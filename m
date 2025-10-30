Return-Path: <linux-kselftest+bounces-44401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B7BC20929
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFF524ED657
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 14:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911AF25A35F;
	Thu, 30 Oct 2025 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xA99Q17e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAD125784A
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834055; cv=none; b=TIQjMufIJ6adA2/D217RYOrCcP4Q6M5Ww5ru7xp97U/GUGhdoNxe/EK+pHBdCn7kLNb5HlyjjcpXCM3hLUB8Vt/xaiWsHCNnG1k22t1yeWtxV7qciRmmWO+sR4I8sqQQeR6mLRqxlhOkIj5mRSa+fCrxchuo1Saz52XU6fLWhRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834055; c=relaxed/simple;
	bh=PWVawbmccAgRpDWZViUQAyTtW2FplbcNS/xcuKfad04=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iDEWoZvPcv1fEUaMdnWLl0MLPcE3WPqIfXPFSLF5xBq1mqJP1h7QBjNiZlkKEOQpbXTPDDe2H4j6pyev/JLOjG/14eP1yQ1mSqjym6TOVm/TX6EfvWzBOPIsDetaSPr13+rs5Q0S12maK2E0auO4DnOKpBloBP20F4t38oHxXUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xA99Q17e; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-340410b11b8so1025647a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 07:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761834053; x=1762438853; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0qr3+qnNJL9IhzJUu4YrvRUubcnt/JnNTBv+5uafE+8=;
        b=xA99Q17eRfbRsTwnnAgG3Jy5tFLXOpUcRITUfRZqAJOzHxwlZNKrDD6YQa4TF9IeC6
         yhh0nSsX9x7HhE7+v+nz1FSkCh6F1npuaEtvp5ysxHNHU7qQU3g7aQx68LYpcWoAo2jF
         AY5snZnzN4ibv1KjUHQ3Q6DH5skeLpRq0bhI2wnDke1NmW/DbZ3Rjwqa5/AsYQUYdPz4
         VMFrIVaRw3/dJhZmtlvkM7Tr+fsWQF2eiK/2WGbMXdsUZ32iwvml4lOg+ZzIf3vXai5d
         TEO4j2CyHVI7vDLFoME6WocuNoAhl6AsNrXms0cx4v6NQJrPgHbq9kl1QUjTS0V0nd85
         94qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761834053; x=1762438853;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qr3+qnNJL9IhzJUu4YrvRUubcnt/JnNTBv+5uafE+8=;
        b=NOnJE0fsvEWh9vZ8Qmt93D70laogPETQnsnWvig9Va6ibdMqk8+SwBSD/KdcI4jrzM
         KzkDWA7cHYXG3EAcPWk8SUkphBopVg7Udg6k9FIeqOVJkjAkZRa592R4QY9pQ48uXcWQ
         pkBrtj9hAT9swbw+2+XThrFOiZGZ6M8eIKiVzqtoJftfh2FIyKuuKS1aNLj59fmgtR6G
         G3OyPh4MjaMjhc0onuYN9DRi7qutFRK/Vr1gMdGDWp83gX1gmZwTw2WO2qMD5gaomPOy
         aj62iR8p3hdkzDxF5r5EauYPaki5t6HaSwkAs7yULtEiImMxWeeUdmkTXvM2s0SSftm9
         oYKw==
X-Forwarded-Encrypted: i=1; AJvYcCV95cDv7jyXX5JtPgtDANmlrC5gAfzLFjEG84cdEFxjFIIpxBAMoBHCwRK/OftFlbml1nrDlB9tEKeZzBlzIUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRbiWJZlVhyQm61NgCDyNzv/JKvDBM+T+ZeHcl4i4LLoW7+2pX
	WQD5XVuVxuY4J6Ez9KgIBl/Lc8KGXMS5/t0FRcYXAXaNC1D/ybWPUV8ooclbCdV+CdUMwR0gZBA
	9MwSbKA==
X-Google-Smtp-Source: AGHT+IEAmG4oREjTJHt0o3RFqvoNyEFntIEpiDXbSgHJz3ZUTt/xpLVWZ3YHlSoxUWhhX4tuZP6rztrMhfY=
X-Received: from pjbfh6.prod.google.com ([2002:a17:90b:346:b0:33b:52d6:e13e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1810:b0:32e:b36b:3711
 with SMTP id 98e67ed59e1d1-3404c58bd21mr3676839a91.28.1761834053119; Thu, 30
 Oct 2025 07:20:53 -0700 (PDT)
Date: Thu, 30 Oct 2025 07:20:50 -0700
In-Reply-To: <d4813147-920e-40a4-a7f7-e93666c77cc1@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212052.200523-1-sagis@google.com> <20251028212052.200523-9-sagis@google.com>
 <d4813147-920e-40a4-a7f7-e93666c77cc1@intel.com>
Message-ID: <aQN0Qg24tMQ9ckUT@google.com>
Subject: Re: [PATCH v12 08/23] KVM: selftests: Define structs to pass
 parameters to TDX boot code
From: Sean Christopherson <seanjc@google.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Sagi Shahar <sagis@google.com>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Oct 29, 2025, Reinette Chatre wrote:
> Hi Sagi,
> 
> On 10/28/25 2:20 PM, Sagi Shahar wrote:
> > TDX registers are inaccessible to KVM. Therefore we need a different
> > mechanism to load boot parameters for TDX code. TDX boot code will read
> > the registers values from memory and set the registers manually.
> > 
> > This patch defines the data structures used to communicate between c
> > code and the TDX assembly boot code which will be added in a later
> > patch.
> > 
> 
> (sidenote: I do not know what the bar for this work is so I'll defer
> comments related to local customs like using "we" and "this patch" in
> changelog)

The same as KVM x86, which follows the same rules as the tip tree, with a few
intentional differences.  By all means, call out those things, it'll save me the
effort :-)

Documentation/process/maintainer-kvm-x86.rst

> 
> > Use kbuild.h to expose the offsets into the structs from c code to
> > assembly code.
> > 
> 
> 
> > diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> > index 148d427ff24b..5e809064ff1c 100644
> > --- a/tools/testing/selftests/kvm/Makefile.kvm
> > +++ b/tools/testing/selftests/kvm/Makefile.kvm
> 
> ...
> 
> > @@ -328,18 +336,28 @@ $(LIBKVM_C_OBJ): $(OUTPUT)/%.o: %.c $(GEN_HDRS)
> >  $(LIBKVM_S_OBJ): $(OUTPUT)/%.o: %.S $(GEN_HDRS)
> >  	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
> >  
> > +$(LIBKVM_ASM_DEFS_OBJ): $(OUTPUT)/%.s: %.c FORCE
> > +	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -S $< -o $@
> > +
> >  # Compile the string overrides as freestanding to prevent the compiler from
> >  # generating self-referential code, e.g. without "freestanding" the compiler may
> >  # "optimize" memcmp() by invoking memcmp(), thus causing infinite recursion.
> >  $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
> >  	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -ffreestanding $< -o $@
> >  
> > +$(OUTPUT)/include/x86/tdx/td_boot_offsets.h: $(OUTPUT)/lib/x86/tdx/td_boot_offsets.s FORCE
> > +	$(call filechk,offsets,__TDX_BOOT_OFFSETS_H__)

Presumably this needs to be guarded so that it's x86-only.  I can't tell for sure
as there are other problems in this series of a similar nature that prevent me from
getting far enough to see.  Please build test on at least one other architecture
before sending the next version.

lib/kvm_util.c:7:10: fatal error: tdx/tdx_util.h: No such file or directory
    7 | #include "tdx/tdx_util.h"
      |          ^~~~~~~~~~~~~~~~
compilation terminated.


If possible, I would also really like to see these programatically defined, e.g.
something like (I have no idea if this is remotely valid syntax):

  $(OUTPUT)/$(TEST_GEN_HEADERS): $(OUTPUT)/%.s FORCE
     $(call filechk,offsets,__%_h__)


> Some folks prefer to keep build output separate and may build tests using a command
> line like:
> 	make O=<output dir> TARGETS=kvm -C tools/testing/selftests

Ya, I exclusively build that way.

> This is a valid usage and will result in td_boot_offsets.h placed in <output dir> that
> is not covered by current include path. A build with above command line thus fails:
> 
> lib/x86/tdx/td_boot.S:4:10: fatal error: tdx/td_boot_offsets.h: No such file or directory
>     4 | #include "tdx/td_boot_offsets.h"
>       |          ^~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> 
> 
> Something like below may be needed to add the output directory to the include path:
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 2f49c8965df9..98bc40a7f069 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -262,7 +262,7 @@ CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
>  	-fno-stack-protector -fno-PIE -fno-strict-aliasing \
>  	-I$(LINUX_TOOL_INCLUDE) -I$(LINUX_TOOL_ARCH_INCLUDE) \
>  	-I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -Iinclude/$(ARCH) \
> -	-I ../rseq -I.. $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
> +	-I ../rseq -I.. -I$(OUTPUT)/include/$(ARCH) $(EXTRA_CFLAGS) $(KHDR_INCLUDES)

Hrm, ya, though I assume we want to define e.g. KVM_GEN_HDRS so that they can be
added to the csope.  Note, ARM already has some generated header stuff, but the
generated code comes from outside of KVM selftests, so we'll want to make sure to
avoid a collision with GEN_HDRS, thus the KVM_ prefix.

	ifeq ($(ARCH),arm64)
	tools_dir := $(top_srcdir)/tools
	arm64_tools_dir := $(tools_dir)/arch/arm64/tools/

	ifneq ($(abs_objdir),)
	arm64_hdr_outdir := $(abs_objdir)/tools/
	else
	arm64_hdr_outdir := $(tools_dir)/
	endif

	GEN_HDRS := $(arm64_hdr_outdir)arch/arm64/include/generated/
	CFLAGS += -I$(GEN_HDRS)

	$(GEN_HDRS): $(wildcard $(arm64_tools_dir)/*)
		$(MAKE) -C $(arm64_tools_dir) OUTPUT=$(arm64_hdr_outdir)
	endif

