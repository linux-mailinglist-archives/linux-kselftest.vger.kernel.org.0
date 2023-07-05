Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730EE748E88
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jul 2023 22:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjGEUAZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jul 2023 16:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjGEUAY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jul 2023 16:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E091CA9;
        Wed,  5 Jul 2023 13:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D524616F9;
        Wed,  5 Jul 2023 20:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CEAC433C8;
        Wed,  5 Jul 2023 20:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688587222;
        bh=RgYgbdXhSlYQN8weRZoRBXRzgMTlKKE50pkJaWLiPNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R+kbhJaftkJQmJpHlFNPOTgXT8LfVU0wL1ZKB38nWPPSUBZctfs16kfrhyHcR/WZq
         n5pSQORPvikhmOG0EFqme5Lbsf579CVjksMXoM0ckK/RGTC4PBPZId/7YVZCqV9IBd
         onEyZpkG9UlvMaUewCTB/wly09rUaxLu4SrzM0EeHfW+e5ntAGOYYYAZSM8/0WE2+u
         uMxezkn50OvQlxUUatfGA9Y6oow7YLbbxKHIXFBLJgVpXonDTNaK8R2OcCT5r6RYmb
         04T0xMIkhGJ5nAJEGKXztVaGaLoveEx3oBG7IF8Ul3vRr9nnoGtvTXH4mjTe7nyuUf
         qmmzXze14M7sA==
Date:   Wed, 5 Jul 2023 21:00:18 +0100
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
Message-ID: <20230705-gloater-relation-29a6080ec87d@spud>
References: <20230705190002.384799-1-charlie@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CH8f+iAqQ0AXuK8P"
Content-Disposition: inline
In-Reply-To: <20230705190002.384799-1-charlie@rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--CH8f+iAqQ0AXuK8P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Charlie,

On Wed, Jul 05, 2023 at 11:59:40AM -0700, Charlie Jenkins wrote:
> Make sv48 the default address space for mmap as some applications
> currently depend on this assumption. Also enable users to select
> desired address space using a non-zero hint address to mmap. Previous
> kernel changes caused Java and other applications to be broken on sv57
> which this patch fixes.
>=20
> Documentation is also added to the RISC-V virtual memory section to expla=
in
> these changes.

I can't find a changelog in any of these patches, nor an explanation for
why this is v3 (or a RESEND). All I can find on the list is a v1. Could
you explain and provide a changelog please?

Cheers,
Conor.

--CH8f+iAqQ0AXuK8P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKXL0QAKCRB4tDGHoIJi
0mSkAP9isKRIaAMcF9iEh5CS2rWMPBczaNg2fqUkVSbIo2jW4wD/UFz0hRhkMWtF
RirBLo291AQ15KrXyMt6MRTbQ7dNtA8=
=YMSS
-----END PGP SIGNATURE-----

--CH8f+iAqQ0AXuK8P--
