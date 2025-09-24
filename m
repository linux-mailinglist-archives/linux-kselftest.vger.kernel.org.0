Return-Path: <linux-kselftest+bounces-42234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F036B9B88F
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 20:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB676325D78
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 18:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F5331A059;
	Wed, 24 Sep 2025 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="al9T90qi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E151FDD
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739224; cv=none; b=buPI0RcDKs8TXBrg7YLSjPsPg6xzQwuiAuUHiuGRReJlsKWSOPS1KZcH24L4pPN6XUUAMmEl2cwUubeXbDn0zEgEnvBd2hfIILnGAwPzVKW1WdM2EI+QVVzu9bRrqsMONR4sdWycim4DXt0WVKxYUgHc6XxaNJzwj+T1XjIfbvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739224; c=relaxed/simple;
	bh=Lz5nNPc99WsglaCwylBBNPoIg34qFlQe9Q2dS/0RE9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGIsJHWWjSM2BT792nzSt4PgR7jtXm25RxICqw1+AC3RshhphBNzLSKn6uHcpfWBlNqOJhVmALjk8sZQ7BO4U+R+awtbAKEm/5Boa8r9FeaBAXuvkMMPLtItiN47xMdgTr8/N1imKKCdOnWL5zN+8Avp7VDDvFDNWJkKsz1K5HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=al9T90qi; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-273a0aeed57so15374265ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 11:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1758739222; x=1759344022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CmJ3vOxzWTYE+jCZQu9PTb3XdXqCFWVRNB5Wst4HaN8=;
        b=al9T90qi45syUvEyts/v+tutJF/mx8ogbgoIi5d3JlDp63HZR4Nqfw8C23i7O0yZj2
         iaJ1IzDNUtU7hkDgTSrtKIX7FQ9jOp/IRZIiJCw2mNfiCEFeIHeuDPf4p5NTVyGqzu2q
         1bi3ia4OLSqW6hvl7tytYz3ssMXe7efg1DU4iUddAo3SXj8T3oqISz9E1SS+OYxBqo4R
         aATgP4fZnilcnkRwbfcB5tiSwYvTGpP1gq1u5+aD88dLFk480RmH90ubqHByExx9zmW1
         E3BzmFp646U+cYitas3/u8u/yyOvOZDqZcIQRSDEuZqAF2hwARthaM730AhGp2xwLESf
         Ca/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758739222; x=1759344022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmJ3vOxzWTYE+jCZQu9PTb3XdXqCFWVRNB5Wst4HaN8=;
        b=DhuNwTwzb3hOQ0/kpk0+MWhgoBMvC3XM2abfG9xtO2oZc4lBkdXymaIQCJItCRXp+Q
         2s+31Q6/JWJJbuKHe6iSxFtajW1nYsjLb46TPiFzb+tvvLIWCCiV+66p5Ea+hJkwm17f
         TFMFXMGxaFGNXizkQzK63wsP9tHhjxmjZzduAY6YPGYDPtI4r4mRDA0iBsZ0QpwYfBDq
         AWgIktoz3ih1XKeyTxK3qGIDfEwvXBU5qlirEGa35zv4A5E20tgEnTyPvWw/bWoZdKd7
         0METds5bkuHQ2ajz5sJ/A0FUFp2JywH03tOMQ99VzHfhtE2USSBSrBAwShq6S0aTaS0h
         c2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCViMymvEyyp4tloSfaXJljNx31IRuKyC1VtgG/39pLwcYVggDmmx51+onhMkKOZU2UVAXf1CiiWbQc7n7f5rPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb/d3M5Q2963SAUzUySGgVy9ISN2QFmVMusF62cPtLB7RZ0eoo
	D+uMb4hFIdko7a3EvkezqKEC3bD1e/WwUd7d9Ap0+q1VBxO+Ed42AXrl+Ru/O27NgqA=
X-Gm-Gg: ASbGnct4qP3HHwAUFU//2bjomV38qTtq0EPkV/cHGwNutuFlMQJV+b/QVOPWOidp7AZ
	0pAqKZFsxUv9wBcAyC1dtDf3weeQlGi64XebC/rUuKvhHDZTU+NDF9Fe8SsW/OwKKrS9BjfBYic
	bL61iXdtB3oVvAU07J3ZJhyMALhRu9F02Qf/moUKCIHF9cjzWLcqRxSd/fZCZ5R7ss5j2uCKjnA
	x3ZLlXg+R9RJe7XLoIjGy5pyG5uatyVb+yAlBAFJqiZq3HJdxXyM9rHIETU2JPadrrh0yStgciN
	l64cAF46vCw/L+ZAU/gCdfXXzxhdRWfflO0QU9P12jLv6E3NCtr4yXrryqzOlmFIp9J8HTH4+MZ
	VwgsApug0Fl8zUEZvgLcyqBrTjM5u4213
X-Google-Smtp-Source: AGHT+IGXuHXHBWPf+oE+Ln4Jp/4CaKr0teMjK8nrYhSg666HYgvhIXatAPi5gWQsQGiN1OujHcfx1A==
X-Received: by 2002:a17:902:e790:b0:24b:270e:56d4 with SMTP id d9443c01a7336-27ed4c67b42mr6992845ad.4.1758739219414;
        Wed, 24 Sep 2025 11:40:19 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698035ddcasm198787335ad.142.2025.09.24.11.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 11:40:18 -0700 (PDT)
Date: Wed, 24 Sep 2025 11:40:15 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Paul Walmsley <pjw@kernel.org>
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
	Andy Chiu <andybnac@gmail.com>, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org,
	Zong Li <zong.li@sifive.com>, David Hildenbrand <david@redhat.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Florian Weimer <fweimer@redhat.com>, bharrington@redhat.com,
	Aurelien Jarno <aurel32@debian.org>
Subject: Re: [PATCH v19 00/27] riscv control-flow integrity for usermode
Message-ID: <aNQ7D6_ZYMhCdkmL@debug.ba.rivosinc.com>
References: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
 <f953ee7b-91b3-f6f5-6955-b4a138f16dbc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f953ee7b-91b3-f6f5-6955-b4a138f16dbc@kernel.org>

On Wed, Sep 24, 2025 at 08:36:11AM -0600, Paul Walmsley wrote:
>Hi,
>
>On Thu, 31 Jul 2025, Deepak Gupta wrote:
>
>[ ... ]
>
>> vDSO related Opens (in the flux)
>> =================================
>>
>> I am listing these opens for laying out plan and what to expect in future
>> patch sets. And of course for the sake of discussion.
>>
>
>[ ... ]
>
>> How many vDSOs
>> ---------------
>> Shadow stack instructions are carved out of zimop (may be operations) and if CPU
>> doesn't implement zimop, they're illegal instructions. Kernel could be running on
>> a CPU which may or may not implement zimop. And thus kernel will have to carry 2
>> different vDSOs and expose the appropriate one depending on whether CPU implements
>> zimop or not.
>
>If we merge this series without this, then when CFI is enabled in the
>Kconfig, we'll wind up with a non-portable kernel that won't run on older
>hardware.  We go to great lengths to enable kernel binary portability
>across the presence or absence of other RISC-V extensions, and I think
>these CFI extensions should be no different.
>
>So before considering this for merging, I'd like to see at least an
>attempt to implement the dual-vDSO approach (or something equivalent)
>where the same kernel binary with CFI enabled can run on both pre-Zimop
>and post-Zimop hardware, with the existing userspaces that are common
>today.

Added some distro folks in this email chain.

After patchwork meeting today, I wanted to continue discussion here. So thanks
Paul for looking into it and initiating a discussion here.

This patch series has been in the queue for quite a long time and we have had
deliberations on vDSO topic earlier as well and after those deliberations it
was decided to go ahead with merge and it indeed was sent for 6.17 merge
window. Unfortunatley due to other unforeseen reasons, entirety of riscv
changes were not picked. So it's a bit disappointing to see back-paddling on
this topic.

Anyways, we are here. So I'll provide a bit of context for the list about
deliberations and discussions we have been having for so many merge windows.
This so that a holistic discussion can happen on this before we make a
decision.

Issue
======

Instructions in RISC-V shadow stack extension (zicfiss - [1]) are carved out of
"may be ops" aka zimop extension [2]. "may be ops" are illegal on non-RVA23
hardware. This means any existing riscv CPU or future CPU which isn't RVA23
compliant and not implementing zimop will treat these encodings as illegal.

Current kernel patches enable shadow stack and landing pad support for
userspace using config `CONFIG_RISCV_USER_CFI`. If this config is selected then
vDSO that will be exposed to user space will also have shadow stack
instructions in them. Kernel compiled with `CONFIG_RISCV_USER_CFI`, for sake of
this discussion lets call it RVA23 compiled kernel.

Issue that we discussed earlier and even today is "This RVA23 compiled kernel
won't be able to support non-RVA23 userspace on non-RVA23 hardware because".
Please note that issue exists only on non-RVA23 hardware (which is existing
hardware and future hardware which is not implementing zimop). RVA23 compiled
kernel can support any sort of userspace on RVA23 hardware.


Discussion
===========

So the issue is not really shadow stack instructions but rather may be op
instructions in codegen (binaries and vDSO) which aren't hidden behind any
flag (to hide them if hardware doesn't support). And if I can narrow down
further, primary issue we are discussing is that if cfi is enabled during
kernel compile, it is bringing in a piece of code (vDSO) which won't work
on existing hardware. But the counter point is if someone were to deploy
RVA23 compiled kernel on non-RVA23 hardware, they must have compiled
rest of the userspace without shadow stack instructions in them for such
a hardware. And thus at this point they could simply choose *not* to turn on
`CONFIG_RISCV_USER_CFI` when compiling such kernel. It's not that difficult to
do so.

Any distro who is shipping userspace (which all of them are) along with kernel
will not be shipping two different userspaces (one with shadow stack and one
without them). If distro are shipping two different userspaces, then they might
as well ship two different kernels. Tagging some distro folks here to get their
take on shipping different userspace depending on whether hardware is RVA23 or
not. @Heinrich, @Florian, @redbeard and @Aurelien.

Major distro's have already drawn a distinction here that they will drop
support for hardware which isn't RVA23 for the sake of keeping binary
distribution simple.

Only other use case that was discussed of a powerful linux user who just wants
to use a single kernel on all kinds of riscv hardware. I am imagining such a
user knows enough about kernel and if is really dear to them, they can develop
their own patches and send it upstream to support their own usecase and we can
discuss them out. Current patchset don't prevent such a developer to send such
patches upstream.

I heard the argument in meeting today that "Zbb" enabling works similar for
kernel today. I looked at "Zbb" enabling. It's for kernel usage and it's
surgically placed in kernel using asm hidden behind alternatives. vDSO isn't
compiled with Zbb. Shadow stack instructions are part of codegen for C files
compiled into vDSO.

Furthermore,

Kernel control flow integrity will introduce shadow stack instructions all
over the kernel binary. Such kernel won't be deployable on non-RVA23 hardware.
How to deal with this problem for a savvy kernel developer who wants to run
same cfi enabled kernel binary on multiple hardware?

Coming from engineering and hacker point of view, I understand the desire here
but I still see that it's complexity enforced on rest of the kernel from a user
base which anyways can achieve such goals. For majority of usecases, I don't
see a reason to increase complexity in the kernel for build, possibly runtime
patching and thus possibly introduce more issues and errors just for the sake
of a science project.

Being said that, re-iterating that currently default for `CONFIG_RISCV_USER_CFI`
is "n" which means it won't be breaking anything unless a user opts "Y". So even
though I really don't see a reason and usability to have complexity in kernel to
carry multiple vDSOs, current patchsets are not a hinderance for such future
capability (because current default is No) and motivated developer is welcome
to build on top of it. Bottomline is I don't see a reason to block current
patchset from merging in v6.18.


[1] - https://github.com/riscv/riscv-isa-manual/blob/main/src/unpriv-cfi.adoc#shadow-stack-zicfiss
[2] - https://github.com/riscv/riscv-isa-manual/blob/main/src/zimop.adoc

>
>thanks Deepak,
>
>- Paul

