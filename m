Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD541F0531
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jun 2020 07:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgFFFHS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 6 Jun 2020 01:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbgFFFHR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 6 Jun 2020 01:07:17 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B7EC08C5C5
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Jun 2020 22:07:17 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b5so5926868pfp.9
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Jun 2020 22:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nPZxvHwBEufxYBdudZlyF4qOYy0qjWWsAs0E7hFIitY=;
        b=LKRXcXAxk/S4d1ojJso185sZY4EDd7oB/TMjk4qHxfa7tmHK7uGzpexJtAQ0bVeTe4
         gxBGgLgZRHQuGtimtkN1dVO21gb6VLxc7FipvFzOng1pcG9UzU9p6XcUDSBuN+VOdGTa
         UMazTNd+n15aosaq7Nu8SUmiRSlNUnFAGE6lU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nPZxvHwBEufxYBdudZlyF4qOYy0qjWWsAs0E7hFIitY=;
        b=QnzbJoyX/fztQxNIY9Gg3uky86IJgMEiOhlSTEoALCXkOyB+9f2HJQrJz6dedKZOaR
         9BsKqrBN6/YESACh4MM5NTYJijXDfwiJ70XiAz6WS7e8w9FDlflVsmLtfwSTyiZpuW0G
         ba9/mXNVmTgd0o6nSaPg8XHRwxFQ/n7MmKBIbRvCE4v1JAf4SGRzip2IbYbVfBw+Z9tC
         d6tBMiDXuqv7NSnJsO0di2EHQjSyNn4ikb87T1lt8+d3tICe5D6ni7Ef/j3rR1nUAO3S
         OeUAKaFqct9Rl5zrMR+dsAHnJtY3mFf8RF7sOM/CP8t4k7eZ/gEOgJVexQpZ+V+SoUxq
         qXkA==
X-Gm-Message-State: AOAM530N70m1YV5A4rIsBOGPMyRPRcTFOp/n/kIdfIQyKkE4K7PHAOLk
        NK47kYWgen+NfmHGKYvsj00xTA==
X-Google-Smtp-Source: ABdhPJxeVT9a/KR76jybKQryE79B0JYUNZw1/TXZXF/G9QFvxCuTwEjn/4pcIn1mqf1SwS4HR8Nf4g==
X-Received: by 2002:a63:c44b:: with SMTP id m11mr11796192pgg.404.1591420036309;
        Fri, 05 Jun 2020 22:07:16 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v8sm1057636pfn.217.2020.06.05.22.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 22:07:15 -0700 (PDT)
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
Subject: [PATCH v7 7/8] MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
Date:   Fri,  5 Jun 2020 22:04:57 -0700
Message-Id: <20200606050458.17281-8-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200606050458.17281-1-scott.branden@broadcom.com>
References: <20200606050458.17281-1-scott.branden@broadcom.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add maintainer entry for new Broadcom VK Driver

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 411cd97bb485..ced084c526df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3656,6 +3656,13 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/broadcom/tg3.*
 
+BROADCOM VK DRIVER
+M:	Scott Branden <scott.branden@broadcom.com>
+L:	bcm-kernel-feedback-list@broadcom.com
+S:	Supported
+F:	drivers/misc/bcm-vk/
+F:	include/uapi/linux/misc/bcm_vk.h
+
 BROCADE BFA FC SCSI DRIVER
 M:	Anil Gurumurthy <anil.gurumurthy@qlogic.com>
 M:	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
-- 
2.17.1

