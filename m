Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10F2634289
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 18:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbiKVReB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 12:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbiKVRdq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 12:33:46 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F297CB84
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 09:33:37 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id h7so9960238qvs.3
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 09:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y0TG7RSDJLBsFmv13T+kVLFnKE/Gs/+y0yFrl/WZR6s=;
        b=L0dZyDnVDHFIaOItmPGH7qgeLVW0usPCwRH/4nTimj8Xh9l2UXEZKNFm/ei9gDcq24
         Pk3u7Gq7lJi0kmr8z8NjnWgqP5s/GTGAjlS5nF3Rg8c28BPysVoaAoT/SPX3zkQcRIfE
         uip9ptnbHvWOX/Zei2bksChNqBhHUUkmXbxVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y0TG7RSDJLBsFmv13T+kVLFnKE/Gs/+y0yFrl/WZR6s=;
        b=Za7dLzb9mQMITiD2fheJDeM9KnbKhm8dmYS2DLHhfEBei3vn5Y9DQ1fKE/H7L1AGaJ
         qV5jRWGi/wcs6MxruaVX2IY/puUWBgJRs+S0/2mHFTN/VwMP8BvxGdnw01y1YVQRyvcX
         HOapJyoLVQtwqt31xWzKpk8MiKRKLVUppynKyHRR03rsHUJoEargY4MB6PGpnBQTRLrp
         YuayCOpkqyCBKrHj/FERhXLoTReyDQ1yQVOGL83cQDB1+z2/gU2phDbKZ98i7dh3lbg2
         GMltn83jlBlWXaKEZ4SwErPYJYOHx53rySNNvwpYRiTQbjgZ9FrScZKGSiMAXmIt/gzQ
         eu3g==
X-Gm-Message-State: ANoB5pl2F/sjJ7wNwX6fcPEwPBLQkxHGeTs8V1DshdeeWXbvhiRO3Cor
        xsxpwyn3d87jEDbCq25O/2zoZTn82YPF5g==
X-Google-Smtp-Source: AA0mqf6Gnosc4XbRizCI2uO72Y/cfpCDvpm9WnA3CXBKjVurbd86lrXzQGo+CBeVaR9tFaHOny4IOQ==
X-Received: by 2002:a0c:ef01:0:b0:4bb:d6bc:be1c with SMTP id t1-20020a0cef01000000b004bbd6bcbe1cmr4759970qvr.82.1669138416033;
        Tue, 22 Nov 2022 09:33:36 -0800 (PST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com. [209.85.222.182])
        by smtp.gmail.com with ESMTPSA id r13-20020a05620a298d00b006eee3a09ff3sm10611863qkp.69.2022.11.22.09.33.32
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 09:33:33 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id v8so10747336qkg.12
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 09:33:32 -0800 (PST)
X-Received: by 2002:a05:620a:1fa:b0:6ee:24d5:b8fc with SMTP id
 x26-20020a05620a01fa00b006ee24d5b8fcmr21656006qkn.336.1669138412298; Tue, 22
 Nov 2022 09:33:32 -0800 (PST)
MIME-Version: 1.0
References: <20221107161740.144456-1-david@redhat.com> <20221107161740.144456-17-david@redhat.com>
 <CAAFQd5C3Ba1WhjYJF_7tW06mgvzoz9KTakNo+Tz8h_f6dGKzHQ@mail.gmail.com> <6175d780-3307-854c-448a-8e6c7ad0772c@xs4all.nl>
In-Reply-To: <6175d780-3307-854c-448a-8e6c7ad0772c@xs4all.nl>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Nov 2022 09:33:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh0nuSn=zYB1z9bHXJRPi33mmbpv-Z6z7ARkHQupbQ3fQ@mail.gmail.com>
Message-ID: <CAHk-=wh0nuSn=zYB1z9bHXJRPi33mmbpv-Z6z7ARkHQupbQ3fQ@mail.gmail.com>
Subject: Re: [PATCH RFC 16/19] mm/frame-vector: remove FOLL_FORCE usage
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        David Hildenbrand <david@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kselftest@vger.kernel.org,
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
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 22, 2022 at 4:25 AM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> I tracked the use of 'force' all the way back to the first git commit
> (2.6.12-rc1) in the very old video-buf.c. So it is very, very old and the
> reason is lost in the mists of time.

Well, not entirely.

For archaeology reasons, I went back to the old BK history, which
exists as a git conversion in

    https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/

and there you can actually find it.

Not with a lot of explanations, though - it's commit b7649ef789
("[PATCH] videobuf update"):

    This updates the video-buf.c module (helper module for video buffer
    management).  Some memory management fixes, also some adaptions to the
    final v4l2 api.

but it went from

         err = get_user_pages(current,current->mm,
-                            data, dma->nr_pages,
-                            rw == READ, 0, /* don't force */
+                            data & PAGE_MASK, dma->nr_pages,
+                            rw == READ, 1, /* force */
                             dma->pages, NULL);

in that commit.

So it goes back to October 2002.

> Looking at this old LWN article https://lwn.net/Articles/28548/ suggests
> that it might be related to calling get_user_pages for write buffers

The timing roughly matches.

> I assume that removing FOLL_FORCE from 'FOLL_FORCE|FOLL_WRITE' will still
> allow drivers to read from the buffer?

The issue with some of the driver hacks has been that

 - they only want to read, and the buffer may be read-only

 - they then used FOLL_WRITE despite that, because they want to break
COW (due to the issue that David is now fixing with his series)

 - but that means that the VM layer says "nope, you can't write to
this read-only user mapping"

 - ... and then they use FOLL_FORCE to say "yes, I can".

iOW, the FOLL_FORCE may be entirely due to an (incorrect, but
historically needed) FOLL_WRITE.

             Linus
