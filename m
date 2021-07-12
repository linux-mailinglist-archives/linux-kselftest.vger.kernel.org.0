Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD663C4F80
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jul 2021 12:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241881AbhGLH0H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jul 2021 03:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:32988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343855AbhGLHYW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jul 2021 03:24:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D30D661404;
        Mon, 12 Jul 2021 07:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626074477;
        bh=DUgcB785XMcpeEq5Yt6WrbqQKAkHFMhqCwGsYbSv/5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QpNaDoHxGVSTdPcnP1QZ9Xgj/BG/oGLNAwW1i5ID9Eg5u4RcpRVI/9r3zr0ldoJe9
         6pGcOxDzaXACdV79bUqSw4iZsVmdmO75MzVRIuSRWKc1XhfYAqET8zihddcP51SepG
         Zo9vbDmL5ZOVpHFIsc/ehxpAKJep4wN/8Lw9zoWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <rong.a.chen@intel.com>,
        Christoph Hellwig <hch@lst.de>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.12 594/700] selftests: splice: Adjust for handler fallback removal
Date:   Mon, 12 Jul 2021 08:11:17 +0200
Message-Id: <20210712061039.156072267@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210712060924.797321836@linuxfoundation.org>
References: <20210712060924.797321836@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 6daf076b717d189f4d02a303d45edd5732341ec1 ]

Some pseudo-filesystems do not have an explicit splice fops since adding
commit 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops"),
and now will reject attempts to use splice() in those filesystem paths.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Link: https://lore.kernel.org/lkml/202009181443.C2179FB@keescook/
Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/splice/short_splice_read.sh     | 119 ++++++++++++++----
 1 file changed, 98 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/splice/short_splice_read.sh b/tools/testing/selftests/splice/short_splice_read.sh
index 7810d3589d9a..22b6c8910b18 100755
--- a/tools/testing/selftests/splice/short_splice_read.sh
+++ b/tools/testing/selftests/splice/short_splice_read.sh
@@ -1,21 +1,87 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
+#
+# Test for mishandling of splice() on pseudofilesystems, which should catch
+# bugs like 11990a5bd7e5 ("module: Correctly truncate sysfs sections output")
+#
+# Since splice fallback was removed as part of the set_fs() rework, many of these
+# tests expect to fail now. See https://lore.kernel.org/lkml/202009181443.C2179FB@keescook/
 set -e
 
+DIR=$(dirname "$0")
+
 ret=0
 
+expect_success()
+{
+	title="$1"
+	shift
+
+	echo "" >&2
+	echo "$title ..." >&2
+
+	set +e
+	"$@"
+	rc=$?
+	set -e
+
+	case "$rc" in
+	0)
+		echo "ok: $title succeeded" >&2
+		;;
+	1)
+		echo "FAIL: $title should work" >&2
+		ret=$(( ret + 1 ))
+		;;
+	*)
+		echo "FAIL: something else went wrong" >&2
+		ret=$(( ret + 1 ))
+		;;
+	esac
+}
+
+expect_failure()
+{
+	title="$1"
+	shift
+
+	echo "" >&2
+	echo "$title ..." >&2
+
+	set +e
+	"$@"
+	rc=$?
+	set -e
+
+	case "$rc" in
+	0)
+		echo "FAIL: $title unexpectedly worked" >&2
+		ret=$(( ret + 1 ))
+		;;
+	1)
+		echo "ok: $title correctly failed" >&2
+		;;
+	*)
+		echo "FAIL: something else went wrong" >&2
+		ret=$(( ret + 1 ))
+		;;
+	esac
+}
+
 do_splice()
 {
 	filename="$1"
 	bytes="$2"
 	expected="$3"
+	report="$4"
 
-	out=$(./splice_read "$filename" "$bytes" | cat)
+	out=$("$DIR"/splice_read "$filename" "$bytes" | cat)
 	if [ "$out" = "$expected" ] ; then
-		echo "ok: $filename $bytes"
+		echo "      matched $report" >&2
+		return 0
 	else
-		echo "FAIL: $filename $bytes"
-		ret=1
+		echo "      no match: '$out' vs $report" >&2
+		return 1
 	fi
 }
 
@@ -23,34 +89,45 @@ test_splice()
 {
 	filename="$1"
 
+	echo "  checking $filename ..." >&2
+
 	full=$(cat "$filename")
+	rc=$?
+	if [ $rc -ne 0 ] ; then
+		return 2
+	fi
+
 	two=$(echo "$full" | grep -m1 . | cut -c-2)
 
 	# Make sure full splice has the same contents as a standard read.
-	do_splice "$filename" 4096 "$full"
+	echo "    splicing 4096 bytes ..." >&2
+	if ! do_splice "$filename" 4096 "$full" "full read" ; then
+		return 1
+	fi
 
 	# Make sure a partial splice see the first two characters.
-	do_splice "$filename" 2 "$two"
+	echo "    splicing 2 bytes ..." >&2
+	if ! do_splice "$filename" 2 "$two" "'$two'" ; then
+		return 1
+	fi
+
+	return 0
 }
 
-# proc_single_open(), seq_read()
-test_splice /proc/$$/limits
-# special open, seq_read()
-test_splice /proc/$$/comm
+### /proc/$pid/ has no splice interface; these should all fail.
+expect_failure "proc_single_open(), seq_read() splice" test_splice /proc/$$/limits
+expect_failure "special open(), seq_read() splice" test_splice /proc/$$/comm
 
-# proc_handler, proc_dointvec_minmax
-test_splice /proc/sys/fs/nr_open
-# proc_handler, proc_dostring
-test_splice /proc/sys/kernel/modprobe
-# proc_handler, special read
-test_splice /proc/sys/kernel/version
+### /proc/sys/ has a splice interface; these should all succeed.
+expect_success "proc_handler: proc_dointvec_minmax() splice" test_splice /proc/sys/fs/nr_open
+expect_success "proc_handler: proc_dostring() splice" test_splice /proc/sys/kernel/modprobe
+expect_success "proc_handler: special read splice" test_splice /proc/sys/kernel/version
 
+### /sys/ has no splice interface; these should all fail.
 if ! [ -d /sys/module/test_module/sections ] ; then
-	modprobe test_module
+	expect_success "test_module kernel module load" modprobe test_module
 fi
-# kernfs, attr
-test_splice /sys/module/test_module/coresize
-# kernfs, binattr
-test_splice /sys/module/test_module/sections/.init.text
+expect_failure "kernfs attr splice" test_splice /sys/module/test_module/coresize
+expect_failure "kernfs binattr splice" test_splice /sys/module/test_module/sections/.init.text
 
 exit $ret
-- 
2.30.2



