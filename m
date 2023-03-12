Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF926B6AB0
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Mar 2023 20:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjCLTgB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Mar 2023 15:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCLTgA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Mar 2023 15:36:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491A339CC8;
        Sun, 12 Mar 2023 12:35:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0BA0B80D5C;
        Sun, 12 Mar 2023 19:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0355C433EF;
        Sun, 12 Mar 2023 19:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678649756;
        bh=Vu0VeFs97BU4JOALMNRa8KqBt7uKbnwhF5S6J/1/OWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uqv0EmQCw4I3C/NFaXEfT/hc2siUGMJ1+LD/xcOUd+yXZFZ+m82sfLtjyyFQmPlm5
         oW3+4Ud+od6haim1YSvtXAmwY6GvjzhtXH+AwYnL7nNfSbrwbUGjKBH4QC1sG6tSKp
         6VRsfoi6oLlx3ngPHC8kh0TpFY2AOWiv/MoQHnEzXRG+Nd1MOgBZ7n051q4wfjhBFi
         NfoZ2EqC5Vu4Mi3mP5+6PjHpMUVAzMwi8T5RrpZQ8OjetoFXVq/m3n7/EubU9OuGUa
         Obas5GcM6iPq0bmHYopSHF5vCC2Cqn7K17+9xn+p319OTx5Jfok/gs2fwIeul/4rPD
         69qWaoUkrbKdQ==
Date:   Sun, 12 Mar 2023 19:35:53 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Add coverage of MTE system registers
Message-ID: <ZA4pmVALRVr0NuIU@sirena.org.uk>
References: <20230308-kvm-arm64-test-mte-regs-v1-1-f92a377e486f@kernel.org>
 <87edpu5klk.wl-maz@kernel.org>
 <ZA3jISc0DH+7swbI@sirena.org.uk>
 <87v8j63rr0.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WJHcUvzHOCQ+71Jf"
Content-Disposition: inline
In-Reply-To: <87v8j63rr0.wl-maz@kernel.org>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--WJHcUvzHOCQ+71Jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 12, 2023 at 03:37:39PM +0000, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Sun, Mar 12, 2023 at 10:29:11AM +0000, Marc Zyngier wrote:
> > > Mark Brown <broonie@kernel.org> wrote:

> > combination just for the sake of it.  It's one of those areas
> > where it's hard to determine if there's an intent behind the
> > implementation choices made or if they're just whatever someone
> > happened to write and not particularly important or desired.

> It *is* desired. We've had cases of flags being reset at the wrong
> time and leading to issues that would be detected by this test. The
> PMU stuff is indeed one example, but similar things could happen
> between SVE+MTE, for example.

I take it you mean that the current situation where it's only
covering X and X+PMU cases is not desired and wasn't intentional?

> > > A good first step would be to be able to build these combinations
> > > dynamically, and only then add new sublists to the mix.

> > That would certainly be a good idea, if we were heading in that
> > direction I'd also expect negative tests checking that for
> > example pointer authentication registers don't appear when that's
> > not enabled.  I'm not sure that it's worth blocking all new
> > coverage for that though, there is still value in having a bit of
> > basic coverage even if not all the combinations are covered yet.

> Then where is the incentive to get it fixed? People will just keep
> piling stuff, and the coverage will increasingly become worse.

It's always possible someone will be interested and keep plugging
away at improving things over the longer term even without having
other work blocked.  Sometimes someone will come along explicitly
trying to improve whatever the thing is, or someone other than
the person submitting a given patch might see the idea being
mentioned and be inspired to implement it (that process is how we
ended up with the ALSA pcm-test program).

The flip side of this approach is that it's encouraging people to
do the minimum possible in order to reduce the chances that out
of scope cleanup work gets added on to whatever they were
originally trying to do, and to avoid doing smaller cleanups if
they notice anything else that could be improved (especially if
those things might resuling in something that'd tie up something
more urgent).  It's not a big deal if it's a small bit of extra
work, but the more work it is than the original thing the more of
an impact it can have.

It's a balancing thing - sometimes things do need some push to
get things done, but on the other hand if it's the only approach
taken then it can become a bit of a self fulfilling prophecy.

> We have to do it as some point, and now is as good a time as any.

Well, I was just doing a drive by patch here because I noticed
that MTE wasn't covered, it's not like I'm even looking at MTE.
Realistically I'm not sure how long it'll be before I have the
bandwidth for reworking this.  There is some other work where I'd
get blocked on it, but it's not going to be this release cycle.

--WJHcUvzHOCQ+71Jf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQOKZYACgkQJNaLcl1U
h9Bx0Af+MhNB5JQvjPLOVR3tG0fmoNBj4n8e6CcKQBWTemQQkp4z2DGozdSNTHvi
xw1L/yMB5t+FAsAliuqLbgzjekR+SIo96YtTa0KO8l55TZwjQyYud5+G9lFZPhK1
eSmfyVY2uTTNdDNWlh7fdL1XTQepdhMpl0k11VJLzi4XoNJ3CEdTWLuoWrfu1mNE
Jd/qJgkmfmPX2NU2+kRy7vNyhtegDtboo/2Gw61tJGnfHmo1xc5F/Gdgq9e9Dnq3
sT7mqsORU2J4Mi5pye94xwVuHR7cNqmrxM23LomwbQJBwnnNilcD/rYN1Frp+hHk
Q9mSQpAOQ8QMOl9F+7WFak13mID1yw==
=AhwS
-----END PGP SIGNATURE-----

--WJHcUvzHOCQ+71Jf--
