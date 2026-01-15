Return-Path: <linux-kselftest+bounces-49041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6F3D26267
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 18:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3975B3026600
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 17:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE883BF2F7;
	Thu, 15 Jan 2026 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mt1r2nl5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63223BF305
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497067; cv=none; b=X+GRzdwTQly5pLMtoA5Iw+kaTi+DW89cRIXUhg4f/8zxZVcXljKoVExcf9fcUOEkQnsakwChAtxcPVDKEBY/WPZskliJvclh8Ryyab82KEBcH7/BzAeFXyqkB8YTD8EPqsW4ypbOKZJCvZ+9lqXQQIHsfLvggYlW2aBFIqKoBOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497067; c=relaxed/simple;
	bh=z5fuYqtywwL6KOIHKbWzEHmAdjuqly6oA3cwR7sT8v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TojmgdytZJbUkLbJr4QpkSA/vFIfNgmsFSSyR6bTcU/eBePSWQ9LjwOkshI9IN3HeSQi7aHuAlGCTonFs17W9+YzrufKEq3zfi9PQWA21hnepy9l6tV4oOZByfqK/yp3y6defH1Sv1EKoeR533eFM0cMlclWyAayhpI0lH3U01c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mt1r2nl5; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa4so921450f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 09:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768497063; x=1769101863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/9zIIkhhFGJW7c5euU+uczxwuqnCR/g7cOorqaRVjc8=;
        b=mt1r2nl5+IcwV4rIclf6O+vfsoItttvYMAwELjX7wAw87RRtgoOW4yjf89VreUeVMN
         DUvrtR/D70+SBDc9heH/xdBvKbODGU113itq08ukub4tw+xmUGwWcQhvsS/yavKIjx8y
         PASkfYCvUsV604SnIoRkl5iKxMvUsKrbTugd7YH3ahhdIWQQnwHQ1c0NgQjcQgRbKuv2
         7EhanVPn/TK/MhaAGM941iuLfLGdB+n9VQzBnIWd0wo7hXd3PVboAUZARPbzFlr0f3XW
         mTrXKtW8TsgnMgSgjAIi7VeQPc9k6LrWVpOEBn+lZbb7YXfAaBO7VVSecu2OIE4EI6IW
         MwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768497063; x=1769101863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9zIIkhhFGJW7c5euU+uczxwuqnCR/g7cOorqaRVjc8=;
        b=ubQUps12jt7B1jJVN7Ktq1tZdNMKkI5PwlAdoU3mBiqyXGWQwsa3yCvS1ZyfrT7S6k
         VBu65/uScZHL5LVuf4weqPkqJe0vBmeglAx32W1gd/U//+DWsujdhBdIrPZf+UwqPIgO
         N2Xtxgjawy6VJnD6Mej7ZllSdd7xnQXz2zXBojsrrxl4uU26h8R+aAovMP73Ds2DcNEF
         aGYcCOe0o1cT/Iaz7V1ZQLC39gnKiLvEVu/qF2tA7xm1iF+Jh36ix8nV2r4bSnxFXKry
         xsnqfNhqofIw1r3jR3O1WcSfvpJ4Pwxw9kpyFk4TEE6IDeUF9Q9MQktixNtektTwNHQG
         Rz9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmb4nXMlnSNn/LNGcah1wbJgUSTngfDpnKmgO7m0m0PKReR4gOOtEgACNsOXIf3qGtTAlD10YEiny8gS93Ck4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEDTI5EIQYqeXIoAKAOnK/xio/54bWpJVzdXM5SvNrTVeP5B60
	oV67VtDqzyVMhSc6GQaWLQpfIFOzEX1haprErk9Zm2hQAtJ7vRLS3pkF
X-Gm-Gg: AY/fxX68rIePmp/xQ0xAxp3LngiZcCPQDHKmte7dZrqu9mtGzq9yZtFIxf3Nc7td2f3
	KfnVG60B2DssT7uFx2R+wDVTN/89P9CznH80ue9J8XYBMlS+4mzbP4ydJI5BfnuLAu+LxxM6fZC
	Wbk02ebUBYgMJ3fCMDfrG1sq8rFiO7ZVt3RDmhqENWEmBYilNRDkpHw4snnDyCena+PgPlt4K+R
	/ISG2XE5/Deu3QStYZX7akqFKiPWT4CXr+dzFmFlsphaw54bkYYb/Wsl2ZLze9xhksqZuSTKRrd
	847ehjJ+LH2in7KYQuhfkFt6e7G/ubKVEF1EcYr0iU3/qn2HHgv6bPcgR6Io9ZNcbYf8ywdFAoz
	664c+dBZ7yiq4KKqffLGgjq609RR6655r487+y4+O+MsjQNweLEYTYz2VAsLY5pQI6DP0bP8mo6
	WmqjZRqeUktNzskEEgkNvO8lK9mCilcu2FG0/YDeZj3pMkL/SgeAqfPuzNWCax2Q1o5hDNXR5J3
	ic/SB1J20xAbQHIKuAGtIkGq0qEn2gK8eNVNyGSCK37b0ed+e4W2wxDSaRYWjNW7g==
X-Received: by 2002:a05:6000:1889:b0:431:9b2:61c4 with SMTP id ffacd0b85a97d-43569bc77b8mr74982f8f.45.1768497062676;
        Thu, 15 Jan 2026 09:11:02 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996cf42sm104023f8f.20.2026.01.15.09.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 09:11:01 -0800 (PST)
Message-ID: <5c0f28de-41dd-47c6-9b0b-9ea40cbbeab2@gmail.com>
Date: Thu, 15 Jan 2026 17:10:55 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 7/9] eth: bnxt: support qcfg provided rx page
 size
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
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
 <28028611f572ded416b8ab653f1b9515b0337fba.1767819709.git.asml.silence@gmail.com>
 <20260113193612.2abfcf10@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260113193612.2abfcf10@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/26 03:36, Jakub Kicinski wrote:
> On Fri,  9 Jan 2026 11:28:46 +0000 Pavel Begunkov wrote:
>> @@ -4342,7 +4343,8 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
>>   		if (!rxr)
>>   			goto skip_rx;
>>   
>> -		rxr->rx_page_size = BNXT_RX_PAGE_SIZE;
>> +		rxq = __netif_get_rx_queue(bp->dev, i);
>> +		rxr->rx_page_size = rxq->qcfg.rx_page_size;
> 
> Pretty sure I asked for the netdev_queue_config() helper to make
> a return, instead of drivers poking directly into core state.
> Having the config live in rxq directly is also ugh.

Having a helper would be a good idea, but I went for stashing
configs in the queue as it's simpler, while dynamic allocations
were of no benefit for this series. Maybe there are some further
plans for it, but as you mentioned, it'd be better to do on top.

> But at this stage we're probably better off if you just respin
> to fix the nits from Paolo and I try to de-lobotimize the driver
> facing API. This is close enough.

Ok

-- 
Pavel Begunkov


