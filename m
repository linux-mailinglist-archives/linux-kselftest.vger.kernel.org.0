Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63DB7076DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 02:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjERAVW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 20:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjERAVV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 20:21:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBAA3AAF
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 17:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684369235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ctm+oHZ88OJx9RdDqhhRf0OhM0Skp+u6Ga9xqH4ST4w=;
        b=G5EM1hydzjK4aiv0Zjxb/QHhDhKGZSVtSVvezitqviHaQiwDftfqXE/JnQtYlsTMCRiRHX
        VytIXszDTyDe3erUhOtNdTmldgx1go0fe922bXwj6QWLZQakxoRLeJ65TLlFYgBNrcF308
        HkVtDNnMDeK3nSeqj0i9xYRN7e0e2BM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-Oib8jOAGNfKA0rHv5nKipw-1; Wed, 17 May 2023 20:20:34 -0400
X-MC-Unique: Oib8jOAGNfKA0rHv5nKipw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f384644b08so2563181cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 17:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684369234; x=1686961234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ctm+oHZ88OJx9RdDqhhRf0OhM0Skp+u6Ga9xqH4ST4w=;
        b=Fy+OoX9/tpEFSxCftd79ZewFbhgg63ICKgCOCTGbjXP8moFRJ1HVuCHI3DWSErmSRt
         INjqqWiaNZhDSitGCVFPDw95lcRDez7Lo1ASfybMy/0VCj5CG01J1sWLr2572glnWRA4
         Pd/fBb6WqnNW4rm6Np49PohcW1id+2ChJXbPnAtYhv6R8c68Cq6ALe49ZblCCq3OoGu6
         w8P6/I5+JRJUrTsUfoyKEug6lI6W3mQICByjuEieKePE67I8R+N6LXWylkLleOgZTsZm
         JK+mOerjxZXOBz8iCm4C3igbkZMtk5VpQwgNOZj6VwXEZEnjFQ8TsqT349GeLCMB1Iaf
         Dsuw==
X-Gm-Message-State: AC+VfDzN7pNOUz8dd7z1sOR9I9nWNzfVSm0nOPmbBe98sVASZtavvzx5
        JYsIa8POeTWW4uaa2wSiVjCrnMpHzRGh3n7wyFh6DRxaW/yaj+AIbs3AlgJDGqRXH/ekjMXlCAQ
        rrCKVohcQrTUs+OZUiY90LBgF09ZU
X-Received: by 2002:ac8:5707:0:b0:3e3:1d31:e37 with SMTP id 7-20020ac85707000000b003e31d310e37mr8013651qtw.1.1684369233893;
        Wed, 17 May 2023 17:20:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5uCwwNk/Gtb9I7N6Wt9AMm8Uc3BeJUVAUIZEhidZKrahY1/OGxGLT0sKfPQ9PRHymHcL6anw==
X-Received: by 2002:ac8:5707:0:b0:3e3:1d31:e37 with SMTP id 7-20020ac85707000000b003e31d310e37mr8013634qtw.1.1684369233657;
        Wed, 17 May 2023 17:20:33 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id c8-20020ac853c8000000b003e69c51cf53sm65569qtq.72.2023.05.17.17.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 17:20:32 -0700 (PDT)
Date:   Wed, 17 May 2023 20:20:31 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     James Houghton <jthoughton@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Huang Ying <ying.huang@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Anish Moorthy <amoorthy@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH 1/3] mm: userfaultfd: add new UFFDIO_SIGBUS ioctl
Message-ID: <ZGVvTxIH3JK9KJq/@x1n>
References: <20230511182426.1898675-1-axelrasmussen@google.com>
 <CADrL8HXFiTL-RDnETS2BUg_qH8CvcCMZiX-kutsrS1-8Uy25=w@mail.gmail.com>
 <ZGVRUeCWr8209m8d@x1n>
 <ZGVTMnVKNcQDM0x4@x1n>
 <CAJHvVcgXynHcuoS6eCfOAB2SgzqYy_zMGrRMR2kFuxOtSdUwvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcgXynHcuoS6eCfOAB2SgzqYy_zMGrRMR2kFuxOtSdUwvQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Axel,

On Wed, May 17, 2023 at 03:28:36PM -0700, Axel Rasmussen wrote:
> I do plan a v2, if for no other reason than to update the
> documentation. Happy to add a cover letter with it as well.
> 
> +Jiaqi back to CC, this is one piece of a larger memory poisoning /
> recovery design Jiaqi is working on, so he may have some ideas why
> MADV_HWPOISON or MADV_PGER will or won't work.
> 
> One idea is, at least for our use case, we have to have the range be
> userfaultfd registered, because we need to intercept the first access
> and check at that point whether or not it should be poisoned. But, I
> think in principle a scheme like this could work:
> 
> 1. Intercept first access with UFFD
> 2. Issue MADV_HWPOISON or MADV_PGERR or etc to put a pte denoting the
> poisoned page in place
> 3. UFFDIO_WAKE to have the faulting thread retry, see the new entry, and SIGBUS
> 
> It's arguably slightly weird, since normally UFFD events are resolved
> with UFFDIO_* operations, but I don't see why it *couldn't* work.
> 
> Then again I am not super familiar with MADV_HWPOISON, I will have to
> do a bit of reading to understand if its semantics are the same
> (future accesses to this address get SIGBUS).

Yes, it'll be great if this can be checked up before sending v2.  What you
said match exactly what I was in mind. I hope it will already work, or we
can always discuss what is missing.

-- 
Peter Xu

