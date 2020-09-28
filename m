Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F5227AE78
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Sep 2020 14:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgI1M5l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Sep 2020 08:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgI1M5l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Sep 2020 08:57:41 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A8AC0613CE
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Sep 2020 05:57:40 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v54so595781qtj.7
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Sep 2020 05:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wDoFUE99bIcRGspOXbo3zjmN4PbXIvPVJjhLWXzP2ws=;
        b=fh+YvJ9Brb4kYYngrH/s/qYqgriElu1sQclUqqsUqnI6iNy73Lw71pmIIPHLpV9j4W
         59/nCSWYfA/9pGsQa331v3pqyC5dMWH3s2EMmVDI+3A4EQ+MyDFAIwCT5zkaVKiutdiD
         WSUcE1foff3Wj638oHgA24KPnv6GD0y1GudgeynBKA6Nu51WFE993W/MIKFGyZ3ush6d
         ABAxCR8X8x/SGd7waBLsiY7M4rWb0PJpGnacZAdQ3fZPhRYbBVf3YEiCJS3URIz0mZTj
         AHIvDqoKW/ZwBWN2LF3qlDVUxFT7tspnHuVo9Kgx5rmhoUybDzdx4349SK5guLHxC5T+
         0b0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wDoFUE99bIcRGspOXbo3zjmN4PbXIvPVJjhLWXzP2ws=;
        b=g1qom591b+/BrmJvXgoja3k34Reh/wvr/RKEqaXXEXvxBXr9CWA//gTzSU6KHrdfdo
         AjMUPn3xeJbfng5Co/5qa26r99Aq3mNr72Y7561rAmpf5YbY+j8UnQXzKUJbILxD+R1x
         80ob91bpR+dCpFQAGK26rV8vseWco60y74PpfGVCbgyL1ZI3bj9o9Y7Zg4F3AvxYKVVM
         jD46kUcT6pCrFD99pVXY1ienRhLxn+4MJPvhA6inLkvR+CxnJWT8zTQ4/QyOvtmfXauB
         FEoifSr5UxZeFTPte1cn8BWleyS4vDU7tzxuI/JDFa74/nhiz8xX6UFjT+uvT+9qx34F
         TZmQ==
X-Gm-Message-State: AOAM532JJSBWvV8NojBDef7UPC0B+7KsAIheZQSbU9kHpdcQYb7CwKGJ
        5ZCUlDLdux9fNPyNgzjmdncBNQ==
X-Google-Smtp-Source: ABdhPJxCKooSFDLWgOXoraPDbg4q0zhejQPruckFKr8pWCDzdZCLrg6aCuKusJtuOinatJbK6F9iAw==
X-Received: by 2002:ac8:4a93:: with SMTP id l19mr1379042qtq.163.1601297860267;
        Mon, 28 Sep 2020 05:57:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id d22sm857359qkj.93.2020.09.28.05.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 05:57:39 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kMsip-001uld-4v; Mon, 28 Sep 2020 09:57:39 -0300
Date:   Mon, 28 Sep 2020 09:57:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/8] selftests/vm: use a common gup_test.h
Message-ID: <20200928125739.GP9916@ziepe.ca>
References: <20200928062159.923212-1-jhubbard@nvidia.com>
 <20200928062159.923212-3-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928062159.923212-3-jhubbard@nvidia.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Sep 27, 2020 at 11:21:53PM -0700, John Hubbard wrote:
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index d1ae706d9927..9cc6bc087461 100644
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -130,3 +130,5 @@ endif
>  $(OUTPUT)/userfaultfd: LDLIBS += -lpthread
>  
>  $(OUTPUT)/mlock-random-test: LDLIBS += -lcap
> +
> +$(OUTPUT)/gup_test: ../../../../mm/gup_test.h

There is no reason to do this, the auto depends will pick up header
files, and gup_test.h isn't a generated file

Jason
