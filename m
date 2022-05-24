Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E4853280A
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 May 2022 12:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbiEXKoB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 May 2022 06:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiEXKoA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 May 2022 06:44:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C76A4F9C6;
        Tue, 24 May 2022 03:43:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB8CB61363;
        Tue, 24 May 2022 10:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88A6C385AA;
        Tue, 24 May 2022 10:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653389037;
        bh=jhPbs8emYF0nXYWVytdztWxnXXYI5JHKopXQu66KTmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ElIrKa2LlJ6gPi7uCCLVLUIZsGQQ3NewLR4VHga7QyZADyrqSvyef3yNEGI6m8iHT
         EEPPFXg/gIWK66dTVAvfEVt3hyZvFH8zk71woB5h5oCWzA8ha8bZE82RW848rKMtJO
         3SO4gYQaRqFBsdc0cHVfRw7w29fT89JvhvQdQaGKYunsVAWgBMaOmiLCg2qMNSZ7O+
         YU9HeQrPCZWDJIPwVYyrynYpF7SuBWOY0+qV+yV3K3FOQ22NIjtV1Tq8n07RoCcOpK
         smElo26GoEGQ2tt24qnhw9Tj+zvC6ZvI5588lkxFfOFAZif/7Fk6yHvlZaQTpHWl4T
         ufE0cnbpBX3cg==
Date:   Tue, 24 May 2022 11:43:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, skhan@linuxfoundation.org,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH] kselftest/arm64: signal: Skip SVE signal test if not
 enough VLs supported
Message-ID: <Yoy26NF4C+XC257z@sirena.org.uk>
References: <20220524103149.2802-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ynI1P3Y53eRc+E0S"
Content-Disposition: inline
In-Reply-To: <20220524103149.2802-1-cristian.marussi@arm.com>
X-Cookie: A man's best friend is his dogma.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--ynI1P3Y53eRc+E0S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 24, 2022 at 11:31:49AM +0100, Cristian Marussi wrote:
> On platform where SVE is supported but there are less than 2 VLs available
> the signal SVE change test should be skipped instead of failing.

Reviewed-by: Mark Brown <broonie@kernel.org>

--ynI1P3Y53eRc+E0S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKMtucACgkQJNaLcl1U
h9DEOgf2L2ciymWK1hIY1vzSZb1GgHb7Ezhg0fijCetczE7exdXVCxuTP8r1E3Ev
C7oGIxGDAjtk0Ma4lcmoHWp9SV/1ENX7MnB4NJxNtW+AtpmywCgFdrrwfyttTz9L
XBtstlZFERvFVaMJOF/yIacHk7t6aPA/ZZb0SqKvtz3DhCMlQLAS4FztIJepd1H1
bRlyVjE94YSZPAnFW5Z7c9Et0jcgzWRENZPz5F+Gjcmh9A1wJxNrnkYZOh9d1bxA
ATmEucMXeTTnvpg6EGrJV7StIRuGPfQXUYJs+XpC/nha/Q9KIoUk6JpAzw/x/iUZ
nXh9CIxmXpdTOs4tNQXvYy47HLV3
=yMTg
-----END PGP SIGNATURE-----

--ynI1P3Y53eRc+E0S--
