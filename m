Return-Path: <linux-kselftest+bounces-48412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DB6CFE90B
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 16:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7375530EBA69
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 15:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70195376BF0;
	Wed,  7 Jan 2026 15:18:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A42B376BCC;
	Wed,  7 Jan 2026 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767799106; cv=none; b=B1T43Hru71syM6tqJ30vro4eokTwoW57DnF8zHtLvsy6LaANlGfG2xS07OJYc9aqRfiWee6bvNNj3sbG8foo8twzOmXNKv6JMXgEIBpDZLIdFtWIcqXdPXK25N7rmbAPIslkH8zla7aRG3J/BgeQqYjiQNMkbdqVRRP3lH4EppY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767799106; c=relaxed/simple;
	bh=NNoNs2hoP285pXc4LULLJAeVOtQRPx8llLbOsS3srsE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myZksO7uHQoaouMxkE0g7jidJvR1uR2oeuqzsubJAeN4TnxrP9l/FkEuV5z7x5ADtDBhsVBXkWKodNJqoQkA4+6UmYcLyq0kdVTUqD+IgeW7Cl/llWPCCGBjtx1lp4tICTXCyThritxTnh3qSgM8vqXkgxCpCdVFuREoIHR7ryY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 866911AAA30;
	Wed,  7 Jan 2026 15:18:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 5F9311A;
	Wed,  7 Jan 2026 15:18:20 +0000 (UTC)
Date: Wed, 7 Jan 2026 10:18:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, shuah@kernel.org, wangfushuai@baidu.com, Shuah Khan
 <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] selftests/tracing: Fix test_multiple_writes stall
Message-ID: <20260107101846.61c182e0@gandalf.local.home>
In-Reply-To: <20260107034914.22315-1-fushuai.wang@linux.dev>
References: <20251227041821.75504-1-fushuai.wang@linux.dev>
	<20260107034914.22315-1-fushuai.wang@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 5F9311A
X-Stat-Signature: 8mbmda3r93zytg45akb4fkp8hkyf6yjo
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19HqUC8bNA02ynABqBYvLkKo06yN5Uf0UA=
X-HE-Tag: 1767799100-19994
X-HE-Meta: U2FsdGVkX1/MD/Ud+ppc5N89H6R19eHi6YrCeTPtyzMFJSnHVR6J9E3M+zU2Jup8OIiNnHCCw/oQ+gdkk6iCQ7wap/SdnsH5cqR3iDYZvasv/vGKVSjoOlZodG7+zEKbyrzi0DeOKXLxW1f77uyr7b3j4Q0jveNXWo8iouGPI5HqBomG5wLV8aWwCGBMBeyCBSO8kWb3Wk4f1B+IejX/29q6TBV7YjCyV0uJHM2Vgi4Tu8S3KkmDwgc64X5jFkTsWeyJikH1tEzqWHA3+uombEr+LJ61tzHgXayBWozC/1z+GPSkNvmpk363WcqJn1qlfE2mUcsPOfk6/+mWpv79uFT0Ez7wJuMVm9SzlZKnInTfJyz5/zBg4PPm7L0CFUWFZJcSNlxetGck2E9Bf1RWcQ==

On Wed,  7 Jan 2026 11:49:14 +0800
Fushuai Wang <fushuai.wang@linux.dev> wrote:

> > When /sys/kernel/tracing/buffer_size_kb is less than 12KB,
> > the test_multiple_writes test will stall and wait for more
> > input due to insufficient buffer space.
> > 
> > Check current buffer_size_kb value before the test. If it is
> > less than 12KB, it temporarily increase the buffer to 12KB,
> > and restore the original value after the tests are completed.
> > 
> > Fixes: 37f46601383a ("selftests/tracing: Add basic test for trace_marker_raw file")
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>  
> 
> Gentle ping.
> 

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Shuah,

Care to take this through your tree? It does fix a bug so it likely should
go into the rc releases and not wait for the next merge window.

Thanks,

-- Steve


