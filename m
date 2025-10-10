Return-Path: <linux-kselftest+bounces-42968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2547BCDE55
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 17:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99681882EC0
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 15:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABB026FA52;
	Fri, 10 Oct 2025 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+NAGFBW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602D6262FE7;
	Fri, 10 Oct 2025 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760111583; cv=none; b=fhOyQMo23IWNM5njXLyqks4NNy86IgZVxcRqpaUBIqtFelb3EN7+9O7xp1kwnYF+Nudct8Z+eVYIYL/ymxAfNgUXolwBhVTqHIpSejixgBT9rugxhdy66VBfZ6anjkLWmoE+MlNq3loiF9HdE1eZ7WyR7lOWgHZxkm7Mt1F7YSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760111583; c=relaxed/simple;
	bh=DD/abvJw2ItDqp3cRU9yINzo4b8UTYCdngAKkF58aDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsHZceHo2fNTeRsa5Mr8jlwLoag6WcU7+HhWzXycht8qziKYJ1u9oE1XvnAkYvk0mI9WBDYZ4FbBWoR3d220QTpWUHBxAiKfmBJ7/UsN89of6CTXFeCYfNTbtdkj0zOKS/MFV9UxhwgPcMsAd+I9aQYyA0xWvhEJMvjSFOWn89g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+NAGFBW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760111581; x=1791647581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DD/abvJw2ItDqp3cRU9yINzo4b8UTYCdngAKkF58aDY=;
  b=Q+NAGFBWwIV25qPsKPhjDSvhA/npadGEAwd9Mz10asWcLZ4+Rftqn3DW
   mUpbwMH8QCb96+R3nb2cK224azR8PI2ywQRqiBeaDXJg6ePe81ylPpD+w
   UWc+epVtd03t7vZHayDk+mpw82cXUf0Eg/sIcPqEmV2p6Axuyvn2Wv/D3
   wfm6Ik8Xw0aRaI13kZLuTbyuRkbbviv6rQqwTvOdgkPXcz6OtCYJFsh/i
   YIMYKbPOZ9DSRC70PT7LlTpr4qxG84jLbwXve66I5jIJPHvAcz3VugicM
   8MbCX0dHUIFrGJzqRlaohvpG6EFPJs3r8BcyjlY76mmgnOdK6TZ1TLPM0
   A==;
X-CSE-ConnectionGUID: QlQpxAwtSYOCUYRvMDHOPQ==
X-CSE-MsgGUID: x9AF91tQS7SDZY5aaf2C1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="65986451"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="65986451"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 08:52:58 -0700
X-CSE-ConnectionGUID: Z82LRwkHS2OR8R6OHAvESA==
X-CSE-MsgGUID: ezsRcgzBQwOn6ubOlZuqPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="186143528"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 10 Oct 2025 08:52:55 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7FQL-0002vZ-1Y;
	Fri, 10 Oct 2025 15:52:53 +0000
Date: Fri, 10 Oct 2025 23:52:52 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Chung <seokwoo.chung130@gmail.com>, rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mathieu.desnoyers@efficios.com,
	shuah@kernel.org, hca@linux.ibm.com, corbet@lwn.net,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	seokwoo.chung130@gmail.com
Subject: Re: [PATCH v3 3/5] tracing: fprobe: support comma-separated symbols
 and :entry/:exit
Message-ID: <202510102331.y36ENO9m-lkp@intel.com>
References: <20251004235001.133111-4-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251004235001.133111-4-seokwoo.chung130@gmail.com>

Hi Ryan,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.17]
[also build test ERROR on linus/master next-20251010]
[cannot apply to trace/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chung/docs-tracing-fprobe-document-list-filters-and-entry-exit/20251010-111713
base:   v6.17
patch link:    https://lore.kernel.org/r/20251004235001.133111-4-seokwoo.chung130%40gmail.com
patch subject: [PATCH v3 3/5] tracing: fprobe: support comma-separated symbols and :entry/:exit
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20251010/202510102331.y36ENO9m-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251010/202510102331.y36ENO9m-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510102331.y36ENO9m-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   kernel/trace/trace_fprobe.c: In function 'parse_fprobe_spec':
>> kernel/trace/trace_fprobe.c:274:28: error: assignment of read-only location '*p'
     274 |                         *p = '\0';
         |                            ^
   kernel/trace/trace_fprobe.c:276:28: error: assignment of read-only location '*p'
     276 |                         *p = '\0';
         |                            ^
   kernel/trace/trace_fprobe.c: In function 'parse_symbol_and_return':
>> kernel/trace/trace_fprobe.c:1281:31: error: 'nofilter' undeclared (first use in this function); did you mean 'filter'?
    1281 |         char *filter = NULL; *nofilter = NULL;
         |                               ^~~~~~~~
         |                               filter
   kernel/trace/trace_fprobe.c:1281:31: note: each undeclared identifier is reported only once for each function it appears in
   kernel/trace/trace_fprobe.c: In function 'trace_fprobe_create_internal':
   kernel/trace/trace_fprobe.c:1355:14: warning: unused variable 'has_wild' [-Wunused-variable]
    1355 |         bool has_wild = false;
         |              ^~~~~~~~
   kernel/trace/trace_fprobe.c: At top level:
>> kernel/trace/trace_fprobe.c:1275:12: warning: 'parse_symbol_and_return' defined but not used [-Wunused-function]
    1275 | static int parse_symbol_and_return(int argc, const char *argv[],
         |            ^~~~~~~~~~~~~~~~~~~~~~~


vim +274 kernel/trace/trace_fprobe.c

   233	
   234	static int parse_fprobe_spec(const char *in, bool is_tracepoint,
   235			char **base, bool *is_return, bool *list_mode,
   236			char **filter, char **nofilter)
   237	{
   238		const char *p;
   239		char *work = NULL;
   240		char *b = NULL, *f = NULL, *nf = NULL;
   241		bool legacy_ret = false;
   242		bool list = false;
   243		int ret = 0;
   244	
   245		if (!in || !base || !is_return || !list_mode || !filter || !nofilter)
   246			return -EINVAL;
   247	
   248		*base = NULL; *filter = NULL; *nofilter = NULL;
   249		*is_return = false; *list_mode = false;
   250	
   251		if (is_tracepoint) {
   252			if (strchr(in, ',') || strchr(in, ':'))
   253				return -EINVAL;
   254			if (strstr(in, "%return"))
   255				return -EINVAL;
   256			for (p = in; *p; p++)
   257				if (!isalnum(*p) && *p != '_')
   258					return -EINVAL;
   259			b = kstrdup(in, GFP_KERNEL);
   260			if (!b)
   261				return -ENOMEM;
   262			*base = b;
   263			return 0;
   264		}
   265	
   266		work = kstrdup(in, GFP_KERNEL);
   267		if (!work)
   268			return -ENOMEM;
   269	
   270		p = strstr(work, "%return");
   271		if (p) {
   272			if (!strcmp(p, ":exit")) {
   273				*is_return = true;
 > 274				*p = '\0';
   275			} else if (!strcmp(p, ":entry")) {
   276				*p = '\0';
   277			} else {
   278				ret = -EINVAL;
   279				goto out;
   280			}
   281		}
   282	
   283		list = !!strchr(work, ',') || has_wildcard(work);
   284		if (legacy_ret)
   285			*is_return = true;
   286	
   287		b = kstrdup(work, GFP_KERNEL);
   288		if (!b) {
   289			ret = -ENOMEM;
   290			goto out;
   291		}
   292	
   293		if (list) {
   294			char *tmp = b, *tok;
   295			size_t fsz = strlen(b) + 1, nfsz = strlen(b) + 1;
   296	
   297			f = kzalloc(fsz, GFP_KERNEL);
   298			nf = kzalloc(nfsz, GFP_KERNEL);
   299			if (!f || !nf) {
   300				ret = -ENOMEM;
   301				goto out;
   302			}
   303	
   304			while ((tok = strsep(&tmp, ",")) != NULL) {
   305				char *dst;
   306				bool neg = (*tok == '!');
   307	
   308				if (*tok == '\0')
   309					continue;
   310				if (neg)
   311					tok++;
   312				dst = neg ? nf : f;
   313				if (dst[0] != '\0')
   314					strcat(dst, ",");
   315				strcat(dst, tok);
   316			}
   317			*list_mode = true;
   318		}
   319	
   320		*base = b; b = NULL;
   321		*filter = f; f = NULL;
   322		*nofilter = nf; nf = NULL;
   323	
   324	out:
   325		kfree(work);
   326		kfree(b);
   327		kfree(f);
   328		kfree(nf);
   329		return ret;
   330	}
   331	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

