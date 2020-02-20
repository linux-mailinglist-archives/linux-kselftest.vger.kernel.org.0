Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D861A1653D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2020 01:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgBTAtH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Feb 2020 19:49:07 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33526 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgBTAs7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Feb 2020 19:48:59 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay11so832915plb.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2020 16:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3w9edU0bQTA/j4i1GZ5kCMLx5L0gk76mGZ2Jl2DPJv8=;
        b=ZeNCpCRGcYvQriOrG7nnRAwG2HLKcfUbnNuky4kQOtRD0bn59Hvqtia7UjS5EL1wtm
         JrkWjvzl+mC614o7v8XfG8+JPEmBrAnWb79QYFg2id7JqxhegfEV05kzAUZv+YfGH2TG
         oohrRRL84DOMAWaN+EK4SCqh6Sx4owhTbcqhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3w9edU0bQTA/j4i1GZ5kCMLx5L0gk76mGZ2Jl2DPJv8=;
        b=pWzGOHYJPAQdSHzhH19DecZsK3eH4zCFOn4EmWnewvY3TLJkUKC7R8vjL/SZWVkfvb
         HqEIkJItxiD+wtWumkZcnw1OTtEQz05oaMNzTNjG0Q3b5AJ3Y61ctcuzoIh838yFFcRz
         o6PC3fAJ0Hs71L8u4/MoARGNOvN6szLJfcfMv1RJr9acS9HvQToLDCuyp7bTFWt6mCVe
         AYT/8GBRPSheDDXrB4D3COPUaOoWLifH0Muv+bDwQuqn3Zei8t9GZMpw+uXEXDRK64/V
         MP3ILGa7nYGu8aUYKohL96UDX3u2B8oq98PzDqLd7cTeCVhrP1iICst+orae0kDIDb/L
         JCkg==
X-Gm-Message-State: APjAAAXqyhAKaOECYGb1A8PWqJOKJhZixQBpy3Dpu46IuQV5fNAuupl2
        9fN1moG6Lw+/q9cEjuWfgoXKSQ==
X-Google-Smtp-Source: APXvYqxvwfYCexceHmLY8+2NVNDKj2k6UoiRx/YzDmwMEI2NjRSexRZ7sLY6QpdZDmP32eZBMJa/tw==
X-Received: by 2002:a17:90a:8d81:: with SMTP id d1mr462100pjo.63.1582159738999;
        Wed, 19 Feb 2020 16:48:58 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 64sm816323pfd.48.2020.02.19.16.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 16:48:58 -0800 (PST)
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
Subject: [PATCH v2 7/7] MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
Date:   Wed, 19 Feb 2020 16:48:25 -0800
Message-Id: <20200220004825.23372-8-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220004825.23372-1-scott.branden@broadcom.com>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
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
index 4beb8dc4c7eb..c55f34f00b85 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3564,6 +3564,13 @@ L:	netdev@vger.kernel.org
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

