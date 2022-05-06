Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D3851DDA5
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 May 2022 18:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443815AbiEFQfw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 May 2022 12:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443807AbiEFQfw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 May 2022 12:35:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCF447043
        for <linux-kselftest@vger.kernel.org>; Fri,  6 May 2022 09:32:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9257261F63
        for <linux-kselftest@vger.kernel.org>; Fri,  6 May 2022 16:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835ADC385A8;
        Fri,  6 May 2022 16:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651854728;
        bh=jSnD0cHZgKQr/BZwlCSFcoI5OOZKJagDpEmOkbvOllc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bt1n0d97NafcxKKjumDtZSPn4SHzOWqXPnl78vT+49eINFnh5BnSgkgK/RNBsY7Qh
         GacasUZWwj9nDUcylkklWagpMVB5vBV+hoMHo7uvSr9jfACzr3UTn/n+iT6/69uykA
         W8wtS9RGMYPWpFfR6tBZRBgk4zed3GHnfuwY/jQvyia1jJsWMLcfX5/oZn8lzHNGr0
         jXy11t9dTPtZFbqrf40Bc36kb6yfYglUifXnIOAHSSpyyQBtBuXMy2jGbQEPrxiowG
         JZvxELZZbBtzxnZW+xNOltLdVo7jIwUecY5JA+DXpop4VTlSxvXtv2vc+P6BS8snb7
         bdhv0aGtOESvg==
Date:   Fri, 6 May 2022 17:32:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [ARM64] status of MTE selftests?
Message-ID: <YnVNADyaft0WkNHu@sirena.org.uk>
References: <87wney4svy.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="px+JFNFucHJ5J4QS"
Content-Disposition: inline
In-Reply-To: <87wney4svy.fsf@redhat.com>
X-Cookie: <Culus-> libc6 is not essential :|
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--px+JFNFucHJ5J4QS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 06, 2022 at 04:50:41PM +0200, Cornelia Huck wrote:

> I'm currently trying to run the MTE selftests on the FVP simulator (Base
> Model)[1], mainly to verify things are sane on the host before wiring up
> the KVM support in QEMU. However, I'm seeing some failures (the non-mte
> tests seemed all fine):

> Are the MTE tests supposed to work on the FVP model? Something broken in
> my config? Anything I can debug?

I would expect them to work, they seemed happy when I was doing
the async mode support IIRC and a quick spin with -next in qemu
everything seems fine, I'm travelling so don't have the
environment for models to hand right now.

> [1] Command line:
> "$MODEL" \
> -C cache_state_modelled=0 \
> -C bp.refcounter.non_arch_start_at_default=1 \
> -C bp.secure_memory=false \
> -C cluster0.has_arm_v8-1=1 \
> -C cluster0.has_arm_v8-2=1 \
> -C cluster0.has_arm_v8-3=1 \
> -C cluster0.has_arm_v8-4=1 \
> -C cluster0.has_arm_v8-5=1 \
> -C cluster0.has_amu=1 \
> -C cluster0.NUM_CORES=4 \
> -C cluster0.memory_tagging_support_level=2 \
> -a "cluster0.*=$AXF" \

> where $AXF contains a kernel at v5.18-rc5-16-g107c948d1d3e[2] and an
> initrd built by mbuto[3] from that level with a slightly tweaked "kselftests"
> profile (adding /dev/shm).

What are you using for EL3 with the model?  Both TF-A and
boot-wrapper are in regular use, TF-A gets *way* more testing
than boot-wrapper which is mostly used by individual developers.

--px+JFNFucHJ5J4QS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ1TYQACgkQJNaLcl1U
h9C4Jgf/UX+N11GgBtM3iud9fb83+ebihZyFyptGvzAXboVY4dHgB5Zaw9YD2NPW
eiJnuFyZA9M5UHBfLpL3jdz2yDv1ue/+0XtXOTldx+dQlGWSDLNRVoFKRchWSvZ7
cfjlmO8BT/qsXR3vv+LhOBOB5FvzSqkw9Hfbgy3g+1oXOcwE7POeJ05cE9ndQUwv
8gkZK3OLWvj16CuSz5xZK3hIgy1k8//LWRV/ji2v1SHWI/HemO+1QnqXeoAAVYfI
S3z9ETC/JXvmUjRi5vtE7Qsac90yFFUDMbhUfL0yyzx2I6fjTAY8pQsE/9M9qvmp
b64rwpn0AxPqe76njNLspx3O6PxgkQ==
=D1dc
-----END PGP SIGNATURE-----

--px+JFNFucHJ5J4QS--
