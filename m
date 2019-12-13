Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 211FF11DBE1
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2019 02:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731666AbfLMB4K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Dec 2019 20:56:10 -0500
Received: from mail-io1-f44.google.com ([209.85.166.44]:38913 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731357AbfLMB4J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Dec 2019 20:56:09 -0500
Received: by mail-io1-f44.google.com with SMTP id c16so773001ioh.6
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Dec 2019 17:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4jtyJn+jd2kldixpZrOSg8TBt8xCd0UBOBYu2Jdo4r4=;
        b=Asyyq5D68W25BKzSzKQUkjSn2xDNWbOl7NxBXvOaVRGASH+aZlLweLJ81c2dVUbVuX
         691irB/y5NxuVTJq1DFPC9N1qM0tunQjtKj3fF2PU7f8C21LLOa1WNPwqrpogyrCuzO0
         UjghPv2S5Hig88Zee8w9gDaniimKxyK2/YkQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4jtyJn+jd2kldixpZrOSg8TBt8xCd0UBOBYu2Jdo4r4=;
        b=FGPMtMx/lY71Q7Hztfo7f4dodDdBUnnGZRPov8lndkBTVatk4J67zvnY0Vj1JANdup
         oSuBGVDWx1MPL8YU45u9u87BGnqmX6KALZ9ednwfRuaFPcMlzvlU8iCgExzHS4LJ+w0w
         415OlBf3xXhsdQZHf8Eg1TMaB0FDQ6tYF6enNzT1msr2mv6SUk37WoasoAAaujmPoYfa
         ZIFMpoZa7Xe+yT96qA7nz/ubNlvuejkfBmP0bNjB6VLoQ7QzkrGVwsM5KgFOFBG3CZ77
         d3ZSXEs0Cq2/J//NOnlNaA4B46k8bMSBchdYeqqUm5wCPUq1MKkBVIyr2wQU8FPP1x5g
         FFEA==
X-Gm-Message-State: APjAAAVevIxlwo9Ouu+labMU4QRuPWjFSefCWhVp0x2/tzyhjNr/GyCr
        gWTiSz7nzfHr9nZpJBaDgNkDMg==
X-Google-Smtp-Source: APXvYqxBY8QCMBIOmrwYTxCxzMazQJTC3wK+Qsu5YVdlers+N/MkKK1lKh9v4m46m285ky2Sp8Jlqg==
X-Received: by 2002:a5d:9d4a:: with SMTP id k10mr5969938iok.134.1576202168931;
        Thu, 12 Dec 2019 17:56:08 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y11sm1684335iot.19.2019.12.12.17.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 17:56:08 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, gregkh@linuxfoundation.org, mcgrof@kernel.org,
        scott.branden@broadcom.com, tiwai@suse.de
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: firmware: Fix it to do root uid check and skip
Date:   Thu, 12 Dec 2019 18:56:06 -0700
Message-Id: <20191213015606.23058-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

firmware attempts to load test modules that require root access
and fail. Fix it to check for root uid and exit with skip code
instead.

Before this fix:

selftests: firmware: fw_run_tests.sh
modprobe: ERROR: could not insert 'test_firmware': Operation not permitted
You must have the following enabled in your kernel:
CONFIG_TEST_FIRMWARE=y
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
not ok 1 selftests: firmware: fw_run_tests.sh # SKIP

With this fix:

selftests: firmware: fw_run_tests.sh
skip all tests: must be run as root
not ok 1 selftests: firmware: fw_run_tests.sh # SKIP

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/firmware/fw_lib.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
index b879305a766d..5b8c0fedee76 100755
--- a/tools/testing/selftests/firmware/fw_lib.sh
+++ b/tools/testing/selftests/firmware/fw_lib.sh
@@ -34,6 +34,12 @@ test_modprobe()
 
 check_mods()
 {
+	local uid=$(id -u)
+	if [ $uid -ne 0 ]; then
+		echo "skip all tests: must be run as root" >&2
+		exit $ksft_skip
+	fi
+
 	trap "test_modprobe" EXIT
 	if [ ! -d $DIR ]; then
 		modprobe test_firmware
-- 
2.20.1

