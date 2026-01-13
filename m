Return-Path: <linux-kselftest+bounces-48852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C1401D18236
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 11:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 952D33004874
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 10:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0F03502BB;
	Tue, 13 Jan 2026 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyXKhICb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4E1274B26
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301211; cv=none; b=QKHfu/Q01JUiSeh8RWu+NteGiVNZJL/yjdVuWIv5Ix4XsCyMbyt3iG7X8xH8cEL00nsHESI2uxalT8EiMlx2I5su47FadwkiIONYSJvDt7xJYSkH+ypxDliJYqiOlZ4NnQaJwyoZdSe2psU1rkNHpMvUvnxPWOXGz6QqrwTxYW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301211; c=relaxed/simple;
	bh=fYO5mAVLp/077UFBDfQhXzmX4QvLaBG8lItV9IMLT1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXZVHUkQGQhgBAhhx0xiLaG2qesd1Dc2ygeA0uOq3JQFWR6eWzgU2pyZivloCnHelGPu7nVbRsN01u8igXnQwWcnkdrRpDxFPCxj2HtWybXOo4xUxkT2o/F1XciZ4wbhbI2EO0h5dIa4VQCt7DhmEbR8BJKcL2t1SwKQS0d5S6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyXKhICb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47bdbc90dcaso52022655e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 02:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768301208; x=1768906008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PKsf3wgw23/pKBp3MaibLO9IrAlpfXga+vfr5Wqb9rU=;
        b=JyXKhICbCoxP4aQeGECr8h7juVZdqeUZtCsHAACCmLhkJ9aLM2y+NZoqn0eL6f2r3p
         df1b+F6B3uSBXVjDOcz1Kfj214xWYIx6H86DQ8Hhw2Jsy0M9YtKzEPV4I38I2mepytQK
         gJMn8zeE1OsZq/HVlUCIgeN7c+MfTZrNgS7tU31PtvArPKl1NHElPMD7DxmnpzaGsh2B
         A3GWLEXLZBWrE6Cv4aHV+x/aJH10eZC5W0xW8otpiUj/05wiQmP/v2mvWfxcSv7+7XKO
         ZoVHNExc1emjviKYf8v4WMXDIgCEzv5EJN2y16SK4KXQ8BX9sz05qYbghCzMzMoY4wmX
         xI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768301208; x=1768906008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKsf3wgw23/pKBp3MaibLO9IrAlpfXga+vfr5Wqb9rU=;
        b=Yzb2JNzYUXdHtW9dAuQO1aDmez9G0udS3k/Rkry8qpUPjSS8GlZVOMAJ3Xbnireibv
         JSYFR7WO22XceotsLIqKXMhu3en1QiDb1ylT1ziBYBDNaWDFkUteoN0YqRjRaZ1wxQjv
         b9YlRrZq8VQ2jZnWZAng21mXgvkiUMGd9g2hlNIL8IMrJ0Eh3IBJx8D4S65G64g6dXKr
         DM1fNZ7/Y7aCxdcPjAsO+1KyS0GQpVK5d20pBHHeM6BkYRoN8ArHnuDmTwPrqKyAoiVQ
         4e5zf5mhKjE84KdyER5Z90WcD1gGtprfaat64AM6r8R3lMd3hlEG785Jby6RFnFHwcw6
         la1w==
X-Forwarded-Encrypted: i=1; AJvYcCXtgenmVKSgBT/0Z837rQZryMr898pKcFHLzTjUG2puSsZuLRHCWq48w14zk5gX+3jdl0rUxXKbtCMl2q61gn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9s27Q7+XojjgV9WAgteGhAHY1/U3AFXLhhxcqPyGmE+W94g+6
	cFGV/tYeOR/jZ/e0c/WPO14PpOg3Fxb1fEvb6dHX4vGyoIg/bodyOM58
X-Gm-Gg: AY/fxX7i5DwO/pdzB4fYXLXztXXTUkMkEef7BdMxIbDpH6RQLLT7oTjjuO6+icmQphS
	Kq6rdBhVAhmREg7eyBEeKHkqAcaM9EeVapQ0l4MoHocmCWK/m3NNipSIR+oN5iPsZ3JXny/o+e9
	S43uvXc6Q2s/Rwk0kzXUx/dGSvcbmmd3R7t4i8wFhzUFaPAftWrf8XtXsAVS1XzYW+n1KJL4Ara
	XMsKnLR26U+YY19zwCRGTmPOUB5yDiqbWc2OeJGOOgxh3coP/TsSQb3uQ44oCqia8gKqdgZtKYE
	UTZWEwGlOJuEbcxvWtYR8GO1pJW8MvZfrflA87TW8sav7+gezsg2H5sDYnx8i4s8IKxSlVKezts
	GP22VVNMf++yqy4el9g727NTyzhOuBPGMyfQCx+jb3tnJ0x48TPSPUBFqMkxO7OlfB5Y3GwSVne
	/eySc1Xvk9/jUsavjxJXqxLbcryulQAs7Wa4UUAjQ9qhJWaToZQv5eRQpd6HZ+AOTQjQoRHwPG9
	y+5lqJwnXrMMuEsMqaT4gvhLjQ5beeOse0/WrwtXh33JDxbran9mM8ru+oDBkgLSQ==
X-Google-Smtp-Source: AGHT+IEymhtJvsVvq7h/MiDqH9B3Tq4aNk4c91QeNppt4FR+JHUA9Tffj05tYCrsjh9jqUJvxHBGZw==
X-Received: by 2002:a05:600c:3152:b0:47d:403c:e5a0 with SMTP id 5b1f17b1804b1-47d84b184abmr250841245e9.12.1768301207472;
        Tue, 13 Jan 2026 02:46:47 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f65d9f0sm409975245e9.12.2026.01.13.02.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 02:46:46 -0800 (PST)
Message-ID: <da02d2af-ba34-4646-b56b-bcb9631cb286@gmail.com>
Date: Tue, 13 Jan 2026 10:46:41 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 5/9] eth: bnxt: store rx buffer size per queue
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Alexander Duyck <alexanderduyck@fb.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan
 <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>,
 Alok Tiwari <alok.a.tiwari@oracle.com>, Ziwei Xiao <ziweixiao@google.com>,
 John Fraker <jfraker@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Joe Damato <joe@dama.to>,
 Mina Almasry <almasrymina@google.com>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, David Wei
 <dw@davidwei.uk>, Yue Haibing <yuehaibing@huawei.com>,
 Haiyue Wang <haiyuewa@163.com>, Jens Axboe <axboe@kernel.dk>,
 Simon Horman <horms@kernel.org>, Vishwanath Seshagiri <vishs@fb.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, dtatulea@nvidia.com,
 io-uring@vger.kernel.org
References: <cover.1767819709.git.asml.silence@gmail.com>
 <e01023029e10a8ff72b5d85cb15e7863b3613ff4.1767819709.git.asml.silence@gmail.com>
 <017b07c8-ed86-4ed1-9793-c150ded68097@redhat.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <017b07c8-ed86-4ed1-9793-c150ded68097@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/13/26 10:19, Paolo Abeni wrote:
> On 1/9/26 12:28 PM, Pavel Begunkov wrote:
>> @@ -4478,7 +4485,7 @@ static void bnxt_init_one_rx_agg_ring_rxbd(struct bnxt *bp,
>>   	ring = &rxr->rx_agg_ring_struct;
>>   	ring->fw_ring_id = INVALID_HW_RING_ID;
>>   	if ((bp->flags & BNXT_FLAG_AGG_RINGS)) {
>> -		type = ((u32)BNXT_RX_PAGE_SIZE << RX_BD_LEN_SHIFT) |
>> +		type = ((u32)(u32)rxr->rx_page_size << RX_BD_LEN_SHIFT) |
> 
> Minor nit: duplicate cast above.

oops, missed that, thanks

> 
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
>> index f5f07a7e6b29..4c880a9fba92 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
>> @@ -1107,6 +1107,7 @@ struct bnxt_rx_ring_info {
>>   
>>   	unsigned long		*rx_agg_bmap;
>>   	u16			rx_agg_bmap_size;
>> +	u16			rx_page_size;
> 
> Any special reason for using u16 above? AFAICS using u32 will not change
> the struct size on 64 bit arches, and using u32 will likely yield better
> code.

IIRC bnxt doesn't support more than 2^16-1, but it doesn't really
matter, I can convert it to u32.

-- 
Pavel Begunkov


