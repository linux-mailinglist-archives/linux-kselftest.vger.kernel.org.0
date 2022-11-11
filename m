Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3D66260B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 18:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbiKKRy0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 12:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiKKRyZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 12:54:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11628DE90;
        Fri, 11 Nov 2022 09:54:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 752B7B826AA;
        Fri, 11 Nov 2022 17:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8536CC433D6;
        Fri, 11 Nov 2022 17:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668189261;
        bh=PKJPaIOgDW5uqG2gedKa2Ua6yA1OebpqOraZ3Ok0JaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ayj0kwZTRWcDBKsLXLi7CimQafyMHSGNuL/1WTYX4Rdh34Y4+6Ghhys7g162ogurE
         UzVezODXJuCq5jby0sWZjjg5TSwvglEVjkyIZr33EyAA2IpEfmyNjyzFAbnDMTTYsc
         wbZ2i8DkidmDfl07LsAVIsvvi005e5YTmmjRcAvhxZ2XBdOppih9TzfLVY64kIwIkl
         51MA+kECriuSr19m0fNiQqTHOP6HOcZyzL1RMJ3XUCw8GW8YUSb2KV7t3Pol/HbctQ
         /CbjEmPYRu/+l40FqtiGMmebGaeHW6C1gaB9Cd9aEAZ0vMWew115wB+pFtW3nwlTVK
         Muplud1IdO+oQ==
Date:   Fri, 11 Nov 2022 18:54:17 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sdf@google.com
Cc:     Rong Tao <rtoax@foxmail.com>, ast@kernel.org,
        Rong Tao <rongtao@cestc.cn>, kernel test robot <lkp@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Daniel Xu <dxu@dxuuu.xyz>,
        "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" 
        <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix error undeclared identifier
 'NF_NAT_MANIP_SRC'
Message-ID: <Y26MSS2twSskZ5J2@lore-desk>
References: <tencent_29D7ABD1744417031AA1B52C914B61158E07@qq.com>
 <Y26FgIJLR3nVKjcb@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="spvS383o4CqWiEAy"
Content-Disposition: inline
In-Reply-To: <Y26FgIJLR3nVKjcb@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--spvS383o4CqWiEAy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 11/11, Rong Tao wrote:
> > From: Rong Tao <rongtao@cestc.cn>
>=20
> > commit 472caa69183f("netfilter: nat: un-export nf_nat_used_tuple")
> > introduce NF_NAT_MANIP_SRC/DST enum in include/net/netfilter/nf_nat.h,
> > and commit b06b45e82b59("selftests/bpf: add tests for bpf_ct_set_nat_in=
fo
> > kfunc") use NF_NAT_MANIP_SRC/DST in test_bpf_nf.c. We copy enum
> > nf_nat_manip_type to test_bpf_nf.c fix this error.
>=20
> > How to reproduce the error:
>=20
> >      $ make -C tools/testing/selftests/bpf/
> >      ...
> >        CLNG-BPF [test_maps] test_bpf_nf.bpf.o
> >        error: use of undeclared identifier 'NF_NAT_MANIP_SRC'
> >              bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
> >                                                             ^
> >        error: use of undeclared identifier 'NF_NAT_MANIP_DST'
> >              bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
> >                                                             ^
> >      2 errors generated.
>=20
> $ grep NF_NAT_MANIP_SRC
> ./tools/testing/selftests/bpf/tools/include/vmlinux.h
>         NF_NAT_MANIP_SRC =3D 0,
>=20
> Doesn't look like your kernel config compiles netfilter nat modules?

yes, in bpf kself-test config (tools/testing/selftests/bpf/config) nf_nat
is compiled as built-in. This issue occurs just if it is compiled as module.

Regards,
Lorenzo

>=20
> > Link: https://lore.kernel.org/lkml/202210280447.STsT1gvq-lkp@intel.com/
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Rong Tao <rongtao@cestc.cn>
> > ---
> >   tools/testing/selftests/bpf/progs/test_bpf_nf.c | 5 +++++
> >   1 file changed, 5 insertions(+)
>=20
> > diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> > b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> > index 227e85e85dda..307ca166ff34 100644
> > --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> > +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> > @@ -3,6 +3,11 @@
> >   #include <bpf/bpf_helpers.h>
> >   #include <bpf/bpf_endian.h>
>=20
> > +enum nf_nat_manip_type {
> > +	NF_NAT_MANIP_SRC,
> > +	NF_NAT_MANIP_DST
> > +};
> > +
> >   #define EAFNOSUPPORT 97
> >   #define EPROTO 71
> >   #define ENONET 64
> > --
> > 2.31.1
>=20

--spvS383o4CqWiEAy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY26MSQAKCRA6cBh0uS2t
rLElAP9pPBWUXclDPJGbSNpyrM4V88sp2TfBB253Ro32lDa5iQD9FgiwFywB44z3
TxNXrDkcdn1g8qBiTzEx2EeRDXP04Ao=
=Q86U
-----END PGP SIGNATURE-----

--spvS383o4CqWiEAy--
