Return-Path: <linux-kselftest+bounces-42965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D46BBCDC0C
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 17:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754DF3BA9F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 15:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CAC2F83C0;
	Fri, 10 Oct 2025 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="biFjZDeW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5552ED854;
	Fri, 10 Oct 2025 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760109057; cv=none; b=TnDyGt1rnetONbQ/75xN6qzT7EuIOajHg6Ss6ZOMVbhBL4/GTOKsf4QzVmEpLU5cs46soTPdrRmvieb1MVm0swVC5B2OepiZK5d2ZreP8JRaLpjzQmVIUycyEB2in39wi09gTJUTgBmyOmy2GPD/aJWP4Y9Db4fGXCQWWq3z3Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760109057; c=relaxed/simple;
	bh=YyE9dyVfbvRNruZ9TF5LOqw2RpOFUMC9DkGoj4Twgqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjQoCusVrsfh7mv+VRKicRctol6IGOjHWskbOWsg4iQZoCa/fOVl2kUbcSIsUNJJyjBiNRZneW0lZTDQN1hLbarXdFu3cQNNqfk2B9+iG7scWcuSMXn6UF+yTzmjDnDFxVkKj+lam0aSBnGvzlU8vpC+aSx4FlkOD9DWODa7VAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=biFjZDeW; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760109055; x=1791645055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YyE9dyVfbvRNruZ9TF5LOqw2RpOFUMC9DkGoj4Twgqw=;
  b=biFjZDeWeP82wR7pBetLjmNRV8iRwjirMCrvQbEq6bqKEPJcysDB+RPa
   gzs6tljG157IqRHZ79xr4JwGyz8/Iv4+UyWf515nmKhzaTsm4Kp0jcZqd
   NbYvv0BgDE+J7TF+kHZGeZwZDqllKzCdyx3RCynMTzwTYqLNoL5pP7jlk
   Y2ad6TZvgBSXhilLzTn7t6KlaNO0qeJARTM5HHA5n4+o8YDs1Vna6o8th
   Z5PIGFAkNQbccDgws9YXHtSSgACifv54z14Wj3MoLlxUt+jH9cJGmbdBb
   c2b4QzCFAWp7amZWLP/NnWLC6osOp08Aceb5KS9xTUn6jUtarTZSLG52p
   w==;
X-CSE-ConnectionGUID: PT0guz2qQzGe59Tr1jMT0g==
X-CSE-MsgGUID: s6dU4wUgQaGDCm7jlDz1Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="61538629"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="61538629"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 08:10:54 -0700
X-CSE-ConnectionGUID: 3oPf/LgcR/qi4aUt2Dk8ew==
X-CSE-MsgGUID: Q5JsZV33TyS12JvRu1tU3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="181425614"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 10 Oct 2025 08:10:52 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7Eld-0002t3-1z;
	Fri, 10 Oct 2025 15:10:49 +0000
Date: Fri, 10 Oct 2025 23:10:31 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Chung <seokwoo.chung130@gmail.com>, rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	mathieu.desnoyers@efficios.com, shuah@kernel.org, hca@linux.ibm.com,
	corbet@lwn.net, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, seokwoo.chung130@gmail.com
Subject: Re: [PATCH v3 3/5] tracing: fprobe: support comma-separated symbols
 and :entry/:exit
Message-ID: <202510102214.7msIkpAr-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.17]
[also build test WARNING on linus/master next-20251010]
[cannot apply to trace/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chung/docs-tracing-fprobe-document-list-filters-and-entry-exit/20251010-111713
base:   v6.17
patch link:    https://lore.kernel.org/r/20251004235001.133111-4-seokwoo.chung130%40gmail.com
patch subject: [PATCH v3 3/5] tracing: fprobe: support comma-separated symbols and :entry/:exit
config: x86_64-randconfig-073-20251010 (https://download.01.org/0day-ci/archive/20251010/202510102214.7msIkpAr-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251010/202510102214.7msIkpAr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510102214.7msIkpAr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/trace_fprobe.c:274:7: error: read-only variable is not assignable
     274 |                         *p = '\0';
         |                         ~~ ^
   kernel/trace/trace_fprobe.c:276:7: error: read-only variable is not assignable
     276 |                         *p = '\0';
         |                         ~~ ^
   kernel/trace/trace_fprobe.c:1281:24: error: use of undeclared identifier 'nofilter'; did you mean 'filter'?
    1281 |         char *filter = NULL; *nofilter = NULL;
         |                               ^~~~~~~~
         |                               filter
   kernel/trace/trace_fprobe.c:1281:8: note: 'filter' declared here
    1281 |         char *filter = NULL; *nofilter = NULL;
         |               ^
   kernel/trace/trace_fprobe.c:1284:26: error: use of undeclared identifier 'nofilter'; did you mean 'filter'?
    1284 |                         &list_mode, &filter, &nofilter);
         |                                               ^~~~~~~~
         |                                               filter
   kernel/trace/trace_fprobe.c:1281:8: note: 'filter' declared here
    1281 |         char *filter = NULL; *nofilter = NULL;
         |               ^
   kernel/trace/trace_fprobe.c:1298:11: error: use of undeclared identifier 'nofilter'; did you mean 'filter'?
    1298 |                                 kfree(nofilter);
         |                                       ^~~~~~~~
         |                                       filter
   kernel/trace/trace_fprobe.c:1281:8: note: 'filter' declared here
    1281 |         char *filter = NULL; *nofilter = NULL;
         |               ^
   kernel/trace/trace_fprobe.c:1307:8: error: use of undeclared identifier 'nofilter'; did you mean 'filter'?
    1307 |         kfree(nofilter);
         |               ^~~~~~~~
         |               filter
   kernel/trace/trace_fprobe.c:1281:8: note: 'filter' declared here
    1281 |         char *filter = NULL; *nofilter = NULL;
         |               ^
>> kernel/trace/trace_fprobe.c:1355:7: warning: unused variable 'has_wild' [-Wunused-variable]
    1355 |         bool has_wild = false;
         |              ^~~~~~~~
   1 warning and 6 errors generated.


vim +/has_wild +1355 kernel/trace/trace_fprobe.c

  1274	
  1275	static int parse_symbol_and_return(int argc, const char *argv[],
  1276					   char **symbol, bool *is_return,
  1277					   bool is_tracepoint)
  1278	{
  1279		int i, ret;
  1280		bool list_mode = false;
  1281		char *filter = NULL; *nofilter = NULL;
  1282	
  1283		ret = parse_fprobe_spec(argv[1], is_tracepoint, symbol, is_return,
  1284				&list_mode, &filter, &nofilter);
  1285		if (ret)
  1286			return ret;
  1287	
  1288		for (i = 2; i < argc; i++) {
  1289			char *tmp = strstr(argv[i], "$retval");
  1290	
  1291			if (tmp && !isalnum(tmp[7]) && tmp[7] != '_') {
  1292				if (is_tracepoint) {
  1293					trace_probe_log_set_index(i);
  1294					trace_probe_log_err(tmp - argv[i], RETVAL_ON_PROBE);
  1295					kfree(*symbol);
  1296					*symbol = NULL;
  1297					kfree(filter);
  1298					kfree(nofilter);
  1299					return -EINVAL;
  1300				}
  1301				*is_return = true;
  1302				break;
  1303			}
  1304		}
  1305	
  1306		kfree(filter);
> 1307		kfree(nofilter);
  1308		return 0;
  1309	}
  1310	
  1311	static int trace_fprobe_create_internal(int argc, const char *argv[],
  1312						struct traceprobe_parse_context *ctx)
  1313	{
  1314		/*
  1315		 * Argument syntax:
  1316		 *  - Add fentry probe:
  1317		 *      f[:[GRP/][EVENT]] [MOD:]KSYM [FETCHARGS]
  1318		 *  - Add fexit probe:
  1319		 *      f[N][:[GRP/][EVENT]] [MOD:]KSYM%return [FETCHARGS]
  1320		 *  - Add tracepoint probe:
  1321		 *      t[:[GRP/][EVENT]] TRACEPOINT [FETCHARGS]
  1322		 *
  1323		 * Fetch args:
  1324		 *  $retval	: fetch return value
  1325		 *  $stack	: fetch stack address
  1326		 *  $stackN	: fetch Nth entry of stack (N:0-)
  1327		 *  $argN	: fetch Nth argument (N:1-)
  1328		 *  $comm       : fetch current task comm
  1329		 *  @ADDR	: fetch memory at ADDR (ADDR should be in kernel)
  1330		 *  @SYM[+|-offs] : fetch memory at SYM +|- offs (SYM is a data symbol)
  1331		 * Dereferencing memory fetch:
  1332		 *  +|-offs(ARG) : fetch memory at ARG +|- offs address.
  1333		 * Alias name of args:
  1334		 *  NAME=FETCHARG : set NAME as alias of FETCHARG.
  1335		 * Type of args:
  1336		 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
  1337		 */
  1338		struct trace_fprobe *tf __free(free_trace_fprobe) = NULL;
  1339		const char *event = NULL, *group = FPROBE_EVENT_SYSTEM;
  1340		struct module *mod __free(module_put) = NULL;
  1341		const char **new_argv __free(kfree) = NULL;
  1342		char *symbol __free(kfree) = NULL;
  1343		char *ebuf __free(kfree) = NULL;
  1344		char *gbuf __free(kfree) = NULL;
  1345		char *sbuf __free(kfree) = NULL;
  1346		char *abuf __free(kfree) = NULL;
  1347		char *dbuf __free(kfree) = NULL;
  1348		int i, new_argc = 0, ret = 0;
  1349		bool is_tracepoint = false;
  1350		bool is_return = false;
  1351		bool list_mode = false;
  1352	
  1353		char *parsed_filter __free(kfree) = NULL;
  1354		char *parsed_nofilter __free(kfree) = NULL;
> 1355		bool has_wild = false;
  1356	
  1357		if ((argv[0][0] != 'f' && argv[0][0] != 't') || argc < 2)
  1358			return -ECANCELED;
  1359	
  1360		if (argv[0][0] == 't') {
  1361			is_tracepoint = true;
  1362			group = TRACEPOINT_EVENT_SYSTEM;
  1363		}
  1364	
  1365		if (argv[0][1] != '\0') {
  1366			if (argv[0][1] != ':') {
  1367				trace_probe_log_set_index(0);
  1368				trace_probe_log_err(1, BAD_MAXACT);
  1369				return -EINVAL;
  1370			}
  1371			event = &argv[0][2];
  1372		}
  1373	
  1374		trace_probe_log_set_index(1);
  1375	
  1376		/* Parse spec early (single vs list, suffix, base symbol) */
  1377		ret = parse_fprobe_spec(argv[1], is_tracepoint, &symbol, &is_return,
  1378				&list_mode, &parsed_filter, &parsed_nofilter);
  1379		if (ret < 0)
  1380			return -EINVAL;
  1381	
  1382		trace_probe_log_set_index(0);
  1383		if (event) {
  1384			gbuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
  1385			if (!gbuf)
  1386				return -ENOMEM;
  1387			ret = traceprobe_parse_event_name(&event, &group, gbuf,
  1388							  event - argv[0]);
  1389			if (ret)
  1390				return -EINVAL;
  1391		}
  1392	
  1393			if (!event) {
  1394			/*
  1395			 * Event name rules:
  1396			 * - For list/wildcard: require explicit [GROUP/]EVENT
  1397			 * - For single literal: autogenerate symbol__entry/symbol__exit
  1398			 */
  1399				if (list_mode || has_wildcard(symbol)) {
  1400					trace_probe_log_err(0, NO_GROUP_NAME);
  1401				return -EINVAL;
  1402			}
  1403			/* Make a new event name */
  1404			if (is_tracepoint)
  1405				snprintf(ebuf, MAX_EVENT_NAME_LEN, "%s%s",
  1406					 isdigit(*symbol) ? "_" : "", symbol);
  1407			else
  1408				snprintf(ebuf, MAX_EVENT_NAME_LEN, "%s__%s", symbol,
  1409					 is_return ? "exit" : "entry");
  1410			sanitize_event_name(ebuf);
  1411			event = ebuf;
  1412		}
  1413	
  1414		if (is_return)
  1415			ctx->flags |= TPARG_FL_RETURN;
  1416		else
  1417			ctx->flags |= TPARG_FL_FENTRY;
  1418	
  1419		ctx->funcname = NULL;
  1420		if (is_tracepoint) {
  1421			/* Get tracepoint and lock its module until the end of the registration. */
  1422			struct tracepoint *tpoint;
  1423	
  1424			ctx->flags |= TPARG_FL_TPOINT;
  1425			mod = NULL;
  1426			tpoint = find_tracepoint(symbol, &mod);
  1427			if (tpoint) {
  1428				sbuf = kmalloc(KSYM_NAME_LEN, GFP_KERNEL);
  1429				if (!sbuf)
  1430					return -ENOMEM;
  1431				ctx->funcname = kallsyms_lookup((unsigned long)tpoint->probestub,
  1432								NULL, NULL, NULL, sbuf);
  1433			}
  1434		}
  1435	
  1436		if (!list_mode && !has_wildcard(symbol) && !is_tracepoint)
  1437			ctx->funcname = symbol;
  1438	
  1439		abuf = kmalloc(MAX_BTF_ARGS_LEN, GFP_KERNEL);
  1440		if (!abuf)
  1441			return -ENOMEM;
  1442		argc -= 2; argv += 2;
  1443		new_argv = traceprobe_expand_meta_args(argc, argv, &new_argc,
  1444						       abuf, MAX_BTF_ARGS_LEN, ctx);
  1445		if (IS_ERR(new_argv))
  1446			return PTR_ERR(new_argv);
  1447		if (new_argv) {
  1448			argc = new_argc;
  1449			argv = new_argv;
  1450		}
  1451		if (argc > MAX_TRACE_ARGS) {
  1452			trace_probe_log_set_index(2);
  1453			trace_probe_log_err(0, TOO_MANY_ARGS);
  1454			return -E2BIG;
  1455		}
  1456	
  1457		ret = traceprobe_expand_dentry_args(argc, argv, &dbuf);
  1458		if (ret)
  1459			return ret;
  1460	
  1461		/* setup a probe */
  1462		tf = alloc_trace_fprobe(group, event, symbol, argc, is_return, is_tracepoint);
  1463		if (IS_ERR(tf)) {
  1464			ret = PTR_ERR(tf);
  1465			/* This must return -ENOMEM, else there is a bug */
  1466			WARN_ON_ONCE(ret != -ENOMEM);
  1467			return ret;
  1468		}
  1469	
  1470		/* carry list parsing result into tf */
  1471		if (!is_tracepoint) {
  1472			tf->list_mode = list_mode;
  1473				if (parsed_filter) {
  1474					tf->filter = kstrdup(parsed_filter, GFP_KERNEL);
  1475					if (!tf->filter)
  1476						return -ENOMEM;
  1477				}
  1478				if (parsed_nofilter) {
  1479					tf->nofilter = kstrdup(parsed_nofilter, GFP_KERNEL);
  1480					if (!tf->nofilter)
  1481						return -ENOMEM;
  1482				}
  1483			}
  1484	
  1485		/* parse arguments */
  1486		for (i = 0; i < argc; i++) {
  1487			trace_probe_log_set_index(i + 2);
  1488			ctx->offset = 0;
  1489			ret = traceprobe_parse_probe_arg(&tf->tp, i, argv[i], ctx);
  1490			if (ret)
  1491				return ret;	/* This can be -ENOMEM */
  1492		}
  1493	
  1494		if (is_return && tf->tp.entry_arg) {
  1495			tf->fp.entry_handler = trace_fprobe_entry_handler;
  1496			tf->fp.entry_data_size = traceprobe_get_entry_data_size(&tf->tp);
  1497			if (ALIGN(tf->fp.entry_data_size, sizeof(long)) > MAX_FPROBE_DATA_SIZE) {
  1498				trace_probe_log_set_index(2);
  1499				trace_probe_log_err(0, TOO_MANY_EARGS);
  1500				return -E2BIG;
  1501			}
  1502		}
  1503	
  1504		ret = traceprobe_set_print_fmt(&tf->tp,
  1505				is_return ? PROBE_PRINT_RETURN : PROBE_PRINT_NORMAL);
  1506		if (ret < 0)
  1507			return ret;
  1508	
  1509		ret = register_trace_fprobe_event(tf);
  1510		if (ret) {
  1511			trace_probe_log_set_index(1);
  1512			if (ret == -EILSEQ)
  1513				trace_probe_log_err(0, BAD_INSN_BNDRY);
  1514			else if (ret == -ENOENT)
  1515				trace_probe_log_err(0, BAD_PROBE_ADDR);
  1516			else if (ret != -ENOMEM && ret != -EEXIST)
  1517				trace_probe_log_err(0, FAIL_REG_PROBE);
  1518			return -EINVAL;
  1519		}
  1520	
  1521		/* 'tf' is successfully registered. To avoid freeing, assign NULL. */
  1522		tf = NULL;
  1523	
  1524		return 0;
  1525	}
  1526	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

