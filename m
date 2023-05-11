Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3386FFC9C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 May 2023 00:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238953AbjEKWZt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 18:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjEKWZs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 18:25:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DA33AB7;
        Thu, 11 May 2023 15:25:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D56864FBB;
        Thu, 11 May 2023 22:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72C6C433EF;
        Thu, 11 May 2023 22:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683843947;
        bh=ULMjF1ezqz7St5bBienNvAvCIvE4TfTmf4qQzCY13so=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U1RbWwzc6MezmvlRhRRnsO95dj3YkJq+62PP/cg5FMd8pWxUwNUsLntuUej2yq4KM
         xQNLHGFZ9tGMQyoxW7EKYCTO0HBldYt2xkhCBvjDliCDHJJgeJAzd1f4AjDQhcpG6Q
         ja4az/oPKzw4SHyTdqe6Avn+GWzA/+BGLsX6p/RPX49hIBo0t+owGFffsNTCuBzgJ5
         6dcBeJVOAbm9tPxrqayleNlt8pmVLRJFfEzblYtRBD1SK4PQrho39rOInBII4u8pGa
         yVFJI1Ma76nGq+MaFpAAD/p5ZfIAgeVK54EY6T6OuQboHiQNlqOOHJU2lOCUKK/tbJ
         BYCQbCeuExJzA==
Date:   Thu, 11 May 2023 23:25:41 +0100
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
Message-ID: <20230511-boozy-comic-5bc8f297dc8e@spud>
References: <cover.1683791148.git.haibo1.xu@intel.com>
 <921fc2e1a91887170e277acb1b52df57480a5736.1683791148.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LWGkwE7Vf2rchKRZ"
Content-Disposition: inline
In-Reply-To: <921fc2e1a91887170e277acb1b52df57480a5736.1683791148.git.haibo1.xu@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--LWGkwE7Vf2rchKRZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2023 at 05:22:48PM +0800, Haibo Xu wrote:
> KVM_GET_REG_LIST API will return all registers that are available to
> KVM_GET/SET_ONE_REG APIs. It's very useful to identify some platform
> regression issue during VM migration.
>=20
> Since this API was already supported on arm64, it'd be straightforward
> to enable it on riscv with similar code structure.

Applied on top of v6.4-rc1 this breaks the build :/

warning: Function parameter or member 'vcpu' not described in 'kvm_riscv_vc=
pu_num_regs'
warning: Function parameter or member 'uindices' not described in 'kvm_risc=
v_vcpu_copy_reg_indices'
warning: Function parameter or member 'vcpu' not described in 'kvm_riscv_vc=
pu_copy_reg_indices'

You have a bunch of kerneldoc comments (the ones with /**) that are not
valid kerneldoc. Apparently allmodconfig catches that!

Cheers,
Conor.

--LWGkwE7Vf2rchKRZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZF1rZQAKCRB4tDGHoIJi
0usNAP0Ykfrz+puD2zn8HGUFz+2fk3qtGa/XYSypVrpgWvW7BgD/T7PlZYcevlSv
hezVcWDYRkavqca+yLrT0grdcCTiBgI=
=ARK0
-----END PGP SIGNATURE-----

--LWGkwE7Vf2rchKRZ--
