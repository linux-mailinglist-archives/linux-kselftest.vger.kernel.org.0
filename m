Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DF95B3B71
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 17:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiIIPGH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 11:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbiIIPGG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 11:06:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E0737FAC;
        Fri,  9 Sep 2022 08:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662735962; x=1694271962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=We9KN/npBy9H+uViA+V3sWO0mdLaDEfmpJXJMfwhST4=;
  b=SuKzwPqf5v+kIiwlEp230kDDfGo+kATTEbBFxMOBpbU5C6bdvvmpIFY9
   MYUiuUBUvXupPPBM7VmSn0ryIRArurqhBCk3KSIEHqnYtRDDNlrCsbxsw
   P4BQypxeU00F/CFbH/gNkkmuXpkjdBPGD3l5OOdMRMVDSz6BjCvO3kLJX
   CgSVPAXer0jBMNm3xJHREvJoNPJaTSfd4Oel2wgxXv3SOhyX8TPGdoA58
   TaXJ5ZFbQczQ3CRX+lV94snasvHmpeH6zdqByxd01F/2eHzDWNzVxR1W9
   dbjQxa0Lra1V5fMfFhsOQJhYL0WDSluhWwjJ3I6pO+31MVz6RDmBcZ62e
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="284512109"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="284512109"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 08:06:01 -0700
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="677188805"
Received: from jkrzyszt-mobl1.ger.corp.intel.com ([10.213.25.143])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 08:05:57 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     igt-dev@lists.freedesktop.org
Cc:     linux-kselftest@vger.kernel.org, daniel@ffwll.ch,
        kunit-dev@googlegroups.com, magalilemes00@gmail.com,
        maira.canal@usp.br, dlatypov@google.com, n@nfraprado.net,
        linux-kernel@vger.kernel.org, leandro.ribeiro@collabora.com,
        dri-devel@lists.freedesktop.org, davidgow@google.com,
        tales.aparecida@gmail.com, skhan@linuxfoundation.org,
        andrealmeid@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        brendanhiggins@google.com, twoerner@gmail.com,
        Isabella Basso <isabbasso@riseup.net>
Subject: Re: [igt-dev] [PATCH i-g-t v2 1/4] lib/igt_kmod: rename kselftest functions to ktest
Date:   Fri, 09 Sep 2022 17:05:54 +0200
Message-ID: <3054638.CbtlEUcBR6@jkrzyszt-mobl1.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20220829000920.38185-2-isabbasso@riseup.net>
References: <20220829000920.38185-1-isabbasso@riseup.net> <20220829000920.38185-2-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Monday, 29 August 2022 02:09:17 CEST Isabella Basso wrote:
> This aims at making IGT's structure more general to different kernel
> testing frameworks such as KUnit, as they use a lot of the same
> functionality.
> 
> Signed-off-by: Isabella Basso <isabbasso@riseup.net>

LGTM

Reviewed-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>

> ---
>  lib/igt_kmod.c | 22 +++++++++++-----------
>  lib/igt_kmod.h | 12 ++++++------
>  2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/lib/igt_kmod.c b/lib/igt_kmod.c
> index bcf7dfeb..bb6cb7bb 100644
> --- a/lib/igt_kmod.c
> +++ b/lib/igt_kmod.c
> @@ -718,8 +718,8 @@ static int open_parameters(const char *module_name)
>  	return open(path, O_RDONLY);
>  }
>  
> -int igt_kselftest_init(struct igt_kselftest *tst,
> -		       const char *module_name)
> +int igt_ktest_init(struct igt_ktest *tst,
> +		   const char *module_name)
>  {
>  	int err;
>  
> @@ -738,7 +738,7 @@ int igt_kselftest_init(struct igt_kselftest *tst,
>  	return 0;
>  }
>  
> -int igt_kselftest_begin(struct igt_kselftest *tst)
> +int igt_ktest_begin(struct igt_ktest *tst)
>  {
>  	int err;
>  
> @@ -753,7 +753,7 @@ int igt_kselftest_begin(struct igt_kselftest *tst)
>  	return 0;
>  }
>  
> -int igt_kselftest_execute(struct igt_kselftest *tst,
> +int igt_kselftest_execute(struct igt_ktest *tst,
>  			  struct igt_kselftest_list *tl,
>  			  const char *options,
>  			  const char *result)
> @@ -791,13 +791,13 @@ int igt_kselftest_execute(struct igt_kselftest *tst,
>  	return err;
>  }
>  
> -void igt_kselftest_end(struct igt_kselftest *tst)
> +void igt_ktest_end(struct igt_ktest *tst)
>  {
>  	kmod_module_remove_module(tst->kmod, KMOD_REMOVE_FORCE);
>  	close(tst->kmsg);
>  }
>  
> -void igt_kselftest_fini(struct igt_kselftest *tst)
> +void igt_ktest_fini(struct igt_ktest *tst)
>  {
>  	free(tst->module_name);
>  	kmod_module_unref(tst->kmod);
> @@ -820,15 +820,15 @@ void igt_kselftests(const char *module_name,
>  		    const char *result,
>  		    const char *filter)
>  {
> -	struct igt_kselftest tst;
> +	struct igt_ktest tst;
>  	IGT_LIST_HEAD(tests);
>  	struct igt_kselftest_list *tl, *tn;
>  
> -	if (igt_kselftest_init(&tst, module_name) != 0)
> +	if (igt_ktest_init(&tst, module_name) != 0)
>  		return;
>  
>  	igt_fixture
> -		igt_require(igt_kselftest_begin(&tst) == 0);
> +		igt_require(igt_ktest_begin(&tst) == 0);
>  
>  	igt_kselftest_get_tests(tst.kmod, filter, &tests);
>  	igt_subtest_with_dynamic(filter ?: "all") {
> @@ -847,9 +847,9 @@ void igt_kselftests(const char *module_name,
>  	}
>  
>  	igt_fixture {
> -		igt_kselftest_end(&tst);
> +		igt_ktest_end(&tst);
>  		igt_require(!igt_list_empty(&tests));
>  	}
>  
> -	igt_kselftest_fini(&tst);
> +	igt_ktest_fini(&tst);
>  }
> diff --git a/lib/igt_kmod.h b/lib/igt_kmod.h
> index f98dd29f..ceb10cd0 100644
> --- a/lib/igt_kmod.h
> +++ b/lib/igt_kmod.h
> @@ -50,7 +50,7 @@ void igt_kselftests(const char *module_name,
>  		    const char *result_option,
>  		    const char *filter);
>  
> -struct igt_kselftest {
> +struct igt_ktest {
>  	struct kmod_module *kmod;
>  	char *module_name;
>  	int kmsg;
> @@ -63,19 +63,19 @@ struct igt_kselftest_list {
>  	char param[];
>  };
>  
> -int igt_kselftest_init(struct igt_kselftest *tst,
> +int igt_ktest_init(struct igt_ktest *tst,
>  		       const char *module_name);
> -int igt_kselftest_begin(struct igt_kselftest *tst);
> +int igt_ktest_begin(struct igt_ktest *tst);
>  
>  void igt_kselftest_get_tests(struct kmod_module *kmod,
>  			     const char *filter,
>  			     struct igt_list_head *tests);
> -int igt_kselftest_execute(struct igt_kselftest *tst,
> +int igt_kselftest_execute(struct igt_ktest *tst,
>  			  struct igt_kselftest_list *tl,
>  			  const char *module_options,
>  			  const char *result);
>  
> -void igt_kselftest_end(struct igt_kselftest *tst);
> -void igt_kselftest_fini(struct igt_kselftest *tst);
> +void igt_ktest_end(struct igt_ktest *tst);
> +void igt_ktest_fini(struct igt_ktest *tst);
>  
>  #endif /* IGT_KMOD_H */
> 




