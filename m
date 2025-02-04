Return-Path: <linux-kselftest+bounces-25737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A1EA27B8D
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 20:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A71447A2197
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 19:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3994B219A8A;
	Tue,  4 Feb 2025 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRTu5Z/S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745D9219A6B;
	Tue,  4 Feb 2025 19:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698076; cv=none; b=s/PYGd1iUaZ1Uq/4NGD/i73jxWL7l5gKIof2Ff3Ig1S4fcfU+j0Zr0KuyBo+6ZshFipAqGGnYXW5hg1b3MDGX9ShUELXnCoeS9Q3DIoJfGiP85XSsPAkmJkB75cY+Q8c0cwt9HQUnAYXXnjDY8PoB3uMPwMYIdrTZiODCwb70LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698076; c=relaxed/simple;
	bh=g8wOV25fc1TNoao6bsF+Qxx5FVzYFX03zAjdYVQ2UII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yj+8M/QXhKxPEhzEPU1SgMqQQFrRca1+anj0181WAAjCvXMBEl9YuA8qdyh3pcLi+xmHFrL5J1EqpOpyCNpqOkPnuQNp7tiyqHJwOe++a5uHNil5H3JlQFyw8FbDsstruoHzBSUy5NAc5ty8ylceaRg1PdFQjRILPGfuXNy7SQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRTu5Z/S; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f08b44937so12806925ad.1;
        Tue, 04 Feb 2025 11:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738698073; x=1739302873; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=moi/W+SxGPnzASf9/FXO/gMD1/604PmuIGFT4p/Ba5w=;
        b=HRTu5Z/SOIPa9LRwry2ryl0CKCJ8+nvp1gKgAWmFiNCI3Wowweyg7bgioOAn0z8H/u
         9VsTKJNW+LktOKu6vO4ERSdkU4gTk7OJDxgHoJpQdC/yHUtDhoRQXbKbdqi0KswA3hnx
         2e9HXR8+6eSVpmSD6pKjgpyLLV+bLuGVqabnuQjtZWTt1CBcOwz8N7n2F6NKKt/R7fP7
         Q0VgqcZORBavhCVEczQG7EvkzZ7mpYbUyqq4M999nJ6esujW/R+OEqigAa/NQr7Ninvh
         Va8TqI4rgFk2vQkH9mnJQPubfXfPcQ3AZlzS4n6HbxgAnv3zLWNjPdwRkXPexSR0nAq1
         bczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698073; x=1739302873;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=moi/W+SxGPnzASf9/FXO/gMD1/604PmuIGFT4p/Ba5w=;
        b=A0LE3KwGtx69TO3+6QAX+n1bfFfSnCFKnoOGc0CQuIlcomMWEb87/rUE+2gfeybGw4
         76Q2gjoDOXljpdtbmiVbsmiB1TB5/OYnNsKHoj0/awAdwEkw47tLdVtKErHQy0//DPyC
         zH4qMTwUyAU8WWQd4qkaeXlR2xJL4mdQB9UB1OLZSpcRVBEFaEPJMgpfnwJkxaNOB9Ct
         B+7F+r56CJx2pKwRClttcsLTAlCBIx0r1qrU8/4i7TCGS/JNTtHelV2GgPtp/Oq+7/H7
         qWDuhdu7A7cMLAApf6PCG5hvnEz/lQZEieGw+IBZ4mzNCkNAeZPkdMpc4DiwCiKBKVS2
         X/Tw==
X-Forwarded-Encrypted: i=1; AJvYcCU8v/7mt01WEtIJq5VjJDQnw8P5TkI9EZzOwS2O+omlJfVbbPhXjBQEwBDbp3Q3oJu1Q1SOGBsjQ6oo@vger.kernel.org, AJvYcCUQYS9TeqeAhugMy0T/52VIonpPPiMNZp4gEDdX3yCe6KXbrmaIuQFFcCSyXphEWWSWdZg=@vger.kernel.org, AJvYcCV0RYTdmcFu3isb4x4jzzLplSlfB0hwyIzk+OljURfIPP66ZytIwnP/WW6jxLO3Dju5spZnHtPK@vger.kernel.org, AJvYcCVE10nJ9xdSLgwHUZhTOcyAMo5BYobOz0pGn6vV7ebk6K2GoXQBQzLecf/jOBd7BT/a7EhO71mWbiktlE33@vger.kernel.org, AJvYcCXsjwht2816hFvitJf5GmKE8MlnQwQcfgmtTY8Bc6eqUqFHkvBmVUVjrAvhyk1ckXkPQAUa+9Qxv7VRq06jdx6G@vger.kernel.org
X-Gm-Message-State: AOJu0YyiR9bN7g1YYWl/7Zpp+yTDxX/+syGheHLzffsgJDAe7b3W7WB5
	YthJkkvRo8KlVHxvg7uaUYmfBfoEu90DB00MKs21xnHd0UCXU/k=
X-Gm-Gg: ASbGncur0bkOOvP/OuZYV3Le4dLNMtGuNBZIEiKllaVEWhHegkroYkKGVyQ+GqXdt/X
	FIucJX0SXw964aRs4tjCLGnXpgkWYW+s1QO+tAwwekH9HAoxgvogVX+DMTUGmhc9bAET8PthrFx
	de5GehMxde+SdS+TpygoKCBP5smPaNaLFhadQg+Rli93jwmXUnZvwmfE7s5PZVm0aQfhq42EWhp
	R0LhD2J/AM8Dma9fU7yHQe1t/s7caraWjKrHi9HeTU4c95CdV0rTLTeIbxtgfXjwG7pY/4TrUEv
	H/mn5budmO2pqaI=
X-Google-Smtp-Source: AGHT+IGgTUpEJBBZoo3WwK/fS9jkgh2la10H+C0J5rIPjISmNgP9ogZWiOD7UQ00ALqtKGAiUGE27Q==
X-Received: by 2002:a17:902:f686:b0:21a:8769:302e with SMTP id d9443c01a7336-21f17e47727mr828805ad.14.1738698071707;
        Tue, 04 Feb 2025 11:41:11 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21de33076a8sm99835365ad.208.2025.02.04.11.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:41:11 -0800 (PST)
Date: Tue, 4 Feb 2025 11:41:09 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
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
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v3 0/6] Device memory TCP TX
Message-ID: <Z6JtVUtsZL6cxsTO@mini-arch>
References: <20250203223916.1064540-1-almasrymina@google.com>
 <a97c4278-ea08-4693-a394-8654f1168fea@redhat.com>
 <CAHS8izNZrKVXSXxL3JG3BuZdho2OQZp=nhLuVCrLZjJD1R0EPg@mail.gmail.com>
 <Z6JXFRUobi-w73D0@mini-arch>
 <60550f27-ea6a-4165-8eaa-a730d02a5ddc@redhat.com>
 <CAHS8izMkfQpUQQLAkyfn8=YkGS1MhPN4DXbxFM6jzCKLAVhM2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMkfQpUQQLAkyfn8=YkGS1MhPN4DXbxFM6jzCKLAVhM2A@mail.gmail.com>

On 02/04, Mina Almasry wrote:
> On Tue, Feb 4, 2025 at 10:32 AM Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > On 2/4/25 7:06 PM, Stanislav Fomichev wrote:
> > > On 02/04, Mina Almasry wrote:
> > >> On Tue, Feb 4, 2025 at 4:32 AM Paolo Abeni <pabeni@redhat.com> wrote:
> > >>>
> > >>> On 2/3/25 11:39 PM, Mina Almasry wrote:
> > >>>> The TX path had been dropped from the Device Memory TCP patch series
> > >>>> post RFCv1 [1], to make that series slightly easier to review. This
> > >>>> series rebases the implementation of the TX path on top of the
> > >>>> net_iov/netmem framework agreed upon and merged. The motivation for
> > >>>> the feature is thoroughly described in the docs & cover letter of the
> > >>>> original proposal, so I don't repeat the lengthy descriptions here, but
> > >>>> they are available in [1].
> > >>>>
> > >>>> Sending this series as RFC as the winder closure is immenient. I plan on
> > >>>> reposting as non-RFC once the tree re-opens, addressing any feedback
> > >>>> I receive in the meantime.
> > >>>
> > >>> I guess you should drop this paragraph.
> > >>>
> > >>>> Full outline on usage of the TX path is detailed in the documentation
> > >>>> added in the first patch.
> > >>>>
> > >>>> Test example is available via the kselftest included in the series as well.
> > >>>>
> > >>>> The series is relatively small, as the TX path for this feature largely
> > >>>> piggybacks on the existing MSG_ZEROCOPY implementation.
> > >>>
> > >>> It looks like no additional device level support is required. That is
> > >>> IMHO so good up to suspicious level :)
> > >>>
> > >>
> > >> It is correct no additional device level support is required. I don't
> > >> have any local changes to my driver to make this work. I think Stan
> > >> on-list was able to run the TX path (he commented on fixes to the test
> > >> but didn't say it doesn't work :D) and one other person was able to
> > >> run it offlist.
> > >
> > > For BRCM I had shared this: https://lore.kernel.org/netdev/ZxAfWHk3aRWl-F31@mini-arch/
> > > I have similar internal patch for mlx5 (will share after RX part gets
> > > in). I agree that it seems like gve_unmap_packet needs some work to be more
> > > careful to not unmap NIOVs (if you were testing against gve).
> >
> > What happen if an user try to use devmem TX on a device not really
> > supporting it? Silent data corruption?
> >
> 
> So the tx dma-buf binding netlink API will bind the dma-buf to the
> netdevice. If that fails, the uapi will return failure and devmem tx
> will not be enabled.
> 
> If the dma-binding succeeds, then the device can indeed DMA into the
> dma-addrs in the device. The TX path will dma from the dma-addrs in
> the device just fine and it need not be aware that the dma-addrs are
> coming from a device and not from host memory.
> 
> The only issue that Stan's patches is pointing to, is that the driver
> will likely be passing these dma-buf addresses into dma-mapping APIs
> like dma_unmap_*() and dma_sync_*() functions. Those, AFAIU, will be
> no-ops with dma-buf addresses in most setups, but it's not 100% safe
> to pass those dma-buf addresses to these dma-mapping APIs, so we
> should avoid these calls entirely.
> 
> > Don't we need some way for the device to opt-in (or opt-out) and avoid
> > such issues?
> >
> 
> Yeah, I think likely the driver needs to declare support (i.e. it's
> not using dma-mapping API with dma-buf addresses).

netif_skb_features/ndo_features_check seems like a good fit?

