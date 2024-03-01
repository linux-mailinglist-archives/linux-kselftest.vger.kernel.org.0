Return-Path: <linux-kselftest+bounces-5716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 802BF86E119
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 13:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207501F23CBD
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 12:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8B4812;
	Fri,  1 Mar 2024 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="f59NIocm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5965338384
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Mar 2024 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709296374; cv=none; b=CQvgVbzR7g5DgrIcSwbGIp9XaQ3L3/xCqDd1nAfVl4cPRiSbDmSbfzeoJDRC4PypMviu4h69ri02AMOlwXHF4fodei2fK3rDBVSFvhF0zb+UxDlIKQK0WrzxH703JZBDpuBFnC0zhgUr98EBCRq0cVej20kn6sJo45Y4o2yjmNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709296374; c=relaxed/simple;
	bh=/eI9D38v+sRpJU6jcLGInWK+uw9tJyayROM2DreeKjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+EMy1XbUJx1GN91XuCSNe2I6EeNbmenJFgDPb/L7LDdThfqQr+jKwAbtHTkGvYzP5S1XnVGVol0m0yv0U057WzZktIFiZXI8qv3G4x+fUSwBOqV05/OOK+D3qxZpF20X/Wq36cFrx3rH4KoFxPtspSlatszuJiIj/g2fbYW5EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=f59NIocm; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5dc949f998fso1458579a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Mar 2024 04:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709296372; x=1709901172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lR9E/jm6p8MT+tRZUdlR0P5QuIRmSZ1lBNgN+cNNF9I=;
        b=f59NIocm7XzPJ3Ki7Xx8NIkNnr5VPIIHETeYioLDLUvuSuy9dWvhp/yDTditBODoht
         B2g9iAecbf+cB0pAWwYO2ZHpn4FUUodbNgECvuXScgSqe4mKJBP9gpxoHOzodolggBTQ
         NRxKYyFMNNpKoiWhllNqpW5fPL3bl80nUCJZRB2ajOiE0e+MfhAIT9toJuaIbj2W9+Mk
         GtwP/GkPXPchsYK3to73Y162o34tESh2uPqCd6dzTswKsxypDOyiDarBYboB2G0VcJgj
         uASpuYpXAUWDa7bxf0cLJW//YZuCoDOXBt2qwu8XzoJuTvMnjk6/oonFfJdnEld3VheM
         gfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709296372; x=1709901172;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lR9E/jm6p8MT+tRZUdlR0P5QuIRmSZ1lBNgN+cNNF9I=;
        b=eXctpZfR+RzycFKrx7KJ74lCGSQGOhbMWyqEaHhBTInlpMB22h2vLpxLa0+hVslK8h
         QU3y6kil4uGV1BZL+WGdnf0zuklgjLXIUQJIDaKxVdfLazfU0oN7y3A7sze5a0p/j0A1
         CCHRzABlse8vl/cVlCrg3PTjN/Zz7QeMw+MN4UlbLwemJlbrpEcoFqHOwfsgQVg7NmKX
         CPU7O5vkXhNJvk3HXrEeMNK8xTuJ6G9IXycVYRghGaGaHztYcIxm/ipfxDNeGVyIzqKM
         aIEhSq/2qCpHFMZRIRwHdbTOd+8NydP8IYGcYswAmoLLEYfVaJ4ZrKvJ/vKN+XS0PLZ9
         c1nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfKA9/jnrwfP1L8gG0Rzv6ipy52uxChC4sFkeyngVNMMt+KhTYiQ5AISAtRWwsp1w6cOcnupA87/fJ0dXgobLnWtWWFtYRP3vjkqKxygok
X-Gm-Message-State: AOJu0YylgU3wCAcE+nMef7Sh8F1rFX4NTo2U/DLx4chR/yAacM4JGaxI
	GZaZt0BZMPDV3D3CsFHZQBFHtvLZ5+koNdlnk6LmEISzR5oETRScPOhzg+mkOQ==
X-Google-Smtp-Source: AGHT+IGki7+N0P0JUftqKXLnxr6EuCXOGMN84IOxXyatvBjh3tKy6hH7vSjqdb/pWKS9UWBBqiLjdQ==
X-Received: by 2002:a17:90b:3585:b0:29a:4239:6893 with SMTP id mm5-20020a17090b358500b0029a42396893mr1542134pjb.6.1709296372634;
        Fri, 01 Mar 2024 04:32:52 -0800 (PST)
Received: from [192.168.50.25] ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id sc11-20020a17090b510b00b00298c633bd5fsm5335779pjb.30.2024.03.01.04.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 04:32:52 -0800 (PST)
Message-ID: <a824a886-1941-4456-a9f5-3398c323a58d@mojatatu.com>
Date: Fri, 1 Mar 2024 09:32:46 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests/tc-testing: require an up to date
 iproute2 for blockcast tests
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, shuah@kernel.org, pabeni@redhat.com, kuba@kernel.org,
 victor@mojatatu.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Linux Kernel Functional Testing <lkft@linaro.org>
References: <20240229143825.1373550-1-pctammela@mojatatu.com>
 <CA+G9fYtuQfNTr3fgJ5MeYCXqvc1x17TdBRxJ6-aD76109=Pk9g@mail.gmail.com>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <CA+G9fYtuQfNTr3fgJ5MeYCXqvc1x17TdBRxJ6-aD76109=Pk9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/03/2024 09:24, Naresh Kamboju wrote:
> Hi Pedro,
> 
> On Thu, 29 Feb 2024 at 20:08, Pedro Tammela <pctammela@mojatatu.com> wrote:
>>
>> Add the dependsOn test check for all the mirred blockcast tests.
>> It will prevent the issue reported by LKFT which happens when an older
>> iproute2 is used to run the current tdc.
> 
> Thank you for the fix patch.
> LKFT tests run on Debian rootfs, Please suggest the packages that are needed
> for tc-testing.

I believe testing on net-next should also use (iproute2 + iproute2-next)[0].
For stable the same rule would apply linux-x.y uses the released 
iproute2-x.y.

It's my understanding that some distros ship a slightly older iproute2.
So in order to match the versions you would need to compile it.

> 
>>
>> Tests are skipped if the dependsOn check fails.
> 
> - Naresh


[0]
https://git.kernel.org/pub/scm/network/iproute2/iproute2.git 
https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

