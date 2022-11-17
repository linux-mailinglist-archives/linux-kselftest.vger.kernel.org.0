Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5734962D01C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 01:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239017AbiKQAre (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 19:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbiKQAqz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 19:46:55 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5C670180
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 16:45:47 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id n18so198696qvt.11
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 16:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6GmH5bBgQAPTYyWGM7n52ZkzuQiQsRGb4mBRnSjjrbs=;
        b=l2lxIbefVRjdcatsHe8zxGxmcFT5QX0zkZlGmTA+6hS7woiLsGV9I6bNGV4zHN8kjb
         l2p/UcY6CYSTNWmi7VujvEPDLopmeYV5y04nexmylfHHZLvrChhtK9ZoFHB8KXFnQm2L
         u2KxlP3m/08gOzMOWFz7wJqhAgcRBAizzZiUHkaGNmUyt44/uIl+uDznkLyQC/8LtiyK
         IYJyOaMVreNHxUrE7KnyIf6buUGiBVrXdyfdI9hycSXNdg6N07L9Zen1tNKJCn4NMx7j
         3tR7ySmG4oePdK/F1paF+sUf2cgVO41erHwEOTLPwwAJA2UwmtpAOpPTOIoYWmh1mJkM
         +oJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GmH5bBgQAPTYyWGM7n52ZkzuQiQsRGb4mBRnSjjrbs=;
        b=msETiLwGz9qI84Wal+s3svS76BHT0LeRxAQ8y76dOpgUjuDTNWo9/1hUOxeXzbAJcV
         XXzRrwrqhyKmYliy3yoSa51cbVvyijrF0+kI5d3IkkWouAT5ZX5WW6QyqOKPHIiUDvNQ
         vGl7EHj9f9ye67oRj/PLe7tF0oueKEtvH5XBj0Xsbt3ESKaDd23Pa0/KVWEZLxrwo9Ya
         C0L+8whKt5QWEi+RN2tgRdODUEZg3+yEvKKizTtsF7QQU5Wkl3aSwPA5Zq5plsiuPOXs
         0Uu/vU2pg61UjW7LPWnqQW7+fCHhfQe0CfSMToVJLIbm/4NFOMHXvtbhNKtwOCquyCpe
         tySA==
X-Gm-Message-State: ANoB5pnetoZ6EzJUlYypIy7msBETBrarqcMmAoTB1R8/+v/72b1yco/y
        7qRePPrqMBctaF2rzL2y2SYPgw==
X-Google-Smtp-Source: AA0mqf6kOndX6mF3jdPV+JEPNJmYotlDtU6GG3yPlrdGFCMTOM0aazChCn63y+VS5Enp4BFgjok9CA==
X-Received: by 2002:a05:6214:7f3:b0:4c6:5acc:1e24 with SMTP id bp19-20020a05621407f300b004c65acc1e24mr626072qvb.61.1668645946250;
        Wed, 16 Nov 2022 16:45:46 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id h2-20020ac85042000000b003a606428a59sm2189506qtm.91.2022.11.16.16.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 16:45:45 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1ovT2G-0066Tl-Ts;
        Wed, 16 Nov 2022 20:45:44 -0400
Date:   Wed, 16 Nov 2022 20:45:44 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH mm-unstable v1 11/20] RDMA/usnic: remove FOLL_FORCE usage
Message-ID: <Y3WEONlxYkwrglYR@ziepe.ca>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-12-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116102659.70287-12-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 16, 2022 at 11:26:50AM +0100, David Hildenbrand wrote:
> GUP now supports reliable R/O long-term pinning in COW mappings, such
> that we break COW early. MAP_SHARED VMAs only use the shared zeropage so
> far in one corner case (DAXFS file with holes), which can be ignored
> because GUP does not support long-term pinning in fsdax (see
> check_vma_flags()).
> 
> Consequently, FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM is no longer required
> for reliable R/O long-term pinning: FOLL_LONGTERM is sufficient. So stop
> using FOLL_FORCE, which is really only for ptrace access.
> 
> Cc: Christian Benvenuti <benve@cisco.com>
> Cc: Nelson Escobar <neescoba@cisco.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/infiniband/hw/usnic/usnic_uiom.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
