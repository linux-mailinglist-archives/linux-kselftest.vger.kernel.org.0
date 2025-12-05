Return-Path: <linux-kselftest+bounces-47090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2834CA5FC3
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 04:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B753B311FBE3
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 03:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0888723BD05;
	Fri,  5 Dec 2025 03:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="holacKc5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DC41BBBE5;
	Fri,  5 Dec 2025 03:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764904680; cv=none; b=it5lPSPgDe1Rs5nW6OiDRDqht1ZgWKgqSPLcv5AvYy0UKwGHtC+MOnEXJ5fI0csF0j8qakOe6B+Fy8nxwxvZHyQOlVWMzUkcju/XapIf2/pD1Ili5fm5CElW58mEk+0z0ffUPx+zFLhbm2WPBwtvSTW98443DVTEXEkmUeC1XOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764904680; c=relaxed/simple;
	bh=+4xBKNgTCtXSfJiB4wC6hNp1lWzbSsly4sh6gavMmL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txdFwhtoNNvpvkjYUThKPWUJX6yatPsowc85NyPTqmexfYzscdGs7tTASGKEsA3SGFFJOTZXbXQ4S57iQHJsN+rxDlhvC3/Inf80Jn9pDcnobjMzrEriM/9K6Q+GvMEbqpd3kJpGa0iU3bHLqabPY/kC+Nxb1bGPgGcjRIuEVjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=holacKc5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764904679; x=1796440679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+4xBKNgTCtXSfJiB4wC6hNp1lWzbSsly4sh6gavMmL0=;
  b=holacKc5BVZ45KzTQcJo+yMjFd4lkVmiONhc/G2gIdIjq0ldJpOrpL5F
   Hv8WWIzLUuh8HUfmxUfjTY4Ju7pX+UqQFToheoWOM6jp4mlO4Be0R55ly
   7JUMYveqc5onSs5mf/FlSYfdnzfWe6S3karo41xrBE8nKzNgKtPJ2Kzew
   P2EtpoR5hyd4NTo8qVF14WsWViFgwPsFBu6AyMXrEgWF8aFK7uiCFhjWy
   +yKdD9vVVG+n7q+90EuZP8dH5j45Q9QpkGh1RUAu4qm0/ZaeOKBwjO6dW
   Lug1ZiapcFLkd6X92rO8nXnPZGbsA5pR+USvfYR9hxvWl7FjaI2gPk+ZI
   Q==;
X-CSE-ConnectionGUID: 5EhybDE0Q7yv1VdCKOep7A==
X-CSE-MsgGUID: 41J9dvBFSsuNmNL7Yfqr9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="65937732"
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="65937732"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 19:17:57 -0800
X-CSE-ConnectionGUID: offQe9NvQZG1kWd8q7zXvg==
X-CSE-MsgGUID: Je8dB3zSRDSYMmG5SoLUsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="194235851"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 04 Dec 2025 19:17:53 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vRMKM-00000000EWr-2fQB;
	Fri, 05 Dec 2025 03:17:50 +0000
Date: Fri, 5 Dec 2025 11:17:40 +0800
From: kernel test robot <lkp@intel.com>
To: Samuel Wu <wusamuel@google.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, rafael.j.wysocki@intel.com,
	Samuel Wu <wusamuel@google.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 1/4] bpf: Add wakeup_source iterator
Message-ID: <202512051019.IljjrKRb-lkp@intel.com>
References: <20251204025003.3162056-2-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204025003.3162056-2-wusamuel@google.com>

Hi Samuel,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]
[also build test ERROR on bpf/master shuah-kselftest/next shuah-kselftest/fixes linus/master v6.18 next-20251204]
[cannot apply to bpf-next/net]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Samuel-Wu/bpf-Add-wakeup_source-iterator/20251204-111108
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20251204025003.3162056-2-wusamuel%40google.com
patch subject: [PATCH v1 1/4] bpf: Add wakeup_source iterator
config: um-randconfig-r052-20251205 (https://download.01.org/0day-ci/archive/20251205/202512051019.IljjrKRb-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251205/202512051019.IljjrKRb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512051019.IljjrKRb-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   kernel/bpf/wakeup_source_iter.c: In function 'wakeup_source_iter_seq_start':
>> kernel/bpf/wakeup_source_iter.c:20:20: error: implicit declaration of function 'wakeup_sources_read_lock'; did you mean 'wakeup_source_register'? [-Werror=implicit-function-declaration]
      20 |         *srcuidx = wakeup_sources_read_lock();
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~
         |                    wakeup_source_register
>> kernel/bpf/wakeup_source_iter.c:22:14: error: implicit declaration of function 'wakeup_sources_walk_start'; did you mean 'wakeup_source_register'? [-Werror=implicit-function-declaration]
      22 |         ws = wakeup_sources_walk_start();
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~
         |              wakeup_source_register
>> kernel/bpf/wakeup_source_iter.c:22:12: warning: assignment to 'struct wakeup_source *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      22 |         ws = wakeup_sources_walk_start();
         |            ^
>> kernel/bpf/wakeup_source_iter.c:24:22: error: implicit declaration of function 'wakeup_sources_walk_next' [-Werror=implicit-function-declaration]
      24 |                 ws = wakeup_sources_walk_next(ws);
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/wakeup_source_iter.c:24:20: warning: assignment to 'struct wakeup_source *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      24 |                 ws = wakeup_sources_walk_next(ws);
         |                    ^
   kernel/bpf/wakeup_source_iter.c: In function 'wakeup_source_iter_seq_next':
>> kernel/bpf/wakeup_source_iter.c:35:16: warning: returning 'int' from a function with return type 'void *' makes pointer from integer without a cast [-Wint-conversion]
      35 |         return wakeup_sources_walk_next(ws);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/wakeup_source_iter.c: In function 'wakeup_source_iter_seq_stop':
>> kernel/bpf/wakeup_source_iter.c:43:17: error: implicit declaration of function 'wakeup_sources_read_unlock' [-Werror=implicit-function-declaration]
      43 |                 wakeup_sources_read_unlock(*srcuidx);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +20 kernel/bpf/wakeup_source_iter.c

    13	
    14	static void *wakeup_source_iter_seq_start(struct seq_file *seq, loff_t *pos)
    15	{
    16		int *srcuidx = seq->private;
    17		struct wakeup_source *ws;
    18		loff_t i;
    19	
  > 20		*srcuidx = wakeup_sources_read_lock();
    21	
  > 22		ws = wakeup_sources_walk_start();
    23		for (i = 0; ws && i < *pos; i++)
  > 24			ws = wakeup_sources_walk_next(ws);
    25	
    26		return ws;
    27	}
    28	
    29	static void *wakeup_source_iter_seq_next(struct seq_file *seq, void *v, loff_t *pos)
    30	{
    31		struct wakeup_source *ws = v;
    32	
    33		++*pos;
    34	
  > 35		return wakeup_sources_walk_next(ws);
    36	}
    37	
    38	static void wakeup_source_iter_seq_stop(struct seq_file *seq, void *v)
    39	{
    40		int *srcuidx = seq->private;
    41	
    42		if (*srcuidx >= 0)
  > 43			wakeup_sources_read_unlock(*srcuidx);
    44		*srcuidx = -1;
    45	}
    46	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

