Return-Path: <linux-kselftest+bounces-24133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AB3A07899
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 15:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0C5188A8C6
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 14:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D03219A93;
	Thu,  9 Jan 2025 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoCsV9C9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008B9217658;
	Thu,  9 Jan 2025 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736431662; cv=none; b=AfmHTqeLZa5mMWR/6GQFKaD9CyRIo6kgyPPMyWHAN7Ws7+QnVTA8wUwHnNu5PPAuo5wBtkco8FphYVs27NbMIiQstVE76jYxzmYec5PFOQm7ytljen1+GCVAQak97Jt/US/ydZ9EtCjNG4HSRXqeivPq7s4q8RGmcuQhrFgRauQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736431662; c=relaxed/simple;
	bh=tscVKlLQWx7s/13Gw4/C7+1Jj4CP4pCVW9+Lu+UEVyk=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=V8QsxF8QE+1raVedgyCs9N6A7kS6IeaPi8jskInWHk+zsLMNl+R+0k37rHCVZRt/oVpGSwfRdxCaYu9nsCl0wEmrW9VFGiFsg7h0OyzYThEGWPLBaodWGxkkEfPFOfUgMWYwk1ck10e8RPPl2fTq1uIbqzLsc5yfgMeFgjO5Zi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoCsV9C9; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b9bc648736so77653785a.1;
        Thu, 09 Jan 2025 06:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736431660; x=1737036460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tscVKlLQWx7s/13Gw4/C7+1Jj4CP4pCVW9+Lu+UEVyk=;
        b=aoCsV9C91AJN0Ra35cL5Q2mh3wmEv+eo7D0jWVkr+RIPQ3BhiUqEO2zRXr+1spJnqD
         pFEEdiw1ywta5XykxQaltPMkhBTnZ0qXmUdz7DWdaiZV7hh6mMJ9cl2t1SEKj29gG9ib
         auTadcbFTaVVOr3gNpANQ5lObsUMRG++iDD2Gs4HhcBb5QXfVDQ1+yRgI5wueBDVgHpK
         DwAl3oosAVms1uoC1WeU5xJi/9fj6GPsfIv6F9U0kmh3dSsmqY4Y+rnGNdj/Lq15RBiO
         1Vf3le632Yuuw8K9K/C1505R3uGmZC7Dp++VMzYEbp/dWZ5vJpKoxAQRljibHJeB7fiB
         CWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736431660; x=1737036460;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tscVKlLQWx7s/13Gw4/C7+1Jj4CP4pCVW9+Lu+UEVyk=;
        b=fdWGIsRsATI1z7a1Pn6Gji543OYFJHRGqqg+txk7pwtIGe+Nf+/JcmiESAzdX1AF7H
         BjhGipCJknM9Qvy06A5pHOFz8UfBOBO0BQFvWyh1wltp98tvyjOh1L+1fzzjG/omhQm4
         1CmehjzqhnESYm219gVImtq2/IQc6F8GafvHGwGFRg2O0/2m2gxTwfhbJ3yq3UgW+FfH
         +1jcv70fWxckGsduHRiO8qotEUEgvZ3SdqizPoDGDPiznmkgIfu+/WMj+PJoFT1z1ddX
         CefmghEFI1PRCNGalkzwswKZU6e6gZT35ULS98e8Nsq29ISbdKb2M2oWTgmfJXKTapWw
         e6jg==
X-Forwarded-Encrypted: i=1; AJvYcCUe+9ZaEAiej+PBzGt/jKDJdVcEz++B6OQCRhdYMX3urLXmK74anidVtc8EIfaXAH22dCblZpSS@vger.kernel.org, AJvYcCVilTSGSfvANmVc1DKxA9oGBaNl9TSurdz3ZRKXbeHV22wt2CXhfL4W2MM7SKJ7KnQUtGZ4xb9/RW76@vger.kernel.org, AJvYcCWcF9t44dItCVMtwgZjpSHSoCSDu4yKHpq6SOd32RPLD/W7lo94+dA8T2MmIt3MRA+astk=@vger.kernel.org, AJvYcCX0/SeK6Z96kJQJtEmaNs5McG14RevCi4kqLLI5AoSwZPeUiyfjdVUCzSdXK0sthk23FKyl0ThS+FH991Bf@vger.kernel.org, AJvYcCX1RBL8AJSdThNQmpHn8vkK6fs/UhqC+HAjJYcYixUVmD3diV+zQUASKQQYV2BHxHc+yhnzXIelMjoKLE2Fx0vb@vger.kernel.org
X-Gm-Message-State: AOJu0YwcXR9BVfuyv9ccVdGiSJtvCIINGjzSsTLGBGCa+R4KoXeXNkTA
	iGFvQ/Je6bTuSOT/szV5zRge+hpGr6nx+769KLG7LTG+LnYLWtPd
X-Gm-Gg: ASbGnctFk54MAzArpmUZJVciTbcNhbZxe36scVy8zKWqXym+L3bTU+GZf0R2fJdecg2
	nneb7m8XDYOJE9KU5t8xJHfRUowXnfM15q7ST3Ggj1oZl/qpGDy1eRSZi/c6Dhl4iuBDxypwUvO
	/6CvKbdgNF3RUMtbYf1PPtpUoFh6IUQW4v90bqX8UWWFg5k/62QOGVHT4WolFrOKhjj6+oLzJRH
	p7zpWEzuGoeYOLLI6xsIzQzj1H0Yj0zRi7jWkV6whSeRDH8N5FhN0/tmEn//vaUGe0x4koVyafT
	4rtmbW08/vxrAvW+yggXB9ciXLFW
X-Google-Smtp-Source: AGHT+IHCTMe567nASwbLxdPVheY8R7YeDB31hZF/68JU5B1pjAC7Gu9U0PmgqA1JJJu294K0BFuIkQ==
X-Received: by 2002:a05:620a:472c:b0:7b6:d736:55c1 with SMTP id af79cd13be357-7bcd9759dffmr1178409285a.48.1736431659927;
        Thu, 09 Jan 2025 06:07:39 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3248304sm69773385a.31.2025.01.09.06.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 06:07:38 -0800 (PST)
Date: Thu, 09 Jan 2025 09:07:37 -0500
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <677fd829b7a84_362bc129431@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250109-rss-v6-0-b1c90ad708f6@daynix.com>
References: <20250109-rss-v6-0-b1c90ad708f6@daynix.com>
Subject: Re: [PATCH v6 0/6] tun: Introduce virtio-net hashing feature
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
> This series depends on: "[PATCH v2 0/3] tun: Unify vnet implementation
> and fill full vnet header"
> https://lore.kernel.org/r/20250109-tun-v2-0-388d7d5a287a@daynix.com

As mentioned elsewhere: let's first handle that patch series and
return to this series only when that is complete.

