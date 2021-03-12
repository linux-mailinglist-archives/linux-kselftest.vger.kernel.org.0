Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32C0339732
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Mar 2021 20:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhCLTKt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Mar 2021 14:10:49 -0500
Received: from mail-bn8nam11on2072.outbound.protection.outlook.com ([40.107.236.72]:1472
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234237AbhCLTK1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Mar 2021 14:10:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iyme2wRFW1J2Z/tOIHeHM07Cg1GAQl+aX7S2dIazWoP6hjNRi1W5bhFDVLvgSAbTY9gnDPACG8XaVjDeNIG6ROQM7h3v7+PY1UTy55jKug2t65+wDTbhOCw0xDjL6gebWOsmnx0v0+Ki1/zWZHpHVp3iLger5s7IfS2ORyOd3ZPslGC1Q0XmTY7mYUu6lMDz/Us5gNYcJE97aHvC9DB4XLdDImDjelnwoCyNBi6zvwqaAv5mpEyVeZia8gJCvWKCie+7Sj/oOppbN8R68F+woWEe3RI0B4m11deaDBFa5xVd/l5A5siXZz58M1YfbD5Fw5naDcShrymd6P2R+FUuFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeQuP8ay98gUCODcX7SWWHzrIOrgpnnNz2PjmdrzjDw=;
 b=XynHbDRZ0tjI8R1g2ODfQk/pvPBRvAqYUmmVR4WgXDSuS2765kICLtJg0gXxnu2HKywChUwzfWuV0Nvsxanv8w+C9GmpGGvOmJXAN6dBjceok8tOJI4BTaUjNk9abj2/ViEWiUnPMHdIhksDz6ZqeOgpmO8qUTaJLr8wGrPtwPymSgQyyvkL2ZGW6VDZvX+AukgR0/Uo7nMqNV5YNLoY3riKmwge1LaVmonX4eIva0r2qtZ5eF9V6JbJxc0A0dLjQErzJgI7A01vGPrfORcYLMWgGsCPfvKKhEmuONuHLyUL5HzTJrGC2MXX/1jG2ad+Lefksa1l6lyMwvLZ8Ul39Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeQuP8ay98gUCODcX7SWWHzrIOrgpnnNz2PjmdrzjDw=;
 b=m6y9zgJdP4q6a0IBbacax7madcxEGVal6EO6GwCR84PzvqL0mmLGWWgVsrFboLXXJ+Hu1iUlByQxDIF/8EUGsbNFntuOUQoqHTFrPUcBDIVVwxn5XdH+qWEOoYObS3tz1M3+f7okeBtmtV1v2DkY3GkllW2FGXBs+zCNizT5ACQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN6PR12MB2672.namprd12.prod.outlook.com (2603:10b6:805:6f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Fri, 12 Mar
 2021 19:10:24 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::20cf:9ae4:26fb:47b7]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::20cf:9ae4:26fb:47b7%7]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 19:10:24 +0000
Subject: RE: [PATCH v5 07/21] selftests/resctrl: Rename CQM test as CMT test
To:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210307145502.2916364-1-fenghua.yu@intel.com>
 <20210307145502.2916364-8-fenghua.yu@intel.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <679251da-b701-7a75-bea3-ebe564bc6319@amd.com>
Date:   Fri, 12 Mar 2021 13:10:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210307145502.2916364-8-fenghua.yu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN7PR04CA0200.namprd04.prod.outlook.com
 (2603:10b6:806:126::25) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.136] (165.204.77.1) by SN7PR04CA0200.namprd04.prod.outlook.com (2603:10b6:806:126::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 19:10:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bfef8658-c2f7-40c4-e7d8-08d8e58a7c73
X-MS-TrafficTypeDiagnostic: SN6PR12MB2672:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2672574EE147029F276401AB956F9@SN6PR12MB2672.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:28;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lLKj3N1x1SMTBkt0vgzlTuXh6XrUROrGOLFtetAOw3ljMqCUMr+U4/tmNIPL/JfuhOjBTSGfSlpfmMz/66sxI41f+fV+e+NSOw6Btrpz/pheUVTbYLjVGcX003ceGgrLJ30b0w05HEWhwWL+IEkErPCLz3Z4Ee3SIxzfPyHJAormN5sAb+BzsJfcZ4ATlpmvJrCPLFwMQyqWv3wVapU9wIbk/5MFfkH7ixv/JTgOUaC/AMusok/HxgdwWtPjmvQShG/bN/ERcLRdRCYmbOE89K2MhthiAHspTsf7cyROAUP0vFEFY4XcIQnu40NlnuEdz5QpIDAmn9SKH9nep9jmOgQ2vm2hBz6amU9EK0wq06EqkRih+yKHU26NJTfpi/Vj6TYA2IiE0TzXyAl0giST7yWwoPmfqMwwzOqp8CM9j3sNV3zQHAU9LGtIrkvm4HS0kD2+q+7swd52OQxQjQfCYlBhHUsJFockOe18ISFmmqaCzYHXMtaH3q1VIPHSVJd8jYxU691mzhI6VhAgs2nls6auHj1xCzfWfRnoZ0oQGO6qVwJg+M1wunjZCJw6/F3RSNTqwkwMwelHoyTF1Ly3Ug4924Y16yOb/pUk155H7kWfPi/vNwrrf1HdZaTynZL1zeTuGxek8LAyd1CHYYOG7ucxIEOYs95mXpE7U3kZxo3Q8ltTP8tX/GvHCWfsuklt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(16526019)(186003)(478600001)(83380400001)(2906002)(26005)(86362001)(4326008)(36756003)(5660300002)(316002)(30864003)(44832011)(53546011)(52116002)(966005)(8936002)(45080400002)(16576012)(66476007)(31686004)(66556008)(31696002)(66946007)(6486002)(2616005)(956004)(54906003)(110136005)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?fq3E8UvPg9PHhjfsq+QIcXuBcf3jn714dwcY4aG26GIRowSMnaUXVHn7?=
 =?Windows-1252?Q?HNg+H18GGPRdLXSile8rj8wcEs0nzuOi933PLPVVN4kuu+c3z5lyj25D?=
 =?Windows-1252?Q?sf9TtneTOyJsZALwUPhKpkWun9bEsoYn2rMc3S8esLKbCEqA2FN6/IS7?=
 =?Windows-1252?Q?RRiu6Hv7J3mYH9RVlRo98X4w0lqG9hn7UD/RsdqP9ToAK4rIyvAfNTUS?=
 =?Windows-1252?Q?LJPGYuXkiGGz+R9fRRaNuY+vpc9OAq7gKYK9tOwNtyGyeyt1C0ChPU7n?=
 =?Windows-1252?Q?Tzt5LgjwgVHEWIGPi7fRWHlHYaBNequyfIOG9bxI5QQjmTZyryn+Gx1A?=
 =?Windows-1252?Q?ZuzL9e+ddumkiwcPffwP5EQ1oQrk2EOVNMqzjaRT7gr34ei3dS1OcvLQ?=
 =?Windows-1252?Q?RoBqxxbBmQFWobJF57Qr7kwAE9RO+oUnL32u/oNpfbe7nz583Y4lf8cT?=
 =?Windows-1252?Q?DLbwPADzkD6rB5be9S1Hjt4lVO/XmEExyma2a8baEllaXLVNkR4WSfrK?=
 =?Windows-1252?Q?RMAmZ6dEk1ekcfGe4sCjzZ2rm2VepYRBPll/h7kGhhDx75nvxidZ2Qvo?=
 =?Windows-1252?Q?nlBOldoJwPA/m1BRj3LFpsfKrtQVRYVR61cBO+38+Djlp+V80Up5Gz63?=
 =?Windows-1252?Q?PO3xBZs1tinHf0fv0Llanpt6ujcDFLhml0lc4dx10szG8XrzUyQUURB8?=
 =?Windows-1252?Q?N69RHcbUd1L5IVD2ZK6zFbjb4zx+IHNZjUsyfVtvNd0l408oPDgMpEWi?=
 =?Windows-1252?Q?9U3YBCwMZm992xbTNG+GGGDRa8rAL3I7Bsbszs+cu+UhQznFDYPjW7sl?=
 =?Windows-1252?Q?pVe/5hSQg9v3aNU/oGbXvU80VyHPFGVDQ9yErLH41Bo+56ValZzqLBDj?=
 =?Windows-1252?Q?Bo09++y5yMlaO1gMDP2V6QiQFRNIYOWj/1WQgyp3UlvyEyLvzC27G81Z?=
 =?Windows-1252?Q?2hcALyfmpCqXFrI7GvhnDNlNNd50EiflEVYIl3w1qGR/ecMjiF/fn3nE?=
 =?Windows-1252?Q?B8jDgDze41dmho403B5HO+eZL8lpfBu9XVGM4H2hAtSP9zC+DqmTEK/I?=
 =?Windows-1252?Q?vMldujxjXGB7sK1PRdUTUSAUPw1iN3TTSaqDqzSXf2PaJTfyzYxe6p8X?=
 =?Windows-1252?Q?O2mrtXhrMI892KV5JQ64s1svvLZLsn6Hc1bcVr+PMVKBsAb2qT04EpOP?=
 =?Windows-1252?Q?CJuyk4He6eMg/5v9kGExiHhB0zojIkANOeraBUi9IyDTZ3WD9oYiOuuJ?=
 =?Windows-1252?Q?N/Q5YQSFlDcaXLjj5cIuOnSj2w2F6daPSfZHWka/IMuTwE9F/5cybZLT?=
 =?Windows-1252?Q?ZBt/igF8eeJ6k9192ftK0wDkS3OAG/7wx4UnU4o2ImHuSJnUqSHDcJtQ?=
 =?Windows-1252?Q?oQdJLgnjnjT+Qq/YyaIa6RMw8S3KeqOFrUEkQzjGqy0rAqlVlgnGNMAU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfef8658-c2f7-40c4-e7d8-08d8e58a7c73
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 19:10:23.7748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8xloQh634VgdcNMSUGNVytthbmAXS21nhzJ4oxx4IXdzDv/tEVkdJLRjV5l8Or2Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2672
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: Fenghua Yu <fenghua.yu@intel.com>
> Sent: Sunday, March 7, 2021 8:55 AM
> To: Shuah Khan <shuah@kernel.org>; Tony Luck <tony.luck@intel.com>;
> Reinette Chatre <reinette.chatre@intel.com>; Moger, Babu
> <Babu.Moger@amd.com>
> Cc: linux-kselftest <linux-kselftest@vger.kernel.org>; linux-kernel <linux-
> kernel@vger.kernel.org>; Fenghua Yu <fenghua.yu@intel.com>
> Subject: [PATCH v5 07/21] selftests/resctrl: Rename CQM test as CMT test
> 
> CMT (Cache Monitoring Technology) [1] is a H/W feature that reports cache
> occupancy of a process. resctrl selftest suite has a unit test to test CMT
> for LLC but the test is named as CQM (Cache Quality Monitoring).
> Furthermore, the unit test source file is named as cqm_test.c and several
> functions, variables, comments, preprocessors and statements widely use
> "cqm" as either suffix or prefix. This rampant misusage of CQM for CMT
> might confuse someone who is newly looking at resctrl selftests because
> this feature is named CMT in the Intel Software Developer's Manual.
> 
> Hence, rename all the occurrences (unit test source file name, functions,
> variables, comments and preprocessors) of cqm with cmt.
> 
> [1] Please see Intel SDM, Volume 3, chapter 17 and section 18 for more
>     information on CMT:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsoftwar
> e.intel.com%2Fcontent%2Fwww%2Fus%2Fen%2Fdevelop%2Farticles%2Fintel-
> sdm.html&amp;data=04%7C01%7Cbabu.moger%40amd.com%7C15bb0710f06a
> 4a413ee008d8e1790293%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0
> %7C637507257137108219%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata
> =f19HKVi8hIoN4CbNYheS4bV136HCbE3INJEum4wDJqo%3D&amp;reserved=0
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  tools/testing/selftests/resctrl/README        |  4 +--
>  tools/testing/selftests/resctrl/cache.c       |  4 +--
>  .../resctrl/{cqm_test.c => cmt_test.c}        | 20 +++++++-------
>  tools/testing/selftests/resctrl/resctrl.h     |  6 ++---
>  .../testing/selftests/resctrl/resctrl_tests.c | 26 +++++++++----------
>  tools/testing/selftests/resctrl/resctrl_val.c | 12 ++++-----
>  tools/testing/selftests/resctrl/resctrlfs.c   | 10 +++----
>  7 files changed, 41 insertions(+), 41 deletions(-)
>  rename tools/testing/selftests/resctrl/{cqm_test.c => cmt_test.c} (89%)
> 
> diff --git a/tools/testing/selftests/resctrl/README
> b/tools/testing/selftests/resctrl/README
> index 6e5a0ffa18e8..4b36b25b6ac0 100644
> --- a/tools/testing/selftests/resctrl/README
> +++ b/tools/testing/selftests/resctrl/README
> @@ -46,8 +46,8 @@ ARGUMENTS
>  Parameter '-h' shows usage information.
> 
>  usage: resctrl_tests [-h] [-b "benchmark_cmd [options]"] [-t test list] [-n
> no_of_bits]
> -        -b benchmark_cmd [options]: run specified benchmark for MBM, MBA and
> CQM default benchmark is builtin fill_buf
> -        -t test list: run tests specified in the test list, e.g. -t mbm, mba, cqm, cat
> +        -b benchmark_cmd [options]: run specified benchmark for MBM, MBA and
> CMT default benchmark is builtin fill_buf
> +        -t test list: run tests specified in the test list, e.g. -t mbm, mba, cmt, cat
>          -n no_of_bits: run cache tests using specified no of bits in cache bit mask
>          -p cpu_no: specify CPU number to run the test. 1 is default
>          -h: help
> diff --git a/tools/testing/selftests/resctrl/cache.c
> b/tools/testing/selftests/resctrl/cache.c
> index 5922cc1b0386..2aa1b5c7d9e1 100644
> --- a/tools/testing/selftests/resctrl/cache.c
> +++ b/tools/testing/selftests/resctrl/cache.c
> @@ -111,7 +111,7 @@ static int get_llc_perf(unsigned long *llc_perf_miss)
> 
>  /*
>   * Get LLC Occupancy as reported by RESCTRL FS
> - * For CQM,
> + * For CMT,
>   * 1. If con_mon grp and mon grp given, then read from mon grp in
>   * con_mon grp
>   * 2. If only con_mon grp given, then read from con_mon grp
> @@ -192,7 +192,7 @@ int measure_cache_vals(struct resctrl_val_param
> *param, int bm_pid)
>  	/*
>  	 * Measure llc occupancy from resctrl.
>  	 */
> -	if (!strncmp(param->resctrl_val, CQM_STR, sizeof(CQM_STR))) {
> +	if (!strncmp(param->resctrl_val, CMT_STR, sizeof(CMT_STR))) {
>  		ret = get_llc_occu_resctrl(&llc_occu_resc);
>  		if (ret < 0)
>  			return ret;
> diff --git a/tools/testing/selftests/resctrl/cqm_test.c
> b/tools/testing/selftests/resctrl/cmt_test.c
> similarity index 89%
> rename from tools/testing/selftests/resctrl/cqm_test.c
> rename to tools/testing/selftests/resctrl/cmt_test.c
> index 271752e9ef5b..ca82db37c1f7 100644
> --- a/tools/testing/selftests/resctrl/cqm_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Cache Monitoring Technology (CQM) test
> + * Cache Monitoring Technology (CMT) test
>   *
>   * Copyright (C) 2018 Intel Corporation
>   *
> @@ -11,7 +11,7 @@
>  #include "resctrl.h"
>  #include <unistd.h>
> 
> -#define RESULT_FILE_NAME	"result_cqm"
> +#define RESULT_FILE_NAME	"result_cmt"
>  #define NUM_OF_RUNS		5
>  #define MAX_DIFF		2000000
>  #define MAX_DIFF_PERCENT	15
> @@ -21,7 +21,7 @@ static char cbm_mask[256];
>  static unsigned long long_mask;
>  static unsigned long cache_size;
> 
> -static int cqm_setup(int num, ...)
> +static int cmt_setup(int num, ...)
>  {
>  	struct resctrl_val_param *p;
>  	va_list param;
> @@ -58,7 +58,7 @@ static void show_cache_info(unsigned long
> sum_llc_occu_resc, int no_of_bits,
>  	else
>  		res = false;
> 
> -	printf("%sok CQM: diff within %d, %d\%%\n", res ? "" : "not",
> +	printf("%sok CMT: diff within %d, %d\%%\n", res ? "" : "not",
>  	       MAX_DIFF, (int)MAX_DIFF_PERCENT);
> 
>  	printf("# diff: %ld\n", avg_diff);
> @@ -106,12 +106,12 @@ static int check_results(struct resctrl_val_param
> *param, int no_of_bits)
>  	return 0;
>  }
> 
> -void cqm_test_cleanup(void)
> +void cmt_test_cleanup(void)
>  {
>  	remove(RESULT_FILE_NAME);
>  }
> 
> -int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
> +int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
>  {
>  	int ret, mum_resctrlfs;
> 
> @@ -122,7 +122,7 @@ int cqm_resctrl_val(int cpu_no, int n, char
> **benchmark_cmd)
>  	if (ret)
>  		return ret;
> 
> -	if (!validate_resctrl_feature_request("cqm"))
> +	if (!validate_resctrl_feature_request("cmt"))
>  		return -1;
> 
>  	ret = get_cbm_mask("L3", cbm_mask);
> @@ -145,7 +145,7 @@ int cqm_resctrl_val(int cpu_no, int n, char
> **benchmark_cmd)
>  	}
> 
>  	struct resctrl_val_param param = {
> -		.resctrl_val	= CQM_STR,
> +		.resctrl_val	= CMT_STR,
>  		.ctrlgrp	= "c1",
>  		.mongrp		= "m1",
>  		.cpu_no		= cpu_no,
> @@ -154,7 +154,7 @@ int cqm_resctrl_val(int cpu_no, int n, char
> **benchmark_cmd)
>  		.mask		= ~(long_mask << n) & long_mask,
>  		.span		= cache_size * n / count_of_bits,
>  		.num_of_runs	= 0,
> -		.setup		= cqm_setup,
> +		.setup		= cmt_setup,
>  	};
> 
>  	if (strcmp(benchmark_cmd[0], "fill_buf") == 0)
> @@ -170,7 +170,7 @@ int cqm_resctrl_val(int cpu_no, int n, char
> **benchmark_cmd)
>  	if (ret)
>  		return ret;
> 
> -	cqm_test_cleanup();
> +	cmt_test_cleanup();
> 
>  	return 0;
>  }
> diff --git a/tools/testing/selftests/resctrl/resctrl.h
> b/tools/testing/selftests/resctrl/resctrl.h
> index 36da6136af96..1a58767a0bd2 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -64,7 +64,7 @@ struct resctrl_val_param {
> 
>  #define MBM_STR			"mbm"
>  #define MBA_STR			"mba"
> -#define CQM_STR			"cqm"
> +#define CMT_STR			"cmt"
>  #define CAT_STR			"cat"
> 
>  extern pid_t bm_pid, ppid;
> @@ -103,9 +103,9 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
>  int cat_val(struct resctrl_val_param *param);
>  void cat_test_cleanup(void);
>  int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type);
> -int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd);
> +int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd);
>  unsigned int count_bits(unsigned long n);
> -void cqm_test_cleanup(void);
> +void cmt_test_cleanup(void);
>  int get_core_sibling(int cpu_no);
>  int measure_cache_vals(struct resctrl_val_param *param, int bm_pid);
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c
> b/tools/testing/selftests/resctrl/resctrl_tests.c
> index ac2269610aa9..01f7aed7f54e 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -37,10 +37,10 @@ void detect_amd(void)
>  static void cmd_help(void)
>  {
>  	printf("usage: resctrl_tests [-h] [-b \"benchmark_cmd [options]\"] [-t
> test list] [-n no_of_bits]\n");
> -	printf("\t-b benchmark_cmd [options]: run specified benchmark for
> MBM, MBA and CQM");
> +	printf("\t-b benchmark_cmd [options]: run specified benchmark for
> MBM, MBA and CMT");
>  	printf("\t default benchmark is builtin fill_buf\n");
>  	printf("\t-t test list: run tests specified in the test list, ");
> -	printf("e.g. -t mbm, mba, cqm, cat\n");
> +	printf("e.g. -t mbm, mba, cmt, cat\n");
>  	printf("\t-n no_of_bits: run cache tests using specified no of bits in
> cache bit mask\n");
>  	printf("\t-p cpu_no: specify CPU number to run the test. 1 is default\n");
>  	printf("\t-h: help\n");
> @@ -50,13 +50,13 @@ void tests_cleanup(void)
>  {
>  	mbm_test_cleanup();
>  	mba_test_cleanup();
> -	cqm_test_cleanup();
> +	cmt_test_cleanup();
>  	cat_test_cleanup();
>  }
> 
>  int main(int argc, char **argv)
>  {
> -	bool has_ben = false, mbm_test = true, mba_test = true, cqm_test =
> true;
> +	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test =
> true;
>  	int res, c, cpu_no = 1, span = 250, argc_new = argc, i, no_of_bits = 5;
>  	char *benchmark_cmd[BENCHMARK_ARGS], bw_report[64],
> bm_type[64];
>  	char
> benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
> @@ -82,15 +82,15 @@ int main(int argc, char **argv)
> 
>  			mbm_test = false;
>  			mba_test = false;
> -			cqm_test = false;
> +			cmt_test = false;
>  			cat_test = false;
>  			while (token) {
>  				if (!strncmp(token, MBM_STR,
> sizeof(MBM_STR))) {
>  					mbm_test = true;
>  				} else if (!strncmp(token, MBA_STR,
> sizeof(MBA_STR))) {
>  					mba_test = true;
> -				} else if (!strncmp(token, CQM_STR,
> sizeof(CQM_STR))) {
> -					cqm_test = true;
> +				} else if (!strncmp(token, CMT_STR,
> sizeof(CMT_STR))) {
> +					cmt_test = true;
>  				} else if (!strncmp(token, CAT_STR,
> sizeof(CAT_STR))) {
>  					cat_test = true;
>  				} else {
> @@ -178,13 +178,13 @@ int main(int argc, char **argv)
>  		tests_run++;
>  	}
> 
> -	if (cqm_test) {
> -		printf("# Starting CQM test ...\n");
> +	if (cmt_test) {
> +		printf("# Starting CMT test ...\n");
>  		if (!has_ben)
> -			sprintf(benchmark_cmd[5], "%s", CQM_STR);
> -		res = cqm_resctrl_val(cpu_no, no_of_bits, benchmark_cmd);
> -		printf("%sok CQM: test\n", res ? "not " : "");
> -		cqm_test_cleanup();
> +			sprintf(benchmark_cmd[5], "%s", "cmt");

Shouldn't this be sprintf(benchmark_cmd[5], "%s", CMT_STR); ?

> +		res = cmt_resctrl_val(cpu_no, no_of_bits, benchmark_cmd);
> +		printf("%sok CMT: test\n", res ? "not " : "");
> +		cmt_test_cleanup();
>  		tests_run++;
>  	}
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c
> b/tools/testing/selftests/resctrl/resctrl_val.c
> index aed71fd0713b..17770095c98e 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -492,7 +492,7 @@ static int print_results_bw(char *filename,  int bm_pid,
> float bw_imc,
>  	return 0;
>  }
> 
> -static void set_cqm_path(const char *ctrlgrp, const char *mongrp, char
> sock_num)
> +static void set_cmt_path(const char *ctrlgrp, const char *mongrp, char
> sock_num)
>  {
>  	if (strlen(ctrlgrp) && strlen(mongrp))
>  		sprintf(llc_occup_path,	CON_MON_LCC_OCCUP_PATH,
> 	RESCTRL_PATH,
> @@ -512,7 +512,7 @@ static void set_cqm_path(const char *ctrlgrp, const char
> *mongrp, char sock_num)
>   * @ctrlgrp:			Name of the control monitor group (con_mon
> grp)
>   * @mongrp:			Name of the monitor group (mon grp)
>   * @cpu_no:			CPU number that the benchmark PID is binded
> to
> - * @resctrl_val:		Resctrl feature (Eg: cat, cqm.. etc)
> + * @resctrl_val:		Resctrl feature (Eg: cat, cmt.. etc)
>   */
>  static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
>  					int cpu_no, char *resctrl_val)
> @@ -524,8 +524,8 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp,
> const char *mongrp,
>  		return;
>  	}
> 
> -	if (!strncmp(resctrl_val, CQM_STR, sizeof(CQM_STR)))
> -		set_cqm_path(ctrlgrp, mongrp, resource_id);
> +	if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
> +		set_cmt_path(ctrlgrp, mongrp, resource_id);
>  }
> 
>  static int
> @@ -682,7 +682,7 @@ int resctrl_val(char **benchmark_cmd, struct
> resctrl_val_param *param)
> 
>  		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
>  					  param->cpu_no, resctrl_val);
> -	} else if (!strncmp(resctrl_val, CQM_STR, sizeof(CQM_STR)))
> +	} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
>  		initialize_llc_occu_resctrl(param->ctrlgrp, param->mongrp,
>  					    param->cpu_no, resctrl_val);
> 
> @@ -721,7 +721,7 @@ int resctrl_val(char **benchmark_cmd, struct
> resctrl_val_param *param)
>  			ret = measure_vals(param, &bw_resc_start);
>  			if (ret)
>  				break;
> -		} else if (!strncmp(resctrl_val, CQM_STR, sizeof(CQM_STR))) {
> +		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
>  			ret = param->setup(1, param);
>  			if (ret) {
>  				ret = 0;
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c
> b/tools/testing/selftests/resctrl/resctrlfs.c
> index bc52076bee7f..b47f4f150189 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -334,7 +334,7 @@ void run_benchmark(int signum, siginfo_t *info, void
> *ucontext)
>  		operation = atoi(benchmark_cmd[4]);
>  		sprintf(resctrl_val, "%s", benchmark_cmd[5]);
> 
> -		if (strncmp(resctrl_val, CQM_STR, sizeof(CQM_STR)))
> +		if (strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
>  			buffer_span = span * MB;
>  		else
>  			buffer_span = span;
> @@ -458,8 +458,8 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp,
> char *mongrp,
>  	if (ret)
>  		goto out;
> 
> -	/* Create mon grp and write pid into it for "mbm" and "cqm" test */
> -	if (!strncmp(resctrl_val, CQM_STR, sizeof(CQM_STR)) ||
> +	/* Create mon grp and write pid into it for "mbm" and "cmt" test */
> +	if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)) ||
>  	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR))) {
>  		if (strlen(mongrp)) {
>  			sprintf(monitorgroup_p, "%s/mon_groups",
> controlgroup);
> @@ -507,7 +507,7 @@ int write_schemata(char *ctrlgrp, char *schemata, int
> cpu_no, char *resctrl_val)
> 
>  	if (strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) &&
>  	    strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) &&
> -	    strncmp(resctrl_val, CQM_STR, sizeof(CQM_STR)))
> +	    strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
>  		return -ENOENT;
> 
>  	if (!schemata) {
> @@ -529,7 +529,7 @@ int write_schemata(char *ctrlgrp, char *schemata, int
> cpu_no, char *resctrl_val)
>  		sprintf(controlgroup, "%s/schemata", RESCTRL_PATH);
> 
>  	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) ||
> -	    !strncmp(resctrl_val, CQM_STR, sizeof(CQM_STR)))
> +	    !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
>  		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=',
> schemata);
>  	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)))
>  		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=',
> schemata);
> --
> 2.30.1

