Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60DD5FDE9D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Oct 2022 19:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJMRDG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Oct 2022 13:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJMRDE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Oct 2022 13:03:04 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D831F5CCC
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 10:03:02 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id u2so1278576ilv.6
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 10:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0SJ/jFf340QWCBLHmbjb0V8xwWmYUnucYYZEwPbeojI=;
        b=JAsHpc/tw836UCyqbjAH1dU6C9lkYn55St0/OxdLFPTxPLDdb5fl51uDjwbSafvKtP
         IaJtHNseYvorRGClfDscnzfiB0suLhbTRwiRXzcNXVtNJ/JhjTExQWCiPxgHJ+SakK7r
         nJYGhMWEV0iBo/eeYXMO9jejDynFg/RvtGC4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0SJ/jFf340QWCBLHmbjb0V8xwWmYUnucYYZEwPbeojI=;
        b=UA78nC/8vQVMqx9h+b9mc2xRKy1d+J/tdUxtoQY7K95FAvgfJNXVcmM3FDb1SQH6sp
         8s7fUMy4bBMCq1CaelycUoQYd7CIIzxxS1xE3IkX6uxPbOLEguJPMoHeTVQ0+FneKcur
         f6yjaESaTwT6T6NhX6/N5k9cybtXhKWHLK9UuvdzbByDmfqNizcAy2McuGZhosDQX3n/
         vyR95ZBrACid7yzBD//0zNU1foFkkREGvbhXVt01Tvk2PXAiC0YKZThtlM4UHiivvXBC
         hkR/b90tzttYbR53Pm2nOrK79oSei/NlH8mYPDp64hi4AMw+HhBlX6yiv7bjaASoE3UW
         7L5A==
X-Gm-Message-State: ACrzQf3IuRiRXcPw7tbECiVkpPkf/TaPMeUrDntXWkc1FEGE7C1zDrZK
        eaaq9ROGPgIjVRh2OUZhEJMiZ3XQzEF0CA==
X-Google-Smtp-Source: AMsMyM5LGWLrVKdG3LpHcSxQ94B0YP3ErKxJ4GJiGn6VrIOxy0J1xLeF8+MJRyl/gfTQtbXlqZproA==
X-Received: by 2002:a92:c24e:0:b0:2fc:3482:a438 with SMTP id k14-20020a92c24e000000b002fc3482a438mr493042ilo.145.1665680581855;
        Thu, 13 Oct 2022 10:03:01 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id m10-20020a6bea0a000000b0068994e773e7sm92355ioc.26.2022.10.13.10.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 10:03:01 -0700 (PDT)
Message-ID: <fe4188e5-2997-6a00-9684-9ca114b6d2c6@linuxfoundation.org>
Date:   Thu, 13 Oct 2022 11:03:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: hmm_test issues with latest mainline
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>,
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
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <26017fe3-5ad7-6946-57db-e5ec48063ceb@suse.cz>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <26017fe3-5ad7-6946-57db-e5ec48063ceb@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/13/22 10:54, Vlastimil Babka wrote:
> Hi,
> 
> I've been trying the hmm_tests as of today's commit:
> 
> a185a0995518 ("Merge tag 'linux-kselftest-kunit-6.1-rc1-2' ...)
> 
> and run into several issues that seemed worth reporting.
> 
> First, it seems the FIXTURE_TEARDOWN(hmm) in
> tools/testing/selftests/vm/hmm-tests.c
> using ASSERT_EQ(ret, 0); can run into an infinite loop of reporting the
> assertion failure. Dunno if it's a kselftests issue or it's a bug to
> use asserts in teardown. I hacked it up like this locally to proceed:
> 

kselftest pull requests didn't include any framework changes. I doubt
that it is framework related.

> --- a/tools/testing/selftests/vm/hmm-tests.c
> +++ b/tools/testing/selftests/vm/hmm-tests.c
> @@ -154,6 +154,11 @@ FIXTURE_TEARDOWN(hmm)
>   {
>   	int ret = close(self->fd);
>   
> +	if (ret != 0) {
> +		fprintf(stderr, "close returned (%d) fd is (%d)\n", ret,self->fd);
> +		exit(1);
> +	}
> +
>   	ASSERT_EQ(ret, 0);
>   	self->fd = -1;
>   }
> 
> Next, there are some tests that fail (and thus also trigger the issue above)
> 
> #  RUN           hmm.hmm_device_private.exclusive ...
> # hmm-tests.c:1702:exclusive:Expected ret (-16) == 0 (0)
> close returned (-1) fd is (3)
> # exclusive: Test failed at step #1
> #          FAIL  hmm.hmm_device_private.exclusive
> not ok 20 hmm.hmm_device_private.exclusive
> #  RUN           hmm.hmm_device_private.exclusive_mprotect ...
> # hmm-tests.c:1756:exclusive_mprotect:Expected ret (-16) == 0 (0)
> close returned (-1) fd is (3)
> # exclusive_mprotect: Test failed at step #1
> #          FAIL  hmm.hmm_device_private.exclusive_mprotect
> not ok 21 hmm.hmm_device_private.exclusive_mprotect
> #  RUN           hmm.hmm_device_private.exclusive_cow ...
> # hmm-tests.c:1809:exclusive_cow:Expected ret (-16) == 0 (0)
> close returned (-1) fd is (3)
> # exclusive_cow: Test failed at step #1
> #          FAIL  hmm.hmm_device_private.exclusive_cow
> not ok 22 hmm.hmm_device_private.exclusive_cow
> 
> I'll try to check more closely but maybe if you can reproduce it too, you'll
> have more idea what's going on.
> 

Sounds good.

> The next thing is more of a question/documentation suggestion. Tons of tests
> fail like this:
> 
> ok 24 hmm.hmm_device_private.hmm_cow_in_device
> #  RUN           hmm.hmm_device_coherent.open_close ...
> could not open hmm dmirror driver (/dev/hmm_dmirror2)
> #      SKIP      DEVICE_COHERENT not available
> #            OK  hmm.hmm_device_coherent.open_close
> 
> I assume this is because I run "test_hmm.sh smoke" without the SPM parameters.
> The help message doesn't say much about what to specify there for
> <spm_addr_dev0> <spm_addr_dev1>. Do these tests need a particular hardware?
> (unlike the rest?) Maybe it could be clarified.
> 
> Last thing, I noticed all these DEVICE_COHERENT tests ultimately count as OK,
> not SKIPPED, which would probably be more appropriate?
> 

Anytime a test can't be run due to missing config, the result should be a SKIP.
If that is not the case let's fix these cases.

> # FAILED: 51 / 54 tests passed.
> # Totals: pass:50 fail:3 xfail:0 xpass:0 skip:1 error:0
> 
> (the skip:1 is due to test 9 "#      SKIP      Huge page could not be allocated"
> which is probably a misconfiguration on my part so I don't report that as an issue)
> 

Skip is the right result in this case if it is indeed the result of misconfig.

thanks,
-- Shuah
