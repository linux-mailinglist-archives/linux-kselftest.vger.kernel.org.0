Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3B25FDEB6
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Oct 2022 19:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJMRMe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Oct 2022 13:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJMRMd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Oct 2022 13:12:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F727BCBA2
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 10:12:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C1E6B2200E;
        Thu, 13 Oct 2022 17:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665681150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=875KymawgiOKvMrSm73B8Ijsp0VVBYGNTS/PvojnyXs=;
        b=QNKSiu2lxDrvRlUn494XvZsyZLeeBIaZB3wVnkFVrmGosw0xCIAueAZGJ9JOV9PczP0wl4
        KTz5/U2aFG+eke1VtJIkOgwP/kf34zUeB6tGSGfrtdRJR8hEfE7Z4By9643OzJfelq9JAA
        oeEPeXGFDw9oPjos5AWVsinCUiq0PDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665681150;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=875KymawgiOKvMrSm73B8Ijsp0VVBYGNTS/PvojnyXs=;
        b=79nANDm0JBGWrcMBPKpXCjKM+OQdogoPQBJddO6dHwN1/nMyynkrRlSAXr2swe+rf18JaE
        v5+I7popaVwhyhAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 662CF139F3;
        Thu, 13 Oct 2022 17:12:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8Pj3F/5GSGNOQQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 13 Oct 2022 17:12:30 +0000
Message-ID: <04114304-7b35-d42f-0155-087e3b6237c6@suse.cz>
Date:   Thu, 13 Oct 2022 19:12:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: hmm_test issues with latest mainline
Content-Language: en-US
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
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <44fcecda-31a4-7288-1848-63003dfe0a7d@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/13/22 19:10, Shuah Khan wrote:
> On 10/13/22 11:01, David Hildenbrand wrote:
>> On 13.10.22 18:54, Vlastimil Babka wrote:
>>> Hi,
>>>
>>> I've been trying the hmm_tests as of today's commit:
>>>
>>> a185a0995518 ("Merge tag 'linux-kselftest-kunit-6.1-rc1-2' ...)
>>>
>>> and run into several issues that seemed worth reporting.
>>>
>>> First, it seems the FIXTURE_TEARDOWN(hmm) in
>>> tools/testing/selftests/vm/hmm-tests.c
>>> using ASSERT_EQ(ret, 0); can run into an infinite loop of reporting the
>>> assertion failure. Dunno if it's a kselftests issue or it's a bug to
>>> use asserts in teardown. I hacked it up like this locally to proceed:
>>>
>>> --- a/tools/testing/selftests/vm/hmm-tests.c
>>> +++ b/tools/testing/selftests/vm/hmm-tests.c
>>> @@ -154,6 +154,11 @@ FIXTURE_TEARDOWN(hmm)
>>>   {
>>>       int ret = close(self->fd);
>>> +    if (ret != 0) {
>>> +        fprintf(stderr, "close returned (%d) fd is (%d)\n", ret,self->fd);
>>> +        exit(1);
>>> +    }
>>> +
>>>       ASSERT_EQ(ret, 0);
>>>       self->fd = -1;
>>>   }
>>>
>>> Next, there are some tests that fail (and thus also trigger the issue above)
>>>
>>> #  RUN           hmm.hmm_device_private.exclusive ...
>>> # hmm-tests.c:1702:exclusive:Expected ret (-16) == 0 (0)
>>> close returned (-1) fd is (3)
>>> # exclusive: Test failed at step #1
>>> #          FAIL  hmm.hmm_device_private.exclusive
>>> not ok 20 hmm.hmm_device_private.exclusive
>>> #  RUN           hmm.hmm_device_private.exclusive_mprotect ...
>>> # hmm-tests.c:1756:exclusive_mprotect:Expected ret (-16) == 0 (0)
>>> close returned (-1) fd is (3)
>>> # exclusive_mprotect: Test failed at step #1
>>> #          FAIL  hmm.hmm_device_private.exclusive_mprotect
>>> not ok 21 hmm.hmm_device_private.exclusive_mprotect
>>> #  RUN           hmm.hmm_device_private.exclusive_cow ...
>>> # hmm-tests.c:1809:exclusive_cow:Expected ret (-16) == 0 (0)
>>> close returned (-1) fd is (3)
>>> # exclusive_cow: Test failed at step #1
>>> #          FAIL  hmm.hmm_device_private.exclusive_cow
>>> not ok 22 hmm.hmm_device_private.exclusive_cow
>>>
>>>
>>
>> When did that test start failing? Was it still ok for 6.0?

Didn't test yet, will try, in case it's my system/config specific thing.

>>
> 
> commit 4fe89d07dcc2804c8b562f6c7896a45643d34b2f (tag: v6.0, linux/master)
> 
> # FAILED: 25 / 50 tests passed.
> # Totals: pass:25 fail:25 xfail:0 xpass:0 skip:0 error:0
> 
> Looks good to me.

Hmm but there's 25 that failed? Or are those also misreported SKIPs?

> Possible change in 6.1 and we have to time fix them all. :)
> 
> thanks,
> -- Shuah

