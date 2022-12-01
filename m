Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A6763F650
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 18:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiLARma (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 12:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiLARm3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 12:42:29 -0500
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920F899F5B
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 09:42:28 -0800 (PST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 3BA6FA0046;
        Thu,  1 Dec 2022 18:42:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 3BA6FA0046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1669916547; bh=2ucO9Lt57QgFG0n6/VtpYwFCiWHoaAKYvu3pZkweeFQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CN4dxb0fH+MXJRow9EJBMzMtzaCAZWQNN4bHsdNNWbpILV3GOl/3ZUALpIRytXXLn
         m4RgdueywCN+TPY3PJqQSV2nVrMAE42NYc2/k8lus/pMyaKLH02tEQ8iORqjjCN53t
         Mmlk5Juz5C4QpEBZzsSAT4vHYRn7WzuY0QVEVgFM=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Thu,  1 Dec 2022 18:42:22 +0100 (CET)
Message-ID: <a55212fc-a676-2335-b861-94ba8d10f207@perex.cz>
Date:   Thu, 1 Dec 2022 18:42:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 0/6] kselftest/alsa: pcm-test improvements
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org
References: <20221130000608.519574-1-broonie@kernel.org>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20221130000608.519574-1-broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 30. 11. 22 1:06, Mark Brown wrote:
> This series provides a bunch of quick updates which should make the
> coverage from pcm-test a bit more useful, it adds some support for
> skipping tests when the hardware/driver is unable to support the
> requested configuration and then expands the set of cases we cover to
> include more sample rates and channel counts.  This should exercise
> switching between 8kHz and 44.1kHz based rates and ensure that clocking
> doesn't get confused by non-stereo channel counts, both of which are I
> expect common real world errors, at least for embedded cards.

The current code allows to override "test.time1 {} test.time2 {}" blocks in 
the configuration files which is equivalent to "test { time1 {} time2 {} }". 
This changeset will introduce configuration lookups like 
"pcm.0.0.PLAYBACK.44k1.2.big {}" which creates another configuration 
structure. The '.' (compound level delimiter) should not be used in the test name.

My original idea for the next improvement was to parse the 
"pcm.0.0.PLAYBACK.test" compound and gather the tests for the given pcm. If 
this compound is missing, we can continue with the hard-coded defaults.

About the skips - the test should probably keep to support also the exact 
parameters. For example - if the hardware must support 6 channels, it should 
not be a skip but an error. Everything may be broken, including the PCM 
configuration refining.

I just sent the patch with my changes for comments [1]. It's just the base 
code which may be extended with your requirements. The skips may be 
implemented using configuration field like 'skip_if_rate_error yes' or so.
Let me know, if I can stack your changes on top, or perhaps, you may be 
willing to adapt them.

					Jaroslav

[1] https://lore.kernel.org/alsa-devel/20221201173333.2494019-1-perex@perex.cz/

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
