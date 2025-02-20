Return-Path: <linux-kselftest+bounces-27047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFCBA3D2AC
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 08:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04CF517996C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 07:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADC51E9B09;
	Thu, 20 Feb 2025 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ah+AnUHs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9870D1E9B1C
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 07:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740038332; cv=none; b=iEy3zzwr2lHwpdt8RQ3BNICw82bbgseCa/4Sob8d0iAzwT9yG1lW7tbdgK5OINW4za7zf0bGFEemcHty0f7wFqq4g2ffSPBcMVpSrjU7Fd+iDy12GaskM8Dp46R8zaQN6ZGoNqUzdSHGfaFqgfLzojeS3pebN2kB6YPwYEEW9Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740038332; c=relaxed/simple;
	bh=PpJNYD2lhmYApKCUTFbnIB2Oz9xNpyPKhkXzhRQ1kRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FkmQBbGuJPlN0iMI54S001IQ4OGWYNiWuDW6K0S+2JEWZTmTe3s3d4BhQoao+Wfy130HU22QAHMty4V5t/v3g50c7d5n9i9hoQQmLrfYaj7Zg3R2K4LIzntdrOUfZi6fp8mDHCJhw4CJakHzMNAUoyIjfqMICiWAU3P2hK6U100=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ah+AnUHs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740038329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PDyq9aCOU4k6/OxS5NyOrQ8zBZnEHt3wS9LzAF8nhU4=;
	b=ah+AnUHsJbYHYCMUpFDnwdbPsGVwykiDieVCQl/SU4Nf2z+Eq2S8msbXoNAXeDGI/WbP+G
	4o28PY0ZkAaDAPhBKwiiMuWhAmwbpBBrcy3JrIhN/5sI4l1b4YwhoOLl8ZMbZfq4lw5/Aj
	O6T4ziad5eJszHE79JH6bOeLyjUagKw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-YQ6loaeDNeCzgyLcVUTUQw-1; Thu, 20 Feb 2025 02:58:43 -0500
X-MC-Unique: YQ6loaeDNeCzgyLcVUTUQw-1
X-Mimecast-MFC-AGG-ID: YQ6loaeDNeCzgyLcVUTUQw_1740038322
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4394c747c72so2582755e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 23:58:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740038322; x=1740643122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDyq9aCOU4k6/OxS5NyOrQ8zBZnEHt3wS9LzAF8nhU4=;
        b=Fv18bjUWwfpo1DbMl4+1NrGeTE0T+HQk5qym3ai5HxVk+xXUU5fOnpoluFM1OUbx8e
         I/+p0Sisp4xk3w0c+5eQQSLsBqefgJDE6/jgAAmITE8lEsYp0cPyU0V2btq/j/fnZnil
         X+fFHOsuDKPEVxJ17uKRgMFBDxS0yApitMT87GxrHXvEkW21VVHoj84X5elvz16SDq3t
         XItGOb2oHF5SyOjgAgtX7+zFhv4H7B/XjaRmcNe8m+FWbFoFoqgMqj+w7hgpQRQ2GvB4
         CU3Sa5upMZTAyJqQjfwtQ6dq/0LOLFozuKCEP4l/HMo09oCOobnMYqakjlQCZOeOS6gy
         eDRA==
X-Forwarded-Encrypted: i=1; AJvYcCVHbXcICGlF75H7bMMwsuW2EQDC0+i6fZbJm53gnLLdNbljNtlpblPjkt94muCRNdFC5ienvfNo26jgs2ND1no=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxd1VajBSrKxWLfgdQc2ztjtm6r75P9uElEBiNYCJD0fYDplb9
	Bw7GdLPJ/8CLCaRabkQ73y0tU+jU0r+Qp2NAeV9lJsclxHO0Wmro+RuzLTKL+uHKezrWrr7RDKu
	GR9YMccNE0XWvhnNQjCMml/k8MtC0Ct0wjtpPeFT+Z+LfPHm9t/pEsRQk1ICcjYJ7n3SoHtQFJg
	==
X-Gm-Gg: ASbGncv9GylZo7NzHvpG/Kdz5QcvMpk/bmrQ8BHNuv3Sr54ZS16dRhX1P23HEkef9Sm
	cVQOs5OyeYcUAAPMxL/LFqfMNok7I9PLMufuCGM/iJ4G496CI8F29tQl+FtfO9IZz4C29lw/zSg
	KqFjcMqruqWEZWodynLvSo4h48SHzseTGPbtasuaUImb1c99TLSEB3xkdVO+z77hEqrxw+h8gjw
	+2riLNsJx9Fyd2SSWTwcoK2vB6UNGEmbQZkYRC/g30Z62ajrebCmd6p4NKmzjyKi1NSwqgYTng9
	/uo/QQuyOk2WM4hY4xsWZAONy8tvB/L01gY=
X-Received: by 2002:a05:600c:1e89:b0:439:9828:c447 with SMTP id 5b1f17b1804b1-439a7b81c85mr5230735e9.17.1740038321783;
        Wed, 19 Feb 2025 23:58:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMZ/J4mT4eh+w4zVIHYL3J2TeyMMFBaqTsZEuN7XJULLXJfI3m9ZBVAO4oeESyI4i7d0LvUQ==
X-Received: by 2002:a05:600c:1e89:b0:439:9828:c447 with SMTP id 5b1f17b1804b1-439a7b81c85mr5230655e9.17.1740038321375;
        Wed, 19 Feb 2025 23:58:41 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa7bcsm232584425e9.28.2025.02.19.23.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 23:58:40 -0800 (PST)
Message-ID: <d4b7f8a0-db50-4b48-b5a3-f60eab76e96b@redhat.com>
Date: Thu, 20 Feb 2025 08:58:38 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] tun: Pad virtio headers
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Jonathan Corbet
 <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250215-buffers-v2-1-1fbc6aaf8ad6@daynix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250215-buffers-v2-1-1fbc6aaf8ad6@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/15/25 7:04 AM, Akihiko Odaki wrote:
> tun simply advances iov_iter when it needs to pad virtio header,
> which leaves the garbage in the buffer as is. This will become
> especially problematic when tun starts to allow enabling the hash
> reporting feature; even if the feature is enabled, the packet may lack a
> hash value and may contain a hole in the virtio header because the
> packet arrived before the feature gets enabled or does not contain the
> header fields to be hashed. If the hole is not filled with zero, it is
> impossible to tell if the packet lacks a hash value.

Should virtio starting sending packets only after feature negotiation?
In other words, can the above happen without another bug somewhere else?

I guess the following question is mostly for Jason and Michael: could be
possible (/would it make any sense) to use a virtio_net_hdr `flags` bit
to explicitly signal the hash fields presence? i.e. making the actual
virtio_net_hdr size 'dynamic'.

> In theory, a user of tun can fill the buffer with zero before calling
> read() to avoid such a problem, but leaving the garbage in the buffer is
> awkward anyway so replace advancing the iterator with writing zeros.
> 
> A user might have initialized the buffer to some non-zero value,
> expecting tun to skip writing it. As this was never a documented
> feature, this seems unlikely.
> 
> The overhead of filling the hole in the header is negligible when the
> header size is specified according to the specification as doing so will
> not make another cache line dirty under a reasonable assumption. Below
> is a proof of this statement:
> 
> The first 10 bytes of the header is always written and tun also writes
> the packet itself immediately after the 
> packet unless the packet is

 ^^^^^ this possibly should be 'virtio header'. Otherwise the sentence
is hard to follow for me.

> empty. This makes a hole between these writes whose size is: sz - 10
> where sz is the specified header size.
> 
> Therefore, we will never make another cache line dirty when:
> sz < L1_CACHE_BYTES + 10
> where L1_CACHE_BYTES is the cache line size. Assuming
> L1_CACHE_BYTES >= 16, this inequation holds when: sz < 26.
> 
> sz <= 20 according to the current specification so we even have a
> margin of 5 bytes in case that the header size grows in a future version
> of the specification.

FTR, the upcoming GSO over UDP tunnel support will add other 4 bytes to
the header. but that will still fit the given boundary.

/P


