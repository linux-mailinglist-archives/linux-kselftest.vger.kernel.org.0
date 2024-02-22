Return-Path: <linux-kselftest+bounces-5257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA9D85EEAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 02:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0BC1C21640
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 01:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C367F516;
	Thu, 22 Feb 2024 01:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="M31wLw/L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DF212B97
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Feb 2024 01:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708565583; cv=none; b=k1nWaqavcRlvmcLfLbnXfO/OLfL+W8idg2OnyPVAMtj4iRpH8NYOhknPBIQnlA8zdtGHbbQ6CiIX54xIYXv06ZTbtID0yic4ikOmNAAMIWgg2S6IhMxlJbWVV2fOJcNotankMvHMcfhCvrafH9j0AzBOVJ9ufzMMBDVwUTRIYA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708565583; c=relaxed/simple;
	bh=VyvKbdCBXwoTpc3NUw38Rj/m1VW8rKxO+v0fPJFet10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFg+HAW53YdrteOtfbPRf4tndQkD58fwVfpkRyKLcHhB2M5ohknGBNbVAOy2pYl2Rb/tPmfPaTG+uiTmqH3wEuMeJVggh+B6sOo4ZkcJnjo8MqzRLTUFqzs44lcxPeG0JZnRoXOk6JAEW/3uzzWjX28rF1Qpl7ZF8TBVfxTCvG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=M31wLw/L; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso1008572a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 17:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708565581; x=1709170381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n1/PMiHWsYAN4wzFhndBXh4DI3dHrcZRXiJQjN9iXLY=;
        b=M31wLw/LyRop/Bi6LxVgxe1UG5g7/LB/Lz2W0L4Mm/dut308tMAJrk3mlLp+Qve/zU
         44XEiqRN7olmitHIDchTRuLANCLDBiI1411xp/MnNt/1de16eQeSRchtmJH7VY8rVlif
         ERKaTjxACsJrgvtXdcIf/ODMD/E39ipdF4t5m8aZbC3CXrDb3fAt2sXjU/rihYFtT3yA
         zxTSdS9DC1mP5P5xbxugAFi/ln00vAl1MGQHVaXtZux3AXgTursBm1XKQEPLduX4pY3V
         Jq0oCw1IaWFwaaRkkSxlYlgBxpaQZdz2Ms3NSMid3Na7FWOVskUAgcI6qo9tqJzsgZiI
         ZfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708565581; x=1709170381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1/PMiHWsYAN4wzFhndBXh4DI3dHrcZRXiJQjN9iXLY=;
        b=qAN+pYg/v/R/upnoJDA27SOJkkMgbTJiXE9gbcfyYKV3AFI16sSs3rYDx/QcUvT9p3
         ndI24IvREyb9zAjQMOrk7ecF9d5kSQ139cxeuFJZa2IKY4FCQJQc80MEWlX5jWyVRpHl
         OEoYOpx7seuXN0qMzkDidWC6WeNJ64AQ3EIT8M6CJwPonNDDjIhoOQO8QxZrvgeytuqH
         YR5A+r2eBmyA3sEjCvta//D9hZQDX79uTla6aLRePV1QkIQdQHl92bF3F3Ha4OXV1k6i
         VeqY+AROtWB2io/b8kl+8whuuOZTVUKe99ODRv6lUqS/dbJztXzFAwQuJoGpqWLhTXKz
         Pcuw==
X-Forwarded-Encrypted: i=1; AJvYcCU4cVhNv63fFFVs9Ifepms5ZThbue8y3paXfbvvt537dKug4c9tOMSWT5z7eHvvzDkdkj61bm1IbOrT4IoDl0b3uIb7y2SvTVBoIyNDkMu4
X-Gm-Message-State: AOJu0YxJLn9bpzqvc2YsrpwZuBWZOSW+b+J+Fdnv2WYsb2rs2JXpU3qy
	Etw6UdoGG7TKhVlaztqvM5wRuI+tu5hXaavCmW8TwJ1RoWHRl/tGv5uVbSSj/eI=
X-Google-Smtp-Source: AGHT+IG0sRbKUEOwlZ17s8jdpcAQ2S3+xO2BqNa6Gjn/TJGMcrfmrjlgVTyqtDhwxmWPGy2rlyUFuw==
X-Received: by 2002:a05:6a21:394c:b0:19e:4aa7:e6ab with SMTP id ac12-20020a056a21394c00b0019e4aa7e6abmr22177735pzc.47.1708565580594;
        Wed, 21 Feb 2024 17:33:00 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id lf8-20020a170902fb4800b001db5ea825b2sm8782350plb.123.2024.02.21.17.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 17:32:59 -0800 (PST)
Date: Wed, 21 Feb 2024 17:32:56 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: David Hildenbrand <david@redhat.com>
Cc: rick.p.edgecombe@intel.com, broonie@kernel.org, Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com, keescook@chromium.org,
	ajones@ventanamicro.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
	alexghiti@rivosinc.com, corbet@lwn.net, aou@eecs.berkeley.edu,
	oleg@redhat.com, akpm@linux-foundation.org, arnd@arndb.de,
	ebiederm@xmission.com, shuah@kernel.org, brauner@kernel.org,
	guoren@kernel.org, samitolvanen@google.com, evan@rivosinc.com,
	xiao.w.wang@intel.com, apatel@ventanamicro.com,
	mchitale@ventanamicro.com, waylingii@gmail.com,
	greentime.hu@sifive.com, heiko@sntech.de, jszhang@kernel.org,
	shikemeng@huaweicloud.com, charlie@rivosinc.com,
	panqinglin2020@iscas.ac.cn, willy@infradead.org,
	vincent.chen@sifive.com, andy.chiu@sifive.com, gerg@kernel.org,
	jeeheng.sia@starfivetech.com, mason.huo@starfivetech.com,
	ancientmodern4@gmail.com, mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com, bhe@redhat.com, ruscur@russell.cc,
	bgray@linux.ibm.com, alx@kernel.org, baruch@tkos.co.il,
	zhangqing@loongson.cn, catalin.marinas@arm.com, revest@chromium.org,
	josh@joshtriplett.org, joey.gouly@arm.com, shr@devkernel.io,
	omosnace@redhat.com, ojeda@kernel.org, jhubbard@nvidia.com,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v1 09/28] mm: abstract shadow stack vma behind
 `arch_is_shadow_stack`
Message-ID: <ZdakSM7KcXGgOoU6@debug.ba.rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-10-debug@rivosinc.com>
 <2f34f6aa-99fa-4545-b706-a1d50864f9e9@redhat.com>
 <ZbKVNm5ubV8yQtSE@debug.ba.rivosinc.com>
 <45d5b98c-bad8-471d-a285-47f47c5b50bb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <45d5b98c-bad8-471d-a285-47f47c5b50bb@redhat.com>

On Tue, Feb 13, 2024 at 11:34:59AM +0100, David Hildenbrand wrote:
>On 25.01.24 18:07, Deepak Gupta wrote:
>>On Thu, Jan 25, 2024 at 09:18:07AM +0100, David Hildenbrand wrote:
>>>On 25.01.24 07:21, debug@rivosinc.com wrote:
>>>>From: Deepak Gupta <debug@rivosinc.com>
>>>>
>>>>x86 has used VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) to encode shadow
>>>>stack VMA. VM_SHADOW_STACK is thus not possible on 32bit. Some arches may
>>>>need a way to encode shadow stack on 32bit and 64bit both and they may
>>>>encode this information differently in VMAs.
>>>>
>>>>This patch changes checks of VM_SHADOW_STACK flag in generic code to call
>>>>to a function `arch_is_shadow_stack` which will return true if arch
>>>>supports shadow stack and vma is shadow stack else stub returns false.
>>>>
>>>>There was a suggestion to name it as `vma_is_shadow_stack`. I preferred to
>>>>keep `arch` prefix in there because it's each arch specific.
>>>>
>>>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>>>---
>>>>  include/linux/mm.h | 18 +++++++++++++++++-
>>>>  mm/gup.c           |  5 +++--
>>>>  mm/internal.h      |  2 +-
>>>>  3 files changed, 21 insertions(+), 4 deletions(-)
>>>>
>>>>diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>index dfe0e8118669..15c70fc677a3 100644
>>>>--- a/include/linux/mm.h
>>>>+++ b/include/linux/mm.h
>>>>@@ -352,6 +352,10 @@ extern unsigned int kobjsize(const void *objp);
>>>>   * for more details on the guard size.
>>>>   */
>>>>  # define VM_SHADOW_STACK	VM_HIGH_ARCH_5
>>>>+static inline bool arch_is_shadow_stack(vm_flags_t vm_flags)
>>>>+{
>>>>+	return (vm_flags & VM_SHADOW_STACK);
>>>>+}
>>>>  #endif
>>>>  #ifdef CONFIG_RISCV_USER_CFI
>>>>@@ -362,10 +366,22 @@ extern unsigned int kobjsize(const void *objp);
>>>>   * with VM_SHARED.
>>>>   */
>>>>  #define VM_SHADOW_STACK	VM_WRITE
>>>>+
>>>>+static inline bool arch_is_shadow_stack(vm_flags_t vm_flags)
>>>>+{
>>>>+	return ((vm_flags & (VM_WRITE | VM_READ | VM_EXEC)) == VM_WRITE);
>>>>+}
>>>>+
>>>
>>>Please no such hacks just to work around the 32bit vmflags limitation.
>>
>>As I said in another response. Noted.
>>And if there're no takers for 32bit on riscv (which highly likely is the case)
>>This will go away in next version of patchsets.
>
>Sorry for the (unusually for me) late reply. Simplifying to riscv64 
>sounds great.
>
>Alternatively, maybe VM_SHADOW_STACK is not even required at all on 
>riscv if we can teach all code to only stare at arch_is_shadow_stack() 
>instead.

Sorry for late reply.

I think for risc-v this can be done, if done in following way

static inline bool arch_is_shadow_stack(struct vm_flags_t vm_flags)
{
		return (vm_get_page_prot(vm_flags) == PAGE_SHADOWSTACK);
}

But doing above will require following

- Inventing a new PROT_XXX type (let's call it PROT_SHADOWSTACK) that
   is only exposed to kernel. PROT_SHADOWSTACK protection flag would allow
   `do_mmap` to do right thing and setup appropriate protection perms.
   We wouldn't want to expose this protection type to user mode (because
   `map_shadow_stack` already exists for that).
   Current patch series uses PROT_SHADOWSTACK because VM_SHADOW_STACK was
   aliased to VM_WRITE.

- As you said teach all the generic code as well to use arch_is_shadow_stack
   which might become complicated (can't say for sure)


>
>... but, just using the same VM_SHADOW_STACK will it all much cleaner. 
>Eventually, we can just stop playing arch-specific games with 
>arch_is_shadow_stack and VM_SHADOW_STACK.

Yeah for now, looks like easier thing to do.

>
>-- 
>Cheers,
>
>David / dhildenb
>

