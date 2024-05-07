Return-Path: <linux-kselftest+bounces-9616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89E28BE8B3
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 18:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17BA1C23814
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 16:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C29C16C44F;
	Tue,  7 May 2024 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkSU5rhY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91D316C434;
	Tue,  7 May 2024 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098835; cv=none; b=J2+6DJvH3VdyIgu1IO9L3OFjfc+416BGjdhLZMqOxz9CZ6QS/67mgkxN/WlK0xMHz8q2FtULdUjq0mYNtUvYhNGbaPOUx9k+o9vGhZmYnRa9fFfFQGnropTwzDkXQ88BJ/oYUgeVb91W/nYdLkRNJCLaheBBeCUX+JKs4hZn6Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098835; c=relaxed/simple;
	bh=XoTG5z1bAVCfS/A6+nmmPwv6OjjWrqUXKpeu2nngY7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=psLMHpelVk9GXgnF+wq6ipXcImr7lTKsYYcw+dqIVzRMraNZNx2NWmqsXofo+GxKt+zTbJcJEYsOcuudc+vD4jq4TrFvIsKXQkVO5gHdQRjDRkXLzTojNlgXuQWfNbsvaEdBynSUjV7YDmWgl1YOZiWac7LaywL+lpursHQDq2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkSU5rhY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41b79451153so27350615e9.2;
        Tue, 07 May 2024 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715098832; x=1715703632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jdb4sZljTUmWsoATTgfpaOlYZ8P52GpRSfK1mq+Jqt8=;
        b=UkSU5rhY3xz/nME/2d1AwbUFd27uvY1BByLtVlM1sqJ6V60lS8ep/hu5Bd6YcqngnV
         Suim+gx+nWJjKKta87zwblrOGwEhF4CdvuFxv1StQkDcwkAH04L/l/wDLslz6nuT/+bl
         Ac509U/zzu/Zp5VV5dmIQVxhBeNNK1smnKUxZlUtNKCj9BuEYtQkey4rcSVa2RqvxB66
         fdHVAIBc/EnbgCU4C5+KTclCIzbzlPbwTOFAPUuaIXqwn0g4Xh+/1HAa+PBmh5K/vSrL
         Z8eAr3Dvnu/Ge0oAPCMWagY2QTFMZVI8siHsNf42OhqoRJV9R3kOTwv8R7D353xwPv2H
         QFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715098832; x=1715703632;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jdb4sZljTUmWsoATTgfpaOlYZ8P52GpRSfK1mq+Jqt8=;
        b=ClCj3vw5QF5oHj+7BDIR57nvkXAXWeBpig9CNozd+0pdXy6qodYLuh4ZuJT8FfYNNU
         ndrK4WcpI/zI3Q4hNlMmZsbvpQVj014r5EAP5BJ+qjUq4SCasN5UqqLd7urT2aVL5P/X
         lsVxpc5KicuhecLwpeYmC0reT5BNbFsrujZDddVXExY6a5BGbRBXOJ5xOYYh3y4kYYyx
         gZ5DXc17hYJUtHVago+hjWGHhwcLevP4c9EtOgwqnvUb7MU/D/dQ1MEFGDWYlU40FEg8
         qf+dlhCagshlgjeFkSlp7q0oYllGbZrp+T+o5vibE/TXJitqpPRgoJP6RvRB3xmLOVP7
         A2MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlDmIQE/2Y0cT7zP+wbkQ9bzGcS9o5s1Mpna3lnoN0/OmZYQ+YKh7jMMSXhZ2N77av66W6HNJeJjEocq6eeVXZImMFlXp4qEwJCncsgJm4E8abeYc6mT8iqjRGw/zNMfiraVW6GjyRteyQIRcIbnyQwdJn85n2az/GbRUcqFz1RP64ThBh
X-Gm-Message-State: AOJu0Yxh/Lk1/L0hyJJ8NtYs6LZVBtv8w92ypQ1U5vpuKgggjJ0Pfnvd
	dBaQVLx0w+6jOei0+STNYeUtwDfIXO2m6af/tVxRTLTn0sdItmfYyVwYMA==
X-Google-Smtp-Source: AGHT+IG9Yuccb4udV7312ZeVQbLc0K+RAED0oaxolsSB0eE4fsl3H368NlYAHnbOynBlypxNm2MVeQ==
X-Received: by 2002:a5d:4a8b:0:b0:343:f3d9:a9d5 with SMTP id ffacd0b85a97d-34fca14b36amr241859f8f.10.1715098811352;
        Tue, 07 May 2024 09:20:11 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id cx8-20020a056000092800b0034e01a80176sm13287273wrb.114.2024.05.07.09.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 09:20:11 -0700 (PDT)
Message-ID: <2262e5b6-d72b-42c3-8d49-663c910904ad@gmail.com>
Date: Tue, 7 May 2024 18:19:53 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v8 3/3] selftests/net: add flush id selftests
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 alobakin@pm.me, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240506093550.128210-1-richardbgobert@gmail.com>
 <761374d3-1c76-4dc2-a4cc-7bd693deb453@gmail.com>
 <663912b7b9746_516de29445@willemb.c.googlers.com.notmuch>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <663912b7b9746_516de29445@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Richard Gobert wrote:
>> Added flush id selftests to test different cases where DF flag is set or
>> unset and id value changes in the following packets. All cases where the
>> packets should coalesce or should not coalesce are tested.
>>
>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
>> ---
>>  tools/testing/selftests/net/gro.c | 147 ++++++++++++++++++++++++++++++
>>  1 file changed, 147 insertions(+)
>>
>> diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
>> index 353e1e867fbb..5dc7b539ccbf 100644
>> --- a/tools/testing/selftests/net/gro.c
>> +++ b/tools/testing/selftests/net/gro.c
>> @@ -617,6 +617,123 @@ static void add_ipv6_exthdr(void *buf, void *optpkt, __u8 exthdr_type, char *ext
>>  	iph->payload_len = htons(ntohs(iph->payload_len) + MIN_EXTHDR_SIZE);
>>  }
>>  
>> +static void fix_ip4_checksum(struct iphdr *iph)
>> +{
>> +	iph->check = 0;
>> +	iph->check = checksum_fold(iph, sizeof(struct iphdr), 0);
>> +}
>> +
>> +static void send_flush_id_case(int fd, struct sockaddr_ll *daddr, int tcase)
>> +{
>> +	static char buf1[MAX_HDR_LEN + PAYLOAD_LEN];
>> +	static char buf2[MAX_HDR_LEN + PAYLOAD_LEN];
>> +	static char buf3[MAX_HDR_LEN + PAYLOAD_LEN];
>> +	bool send_three = false;
>> +	struct iphdr *iph1;
>> +	struct iphdr *iph2;
>> +	struct iphdr *iph3;
>> +
>> +	iph1 = (struct iphdr *)(buf1 + ETH_HLEN);
>> +	iph2 = (struct iphdr *)(buf2 + ETH_HLEN);
>> +	iph3 = (struct iphdr *)(buf3 + ETH_HLEN);
>> +
>> +	create_packet(buf1, 0, 0, PAYLOAD_LEN, 0);
>> +	create_packet(buf2, PAYLOAD_LEN, 0, PAYLOAD_LEN, 0);
>> +	create_packet(buf3, PAYLOAD_LEN * 2, 0, PAYLOAD_LEN, 0);
>> +
>> +	switch (tcase) {
>> +	case 0: /* DF=1, Incrementing - should coalesce */
>> +		iph1->frag_off |= htons(IP_DF);
>> +		iph1->id = htons(8);
>> +		fix_ip4_checksum(iph1);
>> +
>> +		iph2->frag_off |= htons(IP_DF);
>> +		iph2->id = htons(9);
>> +		fix_ip4_checksum(iph2);
>> +		break;
>> +
>> +	case 1: /* DF=1, Fixed - should coalesce */
>> +		iph1->frag_off |= htons(IP_DF);
>> +		iph1->id = htons(8);
>> +		fix_ip4_checksum(iph1);
>> +
>> +		iph2->frag_off |= htons(IP_DF);
>> +		iph2->id = htons(8);
>> +		fix_ip4_checksum(iph2);
>> +		break;
>> +
>> +	case 2: /* DF=0, Incrementing - should coalesce */
>> +		iph1->frag_off &= ~htons(IP_DF);
>> +		iph1->id = htons(8);
>> +		fix_ip4_checksum(iph1);
>> +
>> +		iph2->frag_off &= ~htons(IP_DF);
>> +		iph2->id = htons(9);
>> +		fix_ip4_checksum(iph2);
>> +		break;
>> +
>> +	case 3: /* DF=0, Fixed - should not coalesce */
>> +		iph1->frag_off &= ~htons(IP_DF);
>> +		iph1->id = htons(8);
>> +		fix_ip4_checksum(iph1);
>> +
>> +		iph2->frag_off &= ~htons(IP_DF);
>> +		iph2->id = htons(8);
>> +		fix_ip4_checksum(iph2);
>> +		break;
>> +
>> +	case 4: /* DF=1, two packets incrementing, and one fixed - should
>> +		 * coalesce only the first two packets
>> +		 */
>> +		iph1->frag_off |= htons(IP_DF);
>> +		iph1->id = htons(8);
>> +		fix_ip4_checksum(iph1);
>> +
>> +		iph2->frag_off |= htons(IP_DF);
>> +		iph2->id = htons(9);
>> +		fix_ip4_checksum(iph2);
>> +
>> +		iph3->frag_off |= htons(IP_DF);
>> +		iph3->id = htons(9);
>> +		fix_ip4_checksum(iph3);
>> +		send_three = true;
>> +		break;
>> +
>> +	case 5: /* DF=1, two packets fixed, and one incrementing - should
>> +		 * coalesce only the first two packets
>> +		 */
>> +		iph1->frag_off |= htons(IP_DF);
>> +		iph1->id = htons(8);
>> +		fix_ip4_checksum(iph1);
>> +
>> +		iph2->frag_off |= htons(IP_DF);
>> +		iph2->id = htons(8);
>> +		fix_ip4_checksum(iph2);
>> +
>> +		iph3->frag_off |= htons(IP_DF);
>> +		iph3->id = htons(9);
>> +		fix_ip4_checksum(iph3);
>> +		send_three = true;
>> +		break;
>> +	}
> 
> Consider moving the fix_ip4_checksum calls out of the switch to reduce
> duplication.
> 
>> +
>> +	write_packet(fd, buf1, total_hdr_len + PAYLOAD_LEN, daddr);
>> +	write_packet(fd, buf2, total_hdr_len + PAYLOAD_LEN, daddr);
>> +
>> +	if (send_three)
>> +		write_packet(fd, buf3, total_hdr_len + PAYLOAD_LEN, daddr);
>> +}
>> +
>> +static void test_flush_id(int fd, struct sockaddr_ll *daddr, char *fin_pkt)
>> +{
>> +	for (int i = 0; i < 6; i++) {
> 
> Please avoid unnamed magic constants. Something like
> 
> const int num_flush_id_cases = 6;	/* See switch in send_flush_id_case */
> 

Will do that, thanks for the review!

> Or even define an enum with named tests and and _MAX val. It's
> verbose, but helpful to readers.
> 
>> +		sleep(1);
>> +		send_flush_id_case(fd, daddr, i);
>> +		sleep(1);
>> +		write_packet(fd, fin_pkt, total_hdr_len, daddr);
>> +	}
>> +}
>> +

