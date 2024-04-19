Return-Path: <linux-kselftest+bounces-8419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FEE8AAD88
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 13:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEDCC282EB0
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 11:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A38C81723;
	Fri, 19 Apr 2024 11:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ov+mWThE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DC881725;
	Fri, 19 Apr 2024 11:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713525505; cv=none; b=XLfaIs6WvSlB72tNCUgdoYlU6ENAn2fYlkAj5llL/6ZIZJrFSkBfP3iXGbbtvJfDbFRTf+Vn9YZGCo6U1bj9VoBiZ77SIPwNmrT7Fiu7gMsZUjgDwy/UBfMjpOJ+T93IQPenEb3IzD9fa7ZMhe+GmzZ3odKeNoxzVKQsXq2vUkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713525505; c=relaxed/simple;
	bh=4S0ijTuOG1XfPNB7vzzLF7bgqgJf2hetvsXjMkXUk+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0F3LCuoKY61KpYoXeoEUz+X0j6AFC92kJCWLaoruORmOhaMiKqs01jRwTLMD2AoVGx92Bdhm9/d7jzlVKHleckpPVZI+IwLi5i6oBMN7Q8YotBZRZYkSaO4Ndd+TBRMYNq7gkajgZoS3TtokIX8Imj7OGZYCrHNmiwajMDE4AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ov+mWThE; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso1576687b3a.3;
        Fri, 19 Apr 2024 04:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713525504; x=1714130304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OyBuv5kBEYfUc16aLXP76ZXaynrNdrlIh1WL3rQFBdw=;
        b=Ov+mWThE8IvrN65xo3/FOfZavMaJHKs3T3gm4+NbfMEjWCOGu5bHbtzCHiqniBTvMW
         QC9H477bCfFlhhGsrTUQUVSR86+2bDVHtUiTq977no0Ou9dgW4RO0pf8D+mtBbWzInfj
         iPasmg4oiCd+ICUpIfst6gfRVNe4qANSq0X5OwHAOK9I3eSOM8vV7NfeGbRSCuo9W8oE
         YBGJW0m2zz4ynzAlAlo2N//FH2f9o5qEeQojD1bSfP7rQWcecJNJvtkV2dS7ea6f0OST
         keLK8U4s3/1F+xxe2BhVIUmhRqdCOT47nDl7NKdXWRlZiu1B/YcoSEIQaxMFfHkYHQ4e
         7T5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713525504; x=1714130304;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OyBuv5kBEYfUc16aLXP76ZXaynrNdrlIh1WL3rQFBdw=;
        b=P6xbUFUiPcV1a9/2mXLx1ZrPwldug+Om1IKM4fYQnsfn+9w7YTWkmhOoIR7GLZpI8K
         iZUaq/YIsMJxu4IBMzjr5BuCq1B33u39fp5sYx8Fn1X9XKNzfJnmd9Z/Fbx4oh6uP4aU
         SblXOysuqDhbz9GjRS+P+/VPtiaww/3p53MxOOnYvyFDvOTYHMFqMHkkBTvJdUYZ+q+z
         eAGDdUf2IOJlliURYe/AgxCsGIR4zcUYZM0zJU9vdc77xri3VidAsgwJ9wExAKnybbXL
         OaU4eMK2tYqSeUbYeuzh7OLyAkXpkBJEjjUL1oEhy99IeKGxz1JEknLh5kzUJmlK4IJv
         ERXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnVqKXKIcKadQb6OH504E7z4RpSxJw9UGcshX1Z2xQY/mukm/dJLgX6gAYnMSHdVRqY8SpPeEv4+PtSCPuuci+vEBuiuw6cRzqhW22RxUUK3NvkOz/28kxoF+XkYKGmkD/UHr2a2DAOfOmw2hzGqPg9NbGfsf7kp/QvFzPdAfbiP8E/mhsazCjGVnm9/PE7rDKGRVrAk7QDDYMaxXhL0KLIIhDm9FURQWXpFjsuE8NlbK72S3gdZn9/M1DYPQv
X-Gm-Message-State: AOJu0Yy4JpBOyw1ByM+8VA44hHAPUVZMPtLtuCXsJlXk3x3gZfXfHkAj
	sm+pFBPrc02nfV6+QxNUML0Ep6GI+xxRGpqQ5HDRvA2JOqEo2w5T
X-Google-Smtp-Source: AGHT+IGrIiXTpCilLzBmkpvZQgTccBG7XaieqrHNhkdG0tln9wJXWvgEsCFL2ljmjKXvjnyamvrgcQ==
X-Received: by 2002:a05:6a21:168b:b0:1ac:423b:7c7a with SMTP id np11-20020a056a21168b00b001ac423b7c7amr1456490pzb.21.1713525503827;
        Fri, 19 Apr 2024 04:18:23 -0700 (PDT)
Received: from [192.168.0.107] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902c41100b001e00285b727sm3104974plk.294.2024.04.19.04.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 04:18:23 -0700 (PDT)
Message-ID: <fe361a16-1536-4c92-894a-0b24258384bf@gmail.com>
Date: Fri, 19 Apr 2024 18:18:12 +0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] security: digest_cache LSM
To: Roberto Sassu <roberto.sassu@huawei.com>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet <corbet@lwn.net>,
 paul <paul@paul-moore.com>, jmorris <jmorris@namei.org>,
 serge <serge@hallyn.com>, akpm <akpm@linux-foundation.org>,
 shuah <shuah@kernel.org>, "mcoquelin.stm32" <mcoquelin.stm32@gmail.com>,
 "alexandre.torgue" <alexandre.torgue@foss.st.com>, mic <mic@digikod.net>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
 linux-doc <linux-doc@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-kselftest <linux-kselftest@vger.kernel.org>, bpf
 <bpf@vger.kernel.org>, zohar <zohar@linux.ibm.com>,
 "dmitry.kasatkin" <dmitry.kasatkin@gmail.com>,
 linux-integrity <linux-integrity@vger.kernel.org>,
 wufan <wufan@linux.microsoft.com>, pbrobinson <pbrobinson@gmail.com>,
 zbyszek <zbyszek@in.waw.pl>, hch <hch@lst.de>, mjg59 <mjg59@srcf.ucam.org>,
 pmatilai <pmatilai@redhat.com>, jannh <jannh@google.com>,
 dhowells <dhowells@redhat.com>, jikos <jikos@kernel.org>,
 mkoutny <mkoutny@suse.com>, ppavlu <ppavlu@suse.com>,
 "petr.vorel" <petr.vorel@gmail.com>, mzerqung <mzerqung@0pointer.de>,
 kgold <kgold@linux.ibm.com>
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
 <Zh4DQ7RGxtWCam8K@archie.me>
 <66201cd2.df0a0220.a8ad5.6fbaSMTPIN_ADDED_BROKEN@mx.google.com>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <66201cd2.df0a0220.a8ad5.6fbaSMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/24 02:02, Roberto Sassu wrote:
> 
> 72374d71c315
> 
> Roberto
> 

Still FTA (fail to apply), unfortunately.

-- 
An old man doll... just what I always wanted! - Clara


