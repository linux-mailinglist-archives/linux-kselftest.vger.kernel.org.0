Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2A701982FC
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Mar 2020 20:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgC3SHR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Mar 2020 14:07:17 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:42365 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgC3SHQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Mar 2020 14:07:16 -0400
Received: by mail-il1-f195.google.com with SMTP id f16so16751279ilj.9
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Mar 2020 11:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ppT7F7qNchzvH1R+rW214qqRYLN3C8FBeBsX6qASJ8=;
        b=E7SHscRpJDreN5AQuBS8iLe+I2YBFQtfo9LtAMmQ4nJ1uroPl1RuQzX4PPH8ZhBars
         SMBngiLizr+pyJpE7G9838ffAHtRTGXBDQkS6+ouG1Rxd1EdgQT6cylC8sJBhIORBpBi
         XT/fO3QFGfclRkZ4WJFOEX7sPfuvE3hLzgm60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ppT7F7qNchzvH1R+rW214qqRYLN3C8FBeBsX6qASJ8=;
        b=M/a+eBVac8BpQgbfTpSQL7ZfYAgb+iitLs3CYTu8wed8J5vndHqVPoGzKxGq2aa4NN
         RcoeGE+TW/1OqQcRwTFfy6t5T+vVwi/0xa8ngC6P4xK+eJhvSbnIPCKXgF+fFOdDF4jS
         I5g4FeaiBPTDfKSchI5MS753w/atoBcpAyeP5Wps9ocaEe9UygI3+s1ztSIXb5of9GuR
         cYRfBqROVHUtj13vdiEYF6YWPHUKzpX32e+7we5i42t7Tx6yGdwepdZg+GeyBuZOEoZ0
         tx3LMvCvk9pHu1ANb88h2gFrQjxPWbYCl5Xr2wodpiy4Zc4fHKTSePXSECWtqe/0HlfN
         Pzyw==
X-Gm-Message-State: ANhLgQ1P48F3FtnSHpypU/yV+AMJmp9AjQ2m3x0wbHZt1zBALDwFcFLO
        atr+Tay2/vSeSL33v9scuca5wQ==
X-Google-Smtp-Source: ADFU+vsI3tfecxVgn4jxAb7dkMJJg/4u0XS6Gu2SnEAcEHrslsOrRTCgKhIeKNkS/z+S3BayN8PGnw==
X-Received: by 2002:a92:af53:: with SMTP id n80mr12720393ili.42.1585591634260;
        Mon, 30 Mar 2020 11:07:14 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 8sm4375809ion.33.2020.03.30.11.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 11:07:13 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     masahiroy@kernel.org, michal.lkml@markovi.net
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] Makefile: Update kselftest help information
Date:   Mon, 30 Mar 2020 12:07:11 -0600
Message-Id: <20200330180711.14393-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Update kselftest help information.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Makefile | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index e56bf7ef182d..5e5c770423c7 100644
--- a/Makefile
+++ b/Makefile
@@ -1470,12 +1470,15 @@ help:
 	@echo  '  nsdeps          - Generate missing symbol namespace dependencies'
 	@echo  ''
 	@echo  'Kernel selftest:'
-	@echo  '  kselftest       - Build and run kernel selftest (run as root)'
-	@echo  '                    Build, install, and boot kernel before'
-	@echo  '                    running kselftest on it'
-	@echo  '  kselftest-clean - Remove all generated kselftest files'
-	@echo  '  kselftest-merge - Merge all the config dependencies of kselftest to existing'
-	@echo  '                    .config.'
+	@echo  '  kselftest         - Build and run kernel selftest'
+	@echo  '                      Build, install, and boot kernel before'
+	@echo  '                      running kselftest on it'
+	@echo  '                      Run as root for full coverage'
+	@echo  '  kselftest-all     - Build kernel selftest'
+	@echo  '  kselftest-install - Build and install kernel selftest'
+	@echo  '  kselftest-clean   - Remove all generated kselftest files'
+	@echo  '  kselftest-merge   - Merge all the config dependencies of'
+	@echo  '		      kselftest to existing .config.'
 	@echo  ''
 	@$(if $(dtstree), \
 		echo 'Devicetree:'; \
-- 
2.20.1

