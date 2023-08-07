Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E54D772966
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 17:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjHGPhh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 11:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjHGPhc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 11:37:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31ADEA6
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Aug 2023 08:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691422609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wCM0LSVABzEid+9ZFB8RVu58baVBQ5wmkVT334cAYKs=;
        b=dlHOSv6650uKMK7y6IFub5qerDl7w/6oHXuqCiC2rXK7mXr0JaPfo+E0c0YD8ioIr4HVmD
        Wl46VYkPR4tWQsXn+AIpaqy3XaIATCi2jUq7G4GuJ6ctQVWbQmfcPq7ObIiTPefN+sRH7z
        AfSheYF0HQNqc6MtYoAU+1yfNmHdYk0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-Ksuyu9H9O6q8sVSr5C3jHw-1; Mon, 07 Aug 2023 11:36:48 -0400
X-MC-Unique: Ksuyu9H9O6q8sVSr5C3jHw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30932d15a30so2517216f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Aug 2023 08:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691422607; x=1692027407;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wCM0LSVABzEid+9ZFB8RVu58baVBQ5wmkVT334cAYKs=;
        b=YLr8bQXs8c4UOB3hBEigKct1Imwa+FZGLSfGYOzbs1WgJJfoa5XBy5Lntnnhsa3JcD
         j9X4vyVIeBGjBka/SzSUS95pmm9OXkmKA+g11WKpe1YE+Bz5EQOMUYGiHAu+5GRxR9OY
         odPd+bemv0ptv4FB5ZVSJq+pX6uVTEs8MSXCThhsBKAU4iWELM56JvB/uUtktfQYEzZe
         935mCrEHH4PK86o6D34MMwVMMxQmndjAB2hdvUtz620zYp/+GNFzT+lPYCwG69jSgTzv
         LemYAo2pXOIkqgRPFuJwuY62FLPjCXXWvNIAlq7JFSapKBhkdraTpgu8uMIGGe35V3Lf
         DLug==
X-Gm-Message-State: AOJu0Yx22eqzkWs8HlE2f1brczcgWJknEuR9wjxoMUkYBD8IiPuuVVwU
        zDNPQFBvCOG5pZnt46j9e0AYb2oZglwi2AkOzTpVHnrwSj/JW+er7Ys5YLuhrlSh+rZJEeT+Ey7
        FOHODpicaWOXaPQLflxShcWp6VPsg
X-Received: by 2002:a5d:4085:0:b0:315:96ca:dcab with SMTP id o5-20020a5d4085000000b0031596cadcabmr7337373wrp.35.1691422607007;
        Mon, 07 Aug 2023 08:36:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFazJ0hQvyp0w7nVsyclbNvRXnBSHlJEwsegobzfYo7VP5sfkvDEV8yiWkWqkqGh7ZbhT/yBw==
X-Received: by 2002:a5d:4085:0:b0:315:96ca:dcab with SMTP id o5-20020a5d4085000000b0031596cadcabmr7337347wrp.35.1691422606590;
        Mon, 07 Aug 2023 08:36:46 -0700 (PDT)
Received: from [192.168.3.108] (p4ff234da.dip0.t-ipconnect.de. [79.242.52.218])
        by smtp.gmail.com with ESMTPSA id s1-20020adff801000000b00314417f5272sm10811517wrp.64.2023.08.07.08.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 08:36:46 -0700 (PDT)
Message-ID: <e9cdb144-70c7-6596-2377-e675635c94e0@redhat.com>
Date:   Mon, 7 Aug 2023 17:36:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 7/7] selftest/mm: ksm_functional_tests: Add PROT_NONE
 test
Content-Language: en-US
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liubo <liubo254@huawei.com>, Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>, Shuah Khan <shuah@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20230803143208.383663-1-david@redhat.com>
 <20230803143208.383663-8-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230803143208.383663-8-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 03.08.23 16:32, David Hildenbrand wrote:
> Let's test whether merging and unmerging in PROT_NONE areas works as
> expected.
> 
> Pass a page protection to mmap_and_merge_range(), which will trigger
> an mprotect() after writing to the pages, but before enabling merging.
> 
> Make sure that unsharing works as expected, by performing a ptrace write
> (using /proc/self/mem) and by setting MADV_UNMERGEABLE.
> 
> Note that this implicitly tests that ptrace writes in an inaccessible
> (PROT_NONE) mapping work as expected.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Andrew, can you squash the following?

 From c2be7c02cb96b9189a52a5937821600ef4e259bd Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Mon, 7 Aug 2023 17:33:54 +0200
Subject: [PATCH] Fixup: selftest/mm: ksm_functional_tests: Add PROT_NONE test

As noted by Peter, we should be using sizeof(i) in test_prot_none().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  tools/testing/selftests/mm/ksm_functional_tests.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 8fa4889ab4f3..901e950f9138 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -516,7 +516,7 @@ static void test_prot_none(void)
  	/* Store a unique value in each page on one half using ptrace */
  	for (i = 0; i < size / 2; i += pagesize) {
  		lseek(mem_fd, (uintptr_t) map + i, SEEK_SET);
-		if (write(mem_fd, &i, sizeof(size)) != sizeof(size)) {
+		if (write(mem_fd, &i, sizeof(i)) != sizeof(i)) {
  			ksft_test_result_fail("ptrace write failed\n");
  			goto unmap;
  		}
-- 
2.41.0



-- 
Cheers,

David / dhildenb

