Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063D16ED199
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Apr 2023 17:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjDXPmD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Apr 2023 11:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjDXPmC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Apr 2023 11:42:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD3E114;
        Mon, 24 Apr 2023 08:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682350921; x=1713886921;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eON86bjQxLIOpj1Q+K6F2tLoFgRPgNoaWLb8jdjvrLM=;
  b=Iga/av/7FM1NfoFS8iQqh7xkFm3Aiw2h7cAPpKx/bIixOsxbRlP0RmU0
   sKIlfDUYxpYSeVPsHXZshXC/Scgn7wJyq5OG02Ay/sreVqmbbFP3+Ok1M
   jJ+WEyEIKKi8Ry+rAQW9gkyTo6itXSYbumfvkggxN80KoFcdjkNj33ODW
   5jsziptOJ53ju1vDbsdGDFHqcFRCEGQjUhGIw8ERgOX4G+y2Ha+yqer06
   TUZUi1C041JC/sz98SzCr3qls2uzhFemXGWX1WeaLvi5nZOz/gT3LXTg5
   NhitmO+QDSs7oXXAVCvELSEcHSgt8nm38y+9uzO50bUNmbHqsHoqb3bU9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="432760499"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="432760499"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 08:42:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="723633528"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="723633528"
Received: from wlwpo-8.amr.corp.intel.com ([10.251.215.143])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 08:41:59 -0700
Date:   Mon, 24 Apr 2023 18:41:56 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kselftest@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH v2 07/24] selftests/resctrl: Remove duplicated preparation
 for span arg
In-Reply-To: <59cfa762-24c8-5b53-feca-517250192d65@intel.com>
Message-ID: <fe28574-eb8-28a-1189-7bd470a8bcb@linux.intel.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com> <20230418114506.46788-8-ilpo.jarvinen@linux.intel.com> <59cfa762-24c8-5b53-feca-517250192d65@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1821647782-1682350921=:2038"
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

--8323329-1821647782-1682350921=:2038
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 21 Apr 2023, Reinette Chatre wrote:

> On 4/18/2023 4:44 AM, Ilpo Järvinen wrote:
> > When no benchmark_cmd is given, benchmark_cmd[1] is set to span in
> > main(). There's no need to do it again in run_mba_test().
> > 
> > Remove the duplicated preparation for span argument into
> > benchmark_cmd[1] from run_mba_test(). It enables also removing has_ben
> > argument from run_mba_test() as unnecessary.
> 
> I find the last sentence a bit hard to read. How about
> "After this, the has_ben argument to run_mba_test() can be removed.".
> 
> > 
> > Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  tools/testing/selftests/resctrl/resctrl_tests.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> > index f1ed2c89f228..3c8ec68eb507 100644
> > --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> > +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> > @@ -99,8 +99,8 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, unsigned long span,
> >  	umount_resctrlfs();
> >  }
> >  
> > -static void run_mba_test(bool has_ben, char **benchmark_cmd, unsigned long span,
> > -			 int cpu_no, char *bw_report)
> > +static void run_mba_test(char **benchmark_cmd, unsigned long span, int cpu_no,
> > +			 char *bw_report)
> >  {
> >  	int res;
> >  
> > @@ -117,8 +117,6 @@ static void run_mba_test(bool has_ben, char **benchmark_cmd, unsigned long span,
> >  		goto umount;
> >  	}
> >  
> > -	if (!has_ben)
> > -		sprintf(benchmark_cmd[1], "%lu", span);
> 
> Can "span" also be removed?

Yes.


-- 
 i.

--8323329-1821647782-1682350921=:2038--
