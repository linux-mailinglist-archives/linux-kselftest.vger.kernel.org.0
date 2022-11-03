Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C159618048
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 15:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiKCO5V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 10:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKCO5U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 10:57:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24908111B;
        Thu,  3 Nov 2022 07:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667487440; x=1699023440;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MLW8zE+DMJXqzAzyiq/DhgzhL/SIAUig1ngDloNMjcw=;
  b=RkoYctvdgPzGqAmNmoN5kyRvEiPJbND0hX0ZsB31iUTnuOHk2VIooAk0
   gM+OCv2rCvSenxn5LaEvDolOP5Ph7sdb/NtdIXAB6ghfuNMJVlRkcULKm
   zA8YWtyM7kuYdNhMhTVF6AK03Sov6GH4ix9iNGCeDMFOt/vX8KIKCfXit
   CKpLWbHFNwesQlBgWVu0dIqHtaxMbOKemYir1D1TdOuVfa0J+HNEfwiYy
   0jwLYgM0bHzprCr0qzkVWPNYtNffnBEMrrokj3FpuNoabAu5HB5H4WUTJ
   kdlA0ANj+NrFqInd1TOxzl2lXj7o86JbovhQEocdc7iL7fiTwYAQtrFyq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="297165023"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="297165023"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 07:57:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="809698549"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="809698549"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 03 Nov 2022 07:57:19 -0700
Received: from maurocar-mobl2 (maurocar-mobl2.ger.corp.intel.com [10.252.30.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 34BE1580BA0;
        Thu,  3 Nov 2022 07:57:13 -0700 (PDT)
Date:   Thu, 3 Nov 2022 15:57:10 +0100
From:   Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
To:     Isabella Basso <isabbasso@riseup.net>
Cc:     linux-kselftest@vger.kernel.org, magalilemes00@gmail.com,
        maira.canal@usp.br, dlatypov@google.com, tales.aparecida@gmail.com,
        brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        leandro.ribeiro@collabora.com, igt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, n@nfraprado.net,
        davidgow@google.com, skhan@linuxfoundation.org,
        andrealmeid@riseup.net, kunit-dev@googlegroups.com
Subject: Re: [igt-dev] [PATCH i-g-t v2 3/4] lib/igt_kmod: add compatibility
 for KUnit
Message-ID: <20221103155710.36f29dd3@maurocar-mobl2>
In-Reply-To: <20221103104840.7301df76@maurocar-mobl2>
References: <20220829000920.38185-1-isabbasso@riseup.net>
        <20220829000920.38185-4-isabbasso@riseup.net>
        <20221103104840.7301df76@maurocar-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 3 Nov 2022 10:48:40 +0100
Mauro Carvalho Chehab <mauro.chehab@linux.intel.com> wrote:

> On Sun, 28 Aug 2022 21:09:19 -0300
> Isabella Basso <isabbasso@riseup.net> wrote:
> 
> > This adds functions for both executing the tests as well as parsing (K)TAP
> > kmsg output, as per the KTAP spec [1].
> > 
> > [1] https://www.kernel.org/doc/html/latest/dev-tools/ktap.html
> > 
> > Signed-off-by: Isabella Basso <isabbasso@riseup.net>  
> 
> Hi Isabella,
> 
> I'm doing some tests here with my i915 KUnit patch series.
> 
> There's a problem with the way it is currently parsing the KTAP logs on
> IGT. It sounds that it is parsing the data only at the end, and not as
> they arrive. That's bad, as if something goes wrong, the previously
> reported data is still useful.
> 
> Also, when there's a crash, the IGT process is getting segmentation
> fault. So, the end result is that nothing is actually reported.
> 
> 	$ sudo ./build/tests/i915_selftest
> 	IGT-Version: 1.26-gbab20eb65 (x86_64) (Linux: 6.1.0-rc2-drm-990037e9984e+ x86_64)
> 	Segmentation fault (core dumped)
> 
> However, the logs are there (see enclosed). In this specific case, there
> was a GPU hang while running one of the tests on a real hardware, which
> is something that it is actually expected at development time.

Btw, if you want to test it, the patches I'm using are at:
	https://patchwork.freedesktop.org/series/110483/

The latest patch there is a workaround that fixes the issue. So, if you
apply patches 1-7 only, skipping (or reverting) patch 8, you'll be able
to reproduce the Kernel crash (which seems to be caused by the way KUnit
is initialized).

Regards,
Mauro
