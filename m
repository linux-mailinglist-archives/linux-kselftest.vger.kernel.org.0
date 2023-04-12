Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734AE6DF0EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 11:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjDLJtO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 05:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjDLJtG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 05:49:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E882D77
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 02:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681292899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q5VF2Wz5b80hlOD5M0oVoyLk3sVN8nriejQU685ncfA=;
        b=QjYN42oEQ+LL+8CQbQN9x8NhQtdyOCii3NpjB8tuWd3siqpZ141xlXWbV2j/vPDHxdknua
        05U717VH9u9JmkrzsV7klzAWK46wngY0EscrCGzuAgkq+RKO/C0BWxVKhrsw4ONgAsumrk
        Y5k5dX9Zet9ETzwa0jJ33nDzEnjdq+g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-ilKc-BEEOL23fN6GuV5ioA-1; Wed, 12 Apr 2023 05:48:18 -0400
X-MC-Unique: ilKc-BEEOL23fN6GuV5ioA-1
Received: by mail-wm1-f70.google.com with SMTP id h8-20020a05600c314800b003ef649aa8c7so2465326wmo.6
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 02:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681292897; x=1683884897;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5VF2Wz5b80hlOD5M0oVoyLk3sVN8nriejQU685ncfA=;
        b=vlbT/Gd20Z0mGyvy1YdTxjR9lWKAMJIrdOhpVLO6R87xNyHid9AqgzDAqxGUM6LSE8
         7eh3Pn65rrYhmXe1bzcCfd8ZmWXNeyQnoErFvV+oNC2Gcy+THGigkg+i+4UMV8iehCGc
         7K6MCWaDk2ScmJeUzccnAJb5W4mDZfdwX3kkzLLlmtHUB8GjMCzB1ruGZq6Nl5KfQajq
         3E5dwN08PXc7fMadSpaucCjB9v2L75u9i6BE0lqD6MDJTbQFxCXR+dqxb2SJw++fnfOB
         kqIq2ZUBI+WagThWX6Q/9rJezvtdldGatr7RpkHFR3+tGQ6S+vfMSVS6BpoNqaps7ADA
         TicA==
X-Gm-Message-State: AAQBX9eDj+hukxHADsaREtSwxXYRJhC1sJhOG7lacQbYR8lZIGxDyVKI
        HrUfSxJfNVGzE+lFVBmIaoqJdjlRgW2+QEKPgSQBJccSrdCw627T5aCMvHTZpyl3GWTo5/1n7VD
        V3ax3VvxFii9LO2yWNe/fE1Z0mFMV
X-Received: by 2002:a5d:5682:0:b0:2ef:bbc3:8936 with SMTP id f2-20020a5d5682000000b002efbbc38936mr1593896wrv.40.1681292897711;
        Wed, 12 Apr 2023 02:48:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350aZsiU/uaiPPlC1QybmMrBuigRUyz3mJFz3Bo+72gG1fF1Ill/BaB4OTOK2QwUD+JU828v8KA==
X-Received: by 2002:a5d:5682:0:b0:2ef:bbc3:8936 with SMTP id f2-20020a5d5682000000b002efbbc38936mr1593867wrv.40.1681292897342;
        Wed, 12 Apr 2023 02:48:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4b00:c6fa:b613:dbdc:ab? (p200300cbc7024b00c6fab613dbdc00ab.dip0.t-ipconnect.de. [2003:cb:c702:4b00:c6fa:b613:dbdc:ab])
        by smtp.gmail.com with ESMTPSA id j12-20020a5d604c000000b002efb5f0cf44sm12355603wrt.3.2023.04.12.02.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 02:48:16 -0700 (PDT)
Message-ID: <de93ddc4-29ff-6113-a146-bc278dcce5f9@redhat.com>
Date:   Wed, 12 Apr 2023 11:48:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 RESEND 3/6] sparc/mm: don't unconditionally set HW
 writable bit when setting PTE dirty on 64bit
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20230411142512.438404-1-david@redhat.com>
 <20230411142512.438404-4-david@redhat.com>
 <20230411193548.GA2094947@ravnborg.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230411193548.GA2094947@ravnborg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[...]

>> Let's fix the remaining issues and prepare for reverting the workarounds
>> by setting the HW writable bit only if both, the SW dirty bit and the SW
>> writable bit are set.
>>
>> We have to move pte_dirty() and pte_dirty() up. The code patching
> One of the pte_dirty() should be replaced with pte_write().
> 

Indeed, thanks. I assume Andrew can change the latter to pte_write(). 
[unless I have to resend, of course]

> It would have been nice to separate moving and changes in two patches,
> but keeping it together works too.

I prefer to not have "move code within the same file around" in separate 
patches as long as it doesn't add too much noise. Here, I think it's 
acceptable.

> 
> 
>> mechanism and handling constants > 22bit is a bit special on sparc64.
>>
>> The ASM logic in pte_mkdirty() and pte_mkwrite() match the logic in
>> pte_mkold() to create the mask depending on the machine type. The ASM
>> logic in __pte_mkhwwrite() matches the logic in pte_present(), just
>> using an "or" instead of an "and" instruction.
>>
>> With this commit (sun4u in QEMU):
>> 	root@debian:~/linux/tools/testing/selftests/mm# ./mkdirty
>> 	# [INFO] detected THP size: 8192 KiB
>> 	TAP version 13
>> 	1..6
>> 	# [INFO] PTRACE write access
>> 	ok 1 SIGSEGV generated, page not modified
>> 	# [INFO] PTRACE write access to THP
>> 	ok 2 SIGSEGV generated, page not modified
>> 	# [INFO] Page migration
>> 	ok 3 SIGSEGV generated, page not modified
>> 	# [INFO] Page migration of THP
>> 	ok 4 SIGSEGV generated, page not modified
>> 	# [INFO] PTE-mapping a THP
>> 	ok 5 SIGSEGV generated, page not modified
>> 	# [INFO] UFFDIO_COPY
>> 	ok 6 SIGSEGV generated, page not modified
>> 	# Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
> Nice!
> 
>>
>> This handling seems to have been in place forever.
>>
>> [1] https://lkml.kernel.org/r/533a7c3d-3a48-b16b-b421-6e8386e0b142@redhat.com
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> I tried to follow your changes, but my knowledge of gcc assembler failed
> me. But based on the nice and detailed change log and the code I managed
> to understand:
> Acked-by: Sam Ravnborg <sam@ravnborg.org>


Thanks Sam!

-- 
Thanks,

David / dhildenb

