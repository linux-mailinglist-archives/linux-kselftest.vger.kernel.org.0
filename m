Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942CD7CACF8
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 17:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjJPPGz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 11:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbjJPPGy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 11:06:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805C4D9;
        Mon, 16 Oct 2023 08:06:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC7BC433C9;
        Mon, 16 Oct 2023 15:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697468813;
        bh=GCcpSZHz166979U6vHgX4cVsCXfd7NMyD8cEsvnOS8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DY8wfejmM71V/4hCVydHZ+QhMceo63CcT9Ew3cgKYqqokpfzXOO78fC1SLFQ/C1px
         Fjq/n3TPno7gzRCfzzlYx7PL1xYsjXAGXGHD1NNcTY+iXHT7OkpapmwZbzKEhEUsz3
         3yB/5EwhAXNqLjuUsA7lqDt3fEttcxec/ezXdrEY=
Date:   Mon, 16 Oct 2023 17:05:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jeffxu@chromium.org
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        sroettger@google.com, jeffxu@google.com, jorgelo@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, surenb@google.com, alex.sierra@amd.com,
        apopple@nvidia.com, aneesh.kumar@linux.ibm.com,
        axelrasmussen@google.com, ben@decadent.org.uk,
        catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk,
        ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com,
        corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, torvalds@linux-foundation.org,
        lstoakes@gmail.com, willy@infradead.org, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
        vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
        zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/8] Add mseal syscall
Message-ID: <2023101614-scarce-discount-d7ff@gregkh>
References: <20231016143828.647848-1-jeffxu@chromium.org>
 <20231016143828.647848-2-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016143828.647848-2-jeffxu@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 16, 2023 at 02:38:20PM +0000, jeffxu@chromium.org wrote:
> +#ifdef CONFIG_MSEAL
> +	/*
> +	 * bit masks for seal.
> +	 * need this since vm_flags is full.
> +	 */
> +	unsigned long vm_seals;		/* seal flags, see mm.h. */

"unsigned long" and yet:

> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index c0cb22cd607d..f574c7dbee76 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -802,6 +802,8 @@ asmlinkage long sys_process_mrelease(int pidfd, unsigned int flags);
>  asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
>  			unsigned long prot, unsigned long pgoff,
>  			unsigned long flags);
> +asmlinkage long sys_mseal(unsigned long start, size_t len, unsigned int types,
> +			  unsigned int flags);

"unsigned int"?

Why the mis-match?

> --- a/include/uapi/linux/mman.h
> +++ b/include/uapi/linux/mman.h
> @@ -55,4 +55,10 @@ struct cachestat {
>  	__u64 nr_recently_evicted;
>  };
>  
> +#define MM_SEAL_MSEAL		0x1
> +#define MM_SEAL_MPROTECT	0x2
> +#define MM_SEAL_MUNMAP		0x4
> +#define MM_SEAL_MMAP		0x8
> +#define MM_SEAL_MREMAP		0x10

I think we can use the BIT() macro in uapi .h files now, it is _BITUL().
Might want to use it here too to make it obvious what is happening.

thanks,

greg k-h
