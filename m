Return-Path: <linux-kselftest+bounces-1621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7B480DD59
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 22:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0CE11C21654
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 21:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49C354F94;
	Mon, 11 Dec 2023 21:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhtLoLvA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C42E8;
	Mon, 11 Dec 2023 13:39:37 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-4647e1fd35cso1298769137.0;
        Mon, 11 Dec 2023 13:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702330776; x=1702935576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NZ5CJEGXmBj70A7RmBl7daaBdWL8Nh0RLp7iC/TCj0=;
        b=QhtLoLvADKeYUNW37OkIb1thrqNIut5jFfgRxnIawsV69Sk4KkJwQVMmiDcZ1mjd1/
         36PnaSPW4ZuxzJcHkcJZO53+TaqiK+gcNbb3oR49VFPHyS5BXedvqyjhTb7Uq07+ll8X
         cgUr5C+QWD9jmqF9LXAru4eAKDLM4F70tDo+8GR83vuICe/V38IGDwKSqE/tMBUNvYA8
         sjcoslFUTTXI0Oy8gEbweZCpvw2P6iNsLqyidC5fCV95WlmdPXUn82rerZWAUEvYOri1
         O+O9ME/isOGjLrU5qabbv0GB0DSE7YjrxSqXeJ6WeMjLE397k9ZxRcjtWPlJnsii25M5
         df2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702330776; x=1702935576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NZ5CJEGXmBj70A7RmBl7daaBdWL8Nh0RLp7iC/TCj0=;
        b=EkbT9b1tsjnLqCE7b4sRQ31cLkp+4O3DlS/661n3dlglL3aUQfjWDdKiJ7d1tSwBh0
         YgjKM3PML7hAWBFUW4kUyebhQCB9sqPiTUb5ARgskMkKYCYbEwvc8B6rMWJCV6m1pp1s
         kVGs1IZWMUIp77N1Glj7nMgOqwcMojmbZV4yhvsYHCP9rkkgXRukfWz3D3UKZ3qId/iN
         l1qzP3aRt2ARuzv9NkVRvsjP4ylqDsaimNX0u7DMtFktAJvhY5+dKB+lw4Bm+pA1/SNq
         huTN2MLUnyEtpLjFK/iTG0WZDoD3KMSvcleNMlSFBuSPtCup7rSmmlnf1qWY6mzzvSgs
         RAjw==
X-Gm-Message-State: AOJu0YzVoCQV6u5HhpIT74JuK7pZJP/kfAUN8v3Z/qCuxXhuTbdFfZNP
	38p3qHhyKK3sidU8UTW6tcuuJw9Hp6IRHhRgn+lKHjxmTukR+w==
X-Google-Smtp-Source: AGHT+IGggXsrNXVPAhLoWJQlGqDk3Ep3b86fc2Bfl/RIFEU2YuDNeKRXkOHg1Fk/ZtrfaOCaIz42zHeRpRyFB20LRE8=
X-Received: by 2002:a05:6102:3ed6:b0:465:e39c:476b with SMTP id
 n22-20020a0561023ed600b00465e39c476bmr3452415vsv.32.1702330776266; Mon, 11
 Dec 2023 13:39:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1702325874.git.dxu@dxuuu.xyz> <8ec1b885d2e13fcd20944cce9edc0340d993d044.1702325874.git.dxu@dxuuu.xyz>
In-Reply-To: <8ec1b885d2e13fcd20944cce9edc0340d993d044.1702325874.git.dxu@dxuuu.xyz>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Mon, 11 Dec 2023 13:39:25 -0800
Message-ID: <CAHsH6GsdqBN638uqUm+8QkP1_45coucSTL7o=D2wFW-gYjPaBw@mail.gmail.com>
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

Hi Daniel,

Tiny nits below in case you respin this for other reasons:

On Mon, Dec 11, 2023 at 12:20=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> This commit extends test_tunnel selftest to test the new XDP xfrm state
> lookup kfunc.
>
> Co-developed-by: Antony Antony <antony.antony@secunet.com>
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  .../selftests/bpf/prog_tests/test_tunnel.c    | 20 ++++++--
>  .../selftests/bpf/progs/test_tunnel_kern.c    | 51 +++++++++++++++++++
>  2 files changed, 67 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools=
/testing/selftests/bpf/prog_tests/test_tunnel.c
> index 2d7f8fa82ebd..fc804095d578 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> @@ -278,7 +278,7 @@ static int add_xfrm_tunnel(void)
>         SYS(fail,
>             "ip netns exec at_ns0 "
>                 "ip xfrm state add src %s dst %s proto esp "
> -                       "spi %d reqid 1 mode tunnel "
> +                       "spi %d reqid 1 mode tunnel replay-window 42 "
>                         "auth-trunc 'hmac(sha1)' %s 96 enc 'cbc(aes)' %s"=
,
>             IP4_ADDR_VETH0, IP4_ADDR1_VETH1, XFRM_SPI_IN_TO_OUT, XFRM_AUT=
H, XFRM_ENC);
>         SYS(fail,
> @@ -292,7 +292,7 @@ static int add_xfrm_tunnel(void)
>         SYS(fail,
>             "ip netns exec at_ns0 "
>                 "ip xfrm state add src %s dst %s proto esp "
> -                       "spi %d reqid 2 mode tunnel "
> +                       "spi %d reqid 2 mode tunnel replay-window 42 "

nit: why do you need to set the replay-window in both directions?

>                         "auth-trunc 'hmac(sha1)' %s 96 enc 'cbc(aes)' %s"=
,
>             IP4_ADDR1_VETH1, IP4_ADDR_VETH0, XFRM_SPI_OUT_TO_IN, XFRM_AUT=
H, XFRM_ENC);
>         SYS(fail,
> @@ -313,7 +313,7 @@ static int add_xfrm_tunnel(void)
>          */
>         SYS(fail,
>             "ip xfrm state add src %s dst %s proto esp "
> -                   "spi %d reqid 1 mode tunnel "
> +                   "spi %d reqid 1 mode tunnel replay-window 42 "
>                     "auth-trunc 'hmac(sha1)' %s 96  enc 'cbc(aes)' %s",
>             IP4_ADDR_VETH0, IP4_ADDR1_VETH1, XFRM_SPI_IN_TO_OUT, XFRM_AUT=
H, XFRM_ENC);
>         SYS(fail,
> @@ -325,7 +325,7 @@ static int add_xfrm_tunnel(void)
>         /* root -> at_ns0 */
>         SYS(fail,
>             "ip xfrm state add src %s dst %s proto esp "
> -                   "spi %d reqid 2 mode tunnel "
> +                   "spi %d reqid 2 mode tunnel replay-window 42 "
>                     "auth-trunc 'hmac(sha1)' %s 96  enc 'cbc(aes)' %s",
>             IP4_ADDR1_VETH1, IP4_ADDR_VETH0, XFRM_SPI_OUT_TO_IN, XFRM_AUT=
H, XFRM_ENC);
>         SYS(fail,
> @@ -628,8 +628,10 @@ static void test_xfrm_tunnel(void)
>  {
>         DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook,
>                             .attach_point =3D BPF_TC_INGRESS);
> +       LIBBPF_OPTS(bpf_xdp_attach_opts, opts);
>         struct test_tunnel_kern *skel =3D NULL;
>         struct nstoken *nstoken;
> +       int xdp_prog_fd;
>         int tc_prog_fd;
>         int ifindex;
>         int err;
> @@ -654,6 +656,14 @@ static void test_xfrm_tunnel(void)
>         if (attach_tc_prog(&tc_hook, tc_prog_fd, -1))
>                 goto done;
>
> +       /* attach xdp prog to tunnel dev */
> +       xdp_prog_fd =3D bpf_program__fd(skel->progs.xfrm_get_state_xdp);
> +       if (!ASSERT_GE(xdp_prog_fd, 0, "bpf_program__fd"))
> +               goto done;
> +       err =3D bpf_xdp_attach(ifindex, xdp_prog_fd, XDP_FLAGS_REPLACE, &=
opts);
> +       if (!ASSERT_OK(err, "bpf_xdp_attach"))
> +               goto done;
> +
>         /* ping from at_ns0 namespace test */
>         nstoken =3D open_netns("at_ns0");
>         err =3D test_ping(AF_INET, IP4_ADDR_TUNL_DEV1);
> @@ -667,6 +677,8 @@ static void test_xfrm_tunnel(void)
>                 goto done;
>         if (!ASSERT_EQ(skel->bss->xfrm_remote_ip, 0xac100164, "remote_ip"=
))
>                 goto done;
> +       if (!ASSERT_EQ(skel->bss->xfrm_replay_window, 42, "replay_window"=
))
> +               goto done;
>
>  done:
>         delete_xfrm_tunnel();
> diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools=
/testing/selftests/bpf/progs/test_tunnel_kern.c
> index 3a59eb9c34de..c0dd38616562 100644
> --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> @@ -30,6 +30,10 @@ int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx,
>                           struct bpf_fou_encap *encap, int type) __ksym;
>  int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
>                           struct bpf_fou_encap *encap) __ksym;
> +struct xfrm_state *
> +bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *o=
pts,
> +                      u32 opts__sz) __ksym;
> +void bpf_xdp_xfrm_state_release(struct xfrm_state *x) __ksym;
>
>  struct {
>         __uint(type, BPF_MAP_TYPE_ARRAY);
> @@ -950,4 +954,51 @@ int xfrm_get_state(struct __sk_buff *skb)
>         return TC_ACT_OK;
>  }
>
> +volatile int xfrm_replay_window =3D 0;
> +
> +SEC("xdp")
> +int xfrm_get_state_xdp(struct xdp_md *xdp)
> +{
> +       struct bpf_xfrm_state_opts opts =3D {};
> +       struct xfrm_state *x =3D NULL;
> +       struct ip_esp_hdr *esph;
> +       struct bpf_dynptr ptr;
> +       u8 esph_buf[8] =3D {};
> +       u8 iph_buf[20] =3D {};
> +       struct iphdr *iph;
> +       u32 off;
> +
> +       if (bpf_dynptr_from_xdp(xdp, 0, &ptr))
> +               goto out;
> +
> +       off =3D sizeof(struct ethhdr);
> +       iph =3D bpf_dynptr_slice(&ptr, off, iph_buf, sizeof(iph_buf));
> +       if (!iph || iph->protocol !=3D IPPROTO_ESP)
> +               goto out;
> +
> +       off +=3D sizeof(struct iphdr);
> +       esph =3D bpf_dynptr_slice(&ptr, off, esph_buf, sizeof(esph_buf));
> +       if (!esph)
> +               goto out;
> +
> +       opts.netns_id =3D BPF_F_CURRENT_NETNS;
> +       opts.daddr.a4 =3D iph->daddr;
> +       opts.spi =3D esph->spi;
> +       opts.proto =3D IPPROTO_ESP;
> +       opts.family =3D AF_INET;
> +
> +       x =3D bpf_xdp_get_xfrm_state(xdp, &opts, sizeof(opts));
> +       if (!x || opts.error)

nit: how can opts.error be non zero if x =3D=3D NULL?


Eyal.


> +               goto out;
> +
> +       if (!x->replay_esn)
> +               goto out;
> +
> +       xfrm_replay_window =3D x->replay_esn->replay_window;
> +out:
> +       if (x)
> +               bpf_xdp_xfrm_state_release(x);
> +       return XDP_PASS;
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
> --
> 2.42.1
>

