Return-Path: <linux-kselftest+bounces-13406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C78592C49E
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 22:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7D6282211
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 20:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CFA18561D;
	Tue,  9 Jul 2024 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HajKmWjw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AA413D63E
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Jul 2024 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557325; cv=none; b=m6hXvYmCBC+JFsclMO+KalWE9iGZsT/QkY0YQXmfE+kBVYrNXLqSu31ovwHmu1EMfYGI7n20HuWVje6ShNywOS8XwHIHl6PhLUxTdkfK5UOz6sz6ZXJ48rXDq1IDHIZdEySQDcDg8jaEhA3GIro+arBQDbTPht44YWuvtjD2j9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557325; c=relaxed/simple;
	bh=B6TBOvniiIY4yBsFeLV75HI56BIl5JHOPJ2OBmxRZh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lfrfAZkhx9NaN3tMQb44ldkjTnRymbaBKcWosTBa5Nq8G2pZ3sEqexrkKuSYHexHXN6vbUaJGtJivVvIP+ZQn/0+qjPQAVzqe3mmfosSnK/fWNFgw1ffXlXMYLmZ0LDhsy6R8y3qAj5Up08fHNJd8a4higa/zqKFNArjS2GFqiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HajKmWjw; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7f7e24bac14so11836739f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jul 2024 13:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720557321; x=1721162121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Uw/sa6sLips5jCn0SIjbZbXatTX5nFO4bBzPwrcrqQ=;
        b=HajKmWjw/ch4Vae4Cl7xxoiIcrya9ygDqxUisu2DoBZ1oWrle6OQluls/Lemt22Kbt
         8xoy4LYiIeYrA73Nx6vQlU2SA1uf2uPh10mpz7pli8WZKE3rtke6qC+bQavtNnCf1Lsi
         8OPUYa9kAHLULJyd6elfQCGjp6aXigMBNLg/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720557321; x=1721162121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Uw/sa6sLips5jCn0SIjbZbXatTX5nFO4bBzPwrcrqQ=;
        b=lIY9/leCaLfx6q2Oyk2JQwCeob/l//hrcCHJX7Hpu13Z6d7ofb4q6Q/iYAWIedNXLG
         XGhGx7L6WRidy6dsueoC20a8LZ+JZP2cmUnyZetE41vXJ+g2PKlt6QJswYbcqnFOfqvi
         i3nZJ39SVicYUrSKZGQjDTnTjnyBsrd8W0QvCACDw0tJzVbvD0/t5dYFSakCwn0cNerz
         HT5D7QXkMP+oma1JqiOAdU7vT4+djRYm3UJfoYMP1P+A3bOryvfj9E7fmZe4PNYdSdQ7
         U9L9z29V85uGSayAp76rFdjjdTjM/gd+N42DwhypPArHfEQzUnLT57IbFA6UIVWD2v1R
         1gbA==
X-Forwarded-Encrypted: i=1; AJvYcCUsrrLTMER0y4qIk2ou//j9NUrT7JdMvcBw4PjitaA/a+Q+rxE1qae3CxGK2vlipWZ72b9PX5xRkxrttRV5mRBYbSwbLQbf40cbWvIHbMN3
X-Gm-Message-State: AOJu0Yxb0mhlZRwsWfOOcGDmPm00bd5miCyEx2GrbtLpUkZwwZOg5vwN
	D7APE2st6jDc2MidzkKlPZk7OSK7mIL4MWZLkV34+gXTUD8Ql/Il/njGNePYPd1MzXgeqDND2I/
	k
X-Google-Smtp-Source: AGHT+IFSFdPJDDf6UfJgdzx9C/1pJLpTxO/0uyjQPpSaIATfc7XdSOsrOKq9Ub2TUBKnYOM2bXdgxA==
X-Received: by 2002:a05:6602:6103:b0:7f3:9dd3:15b2 with SMTP id ca18e2360f4ac-7fff92c5be4mr394599039f.0.1720557321484;
        Tue, 09 Jul 2024 13:35:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1c138eesm683371173.151.2024.07.09.13.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 13:35:21 -0700 (PDT)
Message-ID: <b8af74c6-1489-421b-8495-0056ecf144d8@linuxfoundation.org>
Date: Tue, 9 Jul 2024 14:35:20 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftest/timerns: fix clang build failures for abs()
 calls
To: Andrei Vagin <avagin@gmail.com>, John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Dmitry Safonov <dima@arista.com>,
 Thomas Gleixner <tglx@linutronix.de>, Valentin Obst
 <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240704025247.86418-1-jhubbard@nvidia.com>
 <CANaxB-zk-j2E8D0_4x04WL5Jbe08SD39jqBLbehBYWedFg+mMw@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CANaxB-zk-j2E8D0_4x04WL5Jbe08SD39jqBLbehBYWedFg+mMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/3/24 21:44, Andrei Vagin wrote:
> On Wed, Jul 3, 2024 at 7:52 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> When building with clang, via:
>>
>>      make LLVM=1 -C tools/testing/selftests
>>
>> ...clang warns about mismatches between the expected and required
>> integer length being supplied to abs(3).
>>
>> Fix this by using the correct variant of abs(3): labs(3) or llabs(3), in
>> these cases.
>>
> 
> Acked-by: Andrei Vagin <avagin@google.com>
> 

Sent in for Linux 6.10 fixes update.

thanks,
-- Shuah


