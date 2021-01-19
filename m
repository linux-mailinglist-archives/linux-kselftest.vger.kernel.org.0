Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7282FC4DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jan 2021 00:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbhASXhC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jan 2021 18:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbhASXgE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jan 2021 18:36:04 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3469C0613C1
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jan 2021 15:35:23 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id az16so10072623qvb.5
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jan 2021 15:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EhvAcZQ5rgh2MmfIZWPPX4/VupxkzFvw5zJjAClJRLQ=;
        b=KQP2/ghi3PyecmFsYOcygO6glPIdjbt4QD0Oum2Udyc5jCV+RO9CfcMEO5jRHIWdb1
         KR55jJyCsWyHYwxbKA9AcPiyYGZhBiCRMjnz54xXKdAetGI1VBJB5ezLM1Bl452RWANG
         3b35Xwdkv6mh/3cSZhpyxWCK+FayHVR6jl3HAzXsNrXEKL4ts2/9O+t+bA1DkprppOZU
         ny4NEb98PxfewGNh+D+qXTvBHfK5J7sWwEUvODoc+nD8BQmER8+WQHiC4nwzmBsOQTKf
         QAoPCzaIEKHaEiyQc9B2NrL2RGHihp7CFfbxTljqOuGbtv1hpxryOBfR/utcLZkwkrO9
         Oo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EhvAcZQ5rgh2MmfIZWPPX4/VupxkzFvw5zJjAClJRLQ=;
        b=pO4PAfZz8wjLzpiMlpVuENzNAvOwr0OyWWovx24sZFuJgXoimGKmaL0NSLcNKBsar2
         ib1aklHSglZMjxqyCmr4juPL4ehKjO3F9AdwO4ZQA5VlWYNYvsKimCMDAHkkFgoGISHL
         wj7F5BofVJrg6UIbckJykysf95i+4SXJhd05QkjuV345G2VPM85MxBliAMB+JJus3lbd
         HOO/E/AyC+pxs2UwN9ZlYzdvZX0K+C/MgoLH9nJthvb/XtKYhtsLe8AuHM0O0HWB0lpA
         528cwj1NE9aVJvI16CBnsptG3EusdpHLRSQXInDR2WrbQykdfgIwlxJL9tiSnBf1iNzn
         iC/g==
X-Gm-Message-State: AOAM531V+l5UsrshkQElazbbvX6L6bMGZ4aQVNQu2A6bsYHWz50v7Gel
        cRQ5U+rEijJY3DdMQTCZ0Pvfew==
X-Google-Smtp-Source: ABdhPJwQ5+FkffXGjNDuxxs8agNNaUF0vD5Ucc+XPCpjUzppX5ueLh25sKxSCYmaiwfTZk67Q0KfAw==
X-Received: by 2002:a05:6214:1904:: with SMTP id er4mr6763558qvb.49.1611099323173;
        Tue, 19 Jan 2021 15:35:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id 2sm121866qtt.24.2021.01.19.15.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 15:35:22 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l20Wv-003v6u-K8; Tue, 19 Jan 2021 19:35:21 -0400
Date:   Tue, 19 Jan 2021 19:35:21 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 08/14] mm/gup: do not allow zero page for pinned pages
Message-ID: <20210119233521.GE4605@ziepe.ca>
References: <20210119043920.155044-1-pasha.tatashin@soleen.com>
 <20210119043920.155044-9-pasha.tatashin@soleen.com>
 <20210119183013.GB4605@ziepe.ca>
 <CA+CK2bBKbht34Hkg9YvhwYAiAjd3NMd_+Eir9wfx+07V-Y2TTA@mail.gmail.com>
 <20210119184751.GD4605@ziepe.ca>
 <CA+CK2bDGDR9B=n5d4Dz6my6kKyFF=6y79HJt-k-SCpLhF1fUQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bDGDR9B=n5d4Dz6my6kKyFF=6y79HJt-k-SCpLhF1fUQQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 19, 2021 at 03:14:04PM -0500, Pavel Tatashin wrote:

> I was thinking about a use case where userland would pin an address
> without FOLL_WRITE, because the PTE for that address is not going to
> be writable, but some device via DMA will write to it.

That would be a serious bug in the get_user_pages caller to write to a
page without using FOLL_WRITE

Jason
