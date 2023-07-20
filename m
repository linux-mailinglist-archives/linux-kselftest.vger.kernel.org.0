Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8F675ACF7
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 13:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjGTL30 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 07:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjGTL30 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 07:29:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F464B7;
        Thu, 20 Jul 2023 04:29:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDA7561A32;
        Thu, 20 Jul 2023 11:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20ECC433C8;
        Thu, 20 Jul 2023 11:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689852564;
        bh=TTITfnpSbPlFq5r36NeY2UBi8pOPRA+E7+jXQ+8VJcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Me9KG+0l8LRP1GpZVtKDY8zmdy7IjaD7KQa5NIqsbriFqY/nhtMNbN0/65Wk3Hqgo
         a/A7SN2erpOkurmCXH/kaumvn+pg0gaIqkkZ6EF5WeJ0g/ozRKyDPVROurJmHCUfwO
         GUCCtrE1lt0igoLa+TqDZCKYMnICMzH6k2NKqEfowixLUhcetID96i0mSJ3+OU2/2u
         ZOfkIUmRmMsDoQvzVFBU9WCA4y4ekWdvprJpGS3j+Mlv7/13k5NiaOXbmlbCCpspHL
         zHTfDNjT9WV4okmLeTD0cPgUNCFNdzDpDkDBUpUbjth7t4smlrZ6TLoQR9iSyZ8jo5
         1s/7PMhd7y37g==
Date:   Thu, 20 Jul 2023 13:29:21 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] drivers: base: Add basic devm tests for root
 devices
Message-ID: <vfllifvyada5q6agv2jouzqvlcisdqvkv54vs32x3b6jku4aw4@qqqfsgv57mvt>
References: <20230329-kunit-devm-inconsistencies-test-v2-0-19feb71e864b@kernel.org>
 <20230329-kunit-devm-inconsistencies-test-v2-1-19feb71e864b@kernel.org>
 <CABVgOSmUZw3CpzpduAjDx+eZCU5tm=5Pq8dyVt+d7oXb6-_h=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABVgOSmUZw3CpzpduAjDx+eZCU5tm=5Pq8dyVt+d7oXb6-_h=Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David,

On Wed, Jul 19, 2023 at 05:13:45PM +0800, David Gow wrote:
> On Wed, 28 Jun 2023 at 17:49, Maxime Ripard <mripard@kernel.org> wrote:
> >
> > The root devices show some odd behaviours compared to regular "bus" dev=
ices
> > that have been probed through the usual mechanism, so let's create kunit
> > tests to exercise those paths and odd cases.
> >
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > ---
>=20
> Reviewed-by: David Gow <davidgow@google.com>

Thanks!

> There's definitely an argument that root devices are not supposed to
> be like regular devices, and so devm_ managed resources aren't
> supposed to work with them. Either way:
> - It needs to be documented somewhere (and this test makes for good
> documentation, IMO).
> - It should be consistent: if devm_ isn't to be used with root
> devices, it should fail everywhere, and if it is, it should work in
> all the cases below.
>=20
> So I'm all in favour of including this test and making root devices work.

I agree 100%. I've reworded the commit log a bit to make it clearer
that's what we should strive for, and that this is what this patch is
doing.

> That being said, I am planning to send out a patchset adding a struct
> kunit_device for use in tests, which will be attached to a "kunit"
> bus. I think the combination of "fix devm_ with root devices" and
> "don't recommend root devices as a 'fake' device for testing" is
> probably the longer-term solution everyone can agree upon?

Yeah, that sounds reasonable to me

Maxime
