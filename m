Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6FE60C4B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 09:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJYHH5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 03:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiJYHHz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 03:07:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FA16BCE0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 00:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666681674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e274vUxvlMRl4b9EVFADkQ7OakHDt5CbdSA7wcE3hgk=;
        b=KAq4Lnflfo127ahBd6D3zfKVPiJFdCGoUIPgsWDaNlfwWVgE7gK7EOkFCy+q+r7DNvLiVR
        TKi50bH01tE51LoDhfxZKvJYhjhPnwh688XRl9Okj6LZgF3tNkEZQXoecBp+mVLBwomiOt
        wx37jvVuVP8utkCE1Wl/TZ38iL6Ykvs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-306-CiRZXWkRNA-5Si2CaWR9Yw-1; Tue, 25 Oct 2022 03:07:53 -0400
X-MC-Unique: CiRZXWkRNA-5Si2CaWR9Yw-1
Received: by mail-wm1-f71.google.com with SMTP id x12-20020a05600c21cc00b003c8340cb973so1863147wmj.7
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 00:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e274vUxvlMRl4b9EVFADkQ7OakHDt5CbdSA7wcE3hgk=;
        b=0UYzKEC1ZGDOv7nrOCTQfhZujIughRF6np/vf9gVv7vrb4ELLuH8pQ09I9TckDsAux
         7/LYja6IycuyPOlVNo0NiRWnIRXF+tjToZGa9/qLLuC4Xt6LUX3YCMjL4zac8zbz7TMY
         no9Bcz3OgWTchj1xAFfY1eMjfMDlvIZjuaIjEcp4euo+Z/UDyJ3uJAUcHYtOnmXDUwKH
         Q1mweCBd9y7CNrRH+i7UVBAxDPBfxoHb0TQix8V7gyhBAfoU+xZj+7W09LZKWyKFfRlb
         QnahqvNgBBTIYuEhhFFLlc2AddljWmepF+0RYohSTCGqwQlDbnPvV0FofJlqz3TP0AxK
         GZCg==
X-Gm-Message-State: ACrzQf1b8QZSHFGqAF79k99l2lqUoC5WkLtxSUJActJ6Gm0XTxOjQGzK
        cL+GZxBCfd7LTSlpuLkqleBOc2A3LB40L7jb8j6SkcR7Ms9X4P2Shda3LRLe1byRDz4fQN8l9/q
        K2OPw3EtTTSVua2FD/mAZ7norfUIR
X-Received: by 2002:a1c:7215:0:b0:3c7:130c:a77f with SMTP id n21-20020a1c7215000000b003c7130ca77fmr17230951wmc.151.1666681672022;
        Tue, 25 Oct 2022 00:07:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5wfwAz04p4u+4LaRLlYASuFAO4jGFX1iOyzpJF3Rl6HqJmrYTDgzqRMdCAl5kVrCw2aGPoEg==
X-Received: by 2002:a1c:7215:0:b0:3c7:130c:a77f with SMTP id n21-20020a1c7215000000b003c7130ca77fmr17230933wmc.151.1666681671734;
        Tue, 25 Oct 2022 00:07:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:4e00:3efc:1c60:bc60:f557? (p200300cbc70b4e003efc1c60bc60f557.dip0.t-ipconnect.de. [2003:cb:c70b:4e00:3efc:1c60:bc60:f557])
        by smtp.gmail.com with ESMTPSA id a15-20020adffacf000000b002366e3f1497sm1702551wrs.6.2022.10.25.00.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 00:07:51 -0700 (PDT)
Message-ID: <51302b9e-dc69-d709-3214-f23868028555@redhat.com>
Date:   Tue, 25 Oct 2022 09:07:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v1 1/7] selftests/vm: anon_cow: test COW handling of
 anonymous memory
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
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
 <20220927110120.106906-2-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220927110120.106906-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 27.09.22 13:01, David Hildenbrand wrote:
> Let's start adding tests for our COW handling of anonymous memory. We'll
> focus on basic tests that we can achieve without additional libraries or
> gup_test extensions.
> 
> We'll add THP and hugetlb tests separately.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

The following fixup on top:

diff --git a/tools/testing/selftests/vm/anon_cow.c b/tools/testing/selftests/vm/anon_cow.c
index 9d2b15c829e6..4613294af758 100644
--- a/tools/testing/selftests/vm/anon_cow.c
+++ b/tools/testing/selftests/vm/anon_cow.c
@@ -76,7 +76,7 @@ static int child_vmsplice_memcmp_fn(char *mem, size_t size,
                 .iov_base = mem,
                 .iov_len = size,
         };
-       size_t cur, total, transferred;
+       ssize_t cur, total, transferred;
         char *old, *new;
         int fds[2];
         char buf;
@@ -172,7 +172,7 @@ static void do_test_vmsplice_in_parent(char *mem, size_t size,
                 .iov_base = mem,
                 .iov_len = size,
         };
-       size_t cur, total, transferred;
+       ssize_t cur, total, transferred;
         struct comm_pipes comm_pipes;
         char *old, *new;
         int ret, fds[2];


-- 
Thanks,

David / dhildenb

