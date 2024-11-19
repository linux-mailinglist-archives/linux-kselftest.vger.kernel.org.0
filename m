Return-Path: <linux-kselftest+bounces-22220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E199D1DEE
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 03:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2B72827D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 02:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B33045945;
	Tue, 19 Nov 2024 02:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkgnZ6Yv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958B21A28C;
	Tue, 19 Nov 2024 02:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731981873; cv=none; b=t4jtOmxYjocH1sVBZSEW+X+S1eRU2FOAbE2uPuvhO6xX14H0y7T3xfdSLe1fYpv7wCr27zaRLNjqyQDnfgDgxuJZZClh+rDdb3C9heMONH7UWBxd15TYSwV74GUqQ2pSLZ0eesnG6nDkiJkw8QrAG6ygjO/K85P4tjTQj7EnVTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731981873; c=relaxed/simple;
	bh=UQH1BSKJe3E66Jk5s6fPIXMnloiruHizUGZqykgnTnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XuFbWht9EMkYfrio1C98vFctQan55PfgzUdszBysqaDg2e8A38BvhsqghtIUkSiIQrDC8ti1FtAR/EaL8Agr/zhivNtoU/SaIOZPKYH/iluNGDONO30UcJ57HtH9Srk6j8zACtobXP60DQ3JgOL43dPFswuau7Ikobu423SiIRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkgnZ6Yv; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3823e45339bso316735f8f.0;
        Mon, 18 Nov 2024 18:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731981870; x=1732586670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kS731Cc8cwgS3n3RbsMJ2pdKcw5RrIc47mJBIulrqEo=;
        b=SkgnZ6Yv9fvR56lfLaLTZQ1iPeUUERvg/5lUiKDUFUK/EcPZG5VcUZj+13CG5n2zTy
         XLQK3l+kEWOGniDDrB4JOoiqCm0mQnNrMbALoDjWB8DSif1kTm9BipJ/RSxnEPOuVK8D
         Ms4B0g5S81DvzjjFSOOCrYfdRQf1z8Rv8/VrzDUWeA7syQfCWDBh1PnO8rN3SbKZEwlG
         +YBz3cLMXVC2JXB4XIZpz3ObeMNg8bkC/MoQ5HEYjeQzGjzLfBfLZElfVAn4LTq00A+Z
         3fkCzHUTBsclXVcbaKQogqy68ewECzlZeKFciNssSIgXU8OqSiV6PTg7YTXz4Yh8D0KE
         0+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731981870; x=1732586670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kS731Cc8cwgS3n3RbsMJ2pdKcw5RrIc47mJBIulrqEo=;
        b=JDZ7k/DbZnIJQ6H7XCy9HjU0AyWV2REk0T/qFO7wbawvrIV9uVCu/MruiTLTxlY4RC
         jfF4+GpTCpIWgoka8mdcWLaCiNGye8vc5YjGPNzuCPKkC0v6fehua+XAXyv5xfYK9fCg
         9MoSSc5DjsEB/l4NntLWWzsrDpkk9ClpjwMx5iGtvbYH9qyyFna+QZLkWeJHOBH4tR+O
         HDougzqVcA8QuDwToNgTDCSMvh0KF4TN8m1ZZWQdiY2SKDZKuAeqvb3fAuCrR4zHRgjD
         LP31xgFIOQe04WII2G1M0sfHepRXu8chIRFfhtKLiCjmNQq98228IMjxCHcuqORUx6ph
         hjmw==
X-Forwarded-Encrypted: i=1; AJvYcCVqHbz6YwzO2/7PLVk3c4f0WCmDUEQlFaNVHUrhFTZiAheOPH44LV/Igzx4mfGSmPUwK7E11trDoCt6u70=@vger.kernel.org, AJvYcCXDH9J26850HcInhBk4u8DvteNViYZIHcWD+a2NSNdCaORLd5TXlddQvpn/BlSksr4E1t0Qx654u/3pZErv8F/4@vger.kernel.org, AJvYcCXgOZ0TtIn2pPyrWah55PnRhKTW8jGA4tognSaeRSY+vNA9otQtOzsF3CkWChEAwyRML4m/8u3u@vger.kernel.org
X-Gm-Message-State: AOJu0YxLSZV6CRjUynBWwHAOjgZq8CWvg1Or8RxtyygIFbMtk69yPyvr
	UUwmaIJl45SF3OaFORQtBuaneJnn4pliBF7K7PVbpYySWmM9FF9i
X-Google-Smtp-Source: AGHT+IH/NKWP/Hhmyr1Gnn5yCx+ZBzDkcE7R4dlm+G79wi9Re06jyg9WZcCAU7P7C4rZZSpUfjajgQ==
X-Received: by 2002:a05:6000:1f81:b0:37d:4956:b0c2 with SMTP id ffacd0b85a97d-38225aa661cmr9342648f8f.58.1731981869725;
        Mon, 18 Nov 2024 18:04:29 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382491e19bdsm3995422f8f.16.2024.11.18.18.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 18:04:28 -0800 (PST)
Message-ID: <a125f933-b985-441e-9fac-49002bc5933a@gmail.com>
Date: Tue, 19 Nov 2024 04:05:01 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 03/23] ovpn: add basic netlink support
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-3-de4698c73a25@openvpn.net>
 <52a2f654-29e5-4567-b5f8-8362fa55c1e1@gmail.com>
 <a8f3a9ca-698d-4b4e-ab4b-7d8aa651dddc@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <a8f3a9ca-698d-4b4e-ab4b-7d8aa651dddc@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.11.2024 12:05, Antonio Quartulli wrote:
> On 09/11/2024 00:15, Sergey Ryazanov wrote:
>> On 29.10.2024 12:47, Antonio Quartulli wrote:
>>> @@ -37,7 +41,7 @@ static int ovpn_newlink(struct net *src_net, struct 
>>> net_device *dev,
>>>   }
>>>   static struct rtnl_link_ops ovpn_link_ops = {
>>> -    .kind = "ovpn",
>>> +    .kind = OVPN_FAMILY_NAME,
>>
>> nit: are you sure that the link kind is the same as the GENL family? I 
>> mean, they are both deriviated from the protocol name that is common 
>> for both entities, but is it making RTNL kind a derivative of GENL 
>> family?
> 
> I just want to use the same name everywhere and I thought it doesn't 
> make sense to create a separate define (they can be decoupled later 
> should see any need for that).
> But I can add:
> 
> #define OVPN_RTNL_LINK_KIND OVPN_FAMILY_NAME
> 
> to make this relationship explicit?

Can we just leave it as literal? This string is going to be a part of 
ABI and there will be no chance to change it in the future. So, what the 
purpose to define it using a macro if it's self-descriptive?

People also like to define a macro with a generic name like DRV_NAME and 
use it everywhere. What also looks reasonable.

--
Sergey

