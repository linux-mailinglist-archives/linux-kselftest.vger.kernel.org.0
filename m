Return-Path: <linux-kselftest+bounces-11678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42085903CC2
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 15:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0945B214AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 13:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1952D17C20C;
	Tue, 11 Jun 2024 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NV+qCNHE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF11178CCF;
	Tue, 11 Jun 2024 13:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718111412; cv=none; b=nxVj0Mxmo80d7NqIU4hfpE9Fze129L9egrvpBJUekp+JuOIhtOvMhOIvSzPMZP0FEhyNHOweSljX2BDwvfT7OgV6WYWfKsKgGRP3A14SzADSZa+A/LbOpSkr3JPh3FUkM8IbLzpvdf8T/ZGCW6G61OTw7MSm6i3TRD8t0ANJsww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718111412; c=relaxed/simple;
	bh=OowM0yWGrJhu0NXdFvYdfVRs47ccKT5LTXLr4eZ/AB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MBat7MUsNSUopHroqyvYJKxRlUOWincdchV1KjxeQIwefrF51pXUx/GGJTm9x2NnwbOeUxx6OY00Z5F0+Xv9S9wCGF+duL86IBIiWMXg2yNtnotTwdxHwYPNTesPatBjSIDLbhQuTA1EtMKz8c/6PN4lyuItb39aaObLA7B/jX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NV+qCNHE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4214b2c5d40so1729075e9.1;
        Tue, 11 Jun 2024 06:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718111409; x=1718716209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nP2FCmhHcIdR/M9PordkCciczQFKsAS9qu2g/hHc4U0=;
        b=NV+qCNHEUuAzMdD2OMV1imUQi2C1shiVGuc2lVtmF6bZJxsbYIytV0V/a8LTAo66tk
         QfBbIr7KabBAXptNWALu3zpmFq7f3wYu0lpmhZqVvpkJAQ5+uiSteecYBo+Vx/umCVhc
         ZySq/CAZSEz5jVga6Sieys/q3NjLrGtpau/FSZEVVPg5kmaLQrP4WsKPcW+8unGmamPI
         nZtaEWhG8YktZlXNIzf3HFjktAciQM8sqX0pgD0AwG2YGlFlekayVu0ZJKonDWb2AXYK
         oxS5yY16fRFNT8ZrbDb4b0pRe/EwxZFCQ35yAIcC8ywtHGAuAfX5SF1B1SGfIs3tuCdR
         pBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718111409; x=1718716209;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nP2FCmhHcIdR/M9PordkCciczQFKsAS9qu2g/hHc4U0=;
        b=jsiovjiq5qEKGBbzUN97YuXcuxg1MonBAOjP2B2bFucQJNrHipEME+EzTl/3yrNMLr
         KMEOJsrElUKSGLifWGyeCqJJGJZiS9kVEXOzlXqAOt7p7B6lJq1C2AxwhOZgBK6MBst1
         j0Gt3JHNBVGZv+xM9Mow5aaLbIJN3vllUi1TlK28eVS2uylo4BqGWK0PEB3veOrXLR2N
         WM3c+5h90/1mBBdyOGTxzQ1Ufwp+1D2QHnpnTz1ca84lh2hVN26/lyLqWM8NqbVuYQQ6
         g0clyOI7CwoQv6WsQlSvuZgDDLS4mwHGBpzxYpgzxVYpqQFPktAw4WLXdf7qD0KkXSox
         OE2g==
X-Forwarded-Encrypted: i=1; AJvYcCXuhsy5onbQbht4cN9iPOoRf2cZZKGQpfProN2r0oOI+hXeaFX3OViKc5EbISQq1pUzdAj+j7sENRSdEC2gYH8qCKiqQQLMG8un5IGjdNXUc2WVl15Bzjf9Cpdmp8a1w8oK9M+QaVBs0os1Rrfg
X-Gm-Message-State: AOJu0YxV97DZe+AGZRCNePmkfAfwD06l+HujEdhaFJZdOOZzhwGrRCWN
	I7y9aMI341Gp1F7NuDEsXKKNm76Ic1masBJZ+MEznV9BWypDqGl4FqcZwQ==
X-Google-Smtp-Source: AGHT+IFz7C5d9d2H9NIq+F7CzqjYo5tbxwiko3N+2to1x/djg53BXuHXLQfdN9V37tjl/D06kzUHDw==
X-Received: by 2002:a05:600c:1d17:b0:421:de31:84 with SMTP id 5b1f17b1804b1-421de312004mr36040145e9.2.1718111408537;
        Tue, 11 Jun 2024 06:10:08 -0700 (PDT)
Received: from [172.16.102.219] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4225443988dsm24058795e9.47.2024.06.11.06.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 06:10:08 -0700 (PDT)
Message-ID: <37fcb821-e49f-4f9e-a1d2-1d18d40ea61c@gmail.com>
Date: Tue, 11 Jun 2024 14:10:04 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] kunit: Merge assertion test into kunit-test.c
To: David Gow <davidgow@google.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org
References: <20240604123204.10412-1-ivan.orlov0322@gmail.com>
 <20240604123204.10412-6-ivan.orlov0322@gmail.com>
 <CABVgOSkc+t0J2tbgRHnsao9mhhDDKcjp+62R+F_fUQv7aBvTbA@mail.gmail.com>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <CABVgOSkc+t0J2tbgRHnsao9mhhDDKcjp+62R+F_fUQv7aBvTbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/8/24 10:20, David Gow wrote:
> On Tue, 4 Jun 2024 at 20:32, Ivan Orlov <ivan.orlov0322@gmail.com> wrote:
>>
>> Since assert_test covers the part of the KUnit core (the assertion
>> formatting functions), I believe it would be better to have it merged
>> into kunit-test (as it is done for other tests for the KUnit core).
>>
>> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
>> ---
> 
> Personally, I don't mind if the assert tests are in a separate file,
> but do think it's worth having them in the same module.
> 
> Do you think it'd be better to keep them as separate source files (but
> put them in the same module via the Makefile), or is having a single
> source file cleaner?
> 
> Either way, I think this should be merged with the previous patch (see
> my comments there.)
> 

Hi David,

Thank you for the review and sorry for the late reply.

I believe having the assert test in the same file as other kunit core 
tests would be more consistent with the existing test structure 
(otherwise, the tests for other parts of the kunit core should be 
extracted to separate files as well).

What do you think is more appropriate?

-- 
Kind regards,
Ivan Orlov


