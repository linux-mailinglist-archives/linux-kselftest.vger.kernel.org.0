Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2EE1C9F98
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 May 2020 02:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgEHA2F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 May 2020 20:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727092AbgEHA2E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 May 2020 20:28:04 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5924C05BD0A
        for <linux-kselftest@vger.kernel.org>; Thu,  7 May 2020 17:28:04 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s10so2796350plr.1
        for <linux-kselftest@vger.kernel.org>; Thu, 07 May 2020 17:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JPCDjhWyTHrRtN+IrpzH/X2NJ9wHqJH6zPza8eFFddg=;
        b=NWrgZQGnoz5mabDl41Gd4bX6CKcX+TtShgUgAqyBQ4CmcFzkTIh+s4eTOB0O8IQpqt
         SVCmAIes8s9xPwo6zgaPiHYVGOKb7DgRCJ82VqrXHR8tZaT1RHb8beUkwRbwO+/YumY+
         pX4Lb3kGToGG+XOmT86DxbdP3RWi3/OgDiUcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JPCDjhWyTHrRtN+IrpzH/X2NJ9wHqJH6zPza8eFFddg=;
        b=JZ/LfFXzBIuAumGgw87xco1QRoIJJS4f1n4Lj4PDq3lhc3oAWozqqJPqKK7+TCFYe4
         ja3vRPpMRRWiIPoLcT5HxlpxoAY0WuaNece7AkLbR+PDe9IWHVmmkBOzyxHRCiQ/GmGh
         C9j9gwejKrcoFrMBl8lO9Jm9GIDcr1NqNAGe6tkaF3MOhPNW6DzkxAr9FWf5bO23sST4
         Xi2CiWcIPVCYG7A34xDxarp+lhx3Y4lSYjHAYhPfjVfH58OUybKQHP2bb6FS3h2U2vgW
         gVEcGP2KgJuW9xJKf5PoMG8zy+ROp6ujI+m7m5sFphdR+HZZjB2kGhuvucVXGkYx0LEf
         48/g==
X-Gm-Message-State: AGi0PuYbMQMhPPsK1T7fn53r9GMd/oE+EX2WEMHw/RGGanxbgEXjjA24
        a8CB/mxjyuvtkqxV4hb5LF4MBQ==
X-Google-Smtp-Source: APiQypKuwusJV36vLoWnm0n7IvmbrGx5ngG/rLayma/SqYGLRbVTESyX1gWQNGB5aBRDt1tu/M5kRw==
X-Received: by 2002:a17:902:b114:: with SMTP id q20mr14251211plr.120.1588897684116;
        Thu, 07 May 2020 17:28:04 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id gz14sm882677pjb.42.2020.05.07.17.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 17:28:03 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
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
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v5 4/7] firmware: test partial file reads of request_firmware_into_buf
Date:   Thu,  7 May 2020 17:27:36 -0700
Message-Id: <20200508002739.19360-5-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508002739.19360-1-scott.branden@broadcom.com>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add firmware tests for partial file reads of request_firmware_into_buf.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 .../selftests/firmware/fw_filesystem.sh       | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
index fcc281373b4d..38e89ba1b4d3 100755
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
 
+read_firmwares_partial()
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
 
+test_batched_request_firmware_into_buf_partial()
+{
+	echo -n "Batched request_firmware_into_buf_partial() $2 off=$3 size=$4 try #$1: "
+	config_reset
+	config_set_name $TEST_FIRMWARE_INTO_BUF_FILENAME
+	config_set_into_buf
+	config_set_partial
+	config_set_buf_size $4
+	config_set_file_offset $3
+	config_trigger_sync
+	read_firmwares_partial $2 $3 $4
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
+	test_batched_request_firmware_into_buf_partial $i normal 0 10
+done
+
+for i in $(seq 1 5); do
+	test_batched_request_firmware_into_buf_partial $i normal 0 5
+done
+
+for i in $(seq 1 5); do
+	test_batched_request_firmware_into_buf_partial $i normal 1 6
+done
+
+for i in $(seq 1 5); do
+	test_batched_request_firmware_into_buf_partial $i normal 2 10
+done
+
 for i in $(seq 1 5); do
 	test_batched_request_firmware_direct $i normal
 done
-- 
2.17.1

