Return-Path: <linux-kselftest+bounces-47084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7482BCA572A
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 22:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A4296300C51F
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 21:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4337A2FB978;
	Thu,  4 Dec 2025 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dFgkzPaL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B11A2C1590;
	Thu,  4 Dec 2025 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764883422; cv=none; b=jKDBR+/WFqXQoqAn/e4W2aYD2HOeCNoJi5ey6kwog+20x0ihsSb92T8L5usnh/1lpEqvvI8M1lhWQjRca+V4G8Iour9CPgeRRecv2i7mlXZln0jCM5Qf4FtfQMmJWqSil8cdejYx/nk8fnAYgcQioumf7fFLvCh6+1A6FvpRwZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764883422; c=relaxed/simple;
	bh=f8zykM/Rnt7oC2pBaaK6ZmJG2g3hu+6GYv5id9tdyZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPeSEV6o/op0YJlMksJTUzstqEobTRh1gS5599ckmgPBm3yiQD1WP/2yuzLlzFXcnn8y9p1r1S5d2JGZtx0qwx+Z+c3QaqdiXmD7QejvH6ZUEe5Ly+F5sKUkJ+gxOpVyNfre1iJdv+U3Nea4I/rKPc9bkRi/CdrtwHHvaDOMMU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dFgkzPaL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764883421; x=1796419421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f8zykM/Rnt7oC2pBaaK6ZmJG2g3hu+6GYv5id9tdyZw=;
  b=dFgkzPaLAuT+R+55xMdstLgLs9lU/d4GtX3WGNsU2EySaC6z8rhaFQx3
   FmK5h4zfweNMP4KZnHXqop73NGkpVjKVWADGYy+61/CctZuiXM92GQSM4
   VZgCL50v5Wqi50dpNgDkU4AA4eHQivzFj6q8iFvLigWQSUPX+JJ9luEwC
   NMMQDd3MmJp41hqWTD71RqrFVYOIfmRgxG1leMXcCRMLf2sw3+shkQMnn
   QOi4EHN+z0dtSX2i0eXYWhgOf9vp4qNzTE767mwLvFLzASwAAotoHy7ZS
   n69+yVekds1awcb8B705OpnXty6TfpZ6w+tpeq6t0JWfgCZK+i9fxwQ6z
   w==;
X-CSE-ConnectionGUID: 0LGoSitTQ/ydlsWyginHdw==
X-CSE-MsgGUID: VHrclE1kRWyhW7c/i0S1WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="84321237"
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="84321237"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 13:23:40 -0800
X-CSE-ConnectionGUID: ST9W6LWcQlS5c84SBrxJ6w==
X-CSE-MsgGUID: jOxocdD6QjKJyvMUsHJx0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="195515697"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 04 Dec 2025 13:23:35 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vRGnU-00000000EEz-2BZK;
	Thu, 04 Dec 2025 21:23:32 +0000
Date: Fri, 5 Dec 2025 05:23:29 +0800
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
Message-ID: <202512050548.YLgRm659-lkp@intel.com>
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
config: um-randconfig-001-20251205 (https://download.01.org/0day-ci/archive/20251205/202512050548.YLgRm659-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251205/202512050548.YLgRm659-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512050548.YLgRm659-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/wakeup_source_iter.c: In function 'wakeup_source_iter_seq_start':
   kernel/bpf/wakeup_source_iter.c:20:20: error: implicit declaration of function 'wakeup_sources_read_lock'; did you mean 'wakeup_source_register'? [-Wimplicit-function-declaration]
      20 |         *srcuidx = wakeup_sources_read_lock();
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~
         |                    wakeup_source_register
   kernel/bpf/wakeup_source_iter.c:22:14: error: implicit declaration of function 'wakeup_sources_walk_start'; did you mean 'wakeup_source_register'? [-Wimplicit-function-declaration]
      22 |         ws = wakeup_sources_walk_start();
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~
         |              wakeup_source_register
>> kernel/bpf/wakeup_source_iter.c:22:12: error: assignment to 'struct wakeup_source *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      22 |         ws = wakeup_sources_walk_start();
         |            ^
   kernel/bpf/wakeup_source_iter.c:24:22: error: implicit declaration of function 'wakeup_sources_walk_next' [-Wimplicit-function-declaration]
      24 |                 ws = wakeup_sources_walk_next(ws);
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/wakeup_source_iter.c:24:20: error: assignment to 'struct wakeup_source *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      24 |                 ws = wakeup_sources_walk_next(ws);
         |                    ^
   kernel/bpf/wakeup_source_iter.c: In function 'wakeup_source_iter_seq_next':
>> kernel/bpf/wakeup_source_iter.c:35:16: error: returning 'int' from a function with return type 'void *' makes pointer from integer without a cast [-Wint-conversion]
      35 |         return wakeup_sources_walk_next(ws);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/wakeup_source_iter.c: In function 'wakeup_source_iter_seq_stop':
   kernel/bpf/wakeup_source_iter.c:43:17: error: implicit declaration of function 'wakeup_sources_read_unlock' [-Wimplicit-function-declaration]
      43 |                 wakeup_sources_read_unlock(*srcuidx);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +22 kernel/bpf/wakeup_source_iter.c

    13	
    14	static void *wakeup_source_iter_seq_start(struct seq_file *seq, loff_t *pos)
    15	{
    16		int *srcuidx = seq->private;
    17		struct wakeup_source *ws;
    18		loff_t i;
    19	
    20		*srcuidx = wakeup_sources_read_lock();
    21	
  > 22		ws = wakeup_sources_walk_start();
    23		for (i = 0; ws && i < *pos; i++)
    24			ws = wakeup_sources_walk_next(ws);
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

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

