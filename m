Return-Path: <linux-kselftest+bounces-24046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E001A054B3
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 08:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6B41617F4
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 07:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667B51AAA29;
	Wed,  8 Jan 2025 07:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VBxobK1D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xkHuuVpO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD8F1A9B48;
	Wed,  8 Jan 2025 07:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736321933; cv=none; b=kAFbjN7gZc9p4bkha5Jib63mPixYC/I3MSBjObO9TlVMncz0XrFyMm/GhuAq+9wanItC0ofvnZmKmW5Pi0QJr1IRHDIxm4+8QjePAz4L7LpStYzhOwzFIKfBC5ey78f1GBq0gvAUsfI+egovG9wLB+oS1cYaQRo4BKcox9NQDzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736321933; c=relaxed/simple;
	bh=Do6nfWfiEcVXuFd4DCbqjUsxxrESlGX00OoWWDlHxio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAfSd/IY2e2Zw4HZEoavOSsvcySoVlV+LLxtpAJAwgY7fYDZ0pgtrcy93Tt9zzCSE7hCEdfk5iFA+4Fm3Lz1BTax8lv6hVw0F62H9xk1pqsNtXF462HghnbCjHLE1cPfdoRd3W+eBRYbtJqoSih/yuaKea3cL7/jhys5Qgph0lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VBxobK1D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xkHuuVpO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 8 Jan 2025 08:38:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736321930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hHNae7yOreR3HfU+kRH87suqQfKTR9J8UeLgi6567pY=;
	b=VBxobK1DyEktILwQZQPKcfkrvqeQ6ScXmNvOKEEAqQiY8ytFZOZx0pHf1Ns3QsoAFyZy77
	uysfGFfnPDpLNrHMrgsDANcNV1nNkg8kXsfYLAoHqY2t87OoT8+1ci1Bjewdlr89eNKEIM
	BasfOmkqMKET5iQThcppNiRHga+Lqt1wbcICkVkRyCop9+UUF/J3M8VqmcnmvPoAUMyy1L
	gt7/eQ7JRM2xXUW8do2DD4sm14FqhCEKitZgj4RE2z3rjaGEmIOvFRpwjVoz/0i4cAVxla
	dY1GnVC5V/R64LA2GlDadqhZausLMtje/enNKTdG82WodYM9rUnQhhxGzsm6bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736321930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hHNae7yOreR3HfU+kRH87suqQfKTR9J8UeLgi6567pY=;
	b=xkHuuVpOaYhgyhrlO40AT6e4CAZedHrY2/BcweYN3r4EXY911hmNqRDQ8c3bczzi919n5g
	dNqLwk11VS7DWbCg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Dev Jain <dev.jain@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 3/3] selftests/mm: virtual_address_range: Dump to
 /dev/null
Message-ID: <20250108083542-6405a683-1899-4f9a-a915-5f566bd2d7c0@linutronix.de>
References: <20250107-virtual_address_range-tests-v1-0-3834a2fb47fe@linutronix.de>
 <20250107-virtual_address_range-tests-v1-3-3834a2fb47fe@linutronix.de>
 <2c5ab3af-2e58-449a-94f2-5cbcaa8b66f2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c5ab3af-2e58-449a-94f2-5cbcaa8b66f2@arm.com>

On Wed, Jan 08, 2025 at 11:39:40AM +0530, Dev Jain wrote:
> 
> On 07/01/25 8:44 pm, Thomas Weiﬂschuh wrote:
> > During the execution of validate_complete_va_space() a lot of memory is
> > on the VM subsystem. When running on a low memory subsystem an OOM may
> > be triggered, when writing to the dump file as the filesystem may also
> > require memory.
> > 
> > On my test system with 1100MiB physical memory:
> > 
> > 	Tasks state (memory values in pages):
> > 	[  pid  ]   uid  tgid total_vm      rss rss_anon rss_file rss_shmem pgtables_bytes swapents oom_score_adj name
> > 	[     57]     0    57 34359215953      695      256        0       439 1064390656        0             0 virtual_address
> > 
> > 	Out of memory: Killed process 57 (virtual_address) total-vm:137436863812kB, anon-rss:1024kB, file-rss:0kB, shmem-rss:1756kB, UID:0 pgtables:1039444kB oom_score_adj:0
> > 	<snip>
> > 	fault_in_iov_iter_readable+0x4a/0xd0
> > 	generic_perform_write+0x9c/0x280
> > 	shmem_file_write_iter+0x86/0x90
> > 	vfs_write+0x29c/0x480
> > 	ksys_write+0x6c/0xe0
> > 	do_syscall_64+0x9e/0x1a0
> > 	entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > Write the dumped data into /dev/null instead which does not require
> > additional memory during write(), making the code simpler as a
> > side-effect.
> > 
> > Signed-off-by: Thomas Weiﬂschuh<thomas.weissschuh@linutronix.de>
> > ---
> >   tools/testing/selftests/mm/virtual_address_range.c | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> > index 484f82c7b7c871f82a7d9ec6d6c649f2ab1eb0cd..4042fd878acd702d23da2c3293292de33bd48143 100644
> > --- a/tools/testing/selftests/mm/virtual_address_range.c
> > +++ b/tools/testing/selftests/mm/virtual_address_range.c
> > @@ -103,10 +103,9 @@ static int validate_complete_va_space(void)
> >   	FILE *file;
> >   	int fd;
> > -	fd = open("va_dump", O_CREAT | O_WRONLY, 0600);
> > -	unlink("va_dump");
> > +	fd = open("/dev/null", O_WRONLY);
> >   	if (fd < 0) {
> > -		ksft_test_result_skip("cannot create or open dump file\n");
> > +		ksft_test_result_skip("cannot create or open /dev/null\n");
> >   		ksft_finished();
> >   	}
> > @@ -152,7 +151,6 @@ static int validate_complete_va_space(void)
> >   		while (start_addr + hop < end_addr) {
> >   			if (write(fd, (void *)(start_addr + hop), 1) != 1)
> >   				return 1;
> > -			lseek(fd, 0, SEEK_SET);
> >   			hop += MAP_CHUNK_SIZE;
> >   		}
> > 
> 
> The reason I had not used /dev/null was that write() was succeeding to /dev/null
> even from an address not in my VA space. I was puzzled about this behaviour of
> /dev/null and I chose to ignore it and just use a real file.

That makes sense and I can reproduce your example.
Switching to another dummy file which reads the written data like
/dev/random also leads to OOM, so wouldn't help either.

Thanks for the explanation.

@Andrew, could you drop this patch?

> To test this behaviour, run the following program:

[..]

PS: Your mail contained HTML and did not make it to the list archives.
(And the text variant of the example program was corrupted)

