Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA638776C93
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 01:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjHIXHU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 19:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjHIXHU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 19:07:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23992D1;
        Wed,  9 Aug 2023 16:07:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5A6B64C11;
        Wed,  9 Aug 2023 23:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06029C433C7;
        Wed,  9 Aug 2023 23:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691622439;
        bh=+dEkcrkOf/6DcgjLocwePkEkWflhZSGJZZSQWzBYHGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tSILKFd8wS38f4oavtvjQ501JfhIpp5IY8YiqwpIe3vNWWZ08fgrD3X4Xfci6uwtr
         kMbEfKDegKeeSmHH6Yvfv/CDRFe7fjTZ52gWWxMoCUw5JbXEr2f0aTuKOZRgQj18Bt
         ZHjAVbcPoXk5wIDMwn3qq4PTXaBS2kkH+5IOlSt6dlrOmcuCKUZ+guEGkg50b3y9rx
         mEG7UOX56dGTRkST1iQaCam1DJGE/6LH5evYbSRi7XvaRHk6UL2rnjO8D5wC9S2vmn
         jo/SI1ihD5LMR50r6zClX0VBmWaOJlhlhZZorMWl9uozgeMLUjiEzd/zKvHG/XoFkn
         RrabOl7AWSTcQ==
Date:   Thu, 10 Aug 2023 00:07:13 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: Re: [PATCH v9 0/4] RISC-V: mm: Make SV48 the default address space
Message-ID: <20230810-endanger-motive-83096266ab26@spud>
References: <20230809015110.3290774-1-charlie@rivosinc.com>
 <20230809-bobbing-unleaded-c3d5e1c57d96@wendy>
 <ZNQXC+UQ+a0s69Bs@ghost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xYlUSbAm7YzipPhu"
Content-Disposition: inline
In-Reply-To: <ZNQXC+UQ+a0s69Bs@ghost>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--xYlUSbAm7YzipPhu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2023 at 03:45:31PM -0700, Charlie Jenkins wrote:
> On Wed, Aug 09, 2023 at 08:42:58AM +0100, Conor Dooley wrote:
> > On Tue, Aug 08, 2023 at 06:51:06PM -0700, Charlie Jenkins wrote:
> > > Make sv48 the default address space for mmap as some applications
> > > currently depend on this assumption. Users can now select a
> > > desired address space using a non-zero hint address to mmap. Previous=
ly,
> > > requesting the default address space from mmap by passing zero as the=
 hint
> > > address would result in using the largest address space possible. Some
> > > applications depend on empty bits in the virtual address space, like =
Go and
> > > Java, so this patch provides more flexibility for application develop=
ers.
> >=20
> > This still does not build:
> > ../fs/binfmt_flat.c:900:30: error: call to undeclared function 'is_comp=
at_task'; ISO C99 and later do not support implicit function declarations [=
-Wimplicit-function-declaration]
> >=20
> > Reproduceable with allmodconfig.
> >=20
> There is some weird interaction with compat.h. Moving the definitions
> in pgtable.h into the #ifndef __ASSEMBLY__ guarded section resolves=20
> the compile error. I will send out another version with this change.

Just be sure to run an allmodconfig build this time before doing so ;)

--xYlUSbAm7YzipPhu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNQcIQAKCRB4tDGHoIJi
0gh4AP0ZHirwBgSAjTZzsYgQWx0puWLpButSxiuoRHlyGjJHRwD8C6jANtDOeMif
IiUgQCa5S8zKtEanNEt/wf4f6auvfgY=
=E3pw
-----END PGP SIGNATURE-----

--xYlUSbAm7YzipPhu--
