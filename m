Return-Path: <linux-kselftest+bounces-26853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAE8A39E78
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 15:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19BA1188D422
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 14:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581DB26A087;
	Tue, 18 Feb 2025 14:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IZod+D5X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m+/+eXUQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IZod+D5X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m+/+eXUQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9D6265CCC
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888160; cv=none; b=oEIecoaH3ZlU1lHfuxokBY81YI9jGm14D5O64cWzgGsKhaiy0UeQ+hKzSDONPh+viyNLngWyfytp73oWLJqsVUklf4BrXN3EoK4wPNqt77uYKavY6lmBRyP3oUvWu9GuuyHc6yJbmf6dWB4msXA8i5dUJVY9Ju5PSklBBbdDdvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888160; c=relaxed/simple;
	bh=wbaWJEYs63an8hYhHe5clLO+q0SsrXPrRql525V7XMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1sZWtEz7vSYdHISnFWqRycCUf3d1/K7fpMiHIrqzazFX52031/W26CZXr9BWct4rdtXUxi/lCt6cgR1YpPS7wXifqLzELR1Sjex52MPiA5N+ZmTBw0Eq9940mIqPZpxq/89UJE8UTJ6LOJlomQrg8y0A/6NromLyxxxXxeUvgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IZod+D5X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m+/+eXUQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IZod+D5X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m+/+eXUQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 509EE1F396;
	Tue, 18 Feb 2025 14:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739888155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Zzo/PFWjpfLLP255b9u5isxGAMgZSmkcdPseWGgqFbE=;
	b=IZod+D5X7rF9qIvo1AzBqv1YQb+5wCv2BUk23+oOvDGDcNWs3NnHtPV94448fc4/LIodVh
	rTiAlWyA6HSZZEjkAgyfJU0VPKw1h/BdBB9xNdl15ypfiEL6lsWX4qr4Wn5se2/9sml96/
	96l+NGht0PbT80JNKFrIItsnby0scxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739888155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Zzo/PFWjpfLLP255b9u5isxGAMgZSmkcdPseWGgqFbE=;
	b=m+/+eXUQjdmoNKh3jUcMMaZdpiwhYUM3Twh+BBmw5Xbl5TlVBSQ3BrVbRWGY4pLi6N50Xw
	hKwvjpLQ2VymNoBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739888155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Zzo/PFWjpfLLP255b9u5isxGAMgZSmkcdPseWGgqFbE=;
	b=IZod+D5X7rF9qIvo1AzBqv1YQb+5wCv2BUk23+oOvDGDcNWs3NnHtPV94448fc4/LIodVh
	rTiAlWyA6HSZZEjkAgyfJU0VPKw1h/BdBB9xNdl15ypfiEL6lsWX4qr4Wn5se2/9sml96/
	96l+NGht0PbT80JNKFrIItsnby0scxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739888155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Zzo/PFWjpfLLP255b9u5isxGAMgZSmkcdPseWGgqFbE=;
	b=m+/+eXUQjdmoNKh3jUcMMaZdpiwhYUM3Twh+BBmw5Xbl5TlVBSQ3BrVbRWGY4pLi6N50Xw
	hKwvjpLQ2VymNoBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A4F5132C7;
	Tue, 18 Feb 2025 14:15:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qjSSCRuWtGfjXQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 18 Feb 2025 14:15:55 +0000
Message-ID: <a1a9b4e4-a590-4300-a882-88699267c83c@suse.cz>
Date: Tue, 18 Feb 2025 15:15:54 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] selftests/mm: rename guard-pages to guard-regions
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
 David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>,
 Kalesh Singh <kaleshsingh@google.com>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <1c3cd04a3f69b5756b94bda701ac88325a9be18b.1739469950.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <1c3cd04a3f69b5756b94bda701ac88325a9be18b.1739469950.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email,oracle.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 2/13/25 19:17, Lorenzo Stoakes wrote:
> The feature formerly referred to as guard pages is more correctly referred
> to as 'guard regions', as in fact no pages are ever allocated in the
> process of installing the regions.
> 
> To avoid confusion, rename the tests accordingly.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  tools/testing/selftests/mm/.gitignore         |  2 +-
>  tools/testing/selftests/mm/Makefile           |  2 +-
>  .../mm/{guard-pages.c => guard-regions.c}     | 42 +++++++++----------
>  3 files changed, 23 insertions(+), 23 deletions(-)
>  rename tools/testing/selftests/mm/{guard-pages.c => guard-regions.c} (98%)
> 
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index 121000c28c10..c5241b193db8 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -57,4 +57,4 @@ droppable
>  hugetlb_dio
>  pkey_sighandler_tests_32
>  pkey_sighandler_tests_64
> -guard-pages
> +guard-regions
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 63ce39d024bb..8270895039d1 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -97,7 +97,7 @@ TEST_GEN_FILES += hugetlb_fault_after_madv
>  TEST_GEN_FILES += hugetlb_madv_vs_map
>  TEST_GEN_FILES += hugetlb_dio
>  TEST_GEN_FILES += droppable
> -TEST_GEN_FILES += guard-pages
> +TEST_GEN_FILES += guard-regions
>  
>  ifneq ($(ARCH),arm64)
>  TEST_GEN_FILES += soft-dirty
> diff --git a/tools/testing/selftests/mm/guard-pages.c b/tools/testing/selftests/mm/guard-regions.c
> similarity index 98%
> rename from tools/testing/selftests/mm/guard-pages.c
> rename to tools/testing/selftests/mm/guard-regions.c
> index ece37212a8a2..7a41cf9ffbdf 100644
> --- a/tools/testing/selftests/mm/guard-pages.c
> +++ b/tools/testing/selftests/mm/guard-regions.c
> @@ -107,12 +107,12 @@ static bool try_read_write_buf(char *ptr)
>  	return try_read_buf(ptr) && try_write_buf(ptr);
>  }
>  
> -FIXTURE(guard_pages)
> +FIXTURE(guard_regions)
>  {
>  	unsigned long page_size;
>  };
>  
> -FIXTURE_SETUP(guard_pages)
> +FIXTURE_SETUP(guard_regions)
>  {
>  	struct sigaction act = {
>  		.sa_handler = &handle_fatal,
> @@ -126,7 +126,7 @@ FIXTURE_SETUP(guard_pages)
>  	self->page_size = (unsigned long)sysconf(_SC_PAGESIZE);
>  };
>  
> -FIXTURE_TEARDOWN(guard_pages)
> +FIXTURE_TEARDOWN(guard_regions)
>  {
>  	struct sigaction act = {
>  		.sa_handler = SIG_DFL,
> @@ -137,7 +137,7 @@ FIXTURE_TEARDOWN(guard_pages)
>  	sigaction(SIGSEGV, &act, NULL);
>  }
>  
> -TEST_F(guard_pages, basic)
> +TEST_F(guard_regions, basic)
>  {
>  	const unsigned long NUM_PAGES = 10;
>  	const unsigned long page_size = self->page_size;
> @@ -231,7 +231,7 @@ TEST_F(guard_pages, basic)
>  }
>  
>  /* Assert that operations applied across multiple VMAs work as expected. */
> -TEST_F(guard_pages, multi_vma)
> +TEST_F(guard_regions, multi_vma)
>  {
>  	const unsigned long page_size = self->page_size;
>  	char *ptr_region, *ptr, *ptr1, *ptr2, *ptr3;
> @@ -367,7 +367,7 @@ TEST_F(guard_pages, multi_vma)
>   * Assert that batched operations performed using process_madvise() work as
>   * expected.
>   */
> -TEST_F(guard_pages, process_madvise)
> +TEST_F(guard_regions, process_madvise)
>  {
>  	const unsigned long page_size = self->page_size;
>  	pid_t pid = getpid();
> @@ -467,7 +467,7 @@ TEST_F(guard_pages, process_madvise)
>  }
>  
>  /* Assert that unmapping ranges does not leave guard markers behind. */
> -TEST_F(guard_pages, munmap)
> +TEST_F(guard_regions, munmap)
>  {
>  	const unsigned long page_size = self->page_size;
>  	char *ptr, *ptr_new1, *ptr_new2;
> @@ -505,7 +505,7 @@ TEST_F(guard_pages, munmap)
>  }
>  
>  /* Assert that mprotect() operations have no bearing on guard markers. */
> -TEST_F(guard_pages, mprotect)
> +TEST_F(guard_regions, mprotect)
>  {
>  	const unsigned long page_size = self->page_size;
>  	char *ptr;
> @@ -553,7 +553,7 @@ TEST_F(guard_pages, mprotect)
>  }
>  
>  /* Split and merge VMAs and make sure guard pages still behave. */
> -TEST_F(guard_pages, split_merge)
> +TEST_F(guard_regions, split_merge)
>  {
>  	const unsigned long page_size = self->page_size;
>  	char *ptr, *ptr_new;
> @@ -684,7 +684,7 @@ TEST_F(guard_pages, split_merge)
>  }
>  
>  /* Assert that MADV_DONTNEED does not remove guard markers. */
> -TEST_F(guard_pages, dontneed)
> +TEST_F(guard_regions, dontneed)
>  {
>  	const unsigned long page_size = self->page_size;
>  	char *ptr;
> @@ -737,7 +737,7 @@ TEST_F(guard_pages, dontneed)
>  }
>  
>  /* Assert that mlock()'ed pages work correctly with guard markers. */
> -TEST_F(guard_pages, mlock)
> +TEST_F(guard_regions, mlock)
>  {
>  	const unsigned long page_size = self->page_size;
>  	char *ptr;
> @@ -810,7 +810,7 @@ TEST_F(guard_pages, mlock)
>   *
>   * - Moving a mapping alone should retain markers as they are.
>   */
> -TEST_F(guard_pages, mremap_move)
> +TEST_F(guard_regions, mremap_move)
>  {
>  	const unsigned long page_size = self->page_size;
>  	char *ptr, *ptr_new;
> @@ -857,7 +857,7 @@ TEST_F(guard_pages, mremap_move)
>   * will have to remove guard pages manually to fix up (they'd have to do the
>   * same if it were a PROT_NONE mapping).
>   */
> -TEST_F(guard_pages, mremap_expand)
> +TEST_F(guard_regions, mremap_expand)
>  {
>  	const unsigned long page_size = self->page_size;
>  	char *ptr, *ptr_new;
> @@ -920,7 +920,7 @@ TEST_F(guard_pages, mremap_expand)
>   * if the user were using a PROT_NONE mapping they'd have to manually fix this
>   * up also so this is OK.
>   */
> -TEST_F(guard_pages, mremap_shrink)
> +TEST_F(guard_regions, mremap_shrink)
>  {
>  	const unsigned long page_size = self->page_size;
>  	char *ptr;
> @@ -984,7 +984,7 @@ TEST_F(guard_pages, mremap_shrink)
>   * Assert that forking a process with VMAs that do not have VM_WIPEONFORK set
>   * retain guard pages.
>   */
> -TEST_F(guard_pages, fork)
> +TEST_F(guard_regions, fork)
>  {
>  	const unsigned long page_size = self->page_size;
>  	char *ptr;
> @@ -1039,7 +1039,7 @@ TEST_F(guard_pages, fork)
>   * Assert expected behaviour after we fork populated ranges of anonymous memory
>   * and then guard and unguard the range.
>   */
> -TEST_F(guard_pages, fork_cow)
> +TEST_F(guard_regions, fork_cow)
>  {
>  	const unsigned long page_size = self->page_size;
>  	char *ptr;
> @@ -1110,7 +1110,7 @@ TEST_F(guard_pages, fork_cow)
>   * Assert that forking a process with VMAs that do have VM_WIPEONFORK set
>   * behave as expected.
>   */
> -TEST_F(guard_pages, fork_wipeonfork)
> +TEST_F(guard_regions, fork_wipeonfork)
>  {
>  	const unsigned long page_size = self->page_size;
>  	char *ptr;
> @@ -1160,7 +1160,7 @@ TEST_F(guard_pages, fork_wipeonfork)
>  }
>  
>  /* Ensure that MADV_FREE retains guard entries as expected. */
> -TEST_F(guard_pages, lazyfree)
> +TEST_F(guard_regions, lazyfree)
>  {
>  	const unsigned long page_size = self->page_size;
>  	char *ptr;
> @@ -1196,7 +1196,7 @@ TEST_F(guard_pages, lazyfree)
>  }
>  
>  /* Ensure that MADV_POPULATE_READ, MADV_POPULATE_WRITE behave as expected. */
> -TEST_F(guard_pages, populate)
> +TEST_F(guard_regions, populate)
>  {
>  	const unsigned long page_size = self->page_size;
>  	char *ptr;
> @@ -1222,7 +1222,7 @@ TEST_F(guard_pages, populate)
>  }
>  
>  /* Ensure that MADV_COLD, MADV_PAGEOUT do not remove guard markers. */
> -TEST_F(guard_pages, cold_pageout)
> +TEST_F(guard_regions, cold_pageout)
>  {
>  	const unsigned long page_size = self->page_size;
>  	char *ptr;
> @@ -1268,7 +1268,7 @@ TEST_F(guard_pages, cold_pageout)
>  }
>  
>  /* Ensure that guard pages do not break userfaultd. */
> -TEST_F(guard_pages, uffd)
> +TEST_F(guard_regions, uffd)
>  {
>  	const unsigned long page_size = self->page_size;
>  	int uffd;


