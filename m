Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6D45BC486
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Sep 2022 10:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiISIne (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Sep 2022 04:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiISInd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Sep 2022 04:43:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDD921E2B
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Sep 2022 01:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663577011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c68X5zyTPcgo56gf8lFXosz3ez64Ms9Dsywzzb9DBq4=;
        b=X+OU8pcKEozN126RgpG1ZS07kzJXJDTxK20EBqH02V4+wi71v9AOpgQm6M2bFL/RAOaTeV
        ROH7FikQrtnk/lFS5Q02NLpyEJAtUujzZ8giXOwZ9JXvbOUy2PDASn2NSARYyU+G2ckyVc
        0tG/8Rg9jVz2aEndebJ79SknI1cu1vQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-141-EE8sPMunORSRtdR6gp2Vbw-1; Mon, 19 Sep 2022 04:43:27 -0400
X-MC-Unique: EE8sPMunORSRtdR6gp2Vbw-1
Received: by mail-wr1-f69.google.com with SMTP id r23-20020adfb1d7000000b002286358a916so6266489wra.3
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Sep 2022 01:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=c68X5zyTPcgo56gf8lFXosz3ez64Ms9Dsywzzb9DBq4=;
        b=4HIbr+5yJwTI4AFzTfxT9udVCGAjwnjMHG3gx3jGNxl5fK5KGKBwXJrfbUIG5v4Yz/
         IU9NWd701c+L+hRtKFvdR7FWYHFZGcwvUUENPq+KJ8nnGl+BSzR5D6a8+50p1HruesNw
         wUbrM6qudAxmJHtgQcFo0AR+TRV66Cf77OzDQCUIgWavvagwu1fFEs68NGKvO2RPXfSx
         iXDbcVHfcs7F9XrXNcDGfOTj9CPtYFbeaiUwHahIkplJS41DacypSMkMDWm46NtgV4UX
         dIByMTozcoe61sNttymOVM8b3az1DoTeqFUTX4Y8TsQGKH1w8Zjg5VsWQwedOwYvvfYH
         haVg==
X-Gm-Message-State: ACrzQf0erzE3zJ2KesiucCf9yThL9hfTLDDRNoKRou8t7CcfVSPxGtpZ
        Nznye0zsotQdpZsqicYirj3h2juRwBjqEN2kZ2G461Gd07VkkMM0j6GiDZC2+y7YeWBFLvIQb5i
        jl733VXzjYTtP3dg+3zBB7urHS76q
X-Received: by 2002:a05:600c:4e11:b0:3b4:91fd:d0c with SMTP id b17-20020a05600c4e1100b003b491fd0d0cmr11562111wmq.71.1663577006568;
        Mon, 19 Sep 2022 01:43:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6N7jj2hCArDkIS0hqCNfKGStr12fevzZwsYldSD36MylkUB8fFQzxSwsr4/3VsP5ZV8nEMQw==
X-Received: by 2002:a05:600c:4e11:b0:3b4:91fd:d0c with SMTP id b17-20020a05600c4e1100b003b491fd0d0cmr11562098wmq.71.1663577006284;
        Mon, 19 Sep 2022 01:43:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:c100:c136:f914:345f:f5f3? (p200300cbc703c100c136f914345ff5f3.dip0.t-ipconnect.de. [2003:cb:c703:c100:c136:f914:345f:f5f3])
        by smtp.gmail.com with ESMTPSA id h22-20020a05600c2cb600b003b4868eb71bsm14009883wmc.25.2022.09.19.01.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 01:43:25 -0700 (PDT)
Message-ID: <ebcaadb8-a698-b7ba-a11c-dbd2e379fdef@redhat.com>
Date:   Mon, 19 Sep 2022 10:43:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH -next v2 1/5] docs: notifier-error-inject: fix non-working
 usage of negative values
Content-Language: en-US
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        Zhao Gongyi <zhaogongyi@huawei.com>
Cc:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, osalvador@suse.de,
        shuah@kernel.org
References: <20220915085757.258608-1-zhaogongyi@huawei.com>
 <20220915085757.258608-2-zhaogongyi@huawei.com>
 <CAC5umyhUteOFg1Q+rxU01axu_Rt2gadTqi9NxLESiqNyLtHaZA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAC5umyhUteOFg1Q+rxU01axu_Rt2gadTqi9NxLESiqNyLtHaZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17.09.22 07:39, Akinobu Mita wrote:
> 2022年9月15日(木) 18:01 Zhao Gongyi <zhaogongyi@huawei.com>:
>>
>> Fault injection uses debugfs in a way that the provided values via
>> sysfs are interpreted as u64. Providing negative numbers results in
>> an error:
>>
>>    # cd sys/kernel/debug/notifier-error-inject/memory
>>    #  echo -12 > actions/MEM_GOING_ONLINE/error
>>    -bash: echo: write error: Invalid argument
>>
>> Update the docs and examples to use "printf %#x <val>" in these cases.
> 
> I'd rather fix the notifier-error-inject module than change the user interface.
> I'll send a patch, so could you check if that solves the problem.
> 

That will also make patch #2 unnecessary, correct?

-- 
Thanks,

David / dhildenb

