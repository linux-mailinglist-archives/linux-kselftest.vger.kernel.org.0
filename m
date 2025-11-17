Return-Path: <linux-kselftest+bounces-45715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95513C62779
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 07:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D2394E63A9
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 06:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760BB2D6E59;
	Mon, 17 Nov 2025 06:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y209mvOS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736684C9D
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 06:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763359478; cv=none; b=avIpijb5Fo1wnB04p19D1G0+qMRI8IvGWOvIUPxIpVUo49frFSIoWk1asB3tINYfXyXq5fgW8SSLY0jIZKjMqymz6+45vRTe2jNN5mqguALVYeihJPtjufqUEygzKOo4x7vs2i8vQM7U5ATnsJm2LMk8pFRe6SWfwJiEWQ3FTfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763359478; c=relaxed/simple;
	bh=hm8EksoT+/2DgQxjoNjEl6sU6Krkby9Edu+5zlSFhUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=suzNFxiB99hXH48fN5cSPuuqFq1F2FfYOgiAzP58T6X/wqcSeKhJXjDDaimKaQY7QQMCWfz3ZqsZg1VRdELFqULd8wJ7N0U+bSdvN0QwKvAtoWD6dDhec7i7LLBxpUGqsN8wNB8A0mJH31xX+DEnTRLsz14dwDrF7Rxd7BICfbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y209mvOS; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fa987c2b-b806-4aa7-a318-812fc7d0f414@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763359464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZ5qcZGVMGt/z/po/hYAoZDHUji+2tgr7hoNqPgP1tY=;
	b=Y209mvOS+8SFicxLVtTN/H4nWqCGMOmkm6X2ejyNYHLyj6Lw6/L1tocqVNo0ioSsv5HDss
	L6RqtEQzeUUFksMAdOTyCHffKPnKfv72Nx3jzIA/sa+DG58xavSohzFrx7b0XfySp17lD+
	J9YCIG2yFe4crEL+74N3EFCzPHqPz+A=
Date: Sun, 16 Nov 2025 22:04:15 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [bpf-next v1 5/5] selftests/bpf: propagate LLVM toolchain to
 runqslower build
Content-Language: en-GB
To: Hoyeon Lee <hoyeon.lee@suse.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20251115225550.1086693-1-hoyeon.lee@suse.com>
 <20251115225550.1086693-6-hoyeon.lee@suse.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251115225550.1086693-6-hoyeon.lee@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/15/25 2:55 PM, Hoyeon Lee wrote:
> The selftests/bpf invokes a nested make when building runqslower, but
> LLVM toolchain version (clang/llvm-strip) is not propagated. As a
> result, runqslower is built with system default clang, not respecting
> specified LLVM version.
>
>      # LLVM=-21 make -C tools/testing/selftests/bpf
>      ...
>      make feature_display=0 -C /bpf/tools/bpf/runqslower                        \
>          OUTPUT=/bpf/tools/testing/selftests/bpf/tools/build/runqslower/        \
>          BPFOBJ_OUTPUT=/bpf/tools/testing/selftests/bpf/tools/build/libbpf/     \
>          BPFOBJ=/bpf/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a    \
>          BPF_INCLUDE=/bpf/tools/testing/selftests/bpf/tools/include             \
>          BPFTOOL_OUTPUT=/bpf/tools/testing/selftests/bpf/tools/build/bpftool/   \
>          VMLINUX_BTF=/sys/kernel/btf/vmlinux BPF_TARGET_ENDIAN=--target=bpfel   \
>          EXTRA_CFLAGS='-g -O0  ' EXTRA_LDFLAGS=' ' &&                           \
>          cp  /bpf/tools/testing/selftests/bpf/tools/build/runqslower/runqslower \
>              /bpf/tools/testing/selftests/bpf/runqslower
>      clang -g -O2 --target=bpfel -I/bpf/tools/testing/selftests/bpf/tools/build/runqslower/ \
>            -I/bpf/tools/testing/selftests/bpf/tools/include -I/bpf/tools/include/uapi       \
>            -c runqslower.bpf.c -o /bpf/tools/testing/selftests/bpf/tools/build/runqslower/runqslower.bpf.o && \
>            llvm-strip -g /bpf/tools/testing/selftests/bpf/tools/build/runqslower//runqslower.bpf.o
>      /bin/sh: 1: clang: not found

I tried with LLVM=-20 make -C tools/testing/selftests/bpf in my system and
there is no build error.

Also could you try with command line
    make -C tools/testing/selftests/bpf LLVM=1
for clang build kernel or selftests, LLVM=1 is recommended as it
encodes a bunch of clang command lines:
   CC              = $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
   LD              = $(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX)
   AR              = $(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX)
   NM              = $(LLVM_PREFIX)llvm-nm$(LLVM_SUFFIX)
   OBJCOPY         = $(LLVM_PREFIX)llvm-objcopy$(LLVM_SUFFIX)
   OBJDUMP         = $(LLVM_PREFIX)llvm-objdump$(LLVM_SUFFIX)
   READELF         = $(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX)
   STRIP           = $(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX)




>
> Explicitly propagate CLANG and LLVM_STRIP to the runqslower sub-make so
> that the LLVM toolchain selection from lib.mk is preserved.
>
> Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> ---
>   tools/testing/selftests/bpf/Makefile | 1 +
>   tools/testing/selftests/lib.mk       | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 34ea23c63bd5..79ab69920dca 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -306,6 +306,7 @@ endif
>   
>   $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) $(RUNQSLOWER_OUTPUT)
>   	$(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower	       \
> +		    CLANG=$(CLANG) LLVM_STRIP=$(LLVM_STRIP)		       \
>   		    OUTPUT=$(RUNQSLOWER_OUTPUT) VMLINUX_BTF=$(VMLINUX_BTF)     \
>   		    BPFTOOL_OUTPUT=$(HOST_BUILD_DIR)/bpftool/		       \
>   		    BPFOBJ_OUTPUT=$(BUILD_DIR)/libbpf/			       \
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index a448fae57831..f14255b2afbd 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -8,6 +8,7 @@ LLVM_SUFFIX := $(LLVM)
>   endif
>   
>   CLANG := $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
> +LLVM_STRIP := $(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX)
>   
>   CLANG_TARGET_FLAGS_arm          := arm-linux-gnueabi
>   CLANG_TARGET_FLAGS_arm64        := aarch64-linux-gnu


