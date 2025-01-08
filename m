Return-Path: <linux-kselftest+bounces-24066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923A6A06136
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 17:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82938161274
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 16:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381811FE46F;
	Wed,  8 Jan 2025 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cKmNiFZx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xg4RyoyE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2835415B99E;
	Wed,  8 Jan 2025 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736352789; cv=none; b=ZJKP9rz+MRvAOXNTr/kVSYgag8+/vhkgtIEwovFGEh6XqAqa64Ww3ZiM9d3cowrzd632tjsCslWCFD8cUASrQASy8ISYDQZr5wygpEj334Z7tWaJxxif8QzGN0ONaDJtyPx/FWrz24p9I10jbogs4rgwDPyXmtNINdmkehDdAEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736352789; c=relaxed/simple;
	bh=xBKCDuI+140nJUGXVfSBc36vW+LQIvVMQ6CjKPaB4hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Th++kZdODFlDxIyQPJzbSrpNonTYQPFuN8xL32bRDr85/yZVczpQUpAHSj5KpKeqWmgT0c11ACrF1RqGFbXn7pFcoCNdP9ZnwI2i68xXW5uJ+ntLAd7i+IUUBJq0FWZuCrvlatdBb8NsZiVC+CxX3m5sR+E3Wu7v8ed+G3zhgVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cKmNiFZx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xg4RyoyE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 8 Jan 2025 17:13:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736352784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+TfJv4U+XL2AidFaYcUodlJeSgOx+Syd2bkvgydZpIQ=;
	b=cKmNiFZxXEPf828GRbpTMvWxRu8rmNnxjsAyAhwwuoDic7uhOs02d17Mfq7/qAVf4ppp0N
	bIbSE4qHJBBblG9f0kg/bqakTOOEAuTizlybxhfJ5o7nF/Y9JUUubcYJGyGsNe8kJiXqFJ
	DFk4/JUO8BfIWYnq3od7KIo3kU/XQ25QncB6c3gMQEnh4q9afnQNZgdQx9D/Obb0hZ6GWr
	6evGXNd8Rr7PCjtigiGpKRyAMwIXUhAnRTeuMoOfM0ZzEm5IMJHfN1SYOfy5rGXHnUCB+3
	NH60Ez9y2ZU/VcfE/ovs7LuloUOU05hugnn++p3Eb3Td7k2p5FZDoGvdIZ5HwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736352784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+TfJv4U+XL2AidFaYcUodlJeSgOx+Syd2bkvgydZpIQ=;
	b=xg4RyoyE1ySv7XvCN4jkAFNHPNyOnjA+iNYDSnYFu3sTsrhD0eo11RoEhtxFn5k5pOCTOJ
	rbNuqCqw1cTmQsCw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: David Hildenbrand <david@redhat.com>
Cc: Dev Jain <dev.jain@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH 1/3] selftests/mm: virtual_address_range: Fix error when
 CommitLimit < 1GiB
Message-ID: <20250108165052-c03470bd-6ff7-44c9-87b9-9145456bdea8@linutronix.de>
References: <20250107-virtual_address_range-tests-v1-0-3834a2fb47fe@linutronix.de>
 <20250107-virtual_address_range-tests-v1-1-3834a2fb47fe@linutronix.de>
 <5811cf74-d333-4653-ab64-0e981eda7745@arm.com>
 <20250108083855-840c688b-003f-423b-8327-2a10a2b27d58@linutronix.de>
 <05edee1e-04f1-4f19-816f-db03c182a201@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05edee1e-04f1-4f19-816f-db03c182a201@redhat.com>

On Wed, Jan 08, 2025 at 02:36:57PM +0100, David Hildenbrand wrote:
> On 08.01.25 09:05, Thomas Weiﬂschuh wrote:
> > On Wed, Jan 08, 2025 at 11:46:19AM +0530, Dev Jain wrote:
> > > 
> > > On 07/01/25 8:44 pm, Thomas Weiﬂschuh wrote:
> > > > If not enough physical memory is available the kernel may fail mmap();
> > > > see __vm_enough_memory() and vm_commit_limit().
> > > > In that case the logic in validate_complete_va_space() does not make
> > > > sense and will even incorrectly fail.
> > > > Instead skip the test if no mmap() succeeded.
> > > > 
> > > > Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
> > > > Cc: stable@vger.kernel.org
> 
> CC stable on tests is ... odd.

I thought it was fairly common, but it isn't.
Will drop it.

> > > > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > > > 
> > > > ---
> > > > The logic in __vm_enough_memory() seems weird.
> > > > It describes itself as "Check that a process has enough memory to
> > > > allocate a new virtual mapping", however it never checks the current
> > > > memory usage of the process.
> > > > So it only disallows large mappings. But many small mappings taking the
> > > > same amount of memory are allowed; and then even automatically merged
> > > > into one big mapping.
> > > > ---
> > > >    tools/testing/selftests/mm/virtual_address_range.c | 6 ++++++
> > > >    1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> > > > index 2a2b69e91950a37999f606847c9c8328d79890c2..d7bf8094d8bcd4bc96e2db4dc3fcb41968def859 100644
> > > > --- a/tools/testing/selftests/mm/virtual_address_range.c
> > > > +++ b/tools/testing/selftests/mm/virtual_address_range.c
> > > > @@ -178,6 +178,12 @@ int main(int argc, char *argv[])
> > > >    		validate_addr(ptr[i], 0);
> > > >    	}
> > > >    	lchunks = i;
> > > > +
> > > > +	if (!lchunks) {
> > > > +		ksft_test_result_skip("Not enough memory for a single chunk\n");
> > > > +		ksft_finished();
> > > > +	}
> > > > +
> > > >    	hptr = (char **) calloc(NR_CHUNKS_HIGH, sizeof(char *));
> > > >    	if (hptr == NULL) {
> > > >    		ksft_test_result_skip("Memory constraint not fulfilled\n");
> > > > 
> > > 
> > > I do not  know about __vm_enough_memory(), but I am going by your description:
> > > You say that the kernel may fail mmap() when enough physical memory is not
> > > there, but it may happen that we have already done 100 mmap()'s, and then
> > > the kernel fails mmap(), so if (!lchunks) won't be able to handle this case.
> > > Basically, lchunks == 0 is not a complete indicator of kernel failing mmap().
> > 
> > __vm_enough_memory() only checks the size of each single mmap() on its
> > own. It does not actually check the current memory or address space
> > usage of the process.
> > This seems a bit weird, as indicated in my after-the-fold explanation.
> > 
> > > The basic assumption of the test is that any process should be able to exhaust
> > > its virtual address space, and running the test under memory pressure and the
> > > kernel violating this behaviour defeats the point of the test I think?
> > 
> > The assumption is correct, as soon as one mapping succeeds the others
> > will also succeed, until the actual address space is exhausted.
> > 
> > Looking at it again, __vm_enough_memory() is only called for writable
> > mappings, so it would be possible to use only readable mappings in the
> > test. The test will still fail with OOM, as the many PTEs need more than
> > 1GiB of physical memory anyways, but at least that produces a usable
> > error message.
> > However I'm not sure if this would violate other test assumptions.
> > 
> 
> Note that with MAP_NORESRVE, most setups we care about will allow mapping as
> much as you want, but on access OOM will fire.

Thanks for the hint.

> So one could require that /proc/sys/vm/overcommit_memory is setup properly
> and use MAP_NORESRVE.

Isn't the check for lchunks == 0 essentially exactly this?

> Reading from anonymous memory will populate the shared zeropage. To mitigate
> OOM from "too many page tables", one could simply unmap the pieces as they
> are verified (or MAP_FIXED over them, to free page tables).

The code has to figure out if a verified region was created by mmap(),
otherwise an munmap() could crash the process.
As the entries from /proc/self/maps may have been merged and (I assume)
the ordering of mappings is not guaranteed, some bespoke logic to establish
the link will be needed.

Is it fine to rely on CONFIG_ANON_VMA_NAME?
That would make it much easier to implement.

Using MAP_NORESERVE and eager munmap()s, the testcase works nicely even
in very low physical memory conditions.

Thomas

