Return-Path: <linux-kselftest+bounces-25930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45942A2AB5E
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 15:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB57916A2FA
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 14:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655C61EDA17;
	Thu,  6 Feb 2025 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvampsoS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD03C1EDA18
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Feb 2025 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852150; cv=none; b=mCl/FPyAnHglPX/EKox66Uo90lof3I9yEgg762aTqVSfOWLCGJ7z/FoM37imAvQuC7qdmevSpkaLdnnxr8lmuA6VwbAwAq6eAsVxqHd+EfZsZqMEDQrxLMbb2nkjvlGdLaXYncnpPmThM0TvQxQOjE9DOV2RccU/dyySCHGrMTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852150; c=relaxed/simple;
	bh=Y/9TL5ICETEExIkNfaa1Q8SGkOy65DRMnd4GpUkgGHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rNqh33u70NOSmp8ab12cziH/jr+LqTxoBZCT04qC3Lr2gp/iF80RDYflkcqtu7LjeY8nt/Jcl62mr9ZRcyXK2M/s78PMTIct3/8N0hXprdVe4SnHxX/G5lnQdoRYr25CuJ07N7ykG5Czwkqx60F2UInpVSbjiFwfpRr1/NTh2ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvampsoS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738852147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/9TL5ICETEExIkNfaa1Q8SGkOy65DRMnd4GpUkgGHY=;
	b=fvampsoSNyLZCFNNt+aOHE4E9Rm87l8/INTEuxC3MJ49imnL2V2eFn89VUjZX/w65Cb1d6
	lwaFvoPiPkRtDVbcMiWzkqNDYXvk5mh63LJC+1P9yoksziP7Ox1h9z//85i7nOT9vIaDYE
	URT36rp92HV4bQcsCvlKLPxDJyghd/w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-BpcEcqGiOlWEl6o8fMhbEw-1; Thu, 06 Feb 2025 09:29:06 -0500
X-MC-Unique: BpcEcqGiOlWEl6o8fMhbEw-1
X-Mimecast-MFC-AGG-ID: BpcEcqGiOlWEl6o8fMhbEw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4361ecebc5bso5593985e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Feb 2025 06:29:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738852145; x=1739456945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/9TL5ICETEExIkNfaa1Q8SGkOy65DRMnd4GpUkgGHY=;
        b=G0yuNqzX8GUqr3uSiW7WtQqZy/9YNfeaboqkYQuCVhNVMiPTlcwxoPRyT5bzqCsIwt
         W8nCxOleaycJ03iILoi6TK9HRoDwUUgel4d7ST+OtyJx01rlEGtOVwLUibV6QabWWw09
         0e+Tvi36OrgaQu4fjMz9c3Q5bwWG8npZAUdYVv8WowsBdsetTLm2IfMD0OcC5SFLX3Mb
         DeZJNsfZ+5Jlw2TJEWzPre21DHIxaC1C9ppx+q/GWHW0e9Nb3pUFTU86MgmvGOO2cUPi
         cYmIavrQYn1nhqjcrSH2kTGs89L1om0muTMILCsOMZ1buCVwT/lck3UWazkd5JPIW5yG
         EqTA==
X-Forwarded-Encrypted: i=1; AJvYcCWZgKPHw2NFfpBn0HrlmclSxA36WRjI1MozRZyJ577445D8cHiHgC7kWxunW53aZrS6mw2Bp5uw6EI8g3sLglI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFLYv870gTFMUu489kfoB5riit7bTABHp2QWvCRoNu89uU+NSf
	ur1EO9LIH+No7tO6+9FdPtFXgnsIEaHSlSBpqXZZsdwPabZ5E5MN1qEZjeFi26oWi1T7bpWUNrF
	xg1P3RSh688vR8rBgYFrKQNU+luqZEoDyrK24Cy3yBU07kQhFFYmHMZLBB2hTozLlfQ==
X-Gm-Gg: ASbGncuNmZZQqFaakNG9GBmaH9ytVsh2JR95yLrepsjwpOdUxd685nKbiRxcV6kivl7
	40Nu3yrAOm4gTGunLaHNdnlvG/0VAstZVoG6JLBeU/XtE6WWhkWGTVjahKP6kiUceQhDailxYAD
	wogaPF/6j/G+f+hwjAap62++nIRh8w7xDwirrlttEKYN9cuzWRCEUl8HSQV5sxe2kX1px6yCLgQ
	u7JOH152Prhwft1iiwn80hAwRWcTHb//d69NOVfE/hCf3PUsPp/2ZEMnKhDNoBNDAYJxu504Lbx
	W49xtkHTioQUlzQGEAIya5DTTfNPYHcAfJw=
X-Received: by 2002:a05:6000:108e:b0:385:fcfb:8d4f with SMTP id ffacd0b85a97d-38db48abdd1mr4886386f8f.21.1738852145334;
        Thu, 06 Feb 2025 06:29:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/IoDleFwxPd6VvG8B+XIzOXHnma2uT1uK+zVdE4JBcY5pP5LJxIbY10dmEvpunLfzdoCT2w==
X-Received: by 2002:a05:6000:108e:b0:385:fcfb:8d4f with SMTP id ffacd0b85a97d-38db48abdd1mr4886367f8f.21.1738852145009;
        Thu, 06 Feb 2025 06:29:05 -0800 (PST)
Received: from [192.168.88.253] (146-241-41-201.dyn.eolo.it. [146.241.41.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d94db77sm56725485e9.15.2025.02.06.06.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:29:04 -0800 (PST)
Message-ID: <efd3dee8-5a2d-4928-ba1d-ddccb2f29fbe@redhat.com>
Date: Thu, 6 Feb 2025 15:29:02 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next, v7 1/2] netlink: support dumping IPv4 multicast
 addresses
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Hangbin Liu <liuhangbin@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 linux-kselftest@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
References: <20250204091918.2652604-1-yuyanghuang@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250204091918.2652604-1-yuyanghuang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 10:19 AM, Yuyang Huang wrote:
> diff --git a/include/linux/igmp_internal.h b/include/linux/igmp_internal.h
> new file mode 100644
> index 000000000000..0a1bcc8ec8e1
> --- /dev/null
> +++ b/include/linux/igmp_internal.h

I did not undertand you intended to place the new header under the
'include' directory. I still have a preference for a really private
header that would under 'net/ipv4/' (IMHO the possible future divergence
of inet_fill_args and inet6_fill_args is not very relevant) but it's not
a deal breaker.

/P


