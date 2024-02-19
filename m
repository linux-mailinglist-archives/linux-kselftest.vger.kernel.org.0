Return-Path: <linux-kselftest+bounces-4919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C381C859AAF
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 03:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BA38B20AAA
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 02:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6121865;
	Mon, 19 Feb 2024 02:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZl8GWRm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FD81FB3;
	Mon, 19 Feb 2024 02:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708309326; cv=none; b=IOHS4KYT/fIBc4ix1Sukvk1Qn5IaQ0Q0vwWCI0cMM6zcI/Ta3csk/1hy9UaOesANZ3NvXb/1qOjykgetNwBTZeh5I7xLQPGA2LUBz7KIcHa14RxWNPJZJdaUR0kbB+evVMJosYK6H81fQQC1QuAJbA5DCfwVaDk8zlUOOS6AnEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708309326; c=relaxed/simple;
	bh=XM6BHUMrYiGJWWnHdlrLk6QnlNQ6a4vpycoEl/2Upak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=me0pyP1CDWr7tl/GmxuxPpRdEumVFw7EK6EuWzsnVua5R9mhefcnV1UFIXQ2EKNPJ6TY/6qGgk7KhwMz0A1Tdh9WIOjcOTINKO38Qsge6M32O+cxviKU9b8dYUVeJVlp3LbxHV3DiGkwD4XIpzkoVFyIui3j7BfO67HI/JyZZiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZl8GWRm; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708309324; x=1739845324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XM6BHUMrYiGJWWnHdlrLk6QnlNQ6a4vpycoEl/2Upak=;
  b=eZl8GWRmfjxtCrFwEWEt1Fbzwy6yRi3eOijQWoG1jdsJPynobp8ecFen
   v5+RCQ+4jsXms0VHS+7mK8PyHvsaXErSjNBElaTZ6mCdXvz8vO1jhzy1n
   JMsOnOkX5GmWVXBXVtfMEippmx+8Krd749j4i6xKLIGVwq/eEFhoclJQy
   Qi+Xj++EBhg3Q+gRER2z0oYeOKP/wwUuLuMuBrqBrJAYAO9eHeKrf5gQ9
   zvIUuKUcxTo0rCWxZ9Hd/kqfdx59v5Qvy4C1EXSNLxl6EX2Vb12mZ8CuO
   vwBvR8mHHzWVD1znqO2LRXs2lSWCFO+bEc/oOHylQRC1sgsUo30GY6pAk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="27822091"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="27822091"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 18:22:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4509411"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 18 Feb 2024 18:22:00 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbtHw-0003RK-2L;
	Mon, 19 Feb 2024 02:21:53 +0000
Date: Mon, 19 Feb 2024 10:21:40 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, shuah@kernel.org,
	keescook@chromium.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, jakub@cloudflare.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 1/4] selftests: kselftest_harness: pass step via
 shared memory
Message-ID: <202402191034.76fuePpP-lkp@intel.com>
References: <20240213154416.422739-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213154416.422739-2-kuba@kernel.org>

Hi Jakub,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Kicinski/selftests-kselftest_harness-pass-step-via-shared-memory/20240213-234644
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240213154416.422739-2-kuba%40kernel.org
patch subject: [PATCH net-next 1/4] selftests: kselftest_harness: pass step via shared memory
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240219/202402191034.76fuePpP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402191034.76fuePpP-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs_test.c:26:
   fs_test.c: In function 'layout1_no_restriction':
>> common.h:52:40: error: 'struct __test_metadata' has no member named 'step'
      52 |                         _exit(_metadata->step); \
         |                                        ^~
   fs_test.c:403:1: note: in expansion of macro 'TEST_F_FORK'
     403 | TEST_F_FORK(layout1, no_restriction)
         | ^~~~~~~~~~~
   common.h:58:34: error: 'struct __test_metadata' has no member named 'step'
      58 |                         _metadata->step = 1; \
         |                                  ^~
   fs_test.c:403:1: note: in expansion of macro 'TEST_F_FORK'
     403 | TEST_F_FORK(layout1, no_restriction)
         | ^~~~~~~~~~~
   common.h:71:34: error: 'struct __test_metadata' has no member named 'step'
      71 |                         _metadata->step = WEXITSTATUS(status); \
         |                                  ^~
   fs_test.c:403:1: note: in expansion of macro 'TEST_F_FORK'
     403 | TEST_F_FORK(layout1, no_restriction)
         | ^~~~~~~~~~~
   fs_test.c: In function 'layout1_inval':
>> common.h:52:40: error: 'struct __test_metadata' has no member named 'step'
      52 |                         _exit(_metadata->step); \
         |                                        ^~
   fs_test.c:426:1: note: in expansion of macro 'TEST_F_FORK'
     426 | TEST_F_FORK(layout1, inval)
         | ^~~~~~~~~~~
   common.h:58:34: error: 'struct __test_metadata' has no member named 'step'
      58 |                         _metadata->step = 1; \
         |                                  ^~
   fs_test.c:426:1: note: in expansion of macro 'TEST_F_FORK'
     426 | TEST_F_FORK(layout1, inval)
         | ^~~~~~~~~~~
   common.h:71:34: error: 'struct __test_metadata' has no member named 'step'
      71 |                         _metadata->step = WEXITSTATUS(status); \
         |                                  ^~
   fs_test.c:426:1: note: in expansion of macro 'TEST_F_FORK'
     426 | TEST_F_FORK(layout1, inval)
         | ^~~~~~~~~~~
   fs_test.c: In function 'layout1_file_and_dir_access_rights':
>> common.h:52:40: error: 'struct __test_metadata' has no member named 'step'
      52 |                         _exit(_metadata->step); \
         |                                        ^~
   fs_test.c:548:1: note: in expansion of macro 'TEST_F_FORK'
     548 | TEST_F_FORK(layout1, file_and_dir_access_rights)
         | ^~~~~~~~~~~
   common.h:58:34: error: 'struct __test_metadata' has no member named 'step'
      58 |                         _metadata->step = 1; \
         |                                  ^~
   fs_test.c:548:1: note: in expansion of macro 'TEST_F_FORK'
     548 | TEST_F_FORK(layout1, file_and_dir_access_rights)
         | ^~~~~~~~~~~
   common.h:71:34: error: 'struct __test_metadata' has no member named 'step'
      71 |                         _metadata->step = WEXITSTATUS(status); \
         |                                  ^~
   fs_test.c:548:1: note: in expansion of macro 'TEST_F_FORK'
     548 | TEST_F_FORK(layout1, file_and_dir_access_rights)
         | ^~~~~~~~~~~
   fs_test.c: In function 'layout0_ruleset_with_unknown_access':
>> common.h:52:40: error: 'struct __test_metadata' has no member named 'step'
      52 |                         _exit(_metadata->step); \
         |                                        ^~
   fs_test.c:592:1: note: in expansion of macro 'TEST_F_FORK'
     592 | TEST_F_FORK(layout0, ruleset_with_unknown_access)
         | ^~~~~~~~~~~
   common.h:58:34: error: 'struct __test_metadata' has no member named 'step'
      58 |                         _metadata->step = 1; \
         |                                  ^~
   fs_test.c:592:1: note: in expansion of macro 'TEST_F_FORK'
     592 | TEST_F_FORK(layout0, ruleset_with_unknown_access)
         | ^~~~~~~~~~~
   common.h:71:34: error: 'struct __test_metadata' has no member named 'step'
      71 |                         _metadata->step = WEXITSTATUS(status); \
         |                                  ^~
   fs_test.c:592:1: note: in expansion of macro 'TEST_F_FORK'
     592 | TEST_F_FORK(layout0, ruleset_with_unknown_access)
         | ^~~~~~~~~~~
   fs_test.c: In function 'layout0_rule_with_unknown_access':
>> common.h:52:40: error: 'struct __test_metadata' has no member named 'step'
      52 |                         _exit(_metadata->step); \
         |                                        ^~
   fs_test.c:608:1: note: in expansion of macro 'TEST_F_FORK'
     608 | TEST_F_FORK(layout0, rule_with_unknown_access)
         | ^~~~~~~~~~~
   common.h:58:34: error: 'struct __test_metadata' has no member named 'step'
      58 |                         _metadata->step = 1; \
         |                                  ^~
   fs_test.c:608:1: note: in expansion of macro 'TEST_F_FORK'
     608 | TEST_F_FORK(layout0, rule_with_unknown_access)
         | ^~~~~~~~~~~
   common.h:71:34: error: 'struct __test_metadata' has no member named 'step'
      71 |                         _metadata->step = WEXITSTATUS(status); \
         |                                  ^~
   fs_test.c:608:1: note: in expansion of macro 'TEST_F_FORK'
     608 | TEST_F_FORK(layout0, rule_with_unknown_access)
         | ^~~~~~~~~~~
   fs_test.c: In function 'layout1_rule_with_unhandled_access':
>> common.h:52:40: error: 'struct __test_metadata' has no member named 'step'
      52 |                         _exit(_metadata->step); \
         |                                        ^~
   fs_test.c:635:1: note: in expansion of macro 'TEST_F_FORK'
     635 | TEST_F_FORK(layout1, rule_with_unhandled_access)
         | ^~~~~~~~~~~
   common.h:58:34: error: 'struct __test_metadata' has no member named 'step'
      58 |                         _metadata->step = 1; \
         |                                  ^~
   fs_test.c:635:1: note: in expansion of macro 'TEST_F_FORK'
     635 | TEST_F_FORK(layout1, rule_with_unhandled_access)
         | ^~~~~~~~~~~
   common.h:71:34: error: 'struct __test_metadata' has no member named 'step'
      71 |                         _metadata->step = WEXITSTATUS(status); \
         |                                  ^~
   fs_test.c:635:1: note: in expansion of macro 'TEST_F_FORK'
     635 | TEST_F_FORK(layout1, rule_with_unhandled_access)
         | ^~~~~~~~~~~
   fs_test.c: In function 'layout0_proc_nsfs':
>> common.h:52:40: error: 'struct __test_metadata' has no member named 'step'
      52 |                         _exit(_metadata->step); \
         |                                        ^~
   fs_test.c:741:1: note: in expansion of macro 'TEST_F_FORK'
     741 | TEST_F_FORK(layout0, proc_nsfs)
         | ^~~~~~~~~~~
   common.h:58:34: error: 'struct __test_metadata' has no member named 'step'
      58 |                         _metadata->step = 1; \
         |                                  ^~
   fs_test.c:741:1: note: in expansion of macro 'TEST_F_FORK'
     741 | TEST_F_FORK(layout0, proc_nsfs)
         | ^~~~~~~~~~~
   common.h:71:34: error: 'struct __test_metadata' has no member named 'step'
      71 |                         _metadata->step = WEXITSTATUS(status); \
         |                                  ^~
   fs_test.c:741:1: note: in expansion of macro 'TEST_F_FORK'
     741 | TEST_F_FORK(layout0, proc_nsfs)
         | ^~~~~~~~~~~
   fs_test.c: In function 'layout0_unpriv':
>> common.h:52:40: error: 'struct __test_metadata' has no member named 'step'
      52 |                         _exit(_metadata->step); \
         |                                        ^~
   fs_test.c:790:1: note: in expansion of macro 'TEST_F_FORK'
     790 | TEST_F_FORK(layout0, unpriv)
         | ^~~~~~~~~~~
   common.h:58:34: error: 'struct __test_metadata' has no member named 'step'
      58 |                         _metadata->step = 1; \
         |                                  ^~
   fs_test.c:790:1: note: in expansion of macro 'TEST_F_FORK'
     790 | TEST_F_FORK(layout0, unpriv)
         | ^~~~~~~~~~~
   common.h:71:34: error: 'struct __test_metadata' has no member named 'step'
      71 |                         _metadata->step = WEXITSTATUS(status); \
         |                                  ^~
   fs_test.c:790:1: note: in expansion of macro 'TEST_F_FORK'
     790 | TEST_F_FORK(layout0, unpriv)
         | ^~~~~~~~~~~
   fs_test.c: In function 'layout1_effective_access':
>> common.h:52:40: error: 'struct __test_metadata' has no member named 'step'
      52 |                         _exit(_metadata->step); \
         |                                        ^~
   fs_test.c:813:1: note: in expansion of macro 'TEST_F_FORK'
     813 | TEST_F_FORK(layout1, effective_access)
         | ^~~~~~~~~~~
   common.h:58:34: error: 'struct __test_metadata' has no member named 'step'
      58 |                         _metadata->step = 1; \
         |                                  ^~
   fs_test.c:813:1: note: in expansion of macro 'TEST_F_FORK'
     813 | TEST_F_FORK(layout1, effective_access)
         | ^~~~~~~~~~~
   common.h:71:34: error: 'struct __test_metadata' has no member named 'step'
      71 |                         _metadata->step = WEXITSTATUS(status); \
         |                                  ^~
   fs_test.c:813:1: note: in expansion of macro 'TEST_F_FORK'
     813 | TEST_F_FORK(layout1, effective_access)
         | ^~~~~~~~~~~
   fs_test.c: In function 'layout1_unhandled_access':
>> common.h:52:40: error: 'struct __test_metadata' has no member named 'step'
      52 |                         _exit(_metadata->step); \
         |                                        ^~
   fs_test.c:871:1: note: in expansion of macro 'TEST_F_FORK'
     871 | TEST_F_FORK(layout1, unhandled_access)
         | ^~~~~~~~~~~
   common.h:58:34: error: 'struct __test_metadata' has no member named 'step'
      58 |                         _metadata->step = 1; \
         |                                  ^~
   fs_test.c:871:1: note: in expansion of macro 'TEST_F_FORK'
     871 | TEST_F_FORK(layout1, unhandled_access)
         | ^~~~~~~~~~~
   common.h:71:34: error: 'struct __test_metadata' has no member named 'step'
      71 |                         _metadata->step = WEXITSTATUS(status); \
         |                                  ^~
   fs_test.c:871:1: note: in expansion of macro 'TEST_F_FORK'
     871 | TEST_F_FORK(layout1, unhandled_access)
         | ^~~~~~~~~~~
   fs_test.c: In function 'layout1_ruleset_overlap':
>> common.h:52:40: error: 'struct __test_metadata' has no member named 'step'
      52 |                         _exit(_metadata->step); \
         |                                        ^~
   fs_test.c:898:1: note: in expansion of macro 'TEST_F_FORK'
     898 | TEST_F_FORK(layout1, ruleset_overlap)
         | ^~~~~~~~~~~
   common.h:58:34: error: 'struct __test_metadata' has no member named 'step'
      58 |                         _metadata->step = 1; \
         |                                  ^~
   fs_test.c:898:1: note: in expansion of macro 'TEST_F_FORK'
     898 | TEST_F_FORK(layout1, ruleset_overlap)
         | ^~~~~~~~~~~
   common.h:71:34: error: 'struct __test_metadata' has no member named 'step'
      71 |                         _metadata->step = WEXITSTATUS(status); \
         |                                  ^~
   fs_test.c:898:1: note: in expansion of macro 'TEST_F_FORK'
     898 | TEST_F_FORK(layout1, ruleset_overlap)
         | ^~~~~~~~~~~
   fs_test.c: In function 'layout1_layer_rule_unions':
>> common.h:52:40: error: 'struct __test_metadata' has no member named 'step'
      52 |                         _exit(_metadata->step); \
         |                                        ^~
   fs_test.c:939:1: note: in expansion of macro 'TEST_F_FORK'
     939 | TEST_F_FORK(layout1, layer_rule_unions)
         | ^~~~~~~~~~~
   common.h:58:34: error: 'struct __test_metadata' has no member named 'step'
      58 |                         _metadata->step = 1; \
         |                                  ^~
   fs_test.c:939:1: note: in expansion of macro 'TEST_F_FORK'
     939 | TEST_F_FORK(layout1, layer_rule_unions)
         | ^~~~~~~~~~~
   common.h:71:34: error: 'struct __test_metadata' has no member named 'step'
      71 |                         _metadata->step = WEXITSTATUS(status); \
         |                                  ^~
   fs_test.c:939:1: note: in expansion of macro 'TEST_F_FORK'
     939 | TEST_F_FORK(layout1, layer_rule_unions)
         | ^~~~~~~~~~~
   fs_test.c: In function 'layout1_non_overlapping_accesses':
>> common.h:52:40: error: 'struct __test_metadata' has no member named 'step'
      52 |                         _exit(_metadata->step); \
         |                                        ^~
   fs_test.c:1046:1: note: in expansion of macro 'TEST_F_FORK'
    1046 | TEST_F_FORK(layout1, non_overlapping_accesses)
         | ^~~~~~~~~~~
   common.h:58:34: error: 'struct __test_metadata' has no member named 'step'
      58 |                         _metadata->step = 1; \
         |                                  ^~
   fs_test.c:1046:1: note: in expansion of macro 'TEST_F_FORK'
    1046 | TEST_F_FORK(layout1, non_overlapping_accesses)
         | ^~~~~~~~~~~
   common.h:71:34: error: 'struct __test_metadata' has no member named 'step'
      71 |                         _metadata->step = WEXITSTATUS(status); \
         |                                  ^~
   fs_test.c:1046:1: note: in expansion of macro 'TEST_F_FORK'
    1046 | TEST_F_FORK(layout1, non_overlapping_accesses)
         | ^~~~~~~~~~~
   fs_test.c: In function 'layout1_interleaved_masked_accesses':
>> common.h:52:40: error: 'struct __test_metadata' has no member named 'step'
      52 |                         _exit(_metadata->step); \
         |                                        ^~
   fs_test.c:1095:1: note: in expansion of macro 'TEST_F_FORK'
    1095 | TEST_F_FORK(layout1, interleaved_masked_accesses)
         | ^~~~~~~~~~~
   common.h:58:34: error: 'struct __test_metadata' has no member named 'step'
      58 |                         _metadata->step = 1; \
         |                                  ^~
   fs_test.c:1095:1: note: in expansion of macro 'TEST_F_FORK'
    1095 | TEST_F_FORK(layout1, interleaved_masked_accesses)
         | ^~~~~~~~~~~
   common.h:71:34: error: 'struct __test_metadata' has no member named 'step'
      71 |                         _metadata->step = WEXITSTATUS(status); \
         |                                  ^~
   fs_test.c:1095:1: note: in expansion of macro 'TEST_F_FORK'
    1095 | TEST_F_FORK(layout1, interleaved_masked_accesses)
         | ^~~~~~~~~~~
   fs_test.c: In function 'layout1_inherit_subset':
>> common.h:52:40: error: 'struct __test_metadata' has no member named 'step'
      52 |                         _exit(_metadata->step); \
         |                                        ^~
   fs_test.c:1280:1: note: in expansion of macro 'TEST_F_FORK'
    1280 | TEST_F_FORK(layout1, inherit_subset)
         | ^~~~~~~~~~~
   common.h:58:34: error: 'struct __test_metadata' has no member named 'step'
      58 |                         _metadata->step = 1; \
         |                                  ^~
   fs_test.c:1280:1: note: in expansion of macro 'TEST_F_FORK'
    1280 | TEST_F_FORK(layout1, inherit_subset)
         | ^~~~~~~~~~~
   common.h:71:34: error: 'struct __test_metadata' has no member named 'step'
      71 |                         _metadata->step = WEXITSTATUS(status); \
         |                                  ^~
   fs_test.c:1280:1: note: in expansion of macro 'TEST_F_FORK'
    1280 | TEST_F_FORK(layout1, inherit_subset)
         | ^~~~~~~~~~~
   fs_test.c: In function 'layout1_inherit_superset':
>> common.h:52:40: error: 'struct __test_metadata' has no member named 'step'
      52 |                         _exit(_metadata->step); \
         |                                        ^~
   fs_test.c:1397:1: note: in expansion of macro 'TEST_F_FORK'
    1397 | TEST_F_FORK(layout1, inherit_superset)
         | ^~~~~~~~~~~
   common.h:58:34: error: 'struct __test_metadata' has no member named 'step'
      58 |                         _metadata->step = 1; \
         |                                  ^~
   fs_test.c:1397:1: note: in expansion of macro 'TEST_F_FORK'
    1397 | TEST_F_FORK(layout1, inherit_superset)
         | ^~~~~~~~~~~
   common.h:71:34: error: 'struct __test_metadata' has no member named 'step'
      71 |                         _metadata->step = WEXITSTATUS(status); \
         |                                  ^~
   fs_test.c:1397:1: note: in expansion of macro 'TEST_F_FORK'
    1397 | TEST_F_FORK(layout1, inherit_superset)
         | ^~~~~~~~~~~
   fs_test.c: In function 'layout0_max_layers':
>> common.h:52:40: error: 'struct __test_metadata' has no member named 'step'
      52 |                         _exit(_metadata->step); \
         |                                        ^~
   fs_test.c:1434:1: note: in expansion of macro 'TEST_F_FORK'
    1434 | TEST_F_FORK(layout0, max_layers)
         | ^~~~~~~~~~~
   common.h:58:34: error: 'struct __test_metadata' has no member named 'step'
      58 |                         _metadata->step = 1; \
         |                                  ^~
   fs_test.c:1434:1: note: in expansion of macro 'TEST_F_FORK'
    1434 | TEST_F_FORK(layout0, max_layers)
         | ^~~~~~~~~~~
   common.h:71:34: error: 'struct __test_metadata' has no member named 'step'
      71 |                         _metadata->step = WEXITSTATUS(status); \
         |                                  ^~
   fs_test.c:1434:1: note: in expansion of macro 'TEST_F_FORK'
    1434 | TEST_F_FORK(layout0, max_layers)
         | ^~~~~~~~~~~
   fs_test.c: In function 'layout1_empty_or_same_ruleset':
>> common.h:52:40: error: 'struct __test_metadata' has no member named 'step'
      52 |                         _exit(_metadata->step); \
         |                                        ^~
   fs_test.c:1458:1: note: in expansion of macro 'TEST_F_FORK'
    1458 | TEST_F_FORK(layout1, empty_or_same_ruleset)
         | ^~~~~~~~~~~
   common.h:58:34: error: 'struct __test_metadata' has no member named 'step'
      58 |                         _metadata->step = 1; \
         |                                  ^~
   fs_test.c:1458:1: note: in expansion of macro 'TEST_F_FORK'
    1458 | TEST_F_FORK(layout1, empty_or_same_ruleset)
         | ^~~~~~~~~~~
   common.h:71:34: error: 'struct __test_metadata' has no member named 'step'
      71 |                         _metadata->step = WEXITSTATUS(status); \
         |                                  ^~
   fs_test.c:1458:1: note: in expansion of macro 'TEST_F_FORK'
    1458 | TEST_F_FORK(layout1, empty_or_same_ruleset)
         | ^~~~~~~~~~~
   fs_test.c: In function 'layout1_rule_on_mountpoint':
>> common.h:52:40: error: 'struct __test_metadata' has no member named 'step'
      52 |                         _exit(_metadata->step); \
         |                                        ^~
   fs_test.c:1492:1: note: in expansion of macro 'TEST_F_FORK'
    1492 | TEST_F_FORK(layout1, rule_on_mountpoint)
         | ^~~~~~~~~~~
   common.h:58:34: error: 'struct __test_metadata' has no member named 'step'
      58 |                         _metadata->step = 1; \
         |                                  ^~
   fs_test.c:1492:1: note: in expansion of macro 'TEST_F_FORK'
    1492 | TEST_F_FORK(layout1, rule_on_mountpoint)
         | ^~~~~~~~~~~
   common.h:71:34: error: 'struct __test_metadata' has no member named 'step'
      71 |                         _metadata->step = WEXITSTATUS(status); \
         |                                  ^~
   fs_test.c:1492:1: note: in expansion of macro 'TEST_F_FORK'
    1492 | TEST_F_FORK(layout1, rule_on_mountpoint)
         | ^~~~~~~~~~~
   fs_test.c: In function 'layout1_rule_over_mountpoint':
>> common.h:52:40: error: 'struct __test_metadata' has no member named 'step'
      52 |                         _exit(_metadata->step); \
         |                                        ^~
   fs_test.c:1521:1: note: in expansion of macro 'TEST_F_FORK'
    1521 | TEST_F_FORK(layout1, rule_over_mountpoint)
         | ^~~~~~~~~~~
   common.h:58:34: error: 'struct __test_metadata' has no member named 'step'
      58 |                         _metadata->step = 1; \
         |                                  ^~
   fs_test.c:1521:1: note: in expansion of macro 'TEST_F_FORK'
    1521 | TEST_F_FORK(layout1, rule_over_mountpoint)
         | ^~~~~~~~~~~
   common.h:71:34: error: 'struct __test_metadata' has no member named 'step'
      71 |                         _metadata->step = WEXITSTATUS(status); \
         |                                  ^~
   fs_test.c:1521:1: note: in expansion of macro 'TEST_F_FORK'
    1521 | TEST_F_FORK(layout1, rule_over_mountpoint)
         | ^~~~~~~~~~~
   fs_test.c: In function 'layout1_rule_over_root_allow_then_deny':
   common.h:52:40: error: 'struct __test_metadata' has no member named 'step'
      52 |                         _exit(_metadata->step); \
         |                                        ^~
   fs_test.c:1554:1: note: in expansion of macro 'TEST_F_FORK'
    1554 | TEST_F_FORK(layout1, rule_over_root_allow_then_deny)
         | ^~~~~~~~~~~
   common.h:58:34: error: 'struct __test_metadata' has no member named 'step'
      58 |                         _metadata->step = 1; \
         |                                  ^~
   fs_test.c:1554:1: note: in expansion of macro 'TEST_F_FORK'
    1554 | TEST_F_FORK(layout1, rule_over_root_allow_then_deny)
         | ^~~~~~~~~~~
   common.h:71:34: error: 'struct __test_metadata' has no member named 'step'
      71 |                         _metadata->step = WEXITSTATUS(status); \
         |                                  ^~
   fs_test.c:1554:1: note: in expansion of macro 'TEST_F_FORK'
    1554 | TEST_F_FORK(layout1, rule_over_root_allow_then_deny)
         | ^~~~~~~~~~~
   fs_test.c: In function 'layout1_rule_over_root_deny':
   common.h:52:40: error: 'struct __test_metadata' has no member named 'step'
      52 |                         _exit(_metadata->step); \
         |                                        ^~
   fs_test.c:1584:1: note: in expansion of macro 'TEST_F_FORK'
    1584 | TEST_F_FORK(layout1, rule_over_root_deny)
         | ^~~~~~~~~~~
   common.h:58:34: error: 'struct __test_metadata' has no member named 'step'
      58 |                         _metadata->step = 1; \
         |                                  ^~
   fs_test.c:1584:1: note: in expansion of macro 'TEST_F_FORK'
    1584 | TEST_F_FORK(layout1, rule_over_root_deny)
         | ^~~~~~~~~~~
   common.h:71:34: error: 'struct __test_metadata' has no member named 'step'
      71 |                         _metadata->step = WEXITSTATUS(status); \
         |                                  ^~
   fs_test.c:1584:1: note: in expansion of macro 'TEST_F_FORK'
    1584 | TEST_F_FORK(layout1, rule_over_root_deny)
         | ^~~~~~~~~~~
   fs_test.c: In function 'layout1_rule_inside_mount_ns':
   common.h:52:40: error: 'struct __test_metadata' has no member named 'step'
      52 |                         _exit(_metadata->step); \
         |                                        ^~
   fs_test.c:1604:1: note: in expansion of macro 'TEST_F_FORK'
    1604 | TEST_F_FORK(layout1, rule_inside_mount_ns)
         | ^~~~~~~~~~~
   common.h:58:34: error: 'struct __test_metadata' has no member named 'step'
      58 |                         _metadata->step = 1; \
         |                                  ^~
   fs_test.c:1604:1: note: in expansion of macro 'TEST_F_FORK'
    1604 | TEST_F_FORK(layout1, rule_inside_mount_ns)
         | ^~~~~~~~~~~
   common.h:71:34: error: 'struct __test_metadata' has no member named 'step'
      71 |                         _metadata->step = WEXITSTATUS(status); \
         |                                  ^~
   fs_test.c:1604:1: note: in expansion of macro 'TEST_F_FORK'
    1604 | TEST_F_FORK(layout1, rule_inside_mount_ns)
         | ^~~~~~~~~~~
   fs_test.c: In function 'layout1_mount_and_pivot':
   common.h:52:40: error: 'struct __test_metadata' has no member named 'step'
      52 |                         _exit(_metadata->step); \
         |                                        ^~
   fs_test.c:1632:1: note: in expansion of macro 'TEST_F_FORK'
    1632 | TEST_F_FORK(layout1, mount_and_pivot)
         | ^~~~~~~~~~~
   common.h:58:34: error: 'struct __test_metadata' has no member named 'step'
      58 |                         _metadata->step = 1; \
         |                                  ^~
   fs_test.c:1632:1: note: in expansion of macro 'TEST_F_FORK'
    1632 | TEST_F_FORK(layout1, mount_and_pivot)
         | ^~~~~~~~~~~
   common.h:71:34: error: 'struct __test_metadata' has no member named 'step'
      71 |                         _metadata->step = WEXITSTATUS(status); \
         |                                  ^~
   fs_test.c:1632:1: note: in expansion of macro 'TEST_F_FORK'
    1632 | TEST_F_FORK(layout1, mount_and_pivot)
         | ^~~~~~~~~~~
   fs_test.c: In function 'layout1_move_mount':
   common.h:52:40: error: 'struct __test_metadata' has no member named 'step'
      52 |                         _exit(_metadata->step); \
         |                                        ^~
   fs_test.c:1655:1: note: in expansion of macro 'TEST_F_FORK'
    1655 | TEST_F_FORK(layout1, move_mount)
         | ^~~~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

