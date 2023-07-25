Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7428B761D69
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 17:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjGYPdp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 11:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjGYPdp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 11:33:45 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070461FCA
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 08:33:44 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id e9e14a558f8ab-34637e55d9dso4750775ab.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 08:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690299223; x=1690904023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NcZE0YtioxF2+m/NhSyjLV3N0x16iE/BIeSmFcb4big=;
        b=UhyZKI5hoyLcl+X5NF7HSxxUc+Fjb3j6RkY1HalvianMocRJYdXU/1FyF6Ba7P45gi
         t/fTNMCPhYA9wKFTf3AzzbSbkAfcmZrrVnleUqWBebrAGub6BX+9ZnLup+wFa7QgGqaO
         MwnajVbV6D/HneVpOlKXkCpX9b6zvE+wvnvg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690299223; x=1690904023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NcZE0YtioxF2+m/NhSyjLV3N0x16iE/BIeSmFcb4big=;
        b=YRT6MAjUmZTxgXt9j+4W+QUoruASceyTQrUEShGx9JCXX53LA1FL9rnuBa1usdYiFA
         ouXw443dU3M6xAxcF5zWzbtlb80iDgg3CBfXpEWOZhLZbfTo5+g4180xJpnRh9PKe4d6
         lOCQSfekMp4jR3faOR2JiGBKM07Jj2XvZuVN7XsRTIdnFDUh705BHonPTOOvJDGxY5fp
         UamsmDrKiM3SOpoJ6EoquBgq+bb4W3KznlTsFYTj94eEjjakYviWAleN9r10zGyuCfzD
         QIFN8DCbhuz7CuE3NBOYWUOVzirtiULsIkvEC5+pPTnFjomJpg99VW2uUCE/TIJazoa9
         S2BQ==
X-Gm-Message-State: ABy/qLZm114R2+P8A3GBHvLIsly6PcU2E9vOhSV7iNNi23CJQotBhLoj
        k7XEokQ2R3T+MN+wZZKCc9Pu6w==
X-Google-Smtp-Source: APBJJlH31qSc01sPP7Ny562tmdbA0KbLwNjP31nxHoDvFacgarF/gv3lyxwGrK6Cl7/oGuupaiyK1g==
X-Received: by 2002:a92:c88e:0:b0:346:4eb9:9081 with SMTP id w14-20020a92c88e000000b003464eb99081mr8735353ilo.3.1690299223404;
        Tue, 25 Jul 2023 08:33:43 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id w7-20020a92db47000000b0034294982b83sm3793994ilq.69.2023.07.25.08.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 08:33:43 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests:prctl: Fix make clean override warning
Date:   Tue, 25 Jul 2023 09:33:41 -0600
Message-Id: <20230725153341.15025-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Remove clean target in Makefile to fix the following warning
and use the one in common lib.mk

Makefile:14: warning: overriding recipe for target 'clean'
../lib.mk:160: warning: ignoring old recipe for target 'clean'

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/prctl/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/prctl/Makefile b/tools/testing/selftests/prctl/Makefile
index cfc35d29fc2e..01dc90fbb509 100644
--- a/tools/testing/selftests/prctl/Makefile
+++ b/tools/testing/selftests/prctl/Makefile
@@ -10,7 +10,5 @@ all: $(TEST_PROGS)
 
 include ../lib.mk
 
-clean:
-	rm -fr $(TEST_PROGS)
 endif
 endif
-- 
2.39.2

