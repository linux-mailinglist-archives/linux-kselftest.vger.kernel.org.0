Return-Path: <linux-kselftest+bounces-43340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 651E0BE441A
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 17:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 132A035285C
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 15:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFDF34DCCD;
	Thu, 16 Oct 2025 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Jq5SJE6P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721AF34AAE4
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628780; cv=none; b=a/IYACMywnABXy9enqgnIa736T8ZqnUSt5PkvcQsXhPAM+GGtMvrUldqZvKxiAaRnjo+xprDxfVLYHLp7aW8tzyVS1SaQtXSLO0CkwHDmz823+74pF+UHm8fJyurQc3g7FQqgxk+y1ofcedC/CK6TGkR5FQg1pYyfDo3tiqNDeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628780; c=relaxed/simple;
	bh=+vfLAUgKF6uvsarRDRcDQR9Kpy31ISdblD7kabJJs3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErNprJIG3noWdjPDrAK3nIR9avYpYjTzcDXoxDpojXtNRsuXHgJntUF9bn5yO27m1QB8WTnC2L7eDqqJLNgMNejxvfaXgaTOmh8AVpZAJjpxRSC3f3RU50UNluFSLs8xh7C2Wvd/rRYkh0oW+Rig9BixkD2ihlYkFmcRodHrwWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Jq5SJE6P; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b633b54d05dso615979a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 08:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760628777; x=1761233577; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3jxedNOWKQXyjZn7DBAQ8SlEmIZ51OVh5Hh6uRAtw9w=;
        b=Jq5SJE6PzU6fHlU7nHEmD0umujif+eUamOZBvKKQurj651w7qVSZR+hZV4ekbHXBug
         gKBxxF5h7uMjeauLG/DkDxWRwRiTMwS0PnF74pk2YndifB8831Y2RXD/QewITQF3bB7B
         F6OA5CA2b6afNo8Q115MU09+XRm7n/kRev0QhVdZjZvKNKo5d3FjkssJ0Ea2gHDigK2m
         jF6YL7SAZb9GCGkxvZ2IMjidbHCr/SVGJwEIlc4oNv6IyuYdoUCEkuMM5yw+nGoG92O2
         ugteOetqbIiW9OFHsIZtOOYsC5PtP8FT3Fi9WjRgORLcpWzXAiCS8l0YArIiZXH/O1No
         sz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760628777; x=1761233577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jxedNOWKQXyjZn7DBAQ8SlEmIZ51OVh5Hh6uRAtw9w=;
        b=X8esp+Etky+q2Yb5vdSzUIWeE1u6zzKnZ1Tl5x9U30eI34g7NkOrWI31/59/EcchdA
         l6beXb2AQ4mIKr8Nycb9BDnp3CrCyQ2SECSrY7Ydqb2KVMNVdwdPl7BU3cc/qPYsPd3m
         9/JVst96JILE01mmbEXAHajLZYLhK1WrPlthuYNevbUSE+NYxydpBEcNbk5o0enccfed
         8j4QDpd7V+OLsdms7aOtkCm91UHskzWKMmdUbZE9wPbFR1i5IofGDS6YXMYoIq2gVe+z
         FSaRZ3dd2AExKb9gexEiyDE8qTl3gJtt70qMvAfDRmC9e/AfDh8MCFQu5tLgOpi940Er
         phkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJqJYt5hOTYMfqBbZzZ4GfPTWkgb4tZVhvFTFKGnbw3uhRGr33jbcNaU1Dz8QkWMEFaH6kHQc4rsvwgo6OurI=@vger.kernel.org
X-Gm-Message-State: AOJu0YydQXB348dT676a9gTC31jwHwAdGk0mpZi24iTp2Tqj9YkGLrZK
	QjYBqknJGmWz/RsLzIlxMRhqmgQ8Vr7ZcbT7QxkjHATUl5uCrJCrIWqbfWtSPpiI4kQ=
X-Gm-Gg: ASbGnctvSFCn45jV7qCSzT5OUh94jZPcNCe89JkFaOziR+Jwp2aOceb0txc3JzFsQcw
	TpsPXfBmI1XKUPlq0IXc3+nUZNfOjH7qiNNXytrqJ4Gldkg+t6I3M1HIuuAOg/OaoCJtsR8W3yX
	u8R3L9PueOaeGza2Qs8OQDIPm9z+/O5U6ny8xseWGinBJNIh2yxcTYiCKQ6FZinTV7SFXXDIkK/
	twqdVYckcAt5tTGirMbCLqf8p3lhCqkzhbepXUmsSqJ3Jd6+1h3mbI/j/yaPKjmW1+nIc7n77XA
	S06vnntHmPyqxYS3HQb0P4FTHTLCvZO0KgHSWe73YkKHRurOLePQMYmS6Ox0zhcA4AZR4RmUX+0
	q6bfeqiBiOP4kXXtjtA4cfCSRpW0P+5OJ4K3QI8Z1bLny1Ou3gfzumYFhkHCvDYc+UFyYq5Ka8n
	zF7CjhDCEKSg==
X-Google-Smtp-Source: AGHT+IH84DeIB8c+VjuQrVSzDzT3x6nsRergbVWw29DX9ZseotGG3dDJsziVEnyxGDiXthj0SuB12g==
X-Received: by 2002:a17:902:d483:b0:265:47:a7b0 with SMTP id d9443c01a7336-290c9c896a5mr3550315ad.10.1760628776645;
        Thu, 16 Oct 2025 08:32:56 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099348afcsm34256915ad.37.2025.10.16.08.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:32:56 -0700 (PDT)
Date: Thu, 16 Oct 2025 08:32:53 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Zong Li <zong.li@sifive.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com,
	richard.henderson@linaro.org, jim.shu@sifive.com,
	andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
	atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
	alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v20 24/28] arch/riscv: dual vdso creation logic and
 select vdso based on hw
Message-ID: <aPEQJTbADjH9AKUf@debug.ba.rivosinc.com>
References: <20251013-v5_user_cfi_series-v20-0-b9de4be9912e@rivosinc.com>
 <20251013-v5_user_cfi_series-v20-24-b9de4be9912e@rivosinc.com>
 <CANXhq0rVGisy33n6gB-P8B0ALiB2LqqYbKsSqgJLCNNRecP9TA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXhq0rVGisy33n6gB-P8B0ALiB2LqqYbKsSqgJLCNNRecP9TA@mail.gmail.com>

On Thu, Oct 16, 2025 at 04:32:08PM +0800, Zong Li wrote:
>On Tue, Oct 14, 2025 at 5:57 AM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> Shadow stack instructions are taken from zimop (mandated on RVA23).
>> Any hardware prior to RVA23 profile will fault on shado stack instruction.
>
>I notice that there is a typo for shado"w" stack instruction.

Aah yes. Sorry about it and thanks.
Again upto Paul, if he wants me to send another. I'll do that.

-Deepak

>
>> Any userspace with shadow stack instruction in it will fault on such
>> hardware. Thus such userspace can't be brought onto such a hardware.
>>
>> It's not known how userspace will respond to such binary fragmentation.
>> However in order to keep kernel portable across such different hardware,
>> `arch/riscv/kernel/vdso_cfi` is created which has logic (Makefile) to
>> compile `arch/riscv/kernel/vdso` sources with cfi flags and then changes
>> in `arch/riscv/kernel/vdso.c` for selecting appropriate vdso depending
>> on whether underlying hardware(cpu) implements zimop extension. Offset
>> of vdso symbols will change due to having two different vdso binaries,
>> there is added logic to include new generated vdso offset header and
>> dynamically select offset (like for rt_sigreturn).
>>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> ---
>>  arch/riscv/Makefile                        |  3 +++
>>  arch/riscv/include/asm/vdso.h              |  7 ++++++-
>>  arch/riscv/kernel/Makefile                 |  1 +
>>  arch/riscv/kernel/vdso.c                   |  7 +++++++
>>  arch/riscv/kernel/vdso/Makefile            | 29 ++++++++++++++++++++---------
>>  arch/riscv/kernel/vdso/gen_vdso_offsets.sh |  4 +++-
>>  arch/riscv/kernel/vdso_cfi/Makefile        | 25 +++++++++++++++++++++++++
>>  arch/riscv/kernel/vdso_cfi/vdso-cfi.S      | 11 +++++++++++
>>  8 files changed, 76 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
>> index f60c2de0ca08..b74b63da16a7 100644
>> --- a/arch/riscv/Makefile
>> +++ b/arch/riscv/Makefile
>> @@ -176,6 +176,8 @@ ifeq ($(CONFIG_MMU),y)
>>  prepare: vdso_prepare
>>  vdso_prepare: prepare0
>>         $(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso include/generated/vdso-offsets.h
>> +       $(if $(CONFIG_RISCV_USER_CFI),$(Q)$(MAKE) \
>> +               $(build)=arch/riscv/kernel/vdso_cfi include/generated/vdso-cfi-offsets.h)
>>         $(if $(CONFIG_COMPAT),$(Q)$(MAKE) \
>>                 $(build)=arch/riscv/kernel/compat_vdso include/generated/compat_vdso-offsets.h)
>>
>> @@ -183,6 +185,7 @@ endif
>>  endif
>>
>>  vdso-install-y                 += arch/riscv/kernel/vdso/vdso.so.dbg
>> +vdso-install-$(CONFIG_RISCV_USER_CFI)  += arch/riscv/kernel/vdso_cfi/vdso-cfi.so.dbg
>>  vdso-install-$(CONFIG_COMPAT)  += arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg
>>
>>  BOOT_TARGETS := Image Image.gz Image.bz2 Image.lz4 Image.lzma Image.lzo Image.zst Image.xz loader loader.bin xipImage vmlinuz.efi
>> diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
>> index f80357fe24d1..3fc8f72b8bfb 100644
>> --- a/arch/riscv/include/asm/vdso.h
>> +++ b/arch/riscv/include/asm/vdso.h
>> @@ -18,9 +18,13 @@
>>
>>  #ifndef __ASSEMBLER__
>>  #include <generated/vdso-offsets.h>
>> +#include <generated/vdso-cfi-offsets.h>
>>
>>  #define VDSO_SYMBOL(base, name)                                                        \
>> -       (void __user *)((unsigned long)(base) + __vdso_##name##_offset)
>> +       ((IS_ENABLED(CONFIG_RISCV_USER_CFI) &&                                  \
>> +         riscv_has_extension_unlikely(RISCV_ISA_EXT_ZIMOP)) ?                  \
>> +         (void __user *)((unsigned long)(base) + __vdso_##name##_cfi_offset) : \
>> +         (void __user *)((unsigned long)(base) + __vdso_##name##_offset))
>>
>>  #ifdef CONFIG_COMPAT
>>  #include <generated/compat_vdso-offsets.h>
>> @@ -33,6 +37,7 @@ extern char compat_vdso_start[], compat_vdso_end[];
>>  #endif /* CONFIG_COMPAT */
>>
>>  extern char vdso_start[], vdso_end[];
>> +extern char vdso_cfi_start[], vdso_cfi_end[];
>>
>>  #endif /* !__ASSEMBLER__ */
>>
>> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>> index 2d0e0dcedbd3..9026400cba10 100644
>> --- a/arch/riscv/kernel/Makefile
>> +++ b/arch/riscv/kernel/Makefile
>> @@ -72,6 +72,7 @@ obj-y += vendor_extensions/
>>  obj-y  += probes/
>>  obj-y  += tests/
>>  obj-$(CONFIG_MMU) += vdso.o vdso/
>> +obj-$(CONFIG_RISCV_USER_CFI) += vdso_cfi/
>>
>>  obj-$(CONFIG_RISCV_MISALIGNED) += traps_misaligned.o
>>  obj-$(CONFIG_RISCV_MISALIGNED) += unaligned_access_speed.o
>> diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
>> index 3a8e038b10a2..bf080e519101 100644
>> --- a/arch/riscv/kernel/vdso.c
>> +++ b/arch/riscv/kernel/vdso.c
>> @@ -98,6 +98,13 @@ static struct __vdso_info compat_vdso_info __ro_after_init = {
>>
>>  static int __init vdso_init(void)
>>  {
>> +       /* Hart implements zimop, expose cfi compiled vdso */
>> +       if (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
>> +               riscv_has_extension_unlikely(RISCV_ISA_EXT_ZIMOP)) {
>> +               vdso_info.vdso_code_start = vdso_cfi_start;
>> +               vdso_info.vdso_code_end = vdso_cfi_end;
>> +       }
>> +
>>         __vdso_init(&vdso_info);
>>  #ifdef CONFIG_COMPAT
>>         __vdso_init(&compat_vdso_info);
>> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
>> index 272f1d837a80..a842dc034571 100644
>> --- a/arch/riscv/kernel/vdso/Makefile
>> +++ b/arch/riscv/kernel/vdso/Makefile
>> @@ -20,6 +20,10 @@ endif
>>  ifdef VDSO_CFI_BUILD
>>  CFI_MARCH = _zicfilp_zicfiss
>>  CFI_FULL = -fcf-protection=full
>> +CFI_SUFFIX = -cfi
>> +OFFSET_SUFFIX = _cfi
>> +ccflags-y += -DVDSO_CFI=1
>> +asflags-y += -DVDSO_CFI=1
>>  endif
>>
>>  # Files to link into the vdso
>> @@ -48,13 +52,20 @@ endif
>>  CFLAGS_hwprobe.o += -fPIC
>>
>>  # Build rules
>> -targets := $(obj-vdso) vdso.so vdso.so.dbg vdso.lds
>> +vdso_offsets := vdso$(if $(VDSO_CFI_BUILD),$(CFI_SUFFIX),)-offsets.h
>> +vdso_o := vdso$(if $(VDSO_CFI_BUILD),$(CFI_SUFFIX),).o
>> +vdso_so := vdso$(if $(VDSO_CFI_BUILD),$(CFI_SUFFIX),).so
>> +vdso_so_dbg := vdso$(if $(VDSO_CFI_BUILD),$(CFI_SUFFIX),).so.dbg
>> +vdso_lds := vdso.lds
>> +
>> +targets := $(obj-vdso) $(vdso_so) $(vdso_so_dbg) $(vdso_lds)
>> +
>>  obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
>>
>> -obj-y += vdso.o
>> -CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
>> +obj-y += vdso$(if $(VDSO_CFI_BUILD),$(CFI_SUFFIX),).o
>> +CPPFLAGS_$(vdso_lds) += -P -C -U$(ARCH)
>>  ifneq ($(filter vgettimeofday, $(vdso-syms)),)
>> -CPPFLAGS_vdso.lds += -DHAS_VGETTIMEOFDAY
>> +CPPFLAGS_$(vdso_lds) += -DHAS_VGETTIMEOFDAY
>>  endif
>>
>>  # Disable -pg to prevent insert call site
>> @@ -63,12 +74,12 @@ CFLAGS_REMOVE_getrandom.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
>>  CFLAGS_REMOVE_hwprobe.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
>>
>>  # Force dependency
>> -$(obj)/vdso.o: $(obj)/vdso.so
>> +$(obj)/$(vdso_o): $(obj)/$(vdso_so)
>>
>>  # link rule for the .so file, .lds has to be first
>> -$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
>> +$(obj)/$(vdso_so_dbg): $(obj)/$(vdso_lds) $(obj-vdso) FORCE
>>         $(call if_changed,vdsold_and_check)
>> -LDFLAGS_vdso.so.dbg = -shared -soname=linux-vdso.so.1 \
>> +LDFLAGS_$(vdso_so_dbg) = -shared -soname=linux-vdso.so.1 \
>>         --build-id=sha1 --eh-frame-hdr
>>
>>  # strip rule for the .so file
>> @@ -79,9 +90,9 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
>>  # Generate VDSO offsets using helper script
>>  gen-vdsosym := $(src)/gen_vdso_offsets.sh
>>  quiet_cmd_vdsosym = VDSOSYM $@
>> -       cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
>> +       cmd_vdsosym = $(NM) $< | $(gen-vdsosym) $(OFFSET_SUFFIX) | LC_ALL=C sort > $@
>>
>> -include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
>> +include/generated/$(vdso_offsets): $(obj)/$(vdso_so_dbg) FORCE
>>         $(call if_changed,vdsosym)
>>
>>  # actual build commands
>> diff --git a/arch/riscv/kernel/vdso/gen_vdso_offsets.sh b/arch/riscv/kernel/vdso/gen_vdso_offsets.sh
>> index c2e5613f3495..bd5d5afaaa14 100755
>> --- a/arch/riscv/kernel/vdso/gen_vdso_offsets.sh
>> +++ b/arch/riscv/kernel/vdso/gen_vdso_offsets.sh
>> @@ -2,4 +2,6 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>
>>  LC_ALL=C
>> -sed -n -e 's/^[0]\+\(0[0-9a-fA-F]*\) . \(__vdso_[a-zA-Z0-9_]*\)$/\#define \2_offset\t0x\1/p'
>> +SUFFIX=${1:-""}
>> +sed -n -e \
>> +'s/^[0]\+\(0[0-9a-fA-F]*\) . \(__vdso_[a-zA-Z0-9_]*\)$/\#define \2'$SUFFIX'_offset\t0x\1/p'
>> diff --git a/arch/riscv/kernel/vdso_cfi/Makefile b/arch/riscv/kernel/vdso_cfi/Makefile
>> new file mode 100644
>> index 000000000000..8ebd190782b0
>> --- /dev/null
>> +++ b/arch/riscv/kernel/vdso_cfi/Makefile
>> @@ -0,0 +1,25 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +# RISC-V VDSO CFI Makefile
>> +# This Makefile builds the VDSO with CFI support when CONFIG_RISCV_USER_CFI is enabled
>> +
>> +# setting VDSO_CFI_BUILD triggers build for vdso differently
>> +VDSO_CFI_BUILD := 1
>> +
>> +# Set the source directory to the main vdso directory
>> +src := $(srctree)/arch/riscv/kernel/vdso
>> +
>> +# Copy all .S and .c files from vdso directory to vdso_cfi object build directory
>> +vdso_c_sources := $(wildcard $(src)/*.c)
>> +vdso_S_sources := $(wildcard $(src)/*.S)
>> +vdso_c_objects := $(addprefix $(obj)/, $(notdir $(vdso_c_sources)))
>> +vdso_S_objects := $(addprefix $(obj)/, $(notdir $(vdso_S_sources)))
>> +
>> +$(vdso_S_objects): $(obj)/%.S: $(src)/%.S
>> +       $(Q)cp $< $@
>> +
>> +$(vdso_c_objects): $(obj)/%.c: $(src)/%.c
>> +       $(Q)cp $< $@
>> +
>> +# Include the main VDSO Makefile which contains all the build rules and sources
>> +# The VDSO_CFI_BUILD variable will be passed to it to enable CFI compilation
>> +include $(src)/Makefile
>> diff --git a/arch/riscv/kernel/vdso_cfi/vdso-cfi.S b/arch/riscv/kernel/vdso_cfi/vdso-cfi.S
>> new file mode 100644
>> index 000000000000..d426f6accb35
>> --- /dev/null
>> +++ b/arch/riscv/kernel/vdso_cfi/vdso-cfi.S
>> @@ -0,0 +1,11 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright 2025 Rivos, Inc
>> + */
>> +
>> +#define        vdso_start      vdso_cfi_start
>> +#define        vdso_end        vdso_cfi_end
>> +
>> +#define __VDSO_PATH "arch/riscv/kernel/vdso_cfi/vdso-cfi.so"
>> +
>> +#include "../vdso/vdso.S"
>>
>> --
>> 2.43.0
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

