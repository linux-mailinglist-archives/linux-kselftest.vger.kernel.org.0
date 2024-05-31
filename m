Return-Path: <linux-kselftest+bounces-10998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A3C8D61C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 14:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531911F28058
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 12:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA19158A2E;
	Fri, 31 May 2024 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U3R8Tcdz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B65158862;
	Fri, 31 May 2024 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158639; cv=none; b=dF0BGf1SJ7YCPvlZzSsK6dLGQSobs8VvAw06pSiYf+lhrYVPpHDZnsK2LkScW5x2/V2akjTN8SN5vW1LqaZ1BVZE4ZQqsBaEMCruwXDnSLMVx28NI9LAJVvAsl/4AH5q78WijDirJocEi5sX2SjtyWcBkxuYhg+KxgDp+IW5jmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158639; c=relaxed/simple;
	bh=elMV5nlVUCpXGxL/arb3/iQCax33bq4ad5idfGKdJL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzbGuvdJ3Ozqwr+u6QnXjpxvHgV7pqYUPezO7naT74O+mjVb4ftOO6bldceelTfTUVRXoCbAga2LOtNAS4fXxBDe5b9BVku+oeBKpW7H9fjMiDWHltfP8T2qL4HuCoOqwoKBYf8Evc5Laj0TqgRHvEtK25RuHmsr8AJoN363TCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U3R8Tcdz; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717158638; x=1748694638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=elMV5nlVUCpXGxL/arb3/iQCax33bq4ad5idfGKdJL8=;
  b=U3R8TcdzJZWV8rKGKK6HC74C4JJypA+e60JfAzFF3dHyA4Vq4qtt2yuV
   26IEGpISfc4OgDVKUxqlZopJ3rTV1VtYmBznKIJT5/7b7gWWrzke8rwuz
   uv2CVIEI9ITvfpgSNWu5iZdb6kuhIeoHMnnguSJ0SlG2jh831L8/PIe0W
   RwXAlbk/Ak4A67mQ5ArU4AczWouLk6xPoI7Y1hmWGqNOH8cRMuyWkotR1
   Qd7myVd90IFnBbWj5ReL5odTSVMLTw0iyHEp1iUNaRSXuybU3NrHUdVst
   tIhjqlFybuxsxGl9Lbqg92TALJhj65sy1JSuaTzdGuP6b8zWZGMEyCaxR
   w==;
X-CSE-ConnectionGUID: 0FDGtSiYQsiM/jgrw0thZg==
X-CSE-MsgGUID: Q1q3DAzURoGm8yBpXIReJQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="39093349"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="39093349"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 05:30:28 -0700
X-CSE-ConnectionGUID: i98rGWf7SXK/HkAiegwFTA==
X-CSE-MsgGUID: 6ibuqBWfQRe899Pf5ixvdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="59321521"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 31 May 2024 05:30:25 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sD1Oo-000H4b-2B;
	Fri, 31 May 2024 12:30:22 +0000
Date: Fri, 31 May 2024 20:29:28 +0800
From: kernel test robot <lkp@intel.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jiri Kosina <jikos@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Alexei Starovoitov <ast@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH HID 03/13] HID: bpf: implement HID-BPF through
 bpf_struct_ops
Message-ID: <202405312035.U1rZN04z-lkp@intel.com>
References: <20240528-hid_bpf_struct_ops-v1-3-8c6663df27d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528-hid_bpf_struct_ops-v1-3-8c6663df27d8@kernel.org>

Hi Benjamin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 70ec81c2e2b4005465ad0d042e90b36087c36104]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Tissoires/HID-rename-struct-hid_bpf_ops-into-hid_ops/20240528-212222
base:   70ec81c2e2b4005465ad0d042e90b36087c36104
patch link:    https://lore.kernel.org/r/20240528-hid_bpf_struct_ops-v1-3-8c6663df27d8%40kernel.org
patch subject: [PATCH HID 03/13] HID: bpf: implement HID-BPF through bpf_struct_ops
config: i386-buildonly-randconfig-002-20240531 (https://download.01.org/0day-ci/archive/20240531/202405312035.U1rZN04z-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240531/202405312035.U1rZN04z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405312035.U1rZN04z-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/bpf_verifier.h:7:0,
                    from drivers/hid/bpf/hid_bpf_struct_ops.c:10:
   drivers/hid/bpf/hid_bpf_struct_ops.c: In function 'hid_bpf_struct_ops_init':
>> include/linux/bpf.h:1844:50: warning: statement with no effect [-Wunused-value]
    #define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
                                                     ^~~~~~~~~~~~~~~~
   drivers/hid/bpf/hid_bpf_struct_ops.c:244:9: note: in expansion of macro 'register_bpf_struct_ops'
     return register_bpf_struct_ops(&bpf_hid_bpf_ops, hid_bpf_ops);
            ^~~~~~~~~~~~~~~~~~~~~~~


vim +1844 include/linux/bpf.h

c196906d50e360d Hou Tao          2021-10-25  1834  
c196906d50e360d Hou Tao          2021-10-25  1835  int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
c196906d50e360d Hou Tao          2021-10-25  1836  			    union bpf_attr __user *uattr);
c196906d50e360d Hou Tao          2021-10-25  1837  #endif
f6be98d19985411 Kui-Feng Lee     2024-01-19  1838  int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
f6be98d19985411 Kui-Feng Lee     2024-01-19  1839  			     struct btf *btf,
f6be98d19985411 Kui-Feng Lee     2024-01-19  1840  			     struct bpf_verifier_log *log);
1338b93346587a2 Kui-Feng Lee     2024-01-19  1841  void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map);
1611603537a4b88 Kui-Feng Lee     2024-02-08  1842  void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc);
27ae7997a66174c Martin KaFai Lau 2020-01-08  1843  #else
f6be98d19985411 Kui-Feng Lee     2024-01-19 @1844  #define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
85d33df357b6346 Martin KaFai Lau 2020-01-08  1845  static inline bool bpf_try_module_get(const void *data, struct module *owner)
85d33df357b6346 Martin KaFai Lau 2020-01-08  1846  {
85d33df357b6346 Martin KaFai Lau 2020-01-08  1847  	return try_module_get(owner);
85d33df357b6346 Martin KaFai Lau 2020-01-08  1848  }
85d33df357b6346 Martin KaFai Lau 2020-01-08  1849  static inline void bpf_module_put(const void *data, struct module *owner)
85d33df357b6346 Martin KaFai Lau 2020-01-08  1850  {
85d33df357b6346 Martin KaFai Lau 2020-01-08  1851  	module_put(owner);
85d33df357b6346 Martin KaFai Lau 2020-01-08  1852  }
85d33df357b6346 Martin KaFai Lau 2020-01-08  1853  static inline int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map,
85d33df357b6346 Martin KaFai Lau 2020-01-08  1854  						     void *key,
85d33df357b6346 Martin KaFai Lau 2020-01-08  1855  						     void *value)
85d33df357b6346 Martin KaFai Lau 2020-01-08  1856  {
85d33df357b6346 Martin KaFai Lau 2020-01-08  1857  	return -EINVAL;
85d33df357b6346 Martin KaFai Lau 2020-01-08  1858  }
68b04864ca425d1 Kui-Feng Lee     2023-03-22  1859  static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
68b04864ca425d1 Kui-Feng Lee     2023-03-22  1860  {
68b04864ca425d1 Kui-Feng Lee     2023-03-22  1861  	return -EOPNOTSUPP;
68b04864ca425d1 Kui-Feng Lee     2023-03-22  1862  }
1338b93346587a2 Kui-Feng Lee     2024-01-19  1863  static inline void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map)
1338b93346587a2 Kui-Feng Lee     2024-01-19  1864  {
1338b93346587a2 Kui-Feng Lee     2024-01-19  1865  }
68b04864ca425d1 Kui-Feng Lee     2023-03-22  1866  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

