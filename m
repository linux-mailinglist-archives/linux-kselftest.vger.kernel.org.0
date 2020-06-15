Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57DC1FA08F
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jun 2020 21:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbgFOTmd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Jun 2020 15:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730725AbgFOTmS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Jun 2020 15:42:18 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65908C08C5CB
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jun 2020 12:42:16 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id k1so7120957pls.2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jun 2020 12:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sCHL24pJFJSFoASanMhktjUvoQlUfrXyegYhzckyoiE=;
        b=INkNszYZmY2wifOY2yJAIkXAChxTSePBWyOoj3tvJYRWfzjz0IgEM3o3cn8P1ksFmx
         kb6GtYmizImAg60vsTx3PS8iS2T6XGxfB0EbenzJoUUHJutkblYTO2bxLU5FnMDwZNJo
         JCmcIxNy4/LBVcnMwL5CsOSeX2VcquT7Y6Emw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sCHL24pJFJSFoASanMhktjUvoQlUfrXyegYhzckyoiE=;
        b=oFalq+BZBiwTfk2pg9TCcV8u1O9srazGTyIca1mApET3ND+wG8rVbeWYjy2Jl/ZPlQ
         a6/p32U6chKqHQE4+QMVoci6RlpHB/eMo0Pxf4NWmDaZd/ac5r72FAs7zYwbGR75404s
         IQNimatDJ4X/jjEh89Vedo9Zr3qqY/JSePBMiKrwm3nNpF2d8v4AA0iHhErfxZ2DqpSc
         /PjaZFOJAkIRAedSwGbKfOgmislMk76LMbApRWg5+XO7DZ1zphmYvT70yqlpzMBM/V4t
         zT/5PMSemrU6Sl2tvFdhLOjWhhwkb0SnUHTl+v7uS5PsyR630Vuwc1ECiN50+oG+3UEH
         dHGQ==
X-Gm-Message-State: AOAM532UkUCNTFSxG5bjClExs2KhiGneiiw8ROACs4rB0gfd7PDDtpor
        3LAKA/yr+keQYZ25kYYzbRWcOA==
X-Google-Smtp-Source: ABdhPJyETP8Ql6VRKP/AE8oPj2cFuyHxiNTpgJzwUePlExmYGh8vR9y/8m3suyFQihVgaBg1YKVx5g==
X-Received: by 2002:a17:90a:db91:: with SMTP id h17mr857845pjv.6.1592250135228;
        Mon, 15 Jun 2020 12:42:15 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id gq8sm293663pjb.14.2020.06.15.12.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 12:42:14 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v9 4/8] firmware: test partial file reads of request_partial_firmware_into_buf
Date:   Mon, 15 Jun 2020 12:41:47 -0700
Message-Id: <20200615194151.7011-5-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200615194151.7011-1-scott.branden@broadcom.com>
References: <20200615194151.7011-1-scott.branden@broadcom.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add firmware tests for partial file reads of
request_partial_firmware_into_buf.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 .../selftests/firmware/fw_filesystem.sh       | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
index fcc281373b4d..afc2e469ac06 100755
--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -149,6 +149,26 @@ config_unset_into_buf()
 	echo 0 >  $DIR/config_into_buf
 }
 
+config_set_buf_size()
+{
+	echo $1 >  $DIR/config_buf_size
+}
+
+config_set_file_offset()
+{
+	echo $1 >  $DIR/config_file_offset
+}
+
+config_set_partial()
+{
+	echo 1 >  $DIR/config_partial
+}
+
+config_unset_partial()
+{
+	echo 0 >  $DIR/config_partial
+}
+
 config_set_sync_direct()
 {
 	echo 1 >  $DIR/config_sync_direct
@@ -207,6 +227,35 @@ read_firmwares()
 	done
 }
 
+read_partial_firmwares()
+{
+	if [ "$(cat $DIR/config_into_buf)" == "1" ]; then
+		fwfile="${FW_INTO_BUF}"
+	else
+		fwfile="${FW}"
+	fi
+
+	if [ "$1" = "xzonly" ]; then
+		fwfile="${fwfile}-orig"
+	fi
+
+	# Strip fwfile down to match partial offset and length
+	partial_data="$(cat $fwfile)"
+	partial_data="${partial_data:$2:$3}"
+
+	for i in $(seq 0 3); do
+		config_set_read_fw_idx $i
+
+		read_firmware="$(cat $DIR/read_firmware)"
+
+		# Verify the contents are what we expect.
+		if [ $read_firmware != $partial_data ]; then
+			echo "request #$i: partial firmware was not loaded" >&2
+			exit 1
+		fi
+	done
+}
+
 read_firmwares_expect_nofile()
 {
 	for i in $(seq 0 3); do
@@ -319,6 +368,21 @@ test_batched_request_firmware_into_buf()
 	echo "OK"
 }
 
+test_batched_request_partial_firmware_into_buf()
+{
+	echo -n "Batched request_partial_firmware_into_buf() $2 off=$3 size=$4 try #$1: "
+	config_reset
+	config_set_name $TEST_FIRMWARE_INTO_BUF_FILENAME
+	config_set_into_buf
+	config_set_partial
+	config_set_buf_size $4
+	config_set_file_offset $3
+	config_trigger_sync
+	read_partial_firmwares $2 $3 $4
+	release_all_firmware
+	echo "OK"
+}
+
 test_batched_request_firmware_direct()
 {
 	echo -n "Batched request_firmware_direct() $2 try #$1: "
@@ -371,6 +435,22 @@ for i in $(seq 1 5); do
 	test_batched_request_firmware_into_buf $i normal
 done
 
+for i in $(seq 1 5); do
+	test_batched_request_partial_firmware_into_buf $i normal 0 10
+done
+
+for i in $(seq 1 5); do
+	test_batched_request_partial_firmware_into_buf $i normal 0 5
+done
+
+for i in $(seq 1 5); do
+	test_batched_request_partial_firmware_into_buf $i normal 1 6
+done
+
+for i in $(seq 1 5); do
+	test_batched_request_partial_firmware_into_buf $i normal 2 10
+done
+
 for i in $(seq 1 5); do
 	test_batched_request_firmware_direct $i normal
 done
-- 
2.17.1

