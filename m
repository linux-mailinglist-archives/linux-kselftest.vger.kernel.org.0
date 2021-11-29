Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24DC462082
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Nov 2021 20:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349788AbhK2TdY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Nov 2021 14:33:24 -0500
Received: from mga18.intel.com ([134.134.136.126]:34654 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352182AbhK2TbY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Nov 2021 14:31:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="222941747"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="222941747"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 11:27:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="743883242"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga006.fm.intel.com with ESMTP; 29 Nov 2021 11:27:27 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 11:27:26 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 11:27:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 29 Nov 2021 11:27:26 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 29 Nov 2021 11:27:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuMVCtMKz8ksKzRV4tmSNBrJamsKTqgDFBOopGvsA10igGQmh+iuuElLFJXaFYuFBRROCxCiI1OFMX1tjQVl+Cdt4N+g1GiZWYkXKDjT2Vv+YJd0JNsUJ3IdRkxVCW784g09YLjgNyEOxYjJWIwVt3M8cuto0a7TUnFN9sw1NgOpeuPppMsUhoEhch3dQR8IHD3dkvnOylW99i0rumngumtitXpsbIPMYy6n2BxZuUrNACTrIBGtw9VtGEhP+YmE6Gt9e+YJPGBb1T8ZTTJDBWiw6Q1ROZ272XwX6ZAZIZ6CukyDO45aN2UHytWKunwUMUeGz2PMGWjz8QBRiaBDiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkAVd5LIi7uwyMTtlnESWgGjJ9Z8a26IMrE+btTT9OA=;
 b=cAqOIk6txP5Tjh86vAxeFakTGqaufMxeGppR8Zgj6igGCPw52jLsP0w1U1l4BsSHpvf+o4hQw1MyADZRuEa5LX1In0CqPihVcwGgFc8ScUdOLBoAK/YlnWi02O2L02J/J+0a3aEpLPTS+hgHNcRvNJ1TaRpht6t9LKEUuKo3rL5q0VJICS/wh4O+5woM8yg4kZj0/YWsgcLP47WrY0wpmSjxbpOzjKGnorZ2ODa3c3jFNQS0J6HR1U05ltdze42xef+Ubh4BIr1oN2GHwuuHzwg8ZwV5vo2iqODJZDtPIYmrNr4iDdcNUIf+RIayUI7EKLKDEzGSUCc52Gpkyx0vWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkAVd5LIi7uwyMTtlnESWgGjJ9Z8a26IMrE+btTT9OA=;
 b=usOfu/CfJsMNU4T/OnxgudZ4LYmKJ/7JfTQjKwK0Hcz0sT3tTWwtzb6MGUkfqONvjQ33o8xkXKyedX3LoRcRGFdVuo9h7yXu/D6BCOdzeAu+jhsZNYU0EM9d86f0LQK/ufXbkAijO3KNhVGIhHhjt96wvGy+lmvTavE1He8yDQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1844.namprd11.prod.outlook.com (2603:10b6:404:103::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 19:27:25 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4734.023; Mon, 29 Nov 2021
 19:27:25 +0000
Message-ID: <6b9ed425-cadb-15df-4c4f-eb1dc0b814dd@intel.com>
Date:   Mon, 29 Nov 2021 11:27:21 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH 2/3] selftests/resctrl: Return KSFT_SKIP(4) if resctrl
 filessystem is not supported or resctrl is not run as root
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20211110093315.3219191-1-tan.shaopeng@jp.fujitsu.com>
 <20211110093315.3219191-3-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20211110093315.3219191-3-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:303:b4::9) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW4PR03CA0244.namprd03.prod.outlook.com (2603:10b6:303:b4::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Mon, 29 Nov 2021 19:27:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 862bfa35-21d6-4dd3-da85-08d9b36e45e2
X-MS-TrafficTypeDiagnostic: BN6PR11MB1844:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB1844C255953836DFFA0763EFF8669@BN6PR11MB1844.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uSzSU5y27zjT1a6foZpxLwArp7e8042HHE3iDzbsA8tzM+Lh4zuBPErwVPl53xMF5A44IBT/bSvtoRY91cQv7rufYv6bfDDHW2sBoCca84mhVAK+/eCP+fpu7RRFt8sYkFo/rCfS3CgmH5s2kxp58wXVLWN22gzhhvfRosTa7UqHy6dndp8zzwI/tNitbNtsQhlgbcbkybFPedbVgAWFI9WXuepS+cDDNkzHd57fPw4PvWcjdiMsHVg+aE+t0DgbPjC3xe6AyOscomVM2T96Sa+gioS2d+mMe35vYIEYWkjit3aNKJwcri2RzFXMX8cq0qi+nozd62RaMit4vB/qC/DdZLDs2mnxlBsm14hSll5mfglP1cO12s7+b+dq1ZkqHwkDTFdzLLeaU7jA78kpujuvLEGqqSNT4TDJV9JG3orIVf/VUDTx2BpTZxfeV7CcZPGKGGXXp/WpWnzrAW2c7VoHM3tAQ90t0CKCRkmzp32xGDFLXEd0WNltpeBBojQ4H4C4ESgcnK/EnTEIGmCod7Y99Rlj5t2fz72KLhjzk0mnHmHAZK+HhiERiaf3bCMA4mZDKBSm9CN+NXTI4yvvorDRjyDd6mEHDt4szXYcxHDdAv8pvbCr1JTehYVF9OTpRbd/s+H+ZyshaEAZaYWDV8Kmi6PbKgk4M3dBNLC/8jcsbFXBuo6EWIPqCun2pxdq2QYrhrFAjDUSiipbDX2qFig6q5SIzQnR6a7yo3QOyxA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(5660300002)(31696002)(8676002)(2906002)(508600001)(82960400001)(86362001)(4744005)(38100700002)(6666004)(36756003)(83380400001)(110136005)(316002)(16576012)(31686004)(44832011)(26005)(186003)(2616005)(66476007)(66946007)(6486002)(53546011)(66556008)(956004)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTNPMG1XWVY5YlpEdHhDNytsWDI4SkV3Tzh2SmdBRWxqS2Y3SkNwUlBrTW9z?=
 =?utf-8?B?eklLMnpOMUM3MkVBRndrNXBEN2ZSejZUZlZkVzIrZjlpMVNsUnBrd1pYVjRj?=
 =?utf-8?B?TklTSExXVTZZZlZKZkNYeWN3VHluYWFGeEpPU3grWmNCeDNvb3pWN0NWNEhy?=
 =?utf-8?B?ZDlxdFJUS3MvWHpvZTF0TEFMbHhHK2tQbUl0ZWZxUko5YVRvYVA5TFF4UmtY?=
 =?utf-8?B?YTlkcWNHMmcvZzQzajRZU3U4azUveTRZS3VQek5KcG8va3J2ZFF5cDZodHNt?=
 =?utf-8?B?U3kzNFhOY3dDY0Nqckt0K0JnaWFVT3dzWEYyWW1BUUN4L09BU25rNS9uVEZu?=
 =?utf-8?B?enRPVnEwVnRWTSt6TEFSZmJuMFNUVmlZbE9OUngvb0E3eEJMM2N0QTJjNE0y?=
 =?utf-8?B?dUl1RDNjblZQZi9NRkN6ek13aFJjOU85QmNXbXFXV3d5eGxuYTdnQ3dmQVAy?=
 =?utf-8?B?WFAyMEU3WldOaWZtWC9yeW9OMDBQd0g0OHdLTHR5V1MwaFl0dlRQdHRGUTl0?=
 =?utf-8?B?QStUSjFxb0NocVg5NlFUa0Q4S2hQczdxeTBWcUkwOERmWE5Qb1VKNWpuWEdN?=
 =?utf-8?B?UGZZbGYzUTJBSC92bmpTL0ppOE11SEVDZ1VUZXZ2YTBPUG9JKzA2dEFJZWcz?=
 =?utf-8?B?cWNVaUlsRW5iSEJUeFVoT1ZjVXgzWUpGVldGcVhDbG8zSUtwbjZpSld4ekJK?=
 =?utf-8?B?RTNVS1d2REdFSVJNdCswZHhRVTRsWVQxcjNEVEtPL3ViV01kd2wzL0pTTVlx?=
 =?utf-8?B?NUZqWVZIVmphVm5MVjA4bHlOTnFuK21VZ1FPeUNCZ1lyN2VHTE8wcllBdFJr?=
 =?utf-8?B?U1Rrd29kNTRZQkdyemtoOWVpWE9EN1BrNzQ4NnJlSEowaVo3enZiNEtkMHgv?=
 =?utf-8?B?emtTMERkV2ZocDZvd3hnYjExd0J1cnRGYVNrbDk4UUFPa2xhcWxnMjB3K2kw?=
 =?utf-8?B?Z1hXQnFIenRSSmM3UmVpTzFNUU9HeXB5S3gyRU5OODdUTTJ1VDYramppeHZN?=
 =?utf-8?B?eVExNXQwU3RwL2hQRy9LUUJQMk5EY2l6U1R0YzliRDRQSTVhbXpyMXRvdVZG?=
 =?utf-8?B?dEF0S2tDbDBudm8xaWJiUVcraFhnU3crcmpCN2VibDlKZU1nOGpSblAzR3pB?=
 =?utf-8?B?V09teXJhd0hseVBUZmdkdnhQVTdPZHoyaFpWMFhTc0ZobThGTW5XV1A2VS9S?=
 =?utf-8?B?Qmt1SnlCZTNSL0R4Z1EwVlU4MC9EOWl3ZEw0SXVYZENhaElKM0M2SHVVYk1y?=
 =?utf-8?B?R0xNYjBmSkRMS3JpVVE0b2JGQ0lMNzJ5bTZDSHdTbE1BRjlVQkdOOU5yT3c1?=
 =?utf-8?B?TUpSbTJXcjkvWWF5WXhWZk9SejM2VWI1TmpmdTUwVU16TzVNZjdXV214RUYr?=
 =?utf-8?B?dHJzREVxVWdOWXdiWWRuaDAwQmt2TTlnVDY4WlF3bW0wUHJmblVNdHZoMEpW?=
 =?utf-8?B?S2VSd0xaaVRBSWxKb3k0LzBiSmJObExtajNVNjZZa01SdHZEWWNEdVBZbDhy?=
 =?utf-8?B?WjlFZ3lGVnhpLzRVMlBvanR3NHBYK3Vka21OU2dRbjZaL1RXL1dqbmxFY3Ux?=
 =?utf-8?B?VmJqblBtMzJwbVBDaUtpM05rUEdJdHRvNkVydXZRdUQ1djRnL000WjJMdXJY?=
 =?utf-8?B?dEcvNFZicUZHMElNSWJWZ2hGV0ZINVlFcHZTamdRcDNySUF0UVFHVFY4S1p4?=
 =?utf-8?B?Smo0cmJaZm1zTEdMaGttYTc0M2Fya05VOGkvTGcrZXR3TG15VlhiSjljcXJE?=
 =?utf-8?B?V1BMWXFTQkpBekovRmt2S2VVYU5VaStyRnM4YjNvNmk0RUMzNWRhRWFzMFJt?=
 =?utf-8?B?WHdEZWtJRldvTHJwSDRYSE5VQ210T29FZFJqM3p6b3Vqa05yOG01WUZWMktE?=
 =?utf-8?B?aHBkajlYbU4wblh4MUcyekppbkNFMkc5R3AvTUJPcE5TMlI2ZitkT2k1bHdw?=
 =?utf-8?B?ODNrWnN3QUZCVkt2NFUwcWUxVURwcmY1b1Aza2xGWkVROVEwemtVb20vaVp5?=
 =?utf-8?B?VnNyejZXekVLMFhXOVBNaUZqcit2bDgxTm0ydngvK01meXJNeE9JY3lnRTJL?=
 =?utf-8?B?dnZlMFJnMUhQMGQyaThlc1BaRDIrK1l1bUZndFNva0RGOG1rY0gvMDErMUp1?=
 =?utf-8?B?Q2xaZ3hPZUpaMnZoanBKT2x6YVBZWVZLbStRbVMreUQ0OGRmWGV4ak9zNDVz?=
 =?utf-8?B?RHo4Wjd4OHFmcXdEbnRxYU8waG1QYzhuMXlaYjNKQ0hRT1lPT0xSQlFaTlg1?=
 =?utf-8?B?MjBWRDhLQmVNb0dDMmxaQ2crbnlBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 862bfa35-21d6-4dd3-da85-08d9b36e45e2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 19:27:25.2075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mwwL4Br0f0VQCLngHPTVguIl4MXdAEM7HuRppJQkAmuhWOGEAdkIRjzjNr9OnFPLYtldM5iMyvzJpMNJtjemnJPHwDOwP5+Xvz96TY4U6u0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1844
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng Tan,

(subject line and commit message: filessystem -> file system)

On 11/10/2021 1:33 AM, Shaopeng Tan wrote:
> From: "Tan, Shaopeng" <tan.shaopeng@jp.fujitsu.com>
> 
> To unify the return code of resctrl_tests with the return code of
> selftest set, return KSFT_SKIP (4) if resctrl filessystem is not
> supported or resctrl is not run as root.

Could you please elaborate how changing ksft_exit_fail_msg() to 
ksft_exit_skip() accomplishes the goal of unifying the return code? 
What is wrong with using ksft_exit_fail_msg()?

Reinette
