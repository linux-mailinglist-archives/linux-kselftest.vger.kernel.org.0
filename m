Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FBC5FE909
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Oct 2022 08:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJNGp4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Oct 2022 02:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJNGpy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Oct 2022 02:45:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3446F1578AA
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 23:45:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C440121E9A;
        Fri, 14 Oct 2022 06:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665729950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4stetO37DS8MDb8SRwH/wc0SYhyVFw055kNS/KnZ0bc=;
        b=IC+KPb6MYfqzeTWJo+bq/0aL4PEUci9WhYkHdraMXya8qWSs7ZGnrjvkJZb9tjmrJX20h/
        OhsEwfynvp3ycODjqOVYuMzItMKh3z0+7V6wP4IykEREE50qTYqV/KLDutg9mzFpyo3zbV
        +ST+YWQJuToZ+wqmp6cPRjVQmiTSo4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665729950;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4stetO37DS8MDb8SRwH/wc0SYhyVFw055kNS/KnZ0bc=;
        b=6L3mEdbCqfnTtujXcpRDqROtaMpX1PuifnzxSSuEpzzdpuui8d3O8qo93kgdZUctS6G+GA
        Nof3d4I9hXv0H5Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91D4913451;
        Fri, 14 Oct 2022 06:45:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SaHfIp4FSWPQQgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 14 Oct 2022 06:45:50 +0000
Message-ID: <a33f4e26-4436-43ad-9aef-cd7b02e3fb14@suse.cz>
Date:   Fri, 14 Oct 2022 08:45:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: hmm_test issues with latest mainline
To:     David Hildenbrand <david@redhat.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alex Sierra <alex.sierra@amd.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Jerome Glisse <jglisse@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
References: <26017fe3-5ad7-6946-57db-e5ec48063ceb@suse.cz>
 <7e2e6679-3205-3540-f522-9eaed2940559@redhat.com>
 <44fcecda-31a4-7288-1848-63003dfe0a7d@linuxfoundation.org>
 <04114304-7b35-d42f-0155-087e3b6237c6@suse.cz>
 <0e02ace6-2fad-47d2-03b9-d8a46f256097@suse.cz>
 <ecebc355-eff8-0046-3749-8738ed1954de@redhat.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ecebc355-eff8-0046-3749-8738ed1954de@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/13/22 20:00, David Hildenbrand wrote:
>>>>> When did that test start failing? Was it still ok for 6.0?
>>>
>>> Didn't test yet, will try, in case it's my system/config specific thing.
>>
>> So it's actually all the same with v6.0 for me. The infinite loops, the test
>> failures, the misreported SKIPs.
>>
>> #  RUN           hmm.hmm_device_private.exclusive ...
>> # hmm-tests.c:1673:exclusive:Expected ret (-16) == 0 (0)
>> hmm close returned (-1) fd is (3)
>> # exclusive: Test failed at step #1
>> #          FAIL  hmm.hmm_device_private.exclusive
>> not ok 20 hmm.hmm_device_private.exclusive
>> #  RUN           hmm.hmm_device_private.exclusive_mprotect ...
>> # hmm-tests.c:1727:exclusive_mprotect:Expected ret (-16) == 0 (0)
>> hmm close returned (-1) fd is (3)
>> # exclusive_mprotect: Test failed at step #1
>> #          FAIL  hmm.hmm_device_private.exclusive_mprotect
>> not ok 21 hmm.hmm_device_private.exclusive_mprotect
>> #  RUN           hmm.hmm_device_private.exclusive_cow ...
>> # hmm-tests.c:1780:exclusive_cow:Expected ret (-16) == 0 (0)
>> hmm close returned (-1) fd is (3)
>> # exclusive_cow: Test failed at step #1
>> #          FAIL  hmm.hmm_device_private.exclusive_cow
>> not ok 22 hmm.hmm_device_private.exclusive_cow
>>
> 
> Is the kernel compiled with support. I have the feeling that we might simply
> miss kernel support and it's not handled gracefully ...

If you mean CONFIG_DEVICE_PRIVATE=y then it's there. Couldn't find anything
relevant that wouldn't be enabled.


