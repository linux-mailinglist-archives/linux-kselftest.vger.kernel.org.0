Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AE17C683A
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Oct 2023 10:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbjJLIRj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 04:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjJLIRi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 04:17:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29F698;
        Thu, 12 Oct 2023 01:17:36 -0700 (PDT)
Received: from [192.168.100.7] (unknown [59.103.217.136])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EE52D6607341;
        Thu, 12 Oct 2023 09:17:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697098655;
        bh=vTyt7TX3DQPFdic8eB59rza9v8LPVCGALn0DN3U7wgU=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=mRXVtGmXf2LRNZ9ly0IQErkYho8It0SyLVNULBWfzX0YFL1W2hY/yg2lSAn+/55zT
         N24wZrYkKYycpSXYUc7GgPIShtLF6hpN85bG2QtUiZftzg6hTR00z/G62cY0R6tYm2
         PIQBMzcKgbaPiMzM1QukZTki9x7n7tHV24I1trzXvqSfcOliqvitWRH7oy0bf7GjPs
         AIH9LqcgzcDyTUgu3WXM5IuycqyMAPO5npLsvssEl1rzlokWBlKem6IbjQV1OpKfjP
         Do+bW3xd8H17elg8y/Ak7MEYyECN9sYIvQRG2KY+ZzBN/EHfx9SFDhM4ScZvL27N+l
         xjebSRrsBx3vQ==
Message-ID: <018dfa44-785c-403a-a085-c13ee73933df@collabora.com>
Date:   Thu, 12 Oct 2023 13:17:27 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] selftests/mm: include mman header to access
 MREMAP_DONTUNMAP identifier
Content-Language: en-US
To:     Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
        akpm@linux-foundation.org, shuah@kernel.org
References: <20231012064048.433346-1-samasth.norway.ananda@oracle.com>
 <3be75492-36e7-4ffe-ab0e-ef583b801af1@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <3be75492-36e7-4ffe-ab0e-ef583b801af1@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/12/23 1:06 PM, Muhammad Usama Anjum wrote:
> On 10/12/23 11:40 AM, Samasth Norway Ananda wrote:
>> Definition for MREMAP_DONTUNMAP not present in the selftest for
>> mremap_dontunmap thus throwing an undeclared error when running make
>> on mm.
> Thanks for sending the patch.
> 
> You have mentioned in other email that MREMAP_DONTUNMAP isn't present in
> glibc older than 2.32. So including linux/mman.h solves the build error for
> people having older glibc. Please add this to the description of the patch
> to give the exact reason this patch should be accepted.
> 
>>
>> Fixes: 0183d777c29a ("selftests: mm: remove duplicate unneeded defines")
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>> Closes: https://lore.kernel.org/linux-mm/CA+G9fYvV-71XqpCr_jhdDfEtN701fBdG3q+=bafaZiGwUXy_aA@mail.gmail.com/
>> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
>> ---
>>  tools/testing/selftests/mm/mremap_dontunmap.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/mm/mremap_dontunmap.c b/tools/testing/selftests/mm/mremap_dontunmap.c
>> index ca2359835e75..a06e73ec8568 100644
>> --- a/tools/testing/selftests/mm/mremap_dontunmap.c
>> +++ b/tools/testing/selftests/mm/mremap_dontunmap.c
>> @@ -7,6 +7,7 @@
>>   */
>>  #define _GNU_SOURCE
>>  #include <sys/mman.h>
>> +#include <linux/mman.h>
>>  #include <errno.h>
>>  #include <stdio.h>
>>  #include <stdlib.h>
> Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Just to add more context, the build error doesn't trigger on latest glibc.
I've tested building this test with glic 2.31 and there is build error.
This patch fixes the build error.

> 

-- 
BR,
Muhammad Usama Anjum
