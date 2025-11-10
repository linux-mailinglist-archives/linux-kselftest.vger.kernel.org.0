Return-Path: <linux-kselftest+bounces-45213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC9AC45F33
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 11:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0E3F188218E
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 10:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A52725D527;
	Mon, 10 Nov 2025 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4JOMTZp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305EB22A4E1;
	Mon, 10 Nov 2025 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770800; cv=none; b=FIRygB2J1mcbsJGhpWhblr6UMJtY/2r6php7rznEkpoD3TlvstdE2cwvZYIM6e95eYFdCc6gWR3yZndEULz/oovllL4bSiy9dob3F+AVEHPGjhU4KKCj+Tc7W9oMJyjkXoj4Sg1bYefQD7r8xeachbKH6Xn80/O4leHwa2T1wt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770800; c=relaxed/simple;
	bh=XGdAZQMoYX6Us3MCpLM/NxmAUfTsARkCljiFE1chCCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJdL1LF36HA2S8Vw5umCQPnIBvWZfwwxGhoHuMse4VhUjpyiOhpSJMscmcuGsaKc0s3QseWsFeKyVcydTjVKskcme1xCvT5RFG+jkau6TYC4xtgpMu0C0KKxZ3GARibwCaKND+IRsJJf905yDKXj8+WWgu4+pfUke06nvouxdYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4JOMTZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E38C4CEFB;
	Mon, 10 Nov 2025 10:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762770799;
	bh=XGdAZQMoYX6Us3MCpLM/NxmAUfTsARkCljiFE1chCCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J4JOMTZpT9f7JobhPkEEVtMbrvMHN/QmyRT6CkgFjCdJG5tsJTSz8geO6tHzfz4MZ
	 GOtCv9QmePCfHi7gUxydKyaNAHExL86jJuMscDVKgAWHZ7EJQr57EVkxmdLu75Y+fa
	 0e1xo+JMgJNAA5omFi7cogT0zgMR1tsoDvsDgs7KZw1EhYLo4SQ8Go6krZUCmuxhX+
	 TlUwbp/UOOC/EQHwOjQ9q8LN4U6NTRoMDnhC0LYEYxbZTExqiiDH/Y7wbBEyqMfYlr
	 r1v9Pp87oj1/1F+lROk+yyvElmJFs/KQ/dMSJPduQqa1ttaRNf6qVKNo4lb44QhkeA
	 ibjK5TaviSRAQ==
Date: Mon, 10 Nov 2025 12:33:11 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftest/mm: fix pointer comparison in mremap_test
Message-ID: <aRG_Z7p1jwEUsRy5@kernel.org>
References: <20251108161829.25105-1-ankitkhushwaha.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108161829.25105-1-ankitkhushwaha.linux@gmail.com>

On Sat, Nov 08, 2025 at 09:48:29PM +0530, Ankit Khushwaha wrote:
> Pointer arthemitic with 'void * addr' and 'ulong dest_alignment'
> triggers following warning:
> 
> mremap_test.c:1035:31: warning: pointer comparison always evaluates to
> false [-Wtautological-compare]
>  1035 |                 if (addr + c.dest_alignment < addr) {
>       |                                             ^
> 
> this warning is raised from clang version 20.1.8 (Fedora 20.1.8-4.fc42).
> 
> use 'void *tmp_addr' to do the pointer arthemitic.
> 
> Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
> ---
> Changelog:
> v2:
> - use 'void *tmp_addr' for pointer arthemitic instead of typecasting
> 'addr' to 'unsigned long long' as suggested by Andrew.
> 
> v1: https://lore.kernel.org/linux-kselftest/20251106104917.39890-1-ankitkhushwaha.linux@gmail.com/
> ---
>  tools/testing/selftests/mm/mremap_test.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
> index a95c0663a011..308576437228 100644
> --- a/tools/testing/selftests/mm/mremap_test.c
> +++ b/tools/testing/selftests/mm/mremap_test.c
> @@ -994,7 +994,7 @@ static void mremap_move_multi_invalid_vmas(FILE *maps_fp, unsigned long page_siz
>  static long long remap_region(struct config c, unsigned int threshold_mb,
>  			      char *rand_addr)
>  {
> -	void *addr, *src_addr, *dest_addr, *dest_preamble_addr = NULL;
> +	void *addr, *tmp_addr, *src_addr, *dest_addr, *dest_preamble_addr = NULL;
>  	unsigned long long t, d;
>  	struct timespec t_start = {0, 0}, t_end = {0, 0};
>  	long long  start_ns, end_ns, align_mask, ret, offset;
> @@ -1032,7 +1032,8 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
>  	/* Don't destroy existing mappings unless expected to overlap */
>  	while (!is_remap_region_valid(addr, c.region_size) && !c.overlapping) {
>  		/* Check for unsigned overflow */
> -		if (addr + c.dest_alignment < addr) {
> +		tmp_addr = addr + c.dest_alignment;

Nit: tmp_addr can be declared here.

Other than that

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> +		if (tmp_addr < addr) {
>  			ksft_print_msg("Couldn't find a valid region to remap to\n");
>  			ret = -1;
>  			goto clean_up_src;
> --
> 2.51.1
> 

-- 
Sincerely yours,
Mike.

