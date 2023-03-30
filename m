Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572BA6CFA70
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 06:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjC3E40 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 00:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjC3E4Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 00:56:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398B649CE
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 21:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680152135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SfE1DWU3+82lgaUycDeR1l3BXeg5cIyOiSyAYjqLz10=;
        b=JIBtfm8nfjhEAtyVdJBsUdOUVE1f3lkKQ8Ru2jz0y+j7p0LaVcZodkBs2oE7oATBtAh3lw
        +rl0JPdGIcOZF319ahl7RZEJ91gwNVFxaczBFQB7GFHDKK59vzsvqsSUB806IX4QzIBEJh
        ueqRNsX8tTi/oYN7tAwY246yMdzLUSk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-Z_vjetZ6NHOra40qpMNOPg-1; Thu, 30 Mar 2023 00:55:33 -0400
X-MC-Unique: Z_vjetZ6NHOra40qpMNOPg-1
Received: by mail-pj1-f72.google.com with SMTP id nu18-20020a17090b1b1200b0023fbe01dc06so8692140pjb.8
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 21:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680152133;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfE1DWU3+82lgaUycDeR1l3BXeg5cIyOiSyAYjqLz10=;
        b=qYfbsOYq5YkRp9F5WrwA/BVuAtABgyZMX8a5PIKlPQjHoXNDlBcRnFsR30m3GSsR5j
         saQQ7AuJo6TNL8BJ+ejqEnKeonzO699plMXbwPQDa9K2GXZ5y+XZ0agHzxCWZ9aT3jiW
         K1McO67xulV4ub4Hv2wNGqxtkt22D1HyeAwK/tZemTmdUq6KMaekJ1EhROpmoraluhNz
         8RIjlTfJFnxVHF6hysbaHMWSwaN9AXqUlaN8hn0IoibcEbsJH8t9Sg8Niu5E2OI0ubsI
         3OENOGTdogtYis9ovtdmshui5q6e/MREn2i1HaopyflqTe3PX65jG2bLTrbptBUnBs3o
         EVug==
X-Gm-Message-State: AAQBX9erQu5dyCjfrrQPWBqgaxVllc7pkpUsB0Z+cmCBqKKBe0qIAXWC
        zP6rQuoLDZx8vlHvsTtOPnWdfKko/uRgStMQupA+Q2nh7Xa/15dQb+f2mLY0QYnnAXBZCdflKoO
        QkJ2JnhzeG5V7VGXe/BjjbF2OFpsG
X-Received: by 2002:a17:90a:3:b0:23d:3931:7b49 with SMTP id 3-20020a17090a000300b0023d39317b49mr22164454pja.35.1680152132758;
        Wed, 29 Mar 2023 21:55:32 -0700 (PDT)
X-Google-Smtp-Source: AKy350ahVfgTHtRLxkoOOQlT2RCr2YXsazoiymyRXgQ9yO6J9Xq64hWqpppKwwPGxAW3vPkD+5AjgA==
X-Received: by 2002:a17:90a:3:b0:23d:3931:7b49 with SMTP id 3-20020a17090a000300b0023d39317b49mr22164429pja.35.1680152132358;
        Wed, 29 Mar 2023 21:55:32 -0700 (PDT)
Received: from [192.168.35.160] ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id d4-20020a17090ac24400b00240ab3c5f66sm2325330pjx.29.2023.03.29.21.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 21:55:31 -0700 (PDT)
Message-ID: <37dcd52a-2e32-c01d-b805-45d862721fbc@redhat.com>
Date:   Thu, 30 Mar 2023 06:55:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, hannes@cmpxchg.org,
        Hugh Dickins <hughd@google.com>
References: <20230310182851.2579138-1-shr@devkernel.io>
 <20230328160914.5b6b66e4a5ad39e41fd63710@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 0/3] mm: process/cgroup ksm support
In-Reply-To: <20230328160914.5b6b66e4a5ad39e41fd63710@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 29.03.23 01:09, Andrew Morton wrote:
> On Fri, 10 Mar 2023 10:28:48 -0800 Stefan Roesch <shr@devkernel.io> wrote:
> 
>> So far KSM can only be enabled by calling madvise for memory regions. To
>> be able to use KSM for more workloads, KSM needs to have the ability to be
>> enabled / disabled at the process / cgroup level.
> 
> Review on this series has been a bit thin.  Are we OK with moving this
> into mm-stable for the next merge window?

I still want to review (traveling this week), but I also don't want to 
block this forever.

I think I didn't get a reply from Stefan to my question [1] yet (only 
some comments from Johannes). I would still be interested in the 
variance of pages we end up de-duplicating for processes.

The 20% statement in the cover letter is rather useless and possibly 
misleading if no details about the actual workload are shared.

Maybe Hugh has some comments as well (most probably he's also busy).

[1] 
https://lore.kernel.org/all/273a2f82-928f-5ad1-0988-1a886d169e83@redhat.com/

-- 
Thanks,

David / dhildenb

