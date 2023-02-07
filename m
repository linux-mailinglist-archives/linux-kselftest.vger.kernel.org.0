Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE22A68D181
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 09:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjBGIfo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 03:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjBGIfn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 03:35:43 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708F52E837;
        Tue,  7 Feb 2023 00:35:42 -0800 (PST)
Received: from [IPV6:2001:861:4a40:8620:7b9f:2478:5d44:165f] (unknown [IPv6:2001:861:4a40:8620:7b9f:2478:5d44:165f])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AA9936602063;
        Tue,  7 Feb 2023 08:35:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675758940;
        bh=E3Y9inr0arhrKx0qaCwL1KecQMNd8CBh/3BAy3IS224=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jfoR4SZChjfv4LcK3tHJFMOv99GDCy06l+d5LyPTpDla9zwbR51ozhpguY2NgupEG
         aokvCZc/txNSjo27p+0C4MNB8RalT5RebbAuT8GrOlArjA2AKSShffyC4/q3ojhSmy
         xRkdaAFF07lkj9ZJ+Edt8odjqvUGPUXn2ZF+r8cIuBpxhLWjZV1K7HZIF1YT3Ar3vw
         CYZLe9Kkk4d2+YJgkr999Fxc3cuCvh+hGqL94dX9NkKo5/O/C5Ua3wjSh2p7ExEr58
         2INbehgRE25Gyljj6lqXfqjqTP4ULGbOoX1ovoIv4kaXPzvZmX4URlplwjUPUAvqR6
         GPUz7PlB+qnxQ==
Message-ID: <97df8ef0-5eef-91cd-2d6d-eeff764c5e35@collabora.com>
Date:   Tue, 7 Feb 2023 09:36:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] selftests: use printf instead of echo -ne
Content-Language: en-US
To:     Shuah Khan <shuah@kernel.org>,
        Gautam <gautammenghani201@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>
Cc:     kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernelci@lists.linux.dev
References: <20230204135652.336495-1-guillaume.tucker@collabora.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
In-Reply-To: <20230204135652.336495-1-guillaume.tucker@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 04/02/2023 14:56, Guillaume Tucker wrote:
> On some systems, the default echo command doesn't handle the -e option
> and the output looks like this (arm64 build):
> 
> -ne Emit Tests for alsa
> 
> -ne Emit Tests for amd-pstate
> 
> -ne Emit Tests for arm64
> 
> This is for example the case with the KernelCI Docker images
> e.g. kernelci/gcc-10:x86-kselftest-kernelci.  To avoid this issue, use
> printf which handles escape characters as a standard feature and is
> more widespread among modern shells.
> 
> The output is now formatted as expected (x86 build this time):
> 
> Emit Tests for alsa
> Emit Tests for amd-pstate
> Skipping non-existent dir: arm64
> 
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Suggested-by: David Laight <David.Laight@ACULAB.COM>
> Fixes: 3297a4df805d ("kselftests: Enable the echo command to print newlines in Makefile")
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> ---
> 
> Notes:
>     v2: use printf insead of $(which echo)

Oh I see you've already applied the v1 on kselftest/next branch:

  79c16b1120fe selftests: find echo binary to use -ne options

Do you want me to send this printf fix rebased on top?

Thanks,
Guillaume

