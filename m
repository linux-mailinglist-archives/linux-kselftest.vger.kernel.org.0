Return-Path: <linux-kselftest+bounces-41926-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDF7B88C03
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 12:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE9F625BA6
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 10:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68942F3C32;
	Fri, 19 Sep 2025 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7o6dHTX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFD51C5F23
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276257; cv=none; b=ikWlqF4KEV67Aey8Iv6iZqFQBk6R+SuY7vj7uFxwryzxvdox2ylof4MIpJiGA/6kPxgVpj5iBNF5ijPGOZeNsOgnRP8qwzknSBYuQBRKozCXq6VZ/CQiBImhW515uIVUpV+WzVXbbDOpWBKXW2/bHvgwbCVjdpUqMC4BB1udyio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276257; c=relaxed/simple;
	bh=MIxBc+wC/cmWNfba7NJKwLPOOs4c9e3k+S+2+58b6Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGNHvJCu95XyMCbQe1L49K2EVbYBxIyuW5jYvU5ylshwYXCLEzBbE9o56uWHYljUse3qutsCayziKI4mNKnxq4nd3w8y8bB38roYAiYiTc2ahcPQBtKfnpXTYtMcbrYUpnKBU0LRwBEHe2NDndOqrjtKccTHjqRBF+NDLzhMMYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7o6dHTX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45f2c4c3853so6825095e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 03:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758276253; x=1758881053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cwSJqMLbkr+n3h9atzHQFhMdHOFSLWWZIBI6hzjzDlU=;
        b=g7o6dHTX/jKHUK07jvyCoY6ajcxb8/0bRLC2sulEeTiYYmsNUrN/qQ/Kx+x8TGrH09
         xXtmOl/GW/IoqmUA5L8WmpnY/Ry4Mac8F62gy298XaBuGkf30NMiGOVgxuDU0wMvEgog
         9fICTRwDWsQqioLOic49O/qJycH1rVfrSrPZTNghHMFyjkvgtcfZAArPlykxj6LRAgIn
         /z+2cdKAoSMYYHGcHTJUF11WeWwvX1KLS9ZNV0FO83Q74Nm2sLgb/jDzNEhIoab1YNJW
         mPjeFOktVP7AS7KpiFHPoxoBQ7ou9utiKL5FYJ9mpyFQ+LBfTNx7acGRLaPFBHksBDK+
         /N9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758276253; x=1758881053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwSJqMLbkr+n3h9atzHQFhMdHOFSLWWZIBI6hzjzDlU=;
        b=n+nM6gewBliYg3/WvCEaNO1XyuFRIWhEhoNdWY1Sfo7Q3N+DNbYU+zYoJ/shgBcXnd
         hFbXG+k6YuTCmPHCshmmcB9SprO80fiiuFMVRbiyVpSNooYixMcSmf3YXFhRmwBSnm84
         FuJVkNnvEqE/DF5XZloxhHBkt9u+ev/UZhdzhCsisuPXfFElInQFZxd+BnwpEbPMpCLw
         QhpJWJQl9w2yE6IeVebf99exBfQMzIUCYhTQpFrju0rpQ9Azo174H0/SLhnmM2V6uHdL
         I3aUwKT18FjaXyQtrGs5YlxDw3bwOyjhxN82frRsaEDJidIZ+Er0gA215dhUSMXGOfNG
         fjeg==
X-Forwarded-Encrypted: i=1; AJvYcCVFszAuXeowJQWheQ/CEQsQivKX5GVfY3jU31V40535V3oqXpv5jV7vsd89eNe/NFWF5mlk42Uk9tyTAzPpWXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZS75KMAIaFNLpUxjL1dnSD01oWylUvJ9pSFX4jDgnukHKU5g0
	HiZvckOrjJQwNRNK++WfnWBGPHC+xMvqDwBkbww/x/5yZAuClCMG3WrE
X-Gm-Gg: ASbGnctfZEG0GtYV6+F4k5fj9LWa8xtXFMUsvRFBhQyKvxJDp5IfSfMVsMcEh1pXF1e
	o9QxG5epTNNlii8kUrCRLYkgQJuXk0mRROI295lstL2WtQWYlNK3unEY9ZLydhW4F3paVmfmYGo
	jFSwMQIy0j8CivFHhlDIIiNroKCq94zVJpxObeDQbWERS6hwJ5wy8c4V56NPD3geqQxHRxLZ4/K
	VfNq7MKSoSjJUU4bCF6MVknr9yoXCve1PCEJRJ8YpfKuqdbSaRVMQCRcN0O5J36NQTZ8IwWVAGF
	Mdh68k6lhId4iwnEuDkBxFUaur23918+LoIGjmxcOfqSlJDvI62p6ayqHFPAXMO4TftwXIKiUMd
	5lnCojOio5NN8L4OUAhbJ
X-Google-Smtp-Source: AGHT+IHvZMGRRNi+u2pMIpVVRpaJCUA/81PZdTy1q3wdlCcos410V3il5VvXKBDg1PnvbPEV8rv3lQ==
X-Received: by 2002:a05:600c:6305:b0:45b:868e:7f7f with SMTP id 5b1f17b1804b1-467ee8c56d6mr28084075e9.17.1758276252440;
        Fri, 19 Sep 2025 03:04:12 -0700 (PDT)
Received: from andrea ([176.201.192.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f5a286edsm90295055e9.16.2025.09.19.03.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 03:04:12 -0700 (PDT)
Date: Fri, 19 Sep 2025 12:04:05 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: corbet@lwn.net, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, mark.rutland@arm.com,
	ajones@ventanamicro.com, brs@rivosinc.com, anup@brainfault.org,
	atish.patra@linux.dev, pbonzini@redhat.com, shuah@kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, apw@canonical.com, joe@perches.com,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/8] riscv: Add Zalasr ISA extension support
Message-ID: <aM0qlTNPiaQRY2Nv@andrea>
References: <20250919073714.83063-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919073714.83063-1-luxu.kernel@bytedance.com>

On Fri, Sep 19, 2025 at 03:37:06PM +0800, Xu Lu wrote:
> This patch adds support for the Zalasr ISA extension, which supplies the
> real load acquire/store release instructions.
> 
> The specification can be found here:
> https://github.com/riscv/riscv-zalasr/blob/main/chapter2.adoc
> 
> This patch seires has been tested with ltp on Qemu with Brensan's zalasr
> support patch[1].
> 
> Some false positive spacing error happens during patch checking. Thus I
> CCed maintainers of checkpatch.pl as well.
> 
> [1] https://lore.kernel.org/all/CAGPSXwJEdtqW=nx71oufZp64nK6tK=0rytVEcz4F-gfvCOXk2w@mail.gmail.com/
> 
> v3:
>  - Apply acquire/release semantics to arch_xchg/arch_cmpxchg operations
>  so as to ensure FENCE.TSO ordering between operations which precede the
>  UNLOCK+LOCK sequence and operations which follow the sequence. Thanks
>  to Andrea.
>  - Support hwprobe of Zalasr.
>  - Allow Zalasr extensions for Guest/VM.
> 
> v2:
>  - Adjust the order of Zalasr and Zalrsc in dt-bindings. Thanks to
>  Conor.
> 
> Xu Lu (8):
>   riscv: add ISA extension parsing for Zalasr
>   dt-bindings: riscv: Add Zalasr ISA extension description
>   riscv: hwprobe: Export Zalasr extension
>   riscv: Introduce Zalasr instructions
>   riscv: Use Zalasr for smp_load_acquire/smp_store_release
>   riscv: Apply acquire/release semantics to arch_xchg/arch_cmpxchg
>     operations
>   RISC-V: KVM: Allow Zalasr extensions for Guest/VM
>   KVM: riscv: selftests: Add Zalasr extensions to get-reg-list test
> 
>  Documentation/arch/riscv/hwprobe.rst          |   5 +-
>  .../devicetree/bindings/riscv/extensions.yaml |   5 +
>  arch/riscv/include/asm/atomic.h               |   6 -
>  arch/riscv/include/asm/barrier.h              |  91 ++++++++++--
>  arch/riscv/include/asm/cmpxchg.h              | 136 ++++++++----------
>  arch/riscv/include/asm/hwcap.h                |   1 +
>  arch/riscv/include/asm/insn-def.h             |  79 ++++++++++
>  arch/riscv/include/uapi/asm/hwprobe.h         |   1 +
>  arch/riscv/include/uapi/asm/kvm.h             |   1 +
>  arch/riscv/kernel/cpufeature.c                |   1 +
>  arch/riscv/kernel/sys_hwprobe.c               |   1 +
>  arch/riscv/kvm/vcpu_onereg.c                  |   2 +
>  .../selftests/kvm/riscv/get-reg-list.c        |   4 +
>  13 files changed, 242 insertions(+), 91 deletions(-)

I wouldn't have rushed this submission while the discussion on v2 seems
so much alive;  IAC, to add and link to that discussion, this version
(not a review, just looking at this diff stat) is changing the fastpath

  read_unlock()
  read_lock()

from something like

  fence rw,w
  amodadd.w
  amoadd.w
  fence r,rw

to

  fence rw,rw
  amoadd.w
  amoadd.w
  fence rw,rw

no matter Zalasr or !Zalasr.  Similarly for other atomic operations with
release or acquire semantics.  I guess the change was not intentional?
If it was intentional, it should be properly mentioned in the changelog.

  Andrea

