Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3225C4DE44E
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Mar 2022 23:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241397AbiCRWuM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Mar 2022 18:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241379AbiCRWuM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Mar 2022 18:50:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD51527854E;
        Fri, 18 Mar 2022 15:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647643732; x=1679179732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q7sIQTUKcQYGDy/VIAM8n1/fsITuihGNnxq3f4/iyU8=;
  b=GeAw6z1IH3EcTaMlhkr3UxQof1Hj/P/1NwucBndcf6Bqg91l/ZEqNArD
   wgll5oyuZUR/ZwtArmfHIX3yJiElyAQ37OlJh6zjyKm7OaOMekSph+602
   vtZ82dKlsVphkvHCsXcjOolk1iJUIftkHtGYfQAJABVmtOS0DO/RNLhFx
   TmeOjrTDSIjURXfNR3PjxZd9f1dwNwaUEac7X0WleY5Vqsi7UFGoHjMP9
   YSfVtgOVg33vZGMlwxUR4ww61m9K3pTGJuueWWIHk5JxWeM0Ut/ZSoeHZ
   Oo1k8HQkcSCx+ItWEA5kOdUmKBahLSNjHq1x6iBpw0LCdxlWcJnx0IfAI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="237851667"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="237851667"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 15:48:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="517446136"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 15:48:52 -0700
Date:   Fri, 18 Mar 2022 15:48:50 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 2/6] selftests/resctrl: Change the default limited
 time to 120 seconds
Message-ID: <YjUMUs7oIFXsjezq@otcwcpicx3.sc.intel.com>
References: <20220318075807.2921063-1-tan.shaopeng@jp.fujitsu.com>
 <20220318075807.2921063-3-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318075807.2921063-3-tan.shaopeng@jp.fujitsu.com>
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 18, 2022 at 04:58:03PM +0900, Shaopeng Tan wrote:
> When testing on a Intel(R) Xeon(R) Gold 6254 CPU @ 3.10GHz the resctrl
> selftests fail due to timeout after exceeding the default time limit of
> 45 seconds. On this system the test takes about 68 seconds.
> Since the failing test by default accesses a fixed size of memory, the
> execution time should not vary significantly between different environment.
> A new default of 120 seconds should be sufficient yet easy to customize
> with the introduction of the "settings" file for reference.
> 
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/settings | 3 +++
>  1 file changed, 3 insertions(+)
>  create mode 100644 tools/testing/selftests/resctrl/settings
> 
> diff --git a/tools/testing/selftests/resctrl/settings b/tools/testing/selftests/resctrl/settings
> new file mode 100644
> index 000000000000..a383f3d4565b
> --- /dev/null
> +++ b/tools/testing/selftests/resctrl/settings
> @@ -0,0 +1,3 @@
> +# If running time is longer than 120 seconds when new tests are added in
> +# the future, increase timeout here.
> +timeout=120
> -- 
> 2.27.0
> 
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
