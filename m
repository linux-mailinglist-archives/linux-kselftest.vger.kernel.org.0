Return-Path: <linux-kselftest+bounces-42498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AF4BA4B94
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 18:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA24166B25
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 16:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24CA3081C2;
	Fri, 26 Sep 2025 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CoWTEHTR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B86E1C5F1B
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758905795; cv=none; b=c1asUdmlchnCuMfelcVxoBErGFmLQN9v1Xuk8gs1M04jj4zDO4WNM+PCvnJeTlDmyKvsKHxP2MRbbjzs6AlNuC7cg84L9sr6GiAr9ah/uVKtYhIt+8E2VGK6CCOFfE2176dllhOZ5bxy6WQJ80MdfrNeQFl0y4+j4dzCa2Y3kNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758905795; c=relaxed/simple;
	bh=pXbsgR7Ss1aZW3LlfLUf8FaVnZ9Gf2yLcMLB47EnsOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFNeaeXn2bwPbTnKAtzyHh6/vo8j5CDpgEv3WB37quNHTIzk8DBggHDxEgr2K9P6ItZKSyuUTRg6dWi75m8gOUvzH3yEHfWr7PJ2jzNRKA70bBPnKT0K6FeOdkJgCreIXFqTOm0Qq4uI6j/wh3wqz1Ce25oomXFkyUMbeR6ty5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CoWTEHTR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758905793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pXbsgR7Ss1aZW3LlfLUf8FaVnZ9Gf2yLcMLB47EnsOc=;
	b=CoWTEHTRcUr2vMLRYOgll24MCESPKgM8YVcuHG9vO4n8ybwBQdad2WOyTL1s8zgs8CEJB7
	dDdb8fbUXISwP1V3+6VltuYIkqZQ65Wt0bKsQgfBk0F02MOky+7aGE+o+goREUyQFaGMq/
	uAugh4RoT+k0yyiIakXVFC+fwU3Os3I=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-JzmqVHT8N-eYvmGWnL3jzA-1; Fri, 26 Sep 2025 12:56:31 -0400
X-MC-Unique: JzmqVHT8N-eYvmGWnL3jzA-1
X-Mimecast-MFC-AGG-ID: JzmqVHT8N-eYvmGWnL3jzA_1758905791
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33428befbbaso2717043a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 09:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758905791; x=1759510591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXbsgR7Ss1aZW3LlfLUf8FaVnZ9Gf2yLcMLB47EnsOc=;
        b=XMaG8064hvigQvOKl1IOKcKyt2YwACngBT3bFMRKvCMik95buv75/TYEa1ih9033OG
         /p7ys/VpCCwgVwBgZZnPOaUkw+AT55/4GbJMtmTAc3Y2BfmTzYtvbyZmSWLk1BbLeY7D
         iUaXWfdg0xVn9rEqgwZ3DRJeUPLiG9soT58iCwn0TTTXSc9N1QNowR3NZ8kwiinhepj2
         W9zEC3rACANPDlfk/R3/kK//HwsVvbggX8g593EXTJpHZvFGl3yTiPqu2gFXv1a0fMYi
         KTF1QejAGhtq6vB5/wGH5Pr5nzvCXK4D3b+IHbb51KsbSrJsPm26lzxILPRQBmfpKKH1
         KNFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMOACf6aj9IedlgngkE9HfMyojZpf+FWYuPXWarQ9WXJm0fuo3XjRlhAgpBQAKvWO00yTfO9jHDawUc6wLj2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzePBVgktB2rLStABdgrhXw7+3X69ay6MeopcOSaaok4a/coYx
	b1LgvBgK8mm1RHQL+tM0sJJb+nl4LvM00z5Q7cGBOoRbEOgBGQ7ZIH9TR9PmmXpfxS1iCk+tWjV
	sdao6l3YuA38DDBAO+IbYrlH4I2hJz7tdKOINeQBfAe+1yELJuVUr+X4E0s9vpVE41c9Vy8y1UZ
	81TkJaRwQUwzox0mcEEnHpwkXIloze2+dtjtpjZ9rJwesh
X-Gm-Gg: ASbGncvpjude5M0qa2u0nP/GJjckcmxbHJeTjcTGTSgx2nS21h1f/YhqHddZ2rlwcQ3
	XlVokCSsLBZI+Mf+UgstyQdU0/7mFcuKzAJKfgy4t1hMO+vrdd9Nd/3WSAnbECi+NY0n50Qt0op
	aiHy98cvdDDagM/+Rb
X-Received: by 2002:a17:90b:1c8e:b0:330:6d2f:1b5d with SMTP id 98e67ed59e1d1-3342a2e3a0amr9010757a91.26.1758905790889;
        Fri, 26 Sep 2025 09:56:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe/T2nb02ygPzWQlJc91OzCWfWy7tzKbeCqK0AzZtfTw4rJhgRJgzOCPPd+wuatdh/bS3alm4U9h9urtacQQ4=
X-Received: by 2002:a17:90b:1c8e:b0:330:6d2f:1b5d with SMTP id
 98e67ed59e1d1-3342a2e3a0amr9010727a91.26.1758905790446; Fri, 26 Sep 2025
 09:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com> <wcts7brlugr337mcdfbrz5vkhvjikcaql3pdzgke5ahuuut37v@mgcqyo2umu7w>
In-Reply-To: <wcts7brlugr337mcdfbrz5vkhvjikcaql3pdzgke5ahuuut37v@mgcqyo2umu7w>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 26 Sep 2025 18:56:19 +0200
X-Gm-Features: AS18NWDruDib3lxkmBnMwisbhI6jtN_YtNKGNRjNW1-ckH59RRm0Bu1PSqLse0I
Message-ID: <CAGxU2F6pZ7Bp53M3fTpSGDQYnrfxrttQc5bDmQLQX0cseW2A_Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/9] vsock: add namespace support to vhost-vsock
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Sept 2025 at 15:53, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Hi Bobby,
>
> On Tue, Sep 16, 2025 at 04:43:44PM -0700, Bobby Eshleman wrote:
> >This series adds namespace support to vhost-vsock and loopback. It does
> >not add namespaces to any of the other guest transports (virtio-vsock,
> >hyperv, or vmci).
>
> Thanks for this new series and the patience!
> I've been a bit messed up after KVM Forum between personal stuff and
> other things. I'm starting to review and test today, so between this
> afternoon and Monday I hope to send you all my comments.

Okay, I reviewed most of them (I'll do the selftest patches on Monday)
and I think we are near :-)

Just a general suggestion, please spend more time on commit description.
All of them should explain better the reasoning behind. This it will
simplify the review, but also future debug.

Thanks and have a nice weekend!
Stefano


