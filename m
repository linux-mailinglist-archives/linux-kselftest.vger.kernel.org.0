Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F54F50E9DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 22:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245120AbiDYUGT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 16:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245107AbiDYUGN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 16:06:13 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39B2128CCD
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 13:03:07 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id r17so10077910iln.9
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 13:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6IUFVGvfVxw7l6YMhU424l8XqBpC7fGs6gju1QrjU6I=;
        b=b3u4xyXqePElE6uzOsARKY8+PI4TX3Kfwz1v+pt+aDBG6YYxf8B4BFF122dVgsWa0G
         wTroXZKBEgXygfLWgFZ6duEffBwEcqbKlxo2oXvU6f5+c465slS+cKlD6utjJ9VRtGKz
         E23GQlTrmCfcHJ2Lo22SWt5mHhkrQ8ecf4i5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6IUFVGvfVxw7l6YMhU424l8XqBpC7fGs6gju1QrjU6I=;
        b=sLVDM2F1T1wY4Yj8LL7/aJ5+BLYgqFGJQldAEz34QQpq+TNzkVwCbXtHmoMeuSmDRE
         ZvtITiTgvm8OmfyLzBvufv/VMtWpivjFESDjsU9FrXgJQbGwJifh8tIQa265zpfrX5yz
         1EJA+x+NdWZgv2IHA8rVZdESJ5Fgm58QLlnam+szw3TfV6UXXD7HW7QJTsvelhNNiZxm
         oCgJCEb0xjYuQlXdBKx1I56O+m4+HLsdWba0egVogxLsXLUZl8vQvaQXHPO32G9Fd/IB
         32QnKY2RbBmudOC1sVan4f+ZN1iOPfleIXxOKL4gs3Nd3WUSUPbr0nmNLnthEJn0MnQE
         FdAg==
X-Gm-Message-State: AOAM532M01Y44Au49u9G3x9v8wAWwKnHeL/2Ts0Y9l/axXmyFDh6EPh6
        Us0wD9MkXqqA4pwLglbRmHZ6VA==
X-Google-Smtp-Source: ABdhPJz7jabMcQMahAgzEB+tpsiYw2q8m1KcTY1nfihf3Zk6kiyb14v45rF0wOE1m6bpHahdMHyESw==
X-Received: by 2002:a05:6e02:190c:b0:2cd:9331:2750 with SMTP id w12-20020a056e02190c00b002cd93312750mr3026582ilu.214.1650916987125;
        Mon, 25 Apr 2022 13:03:07 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id s8-20020a056e021a0800b002cd8179e7a0sm5202881ild.16.2022.04.25.13.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 13:03:06 -0700 (PDT)
Subject: Re: [PATCH RESEND] selftests/damon: add damon to selftests root
 Makefile
To:     Yuanchu Xie <yuanchu@google.com>, SeongJae Park <sj@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Markus Boehme <markubo@amazon.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Rientjes <rientjes@google.com>
References: <20220418202017.3583638-1-yuanchu@google.com>
 <93c3f9b4-7e14-858b-bf6c-23e4f3bec232@google.com>
 <31edb348-d802-0ee5-c13d-a9ef17b2ea8a@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f6cc50f0-318f-097f-af13-271a2fb4d645@linuxfoundation.org>
Date:   Mon, 25 Apr 2022 14:03:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <31edb348-d802-0ee5-c13d-a9ef17b2ea8a@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/25/22 1:37 PM, Shuah Khan wrote:
> On 4/24/22 1:35 PM, David Rientjes wrote:
>> On Mon, 18 Apr 2022, Yuanchu Xie wrote:
>>
>>> Currently the damon selftests are not built with the rest of the
>>> selftests. We add damon to the list of targets.
>>>
>>> Fixes: b348eb7abd09 ("mm/damon: add user space selftests")
>>> Reviewed-by: SeongJae Park <sj@kernel.org>
>>> Signed-off-by: Yuanchu Xie <yuanchu@google.com>
>>
>> Acked-by: David Rientjes <rientjes@google.com>
>>
> 
> Thank you. Applied to linux-kselftest next for 5.19-rc1.
> 

The test builds with warnings. Would you like to fix these as
well?

make
gcc     huge_count_read_write.c  -o linux_5.18/tools/testing/selftests/damon/huge_count_read_write
huge_count_read_write.c: In function ‘write_read_with_huge_count’:
huge_count_read_write.c:23:9: warning: ‘write’ reading 4294967295 bytes from a region of size 1 [-Wstringop-overread]
    23 |         write(filedesc, "", 0xfffffffful);
       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from huge_count_read_write.c:8:
/usr/include/unistd.h:378:16: note: in a call to function ‘write’ declared with attribute ‘access (read_only, 2, 3)’
   378 | extern ssize_t write (int __fd, const void *__buf, size_t __n) __wur
       |                ^~~~~
huge_count_read_write.c:25:15: warning: ‘read’ writing 4294967295 bytes into a region of size 25 overflows the destination [-Wstringop-overflow=]
    25 |         ret = read(filedesc, buf, 0xfffffffful);
       |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
huge_count_read_write.c:14:14: note: destination object ‘buf’ of size 25
    14 |         char buf[25];
       |              ^~~
In file included from huge_count_read_write.c:8:
/usr/include/unistd.h:371:16: note: in a call to function ‘read’ declared with attribute ‘access (write_only, 2, 3)’
   371 | extern ssize_t read (int __fd, void *__buf, size_t __nbytes) __wur
       |                ^~~~

thanks,
-- Shuah
