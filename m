Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001C67CC7CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 17:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344176AbjJQPqV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 11:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbjJQPp7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 11:45:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C952A19B;
        Tue, 17 Oct 2023 08:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=HqpYto28NsMabgIUb0zwF/UIwjSPedBpjPncERhM0sc=; b=OiWj523wh1qqOURtI8D0fP9yhq
        BpKtVJH7f5xAmh2kV4g4NT4z4JCMxhFGYGPOrZCkl4DqWtTsCqR2kAJKLehXRyjoJy8IBgRrRJNEh
        8NrJ34NME2vvCbPyOhJfxLbveH0Nxa9Vokt6hgrKueEQQ3VqlTDXoHQ4nvsG1nhBM1rxXqRLHPiQB
        ZJ6LG7BelIHi3Fd0NmRghWkmDZR2/bHfaZ+7B/ddgE/8+nXlP3aL+OWbawfYnKCqgSTyy7mbP4CMk
        LBoMUXzHKzYsa4du5552XOyNkQ/99AV1qORCdGhqM1+87tmw7wkoXKQV8Qmx2GFCNOM4J8KfFinUY
        RYs6oXpA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qsmGI-00Cm99-1U;
        Tue, 17 Oct 2023 15:45:38 +0000
Message-ID: <cba3771f-09bb-4b2b-af13-00dd2f9c4e64@infradead.org>
Date:   Tue, 17 Oct 2023 08:45:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/8] mseal: Add mseal(2) syscall.
Content-Language: en-US
To:     jeffxu@chromium.org, akpm@linux-foundation.org,
        keescook@chromium.org, jannh@google.com, sroettger@google.com,
        willy@infradead.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org
Cc:     jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, surenb@google.com, alex.sierra@amd.com,
        apopple@nvidia.com, aneesh.kumar@linux.ibm.com,
        axelrasmussen@google.com, ben@decadent.org.uk,
        catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk,
        ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com,
        corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, lstoakes@gmail.com, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
        vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
        zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
References: <20231017090815.1067790-1-jeffxu@chromium.org>
 <20231017090815.1067790-2-jeffxu@chromium.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231017090815.1067790-2-jeffxu@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

nit:

On 10/17/23 02:08, jeffxu@chromium.org wrote:

| diff --git a/mm/Kconfig b/mm/Kconfig
| index 264a2df5ecf5..db8a567cb4d3 100644
| --- a/mm/Kconfig
| +++ b/mm/Kconfig
| @@ -1258,6 +1258,14 @@ config LOCK_MM_AND_FIND_VMA
|  	bool
|  	depends on !STACK_GROWSUP
|  
| +config MSEAL
| +	default n
| +	bool "Enable mseal() system call"
| +	depends on MMU
| +	help
| +	  Enable the mseal() system call. Make memory areas's metadata immutable

	                                              areas'

$search_engine is your friend.

| +	  by selected system calls, i.e. mprotect(), munmap(), mremap(), mmap().


-- 
~Randy
