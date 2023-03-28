Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8AE6CB73D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 08:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjC1Geb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 02:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjC1Gea (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 02:34:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5ABAB;
        Mon, 27 Mar 2023 23:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679985258; x=1711521258;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tiG1v6NfOzPmruzIudxgHxX7Fr23+NkzRWHlkxxT8xc=;
  b=xPl8pOeWj3aTQ06zEc02NONzxbcDns0wE7I8PePYlf1o/8hLjV/7fVQ3
   s0sl+/Ly2VuJTz5EJenofOpd4RL6JOewzLLnIGrnwDOAmWIGMDQnXxfuy
   V4rphg+ZB/CvG1vZyYf6EjO5BytOUs9T/eBHKUPXnolDjN0QbzgKZnak2
   YoyNqOQDO+4QmXsZN5dRx09al0qgFn2VrhYh9xVl0XIt2hJPRQTZRigot
   dFAWwHmfTzYIX6yu2zZYdatewufNX2wFtcElyLhOsaAxAcXNWHzWbuJmL
   uKUCQ1JyVjOZ9XQKLLRx7Pa+vhYa40QFcMn4ZUbsTf9zlpMvUurGQ5wKv
   w==;
X-IronPort-AV: E=Sophos;i="5.98,296,1673938800"; 
   d="asc'?scan'208";a="206622339"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Mar 2023 23:34:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 23:34:16 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 27 Mar 2023 23:34:11 -0700
Date:   Tue, 28 Mar 2023 07:45:28 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Evan Green <evan@rivosinc.com>
CC:     Palmer Dabbelt <palmer@rivosinc.com>, <slewis@rivosinc.com>,
        <vineetg@rivosinc.com>, <heiko@sntech.de>,
        Conor Dooley <conor@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@rivosinc.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Dao Lu <daolu@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jann Horn <jannh@google.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Mark Brown <broonie@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Xu <peterx@redhat.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Randy Dunlap <rdunlap@infradead.org>,
        Samuel Holland <samuel@sholland.org>,
        Shuah Khan <shuah@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v5 0/6] RISC-V Hardware Probing User Interface
Message-ID: <d47020f9-e5a8-4ef3-94bc-6aa6f6b2465c@spud>
References: <20230327163203.2918455-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PnlzjXfdKEpPFvxa"
Content-Disposition: inline
In-Reply-To: <20230327163203.2918455-1-evan@rivosinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--PnlzjXfdKEpPFvxa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 27, 2023 at 09:31:57AM -0700, Evan Green wrote:

Hey Evan,

Patchwork has a rake of complaints about the series unfortunately:
https://patchwork.kernel.org/project/linux-riscv/list/?series=734234

Some of the checkpatch whinging may be spurious, but there's some
definitely valid stuff in there!

> Evan Green (6):
>   RISC-V: Move struct riscv_cpuinfo to new header
>   RISC-V: Add a syscall for HW probing
>   RISC-V: hwprobe: Add support for RISCV_HWPROBE_BASE_BEHAVIOR_IMA
>   RISC-V: hwprobe: Support probing of misaligned access performance
>   selftests: Test the new RISC-V hwprobe interface

>   RISC-V: Add hwprobe vDSO function and data

And this one breaks the build for !MMU kernels unfortunately.

Thanks,
Conor.

--PnlzjXfdKEpPFvxa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCKNAwAKCRB4tDGHoIJi
0oy+AQCM8sPGm+KSyYCi9ckhnMclSSVU3IvS2XeSU1qNcJO+VQD/ZyBX5554srKJ
1RmCuSKrnOwGjERvEz0BeAl13ls1+gk=
=3HNq
-----END PGP SIGNATURE-----

--PnlzjXfdKEpPFvxa--
