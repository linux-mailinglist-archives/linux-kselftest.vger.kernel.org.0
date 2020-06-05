Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94E71EF99B
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jun 2020 15:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgFENtU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Jun 2020 09:49:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:54997 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbgFENtU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Jun 2020 09:49:20 -0400
IronPort-SDR: DujeTM2AkV+JAJOEqHlw2isYSZJiRJj15YRPWLi8ZzMJRuK1iMrsH+yBxn1HhD/JRq50XEGr17
 QA/DwGwUUf8A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 06:49:20 -0700
IronPort-SDR: p3OZQIeTht0UzBij0WEyDk4bQ9mbt8x+0i8S4aQBnM9G7dXZg/7LHsnARcgH7JqT7+Eo93il2e
 VS3NAv9vg46Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,476,1583222400"; 
   d="scan'208";a="445897890"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 05 Jun 2020 06:49:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 8F8C7190; Fri,  5 Jun 2020 16:49:16 +0300 (EEST)
Date:   Fri, 5 Jun 2020 16:49:16 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Zi Yan <ziy@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] khugepaged: selftests: fix timeout condition in
 wait_for_scan()
Message-ID: <20200605134916.tq6lfut3cikhuhbf@black.fi.intel.com>
References: <20200605110736.GH978434@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605110736.GH978434@mwanda>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 05, 2020 at 02:07:36PM +0300, Dan Carpenter wrote:
> The loop exits with "timeout" set to -1 and not to 0 so the test needs
> to be fixed.
> 
> Fixes: e7b592f6caca ("khugepaged: add self test")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  tools/testing/selftests/vm/khugepaged.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vm/khugepaged.c b/tools/testing/selftests/vm/khugepaged.c
> index 51b89cedd09d1..8b75821302a79 100644
> --- a/tools/testing/selftests/vm/khugepaged.c
> +++ b/tools/testing/selftests/vm/khugepaged.c
> @@ -502,7 +502,7 @@ static bool wait_for_scan(const char *msg, char *p)
>  
>  	madvise(p, hpage_pmd_size, MADV_NOHUGEPAGE);
>  
> -	return !timeout;
> +	return timeout == -1;
>  }
>  
>  static void alloc_at_fault(void)

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Thanks.

-- 
 Kirill A. Shutemov
