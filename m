Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680966B4B66
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 16:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbjCJPoI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 10:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbjCJPnw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 10:43:52 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D7812D4BC;
        Fri, 10 Mar 2023 07:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678462264; x=1709998264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VGidnxksCWSRreIR6ljXP62hhre0QuKRN8KkxMOA8+0=;
  b=As5BSZ/AqMeyKObpIM9H+Bt5/2OEU0Nmrh5JVjbWiEZ7+7KpanNAD/Bw
   0fkC51gvdXX4y60ly2Dc+pwHxyvRIdnvap0p/Yrr8N0OrYaOrKa72Bzsq
   69OEIt9/yRPQ0KkQfyWgQ6bNnoduUYudwQ6mEgUQFDFcB/Czp/KKyBOVP
   mY1RQInl+u66SbsTmNMNqvgrwlNDtGhvPoFOCoEAq6YpPDVv+XiL3ykeU
   u4gZcpMD2JXhnoM/cC+koeHEET/iMfJ1SO1w7VDwUjVjJ/paFPeecH7AD
   5kdQCgRu7PqpODJj2KjbwJT3bbDrJdVQA7lOcK7iSlg8JROcIONbd8Ipt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="325101996"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="325101996"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 07:30:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="708041172"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="708041172"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 10 Mar 2023 07:30:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1paehX-00100z-0L;
        Fri, 10 Mar 2023 17:30:35 +0200
Date:   Fri, 10 Mar 2023 17:30:34 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Subject: Re: [PATCH v1 1/1] .gitignore: Unignore .kunitconfig
Message-ID: <ZAtNGmqKSgmaGBtI@smile.fi.intel.com>
References: <20230127145708.12915-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127145708.12915-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 27, 2023 at 04:57:08PM +0200, Andy Shevchenko wrote:
> There are almost dozen of .kunitconfig files that are ignored but
> tracked. Unignore them.

It's still an issue, can we apply this patch or can somebody to propose
the better sooner than later, please?

-- 
With Best Regards,
Andy Shevchenko


