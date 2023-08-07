Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA06771DD6
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 12:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjHGKVh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 06:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjHGKVg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 06:21:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10D110F3;
        Mon,  7 Aug 2023 03:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691403694; x=1722939694;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Rm7LJQ564OLnj/iw6lW7UPOFQ16qq+MdcojYn2IG2Uk=;
  b=XQlPyV5vG3XazqVqdpe/Z4jikIA17Q9BxXA129aSbPfGWFj1FOCi5s2d
   jrWJYusFawivFSK9fHtoxsfn5U1azWGbFR52JPUXLOL41787i0PlHy5Lh
   PgOr2BeXIKrRD9OkoLOyCoqdZgTzZ9oflOYCaRcXfwpBvYYEDDS0KRqd9
   btNfWaPMxlbknwAPArJP6vLqVt/29kdjSq7GlCRH/uIyecV+xB7hhgZk+
   bB0/0p4wTaFfbAUe9CiBdQ6+667RIn4YKMY21ttqCXMvEsFsfJV57Jek5
   bNlj5bSXY2hIoSz9VgBkruyoUv2gJTOFrcpQ3QjK9zTTGM49tQr9i3t6x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="350816748"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="350816748"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 03:21:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="765945835"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="765945835"
Received: from siminapx-mobl1.ger.corp.intel.com ([10.251.210.150])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 03:21:31 -0700
Date:   Mon, 7 Aug 2023 13:21:29 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 12/19] selftests/resctrl: Remove "malloc_and_init_memory"
 param from run_fill_buf()
In-Reply-To: <856ad175-26f8-90ea-d801-c722d2b19b2e@intel.com>
Message-ID: <89befd7d-f756-f462-3986-a63f4e3dba86@linux.intel.com>
References: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com> <20230717131507.32420-13-ilpo.jarvinen@linux.intel.com> <7bba4db8-eaac-238d-b764-89d0ae2a9bba@linuxfoundation.org> <856ad175-26f8-90ea-d801-c722d2b19b2e@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1195163407-1691403693=:9752"
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

--8323329-1195163407-1691403693=:9752
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 25 Jul 2023, Reinette Chatre wrote:

> Hi Shuah,
> 
> On 7/25/2023 7:49 AM, Shuah Khan wrote:
> > WARNING: Prefer strscpy over strcpy - see: https://github.com/KSPP/linux/issues/88
> > #233: FILE: tools/testing/selftests/resctrl/resctrl_tests.c:276:
> > +        strcpy(benchmark_cmd[3], "0");
> > 
> > WARNING: Prefer strscpy over strcpy - see: https://github.com/KSPP/linux/issues/88
> > #234: FILE: tools/testing/selftests/resctrl/resctrl_tests.c:277:
> > +        strcpy(benchmark_cmd[4], "");
> > 
> > total: 0 errors, 2 warnings, 142 lines checked
> > 
> > I am applying the patch set to linux-kselftest next - please fix
> > the aboe and send a patch on top of linux-kselftest next
> 
> Is strscpy() available to userspace? I found lib/strscpy_kunit.c
> that makes me think this is currently only available to kernel code.

It's not available and I've done so little userspace programming in 
the recent years (and even less string manipulation in userspace C)
I've no idea what would be the best way to replace it.

However, I've a few patches which will cleanup the benchmark command 
handling that include removal of these strcpy()s. Those changes looked 
separate enough from the rest I can send it independent of that CAT 
rewrite which would have been the next entry in my pending resctrl 
selftest patches queue.


-- 
 i.

--8323329-1195163407-1691403693=:9752--
