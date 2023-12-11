Return-Path: <linux-kselftest+bounces-1630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E39580DF45
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 00:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B631C214F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 23:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3775647C;
	Mon, 11 Dec 2023 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2BaB0nX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510D6CD;
	Mon, 11 Dec 2023 15:13:20 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-590bb31ccf5so1666215eaf.3;
        Mon, 11 Dec 2023 15:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702336399; x=1702941199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xubElgI4Z56aixIPByeWysvBwAoYQd2kSEQW2+R/bzE=;
        b=m2BaB0nX9CcWyDNId/hrYcLMRpPGJurHtazB4F8WRzEpB6f8aXwxQSyk6gAGMik6LG
         VxgvZ5Lg8j0qQ3Gc5oWoozsqza67RAHkadQBBsy/Zlf6Oq5HZ/PwZU0uBGXGP2FNWuE6
         wbA04uKRktB5t8w6sPp9epFKmPTXib299XDAMbBRkeO8IvBx0FdHNesPwg8zbDoQjHDV
         lvGzrZZxTE7VwEkXeamz6R20p0hiOibl1icPP4QhLg0CrxoZ8Up/zVDYxlGBovs7WkiA
         RJrDBMvkrkd+JGDHeF3VtVPPfU7FjEQvQsy4TaPC2ZuyJkrSHrKYnHpFHDYD+PQVTbll
         ES5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702336399; x=1702941199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xubElgI4Z56aixIPByeWysvBwAoYQd2kSEQW2+R/bzE=;
        b=H8fpWQvMRsRks9i41VDq5OjqXTLlhT4s+DrXppCpagT+LzsQ2N760jL+i4jFYXnLn+
         rO6KwlM+3vgXuY01qck2te3b8662fgSc7HErDSaiSc/C7NedonsJHGVQdCVvY++YY9mE
         OE8OcdlCN/g5Ln7cfzbWsVvjv30T0j2URQM9PPpcy0VnHmYkqhsy7ICNEbLgT4ocgVWI
         SnGiOez0vhkDWfFWvZk/QcXbfRQ1Wu41VRSCW9W1iXpr+utr7d911RyIqXFrohkb6c10
         yZKhi7T7PjqB+kXZqcHFFOfmE0chufmpVbsStCJFIiuNH2T8tGa0AYkIoWqjjEpx3jLF
         ZrjA==
X-Gm-Message-State: AOJu0YyL2+2nHiOzpcAcZXYa1UxFSHfFAPMIaVpcML3hnvYWILZHLCoo
	EUNSlj5a3lL+kdM30P+AMLYAg+lDKJlxr6lTGxA=
X-Google-Smtp-Source: AGHT+IHdPeLx0zfH/6+KNsgpXh0zWHoT8Dqe3uFCxj/4RnAWzc8/3vZC2f0d6d0EWMBgLZoVh86YLlH/joKhYG7Yjpg=
X-Received: by 2002:a4a:5507:0:b0:591:203b:c1d6 with SMTP id
 e7-20020a4a5507000000b00591203bc1d6mr977454oob.15.1702336399455; Mon, 11 Dec
 2023 15:13:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1702325874.git.dxu@dxuuu.xyz> <8ec1b885d2e13fcd20944cce9edc0340d993d044.1702325874.git.dxu@dxuuu.xyz>
 <CAHsH6GsdqBN638uqUm+8QkP1_45coucSTL7o=D2wFW-gYjPaBw@mail.gmail.com> <7yjkfhrwdphtcljq3odv4jc6lucd32wcg277hfsf4ve2jbo7hp@vuqzwbq5nxjw>
In-Reply-To: <7yjkfhrwdphtcljq3odv4jc6lucd32wcg277hfsf4ve2jbo7hp@vuqzwbq5nxjw>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Mon, 11 Dec 2023 15:13:07 -0800
Message-ID: <CAHsH6Gs1vUQnhR_a4qFnAF37Vx=68Do28sfVfFxQ9pVj9jSzjw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 9/9] bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: daniel@iogearbox.net, davem@davemloft.net, shuah@kernel.org, 
	ast@kernel.org, john.fastabend@gmail.com, kuba@kernel.org, andrii@kernel.org, 
	hawk@kernel.org, steffen.klassert@secunet.com, antony.antony@secunet.com, 
	alexei.starovoitov@gmail.com, yonghong.song@linux.dev, eddyz87@gmail.com, 
	mykolal@fb.com, martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, devel@linux-ipsec.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 2:31=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> On Mon, Dec 11, 2023 at 01:39:25PM -0800, Eyal Birger wrote:
> > Hi Daniel,
> >
> > Tiny nits below in case you respin this for other reasons:
> >
> > On Mon, Dec 11, 2023 at 12:20=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrot=
e:
> > >
> > > This commit extends test_tunnel selftest to test the new XDP xfrm sta=
te
> > > lookup kfunc.
> > >
> > > Co-developed-by: Antony Antony <antony.antony@secunet.com>
> > > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > ---
> > >  .../selftests/bpf/prog_tests/test_tunnel.c    | 20 ++++++--
> > >  .../selftests/bpf/progs/test_tunnel_kern.c    | 51 +++++++++++++++++=
++
> > >  2 files changed, 67 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/t=
ools/testing/selftests/bpf/prog_tests/test_tunnel.c
> > > index 2d7f8fa82ebd..fc804095d578 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> > > @@ -278,7 +278,7 @@ static int add_xfrm_tunnel(void)
> > >         SYS(fail,
> > >             "ip netns exec at_ns0 "
> > >                 "ip xfrm state add src %s dst %s proto esp "
> > > -                       "spi %d reqid 1 mode tunnel "
> > > +                       "spi %d reqid 1 mode tunnel replay-window 42 =
"
> > >                         "auth-trunc 'hmac(sha1)' %s 96 enc 'cbc(aes)'=
 %s",
> > >             IP4_ADDR_VETH0, IP4_ADDR1_VETH1, XFRM_SPI_IN_TO_OUT, XFRM=
_AUTH, XFRM_ENC);
> > >         SYS(fail,
> > > @@ -292,7 +292,7 @@ static int add_xfrm_tunnel(void)
> > >         SYS(fail,
> > >             "ip netns exec at_ns0 "
> > >                 "ip xfrm state add src %s dst %s proto esp "
> > > -                       "spi %d reqid 2 mode tunnel "
> > > +                       "spi %d reqid 2 mode tunnel replay-window 42 =
"
> >
> > nit: why do you need to set the replay-window in both directions?
>
> No reason - probably just careless here.
>
> >
> > >                         "auth-trunc 'hmac(sha1)' %s 96 enc 'cbc(aes)'=
 %s",
> > >             IP4_ADDR1_VETH1, IP4_ADDR_VETH0, XFRM_SPI_OUT_TO_IN, XFRM=
_AUTH, XFRM_ENC);
> > >         SYS(fail,
> > > @@ -313,7 +313,7 @@ static int add_xfrm_tunnel(void)
> > >          */
> > >         SYS(fail,
> > >             "ip xfrm state add src %s dst %s proto esp "
> > > -                   "spi %d reqid 1 mode tunnel "
> > > +                   "spi %d reqid 1 mode tunnel replay-window 42 "
> > >                     "auth-trunc 'hmac(sha1)' %s 96  enc 'cbc(aes)' %s=
",
> > >             IP4_ADDR_VETH0, IP4_ADDR1_VETH1, XFRM_SPI_IN_TO_OUT, XFRM=
_AUTH, XFRM_ENC);
> > >         SYS(fail,
> > > @@ -325,7 +325,7 @@ static int add_xfrm_tunnel(void)
> > >         /* root -> at_ns0 */
> > >         SYS(fail,
> > >             "ip xfrm state add src %s dst %s proto esp "
> > > -                   "spi %d reqid 2 mode tunnel "
> > > +                   "spi %d reqid 2 mode tunnel replay-window 42 "
> > >                     "auth-trunc 'hmac(sha1)' %s 96  enc 'cbc(aes)' %s=
",
> > >             IP4_ADDR1_VETH1, IP4_ADDR_VETH0, XFRM_SPI_OUT_TO_IN, XFRM=
_AUTH, XFRM_ENC);
> > >         SYS(fail,
> > > @@ -628,8 +628,10 @@ static void test_xfrm_tunnel(void)
> > >  {
> > >         DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook,
> > >                             .attach_point =3D BPF_TC_INGRESS);
> > > +       LIBBPF_OPTS(bpf_xdp_attach_opts, opts);
> > >         struct test_tunnel_kern *skel =3D NULL;
> > >         struct nstoken *nstoken;
> > > +       int xdp_prog_fd;
> > >         int tc_prog_fd;
> > >         int ifindex;
> > >         int err;
> > > @@ -654,6 +656,14 @@ static void test_xfrm_tunnel(void)
> > >         if (attach_tc_prog(&tc_hook, tc_prog_fd, -1))
> > >                 goto done;
> > >
> > > +       /* attach xdp prog to tunnel dev */
> > > +       xdp_prog_fd =3D bpf_program__fd(skel->progs.xfrm_get_state_xd=
p);
> > > +       if (!ASSERT_GE(xdp_prog_fd, 0, "bpf_program__fd"))
> > > +               goto done;
> > > +       err =3D bpf_xdp_attach(ifindex, xdp_prog_fd, XDP_FLAGS_REPLAC=
E, &opts);
> > > +       if (!ASSERT_OK(err, "bpf_xdp_attach"))
> > > +               goto done;
> > > +
> > >         /* ping from at_ns0 namespace test */
> > >         nstoken =3D open_netns("at_ns0");
> > >         err =3D test_ping(AF_INET, IP4_ADDR_TUNL_DEV1);
> > > @@ -667,6 +677,8 @@ static void test_xfrm_tunnel(void)
> > >                 goto done;
> > >         if (!ASSERT_EQ(skel->bss->xfrm_remote_ip, 0xac100164, "remote=
_ip"))
> > >                 goto done;
> > > +       if (!ASSERT_EQ(skel->bss->xfrm_replay_window, 42, "replay_win=
dow"))
> > > +               goto done;
> > >
> > >  done:
> > >         delete_xfrm_tunnel();
> > > diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/t=
ools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > index 3a59eb9c34de..c0dd38616562 100644
> > > --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > @@ -30,6 +30,10 @@ int bpf_skb_set_fou_encap(struct __sk_buff *skb_ct=
x,
> > >                           struct bpf_fou_encap *encap, int type) __ks=
ym;
> > >  int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
> > >                           struct bpf_fou_encap *encap) __ksym;
> > > +struct xfrm_state *
> > > +bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opt=
s *opts,
> > > +                      u32 opts__sz) __ksym;
> > > +void bpf_xdp_xfrm_state_release(struct xfrm_state *x) __ksym;
> > >
> > >  struct {
> > >         __uint(type, BPF_MAP_TYPE_ARRAY);
> > > @@ -950,4 +954,51 @@ int xfrm_get_state(struct __sk_buff *skb)
> > >         return TC_ACT_OK;
> > >  }
> > >
> > > +volatile int xfrm_replay_window =3D 0;
> > > +
> > > +SEC("xdp")
> > > +int xfrm_get_state_xdp(struct xdp_md *xdp)
> > > +{
> > > +       struct bpf_xfrm_state_opts opts =3D {};
> > > +       struct xfrm_state *x =3D NULL;
> > > +       struct ip_esp_hdr *esph;
> > > +       struct bpf_dynptr ptr;
> > > +       u8 esph_buf[8] =3D {};
> > > +       u8 iph_buf[20] =3D {};
> > > +       struct iphdr *iph;
> > > +       u32 off;
> > > +
> > > +       if (bpf_dynptr_from_xdp(xdp, 0, &ptr))
> > > +               goto out;
> > > +
> > > +       off =3D sizeof(struct ethhdr);
> > > +       iph =3D bpf_dynptr_slice(&ptr, off, iph_buf, sizeof(iph_buf))=
;
> > > +       if (!iph || iph->protocol !=3D IPPROTO_ESP)
> > > +               goto out;
> > > +
> > > +       off +=3D sizeof(struct iphdr);
> > > +       esph =3D bpf_dynptr_slice(&ptr, off, esph_buf, sizeof(esph_bu=
f));
> > > +       if (!esph)
> > > +               goto out;
> > > +
> > > +       opts.netns_id =3D BPF_F_CURRENT_NETNS;
> > > +       opts.daddr.a4 =3D iph->daddr;
> > > +       opts.spi =3D esph->spi;
> > > +       opts.proto =3D IPPROTO_ESP;
> > > +       opts.family =3D AF_INET;
> > > +
> > > +       x =3D bpf_xdp_get_xfrm_state(xdp, &opts, sizeof(opts));
> > > +       if (!x || opts.error)
> >
> > nit: how can opts.error be non zero if x =3D=3D NULL?
>
> Ignoring the new -ENOENT case, it can't. Which is why I'm testing that
> behavior here.

I'm sorry, I don't understand.

AFAICT, regardless of the -ENOENT change, I don't see
how (!x) is false and (opt.error) is true, and so
"if (!x || opts.error)" is always equivalent to "if (!x)".

What am I missing?
Eyal.

