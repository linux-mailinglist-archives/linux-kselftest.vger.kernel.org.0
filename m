Return-Path: <linux-kselftest+bounces-43139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7FCBDB2FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 22:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DCCA18A372C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 20:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646E830597C;
	Tue, 14 Oct 2025 20:14:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03822306484;
	Tue, 14 Oct 2025 20:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760472850; cv=none; b=JaUxE/NOI4d4xVHjjshVMwYHCVVY3TujSI5+fXL6Ibt6Sh59BllPEL53kS9/kkLf9MGXdaxlGt/yrHUMQy+Qm6/73sMx6R1my37wNHLNfKW/cgOpAdT2pMUd+449QXoJzWuiW9gKuvncaFfOt/+Sz+1H6m6c8oe54Maf8iZvlzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760472850; c=relaxed/simple;
	bh=qjN9yMcbqb9el7V0EC31POCxcsJn4SiO/M7H0T1mlX8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDMRYxyNxQc/LW+j65jWQOG8A3BgEy3I2wBmSJvDeNDVeIOzBDvNut4SC9ftjBet+ZDPiw2XG6X3lWimQyQV+UE7IPcK6gqJ5GaLPGym0jOGH42FbXsQIl7OnvOIcwUWgo+0d0u5qkcYLTRhVGc/1ul5WE3YlOHXOGefWOU6djM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id C349E5C581;
	Tue, 14 Oct 2025 20:13:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id E11338000E;
	Tue, 14 Oct 2025 20:13:57 +0000 (UTC)
Date: Tue, 14 Oct 2025 16:14:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH] selftests/tracing: Add basic test for trace_marker_raw
 file
Message-ID: <20251014161403.1443c21f@gandalf.local.home>
In-Reply-To: <20251014145149.3e3c1033@gandalf.local.home>
References: <20251014145149.3e3c1033@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E11338000E
X-Stat-Signature: u64ndhrjssy8xingoipzrnyc7oodekyq
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+lGRKZK6BAdeIUhgbLVSGrl3LBWC9yKi4=
X-HE-Tag: 1760472837-564214
X-HE-Meta: U2FsdGVkX1/2AyXiwXzfWQLkepWc1NQmahTza+SNdD+Qm5zhatbjZP0a5ZR8dtSSQy42AO+VKuBX0jwka3M1YxM5LsruxpTImGU4WTInj4Y5BmKmg6MH4+UH+3MnmSAMSHC6X+T7HDEugFj6pWARd8WDWhkibtt9CMYlbqOlfTc7Pj1IfDL2Td7Ra7sff6Dmn18fuhDMQ1aPcSJ5QgFXLkytMGFmlw8bz+lUHlWSEhnCQvfBe99OBE9jP438IUh3h1nUJLSYirvcc/Eo8+/ZUAlCcI+NmWkT2sg6aX4TsZgwGEYfCHmwgQwmepwgFbWIWr/TAAmmQD+H/aYY6JqenkzMYzzCWKE+DLklWdrTlLuvMjuCVvxiJrMheE2azhvq



Shuah,

After Masami gives an ack, could you take this through your tree.

I don't think it's urgent, but I want to make sure it gets upstream.

-- Steve


On Tue, 14 Oct 2025 14:51:49 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Commit 64cf7d058a00 ("tracing: Have trace_marker use per-cpu data to read
> user space") made an update that fixed both trace_marker and
> trace_marker_raw. But the small difference made to trace_marker_raw had a
> blatant bug in it that any basic testing would have uncovered.
> Unfortunately, the self tests have tests for trace_marker but nothing for
> trace_marker_raw which allowed the bug to get upstream.
> 
> Add basic selftests to test trace_marker_raw so that this doesn't happen
> again.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>

