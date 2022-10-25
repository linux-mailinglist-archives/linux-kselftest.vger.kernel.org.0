Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6CA60C4C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 09:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiJYHKd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 03:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiJYHK1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 03:10:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0211FDDB5B
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 00:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666681824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6uE3DhoyppSorLvc/Envz8CzaNz1EF7/KSd+9Rw6KO4=;
        b=VIGxJTOg/s8NJH4Lw6U7zV2dd/ARxA9sx9tdGddIeUFeHzTnJaAxLMwTTAUER8RV1cqx1x
        njJxtxvlIqcEYIgRTSt12blWcvS+l2I3oX2QpFr7mWjOWVLE2r2CwDgCxEv7+JY62hk4yb
        oa59Gg3ZpcWV+g2y451swSGlxRi3xfQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-447-2MVlyNywNES_-tMqOoZuBg-1; Tue, 25 Oct 2022 03:10:21 -0400
X-MC-Unique: 2MVlyNywNES_-tMqOoZuBg-1
Received: by mail-wm1-f70.google.com with SMTP id q14-20020a7bce8e000000b003c6b7debf22so2156873wmj.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 00:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6uE3DhoyppSorLvc/Envz8CzaNz1EF7/KSd+9Rw6KO4=;
        b=yZ4a0jIbPSvsUE5t/bW2midrdtKA2JEVz77gK8Vg4u0wge4jjZaCNrGkFtotZhv0At
         REmfPW69bhimXBOgMBKfBbGHpSwXPPdeu715yPaTYk3qNMdWH66FPLQ/fRE2FPrc+2rD
         IzBCMjCK1wJBy7/lwIZrHKjI3q7lgWtIolKWxFtxMdQHHe/609pOXJBgtZNCZGTxf0Ht
         lkRQERjEMQuHQwiZEs+kq+oGhEZ/yCcRM4mS2jAVeZEWWhhDQBCnZuxtqmbR3Yi041Lg
         DWbOWZ6FNxo1gFYbPqDkzqngrKbBpios/D2ZcMsdAjPTGugCavJnehXLEplKyeycW4hm
         lTig==
X-Gm-Message-State: ACrzQf2VJOo+iRekMC2eTb2gc0Y+m+U2ZK4uMU2gx8j1JDLxJhSg7hTE
        Is1SiU61U1J5uU33vd64hkOBKQrqewpFBL7kmszcjtuIsxg85SIyBscnC1seWsr59e1CWbZc6YQ
        9hkkZbI9ESq6j/FrHnKLSNEy5CkMw
X-Received: by 2002:a05:600c:a47:b0:3a6:5848:4bde with SMTP id c7-20020a05600c0a4700b003a658484bdemr44919407wmq.189.1666681820550;
        Tue, 25 Oct 2022 00:10:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7YT/j1Vmojh5DBuD0Dlc3qbWbBxDj/qp//DibR7eJ6WajhCcajb+s3exb/pzzTjfOALnrs0Q==
X-Received: by 2002:a05:600c:a47:b0:3a6:5848:4bde with SMTP id c7-20020a05600c0a4700b003a658484bdemr44919379wmq.189.1666681820211;
        Tue, 25 Oct 2022 00:10:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:4e00:3efc:1c60:bc60:f557? (p200300cbc70b4e003efc1c60bc60f557.dip0.t-ipconnect.de. [2003:cb:c70b:4e00:3efc:1c60:bc60:f557])
        by smtp.gmail.com with ESMTPSA id p5-20020a1c5445000000b003c71358a42dsm12027984wmi.18.2022.10.25.00.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 00:10:19 -0700 (PDT)
Message-ID: <445fe1ae-9e22-0d1d-4d09-272231d2f84a@redhat.com>
Date:   Tue, 25 Oct 2022 09:10:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v1 5/7] selftests/vm: anon_cow: add liburing test cases
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
 <20220927110120.106906-6-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220927110120.106906-6-david@redhat.com>
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
> io_uring provides a simple mechanism to test long-term, R/W GUP pins
> -- via fixed buffers -- and can be used to verify that GUP pins stay
> in sync with the pages in the page table even if a page would
> temporarily get mapped R/O or concurrent fork() could accidentially
> end up sharing pinned pages with the child.
> 
> Note that this essentially re-introduces local_config support that was
> removed recently in commit 6f83d6c74ea5 ("Kselftests: remove support of
> libhugetlbfs from kselftests").
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

The following fixup on top:

diff --git a/tools/testing/selftests/vm/anon_cow.c b/tools/testing/selftests/vm/anon_cow.c
index c1450a5d6f53..01417a604eda 100644
--- a/tools/testing/selftests/vm/anon_cow.c
+++ b/tools/testing/selftests/vm/anon_cow.c
@@ -346,7 +346,7 @@ static void do_test_iouring(char *mem, size_t size, bool use_fork)
         struct io_uring_cqe *cqe;
         struct io_uring_sqe *sqe;
         struct io_uring ring;
-       size_t cur, total;
+       ssize_t cur, total;
         struct iovec iov;
         char *buf, *tmp;
         int ret, fd;


-- 
Thanks,

David / dhildenb

