Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719492B1153
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Nov 2020 23:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgKLWWC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Nov 2020 17:22:02 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10755 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgKLWWC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Nov 2020 17:22:02 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fadb58e0000>; Thu, 12 Nov 2020 14:22:06 -0800
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 22:22:00 +0000
Subject: Re: [RFC PATCH 1/6] mm: huge_memory: add new debugfs interface to
 trigger split huge page on any page range.
To:     Zi Yan <ziy@nvidia.com>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-2-zi.yan@sent.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <69294b6a-ecfb-fac0-2725-9ac0b73f43aa@nvidia.com>
Date:   Thu, 12 Nov 2020 14:22:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20201111204008.21332-2-zi.yan@sent.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605219726; bh=MRJlV+jO9gQUfjeyUA6U+V092g79T0PX8NmUSZOQA4M=;
        h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=DRu2kukRl/lA6HAt0sSPrNuNAeeDllmZ4MCT2N15qwy9uWDjHXylosjnqdoSkFug/
         aSbUzZ4dX2j1XwcgdOsZVrvjZmNYZ9qVl2BHD3UwI7JZ2HftIeSVsyMz7FGcEV913/
         5wpp2eviTofUCf6m1/qBBycpd2xiNJV+9ZIovokIc6wAYmb2dE+1+UV8iPiUCq8+qO
         hOqJWDkmO+1G2Z8ijgPI5iuxb3c6Qdw7TFihOLonojO3fPjEng/E+uk7gY+QVgqfh3
         Z/PjgFEUU9+f0FGmFYaBXMoa2zwvXPhNq9btwYKcrws+iLOQ/MeZJQUoAumLle/A9W
         BetRm4hX3RY+w==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 11/11/20 12:40 PM, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Huge pages in the process with the given pid and virtual address range
> are split. It is used to test split huge page function. In addition,
> a testing program is added to tools/testing/selftests/vm to utilize the
> interface by splitting PMD THPs.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/huge_memory.c                              |  98 +++++++++++
>   mm/internal.h                                 |   1 +
>   mm/migrate.c                                  |   2 +-
>   tools/testing/selftests/vm/Makefile           |   1 +
>   .../selftests/vm/split_huge_page_test.c       | 161 ++++++++++++++++++
>   5 files changed, 262 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/vm/split_huge_page_test.c

Don't forget to update ".gitignore" to include "split_huge_page_test".
