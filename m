Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AC4760DFE
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 11:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGYJJu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 05:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGYJJt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 05:09:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FEF9B;
        Tue, 25 Jul 2023 02:09:48 -0700 (PDT)
Received: from [192.168.100.7] (unknown [59.103.217.18])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7AD6F6607108;
        Tue, 25 Jul 2023 10:09:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690276186;
        bh=XdNAqD8pBtuejUuQFT+jmKzDVpGQZBU3/DTPb3ihEmo=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=d7hVqBt3iuMHzYWfjG0CGNHi2ClrCmnXnBTsfB/r7HruJrbnSCqcl0i0Tg7QTfYQ6
         NEbT9Gf30FbGxTKFtJrrJQlSSubGDgkKQHQ+ORIjYELSwWMG2oVJnCUm62xTckCxFB
         jelQdGbUVo+0zxdWEwD895dvUagXZbyEbhEA3Aq6aEr0MVtd+tQ0D2fHTExwRtkTen
         wGVREO5J1I63LV0rUN4hVnwdt0kWyGDsnwbF8HM4sFeGVeFVwQzO9MYJU7epJWQan7
         Q9Bz2C8Y6/lcexEifufO2KP+gsE8uaxCCE00xg2rI5uasR2VO6ibEn8PUYe9IU+BdT
         1VecNbs2To1Ug==
Message-ID: <1afedab8-5929-61e5-b0da-9c70dc01c254@collabora.com>
Date:   Tue, 25 Jul 2023 14:09:32 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [v2] fs/proc/task_mmu: Implement IOCTL for efficient page table
 scanning
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
References: <20230713101415.108875-6-usama.anjum@collabora.com>
 <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
 <7eedf953-7cf6-c342-8fa8-b7626d69ab63@collabora.com>
 <ZLpqzcyo2ZMXwtm4@qmqm.qmqm.pl>
 <382f4435-2088-08ce-20e9-bc1a15050861@collabora.com>
 <ZLshsAj5PbsEAHhP@qmqm.qmqm.pl>
 <b1071d62-5c8e-1b03-d919-b3a9db520e51@collabora.com>
 <CABb0KFF6M2_94Ect72zMtaRLBpOoHjHYJA-Ube3oQAh4cXSg5w@mail.gmail.com>
 <44eddc7d-fd68-1595-7e4f-e196abe37311@collabora.com>
 <CABb0KFHJVeEkh4f6WWK6FThCbA+NE8iYUZE68nV1YAxaHwiwog@mail.gmail.com>
 <e1ead2e8-046a-31d9-8df9-27cdd7b7ff83@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <e1ead2e8-046a-31d9-8df9-27cdd7b7ff83@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/25/23 12:23 PM, Muhammad Usama Anjum wrote:
> On 7/24/23 9:10 PM, Michał Mirosław wrote:
> [...]>>>> @@ -2219,22 +2225,24 @@ static int pagemap_scan_get_args(struct
> pm_scan_arg
>>>>> *arg,
>>>>>              arg->category_anyof_mask | arg->return_mask) & ~PM_SCAN_CATEGORIES)
>>>>>                 return -EINVAL;
>>>>>
>>>>> -       start = untagged_addr((unsigned long)arg->start);
>>>>> -       end = untagged_addr((unsigned long)arg->end);
>>>>> -       vec = untagged_addr((unsigned long)arg->vec);
>>>>> +       arg->start = untagged_addr((unsigned long)arg->start);
>>>>> +       arg->end = untagged_addr((unsigned long)arg->end);
>>>>> +       arg->vec = untagged_addr((unsigned long)arg->vec);
>>>>
>>>> BTW, We should we keep the tag in args writeback().
>>> Sorry what?
>>> After this function, the start, end and vec would be used. We need to make
>>> sure that the address are untagged before that.
>>
>> We do write back the address the walk ended at to arg->start in
>> userspace. This pointer I think needs the tag reconstructed so that
>> retrying the ioctl() will be possible.
> Even if we reconstruct the tag for end and vec, We need to update the start
> address. Can we just put same tag as original start in it? I'm not sure.
The special users would use tags. If they are using it, they'll just re-add
the tag in next invocation. I think this implementation is correct.

> 

-- 
BR,
Muhammad Usama Anjum
