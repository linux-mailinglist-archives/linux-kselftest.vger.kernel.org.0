Return-Path: <linux-kselftest+bounces-27606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2215A45E7B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 13:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3893F189CA37
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 12:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA39C221721;
	Wed, 26 Feb 2025 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwR7gNJJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B013C22171E;
	Wed, 26 Feb 2025 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571676; cv=none; b=VvywHcmn37eJ8hRcqqasC3dmN9nBN3/Nc2miDG5yO/+Fnsl8VXfTCq9gdv0sVimNrRTcQ19XSuiCIUYYRRadeORj+2objekjZF0nYNKhYbJopQLeRhSBdWB/KCyM+tEjw4M8w0R6wU+9jTzPhoT5yZdjDN5+jlWnE/Kuz1wCoSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571676; c=relaxed/simple;
	bh=id2xDEDTLHUZgNU7NFHY3JAAhpjgs1WcqbDXOZiObMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKWXjXyJ4SS1OHXMepUj+qiIdgtbAd9210kI5tiojufU8QOMUsnRjJVq78UawZ2cMhqaTJei82Yn5Pj6MCCGv4JTelSwlbygCFnBEd5FOF+DXC26znqu0MZNtRsuJx3w0zPgemJU8N2E2qqkcGveSp31LEaZlC5J0q5olh1U4fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwR7gNJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05329C4CEE9;
	Wed, 26 Feb 2025 12:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740571676;
	bh=id2xDEDTLHUZgNU7NFHY3JAAhpjgs1WcqbDXOZiObMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CwR7gNJJ8i3ABdIYuJrSeqdft+2nutLp2T/g68b+sYlXapbR92pYc6mXuJvKfIiKf
	 1OMdMZg1P4QXCYPZQepZKg7BNFvzx/6QYuJEYXJv87HqPh37IJBvRrRUmJXCsLU3Fs
	 hyN+3lJSeMG5vDxDO6SBSfVt8i5fSD4ko8ZDjG6KnSJto2+waIggTYpTIgPAYY69Fe
	 uAvDSk7mrRKdD2+5HyBRlUzxppfDgDwSayJB/EiWyqZB3/ZULegHQik+y/56eRiBwL
	 LXlP8c0wIm2qAg/uECLh9dh3yqmweggQ4RQCtLdlhlFSax2K+9Frnk6NKUPapCqSsU
	 8/AWO+hUQGgiQ==
Date: Wed, 26 Feb 2025 13:07:47 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, shuah@kernel.org
Subject: Re: [PATCH 0/9] selftests/x86/xstate: Introduce common code for
 testing extended states
Message-ID: <Z78EE9cQ1FaF29zz@gmail.com>
References: <20250226010731.2456-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250226010731.2456-1-chang.seok.bae@intel.com>


* Chang S. Bae <chang.seok.bae@intel.com> wrote:

> Hi all,
> 
> This series proposes a rework of xstate-related tests to improve
> maintainability and expand test coverage.
> 
> == Motivation: Addressing Missing and New XSTATE Tests ==
> 
> With the introduction of AMX, a new test suite [1] was created to verify
> dynamic state handling by the kernel as observed from userspace. However,
> previous tests for non-dynamic states like AVX lacked ABI validation,
> leaving gaps in coverage. While these states currently function without
> major issues (following the alternate sigstack fix [2]), xstate testing
> in the x86 selftest suite has been largely overlooked.
> 
> Now, with Intel introducing another extended state, Advanced Performance
> Extensions (APX) [3], a correspondent test case is need. The APX enabling
> series will follow shortly and will leverage this refactored selftest
> framework.
> 
> == Selftest Code Rework ==
> 
> To ensure ABI validation and core functionality across various xstates,
> refactoring the test code is necessary. Without this, existing code from
> amx.c would need to be duplicated, compromising the structural quality of
> xstate tests.
> 
> This series introduces a shared test framework for extended state
> validation, applicable to both existing and new xstates. The test cases
> cover:
> * Context switching
> * ABI compatibility for signal handling
> * ABI compatibility for ptrace interactions
> 
> == Patch Organization ==
> 
> The patchset is structured as follows:
> 
> * PATCH1: Preparatory cleanup — removing redundant signal handler
>   registration code.
> * PATCH2/3: Introduce low-level XSAVE helpers and xstate component
>   enumeration.
> * PATCH4/5: Refactor existing test code.
> * PATCH6: Introduce a new signal test case.
> * PATCH7/8: Consolidate test invocations and clarify the list of
>   supported features.
> * PATCH9: Add test coverage for AVX.
> 
> == Coverage and Future Work Considerations ==
> 
> Currently, these tests are aligned with 64-bit mode only. Support for
> 32-bit cases will be considered when necessary, but only after this phase
> of rework is finalized.
> 
> FWIW, the AMX TILECFG state is trivial, requiring almost constant values.
> Additionally, various PKRU tests are already established in
> tools/selftests/mm.
> 
> This series is based on the tip/master branch. You can also find it in
> the following repository:
>     git://github.com/intel/apx.git selftest-xstate_v1
> 
> Thanks,
> Chang
> 
> [1] https://lore.kernel.org/all/20211026122523.AFB99C1F@davehans-spike.ostc.intel.com/
> [2] https://lore.kernel.org/lkml/20210518200320.17239-1-chang.seok.bae@intel.com/
> [3] https://www.intel.com/content/www/us/en/developer/articles/technical/advanced-performance-extensions-apx.html
> 
> Chang S. Bae (9):
>   selftests/x86: Consolidate redundant signal helper functions
>   selftests/x86/xstate: Refactor XSAVE helpers for general use
>   selftests/x86/xstate: Enumerate and name xstate components
>   selftests/x86/xstate: Refactor context switching test
>   selftests/x86/xstate: Refactor ptrace ABI test
>   selftests/x86/xstate: Introduce signal ABI test
>   selftests/x86/xstate: Consolidate test invocations into a single entry
>   selftests/x86/xstate: Clarify supported xstates
>   selftests/x86/avx: Add AVX test

>  22 files changed, 753 insertions(+), 720 deletions(-)

Thank you very much for doing this - this series is a very big step 
forward in this area.

I've applied your series to tip:x86/fpu with minor edits to the 
changelogs, and if all goes fine it should all go upstream in the v6.15 
merge window in a couple of weeks.

Thanks,

	Ingo

