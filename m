Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E98125C167
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Sep 2020 14:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgICM4N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Sep 2020 08:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbgICMyp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Sep 2020 08:54:45 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20ABAC061245
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Sep 2020 05:54:44 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y11so1843925lfl.5
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Sep 2020 05:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=onLl8rTDQyvNpKgJJE9dFmq94UrkQmRn/zbTPNdul+w=;
        b=kyWZd6uSWtnkPJPjNC9/5GmYksI/3zvd739yEGMNVYRRPQ+obtq6kc0P1lySF1wLna
         /9pVxkncaXRcO2tuJq3pvnexLY4/WEYs6tUJiejalUKE87aVDxTtE8HGZioi56/HtvGW
         yphbM/vIdOQS1E8H5tT9vqdWIBrlZSJthYKw99V3Br+Jb4Wy1/Z14Ngc4JlLjaNb+iBN
         xdzS5/4L9tad8h/PIo9T2VsXCmgBMNtPZPjyG+MR2avtJUVy/CwEcgRJqvxxJyZ5cc+b
         kVEFsNzOzEK2uw81sjvtX00wvqAEmpeahxzGvmJf2FDEtGdxJK92HT48bXtJyIME/kON
         QHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=onLl8rTDQyvNpKgJJE9dFmq94UrkQmRn/zbTPNdul+w=;
        b=df6sQP8fWNgyQEGbHJzWswHzOEKpnorvvBRKDwYmBg+NifOE8e0rnSBl6xO3tcBqcr
         EJnFAf44OXJl12h9ogX6zb4t4+o1Q33RyM4RGVGP76AVOtOz7ywFe4d9NVQmBHVZ5U2A
         i+Id4E/YxSccgTTgtCyWRMrmBed16OTeocYL/pKkCqYCfS+OnqOE126nVMvgc/JJ9Tzk
         WOxgCujyByTIr3SMYgmcAK9pbN/AzdZbgkE0FtNqIfGhLEJr2h3VWsERhL9zFEj1f6Gj
         9anYfb+mnerLC5hVxQv6/V3cagCcSgYxhiL4LW8t66iKMJjLydgrjBpjwCl158shpxqo
         1PXQ==
X-Gm-Message-State: AOAM532qc2OIF5XLEt5gomkCbkvmeUp01vcE0VVYKOMf2APt7muSB/57
        2BR/kzSvFB9SZm8eE2B9/QxNig==
X-Google-Smtp-Source: ABdhPJxLwRZ25xqjpghlAiLuT8OszHqy2R0uqqhz3VeP7cshAVmBhDNDZKmnWNKpKHq5Fjz6I8h+WA==
X-Received: by 2002:a19:40c8:: with SMTP id n191mr1267052lfa.29.1599137681414;
        Thu, 03 Sep 2020 05:54:41 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id l16sm595692ljb.72.2020.09.03.05.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 05:54:40 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 321BC102212; Thu,  3 Sep 2020 15:54:42 +0300 (+03)
Date:   Thu, 3 Sep 2020 15:54:42 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Ben Skeggs <bskeggs@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/7] mm/thp: fix __split_huge_pmd_locked() for
 migration PMD
Message-ID: <20200903125442.4no5dq7mzcdllery@box>
References: <20200902165830.5367-1-rcampbell@nvidia.com>
 <20200902165830.5367-2-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902165830.5367-2-rcampbell@nvidia.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 02, 2020 at 09:58:24AM -0700, Ralph Campbell wrote:
> A migrating transparent huge page has to already be unmapped. Otherwise,
> the page could be modified while it is being copied to a new page and
> data could be lost. The function __split_huge_pmd() checks for a PMD
> migration entry before calling __split_huge_pmd_locked() leading one to
> think that __split_huge_pmd_locked() can handle splitting a migrating PMD.
> However, the code always increments the page->_mapcount and adjusts the
> memory control group accounting assuming the page is mapped.
> Also, if the PMD entry is a migration PMD entry, the call to
> is_huge_zero_pmd(*pmd) is incorrect because it calls pmd_pfn(pmd) instead
> of migration_entry_to_pfn(pmd_to_swp_entry(pmd)).
> Fix these problems by checking for a PMD migration entry.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>

Hm. Could you remind me what codepath splits migration PMD? Maybe it
should wait until migration is complete? We could avoid a lot of
complexity this way.

-- 
 Kirill A. Shutemov
