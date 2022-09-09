Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257E35B3B12
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 16:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiIIOtg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 10:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiIIOtd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 10:49:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D685B11176;
        Fri,  9 Sep 2022 07:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662734971; x=1694270971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F9RWZbrEgWr3jOpGPJzSTGXGG9s7o1/0a4ZDcE3DRRM=;
  b=MoC6SOsySulYWNq1uchtX5W4Dqd93YC+zqEj9qP6oR9aMtxfF1ZDtlSd
   OuQF71KfBEZcZgeZZyhkZMopVnDgd6KGr4b+8+3lH35ZiYOXqMv99lp0f
   L6Pmt6rpszFYwyVlTILh/FPQfNr85CUMp8G9ZN+DxJY4/q5uHTlZxctZR
   lmAWI6lqS6WZyH8iv+4R5QLg+jfN14VwGbzMGe7ClnHvjVjyvbEEBvqfM
   bLcDsN3Mu+is4+Vv4UDo17jUoYeC35BQBvcs5aUPjfqhS4Y/vTne3GD4P
   v1QQMJbnH7AhLL5JXlWlNYZRRmfVOAvPIaGvXFSrrNH7IWI/syEFZqMRG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="296227134"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="296227134"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 07:49:31 -0700
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="677183072"
Received: from jkrzyszt-mobl1.ger.corp.intel.com ([10.213.25.143])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 07:49:26 -0700
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
Subject: Re: [igt-dev] [PATCH i-g-t v2 0/4] Add support for KUnit tests
Date:   Fri, 09 Sep 2022 16:49:24 +0200
Message-ID: <5354052.Sb9uPGUboI@jkrzyszt-mobl1.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20220829000920.38185-1-isabbasso@riseup.net>
References: <20220829000920.38185-1-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Isabella,

On Monday, 29 August 2022 02:09:16 CEST Isabella Basso wrote:
> This patch series was first developed as part of the LKCamp hackathon
> that happened last year[1], mainly focusing on refactoring DRM tests to
> use KUnit.
> 
> KUnit[2][3] is a unified test framework that provides helper tools,
> simplifying their development and execution. Using an x86-64 machine
> it's possible to run tests in the host's kernel natively using user-mode
> Linux[4] (aka UML), which simplifies usage in a wide variety of
> scenarios, including integration to CI.
> 
> As the tool's adoption widens into graphics testing territory, I and
> LKCamp members figured it would be important to support it in IGT, as
> it's a core tool for GPU drivers maintainers.
> 
> I have then added KUnit support into IGT mainly following the KTAP
> specs, and it can be tested using patch 4/4 in this series together with
> a DRM selftests patch series available at [5].

CI pre-merge results indicate that your new versions of tests were not able to 
load kunit module, then didn't actually execute any kunit tests, but returned 
SUCCESS.  That's probably not what we expect from IGT tests.

https://intel-gfx-ci.01.org/tree/drm-tip/IGTPW_7698/shard-rkl-4/igt@drm_buddy.html
https://intel-gfx-ci.01.org/tree/drm-tip/IGTPW_7698/shard-rkl-1/igt@drm_mm.html
https://intel-gfx-ci.01.org/tree/drm-tip/IGTPW_7698/shard-rkl-5/igt@kms_selftest.html

Thanks,
Janusz

> 
> Changes since v1:
> - Major rework of parsing function structure:
>   - It is not longer recursive
>   - Adapt kselftests functions and structs to be used with KUnit
> - Switch DRM selftests to KUnit parsing as they're updated in the kernel
> - Replace AMD KUnit tests by DRM selftests
> 
> [1]: https://groups.google.com/g/kunit-dev/c/YqFR1q2uZvk/m/IbvItSfHBAAJ
> [2]: https://kunit.dev
> [3]: https://docs.kernel.org/dev-tools/kunit/index.html
> [4]: http://user-mode-linux.sourceforge.net
> [5]: https://lore.kernel.org/all/20220708203052.236290-1-maira.canal@usp.br/
> 
> Isabella Basso (4):
>   lib/igt_kmod: rename kselftest functions to ktest
>   lib/igt_kmod.c: check if module is builtin before attempting to unload
>     it
>   lib/igt_kmod: add compatibility for KUnit
>   tests: DRM selftests: switch to KUnit
> 
>  lib/igt_kmod.c       | 315 +++++++++++++++++++++++++++++++++++++++++--
>  lib/igt_kmod.h       |  14 +-
>  tests/drm_buddy.c    |   7 +-
>  tests/drm_mm.c       |   7 +-
>  tests/kms_selftest.c |  12 +-
>  5 files changed, 329 insertions(+), 26 deletions(-)
> 
> 




