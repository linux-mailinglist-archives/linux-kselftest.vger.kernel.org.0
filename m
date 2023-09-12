Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA70079C6EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 08:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjILGdM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 02:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjILGdL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 02:33:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80670E76;
        Mon, 11 Sep 2023 23:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694500387; x=1726036387;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=4ZdPUh5fj46VTZkvVI2em1ZKi6IIcapNTY91Uv23ZYw=;
  b=JBUJY1MMIfunK5ScQE1jh45byvR4rxwgix+U0XxwReRA46aH9+t8/SEh
   IxvJW/3xTp4aT5tbdBI0y7MVRKVkXzYPfjRa+2pP1ZcPbNZBBobU9cnP/
   aeVSiuPwe919BmD1Z1FZKVbxMR+F+UopJLvK0SFfZBB2GBjgFyLzEvVIP
   SfbP1ts0Op1FMzq/hA6Lej50Rj63r7DOEzlcxw1ck4Q3UA8PoTvtNBfO3
   bTv1BialD8UVbwoYW9fcem0Tmvx18V3hDvnub7JECQlZzBepPWlRAN9HS
   P5otRMydeMBOnvAlYNxAZyC7ttpP9guCcMmX0MDYUps8S1Fj3p2NpF5hV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="375619582"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="375619582"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 23:33:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="693380960"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="693380960"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 23:33:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 23:33:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 23:33:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 23:33:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpE9yLNn0p5UTNh1bLI2e7b00R/JUp67kDWcT3pnYXnh5NkA5E4/rjxwLuXqF5v73GGDGt2Dnxy7uZtJgEHMfvZj/lEEcvd3PJYyKyvqyOgrYVsu2WhqU75F0bcLt6ypzTwqjWvRc8bGsJwfJtVEUT3CIobehgHWqXQQTHVsBINvSxNM+3MVdbjpJrGLDRTQmDcTSxREscQL2Rtx54xzoRbJ5EHGsIJtdTJfACSJmjw9Hneefv1ju3yxDOKwhNQ/ka81JWjdbXGT2UlvL2KEgqxOccl2rCmCOjToMw5rAQD3LxHPlOnTPV2TTKYUPLlAGuUZVCW9Zcr3QqIgoZEq9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xw6U0qDsh3U+i/Qcigmd/CJLB6CrjSvRhzjihhHnvhU=;
 b=HJeIzDsXEsYtNuADKeHiInxAJ5RY8LJyypiq4UDZpUPuSmq0vB1zhZGP/wZwv+xaPSZMlIo9gMJNs1R/xbURIZapBBPZ7K4Z44SdK73wJiTVncNARQSv9eMjufqU0nNyizmOt5P84AJlmhzBIKR9AN3ygga+Rd6Nvxfvzj/V5jJMtbwpBknD4FBE2HNLguPCXC9lqE9jzHSa42ySIwDoEebq26kBnKwIz9XLpFSp2gTI2K7jH6OUL/mmyggWhvFkTKoOngskazhTIIWsHLsyo1oMwaVCM0AesSZHAR4Wiw2lScZsx7JDLdoCjI6XYCPEq7HjoVTjHj6JGjDULK+Rfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by DS0PR11MB7802.namprd11.prod.outlook.com (2603:10b6:8:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 06:33:04 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107%4]) with mapi id 15.20.6745.034; Tue, 12 Sep 2023
 06:33:04 +0000
Date:   Tue, 12 Sep 2023 08:32:57 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RESEND v3 1/2] selftests/resctrl: Fix schemata write
 error check
Message-ID: <sr6ana6d7ebtuxbhjuo6kcnhnn2zzvg3ivve6mndqeb3nxrzo7@mrfmtzlxlwdh>
References: <cover.1693575451.git.maciej.wieczor-retman@intel.com>
 <960b5302cee8e5bb0e83dcf20cd2ef4d353b7b0b.1693575451.git.maciej.wieczor-retman@intel.com>
 <99eabc5c-f5e3-27dd-0a29-ad0cdb7b4239@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99eabc5c-f5e3-27dd-0a29-ad0cdb7b4239@intel.com>
X-ClientProxiedBy: FR2P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::16) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|DS0PR11MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: 073b119a-9d10-422d-ac17-08dbb35a1e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cVhqTPNSSOEGKUN9o7G871xGzTUZ9irxn0s6sm01yPJ46jJEU/4zPzf++/RxXgusn4ps2N65AlPQlz4E/8CKYrJh2hTUlq5gWlfuMpgKmmaWq/3rZT4UkItoaRKDEIvFke5ABQCV2Nzx8W/LIarmsVuveCXC7mTmZVpjMX1OoKRYQl+YKMtyJWr2+NkGBBMKv4FE/7FNj3R53pHfo7NBqpciNs9KgsM5jYks2HNOeLkdJH6DuLlikbKkVDfjKleUWC9k6mKqEdmqdAYWrWSCwGcxeVWaivU3NHnrV1mz0u6gmz0HdTmxxoxei/oA6aQuJmhreIOzhXWAdLTRTJJ2cP2T0TJRCxHg/msrLr2VGMnaYIKB34n2lt0del7W4DTXEF3hysugppF1x43MKiSFtm52eEbl15gUrHVV93tyMDB0m5lcgySAWKS7ornDXTQ8cEKHJK8y7SRoNXUn+8FKyniFbE+cmCGF4XxeX7awl49EemDH0Pj3SRUxanZirQgbJf9lL5nNq6YqCybgMQuUeV8JY6Z10i12wYUI6w3M7lRa2PGuad1SxnsI8vCVwBbZ3BlT80gGv66G8A3yBiGnI3jtpd4WPSuiiq55SZR6cYktzb8I635ADII9G8mUHvLm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199024)(1800799009)(186009)(66946007)(6506007)(6666004)(66556008)(54906003)(66476007)(6636002)(53546011)(6486002)(6512007)(9686003)(316002)(41300700001)(478600001)(8936002)(8676002)(4326008)(6862004)(26005)(5660300002)(82960400001)(38100700002)(66574015)(2906002)(33716001)(86362001)(83380400001)(27256005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTBFYWNUNkFhWTYxWnFMMkhZZGNlUWtIU2tLTHRvTUswYmprK1A1NkdYVE96?=
 =?utf-8?B?L3BKTkVDbkhqbXEzSHpQTGxZaFNuN2hjTll1aDJJREwrUzBPbFRYVVpHeHNN?=
 =?utf-8?B?QzI0aDdaYm95c3NobVBJa2xWME5hRzJKS1FhaFR0Z3FITkJNNmtBQTAwaUQ5?=
 =?utf-8?B?NHhUQWszK0t5R2hkSHM3TWE2VURIWXRCUmcxOW9Gb28wM1JvS3pFaHgxRmpT?=
 =?utf-8?B?OTlWdHVQWXRKT3VPM3lsenJtSDRQaytCM1N4eTJFaDBmNHcrSUh3c2RrZlVV?=
 =?utf-8?B?akFjMVlhWERyeFJhVFI3U2wyek1kRm1VYngrSEhlVjBpeEdqQUNIZmhJMTkr?=
 =?utf-8?B?OTZrbklhUGFRZWxWTytTL0t4azltNTZvblo1WVdSSlpSU0lPYVhURFcwcHU5?=
 =?utf-8?B?KzRvbW1IUm1TQS8rbkRzRFhHTmdEakZQSzJ3WUNvQ252Rk1OUU90dU02SW5j?=
 =?utf-8?B?a2NocVprWklMT3p0QUlrOVNOQ3NUTGY0QkdEUS9wNjh4cSsrdzhqUmpuOSs0?=
 =?utf-8?B?WWdFQTEyak5iTzYzNXA3ZmdOdjlKbHNvVWt2Ti92Y211SlZHalFDZCtnK3NZ?=
 =?utf-8?B?dG1TRmhqTVFsMWhObVpMdzZhT0t3NEFPQ2VOVzFTS25MK1NHcEhoQVU5VHR2?=
 =?utf-8?B?T0k3eTVjRXdpTTlOU2VOU3FRVGp1MDVST2ppUmZ1L0EzYjB5aWVoTjJyQnQv?=
 =?utf-8?B?VThtVmtuNjJISTg2S0kzY200WEozUjhVU3JWU29ZN21qc3JUMWNMeWhld29X?=
 =?utf-8?B?aTdORFJFaVdCV3N2YkFTb0RnTjBXeklFSWVHaktYMEF6R2NIU2NFZTZoZUsx?=
 =?utf-8?B?Y0JmdGlEbHA0UVZSMjNMZ1BOZkZla0tVdk9hQm9YMkdyS2tINGtKcU4wbTBM?=
 =?utf-8?B?Zkd3UmpiaitPVjFKRFNmZFV6cW1NekUxSE93STR1YVZJaHdOenJ6R1FDb0lH?=
 =?utf-8?B?VklqSUhpWnR2Z2Z3RWhaSWo1dkFKRlFseWg3eFhQSU0rR3NqSUFvNTJ3VVk4?=
 =?utf-8?B?WGEyMlB6d2QyaUdxSS9DbWZOeXcvanBYYVFpS2V4Zy9pSkJKcEQydzdPSHlK?=
 =?utf-8?B?cGtBOFQvdmxIMDV2V0VpUzJOemtaSFZsNU9SUW9mclpjeS9JemplYVIwelRY?=
 =?utf-8?B?N1pjMFhReExiR1JIMXhRRWlpTThySXdKOWkrVytOdU13MnhDZllPb2FReTRj?=
 =?utf-8?B?Wms0ZzYzRExNYjVnaDNQaWw0V1ptRGNMNG1TeE1yYW8vN21hUkdZbUVESEZI?=
 =?utf-8?B?KytuRnErY2k3dndUUzJuTmpsYURYY25WOU5NVlREaC9iRzFhUC90SE96dlNm?=
 =?utf-8?B?ZGs5UUlVVk9tVmMydzZGU3R4UndCVElyR2xTd1R0bzZLSlhCZWZKT3QzK1pt?=
 =?utf-8?B?azBLNXNFVlhwZVVqMWp2cmlPem1XTk4xVFJGT1dzN3Z2d0FTVjhnbFRiSmlm?=
 =?utf-8?B?OVR1MGxFbitUY2tNWkNzTWc5SmFxMitoWFVVVy8zSmdwYytkU3ZkQmkwRlVU?=
 =?utf-8?B?bzRxVmJWTFVIVVdqQVRxUFBTQUE5TW5zM3B2eVV4dFVjRnRFWm94RXdNVXpz?=
 =?utf-8?B?UTJFcmpRV1dRRTJkSFJLN1dVMjZXSzkwR1FlaTBvbytYZkRPTlQxRk9PcnZ4?=
 =?utf-8?B?Y3RzQmYydGhMTWo3QW5zVW5yd1MydW5nV28rNGdjZHZIa3gwc2NuRW8xU3VT?=
 =?utf-8?B?c1dFcXQzSDZ3K0NNMnlEcml4S2NMeWRiNWlNNXVrRUJ3SUVvMXYwNDJlemJi?=
 =?utf-8?B?UktwS1orcXBsYW1wcjl2NFRwZzNVN0pINkJZaGRrNHRjQVpQSFB0MlZtMHlL?=
 =?utf-8?B?citYeTZzYStpTXNJSXFkUEYyc1NIQ2RLTjZXT0ozYVFBSTM2R0xnNit5bDN2?=
 =?utf-8?B?dVhvL0poQ1RIdGRzUVNYa2ljYng1MVUvR3lrazR4dTk4UDVoa055WS9KM2sw?=
 =?utf-8?B?QjRjNkdGU0RENmNzZjhmRDNLT0hueUpZT0R5a0FXd01XNzcvOWc1VXhSLzJU?=
 =?utf-8?B?T1lhb3hNc2pudW1NOEVtaFRGMHRPck5aZ0ZHYTBrLzJHUjIyUnViWDVvVCt6?=
 =?utf-8?B?VmttNUYraW5Pejd3MVQ4cUNEUVZHYzRpd0dWNTdwemZoRzFUZ0YwemNWYWhO?=
 =?utf-8?B?aVNhYnM5WDFNMTNDcXVEdVRXd3FkVUtlWXV3MHRyR1gzZHIyT01XRVVucHcw?=
 =?utf-8?Q?a2VkfsNjnhmoWHtYsPAETRY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 073b119a-9d10-422d-ac17-08dbb35a1e09
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 06:33:03.7119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tayqJoZx3dh5LFC1ckiLYqXGs2bUMNrg1/cC5teccmW7coLkLlGDAJMeta7l7hw4oelj9Bx/ikpv6tFBjchBw52JycY6B0Ms+A0N67e7NpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7802
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-09-11 at 09:59:06 -0700, Reinette Chatre wrote:
>Hi Maciej,
>When I build the tests with this applied I encounter the following:
>
>resctrlfs.c: In function ‘write_schemata’:
>resctrlfs.c:475:14: warning: implicit declaration of function ‘open’; did you mean ‘popen’? [-Wimplicit-function-declaration]
>  475 |         fd = open(controlgroup, O_WRONLY);
>      |              ^~~~
>      |              popen
>resctrlfs.c:475:33: error: ‘O_WRONLY’ undeclared (first use in this function)
>  475 |         fd = open(controlgroup, O_WRONLY);
>      |                                 ^~~~~~~~
>resctrlfs.c:475:33: note: each undeclared identifier is reported only once for each function it appears in

Hmm, that's odd. How do you build the tests?

I use "make -C tools/testing/selftests/resctrl" while in the root kernel
source directory. I tried to get the same error you experienced by
compiling some dummy test program with "open" and "O_WRONLY". From the
experiment I found that the "resctrl.h" header provides the declarations
that are causing your errors.

>> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
>> index bd36ee206602..b0b14a5bcbf5 100644
>> --- a/tools/testing/selftests/resctrl/resctrlfs.c
>> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
>> @@ -488,9 +488,8 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
>>   */
>>  int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>>  {
>> -	char controlgroup[1024], schema[1024], reason[64];
>> -	int resource_id, ret = 0;
>> -	FILE *fp;
>> +	char controlgroup[1024], schema[1024], reason[128];
>> +	int resource_id, fd, schema_len = -1, ret = 0;
>>  
>>  	if (strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) &&
>>  	    strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) &&
>> @@ -518,27 +517,30 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
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
>>  
>> -	fp = fopen(controlgroup, "w");
>> -	if (!fp) {
>> +	fd = open(controlgroup, O_WRONLY);
>> +	if (!fd) {
>>  		sprintf(reason, "Failed to open control group");
>
>It makes code easier to understand and maintain if it is kept
>consistent. It is thus unexpected for open() error handling to
>be untouched while write() error handling is modified. I think
>the addition of errno in error handling of write() is helpful. 
>Could you do the same for open()?

Okay, I'll add that, thanks.

-- 
Kind regards
Maciej Wieczór-Retman
