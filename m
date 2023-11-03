Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F9F7E033F
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Nov 2023 14:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjKCNAX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Nov 2023 09:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKCNAW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Nov 2023 09:00:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14747111
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Nov 2023 05:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699016373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=qGvxE1TdNLz4iTVDTpQ4IJBdvLBoFmJbY/H0N64mqPQ=;
        b=Woe4l9GXVUntfIIMgqTHlq7NJErmG2WYOp0ISVR3Z4g+AReaOWUsdJKAg3JMgbSEszijOV
        s2AvZAnUpLqFZmcB8zjFx/MBkD8lbtk6X/AuLUhWlbU62+N3Fo/+9l3R0yok3kklG0BYr5
        mMZsJaBYLhxXNPmzbWReak7gL5T3bMk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-2uz0lDdgPaqleyQL3OkecQ-1; Fri, 03 Nov 2023 08:59:31 -0400
X-MC-Unique: 2uz0lDdgPaqleyQL3OkecQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-32d9751ca2cso926154f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Nov 2023 05:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699016370; x=1699621170;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGvxE1TdNLz4iTVDTpQ4IJBdvLBoFmJbY/H0N64mqPQ=;
        b=GGP0tV5q5AOElmo5zv61DNNmDMQdjXTP9+LcVB5Gdw39lCI6RgZ9FbaBbCSlUXw4A+
         PisQ4AxRiBMPDVuh2F3AFOyxQviNd2JljmUYVqbEnSieB+Xt6jHKsNpUQchvySYp/Y6r
         DUZbyj9Zh2eHYYVZXxVf+2VX4SUibn7/uWLejnaLRMNvWe8NPDlpkf5VSjXYdUyqfF7U
         ELLJjNytj8excZ/20ICImLpCMxt1a/ydDtBxSU2LSYDYXuIFBnXPJNSFQTHkVDzkAGO4
         nt0goRbcM0NQnnSDJ6uf6ka+cUC3+3IJ/94F423vayS40Tgp8hUSWUz5eT6HJID6IjmN
         MhQg==
X-Gm-Message-State: AOJu0YzN6HDwhU1r1hKsFBEFAj9Ze3i6KVHwY/0xJm9m2Q8qhffBldfO
        iLB1vM5oDfFolXSmPJu9oiQmdicN2tj2y6T263RwOnNC+XCOtI66n5CHqWLIu6BHMfhChduXqUz
        WA8Z5t9QiWGIh5FYBTMI9YVWwHaRV
X-Received: by 2002:adf:d1ed:0:b0:32f:810e:8a3f with SMTP id g13-20020adfd1ed000000b0032f810e8a3fmr16714950wrd.14.1699016370649;
        Fri, 03 Nov 2023 05:59:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyBS6Z00CC8vwD2VjTJLhG+y55gMeontkOP+IPGK1FAnt0REikOBq2K+D/yLhaFXGK4BHSoA==
X-Received: by 2002:adf:d1ed:0:b0:32f:810e:8a3f with SMTP id g13-20020adfd1ed000000b0032f810e8a3fmr16714925wrd.14.1699016370211;
        Fri, 03 Nov 2023 05:59:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:a600:bc48:cd31:d01f:f468? (p200300cbc70aa600bc48cd31d01ff468.dip0.t-ipconnect.de. [2003:cb:c70a:a600:bc48:cd31:d01f:f468])
        by smtp.gmail.com with ESMTPSA id j5-20020adfe505000000b0031fd849e797sm1398010wrm.105.2023.11.03.05.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 05:59:29 -0700 (PDT)
Message-ID: <15ff806d-59ab-46ab-8891-05ab917a1528@redhat.com>
Date:   Fri, 3 Nov 2023 13:59:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] selftests: error out if kernel header files are
 not yet built
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20230606071637.267103-1-jhubbard@nvidia.com>
 <20230606071637.267103-12-jhubbard@nvidia.com>
 <20231103121652.GA6217@noisy.programming.kicks-ass.net>
 <a002f903-723f-40ae-8d7a-421ab2e082e2@redhat.com>
 <20231103124606.GB8262@noisy.programming.kicks-ass.net>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231103124606.GB8262@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 03.11.23 13:46, Peter Zijlstra wrote:
> On Fri, Nov 03, 2023 at 01:22:54PM +0100, David Hildenbrand wrote:
>> On 03.11.23 13:16, Peter Zijlstra wrote:
>>> On Tue, Jun 06, 2023 at 12:16:37AM -0700, John Hubbard wrote:
>>>> As per a discussion with Muhammad Usama Anjum [1], the following is how
>>>> one is supposed to build selftests:
>>>>
>>>>       make headers && make -C tools/testing/selftests/mm
>>>>
>>>> Change the selftest build system's lib.mk to fail out with a helpful
>>>> message if that prerequisite "make headers" has not been done yet.
>>>>
>>>
>>> NAK NAK NAK
>>>
>>> This now means I can no longer run selftests, I thank you very much! :-/
>>>
>>> root@spr:/usr/src/linux-2.6# make O=defconfig-build/ -j64
>>> make[1]: Entering directory '/usr/src/linux-2.6/defconfig-build'
>>> ***
>>> *** The source tree is not clean, please run 'make mrproper'
>>> *** in /usr/src/linux-2.6
>>>
>>>
>>> I've always done:
>>>
>>>     cd tools/testing/selftests/x86; make
>>>
>>> and that has always worked
>>>
>>> Now I can't bloody well build *any* selftest or risk not being able to
>>> do builds.
>>
>> This change landed in 6.5, no? And 6.6 was just released. Just curious why
>> you notice that now.
> 
> Dunno, last time I edited the selftests and needed to recompile was a
> few weeks ago.

Okay. the question is if your workflow can be easily adjusted, or if we 
can improve that header handling as a whole.

The problem I had with this recently: just because we did a "make 
headers" once in a git tree doesn't mean that it is still up-to-date.

So once some selftest changes showed up that require newer headers, 
building the selftests again fails without a hint that another round of 
"make headers" would be required.

-- 
Cheers,

David / dhildenb

