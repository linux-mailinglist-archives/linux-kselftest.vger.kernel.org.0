Return-Path: <linux-kselftest+bounces-18139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A75CC97CBF4
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 18:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA63C1C20CDA
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 16:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5150319F489;
	Thu, 19 Sep 2024 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nbn3ddoZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF1319EEBF
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2024 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726761717; cv=none; b=Ix8qe3Ar1jsMLeP39NyTzx7PvuVHz3xJpSop+DpUAPm7ZMxiv7CwjQm+vif9FLZkChChwn7YUvTeqjotbLxk6soPaI4MRRcmgdbP7RjdlY1W/Bxy3E1/VrtcDZaKqhDtk6eQaLIZ1MJYTafxjuP2vK2kpApm/20cLpqBV76ESng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726761717; c=relaxed/simple;
	bh=cpJFeFr3Q9I7szQagFKASX5ieMYKw9TQeZYUEZA6+Qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZvLOIrYg+NyoxTHWMDLe4D9PPtPzHPNVmC+pF9lb8GJ+x7iXZuuoJ/U64yKHWqgyhlLQ5bG3rFipI5LCDU62aXmDVQ3vCbZc61Bd1CiuAVtvGRYqrKfR/PduUNFjQ8uBlKGo1aLD9NLi4HkS47AMHbEIjj3nKlNX6UMXf2nl+lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nbn3ddoZ; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39f526fd19bso3950965ab.1
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2024 09:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726761714; x=1727366514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hf+LsicU5kfxn2tpKhkFH/ZcN5QJYed0eVtFtXBM19w=;
        b=Nbn3ddoZzzBKImVr8EDmyVp1pcNrFBcLG9bIi5PEFTlfc5RhuUxLVbTN3Ew0d9uNVO
         JfEvHsD2PWZpzyp86lAxiLbduWFVI07hMLOBomYFDXPX5aQodGBC3u9ipYLxJTuWY+Nr
         NIc6M9+AdH7kvzvruHbSLVY+R2I9l9qeJrTKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726761714; x=1727366514;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hf+LsicU5kfxn2tpKhkFH/ZcN5QJYed0eVtFtXBM19w=;
        b=dyereEq9MwyYbViIcYW7xLFGYXc9fFsTovod0/78gh6zdh07aRdmUqhduIPZG9/v1e
         IUMaQiv/HcrGJY0MstcV7z2aKh0SZE/nozE6Qu6fNaK6mpCgTYDx1BFWciZambCzh0Mo
         DHynfP3IR+6W5zKRsr805Ig1V1UL7HZyFbQMT5My3Ji6pFd1VBW/mZgFKYbDQ0WXm9ee
         c6Dv1jNjzrB/YV233lz/kSuwQTjVLDoQMK9xuGqguLgDYHez128cgwTNOjzO+W1aiTeO
         dIvi45zuYdOOroaVxiLtU24iMVrzEVIdhcW3igksNQ/ULE2zIMTDiw8k059aK9Blzyrk
         QNrg==
X-Forwarded-Encrypted: i=1; AJvYcCVbD+NjHvBjwhcbVYfxmp1NdrNpa9kjFYWHWKRnF9fBzNhJ0bPrDqviqup5EquNKZiSMM7LI/qFqrJPhNx385Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlLm1IP2qPFqwoRV1I6A2vd+7LLU3A9KykfJgt0V44FDQ53rsK
	6cAMXA7tK4nCQrojAx2Xm3blTh6qmuQw4K09sk7OjFVwxnZ3AqFJhi8FzTHDydo=
X-Google-Smtp-Source: AGHT+IHfDnCPZjd75IkE+J/Gi3J6YMDrXBv/k81CP1ouQYZ6tsGogqyqq6qhv3icghhWDzOT2fHdPA==
X-Received: by 2002:a92:ca08:0:b0:3a0:92a4:a462 with SMTP id e9e14a558f8ab-3a092a4a67cmr184506265ab.10.1726761714157;
        Thu, 19 Sep 2024 09:01:54 -0700 (PDT)
Received: from [10.212.145.178] ([12.216.155.19])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ec17e9bsm3017456173.53.2024.09.19.09.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 09:01:53 -0700 (PDT)
Message-ID: <bd5eb792-124f-4eaa-9ff9-a99765d1ef73@linuxfoundation.org>
Date: Thu, 19 Sep 2024 10:01:51 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] Add KUnit tests for llist
To: Artur Alves <arturacb@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc: n@nfraprado.net, andrealmeid@riseup.net, vinicius@nukelet.com,
 diego.daniel.professional@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240917005116.304090-1-arturacb@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240917005116.304090-1-arturacb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/24 18:51, Artur Alves wrote:
> Hi all,
> 
> This is part of a hackathon organized by LKCAMP[1], focused on writing
> tests using KUnit. We reached out a while ago asking for advice on what
> would be a useful contribution[2] and ended up choosing data structures
> that did not yet have tests.
> 
> This patch adds tests for the llist data structure, defined in
> include/linux/llist.h, and is inspired by the KUnit tests for the doubly
> linked list in lib/list-test.c[3].
> 
> It is important to note that this patch depends on the patch referenced
> in [4], as it utilizes the newly created lib/tests/ subdirectory.
> 
> [1] https://lkcamp.dev/about/
> [2] https://lore.kernel.org/all/Zktnt7rjKryTh9-N@arch/
> [3] https://elixir.bootlin.com/linux/latest/source/lib/list-test.c
> [4] https://lore.kernel.org/all/20240720181025.work.002-kees@kernel.org/
> 
> ---
> Changes in v3:
>      - Resolved checkpatch warnings:
>          - Renamed tests for macros starting with 'for_each'

Shouldn't this a separate patch to make it easy to review?

>          - Removed link from commit message
>      - Replaced hardcoded constants with ENTRIES_SIZE

Shouldn't this a separate patch to make it easy to review?

>      - Updated initialization of llist_node array
>      - Fixed typos
>      - Update Kconfig.debug message for llist_kunit

Are these changes to existing code or warnings on your added code?
> 
> Changes in v2:
>      - Add MODULE_DESCRIPTION()
>      - Move the tests from lib/llist_kunit.c to lib/tests/llist_kunit.c
>      - Change the license from "GPL v2" to "GPL"
> 
> Artur Alves (1):
>    lib/llist_kunit.c: add KUnit tests for llist
> 
>   lib/Kconfig.debug       |  11 ++
>   lib/tests/Makefile      |   1 +
>   lib/tests/llist_kunit.c | 358 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 370 insertions(+)
>   create mode 100644 lib/tests/llist_kunit.c
> 

You are combining lot of changes in one single patch. Each change as a separate
patch will help reviewers.

Adding new test should be a separate patch.

- renaming as a separate patch

thanks,
-- Shuah

