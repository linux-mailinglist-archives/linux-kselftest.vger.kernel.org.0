Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA4B752DD3
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 01:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbjGMXLF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 19:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbjGMXLE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 19:11:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E692172C;
        Thu, 13 Jul 2023 16:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689289864; x=1720825864;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=wo2uIoXDWVqe7NRyQ5Cf3THrxAWEpUZcWGFGNYdhVFU=;
  b=Bc7KTrFFmN4WL6ozPi3Rq8I2gL71hzeoNEJNIKEIy3vePyvx5d+RDiAd
   Q6GbS9qbLsTIfyrN9jPOqIhBtED4QV4Ra60uAVpPXAyuyXmaI1kz70SnL
   40x/rs1Ky0BOpXV5gkpBVMpop0KQ95txt1OOVkg4htk/Wk11fMIv8o1at
   sW2gsIgl32nSg26+iFaA9lQSHAHIVjI94U4apIoT0qcn1YY07XvZ9+Rl1
   9SijAHrxzGnZHJqlPc1XuNGcYgNCccxiBM+FuF0l7IKPqosGIitDjPr/I
   GHsux3HPcTgLPcd1HkiCGchn/Hik67L/ibR6Md7C3t9u05lSB0yg5u5ew
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="396145014"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="396145014"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 16:11:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="699438619"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="699438619"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 13 Jul 2023 16:11:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 16:11:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 16:11:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 16:11:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 16:11:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yl0sWxt9AyOMRsO7tbMtEez7n1gb0n6YlRIwTYc6Mrb5XDoagNUQGGHONHeiOkGNG5JdfAExI6OXg1387P2CD82uuMQZHvoYRR0OYDlX6iV9vnKE7Iw8KRDytax2824uUauikUuIATWtqIT1P+xbSrs8X9MPtAAdJuo2NFYR4odHwyW09MQucICDt/8z0uaOBXhx09cWE8nBfMNfsg8edGHE8bh3B/U/L5ajdcZwlcWZ0bt48F/NubcADEQe9Zq6hlkkvfL2T2r8DFWy/OieAdfhkWeKHc/qSeKxz9iMwFCXFRaslKrV/oURUZwWSW60E/s9Cvsbk6ZG6Ec6jUganA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xe6C48vrcYukNlqY2zTFJozFvzHFIYv4kpJLRgdR+jk=;
 b=QTC5K1+F001R0942kaob+47CJK0wLUzCghjHZW+jnbMnKt1q6bqP/UGe10m/diTOapuOtzsTWGgI9DtgQDH+l/Rvw5rKCf1Apnsa4Lv/+wHtIS0sHed3aKDwltcdmbBDgGcNwuHmPVJIqCQdOJe4ILK3RwXdk1AlxW2GkXoxyk6Bu585jdPiDlM6VwpviUYu937IBYo7BGBOZlFfFLzSxmEGlE7Jj2GPedUwPIgqYvxA3ZkQ1s5+7WWsLuiD4RaUNGlY58VboaRVX/FkN+ws8JINscy/sIrULOXpl1Gzr5vzHim8dKXWzZeRyW3ZFXFohNl9YAQSVmc2RBqOwBoeHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6474.namprd11.prod.outlook.com (2603:10b6:510:1f2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 23:11:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 23:11:00 +0000
Message-ID: <5db919ba-5d64-fb75-4f40-ce18c232f20b@intel.com>
Date:   Thu, 13 Jul 2023 16:10:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 15/19] selftests/resctrl: Don't pass test name to
 fill_buf
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-16-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230713131932.133258-16-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0098.namprd04.prod.outlook.com
 (2603:10b6:303:83::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: ca6321fd-ca5a-478d-ce51-08db83f66c02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8w3Q6LuSl4W+GvZMR1u5TMwiRK7K/kJZ5vwfOWZwe5TkTiPBHtyOYlvPmKEbGxrwp7+OCwvhFsuiR0ScPMH9tNq+M9I7QsbbeKugA4ZQd2fJgqdlADZk982D8Yrfd0MGYlOsFwjuEs/waRFP1lrsu9iyFimulJwu2tShVvDG/Ie9sZ4VJhk+uiZmghKzCdGd/mjn32+2eB7u4qQ4EWIl0kx3aewe9+bLdfvmCDx5cQbvgh8cT2mNfWnxmB5GAsxMQFWBxc9ullJDErGfHcr0wcl7UMp3dMiu1lkgO0c4hv6toxDdiV63yRBc5Db7mKFAVsjLFPmfmJ0uaqgpPOHVXDqNHwK4nHCKjLucDE0OtPfhdxhaoXiXyhzP+Rku7IJxGn9t8BnEnFmB7fDA5UlLxnSMW26wEP1GdRad6N09SeGiNOPcTxWyMkqk0oOmzft1PuPB2geTbNM/MEJ1N2/W4FDnhQqFnEbrJLKEjKJ+DrNgpmeuuUtKVo8tvvfXA2RkjEZv70jtekbdjpAyZPQBXqFz5nocDyHkFew8sWLOPen8XXZBctO4yZOucvPcqMrPFVznv+wvFxxiUn4A2XbNtnX8XoHyVXzF5LjulqqP9XzRckvG17M+hrj5TU5657NO30rvewOh7+YX8YBRJqILCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(38100700002)(478600001)(82960400001)(31696002)(86362001)(6666004)(6486002)(110136005)(66556008)(66946007)(66476007)(316002)(31686004)(6512007)(41300700001)(186003)(66574015)(2616005)(2906002)(4744005)(36756003)(8936002)(8676002)(44832011)(26005)(53546011)(5660300002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVdUMDZ0am5jbXNKcUo1OXlzZ3o0SUR5S3IxemJKdkJxMHNxT0RUL0M4SWpQ?=
 =?utf-8?B?OE5LTWY2bUk1Y0pIcGQ0eWRCZVFaM3BpSVNBcktqcklGQW5wblNZdzlZTks3?=
 =?utf-8?B?MVp2bHUyNGV5REFFY2ZYcE90bWc3b1RaNTNQbTNhbHdTRFpsZFA1OHV1QXF3?=
 =?utf-8?B?aVJHMFp3MEFLMCtvV24xdE52SXEwRHBlL0o5b3RRUGxMZmJKTnBLZWl5ZENu?=
 =?utf-8?B?WXk4UTZ2RGt6S3kyYnVMSi9WelVnUHFuOGJjMVFPajBMR3ltWVdzTmtWSGh6?=
 =?utf-8?B?WHA3OGtwZ3VoNThIWDRZVWQ4Y0NVbTkweVM0dkFzTW5DUS82cDcrdVBGc2lP?=
 =?utf-8?B?Y2duL3hETTlSZW8yV2dQbFlURzVuRUFsTlhhL0NWditmdWtCSnJrNTlSb2RQ?=
 =?utf-8?B?bktnRkt4NjFBMytkUHhZbFdRVGZZSTRURXBiOVBDN0hMM0J6Ykp1WDlCOTIw?=
 =?utf-8?B?NHlTUGh2amF5bDFCOHg2UWlpM3Z6VVpQTlBoVlpTV2xQUU03aEx2amxLRVlh?=
 =?utf-8?B?ZG03YWVmOVBJUFNCVkJkREgvVENFUjVCdGk1WFltOThwL2t0TGliRXB2TE9X?=
 =?utf-8?B?ZTVyQWpOUjVwTnlJUy9Hakc2UFcrNm9IM2VDYzlHTmYxa29lTGs3Mm1heUZC?=
 =?utf-8?B?d1lvNCtneXNiUU0wN1VTa3NzQ3QzWUMxeGNpS3VVRzN5azFGcm5vZlVVU0dS?=
 =?utf-8?B?aEZzZGF5TS9ZMG5NYkRjMTdJWGdWeTN0clRsSFJJYnpVVlZWQmQyRUFlRDEy?=
 =?utf-8?B?R3JjbFY5VHBkaHUxRURsOGZpRjFGNm4rcjk3eGFGK1VTZ0JsaVZFQndxSVFa?=
 =?utf-8?B?S2Y3S255dUtjSStvMjl2c1FHWnVSaWhsRzFCR3BiTS84NTA1NU13dHprQUdM?=
 =?utf-8?B?ZXRWUEVTVFJDRW1BSncvZk4wRWhzZHhUd2NvVmFDUTlNcFQ5N0w0ckhFWjA5?=
 =?utf-8?B?aG8vMG9iTjdXd0JMZWNuN1NQVEFJcnNIcWFKVWcyNzE5RTEyOUNCYk9iNHRN?=
 =?utf-8?B?bDNMbStuRVpucWRsY3YxbWtHWThrTS90ejFiZ0pHelBCc21hampzTHdnRXZ0?=
 =?utf-8?B?RWNJdnpNUStPaEMzcExIMVVpZEtXUDhlaGhRa0NqdnhJdklrTU5IV3ZWOUZs?=
 =?utf-8?B?anU3M2w0aVI3WStUUmZpeEYyTGdyVHhrazlMdlVQT2owVGlDUWNzdG1nM1dU?=
 =?utf-8?B?ckNib3VZbUhscHJIWngycG8xUlpMMlZvUVdmWFpqNzBpVDBzTDU4eW5iZUJX?=
 =?utf-8?B?ZHhhcytkK3ErNjVBZmVYZzNsMDRRNVFISkZFcStGWldZV0VtUUlkckl6VDIx?=
 =?utf-8?B?Zmpxc05kYzBHQWJ2WHQrM2VUYWFaMUUrWFNHcjBzOWlaa29hbHNSN2dXczlF?=
 =?utf-8?B?UWZaYkxSOFlNb0FZT1ZLY0ZvaXlsRGJkcmg1WnRqWUtvK0ZnQ210bXJUbGJK?=
 =?utf-8?B?Q3lEQ2tXdUVtMnhWMVlnNUZ4SzQyS3hxZVdwVWFJRFRhWjRGcENoZzFTQVF6?=
 =?utf-8?B?Q3JzU2dwa2o1RWNJUG94RGgrNHVKa05qa1g0OTNnc1RPMzR3ZmxEelkzRXNl?=
 =?utf-8?B?dzliLzdVeGFlR3lEb1hoYVlKamJ0RHFzVVJId3pxc2F6NVpDSENTcVhBa1RO?=
 =?utf-8?B?WHBjc3FLTklFYmprTGpRVnFjQkFxVE5PeVN5Wkk1bEoyb1BtK3BjaXpQWFFv?=
 =?utf-8?B?Um42L29qOHdWWUVyM1BsOXhLWE5NaTh2cFNpYWNJbmpvQzFwOVZPenBZd0gr?=
 =?utf-8?B?aXdzZUw1NjBXMFRkTG9tMUZpQlB2RUhmOVlGQmlGSktpREREQmJ3aWtob2Zn?=
 =?utf-8?B?MTZ6WFFYd0ttTkp5VTEzU0ppNGJzZ0NTL3dIUGpsZEdYZWlnK0lXTTdVbndh?=
 =?utf-8?B?SXJPWlJsNEZNU0dQYVYrcktzUkw2ODRzdWxMRXQxcVZCQ1RhWXBLMWdkdElO?=
 =?utf-8?B?RXM0cy9RLzVnRkFvanFCSHNKbHQ2S2h5RTBXUkNBeFZZb0dOdjEwMDRieUEx?=
 =?utf-8?B?K0gyUDlpdkVDdTIwckJuVGVtUlg1dStQZktZdEgvZXdkVExCUHo0cGRwT1BC?=
 =?utf-8?B?MlpycVpGeWtFamh4T1ltM0NqSVV3eWFxanRoNzkxYTU4bUd1MXNpVWdMN0ZC?=
 =?utf-8?B?bC92WTdWQW1EdFhOQi8vdmplVzNYSzl6bi9ocnNHRFF1aWNFb3hncTgvNjgv?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6321fd-ca5a-478d-ce51-08db83f66c02
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 23:11:00.1742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NqUSlB5f4ttnHkf0qVfH9owIU3Wwcwi0+3qTyY3agEwbPMkrzVnJxqcaw+m588sb0EG+uEyYk2pA6EOFwZXDJ9xEpD+KSIWwgAa3WA0PJe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6474
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
> Test name is passed to fill_buf functions so that they can loop around
> buffer only once. This is required for CAT test case.
> 
> To loop around buffer only once, caller doesn't need to let fill_buf
> know which test case it is. Instead, pass a boolean argument 'once'
> which makes fill_buf more generic.
> 
> As run_benchmark() no longer needs to pass the test name to
> run_fill_buf(), a few test running functions can be simplified to not
> write the test name into the default benchmark_cmd. The has_ben
> argument can also be removed now from those test running functions.
> 
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
