Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8BF75AD9D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 13:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjGTL5f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 07:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjGTL5d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 07:57:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEE6AC;
        Thu, 20 Jul 2023 04:57:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0605561A0F;
        Thu, 20 Jul 2023 11:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE185C433C7;
        Thu, 20 Jul 2023 11:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689854251;
        bh=HYzOZwBCPNFiT5kmjwwkWIQMMa++9Xa/tD7IznzAtKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E3ivI/wuaeM27HfM8GmboxrvtMcFm0CpdZ+1ijS5A7XMiHT/Vi9KejOY3R0wYf0Lg
         aXKR1Zu8Ask5XVQs0mSkDXU7l00KHN+UGt+rrOkKKycCZcJfqTfcociTe5nA95gfui
         dFaBfE5AYNLYo04zuhJveheh5zTvh6QDbFELy+zdMrmRa6qLUqOBgu7E02wM6EJc3f
         KSPjbjdb6z3UzTH/CUJhMSJ8eAZK3OKxtE6uY2fjgTE6s5FYBN/f/9J96wVq4sup3A
         RHph1oSpfx9mqMuaSaGtqqSTwLUzUdQ1UEvtrW+tg8mA/v3D+9d2MvY01vKvlPSoYk
         eg6vAweIuanVA==
Date:   Thu, 20 Jul 2023 13:57:28 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] drivers: base: Free devm resources when
 unregistering a device
Message-ID: <ktpru2pormh4fgkwxjpidk3vrlg3qh47tmye5l4vk6slutd25p@fwtkiizh3fa4>
References: <20230329-kunit-devm-inconsistencies-test-v2-0-19feb71e864b@kernel.org>
 <20230329-kunit-devm-inconsistencies-test-v2-3-19feb71e864b@kernel.org>
 <CABVgOSmBcSA69SXEOh8_A7=aSigv5vztkhPYt9TBSNnxhiRSYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABVgOSmBcSA69SXEOh8_A7=aSigv5vztkhPYt9TBSNnxhiRSYA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 19, 2023 at 05:13:58PM +0800, David Gow wrote:
> On Wed, 28 Jun 2023 at 17:50, Maxime Ripard <mripard@kernel.org> wrote:
> >
> > From: David Gow <davidgow@google.com>
> >
> > In the current code, devres_release_all() only gets called if the device
> > has a bus and has been probed.
> >
> > This leads to issues when using bus-less or driver-less devices where
> > the device might never get freed if a managed resource holds a reference
> > to the device. This is happening in the DRM framework for example.
> >
> > We should thus call devres_release_all() in the device_del() function to
> > make sure that the device-managed actions are properly executed when the
> > device is unregistered, even if it has neither a bus nor a driver.
> >
> > This is effectively the same change than commit 2f8d16a996da ("devres:
> > release resources on device_del()") that got reverted by commit
> > a525a3ddeaca ("driver core: free devres in device_release") over
> > use-after-free concerns.
> >
> > It's not clear whether those concerns are legitimate though, but I would
> > expect drivers not to register new resources in their device-managed
> > actions.
>=20
> It might be clearer to notice that this patch effectively combines the
> two patches above, freeing _both_ on device_del() and
> device_release(). This should give us the best of both worlds.

You're right I'll add that part to the commit log.

> I'm not aware of a use-after-free issue that could result here, though
> it's possible there's a double free I'm missing now that we are
> freeing things twice. My understanding is that commit a525a3ddeaca
> ("driver core: free devres in device_release") was more to avoid a
> leak than a use-after-free, but I could be wrong.

Yeah, I'm not sure where I got the UAF from. I probably
misread/misremembered.

Maxime
