Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBAD7742A6
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 19:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjHHRrL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 13:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbjHHRps (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 13:45:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3BE25EFE
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Aug 2023 09:20:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF11A6249C
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Aug 2023 13:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A087C433C9;
        Tue,  8 Aug 2023 13:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691502760;
        bh=4iyLn+x1TmF4WWToJEC2HsGa+X2k94nNgpKP+jyM4f4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ugc3uuKzJeh0JASWcMYsik0xMY5cWseW1BcOG73TXl+3VQ21fB7XTD1PmGXvqdEbx
         TGkSAhJ40zyd8FhylAD2mgOv+Il7YLExqK55diJXmq0KJwbB/5quClhaMXekuD404Y
         LrSPzNTDlbyqwSVUogpShSoRwgFSpgLkuOyP9gGDj30lOhkbqlXOOs6GD4iERS/sei
         L0qEGrU7MIujv81mh/tvaH0ZD0rVuTwCFukE0TXfxffHzqOOZ6FCM1jA01AkqE0TmR
         gzPpfVhTsuTXSZ35N8ZNPhZX9tVm3bQzWYAJywhYIzFyEaA4V9rn7HQP4US7MfsT1Q
         KpGJtQKnzf5KQ==
Date:   Tue, 8 Aug 2023 14:52:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     kristina.martsenko@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, xiexiuqi@huawei.com
Subject: Re: [PATCH v2 0/5] kselftest/arm64: add features check to hwcap test
Message-ID: <770859b2-aa8f-4437-814c-ad995844424b@sirena.org.uk>
References: <20230808134036.668954-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N7V7gCANib/hPHqs"
Content-Disposition: inline
In-Reply-To: <20230808134036.668954-1-zengheng4@huawei.com>
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


--N7V7gCANib/hPHqs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 08, 2023 at 09:40:31PM +0800, Zeng Heng wrote:
> Add new feature checks and provide testing item to support capturing
> SIGBUS exception signal.

Please carry tags from old versions forward if there haven't been
changes that invalidate them:

Reviewed-by: Mark Brown <broonie@kernel.org>

--N7V7gCANib/hPHqs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTSSKIACgkQJNaLcl1U
h9A4VQf/eUVU0fnrDbwOQcdeW9a/F71EnU+FR4eDRpZklvwUGc8XS44KElpdKZYH
5bXZ0wa5duj9nUWSHwFGmWexezi8S9pSi8pcSlaopz+7egja/zKFl86ZdgS513Y/
ajfuNWrlrdy7sI8z52YmlRA31xm0s5X1EF/BNFN0em57hbCsMWDwWz7Fy8ydr51i
dLu8Av1o9Q+o2Lj3n4gVCuHSjEeePV5aCeicWrrfidIbbBYVVfvwKTnEmQsQ9WZ5
Q8MNDp84rZmrX7uu8usRe76BdPVs9M+56sqY2OHn1Nonw4M62yP8TiNJ8ggqUh6m
evd4oEPV8vDA4hWPAkwgc/Bx/A1MHA==
=gjW3
-----END PGP SIGNATURE-----

--N7V7gCANib/hPHqs--
