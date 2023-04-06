Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE7B6D8D25
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 04:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjDFCBr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Apr 2023 22:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDFCBp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Apr 2023 22:01:45 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6531549CA;
        Wed,  5 Apr 2023 19:01:43 -0700 (PDT)
X-UUID: 6087444942d642b198feddb737f80198-20230406
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:8d61358a-9d42-4073-a308-50cb367fedf9,IP:5,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-4
X-CID-INFO: VERSION:1.1.22,REQID:8d61358a-9d42-4073-a308-50cb367fedf9,IP:5,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-4
X-CID-META: VersionHash:120426c,CLOUDID:5389e3f7-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:230404153214E4ZTVHD4,BulkQuantity:2,Recheck:0,SF:38|24|17|19|44|102,
        TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 6087444942d642b198feddb737f80198-20230406
X-User: jiangfeng@kylinos.cn
Received: from [172.20.12.214] [(116.128.244.169)] by mailgw
        (envelope-from <jiangfeng@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
        with ESMTP id 1536921828; Thu, 06 Apr 2023 10:01:35 +0800
Message-ID: <6e74d3f5-b792-7576-2340-fb4d67490a6b@kylinos.cn>
Date:   Thu, 6 Apr 2023 10:01:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] selftests/mm: fix memory leak in child_memcmp_fn
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Xie <xieming@kylinos.cn>
References: <20230404031234.78272-1-jiangfeng@kylinos.cn>
 <5c415fa5-1637-883d-8136-fc4280274406@redhat.com>
From:   Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <5c415fa5-1637-883d-8136-fc4280274406@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/4/4 15:31, David Hildenbrand wrote:
> On 04.04.23 05:12, Feng Jiang wrote:
>> The allocated memory should be freed on return.
>>
>> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
>> Suggested-by: Ming Xie <xieming@kylinos.cn>
>> ---
>>   tools/testing/selftests/mm/cow.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/mm/cow.c 
>> b/tools/testing/selftests/mm/cow.c
>> index 0eb2e8180aa5..c0dd2dfca51b 100644
>> --- a/tools/testing/selftests/mm/cow.c
>> +++ b/tools/testing/selftests/mm/cow.c
>> @@ -162,6 +162,10 @@ static int child_memcmp_fn(char *mem, size_t size,
>>   {
>>       char *old = malloc(size);
>>       char buf;
>> +    int ret;
>> +
>> +    if (!old)
>> +        return -ENOMEM;
>>         /* Backup the original content. */
>>       memcpy(old, mem, size);
>> @@ -172,7 +176,10 @@ static int child_memcmp_fn(char *mem, size_t size,
>>           ;
>>         /* See if we still read the old values. */
>> -    return memcmp(old, mem, size);
>> +    ret = memcmp(old, mem, size);
>> +    free(old);
>> +
>> +    return ret;
>>   }
>>     static int child_vmsplice_memcmp_fn(char *mem, size_t size,
>
> NAK, the whole point of this function is that the child process will 
> exit immediately after executing this function, cleaning up 
> automatically.
>
Hi David, thanks very much for your review and I think you are right.

While the OS provides a cleanup mechanism to underwrite this, I think it 
makes sense for the application to ensure that its own logic is complete 
and correct.

