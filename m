Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DE2550F8D
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jun 2022 07:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiFTFFy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Jun 2022 01:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiFTFFy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Jun 2022 01:05:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA9BD133;
        Sun, 19 Jun 2022 22:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655701553; x=1687237553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0CFFG2LTJ/49RkrrvRheatNkvjYQNThXwuBHWnmvnA4=;
  b=j1YcI0skDtK2A7CEIZoPrId9RIgqi6vnXRAOTw88fG7e7Tt1uzb83OEJ
   9APB0pJEvUXAwdg57/9RDcbPQMzGrmlKI2JoJx/TLZuYbYsYtvYusVKoC
   7j2OADh6wtW/EoyoGXt6k2FjAoSYGTXt+JYEU88QWaHQz0jjdSSFXfJdn
   WC6Y831OHB07LXIcOfMV5mvPl5M1SqLqCF10UYY5a2enkefSEwLqQvCuh
   AFpzl+s8zxgidTJikevPxXTt9ZfXeNkRbOiafBpxUM1KLPQaLLXWrh+nm
   1KbUxoOTmYaNU45VgYsanYpLvZnht9VIsnGazMhaY7OqN7+ftT0AETtWW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="259624220"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="259624220"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 22:05:53 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="654500483"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 22:05:48 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 20 Jun 2022 08:05:46 +0300
Date:   Mon, 20 Jun 2022 08:05:46 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Andra Paraschiv <andraprs@amazon.com>,
        Longpeng <longpeng2@huawei.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>,
        linux-mmc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-modules@vger.kernel.org,
        Matt Johnston <matt@codeconstruct.com.au>
Subject: Re: [PATCH 3/5] thunderbolt: test: Use kunit_test_suite() macro
Message-ID: <YrAAKqdiG3GAGh1r@lahna>
References: <20220618090310.1174932-1-davidgow@google.com>
 <20220618090310.1174932-4-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618090310.1174932-4-davidgow@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jun 18, 2022 at 05:03:08PM +0800, David Gow wrote:
> The new implementation of kunit_test_suite() for modules no longer
> conflicts with module_init, so can now be used by the thunderbolt tests.
> 
> Also update the Kconfig entry to enable the test when KUNIT_ALL_TESTS is
> enabled.
> 
> This means that kunit_tool can now successfully run and parse the test
> results with, for example:
> 	./tools/testing/kunit/kunit.py run --arch=x86_64 \
> 	--kconfig_add CONFIG_PCI=y --kconfig_add CONFIG_USB4=y \
> 	'thunderbolt'
> 
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
