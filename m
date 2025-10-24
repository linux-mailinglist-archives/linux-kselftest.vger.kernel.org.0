Return-Path: <linux-kselftest+bounces-43990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BE9C07122
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 17:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1311C0364F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 15:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA45328B4B;
	Fri, 24 Oct 2025 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeyQ2w4G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64FA2DA765;
	Fri, 24 Oct 2025 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320933; cv=none; b=t5Ui0bzqy8Tvyo1RnBZhTzeyLH/RdTEAS//Qs8eBXpe7HKZpCZiNhcXo5rtRBmwAsALT+X1dLK69A+o5ZjQdDjzxJpu6Jw19xtPUEoiswLO7AMDvVChyBicXUF+2nyi09a2yAABlV2m56aZAmcCB2/0k4FnTH0njqGyljfP2E1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320933; c=relaxed/simple;
	bh=e4EnLs+KI0UqXaB1trgD5GCu2ZyhkG5qzX3ngK0Lo1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=leRJ1FwgKNILnt8iTOP0wPYUkV+/8GPqar6n5hxfyARiLgNV/pe0sIVi1+b3l7igS4ypKf7xw3jIsBArIFbvSL+Y3/L7Ye2/cdhC0OiiQCi+b5Dd5RYhwZXuvzkWdOcp4GLKMEM7uYUXCag3BhzHUCsln+g5ObPsXBywt+2e078=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeyQ2w4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA3EC4CEF1;
	Fri, 24 Oct 2025 15:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761320933;
	bh=e4EnLs+KI0UqXaB1trgD5GCu2ZyhkG5qzX3ngK0Lo1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eeyQ2w4G22fgbXxoT8z/fDtch/MDr4P8J+jS/S4kZVvSq07vPD2g07HC6/gwjt3b9
	 eKRbhTkgvc1CjUwEpcktXpKF7pdlISGVeU0VwVQTYiLNsJkzrTQXQnMsNzE+pitPRb
	 W9JWWIMd7VUHMM9klzJrBLZYo4w0udKVIjsw7lwdIdun+nLbG5p5vV9JRfGjNsUXgx
	 Tmuxh6syssT//GBzbaLZISmKSVYXxDnyh6b9n+69CGoavIhi+EiQ+qoNcQu4OvN1UK
	 a9HvHHoFkVgj8jLPcZcg3SeufvzmG1xld1zU8VpS2gJRQ8GRpAWrlt+J153+yf6Zqq
	 xtg6jP2zs76lw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  akpm@linux-foundation.org,  brauner@kernel.org,  corbet@lwn.net,
  graf@amazon.com,  jgg@ziepe.ca,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-mm@kvack.org,
  masahiroy@kernel.org,  ojeda@kernel.org,  rdunlap@infradead.org,
  tj@kernel.org
Subject: Re: [PATCHv7 5/7] kho: don't unpreserve memory during abort
In-Reply-To: <CA+CK2bARUpZaymPTusZWM-kzXcUp_d1UK9nUudu3tHitpeAH5Q@mail.gmail.com>
	(Pasha Tatashin's message of "Fri, 24 Oct 2025 11:33:26 -0400")
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
	<20251022005719.3670224-6-pasha.tatashin@soleen.com>
	<mafs0a51jfar1.fsf@kernel.org> <aPnXVmD3cNmYNRF_@kernel.org>
	<CA+CK2bAvKrfuOXTa-RWtcuSR8rkPMhurwCn41NcUm44_vT63rA@mail.gmail.com>
	<mafs0wm4ke2wq.fsf@kernel.org>
	<CA+CK2bARUpZaymPTusZWM-kzXcUp_d1UK9nUudu3tHitpeAH5Q@mail.gmail.com>
Date: Fri, 24 Oct 2025 17:48:50 +0200
Message-ID: <mafs0sef8e1wd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 24 2025, Pasha Tatashin wrote:

>> If any of the kho_preserve_pages() fails, the notifier block will fail,
>> cause an abort, and eventually all memory will be unpreserved.
>
> This is a wrong behavior. Why should the memory that I preserved be
> unpreserved if there is finailziation failure or abort? reserve_mem
> should still keep memory as preserved in case KHO later will be
> finalized right? I have tested that this patch works with kho
> self-test: preserve, finalize, abort, finalize again, and the pages
> are properly preserved.
>
> KHO Test and memblock do not need to ever unpreserve pages, as they
> preserve them once during boot.

Agreed. The behaviour of reserve_mem and test_kho should be fixed, patch
3 just exposes the problem.

So, for this patch

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

>
>> Now that there is no notifier, and thus no abort, the pages must be
>> unpreserved explicitly before returning.
>>
>> Similarly, for test_kho, kho_test_notifier() calls kho_preserve_folio()
>> and expects the abort to clean things up.
>>
>> Side note: test_kho also preserves folios from kho_test_save_data() and
>> doesn't clean them up on error, but that is a separate problem that this
>> series doesn't have to solve.
>>
>> I think patch 3/7 is the one that actually causes this problem since it
>
> I updated that patch with your suggested fix.

Thanks!

-- 
Regards,
Pratyush Yadav

