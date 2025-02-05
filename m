Return-Path: <linux-kselftest+bounces-25745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A262A28093
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 02:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89FDF7A3DB5
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 01:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABC142052;
	Wed,  5 Feb 2025 01:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvEaUhdp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0422F43;
	Wed,  5 Feb 2025 01:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738717522; cv=none; b=btSGOUJItd4tR/0TIOCAcUffrGFY74mSewrlxFRfUDFz6prNQLbauVUMKD4VyvHLGnU4mJPdHQCoBarJbmM+NOJjnA+kr1urPvlpFMDk1IW/Xuf68DV2i/9IQN6VnswdV4NI/kIrTSCNOskOcL7dShzWg6+RyXfqxiieEPZDzkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738717522; c=relaxed/simple;
	bh=7vL1iclfVpKxu925UkU7LhOSPGQwgfUzy/hKHdblj8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvWgMIIJMVj+DZzpQMM1idMOUUN8uubhhWRWxIR1gJIlReF/SQVGvHXdqNZiAJJzK2R/ihk/P1sPIlItDrC3fPAMt1UxvVJxQ+qSUl39jd3S82ConDsOwX1hFwiAORGf5lhDJGB/AHku7WX8L6Rxg9shukGUk1XyHOXcc0JB9lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvEaUhdp; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21634338cfdso54513145ad.2;
        Tue, 04 Feb 2025 17:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738717519; x=1739322319; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BU7gpRZNtZd4YkMjoYUK8uFnG/DJrk9+8BiLG4sDqag=;
        b=EvEaUhdpJsSlZytiOkC/StxNmQ7Hm5y3Lp9bGqv/J3Qa9X1jJd5D9mH8spnIeNoOe0
         nJfp2soXGK6O7O9g5JxSYU3HdjMAZ6sRUc8HQaewXJaw/CdAyAxhR9m9EoMOorutHnbv
         FnQDxvwSWN8N4sGNcC4FAR6A07twImsRj9eBpPOesumsdNSkbaY/I/2ZnRtK6qJJJosU
         F0alt9qu+hJLN5HyXrdO/n9rg6+VHNgUBNyo+s6Ojyc8CfoWTYNvbEDZmp9lDlxY5Rre
         EA5a+hFxVOMhROukbnUgS1Hpz437desKPobpIL1ysS1ZJbmZ+1o3fNLikSdgMdlXWPqL
         ImCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738717519; x=1739322319;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BU7gpRZNtZd4YkMjoYUK8uFnG/DJrk9+8BiLG4sDqag=;
        b=ehlU1gH2V8ip/7mgh63b1tm57jq9DkCrUodG6QmYVhq8/MusHZfSwmP9cPkB8EdVov
         a8hCVX+ipVcrOZ5aifELP+2t5f6ma16T7/oHP+VOkKmYRZFZ5k1ZH2R48RKTLzJDFZsB
         /YPKEmCme8zfiJxX53CvzpbK1Vhh4MSJMa9cZQWZP/hAJagOIuRmSiErbslaphAwLOYO
         3l6WwMCokrVq312Bu6AS4HZl39HdMkjmIcPF+nLIILeQvS4Wm4RErY2y/0UTewJIB6au
         FXrP/iDVtvAyZOsdQZ7W/vJaPETCKyWpeH7nZqaqEMBGugmk94uqRmMX89ElD8N+NHsO
         RWnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6AZumBfU+CULngbgHbFD6IRTH1O7/MpoKwCd1FbWzvxYv2w1TMMsO1G9MBWZYzbrnmiuVeX+fbKCZ@vger.kernel.org, AJvYcCU9Ie8RRTxwoL6Tq0PNaW/7bbzIdFmKoaElu42ScY838X2tJFolD8PsNzBDSwq9x8vYMqrLCm2Q2GwYSOU2@vger.kernel.org, AJvYcCUQ2srerYEjv7VVZ4i0pJ4kvKZOnaSstnIG6bpgsY2+uYJg2I6SLkP0Re78yDwfuMEPtzo=@vger.kernel.org, AJvYcCVTtuJzGFBUP2RiGqfvbvl9tpY0lAnJto3i/18I+wav4Pb5t1dvXPziRdzhIAdkzhJRTAJmQIq0@vger.kernel.org, AJvYcCWqZbYSufXj6gNe2c8Ampr2SMa6QGEX+mylX4MbKs4ltdjVNje5teiNF2E4EYmwx1u8CEWAEQYBkclFqzPo8ohk@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr4o+VFk0lpaWnPjnOIn1E2l3q8AqgrnYsVu5QDq1aZ4Of9lKc
	Nf5Io2pygSvb40PkzJR8q27hZPxXWlcRdD9DSxCc9TxRF/CsfzgdO3QhOE8=
X-Gm-Gg: ASbGnctQhEOqLWO3egAMc1DXw+KgK93gvCw557AzohDual+wy6nH2SUTiKvSin2typE
	TPbapPWtJ5XKUTNMK/3/qVldvgqemv43BHq5qW+mXluv2hVpR+psQhuIPran03dDSosKb2aoR+W
	Ndv8y1u65bAu7/Xny4nMFlneykaw8WKy9pGUy4NlmbLae8Ql4rj7YXUKioTiUoQ0Bg3EEcUNaAP
	6fcH50aX61eovP1XWhiFKiPH9ow0eWHLkJ5Z+pLD614tgIBDc1kcRqLOcIIE3Ph1/32U8+GcQxS
	dUIZ126fFWZJBhM=
X-Google-Smtp-Source: AGHT+IH5+nXrvXYLMjkRMHIozAriajOdWhJhRISn3SXna+dvXhvXjPqnYbRhXJ+0gfCOfvWlHmS6XQ==
X-Received: by 2002:a17:902:d508:b0:21d:dfae:300b with SMTP id d9443c01a7336-21f17e2ca29mr17032435ad.10.1738717519468;
        Tue, 04 Feb 2025 17:05:19 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f16408194sm4367715ad.10.2025.02.04.17.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 17:05:18 -0800 (PST)
Date: Tue, 4 Feb 2025 17:05:18 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Mina Almasry <almasrymina@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: Re: [PATCH net-next v3 0/6] Device memory TCP TX
Message-ID: <Z6K5TmSKMcqmgjUK@mini-arch>
References: <20250203223916.1064540-1-almasrymina@google.com>
 <a97c4278-ea08-4693-a394-8654f1168fea@redhat.com>
 <CAHS8izNZrKVXSXxL3JG3BuZdho2OQZp=nhLuVCrLZjJD1R0EPg@mail.gmail.com>
 <Z6JXFRUobi-w73D0@mini-arch>
 <CAHS8izNXo1cQmA5GijE-UW2X1OU6irMV9FRevL5tZW3B5NQ8rA@mail.gmail.com>
 <Z6Jt62bZEeHnN1JP@mini-arch>
 <CAAywjhTZnyLkCSQTMO1SpJrL-epJMDrWRDAb_UEnR5WuAEvtpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAywjhTZnyLkCSQTMO1SpJrL-epJMDrWRDAb_UEnR5WuAEvtpg@mail.gmail.com>

On 02/04, Samiullah Khawaja wrote:
> On Tue, Feb 4, 2025 at 11:43 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 02/04, Mina Almasry wrote:
> > > On Tue, Feb 4, 2025 at 10:06 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> > > >
> > > > On 02/04, Mina Almasry wrote:
> > > > > On Tue, Feb 4, 2025 at 4:32 AM Paolo Abeni <pabeni@redhat.com> wrote:
> > > > > >
> > > > > > On 2/3/25 11:39 PM, Mina Almasry wrote:
> > > > > > > The TX path had been dropped from the Device Memory TCP patch series
> > > > > > > post RFCv1 [1], to make that series slightly easier to review. This
> > > > > > > series rebases the implementation of the TX path on top of the
> > > > > > > net_iov/netmem framework agreed upon and merged. The motivation for
> > > > > > > the feature is thoroughly described in the docs & cover letter of the
> > > > > > > original proposal, so I don't repeat the lengthy descriptions here, but
> > > > > > > they are available in [1].
> > > > > > >
> > > > > > > Sending this series as RFC as the winder closure is immenient. I plan on
> > > > > > > reposting as non-RFC once the tree re-opens, addressing any feedback
> > > > > > > I receive in the meantime.
> > > > > >
> > > > > > I guess you should drop this paragraph.
> > > > > >
> > > > > > > Full outline on usage of the TX path is detailed in the documentation
> > > > > > > added in the first patch.
> > > > > > >
> > > > > > > Test example is available via the kselftest included in the series as well.
> > > > > > >
> > > > > > > The series is relatively small, as the TX path for this feature largely
> > > > > > > piggybacks on the existing MSG_ZEROCOPY implementation.
> > > > > >
> > > > > > It looks like no additional device level support is required. That is
> > > > > > IMHO so good up to suspicious level :)
> > > > > >
> > > > >
> > > > > It is correct no additional device level support is required. I don't
> > > > > have any local changes to my driver to make this work. I think Stan
> > > > > on-list was able to run the TX path (he commented on fixes to the test
> > > > > but didn't say it doesn't work :D) and one other person was able to
> > > > > run it offlist.
> > > >
> > > > For BRCM I had shared this: https://lore.kernel.org/netdev/ZxAfWHk3aRWl-F31@mini-arch/
> > > > I have similar internal patch for mlx5 (will share after RX part gets
> > > > in). I agree that it seems like gve_unmap_packet needs some work to be more
> > > > careful to not unmap NIOVs (if you were testing against gve).
> > >
> > > Hmm. I think you're right. We ran into a similar issue with the RX
> > > path. The RX path worked 'fine' on initial merge, but it was passing
> > > dmabuf dma-addrs to the dma-mapping API which Jason later called out
> > > to be unsafe. The dma-mapping API calls with dmabuf dma-addrs will
> > > boil down into no-ops for a lot of setups I think which is why I'm not
> > > running into any issues in testing, but upon closer look, I think yes,
> > > we need to make sure the driver doesn't end up passing these niov
> > > dma-addrs to functions like dma_unmap_*() and dma_sync_*().
> > >
> > > Stan, do you run into issues (crashes/warnings/bugs) in your setup
> > > when the driver tries to unmap niovs? Or did you implement these
> > > changes purely for safety?
> >
> > I don't run into any issues with those unmaps in place, but I'm running x86
> > with iommu bypass (and as you mention in the other thread, those
> > calls are no-ops in this case).
> The dma_addr from dma-buf should never enter dma_* APIs. dma-bufs
> exporters have their own implementation of these ops and they could be
> no-op for identity mappings or when iommu is disabled (in a VM? with
> no IOMMU enabled GPA=IOVA). so if we really want to map/unmap/sync
> these addresses the dma-buf APIs should be used to do that. Maybe some
> glue with a memory provider is required for these net_iovs? I think
> the safest option with these is that mappings are never unmapped
> manually by driver until the dma_buf_unmap_attachment is called during
> unbinding? But maybe that complicates things for io_uring?

Correct, we don't want to call dma_* APIs on NIOVs, but currently we
do (unmap on tx completion). I mentioned [0] in another thread, we need
something similar for gve (and eventually mlx). skb_frag_dma_map hides
the mapping, but the unmapping unconditionally explicitly calls dma_ APIs
(in most drivers I've looked at).
 
0: https://lore.kernel.org/netdev/ZxAfWHk3aRWl-F31@mini-arch/

