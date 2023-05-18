Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C897077AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 03:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjERBw6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 21:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjERBw4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 21:52:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905E6E43;
        Wed, 17 May 2023 18:52:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28BA764BD6;
        Thu, 18 May 2023 01:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0969AC433D2;
        Thu, 18 May 2023 01:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684374754;
        bh=pjtLE8555bztw1J0Al/PR1KoBtn+ImBs40JDlz7is80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JFnYh8Zz+wV5EXMIhPo3LnVldEDYwm94leuR+iw8Ad8NMxt5HOynVPeF7rOUbby9B
         RrBtO97mswYgVodxmH+5JAEEPZY0ZGc7MRDGO7qhs4E+1k68G3QYWtcmNadkvmPsy/
         aqog5QbA8WuZCz06vEW7HMcEB1+l2qe9vOx4JbCQTd0luso9tsnK22hkKb2ojW68oU
         8LPyxErqSAmKhU9pElhwx/IWVjN8FPvfTX7JBxmtg1Fa2AeLqW1hCOgeClj+vMffTN
         38044sJxW+viNIGBjP7slrvQSJEP81+zZpvopwMvoYzzmeV/lUWxx4+b9KanD6Kz+o
         OwcAwzh5BD/zA==
Date:   Thu, 18 May 2023 10:52:31 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: arm64: fp-stress: BUG: KFENCE: memory corruption in
 fpsimd_release_task
Message-ID: <ZGWE36pSRMsIHCCa@finisterre.sirena.org.uk>
References: <CA+G9fYtU7HsV0R0dp4XEH5xXHSJFw8KyDf5VQrLLfMxWfxQkag@mail.gmail.com>
 <2d9a04d8-c09e-49aa-95eb-32b4679f7eba@kili.mountain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rY0voc5PYG++8Gkl"
Content-Disposition: inline
In-Reply-To: <2d9a04d8-c09e-49aa-95eb-32b4679f7eba@kili.mountain>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--rY0voc5PYG++8Gkl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 17, 2023 at 10:30:29PM +0300, Dan Carpenter wrote:

> I don't know this code at all so probably this is dumb...  I don't
> undestand how vec_set_vector_length() ensures that sme_state_size()
> stays in sync with the actual size allocated in sme_alloc()

>    866          vl = find_supported_vector_length(type, vl);

> type is ARM64_VEC_SVE.  I've looked at this function for a while and
> I don't see anything which ensures that "vl" is less than the current
> value.

It could be either ARM64_VEC_SVE or ARM64_VEC_SME.

>    917          task_set_vl(task, type, vl);

> "vl" is set here.  This is fine if we are setting it to a smaller value,
> but if we are setting it to a larger value then I think we need to
> realloc the ->sme_state buffer.

> When we call sme_alloc() it will say the buffer is already allocated
> and just zero out what we need for "vl", but the existing buffer is too
> small.

If we are setting the SVE vector length we do not need to reallocate the
SME state since the size of the data stored in the sme_state buffer is
influenced only by the SME vector length, not the SVE vector length.  We
unconditionally free the SVE state (causing it to be reallocated when
needed) since the size needed for it depends on both vector lengths.

--rY0voc5PYG++8Gkl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRlhN4ACgkQJNaLcl1U
h9DqRwf/X+zviCsIKHpmhoquFCDxBAHtifbeY9wb7j1UxogJFbYb63W1KLOdVX9h
uUTSjLgP3G1TwWgx+MNbcFpJUdANp+ED/6415lmyMYVZiigyYi83JrQWYq83+bnX
uKcvoO78r1sJcj3NUdnhkkzZ/evhtd1Psznv216yAG7/FqaPWW455HlYfb69nqvK
TQxV4sOUeJdn3h4lPMd97aYlwmHbc34lwXHvAShPsn5G/7zRH0/dtF1r1A+CFUwJ
sGK9zUZ2pyRegWb3NCJwu3r2f0FxYUvZrIQuokwUjaKWVq/1pWubTVQUHpebXxF+
NgpH6W6CZg4nWCoS4bEgiqnAYVS2uw==
=uVOX
-----END PGP SIGNATURE-----

--rY0voc5PYG++8Gkl--
