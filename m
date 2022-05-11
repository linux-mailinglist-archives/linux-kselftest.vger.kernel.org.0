Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC20523355
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 May 2022 14:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242600AbiEKMtC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 May 2022 08:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbiEKMtB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 May 2022 08:49:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC755EBE7
        for <linux-kselftest@vger.kernel.org>; Wed, 11 May 2022 05:49:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F7EEB82359
        for <linux-kselftest@vger.kernel.org>; Wed, 11 May 2022 12:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1EAAC34111;
        Wed, 11 May 2022 12:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652273338;
        bh=W3fAgRtwL3T7fwbJo1Zyo//FFepulalmU4a8/ymD3Zk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tth/nM79dnYACegz3aDvCTG0y8TVgMn9dxaRmToX2BGbaM6uR+3flv/RGD5d7Om5b
         VuFn9OCP7/8aG22TgkUXw70sMYF8Kx8iI7tQfMfiNgudAycedHp3O429/RCNUSdZf1
         ROODalnMN+B72tbhzDTIpT8YOyVju3B+VtMa+/dhUs3v9pMV518Hdf9dwBzuXsR9z/
         uxdgR0NIpzpYfMy2I0vnbGTAf8R9BGSjntW5obc6g62i7X8HakV7QiGdBVxL0+0Tgw
         +XrKL/CvzdORsXkO+tL4nAylnFkMoZwy6+eG+bTyt7qX9RMyRi6/F5Ve5wvVNQomKJ
         ZIQJxP2VlvvKA==
Date:   Wed, 11 May 2022 13:48:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [ARM64] status of MTE selftests?
Message-ID: <YnuwtXBxIEqivZfV@sirena.org.uk>
References: <87wney4svy.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YLvnBR0F3qawMNk+"
Content-Disposition: inline
In-Reply-To: <87wney4svy.fsf@redhat.com>
X-Cookie: Look ere ye leap.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--YLvnBR0F3qawMNk+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 06, 2022 at 04:50:41PM +0200, Cornelia Huck wrote:

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

You need to set bp.dram_metadata.is_enabled=1 as well.

--YLvnBR0F3qawMNk+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ7sLQACgkQJNaLcl1U
h9CICgf7BbOqcgfFYd2rrWaiI6SrvokUojgbPlrbA5xXYhXINBjmN1PnwWMlt8pj
1eKrRRiibH9f/7v4jJIq9iZfL8D78qVvbHQS16UjYxTBEEFHaGLY5VACaSm41pDx
PVIK0fh9otkr3Mg1DQsbYh77qYD9+7sF6yoPNR04w+ybPeOX4oqtMHGbJIwPLeyN
uqtehxihaK7PEdmFPjOzELlMXxCsBODUnlP7aflWjUDm4pjjNxmIzT0ornxVhRhz
BQMtEpSmAddwKnhuP06c94BaEBhr/qz3fc5hcbwFIwj58n/vHMcyvyo/tIn5kLPb
usxtSyZMXeoy3naQAU5VrG9wi5dFKg==
=ZGrr
-----END PGP SIGNATURE-----

--YLvnBR0F3qawMNk+--
