Return-Path: <linux-kselftest+bounces-25936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FD9A2AD4F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 17:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876183A2EA6
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 16:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6B21EDA2E;
	Thu,  6 Feb 2025 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIUf50Ht"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404111F416F;
	Thu,  6 Feb 2025 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858195; cv=none; b=bADX/Mlw6OuuRXm81eWQXGwpq26+S4S/+niXplDW4sLPoVw/3Ix3B4BM3QB/OBEVTGaktW5K1RFfoQhGKc/1bYMcEFCvVVCRGtcKIMH1CAq+UA1XH0Hyp1EB8Ag5iq8IFh2YqtVpRFmwKzn5ft1EbEa2CKoljanPhCT8ohn3Vsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858195; c=relaxed/simple;
	bh=Sz0yAKu52Q/DkcVZvMUnojW6qo+VO61Tj6LBMXUj0n8=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hzk7Ao46CL/G7jyYQmAAUjB3cdxdHxKeh51fi3bWHjiuAdIeyND9IXholV2RL4504RYp1y07oFfke48YPn4uK1wEdcB4A9DxLHpiNP8OPkLSYu9IZjBfxZgwPFpOk6PxIeWlW20aUF+kqAgvs/YloTuMZQfGkpBI1F+KjlGlpAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIUf50Ht; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c0155af484so132897785a.0;
        Thu, 06 Feb 2025 08:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738858192; x=1739462992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkXONlGU8F89bT8v/54D+GqervLT59Ca/28JVFZb6vM=;
        b=bIUf50HtF/dr8rzm+AIPPGZ46KoUdXVf4y+oQVheoCbfTek11Ejfn+fR/j4fUVyYEZ
         Ya4y4HkGjDzS9X0L27OdS7YDVFLXgD6NnBWMcMAUb5Gwo07sINM/GZ9kPK/8E4gOfMym
         cfIb0zXuX0u2t5S4nMCXmsYMyHb8GqujjEYhjnBrfCWuPr7BtdMTt1DQfGqgpwCAv2Hk
         VIWv/unc9k3BmaGGv+jIWUl4DSPJKOcLyvAGXs46hKghMi8DlayByzdVNNfLoenlgPgC
         6mVSICwTLWZTuCyKpwZPNN7l36p9hiZ2N3O7t8AUFeLZ5vBIQIWJS0PaSN98xMsjgvib
         LX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738858192; x=1739462992;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkXONlGU8F89bT8v/54D+GqervLT59Ca/28JVFZb6vM=;
        b=ZmAUJMRSYIGi0rpUQaO0+9d+KETBQQVEAK46Ar2RoaQZNoqJ1zpWAnKIA2+o0XqDkL
         L6eRXBD+9m5BeqWjdgpFX6OFU/K3AJliOemWOumvAKc6jsVbZZFKrRg/JkHBy+6xX/tf
         HThnME40OafZ2MXQgzQTjkgrjkmO/J4m5IUehpOsGGqDlC/fzSXp2CVu+K9GVADC0Nya
         u99hDMu0ZaKqXzzIzW4lEIMEwqBBxtxyUinH9LwyyOgezIUZJhA4m9ZLURJFsvrbz74l
         474S6rP443x6CrUzlWf4ubup97l6knVSo8M6HocdFiF7/nlAe6XCZFo5rX5i+bggjybC
         z3dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlLRKMEPMKQJaGPWe63ef2QomkjRIoQ9E+AeJFGJEGdvofwNTYOhK/VR0GHaLXP6aOAFh03RgHkeRD@vger.kernel.org, AJvYcCV3G4YwkEN6LLhFLfl852tbQUykEuJDKdfmW8VxOoA4tEO/YAy3Qnv3u6+yT5bn/0gdaohx/Ipt0xXIlS4lAZn2@vger.kernel.org, AJvYcCVyTurBreE9/bSFaRpzE2MhSzh8BuVGeHfWv/XTAKw5VmTNqA9s8se5uPfw52gTEyAWuyY=@vger.kernel.org, AJvYcCWMuYDvx/8Z7+Yazk3w4ba/1CvjQokRUsdmg5/CiNwbe2SaD99/henHW8983ETtP773b5lqtgtE@vger.kernel.org, AJvYcCWypCbCrvptdR5UOpWPq9EhbVFd775kiVMLAFbfvzRxrSiq9OgIAV8V6H8rlqmqrB7AL5V20YJyVCYm+kSk@vger.kernel.org
X-Gm-Message-State: AOJu0YwpA8jGwUwwsbGseS+gVUpwWO724XkXsVwA1dGlZiZMhd7FraE7
	q9yJk3TcvZpb1lDP45VYhKhlgyuFyJGRJC5g4AmLvdbN7KUZFZFH
X-Gm-Gg: ASbGncud0qSiK8MIa2L7z2x416hwke4cW9i+TlrjqHI0JyZ8Tf8SkyY+vTDpudjNrVb
	MT88w1p/KEJs8/lvzSZ/UcflpMb+5QS9Cp56B5XH+07xC1/Y4LVzU86X2O+BCuliKkPiZlmAjtJ
	089mwyCLS44lCGPk918Re2iXtjNZCR+d5aXnNiQ02AmRWcBGZEqTCMynohCumuP+EzX7QrHe02T
	wcYv80VmGabamPdha1Y2jer2uPvJjegmAgEtX3/eMwzC7bbfmbHNHbApPkm9+acervN087x3Kuy
	lba6Un44W2CGW+bpuau7BawagnSbs/Fa7dApqM6q3JwXJXRwY+3iV/bNJnIqhPU=
X-Google-Smtp-Source: AGHT+IGt+/KI7G+Ky43LZCW+7h9o5kkC2zN8+03mInm/HQvkfRNm9I7BK0cYoEJQCJyLgDBBFNdRpg==
X-Received: by 2002:a05:620a:4312:b0:7b6:d4a2:f11f with SMTP id af79cd13be357-7c039e92d5amr889066885a.0.1738858191933;
        Thu, 06 Feb 2025 08:09:51 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e9fa5esm75699285a.76.2025.02.06.08.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 08:09:51 -0800 (PST)
Date: Thu, 06 Feb 2025 11:09:50 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
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
 devel@daynix.com
Message-ID: <67a4dece7b7e4_20644429480@willemb.c.googlers.com.notmuch>
In-Reply-To: <8b389981-c04a-4d4f-8a5a-043b4cd6e8db@daynix.com>
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
 <20250205-tun-v5-6-15d0b32e87fa@daynix.com>
 <67a3d6706c01a_170d3929436@willemb.c.googlers.com.notmuch>
 <8b389981-c04a-4d4f-8a5a-043b4cd6e8db@daynix.com>
Subject: Re: [PATCH net-next v5 6/7] tap: Keep hdr_len in tap_get_user()
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
> On 2025/02/06 6:21, Willem de Bruijn wrote:
> > Akihiko Odaki wrote:
> >> hdr_len is repeatedly used so keep it in a local variable.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > 
> >> @@ -682,11 +683,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
> >>   	if (msg_control && sock_flag(&q->sk, SOCK_ZEROCOPY)) {
> >>   		struct iov_iter i;
> >>   
> >> -		copylen = vnet_hdr.hdr_len ?
> >> -			tap16_to_cpu(q, vnet_hdr.hdr_len) : GOODCOPY_LEN;
> >> -		if (copylen > good_linear)
> >> -			copylen = good_linear;
> >> -		else if (copylen < ETH_HLEN)
> >> +		copylen = min(hdr_len ? hdr_len : GOODCOPY_LEN, good_linear);
> >> +		if (copylen < ETH_HLEN)
> >>   			copylen = ETH_HLEN;
> > 
> > I forgot earlier: this can also use single line statement
> > 
> >      copylen = max(copylen, ETH_HLEN);
> > 
> > And perhaps easiest to follow is
> > 
> >      copylen = hdr_len ?: GOODCOPY_LEN;
> >      copylen = min(copylen, good_linear);
> >      copylen = max(copylen, ETH_HLEN);
> 
> I introduced the min() usage as it now neatly fits in a line, but I 
> found even clamp() fits so I'll use it in the next version:
> copylen = clamp(hdr_len ?: GOODCOPY_LEN, ETH_HLEN, good_linear);
> 
> Please tell me if you prefer hdr_len ?: GOODCOPY_LEN in a separate line:
> copylen = hdr_len ?: GOODCOPY_LEN;
> copylen = clamp(copylen, ETH_HLEN, good_linear);

Oh nice. I had forgotten about clamp. Even better.
 



