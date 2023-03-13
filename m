Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F736B7D65
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Mar 2023 17:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjCMQ0I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Mar 2023 12:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCMQ0H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Mar 2023 12:26:07 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06BA2DE73
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Mar 2023 09:26:05 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id nf5so8553367qvb.5
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Mar 2023 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1678724765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ySLTlGrwz6oW+f8sFlLSgS6OiFk6jTO/4mJGRVwuTkU=;
        b=xAMIUDJFE3jM819ZTUErzGnW1a312jSUlvICyJX2o9vTCwqnhtx2ygELjCRyVf+XiC
         Rw3JKEQL3nTidz1EvLc1vMwJ0V/l8gF/O0kURWSMpygu+eI2SKLGgaLaGL+nklo5oVB9
         QScThBxuFtijKa9Xbf8EJtIISiw7AdM7ZI1jUTpl/TjtShKgN8NEYiBXDOBQqViXCUgK
         FfCYKa0tLSYU3LshWYlaIQDUHB8OAc2dzQd4x9tB/W2P6i0xGB8KM8B/YAXe+EsE4qKT
         VI82vrv5r/HJvY2x37Qdfwz/4wflQgkUlY6RUcivF50fg6IfbiA3dCuxmKXm1Hdsz4zf
         kTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678724765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySLTlGrwz6oW+f8sFlLSgS6OiFk6jTO/4mJGRVwuTkU=;
        b=swcqGZ2t1alopGSxqtEZk3wQJWTTib69WMh2r/Mw06DM8Yr9WgvQ/nFzJd7kcwC8QV
         23GRTH4udol9g43SryP2JR792kaZMvQ2BL7Z573EIq0gV05NCtr+zL7KfYPbMX9uuDrd
         1+S0iFjbpZh4Ktfk/1zG+vlkwWsHybzX1JR0jkITUC5XfJ0amchjeaoWh2Yg8ubfZcjy
         NGBgT1+RV7jmvXlznd/IbeQHhL5P/ww+BNc88B0wTBX7DKT81NDK4q+t9ODVH6Cr5rea
         ivch7Gz6T0SvvqsyPl20bxh6nsc1yQqf2oc5MV1bpYPWwHo32mcr8Arw7SK0FH0K8CV/
         e0xg==
X-Gm-Message-State: AO0yUKVr5hUPdKU5iK5w9mrLANkKJ7O7JS3zuPXdQNS6ETGf3kHqGpl+
        2UOjLuPtJ+DsBikQXhQfgiwiQQ==
X-Google-Smtp-Source: AK7set+HTJLvv62hY5uBNZqcsnd89WiHsgwusCnYu6ISinhxqnJaDD8TylUxF7V9gCMfZ6kLymlK+g==
X-Received: by 2002:a05:6214:2464:b0:56e:a918:a4ed with SMTP id im4-20020a056214246400b0056ea918a4edmr14771754qvb.1.1678724764783;
        Mon, 13 Mar 2023 09:26:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:d32c])
        by smtp.gmail.com with ESMTPSA id n188-20020a37bdc5000000b007456b2759efsm21679qkf.28.2023.03.13.09.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 09:26:04 -0700 (PDT)
Date:   Mon, 13 Mar 2023 12:26:03 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v4 1/3] mm: add new api to enable ksm per process
Message-ID: <20230313162603.GA965640@cmpxchg.org>
References: <20230310182851.2579138-1-shr@devkernel.io>
 <20230310182851.2579138-2-shr@devkernel.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310182851.2579138-2-shr@devkernel.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 10, 2023 at 10:28:49AM -0800, Stefan Roesch wrote:
> @@ -534,16 +534,58 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr,
>  	return (ret & VM_FAULT_OOM) ? -ENOMEM : 0;
>  }
>  
> +static bool vma_ksm_compatible(struct vm_area_struct *vma)
> +{
> +	/*
> +	 * Be somewhat over-protective for now!
> +	 */
> +	if (vma->vm_flags & (VM_MERGEABLE | VM_SHARED  | VM_MAYSHARE   |
> +			     VM_PFNMAP    | VM_IO      | VM_DONTEXPAND |
> +			     VM_HUGETLB | VM_MIXEDMAP))
> +		return false;		/* just ignore the advice */
> +
> +	if (vma_is_dax(vma))
> +		return false;
> +
> +#ifdef VM_SAO
> +	if (*vm_flags & VM_SAO)
> +		return false;
> +#endif
> +#ifdef VM_SPARC_ADI
> +	if (*vm_flags & VM_SPARC_ADI)
> +		return false;
> +#endif

These two also need to check vma->vm_flags, or it won't build on those
configs.

Otherwise, the patch looks good to me.
