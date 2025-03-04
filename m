Return-Path: <linux-kselftest+bounces-28208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 610C5A4E0D7
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 15:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A7A1886B13
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 14:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82D3207DF5;
	Tue,  4 Mar 2025 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/F4X3nK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A521207DFE
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098233; cv=none; b=CnzRW66pWDu7PY2exHOi9AQ4obfEXM1fVlDTqP/nyCJDT3qJMiiWvcqh1ntzldqzFZXVOwcWfD77You72iP1wExoprAUGbg/lJYCI8iuSVmGGb/UAMhoDxakkxt+0l6WSuiObPFoWNm0jq8USAgZqCG+gdmVu7unGnkHhMQSPsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098233; c=relaxed/simple;
	bh=YToWRXI3ojp5Qpx1iSipk79vN6Czw/zLodfp8xVJwD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5swB8ptsjUC59z7hmoFb4hX7Fnh1vdnfO6fyrfTeIAfU/r2ZLvFHRYC25I+MI9g6XKx/gIdAZ+cb4k1i9oaEs8PDrQewURB7C7WYaCdSxx2M1fuRaQUYBEgL8ZIqVxTt+psr2PE8qE2ibR5KvmjFZCfFGaVWJWCqiPlGWllW3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/F4X3nK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741098231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u7Jl6RqLE4ySPh0n2/0y55XdmikJ9fMRlsEGtfokKwE=;
	b=R/F4X3nKxSTc6yn+bqiWphxOxnEX+x3EWKW8KGn0MbLgawwdPFsrznEmlSuOPYp2j+bTep
	LckdS7gZthucQgubM7s6wneMObgL6dA8lFUvxb9/O5jnNBqs+1/cETOxGpB9yy9hCFBJz1
	OqNzB6A2nDpeenXTLoQC7R8Wcalmyro=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-bLvE56SmO6e-GxioBtzW7Q-1; Tue, 04 Mar 2025 09:23:44 -0500
X-MC-Unique: bLvE56SmO6e-GxioBtzW7Q-1
X-Mimecast-MFC-AGG-ID: bLvE56SmO6e-GxioBtzW7Q_1741098224
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4388eee7073so29069135e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Mar 2025 06:23:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741098223; x=1741703023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7Jl6RqLE4ySPh0n2/0y55XdmikJ9fMRlsEGtfokKwE=;
        b=XDQYoCKwWIczOd7ePHwJI9vsQSU34qCGjgGLUaqrMNWColzNkD3dr24t4TMc2884zZ
         B3F5xCXjU+BJwzIItDDtaiq7wIu1/yuSCJnqHSvf2mvuo/mRvfW88aHJPdHEYYkZsoLw
         Y2PZsNCOEAA8rGv4tV36oi4lnCr4FF2PjA2aUpMgCgakkVj1lxLWvwuZGS7uZ+LPzqHW
         AWjplNDw1Sq/8RKgdouePc+ORL72hHDiXJ/cAncPoC99apm8FCy9bN5kvCywCn67Ve3n
         O0PTxGL8XYTSuCUDVYjuRrRAzLtdYV6cfgEHGUV73+aw6X19jKA0AKZerwVvWj2aeXrb
         SO3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTJZo8uQIOwgSMbntrhPKNLGAPuNCUc5hBqlB91dMIDHkBquPR2wLp0gb9x2uN/Cz/zgyQfQOwGx91qv5muAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YySH8nd5gVLigfWdD3qePTa9N7B8NqUyeP/UiktMJvHup2bYm1J
	nYBrU5e2WGw2/mGn7S9qLeCfLpcS0AgwUYOBKG54RxX/u+wmdv3bfSRH/Qw0Aj2Na8pmPrVBrx6
	bUmnDKt9haFpAImHmjPG4aLrxo3GoFDuOZAXpxdXCydCHU1z39q1V2Nv/9JzKu9wOaw==
X-Gm-Gg: ASbGnct+id+dtsg3HVKLQLDYEymOqD0mXDOI55iKc646cY8nhrKr9pjdMLL0vXWph9J
	rmHhUjlo6iOMs8dkYVxXBxv7QMJh2+uNDG6ItV9bjFSIKzLCCO5DQzF6+0B+YTl1GxEnV0EoNDE
	FoQQJ18HN7IMYN2LqKcOPzvBZ242RBMJsU2CmrtccBkYnEEgrvHp4hg914r3vjZCS7GQEmOid5d
	TodoPOLLnVgFqD5WxmO5ngpS9cUYo97WN9nv8iCkrtqgO/RKRWs5Ym2qCr4fENgG0ypaa43vwdn
	BVLS54rCvXjbZHSiNSF6jcKSZuSFA7CWoScofnuGL6SErg==
X-Received: by 2002:a05:600c:4793:b0:43b:baf7:76e4 with SMTP id 5b1f17b1804b1-43bcae04e19mr29901225e9.1.1741098223609;
        Tue, 04 Mar 2025 06:23:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF52Rx16VjlDS72aosnmdGbcCI7vGQKO/XsIiTckVodJ9P2N/4wxflyj/DJe6Sib08YfVkUAQ==
X-Received: by 2002:a05:600c:4793:b0:43b:baf7:76e4 with SMTP id 5b1f17b1804b1-43bcae04e19mr29900945e9.1.1741098223266;
        Tue, 04 Mar 2025 06:23:43 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b736f75ebsm199915175e9.3.2025.03.04.06.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 06:23:42 -0800 (PST)
Message-ID: <278118b1-eae8-401a-8501-e0a777852fcf@redhat.com>
Date: Tue, 4 Mar 2025 15:23:40 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/7] netconsole: add task name to extra data
 fields
To: Breno Leitao <leitao@debian.org>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@meta.com
References: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
 <20250221-netcons_current-v1-5-21c86ae8fc0d@debian.org>
 <20250225101910.GM1615191@kernel.org>
 <20250225-doberman-of-scientific-champagne-640c69@leitao>
 <d0e43d0a-621d-46ee-8cb7-1e5c41e76b8c@redhat.com>
 <20250225-bright-jasmine-butterfly-aa1bb0@leitao>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250225-bright-jasmine-butterfly-aa1bb0@leitao>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/25 2:11 PM, Breno Leitao wrote:
> Ack. I will remove the check then, and check if the UDP stack has been
> initialized before calling netpoll helpers.
> 
> What is the best way to make sure taht the UDP stack has been
> initialized?

[brosers!] Sorry for the latency. My statement was intended as a
negative example: "adding such check would be as misleading as checking
if the UDP stack has been before calling netpoll helpers". The UDP stack
is always initialized when called from netpoll, due to the relevant
"init" order.

/P


