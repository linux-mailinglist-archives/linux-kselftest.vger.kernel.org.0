Return-Path: <linux-kselftest+bounces-19304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 821BA995B76
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 01:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7082B2129C
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 23:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A990F2178E4;
	Tue,  8 Oct 2024 23:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fWo+Fr9m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D61B33986
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Oct 2024 23:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429473; cv=none; b=jDGCnXrIuQ8iRmC7FZrEXDGiDbWEecZ5g+/Jizt/rd5GhMl8S8AE4ozR5T4MxvcBnoNY+dYafp3k/BHrZTJVnXSDZOAVmQLRLN/PjEQcL1Fz2VXC4mfVhLyv/bq83ppbxnk7muvI2a7NOSofqyEJgexhg4Yx1wC7p0Ry0z7Qp1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429473; c=relaxed/simple;
	bh=CzD38ZoFkgG9d1H2++XkkVz+Mfbolc0I0BV6YX0ZnoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFtpmp03KQi9+0AdwNH3YnaPxlZJeYAqSErZABN6nPIqpnFPc1FJMapPnY0zK15ohYShyq43x/NuMKPULfwB5PLjP0HH9fRb3Ro6kAqm/+drVY5LLmHisy9NdIOI7rb2dSoW/dVvhi0lxP+y4nLNtA8VR7BXr4SwqQm+hjmh1VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fWo+Fr9m; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7c1324be8easo215165a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2024 16:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728429471; x=1729034271; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=84oqUYHHA4jnRjNWhrPRTTubksgbEji8zyCvQWhxvkk=;
        b=fWo+Fr9mdBUeTJIbpXTTPPaL0wwvNmyvBm/204yPl2OuSoYkPhksT13m6iW7XoI3CV
         xTFvHgqwy3UP5RsdcBwjM0+GWAg6pFKzEOFNwWcYaX1CIbeZvno3g0R4z7C1pf0yhwAi
         dG9guae+6n74xhaw8tuTqokoWnFLlPdQLqc3MnMxc3Ir/DfSfnZ2pvF9fqPJoQ1C7mLY
         bJCjU9i1cp4Gj3YvMD85Hxa3GayE2igy1e5uEtKKdcFX/zKzmzHp3Kz5V6hB6/iEYtJO
         PYC93kDv9N8pXMgKslIiYiHqRmScaWHrhLpjxHcgMi+yZjXJqV/fN9nNMhznHyA5cJhI
         eZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728429471; x=1729034271;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84oqUYHHA4jnRjNWhrPRTTubksgbEji8zyCvQWhxvkk=;
        b=IF8dei56OO9mqmJcUCPEyxybpkkiMoyYTCjTshOztSR+GVlrHnE4TjmtUpZ/2mvWM9
         3diADUtXCG0JJRVOW0E1qkKyBi2N2bfNsckv8g8HCKWrfZascHRO4A9OmpGY7yEFF+0d
         bCNWyHFLaqSPZ8DupnKpmMGblQUgnAzsHTZJyKWM21fqmjzejoEOcHnvxZVfQZSLtKJo
         RYsAHiQw8uV5boej/5bjwD2FGUOT8dG5FC1JJAEApyFGbOoFS6ZAm7FLwL51dp9onSK7
         hfBCoO86UJ51QcJ5iK9mWb6G4N+8LKTDyHUwdHUlPOiKCtVDlHBCCUbfhNqUNfI8nY9T
         YOVA==
X-Forwarded-Encrypted: i=1; AJvYcCXEg43JoJkmYfks76s2yuS3cTJuZDUYAq9MBCbRBWPE5Qt3Aq0C/lk+A+6ly4/ZwBkZYupJnwCzoJq0yJFt3tY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx04BBhgfh+JEKb3xDlplpKTOaxdITdh6Rfiw1FMp0eYDh4u6Z0
	Bs8GsUZQtBYMioGdhfOW1DJS2gAretLHq90+tkl5+OlWS8VQwaIQlbbJCJ5BIb4=
X-Google-Smtp-Source: AGHT+IGxbclCqX1bt/+XMXoEabpsMwXOYl+1J5QNTxY9IdVlmLlwPn5SdI2aGJZaqusXEkmXDVEomQ==
X-Received: by 2002:a17:90a:d384:b0:2e2:7f8f:3ad5 with SMTP id 98e67ed59e1d1-2e27f8f3c85mr7490705a91.2.1728429470996;
        Tue, 08 Oct 2024 16:17:50 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5caa753sm140231a91.54.2024.10.08.16.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 16:17:50 -0700 (PDT)
Date: Tue, 8 Oct 2024 16:17:47 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "robh@kernel.org" <robh@kernel.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor@kernel.org" <conor@kernel.org>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
	"kees@kernel.org" <kees@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"jim.shu@sifive.com" <jim.shu@sifive.com>,
	"alistair.francis@wdc.com" <alistair.francis@wdc.com>,
	"cleger@rivosinc.com" <cleger@rivosinc.com>,
	"kito.cheng@sifive.com" <kito.cheng@sifive.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"samitolvanen@google.com" <samitolvanen@google.com>,
	"evan@rivosinc.com" <evan@rivosinc.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"atishp@rivosinc.com" <atishp@rivosinc.com>,
	"andybnac@gmail.com" <andybnac@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"charlie@rivosinc.com" <charlie@rivosinc.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"richard.henderson@linaro.org" <richard.henderson@linaro.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"alexghiti@rivosinc.com" <alexghiti@rivosinc.com>
Subject: Re: [PATCH v6 16/33] riscv/shstk: If needed allocate a new shadow
 stack on clone
Message-ID: <ZwW9m6pqcTFBovuG@debug.ba.rivosinc.com>
References: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
 <20241008-v5_user_cfi_series-v6-16-60d9fe073f37@rivosinc.com>
 <aa75cbd142c51b996423f18769d8b8d7ecc39081.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa75cbd142c51b996423f18769d8b8d7ecc39081.camel@intel.com>

On Tue, Oct 08, 2024 at 10:55:29PM +0000, Edgecombe, Rick P wrote:
>On Tue, 2024-10-08 at 15:36 -0700, Deepak Gupta wrote:
>> +unsigned long shstk_alloc_thread_stack(struct task_struct *tsk,
>> +					�� const struct kernel_clone_args *args)
>> +{
>> +	unsigned long addr, size;
>> +
>> +	/* If shadow stack is not supported, return 0 */
>> +	if (!cpu_supports_shadow_stack())
>> +		return 0;
>> +
>> +	/*
>> +	 * If shadow stack is not enabled on the new thread, skip any
>> +	 * switch to a new shadow stack.
>> +	 */
>> +	if (!is_shstk_enabled(tsk))
>> +		return 0;
>> +
>> +	/*
>> +	 * For CLONE_VFORK the child will share the parents shadow stack.
>> +	 * Set base = 0 and size = 0, this is special means to track this state
>> +	 * so the freeing logic run for child knows to leave it alone.
>> +	 */
>> +	if (args->flags & CLONE_VFORK) {
>> +		set_shstk_base(tsk, 0, 0);
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * For !CLONE_VM the child will use a copy of the parents shadow
>> +	 * stack.
>> +	 */
>> +	if (!(args->flags & CLONE_VM))
>> +		return 0;
>> +
>> +	/*
>> +	 * reaching here means, CLONE_VM was specified and thus a separate shadow
>> +	 * stack is needed for new cloned thread. Note: below allocation is happening
>> +	 * using current mm.
>> +	 */
>> +	size = calc_shstk_size(args->stack_size);
>> +	addr = allocate_shadow_stack(0, size, 0, false);
>> +	if (IS_ERR_VALUE(addr))
>> +		return addr;
>> +
>> +	set_shstk_base(tsk, addr, size);
>> +
>> +	return addr + size;
>> +}
>
>A lot of this patch and the previous one is similar to x86's and arm's. It great
>that we can have consistency around this behavior.
>
>There might be enough consistency to refactor some of the arch code into a
>kernel/shstk.c.
>
>Should we try?

Yeah you're right. Honestly, I've been shameless in adapting most of the flows
from x86 `shstk.c` for risc-v. So thank you for that.

Now that we've `ARCH_HAS_USER_SHADOW_STACK` part of multiple patch series (riscv
shadowstack, clone3 and I think arm64 gcs series as well). It's probably the
appropriate time to find common grounds.

This is what I suggest

- move most of the common/arch agnostic shadow stack stuff in kernel/shstk.c
   This gets part of compile if `ARCH_HAS_USER_SHADOW_STACK` is enabled/selected.

- allow arch specific branch out guard checks for "if cpu supports", "is shadow stack
   enabled on the task_struct" (I expect each arch layout of task_struct will be
   different, no point finding common ground there), etc.

I think it's worth a try. 
If you already don't have patches, I'll spend some time to see what it takes to
converge in my next version. If I end up into some roadblock, will use this thread
for further discussion.


