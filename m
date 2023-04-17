Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612BD6E4C57
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Apr 2023 17:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjDQPEC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Apr 2023 11:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjDQPD4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Apr 2023 11:03:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FA110E
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Apr 2023 08:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681743784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9AEy9mK6O3Mbv/ulbvFXi8BBb8TRpaehy7L8tKOiCn8=;
        b=Al5vq02qUq/C6bYhnzShJgBCw2/jGZJM/Onzux3OEz0FOXOteVwDWWaskypqE1tRTCRlYl
        D4h8tZ9SBVWkU9r+8/qtHVdo9JWhghXa/4Y9nbkvZV77Api6I+3poF86EKYlaeJcimFHIe
        yTo26kzjd28Rl12obMUP+sIUEYkgUVA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-_KH9HYJNMG2Pd5R_uWZ8nw-1; Mon, 17 Apr 2023 10:56:36 -0400
X-MC-Unique: _KH9HYJNMG2Pd5R_uWZ8nw-1
Received: by mail-wm1-f72.google.com with SMTP id w16-20020a05600c475000b003f082eecdcaso10678037wmo.6
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Apr 2023 07:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681743395; x=1684335395;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9AEy9mK6O3Mbv/ulbvFXi8BBb8TRpaehy7L8tKOiCn8=;
        b=Xaw4BfgCYWLWhDTKWRZ3m9v/bhSUvjkKbC1m39bloObXBXsR+XkqJn5sY5oBzZtctl
         Fl5vosxYOZNPTHheAu++2P/AggpmrcwuklArYTdWFyu/UT5oAQ2ykK2mZN1V3J4UKhc/
         HchfadDywxG0fi7BSofKDZraUQH/0u04+DRNZJwN8ys9o8Gl68ogBrYvNX+fuiarsUDS
         blammUzAZ6kqzT27O29NbmVDASXUz+2ldOng7Og2pCZr/Yp+V0d45nj7yK8kucsx+mOH
         xfjYinZicrQHr6VHErB6k6KAuG04F7EcsmymI3f7c9/DnwyXZRZ51Sl++i/cyRiUDDyH
         DMQg==
X-Gm-Message-State: AAQBX9ef0DNRXmGJCXGdOR44vcUQnQIHFrJfVUltOFz1wIlI12BQxWGp
        e3+H9fLdvlacfTjaSNP44kROfFqmagF24+2OB4NkxABAqFFk/Xdt3xJmqXT6gupMQkg/hsvaREJ
        e0S601hsCMOmbp9eXYM194P6zuWDi
X-Received: by 2002:a1c:6a10:0:b0:3f1:7324:c81d with SMTP id f16-20020a1c6a10000000b003f17324c81dmr2928931wmc.14.1681743395474;
        Mon, 17 Apr 2023 07:56:35 -0700 (PDT)
X-Google-Smtp-Source: AKy350a6ddKymR8nlcmLUE/5sBw6TnJoW0qmSC81AMGo1SYFyxMxj5tFc0W5AcAdnFpqPUjwD1aYVg==
X-Received: by 2002:a1c:6a10:0:b0:3f1:7324:c81d with SMTP id f16-20020a1c6a10000000b003f17324c81dmr2928915wmc.14.1681743395171;
        Mon, 17 Apr 2023 07:56:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:db07:68a9:6af5:ecdf? (p200300cbc700fc00db0768a96af5ecdf.dip0.t-ipconnect.de. [2003:cb:c700:fc00:db07:68a9:6af5:ecdf])
        by smtp.gmail.com with ESMTPSA id v22-20020a7bcb56000000b003f049a42689sm12161191wmj.25.2023.04.17.07.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 07:56:34 -0700 (PDT)
Message-ID: <954d6b1f-5b4d-48e5-02fe-646b3e79f6e5@redhat.com>
Date:   Mon, 17 Apr 2023 16:56:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v8 3/3] selftests/mm: add new selftests for KSM
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, willy@infradead.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <20230415225913.3206647-1-shr@devkernel.io>
 <20230415225913.3206647-4-shr@devkernel.io>
 <355f42d1-4354-376d-ab27-7e55d06e64a6@redhat.com>
Organization: Red Hat
In-Reply-To: <355f42d1-4354-376d-ab27-7e55d06e64a6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17.04.23 16:35, David Hildenbrand wrote:
>> +/* Verify that KSM can be enabled / queried with prctl. */
>> +static void test_prctl(void)
>> +{
>> +	int ret;
>> +
>> +	ksft_print_msg("[RUN] %s\n", __func__);
>> +
>> +	ret = prctl(PR_SET_MEMORY_MERGE, 1, 0, 0, 0);
>> +	if (ret < 0 && errno == EINVAL) {
>> +		ksft_test_result_skip("PR_SET_MEMORY_MERGE not supported\n");
>> +		return;
>> +	} else if (ret) {
>> +		ksft_test_result_fail("PR_SET_MEMORY_MERGE=1 failed\n");
>> +	}
> 
> Just realized we're missing a "return;" in case of the failure here.
> 


And we should probably fix that as well:

ERROR: do not initialise globals to 0
#235: FILE: tools/testing/selftests/mm/ksm_tests.c:57:
+int debug = 0;

total: 1 errors, 0 warnings, 512 lines checked


-- 
Thanks,

David / dhildenb

