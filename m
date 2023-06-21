Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B3673864F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 16:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjFUOJV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 10:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjFUOJH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 10:09:07 -0400
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC3719A9;
        Wed, 21 Jun 2023 07:09:01 -0700 (PDT)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 762631E36;
        Wed, 21 Jun 2023 16:08:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 762631E36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1687356537; bh=hWXdhsVQpB/+odxLGC42YI96+2wDIp0AX9bS19+Gdls=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=hRxm4WlyJw2csmDx+4MIHfUDNvERGecyaCSIxZONPgugcwVP2EkzFT0MtkQimGTzQ
         p2SQK9SuEZdc6vsQGGJLj712XnD/+bHpNaqzyPhyRDm3oa8c5e+3dIFxRb5+T1l8z0
         BeqR/fZQCBqx+siJoyuTH6gKZhg9OUiLUMfi+a4s=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Wed, 21 Jun 2023 16:08:48 +0200 (CEST)
Message-ID: <443f697b-fecf-6e8e-0b76-65257aff7da8@perex.cz>
Date:   Wed, 21 Jun 2023 16:08:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shuah Khan <shuah@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20230620220839.2215057-1-nfraprado@collabora.com>
 <20230620220839.2215057-3-nfraprado@collabora.com>
 <33bea0d3-b8dd-4936-812e-392166df4437@sirena.org.uk>
From:   Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 2/2] kselftest/alsa: pcm-test: Decrease stream duration
 from 4 to 2 seconds
In-Reply-To: <33bea0d3-b8dd-4936-812e-392166df4437@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 21. 06. 23 15:08, Mark Brown wrote:
> On Tue, Jun 20, 2023 at 06:08:26PM -0400, Nícolas F. R. A. Prado wrote:
> 
>> -	const int duration_s = 4, margin_ms = 100;
>> +	const int duration_s = 2, margin_ms = 100;
> 
> This doesn't scale the margin with the duration which will affect the
> sensitivity of the test to misclocking.  It should make it less
> sensitive which is *probably* safer but at least worth noting.
> 
> We might also have issues with some of the lower sample rates, IIRC some
> devices are constrained in ways that mean they want a minimum buffer
> size which is harder to satisfy with very short playbacks and low sample
> rates.
> 
> I don't know why Jaroslav picked the 4s number here.

You basically replied yourself. The values (time + margin) were picked to do 
the DMA test for a reasonable time - based on my experience.

I think that the problem is somewhere else here. The overall test timeout 
should be calculated dynamically. All tests may be queried for the maximal 
expected interval based on the hardware/software capabilities. It's a bit 
pitfall to have a fixed time limit where the realtime tests depend on the 
number of devices.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

