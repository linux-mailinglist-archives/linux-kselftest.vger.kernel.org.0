Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845D6428D9A
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Oct 2021 15:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbhJKNQU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 09:16:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231538AbhJKNQT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 09:16:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A887C60F23;
        Mon, 11 Oct 2021 13:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633958059;
        bh=zrt4DdCaYzzMygmJcF9MUNE6qJXPjem40EpxmAm7oOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=me1Q7vyI43OEI+mA6o/aIxRtQLrKUwSKXeMFJmiY9NoWTn4VKA4vjzZOKwZVCZLx+
         kNUJadEL5+0S+L7OVkKShNZev6TrDDNAln0YmhpSPCqdnliHiDLS0P3o+JF1SwB+ro
         aprBSHLRbABZAJx437ZBJnkslbkvSKRh8sg8i7Rh2sNtypWkiQIRWYV3gqAHmu+Op9
         k7js50KRkxusame1MlY0YYOjpAKjclhcbYI5hDWQs0rAqKXAbljrL4qaUF5sfN3tge
         9hlE+eURwVhCDQruyl648tWc5vnH7mTMGh0A3zV/5cff0/phGnH8jukmwgJfCxEQb4
         mpYFJDgdQDMwA==
Date:   Mon, 11 Oct 2021 14:14:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 08/38] arm64/sve: Track vector lengths for tasks in an
 array
Message-ID: <YWQ4qDmu8Yyiwm5C@sirena.org.uk>
References: <20210930181144.10029-1-broonie@kernel.org>
 <20210930181144.10029-9-broonie@kernel.org>
 <20211011112057.00007b90@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MUswJGCPQF2iB385"
Content-Disposition: inline
In-Reply-To: <20211011112057.00007b90@Huawei.com>
X-Cookie: Your ignorance cramps my conversation.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--MUswJGCPQF2iB385
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 11, 2021 at 11:20:57AM +0100, Jonathan Cameron wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > As for SVE we will track a per task SME vector length for tasks. Convert
> > the existing storage for the vector length into an array and update
> > fpsimd_flush_task() to initialise this in a function.

> I'm clearly having a trivial comment day.  Given reduction in indenting
> it would be nice perhaps to reformat comments to take that into account.

Again I'll have done this to make it clearer that things are just being
moved about - as a reviewer I do find things like that very helpful.

> I'm also unconvinced the trivial wrappers are worthwhile.  (maybe you drop
> those later?)

They do hide what we're doing from the rest of the series which makes
the whole thing a lot easier to work with, especially if we change what
data structures we use or there's some debate as to the names of the
constants.  A bunch of them directly map onto existing trivial wrappers
too, there's been some stylistic preference for that.

If people want to remove the wrappers I'd propose leaving them for now
then adding a patch afterwards which removes them, or at least waiting
until we've got very firm agreement from Catalin and Will on the data
structures and constants.

--MUswJGCPQF2iB385
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFkOKcACgkQJNaLcl1U
h9CXLwf/RlL3+zISFpOx1BhuF2eTNi/RjVMictpcEu4nhvYTeBMILGi4CkpasGPw
HEJrGTlYpsmyXzPp0b7Hy2rIlrdO8jp4ll7ZXyKjxqnRXH/qpdlIMzWfj0fZtN2s
draP5RgCvsrjy78KNJCC8avXJ/XW1XqSn09T5lxfezAKXbL3OBmkFIIo2GRoWLXa
ihnIcUEWEupNqUVesaOuu7cqtmRR2UKvzq7sR0640O3VHkMkLH8Wn8+vZAC65/PI
y3stXyDksCoMrxBb3PA6drJXc4I/q03Usb1Apt4WXyO32B1TsfIgAsu64t/wslOb
kW3q1OmFEX7wrkUFF5nIjUOdmZkJpQ==
=Md1T
-----END PGP SIGNATURE-----

--MUswJGCPQF2iB385--
