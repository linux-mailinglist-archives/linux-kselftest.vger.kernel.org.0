Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F8F5FDF37
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Oct 2022 19:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiJMRpO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Oct 2022 13:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJMRpL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Oct 2022 13:45:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B699B50BA4
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 10:45:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 168491FEA1;
        Thu, 13 Oct 2022 17:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665683109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C0ZcrqWq02INMyuvT9d4Qy6sMxojvAn5U3ibtbgaCXk=;
        b=LZIJzjWrVjS8AxO6xpXn4tp3ROO/OkLAV9NdB13J0qbOhcMT0TxZvJekrOGU7Zhm6dIrhL
        ThFGzypQz/Bf+R9cy95pevWsFC0BFG3qJc3QAYhtQdzoDiKADjPr0aqLxYcSyHsXizDu9s
        mqU+fsRthMNLHCt7c44CILLVEH5qiWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665683109;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C0ZcrqWq02INMyuvT9d4Qy6sMxojvAn5U3ibtbgaCXk=;
        b=6YWqm7zQTNYMkwSMw8jf2lSqtAQdQQ+i3u9Kl72Apb10Dbb+Ws4fTv/Tt2IE6weDC0fDMk
        38ws2s9auCu2/qCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 858C6139F3;
        Thu, 13 Oct 2022 17:45:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FqB3H6ROSGMWVgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 13 Oct 2022 17:45:08 +0000
Message-ID: <0e02ace6-2fad-47d2-03b9-d8a46f256097@suse.cz>
Date:   Thu, 13 Oct 2022 19:45:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: hmm_test issues with latest mainline
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>,
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
Content-Language: en-US
In-Reply-To: <04114304-7b35-d42f-0155-087e3b6237c6@suse.cz>
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

On 10/13/22 19:12, Vlastimil Babka wrote:
> On 10/13/22 19:10, Shuah Khan wrote:
>> On 10/13/22 11:01, David Hildenbrand wrote:
>>> On 13.10.22 18:54, Vlastimil Babka wrote:
>>>> Hi,
>>>>
>>>> I've been trying the hmm_tests as of today's commit:
>>>>
>>>> a185a0995518 ("Merge tag 'linux-kselftest-kunit-6.1-rc1-2' ...)
>>>>
>>>> and run into several issues that seemed worth reporting.
>>>>
>>>> First, it seems the FIXTURE_TEARDOWN(hmm) in
>>>> tools/testing/selftests/vm/hmm-tests.c
>>>> using ASSERT_EQ(ret, 0); can run into an infinite loop of reporting the
>>>> assertion failure. Dunno if it's a kselftests issue or it's a bug to
>>>> use asserts in teardown. I hacked it up like this locally to proceed:
>>>>
>>>> --- a/tools/testing/selftests/vm/hmm-tests.c
>>>> +++ b/tools/testing/selftests/vm/hmm-tests.c
>>>> @@ -154,6 +154,11 @@ FIXTURE_TEARDOWN(hmm)
>>>>   {
>>>>       int ret = close(self->fd);
>>>> +    if (ret != 0) {
>>>> +        fprintf(stderr, "close returned (%d) fd is (%d)\n", ret,self->fd);
>>>> +        exit(1);
>>>> +    }
>>>> +
>>>>       ASSERT_EQ(ret, 0);
>>>>       self->fd = -1;
>>>>   }
>>>>
>>>> Next, there are some tests that fail (and thus also trigger the issue above)
>>>>
>>>> #  RUN           hmm.hmm_device_private.exclusive ...
>>>> # hmm-tests.c:1702:exclusive:Expected ret (-16) == 0 (0)
>>>> close returned (-1) fd is (3)
>>>> # exclusive: Test failed at step #1
>>>> #          FAIL  hmm.hmm_device_private.exclusive
>>>> not ok 20 hmm.hmm_device_private.exclusive
>>>> #  RUN           hmm.hmm_device_private.exclusive_mprotect ...
>>>> # hmm-tests.c:1756:exclusive_mprotect:Expected ret (-16) == 0 (0)
>>>> close returned (-1) fd is (3)
>>>> # exclusive_mprotect: Test failed at step #1
>>>> #          FAIL  hmm.hmm_device_private.exclusive_mprotect
>>>> not ok 21 hmm.hmm_device_private.exclusive_mprotect
>>>> #  RUN           hmm.hmm_device_private.exclusive_cow ...
>>>> # hmm-tests.c:1809:exclusive_cow:Expected ret (-16) == 0 (0)
>>>> close returned (-1) fd is (3)
>>>> # exclusive_cow: Test failed at step #1
>>>> #          FAIL  hmm.hmm_device_private.exclusive_cow
>>>> not ok 22 hmm.hmm_device_private.exclusive_cow
>>>>
>>>>
>>>
>>> When did that test start failing? Was it still ok for 6.0?
> 
> Didn't test yet, will try, in case it's my system/config specific thing.

So it's actually all the same with v6.0 for me. The infinite loops, the test
failures, the misreported SKIPs.

#  RUN           hmm.hmm_device_private.exclusive ...
# hmm-tests.c:1673:exclusive:Expected ret (-16) == 0 (0)
hmm close returned (-1) fd is (3)
# exclusive: Test failed at step #1
#          FAIL  hmm.hmm_device_private.exclusive
not ok 20 hmm.hmm_device_private.exclusive
#  RUN           hmm.hmm_device_private.exclusive_mprotect ...
# hmm-tests.c:1727:exclusive_mprotect:Expected ret (-16) == 0 (0)
hmm close returned (-1) fd is (3)
# exclusive_mprotect: Test failed at step #1
#          FAIL  hmm.hmm_device_private.exclusive_mprotect
not ok 21 hmm.hmm_device_private.exclusive_mprotect
#  RUN           hmm.hmm_device_private.exclusive_cow ...
# hmm-tests.c:1780:exclusive_cow:Expected ret (-16) == 0 (0)
hmm close returned (-1) fd is (3)
# exclusive_cow: Test failed at step #1
#          FAIL  hmm.hmm_device_private.exclusive_cow
not ok 22 hmm.hmm_device_private.exclusive_cow

