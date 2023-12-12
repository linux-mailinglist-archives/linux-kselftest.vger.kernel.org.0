Return-Path: <linux-kselftest+bounces-1754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D7D80FB19
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 00:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7402820C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 23:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E5064714;
	Tue, 12 Dec 2023 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTIeK8ZD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B715E99;
	Tue, 12 Dec 2023 15:14:29 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id ffacd0b85a97d-336378d3bfdso290085f8f.1;
        Tue, 12 Dec 2023 15:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702422868; x=1703027668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MK4XNOiUczTnCjgph+SkPa+TLs4r2nIM6Me08H3+Bo=;
        b=nTIeK8ZDZJceP2rMOH/5odbJeIj8IqH2WvAeHTppMrkOt3T1NInXDqmmpwofsYNx81
         zkcGDhZq9NKgBvpCaaYUAjhJ+IDp+c81psTKmKBoNjY2XJjsw4XZPUpS1X7ygagMHg4K
         TlU3nSQ/SGGR92rdAn57LvWDibW3xBi3e7MFReRe/OOsO5AodAie17dCl9z21BxWajCi
         HkcdeGdoHIZUyJeYYa6xUDd4V60yA1rwzuu9CGssGCuainTCHdnqWPyZSe5hu2d8evvM
         g7971HUfauONgXrfYsCn1aHnHSY0mmFLEI8JOZ2GMotbLR/1cjml2mjQ+Lo3MMXNFoLG
         uSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702422868; x=1703027668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MK4XNOiUczTnCjgph+SkPa+TLs4r2nIM6Me08H3+Bo=;
        b=ISrSOM1kstZcg5BjCHUjfu1CViwcmS0ZvIfh2juP2HQV9OBSnVcDuTuIPwwPW3lZFO
         gxPEomhmbuX6SMPOF2+KThE8Uzmw1Zk34v7K3CgdDeGT/j+dkkIgmzR1Rsyoj/NSAxzy
         1CViZqpDxLs50n5lKbeoPfTF348lido6VOnfGXJWSVru9eWdU4zMZjs3dfMMNcAGQ/AL
         lUJHp/esoWjCR2iCbYtPUbm5DlYnJIGbrZWizKwWdekoqNRzXVPAwX4O+jI99fnMa3j9
         bLI/++h9/APktdKk8OkzQhXSuBuVXnOr0KFdoPmY7bqXlwW/mKEcACIpY0Qx78u0uXPx
         yKwQ==
X-Gm-Message-State: AOJu0YxXqu9yICRxuxv5l0488I2STrEFCUSGye2M1vDB/drkRwHME72N
	0C0b5WruVJzS5K5VQj77X+6ywWXologkmhKyC2k=
X-Google-Smtp-Source: AGHT+IEn8ug2jnMUFyqlw3I+9kC0xAzvNm7keMaysp7nQ8xDmdPjP/+qNrrL7CKS/5wfABLY2GmxfnCKIB6Xe/SdnHo=
X-Received: by 2002:a05:600c:30d2:b0:40c:4378:f111 with SMTP id
 h18-20020a05600c30d200b0040c4378f111mr2377932wmn.80.1702422867897; Tue, 12
 Dec 2023 15:14:27 -0800 (PST)
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
 <fwadmdjjogp4ybfxfpwovnmnn36jigffopijsuqt4ly4vxqghm@ysqhd25mzylp> <fecc7tpmbnqxuxqqolm44ggyeomcr3piabsjkv3pgyzlhyonq6@iiaxf34erjzq>
In-Reply-To: <fecc7tpmbnqxuxqqolm44ggyeomcr3piabsjkv3pgyzlhyonq6@iiaxf34erjzq>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 13 Dec 2023 00:13:51 +0100
Message-ID: <CAP01T770poh_63vBC+Heb9ASJ9pDZd1wTDWAgm5KCYHK9GtE1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 9/9] bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Eyal Birger <eyal.birger@gmail.com>, daniel@iogearbox.net, davem@davemloft.net, 
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

On Tue, 12 Dec 2023 at 20:52, Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> cc Kumar
>
> On Tue, Dec 12, 2023 at 09:17:02AM -0700, Daniel Xu wrote:
> > On Mon, Dec 11, 2023 at 04:25:06PM -0800, Eyal Birger wrote:
> > > On Mon, Dec 11, 2023 at 3:49=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wro=
te:
> > > >
> > > > On Mon, Dec 11, 2023 at 03:13:07PM -0800, Eyal Birger wrote:
> > > > > On Mon, Dec 11, 2023 at 2:31=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz>=
 wrote:
> > > > > >
> > > > > > On Mon, Dec 11, 2023 at 01:39:25PM -0800, Eyal Birger wrote:
> > > > > > > Hi Daniel,
> > > > > > >
> > > > > > > Tiny nits below in case you respin this for other reasons:
> > > > > > >
> > > > > > > On Mon, Dec 11, 2023 at 12:20=E2=80=AFPM Daniel Xu <dxu@dxuuu=
.xyz> wrote:
> > > > > > > >
> > > > > > > > This commit extends test_tunnel selftest to test the new XD=
P xfrm state
> > > > > > > > lookup kfunc.
> > > > > > > >
> > > > > > > > Co-developed-by: Antony Antony <antony.antony@secunet.com>
> > > > > > > > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > > > > > > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > > > > > > ---
> > > > > > > >  .../selftests/bpf/prog_tests/test_tunnel.c    | 20 ++++++-=
-
> > > > > > > >  .../selftests/bpf/progs/test_tunnel_kern.c    | 51 +++++++=
++++++++++++
> > > > > > > >  2 files changed, 67 insertions(+), 4 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/tools/testing/selftests/bpf/prog_tests/test_tu=
nnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> > > > > > > > index 2d7f8fa82ebd..fc804095d578 100644
> > > > > > > > --- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> > > > > > > > +++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> > > > > > > > @@ -278,7 +278,7 @@ static int add_xfrm_tunnel(void)
> > > > > > > >         SYS(fail,
> > > > > > > >             "ip netns exec at_ns0 "
> > > > > > > >                 "ip xfrm state add src %s dst %s proto esp =
"
> > > > > > > > -                       "spi %d reqid 1 mode tunnel "
> > > > > > > > +                       "spi %d reqid 1 mode tunnel replay-=
window 42 "
> > > > > > > >                         "auth-trunc 'hmac(sha1)' %s 96 enc =
'cbc(aes)' %s",
> > > > > > > >             IP4_ADDR_VETH0, IP4_ADDR1_VETH1, XFRM_SPI_IN_TO=
_OUT, XFRM_AUTH, XFRM_ENC);
> > > > > > > >         SYS(fail,
> > > > > > > > @@ -292,7 +292,7 @@ static int add_xfrm_tunnel(void)
> > > > > > > >         SYS(fail,
> > > > > > > >             "ip netns exec at_ns0 "
> > > > > > > >                 "ip xfrm state add src %s dst %s proto esp =
"
> > > > > > > > -                       "spi %d reqid 2 mode tunnel "
> > > > > > > > +                       "spi %d reqid 2 mode tunnel replay-=
window 42 "
> > > > > > >
> > > > > > > nit: why do you need to set the replay-window in both directi=
ons?
> > > > > >
> > > > > > No reason - probably just careless here.
> > > > > >
> > > > > > >
> > > > > > > >                         "auth-trunc 'hmac(sha1)' %s 96 enc =
'cbc(aes)' %s",
> > > > > > > >             IP4_ADDR1_VETH1, IP4_ADDR_VETH0, XFRM_SPI_OUT_T=
O_IN, XFRM_AUTH, XFRM_ENC);
> > > > > > > >         SYS(fail,
> > > > > > > > @@ -313,7 +313,7 @@ static int add_xfrm_tunnel(void)
> > > > > > > >          */
> > > > > > > >         SYS(fail,
> > > > > > > >             "ip xfrm state add src %s dst %s proto esp "
> > > > > > > > -                   "spi %d reqid 1 mode tunnel "
> > > > > > > > +                   "spi %d reqid 1 mode tunnel replay-wind=
ow 42 "
> > > > > > > >                     "auth-trunc 'hmac(sha1)' %s 96  enc 'cb=
c(aes)' %s",
> > > > > > > >             IP4_ADDR_VETH0, IP4_ADDR1_VETH1, XFRM_SPI_IN_TO=
_OUT, XFRM_AUTH, XFRM_ENC);
> > > > > > > >         SYS(fail,
> > > > > > > > @@ -325,7 +325,7 @@ static int add_xfrm_tunnel(void)
> > > > > > > >         /* root -> at_ns0 */
> > > > > > > >         SYS(fail,
> > > > > > > >             "ip xfrm state add src %s dst %s proto esp "
> > > > > > > > -                   "spi %d reqid 2 mode tunnel "
> > > > > > > > +                   "spi %d reqid 2 mode tunnel replay-wind=
ow 42 "
> > > > > > > >                     "auth-trunc 'hmac(sha1)' %s 96  enc 'cb=
c(aes)' %s",
> > > > > > > >             IP4_ADDR1_VETH1, IP4_ADDR_VETH0, XFRM_SPI_OUT_T=
O_IN, XFRM_AUTH, XFRM_ENC);
> > > > > > > >         SYS(fail,
> > > > > > > > @@ -628,8 +628,10 @@ static void test_xfrm_tunnel(void)
> > > > > > > >  {
> > > > > > > >         DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook,
> > > > > > > >                             .attach_point =3D BPF_TC_INGRES=
S);
> > > > > > > > +       LIBBPF_OPTS(bpf_xdp_attach_opts, opts);
> > > > > > > >         struct test_tunnel_kern *skel =3D NULL;
> > > > > > > >         struct nstoken *nstoken;
> > > > > > > > +       int xdp_prog_fd;
> > > > > > > >         int tc_prog_fd;
> > > > > > > >         int ifindex;
> > > > > > > >         int err;
> > > > > > > > @@ -654,6 +656,14 @@ static void test_xfrm_tunnel(void)
> > > > > > > >         if (attach_tc_prog(&tc_hook, tc_prog_fd, -1))
> > > > > > > >                 goto done;
> > > > > > > >
> > > > > > > > +       /* attach xdp prog to tunnel dev */
> > > > > > > > +       xdp_prog_fd =3D bpf_program__fd(skel->progs.xfrm_ge=
t_state_xdp);
> > > > > > > > +       if (!ASSERT_GE(xdp_prog_fd, 0, "bpf_program__fd"))
> > > > > > > > +               goto done;
> > > > > > > > +       err =3D bpf_xdp_attach(ifindex, xdp_prog_fd, XDP_FL=
AGS_REPLACE, &opts);
> > > > > > > > +       if (!ASSERT_OK(err, "bpf_xdp_attach"))
> > > > > > > > +               goto done;
> > > > > > > > +
> > > > > > > >         /* ping from at_ns0 namespace test */
> > > > > > > >         nstoken =3D open_netns("at_ns0");
> > > > > > > >         err =3D test_ping(AF_INET, IP4_ADDR_TUNL_DEV1);
> > > > > > > > @@ -667,6 +677,8 @@ static void test_xfrm_tunnel(void)
> > > > > > > >                 goto done;
> > > > > > > >         if (!ASSERT_EQ(skel->bss->xfrm_remote_ip, 0xac10016=
4, "remote_ip"))
> > > > > > > >                 goto done;
> > > > > > > > +       if (!ASSERT_EQ(skel->bss->xfrm_replay_window, 42, "=
replay_window"))
> > > > > > > > +               goto done;
> > > > > > > >
> > > > > > > >  done:
> > > > > > > >         delete_xfrm_tunnel();
> > > > > > > > diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_=
kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > > > > > index 3a59eb9c34de..c0dd38616562 100644
> > > > > > > > --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > > > > > +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > > > > > @@ -30,6 +30,10 @@ int bpf_skb_set_fou_encap(struct __sk_bu=
ff *skb_ctx,
> > > > > > > >                           struct bpf_fou_encap *encap, int =
type) __ksym;
> > > > > > > >  int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
> > > > > > > >                           struct bpf_fou_encap *encap) __ks=
ym;
> > > > > > > > +struct xfrm_state *
> > > > > > > > +bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm=
_state_opts *opts,
> > > > > > > > +                      u32 opts__sz) __ksym;
> > > > > > > > +void bpf_xdp_xfrm_state_release(struct xfrm_state *x) __ks=
ym;
> > > > > > > >
> > > > > > > >  struct {
> > > > > > > >         __uint(type, BPF_MAP_TYPE_ARRAY);
> > > > > > > > @@ -950,4 +954,51 @@ int xfrm_get_state(struct __sk_buff *s=
kb)
> > > > > > > >         return TC_ACT_OK;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +volatile int xfrm_replay_window =3D 0;
> > > > > > > > +
> > > > > > > > +SEC("xdp")
> > > > > > > > +int xfrm_get_state_xdp(struct xdp_md *xdp)
> > > > > > > > +{
> > > > > > > > +       struct bpf_xfrm_state_opts opts =3D {};
> > > > > > > > +       struct xfrm_state *x =3D NULL;
> > > > > > > > +       struct ip_esp_hdr *esph;
> > > > > > > > +       struct bpf_dynptr ptr;
> > > > > > > > +       u8 esph_buf[8] =3D {};
> > > > > > > > +       u8 iph_buf[20] =3D {};
> > > > > > > > +       struct iphdr *iph;
> > > > > > > > +       u32 off;
> > > > > > > > +
> > > > > > > > +       if (bpf_dynptr_from_xdp(xdp, 0, &ptr))
> > > > > > > > +               goto out;
> > > > > > > > +
> > > > > > > > +       off =3D sizeof(struct ethhdr);
> > > > > > > > +       iph =3D bpf_dynptr_slice(&ptr, off, iph_buf, sizeof=
(iph_buf));
> > > > > > > > +       if (!iph || iph->protocol !=3D IPPROTO_ESP)
> > > > > > > > +               goto out;
> > > > > > > > +
> > > > > > > > +       off +=3D sizeof(struct iphdr);
> > > > > > > > +       esph =3D bpf_dynptr_slice(&ptr, off, esph_buf, size=
of(esph_buf));
> > > > > > > > +       if (!esph)
> > > > > > > > +               goto out;
> > > > > > > > +
> > > > > > > > +       opts.netns_id =3D BPF_F_CURRENT_NETNS;
> > > > > > > > +       opts.daddr.a4 =3D iph->daddr;
> > > > > > > > +       opts.spi =3D esph->spi;
> > > > > > > > +       opts.proto =3D IPPROTO_ESP;
> > > > > > > > +       opts.family =3D AF_INET;
> > > > > > > > +
> > > > > > > > +       x =3D bpf_xdp_get_xfrm_state(xdp, &opts, sizeof(opt=
s));
> > > > > > > > +       if (!x || opts.error)
> > > > > > >
> > > > > > > nit: how can opts.error be non zero if x =3D=3D NULL?
> > > > > >
> > > > > > Ignoring the new -ENOENT case, it can't. Which is why I'm testi=
ng that
> > > > > > behavior here.
> > > > >
> > > > > I'm sorry, I don't understand.
> > > > >
> > > > > AFAICT, regardless of the -ENOENT change, I don't see
> > > > > how (!x) is false and (opt.error) is true, and so
> > > > > "if (!x || opts.error)" is always equivalent to "if (!x)".
> > > > >
> > > > > What am I missing?
> > > > > Eyal.
> > > >
> > > > The selftests are tests so my intention was to check edge cases her=
e.
> > > > In normal operation it shouldn't be possible that
> > > > bpf_xdp_get_xfrm_state() returns non-NULL and also an error. Maybe
> > > > another way of writing this would be:
> > > >
> > > >         if (!x)
> > > >                 goto out;
> > > >         assert(opts.error =3D=3D 0);
> > >
> > > I think this would convey the "edge case testing" notion better.
> > >
> > > >
> > > > If I'm trying to be too clever (or maybe just wrong) or it's pointl=
ess,
> > > > I can remove the `opts.error` condition.
> > >
> > > At least for me the tests also serve as references as to how the
> > > API is expected to be used, so I think it'd be clearer without
> > > signaling that opts.error could potentially be nonzero on success.
> > >
> > > An assertion would indeed make that clear.
> >
> > Sure, sounds good. I will check on the new bpf assert infra.
>
> Couldn't quite get bpf_assert() working. The following diff:
>
> diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools=
/testing/selftests/bpf/progs/test_tunnel_kern.c
> index c0dd38616562..f00dba85ac5d 100644
> --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> @@ -8,8 +8,9 @@
>   */
>  #include "vmlinux.h"
>  #include <bpf/bpf_core_read.h>
> -#include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_endian.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_experimental.h"
>  #include "bpf_kfuncs.h"
>  #include "bpf_tracing_net.h"
>
> @@ -988,8 +989,9 @@ int xfrm_get_state_xdp(struct xdp_md *xdp)
>         opts.family =3D AF_INET;
>
>         x =3D bpf_xdp_get_xfrm_state(xdp, &opts, sizeof(opts));
> -       if (!x || opts.error)
> +       if (!x)
>                 goto out;
> +       bpf_assert_with(opts.error =3D=3D 0, XDP_PASS);
>
>         if (!x->replay_esn)
>                 goto out;
>
> results in:
>
> 57: (b7) r1 =3D 2                       ; R1_w=3D2 refs=3D5
> 58: (85) call bpf_throw#115436
> calling kernel function bpf_throw is not allowed
>

I think this might be because bpf_throw is not registered for use by
BPF_PROG_TYPE_XDP. I would simply register the generic_kfunc_set for
this program type as well, since it's already done for TC.

> It looks like the above error comes from verifier.c:fetch_kfunc_meta,
> but I can run the exceptions selftests just fine with the same bzImage.
> So I'm thinking it's not a kfunc registration or BTF issue.
>
> Maybe it's cuz I'm holding onto KFUNC_ACQUIRE'd `x`? Not sure.
>

Yes, even once you enable this, this will fail for now. I am sending
out a series later this week that enables bpf_throw with acquired
references, but until then may I suggest the following:

#define bpf_assert_if(cond) for (int ___i =3D 0, ___j =3D (cond); !(___j) \
&& !___j; bpf_throw(), ___i++)

This will allow you to insert some cleanup code with an assertion.
Then in my series, I will convert this temporary bpf_assert_if back to
the normal bpf_assert.

It would look like:
bpf_assert_if(opts.error =3D=3D 0) {
  // Execute if assertion failed
  bpf_xdp_xfrm_state_release(x);
}

Likewise for bpf_assert_with_if, you get the idea.



> So for now I think I'll drop checking opts.error.
>
> [...]

