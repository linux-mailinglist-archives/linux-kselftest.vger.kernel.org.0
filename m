Return-Path: <linux-kselftest+bounces-7733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F308A20F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 23:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497682864CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 21:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4C7376FE;
	Thu, 11 Apr 2024 21:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY0KhRdA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB5C12E6C;
	Thu, 11 Apr 2024 21:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712871314; cv=none; b=UeoqVOtb6Fy6N4pN9lfHp4KLklGH9+ZrNvFbqbeT5BInnlxO4tpEd0xjx/0RrF9IjT3oAmPQcKsbwvTEM668wz4Mn/mUlGilt0mEMXk4E2XG456yL0jwYwRcutVt/Nbx9mxXbTttgYjS+LHVDpuW9TZuULNbI1lsbQCZwqnbEaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712871314; c=relaxed/simple;
	bh=PI/v7zf9imTyUebgJBxjgjFvglA8DKk7b3zyb8bg0zA=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZTu+Vo1af/oo8ZL/Jey2qCm2rKNDxAtBwllvGIqC+l8AfRHJo7BXtDx4HitIpyIqAMLpRJ4EgymQUbnT9l6gVzIc5WAtDR/8HiDCKVEM7uKskqm0FF0wRa5JgA04NuL4tKvg5QYneU2MBL879acOf5stzsOcce7l4i1+a+HaF24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hY0KhRdA; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6ea09b6c826so116841a34.0;
        Thu, 11 Apr 2024 14:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712871312; x=1713476112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GZWFnKLGg7a3pKfMnIks+tuuAhpazBSCLZ0rJ/5h14=;
        b=hY0KhRdA2sufJT+SvloV2MLviTO/Yw0AOvLsFdhOXZBoVNnJU9LuNwLIDLI85hu9ow
         S7jzr+uxIAwfcJd3hXvPUhfJNaJkfchoGDCVfxD/WyhBr7aEu+eosvAKha3NFbonTbmR
         +pooynTW4rRGG0oz2BsbqHBh6w4GNj1B/ubK91ab9S2ZYWoZYbO4FaAy83L4eixZBXic
         oq8FIcRumAZiDC6V+Wd5if/8ZHptC2NoUNqR8JBHFAac7E8pQQhZAxXzuGAHLcfGV9wX
         ncQs8iKRCj0zs/Ykxu0X0R4wk1DCKqo8Z0nvOQv6mHUfSuXFIQv8rrhfMWkaKhzqrCoT
         6saA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712871312; x=1713476112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GZWFnKLGg7a3pKfMnIks+tuuAhpazBSCLZ0rJ/5h14=;
        b=Zp8xjwjMggGxsjfu8H5MXjB0PgOBVMSxxUgpOfTiJG0cZ4/dNcRCC5y2OTFWYkvgbJ
         yRWRTWRuyPjLCWPDgjtOLLSSwrL5ej98sszEpK0sGmiR5UMEiTAuKkxbYj+VnzxRAb4V
         qHXEAZLzOuLx3cdsENt+0gncghiCzskXM8/PnlszrbHLGQayz1EgTuY5h6o9Gdhe3qQK
         cD7jsxEqBnrX9g/lRACYBShJ+mq5OEMdYDz+T0NQKTfcCLyKyMzHmiUGVazrG15k7k13
         XfibF8GEx2DMWEqolmFyHZ0QV5AoCVlkzeSV8BvKU4pzfjyHa19klRpZ3wyJb3Cxf7es
         RBMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2x9htW0XJopaka4YgUDct+aRyhNIUaZaHkxyJR4NEYibshh1NZQpawvnUhE0QYO2ZZqY0uAgFR0sf/shQzUc497qva1m21vwhVODSqjH75wvpOPH7bQE8XNfaFprF2pSmCdCyiBSZW0bCGXIr6j+9eVi99MLNPEBthaMRONgSI03adQyb
X-Gm-Message-State: AOJu0Yzlvs70+k4FrNLCySUNIm57dpkaX8pedeNjuZMZ7LJn9XB7bLYa
	PMD1xojwEjkmaXDvWSnz5Wrl8Cg+UzIY9QTF4sfbg/2KinRc9Nq4
X-Google-Smtp-Source: AGHT+IGBrsgvGLTizvk744f8oyIMHrJWHSIqgTxKQfaqnLIiNH0J/w7yGGl2xFsjVWo8ezLtQIgZbg==
X-Received: by 2002:a9d:7c89:0:b0:6ea:1fbc:459f with SMTP id q9-20020a9d7c89000000b006ea1fbc459fmr1057772otn.0.1712871312264;
        Thu, 11 Apr 2024 14:35:12 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id bp37-20020a05620a45a500b0078ec8690764sm537078qkb.87.2024.04.11.14.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 14:35:11 -0700 (PDT)
Date: Thu, 11 Apr 2024 17:35:11 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 dsahern@kernel.org, 
 aduyck@mirantis.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <6618578fc34fa_36e52529429@willemb.c.googlers.com.notmuch>
In-Reply-To: <24daf0f8-1e81-4bdb-81f3-0f95bf4392f4@gmail.com>
References: <20240410153423.107381-1-richardbgobert@gmail.com>
 <20240410153423.107381-6-richardbgobert@gmail.com>
 <66174ec5bbd29_2d6bc629481@willemb.c.googlers.com.notmuch>
 <24daf0f8-1e81-4bdb-81f3-0f95bf4392f4@gmail.com>
Subject: Re: [PATCH net-next v6 5/6] net: gro: move L3 flush checks to
 tcp_gro_receive and udp_gro_receive_segment
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Willem de Bruijn wrote:
> > Richard Gobert wrote:
> >> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
> >> iph->id, ...) against all packets in a loop. These flush checks are used
> >> currently only in tcp flows in GRO.
> >>
> >> These checks need to be done only once in tcp_gro_receive and only against
> >> the found p skb, since they only affect flush and not same_flow.
> > 
> > I don't quite understand where the performance improvements arise.
> > As inet_gro_receive will skip any p that does not match:
> > 
> >       if (!NAPI_GRO_CB(p)->same_flow)
> >               continue;
> > 
> >       iph2 = (struct iphdr *)(p->data + off);
> >       /* The above works because, with the exception of the top
> >        * (inner most) layer, we only aggregate pkts with the same
> >        * hdr length so all the hdrs we'll need to verify will start
> >        * at the same offset.
> >        */
> >       if ((iph->protocol ^ iph2->protocol) |
> >           ((__force u32)iph->saddr ^ (__force u32)iph2->saddr) |
> >           ((__force u32)iph->daddr ^ (__force u32)iph2->daddr)) {
> >               NAPI_GRO_CB(p)->same_flow = 0;
> >               continue;
> >       }
> > 
> > So these checks are already only performed against a p that matches.
> >  
> 
> 
> Thanks for the review!
> 
> flush/flush_id is calculated for all other p with same_flow = 1 (which is
> not always determined to be 0 before inet_gro_receive) and same src/dst
> addr in the bucket. Moving it to udp_gro_receive_segment/tcp_gro_receive
> will make it run only once when a matching p is found.

So this optimization is for flows that are the same up to having the
same saddr/daddr. Aside from stress tests, it seems rare to have many
concurrent flows between the same pair of machines?

> 
> In addition, UDP flows where skb_gro_receive_list is called -
> flush/flush_id is not relevant and does not need to be calculated. 

That makes sense

> In these
> cases total CPU time in GRO should drop. I could post perf numbers for
> this flow as well.
> 
> 
> >> Leveraging the previous commit in the series, in which correct network
> >> header offsets are saved for both outer and inner network headers -
> >> allowing these checks to be done only once, in tcp_gro_receive. As a
> > 
> > Comments should be updated to reflect both TCP and L4 UDP. Can
> > generalize to transport callbacks.
> > 
> >> result, NAPI_GRO_CB(p)->flush is not used at all. In addition, flush_id
> >> checks are more declarative and contained in inet_gro_flush, thus removing
> >> the need for flush_id in napi_gro_cb.
> >>
> >> This results in less parsing code for UDP flows and non-loop flush tests
> >> for TCP flows.
> > 
> > This moves network layer tests out of the network layer callbacks into
> > helpers called from the transport layer callback. And then the helper
> > has to look up the network layer header and demultiplex the protocol
> > again:
> > 
> >     +		if (((struct iphdr *)nh)->version == 6)
> >     +			flush |= ipv6_gro_flush(nh, nh2);
> >     +		else
> >     +			flush |= inet_gro_flush(nh, nh2, p, i != encap_mark);
> > 
> > That just seems a bit roundabout.
> 
> IMO this commit could be a part of a larger change, where all
> loops in gro_list_prepare, inet_gro_receive and ipv6_gro_receive can be
> removed, and the logic for finding a matching p will be moved to L4.  This
> means that when p is found, the rest of the gro_list would not need to be
> traversed and thus would not even dirty cache lines at all. I can provide a
> code snippet which would explain it better.

These loops are exactly the mechanism to find a matching p. Though
with all the callbacks perhaps not the most efficient model. The
hashtable should have solved much of that.

Yes, please share a snippet to understand how you would replace this.

In the meantime, I do suggest sending the first two patches to net,
as they have Fixes tags. And then follow up with this for net-next
separately.

