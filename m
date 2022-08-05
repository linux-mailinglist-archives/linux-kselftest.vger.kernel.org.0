Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228EF58AF85
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Aug 2022 20:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240682AbiHESGL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Aug 2022 14:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiHESGK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Aug 2022 14:06:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E49FC74E08
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Aug 2022 11:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659722768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gTG5sYKz5wYWpj0OuPtAuT0vzoUTMIRW2UW4E5SQLSQ=;
        b=EqtatFDulK1RwYEUXVMucgeZtcmVXqtT8a4mf7nysaZnENR/B78tcR/PjnyTpZs7euqc4r
        /xsrR39d50VVRXAPVuQ+Fry6vuDwWyRKOM9Nc8HfsLjvPZQjxweQffVfEiqPz5dhr2xZqE
        oFEPcIKVnFDX4tLmD5mv3ASVCl9MFrw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-Cxoia1AONoW-H59y4o3Y-Q-1; Fri, 05 Aug 2022 14:06:06 -0400
X-MC-Unique: Cxoia1AONoW-H59y4o3Y-Q-1
Received: by mail-wm1-f71.google.com with SMTP id n30-20020a05600c501e00b003a3264465ebso3575672wmr.1
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Aug 2022 11:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=gTG5sYKz5wYWpj0OuPtAuT0vzoUTMIRW2UW4E5SQLSQ=;
        b=wWd50yLgavyIvGK84p8pxGTmFR5d8R1DY8v+f60WHkKzHHoxtzwx5h1lNww1IgAKmT
         rEDMUJdBIixzC2UV2iqsjIanGrqFPq/+02qLCjYh0xfDOTUYfgktgH5NwiDT9JKHPQo5
         vX7ShTx8UvhB1IcW1rmORArhT7120rnHsHk09TP33kTMoLE+CWTIAa7+9MOqMnwJiXXn
         S/N9lm0+a+qZ809d1YLgGl3LP1fGxCEg6kh22mAxJAqwy9ldW+a+v84Ty+HHOlb1g96T
         08php2kQ3bSIZCR86eamqzi0UuxZ3S/82w3bMKgu9SRr6aRsdIi9W7dQMonHRGUdJePh
         8mgw==
X-Gm-Message-State: ACgBeo3FJ8DcxrAgwOryySoOvvdKkcrw6mwfPeRgRFiq0m2K0wLdvieC
        VZKnIz+AB1+InM9uNM4uol9r5uPM6fEa2430lY+B7mNx8L6kPa8Q/IMEWFE1mbpN6JGx7Zgfvql
        WY2pEkSxz2RUFpaMce+N5t0nNtfSn
X-Received: by 2002:a05:6000:811:b0:220:6262:ac66 with SMTP id bt17-20020a056000081100b002206262ac66mr4741197wrb.529.1659722765758;
        Fri, 05 Aug 2022 11:06:05 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4YiYJd4RGqr8HPcVnnEu37Kzz2xizPBJ/DFAoYEPdnVgyVJMfvEXwBl3Yrl6juKrdXAyBEpQ==
X-Received: by 2002:a05:6000:811:b0:220:6262:ac66 with SMTP id bt17-20020a056000081100b002206262ac66mr4741186wrb.529.1659722765470;
        Fri, 05 Aug 2022 11:06:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:fb00:f5c3:24b2:3d03:9d52? (p200300cbc706fb00f5c324b23d039d52.dip0.t-ipconnect.de. [2003:cb:c706:fb00:f5c3:24b2:3d03:9d52])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c190600b003a31b79dc0esm26070221wmq.1.2022.08.05.11.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 11:06:05 -0700 (PDT)
Message-ID: <a2b8fa73-4efd-426f-abcd-7975ff9a7101@redhat.com>
Date:   Fri, 5 Aug 2022 20:06:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 01/14] mm: Add F_SEAL_AUTO_ALLOCATE seal to memfd
Content-Language: en-US
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-2-chao.p.peng@linux.intel.com>
 <f39c4f63-a511-4beb-b3a4-66589ddb5475@redhat.com>
 <472207cf-ff71-563b-7b66-0c7bea9ea8ad@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <472207cf-ff71-563b-7b66-0c7bea9ea8ad@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 05.08.22 19:55, Paolo Bonzini wrote:
> On 7/21/22 11:44, David Hildenbrand wrote:
>>
>> Also, I*think*  you can place pages via userfaultfd into shmem. Not
>> sure if that would count "auto alloc", but it would certainly bypass
>> fallocate().
> 
> Yeah, userfaultfd_register would probably have to forbid this for 
> F_SEAL_AUTO_ALLOCATE vmas.  Maybe the memfile_node can be reused for 
> this, adding a new MEMFILE_F_NO_AUTO_ALLOCATE flags?  Then 
> userfault_register would do something like 
> memfile_node_get_flags(vma->vm_file) and check the result.

An alternative is to simply have the shmem allocation fail in a similar
way. Maybe it does already, I haven't checked (don't think so).


-- 
Thanks,

David / dhildenb

