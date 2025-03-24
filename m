Return-Path: <linux-kselftest+bounces-29718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB67A6E6D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 23:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383053A4821
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 22:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2AA1EF0AD;
	Mon, 24 Mar 2025 22:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BozUFF6l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC61189520;
	Mon, 24 Mar 2025 22:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856599; cv=none; b=ts+msUaOaQnZ2YkMxEPDh3tKu6BpK1Ho3eZbOxn0yKt6djhh+ezWc59SvLrHLUTk/tOsfueFFYuvqK/VSKWfucWNA+okM+ulP/hNDTc8wAlADkrBcKemmtC88M4X1E0PK3dkmucmWknFkHV/wCCmlmBsyX/OouI1HXSAibkRaQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856599; c=relaxed/simple;
	bh=NkWtHQZowQTL7Jol5zWrb9SwiFcWoVIVhxmr/IcG3Ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WdWFyB+IzMZjcUyYJsqjRiiu4n8kYEWKBWQU7eyO5wQh+uUT+yZXzqpYqIjKWSd5oNFgj1IsX0osUJjIBxbnCAn1ILs3ygnFQksgxoyilYWGJs0ZvsZIotr0suPdZPaoFOBUl/8VRKNN1V87oiwgnUKtf6DXmobLWOvbKZdmxXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BozUFF6l; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-301302a328bso9398022a91.2;
        Mon, 24 Mar 2025 15:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742856597; x=1743461397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pnVKKXArtsJAYtZYqgbhwKX6/KL/EYF8EfA1x2Ala1g=;
        b=BozUFF6lF/LGAFBi7cU3p6fu7arU2mQovC98mBpOh8by4MZMTzwNLKC2DH2xhqTLCN
         JobO6BTsir1LaPQCriO/uEX45R2H4/X7yZ925R/431LPVRKTZfpLjkawjMhbJN7JWtCu
         RtXIff8B7nI4E8szThOOUBmlukv30EEMUjLP3aaapUfF9X7HStx01CGdbLQPDDc/5hon
         H8TzQ1eMqRjtfaymdsLlIoMIkUpoJuGGf7gCM+idxnBi2KkS49lYT41lLJKm+APBKG8T
         YJqv0b50CeZgo+P401TC04Jo5v92S1TcbFv6vTDB7IFRSvnjU2dAD7qH+wDcl5VDP7st
         p6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742856597; x=1743461397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pnVKKXArtsJAYtZYqgbhwKX6/KL/EYF8EfA1x2Ala1g=;
        b=dEuEZIYyAtTGDXStx7LX5GCoMWzWL95i2R8EgygJ9OqJXiVoBEgl2lxEkmkaIcOZwy
         xv8wSgEtb+o+X29hc0mAOxDRYDp63zklf/mLXRIpEKDUIKAyvpxCeJvcfBlrvYkpq33E
         a2mSjhCRi/R2thpqOnQVYcZvllshOULrTXaUAtnkXSavfEOxDAum3XYr2eskJkx29fr9
         tCnCRCghAICf8Sq2c8Lp8RZNcZBL5/aDNStsR/9hi6NILthIgJSrd+FGa0CCy0XN1M/X
         BTG8lGdfI866nJkzjQSUc/IoRLC+HVhXgDfXyi6/nHNCT8QomgIHInTWd3CPbqRm3YWL
         9vfg==
X-Forwarded-Encrypted: i=1; AJvYcCV8f8SakkFy4lXN5PtkC0QJWrz4Wj8qlJpcbBEkLnLMCwJaoiS7t8XHUFPavAuMtQCILEg/Xavzw8CgHge9Fg==@vger.kernel.org, AJvYcCWF8d3nUqHrixO8ABC+wVahYuRQNAEARfXSHZQxaYoWH2DiZAxsv781gRnf0eiyllc5ajFzvXWb6L+DFKo/+j4P@vger.kernel.org, AJvYcCXOBciiFe7cttsn2/l1gZ5gp4WuBpa9xttvzGLkbTxiXl5dUBmrnS5+Eesd2cYufpvFZHT0UUxaoPzEhVI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+0qaXMkLURT6KHu4bItadtYW/gnMhmew+1SZXmRwKo+Si+1zI
	fIV9iyDqQN37YzButuoiPFAXZtotPGhVjAjWux/vSqRhKFdgWReR
X-Gm-Gg: ASbGnctct279o1aU0YPcK7Il+PXSM5vNzM101cxwFzoVtvWCfcKHtOvNV8URh1acV9K
	x18VUFFoGDPrK+9vcH75RCrOIVkwgsStSKGSt5ON4+4fdFn4YQ7yhYW5AS0rg0x/TemJupBHf8B
	Kk5/rD0hUyd47npYHsKrQ94yK7KhMQEVrJcW41/UtQHb6bapHWmBQRL2PcW1fJrfG0ihBinJZHq
	d+q+MhssOGi3/qCEQYBWP6wquf340zHvEe7FrsnZmdHYjQQIpAb3IqYgC9M3ytGbISYHAdnQaMb
	aW1WJr9nunTwgvph8yZiNfOR11+m8dfUaGVp9UqpCAbRtY+glZvxa9/OIt6dHQveqYPA0gqIEdT
	fUyp8QoFUECODeI/APDOg
X-Google-Smtp-Source: AGHT+IG/E3HxCR8DB9j70Xj+kKpNSWoN0BEqeQL1R9dn0EUzNvVnDIR9zmF/TOag2aAJqylX8FSIGQ==
X-Received: by 2002:a17:90b:28c8:b0:2fe:b8ba:62de with SMTP id 98e67ed59e1d1-3030fee95efmr23243993a91.25.1742856596817;
        Mon, 24 Mar 2025 15:49:56 -0700 (PDT)
Received: from ?IPV6:2804:d57:4e50:a700:f33d:65d1:e22e:109b? ([2804:d57:4e50:a700:f33d:65d1:e22e:109b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030f807533sm8763746a91.49.2025.03.24.15.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 15:49:56 -0700 (PDT)
Message-ID: <135e8686-1eaf-44d7-a547-1c9611f7f180@gmail.com>
Date: Mon, 24 Mar 2025 19:49:50 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] selftests: livepatch: add new ftrace helpers
 functions
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
 Shuah Khan <shuah@kernel.org>, Marcos Paulo de Souza <mpdesouza@suse.com>,
 live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, felipe_life@live.com
References: <20250318-ftrace-sftest-livepatch-v2-0-60cb0aa95cca@gmail.com>
 <20250318-ftrace-sftest-livepatch-v2-1-60cb0aa95cca@gmail.com>
 <Z+GmGfcdEceUzTQc@redhat.com>
Content-Language: en-US
From: Filipe Xavier <felipeaggger@gmail.com>
In-Reply-To: <Z+GmGfcdEceUzTQc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/24/25 3:36 PM, Joe Lawrence wrote:

> On Tue, Mar 18, 2025 at 06:20:35PM -0300, Filipe Xavier wrote:
>> [ ... snip ... ]
>>
>> +	if [[ -n "$FTRACE_FILTER" ]]; then
>> +		echo "$FTRACE_FILTER" \
>> +			| sed -e "/#### all functions enabled ####/d"
>> +			> "$SYSFS_TRACING_DIR/set_ftrace_filter"
>> +	fi
>    
> Also, this may be more stylistic than a functional nit (I don't know for
> sure), but shellcheck [1] seemed confused about these lines:
>
>     In tools/testing/selftests/livepatch/functions.sh line 90:
>                            > "$SYSFS_TRACING_DIR/set_ftrace_filter"
>                            ^-- SC2188 (warning): This redirection doesn't have a command. Move to its command (or use 'true' as no-op).
>
> I wasn't going to comment on these until I saw shellcheck note them, but
> I thought shell script convention was typically to end the line with the
> redirection/pipe then escape the end of line like:
>
>    commands | commands > \
>        tee output.txt
>
> There are a few existing examples of this pattern if you grep the
> functions.sh file for '\\$'.
>
> That said, I'm far from certain whether which order is better than the
> other.  The only reason for bringing it up is that shellcheck warns on
> this patch's usage.
>
> [1] https://www.shellcheck.net/
>
> -- Joe

Thanks for review Joe, I'm sending a new version with all the fixes.

Cheers

Filipe


