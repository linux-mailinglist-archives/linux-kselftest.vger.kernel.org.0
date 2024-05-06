Return-Path: <linux-kselftest+bounces-9544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F36E88BD3CF
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 19:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FEE28540E
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 17:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F1E157480;
	Mon,  6 May 2024 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJBhM3hI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCCB15747A;
	Mon,  6 May 2024 17:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715016379; cv=none; b=JtUKAK04uttzmASPpnfijSWUjwma3T6YjScq9ew01FvRjcrtLdi0GppnYv6Z6TimejOI1wpei0+jEHQr0aFuMApPLfkZZJVanFQLjRMr0Yu9SGW5g+0y4xtlOTFO0sLF20ZkLLpYVgD1F21gCMYRoicWsVvloAkCFVccpLiqp/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715016379; c=relaxed/simple;
	bh=MItOV8hMg+olosaIlnJ6NDr65xwqJcwU8Z4bEj8wYQM=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HD0WzOnUcs7hxKZr7VJWBWLviKyRVd78BESihp4VUdmrzXRppniHu6AB/d71dHW7zVtGQmvP8bvMwQNA8+Vcr7/Wy4vpi0wjyPLAUbkKD40sggZPuOnXiUaoyjdHKM8jP0n+cljHIpP2I02sKLeSWzQ9Oqe//SKqmSx2qv1K29g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJBhM3hI; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6181d032bf9so20260647b3.3;
        Mon, 06 May 2024 10:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715016376; x=1715621176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wuju28aY+PFkQvxmGZtNIpSACxyjaEw9XjsWh02SLLA=;
        b=HJBhM3hI8u5uZrHbSWD1yp+4e2reEiMwfXVl/VQAGWVHom1pTgJLGVn1csrx/pYVen
         LpaVqLvSgYySRof+/rYrEitfRb+gpbsW0oHDHwgDdEc6zpsq09kIwAwqD4sKEd2/RgRZ
         tghGCt/q7UzAW1PkZcn33Xsw/qkzKLWSmc86FO2JPzikG62DVIJJamyjOleNJxmd6jRo
         Qwfj9HAnTYW/+0q7oDi18++ljs3CSNxsMBaJaky5iKHqYAvyb09rTtTFX2ZsQGH0Kr/j
         OlLwQoK9r1QOGHy0/431F/Eo5W41BOnnV9SuV5C4w50ecRs34if2BCP6yH7zEoJK0fcU
         JWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715016376; x=1715621176;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wuju28aY+PFkQvxmGZtNIpSACxyjaEw9XjsWh02SLLA=;
        b=RuTgPy7MEw1Xci306xbRcnjGow8Uz5giHwT7XMV7pSqBm7b8jq7Iyou46uyPFbWByP
         P86qzLOTEhvVHKPEszyB/2rnpHR/MYsV2YxUWDLDDKsHF3q82rD4tBPI09fck6lGNRTD
         sHlKX8bxDFt6IsqL9UOwxfdSYavufq121vPRgZO1eyLKhGeVegTMgME+/b4I+rR56LcJ
         bAKs55YEnGG2U0eGYNSKgrE4Um6nHvHEL+x5Lakxg3DNHqi2Uae1M2/LF6RNfhJBj/7F
         5xmjDOShsYGUdd0Adp9UPx1HBIT/1f/h7KJIOsAVfQ3sIp1dyK8N/+P2MzSk+1nbQLSf
         pJeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUA4cXFCJukcuMhHbMMdBU6ql39tevvp2Na/eTrUvHL9hk3i4WFGBI/WmCtzoIxsA38wAQ42TvHXggOFMfgzdBOdDIzpvvOB9D/JsrqXmjavwT/goj6mpbGTru8tYFnrgb+VkSxgDm2HjgSF40OYa4JHZ3Qo771toEV6LrVmyyAAgvqhmc
X-Gm-Message-State: AOJu0YyUz7MCNLxhjWFq5SVXDuI0AfM8u1agWi7AcyUY2r9zy+eByPDL
	tgywtwOz+1hkvD00t5cH5Lp4jXk1+UP6cCI/1nGiJbf17oauc02m
X-Google-Smtp-Source: AGHT+IEEIhRzQPPWEZapafecc9KRrti7+Bx4/RcP1LezidWSb31RwV6jcaEupYJ/c+5oIEANg7Pjpw==
X-Received: by 2002:a5b:a0d:0:b0:de5:9f30:e40c with SMTP id k13-20020a5b0a0d000000b00de59f30e40cmr10395194ybq.4.1715016376437;
        Mon, 06 May 2024 10:26:16 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id bx9-20020a05622a090900b0043490cc5254sm5352234qtb.32.2024.05.06.10.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 10:26:15 -0700 (PDT)
Date: Mon, 06 May 2024 13:26:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 willemdebruijn.kernel@gmail.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 alobakin@pm.me, 
 shuah@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <663912b7b9746_516de29445@willemb.c.googlers.com.notmuch>
In-Reply-To: <761374d3-1c76-4dc2-a4cc-7bd693deb453@gmail.com>
References: <20240506093550.128210-1-richardbgobert@gmail.com>
 <761374d3-1c76-4dc2-a4cc-7bd693deb453@gmail.com>
Subject: Re: [PATCH net-next v8 3/3] selftests/net: add flush id selftests
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
> ---
>  tools/testing/selftests/net/gro.c | 147 ++++++++++++++++++++++++++++++
>  1 file changed, 147 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
> index 353e1e867fbb..5dc7b539ccbf 100644
> --- a/tools/testing/selftests/net/gro.c
> +++ b/tools/testing/selftests/net/gro.c
> @@ -617,6 +617,123 @@ static void add_ipv6_exthdr(void *buf, void *optpkt, __u8 exthdr_type, char *ext
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
> +	static char buf1[MAX_HDR_LEN + PAYLOAD_LEN];
> +	static char buf2[MAX_HDR_LEN + PAYLOAD_LEN];
> +	static char buf3[MAX_HDR_LEN + PAYLOAD_LEN];
> +	bool send_three = false;
> +	struct iphdr *iph1;
> +	struct iphdr *iph2;
> +	struct iphdr *iph3;
> +
> +	iph1 = (struct iphdr *)(buf1 + ETH_HLEN);
> +	iph2 = (struct iphdr *)(buf2 + ETH_HLEN);
> +	iph3 = (struct iphdr *)(buf3 + ETH_HLEN);
> +
> +	create_packet(buf1, 0, 0, PAYLOAD_LEN, 0);
> +	create_packet(buf2, PAYLOAD_LEN, 0, PAYLOAD_LEN, 0);
> +	create_packet(buf3, PAYLOAD_LEN * 2, 0, PAYLOAD_LEN, 0);
> +
> +	switch (tcase) {
> +	case 0: /* DF=1, Incrementing - should coalesce */
> +		iph1->frag_off |= htons(IP_DF);
> +		iph1->id = htons(8);
> +		fix_ip4_checksum(iph1);
> +
> +		iph2->frag_off |= htons(IP_DF);
> +		iph2->id = htons(9);
> +		fix_ip4_checksum(iph2);
> +		break;
> +
> +	case 1: /* DF=1, Fixed - should coalesce */
> +		iph1->frag_off |= htons(IP_DF);
> +		iph1->id = htons(8);
> +		fix_ip4_checksum(iph1);
> +
> +		iph2->frag_off |= htons(IP_DF);
> +		iph2->id = htons(8);
> +		fix_ip4_checksum(iph2);
> +		break;
> +
> +	case 2: /* DF=0, Incrementing - should coalesce */
> +		iph1->frag_off &= ~htons(IP_DF);
> +		iph1->id = htons(8);
> +		fix_ip4_checksum(iph1);
> +
> +		iph2->frag_off &= ~htons(IP_DF);
> +		iph2->id = htons(9);
> +		fix_ip4_checksum(iph2);
> +		break;
> +
> +	case 3: /* DF=0, Fixed - should not coalesce */
> +		iph1->frag_off &= ~htons(IP_DF);
> +		iph1->id = htons(8);
> +		fix_ip4_checksum(iph1);
> +
> +		iph2->frag_off &= ~htons(IP_DF);
> +		iph2->id = htons(8);
> +		fix_ip4_checksum(iph2);
> +		break;
> +
> +	case 4: /* DF=1, two packets incrementing, and one fixed - should
> +		 * coalesce only the first two packets
> +		 */
> +		iph1->frag_off |= htons(IP_DF);
> +		iph1->id = htons(8);
> +		fix_ip4_checksum(iph1);
> +
> +		iph2->frag_off |= htons(IP_DF);
> +		iph2->id = htons(9);
> +		fix_ip4_checksum(iph2);
> +
> +		iph3->frag_off |= htons(IP_DF);
> +		iph3->id = htons(9);
> +		fix_ip4_checksum(iph3);
> +		send_three = true;
> +		break;
> +
> +	case 5: /* DF=1, two packets fixed, and one incrementing - should
> +		 * coalesce only the first two packets
> +		 */
> +		iph1->frag_off |= htons(IP_DF);
> +		iph1->id = htons(8);
> +		fix_ip4_checksum(iph1);
> +
> +		iph2->frag_off |= htons(IP_DF);
> +		iph2->id = htons(8);
> +		fix_ip4_checksum(iph2);
> +
> +		iph3->frag_off |= htons(IP_DF);
> +		iph3->id = htons(9);
> +		fix_ip4_checksum(iph3);
> +		send_three = true;
> +		break;
> +	}

Consider moving the fix_ip4_checksum calls out of the switch to reduce
duplication.

> +
> +	write_packet(fd, buf1, total_hdr_len + PAYLOAD_LEN, daddr);
> +	write_packet(fd, buf2, total_hdr_len + PAYLOAD_LEN, daddr);
> +
> +	if (send_three)
> +		write_packet(fd, buf3, total_hdr_len + PAYLOAD_LEN, daddr);
> +}
> +
> +static void test_flush_id(int fd, struct sockaddr_ll *daddr, char *fin_pkt)
> +{
> +	for (int i = 0; i < 6; i++) {

Please avoid unnamed magic constants. Something like

const int num_flush_id_cases = 6;	/* See switch in send_flush_id_case */

Or even define an enum with named tests and and _MAX val. It's
verbose, but helpful to readers.

> +		sleep(1);
> +		send_flush_id_case(fd, daddr, i);
> +		sleep(1);
> +		write_packet(fd, fin_pkt, total_hdr_len, daddr);
> +	}
> +}
> +

