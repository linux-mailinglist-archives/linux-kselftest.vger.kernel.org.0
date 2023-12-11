Return-Path: <linux-kselftest+bounces-1629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 777B980DE47
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 23:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E20FEB2125E
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 22:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B241C20DD2;
	Mon, 11 Dec 2023 22:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="MEVPiR4D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LjmlzvY1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F18E3;
	Mon, 11 Dec 2023 14:31:33 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.nyi.internal (Postfix) with ESMTP id 99F445808E5;
	Mon, 11 Dec 2023 17:31:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 11 Dec 2023 17:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1702333892; x=1702341092; bh=noYVecovZCVYjE2fXj6XIEKWxth/MKVOHai
	tOHJtIuo=; b=MEVPiR4DhVa93P6GQTLGR172fnYPLABhsrjTKoprx1/W/9u/yvv
	8bKL+Hbj6UIt5vT0mLKwmdp0hoFF3VHaT1yoxlmxT7Fx4xczlg24qwcVZxzl3JZA
	J2WyBOi/9HKtS948GcVt+JxewijiM4N9Pu7QKa3pkSpAApzBPtf22dlK0PdcyV9u
	uwU+gQKIywVSAYIIxMx4GSTlZy10ICuUJ/WlT3+YVHpYvIhr7HaL0BLQsbPBGm+G
	GGvqEnmgfZrxmgTjl0KIyEPzA4Hep+6Lz+B6DvF/4VAOCqaKGi5jL4YF8Juu2dLQ
	MaB8cHXgOm47pRLvogS3QsDCq2NxzIrCUIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1702333892; x=1702341092; bh=noYVecovZCVYjE2fXj6XIEKWxth/MKVOHai
	tOHJtIuo=; b=LjmlzvY1/Fb+wcqkJenetBnlsZ67SYBcLkgOmljkwCcpExYkAXp
	CjWuhP6k4c6NVTOPOr8eTDbki/QCSdwQnKINyqelqZKmvpJCEFMka8b6urbEzMxu
	W3mnw16JLls8MlPLzRXf76kPgWqa0qHXsu+00uuWV+OQKITMPlN36boGMqCLNcPz
	ej7a5swG3eNB2d2ObGIZBVXjxW4lZhmAAWb45G+lN9/cYSqbRV/uODkY+8ymZ5zM
	FSZiuVuBCPtTIrkJyflXdcJNfXni/dDEyah2ABZu8xlFpZ3MxPZHgm+IaC6leVBg
	bEUq2xlifsHY6CrdQaAim1blxlZLcgd+Xwg==
X-ME-Sender: <xms:xI13ZeEHkH8i6x3QkJnGzdd5ArImUKK9FPd73JMAwcRd6thuj8qxtA>
    <xme:xI13ZfWcyWATzR3TEc6E5B6rJKxKy9dFp-Ilnz0Yccn2Gxonv5IjhEkPUpvjvBsd2
    WrgyH48pzLLLCb8xQ>
X-ME-Received: <xmr:xI13ZYJKGHhMjt5IA2RxEALGZAbOVDLtT_PzITBNV4-V8l9hmyY7Hxg6lTKv32B5noOo9Swo5Y2R7CXw-CdjvP4eXTOIDBa10kyK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgudeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefs
    tddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihii
    eqnecuggftrfgrthhtvghrnheptdfgueeuueekieekgfeiueekffelteekkeekgeegffev
    tddvjeeuheeuueelfeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:xI13ZYHxA6YU4n1HJbFaUNGs6jgFIvPUOv97eJsegB0ObPaKAD3Esw>
    <xmx:xI13ZUV-1_fVRZKtoV-K1sHUXCoOTtkggv2fMd4L8EPuGpnzuX1iZQ>
    <xmx:xI13ZbNdteCOTxMvNZyGXUA_n4ktcpeCWlzfsEZfgMCUn5lcxFGgtg>
    <xmx:xI13ZamVUEDkfoTYdv-m_Z_vx4gs6L4tFl0Hj16fZj41uHWlDngQFQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 17:31:30 -0500 (EST)
Date: Mon, 11 Dec 2023 15:31:29 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: daniel@iogearbox.net, davem@davemloft.net, shuah@kernel.org, 
	ast@kernel.org, john.fastabend@gmail.com, kuba@kernel.org, andrii@kernel.org, 
	hawk@kernel.org, steffen.klassert@secunet.com, antony.antony@secunet.com, 
	alexei.starovoitov@gmail.com, yonghong.song@linux.dev, eddyz87@gmail.com, mykolal@fb.com, 
	martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	devel@linux-ipsec.org
Subject: Re: [PATCH bpf-next v5 9/9] bpf: xfrm: Add selftest for
 bpf_xdp_get_xfrm_state()
Message-ID: <7yjkfhrwdphtcljq3odv4jc6lucd32wcg277hfsf4ve2jbo7hp@vuqzwbq5nxjw>
References: <cover.1702325874.git.dxu@dxuuu.xyz>
 <8ec1b885d2e13fcd20944cce9edc0340d993d044.1702325874.git.dxu@dxuuu.xyz>
 <CAHsH6GsdqBN638uqUm+8QkP1_45coucSTL7o=D2wFW-gYjPaBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHsH6GsdqBN638uqUm+8QkP1_45coucSTL7o=D2wFW-gYjPaBw@mail.gmail.com>

On Mon, Dec 11, 2023 at 01:39:25PM -0800, Eyal Birger wrote:
> Hi Daniel,
> 
> Tiny nits below in case you respin this for other reasons:
> 
> On Mon, Dec 11, 2023 at 12:20 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > This commit extends test_tunnel selftest to test the new XDP xfrm state
> > lookup kfunc.
> >
> > Co-developed-by: Antony Antony <antony.antony@secunet.com>
> > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  .../selftests/bpf/prog_tests/test_tunnel.c    | 20 ++++++--
> >  .../selftests/bpf/progs/test_tunnel_kern.c    | 51 +++++++++++++++++++
> >  2 files changed, 67 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> > index 2d7f8fa82ebd..fc804095d578 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> > @@ -278,7 +278,7 @@ static int add_xfrm_tunnel(void)
> >         SYS(fail,
> >             "ip netns exec at_ns0 "
> >                 "ip xfrm state add src %s dst %s proto esp "
> > -                       "spi %d reqid 1 mode tunnel "
> > +                       "spi %d reqid 1 mode tunnel replay-window 42 "
> >                         "auth-trunc 'hmac(sha1)' %s 96 enc 'cbc(aes)' %s",
> >             IP4_ADDR_VETH0, IP4_ADDR1_VETH1, XFRM_SPI_IN_TO_OUT, XFRM_AUTH, XFRM_ENC);
> >         SYS(fail,
> > @@ -292,7 +292,7 @@ static int add_xfrm_tunnel(void)
> >         SYS(fail,
> >             "ip netns exec at_ns0 "
> >                 "ip xfrm state add src %s dst %s proto esp "
> > -                       "spi %d reqid 2 mode tunnel "
> > +                       "spi %d reqid 2 mode tunnel replay-window 42 "
> 
> nit: why do you need to set the replay-window in both directions?

No reason - probably just careless here.

> 
> >                         "auth-trunc 'hmac(sha1)' %s 96 enc 'cbc(aes)' %s",
> >             IP4_ADDR1_VETH1, IP4_ADDR_VETH0, XFRM_SPI_OUT_TO_IN, XFRM_AUTH, XFRM_ENC);
> >         SYS(fail,
> > @@ -313,7 +313,7 @@ static int add_xfrm_tunnel(void)
> >          */
> >         SYS(fail,
> >             "ip xfrm state add src %s dst %s proto esp "
> > -                   "spi %d reqid 1 mode tunnel "
> > +                   "spi %d reqid 1 mode tunnel replay-window 42 "
> >                     "auth-trunc 'hmac(sha1)' %s 96  enc 'cbc(aes)' %s",
> >             IP4_ADDR_VETH0, IP4_ADDR1_VETH1, XFRM_SPI_IN_TO_OUT, XFRM_AUTH, XFRM_ENC);
> >         SYS(fail,
> > @@ -325,7 +325,7 @@ static int add_xfrm_tunnel(void)
> >         /* root -> at_ns0 */
> >         SYS(fail,
> >             "ip xfrm state add src %s dst %s proto esp "
> > -                   "spi %d reqid 2 mode tunnel "
> > +                   "spi %d reqid 2 mode tunnel replay-window 42 "
> >                     "auth-trunc 'hmac(sha1)' %s 96  enc 'cbc(aes)' %s",
> >             IP4_ADDR1_VETH1, IP4_ADDR_VETH0, XFRM_SPI_OUT_TO_IN, XFRM_AUTH, XFRM_ENC);
> >         SYS(fail,
> > @@ -628,8 +628,10 @@ static void test_xfrm_tunnel(void)
> >  {
> >         DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook,
> >                             .attach_point = BPF_TC_INGRESS);
> > +       LIBBPF_OPTS(bpf_xdp_attach_opts, opts);
> >         struct test_tunnel_kern *skel = NULL;
> >         struct nstoken *nstoken;
> > +       int xdp_prog_fd;
> >         int tc_prog_fd;
> >         int ifindex;
> >         int err;
> > @@ -654,6 +656,14 @@ static void test_xfrm_tunnel(void)
> >         if (attach_tc_prog(&tc_hook, tc_prog_fd, -1))
> >                 goto done;
> >
> > +       /* attach xdp prog to tunnel dev */
> > +       xdp_prog_fd = bpf_program__fd(skel->progs.xfrm_get_state_xdp);
> > +       if (!ASSERT_GE(xdp_prog_fd, 0, "bpf_program__fd"))
> > +               goto done;
> > +       err = bpf_xdp_attach(ifindex, xdp_prog_fd, XDP_FLAGS_REPLACE, &opts);
> > +       if (!ASSERT_OK(err, "bpf_xdp_attach"))
> > +               goto done;
> > +
> >         /* ping from at_ns0 namespace test */
> >         nstoken = open_netns("at_ns0");
> >         err = test_ping(AF_INET, IP4_ADDR_TUNL_DEV1);
> > @@ -667,6 +677,8 @@ static void test_xfrm_tunnel(void)
> >                 goto done;
> >         if (!ASSERT_EQ(skel->bss->xfrm_remote_ip, 0xac100164, "remote_ip"))
> >                 goto done;
> > +       if (!ASSERT_EQ(skel->bss->xfrm_replay_window, 42, "replay_window"))
> > +               goto done;
> >
> >  done:
> >         delete_xfrm_tunnel();
> > diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > index 3a59eb9c34de..c0dd38616562 100644
> > --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > @@ -30,6 +30,10 @@ int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx,
> >                           struct bpf_fou_encap *encap, int type) __ksym;
> >  int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
> >                           struct bpf_fou_encap *encap) __ksym;
> > +struct xfrm_state *
> > +bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *opts,
> > +                      u32 opts__sz) __ksym;
> > +void bpf_xdp_xfrm_state_release(struct xfrm_state *x) __ksym;
> >
> >  struct {
> >         __uint(type, BPF_MAP_TYPE_ARRAY);
> > @@ -950,4 +954,51 @@ int xfrm_get_state(struct __sk_buff *skb)
> >         return TC_ACT_OK;
> >  }
> >
> > +volatile int xfrm_replay_window = 0;
> > +
> > +SEC("xdp")
> > +int xfrm_get_state_xdp(struct xdp_md *xdp)
> > +{
> > +       struct bpf_xfrm_state_opts opts = {};
> > +       struct xfrm_state *x = NULL;
> > +       struct ip_esp_hdr *esph;
> > +       struct bpf_dynptr ptr;
> > +       u8 esph_buf[8] = {};
> > +       u8 iph_buf[20] = {};
> > +       struct iphdr *iph;
> > +       u32 off;
> > +
> > +       if (bpf_dynptr_from_xdp(xdp, 0, &ptr))
> > +               goto out;
> > +
> > +       off = sizeof(struct ethhdr);
> > +       iph = bpf_dynptr_slice(&ptr, off, iph_buf, sizeof(iph_buf));
> > +       if (!iph || iph->protocol != IPPROTO_ESP)
> > +               goto out;
> > +
> > +       off += sizeof(struct iphdr);
> > +       esph = bpf_dynptr_slice(&ptr, off, esph_buf, sizeof(esph_buf));
> > +       if (!esph)
> > +               goto out;
> > +
> > +       opts.netns_id = BPF_F_CURRENT_NETNS;
> > +       opts.daddr.a4 = iph->daddr;
> > +       opts.spi = esph->spi;
> > +       opts.proto = IPPROTO_ESP;
> > +       opts.family = AF_INET;
> > +
> > +       x = bpf_xdp_get_xfrm_state(xdp, &opts, sizeof(opts));
> > +       if (!x || opts.error)
> 
> nit: how can opts.error be non zero if x == NULL?

Ignoring the new -ENOENT case, it can't. Which is why I'm testing that
behavior here.

[...]

Thanks,
Daniel

