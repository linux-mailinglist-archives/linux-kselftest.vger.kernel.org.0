Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E3478434E
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Aug 2023 16:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjHVOHi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Aug 2023 10:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236519AbjHVOHh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Aug 2023 10:07:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B77AE7A;
        Tue, 22 Aug 2023 07:07:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E1866205E;
        Tue, 22 Aug 2023 14:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7CDC433C8;
        Tue, 22 Aug 2023 14:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692713131;
        bh=3U3Rd6RqE2N05R7KVqOROMjjsKW6c4W4zLzqCOf9ay4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F2s6UlGCXF+cUbq3M7PeDm9IkcQdEuvUyFC0tSNNxx4pgd4BYjY4y7eNgpLtELI3r
         2rxR4sa03dX7S7fWJszjxkU0O1v+p5yprItIJ0mNJxKNdRgb9OHayLsY/WjajVM0aH
         rsGcAVcpHH7DrEV/U/G6sc+bKozccuD8Iw2JHxLhaSU9TW0PfVJh626FiOdkXkof3J
         9PrenxlbewwZ6jTyn/8LQApnrGQwdWbskKdmkHPpAekP+QZofOY676C9uNcMhn+sJB
         PD1W9W7ZWoCHabqnfnR2SsdwBM8Nq9lzCS4xZLfoOA62rRk7ZkZth3WGSrh0BS9vp3
         hhPi8jdSSyqaQ==
Date:   Tue, 22 Aug 2023 15:05:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Ricardo B. Marliere" <rbmarliere@gmail.com>
Cc:     skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: alsa: make LDLIBS consistent
Message-ID: <2fd85cbe-9909-4200-be38-450d4c57425b@sirena.org.uk>
References: <20230822131544.38152-1-rbmarliere@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YnYJW5zIJUoht6iF"
Content-Disposition: inline
In-Reply-To: <20230822131544.38152-1-rbmarliere@gmail.com>
X-Cookie: MIT:
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--YnYJW5zIJUoht6iF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 22, 2023 at 10:15:45AM -0300, Ricardo B. Marliere wrote:

> In kselftest_deps.sh script, the level 3 parser is broken for the alsa
> subsystem Makefile.

>  CFLAGS += $(shell pkg-config --cflags alsa)
> -LDLIBS += $(shell pkg-config --libs alsa)
> -ifeq ($(LDLIBS),)
> -LDLIBS += -lasound
> +VAR_LDLIBS += $(shell pkg-config --libs alsa)
> +ifeq ($(VAR_LDLIBS),)
> +VAR_LDLIBS += -lasound

This seems like an undocumented bodge for whatever limitation the
checker script has.  If nothing else someone might come along later and
switch back to using the standard variable name, and TBH it does feel
like it'd be better to teach the checker to understand the pkg-config
idiom here.

--YnYJW5zIJUoht6iF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTkwKYACgkQJNaLcl1U
h9C/mAf/dy7AeSeT+7PvbyRWCvx9XCNcPEx+JDgZvbkKkU/DDfSUXKjRAvl0bIlp
TSb4eNOmHbp42ttNfU7tV26sG4o/1zYoNuXBLJiHWAjZtEJQHIPyjieLSOdKRhAr
NxTDSk6Swmq9ja5qCy/2JQxjpafjn2PydtFN5jWnICunvzg9lsqlUT4oe7cUeR7g
j9w+8iGRmmDNt1VMz5YERDNY9QO9IE6bGyWUazjXXEklPEQ8LFxn8JfPnrn6hG3K
J1zVyFhW581rcXKtwFi3lWQGKVpv/B3v3o0Q3pEvqRBpv+NmGlSExhAdxe8btNvD
KhJHx/F806ENSlx9Q0VMpS3SoCvJBA==
=FABK
-----END PGP SIGNATURE-----

--YnYJW5zIJUoht6iF--
