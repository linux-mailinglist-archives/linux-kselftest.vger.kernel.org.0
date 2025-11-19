Return-Path: <linux-kselftest+bounces-46021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 756E1C71386
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 23:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 7FCC529614
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 22:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362C930C373;
	Wed, 19 Nov 2025 22:05:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E249830BBB6;
	Wed, 19 Nov 2025 22:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763589953; cv=none; b=oDyhVv9+eLgXXG5JEorZH0KBcAIr+JOnkJmrctVMY8VHrfBX+a8k62WPdbqZqd7ScnEc/w3Z/0Pki9z8AAoS2DrG1Ysp6xOrz7cdoe+NvM4zQwmxqG10FHQrOnf59P8gfEKfGhSIX2X+Cn53shUPIHAzfAD/RjZHp2VJXESVnTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763589953; c=relaxed/simple;
	bh=c4Gl/Qk3XtUmWlC6heIvb9j7SNwat+sUFYe1uSfb+vE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dTv56AAFu0MsaPAaYgZCRMrExjxW2/2lCiJf26ZINufIjHsDM8a+JPzpJMUNu2GBD3jIhV9JqlN/NdK/1OdvMSd5QbDpDHqdBor+TJ6g91Di6gUFNS8GWmm3NEAc7ky4rjA18zVWueWiEN1aa4WX/nW85oXrn5NMEfVKxhmRzpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 4D7D913B7F0;
	Wed, 19 Nov 2025 22:05:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 5F97A2002B;
	Wed, 19 Nov 2025 22:05:41 +0000 (UTC)
Date: Wed, 19 Nov 2025 17:06:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: tracing: Add tprobe enable/disable testcase
Message-ID: <20251119170611.6eff8df7@gandalf.local.home>
In-Reply-To: <f5f272e1-e164-4bb1-bfd0-42edd5a125c5@linuxfoundation.org>
References: <176252610176.214996.3978515319000806265.stgit@devnote2>
	<f5f272e1-e164-4bb1-bfd0-42edd5a125c5@linuxfoundation.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: qt3nbt7m3zn5eaybzkwdrdu8jrwhxoi9
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 5F97A2002B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+f8S3NzMYk8N3vwEo5RroqOMT1VLK5F1U=
X-HE-Tag: 1763589941-370316
X-HE-Meta: U2FsdGVkX18zFYJhiaqMjDmgbovDsrdOHb0EyB6OL1dU0/UXnacLXq2hjKSA6Ixx6rvpu3i1bdIIo89Aj7NtHR7K89XY0Qoyx6zeoI+qiqKQLIXqGWrOal5vEC4Hw9vDaBCgohSx4PvEzoa0pOi6Mr2mWhzEpOHC+Nr6X4Mo/Df7jTeoyNjPaQajUEWDzxCyCbHQnhWU9RB2OAPb8QvQw0RJrXvJx3Tr6/L95J+p3lsSNoKefLqAivS9Haj4dKFqFRqTHRwfmwfD6fiwOpAMsgo80LTjLX6KLs1MZ948pSZXBWPVXz7Y3NCsA/uKSeb2UHg3bsRkIjIxXMMgn/N5VUgxljK4RYDgD2Fa+kI6Lo82YJEqcfdx5UtitgfKXERrv/pFpn/ieoiNAwmVOZOd2g==

On Wed, 19 Nov 2025 14:44:22 -0700
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 11/7/25 07:35, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Commit 2867495dea86 ("tracing: tprobe-events: Register tracepoint when
> > enable tprobe event") caused regression bug and tprobe did not work.
> > To prevent similar problems, add a testcase which enables/disables a
> > tprobe and check the results.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>  
> 
> Steve, do you want me to take this through my tree?

Yes please. Masami's an official maintainer and mostly handles all things
"probe" related. This is his domain ;-)

Thanks,

-- Steve

