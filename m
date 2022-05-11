Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B46523B78
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 May 2022 19:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243613AbiEKR05 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 May 2022 13:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238659AbiEKR05 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 May 2022 13:26:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D341F61B;
        Wed, 11 May 2022 10:26:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3B3BB82153;
        Wed, 11 May 2022 17:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C776CC34113;
        Wed, 11 May 2022 17:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652290013;
        bh=gsALImJFoR8MPXuVxsTvI4zgkVcN+RW5RzsL2NJ132c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Apycm8zHTXiLRr98CJxDEUgmz9IIOgcp63OPerNpLEcAP1MdHAdv1NI4eCankb1I8
         FxaXYXgOvG1dA2otwVLoIN23FBnRwqRbluyFY0Amw1totaUaftmmIMUB8dAWFAbzdZ
         ru9mD9AvEhD+rJuBLa4jxE6WiRlk7eD4ah483EdgjjBA0rUwaboNfW6H84AYwe4eKb
         iztDPmC1P4xwye8LhcHwVcLiHtkv1NqVsWpAo4BMogfC7KLivESkkf9oolNEZz2awK
         hm3UZfN6/UrA4NhVxqwEIIs6LfFDwj6hg4nHjUdmDOwJeXesgg4HUrAEglfmRTFvML
         Hawkws6DtGSAA==
Date:   Wed, 11 May 2022 18:26:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: bti: force static linking
Message-ID: <Ynvx2KO75wT6QEgw@sirena.org.uk>
References: <20220511172129.2078337-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IweqdPMc2U0S71bH"
Content-Disposition: inline
In-Reply-To: <20220511172129.2078337-1-andre.przywara@arm.com>
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


--IweqdPMc2U0S71bH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 11, 2022 at 06:21:29PM +0100, Andre Przywara wrote:
> The "bti" selftests are built with -nostdlib, which apparently
> automatically creates a statically linked binary, which is what we want
> and need for BTI (to avoid interactions with the dynamic linker).

Reviewed-by: Mark Brown <broonie@kernel.org>

--IweqdPMc2U0S71bH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ78dcACgkQJNaLcl1U
h9DGMwf/ffOfbRykB2NGVNbpMNu1bdcYv8z8n+1/gen4sIiqH+ZINetF3tB7nzs9
YTYT6P7KJO2CSKjFW+oWtkWBNRqBojGhugPPaxCHVB25cap2CgupVlV265NvVCoL
f8YXO5e1M+133BV0NwPnRdMzLjyaIuEC4fI3lzdu8pwh3WHis07gGlMd30TmqC7H
36DO2S3Y6W3RQLueAefpo9mvK/5Chf+eXx2VyOxmMDQYoJUOwMpS9C1B/AUDxdaQ
ULZmED6ah3X5uwuBf75wnr5skRusbM6SlfZcDXLsdKpKuF3kiL1V9zgJCMVEvb2b
UEcfHBiS2Ed+fsTPiQb0yuqmSO+TLQ==
=+85y
-----END PGP SIGNATURE-----

--IweqdPMc2U0S71bH--
