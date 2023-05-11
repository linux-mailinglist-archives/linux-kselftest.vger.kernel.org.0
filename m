Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5656FFCCE
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 May 2023 00:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbjEKWsR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 18:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbjEKWsP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 18:48:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06A94496;
        Thu, 11 May 2023 15:48:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67E5D6523A;
        Thu, 11 May 2023 22:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827DEC433EF;
        Thu, 11 May 2023 22:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683845293;
        bh=rOH5f9jhgIQOxgpJ7gvL6+asAZ61e4aqc8BMhuV/e7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GRFgn1kCkG+kTaqkSZD4uqu/lNM4l/xANFvMls4AiGgfWP6ZnvFC5NLld4Vs5Bc0Q
         Uu4spvSUS9LWhPzXYB1XuGUgYaHNSM/cQGzoH6E/C80QvPUs2qH0L8ttSF+/I6aBK1
         J+7JAll49Zrbw52iO6niwiYqQalk42Ut1XNeGHXDWHDW7fHlbntWSoLXpo9hPzlx3P
         4/Yu0CRgDOHw2APPp5u/ayBlkaVHzLrVXYoXRBodIZSggId0JODS8/VXySVL0x3c/Y
         PETM1L0yIurMZgMqbW3LR4iphVQyWfMzeE14/NIPNo51uInGfJiIetfrikF95AukSP
         M9ezDqy0jqLAw==
Date:   Thu, 11 May 2023 23:48:08 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, ajones@ventanamicro.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: kvm: Add KVM_GET_REG_LIST API support
Message-ID: <20230511-leverage-backspin-34bcde885006@spud>
References: <cover.1683791148.git.haibo1.xu@intel.com>
 <921fc2e1a91887170e277acb1b52df57480a5736.1683791148.git.haibo1.xu@intel.com>
 <20230511-boozy-comic-5bc8f297dc8e@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KynvZX22npN01eSI"
Content-Disposition: inline
In-Reply-To: <20230511-boozy-comic-5bc8f297dc8e@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--KynvZX22npN01eSI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2023 at 11:25:41PM +0100, Conor Dooley wrote:
> On Thu, May 11, 2023 at 05:22:48PM +0800, Haibo Xu wrote:
> > KVM_GET_REG_LIST API will return all registers that are available to
> > KVM_GET/SET_ONE_REG APIs. It's very useful to identify some platform
> > regression issue during VM migration.
> >=20
> > Since this API was already supported on arm64, it'd be straightforward
> > to enable it on riscv with similar code structure.
>=20
> Applied on top of v6.4-rc1 this breaks the build :/

I lied, I forgot W=3D1 is enabled for the allmodconfig builds in the
patchwork automation.
The warnings are trivial to fix, so you should fix them anyway!

> warning: Function parameter or member 'vcpu' not described in 'kvm_riscv_=
vcpu_num_regs'
> warning: Function parameter or member 'uindices' not described in 'kvm_ri=
scv_vcpu_copy_reg_indices'
> warning: Function parameter or member 'vcpu' not described in 'kvm_riscv_=
vcpu_copy_reg_indices'
>=20
> You have a bunch of kerneldoc comments (the ones with /**) that are not
> valid kerneldoc. Apparently allmodconfig catches that!
>=20
> Cheers,
> Conor.



--KynvZX22npN01eSI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZF1wpwAKCRB4tDGHoIJi
0oATAQD5EHTulvItTCXcBqe+kpBl82E5bTphHX2ZgHgnjZwK6wD+ID3b1Z7gRijz
qKmRHxrIJcJtYMnnhHq33dgNdML1aAs=
=wPq7
-----END PGP SIGNATURE-----

--KynvZX22npN01eSI--
