Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4D4620117
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 22:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiKGV0R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 16:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbiKGV0H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 16:26:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7011FDE5;
        Mon,  7 Nov 2022 13:26:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 681A7CE1836;
        Mon,  7 Nov 2022 21:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9495CC43146;
        Mon,  7 Nov 2022 21:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667856362;
        bh=SwQyXyRosovtBDcr7GfPt6fsp4ng05oq/t3fG7dB68g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ffvHIqojBVLH/R8RQOQEgXCeTITmfwvIoxefm2/kBiEz2OyLI9Io4TDxW06ogg/sN
         3fWSVwLP7C1LXRhdThBd1UCmwrb62aNwnwPhsnjD194IsHOpRrxOtn/gP3z8BLEjEE
         3a6gLv9bTBbYeKfi6puWXH9+gHFk4yKiM4mbbf1kJMaVXq4O7YS4IPezgSwqAiw6dg
         aWWwBH05mwWpElBiERd2AjzW1oA4IQ2N8kMYhhPV076879Sxylya1gjvFB6S75Ki6D
         YSxGBZQ+IsbaVRLSlTBJcnreOKfX2foV+YDEFOPtCI4Hb73C8fJ5KP2ecXZ+zVPCe3
         Yxz5zRAEx0Q+g==
Received: by mail-yb1-f169.google.com with SMTP id j130so15158729ybj.9;
        Mon, 07 Nov 2022 13:26:02 -0800 (PST)
X-Gm-Message-State: ANoB5plSB68OZ+YlugLT+B1aiH52aXAGrNy8amNPjlBov+mnscikxPu8
        hKgdN9sUOuKN+ilwdyRBIeHLJrKlJ4LFVTU5tAs=
X-Google-Smtp-Source: AA0mqf57IeLMapCs6BKe1PyHfS6JiZC8g/49BGtedtXgLWmUCCwX95DungbNLQq9eDdaj9K/AImhyOL53rs80CSF5uA=
X-Received: by 2002:a25:2389:0:b0:6d8:7f81:edaf with SMTP id
 j131-20020a252389000000b006d87f81edafmr3849061ybj.443.1667856361598; Mon, 07
 Nov 2022 13:26:01 -0800 (PST)
MIME-Version: 1.0
References: <20221107161740.144456-1-david@redhat.com> <20221107161740.144456-20-david@redhat.com>
In-Reply-To: <20221107161740.144456-20-david@redhat.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 7 Nov 2022 23:25:35 +0200
X-Gmail-Original-Message-ID: <CAFCwf12AtZ3jqJf8fTmq+bK5Z109N_k4WG1nuDmMXoBNA3KMmA@mail.gmail.com>
Message-ID: <CAFCwf12AtZ3jqJf8fTmq+bK5Z109N_k4WG1nuDmMXoBNA3KMmA@mail.gmail.com>
Subject: Re: [PATCH RFC 19/19] habanalabs: remove FOLL_FORCE usage
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 7, 2022 at 6:19 PM David Hildenbrand <david@redhat.com> wrote:
>
> FOLL_FORCE is really only for debugger access. As we unpin the pinned pages
> using unpin_user_pages_dirty_lock(true), the assumption is that all these
> pages are writable.
>
> FOLL_FORCE in this case seems to be due to copy-and-past from other
> drivers. Let's just remove it.
>
> Cc: Oded Gabbay <ogabbay@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/misc/habanalabs/common/memory.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
> index ef28f3b37b93..e35cca96bbef 100644
> --- a/drivers/misc/habanalabs/common/memory.c
> +++ b/drivers/misc/habanalabs/common/memory.c
> @@ -2312,8 +2312,7 @@ static int get_user_memory(struct hl_device *hdev, u64 addr, u64 size,
>         if (!userptr->pages)
>                 return -ENOMEM;
>
> -       rc = pin_user_pages_fast(start, npages,
> -                                FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
> +       rc = pin_user_pages_fast(start, npages, FOLL_WRITE | FOLL_LONGTERM,
>                                  userptr->pages);
>
>         if (rc != npages) {
> --
> 2.38.1
>
>
Acked-by: Oded Gabbay <ogabbay@kernel.org>
Thanks,
Oded
