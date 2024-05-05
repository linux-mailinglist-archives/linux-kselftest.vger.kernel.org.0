Return-Path: <linux-kselftest+bounces-9494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A25938BC48F
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 00:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589F11F21706
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 22:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5D213FD8C;
	Sun,  5 May 2024 22:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkZzbUlR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9162B757E0;
	Sun,  5 May 2024 22:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714948582; cv=none; b=s0tCDHRn+YSTeIw/yv2CzuSXlivFKFo/RBGoF8yeDqpnwuwPMSqHfQN8HWkCz7GMldNjp5e/r9d+DEoWs5qO0RlNSlYMV9oCaQgJzd8yB+vd3XvUbOEqzJWYovpxiMWJQGRpijS5RYb7cfPSwlwe46CWSDjrRkHAJJHIql2Xz84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714948582; c=relaxed/simple;
	bh=6DdcTaAGg/9kv6PU0U5dfTC1o4/Oa9oCpynq/HkvFyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdwboIfGaKubT9LqCev3OrsWh8AMm9UaR4m+12L2sNwfu5ZfwQViQkp9RSI5DGci4oRfE8YZWI5BtkLcoolekGWA3Sl60Nv10xYsWG5MRN+aDJoOLnaVZmgx9ZkcUyTk8UZv9jCP76mvqfLJBwLJ/qk/XH22kaCrx+WksKm8N7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkZzbUlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502F4C113CC;
	Sun,  5 May 2024 22:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714948582;
	bh=6DdcTaAGg/9kv6PU0U5dfTC1o4/Oa9oCpynq/HkvFyg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bkZzbUlR5RiWYKmj0+xKiIBrCK6V2XGHNdOfsQMdc7kC5oIk9ujoB87YNhvkJN1UF
	 JcfJJ3MTUi0+GI8SZ1NIjNoJmCSwTiOl+/H69DHkXDeuU1GeolP/qIal/UgOBagwT/
	 Tk49pP7TLrNccuT1KdQp5mjeg4Ds7VTS9ESjxQZkC2/AoNjJOoMER7RyQgov8hEorC
	 WrIPwjlrRXc/tqBVezQGmPp6meCil7wpvacxv6f7YJMAqQLiRgLnwOywCY79fejLLD
	 vZ3OFwLCPseKuBUDjUcSFYUwCv58YzIwnSwkANcjvTqwCOxXo1uHjO1197ooL6HjP3
	 ErQiXXbMyXlrg==
Message-ID: <4f947691-bf25-460b-bc08-da29de3fdaa6@kernel.org>
Date: Sun, 5 May 2024 23:36:14 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] bpftool, selftests/hid/bpf: fix 29 clang warnings
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Justin Stitt <justinstitt@google.com>,
 Peter Hutterer <peter.hutterer@who-t.net>,
 Jason Gerecke <jason.gerecke@wacom.com>,
 Joshua Dickens <joshua@joshua-dickens.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-input@vger.kernel.org, Valentin Obst <kernel@valentinobst.de>,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 llvm@lists.linux.dev
References: <20240505215636.63592-1-jhubbard@nvidia.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20240505215636.63592-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/05/2024 22:56, John Hubbard wrote:
> When building either tools/bpf/bpftool, or tools/testing/selftests/hid,
> (the same Makefile is used for these), clang generates many instances of
> a warning that is useless here:
> 
>     "clang: warning: -lLLVM-17: 'linker' input unused"
> 
> Silence this in both locations, by disabling that warning when building
> with clang.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  tools/bpf/bpftool/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index e9154ace80ff..c7457921d136 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -133,6 +133,10 @@ CFLAGS += -DUSE_LIBCAP
>  LIBS += -lcap
>  endif
>  
> +ifneq ($(LLVM),)
> +    CFLAGS += -Wno-unused-command-line-argument
> +endif
Thanks! If possible, I'd rather keep the warning enabled, and fix the
command line instead. Looking at the error and the Makefile, we may not 
need the -lLLVM<version> in the CFLAGS at all, but only in $(LIBS). On
my setup, I can build successfully, without the warnings, with the
following patch:

------
diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index b67454b45a49..dfa4f1bebbb3 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -147,7 +147,7 @@ ifeq ($(feature-llvm),1)
   # If LLVM is available, use it for JIT disassembly
   CFLAGS  += -DHAVE_LLVM_SUPPORT
   LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
-  CFLAGS  += $(shell $(LLVM_CONFIG) --cflags --libs $(LLVM_CONFIG_LIB_COMPONENTS))
+  CFLAGS  += $(shell $(LLVM_CONFIG) --cflags)
   LIBS    += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
   ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
     LIBS += $(shell $(LLVM_CONFIG) --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
------

Could you please check whether that works on your side, too?

Quentin

