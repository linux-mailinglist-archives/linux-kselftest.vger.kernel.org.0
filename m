Return-Path: <linux-kselftest+bounces-35605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7ABAE37D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 10:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E47188D3CB
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 08:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB92B20ADE6;
	Mon, 23 Jun 2025 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BI+chq3M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B471FECDF
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750666037; cv=none; b=MYEPz97uaXAffw1Df4gvKo5BafuW3VbSFx71+dNqx0qvLUgZ3F+Nc2RL9BTr+L/3YmVb/j5Bg7ocD438Obh/tO4umqXzFhC/ImFQlsQZpalNubRwBUofsuK2b771dg33mrTkz97ERoe07OmI7UE+dc3PQmmwylHylmfg0a8DAd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750666037; c=relaxed/simple;
	bh=dhmcYeHsQsigeZcrHk+M4JmzBnlMYZpMRTtb2dRaBIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJKfg65LAJH74WGA6w6urtqx23YyyFI9XCFjh5QhNorg8hjLexIQyyPc0J1HMxviA33OM4x6yvDRR+366mC4pnBNlCueZPJD3emuCNN5zr34BGN24LWpJYzuoTiYACDXhrMvSNVTCePCqQMfznKfQtihdSzQr/6+/LxeogqQ3Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BI+chq3M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750666035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dhmcYeHsQsigeZcrHk+M4JmzBnlMYZpMRTtb2dRaBIo=;
	b=BI+chq3M7hVHB0bA32TQvvmmlnhGWVLoONDehScEa1ijUX5Bn9BZOhLsfzFph8KV9QUlFr
	aSt/mMGtC/HeQfi9TQUNg3kDZyQ/ggbrGdQ22IoyGR1gQjeaha3itZe340RpaNThTytMbD
	bTEPjkh2TjerFBvMeb5n2e24CrlqFiY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-Zdsi87MeOlO2nD0uEDrlEQ-1; Mon, 23 Jun 2025 04:07:12 -0400
X-MC-Unique: Zdsi87MeOlO2nD0uEDrlEQ-1
X-Mimecast-MFC-AGG-ID: Zdsi87MeOlO2nD0uEDrlEQ_1750666032
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3141a9a6888so3647245a91.3
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 01:07:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750666032; x=1751270832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhmcYeHsQsigeZcrHk+M4JmzBnlMYZpMRTtb2dRaBIo=;
        b=pBrcJj8DOuqLK/bL3yJKCnmoZB6znYx13Vx1JLUUK00Y5ep05nB+oj/9UYc6tSVMy2
         ecekP5T6aGDdVNovdYwyEK9scomntOn1QuTbBOUIJQ6zJDnD48ybrOMqGcHKt53K3GmG
         MLeQm8EyRZYTYKqAqRDFPIqhAeJnP/4sG6AFy/DBK5/pzWU7nsBeH0HayVQ9BxeF/5y1
         kXr31AAQ3VLN3K2pycpVaxO3YfQuXIPhpQe9yiCvpXxJH94Qz7BBGDgAzw74l4qbYrit
         g70DRK1UXTHfTu3u3SBllGYywgyFWMp6B2mdu3EV8qNW2ifocmRI8wao1yPSLa/Cqqt7
         /nwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+fJ9wFERSRjhAmLw9f9iQ/Bt0pj7eOgasr5A8t38fhfVGV52e6ibs833ydq3GrcFyedFcuCXAeKhuPr9hhdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynTt+F4Ubo/SyenFmHjiS816eXEyCGHVqK1/Zt+YlVz7719Fdx
	92JNCuxH6jAjK1lTPOjw+L0w3M0bTsFqXwks6ldv3aOs0ZiL1OAuoICSL6n+pnLq5PE7OmJBebV
	gzRkNXzU1e9TIsLqLgSDVzu5g0ewM4dkKS5y9z4/aQ6RSXisZEEDaNEypprxcYNzqh+0wyWZie9
	3DAq7GkZ4h7X6bT9eM2M/AQk2ocuZl5RwEkc/DLPsw1AMf
X-Gm-Gg: ASbGncuCcVKrmjbxlAHlkWMR8VaPCF2EFDBYzLZeMgJNER2Irny63RcYaiULHmM7GMN
	T5iFUXrCextELdRelAsUp6GCi9l3lDHRU0CD3VE6EhPYU7FP09oXT+jze0Ye322mW03Sfh+G9Ts
	GcuYsC
X-Received: by 2002:a17:90b:5444:b0:30e:9349:2da2 with SMTP id 98e67ed59e1d1-3159d628b59mr18126480a91.4.1750666031642;
        Mon, 23 Jun 2025 01:07:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVQTOppEHtAfsayyJvo34GLVedX6rLC/x06Rbxlu1q0T6P50V9CQroeozuTXZMW8lnTkCwwxrOBTsZCaXXqkM=
X-Received: by 2002:a17:90b:5444:b0:30e:9349:2da2 with SMTP id
 98e67ed59e1d1-3159d628b59mr18126445a91.4.1750666031289; Mon, 23 Jun 2025
 01:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530-rss-v12-0-95d8b348de91@daynix.com> <20250530-rss-v12-1-95d8b348de91@daynix.com>
 <CACGkMEufffSj1GQMqwf598__-JgNtXRpyvsLtjSbr3angLmJXg@mail.gmail.com>
 <95cb2640-570d-4f51-8775-af5248c6bc5a@daynix.com> <CACGkMEu6fZaErFEu7_UFsykXRL7Z+CwmkcxmvJHC+eN_j0pQvg@mail.gmail.com>
 <4eaa7aaa-f677-4a31-bcc2-badcb5e2b9f6@daynix.com> <CACGkMEu3QH+VdHqQEePYz_z+_bNYswpA-KNxzz0edEOSSkJtWw@mail.gmail.com>
 <75ef190e-49fc-48aa-abf2-579ea31e4d15@daynix.com> <CACGkMEu2n-O0UtVEmcPkELcg9gpML=m5W=qYPjeEjp3ba73Eiw@mail.gmail.com>
 <760e9154-3440-464f-9b82-5a0c66f482ee@daynix.com> <CACGkMEtCr65RFB0jeprX3iQ3ke997AWF0FGH6JW_zuJOLqS5uw@mail.gmail.com>
 <CAOEp5OcybMttzRam+RKQHv4KA-zLnxGrL+UApc5KrAG+op9LKg@mail.gmail.com>
In-Reply-To: <CAOEp5OcybMttzRam+RKQHv4KA-zLnxGrL+UApc5KrAG+op9LKg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 23 Jun 2025 16:07:00 +0800
X-Gm-Features: AX0GCFtKGLSh9bwOyNMqm1wsTSYXIq66dXiloWDLmA7vjP1FAzXUnFKbCzTNLUI
Message-ID: <CACGkMEsfxXtHce2HeYwYxmhB0e5cOjn17qM6zFEt75bQhbtrDw@mail.gmail.com>
Subject: Re: [PATCH net-next v12 01/10] virtio_net: Add functions for hashing
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Andrew Melnychenko <andrew@daynix.com>, Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 1:40=E2=80=AFAM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> > Yuri, can you help to clarify this?
>
> I see here several questions:
> 1. Whether it is ok for the device not to indicate support for XXX_EX has=
h type?
> - I think, yes (strictly speaking, it was better to test that before
> submitting the patches )
> 2. Is it possible that the guest will enable some XXX_EX hash type if
> the device does not indicate that it is supported?
> - No (I think this is part of the spec)

There's another question, is the device allowed to fallback to
VIRTIO_NET_HASH_TYPE_IPv6 if it fails to parse extensions?

> 3. What to do if we migrate between systems with different
> capabilities of hash support/reporting/whatever
> - IMO, at this moment such case should be excluded and only mechanism
> we have for that is the compatible machine version
> - in some future the change of device capabilities can be communicated
> to the driver and _probably_ the driver might be able to communicate
> the change of device capabilities to the OS

Are you suggesting implementing all hash types? Note that Akihiko
raises the issue that in the actual implementation there should be a
limitation of the maximum number of options. If such a limitation is
different between src and dst, the difference could be noticed by the
guest.

> 4. Does it make sense to have fine configuration of hash types mask
> via command-line?
> - IMO, no. This would require the user to have too much knowledge
> about RSS internals
>
> Please let me know if I missed something.
>

Thanks


