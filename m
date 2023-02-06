Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9739968C8C2
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 22:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjBFV3E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 16:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBFV3D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 16:29:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DA483C9;
        Mon,  6 Feb 2023 13:28:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E21F6101A;
        Mon,  6 Feb 2023 21:27:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D9CC4339B;
        Mon,  6 Feb 2023 21:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675718850;
        bh=6fIOqeNi3vF8HalHNxYru+WNebNeboOgDccO3l/RKP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CL4ucl87U0F8GbsfXhz7gntr4An+rQhXUAvd484L5VYV6F900jD+fEkljrxTp/v7+
         jINgL2Ex1gR05VKvyORXPTwEb0pYtJ5jNAXruUF1w+t4qmU6akzAIdU4a1CfmbHUC6
         OIc40lE8GEoomm2I6zYH7lezvNHywdlifNZMQe2amWmtEAsQrInrikg17EKMnt1qD9
         75n+V4pRoUNCEeK3LBPZW8BVnmVCtGOpfPWLEtgqUAFKVs+e0q7mS2QHzzlMBx+HoS
         hKKe3qAdZd+JV6/OOicbliyrxFH7P0uZODoyOwaNJ5j1DpA5/6+QbA1vW1wrSH83/s
         zJhw4Ddi+4T0Q==
Date:   Mon, 6 Feb 2023 21:27:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor@kernel.org>, vineetg@rivosinc.com,
        heiko@sntech.de, slewis@rivosinc.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 6/6] selftests: Test the new RISC-V hwprobe interface
Message-ID: <Y+FwvI+xRg7zMhSx@sirena.org.uk>
References: <20230206201455.1790329-1-evan@rivosinc.com>
 <20230206201455.1790329-7-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jIK7x70KbUt5/QNK"
Content-Disposition: inline
In-Reply-To: <20230206201455.1790329-7-evan@rivosinc.com>
X-Cookie: Hope is a waking dream.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--jIK7x70KbUt5/QNK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 06, 2023 at 12:14:55PM -0800, Evan Green wrote:

> +int main(int argc, char **argv)
> +{

> --- /dev/null
> +++ b/tools/testing/selftests/riscv/libc.S

> +.global _start
> +_start:
> +.option push
> +.option norelax
> +	la gp, __global_pointer$
> +.option pop
> +
> +	la sp, stack
> +
> +	la t0, heap
> +	la t1, brk
> +	REG_S t0, 0(t1)
> +
> +	li a0, 0
> +	li a1, 0
> +
> +	call main

This looks like it's just a standard program entry but I don't speak
RISC-V asm so I might be missing something.  If that's the case might it
make sense to use nolibc here?

--jIK7x70KbUt5/QNK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPhcLsACgkQJNaLcl1U
h9AXOAf+KvTREbTPWHZKIdO47p4iBbiY9FSOG3Y7Acvd7aMmaPWWLQU1wRTSig9V
SfnXNrxRcXT7f9eKvDnU7SAYblPQOcEkK5tv6E2OWOY6H8VarpTCKT7rUvfKaV7A
+FKsr/AZsIH27agEvbS4fgCjyFR/MJtyK/PwzpwQ7bYPXQPAo6NVF/vniJj40HP0
5VGzoxXa+2r8AK0fbe3qDEeNcNe5piAGtK9BCUkaADpF3BZ/8qEhmGlM5bA39itb
qvgV/4NJ5VfUfWg+Te8h5j3VUprcPaX4epNacV5HP8lgfr3bO4ms4nl8pAqCGoTK
oPnl54sP9qzvh6fzkZropoE6/ek4AA==
=/PL7
-----END PGP SIGNATURE-----

--jIK7x70KbUt5/QNK--
