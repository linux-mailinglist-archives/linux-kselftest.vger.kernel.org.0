Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374BE5FE91F
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Oct 2022 08:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJNGxH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Oct 2022 02:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiJNGxG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Oct 2022 02:53:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA328E4C35
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 23:53:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A9A881F385;
        Fri, 14 Oct 2022 06:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665730383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UXBq2GZecaEmvotCXnmQMpFhZdLX4/98y393x3vVLfI=;
        b=IUqOVVSH0ZnLLJjdBVBRZ4iBOYT2Y1Cp9I9nWmUFiJeyqNwvFXyQOxwTYMbfBT61G1gmtK
        TNJZLWEwh0QNp1oU3XlQ3WhY3AaV1lFKF9jVTHMOZxMKYyTz9sBuR2kgluKgffhEppzxuP
        XJyUperk3Y9AOudCyrWzpkF/cXpE7e4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665730383;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UXBq2GZecaEmvotCXnmQMpFhZdLX4/98y393x3vVLfI=;
        b=y+Kd3g2/E+cvNlYEU1buRTtgZmAH7njIFWyDBABC8ZSE29+ws/zzTmdg7WU8splSv7tJze
        +LImP5dj5m592rAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6391513451;
        Fri, 14 Oct 2022 06:53:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id atNnF08HSWPlRgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 14 Oct 2022 06:53:03 +0000
Message-ID: <74255a05-831b-0aaf-b265-e6af4cd0aabb@suse.cz>
Date:   Fri, 14 Oct 2022 08:53:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: hmm_test issues with latest mainline
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
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
 <2d4b8d64-f17f-90ad-7328-b5ca7537d08a@suse.cz> <87fsfrjgq6.fsf@nvidia.com>
 <87bkqfjdec.fsf@nvidia.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <87bkqfjdec.fsf@nvidia.com>
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

On 10/14/22 05:21, Alistair Popple wrote:
> 
> Seems like this would fix both the SKIP in FIXTURE_SETUP and ASSERT in
> FIXTURE_TEARDOWN issues:

Yep, that fixed the infinite error loops for me, thanks.

...

>> Unlike hmm-tests though the above snippet reports correct pass/skip
>> statistics with the teardown assertion removed. This is because there is
>> also a bug in hmm-tests. Currently we have:
>>
>>    SKIP(exit(0), "DEVICE_COHERENT not available");
>>
>> Which should really be:
>>
>>    SKIP(return, "DEVICE_COHERENT not available");
>>

And with this on top, I got the skips due to DEVICE_COHERENT not available
counted correctly.

>> Of course that results in an infinite loop due to the associated
>> assertion failure during teardown which is still called despite the SKIP
>> in setup. Not sure if this is why it was originally coded this way.
>>
>>  - Alistair
>>
>>>> thanks,
>>>> -- Shuah
>>>>
>>>>
>>>>

