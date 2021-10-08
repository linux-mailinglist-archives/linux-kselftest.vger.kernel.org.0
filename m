Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D09426D7D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Oct 2021 17:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242884AbhJHPai (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Oct 2021 11:30:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231129AbhJHPah (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Oct 2021 11:30:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0FFB60F6F;
        Fri,  8 Oct 2021 15:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633706922;
        bh=6oSToV9ggFKc8QjkklbsZ0Ve5MMNj5FyB4F3UNX3VCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T/K9AbW+6gV8CWtfW93JjuNghIbJJEUKSm2esxA3YCp5/QQX6JHWcKNEtH7FCSImd
         z6NU6h1Af4hSP2oMTh/v//AgxXRJ05jkG3RiqkEGvISF+F+9502Cf75BCtgkhzwRet
         dJkpUwLNqDgNci3kkwTTmat1EWhLR3ZPHOXuAayobHYo5MsR/W0G4h5K0ugW4084L5
         a4Q+G/UQV969HHncN/TKgzxQKp6vk7cJwuBO7yBpmsYnRhN2Ss7nwaYsi9QHu5jWaY
         6SkB2n8lo4WLSwcQ/Sx3u2wZMqOgPxABSEZEhgWq2l9SLpfPp8RxK42awaUgoeFZu9
         8vb/U9YZa3ovg==
Date:   Fri, 8 Oct 2021 16:28:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alan Hayward <Alan.Hayward@arm.com>
Cc:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Luis Machado <Luis.Machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant KumarDwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH v1 12/38] arm64/sme: Provide ABI documentation for SME
Message-ID: <YWBjp8UnkMaHsZRA@sirena.org.uk>
References: <20210930181144.10029-1-broonie@kernel.org>
 <20210930181144.10029-13-broonie@kernel.org>
 <59675B79-E426-4177-8A4E-43026E42B9E3@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WptuHqh5pX8tfhsN"
Content-Disposition: inline
In-Reply-To: <59675B79-E426-4177-8A4E-43026E42B9E3@arm.com>
X-Cookie: When your memory goes, forget it!
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--WptuHqh5pX8tfhsN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 08, 2021 at 02:11:46PM +0000, Alan Hayward wrote:

> read looks fine, given this builds on the existing SVE implementation. Al=
though
> I think effectively managing the different modes in the debugger may be t=
ricky.

Sadly I don't see any way of handling the hardware in a way that
doesn't present some kind of hassle.

> The .rst files are a huge help too.

Glad to hear it.

> What is returned if SME is in streaming mode and I call GETREGSET with NT=
_ARM_SVE ?
> What is returned if SME is not in streaming mode and I call GETREGSET wit=
h NT_ARM_SSVE ?

In both cases you'll get the user_sve_header with no register
payload and neither of the register types flagged.  I'll make
this a bit more explicit in the documentation, in the SVE
documentation it currently just talks about no register data
being available but doesn't ever actually explicitly say why that
would happen like we do for ZA, it's currently not super helpful.

> Can NT_ARM_SSVE return a fpsimd?

It's documented that way for simplicity but in the current
implementation it won't ever actually do so in practice.  The
only case where I could see that it might happen would be if we
change the syscalls to stay in streaming mode over syscall, in
that case we could do as we do for SVE and preserve FPSIMD
registers only.  At present we drop out of streaming mode if we
get a syscall with it enabled so it's a non-issue, if people
agree that that's the right thing for the syscalls then we should
update the documentation to specify this since otherwise we'll
doubtless catch someone by surprise if we ever manage to start
doing it in the future.

> > +* The presence of SVE is reported to userspace via HWCAP2_SME in the a=
ux vector
>=20
> SME not SVE?

Ack, yes.  Well, I guess given that SME should never appear in a
system without SVE the statement is true but...

--WptuHqh5pX8tfhsN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFgY6IACgkQJNaLcl1U
h9D5Uwf+MKiWOlDxnR+AMwjmAo/kSHUd9cmo2cbiwug9qLFsgNFfEiL0LQKXXh0t
4ppT2xtIDwoVQpjBriweVTtn6LmC5tMQ5t92TaGO1lexcEGCrVt8fS+rDcpalJhz
iOhEw0mPS3mE6sprJ+OHlV/DQ7UTJ7rk9cUxdrHw2shorI7X3IBfutPijvpiVONw
BgfmXfEhbl9v/Up2zxbFISBkN4+I4lphaTOwQLEsgm0wzIpAfRhGW/o/i4ymI1aF
qeuktka4tw6nNygYbOe0JdCMF/TaRG5LqqQZgD6YhUi8t9Iz4512voH4QHFsF4x7
WZYCNR0/jKMsY3Ab4FICvgQXSn8QCQ==
=hLXO
-----END PGP SIGNATURE-----

--WptuHqh5pX8tfhsN--
