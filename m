Return-Path: <linux-kselftest+bounces-46602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F28C8CD8E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 06:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEEF34E5E43
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 05:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1536230FC1F;
	Thu, 27 Nov 2025 05:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUD3vwtq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4D330FC0F;
	Thu, 27 Nov 2025 05:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764219991; cv=none; b=FbI101RMSNC4bM42HJsB7wq0yo+ZsxsixtNt2Ie8GxiD2qugeu7g+uIdFzGo5S403B4mDJQRKdxKZZXvmx0isns/uXjsk/5CAr4291S2qZixhQ5ynbEFnFvzCwwGuG95TopaSZqwk0KhZWw5RRdJ1aPn3nrL3YWu2FiuycRq0fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764219991; c=relaxed/simple;
	bh=9KGqhg7bfj1kYxRW5hx3J4260dqKwUVUWWB8jKANxiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIWA53t8577ERnxZo/sG5AZRzUI3byq407bL20ZT1Fn2baA2nDm0SKrGcYAX+fbexWFsrtIAIigVBF+dY+i/LUGwIJyZe1THgmf6/T84Gva5thVjm5MCgaHfXhhNS6pMn9lLy7bzAc5QA4OuLBm2Etey0y2gEEb9x62eOOe15Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUD3vwtq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8A2C4CEF8;
	Thu, 27 Nov 2025 05:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764219991;
	bh=9KGqhg7bfj1kYxRW5hx3J4260dqKwUVUWWB8jKANxiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bUD3vwtq7DBusOVYT88WRzd+l/tl2pENfsZwVOzSdSHlfCnTWpFbXAu6vZ/BfN+Yl
	 UtYgdlJ9Ie9rQTLqz0tyCxVyi961e4bJxwzyIWuWKTFWdLYGVeLzjbdItUCAg13aiE
	 BE6dKASgyEYwWa2dpYUCu996Fi3njrLV+lyaTqwk9Y2JnLt4IEKuVrv4h/+yao8S8E
	 pSb4p+Cvy8kaBP8Lo9ItLc0DL6Tku2JF6nBKYUehJ084XoVltVazaxVUy+FrwYmW/z
	 4yJBhzu0hHzJ9xaVXrYetVXrNW+ZVt+MW7hIeuetUsMKMpDTc0i/m8oGMFjD6y7S0y
	 glXNgVD1nCzWA==
Date: Thu, 27 Nov 2025 07:06:21 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] selftests/mm/uffd: initialize char variable to Null
Message-ID: <aSfcTS3xf64zLdbR@kernel.org>
References: <20251126160830.52124-1-ankitkhushwaha.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126160830.52124-1-ankitkhushwaha.linux@gmail.com>

On Wed, Nov 26, 2025 at 09:38:30PM +0530, Ankit Khushwaha wrote:
> In "uffd-stress.c" & "uffd-unit-tests.c". address of char variable having
> garbage value (uninitialized) is passed to 'write' syscall triggers
> warning.
> 
> 	uffd-stress.c:246:39: warning: variable 'c' is uninitialized when
> 	passed  as a const pointer argument here
> 	[-Wuninitialized-const-pointer]
> 
> 	uffd-unit-tests.c:581:31: warning: variable 'c' is uninitialized
> 	when passed as a const pointer argument here
> 	[-Wuninitialized-const-pointer]
> 
> so the fix is to assign char variable to '\0' to prevent writing of
> garbage value.
> 
> Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> this warning is raised with clang version 21.1.5 (Fedora 21.1.5-1.fc43).
> ---
>  tools/testing/selftests/mm/uffd-stress.c     | 2 +-
>  tools/testing/selftests/mm/uffd-unit-tests.c | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> index b51c89e1cd1a..700fbaa18d44 100644
> --- a/tools/testing/selftests/mm/uffd-stress.c
> +++ b/tools/testing/selftests/mm/uffd-stress.c
> @@ -241,7 +241,7 @@ static int stress(struct uffd_args *args)
>  			return 1;
> 
>  	for (cpu = 0; cpu < gopts->nr_parallel; cpu++) {
> -		char c;
> +		char c = '\0';
>  		if (bounces & BOUNCE_POLL) {
>  			if (write(gopts->pipefd[cpu*2+1], &c, 1) != 1)
>  				err("pipefd write error");
> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
> index f917b4c4c943..f4807242c5b2 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> @@ -543,7 +543,7 @@ static void uffd_minor_test_common(uffd_global_test_opts_t *gopts, bool test_col
>  {
>  	unsigned long p;
>  	pthread_t uffd_mon;
> -	char c;
> +	char c = '\0';
>  	struct uffd_args args = { 0 };
>  	args.gopts = gopts;
> 
> @@ -759,7 +759,7 @@ static void uffd_sigbus_test_common(uffd_global_test_opts_t *gopts, bool wp)
>  	pthread_t uffd_mon;
>  	pid_t pid;
>  	int err;
> -	char c;
> +	char c = '\0';
>  	struct uffd_args args = { 0 };
>  	args.gopts = gopts;
> 
> @@ -819,7 +819,7 @@ static void uffd_events_test_common(uffd_global_test_opts_t *gopts, bool wp)
>  	pthread_t uffd_mon;
>  	pid_t pid;
>  	int err;
> -	char c;
> +	char c = '\0';
>  	struct uffd_args args = { 0 };
>  	args.gopts = gopts;
> 
> @@ -1125,7 +1125,7 @@ uffd_move_test_common(uffd_global_test_opts_t *gopts,
>  {
>  	unsigned long nr;
>  	pthread_t uffd_mon;
> -	char c;
> +	char c = '\0';
>  	unsigned long long count;
>  	struct uffd_args args = { 0 };
>  	char *orig_area_src = NULL, *orig_area_dst = NULL;
> --
> 2.52.0
> 

-- 
Sincerely yours,
Mike.

