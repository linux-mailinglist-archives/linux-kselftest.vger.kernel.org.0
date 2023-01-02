Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F6A65B570
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jan 2023 18:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbjABRAB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Jan 2023 12:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbjABQ7x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Jan 2023 11:59:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF61CCD0
        for <linux-kselftest@vger.kernel.org>; Mon,  2 Jan 2023 08:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672678746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nTCIZ7IHuULT6fez4X5HuU0mNTgMf9mzjRqDHXDxk7w=;
        b=SZfMmjTk7SRxbkNQ8l/ndj7cyCKArUlV+LBkiCb/3dZf9cQqyrioLGLhiydUD2IbOBDkIA
        /8c6oUxU1O5SZTs0Bj7VMktzMa7ea6HEf88QRLZX3vmNDDSbmr8jLNjHWfawJStq4wL8TY
        Hsi7uPRSLlwb06RMk2vMYFoHzf9Lt+o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-553-G5jJooIKNAWIz3rebDxBAw-1; Mon, 02 Jan 2023 11:59:04 -0500
X-MC-Unique: G5jJooIKNAWIz3rebDxBAw-1
Received: by mail-wm1-f70.google.com with SMTP id q19-20020a1cf313000000b003d96c95e2f9so5924235wmq.2
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jan 2023 08:59:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nTCIZ7IHuULT6fez4X5HuU0mNTgMf9mzjRqDHXDxk7w=;
        b=0btrQINutX0ALZB1dfstL6tKjWYnkWdj0PQdHKZFXX9t7khFXDZHshqtMIPFIssj5e
         kjhQmgXLHQho7G/GeAqGLgNIvnoGK/UpKBsO9WGR1FNMzSWg/k2vl3jdvUhSzeh7snbw
         Q8FUn+XreXwsNAOdAMXi+05aGh5sdaQaexj9n24ZjR1lXT23DjR1D4QC/zbwuDSnGLgG
         dlF0dM1jK5bsbTkXx8xuAuPkPWfF9UuRbL86+G6ovfTcPdqcGBQ1r1yIuT7xy0CHRj0c
         Z0W8ic9KDgMsktn4xY8dslt2GQMteXNpoUd7NTEyeymvbYqRfve8IERsfsMbZ4V4P8Kq
         1Akw==
X-Gm-Message-State: AFqh2koVql5hzIdVFjCyD0gqnVzwgK8MGdFqzAMdQTnn2sVnrGul9Jcv
        AaP8kGE5fjDJQJ2xD5dK8ukPAUxzHn7t7f7Iy17m+OzOHm8URxe20RyKdV/1HJjAuBg+gZQSglR
        IFwsAs7W0otW2oApAPOHQep49ZnDy
X-Received: by 2002:a5d:4406:0:b0:242:7248:fbe with SMTP id z6-20020a5d4406000000b0024272480fbemr25733626wrq.25.1672678743710;
        Mon, 02 Jan 2023 08:59:03 -0800 (PST)
X-Google-Smtp-Source: AMrXdXthYoV4iOcJG3VsfRnJibfrOk5dWxFJ8qfSBsRAPuSk3V9O7Ch1N3TNdNPZBs+eSLxvRNdZCw==
X-Received: by 2002:a5d:4406:0:b0:242:7248:fbe with SMTP id z6-20020a5d4406000000b0024272480fbemr25733620wrq.25.1672678743456;
        Mon, 02 Jan 2023 08:59:03 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:500:9382:2e5a:fea:8889? (p200300cbc703050093822e5a0fea8889.dip0.t-ipconnect.de. [2003:cb:c703:500:9382:2e5a:fea:8889])
        by smtp.gmail.com with ESMTPSA id m24-20020a056000181800b00296730b5c3esm5554570wrh.102.2023.01.02.08.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 08:59:03 -0800 (PST)
Message-ID: <6c3725b7-53af-bcc7-2a58-a35b2bc08b4f@redhat.com>
Date:   Mon, 2 Jan 2023 17:59:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4] selftest/vm: add mremap expand merge offset test
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Jakub Matena <matenajakub@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>
References: <02b117a8ffd52acc01dc66c2fb39754f08d92c0e.1672675824.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <02b117a8ffd52acc01dc66c2fb39754f08d92c0e.1672675824.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02.01.23 17:11, Lorenzo Stoakes wrote:
> Add a test to assert that we can mremap() and expand a mapping starting
> from an offset within an existing mapping. We unmap the last page in a 3
> page mapping to ensure that the remap should always succeed, before
> remapping from the 2nd page.
> 
> This is additionally a regression test for the issue solved in "mm, mremap:
> fix mremap() expanding vma with addr inside vma" and confirmed to fail
> prior to the change and pass after it.
> 
> Finally, this patch updates the existing mremap expand merge test to check
> error conditions and reduce code duplication between the two tests.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

