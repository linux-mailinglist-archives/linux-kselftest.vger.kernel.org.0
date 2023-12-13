Return-Path: <linux-kselftest+bounces-1880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB078122B8
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 00:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F155D1C213B8
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 23:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B7F77B27;
	Wed, 13 Dec 2023 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="WyCWHYX4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LlD5lYks"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68963B0;
	Wed, 13 Dec 2023 15:15:50 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.west.internal (Postfix) with ESMTP id B47952B002A4;
	Wed, 13 Dec 2023 18:15:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 13 Dec 2023 18:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1702509344;
	 x=1702516544; bh=qAygdCK51qJjDo5q40m5Ngxi6wos64jJBcQTm0MRQ0c=; b=
	WyCWHYX46fcf4yRpB4QJF8XIu9nCBpIdTe5KOC6PjkAcRPI88VE3cCY59aI84tKk
	lvWE8h/rmY43pbkmVkJgh9gWG4oyeYcy9RH+1p/e5VXx3drNzvnXi9gOG/zNan18
	4SSBhHNJVJe9+vDi9EXkTtvHpdAReULbtXTBlfqoXM7D39kqQdvnd6TsW8FSth5Q
	Z93ZqSUMOg0okGHAljNPDRohb0oCa9Zdvnu9k5C5zTZrc91nj/V8YpgIsg7fK9gH
	gfAjVqvdylZg6MEXUCYwtskxgllXFRzMxF3UQblMWyPf4iTi6O+ia4bLSBa30kfd
	uq8KdMsOgj687uzmyPAgLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702509344; x=
	1702516544; bh=qAygdCK51qJjDo5q40m5Ngxi6wos64jJBcQTm0MRQ0c=; b=L
	lD5lYksSK8HvmEXhs2gUtGFFakszs6oEknc+mGml784n3MHyZpp9zRd+gDzBo54M
	3eyDzyz2i5glDhFe8FMY9KEFIqGtAFdacOyZCfRhVVxgwF7rmgEAxqNwp8pUa554
	XJglIGgM6RkHDoD4YdtsQi4Nsmu9AOxd27SUlqAFh9/DSxzSsow+2+gil+7VK0Y+
	Xk+GekdtJGNSnyJjLF8pI+fd8WqQoi5GcXa1rtZb1iMJetO44lL7sxO02qDPA8rp
	PEaBl48mFNa+aWj3C+OZgfY1OZi5yskTXr228Yl/9VKoqO2ZbbGN+q5mhK5Ghy1y
	YxfjJY7rTxILo+nVipI+g==
X-ME-Sender: <xms:Hzt6ZVGgze6jEjY3C4RKKdg7Bk_XkGSi2jvzS7juqn1P8ir2zABSOg>
    <xme:Hzt6ZaUkOLxHqpTwyRH9Mayd-plccw8YkFq0nSQBraJC91UUQCVIcLlFxYnZjpCmh
    DVjfSdh98yB8k66kg>
X-ME-Received: <xmr:Hzt6ZXIwUGpjYDwL5Gin95yAGe8b44e1YrPpAtObC75gV8vugXdd372mKIriKSbW0WgpjRW0GnIF9JU_BnZm3aXEVme6Zk9VsKEY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelkedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtugfgjgestheksfdt
    tddtjeenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedtgfeuueeukeeikefgieeukeffleetkeekkeeggeffvedt
    vdejueehueeuleefteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:Hzt6ZbF4phkG2YoxYQ20L_rzugm43vcZnxobc-X0_OiC7mb2OgMEfQ>
    <xmx:Hzt6ZbUtwHkutoqyO_UgyshJ5ZW7gIfrDCzVrfmxLtWdpi4fV4DU0A>
    <xmx:Hzt6ZWOwphn1uDbnQEDT6lZjbRQI8LS4gRKwzzYp9z_MtJhcPRxvOQ>
    <xmx:IDt6ZR8rjYLPoDMtwDftVcVvP7ndnOtIxr9qAmwedJI46phtJ5aiF1eXAEk>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Dec 2023 18:15:41 -0500 (EST)
Date: Wed, 13 Dec 2023 16:15:40 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Eyal Birger <eyal.birger@gmail.com>, daniel@iogearbox.net, 
	davem@davemloft.net, shuah@kernel.org, ast@kernel.org, john.fastabend@gmail.com, 
	kuba@kernel.org, andrii@kernel.org, hawk@kernel.org, steffen.klassert@secunet.com, 
	antony.antony@secunet.com, alexei.starovoitov@gmail.com, yonghong.song@linux.dev, 
	eddyz87@gmail.com, mykolal@fb.com, martin.lau@linux.dev, song@kernel.org, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, devel@linux-ipsec.org
Subject: Re: [PATCH bpf-next v5 9/9] bpf: xfrm: Add selftest for
 bpf_xdp_get_xfrm_state()
Message-ID: <yshbkwaiong7qq2rsgkpvvyvzefnwud5uywbea6ocfxxenzv6s@dn45gdaygaso>
References: <cover.1702325874.git.dxu@dxuuu.xyz>
 <8ec1b885d2e13fcd20944cce9edc0340d993d044.1702325874.git.dxu@dxuuu.xyz>
 <CAHsH6GsdqBN638uqUm+8QkP1_45coucSTL7o=D2wFW-gYjPaBw@mail.gmail.com>
 <7yjkfhrwdphtcljq3odv4jc6lucd32wcg277hfsf4ve2jbo7hp@vuqzwbq5nxjw>
 <CAHsH6Gs1vUQnhR_a4qFnAF37Vx=68Do28sfVfFxQ9pVj9jSzjw@mail.gmail.com>
 <qiv464c4y43mo5rih5k6lgzkbpnj6wsrl52hrhgbxeqj45atun@szmqlmnccm52>
 <CAHsH6Gujycb9RBuRk7QHorLe0Q=Np_tb3uboQfp9KmJnegVXvw@mail.gmail.com>
 <fwadmdjjogp4ybfxfpwovnmnn36jigffopijsuqt4ly4vxqghm@ysqhd25mzylp>
 <fecc7tpmbnqxuxqqolm44ggyeomcr3piabsjkv3pgyzlhyonq6@iiaxf34erjzq>
 <CAP01T770poh_63vBC+Heb9ASJ9pDZd1wTDWAgm5KCYHK9GtE1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP01T770poh_63vBC+Heb9ASJ9pDZd1wTDWAgm5KCYHK9GtE1g@mail.gmail.com>

On Wed, Dec 13, 2023 at 12:13:51AM +0100, Kumar Kartikeya Dwivedi wrote:
> On Tue, 12 Dec 2023 at 20:52, Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > cc Kumar
> >
> > On Tue, Dec 12, 2023 at 09:17:02AM -0700, Daniel Xu wrote:
> > > On Mon, Dec 11, 2023 at 04:25:06PM -0800, Eyal Birger wrote:
> > > > On Mon, Dec 11, 2023 at 3:49 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > > > >
> > > > > On Mon, Dec 11, 2023 at 03:13:07PM -0800, Eyal Birger wrote:
> > > > > > On Mon, Dec 11, 2023 at 2:31 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > > > > > >
> > > > > > > On Mon, Dec 11, 2023 at 01:39:25PM -0800, Eyal Birger wrote:
> > > > > > > > Hi Daniel,
> > > > > > > >
> > > > > > > > Tiny nits below in case you respin this for other reasons:
> > > > > > > >
> > > > > > > > On Mon, Dec 11, 2023 at 12:20 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > > > > > > > >
> > > > > > > > > This commit extends test_tunnel selftest to test the new XDP xfrm state
> > > > > > > > > lookup kfunc.
> > > > > > > > >
> > > > > > > > > Co-developed-by: Antony Antony <antony.antony@secunet.com>
> > > > > > > > > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > > > > > > > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > > > > > > > ---
> > > > > > > > >  .../selftests/bpf/prog_tests/test_tunnel.c    | 20 ++++++--
> > > > > > > > >  .../selftests/bpf/progs/test_tunnel_kern.c    | 51 +++++++++++++++++++
> > > > > > > > >  2 files changed, 67 insertions(+), 4 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> > > > > > > > > index 2d7f8fa82ebd..fc804095d578 100644
> > > > > > > > > --- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> > > > > > > > > +++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> > > > > > > > > @@ -278,7 +278,7 @@ static int add_xfrm_tunnel(void)
> > > > > > > > >         SYS(fail,
> > > > > > > > >             "ip netns exec at_ns0 "
> > > > > > > > >                 "ip xfrm state add src %s dst %s proto esp "
> > > > > > > > > -                       "spi %d reqid 1 mode tunnel "
> > > > > > > > > +                       "spi %d reqid 1 mode tunnel replay-window 42 "
> > > > > > > > >                         "auth-trunc 'hmac(sha1)' %s 96 enc 'cbc(aes)' %s",
> > > > > > > > >             IP4_ADDR_VETH0, IP4_ADDR1_VETH1, XFRM_SPI_IN_TO_OUT, XFRM_AUTH, XFRM_ENC);
> > > > > > > > >         SYS(fail,
> > > > > > > > > @@ -292,7 +292,7 @@ static int add_xfrm_tunnel(void)
> > > > > > > > >         SYS(fail,
> > > > > > > > >             "ip netns exec at_ns0 "
> > > > > > > > >                 "ip xfrm state add src %s dst %s proto esp "
> > > > > > > > > -                       "spi %d reqid 2 mode tunnel "
> > > > > > > > > +                       "spi %d reqid 2 mode tunnel replay-window 42 "
> > > > > > > >
> > > > > > > > nit: why do you need to set the replay-window in both directions?
> > > > > > >
> > > > > > > No reason - probably just careless here.
> > > > > > >
> > > > > > > >
> > > > > > > > >                         "auth-trunc 'hmac(sha1)' %s 96 enc 'cbc(aes)' %s",
> > > > > > > > >             IP4_ADDR1_VETH1, IP4_ADDR_VETH0, XFRM_SPI_OUT_TO_IN, XFRM_AUTH, XFRM_ENC);
> > > > > > > > >         SYS(fail,
> > > > > > > > > @@ -313,7 +313,7 @@ static int add_xfrm_tunnel(void)
> > > > > > > > >          */
> > > > > > > > >         SYS(fail,
> > > > > > > > >             "ip xfrm state add src %s dst %s proto esp "
> > > > > > > > > -                   "spi %d reqid 1 mode tunnel "
> > > > > > > > > +                   "spi %d reqid 1 mode tunnel replay-window 42 "
> > > > > > > > >                     "auth-trunc 'hmac(sha1)' %s 96  enc 'cbc(aes)' %s",
> > > > > > > > >             IP4_ADDR_VETH0, IP4_ADDR1_VETH1, XFRM_SPI_IN_TO_OUT, XFRM_AUTH, XFRM_ENC);
> > > > > > > > >         SYS(fail,
> > > > > > > > > @@ -325,7 +325,7 @@ static int add_xfrm_tunnel(void)
> > > > > > > > >         /* root -> at_ns0 */
> > > > > > > > >         SYS(fail,
> > > > > > > > >             "ip xfrm state add src %s dst %s proto esp "
> > > > > > > > > -                   "spi %d reqid 2 mode tunnel "
> > > > > > > > > +                   "spi %d reqid 2 mode tunnel replay-window 42 "
> > > > > > > > >                     "auth-trunc 'hmac(sha1)' %s 96  enc 'cbc(aes)' %s",
> > > > > > > > >             IP4_ADDR1_VETH1, IP4_ADDR_VETH0, XFRM_SPI_OUT_TO_IN, XFRM_AUTH, XFRM_ENC);
> > > > > > > > >         SYS(fail,
> > > > > > > > > @@ -628,8 +628,10 @@ static void test_xfrm_tunnel(void)
> > > > > > > > >  {
> > > > > > > > >         DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook,
> > > > > > > > >                             .attach_point = BPF_TC_INGRESS);
> > > > > > > > > +       LIBBPF_OPTS(bpf_xdp_attach_opts, opts);
> > > > > > > > >         struct test_tunnel_kern *skel = NULL;
> > > > > > > > >         struct nstoken *nstoken;
> > > > > > > > > +       int xdp_prog_fd;
> > > > > > > > >         int tc_prog_fd;
> > > > > > > > >         int ifindex;
> > > > > > > > >         int err;
> > > > > > > > > @@ -654,6 +656,14 @@ static void test_xfrm_tunnel(void)
> > > > > > > > >         if (attach_tc_prog(&tc_hook, tc_prog_fd, -1))
> > > > > > > > >                 goto done;
> > > > > > > > >
> > > > > > > > > +       /* attach xdp prog to tunnel dev */
> > > > > > > > > +       xdp_prog_fd = bpf_program__fd(skel->progs.xfrm_get_state_xdp);
> > > > > > > > > +       if (!ASSERT_GE(xdp_prog_fd, 0, "bpf_program__fd"))
> > > > > > > > > +               goto done;
> > > > > > > > > +       err = bpf_xdp_attach(ifindex, xdp_prog_fd, XDP_FLAGS_REPLACE, &opts);
> > > > > > > > > +       if (!ASSERT_OK(err, "bpf_xdp_attach"))
> > > > > > > > > +               goto done;
> > > > > > > > > +
> > > > > > > > >         /* ping from at_ns0 namespace test */
> > > > > > > > >         nstoken = open_netns("at_ns0");
> > > > > > > > >         err = test_ping(AF_INET, IP4_ADDR_TUNL_DEV1);
> > > > > > > > > @@ -667,6 +677,8 @@ static void test_xfrm_tunnel(void)
> > > > > > > > >                 goto done;
> > > > > > > > >         if (!ASSERT_EQ(skel->bss->xfrm_remote_ip, 0xac100164, "remote_ip"))
> > > > > > > > >                 goto done;
> > > > > > > > > +       if (!ASSERT_EQ(skel->bss->xfrm_replay_window, 42, "replay_window"))
> > > > > > > > > +               goto done;
> > > > > > > > >
> > > > > > > > >  done:
> > > > > > > > >         delete_xfrm_tunnel();
> > > > > > > > > diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > > > > > > index 3a59eb9c34de..c0dd38616562 100644
> > > > > > > > > --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > > > > > > +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > > > > > > @@ -30,6 +30,10 @@ int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx,
> > > > > > > > >                           struct bpf_fou_encap *encap, int type) __ksym;
> > > > > > > > >  int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
> > > > > > > > >                           struct bpf_fou_encap *encap) __ksym;
> > > > > > > > > +struct xfrm_state *
> > > > > > > > > +bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *opts,
> > > > > > > > > +                      u32 opts__sz) __ksym;
> > > > > > > > > +void bpf_xdp_xfrm_state_release(struct xfrm_state *x) __ksym;
> > > > > > > > >
> > > > > > > > >  struct {
> > > > > > > > >         __uint(type, BPF_MAP_TYPE_ARRAY);
> > > > > > > > > @@ -950,4 +954,51 @@ int xfrm_get_state(struct __sk_buff *skb)
> > > > > > > > >         return TC_ACT_OK;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +volatile int xfrm_replay_window = 0;
> > > > > > > > > +
> > > > > > > > > +SEC("xdp")
> > > > > > > > > +int xfrm_get_state_xdp(struct xdp_md *xdp)
> > > > > > > > > +{
> > > > > > > > > +       struct bpf_xfrm_state_opts opts = {};
> > > > > > > > > +       struct xfrm_state *x = NULL;
> > > > > > > > > +       struct ip_esp_hdr *esph;
> > > > > > > > > +       struct bpf_dynptr ptr;
> > > > > > > > > +       u8 esph_buf[8] = {};
> > > > > > > > > +       u8 iph_buf[20] = {};
> > > > > > > > > +       struct iphdr *iph;
> > > > > > > > > +       u32 off;
> > > > > > > > > +
> > > > > > > > > +       if (bpf_dynptr_from_xdp(xdp, 0, &ptr))
> > > > > > > > > +               goto out;
> > > > > > > > > +
> > > > > > > > > +       off = sizeof(struct ethhdr);
> > > > > > > > > +       iph = bpf_dynptr_slice(&ptr, off, iph_buf, sizeof(iph_buf));
> > > > > > > > > +       if (!iph || iph->protocol != IPPROTO_ESP)
> > > > > > > > > +               goto out;
> > > > > > > > > +
> > > > > > > > > +       off += sizeof(struct iphdr);
> > > > > > > > > +       esph = bpf_dynptr_slice(&ptr, off, esph_buf, sizeof(esph_buf));
> > > > > > > > > +       if (!esph)
> > > > > > > > > +               goto out;
> > > > > > > > > +
> > > > > > > > > +       opts.netns_id = BPF_F_CURRENT_NETNS;
> > > > > > > > > +       opts.daddr.a4 = iph->daddr;
> > > > > > > > > +       opts.spi = esph->spi;
> > > > > > > > > +       opts.proto = IPPROTO_ESP;
> > > > > > > > > +       opts.family = AF_INET;
> > > > > > > > > +
> > > > > > > > > +       x = bpf_xdp_get_xfrm_state(xdp, &opts, sizeof(opts));
> > > > > > > > > +       if (!x || opts.error)
> > > > > > > >
> > > > > > > > nit: how can opts.error be non zero if x == NULL?
> > > > > > >
> > > > > > > Ignoring the new -ENOENT case, it can't. Which is why I'm testing that
> > > > > > > behavior here.
> > > > > >
> > > > > > I'm sorry, I don't understand.
> > > > > >
> > > > > > AFAICT, regardless of the -ENOENT change, I don't see
> > > > > > how (!x) is false and (opt.error) is true, and so
> > > > > > "if (!x || opts.error)" is always equivalent to "if (!x)".
> > > > > >
> > > > > > What am I missing?
> > > > > > Eyal.
> > > > >
> > > > > The selftests are tests so my intention was to check edge cases here.
> > > > > In normal operation it shouldn't be possible that
> > > > > bpf_xdp_get_xfrm_state() returns non-NULL and also an error. Maybe
> > > > > another way of writing this would be:
> > > > >
> > > > >         if (!x)
> > > > >                 goto out;
> > > > >         assert(opts.error == 0);
> > > >
> > > > I think this would convey the "edge case testing" notion better.
> > > >
> > > > >
> > > > > If I'm trying to be too clever (or maybe just wrong) or it's pointless,
> > > > > I can remove the `opts.error` condition.
> > > >
> > > > At least for me the tests also serve as references as to how the
> > > > API is expected to be used, so I think it'd be clearer without
> > > > signaling that opts.error could potentially be nonzero on success.
> > > >
> > > > An assertion would indeed make that clear.
> > >
> > > Sure, sounds good. I will check on the new bpf assert infra.
> >
> > Couldn't quite get bpf_assert() working. The following diff:
> >
> > diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > index c0dd38616562..f00dba85ac5d 100644
> > --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > @@ -8,8 +8,9 @@
> >   */
> >  #include "vmlinux.h"
> >  #include <bpf/bpf_core_read.h>
> > -#include <bpf/bpf_helpers.h>
> >  #include <bpf/bpf_endian.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include "bpf_experimental.h"
> >  #include "bpf_kfuncs.h"
> >  #include "bpf_tracing_net.h"
> >
> > @@ -988,8 +989,9 @@ int xfrm_get_state_xdp(struct xdp_md *xdp)
> >         opts.family = AF_INET;
> >
> >         x = bpf_xdp_get_xfrm_state(xdp, &opts, sizeof(opts));
> > -       if (!x || opts.error)
> > +       if (!x)
> >                 goto out;
> > +       bpf_assert_with(opts.error == 0, XDP_PASS);
> >
> >         if (!x->replay_esn)
> >                 goto out;
> >
> > results in:
> >
> > 57: (b7) r1 = 2                       ; R1_w=2 refs=5
> > 58: (85) call bpf_throw#115436
> > calling kernel function bpf_throw is not allowed
> >
> 
> I think this might be because bpf_throw is not registered for use by
> BPF_PROG_TYPE_XDP. I would simply register the generic_kfunc_set for
> this program type as well, since it's already done for TC.

Ah yeah, that was it.

> 
> > It looks like the above error comes from verifier.c:fetch_kfunc_meta,
> > but I can run the exceptions selftests just fine with the same bzImage.
> > So I'm thinking it's not a kfunc registration or BTF issue.
> >
> > Maybe it's cuz I'm holding onto KFUNC_ACQUIRE'd `x`? Not sure.
> >
> 
> Yes, even once you enable this, this will fail for now. I am sending
> out a series later this week that enables bpf_throw with acquired
> references, but until then may I suggest the following:
> 
> #define bpf_assert_if(cond) for (int ___i = 0, ___j = (cond); !(___j) \
> && !___j; bpf_throw(), ___i++)
> 
> This will allow you to insert some cleanup code with an assertion.
> Then in my series, I will convert this temporary bpf_assert_if back to
> the normal bpf_assert.
> 
> It would look like:
> bpf_assert_if(opts.error == 0) {
>   // Execute if assertion failed
>   bpf_xdp_xfrm_state_release(x);
> }
> 
> Likewise for bpf_assert_with_if, you get the idea.

I gave it a try and I'm getting this compile error:

        progs/test_tunnel_kern.c:996:2: error: variable '___j' used in loop condition not modified in loop body [-Werror,-Wfor-loop-analysis]
                bpf_assert_with_if(opts.error == 0, XDP_PASS) {
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        /home/dxu/dev/linux/tools/testing/selftests/bpf/bpf_experimental.h:295:38: note: expanded from macro 'bpf_assert_with_if'
                for (int ___i = 0, ___j = (cond); !(___j) && !___j; bpf_throw(value), ___i++)
                                                    ^~~~      ~~~~
        1 error generated.
        make: *** [Makefile:618: /home/dxu/dev/linux/tools/testing/selftests/bpf/test_tunnel_kern.bpf.o] Error 1

Seems like the compiler is being clever.

Thanks,
Daniel

