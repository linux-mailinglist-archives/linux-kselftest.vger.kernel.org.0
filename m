Return-Path: <linux-kselftest+bounces-24048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFB8A054F8
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 09:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784EA165663
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 08:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFCF1AF0D3;
	Wed,  8 Jan 2025 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ln3Ko/U9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HsNNeh3R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935981AA781;
	Wed,  8 Jan 2025 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736323553; cv=none; b=RSm4MNFYgwBRnbeaVgx1AE+FXZW58NrE1u7kH2ruHDaP87qf1vQKucm7IVU3BuJ0g7Bjnaay0wtfLkrRIsDLs0C4fnRb9hRTg6+Zrlnhrz9k7KBgSSEnWTC+aHo1EiDZj2/vbSQwi8O0z5icGs4jsXwIxBEfODWnMtaThGzP+2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736323553; c=relaxed/simple;
	bh=SyvnMFw9tENgnWpRfx0m3z6LwOVKNZyoCL+rq6ghP8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOGMZeL3Te/7n3tUwykJFFhL1+aj0iFGM/wZsTt08LIiKdT9bxHboijyK3m3zICkQxv9EfM7gkuyJfJMw/1TJS7l4Lfs2o8nw1Anvkau7k8zycEdYAiNi7G8e9fR+Zv8fPLvHwNIMVLnho5LlXv89GQ7+qnnV9khgOf6ww2pC4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ln3Ko/U9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HsNNeh3R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 8 Jan 2025 09:05:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736323549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qJmg0rlYDsu9eOC/BK9/42GtYToiXcNh3fOPiQsHx28=;
	b=ln3Ko/U9q5IFu3FTm0+YzBkPfHxxpock+ZTNMzitMYQtFkBRw2JpSECshDnLIfF/rN00Op
	fSQBOOJ3EYl3Sdwxi0WOWxF5hepkHR6hgNjrPm4g7c+LHI5pHJwxRV+caev0kBNQYZkxhA
	y3GWzSBW4DxJ03ywD1mAJN0H05Wc/JmEh0/62pa40wWCDBFb7l+4w9volysE35CZbpwb7S
	IUGlYW3zmXUMhjAC8mSliphBfcTtVkObUjv9J/bqeX44dAtILZMR+F6abM+WN65eI1iPk0
	3D4lRGPUmrzx0V+E/VogYIy7WY4zfei3T5DVaWy3xx5LrhFmVkbNQeL7mF9Vow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736323549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qJmg0rlYDsu9eOC/BK9/42GtYToiXcNh3fOPiQsHx28=;
	b=HsNNeh3RFpXd9rSUKsJHzCMMKUHXeFrMxlbNDm6s6+G9tA68kvlcLaXQnjcObvgWD/s1Be
	10Eqm24ER82AgcBA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Dev Jain <dev.jain@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/3] selftests/mm: virtual_address_range: Fix error when
 CommitLimit < 1GiB
Message-ID: <20250108083855-840c688b-003f-423b-8327-2a10a2b27d58@linutronix.de>
References: <20250107-virtual_address_range-tests-v1-0-3834a2fb47fe@linutronix.de>
 <20250107-virtual_address_range-tests-v1-1-3834a2fb47fe@linutronix.de>
 <5811cf74-d333-4653-ab64-0e981eda7745@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5811cf74-d333-4653-ab64-0e981eda7745@arm.com>

On Wed, Jan 08, 2025 at 11:46:19AM +0530, Dev Jain wrote:
> 
> On 07/01/25 8:44 pm, Thomas Weiﬂschuh wrote:
> > If not enough physical memory is available the kernel may fail mmap();
> > see __vm_enough_memory() and vm_commit_limit().
> > In that case the logic in validate_complete_va_space() does not make
> > sense and will even incorrectly fail.
> > Instead skip the test if no mmap() succeeded.
> > 
> > Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > 
> > ---
> > The logic in __vm_enough_memory() seems weird.
> > It describes itself as "Check that a process has enough memory to
> > allocate a new virtual mapping", however it never checks the current
> > memory usage of the process.
> > So it only disallows large mappings. But many small mappings taking the
> > same amount of memory are allowed; and then even automatically merged
> > into one big mapping.
> > ---
> >   tools/testing/selftests/mm/virtual_address_range.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> > index 2a2b69e91950a37999f606847c9c8328d79890c2..d7bf8094d8bcd4bc96e2db4dc3fcb41968def859 100644
> > --- a/tools/testing/selftests/mm/virtual_address_range.c
> > +++ b/tools/testing/selftests/mm/virtual_address_range.c
> > @@ -178,6 +178,12 @@ int main(int argc, char *argv[])
> >   		validate_addr(ptr[i], 0);
> >   	}
> >   	lchunks = i;
> > +
> > +	if (!lchunks) {
> > +		ksft_test_result_skip("Not enough memory for a single chunk\n");
> > +		ksft_finished();
> > +	}
> > +
> >   	hptr = (char **) calloc(NR_CHUNKS_HIGH, sizeof(char *));
> >   	if (hptr == NULL) {
> >   		ksft_test_result_skip("Memory constraint not fulfilled\n");
> > 
> 
> I do not  know about __vm_enough_memory(), but I am going by your description:
> You say that the kernel may fail mmap() when enough physical memory is not
> there, but it may happen that we have already done 100 mmap()'s, and then
> the kernel fails mmap(), so if (!lchunks) won't be able to handle this case.
> Basically, lchunks == 0 is not a complete indicator of kernel failing mmap().

__vm_enough_memory() only checks the size of each single mmap() on its
own. It does not actually check the current memory or address space
usage of the process.
This seems a bit weird, as indicated in my after-the-fold explanation.

> The basic assumption of the test is that any process should be able to exhaust
> its virtual address space, and running the test under memory pressure and the
> kernel violating this behaviour defeats the point of the test I think?

The assumption is correct, as soon as one mapping succeeds the others
will also succeed, until the actual address space is exhausted.

Looking at it again, __vm_enough_memory() is only called for writable
mappings, so it would be possible to use only readable mappings in the
test. The test will still fail with OOM, as the many PTEs need more than
1GiB of physical memory anyways, but at least that produces a usable
error message.
However I'm not sure if this would violate other test assumptions.

