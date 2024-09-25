Return-Path: <linux-kselftest+bounces-18336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C67CE985174
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 05:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C652284F44
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 03:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E98A14BFA2;
	Wed, 25 Sep 2024 03:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFIvvS/C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD34314AD19
	for <linux-kselftest@vger.kernel.org>; Wed, 25 Sep 2024 03:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727235075; cv=none; b=CSqIs2WJAKqcswMZVttUXHNwWM5KXTuoucBXVPlxsFfHFgU/15/HXKuctgbGQPz+Uxni1t+1xgHNjV2puAVXh2Y/Sg98AzkB304trX+Bn6GGDbv7VzpC2R+xeuM+xn6mjZ7rj/cz/8dPJDjf5u6zgK5ObUGP2iAEEmljSYkxrDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727235075; c=relaxed/simple;
	bh=M0Ynl+OetR8GBYZEwi4ht5kW6Ch+UvBVR3yT5ZWcE34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptCNlmIWtNWame+9qq26TeVH0DehNFnGPtcrzD0XDp88jhSkYCU8FDrxGapHgR5kwGdpIEIR9dcXsFH2AYmtEMmOM0Z0lhfvnW/WMRDHLWxn2mDRDroC6elz7LDGJqiUg8OdVeQI8B3ePWSsKzadLGWaWT7lZ+C7WbSpn0gIQoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FFIvvS/C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727235072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0Ynl+OetR8GBYZEwi4ht5kW6Ch+UvBVR3yT5ZWcE34=;
	b=FFIvvS/CQYMTvZOM7EAcZo7XJyKmfnUVnhfuMDoSqEDqFCdptSG+8JPI1bLbrvny+78Rl0
	XLjHeW8dnQS0MkZhHtgxrgONGe6dYfWu2ozWl2byXxHOTtTTES5Iugvmo75F0urSy34J+v
	JlbVfbSgjROk44g9e/K9kXEyGdIB2WI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-QxaH_k5xNWOdSFOshqvMSw-1; Tue, 24 Sep 2024 23:31:09 -0400
X-MC-Unique: QxaH_k5xNWOdSFOshqvMSw-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7d50dadb7f8so290417a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 20:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727235068; x=1727839868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0Ynl+OetR8GBYZEwi4ht5kW6Ch+UvBVR3yT5ZWcE34=;
        b=HzP9QKRyVmBpQBhB5wKF9OcfcvFjZzmzCvWZxYSif1poGDrlVM7q7Lg2/6hkNffeST
         N8EDAEsBxhX/Q4fcZZTNTReaV/PD4AErNYvvh95Esz+vHmCinWgwoaq0l192Wze7uYe4
         vqjz1Lt9k0WpN29HSZLAkpw7iPPJCqfKi47PBsI1R+nz2tH+JuglsCG1+ltn1gcBoCEg
         g/tKOadLyKDWTkVOsYXdnblXpRs26R2HodRg06RpXqctZEUq9AuTBeZKIVEXv4grcwIS
         7dH07o4WkLOjJReE1H/eaSg96BSdQJveTG2PmJJOI0MWGpxbHMZ/6qTPYvuQItpSiZ/a
         c7HA==
X-Forwarded-Encrypted: i=1; AJvYcCXetvFUMltBT8F4wM06HKCelzb4iznPXSQSNZr4N6h93vGCbaYBMjcx6tzysFHTo+XNAjG8s59jn1LrEKJDhiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YynBvdRg2QTDslmteYGku32On2DXa+tmigGeuXqaJXSJgbYhQqJ
	2BBXMvAS3XQDQ7leL5Iemv/MwLa6hd+eVM7tD8vIdRfFpLI0QRagC3dcbzGnkdxMoK3Jda8teSc
	kZ976pjwkWESxug2+TWxidhBik37Fi/1LMeaUHBvtgFE2qVyHE4AxL6nkDuytEo9UJ8Ve2qrwTo
	GyeY67GfnnazcmMXFpGb+VnIdDNvXszfHPdHzyOdta
X-Received: by 2002:a17:90a:d18b:b0:2c9:7343:71f1 with SMTP id 98e67ed59e1d1-2e06ac390c5mr2020784a91.14.1727235068210;
        Tue, 24 Sep 2024 20:31:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHSXnVXH4KJFogFRlAqrxz0oHdsU+wQjcpSOWPpZkunKpdZpa8uVOFkj6NCDsQxAw+PRNHCHqUsGcOkqjm3ok=
X-Received: by 2002:a17:90a:d18b:b0:2c9:7343:71f1 with SMTP id
 98e67ed59e1d1-2e06ac390c5mr2020746a91.14.1727235067738; Tue, 24 Sep 2024
 20:31:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com> <20240924-rss-v4-7-84e932ec0e6c@daynix.com>
In-Reply-To: <20240924-rss-v4-7-84e932ec0e6c@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 25 Sep 2024 11:30:56 +0800
Message-ID: <CACGkMEvKPXCPi6=1938J-k8JNA+hHqzRSt1gPQtqBvSfcgGZeQ@mail.gmail.com>
Subject: Re: [PATCH RFC v4 7/9] tun: Introduce virtio-net RSS
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
> RSS is a receive steering algorithm that can be negotiated to use with
> virtio_net. Conventionally the hash calculation was done by the VMM.
> However, computing the hash after the queue was chosen defeats the
> purpose of RSS.
>
> Another approach is to use eBPF steering program. This approach has
> another downside: it cannot report the calculated hash due to the
> restrictive nature of eBPF steering program.
>
> Introduce the code to perform RSS to the kernel in order to overcome
> thse challenges. An alternative solution is to extend the eBPF steering
> program so that it will be able to report to the userspace, but I didn't
> opt for it because extending the current mechanism of eBPF steering
> program as is because it relies on legacy context rewriting, and
> introducing kfunc-based eBPF will result in non-UAPI dependency while
> the other relevant virtualization APIs such as KVM and vhost_net are
> UAPIs.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

If we decide to go this way, we need to make it reusable for macvtap as wel=
l.

Thanks


