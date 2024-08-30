Return-Path: <linux-kselftest+bounces-16798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D74C96621F
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 14:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F3E1C2320D
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 12:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B50B19ABAA;
	Fri, 30 Aug 2024 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXWewsPe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA25192D79;
	Fri, 30 Aug 2024 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022634; cv=none; b=sFQ2SF6vQ8oBUmuSZwau4Ioivt+jQ9uEYEaKFBx2LS2udh1uX+TPZ//jAZniXCYDkfRCtNx8z7AZ0ew08NCHL42q+9vcnUScFu1l17L2nTZzptrrj/jZgOgQkOKREhSZUrJnu/EjjgZfrOABXPGBCYlOvWIRWs1YK9k/GZS/8zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022634; c=relaxed/simple;
	bh=636WsPg3WRlImUP1Ow5Z9og0PiDOi2SHgti5uiQze1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRqpdJxKG+XucR7mfJk6pmnadoU3YaW4XTSVvCAywp9mTyTle99ryOJ22OM4ogq3TYT2lModIVML2Y8doLwNTlEPwbw6TxdicyRr4yBTugNHyY401WlP2RmpdiGS1baLIbsM5oiWg+RJyavMrHoJDrUrj5vIibrgfqZM7BypLxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXWewsPe; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-371936541caso1136453f8f.0;
        Fri, 30 Aug 2024 05:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725022631; x=1725627431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vCgr74y9AiLo/scYXhaI4I/tHTGFD5TGQGVR/RJySd0=;
        b=EXWewsPesKmH/GoGYMnJ4+IEFuNtXLanfe74hq8w9fXp9myH5dsQcrFhlZyrRYtLNp
         DKnG+ZGH54DMl2AVWn7r2/oXtreP1Efo0AVp3eY5cPzRfGcNqJGmYyu89Uhy+R1jgDQF
         sgbPKHsZZ2fU//VkfNCxNCgXhBAGDtCMrw0QInlNKbeMgCndO2HfExLKYQNrzUkhi0p2
         bjThjHDp0ONS7lAvEmmagVEFxUZLjWZw2b743rA3/23Z30gCQVquPS6Ux+tGi80Ozyok
         2dn3uKss0/ys3FWU9GnWfuV3d028thLnE9CjKQjyb9gB6FDSXEZq1lx2idb6/XUWOISP
         xZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725022631; x=1725627431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCgr74y9AiLo/scYXhaI4I/tHTGFD5TGQGVR/RJySd0=;
        b=E5uXMjqOKNhmLHKyPMZEM5cnPqwH4b6srAXAk6JhGq072Wgg5ewzb+PIo3Purk4/52
         dbizZ0cqKKrffOCfuIMl1qrtjwPM1/tgQNFGEMTnQOr7i9yb3+WKbEhEeWUrlsXkIphd
         Fjb2U1feiksMY1OLxJlSmbcvOv18zSEb0e4ACueYb7Th7SdpmDOpl24MF+VIv19S8r6a
         zwxHaPZC7ESKTXM4zewv5fkWrMwrAJHz7Jg01LCsl34dprqQkb8sTXYjvzqLDcsK+PjD
         PYmuBP8DV4RLmEK3ShQbZp8O6R9WOi0W5UQWUVpoXglPxAcMBJNU4Wu2htnMPVh0PBvb
         M2lA==
X-Forwarded-Encrypted: i=1; AJvYcCUR3d/FZKJ0HK6rvadN1/u62JTgvE6tKKE4wve9iL8GuH6twMFSSnnwY/8g1OrAc+HGe/nCES8Uaw6WH45FExUI@vger.kernel.org, AJvYcCUgO3QHhvoA7l2GSFtNv1KkRSvnJgZQTuZvOo+EojL3l/gaApUKFqQmagE4W8alMtd2vg+Koq3ku5YnTxgwqLk=@vger.kernel.org, AJvYcCVdJohbsG5CXr53iIArrEs9p0dC2dNRPl3GlGK2CF6fhbsPD8CmmH0+BIwaA460O1lTCwylcqkhx+I075E9@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj6JIiWLj+KNQptQfaNZ/i2VBE9HgGrh49k5y3JTCmyRjC1LZW
	F1gI8VkIpVpcITlMX5eTul30rGvK3PwbJven1WVjoB8VnfvMLB9N
X-Google-Smtp-Source: AGHT+IELuymsP2ONyWahLAwU24MxpYIrM9umnYMsspvUe2V+UJHjPjR3wpX8ecF314kw6+RiM8FfYw==
X-Received: by 2002:a5d:59a2:0:b0:369:b7e3:497c with SMTP id ffacd0b85a97d-3749b5320fbmr5447995f8f.1.1725022630153;
        Fri, 30 Aug 2024 05:57:10 -0700 (PDT)
Received: from PC-PEDRO-ARCH ([2001:8a0:7862:ea00:1d36:5f53:3f57:14ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee4c83fsm3977953f8f.22.2024.08.30.05.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 05:57:09 -0700 (PDT)
Date: Fri, 30 Aug 2024 13:57:06 +0100
From: Pedro Falcato <pedro.falcato@gmail.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	willy@infradead.org, lorenzo.stoakes@oracle.com, broonie@kernel.org, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, rientjes@google.com, keescook@chromium.org
Subject: Re: [PATCH v2 3/4] selftests/mm: mseal_test add more tests for mmap
Message-ID: <q3xvzsnyltr2gdgnecgw74umi2yrjvimkxo7bvgnqb4darakzw@jahjkavgcyfm>
References: <20240829214352.963001-1-jeffxu@chromium.org>
 <20240829214352.963001-4-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829214352.963001-4-jeffxu@chromium.org>

On Thu, Aug 29, 2024 at 09:43:51PM GMT, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Add sealing test to cover mmap for
> Expand/shrink across vmas.
> Reuse the same address in !MAP_FIXED case.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  tools/testing/selftests/mm/mseal_test.c | 125 +++++++++++++++++++++++-
>  1 file changed, 124 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
> index ae06c354220d..d83538039e76 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -2222,6 +2222,122 @@ static void test_munmap_free_multiple_ranges(bool seal)
>  	REPORT_TEST_PASS();
>  }
>  
> +static void test_seal_mmap_expand_seal_middle(bool seal)
> +{
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 12 * page_size;
> +	int ret;
> +	void *ret2;
> +	int prot;
> +
> +	setup_single_address(size, &ptr);
> +	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> +	/* ummap last 4 pages. */
> +	ret = sys_munmap(ptr + 8 * page_size, 4 * page_size);
> +	FAIL_TEST_IF_FALSE(!ret);
> +
> +	size = get_vma_size(ptr, &prot);
> +	FAIL_TEST_IF_FALSE(size == 8 * page_size);
> +	FAIL_TEST_IF_FALSE(prot == 0x4);
> +
> +	if (seal) {
> +		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
> +		FAIL_TEST_IF_FALSE(!ret);
> +	}
> +
> +	/* use mmap to expand. */
> +	ret2 = mmap(ptr, 12 * page_size, PROT_READ,
> +			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);

This is not expansion, but overwriting. Expansion is allowed through an adjacent mmap + mseal (which will merge the two VMAs).

> +	if (seal) {
> +		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +
> +		size = get_vma_size(ptr + 4 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +	} else
> +		FAIL_TEST_IF_FALSE(ret2 == ptr);
> +
> +	REPORT_TEST_PASS();
> +}
> +
> +static void test_seal_mmap_shrink_seal_middle(bool seal)
> +{
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 12 * page_size;
> +	int ret;
> +	void *ret2;
> +	int prot;
> +
> +	setup_single_address(size, &ptr);
> +	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> +
> +	if (seal) {
> +		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
> +		FAIL_TEST_IF_FALSE(!ret);
> +	}
> +
> +	/* use mmap to shrink. */
> +	ret2 = mmap(ptr, 7 * page_size, PROT_READ,
> +			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);

This is also a partial overwrite.

> +	if (seal) {
> +		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +
> +		size = get_vma_size(ptr + 4 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +
> +		size = get_vma_size(ptr + 4 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +	} else
> +		FAIL_TEST_IF_FALSE(ret2 == ptr);
> +
> +	REPORT_TEST_PASS();
> +}
> +
> +static void test_seal_mmap_reuse_addr(bool seal)
> +{
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = page_size;
> +	int ret;
> +	void *ret2;
> +	int prot;
> +
> +	setup_single_address(size, &ptr);
> +	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> +
> +	if (seal) {
> +		ret = sys_mseal(ptr, size);
> +		FAIL_TEST_IF_FALSE(!ret);
> +	}
> +
> +	/* use mmap to change protection. */
> +	ret2 = mmap(ptr, size, PROT_NONE,
> +			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +

This is also an overwrite. You're semantically testing the same thing, and testing the same regions of code.
These 3 tests are all kind of the same thing.

-- 
Pedro

