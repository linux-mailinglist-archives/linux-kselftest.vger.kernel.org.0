Return-Path: <linux-kselftest+bounces-22382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0089D448F
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 00:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB751F22000
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 23:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABDB1B5ED2;
	Wed, 20 Nov 2024 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/XvMaE7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14760146593;
	Wed, 20 Nov 2024 23:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732145637; cv=none; b=mDUgHFMTzSvABV2xkcQdmSEHo/wAZbQhv5d4i7ppoeu/bdMEZio7r1NjC0V6LrlxB1oE9dNgv87O8cIQ15XsxfMPwhj0T3X/yx+tR3qkDNyY90hXEryfY00XI4/HwYgrOMpVR/IwH+c5koEY8DgmcrZEgFKHqST0wJYDHE833mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732145637; c=relaxed/simple;
	bh=6J7xR11ORo3RIfap9ywU3d0t+DfN7EdMpAulAvdmJCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ncyGs8YTrB3m49S8wh4ITxJkQnsU5QK/BTpzV/jEpWyK+Z3Lx4ert10n+BX2roU8wtr/HEBryXx2DskQTWq44VMten7MzjKN54utuRBy6YesuASZXfWnM1QUAjSK1uHrn0bKt+x44UBpAug/qhnTdMDFYgIe3wxNKzHlmFieWxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/XvMaE7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43163667f0eso2307245e9.0;
        Wed, 20 Nov 2024 15:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732145634; x=1732750434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KA1UH+wyjBnkz15ZnSLPILDTGoXb7OXqR690RmvAP8E=;
        b=D/XvMaE7zx3sl6V+tNdu8GarjQOzDmgK8NE2yAYCpbDv6+egcaW7MZjfSOfmQnskSg
         UywOxGSZNLIcihI2alQWpf0lhn+jrRUayPg4BwhOqXaap6ovnbb8bek+jdZAX93OxSVL
         uW4hVRUHhNucE8KSbJ8OvJdJ8Ul9wUFpHos9t5T6FXIz5vBRRRp9e4bUUelPmy5upCA9
         nXRzCkyJrtbPqrXR4lrSjuxkqddKFcFBEVxIOZKVrjkA6bVuWxnHa3yZj0Bzx10lJq9T
         HWwnBQc1yPCOJk6jtmf2qHcZhwBeMC3cClDGVHDtPc8C7zIQMrrTdZf4/9/zVw4oe1uW
         aYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732145634; x=1732750434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KA1UH+wyjBnkz15ZnSLPILDTGoXb7OXqR690RmvAP8E=;
        b=utne24VMLPZEc1GSF5vC0NNC40y+PJD/6mrYHP3KREAsAfMbRO1oi0n8z+c4nXwm6B
         tYv6BOmfOAdJYA6ZnGzjf/OVSOHGbTWZky0GVxmb64YJ2bOe0vSCppRZ/7s4yRzB3UEu
         JUwNKFSaV3L6r/uL5s7fpKGK1487y3nEOX3eRihhTAuQ5PVFIEQ+5xir53JboasopehY
         Yf5LXlnpq7GFpeI4CdCjamJEbVAL99gzq4zNmti+TXUXo0BVC1Q6P4aSdH9reSckIM7l
         LLoFsTI9wlvbHsNiWsjCugINuot50IvAQAoSsElas+DBskgAooVa/SpEy86ZOYFDlV+D
         Wf4w==
X-Forwarded-Encrypted: i=1; AJvYcCV0OSjtS/qoEhtMsdV7durFL5XTEJIEtNPeJq4qJa1TuySZcUD1TWho4h7PQzbxgP8RFfsEBcn++UqQaoPbmCPA@vger.kernel.org, AJvYcCVXMP5gLx+xZ+WBlqA7LzUeRPT7ZgRyNClxoI8hNDAWRs2zjqZ6OVLofsdhY/rGCvOWohF4+hc9@vger.kernel.org, AJvYcCWwu6mBg5mtOjIcF0bnKWX2pMmOHqEzj7x5ObGO3N/1v/6D/ANdD4ZxgBWB4fYAQ+ldce+jebL0VA704d8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+TDPPShyyIcZCWtWU0WiFMXUHb0jn13K7rMkxETYrdLIVBBow
	ZUjEwJM1nVooZl/r6U+WTc/uazcrzTwjIUS4EKJcfEeIKf+iY9oD
X-Google-Smtp-Source: AGHT+IE+SQIsEimpHXJsKKmHX3ZxLKNCRpYFvsqLzYug5ritHNDbcVB7wT5lLQWpGSN3e76BizHlYg==
X-Received: by 2002:a5d:5f8f:0:b0:381:f5c2:97c9 with SMTP id ffacd0b85a97d-38254af996emr3437272f8f.25.1732145634043;
        Wed, 20 Nov 2024 15:33:54 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825a6bbe80sm476375f8f.35.2024.11.20.15.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 15:33:52 -0800 (PST)
Message-ID: <68214df3-23b6-4da4-9ad9-b10e8878a4da@gmail.com>
Date: Thu, 21 Nov 2024 01:34:27 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 07/23] ovpn: introduce the ovpn_socket object
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-7-de4698c73a25@openvpn.net>
 <62d382f8-ea45-4157-b54b-8fed7bdafcca@gmail.com>
 <1dffb833-1688-4572-bbf8-c6524cd84402@openvpn.net>
 <b8612694-c5b7-4b62-8b9d-783aaec1439f@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <b8612694-c5b7-4b62-8b9d-783aaec1439f@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19.11.2024 15:44, Antonio Quartulli wrote:
> On 15/11/2024 15:28, Antonio Quartulli wrote:
> [...]
>>>> +}
>>>> +
>>>> +static struct ovpn_socket *ovpn_socket_get(struct socket *sock)
>>>> +{
>>>> +    struct ovpn_socket *ovpn_sock;
>>>> +
>>>> +    rcu_read_lock();
>>>> +    ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
>>>> +    if (!ovpn_socket_hold(ovpn_sock)) {
>>>> +        pr_warn("%s: found ovpn_socket with ref = 0\n", __func__);
>>>
>>> Should we be more specific here and print warning with 
>>> netdev_warn(ovpn_sock->ovpn->dev, ...)?
>>
>> ACK must be an unnoticed leftover
> 
> I take this back.
> If refcounter is zero, I'd avoid accessing any field of the ovpn_sock 
> object, thus the pr_warn() without any reference to the device.

If it's such unlikely scenario, then should it be:

if (WARN_ON(!ovpn_socket_hold(ovpn_sock)))
     ovpn_sock = NULL;

?

--
Sergey

