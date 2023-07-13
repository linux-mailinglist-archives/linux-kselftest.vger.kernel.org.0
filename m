Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A439752DC3
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 01:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbjGMXHo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 19:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbjGMXHn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 19:07:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAA32D60;
        Thu, 13 Jul 2023 16:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689289653; x=1720825653;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=m0PQqfVfC9gcnzEuR1YJmp9seeWfbt/j5l8yXGqrqQE=;
  b=gdSY7/8xWJZdB7+k0AipQwWqrBcxa+7eAvtkBxMDSwN6i2kpG3ha6Acm
   CA0KGU0lNtuIZqf7K5WMPedCzMa8Qp3TOd3bec8qZ133bB8YvSe59Qbiu
   FnU+vf/Kbuk4/Jf0WurEQRT2AhDiA3B/NcOEYjBqH/Hr4rSyF8HqPTP3Z
   +ILXeWu4Bqgp+yffAr97K5Zw2DT9yUMuCYME0R82Y+z+bO5soPHHTn1Yo
   FJKVOKI47T2t/F8Wm7laouBMSBnf7TaHX2PcTT0Dul2j7QgkJy0Nw2yRx
   Cdm+MFkAWcfXIYsWlxv45AjHY+/hLcYzlLF1QltrFV0u1iUyz18g1GJ7J
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="431505686"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="431505686"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 16:07:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="672469095"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="672469095"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 13 Jul 2023 16:07:32 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 16:07:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 16:07:32 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 16:07:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnIKwbkBbXMMcYz8j2nnEj0/w8TqGwlFgjXAT8rj2PJFfefT0STHUFZZWShI6JEagk/5zivCaUad2o4T2TpmH1xl6eGhZPqbKNe3iU2Nh9FBYu403YnpuGPEBVlsrymOrUUqvPHTm1P05IZgh6ETGG+1X+x3KAIRUVShp3HAMZxq0w+do3YlUbJyTqgAks+mMZ8kcL6bWHQvwt+W345vmcweDvEl3A5n4vWichuOzdnnCqTVpFxZ8H2tp1Yr1F1M7zL7WTGn7pPAVryTDLemIcJGbcNMoe4rJ/9xmxIM1KnvIGhE2LocOmhpMChkQkAbMI7igc+tsYXbh0DizNC6kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeloGtqdTRyd0/6kCO/QQj9bS7tIyyoJsgKWWNVvNO8=;
 b=ONX1zCuaZnCvfOwHITY+9K1TrmznA962wWJFvWpnEKPCrZ7ry+uXbzkjW8bFZ/Ltw9UgTW3mx1/mAfZUCu0Jz+jDy5S/OVFhqogj5aI+/fEjSPxEeZtvPp5LGsg7djWaHTFaFZ8nqpILcF0E07WqMY+i1ndN5+IpgfSOiUSW3AqClPDE9QMxQYZ0g3Q2SJ/kOX11vytbEfg2cgqRmLreDmg6xJ/1R6beW5S8uLLwQzgnE1QotSQbI/k7PBf8/4ELhTI8tNlTaROicyMG91cygGQhD85FtXj0MmiwQRy2X9lwD5f6Uow6nYUzzrNMcPLvj9Y8yfOwuTF69ZaXHACHnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6474.namprd11.prod.outlook.com (2603:10b6:510:1f2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 23:07:25 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 23:07:25 +0000
Message-ID: <22a61125-a0b9-f432-218f-cb467d1ef379@intel.com>
Date:   Thu, 13 Jul 2023 16:07:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 14/19] selftests/resctrl: Improve parameter consistency
 in fill_buf
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-15-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230713131932.133258-15-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:303:8f::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cd25960-3459-4fbc-e9e9-08db83f5ebb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+z9NivZ2VFyf9PWt2lAjPDkYp2OOTlFzD+HFOJRA2orZywC1GgcgQD9OXhabpk1IEN5o4j37P7whY8gAK3b6pw/CAT/J09zZXJ/qPdgX/5Q/Yg/xVBZd2PyvcLKAKonTIPP3MIVg0cL9irnXVa0GzEWYxVoI6UeyWjox02/kZFkUMr2hElclNYrq0Ymr5GuCrsJBbX5FYfembdw7qZBsfUbIFTKdUcpqoaDsKt8eBgvP3ftsMI7gaN8QW1mBqfor8UIv6JJKhSHgI9tshDoIiDCzYQkNgQm3+vWBayPXEn8HYAMOQ+SNAYPMFY6UGatfujWp+jbfDeZXH1S7C+rFRhxzb3y860PJu/AXvp++7feGYgJ4GsymdwaJIIPrOCJMFX3nq6mOXaMP5Br0d12uq5SXXkTCr1bZLhuTsd7h7DigU5xjN/iiVXrXZMYh+nR10ZJf7HuNdpQ0jiIcVv8aeT+HYrZSbRHJ7sgTK0Tpdzp3Mf5PMOr2CkqbrlLNxtCvkMJHG9AkIU8uW0nxH+dbyicrXjJrb1E9N+5rM78RvTr17WdI4IfWDHz6wSgtswwh09gRhlA90Pp8u6jiHlMg0idM/tFznwRX0zUJnIZhbioIeTVPPPyuXZwhlZIa5XxFZs0o62YQmIQobZRecmStQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(38100700002)(478600001)(82960400001)(31696002)(86362001)(6666004)(6486002)(110136005)(66556008)(66946007)(66476007)(316002)(31686004)(6512007)(41300700001)(83380400001)(186003)(2616005)(2906002)(36756003)(8936002)(8676002)(44832011)(26005)(53546011)(5660300002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmcvUjVRWWVtNEpjdTlidlRVYkk4VElOclhJcWxKZWVydFp0VnVPWGlYSkFF?=
 =?utf-8?B?Nnp2R204eTVSdXFzdGRtWGhTY0puVnlwdllEVGtySW1oemVDRkcveG91WjNN?=
 =?utf-8?B?UGRDNDZFM05lSGNteklSeVlETXBvZGJyQytKS28yOUU0QkxPQnEwYXlZdE4w?=
 =?utf-8?B?TGhYYm1yUHZWSFhFSnk2WkRoTkp1S0sweTBiNndTK1NGZXBUVEwyaG0zK0l4?=
 =?utf-8?B?a1JRRldidjlTaklXV3Z3cHd1SllkRlJFeVNtWmZ3cVFkME1WaG1jSzY5QXlh?=
 =?utf-8?B?R056a2ZMdXJtNjdLS2w5ZzA4bDYrbGZhUGtVM0dzeHloZURHMkV6QUZoekcv?=
 =?utf-8?B?cnI0dm4yWWFwb1JLeGZsVjlaeCtkMDdjVXhZUkpVRzJ6aHhCdzBXVUJPWkVJ?=
 =?utf-8?B?c3VxckNqWnBFZllLb1BZMWJvT2dBZU12VXJtYUxTRTZrVXR5VnE2amx1WFJE?=
 =?utf-8?B?c1VUN0hDaFFiZTRrUytnL09aRmNETGpyeTh6SHF6MFJCTENFMGxEZElSL25n?=
 =?utf-8?B?dDNXYWp1NnBFN3d5a0dTanpQRERXRDNFMjJkam4ybGNMMGF6Q2dRWi9zeDVI?=
 =?utf-8?B?dVBkNnR4UUFGOEk4Q0xmc2Zsc3JQOFhDNW9BSnM1YUdwZmhhN3NWZ25wTDRm?=
 =?utf-8?B?anJ2RGtFNzVuNThGaERmZGV6d2NqRUV2Z2pSWFk2blVSQWdMVEdJeW9NUUNL?=
 =?utf-8?B?Z1Q4T0NPOW5xamhzL2RkVGhGcWJLTUs3NEsrR2NBUUkvU1dteC9MckN0bGtw?=
 =?utf-8?B?R3BhSnk1UFNNaTQ2eFBtVlNyUlY0eFo0NmNJdjJYUCtiNERUbTNqK3FDcVRU?=
 =?utf-8?B?ZHRiRVNoOFBvNk9OTDFzazBYR29pMlhNNytzZnltUmp0cWFqbTNjRno4dkJN?=
 =?utf-8?B?TUs5ZHpWMFZHYXQrMFp6WlBOZWltUmNGMVdzaVFBSTYxbUppQjN0Nm1TaTBB?=
 =?utf-8?B?ZHkwdjRZdHNUNXNzOGZOVnV2dXlRdWZJdkRiZjlicjdhVjltajJYMmN5LzJH?=
 =?utf-8?B?Y05KUnUzS1ZQYjNqNk01cytBQWNSdTcxZTZzQk1zaFZQRVEvY2ZYeER2QjdO?=
 =?utf-8?B?b2NybGlLczZBSkFTNm9DbEh5RkFySmZpRmtodjZsRVUyVEc1cjVJaEVrektK?=
 =?utf-8?B?OUtodkJldFhBN0xwb05uUEM4TGlGemYxM2VQUDlwbElGVEtmN2VyMDU3bG8x?=
 =?utf-8?B?Qk1ldW1tN1k0Ym1vTFpMakRWa2tKd3ZhcnhVRWRYaitmMHFIcUhvWEIrOGVY?=
 =?utf-8?B?RFh1SHJiZmRqQnF6WWp5QldmWVBLUTRqVGNtcXgyYXRXYkNleHhHZ2t0YjYy?=
 =?utf-8?B?OHhtRGppL21pMU1qcDB5OUFpTUFPWDNPdVQvaTdRbnRXZVJkZmtOb1R1VEIy?=
 =?utf-8?B?WWZEQ0g4TVRrOU9ERFNRMXU2VnBhcTVjRVk0cFhJZ0NyeHBrRjBTTzJ0ZnJI?=
 =?utf-8?B?K1B0bUFldVVRRzFlbXBNaklLbWxZU2dNVjlmNEJMUFcxNHd4NHFGNHZrTDBC?=
 =?utf-8?B?UE5UK1kySHIvRTJQN0xKTlgwaG11Y0xTWk5GaFlGN2VRTVdTRFNwSmFQQXIx?=
 =?utf-8?B?d2xFc3BMaDVXY1dWdktRM0pRbHJoRVorSG43NERzUnR6aGpCWVR4QWZvR1lw?=
 =?utf-8?B?U05KUXI4NTJ2d0NUaVN4cGd3emluOXhCVU5NejVhWXhNcnF4SFlqcWd4SHM5?=
 =?utf-8?B?K1ZPNmtaSlVnelVKNXlWb09jOHlPa1QzUFppWlBVcHZGM1ZLNVNLVGk1MWFF?=
 =?utf-8?B?L2x6K0hZelpYT21XdGUwSjNocUNMZjlLOXRpYWZRaitmMUNRRWE0WDFKSTZB?=
 =?utf-8?B?NWRrZ3RveWExbHhwakNNRXZpRGtrd3g4MjR3cVl2VXB5OXhFUXhEQkNzblBa?=
 =?utf-8?B?RFh5em1PVXJBdi81S2ptQ1FaaGxQVVJCbWJ3WS9CWmp1QWpyK0pVY2p5RG9J?=
 =?utf-8?B?NzRxSkhiNUJxcHBXRlN3VW9EZ1p5Q0Y4S01Rbm1kajVGUktCcFpKdzJ0dVhJ?=
 =?utf-8?B?NWlIUko2N04wMkdHTUpqQU9rTDI2cDZ1a3U2aXBpTFRzbHBxakliZnNyOVlH?=
 =?utf-8?B?ZmJZakxqcDVGb1ZxSENock1YYkNuMytzWVY1NGhJUHNkMUF5YkR5MkNBVE5V?=
 =?utf-8?B?NFVGTFg4bjhydDhqZm9SOGZET2ZxeXFBTndOZlRNODNaQzk3WG11VVBuajg2?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd25960-3459-4fbc-e9e9-08db83f5ebb2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 23:07:24.8948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToX/ttlcTY+jalbRnGJYbqw7mzc4D+Le29zEg3uMEFEU+RoC6GajLQR6r0e3AeF08yqnuM+6a8/shC2Ux2pytZztceysBJfC2TCwvdJFPWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6474
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
> fill_buf's arguments can be improved in multiple ways:
> 
>   - Multiple functions in fill_buf have start_ptr as one of their
>     argument which is a bit long and the extra "start" is pretty
>     obvious when it comes to pointers.
> 
>   - Some of the functions take end_ptr and others size_t to indicate
>     the end of the buffer.
> 
>   - Some arguments meaning buffer size are called just 's'
> 
>   - mem_flush() takes void * but immediately converts it to char *
> 
> Cleanup the parameters to make things simpler and more consistent:
> 
>   - Rename start_ptr to simply buf as it's shorter.
> 
>   - Replace end_ptr and s parameters with buf_size and only calculate
>     end_ptr in the functions that truly use it.
> 
>   - Make mem_flush() parameters to follow the same convention as the
>     other functions in fill_buf.
> 
>   - convert mem_flush() char * to unsigned char *.
> 
> While at it, fix also a typo in a comment.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

This makes the code significantly easier to read. Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
