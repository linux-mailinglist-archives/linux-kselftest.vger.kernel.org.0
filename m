Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95826ED15E
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Apr 2023 17:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjDXPbu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Apr 2023 11:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjDXPbt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Apr 2023 11:31:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BAE93D8;
        Mon, 24 Apr 2023 08:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682350289; x=1713886289;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ESvsUH8k5QGLZXs7AyLey2PqvroGXsERodoGrdKQ7tk=;
  b=KOUq260LPTZvZO9LwCwbjxnBuect7eizhmODPy7Hyxp578b7Hxx34Scd
   Xb6Wcqx49b0rl4zhaX9qTuj/fNf0E1LioPY9ttbYUEAPNGl3VgmN9F6aD
   V1oDipPqU/oz1M2lJMvokyHmDjDzI1W42deWYjBC+uwM8YdqcnFODu9TY
   tgWTOuQaJgd+SJxPEqBrDvTVHMHB2uJ+Ypax1WxRvIcbEyvxhUSEVxcR6
   UH5zHyrP+hG3QkBEuzkTn0hC5vY8vXYWkdaBJLT78Uqp4AxoTM1xDYApG
   ie2nI9cg6RRCs75EPAfvMxaMUzpPAZ7pjj+w6xA+u7GKwHyyhexGiTkmZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="335373013"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="335373013"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 08:31:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="757744517"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="757744517"
Received: from wlwpo-8.amr.corp.intel.com ([10.251.215.143])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 08:31:26 -0700
Date:   Mon, 24 Apr 2023 18:31:24 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH v2 06/24] selftests/resctrl: Express span in bytes
In-Reply-To: <500854b8-f070-37fb-40c9-47715744f451@intel.com>
Message-ID: <983b41f-861-71c3-e62d-e79b393319c5@linux.intel.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com> <20230418114506.46788-7-ilpo.jarvinen@linux.intel.com> <500854b8-f070-37fb-40c9-47715744f451@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-274303526-1682350288=:2038"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-274303526-1682350288=:2038
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 21 Apr 2023, Reinette Chatre wrote:
> On 4/18/2023 4:44 AM, Ilpo Järvinen wrote:
> > Make MBA and MBM tests to use megabytes to represent span. CMT test
> > uses bytes.
> > 
> > Convert MBA and MBM tests to use bytes like CMT test to remove the
> > inconsistency between the tests. This also allows removing test
> > dependent buffer sizing from run_benchmark().
> 
> It is not clear to me how this patch achieves this goal since after
> it show_mba_info() still displays results in MB.

This was more for internal consistency as there was the test type 
dependent span calculation in run_benchmark(). I can fix the changelog to 
reflect that, however, what you think would be the best approach in 
show_bw_info(), should I leave the print to use MB (converting the 
internal representation back from bytes to MB there)?

-- 
 i.

--8323329-274303526-1682350288=:2038--
