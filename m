Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B53692F4E
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Feb 2023 09:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjBKISF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 11 Feb 2023 03:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBKISE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 11 Feb 2023 03:18:04 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13095311E0;
        Sat, 11 Feb 2023 00:18:03 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id r17so4973337pff.9;
        Sat, 11 Feb 2023 00:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rW1BUSMrAhrgql9xxXVd047UVudLKi81PnrH+oLQFDk=;
        b=mQCPAzWfOgLYC4qODRKK/T87mp9xSEFeVo9A4LGi3kdivVhsxe+22zzSO+cChGtl/V
         d3PSYmNQMMMae0idpmILhADiHWN+LZII/ChSF4AwIo9KABUJB8Mh4TT+AIzk5s93jyZe
         uDvkBv4gJSquGbaa9TSN2/h9mZqU8ofUu6P6enmwXSIIQ1AQz385sgbMIJa+J6owZ/It
         62VSgk1jt9QTmU/rvZToHuMYV6RG1DcbdH9VcKN7GveOsaE/0EVdO93lEznT3nU1wVWS
         osOA/wK9pOFwW1EBaXXvbMnAeKEXnUAwaodzGNdp2sUvf6mLQYoJPMzA8jbm0/gtdUQH
         kFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rW1BUSMrAhrgql9xxXVd047UVudLKi81PnrH+oLQFDk=;
        b=QvT/rmm8bj2rX7hKQuqPfhlJsjLKGiSzHmUI+fnVQmLHD1UugjjagVJSERlIx3YbEG
         tYfL7XtFRX2quYOi0q+Jo6jMHvnzXjx3+UcjVfJaNTvdsZPKi/O9vTkPUiY2oqqeYFV9
         VqlDUBk0bc2pxVL1S8tKFuxN+BXkOZRohMz8aWWjHf+GXxMXFkAu8NiN18aicG3RqxIE
         xiU+S9xpYFBL7AQtKLbpJDejnPhAVsxhUay3MiqjnhP6rRF8yg/DQMjnjx7DenwplzEg
         UX512txMDWdwYz23R3aH6KiNWH5z8ZUToGKFcnB6y8hfEsEheuWeLl02wsQZLvmIKUYb
         wnDQ==
X-Gm-Message-State: AO0yUKVFe0Kj4m4QoFjJyxGRYaxoWhLyPveRqng1x7/1LbuPEzjrzOUG
        bPAjtsRxUs1Um+6R10H0KuuEGBr94qA=
X-Google-Smtp-Source: AK7set9VLKH+usjF9sXvLVOUzWF+B/aliECXdUwnqlV6PwGm2640y3tu5l+HODFuNrfkb3kwe68svA==
X-Received: by 2002:a62:7bd6:0:b0:587:f436:6ea8 with SMTP id w205-20020a627bd6000000b00587f4366ea8mr14567193pfc.16.1676103482489;
        Sat, 11 Feb 2023 00:18:02 -0800 (PST)
Received: from [192.168.43.80] (subs32-116-206-28-35.three.co.id. [116.206.28.35])
        by smtp.gmail.com with ESMTPSA id a23-20020a62bd17000000b005a816b7c3e8sm4424615pff.24.2023.02.11.00.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 00:18:02 -0800 (PST)
Message-ID: <e373069e-b68a-a924-d4be-742f7040a7e1@gmail.com>
Date:   Sat, 11 Feb 2023 15:17:57 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH v2 09/19] docs: document general_profit sysfs knob
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org
References: <20230210215023.2740545-1-shr@devkernel.io>
 <20230210215023.2740545-10-shr@devkernel.io>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230210215023.2740545-10-shr@devkernel.io>
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
> Document general_progit knob.

Book about Git :); it should have been general_profit.
 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-ksm b/Documentation/ABI/testing/sysfs-kernel-mm-ksm
> index d244674a9480..7768e90f7a8f 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-ksm
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-ksm
> @@ -51,3 +51,11 @@ Description:	Control merging pages across different NUMA nodes.
>  
>  		When it is set to 0 only pages from the same node are merged,
>  		otherwise pages from all nodes can be merged together (default).
> +
> +What:		/sys/kernel/mm/ksm/general_profit
> +Date:		January 2023
> +KernelVersion:  6.1
> +Contact:	Linux memory management mailing list <linux-mm@kvack.org>
> +Description:	Measure how effective KSM is.
> +		general_profit: how effective is KSM. The formula for the
> +		calculation is in Documentation/admin-guide/mm/ksm.rst.
> diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
> index f160f9487a90..5c4daf44d79d 100644
> --- a/Documentation/admin-guide/mm/ksm.rst
> +++ b/Documentation/admin-guide/mm/ksm.rst
> @@ -159,6 +159,8 @@ stable_node_chains_prune_millisecs
>  
>  The effectiveness of KSM and MADV_MERGEABLE is shown in ``/sys/kernel/mm/ksm/``:
>  
> +general_profit
> +        how effective is KSM. The calculation is explained below.
>  pages_shared
>          how many shared pages are being used
>  pages_sharing

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

