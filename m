Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9C1702966
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 11:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjEOJp3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 05:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241052AbjEOJpE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 05:45:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F9110DD;
        Mon, 15 May 2023 02:43:15 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a0c:5a83:9203:ad00:2382:dff5:d060:ac62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6933966031D7;
        Mon, 15 May 2023 10:43:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684143793;
        bh=+MCskmCGmJIvWHAj2wGlAPgVjUersyVw3itl9FDTp5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ka60WAbh4l1VgDuo+v2GG9+WQHy4LUUFlDeIMv+GY0t0i8NC2P1YMLiHO6akxXi+Y
         Tx8aNMGzzrcof4O+eCPsPnUyAUwgaBIRHmcsbsrLM5hxhL92g0wkv+e72M3toM8Jv9
         1ih7eTozqvjiNZUHWWKbt6RvEn87/R1LrtFE/StQuKYlLkydl120lRDXDZXSexyEoM
         1evc/M2rz7U+NNKMsqbFjhwsUvQelBvDMJhiNy8FaxDBatvaW45ZoCGnfbssq9y6u8
         WQewBeTvw2wttPsMIpy00MR0MR3txkWpsmM/g2mZqWdtCAWuPQKJ9P1QEbhrwCWdGu
         ni22R/h32NcuQ==
Date:   Mon, 15 May 2023 11:43:10 +0200
From:   Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>,
        kernel@collabora.com, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: Increase kselftest timeout
Message-ID: <20230515094310.hulpyhhtb4sxxn7i@rcn-XPS-13-9305>
References: <20221213183242.1908249-1-nfraprado@collabora.com>
 <2ee34e21-44bd-71e7-6da2-f4bea9a35452@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ee34e21-44bd-71e7-6da2-f4bea9a35452@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

Bumping an old thread, this is still an issue for this test [1] and it
could end up affecting many others.

On mar 13-12-2022 11:37:56, Shuah Khan wrote:
> On 12/13/22 11:32, Nícolas F. R. A. Prado wrote:
> > The default timeout for kselftests is 45 seconds, but pcm-test can take
> > longer than that to run depending on the number of PCMs present on a
> > device.
> > 
> > As a data point, running pcm-test on mt8192-asurada-spherion takes about
> > 1m15s.
> > 
> > Set the timeout to 10 minutes, which should give enough slack to run the
> > test even on devices with many PCMs.
> > 
> 
> 10 minutes is way too long.

Is there a downside to that? There'll be some tests that take more time,
I don't think that's a problem with the tests or a reason to let them
timeout. IMO it's the test framework which should adapt to the needs of
different types of tests, and the solution provided by this patch is
good enough, it addresses the problem for this particular test suite.

If the solution is still unacceptable, do you have an alternative
proposal in mind that we can try to implement?

Thanks,
Ricardo

[1] https://linux.kernelci.org/test/case/id/646127cf62438996ba2e8648/
