Return-Path: <linux-kselftest+bounces-1632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE28180E035
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 01:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F17A2826B6
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 00:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0453F375;
	Tue, 12 Dec 2023 00:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo4A/QWi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E493CCE;
	Mon, 11 Dec 2023 16:25:18 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b9df0a6560so3339420b6e.2;
        Mon, 11 Dec 2023 16:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702340718; x=1702945518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39T29mKaZhZsvtvyPbf6oRtFUL7dkzA08+GHd64VmhI=;
        b=jo4A/QWiQXMW/S66MDyqW5fBgdABOkIOck0+Y53GCC2ybLFJxUR9NjwBZRZgIApgQz
         xxTWSt9SFMqKLFhvWcEk9KkQ/dJkNBV1gVb6xYnNdTrALvlXK27AHK9yU7vD1KLAcX4c
         FcNCpeR5SumD8YsnyN/bp3vmyjhX0WYeoM9S2MUKWuXtOZkljGfDk6dRppih7yz4FlcA
         a9OIFYDADWK0W96Fp9FCSmjv36m+WrjoupO0k0FaNBG0wiHJLtnjWIm0gJGSXox1vxGr
         vy1yknMhKKvVZdKS+1sdnmHQe9kzmsV3WjYf+F91iRb19TUTT1cqgHzWt+sTHaHn3uDU
         DAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702340718; x=1702945518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39T29mKaZhZsvtvyPbf6oRtFUL7dkzA08+GHd64VmhI=;
        b=Ok3dK1CzwNWpeY0kMSpFjDIvTQF+HOGyzgpENxaz3eSX3hIqnFt9rib5yy3i5bIiwe
         0ndupZrrAknW5L6O/IrzVvPs0gj5guo2CVwpRL1Uj9VoAizLVSQS3oAWWLCmcG+h9EvU
         lIYLoRL6YWpYqaZlQXx+mL5ReKdOtWWW6ti/XyyLNf8aloOx1AIBFVfRoKc8xW+rCbW3
         RwTsmORRN96izv90pDlMBJ4paDgQ3UGd41yhDp1ORXOVWWZgihd7t5ZuYpptA3ReVrwl
         2G9sqfnuuGtCaUni8ZpM044b963PosxRG5JSrTNX2uxxvwgru3XVq3Lwa4MEBmND98cf
         Alqg==
X-Gm-Message-State: AOJu0Yy8xFdE2FdEuKqqQLX3V5LNWO4ZD9Nj0RmHZsqR/KEZC0j337GL
	pC8NxgsM42yj6kY5dv7AZNfzskZVIz41/YgJ1g0=
X-Google-Smtp-Source: AGHT+IEh6B1JkFF/ps9Eg/qwzMBzzH+8yw0p8aEhYu+TFDOp4cD/p9V1q7JFIhTjuKQ2UdWFg81KTYNc8+bnTtl1rfA=
X-Received: by 2002:a05:6808:151f:b0:3b8:b063:664d with SMTP id
 u31-20020a056808151f00b003b8b063664dmr5343458oiw.68.1702340717969; Mon, 11
 Dec 2023 16:25:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1702325874.git.dxu@dxuuu.xyz> <8ec1b885d2e13fcd20944cce9edc0340d993d044.1702325874.git.dxu@dxuuu.xyz>
 <CAHsH6GsdqBN638uqUm+8QkP1_45coucSTL7o=D2wFW-gYjPaBw@mail.gmail.com>
 <7yjkfhrwdphtcljq3odv4jc6lucd32wcg277hfsf4ve2jbo7hp@vuqzwbq5nxjw>
 <CAHsH6Gs1vUQnhR_a4qFnAF37Vx=68Do28sfVfFxQ9pVj9jSzjw@mail.gmail.com> <qiv464c4y43mo5rih5k6lgzkbpnj6wsrl52hrhgbxeqj45atun@szmqlmnccm52>
In-Reply-To: <qiv464c4y43mo5rih5k6lgzkbpnj6wsrl52hrhgbxeqj45atun@szmqlmnccm52>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Mon, 11 Dec 2023 16:25:06 -0800
Message-ID: <CAHsH6Gujycb9RBuRk7QHorLe0Q=Np_tb3uboQfp9KmJnegVXvw@mail.gmail.com>
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

On Mon, Dec 11, 2023 at 3:49=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> On Mon, Dec 11, 2023 at 03:13:07PM -0800, Eyal Birger wrote:
> > On Mon, Dec 11, 2023 at 2:31=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote=
:
> > >
> > > On Mon, Dec 11, 2023 at 01:39:25PM -0800, Eyal Birger wrote:
> > > > Hi Daniel,
> > > >
> > > > Tiny nits below in case you respin this for other reasons:
> > > >
> > > > On Mon, Dec 11, 2023 at 12:20=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> =
wrote:
> > > > >
> > > > > This commit extends test_tunnel selftest to test the new XDP xfrm=
 state
> > > > > lookup kfunc.
> > > > >
> > > > > Co-developed-by: Antony Antony <antony.antony@secunet.com>
> > > > > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > > > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > > > ---
> > > > >  .../selftests/bpf/prog_tests/test_tunnel.c    | 20 ++++++--
> > > > >  .../selftests/bpf/progs/test_tunnel_kern.c    | 51 +++++++++++++=
++++++
> > > > >  2 files changed, 67 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c=
 b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> > > > > index 2d7f8fa82ebd..fc804095d578 100644
> > > > > --- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> > > > > +++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> > > > > @@ -278,7 +278,7 @@ static int add_xfrm_tunnel(void)
> > > > >         SYS(fail,
> > > > >             "ip netns exec at_ns0 "
> > > > >                 "ip xfrm state add src %s dst %s proto esp "
> > > > > -                       "spi %d reqid 1 mode tunnel "
> > > > > +                       "spi %d reqid 1 mode tunnel replay-window=
 42 "
> > > > >                         "auth-trunc 'hmac(sha1)' %s 96 enc 'cbc(a=
es)' %s",
> > > > >             IP4_ADDR_VETH0, IP4_ADDR1_VETH1, XFRM_SPI_IN_TO_OUT, =
XFRM_AUTH, XFRM_ENC);
> > > > >         SYS(fail,
> > > > > @@ -292,7 +292,7 @@ static int add_xfrm_tunnel(void)
> > > > >         SYS(fail,
> > > > >             "ip netns exec at_ns0 "
> > > > >                 "ip xfrm state add src %s dst %s proto esp "
> > > > > -                       "spi %d reqid 2 mode tunnel "
> > > > > +                       "spi %d reqid 2 mode tunnel replay-window=
 42 "
> > > >
> > > > nit: why do you need to set the replay-window in both directions?
> > >
> > > No reason - probably just careless here.
> > >
> > > >
> > > > >                         "auth-trunc 'hmac(sha1)' %s 96 enc 'cbc(a=
es)' %s",
> > > > >             IP4_ADDR1_VETH1, IP4_ADDR_VETH0, XFRM_SPI_OUT_TO_IN, =
XFRM_AUTH, XFRM_ENC);
> > > > >         SYS(fail,
> > > > > @@ -313,7 +313,7 @@ static int add_xfrm_tunnel(void)
> > > > >          */
> > > > >         SYS(fail,
> > > > >             "ip xfrm state add src %s dst %s proto esp "
> > > > > -                   "spi %d reqid 1 mode tunnel "
> > > > > +                   "spi %d reqid 1 mode tunnel replay-window 42 =
"
> > > > >                     "auth-trunc 'hmac(sha1)' %s 96  enc 'cbc(aes)=
' %s",
> > > > >             IP4_ADDR_VETH0, IP4_ADDR1_VETH1, XFRM_SPI_IN_TO_OUT, =
XFRM_AUTH, XFRM_ENC);
> > > > >         SYS(fail,
> > > > > @@ -325,7 +325,7 @@ static int add_xfrm_tunnel(void)
> > > > >         /* root -> at_ns0 */
> > > > >         SYS(fail,
> > > > >             "ip xfrm state add src %s dst %s proto esp "
> > > > > -                   "spi %d reqid 2 mode tunnel "
> > > > > +                   "spi %d reqid 2 mode tunnel replay-window 42 =
"
> > > > >                     "auth-trunc 'hmac(sha1)' %s 96  enc 'cbc(aes)=
' %s",
> > > > >             IP4_ADDR1_VETH1, IP4_ADDR_VETH0, XFRM_SPI_OUT_TO_IN, =
XFRM_AUTH, XFRM_ENC);
> > > > >         SYS(fail,
> > > > > @@ -628,8 +628,10 @@ static void test_xfrm_tunnel(void)
> > > > >  {
> > > > >         DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook,
> > > > >                             .attach_point =3D BPF_TC_INGRESS);
> > > > > +       LIBBPF_OPTS(bpf_xdp_attach_opts, opts);
> > > > >         struct test_tunnel_kern *skel =3D NULL;
> > > > >         struct nstoken *nstoken;
> > > > > +       int xdp_prog_fd;
> > > > >         int tc_prog_fd;
> > > > >         int ifindex;
> > > > >         int err;
> > > > > @@ -654,6 +656,14 @@ static void test_xfrm_tunnel(void)
> > > > >         if (attach_tc_prog(&tc_hook, tc_prog_fd, -1))
> > > > >                 goto done;
> > > > >
> > > > > +       /* attach xdp prog to tunnel dev */
> > > > > +       xdp_prog_fd =3D bpf_program__fd(skel->progs.xfrm_get_stat=
e_xdp);
> > > > > +       if (!ASSERT_GE(xdp_prog_fd, 0, "bpf_program__fd"))
> > > > > +               goto done;
> > > > > +       err =3D bpf_xdp_attach(ifindex, xdp_prog_fd, XDP_FLAGS_RE=
PLACE, &opts);
> > > > > +       if (!ASSERT_OK(err, "bpf_xdp_attach"))
> > > > > +               goto done;
> > > > > +
> > > > >         /* ping from at_ns0 namespace test */
> > > > >         nstoken =3D open_netns("at_ns0");
> > > > >         err =3D test_ping(AF_INET, IP4_ADDR_TUNL_DEV1);
> > > > > @@ -667,6 +677,8 @@ static void test_xfrm_tunnel(void)
> > > > >                 goto done;
> > > > >         if (!ASSERT_EQ(skel->bss->xfrm_remote_ip, 0xac100164, "re=
mote_ip"))
> > > > >                 goto done;
> > > > > +       if (!ASSERT_EQ(skel->bss->xfrm_replay_window, 42, "replay=
_window"))
> > > > > +               goto done;
> > > > >
> > > > >  done:
> > > > >         delete_xfrm_tunnel();
> > > > > diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c=
 b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > > index 3a59eb9c34de..c0dd38616562 100644
> > > > > --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > > +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > > @@ -30,6 +30,10 @@ int bpf_skb_set_fou_encap(struct __sk_buff *sk=
b_ctx,
> > > > >                           struct bpf_fou_encap *encap, int type) =
__ksym;
> > > > >  int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
> > > > >                           struct bpf_fou_encap *encap) __ksym;
> > > > > +struct xfrm_state *
> > > > > +bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state=
_opts *opts,
> > > > > +                      u32 opts__sz) __ksym;
> > > > > +void bpf_xdp_xfrm_state_release(struct xfrm_state *x) __ksym;
> > > > >
> > > > >  struct {
> > > > >         __uint(type, BPF_MAP_TYPE_ARRAY);
> > > > > @@ -950,4 +954,51 @@ int xfrm_get_state(struct __sk_buff *skb)
> > > > >         return TC_ACT_OK;
> > > > >  }
> > > > >
> > > > > +volatile int xfrm_replay_window =3D 0;
> > > > > +
> > > > > +SEC("xdp")
> > > > > +int xfrm_get_state_xdp(struct xdp_md *xdp)
> > > > > +{
> > > > > +       struct bpf_xfrm_state_opts opts =3D {};
> > > > > +       struct xfrm_state *x =3D NULL;
> > > > > +       struct ip_esp_hdr *esph;
> > > > > +       struct bpf_dynptr ptr;
> > > > > +       u8 esph_buf[8] =3D {};
> > > > > +       u8 iph_buf[20] =3D {};
> > > > > +       struct iphdr *iph;
> > > > > +       u32 off;
> > > > > +
> > > > > +       if (bpf_dynptr_from_xdp(xdp, 0, &ptr))
> > > > > +               goto out;
> > > > > +
> > > > > +       off =3D sizeof(struct ethhdr);
> > > > > +       iph =3D bpf_dynptr_slice(&ptr, off, iph_buf, sizeof(iph_b=
uf));
> > > > > +       if (!iph || iph->protocol !=3D IPPROTO_ESP)
> > > > > +               goto out;
> > > > > +
> > > > > +       off +=3D sizeof(struct iphdr);
> > > > > +       esph =3D bpf_dynptr_slice(&ptr, off, esph_buf, sizeof(esp=
h_buf));
> > > > > +       if (!esph)
> > > > > +               goto out;
> > > > > +
> > > > > +       opts.netns_id =3D BPF_F_CURRENT_NETNS;
> > > > > +       opts.daddr.a4 =3D iph->daddr;
> > > > > +       opts.spi =3D esph->spi;
> > > > > +       opts.proto =3D IPPROTO_ESP;
> > > > > +       opts.family =3D AF_INET;
> > > > > +
> > > > > +       x =3D bpf_xdp_get_xfrm_state(xdp, &opts, sizeof(opts));
> > > > > +       if (!x || opts.error)
> > > >
> > > > nit: how can opts.error be non zero if x =3D=3D NULL?
> > >
> > > Ignoring the new -ENOENT case, it can't. Which is why I'm testing tha=
t
> > > behavior here.
> >
> > I'm sorry, I don't understand.
> >
> > AFAICT, regardless of the -ENOENT change, I don't see
> > how (!x) is false and (opt.error) is true, and so
> > "if (!x || opts.error)" is always equivalent to "if (!x)".
> >
> > What am I missing?
> > Eyal.
>
> The selftests are tests so my intention was to check edge cases here.
> In normal operation it shouldn't be possible that
> bpf_xdp_get_xfrm_state() returns non-NULL and also an error. Maybe
> another way of writing this would be:
>
>         if (!x)
>                 goto out;
>         assert(opts.error =3D=3D 0);

I think this would convey the "edge case testing" notion better.

>
> If I'm trying to be too clever (or maybe just wrong) or it's pointless,
> I can remove the `opts.error` condition.

At least for me the tests also serve as references as to how the
API is expected to be used, so I think it'd be clearer without
signaling that opts.error could potentially be nonzero on success.

An assertion would indeed make that clear.

Thanks for the explanation,
Eyal.

