Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9417D0F0A
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 13:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377081AbjJTLqq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 07:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377036AbjJTLqp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 07:46:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C3A197;
        Fri, 20 Oct 2023 04:46:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57C2C433C8;
        Fri, 20 Oct 2023 11:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697802402;
        bh=wIvPvYWbW2pmWU0x+kky3EU9suVFdd0N9+lKFFOVaIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kmGNTxgnaUckzsNPmJM2xRA2i9Z+TYVuIwy64oRkiAojGoR6rxTtkU2tuAYMsea9P
         ePt56fh8frKJCqUhNpAXFbK24yUTrMVV81mtdp/g/Q11NSGJW6hNICe9EF8R4tqDKK
         Ymf2ALKFylRZL3eSFHoFYR7xH3iQwg4dddKNd/QnYgmncG0/rTCTakqKOOOiMiF70+
         S9Vj+wH3iZbZ7l0vLeGIScUoDiOUm2qBVnjg2wj2lovq4ZUROOEbwvpyxhASfR64SI
         sjn1cB/a/4PHRs8Aqj/xGSKuFBV9Nbfgj5K4dtuwwT60oCQGjJbWHSiTNRavomuFOv
         Zs0iz3QondFWw==
Date:   Fri, 20 Oct 2023 12:46:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Tobias Klauser <tklauser@distanz.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/clone3: Skip new time namespace test when
 unsupported
Message-ID: <bca5db5e-2536-4e3f-8d04-7e0e13203ad6@sirena.org.uk>
References: <20231020-kselftest-clone3-time-ns-v1-1-31a17e072a05@kernel.org>
 <20231019163538.69d494a0af0560a492b5ffb4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qSn9tPxObTSA9+Xo"
Content-Disposition: inline
In-Reply-To: <20231019163538.69d494a0af0560a492b5ffb4@linux-foundation.org>
X-Cookie: teamwork, n.:
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--qSn9tPxObTSA9+Xo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 19, 2023 at 04:35:38PM -0700, Andrew Morton wrote:
> On Fri, 20 Oct 2023 00:08:12 +0100 Mark Brown <broonie@kernel.org> wrote:

> > Use a filter function to skip the time namespace test on systems with
> > !CONFIG_TIME_NS. This reworks a fix originally done by Tiezhu Yang prior
> > to the refactoring in 34dce23f7e40 ("selftests/clone3: Report descriptive
> > test names"). The changelog from their fix explains the issue very clearly:

> I was about to send Tiezhu Yang's fix to Linus.   I'll rebase mm-hotfixes-stable
> to drop that patch, so you own it now!

> Please note that your version lacks an explicit cc:stable, but I suppose the
> stablebots will scoop it up anyway.

I think I was expecting Tiezhu's version to still get sent and then the
two versions to get merged - the refactoring that caused the conflict is
very clearly not stable material.

> > Original-fix-from: Tiezhu Yang <yangtiezhu@loongson.cn>

> "Original-fix-from" isn't a thing.  In fact it seems to be the first
> time this has been used.  Grepping for  "Original-.*:" shows
> all sorts of innovations, including "Based-on-the-original-screenplay-by:".

> I guess Documentation/process/submitting-patches.rst and checkpatch
> lost this fight a long time ago.

Well, they've always been documenting existing practice.

--qSn9tPxObTSA9+Xo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUyaJwACgkQJNaLcl1U
h9BR3Af/Uf7ib9YeIsoiSpGtzNPGw7rRx00YLF141fdedu3LxJFGWXqKsofcpD/7
TbxWppJ/42QTQPvypvpY1QU5BENGr2DdqULp76eR1vnXsl/XLoBd+eZPkQLf8VsJ
1GREd9llwocTaStvT9rNQ4eYk/bEoIe3gT7wIxB22j5rv9Aks3/eSKFIfN4Ymo96
2FqJAmRMn+4HdfYsSAZaQb0iGgWzeRzySBBBY4pe6/yf/ruLoPzPMRGG1WtcH02P
FOwKpkeZAWQDleM4rHEr8btxE8UTW2qCtf6dPFYDGUKRjuD6/Xez6+cXmrm3KXdn
+J8tIlSDB4+aX8C+gNDypuJ2Qy2TgA==
=Rfrq
-----END PGP SIGNATURE-----

--qSn9tPxObTSA9+Xo--
