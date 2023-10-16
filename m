Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C5E7CA23E
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 10:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjJPIrl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 04:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbjJPIri (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 04:47:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D6B9B;
        Mon, 16 Oct 2023 01:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697446057; x=1728982057;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wjZpxVJ5dbr8+1cfQF6ueToBM+d0ID9OcBGdQ/RRLzY=;
  b=cybW2ZD1+Vl/SecBklpuGfx5AThkbxZCanaQGR+V010hi+0AU4DXiwC1
   Ajo3cZ82Skq0FFQ1J/y0PylLtrFMwP2eKlVAA7jEBbV8hbgZHmWW0gs+D
   6VdKOEEXGAjEHNSLi/E43uPWfSI0vWpdEQb/ff+uGPrrFFkqAZx0C9NzR
   14HgsnJ5rWSvqueL0HPJC7TDbOrFqjyku5ny+7ld9hKUNE3z1xVOdayeA
   Wrhcdpcn8M05VXOTOHoO2FLzqGl5L7cIAoSmeBq8CTgblpPkstF0qFpQp
   Zxzp9RqlLnKnJJkUC4s1DfbzSAcK4h4aD1L91HBIWC0BdQYzopbGPkcuZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="385320643"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="385320643"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 01:47:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="846320819"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="846320819"
Received: from bmihaile-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.37.165])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 01:47:26 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id BE7CA10A1EC; Mon, 16 Oct 2023 11:47:23 +0300 (+03)
Date:   Mon, 16 Oct 2023 11:47:23 +0300
From:   kirill.shutemov@linux.intel.com
To:     Binbin Wu <binbin.wu@linux.intel.com>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/x86/lam: Zero out buffer for readlink()
Message-ID: <20231016084723.icjv6mj64ocx2hoj@box>
References: <20231016062446.695-1-binbin.wu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016062446.695-1-binbin.wu@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 16, 2023 at 02:24:46PM +0800, Binbin Wu wrote:
> Zero out the buffer for readlink() since readlink() does not append a
> terminating null byte to the buffer.  Also change the buffer length
> passed to readlink() to 'PATH_MAX - 1' to ensure the resulting string
> is always null terminated.
> 
> Fixes: 833c12ce0f430 ("selftests/x86/lam: Add inherit test cases for linear-address masking")
> 
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
