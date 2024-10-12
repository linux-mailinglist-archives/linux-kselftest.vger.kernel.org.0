Return-Path: <linux-kselftest+bounces-19599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD21B99B31A
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 12:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9F21C21AC6
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 10:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319301547ED;
	Sat, 12 Oct 2024 10:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="CJ1ch+Xs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3865154426
	for <linux-kselftest@vger.kernel.org>; Sat, 12 Oct 2024 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728729759; cv=none; b=XF/62GbL1um/ta4KUInRncs8Qo6oUM9cYoB9OQPCqTgySwsD7M4FZT3kw4k0h3wzCdKp0quSZBSKb/CcknwcS7Ow/5Y3a3mZCDxgeUxDm/U14ZBl8D4mx6ZTlKDse67redUx7BtNc+FCa+cbSd3yUN5yxhiFqhsrsShqlYhzPCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728729759; c=relaxed/simple;
	bh=F2Sp1fzcw8Uf/QMINhGhDYWS9F5dWa9nb4/qh8r/ALY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jdBIXyeUNThMvgVQbcye+kC4qjNxOH90yld9otaEfxtyn4MshA7tD51wx0DjnJ8pvp9pn0Fx+fKECv7XnGRHlHdzjMkPh8slzHT8a2BHzwnoTpPA4DX98gl8JxU9OgLcm8lfWmzoDBVWaJBSUqHI6oN1VoFwKvhHaYBrGXPTv2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=CJ1ch+Xs; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c70abba48so19098705ad.0
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Oct 2024 03:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728729757; x=1729334557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rnVDkA3/NaAKhKgMUHvmItPchk02Cn37cnkYPg5p2Qw=;
        b=CJ1ch+XsP3k9Bdzgi04+URwvUed22kf7IKlTv1B37FV6auETP4UlJefSeJXGYF9vSb
         BndSPWHOFR5xJEBQbpFAxbda8AOE0AO2cUs5dvj0yNA6O+i1JXchGPZMtEEcUBJ1jDpA
         9ae5pOZ4/yMrP9TjbkbPbVtkeUGQhjollE3J4wiGs9fK52X2x1+HrGucK/JOEL2JW79P
         6cInfHli9hUziadd/Wsbh4zll4iZ37mOZPwoSCDOt8srfmrJtBy+AFMV/iBVQfaWP60W
         LDAvyZwIkTLvul7Ko140liyADahfYrbPfITSn4SlImw3918FdMwtiQzT5teJi6CGysLl
         wU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728729757; x=1729334557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rnVDkA3/NaAKhKgMUHvmItPchk02Cn37cnkYPg5p2Qw=;
        b=mNleOy40C3xgwl+kiawDQFvekUhaF8Y7v1mHoAIpIugsEiPXgyLGUIq55rd31HK0Ag
         5pA2zChG68bPACNIXhzHMtLX4VJoVJxCvNDpltm6lfKO8t0iPM7gPFBK4LsHXU7oNJ4Y
         eRXLjMvP4AHrOo4LDfFLySM0JQPLX7mLhd6zFJKaFMaMmNYroy6nFrZEZSYRxxYDRHlW
         XtdX6Kowi+O/EJiqUp3JFSo3lvyM+evLJzn4A6f+LOHR5uWhKZuX0hP49b6rW1+jKmMU
         OpgFleJ+JMcUfFqrK0ZGpBN6ZBliRd6bDDj2zp0nmVJ/mTLa0LgzkGTRFvZzs6XSjW1Q
         ISpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5UFFuT1DpiiGdAopzE5+R2BlwEOkA3cdoxXy7vriy3OS1xUxRSRx0HgfBBMNMy9neR1Zt1FNomHV5rPKULgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YydKeuOmkQMqWSXeMkuISMqlJTLXmU9URPIM9k1PoCSmqXCnscn
	YVIV+MrTtfs+FLwsvOC04S94l+bIU/krZsrNoDgmIiEsTOA7TCDKa3pvwgXinoU=
X-Google-Smtp-Source: AGHT+IHAAJSka16NZVOG9ERRGT0s8XZNSpBXGOA3FY01waa9+ItcfG5gf6PTH3meZ9nN0csYqZ692Q==
X-Received: by 2002:a17:902:e5d2:b0:20c:ce9c:bbb0 with SMTP id d9443c01a7336-20cce9cbddfmr6671465ad.0.1728729757238;
        Sat, 12 Oct 2024 03:42:37 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c33ffadsm35367635ad.266.2024.10.12.03.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 03:42:36 -0700 (PDT)
Message-ID: <30bbebd8-1692-4b62-9a1f-070f6152061c@daynix.com>
Date: Sat, 12 Oct 2024 19:42:31 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v5 01/10] virtio_net: Add functions for hashing
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
 <20241008-rss-v5-1-f3cf68df005d@daynix.com>
 <67068a7261d8c_1cca3129414@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <67068a7261d8c_1cca3129414@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/09 22:51, Willem de Bruijn wrote:
> Akihiko Odaki wrote:
>> They are useful to implement VIRTIO_NET_F_RSS and
>> VIRTIO_NET_F_HASH_REPORT.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   include/linux/virtio_net.h | 188 +++++++++++++++++++++++++++++++++++++++++++++
> 
> No need for these to be in header files

I naively followed prior examples in this file. Do you have an 
alternative idea?

