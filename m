Return-Path: <linux-kselftest+bounces-16797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1C896620C
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 14:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A191C22681
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 12:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B215919ABDE;
	Fri, 30 Aug 2024 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgz2qLS2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A59179652;
	Fri, 30 Aug 2024 12:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022373; cv=none; b=KlGB5wQ4p1i71PthqWgmHifIRHoPGOoOK1aocVuMqYZiodvTX2yg3n4M23O3nGDo4CDWUgeISpeBC0tU7ahwy0T+QfUJOfXXWpxJFw/l1Grgb23Djs35q1s06aiCmpZwz9pYhVOWWlcLibYY1LNsw+pKxAMFwmBtYPOqdI67oNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022373; c=relaxed/simple;
	bh=arnodLySQ2biQkWEI7752R6tKFP1HasII4QgKAhxAcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQqC4jrjGGQtcNLro8I138frQcsOyp9aknpSNSRXFo9cFAvnBuqhFFbpR3hzHCn0QNYPC05ZuDu21FnlgYF9qxp87r5a3luYmw9fGa7PM11isaz1G3aHYsUss972SsdlvjS8dORgKliCyTk+m9h87Lfuw48KfaRvQuRRuqtE/jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgz2qLS2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42bb8cf8a5bso11676685e9.2;
        Fri, 30 Aug 2024 05:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725022370; x=1725627170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B/570cclLdWZD3k/8NAqWM1ozjFwAOjURdHiI/FEaSk=;
        b=lgz2qLS2VioFVRrLhF0B2W7AOVrjRu2dMJbb1NLxnItYV2PYlKGNcAmbsUGdzj1UC2
         6sXEXc3cKsC2RseFQ2mWYUYwLRQCDt7iDroD/l7f+lmBI6OETZmdU8hB0FdqNEDI7Pez
         VCozYkM/kOmnRZa8bn6evGlX1B5YGXuqgNohnjsn9/jwgDVMkK6Ysdji9a3ixlkl1Cf/
         uSBNDmi594DhE1HBG/PoVkNwbp/CGUGSpyj/b1Hi+rmHTyC7jNFEkmjgWPj7AM+HMcPd
         D96yE4RNI+WSsjgBW3SExKw1gNmzyYvW3GN1wO1l7DrVhdi7ze+DVCxXXGuqCwJ7Jf4n
         iVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725022370; x=1725627170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/570cclLdWZD3k/8NAqWM1ozjFwAOjURdHiI/FEaSk=;
        b=V6H4pl7AvcpMAk6oXzGH5NkqC1hfP5HhXJWLk38E9tZFsZ2Jy44nTebEdTO5NapxUq
         5saE8LvCuT2WsL9furuusa4LnxAXyItScqiAfFOyyAIlKaU4UPeQD2uJlGYk7DB+u4aB
         b+500z99OkFQa9iVsBYikCqXouHB36WRWqc7Y7XER8MVvIxlhoIZ89ctHrUNIXF+m7GE
         ZYYFoMhDEJvv7BoDQHBvM7WBWZhKy8qGnbykhD8NA8vtcuWMtp67RfZKen0qIiycLBGk
         6YGtQTpM8SIh2eGIUXlb25giniiAGyoArYbvDVL6y9X8SNKDSPvIJePGQXRGtFDXxn3g
         MduQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfGQgOAmJh63eViU2hdYy6Tu0Di0c0RQ50EBpZaaxNVXfR2QFkJaI2qwbHFnOo2UOobY+HATPZijBYGPc6@vger.kernel.org, AJvYcCW06geAkufUf364xLHSE0+121PjasCzwxrdNXLtT5y9CoVbYbBZPmeRGBRE5kQtt/Gk9PbmTyaL2bQD5SKf0tE=@vger.kernel.org, AJvYcCWeGCXVEbAyAyG1tcA8arkX5qOWiR6Nwj/svQuW24XXdrvPXqOtrSYuu7ZRWcRvPDCEWxzzb3nZi2Z5gRFSN9f0@vger.kernel.org
X-Gm-Message-State: AOJu0Yym6EyvnPVOshOcEPJyZdw4W2jl6fgBbwBQWNUtrA5RatzMVBwP
	tHC//hvoHFGBSPUF/38AQpnR0QwLtDU/Z5Jd/Wi/DRkTtJ1nYjAM
X-Google-Smtp-Source: AGHT+IEvj0O5jYf+isd21q/xr6784Ev1IwUiwpxzlwD7cJKfBGrepY5KrM3e7ldnpMLsNkHBHXaNyw==
X-Received: by 2002:a05:600c:1914:b0:426:5269:9838 with SMTP id 5b1f17b1804b1-42bb0242552mr50403875e9.4.1725022369524;
        Fri, 30 Aug 2024 05:52:49 -0700 (PDT)
Received: from PC-PEDRO-ARCH ([2001:8a0:7862:ea00:1d36:5f53:3f57:14ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e33d60sm45802415e9.43.2024.08.30.05.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 05:52:49 -0700 (PDT)
Date: Fri, 30 Aug 2024 13:52:46 +0100
From: Pedro Falcato <pedro.falcato@gmail.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	willy@infradead.org, lorenzo.stoakes@oracle.com, broonie@kernel.org, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, rientjes@google.com, keescook@chromium.org
Subject: Re: [PATCH v2 2/4] selftests/mm: mseal_test add sealed madvise type
Message-ID: <ggnces6muodr4q27yuprhyhjovn7vlaj4pdnmte44kg2of62sx@ihwlrb52hsmm>
References: <20240829214352.963001-1-jeffxu@chromium.org>
 <20240829214352.963001-3-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829214352.963001-3-jeffxu@chromium.org>

On Thu, Aug 29, 2024 at 09:43:50PM GMT, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Add a testcase to cover all sealed madvise type.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  tools/testing/selftests/mm/mseal_test.c | 108 +++++++++++++++++++++++-
>  1 file changed, 107 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
> index adc646cf576c..ae06c354220d 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -2121,6 +2121,107 @@ static void test_seal_madvise_nodiscard(bool seal)
>  	REPORT_TEST_PASS();
>  }
>  
> +static void test_seal_discard_madvise_advice(void)
> +{
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +	int sealed_advice[] = {MADV_FREE, MADV_DONTNEED,
> +		MADV_DONTNEED_LOCKED, MADV_REMOVE,
> +		MADV_DONTFORK, MADV_WIPEONFORK};
> +	int size_sealed_advice = sizeof(sealed_advice) / sizeof(int);
> +
> +	setup_single_address(size, &ptr);
> +	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> +
> +	ret = seal_single_address(ptr, size);
> +	FAIL_TEST_IF_FALSE(!ret);
> +
> +	for (int i = 0; i < size_sealed_advice; i++) {
> +		ret = sys_madvise(ptr, size, sealed_advice[i]);
> +		FAIL_TEST_IF_FALSE(ret < 0);
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +	}
> +
> +	REPORT_TEST_PASS();
> +}

This can replace some of the other 9 discard tests already there, no?

> +
> +static void test_munmap_free_multiple_ranges(bool seal)
> +{
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 8 * page_size;
> +	int ret;
> +	int prot;
> +
> +	setup_single_address(size, &ptr);
> +	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> +
> +	/* unmap one page from beginning. */
> +	ret = sys_munmap(ptr, page_size);
> +	FAIL_TEST_IF_FALSE(!ret);
> +
> +	/* unmap one page from middle. */
> +	ret = sys_munmap(ptr + 4 * page_size, page_size);
> +	FAIL_TEST_IF_FALSE(!ret);
> +
> +	size = get_vma_size(ptr + page_size, &prot);
> +	FAIL_TEST_IF_FALSE(size == 3 * page_size);
> +	FAIL_TEST_IF_FALSE(prot == 4);
> +
> +	size = get_vma_size(ptr +  5 * page_size, &prot);
> +	FAIL_TEST_IF_FALSE(size == 3 * page_size);
> +	FAIL_TEST_IF_FALSE(prot == 4);
> +
> +
> +	/* seal the last page */
> +	if (seal) {
> +		ret = sys_mseal(ptr + 7 * page_size, page_size);
> +		FAIL_TEST_IF_FALSE(!ret);
> +
> +		size = get_vma_size(ptr +  1 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 3 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 4);
> +
> +		size = get_vma_size(ptr +  5 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 2 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 4);
> +
> +		size = get_vma_size(ptr +  7 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 1 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 4);
> +	}
> +
> +	/* munmap all 8  pages from beginning */
> +	ret = sys_munmap(ptr, 8 * page_size);
> +	if (seal) {
> +		FAIL_TEST_IF_FALSE(ret);
> +
> +		/* verify mapping are not changed */
> +		size = get_vma_size(ptr + 1 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 3 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 4);
> +
> +		size = get_vma_size(ptr +  5 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 2 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 4);
> +
> +		size = get_vma_size(ptr +  7 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 1 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 4);
> +	} else {
> +		FAIL_TEST_IF_FALSE(!ret);
> +
> +		for (int i = 0; i < 8; i++) {
> +			size = get_vma_size(ptr, &prot);
> +			FAIL_TEST_IF_FALSE(size == 0);
> +		}
> +	}
> +
> +	REPORT_TEST_PASS();
> +}

Unrelated munmap change.

-- 
Pedro

