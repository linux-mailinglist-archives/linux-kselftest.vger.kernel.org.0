Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0371962D025
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 01:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238998AbiKQAsT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 19:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239043AbiKQArf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 19:47:35 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD074716D5
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 16:46:05 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id v8so212446qkg.12
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 16:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rT9xjSJmKp4cCvf16bTKl9Dc4YEY7MjOtsK/w44qv+E=;
        b=VV2cb+pd6jfcSL2tauZE67KBioAHcybPQR+VfU40dKebsvpG7CB3+xd0Uv8h8MKz8R
         sbSQ7TqeMCU61fYQIjRwQoQBWrCcg8ekkdEQ8V7xYjRGPq0DN+C0Atnpvt0eAux7Zvaz
         PXr7WI31PYcmErRNWRYdBKljCyptLiKShcOF4gqH5bxcH7c9a48sUWSu+SLW+D60rEcT
         94q2cJm8yEvdEzbYpl0Vwvwu6uXwvrse0KXhbaR5xd9/LECZYdD6vR+hmUeAJTlxbvcq
         ueSGRE+vNlUSsDE90kXWUWeAcS6lHSqHDXkbeBbAuFPPnKLrO2HgUtltNTPZxflFTx6j
         B+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rT9xjSJmKp4cCvf16bTKl9Dc4YEY7MjOtsK/w44qv+E=;
        b=zZOLXD27Zy6IzuSWU8oUQOe9hRDKnhyUbm55wK+wj3WSYR4P/lu8ev0m5iypHxQqUs
         4yf4cjQyVuZhsbxIej4oZg3L/H5DTko52Skg6J+LYD4nnO9YzKc8SK6RwB65cq9BkHis
         hu+oF+133a2bAP31HKqDlqDJxEJ5ezVv35WoFKSHYNgVNbQqEIjpgz9H1/KzYF0EPuu6
         skqTdsU+gTncFZKnbuyy+NWxIJCDDxpXE6jnUD0Gv+wVYq+LVirVDbFfAlMQUBBdTHky
         CvBgSrLuDnXFtgzU5GwxRk3MhAEJLtP4NSAn2p/nUM/8bNcIx/DdyLpTJBjbKyXsWN+Z
         sSOQ==
X-Gm-Message-State: ANoB5pkszZAxIfh9Fisy2YDeB8FkhYGCc4ChGVfgO3VqlQMgruykesNI
        AVg1FlF49aGZ/vxohwXMIFYq+A==
X-Google-Smtp-Source: AA0mqf607w9C7cuVA1Gk/5OO594s7B3KGBk4c2yq8D1+/1YgY/KvFwESfDj3NEnwxZjz0MAqyk7Deg==
X-Received: by 2002:a37:424c:0:b0:6fb:a0ec:c5ba with SMTP id p73-20020a37424c000000b006fba0ecc5bamr8177915qka.493.1668645964499;
        Wed, 16 Nov 2022 16:46:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id i18-20020a05620a405200b006fa84082b6dsm11394495qko.128.2022.11.16.16.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 16:46:03 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1ovT2Z-0066UZ-3n;
        Wed, 16 Nov 2022 20:46:03 -0400
Date:   Wed, 16 Nov 2022 20:46:03 -0400
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
        Bernard Metzler <bmt@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH mm-unstable v1 12/20] RDMA/siw: remove FOLL_FORCE usage
Message-ID: <Y3WES5adl6yyS4ZB@ziepe.ca>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-13-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116102659.70287-13-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 16, 2022 at 11:26:51AM +0100, David Hildenbrand wrote:
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
> Cc: Bernard Metzler <bmt@zurich.ibm.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/infiniband/sw/siw/siw_mem.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
