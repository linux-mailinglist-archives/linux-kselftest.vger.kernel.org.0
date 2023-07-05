Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA1E749072
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jul 2023 23:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjGEV7V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jul 2023 17:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjGEV7V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jul 2023 17:59:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DBA198E;
        Wed,  5 Jul 2023 14:59:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB5186176B;
        Wed,  5 Jul 2023 21:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6580C433C7;
        Wed,  5 Jul 2023 21:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688594359;
        bh=qEIycahdSuFpaMds3e9WtkAzIWBozcEdpxs2byPOYUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D+DNIqSYtkd+LV4jJsj6ZgUaSptlci0ak2Sm+xOLLEHOlo+njzgJQKUA3c5zMQAw3
         SdRF1xDtKZyuEEqFNvHICX/ZDxH7CCdnCo9u+JK8kQM4tcTX6kXOcNKCnv7pZeMwmt
         A2KJAsMIqFXs5CX1sUqixtJMe4OM7PLJMKPKM94QtSbZvkmcyWaqolxSz7nUvBMxRg
         FUpqaJ+TZKkNWb9V1JqN4rre1F8z7a7Kfs5f8s98Gh2D/vwV1prYQ/I892GX2mja2v
         w1Apw7iY9SQlq+gcZOifbs0GQiYm/DvNk+j7lmzuQgXVx5FyugMrACNOovVqTNczBF
         5zEzNZe8EWBkQ==
Date:   Wed, 5 Jul 2023 22:59:12 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com
Subject: Re: [RESEND PATCH v3 0/2] RISC-V: mm: Make SV48 the default address
 space
Message-ID: <20230705-antler-nature-4492ebe90c63@spud>
References: <20230705190002.384799-1-charlie@rivosinc.com>
 <20230705-gloater-relation-29a6080ec87d@spud>
 <ZKXXquCXkSdFD837@ghost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LfSAcveqTz6Siyh4"
Content-Disposition: inline
In-Reply-To: <ZKXXquCXkSdFD837@ghost>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--LfSAcveqTz6Siyh4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2023 at 01:50:50PM -0700, Charlie Jenkins wrote:
> On Wed, Jul 05, 2023 at 09:00:18PM +0100, Conor Dooley wrote:
> > Hey Charlie,
> >=20
> > On Wed, Jul 05, 2023 at 11:59:40AM -0700, Charlie Jenkins wrote:
> > > Make sv48 the default address space for mmap as some applications
> > > currently depend on this assumption. Also enable users to select
> > > desired address space using a non-zero hint address to mmap. Previous
> > > kernel changes caused Java and other applications to be broken on sv57
> > > which this patch fixes.
> > >=20
> > > Documentation is also added to the RISC-V virtual memory section to e=
xplain
> > > these changes.
> >=20
> > I can't find a changelog in any of these patches, nor an explanation for
> > why this is v3 (or a RESEND). All I can find on the list is a v1. Could
> > you explain and provide a changelog please?
> >=20
> > Cheers,
> > Conor.
>=20
> I made a series of mistakes due to an incorrect email configuration. I
> knew something was wrong but I didn't know what after I sent out v2. v2
> bumped the default address space from sv39 to sv48. The purpose of v3
> was to remove an erroneous .gitignore I had included in v2 and also
> modify a testcase that was supposed to check the default was sv48 but it
> was still checking for sv39. After sending out v3 I realized what was
> wrong with my configuration, so I decided to mark it as a resend because
> I believe some people did recieve the previous emails.

Ah yes, I remember massive CC list you used first time around that seemed
to trip up infradead's list service. I guess I've finally gotten to the
incoming mail volume that I am starting to not remember things, even
when they were unusual...

Next time you're sending patches, please add the changelog to your
cover, makes life easier for reviewers etc.

Thanks Charlie,
Conor.

--LfSAcveqTz6Siyh4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKXnsAAKCRB4tDGHoIJi
0k+oAQDvJTKzU6XjlcyqJplBSCfBAjHSVCZ/3LKrXVhbsOJ9yAEA4CJHvvobjGub
lihp+LJxJxUlkuRipXEzHEkTRK6fIQM=
=Msdq
-----END PGP SIGNATURE-----

--LfSAcveqTz6Siyh4--
