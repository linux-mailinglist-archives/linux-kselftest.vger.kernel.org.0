Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC79B6B672D
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Mar 2023 15:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjCLOf3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Mar 2023 10:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCLOf2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Mar 2023 10:35:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C33431E34;
        Sun, 12 Mar 2023 07:35:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F686B80B74;
        Sun, 12 Mar 2023 14:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCEFC433D2;
        Sun, 12 Mar 2023 14:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678631717;
        bh=FjumaEd5lBdbEo9vAB2lM8nRQNWRaIFGslU/L7zQyJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V1JZOzbwpDRVLPZJp8TzeZo9if42+a9X4XNSDGxbpuCyv8jAx7901ecH1dj20xZyJ
         8Kdz8ognOq+68U1AKKKLmTbxqHGylMOSHhoLJnWDhnMrZC/i24jKmLnyJBX/uWpmKO
         QssDbFc4M9hMkQmScuGGjL1lZX5ufG0/hO/HNqQuVBZ829jcqqTqts0Zqw1nODOx4f
         EVVHOHbR8vQrdA1eb4qNDBSyj7vjvP0snAJa8TFhQeRFSirrR6rfUeE5734xo4oHHc
         IBN3kxIjsWySMhRx8GwEWNLDk99O/yv/knCFRHr2mGs0rh7WASgmHSdMUo6vJNKTSR
         Z6WKump+3RvSQ==
Date:   Sun, 12 Mar 2023 14:35:13 +0000
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
Message-ID: <ZA3jISc0DH+7swbI@sirena.org.uk>
References: <20230308-kvm-arm64-test-mte-regs-v1-1-f92a377e486f@kernel.org>
 <87edpu5klk.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1j3wi4VN8b1yeJc2"
Content-Disposition: inline
In-Reply-To: <87edpu5klk.wl-maz@kernel.org>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--1j3wi4VN8b1yeJc2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 12, 2023 at 10:29:11AM +0000, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> >  static struct vcpu_config *vcpu_configs[] = {
> >  	&vregs_config,
> > @@ -1131,5 +1163,6 @@ static struct vcpu_config *vcpu_configs[] = {
> >  	&sve_pmu_config,
> >  	&pauth_config,
> >  	&pauth_pmu_config,
> > +	&mte_config,
> >  };
> >  static int vcpu_configs_n = ARRAY_SIZE(vcpu_configs);

> Is there any reason why we sidestep the combinations of MTE with PAuth
> and PMU? I know this leads to an exponential set growth, but this is
> the very purpose of this test, and we found bugs related to this in
> the past.

The test is already not bothering with the combinations of SVE
and pointer auth, it appeared that the intent of the test was
only to test specific combinations.  From what's there it looks
more like there's something with PMU interacting specially with
things (it's all X and X+PMU) that needs coverage.  I couldn't
see anything between it and MTE, though I nearly added a MTE+PMU
combination just for the sake of it.  It's one of those areas
where it's hard to determine if there's an intent behind the
implementation choices made or if they're just whatever someone
happened to write and not particularly important or desired.

> A good first step would be to be able to build these combinations
> dynamically, and only then add new sublists to the mix.

That would certainly be a good idea, if we were heading in that
direction I'd also expect negative tests checking that for
example pointer authentication registers don't appear when that's
not enabled.  I'm not sure that it's worth blocking all new
coverage for that though, there is still value in having a bit of
basic coverage even if not all the combinations are covered yet.

The test is also going to want extension for more gracefully
handling registers that appear based on architecture extensions
with no control over their exposure to the guest, potentially
with tie in to handling based on configurable ID registers when
that goes in.  The way this test is written was also part of why
I was wondering if PIE should be configurable.

--1j3wi4VN8b1yeJc2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQN4x4ACgkQJNaLcl1U
h9BC1Qf+PeXvTRiVGWbVVDpsv6dV6cOogE3gY2qfIvo61y3DCKHWs7R/Fvk4+UnZ
SIK9Zr2SK18GFRUiFXY8SuWo9biw8euRztyjNUNkYAxd1RUvQ9JfBryR4x0StJp4
Sgpsu6OK5nVv5vy6YQuIi8jSs733XU3r+m8yHnJy/0yqZMxr+sdBpEz/n/nNQMuQ
OeaLK3ePzQD9hEmSNNHLGwLZrwWIZfaRhj58n2q07UPWri/GS6iBPKPQKvPhqzze
mcDhSmL11cnfL0qKW9acWQWo24ER1ggobOd3GJmP9CcU66dBLFYD+15QU9YkVNrk
wyHZNaMST7FfofgJRnjt0Y715QoLXA==
=0SaC
-----END PGP SIGNATURE-----

--1j3wi4VN8b1yeJc2--
