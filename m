Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDCA5E69D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Sep 2022 19:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiIVRr1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Sep 2022 13:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiIVRr0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Sep 2022 13:47:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFD5F961C;
        Thu, 22 Sep 2022 10:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663868844; x=1695404844;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=idn8ZJHSyHTt7YuUYZSK4kSG4XA4PFVRxA+/yKK48tQ=;
  b=C+2ST2rn9GmWQzszucMlHQl+XNohd9yTUVdtXvTFwvs+ix9vQ5+XN+EA
   p5VY4sA9cBDKI2jVcS0vlZ/wlIXSAvaEGaqmc4FeuoIjmuOkaSZRtViT2
   P1OERRTa1FaAtdtXTyWFbWkqvFushUbpLnvhE/4tVxbBuOS/2bxuzVLVx
   G1GoFX6K8WC5PMpe3X8tQlx5lVpbXy+f/36ASPSuoWo7QfkBHfh4tdLdX
   cNO5bUMqdMTT2dpJcbCeeDClJtQBMjuEeOe7JLTw5E1nmnzzJGCUGAv7Q
   DRiOE3NZYF4HHynjJOJR4DXhBqtjJCYW+l+7/CniAv22n5Nb8sdMhm+KK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="299092796"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="299092796"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 10:47:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="708976510"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Sep 2022 10:47:19 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 10:47:18 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 10:47:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 22 Sep 2022 10:47:18 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 22 Sep 2022 10:47:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxLiNOQZbF0AMumTnHEma7QdPvJPBI84WHLbE9sFGvL/5EsoHl51v2xhF+RSj5IcGWEkMG9CIYinWy7gKJ2D0XYbkRqMeu1xRalfE34gHSu8T4vlnfh/wtk1MGHioR5CzL1J4QLDXOWPBXR8L/bVH7b3dhotMu30T2WKA7WwJVNUvWwOgSKmjVjBMG98CQzxAsyjBVpzgXjRxS3zrZvUzKZB7GoSKteiHnMtwK/Aa1sYfJbRI+D+o0ob3BKxT/HHEB32jzJgwbOKW2DSJi2aRcnRiu6oYOVrs5bpejoEjwQNFtW2E4eVtPGXcpn0oM1EpIcHAjp3Xy8HeUFDAYrf7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pR0qoHigdgl0e2ZuoCQi4gHOaYK0IOWg0XcvXBbVqSM=;
 b=BLcADB/jRag2JSRRtd4DWLcaz7A8CwTINGXzQ0AJnM7e7gy7Ja/kmWZ1y0EG5Zp88RwcxSY7sluKmgjPIrrkVyqH3k/oA2OnSIkGcQiqKcZHcxPA1ufgjMdEoPj1qOky/KR5BxNhZLdbDY9BWQUyjCcH5ecZ+5fV6FAhVnpwVgc9F6ougMbIVq2gs/GL8/oTdLWgPQQlrv17u6EbBDF1Ccw7YZYXf3X3JBDOPd3Q/hNiQk+inzqWOdNYyFrcDEKvuaatfuq+H2whImFiPQNEr+6xbileu6AiI1sTjspTkzuKqffxIJRoKxfU7IrnLk37t08cMr3o32WaSx3yfa7Gcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA0PR11MB4670.namprd11.prod.outlook.com (2603:10b6:806:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 17:47:17 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%11]) with mapi id 15.20.5654.016; Thu, 22 Sep
 2022 17:47:16 +0000
Message-ID: <9094c887-afbc-98b5-33eb-f448ea8ee4ba@intel.com>
Date:   Thu, 22 Sep 2022 10:47:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH 4/5] selftests/resctrl: Kill the child process before
 exiting the parent process if an exception occurs
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com>
 <20220914015147.3071025-6-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220914015147.3071025-6-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::13) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SA0PR11MB4670:EE_
X-MS-Office365-Filtering-Correlation-Id: 134ed2b2-0a11-4074-31bc-08da9cc27d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lIjIm5uIE8CD4VnWC67/YGi4Z/ZQRpTn9uQtrLnb1BLpIw7EtDljDfZw37R4ds08ggY7nMs8kRxs3D1U1LYaP9uoGmrC2kJWQXGdRRv0nkkhI1rFdXbu4Lzoj5wiBItD0lu9jv8c926+o1+5XAH7D2VGnalzEExdcK38Z10am0xVCq0i7za7l6EQeDy4JrweYPVfyBJViZO7EJv0pDmmZypkAmTPUrTLGffNKUB1We4rv0SC4ncc2DJaRq15SLphk88t64Q4eOsJsoYV0Cf3kp6JfYOfidc8zmwyEoBQSvIZ0Wqq5fI++Ghs23zbmA8GU/ggQS0Tv0HSGuhlaFDYBE47h/rw1UggyXmKRngPEvE/N19lFgANoxlKZoiw1ByZ7wYEH8M/haMrYd/+lbxylYG7JYwyatRGGzPZ3UjyhjTnO2Xm6IJGB07FGbBmdkwl34hsKwxfSxgYMURogK+T7ACICF8xoaaZNuKh5wsH/DOUi3pG7T9/wmu3S1L9nDpfuW2y1QelU9xCqdaGRQvOJQN2/mEh7JRDyl9OBw1we0lzqmpNZ/2CX2ENQ3PaRRZq6hnp7bqPAUOgtre0n7ORt+zkj0FwftJyZGO3bmN+i0HETxMGx/MWozBSY6g83HL/f7qWjQsxIh0yTbOSIY4jpfD4llNc0BL9d23dYBx/TfAXEdCkHQ1P2Mutfq7oXBuSUMKyWBE1wt7cPnpQ6WErgOMV5WC/Cz3HCGYV6n28UFs8ethqay2YMxrW9AeON+rHHqPkkemKtB/hGbtp27en/2/Ev2pzYcIUPNhLIr/aYco=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199015)(6506007)(36756003)(53546011)(26005)(31686004)(6512007)(66476007)(66556008)(86362001)(110136005)(66946007)(4326008)(8676002)(41300700001)(82960400001)(83380400001)(6486002)(186003)(478600001)(5660300002)(8936002)(31696002)(2616005)(38100700002)(316002)(2906002)(44832011)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajk4OWRZdmZuZEN6NWpicUpLMnJxZlN2R3lUQzd4Sll6TXdWZjRTaE5wakJ4?=
 =?utf-8?B?N2Q2cS9HQS83WjBYM1Rpdm9TRVY3SjUyVU45TjZNTHEzenpPbURpNmU4S3Rl?=
 =?utf-8?B?VlZnUnZkNEFrclk4Q3NnTUc5c0xRLzJidW0xa1JEN1FrUU1HLzlHSWlKTVow?=
 =?utf-8?B?R2VITS9nRXk2V3A4M1k3TjhSWDN0VVRaY29zdFR0RmxYSWpJd0pMcHBRdFd1?=
 =?utf-8?B?ZGRseEcrUGlLKzdJS3JkOU5FanZqeWpyQ3U1K01lTjZ1dzZVMmNubHFJbUV2?=
 =?utf-8?B?SjdZZmZDYVZiNzVOYUtyRW1TSGhDVlJiSC9RdDM4cDNINUZyN0lqbDcvSExj?=
 =?utf-8?B?YnFQM3dxT1gwM0x5RG5NVEdEMUl6NXlETzE5NDJJRUgva084K0JzK1M5Mmxr?=
 =?utf-8?B?eUxOLzlkdnEyVWlSNTJYTUkxRlNTZmc0aXhSYXhrSDZJL3oyZmtEZkkwRUtE?=
 =?utf-8?B?dXBFRlRYUTByT3J3QnB3Z2UvOFBwaytlaUtnSnV6LzVvT1JCaFg1UExTMkpm?=
 =?utf-8?B?M0lyR1JNYkg2cFdZNkEwYWFvbkJ3bXVpQmh6a2NncjZxb0xETDZRVnRJMmdR?=
 =?utf-8?B?Sm5wOFJPWk1XekRjZ2xTZGQ0VVp6dXMzdS9LeVFGNEp3QS9JbmpNc3M1QTVJ?=
 =?utf-8?B?ZDA2L3ZnM2wvNE42K3FJbkdXelhGV0Eza3BUZGFuK0l0dXpWZWxDdUNWc0Q5?=
 =?utf-8?B?eFU0SVpMdGNXTmFGV1BSL0lUQUZGRm5xYUFuUjhzQmZBMUVGODl5aS9NeFdm?=
 =?utf-8?B?NExZMUhscVl2eFlud28wS0s5SjdRaVRDQVFtc0k0T2VxU01tRDhrbFo2QVRm?=
 =?utf-8?B?c1EvV25SSk9OOGUxRktsSTF0M1hXOHZVMDVSYkxNL05LY3lCSTJIREo1R3NM?=
 =?utf-8?B?NUNnWFA4Z2pNcjN1WGRzemRuNGgzQ0M4d2FYd3dCTVZ0MnhkVFpyUmdzNU1O?=
 =?utf-8?B?Tk5aYnF4SGNlaUduY3ZYZXlFaWpYWEJYRi83UTA2dHM3WmpMcFNLM25TWE1r?=
 =?utf-8?B?bm5vc0VLaUY5ZXVzMDlud2lSWlllb3c1ZzhYWHR0VkZVTEhPbjlxYk1nMkpR?=
 =?utf-8?B?Qm9FdTA1bmlMQlFSY2JHNkJ2cWtzSlBBdm05QTVEQXYxL2xHc2Frak80Nkt3?=
 =?utf-8?B?NEllTllReE9zMDJDZWM2aW9ScTM0bzBFZmdxblEzRTFFeStLbkhzdC8zZDRk?=
 =?utf-8?B?bnk1T2FGU3Z0R04wcDdRNXJnU2VIeU9KVS9qVHlpOFE4UEpJL3VNdWFrY3Fo?=
 =?utf-8?B?YjNrNE16T3A3VStlTjdYMVUzRTZ0M1BZb3craHVyUWk1cWdqTEIxY00zV0tm?=
 =?utf-8?B?aWVYdjFmczNRUEgvUUFNNG53aW1iS2lCdG9sZEwxNEQ3b25WSkRuTVg1cGtE?=
 =?utf-8?B?SDE4Yjh6RTlsdmQrczE3NURxdnZMbDZWVjlSYmVrVi8zK3Q4MS9HOEhwd2JZ?=
 =?utf-8?B?SVpnVUU2MXBWblAzNFNqU3JKcDVWN2Vsc0RvdDZQcTgzamt1V3laWHRnSGZz?=
 =?utf-8?B?eTlwcUtzTjFLNkdmaXFHVnZJbjVFQTVXTFlOeExzcXBHUDkvUzF4c3IvZVZS?=
 =?utf-8?B?Q0dOb0hrNmZXVEZWbS9nMHJtSW1NQ29YZk9qN3NneU42VUFWQlNvNk9iaTlW?=
 =?utf-8?B?dEdreGg2RTZLSVlFMzJHV1UwRWxiMEMrRkpLb0szYjIxbGtUa2hPSDVjWnVH?=
 =?utf-8?B?cVkwNWFHMWNpTjZDV2dyL2hETVBqbFJkZ0JJc1dHVzRXYjh4VzhzZ2ljNXlC?=
 =?utf-8?B?MjMvR0pLS29MSDFGa3h0RlgvNVJRcDJlOW85RG9HeHd0T1hVcTdNQkJ3RWoz?=
 =?utf-8?B?TmQ3dThhZWZKSnBSOFBpMXNESU9BdnZpd0NqUCt2TTJ1a0VFeGl4VmF5K0ZB?=
 =?utf-8?B?L2JQUk50bndQYmtUVmhibnVsQ3V4WUw5bGg1ZEQwM0RIWHI5WlZJQUVqcjla?=
 =?utf-8?B?c2oydDRkNFVIOE9DUHNCUlZEWXRVaFlTL2tNaFBWeWJsVDloRjEwMGZGWXY3?=
 =?utf-8?B?a05BQVVGUkFkbTJaSU8vOXBFUDJMNHhqQ0tDMWhqZkJ5RzhEV3JPVnhpM2Q2?=
 =?utf-8?B?c2lHRmM0Q1VWRVVsYWZwNlBNUEhBY3g5dnJveGJQdzFTOXAyaE9TVVhZdXR1?=
 =?utf-8?B?Y2VSbHhmZkxnZTVCWTRyV1ZUeXJzeitZQVZTK3N3Z0JyOGFwVVF2UnFYMkRl?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 134ed2b2-0a11-4074-31bc-08da9cc27d52
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 17:47:16.8817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJGMiq0Seh+hj7dgzKdURzE8aZRWv6VXTb6SFQughGlwjitxerAH/u8v0wPmVp9t/YIx/Z5+apZfmJbHuNx2sXs0D5BO0Q+2DqKG+MF3vkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4670
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng,

On 9/13/2022 6:51 PM, Shaopeng Tan wrote:

...

> @@ -218,11 +219,11 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  			}
>  		}
>  		close(pipefd[0]);
> -		kill(bm_pid, SIGKILL);
>  	}
>  
> -	if (bm_pid)
> -		umount_resctrlfs();
> +out:
> +	kill(bm_pid, SIGKILL);
> +	umount_resctrlfs();
>  

From what I can tell both parent and child will now run this code. So
both will attempt to unmount resctrl fs and the child will attempt
to kill PID 0?

Reinette
