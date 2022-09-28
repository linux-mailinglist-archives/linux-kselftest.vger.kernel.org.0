Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3C45EE82B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Sep 2022 23:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiI1VST (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Sep 2022 17:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbiI1VR5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Sep 2022 17:17:57 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F5176941;
        Wed, 28 Sep 2022 14:12:44 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso1668034wms.5;
        Wed, 28 Sep 2022 14:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=/eIyDSHf+Wvh5dWsUKZ5IxKV+5309fgN2JH2Fm4Ndz0=;
        b=Dkdr+KJYuG66hdJb23dnHSn1DwGNUfskY7BgEqfWap3p5qgDKa4wYBWs9ld6cQub5d
         c+Q3bDeHyKbjJo1C2v89lMnXR84Mzf8NYwu91D1NGBubnFzT8stguHfA8ca4X3oV1FMz
         PEpqTsqW5+GjAry5FIVc75y34mPqk0HmfbnekDidYm8YXM0XNTVDI/i/2rKP5WKiJmtt
         5YRJbw9ccb8TDKSmeGj6A9ztmkZK3Sw73Z4huTFXYpSvJoVccsTlVgQOaXNF9TMtaKeO
         xSTu2OHBf1zJmChNfg0SPSahW9/xfCD0Yggz5OBI/oi4T2BxOn4BN4bwmc7ihfIy+dUT
         cTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=/eIyDSHf+Wvh5dWsUKZ5IxKV+5309fgN2JH2Fm4Ndz0=;
        b=XQhj3hkGfVcbjvMPd4a91ACt9bWSL1LQXOKaREJlEXAy7Ufje378FyVXc20zsUBIbb
         KTSW53ICgcD0AynY87QcyczOc5VVm31yzxq4kYSocUvDnUawXzMGD/GFjDV65mje6aqA
         bdNXQS7a+ui1pQHaniptHFbYFnK3EIGdfXerXKAAlr3rpSrLXKh7CTuoGKO98G5EMBP7
         pDfK+WGUIn7FBX4aSNtrYpEDtjagDu5hrLquADjiDoBWHy3Vq+D9EzH+KdYYNz/mJBHp
         JstcoUJO1TRp881qGBlZfs0fPquiEmR/JHXvrmAphAxvEc6K4BsFdztqErbbACysTat7
         uaAQ==
X-Gm-Message-State: ACrzQf0HBQsEV0g7Tn/KpJny6/blt7nb+tyngTrLt9zEVlBdobNFbvhE
        qLRSr0Q0q3oKBkXJtHi+t9NqkYmkLq8WsA==
X-Google-Smtp-Source: AMsMyM6hGAJbxH4u+WZ+7QZCK2XvJa/Vur1hu8Dj4hQ0CYgINIcC5F0dfh0i/KmyHvSGQiMUH/0xUQ==
X-Received: by 2002:a05:600c:b42:b0:3b4:7580:a995 with SMTP id k2-20020a05600c0b4200b003b47580a995mr8498320wmr.30.1664399563194;
        Wed, 28 Sep 2022 14:12:43 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j1-20020a5d4481000000b0022ae401e9e0sm4947459wrq.78.2022.09.28.14.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 14:12:42 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: Fix spelling mistake "UFFDIO_CONINUE" -> "UFFDIO_CONTINUE"
Date:   Wed, 28 Sep 2022 22:12:41 +0100
Message-Id: <20220928211241.62158-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is a spelling mistake in a debug message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/kvm/demand_paging_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 779ae54f89c4..56035d94c653 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -225,7 +225,7 @@ static void setup_demand_paging(struct kvm_vm *vm,
 
 	PER_PAGE_DEBUG("Userfaultfd %s mode, faults resolved with %s\n",
 		       is_minor ? "MINOR" : "MISSING",
-		       is_minor ? "UFFDIO_CONINUE" : "UFFDIO_COPY");
+		       is_minor ? "UFFDIO_CONTINUE" : "UFFDIO_COPY");
 
 	/* In order to get minor faults, prefault via the alias. */
 	if (is_minor) {
-- 
2.37.1

