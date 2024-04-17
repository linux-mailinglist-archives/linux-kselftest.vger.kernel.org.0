Return-Path: <linux-kselftest+bounces-8255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E436B8A857F
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 16:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215F81C211F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 14:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970AA1411C4;
	Wed, 17 Apr 2024 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQJl4ST/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EEF140E3D;
	Wed, 17 Apr 2024 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713362497; cv=none; b=LQb3750zmU5UXKXW09Izz1mxysH+bDWmdyNfyju4MC+rs6TOTTHwB6V5Nhcatg7I8zTVyRUWihsB3Jn1lqZAUOpGQyBnM8eEtPciGyUfBDCowXHi8pNQSsYz3A9gwVZLlQmI8xox00/Lwc9GJBW0Cm63NpZyAakhHuvxZ0C0Nms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713362497; c=relaxed/simple;
	bh=CU+HeyH/ojny8KZnhNOlUonCof6xRoup05E6NQI+eDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ojyw0gZTTxu56yj6RWw5KWndTWsXG+NPntGnXYGDA/5827iZLQKxXdTa6w033Ker67OVslER9QD1Cmpj30lc3+b/21/+suiIrRs1OalL1Q0az7IM8XItDwkTOSw+K9tMUS0jN6a8l/zaQDLsWHM5hDCtujyBxNB2Lzy/Er3KE8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQJl4ST/; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-434c695ec3dso24098481cf.0;
        Wed, 17 Apr 2024 07:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713362495; x=1713967295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p1tT3cYXJu3UEQ4P60TpLumIC3N8bqb0igmiPgrEPJw=;
        b=MQJl4ST/PqOmBVGK85WSDGRFz5z1vGJMZVn+/BybRzPQRrifNZm7Nmf9QQxQeF9Qm2
         lempYDBSDABxo5EYkGAlH6bdj3SmPRTa7T6BlhZR4uHD5jT7oB/vbCTB8gF6lCT9RWbM
         mm4VEUkGnzq2scEh+EpLdMxYfFnEMa0apnJiwP9eAzPqkkr8gu4zypVBkIMt/YYT7CMU
         h5Tctswzq5Zg8pcVfGzpGqslBi/1SHFi8rcbPpYSpcLp1HUvTqmUgY7qP7FdX+Nl/FtQ
         UiRNMKPvnEBZ0NDdAigJs2opeUBML4rSVTmdJUf9LjPXl5gekkk108U7x8LDQBj02TTZ
         UDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713362495; x=1713967295;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p1tT3cYXJu3UEQ4P60TpLumIC3N8bqb0igmiPgrEPJw=;
        b=LdxZduobMbtcZ8qg4x8KiXILDNbTVUrjXOt730XDAqEyvOmiYBdP5cB6VTJlzBKw1M
         JgDsrf0gD0BZ5FzBRerdFXI12ZOQ6+gcdemqGSSdQvkAWxa93ZQgJgpytcmQTjpTOINw
         zZ4lQvVji8BgTSaJ1zUeugGvl+KHjAvkH5MTTUlgLatd0tPqh0NZJYVCcjnu1GBvRB4l
         9AduRvrLWV4zpajg3reOS6nHuC/64jolSwExJuY8xaHjU5/AiGKHKmn/cFAlsU6eB+M0
         Sl4/JY+HcBe+qdRPo0cQBOM/blDnfs67Ru40Ot7EgNyzFzTpYVq9DPqKCb1mk84FO1J5
         aj7w==
X-Forwarded-Encrypted: i=1; AJvYcCWpI+fLc2DX+GW0SbaJjILLzAq+iU7h6gtGcpq7ZSNHSv/jKsKFObX+cj7gg6ecjb+7U3wUjIsVsUI92EN/HvPKWsjmlSMGALKuazHUIHHdhKhh609bmxKP2+ljpUx+xclzO5LoQnxogJdS8r64CcB5V/4VNbRIJHCN78oBuEehQARPV+sr
X-Gm-Message-State: AOJu0Yx7ZTOVhV6NfA51d1DQ9e54kP1tZbN2U5uG2MNwWf8d8zO8ZBcX
	HdVFH+GTYpANW/3XZMiVqBhJPypLs7GSCeqpegKmTfOsgZK+mHYJzxaO+w==
X-Google-Smtp-Source: AGHT+IGwTfoazo/W+mHuGauFRi22Q3/jlm0lmB2lmKtHEYWXxKWBX4U6oEuNpob9eIHzQul5Jfwrbg==
X-Received: by 2002:ac8:5ad5:0:b0:434:e71b:f9e1 with SMTP id d21-20020ac85ad5000000b00434e71bf9e1mr21367015qtd.10.1713362494869;
        Wed, 17 Apr 2024 07:01:34 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id kg26-20020a05622a761a00b00434c1eedb0esm8088375qtb.36.2024.04.17.07.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 07:01:34 -0700 (PDT)
Message-ID: <ec343187-caea-4b60-af7c-f232e31d2cf2@gmail.com>
Date: Wed, 17 Apr 2024 16:01:22 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v7 3/3] selftests/net: add flush id selftests
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240412155533.115507-1-richardbgobert@gmail.com>
 <20240412155533.115507-4-richardbgobert@gmail.com>
 <661b299dbed73_3cb63829464@willemb.c.googlers.com.notmuch>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <661b299dbed73_3cb63829464@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Richard Gobert wrote:
>> Added flush id selftests to test different cases where DF flag is set or
>> unset and id value changes in the following packets. All cases where the
>> packets should coalesce or should not coalesce are tested.
>>
>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> 
> Thanks for adding tests. Minor point below only. The tests pass both
> before and after your series, right? Then immediately a nice
> validation that the optimization has no unintended side-effects.
> 

Yes, the logic is preserved - tests pass both in net-next and after
applying the patch :)

>> ---
>>  tools/testing/selftests/net/gro.c | 144 ++++++++++++++++++++++++++++++
>>  1 file changed, 144 insertions(+)
>>
>> diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
>> index 353e1e867fbb..74ab06953c38 100644
>> --- a/tools/testing/selftests/net/gro.c
>> +++ b/tools/testing/selftests/net/gro.c
>> @@ -617,6 +617,120 @@ static void add_ipv6_exthdr(void *buf, void *optpkt, __u8 exthdr_type, char *ext
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
>> +	bool send_three = false;
>> +	static char buf1[MAX_HDR_LEN + PAYLOAD_LEN];
>> +	static char buf2[MAX_HDR_LEN + PAYLOAD_LEN];
>> +	static char buf3[MAX_HDR_LEN + PAYLOAD_LEN];
>> +
>> +	create_packet(buf1, 0, 0, PAYLOAD_LEN, 0);
>> +	create_packet(buf2, PAYLOAD_LEN, 0, PAYLOAD_LEN, 0);
>> +	create_packet(buf3, PAYLOAD_LEN * 2, 0, PAYLOAD_LEN, 0);
>> +
>> +	struct iphdr *iph1 = (struct iphdr *)(buf1 + ETH_HLEN);
>> +	struct iphdr *iph2 = (struct iphdr *)(buf2 + ETH_HLEN);
>> +	struct iphdr *iph3 = (struct iphdr *)(buf3 + ETH_HLEN);
>> +
> 
> minor: variable defintions before code, and reverse chrismas tree.

Good catch, I'll apply these changes and push v8 when the relevant series
for net will be merged. Thanks!

