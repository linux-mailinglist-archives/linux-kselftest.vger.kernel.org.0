Return-Path: <linux-kselftest+bounces-41041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3C1B4A83F
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 11:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3500918945BF
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 09:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8082B2D7398;
	Tue,  9 Sep 2025 09:27:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4E42D6E74;
	Tue,  9 Sep 2025 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757410060; cv=none; b=ogVhlO7pJmd96UYbVEUQB23dk4BD2IjubwYeMGLCSdAlnxrbaL1Tc/SX9SHpmvBNx2k/igoeCaVchKr2uk4ElDF3WDrlI+mTg+wRJ5sDk3L+1Usxn6Gbp5+B0MLDMXskptfr+rPncGgUU4rJdrGAewNbp/XMymWe4RwNCPMBoio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757410060; c=relaxed/simple;
	bh=ppynKOhlQZrrzRmCZPG5ZcpM9h6fYtoudNIbSvBcgDU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HmJ0bnUjHi6AcV6v9xRKBXaBsf25kjefLY/2Hl9XnEq3YfNXCAh0V2a8J3PDTht9dGPyrWBP/XF68WqTz8CeDH1HMN/ntFgx2ln/BTqIgit0ZKJT6ApXJ5iUTgsXJgDv7lCCmHrELrrHldHvelk6YRieAGxB1tQdJfZEhyv5Q2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-45df09c7128so3304385e9.1;
        Tue, 09 Sep 2025 02:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757410057; x=1758014857;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksjAnKaMZ4iyJ0ZUawa3XTHbrqb6Br6KTspOPBda3jU=;
        b=vwOv1BxI3S88c03iHgoc8wRSpBBs5GvyfCmhnOKEFQHE1YWmknlbVOBJ1rg/tE8o4f
         3SFtCL2ZPbzerK8PuwPJRz1YfRrwo1s1qvCmSbDFSYKgb3i6MUuMWWMY848JumWvPUPa
         8suoQ6TtFG2EI0Uj/JdGsM/YU+4m9AtRes9x8wOiFu2Z4PthTYQhfXgQABNrXB+rCcfi
         VtbpCH/1Xqroc2gRVcbrYtGM91gMwq09O9QFeNyWR3pAjl3PNU8s2kPDUfrgYy7sOUZe
         1O22+YOVbRzzW6WR/XHjQvUr3dECmjMCHBnEpF5rMU106HokOROomBGGDxOJ18q1Zj4V
         CW2w==
X-Forwarded-Encrypted: i=1; AJvYcCUY0MjScKZp8xEBAh09rJxOA7WHjKbVSU7yuYCDXlywSEzGYiSaPVT1LbAqGtgqpPmaAQd5XU/4@vger.kernel.org, AJvYcCUqn6LcyapB2SeTVNgQbzFQijDx96zSjf4WLXxI1oaSBK6FdY9jOAavj0rNg/BF3TLDmXfT8ZJFIDYlWMeOf/wW@vger.kernel.org, AJvYcCW+HSYW4sZM3MvjoTuyrt+d5u+Z0HvFGFgbmroRYgGmk5qmF3OUFpkv1Rt5AiG2kmP8AcuYjKNpki88sbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1/qbrESn8pqwbFY5IpW2WdxUGsK9y+5QC1EI9VZjfV6qz5QBO
	kl+PIDuhk7AwuyvJcHecSZ2UATT/EUNkY/5Jcjp+6WDEeHLRleATo2c+77QVqX7Y
X-Gm-Gg: ASbGncuJloz+q7SEW4iC1bQXiswWjlFy8V3Dx0JPdqarHf4azzasl/Em/LbPGRtb2D1
	5X/FlH567SAm7WloEulF4RMoIbFuoY1/e8Cltg0t/xXPIWtukePZSvuN95610scMSiSHRlBGEop
	Avoln5VqWxtb8ZH5XIfrZZbZudNBgudzGRc32cDadFxqsc6k4BhgUzPdzwlD6LTfzttjL37PWZ7
	lTONailgm5rl+PQUZQTJ/ViXiwT8d6KRT7TQKpJF2am2XJd6H8cplIikJSpvsHdbY37j6ksAcOa
	r98iF1QApRrG68V32msqu9VAc/smDhepkdFXrdruQulQpBPFO1n5mRGRWO80TmWHpOcNSJdeBhD
	SNpYGqFqJ2Mkd8BlklSJvPznAdDMOcqSYIBsmMqCLCZQFGL4RItokF5u7FV0Pzk9UHQ==
X-Google-Smtp-Source: AGHT+IH/7mAmrftaGc+Yv0Mxl1majr2DM9UsuQLqEi1oA/Z+zk7GWhPo6sc5LSSODi2WWIzL37G8xg==
X-Received: by 2002:a05:600c:c491:b0:45d:d79c:7503 with SMTP id 5b1f17b1804b1-45dde20041amr93351555e9.12.1757410056601;
        Tue, 09 Sep 2025 02:27:36 -0700 (PDT)
Received: from [192.168.88.248] (89-24-56-72.nat.epc.tmcz.cz. [89.24.56.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dda2021dfsm171185765e9.24.2025.09.09.02.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 02:27:36 -0700 (PDT)
Message-ID: <019efaf3-2f4f-4b67-9d25-271b052df84b@ovn.org>
Date: Tue, 9 Sep 2025 11:27:34 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, dev@openvswitch.org,
 Eelco Chaudron <echaudro@redhat.com>, Aaron Conole <aconole@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH net 1/2] net: dst_metadata: fix IP_DF bit not extracted
 from tunnel headers
To: Ido Schimmel <idosch@idosch.org>
References: <20250905133105.3940420-1-i.maximets@ovn.org>
 <20250905133105.3940420-2-i.maximets@ovn.org> <aL_oHVTjm6zw9AJO@shredder>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <aL_oHVTjm6zw9AJO@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 10:41 AM, Ido Schimmel wrote:
> On Fri, Sep 05, 2025 at 03:30:55PM +0200, Ilya Maximets wrote:
>> @@ -220,9 +221,15 @@ static inline struct metadata_dst *ip_tun_rx_dst(struct sk_buff *skb,
>>  						 int md_size)
>>  {
>>  	const struct iphdr *iph = ip_hdr(skb);
>> +	struct metadata_dst *tun_dst;
>> +
>> +	tun_dst = __ip_tun_set_dst(iph->saddr, iph->daddr, iph->tos, iph->ttl,
>> +				   0, flags, tunnel_id, md_size);
>>  
>> -	return __ip_tun_set_dst(iph->saddr, iph->daddr, iph->tos, iph->ttl,
>> -				0, flags, tunnel_id, md_size);
>> +	if (iph->frag_off & htons(IP_DF))
>> +		__set_bit(IP_TUNNEL_DONT_FRAGMENT_BIT,
>> +			  tun_dst->u.tun_info.key.tun_flags);
> 
> Shouldn't you check that tun_dst isn't NULL?

That's true.  It should be:  if (tun_dst && ...)
I had too many versions of this change and lost the check in the end.

Will wait a bit and then send a v2.

Thanks!

Best regards, Ilya Maximets.

