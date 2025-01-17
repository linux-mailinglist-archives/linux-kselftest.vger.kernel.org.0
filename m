Return-Path: <linux-kselftest+bounces-24699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C98BEA14C02
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 10:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8551160FE5
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 09:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D665F1F942E;
	Fri, 17 Jan 2025 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7fZ8sm2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6391F790B;
	Fri, 17 Jan 2025 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737105498; cv=none; b=Gl5JyONuSQbMqCUZsHrS7a0hdJ/IA/2RpEHzOZ2RdSQCuyJH3ZALUtVI8FDC2BvhmDvI6LDABdVhHK8yEP8tEwIBVhVu81elPeHlJnn0lO+tQ0C9gNlFKYcGEE3UPMBGkFSWNscmQg6IGNpNlEDr6t7tEUvPDR793qbYvE1xeZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737105498; c=relaxed/simple;
	bh=RV6RXs0gcTNOti1+8bEel3sM0z+UvSDpbVmTm3XMtFc=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XQ+pU8T5ufGY/sbAD6PN/dj/lou2fU8Y0JyqsAPGQM5/Kf17aWjZVC+ZQbuvt30M//25SZjAMkVn0O69j/+oJpGu60ICOPCeioOm/3JnwmVeafC5jdJVqVau1TBquHgbFTEGn/0u6HHuHEcJdZpVqQzuJ8y2z0n5KmEDac0HEmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7fZ8sm2; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-467b086e0easo11079331cf.1;
        Fri, 17 Jan 2025 01:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737105495; x=1737710295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRc4pJ3jbfs9xw83YIL2zd+fqf9z+TDnT5AsKk692iE=;
        b=Z7fZ8sm26ZvDJosxRdy3SVMHuNqjIlS6N/z5QUK/MzuhG7SPDIp8fYExNIj6MbTJIx
         1cHLx1+enjG1OkdkOhlvPx5seZkiMG8S0h4AvGoT08ipANmuE8vALx7ufANkG446wR3+
         etL1dQuEX9Csl7wk+4cCLPZzi82RD4Bsz4lUB4golDBme1dvogYRK1CqnpFcf/+HwnME
         l7Rt4RidVluLPbzZKyBWfWvPnWhN6dQIFuOehT5Ar2Je8fbXCNvz5AvrX9E7mWAuKu6D
         Rp+B5wmHiIQ0K/H8DMJZB9vrqqZpD0Ffs4IbZCdrexFITTZxMwBd0tAC7RJt1bgDAU7/
         V0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737105495; x=1737710295;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRc4pJ3jbfs9xw83YIL2zd+fqf9z+TDnT5AsKk692iE=;
        b=XXzzSqHSxuh27BgsqT+ncFOKbgiV6LUVyAJTXU0l+MSEFoDeczVYFAQAbswZJ+9lOz
         m3nDMKHuxs5t/rli+mPr8JfCLmwVf+Qg/y+FWHDOuTMPQvdxUh1vun2hYI4brh+TBOv4
         Illyz7bm8VVMnI0i86BTkPJqSzFIbbYzJnd6GXl56aUw/E/VNdOM/R/dUZjpxelBaP7t
         Fh3fHAoba0npfF9CAhNHavyyXkOJtvmpXMep6kltOtMymO0GWy1+3Mmmi13NbHYwP96+
         oDhBgjAAe3O6f9xFHYoOcjiF4uo+lPEvk9bLKJaHlZep7+YZ83/R8CeKM+64hjQv9Bv3
         L9XA==
X-Forwarded-Encrypted: i=1; AJvYcCUFlKI4RM72S62w4o2byyvfobxHUtT3HpxxEfZmDJDKHYspNk74oFxLVgGs7yel1nJ4+U+v5eVIu8/mgtYRmZMa@vger.kernel.org, AJvYcCUnHsg/Q4+dhNKFQAgNn2T7qpCoG4C+uY3+xGZezQyKVHBsgx90sFIVqiJ1UzcTcE8CBH56kW/zdut4@vger.kernel.org, AJvYcCW7Xnqu+FhdVcWRavT7IyWclkMc59uCVTpbR5n1sayejKxzd6bPX1itxJJxiFB7RUd+QMc=@vger.kernel.org, AJvYcCXBJu2ZNfrE452s7qQccusfbf3fslsL/QqA1QEpBGjTK9jTjutBgAvqopotOjgHsKso0L7yKOMm@vger.kernel.org, AJvYcCXTo86SGIlj92E+AjrZzarRPAvKE0U6RfJsHVfQyt+iUjzsBiFq4jjRqIdS5AKp30nOyMVHC/C7A5PSMvb8@vger.kernel.org
X-Gm-Message-State: AOJu0YyXy4KJuVLTmW1o3Ey37RmPwoBGHx2x1TRX95DzyMC9Bzx97n3E
	2J9u8BErTSYlF60G9pVTfLM7w4Uajl2T4LnS86/q2b0NX36VVAxt
X-Gm-Gg: ASbGncsv2lGwOIi/r0YCDhqBYvR6rBB4EYliRWH+aXmt37f7thn6rdDDINY5aoqajXV
	CkkAOl3mFg5dZTbfi4W+9O56gSmATVn/bRTIYL/jQYRqe7loRdZ+gcgJp2ShJqZjQaRSLC+psD4
	4HGcb365oTI8Btk+OS4F+0sbLI1pUd7HTT23TyHk1uXrbASJlzsKKoMVc4dXF508uAmpY73djmL
	BZ/tyKkaxrDyO9tkfXeh2wKYJnFaECP9Z0x7AopURSTAT3hpBYfwmZP5ZfQDuNN2/mrBrrQ/ppu
	73u3C6PqipkAZTNi26+LSXdVB9VK
X-Google-Smtp-Source: AGHT+IFqniVuHfpG5nj5bXLQpzPI092VwpWQMjG3HMguT6Fe+qg5qdv/hCsmLd6zNBeyZ+CgpugYMA==
X-Received: by 2002:a05:622a:11cc:b0:467:456c:2957 with SMTP id d75a77b69052e-46e12a1e6efmr26486311cf.10.1737105495325;
        Fri, 17 Jan 2025 01:18:15 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e102fbf2dsm9495561cf.24.2025.01.17.01.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 01:18:14 -0800 (PST)
Date: Fri, 17 Jan 2025 04:18:14 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <678a205681078_3e503c2948c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250116-tun-v3-5-c6b2871e97f7@daynix.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
 <20250116-tun-v3-5-c6b2871e97f7@daynix.com>
Subject: Re: [PATCH net v3 5/9] tun: Decouple vnet handling
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> Decouple the vnet handling code so that we can reuse it for tap.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  drivers/net/tun.c | 229 +++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 133 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index add09dfdada5..1f4a066ad2f0 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -351,6 +351,122 @@ static inline __virtio16 cpu_to_tun16(unsigned int flags, u16 val)
>  	return __cpu_to_virtio16(tun_is_little_endian(flags), val);
>  }
>  
> +static long tun_vnet_ioctl(int *sz, unsigned int *flags,
> +			   unsigned int cmd, int __user *sp)
> +{

please use vnet_hdr_len_sz instead of sz. It's a bit too cryptic for
a casual reader to understand the meaning.

