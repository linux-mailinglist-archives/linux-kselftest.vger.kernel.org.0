Return-Path: <linux-kselftest+bounces-24709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F7EA14D8A
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 11:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D277188C292
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 10:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37E91FC0F8;
	Fri, 17 Jan 2025 10:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmFuQ4E1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07B81FBC91;
	Fri, 17 Jan 2025 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737109703; cv=none; b=WHgSYwjnMZeHZycvai1dHI7SkLREPI338QlMMb0xLO2sM2qIpQRDKDuiymbt2v87W6YNl21GKn8ZmLOqBMJq3r3Zwzh+/cBZvJpbiewoyWXzYCgtGXyd4L5PY33fjR9/nDDP/bbXfIoQH8MuDBjFoybHOmRxwq6KmPhIfQDHU7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737109703; c=relaxed/simple;
	bh=kkoEmAYe2SZLE+qbTYdKkQHJdK3eWyXaa+xFMCTKA9o=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ke+TLSX6VezRXFbz2zZn/6YvremzTFj/v1QdPJ0MiFliFROZs0CRJMKvMspvVM36v+ATpLgU7PXOX6u+HIbZVJ2HI0mh5S5SlXZi0cI3aXV224+rxTn3XmDGaW+LDzQBPd54GeJiFyiLM/lLmhlOKssMZVhU8b7hGqPyj4wTNHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmFuQ4E1; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b6ea711805so258158285a.1;
        Fri, 17 Jan 2025 02:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737109700; x=1737714500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYXgLu2ectYIWcNrQyXJcEHx/eKfm/mDV/W/h+cCuZM=;
        b=dmFuQ4E1T326+Jb22GczpVumZrQ+WAuHlI2Etm71569FAKwjlWULm9ovcMIVvJEEWi
         NNArrchkuRa0RtCdyYcMBqYFIL++AFED8+f0Sq85ZB6tzy6rFU+IEkCfyUyqQ0tjZiII
         xMUZub3BMI3vt1eLekXVILU25jFKsDxYZc74Er5sJbgyz3HHdkr7Didb+Gc6wQ8vNC0X
         nI05aphk0kzHqMbrd7l5zuCd6KfLXMYUIDYoaGjyAdibPyNlxm1GlMVI/L0jBs/yxo+v
         Wm1+JOhMe1YVaxoCY2Fz4Bu2emOVr1et0QnyFoeU7/Rg+SS/N5XsSV/vLO2P8uICm3Dn
         jrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737109700; x=1737714500;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYXgLu2ectYIWcNrQyXJcEHx/eKfm/mDV/W/h+cCuZM=;
        b=UFK6kn+oXZI/c8llF1JqHU7XNrggBv/LPBx/Fqua1YnhwonyLENIT27HLoPfFPTJrX
         jr9sU9n1VS9fE5UsAOvTSdSZr43oEIpxBsqIHISyhNEb1Bj+pJmUl6DAxUtNdzrU0ncp
         eLmL5awPZmTuyvwtOfiQXvFDHD1AgvNJ0+qZitNtY3WR75rqCmpgCq4GMYG4P+pSpPci
         vxPXAtulPJwtOPCLkust5f78NnRHnGv+NPXykmA7fruJjiMrNPpbWo5GV2iDU51lYiGi
         NVPmtDaRR3bZ0I8ltwn2uyHqLXRzr80mkAwne67GjfRd/O09bEILR2kdciXbaS48U+KD
         6FbA==
X-Forwarded-Encrypted: i=1; AJvYcCU95SbQv+5I+atNX+JGVQUZlQohH5xfzs+s+HUFvAGlNb7l+7WsuucLPDz4he3eQuwJ3pI=@vger.kernel.org, AJvYcCUHq8fhcDcM9MlTnkLjjbpZu0177tg/lgbfeB9tylmgRvuYyEzN5z6lpupk7s8KqpcYwJ0O9Z6iiL3QRugV@vger.kernel.org, AJvYcCUaNeFrzCdg/jsCHBwOFQT2B9WbhUWNwsalTaz7AA32TgX6iqT/1/ZDTJhaFPfPpSXa7WOmIVCXMbBYVxZl6uN2@vger.kernel.org, AJvYcCV6mri+a6JNVVLya7dDXO9EVH4uQvQsr7Nz894eXuB0dyVTmOD8705jFHMcjb5FNdU8GTRp3IK8@vger.kernel.org, AJvYcCVsaNS+7ACdDdQdXoVZWOIMHJZTMXsP6y8B58XEdzIl5Wwmm4tPDyAeXrgebzgX4fsBtL9ztuLQlEAJ@vger.kernel.org
X-Gm-Message-State: AOJu0YykAOIn8X5bd1xHzhsqcz8HEZwZtHU38e+IP0Vie8QLS+1TkdNI
	trFFl6VSEU3dLj0921KbrTZihl5LlaRi8BgdlzJyYbp70vPLYP1H
X-Gm-Gg: ASbGncsChR96usb/MPzahIrSZ1ktX03xw7m0C+5BitTjS4Ip8V1Us85FUJbDXYH2ufF
	HMrzzaL0VVc1viy+biCrxRH+A5RqjkSO2OzgNBdwrHup2veVhho1MAkjeqZAz+SXa1h3fw7WbVV
	JQRw3v1/c9aFVSskUyML4be5D3VJKrTyB/H2LyMxlW5gh2D3667eXNLOh/VcuP6rWNE/yBAhQj/
	m9cw46U7jM+o01KIbD/L96PfxWcCKqhDGZ7D/7Uz4hhHRoSDupjGYChBgfE9+xv7R2BMwwRsWry
	6bI/QmBWoLDEL8Qg3s1Hp/e1Cj1b
X-Google-Smtp-Source: AGHT+IFObFBUXDtDYfekB0QfBszL3tBkMMYxZKYT1erZOVR7bhzQHoC9ZWEDJqk6RDdXdB+0ChWnqw==
X-Received: by 2002:a05:620a:4502:b0:7a9:c129:5da7 with SMTP id af79cd13be357-7be6320be98mr319611385a.29.1737109699851;
        Fri, 17 Jan 2025 02:28:19 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be614743easm101344385a.24.2025.01.17.02.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 02:28:19 -0800 (PST)
Date: Fri, 17 Jan 2025 05:28:18 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
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
Message-ID: <678a30c2df05f_3ef8eb29481@willemb.c.googlers.com.notmuch>
In-Reply-To: <678a1fd7d7c85_3e503c29449@willemb.c.googlers.com.notmuch>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
 <20250116-tun-v3-4-c6b2871e97f7@daynix.com>
 <678a1fd7d7c85_3e503c29449@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net v3 4/9] tun: Decouple vnet from tun_struct
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Akihiko Odaki wrote:
> > Decouple vnet-related functions from tun_struct so that we can reuse
> > them for tap in the future.
> > 
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> >  drivers/net/tun.c | 53 +++++++++++++++++++++++++++--------------------------
> >  1 file changed, 27 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index ec56ac865848..add09dfdada5 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -298,16 +298,16 @@ static bool tun_napi_frags_enabled(const struct tun_file *tfile)
> >  	return tfile->napi_frags_enabled;
> >  }
> >  
> > -static inline bool tun_legacy_is_little_endian(struct tun_struct *tun)
> > +static inline bool tun_legacy_is_little_endian(unsigned int flags)
> >  {
> >  	return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
> > -		 (tun->flags & TUN_VNET_BE)) &&
> > +		 (flags & TUN_VNET_BE)) &&
> >  		virtio_legacy_is_little_endian();
> >  }
> >  
> > -static long tun_get_vnet_be(struct tun_struct *tun, int __user *argp)
> > +static long tun_get_vnet_be(unsigned int flags, int __user *argp)
> >  {
> > -	int be = !!(tun->flags & TUN_VNET_BE);
> > +	int be = !!(flags & TUN_VNET_BE);
> >  
> >  	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
> >  		return -EINVAL;
> > @@ -318,7 +318,7 @@ static long tun_get_vnet_be(struct tun_struct *tun, int __user *argp)
> >  	return 0;
> >  }
> >  
> > -static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
> > +static long tun_set_vnet_be(unsigned int *flags, int __user *argp)
> >  {
> >  	int be;
> >  
> > @@ -329,27 +329,26 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
> >  		return -EFAULT;
> >  
> >  	if (be)
> > -		tun->flags |= TUN_VNET_BE;
> > +		*flags |= TUN_VNET_BE;
> >  	else
> > -		tun->flags &= ~TUN_VNET_BE;
> > +		*flags &= ~TUN_VNET_BE;
> >  
> >  	return 0;
> >  }
> >  
> > -static inline bool tun_is_little_endian(struct tun_struct *tun)
> > +static inline bool tun_is_little_endian(unsigned int flags)
> >  {
> > -	return tun->flags & TUN_VNET_LE ||
> > -		tun_legacy_is_little_endian(tun);
> > +	return flags & TUN_VNET_LE || tun_legacy_is_little_endian(flags);
> >  }
> >  
> > -static inline u16 tun16_to_cpu(struct tun_struct *tun, __virtio16 val)
> > +static inline u16 tun16_to_cpu(unsigned int flags, __virtio16 val)
> >  {
> > -	return __virtio16_to_cpu(tun_is_little_endian(tun), val);
> > +	return __virtio16_to_cpu(tun_is_little_endian(flags), val);
> >  }
> >  
> > -static inline __virtio16 cpu_to_tun16(struct tun_struct *tun, u16 val)
> > +static inline __virtio16 cpu_to_tun16(unsigned int flags, u16 val)
> >  {
> > -	return __cpu_to_virtio16(tun_is_little_endian(tun), val);
> > +	return __cpu_to_virtio16(tun_is_little_endian(flags), val);
> >  }
> >  
> >  static inline u32 tun_hashfn(u32 rxhash)
> > @@ -1764,6 +1763,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
> >  
> >  	if (tun->flags & IFF_VNET_HDR) {
> >  		int vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
> > +		int flags = tun->flags;
> 
> Here and elsewhere: instead of passing around and repeatedly parsing
> flags, have a variable is_little_endian (or is_le)?

I guess this will not work everywhere, because endianness is not a
boolean flag.. Code checks both TUN_VNET_LE and TUN_VNET_BE.

