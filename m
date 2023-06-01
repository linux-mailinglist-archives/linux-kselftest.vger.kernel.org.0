Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E03E719537
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 10:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjFAIRh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 04:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjFAIRg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 04:17:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEFDC0
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Jun 2023 01:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685607406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wKmPbrFwESFZJl2H01/KcKj6DErTerOIUGeta+Cdp9Q=;
        b=XkdvHPV7VHERKN7F2igr0ACbR/e1rF9zs3rmgOw6ADwvwAWovuaO9axvKUi9EVR7fEeK2k
        Km0yCV95Sa6C4sf9SKV9FFa/fzHa0Q0o2r1vs21mFpIJ5i9EKOj9Rabl5zGEzeCzkXV9hS
        BzxL34A1RdAI0Bnbqlj9Cuq09uv1se8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-edshLySbO36WavR5zZjgFA-1; Thu, 01 Jun 2023 04:16:44 -0400
X-MC-Unique: edshLySbO36WavR5zZjgFA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2af2790f4a2so4849011fa.1
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Jun 2023 01:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685607403; x=1688199403;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKmPbrFwESFZJl2H01/KcKj6DErTerOIUGeta+Cdp9Q=;
        b=VTjFxEOuwCNxRxdiyPYMj/rD+beEY2lys5LhHMRvBHe+/RfjaHss9lZl9cmXqWjCv/
         zJBjAOe6uD+gsOo2OkDmleoEfJsSliKfhrwdaM6Y1x+E3lzsUNsgeznXYyBeEDE3cit6
         /Ykl75At5rEYqphATVrkCVVFvuJlNk3eRhoDJsQiTSZp0fh7jBTUsGZbQwebT7igaVD0
         wdWUKJOOZnE3LIR7I3/d6tDm8lXf/8+hhE1WnmjHhKJoND/TjABqcUDAShhMhQf9Iyri
         EbPlVL+Q0p/ZkyZsMmxPpts715MeG+GjX+4k35SVNZv0eQpN9oK3YUAztg8M/YfDS4zo
         Dlvg==
X-Gm-Message-State: AC+VfDxvsO2zV/aYSrJUkROhsWu+uHH4QYTNo5X6WCLACqYsQQ/CyBOc
        nGcOhA4DabbqyBzFpPJ+J9/IxsdCuaj/DH3mHLQHugx+2tZLtGfSAVIMPCCnSL7DCLeyYR57+YB
        N2kfR+pPmAx1DcoplG4aRSGbkWSDUqI+RmDll
X-Received: by 2002:ac2:4149:0:b0:4f3:7c24:1029 with SMTP id c9-20020ac24149000000b004f37c241029mr741613lfi.60.1685607403370;
        Thu, 01 Jun 2023 01:16:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7NS61bKX6pql0N3/fkWSFJqZb3sUgTR7ldIN/Kjqcc3QC+WNlSkFZRaDsvl0e+iAa0OgTh0A==
X-Received: by 2002:ac2:4149:0:b0:4f3:7c24:1029 with SMTP id c9-20020ac24149000000b004f37c241029mr741593lfi.60.1685607402876;
        Thu, 01 Jun 2023 01:16:42 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id z16-20020a7bc7d0000000b003f605814850sm1388319wmk.37.2023.06.01.01.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 01:16:42 -0700 (PDT)
Message-ID: <fa6009d4-643e-97ec-5317-a57a535e0495@redhat.com>
Date:   Thu, 1 Jun 2023 10:16:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>
References: <20230519102723.185721-1-david@redhat.com>
 <20230519102723.185721-3-david@redhat.com>
 <be2346e4-e8c0-4470-9bf4-59eb864063a8@lucifer.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 2/3] selftests/mm: gup_longterm: new functional test
 for FOLL_LONGTERM
In-Reply-To: <be2346e4-e8c0-4470-9bf4-59eb864063a8@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 28.05.23 17:03, Lorenzo Stoakes wrote:
> On Fri, May 19, 2023 at 12:27:22PM +0200, David Hildenbrand wrote:
>> Let's add a new test for checking whether GUP long-term page pinning
>> works as expected (R/O vs. R/W, MAP_PRIVATE vs. MAP_SHARED, GUP vs.
>> GUP-fast). Note that COW handling with long-term R/O pinning in private
>> mappings, and pinning of anonymous memory in general, is tested by the
>> COW selftest. This test, therefore, focuses on page pinning in
>> file mappings.
>>
>> The most interesting case is probably the "local tmpfile" case, as that
>> will likely end up on a "real" filesystem such as ext4 or xfs, not on a
>> virtual one like tmpfs or hugetlb where any long-term page pinning is
>> always expected to succeed.
>>
>> For now, only add tests that use the "/sys/kernel/debug/gup_test"
>> interface. We'll add tests based on liburing separately next.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---

[...]

>> +static void do_test(int fd, size_t size, enum test_type type, bool shared)
>> +{
>> +	__fsword_t fs_type = get_fs_type(fd);
>> +	bool should_work;
>> +	char *mem;
>> +	int ret;
>> +
>> +	if (ftruncate(fd, size)) {
>> +		ksft_test_result_fail("ftruncate() failed\n");
>> +		return;
>> +	}
>> +
>> +	if (fallocate(fd, 0, 0, size)) {
>> +		if (size == pagesize)
>> +			ksft_test_result_fail("fallocate() failed\n");
>> +		else
>> +			ksft_test_result_skip("need more free huge pages\n");
>> +		return;
>> +	}
>> +
>> +	mem = mmap(NULL, size, PROT_READ | PROT_WRITE,
>> +		   shared ? MAP_SHARED : MAP_PRIVATE, fd, 0);
>> +	if (mem == MAP_FAILED) {
>> +		if (size == pagesize || shared)
>> +			ksft_test_result_fail("mmap() failed\n");
>> +		else
>> +			ksft_test_result_skip("need more free huge pages\n");
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * Fault in the page writable such that GUP-fast can eventually pin
>> +	 * it immediately.
>> +	 */
>> +	memset(mem, 0, size);
> 

For shared mappings, MAP_POPULATE will not fault-in the pages writable. 
See mm/gup.c:populate_vma_page_range().

[There is also the case that mmap() doesn't fail if populate fails, but 
that's only a side note regarding weird semantics of MAP_POPULATE]

[...]

>> +	int flags = MFD_HUGETLB;
>> +	int fd;
>> +
>> +	ksft_print_msg("[RUN] %s ... with memfd hugetlb (%zu kB)\n", desc,
>> +		       hugetlbsize / 1024);
>> +
>> +	flags |= __builtin_ctzll(hugetlbsize) << MFD_HUGE_SHIFT;
> 
> Hm this feels a little cute :)

It's a weird interfacing, having to specify the desired size via flags 
... see the man page of memfd_create, which links to the man page of 
mmap: "the desired huge page size can be configured by encoding the 
base-2 logarithm of the desired page size in the six bits at the offset 
MAP_HUGE_SHIFT".

FWIW, we're using the same approach in cow.c already [and other memfd 
users like QEMU do it just like that, using ctz].

[...]

>> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
>> index 4893eb60d96d..b6b1eb6a8a6b 100644
>> --- a/tools/testing/selftests/mm/run_vmtests.sh
>> +++ b/tools/testing/selftests/mm/run_vmtests.sh
>> @@ -24,7 +24,7 @@ separated by spaces:
>>   - mmap
>>   	tests for mmap(2)
>>   - gup_test
>> -	tests for gup using gup_test interface
>> +	tests for gup
> 
> Super nitty again, but I'm guessing this means the CONFIG_GUP_TEST
> interface, perhaps worth keeping?

With this patch, agreed. But not longer with the next patch -- guess I 
simplified when splitting it up. If there are no strong feelings I'll 
leave it in this patch.

[...]

>>
> 
> OK this patch is really nice + well implemented, I can only point out a
> couple EXTREMELY nitty comments :) Thanks very much for adding a test for
> this, it's super useful!
> 
> Therefore,
> 
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
> 

Thanks for the review! My selftest patches rarely get that much 
attention, so highly appreciated :)

-- 
Thanks,

David / dhildenb

