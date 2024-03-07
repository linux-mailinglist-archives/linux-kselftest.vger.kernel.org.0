Return-Path: <linux-kselftest+bounces-6076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6151D875AFB
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 00:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9421C210FD
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 23:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81323D965;
	Thu,  7 Mar 2024 23:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oI9wAE6N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A82F4FC;
	Thu,  7 Mar 2024 23:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709853414; cv=none; b=CURSi4s2r4fU9FLmfEDWQqnXUfjeGoPqnKz/lw0AN+HR2lmEP24Dy+pAK92Enj3v2rA7YqZlWIE4RspfmlV5dHwAAmO/OiluOzrFj73hxhmRqqaR0vCS6xm7mgPnsyCabZDEpQftH2+c3huZFMBBeSbw0DAXsYJd44k36jyM3VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709853414; c=relaxed/simple;
	bh=qxqwgxLG6VEBZ3elgEl/IvmQclrYAFW+MhoFG2pv1rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ed3U2PUm0bBsw14KnvtjP1zyR9cMRh3GOBKGLxeslJWME5aI996oPCybyDhAvwP5hgVsyUVn86ApZAhHHMxR0tJ46MvoyBeD/7kyHuujnv7WRvpx+labhoLKdjtqHEmsh2lzFRIdPMo7kYYlZxoejCWHVqOjrkWPwRVJd6Y+XYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oI9wAE6N; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709853413; x=1741389413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qxqwgxLG6VEBZ3elgEl/IvmQclrYAFW+MhoFG2pv1rY=;
  b=oI9wAE6NUxvdXM0r4ldBL8a2/88r7pqLQ1NfkCTArsvfFEIKidIZFgtR
   MDH1/v8FI8VFHEUjU5Yx6/wFf8Yy7N9qW6Smm61u3K3EHjeDF8VxxNYwn
   ylTbuAFmxAGc0sDoh4WW7o7OfUMuxZTapjq7zbnsQLxHPkU1ZH3nw+HV2
   zjxortQ7Spd42YXGlyCI4lOIXMQ3Sj5lix4i7y5oHtliSIolyeY9DvMIf
   TZt7ohlXF89QLwVdks4VaLLHX71eYYJWmrHEMHiAKoqEfZGq8HUz5IBLL
   x7cIMzHLEy+u3KvdzcoAV+dfNHH82km9hycte+liMacKS1henmFdIGXAJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4406744"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="4406744"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 15:16:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="41194085"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.105])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 15:16:51 -0800
Date: Thu, 7 Mar 2024 15:16:50 -0800
From: Tony Luck <tony.luck@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Message-ID: <ZepK4mtoV_J8-UbE@agluck-desk3>
References: <cover.1709721159.git.maciej.wieczor-retman@intel.com>
 <8a158ada92f06b97a4679721e84e787e94b94647.1709721159.git.maciej.wieczor-retman@intel.com>
 <SJ1PR11MB608310C72D7189C139EA6302FC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <o6va7b7rc3q46olsbscav7pla4hxot2g6xhctflhmf64pj5hpx@56vtbg3yyquy>
 <SJ1PR11MB60830E546B3D575B01D37104FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <159474e6-ef11-4769-a182-86483efcf2a6@intel.com>
 <SJ1PR11MB60832DAD58E864F99A16FCC4FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0393c4ce-7e41-4dcc-940a-a6bea9437970@intel.com>
 <SJ1PR11MB6083AACB10645E41DD3F9639FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <55a55960-8bb1-4ce2-a2c7-68e167da8bcc@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55a55960-8bb1-4ce2-a2c7-68e167da8bcc@intel.com>

On Thu, Mar 07, 2024 at 02:39:08PM -0800, Reinette Chatre wrote:
> Thank you for the example. I find that significantly easier to
> understand than a single number in a generic "nodes_per_l3_cache".
> Especially with potential confusion surrounding inconsistent "nodes"
> between allocation and monitoring. 
> 
> How about domain_cpu_list and domain_cpu_map ?

Reinette,

Like this (my test system doesn't have SNC, so all domains are the same):

$ cd /sys/fs/resctrl/info/
$ grep . */domain*
L3/domain_cpu_list:0: 0-35,72-107
L3/domain_cpu_list:1: 36-71,108-143
L3/domain_cpu_map:0: 0000,00000fff,ffffff00,0000000f,ffffffff
L3/domain_cpu_map:1: ffff,fffff000,000000ff,fffffff0,00000000
L3_MON/domain_cpu_list:0: 0-35,72-107
L3_MON/domain_cpu_list:1: 36-71,108-143
L3_MON/domain_cpu_map:0: 0000,00000fff,ffffff00,0000000f,ffffffff
L3_MON/domain_cpu_map:1: ffff,fffff000,000000ff,fffffff0,00000000
MB/domain_cpu_list:0: 0-35,72-107
MB/domain_cpu_list:1: 36-71,108-143
MB/domain_cpu_map:0: 0000,00000fff,ffffff00,0000000f,ffffffff
MB/domain_cpu_map:1: ffff,fffff000,000000ff,fffffff0,00000000


The patch to do this is pretty straightforward.

-Tony

---

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index ae80170a0d1b..c180b80640e3 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -957,6 +957,20 @@ static int rdt_num_closids_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int rdt_ctrl_cpus_show(struct kernfs_open_file *of,
+			      struct seq_file *seq, void *v)
+{
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
+	struct rdt_ctrl_domain *d;
+
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list)
+		seq_printf(seq, is_cpu_list(of) ? "%d: %*pbl\n" : "%d: %*pb\n",
+			   d->hdr.id, cpumask_pr_args(&d->hdr.cpu_mask));
+
+	return 0;
+}
+
 static int rdt_default_ctrl_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
@@ -1103,6 +1117,19 @@ static int rdt_num_rmids_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int rdt_mon_cpus_show(struct kernfs_open_file *of,
+			     struct seq_file *seq, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	struct rdt_mon_domain *d;
+
+	list_for_each_entry(d, &r->mon_domains, hdr.list)
+		seq_printf(seq, is_cpu_list(of) ? "%d: %*pbl\n" : "%d: %*pb\n",
+			   d->hdr.id, cpumask_pr_args(&d->hdr.cpu_mask));
+
+	return 0;
+}
+
 static int rdt_mon_features_show(struct kernfs_open_file *of,
 				 struct seq_file *seq, void *v)
 {
@@ -1810,6 +1837,21 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdt_num_closids_show,
 		.fflags		= RFTYPE_CTRL_INFO,
 	},
+	{
+		.name		= "domain_cpu_list",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdt_ctrl_cpus_show,
+		.flags		= RFTYPE_FLAGS_CPUS_LIST,
+		.fflags		= RFTYPE_CTRL_INFO,
+	},
+	{
+		.name		= "domain_cpu_map",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdt_ctrl_cpus_show,
+		.fflags		= RFTYPE_CTRL_INFO,
+	},
 	{
 		.name		= "mon_features",
 		.mode		= 0444,
@@ -1824,6 +1866,21 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdt_num_rmids_show,
 		.fflags		= RFTYPE_MON_INFO,
 	},
+	{
+		.name		= "domain_cpu_list",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdt_mon_cpus_show,
+		.flags		= RFTYPE_FLAGS_CPUS_LIST,
+		.fflags		= RFTYPE_MON_INFO,
+	},
+	{
+		.name		= "domain_cpu_map",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdt_mon_cpus_show,
+		.fflags		= RFTYPE_MON_INFO,
+	},
 	{
 		.name		= "cbm_mask",
 		.mode		= 0444,
-- 
2.43.0


