Return-Path: <linux-kselftest+bounces-24883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FAAA1801F
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 15:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B407218874DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 14:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC51E1F472C;
	Tue, 21 Jan 2025 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ow2/N6rG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE5A1F3FD8;
	Tue, 21 Jan 2025 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470407; cv=none; b=ZPZxoL43Nt1oAPLgqYUzv6lxLJvL5RS6DnwTDa9wX49AZ6ymx88lbFMzptq+hamAcHXkvXAKpldDpgr4SEuMevUGM0Wuu2opgo7S6HV3/gWf+SC3u+WXU9DHJsULujeaWbouWMXrYliOdRDn6Lq7UheGhW9pZMBe9ak58JV1Mwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470407; c=relaxed/simple;
	bh=RoOPEw1pnjf93BWu1H+vv+vMseKv0LAkB8QIKntc2D8=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Cdr0s4rnZrUb2KEHrpoeMDL+uKPPB5PjjjI6THBHpLkRFjQyoU9Eizz8hzMy7KufCYZMRVLU8IDM7DTYuNS1o7dNas+KTF4fyQ8HxVyRZx8buAoynUDXIOhpStyp9Tp9dreWtWxX5ESn+tuchPff6s851b2GaPKbeLTwBp8+37o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ow2/N6rG; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b700c13edaso303446385a.3;
        Tue, 21 Jan 2025 06:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737470405; x=1738075205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGQfSzGMb0K2xpDR8R+dRZzW8GV9BBlFM9+N4B0KulE=;
        b=Ow2/N6rG03ktTfCSUj4+ZMDgjhPocbxqlwSIFd3xXQzhnFBsGTTWyKf61ZqRqKaGQc
         29aXBOmc42ocimuf3r44m2y8MUNv2LN5BwFSwtVwZHuuNTf+ZIJ5Ghd5J1YxL+fREngP
         6pvqz43F7ldltbZXuQsIUSB1IZyi1dQd77tLLdh5aUEdxYJm8UvLrG69N4QGflqoFEez
         FKWgk6HC3izQBacH07DwmyOJqUJSBzDIhZ2ErABKda+1nVlS/a7Tj33ThD/IBoO2mH3i
         QbR2agosqWixbD3nZCeVicHy4Zzi1cysMBWd0xSiKlmQiP+YRmRPUZhrlu8hfPMrrt5/
         Q04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737470405; x=1738075205;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGQfSzGMb0K2xpDR8R+dRZzW8GV9BBlFM9+N4B0KulE=;
        b=CHP2giN/rr25Not5M4aTkZfqCFpebD/v5utLscz3yIc5jN6FumpQin0sbTcHSwS5YP
         11NWK5ivW2cd22BdP4+8T5gBOUMC5DS55bV3C596LwJoTNy6vn9h2/V+NLxuQ/qq7C2X
         idxrjRqndLAkuInsRoTUj3rPCouBjkAZTYGYvZ7LVGtNemOdygwkTDdz3wwlaXQrCD5/
         XNMJbp73JjDwptCuYlbD9VmYzWqSlv0u3r9VFk023Y/AhPCPkfHYcdOMhANnTwB+ZG91
         eLa+a+vwUhRmFFSxU+oRWrXX3EUoOSF0g1WFPl4cXRHnBXHnKS5RyoLXf3+bXMvnRtzS
         S68g==
X-Forwarded-Encrypted: i=1; AJvYcCUymrgrHRhuQWotFPTqplM+B9UzaXLPE1LAAFUjDk+9zgk6iy31/7bspmNspLNo1r4MwU0BhvQt6sDzL3Sy@vger.kernel.org, AJvYcCVe+Hls4EKe27WWZ2vG3vKnBh031Qiqt74vR/AmKA6j6FPRlGjqFKFXc1G9X4kkZxa6Im78MnTt/PsbgnUnYKHP@vger.kernel.org, AJvYcCWIg04mfIBKbJjSatYRPWPY9JBRqy2RVI8tixI52Rn+IUHreq9PAGapjBey5zV/RrKVTTY=@vger.kernel.org, AJvYcCWk4TkcL+GMm+3ninooQUga7TNjTEZdRX1t6D8iecy2NQxcil5FsPZGW/Mc1m2vzwwkQqidGHvgbdTF@vger.kernel.org, AJvYcCXDru/uirb6RE/ex5G4O6RniDTl24WBLGgAJelDHouDPXkBafs+3q2p89KYRvvtwBCME1I78EQM@vger.kernel.org
X-Gm-Message-State: AOJu0YwHAOIMI6HwHxIoor+lZJ1fjkEARj0SWmMq/7XxjY6kOjjR4j3K
	qRjMRkMwy/acI29vOxFZ0bDvdMIDLWR4aDozTHDg4YtkW/jP22IE
X-Gm-Gg: ASbGncss6222td6S81Lc/crawGBidWM/3Bwz6930W2y7N4GmJmrrE0tggYg980/aSQj
	S8lj8K2MQyZNroaLaPEm+egSjzALJAa5tO/KuyP8udns7IylnDHnnBRdrWIaqHUYZt7aDXH2i0B
	KN1EopaPZpqyzI0Z3OS/Tosk7cugKew64JppV/Nf+K9nRWtAK73BYSFQzF60e416twi9L30M+50
	TB0X8GEp0GrA2b4+Bt+F1RikOrVHMjThj/NkgXk8vSO8z2nGy+ArTiz43wr2qYyJau003A0o+TN
	HAlKvKbWBixhWNOLNmLuBvddpT7G+UcEQ4EUaaQVsA==
X-Google-Smtp-Source: AGHT+IEm9uh2oi8GwqrdV15LlWS/Rqn7wndmxNzv/1SRiy16/A1ivtq3hKiACLTKq3h6bJm+AeDuYg==
X-Received: by 2002:a05:6214:c25:b0:6d8:899e:c3bf with SMTP id 6a1803df08f44-6e1b21c47f9mr251116416d6.34.1737470404863;
        Tue, 21 Jan 2025 06:40:04 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afce3215sm51677466d6.100.2025.01.21.06.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 06:40:04 -0800 (PST)
Date: Tue, 21 Jan 2025 09:40:03 -0500
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
Message-ID: <678fb1c3d123b_23e15a2946c@willemb.c.googlers.com.notmuch>
In-Reply-To: <806def7d-16f3-4d53-abc8-7d18e8c22dcb@daynix.com>
References: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
 <20250120-tun-v4-8-ee81dda03d7f@daynix.com>
 <678e327e34602_19c737294b4@willemb.c.googlers.com.notmuch>
 <806def7d-16f3-4d53-abc8-7d18e8c22dcb@daynix.com>
Subject: Re: [PATCH net-next v4 8/9] tap: Keep hdr_len in tap_get_user()
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
> On 2025/01/20 20:24, Willem de Bruijn wrote:
> > Akihiko Odaki wrote:
> >> hdr_len is repeatedly used so keep it in a local variable.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> ---
> >>   drivers/net/tap.c | 17 +++++++----------
> >>   1 file changed, 7 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >> index 061c2f27dfc83f5e6d0bea4da0e845cc429b1fd8..7ee2e9ee2a89fd539b087496b92d2f6198266f44 100644
> >> --- a/drivers/net/tap.c
> >> +++ b/drivers/net/tap.c
> >> @@ -645,6 +645,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
> >>   	int err;
> >>   	struct virtio_net_hdr vnet_hdr = { 0 };
> >>   	int vnet_hdr_len = 0;
> >> +	int hdr_len = 0;
> >>   	int copylen = 0;
> >>   	int depth;
> >>   	bool zerocopy = false;
> >> @@ -672,6 +673,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
> >>   		err = -EINVAL;
> >>   		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > iov_iter_count(from))
> >>   			goto err;
> >> +		hdr_len = tap16_to_cpu(q, vnet_hdr.hdr_len);
> >>   	}
> >>   
> >>   	len = iov_iter_count(from);
> >> @@ -683,11 +685,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
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
> >>   		linear = copylen;
> >>   		i = *from;
> >> @@ -698,11 +697,9 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
> >>   
> >>   	if (!zerocopy) {
> >>   		copylen = len;
> >> -		linear = tap16_to_cpu(q, vnet_hdr.hdr_len);
> >> -		if (linear > good_linear)
> >> -			linear = good_linear;
> >> -		else if (linear < ETH_HLEN)
> >> -			linear = ETH_HLEN;
> >> +		linear = min(hdr_len, good_linear);
> >> +		if (copylen < ETH_HLEN)
> >> +			copylen = ETH_HLEN;
> > 
> > Similar to previous patch, I don't think this patch is significant
> > enough to warrant the code churn.
> 
> The following patch will require replacing
> tap16_to_cpu(q, vnet_hdr.hdr_len)
> with
> tap16_to_cpu(q->flags, vnet_hdr.hdr_len)
>
> It will make some lines a bit too long. Calling tap16_to_cpu() at 
> multiple places is also not good to keep the vnet implementation unified 
> as the function inspects vnet_hdr.
> 
> This patch is independently too trivial, but I think it is a worthwhile 
> cleanup combined with the following patch.

Ok. I see what you mean.

