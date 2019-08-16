Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28B9C8F7DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2019 02:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfHPAKC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Aug 2019 20:10:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38768 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfHPAKB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Aug 2019 20:10:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id o70so2157103pfg.5
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Aug 2019 17:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XVcmO8RzpRC/BFyAhdGsg6GtacmmL8vW5DzIGcj2y00=;
        b=UyJlZup3Cv7yWgUuLvmQAnNfqDuhuM74GoMYvrExOhXCciNnhsHNjBZs2PEruaFfjG
         Jcui7w1fA8S36tDl5u6QHeKZF53YBkNnI8NRPTT9EsiCecxj3lysIb5IqKM09mKOGb1+
         UDcxcyEFboiIxHynVYAC8K3EeVb9qsmZqVhaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XVcmO8RzpRC/BFyAhdGsg6GtacmmL8vW5DzIGcj2y00=;
        b=m7O7zIwYan3GD6pppy5LCvQGTsbxx3zCxkc5dNNXouJt2gnVLtI9yBcrx865t6JLlc
         hTv/kpZ437cRpWIchTbXE4J0xQMikvMPvi8M/5Sw/058h6Z/Ntdqft/b9Ogdj6R7NhFv
         0MqtzSn9F4traJaoqytypQLKAq0IuLJ1ep+ewIq9luac/8aWK6mN7U+Ua05Y3g5FHpp+
         bdpC5+Jb119R96Tmz7GTCW4i1rgg6r0pjX3mn/gPO0ZsEMfqAgWqEX9XYuk7g/amnn6a
         SWKQKcWd4E+G6znkAv4WqahnkKz6Hb+PnVN6k8cJ265bSNkbbMna2rAwoUswXJGRqgzZ
         LQ/g==
X-Gm-Message-State: APjAAAUOSMFqVbH6cdZCFczYa0oXyJq50qTPcfOaKS+im+Xxyw8j1ZGV
        K4ookebAM7vzEgNFr5di3jmk4g==
X-Google-Smtp-Source: APXvYqwAprqv8uGMD++iNatIdUckz9u8bL8pKGeHjyJM0EavcZ5h0ap9TeggfP0kBtQm1ZfTd3GqbQ==
X-Received: by 2002:a17:90a:b947:: with SMTP id f7mr4557928pjw.63.1565914200957;
        Thu, 15 Aug 2019 17:10:00 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id g2sm4056916pfi.26.2019.08.15.17.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 17:10:00 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org
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
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH 3/3] firmware: add mutex fw_lock_fallback for race condition
Date:   Thu, 15 Aug 2019 17:09:45 -0700
Message-Id: <20190816000945.29810-4-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190816000945.29810-1-scott.branden@broadcom.com>
References: <20190816000945.29810-1-scott.branden@broadcom.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A race condition exists between _request_firmware_prepare checking
if firmware is assigned and firmware_fallback_sysfs creating a sysfs
entry (kernel trace below).  To avoid such condition add a mutex
fw_lock_fallback to protect against such condition.

misc test_firmware: Falling back to sysfs fallback for: nope-test-firmware.bin
sysfs: cannot create duplicate filename '/devices/virtual/misc/test_firmware/nope-test-firmware.bin'
CPU: 4 PID: 2059 Comm: test_firmware-3 Not tainted 5.3.0-rc4 #1
Hardware name: Dell Inc. OptiPlex 7010/0KRC95, BIOS A13 03/25/2013
Call Trace:
 dump_stack+0x67/0x90
 sysfs_warn_dup.cold+0x17/0x24
 sysfs_create_dir_ns+0xb3/0xd0
 kobject_add_internal+0xa6/0x2a0
 kobject_add+0x7e/0xb0
 ? _cond_resched+0x15/0x30
 device_add+0x121/0x670
 firmware_fallback_sysfs+0x15c/0x3c9
 _request_firmware+0x432/0x5a0
 ? devres_find+0x63/0xc0
 request_firmware_into_buf+0x63/0x80
 test_fw_run_batch_request+0x96/0xe0
 kthread+0xfb/0x130
 ? reset_store+0x30/0x30
 ? kthread_park+0x80/0x80
 ret_from_fork+0x3a/0x50
kobject_add_internal failed for nope-test-firmware.bin with -EEXIST, don't try to register things with the same name in the same directory.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/base/firmware_loader/main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index bf44c79beae9..ce9896e3b782 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -88,6 +88,7 @@ static inline struct fw_priv *to_fw_priv(struct kref *ref)
 /* fw_lock could be moved to 'struct fw_sysfs' but since it is just
  * guarding for corner cases a global lock should be OK */
 DEFINE_MUTEX(fw_lock);
+DEFINE_MUTEX(fw_lock_fallback);
 
 static struct firmware_cache fw_cache;
 
@@ -758,6 +759,17 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 	if (!firmware_p)
 		return -EINVAL;
 
+	/*
+	 * There is a race condition between _request_firmware_prepare checking
+	 * if firmware is assigned and firmware_fallback_sysfs creating sysfs
+	 * entries with duplicate names.
+	 * Yet, with this lock the firmware_test locks up with cache enabled
+	 * and no event used during firmware test.
+	 * This points to some very racy code I don't know how to entirely fix.
+	 */
+	if (opt_flags & FW_OPT_NOCACHE)
+		mutex_lock(&fw_lock_fallback);
+
 	if (!name || name[0] == '\0') {
 		ret = -EINVAL;
 		goto out;
@@ -791,6 +803,9 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 		fw = NULL;
 	}
 
+	if (opt_flags & FW_OPT_NOCACHE)
+		mutex_unlock(&fw_lock_fallback);
+
 	*firmware_p = fw;
 	return ret;
 }
-- 
2.17.1

