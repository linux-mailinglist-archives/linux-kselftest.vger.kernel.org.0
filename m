Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76D57B0738
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 16:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjI0Opg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 10:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjI0Opf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 10:45:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ABAF4;
        Wed, 27 Sep 2023 07:45:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4E7C433C8;
        Wed, 27 Sep 2023 14:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695825933;
        bh=u5mSK+ETqJiKORZJywzslvagA7g/tSjSxUTNQ6vOmcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S7rMseEE9HGEpW+317qdYZUAuRIVkN72nhW/YDjgrNoY+f/EpZ31mTeCmKgCbLV1F
         4zX5Mhm7n3HumvTTiJGm9fgQckcOw6lEg6W7ns2XTshG2VSkAR8fgREeYBgmOOZOme
         T19mfTu1SGJS/hE0pfDZU4kbfCKNVSFGPhMLghB0kvaqhM8ZOGspji6+IoRlXpV0kS
         NGuOYyK+bPo5UNf0JpWoZw1nxS5cYihIWATMpx+tv59rl7Qsimjw5ypD1haDdrl/Mz
         +rLlQ6tcbrHpsZ1Lp1nXc/KY+jHuWWfzw6ZbzWRDRm4grJhGVoZ3xJx3BrvqOBNhC/
         IdVvZtUfNHigA==
Date:   Wed, 27 Sep 2023 15:45:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
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
Message-ID: <20230927-snowcap-stadium-2f6aeffac59e@spud>
References: <20230925133859.1735879-1-apatel@ventanamicro.com>
 <20230925-gorged-boxer-3804735e2d18@spud>
 <20230925-reappear-unkind-7f31acdd82de@spud>
 <CAK9=C2UBgNWFTdQKt29+bNnWDgHZGd5fU+oP1bqsarkqc5+jgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iiRtwGBozE76B1Lv"
Content-Disposition: inline
In-Reply-To: <CAK9=C2UBgNWFTdQKt29+bNnWDgHZGd5fU+oP1bqsarkqc5+jgg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--iiRtwGBozE76B1Lv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 07:54:49PM +0530, Anup Patel wrote:
> On Mon, Sep 25, 2023 at 9:07=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Mon, Sep 25, 2023 at 04:33:15PM +0100, Conor Dooley wrote:
> > > On Mon, Sep 25, 2023 at 07:08:50PM +0530, Anup Patel wrote:
> > > > This series extends KVM RISC-V to allow Guest/VM discover and use
> > > > conditional operations related ISA extensions (namely XVentanaCondO=
ps
> > > > and Zicond).
> > > >
> > > > To try these patches, use KVMTOOL from riscv_zbx_zicntr_smstateen_c=
ondops_v1
> > > > branch at: https://github.com/avpatel/kvmtool.git
> > > >
> > > > These patches are based upon the latest riscv_kvm_queue and can als=
o be
> > > > found in the riscv_kvm_condops_v2 branch at:
> > > > https://github.com/avpatel/linux.git
> > > >
> > > > Changes since v1:
> > > >  - Rebased the series on riscv_kvm_queue
> > > >  - Split PATCH1 and PATCH2 of v1 series into two patches
> > > >  - Added separate test configs for XVentanaCondOps and Zicond in PA=
TCH7
> > > >    of v1 series.
> > > >
> > > > Anup Patel (9):
> > > >   dt-bindings: riscv: Add XVentanaCondOps extension entry
> > > >   RISC-V: Detect XVentanaCondOps from ISA string
> > > >   dt-bindings: riscv: Add Zicond extension entry
> > > >   RISC-V: Detect Zicond from ISA string
> > >
> > > For these 4:
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >
> > Actually, now that I think of it, I'm going to temporarily un-review th=
is.
> > From patch-acceptance.rst:
> > | Additionally, the RISC-V specification allows implementers to create
> > | their own custom extensions.  These custom extensions aren't required
> > | to go through any review or ratification process by the RISC-V
> > | Foundation.  To avoid the maintenance complexity and potential
> > | performance impact of adding kernel code for implementor-specific
> > | RISC-V extensions, we'll only consider patches for extensions that ei=
ther:
> > |
> > | - Have been officially frozen or ratified by the RISC-V Foundation, or
> > | - Have been implemented in hardware that is widely available, per sta=
ndard
> > |   Linux practice.
> >
> > The xventanacondops bits don't qualify under the first entry, and I
> > don't think they qualify under the second yet. Am I wrong?
>=20
> The Ventana Veyron V1 was announced in Dec 2022 at RISC-V summit
> followed by press releases:
> https://www.ventanamicro.com/ventana-introduces-veyron-worlds-first-data-=
center-class-risc-v-cpu-product-family/
> https://www.embedded.com/ventana-reveals-risc-v-cpu-compute-chiplet-for-d=
ata-center/
> https://www.prnewswire.com/news-releases/ventana-introduces-veyron-worlds=
-first-data-center-class-risc-v-cpu-product-family-301700985.html
>=20
> @Palmer if the above looks good to you then please ack PATCH1-to-4

These are announcements AFAICT & not an indication of "being implemented
in hardware that is widely available".

--iiRtwGBozE76B1Lv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRRACAAKCRB4tDGHoIJi
0qQEAQDTNOG4ag8LjtNZMYFOnkSFGHrw50GOrUOnnHOGQ9gTaAEA4l7aRLFtSW8o
WiJV1zWNZaMssu0BppMJh3/v3IudAw4=
=xlPj
-----END PGP SIGNATURE-----

--iiRtwGBozE76B1Lv--
