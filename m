Return-Path: <linux-kselftest+bounces-36192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E02CAAEFD1E
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 16:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6394A7B34
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 14:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236F5278170;
	Tue,  1 Jul 2025 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2A7YkNW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0C2277C8A
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Jul 2025 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751381499; cv=none; b=YPsV0MXzOILyAdlALJ0v+ytzfxbKlJ3bq0wbYwBEBdG4vJKjXikFn+HvH75bEV7v2PLzTEy1+QL5u7Ue/2nW8FN/Q8un5wGht6X930bljoYDyu2bMzpxOd3DtysGd5bqNV3EgTCTyFltpljLhUnXBwafmKUhJx01UI9eiVWgyF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751381499; c=relaxed/simple;
	bh=BWiWtdtkzhiodBbBdXIWgPS9dVhTj3P8vnMtTSxGEeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l29/MEQGEt6nhIgOUeikOVLDHscLU3R5C+ftFHzg2EY82cz9psXlznjqvwpQ+keWffdG8rwdFS3SDeSaEuNv6KV6KS1nRbl1hCkxSyJnfRpW+WKdLAU/PNficwnUtVqM6imSyZh6Rha8gmdSQBmkiPJPVPjJBYVcfRISes85Sio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F2A7YkNW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751381494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EfoMdtoDyXREIezrPUdu2a2yagVb9vBk4JaNn3pDuBo=;
	b=F2A7YkNWZ+mnZn8qyLzFCC5z+0S/XvEiXjkuCPldfk/ocpH0gGNXDx6DLfc/iGcVgZ9k9u
	LePrQOmpJM09CLGpmWmGPGRvwvi00hsFhkegHF7Pb4VLK6X9yo5G+FLjAN2M8ljfRIim90
	ft9rhiftYOxHijw4urDnbMtdWTeJyQo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-5VKIZ5CcOVaHv6AVxYu3ng-1; Tue, 01 Jul 2025 10:51:32 -0400
X-MC-Unique: 5VKIZ5CcOVaHv6AVxYu3ng-1
X-Mimecast-MFC-AGG-ID: 5VKIZ5CcOVaHv6AVxYu3ng_1751381491
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450d290d542so37010005e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jul 2025 07:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751381491; x=1751986291;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EfoMdtoDyXREIezrPUdu2a2yagVb9vBk4JaNn3pDuBo=;
        b=SncMVwO7jlk0ec3grGxv1HEekfUbTzw/n7sM/wyGy00QaWJPhMRM0BeT2WmhQIqTDm
         fE7IHXlcgyirMr0pJ2cNyObzUlRpXVpI5hZqp/A+/kKd973AbAuiNiRppDkpzunnCewV
         p9Ft+F4pId8jkwoyGlxDyQRz7CdaPR5srZ8IEH563ABl6+bs74Wr7YLlKe81omo4teCc
         NNsVlwSHYwTgBOnsMITbzmccHLGoO6t9m/BQwpK2SHsDGlr5iM3f2dg0ueZDKnbuPCn+
         D0xzfXf/43ueKUsED4Br6E9g2b7girnUJQ5ffAERctjAXV7QXcCDABT7z/5SRpJeYHJm
         dIIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV66X+vQE4nnHQHJGc9ExJ1z/WlatyGMeW7LJKT+QGZIqo0ypM3fqsk4wfhf1/uk3xJK9j2x8oMnVBsXCxTBxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsNbKa51Rp0P8TJZD7gjnsW4uCfPkHTMAdf5iIcgynP7h/0ebm
	5of6EuZZ3NM5SuAnF1os1+qweyVb1py05kkS/CG04VriSvmLW1Cb93dxZjxA3rFtwZFMcndA62b
	Oj0WSQViDhbTzFt2/aeK7Nfcqi6jcKinBLDYPf9iVftFRY+mTFIrYBOaa5X1Oe1QpiRwsERPuEl
	3pBKUf
X-Gm-Gg: ASbGncuW9yxeUaB5REbCTalG+6JMnkLHs3BFJ7Nl6TGiVobirsQXr8ivRy2eHnjWrxM
	xnho2PCdhWbukB8nmIAdHiH0zuCoDCUsTkIhMMOPIDzF+2Lm9VxBZ9jJGT5+hJ8LJmk42MCWWvH
	HbTam/aSjrxCNda4K/O/YXA7so0zKx56eNSFrxxpvi+6z3/sQs9zvwN1j+i9GMI4TBXNRx5jDxC
	Ry3blTvL9cE9VcR5OT91orcw4ebqJQS4g35kXuSXRXQRnRb6GOy+bRL63tcmiwFUFRUUhXraeav
	l/sI7+/ndwNm86vEGxmzjVEzAezXSRzGCe4cPRAEzn8X9yy2C6b4DxCgGPQ40PLn0DlQ/GT47ny
	D3t6Ck1G/wEbxLAPpOUholfS//GIi+OGvvTsBVupmuu6xU1/whA==
X-Received: by 2002:a05:600c:19d4:b0:43d:2313:7b49 with SMTP id 5b1f17b1804b1-4539517a717mr153524475e9.12.1751381490910;
        Tue, 01 Jul 2025 07:51:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMux53C2I8qV2sDcGrxw/+8VvZIK9p/Asqk8P2x7vDhoU+mdYa6aqec+kf1tu5AD1aCAThtw==
X-Received: by 2002:a05:600c:19d4:b0:43d:2313:7b49 with SMTP id 5b1f17b1804b1-4539517a717mr153524095e9.12.1751381490432;
        Tue, 01 Jul 2025 07:51:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad0fesm203561125e9.25.2025.07.01.07.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 07:51:29 -0700 (PDT)
Message-ID: <20027e0c-f43b-4d10-a4d6-41dcc38145bd@redhat.com>
Date: Tue, 1 Jul 2025 16:51:29 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: pagemap_scan ioctl: add PFN ZERO test cases
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250630102443.137809-1-usama.anjum@collabora.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250630102443.137809-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.06.25 12:24, Muhammad Usama Anjum wrote:
> Add test cases to test the correctness of PFN ZERO flag of pagemap_scan
> ioctl. Test with normal pages backed memory and huge pages backed
> memory.

Just to verify: would this trigger on kernels before my fix?

> 
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> The bug has been fixed [1].
> 
> [1] https://lore.kernel.org/all/20250617143532.2375383-1-david@redhat.com
> ---
>   tools/testing/selftests/mm/pagemap_ioctl.c | 57 +++++++++++++++++++++-
>   1 file changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
> index 57b4bba2b45f3..6138de0087edf 100644
> --- a/tools/testing/selftests/mm/pagemap_ioctl.c
> +++ b/tools/testing/selftests/mm/pagemap_ioctl.c
> @@ -1,4 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0
> +
>   #define _GNU_SOURCE
>   #include <stdio.h>
>   #include <fcntl.h>
> @@ -1480,6 +1481,57 @@ static void transact_test(int page_size)
>   			      extra_thread_faults);
>   }
>   
> +void zeropfn_tests(void)
> +{
> +	unsigned long long mem_size;
> +	struct page_region vec;
> +	int i, ret;
> +	char *mem;
> +
> +	/* Test with page backed memory */

What is "page backed memory" ? :)

> +	mem_size = 10 * page_size;
> +	mem = mmap(NULL, mem_size, PROT_READ, MAP_PRIVATE | MAP_ANON, -1, 0);
> +	if (mem == MAP_FAILED)
> +		ksft_exit_fail_msg("error nomem\n");
> +
> +	/* Touch each page to ensure it's mapped */
> +	for (i = 0; i < mem_size; i += page_size)
> +		(void)((volatile char *)mem)[i];
> +
> +	ret = pagemap_ioctl(mem, mem_size, &vec, 1, 0,
> +			    (mem_size / page_size), PAGE_IS_PFNZERO, 0, 0, PAGE_IS_PFNZERO);
> +	if (ret < 0)
> +		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
> +
> +	ksft_test_result(ret == 1 && LEN(vec) == (mem_size / page_size),
> +			 "%s all pages must have PFNZERO set\n", __func__);
> +
> +	munmap(mem, mem_size);
> +
> +	/* Test with huge page */
> +	mem_size = 10 * hpage_size;
> +	mem = memalign(hpage_size, mem_size);
> +	if (!mem)
> +		ksft_exit_fail_msg("error nomem\n");
> +
> +	ret = madvise(mem, mem_size, MADV_HUGEPAGE);
> +	if (ret)
> +		ksft_exit_fail_msg("madvise failed %d %s\n", errno, strerror(errno));

Might fail on older kernels, so we usually treat this as a skip.

> +
> +	for (i = 0; i < mem_size; i += hpage_size)
> +		(void)((volatile char *)mem)[i];
> +
> +	ret = pagemap_ioctl(mem, mem_size, &vec, 1, 0,
> +			    (mem_size / page_size), PAGE_IS_PFNZERO, 0, 0, PAGE_IS_PFNZERO);
> +	if (ret < 0)
> +		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
> +
> +	ksft_test_result(ret == 1 && LEN(vec) == (mem_size / page_size),
> +			 "%s all huge pages must have PFNZERO set\n", __func__);

Wouldn't this be able to fail if 
/sys/kernel/mm/transparent_hugepage/use_zero_page is set to false, or if 
mmap() gave us a suboptimally-aligned range?

You'd have to read each and every page to get the ordinary shared 
zeropage in these configs instead without making the test too complicated.

> +
> +	free(mem);


Shouldn't this be an munmap() ?

> +}
> +
>   int main(int __attribute__((unused)) argc, char *argv[])
>   {
>   	int shmid, buf_size, fd, i, ret;
> @@ -1494,7 +1546,7 @@ int main(int __attribute__((unused)) argc, char *argv[])
>   	if (init_uffd())
>   		ksft_exit_pass();
>   
> -	ksft_set_plan(115);
> +	ksft_set_plan(117);

We should probably look into converting this test to kselftest_harness.

-- 
Cheers,

David / dhildenb


