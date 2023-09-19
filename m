Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC057A5ADF
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 09:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjISH15 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 03:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjISH15 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 03:27:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F25B100;
        Tue, 19 Sep 2023 00:27:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFC3C433C8;
        Tue, 19 Sep 2023 07:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695108471;
        bh=mzK6crL+VUkpX6w6hXMx4eUQWGf2NhkR2PJIoKzzRO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S/ERXLsV3Xy1yo8dnksIiY6+McHxQxZGbDRAtjIMwY/TZ1/wRekuqbJU1TTpbpigV
         nOc5qi7PuwaejQWULNWNEdNuuIVNQlukDOeqDHrZspEavoLdBgEr86SKnAEIyJKthD
         GCoGOg3uEwzPM+RJLeJO8GSm2BxyNysvvnRq1pLwOnNHR2W8vOP2rDZtMSEI5ps9QS
         NAjDl5HjDOqlFCztueNRQLhvYF/xLO6uvi9zsTQQpIK93VYwtqmd9fKih0HbPH066q
         +Qv0bA/QGthE6LTLsqBppsKtbOZJsVYZ62emEPmcB8d3y29WHOLOJzqVlbigtKAy5i
         XleWtnM189YSw==
Date:   Tue, 19 Sep 2023 08:27:45 +0100
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
Subject: Re: [PATCH 2/7] RISC-V: Detect Zicond from ISA string
Message-ID: <20230919-3a8fcdaa86607d0ff8399132@fedora>
References: <20230919035343.1399389-1-apatel@ventanamicro.com>
 <20230919035343.1399389-3-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CvRVj5A87ghfW3qF"
Content-Disposition: inline
In-Reply-To: <20230919035343.1399389-3-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--CvRVj5A87ghfW3qF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 09:23:38AM +0530, Anup Patel wrote:
> The RISC-V integer conditional (Zicond) operation extension defines
> standard conditional arithmetic and conditional-select/move operations
> which are inspired from the XVentanaCondOps extension. In fact, QEMU
> RISC-V also has support for emulating Zicond extension.
>=20
> Let us detect Zicond extension from ISA string available through
> DT or ACPI.
>=20
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>

Same applies here w.r.t. splitting in two.

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
>  arch/riscv/include/asm/hwcap.h                          | 1 +
>  arch/riscv/kernel/cpufeature.c                          | 1 +
>  3 files changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index cad8ef68eca7..7ea90e2dbc5b 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -225,6 +225,12 @@ properties:
>              ratified in the 20191213 version of the unprivileged ISA
>              specification.
> =20
> +        - const: zicond
> +          description:
> +            The standard Zicond extension for conditional arithmetic and
> +            conditional-select/move operations as ratified in commit 8fb=
6694
> +            ("Update Gemfile") of riscv-zicond.
> +
>          - const: zicsr
>            description: |
>              The standard Zicsr extension for control and status register
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index b7efe9e2fa89..15bafc02ffd4 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -60,6 +60,7 @@
>  #define RISCV_ISA_EXT_ZIHPM		42
>  #define RISCV_ISA_EXT_SMSTATEEN		43
>  #define RISCV_ISA_EXT_XVENTANACONDOPS	44
> +#define RISCV_ISA_EXT_ZICOND		45
> =20
>  #define RISCV_ISA_EXT_MAX		64
> =20
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 3a31d34fe709..49b6551f3347 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -174,6 +174,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>  	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
>  	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
>  	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
> +	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
>  	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
>  	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
>  	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
> --=20
> 2.34.1
>=20

--CvRVj5A87ghfW3qF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQlNbQAKCRB4tDGHoIJi
0sB/AQCkDRgOkSjJzzncOD0fKPsUVygPrBmienPpyGN8TCotZQD/Xu8iLOeByBoU
/C12tvL3YG5xQOT+5JAwKrmczt+L0AI=
=X24a
-----END PGP SIGNATURE-----

--CvRVj5A87ghfW3qF--
