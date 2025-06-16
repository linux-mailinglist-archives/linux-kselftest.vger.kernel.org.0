Return-Path: <linux-kselftest+bounces-35153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A466ADBD39
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 00:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF6E3A429C
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 22:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65ADD2264CF;
	Mon, 16 Jun 2025 22:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYX8ZSks"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0A92264BE
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Jun 2025 22:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750114177; cv=none; b=PH5WpSF7Qka708YOS8HSs9b5xMHpuxo7DBRrtq8ZCcCm1BZzGak0AcxOT0W3w2TdCXpJKA6w6OuIQYksesjBeFnPqvBoUmus506KpdS1DFfQd9m4ZaVscOvI6UJ9sEZZVGCPMNXr/6HukW0TCjD0EfiXunW8eDwPyzhmNjnl0ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750114177; c=relaxed/simple;
	bh=tZLFoxygNTlGhkQcfY78pxQHgKoAw84D8OUjTG4giqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIbJxK1cpi/A9wrIQdpzMWViBRcOa9TdKNqNRje7W3SSYqU0gApsiuBxUl36NkRVUn8I8AvCxkEqBGFxpOtgsJFEG1ZeFfVX9nA0i/qd5SA4yMRZXXvuCaeZa6keJZYBQpdlXUucESRwjRGtzchQhmmG2wUp3mdOwxtXGwE62Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYX8ZSks; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-adb47e0644dso40562566b.0
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Jun 2025 15:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750114174; x=1750718974; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pfo5QVqcXpNlB2XvBKhw7PgNU7pYx+RjxjorWCsgyEo=;
        b=HYX8ZSksxir7U/i1YwZ8CYSjP/mrd0YGpkOoI4IJlAIApF8Z/e+F41HDNRvtHUcSWp
         nbZws2tiZ0T8gw5/koQjuaMXki+y23FDIAgm1RLIBX4sB9qobUNFE+pxqWJYrDuu6yOm
         +YjzJOwOWljswnR+dbzDr4cJbd4bZVWls/Z3bhJmv916/AJ4jTHHWfeWXTXhiJJ+bYh5
         w6OIpX3Q/WJZ0890oGHmQdUedALjrVc1BPCBQIiWoZqkbpfWGPzKVjiVUhx5Gvh0ThjF
         8ITmUw8q1SbdmJcUxEFQVuZTFnw7t3dp+nSDU2qlamaMBjN0/zeSDCfYgz3bbipnXt/0
         NZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750114174; x=1750718974;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pfo5QVqcXpNlB2XvBKhw7PgNU7pYx+RjxjorWCsgyEo=;
        b=W5APILxHd4VodA0U/qUsv1kPKQL3vMQsIYy4266sKkMXr5mbDJNmQIWVItAQWBlqS3
         O2Gk/JwG6qAP0dxLG5royqGkYlR5aZPYdtYPwjNSGlW/h6Abz6CZU3Bgg5fCYsSAM4Vh
         lbf08WgWXS9ILUxXatQAJ9+mHx2R5am0P6ZOZK7FKwYeuf8FS4ZRX7eJvgKj4SaxtTn8
         hp4X9fMF/Xf63Ong8uoGgngvZh7FZVWkaq7gAOMcqIr18zStdiX+AKoqCCyvej5JjKYz
         oe842kjjxZZ+tcWUf99q5VnK0UfHzH7+BiLocD7WLPz6sh/Hu712fTVWY4mulNoCgpJR
         acog==
X-Forwarded-Encrypted: i=1; AJvYcCVc7ky9L41EbjOsqq0ZhcHrnb/2ICAARQWJF0bGzyTFloXZS8/uZU5arOjTtNIYfNnYyoKCdGRoakuzt8ETU0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSJN9tazJzlPW0VgyUqZ66taGWoBG5aLdyspMn/YGDhWhUwyOA
	vtt/tsjpluJ63RR8vCihCKi5HcD0RzGJLMheUllzgSzUcRbsP+B4/rqs
X-Gm-Gg: ASbGncsKD6yajbFMZ8m5Xt6tURwvwgjYrEEXS9h0JUEYpkdgZ261f87GJGccEs7IB76
	SPkh8E4ghtHK80QJGuJB6cGoxWNk4kLBs8rf7KpfDESTbfkPrWwuf3Xn4V+xUXzY27Y55BpMkdA
	HP8RLqh5KdcV0o3XRV3vJAepUY45F+1DZpag0ucmIXdR6G/MVbBaV3Gd/gL4yagNEOQIOubfKyh
	WsLzg9xNHW2zbHPnbns7BzuJJd6c+Fu47kKBqAT24KTbkq14jIa7put8EkbMl+dAxajt8ipI7wK
	KhvL3H1PiK+vek1V5VhhIRYboYsDEwDrq4YpQlrPzIiy8UOPMUFwYp63ZFd1zw==
X-Google-Smtp-Source: AGHT+IGxukeO7NCCDALLIoJqx4E9qUKbvTMzT+5IB+ZVrTUdGRiUoAXylPQgZx1xBOO+k10+ceJa3w==
X-Received: by 2002:a17:907:7f05:b0:ad8:5740:9932 with SMTP id a640c23a62f3a-adf4fa8a045mr1104159366b.26.1750114173670;
        Mon, 16 Jun 2025 15:49:33 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec899ae45sm748674166b.179.2025.06.16.15.49.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jun 2025 15:49:33 -0700 (PDT)
Date: Mon, 16 Jun 2025 22:49:32 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, shuah@kernel.org, kees@kernel.org,
	luto@amacapital.net, wad@chromium.org,
	linux-kselftest@vger.kernel.org, thomas.weissschuh@linutronix.de,
	skhan@linuxfoundation.org
Subject: Re: [PATCH 2/3] selftests: print 0 if no test is chosen
Message-ID: <20250616224932.yrtezpd5n5qcojuc@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250616122338.32678-1-richard.weiyang@gmail.com>
 <20250616122338.32678-3-richard.weiyang@gmail.com>
 <ff053978-78ce-4ac1-a406-32222bfbde05@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff053978-78ce-4ac1-a406-32222bfbde05@collabora.com>
User-Agent: NeoMutt/20170113 (1.7.2)

Hi, Muhammad

Thanks for review.

On Mon, Jun 16, 2025 at 05:44:55PM +0500, Muhammad Usama Anjum wrote:
>On 6/16/25 5:23 PM, Wei Yang wrote:
>> In case there is no test chosen, e.g -t non-exist, the following message
>> would be printed at start.
>> 
>>     TAP version 13
>>     1..0
>> 
>> Change it to print 0 if no test is chosen.
>Please give reference from TAP format guidelines for this change.

I see, will drop it for later version. 

>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> ---
>>  tools/testing/selftests/kselftest.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
>> index c3b6d2604b1e..9fcf76f0b702 100644
>> --- a/tools/testing/selftests/kselftest.h
>> +++ b/tools/testing/selftests/kselftest.h
>> @@ -144,7 +144,7 @@ static inline void ksft_print_header(void)
>>  static inline void ksft_set_plan(unsigned int plan)
>>  {
>>  	ksft_plan = plan;
>> -	printf("1..%u\n", ksft_plan);
>> +	printf("%u..%u\n", !plan ? 0 : 1, ksft_plan);
>>  }
>>  
>>  static inline void ksft_print_cnts(void)

-- 
Wei Yang
Help you, Help me

