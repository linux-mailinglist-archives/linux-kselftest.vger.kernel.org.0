Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC5171295A
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 17:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244126AbjEZPYL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 11:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244115AbjEZPX5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 11:23:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2447E5E;
        Fri, 26 May 2023 08:23:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0A48650E5;
        Fri, 26 May 2023 15:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6B7C433D2;
        Fri, 26 May 2023 15:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685114619;
        bh=sSJgHGhspOdtf9IZ1Lw+Z6mc2TQf02OhlSH49aYKpf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TgkbPW2CX2koGBwD13BHHB9ycraKbxKDJj124gfbGxpLSf5dZkRE09eYfW56u16fp
         mBZtQ2cwEruSCMHVE/APUDJ/Lt49KSwqxwikIOE/GHGE/Gi9gr7IxD0stinVwOUNiP
         mplAxxjn6h88TxOKI467EUM0nvdESpqO1RBjRP7v9fJshcPggf3tG89akIJTTIQ1Iq
         6UVr8KzKdjej2szrcuaBDW6rRe6HMMsKL7VOIoMPy5GhqLnEM8nWLoCQ6e3eEbx6uc
         +rFVjzydlRhdGMCShhxBgJhKjSzLtV/lnzwMtDlNYJENmR2EvtepFYNaf/yl70KbEh
         kD+vbnE+4oKqA==
Date:   Fri, 26 May 2023 16:23:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.3 07/67] selftests/ftrace: Improve integration
 with kselftest runner
Message-ID: <276d5748-40c4-43b4-9241-9d30a5a64d0e@sirena.org.uk>
References: <20230525183144.1717540-1-sashal@kernel.org>
 <20230525183144.1717540-7-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uFSV+DBTeD1SzadS"
Content-Disposition: inline
In-Reply-To: <20230525183144.1717540-7-sashal@kernel.org>
X-Cookie: A Smith & Wesson beats four aces.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--uFSV+DBTeD1SzadS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 02:30:44PM -0400, Sasha Levin wrote:
> From: Mark Brown <broonie@kernel.org>
>=20
> [ Upstream commit dbcf76390eb9a65d5d0c37b0cd57335218564e37 ]
>=20
> The ftrace selftests do not currently produce KTAP output, they produce a
> custom format much nicer for human consumption. This means that when run =
in
> automated test systems we just get a single result for the suite as a who=
le
> rather than recording results for individual test cases, making it harder
> to look at the test data and masking things like inappropriate skips.

This seems to be very much a new feature rather than a fix?

--uFSV+DBTeD1SzadS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRwzvUACgkQJNaLcl1U
h9D7LggAgOwulEbrQyGLRizOAvifu4pqbEIPNrfraY7R4yMLY92GKTHnomcrhJti
SPWK4+mWzqJBlkgQy7fH8rGSoQB2rBo8RQ1qnWv85nkLiVF5K+uFUJVJKuBVo1k6
X8YMdEzvgBjWuKqCeAYKEsXiGOxm+dxgVm+pLwfnZDt0QDSkAGkLTRIZpps9THCT
UgE5GVCfklHhzT0zqXabEcYMBwc6+uFlXVtLxac5Z0I4ju2BfTHGRAOALdRP/MOM
DKGo804L9VERy35Xs+Yf/eRHfRnI4fQA7UYGYXGel+oAXps1H8InhFWRNDbpju6n
zSAwhu421iD24Eh68Kpmcs54I4SE7Q==
=sfjq
-----END PGP SIGNATURE-----

--uFSV+DBTeD1SzadS--
