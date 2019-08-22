Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 231DF99FF4
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2019 21:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391930AbfHVTZ1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Aug 2019 15:25:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32834 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404384AbfHVTZZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Aug 2019 15:25:25 -0400
Received: by mail-pl1-f193.google.com with SMTP id go14so4012562plb.0
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Aug 2019 12:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cvNFosYfslBR/6BVIMWexVcAL5TsK7108rSnZMZd4X4=;
        b=LqfcfkmpyJUSc2aXfZWs3W0xMRRcheys90Q7EO54mjpiPWnL9sBnbv8XMLomSSx8O9
         9ktpA4rZhdplpQ4ro5QS7HE4S//9qBDE3luw1BnSeewiMlF5fftt+LT15Sit1z7GBMmo
         yaCcSKkt+tggxjuspHuFaMogtb3SCbr2pE7Uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cvNFosYfslBR/6BVIMWexVcAL5TsK7108rSnZMZd4X4=;
        b=ZvVlLRlwaUkNmswIjeeXSLhfdz/v76+lpNGmDUAGKkKBzGNy602UF2kVid+iDNllI7
         cDfDyp2vn38SZWoe7lBJ8LU0HtD1O3x45TIPcTWed+6RgkW85Y4o6e79iJzcG26UulIX
         pGPX6rR0WZ8bFqeuQiis/XNB2qA4Kybr9PIHuM39OzcSi/nualHCGCNI8T7VKiMsNgzu
         NuiCQCVP5LQmQXwp3sqX2l1kOvdi4PBBMsXCNZzfwJpPge2acKbvqt1BFWrmF2zsvhyB
         2FyMDWkaTVHaDyxAJ6lNdcNEFjTPdIz8UCyYDLpT3VThuUDz09hHHXUz6+L8vUjiaM+x
         W/PQ==
X-Gm-Message-State: APjAAAWv9K4u6/jLjWAoWfdXzUsc+oG3YN7ngz9F6FgSjwfO7E4O7qwB
        VyJp1/u5rv/sd1GNfwCT5FQ7gw==
X-Google-Smtp-Source: APXvYqxTvONL03yjcaj7MsrmAUaBSFUgWDAcWsFUDtXLuMO0GvKeUtS496WfXIlpijUGpqlrHgo0FQ==
X-Received: by 2002:a17:902:ba81:: with SMTP id k1mr441791pls.213.1566501924580;
        Thu, 22 Aug 2019 12:25:24 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c12sm198018pfc.22.2019.08.22.12.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:25:24 -0700 (PDT)
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
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH 7/7] MAINTAINERS: bcm-vk: Add maintainer for Broadcom Valkyrie Driver
Date:   Thu, 22 Aug 2019 12:24:51 -0700
Message-Id: <20190822192451.5983-8-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190822192451.5983-1-scott.branden@broadcom.com>
References: <20190822192451.5983-1-scott.branden@broadcom.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add maintainer entry for new Broadcom Valkyrie Driver

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 08176d64eed5..6eb2e3accf1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3456,6 +3456,13 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/broadcom/tg3.*
 
+BROADCOM VALKYRIE DRIVER
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

