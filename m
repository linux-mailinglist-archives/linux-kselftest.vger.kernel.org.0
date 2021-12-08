Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA03146DCC5
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 21:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbhLHUQA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 15:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbhLHUP7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 15:15:59 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3720EC061746
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Dec 2021 12:12:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8C217CE2343
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Dec 2021 20:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29060C341C7;
        Wed,  8 Dec 2021 20:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638994343;
        bh=iazGye5DeSrNPzppIpRwidZhhtB4BOPdiXaY1n0rx9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ma2dKd/+KjKG1eJhDDH/xlnOc8IdJicaBRAkPIl3Qb/4U8bKWqmZpJU1HoomVHUX9
         NCSO9uqIKXrampTnSJJXTrcmlobCtvhVOHCzoheMwj5/taNFkp0v0FKd/ycLkrrMvh
         HD5jy8Hu/OJXtpGhlXEbDi/uF7K8CdvGNfeVcEpKPZSp1F/H9PSLJ33MauL5RbzD+N
         plsyN5dv8DWfiZ6EFCoCmVREGvHFWzCcEBHa2ui6Jzpt+uFzTxaO6UFoOaB10HBYp5
         6KT87n/PTgUwhQwo9U+N67FgrnIArDAfcXwNyKw+dHzwrLFSar4M9msIkIMJD4JD5D
         u0pwPbDOweZFw==
Date:   Wed, 8 Dec 2021 20:12:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Takashi Iwai <tiwai@suse.de>, Shuah Khan <shuah@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        linux-kselftest@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2] kselftest: alsa: Add simplistic test for ALSA mixer
 controls kselftest
Message-ID: <YbERo5FxA6Rm3bhd@sirena.org.uk>
References: <20211206160305.194011-1-broonie@kernel.org>
 <de0c5677-c2cf-d1ab-68c5-2f410d17b66c@linuxfoundation.org>
 <YbD7+C74DFlZEokt@sirena.org.uk>
 <37f87d39-b5a9-46f6-2667-c0b7aafb731a@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lWT1caQ4Q7KYXwAA"
Content-Disposition: inline
In-Reply-To: <37f87d39-b5a9-46f6-2667-c0b7aafb731a@linuxfoundation.org>
X-Cookie: Alex Haley was adopted!
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--lWT1caQ4Q7KYXwAA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 08, 2021 at 11:59:18AM -0700, Shuah Khan wrote:
> On 12/8/21 11:39 AM, Mark Brown wrote:
> > On Wed, Dec 08, 2021 at 10:42:35AM -0700, Shuah Khan wrote:

> > > > +	snd_ctl_elem_value_alloca(&val);

> > This is idiomatic for alsa-lib code.

> This is kernel code that is going into kernel sources. Why follow
> alsa-lib convention?

Well, the kernel doesn't generally use alloca() as a pattern given the
relatively small stack sizes we have and doesn't define helpers like
these for it...  it's a toss up here between the conventions for use of
the library we're using and the conventions of the kernel.

> > > > +	ksft_print_header();

> > > Add a check for root and skil the test.

> > There is no need for this test to run as root in most configurations,
> > it is common to provide direct access to the sound cards to some or all
> > users - for example with desktop distros the entire userspace audio
> > subsystem normally runs as the logged in user by default.  alsa-lib's

> On my system, I don't see any output if run as root. Are there some tests
> that work as non-root?

All of them work as non-root if the user they're running as has access
to a card, if they do or not is system dependent - there may not be any
cards at all in a given system to find.  Running as root will punch
through most permission problems but it's not a requirement and a system
could use a security module like SELinux to restrict what root can do.
The sound devices are usually in /dev/snd, though userspace can place
them where it wants - if run as a user that can access the relevant
devices for the mixer interface (usually /dev/snd/controlC* though again
userspace can rename them) then the tests will run on those devices.

--lWT1caQ4Q7KYXwAA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGxEaIACgkQJNaLcl1U
h9DjdQf8CkPDsV4U6m2ROl74ZMf9OC+szRiNZw+w0Hh/hBlSxC4biyrcSrbgeuLA
ELLBEeUTn2jaXsLBx39cdoqR3N2JXZ6iO2FQMCnebrAGf08qcmpH/FPzTs5SGywp
AMQ79NlH0ekWcGpibqxGvOekeEUZJ3/ImzuBpmXraMQDIGbb+ckEzxpxyjHEX2WJ
1sVwTYNL3Q8snU1M8WCaneSPtN8n5tKDhgNbC/Oz6U11kfrAmImQG3EhHkBBxt5s
bIh6ycGVRyWNR0N4MoOksr4AJR7QxU+9UlmseaGLmz+2Lqxx9qit8LlvAbZxtj8T
XeTrc7RvdSOj4sb5Kt3T0wuzplXInw==
=s3po
-----END PGP SIGNATURE-----

--lWT1caQ4Q7KYXwAA--
