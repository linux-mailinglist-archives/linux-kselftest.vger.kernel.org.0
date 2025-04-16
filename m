Return-Path: <linux-kselftest+bounces-30926-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 935CDA8AD13
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 02:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C3D444189
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 00:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582961F1526;
	Wed, 16 Apr 2025 00:54:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351F31E2834;
	Wed, 16 Apr 2025 00:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744764885; cv=none; b=kEw7sJQIAEi6YxHgd2WE3ZNaSf5L3FHOQKW2UxqqQk2OE8LoBPUGsAosiEaBjtyMWtVi3VsGJdJojjfgVrylxt/rXqNRiH43jRqc/XCRRfa/sM05UZyW6z8aGsa9Bj1pFq6JgO8DA2R83pQEli+TJSJflYUIqGloBWv0X1VpgQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744764885; c=relaxed/simple;
	bh=JnXCr2gEYLGKH2IMinVb0GHXPRNq/IdyJwBNURilIPA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIk6xe1gyQkbusrU9NQcn4Exa3CvfvrZHppG6kTBsq6XG1m9/oa5SUf+lnt/snaWwq43AVYc41qBWMmNm2/SWArarlLBXqxKjxt9KpCLD9xcMlylFKmO33EUqiHi4RSIPWKcpwbdQvAn9Zwjywct6UddaZmm20yghWQ18HFsELw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C41C4CEEC;
	Wed, 16 Apr 2025 00:54:43 +0000 (UTC)
Date: Tue, 15 Apr 2025 20:54:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, Mark
 Brown <broonie@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Differentiate bash and dash in
 dynevent_limitations.tc
Message-ID: <20250415205442.2437cea3@batman.local.home>
In-Reply-To: <658670d0-086b-49e9-85ac-3e002fa8322b@linuxfoundation.org>
References: <20250414210900.4de5e8b9@gandalf.local.home>
	<20250416075832.cd27bcb52b7e31d0f5717273@kernel.org>
	<658670d0-086b-49e9-85ac-3e002fa8322b@linuxfoundation.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 17:03:44 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >   
> 
> Steve, do you want me to pick this up for rc3?

Hi Shuah,

Yes, can you please. But can you change the Closes tag to:

Closes: https://lore.kernel.org/all/350786cc-9e40-4396-ab95-4f10d69122fb@sirena.org.uk/

Because the one I had was the top of the thread which is about a
different bug. Mark mentioned this bug in the middle of the thread and
the above link is where Mark mentioned it.

-- Steve

