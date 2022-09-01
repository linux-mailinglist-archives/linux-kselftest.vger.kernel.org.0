Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205655AA385
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Sep 2022 01:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbiIAXMa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 19:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbiIAXM2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 19:12:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B754579683;
        Thu,  1 Sep 2022 16:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662073947; x=1693609947;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uELS70Kdovd4hkJeQ7QT694mUE9RPJl9ziG/RHCoL3I=;
  b=HN/sS9M0LYMlkGHJKpS104tjelqvYDJ+g37yCSAjQk3rr5uPt2eLg2p3
   0OL/FmRLT+LRrb5/N5evcCWXApfhNLiGw1U+tmf76OjMtaHGrEg5xbtZp
   HBw1QPGGJ3pLtf7/kr1vXCawIHNc/eSx2q43lRlj48ADuLG+WHgrmiMAa
   I7Cxo0QusplItTYvogQd2IjFdtpVBiGnQLvqrM6DOl3L41cVhEi2yUQrv
   0VuzLaG3GGXoL6yi4pPBDzD0k284rajA41g1XwDEVdk6ubqcMkbkVOAbG
   Ky1L+alrFkg2VrLXlQv4PLCN3lbILezGYLoyU5Uu0NYYXEneWiUudJb3s
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="294589015"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="294589015"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 16:12:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="788460435"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 01 Sep 2022 16:12:27 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 16:12:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 1 Sep 2022 16:12:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 1 Sep 2022 16:12:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nF8W8h2oSig+EvHL5I9W6yc3GE/eIg0ruQ+Fjdl9MDJ7V+vLzq8o9vgr+UbTpluiFgjBXs76bETELHovmjSysXhm1p0SsdLMf6SrLve5CvnlAmzsAq1jeLNoXiPEZ+ih3zVY1Pj70EfVTYujP5ehfxiWMGxR+qkS+lehUQxLABoV0jr7B37K60QAmGgNTV588Z1a5iFmvCkBSlkp/kpuaJAqzZ9yNCD8q9mAPEkLaKVfc/eageAUPehdvVydZj1Hg1sDo0MfFlvYriP8Z4Oj2GnYZEfMQ6bdWgAS3RXFPPr22MXhA094ruwADGN2MJ4zTmK1MP8sziw7yLGox4hilA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KsIp/rZH5TLPW6L5DoCocqEzGMbm9L+22JAdEFwLVk=;
 b=gqIbsw+lRKk06A3ICJMKjk07j4cfSS+SooZwrOQtt7oY/jOivbUInZuuA/raZOZO8x+2GHI0/9/l9wpqXk1nUTm2QQPwr9diw6R7plDyn19UEppEaMGhPKJQcqZpeYE3z6abO1yOU5QnaaOyCynkAYSMbYAvhE5T+aeCUshJRMtYCpBfSV15IAKc9Ifqpw2hpg3PSaNVrm3ShWNgpAMPmkyfNOM49wQXbqmwr4hvP817QNKk2hk7Pdjt3HEalNZ832S16eEPA5cCaByOsd5oQQHapkt5rFl9mWaXopxRXRwGPgaKVAOIC3R5sP8GEhCrHX8UBs8bSITB+WSn84011Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS7PR11MB6061.namprd11.prod.outlook.com (2603:10b6:8:74::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Thu, 1 Sep 2022 23:12:25 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%11]) with mapi id 15.20.5566.023; Thu, 1 Sep 2022
 23:12:25 +0000
Message-ID: <17dcb776-14b8-f673-1f36-8f22b192eadb@intel.com>
Date:   Thu, 1 Sep 2022 16:12:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH v2 4/6] selftests/sgx: Add SGX selftest
 augment_via_eaccept_long
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <linux-sgx@vger.kernel.org>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Shuah Khan" <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220831173829.126661-1-jarkko@kernel.org>
 <20220831173829.126661-5-jarkko@kernel.org>
 <d2b76530-82a2-6ac1-32ea-696e653d767d@intel.com>
 <YxEwwzXOsCliznQJ@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YxEwwzXOsCliznQJ@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0121.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::6) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df62a00c-9fc2-44ab-51e7-08da8c6f6e7c
X-MS-TrafficTypeDiagnostic: DS7PR11MB6061:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HOjiQYrDTJT5l4XtftRzwb8oO5VGcWJMJ74mHRhlDGiCBlOFfRhwvAalbuKEL43CFZZK95wEq1QsF313mPnPtc4jBjiGwobSlaBdU/yISOAkoZZBmdcDvTd0b72Z4IKmOkdoui2zxKe631xy+HDWKqFoUHwjjMAcb/ZX0DUzSBeoaXr+FHol6vGEYTP/a9HGP4ZnJKXzd7i1YXoq9UH7mVjF+8xOVq5UG38Tnxyx9UyViaHI7Tvvvy707wJuObmNNSlJEiu2859/38Gd6rCKD0oR211JURTZyXNGDVYxSeqvLE9FD6g6rASR65VcETQzEA3O+7PvclYljPjwPR2vASyRDgzLmuDUhvdP7ri9/RBxlLuYnpgt3DewG05DVIton3MH2oSKv3Oe+VYbxRzGoz4BHcpqCSXEDcKOJYTurFKaTisK8H/5p0DHcMl74jIlGBExOePpwsonEQJXfjFAzXo1psTeWHjjyJvHwzuxj8BwK8BMzKGB5HRZvCWGYvQ1XDx2HSAMjFVJQS/M2GLl3pVydOzmg6WE8q1l3JFKGZnduv+3G3qE4RvfLBEMQv3JVLIvqSHtAvodnEMDtjTTKaZP5127/gUPJDGs/2K/NSE+2xsU5fPr0Rd6SJBdY0rj3vUboi5XzpmtrNOsUVh5c+eAOnrQsFhSi2o9e48eUXAp0bGtDlrYQX8wILsqFRqvDBAuiRTHjeWFlbe5sUiU/gAdHoVkxwsVL2XrCqs5Uumq4Nx0qgaBz6r45cyfb+VBEemqS7kvJ3JDJ3J2LjN/x8KUKc0hxuBmCZK2LCevVOI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(396003)(346002)(376002)(136003)(6666004)(4326008)(8676002)(66556008)(2616005)(38100700002)(31696002)(66946007)(66476007)(36756003)(86362001)(2906002)(5660300002)(186003)(8936002)(44832011)(53546011)(26005)(6506007)(6512007)(54906003)(41300700001)(45080400002)(316002)(83380400001)(6486002)(82960400001)(31686004)(6916009)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVNUV2JMaXFFUDJMdkh6Ny9xZjJ0WnBxT0ErTmFqT0FGUlhubUN2VWZoZXJO?=
 =?utf-8?B?MmFPQ2pRUUNONXRHZ2k1RmhGZmkxU2svbm9mdWZDMzlTT3Zva3E4bEZ6VWpn?=
 =?utf-8?B?N3I2dStaRXZaTDNja2FGbmJaR1NVSFI0SFFLOTZsa05XZnpIU0VzZ0pjZzR2?=
 =?utf-8?B?VVJROFhxYzRxOEJtbWp0MUZEZ04wUEpKWURLVVprSXE1UGFxRTd3Z1NiaWN2?=
 =?utf-8?B?VDBZamVuS2RGOHdPc0FtdmJiQUszU3MrZUhIVmlGYzFOUFFoYkpYWjh5akU5?=
 =?utf-8?B?LzFlY0VBTEJ6enhGNUpHV1BNOVZXV2lZK0FsYWRvZm1hdy9kTEEyOEhEQkRP?=
 =?utf-8?B?RW5ib0t6L2k5WWgvK0Y2MWZ1OFp5dzRBOUhnak8wU0Z2dGhUWlRTclFOVFhp?=
 =?utf-8?B?RnFPV3RtNVo1Nm4vMWJNVXZjSXdMSVJlSzJ0amNOajh3T1dSM2l4Z01hRmhx?=
 =?utf-8?B?MHBPOEY5emxYQmFwZ0l5THhoMkd0ZlpYWHU2dXdtTmpEc01CR2lnKzB1N3M2?=
 =?utf-8?B?VjFHanRaZkowcnBhYk4ybGdzbDByWEdycWJpRE14VWJoSXljTFNrRXlUR1Zq?=
 =?utf-8?B?VVk5N2g5UEE2SWV4N1hTWnNmTjVoVW5wd0ppSW9ycUo2cnQzWURid2wwTVBt?=
 =?utf-8?B?NTdsTmtmdWN6R3hzV2xETVNQTXlNREpiZ0FOMVBkR28rYkl2RmZpOUNGTzU1?=
 =?utf-8?B?S0JUbVNGL0F0aGhTb1g3WGlMMHZ5M1BJa2pjS2pURHFtYnpNMjhCZjAxM04x?=
 =?utf-8?B?aXJMRnNNRXBEMFZlaDZpa3Naa0xRRVVlOXd6QmV3cDRDUlJzaGdmTWdoSlBk?=
 =?utf-8?B?UllMMXNpb2tFaFZKWDJvYWV1SWJEc0lacWZhdEhDK1RNZlprK3pQcTk0RWRo?=
 =?utf-8?B?VWtXR1A3QTJ5SVFMYkpCWllLcXlHeERjQUFtWWhzMys2MWJkWlo0SGdPQ085?=
 =?utf-8?B?aWd6N2FCanM2S0FPd3hNT2xOUDljdDl4aVlVRWd6MXBNV3JvWkk1R1ZoRGJY?=
 =?utf-8?B?UCsyc2ZOamZDRUwwKzRma0c3WDFvWGprVFpjSDNkdjN5Ni93OUFVK09udEd6?=
 =?utf-8?B?Smx3cEM5MlhmKzVlRmRkanZDeWM4Zm1paE5XTTJUNk1ST3FGQlZWNmdzU1ll?=
 =?utf-8?B?ZDJPVXlTVTk2VGFOTGJncnlkaUoyK2ZMd3BsWFVKbGZvdFlMOXZ4SzlENHhR?=
 =?utf-8?B?cmsvd2NSUnFpOVJkU0MzVHR1eElSYnVMVGZYYTdOd3RCYUhsZWhLMElEZnFS?=
 =?utf-8?B?MDUrNjNsUllvMDl0bmVSQzFRdmlKOGZXY0ZhTjh0aU9oUGp5NWpyY1RtWkpj?=
 =?utf-8?B?dFI2cnNJZTdZT3lPTXFFaG44T05nbC9IazFvSjl1UkJDR3lwRlVyc0lLcFRB?=
 =?utf-8?B?aGpFa3Y1QWxubXRrNTJVUW9VSDhTNWFTaG9aTzFLWlNEdGNTU282R2h3L0lY?=
 =?utf-8?B?blV5cUtqR3BLbGNNRjJQdDFqUGRYMHRFTVJ2NXF1dDJ3emNZZ0pmZ09tNkJi?=
 =?utf-8?B?czRkL1orcStudVFHSEk1ZC9kb3grUFJUb0NCZHFRYTlZVTN5ZkdZQ3Ntd0x4?=
 =?utf-8?B?S2cxaVA5OVppc3dmcDRrUWFTNTFtdTJCbUU5Y0NyME4zMDQ2ZlVBckh2Z2ZX?=
 =?utf-8?B?bDhwM3NnbnovUHpLa1ZzOWh5alk4Y1V0ZUwxZThvdkNqZ21SQUJGbDRMWDh2?=
 =?utf-8?B?RFMyZk1ITFhJaHpvMW9oWE45VlgrZXRHWUl4R0ZGTDJUdXkvNnN1eURKZzNM?=
 =?utf-8?B?anlvOTlSakFDWnFRQXZidDlEaXpmbktOanR1c24wQ1A0c1pLUVJVeUlTWjZU?=
 =?utf-8?B?OHlTcU9NR2xIRFdQMDZkY2J6MkZOSWF4TWZYUU1WbUlJS002QTZxdUgyLytD?=
 =?utf-8?B?SU5ZODdlNG92M1czYlNpSktVdmgvT0o4U2tEcU05TGRzdktZU3cwblIwSTJt?=
 =?utf-8?B?OHpBY0g3L1QrZXBsTllna1hPYWpieGFWV1BuempTM1daeVVtSTVqUHQvZmt5?=
 =?utf-8?B?ZHZ1N0FZSElVYXRPdFVNZFVVenlTbFd5cWR6eHdhRnlpVzA1d3g3S2F3YUxK?=
 =?utf-8?B?ODhORytLTjJScCsxcjFGYVoybmdWQ1UwNmY3UGNoSEFHZG1MeXVpZXlUc3ZN?=
 =?utf-8?B?QVgyMmcveTU2ZXZHS1duYSs0dGYwbzBlSU41VHRZV3NRaFhkWHZ5RE1rVjZk?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df62a00c-9fc2-44ab-51e7-08da8c6f6e7c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 23:12:25.0652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUlr+GJyR/0ka9oLpXxrzCImHuZ2WHbZiOfl+L6av3v1q/3NmdW5+hRKEO6+I0twbApZCTkS6XLiEYx4KU+7d85dnmOuoLlnyXEcIzg6uz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6061
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

On 9/1/2022 3:22 PM, Jarkko Sakkinen wrote:
> On Wed, Aug 31, 2022 at 01:07:35PM -0700, Reinette Chatre wrote:
>> On 8/31/2022 10:38 AM, Jarkko Sakkinen wrote:

...

>>>  tools/testing/selftests/sgx/load.c |   5 +-
>>>  tools/testing/selftests/sgx/main.c | 143 +++++++++++++++++++++++++----
>>>  tools/testing/selftests/sgx/main.h |   3 +-
>>
>> Is this test passing on your system? This version is missing the change to
>> mrenclave_ecreate() that causes SGX_IOC_ENCLAVE_INIT to fail when I try it out.
> 
> I *did* get a pass in my test machine. Hmm... I'll check if
> the kernel tree was out-of-sync, which could be the reason.
> 
> I do not compile kernel on that machine but have the kernel
> tree for running selftests. So there is a possiblity for
> a human error. Thanks for pointing this out.

On my system I encounter the failure below (V1 of this series
did not have this problem):

[SNIP]
ok 11 enclave.augment_via_eaccept
#  RUN           enclave.augment_via_eaccept_long ...
SGX_IOC_ENCLAVE_INIT failed: Operation not permitted
# main.c:236:augment_via_eaccept_long:0x0000000000000000 0x0000000000002000 0x03
# main.c:236:augment_via_eaccept_long:0x0000000000002000 0x0000000000001000 0x05
# main.c:236:augment_via_eaccept_long:0x0000000000003000 0x0000000000006000 0x03
# main.c:236:augment_via_eaccept_long:0x0000000000009000 0x0000000000001000 0x03
# main.c:251:augment_via_eaccept_long:Failed to initialize the test enclave.
# main.c:1260:augment_via_eaccept_long:Expected 0 (0) != setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata, EDMM_SIZE_LONG) (0)
# augment_via_eaccept_long: Test terminated by assertion
#          FAIL  enclave.augment_via_eaccept_long
not ok 12 enclave.augment_via_eaccept_long
[SNIP]

...

>>>  
>>>  static const uint64_t MAGIC = 0x1122334455667788ULL;
>>>  static const uint64_t MAGIC2 = 0x8877665544332211ULL;
>>> +/* Message-ID: <DM8PR11MB55912A7F47A84EC9913A6352F6999@DM8PR11MB5591.namprd11.prod.outlook.com> */
>>> +static const uint64_t EDMM_SIZE_LONG = 8L * 1024L * 1024L * 1024L;
>>> +static const uint64_t TIMEOUT_LONG = 900; /* seconds */
>>> +
>>
>> Apologies if my feedback was vague - I actually think that the comments in V1 added
>> valuable information, it was just the variation in formatting that was distracting.
> 
> IMHO message ID is pretty good reference. Can you
> propose how would you redo it to minimize the number
> of iterations in the series?

The message ID is a good reference but it points to an email thread
and as used here it is unclear what part of that thread is referred to.
What you had in V1 was very helpful so it could be:

/*
 * The size was chosen based on a bug report:
 * Message-ID: <DM8PR11MB55912A7F47A84EC9913A6352F6999@DM8PR11MB5591.namprd11.prod.outlook.com>
 */

I am not sure about Message-ID vs url. The latter may be more
convenient since the user needs to first search which inbox the message-ID belongs
to before the message can be accessed. Not a big deal though so I think
either works.

Reinette
