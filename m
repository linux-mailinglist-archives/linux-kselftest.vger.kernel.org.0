Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35103756A10
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 19:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjGQRWh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 13:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjGQRWg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 13:22:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9191AC;
        Mon, 17 Jul 2023 10:22:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D74A61018;
        Mon, 17 Jul 2023 17:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6517BC433C8;
        Mon, 17 Jul 2023 17:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689614554;
        bh=rJXSMbXopHvzaOfxutArZHo4YpzR2mCSg0JUfvuSo4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MQkRFGtGNL8T040HYhnYUjPCQxbvFtQ/z6Fi4MkctAqMvaJytUL5Iz0z+URs/jaV0
         +CzsoymzCfwuPz5PwZW/2d2KyapSIeC1rq6CpZ6pkR/RYpjc3MVOFEa+oDaoEAW8oV
         /dQpwIJKlCUof4mK7W+JeksIimG4ixiz8kwpa0FGrNAS4Lt8Kgn4QsKL7Opcpz0T4+
         53p1q2gnLgDcDpC5Nac/Kol2gvBjRqLBRfutheSeNmJZFB6vEac6p0B8FWljCTob1J
         glGfodVUXJ/DPRhBG/SKBXzhuy9TO7QJT66N3N8tynSSptzBd9RsyXMmEKuCBUJIEu
         jpgfzlwv6nNaA==
Date:   Mon, 17 Jul 2023 18:22:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/8] selftests: Line buffer test program's stdout
Message-ID: <180a7944-2b35-4fc4-a1b4-e93b45c52247@sirena.org.uk>
References: <20230717103152.202078-1-ryan.roberts@arm.com>
 <20230717103152.202078-2-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3rH2O9kFg8eWmXkE"
Content-Disposition: inline
In-Reply-To: <20230717103152.202078-2-ryan.roberts@arm.com>
X-Cookie: Not a flying toy.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--3rH2O9kFg8eWmXkE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 17, 2023 at 11:31:45AM +0100, Ryan Roberts wrote:
> The selftests runner pipes the test program's stdout to tap_prefix. The
> presence of the pipe means that the test program sets its stdout to be
> fully buffered (as aposed to line buffered when directly connected to
> the terminal). The block buffering means that there is often content in

Reviewed-by: Mark Brown <broonie@kernel.org>

--3rH2O9kFg8eWmXkE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS1eNQACgkQJNaLcl1U
h9CxrQf/aTBtyZVA84+LhCY4xEOt9mFkBSgx0gaWyZyFJ20HdfstopxPffmapASL
fEM4sEF93ITJ+Zh+p9n940WlZm/0rDBAHxWQW0WX4Gq5qQBWeo5N9n60k4b+sMux
YdW5Q+Iea1lABda8jd2+VXXeNs/O98RuzbxHufDErLtMeXzofynzcoeBXFaNm4/v
JcjbOJrmBEVCsIKJIrtqTAO0Qj3Tadc+9sjmnqCv5b+w/9yjNCF1SL3lK60iBlHr
FELwmtvF/IeZC2SfJjD9Xh69b7qG3qHYXoe4jnppkY7j8HcSqK/twpLGI+CYeR72
cCD5HaYcGabeOJyezTTesdZZhx7j1w==
=9cXt
-----END PGP SIGNATURE-----

--3rH2O9kFg8eWmXkE--
