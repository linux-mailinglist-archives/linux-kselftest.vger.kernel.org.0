Return-Path: <linux-kselftest+bounces-25428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 542F4A2310F
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 16:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D81DA7A28A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 15:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A051E9B22;
	Thu, 30 Jan 2025 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rn7IU0Xl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BD21E7668;
	Thu, 30 Jan 2025 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738251309; cv=none; b=oc6grvYLDf1ZDZhas3XQQa5SWNrvw9AXO4mXBM5cOnEVYPVBrH0kp8cUUYTwnLR548gpgxhNT2cROXyVxCXph/GuBGY4hwhoNuMviENrbLSJePk2oL8/1pZEtp5QS3f5GgMpkzzPb5scZj+3ij3Z3dMfqaJ2zDPwHJzGH6PsN08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738251309; c=relaxed/simple;
	bh=F0L0UFJMFu1dNFDx+bZr4INjxQJbiHCHvJicfSQSXmI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=h0HfsvNGCzVTr0xMRQcpcuI3qLN4FdBXBCxgiczGIqL9fXFlxM8Gloj5oqNRfdloBRG9g9WbkJTeN4vij5FnNmSZxEFu6I9N5r5Z8jIZFDP1uAlHCvhriMA55drGHdNf1nYI2euF761BJH/tHzQApy+0L9+WUvChWwVl/31wTRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rn7IU0Xl; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7be8f28172dso44928785a.3;
        Thu, 30 Jan 2025 07:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738251306; x=1738856106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Y7vjNKJSsbv0kKdvCQ/SyM2oijPldetOL5qOy4DLoo=;
        b=Rn7IU0XlldET1plmoz/H23owQqbVjvkTtMkN6LWhQopnHgJBiTDlx7PZ0ras3J/8kj
         G/KbDqd09MlnNo3wK+1MhMp/uAruKMVzTLonV+bINI1oydfoUwL6qlH50HCDpnOGyCIa
         tYq9yzkjQa23xk+MaAorN2z1ZhP+5eVSlLNdfwCFCayTgoac1vsPVtc9laegOkQGZApw
         MenxVewtjAGb0QWkht6Od245uzDCuww2gU7vZoMyKiZ5jaDJaHesFc3S0AK9JK3gg7aT
         R480C50P95/uqwUKluU+nCgrp6ajojyiKWeUryK5oFO9d8ICf0bGuBsr5eHjq2iskkvl
         tufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738251306; x=1738856106;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Y7vjNKJSsbv0kKdvCQ/SyM2oijPldetOL5qOy4DLoo=;
        b=G+M0gQhdBid9srGwvTVBupep5AqHp/X8feMSJ8fKXRfSaw7JuFina2Yb94iqGPbHb0
         Q0g+Cpctnuhqn5ONlLEyCoYQcssClXFoNvH0CJYPll/5xeG3zjas6tSxGnhBJi8Zn69N
         JQjElSUCp3OuufGivdJHLsrB2SW2oHe0xHF+x5BPdK1dYGPcIk6mJjLXsFjdcDZqCFsR
         2jTkni1rdckoB8Ran5vBak2gK11saJsDXcAYpfcpZd+OhQ6temFBzSfiapfTK2oXDTz7
         q4G7W078L6qAwrTk+7Mei0hYXuKDQRFjZug1GcCvfQUsVwUBhFN3NkuYB8dwrS6Yix/N
         9Iug==
X-Forwarded-Encrypted: i=1; AJvYcCVFzyVyOUWfVTJobDB9e4jaEttgY5ny0hB05AUipB3eOqYhDw2XTWq1VOPf0ytFbyh2fZ4nm0ye@vger.kernel.org, AJvYcCX1oDju0H9/nSG1eXI6Yqg0vXgUsFkOUjwCNnzlsrijVlvOVelXApQNScW/8L8tDFCBBZFhR14SIImaM8UIuqH9@vger.kernel.org, AJvYcCXF613tS+96AAg7caOh20aZSnoudS/cKTjn9xK0aHfTIdr/Y8yOvgAKxmW82+LnwfJT7NLtzA9/Dw9GW9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxedXDl6/ck4UeDpuwMo4JJWelC2HwT9wVYyZgf6duuhqfd3g54
	B4QMRcEGPF1w4Y/NP0ICrQyjKahsk7prcINuVftidxqbSPpWhIcC
X-Gm-Gg: ASbGnctEbMZdWALfvwCANRYZm5KPs9r5pfzPQLw94ehzWgpmcOXCqb5S9RN9kZ7oCCD
	DUmrvvbwPJQL52jlbh5U56bBI1u6VwPosdxH5ieIAbV9d9TEa/KrAFh9125EeEXsJlmeBPvbJ1v
	VLs7SExno6Vzttk0742eMXYeXuATMZWpbKshHigxX55KXT7W4Lva7GTj20OFpT8n0dvIwFfaeoG
	ImSMP/jLtOny4xXVgb0CdZFGzgsv2W+SvA+9ffYQbEdpo0sDaXk+ugUmSth3LL6rXwVCQ59QVns
	F0uB9YizqE1sQcVM9snh5eSK4h1ZLnzNJrzXw+d11veAKkeloJZh1eK47HURSXk=
X-Google-Smtp-Source: AGHT+IHSjgwd2Y2TrZu6CGi6QE0CtItO07MK1UrUGiqrJJpEqUAJ+4VQla2VPs79AMFsMXLQTlNKdQ==
X-Received: by 2002:a05:620a:2a10:b0:7b6:deab:d485 with SMTP id af79cd13be357-7bffcce52c5mr911716685a.16.1738251306156;
        Thu, 30 Jan 2025 07:35:06 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e25495e831sm7274446d6.123.2025.01.30.07.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 07:35:05 -0800 (PST)
Date: Thu, 30 Jan 2025 10:35:05 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yan Zhai <yan@cloudflare.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Josh Hunt <johunt@akamai.com>, 
 Alexander Duyck <alexander.h.duyck@linux.intel.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 kernel-team@cloudflare.com
Message-ID: <679b9c293471b_1ca8082949b@willemb.c.googlers.com.notmuch>
In-Reply-To: <Z5swit7ykNRbJFMS@debian.debian>
References: <Z5swit7ykNRbJFMS@debian.debian>
Subject: Re: [PATCH v2 net] udp: gso: do not drop small packets when PMTU
 reduces
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yan Zhai wrote:
> Commit 4094871db1d6 ("udp: only do GSO if # of segs > 1") avoided GSO
> for small packets. But the kernel currently dismisses GSO requests only
> after checking MTU/PMTU on gso_size. This means any packets, regardless
> of their payload sizes, could be dropped when PMTU becomes smaller than
> requested gso_size. We encountered this issue in production and it
> caused a reliability problem that new QUIC connection cannot be
> established before PMTU cache expired, while non GSO sockets still
> worked fine at the same time.
> 
> Ideally, do not check any GSO related constraints when payload size is
> smaller than requested gso_size, and return EMSGSIZE instead of EINVAL
> on MTU/PMTU check failure to be more specific on the error cause.
> 
> Fixes: 4094871db1d6 ("udp: only do GSO if # of segs > 1")
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> --
> v1->v2: add a missing MTU check when fall back to no GSO mode suggested
> by Willem de Bruijn <willemdebruijn.kernel@gmail.com>; Fixed up commit
> message to be more precise.
> 
> v1: https://lore.kernel.org/all/Z5cgWh%2F6bRQm9vVU@debian.debian/
> ---
>  net/ipv4/udp.c                       | 28 +++++++++++++++++++---------
>  net/ipv6/udp.c                       | 28 +++++++++++++++++++---------
>  tools/testing/selftests/net/udpgso.c | 14 ++++++++++++++
>  3 files changed, 52 insertions(+), 18 deletions(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index c472c9a57cf6..0b5010238d05 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1141,9 +1141,20 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
>  		const int hlen = skb_network_header_len(skb) +
>  				 sizeof(struct udphdr);
>  
> +		if (datalen <= cork->gso_size) {
> +			/*
> +			 * check MTU again: it's skipped previously when
> +			 * gso_size != 0
> +			 */
> +			if (hlen + datalen > cork->fragsize) {
> +				kfree_skb(skb);
> +				return -EMSGSIZE;
> +			}
> +			goto no_gso;

This is almost the same as the test below.

How about just

    if (hlen + min(cork->gso_size, datalen) > cork->fragsize)

And don't bypass the subsequent checks with a goto, or modify the
rest of the code.

> +		}
>  		if (hlen + cork->gso_size > cork->fragsize) {
>  			kfree_skb(skb);
> -			return -EINVAL;
> +			return -EMSGSIZE;
>  		}
>  		if (datalen > cork->gso_size * UDP_MAX_SEGMENTS) {
>  			kfree_skb(skb);
> @@ -1158,17 +1169,16 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
>  			return -EIO;
>  		}
>  
> -		if (datalen > cork->gso_size) {
> -			skb_shinfo(skb)->gso_size = cork->gso_size;
> -			skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
> -			skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
> -								 cork->gso_size);
> +		skb_shinfo(skb)->gso_size = cork->gso_size;
> +		skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
> +		skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
> +							 cork->gso_size);
>  
> -			/* Don't checksum the payload, skb will get segmented */
> -			goto csum_partial;
> -		}
> +		/* Don't checksum the payload, skb will get segmented */
> +		goto csum_partial;
>  	}
>  
> +no_gso:
>  	if (is_udplite)  				 /*     UDP-Lite      */
>  		csum = udplite_csum(skb);
>  
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 6671daa67f4f..d97befa7f80d 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -1389,9 +1389,20 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
>  		const int hlen = skb_network_header_len(skb) +
>  				 sizeof(struct udphdr);
>  
> +		if (datalen <= cork->gso_size) {
> +			/*
> +			 * check MTU again: it's skipped previously when
> +			 * gso_size != 0
> +			 */
> +			if (hlen + datalen > cork->fragsize) {
> +				kfree_skb(skb);
> +				return -EMSGSIZE;
> +			}
> +			goto no_gso;
> +		}
>  		if (hlen + cork->gso_size > cork->fragsize) {
>  			kfree_skb(skb);
> -			return -EINVAL;
> +			return -EMSGSIZE;
>  		}
>  		if (datalen > cork->gso_size * UDP_MAX_SEGMENTS) {
>  			kfree_skb(skb);
> @@ -1406,17 +1417,16 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
>  			return -EIO;
>  		}
>  
> -		if (datalen > cork->gso_size) {
> -			skb_shinfo(skb)->gso_size = cork->gso_size;
> -			skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
> -			skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
> -								 cork->gso_size);
> +		skb_shinfo(skb)->gso_size = cork->gso_size;
> +		skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
> +		skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
> +							 cork->gso_size);
>  
> -			/* Don't checksum the payload, skb will get segmented */
> -			goto csum_partial;
> -		}
> +		/* Don't checksum the payload, skb will get segmented */
> +		goto csum_partial;
>  	}
>  
> +no_gso:
>  	if (is_udplite)
>  		csum = udplite_csum(skb);
>  	else if (udp_get_no_check6_tx(sk)) {   /* UDP csum disabled */
> diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
> index 3f2fca02fec5..fb73f1c331fb 100644
> --- a/tools/testing/selftests/net/udpgso.c
> +++ b/tools/testing/selftests/net/udpgso.c
> @@ -102,6 +102,13 @@ struct testcase testcases_v4[] = {
>  		.gso_len = CONST_MSS_V4,
>  		.r_num_mss = 1,
>  	},
> +	{
> +		/* datalen <= MSS < gso_len: will fall back to no GSO */
> +		.tlen = CONST_MSS_V4,
> +		.gso_len = CONST_MSS_V4 + 1,
> +		.r_num_mss = 0,
> +		.r_len_last = CONST_MSS_V4,
> +	},

Please also add a test where datalen > MSS < gso_len (with .tfail = true).

>  	{
>  		/* send a single MSS + 1B */
>  		.tlen = CONST_MSS_V4 + 1,
> @@ -205,6 +212,13 @@ struct testcase testcases_v6[] = {
>  		.gso_len = CONST_MSS_V6,
>  		.r_num_mss = 1,
>  	},
> +	{
> +		/* datalen <= MSS < gso_len: will fall back to no GSO */
> +		.tlen = CONST_MSS_V6,
> +		.gso_len = CONST_MSS_V6 + 1,
> +		.r_num_mss = 0,
> +		.r_len_last = CONST_MSS_V6,
> +	},
>  	{
>  		/* send a single MSS + 1B */
>  		.tlen = CONST_MSS_V6 + 1,
> -- 
> 2.30.2
> 
> 



