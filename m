Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34034E9892
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Mar 2022 15:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243385AbiC1Nsl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Mar 2022 09:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241543AbiC1Nsk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Mar 2022 09:48:40 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732833B299
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Mar 2022 06:46:59 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s8so12648838pfk.12
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Mar 2022 06:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/dMQIrPyzM/kkOwYGPw1QWEOSnMNV3c4vCc0NxfpSIk=;
        b=DWrWXxOejXxfg5Pki9mNTi/NGQ8EbtGx5AYhdRWOJBZbAPTnMNcfRtzK32Qut8Kd5L
         mx5u9zz3R2++k4KKy7Fzpg4GGlZzaEue0/X0uwcm/YSMRp4GsVoK/bt4K/jcHREUmDls
         NFaoTfi2HwZ0wA3yOs4Vm78bXHc181c0ty+ikrOzsaiL0gQdnV51wL+th/FF7KNj26g+
         vYab+NWs8QZPLnL4CPUN/Tu9ev/Kl31fVbJvvENg0bz13bP0zxlk6lAWeJIVtmBN2pTX
         HfdzbMwccIUl/FtRUSsUdFNp32QHJD2rWpenE6iMQSQhP0Xt2eu0FXNi4z3Js+8HKLaX
         VmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/dMQIrPyzM/kkOwYGPw1QWEOSnMNV3c4vCc0NxfpSIk=;
        b=kJOdZsMp274C1F9RThGVeNgmNIsPnKAU2Tv9Be51Mx5MwsUhOXYvUaOnkuECRw3hVz
         6j3pdMQ2y/Awhz7imgRwbry8FOpCtx2Boryjdh4bPe7mT2MOs3hXMaOlPt6xXPzK7g/A
         LYLnpjtZxqoRn+ro9LhJppe30cY0sD7cx8Zyz3GJnugFV2sI00QCUGtp8mPssWi6XQEw
         9hfsGSfb3VyJrlvK9jGN3sU6LIuzwBTNaqDL/Kz8EmKRCfxGL5vpMIaHUi7Og16DeeSe
         4LxM8OYw7VhOwmWGZwENMEwsL0rkiEjKO9tVqF6rNYttGynd/MLoP3Y/u16CA76oO/S9
         G20Q==
X-Gm-Message-State: AOAM533btDzvE1k4nIvuffW+t31TP55nRHHA9oUeefptJwv+xM/EO/+g
        nKrIumrpdfC+312a0EDIMPykWw==
X-Google-Smtp-Source: ABdhPJwVxR9SBT+q+4aBSBWOiOCN9ExcuqATipmXaCY2i5Dn0rpwFMQ+fs8OLE0oODM4si8JB+9/Ow==
X-Received: by 2002:a63:1459:0:b0:381:7672:e79f with SMTP id 25-20020a631459000000b003817672e79fmr10443003pgu.214.1648475218843;
        Mon, 28 Mar 2022 06:46:58 -0700 (PDT)
Received: from localhost.localdomain ([124.123.177.148])
        by smtp.gmail.com with ESMTPSA id g6-20020a056a000b8600b004faa49add69sm16433899pfj.107.2022.03.28.06.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 06:46:57 -0700 (PDT)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     davem@davemloft.net
Cc:     pabeni@redhat.com, kuba@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH] selftests: net: Add tls config dependency for tls selftests
Date:   Mon, 28 Mar 2022 19:16:50 +0530
Message-Id: <20220328134650.72265-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

selftest net tls test cases need TLS=m without this the test hangs.
Enabling config TLS solves this problem and runs to complete.
  - CONFIG_TLS=m

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 tools/testing/selftests/net/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index ead7963b9bf0..cecb921a0dbf 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -43,5 +43,6 @@ CONFIG_NET_ACT_TUNNEL_KEY=m
 CONFIG_NET_ACT_MIRRED=m
 CONFIG_BAREUDP=m
 CONFIG_IPV6_IOAM6_LWTUNNEL=y
+CONFIG_TLS=m
 CONFIG_CRYPTO_SM4=y
 CONFIG_AMT=m
-- 
2.30.2

