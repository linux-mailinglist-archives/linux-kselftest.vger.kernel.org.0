Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304FE55D62E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jun 2022 15:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241457AbiF1HSA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Jun 2022 03:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241591AbiF1HSA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Jun 2022 03:18:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3219C2CDF1;
        Tue, 28 Jun 2022 00:17:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2E5BB81CD3;
        Tue, 28 Jun 2022 07:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D803C341CB;
        Tue, 28 Jun 2022 07:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656400676;
        bh=9f3hskPxoIjzFqhBj1+BqdFVuxoMB7KN1AknVE1N6C0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pyvJQc1J0UjDydiW+SD4ddCS1eB/njx9dSX1MPIyYOnTeRBQsQ0xwhfGZG/DU69zR
         efeCMwfpOrlUFGQANe7y1zhqAgklewzwFM1LY/4lDUsTrvz5sWDKG86uu8oFo+fiix
         u+qTUjqEgVr2O8NkBz+mF54s6RGMh2xkRNpX6qrqITS4vzbCSE+pWp9TmSrDrQH+Ik
         IbyDaPUQThh8rJBpPp2vs4slme+zg2FBvxYauWAfne+mya5HZ4kWKilQEjPBTEN7Io
         49Z9R2jRBhdxxoOPy4ceS6nOw++fQ3Kg7pRYFez+QfbIq4IOZsIPzVC4p+FYT5yl5B
         /EcHmj0xo+UTw==
Date:   Tue, 28 Jun 2022 08:17:49 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, Harinder Singh <sharinder@google.com>,
        Tim Bird <tim.bird@sony.com>
Subject: Re: [PATCH] Documentation: kunit: eliminate code-block warnings
Message-ID: <20220628081744.7e6955e6@sal.lan>
In-Reply-To: <4c403239-3c71-4ab9-2168-f7e9d77008b2@infradead.org>
References: <20220401024707.10550-1-rdunlap@infradead.org>
        <87fsjt50c8.fsf@meer.lwn.net>
        <4c403239-3c71-4ab9-2168-f7e9d77008b2@infradead.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Em Sat, 25 Jun 2022 08:12:00 -0700
Randy Dunlap <rdunlap@infradead.org> escreveu:

> > So which version of Sphinx are you using?  The language argument became
> > optional in 2.0, so you'd need to be running something pretty ancient to
> > see this.
> > 
> > Ah, I see 1.8.5 in your later message...how wedded are you to that
> > version?  
> 
> It's what ships with OpenSuse Leap 15.3, which I have been using for quite
> a long time.
> 
> I see that there is now OpenSuse Leap 15.4, so I could upgrade to that,
> but I don't know what version on Sphinx it uses.

It seems that there are two versions on it, packaged with different
names:

2.3.1:
	https://download.opensuse.org/distribution/leap/15.4/repo/oss/noarch/python3-Sphinx-2.3.1-150400.1.7.noarch.rpm
4.2.0:
	https://download.opensuse.org/distribution/leap/15.4/repo/oss/noarch/python3-Sphinx_4_2_0-4.2.0-150400.11.6.noarch.rpm

It should be noticed that, while we don't decide to remove support for
Sphinx < 3, kernel-doc has two different outputs, depending on Sphinx C
domain support. The legacy support is enabled with version < 3 [1].

As we're currently discussing dropping support for Sphinx version < 3,
I would recommend you to use the 4.2 package.

Regards,
Mauro

[1] Version 3.0 is a bad choice, as the C domain is partially broken.
