Return-Path: <linux-kselftest+bounces-46052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 474E6C71EC6
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 04:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 7BCEC2B1C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 03:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68372FC00E;
	Thu, 20 Nov 2025 03:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gmTMIGEy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1192E0415
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 03:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763607911; cv=none; b=AsMlhVYUHmMMsFzuA29P1MQyIQ81gkjCt2JS4+xCoHJVPDem3Xm+1LgiZdkYrOwa6W01l2VkavTHXgdcSJagOXLDdq+x5bD0MHYZV06qih7eDvCr3RdIl9EQyuz/1j59jHQi3nICy//A4hcDtKuMAgdSW7MsEb0O8AGjuoL1Upc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763607911; c=relaxed/simple;
	bh=uPYbHox/+V283sb8om2P37+Ret4HbJlps5xc8E1rk6o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eRqFrPgO5B+6ptXOQd4mOtChySAEAzXYsTlmEArr88suxEgB5QHhH0qBZhP+KSvW7YWU9nt8zxwz4Z0zFqAzZ8vQMV1hMVaA2C/4iYhk5sDbrF24ooU4MFnyHVdP7b6x1S0nhBotnNGq+mOfPi9atQ3NYW8hFPod9xnCahLApWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gmTMIGEy; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763607897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mp9GsOxlS5mfbOTt7JkQadj8FOcXU3nLzOqalaTK7J8=;
	b=gmTMIGEy3i6I93R2sPQbtMUa79JbcV5wpW+rsn0T1+//CcMXZPMpTsNMKh0WgfL2rmzhgq
	ADk90CoVVwjbe3RjNiViIqT8mC2EN5Jomd5GyIkHb+plaECxd3MqAnCY1lrWF0ponxW9M7
	l2DfKVoplZebUgVFAX6ZaGNYgOU5h80=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>,  Shakeel Butt
 <shakeel.butt@linux.dev>,  Muchun Song <muchun.song@linux.dev>,  Alexei
 Starovoitov <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Andrii Nakryiko <andrii@kernel.org>,  Martin KaFai Lau
 <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,  Song Liu
 <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  John
 Fastabend <john.fastabend@gmail.com>,  KP Singh <kpsingh@kernel.org>,
  Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>,  Jiri
 Olsa <jolsa@kernel.org>,  Shuah Khan <shuah@kernel.org>,  Peter Zijlstra
 <peterz@infradead.org>,  Miguel Ojeda <ojeda@kernel.org>,  Nathan
 Chancellor <nathan@kernel.org>,  Kees Cook <kees@kernel.org>,  Tejun Heo
 <tj@kernel.org>,  Jeff Xu <jeffxu@chromium.org>,  mkoutny@suse.com,  Jan
 Hendrik Farr <kernel@jfarr.cc>,  Christian Brauner <brauner@kernel.org>,
  Randy Dunlap <rdunlap@infradead.org>,  Brian Gerst <brgerst@gmail.com>,
  Masahiro Yamada <masahiroy@kernel.org>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  cgroups@vger.kernel.org,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH 0/3] Memory Controller eBPF support
In-Reply-To: <cover.1763457705.git.zhuhui@kylinos.cn> (Hui Zhu's message of
	"Wed, 19 Nov 2025 09:34:05 +0800")
References: <cover.1763457705.git.zhuhui@kylinos.cn>
Date: Wed, 19 Nov 2025 19:04:44 -0800
Message-ID: <87ldk1mmk3.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Hui Zhu <hui.zhu@linux.dev> writes:

> From: Hui Zhu <zhuhui@kylinos.cn>
>
> This series proposes adding eBPF support to the Linux memory
> controller, enabling dynamic and extensible memory management
> policies at runtime.
>
> Background
>
> The memory controller (memcg) currently provides fixed memory
> accounting and reclamation policies through static kernel code.
> This limits flexibility for specialized workloads and use cases
> that require custom memory management strategies.
>
> By enabling eBPF programs to hook into key memory control
> operations, administrators can implement custom policies without
> recompiling the kernel, while maintaining the safety guarantees
> provided by the BPF verifier.
>
> Use Cases
>
> 1. Custom memory reclamation strategies for specialized workloads
> 2. Dynamic memory pressure monitoring and telemetry
> 3. Memory accounting adjustments based on runtime conditions
> 4. Integration with container orchestration systems for
>    intelligent resource management
> 5. Research and experimentation with novel memory management
>    algorithms
>
> Design Overview
>
> This series introduces:
>
> 1. A new BPF struct ops type (`memcg_ops`) that allows eBPF
>    programs to implement custom behavior for memory charging
>    operations.
>
> 2. A hook point in the `try_charge_memcg()` fast path that
>    invokes registered eBPF programs to determine if custom
>    memory management should be applied.
>
> 3. The eBPF handler can inspect memory cgroup context and
>    optionally modify certain parameters (e.g., `nr_pages` for
>    reclamation size).
>
> 4. A reference counting mechanism using `percpu_ref` to safely
>    manage the lifecycle of registered eBPF struct ops instances.

Can you please describe how these hooks will be used in practice?
What's the problem you can solve with it and can't without?

I generally agree with an idea to use BPF for various memcg-related
policies, but I'm not sure how specific callbacks can be used in
practice.

Thanks!

