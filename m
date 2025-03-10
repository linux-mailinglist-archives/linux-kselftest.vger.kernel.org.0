Return-Path: <linux-kselftest+bounces-28648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B701A599BD
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 16:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0643AC05E
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 15:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32BC22F15B;
	Mon, 10 Mar 2025 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="w8lH1Kbv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B577227EA0
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619881; cv=none; b=H5Xgb+h03AT+yj5jqpmLGZfVaMGpYGBuK15o/yyHmIR9kpO9LSyqb14fKz8zZB43oKba0jmmfe2wz8PrNCh+4iKvGsLqP3zgbf2XXHuW+vFBZ/UhwB370r57ZMpezhYsxIgRObRcC1ccgOV6RsNsBHZ5MI+wNOFcgS6Kq7DpJv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619881; c=relaxed/simple;
	bh=x7cI/8nUBvDIXlw67CxmYU0KDbq1pXrHOJpQbPVzGZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UW4Q+JNftDSqW6aQk5+Qhz37KHU2sr5TJmNy4y2IqefhwTpkxTKgyEoHaC1ZvVG5Nz8KUfAPcY94c3jW7+TxSeimh2Wh18OtX7H2js4liUHeLD4hnX4s4M60hqr6HbRWluXtOaxifN823jG26WAh1y9ymTmEKURNbs09ppoh+eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=w8lH1Kbv; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d4496a34cdso5549475ab.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 08:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741619877; x=1742224677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iFI5CNZ7ypkf6nzIklavj71fRclQxpBXGT5mnCzliiA=;
        b=w8lH1Kbve4aFuEHGM6lz195sAuOqeeug608K0UiT5mpHLJgNqZfM4v5Fl9Ihwi8azA
         oR1kRAJLZ5o9pd3JlrEW/TJ7pbq9vIG64zhLQ+1RYsQQJUzfaESiKTpOaCn3e3azlQF/
         PAPAeRWX8l0Ez1MeztNBKvciLVOzdmovGo0ASLHQ0BXmWNhmbZ3KcZI0E0a4P+YZ4wDb
         2QyW+rFwbGZCG8MZFFQQLWbedx03QKqnPh9cV4yvu3G0L3matrFhPfyxm9t/FDF2KJZW
         c2RpwMhFU5BLg/P3+i0GZ6M2X32qWFHBvDLw+MHqfZys/ZgK92xXnyAUXbKgpZyDZ9UO
         XvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619877; x=1742224677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iFI5CNZ7ypkf6nzIklavj71fRclQxpBXGT5mnCzliiA=;
        b=EZIagCyccxanxP56qQ6RrdlXG13g7Bbyb2e2nDvUAnEE9Av0VgUUkM6btxbAT2kIp6
         XKDANrl8LUgQYKGrvrcC60ExPO2Rmho6VqvREld8IzxxLg/XZ2ZDxbKZv0VYZhlOV0qh
         k/e3yS6/RIE/2Nmx8WjzWnWFf+Y1eEqPdcwV3JupfuSUDqdvyXRLXqde82N1shyXJxC9
         fX6slyPjJDGDDwtPvHtaNE5xqwnL7TKttk5u0MYeDy7jjo2OV1KMMlpv7/1dEl3e11nP
         FyBhrtDoI3XSKcnBcK4+R4wieGkXkNJ2ieEw1fOdbKWSqj30SvT52pUSFstwTGNUVHO+
         1hXA==
X-Gm-Message-State: AOJu0YzSE+VssbeANLQCVB6pu2vt+yGy9D3CtJEq+9HQ/jy+EH3xBbh4
	nb9q5NQmJPvgO/Lz/NST7yuIss5SKbENfZMMOlSQWAZedjHjaSkjSyf99EwvvME=
X-Gm-Gg: ASbGncsdEBZ6LEpd6ra9GUlnI9GqCNvQZPyLTnQNQyvkYlOHyxIbmWmLRRjkJ+A1mWu
	tzqGO10ILjghMautf8eLJIfMSAiJ1wpFHwxJHUzOKuCU25M4Kcmwwptgwf43uieVMwlT8nMrCQo
	JsQPyv7u5kQqM2dDS+FKwMQPD0m0xxEFLRH3kjuV/KnwfGh8f4p2pXcD0axfWP7jV2HHSaioV/e
	rIYG0h1Y8/XR0pcFRIYS+VuPdfB842is61Dz1M5pjOqzk/sLo91+WobytlI45uL0UrA2ZTc5klV
	YolytIiI3kKTUPjGUXi9DfhFFzLDFZu52RxcJ9e7joBDVc8FzMI=
X-Google-Smtp-Source: AGHT+IG8WEiNmKZXmzNssBoH4GEX3aThQEM0prs5cfp8Q/hzNRnZCn6/+Ek9xAgb+mAsNHaVEYgWVQ==
X-Received: by 2002:a05:6e02:3f89:b0:3d3:e284:afbb with SMTP id e9e14a558f8ab-3d441992552mr154286055ab.11.1741619877221;
        Mon, 10 Mar 2025 08:17:57 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f22e050697sm1041501173.78.2025.03.10.08.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 08:17:56 -0700 (PDT)
Message-ID: <95955f2d-6bcd-492b-9057-37363168bdf5@kernel.dk>
Date: Mon, 10 Mar 2025 09:17:56 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] selftests: ublk: bug fixes & consolidation
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
References: <20250303124324.3563605-1-ming.lei@redhat.com>
 <CAFj5m9+25+zUjUun12YvEzcH7NZ4eeJrq=p+7DYZ7kuasiDoqw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAFj5m9+25+zUjUun12YvEzcH7NZ4eeJrq=p+7DYZ7kuasiDoqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/25 9:09 AM, Ming Lei wrote:
> On Mon, Mar 3, 2025 at 8:43?PM Ming Lei <ming.lei@redhat.com> wrote:
>>
>> Hello Jens and guys,
>>
>> This patchset fixes several issues(1, 2, 4) and consolidate & improve
>> the tests in the following ways:
>>
>> - support shellcheck and fixes all warning
>>
>> - misc cleanup
>>
>> - improve cleanup code path(module load/unload, cleanup temp files)
>>
>> - help to reuse the same test source code and scripts for other
>>   projects(liburing[1], blktest, ...)
>>
>> - add two stress tests for covering IO workloads vs. removing device &
>> killing ublk server, given buffer lifetime is one big thing for ublk-zc
>>
>>
>> [1] https://github.com/ming1/liburing/commits/ublk-zc
>>
>> - just need one line change for overriding skip_code, libring uses 77 and
>>   kselftests takes 4
> 
> Hi Jens,
> 
> Can you merge this patchset if you are fine?

Yep sorry, was pondering how best to get it staged. Should go into
block, but depends on the other bits that I staged for io_uring. So I'll
just put it there, not a big deal.

-- 
Jens Axboe

