Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BDB692F50
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Feb 2023 09:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBKIS7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 11 Feb 2023 03:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBKIS7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 11 Feb 2023 03:18:59 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7571E311E1;
        Sat, 11 Feb 2023 00:18:58 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso12469927pjj.1;
        Sat, 11 Feb 2023 00:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f5Y2IOJ6Y1jzGi1sXY9QnheXqq2KoQrWJa2bEZkQXhM=;
        b=PHWRqsM2t//NUHRQ3OJjcioM2MQNLfcFn0kD/XW0BHs0MrNxxxAylvSg0vH8UAuWSH
         chxSwFwB/fBdAY3WJz4ZMP3Im0dU2kiUNqGcjVnNFGG46G8Xj7AbE3hyRfA8CKufC7v9
         6f96gEPXMVF5FIYImi0MztNbWrOYeit+eUxsTxOrE4cwK+z/p2bY+pQK/ciaPjcoEDhe
         GKrhKuC+pVf/JCbdIHVlNMPvflxrVpWgHVGiuhlNBtDHWl2WBdK6jexQMd5ygnZb9oyo
         Mt23WiIKUkZxspDAUZvF2pabUMjljBpuIqeQ3NUu5vHChwj6cXSPT8I5Ehh0LNPZO9Up
         fuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5Y2IOJ6Y1jzGi1sXY9QnheXqq2KoQrWJa2bEZkQXhM=;
        b=kcaYU2NN0V4UXUhyYiJ9yjxNtmAvLP/kr67Su77jdDnopekwnlzKOvYgf2X4l6+vZn
         FSyZEoEZbf8BwOvX1ZRPRGGP4OFU4E7gAFDJcyiMoq8tI4WduXyyV5LoulfLceljlfTf
         ROCU6rh4QgH05wg9EEWVKPR64FAWChiG9EBjeEpEbw6M5F9s9q8ZhihmMp8B30TgV3+d
         vjJhELxcOGVG0+ScW5oL7nZi90jQvO2JPBAh92qp7v95qhdhxFtVDZReLeXJH7T1gzDr
         taIo8SgndYNMbGGCrIE6oM+iGYzVMjjCyGR4HCcb/pzc7R7luNm4L6uHP/BZZJrPisnp
         68qQ==
X-Gm-Message-State: AO0yUKWkOQluoTWMefIj8yntMnSjBiEF4VkxRMdFu0EUi8BhqGwINcmB
        gnR/BLC0MkeDG5m60xa971U=
X-Google-Smtp-Source: AK7set8l4vNHP7jm4zzR0JmMhos4cGV/JAr7ZGeAuHUuOPKPQGTkzCR/W7ftgqZwSOwAOd85Wi4siw==
X-Received: by 2002:a17:902:eb83:b0:198:f45c:853c with SMTP id q3-20020a170902eb8300b00198f45c853cmr9630060plg.25.1676103537911;
        Sat, 11 Feb 2023 00:18:57 -0800 (PST)
Received: from [192.168.43.80] (subs32-116-206-28-35.three.co.id. [116.206.28.35])
        by smtp.gmail.com with ESMTPSA id b10-20020a1709027e0a00b001994fc55998sm4429585plm.217.2023.02.11.00.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 00:18:57 -0800 (PST)
Message-ID: <48c904ba-cb25-dc55-4ea1-a5efcdcd8c34@gmail.com>
Date:   Sat, 11 Feb 2023 15:18:53 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH v2 14/19] docs: document new procfs ksm knobs
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org
References: <20230210215023.2740545-1-shr@devkernel.io>
 <20230210215023.2740545-15-shr@devkernel.io>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230210215023.2740545-15-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/11/23 04:50, Stefan Roesch wrote:
> diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
> index 5c4daf44d79d..34f1d0396eee 100644
> --- a/Documentation/admin-guide/mm/ksm.rst
> +++ b/Documentation/admin-guide/mm/ksm.rst
> @@ -218,7 +218,8 @@ several times, which are unprofitable memory consumed.
>  			  ksm_rmap_items * sizeof(rmap_item).
>  
>     where ksm_merging_pages is shown under the directory ``/proc/<pid>/``,
> -   and ksm_rmap_items is shown in ``/proc/<pid>/ksm_stat``.
> +   and ksm_rmap_items is shown in ``/proc/<pid>/ksm_stat``. The process profit
> +   is also shown in ``/proc/<pid>/ksm_stat`` as ksm_process_profit.
>  
>  From the perspective of application, a high ratio of ``ksm_rmap_items`` to
>  ``ksm_merging_pages`` means a bad madvise-applied policy, so developers or
> @@ -229,6 +230,9 @@ so if the ``ksm_rmap_items/ksm_merging_pages`` ratio exceeds 64 on 64-bit CPU
>  or exceeds 128 on 32-bit CPU, then the app's madvise policy should be dropped,
>  because the ksm profit is approximately zero or negative.
>  
> +The ksm_merge_type in ``/proc/<pid>/ksm_stat`` shows the merge type of the
> +process. Valid values are ``none``, ``madvise`` and ``process``.
> +
>  Monitoring KSM events
>  =====================
>  

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

