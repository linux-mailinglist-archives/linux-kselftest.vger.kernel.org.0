Return-Path: <linux-kselftest+bounces-32173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FFAAA7165
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2963B12B3
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C54243964;
	Fri,  2 May 2025 12:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kwsid3AY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B6E22578C
	for <linux-kselftest@vger.kernel.org>; Fri,  2 May 2025 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188182; cv=none; b=dbqhrbg7x5e2XjE9+mgsSWKzpNFIPjUobLrB9xsfNVPerkpoiHpvuR4IgnTSnwHcYew2lUTN9T60/QptSBNxrPECzVI1Ax35BcDjv5ZXA2z9vSpPpOHzmCmlHNOS5x8a0vfgA47cAhJDxwzVtu8SWL12DBvaP5NaBI3oJjgXqJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188182; c=relaxed/simple;
	bh=929IJRm8l8mqIeXBF+KLWEt6Xqyzatc/dQC7C+euxz4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OK5MuugkvxBtwOvosEj67lHqRUt6GmY4Lzx/LMMUpoU17GR9iezEiwi+1/aYXoq6EGwitVkJUALovm/meZ1nFB5qfJhi4Dy+cMThDM1ImVyWONKm7AtCDU+xrcsWPfCv+nNCqRtH80Q94/O+dgT4GGJdA+HJnQ1WpohHL+kVpd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kwsid3AY; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43efa869b0aso12500975e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 02 May 2025 05:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746188179; x=1746792979; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xpQTX7qbtTqiZ2cYzNQe4qlADufga3HtIbspyW6RXEI=;
        b=kwsid3AYr+s/mUFkbgJXY5sLUHyUQFSC91XJG2y77js7iPA/LiskadxY/DrOK7mW0Z
         0Hu3nwtuX+fgSA86loNIXDbxeR7ebxvNyxN2+tiTN8rTwJST56ESwFQS03XZSlyP7K8d
         hBxeahWCc43G1xuLq868e3wMXRLGgCMKtUD4YyURz3Ovz51hjjIuYMMxvv+kQHzW8WiB
         Jed8aDpfT/2C5+9xViJ1F4T8USX+ooAPK5EJvC/jC2Kd8FTm75pPRMRzAGKuCJsNr2Zd
         9307AZCRN7My2N8EbIi4CoFsUty986j1UJH1DQ4LZa6el27xkEwgpL3vvSu5JSPhR++S
         9bxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746188179; x=1746792979;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xpQTX7qbtTqiZ2cYzNQe4qlADufga3HtIbspyW6RXEI=;
        b=vYrILXsEW0gfXaO/261y215AZv3Qu+BM4C5UQFhl0hXdyM1C4MovFN2LFiCluU2Y8W
         nY7F3RzvpIPMtvVHJ0a+ZRad8ePjtnReYS2InBx3gmQJROXHhHADo8mzuqAR0Y7tVNwb
         +n3AuJTQQj1gRj7nwewxjYQ1Hpi/RCXIYZBGJ4h9FeWwrVxdNWhUXdTq0m4lqkppplSP
         +WQ8in+cHFOekqP7vT0nzgM/2A5BAoPnsbE4Bwc5/xz6lZKBfLx8kERqYVjMi4qXr+pg
         vH/XhwFJaeNJq54CmUKNZHwp347CGCd4MD10PnyxX4P0OCzoBQwNrgYBN635yBNhUkaK
         lb6A==
X-Forwarded-Encrypted: i=1; AJvYcCVz6cOYdGxxRNrcDvZ8demaZmbBVTOmjxT39fT9wNgEt+5Sg6Lw2shjFG6RTdk9mFHBabr6Q8vm7qjhtLqaG/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGy3F+PxP7ubabduNroXReJUnwO3Lm3jwa0kfbK37LIDqqMYRC
	FZC0GExqfayHNCKjBVO3MY4lmzunGZNXSBv83Y+e73orUi13ftfnPnb+5x/OQPYAae0oak4a5rZ
	5uWdHcDAsrw==
X-Google-Smtp-Source: AGHT+IHGPJ8d8Rj7Vp0b8xFb7q1PChNxC2PGcrvlNuQ85axCMGpx4XborD9U5msKtCnHqeVLkMXXzpsI/8IeTQ==
X-Received: from wmqe18.prod.google.com ([2002:a05:600c:4e52:b0:441:b607:4ec0])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1992:b0:43d:9f2:6274 with SMTP id 5b1f17b1804b1-441bbeb3383mr21806185e9.14.1746188179399;
 Fri, 02 May 2025 05:16:19 -0700 (PDT)
Date: Fri, 02 May 2025 12:16:17 +0000
In-Reply-To: <20250501163827.2598-2-ujwal.kundur@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250501163827.2598-1-ujwal.kundur@gmail.com> <20250501163827.2598-2-ujwal.kundur@gmail.com>
X-Mailer: aerc 0.20.0
Message-ID: <D9LO1QI65D6K.NLDZ4RK2835Y@google.com>
Subject: Re: [PATCH 1/4] selftests/mm/uffd: Refactor non-composite global vars
 into struct
From: Brendan Jackman <jackmanb@google.com>
To: Ujwal Kundur <ujwal.kundur@gmail.com>, <akpm@linux-foundation.org>, 
	<peterx@redhat.com>, <shuah@kernel.org>
Cc: <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu May 1, 2025 at 4:38 PM UTC, Ujwal Kundur wrote:
> + * count is placed in the page after pthread_mutex_t naturally aligned
> + * to avoid non alignment faults on non-x86 archs.
> + */
> +volatile unsigned long long *area_count(
> +		char *area, unsigned long nr,
> +		uffd_global_test_opts_t *gopts)
> +{
> +	return (volatile unsigned long long *)
> +			((unsigned long) (area + nr * gopts->page_size +
> +			  sizeof(pthread_mutex_t) +
> +			  sizeof(unsigned long long) - 1) &
> +			 ~(unsigned long)(sizeof(unsigned long long) -  1));

Stray space after the minus there

> -static void retry_copy_page(int ufd, struct uffdio_copy *uffdio_copy,
> +static void retry_copy_page(uffd_global_test_opts_t *gopts, struct uffdio_copy *uffdio_copy,
>  			    unsigned long offset)
>  {
> -	uffd_test_ops->alias_mapping(&uffdio_copy->dst,
> +	uffd_test_ops->alias_mapping(gopts,
> +					&uffdio_copy->dst,

Little bit of indentation mess here

I don't understand this code but since I was hurt by these global
variables I had a look over the diff anyway, it LGTM (aside from the
formatting nits), thanks.

Reviewed-by: Brendan Jackman <jackmanb@google.com>

