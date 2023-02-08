Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6D568F183
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Feb 2023 16:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjBHPBA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 10:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjBHPA6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 10:00:58 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047D22BF00
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Feb 2023 07:00:58 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id k13so19590959plg.0
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Feb 2023 07:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9oflZ6zNlZVw9EmQqtsymlsndLRnz7qdnW4kcU4XhjM=;
        b=TyTWS/m7Pe2sYVsfIBwR88tdeTexgn+w18bj2jrQWwl0SQF29dkYshlSrsV/RQ8eOf
         xOJ2oFUZxpUeJJGxZgJ86tMlRl4iHU9nCb0FPsYcQkABj007u2lqUSug07Yx4eXQKHdT
         UDizQVJZy6FaeFNJCSOJH8vp8pB/shodMkYWrWIaopfsQp6zZsGYacJkWZqPILAeZNN9
         gGciY+60JeeiSbkUnIX+LRKlxwQD4t3JOAhbe2TwwSgFjZFOG2BX7PJokbnTEOIDkRyE
         bqIbo4Qn2FSkf+Cy1wc/VVk8TjwRhk6vGj9HgMzbjINIwLN+KXVU4cLJriEgaNAgcnpx
         fX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oflZ6zNlZVw9EmQqtsymlsndLRnz7qdnW4kcU4XhjM=;
        b=Z10VtHgahNwGsQSqzWnhS+N18Hxg4D5FvCcaPhKA6piQGy6KEbprWUVxx6YvMbxjeZ
         vTb/yqMOjTTDkG1TQHiyu268ez+uBOyPM6DEAoFQPgBHmCS+zio4PO4W3DiTN9+2Uhem
         v+fv40qHy6DwWBQtMLSnQJJcKHzdqeEGHaPf1Me+4HL/rWbUdcOm8TKLvfebIT5jqeCu
         Y9DngHoRTBwg5YZlUr4spOeldA0QfCekOiwd9rhzCJeqMXXvvKqHJFNwhsmlGDrfQzd/
         3PUZ2AC1l1kVWYzzGnVBxFcC+uQT2Jdo4HDI+THbwyeViC4G/gl8qQKBBCdgz6dBIi9C
         7SbA==
X-Gm-Message-State: AO0yUKVlhWyDQykapxsJ7iQV3IMwq5GIhpE3xqsXZwLvZCOGjY/aMuJA
        XjD8Gn2V2z3yxSO6U2IXv3drfQ==
X-Google-Smtp-Source: AK7set/Sg1EKZpPnOVhuAt9KhQSjGh52j1FGM0jG+Z5akg4z80ux7gd3rmlDUGrfknhCAucbOTZxkg==
X-Received: by 2002:a17:902:e80e:b0:198:af4f:de09 with SMTP id u14-20020a170902e80e00b00198af4fde09mr233575plg.9.1675868457315;
        Wed, 08 Feb 2023 07:00:57 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id p21-20020a056a000a1500b00593d7db7f29sm11340184pfh.216.2023.02.08.07.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 07:00:56 -0800 (PST)
Date:   Wed, 8 Feb 2023 15:00:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     shahuang@redhat.com
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <andrew.jones@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Ben Gardon <bgardon@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: selftests: Remove duplicate macro definition
Message-ID: <Y+O5JW+Ro3i7iXV3@google.com>
References: <20230208071801.68620-1-shahuang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208071801.68620-1-shahuang@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 08, 2023, shahuang@redhat.com wrote:
> From: Shaoqin Huang <shahuang@redhat.com>
> 
> The KVM_GUEST_PAGE_TABLE_MIN_PADDR macro has been defined in
> include/kvm_util_base.h. So remove the duplicate definition in
> lib/kvm_util.c.
> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index f25b3e9b5a07..3ea24a5f4c43 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1942,9 +1942,6 @@ vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
>  	return vm_phy_pages_alloc(vm, 1, paddr_min, memslot);
>  }
>  
> -/* Arbitrary minimum physical address used for virtual translation tables. */
> -#define KVM_GUEST_PAGE_TABLE_MIN_PADDR 0x180000

Huh.  There wasn't even a merge conflict or anything, I just added it twice in
commit cce0c23dd944 ("KVM: selftests: Add wrapper to allocate page table page").

Anyways, applied to kvm-x86 selftests with a Fixes tag.  Thanks!

[1/1] KVM: selftests: Remove duplicate macro definition
      https://github.com/kvm-x86/linux/commit/695fa5a64cf5

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
