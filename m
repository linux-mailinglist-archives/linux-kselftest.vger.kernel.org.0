Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7935FDEAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Oct 2022 19:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJMRKb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Oct 2022 13:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiJMRKa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Oct 2022 13:10:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFD39413F
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 10:10:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EA0C233B2C;
        Thu, 13 Oct 2022 17:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665681026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aOUN0RqxfFAji7pAOYbsyHmN1Jeo/tXqK+Fvu5sgj1A=;
        b=j+6pNY11XxsrBUUDZRHSikzA0VUhJbutw8ULURF1AeaUGAtG6tG3+GyspdW/KdS9tRzokJ
        xafNe25q4OIkP22ciK5UxeGCgzz50aAFwVhQhTAtvlKDRVneKk9Kms7YqSNzaCympsCUMk
        tRtlwIBGIBgzvW9Y+wa/Il+1rijLnjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665681026;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aOUN0RqxfFAji7pAOYbsyHmN1Jeo/tXqK+Fvu5sgj1A=;
        b=7LOmPPfLA9yWniTFBPHEoEZ6N53IEDNIpPTh2+Jrrd/VTCpM0lffHhmhjdT/wo9Pi9ywg2
        9uV4lfsYGYPipUDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6067D139F3;
        Thu, 13 Oct 2022 17:10:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rNjmDoJGSGP0PwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 13 Oct 2022 17:10:26 +0000
Message-ID: <02c39433-a572-f730-6853-32a5247b9360@suse.cz>
Date:   Thu, 13 Oct 2022 19:10:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: hmm_test issues with latest mainline
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Alex Sierra <alex.sierra@amd.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Jerome Glisse <jglisse@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>
References: <26017fe3-5ad7-6946-57db-e5ec48063ceb@suse.cz>
 <fe4188e5-2997-6a00-9684-9ca114b6d2c6@linuxfoundation.org>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <fe4188e5-2997-6a00-9684-9ca114b6d2c6@linuxfoundation.org>
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

On 10/13/22 19:03, Shuah Khan wrote:
> On 10/13/22 10:54, Vlastimil Babka wrote:
>> Hi,
>>
>> I've been trying the hmm_tests as of today's commit:
>>
>> a185a0995518 ("Merge tag 'linux-kselftest-kunit-6.1-rc1-2' ...)
>>
>> and run into several issues that seemed worth reporting.
>>
>> First, it seems the FIXTURE_TEARDOWN(hmm) in
>> tools/testing/selftests/vm/hmm-tests.c
>> using ASSERT_EQ(ret, 0); can run into an infinite loop of reporting the
>> assertion failure. Dunno if it's a kselftests issue or it's a bug to
>> use asserts in teardown. I hacked it up like this locally to proceed:
>>
> 
> kselftest pull requests didn't include any framework changes. I doubt
> that it is framework related.

But is it OK to use e.g. ASSERT_EQ() in FIXTURE_TEARDOWN()?

>> --- a/tools/testing/selftests/vm/hmm-tests.c
>> +++ b/tools/testing/selftests/vm/hmm-tests.c
>> @@ -154,6 +154,11 @@ FIXTURE_TEARDOWN(hmm)
>>   {
>>       int ret = close(self->fd);
>>   +    if (ret != 0) {
>> +        fprintf(stderr, "close returned (%d) fd is (%d)\n", ret,self->fd);
>> +        exit(1);
>> +    }
>> +
>>       ASSERT_EQ(ret, 0);
>>       self->fd = -1;
>>   }
>>
>> Next, there are some tests that fail (and thus also trigger the issue above)
>>
>> #  RUN           hmm.hmm_device_private.exclusive ...
>> # hmm-tests.c:1702:exclusive:Expected ret (-16) == 0 (0)
>> close returned (-1) fd is (3)
>> # exclusive: Test failed at step #1
>> #          FAIL  hmm.hmm_device_private.exclusive
>> not ok 20 hmm.hmm_device_private.exclusive
>> #  RUN           hmm.hmm_device_private.exclusive_mprotect ...
>> # hmm-tests.c:1756:exclusive_mprotect:Expected ret (-16) == 0 (0)
>> close returned (-1) fd is (3)
>> # exclusive_mprotect: Test failed at step #1
>> #          FAIL  hmm.hmm_device_private.exclusive_mprotect
>> not ok 21 hmm.hmm_device_private.exclusive_mprotect
>> #  RUN           hmm.hmm_device_private.exclusive_cow ...
>> # hmm-tests.c:1809:exclusive_cow:Expected ret (-16) == 0 (0)
>> close returned (-1) fd is (3)
>> # exclusive_cow: Test failed at step #1
>> #          FAIL  hmm.hmm_device_private.exclusive_cow
>> not ok 22 hmm.hmm_device_private.exclusive_cow
>>
>> I'll try to check more closely but maybe if you can reproduce it too, you'll
>> have more idea what's going on.
>>
> 
> Sounds good.
> 
>> The next thing is more of a question/documentation suggestion. Tons of tests
>> fail like this:
>>
>> ok 24 hmm.hmm_device_private.hmm_cow_in_device
>> #  RUN           hmm.hmm_device_coherent.open_close ...
>> could not open hmm dmirror driver (/dev/hmm_dmirror2)
>> #      SKIP      DEVICE_COHERENT not available
>> #            OK  hmm.hmm_device_coherent.open_close
>>
>> I assume this is because I run "test_hmm.sh smoke" without the SPM
>> parameters.
>> The help message doesn't say much about what to specify there for
>> <spm_addr_dev0> <spm_addr_dev1>. Do these tests need a particular hardware?
>> (unlike the rest?) Maybe it could be clarified.
>>
>> Last thing, I noticed all these DEVICE_COHERENT tests ultimately count as OK,
>> not SKIPPED, which would probably be more appropriate?
>>
> 
> Anytime a test can't be run due to missing config, the result should be a SKIP.
> If that is not the case let's fix these cases.
> 
>> # FAILED: 51 / 54 tests passed.
>> # Totals: pass:50 fail:3 xfail:0 xpass:0 skip:1 error:0
>>
>> (the skip:1 is due to test 9 "#      SKIP      Huge page could not be
>> allocated"
>> which is probably a misconfiguration on my part so I don't report that as
>> an issue)
>>
> 
> Skip is the right result in this case if it is indeed the result of misconfig.

Right. My point is that there were more than 20 more reporting "#      SKIP
    DEVICE_COHERENT not available" that were not counted as skip: but pass:

> thanks,
> -- Shuah

