Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FD77D1407
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 18:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjJTQdu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 12:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjJTQdt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 12:33:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00901D5E;
        Fri, 20 Oct 2023 09:33:47 -0700 (PDT)
Received: from [192.168.100.7] (unknown [39.34.188.12])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 571ED660737B;
        Fri, 20 Oct 2023 17:33:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697819626;
        bh=qAf3VEpznG3prdWZXqc557DgYUNT22t1DAY9WghAu+k=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=kxIb9rhY56Zh09c+xKKNsfn+CdSM2I7MVoJaUtB4doGcTTUT6bxvDoh8wQo7+qsD0
         K8nzYVZbmnL3/wWhcydm+ipN0T9m/0nbqKWqE52KE8BkSZt6DmGOEuLw3mvHmkpDFd
         /an8HY4m3/GCQQA40CRMiNZBTjb/fTpG7d8iq6sFZNvuD34ia+IctP8S4A06l/ikO+
         DWmmNyaaSUATq/+kUtSoUBKzpV26GHx17pgcFL8Zj+q2815xSfgV/e4NsMP1bCGyAB
         bI0I+4Ta5zBgOUbWQWY8J0SJRT3rkXLtZdPDWsoD6p80d/eluP6qp6BFcVOwylpd6l
         3WzBwuIJdq+ZA==
Message-ID: <53fcf507-c00e-4715-bc81-082282c37c86@collabora.com>
Date:   Fri, 20 Oct 2023 21:33:23 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        jeffxu@chromium.org, akpm@linux-foundation.org,
        keescook@chromium.org, jannh@google.com, sroettger@google.com,
        willy@infradead.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, jeffxu@google.com,
        jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, surenb@google.com, alex.sierra@amd.com,
        apopple@nvidia.com, aneesh.kumar@linux.ibm.com,
        axelrasmussen@google.com, ben@decadent.org.uk,
        catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk,
        ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com,
        corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, lstoakes@gmail.com, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        ryan.roberts@arm.com, shr@devkernel.io, vbabka@suse.cz,
        xiujianfeng@huawei.com, yu.ma@intel.com, zhangpeng362@huawei.com,
        dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH v2 8/8] selftest mm/mseal mprotect/munmap/mremap/mmap
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
References: <20231017090815.1067790-1-jeffxu@chromium.org>
 <20231017090815.1067790-9-jeffxu@chromium.org>
 <3cf29cd5-8346-419f-88f1-3a5c8ddbacad@collabora.com>
 <20231020152354.GC31411@noisy.programming.kicks-ass.net>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20231020152354.GC31411@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/20/23 8:23 PM, Peter Zijlstra wrote:
> On Fri, Oct 20, 2023 at 07:24:03PM +0500, Muhammad Usama Anjum wrote:
> 
>> Please remove these. These macros would be picked up from the kernel
>> headers automatically.
> 
> As per the previous discussions, how does that work if you have O= build
> directories?
Then headers should be prepared in that O= directory first.
make headers O=abc && make -C tools/testing/selftests O=abc

> 
> I find this push to force people to do 'make headers' in order to use
> simple selftests quite misguided. You're making it *harder* to use,
> leading to less use.
I'm just following what we have been doing over selftests mailing list to
fix build issues in different use cases and kselfest.rst. Let me share the
history:

Around 2 years ago, selftest Makefile used to prepare kernel headers from
source automatically and include them to build selftests. It had several
bugs. So they separated the header preparation from selftest build. After a
while people started getting build failures because they weren't building
headers which were previously built automatically. So someone had written a
patch (already in v6.6-rc6) to show informative error if headers aren't
present. So now selftests can't be built until headers are built.

The understanding here is that selftests come with kernel source and they
should be built using in-source kernel headers as people don't always have
updated headers. I think, if someone want to build just one selftest
without doing make headers, he should install kernel headers from source
before doing so instead of adding duplicate defines in the test itself. It
helps while development to not to keep the duplicate copy of these macros
in selftest as well.


-- 
BR,
Muhammad Usama Anjum
