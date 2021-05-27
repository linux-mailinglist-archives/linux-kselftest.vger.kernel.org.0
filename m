Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302D839256D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 May 2021 05:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhE0D1V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 23:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbhE0D1P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 23:27:15 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A542C06138C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 20:25:42 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 29so2638439pgu.11
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 20:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xSrDOJL7AvET8ApETnA9Y+QljBtfU/9EtYO3Hi8VAeQ=;
        b=YCb4gx6Yo4Mls6/Kfu007YuHtC7j7O3MZZVRjPBY2YNQiLUfJ43aA7MnUPI4glqmco
         6qttBM0O0w+DqQ99T3y7x7EYo1qZSZ7ZrNkHPobPHh70MQdFym6/O0i/Q06GEg8d2sdV
         oJ+FACHpAIZyGJchDcE6Xn3hkhFdvSCMzsfuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xSrDOJL7AvET8ApETnA9Y+QljBtfU/9EtYO3Hi8VAeQ=;
        b=K+LovarPLOB39a6IoQkcFuEg4oYavXsUYzmSPJQ/HpM3hncrEF7o7eHWpkretJN3yg
         J7OnP8XMqnBhwl4IcXGtiT/nbM4Awp64oaz0IJ4s/OzluzzE98GM35a0qr3tyIL2o8kr
         DKPXXd7GT4OOpm57X6XNRqzGD2+UEeEkJJyihG9n4RZx+owNmaBb3EG7wKW7s9AmRLQz
         EUW9sOegU9bIBjFlacSEHr/rrqjRHmfRWTYyseiPI1CQi9vEpAWnuybx/kzlcwtMDwCt
         t1Eb8appR7MpCWHs9TpS9YqSHA9alHo4J3IrybkhfwOW4A9MV90/AVTAdPj/9t+Chb8T
         s8aw==
X-Gm-Message-State: AOAM530QiOE2edvuD6O0UBg2B53DL3Detmes69X6GrTDa6WntcyIx5Pw
        Wb4YxLAWmmCSOHHU5Ze/Ke90Lg==
X-Google-Smtp-Source: ABdhPJyP8Xdk2BJWUxLa9OrBmf9ZwPxqmfSxTK6lUz4H6KRnvicak7dNZRPWTuDr+cJ05BzTRz+ytQ==
X-Received: by 2002:a63:fc20:: with SMTP id j32mr1745278pgi.8.1622085941890;
        Wed, 26 May 2021 20:25:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 25sm506436pfh.39.2021.05.26.20.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 20:25:41 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-kselftest@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH][RESEND] selftests: splice: Adjust for handler fallback removal
Date:   Wed, 26 May 2021 20:25:37 -0700
Message-Id: <20210527032537.3730425-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=603487f9de099887a00e11755360a455050dbeec; i=ZtJYRYTJ2d/M8JopmSDlVxkQZozgLi/kyiL216XRmnk=; m=4v8n4XvSJkPFvRCNgkJS0rmZjjTiHH8uTeE8Z565PA8=; p=vTLCwvwX8DObrgvz6sQbgpX2sggrItay1Zh30+xFtUY=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmCvETAACgkQiXL039xtwCYOERAAka0 4buOqk/xIbgX4Za7FaClAnjZmYu9Nzif1O2rFcd8K/hXjRknck21ic45xO/8miq8y6mGnuxUm+4v7 Oews0U7MAk2kpOwJDDxttePIcpiIUWNd1o4jX0Nsqqua+1pSHQaEZ52lecPUNL88o123r0r12ALxd wDcUJx1Cz7Bk5pSo4L/JCV/pBsQluBtuiVJYGMLAAmeC+dw8C0SYpIs/rjVSFiHTkEHaQPPTMUML8 DSoPyTLbzF0s4o+LgWfkLjWd4a6G/POTYfeMVQOYw70G9b+93NSYs0lGCECG/XeyXpsvytxmJ8idm dBh6oEidGuE7+S5Ne1cjM5LwYpZkDTaB6S59X0QVX73uG573jagpwxbfAnwBYE+jUpQkPNBvptpJP oYIe9dG8vRiXdC9+YzTWjLTVe+xj31y3hPKZRfuGW85MgyA83SJyq+xhNS66cRMBRBh2TA0fws5eM RvzECHpdHmShYOUDKmMWxVlYKjxej1P/LuoGdPsMqrdCzhuTET2q93ymQA61/AIwdw8N7N/qYe/D2 RigEuMBslTZ4bRA5T2BrPK6dcX7SQg47eR8Pj4ASbdEs665tDABu+n3p1d7eDWEPq0UcatbO7Etum V72P87XhFCcoEq5PlqE4YGd7G/unlwnabUlBTghi3q/Uwuwn1rdiNNNTwMHY9McA=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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
---
Resend of https://lore.kernel.org/linux-kselftest/20201005204517.2652730-1-keescook@chromium.org/
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
2.25.1

