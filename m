Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3897BF2FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 08:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442235AbjJJG2l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 02:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442233AbjJJG2k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 02:28:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A8AA7;
        Mon,  9 Oct 2023 23:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696919317; x=1728455317;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=4jE+PKSt8RyoEfQc42bJCTXndRzMaKURXbt0xZD8cHA=;
  b=fRWm2SxpLnosBO/SE0NJyS2g1faqaJo17dgO9WuVu+RINluJX6OeqDth
   Hut1LVT2osVzzPASBp8bqH+SHJkTD40mRFRfk3ABvfivDBMFKDWRWZoSR
   qcBbEd6tDEBFg6X6Iq/iLUFmKwotE4+MUqRnrJp9wVFDGHCAJbLnq6FIY
   fE0Zf20S9ILHMyq/p8q0pN14NwnRpCptcvb4iYvT24shNhWKKF3q8AC/Q
   +6GIFtDD7/u5o3lJEMLSguLxW2Os4nDF72kWjhl294iz41RDGziQoa/36
   OYAO/OBRQP1Jq4LYJ3lmUrUizyZXJTjgxIpw+Y76u/aQP7U4aCihgjeOZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="381581540"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="381581540"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 23:28:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="1084653983"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="1084653983"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 23:28:33 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 23:28:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 23:28:32 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 23:28:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6eQoX//Nz00ip86g03g32ULdqyGn3mWwN4lLKiBuiEw23ZRVUxkMK7j98LkrnyN98rmN64ufaU+gd90pWGdrTjwEZCF1f/pQ21JseVez6cPbq08WPHM2PdTy6W4mY2EK9jkkZwPopNvCYRX5kNRp8CTfYej7/MJYYqZlHFzoKD3Qv/kHYNIGrThQDLI+0FDgZLbaLiJ28iJNf753yzCHG9zDoB2SlsiN1Ce55pBstKIoNAgSjT2NFoMU2Ja5Pju+rnJi2C2KE6cp1BMsuM3ojh7aw0Crz/FHotHPRrxf/aO1sTNZzFe7QoxcyfYnGgrIcB/hic+Hmvt/v4x6Y0V0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DNeBU5DpUzh4wodAIqiulZFYv7Px5KjHzo9IL486so=;
 b=Icr2DQawK1Mw8MJnuEAW8RZZxBjWq6Dxu4ITOIVH8YPYeDJvnyQL23q597atLtSJm8M7YE/3c+ocOZGtK7yh4l5t7/8QBMcqV0IF+sBHmy2y37oLnyhsO5+GU8HTxLCSYqsa2iLdW7w83ybK8mBbs3gct/b+HfpYdRRRg2qbfUyxOmsH/DM3AeNNetqlBMbIMnZ5IN/ux8Hdg3D4OfrP96cUsHbZiUKsCUP7tU5yNXD3/mE+fUhcHVo6DLXfTGrQSHX4/bQe4cNtAOcU0JYWSjy/u/2s7vttn4COWhgvkvm6lpCcerBI2wbznWNzh7yk0ASrXlUYzgRIR/8/ve3wYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by DM6PR11MB4564.namprd11.prod.outlook.com (2603:10b6:5:2a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 06:28:30 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 06:28:29 +0000
Date:   Tue, 10 Oct 2023 08:28:25 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] selftests/resctrl: Fix schemata write error check
Message-ID: <oc3jfclnvdlg27mcmnplguho2hifz2xvl6bcowgx2oy5xgevju@g2rp3r6hrfdx>
References: <cover.1696848653.git.maciej.wieczor-retman@intel.com>
 <ef13c2395db0a688ed84f4b535b308bb6f7b71c7.1696848653.git.maciej.wieczor-retman@intel.com>
 <822a4716-4079-44d5-81d9-83c7e9bef610@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <822a4716-4079-44d5-81d9-83c7e9bef610@intel.com>
X-ClientProxiedBy: WA2P291CA0008.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::21) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|DM6PR11MB4564:EE_
X-MS-Office365-Filtering-Correlation-Id: 323fef1c-aadc-4a88-c506-08dbc95a1e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k5hYFWEPOm3+4nJASvtbPxcot3QUHZRjI/VMJbdawUX733Zk993+PjTqbKXIERY7KWEEmnfLEG85CGmsdwyJiE/J0LnBkMS7OeSm2yE+k9Od1ftJFyccMgqfEX1F3uioKbU4uzpOxruLj8j1bNScyO+zki0c9hTTZEvkQEgRPRxTJ9e1BrfcHg0YEGjZMx8pyMw7e4sm30oNrENvDYsY/6fQX6UbsvG+O3LjwbtpLpKY7yLbOzh50tnyxu0EavydsaX5Q4uxcccS08WMi9rNIW8bP6/xUo/vkElHvp7PXjsQxzHWgL6/L10pd08LZZR0BsMdfqjVCz07d64DJMatUqfvWWCK0TPrSsGCVUOtWcSoAqx8fY6SOGpL9PprszNupKLBAM3bCjtVO2REFn9s3p+TH6Vp5nYb+LLMn90KvLaAo2Nfg99ZxPnoxAycjkzvgAZmz07cz0a+tgPwrZiep8bX9WGsqF+CR08FDK8s07vDAyzw5jJI3KQQ8r42CF4JALoJutqRUQKZLv95lBFsRAjDlLzn5xxvk9GxqiE3bI4byZ74vjNvcNe/qXRWwNuK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(5660300002)(26005)(53546011)(9686003)(6666004)(8936002)(54906003)(6506007)(66574015)(6512007)(478600001)(4326008)(83380400001)(8676002)(2906002)(6862004)(66946007)(66476007)(33716001)(66556008)(6636002)(6486002)(41300700001)(316002)(38100700002)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6fT3YpxlsPl03v88lZ2pveHLGCihXF19L+x0Gmw7qboZaUchkhx3P7X1H6?=
 =?iso-8859-1?Q?MAaVs2MQ0HVnmO4Re6g9JPUmA1GrlDk6KtYDU4StNK0/v3VZH/LdSVwU3y?=
 =?iso-8859-1?Q?4wEhvEyrOIN/wF1VRgh4NtJug8FbhO9jXavq0MJoUKEAQ6xkG+Kgy+hgSe?=
 =?iso-8859-1?Q?l1mGHc9Z0LtQUPJY1wetGFK8G9g03+JON7mMy4sS/29IievprXVa4Ev1yQ?=
 =?iso-8859-1?Q?8ZOeSpgh8m9kIZNe0ivWpLY97OyuIc5oAFg6/1xx5LVLFQlaR2mpQrM+aj?=
 =?iso-8859-1?Q?b3FjRUDVexRHLyEQUiSupEJHsZdVgHLNSxNPq3oe22xhhPEjjoiPtl7ugr?=
 =?iso-8859-1?Q?2ycF6rXfG1g4oy4qlAQZtj54tYqJTvAt+u32XKK1Ma+g6JTGhDDprEDVVp?=
 =?iso-8859-1?Q?g2ix62RDrFe3JRvC+ITwV0eNvV/resYy++fqJsO8XxBk8jPdAgFe3eEvGg?=
 =?iso-8859-1?Q?Re0Eo20O1K3xz+lfvrFtPtljG+Oy0Ch6mU+WCkK83nSv9RsmWIDro/kxk2?=
 =?iso-8859-1?Q?NpN3IvPoHE6YiKXghbC/shZ71+DcGw06WwamRTssdr9em2S1kfavAGXZPN?=
 =?iso-8859-1?Q?qEQ8hpJivs0pIXdROwpUlF1cNFSgcCPwSUIcQ+8hEwUykZeyYJSEbSIFwu?=
 =?iso-8859-1?Q?4Kv15uiY8+dDLlSeRJv6g+ykAOKC0ta015mGfFw73LXmofu1N+hhbA5wqp?=
 =?iso-8859-1?Q?NKkUGGC7njZU2d+bpWab9mGW7yLxo9tgoubPSEZnn1D1Joz9dHB/WrwjoP?=
 =?iso-8859-1?Q?90jfd6LBWAAMubJVXbLK7RZnUPUuURhyHpzsMwCcCh8JZt4FMnlzqM8yeC?=
 =?iso-8859-1?Q?ekLceQYuQbC+MEulQ5pJxyn5v+t2DckzZYLQ7bH3Yf/jfkIZBeQ4dcxElw?=
 =?iso-8859-1?Q?O4RQX7qZ18e0I044Vv/1IpM3BT35nzMoO/FY+RNKidwi0GPG+Tlk8vRE0E?=
 =?iso-8859-1?Q?+7ojPV6DE1xDu4b/E1gS2K59zrugGJwK1EsbRoThzXjh369+42wtSJ0ei5?=
 =?iso-8859-1?Q?Pn3cB4tvH30sPgkdS3WjXGDoY9RkarwFaADJIw7eGer2aA5YqZSpl9UehF?=
 =?iso-8859-1?Q?k+xpycKV3XVvxO6k31PFQ8gOV1L27egIRL/Q9kN+ejyJkTzqEzvoEdi1nQ?=
 =?iso-8859-1?Q?Vq/ygZYGzB8MUdMO/Gifd3hzxgoVsKYsRU43saBxpK7XPjHc7EBW+KzJit?=
 =?iso-8859-1?Q?tqicZ1iSIaqYD7JB+AXnEA6lQ/WcR9rdOfZUTuyOh57vRpVYmGh55kkMMm?=
 =?iso-8859-1?Q?0ksA40853VixvEK3ucFzT0z3Ge6iqirLbb25nIQD9/+UJMFaHolL17a8AA?=
 =?iso-8859-1?Q?KPlBuA0Ic5bjOQzrvITbuMA6Wcmxd/D5CXxjwrC6EA2ktGo74HoJcIMTFO?=
 =?iso-8859-1?Q?A08nbC0UWIUft0aOTkNbrmXXQFtk8zy1m8ggqZLwcMD2+uSaQAsaIjEdxz?=
 =?iso-8859-1?Q?badT8GhRMyk9YUI8IBw/ZNsmV5kMov8DnMpLCTyxw918I678mVdobLJCfO?=
 =?iso-8859-1?Q?/6H4vHEbH1lFPstQims/UxF8zuEaZYOd/xFzrhm44tjSqEQkNjOrAz6EIL?=
 =?iso-8859-1?Q?leLfSVtihvaGHwW8nsHbsA4dCU8WqZSh/UTYR6DLS4mUDs4aBTbaK1u1xi?=
 =?iso-8859-1?Q?mjdQV2zaOBfTdRNTGSk3LIdN4JBLeFPSYRGR9OxQRpKlItUZ/P1521T5YJ?=
 =?iso-8859-1?Q?un0IVkvN4QjhN4jJXHs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 323fef1c-aadc-4a88-c506-08dbc95a1e6d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 06:28:29.9273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaWn4NXzVCSnEbag3fISWJNHWVKXNbDwlMi5DBvZsnR9SmBlz6wKDAGqFvlRiHhlhFKbliz3Kk7WAmzc19LlnIwOX3y23sKXbe8cARba+i0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4564
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-10-09 at 11:55:16 -0700, Reinette Chatre wrote:
>Hi Maciej,
>
>On 10/9/2023 3:57 AM, Maciej Wieczor-Retman wrote:
>> Writing bitmasks to the schemata can fail when the bitmask doesn't
>> adhere to constraints defined by what a particular CPU supports.
>> Some example of constraints are max length or having contiguous bits.
>> The driver should properly return errors when any rule concerning
>> bitmask format is broken.
>> 
>> Resctrl FS returns error codes from fprintf() only when fclose() is
>> called. Current error checking scheme allows invalid bitmasks to be
>> written into schemata file and the selftest doesn't notice because the
>> fclose() error code isn't checked.
>> 
>> Substitute fopen(), flose() and fprintf() with open(), close() and
>> write() to avoid error code buffering between fprintf() and fclose().
>> 
>> Remove newline character from the schema string after writing it to
>> the schemata file so it prints correctly before function return.
>> 
>> Pass the string generated with strerror() to the "reason" buffer so
>> the error message is more verbose. Extend "reason" buffer so it can hold
>> longer messages.
>> 
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> ---
>> Changelog v6:
>> - Align schema_len error checking with typical snprintf format.
>>   (Reinette)
>> - Initialize schema string for early return eventuality. (Reinette)
>> 
>> Changelog v5:
>> - Add Ilpo's reviewed-by tag.
>> - Fix wrong open() error checking. (Reinette)
>> - Add error checking to schema_len variable.
>> 
>> Changelog v4:
>> - Unify error checking between open() and write(). (Reinette)
>> - Add fcntl.h for glibc backward compatiblitiy. (Reinette)
>> 
>> Changelog v3:
>> - Rename fp to fd. (Ilpo)
>> - Remove strlen, strcspn and just use the snprintf value instead. (Ilpo)
>> 
>> Changelog v2:
>> - Rewrite patch message.
>> - Double "reason" buffer size to fit longer error explanation.
>> - Redo file interactions with syscalls instead of stdio functions.
>> 
>>  tools/testing/selftests/resctrl/resctrlfs.c | 36 +++++++++++++--------
>>  1 file changed, 23 insertions(+), 13 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
>> index 3a8111362d26..648f9ec8b355 100644
>> --- a/tools/testing/selftests/resctrl/resctrlfs.c
>> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
>> @@ -8,6 +8,7 @@
>>   *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
>>   *    Fenghua Yu <fenghua.yu@intel.com>
>>   */
>> +#include <fcntl.h>
>>  #include <limits.h>
>>  
>>  #include "resctrl.h"
>> @@ -490,9 +491,8 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
>>   */
>>  int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>>  {
>> -	char controlgroup[1024], schema[1024], reason[64];
>> -	int resource_id, ret = 0;
>> -	FILE *fp;
>> +	char controlgroup[1024], reason[128], schema[1024] = {};
>> +	int resource_id, fd, schema_len = -1, ret = 0;
>>  
>>  	if (strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) &&
>>  	    strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) &&
>> @@ -520,27 +520,37 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>>  
>>  	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) ||
>>  	    !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
>> -		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=', schemata);
>> +		schema_len = snprintf(schema, sizeof(schema), "%s%d%c%s\n",
>> +				      "L3:", resource_id, '=', schemata);
>>  	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) ||
>>  	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)))
>> -		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);
>> +		schema_len = snprintf(schema, sizeof(schema), "%s%d%c%s\n",
>> +				      "MB:", resource_id, '=', schemata);
>> +	if (schema_len < 0 || schema_len >= sizeof(schema)) {
>> +		snprintf(reason, sizeof(reason),
>> +			 "snprintf() failed with return value : %d", schema_len);
>> +		ret = -1;
>> +		goto out;
>> +	}
>>  
>> -	fp = fopen(controlgroup, "w");
>> -	if (!fp) {
>> -		sprintf(reason, "Failed to open control group");
>> +	fd = open(controlgroup, O_WRONLY);
>> +	if (fd < 0) {
>> +		snprintf(reason, sizeof(reason),
>> +			 "open() failed : %s", strerror(errno));
>>  		ret = -1;
>>  
>>  		goto out;
>>  	}
>> -
>> -	if (fprintf(fp, "%s\n", schema) < 0) {
>> -		sprintf(reason, "Failed to write schemata in control group");
>> -		fclose(fp);
>> +	if (write(fd, schema, schema_len) < 0) {
>> +		snprintf(reason, sizeof(reason),
>> +			 "write() failed : %s", strerror(errno));
>> +		close(fd);
>>  		ret = -1;
>>  
>>  		goto out;
>>  	}
>> -	fclose(fp);
>> +	close(fd);
>> +	schema[schema_len - 1] = 0;
>>  
>>  out:
>>  	ksft_print_msg("Write schema \"%s\" to resctrl FS%s%s\n",
>
>
>As changelog states, the newline is removed from schema to
>ensure it is printed correctly. Note that this is not done when an
>error is encountered during open() or write() so when an error is
>encountered in these places then the print does not look as intended.
>
>I think a new goto label inserted just before the newline removal
>should be sufficient, with the open() and write() error paths jumping
>to it.
>
>With that addressed:
>
>Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>
>Reinette

Thanks, I'll make the correction and resend.

-- 
Kind regards
Maciej Wieczór-Retman
