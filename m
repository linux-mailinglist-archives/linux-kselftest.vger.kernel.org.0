Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDB564C8EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Dec 2022 13:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238246AbiLNMXV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Dec 2022 07:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbiLNMW5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Dec 2022 07:22:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3002A25C7A;
        Wed, 14 Dec 2022 04:20:25 -0800 (PST)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BD3CD6602BF9;
        Wed, 14 Dec 2022 12:20:20 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671020423;
        bh=Kvtf89epnIka0ewCiy2bwTCDZMYaQDZFo0v3TeWBBPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bmj7W0h22ImHXanYrP/14WsZcnSst5QFgL9vwf5ZuEXCG/GazXGV1pmwo2tZsIXs6
         RNj06Y6PFQujRV6pJoNfGF5oBvXTu0+XoWansSdHkQAx+zOlS4I8edsCuyMGUiTFK+
         /YCPtsueecDrh9f3bMZPdAFFSCKU9JVBRCNaiOEAlSRhW/3jCMZRVkuKS37idlLj6E
         V+oWnhtFioo0Nq7+E++rgKeKYHCWjg5yRZQX1m1HD6WnsraNMhTyEUg5FYzvZqzNBL
         4JUpFR3YP+7J5JDHyZpyhPv6cxjkb7QmuPr0wXt4OjZ+kEkqJ42Mtz7fuJhPdBIVDK
         1TAgFzGsFVixA==
Date:   Wed, 14 Dec 2022 09:20:16 -0300
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, kernel@collabora.com,
        Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: Increase kselftest timeout
Message-ID: <20221214122016.2geliu5k5n7fbo6r@notapiano>
References: <20221213183242.1908249-1-nfraprado@collabora.com>
 <2ee34e21-44bd-71e7-6da2-f4bea9a35452@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ee34e21-44bd-71e7-6da2-f4bea9a35452@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 13, 2022 at 11:37:56AM -0700, Shuah Khan wrote:
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
> 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > 
> > ---
> > 
> >   tools/testing/selftests/alsa/settings | 1 +
> >   1 file changed, 1 insertion(+)
> >   create mode 100644 tools/testing/selftests/alsa/settings
> > 
> > diff --git a/tools/testing/selftests/alsa/settings b/tools/testing/selftests/alsa/settings
> > new file mode 100644
> > index 000000000000..a62d2fa1275c
> > --- /dev/null
> > +++ b/tools/testing/selftests/alsa/settings
> > @@ -0,0 +1 @@
> > +timeout=600
> 
> Adding timeouts like this especially 10 minutes will increase the time
> it takes to run tests. We run the risk of people not wanting to run tests
> anymore.

I set it high because I suspect the time it takes to run pcm-test might be a lot
higher in some machines (even on mt8192-asurada-spherion, it takes 1m15s, but
only ~10% of the tests are actually running, since many of the PCMs are
disabled).

But I can lower it to, say, 3 minutes, and we can increase the timeout as
needed.

Thanks,
Nícolas
