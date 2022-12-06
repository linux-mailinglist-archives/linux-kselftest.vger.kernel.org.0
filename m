Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04F8644D7A
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Dec 2022 21:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLFUtW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Dec 2022 15:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiLFUtN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Dec 2022 15:49:13 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2D017054;
        Tue,  6 Dec 2022 12:49:07 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NRXZn29C4z4xGR;
        Wed,  7 Dec 2022 07:49:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670359745;
        bh=QsqEJZkBj+bsOZmR3tCA3dJy4vZlG1oR0bu1q4PrRcA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qRIcMQCwDmVZNhlpkWVRJs/nQLMVUAvL9eRaMaYyaMnnf2+sjb8aygYUii4K0LK/X
         auQnVEcuSDIThBsj2lR3GrRhICBC7iGHtyeKOU4frbkn5PldHfiL+A46dMPjpgX4qT
         +evP3xqEwcYK/aLkHWfexqzpprL0bthGEBZ4rXVB2f+crECWef27CNoXrqtK8URWLv
         zB48iTD79pBXqsf40UoedN11VbkE5nSFjElEyml82y9um6pLcpCePX2H1Lfy0R4cIe
         P+DTX/remer6Cnk4osbsipfjTRdAb6TT1oGbTDhijpNIiGUXOP/W5/QL0K3h6LMq3p
         eW247JDsmJILg==
Date:   Wed, 7 Dec 2022 07:49:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>
Subject: Re: [PATCH] KVM: selftests: Fix build due to ucall_uninit() removal
Message-ID: <20221207074904.2f9d04ed@canb.auug.org.au>
In-Reply-To: <20221206181506.252537-1-broonie@kernel.org>
References: <20221206181506.252537-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/u+q73nYgMy+BGDygpKgn=gy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--Sig_/u+q73nYgMy+BGDygpKgn=gy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Tue,  6 Dec 2022 18:15:06 +0000 Mark Brown <broonie@kernel.org> wrote:
>
> Today's -next fails to build on arm64 due to:
>=20
> In file included from include/kvm_util.h:11,
>                  from aarch64/page_fault_test.c:15:
> include/ucall_common.h:36:47: note: expected =E2=80=98vm_paddr_t=E2=80=99=
 {aka =E2=80=98long unsigned int=E2=80=99} but argument is of type =E2=80=
=98void *=E2=80=99
>    36 | void ucall_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa);
>       |                                    ~~~~~~~~~~~^~~~~~~~
> aarch64/page_fault_test.c:725:2: warning: implicit declaration of functio=
n =E2=80=98ucall_uninit=E2=80=99; did you mean =E2=80=98ucall_init=E2=80=99=
? [-Wimplicit-function-declaration]
>   725 |  ucall_uninit(vm);
>       |  ^~~~~~~~~~~~
>       |  ucall_init
>=20
> which is caused by commit
>=20
> interacting poorly with commit
>=20
>    28a65567acb5 ("KVM: selftests: Drop now-unnecessary ucall_uninit()")
>=20
> As is done for other ucall_uninit() users remove the call in the newly ad=
ded
> page_fault_test.c.
>=20
> Fixes: 28a65567acb5 ("KVM: selftests: Drop now-unnecessary ucall_uninit()=
")
> Fixes: 35c581015712 ("KVM: selftests: aarch64: Add aarch64/page_fault_tes=
t")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Ricardo Koller <ricarkol@google.com>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>  tools/testing/selftests/kvm/aarch64/page_fault_test.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/kvm/aarch64/page_fault_test.c b/tool=
s/testing/selftests/kvm/aarch64/page_fault_test.c
> index 05bb6a6369c2..4ef89c57a937 100644
> --- a/tools/testing/selftests/kvm/aarch64/page_fault_test.c
> +++ b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
> @@ -722,7 +722,6 @@ static void run_test(enum vm_guest_mode mode, void *a=
rg)
> =20
>  	vcpu_run_loop(vm, vcpu, test);
> =20
> -	ucall_uninit(vm);
>  	kvm_vm_free(vm);
>  	free_uffd(test, pt_uffd, data_uffd);
> =20
> --=20
> 2.30.2
>=20

Also added to my merge of the kvm-arm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/u+q73nYgMy+BGDygpKgn=gy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOPqsAACgkQAVBC80lX
0Gzv6gf9HsGS9Vbvxo9vuMbxYJqAD20wjHAVefhsKNGFjF8FQp55Qv9m6GHNTbof
Aq6BzMYB4R2R0Ey+EwAXpnIYuaC2oxfjI//BFvOzrPg7KPkAJWYro9G7nzMIJICQ
vNB+5MPf1cbYwIFdb5uQzQ6EzvmnGXBltR9RaARRm8tUSiG2VJi6ZFRcIAt6gBFE
DRCNGknoOu9ede/ovkWzaRA4fXAx2ngmErvqRHiDiEzLULKhpVBHI45RwOGq5KyN
4tQZA99I5faC/i6cFk8AP0reXJj3mIniuyKMAqM+BJjoAmIR18QgFNJv1GI5bYej
TFvYgFqcKbH2lNp3hfHwBvep2I37KQ==
=296z
-----END PGP SIGNATURE-----

--Sig_/u+q73nYgMy+BGDygpKgn=gy--
