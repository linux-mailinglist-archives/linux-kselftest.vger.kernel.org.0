Return-Path: <linux-kselftest+bounces-32902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2794AB545D
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 14:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E696B3B8EA7
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 12:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1620128D8E5;
	Tue, 13 May 2025 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GYImWMvg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C1B20B20A
	for <linux-kselftest@vger.kernel.org>; Tue, 13 May 2025 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747138355; cv=none; b=q/AofI1RzL9j/zFGerPAblgPi2PdxL3zLQMLFPnFPEHcLOev5Z338h6MHqQleaMsk0WX+baKj/cFkh5yvz1s2uBquEiCKq/sDzucHIjHkSg3QC+TJX8eNmfY+5+48W1X2eGyXMgoimHDUpvIFhLDqFssUencDIJ5gwc6ZEHJr3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747138355; c=relaxed/simple;
	bh=HPuCt+1fD/pUI/mXntTqmuQxT8nb9RKQ6nUZLoUxe8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tEp3x5R2IJBEOnPF+F3XFIf7zgny7/V9yvD9LoQDN55AvAPkzaaGFRJb9mBoCgJSmw8waA1rjBQMCwh/zkWMLgETF6GQ1hwefMstjoKCC0nCH9ijQBP2k3r9JcUcV4d4itG4pges6x7LaiEE7VNvs3UD+XYwQZvJg7GBBHTYVtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GYImWMvg; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a2057d164bso792720f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 May 2025 05:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747138351; x=1747743151; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tqJ7N5MPCKIBPZ28ZuVfeZRrV5rqQYI+Sww0v7Ls2co=;
        b=GYImWMvgCqa7zWkPOesZWpGLBw4x+mrlUNMR/dn9+29VdSR48VV7cpczJ6LF7s+4Sk
         3IxW8Ak6/33lUaDtaFv828ZiL0qNnhTGcxxHdbTi10neJLq4FMrYI7/JSDk7PbnI0lsY
         mYWxWioNDQREC6rslbit3Mbv+v9ImcTGwxU6IZ8hhpqJwjej/ndzfcMtMPhdMRwGwFnk
         dUAtrkMhpFyrLWSEgE5BdzvjahsuJ5CFJlMpBwHJ4BbVIRPf7cao2RyP8r7Or7ioAtto
         occI4+pHRLMQLinaHyMMe11fF0bpPbTEU6y3X9j5dyevyU/bugRwfeEG90y2fVFy8akD
         QCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747138351; x=1747743151;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqJ7N5MPCKIBPZ28ZuVfeZRrV5rqQYI+Sww0v7Ls2co=;
        b=E1zqKVVK6O1NqMZj0lWQDqP5JWolsn/1fEmGOLFWq6bavzRfssN4zx/Tckuqlg2xkJ
         gHaXt5o77Gs0fzJ9Q9/f6Ccy2sFWyton/rQLW74XxTOFQMqrIjGvxHx7f62pccVAsAl8
         fpccmvbU2wfpiYNY9+CXcMdttJhsL9ew0FxtFByBmjV32q2ewHEvNKlxqrvA2zOq+pSj
         rmdBmKHnH6cYFiEkuKG7d5bhnF0V3ND0xfbAN8BpTF5aBdFp5lZlde0wjYJ0MQUXe+bK
         q9G3tg+E69ERl1Nt7IPhPdaEL7FLo+YswrglK4zcaqiIipF7/i/4R1rlgK4Kn5XoyA46
         goxg==
X-Forwarded-Encrypted: i=1; AJvYcCXzHufcw1HToY2ETktGU8/cuNt7M8exay96kCO38EG9vkic7Y+RsHpSbYBdDDP04XJ0W/pI51Y1M6nbse3hmLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuPdNgcMBV1M8G4sBir4BKV/8YNT2F3TPOuP2csZNt+ZMNUJ5W
	0YNBLKW82UFo/vRriYaqfkqoLB23IKg6b3ZVMPgDVoW3+ce5sYS6bieznGZV7U6B6MnF7nEG4eG
	mbN7y8uN2Jg==
X-Google-Smtp-Source: AGHT+IG1OsKgvOvWxbxMpIyjNij9qpe7ZgQZFFjSE4GFLCMtcMJZvIlysSCvcCV8dJuwPiyPNy+cphTfNr8caQ==
X-Received: from wmbdr13.prod.google.com ([2002:a05:600c:608d:b0:441:b607:4ec0])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:40e0:b0:3a2:3c51:7df0 with SMTP id ffacd0b85a97d-3a23c51810fmr3866676f8f.49.1747138351600;
 Tue, 13 May 2025 05:12:31 -0700 (PDT)
Date: Tue, 13 May 2025 12:12:29 +0000
In-Reply-To: <20250510160335.1898-1-ujwal.kundur@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250501163827.2598-1-ujwal.kundur@gmail.com> <20250510160335.1898-1-ujwal.kundur@gmail.com>
X-Mailer: aerc 0.20.0
Message-ID: <D9V0UTL5BCLM.1WHR6F4UN14QQ@google.com>
Subject: Re: [PATCH v3 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
From: Brendan Jackman <jackmanb@google.com>
To: Ujwal Kundur <ujwal.kundur@gmail.com>, <akpm@linux-foundation.org>, 
	<peterx@redhat.com>, <shuah@kernel.org>
Cc: <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat May 10, 2025 at 4:03 PM UTC, Ujwal Kundur wrote:
> Refactor macros and non-composite global variable definitions into a
> struct that is defined at the start of a test and is passed around
> instead of relying on global vars.
>
> Signed-off-by: Ujwal Kundur <ujwal.kundur@gmail.com>

Tested-by: Brendan Jackman <jackmanb@google.com

Using this hacked to enable the uffd tests (I disable them normally
because they're flaky):

https://github.com/bjackman/linux/blob/github-base/.github/scripts/run_local.sh

> ---
>  Changes since v2:
>  - redo patch on mm-new branch
>  Changes since v1:
>  - indentation fixes
>  - squash into single patch to assist bisections

Thanks for this.

> -static void retry_copy_page(int ufd, struct uffdio_copy *uffdio_copy,
> -			    unsigned long offset)
> +static void retry_copy_page(uffd_global_test_opts_t *gopts, struct uffdio_copy *uffdio_copy,
> +							unsigned long offset)
>  {
> -	uffd_test_ops->alias_mapping(&uffdio_copy->dst,
> -				     uffdio_copy->len,
> -				     offset);
> -	if (ioctl(ufd, UFFDIO_COPY, uffdio_copy)) {
> +	uffd_test_ops->alias_mapping(gopts,
> +								&uffdio_copy->dst,
> +								uffdio_copy->len,
> +								offset);

Looks like your editor got a bit excited here :D

There are a few other places where this happened too, e.g. the
are_count() declaration and there's a pthread_create_call() that's quite
messed up.

Unfortunately I don't know of any tool that can find/fix these issues
automatically without also messing up the whole file. Could you just
do a visual skim and fix what you can spot?

>  static void sigalrm(int sig)
>  {
>  	if (sig != SIGALRM)
>  		abort();
> -	test_uffdio_copy_eexist = true;
> +	// TODO: Set this without access to global vars
> +	// gopts->test_uffdio_copy_eexist = true;

Did you mean to leave this like that?

> @@ -1734,6 +1737,27 @@ int main(int argc, char *argv[])
>  		}
>  		for (j = 0; j < n_mems; j++) {
>  			mem_type = &mem_types[j];
> +
> +			// Initialize global test options

Wrong comment style here

> +			uffd_global_test_opts_t gopts;
> +
> +			gopts.map_shared = mem_type->shared;
> +			uffd_test_ops = mem_type->mem_ops;
> +			uffd_test_case_ops = test->test_case_ops;
> +
> +			if (mem_type->mem_flag & (MEM_HUGETLB_PRIVATE | MEM_HUGETLB))
> +				gopts.page_size = default_huge_page_size();
> +			else
> +				gopts.page_size = psize();
> +
> +			/* Ensure we have at least 2 pages */
> +			gopts.nr_pages = MAX(UFFD_TEST_MEM_SIZE, gopts.page_size * 2) / gopts.page_size;
> +			/* TODO: remove this global var.. it's so ugly */

That's done :)

> +			gopts.nr_parallel = 1;
> +
> +			/* Initialize test arguments */

(This comment seems like noise? I could be wrong, not a big deal).


Thanks for these improvements. Bit of a hasty review and I'm not really
qualified to comment on the test logic itself, but aside from that and
my nits:

Reviewed-by: Brendan Jackman <jackmanb@google.com>

