Return-Path: <linux-kselftest+bounces-9159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DE88B8068
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 21:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9127D1C228E8
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 19:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADE5181CF6;
	Tue, 30 Apr 2024 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yhrCM4Yd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F5A199E85
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2024 19:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714504777; cv=none; b=XANWJZamyPE6w+aNZRD6B8/HCOYMncZS1+hniHu+8n+54nLmdjmrm4xwHfVu3PlG5OOWwgZ3tgQ58JsWzjeBy+DPJ3vzhHs0n++1x/lf1QusqaB9aOGO/cdC0s6ETm5XUVTIsl19gKUuQJk/uvAliKz+efum3HGYprhmx6qGEhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714504777; c=relaxed/simple;
	bh=rXrYXwxz8utS37Zdd/NHXMvvYHT1Pko55fdXpz+a0f8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNQdwtGxsNPFZiOVp0X05lDiBanA2nHph0k3wa5fE3YYVkmxV9/4k/axDi8nYE2OE5Zh/p4+CrTtpoOWeYnsyyYgvv69kxa1XCDOQ4eF58VDYy6KRUUsL4+VERpVUGOFVOL8KoL+tcUUAMWcbMDE9AnnMX9IqPOl/OntbP7f1To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yhrCM4Yd; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51d20472133so4691158e87.3
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2024 12:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714504773; x=1715109573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBbLSd4KX1Ml6Kx/U9tspaOWXAez2c+6/7rMF07WiMA=;
        b=yhrCM4YdS1mVSkC6dZlf25VsI6foSQBCk1DyesxJ/3Nf9GIMHy2gLaao5m1yno4E4y
         LtG62zQbF9BTkR0aOMYlQm1EEMYIDUCq9PMx9uJmf3kKE2VKFDXgbV/etlhd83AV68Mw
         q0LoGQlekuHwfa+7Hc6GI0DZ/Iir29gHWQ93YeFSVeB4ebbTLs1IPAMrizUw1zcYmLPc
         dGrMy+HB86r/BLLws08RKvC1H2mXBtxc86+vZP7uOFNjHzPyfH/Yc46yDsB17PHHg3/8
         cmY8hLG3CzLveY5qMgQT1zM60pq2ET0rzg8DrUA3vcerRTlTRWGeqNRVTZKVEPp06M3c
         o+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714504773; x=1715109573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JBbLSd4KX1Ml6Kx/U9tspaOWXAez2c+6/7rMF07WiMA=;
        b=pkarB750D6kf8OfixHOqYky4QGsvIev61FtlOn5N5l4lV92ySsClTWqUlN/m5Zmhsq
         2L47oEFBO9C871HPiif7Q9b6+hFDJyHR21Fi+GlUTjE+5yqi47QUlnLR1huE+G0ODbFz
         lxH91wZHRrIEcF4yl1Uudqnt5opl2n9xOtDAytCEOUfExBTiUbcK0UfqQpexmhv/dC35
         cMKgZFMItyup+qQR6H/mzX6qibNdxUVNXdiMEHGlmPf+kJwpevqcvFqm1P21cwdz2Amq
         ueUa6A3zQRVLZKQa29yLpbIstoKEkcGlp3oVUU6fzg0NXAgOdb+Zlb7MbtLfCe0IOBhY
         tXdw==
X-Forwarded-Encrypted: i=1; AJvYcCU+6qMXtc8nGZjCmLfBFE3qP9G6a2D2TGB6choaAsWzFKgMD43uY1zlJgtxybM6AhUsp8qrI285gO7gStbq/3YGi8Nqsyl3gGcvqrxwFJ/F
X-Gm-Message-State: AOJu0YxSw3Vh7CdHgTR6TWV/lf+XMoVSOobgfXcXWx2Klk43+u3mmVCh
	3Sd61ihw1b1hwsXLHM90+HAyVL7zBRP7q/DyFVj7d4nF+9DeaHAP5slfR2aFym0+vAukUMjG2rA
	f3GLv4UHSuwh93OyqELPA3Wkik6doi93c1m2g
X-Google-Smtp-Source: AGHT+IEv1vAD5KmPx2DuK83e++oMbqGnWC2h94YZYICJhje+Ouaos+1vgy9d2n+Zn+VtRp04liNfK+AEGoM+Z6BbCWI=
X-Received: by 2002:a05:6512:3492:b0:517:8ad8:c64 with SMTP id
 v18-20020a056512349200b005178ad80c64mr259130lfr.21.1714504772286; Tue, 30 Apr
 2024 12:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403002053.2376017-1-almasrymina@google.com>
 <20240403002053.2376017-8-almasrymina@google.com> <8357256a-f0e9-4640-8fec-23341fc607db@davidwei.uk>
 <CAHS8izPeYryoLdCAQdGQU-wn7YVdtuofVKNvRFjFjhqTDsT7zA@mail.gmail.com>
 <aafbbf09-a33d-4e73-99c8-9ddab5910657@kernel.dk> <CAHS8izMKLYATo6g3xkj_thFo3whCfq6LSoex5s0m5XZd-U7SVQ@mail.gmail.com>
 <11f52113-7b67-4b45-ba1d-29b070050cec@kernel.dk>
In-Reply-To: <11f52113-7b67-4b45-ba1d-29b070050cec@kernel.dk>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 30 Apr 2024 12:19:17 -0700
Message-ID: <CAHS8izP3KtH_CHyQKE+=vrY-yREq5Bb_Kd+KLyJ4j-_AdjNk-Q@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v8 07/14] page_pool: devmem support
To: Jens Axboe <axboe@kernel.dk>
Cc: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Amritha Nambiar <amritha.nambiar@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Christian Brauner <brauner@kernel.org>, Simon Horman <horms@kernel.org>, 
	David Howells <dhowells@redhat.com>, Florian Westphal <fw@strlen.de>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	Aleksander Lobakin <aleksander.lobakin@intel.com>, Michael Lass <bevan@bi-co.net>, 
	Jiri Pirko <jiri@resnulli.us>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Richard Gobert <richardbgobert@gmail.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Johannes Berg <johannes.berg@intel.com>, Abel Wu <wuyun.abel@bytedance.com>, 
	Breno Leitao <leitao@debian.org>, Pavel Begunkov <asml.silence@gmail.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 11:55=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 4/30/24 12:29 PM, Mina Almasry wrote:
> > On Tue, Apr 30, 2024 at 6:46?AM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 4/26/24 8:11 PM, Mina Almasry wrote:
> >>> On Fri, Apr 26, 2024 at 5:18?PM David Wei <dw@davidwei.uk> wrote:
> >>>>
> >>>> On 2024-04-02 5:20 pm, Mina Almasry wrote:
> >>>>> @@ -69,20 +106,26 @@ net_iov_binding(const struct net_iov *niov)
> >>>>>   */
> >>>>>  typedef unsigned long __bitwise netmem_ref;
> >>>>>
> >>>>> +static inline bool netmem_is_net_iov(const netmem_ref netmem)
> >>>>> +{
> >>>>> +#if defined(CONFIG_PAGE_POOL) && defined(CONFIG_DMA_SHARED_BUFFER)
> >>>>
> >>>> I am guessing you added this to try and speed up the fast path? It's
> >>>> overly restrictive for us since we do not need dmabuf necessarily. I
> >>>> spent a bit too much time wondering why things aren't working only t=
o
> >>>> find this :(
> >>>
> >>> My apologies, I'll try to put the changelog somewhere prominent, or
> >>> notify you when I do something that I think breaks you.
> >>>
> >>> Yes, this is a by-product of a discussion with regards to the
> >>> page_pool benchmark regressions due to adding devmem. There is some
> >>> background on why this was added and the impact on the
> >>> bench_page_pool_simple tests in the cover letter.
> >>>
> >>> For you, I imagine you want to change this to something like:
> >>>
> >>> #if defined(CONFIG_PAGE_POOL)
> >>> #if defined(CONFIG_DMA_SHARED_BUFFER) || defined(CONFIG_IOURING)
> >>>
> >>> or something like that, right? Not sure if this is something I should
> >>> do here or if something more appropriate to be in the patches you
> >>> apply on top.
> >>
> >> In general, attempting to hide overhead behind config options is alway=
s
> >> a losing proposition. It merely serves to say "look, if these things
> >> aren't enabled, the overhead isn't there", while distros blindly enabl=
e
> >> pretty much everything and then you're back where you started.
> >>
> >
> > The history there is that this check adds 1 cycle regression to the
> > page_pool fast path benchmark. The regression last I measured is 8->9
> > cycles, so in % wise it's a quite significant 12.5% (more details in
> > the cover letter[1]). I doubt I can do much better than that to be
> > honest.
>
> I'm all for cycle counting, and do it myself too, but is that even
> measurable in anything that isn't a super targeted microbenchmark? Or
> even in that?
>

Not as far as I can tell, no. This was purely to improve the page_pool
benchmark.

> > There was a desire not to pay this overhead in setups that will likely
> > not care about devmem, like embedded devices maybe, or setups without
> > GPUs. Adding a CONFIG check here seemed like very low hanging fruit,
> > but yes it just hides the overhead in some configs, not really removes
> > it.
> >
> > There was a discussion about adding this entire netmem/devmem work
> > under a new CONFIG. There was pushback particularly from Willem that
> > at the end of the day what is enabled on most distros is what matters
> > and we added code churn and CONFIG churn for little value.
> >
> > If there is significant pushback to the CONFIG check I can remove it.
> > I don't feel like it's critical, it just mirco-optimizes some setups
> > that doesn't really care about this work area.
>
> That is true, but in practice it'll be enabled anyway. Seems like it's
> not really worth it in this scenario.
>

OK, no pushback from me. I'll remove the CONFIG check in the next iteration=
.

--=20
Thanks,
Mina

