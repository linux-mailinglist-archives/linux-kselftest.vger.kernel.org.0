Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BA360815F
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Oct 2022 00:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJUWSY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Oct 2022 18:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJUWSX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Oct 2022 18:18:23 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E8E2AB114
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Oct 2022 15:18:22 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id e15so3502928iof.2
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Oct 2022 15:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uHpsc7JDBKBVEVoQqaI+RpbRVw1k3xIZMj5IbmUH4Mc=;
        b=Hoexp24pWxT51sttqrlDPFHZRFrIzEb8pzyrkGC6ZGWWfSNVV+RkZGdG4VRhf4E1Nj
         y3kjqpSed//ZP8syILc0P6fVc33NlVaUYnTc83BtrF8shGFLFz+gsPiI8JGIFqUGCkg5
         t//2Lz8aLeDppPLKEAL4kqI4FAFxmpHNtAwxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uHpsc7JDBKBVEVoQqaI+RpbRVw1k3xIZMj5IbmUH4Mc=;
        b=CYDmGsN5d97A3JtCmbt37MYfuZKM6P+wbUbv51gkgSlISGDO4bsSDF3T4GHa/rkvzJ
         +8Ox6fWPl5y7adrnPDfKKV0lYVR7UlBGKTlD+W9HCnFGlvhcbOdjmGIT30Pp4phwFNRs
         8CD5WjJBMRWJgH99yKDBPKAorxMKLhP0eYEWetatBnu4dlvIWNTEqRr9o19Hm/BWRtik
         lZ5VONCrJSiYfGsEP6tWWIZbz1WQEvmYNVaUIOXwiARYgwahdez5/4EBDxxuQzqzt3qR
         i1IfJprDy3gItSuwsZVAuvCaZlqgLpLkfP2ZracUthKwPjtLKLDiSWVQTfQoIVl81vXP
         LxRA==
X-Gm-Message-State: ACrzQf1OaDUZs+BC9XLaBy0bvzjxPyalXIC8sjjU4bFGbABXQF8r5MoP
        +pobWXGRf8JxD4dfFOJkZGeQVEz0Lzvb1w==
X-Google-Smtp-Source: AMsMyM4yUT2UADHDx4i/UAcaFyD9mgwJ8M0/v+PX/Jsf76+6TPqfVY7OnpcFlLP7xUWXjSh2Ek5UBg==
X-Received: by 2002:a6b:680c:0:b0:6bc:211c:15cb with SMTP id d12-20020a6b680c000000b006bc211c15cbmr14441038ioc.192.1666390701464;
        Fri, 21 Oct 2022 15:18:21 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id cp6-20020a056638480600b0036cc14af7adsm430740jab.149.2022.10.21.15.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 15:18:20 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     skhan@linuxfoundation.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Enhance watchdog API test coverage 
Date:   Fri, 21 Oct 2022 16:18:15 -0600
Message-Id: <cover.1666390362.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Enace watchdog test to improve watchdog API coverage of iocls and
return values.

Shuah Khan (4):
  selftests/watchdog: change to print reset reason info.
  selftests/watchdog: add support for WDIOC_GETSTATUS
  selftests/watchdog: print watchdog_info option strings
  selftests/watchdog: add test for WDIOC_GETTEMP

 .../selftests/watchdog/watchdog-test.c        | 104 +++++++++++++++++-
 1 file changed, 99 insertions(+), 5 deletions(-)

-- 
2.34.1

