Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC5F5BCA3E
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Sep 2022 13:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiISLFn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Sep 2022 07:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiISLFh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Sep 2022 07:05:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E286FBC89
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Sep 2022 04:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663585528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IulqkCtEaGt099GbXE/BHeOG0mRKOudTYkQ9exTVP/g=;
        b=Rzgpec3nxF2pp+TRGKk4NLGjSMlXSVSVDumQyUyBkUdVFJpZqdjzSmQ0LA5vvbQtnVZG0P
        DbZBrtmLF2LKC31lj+s1Z+RQ1i5pC6sdWJyOo2bpihwtyE0rdjuP0HsPXB1y8nKWu8Kw/H
        01LL9yFPN6+qiPav5avN5QfLv3FlJ8I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-220-OT2uuESSPpiVnrv8XLZaIw-1; Mon, 19 Sep 2022 07:05:27 -0400
X-MC-Unique: OT2uuESSPpiVnrv8XLZaIw-1
Received: by mail-wr1-f70.google.com with SMTP id o7-20020adfba07000000b00228663f217fso5745368wrg.20
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Sep 2022 04:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=IulqkCtEaGt099GbXE/BHeOG0mRKOudTYkQ9exTVP/g=;
        b=5Cy25e+RxV0aQKugRwjVqpukNj8ZMsx8Rr2VuVc8Dm5KxnE5iVfTd8OTz+5hVHb1CI
         yyNNCxHC6VFnqjNmCgD/PPNRYfyLsM4nOqNc5Pm+CyTQrvmhnBRPs94Ttwg2fG5caqGz
         QM+KYfJuYZj8oZfHubAWAjzLQsX7kWzPopCOsAwdHAmBMaWR25IvSNsPd7ImWrjnQPBV
         Y4/9deZ/9EeDhCYLYZAJVhug6ouFgZ8RUsLSPsYC8aabM14DGg97RES9iEwNIB820hy4
         MyZlqMghYfGQspHMgwq69cPzsncxv2A0tLMdij6rB/hjFmPEYN83GAxraV35aevev8fK
         9juQ==
X-Gm-Message-State: ACrzQf2rk4TjtchrDZlhS+GfOAEyq0i2YZKxAa3YnNPtGLN0wBdI1ynI
        F02WHXDUDxTr7MSIXDMcepbhmfGVtBOFI1jvKaIdaLk6Lgxvlq1bI8sZx24OWx+YdUZPBaqpR7s
        mtR6sIJTwf4XIFnf1lEpyu9gwlAyl
X-Received: by 2002:a05:6000:114b:b0:228:ab76:fa00 with SMTP id d11-20020a056000114b00b00228ab76fa00mr10087454wrx.628.1663585526745;
        Mon, 19 Sep 2022 04:05:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM57vq8QjEFjVNsIk+CislbvrnvNW7MFRM57slGULMzKF0ghTms9waLzTbyAJnL91m2L8CeC3Q==
X-Received: by 2002:a05:6000:114b:b0:228:ab76:fa00 with SMTP id d11-20020a056000114b00b00228ab76fa00mr10087440wrx.628.1663585526436;
        Mon, 19 Sep 2022 04:05:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:c100:c136:f914:345f:f5f3? (p200300cbc703c100c136f914345ff5f3.dip0.t-ipconnect.de. [2003:cb:c703:c100:c136:f914:345f:f5f3])
        by smtp.gmail.com with ESMTPSA id bx26-20020a5d5b1a000000b0022afcc11f65sm3939718wrb.47.2022.09.19.04.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 04:05:25 -0700 (PDT)
Message-ID: <93339a97-ea08-0880-b0cf-e5270179079a@redhat.com>
Date:   Mon, 19 Sep 2022 13:05:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH -next v2 1/5] docs: notifier-error-inject: fix non-working
 usage of negative values
Content-Language: en-US
To:     zhaogongyi <zhaogongyi@huawei.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "shuah@kernel.org" <shuah@kernel.org>
References: <076b1f2a38ab4ca4a61e6a79c765bcba@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <076b1f2a38ab4ca4a61e6a79c765bcba@huawei.com>
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

On 19.09.22 11:01, zhaogongyi wrote:
> Hi!
> 
>>
>> On 17.09.22 07:39, Akinobu Mita wrote:
>>> 2022年9月15日(木) 18:01 Zhao Gongyi <zhaogongyi@huawei.com>:
>>>>
>>>> Fault injection uses debugfs in a way that the provided values via
>>>> sysfs are interpreted as u64. Providing negative numbers results in
>>>> an error:
>>>>
>>>>     # cd sys/kernel/debug/notifier-error-inject/memory
>>>>     #  echo -12 > actions/MEM_GOING_ONLINE/error
>>>>     -bash: echo: write error: Invalid argument
>>>>
>>>> Update the docs and examples to use "printf %#x <val>" in these cases.
>>>
>>> I'd rather fix the notifier-error-inject module than change the user
>> interface.
>>> I'll send a patch, so could you check if that solves the problem.
>>>
>>
>> That will also make patch #2 unnecessary, correct?
> 
> Yes. But there is another commit 005747526d4f3c2ec995891e95cb7625161022f9 that has the same problem.
> 
> Thanks!

Right. See my reply to the other patch:

https://lkml.kernel.org/r/93c044ca-7d2f-e23f-8eb4-72c133737a15@redhat.com

simple_attr_read()/simple_attr_write() fmt behavior is odd.

-- 
Thanks,

David / dhildenb

