Return-Path: <linux-kselftest+bounces-46656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FC3C8ED95
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 15:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2393334A339
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 14:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D2D29993F;
	Thu, 27 Nov 2025 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qo3UvmQG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97F027703C;
	Thu, 27 Nov 2025 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764254994; cv=none; b=qDpUuEunN4jIYowqAjenMJXgv31671O+BA0s+7V6mi0sGYYanLtKYjB05YO2W5EkKa4lrHxw0cSXGQwbaFgDfGdiq1aZWfJAZbl56wz0cpUHFyOZvHmWeW0PmEfjSSZrXJNYtEKAjv80K63t2JYB+gzl31toc4SRr39nF8976Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764254994; c=relaxed/simple;
	bh=8rbYXMJ/hJ7cEW5zgrnHPgV0bxewRwQbEFcf01xOEvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNuNRKdKwL4Z6xX5h3HiAjXaK2P7BzNpuJ8xQxWjxwIXWf6rbiKH9bcugI6U3j6zmsLWIE3LJoHrwCeWTN0gGIF7B6hn4PuRZwhfHoGh1pECTVmjD7SMbJDGEOtJoNKhDV9YfTVPmV4pw4DQV3i43HAicQVELqIlR47F+b5zbg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qo3UvmQG; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764254992; x=1795790992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8rbYXMJ/hJ7cEW5zgrnHPgV0bxewRwQbEFcf01xOEvQ=;
  b=Qo3UvmQGu6JBr8pEd3PDZSD8/2Hcli2pb8iI2p0Cv7Ake/ZVXSr0oU/C
   RvwIT1jVFxz6IlBXyY8puQ/gSB+X5MQ8IF+3QlHGvvORNnsbMhOSHgkmd
   hb8hE6YeugyjXdCInRcHt25dS50kaWxPiprVrhcfyFy6izu8znczexDaH
   gVUatHLIFoi0oReXO/plfY1pt/hW68mZauLlxFTG1ATjFsrKZ1I74ZamO
   jlZaiC2bm9D+Ke1TP2bpkxWY8DGEZ4EL4CKwZhOLvjD+GY+Ti7JgmoG7r
   tWcoghsPJP+u5tWGcPLsHsjDxzIW/CTjwjgzHvxqtl/7Ydeeu0yZYgBFd
   A==;
X-CSE-ConnectionGUID: gCnqKw8DTui/lGlIAXp+0g==
X-CSE-MsgGUID: PlJyol6wRHCaN7zJ3epxcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="88945692"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="88945692"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 06:49:51 -0800
X-CSE-ConnectionGUID: ZvGpGi2YR/OIWJQTJ7W/XQ==
X-CSE-MsgGUID: 7iQSOpnqRZqHe8GrZYRqiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="192508889"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 27 Nov 2025 06:49:48 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOdJZ-000000004sT-2ArO;
	Thu, 27 Nov 2025 14:49:45 +0000
Date: Thu, 27 Nov 2025 22:49:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>,
	rostedt@goodmis.org, mhiramat@kernel.org, corbet@lwn.net,
	shuah@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
Subject: Re: [PATCH v4 2/3] tracing/fprobe: Support comma-separated symbols
 and :entry/:exit
Message-ID: <202511272254.BX8oUzwu-lkp@intel.com>
References: <20251126184110.72241-3-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126184110.72241-3-seokwoo.chung130@gmail.com>

Hi Seokwoo,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on linus/master v6.18-rc7 next-20251127]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Seokwoo-Chung-Ryan/docs-tracing-fprobe-Document-list-filters-and-entry-exit/20251127-024245
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20251126184110.72241-3-seokwoo.chung130%40gmail.com
patch subject: [PATCH v4 2/3] tracing/fprobe: Support comma-separated symbols and :entry/:exit
config: x86_64-randconfig-001-20251127 (https://download.01.org/0day-ci/archive/20251127/202511272254.BX8oUzwu-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251127/202511272254.BX8oUzwu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511272254.BX8oUzwu-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/trace/trace_fprobe.c:1284:1: error: function definition is not allowed here
    1284 | {
         | ^
   kernel/trace/trace_fprobe.c:1514:1: error: function definition is not allowed here
    1514 | {
         | ^
   kernel/trace/trace_fprobe.c:1531:1: error: function definition is not allowed here
    1531 | {
         | ^
   kernel/trace/trace_fprobe.c:1536:1: error: function definition is not allowed here
    1536 | {
         | ^
   kernel/trace/trace_fprobe.c:1546:1: error: function definition is not allowed here
    1546 | {
         | ^
   kernel/trace/trace_fprobe.c:1574:1: error: function definition is not allowed here
    1574 | {
         | ^
   kernel/trace/trace_fprobe.c:1610:1: error: function definition is not allowed here
    1610 | {
         | ^
   kernel/trace/trace_fprobe.c:1655:1: error: function definition is not allowed here
    1655 | {
         | ^
   kernel/trace/trace_fprobe.c:1684:1: error: function definition is not allowed here
    1684 | {
         | ^
>> kernel/trace/trace_fprobe.c:1702:15: error: use of undeclared identifier 'init_fprobe_trace_early'
    1702 | core_initcall(init_fprobe_trace_early);
         |               ^
>> kernel/trace/trace_fprobe.c:1702:15: error: use of undeclared identifier 'init_fprobe_trace_early'
>> kernel/trace/trace_fprobe.c:1702:40: error: expected '}'
    1702 | core_initcall(init_fprobe_trace_early);
         |                                        ^
   kernel/trace/trace_fprobe.c:1175:1: note: to match this '{'
    1175 | {
         | ^
   12 errors generated.


vim +1284 kernel/trace/trace_fprobe.c

08c9306fc2e32b Masami Hiramatsu (Google  2023-08-23  1281) 
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1282) static int trace_fprobe_create_internal(int argc, const char *argv[],
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1283) 					struct traceprobe_parse_context *ctx)
334e5519c37570 Masami Hiramatsu (Google  2023-06-06 @1284) {
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1285) 	/*
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1286) 	 * Argument syntax:
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1287) 	 *  - Add fentry probe:
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1288) 	 *      f[:[GRP/][EVENT]] [MOD:]KSYM [FETCHARGS]
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1289) 	 *  - Add fexit probe:
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1290) 	 *      f[N][:[GRP/][EVENT]] [MOD:]KSYM%return [FETCHARGS]
e2d0d7b2f42dca Masami Hiramatsu (Google  2023-06-06  1291) 	 *  - Add tracepoint probe:
e2d0d7b2f42dca Masami Hiramatsu (Google  2023-06-06  1292) 	 *      t[:[GRP/][EVENT]] TRACEPOINT [FETCHARGS]
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1293) 	 *
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1294) 	 * Fetch args:
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1295) 	 *  $retval	: fetch return value
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1296) 	 *  $stack	: fetch stack address
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1297) 	 *  $stackN	: fetch Nth entry of stack (N:0-)
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1298) 	 *  $argN	: fetch Nth argument (N:1-)
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1299) 	 *  $comm       : fetch current task comm
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1300) 	 *  @ADDR	: fetch memory at ADDR (ADDR should be in kernel)
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1301) 	 *  @SYM[+|-offs] : fetch memory at SYM +|- offs (SYM is a data symbol)
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1302) 	 * Dereferencing memory fetch:
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1303) 	 *  +|-offs(ARG) : fetch memory at ARG +|- offs address.
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1304) 	 * Alias name of args:
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1305) 	 *  NAME=FETCHARG : set NAME as alias of FETCHARG.
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1306) 	 * Type of args:
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1307) 	 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1308) 	 */
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1309) 	struct trace_fprobe *tf __free(free_trace_fprobe) = NULL;
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1310) 	const char *event = NULL, *group = FPROBE_EVENT_SYSTEM;
d643eaa7082dc3 Masami Hiramatsu (Google  2025-07-23  1311) 	struct module *mod __free(module_put) = NULL;
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1312) 	const char **new_argv __free(kfree) = NULL;
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1313) 	char *parsed_nofilter __free(kfree) = NULL;
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1314) 	char *parsed_filter __free(kfree) = NULL;
d643eaa7082dc3 Masami Hiramatsu (Google  2025-07-23  1315) 	char *symbol __free(kfree) = NULL;
d643eaa7082dc3 Masami Hiramatsu (Google  2025-07-23  1316) 	char *ebuf __free(kfree) = NULL;
d643eaa7082dc3 Masami Hiramatsu (Google  2025-07-23  1317) 	char *gbuf __free(kfree) = NULL;
d643eaa7082dc3 Masami Hiramatsu (Google  2025-07-23  1318) 	char *sbuf __free(kfree) = NULL;
d643eaa7082dc3 Masami Hiramatsu (Google  2025-07-23  1319) 	char *abuf __free(kfree) = NULL;
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1320) 	char *dbuf __free(kfree) = NULL;
d643eaa7082dc3 Masami Hiramatsu (Google  2025-07-23  1321) 	int i, new_argc = 0, ret = 0;
e2d0d7b2f42dca Masami Hiramatsu (Google  2023-06-06  1322) 	bool is_tracepoint = false;
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1323) 	bool list_mode = false;
d643eaa7082dc3 Masami Hiramatsu (Google  2025-07-23  1324) 	bool is_return = false;
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1325) 
e2d0d7b2f42dca Masami Hiramatsu (Google  2023-06-06  1326) 	if ((argv[0][0] != 'f' && argv[0][0] != 't') || argc < 2)
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1327) 		return -ECANCELED;
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1328) 
e2d0d7b2f42dca Masami Hiramatsu (Google  2023-06-06  1329) 	if (argv[0][0] == 't') {
e2d0d7b2f42dca Masami Hiramatsu (Google  2023-06-06  1330) 		is_tracepoint = true;
e2d0d7b2f42dca Masami Hiramatsu (Google  2023-06-06  1331) 		group = TRACEPOINT_EVENT_SYSTEM;
e2d0d7b2f42dca Masami Hiramatsu (Google  2023-06-06  1332) 	}
e2d0d7b2f42dca Masami Hiramatsu (Google  2023-06-06  1333) 
a2224559cbba1d Masami Hiramatsu (Google  2024-12-26  1334) 	if (argv[0][1] != '\0') {
a2224559cbba1d Masami Hiramatsu (Google  2024-12-26  1335) 		if (argv[0][1] != ':') {
a2224559cbba1d Masami Hiramatsu (Google  2024-12-26  1336) 			trace_probe_log_set_index(0);
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1337) 			trace_probe_log_err(1, BAD_MAXACT);
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1338) 			return -EINVAL;
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1339) 		}
a2224559cbba1d Masami Hiramatsu (Google  2024-12-26  1340) 		event = &argv[0][2];
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1341) 	}
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1342) 
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1343) 	trace_probe_log_set_index(1);
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1344) 
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1345) 	/* Parse spec early (single vs list, suffix, base symbol) */
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1346) 	ret = parse_fprobe_spec(argv[1], is_tracepoint, &symbol, &is_return,
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1347) 			&list_mode, &parsed_filter, &parsed_nofilter);
08c9306fc2e32b Masami Hiramatsu (Google  2023-08-23  1348) 	if (ret < 0)
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1349) 		return -EINVAL;
08c9306fc2e32b Masami Hiramatsu (Google  2023-08-23  1350) 
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1351) 	for (i = 2; i < argc; i++) {
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1352) 		char *tmp = strstr(argv[i], "$retval");
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1353) 
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1354) 		if (tmp && !isalnum(tmp[7]) && tmp[7] != '_') {
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1355) 			if (is_tracepoint) {
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1356) 				trace_probe_log_set_index(i);
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1357) 				trace_probe_log_err(tmp - argv[i], RETVAL_ON_PROBE);
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1358) 				return -EINVAL;
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1359) 			}
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1360) 			is_return = true;
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1361) 			break;
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1362) 		}
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1363) 	}
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1364) 
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1365) 	trace_probe_log_set_index(0);
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1366) 	if (event) {
d643eaa7082dc3 Masami Hiramatsu (Google  2025-07-23  1367) 		gbuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
d643eaa7082dc3 Masami Hiramatsu (Google  2025-07-23  1368) 		if (!gbuf)
d643eaa7082dc3 Masami Hiramatsu (Google  2025-07-23  1369) 			return -ENOMEM;
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1370) 		ret = traceprobe_parse_event_name(&event, &group, gbuf,
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1371) 						  event - argv[0]);
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1372) 		if (ret)
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1373) 			return -EINVAL;
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1374) 	}
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1375) 
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1376) 	if (!event) {
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1377) 		/*
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1378) 		 * Event name rules:
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1379) 		 * - For list/wildcard: require explicit [GROUP/]EVENT
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1380) 		 * - For single literal: autogenerate symbol__entry/symbol__exit
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1381) 		 */
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1382) 		if (list_mode || has_wildcard(symbol)) {
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1383) 			trace_probe_log_err(0, NO_GROUP_NAME);
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1384) 			return -EINVAL;
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1385) 		}
d643eaa7082dc3 Masami Hiramatsu (Google  2025-07-23  1386) 		ebuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
d643eaa7082dc3 Masami Hiramatsu (Google  2025-07-23  1387) 		if (!ebuf)
d643eaa7082dc3 Masami Hiramatsu (Google  2025-07-23  1388) 			return -ENOMEM;
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1389) 		/* Make a new event name */
e2d0d7b2f42dca Masami Hiramatsu (Google  2023-06-06  1390) 		if (is_tracepoint)
d643eaa7082dc3 Masami Hiramatsu (Google  2025-07-23  1391) 			snprintf(ebuf, MAX_EVENT_NAME_LEN, "%s%s",
b576e09701c7d0 Masami Hiramatsu (Google  2023-06-06  1392) 				 isdigit(*symbol) ? "_" : "", symbol);
e2d0d7b2f42dca Masami Hiramatsu (Google  2023-06-06  1393) 		else
d643eaa7082dc3 Masami Hiramatsu (Google  2025-07-23  1394) 			snprintf(ebuf, MAX_EVENT_NAME_LEN, "%s__%s", symbol,
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1395) 				 is_return ? "exit" : "entry");
d643eaa7082dc3 Masami Hiramatsu (Google  2025-07-23  1396) 		sanitize_event_name(ebuf);
d643eaa7082dc3 Masami Hiramatsu (Google  2025-07-23  1397) 		event = ebuf;
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1398) 	}
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1399) 
b576e09701c7d0 Masami Hiramatsu (Google  2023-06-06  1400) 	if (is_return)
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1401) 		ctx->flags |= TPARG_FL_RETURN;
b576e09701c7d0 Masami Hiramatsu (Google  2023-06-06  1402) 	else
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1403) 		ctx->flags |= TPARG_FL_FENTRY;
b576e09701c7d0 Masami Hiramatsu (Google  2023-06-06  1404) 
2867495dea8632 Masami Hiramatsu (Google  2025-04-01  1405) 	ctx->funcname = NULL;
b576e09701c7d0 Masami Hiramatsu (Google  2023-06-06  1406) 	if (is_tracepoint) {
2867495dea8632 Masami Hiramatsu (Google  2025-04-01  1407) 		/* Get tracepoint and lock its module until the end of the registration. */
2867495dea8632 Masami Hiramatsu (Google  2025-04-01  1408) 		struct tracepoint *tpoint;
2867495dea8632 Masami Hiramatsu (Google  2025-04-01  1409) 
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1410) 		ctx->flags |= TPARG_FL_TPOINT;
2867495dea8632 Masami Hiramatsu (Google  2025-04-01  1411) 		mod = NULL;
2867495dea8632 Masami Hiramatsu (Google  2025-04-01  1412) 		tpoint = find_tracepoint(symbol, &mod);
d643eaa7082dc3 Masami Hiramatsu (Google  2025-07-23  1413) 		if (tpoint) {
d643eaa7082dc3 Masami Hiramatsu (Google  2025-07-23  1414) 			sbuf = kmalloc(KSYM_NAME_LEN, GFP_KERNEL);
d643eaa7082dc3 Masami Hiramatsu (Google  2025-07-23  1415) 			if (!sbuf)
d643eaa7082dc3 Masami Hiramatsu (Google  2025-07-23  1416) 				return -ENOMEM;
2867495dea8632 Masami Hiramatsu (Google  2025-04-01  1417) 			ctx->funcname = kallsyms_lookup((unsigned long)tpoint->probestub,
2867495dea8632 Masami Hiramatsu (Google  2025-04-01  1418) 							NULL, NULL, NULL, sbuf);
b576e09701c7d0 Masami Hiramatsu (Google  2023-06-06  1419) 		}
d643eaa7082dc3 Masami Hiramatsu (Google  2025-07-23  1420) 	}
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1421) 
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1422) 	if (!list_mode && !has_wildcard(symbol) && !is_tracepoint)
e3d6e1b9a34c74 Masami Hiramatsu (Google  2025-04-01  1423) 		ctx->funcname = symbol;
b576e09701c7d0 Masami Hiramatsu (Google  2023-06-06  1424) 
d643eaa7082dc3 Masami Hiramatsu (Google  2025-07-23  1425) 	abuf = kmalloc(MAX_BTF_ARGS_LEN, GFP_KERNEL);
d643eaa7082dc3 Masami Hiramatsu (Google  2025-07-23  1426) 	if (!abuf)
d643eaa7082dc3 Masami Hiramatsu (Google  2025-07-23  1427) 		return -ENOMEM;
18b1e870a49671 Masami Hiramatsu (Google  2023-06-06  1428) 	argc -= 2; argv += 2;
18b1e870a49671 Masami Hiramatsu (Google  2023-06-06  1429) 	new_argv = traceprobe_expand_meta_args(argc, argv, &new_argc,
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1430) 					       abuf, MAX_BTF_ARGS_LEN, ctx);
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1431) 	if (IS_ERR(new_argv))
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1432) 		return PTR_ERR(new_argv);
18b1e870a49671 Masami Hiramatsu (Google  2023-06-06  1433) 	if (new_argv) {
18b1e870a49671 Masami Hiramatsu (Google  2023-06-06  1434) 		argc = new_argc;
18b1e870a49671 Masami Hiramatsu (Google  2023-06-06  1435) 		argv = new_argv;
18b1e870a49671 Masami Hiramatsu (Google  2023-06-06  1436) 	}
57faaa04804ccb Masami Hiramatsu (Google  2025-03-27  1437) 	if (argc > MAX_TRACE_ARGS) {
57faaa04804ccb Masami Hiramatsu (Google  2025-03-27  1438) 		trace_probe_log_set_index(2);
57faaa04804ccb Masami Hiramatsu (Google  2025-03-27  1439) 		trace_probe_log_err(0, TOO_MANY_ARGS);
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1440) 		return -E2BIG;
57faaa04804ccb Masami Hiramatsu (Google  2025-03-27  1441) 	}
18b1e870a49671 Masami Hiramatsu (Google  2023-06-06  1442) 
d9b15224dd8ff8 Ye Bin                    2024-03-22  1443  	ret = traceprobe_expand_dentry_args(argc, argv, &dbuf);
d9b15224dd8ff8 Ye Bin                    2024-03-22  1444  	if (ret)
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1445) 		return ret;
d9b15224dd8ff8 Ye Bin                    2024-03-22  1446  
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1447) 	/* setup a probe */
2867495dea8632 Masami Hiramatsu (Google  2025-04-01  1448) 	tf = alloc_trace_fprobe(group, event, symbol, argc, is_return, is_tracepoint);
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1449) 	if (IS_ERR(tf)) {
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1450) 		ret = PTR_ERR(tf);
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1451) 		/* This must return -ENOMEM, else there is a bug */
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1452) 		WARN_ON_ONCE(ret != -ENOMEM);
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1453) 		return ret;
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1454) 	}
e2d0d7b2f42dca Masami Hiramatsu (Google  2023-06-06  1455) 
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1456) 	/* carry list parsing result into tf */
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1457) 	if (!is_tracepoint) {
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1458) 		tf->list_mode = list_mode;
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1459) 		if (parsed_filter) {
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1460) 			tf->filter = kstrdup(parsed_filter, GFP_KERNEL);
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1461) 			if (!tf->filter)
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1462) 				return -ENOMEM;
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1463) 		}
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1464) 		if (parsed_nofilter) {
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1465) 			tf->nofilter = kstrdup(parsed_nofilter, GFP_KERNEL);
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1466) 			if (!tf->nofilter)
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1467) 				return -ENOMEM;
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1468) 		}
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1469) 	}
a90d508c939bee Seokwoo Chung (Ryan       2025-11-26  1470) 
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1471) 	/* parse arguments */
73f35080477e89 Mikel Rychliski           2024-09-30  1472  	for (i = 0; i < argc; i++) {
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1473) 		trace_probe_log_set_index(i + 2);
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1474) 		ctx->offset = 0;
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1475) 		ret = traceprobe_parse_probe_arg(&tf->tp, i, argv[i], ctx);
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1476) 		if (ret)
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1477) 			return ret;	/* This can be -ENOMEM */
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1478) 	}
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1479) 
25f00e40ce7953 Masami Hiramatsu (Google  2024-03-04  1480) 	if (is_return && tf->tp.entry_arg) {
25f00e40ce7953 Masami Hiramatsu (Google  2024-03-04  1481) 		tf->fp.entry_handler = trace_fprobe_entry_handler;
25f00e40ce7953 Masami Hiramatsu (Google  2024-03-04  1482) 		tf->fp.entry_data_size = traceprobe_get_entry_data_size(&tf->tp);
db5e228611b118 Masami Hiramatsu (Google  2025-02-26  1483) 		if (ALIGN(tf->fp.entry_data_size, sizeof(long)) > MAX_FPROBE_DATA_SIZE) {
db5e228611b118 Masami Hiramatsu (Google  2025-02-26  1484) 			trace_probe_log_set_index(2);
db5e228611b118 Masami Hiramatsu (Google  2025-02-26  1485) 			trace_probe_log_err(0, TOO_MANY_EARGS);
db5e228611b118 Masami Hiramatsu (Google  2025-02-26  1486) 			return -E2BIG;
db5e228611b118 Masami Hiramatsu (Google  2025-02-26  1487) 		}
25f00e40ce7953 Masami Hiramatsu (Google  2024-03-04  1488) 	}
25f00e40ce7953 Masami Hiramatsu (Google  2024-03-04  1489) 
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1490) 	ret = traceprobe_set_print_fmt(&tf->tp,
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1491) 			is_return ? PROBE_PRINT_RETURN : PROBE_PRINT_NORMAL);
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1492) 	if (ret < 0)
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1493) 		return ret;
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1494) 
2db832ec9090d3 Masami Hiramatsu (Google  2025-04-01  1495) 	ret = register_trace_fprobe_event(tf);
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1496) 	if (ret) {
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1497) 		trace_probe_log_set_index(1);
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1498) 		if (ret == -EILSEQ)
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1499) 			trace_probe_log_err(0, BAD_INSN_BNDRY);
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1500) 		else if (ret == -ENOENT)
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1501) 			trace_probe_log_err(0, BAD_PROBE_ADDR);
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1502) 		else if (ret != -ENOMEM && ret != -EEXIST)
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1503) 			trace_probe_log_err(0, FAIL_REG_PROBE);
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1504) 		return -EINVAL;
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1505) 	}
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1506) 
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1507) 	/* 'tf' is successfully registered. To avoid freeing, assign NULL. */
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1508) 	tf = NULL;
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1509) 
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1510) 	return 0;
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1511) }
8275637215bd3d Masami Hiramatsu (Google  2025-01-17  1512) 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

