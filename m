Return-Path: <linux-kselftest+bounces-43536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 562A7BEFB8D
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 09:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F14189CFB4
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 07:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013042DFA21;
	Mon, 20 Oct 2025 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GD/xJmWM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB892D7DFC;
	Mon, 20 Oct 2025 07:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760946226; cv=none; b=UWOFO6iSPhNMHpGmL7GLeqXL9eKeKCYW5bGvdjMHpOqxrnz71mT7vRzzAlqFaIAQTH8rd1XYuxIXcrcKNxauA7cxm5l5JuKunJiyPzJQJm1b6Luk8wiXsRSS+qFahDlICdPaoLMHez+U3LWW7KGK9v4s2FM78y6co3JcvtUFkdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760946226; c=relaxed/simple;
	bh=BO5RsfQHWdqK/8/bY6nMyHmhnk8uSPRdfDihSgALoXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ca+BT+Ceo5Em14SmfrkHu+Sh1pqYvwuyOs/5LQGvY/M1iSzzwLP9+ybMwBbUX91dKDZevN0sEgxAYZdcgENFyYVG55xkIp9ZCH9T6LYMJwXLF8vAf/q5xfNNiqSDxHVpTCMAUF7o8vosYPOjr1O0+dHVC0nz3DAMShfQH//b8DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GD/xJmWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CE9C4CEF9;
	Mon, 20 Oct 2025 07:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760946226;
	bh=BO5RsfQHWdqK/8/bY6nMyHmhnk8uSPRdfDihSgALoXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GD/xJmWMNtkh88BpkeuZO9yKhhM9JSXE1JpFOPv1KpkAbGOpAqegh5/3YqEzdjD9U
	 lTDl/Wc/FLZlR7lIYuS/F9qHTmoOqCqlfyOz8E/7GPfVByVjvtdRqIoowyu/Hfp6Fg
	 JlaRoqtVIPTNEybkOLgRTXPQsrW1Vo/iyAE0LJx9BKj4adC4ynSIfSVa9zPrNBa/PP
	 Q0XnfmCuVfH7qcVTl6Y0ZA564yFmOYs7icu9Y2C2f9M4joMHOcHgl2aJ6rrRSyrVyB
	 FVUyJ3vkkEKu8OQPHvfKuu6JfyV/spsBiSFRe6yYeyXd7idtvn/0H69T9cKglcej1L
	 egDCQfHTw7v4g==
Date: Mon, 20 Oct 2025 10:43:37 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	masahiroy@kernel.org, ojeda@kernel.org, pratyush@kernel.org,
	rdunlap@infradead.org, tj@kernel.org, jasonmiu@google.com,
	dmatlack@google.com, skhawaja@google.com
Subject: Re: [PATCH v6 01/10] kho: allow to drive kho from within kernel
Message-ID: <aPXoKRVAyGWCNj8I@kernel.org>
References: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
 <20251018171756.1724191-2-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018171756.1724191-2-pasha.tatashin@soleen.com>

On Sat, Oct 18, 2025 at 01:17:47PM -0400, Pasha Tatashin wrote:
> Allow to do finalize and abort from kernel modules, so LUO could

We surely don't want modules being able to drive that. Maybe

   allow kernel to drive finalize and abort without requiring triggers
   from the userspace

> drive the KHO sequence via its own state machine.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> ---
>  include/linux/kexec_handover.h | 15 +++++++
>  kernel/kexec_handover.c        | 74 ++++++++++++++++++++--------------
>  2 files changed, 59 insertions(+), 30 deletions(-)

...

> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index 76f0940fb485..76c34ea923f0 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -1067,7 +1067,7 @@ static int kho_out_update_debugfs_fdt(void)
>  	return err;
>  }
>  
> -static int kho_abort(void)
> +static int __kho_abort(void)
>  {
>  	int err;
>  	unsigned long order;
> @@ -1100,7 +1100,27 @@ static int kho_abort(void)
>  	return err;
>  }
>  
> -static int kho_finalize(void)
> +int kho_abort(void)
> +{
> +	int ret = 0;
> +
> +	if (!kho_enable)
> +		return -EOPNOTSUPP;
> +
> +	guard(mutex)(&kho_out.lock);

Please include linux/cleanup.h explicitly

> +	if (!kho_out.finalized)
> +		return -ENOENT;
> +

...

> -unlock:
> -	mutex_unlock(&kho_out.lock);
> -	return ret;
> +	return (!!_val) ? kho_finalize() : kho_abort();

An 'if' would be cleared IMO:

	if (val)
		return kho_finalize();
	else
		return kho_abort();

and we can rename u64 _val to u64 val as we are dropping the boolean.

>  }

-- 
Sincerely yours,
Mike.

