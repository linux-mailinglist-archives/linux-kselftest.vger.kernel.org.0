Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B00A692142
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 15:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjBJO6P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 09:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjBJO6O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 09:58:14 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AED77B9F;
        Fri, 10 Feb 2023 06:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676041060; x=1707577060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uGsHhSmLfn0k4uR1/avlGQfHpqa+SE/uoIYkvAW37Bw=;
  b=bCV237UOSUVjqs/ihJx8gqMHcjjCDkkSoSKshzQ35fb81/zeWNdMUeA7
   f5+NniOP0OYA39k5n8p4VEFFDUhy68qmrCgTxZ8+2gxwrds05pP6ij+1q
   hLfP2naRvXsHYjcG/8sUzcGesf/jl39Um4DZVGtOIz9y9fZQMyja+qTT3
   LYxs9KanMs9FeV/rabe7agiWsBylwXjPcv7fGPjH6X3hXOkDAS2B/tMYF
   YPNyjOuKvI5UelFmUcIZdrqNngBUoFl2oc38NFdEQPtqwOy/tEulcbjS0
   noPf6Hv6LZSzCsj3+XdzTReqcqZ7MnDl6yfaNy1Ua9TfuQavYQfaeQz/n
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="395041695"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="395041695"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 06:56:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="731735842"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="731735842"
Received: from jkrzyszt-mobl1.ger.corp.intel.com ([10.213.0.158])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 06:56:47 -0800
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Isabella Basso <isabbasso@riseup.net>
Cc:     igt-dev@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Magali Lemes <magalilemes00@gmail.com>,
        =?ISO-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>,
        Daniel Latypov <dlatypov@google.com>, n@nfraprado.net,
        kernel list <linux-kernel@vger.kernel.org>,
        leandro.ribeiro@collabora.com,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Gow <davidgow@google.com>,
        Tales Aparecida <tales.aparecida@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@riseup.net>,
        Brendan Higgins <brendanhiggins@google.com>,
        Trevor Woerner <twoerner@gmail.com>,
        Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
Subject: Re: [igt-dev] [PATCH i-g-t v2 3/4] lib/igt_kmod: add compatibility for KUnit
Date:   Fri, 10 Feb 2023 15:56:44 +0100
Message-ID: <7621786.lvqk35OSZv@jkrzyszt-mobl1.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <66E07FE6-0FE1-4CDF-A346-CF23C7B9D073@riseup.net>
References: <20220829000920.38185-1-isabbasso@riseup.net> <2101392.KlZ2vcFHjT@jkrzyszt-mobl1.ger.corp.intel.com> <66E07FE6-0FE1-4CDF-A346-CF23C7B9D073@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Isabella,

On Monday, 19 September 2022 22:55:44 CET Isabella Basso wrote:
> Hi, Janusz,
> 
> > Am 09/09/2022 um 12:18 PM schrieb Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>:
> > 
> > ...
> > 
> > Anyway, related to my comment about naming that function a parser, I think the 
> > best approach would be for that parser to return a generic set of results from 
> > kunit execution, then we could feed that data into an IGT specific handler 
> > that would convert them to IGT results (SUCCESS, FAIL, or SKIP) as if returned 
> > by a set of IGT dynamic subtests.
> 
> That sounds like a good idea to me, I might take some extra time before v3 to
> do that, though. 

Were you able to make any progress?  Do you need any help?

Thanks,
Janusz


