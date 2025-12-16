Return-Path: <linux-kselftest+bounces-47591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E41DBCC114F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 07:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4D3130262AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 06:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC7233B6E6;
	Tue, 16 Dec 2025 06:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gq8h3iTc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEA92D878D;
	Tue, 16 Dec 2025 06:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765865741; cv=none; b=OWXJrbEcQwYNSOrsXCQew/eZGVCVvA8TxBQIfZIXmX8h1zWxc8zpCm+FgRrmnLpXO8z2vtQjZ7ZWhTLG6vSTky3hKRiGLmI9eSIQMvfEEUfMe//PtbKpel+DE8DKpuY0kErIz/IvlFt/7r83jR3g4b2So3zF0x0boxMNEMYOY3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765865741; c=relaxed/simple;
	bh=wvdO8w2J02Po7liRduRPemBeLA5dbDMtI1kfUlC3tGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBX90s0S2js9vTcORqEsLk/dYZmkEklDBAXxRQzzNLimNDmOthgBoeAiyJIA8IL+4f03BDQ6U1ahzG5gKLJKmaapjGVRI1DSnxurVbJFURqg1p0JMxzjniN2RQ+I98PI7Nwu++fp7DioeyjK6bT4p9nbJrI1CZtCRDXY461/k80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gq8h3iTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8EAC4CEF1;
	Tue, 16 Dec 2025 06:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765865741;
	bh=wvdO8w2J02Po7liRduRPemBeLA5dbDMtI1kfUlC3tGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gq8h3iTcRCuxYUusO3Y4fB/mnBtIQknYCrU2rFzXNytVnEWECHtviN35iqkOiidF/
	 rStM91yoSvzl5uFcGdDwt4saGuOZK1cCRTuvNeHDQwTJXlJbBqt5AzyELBPtN0QauO
	 dW2ocJU0ZI7Zo/E9P42D04VrGth6doxyIrsvVAY0Mqul1pUudP+UBzWnxXUpHuN3AL
	 Nzdr2VFTZ7+jA+/gS/ao9kiQ4bXUj+eHejLOax4AzWqnHl5ETW3ZiiX/nKrc8knrGn
	 KltTV0NZaod/D5WOSiR6UZKSS+QiSA8EMAtBBTV8Q+ac8D+QyA+Gbt6iZNEdvhmq4v
	 S97es6G/c5t2A==
Date: Tue, 16 Dec 2025 08:15:31 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Wake Liu <wakel@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, Peter Xu <peterx@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] selftests/mm: Fix thread state check in uffd-unit-tests
Message-ID: <aUD5A/jNwW1g7wDJ@kernel.org>
References: <20251210091408.3781445-1-wakel@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210091408.3781445-1-wakel@google.com>

On Wed, Dec 10, 2025 at 05:14:08PM +0800, Wake Liu wrote:
> In the thread_state_get() function, the logic to find the thread's state
> character was using `sizeof(header) - 1` to calculate the offset from
> the "State:\t" string.
> 
> The `header` variable is a `const char *` pointer. `sizeof()` on a
> pointer returns the size of the pointer itself, not the length of the
> string literal it points to. This makes the code's behavior dependent
> on the architecture's pointer size.
> 
> This bug was identified on a 32-bit ARM build (`gsi_tv_arm`) for
> Android, running on an ARMv8-based device, compiled with Clang 19.0.1.
> 
> On this 32-bit architecture, `sizeof(char *)` is 4. The expression
> `sizeof(header) - 1` resulted in an incorrect offset of 3, causing the
> test to read the wrong character from `/proc/[tid]/status` and fail.
> 
> On 64-bit architectures, `sizeof(char *)` is 8, so the expression
> coincidentally evaluates to 7, which matches the length of "State:\t".
> This is why the bug likely remained hidden on 64-bit builds.
> 
> To fix this and make the code portable and correct across all
> architectures, this patch replaces `sizeof(header) - 1` with
> `strlen(header)`. The `strlen()` function correctly calculates the
> string's length, ensuring the correct offset is always used.
> 
> Signed-off-by: Wake Liu <wakel@google.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  tools/testing/selftests/mm/uffd-unit-tests.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
> index f4807242c5b2..6f5e404a446c 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> @@ -1317,7 +1317,7 @@ static thread_state thread_state_get(pid_t tid)
>  		p = strstr(tmp, header);
>  		if (p) {
>  			/* For example, "State:\tD (disk sleep)" */
> -			c = *(p + sizeof(header) - 1);
> +			c = *(p + strlen(header));
>  			return c == 'D' ?
>  			    THR_STATE_UNINTERRUPTIBLE : THR_STATE_UNKNOWN;
>  		}
> -- 
> 2.52.0.223.gf5cc29aaa4-goog
> 

-- 
Sincerely yours,
Mike.

