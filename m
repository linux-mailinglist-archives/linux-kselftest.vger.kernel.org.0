Return-Path: <linux-kselftest+bounces-25095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A5AA1B685
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 14:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C063AF364
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 13:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9E11CD15;
	Fri, 24 Jan 2025 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDiQCtfn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA561524F
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2025 13:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737723660; cv=none; b=dmPgnWwdFNoVnCcSjDsi1pwCKeghU/RFc9ebr5UNCgQtgGVSiMOZWLaHLYBq1CFCY6kgmcj0aBkg2dC40MM1L1iO03jwchJdlnm9cfXbs4a5DudEkHvtr3op/emHbGDu9BtrEe4ZIa3LWLUF0UnkrNfoBYnwUv0/yi3zkIF7sLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737723660; c=relaxed/simple;
	bh=XqSXfaeYkHMa0uyMmCXgrjLlTezxa7CtAQWxJfRf2jI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=seScs7bE2Cz35DJGghguQJ8EtJR5xiji3L3K8VksKnOWz6CKsFOM4eDv+kQJtafc672xUeUE29rrIihhgulPTn0mQQmKJhRPqjfv1ETfBO9FJT/D12aMga/1XI65VecKR2CIjzMrSu1hlvCBha35r71lPGdVp8i7jxJ96PprwOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fDiQCtfn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737723658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vo3fTWya9tHycVPx5tFin/qFgljd4EcPY6jTqMY9tdU=;
	b=fDiQCtfn/cE/O1V81wnMjXQ8/TspnpIANUctmOqOb7xQsz/3SN7OVk26NWuRfibiqU74iq
	NkVRs5GnbBO+Za/teUyPQl4Kab/yye4+lkgw8E1h027ymfhmJyJHEwM+snacG0L2sg0swx
	4rpqBkqP0QP16CgLad3ArvA4g+cO1Gs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-2mnqcL9kNd62zZs7eYF7-g-1; Fri, 24 Jan 2025 08:00:56 -0500
X-MC-Unique: 2mnqcL9kNd62zZs7eYF7-g-1
X-Mimecast-MFC-AGG-ID: 2mnqcL9kNd62zZs7eYF7-g
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385d6ee042eso1547403f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2025 05:00:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737723655; x=1738328455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vo3fTWya9tHycVPx5tFin/qFgljd4EcPY6jTqMY9tdU=;
        b=qBe4skW9iDlu/B1bjWJb4Wq7ZO/KlwhpRpJJLZkSYmGtgD+oXVJMHoxDuvZ8/N2TQA
         j3SLG0qlfqkXeBQ9cZqvlYNVbs6YNMOSFQ6rZeRRrEzSx6+PW3KPCkHD30BDntu42Uf5
         7/wp4rzP9uUlB5jcMWhNUzT4BAGlnILUYwxHUH66Hy1stIqfSDuMTxYImvC2bWBwXIJ4
         SjGJgQL5lmM++hcJ1ssCW2DulMlT8TdEb9aiF3ztOskxfMYduYiotmnyl4cAY4QZabtd
         97iPhC1VJszHsgTqnwRVAq9SH0HDj/TIcl/o0MV7I7Et2WG7P6qg2AxpgAYcrGBOQXwN
         TeKg==
X-Forwarded-Encrypted: i=1; AJvYcCW/jcnmlcGV8zZwAbrMKU62rgeK3xtDgVlheZWspn63nkZgkqOS8I2ZVMqLp30tQ/MtiHpFb8vIZQ7UnqI/dOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwdJ+ml4/4GzI+qeU9O15dyg2rqFOI/zaWGTBwwJcUJvhPNFS/
	FoTXolTNnlpmafbDa6kcsM2U4xWbTAQ2NA2RpOffy66c3g0eUcWyq63E6+0qZSaiBPCgnWRCXcz
	JcGkHySjINDJ67+o6S8nuIcTs/8pJPAHWm2g23WpQEff+ZT+1LxaZdkRmLzwj8iQackEqGbuAqg
	ld
X-Gm-Gg: ASbGnctQNaZqACL0nIIBaNFV6nsZM1caA0XlrXv1tL9eyeqkgqo8+ia2c6lxjwLb6u0
	CtMJRQ93+SwdPUVy1Ou0EHgv+t+jI6/gyTfSn2wGFl5MtHQe1m78SUBVAi0mJs2GppHBq/HsWzO
	Miu8zHIG0CEXLlAKE8uwnEF3oloNYTnI3659P1fwO3O5HcNIdCI3d/Ug3su8whhCvFXe2QIuXt4
	v15bY/1wH8z6YwOn/a3DmC/AEE+1a55svKJjcVxqqevzlMl6sHugcR1Y5TjhUpXqT/cJqITBwIr
	kQYw77ReZSEWlS7iZO0QVp/l9WLLOmxrOkgnE7qp3tAC4A==
X-Received: by 2002:a5d:5f54:0:b0:385:fa33:29ed with SMTP id ffacd0b85a97d-38bf57d2cc4mr26674291f8f.47.1737723655028;
        Fri, 24 Jan 2025 05:00:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7O6kDxKgj8QXof6pkh0HnABdfU01AfCfVNwm0lMd0ZfNC4JqKT86eG7V6rVx2a63lUIXoHw==
X-Received: by 2002:a5d:5f54:0:b0:385:fa33:29ed with SMTP id ffacd0b85a97d-38bf57d2cc4mr26674235f8f.47.1737723654623;
        Fri, 24 Jan 2025 05:00:54 -0800 (PST)
Received: from [192.168.0.167] (h-185-57-5-149.na.cust.bahnhof.fi. [185.57.5.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4857cesm25657015e9.13.2025.01.24.05.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 05:00:54 -0800 (PST)
Message-ID: <298675d0-ba19-4c87-b00d-57a5e31b05b6@redhat.com>
Date: Fri, 24 Jan 2025 15:00:51 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
To: Jarkko Sakkinen <jarkko@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 =?UTF-8?Q?Leonardo_Br=C3=A1s?= <leobras.c@gmail.com>
Cc: Vignesh Raman <vignesh.raman@collabora.com>, kernelci@lists.linux.dev,
 linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, mripard@kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com,
 pawiecz@collabora.com, spbnick@gmail.com, tales.aparecida@gmail.com,
 workflows@vger.kernel.org, skhan@linuxfoundation.org,
 kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com,
 cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com,
 kernel@collabora.com, torvalds@linuxfoundation.org,
 gregkh@linuxfoundation.org, daniels@collabora.com,
 helen.koike@collabora.com, shreeya.patel@collabora.com,
 denys.f@collabora.com, nicolas.dufresne@collabora.com,
 louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, melissa.srw@gmail.com,
 simona@ffwll.ch, airlied@gmail.com, Tim.Bird@sony.com, broonie@kernel.org,
 groeck@google.com, rdunlap@infradead.org, geert@linux-m68k.org,
 michel.daenzer@mailbox.org, sakari.ailus@iki.fi
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
 <20250124081250.GA24731@pendragon.ideasonboard.com>
 <D7AAOSNDJV11.AXVF80Z934BK@kernel.org>
Content-Language: en-US
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
In-Reply-To: <D7AAOSNDJV11.AXVF80Z934BK@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/25 2:16 PM, Jarkko Sakkinen wrote:
> On Fri Jan 24, 2025 at 10:12 AM EET, Laurent Pinchart wrote:
>> Gitlab as an open-source software project (the community edition) is one
>> thing, but can we please avoid advertising specific proprietary services
>> in the kernel documentation ?
> 
> I don't think we should have any of this in the mainline kernel.
> 
> One angle is that "no regressions rule" applies also to the shenanigans.
> 
> Do we really spend energy on this proprietary crap to the eternity?

This is not getting included into the kernel itself, the contributed code is,
of course, open-source. And yes it would execute just fine on the fully
open-source community-edition GitLab. I don't think "no regressions rule"
should apply here. This is for developers only, and is a template for making
your own pipeline mostly, with pieces which can be reused.

Nick


