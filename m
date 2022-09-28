Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B275ED473
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Sep 2022 08:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbiI1GEL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Sep 2022 02:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiI1GEK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Sep 2022 02:04:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2175F11A68C;
        Tue, 27 Sep 2022 23:04:08 -0700 (PDT)
Received: from [192.168.10.9] (unknown [39.45.148.204])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BE0B0660221F;
        Wed, 28 Sep 2022 07:04:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664345045;
        bh=bCIwW7EnoB27URDSRgUhCbHMbob8kMA51uretneCH6Q=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=N3+1KZuO5H04WNxoCOUnyir8XcV1ug7Z1d4L9L8SOJ8okF7JdcbpmOdS1qo7K84TM
         S8jYu4V3IIxMf7oYORnrWJPqcJGYHpXA4m1d9NV66kS2ESmpwPrpTEdMT2+01ajYna
         NcQBJAXjNf8o87NA3HY5Id3TTdprvTEQM6rAe07MMPPbre+we4/meeAE3pYKjq/Q5r
         cmUCvTAkyCynARQChugIhgjgfzjJ7a9gvAQzGXseBfurkAIISOcPiSyRhYUYX/aU8a
         84A3KfYvhLZ2Q4eaeA7V60Td5yReER5N2f1Wv5QSlCoS41Fnq6ojT91/iHVmk7SUF0
         7ZnF7rDUz1fvw==
Message-ID: <26380310-05c6-3e57-d05a-e6e373335232@collabora.com>
Date:   Wed, 28 Sep 2022 11:03:58 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 0/4] Implement IOCTL to get and clear soft dirty PTE
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <20220826064535.1941190-1-usama.anjum@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220826064535.1941190-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Any thoughts about it?

On 8/26/22 11:45 AM, Muhammad Usama Anjum wrote:
> 
> Hello,
> 
> This patch series implements a new ioctl on the pagemap proc fs file to
> get, clear and perform both get and clear at the same time atomically on
> the specified range of the memory.
> 
> Soft-dirty PTE bit of the memory pages can be viewed by using pagemap
> procfs file. The soft-dirty PTE bit for the whole memory range of the
> process can be cleared by writing to the clear_refs file. This series
> adds features that weren't present earlier.
> - There is no atomic get soft-dirty PTE bit status and clear operation
>   present.
> - The soft-dirty PTE bit of only a part of memory cannot be cleared.
> 
> Historically, soft-dirty PTE bit tracking has been used in the CRIU
> project. The proc fs interface is enough for that as I think the process
> is frozen. We have the use case where we need to track the soft-dirty
> PTE bit for the running processes. We need this tracking and clear
> mechanism of a region of memory while the process is running to emulate
> the getWriteWatch() syscall of Windows. This syscall is used by games to
> keep track of dirty pages and keep processing only the dirty pages. This
> new ioctl can be used by the CRIU project and other applications which
> require soft-dirty PTE bit information.
> 
> As in the current kernel there is no way to clear a part of memory (instead
> of clearing the Soft-Dirty bits for the entire process) and get+clear
> operation cannot be performed atomically, there are other methods to mimic
> this information entirely in userspace with poor performance:
> - The mprotect syscall and SIGSEGV handler for bookkeeping
> - The userfaultfd syscall with the handler for bookkeeping
> Some benchmarks can be seen [1].
> 
> This ioctl can be used by the CRIU project and other applications which
> require soft-dirty PTE bit information. The following operations are
> supported in this ioctl:
> - Get the pages that are soft-dirty.
> - Clear the pages which are soft-dirty.
> - The optional flag to ignore the VM_SOFTDIRTY and only track per page
> soft-dirty PTE bit
> 
> There are two decisions which have been taken about how to get the output
> from the syscall.
> - Return offsets of the pages from the start in the vec
> - Stop execution when vec is filled with dirty pages
> These two arguments doesn't follow the mincore() philosophy where the
> output array corresponds to the address range in one to one fashion, hence
> the output buffer length isn't passed and only a flag is set if the page
> is present. This makes mincore() easy to use with less control. We are
> passing the size of the output array and putting return data consecutively
> which is offset of dirty pages from the start. The user can convert these
> offsets back into the dirty page addresses easily. Suppose, the user want
> to get first 10 dirty pages from a total memory of 100 pages. He'll
> allocate output buffer of size 10 and the ioctl will abort after finding the
> 10 pages. This behaviour is needed to support Windows' getWriteWatch(). The
> behaviour like mincore() can be achieved by passing output buffer of 100
> size. This interface can be used for any desired behaviour.
> 
> [1] https://lore.kernel.org/lkml/54d4c322-cd6e-eefd-b161-2af2b56aae24@collabora.com/
> 
> Regards,
> Muhammad Usama Anjum
> 
> Muhammad Usama Anjum (4):
>   fs/proc/task_mmu: update functions to clear the soft-dirty PTE bit
>   fs/proc/task_mmu: Implement IOCTL to get and clear soft dirty PTE bit
>   selftests: vm: add pagemap ioctl tests
>   mm: add documentation of the new ioctl on pagemap
> 
>  Documentation/admin-guide/mm/soft-dirty.rst |  42 +-
>  fs/proc/task_mmu.c                          | 342 ++++++++++-
>  include/uapi/linux/fs.h                     |  23 +
>  tools/include/uapi/linux/fs.h               |  23 +
>  tools/testing/selftests/vm/.gitignore       |   1 +
>  tools/testing/selftests/vm/Makefile         |   2 +
>  tools/testing/selftests/vm/pagemap_ioctl.c  | 649 ++++++++++++++++++++
>  7 files changed, 1050 insertions(+), 32 deletions(-)
>  create mode 100644 tools/testing/selftests/vm/pagemap_ioctl.c
> 

-- 
Muhammad Usama Anjum
