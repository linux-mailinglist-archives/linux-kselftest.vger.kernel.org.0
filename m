Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6EE5FDE9A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Oct 2022 19:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJMRBj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Oct 2022 13:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJMRBb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Oct 2022 13:01:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F086BEA6A9
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 10:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665680488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ehGBuNc1sbQm4mu6rU843gW1LNmhGziTZ5r1rpb2d4=;
        b=HKvck3D71RCYOPvr7K4kiVHQMj1uqA5RNEd0ig6el/stQBgcj87in6ckBXH7Cqs68h5HHF
        h2mWifwVrwyBBrrfwaexl+SvX/PI7GqnqRV02GgSIBXWUhW3492d7VPZWNR9Cfx+8Q1IGg
        jdDr4xbpzaJPPXc+rIyZ/JID0fsuiYE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-463-o90S8HYNO5CB9mmod1wR3g-1; Thu, 13 Oct 2022 13:01:27 -0400
X-MC-Unique: o90S8HYNO5CB9mmod1wR3g-1
Received: by mail-wm1-f72.google.com with SMTP id h129-20020a1c2187000000b003bf635eac31so1484037wmh.4
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 10:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ehGBuNc1sbQm4mu6rU843gW1LNmhGziTZ5r1rpb2d4=;
        b=kNaB6MxfRXd9lHWPwg+i4kmzrZ2Xv1fOhX23kNa6R6/V6p3K8xevEugBZ9fSKoEN6x
         uYMpN2bvhMtD/YUYVf30TsDAt0eb99xBjMBat7CNSIMi18fbQasbCyncJQtdpoJik3Y7
         lKh5kWWkRxmDLLxcfi0atH/8eT0rLApmeyl8oQInT4hbD7WK0bKRekM+IyGW6ImbnH0V
         rsR5LI6Uj75arybw8mbI5xu+/7yGdA2FmtnPuZ3N6QJrrKahc5v73j5X8JhlmavidBAm
         BDY6e2D4aRPaI9OItLKg4hW9XzfpErpe73cHWIu+c3VmoNTIk/XI4NNvfJiRI85Lqogy
         0T+Q==
X-Gm-Message-State: ACrzQf3jJX74ScKs5/IWoxkp1WmRQoO6/OwSYOQw63CmkOvwCxasA6rK
        JNs7YDI1x1ozlf+SD1DoC8A2+u1mP9fQTHVxLHuL/aPVt3zUHmk3Yh2xtI7uHGSeAbLQb6wQO6H
        5JPJ8+96nhv08MGjKCI2dD0Fgoso8
X-Received: by 2002:a05:600c:1da2:b0:3b4:856a:162c with SMTP id p34-20020a05600c1da200b003b4856a162cmr7106886wms.28.1665680486142;
        Thu, 13 Oct 2022 10:01:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5RgE8uXapCGh0/vCpUyQqgrlCKlvZ8P6fv99nBMPLAXaN4ZROUUqZHwjEs1SconnG/p8A44w==
X-Received: by 2002:a05:600c:1da2:b0:3b4:856a:162c with SMTP id p34-20020a05600c1da200b003b4856a162cmr7106855wms.28.1665680485817;
        Thu, 13 Oct 2022 10:01:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:9d00:a34c:e448:d59b:831? (p200300cbc7069d00a34ce448d59b0831.dip0.t-ipconnect.de. [2003:cb:c706:9d00:a34c:e448:d59b:831])
        by smtp.gmail.com with ESMTPSA id m8-20020adfe0c8000000b0022efc4322a9sm122659wri.10.2022.10.13.10.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 10:01:25 -0700 (PDT)
Message-ID: <7e2e6679-3205-3540-f522-9eaed2940559@redhat.com>
Date:   Thu, 13 Oct 2022 19:01:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
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
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
References: <26017fe3-5ad7-6946-57db-e5ec48063ceb@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <26017fe3-5ad7-6946-57db-e5ec48063ceb@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 13.10.22 18:54, Vlastimil Babka wrote:
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
>

When did that test start failing? Was it still ok for 6.0?

-- 
Thanks,

David / dhildenb

