Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D045769921
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 16:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjGaOMt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 10:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjGaOMq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 10:12:46 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CEBB3;
        Mon, 31 Jul 2023 07:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690812761; x=1722348761;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8lJQW7XtYIZJGUpSg5bDxxZ5nMixXPpf80t0cGGyY2I=;
  b=iFOLej+3Gi4EcqvZla2V8O8GivIhFXW062mjL1Hz1WPAJOK6oObhtYud
   f9eNwqfzO7IgKYKcUEHPoswLNY0DiptA0aCMDFLP2QtDxAkcTxJldOKVc
   CLLoBS6KqYFSOO/I8UZYa6jtBmJDTvuMlofollJbRaykBY0Gng8ZWaoGp
   GgKK8zTvKDSrSWS+EUVQQPw6ql/45P7OnGorOsI1+XL5MCwpXNb7QlTW6
   K/EDd9sRAAlpM7v/VOTY5vs977qrKXB6NIkuc2T5I2GJvYUijvnHZlhFV
   JJF59oIS2ngeU+pGmjy3HhNZGDNETbys/ZRnFHi7gqDhSAjI5+LCgpv6Y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="455403611"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="455403611"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 07:12:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="728324343"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="728324343"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO jkrzyszt-mobl2.intranet) ([10.213.1.128])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 07:12:38 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        igt-dev@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: [PATCH v3 0/3] kunit: Expose some built-in features to modules
Date:   Mon, 31 Jul 2023 16:10:22 +0200
Message-ID: <20230731141021.2854827-5-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Submit the top-level headers also from the kunit test module notifier
initialization callback, so external tools that are parsing dmesg for
kunit test output are able to tell how many test suites should be expected
and whether to continue parsing after complete output from the first test
suite is collected.

Extend kunit module notifier initialization callback with a processing
path for only listing the tests provided by a module if the kunit action
parameter is set to "list", so external tools can obtain a list of test
cases to be executed in advance and can make a better job on assigning
kernel messages interleaved with kunit output to specific tests.

Use test filtering functions in kunit module notifier callback functions,
so external tools are able to execute individual test cases from kunit
test modules in order to still better isolate their potential impact on
kernel messages that appear interleaved with output from other tests.

v3: Fix CONFIG_GLOB, required by filtering fuctions, not selected when
    building as a module.
v2: Fix new name of a structure moved to kunit namespace not updated
    across all uses.

Janusz Krzysztofik (3):
  kunit: Report the count of test suites in a module
  kunit: Make 'list' action available to kunit test modules
  kunit: Allow kunit test modules to use test filtering

 include/kunit/test.h | 14 +++++++++++
 lib/kunit/Kconfig    |  2 +-
 lib/kunit/executor.c | 57 +++++++++++++++++++++++++-------------------
 lib/kunit/test.c     | 57 +++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 104 insertions(+), 26 deletions(-)

-- 
2.41.0

