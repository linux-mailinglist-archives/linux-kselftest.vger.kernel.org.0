Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D347D1106
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 15:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377376AbjJTN4m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 09:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377419AbjJTN4l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 09:56:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3482E1A8;
        Fri, 20 Oct 2023 06:56:39 -0700 (PDT)
Received: from [192.168.100.7] (unknown [39.34.188.12])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 745D56607377;
        Fri, 20 Oct 2023 14:56:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697810197;
        bh=rKfZfpFQKx5mNZYmDoPXgE0AS8y+IyTbCZMCDsJThSQ=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=GDpC5UdMeV5DzD30TDmYalwaFxn1hMovA+uu/S5FTUYpQLOeERNorFBCv4gofox3a
         iQA6F5vueG5gUgX35ADJg4EOCi6jjs6eY21q/pa39yr1ZqSYjjKjCgwzGK/969TA1a
         ZD80vCXwVQs5QZ7Fp8hi5dCAsRZHI4VfaYNHGMy9irZC2ugHd5gAfTjUt5o2TELaLx
         NNSy3+jXeodA0EwNPsMgld2HFkeALd3IYhjuAw5W4vfAGAukXsH2oh+5KKR5uvcpyV
         TkXjWb9sHYI4Zdcyg3hHeiZAWeHy2vT1Zb1lFmlY4N/wKlCEHNVwIcv+XfwNDi95a/
         Plz7SPiFE6kpg==
Message-ID: <38f132b8-4fd2-40e2-b24e-62164a0ee4e6@collabora.com>
Date:   Fri, 20 Oct 2023 18:56:07 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
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
Subject: Re: [RFC PATCH v2 6/8] mseal: Check seal flag for mremap(2)
Content-Language: en-US
To:     jeffxu@chromium.org, akpm@linux-foundation.org,
        keescook@chromium.org, jannh@google.com, sroettger@google.com,
        willy@infradead.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org
References: <20231017090815.1067790-1-jeffxu@chromium.org>
 <20231017090815.1067790-7-jeffxu@chromium.org>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20231017090815.1067790-7-jeffxu@chromium.org>
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

On 10/17/23 2:08 PM, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
> 
> mremap(2) can shrink/expand a VMA, or move a VMA to a fixed
> address and overwriting or existing VMA. Sealing will
> prevent unintended mremap(2) call.
> 
> What this patch does:
> When a mremap(2) is invoked, if one of its VMAs has MM_SEAL_MREMAP
> set from previous mseal(2) call, this mremap(2) will fail, without
> any VMA modified.
> 
> This patch is based on following:
> 1. At syscall entry point: SYSCALL_DEFINE5(mremap,...)
> There are two cases:
Maybe we can reduce the code duplication by bringing the check if memory is
sealed before call to mremap_to().

> a. going into mremap_to().
> b. not going into mremap_to().
> 
> 2. For mremap_to() case.
> Since mremap_to() is called only from SYSCALL_DEFINE5(mremap,..),
> omit changing signature of mremap_to(), i.e. not passing
> checkSeals flag.
> In mremap_to(), it calls can_modify_mm() for src address and
> dst address (when MREMAP_FIXED is used), before any update is
> made to the VMAs.
> 
> 3. For non mremap_to() case.
> It is still part of SYSCALL_DEFINE5(mremap,...).
> It calls can_modify_mm() to check sealing in the src address,
> before any update is made to src VMAs.
> Check for dest address is not needed, because dest memory is
> allocated in current mremap(2) call.
> 
> Signed-off-by: Jeff Xu <jeffxu@google.com>
> ---
>  mm/mremap.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index ac363937f8c4..691fc32d37e4 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -836,7 +836,27 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  	if ((mm->map_count + 2) >= sysctl_max_map_count - 3)
>  		return -ENOMEM;
>  
> +	/*
> +	 * Check src address for sealing.
> +	 *
> +	 * Note: mremap_to() currently called from one place:
> +	 * SYSCALL_DEFINE4(pkey_mprotect, ...)
> +	 * and not in any other places.
> +	 * Therefore, omit changing the signature of mremap_to()
> +	 * Otherwise, we might need to add checkSeals and pass it
> +	 * from all callers of mremap_to().
> +	 */
> +	if (!can_modify_mm(mm, addr, addr + old_len, MM_SEAL_MREMAP))
> +		return -EACCES;
> +
>  	if (flags & MREMAP_FIXED) {
> +		/*
> +		 * Check dest address for sealing.
> +		 */
> +		if (!can_modify_mm(mm, new_addr, new_addr + new_len,
> +				   MM_SEAL_MREMAP))
> +			return -EACCES;
> +
Move these two checks to just before call to mremap_to() in sys_mremap() or
even earlier. Or even better move the first condition before mremap_to()
and second condition can be checked before call to mremap_to().

>  		ret = do_munmap(mm, new_addr, new_len, uf_unmap_early);
>  		if (ret)
>  			goto out;
> @@ -995,6 +1015,11 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  		goto out;
>  	}
>  
> +	if (!can_modify_mm(mm, addr, addr + old_len, MM_SEAL_MREMAP)) {
> +		ret = -EACCES;
> +		goto out;
> +	}
> +
>  	/*
>  	 * Always allow a shrinking remap: that just unmaps
>  	 * the unnecessary pages..

-- 
BR,
Muhammad Usama Anjum
