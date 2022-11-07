Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11205620268
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 23:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiKGWlB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 17:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiKGWlA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 17:41:00 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F30205D3;
        Mon,  7 Nov 2022 14:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667860859; x=1699396859;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=USL/WiE/dtIEnX2AUiGbh1Q1Dp6p9SpyGpNpjPyYkAc=;
  b=hb7oQjeN3yfx6K6UvZ/nRdOobxS+bzu9MOi07eiJD7y8H3BeKz7xMdon
   BZDsPf9rKtuDrgpUz/eIXQfgv4Mc21Ucr0PhW8WQjXD5Ya28Pol/CXu6Q
   lTSDEtLbNhyDmg6aRgNq6kcWfDmPh27xwDHCj4o5SUgD+5/xENqjNgYuJ
   WsMm9VvIqdfleUdcnNfC+GaukJoT2VUzFI2OCNKQSfteAa8ZIayI54/68
   gR7+RScZsJ/7PRMywPFMYCw6muYHHKs/R+cUf0tLYsGuiSuMwD7HVTV03
   RBd4SuM1M0XQNf/95e+vtEuivLTVdt3o4XBwowa2E9NiDAUWpQt7L1HR3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="311695069"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="311695069"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:40:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="636093920"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="636093920"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 07 Nov 2022 14:40:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 14:40:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 14:40:58 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 14:40:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ks3ggbrn86mv1YYh6uN2+W67mDQEHZUIkWzrqGMsTiJRgDIi4Jsjp2qIIjrYk6gWWQzNdHo1Z2l/FUd+gqE6XJLD6Dh11HFC+xngUpT6Pm1voldOctMX8neC459q7uycQlRbBFxLmVTxJqqXa3Gpca86o3Asy5p3e3qXC5pVtXV0QX3HSpHCHmuVP4G0089/r7moBJDc2kNZRJeXibm75PojRC80Ky9rmyQPo653MyPvKUdire3jqp7F1gC+9At8Ltj6UC2NLW5W6J7b2za0WJCjY6Zq/SqHdtvU+9g/X71hvLScYaPW5mU957F1Dt0d/kMUE9DA4EFhshx2zBGu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWnW6DDDNOc38lwl8M0rUg9Qqpjl4O8xoI0uvikcvRY=;
 b=hdnLmWbTYhDCK0AOvx4SnZjumDEF9Epw+R71HdPHDCJYNiRzVGSNXlcbyAqydroSXy+SYJ8nT4zx4WrRP+5QbetoCgWIzNXvSHuzz4gie4s+FqRnvPQ+Fu5450l7NupNhlkV6xETczCK49TUT764b5vi6nQD8w0vqhqnr2Y3Cvh9zZRUPMBShtDrVpTJ/gyhQf3ksUX2hwusUb/UekgfSlgWIaSnCWYveed0Zav9FY/mq5DlySh39PWGvyVn+rJWFWkbTR50ZrltNqYZz+Twp2tMfjig2/9ekdbYwy/JTZwUp0QNeXixEyVsrG6XOuH1OsE6bGnyfpr9IO5UxnHzcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM4PR11MB5344.namprd11.prod.outlook.com (2603:10b6:5:393::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 22:40:54 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5791.025; Mon, 7 Nov 2022
 22:40:54 +0000
Message-ID: <50c82ae4-fb71-c534-d285-5991baa37150@intel.com>
Date:   Mon, 7 Nov 2022 14:40:52 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH v3 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20221101094341.3383073-1-tan.shaopeng@jp.fujitsu.com>
 <20221101094341.3383073-5-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221101094341.3383073-5-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::9) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DM4PR11MB5344:EE_
X-MS-Office365-Filtering-Correlation-Id: 19bd9189-bd88-4595-6b0f-08dac1112171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pKGhxQ8aZbcRdim/GNpzZopjEPP3kYcKzgEkS3RtoNen7L/DljTqJEjRdjUE9UH3zqFlLq4vs0hKCNdC8hO4blkzBKI0Ul+pvjLtddBkTrmW3XV76MV84ZN5Xs4+x+WDy6YuEZ92Yk9lu5+tASA+HfgmuWyv5VD+RdenL6cYGRRPjvV6xwB2qi8yYeXU3Vz+ctIWZcXriPLZVkzk4vmeBz0m8IPS1UOpePDJDr34rz4o0qF+HeHRa2XqDAFM9La2YqO55oikCJu4kT68uqxwhW6GENevpuAJgdeUTxAotL7oZN6tn3iar/u7kjHQHKrMLAjkSYlRL9OUoNSIFlxR/YYczDe+se0rmyaVI5bFep7yZhe7zoZj3UpwHCxzPfo2Kofoe1Tr7I/LSEj08Xfk+hVR0fEeFJ4JfIqRUpa54/rhpT66IaDSx7qDTMPngMVvsCrEgkePB/yPlnZP5ReI4is5EC7KDbyDe7vTCR6M+u9Pmaf4e5rR7sUtQIbuIovtedYAFHSN+thUnZXFWF9Q34W5YS3P7TP6GmbAMty+FzDsQmcSD3L29bfoPF/WddnomVPNjlpoCG9cx+Ih/t/lnIRlYrnJgb2b9IiLiRxjwAvbYxFlSy2gcF427AVjgKsvU2RQsxhJF5VB9Fo6OUREAhYzAfvZWG9xt1xpmWxhqA4U+3K7gw1V+oS2XXsbOyRZWs3b4hxW0eh/iW2sqpnYrN2U6R/EBrBvhT0lAqeEEOjxcJl7/OWGrlVKZj4+yske1iXfBSFeZlgeRGL0Js1hJFXkEEzeOrrnP2CqABOv2Dc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199015)(316002)(110136005)(4326008)(8676002)(2906002)(31696002)(6486002)(478600001)(36756003)(66476007)(66946007)(66556008)(86362001)(82960400001)(83380400001)(38100700002)(6506007)(6512007)(26005)(2616005)(53546011)(186003)(44832011)(8936002)(5660300002)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkxoWnFFK2dXT3d4clBSRnVRYkV4SDFjY1YwQkUvRVJWMHkzWW1LejlrTlpO?=
 =?utf-8?B?dElBR0g2THczeTI0MTd5Z3BiWk5ZK2N6TDlVWWVGeVZvUlZZVDdwSlRVZ2Qz?=
 =?utf-8?B?VkxOazM1WTlxWVgrb2lSNEh2NXNvTE9jd3lIKy82RkZkSVdBdklYSE9NWlpF?=
 =?utf-8?B?bWdScWtGTC9BQTVFeXAxeS9UNlgwYmUvTUNMczRxc2pyR2lHRmVucEpEczY0?=
 =?utf-8?B?VVhtYTI5TFlsMlNVRDUwN2FnQ0hBVEt2aGxpWHhIZUxUd1gwa1dPTm1wUFR4?=
 =?utf-8?B?N0FULzZqUVhmNFJjTG9kdG1NZ2ZZM3U2cHhkOVhLdmllcTdnUG1BbDB2eFpY?=
 =?utf-8?B?UFdIWHpTZGpzWDVHa0RyMXY2cEtLV2dMWHYzR3dQVnNBWSsyRXlWcFQ4Q3Jx?=
 =?utf-8?B?ekE5Tm5xanJiNUxMMUxtaVI5SlhMZlRkRUxSS3paZVNOS1J0WVAzSnBZQUF1?=
 =?utf-8?B?QjFrQTVraXBqRGFlaVRHNCtiT2I3MXZaMHV3VFgxTE05T2ZRUVU0NTg3VXZO?=
 =?utf-8?B?UEZEblZ0RTBxVEh5cDdZaXNpWXRrV21MZVgvZ3pJYkg3VUc1ZHZjTngvZXFR?=
 =?utf-8?B?c1kzTEFGdGFLVW55Rzg1Zk5LQWFGZGljWUJWUXFZc1JPYWc4RFR2S256cEdC?=
 =?utf-8?B?NGl1YWdteWlSWVlHbzBWdEhlenEybFhkU2lSNnZraTNXL2Z6ZUJsU2VYTGEy?=
 =?utf-8?B?QWNVaDBNdmN2QytCK2ZpU1oxT1dZTVNSWmFjRDZWK2RYbFJkbXFKclFrNFVa?=
 =?utf-8?B?cWFHNWgvT0gvdGtqREtmb3RVY1FNZWloZEtVWStjNVlVMjl2aGQ2R2pydm1C?=
 =?utf-8?B?TldnOEI5bFh5RUdFQjVoWUpmVkg3bHZta0pSMmZMVmg1RjVXSVRMLzAwVGJp?=
 =?utf-8?B?V1JpTnBFcmFpK0VPVzFDbHFsL1JmSEtleloyUjFZMU9ZdFpSVnFDdk52STVz?=
 =?utf-8?B?MTJCeVJFQkVRM2c5cGJaUWlXNHV5M1pVV08yN1RjSHBmcFNmZ2hncW5yWURk?=
 =?utf-8?B?SlVBc0lENnZTRVFoR2MvZlhVOGlLZmlJb0FvZ1VHQUNtS0xDdEhXVVFYdk91?=
 =?utf-8?B?bGZNUXlZWUVzbjEwT3I4bW40NktYWlBkTkttTlFJQWdnL2I5U0xBY1lXV3dm?=
 =?utf-8?B?SFE1Ym1OMjJ3UXU0WUdTclMyeUpCeW1sdGFtb3JTVjdjcDJxNU5GRmhtT1Qr?=
 =?utf-8?B?WGp6NUdWTHI4cHhId0dGbkdXRXN4UnMyaitjemtpM1ZZTTlKMlRJazhNc3VB?=
 =?utf-8?B?amlmRk9RTFF1WFlEV09Nb1RCK2RZT0tncUNMTzE2alhwUEl4eWVrZE5JZytF?=
 =?utf-8?B?ODlCaHJlYytwS1lhSTlpSnpBMlUwYjBlcm55VERWMlRyNnhtZ2NxZktMSFBz?=
 =?utf-8?B?UlY2NTlQMXdsdTFUUzYzZXY1Z0hTbktUdE5XN3dsV0hSejdMNWVFM1FRcDBC?=
 =?utf-8?B?TkREZkttVVdmaXl6TU45WE9YMHkwaDdwWnRjMHhvSzF4bEhMRDdsenNaNm9l?=
 =?utf-8?B?NkNmUm1mVGoyUVJ1TFNaTWI3UVNtbGlzUG15d3lSQkxaZWFGaGlZWk9yc3pO?=
 =?utf-8?B?cTdZOHoxODBiVWdFNE96YWR4R2xOSzlkeFBFZTQrWDBxbWt1aXZMQksrVnl6?=
 =?utf-8?B?YmRuU3puancrRUo5U1l4bG5EVXM5RkFMaXB6YnhIdWNXbGxrRE5DWTJZTXJw?=
 =?utf-8?B?QjNMVGN4RWVxem13T21FOE1LdnRxMkMwUFJDUVpvQWZmdkRsNVlDVTl3bW9y?=
 =?utf-8?B?bDBBdXlrdWRyNlNwRnp0STBqck9xMGwyUnhUdlJuZUhCZGZ3RHVWVXhQV0tV?=
 =?utf-8?B?YXVOU0FXU1M4THRReFhzMTYvRG44MUtQWVdwS0NzQmM4Ulh3eDUxRTA5bXZv?=
 =?utf-8?B?eUZmcHdBVWQ2VTRTaU1ta0QxRTIwSjFGTXhWV0xocjVURWlTaFFaRkJ0NUo3?=
 =?utf-8?B?bGIwOENYdkJibk95R2lEOExpaC9XMG0vem5tRGM4VExNVW03TVZkeG1LUzB0?=
 =?utf-8?B?dWRldTZYdjcxL2ZMempZSEllT3RMRGFZeGhSNWYrOTNQRWFTY1RkMWtvT1A3?=
 =?utf-8?B?ekt5dk5SYngyQlcwQ0JtMUFYRU9ZV0dOSGhZTVdZZnZmb01HalFUeExvWVdI?=
 =?utf-8?B?OHJNM2Mza3pMQThHWElub3p4Wk1lKy9kNU1FL1doRElncENvVGhYRlBnREp2?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bd9189-bd88-4595-6b0f-08dac1112171
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 22:40:54.7282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLKgOUTElc7XRJFQzNe4c2Rv0FcbajjuH1HJeBLypj2C5Uy+/cLTAk4DQOmjhzECV8ucc4buTJQR0pd35fpDtCkPL0EI8IPUJ2lPhr7IWv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5344
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng,

On 11/1/2022 2:43 AM, Shaopeng Tan wrote:
> After creating a child process with fork() in CAT test, if there is
> an error occurs or such as a SIGINT signal is received, the parent

I find the above hard to read. How about "..., if an error occurs or
a signal such as SIGINT is received, ..."

> process will be terminated immediately, but the child process will not
> be killed and also umount_resctrlfs() will not be called.
> 
> Add a signal handler like other tests to kill child process, umount
> resctrlfs, cleanup result files, etc. when an error occurs.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/cat_test.c | 28 +++++++++++++++-------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 

...

> @@ -201,7 +212,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  		    sizeof(pipe_message)) {
>  			close(pipefd[1]);
>  			perror("# failed signaling parent process");
> -			return errno;

It looks like pipefd[1] will be closed twice if the write() failed.

It does look strange to let the child continue to its infinite loop
after the write() failed. I assume that it is because the parent will
also be stuck and the new ctrl_handler() is expected to unblock both?
Could you please add a comment to the code to clarify this flow?

Thank you very much

Reinette

