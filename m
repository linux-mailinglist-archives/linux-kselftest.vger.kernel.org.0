Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AC0753FF8
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 18:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjGNQtN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 12:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjGNQtN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 12:49:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC26E358C;
        Fri, 14 Jul 2023 09:49:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A6B661D50;
        Fri, 14 Jul 2023 16:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60D6C433C8;
        Fri, 14 Jul 2023 16:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689353351;
        bh=wrvm85rpUKJvNzsGJuulgx0fZzfIPbGow1TQ3F7WIZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JMP2dQXQX3KksnQ87Yf0g7ixHYTfgbww5O56hL6BURnGRgHcnVky9wlSXdx7ZcAXH
         N/qhftW6TcSy1FVC+SRqpr64zkUGGt5MsaRCGS/5WcGR00wp33TNfQblT41z4FWwFM
         nXx80vBxitiuugAHjDz+Fwx5NGlQgUmhKFrXItdizdQXIfLkF9kobmLWtwFfW+b3oA
         zYWdsZmNI6y19wLU3pATzhjJQRom/VDea5JEE1rFHNf5xiKUbarYNck51gTMuggTbV
         k6PBp9jkI8SK1L33RKiMa9SSEcjGIHiFJbcfbkYHOr1O+53imE4THl2kbn09WINwul
         cbvStONnN6JsA==
Date:   Fri, 14 Jul 2023 17:49:06 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        paul.walmsley@sifive.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: Re: [PATCH v5 0/4] RISC-V: mm: Make SV48 the default address space
Message-ID: <20230714-tapering-driller-474e5581587b@spud>
References: <20230714001430.75798-1-charlie@rivosinc.com>
 <20230714-hangnail-stinking-60f9725ac0d5@spud>
 <ZLF5nS12R37loA9I@ghost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fWc2GpvHl7O6XfFi"
Content-Disposition: inline
In-Reply-To: <ZLF5nS12R37loA9I@ghost>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--fWc2GpvHl7O6XfFi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 09:36:45AM -0700, Charlie Jenkins wrote:
> On Fri, Jul 14, 2023 at 12:17:00PM +0100, Conor Dooley wrote:
> > On Thu, Jul 13, 2023 at 05:13:59PM -0700, Charlie Jenkins wrote:
> > > Make sv48 the default address space for mmap as some applications
> > > currently depend on this assumption. Users can now select a
> > > desired address space using a non-zero hint address to mmap. Previous=
ly,
> > > requesting the default address space from mmap by passing zero as the=
 hint
> > > address would result in using the largest address space possible. Some
> > > applications depend on empty bits in the virtual address space, like =
Go and
> > > Java, so this patch provides more flexibility for application develop=
ers.
> >=20
> > The patchwork automation failed to apply this, what is the base for the
> > series?
>=20
> I forgot to pull in the changes to the riscv selftests so the conflict
> is in that Makefile. I will send out a v6 with the correct base.

If you don't actually _depend_ on the content of those changes to the
self tests, then just submit on top of v6.5-rc1 & Palmer can sort out
the conflicts.

--fWc2GpvHl7O6XfFi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLF8ggAKCRB4tDGHoIJi
0m07AQCj+lIfVeQE4qpYSA7caL2Mx/b/6avQrccHw0jj58/tHAEAySe+TvuXvxDU
vH9Tt3i4AfDoonrbuk1+fvb154INugw=
=GRef
-----END PGP SIGNATURE-----

--fWc2GpvHl7O6XfFi--
