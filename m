Return-Path: <linux-kselftest+bounces-49364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC20D3AAD3
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 14:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E6350300A9BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 13:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E2C36E46E;
	Mon, 19 Jan 2026 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYiIrJRs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB1236D512
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768830881; cv=none; b=JyJEoWYtaS3JBop43nDIrrFBsm+tiLM/Ux7SEhKgtG6U6N0EYPTj9Tn74lx6O51EaDc0PnoGkppB6x7SV8ArMv/EHaJ0UNBhFxmDVnAY7Eew1S8K9mLv7bS4jS1RSDL+YJ+Nt7UvBYotsiQrAnnXdFpuVcKlbh596o2DHdXHvjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768830881; c=relaxed/simple;
	bh=lo81BFx/Ulv0xcaPTgRdmV6KO1F84bHVc1SQVycS4S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B8TJ/9s6BX/uyKGq4jOvEPoxeut9Lgiy2ljUEDbaz6VBAuJfAYH97E4LhhgFrX4ixnLyKXozkGm4Xb4OvF9gB1IFCyiIgtn5JDcBM28f5tJqog0Oe3JhDfRCLSBD8r8z7tikvJ3MmktW1oXDFCKul3wehDTIDUr0Ey6C5Yfgn74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYiIrJRs; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fbc544b09so2859800f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 05:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768830878; x=1769435678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MPy6cjzmHwuoEQvvRHEOfQ3zwGp51DN3ulInpeNRzkQ=;
        b=OYiIrJRseciC2w1wnZYx/HQx+/0wX9AA+uU2X5/x12E/i8fcD9BBGk2WIj8Vzl3nQ2
         heoHllWVgyETGz3o9UJgZUj2iw1g5A5wmNYoC6B6US3c9/XQGop6MP/TI4iL4MetxhRY
         Kgm5v0Ns51mj3FsZElRH0eS5inpYEalQgzOnzZJg34NDzxt6sEx55JnBLY9QqwL0TAZM
         yKR9AQMFWpTfpCIbn+BPlWKV+6IlkWqzjZnim0bEJWKxZhSFiE9zCJqz4FO0cu+JXDSh
         KRlwuTmdMrX0dyEWK65U+OJAyPp+Pq2QXSV3yn85P+XNHgTTnyyXX46U0HrzUcZZQLQD
         EG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768830878; x=1769435678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPy6cjzmHwuoEQvvRHEOfQ3zwGp51DN3ulInpeNRzkQ=;
        b=s2HkFD1SKViHRjAyjUqN6XL6oxr63+40aOA28SnGt6xRQn2JKg1Y0dC7l86d7GVvQd
         7ghpOdcRe3317iyEGSLhY8TTf5icMRXf8kFoiKjR2uR+JcJ1a3SMQK4lJFCyj4UrDPbQ
         dFzkXi7VAC5QzGBhoDlA6AsKxrqPkokNBmwdHGL+HFESZuSr3js8JSB3/7iFp4BY/g8x
         QFl06JoOeo9phc2XTN8THKqxBrqeozbwDNFeh85Ar5w5WA2qGp+tHMp2T2WFwke0q3oT
         WfrktvNhBJBsrUot79dIzK0BcBODctlMoz/0uf0vvDPjO0i0sYpSvXNDDhjlvBdsuqlL
         JHrw==
X-Forwarded-Encrypted: i=1; AJvYcCXS1g9sTt92HfKp2nxAwjef9fUGmgv63sAs7CRl2a2oybIYaI95/zKOufVh5AVQF1XBOkqpRJy/REq70VsuNHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5I7LJL4d8sbC6bW+twUbA0sBczkmpfHdHR6SZX6N3eEyDQ6ly
	5e//WBAXCuEXanHQhhG5I2inVlnUTP7uXexFjhxTNIgJBlBzd2uGSsEo
X-Gm-Gg: AZuq6aJH0wvioDfGtCtbnhvQo66IAfBQdRQ2LOt8rnadNMPcRTV4atXJfkF3nE0xLWq
	A/tmpygAZGEn6LFn3zv0t/SN1+J3UJmRWr+QVSC25bo42vZytAHQV9d2C7oFStv0WxczOOJpU60
	jDqTxyfznhbaWJDMCknQymePSsBECrzUZl5mEu7mmElvWGBCydoyw1SZpvb+5GE0X23PQhuMWQl
	c7s6a7MQFU85LvYy070M+0f/cCps3e25xkf7fNNDdgTY60xhh+3JQ+QrLUirUlox19aM5qB7O0o
	hQKOCbwElMpiD1YmWZxL3RdS7L7iLYLxOZripf4WrBAh83fcWpE5cDa0VjvW465m5iiMYe9KNhj
	CfM+7qKK2JJUboP+f6vhs6hBujne70MWuIb2EfWYZbengQYrPngqCnpznxebgAAKEPwI1w3P228
	pnN2Os8EnxfnicnyCX2D4IbUfX6HZWY6qSvFH1cAKJ4X/WpiWzF2wEE1x62iYKaQrrCaIYIuZJD
	x1if+TeN/f9VX9rHCjY0HNPSiF5SbclaHec7gB2jj/0184dgwuQmxI3Nd8Hw6zg
X-Received: by 2002:a05:6000:3110:b0:431:48f:f78f with SMTP id ffacd0b85a97d-4356996f2f0mr12962136f8f.1.1768830877534;
        Mon, 19 Jan 2026 05:54:37 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921f6esm22810483f8f.4.2026.01.19.05.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 05:54:36 -0800 (PST)
Message-ID: <7ab5309d-8654-4fa8-9a1e-24b948bccba2@gmail.com>
Date: Mon, 19 Jan 2026 13:54:37 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 0/9] Add support for providers with large rx
 buffer
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Michael Chan <michael.chan@broadcom.com>,
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
 Samiullah Khawaja <skhawaja@google.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, David Wei
 <dw@davidwei.uk>, Yue Haibing <yuehaibing@huawei.com>,
 Haiyue Wang <haiyuewa@163.com>, Jens Axboe <axboe@kernel.dk>,
 Simon Horman <horms@kernel.org>, Vishwanath Seshagiri <vishs@fb.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, dtatulea@nvidia.com, kernel-team@meta.com,
 io-uring@vger.kernel.org
References: <cover.1768493907.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <cover.1768493907.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/26 17:11, Pavel Begunkov wrote:
> Note: it's net/ only bits and doesn't include changes, which shoulf be
> merged separately and are posted separately. The full branch for
> convenience is at [1], and the patch is here:

Looks like patchwork says the patches don't apply, but the branch
still merges well. Alternatively, I can rebase on top of net-next
and likely delay the final io_uring commit to one release after.

-- 
Pavel Begunkov


