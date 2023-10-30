Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC187DC044
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Oct 2023 20:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjJ3TTS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Oct 2023 15:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjJ3TTR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Oct 2023 15:19:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAA8A9
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Oct 2023 12:19:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E832BC433CA;
        Mon, 30 Oct 2023 19:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698693555;
        bh=b1P+xGBpXuHH3zJSQqiq0GgsyhDNe6leXkljzpeIAlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BMcPl2U2tgJLpyMgeBDjJgWP4k8GBaiWI0DNxHn13xzQCNz8CuKgNWw4vMQ74ckUf
         LeWC7Bl+PDJtOCaFWAu00YPCcO6F9GrFmtuD5yb59HS/K5gcoNK5AjG2BsDTsUstj1
         yW4X628WVmSnwyRcsxJ3MXAeyBP3EV4cGnphf4dgiLNJ77M5Uwt6yOXM1r0NtM91hD
         8ih6Ijket7ATjUCMAkq734NINSF+vuNsbKWY58vgmnKg5jUMQNu2leX6zJaB2N0Vqg
         QCm79p7Hu9tN1D1pE9qsMZwq1mUDo6lJHQAosVFzc4F7DT97p76frMkD9oi9T2ozOh
         8U4ovhQfMX19w==
Date:   Mon, 30 Oct 2023 19:19:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        aneesh.kumar@linux.ibm.com, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, maz@kernel.org,
        oliver.upton@linux.dev, shuah@kernel.org, will@kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v2 22/24] kselftest/arm64: parse POE_MAGIC in a signal
 frame
Message-ID: <09c186f6-67b0-45e6-a214-86c3d42f7468@sirena.org.uk>
References: <20231027180850.1068089-1-joey.gouly@arm.com>
 <20231027180850.1068089-23-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MDH1g474pEp7uJzA"
Content-Disposition: inline
In-Reply-To: <20231027180850.1068089-23-joey.gouly@arm.com>
X-Cookie: Boy!  Eucalyptus!
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--MDH1g474pEp7uJzA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 27, 2023 at 07:08:48PM +0100, Joey Gouly wrote:
> Teach the signal frame parsing about the new POE frame, avoids warning when it
> is generated.

Reviewed-by: Mark Brown <broonie@kernel.org>

--MDH1g474pEp7uJzA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVAAawACgkQJNaLcl1U
h9ByXwf/Qipq20s1AGWakFhuHaAODSH+x5GvEWnhqnyGEXYH5CeuHmz42KglMcTH
klBUtq4GsO6pZtfcH26l2oa7M8Vwlqjb1yJlCQCXUr0rss56yeMy5VEc7sP1ncIZ
258KJFkULSFuke6H28g0I2cq9VFBfeXCZQl4z5mwqiUGMfw/os/GBuL/wv94g9Pv
Uy/0GOfecHn3qcZmu18++tocMCmsQIQgn1lKlzjLHDs96JxhUwoiYGD4ljPVt45e
M/TppJ9+pjUHrrPRbV6xh+QwrOnggYtvDfqxKAhTTdHhrbHf/tcf15tvSzBT/kW9
N9tA70bWLOcUApWqgMvnv0IzuxInRg==
=83hu
-----END PGP SIGNATURE-----

--MDH1g474pEp7uJzA--
