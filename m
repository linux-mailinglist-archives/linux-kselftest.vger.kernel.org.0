Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179D54AE083
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 19:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384783AbiBHSQQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 13:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384832AbiBHSQN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 13:16:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8218C03FEDE
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 10:16:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85E2DB81CC3
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 18:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BF2C340EC;
        Tue,  8 Feb 2022 18:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644344165;
        bh=KJZWWIBr3sW8Kb5rjXU/37s3ct4qrj2K1qo54qvll+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PBLtNrP3+6MrSmp1rFOz4ZxEj4sVb24UntKD+o+Ms/kMziG97sTT+nEUXco3SaRfI
         WdjazgWXXKVNW2g1zDq2BLzrqZTKOt986ilvQZR3z6dLCwhYMgGO7sHSVcjti3ofAP
         e71Qji0dlexH047KqPZVdCfTQTwPl5LSQSyu9GrcfHWD2ibQQo+q/C/MwMHFEqK6bD
         Bkv0DLBEkIVoVjmKjcXlmlCmYa5JF2qNX5ly5OXPSpC1BjRX32/kSlUvBPXnTFdKqT
         4FENYp9sEpYUwDzeyUx5BobfQN+mcTv5P2QhdTJwk6P3B1CRk+vPHRsMJ2iO7/xZZr
         pQcl1HhqqO3/A==
Date:   Tue, 8 Feb 2022 18:15:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v11 40/40] kselftest/arm64: Add SME support to syscall
 ABI test
Message-ID: <YgKzXs2Eti+Z2A1+@sirena.org.uk>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-41-broonie@kernel.org>
 <676aa270-7801-9689-7c88-27368f32a532@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xHAM8WaJGIqLV+h1"
Content-Disposition: inline
In-Reply-To: <676aa270-7801-9689-7c88-27368f32a532@linuxfoundation.org>
X-Cookie: This is your fortune.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--xHAM8WaJGIqLV+h1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 07, 2022 at 06:52:06PM -0700, Shuah Khan wrote:
> On 2/7/22 8:21 AM, Mark Brown wrote:

> > +static int check_za(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
> > +		    uint64_t svcr)
> > +{
> > +	size_t reg_size = sme_vl * sme_vl;

> Is there possibilty of size_t overfolow here?

No, if the size of a vector were anywhere near to being able to being
able to do that I think we'd have serious design issues with the ABI -
the size being calculated here is the size of a single register.  The
current architectural maximum vector length is 2048 bits, which would
give a size of 64K for ZA if implemented.

> > +	if (memcmp(za_in, za_out, reg_size) != 0) {
> > +		ksft_print_msg("SME VL %d ZA does not match\n", sme_vl);

> Print the expected value in addition to the sme_val.

This is not comparing the vector length, this is comparing the contents
of the ZA register which may be up to 64K in size.  There are serious
presentational issues with displaying any errors in a useful fashion for
such a large register which IME needs custom display code adding by
whoever is debugging the issue that takes account of what the pattern
being observed is.

> > @@ -265,8 +357,36 @@ static void test_one_syscall(struct syscall_cfg *cfg)
> >   		if (sve_vq != sve_vq_from_vl(sve_vl))
> >   			sve_vq = sve_vq_from_vl(sve_vl);
> > -		ksft_test_result(do_test(cfg, sve_vl),
> > +		ksft_test_result(do_test(cfg, sve_vl, default_sme_vl, 0),
> >   				 "%s SVE VL %d\n", cfg->name, sve_vl);

> Print default_sme_vl as well.

default_sme_vl is just being passed in as a dummy value here since the
function takes a fixed number of arguments, this is testing the case
where SME is not used or enabled and will be run on systems which do not
have SME at all so there won't be any defined vector length for SME.  I
fear that it would cause confusion to display a SME VL here, and
do_test() won't actually pay any attention to that argument in this
case.  We will individually step through all possible combinations of
SVE and SME vector lengths in separate tests.

--xHAM8WaJGIqLV+h1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmICs10ACgkQJNaLcl1U
h9D3SAf/bnbigyFVYyWH3lS3XqC3GTl/eNadt7qOKcC1DwTUYLI/mVM/YW70z1B1
MOUbODr3ubbXGsEg3A8cnjgKmPpoI23VHw3dEXnlwsrBtDoJz/IDMd+gqpYrgq6k
nYe6TTtVV/KT5mMp6+tT5JCHAN0k1hyhh23SasbGSMwB6SbKUel2zER7+caBs6wr
0OJo8CTmOxqZ5eneb9Hkdo3AQl2QnOBCfQFBElMf5Ws3kYkFJHNfhyA4HL2K02HN
gtF3yXqq7kQRR/+iDBVevLURhR0Pkb6WkhPowvCk/dlJUa2Yr8If0fi4bWUs8F/2
jDAwm6CSNBuOGtDosPcE2pfi3m07HA==
=OBgz
-----END PGP SIGNATURE-----

--xHAM8WaJGIqLV+h1--
