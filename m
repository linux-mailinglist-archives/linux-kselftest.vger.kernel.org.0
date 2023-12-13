Return-Path: <linux-kselftest+bounces-1881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3022181238B
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 00:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86EC1F21980
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 23:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D7079E16;
	Wed, 13 Dec 2023 23:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmP/81Xv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A8D113;
	Wed, 13 Dec 2023 15:49:49 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7cb47dc6ab1so259063241.3;
        Wed, 13 Dec 2023 15:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702511389; x=1703116189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUBt6QVbEsgi3lYjojDNS+3Va4EwmYkCnZ9EmvcYyR0=;
        b=dmP/81XvMnxOC7gGNGo93WoelxC12KmeJamXUZ5TAyQT2knq+kWDvHJVoO3QA+uqcG
         fzmLPM0/G47Y2OcwLof8SreKtO6iA0Bc5Fx2YcmpeppUCYrQ7tArVVB4LSqQLFC+sb/H
         zply2MS0z1I7IOrn9X4ykIVSVHRx6KeNHCspdWU3khrNThQrP4RZy6Y0UENaZ14WTriB
         /xLR80rmMBr8SkeAHSJAzaP/3jslCELJEUHV140xrJ2IJVuyOZfeUBaBT0fZdperjPOw
         ugtXcny6yZ+wFV7I7iM8iWQcn2ZVWXdFqV3Fh3kQDg0Q3jg5DKLY1BQ5mnKWme1cPwt3
         MEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702511389; x=1703116189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUBt6QVbEsgi3lYjojDNS+3Va4EwmYkCnZ9EmvcYyR0=;
        b=mVvFvQDtAAHvMEwzxZtcA5n1BHEC/PMjZzL2yctNaPIVdEV0d30c9ROc8K3UbPDcLv
         Z6m4XByfCHLV3R0Ko+tysPwIhUe0lspiWMVXYVRiegBvjzX4M6Afk2pSscPE/D4SXSGx
         36rO9pvqA0itljO0r0wjaaNUhTs5hXzGWcazytZwc5NrM8E8/rp39ePUDww4tjxNdcP2
         jpzPzddw6/SU5++4Z/0CT7j3BgTHVSJuU3TVEjoGLdIeWXWKSWdafevKMlkCcrB50UIS
         hqRipevb45jvTRbPBLPXCKYhN0VV10y8ilMdHxixi306tt6XpHMpGUaP/IvjPwrbx9TO
         qVqA==
X-Gm-Message-State: AOJu0YzTA0xptjCwx1aptwcX1D1Pn0FLRDHPDBd8jJnZQAlbyuupRa1Y
	2ULU5y78fveKaLPguuA95UEEvG1dsdIFwYH/gzw=
X-Google-Smtp-Source: AGHT+IFKGhYT6v511YmGLVnz4aM2iip/Yf+4Vqb83drCUseFfYqammKpsm8ZepWgUlC+Tc48A9tSyqdAL8jupK02G34=
X-Received: by 2002:a05:6102:3ed6:b0:465:e39c:476b with SMTP id
 n22-20020a0561023ed600b00465e39c476bmr7011003vsv.32.1702511388589; Wed, 13
 Dec 2023 15:49:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1702325874.git.dxu@dxuuu.xyz> <8ec1b885d2e13fcd20944cce9edc0340d993d044.1702325874.git.dxu@dxuuu.xyz>
 <CAHsH6GsdqBN638uqUm+8QkP1_45coucSTL7o=D2wFW-gYjPaBw@mail.gmail.com>
 <7yjkfhrwdphtcljq3odv4jc6lucd32wcg277hfsf4ve2jbo7hp@vuqzwbq5nxjw>
 <CAHsH6Gs1vUQnhR_a4qFnAF37Vx=68Do28sfVfFxQ9pVj9jSzjw@mail.gmail.com>
 <qiv464c4y43mo5rih5k6lgzkbpnj6wsrl52hrhgbxeqj45atun@szmqlmnccm52>
 <CAHsH6Gujycb9RBuRk7QHorLe0Q=Np_tb3uboQfp9KmJnegVXvw@mail.gmail.com>
 <fwadmdjjogp4ybfxfpwovnmnn36jigffopijsuqt4ly4vxqghm@ysqhd25mzylp>
 <fecc7tpmbnqxuxqqolm44ggyeomcr3piabsjkv3pgyzlhyonq6@iiaxf34erjzq>
 <CAP01T770poh_63vBC+Heb9ASJ9pDZd1wTDWAgm5KCYHK9GtE1g@mail.gmail.com> <yshbkwaiong7qq2rsgkpvvyvzefnwud5uywbea6ocfxxenzv6s@dn45gdaygaso>
In-Reply-To: <yshbkwaiong7qq2rsgkpvvyvzefnwud5uywbea6ocfxxenzv6s@dn45gdaygaso>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Wed, 13 Dec 2023 15:49:37 -0800
Message-ID: <CAHsH6Gu_c29Nc+cH-s3EeztwScL=A42wi_SuJD=WeYV0mtVxbA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 9/9] bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, daniel@iogearbox.net, davem@davemloft.net, 
	shuah@kernel.org, ast@kernel.org, john.fastabend@gmail.com, kuba@kernel.org, 
	andrii@kernel.org, hawk@kernel.org, steffen.klassert@secunet.com, 
	antony.antony@secunet.com, alexei.starovoitov@gmail.com, 
	yonghong.song@linux.dev, eddyz87@gmail.com, mykolal@fb.com, 
	martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, devel@linux-ipsec.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 3:15=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> On Wed, Dec 13, 2023 at 12:13:51AM +0100, Kumar Kartikeya Dwivedi wrote:
> > On Tue, 12 Dec 2023 at 20:52, Daniel Xu <dxu@dxuuu.xyz> wrote:
> > >
> > > cc Kumar
> > >
> > > On Tue, Dec 12, 2023 at 09:17:02AM -0700, Daniel Xu wrote:
> > > > On Mon, Dec 11, 2023 at 04:25:06PM -0800, Eyal Birger wrote:
> > > > > On Mon, Dec 11, 2023 at 3:49=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz>=
 wrote:
> > > > > >
> > > > > > On Mon, Dec 11, 2023 at 03:13:07PM -0800, Eyal Birger wrote:
> > > > > > > On Mon, Dec 11, 2023 at 2:31=E2=80=AFPM Daniel Xu <dxu@dxuuu.=
xyz> wrote:
> > > > > > > >
> > > > > > > > On Mon, Dec 11, 2023 at 01:39:25PM -0800, Eyal Birger wrote=
:
> > > > > > > > > Hi Daniel,
> > > > > > > > >
> > > > > > > > > Tiny nits below in case you respin this for other reasons=
:
> > > > > > > > >
> > > > > > > > > On Mon, Dec 11, 2023 at 12:20=E2=80=AFPM Daniel Xu <dxu@d=
xuuu.xyz> wrote:
> > > > > > > > > >
> > > > > > > > > > This commit extends test_tunnel selftest to test the ne=
w XDP xfrm state
> > > > > > > > > > lookup kfunc.
> > > > > > > > > >
> > > > > > > > > > Co-developed-by: Antony Antony <antony.antony@secunet.c=
om>
> > > > > > > > > > Signed-off-by: Antony Antony <antony.antony@secunet.com=
>
> > > > > > > > > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > > > > > > > > ---
> > > > > > > > > >  .../selftests/bpf/prog_tests/test_tunnel.c    | 20 +++=
+++--
> > > > > > > > > >  .../selftests/bpf/progs/test_tunnel_kern.c    | 51 +++=
++++++++++++++++
> > > > > > > > > >  2 files changed, 67 insertions(+), 4 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/tools/testing/selftests/bpf/prog_tests/tes=
t_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> > > > > > > > > > index 2d7f8fa82ebd..fc804095d578 100644
> > > > > > > > > > --- a/tools/testing/selftests/bpf/prog_tests/test_tunne=
l.c
> > > > > > > > > > +++ b/tools/testing/selftests/bpf/prog_tests/test_tunne=
l.c
> > > > > > > > > > @@ -278,7 +278,7 @@ static int add_xfrm_tunnel(void)
> > > > > > > > > >         SYS(fail,
> > > > > > > > > >             "ip netns exec at_ns0 "
> > > > > > > > > >                 "ip xfrm state add src %s dst %s proto =
esp "
> > > > > > > > > > -                       "spi %d reqid 1 mode tunnel "
> > > > > > > > > > +                       "spi %d reqid 1 mode tunnel rep=
lay-window 42 "
> > > > > > > > > >                         "auth-trunc 'hmac(sha1)' %s 96 =
enc 'cbc(aes)' %s",
> > > > > > > > > >             IP4_ADDR_VETH0, IP4_ADDR1_VETH1, XFRM_SPI_I=
N_TO_OUT, XFRM_AUTH, XFRM_ENC);
> > > > > > > > > >         SYS(fail,
> > > > > > > > > > @@ -292,7 +292,7 @@ static int add_xfrm_tunnel(void)
> > > > > > > > > >         SYS(fail,
> > > > > > > > > >             "ip netns exec at_ns0 "
> > > > > > > > > >                 "ip xfrm state add src %s dst %s proto =
esp "
> > > > > > > > > > -                       "spi %d reqid 2 mode tunnel "
> > > > > > > > > > +                       "spi %d reqid 2 mode tunnel rep=
lay-window 42 "
> > > > > > > > >
> > > > > > > > > nit: why do you need to set the replay-window in both dir=
ections?
> > > > > > > >
> > > > > > > > No reason - probably just careless here.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >                         "auth-trunc 'hmac(sha1)' %s 96 =
enc 'cbc(aes)' %s",
> > > > > > > > > >             IP4_ADDR1_VETH1, IP4_ADDR_VETH0, XFRM_SPI_O=
UT_TO_IN, XFRM_AUTH, XFRM_ENC);
> > > > > > > > > >         SYS(fail,
> > > > > > > > > > @@ -313,7 +313,7 @@ static int add_xfrm_tunnel(void)
> > > > > > > > > >          */
> > > > > > > > > >         SYS(fail,
> > > > > > > > > >             "ip xfrm state add src %s dst %s proto esp =
"
> > > > > > > > > > -                   "spi %d reqid 1 mode tunnel "
> > > > > > > > > > +                   "spi %d reqid 1 mode tunnel replay-=
window 42 "
> > > > > > > > > >                     "auth-trunc 'hmac(sha1)' %s 96  enc=
 'cbc(aes)' %s",
> > > > > > > > > >             IP4_ADDR_VETH0, IP4_ADDR1_VETH1, XFRM_SPI_I=
N_TO_OUT, XFRM_AUTH, XFRM_ENC);
> > > > > > > > > >         SYS(fail,
> > > > > > > > > > @@ -325,7 +325,7 @@ static int add_xfrm_tunnel(void)
> > > > > > > > > >         /* root -> at_ns0 */
> > > > > > > > > >         SYS(fail,
> > > > > > > > > >             "ip xfrm state add src %s dst %s proto esp =
"
> > > > > > > > > > -                   "spi %d reqid 2 mode tunnel "
> > > > > > > > > > +                   "spi %d reqid 2 mode tunnel replay-=
window 42 "
> > > > > > > > > >                     "auth-trunc 'hmac(sha1)' %s 96  enc=
 'cbc(aes)' %s",
> > > > > > > > > >             IP4_ADDR1_VETH1, IP4_ADDR_VETH0, XFRM_SPI_O=
UT_TO_IN, XFRM_AUTH, XFRM_ENC);
> > > > > > > > > >         SYS(fail,
> > > > > > > > > > @@ -628,8 +628,10 @@ static void test_xfrm_tunnel(void)
> > > > > > > > > >  {
> > > > > > > > > >         DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook,
> > > > > > > > > >                             .attach_point =3D BPF_TC_IN=
GRESS);
> > > > > > > > > > +       LIBBPF_OPTS(bpf_xdp_attach_opts, opts);
> > > > > > > > > >         struct test_tunnel_kern *skel =3D NULL;
> > > > > > > > > >         struct nstoken *nstoken;
> > > > > > > > > > +       int xdp_prog_fd;
> > > > > > > > > >         int tc_prog_fd;
> > > > > > > > > >         int ifindex;
> > > > > > > > > >         int err;
> > > > > > > > > > @@ -654,6 +656,14 @@ static void test_xfrm_tunnel(void)
> > > > > > > > > >         if (attach_tc_prog(&tc_hook, tc_prog_fd, -1))
> > > > > > > > > >                 goto done;
> > > > > > > > > >
> > > > > > > > > > +       /* attach xdp prog to tunnel dev */
> > > > > > > > > > +       xdp_prog_fd =3D bpf_program__fd(skel->progs.xfr=
m_get_state_xdp);
> > > > > > > > > > +       if (!ASSERT_GE(xdp_prog_fd, 0, "bpf_program__fd=
"))
> > > > > > > > > > +               goto done;
> > > > > > > > > > +       err =3D bpf_xdp_attach(ifindex, xdp_prog_fd, XD=
P_FLAGS_REPLACE, &opts);
> > > > > > > > > > +       if (!ASSERT_OK(err, "bpf_xdp_attach"))
> > > > > > > > > > +               goto done;
> > > > > > > > > > +
> > > > > > > > > >         /* ping from at_ns0 namespace test */
> > > > > > > > > >         nstoken =3D open_netns("at_ns0");
> > > > > > > > > >         err =3D test_ping(AF_INET, IP4_ADDR_TUNL_DEV1);
> > > > > > > > > > @@ -667,6 +677,8 @@ static void test_xfrm_tunnel(void)
> > > > > > > > > >                 goto done;
> > > > > > > > > >         if (!ASSERT_EQ(skel->bss->xfrm_remote_ip, 0xac1=
00164, "remote_ip"))
> > > > > > > > > >                 goto done;
> > > > > > > > > > +       if (!ASSERT_EQ(skel->bss->xfrm_replay_window, 4=
2, "replay_window"))
> > > > > > > > > > +               goto done;
> > > > > > > > > >
> > > > > > > > > >  done:
> > > > > > > > > >         delete_xfrm_tunnel();
> > > > > > > > > > diff --git a/tools/testing/selftests/bpf/progs/test_tun=
nel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > > > > > > > index 3a59eb9c34de..c0dd38616562 100644
> > > > > > > > > > --- a/tools/testing/selftests/bpf/progs/test_tunnel_ker=
n.c
> > > > > > > > > > +++ b/tools/testing/selftests/bpf/progs/test_tunnel_ker=
n.c
> > > > > > > > > > @@ -30,6 +30,10 @@ int bpf_skb_set_fou_encap(struct __s=
k_buff *skb_ctx,
> > > > > > > > > >                           struct bpf_fou_encap *encap, =
int type) __ksym;
> > > > > > > > > >  int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
> > > > > > > > > >                           struct bpf_fou_encap *encap) =
__ksym;
> > > > > > > > > > +struct xfrm_state *
> > > > > > > > > > +bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_=
xfrm_state_opts *opts,
> > > > > > > > > > +                      u32 opts__sz) __ksym;
> > > > > > > > > > +void bpf_xdp_xfrm_state_release(struct xfrm_state *x) =
__ksym;
> > > > > > > > > >
> > > > > > > > > >  struct {
> > > > > > > > > >         __uint(type, BPF_MAP_TYPE_ARRAY);
> > > > > > > > > > @@ -950,4 +954,51 @@ int xfrm_get_state(struct __sk_buf=
f *skb)
> > > > > > > > > >         return TC_ACT_OK;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > +volatile int xfrm_replay_window =3D 0;
> > > > > > > > > > +
> > > > > > > > > > +SEC("xdp")
> > > > > > > > > > +int xfrm_get_state_xdp(struct xdp_md *xdp)
> > > > > > > > > > +{
> > > > > > > > > > +       struct bpf_xfrm_state_opts opts =3D {};
> > > > > > > > > > +       struct xfrm_state *x =3D NULL;
> > > > > > > > > > +       struct ip_esp_hdr *esph;
> > > > > > > > > > +       struct bpf_dynptr ptr;
> > > > > > > > > > +       u8 esph_buf[8] =3D {};
> > > > > > > > > > +       u8 iph_buf[20] =3D {};
> > > > > > > > > > +       struct iphdr *iph;
> > > > > > > > > > +       u32 off;
> > > > > > > > > > +
> > > > > > > > > > +       if (bpf_dynptr_from_xdp(xdp, 0, &ptr))
> > > > > > > > > > +               goto out;
> > > > > > > > > > +
> > > > > > > > > > +       off =3D sizeof(struct ethhdr);
> > > > > > > > > > +       iph =3D bpf_dynptr_slice(&ptr, off, iph_buf, si=
zeof(iph_buf));
> > > > > > > > > > +       if (!iph || iph->protocol !=3D IPPROTO_ESP)
> > > > > > > > > > +               goto out;
> > > > > > > > > > +
> > > > > > > > > > +       off +=3D sizeof(struct iphdr);
> > > > > > > > > > +       esph =3D bpf_dynptr_slice(&ptr, off, esph_buf, =
sizeof(esph_buf));
> > > > > > > > > > +       if (!esph)
> > > > > > > > > > +               goto out;
> > > > > > > > > > +
> > > > > > > > > > +       opts.netns_id =3D BPF_F_CURRENT_NETNS;
> > > > > > > > > > +       opts.daddr.a4 =3D iph->daddr;
> > > > > > > > > > +       opts.spi =3D esph->spi;
> > > > > > > > > > +       opts.proto =3D IPPROTO_ESP;
> > > > > > > > > > +       opts.family =3D AF_INET;
> > > > > > > > > > +
> > > > > > > > > > +       x =3D bpf_xdp_get_xfrm_state(xdp, &opts, sizeof=
(opts));
> > > > > > > > > > +       if (!x || opts.error)
> > > > > > > > >
> > > > > > > > > nit: how can opts.error be non zero if x =3D=3D NULL?
> > > > > > > >
> > > > > > > > Ignoring the new -ENOENT case, it can't. Which is why I'm t=
esting that
> > > > > > > > behavior here.
> > > > > > >
> > > > > > > I'm sorry, I don't understand.
> > > > > > >
> > > > > > > AFAICT, regardless of the -ENOENT change, I don't see
> > > > > > > how (!x) is false and (opt.error) is true, and so
> > > > > > > "if (!x || opts.error)" is always equivalent to "if (!x)".
> > > > > > >
> > > > > > > What am I missing?
> > > > > > > Eyal.
> > > > > >
> > > > > > The selftests are tests so my intention was to check edge cases=
 here.
> > > > > > In normal operation it shouldn't be possible that
> > > > > > bpf_xdp_get_xfrm_state() returns non-NULL and also an error. Ma=
ybe
> > > > > > another way of writing this would be:
> > > > > >
> > > > > >         if (!x)
> > > > > >                 goto out;
> > > > > >         assert(opts.error =3D=3D 0);
> > > > >
> > > > > I think this would convey the "edge case testing" notion better.
> > > > >
> > > > > >
> > > > > > If I'm trying to be too clever (or maybe just wrong) or it's po=
intless,
> > > > > > I can remove the `opts.error` condition.
> > > > >
> > > > > At least for me the tests also serve as references as to how the
> > > > > API is expected to be used, so I think it'd be clearer without
> > > > > signaling that opts.error could potentially be nonzero on success=
.
> > > > >
> > > > > An assertion would indeed make that clear.
> > > >
> > > > Sure, sounds good. I will check on the new bpf assert infra.
> > >
> > > Couldn't quite get bpf_assert() working. The following diff:
> > >
> > > diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/t=
ools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > index c0dd38616562..f00dba85ac5d 100644
> > > --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > @@ -8,8 +8,9 @@
> > >   */
> > >  #include "vmlinux.h"
> > >  #include <bpf/bpf_core_read.h>
> > > -#include <bpf/bpf_helpers.h>
> > >  #include <bpf/bpf_endian.h>
> > > +#include <bpf/bpf_helpers.h>
> > > +#include "bpf_experimental.h"
> > >  #include "bpf_kfuncs.h"
> > >  #include "bpf_tracing_net.h"
> > >
> > > @@ -988,8 +989,9 @@ int xfrm_get_state_xdp(struct xdp_md *xdp)
> > >         opts.family =3D AF_INET;
> > >
> > >         x =3D bpf_xdp_get_xfrm_state(xdp, &opts, sizeof(opts));
> > > -       if (!x || opts.error)
> > > +       if (!x)
> > >                 goto out;
> > > +       bpf_assert_with(opts.error =3D=3D 0, XDP_PASS);
> > >
> > >         if (!x->replay_esn)
> > >                 goto out;
> > >
> > > results in:
> > >
> > > 57: (b7) r1 =3D 2                       ; R1_w=3D2 refs=3D5
> > > 58: (85) call bpf_throw#115436
> > > calling kernel function bpf_throw is not allowed
> > >
> >
> > I think this might be because bpf_throw is not registered for use by
> > BPF_PROG_TYPE_XDP. I would simply register the generic_kfunc_set for
> > this program type as well, since it's already done for TC.
>
> Ah yeah, that was it.
>
> >
> > > It looks like the above error comes from verifier.c:fetch_kfunc_meta,
> > > but I can run the exceptions selftests just fine with the same bzImag=
e.
> > > So I'm thinking it's not a kfunc registration or BTF issue.
> > >
> > > Maybe it's cuz I'm holding onto KFUNC_ACQUIRE'd `x`? Not sure.
> > >
> >
> > Yes, even once you enable this, this will fail for now. I am sending
> > out a series later this week that enables bpf_throw with acquired
> > references, but until then may I suggest the following:
> >
> > #define bpf_assert_if(cond) for (int ___i =3D 0, ___j =3D (cond); !(___=
j) \
> > && !___j; bpf_throw(), ___i++)
> >
> > This will allow you to insert some cleanup code with an assertion.
> > Then in my series, I will convert this temporary bpf_assert_if back to
> > the normal bpf_assert.
> >
> > It would look like:
> > bpf_assert_if(opts.error =3D=3D 0) {
> >   // Execute if assertion failed
> >   bpf_xdp_xfrm_state_release(x);
> > }
> >
> > Likewise for bpf_assert_with_if, you get the idea.
>
> I gave it a try and I'm getting this compile error:
>
>         progs/test_tunnel_kern.c:996:2: error: variable '___j' used in lo=
op condition not modified in loop body [-Werror,-Wfor-loop-analysis]
>                 bpf_assert_with_if(opts.error =3D=3D 0, XDP_PASS) {
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         /home/dxu/dev/linux/tools/testing/selftests/bpf/bpf_experimental.=
h:295:38: note: expanded from macro 'bpf_assert_with_if'
>                 for (int ___i =3D 0, ___j =3D (cond); !(___j) && !___j; b=
pf_throw(value), ___i++)
>                                                     ^~~~      ~~~~
>         1 error generated.
>         make: *** [Makefile:618: /home/dxu/dev/linux/tools/testing/selfte=
sts/bpf/test_tunnel_kern.bpf.o] Error 1
>
> Seems like the compiler is being clever.

It looks like ___j is used twice - maybe it was meant to be ___i? i.e.:

   for (int ___i =3D 0, ___j =3D (cond); !(___j) && !___i; bpf_throw(value)=
, ___i++)

Eyal.

