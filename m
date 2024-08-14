Return-Path: <linux-kselftest+bounces-15327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A073951EE8
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 17:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9626A1F23CFA
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 15:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9EE1B580E;
	Wed, 14 Aug 2024 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cq2iOqfg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB0E1B29CF;
	Wed, 14 Aug 2024 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650313; cv=none; b=O3cwmyQHyzVhD4/bRGA47Fhx8IFA0+Gl/o/d1sgS2WGPcs1UVftpP+uiMnHSlWM2f5ozKdvRQRZVFrnkBzksM+8FjzBPSUQ/uwMy7STzdGx0a8tVjniEaB2uezK1UXk0FxOL/gf/N/PLaPw7t7mbFqBUJtMQqS2stSb+fDI7otY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650313; c=relaxed/simple;
	bh=eeREinB8Mir7bqqQqG6csHrywof8fVP+bxHSTvDX9tE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CJeFlHOtuEoKlh4chEVyIsqGCl32y6AtMXwfIbaO3rAPWkiPntGMghqwK4cj8SmGwNAlearCNlUIIS7MvuaUuAp14pLA3uQUI/XpqF4HVafIhnSFbg7mnsDoVVGvl8jPFl7t9N5uVEUbAPjy5Ig122wnIPBQKo7doUH1I0/MmUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cq2iOqfg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355A1C116B1;
	Wed, 14 Aug 2024 15:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723650313;
	bh=eeREinB8Mir7bqqQqG6csHrywof8fVP+bxHSTvDX9tE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cq2iOqfgprdMfRGKaVGTdhuLZ5YQSakYCUwrM37igbxZ81mGB5nm/cvOoGMuCgkdb
	 HminpE0OuUW+NAQIi2Fg5b6+559rHVH3gS+bHEpKmaqc/XDF3fgHCPJt7ax7gCEOxa
	 /QXLPalndj63SsBb2l23GEMXekE2lRw+MMZ6X3cYAVR/50JF6JO07I2bTaRLwi7CPF
	 9UKkE+DvG+2WXxjvWJZWeqwh8j6W5ueDgnwIrLHk1OOWTdxmW3fy1MMXk0MGH3ACL4
	 1SvifdjdreHP9HT17nLzvxNuImU/n6Ct++lKvWsggUUqXlK32PBx12SlWKv25y0Od7
	 utJt4IS6BUF5Q==
Date: Thu, 15 Aug 2024 00:45:09 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Add required dependency for kprobe
 tests
Message-Id: <20240815004509.b5252f43379124b4ea9c26f5@kernel.org>
In-Reply-To: <9016df04-041b-4837-9590-1c5159609826@linuxfoundation.org>
References: <171823033048.152840.662759412433336839.stgit@devnote2>
	<20240814095323.c8458e2cb6031c3014a7b7e0@kernel.org>
	<9016df04-041b-4837-9590-1c5159609826@linuxfoundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 05:43:29 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 8/13/24 18:53, Masami Hiramatsu (Google) wrote:
> > Hi Shuah,
> > 
> > Can you pick this? I confirmed this can be applied on v6.11-rc3.
> > 
> > 
> > 
> > On Thu, 13 Jun 2024 07:12:10 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > 
> >> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >>
> >> kprobe_args_{char,string}.tc are using available_filter_functions file
> >> which is provided by function tracer. Thus if function tracer is disabled,
> >> these tests are failed on recent kernels because tracefs_create_dir is
> >> not raised events by adding a dynamic event.
> >> Add available_filter_functions to requires line.
> >>
> >> Fixes: 7c1130ea5cae ("test: ftrace: Fix kprobe test for eventfs")
> >> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Applied to linux-kselftest next for Linux 6.12-rc1

Thanks!

> 
> thanks,
> -- Shuah


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

