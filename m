Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE677BFF82
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 16:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjJJOoI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 10:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjJJOoH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 10:44:07 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4021CB7
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Oct 2023 07:44:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso1029092366b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Oct 2023 07:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696949042; x=1697553842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8j7Zr/R9tLiQtURg5XOgTT0C5ad2/qZUZc6ItwXYFHY=;
        b=FCQfx9sUJb54h4CKYTgdTbuBS0kA6nuLypTWtLqx9Wy+CXjm4LGBaP/2T2GN2+uhcA
         cIRUssD2RTsuWPNeEdI1Hj/IXlmpu5ZI/uxO23kjsccxiDbfFicO/5gNK0KVE806T5tF
         f1dD4L7P8N9zk4aI1HjLMWTyuIO9VHdEYzziQ3kJDZ3iyUKAKWN5/mHa25VlCEDIKRV4
         h3yl/8qS8s6uL9/H6ezVG3EvyrVZJgXJLaDU48vb1m117sGxWhUGirQ4x3ha7G4i81IV
         qXrHx8QvI+5/6zoUvdaRpUhA4x8di+ec8R3I43ZKn+nMUfYy67GNOCLG6a5+Tgu6eixo
         0DaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696949042; x=1697553842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8j7Zr/R9tLiQtURg5XOgTT0C5ad2/qZUZc6ItwXYFHY=;
        b=qnbgSAM02IsMHwIY9bO/yyG4PnVUDhx4G5iUgGNWQmLoHjZUZpODvGaVdjJXheA6Kj
         z3HI+tFedUnGBGD4ftUc6eCwwRDtGcbzKvRRvM7XuJ/WNAZJatxlCrtqUT8rCn3ITwVJ
         x6ekx28aJEN5jcOnURT9DHL8KoO89h4XSWFQWu0c9+Ngsvg2pxytipY8kWMaekLtJcY3
         pTdJwlGNuf3T7uyi7fXkKSIRrPpPnacDQT783as4WEuY91SWBBCsGrWj+EsY9oPcfFmR
         Ea1I/FAsjztOgBmnMm2KbnlExLq4c9pOcfPHrZFCfmu4lFvDASFnS1SlUfihgNfVUlGl
         mouQ==
X-Gm-Message-State: AOJu0Yw97OJSKEVcqLTegad8jjcMwyrTVgfR6VJKvFun/kmXDFS8aQda
        pqosg/+270NDcV0wd8OO7mPJLg==
X-Google-Smtp-Source: AGHT+IFTNQ2fnNorUyp5clsnNygUQyxd0TyIcQb4r+pDJCjJSVzNOWBKpOkGnnY+cQYIZv4ugNcfQA==
X-Received: by 2002:a17:906:154:b0:9a9:f2fd:2a2b with SMTP id 20-20020a170906015400b009a9f2fd2a2bmr14156360ejh.73.1696949042619;
        Tue, 10 Oct 2023 07:44:02 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id m14-20020a1709066d0e00b00991d54db2acsm8511033ejr.44.2023.10.10.07.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 07:44:01 -0700 (PDT)
From:   Jiri Pirko <jiri@resnulli.us>
To:     netdev@vger.kernel.org
Cc:     kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
        shuah@kernel.org, pavan.chebbi@broadcom.com,
        linux-kselftest@vger.kernel.org
Subject: [patch net-next] selftests: netdevsim: use suitable existing dummy file for flash test
Date:   Tue, 10 Oct 2023 16:44:00 +0200
Message-ID: <20231010144400.211191-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jiri Pirko <jiri@nvidia.com>

The file name used in flash test was "dummy" because at the time test
was written, drivers were responsible for file request and as netdevsim
didn't do that, name was unused. However, the file load request is
now done in devlink code and therefore the file has to exist.
Use first random file from /lib/firmware for this purpose.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 .../drivers/net/netdevsim/devlink.sh          | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
index 7f7d20f22207..46e20b13473c 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
@@ -31,36 +31,43 @@ devlink_wait()
 
 fw_flash_test()
 {
+	DUMMYFILE=$(find /lib/firmware -maxdepth 1 -type f  -printf '%f\n' |head -1)
 	RET=0
 
-	devlink dev flash $DL_HANDLE file dummy
+	if [ -z "$DUMMYFILE" ]
+	then
+		echo "SKIP: unable to find suitable dummy firmware file"
+		return
+	fi
+
+	devlink dev flash $DL_HANDLE file $DUMMYFILE
 	check_err $? "Failed to flash with status updates on"
 
-	devlink dev flash $DL_HANDLE file dummy component fw.mgmt
+	devlink dev flash $DL_HANDLE file $DUMMYFILE component fw.mgmt
 	check_err $? "Failed to flash with component attribute"
 
-	devlink dev flash $DL_HANDLE file dummy overwrite settings
+	devlink dev flash $DL_HANDLE file $DUMMYFILE overwrite settings
 	check_fail $? "Flash with overwrite settings should be rejected"
 
 	echo "1"> $DEBUGFS_DIR/fw_update_overwrite_mask
 	check_err $? "Failed to change allowed overwrite mask"
 
-	devlink dev flash $DL_HANDLE file dummy overwrite settings
+	devlink dev flash $DL_HANDLE file $DUMMYFILE overwrite settings
 	check_err $? "Failed to flash with settings overwrite enabled"
 
-	devlink dev flash $DL_HANDLE file dummy overwrite identifiers
+	devlink dev flash $DL_HANDLE file $DUMMYFILE overwrite identifiers
 	check_fail $? "Flash with overwrite settings should be identifiers"
 
 	echo "3"> $DEBUGFS_DIR/fw_update_overwrite_mask
 	check_err $? "Failed to change allowed overwrite mask"
 
-	devlink dev flash $DL_HANDLE file dummy overwrite identifiers overwrite settings
+	devlink dev flash $DL_HANDLE file $DUMMYFILE overwrite identifiers overwrite settings
 	check_err $? "Failed to flash with settings and identifiers overwrite enabled"
 
 	echo "n"> $DEBUGFS_DIR/fw_update_status
 	check_err $? "Failed to disable status updates"
 
-	devlink dev flash $DL_HANDLE file dummy
+	devlink dev flash $DL_HANDLE file $DUMMYFILE
 	check_err $? "Failed to flash with status updates off"
 
 	log_test "fw flash test"
-- 
2.41.0

