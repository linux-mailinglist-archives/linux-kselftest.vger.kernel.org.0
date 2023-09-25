Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538087ADB80
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 17:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjIYPd1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 11:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjIYPd0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 11:33:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D077CCE;
        Mon, 25 Sep 2023 08:33:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605D0C433C8;
        Mon, 25 Sep 2023 15:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695656000;
        bh=LlQZWb94aVblB834U6IwUKmjry1skklBbOsT2TyvxAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RMqq13vXMBhyLOmi1LtSzfzLW0O7BdcmEjHKNmYJ5V7O+I4jDqD2JmxjirQ4e+3gO
         2B37U9le9l/3NV2eNlAdKm73O5EAtTRwfHA7Gnlmds3uLutLsjSoeUoOezVv4BSibY
         +7X9yzr45tNYY8BOWkEwnOXsQk8DAdanHYl7dgjIDmZZnc+rteFd7CAoSuQw9KQbWQ
         7ElJgyU1paGTIZEXxIRLDW6z7tbXlEJYQpuIyNc5VT4sZKaJJ6KxJeqTyrqgqDbaob
         DM2YswOxsEloaqRHbvO8n9O4beizW9/FyOIRkeXWSDctfTUFgcP878tilySmEkmXC1
         hIV7v1AE0uMDQ==
Date:   Mon, 25 Sep 2023 16:33:15 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/9] KVM RISC-V Conditional Operations
Message-ID: <20230925-gorged-boxer-3804735e2d18@spud>
References: <20230925133859.1735879-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HnRIDq6Cwufm8SDg"
Content-Disposition: inline
In-Reply-To: <20230925133859.1735879-1-apatel@ventanamicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--HnRIDq6Cwufm8SDg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 07:08:50PM +0530, Anup Patel wrote:
> This series extends KVM RISC-V to allow Guest/VM discover and use
> conditional operations related ISA extensions (namely XVentanaCondOps
> and Zicond).
>=20
> To try these patches, use KVMTOOL from riscv_zbx_zicntr_smstateen_condops=
_v1
> branch at: https://github.com/avpatel/kvmtool.git
>=20
> These patches are based upon the latest riscv_kvm_queue and can also be
> found in the riscv_kvm_condops_v2 branch at:
> https://github.com/avpatel/linux.git
>=20
> Changes since v1:
>  - Rebased the series on riscv_kvm_queue
>  - Split PATCH1 and PATCH2 of v1 series into two patches
>  - Added separate test configs for XVentanaCondOps and Zicond in PATCH7
>    of v1 series.
>=20
> Anup Patel (9):
>   dt-bindings: riscv: Add XVentanaCondOps extension entry
>   RISC-V: Detect XVentanaCondOps from ISA string
>   dt-bindings: riscv: Add Zicond extension entry
>   RISC-V: Detect Zicond from ISA string

For these 4:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for splitting it out,
Conor.

--HnRIDq6Cwufm8SDg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRGoOwAKCRB4tDGHoIJi
0r9rAP4nMvXYlok1V/XcbaH47Y3D800gwvZ9PgMg5igQpnlnlAEAqMfjnm+TcNSW
Io17cdSsNsEy4YSDZCN+vp62z3laxQM=
=ppj2
-----END PGP SIGNATURE-----

--HnRIDq6Cwufm8SDg--
