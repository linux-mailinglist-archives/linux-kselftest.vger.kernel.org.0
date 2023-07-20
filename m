Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F8D75AD33
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 13:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjGTLkR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 07:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGTLkQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 07:40:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9AB189;
        Thu, 20 Jul 2023 04:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AC8661A3F;
        Thu, 20 Jul 2023 11:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9297AC433C9;
        Thu, 20 Jul 2023 11:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689853214;
        bh=sf+p0ULly/I8blnBXx05PUk4EXNbAItZNLpvWv1NFOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KhKZODI0RVQzFfx8b/9CPiUlb7RoEuHXXczVpfA583EApxRZByeT1u69uKUrV+4EA
         CD/h5Dz/G4+3kcH+XqHpA7rP2KoxLLeCGVGVKr6QedqSOhFbpXqkfNV95NsGl4teU4
         Invz8JbJZs+d1ZAUcorQ+NbCwTiKhkb7sERQy/Z+S0yQcXm93Sen5G/h7ZnQKo9kyw
         nyPG1YoN1SdX9Uo6Z3YkEqG5CTEBffTi8hbGOxnMcurAFnCjPQNGAc4/0mnZnAzAij
         axRiE+/EojBXQdClkxdEOjVNBdETxe1CV8UaNshegltAUeCxW3JJ8jLXQ+BaBBuZmn
         cXAvJQXAemHeQ==
Date:   Thu, 20 Jul 2023 13:40:12 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] drivers: base: Add basic devm tests for platform
 devices
Message-ID: <rlcesc2enzsbagn6uzu3fztda65lsytsgsrhgnau6knlhcudvk@qsodzahwizj3>
References: <20230329-kunit-devm-inconsistencies-test-v2-0-19feb71e864b@kernel.org>
 <20230329-kunit-devm-inconsistencies-test-v2-2-19feb71e864b@kernel.org>
 <CABVgOS=-LCKpevBNO6SSBYXLAURa5AxXr34gOdt2xZSL+FwoXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABVgOS=-LCKpevBNO6SSBYXLAURa5AxXr34gOdt2xZSL+FwoXg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi

On Wed, Jul 19, 2023 at 05:13:50PM +0800, David Gow wrote:
> On Wed, 28 Jun 2023 at 17:49, Maxime Ripard <mripard@kernel.org> wrote:
> >
> > Platform devices show some inconsistencies with how devm resources are
> > released when the device has been probed and when it hasn't. Let's add a
> > few tests to exercise thos paths and odd cases.
>=20
> Nit: "these".
>=20
> Also, it'd be nice to call out the case that fails explicitly in the
> commit message here, so it's obvious what the "inconsistency" is.

I've reworded the commit message.

> >
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > ---
>=20
> This looks good to me. I think this is, if anything, even more
> obviously important than the root device issues, so we definitely need
> to fix or document it.
>=20
> Reviewed-by: David Gow <davidgow@google.com>

Thanks!
Maxime
