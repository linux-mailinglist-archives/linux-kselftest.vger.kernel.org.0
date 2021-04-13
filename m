Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C994B35E77F
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Apr 2021 22:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348167AbhDMURO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Apr 2021 16:17:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28251 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348163AbhDMURO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Apr 2021 16:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618345014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iFBhLR1Gx0aeiV6J1eM1yEOIsjeKpw+FknvPJH209wU=;
        b=OfwZdNZ7FEpdjwMMGE82ZG6+x5WYimn5GoBeFLZGxp7bWBZiP6v0PMRmdKlIxMXq1vm4HM
        7JEP/uGOY+ZTlh3obQKqCRKMflgJci9vLHh+RU47Xqm1qNV3MM/SNVw2yEkUbvDXi9rcv2
        Bt+MIw8otm1uAd3RjJk3RCDvonQf0gw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-htdhW89KNDOt8kvk6mtECQ-1; Tue, 13 Apr 2021 16:16:52 -0400
X-MC-Unique: htdhW89KNDOt8kvk6mtECQ-1
Received: by mail-qt1-f199.google.com with SMTP id n13-20020ac86f4d0000b02901b35920b3cbso423994qtv.23
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Apr 2021 13:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iFBhLR1Gx0aeiV6J1eM1yEOIsjeKpw+FknvPJH209wU=;
        b=Yclx1NpT+mlrTAODGWYaHwWyag6QVjtkTGHXS0v64vLi5NCQ5/5gG7WXu0gu/+939i
         liYkKw3QoVqPKKHRvXwh8JlYPrHlQMW+4qj3RApTvz7rV58l2n6DPgXskfICOckAlAil
         iRI+UuySA23G2VjcPitEchfj1MUAzk58hnPhwVI2JqZiwaYKNCg6E7CA2BA8vJ8kLQmj
         cSXjhuvDH65B1e/AkrCLTncKAMM9i5bSeSl96FYVlxwDJPd/LUxeEVTECznOKnEdNnw9
         dIuCe/8Um8J0TGY5P5RewXqjD/VgQqEoEgDLiviTn9LaCBKjj+aBrfD6SsnuDbYs2kB/
         ccfw==
X-Gm-Message-State: AOAM5311/MwFalpC3jSGCn3RPo0GCh7GOuFrztJtbeNP+PSL0arGp0WP
        JcNEhN0ui72ugRN9VRAKdCin4M3NBni4hmMsFVrm2LRkoz00f6fF/Jfpn57nrIROsW0//MczTAF
        cdwJ+bMrSynOAg9d73kdtGlng+Xe9
X-Received: by 2002:a05:620a:22ea:: with SMTP id p10mr33673831qki.27.1618345012352;
        Tue, 13 Apr 2021 13:16:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3IttBM2aAsbOlGIkYA5j8AtGXTYyXS8sJV22svEAsTrySp6idSonzYhdMsJWvU4N7vhjqHw==
X-Received: by 2002:a05:620a:22ea:: with SMTP id p10mr33673803qki.27.1618345012160;
        Tue, 13 Apr 2021 13:16:52 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id t4sm4362370qkg.75.2021.04.13.13.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 13:16:51 -0700 (PDT)
Date:   Tue, 13 Apr 2021 16:16:49 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v2 5/9] userfaultfd/selftests: use memfd_create for shmem
 test type
Message-ID: <20210413201649.GE4440@xz-x1>
References: <20210413051721.2896915-1-axelrasmussen@google.com>
 <20210413051721.2896915-6-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210413051721.2896915-6-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 12, 2021 at 10:17:17PM -0700, Axel Rasmussen wrote:
> This is a preparatory commit. In the future, we want to be able to setup
> alias mappings for area_src and area_dst in the shmem test, like we do
> in the hugetlb_shared test. With a VMA obtained via
> mmap(MAP_ANONYMOUS | MAP_SHARED), it isn't clear how to do this.
> 
> So, mmap() with an fd, so we can create alias mappings. Use memfd_create
> instead of actually passing in a tmpfs path like hugetlb does, since
> it's more convenient / simpler to run, and works just as well.
> 
> Future commits will:
> 
> 1. Setup the alias mappings.
> 2. Extend our tests to actually take advantage of this, to test new
>    userfaultfd behavior being introduced in this series.
> 
> Also, a small fix in the area we're changing: when the hugetlb setup
> fails in main(), pass in the right argv[] so we actually print out the
> hugetlb file path.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

