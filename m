Return-Path: <linux-kselftest+bounces-25228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4FDA1D632
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 13:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42CAC3A577A
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 12:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E601FF5F7;
	Mon, 27 Jan 2025 12:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PyQZLNMp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568271FC7ED
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Jan 2025 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737982238; cv=none; b=NmVfozwhqW1xy//zeZHZ2jgofApFvJR3Yu2VQ5j4/QP/xBm+1A2HllMW8GYA1QU9Skjh1MaJTQCbI7EgF9nB9lezJ3cOubFqZuTPjqE3Ey29rqPsc3jHKwjruAd8LBC4zAUAjWIuioC31vatxRyFPgO84pFPY32lQ+0CFwea2Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737982238; c=relaxed/simple;
	bh=HR4noXGU7w13ZIhOM/ucls8vVM3bhmVGGYLoZmvVDTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKTk4g0QVC+qOpIQrL2qOV4tnzDNQ/lYTaA/EkFWcNWu+WXP9vPqPQPW+YASU6zDBllPF0M9rHR8JwbMxdY2fAn/hQiX2SenWYp9kOXh1SySRaNEIqBk2zSK2lSOi1jOeSgEm+YPSsGpLsEfqdqC9D12x4d6l1ZwLIZA78kLFSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PyQZLNMp; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43618283d48so30801665e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jan 2025 04:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737982234; x=1738587034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VG6M7E++/3Ce9GXj2tezC00IBdvh1kteyj5hzR0NwA8=;
        b=PyQZLNMpcVv/C7aBWa3i52KmbAcnYmUFq8gKJojCHwVh04N4W5Jf8S5K0rmEWApHqN
         X93gpvF1GQFkJ1DFtHAoBHJckiAP3RU9fie6Xbw0vXq7ylpjHiww6RoOzN89jXFRN32x
         Q+wQXO+1zwxrvukDu9Bpe0dMNdQwux3a+D9Z7MeiiQ/3C2bb2wSSvV6EJfsbBYFcj3Ng
         vm2o+LlIeCdP/lHC7e0qSOdAB7FLP/OdrT9oyujN4J2gy6UMr7LlRiG20LsWk3jw8mJa
         cgtGJGcT5IRkhwdT7jYeDvhrlJzGBedfWqUbeGG8pNOlegM2Y/dhITi/KOJhQS2RQczD
         RWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737982234; x=1738587034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VG6M7E++/3Ce9GXj2tezC00IBdvh1kteyj5hzR0NwA8=;
        b=SDwOlozSrkRWIRYQKKJz6iy+99DTJCDioNgzxSdievcBj48EWld8cd9+v4UH+h7H+p
         pKjcrYX3VzBYNKdSRTFhdj/quK8dsb0q87SnDGhG1oDDrYW+50P0YMUhkdrS7rt/skur
         wqDyFrAjB+tsuTWDP+wBUaW+mO51hIZzs06Lb0/bwJ8whIDv5wSVt2DgUbDafhkp7FKg
         CsMDMxX1hRMS7wFvxhj43WMCdqeJZkGhPACjTEtc447LKM+JN/vAZOpE50+VylqKAe+N
         ngaXZLmR8BSHXQk2JBDgaKos1ypRkpnbk3p/qyjIHGf8vs5gVjPgKs4VDtHau7eqqhiM
         UdJw==
X-Forwarded-Encrypted: i=1; AJvYcCXIqZYj6Xy/ahpmJKl22xJh0acA1j3TiV0oQkwdXevWyNbHRy+dMq7S3mjwHxGJCo2gVvk+scXGeKRg0vgrsa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqGEES0eepWQjS3oAFUcs00zY0BInJ94R19k/xza8wBLBZrGcl
	i3gSlw0offYKr9ZiqYdI6Oi2/k/FdEPYTRdI/2qsuh3veJVKseuRa1QYfuNESaw=
X-Gm-Gg: ASbGnctZisfD+Uw9F4yIe57NxI/t5t9UEm3i/4eCGdgeaZ+xalxAlQ15ReeV1X/kJfZ
	PGzs36aACwJkYXgMJUyEOwpKkgFTr7L+XP0kHlcpd7MlqAdISdv0p1zM6/HZ/64LdRNtGH1I5go
	YD6tu6tvQIyABWVa//jTj0kHQu4UG0iJ1AduKg7wZfE/mdP/WDud1BkRGhlSyBHHHFEVo0iA4Mm
	t4j9a1qf//PWT4G5p2dFDgM+2SWisGjDAKXYB/bm1UW/5JQB6tl8M063jrn2090kJG6cszC6e9G
	4kyda+LZ
X-Google-Smtp-Source: AGHT+IHGKx5XPAjKkuM8tLdY/iEmI+lFN9vw68MEGkVKzufCkr8AVUadSDTJkGDjd3qRPKQy8gyy+g==
X-Received: by 2002:a05:600c:46ca:b0:434:a367:2bd9 with SMTP id 5b1f17b1804b1-438913dfd7fmr435221995e9.14.1737982233635;
        Mon, 27 Jan 2025 04:50:33 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd54bfb0sm128676475e9.32.2025.01.27.04.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 04:50:33 -0800 (PST)
Message-ID: <021665c5-b017-415f-ad2b-0131dcc81068@suse.com>
Date: Mon, 27 Jan 2025 13:50:31 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] module: switch to execmem API for remapping as RW
 and restoring ROX
To: Mike Rapoport <rppt@kernel.org>
Cc: x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Borislav Petkov <bp@alien8.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 Daniel Gomez <da.gomez@samsung.com>, Daniel Thompson <danielt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, David Gow <davidgow@google.com>,
 Douglas Anderson <dianders@chromium.org>, Ingo Molnar <mingo@redhat.com>,
 Jason Wessel <jason.wessel@windriver.com>, Jiri Kosina <jikos@kernel.org>,
 Joe Lawrence <joe.lawrence@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Petr Mladek <pmladek@suse.com>, Rae Moar <rmoar@google.com>,
 Richard Weinberger <richard@nod.at>, Sami Tolvanen
 <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>,
 Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>, kgdb-bugreport@lists.sourceforge.net,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-um@lists.infradead.org, live-patching@vger.kernel.org
References: <20250126074733.1384926-1-rppt@kernel.org>
 <20250126074733.1384926-7-rppt@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250126074733.1384926-7-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/26/25 08:47, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Instead of using writable copy for module text sections, temporarily remap
> the memory allocated from execmem's ROX cache as writable and restore its
> ROX permissions after the module is formed.
> 
> This will allow removing nasty games with writable copy in alternatives
> patching on x86.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

[...]

> +static void module_memory_restore_rox(struct module *mod)
> +{
> +	for_class_mod_mem_type(type, text) {
> +		struct module_memory *mem = &mod->mem[type];
> +
> +		if (mem->is_rox)
> +			execmem_restore_rox(mem->base, mem->size);
> +	}
> +}
> +

Can the execmem_restore_rox() call here fail? I realize that there isn't
much that the module loader can do if that happens, but should it be
perhaps logged as a warning?

-- 
Thanks,
Petr

