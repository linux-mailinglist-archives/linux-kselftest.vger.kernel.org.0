Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBCF4AD93D
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 14:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350320AbiBHNQO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 08:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245549AbiBHMsF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 07:48:05 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EF6C03FEC0
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 04:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644324484; x=1675860484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RqexsZZOUZKYkeXOWBtV9gc3KdgjC20v88OKn1Iwgbc=;
  b=jRe9/e6v9xtyxmmi84A5bUNmVi4Jr3gZM93vHmQul8c0FqRoim0D5DCT
   iCqZlKDYwv2J26IuhiqkdCsoieVhTEq2vz1GAj3/YM8EK9lJjAGaM11Wr
   SzVLL1/lK+yJqQv9C+dX2qsGAFAcc8MxtjqMpf75e1UoRV6pgwlxQVIxv
   q35hY2gc/HNulGh3FZ3kBc7Y+WvQUa1H5tMlHOjlMtNic35MiA/1Nt5n3
   Jhmnu7iMp7TMI1ZUIH/xwAsMnHtOefwuA9uEcbUEXIccDa8x3wCKKDue2
   asPmBkFqWX9CKnZrJBPfXOYlouEuMgNqrdicOXy7tSO+KNkHCUZuPNt74
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="335342248"
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="335342248"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 04:47:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="632832992"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 04:47:39 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 08 Feb 2022 14:47:36 +0200
Date:   Tue, 8 Feb 2022 14:47:36 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>
Subject: Re: [PATCH v4 3/6] thunderbolt: test: use NULL macros
Message-ID: <YgJmaDJTGTmRgNIy@lahna>
References: <20220208114541.2046909-1-ribalda@chromium.org>
 <20220208114541.2046909-3-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208114541.2046909-3-ribalda@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Tue, Feb 08, 2022 at 12:45:38PM +0100, Ricardo Ribalda wrote:
> Replace the NULL checks with the more specific and idiomatic NULL macros.
> 
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/thunderbolt/test.c | 130 ++++++++++++++++++-------------------
>  1 file changed, 65 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/thunderbolt/test.c b/drivers/thunderbolt/test.c
> index 1f69bab236ee..f5bf8d659db4 100644
> --- a/drivers/thunderbolt/test.c
> +++ b/drivers/thunderbolt/test.c

You could add these too while there:

>  	p = tb_property_find(dir, "foo", TB_PROPERTY_TYPE_TEXT);
>  	KUNIT_ASSERT_TRUE(test, !p);

>  	p = tb_property_find(dir, "missing", TB_PROPERTY_TYPE_DIRECTORY);
>  	KUNIT_ASSERT_TRUE(test, !p);
