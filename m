Return-Path: <linux-kselftest+bounces-42860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F74EBC316A
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 02:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95FB7189CC12
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 00:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC182877D8;
	Wed,  8 Oct 2025 00:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiNR8Ulr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD80B2877C2;
	Wed,  8 Oct 2025 00:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759884677; cv=none; b=BfE/zoZeAyLAYeXN1pFGrjy8p1jcSI+m1uMa5X49QLXjthN74Bnak7mDmv8MONLwUGm4+Zork3tSeq0B/vrrM0ihqq4rumbudlNlUmWX0cP/2N255bTphcKheURffsXjunRRWpXKD5eFF+SN6Px8eBG5KetVtuzmOZIqxLm0vN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759884677; c=relaxed/simple;
	bh=ip9Z6xXZyARdKTzPzXZm8Lt9Os1E7qphGPd4Rh7D3s0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CuNxgpYiYl8Hgzy7jLhfmdWeiiZqUP6GqzKT8SVEXjwNZQTIpTppQac96ScESyD6/TNDy7/4T/RVKQuj6HnoMe9iJq7PXp1SXioA0p/6x0FFTu2RZ8XQ2M6sAz+6eNZnqvTo888JX6m/gNBmkUBDtMughnW4J+9uzfDw/Q98tyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiNR8Ulr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E9CC4CEF1;
	Wed,  8 Oct 2025 00:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759884676;
	bh=ip9Z6xXZyARdKTzPzXZm8Lt9Os1E7qphGPd4Rh7D3s0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PiNR8Ulr/Nd31jm8jP7o4IVAlPCLO0zBrHyWBfo/fpazSBd4XAIH+pJh5CoWVZzTp
	 FTHb/uOkDHl4tJatt/d9qoR7ga/upW5LFb7Tw17x3zD98v7T+WFPW9R9kTZQdNnXji
	 rm6mhwXzpMPqbxYVjD+h4faxWJtxpyMT6g88Zwuq0R+bZtxiBjassjPdc0LTlCSxDK
	 ++9sMELLQqIBPeq2wcRTN8wesRPMm4FRnq0/Dyd/AelLmiamVxVoHGIWaaKTG9nWql
	 Ad4eNyck/ZO+M6qCgWO5RGQkfa0XMeTR7xFeyLG9FdOdUSo8MKvSBmoG28HfI2dems
	 lH2mS8kJB9vyw==
Date: Wed, 8 Oct 2025 09:51:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ryan Chung <seokwoo.chung130@gmail.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 hca@linux.ibm.com, corbet@lwn.net, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/5] tracing: fprobe: list-style filters,
Message-Id: <20251008095111.5732b065dcebe53fc80063c5@kernel.org>
In-Reply-To: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
References: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ryan,

Thanks for update!

On Sun,  5 Oct 2025 08:46:54 +0900
Ryan Chung <seokwoo.chung130@gmail.com> wrote:

> This series aims to extend fprobe with list-style filters and a clear
> entry/exist qualifier. Users can now specify a comma-separated symbol
> list with ! exclusions, and use a spec-level suffix to select probe
> type:
> 
> - funcA*, !funcAB, funcC -> entry probes
> - funcA*, !funcAB, funcC:entry -> explicit entry
> - funcA*, !funcAB, funcC:exit -> return/exit across the whole list


Just a note, it should not accept spaces in the list. The space
is the highest level delimiter. I hope actual implementation
does not accept spaces. So something like:

 "funcA*,!funcAB,funcC"
 "funcA*,!funcAB,funcC:entry"
 "funcA*,!funcAB,funcC:exit"


> 
> For compatibility, %return remains supported for single, literal
> symbols. When a list or wildcard is used, an explicit [GROUP/EVENT is
> required and autogeneration is disabled. Autogen names are kept for
> single-symbol specs, with wildcard sanitization. For list/wildcard forms
> we set ctx->funcname = NULL so BTF lookups are not attempted.

OK. So "funcA*%return" and "funcA,funcB%return" will fail.

> 
> The series moves parsing to the parse path, documents the new syntax,
> and adds selftests that accept valid list cases and reject empty tokens,
> stray commas, and %return mixed with lists or wildcards. Selftests also
> verify enable/disable flow and that entry+exit on the same set do not
> double-count attached functions.

Thanks for adding selftests and document, that is important to maintain
features.

> 
> Help wanted: This is my first time contributing ftrace selftests. I
> would appreciate comments and recommendations on test structure and
> coverage.

OK, let me review it.

Thanks,


> 
> Basic coverage is included, but this likely needs broader testing across
> architectures. Feedback and additional test ideas are welcome.
> 
> Changes since v2:
> - Introduce spec-level: :entry/:exit; reject %return with
>   lists/wildcards
> - Require explict [GROUP/]EVENT for list/wildcard; keep autogen only for
>   single literal.
> - Sanitize autogen names for single-symbol wildcards
> - Set ctx->funcname = NULL for list/wildcard to bypass BTF
> - Move list parsing out of __register_trace_fprobe() and into the parse
>   path
> - Update docs and tracefs README and add dynevent selftests for
>   accept/reject and enable/disable flow
> 
> Link: https://lore.kernel.org/lkml/20250904103219.f4937968362bfff1ecd3f004@kernel.org/
> 
> Ryan Chung (5):
>   docs: tracing: fprobe: document list filters and :entry/:exit
>   tracing: fprobe: require explicit [GROUP/]EVENT for list/wildcard
>   tracing: fprobe: support comma-separated symbols and :entry/:exit
>   selftests/ftrace: dynevent: add reject cases for list/:entry/:exit
>   selftests/ftrace: dynevent: add reject cases
> 
>  Documentation/trace/fprobetrace.rst           |  27 +-
>  kernel/trace/trace.c                          |   3 +-
>  kernel/trace/trace_fprobe.c                   | 247 ++++++++++++++----
>  .../test.d/dynevent/add_remove_fprobe.tc      | 121 +++++++++
>  .../test.d/dynevent/fprobe_syntax_errors.tc   |  13 +
>  5 files changed, 349 insertions(+), 62 deletions(-)
> 
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

