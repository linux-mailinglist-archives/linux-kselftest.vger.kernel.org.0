Return-Path: <linux-kselftest+bounces-32832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2CEAB3015
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 08:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A3C1891644
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 06:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB8424BC04;
	Mon, 12 May 2025 06:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEVlwO9f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEBF20326;
	Mon, 12 May 2025 06:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747032839; cv=none; b=DWJDaVXYYwz3Qq1/RJuGVLwhJZYh2drZjgVHSKMa3AVrKrow7VllF2QRHC4GRqMlIc48tbZ3+poc5RMxXXAs3n6YjGO5xuoJPoLbHz41Hm3FDZXcIGCIMapyG6hg+KRvp/l46asggfdyt6HUzCQobcL/h/NzgDxzOBgqc5P5GXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747032839; c=relaxed/simple;
	bh=mh+sdmR3x5Rbvl556oXQ+b9KXmClWHYBqf3INe3CBIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sw6yYS6bNnKRNrrBCn0h8Kx6Prgyq/vVIgj/cdR8hOOLqbvZs3PZ/EixZLjih+wcahH7DypXKyOM6uOTs6gS3ga6gXpkoawRT7BoWiJrnp0Vwov2wvatamfSUAYnlwksuCMyg4991nB3ImOSVjjkW3LmRuOYdDZIjM9Y/i9INR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEVlwO9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054A0C4CEE7;
	Mon, 12 May 2025 06:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747032839;
	bh=mh+sdmR3x5Rbvl556oXQ+b9KXmClWHYBqf3INe3CBIM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TEVlwO9fPqb4KYxcSKok/3WWhh6Roy+HMyg2gazSODgwSIPiMZt89NLxTz9jeLXSw
	 7iy2n9cSfsXdDvGTqj1lacaUwnNaUGV2Q+aAbn1QpyvW0mWL/uuyoKaa04ypQYIEac
	 t1OlcqyETToELo9ndHjwmq1NBU/Tl9yVgMXaNqtJSNTRL4OrpV3RZWoMAtUMNtqMbg
	 /NXw89QfB3vH+axLTuqRCdJonifYLpwj0mkJ1OBUkGeAide2Q5V4hJ9gLYpOlS1Mkh
	 EEVBVT4LzTUfVMhfmpMIPy2101HzN1uJDj4o8xDLIi66NPmvA/DbF1a14isvkK2DlB
	 xxh1eLdPqs1vw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5feb22e7d84so501423a12.3;
        Sun, 11 May 2025 23:53:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9B23gPbWkwAetI1fD0PKhKLUr1WnfVxOuxtasV2l2KlmY/c7lk8IdyLk7llKegGPJrEc=@vger.kernel.org, AJvYcCVWQPM3uKvWXbFtAPFpbXC8Z44Tk704VZkIcimMbeJk2kZVwAV1k8ImcESjrJqYmyO0pBUyFhPQYnWEtPeBkKCV@vger.kernel.org, AJvYcCWYd8gQPPs4ZSJcguMxvQ0RBpNF7QycdVY0hoke3kCByjEuKTnDA58jSuhmytgTfcohK/SdJqKek8fmOI1o@vger.kernel.org
X-Gm-Message-State: AOJu0YytDFIiSKxoTBc0y7kJakJGnXgrOLgJl8YnBzA3zgBF4lMPH2cW
	InxegtOT8fUNvptq8HUFpgyRNkdgDElQPjVx71pI55YNBTM7avPVn29NutA2xdD+bHrboaK7veZ
	t55XvKvNrcVflduoVOqVD45YWL+I=
X-Google-Smtp-Source: AGHT+IGYRY0B10vegQmafQSE8DUSAPwKI0y7cXH+07quA4LOc9ROMYRJ/NbsjsQKA9jnOXY8pQ4n1aGH9LYo+ms3Ukc=
X-Received: by 2002:a05:6402:239c:b0:5fc:a51c:149 with SMTP id
 4fb4d7f45d1cf-5fca51c13acmr7690374a12.15.1747032837537; Sun, 11 May 2025
 23:53:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250427064535.242404-1-maobibo@loongson.cn>
In-Reply-To: <20250427064535.242404-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 12 May 2025 14:53:48 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7XmHcvea-8NvgnSzfg6dVt5wATyDKmDYp31ThYZa+Fgw@mail.gmail.com>
X-Gm-Features: AX0GCFuW_0esH8fIIs24kGTOZ9DFkLfLl9d7hy6t1OtIT5_MwJ3ZMPQwKcpHYSM
Message-ID: <CAAhV-H7XmHcvea-8NvgnSzfg6dVt5wATyDKmDYp31ThYZa+Fgw@mail.gmail.com>
Subject: Re: [PATCH v11 0/5] KVM: selftests: Add LoongArch support
To: Bibo Mao <maobibo@loongson.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Sun, Apr 27, 2025 at 2:45=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> This patchset adds KVM selftests for LoongArch system, currently only
> some common test cases are supported and pass to run. These test cases
> are listed as following:
>     coalesced_io_test
>     demand_paging_test
>     dirty_log_perf_test
>     dirty_log_test
>     guest_print_test
>     hardware_disable_test
>     kvm_binary_stats_test
>     kvm_create_max_vcpus
>     kvm_page_table_test
>     memslot_modification_stress_test
>     memslot_perf_test
>     set_memory_region_test
I have applied this series [1] but with some modifications (see
comments in other patches). You can test it to see if everything is
OK.

And if it's OK, it is better to fetch the patches from [1] and then send V1=
2.

[1] https://github.com/chenhuacai/linux/commits/loongarch-next



Huacai

>
> ---
> Changes in v11:
> 1. Fix a typo issue in notes of patch 2, it is kvm_util_arch.h rather tha=
n
>    kvm_util_base.h
>
> Changes in v10:
> 1. Add PS_64K and remove PS_8K in file include/loongarch/processor.h
> 2. Fix a typo issue in file lib/loongarch/processor.c
> 3. Update file MAINTAINERS about LoongArch KVM selftests
>
> Changes in v9:
> 1. Add vm mode VM_MODE_P47V47_16K, LoongArch VM uses this mode by
>    default, rather than VM_MODE_P36V47_16K.
> 2. Refresh some spelling issues in changelog.
>
> Changes in v8:
> 1. Porting patch based on the latest version.
> 2. For macro PC_OFFSET_EXREGS, offsetof() method is used for C header fil=
e,
>    still hardcoded definition for assemble language.
>
> Changes in v7:
> 1. Refine code to add LoongArch support in test case
> set_memory_region_test.
>
> Changes in v6:
> 1. Refresh the patch based on latest kernel 6.8-rc1, add LoongArch
> support about testcase set_memory_region_test.
> 2. Add hardware_disable_test test case.
> 3. Drop modification about macro DEFAULT_GUEST_TEST_MEM, it is problem
> of LoongArch binutils, this issue is raised to LoongArch binutils owners.
>
> Changes in v5:
> 1. In LoongArch kvm self tests, the DEFAULT_GUEST_TEST_MEM could be
> 0x130000000, it is different from the default value in memstress.h.
> So we Move the definition of DEFAULT_GUEST_TEST_MEM into LoongArch
> ucall.h, and add 'ifndef' condition for DEFAULT_GUEST_TEST_MEM
> in memstress.h.
>
> Changes in v4:
> 1. Remove the based-on flag, as the LoongArch KVM patch series
> have been accepted by Linux kernel, so this can be applied directly
> in kernel.
>
> Changes in v3:
> 1. Improve implementation of LoongArch VM page walk.
> 2. Add exception handler for LoongArch.
> 3. Add dirty_log_test, dirty_log_perf_test, guest_print_test
> test cases for LoongArch.
> 4. Add __ASSEMBLER__ macro to distinguish asm file and c file.
> 5. Move ucall_arch_do_ucall to the header file and make it as
> static inline to avoid function calls.
> 6. Change the DEFAULT_GUEST_TEST_MEM base addr for LoongArch.
>
> Changes in v2:
> 1. We should use ".balign 4096" to align the assemble code with 4K in
> exception.S instead of "align 12".
> 2. LoongArch only supports 3 or 4 levels page tables, so we remove the
> hanlders for 2-levels page table.
> 3. Remove the DEFAULT_LOONGARCH_GUEST_STACK_VADDR_MIN and use the common
> DEFAULT_GUEST_STACK_VADDR_MIN to allocate stack memory in guest.
> 4. Reorganize the test cases supported by LoongArch.
> 5. Fix some code comments.
> 6. Add kvm_binary_stats_test test case into LoongArch KVM selftests.
> ---
> Bibo Mao (5):
>   KVM: selftests: Add VM_MODE_P47V47_16K VM mode
>   KVM: selftests: Add KVM selftests header files for LoongArch
>   KVM: selftests: Add core KVM selftests support for LoongArch
>   KVM: selftests: Add ucall test support for LoongArch
>   KVM: selftests: Add test cases for LoongArch
>
>  MAINTAINERS                                   |   2 +
>  tools/testing/selftests/kvm/Makefile          |   2 +-
>  tools/testing/selftests/kvm/Makefile.kvm      |  18 +
>  .../testing/selftests/kvm/include/kvm_util.h  |   6 +
>  .../kvm/include/loongarch/kvm_util_arch.h     |   7 +
>  .../kvm/include/loongarch/processor.h         | 141 ++++++++
>  .../selftests/kvm/include/loongarch/ucall.h   |  20 +
>  tools/testing/selftests/kvm/lib/kvm_util.c    |   3 +
>  .../selftests/kvm/lib/loongarch/exception.S   |  59 +++
>  .../selftests/kvm/lib/loongarch/processor.c   | 342 ++++++++++++++++++
>  .../selftests/kvm/lib/loongarch/ucall.c       |  38 ++
>  .../selftests/kvm/set_memory_region_test.c    |   2 +-
>  12 files changed, 638 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/loongarch/kvm_uti=
l_arch.h
>  create mode 100644 tools/testing/selftests/kvm/include/loongarch/process=
or.h
>  create mode 100644 tools/testing/selftests/kvm/include/loongarch/ucall.h
>  create mode 100644 tools/testing/selftests/kvm/lib/loongarch/exception.S
>  create mode 100644 tools/testing/selftests/kvm/lib/loongarch/processor.c
>  create mode 100644 tools/testing/selftests/kvm/lib/loongarch/ucall.c
>
>
> base-commit: 5bc1018675ec28a8a60d83b378d8c3991faa5a27
> --
> 2.39.3
>

