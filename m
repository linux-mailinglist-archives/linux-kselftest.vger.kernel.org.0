Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FC52FBF06
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jan 2021 19:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387558AbhASSbU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jan 2021 13:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387620AbhASSbC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jan 2021 13:31:02 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54069C0613D3
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jan 2021 10:30:15 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id bd6so9609058qvb.9
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jan 2021 10:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k26IIVGt0E6B0tvAWOLHZwdfWuzN6d7qHFvd8ZVNYk0=;
        b=SUDvSIigSqo9rIUtIa5Eu7WRTj6rJFVObJR6As14fn+j77cYLuyyxMrcYQn4LJ7oG7
         c+B4J2r9aBh7C2LK9Ij3Rwg3xcoBksq1T/LmdXvtLr00KreJld2kCA0eD9SMgWcetyIG
         dN1f9MePpQ76i5U7QninrJfI6nDXmt78D4XVs8g1ze5Sg/QMQiFUS9DYfXAwUlRF8mqn
         6cB8q+OXHzS5MK0gRo4uPohwvfUbo7BxlINAn4ZCTyFG0Tjjo977o6dQzaAww+qmiotF
         Ybr9L5jpCctVi2x5b//4Cv/tMqGPxAeaLRqM/yCPr1TjJknCu6hQDBScR/SeH0Y4SDJu
         VkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k26IIVGt0E6B0tvAWOLHZwdfWuzN6d7qHFvd8ZVNYk0=;
        b=iiIELOrb+V4rPejbVQZ9N9nFesymlAGuOfTrfB8f51OrIjat/bIpOTfjP09coxlQ6T
         /p3ASUgVOGJQkPWR8iEBQK5cnCFumKD65WqhgMJxnXSRHiKhCXynv9Dwpyr4AhZ+uPbS
         qm2A2sUbE6beKTSi6I5LZ0p/g/hfgUAEpF/esruOtWz3SCQeUCN5fZbGpIJDlXmXpUxc
         hPa2C/CNSYS9vYOM1svgQbTN6C1rKe1/MU99g7a0BQmDDIonvIQzcFmTIu7s7z3FLH0p
         NJEY68LgHBeUesPYRSiRzGfZ+Ei7UOsYreeygX7CoHsNnsci0lG6blyIez9TXyxYkGZ6
         DfAw==
X-Gm-Message-State: AOAM532QPlx6Jjk4ci7ZSz8OXxDQ78I3KXCOCWFCVH75MvNplDcAmP7O
        5bjalt48QrohSC7xq/c1tdEuEg==
X-Google-Smtp-Source: ABdhPJyVPdLzW30F86jbhbw02UhyEzNHNm1A2a7XQsfcX2SJOI44r3mS/eSEiOOFPJWqKfCPcbsZUA==
X-Received: by 2002:a0c:f005:: with SMTP id z5mr5528978qvk.9.1611081014621;
        Tue, 19 Jan 2021 10:30:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id 128sm13451661qki.26.2021.01.19.10.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 10:30:14 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l1vld-003pg1-Ed; Tue, 19 Jan 2021 14:30:13 -0400
Date:   Tue, 19 Jan 2021 14:30:13 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        sashal@kernel.org, tyhicks@linux.microsoft.com,
        iamjoonsoo.kim@lge.com, mike.kravetz@oracle.com,
        rostedt@goodmis.org, mingo@redhat.com, peterz@infradead.org,
        mgorman@suse.de, willy@infradead.org, rientjes@google.com,
        jhubbard@nvidia.com, linux-doc@vger.kernel.org,
        ira.weiny@intel.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 08/14] mm/gup: do not allow zero page for pinned pages
Message-ID: <20210119183013.GB4605@ziepe.ca>
References: <20210119043920.155044-1-pasha.tatashin@soleen.com>
 <20210119043920.155044-9-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119043920.155044-9-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 18, 2021 at 11:39:14PM -0500, Pavel Tatashin wrote:
> Zero page should not be used for long term pinned pages. Once pages
> are pinned their physical addresses cannot changed until they are unpinned.
> 
> Guarantee to always return real pages when they are pinned by adding
> FOLL_WRITE.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  mm/gup.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

No, this will definitely break things

Why does the zero page have to be movable?

Jason
