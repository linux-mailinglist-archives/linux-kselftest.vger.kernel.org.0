Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0821F715F2
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2019 12:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfGWKW6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Jul 2019 06:22:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35831 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfGWKW6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Jul 2019 06:22:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id s1so12896585pgr.2;
        Tue, 23 Jul 2019 03:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/H2B0WFxeIWcM+7UBhbw86h4wEoQFKN7p8J7MWvRdG0=;
        b=uFfEf+OXm+zsoHCS/L0k4e8GIugD78wl1bTN61mUsqnPj9OLJWvoh2FJIBlv1FVnM7
         7WYnUuB7HzDO/O/3aoWr/R4e2RWCdDTN1Pb3MU9IWMLTf7CieeBlkLQt65N72pgq0cIW
         lRi9r0GJa+R2p0YWj9DigweXoOR62rvOptI5K7xHFH+l0XfM8WebXkz2vosJAwPEjAZh
         4kFG4izIUh4bHOQ/luq3Gt9C53tV8Be8lnjJu125xzkxWpzPcvctfovL9IC8kGsmc/R2
         gkft9S9GQLjPaBd0iTLs+uvoFf56JG1LDnG/LStB7E7PPbAMt4OMHfPphXHHXex5A027
         fRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/H2B0WFxeIWcM+7UBhbw86h4wEoQFKN7p8J7MWvRdG0=;
        b=XHX5jlSlou39BnFKok2sDFFepgxBPbHdCOsDgDgi90vA9inZ6iO7rrCNXrN7hHSevq
         Ad8i/tE0FaWC+GJ5BFId0zn+U45DFoerTcIvVQ702JVMw2byUWtub0h729oQ6zrZZIHE
         cHZCxAlNOqoSnpbZhxkLP+m2DRKzF7QuMQMDn+Xgnbt40pdtldoJAMJp/U5tfMKWy93T
         Mj2adLSZwPKGOFeNHYgX5vpHcuRscw6PADge7+3hLYKbcfEob9M+EUNE34Fyyd/zVs5j
         xAzFnIqUD9W7CCd2hrOGMtYF4kYtjK/pXzPqVd6uhLRKFPTy6eJkjwGPrBwY41vP4lZy
         yHmQ==
X-Gm-Message-State: APjAAAWcD6dTnw7RS10xvfQ4GQrkm3YWEbsMDENmnIKJgtPLKoGSLlyT
        AtE15rUv6PBvzv4wOZ+rFXpmotrGdzk=
X-Google-Smtp-Source: APXvYqzeGMV7FlWpVDCe1XEqdS8Czj2+eFlTvaGhxKQYeG/y8MvzvrJAjYaNTTVwWBuB0xgIKHBWfw==
X-Received: by 2002:a63:9c5:: with SMTP id 188mr42549409pgj.2.1563877377445;
        Tue, 23 Jul 2019 03:22:57 -0700 (PDT)
Received: from masabert (150-66-88-81m5.mineo.jp. [150.66.88.81])
        by smtp.gmail.com with ESMTPSA id o14sm42539658pjp.29.2019.07.23.03.22.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 03:22:56 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 7C620201372; Tue, 23 Jul 2019 19:22:53 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        rdunlap@infradead.org, linux-kselftest@vger.kernel.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] selftests: kmod: Fix typo in kmod.sh
Date:   Tue, 23 Jul 2019 19:22:52 +0900
Message-Id: <20190723102252.19931-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.22.0.545.g9c9b961d7eb1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch fixes some spelling typos in kmod.sh

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 tools/testing/selftests/kmod/kmod.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kmod/kmod.sh b/tools/testing/selftests/kmod/kmod.sh
index 0a76314b4414..8b944cf042f6 100755
--- a/tools/testing/selftests/kmod/kmod.sh
+++ b/tools/testing/selftests/kmod/kmod.sh
@@ -28,7 +28,7 @@
 # override by exporting to your environment prior running this script.
 # For instance this script assumes you do not have xfs loaded upon boot.
 # If this is false, export DEFAULT_KMOD_FS="ext4" prior to running this
-# script if the filesyste module you don't have loaded upon bootup
+# script if the filesystem module you don't have loaded upon bootup
 # is ext4 instead. Refer to allow_user_defaults() for a list of user
 # override variables possible.
 #
@@ -263,7 +263,7 @@ config_get_test_result()
 config_reset()
 {
 	if ! echo -n "1" >"$DIR"/reset; then
-		echo "$0: reset shuld have worked" >&2
+		echo "$0: reset should have worked" >&2
 		exit 1
 	fi
 }
@@ -488,7 +488,7 @@ usage()
 	echo Example uses:
 	echo
 	echo "${TEST_NAME}.sh		-- executes all tests"
-	echo "${TEST_NAME}.sh -t 0008	-- Executes test ID 0008 number of times is recomended"
+	echo "${TEST_NAME}.sh -t 0008	-- Executes test ID 0008 number of times is recommended"
 	echo "${TEST_NAME}.sh -w 0008	-- Watch test ID 0008 run until an error occurs"
 	echo "${TEST_NAME}.sh -s 0008	-- Run test ID 0008 once"
 	echo "${TEST_NAME}.sh -c 0008 3	-- Run test ID 0008 three times"
-- 
2.22.0.545.g9c9b961d7eb1

