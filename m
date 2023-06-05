Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692CF722BC5
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 17:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbjFEPrL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 11:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbjFEPq6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 11:46:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AFFE4C
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 08:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685979841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uqr8cXAKFqCk2YnqjL4KjwaNLI7luK4gqpzwm6zg+eU=;
        b=Gr+zQTRE/ZGhQy7aFt7JVzvcMbhWK93g5uCK+DI0njsNFjCbPxQvMWPi6URAok60jJ0hMO
        PwDhq0BSiKU3tBmZrZ3MOVn7uv6JdzfuL7PBoobSB982Sm7WJHKCmfb5nFQG1WBmhRTcuF
        CvjbHJDIuVGCYF+2lxLbMwJNQj5Y/+I=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-b9swoD5MMPqn8WGx9hgmhg-1; Mon, 05 Jun 2023 11:43:59 -0400
X-MC-Unique: b9swoD5MMPqn8WGx9hgmhg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f9aa9aee8cso1362161cf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jun 2023 08:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685979838; x=1688571838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uqr8cXAKFqCk2YnqjL4KjwaNLI7luK4gqpzwm6zg+eU=;
        b=QvodbTAKQLXo1sTP5hRSsovHdk+7xv2yajAZNTwvhAXFcLwbwgByseGz+BfBP0yh3P
         VKuYDincdAc1Z9sNUpsC8csiAU2hsXwnlemJX7JSez/rHC8HjZ22mO23YX0VtXVLqb0H
         zDjG4orJaC75hMSrqC/lMdOE4B2qOO9+EMxX+Tf90SFor/8kVm1mlQQQgYud9MmtIhM3
         EgwZ1W/5cPK0H6XfsTQgJCDjxzFbjKA17Nxxj9z50xg+hlidjElol7oIp36NNeDzz6E+
         mBjCfE8p+4uekA+IlX+fpaR7lLkJz0yX0wKcBppF3EOYlOccXU/nn3Nzh8h2/1tCpU92
         pRAg==
X-Gm-Message-State: AC+VfDx7Z0a4Nl7Zg8Vc4iF9zVCBHxD4M8sndFGfkvvseT7WgVhpUFuQ
        ry2pPz6AGJtUxFu84bXHFRk1eWYNBkCjPOdxiaI5n1eTZ0iWe9g8bOxAtqLE5wx7pJSOX5ry7AZ
        gTN3XnvGkViiL6vD1tbL2407ruX24z4IHKz1G
X-Received: by 2002:ac8:5bcf:0:b0:3f6:b330:4bfb with SMTP id b15-20020ac85bcf000000b003f6b3304bfbmr22480313qtb.0.1685979838649;
        Mon, 05 Jun 2023 08:43:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5jznbCgExyaLNQztYMzHdFKbqFXFxr8ajJUyuToLJ3v/+o3EtdG/wbnhNA/zQiIpX8t+oH7Q==
X-Received: by 2002:ac8:5bcf:0:b0:3f6:b330:4bfb with SMTP id b15-20020ac85bcf000000b003f6b3304bfbmr22480298qtb.0.1685979838422;
        Mon, 05 Jun 2023 08:43:58 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id ey5-20020a05622a4c0500b003f6bbd7863csm3196694qtb.86.2023.06.05.08.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 08:43:57 -0700 (PDT)
Date:   Mon, 5 Jun 2023 11:43:56 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/11] selftests/mm: fix "warning: expression which
 evaluates to zero..." in mlock2-tests.c
Message-ID: <ZH4CvMFgu7IFFMwk@x1n>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
 <20230603021558.95299-4-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230603021558.95299-4-jhubbard@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 02, 2023 at 07:15:50PM -0700, John Hubbard wrote:
> The stop variable is a char*, and the code was assigning a char value to
> it. This was generating a warning when compiling with clang.
> 
> However, as both David and Peter pointed out, stop is not even used
> after the problematic assignment to a char type. So just delete that
> line entirely.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  tools/testing/selftests/mm/mlock2-tests.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/mlock2-tests.c b/tools/testing/selftests/mm/mlock2-tests.c
> index 11b2301f3aa3..80cddc0de206 100644
> --- a/tools/testing/selftests/mm/mlock2-tests.c
> +++ b/tools/testing/selftests/mm/mlock2-tests.c
> @@ -50,7 +50,6 @@ static int get_vm_area(unsigned long addr, struct vm_boundaries *area)
>  			printf("cannot parse /proc/self/maps\n");
>  			goto out;
>  		}
> -		stop = '\0';
>  
>  		sscanf(line, "%lx", &start);
>  		sscanf(end_addr, "%lx", &end);

I'd rather simply make it "*stop = '\0'", or as David suggested dropping
stop completely when we're it (assumes that scanf() will always work with
number ending with space ' ').

No strong opinion here, though.

-- 
Peter Xu

