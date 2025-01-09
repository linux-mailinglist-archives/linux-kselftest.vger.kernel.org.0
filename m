Return-Path: <linux-kselftest+bounces-24115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEBEA06F54
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 08:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A183A1AA3
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 07:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D532036F6;
	Thu,  9 Jan 2025 07:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BRBXlF0X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N/HAIf5B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D314A2D;
	Thu,  9 Jan 2025 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736408874; cv=none; b=LJETDCN9gRsVFeo6On7+BnA8L9R/d1QYSyVRoOV44Jtov5tDyC+6NlpM2I0EU1vCpyOJUzR//JzDScnwaUMcpZHIbhPsFuOcloGLe94YTrg7pHDJuYREPLGwfthg7YhF5XEhza+S925FVc3n12axGmq0+SdoLMjBFNtxvNjuf+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736408874; c=relaxed/simple;
	bh=eRjlLDGfZ6TONdV7dd7oLhJ9Q453qsuQ3OEQZK6dDdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Udzfflbi1jL6/FpoMEmjAd/F51C+kwmJtJl6+6guRNkYmDqR5HzkkW37AlQQSAFRrQmOB94468edGgMYQdm0V3hz6vv2l6poAsZgcio+PZIwxxaD/EWrPaWYAMsnr5wEmUcVCQ6/IlHJPYz6tkbToaBY3sDQGrozgkUq+es6N80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BRBXlF0X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N/HAIf5B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 9 Jan 2025 08:47:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736408869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i1V0TrdJKeHlH2Z9S5D1oxp0ND7KirJepJzthqVZ+FQ=;
	b=BRBXlF0XjNWj1YBVE5ZNopGgiROM/RFyclkHtBquuaVzilav4qq0Qlht2lVj1FSI6xGuBo
	v90Q/yK5GQUQPhiwWeX0/HpkJy+p84RLEgZ3/5Inh1t//LOIFq3NG7dHx/6qkjuGAOWnVz
	JUbB05bp+iNcv0PI1yb5jpSPN90jRxC2l9PXUZtTM9yJ/mqt/Nz0y9vKmdK4OHnS+LUk4p
	B9swCdR7l3tVaMlanihG5rlxfHcdyOqka65J+bCxZau9JEMahJen0VxMkLhNhnAxsTGz2G
	PrlI7uJ5P1SZVleV8YYtw/47LQ17cy+ounmBKfvaI8nZCvkGQVyqyDKZZj7zOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736408869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i1V0TrdJKeHlH2Z9S5D1oxp0ND7KirJepJzthqVZ+FQ=;
	b=N/HAIf5Be6QwreeT3nX298vDvaTYMJwCvjxNXYRri75wgx+CyYEmlf2044sFvN15lWVdwo
	4VLOU5lu+gI5hZAQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: David Hildenbrand <david@redhat.com>
Cc: Dev Jain <dev.jain@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH 1/3] selftests/mm: virtual_address_range: Fix error when
 CommitLimit < 1GiB
Message-ID: <20250109083527-e3c77b5f-14f5-467b-9cee-f71c75b2d654@linutronix.de>
References: <20250107-virtual_address_range-tests-v1-0-3834a2fb47fe@linutronix.de>
 <20250107-virtual_address_range-tests-v1-1-3834a2fb47fe@linutronix.de>
 <5811cf74-d333-4653-ab64-0e981eda7745@arm.com>
 <20250108083855-840c688b-003f-423b-8327-2a10a2b27d58@linutronix.de>
 <05edee1e-04f1-4f19-816f-db03c182a201@redhat.com>
 <20250108165052-c03470bd-6ff7-44c9-87b9-9145456bdea8@linutronix.de>
 <618798d5-71b2-43d6-8f5c-78d911c5dd43@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <618798d5-71b2-43d6-8f5c-78d911c5dd43@redhat.com>

On Wed, Jan 08, 2025 at 05:46:37PM +0100, David Hildenbrand wrote:
> On 08.01.25 17:13, Thomas Weißschuh wrote:
> > On Wed, Jan 08, 2025 at 02:36:57PM +0100, David Hildenbrand wrote:
> > > On 08.01.25 09:05, Thomas Weißschuh wrote:
> > > > On Wed, Jan 08, 2025 at 11:46:19AM +0530, Dev Jain wrote:
> > > > > 
> > > > > On 07/01/25 8:44 pm, Thomas Weißschuh wrote:
> > > > > > If not enough physical memory is available the kernel may fail mmap();
> > > > > > see __vm_enough_memory() and vm_commit_limit().
> > > > > > In that case the logic in validate_complete_va_space() does not make
> > > > > > sense and will even incorrectly fail.
> > > > > > Instead skip the test if no mmap() succeeded.
> > > > > > 
> > > > > > Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
> > > > > > Cc: stable@vger.kernel.org
> > > 
> > > CC stable on tests is ... odd.
> > 
> > I thought it was fairly common, but it isn't.
> > Will drop it.
> 
> As it's not really a "kernel BUG", it's rather uncommon.

I also used it on patch 2, which is now reproducibly broken on x86
mainline since my commit mentioned in that patch.
But I'll drop it there, too.

> > > Note that with MAP_NORESRVE, most setups we care about will allow mapping as
> > > much as you want, but on access OOM will fire.
> > 
> > Thanks for the hint.
> > 
> > > So one could require that /proc/sys/vm/overcommit_memory is setup properly
> > > and use MAP_NORESRVE.
> > 
> > Isn't the check for lchunks == 0 essentially exactly this?
> 
> I assume paired with MAP_NORESERVE?

Yes.

> Maybe, but it could be better to have something that says "if
> overcommit_memory is not setup properly I will SKIP this test", but
> otherwise I expect this to work and will FAIL if it doesn't".

Ok, I'll validate the sysctl value.

> Or would you expect to run into lchunks == 0 even if overcommit_memory is
> setup properly and MAP_NORESERVE is used? (very very low memory that we
> cannot even create all the VMAs?)

No.

> > > Reading from anonymous memory will populate the shared zeropage. To mitigate
> > > OOM from "too many page tables", one could simply unmap the pieces as they
> > > are verified (or MAP_FIXED over them, to free page tables).
> > 
> > The code has to figure out if a verified region was created by mmap(),
> > otherwise an munmap() could crash the process.
> > As the entries from /proc/self/maps may have been merged and (I assume)
> 
> Yes, and partial unmap (in chunk granularity?) would split them again.
> 
> > the ordering of mappings is not guaranteed, some bespoke logic to establish
> > the link will be needed.
> 
> My thinking was that you simply process one /proc/self/maps entry in some
> chunks. After processing a chunk, you munmap() it.
> 
> So you would process + munmap in chunks.

That is clear. The issue would be to figure which chunks are valid to
unmap. If something critical like the executable file is unmapped,
the process crashes. But see below.

> > Is it fine to rely on CONFIG_ANON_VMA_NAME?
> > That would make it much easier to implement.
> 
> Can you elaborate how you would do it?

First set the VMA name after mmap():

for (i = 0; i < NR_CHUNKS_LOW; i++) {
	ptr[i] = mmap(NULL, MAP_CHUNK_SIZE, PROT_READ | PROT_WRITE,
		     MAP_NORESERVE | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

	if (ptr[i] == MAP_FAILED) {
		if (validate_lower_address_hint())
			ksft_exit_fail_msg("mmap unexpectedly succeeded with hint\n");
		break;
	}

	validate_addr(ptr[i], 0);
	if (prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, ptr[i], MAP_CHUNK_SIZE, "virtual_address_range"))
		ksft_exit_fail_msg("prctl(PR_SET_VMA_ANON_NAME) failed: %s\n", strerror(errno));
}

During validation:

hop = 0;
while (start_addr + hop < end_addr) {
	if (write(fd, (void *)(start_addr + hop), 1) != 1)
		return 1;
	lseek(fd, 0, SEEK_SET);

	if (!strncmp(line + path_offset, "[anon:virtual_address_range]", 28))
		munmap((char *)(start_addr + hop), MAP_CHUNK_SIZE);

	hop += MAP_CHUNK_SIZE;

}

It is done for each chunk, as all chunks may have been merged into a
single VMA and a per-VMA unmap would not happen before OOM.

> > Using MAP_NORESERVE and eager munmap()s, the testcase works nicely even
> > in very low physical memory conditions.
> 
> Cool.

