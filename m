Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8773B62BABD
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 12:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiKPLEf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 06:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237851AbiKPLEU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 06:04:20 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7561F49B6E
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 02:50:35 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id gv23so10364259ejb.3
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 02:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdwJ/650wADnRoR72oyZkQ8DiIzSWQSpq6IdxtCR+gY=;
        b=f2SpOZdEZzXCSPn0ykm1oJX1As7I6xxh5wr16pOd/kbA5OOiuO0Y4IWH35k28OjNoj
         wHiTHItpgbOeFMLRaKE+zMy2u3TZ9N8dtmICEQujo3Me7a5E74OF+31ufRLy1oYVFEA1
         T3Nbw0vHjZlr/vzIiD2dpwD9w/oFbF5Q800Lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mdwJ/650wADnRoR72oyZkQ8DiIzSWQSpq6IdxtCR+gY=;
        b=BQ2z/2a9i4VIdNoiH3wl7sD5vMfeglZDB/fuWhtlVdav89fivYuutAeDno25icHQv6
         LlTHu0FSzvYOPzXGneZ8UaCSmMPnasbjGl1NRjkAeTLW5IsBzfNwr7/NiCsAeaBIXbMH
         aFNycdAnqGeT8D/SOB6BDhFQ802A9xKbXVDRVoHTvaZzrNN9wtKukKyh7upSqX/G4FZu
         cgH7ofl86qKZIAN+dUdPYm2BJACvsjAmqZeqRd9fleHU+OOa4VkE4/sOSwZlXjG6h+PS
         po0gVO9XAyFLPpEPKGRHK8Gm9jQDKmZ132CgPkWi0ANhw7EOkD52pF6lV2qQCwupoxza
         fmkQ==
X-Gm-Message-State: ANoB5pkZWObx0CTFzp0CNl4c2Fh9Io66UWTO5Tjg9odj4GIJAl7ebAge
        ZViLNBdbBXsYYfER8BxLw3TpuQ==
X-Google-Smtp-Source: AA0mqf4MgV0oW/LCUugReHUpBkpepoZ7Vy6UeNXMZ5Yjky+iNhPczOtY8K1ul1dtRtcsoxT6/N3VKQ==
X-Received: by 2002:a17:906:78e:b0:7a1:e52e:bddb with SMTP id l14-20020a170906078e00b007a1e52ebddbmr16502698ejc.685.1668595834073;
        Wed, 16 Nov 2022 02:50:34 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id jw17-20020a17090776b100b0078b1ff41f05sm6758790ejc.43.2022.11.16.02.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:50:33 -0800 (PST)
Date:   Wed, 16 Nov 2022 11:50:31 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil@xs4all.nl>,
        linux-mm@kvack.org, Nadav Amit <namit@vmware.com>,
        linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        x86@kernel.org, Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vlastimil Babka <vbabka@suse.cz>, linux-media@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-um@lists.infradead.org, etnaviv@lists.freedesktop.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Oded Gabbay <ogabbay@kernel.org>,
        linux-mips@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH mm-unstable v1 16/20] mm/frame-vector: remove FOLL_FORCE
 usage
Message-ID: <Y3TAd14jCBSKeqsL@phenom.ffwll.local>
Mail-Followup-To: David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil@xs4all.nl>,
        linux-mm@kvack.org, Nadav Amit <namit@vmware.com>,
        linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        x86@kernel.org, Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>,
        linux-media@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-um@lists.infradead.org,
        etnaviv@lists.freedesktop.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        Oded Gabbay <ogabbay@kernel.org>, linux-mips@vger.kernel.org,
        Tomasz Figa <tfiga@chromium.org>, linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-17-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116102659.70287-17-david@redhat.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 16, 2022 at 11:26:55AM +0100, David Hildenbrand wrote:
> FOLL_FORCE is really only for ptrace access. According to commit
> 707947247e95 ("media: videobuf2-vmalloc: get_userptr: buffers are always
> writable"), get_vaddr_frames() currently pins all pages writable as a
> workaround for issues with read-only buffers.
> 
> FOLL_FORCE, however, seems to be a legacy leftover as it predates
> commit 707947247e95 ("media: videobuf2-vmalloc: get_userptr: buffers are
> always writable"). Let's just remove it.
> 
> Once the read-only buffer issue has been resolved, FOLL_WRITE could
> again be set depending on the DMA direction.
> 
> Cc: Hans Verkuil <hverkuil@xs4all.nl>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Tomasz Figa <tfiga@chromium.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Also code I looked at while looking at follow_pfn stuff

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/media/common/videobuf2/frame_vector.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/common/videobuf2/frame_vector.c b/drivers/media/common/videobuf2/frame_vector.c
> index 542dde9d2609..062e98148c53 100644
> --- a/drivers/media/common/videobuf2/frame_vector.c
> +++ b/drivers/media/common/videobuf2/frame_vector.c
> @@ -50,7 +50,7 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
>  	start = untagged_addr(start);
>  
>  	ret = pin_user_pages_fast(start, nr_frames,
> -				  FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
> +				  FOLL_WRITE | FOLL_LONGTERM,
>  				  (struct page **)(vec->ptrs));
>  	if (ret > 0) {
>  		vec->got_ref = true;
> -- 
> 2.38.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
