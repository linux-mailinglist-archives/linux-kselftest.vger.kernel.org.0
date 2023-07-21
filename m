Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD6E75D073
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jul 2023 19:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjGURQs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 13:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjGURQr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 13:16:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AED22D7B;
        Fri, 21 Jul 2023 10:16:44 -0700 (PDT)
Received: from [IPV6:2001:861:4a40:8620:d901:c525:a85f:2da3] (unknown [IPv6:2001:861:4a40:8620:d901:c525:a85f:2da3])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AA4C76606F70;
        Fri, 21 Jul 2023 18:16:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689959802;
        bh=YD4iaeXfN0/ZwtoiuO2lfQhuap3yBW4hZwcYz7IkNHs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Kp60x5iT0bGU5gxqhgXcgFl7ke4PXSlVLtIh/IXGx21yIcad4X+sVpxjROXqutjA4
         xR3cV2M9pCrR6xiMDRn/VnLDQJ5lmSzXw7RAiQiDVwOMB54itFJ26YFL6vaksFD7+C
         4hqg3WQGVyBBY7SGW4r9oDOLhETr7qA39CYBlLtFt/C7/yi8ep3HhMxrg+I7+HWnvx
         dr+OT2Vl+LGeYMjMRnPZ2grX+4M6CzXe9xgQ4LCopZJNVQj/4n1onQXAYy+MDQs/rn
         H/9srF+3BCJt2Vgerii2H5O39k6wWfT9GRD6PVW0HwzHU1OdBMapZFtiy7YOEqTTOS
         diMFMI1MmGjoQ==
Message-ID: <e185087d-8df2-2457-0c93-4b638fdee05c@collabora.com>
Date:   Fri, 21 Jul 2023 19:16:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [ANNOUNCE/CFP] Kernel Testing & Dependability Micro-conference at
 LPC 2023
Content-Language: en-US
To:     shuah <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "kernelci@lists.linux.dev" <kernelci@lists.linux.dev>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
References: <e04d1d5b-518b-bebd-aa7a-70b87bc4e867@kernel.org>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
In-Reply-To: <e04d1d5b-518b-bebd-aa7a-70b87bc4e867@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+kernelci

On 19/07/2023 23:34, shuah wrote:
> Hello,
> 
> I am reaching out to announce that we are once again planning to
> gather to discuss testing and dependability related topics at the
> Kernel Testing & Dependability Micro-conference at LPC 2023.
> 
> We invite you to submit proposals for discussion:
> - https://lpc.events/event/17/abstracts/1430/
> 
> The Linux Plumbers 2023 Kernel Testing & Dependability track focuses on
> advancing the current state of testing of the Linux Kernel and its related
> infrastructure. The main purpose is to improve software quality and
> dependability for applications that require predictability and trust.
> 
> We aim to create connections between folks working on similar projects,
> and help individual projects make progress.
> 
> This track is intended to promote collaboration between all the communities
> and people interested in the Kernel testing & dependability. This will help
> move the conversation forward from where we left off at the LPC 2022 Kernel
> Testing & Dependability MC.
> 
> We ask that any topic discussions focus on issues/problems they are facing
> and possible alternatives to resolving them. The Micro-conference is open to
> all topics related to testing on Linux, not necessarily in the kernel space.
> 
> Suggested topics:
> 
> - KernelCI: Topics on improvements and enhancements for test coverage
> - Growing KCIDB, integrating more sources (https://kernelci.org/docs/kcidb/)
> - Sanitizers
> - Using Clang for better testing coverage
> - How to spread KUnit throughout the kernel?
> - Building and testing in-kernel Rust code.
> - Explore ways to improve testing framework and tests in the kernel
>   with a specific goal to increase traceability and code coverage.
> - Explore how do SBOMs figure into dependability?
> 
> Proposals can be submitted here, by August 20th:
> - https://lpc.events/event/17/abstracts/
> 
> Please reach out to MC leads:
>      Shuah Khan (shuah@kernel.org)
>      Sasha Levin <sashal@kernel.org>
>      Guillaume Tucker <guillaume.tucker@collabora.com>
> 
> thank you,
> -- Shuah

