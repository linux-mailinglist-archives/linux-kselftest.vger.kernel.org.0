Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F314ECAE1
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Mar 2022 19:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349399AbiC3RmO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Mar 2022 13:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349343AbiC3RmN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Mar 2022 13:42:13 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08305F4613;
        Wed, 30 Mar 2022 10:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648662028; x=1680198028;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9vowUBdRyVK5SAGLwF7bPrw0qm9UZ5a+X9Ovn8p3gE8=;
  b=NgEX86bJUtgaba3bjvaFIQ9zrX1th/8nJ8l8FPXaJrwTlG893QT+eVJh
   jfA3/izJkzhsXJ2Ry8k42z3kIJa0F5aDXr/U4KPpqYp64W4y7vL0SSV0f
   hOwN7VHojjJcKlFR9U5XDQfoJrU4JoHSs891ND3v5pi5+DfnrLMQVNkDu
   Kbl8v4G749un92S8Fd2ujdDMF1MxVft2Th8k7gKSuD7moWJ3jfU6jG646
   ube8F8Wo8+YQ9kkqRDJVnk4sYLnJn/x81D866oaS6e9vFYMWBW2orM+6q
   BlT3LAINd6RudssK7qB8JotRYkGCSl2CfRgeilnqnez+qnlaMjiVgBBhB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="258433998"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="258433998"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 10:40:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="649951769"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga002.fm.intel.com with ESMTP; 30 Mar 2022 10:40:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 30 Mar 2022 10:40:27 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 30 Mar 2022 10:40:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 30 Mar 2022 10:40:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 30 Mar 2022 10:40:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWKwuAj+OULQHj5mvjfM/olGqSMPMQsxv6xD5pcSwCx0dLY0tC2Jh3Jkb8XdmAlQa3/HA73XgwMc4ZrA6GoO1awqNMc9G/jVtWJ4XQqwXRkhK20Xb8lF8RYs0rWO5i43FIZMhgGo64fMZkvE1Zy7kE0+QO8CnevTbbkvjTV4GPbjDPK5n05GasOuu5XduziUtaUfhoO7k/B2FUGAnvv9mr09ETTQ6+AIKjMPj2jFhC7nT9kpue7lIb+GbZxHZdlGkU6RcGF0NuJMlCB+KPDLRgpkzsRUDxOPrLD8F8/+9fyrhfUSxh0xbos5bpycvDNIdUhreh37vK9exd5OS7GOXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzYGMK1s6YFkzlhUhnx93nDiqQYseloFz417R5lGlxU=;
 b=Fz4/LmuiLUwJubTQfGCULab0DUvClcrCb5GTtyK63/WgW/4hD6/beE7PCHDCI85hdjMVFhIfVJtxf3F5NGO/JxynuOkURRYKtrYQuC+pi9eNx1puNzQK+ec1MIgqkpDVhSwBPln845Qaqe1Mn16n/X/bgTT389l2LRxxGDZ5tyH2a08Q81f4gfChNEApgQWPvZlzu+oCsE5Cfxa42s8CqN7KiWbSWJHTiycOPQU1gvV95evlgtnt6sMtJ1xutjn8pGpqz7a1GWhmqruRmvng5Rw4ozoUk5YNQKdnJkadIzrIgaRH8R724hoNop5Mu1GCiJQXFqWEPgsBK+WpJ5UwvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB5740.namprd11.prod.outlook.com (2603:10b6:610:101::7)
 by DM6PR11MB4756.namprd11.prod.outlook.com (2603:10b6:5:2a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Wed, 30 Mar
 2022 17:40:23 +0000
Received: from CH0PR11MB5740.namprd11.prod.outlook.com
 ([fe80::5ca:aece:f36:c53f]) by CH0PR11MB5740.namprd11.prod.outlook.com
 ([fe80::5ca:aece:f36:c53f%3]) with mapi id 15.20.5123.019; Wed, 30 Mar 2022
 17:40:23 +0000
Message-ID: <0031a4f0-75f6-3104-1825-dcc2528f61b0@intel.com>
Date:   Wed, 30 Mar 2022 10:40:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] selftests/sgx: Use rip relative addressing for
 encl_stack
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Shuah Khan <skhan@linuxfoundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:INTEL SGX" <linux-sgx@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220322074313.7444-1-jarkko@kernel.org>
 <7b7732ec-c7ff-cf92-510f-64c83ed985cd@intel.com> <YkRvFkEO8Ic1VdQ8@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YkRvFkEO8Ic1VdQ8@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0312.namprd03.prod.outlook.com
 (2603:10b6:303:dd::17) To CH0PR11MB5740.namprd11.prod.outlook.com
 (2603:10b6:610:101::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c1f924c-7755-4718-45ce-08da12745e0f
X-MS-TrafficTypeDiagnostic: DM6PR11MB4756:EE_
X-Microsoft-Antispam-PRVS: <DM6PR11MB4756F8FEC39CA06137058192F81F9@DM6PR11MB4756.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +j1oMOECPBRnzFAin+sa1igRW/kOhzusf9SJA+a2Z/s9m7mbY36PsfGHT5RdWTUHMJVis3vyUmL1UlMqrdYwF4pzdzzRBK7T/h4INEWFXE4ufx3AWYVVNG4CkSo2GY5KuX5ieDEdHcn4oawD/VgBAMgESbztKlgxAKEPpeRZHa3SWao3sZx75Qab7bbHNv1LIjk6QhzOj38sxLp/1CtEWonJs6imrMAUk5Ehb6z3Mp4o/gg8Ms8iwD0RO/8p8vWAIsP7rK0wBV2dE9utgE0ZD4Rc9DNq/vt9P5kA/bgSunx3yTlJGE7ZI7IhXAOYavwhA/fS6+WvwCZ8KnRGxs89t9sbE5gEqzaSCQUOLiwPsqpIPM4DGWBX7rKxwJn4F1DEZV/chgWJzqoPzCJ+axuYk2XX8mvPC2Vzg7lMme+2kTWxYF9QwW5W5Oj9Jxc60TLxGj0IM+oGf4H57QwQ8+7lXmCzfpJYLyQ02HPtNZWJrNGeLHMrGSn+pMje2q2eYwf0Qn1TMPkR5G6gOElFm/uLWh1a4QfLagYr7WGWDq/1+VA/+c/TzMLxFxr0C43mi+M8mYTKAjMK/saQrIdnvmtpX2c+BmE4gIctyRsMdb/Qsaq8Ac8bLX/yunL+KNmnGyU7DMdx8jAFODkTXr+5fi5VF9+hbIeNTmSeRMGS9vUwbxY2frmy6NKXR/Ml+5s+D6NUcLrsaDcz1unMWWtacLDGiSFvkWcGM8W4+/Gazd0o7MBB1cWuAkGeFsGxAfn5brKVJLhAA8mxRU8g0mEEirhdkzY9iUeFIDqRjzmbfz8B2mN2KcmGu+fYNepkejTc30UD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5740.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(5660300002)(316002)(82960400001)(66476007)(54906003)(86362001)(6916009)(6666004)(36756003)(31686004)(31696002)(44832011)(8676002)(4326008)(508600001)(66946007)(966005)(66556008)(8936002)(6486002)(83380400001)(26005)(2616005)(186003)(53546011)(6506007)(2906002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djJuZ0FES1JLMDE3amE5L1hMUlJqMXJTK1k1ZzdYMFg5Y2ozbkY2UkhkQktp?=
 =?utf-8?B?b2pmYnFMYjF3NjZmR2srL0NXYW1IdHV2Ull5UHVobTZ2TUFMVi9CWXFOUFlD?=
 =?utf-8?B?Rm9MVkxNSGxOdytJVXB4N2JvQnAxdEYvekFXYi9YMGlPcGRFMkc2MS9raU5v?=
 =?utf-8?B?b3BQMFUzOGRpT0FxN2ZIR0lUVHNkZmJaV2paREQrSytSdWZodXJ5d2lZR2J1?=
 =?utf-8?B?OE1EVFVBWXUwODlRdkxBbUV3RWpGL3lQeit6VHNhUW5qWE0vbWl1Z3J0NmNY?=
 =?utf-8?B?S0VMd1ZhV00xeFhDYjQ2dlVCeVY4MFhJTmpOTnlzaDI3R1VUTzBjdFo3eFJX?=
 =?utf-8?B?aWVLZjFoUTQ0QWo0UGk3RUlmV1p1Mzc2THVhU3RsRVlDYXZIZlZsQzVnSW5M?=
 =?utf-8?B?b0ZsY2JxY1lHek45RGRKWWZwRHo4S1B2UHludVVwWjVTYkptWHgxREpoZ2tt?=
 =?utf-8?B?VVNPWUhBdlNuMXVhUk9DbW5KejJIaEVrT3VWeC9yalJVaGl1SUVEdGxpbUhG?=
 =?utf-8?B?V2dYbFFpeG9aTG4rUVlTdXFUeGs3ZDFwenZyWUQ5ZC94bXBPZHFvUjN5RTh2?=
 =?utf-8?B?Y29yMlZoQlR6N2tpQ2xQazVvYnlKTThrdjBJYW9zOHhZOFdhdFRlTzZTdzVw?=
 =?utf-8?B?UCs0MG5kalJkWjRSMjJ3c3U2emZhVDM3SHhGTDc0VXRNR3IyNUYvOW5VVGU5?=
 =?utf-8?B?V1dua09nMXNCa2o1RGFqYjlTVWhrYTJ6WVRmaERuSEpVa3owd1Fpc1J2MTFM?=
 =?utf-8?B?SWRydWFsN1BzTFo1OVBLclc2NGRCeUtiSU90WFhOYXhucGJtYWRBdzUvT0s1?=
 =?utf-8?B?dHhlYkNYc1ZQSGx6RDhiYTgzS2Y5SW42SGFXc3lIUDR6bGcrU1JOZEF2TkdB?=
 =?utf-8?B?Q3dpTG51TkZ0ZTQzSUFDOWVudnY2MHEvdFh1Zk1wNnFHTkJmQVlFaHNGNGpZ?=
 =?utf-8?B?czhJZGYvUitSN1VCTVhqNFgyNU9UWXFDM3prYlhrRnhWaEhuU1ZwOCtwRGlZ?=
 =?utf-8?B?TWx3VDVjSEdocFJVb0RRa0FraHgweHgrZURkNmVFNFd1YVlHRHFEL3hDMFY1?=
 =?utf-8?B?ak5SZDJlTUw4ZnNQNGdVZ002TGlOZitwbWUyRkFvV3dWb3lDYXVrUTZQMmJ1?=
 =?utf-8?B?ZmdsVzdVNk4zc1l3UmJlZnFXSFh6bEpJY3FzYlZVZ3hKRlEyaGhjelJDZER6?=
 =?utf-8?B?NC9IOUxlM0RUNHoxYVQ0VzJRTXZwNC9XU0FWYUUyY2NucHBMVzg3WUFmR1cy?=
 =?utf-8?B?SEk4UUpWYjNKdHloNE13MFNVUnNYK2UzMHBMNVNTeDMrQkFhUFJ2UmZFQkQw?=
 =?utf-8?B?MDZnK1NDNUd4YlpuUld5RENoOWlFSFoxbzVJWEhJZm1XaklXSHp6Q3U0L2gv?=
 =?utf-8?B?aS9wd3czOGx6Nk40aXpvRkVtM3VibkF0clBSSSthMlZJZ2M2dnI4WUU5TzFR?=
 =?utf-8?B?MER6alN2NHFFM0o3RXAwZExFU3FhNG0rbFg5dXBzMVlySFZ4Qk5Zbm95NS94?=
 =?utf-8?B?TlZ4RmhKZzIraFoxcEQwQmtma0gyRENHMHhmMDlwR0dHQU9xNEVsZFdCUm5I?=
 =?utf-8?B?Q1ZUMXd3TTJKR1ZHMkVnbTE0TTVlbHVidDRLbkdFVExuNlhFUC9GNUREWHhw?=
 =?utf-8?B?WXg3Q0dTdDVUSUNtNy9DcG5sVVVlYXFRdHptZ2l2SlBYR2hPcVk0emI5Q3JI?=
 =?utf-8?B?VlNXUUxIUlVyNlIrTWJSR2FjeU0xb2hLWWV0MEVHa0xEaWdTV2N3bUlVZ2lv?=
 =?utf-8?B?VEh1dlQydklwY3hxYmwrZktZeW5HNmhTbXl1K1VSaEQvRWsrQ3UwcEV1QmNJ?=
 =?utf-8?B?aWNEWVBZQ0RNSUI4eEdnRzBySWxOL1YrRXY5RFZqcE83RWJHUXNzbDRHMGlh?=
 =?utf-8?B?MXZGZFJTN0VkemNlWFdFMEZqdFRsTUZYU0dMRW9HM0NkUTk4QXdUYTJ2bUxK?=
 =?utf-8?B?b0J2MFlqV3JndStTTElHN2lKR1ZROStYNExIcVhwLy9oVnNIR0l0b2ZRTWdR?=
 =?utf-8?B?Q2hXWC8ya2FYc1NFL3FqRWp0R3ROSSt6V1F4ZUcrNHJHRXB5VUlYeFZwQTFu?=
 =?utf-8?B?dS9YNFRjZkZuUGhmVU0wQm5FM1dFL2pkcHE3TGxSak93TzlnUGRoclNyZFMz?=
 =?utf-8?B?TjJuK3UyQllROTkwRFBhaUhYSHBVZTJTdWdTa29IVkFlWHJmS3VLNzFDbWdj?=
 =?utf-8?B?VTk0OXRad1dGYlJJaTNGQ1ZxZWwvVFFkZFl3Tk4ySndTSCt6VUhoSXljcDFE?=
 =?utf-8?B?bHZiT25UcHNHb2QrUW83SUNBeUtrTGFhM256Uk53YisyZHRicWRVUUJ0NVVi?=
 =?utf-8?B?dlRtbHduaU1lMVB0MXNRUHJuc0ovRFE1YzY1bEFKMWpaVGhaQnMwczNHdml1?=
 =?utf-8?Q?YrRbbCkIAK2oDDSE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1f924c-7755-4718-45ce-08da12745e0f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5740.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 17:40:23.4755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 80ION2YnLod4vmipuoob1k4vP3Z8QEkgEH9blz2Yjwf0loasCjQHTF7h5mA/fMkaQJwnGLrQ3rTqIleKdmbfVruYgaYNx1AJPMnFmqvTzuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4756
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 3/30/2022 7:54 AM, Jarkko Sakkinen wrote:
> On Mon, Mar 28, 2022 at 02:49:04PM -0700, Reinette Chatre wrote:
>> Hi Jarkko,
>>
>> On 3/22/2022 12:43 AM, Jarkko Sakkinen wrote:
>>> Simplify the test_encl_bootstrap.S flow by using rip-relative addressing.
>>> Compiler does the right thing here, and this removes dependency on where
>>> TCS entries need to be located in the binary, i.e. allows the binary layout
>>> changed freely in the future.
>>>
>>> Cc: Reinette Chatre <reinette.chatre@intel.com>
>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>>> ---
>>>  tools/testing/selftests/sgx/test_encl_bootstrap.S | 6 +-----
>>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/testing/selftests/sgx/test_encl_bootstrap.S
>>> index 82fb0dfcbd23..1c1b5c6c4ffe 100644
>>> --- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
>>> +++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
>>> @@ -40,11 +40,7 @@
>>>  	.text
>>>  
>>>  encl_entry:
>>> -	# RBX contains the base address for TCS, which is the first address
>>> -	# inside the enclave for TCS #1 and one page into the enclave for
>>> -	# TCS #2. By adding the value of encl_stack to it, we get
>>> -	# the absolute address for the stack.
>>> -	lea	(encl_stack)(%rbx), %rax
>>> +	lea	(encl_stack)(%rip), %rax
>>>  	xchg	%rsp, %rax
>>>  	push	%rax
>>>  
>>
>> The goal of the above snippet is to set RSP to ensure that each thread has its own stack.
>>
>> Since EENTER computes RIP as EnclaveBase + TCS.OENTRY, by using offset from RIP this
>> would result in all TCS with OENTRY of encl_entry to use the same stack, no?
>>
>> Could you please consider the following as an alternative:
>> https://lore.kernel.org/lkml/65c137c875bd4da675eaba35316ff43d7cfd52f8.1644274683.git.reinette.chatre@intel.com/
>>
>> The idea in that patch is that a new TCS would always need to be accompanied by a
>> dedicated stack so, at least for testing purposes, the TCS and stack can be dynamically
>> allocated together with the TCS page following its stack.  This seems much simpler
>> to me and also makes the following patch unnecessary.
> 
> There's no better alternative than use rip. Compiler will fix it up.

Could you please elaborate how the compiler will fix it up?

> 
> So, no, I won't consider that. This a dead obvious change.

It is not obvious to me so I attempted to make it obvious by writing a test program that
prints RSP from the two different threads.

test_encl_bootstrap.S gives each thread, TCS #1 and TCS #2, a page of stack.
Before your patch, with the test below printing RSP, this is clear ... the stack used by the
two threads are one page apart:
#  RUN           enclave.tcs_entry ...
rsp TCS #1 = 0X7FD997D97F68
rsp TCS #2 = 0X7FD997D98F68
#            OK  enclave.tcs_entry

After applying this patch both threads use the same stack memory:
#  RUN           enclave.tcs_entry ...
rsp TCS #1 = 0X7FCF778B7F68
rsp TCS #2 = 0X7FCF778B7F68
#            OK  enclave.tcs_entry

Here is the test I used:

diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selftests/sgx/defines.h
index d8587c971941..08b2765dc2f4 100644
--- a/tools/testing/selftests/sgx/defines.h
+++ b/tools/testing/selftests/sgx/defines.h
@@ -27,6 +27,7 @@ enum encl_op_type {
 	ENCL_OP_EACCEPT,
 	ENCL_OP_EMODPE,
 	ENCL_OP_INIT_TCS_PAGE,
+	ENCL_OP_GET_RSP,
 	ENCL_OP_MAX,
 };
 
@@ -76,4 +77,10 @@ struct encl_op_init_tcs_page {
 	uint64_t entry;
 };
 
+struct encl_op_rsp {
+	struct encl_op_header header;
+	uint64_t ret;
+};
+
+
 #endif /* DEFINES_H */
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index a7543e5561a9..2380944dce71 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -570,12 +573,14 @@ TEST_F(enclave, clobbered_vdso_and_user_function)
 /*
  * Sanity check that it is possible to enter either of the two hardcoded TCS
  */
 TEST_F(enclave, tcs_entry)
 {
 	struct encl_op_header op;
+	struct encl_op_rsp rsp_op;
 
 	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
 
@@ -591,6 +596,17 @@ TEST_F(enclave, tcs_entry)
 	EXPECT_EQ(self->run.exception_error_code, 0);
 	EXPECT_EQ(self->run.exception_addr, 0);
 
+	rsp_op.ret = 0;
+	rsp_op.header.type = ENCL_OP_GET_RSP;
+
+	EXPECT_EQ(ENCL_CALL(&rsp_op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+	printf("rsp TCS #1 = 0X%lX \n", rsp_op.ret);
+
 	/* Move to the next TCS. */
 	self->run.tcs = self->encl.encl_base + PAGE_SIZE;
 
@@ -600,6 +616,17 @@ TEST_F(enclave, tcs_entry)
 	EXPECT_EQ(self->run.exception_vector, 0);
 	EXPECT_EQ(self->run.exception_error_code, 0);
 	EXPECT_EQ(self->run.exception_addr, 0);
+	rsp_op.ret = 0;
+	rsp_op.header.type = ENCL_OP_GET_RSP;
+
+	EXPECT_EQ(ENCL_CALL(&rsp_op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+	printf("rsp TCS #2 = 0X%lX \n", rsp_op.ret);
+
 }
 
 /*
diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index c0d6397295e3..b2a94a6d754e 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -119,6 +119,17 @@ static void do_encl_op_nop(void *_op)
 
 }
 
+static void do_get_rsp(void *_op)
+{
+	struct encl_op_rsp *op = _op;
+	uint64_t rsp;
+
+	asm volatile("mov %%rsp, %0 \n": "=r"(rsp) ::);
+
+	op->ret = rsp;
+
+}
+
 void encl_body(void *rdi,  void *rsi)
 {
 	const void (*encl_op_array[ENCL_OP_MAX])(void *) = {
@@ -130,6 +141,7 @@ void encl_body(void *rdi,  void *rsi)
 		do_encl_eaccept,
 		do_encl_emodpe,
 		do_encl_init_tcs_page,
+		do_get_rsp,
 	};
 
 	struct encl_op_header *op = (struct encl_op_header *)rdi;

