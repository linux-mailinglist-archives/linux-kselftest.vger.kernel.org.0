Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3802C6E20AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 12:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjDNK0H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 06:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjDNK0G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 06:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BD24EF3
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 03:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681467904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QcY9UQN+sgDIeuyeA2i6LuRS8ISnfWHgkBht0s/19qA=;
        b=BHLCDZx8gCJweJzPMMZsMXXu4/ilnZLXDjuyBwzZMNXuPggmWbVihuerV4dgjE/Oy/FFnv
        yTxLZRQE8Vx6RvBB03PCF4lRyafAKuN0QTxkMA/v7HkX8tGfp9j4emUy5Ck1QuRLFha9Dy
        yte78GMaFa7tvZCpT1m6imHMjkmDnbI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-VsK5JGIfPzalnQxfQLaOiw-1; Fri, 14 Apr 2023 06:25:03 -0400
X-MC-Unique: VsK5JGIfPzalnQxfQLaOiw-1
Received: by mail-wm1-f71.google.com with SMTP id bh6-20020a05600c3d0600b003f0a1353fe2so3256303wmb.0
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 03:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681467902; x=1684059902;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QcY9UQN+sgDIeuyeA2i6LuRS8ISnfWHgkBht0s/19qA=;
        b=l8IbVjPkTukbRLidm24ynrD+jP6reCkpCxwxePecvoyrGEHwvR2tfWWK2eSag2QUdZ
         5xaNLZa+3NHmYuVfALQ2i74C615hnmcP3yc1cRHcrZoaXJwAm/9+Lwp4g0EZlCBzDCsX
         s067WNsZcJjy/g2ah6T4kBKJbXhe/hgw8ZN1J/qzHrCvW+GI+cekDpaKo5C62keDDUNo
         Fq+l0NWwgKQodupty3HsRRdSoDYSnLP1Q8K7CmdJH+lAd8cxhNYsYwEgw5oxoidZP6jb
         nYEEYdzhs0LAKC4agMmOgF6K+IIbJp0pmo9gEcL/dvr/G+9OQ7ShbjIwKN3p3YrtSxNk
         HHew==
X-Gm-Message-State: AAQBX9fNqMCybOoqcl8PXyTohZhGT2QmLLyH5tcAZWurhDxNC5vLLjJP
        9BoAclcFnQI+SPkJjnXkHub8s/jxs2IN82p20zn1bc39rhhxXAIlGXlS1m1+CKlnzJPTPt4+ZBr
        azEJ89pIo6ow5Z9bfhzUq17kDH9m9
X-Received: by 2002:a1c:f60a:0:b0:3ed:9ce3:4a39 with SMTP id w10-20020a1cf60a000000b003ed9ce34a39mr4168147wmc.26.1681467901817;
        Fri, 14 Apr 2023 03:25:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350aE0fJ16pyJLzb3fBgzbhX9M+NiOEOq9BBo6MIjOgyR17TW6oYD8CgWOQk9CaCcb1Vv4AXb3A==
X-Received: by 2002:a1c:f60a:0:b0:3ed:9ce3:4a39 with SMTP id w10-20020a1cf60a000000b003ed9ce34a39mr4168127wmc.26.1681467901399;
        Fri, 14 Apr 2023 03:25:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5700:cb5b:f73a:c650:1d9? (p200300cbc7025700cb5bf73ac65001d9.dip0.t-ipconnect.de. [2003:cb:c702:5700:cb5b:f73a:c650:1d9])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003ee74c25f12sm7605573wms.35.2023.04.14.03.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 03:25:00 -0700 (PDT)
Message-ID: <d2df2d42-66bd-3b7a-99a1-370cc91906e4@redhat.com>
Date:   Fri, 14 Apr 2023 12:24:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, willy@infradead.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <20230413233115.1878303-1-shr@devkernel.io>
 <20230413233115.1878303-2-shr@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v7 1/3] mm: add new api to enable ksm per process
In-Reply-To: <20230413233115.1878303-2-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thanks!

In general,

Acked-by: David Hildenbrand <david@redhat.com>

Two nits below, after staring at some other prctl implementations.

> +#define PR_SET_MEMORY_MERGE		67
> +#define PR_GET_MEMORY_MERGE		68
>   #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 495cd87d9bf4..8c2e50edeb18 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -15,6 +15,7 @@
>   #include <linux/highuid.h>
>   #include <linux/fs.h>
>   #include <linux/kmod.h>
> +#include <linux/ksm.h>
>   #include <linux/perf_event.h>
>   #include <linux/resource.h>
>   #include <linux/kernel.h>
> @@ -2661,6 +2662,30 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>   	case PR_SET_VMA:
>   		error = prctl_set_vma(arg2, arg3, arg4, arg5);
>   		break;
> +#ifdef CONFIG_KSM
> +	case PR_SET_MEMORY_MERGE:

Looking at some other code (PR_SET_NO_NEW_PRIVS/ PR_SET_THP_DISABLE) I 
wonder if we also want

if (arg3 || arg4 || arg5)
	return -EINVAL;

For PR_GET_MEMORY_MERGE it looks good already.

> +		if (mmap_write_lock_killable(me->mm))
> +			return -EINTR;
> +
> +		if (arg2) {
> +			error = ksm_enable_merge_any(me->mm);
> +		} else {
> +			/*
> +			 * TODO: we might want disable KSM on all VMAs and
> +			 * trigger unsharing to completely disable KSM.
> +			 */
> +			clear_bit(MMF_VM_MERGE_ANY, &me->mm->flags);
> +			error = 0;
> +		}
> +		mmap_write_unlock(me->mm);
> +		break;
> +	case PR_GET_MEMORY_MERGE:
> +		if (arg2 || arg3 || arg4 || arg5)
> +			return -EINVAL;
> +
> +		error = !!test_bit(MMF_VM_MERGE_ANY, &me->mm->flags);
> +		break;
> +#endif
>   	default:
>   		error = -EINVAL;
>   		break;

[...]

> +/**
> + * ksm_enable_merge_any - Add mm to mm ksm list and enable merging on all
> + *                        compatible VMA's
> + *
> + * @mm:  Pointer to mm
> + *
> + * Returns 0 on success, otherwise error code
> + */
> +int ksm_enable_merge_any(struct mm_struct *mm)
> +{
> +	int err;
> +
> +	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
> +		return -EINVAL;


I'm curious, why is enabling the prctl() supposed to fail if already 
enabled? (it would not fail if disabling and already disabled)

For example, PR_SET_THP_DISABLE/PR_SET_NO_NEW_PRIVS doesn't fail if 
already set.

-- 
Thanks,

David / dhildenb

