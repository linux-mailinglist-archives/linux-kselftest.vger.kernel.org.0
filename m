Return-Path: <linux-kselftest+bounces-25890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0D9A2A1A7
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 07:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56EC718874C0
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 06:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685F7224AE5;
	Thu,  6 Feb 2025 06:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="vmnDxC7G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48F620B208
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Feb 2025 06:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738825123; cv=none; b=NBUQlizE8E4pr0Gewx7d7HBjgiqAERmCO//UJYk7fdPmHdAWjOOMKTL681wmlsXuBvvHCNqC6ZKDZXWy11+wTFVSRlfb7yi4SaS1neLOBw6C4AU8b5KEwy87V8v7QD1Q97vlEZnpHMQSRjT9bdfy6xGwxvchwVBJ8cee296xTfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738825123; c=relaxed/simple;
	bh=og3Aq1IjApPzY4pBlRJEpp2monYtKZMRFoZcCbo2WO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g+TUOccyIKHocrh4bYdNWaj6DUiTyJCrTy1WFEe6GOlHqFDk+Jc4BNCIXdsD6h46k3TNsCrv5MPQKmYCHYrKpwV13+ojGq+66P25g6fmTpSI4T3TgfSTxscFp9vsjPadyfDkzrcYMTrtOq7wmsLM1o7rKv6i89HthCwXVGME2W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=vmnDxC7G; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f200014f1so8361165ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Feb 2025 22:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738825121; x=1739429921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MfkFHRY4BuNO95W0YyldJMDcWeJ1g/mRAGw+u9+CPB0=;
        b=vmnDxC7Gxchxw1LtQ3i7bSdlDrG0ebeWraoMP4rauxsI9uiJ5x+WxrDyHSIEWhrb0p
         wjraVaFlMkv16b6IYjG27lol78/n506Ws//dWuJ4sPiUyma+6x3CiRJVc7ZjhHFeEneU
         yA5j0VaFe53ATkXIMJJ8zr1nAuQT1R2TpUOwnainI2C6d7kh4p4AmArZOLGoJ197SCFs
         ngwx3rOENpKJlGX2wy8DLXNzl8vDSmoNgSBWiI3zfDp7FyKrxW9qDdhRXo4i61+y8DFm
         kkfGhfHGGr3rrXObj5zbMB/3FQTxXVU397KqaGCwtPQKG0Qcs+9FdemWZTsf+yuamk0/
         Hpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738825121; x=1739429921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MfkFHRY4BuNO95W0YyldJMDcWeJ1g/mRAGw+u9+CPB0=;
        b=f8T01OyUXlJfZfn3eQu61QqeB+nzFRHOal1vtsMhe8HQfGbfVRrS8kFwAbFncCPb/f
         WNHeHYn1PXWaoNgsqRle9Ri8gC7qGiZYdvtPYF3qiUrRbn026E60V/uPOq4wn4ctub1g
         bby+K4QiSbosiiiwaKduSzpEiBwNhDdikFyowNbR8AoQT6cwOr+TAagI200kUJ8t4t5s
         ivJAHHXjtMt2uNLqEM/WgB3e5rqpgB9V0QPBEwK+UeiaQwHND9TFb+XEIkPC3ml8bS5j
         jmIdqorJzbD2fvkEGghyLsMX5MeU3Ka5fssV54nEH4EswKg8dve9JnRjtgu1nmGGUr93
         ZNKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaTkxwhllX2hB0HbS3L3LRhmMjomLeQEJ4f7gHViiXtM2gn7wvSsFBu8pl51ND5MhJUvOD1ukHcCBstcEPRN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUNET0BX3QSvmHDQ5s79pL6KkFMguXmsGvhWKmyYMMVFWSCMkG
	pGLKyG/3X4qxxCxD3yjfuUGvWuFAaC2T7PqwQssFmyBC+bsMvFpNQNrAFgUmRdY=
X-Gm-Gg: ASbGncujrknpUaVLayCZret5joV+Pgn6gX/Qu57NILwhgIoOKdzRd5F8p0dzhvyL0cl
	Jg9Bqgbf3wwYu3QJ4FrA9S39Gyh11ZGhUrfTWqqvic5WE6o/LyeV8j0LOyuf8wLa9nGh6y2+EEQ
	xYkiDIwLUccQFA4k6GXulbK1TJQoteS+bwvfM3UQCQ5KDRp3xDWys/75T8hBd/qMUFpWR8JDjkG
	+8V1QzvVc7DWmFWQNfxi24p7SdBoC8ZngS7Z9Vx/MOMPr8rZ2sOENAHwokSl8MwDHB4MlqeJ3/I
	UGsmV9k0GIylJOmSJ8wS7+R8HItz
X-Google-Smtp-Source: AGHT+IHSHvbDEBE36nUTLqiZtQMOf3j/rI2OoIwM0kMRTh5vyxMjVD4DwGY5i/68BnM7I5tCX5GUew==
X-Received: by 2002:a05:6a21:1805:b0:1ed:a6d7:3c07 with SMTP id adf61e73a8af0-1ede881f0b3mr9719443637.4.1738825121065;
        Wed, 05 Feb 2025 22:58:41 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ad292dsm590546b3a.61.2025.02.05.22.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 22:58:40 -0800 (PST)
Message-ID: <1c2a1bd6-9ce9-47d8-b89d-1a647575ce07@daynix.com>
Date: Thu, 6 Feb 2025 15:58:34 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 5/7] tun: Extract the vnet handling code
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
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
 <20250205-tun-v5-5-15d0b32e87fa@daynix.com>
 <67a3d44d44f12_170d392947c@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <67a3d44d44f12_170d392947c@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/02/06 6:12, Willem de Bruijn wrote:
> Akihiko Odaki wrote:
>> The vnet handling code will be reused by tap.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   MAINTAINERS            |   2 +-
>>   drivers/net/tun.c      | 179 +----------------------------------------------
>>   drivers/net/tun_vnet.h | 184 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 187 insertions(+), 178 deletions(-)
> 
>> -static inline bool tun_legacy_is_little_endian(unsigned int flags)
>> -{
>> -	return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
>> -		 (flags & TUN_VNET_BE)) &&
>> -		virtio_legacy_is_little_endian();
>> -}
> 
>> +static inline bool tun_vnet_legacy_is_little_endian(unsigned int flags)
>> +{
>> +	return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
>> +		 (flags & TUN_VNET_BE)) &&
>> +		virtio_legacy_is_little_endian();
>> +}
> 
> In general LGTM. But why did you rename functions while moving them?
> Please add an explanation in the commit message for any non obvious
> changes like that.

I renamed them to clarify they are in a distinct, decoupled part of 
code. It was obvious in the previous version as they are static 
functions contained in a translation unit, but now they are part of a 
header file so I'm clarifying that with this rename. I will add this 
explanation to the commit message.

