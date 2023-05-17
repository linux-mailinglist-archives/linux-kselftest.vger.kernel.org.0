Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23D0705BA2
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 02:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjEQAG1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 May 2023 20:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjEQAG0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 May 2023 20:06:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5B22D66;
        Tue, 16 May 2023 17:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684281984; x=1715817984;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rPt43MNebs/5znkgjxwha/576Cc5dLJmayIDy5S1SaE=;
  b=hLS4zRhd/9gh5BXJbX65ugXOSZetJZpYtEczqeFkItbSrGc7dVyH5wC9
   5fT0iiYTkAXQJs8LbiampfuIuf6qobkF0wcYs6x79mITJLatnHpvnW+xT
   DdI+IYqchQo5HG/FW+eClcsLEUDEPiheVsCUGLwKy21YVsmH58CzXuVi0
   nrkLNF6ikfQWd21XpJSHDZEKc0G2XcN1Zg3+tOzydfTKPNfVdSNXhDxvv
   P64IhIKBAVdM3/yiLGhZVMKsXGoiu/CyS4DZ2mxQqmqOIgFRhZIYtt9jP
   tjssGz7xzFnGjHf3j2UiXIMv2ne0mJ/HT1zUCqVKmiBo59D4AOZLFAFvN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="341001780"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="341001780"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 17:06:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="1031470654"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="1031470654"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 16 May 2023 17:06:01 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 17:06:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 17:06:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 16 May 2023 17:06:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 17:06:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9TAh1uRgl/iDznsNTvkOiwrGoXAT+pIvKOClEVDRx/5pyI6lSeI6KHS6p/vi3PDjys2SCGPGLQLpbBbHoqxvFRvilLqeqaafV30DlO6kZgrNQikeKVN+2fSp5lZhZnR8Vj7jaPsh3/EfHryjJQ5Y7xD4UBfTtWhzfHFmAqBmWK57aHvCI4OvGrWiP3lvdtGfHxdw0mafx3KX+0efpZpvXT06LZbi0UtdR3ZGfyRtcvpr5l510jkXV97jf5Sad/rNKdssrfSMoaI1TbXoi9P61UhPRzZhVZNzhjDNNlL/cr+9hPEZ7oFwNi9BTSdSCLsHHd/3APz6Ssf3uH31Oy/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlvvTSWJTBr5E9lAuJsO0+GxWRFspTtmxRfOvrkj82w=;
 b=K8squHSokgDFbaOU6x/0Ow73as+/UEQfIowCy8WAf+Z1/4wKA/l0FZzYMW/c28+iVF66Qm1GPRj3TVOYCjGDesRt7lDMR6FxOIAm7EsBnwMpMYzFcDSIoFKGZ6zvPP5G0hf9Fa5BhyBYWC5YC3MBgSUrs6s7Tj4DV8wnUHoGAs0IB6/g3WJ6kzu7IycACSQBjuGDh13xJ21kP+FXpUMukgFdKge5UrdoGfeaOdV9w5R+eiBCZ0TYTNGCax9dBLaI+dtKog1RDCpgE+k1nirgVCEtzfOjKsxxWk6VBy4OK+Mzci4G2jg+7Vv8fMZ7l7WxMEBIp3IE18IYiQ9ZuxmbHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7911.namprd11.prod.outlook.com (2603:10b6:208:40e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 00:05:52 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6387.028; Wed, 17 May 2023
 00:05:52 +0000
Message-ID: <04c9eb5e-3395-05e6-f0cc-bc8f054a6031@intel.com>
Date:   Tue, 16 May 2023 17:05:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v1 3/9] x86/resctrl: Add resctrl_mbm_flush_cpu() to
 collect CPUs' MBM events
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stephane Eranian <eranian@google.com>,
        James Morse <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20230421141723.2405942-1-peternewman@google.com>
 <20230421141723.2405942-4-peternewman@google.com>
 <38b9e6df-cccd-a745-da4a-1d1a0ec86ff3@intel.com>
 <CALPaoCg76nUsJ7eYcU61gied8WBuAAmqy0Pqpsq5=Z-S52Qg6w@mail.gmail.com>
 <31993ea8-97e5-b8d5-b344-48db212bc9cf@intel.com>
 <CALPaoCiPCxUeGKjZytxmse2oNs=qDBbRY9kH7AZGG6iXf1qtJw@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCiPCxUeGKjZytxmse2oNs=qDBbRY9kH7AZGG6iXf1qtJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0371.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e6af65d-43be-4f45-7472-08db566a7a72
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eUeWZ38Ckquq4KQ7Vya9yeZN3o4FXvld0JqHz1XeWBLjDBO5mgejRE9kn5RmCdTuvG/YPj3jGpCnsTAFZFpYwOSPQsMdN8vnA9eFeVqitjIONvNTN0At655wdqA/Nhw8oMNkwZL83pc3MJqK7vM8S/HaSCo3dCG776ot09WdBBvdu3kFJy/+Y6+iwHFPWxlQjilFLimWdE0QIeFgMCx9x6nvZg9hZY2J0WI87kqCZBOaoANZI1+Mb/GttVq56cKpp/aoJ3F/VMxopFUMiOeyzzsyQU7fGkFQfJ8sHKwoLftOlC7KSoudt/2xuE/nJ5Iz8k4FMjibDxkVI2TKiJcVwx2c2COOtz5SD0YmAqfobrWkVBj/Mq9UvfHm5E7V7HF0RWYqR5SMpm+SebTUrL1OPFOpEW9gv7pPeQyisWPhkJRxNiNOGqCNNfl8l2OW1VFnNZ8csu1HbqeQNLhiONglwxE9/Kxcpw69IyrgpjGrvb3/hb7hEI/QbEepNtlh9FDBzdmRJrTMRPEY4DHR/XhEBus7e/5kiHIIjnYOwRB/PYzdI2ETKIHt6uTVMX+W0rpssUSABiqzR7WdSec72Ws09iHxmFK30t+WA4QHR08TywGSY81nmQaiCAl4gTHu3rvL71f6EqJuUsgE48Eb9c6a+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199021)(31696002)(86362001)(54906003)(478600001)(36756003)(186003)(53546011)(6512007)(26005)(6506007)(7416002)(6486002)(316002)(38100700002)(41300700001)(66946007)(66476007)(66556008)(4326008)(6916009)(8676002)(31686004)(82960400001)(5660300002)(44832011)(83380400001)(2906002)(8936002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0hSekJNMXJDZThhRXlNWEdDcmtKV0wxZlpYcnVDMHZjTzYzbWhNcW1Hdjl6?=
 =?utf-8?B?RTdVcjJTcUZXbmRnNlNXSnVrbVVrQ0FuOHMvZzFqMmN3MWNkeVY5SVY3dnF0?=
 =?utf-8?B?OGdyd0VpbzNWZm1UWlMzSWUvY1ZuVzBLdWFWdVArdStyc0gvSzRJU05pSndu?=
 =?utf-8?B?am1kek4yV1NYK0pORWpSRGFKMkt2QWhXc0hEa0FrZUpFZ2JQekk1L1M2L2V1?=
 =?utf-8?B?WmszNS9wc1loQnIycUhFQmw3c3h0d2tqelBwbzN3T3d6RWZ0eXpwalVOYUFw?=
 =?utf-8?B?VVVjQnVvYlphVENhR09KTG5mMTRZUEJWWkMxUncvQ0YrVy85MnFreHN4cGZY?=
 =?utf-8?B?QmRNSGgzNUduZTNjNjVhMmk3RVZrY1NQTkg4VDJFYVptOEtGNU5OZHBSdzZJ?=
 =?utf-8?B?bm1OOHVnVEZPdDR2Z1NjYXpob2xUZTJscWk1dVBQaHp4bjRRdTZKM3A5eVoy?=
 =?utf-8?B?Y0FoTkEyUUZKc1J2SVFFSXVZRTlUQ0I3SjRrb2M0S2dOTXJUVmtlckhsaXVp?=
 =?utf-8?B?NVhTelM3STl4R0JQaHdqZXB6ZXFlK0NOOTFqS0JyR2ZNcmJ0SjNEdWdkOUlM?=
 =?utf-8?B?UC95d2lBZDNmcTB3M3B5dURQZlRrRzJNOVlvV2g5K0IvRXR4U1c2TVVoK0VJ?=
 =?utf-8?B?dVp0Ykk1TCtBMjZLOXVadlg1MGg2cWNrN1pWU1RJdVBjb1Y2MkFLTnZ5aVVX?=
 =?utf-8?B?akZsNFF4UXdWYnhUMk5Pd1JUZFZLTlpwcjBXaUNhbjZDS1ljRTd1eFh2L29K?=
 =?utf-8?B?dnFpMUE3N3lZL1AzZWxWTGlPTGFCSVN6amx3dUk3NjNSTUlVNGpMZ29UZVVX?=
 =?utf-8?B?R0JOUWJJTHhyTXFXdkh4bllLdnlMWmtSaEhmdkNnenpMaUJpeTVLWlRSRUlN?=
 =?utf-8?B?eFY4R0k3OG90NGhvdUpBeUN1TFQ4M2xyRkZGOWVsQnZCbnJSakxzVU13d2F0?=
 =?utf-8?B?U05LaHVhdlpxWSttT25qMnpzc1NpbEQ1Rjd1V0NNWkxlOVVqK3FoeUhYSVpV?=
 =?utf-8?B?Q3hiU3ZZTVQyS1hrQWFkemFmdEFjYlZwSE80WEpsWHpqYnExOTJzOVArZEhw?=
 =?utf-8?B?ZEI4V3M2SVVzWFFtS0NxVGtxOVRMdUlDZGRxclJPclRGY1prbGFnSVFGMm13?=
 =?utf-8?B?RktyMUluSW4vWXNXcE41dFkvZHZBcW4zaC8rNHRTeUpNLytiOTdWemRwb3dU?=
 =?utf-8?B?aGFnemJmTDBKLzlCQWd1a0E0V3dDd0tNZjBMcGV5TTBSWDJ0VzdZNjdDWnRx?=
 =?utf-8?B?TXZEK3l0d3prK0xmeUxwZEpOakw2Z0ZRRk5vby9GZW1ldTl1YkZMVDJvdDRv?=
 =?utf-8?B?MUlhOVU2cEdyYU5Oa3l3dGM3U2tybSticlE3K2JnWU1vMloxR2x6azQyUCsv?=
 =?utf-8?B?SWRrdExnTVcwY0d4bUxpUkRFLy84L1Y1QkVoWjNhelhJNjlWMTA1aENJV2x6?=
 =?utf-8?B?SW1hNjloNWFUSk5mSytpSmVEU2VvQmUvckQ1NDlmMEp5Mzk0SUtYZHlGKzQ2?=
 =?utf-8?B?dUNWSzh3UElHVmdUc2RtaDJoUGVHanN0d2RpaUpzc2c5REpNMHNCa3VsQi9y?=
 =?utf-8?B?T253S2loOXB3ZkRrRGJBNmEvTUd6WHQ4Uk44NnJjSzU5N0UyUmJLY1U4VU1l?=
 =?utf-8?B?TWxNK0Zwc3ZmRFl3V1h0bWNPTjZsQ3BVUG5nNzJqRkw0QXRQQ3NLVitqanZv?=
 =?utf-8?B?aWNBOXdkMmpjL1FDMWZ6OUIyOHliRmpCaXdGa2JKeldQSHZHVDJpYkV0cEhk?=
 =?utf-8?B?cEcxeWQ4Zm8vbXhNcDRMWFVpb1BpVDNZVFpiNUVXQVBlMWpuTmsycmpvQVlI?=
 =?utf-8?B?NkExYk9DYW1LMEhhWFp6bEFtK3R2b3R3cmU1YXBsMnMrTitrMDV4aU9PN0V2?=
 =?utf-8?B?anFPYjRKNVBDajNodUpnMHVLTk5QTWx5WEJlSG5aQzA5dlY2K2lQdzQyQTZD?=
 =?utf-8?B?OUQ5dVdrY0JNM0RrSGJESGRnc3lyM3F3RFR2dTlzbHVFN0FKVnE3WFdReFhD?=
 =?utf-8?B?R080SVZQdHpwS2J6QTZhZTJFdC9jWG9ZeHl3VmloV05JZys0bEFDdzBON0Qr?=
 =?utf-8?B?RU9DTEVuV1ZIY2FRek9JamJYVzZZajRCYjJ0VFYzSmpiOSsvWkVrYlRKVVlR?=
 =?utf-8?B?QTVqUlhqa0UrSEFUSGhDQ1Z3OThTNEQ1dFJORVdYVno4YVlhcGQvTERNTVhM?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6af65d-43be-4f45-7472-08db566a7a72
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 00:05:52.5607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQ+1R9K1JbqK+9UsP/Sf62fzlwJpkfYSYb7ASWG09ho+GlNpbTHT5HFJ4ShdjmHMXnXsxtcVj9YdrFgLarAdIR4PTWZLVL8MrV/bS4OtuXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7911
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Peter,

On 5/15/2023 7:42 AM, Peter Newman wrote:
> Hi Reinette,
> 
> On Fri, May 12, 2023 at 5:26 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 5/12/2023 6:25 AM, Peter Newman wrote:
>>> On Thu, May 11, 2023 at 11:37 PM Reinette Chatre
>>> <reinette.chatre@intel.com> wrote:
>>>> On 4/21/2023 7:17 AM, Peter Newman wrote:
>>>>> Implement resctrl_mbm_flush_cpu(), which collects a domain's current MBM
>>>>> event counts into its current software RMID. The delta for each CPU is
>>>>> determined by tracking the previous event counts in per-CPU data.  The
>>>>> software byte counts reside in the arch-independent mbm_state
>>>>> structures.
>>>>
>>>> Could you elaborate why the arch-independent mbm_state was chosen?
>>>
>>> It largely had to do with how many soft RMIDs to implement. For our
>>> own needs, we were mainly concerned with getting back to the number of
>>> monitoring groups the hardware claimed to support, so there wasn't
>>> much internal motivation to support an unbounded number of soft RMIDs.
>>
>> Apologies for not being explicit, I was actually curious why the
>> arch-independent mbm_state, as opposed to the arch-dependent state, was
>> chosen.
>>
>> I think the lines are getting a bit blurry here with the software RMID
>> feature added as a resctrl filesystem feature (and thus non architectural),
>> but it is specific to AMD architecture.
> 
> The soft RMID solution applies conceptually to any system where the
> number of hardware counters is smaller than the number of desired
> monitoring groups, but at least as large as the number of CPUs. It's a
> solution we may need to rely on more in the future as it's easier for
> monitoring hardware to scale to the number of CPUs than (CPUs *
> mbm_domains). I believed the counts in bytes would apply to the user
> interface universally.
> 
> However, I did recently rebase these changes onto one of James's MPAM
> snapshot branches and __mbm_flush() did end up fitting better on the
> arch-dependent side, so I was forced to move the counters over to
> arch_mbm_state because on the snapshot branch the arch-dependent code
> cannot see the arch-independent mbm_state structure. I then created
> resctrl_arch-() helpers for __mon_event_count() to read the counts
> from the arch_mbm_state.
> 
> In hindsight, despite generic-looking code being able to retrieve the
> CPU counts with resctrl_arch_rmid_read(), the permanent assignment of
> a HW RMID to a CPU is an implementation-detail specific to the
> RDT/PQoS interface and would probably not align to a theoretical MPAM
> implementation.

Indeed. There are a couple of points in this work that blurs the clear
boundary that the MPAM enabling is trying to establish. We should keep
this in mind when looking how this should be solved so that it does
not create another item that needs to be untangled. A small but significant
start may be to start referring to this as "soft mon id" or something
else that is generic. Especially since this is proposed as a mount
option and thus tied to the filesystem.


>>>>> +/*
>>>>> + * Called from context switch code __resctrl_sched_in() when the current soft
>>>>> + * RMID is changing or before reporting event counts to user space.
>>>>> + */
>>>>> +void resctrl_mbm_flush_cpu(void)
>>>>> +{
>>>>> +     struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>>>> +     int cpu = smp_processor_id();
>>>>> +     struct rdt_domain *d;
>>>>> +
>>>>> +     d = get_domain_from_cpu(cpu, r);
>>>>> +     if (!d)
>>>>> +             return;
>>>>> +
>>>>> +     if (is_mbm_local_enabled())
>>>>> +             __mbm_flush(QOS_L3_MBM_LOCAL_EVENT_ID, r, d);
>>>>> +     if (is_mbm_total_enabled())
>>>>> +             __mbm_flush(QOS_L3_MBM_TOTAL_EVENT_ID, r, d);
>>>>> +}
>>>>
>>>> This (potentially) adds two MSR writes and two MSR reads to what could possibly
>>>> be quite slow MSRs if it was not designed to be used in context switch. Do you
>>>> perhaps have data on how long these MSR reads/writes take on these systems to get
>>>> an idea about the impact on context switch? I think this data should feature
>>>> prominently in the changelog.
>>>
>>> I can probably use ftrace to determine the cost of an __rmid_read()
>>> call on a few implementations.
>>
>> On a lower level I think it may be interesting to measure more closely
>> just how long a wrmsr and rdmsr take on these registers. It may be interesting
>> if you, for example, use rdtsc_ordered() before and after these calls, and then
>> compare it to how long it takes to write the PQR register that has been
>> designed to be used in context switch.
>>
>>> To understand the overall impact to context switch, I can put together
>>> a scenario where I can control whether the context switches being
>>> measured result in change of soft RMID to prevent the data from being
>>> diluted by non-flushing switches.
>>
>> This sounds great. Thank you very much.
> 
> I used a simple parent-child pipe loop benchmark with the parent in
> one monitoring group and the child in another to trigger 2M
> context-switches on the same CPU and compared the sample-based
> profiles on an AMD and Intel implementation. I used perf diff to
> compare the samples between hard and soft RMID switches.
> 
> Intel(R) Xeon(R) Platinum 8173M CPU @ 2.00GHz:
> 
>               +44.80%  [kernel.kallsyms]  [k] __rmid_read
>     10.43%     -9.52%  [kernel.kallsyms]  [k] __switch_to
> 
> AMD EPYC 7B12 64-Core Processor:
> 
>               +28.27%  [kernel.kallsyms]  [k] __rmid_read
>     13.45%    -13.44%  [kernel.kallsyms]  [k] __switch_to
> 
> Note that a soft RMID switch that doesn't change CLOSID skips the
> PQR_ASSOC write completely, so from this data I can roughly say that
> __rmid_read() is a little over 2x the length of a PQR_ASSOC write that
> changes the current RMID on the AMD implementation and about 4.5x
> longer on Intel.
> 
> Let me know if this clarifies the cost enough or if you'd like to also
> see instrumented measurements on the individual WRMSR/RDMSR
> instructions.

I can see from the data the portion of total time spent in __rmid_read().
It is not clear to me what the impact on a context switch is. Is it
possible to say with this data that: this solution makes a context switch
x% slower?

I think it may be optimistic to view this as a replacement of a PQR write.
As you point out, that requires that a CPU switches between tasks with the
same CLOSID. You demonstrate that resctrl already contributes a significant
delay to __switch_to - this work will increase that much more, it has to
be clear about this impact and motivate that it is acceptable.

Reinette







