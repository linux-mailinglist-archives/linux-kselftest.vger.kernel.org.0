Return-Path: <linux-kselftest+bounces-19353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56256996CB0
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 15:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A5E1F21927
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 13:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFD01991D0;
	Wed,  9 Oct 2024 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GC4L+EtS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A938B192D6E;
	Wed,  9 Oct 2024 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481864; cv=none; b=A1RxGXfm8zyVER/vLS9SFAH4fLn6mu3B4X+d0gR8G34DhqWNHrykmDIBtmhksT1Ecf9rSGe9kxh2PXN+s9tV28q6uWX3GZQ97uMmkwQvmkSL4lURqZrHx/vtDoyH0hzDBO5dN2OdPTU9D/dpvu12ibqxpbdM1+qMeyL+xjHitvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481864; c=relaxed/simple;
	bh=7JXbVvEDPzan+Cb5PlA35BuMqUzWL66UXvEGnnp08KM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nm06sZ/vff7mP/Z4h+zNWMyOIA5Av+4D6+z/dhBjV15Soh+vgnqM4uoL0KWCgJ+kxJHxvaCPkfdsudN9VHHYqyc/p47NHF+gjpu7Ycgboz3ktIo0vZdmlVjw1ec6/CX0np+wVgNNOcqCWbnL90/BSpSEcWgNNvKuKpW6psWpEUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GC4L+EtS; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4a3c8b8cf78so2525445137.0;
        Wed, 09 Oct 2024 06:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728481861; x=1729086661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxorcdFJTora9Qz/aUcFQRS7K6k631IINdmiD7aAfHM=;
        b=GC4L+EtSw9JEnRlPqcOh1xBDz4p2JN8+oL4zjC3g68VXKzpvQIsy2OmLfO9a1W2MaZ
         MaUyMLA1X0UG8lxHP00JlYOnWWMqDE1WDb0EBJC0TzJe0sd2uCMfP0kogHkdrQzW/ema
         OnTENG0GGwwyI3QioBQP4e43gq/rIN5X+B18eNwsqVRjNCeHeqt3HzXRCEvk+C3Fco08
         L5nAIIqR6otf4XEx8jAwwQMIlyXrCdomKcCk5aHQ4cIWCzcfaRJBVUmGOIZHm2Fg4kd1
         MOSa8U/go4zDwyVgBxEEGmtZ7KygpD7b2uDFCJTaKsdyuJ6We4w8SBxiL+Z0G2BOMYkl
         bPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728481861; x=1729086661;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zxorcdFJTora9Qz/aUcFQRS7K6k631IINdmiD7aAfHM=;
        b=JZRu4PNypLpPMA7HSHWsNVqcdu+Uxt6GEZuFErBffvGaWMhqUhZdf9tln66X5VAxA6
         FolG2oldqRJGqvffeiRrp99fkaoc/i6lbdIfbu7zxfvpBeffl+7Q/0/wy3impA2+9Mfe
         uW652+b2L6txuofzj74aUcMRhcjGxFprrdVF48KeV9ljocIFM3z3Xm21X7TOWnD4q/aU
         Zo2a4i5z5OBF/PC3e3w76+Jg4UNVFIGGsyG0oHRHUEYroMfG7BUsRZSY14xaU7DnB6H9
         LjhbtrGlCDMedov7Qq1xAeh3tRAzE19rVdTorGu8H8s/+vHgpm56QUFAZqZTUUByXqgf
         J+fw==
X-Forwarded-Encrypted: i=1; AJvYcCUnwLUFht1/st/iAVJkCeFxpYirTbWtIzZniJXVX61dsuMml/vDok3QAmi3Oen0olm/uI+Ijs6f@vger.kernel.org, AJvYcCWecvegcQTaleeTWH/vW/B91uXhyRNlqHTAiMwPPn08nxkSewI3AUO0Z9bxtKhbAh3wCrS6fimjJOxge2M=@vger.kernel.org, AJvYcCXjW7xKlmXvF8Mb0Yioy5pTjXIqsslove7/OYXfBtVj7TKwWuUYFW8fg+5Yq+MGq1NMSp6grBy1zjU4OgIo5pwy@vger.kernel.org
X-Gm-Message-State: AOJu0YyncJD2xsx2FGpgXw3FIdW/TcgMR0Yyd+b05kgj4w5nVIB9/iXA
	2e9+PDPNBMd4ZywLv882lPTJcLCe2xfeFjNGfTWmH1gf+PBKX8em
X-Google-Smtp-Source: AGHT+IHwpE6vd3uwyFp4XXsCWi/iNSPtgTNRAdRiWMJk/LVFKNRqPSLhhy90D7iawGR99/IXZgWY4A==
X-Received: by 2002:a05:6102:c48:b0:4a3:d46a:3597 with SMTP id ada2fe7eead31-4a448e5a6d1mr1768845137.28.1728481861467;
        Wed, 09 Oct 2024 06:51:01 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da74b2123sm46473161cf.20.2024.10.09.06.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 06:51:01 -0700 (PDT)
Date: Wed, 09 Oct 2024 09:51:00 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gur Stavi <gur.stavi@huawei.com>, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 gur.stavi@huawei.com, 
 kuba@kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 shuah@kernel.org
Message-ID: <67068a44bff02_1cca3129431@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241009065837.354332-1-gur.stavi@huawei.com>
References: <67054127bb083_18b21e2943f@willemb.c.googlers.com.notmuch>
 <20241009065837.354332-1-gur.stavi@huawei.com>
Subject: Re: [PATCH net-next v02 1/2] af_packet: allow fanout_add when socket
 is not RUNNING
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Gur Stavi wrote:
> >> @@ -1846,21 +1846,21 @@ static int fanout_add(struct sock *sk, struct fanout_args *args)
> >>  	err = -EINVAL;
> >>
> >>  	spin_lock(&po->bind_lock);
> >> -	if (packet_sock_flag(po, PACKET_SOCK_RUNNING) &&
> >> -	    match->type == type &&
> >> +	if (match->type == type &&
> >>  	    match->prot_hook.type == po->prot_hook.type &&
> >>  	    match->prot_hook.dev == po->prot_hook.dev) {
> >
> > Remaining unaddressed issue is that the socket can now be added
> > before being bound. See comment in v1.
> 
> I extended the psock_fanout test with unbound fanout test.
> 
> As far as I understand, the easiest way to verify bind is to test that
> po->prot_hook.dev != NULL, since we are under a bind_lock anyway.
> But perhaps a more readable and direct approach to test "bind" would be
> to test po->ifindex != -1, as ifindex is commented as "bound device".
> However, at the moment ifindex is not initialized to -1, I can add such
> initialization, but perhaps I do not fully understand all the logic.
> 
> Any preferences?

prot_hook.dev is not necessarily set if a packet socket is bound.
It may be bound to any device. See dev_add_pack and ptype_head.

prot_hook.type, on the other hand, must be set if bound and is only
modified with the bind_lock held too.

Well, and in packet_create. But setsockopt PACKET_FANOUT_ADD also
succeeds in case bind() was not called explicitly first to bind to
a specific device or change ptype.

