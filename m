Return-Path: <linux-kselftest+bounces-32051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7944CAA5758
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 23:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC0F3A383F
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 21:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63952C2AA0;
	Wed, 30 Apr 2025 21:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F6f0SRn/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C46F2C10A6
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 21:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048353; cv=none; b=e04Qp82KdfMA0rf7uzUN/RbIoi4YqOr79M+KCEDV4HFna04V4J7oQO2a8rkr+2sHvqPyBLSWJmolQZlQct8i6ChtwdriMs1Y9WRhaRedDAJa1azSQ16dHAjOcGOb1hkR6xVHck/axyGyEGtIJEqwcyEu/MdQM5XwX7Y45bG+mqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048353; c=relaxed/simple;
	bh=m0DL8qKn2HJPRt/zk/ogv7PAipQf0Rr3c/trxICPpew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TsecBd6VL1boJI5YTFCjXH0dCH4GhEH5Q+Zmhm1r4T+YOPyXCRKlGwnGeNESuqsHfxC4faPmbKsslE+ntBjOlZ4V03Bzqor03FgPDq4tcNgAnn4JwlTYUqUvvMWelJkpH34gSbSf2NAKBv6l47aM99JSKLNAudBmXbrM4JsEowY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F6f0SRn/; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85ea482e3adso53577239f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 14:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746048350; x=1746653150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QYRbN+u1XnrHIXA+Wt481EGYDyTsWUWpekmgQbhJw38=;
        b=F6f0SRn/F5Gnnw9z4U5LCTAmUQ66JNVPtP63Kbb0U4/EtkMbiOBAKdg42MWEvHSePn
         xwBqZ01auSveBWaYOyCJ56466URw04H0YjGUK1Qaak18Cn47q4cnCCfXnCSOoTbHOu/v
         m+dXykKkhyHu4pN5MFpCETaUjFOLUoCbHg5fQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746048350; x=1746653150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QYRbN+u1XnrHIXA+Wt481EGYDyTsWUWpekmgQbhJw38=;
        b=ks4PyoL7bvp8rDo9k4Y5h60bHhb/Gn5EjI4ziej1g/6/kOMiJhMNKt2GRPihoAYHOx
         68z0v21v1Z82Lg4jqN69iP5bvX4Vfovran0779EtCckhPkZW24aGS95eANd3yhBCrd5T
         CqZ1m7ifTSYCbDvVqW4XYbd7i4L8DirNlBJS4t0CY7VNPMEvd76u9GaBCfvr6uhx2Mg+
         vm7NcjMjZx+9fZ8/rSHKE4052eI40I3gsEP26JDMV4YtdNarWr9BBDIO3NgWAQbzMjuM
         MqAHkd4UMp4CEe1FQX2g/nEarAHS6UiPPeY72ZHOX3dpyNHtFscksGGIvhEnwbiCqjGW
         M1YA==
X-Forwarded-Encrypted: i=1; AJvYcCVV/yrfC9kTWEBRBRa70C6rjEP4M/5TKTblJCU8RNq477M6KZH49I36+YHqT4XUxC+IaZqM/rPT/DsxqycIPhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsTVw4xzHQOXwN0ndL+14cVeNCxMZG0oiLzHZW4UhGwc69W72L
	CPLx3huwbyPbNm2u+J1MklU1RAI86mK9xmmTxYSq8A2XyfIu5yPBcdzBjEYl4aM=
X-Gm-Gg: ASbGnct2drQs3bQ+7lfO/S84rAzqFmjIQ8Cb9qomJJtlWTxKruxBcA0Br/An3xDvvoA
	ofa9UpkvvZkMDzj3qKnEsUMN49WHvHG2f4ERgSe7OM6w/V/n9SH180SvzjqUGCNOlqBwRLDW/EJ
	OQ1apROidHPWkKRrxMBzGNU1p9HL3ici84cwhQ+rOu1T1s+l1YEyHuw6SPggDGL00v4QH6VFeze
	Eup08cSCVFQ6x5r66BZsemAFMETPeP2sJrdl2HqRIY7WArMUgVjuQkBjFe8OBOxViJ8aU8NZ/YW
	xtDtZw4ED2tO78PFqLs7Vsx6scWDNq3GftolnM6zAp2M4XPBWvw=
X-Google-Smtp-Source: AGHT+IEiiHKVJFhUXHUB3t68KuJgUDxukeIkKP8WUSh1zX997FZQjk44Ybevewxli9cGlS3ksir7lw==
X-Received: by 2002:a05:6e02:3a08:b0:3d6:cb49:1e5f with SMTP id e9e14a558f8ab-3d970a6e9abmr606365ab.2.1746048350065;
        Wed, 30 Apr 2025 14:25:50 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f862e831a2sm921932173.40.2025.04.30.14.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 14:25:49 -0700 (PDT)
Message-ID: <4d1acc28-3645-461a-97e3-316563f468e0@linuxfoundation.org>
Date: Wed, 30 Apr 2025 15:25:48 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] kunit: add tips to clean source tree to build help
 message
To: David Gow <davidgow@google.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com, corbet@lwn.net,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1745965121.git.skhan@linuxfoundation.org>
 <dc8f4035a8d493be9ddc0e868a3ffd67626cca00.1745965121.git.skhan@linuxfoundation.org>
 <CABVgOSnKPPLH9BASOZ0b3mMOUuiVXxsdXQcoQqyTKd5UYONpUQ@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOSnKPPLH9BASOZ0b3mMOUuiVXxsdXQcoQqyTKd5UYONpUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/25 21:54, David Gow wrote:
> On Wed, 30 Apr 2025 at 06:27, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> Add tips to clean source tree to build help message. When user run
>> kunit.py after building another kernel for ARCH=foo, it is necessary
>> to run 'make ARCH=foo mrproper' to remove all build artifacts generated
>> during the build. In such cases, kunit build could fail.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
> 
> Thanks for doing this.
> 
> This looks good to me, save for the issue below.
> 
> I do wonder whether there's a more general fix we can do in the
> makefiles, but I'm not sure how that'd have to work. Maybe by storing
> the architecture used somewhere and amending the error based on that,
> or hacking around the specific x86_64/UML incompatibilities. But let's
> go ahead with this fix regardless.

I agree the right fix is to see if kunit.py can suggest the right arch
to clean. I will take a look at that.

As you said, it is good to have this documented in this series.

> 
> Cheers,
> -- David
> 
>>   tools/testing/kunit/kunit.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
>> index 7f9ae55fd6d5..db86a396ed33 100755
>> --- a/tools/testing/kunit/kunit.py
>> +++ b/tools/testing/kunit/kunit.py
>> @@ -583,7 +583,7 @@ def main(argv: Sequence[str]) -> None:
>>                                                  'the options in .kunitconfig')
>>          add_common_opts(config_parser)
>>
>> -       build_parser = subparser.add_parser('build', help='Builds a kernel with KUnit tests')
>> +       build_parser = subparser.add_parser('build', help='Builds a kernel with KUnit tests. Successful build depends on a clean source tree. Run mrproper to clean generated artifcats for prior ARCH=foo kernel build. Run 'make ARCH=foo mrproper')
> 
> Because this string is enclosed by single quotes, the 'make ARCH=foo
> mrproper' is not part of the string (and there's a missing terminating
> quote as well).
> 
> Maybe change help= to use double quotes, and add the missing one? Or
> use double quotes or backticks for the make example?
> 
> 
>>          add_common_opts(build_parser)
>>          add_build_opts(build_parser)

Thanks for the pointers. I will go look at those to make this
help message coded better,

thanks,
-- Shuah

