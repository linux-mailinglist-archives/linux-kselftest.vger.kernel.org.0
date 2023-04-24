Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84046ED0EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Apr 2023 17:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjDXPGZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Apr 2023 11:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjDXPGY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Apr 2023 11:06:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F2D35AC;
        Mon, 24 Apr 2023 08:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682348783; x=1713884783;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=P2/o+HQtOGekrFjXgRaUqQiENOerFGVjTh6Xgf7VXmE=;
  b=fImFD0R+EpT7+Xqh9PkGGcapXxWBuUR9/iO5Ltw+h+xqAteL2vTJkUtA
   xVuJTjpADMwOki8xGIifzU09ddGiGiPDdyoYFtB2Kgqq10UEhtEUf1TG9
   T7OR7y6PqenzIFJSWJGrsaFA0a8XWoDrZ9hjzOFIluvlYp/OHaQIHRvbi
   KDem6mBFVymSrRTXwYr8DQFo8s422MGePNaJRLcVu1Pudew3c99ixNbVa
   N149NBRDdJU5ASJ51TmA3cyey0WaDrEiTRDZ1nR9IMRro97Ax9OKtIbpY
   GnyhtAtaNB9U5doW1CVvGR5GD1j4zLIEaW72g/R4oZ/1EFEBFlUpm/tCn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="346500432"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="346500432"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 08:05:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="670529165"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="670529165"
Received: from wlwpo-8.amr.corp.intel.com ([10.251.215.143])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 08:05:53 -0700
Date:   Mon, 24 Apr 2023 18:05:50 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH v2 05/24] selftests/resctrl: Make span unsigned long
 everywhere
In-Reply-To: <83a61c92-01bf-0ac3-709d-7ba2ed0259b2@intel.com>
Message-ID: <6585df2-6b55-b1da-483-7c2e3356e6bf@linux.intel.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com> <20230418114506.46788-6-ilpo.jarvinen@linux.intel.com> <83a61c92-01bf-0ac3-709d-7ba2ed0259b2@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-702082943-1682348754=:2038"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-702082943-1682348754=:2038
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 21 Apr 2023, Reinette Chatre wrote:
> On 4/18/2023 4:44 AM, Ilpo Järvinen wrote:
> > fill_buf(), show_bw_info(), and resctrl_val_param.span define span as
> > unsigned long.
> 
> There is no fill_buf() in the code and show_bw_info() does
> not define span as unsigned long (it is even the first function
> changed in this patch).

Shuffling a large number of patches around seems detrimental for the 
quality of the commit messages no matter how hard I try to maintain them 
up to date. Thanks for noticing this.

> > Consistently use unsigned long elsewhere too for span parameters.
> 
> Is unsigned long the right type to use? Tracing through all the
> indirections I do not see how making all usages unsigned long
> achieves consistency ... have you considered size_t?

I'll change to size_t as it refers to the size of the memory block.

-- 
 i.

--8323329-702082943-1682348754=:2038--
