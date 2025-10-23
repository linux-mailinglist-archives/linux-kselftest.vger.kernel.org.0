Return-Path: <linux-kselftest+bounces-43846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87DABFF77B
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 09:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E53C3A78A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 07:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E2A2BDC29;
	Thu, 23 Oct 2025 07:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OODg5w6E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C56026F29B;
	Thu, 23 Oct 2025 07:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203638; cv=none; b=hM8vi0J7xDKrT6KLx7xMqiiQMbiH/I5psJzxwoJ7ZlO2VB5xe4Bb28Us5tJdc7CFQLyjiA7zzALO80eS4YUGGnZZ54ht6yTescULqG/zOtFM5KunZpIy8Zxw/HKilJ8hr/sPLjMCLXVL+ItR41XrLTsbqJkxhXRrDZxDgI+t3gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203638; c=relaxed/simple;
	bh=2Z6faUlpxxg8NJ99mOXDv3nxN6IIqbuwazngqBJ2agg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qmlv5X32U2mGQ3BGHQmieRcI/dP+DgvsSZpSNZ79TQyr/1CixSRuI+MHUoJN4SmXAsl3VuprpYNjqnyhW0NraabieaukomzitbF1Pc+lqmroQrGiGn5qHuFj5XbQzsp8KTY9yXToaHaaiytFY05prpgckLBdVb26KOy7SFm2gdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OODg5w6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24502C4CEE7;
	Thu, 23 Oct 2025 07:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761203637;
	bh=2Z6faUlpxxg8NJ99mOXDv3nxN6IIqbuwazngqBJ2agg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OODg5w6EFB/hjsGbHVp2Vq9m7F+hBZgNtIuU5LNZe2mYTpdNyCVCbIXUA3Vdvyk52
	 ErhoZo9K7Z89GKXdanMvWKrAWUrbXY67tNn6zxtWL+7BzQSgaPo52fDLmUpan2VWdD
	 rE2qNVF+7AsYdvGZDRWtc/a8+uxAsg54+3aw866XKzV9gBQuY2ujGksVFsgziH3ktL
	 opVRerWZOfIvj8VhNQRP2iKDKInrAtXVwvVYm96tdy08q1RKVcXFwAqP524kuC2LgX
	 DtWdWbTC1YhHlmVgdTf6JFxr4NPdwQYSVh2DnnrfeRw81pRGpc9vwOUINW3WpTOZVf
	 BlAC0rtfGtWXA==
Date: Thu, 23 Oct 2025 10:13:49 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	masahiroy@kernel.org, ojeda@kernel.org, pratyush@kernel.org,
	rdunlap@infradead.org, tj@kernel.org
Subject: Re: [PATCHv7 1/7] kho: allow to drive kho from within kernel
Message-ID: <aPnVrZC4Fz273lLn@kernel.org>
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
 <20251022005719.3670224-2-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022005719.3670224-2-pasha.tatashin@soleen.com>

On Tue, Oct 21, 2025 at 08:57:13PM -0400, Pasha Tatashin wrote:
> Allow kernel to drive finalize and abort without requiring triggers
> from the userspace.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/kexec_handover.h | 15 +++++++
>  kernel/kexec_handover.c        | 75 +++++++++++++++++++++-------------
>  2 files changed, 61 insertions(+), 29 deletions(-)
> 
> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
> index 25042c1d8d54..04d0108db98e 100644
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -67,6 +67,10 @@ void kho_memory_init(void);
>  
>  void kho_populate(phys_addr_t fdt_phys, u64 fdt_len, phys_addr_t scratch_phys,
>  		  u64 scratch_len);
> +
> +int kho_finalize(void);
> +int kho_abort(void);
> +
>  #else
>  static inline bool kho_is_enabled(void)
>  {
> @@ -139,6 +143,17 @@ static inline void kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  				phys_addr_t scratch_phys, u64 scratch_len)
>  {
>  }
> +
> +static inline int kho_finalize(void)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int kho_abort(void)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  #endif /* CONFIG_KEXEC_HANDOVER */
>  
>  #endif /* LINUX_KEXEC_HANDOVER_H */
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index de4466b47455..6458f369a346 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -1087,7 +1087,7 @@ static int kho_out_update_debugfs_fdt(void)
>  	return err;
>  }
>  
> -static int kho_abort(void)
> +static int __kho_abort(void)
>  {
>  	int err;
>  	unsigned long order;
> @@ -1120,7 +1120,27 @@ static int kho_abort(void)
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
> +	if (!kho_out.finalized)
> +		return -ENOENT;
> +
> +	ret = __kho_abort();
> +	if (ret)
> +		return ret;
> +
> +	kho_out.finalized = false;
> +
> +	return kho_out_update_debugfs_fdt();
> +}
> +
> +static int __kho_finalize(void)
>  {
>  	int err = 0;
>  	u64 *preserved_mem_map;
> @@ -1163,12 +1183,32 @@ static int kho_finalize(void)
>  abort:
>  	if (err) {
>  		pr_err("Failed to convert KHO state tree: %d\n", err);
> -		kho_abort();
> +		__kho_abort();
>  	}
>  
>  	return err;
>  }
>  
> +int kho_finalize(void)
> +{
> +	int ret;
> +
> +	if (!kho_enable)
> +		return -EOPNOTSUPP;
> +
> +	guard(mutex)(&kho_out.lock);
> +	if (kho_out.finalized)
> +		return -EEXIST;
> +
> +	ret = __kho_finalize();
> +	if (ret)
> +		return ret;
> +
> +	kho_out.finalized = true;
> +
> +	return kho_out_update_debugfs_fdt();
> +}
> +
>  static int kho_out_finalize_get(void *data, u64 *val)
>  {
>  	mutex_lock(&kho_out.lock);
> @@ -1178,35 +1218,12 @@ static int kho_out_finalize_get(void *data, u64 *val)
>  	return 0;
>  }
>  
> -static int kho_out_finalize_set(void *data, u64 _val)
> +static int kho_out_finalize_set(void *data, u64 val)
>  {
> -	int ret = 0;
> -	bool val = !!_val;
> -
> -	mutex_lock(&kho_out.lock);
> -
> -	if (val == kho_out.finalized) {
> -		if (kho_out.finalized)
> -			ret = -EEXIST;
> -		else
> -			ret = -ENOENT;
> -		goto unlock;
> -	}
> -
>  	if (val)
> -		ret = kho_finalize();
> +		return kho_finalize();
>  	else
> -		ret = kho_abort();
> -
> -	if (ret)
> -		goto unlock;
> -
> -	kho_out.finalized = val;
> -	ret = kho_out_update_debugfs_fdt();
> -
> -unlock:
> -	mutex_unlock(&kho_out.lock);
> -	return ret;
> +		return kho_abort();
>  }
>  
>  DEFINE_DEBUGFS_ATTRIBUTE(fops_kho_out_finalize, kho_out_finalize_get,
> -- 
> 2.51.0.915.g61a8936c21-goog
> 

-- 
Sincerely yours,
Mike.

