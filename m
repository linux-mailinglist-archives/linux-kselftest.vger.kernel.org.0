Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB63A781218
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 19:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379118AbjHRRhj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 13:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379146AbjHRRhO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 13:37:14 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3C54229;
        Fri, 18 Aug 2023 10:37:09 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-565dc391be3so1648593a12.0;
        Fri, 18 Aug 2023 10:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692380229; x=1692985029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YW52+wyDUyO2L5rIdP1Yu5xGuH4Mp8hYAuSlf8LZHvM=;
        b=DwiSePEzdv2Jzdf8G0tfzoEBlouteK03XQFLxNmRdABq75AEyO1/tGBNELJ3TLN7mt
         nPt8KL5cAKVc5BKX30S6+vARVT4wnMWrknfCcKcpS9FsITrtbc7GxHfMWy9At3teawA3
         CgtIuJ9oBog9hBKQW1mWEVLFoixdipsTwxBAJ2s4WeYTM1dYG6grIRlJ62vQvTxd4PIu
         K5Qg55Li9JLIFxS9+MYYAIysbWOPTZZdSHc4pFFwgS+W9lqlYLr6l3Mqd6+j9vj1z8/j
         USUy3nFKBtHYg50KztR968edZMerwqa5/asMwnvpnQjWjk8Slr+qzgCIPoG+hwqxZiYo
         8U3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692380229; x=1692985029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YW52+wyDUyO2L5rIdP1Yu5xGuH4Mp8hYAuSlf8LZHvM=;
        b=GcFnuIwzorD1Ll+srgnkUNks0+liJblwZpIGimgkXv1bnqqNeTRqjelPc92D1jG6TL
         /g2o02pV7Z+TPuyeKfGW4IjePa6jor0qJyFHv/bdPIlYybGlqAD207hEl1wZm02YsVUK
         UC3BF81ykTK5sgG/dX3N1ktCLQgQZfiSuQpSZA80e/IkIMEY12/hCZIrDIwl3bJSl9eZ
         GRR6DjLhhPi8OWPbLzCwahegCotnfp3jf+Sz49CVKCiAlng3Xse643xeUjipPzw6CLX9
         ENmdHxmBtnr+NymZddSxUKjI7hqLB6Pd/+0DXP/Z2SYOzY+Bzh2QX+6Olo0VlWbuGVwp
         cGwA==
X-Gm-Message-State: AOJu0YwYLEOxp9Vr9ZnTQkB5Oq4AqxASNgCT8+6Od+plWoUM2C57+liU
        i9Az8vYTbDc+06bYKJfYyGk=
X-Google-Smtp-Source: AGHT+IHSa6TLwReCiv37Ufbq5NLyr7Ge9qIPIA+NlyZtg5Togo2BH2TlRRmtDi/ha7A/2yjOEwmN0w==
X-Received: by 2002:a17:90a:31c2:b0:268:8ff2:5c0d with SMTP id j2-20020a17090a31c200b002688ff25c0dmr4246579pjf.17.1692380229059;
        Fri, 18 Aug 2023 10:37:09 -0700 (PDT)
Received: from fanta-System-Product-Name.. ([222.252.65.171])
        by smtp.gmail.com with ESMTPSA id 1-20020a17090a19c100b00267ae12b80bsm3785031pjj.34.2023.08.18.10.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 10:37:08 -0700 (PDT)
From:   Anh Tuan Phan <tuananhlfc@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org
Cc:     Anh Tuan Phan <tuananhlfc@gmail.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v1] selftests/net: Add log.txt and tools to .gitignore
Date:   Sat, 19 Aug 2023 00:37:02 +0700
Message-Id: <20230818173702.216265-1-tuananhlfc@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Update .gitignore to untrack tools directory and log.txt. "tools" is
generated in "selftests/net/Makefile" and log.txt is generated in
"selftests/net/gro.sh" when executing run_all_tests.

Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
---
 tools/testing/selftests/net/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 501854a89cc0..2f9d378edec3 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -15,6 +15,7 @@ ip_local_port_range
 ipsec
 ipv6_flowlabel
 ipv6_flowlabel_mgr
+log.txt
 msg_zerocopy
 nettest
 psock_fanout
@@ -45,6 +46,7 @@ test_unix_oob
 timestamping
 tls
 toeplitz
+tools
 tun
 txring_overwrite
 txtimestamp
-- 
2.34.1

