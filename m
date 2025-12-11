Return-Path: <linux-kselftest+bounces-47374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6958FCB46C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 02:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63043301E589
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 01:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E41B2D97AC;
	Thu, 11 Dec 2025 01:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeYXdFQK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B896618FC80
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 01:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765416675; cv=none; b=IlwRudgKWIJ00HKZAbyIwepRCxFAlYAsds4ur9k9wUm7VWtOoKKhREtr9G7dHZ/N9wMYipr2hUGKk4kVAR9hMOQwXffxqci7Rj2gEVoTopej0ONPe/9m922j85cYVOwS7KPzrXEbJSjlRg7FLHud3GaffCmt8proX/YbTDoPuOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765416675; c=relaxed/simple;
	bh=WTGcFCS6w7nlAaqkBZ3n6Gv7wFcX8BfAhcm/JFIe5Lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbNO2UGTrmlk0YU7nikYmuD7QZEN5kXDk9v1ZM8QXBD2VB9VuV+5gb6BvJiEWNBeaIkbimry9Ig2CfEAGJ8YqxyPFWjT0Yxpwjyn+MeJ/n754n/uOMICURmki0pKeZyhKOS6ZwkrQhS6oJiQhjbJJXIJo6I0ESOlJ4Q+Z4y9sO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeYXdFQK; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso653113b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Dec 2025 17:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765416673; x=1766021473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fZdCO/Mv9RBE0LHZ0bjkyPo+ciEfdxSfUwGGq9Yh/c0=;
        b=IeYXdFQKWk7t+QfhJqDOEqv0XEjreRqj+MI3d6Je3A12CgF4LpScw8LH8F1RG7zmUO
         JDm06TPyDoqBHiKEZoh9TGOFeAvZ9dpQC46DDNtSEY5VqcktDvLdTtZ9dFj+UNW7Js2F
         TnM61m83TBAWje3XUfVC2rABiD1Zp53TavlIFhJwson7M0/WEnLdqFBcCXpjCBNos6RA
         tsO483vypG3w1MhDgmKNYdMsnFQAbonE3ibAxD0NwV8VoSnLVZ5C9Jang1AuMhNA92r9
         2npaDjbBCEYe1fdrTg4bS5OYlCJhPTy+CoKQpuedqBpFCo5pGA94jJoXUjwUoVfoWxe+
         Zqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765416673; x=1766021473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZdCO/Mv9RBE0LHZ0bjkyPo+ciEfdxSfUwGGq9Yh/c0=;
        b=J97AP532rk9vzOmrtnoDT4McfP+5+dE1NnTIZ8cbFV8Vx5A+xn+JZuk7SVdmiOz2DQ
         VXPYZKsujXl//2MJohUNs6G+srAxkdFxsX9gQ78tuP6RNby84h7cYlRqqmuqZEpqWpA7
         L4n9KGNinNd1I+opfi5O9N2ZMapXjZXIjGAFbwtNiH3+A0DMSUV+Ln17Do0t19nX5Y2O
         WicuoGW4nJGyZBIvv0JeOAurgJJREKpIdgWXpbtFHAhgrUn5Gp9dSMB6l8rckk9lYIJZ
         BefmxAYvjhppC+E/wa2elj5zVseX5vR69FgYxEz/MVqcg0KsEYDAnYtc4MiILcBp0f+6
         8AVg==
X-Forwarded-Encrypted: i=1; AJvYcCWfCPFr8DDRWNXOSREEDEG5iBcVv9/YxwoissuQ+cK3hGz3YN6caGquRUy4ByWDDs4G84+cLB9VAJzY0pPtV9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjGXv4zKTjyiawbEbJQs6UBJeNJlLbIQBxrzRD236p//PYicrx
	FWR9Hjj3JRogLG8rzBj9l7FvWJ85Yc4gHeJtN8RTTC3M4CbAKA05lWBI
X-Gm-Gg: ASbGncuil7LNVSKIuZepNMbPaPOFaLHR3ng7AJbCQ5OyaCz4Pj2391T2XIcAPLtM4ZB
	+qoC0jv0BoHKfd7ppI57Kp7rMSjBNkMH4xEnCPNVt/ClF6iq5FvupEEYq9QhCFBv5XYD3WRsu18
	AwvVsCYZsklkswEF8vFwb0ZilGCCASigBluRaMHmaBrKdrOJXIk3Aq1IdK9NvY574dQYg42XL9h
	0QavtURsJadP4TIUTF/iKNdNsuuYoBUoAbTnfXhAXmV7/l377L57ogpzeKcH89KF0Fbip29/BMH
	3xC4w1Jy+rgR9mEg2TT2M72Zf2NI17jrvo/Vr3w8lEydpVdeFVE3CBmjGmjX/L/wv0JN0JlK3uz
	wd7Zb3yBCv96LmEp+ZFahOc2iehX8ed/XfN3P/iDzcDNwL26QFRWRBZryvjOwVZKD9O8b7b9W5P
	+KRUr/83SAm/TzM1D12vqXO50xtV75GLBwjkggGe3S/yQv23tjNYzOc6Wt6QlZCxlfQIfQoRUVN
	EOUfSB79xiG3xBbszVGD3MstgKpsBI6yzjkvhDrpD8UTCy612LuHDfnPJI6UQ==
X-Google-Smtp-Source: AGHT+IGVt+ykzKwUkvlI66EhGPLEJT0k2WcMqC7wbWNtFp2WzvnzQClEU8G0uA4bJZHHBv9Er2SFdw==
X-Received: by 2002:a05:6a20:3d25:b0:366:14b0:1a37 with SMTP id adf61e73a8af0-366e33be8e5mr4459913637.69.1765416673027;
        Wed, 10 Dec 2025 17:31:13 -0800 (PST)
Received: from [10.200.8.97] (fs98a57d9d.tkyc007.ap.nuro.jp. [152.165.125.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2bfa0845sm618391a12.28.2025.12.10.17.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 17:31:12 -0800 (PST)
Message-ID: <878759ec-f630-4961-a17f-6355df26507f@gmail.com>
Date: Thu, 11 Dec 2025 01:31:09 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 4/9] net: let pp memory provider to specify rx
 buf len
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan
 <shuah@kernel.org>, Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Yue Haibing <yuehaibing@huawei.com>,
 David Wei <dw@davidwei.uk>, Haiyue Wang <haiyuewa@163.com>,
 Jens Axboe <axboe@kernel.dk>, Joe Damato <jdamato@fastly.com>,
 Simon Horman <horms@kernel.org>, Vishwanath Seshagiri <vishs@fb.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 io-uring@vger.kernel.org, dtatulea@nvidia.com
References: <cover.1764542851.git.asml.silence@gmail.com>
 <0364ec97cc65b7b7b7376b98438c2630fa2e003c.1764542851.git.asml.silence@gmail.com>
 <20251202110431.376dc793@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251202110431.376dc793@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/2/25 19:04, Jakub Kicinski wrote:
> On Sun, 30 Nov 2025 23:35:19 +0000 Pavel Begunkov wrote:
>> +enum {
>> +	/* queue restart support custom rx buffer sizes */
>> +	NDO_QUEUE_RX_BUF_SIZE		= 0x1,
> 
> If you have to respin -- let's drop the NDO from this define.
> To suggest something specific - QCFG_ is a better prefix?
> IDK why we ended up with ndo_ prefix on the queue ops..

QCFG_ sounds better indeed

> Also RX_PAGE_SIZE is a better name for the fields? RX_BUF_SIZE
> is easy to confuse with RX_BUF_LEN which we are no longer trying
> to modify.

It's not "page" because there are no struct page's, and those are
just buffers. Maybe it's also some net/driver specific term?
I don't get the difference here b/w "size" and "len" either, but
in any case I don't really have any real opinion about the name,
and it can always be changed later.

-- 
Pavel Begunkov


