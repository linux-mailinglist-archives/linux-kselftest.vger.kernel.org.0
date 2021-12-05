Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E844688BD
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Dec 2021 01:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhLEAge (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 Dec 2021 19:36:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:21327 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229772AbhLEAgd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 Dec 2021 19:36:33 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10188"; a="235888417"
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="235888417"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 16:33:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="578868381"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 04 Dec 2021 16:33:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 4 Dec 2021 16:33:04 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 4 Dec 2021 16:33:04 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sat, 4 Dec 2021 16:33:04 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sat, 4 Dec 2021 16:33:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrrbkmT5Yl708JnYXO45JKovSPHV57nDGLORKVaZgGQD3O+o3RG+9fvRIrpV1PSzXWKDM9IQ4CBDOp1V9bdpb1vLTDY68IL1XONHHNi7e7GFe9e0k+DQWH4cYcZCrIIG1IPClGAGG3VtYAzhLHP2voj1kpGgTj0tFODX8nwDTVHUS3Mg86SOBAs5ueigiPnLIQcseIcZgJXu3ka4YU/T2jKqxXOJNzE76hztIEtiNOyHv2gQ6lbMORmOtDF7dIZGTJ24kVgl0WROwDzzWZpIdXWoOqUna9TTkfyKfmNZsi0MXWnGnKnfQW56WiRwLZwBL9eKH+i93UAzh4+7YL1CfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBu/9kBPFjBBZ8ibuewyEV/cnS7RXBQ38zEd+IHKDhc=;
 b=GqCrzGt79GPSnVFzVNvaRzAgPGLDO5clPtKQ16i0yAiWaKljG8aW6hhdfXQHcUOQPbWunlOya1It8vy9HVIwb3jt0Ke7OUbm788NM2KVQ6WQeyT3HX8unENGcWRvZL2U/+GG6Dk1UX/vYe6+VE60xo8Pc5viaCbMwrQPgoGD+AaXUcEijKm9F3pupwJHMbsCqDKoM8TNhuP+HsNywduHVKicbHfgMWsP9nFyvKcTxZYwyPgrYcVNA45GAFfrIwbE+sfoFMpbw//tj5YDXJbbJho/P3iufDwti2UbY5CsMtVbswdU+6IcORiajt9cjHBfDgFZ1NtW1q6zE+ctyp4gBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBu/9kBPFjBBZ8ibuewyEV/cnS7RXBQ38zEd+IHKDhc=;
 b=TIiERvxRH2u2ssts7wUwfpc5NX40DPtHT2HaNwwr7D/WeSxK+B7qpVOkg36k0jqTeU/aCQ4Tcfl35AMn1Ft611hwb81qWTV60QqiKIONpEGfJUv+xdTYNIWJOLmEwqy/6IEWxl/22nuM4+jB5G5fEjG+M4rdsS48SV0hxCSKJ54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1844.namprd11.prod.outlook.com (2603:10b6:404:103::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Sun, 5 Dec
 2021 00:33:02 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4734.023; Sun, 5 Dec 2021
 00:33:02 +0000
Message-ID: <c5792b66-4a27-0a62-bb75-6cc0c4219002@intel.com>
Date:   Sat, 4 Dec 2021 16:32:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH] selftests/sgx: Fix corrupted cpuid macro invocation
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, Shuah Khan <shuah@kernel.org>
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-sgx@vger.kernel.org>
References: <20211204202355.23005-1-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20211204202355.23005-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR14CA0034.namprd14.prod.outlook.com
 (2603:10b6:300:12b::20) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR14CA0034.namprd14.prod.outlook.com (2603:10b6:300:12b::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Sun, 5 Dec 2021 00:33:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89c61b9f-3e27-42e1-0b3c-08d9b786cc02
X-MS-TrafficTypeDiagnostic: BN6PR11MB1844:
X-Microsoft-Antispam-PRVS: <BN6PR11MB1844029A1FE18F3F2250C9EFF86C9@BN6PR11MB1844.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wFWi308SEAwPrFbyFzEx7jIywe/iJxnLfZA/86iyJqWoldounCflP2FzGOAhoRMfIzURQiG6sgJE6sIirTSKRNK2yWGcpB2g/VShfCBG3jlWRfT++h0vGKFOj+RocCEylbfiNHXdXKmd5NVgt2RcGWtrPaOvLXUjc4wfiWXKhO4RrhYmUAybW7mduVASgiausNrAe7LWE05haAdpXnooiIAE8kHBClPft/EiNgpTZpFIJLnolKgp2Mol/sxFsIlgiKlMQtoOLHlb3LQuKfHn5YPBte0jqtoTQflOa26aDI20LpS7Wnl/xidNCbuq1I0V8iFjsxcBdhxUycudrnXrpL/Mc0PwJY6+6QUc8um0CvAGGLZoTkV/FUnFPHSLL6zFjB92xVjteDDzTJ8o3NdrW1DZ1zOcLvXpyCDhij3BtZEwvGmFruDP9lHeJzh0uw3YSXde5oZnk0i6Jp1YCwiZ7/UYLXptgf9Y2i06m8zURl+tglVfclKnLbl1rGjPZm182HOMV68um8I1KAz+ZJh4/XYkZNUA82ryT/geQzaU9+2wGIbOLTu+8fsDGxUhuwDlHZ1ZRC/whZ4KcjdV3kYEc8VoE/0xGomAHSEYPQyW95KE7RjMF+FuikTBby5j6Id12lcacaoQbYEEyrur3uOx3wbixerM+ciDgl+RKSWRZAKIsV8G2KGcaR5BWYiZN6D52t98yvviEdDcBFE4JIxqN5+jLdg1QgxI14fW+1trGbZKI4997N6cvEp152OXMiOM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(16576012)(31686004)(66946007)(4326008)(31696002)(316002)(26005)(53546011)(2906002)(44832011)(8676002)(86362001)(6486002)(2616005)(956004)(38100700002)(66476007)(186003)(5660300002)(66556008)(8936002)(83380400001)(36756003)(110136005)(82960400001)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME5Gbk53ZVI2bzZJRC81WlY5S0FuSVhqUEpLK2dvbDY3b25CQ2NVTnNFTnZD?=
 =?utf-8?B?KzNBYWV1dG40b0dzSGFWdXk0TmFxeHFrQm9UbUsxMjVZL0xuU3UvRFhZR1Fn?=
 =?utf-8?B?dUVxZ2JLTmJab2MxWTBUbzU4SnkydlI0cTJkbzNESHVsemJGWDRieVpuOG5n?=
 =?utf-8?B?VzBxQnNMZHFkU0cyR2J4Tmk0cGtwR2VPc1R4RTU2SDYwYTVEcnJ1aVhWSFZ4?=
 =?utf-8?B?ek1lcDZqQU5lWk12NnM0VDIvNTdQazgwWmxBb3lVSkNWNXZkNkp5MEdMYnRu?=
 =?utf-8?B?bVJKN2NOR0J0RlMvb0lidGhGMHluanp0RXgyVkpyZ2xqWS9YNjFoMFRhUHox?=
 =?utf-8?B?dStCQTl6UFJGQ0VyMC9wUEVNOXBkUDFBbXZ0WXN5dFVVOTJhZGRkai9Jb3hF?=
 =?utf-8?B?N0JIUDJvc2NhdHVsQUFVY3RVc3V6cXorc0NyZVRBZ1loWVN2blgvSVRNempD?=
 =?utf-8?B?T1dCVDBSSUp3cG1NSVNYanhiVXErMDQyL2dSS3RGME5ZRkJIR1YvTE15Ry9Z?=
 =?utf-8?B?cGlhVFVvUzBWRVpJMnJCRlVtQ0JGcTRMenNDVnlOSkQ1MlRXVGtYaWh4Wmln?=
 =?utf-8?B?WjlnMnI0TkpBcDFPVDkrN0hkNXZzaWFiSUU5VlJDTmlPY28xZnhIbGdVNXNo?=
 =?utf-8?B?OW02V3lZamkxamR5UW5tUjhYL3NLdkU2dFJBZmJmOUNuV0Vuci9DQ1IxYjFC?=
 =?utf-8?B?c2dPTGdTWGt1bEZwaW0yQ3FTZkpNVE9MTzArN0dIMG9Gbyt3NnN3Y1pUQXl5?=
 =?utf-8?B?clVYVXM4SHZFVWNzY1BXenpiTzVjR1pvanBaOWM4cEFTM3E4VEpaSTZnNVhs?=
 =?utf-8?B?U0x1K3Yvd2Znb3Z5VUN5b2ZLQWRHeDVKcWVYcGw5WnROTlVNWm1zV0tyc1FL?=
 =?utf-8?B?RjdsNVVxN2dMUmlpMlkyYzY2NlVTVTZIUWtrTlFFOWw5RFpBRDI5bW4yQ3pj?=
 =?utf-8?B?WjlWVklaVmpnQnlKWng0SkdvQ3cyVjhZMC9BM1Y2ajdIeFlaeWlRT2pEdGpR?=
 =?utf-8?B?Q29JaWpZaklNQ2JXRDBMSEdoUmFwbmJzT0w1ejlwdlBoSHJiVXlGY1R6TzVZ?=
 =?utf-8?B?WDdUQ3NHbmY3RnJPYW5aeXh2Qng2L0RtRngvU3Mxc1ZrOUl0eXlUTjBXQTBG?=
 =?utf-8?B?THhSalQyem5BYU4wZDF2VDl4dnVjaUdtZlpBc2E3dC9JVU8yOUhrYkZBempq?=
 =?utf-8?B?SHBROVIxR2RRd1QrVlFTWkxYNDd3SWFvak05TjhDWHZvTnJiSm5lOXFqZVpT?=
 =?utf-8?B?OWpXZnltRUZ3QlNlN21TUmx6ZWtwTkJEYWlYSUhLRk5ZQW9SWUtWUkp6TGI2?=
 =?utf-8?B?cU1ZSllrd3UrdlJlcXdXS0l0WDIzWFVaQ2hKbzhBeXZpbHlzNUZhZTRydzc4?=
 =?utf-8?B?YXdrS3hlZFFDTnNwSG5rUFNBKzBETDhFbzRVNmJCVlVEZVNhd1FQLys4OGpT?=
 =?utf-8?B?ZS9BME5FYW1nZXEwTzhtRkllOGQ1TzVLUmtmZGx2MkNoT28vQSs4V2N6UGJw?=
 =?utf-8?B?MGpnMU0waElwNWgyUU04SjY0Zng1TUpPYjNqSXRnblBaaVVzOUs3UEhWaVNh?=
 =?utf-8?B?UEpESUsyMEJMWGJjSmdnVTk2UFlYck1jOVpLWVh5SDlZNzlRUzNxSnNwNFpZ?=
 =?utf-8?B?SU5aMWtRSDYwY3Zkc01TRjZOMXlEekFTa3kzNXZXTDlhd1BKTWl6SG1YcEVu?=
 =?utf-8?B?aUtGamREVUlvZjMwcW5MYTVFUCtGT1VZb3g3R1pVMmhGZmY0bloxdjIvMFAr?=
 =?utf-8?B?eVpuTDZCaE90dW44UjNDM3RiM0VYYTQwNHlnVWIxUDFKYk5Wa0NaUHpoTnRq?=
 =?utf-8?B?YmE0S1NHUEdiU2pqbmY5a0YzakFjMEVVclV2bEljQ0FSY1o5NHptUEl2dmpj?=
 =?utf-8?B?ekpiL0RSaUd0dndrZUlWQlplVWdnN3RYZU9TTHlVQWVHcVRMalU1ZitQeStK?=
 =?utf-8?B?Y0sxbjAvQ2pCWSt2VWJYZi9sZjh1Wk5pd1hMd0ZYYlZlaWFIYkNneEppaDhY?=
 =?utf-8?B?QXBTcFczOFRTajY1T1BqV0Nhd2ZvajBibWN2cEVQeXVPUEhZL3RBTUhHUW9O?=
 =?utf-8?B?S0JaTnBMNVpDUEtlSHBSNWFLODltUXROZ3kyU1JySXQ0aXlJUEtrSENHYzNr?=
 =?utf-8?B?Y2s3MUo4VGpET1E1RmJmdmh0d2dBT3dUakpRSEJXUnBRaDc1UUp0OFVIYVRK?=
 =?utf-8?B?bWJDVTk2dllUT1Zudkg4UFd1TXczVEV4M1d0blliMXk4ZjlDLzV6bkQ1TU5R?=
 =?utf-8?Q?ULfU4vHj+sN0kDvSVloK9BYP1YDtYIdvxOn/lJnS4A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c61b9f-3e27-42e1-0b3c-08d9b786cc02
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2021 00:33:02.7893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GONqoH9YEOATgEQxUljR0vYfa9dQIT7c0QeTBOyqr/sBaUSmPCK5xnN5m7rqHxo0DNiHWHGDb1C4CtQUsA4Bzw/KWsiprZ8uzyKdhLFLDnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1844
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

(Dave: I am very sorry - selftests on x86/sgx on tip.git is currently 
broken because of this)

On 12/4/2021 12:23 PM, Jarkko Sakkinen wrote:
> Compilation results:
> 
> $ make -C tools/testing/selftests/sgx/
> make: Entering directory '/home/jarkko/Projects/linux-sgx/tools/testing/selftests/sgx'
> gcc -Wall -Werror -g -I../../../../tools/include -fPIC -z noexecstack -c main.c -o /home/jarkko/Projects/linux-sgx/tools/testing/selftests/sgx/main.o
> main.c: In function ‘get_total_epc_mem’:
> main.c:296:17: error: implicit declaration of function ‘__cpuid’ [-Werror=implicit-function-declaration]
>    296 |                 __cpuid(&eax, &ebx, &ecx, &edx);
>        |                 ^~~~~~~
> cc1: all warnings being treated as errors
> make: *** [Makefile:33: /home/jarkko/Projects/linux-sgx/tools/testing/selftests/sgx/main.o] Error 1
> make: Leaving directory '/home/jarkko/Projects/linux-sgx/tools/testing/selftests/sgx'
> 
> Include to cpuid.h is missing and the macro usage is incorrect.
> 
> Include cpuid.h and use __cpuid_count() macro in order to fix the
> compilation issue.
> 
> Fixes: f0ff2447b861 ("selftests/sgx: Add a new kselftest: Unclobbered_vdso_oversubscribed")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

I am sorry - this was my mistake because of a last minute change to that 
patch that I submitted with a dependency that only arrives in a later 
patch that is not upstream yet.

Jarkko, thank you very much for catching this.

I am not sure what the right way is to fix it though - my original 
intention, what the code uses, was to add a snippet as below as is the 
custom for all tests needing to run cpuid. There are many usages of 
cpuid among the selftests but none rely on the cpuid.h to bring in 
__cpuid_count. I do not know the motivation for this but preferred to 
stick with the custom for my implementation.

+static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
+			   unsigned int *ecx, unsigned int *edx)
+{
+	asm volatile("cpuid"
+	    : "=a" (*eax),
+	      "=b" (*ebx),
+	      "=c" (*ecx),
+	      "=d" (*edx)
+	    : "0" (*eax), "2" (*ecx)
+	    : "memory");
+}


Reinette
