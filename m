Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BD4672029
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 15:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjAROvm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Jan 2023 09:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjAROvZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Jan 2023 09:51:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905655954B;
        Wed, 18 Jan 2023 06:44:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B670B81123;
        Wed, 18 Jan 2023 14:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08348C433EF;
        Wed, 18 Jan 2023 14:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674053055;
        bh=Ny0Vcg5hmKHdMZlRWCYr0SBfo4oea+g9YYVbkfl6z9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gJjdJIYwwnU+pHS3gD5yn0jFDcr/I8PiLw2FekWBsgaV+Q9KtNGkdvTT8w40FZKeH
         QIzRkA/+LWRZfJyTKNKCMi8o7MKf7AbcH9FTMcfu57MYhvrj8JgPM/vSGF5W8zb8lW
         +5Vrtmo+v+f8kjE1Nh5R1b94Zg3iQCu3nafbwDDG7O2zT5PpNUjNmVI05JWEixNG0q
         wNARub3f8NPzZDc2fFiKvATt/Mi+dvvD7Uz7gu46NFsXX+b7AZtC5wE7XWRbgcZol7
         9gCI8osuUKl1c0FOGyGt9ydsdGyJwIEHSFAM+C8QFeshXlwpbEXY2M6XEcJc4lUHI9
         xfCQhL11sI7Vg==
Date:   Wed, 18 Jan 2023 14:44:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Oliver Upton <oliver.upton@linux.dev>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Fix build of rseq test
Message-ID: <Y8gFutX+TaukU1BX@sirena.org.uk>
References: <20230106-fix-kvm-rseq-build-v1-1-b704d9831d02@kernel.org>
 <Y8f2HA02BJNYUYc7@sirena.org.uk>
 <c8901eb2-bee5-a7b3-cd43-ace970754ade@efficios.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h/ESpOp+6w4ZSKYi"
Content-Disposition: inline
In-Reply-To: <c8901eb2-bee5-a7b3-cd43-ace970754ade@efficios.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--h/ESpOp+6w4ZSKYi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 18, 2023 at 09:30:01AM -0500, Mathieu Desnoyers wrote:
> On 2023-01-18 08:37, Mark Brown wrote:
> > On Fri, Jan 06, 2023 at 07:24:19PM +0000, Mark Brown wrote:

> > > The KVM rseq test is failing to build in -next due to a commit merged
> > > from the tip tree which adds a wrapper for sys_getcpu() to the rseq
> > > kselftests, conflicting with the wrapper already included in the KVM
> > > selftest:

> > Any thoughts on this?  The KVM tests are still failing to build
> > in -next:

> I'm OK with the fix you submitted in this email thread. Should it be routed
> through -tip ?

I think so, it'll need to go along with the patch that introduced
the new wrapper.

> Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks.

--h/ESpOp+6w4ZSKYi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPIBbYACgkQJNaLcl1U
h9DccAf9Eji87NOmL5JGlW5mBCREYf+LSKZPm4vjI4FCjJompW+Bii6By7fnra/I
6yERf0CmNImJ4NURQtNQ3dTH41aENlfY6EnB55afx58BHJdYPEqAK5m1oY0RqAiX
MTi1W48AgCNwjDmTT/3AuKfMqIuWHwaJyvK/1fEr36hcYxpsfFlr3uE63ll3CX2m
g29dfvysZRckFYn6pFoZP30O/NSt/SUnW1r9piZuW1tYAKAPGiQx/UzAp9tIwrH4
i8v7TikUPPPpO3OCVqoE3jUDAoh2kCpW3fqxTWCSMrTKrTdNAT+LOzFlo+xQJWoq
3ZyyWI71XZu9Qs2fo04sWKaFDgli2A==
=L/AR
-----END PGP SIGNATURE-----

--h/ESpOp+6w4ZSKYi--
