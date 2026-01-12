Return-Path: <linux-kselftest+bounces-48796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BE1D15CBA
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 00:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 183AB3086E46
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 23:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53978349AF1;
	Mon, 12 Jan 2026 23:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnwgFz9v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1116344025
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 23:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768260080; cv=none; b=b9X8n6tpp2ula0EmJc8qKwXSCk3Tvy6zFib/k40bhvczBOXIUG4O/pfegq5rbIq9H8/pirhK4X5m8r1SN5BynXsTCEodUkEsIv/yw3KMhsah+4cqJvLCvNTXddqXg0B3XiS1wVFKfK5Qit9n0Q3QYcU0Znmvj1mPYUNy16Fd/RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768260080; c=relaxed/simple;
	bh=7L4AuwoQwpFDKJ+QfvB8n+UzDOCrhQdo2yK39qUc8cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAoUzthQm+lQAqxpZfFKAweYzN0iadljCIA7Tp356MuUVF7pGQ631S6nIiI0iLDgNTCLWwsG9u+AOWFPhuJK4zQzM2A1ButfaQysHtU11Jh8BeOPkrLY8cW44IuqXCmMbZu2jTfD7QoAHZNCNKPnOVI48/n6PRS+6XSkP9yjxCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnwgFz9v; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6481bd173c0so1166445d50.2
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 15:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768260072; x=1768864872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jtoLeYJaY/2ODhxZmDU22B5G0cJLjLhdpG7Ly3b1Aek=;
        b=bnwgFz9vs89U9SsRGckgS2XN4MyfrbVDR1dCDH2HClRdZmlUE/XHYWgUfKlFFk7trh
         J6XZTAZzoGBhvbI4xJTxV1ZlAMe+gZD9TUlsc8FDEJ2e3lcvL9OJUz77cb2dS3dm08lk
         u2qddLyeSNf5u8ER8dCX9RfiSxdfKnFtX6LXWI7j8N7Ip7FzH0EzzstIx9pBLXXLaat8
         CwVf2+Tygfn26guy/NAElPnU5Tm1t/yJV0FtgnTQZkSP1AA0vKKOyoiEpcxQL7ci4jjb
         r8vFDHLO21Kg9zpMwL6+pmEgfPFF0R8ICp5V8V0pN0p4BaEx7BisktOLUi7hv8LBlYKq
         HO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768260072; x=1768864872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtoLeYJaY/2ODhxZmDU22B5G0cJLjLhdpG7Ly3b1Aek=;
        b=Ry69CVnwUVvmzEF+0FNKyDiuZrZoY9RHgmfXPt+ViDtaYxrd8DRauc4dVC4BnX0ALo
         kWyhSjWnRkhT7w1cgQaCCa3UYtes9wXgchXh+jqWrepq8VAVVjABeMBfYq6cqU6u34Bn
         KnTZFcb0zcsnZObgm03MLu7TUEYYzqocySa8wL6DdM9tZzBKGI6QitqO3/zM/bV915sw
         XW7EscvgPPEa17fZr1rCIVH3xzPUqVbldnnbPWGhxy8xcbVkTg85ULuOnQSkhphsH670
         24zLIVwPX8nfzJmovEPvm9fB40ZU75VE2B4dGmDh71LVNBTiplfNjIGwbtBIaP5V+h62
         5mQA==
X-Forwarded-Encrypted: i=1; AJvYcCW0gOoJUBqKR1iGOzCX2nv6EkYpYOwkHYQvpNiH0HB6CYnpT9rRkYbvRnXL6iBeBaB4H5ClwdOki6r4IR5MLaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE0LTSUUwKrpUfTCahTZ5CU1UNxa0Y8HYIBPOwCtOyZULqgTh7
	mjrmPt+7ZCw/0vYdpfsV+TXBmMOBeTGOZ9rT+6q8J4CKTUiTdwG0tHKp
X-Gm-Gg: AY/fxX7GVcd2E5Yu0ZXOjJ003KdkpRUnil7v/G2eTHrFNqnD1DcL6d16QGCj8BDK0hu
	iQps6dMoB2+H3HgxnX6l53ylAdw6NHLiDYbQV61HZ9z8GF4XTrcVgos1FGSIwCh3vE73y3bkLmq
	wCJQj0JUttrdyXU/7dJ1TKHD2JiM6V/2Vk3EeF5WQRFJ0Mql5FDzH1peqMH17kLabR9l0bNZLiS
	khrAmZKbC+WG6Bqwsdmhbuwm+anO6nzgEd7NTwsYokVoi6F8U8Pa43O11dwcBBHgbJRcaCeg5Ht
	fqhFXgZmHiNxzVkYstlgVUMDiKm1UQk65UiOQtWFhzREc7GXsR6tcG+sTlW2c3PImXutNgmlMpK
	98FS16GZfv5HzNSZkZMfprusl+2S0o/Wmm4YyAAj9rBlPBsGB5LFq31n8ZqPfLCYrbL7kah93zG
	50pFxL2ItFxK2omGZXcMjNza9jPWzac2/vSg==
X-Google-Smtp-Source: AGHT+IGPR3yHTofTNuLsmIGRF/vxUZuNpadx2Jh/erk6LsyOgtC+kyjO5yp6nCVt3XNr+Y0sCRmwIQ==
X-Received: by 2002:a05:690e:4085:b0:645:5297:3e65 with SMTP id 956f58d0204a3-64716b35ea6mr16989024d50.11.1768260071815;
        Mon, 12 Jan 2026 15:21:11 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6e12ffsm74065287b3.53.2026.01.12.15.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 15:21:11 -0800 (PST)
Date: Mon, 12 Jan 2026 15:21:09 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v13 03/13] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Message-ID: <aWWB5bvx677ep317@devvm11784.nha0.facebook.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
 <20251223-vsock-vmtest-v13-3-9d6db8e7c80b@meta.com>
 <20260111014500-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111014500-mutt-send-email-mst@kernel.org>

On Sun, Jan 11, 2026 at 01:46:43AM -0500, Michael S. Tsirkin wrote:
> On Tue, Dec 23, 2025 at 04:28:37PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Associate reply packets with the sending socket. When vsock must reply
> > with an RST packet and there exists a sending socket (e.g., for
> > loopback), setting the skb owner to the socket correctly handles
> > reference counting between the skb and sk (i.e., the sk stays alive
> > until the skb is freed).
> > 
> > This allows the net namespace to be used for socket lookups for the
> > duration of the reply skb's lifetime, preventing race conditions between
> > the namespace lifecycle and vsock socket search using the namespace
> > pointer.
> > 
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Changes in v11:
> > - move before adding to netns support (Stefano)
> 
> can you explain about the revert please?
> I looked at feedback from Stefano and all he said
> aparently was not to break bisect.

The patch that brings support into vsock_loopback depends on this one to
avoid a introducing a race condition, so it should come before that one.

Best,
Bobby

