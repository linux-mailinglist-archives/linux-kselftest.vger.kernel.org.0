Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0990062DC00
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 13:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbiKQMxZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 07:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbiKQMxC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 07:53:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E611D58BFA
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Nov 2022 04:53:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 578EA61B9D
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Nov 2022 12:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFC2C433D6;
        Thu, 17 Nov 2022 12:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668689580;
        bh=wAbJ7y1N/MyCusn5aj1cOPNqg5kyfJzQlWfq/rm/+Q8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PBx+/8t5FlfPEL03r9bF4tquhk9AMCdXC8TQPwlIew8kD6QoshEjsK2/KdRaB+ry0
         GYHfRlIvTutC4xndNXz7BaoCyldZXM6lnw1xBEkOjl5oH6V0RQlQFl3n7jRbtav/yL
         XuNsOROOsySTlgB1ZviYwGat/M2FvD7AGyitocsnkEfpKi8yEaU9+W9l5Dl169Z6/F
         ZETX4pe04a6n37boqXjakhtVb482Z6PIi4ZvxTuuqnpx7NZoZS8gc3IWMc8QCyxXfE
         2nmYMPYlX5UglcdR3bFTUtrUHdJfTrFJAcRyPJRNbMN7F+8SqZBa0FSdi9/CMK9RYv
         8N9LUPD7FbtqQ==
Date:   Thu, 17 Nov 2022 12:52:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1] kselftest/arm64: Use preferred form for predicate
 load/stores
Message-ID: <Y3YuniIBdSa02hUr@sirena.org.uk>
References: <20221117114130.687261-1-broonie@kernel.org>
 <Y3YgdloFYx3pQUO0@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5QqIbPyyCJ7unPfh"
Content-Disposition: inline
In-Reply-To: <Y3YgdloFYx3pQUO0@FVFF77S0Q05N>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--5QqIbPyyCJ7unPfh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 17, 2022 at 11:52:22AM +0000, Mark Rutland wrote:
> On Thu, Nov 17, 2022 at 11:41:30AM +0000, Mark Brown wrote:

> > The preferred form of the str/ldr for predicate registers with an immediate
> > of zero is to omit the zero, and the clang built in assembler rejects the
> > zero immediate. Drop the immediate.

> Rejecting that outright seems like a bug in clang, given there are legitimate
> reasons to write code that way (e.g. using asm-offsets style definitions); has
> that been reported so that it can be fixed?

I believe it's been reported, yes.

--5QqIbPyyCJ7unPfh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN2LpgACgkQJNaLcl1U
h9Dpigf+Jhl3Eu1+Aj6FZeF5IJBLuO+6Lrdx1wIS5uSBktFtzUBMRwrUMYP/tqzY
lEvr8YKAbW5pnjBt1auEAS/k+9Qd04yIB1WxT5pG62ZpKb8Hy/m2/REa5AgpRYS7
/22JhbENYfS6qa7xKVYKqiK71lQCB9ysENCcKTgKIN2QFzoaNEgUdx+C4w37AZOZ
diIC/wIE815r2XVSx4g8b/Nrd184a+i1pw4rwEWeMcye0Wcwf9ue5c80zuy4rfDA
T36oCGAgFbsKkvFaRMl1laX4psN4IaoXWJnzLwY78Z5JSWhO7ImQnS2hRVaZP8p1
3rjvzNN42Xb5vv+HWf7dK05u04nnHQ==
=b/q8
-----END PGP SIGNATURE-----

--5QqIbPyyCJ7unPfh--
