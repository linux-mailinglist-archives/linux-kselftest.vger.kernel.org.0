Return-Path: <linux-kselftest+bounces-7912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DD68A3FCF
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 02:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A366FB20F0A
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 00:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68966F9F0;
	Sun, 14 Apr 2024 00:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJd1QCTj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DF63214;
	Sun, 14 Apr 2024 00:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713056161; cv=none; b=eo+96CGZPxouRoa+f7KQNNe7yQAOAb8j7jwaXzqGvtA44RIC1Res4coQHu3N+LVOsCkSRzaRUUTTQxkYlhqJRdvqdxEKsv0hCwjas6rRzfiPkrgHmksxv8+jy0yWfhUfngJCQ6XVhnZEW5qzghuNGlWQaCQstvRjrLU9AiqPu8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713056161; c=relaxed/simple;
	bh=kGfXnmNtUKAtFIseVa6WI/n9HHYWtkzy7aRGv0qO5Lo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=vDfOxxojYTnydRbhtV7AZBETqbT1fBkyIwUBtXz80TzpeBSr2ItjECJfsV+p97Y5Wie777BA6Ep5Uy5mYCECnieCOsq1U7+AequxIyLYDz6jlKGGtVQzO7hd8vsDcchlO/lIFQnY9HlFzlc9kl4r0Jso7XY8rlr9pFCfPT5a2LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJd1QCTj; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-699320fcbc1so15009266d6.3;
        Sat, 13 Apr 2024 17:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713056159; x=1713660959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNZ+oOPCoNS4CcsBKvvFZNRK7O8XiSWoEaUwUPk9uNo=;
        b=DJd1QCTjzsd/VGILXnYMkulGiNr5HpBKDMbHhOFFKbVyF2S7pGnXw6Mus6hgXp6jm+
         XUwmp4BqGCChVQ+N+qf+k0lPtNLJ94VP8zXRoqkjtpGOH6nfFrF7IHWFKTGc3aRQ+EBx
         BUnMDh9RuEqqJBChCVCv/Bz7mt4PZnsKrlBeeDE3Aqs0+gdCwHdrpC2aEebmw1t6YMwz
         kgE7WcNeA1S/ruu5m6gS9dzaXfx2YUKqxsdZ9T25/IYYpIn4sk9kdKTe0lKqle7cTt18
         kkez5ppd5+j9Yu9i6w3cCZb9gfbaoMZSzsgnwxDDX+8DVBoKAKPZLhlD16k/3xmVsToS
         Vn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713056159; x=1713660959;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zNZ+oOPCoNS4CcsBKvvFZNRK7O8XiSWoEaUwUPk9uNo=;
        b=E8LeDGS8qoUaQ+VqrYTbjvJK2DZOe0C0CgZ6LkIdFCnPoVUlnJngxvMLaVu3p5voNG
         spzb2LXtetJNNKRZFYLYV6wBymmCwtT6PIiGAqDZWGrnTdzcklosiiP07cjHnNuEiDBz
         GcKbrTkV+5qRzL+pVmkHj1jNwlN05tBCJ71O+7F2V1q8pneAUU1GyBOYabW0U3VVhC3L
         fDVUntrot4wvJ9FChAZI79fWpyodOHrl0znhJ2+v3xypfkvyHIVIstgKX5+xh6Yot9pM
         wcGoaKo+TakEg72Ev7ljixCAGAXQ4ql/YBHI+C/lVZy/5lkY6Na1e8ZB59/ELAIrBWXN
         usBA==
X-Forwarded-Encrypted: i=1; AJvYcCW73QsK7ym54mDAHEhBlkf2yZ5KjKh4oKXa0Z2Z21IGnsyNbcFLycohz1Bx2VZTV0BjL8wh09OU//r5i1dwZ13pn3ihFhoUtraXACYw2JWJflMhcy61LHFouoBTnMTNKpg2TZhnMzC99CffsXq3sZf/lXwxDhc91j7+snzVFsfvqzikte1C
X-Gm-Message-State: AOJu0YxciSNIdyXHGlBLpo7vVwO18bGWuHWeYGQi4oi1rAoJHTwYLHyA
	uezwHu8UUPEM25DV07077pK6IXt9kwuZ2xhPxDymKYDeqcWqK+9E
X-Google-Smtp-Source: AGHT+IFa3ku7DLHF/teLmehAzpVA4kaLVjjalgzXYxniMfR2sFwQjq1dvcBXyfr/sMNxQKtMnWy+TQ==
X-Received: by 2002:a05:6214:516:b0:69b:1f75:e702 with SMTP id px22-20020a056214051600b0069b1f75e702mr6824288qvb.35.1713056158743;
        Sat, 13 Apr 2024 17:55:58 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id d18-20020a0cfe92000000b0069b3e70937dsm4309240qvs.81.2024.04.13.17.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 17:55:58 -0700 (PDT)
Date: Sat, 13 Apr 2024 20:55:57 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 shuah@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Message-ID: <661b299dbed73_3cb63829464@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240412155533.115507-4-richardbgobert@gmail.com>
References: <20240412155533.115507-1-richardbgobert@gmail.com>
 <20240412155533.115507-4-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v7 3/3] selftests/net: add flush id selftests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Added flush id selftests to test different cases where DF flag is set or
> unset and id value changes in the following packets. All cases where the
> packets should coalesce or should not coalesce are tested.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Thanks for adding tests. Minor point below only. The tests pass both
before and after your series, right? Then immediately a nice
validation that the optimization has no unintended side-effects.

> ---
>  tools/testing/selftests/net/gro.c | 144 ++++++++++++++++++++++++++++++
>  1 file changed, 144 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
> index 353e1e867fbb..74ab06953c38 100644
> --- a/tools/testing/selftests/net/gro.c
> +++ b/tools/testing/selftests/net/gro.c
> @@ -617,6 +617,120 @@ static void add_ipv6_exthdr(void *buf, void *optpkt, __u8 exthdr_type, char *ext
>  	iph->payload_len = htons(ntohs(iph->payload_len) + MIN_EXTHDR_SIZE);
>  }
>  
> +static void fix_ip4_checksum(struct iphdr *iph)
> +{
> +	iph->check = 0;
> +	iph->check = checksum_fold(iph, sizeof(struct iphdr), 0);
> +}
> +
> +static void send_flush_id_case(int fd, struct sockaddr_ll *daddr, int tcase)
> +{
> +	bool send_three = false;
> +	static char buf1[MAX_HDR_LEN + PAYLOAD_LEN];
> +	static char buf2[MAX_HDR_LEN + PAYLOAD_LEN];
> +	static char buf3[MAX_HDR_LEN + PAYLOAD_LEN];
> +
> +	create_packet(buf1, 0, 0, PAYLOAD_LEN, 0);
> +	create_packet(buf2, PAYLOAD_LEN, 0, PAYLOAD_LEN, 0);
> +	create_packet(buf3, PAYLOAD_LEN * 2, 0, PAYLOAD_LEN, 0);
> +
> +	struct iphdr *iph1 = (struct iphdr *)(buf1 + ETH_HLEN);
> +	struct iphdr *iph2 = (struct iphdr *)(buf2 + ETH_HLEN);
> +	struct iphdr *iph3 = (struct iphdr *)(buf3 + ETH_HLEN);
> +

minor: variable defintions before code, and reverse chrismas tree.

