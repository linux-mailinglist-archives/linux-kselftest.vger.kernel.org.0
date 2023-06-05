Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C5C722BFC
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 17:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjFEPzG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 11:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjFEPyo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 11:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1991B91
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 08:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685980442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wnGZe2ilus++rN8zbkaGZiYRKzaIR14IuW+BRuj6vnQ=;
        b=E0wU7soExzOBnhQmfCMYIpkGw/65jzCE9fXmLqykVge2tWci1nF9P+qaqh3dfEmIuud401
        r6dj1hEJKTHaCy1YxI6mYd0Wlrysp5Bzw+rNSCXHysM2+Blih18p+Ibt13dY/UjBqNKqZA
        KtOEvKEc8NP2uKDA5ILaCuFHQrBBFxU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-Xqlrn7M3NlSnUZqgjJ3Iwg-1; Mon, 05 Jun 2023 11:54:00 -0400
X-MC-Unique: Xqlrn7M3NlSnUZqgjJ3Iwg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75ec325d255so8794485a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jun 2023 08:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685980440; x=1688572440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnGZe2ilus++rN8zbkaGZiYRKzaIR14IuW+BRuj6vnQ=;
        b=QjOmo43B0c2YmD5lYH6XkjwIbduvzjy5JP7cbZoxLwm713bgNwejZ+PszdFKVV2N0Y
         XIJNUOCLoJX63PUP+eGQwu1PY7OwxJNyCsKRI4TrgoMDmNcbq+7gtMNzzjzKhwLA9/gN
         inxOBWoBIweaGDty8ifxxQhjUPegJjJWP3mHfiCu4//Q0qM3WpVgBAVdeaeILQ5/moRq
         hcAtOSMOWx0rcmpg2jqGM8EE0D3ENZczVQuir3Wbxz5eWZSIqN9PVxYTwl5g3S9T3tOe
         xEzH4i2eRwvLHYXP5h5hwlErlDCp3heolBkJg0gCX3aZKHGvH+qUN0DAg4j9t/oCiYPu
         ymHw==
X-Gm-Message-State: AC+VfDx7iLfyyO8M4bOs0u6+B0vClTirFB4TqUZX+r29yGJgVfkju3p4
        Ru3LMgtD7njgrJoCntqos5HHOJ4nVwVjBUwhA19stpCZ5KJv6qRsGRdmFtC/3a2gFtbVicgnBOl
        EIOLA832M258NOOuO0duMy/AwCoYJ
X-Received: by 2002:a05:620a:9489:b0:75e:c678:d49e with SMTP id sn9-20020a05620a948900b0075ec678d49emr863505qkn.2.1685980440270;
        Mon, 05 Jun 2023 08:54:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ61kcSxuNBntjQ5RQOTzn43/Y6bCUQxP8v4qMNgTUyCXWLS6gcFbCAUdXkDQjnyKfpjq/sYkQ==
X-Received: by 2002:a05:620a:9489:b0:75e:c678:d49e with SMTP id sn9-20020a05620a948900b0075ec678d49emr863494qkn.2.1685980440037;
        Mon, 05 Jun 2023 08:54:00 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id g14-20020ae9e10e000000b0075bcc5ab975sm4270572qkm.92.2023.06.05.08.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 08:53:58 -0700 (PDT)
Date:   Mon, 5 Jun 2023 11:53:57 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/11] selftests/mm: .gitignore: add mkdirty,
 va_high_addr_switch
Message-ID: <ZH4FFa4FV9KGwBZo@x1n>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
 <20230603021558.95299-6-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230603021558.95299-6-jhubbard@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 02, 2023 at 07:15:52PM -0700, John Hubbard wrote:
> These new build products were left out of .gitignore, so add them now.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  tools/testing/selftests/mm/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index 8917455f4f51..ab215303d8e9 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -39,3 +39,5 @@ local_config.h
>  local_config.mk
>  ksm_functional_tests
>  mdwe_test
> +mkdirty
> +va_high_addr_switch
> \ No newline at end of file

Maybe also the new gup_longterm?

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

