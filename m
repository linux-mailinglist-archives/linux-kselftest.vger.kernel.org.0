Return-Path: <linux-kselftest+bounces-18056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF15C97A9D7
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 02:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E5C1C22DA3
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 00:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D20148833;
	Tue, 17 Sep 2024 00:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RhRoQT49"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78DA3BBE5
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Sep 2024 00:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726531249; cv=none; b=orxcZUEeJyrX/DZyTh4x3BNTXYYfH20z4xt/5B+MFXEqsHDQ0LaSQ1qEIPl3oz0OF5iTLz26z5IV5P+Q78q9xeocwyweJz2YggRoYGZUKFIsIBBRwzU3UwDYhy7s3bx33JBzLcRP9HEZwobR6E4JMpFMti5V5Pzz0OLb2rzEM4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726531249; c=relaxed/simple;
	bh=Ee17siRqBFROuZr/thXBuY61Xxnn7brpn1HX2BS79j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ei6c1dU1vhsmjtpkV5NgY/YkDxBq4gMrTCR+ke+UmwmoMxYm6jDjGJYRwvuc6hjFCxuN2wL/5SCGRwnfuBhEP3w0oUeDX4nY7FTGzvyjbuKDQueLjh7VNF+EId5Z/4WDwxRrVl6NiuT4u/XSv7o5RD9gZebTmEDGmX84uPUUJd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RhRoQT49; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fee6435a34so43704085ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Sep 2024 17:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726531246; x=1727136046; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eup1ahvLxbk3GqS/ZMeUjwBFH9cE8D+Ggr+WJlLQMOk=;
        b=RhRoQT49oLiMTKeVDt3o35EPTFrI9VTfyuiHCpYg0jF/Ir0+3X6JtB37avwfLK/pOo
         xtUz4MGUJ6UkuCuX+7d1d7AMVsLkDNoHDX5K14QrtR8CNaDZkDZUC2CwcyvDqi99H8k0
         SGt7yw9X814xthl4fj/4VQFD6VQjlbyrxxw5EkJUNfr4kfrfC5MEl7zwcFJMbhfvCeaM
         EKmNXMThZdV2mD32PkwhtCa0LrlHqz+etI5OcLU2psrqL/OE6ymC6jTgvp9xbONqSMP8
         BUTnOj2lJLTz9/RK58pKcXsMfwkOfq6yQ9Y6hgKizhG7G6mYHOPDm4WIYfihyE0f8IYh
         PjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726531246; x=1727136046;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eup1ahvLxbk3GqS/ZMeUjwBFH9cE8D+Ggr+WJlLQMOk=;
        b=nJDGqrd68e6UJhUod7MBorHiorGjhiUmeXV3GRE7AMcD0j9wacVX7lan6kE0+V/yb4
         PLFmVCd6OR/FVVl7osEITjrVpxzpNc37hUH4M13JhxVRf3jPxTMtOZm/ebJzrWGcNeFD
         65TR9gqQoN7To5exb58j22vHejKKaqcDl1AgaoZDdXtVbHv4c7kntNmsywkrXQ/SAGej
         6LhA5s9iLpQHX2NAPfgf0JZaSPONGcwI+pfDKKdTEeGcT6JTmmbLR0QXte0jebA0Opw8
         oCnmZ9jqTtbHJ+uDoevvFo3C+9+UeTc1X3G+ILdj/fJHUKCTC+pEjtsU7xq4Lq4uq0jN
         K+TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHoL6DSKgpOm8ZyCY50+vGcK7qksF8MxIqXLV+/xCCtmMjTd+ufvR/cQiPeS0BGxF6YtPztKWcob+QYGmc4Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgp5HNugoDzn4UMqACEFBfjB/Jsd4wQxvgCOOz4GqFmv8c8KN6
	IPq21A0ra9H83L3EXUGNShcTnZLKXCYC7jAJ7tyN81nrgutMBq/H1+AwLBbOy58=
X-Google-Smtp-Source: AGHT+IH64YpGkOt6sdEnN70vzwbW5vOexKApQ3tQQA6MC8BwStmIPrrAyTwaRSTJo5R11SP51oTbHQ==
X-Received: by 2002:a17:902:ea0d:b0:205:7c76:4b2c with SMTP id d9443c01a7336-2076e412882mr247960785ad.48.1726531245442;
        Mon, 16 Sep 2024 17:00:45 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794601384sm41311685ad.94.2024.09.16.17.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 17:00:45 -0700 (PDT)
Date: Mon, 16 Sep 2024 17:00:40 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Andy Chiu <andybnac@gmail.com>
Cc: paul.walmsley@sifive.com, palmer@sifive.com, conor@kernel.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
	quic_zhonhan@quicinc.com, zong.li@sifive.com, zev@bewilderbeest.net,
	david@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
	broonie@kernel.org, dave.hansen@linux.intel.com,
	atishp@rivosinc.com, bjorn@rivosinc.com, namcaov@gmail.com,
	usama.anjum@collabora.com, guoren@kernel.org, alx@kernel.org,
	jszhang@kernel.org, hpa@zytor.com, puranjay@kernel.org,
	shuah@kernel.org, sorear@fastmail.com, costa.shul@redhat.com,
	robh@kernel.org, antonb@tenstorrent.com, quic_bjorande@quicinc.com,
	lorenzo.stoakes@oracle.com, corbet@lwn.net, dawei.li@shingroup.cn,
	anup@brainfault.org, deller@gmx.de, x86@kernel.org,
	andrii@kernel.org, willy@infradead.org, kees@kernel.org,
	mingo@redhat.com, libang.li@antgroup.com, samitolvanen@google.com,
	greentime.hu@sifive.com, osalvador@suse.de, ajones@ventanamicro.com,
	revest@chromium.org, ancientmodern4@gmail.com,
	aou@eecs.berkeley.edu, jerry.shih@sifive.com,
	alexghiti@rivosinc.com, arnd@arndb.de, yang.lee@linux.alibaba.com,
	charlie@rivosinc.com, bgray@linux.ibm.com, Liam.Howlett@oracle.com,
	leobras@redhat.com, songshuaishuai@tinylab.org,
	xiao.w.wang@intel.com, bp@alien8.de, cuiyunhui@bytedance.com,
	mchitale@ventanamicro.com, cleger@rivosinc.com, tglx@linutronix.de,
	krzk+dt@kernel.org, vbabka@suse.cz, brauner@kernel.org,
	bhe@redhat.com, ke.zhao@shingroup.cn, oleg@redhat.com,
	samuel.holland@sifive.com, ben.dooks@codethink.co.uk,
	evan@rivosinc.com, palmer@dabbelt.com, ebiederm@xmission.com,
	andy.chiu@sifive.com, schwab@suse.de, akpm@linux-foundation.org,
	sameo@rivosinc.com, tanzhasanwork@gmail.com, rppt@kernel.org,
	ryan.roberts@arm.com
Subject: Re: [PATCH v4 21/30] riscv/traps: Introduce software check exception
Message-ID: <ZujGqOVbYZ8+8XPu@debug.ba.rivosinc.com>
References: <20240912231650.3740732-1-debug@rivosinc.com>
 <20240912231650.3740732-22-debug@rivosinc.com>
 <CAFTtA3NA+OwZv5hJU3EWjuNHNjA3fQzPC+sX84Nb9YyJXdENSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFTtA3NA+OwZv5hJU3EWjuNHNjA3fQzPC+sX84Nb9YyJXdENSA@mail.gmail.com>

On Fri, Sep 13, 2024 at 09:35:50PM +0200, Andy Chiu wrote:
>Hi Deepak
>
>Deepak Gupta <debug@rivosinc.com> 於 2024年9月13日 週五 上午2:32寫道：
>>
>> zicfiss / zicfilp introduces a new exception to priv isa `software check
>> exception` with cause code = 18. This patch implements software check
>> exception.
>>
>> Additionally it implements a cfi violation handler which checks for code
>> in xtval. If xtval=2, it means that sw check exception happened because of
>> an indirect branch not landing on 4 byte aligned PC or not landing on
>> `lpad` instruction or label value embedded in `lpad` not matching label
>> value setup in `x7`. If xtval=3, it means that sw check exception happened
>> because of mismatch between link register (x1 or x5) and top of shadow
>> stack (on execution of `sspopchk`).
>>
>> In case of cfi violation, SIGSEGV is raised with code=SEGV_CPERR.
>> SEGV_CPERR was introduced by x86 shadow stack patches.
>>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> ---
>>  arch/riscv/include/asm/asm-prototypes.h |  1 +
>>  arch/riscv/include/asm/entry-common.h   |  2 ++
>>  arch/riscv/kernel/entry.S               |  3 ++
>>  arch/riscv/kernel/traps.c               | 38 +++++++++++++++++++++++++
>>  4 files changed, 44 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include/asm/asm-prototypes.h
>> index cd627ec289f1..5a27cefd7805 100644
>> --- a/arch/riscv/include/asm/asm-prototypes.h
>> +++ b/arch/riscv/include/asm/asm-prototypes.h
>> @@ -51,6 +51,7 @@ DECLARE_DO_ERROR_INFO(do_trap_ecall_u);
>>  DECLARE_DO_ERROR_INFO(do_trap_ecall_s);
>>  DECLARE_DO_ERROR_INFO(do_trap_ecall_m);
>>  DECLARE_DO_ERROR_INFO(do_trap_break);
>> +DECLARE_DO_ERROR_INFO(do_trap_software_check);
>>
>>  asmlinkage void handle_bad_stack(struct pt_regs *regs);
>>  asmlinkage void do_page_fault(struct pt_regs *regs);
>> diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
>> index 2293e535f865..4068c7e5452a 100644
>> --- a/arch/riscv/include/asm/entry-common.h
>> +++ b/arch/riscv/include/asm/entry-common.h
>> @@ -39,4 +39,6 @@ static inline int handle_misaligned_store(struct pt_regs *regs)
>>  }
>>  #endif
>>
>> +bool handle_user_cfi_violation(struct pt_regs *regs);
>> +
>>  #endif /* _ASM_RISCV_ENTRY_COMMON_H */
>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>> index ca9203e6d76d..2ec75ba864a8 100644
>> --- a/arch/riscv/kernel/entry.S
>> +++ b/arch/riscv/kernel/entry.S
>> @@ -384,6 +384,9 @@ SYM_DATA_START_LOCAL(excp_vect_table)
>>         RISCV_PTR do_page_fault   /* load page fault */
>>         RISCV_PTR do_trap_unknown
>>         RISCV_PTR do_page_fault   /* store page fault */
>> +       RISCV_PTR do_trap_unknown /* cause=16 */
>> +       RISCV_PTR do_trap_unknown /* cause=17 */
>> +       RISCV_PTR do_trap_software_check /* cause=18 is sw check exception */
>>  SYM_DATA_END_LABEL(excp_vect_table, SYM_L_LOCAL, excp_vect_table_end)
>>
>>  #ifndef CONFIG_MMU
>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> index 51ebfd23e007..32d1453bed72 100644
>> --- a/arch/riscv/kernel/traps.c
>> +++ b/arch/riscv/kernel/traps.c
>> @@ -354,6 +354,44 @@ void do_trap_ecall_u(struct pt_regs *regs)
>>
>>  }
>>
>> +#define CFI_TVAL_FCFI_CODE     2
>> +#define CFI_TVAL_BCFI_CODE     3
>> +/* handle cfi violations */
>> +bool handle_user_cfi_violation(struct pt_regs *regs)
>> +{
>> +       bool ret = false;
>> +       unsigned long tval = csr_read(CSR_TVAL);
>> +
>> +       if (((tval == CFI_TVAL_FCFI_CODE) && cpu_supports_indirect_br_lp_instr()) ||
>> +               ((tval == CFI_TVAL_BCFI_CODE) && cpu_supports_shadow_stack())) {
>> +               do_trap_error(regs, SIGSEGV, SEGV_CPERR, regs->epc,
>> +                                         "Oops - control flow violation");
>> +               ret = true;
>> +       }
>> +
>> +       return ret;
>> +}
>> +/*
>> + * software check exception is defined with risc-v cfi spec. Software check
>> + * exception is raised when:-
>> + * a) An indirect branch doesn't land on 4 byte aligned PC or `lpad`
>> + *    instruction or `label` value programmed in `lpad` instr doesn't
>> + *    match with value setup in `x7`. reported code in `xtval` is 2.
>> + * b) `sspopchk` instruction finds a mismatch between top of shadow stack (ssp)
>> + *    and x1/x5. reported code in `xtval` is 3.
>> + */
>
>It seems like this trap handler does not follow generic entry. This
>can cause problems as signal delivery is done in
>irqentry_exit_to_user_mode(). Please reference the commit f0bddf50586d
>("riscv: entry: Convert to generic entry") for more information.

Ack. will fix it.

>
>> +asmlinkage __visible __trap_section void do_trap_software_check(struct pt_regs *regs)
>> +{
>> +       if (user_mode(regs)) {
>> +               /* not a cfi violation, then merge into flow of unknown trap handler */
>> +               if (!handle_user_cfi_violation(regs))
>> +                       do_trap_unknown(regs);
>> +       } else {
>> +               /* sw check exception coming from kernel is a bug in kernel */
>> +               die(regs, "Kernel BUG");
>> +       }
>> +}
>> +
>>  #ifdef CONFIG_MMU
>>  asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
>>  {
>> --
>> 2.45.0
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>Cheers,
>Andy

