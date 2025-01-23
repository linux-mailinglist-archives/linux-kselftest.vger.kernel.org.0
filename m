Return-Path: <linux-kselftest+bounces-25010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F738A1A596
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 15:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1583AC5BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 14:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEA921149C;
	Thu, 23 Jan 2025 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vvlx3XyL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5186020F98A
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737641795; cv=none; b=uBDKIqxdPokCqzajkmzkRRpU2fMv5SBkSx41RbSWuSThbcyMhBsSOyCaksyiWiB+GjM2o25HEZ0zWoGOHMproGi9z72wMq6a1XmMzhvupunxuQJ2aNfeGnA0jtC4AdIjvYh+nSILTE+AmSfysFET/3vkK67RVbfjwuH6aZ8OJtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737641795; c=relaxed/simple;
	bh=6V3W+o+MWoic0jA4thqpS40vCUdZ/uudiQaYYdeTdEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p4ZpPUT7XbKUJ7aI+7DpMRIPJdcfmd6x6Y8Z5HnV/BBg+hqJ9Tq2H1RSjzzbUrBelZcdxvV3UBRGBahPQcn2+FhnWuiLNKQ5KFIB8FJ059i4Zd2IKfzP15Ugn1TDPdHMlVCsGfn9ZY9iZF0oyj1KVsXWN8zZgf+fMi2zy3F4L+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vvlx3XyL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-436345cc17bso7128565e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 06:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737641791; x=1738246591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QDz8608lNaW0P9BTT1X9DLek8Kcys+jnF/tb6a9Lcbw=;
        b=Vvlx3XyLK269fz/1nd7DHEn9lt1dWkSZnvM3xyPmFiKFF3X7dyXNsy6zu1opJhq7hC
         aDzl/gHg/lgksQ7mvGxoZtK1t64sNknbAsP2AKTTG0qLPQvwYo0mMfWfRGUWfMxznEAl
         agVvTe4A6e+RzelX9HSh3Z4N6LqWh11u5I0TllfBz+yxao2lU4djR1AFhjAVrqKPf70l
         ycH2feDrUvUqlXoAKSnCAHfjjSEyUANOkvsYkjSD03bdgkiCkq2tURFxWbFvoMBUdSei
         NpI4Z7cJqZEmT5ecg1EdCDgX4NisstLkbn/QYeQAh0Qe6CwOEnJBSOol0JlW/9lOgELI
         uFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737641791; x=1738246591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDz8608lNaW0P9BTT1X9DLek8Kcys+jnF/tb6a9Lcbw=;
        b=Af25BYuPh/DkNq/JumEdGGkIb4SD0u4/eAFzxH4ySHb8loqB4SrZ1Pb1WoaTGI9POp
         +XUG1KSingFDHZx5SLSZuugFRb5EJG/f1kDilY5DGbVLewsQ3vwYBZsopRQUG8N+UsOS
         FHJx2EnB0Y1dwGvC5zXTMc3saf2unOCoAcsxFNOTWCeJu66D3clpafPIc1/lNgp41+TX
         gmojC64zUO5s+5p/vg76CRXWknARlPVKEDOPZ9D1lIcEpGsen6x180/BlUoiYlZl2R9/
         tGOvtMDuGVIld7zhnAtAyxR3oZugv/hXUVCFPjY0Cg1tVZOu8hRyQ2y3qhaMwjwM96tQ
         tEPw==
X-Forwarded-Encrypted: i=1; AJvYcCXX9U3Ry0JF8O5SDAhTgeX+J10Z8okFrHvjGUc1IWTXLFVQnVDCufS0GB+yF5B6wg+zroGLF9VeJMIbR9KhjRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGDJe1WUOJpdGY1CqlFp5RaRDKs2RmKXbJORu75mMR6aAe9MDY
	KfpqvrlBYYQ+SgNp62K904qfKOPMVTMJ6eS8zW6B4hSQeqp0ukrFcL42/rSyEaE=
X-Gm-Gg: ASbGncudKbNZ3Ryf/MvwdvtIXOOSoofXdwSfNim4bK5YWgt8yBjSvKG4NVKhPznJUdV
	n79wj7WJPPnFkYS5GGKaorpGf6IZhh9uy2gQayD6Z4HPq6VlAapcJcP7rp9qFJhjccUJTyAIq+/
	7MHFTmnKHg15jQi3XAiRHEs5t5Z5ldTHxy/+Zk4925kx1/SqQ1gl+LeNq74hgqUkhfvnjvbTJrS
	qF1XuLw2FaW59G37z2wvIVmQu0qBEOWRnMY/9LPCK4QOEJpCU7qoeuTGqKQj524LudAHys/wKDi
	6iK83H1d
X-Google-Smtp-Source: AGHT+IEZ3PnxYGUvf8/rU964wji50OH+SsshrvGk6eo7bEmtZzJZRo7kuLNRZ25HdqIFvqguWQOL1A==
X-Received: by 2002:a5d:4243:0:b0:386:2a3b:8aa with SMTP id ffacd0b85a97d-38bf57b3f56mr16813575f8f.37.1737641791528;
        Thu, 23 Jan 2025 06:16:31 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3275595sm19543698f8f.67.2025.01.23.06.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 06:16:31 -0800 (PST)
Message-ID: <4a9ca024-fc25-4fe0-94d5-65899b2cec6b@suse.com>
Date: Thu, 23 Jan 2025 15:16:28 +0100
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
 Petr Mladek <pmladek@suse.com>, Petr Pavlu <petr.pavlu@suse.com>,
 Rae Moar <rmoar@google.com>, Richard Weinberger <richard@nod.at>,
 Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>,
 Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>, kgdb-bugreport@lists.sourceforge.net,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-um@lists.infradead.org, live-patching@vger.kernel.org
References: <20250121095739.986006-1-rppt@kernel.org>
 <20250121095739.986006-7-rppt@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250121095739.986006-7-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/21/25 10:57, Mike Rapoport wrote:
> In order to use execmem's API for temporal remapping of the memory
> allocated from ROX cache as writable, there is a need to distinguish
> between the state when the module is being formed and the state when it is
> deconstructed and freed so that when module_memory_free() is called from
> error paths during module loading it could restore ROX mappings.
> 
> Replace open coded checks for MODULE_STATE_UNFORMED with a helper
> function module_is_formed() and add a new MODULE_STATE_GONE that will be
> set when the module is deconstructed and freed.

I don't fully follow why this case requires a new module state. My
understanding it that the function load_module() has the necessary
context that after calling layout_and_allocate(), the updated ROX
mappings need to be restored. I would then expect the function to be
appropriately able to unwind this operation in case of an error. It
could be done by having a helper that walks the mappings and calls
execmem_restore_rox(), or if you want to keep it in module_memory_free()
as done in the patch #7 then a flag could be passed down to
module_deallocate() -> free_mod_mem() -> module_memory_free()?

It is at least good that MODULE_STATE_GONE is only set in free_module()
past the sysfs teardown, so it never shows in
/sys/module/<mod>/initstate. Otherwise, this would require teaching kmod
about this state as well.

-- 
Thanks,
Petr

