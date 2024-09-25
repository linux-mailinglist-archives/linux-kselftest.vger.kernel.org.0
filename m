Return-Path: <linux-kselftest+bounces-18335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E72F985168
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 05:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07FC284309
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 03:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD7A14900F;
	Wed, 25 Sep 2024 03:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cc50jO1v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1EE34CC4
	for <linux-kselftest@vger.kernel.org>; Wed, 25 Sep 2024 03:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727235026; cv=none; b=os6k9sVQ+JPQBjGJhVbcK923sg9L3c6ZwIkTU2ysQFFVm81MbcyiiaUQl132IlUJ2avr1vjpce6BpJ/CxIOJ/nx3Yyc7gUt7ZSwtM06VcT6D0CqeKDmXS6aUImlSyf+LatjuJvq3+Ynk9Q4IPgEv5ZJ/3YBvRzBVaJaE2AyT/uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727235026; c=relaxed/simple;
	bh=/pj+RCuXouKWKKmVNJjkG4mjtgCiJqE6IxJ4EvXxnE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfCOjSV5CUR7IBJUiq9y3kjelj2inSE7Ng4XJ2f7sbxfWY3sc2bZ+5MJVIubHWL+fE8686vn03Ro7MiaXppLau7tCHUs5y/BIYKZbrB9X2MKaBnU1FFzGzgKB36J1vVtvoCGZN+KcE9Y+mEZOl4MflGtspCLLvhDelhm1fPpRqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cc50jO1v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727235024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pj+RCuXouKWKKmVNJjkG4mjtgCiJqE6IxJ4EvXxnE4=;
	b=Cc50jO1vwKFaEKU2XlDyrbNt/ghI8Q4f7OyGi9IdYTcKsiVT1tASj2oYd0URyrZRUE7e1k
	5Xg3T3sKJYlPAyDMdt9z7r6570YQXa97L6GW7EBMhp5bQ1Y3llL19jXoLqYbkqozaQpyDb
	IvLuAhyly3Iw+ra5b+DjdRpRwy+KIH4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-n6Yokn1dPc-yzI5E48kpHg-1; Tue, 24 Sep 2024 23:30:22 -0400
X-MC-Unique: n6Yokn1dPc-yzI5E48kpHg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e070439426so349463a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 20:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727235022; x=1727839822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pj+RCuXouKWKKmVNJjkG4mjtgCiJqE6IxJ4EvXxnE4=;
        b=ux4enUsRBpCPf/APJLv4HtqcZnDIZOHlSNSDZrlGCUAyI5YJUxsswb8bKBKbgpx5Gw
         VGUTfnaggtGytazh7zxLxTrN3NrsnwBDPt9ATBgfmfaY1Engpa/uOc1wx6hCB7Yk1xOX
         LOTLpFNXlgX0UUqmmyXvUNo3OQhxf3wsfgBvDG7tJ01dIor6eH2L85x9uPaCNZrLMe86
         sC89fCx+BAcSz152zzsG+le04FpoQqBN/B2yUMZ4Ibds03cNsUeQ4muFYAYa9PoqChFM
         +EePjtiQsVT0SWSboCyjVhBSKMYFuM+W2rhKx9IMk3ZHc7yjxwwPMTKUqTAPNGKtpag+
         UOcg==
X-Forwarded-Encrypted: i=1; AJvYcCUB5H/9qJlQhpIoHqqHq6NV9nPeGcTT0/ZYfl6RdTOts5EPID7/wNrfWiHvuGbRycxVTdFwqLPtiEcmEJVEmfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYaLpDHP6K+OicNeGS4JFvO6wY10DUWC+B+PPUOpTcVrzKIGEF
	X4EZwGKe4//JTk+JrScj7sarsqTLuwFtkivxaH8O2xzbdTDbucHBfkaJE8BZMpSo80FeNqR+c5A
	LfRUe3VY9AdfunmwWcv9r8bn44w/65H0+OG9jWuXvrbqCTMt+ZnpW3iLBw8XW8+g2N4Kt0xB+Vn
	Az6CyAqDqNeapYlTN7EMDr8n1Qqzdum0CYdOs4mKxP
X-Received: by 2002:a17:90a:f2d5:b0:2da:905a:d88a with SMTP id 98e67ed59e1d1-2e06ae791a7mr1467815a91.21.1727235021753;
        Tue, 24 Sep 2024 20:30:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt284MvmYUlT8+AL6adgtTv8NmOQ1ld/MsvwYgsNGC040Pi/BgPI1vkZfb6OO4Jtnfla96r8UcK+AJSx61zg8=
X-Received: by 2002:a17:90a:f2d5:b0:2da:905a:d88a with SMTP id
 98e67ed59e1d1-2e06ae791a7mr1467782a91.21.1727235021240; Tue, 24 Sep 2024
 20:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
In-Reply-To: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 25 Sep 2024 11:30:08 +0800
Message-ID: <CACGkMEvMuBe5=wQxZMns4R-oJtVOWGhKM3sXy8U6wSQX7c=iWQ@mail.gmail.com>
Subject: Re: [PATCH RFC v4 0/9] tun: Introduce virtio-net hashing feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 5:01=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> virtio-net have two usage of hashes: one is RSS and another is hash
> reporting. Conventionally the hash calculation was done by the VMM.
> However, computing the hash after the queue was chosen defeats the
> purpose of RSS.
>
> Another approach is to use eBPF steering program. This approach has
> another downside: it cannot report the calculated hash due to the
> restrictive nature of eBPF.
>
> Introduce the code to compute hashes to the kernel in order to overcome
> thse challenges.
>
> An alternative solution is to extend the eBPF steering program so that it
> will be able to report to the userspace, but it is based on context
> rewrites, which is in feature freeze. We can adopt kfuncs, but they will
> not be UAPIs. We opt to ioctl to align with other relevant UAPIs (KVM
> and vhost_net).
>

I wonder if we could clone the skb and reuse some to store the hash,
then the steering eBPF program can access these fields without
introducing full RSS in the kernel?

Thanks


