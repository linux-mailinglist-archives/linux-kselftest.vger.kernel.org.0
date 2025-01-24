Return-Path: <linux-kselftest+bounces-25093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53726A1B677
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 14:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB3BA3AB264
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 12:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCF88488;
	Fri, 24 Jan 2025 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BGbtSYPC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4288635951
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2025 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737723601; cv=none; b=SXgFzNay58wWztSlhlNCDtUuPDmrNGOq97XgE2HM+MAyFVpFaPkzDWLGVPJp7BdtQpKKIeKsJz65cqY0xruUkGAthHPRvHKE4KbR4ChvQq9P4PIPmEq0qsw1o3IgxRspxIdRQLxXAVnquvOm1ysbWqatiGmig6eO4rFsMi/LYF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737723601; c=relaxed/simple;
	bh=048+X1MOxQiKIP2lifMdZPmBKfc4MBq+0baHP1eRuak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmWz9MfeMxhV74O4+dDB3OU1Xr7I7+45on9iqUB+wRmBSs0GsGpRbsP6gll9VzTPj0oZnsvoa5C7iN/NT+abQy29MiytVdKvMecW4Wx9T6pKY+2iurIGJhiBzE5snKwCONvbdDU6CZzliY8J/VSZLxUmBqoRyLiSmfyFAcWSuLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BGbtSYPC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361815b96cso13981795e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2025 04:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737723597; x=1738328397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y4p8V7L+SybE9UNVkk/PglJRrxpw6EHRMFcIJ2bc0MU=;
        b=BGbtSYPC7sMV7QowIyTnnRudLohDj4MSK+t1pcHS+UdVJoQfIIxlXW9sDjsmJgf970
         w/y2bUnqkb/BRWgclxfMzz8DpVNilOeiU+hN9G24HA3L+fdN4s/BOCAT8T9wrMh/XSOG
         jEltks+RqiEf1u1vX9pP+ZNMvM/JYUH+MgfD1XO31b0vpbcgLoBptdOY/GB5m1MhwlgP
         Nn4NuruQfjH5E26whSVpbkg5znAsIktGv5UL8y27ZC5qAQpjVcg2e/zfLD75AMagnVKh
         5SSN4at0OeQjkny8fc9YufHDd9n272NmsFYxZFx1S79HjZ8YwNLqV/7i5m/nhnA/MZq/
         TNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737723597; x=1738328397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4p8V7L+SybE9UNVkk/PglJRrxpw6EHRMFcIJ2bc0MU=;
        b=woHzaW6ZQY2b/D/E2wkGjvHJmPt8rdhMJI5/tdQgEbZphWhp0l4bF71JV6qk9RuuCn
         RdUSUroLUdbhyICO8kYc1eLV70ElqVKfq5ZVWhW1XXU6PEE/nshpnEfnRPm3S1IG0cwa
         OozZzent2jf+dI1psevIr2Hx3016kXnFgTAc5WMU168f0b33vWcvBUWd/B6MVfJoj30m
         qbuSPfjroxkF562dNGnOpKvptOiji0XR93dm94bxH6g+LXkzFNFhvOrdpJX96maRhQB1
         JGQZjYnjAHaVvoB6yuMSj+3DrkmcpEAesL701ruKZ0hfxHxCghWuhjzw8Qydmyz1UCV5
         UDLw==
X-Forwarded-Encrypted: i=1; AJvYcCUZvWntepG8hQRyW7MK0Md1CmtTRxqrEOR0q/Fr8w0spdafBy+dKgs3NEyc+/zS2FXRO+6lE8NFGZAvGr8tLxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK4T/RoQXRu4jKucHje7boNAwJTGhO/wDerRRDvMyGVhya08n7
	z3rYvKOY9qaoonO4Ci5Oz5KGOML3p7JkUunKtt9fWiA2oEwDZl44+ehgfPBdrzU=
X-Gm-Gg: ASbGncstZ6xkf3Z1dPgcQXYIbAGVW9gdTjSVqz7ScD2izWpsEYqS90ZpOKqHACH8YDj
	B8OnE87UNFkivkpIdJbXrn3LDs43WSVmp+bfJAzaB8nnx+CuHTlZVRk+l9uhgs0FgwjLUbAqIbR
	wRnYt1ml8tWQ8dFB+7FXGh53YrsbqvxsL8UC8Z33jVvJdkBtyaJgvTq8TcvV9gTMGCIObQvr2ld
	6pU7wYAnDZJgHWj6PwDenup/2DG9cl5C63s5L10I3QJ9DyuJyfWI+Q2jNu/wpELO9TRvT7awywu
	n56w7VWjasgkyt6uWZE=
X-Google-Smtp-Source: AGHT+IEDbDZN2m5CHXDDsa3oj6Ebp9OHdbtruLTcN0mhHSAJojPcoO/LDhDZ6xjm5yK5+6pSh7FY3A==
X-Received: by 2002:a05:600c:63d5:b0:438:a46b:1a6 with SMTP id 5b1f17b1804b1-438a46b0388mr219468875e9.18.1737723597250;
        Fri, 24 Jan 2025 04:59:57 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd501721sm25207325e9.9.2025.01.24.04.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 04:59:56 -0800 (PST)
Message-ID: <8c6972c4-c1bb-402a-a72d-f92b87ee5a89@suse.com>
Date: Fri, 24 Jan 2025 13:59:55 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] module: introduce MODULE_STATE_GONE
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
References: <20250121095739.986006-1-rppt@kernel.org>
 <20250121095739.986006-7-rppt@kernel.org>
 <4a9ca024-fc25-4fe0-94d5-65899b2cec6b@suse.com> <Z5N0UVLTJrrK8evM@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <Z5N0UVLTJrrK8evM@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/25 12:06, Mike Rapoport wrote:
> On Thu, Jan 23, 2025 at 03:16:28PM +0100, Petr Pavlu wrote:
>> On 1/21/25 10:57, Mike Rapoport wrote:
>>> In order to use execmem's API for temporal remapping of the memory
>>> allocated from ROX cache as writable, there is a need to distinguish
>>> between the state when the module is being formed and the state when it is
>>> deconstructed and freed so that when module_memory_free() is called from
>>> error paths during module loading it could restore ROX mappings.
>>>
>>> Replace open coded checks for MODULE_STATE_UNFORMED with a helper
>>> function module_is_formed() and add a new MODULE_STATE_GONE that will be
>>> set when the module is deconstructed and freed.
>>
>> I don't fully follow why this case requires a new module state. My
>> understanding it that the function load_module() has the necessary
>> context that after calling layout_and_allocate(), the updated ROX
>> mappings need to be restored. I would then expect the function to be
>> appropriately able to unwind this operation in case of an error. It
>> could be done by having a helper that walks the mappings and calls
>> execmem_restore_rox(), or if you want to keep it in module_memory_free()
>> as done in the patch #7 then a flag could be passed down to
>> module_deallocate() -> free_mod_mem() -> module_memory_free()?
> 
> Initially I wanted to track ROX <-> RW transitions in struct module_memory
> so that module_memory_free() could do the right thing depending on memory
> state. But that meant either ugly games with const'ness in strict_rwx.c,
> an additional helper or a new global module state. The latter seemed the
> most elegant to me.
> If a new global module state is really that intrusive, I can drop it in
> favor a helper that will be called from error handling paths. E.g.
> something like the patch below (on top of this series and with this patch
> reverted)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 7164cd353a78..4a02503836d7 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1268,13 +1268,20 @@ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
>  	return 0;
>  }
>  
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
>  static void module_memory_free(struct module *mod, enum mod_mem_type type)
>  {
>  	struct module_memory *mem = &mod->mem[type];
>  
> -	if (mod->state == MODULE_STATE_UNFORMED && mem->is_rox)
> -		execmem_restore_rox(mem->base, mem->size);
> -
>  	execmem_free(mem->base);
>  }
>  
> @@ -2617,6 +2624,7 @@ static int move_module(struct module *mod, struct load_info *info)
>  
>  	return 0;
>  out_err:
> +	module_memory_restore_rox(mod);
>  	for (t--; t >= 0; t--)
>  		module_memory_free(mod, t);
>  	if (codetag_section_found)
> @@ -3372,6 +3380,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  				       mod->mem[type].size);
>  	}
>  
> +	module_memory_restore_rox(mod);
>  	module_deallocate(mod, info);
>   free_copy:
>  	/*
>  

This looks better to me.

My view is that the module_state tracks major stages of a module during
its lifecycle. It provides information to the module loader itself,
other subsystems that need to closely interact with modules, and to the
userspace via the initstate sysfs attribute.

Adding a new state means potentially more complexity for all these
parts. In this case, the state was needed because of a logic that is
local only to the module loader, or even just to the function
load_module(). I think it is better to avoid adding a new state only for
that.

-- 
Thanks,
Petr

