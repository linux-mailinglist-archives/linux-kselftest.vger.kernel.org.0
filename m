Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7EB723877
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 09:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbjFFHLh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 03:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbjFFHL1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 03:11:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C053EC
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Jun 2023 00:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686035436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=znzcZh/FoBR70IAi4uiesl3ajaljXIGrrB/hgdSvA54=;
        b=RlYCfh/Hjz+wp4GcMXZwHLRf7jaHQnhFR0ptFN6qaV7d+Ljbgy+QiwvWbfg9XOt7EgKgjk
        wxlDrtqi04pYud3pFspVbITfFrPUcR/BemeDiehIKXZ7a87CwGBU9iEOYp8H4/oTME+MuQ
        TSwbzhVkVrKabHcERQdThe5/q8TdL50=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-w5rUU1lvPDGj2fC1QokvZw-1; Tue, 06 Jun 2023 03:10:33 -0400
X-MC-Unique: w5rUU1lvPDGj2fC1QokvZw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f72720c592so24717185e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jun 2023 00:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686035431; x=1688627431;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znzcZh/FoBR70IAi4uiesl3ajaljXIGrrB/hgdSvA54=;
        b=b97zWtseeq3FhxEU0qOqpQ1rnf5bzUMUKnG/u9H1yYNgnr1j+MWn16dMJCwzbhhZd7
         J2jNFZNCbb5WcylnWQUCRuqWm/PMsV9LOtTTtJLV0HqSMihlfe3tS8/UEMgDWsZgllsv
         mr3adicLp4fXBybJuW2TecbaKIjBjeFipkv0zwHqalaRvHMI2Fx3YB8NqiX3TqbjK5RP
         Pkfg7S7/RjpZah9qBXf3eKcfIHsZipVFZznsgJPVpljjuqQJ62ugniAw2J8JJv17kTc3
         jRL3MWC7fkZRYm35Ma79oXr30mN8JvERC9kaO5IK9XnQwpaLu6r2b8vgFlUpEgS320U0
         HQEg==
X-Gm-Message-State: AC+VfDyWoGWXyy/YBBRyWJ8+jgn1Kr7S9/Nulx5k8abU51b0PlMMw1Oj
        XHKcq4llPcm9rtTILuGwp5TajMnmJ6X5O5ueb+Ar/rIbv7j4CRDFypNG9fUeX01EK5PyDOC3SF8
        zdPqxT0EhfTcya3lTTSuJDxdaEeYy
X-Received: by 2002:a7b:c302:0:b0:3f7:2d79:9edf with SMTP id k2-20020a7bc302000000b003f72d799edfmr1228113wmj.7.1686035431312;
        Tue, 06 Jun 2023 00:10:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Ei1Gu9cG306mrOCZa5KgbLIesll7Akod2t7m1Y5/w4jJYTazc5TJRd+GgF71Pteor29xSSQ==
X-Received: by 2002:a7b:c302:0:b0:3f7:2d79:9edf with SMTP id k2-20020a7bc302000000b003f72d799edfmr1228091wmj.7.1686035430963;
        Tue, 06 Jun 2023 00:10:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:d100:ce7e:d566:43f8:2b24? (p200300cbc709d100ce7ed56643f82b24.dip0.t-ipconnect.de. [2003:cb:c709:d100:ce7e:d566:43f8:2b24])
        by smtp.gmail.com with ESMTPSA id r1-20020a5d52c1000000b0030ae69920c9sm11651633wrv.53.2023.06.06.00.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 00:10:26 -0700 (PDT)
Message-ID: <e099e2c1-322c-0a64-0f5b-5da621fedca1@redhat.com>
Date:   Tue, 6 Jun 2023 09:10:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 2/3] selftests/mm: gup_longterm: new functional test
 for FOLL_LONGTERM
To:     John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Peter Xu <peterx@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jan Kara <jack@suse.cz>
References: <20230519102723.185721-1-david@redhat.com>
 <20230519102723.185721-3-david@redhat.com>
 <ea3548ae-de27-fb67-5b2a-34aca006005c@nvidia.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ea3548ae-de27-fb67-5b2a-34aca006005c@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 06.06.23 08:23, John Hubbard wrote:
> On 5/19/23 03:27, David Hildenbrand wrote:
> ...
>> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
>> index 23af4633f0f4..95acb099315e 100644
>> --- a/tools/testing/selftests/mm/Makefile
>> +++ b/tools/testing/selftests/mm/Makefile
>> @@ -34,6 +34,7 @@ LDLIBS = -lrt -lpthread
>>   
>>   TEST_GEN_PROGS = cow
>>   TEST_GEN_PROGS += compaction_test
>> +TEST_GEN_PROGS += gup_longterm
> 
> Hi David,
> 
> Peter Xu just pointed out that we need a .gitignore entry for
> gup_longterm [1]. That logically belongs in this patch, I think.

Yes, although I don't care if it's in a follow-up patch (we're talking 
testcases after all).

@Andrew can you include that hunk in that patch or do you want a resend?

-- 
Cheers,

David / dhildenb

