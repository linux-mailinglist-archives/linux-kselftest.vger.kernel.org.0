Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7D05FE2D4
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Oct 2022 21:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiJMToT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Oct 2022 15:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiJMTnz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Oct 2022 15:43:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F5D183E3D
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 12:43:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C8B631F897;
        Thu, 13 Oct 2022 19:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665690229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0SRPyTFfuFKby1RsLVk+Uu42uWEeXFxo8nOmnKjyoSE=;
        b=y+hHSaGlJDpo1LLBm+YPFXyiPCjWQkDqV5oY6AKNtaGHu4q8YBZLwpTUURQN3BisvRMPY9
        zXSfQjKAlOGwDJ1oBvEazobLHt14rrEZfRZpI9fT6fwNJUBQvCWRH94T5xEaF4f9GKRK8l
        w/k10w+4DFXtCIp2YZF3QNJYRzlyVgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665690229;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0SRPyTFfuFKby1RsLVk+Uu42uWEeXFxo8nOmnKjyoSE=;
        b=fohH86wtufxIr9G3/RoPsrzrFpUUj8GxQaiFZEBKDFIy5PEOPo/ySQ1QVKc+mT1sZouVag
        +e+Ed8tX3WlEcZDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70C09139F3;
        Thu, 13 Oct 2022 19:43:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8XK3GnVqSGNrGwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 13 Oct 2022 19:43:49 +0000
Message-ID: <2d4b8d64-f17f-90ad-7328-b5ca7537d08a@suse.cz>
Date:   Thu, 13 Oct 2022 21:43:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: hmm_test issues with latest mainline
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
 <0e02ace6-2fad-47d2-03b9-d8a46f256097@suse.cz>
 <ecebc355-eff8-0046-3749-8738ed1954de@redhat.com>
 <a7b3cf86-4578-c23d-7326-4ddf7dcda043@linuxfoundation.org>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <a7b3cf86-4578-c23d-7326-4ddf7dcda043@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/13/2022 9:38 PM, Shuah Khan wrote:
> On 10/13/22 12:00, David Hildenbrand wrote:
>>>>>> When did that test start failing? Was it still ok for 6.0?
>>>>
>>>> Didn't test yet, will try, in case it's my system/config specific thing.
>>>
>>> So it's actually all the same with v6.0 for me. The infinite loops, the test
>>> failures, the misreported SKIPs.
>>>
> 
> I am not seeing infinite loops and seeing 25 failures which could
> be skips.
> 
>>
>> Is the kernel compiled with support. I have the feeling that we might simply miss kernel support and it's not handled gracefully ...
>>
> 
> Here is my config
> CONFIG_HMM_MIRROR=y
> # CONFIG_TEST_HMM is not set
> 
> Okay here is what is going on - hmm_tests are supposed to be run
> from test_hmm.sh script. When I run this I see a message that tells
> me what to do.
> 
> sudo ./test_hmm.sh
> ./test_hmm.sh: You must have the following enabled in your kernel:
> CONFIG_TEST_HMM=m
> 
> Running ./hmm_tests gives me all the failures. So it appears running
> hmm_tests executable won't work. This is expected as test_hmm.sh does
> the right setup before running the test. We have several tests that do
> that.
> 
> Vlastimil, can you try this and let me know what you see. I will compile
> with CONFIG_TEST_HMM=m and let you know what I see on my system.

Right, I didn't mention it, sorry. I did have CONFIG_TEST_HMM=m and was running
"test_hmm.sh smoke"

> thanks,
> -- Shuah
> 
> 
> 

