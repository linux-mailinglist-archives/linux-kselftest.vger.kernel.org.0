Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F48B69EA61
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Feb 2023 23:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjBUWpL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Feb 2023 17:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBUWpK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Feb 2023 17:45:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF8E22DC1;
        Tue, 21 Feb 2023 14:45:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E306B81107;
        Tue, 21 Feb 2023 22:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4174CC433EF;
        Tue, 21 Feb 2023 22:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677019506;
        bh=8SFKrp35fK6Dd8k0lr1dPRUo9rE3AzIz/CciN7T0U1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=utv7piB4pUX7N+bKFbfNKT3h3UFVgz0o9G0aQEt/8KQSoOwMOlTcFHA7SsBLvSzUQ
         6nOTHlhVxnHY90bmwshQtB0qBjfgYlnagq0EmF/EGo2HU1xdMWuPD9NXFU9V4hTRIp
         eRUzQge81LKi7K1/NjbHFSLxu7FKhsgiUwQNcLbcL9+27MYgeX19X7e8bKKC8e7Jen
         zfKXF82FPxfC+lbeNMdZCPLQBAXgANCgKa7TeG0jKsU6pd3BJ2kjJODNoKYCfAu0uF
         SAZ3wV+OwNPdUmEfHJ8rWOm9fEt79o4pTJQfLnEjwsnsr3x9pYas10veF89Z7gUO1E
         aRlFI5uRJVVYg==
Date:   Tue, 21 Feb 2023 22:45:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, heiko@sntech.de,
        Conor Dooley <conor@kernel.org>, slewis@rivosinc.com,
        vineetg@rivosinc.com, Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 6/7] selftests: Test the new RISC-V hwprobe interface
Message-ID: <Y/VJb/Mz4OI09MEr@sirena.org.uk>
References: <20230221190858.3159617-1-evan@rivosinc.com>
 <20230221190858.3159617-7-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3eeBJmjkOCU+EDTd"
Content-Disposition: inline
In-Reply-To: <20230221190858.3159617-7-evan@rivosinc.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--3eeBJmjkOCU+EDTd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 21, 2023 at 11:08:57AM -0800, Evan Green wrote:

> RISC-V, so I've added some infrastructure for those as well.  The build
> stuff looks pretty straight-forward, but there's also  a tiny C library
> to avoid coupling this to any userspace implementation.

It looks like this has been updated to just use the normal system
libc so the changelog isn't accurate any more?

--3eeBJmjkOCU+EDTd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP1SW4ACgkQJNaLcl1U
h9AARQf+J6bTCIZaQ6XTb3NG4YC4SxstK3Mul0hg7r4uTMkxN5HWg3KMkEKSRKvv
iw3J+4GuEAOoqUv9EIZ5tllsIvJMLMxrScHphIMXD3lDOmWZPQPgEbgec6QvpmZD
EXkNIDDhcpqb7kxOwu5S7eObn9nAKYNpV70u75RADCxirW/IbWB2HXNYMKGfztl5
kEQ80Xrxxx8I/eU6PJuohSsOm31e0yJCns9aWDpqtrBdvrCNwgicrVSGVg8s/EP6
WwsiqINdzfgkYcSXfRDCzlpUZxoqIbXx8X89FvjiCGQrgZSChzHec8yRUSElg4gQ
lL30KzIaj3ILRCoh4mrDu06OxKSxng==
=Dcav
-----END PGP SIGNATURE-----

--3eeBJmjkOCU+EDTd--
