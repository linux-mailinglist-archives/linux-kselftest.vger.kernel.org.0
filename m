Return-Path: <linux-kselftest+bounces-29816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C418A717DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 14:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DB4318866F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 13:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1871EFF9D;
	Wed, 26 Mar 2025 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Uy5uX/V2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3F61EEA59
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Mar 2025 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997260; cv=none; b=JznTGKvxCCUMUDy8oTx1qLQ44RiO8/fGUd9j9OipdO2HR8v73b4yiEeqDBY5hI/PiW6ntNbcRegSsuUaaxDoOKBQkZ9S9o6ckI+JpvOTyU6GotyLyuU7xS9UOr1tUqppCaA9cuc6qqbhJmrqAAb0fhZOZ95Mf92HyRbjvTwDTYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997260; c=relaxed/simple;
	bh=wGfc44ZqUZoqgNrJXPj+HH+XT/DLlF0w6ld1Q/vdVTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VYO3vFoeFgMhSKkxWAJo7/EVZVXeOYBmfbR3fRlCYVK+D6eXASO2TVPmgPa44j/WiXgRdEzfKQAz/schwEEBwJrc+ypPDXMc90d/y+YSDZBlO2Ecav8B61uFIiCLKT+yCc7IbQ4C9PhdykXTDRd0m9enTY15YlaOpHANnx/hfEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Uy5uX/V2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so6252925e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Mar 2025 06:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1742997257; x=1743602057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rsOCFTwn1oMAy5qpk7iWqq6q8BR2NWxS6JSCn3+dsz4=;
        b=Uy5uX/V2wqgtNQ9XHZX0wk+Z14AgPQLQUOqnD+Xt9+6+5NniJFLb5vCnHLMOa3ySh0
         kU8EcbYFQT/0jUGo/HutC5JaynJZFx+5aXrDvaUl52yREmbNCMQ+tbRRc6tAvK76M8F+
         cPo03IuMcU+1CxUuhmTz6CrYrgzj19KSk61BnMS2TjRcJFQfSBAirGKVRJ6YUztE655E
         XAd852rYBPMcaW9RDdkP7jb/h8JR2CkQZ6rSQhxhe9voG4b8tNyXvgeQQRxDn1A8bB/c
         s6F/lZsRYhvbV1g92H1iVQ9vS5fX2SdHGyu821FnN/pFEyfhGAcm+UdFzyXhsiJUeWn0
         lt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742997257; x=1743602057;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsOCFTwn1oMAy5qpk7iWqq6q8BR2NWxS6JSCn3+dsz4=;
        b=X4OjSfAKdopG9VAa4f8TCKIibIOVnacn9hb2+HxnNx9ihUkEcfk4JaM8cjcKmw7MiM
         uBaa4xx7v7y7qpmh8oGD5X7TWAsgro3wLdD2+xP5P1JN/I9xYbvtoqqTe4mIv8lsVTuk
         Wy6hpCl7E3uytGB8qhVszxm0zvJjQo3MI7AGvsHQUfqQcfwtxquK+NDVpCr1xZw2YL6J
         t3tFCSos+oD+aI3zUA5P7byC2ac36rQEhtJk9uV57Z/d6w23D/X0JQuridv0YunLSh+p
         jJZ3TqD4AQNYAAF2cOlq/r6ECkdFFGCRIcsrpgPuMECJr1wBPHB88ofNasDPuMgwKGNs
         q7xA==
X-Forwarded-Encrypted: i=1; AJvYcCXPAvzGB2FqOeej3moj5F5LLHoarp6LP+XatMc0hMmU123qpKjHkwsmdS17r8UiSPmCktR0mP45mVIb+ONuI6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7zqFRKC9YemJDEbH2funHKznnw6wRWvscrtZy7Dc9JfJ/9Ns4
	vPMhJH180jgteSABH5bCJKlnJqfDHNZm4Gx5oYLN6iiU8KlwUhuvKS0OCJAFge5WIsk0eHSOjYi
	VV+ouTrMjfl7/3+UVAlbAEMQDXCTsDUw4JnfPN8NSgBZrBxSokwg0XYe1ajo=
X-Gm-Gg: ASbGncvjiOsd50+0+cQSpf3OYSN35FAFa/UvC4pEHYbEoayhDBItUXMjAJxlKKkXAHg
	v3pRKv8neDd1ulcmwtXrXvwZUfmFYW+GkDv9TEqBo9ceRhvOSLUMmGR/6kafXqnofX7pbXkUHiM
	upzkVcT9aJykhvxuw9jroFskrM71HdeQxPV5erGZEd7DVfDd0Xe25HhyB7x68+7vpuluM6hYiRf
	CDAcMH5K2WTesWZu8ovCx4Sv9q7rGzyTK4qqvccI/WSumfhn+rw9QUJ10QVBrEdiVMHArpqVGXf
	ugNQERjOSmkrn6EIaal4fa/91dKn+9jgqliDrwGlihw5hjpXvhvZuEkao96RczURpKMG3ce9HAR
	XqQ==
X-Google-Smtp-Source: AGHT+IEYaQRli96noTsQSFRkoSF54SEXCAb1IdDBlITNyE7Nhp6mg7wkj4YashD1gdJ3LGD73M7TKQ==
X-Received: by 2002:a05:600c:6b65:b0:43b:4829:8067 with SMTP id 5b1f17b1804b1-43d7755b129mr24733585e9.6.1742997257063;
        Wed, 26 Mar 2025 06:54:17 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:e3b:3856:9645:30d? ([2001:67c:2fbc:1:e3b:3856:9645:30d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f995a10sm16730770f8f.6.2025.03.26.06.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 06:54:16 -0700 (PDT)
Message-ID: <8755fdba-7151-4452-87f7-2407b47c0801@openvpn.net>
Date: Wed, 26 Mar 2025 14:54:15 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v24 09/23] ovpn: implement packet processing
To: Qingfang Deng <dqfext@gmail.com>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, Xiao Liang <shaw.leon@gmail.com>
References: <20250318-b4-ovpn-v24-9-3ec4ab5c4a77@openvpn.net>
 <20250325020802.7632-1-dqfext@gmail.com>
 <58712444-1de7-4076-b850-4c6035792931@openvpn.net>
 <CALW65jZ=Jngf0THLTuWHuhpQb0NDM=4x4HN_Xj922nmq71EMUQ@mail.gmail.com>
 <bdcc035e-24c2-4469-a0fd-f63494d74169@openvpn.net>
 <CALW65jYBtu3Uew9k=aZS9BNdqH6fJ0bqWVFNVeqHJxqSYzjebQ@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <CALW65jYBtu3Uew9k=aZS9BNdqH6fJ0bqWVFNVeqHJxqSYzjebQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/03/2025 13:43, Qingfang Deng wrote:
> On Wed, Mar 26, 2025 at 6:22 PM Antonio Quartulli <antonio@openvpn.net> wrote:
>>>> This is not what we want.
>>>
>>> Got it. You could replace it with
>>> atomic_fetch_add_unless(&pid->seq_num, 1, 0) and check if it wraps
>>> around to zero.
>>
>> What about the first time when seq_num is 0? It will already stop, no?
> 
> The initial value of seq_num is 1.

Ah, you're right. Because atomic_fetch_add_unless() returns the original 
value.

Then I think your whole suggestion makes sense.
I will switch to atomic_t (32bit) and check for the wrap-around.

Cheers,

-- 
Antonio Quartulli
OpenVPN Inc.


