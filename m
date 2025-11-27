Return-Path: <linux-kselftest+bounces-46604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF0BC8CE6A
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 07:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED223B0E23
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 06:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0311A2F60B2;
	Thu, 27 Nov 2025 06:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZes9LtM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C062C2D6E61;
	Thu, 27 Nov 2025 06:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764223941; cv=none; b=uS0WJlO7ma4MT3p1ETAGVrvzrktK5fK58rQ8npv96Mbx/kGzhX2yIl903CHNYjEljJ2W0wgp5OWmYeQHohX8uhrLla9wrn7vxtwsM/WgnmyGOMYWjz4eNpJGYCY9Z8TiZnZRJEKraegIIp4OH17hRQAPALkc0Ampf+VCFBdHXNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764223941; c=relaxed/simple;
	bh=SHykcjcXOicpMg1lNGih+WJT2lVGik1tv3mTORvyUFI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UqIglBkH/uz2vCYAnLJusir2Aih5HTYneZL1VZ1CaHTg77xxbYjvrrAufcZJOc5tND0l0Ghj/kOeCY+0PeqyueFfj6V/Z8qvT5+eTOmMKl0Vta+rIuTUCa2yXAAHlKUpW31KJ3LuxnDnmKmqX8gUj0pikpSJMCLwHD40owJnvSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZes9LtM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15CAC4CEF8;
	Thu, 27 Nov 2025 06:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764223941;
	bh=SHykcjcXOicpMg1lNGih+WJT2lVGik1tv3mTORvyUFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CZes9LtMRpUZLC/HdCtNbX1O45EyHJ5NqT5DSAkS1zFTOU7JJFu1xtVb2JB5BDP2/
	 4zTCEXCVf/zOPhK+ter+3ufGbdB8OmEF0lgcCEJvlrPaUsZ6HPqY7pXWDrAlCZWenY
	 Y3hGEey1aYjwDAvT2I56cGtfxKMWkvh0cIHMfq3K0K3ZsGJbgWktysaOxOPrTwsHkK
	 io/HCbfq0JWAB/5O4KuUPoZXMpO/YEETkZc3zbJrafmZXMK0F41bY+zuqm6rD8M9QK
	 pYeWbFXStM/G5F8+ZJTxPW2m+vED9c1A1dBAnkHDVYwfaunxQ4Bwl6JgkCtNI4EaiQ
	 LnH4t7QHDpwiA==
Date: Thu, 27 Nov 2025 15:12:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
Cc: rostedt@goodmis.org, corbet@lwn.net, shuah@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Support comma-separated symbols and :entry/:exit
Message-Id: <20251127151218.4763b25c751bb2aac4b1ee36@kernel.org>
In-Reply-To: <20251126184110.72241-1-seokwoo.chung130@gmail.com>
References: <20251126184110.72241-1-seokwoo.chung130@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 13:41:07 -0500
"Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com> wrote:

> Extend fprobe to support list-style filters and explicit entry/exit suffixes.
> Currentyl, fprobe only supports a single symbol (or wildcard) per event.
> This patch allows users to specify a comma-separated list of symbols.
> 
> New Syntax:
> - f:[GRP/][EVENT] func1,func2,func3:entry
> - f:[GRP/][EVENT] func1,func2,func3:exit

Thanks for updating!

> 
> Logic changes:
> - Refactor parsing logic into 'parse_fprobe_spec'
> - Support '!' prefix for exclusion
> - Disable BTF lookup ('ctx->funcname = NULL') when a list or wildcard is used,
>   as a single function signature cannot apply to multiple functions.
> - Reject legacy '%return' suffix when used with lists or wildcards
> - Update tracefs/README
> 
> Testing:
> Verified on x86_64 via QEMU. Checked registration of lists, exclusions, and
> explicit suffixes. Verified rejection of invalid syntax including trailing
> commas and mixed legacy/new syntax.
> 
> Seokwoo Chung (Ryan) (3):
>   docs: tracing/fprobe: Document list filters and :entry/:exit
>   tracing/fprobe: Support comma-separated symbols and :entry/:exit

For the next time, please add docs patch after code change because of bisect.
(Or, include the document update into code update.)

>   selftests/ftrace: Add accept cases for fprobe list syntax

Testing after code is good. :)

Thank you,

> 
> Changes in v4:
> - Added validation to reject trailing commas (empty tokens) in symbol lists
> - Added vaildation to reject mixed of list syntax with %return suffix
> - Refactored parse_fprobe_spec to user __free(kfree) for automatic memory
>   cleanup
> - Removed the now-unused parse_symbol_and_return function to avoid compiler
>   warnings.
> - Tigtened %return detection to ensure it only matches as a strict suffix, not a
>   substring
> - Link to v3: https://lore.kernel.org/lkml/20250904103219.f4937968362bfff1ecd3f004@kernel.org/
> 
>  Documentation/trace/fprobetrace.rst           |  17 +-
>  kernel/trace/trace.c                          |   3 +-
>  kernel/trace/trace_fprobe.c                   | 209 ++++++++++++++----
>  .../ftrace/test.d/dynevent/fprobe_list.tc     |  92 ++++++++
>  4 files changed, 269 insertions(+), 52 deletions(-)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc
> 
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

