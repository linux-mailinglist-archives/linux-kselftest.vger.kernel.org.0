Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1929568BD70
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 14:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBFNCm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 08:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjBFNCl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 08:02:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EFC2332B;
        Mon,  6 Feb 2023 05:02:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B440160ED0;
        Mon,  6 Feb 2023 13:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1556C433EF;
        Mon,  6 Feb 2023 13:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675688560;
        bh=tJmujHmJcFdKVliYWHuZ3IFNjgrhKrrGtfsWmEgSqkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d8HW7sAH0SbCtcMu0ADg7/fZAnIawCqxfE9Om4v+vWLAzpnp2qannalR338lhxoTi
         Ej6THKSMlLieGy9PVuUxRIy/KVhgeUhhbHW/2boQUxLYRpZY8cVHVojvpSrZ45An+V
         OuyPq8qnIO8VFA7nmvYLOiVSzYNnLVoYOV7s53bH3A7kBMyWwrhGr+VXt1g9MfhoBx
         gHMUmghNkiwpAW2u48OQ9oacXygl0Bs38F1br3WjPxakY+VEtd3RcmyM5X6TclEZm9
         kSlfWTALaUoAtwuc6fWT3EBHqLU8z5HgLChBYTMc/Ed8GxHsKQKZx1crlYHoem1+2K
         Dy72Kd/cN9YnQ==
Date:   Mon, 6 Feb 2023 13:02:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 07/21] arm64/sme: Enable host kernel to access ZT0
Message-ID: <Y+D6afdDp6St079z@sirena.org.uk>
References: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
 <20221208-arm64-sme2-v4-7-f2fa0aef982f@kernel.org>
 <86y1pbywbb.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pxpYawn5NK0KvypX"
Content-Disposition: inline
In-Reply-To: <86y1pbywbb.wl-maz@kernel.org>
X-Cookie: Hope is a waking dream.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--pxpYawn5NK0KvypX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 06, 2023 at 09:31:20AM +0000, Marc Zyngier wrote:

> __check_override assumes that the ID_AA64SMFR0_EL1 value is in x1, and
> I guess that the intent of the code is to reuse value read a few lines
> above. But as the comment says at the beginning of the macro, x1 will
> be clobbered, and the checks always fails.

Yes, it looks like this is a victim of rebasing - I didn't spot the
change to make x1 clobbered when the override checking was refactored.
Thanks for spotting this.

> I presume we're just lucky that sme2_kernel_enable() does the same
> thing unconditionally, which probably means this was only ever tested
> with a VHE kernel (it'd otherwise catch fire).

Yes, I'd not be surprised if I'd never run this in nVHE.

> The easiest fix is just to reload the id register before checking it,
> something like the patch below, compile-tested only.

Reviewed-by: Mark Brown <broonie@kernel.org>

--pxpYawn5NK0KvypX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPg+mgACgkQJNaLcl1U
h9CWoAf/autA/Mi++TtM0WfDO989RWtfdQeyfjo68JI2KAfuOS+EZzXsBI0tGWfa
ZJekC2WlIZbo6gBAtDHT/+LspDthG2hQJXawXHy0bpG/YvLnjJvxo7KWTvO9szI3
m2BP5wL0O2McHI5RAbVvyCZS8VCvP0OeC5X5G9uYX7Plh51tNb/lMZUbTyJvxkTg
WderG8+izuMhAYMSi7M5wuceSY+QO2sVLv/f2cFTVXFqDYpjmfyjhjhGi0zOGlUd
XOk9iR9mg6PHs/RB4beUsxNJj5JQT9Du28JXmyG7iuLqrZN45TK3VqXKNk2dC+dV
vwknsBbQvGLhcNCwsvb9DNCZS6g5pQ==
=ajB9
-----END PGP SIGNATURE-----

--pxpYawn5NK0KvypX--
