Return-Path: <linux-kselftest+bounces-20187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E729A4AD7
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 03:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1923D1F2200A
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 01:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9734F1BDAAE;
	Sat, 19 Oct 2024 01:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VUQ9HmZn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558521BDA90;
	Sat, 19 Oct 2024 01:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729301362; cv=none; b=frI+4fROp/cuiQdTpKg5m4xSl+JL5kFP3P8Ol7XLnOHhjpODnDCIvDpx//5VsrMCv97LdwKShrVHDTmnwQjfw83FLIXpWhzTDHrVY2xrjBLu3aY8PpPHhEo/Mi/fsYFnBUGzoV3uNTzzkQIZHqRcp2k73741HhGhkHX/XA0Nqts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729301362; c=relaxed/simple;
	bh=lA6iEb80FRejSmPfv3Mb+kme2qzAtWy53GyZ6Q6GsYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0Y3f4gYCmadrGzZkr9Ddx4qh4zcWi2vkUOQG+WE2yI5sEd3K3iud9G33Abf3ov+vP/jWFkNwC0ri6dkR8hOCRvs6z1onusxXeyaQF+YTJhaHARulxFZGLnWYnkgNyhRkNHQke0ajWVg8zSEDI3NarsSK/qA1goG/Nd2r4++was=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VUQ9HmZn; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729301360; x=1760837360;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lA6iEb80FRejSmPfv3Mb+kme2qzAtWy53GyZ6Q6GsYc=;
  b=VUQ9HmZnFPMxFUqZ7WN8Z4w7G+kq27BOUbd8TlvjvzmH1m7d8EGqyclI
   U6x76r/zR38uMgce7a8r0KHqZwtnz5NaqNUaqgtlgdCywBctx4IE/+bfh
   NmAWDaaK1X8JJ/tfcI5Ri9rtK3YkUERqfIjUnNv8zd7Ld4UvzXUNM97vY
   ZXVVbM4PPz7YxWBQKnKxA4RNkjai7uVzj0Ry87Cscx0PIJbS8BN9FSwSb
   RQGXhc8v26K8cKDCiAczsRgW7jYSw6sDQsYsFWRyLC5k+DUT34ZKOi/xf
   JsNm253YuAvopqWy0askwmlHpV30OvV2l/bxPZpsesQkndXageQNtg8M1
   A==;
X-CSE-ConnectionGUID: QNlxqwWpSf2Ze7PpPSWoZA==
X-CSE-MsgGUID: LA6NBs3uToqaL15ypw/AFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28637841"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28637841"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 18:29:19 -0700
X-CSE-ConnectionGUID: y9r2LMKpTGGUVszYTrHueA==
X-CSE-MsgGUID: T/br1GwLQlqWUTTg3PRsag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="79081021"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 18 Oct 2024 18:29:15 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1yHI-000OXB-2C;
	Sat, 19 Oct 2024 01:29:12 +0000
Date: Sat, 19 Oct 2024 09:28:17 +0800
From: kernel test robot <lkp@intel.com>
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>, davem@davemloft.net,
	Liam.Howlett@oracle.com
Cc: oe-kbuild-all@lists.linux.dev, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, jiri@resnulli.us,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	akpm@linux-foundation.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, anjali.k.kulkarni@oracle.com,
	peili.io@oracle.com
Subject: Re: [PATCH net-next v5 2/3] connector/cn_proc: Kunit tests for
 threads hash table
Message-ID: <202410190945.sGeQPUMr-lkp@intel.com>
References: <20241017181436.2047508-3-anjali.k.kulkarni@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017181436.2047508-3-anjali.k.kulkarni@oracle.com>

Hi Anjali,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Anjali-Kulkarni/connector-cn_proc-Add-hash-table-for-threads/20241018-021755
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241017181436.2047508-3-anjali.k.kulkarni%40oracle.com
patch subject: [PATCH net-next v5 2/3] connector/cn_proc: Kunit tests for threads hash table
config: sparc-randconfig-001-20241019 (https://download.01.org/0day-ci/archive/20241019/202410190945.sGeQPUMr-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241019/202410190945.sGeQPUMr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410190945.sGeQPUMr-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc-linux-ld: lib/cn_hash_test.o: in function `cn_hash_test_dup_del':
>> lib/cn_hash_test.c:140:(.text+0x44): undefined reference to `cn_del_get_exval'
>> sparc-linux-ld: lib/cn_hash_test.c:143:(.text+0xb4): undefined reference to `cn_del_get_exval'
>> sparc-linux-ld: lib/cn_hash_test.c:146:(.text+0x128): undefined reference to `cn_table_empty'
   sparc-linux-ld: lib/cn_hash_test.o: in function `cn_display_htable':
>> lib/cn_hash_test.c:42:(.text+0x1f8): undefined reference to `cn_display_hlist'
   sparc-linux-ld: lib/cn_hash_test.o: in function `cn_hash_test_del_get_exval':
   lib/cn_hash_test.c:103:(.text+0x2bc): undefined reference to `cn_del_get_exval'
   sparc-linux-ld: lib/cn_hash_test.c:109:(.text+0x350): undefined reference to `cn_table_empty'
   sparc-linux-ld: lib/cn_hash_test.o: in function `cn_hash_test_dup_add':
>> lib/cn_hash_test.c:118:(.text+0x3f0): undefined reference to `cn_add_elem'
>> sparc-linux-ld: lib/cn_hash_test.c:121:(.text+0x458): undefined reference to `cn_get_exval'
>> sparc-linux-ld: lib/cn_hash_test.c:127:(.text+0x4d8): undefined reference to `cn_add_elem'
   sparc-linux-ld: lib/cn_hash_test.c:130:(.text+0x540): undefined reference to `cn_get_exval'
   sparc-linux-ld: lib/cn_hash_test.o: in function `cn_hash_test_del':
   lib/cn_hash_test.c:85:(.text+0x5d0): undefined reference to `cn_del_get_exval'
   sparc-linux-ld: lib/cn_hash_test.c:90:(.text+0x640): undefined reference to `cn_get_exval'
   sparc-linux-ld: lib/cn_hash_test.c:95:(.text+0x6cc): undefined reference to `cn_table_empty'
   sparc-linux-ld: lib/cn_hash_test.o: in function `cn_hash_test_add':
   lib/cn_hash_test.c:67:(.text+0x7b4): undefined reference to `cn_add_elem'
   sparc-linux-ld: lib/cn_hash_test.c:72:(.text+0x824): undefined reference to `cn_get_exval'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


vim +140 lib/cn_hash_test.c

    31	
    32	static void cn_display_htable(struct kunit *test, int len)
    33	{
    34		int i, err;
    35	
    36		cn_hash_init(test);
    37	
    38		pr_debug("\n");
    39		pr_debug("Displaying hash table:\n");
    40	
    41		for (i = 0; i < len; i++) {
  > 42			err = cn_display_hlist(adata[i].pid, len, &adata[i].key,
    43						key_display);
    44			key_display[adata[i].key] = 1;
    45			KUNIT_EXPECT_EQ(test, err, 0);
    46		}
    47	}
    48	
    49	static void cn_hash_test_add(struct kunit *test)
    50	{
    51		int err, i;
    52		int exit_val;
    53	
    54		adata[0].pid = 1;
    55		adata[0].exit_val = 45;
    56	
    57		adata[1].pid = 2;
    58		adata[1].exit_val = 13;
    59	
    60		adata[2].pid = 1024;
    61		adata[2].exit_val = 16;
    62	
    63		adata[3].pid = 1023;
    64		adata[3].exit_val = 71;
    65	
    66		for (i = 0; i < ARRAY_SIZE(adata); i++) {
    67			err = cn_add_elem(adata[i].exit_val, adata[i].pid);
    68			KUNIT_EXPECT_EQ_MSG(test, 0, err,
    69					"Adding pid %d returned err %d",
    70					adata[i].pid, err);
    71	
    72			exit_val = cn_get_exval(adata[i].pid);
    73			KUNIT_EXPECT_EQ(test, adata[i].exit_val, exit_val);
    74		}
    75	
    76		cn_display_htable(test, ARRAY_SIZE(adata));
    77	}
    78	
    79	static void cn_hash_test_del(struct kunit *test)
    80	{
    81		int i, err;
    82		int exit_val;
    83	
    84		for (i = 0; i < ARRAY_SIZE(adata); i++) {
    85			err = cn_del_get_exval(adata[i].pid);
    86			KUNIT_EXPECT_GT_MSG(test, err, 0,
    87					"Deleting pid %d returned err %d",
    88					adata[i].pid, err);
    89	
    90			exit_val = cn_get_exval(adata[i].pid);
    91			KUNIT_EXPECT_EQ(test, -EINVAL, exit_val);
    92		}
    93	
    94		cn_display_htable(test, ARRAY_SIZE(adata));
    95		KUNIT_EXPECT_TRUE(test, cn_table_empty());
    96	}
    97	
    98	static void cn_hash_test_del_get_exval(struct kunit *test)
    99	{
   100		int i, exval;
   101	
   102		for (i = 0; i < ARRAY_SIZE(adata); i++) {
   103			exval = cn_del_get_exval(adata[i].pid);
   104			KUNIT_EXPECT_EQ(test, adata[i].exit_val, exval);
   105	
   106			cn_display_htable(test, ARRAY_SIZE(adata));
   107		}
   108	
   109		KUNIT_EXPECT_TRUE(test, cn_table_empty());
   110	}
   111	static void cn_hash_test_dup_add(struct kunit *test)
   112	{
   113		int err, exit_val;
   114	
   115		adata[0].pid = 10;
   116		adata[0].exit_val = 21;
   117	
 > 118		err = cn_add_elem(adata[0].exit_val, adata[0].pid);
   119		KUNIT_EXPECT_EQ(test, 0, err);
   120	
 > 121		exit_val = cn_get_exval(adata[0].pid);
   122		KUNIT_EXPECT_EQ(test, 21, exit_val);
   123	
   124		adata[1].pid = 10;
   125		adata[1].exit_val = 12;
   126	
 > 127		err = cn_add_elem(adata[1].exit_val, adata[1].pid);
   128		KUNIT_EXPECT_EQ(test, -EEXIST, err);
   129	
   130		exit_val = cn_get_exval(adata[1].pid);
   131		KUNIT_EXPECT_EQ(test, 21, exit_val);
   132	
   133		cn_display_htable(test, 1);
   134	}
   135	
   136	static void cn_hash_test_dup_del(struct kunit *test)
   137	{
   138		int err;
   139	
 > 140		err = cn_del_get_exval(adata[0].pid);
   141		KUNIT_EXPECT_EQ(test, adata[0].exit_val, err);
   142	
 > 143		err = cn_del_get_exval(adata[0].pid);
   144		KUNIT_EXPECT_EQ(test, -EINVAL, err);
   145	
 > 146		KUNIT_EXPECT_TRUE(test, cn_table_empty());
   147	}
   148	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

