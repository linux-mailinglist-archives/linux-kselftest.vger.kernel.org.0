Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809B859D2C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 09:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241402AbiHWHzO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Aug 2022 03:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240307AbiHWHzL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Aug 2022 03:55:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1298A33343
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Aug 2022 00:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661241309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EIwZ7BoTfdMUAhH2fOQC6fOziS/YjfnIvgRTO5vTHto=;
        b=DyCI55PulUdOrmKB+WgGxp1BNPAeh4juvIPpeXCF87rXoNnLnpMySUbuwRhr2S0tj1ME19
        XoH2s5lhUgWm3ytjpdAK5bRJwjnYlJotPWAxLQCFL+JlZGmvCyohxuntZ48XyDsa5fE2YY
        haGZa/VSZ6I6oWfy2Vr9bHAQfLHmsYI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-607-gt4HGpGwPSq5z-4Y5JWr9g-1; Tue, 23 Aug 2022 03:55:07 -0400
X-MC-Unique: gt4HGpGwPSq5z-4Y5JWr9g-1
Received: by mail-wm1-f69.google.com with SMTP id h82-20020a1c2155000000b003a64d0510d9so2618516wmh.8
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Aug 2022 00:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=EIwZ7BoTfdMUAhH2fOQC6fOziS/YjfnIvgRTO5vTHto=;
        b=xDmk27uHJB0nAEO9s+FJw4qqFrwsiEGEdxXyf1xoWsyPluYLxlV0vRbmkQfA1e6WKO
         7P8MHHOYdKaWm3qhtZb4OfbYaSbTgfmEKdjUsnuCrBYaUyO1HRj4/mlBayaKVqK6aTD3
         eiVTw+7yzIGi5hzG8C3cM6v1GQEXvsyyJvZRF+tpyGCEV2izYTjoUUTT9ElDZ79V7rB2
         XdvbZw22NZIN9lu4ct54FSD41Uov9LKts096NCa0Xd57yD4Xg/enHbLqLkwhOKvdKPS+
         JnZpc59e/5mADTWMrymCdT8jMZmPHwuMRPeg5xt8rYBCww/ownPFqOB44GvsFZXYzNVO
         8y7A==
X-Gm-Message-State: ACgBeo1Q9tOZ5OO7u10y8xrjCorJykwdraTYrOJOpA5gxGcDVzPlS6/O
        P3JRNBcv+kj961RDYyMHM1xUOCaHmazU+GL9B6yRyqSZqkYmlNgZxSx8pR3lGK/W8483jDIYhCf
        K+kpMf3Fw9nN73bDnv+g3MyIQIkML
X-Received: by 2002:adf:f643:0:b0:225:2cb3:4b05 with SMTP id x3-20020adff643000000b002252cb34b05mr13203055wrp.12.1661241306643;
        Tue, 23 Aug 2022 00:55:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7QQcmZIjuOTP3rp/phaSR8BK9i2DfQ3gujUYj0ItGrG9WBrBV+POmli4zo4g6w/n8XuVdszg==
X-Received: by 2002:adf:f643:0:b0:225:2cb3:4b05 with SMTP id x3-20020adff643000000b002252cb34b05mr13203037wrp.12.1661241306387;
        Tue, 23 Aug 2022 00:55:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:1600:c48b:1fab:a330:5182? (p200300cbc70b1600c48b1faba3305182.dip0.t-ipconnect.de. [2003:cb:c70b:1600:c48b:1fab:a330:5182])
        by smtp.gmail.com with ESMTPSA id c9-20020a05600c100900b003a2f6367049sm16281074wmc.48.2022.08.23.00.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 00:55:05 -0700 (PDT)
Message-ID: <b2743a3a-a1b4-2d2e-98be-87b58ad387cf@redhat.com>
Date:   Tue, 23 Aug 2022 09:55:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        aarcange@redhat.com, ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <ff5c5b97-acdf-9745-ebe5-c6609dd6322e@google.com>
 <20220818132421.6xmjqduempmxnnu2@box> <Yv7XTON3MwuC1Q3U@google.com>
 <226ab26d-9aa8-dce2-c7f0-9e3f5b65b63@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
In-Reply-To: <226ab26d-9aa8-dce2-c7f0-9e3f5b65b63@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 19.08.22 05:38, Hugh Dickins wrote:
> On Fri, 19 Aug 2022, Sean Christopherson wrote:
>> On Thu, Aug 18, 2022, Kirill A . Shutemov wrote:
>>> On Wed, Aug 17, 2022 at 10:40:12PM -0700, Hugh Dickins wrote:
>>>> On Wed, 6 Jul 2022, Chao Peng wrote:
>>>> But since then, TDX in particular has forced an effort into preventing
>>>> (by flags, seals, notifiers) almost everything that makes it shmem/tmpfs.
>>>>
>>>> Are any of the shmem.c mods useful to existing users of shmem.c? No.
>>>> Is MFD_INACCESSIBLE useful or comprehensible to memfd_create() users? No.
>>
>> But QEMU and other VMMs are users of shmem and memfd.  The new features certainly
>> aren't useful for _all_ existing users, but I don't think it's fair to say that
>> they're not useful for _any_ existing users.
> 
> Okay, I stand corrected: there exist some users of memfd_create()
> who will also have use for "INACCESSIBLE" memory.

As raised in reply to the relevant patch, I'm not sure if we really have
to/want to expose MFD_INACCESSIBLE to user space. I feel like this is a
requirement of specific memfd_notifer (memfile_notifier) implementations
-- such as TDX that will convert the memory and MCE-kill the machine on
ordinary write access. We might be able to set/enforce this when
registering a notifier internally instead, and fail notifier
registration if a condition isn't met (e.g., existing mmap).

So I'd be curious, which other users of shmem/memfd would benefit from
(MMU)-"INACCESSIBLE" memory obtained via memfd_create()?

-- 
Thanks,

David / dhildenb

