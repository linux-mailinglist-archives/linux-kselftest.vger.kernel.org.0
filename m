Return-Path: <linux-kselftest+bounces-29303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A47AA663DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA71175007
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 00:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614BF1D554;
	Tue, 18 Mar 2025 00:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Se7yO4wP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C053F9FE
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 00:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257768; cv=none; b=RqiFx+h7af78XUbball6ZHOsiKp+1IOfFDgjUAyTxpNXras2fTnaa9J4K4KIS7CpOX/hxWwEvJvjpvntxxcc1ODZwxn+I0urBC2ETGTGXqZA23ZwLoZ1NcByrfEnKZBA9Vs8VpgUsk84vpRq3kqU6ebT4ZHWV50hIHpomUHSAhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257768; c=relaxed/simple;
	bh=Iq6VTTpZ7kMw4sehGuzpV0DZTLHk3gC3ZjUxf5EpShY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SG054b9hUU4HiodW1o3txbmwt/4/WudPRT39wKArIxk9I8fxZsIecmi9PKGZWouY1g/mCPAGCj9fajTMEvYEF6R7sANUjambEqMB8BDO8ZlKv40DXTOz7YHLXqbUhJpjtoqH2cudEw9/QXPQ/GNe2m58GnJCqlI2m2WwR3Y0guU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Se7yO4wP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742257765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uGlyUD8vqNUb+95XWNLKTz4/ExHYTFqRQ19vbWD0q9U=;
	b=Se7yO4wP6Q86jgXj8j9GJzlj4leGqxxsZSLnykxduCBia0XGw3x6aPjFan8MTv4otyTnGb
	govatW4RAJMPD6iuYJIq6QrUINMJiV7P+3a9JhLl+2ppDi+n+vmn/F/9nKHEAGKwH8nhqv
	oCc+IGjoqC8MGgIbxLfmxB5WZd+pcjA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-x0ONrCdlPDmaXpH3ALztLw-1; Mon, 17 Mar 2025 20:29:24 -0400
X-MC-Unique: x0ONrCdlPDmaXpH3ALztLw-1
X-Mimecast-MFC-AGG-ID: x0ONrCdlPDmaXpH3ALztLw_1742257763
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff69646218so6932605a91.3
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 17:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742257763; x=1742862563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGlyUD8vqNUb+95XWNLKTz4/ExHYTFqRQ19vbWD0q9U=;
        b=LGaFIUxitrgBYtd/ilBANuC7/BmKZOaBdzqUwB1Sz9yMdUuNR4TWBsVhTKngKv0Qzs
         yK5OAuGoBz9DC17p2mNbQmWJXzsiOCyFmWeiLvyNvaplcwQfzloo3G8w4uBBNuHbOe7r
         diM2H8PhjtkmMZJmd39gJ6hp8wciXz/TNucQ76GvYkY9fZfA46yyfcWoUFunXMB6wSAj
         Czm6AH2NsVmrdm8uRC8jicGTcKWpZj0jIJ8mKY8470ofrNIc1+P1E3jcRaVYB28WYdKw
         BXbP++Fu9qE6qtEsPkXZ++aj5arv5OwQIXtdU7nk6Kaih2ml4Jtjk3yMTHdiDnQf9DLP
         vbtg==
X-Forwarded-Encrypted: i=1; AJvYcCVeCb8DIhTVkxz/CQ+3vinu/FPMJTnkQoSjznGj/YLtBwyicRikTecUhPRaRWH5QdxERiOhohRYWxWSbHIxo7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz44YqGrGCsLiH03jEufuJExPWv46lJQ5aNdCCNLadWiyY7nNS9
	yYrW25/mRsypEVkm9u021NdhT7xBFrvC0kChF12qJWFnBpgfd4BZ/0AShKj0w245bLrT8Wujx86
	oWmOeMeAD/OdXooXS5AVVeDIE6pf3okfbaqvPybBmFMnZTzAu9t1jQXpLo2UV6Xh26fMyx5CTN4
	rTh2l0uACHOhAaXl+XXLWbvO0Gbh5xZSJXA5HRDv5n
X-Gm-Gg: ASbGncsgb7D7Rwn82GJ6Uz07I4uRUaagJpPasOE2wN2S8sVUglu23TdfYKcZWOF4Pss
	NkwJKecMfLHqGa6cqqBMnZMvOKb6zwOOHgGWMj87M6LMseIcYm068THYzmXzmuBSdvgSmHA==
X-Received: by 2002:a17:90b:184e:b0:2ff:4f04:4261 with SMTP id 98e67ed59e1d1-301a5ba9e76mr360775a91.34.1742257763160;
        Mon, 17 Mar 2025 17:29:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOGBbCKgtLfnNUEqdVYBOyaNX4J8YQ0wrsnqj7PZlK8HAfiTPLx5TPUO4ZzYQvRfRq3UkxLbm7lMIv7cr07dk=
X-Received: by 2002:a17:90b:184e:b0:2ff:4f04:4261 with SMTP id
 98e67ed59e1d1-301a5ba9e76mr360742a91.34.1742257762833; Mon, 17 Mar 2025
 17:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-rss-v11-0-4cacca92f31f@daynix.com>
In-Reply-To: <20250317-rss-v11-0-4cacca92f31f@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Mar 2025 08:29:09 +0800
X-Gm-Features: AQ5f1JpeJNqrDdWSKhpRoLtJXf8LNGibcE3CCqsOw8cQQUTRxkqjeK2TKIkholg
Message-ID: <CACGkMEu=pPTd-QHKRDw7noRCTu-18c7JLJNKZCEu5=BHAE0aJQ@mail.gmail.com>
Subject: Re: [PATCH net-next v11 00/10] tun: Introduce virtio-net hashing feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 6:58=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
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
> The patches for QEMU to use this new feature was submitted as RFC and
> is available at:
> https://patchew.org/QEMU/20250313-hash-v4-0-c75c494b495e@daynix.com/
>
> This work was presented at LPC 2024:
> https://lpc.events/event/18/contributions/1963/
>
> V1 -> V2:
>   Changed to introduce a new BPF program type.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v11:
> - Added the missing code to free vnet_hash in patch
>   "tap: Introduce virtio-net hash feature".
> - Link to v10: https://lore.kernel.org/r/20250313-rss-v10-0-3185d73a9af0@=
daynix.com
>

We only have 2 or 3 points that need to be sorted out. Let's hold on
to the iteration until we had an agreement.

Thanks


