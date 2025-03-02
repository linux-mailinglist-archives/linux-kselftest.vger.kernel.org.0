Return-Path: <linux-kselftest+bounces-27988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F14DA4B4D1
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 22:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788F016ADEE
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 21:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF90D1E9B0B;
	Sun,  2 Mar 2025 21:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Sh5BiYH4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85151BD01F
	for <linux-kselftest@vger.kernel.org>; Sun,  2 Mar 2025 21:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740949250; cv=none; b=ZKDBzo8iMNFN9uU71XYI0RHMbA0oMGjZrKZ+AiWQACb2h7ezi5E4fr1jj7o5gz0VHHRTeSodAXdK1eyBINiXgMXr2z9lHxBreJQs1mOh7Hha5yzwrtHpyOxMBcIEk3/YNgCsoU4ZrHutF30miuR/1sdc9udm5Peu1p/dPGYTKNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740949250; c=relaxed/simple;
	bh=A9r6/gAuXlZda9mTxh9tjwvhwGO2D4It/Pq1azbEFuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4Hfb5+kPwVI20Ew7DNSFmLXxSNSijSczfb83egN3qTUhKwUSXgTF7x4t4zMwyDtTghaGo20KjPMFiE0qQQtBl9TjYxAucGZ3MKBj2gTTsU+q0swuNnb1whOlySrwzZxcmRiEoAcxz91pQ6IxTg9aosb7XVLWLp+YrdC/3Foe4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Sh5BiYH4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bbd711eedso3952765e9.3
        for <linux-kselftest@vger.kernel.org>; Sun, 02 Mar 2025 13:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1740949247; x=1741554047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hAnOp99iT1uPkgpsx2aoc6/2Km+LUZbQgjOhpFnZ3XA=;
        b=Sh5BiYH40RDXR0S3zYi/IABMIXlq7d+w1flZY72X2TrQaOCKVu+porkU/OKNC/8JUL
         JnEae3nxoygQhC3aYJmO93AN7SP5sVfZSpjYA0OIrPbwH2dB9parg01E9pwP9W4UAQpT
         PzM69sBXKNZzb8EF9COIJOs9KsNL3MEg81IUpudsZJkX8+/nGXhfN7o3Gh/TmObYyF/H
         TcInRI4qDQu4bub4EiWi25VEAYr/qRtQKLGkZPPwIOkFSzj/RvmDcoyqTseLx50BQsZE
         iyUvlzugK/4RHVBF/pA/T1U7s5FmyYSIfRAj5Xga/aDQbShH3MI4AwnKqDxOwdqA3z51
         rwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740949247; x=1741554047;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAnOp99iT1uPkgpsx2aoc6/2Km+LUZbQgjOhpFnZ3XA=;
        b=CvJrKtgEGJ6CwuHPDShtMJcdEFFlDj2TpR7+JVlDWBMnngjYQh9uLQwCZ6fGy+14u0
         YjshSE9gLbt8IK7PLr6X4pzD1yMThW6HykrgtAayXkbTZqP0lZGNKKT6747RCI332cJz
         /3jUt5pql5WrPA5vGEsCz8tuAKi/TWQD8RmJLGg8jTn0VSMhFYummKrtiTE+rE4Y/0ya
         v2T1yUnx0dxUfcOpMs+dDWYIuwTBtVp+zgfs4xUvGbx7HWThjfqIUrb4w5nulrjQAXBg
         RDpcHILZui2gU/BFOk6kZ+2yL+6teqfRhbsqxHpJRmplMQ1x2dLBtPRLwfE42qDl9JvZ
         i71g==
X-Forwarded-Encrypted: i=1; AJvYcCWV+UccPegpIo9a43GgtJZvp8jpTAPQPMVyUFi2kuLHR2RVHJaedUWqjurQpIkkmPz5WsRSSVwBiwnNw2OEsao=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGsxJSk6hWrJXua5Vd6L/94gkxdSgQzIOtgDcSEAsqKy1pWyS7
	dxGGIhBc0iXazVDiRZooD33rYiBlQ/JmI50nFD8yqEYnsw2mi9D5BGq84HI+kTY=
X-Gm-Gg: ASbGncswI7+RHq5cBAGnbQKmj46AljzaFdXtiyvuP5I2PG9V6eG5TIKbcvJ5qrxPuoj
	KAHtvGlli6vY7pLr8Y98e/z9mdIL9ofSJUF+KUChyIOkrE/ICSsDCC4qVPOJPSZ6M2tK/VfRfD6
	qEmIQB96KqEaCBsWoPsQNuVO4Hdn5cCB+gaFcPf4J0dx2X3eApw5+7OaQBUYqbkvkrvBLx5bmFP
	bo/js+YHuMrRZq+rRncIoBE4re5ppLsgjuzRqjWkYCnT/eJVieK+dfWAzHGmOJ5PjrdipAE4k3o
	umUIwmsieO62Oz61iLhO/HK/9LltNE3M2G7s019zovDAcCnQb9giyzCUatgkQwOFTTL/2AgCpwG
	n7r+8uao=
X-Google-Smtp-Source: AGHT+IEH4nREHUeVRvdNi33MpgNfNuNmaut6ZGYlTG2Uj9fUuxIDGcP2iF49B8vv3JWDfNMtQ3fGtQ==
X-Received: by 2002:a05:600c:1392:b0:439:6ab6:5d45 with SMTP id 5b1f17b1804b1-43ba6747775mr76635475e9.28.1740949247217;
        Sun, 02 Mar 2025 13:00:47 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:6db2:7b02:2c7e:3704? ([2001:67c:2fbc:1:6db2:7b02:2c7e:3704])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a28bf64sm132801285e9.39.2025.03.02.13.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 13:00:45 -0800 (PST)
Message-ID: <e640386e-46dd-4215-8824-751fc6655ed4@openvpn.net>
Date: Sun, 2 Mar 2025 22:00:43 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 20/25] ovpn: implement peer
 add/get/dump/delete via netlink
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
 <20250227-b4-ovpn-v20-20-93f363310834@openvpn.net> <Z8SiTgEmj2Vr-p-E@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z8SiTgEmj2Vr-p-E@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/03/2025 19:24, Sabrina Dubroca wrote:
> 2025-02-27, 02:21:45 +0100, Antonio Quartulli wrote:
>> @@ -1310,9 +1329,12 @@ void ovpn_peer_keepalive_work(struct work_struct *work)
>>   	if (next_run > 0 && ovpn->registered) {
>>   		netdev_dbg(ovpn->dev,
>>   			   "scheduling keepalive work: now=%llu next_run=%llu delta=%llu\n",
>> -			   next_run, now, next_run - now);
>> +			   next_run, now, next_run - now ?: 0);
> 
> nit: I don't think this "?: 0" does anything

Ouch, I missed the ">= 0".
The idea is that now may have outgrown next_run and in that case we must 
reschedule the worker immediately (while also avoid passing a negative 
number as delay).


Will get this fixed.

Cheers,

> 
>> +		/* due to the waiting above, the next_run deadline may have
>> +		 * passed: in this case we reschedule the worker immediately
>> +		 */
>>   		schedule_delayed_work(&ovpn->keepalive_work,
>> -				      (next_run - now) * HZ);
>> +				      (next_run - now) * HZ ?: 0);
> 
> nit: same here
> 

-- 
Antonio Quartulli
OpenVPN Inc.


