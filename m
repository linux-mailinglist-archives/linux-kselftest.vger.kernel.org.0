Return-Path: <linux-kselftest+bounces-29386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CCBA67F23
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 22:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30DD172C1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 21:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C981F8753;
	Tue, 18 Mar 2025 21:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YlmAwYDf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B981D61A4
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 21:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742334793; cv=none; b=RvD2YpeCXjbrDMyso6hfE4DjNvIqv5f2I4TClmIOzSsUXsTt+9At3cx21JbE930AE8qVnG+fLErd5JNjJh4Kd/WY0DJlEsw/vvh8IIx+1wwXL0HOEcDaWLzV7k76k+jNFOk9BoHpMuf+I7wt5woMK3PAbkhaYMpxn0MARq+m8q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742334793; c=relaxed/simple;
	bh=4KgbNRWZ7T15JgjYcuA5gDJYZQgNEHYi+2VqoovCPms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GP44s+41XHlQs8LxfI4UPbfDeHQxxtOasyPdr2bw6lfmMZqq7S+hvU56Xg5+ble5qQakR3pCcth2IrqP57Yn4yFhKIDtosWkzLlIdpWKi96gXLuu5Gq5y765uxJHZ6X1C72rubMVl0av7Wl3B32UWPnMb8SUsrwJk9koKF1geP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YlmAwYDf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742334789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P8s99RB2PpTDqfRG24VVcz21yHqoAi9hghS96iW/bhA=;
	b=YlmAwYDfhYkGZyj2Ii2cqHr5NVtPsLoqBN8WmuVIe4f+BZeIeIgfya/QieRzG81A9E29wc
	SYpyJfpt26OGIzbcG0cXIvCaaUP0yQIZBQeHFpauJTRKcbGd1uAlE7yK7bgJE9gqPbuFzs
	YEy2eLbvL0+JCiBHb2d2dQPoCxzjxD0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-yWCGqXYKOeu6TuOhg77DEw-1; Tue, 18 Mar 2025 17:52:08 -0400
X-MC-Unique: yWCGqXYKOeu6TuOhg77DEw-1
X-Mimecast-MFC-AGG-ID: yWCGqXYKOeu6TuOhg77DEw_1742334728
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c3c5e92d41so1080594185a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 14:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742334728; x=1742939528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8s99RB2PpTDqfRG24VVcz21yHqoAi9hghS96iW/bhA=;
        b=uBpwS68jiyUvSH1Di55fxNBXnv0nyLetZktq6EXyO8teF5jdGd7h8qJDgbyZsnPSPD
         lSXyXR8oRXJ7EMManW/dbteomB6CQeGAA2gfX2P21SaCcX1hVTrDP40wtpMRGb2a2X/g
         lvGPz9JmM5Efnn65qz/IjmO89tgRIwvX4bZsKgKkJQ0Dmj+NYY/X+04kXD372JQkvTIS
         BOIn/vrCLbKdkvGdUoTpmBGOjFQCfYRMrovdBdLK9NwvBKwmhTFHEUh9BWGOa6rWVAHL
         M0PQH/FnLmHMzP7w0KmPq26ScHyVV+TU8aPGfGzsArvmETsDQ60nQ05MzNCqmsRzwVcv
         tg3A==
X-Forwarded-Encrypted: i=1; AJvYcCWo2BR2b0590GgVYLkt1D5FE+QY7E1gkwi5mkrg12tAtCA/PVCdBtvHIGfCC0nS1odtoFrm+eFS+An/Ung4E/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFm8Kc5Jo/01HwGvVVJHjLeqe5M6JjT1ABygtevBYa6MdxfkpF
	qxJAweeR8wDL5tiH9UK+uZYkLf+eNsVhjGIPzPUhLGXP8L1Q14/EB1GKKHOQJrkup6VtmeA+fZZ
	lkkp4OuZoXm9x5rGUDR8ZOz7aqgEgnbhOXU/uV06afB3QWtwa45pK51kgRG7rxb4nvg==
X-Gm-Gg: ASbGncv5jDBhqcIL1Xsy5sfkbPd1sXe7MGOr3+lFkXM9XerhbQ+rPw3gloIfFYDziHV
	2X7CPXKYv/8lNTjTu0Rjyjuy+ERsfCrge1VV5/JKxjyaDdiONR4VVpcwlXVqR/dW+grIFiCd5/P
	pKc6sCX0pyIkv8/f1NMlzZh0FxErRFv+/wltQzJYRIIj2zs8b5FOVHEr/qNDnadgoXM7DG19E1E
	ZH5EJBKXXLlPtJnFRHoT+Yh9hXEWzIyxmXg5T6EJ1B/rJGMkWDezBGoFdIyUs1xoXbkxYSce/Q7
	yFSC0h3hguHbfgett4lC3VOcWUjlq60iC4pjplGor2rqYSAA1lwqA6rCow==
X-Received: by 2002:a05:622a:1f8c:b0:476:8f41:7b93 with SMTP id d75a77b69052e-477082dba8emr9165971cf.12.1742334727870;
        Tue, 18 Mar 2025 14:52:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9iadiDCeFSnKYTy5zZu49JXvC/XH7qcUqaifbR4vUmmBSoPoKlm8Jka1F6LmghgXAgSL6nQ==
X-Received: by 2002:a05:622a:1f8c:b0:476:8f41:7b93 with SMTP id d75a77b69052e-477082dba8emr9165661cf.12.1742334727552;
        Tue, 18 Mar 2025 14:52:07 -0700 (PDT)
Received: from athena.aquini.home (c-76-23-219-111.hsd1.me.comcast.net. [76.23.219.111])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb82c170sm71481971cf.77.2025.03.18.14.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 14:52:07 -0700 (PDT)
Date: Tue, 18 Mar 2025 17:52:05 -0400
From: Rafael Aquini <raquini@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 2/3] selftests/mm: uffd-unit-tests support for
 hugepages > 2M
Message-ID: <Z9nrBYowE8iqwT5o@athena.aquini.home>
References: <20250318174343.243631-1-ryan.roberts@arm.com>
 <20250318174343.243631-2-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318174343.243631-2-ryan.roberts@arm.com>

On Tue, Mar 18, 2025 at 05:43:40PM +0000, Ryan Roberts wrote:
> uffd-unit-tests uses a memory area with a fixed 32M size. Then it
> calculates the number of pages by dividing by page_size, which itself is
> either the base page size or the PMD huge page size depending on the
> test config. For the latter, we end up with nr_pages=1 for arm64 16K
> base pages, and nr_pages=0 for 64K base pages. This doesn't end well.
> 
> So let's make the 32M size a floor and also ensure that we have at least
> 2 pages given the PMD size. With this change, the tests pass on arm64
> 64K base page size configuration.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  tools/testing/selftests/mm/uffd-unit-tests.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
> index 74c8bc02b506..6973e57b227a 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> @@ -26,6 +26,8 @@
>  #define ALIGN_UP(x, align_to) \
>  	((__typeof__(x))((((unsigned long)(x)) + ((align_to)-1)) & ~((align_to)-1)))
>  
> +#define MAX(a, b) (((a) > (b)) ? (a) : (b))
> +
>  struct mem_type {
>  	const char *name;
>  	unsigned int mem_flag;
> @@ -196,7 +198,8 @@ uffd_setup_environment(uffd_test_args_t *args, uffd_test_case_t *test,
>  	else
>  		page_size = psize();
>  
> -	nr_pages = UFFD_TEST_MEM_SIZE / page_size;
> +	/* Ensure we have at least 2 pages */
> +	nr_pages = MAX(UFFD_TEST_MEM_SIZE, page_size * 2) / page_size;
>  	/* TODO: remove this global var.. it's so ugly */
>  	nr_cpus = 1;
>  
> -- 
> 2.43.0
> 
 
Acked-by: Rafael Aquini <raquini@redhat.com>


