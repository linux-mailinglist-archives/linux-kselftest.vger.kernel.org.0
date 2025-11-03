Return-Path: <linux-kselftest+bounces-44672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864B0C2D6AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 18:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D933A010C
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 17:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B484E319605;
	Mon,  3 Nov 2025 17:10:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E833195EC;
	Mon,  3 Nov 2025 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189809; cv=none; b=iv97ku0dqWpCRJCSqWncjGf6jmp7QE0oEjH1c0PHB5eQwhyUrauKgM5W1s9oUcthG6nV23fm+1loT9Mvwinft8RoSFhlBHa8XePqS6Oxw7HB27YYeSbr4sTfa7Z86CHnsGbB7biQcXA2UJE8bmh73Y09w2+FMTmU9GUeP4T0FaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189809; c=relaxed/simple;
	bh=LJh0yJmZew+j33AAQcg4a1FkrctIZBGiG0dRH5ntOVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u73wIIP57NzDdw162XoWfqtlNRMQCHDOHu1lWV4BfI5X6SZZu6w7SQ4YFoi0JKzWT/KdOq6qHHivxInWTNrnQof/0cyKAA0OIER2Qz+BV0f2i3MlKSqcWd5jUM+V/sH2nqIJCuszXVKeGsusU2qTnelfqDuR1l/PeUdhoxK2ehI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 7C65487A07;
	Mon,  3 Nov 2025 17:10:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 8952F80009;
	Mon,  3 Nov 2025 17:10:01 +0000 (UTC)
Date: Mon, 3 Nov 2025 12:10:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH] selftests/tracing: Add basic test for trace_marker_raw
 file
Message-ID: <20251103121005.6399baf3@gandalf.local.home>
In-Reply-To: <20251014161403.1443c21f@gandalf.local.home>
References: <20251014145149.3e3c1033@gandalf.local.home>
	<20251014161403.1443c21f@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: hk76wpkzbpmcdotf97s3yti645x16htk
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 8952F80009
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+OJjDpCCQZTaWuuqg4AxJH6/gz5MVPfM4=
X-HE-Tag: 1762189801-800533
X-HE-Meta: U2FsdGVkX18tWlsEVyMSMYef+Sj6KGHulrIOpw579zFEDGoqMVKtdR+08qaWO5ytMy55qtFbZYYWgh9bRoRJpaAI6g2Xn5pgtqYaG4PATyWXm0+XwAwPyA6M3JggK26NIZrFzp5MVfCkuTUqTlQEgdbpDZyvikEL7bsKIxuc62OPTe7nZEfhalu8OW2dWex0MhmkxxlY5g47jIBnEYllPOEc+rNzdqrxU7FvyLUUp8bsvNpsWzh02PpFc8MU18btNtT41HfeLRgyEkEpSYRJAsMwxZnO4Fum/CDVkTEZeLRT/DRsIMvpY5dkFM4SgbsgC445lUd0O5p680Jv5XX/s9Fd6nE5xqhNLwqEAF9lTEefg+jh9SdRZdOA18i3z28+C3paIifWpqnUC9pL6bJi0PMV7hMyH70S

Masami,

  Ping!

-- Steve


On Tue, 14 Oct 2025 16:14:03 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Shuah,
> 
> After Masami gives an ack, could you take this through your tree.
> 
> I don't think it's urgent, but I want to make sure it gets upstream.
> 
> -- Steve
> 
> 
> On Tue, 14 Oct 2025 14:51:49 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > Commit 64cf7d058a00 ("tracing: Have trace_marker use per-cpu data to read
> > user space") made an update that fixed both trace_marker and
> > trace_marker_raw. But the small difference made to trace_marker_raw had a
> > blatant bug in it that any basic testing would have uncovered.
> > Unfortunately, the self tests have tests for trace_marker but nothing for
> > trace_marker_raw which allowed the bug to get upstream.
> > 
> > Add basic selftests to test trace_marker_raw so that this doesn't happen
> > again.
> > 
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> >  


