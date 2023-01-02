Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633A465B47B
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jan 2023 16:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbjABPyO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Jan 2023 10:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjABPyN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Jan 2023 10:54:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D52DAE
        for <linux-kselftest@vger.kernel.org>; Mon,  2 Jan 2023 07:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672674804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=08dCYsa5Ayalb0WHzc9Dc+dPt0AFb2C2DyR+UOE8zaY=;
        b=C7bkFE07gLsEtVfkfzh/DYKscmoJSfmg/2enR47iyUHky0B4jAc3wrCT0y7Zho/hGjfZOv
        uae1N2g+yaS47eMaECivaXQCdiqAqe/JUnwrsRJv67YVhzrctOVW2jHRnv0p0DbZfEmuMS
        Z7SGa0IxHeysilsSAo5mGoib2UJfeEU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-121-NFVRiEbjOQSto2Rdv-6VGQ-1; Mon, 02 Jan 2023 10:53:22 -0500
X-MC-Unique: NFVRiEbjOQSto2Rdv-6VGQ-1
Received: by mail-wm1-f69.google.com with SMTP id k20-20020a05600c1c9400b003d9717c8b11so13281932wms.7
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jan 2023 07:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=08dCYsa5Ayalb0WHzc9Dc+dPt0AFb2C2DyR+UOE8zaY=;
        b=ttHV3owbVwhR3hqnG2ICUEqvzZVEnF4L8AuYk7Ettn+oN/6xBhC4qsaqQ+V2lY8bAI
         ppb6QfeEk5KE3sWjF1c3UEPXrcmgU40d2TLs1auJmn0xKkgI+kFd0K9jsRrlPOo7ZyZX
         X63b8NOp0huJhprZ+QGMzDj5uE7qflEmIuWN7Ewb114O8JpIJpX9kngc7sGQXe8gDfqr
         FWrmnznep+lEsNGNzqnoro7IAG6uzHQqLUazX7o/NlW0fCn1e06IbtASlCb8gyCvfAmq
         rqSOdl/TqKAUGIe7wOBw5/8S0f8HHscY2/WfCPlN3q2C+gDi1LrR5yuG8iprSp8159CD
         YPnw==
X-Gm-Message-State: AFqh2krZD+EJ84/yuKk+eqRwAWi32NGJsJ2AyrRJSNJSUDB3/Jdiz84X
        XDEim6UngYhwdB6JhLioaEim8iRSj5AMSyvWD2YghOOWs/0YpgqbDcnPbYsNBOPPvFsSrTzZ2l/
        cb0EmjbYhiPjOe8+waqrn7rY5b1yC
X-Received: by 2002:adf:cc8e:0:b0:273:75d2:8d01 with SMTP id p14-20020adfcc8e000000b0027375d28d01mr23779216wrj.26.1672674801690;
        Mon, 02 Jan 2023 07:53:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvsKmOyCmw5BR6SbNL6IHnflKGvVcnU44NWhqj6A8qfHLRPHgTXjmjL32Q503GqLTl/iAl4Zg==
X-Received: by 2002:adf:cc8e:0:b0:273:75d2:8d01 with SMTP id p14-20020adfcc8e000000b0027375d28d01mr23779202wrj.26.1672674801440;
        Mon, 02 Jan 2023 07:53:21 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:500:9382:2e5a:fea:8889? (p200300cbc703050093822e5a0fea8889.dip0.t-ipconnect.de. [2003:cb:c703:500:9382:2e5a:fea:8889])
        by smtp.gmail.com with ESMTPSA id j13-20020a5d618d000000b002425dc49024sm28834869wru.43.2023.01.02.07.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 07:53:21 -0800 (PST)
Message-ID: <54da9c76-a506-0acd-3f97-60a0cce87c8a@redhat.com>
Date:   Mon, 2 Jan 2023 16:53:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] selftest/vm: add mremap expand merge offset test
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Jakub Matena <matenajakub@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>
References: <f132891530423f8bb72fde8169279b1c5967ec40.1672670177.git.lstoakes@gmail.com>
 <3a4fbe90-b46e-aa49-9866-e2b0cf6de38d@redhat.com> <Y7L9JfyQrwIRVo2A@lucifer>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y7L9JfyQrwIRVo2A@lucifer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02.01.23 16:49, Lorenzo Stoakes wrote:
> On Mon, Jan 02, 2023 at 04:34:14PM +0100, David Hildenbrand wrote:
>> On 02.01.23 15:44, Lorenzo Stoakes wrote:
>>> Add a test to assert that we can mremap() and expand a mapping starting
>>> from an offset within an existing mapping. We unmap the last page in a 3
>>> page mapping to ensure that the remap should always succeed, before
>>> remapping from the 2nd page.
>>>
>>> This is additionally a regression test for the issue solved in "mm, mremap:
>>> fix mremap() expanding vma with addr inside vma" and confirmed to fail
>>> prior to the change and pass after it.
>>>
>>> Finally, this patch updates the existing mremap expand merge test to check
>>> error conditions and reduce code duplication between the two tests.
>>>
>>> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
>>> ---
>>>    tools/testing/selftests/vm/mremap_test.c | 115 ++++++++++++++++++-----
>>>    1 file changed, 93 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/vm/mremap_test.c
>>
>>
>> ...
>>
>>> +
>>> +	start = mmap(NULL, 3 * page_size, PROT_READ | PROT_WRITE,
>>> +		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>> +
>>> +	if (start == MAP_FAILED) {
>>> +		ksft_print_msg("mmap failed: %s\n", strerror(errno));
>>
>> I'd
>>
>> 	ksft_test_result_fail(...)
>> 	return;
>>
>>> +		goto out;
>>> +	}
>>> +
>>> +	munmap(start + page_size, page_size);
>>> +	remap = mremap(start, page_size, 2 * page_size, 0);
>>> +	if (remap == MAP_FAILED) {
>>> +		ksft_print_msg("mremap failed: %s\n", strerror(errno));
>>> +		munmap(start, page_size);
>>> +		munmap(start + 2 * page_size, page_size);
>>> +		goto out;
>>
>> dito
>>
>> 	ksft_test_result_fail(...)
>> 	...
>> 	return;
>>
>>> +	}
>>> +
>>> +	success = is_range_mapped(maps_fp, start, start + 3 * page_size);
>>> +	munmap(start, 3 * page_size);
>>> +
>>> +out:
>>
>> then you can drop the out label.
>>
> 
> I have to disagree on this, to be consistent with the other tests the
> failure messages should include the test name, and putting the
> ksft_test_result_fail("test name") in each branch as well as the error
> message would just be wilful duplication.
> 
> I do think it's a pity C lacks mechanisms such that gotos are sometimes
> necessary, but I can only right so many wrongs in this patch :)
> 

Let's agree to disagree ;) Too bad we don't have prefix push/pop 
functionality as we have in other similar testing frameworks -- to avoid 
exactly that duplication.

[...]

>> I'd simply use a global variable, same applies for page_size. But passing it
>> around is also ok.
>>
> 
> I am trying to keep things consistent with what's gone before in this code,
> and given page_size is being passed around I think the 'when in Rome'
> principle applies equally to passing the fp around I think.

Other tests we have handle it "easier". :)

-- 
Thanks,

David / dhildenb

