Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A2A75A0A2
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 23:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjGSVen (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 17:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGSVem (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 17:34:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5699813E;
        Wed, 19 Jul 2023 14:34:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D57BF6184B;
        Wed, 19 Jul 2023 21:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA13C433C7;
        Wed, 19 Jul 2023 21:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689802479;
        bh=xs32mHA4nF+9n7KP46/BKyGjjAqCtVdA4jVux5mh1s0=;
        h=Date:From:Subject:To:Cc:From;
        b=KArmPznPDrFTMp1keqVit+9mFc7Y4Ez8RPx5k0emvObaFNEkmeJpAhm1Qd10RDQTJ
         Bm1e3Xq0VJQntzNgwB8Gr8zEDZV5Slz3A6nRMd/2Ejh1CN/J+2dfVccKisoO0LvhCY
         AlfNrIOBaA8difCvi4XSv5VBHxh0ferpdiGm7eg946Dse7Kc88IMqZ8Id8DWyGHY7Y
         WXLVzaRLXIRK+ZYZSse0iYI/92DtF7Wu/Kvt3HGefN8rAid7tU68DunS0bV152J+p0
         30z6yluU1iyLGrpLZZIL4P9o4r4RwPtV33z4faNEAuFgAiuNqakpV9jVIHChu5n2st
         yP/IpJ+uw/qmw==
Message-ID: <e04d1d5b-518b-bebd-aa7a-70b87bc4e867@kernel.org>
Date:   Wed, 19 Jul 2023 15:34:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
From:   shuah <shuah@kernel.org>
Subject: [ANNOUNCE/CFP] Kernel Testing & Dependability Micro-conference at LPC
 2023
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

I am reaching out to announce that we are once again planning to
gather to discuss testing and dependability related topics at the
Kernel Testing & Dependability Micro-conference at LPC 2023.

We invite you to submit proposals for discussion:
- https://lpc.events/event/17/abstracts/1430/

The Linux Plumbers 2023 Kernel Testing & Dependability track focuses on
advancing the current state of testing of the Linux Kernel and its related
infrastructure. The main purpose is to improve software quality and
dependability for applications that require predictability and trust.

We aim to create connections between folks working on similar projects,
and help individual projects make progress.

This track is intended to promote collaboration between all the communities
and people interested in the Kernel testing & dependability. This will help
move the conversation forward from where we left off at the LPC 2022 Kernel
Testing & Dependability MC.

We ask that any topic discussions focus on issues/problems they are facing
and possible alternatives to resolving them. The Micro-conference is open to
all topics related to testing on Linux, not necessarily in the kernel space.

Suggested topics:

- KernelCI: Topics on improvements and enhancements for test coverage
- Growing KCIDB, integrating more sources (https://kernelci.org/docs/kcidb/)
- Sanitizers
- Using Clang for better testing coverage
- How to spread KUnit throughout the kernel?
- Building and testing in-kernel Rust code.
- Explore ways to improve testing framework and tests in the kernel
   with a specific goal to increase traceability and code coverage.
- Explore how do SBOMs figure into dependability?

Proposals can be submitted here, by August 20th:
- https://lpc.events/event/17/abstracts/

Please reach out to MC leads:
      Shuah Khan (shuah@kernel.org)
      Sasha Levin <sashal@kernel.org>
      Guillaume Tucker <guillaume.tucker@collabora.com>

thank you,
-- Shuah
