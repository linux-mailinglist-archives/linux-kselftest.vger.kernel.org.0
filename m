Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC5E6260E8
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 19:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiKKSMs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 13:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiKKSMi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 13:12:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281AE63BAD;
        Fri, 11 Nov 2022 10:12:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5B51B826C7;
        Fri, 11 Nov 2022 18:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BABC433C1;
        Fri, 11 Nov 2022 18:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668190354;
        bh=8e/RTvJUsWMsttv0bdTCoFlXV86DjbvOcbtUwMf1f7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d3XWKd6thOjnst/9+wq/TS2jqhP2vcPa/JozNYyKQogRn3AdbikTAKpCsXE/FeUJX
         gHh/skBHCQWafH0rJ63En89BRIbccbJWozf6NUdRe+luQ49pO4GNfw3iwDxfsoL4vH
         Gk85xDygOnofj2Fe8jVJs7DDQ0j8nlU4B32MzQC/brSNzQnUgRkjnxp/COsWVingWs
         J/1OiZgZBa+idXbvO0knhX5WFBYHlP/7tFXvRxpjyeAZZ5Nrf95bMxYX8fS/p7ZK9l
         m9I2ZClWXBgp6HnHCpdHumWTVSTTMOZi8+WUovsUMcb5o+1WbOOqfUnKNdxupWZKgs
         8nEDGH6C405cA==
Date:   Fri, 11 Nov 2022 19:12:30 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Stanislav Fomichev <sdf@google.com>
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
Message-ID: <Y26QjqvVTosoCgPT@lore-desk>
References: <tencent_29D7ABD1744417031AA1B52C914B61158E07@qq.com>
 <Y26FgIJLR3nVKjcb@google.com>
 <Y26MSS2twSskZ5J2@lore-desk>
 <CAKH8qBvxZBX7_GQYQzSrZ5j=P3rViyqNq3V3oo5CtEMR9BQepA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RREGnsch0YAdzI4A"
Content-Disposition: inline
In-Reply-To: <CAKH8qBvxZBX7_GQYQzSrZ5j=P3rViyqNq3V3oo5CtEMR9BQepA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--RREGnsch0YAdzI4A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, Nov 11, 2022 at 9:54 AM Lorenzo Bianconi <lorenzo@kernel.org> wro=
te:
> >
> > > On 11/11, Rong Tao wrote:
> > > > From: Rong Tao <rongtao@cestc.cn>
> > >
> > > > commit 472caa69183f("netfilter: nat: un-export nf_nat_used_tuple")
> > > > introduce NF_NAT_MANIP_SRC/DST enum in include/net/netfilter/nf_nat=
=2Eh,
> > > > and commit b06b45e82b59("selftests/bpf: add tests for bpf_ct_set_na=
t_info
> > > > kfunc") use NF_NAT_MANIP_SRC/DST in test_bpf_nf.c. We copy enum
> > > > nf_nat_manip_type to test_bpf_nf.c fix this error.
> > >
> > > > How to reproduce the error:
> > >
> > > >      $ make -C tools/testing/selftests/bpf/
> > > >      ...
> > > >        CLNG-BPF [test_maps] test_bpf_nf.bpf.o
> > > >        error: use of undeclared identifier 'NF_NAT_MANIP_SRC'
> > > >              bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SR=
C);
> > > >                                                             ^
> > > >        error: use of undeclared identifier 'NF_NAT_MANIP_DST'
> > > >              bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DS=
T);
> > > >                                                             ^
> > > >      2 errors generated.
> > >
> > > $ grep NF_NAT_MANIP_SRC
> > > ./tools/testing/selftests/bpf/tools/include/vmlinux.h
> > >         NF_NAT_MANIP_SRC =3D 0,
> > >
> > > Doesn't look like your kernel config compiles netfilter nat modules?
> >
> > yes, in bpf kself-test config (tools/testing/selftests/bpf/config) nf_n=
at
> > is compiled as built-in. This issue occurs just if it is compiled as mo=
dule.
>=20
> Right, but if we unconditionally define this enum, I think you'll
> break the case where it's compiled as a built-in?
> Since at least in my vmlinux.h I have all the defines and this test
> includes vmlinux.h...

yes, it is correct.

>=20
> > Regards,
> > Lorenzo
> >
> > >
> > > > Link: https://lore.kernel.org/lkml/202210280447.STsT1gvq-lkp@intel.=
com/
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Signed-off-by: Rong Tao <rongtao@cestc.cn>
> > > > ---
> > > >   tools/testing/selftests/bpf/progs/test_bpf_nf.c | 5 +++++
> > > >   1 file changed, 5 insertions(+)
> > >
> > > > diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> > > > b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> > > > index 227e85e85dda..307ca166ff34 100644
> > > > --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> > > > +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> > > > @@ -3,6 +3,11 @@
> > > >   #include <bpf/bpf_helpers.h>
> > > >   #include <bpf/bpf_endian.h>
> > >
> > > > +enum nf_nat_manip_type {
> > > > +   NF_NAT_MANIP_SRC,
> > > > +   NF_NAT_MANIP_DST
> > > > +};
> > > > +
> > > >   #define EAFNOSUPPORT 97
> > > >   #define EPROTO 71
> > > >   #define ENONET 64
> > > > --
> > > > 2.31.1
> > >

--RREGnsch0YAdzI4A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY26QjgAKCRA6cBh0uS2t
rHk5AP4qKv4HeJgc4FhLgnxgdpQCBOm8g3Mc5xObRZcWvlHFqAD7BNeUFMwaLLfl
TxvON7agcBk0KFLjb/YFnU10Zk8+GwQ=
=Hrtv
-----END PGP SIGNATURE-----

--RREGnsch0YAdzI4A--
