Return-Path: <linux-kselftest+bounces-28024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB04A4BCD7
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 11:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38DD016F359
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 10:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EDA1F0E44;
	Mon,  3 Mar 2025 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jwPRPmxx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3E61D7E4C
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998939; cv=none; b=qUQ6KNd/nGzkoX7AL+jXJMqz+pqBWT6kCHr1hjmhBT2RhwBCUbPffdzRbOHF2t5zFQFzSkwxO3ezTP823j53gjXdLTyfCfSeIJEItpDA6oCHM/c8q8DpZEzPvhtpDjrzmquSEHgPAucqwPZIMXSl8ULmanTQujIU4bAyXX5UkBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998939; c=relaxed/simple;
	bh=K14HMsxkEGr+s2VxJ3l11dPaq+7OvburkPgTNLMuo0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgVCtyG1Y+QJakFuNWIknsTUa67CfGWWbRlRKVFoEmherEHXGIYt0fNK5+/xSVajseR8+RXbRWaf1Z+A5qNrB8Jo0Thqo91Sw6H44fM5hcn5VJyQeLwUmEBPwxtf2OvwBlDM39r+QxM2fniRQZ42NcpPyblJwefTq+5WbUysq40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jwPRPmxx; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-438d9c391fcso80805e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 02:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740998936; x=1741603736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K+Ima0DPstNEgvXjJlluQ15dydqJt2/LyuMAnXcoK4Q=;
        b=jwPRPmxxa/kP6HhMneKmqIsw55u2VXh6GXEEKmemqyZxmnEIhnCvDSykKZ7eolcOzQ
         BON05rMyww8exL6F3TiF+kKRYWxaakNXLTPfRMlhZAfJ9C3N9W5TvoDDvW3yrTmcH4mc
         e0XH/O1rya3j1DzOVvu/ul0C8iRaIZfFNglGLtxq8iAhBSoiNCM5t/8jX+LEbTyZg8v/
         rIat1wA/A5xvtPJa7//XlVGzY0i/zHBLhUupu/XwOhaXCqVXyAkBABZQceoCG2vnldFP
         KYXAXioJH7RYE4zLc6fvK7nyynTl7E793THycya28W7Oho9W/7zDCxY3LHYxbp2aWV/0
         XlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740998936; x=1741603736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+Ima0DPstNEgvXjJlluQ15dydqJt2/LyuMAnXcoK4Q=;
        b=IyAX4B2fg1TrMY8YDCdPabaAg+Qv+RqfDdPDgXu5kqMCTFE71jj6wxzOYQx4wIsdyP
         eeWo6hz4MYG7VqBYF/JqHJkidWGKmNsJgMPl5k1IqGWTLRO/2lAPHuadWmglxQKSteKM
         1tOzs4S4nTbhWLDRnxWmHdWpbR2QrSEmyOGkaFdAx219tcIEe3ndc2ZMPiqYw96gzX+q
         968lCJGEGnD2wHbBGKk9m7v7g/69NzNWJc6RFMH2h4ku0Vti/rkQhhX3kHKG753IXl5g
         VoX8AkHsxLBb6ENmtyBqdZKO9C2RX/1KIlyiD6NoRcyvmNdtUMJTQkCL5qQB1OC4EXQm
         HPyg==
X-Forwarded-Encrypted: i=1; AJvYcCURneTfmF27Ytp7FDOiN+N3tXAXTDccOn1LYeBUosS4MQPGD0F3LoESHeB5C447Yhr9r5uQ/8VlKlmpaHJV3eI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPn+yBX9oPFkbaJfy1oxnjUhHt2Bc5k1/Q2lkEjqGgIjn9zQkQ
	W6D2TosZ5kIRs0Yxh6+AAoGhIkemw4axfCg+9uFlP09cmFpyZQNFvHP7KKLpoA==
X-Gm-Gg: ASbGnctPMl1cpTSQXCDMYKkqqQ9RxkFEpslbq/gMw5wuJ5fcEQnz6LDs98/h2+sFD6X
	Bj2GEqAfMcHb1/WEzvJtTSrDk6ZDKfNDF4fFrYPCILhg4GtuHsd1p4DFzxPlZldlJQZFlUQJVhr
	pSaH9kM+2mM7lCFGY3iTky+9ELtpHUxcHI2HkA/T0SrLt/C0nntV651cZKGPAaIds7gcPs9bgBW
	5qJcW+FjKGT4Kb/2CTAMKZBdxTjB9Xhw365vghgk+dn2BRxrk4YoGZIQD5kxriKpQv0bEsE8rFR
	NfQ1CAAIvWRgbofFjPAgLQKkj2LTFp1iLh4wfWnALtk8cP54ThEk+hCkUmXivB4X937wnvjJsOn
	Xu2Lq
X-Google-Smtp-Source: AGHT+IHd8ZHKAZRkwCUv3CySl6Z5lqyKm8ohs6rgo4oSk5bfdq+8pAFaHNZHO3YC+e9UOzwjLKFEUA==
X-Received: by 2002:a05:600c:3c90:b0:439:9434:1b66 with SMTP id 5b1f17b1804b1-43baff09304mr2313315e9.1.1740998935672;
        Mon, 03 Mar 2025 02:48:55 -0800 (PST)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b694524c6sm160673665e9.0.2025.03.03.02.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 02:48:54 -0800 (PST)
Date: Mon, 3 Mar 2025 10:48:50 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/10] selftests/mm: Skip uffd-wp-mremap if
 userfaultfd not available
Message-ID: <Z8WJEsEAwUPeMkqy@google.com>
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-3-958e3b6f0203@google.com>
 <99739a23-9843-4c96-a614-ce2d48431a5c@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99739a23-9843-4c96-a614-ce2d48431a5c@arm.com>

On Fri, Feb 28, 2025 at 10:55:00PM +0530, Dev Jain wrote:
> 
> 
> On 28/02/25 10:24 pm, Brendan Jackman wrote:
> > It's obvious that this should fail in that case, but still, save the
> > reader the effort of figuring out that they've run into this by just
> > SKIPping
> > 
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > ---
> >   tools/testing/selftests/mm/uffd-wp-mremap.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/mm/uffd-wp-mremap.c b/tools/testing/selftests/mm/uffd-wp-mremap.c
> > index 2c4f984bd73caa17e12b9f4a5bb71e7fdf5d8554..c2ba7d46c7b4581a3c32a6b6acd148e3e89c2172 100644
> > --- a/tools/testing/selftests/mm/uffd-wp-mremap.c
> > +++ b/tools/testing/selftests/mm/uffd-wp-mremap.c
> > @@ -182,7 +182,10 @@ static void test_one_folio(size_t size, bool private, bool swapout, bool hugetlb
> >   	/* Register range for uffd-wp. */
> >   	if (userfaultfd_open(&features)) {
> > -		ksft_test_result_fail("userfaultfd_open() failed\n");
> > +		if (errno == ENOENT)
> > +			ksft_test_result_skip("userfaultfd not available\n");
> > +		else
> > +			ksft_test_result_fail("userfaultfd_open() failed\n");
> >   		goto out;
> >   	}
> >   	if (uffd_register(uffd, mem, size, false, true, false)) {
> > 
> 
> I think you are correct, just want to confirm whether "uffd not available"
> if and only if "errno == ENOENT" is true. That is,
> is it possible that errno can be something else and uffd is still not
> available, 

Yeah, I strongly suspect this can happen. This is an attempt to
improve things but I don't think it's a full solution.

I've been pondering this a bit and I think it's impractical to solve
problems like this in the code of individual testst. I think the right
thing to do is either:

1. Have a centralised facility for detecting conditions like
   "userfaultfd not available" that tests can just query it, so they
   say something like:

   ksft_test_requires("userfaultfd");

   Which would do some sort of actual principled check for presence
   and then skip the test with an informative message when it's not
   there. There would be a list of these "system requirements" in the
   code so you can easily see in one place what things might be needed
   to successfully run all the tests.

or

2. Specify out of band that there's a fixed set of requirements for
   running the tests and document that you shouldn't run them without
   satisfying them. Then just don't bother with SKIPs and call it user
   error.

   This would require some reasonably usable tooling for actually
   getting a system that satisfies the requirements.

But both of them require a deeper investment. I would quite like to
explore option 1 a bit but that's for a future Brendan. 

In the meantime I'm just trying to get these tests running on
virtme-ng. (I'm not even gonna add all of them, because e.g. once I
noticed this one I added a `scripts/config -e USERFAULTFD` to my
script, so I won't notice if anything else is missing the check).

> or errno can be ENOENT even if uffd is available.

I think it's probably posible for this to happen too, e.g. if the
system has a perverted /dev or something. But again I think that can
only be solved with the kinda stuff I mentioned above.

Sorry for the essay :D

