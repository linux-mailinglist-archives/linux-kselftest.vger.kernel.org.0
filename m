Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433BD6BCCA4
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 11:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjCPKXZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 06:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCPKXC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 06:23:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F755C4884;
        Thu, 16 Mar 2023 03:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678962134; x=1710498134;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=AXs+v9unQsT/CL6RnBbNTPiJoA+wNOgUNKpFs1nzhco=;
  b=APqbcU3wMJJ/acYChCPwffM542lOsZCORkpUvWphhzbp7ub1nj4t0gzi
   pc/OPxtyxXBKDf87E4qSEb79mxJ7wcj6aadqZJZQCXZcJFIEImoWWxcs0
   jSrPZl72MkCp7VeeVc2ckwzRgmsqwni77c2Z7k0N5Q23q4D9a6webyQcY
   71/HZQbhveZQoFYP3c9pUvu4cYtVAbgypBE4RcIJS1+2qjHegYwA4cXmd
   ZGX0AMumBNcWbyrYB2xtogJMnunQECdTW7hFNzJExX0lCm51VTht2weis
   +pXLC4vR3IwTmZ6+Cr+TEqqN6MO8ZIkBLsga4TPzj3luQ+xLmlH7rZjOh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="424220849"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="424220849"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 03:21:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="679848802"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="679848802"
Received: from trybicki-mobl1.ger.corp.intel.com ([10.252.63.119])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 03:21:37 -0700
Date:   Thu, 16 Mar 2023 12:21:35 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2 9/9] selftests/resctrl: Correct get_llc_perf() param
 in function comment
In-Reply-To: <50d0e974-478f-ea60-9b7b-50982697ef96@intel.com>
Message-ID: <4830705e-212f-6dd1-e8e9-7a35cc886d5@linux.intel.com>
References: <20230215130605.31583-1-ilpo.jarvinen@linux.intel.com> <20230215130605.31583-10-ilpo.jarvinen@linux.intel.com> <50d0e974-478f-ea60-9b7b-50982697ef96@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-709021613-1678956358=:2328"
Content-ID: <20644a1f-8a3a-3710-d252-7214cb778879@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-709021613-1678956358=:2328
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <da49d149-2086-13e1-7fdb-89f8a95812c9@linux.intel.com>

On Wed, 15 Mar 2023, Reinette Chatre wrote:

> Hi Ilpo,
> 
> On 2/15/2023 5:06 AM, Ilpo Järvinen wrote:
> > get_llc_perf() function comment refers to cpu_no parameter that does
> > not exist.
> > 
> > Correct get_llc_perf() the comment to document llc_perf_miss instead.
> 
> "Correct the get_llc_perf() comment"?

Yes. No matter how many times I read my own changelogs through, my mind 
goes to auto-correction mode and I often fail to spot obvious errors such 
as this.

Thanks for reviewing.

-- 
 i.

> This is so minor and I do not think a reason to resubmit whole series.

> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> 
> Thank you
> 
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> 
> Reinette
> 
--8323329-709021613-1678956358=:2328--
