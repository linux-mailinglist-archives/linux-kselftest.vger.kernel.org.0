Return-Path: <linux-kselftest+bounces-25238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D8EA1DA1F
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 17:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438361885919
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 16:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241DC5FDA7;
	Mon, 27 Jan 2025 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGGV/9sp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFB07BAEC;
	Mon, 27 Jan 2025 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737993887; cv=none; b=a0uk5ChCQNLor8MNMvEhE4Hvq61v9QN1jJrrAGUsUu5PmOFt4Ty5OKY0A9mFgJz4ZLt4yF5ruDvdxGHKMhSKFmdiS/Z7L6s4PQsJzr/1oB9K+pj6V/mL9jX3XII0ezs2tGlKpeEhwVGGKP2mdXopLytGnnBOiLxiGEixYX0TH/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737993887; c=relaxed/simple;
	bh=apZ5E3/lHSBZLZjJrFRNg92Lj7oD7FG7hxu8W7ybIv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTIund1cG6gAGyL/I6U+uYp6/iCP/1s6t3QGmHhzXo+iCiGcxi2rnS+U7Yo+ctR2VuRFyFgN5b9ugUOJ5BJSYgWwo2Ws3l5i7jy1xhezIXPwLfCwPoFe4/U1SZjiqZgrRyqVDYmM/bSOBuk2AypxTjxNCrpKGHzeCxO5I6XsqZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGGV/9sp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2163b0c09afso84285165ad.0;
        Mon, 27 Jan 2025 08:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737993884; x=1738598684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bhtYqaf9HNl2Tvv5wf0rnBEEHSiWm6k/ivguWbD71P0=;
        b=FGGV/9spSfc8Nvz9AzXSQaY+t2Dvgcqmsi80imqIHEITy++wkTQFrJkbTowuxgJ/mt
         NdFa6x9b8OZceCA3fPKozgP9MMHairIN2wNnoVoA+QGSSI+M+1mOvHpN3g+nuhHMAgCv
         iVsVMNzsXCSRrEsfvy19Tzt97QuqK5BAiePekza+RgnjsieIm24oTUUCg+J4wOxx7MTT
         b8rHlAOh5LrpFSpkRZJQ7nOd8SlkiK7YoP3hb8aCqCYJPPjQXh1T4D/miTVEd9MAzZuP
         9PmgHHpbK8B3jRGlvAaDiH0Eg5tvOuBWlB9zhZBO1Y5ubwDPDtddGa+blr68qAfKh+ey
         tzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737993885; x=1738598685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhtYqaf9HNl2Tvv5wf0rnBEEHSiWm6k/ivguWbD71P0=;
        b=pEOgchqX5mq+kF/SIxHB3+BMnc0VGc1/ZxQKuF1T9Frv14EEko+rNjEjMSPb7JNj3g
         qmvJfUaqoUaMXiUCRwafcrzYgNWQC5vgvd7hNYuNAdacCUJk1TCa5RzEwAG79Y+s4HWK
         1JBEQBQgzvXlb1EF8/1gGh70nuCrXArZvHSNQuRdHDzjD6mke40TE2fcCBDgiNLi31Y5
         edXrqh0z533fUE6AsqwD36t0ArnqAlUSrpMnC3LMAvY99dPXQpdtl7V+M6qQwHowbDpr
         SmzNP6n2wjmGnhDTylwO3vly27lG4ws1BE0pw4ZWC2JY8kw2sMiHBBeF7WzqQMSY36lO
         yzlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCjs9pnqIkMUdl63yt/17cwAZBeTF/Lv71LGoisf6CTmcLUrVwkeSSQM1z8B5zxbyoSSliYC1k+NRh@vger.kernel.org, AJvYcCUbqkLlVfO+o1nTqG1SR6xnb6kWf+EejrtXW5Ab4lS9v8bTMVl86bUEpluHswXsug4rj+a+6A3mx5zylOOycfL4@vger.kernel.org, AJvYcCWFOG0f+XCMyJqsx8mEcVSVMK95qJDCDufpP1s+Gev6JTAvAAotsWqfuEh+0ce/H8O9MBc=@vger.kernel.org, AJvYcCXSsYnNlJweNndMJjLsu55512zN+ppnRSe4vxaO1J6pbC1srmsYxYo/N8hxEmUnMr9ormw5ItNKgcFOui+C@vger.kernel.org, AJvYcCXmoUJBpPxsV4ENq+Bdqrn1Nc18OkC8umxpx4ejFkPltmyDMWNFLwbBVXN+H6uWlHoSlXUBpvnF@vger.kernel.org
X-Gm-Message-State: AOJu0YyA17x8xTyaoHv7xplMtxMUndNc3wWtkkfYPPC/EZAmrL2Fya3Q
	4R5Mfg9tVA4kwKIEV1i08mfso0opkO7SAInLYBDCa/PgTv9kNBKs
X-Gm-Gg: ASbGncsFa1QnH6Tm2uvY3d76CCG95x1glQAVS/xoPpPVezO5smbmtaYUGPXVUpp9LJT
	P3mfCR7gdIAEakiB+w8LkR3a8rZskZyEeW/G5izrU4Hi05QmRVhb1R5AxOD41638+1LAkKsjfRH
	2UMjutj1d+jpgYHDUl0rxdNaFAJnwQPVsaepufjZ+AhTJLCcnCj9u61ezaOHr8J9tCLHoGttZ9V
	yegrs3a2FbI9JsYzzBkMKlWeHzx+vBVwo2W6HYtpCYl9jd+QWeImdrZckhE9Wj5oNtmbRuoJSfc
	Q3K2NQ==
X-Google-Smtp-Source: AGHT+IESvwfGyLqmu3jP5n+pNmNlyBZKOsDbT4avridkVgJrMVZ+QuspeR4I4KnEw+lvpFE0YHH7iA==
X-Received: by 2002:a05:6a21:3391:b0:1e0:d123:7166 with SMTP id adf61e73a8af0-1eb2148de80mr63097969637.14.1737993884394;
        Mon, 27 Jan 2025 08:04:44 -0800 (PST)
Received: from gmail.com ([98.97.39.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6b307fsm7317183b3a.46.2025.01.27.08.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 08:04:43 -0800 (PST)
Date: Mon, 27 Jan 2025 08:04:29 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Jiayuan Chen <mrpre@163.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org, edumazet@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, song@kernel.org, andrii@kernel.org, mhal@rbox.co, 
	yonghong.song@linux.dev, daniel@iogearbox.net, xiyou.wangcong@gmail.com, horms@kernel.org, 
	corbet@lwn.net, eddyz87@gmail.com, cong.wang@bytedance.com, shuah@kernel.org, 
	mykolal@fb.com, jolsa@kernel.org, haoluo@google.com, sdf@fomichev.me, 
	kpsingh@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v9 0/5] bpf: fix wrong copied_seq calculation and add
 tests
Message-ID: <i2pmhcfge4my5rl4sy5uvu3lhnbtov5rhcjdrqbwunicnefrzy@uhs35blc47lv>
References: <20250122100917.49845-1-mrpre@163.com>
 <877c6hd5io.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877c6hd5io.fsf@cloudflare.com>

On 2025-01-26 15:16:47, Jakub Sitnicki wrote:
> On Wed, Jan 22, 2025 at 06:09 PM +08, Jiayuan Chen wrote:
> > A previous commit described in this topic
> > http://lore.kernel.org/bpf/20230523025618.113937-9-john.fastabend@gmail.com
> > directly updated 'sk->copied_seq' in the tcp_eat_skb() function when the
> > action of a BPF program was SK_REDIRECT. For other actions, like SK_PASS,
> > the update logic for 'sk->copied_seq' was moved to
> > tcp_bpf_recvmsg_parser() to ensure the accuracy of the 'fionread' feature.
> >
> > That commit works for a single stream_verdict scenario, as it also
> > modified 'sk_data_ready->sk_psock_verdict_data_ready->tcp_read_skb'
> > to remove updating 'sk->copied_seq'.
> >
> > However, for programs where both stream_parser and stream_verdict are
> > active (strparser purpose), tcp_read_sock() was used instead of
> > tcp_read_skb() (sk_data_ready->strp_data_ready->tcp_read_sock).
> > tcp_read_sock() now still updates 'sk->copied_seq', leading to duplicated
> > updates.
> >
> > In summary, for strparser + SK_PASS, copied_seq is redundantly calculated
> > in both tcp_read_sock() and tcp_bpf_recvmsg_parser().
> >
> > The issue causes incorrect copied_seq calculations, which prevent
> > correct data reads from the recv() interface in user-land.
> >
> > Also we added test cases for bpf + strparser and separated them from
> > sockmap_basic, as strparser has more encapsulation and parsing
> > capabilities compared to sockmap.
> >
> > ---
> > V8 -> v9
> > https://lore.kernel.org/bpf/20250121050707.55523-1-mrpre@163.com/
> > Fixed some issues suggested by Jakub Sitnicki.
> >
> > V7 -> V8
> > https://lore.kernel.org/bpf/20250116140531.108636-1-mrpre@163.com/
> > Avoid using add read_sock to psock. (Jakub Sitnicki)
> > Avoid using warpper function to check whether strparser is supported.
> >
> > V3 -> V7:
> > https://lore.kernel.org/bpf/20250109094402.50838-1-mrpre@163.com/
> > https://lore.kernel.org/bpf/20241218053408.437295-1-mrpre@163.com/
> > Avoid introducing new proto_ops. (Jakub Sitnicki).
> > Add more edge test cases for strparser + bpf.
> > Fix patchwork fail of test cases code.
> > Fix psock fetch without rcu lock.
> > Move code of modifying to tcp_bpf.c.
> >
> > V1 -> V3:
> > https://lore.kernel.org/bpf/20241209152740.281125-1-mrpre@163.com/
> > Fix patchwork fail by adding Fixes tag.
> > Save skb data offset for ENOMEM. (John Fastabend)
> > ---
> 
> Thanks for addressing all feedback, Jiayuan. Series LGTM.
> Feel free to carry my tags if there is another iteration.

+1 Thanks Jiayuan for sticking with this.

I've reviewed this a couple times. I had one nit on the if/else branch
for a read call, but I haven't come up with anything better on my end
and this fixes a real bug. So lets take it.

For the series.

Acked-by: John Fastabend <john.fastabend@gmail.com>

> 
> -jkbs

