Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E625B7B223F
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 18:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjI1QZw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 12:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjI1QZu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 12:25:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444B11A4
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 09:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695918298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ndiSQPUClBTrz4CKUdDdf3vxdcFaBznOakZY24ftqF0=;
        b=Q7NAHGA+br5mvZRVSyP910JJYNRon7hgvOUbMWEo4/jneTuzk8bDsBMl+dxFH/dG8KYE6d
        MJhidH8/Zf7jS/oSobgvuaeb6FjwjqBJcnFT4NrPQ1TVBICRI7joLHgAEv1HSS+2gOJlbk
        Ig8NUI9LzbP/29eWOw7LdbHqZzA6QLk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-V1MwwsvlOWiW-S2RXgDSWA-1; Thu, 28 Sep 2023 12:24:57 -0400
X-MC-Unique: V1MwwsvlOWiW-S2RXgDSWA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-41951447612so21821151cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 09:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695918296; x=1696523096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndiSQPUClBTrz4CKUdDdf3vxdcFaBznOakZY24ftqF0=;
        b=gRJtI2N3mqyW+XcIxkbTAokmgUK/tO45jfvRXOUGSrn2oIl5/n/sC70Um8QoUef5uJ
         /jO1EjyHY/u00We0n4OuuxiBi4BWw+iWFkBTTVd+RBrfEmds9GN1eZX5ku7YZUZRNbI4
         PklmVJlA15Dkoy/lPebluy7GGgXi8CthBPd1KdwAT0xyYjjwQDjn6T5MaP/IcYvCzaz9
         d6MIrvcf6NspDwIv2fOfk6hfPhUhHHNm7c9c+giXbLmugJvbMbZ7FMcWvdn0fjZcMRUt
         6CdVsFyNn824ktr+bVbU4m3Jhn+bHQs+jkhK2oKKSNkWNbrU9JJngWI5S1wogK96pakb
         CHhg==
X-Gm-Message-State: AOJu0Yyfsx+Qp8JUjYn5DnJTCw5V3Ds+x8C6y/+917F/Ut/jK++dITpu
        TzgNvP/KAiKTUctYvzJ6wp6j0I5XNRakqk3c+9AEyfvRx2dv3s1wPX2Xjc2nJ0m1/cMjs6OJhxr
        SLGK3HaZjr00cKV2hg2LUZL9lnUNY
X-Received: by 2002:a05:622a:1a27:b0:418:f2a:c223 with SMTP id f39-20020a05622a1a2700b004180f2ac223mr1920009qtb.1.1695918296713;
        Thu, 28 Sep 2023 09:24:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2f1QIwKluc2EwyGnzKjSpJAlIkFFpuh6Qbcc40o5jjLqmHgZGD4ZV3pjpnz+FWlEbN4/rtA==
X-Received: by 2002:a05:622a:1a27:b0:418:f2a:c223 with SMTP id f39-20020a05622a1a2700b004180f2ac223mr1919998qtb.1.1695918296376;
        Thu, 28 Sep 2023 09:24:56 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id c25-20020ac86619000000b004195faf1e2csm1154119qtp.97.2023.09.28.09.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 09:24:56 -0700 (PDT)
Date:   Thu, 28 Sep 2023 12:24:53 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
Message-ID: <ZRWo1daWBnwNz0/O@x1n>
References: <20230923013148.1390521-1-surenb@google.com>
 <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
 <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 27, 2023 at 03:29:35PM +0200, David Hildenbrand wrote:
> > > +       if (!pte_same(*src_pte, orig_src_pte) ||
> > > +           !pte_same(*dst_pte, orig_dst_pte) ||
> > > +           folio_test_large(src_folio) ||
> > > +           folio_estimated_sharers(src_folio) != 1) {
> 
> ^ here you should check PageAnonExclusive. Please get rid of any implicit
> explicit/implcit mapcount checks.

David, is PageAnon 100% accurate now in the current tree?

IOW, can it be possible that the page has total_mapcount==1 but missing
AnonExclusive bit in any possible way?

Thanks,

-- 
Peter Xu

