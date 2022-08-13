Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8163059188F
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Aug 2022 06:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbiHMEVI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 13 Aug 2022 00:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMEVH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 13 Aug 2022 00:21:07 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BE4B63;
        Fri, 12 Aug 2022 21:21:04 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id 125so2604374vsd.5;
        Fri, 12 Aug 2022 21:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=o01oq+Gf8dwbR6A/9avB+5Ws+nWiRHQPAKrW3k8wtNc=;
        b=hOUQ1cRL+Jt2NDV/GmJmeNmbbHiQFZrzf6ba5w6zZ8fHA/RBuN6wj6yzpAaPn+qBpl
         O48BsB+26Rnbwhi5KGsLkXSUUm7ClKZBccAIErUS4TVzSEXHUf9R3E3yXUcOGqgLJ9uS
         MYRDHPPWsDGbYsRHeWzp5umVWvpx7rAvUSJWqjndZuJUi+4E+C3HiG2IqqaKp4waIvhJ
         m3bq6LDxliU8FL2mey6Iu0jByxfko63eQxDsG4I2IqvPT5jFXpWn2BGwoJvRLZUYSyVN
         54+v8znGSbKtENttAGCtnyvwZGcPzU5hhNNoqswXmrQVoUdWyzgNAg2MhFIK5HoYAyKQ
         wsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=o01oq+Gf8dwbR6A/9avB+5Ws+nWiRHQPAKrW3k8wtNc=;
        b=117p8MSp3OnUOEyF/w+H9mLYSJbK1XJc9eeq2OkqYVhXqoatwbANLJJnz/cPfooNCi
         bVdZNpelPLXyfWMZQPqT2L2JD9nOyCb6jW4rSQ+AecuYr6YbeSm5Q9M9HnpjHFDEBrbX
         Ay2TBEKmfpvAQ5E6cG1o4N1GFcxsfEY7VWbazQk7HwWC8jr6Zo9s8HbU0FVRtOro6l3G
         JW3yUTtr/VUJGsOAS5FaJ1v1oNUeLjj33GWG+QlWJEThB9T7o0oELj52CKDmCuLYItNT
         qO6E0fekgeEJXAVAoJFxYKafbWn/R7DlUWblIUIg7WPlMtGSbzFIq+pFeunuutT0+DYQ
         UTaA==
X-Gm-Message-State: ACgBeo2FEINtWXKd8Hdlp9Y/iL1FQRIGTsmWfQJBRj/ZR5zEk7duUyJP
        C4NQNW9Y6n0s4ogz4ypxbtw=
X-Google-Smtp-Source: AA6agR4wbFBYq+rOGl82SCRp+2/Q2sgm4HoLMFyo/8Zgm/OIdbvURTOxjEz1xTa0zQ2zCRj2bN9Y3Q==
X-Received: by 2002:a67:ad09:0:b0:388:8e8c:55f8 with SMTP id t9-20020a67ad09000000b003888e8c55f8mr3006206vsl.43.1660364463711;
        Fri, 12 Aug 2022 21:21:03 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1003])
        by smtp.gmail.com with ESMTPSA id cz10-20020a056102290a00b0038712af0dbesm2434646vsb.22.2022.08.12.21.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 21:21:01 -0700 (PDT)
From:   Tales Aparecida <tales.aparecida@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>, brendanhiggins@google.com,
        corbet@lwn.net
Cc:     Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 0/4] Documentation: KUnit: minor fixes
Date:   Sat, 13 Aug 2022 01:20:51 -0300
Message-Id: <20220813042055.136832-1-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

This is a short series of minor fixes to the Kunit documentation,
they probably can be squashed but I suppose it's easier
to review them individually.

Thanks for any feedbacks,
Tales

Tales Aparecida (4):
  Documentation: kunit: fix trivial typo
  Documentation: Kunit: Fix inconsistent titles
  Documentation: KUnit: Fix non-uml anchor
  Documentation: Kunit: Add ref for other kinds of tests

 Documentation/dev-tools/kunit/architecture.rst | 4 ++--
 Documentation/dev-tools/kunit/faq.rst          | 8 +++++---
 Documentation/dev-tools/kunit/index.rst        | 2 ++
 Documentation/dev-tools/kunit/run_wrapper.rst  | 4 +++-
 Documentation/dev-tools/kunit/usage.rst        | 4 ++--
 5 files changed, 14 insertions(+), 8 deletions(-)

-- 
2.37.1

