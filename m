Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDDC33B21E
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Mar 2021 13:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhCOMIA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Mar 2021 08:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCOMHr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Mar 2021 08:07:47 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97206C06175F
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Mar 2021 05:07:46 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 18so56379135lff.6
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Mar 2021 05:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xcBEaoMgOUg6Oq+1NZ62LHPAUIVElSEob3K7B1GsgBA=;
        b=fnukcSh6bz8KDNhtKbz34zCgeiqi2Wit0RLRnJO2jCJzPRTPlNg7l1ilMm5hOIYhgZ
         4yFTgcNbi2hqFx01FWQwquRN5uLKXA/yb+J+PjomR69PnmiK4oG33+3c010SeyqY3b1V
         Tj14GcgJ/xu+TmpjZDPgR48G+e1seHknp2rQPkBt1l9vOBwZUmaypRcFcwwVe11oUPrd
         p2jR4PGu8G5H+noyCy8uUsmt2m4alcAI8kpq7Xv/8GztX8H/BcbPSY1CqtUxhsAYJpnr
         0zoc3x3RZzudcIrlR6bKHnNcchzny8xqNiNxrPv5AO9oG3NvemR4g1kuDiKqmRnUuhtZ
         F9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xcBEaoMgOUg6Oq+1NZ62LHPAUIVElSEob3K7B1GsgBA=;
        b=MO478uXWjz7DuOlyKiBWMoUHoN4j6gtYNyStNBSTa8N4Jx5ZFmG4+CC0UJlGrw3Slv
         WpWmlm59L4E7FJMBDXQO107iX4TvryfIKLtBBiDuBxhmfYWt+VBoacTjmpGZJhFef86C
         Rr+HeuRD6xji1+ykvjCGviV7YALlDmobIMeBPT0fl3ih12eJ66KzHrWHlXmDo+SVCaWv
         osfyVhYt8bBA3tqG37pLjkzeXHA1Z8jP87uEkDh/XVNs05NqK+hpmDj+laD+dfSyvX3A
         M1Y6QhBiV+RexjRb1zY7iOj793McJgYKsNlV8q97ce6Szbg5sADwJccGqLSP+kLB8Gvl
         ozlg==
X-Gm-Message-State: AOAM532LCmaohvoN7NzJ2rS4p9o1JvtrMrHcDY6Q0ESB/S5FxsFtaeBr
        yaxKidYkX8VC47eDY9wuBgmh9w==
X-Google-Smtp-Source: ABdhPJx7lPgJ8wy+Ez31fyuhgQCC28oY7wc9fb7gDEwMPYVgovdXw1VtMnh+D+uQSvEDn+jgeySKuQ==
X-Received: by 2002:ac2:5d52:: with SMTP id w18mr7553649lfd.28.1615810065040;
        Mon, 15 Mar 2021 05:07:45 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y14sm2639094lfl.165.2021.03.15.05.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 05:07:44 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7EFB910246E; Mon, 15 Mar 2021 15:07:48 +0300 (+03)
Date:   Mon, 15 Mar 2021 15:07:48 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Mika Penttila <mika.penttila@nextfour.com>
Subject: Re: [PATCH v3] mm: huge_memory: a new debugfs interface for
 splitting THP tests.
Message-ID: <20210315120748.nuw5vk6grmfacact@box>
References: <20210312005712.116888-1-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312005712.116888-1-zi.yan@sent.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 11, 2021 at 07:57:12PM -0500, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> We do not have a direct user interface of splitting the compound page
> backing a THP

But we do. You expand it.

> and there is no need unless we want to expose the THP
> implementation details to users. Make <debugfs>/split_huge_pages accept
> a new command to do that.
> 
> By writing "<pid>,<vaddr_start>,<vaddr_end>" to
> <debugfs>/split_huge_pages, THPs within the given virtual address range
> from the process with the given pid are split. It is used to test
> split_huge_page function. In addition, a selftest program is added to
> tools/testing/selftests/vm to utilize the interface by splitting
> PMD THPs and PTE-mapped THPs.
> 

Okay, makes sense.

But it doesn't cover non-mapped THPs. tmpfs may have file backed by THP
that mapped nowhere. Do we want to cover this case too?

Maybe have PID:<pid>,<vaddr_start>,<vaddr_end> and
FILE:<path>,<off_start>,<off_end> ?

-- 
 Kirill A. Shutemov
