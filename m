Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41C36045D4
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Oct 2022 14:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbiJSMuM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Oct 2022 08:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbiJSMtX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Oct 2022 08:49:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07140219E
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Oct 2022 05:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666182679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vdyF20motJAcGwhEZFkcIJUXHpFy/FT1+InzXbprcxQ=;
        b=dixvTUWCpV1hNhuHHlJ50BYnYtd/ddnmCoHXZ514wlPMuDCvbASEEEDf1MssVsrI8HKOwG
        QxMlYrOuLspN+TZb6Mm6kHk1+mmcXccin+pncRouof9GTFMmwBN1JFPBVFOgO1VvAHm5WT
        f/ifio+UAaHNX54DQPqfdEvViBMvYgU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-331-cXn2m1SpO9Go2E6_lysImQ-1; Wed, 19 Oct 2022 08:31:18 -0400
X-MC-Unique: cXn2m1SpO9Go2E6_lysImQ-1
Received: by mail-wr1-f69.google.com with SMTP id s4-20020adfbc04000000b0022e03fc10a9so5527244wrg.15
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Oct 2022 05:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdyF20motJAcGwhEZFkcIJUXHpFy/FT1+InzXbprcxQ=;
        b=Q3w7Wd7yHK5bXgj+DmSgfUzScIsvl0UYQjAG5mZHA5bZJ0nmglX9G4+9ePJfpAbwF7
         S+jQIi3CIFbZDIKFTGc9TBHqFKfYdP02oscqFCiDVQ9O7dd5N1+vDMWPSab9aXSheTfD
         EhkChIMC1KNvI/UNAO4BNHBeM5RCiwrE1K/w7XVYxbXzW/XePjKkw4P5mhkmeymk+UJF
         fSRftgdhGFnmacpTwtgr506jcAqmCmeahsYPjqNvkU0NjxL5IQdS2GI1dBcxvmcjl93X
         VQTs+ubMUaxdxj8EiImpbY8+Dnu5fdCd1DnHAA7RloQptxxsDzSC65O7+Fdy+b4SvjPT
         xoSQ==
X-Gm-Message-State: ACrzQf0dzLYeFhbgt9yEVw8dY4L+DNA2x3i3Uuju0MGujbBjfXot7x7W
        P5rXD3QT3AUZRRMKziRIw+U5R5AwlS4qVrrjmtL3RHySK7aXH6sSTvkUTg37xiur79Rtdt6IaVA
        6yoTmaMGJx4ar+x6nT48dSSgysV6S
X-Received: by 2002:adf:e2d2:0:b0:22f:6a2a:92ab with SMTP id d18-20020adfe2d2000000b0022f6a2a92abmr4785875wrj.545.1666182677363;
        Wed, 19 Oct 2022 05:31:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6vpRf1nx8zR6YQpm368M0MQZZnl74qgOl7S9XqjCF6QToT5rTsmXN0Wg87YGXaLyxnO8ihgw==
X-Received: by 2002:adf:e2d2:0:b0:22f:6a2a:92ab with SMTP id d18-20020adfe2d2000000b0022f6a2a92abmr4785851wrj.545.1666182677037;
        Wed, 19 Oct 2022 05:31:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:2c00:d4ac:d2c:4aee:dac1? (p200300cbc7072c00d4ac0d2c4aeedac1.dip0.t-ipconnect.de. [2003:cb:c707:2c00:d4ac:d2c:4aee:dac1])
        by smtp.gmail.com with ESMTPSA id u5-20020a5d5145000000b00232251d71c7sm13533415wrt.68.2022.10.19.05.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 05:31:16 -0700 (PDT)
Message-ID: <74adbb51-6e33-f636-8a9c-2ad87bd9007e@redhat.com>
Date:   Wed, 19 Oct 2022 14:31:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v1 7/7] selftests/vm: anon_cow: add R/O longterm tests via
 gup_test
Content-Language: en-US
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>
References: <20220927110120.106906-1-david@redhat.com>
 <20220927110120.106906-8-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220927110120.106906-8-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 27.09.22 13:01, David Hildenbrand wrote:
> Let's trigger a R/O longterm pin on three cases of R/O mapped anonymous
> pages:
> * exclusive (never shared)
> * shared (child still alive)
> * previously shared (child no longer alive)
> 
> ... and make sure that the pin is reliable: whatever we write via the page
> tables has to be observable via the pin.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

The following on top should silence the warning on 32bit:

https://lore.kernel.org/all/202210182101.XOyPZEQV-lkp@intel.com/T/#u


diff --git a/mm/gup_test.c b/mm/gup_test.c
index 2bbfacd31f5a..57c343f2dc51 100644
--- a/mm/gup_test.c
+++ b/mm/gup_test.c
@@ -299,7 +299,8 @@ static inline int pin_longterm_test_read(unsigned long arg)
         for (i = 0; i < pin_longterm_test_nr_pages; i++) {
                 void *addr = page_to_virt(pin_longterm_test_pages[i]);
  
-               if (copy_to_user((void __user *)user_addr, addr, PAGE_SIZE))
+               if (copy_to_user((void __user *)(unsigned long)user_addr, addr,
+                                PAGE_SIZE))
                         return -EFAULT;
                 user_addr += PAGE_SIZE;
         }


-- 
Thanks,

David / dhildenb

