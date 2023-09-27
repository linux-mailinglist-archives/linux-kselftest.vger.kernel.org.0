Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC33E7B0250
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 13:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjI0LC2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 07:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0LC0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 07:02:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2772F3;
        Wed, 27 Sep 2023 04:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695812545; x=1727348545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O5il/qQ8Ygfz16OqECjDz2RFbtz7dYf9brLjgdVGI60=;
  b=ciiX3Y7GcZPnWGjCDDCmVzaREupnhSPpo5sIzyy85EW2BsjCaMLi05bt
   AsOZvrNwxj3Zb+EqdeCP4ZuQVIm5MhHRt15y+MT9xm6Yah+M9IgeqvY+2
   f8N9s9tz6TiAM9qKgFWLCsX9GWhnZA0R0HSFynmUIyxq05UKZy+TMQS6L
   ngimTW1YF1gaIc73Bw58iFs+/r4x5oy3eX6mLZPpkGyJGbrfpPcZlyjCU
   N3jYL8g9e2gzhS0wRW15QFiEmECR0XL/fm7qoDa4EsQFCzV1/UnGiaLJ0
   CFBttW0JcrN0Ojsoq1SNWv40aRjRLY0STUNIrtCBdLSvGGYhgTKbJPdhS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="445930820"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="445930820"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 04:02:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="749163047"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="749163047"
Received: from vsovraso-mobl.ccr.corp.intel.com (HELO box.shutemov.name) ([10.249.33.20])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 04:02:22 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id DBE9C109883; Wed, 27 Sep 2023 14:02:19 +0300 (+03)
Date:   Wed, 27 Sep 2023 14:02:19 +0300
From:   kirill.shutemov@linux.intel.com
To:     Binbin Wu <binbin.wu@linux.intel.com>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, weihong.zhang@intel.com
Subject: Re: [PATCH] selftests/x86/lam: Zero out buffer for readlink()
Message-ID: <20230927110219.b5n3fbbwrxtcwtzp@box.shutemov.name>
References: <20230923233346.12726-1-binbin.wu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923233346.12726-1-binbin.wu@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Sep 24, 2023 at 07:33:46AM +0800, Binbin Wu wrote:
> Zero out the buffer for readlink() since readlink() does not append a
> terminating null byte to the buffer.
> 
> Fixes: 833c12ce0f430 ("selftests/x86/lam: Add inherit test cases for linear-address masking")
> 
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> ---
>  tools/testing/selftests/x86/lam.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
> index eb0e46905bf9..9f06942a8e25 100644
> --- a/tools/testing/selftests/x86/lam.c
> +++ b/tools/testing/selftests/x86/lam.c
> @@ -680,7 +680,7 @@ static int handle_execve(struct testcases *test)
>  		perror("Fork failed.");
>  		ret = 1;
>  	} else if (pid == 0) {
> -		char path[PATH_MAX];
> +		char path[PATH_MAX] = {0};

Shouldn't it be PATH_MAX+1 to handle the case when readlink(2) stores
exactly PATH_MAX bytes into the buffer?

>  
>  		/* Set LAM mode in parent process */
>  		if (set_lam(lam) != 0)
> 
> base-commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70
> -- 
> 2.25.1
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
