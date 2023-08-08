Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CB3774774
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 21:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjHHTPJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 15:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjHHTOm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 15:14:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA48C1458A
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Aug 2023 09:37:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C650362542
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Aug 2023 12:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687F9C433C7;
        Tue,  8 Aug 2023 12:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691499482;
        bh=v3/qlqeE30vxmg5ij1peV318QeAlN3UEdap7fO4RiRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lZZsCImzCZd9fcCT1rTimMEhp9bwObuITXcD8c35VupduGQY8uVM9oN1Kgd3HoRJk
         mvvgA6beWBceVlRf0GJSv4L0Pra7DrFtIVhgzc9Q74wC5De4IzhKVgffRRdz66FB9v
         jqrNnMDWlyY6InAY+IoyU6m+bWk+e4lU4RXptXPWKvGWENaskAhV3D7679JgSQGcPN
         kPn2bkPekEOoWnZlqEFpN0GvGXB3aplY41GpS+mdWs8vswAR6QaatKuT+I/9U9hR4E
         efr5iF5rVxDliTr3rb7kzEf0kgE6E6rWAoOL1JaI2V8YyUmIvY2/UIB7V1IXSehjga
         ilfPstXkq2K0g==
Date:   Tue, 8 Aug 2023 13:57:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     kristina.martsenko@arm.com, shuah@kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        linux-kselftest@vger.kernel.org, xiexiuqi@huawei.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/5] kselftest/arm64: add features check to hwcap test
Message-ID: <d9d8912b-125b-41fa-9c34-f624b4cc59f7@sirena.org.uk>
References: <20230808061356.2215158-1-zengheng4@huawei.com>
 <20230808061356.2215158-6-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0ZBW3VawUfWDahIx"
Content-Disposition: inline
In-Reply-To: <20230808061356.2215158-6-zengheng4@huawei.com>
X-Cookie: You need not be present to win.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--0ZBW3VawUfWDahIx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 08, 2023 at 02:13:56PM +0800, Zeng Heng wrote:
> Add new feature checks and provide testing item to support capturing
> SIGBUS exception signal.

I've not checked that the specific LSE2 behaviour is sensible but the
integration with the framework looks good.  The manual encoding is not
really important, just a stylistic nit.

Reviewed-by: Mark Brown <broonie@kernel.org>

--0ZBW3VawUfWDahIx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTSO9QACgkQJNaLcl1U
h9BO7wgAhYV5mp+7d+fsY5nk2D+h2rP95692ZikiI0HBcLWydupXVSfcSBjsCfsi
lkr4t1l15Jrmyl+wcOuouGj/Nyk1B9nvGAVBlOrVQqWpazzW9pCZ1/zqTU6xm34O
pzVGLq6Y2VCFlRtIgjDwpCQ3dNeUWfrYfQ33oPzCJ/hkZQdXh/rf22F/EYlJ1lAI
hBirSrUdpGhpLKZ6Pp3Ve65XkD/fXeYSoDC3te/v4wMH9Iz8f2Kx/kSBY8OOdUyr
vUhtl38VqLFfsDkNfNzFHJ+R8dmX0SVSatqVdFKaj2K4oF9Pzzq7esglB6QrCCXX
SLzavDqVdulgNSZKWSztzEt6/nUgMg==
=BcHf
-----END PGP SIGNATURE-----

--0ZBW3VawUfWDahIx--
