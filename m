Return-Path: <linux-kselftest+bounces-25296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC6EA20891
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 11:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0346B1887BC6
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 10:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D18419D8A7;
	Tue, 28 Jan 2025 10:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U4paw1zD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A69919CC05
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738060302; cv=none; b=n8e95tqL7NdmtBoH9TLfPwdtUN6U49aD3DUjRcvP4HYO8kVNMxkeKCWZJ+usc4NR+9575CZvGaDwQIb6HHX5a9i8aFI7rRaWoI88IP1+wKohf5XBOgrAB3taaknu/zjq3bSGk4eNUDOSku9chiV4eA78r9Spfeh49aQVfqxRLvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738060302; c=relaxed/simple;
	bh=NagYAn2TrqtC5b5RwfDanYg+3MCbHeG3S0GDa3m3CQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5y9g5LcAu1UOC4mG20AQEmo6jI/w4okDUjpaHF2IKiMiIWeNkanMNmhocB6KDi2+rXFVByojZ+EFtBK9An94HT0brBEhnKAKMcUB+PeGkK3WfwYAeGQ2EexAB6ZCuj2th/edqLjiFtsoYsNvEs8OaAoy2EemQXMrucqPjZ935g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U4paw1zD; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso4623450f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 02:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738060298; x=1738665098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2XyAQrOTcI19ilumWSMw1hLrZQh31wPEOX9kHRV/Kjk=;
        b=U4paw1zD7zZ0EQCavCRc+K4qb1TkN59e/bubDOIcft/E9ttjtgYKhfOvOvV4VAMzuh
         fYhqXIs+Ula0utsFTmsAs/54YNeZKJ+ik4WteQ9mhJUZU3hNJgPzkhscdspu0Ci1gZWw
         qm74QuMeUTn1BKz3sppaNQHaA2kiZi9E1X8CNwUHLB1+wnPUCRGYvXO0lBas438yxvtl
         SuUcoyTZ89rKq0yhAsD9SZy3E8/ic64RHuNJCj5SX8ZKlgYMSDjxXEOu6os5RNd5IYSY
         bmhIHPFNUQCUZozfqk9+mYANoUoO7xn8gQ91h4KTqb2NgcxuHpX0eHNuBXRIunYvWERn
         dJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738060298; x=1738665098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2XyAQrOTcI19ilumWSMw1hLrZQh31wPEOX9kHRV/Kjk=;
        b=f6iHk0GhdWNpMI++rJTV+UnUkk1/Z9dxim5leAFHGfM70uokCOvvfFAhOoAw/45jKt
         ocxITLhoO3tUqmpj1f6GBeDRR9M6mCGD3D6bWXcUNIG+OePIN9nE5rJMgrq92T33c7Fm
         5BnNUWYlS+4E72YL/xfUxZ6PQCGjte0ak77zxcLvaKnQq/JZiTRc8amXCbtZ21VZoJBc
         lL4opJ+TEngLLQ9KT9GNuNAqX0XRgtu3dVhKHfqzZCgV2tq9juUXleZTjNN6CG6XQe7p
         If3xXpCSkqAh6I+FsuMo6vUU/6UgDOEeG9UQJrJ9KayHi55gZJTrGL2Dh3LlXniqAk24
         p9hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQazzIYRUrfCXR2wh6Vc+4JC9YZBaLV92b+FW2jUt+lTP7pILr1As/siauC6aqB2EsLg1heFOsqfaW7mh2lOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxee7Ls8JlAfOXZYXhHi5FguLNPv4A7lpctLiwFl9OEaKagyzRa
	4MEXB06SPlyzAVKSYoCzG6XPMKUCoTIyPgS5YnWQ8qUM+74qAUol+PIiiyiEO8I=
X-Gm-Gg: ASbGncsuapBIHCZwgceMt3a7TAVZtXTKhK1iYOA5uXi8nFQbFzXRkAWx/VsYQNxiYx1
	/Y87cppUPR4TluwYlhX5m28er2RqQ4Jg+a0K8y4A0QMl5W+8KZIZfjlRyN5CWm7O0kerjYBKxm0
	dr7iFTjYn3tXN8pbQ6RyP7fcZG09CIkEB+Gf00YJHkKj0abEkgSeF4Icrl1mvBIDOrSWdDWmFpp
	F7nR9oE0ZdJfq40C514ah7gKjc/wNXNBozSb7dIdhzeohBAQj4uFRfdtztrPqJt5LjlQOdw2oVb
	Wwn0c9L93WJTwvku5Yc=
X-Google-Smtp-Source: AGHT+IF66ZZk/rhZtGcWoNDXw91fpPKUDEMFBtm8dpseiNoX9eGm2cyqqMp6iJGiup5xykF6TH0wXg==
X-Received: by 2002:a05:6000:1788:b0:382:3c7b:9ae with SMTP id ffacd0b85a97d-38bf56633damr43631218f8f.16.1738060298374;
        Tue, 28 Jan 2025 02:31:38 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a188d5dsm14110246f8f.55.2025.01.28.02.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 02:31:38 -0800 (PST)
Message-ID: <099b8e0b-2c64-482f-8c22-32afc5b21beb@suse.com>
Date: Tue, 28 Jan 2025 11:31:36 +0100
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
 <021665c5-b017-415f-ad2b-0131dcc81068@suse.com> <Z5iq2GJKIdlB9APM@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <Z5iq2GJKIdlB9APM@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/28/25 11:00, Mike Rapoport wrote:
> On Mon, Jan 27, 2025 at 01:50:31PM +0100, Petr Pavlu wrote:
>> On 1/26/25 08:47, Mike Rapoport wrote:
>>> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>>>
>>> Instead of using writable copy for module text sections, temporarily remap
>>> the memory allocated from execmem's ROX cache as writable and restore its
>>> ROX permissions after the module is formed.
>>>
>>> This will allow removing nasty games with writable copy in alternatives
>>> patching on x86.
>>>
>>> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>
>> [...]
>>
>>> +static void module_memory_restore_rox(struct module *mod)
>>> +{
>>> +	for_class_mod_mem_type(type, text) {
>>> +		struct module_memory *mem = &mod->mem[type];
>>> +
>>> +		if (mem->is_rox)
>>> +			execmem_restore_rox(mem->base, mem->size);
>>> +	}
>>> +}
>>> +
>>
>> Can the execmem_restore_rox() call here fail? I realize that there isn't
>> much that the module loader can do if that happens, but should it be
>> perhaps logged as a warning?
> 
> It won't fail at this point. set_memory APIs may fail if they need to split
> a large page and could not allocate a new page table, but here all the
> splits were already done at module_memory_alloc() time.

Ok, thanks for the explanation.

Acked-by: Petr Pavlu <petr.pavlu@suse.com>

-- Petr

