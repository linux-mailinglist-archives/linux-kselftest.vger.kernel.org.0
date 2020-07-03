Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9561F213F53
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jul 2020 20:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgGCSnb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Jul 2020 14:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgGCSnb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Jul 2020 14:43:31 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4E1C061794
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Jul 2020 11:43:31 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bf7so3601606plb.2
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Jul 2020 11:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=mPYr8lr3dKUW6vXJxZwhdaycJnvZSFeoH2v61Uj7UJE=;
        b=mof6JfwP8HZHKdXOSnM0KGvAbs+aaGUl0ZRYqOy7DKbsrF/bsIBrdbBzKrZbUpKiMm
         JDbUMsX26Or6vL/H/UMsIDo0B7NsONf7q+ErPdZeT38sPBCXXOu/rBZ3n5HxrlqbvG1X
         I+U1/5ChNQAZvIVSMsUoSwM4Z1Cqd1NqwgqV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=mPYr8lr3dKUW6vXJxZwhdaycJnvZSFeoH2v61Uj7UJE=;
        b=F4f8G+xzATjPnEYtbnAiKXyFQWSL+nxJotE2HwDUzVqAqE8OuW21t9olbGnv/wjdfl
         0YVSKcQBMGsHyo3Kp5ZV45MAGFoFXw3U4MoHaqv/uAkoRQmBBt1+8hLMK7FRw10qrwt4
         jAWjKEQ3NzxPqCRmlGgKPPksz79rlZJDlE9UqeI3ws3DgpUJjzySu+s/jJneZnX58s0L
         zAI85AS+7HjzVKHxRXbU/Xm6T3flWzepIcv1d3neYm/uUfI1Z0ruWGUpQKMVz1kct14s
         Ya9q0RUPRteJMGA/su3LIPdKWIpxecSmyduKgquQ1vChMO9JWmRUe4YOMgwcTsGfzqpI
         VUvQ==
X-Gm-Message-State: AOAM532At5PppZT1qjO/sRwxTwNCK/6e3khiBYvFzTJ9V207Xx8p+vK7
        BhBHczxpweEMa4pQy4kNnKW+Fg==
X-Google-Smtp-Source: ABdhPJyq6m8Qlb4zZJvG3Y12jlIiEeZ9iY6G937YP3me7No2ZXYqR9ki1WHJLdnN9BcRmfa7w8PCbw==
X-Received: by 2002:a17:90a:764c:: with SMTP id s12mr25055306pjl.201.1593801810720;
        Fri, 03 Jul 2020 11:43:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j36sm12672948pgj.39.2020.07.03.11.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 11:43:29 -0700 (PDT)
Date:   Fri, 3 Jul 2020 11:43:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dominik Czarnota <dominik.czarnota@trailofbits.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: kmod: Add module address visibility test
Message-ID: <202007031141.6AC2173@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Make sure we don't regress the CAP_SYSLOG behavior of the module address
visibility via /proc/modules nor /sys/module/*/sections/*.

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
I forgot to include this patch in my kallsyms_show_value() f_cred series:
https://lore.kernel.org/lkml/20200702232638.2946421-1-keescook@chromium.org/
Since this depends on the changes, I'd like to include this in the
series with acks/review, etc. :)
---
 tools/testing/selftests/kmod/kmod.sh | 36 ++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/kmod/kmod.sh b/tools/testing/selftests/kmod/kmod.sh
index 3702dbcc90a7..c82aa77958e5 100755
--- a/tools/testing/selftests/kmod/kmod.sh
+++ b/tools/testing/selftests/kmod/kmod.sh
@@ -63,6 +63,8 @@ ALL_TESTS="$ALL_TESTS 0008:150:1"
 ALL_TESTS="$ALL_TESTS 0009:150:1"
 ALL_TESTS="$ALL_TESTS 0010:1:1"
 ALL_TESTS="$ALL_TESTS 0011:1:1"
+ALL_TESTS="$ALL_TESTS 0012:1:1"
+ALL_TESTS="$ALL_TESTS 0013:1:1"
 
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
@@ -470,6 +472,38 @@ kmod_test_0011()
 	echo "$MODPROBE" > /proc/sys/kernel/modprobe
 }
 
+kmod_check_visibility()
+{
+	local name="$1"
+	local cmd="$2"
+
+	modprobe $DEFAULT_KMOD_DRIVER
+
+	local priv=$(eval $cmd)
+	local unpriv=$(capsh --drop=CAP_SYSLOG -- -c "$cmd")
+
+	if [ "$priv" = "$unpriv" ] || \
+	   [ "${priv:0:3}" = "0x0" ] || \
+	   [ "${unpriv:0:3}" != "0x0" ] ; then
+		echo "${FUNCNAME[0]}: FAIL, $name visible to unpriv: '$priv' vs '$unpriv'" >&2
+		exit 1
+	else
+		echo "${FUNCNAME[0]}: OK!"
+	fi
+}
+
+kmod_test_0012()
+{
+	kmod_check_visibility /proc/modules \
+		"grep '^${DEFAULT_KMOD_DRIVER}\b' /proc/modules | awk '{print \$NF}'"
+}
+
+kmod_test_0013()
+{
+	kmod_check_visibility '/sys/module/*/sections/*' \
+		"cat /sys/module/${DEFAULT_KMOD_DRIVER}/sections/.*text | head -n1"
+}
+
 list_tests()
 {
 	echo "Test ID list:"
@@ -489,6 +523,8 @@ list_tests()
 	echo "0009 x $(get_test_count 0009) - multithreaded - push kmod_concurrent over max_modprobes for get_fs_type()"
 	echo "0010 x $(get_test_count 0010) - test nonexistent modprobe path"
 	echo "0011 x $(get_test_count 0011) - test completely disabling module autoloading"
+	echo "0012 x $(get_test_count 0012) - test /proc/modules address visibility under CAP_SYSLOG"
+	echo "0013 x $(get_test_count 0013) - test /sys/module/*/sections/* visibility under CAP_SYSLOG"
 }
 
 usage()
-- 
2.25.1


-- 
Kees Cook
