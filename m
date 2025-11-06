Return-Path: <linux-kselftest+bounces-45017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CD7C3C79D
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 17:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E0514FDB3F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 16:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DF034F253;
	Thu,  6 Nov 2025 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAxO9H/5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="t8icFj3q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E0634E755
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446251; cv=none; b=PWcYfKa3f5nPf0OOuinNF0GGN2NUtYbh3g7Cw+D6WYfPrkOpCrlXgYILMETacaLcbzgBRhhSniHzn8jQ72pQB532l0ybfWRRoATOLw/exA3+qhWluAESfTmYZoGU0cI6KMjY7q0lMJEHkdZY9WXYeT+Ak97V2b1FD0Wi8KLp6vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446251; c=relaxed/simple;
	bh=0vKjDbLZ5uIsJA1uwTP3kzZUDanfSCuXi6/Z1HKwKG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJs+srkYrFbc4K/peUv5tWWlFXiYYWgu/4gDl5UtA34zU+38SBH4ufNHWLqL48DiHYPbeblPMZAwhnhSSglZaWgvPimZy9YWIK9Qbebay90rd/iP8f7U5phMj67JHpFcvYc0JuGOCnb5tcOVF0wam4s26jcvE8Kzu0z4TZPTfc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZAxO9H/5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=t8icFj3q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762446248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1DG4kG92g8zznE2M/rfvvdgAVk3otj7VoXSOREQcnM=;
	b=ZAxO9H/54zOUwa3Nmh7KPcpS5PLFbh9S72AD2HS79tgw343n/umL2Vxo5zws6udTdKhqet
	/ljVYO8nyv6CI+DOa4CeTX8rubamQSNhQthIZY0YekrzZzxE2YStfzAs5TW1RkaAmsoMZe
	gkKMD/Dk4qx7u+PLbqVk/Yx1XCzhhQc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-suFqDGlqPcKT4BXuCMLbKQ-1; Thu, 06 Nov 2025 11:24:06 -0500
X-MC-Unique: suFqDGlqPcKT4BXuCMLbKQ-1
X-Mimecast-MFC-AGG-ID: suFqDGlqPcKT4BXuCMLbKQ_1762446245
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477594aad41so6876965e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 08:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762446245; x=1763051045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N1DG4kG92g8zznE2M/rfvvdgAVk3otj7VoXSOREQcnM=;
        b=t8icFj3qcK2oUVcdV1K/+09UzGEZx9vO11ghuK8XhkNBhOGU9+2JMp2DYrP0X1IXGa
         f5qOqFxXxly4Dmuet1jPE0cgz/ebUT4Y5EHqFKAxwRjlwdhmUSwVzcX/LTXEkJKCoL2G
         1bYomD1hwC7aEpdmW0VqNAVz7CUiZARrCqhrx1PcbRhquB6nPBNtBEjMI8Vh20NU8/AY
         Q5GMDUufIAgL6IMxoVgsjq/8t3MWai7PBRW6VsThpAi5LFcYns0JYUloxoedv3vFz5wY
         4kvQsYELA846+ONvrH6Gvh7iLba63EZ+rD5rwJswv3cLgN25QSwTUotV7XPkBugu94a/
         uqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446245; x=1763051045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1DG4kG92g8zznE2M/rfvvdgAVk3otj7VoXSOREQcnM=;
        b=B5wGo2NNyd/3jGCil2ZbHfpOw9DTntH0Pe+Zig2CpJfALPG5nEkNofQYgWnMkBCaEP
         dg0itSJkzQLA+tbxLhrpbOa+kq84gs7CeX0P08T7GbTN8nlgF8/6NpJKQaXABFUbg7PF
         WVnJdqEDPf1gwtXhktLpIa1yPvDNSmq9O1eEE2Dqgm62cXPqSlIk++Gft5gB//Ge8pxV
         ieBzyuUDwyGFDtGgmN0z7Ue0ni7MN+DfY6X0OyyjmxWqQEcH6KWfps8WwBnVyi2wCRY5
         1JCMcMbrKEsJBBETFHC5k2BGGir69I68Uld8SJqDG8Yh9T/2VDQNKe0fFpmQct6v1ORU
         IQqg==
X-Forwarded-Encrypted: i=1; AJvYcCUDhM38U2XrddtcAj2cU2+erEDBzCTf+Dl5BKUPOKReoviWq6fpINHNvPvvfCzbFJd+AIZY1lI1UllANjNpw8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc4h//Vnd3K6l+lRoiz/e2b1kCRD/ER6sZpEQIbq+sOfZAUUSm
	Mg6Do+1AjRKLy3GbCoOAnOn+0XxtmPq8+rMolru1bCU65BwKaeBzvogQruFcrJ2kX0zMUqSJ8qx
	U3NhWX0ly4EHdf/Ks0BN3DkytwCK6h3SMOdTZpyA531HuHwbApTaywlJYe880ChqCGSSozg==
X-Gm-Gg: ASbGnctemBY+cvZPugkCqjcfxw6cu/mV/O668IvRwIrgvxjj0vgK4m2/TCN25qppZLi
	BSnYm+O8soSsCB1b7NCgM7aZO4tXRPJSgkKbgn4cSqtItd9+XmtWeirSXeMs/dNwzC5N/ZYojsI
	r2kua8L1ONvrlR4vowKJJQbe1UyWAS2kx4bAhnK8sxwIKsfaNkOc+fBdSmo8ELA9xQIjdKJHCPu
	lHXjSQ1K45kCBTijPiPcrR85lHVdD47uD9kzwLHflWOkzzQWYXpKjjNbdhubC2HfOiwhon2D1a5
	gyaEp/hzVdi0k8k4ehk7eW4BQ/6eBK8pCitpMVXHmmhStLInpUKZ8oP25u6UlrUMLAyPuZNELWR
	M+A==
X-Received: by 2002:a05:600c:5486:b0:477:5a30:1c37 with SMTP id 5b1f17b1804b1-4775ce9de52mr66233975e9.41.1762446245370;
        Thu, 06 Nov 2025 08:24:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0G1GMRMF16+MzLwvDgk0DmYYlo1r00tXQsnMrr1muBaVhluzHBbanGO0G1csDS3yewZ8H4g==
X-Received: by 2002:a05:600c:5486:b0:477:5a30:1c37 with SMTP id 5b1f17b1804b1-4775ce9de52mr66233365e9.41.1762446243795;
        Thu, 06 Nov 2025 08:24:03 -0800 (PST)
Received: from sgarzare-redhat ([78.209.9.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477625c2f77sm56342755e9.9.2025.11.06.08.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:24:03 -0800 (PST)
Date: Thu, 6 Nov 2025 17:23:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 00/14] vsock: add namespace support to
 vhost-vsock
Message-ID: <4vleifija3dfkvhvqixov5d6cefsr5wnwae74xwc5wz55wi6ic@su3h4ffnp3et>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <k4tqyp7wlnbmcntmvzp7oawacfofnnzdi5cjwlj6djxtlo6xai@44ivtv4kgjz2>
 <aP+rCQih4YMm1OAp@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aP+rCQih4YMm1OAp@devvm11784.nha0.facebook.com>

On Mon, Oct 27, 2025 at 10:25:29AM -0700, Bobby Eshleman wrote:
>On Mon, Oct 27, 2025 at 02:28:31PM +0100, Stefano Garzarella wrote:
>> Hi Bobby,
>>
>> >
>> > Changes in v8:
>> > - Break generic cleanup/refactoring patches into standalone series,
>> >  remove those from this series
>>
>> Yep, thanks for splitting the series. I'll review it ASAP since it's a
>> dependency.
>>
>> I was at GSoC mentor summit last week, so I'm bit busy with the backlog, but
>> I'll do my best to review both series this week.
>>
>> Thanks,
>> Stefano
>>
>
>Thanks for the heads up!

I just reviewed the code changes. I skipped the selftest, since we are 
still discussing the other series (indeed I can't apply this anymore on 
top of that), so I'll check the rest later.

Thanks for the great work!

Stefano


