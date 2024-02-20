Return-Path: <linux-kselftest+bounces-5084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E18E85CBC6
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 00:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3301E1C21C91
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 23:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7626E154BE5;
	Tue, 20 Feb 2024 23:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aMgSqsC4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B0C154454
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 23:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470453; cv=none; b=rYjuW2XbU++ZgHY2ja2MnW6BveEpcXDIbC47ZmQhsGZW1gkC0TYSC16dbGvZJJM6BmdDx8CW0ubDgwGvAutQbwwMoXu3fLdtayE/F9SdZaF+2XNFkI7zaFFi/QV6E1wJ4F9D4mkvSgh3ZjrLaKucB0qQZkgZyB/qFUMuZfkMBVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470453; c=relaxed/simple;
	bh=fHKOmlZcwTyigCc1C09h+brUzug3zaeOVrozq4hbx2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qo+jhoEy72K/RYzuIJDxt5VR9VTFn0usl5DEnxZFK8guzfiPuCjf9BBX3D8UInuPccT67JjMR757HVIcDbfNvtQl1Ch3IR90582G2eOHvXV6N66WeYmQGMnQD1izRROwDzL87rxlyDQ8AehwQdJk2ejSaUjKOo4S+1pNRZ0glzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aMgSqsC4; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso98629139f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 15:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708470449; x=1709075249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9x2CUPvUFUUko+dVNH1Y/5ad8W+x8zRKELcvKfDncbs=;
        b=aMgSqsC4jeQx6Cf0PWKk3p850ojupYtLxAg9Nf3C/yq8BRp+O3Z0XE+OYBm6pc5mmk
         D8uvxuNtiPoM+1EwdxtpSWa2NkQOMNoGXS8vdUyYbMF95ABbyvWbco18/oymczgU0X82
         GK1HkDH+BeZSN/RRmu7pZtjbYwvkxxjYWMBuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708470449; x=1709075249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9x2CUPvUFUUko+dVNH1Y/5ad8W+x8zRKELcvKfDncbs=;
        b=uw48qHhe2tJ4BvLsNEPS1XKPTcZva03fa2DEeRC3fan06K2MuMmsdss/Uzc7TURpT5
         i5eNTeVo5WpNLDi7EWLReNCLdQxgdVPxJeDGY3H0WoVh6IzarbNONDsEZ5K63HfvCM54
         w9AxOXJnlDRhBVjhrOn+jTsOM7JZwWslFFFkm3SNvSiaglgnqMlShAsLTnKTW7UVFBCU
         HeQ9fumhrC58UEQRetx3YWWAp7FYSY+9QNjlZSNfK0fQ8I/BLxyOGhK/yMZnbZD1Od/I
         YYqovGxYmbA4QZCKZFX1FNbRprV5FdV4f7/GIbXgKvp99g7jRixmJsy1vNwFonRvylLZ
         IeWA==
X-Forwarded-Encrypted: i=1; AJvYcCVUqDOM9mlZnv1EoinCIzoSo5+EYM+E1e9HQfgt48q73l6wRJ9y49k6cFfa9z1uPYRkjxvSYrKk0MSQkfCQDg6r19DoKXkfb0U6bwZw11t7
X-Gm-Message-State: AOJu0Yx9liAiQehZPiG43L1KzCd+VIfCimvPcc3U06r7Cg+i/4Ute9a2
	wimP6Q6wRYH+tsymo5jQ0VWlXYkHsunx6LIExF7zP+W1jODbJm0UfeHriU02WPQ=
X-Google-Smtp-Source: AGHT+IF8qVAf6CmBpwXsy1pUXIlHU919CQ+KUf6sP/gKuYif37kpL2xFgo35WqEMwBcV6ZKD8DuBcQ==
X-Received: by 2002:a05:6602:1d47:b0:7c4:655:6e05 with SMTP id hi7-20020a0566021d4700b007c406556e05mr15344624iob.2.1708470449710;
        Tue, 20 Feb 2024 15:07:29 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id t125-20020a6bc383000000b007c4926ebed8sm2649012iof.40.2024.02.20.15.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 15:07:29 -0800 (PST)
Message-ID: <bd0abacb-e0d5-40f5-b786-6021f6d8bd2e@linuxfoundation.org>
Date: Tue, 20 Feb 2024 16:07:28 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.8-rc5
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Guenter Roeck <linux@roeck-us.net>, David Gow <davidgow@google.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Matthew Auld <matthew.auld@intel.com>,
 Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 kselftest list <linux-kselftest@vger.kernel.org>,
 KUnit Development <kunit-dev@googlegroups.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <CAHk-=wi8vZD7EXZfob-yhfDERyfzWxzMOzG9FsOuaKU-v6+PHA@mail.gmail.com>
 <538327ff-8d34-41d5-a9ae-1a334744f5ae@roeck-us.net>
 <CAHk-=wj6xj_cGmsQK7g=hSfRZZNo-njC+u_1v3dE8fPZtjCBOg@mail.gmail.com>
 <CAHk-=wgJMOquDO5f8ShH1f4rzZwzApNVCw643m5-Yj+BfsFstA@mail.gmail.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAHk-=wgJMOquDO5f8ShH1f4rzZwzApNVCw643m5-Yj+BfsFstA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/24 13:16, Linus Torvalds wrote:
> On Tue, 20 Feb 2024 at 11:57, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> It turns out that that commit is buggy for another reason, but it's
>> hidden by the fact that apparently KUNIT_ASSERT_FALSE_MSG() doesn't
>> check the format string.
> 
> The fix for that is this:
> 
>    --- a/include/kunit/test.h
>    +++ b/include/kunit/test.h
>    @@ -579,7 +579,7 @@ void __printf(2, 3) kunit_log_append(struct
> string_stream *log, const char *fmt,
> 
>     void __noreturn __kunit_abort(struct kunit *test);
> 
>    -void __kunit_do_failed_assertion(struct kunit *test,
>    +void __printf(6,7) __kunit_do_failed_assertion(struct kunit *test,
>                                   const struct kunit_loc *loc,
>                                   enum kunit_assert_type type,
>                                   const struct kunit_assert *assert,
> 
> but that causes a *lot* of noise (not just in drm_buddy_test.c), so
> I'm not going to apply that fix as-is. Clearly there's a lot of
> incorrect format parameters that have never been checked.
> 
> Instead adding Shuah and the KUnit people to the participants, and
> hoping that they will fix this up and we can get the format fixes for
> KUnit in the 6.9 timeframe.
> 

We will take care of this for 6.9

> Side note: when I apply the above patch, the suggestions gcc spews out
> look invalid. Gcc seems to suggest turning a a format string of '%d"
> to "%ld" for a size_t variable. That's wrong. It should be "%zu".
> 
> A 'size_t' can in fact be 'unsigned int' on some platforms (not just
> in theory), so %ld is really incorrect not just from a sign
> perspective.
> 
> Anyway, I guess I will commit the immediate drm_buddy_test.c fix to
> get rid of the build issue, but the KUnit message format string issue
> will have to be a "let's get this fixed up _later_" issue.
> 
>                Linus

Thank you.

-- Shuah


