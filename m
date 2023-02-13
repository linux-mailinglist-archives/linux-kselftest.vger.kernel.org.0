Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EFD695081
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Feb 2023 20:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjBMTUS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 14:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBMTUR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 14:20:17 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520F9CC0E;
        Mon, 13 Feb 2023 11:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676316016; x=1707852016;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q2FBs6muDL/D2ibCRLGlQdlI/GHZVuQiHmYrICkXeOs=;
  b=c6vIOFaS2zCR4bwbntUD543doRj6Giz+o4rnAHJK6eXZ+eCfmCZ0B9lz
   uGEvcTrGP5t2fqR2QCuvKOrudEMgukvHUdxBBuGVAz+wApWq/JJa6OPjw
   ipL5Mq5ILQXP9SCnS+ZdBDNl9Y6E/g1qyi7GCOPPwfyjBJh3OoIn7UIj4
   7yrJksl5eWqkSXlEizbEgVyn3DF48NC6natSjazrPcdCj0Ij0thTN7gHB
   MUWCmZ55x+Thw5jxyAa8P+ddkM4dljb04zHOFYQSBZiEHJsU/PIWq9Ch9
   VdGhhy5ZkXPf5jrCdszzyW0hBHzjuzOzf0APGI4t/d8tyOONiS8T/6lIc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="318999508"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="318999508"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 11:20:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="777981225"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="777981225"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 13 Feb 2023 11:20:15 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 11:20:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 11:20:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 11:20:14 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 11:20:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cC7yGRREaTBgLPY4KDM9V5R+bJtdnkWY8YhOt9iizBetwYvVr/5Sh5DZwkksSu2NAO+sWPxnWlX9PfS/eV0IZ4A62VYLJyYBDhkytVotYiZ9anoWIVio5hgLPZrniYeU5SNpzSzAOaxgAexCcoTQkQrsOsbJZFo52Rzw1PteKRhX71eEFyUpMCqdxQ/4/i5sod4owUMPgK6a7u3md7IXRGEi1TWEw0gvUcfnzUoN639XeD0icRiBbvdynwESE9OgLwTJM1TvuMz6Z07Z9u4mq8jhNbfTLQcGTy8dRHZrEzUIEfxCfUOxv8bfdGZLLFek2Z0s/EngH3YZdk9fWyCCXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyHHqwq/KubDSKpm6Lm8AzIBEGrOzsFfLSW8oUTfmJ8=;
 b=W4+coiqiGQtLyFOhEqITvtBTQL6+HYC9Bdi1WWhl2AbLcp624bCetzd6cmnYiO0AO+R78se3TL5h3P42jDnR/U7CJZ0TytepLWBz5OFznPFkzYjQh7VTlIbdCx07sjuOAJceDtN+NDN4NplgkdVUl7g2EYiI0wpqbPSeCUxbMsfE7ZbmQXmFlE+2SYgHXGVJDW0llQlpFrEFRTupx2M3sMDV+3K0I/W2eN/dxSj7JS4eNXq1k0FZaqCa5do4KbXcLDt2L4fGZjimkSbjTQsiDaXl1W515Pb9PSq3QQgELXQjxqNbz+Y6KNLJxdUkd+/MpbVNKG/JKzgJBFfy124CFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by LV2PR11MB6048.namprd11.prod.outlook.com (2603:10b6:408:178::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 19:20:10 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6086.024; Mon, 13 Feb
 2023 19:20:10 +0000
Message-ID: <1a933b7c-0318-ce06-9239-197d78c9889d@intel.com>
Date:   Mon, 13 Feb 2023 11:20:08 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH v7 4/6] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20230213062428.1721572-1-tan.shaopeng@jp.fujitsu.com>
 <20230213062428.1721572-5-tan.shaopeng@jp.fujitsu.com>
 <616c7fab-65ad-17b7-f360-94b7e22f892@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <616c7fab-65ad-17b7-f360-94b7e22f892@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::10) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|LV2PR11MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e30570-65c1-402c-5188-08db0df752e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8iQ0BfZAhWjfAz5SX27NcY8Ldk6LpOni6pY6TQhlR4s3TDxie7RplZH2SdBaJVYj7qywUO+FcbLhmHPGteOmXHFxK6jeZtlfTXSuzFbE3xcBumf5hMTaVvIjf1aPJFaRnHPwVRDZkPHmmzPMHAJUt0TelZuQ5oPLpeh2qrbgouJAGQMMV/p46WVR4WCnEMMFqYO5yDdc1MrTZC7X6+q68Oga0jQvYahULc37O92Xlwnb5hJ3jUSWvkcsAV5BdNNRCI6T2OA3l4AKUiMVEW6WXgZfzpT3erNPmPqu1bL7CINoq6KGSFGn+HqGdZl4n2BMj3KQNavdVGbXQA6E/0zpuijMP1w1LpRoEoEBoq7ZuNRBIvUJwhhs8GWoVrCFgsITt44z2XNjEqXFZcHnM8LVvkShVv9m8nfQEDXgQ/bTouC4PCawgp8xRN7x7QIRUN2+clYe/u4jyGr8ie5YXF5iEjsvphtoIS+ksg1U8Q1t44SxY//NAMeKkNN7T5Naw5cIKHjuzfVAesRJ6cEXtowp6MNYmUCENKeIDnWl+mbT9shCmlpXeWiVuuwd+cZVIYwax7/Fm7w4sUAVBxI+5kIXBctkzgaoZpex5UGDzGTHk/REfo2iJ59BWD7okIjqbJGgQrqH5pyYl+DbRfDNk4T60ECSKX4pTAAK0iA0KZNlVN9laUdoV6nHEBq8Aw5ujvbr+ugK0vGxq3jpkG+0JMXqvUw4iTNtqgcU4apgB9qQZj4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199018)(41300700001)(54906003)(110136005)(38100700002)(36756003)(5660300002)(8936002)(44832011)(478600001)(31696002)(2906002)(82960400001)(6506007)(6512007)(186003)(53546011)(26005)(86362001)(6486002)(2616005)(66476007)(66574015)(66556008)(66946007)(8676002)(4326008)(83380400001)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVVwVXJIQ3hkQnpRbTlEOWlUOTB4MTFtM1dBUWt1bjFsd1pWRVJobVpvdklM?=
 =?utf-8?B?REhTeUlBSmNJMjZBKzBGSjNiYVduT3J3Y2FKSzdsem41dzQ3ZTBkUHR2UmVv?=
 =?utf-8?B?VEY1ZDNGUkIydEltMnJPbnpGRWM2TkY2b1QyTi92MFhWWkNtSmN5bDhMWHg4?=
 =?utf-8?B?T2E4K055ZHI5cWlIUDVmY0VqNVNsdWlYM0h1UjZmQnh5ZUl6amdoQTNyYitF?=
 =?utf-8?B?cXNIRXVOOUx1QkVGYWh3NWNwUFViVDhQNC9tZm53WDFMeWVFTUF6M1ZBbHQ2?=
 =?utf-8?B?d0djOXNCNFBPUlVnTXZxUTkyZkZWdDRXN2RLUVAzaFNvNy9jaDdINkR5TFFT?=
 =?utf-8?B?MlhpZFE4eTNCS0lRcktxcFc3c2U5ZmlRTXVaMldFeU1kbGhTRGdOdWZFdHhP?=
 =?utf-8?B?emV2SWFLRlgrdXVGVjVQRFRJRENHVm5IUFAxeS9zS2lyUVVIeHBiMDNhQjRl?=
 =?utf-8?B?NE9xQ0RhcHdFSCtrT0RyNDRTN3lraVgrZkR1ZDUzc0JwNU5RVGlYMFJSWHQr?=
 =?utf-8?B?WHhEd3FBNmQwbExEc1dWZ3BqYlVIaVhHUmY1d0pJM2VMK3RaWnhHK2lTaHdH?=
 =?utf-8?B?NVYzSE9INDhCcytsa3NwWkFjd1NzTHBzdkQvTUdJWmhSalQzUGRZcFFPKytW?=
 =?utf-8?B?YUxtVVRDeThKalVXYWp6MUhPRTBPR2cwOFhHK2F1aXlpL1ZzeGhISTdtcFFn?=
 =?utf-8?B?ZmM0RWJOMUZPeFpZQkVzcVJLTllZWkZURk5ram5DMUdNOHJSRlJycE9rNitq?=
 =?utf-8?B?WmlXK0RkVUd3cTZnV001YW5XU1ZnYlYyMHJyaEtTRUNEZ215MEk5WHBCZmZN?=
 =?utf-8?B?VDVROXpWajU4OFYwSXp6SU01TmVucFhBeit5eENjenAzNGlRRDNlV2JadXQz?=
 =?utf-8?B?V3VQOW9ScnB2VmlHWlRvZ2M2UDdzOFR4cDdiY2tkTGRLbzlHRmZoQ1JQTHZr?=
 =?utf-8?B?eUJuZCtpbDB3Q21VRzVtUGx6d2s1WmN1WUVqU09PZXk1VjltQXdSZ3NhSG9w?=
 =?utf-8?B?bWlQQXJVVk8wMlJ2czRSVXB4RDJ5ZkhoalpzV25wSGhoT2J3a1diUklVelNh?=
 =?utf-8?B?NFUxb0tpTVNYL0orbmZLeENGRkNncWpVOXJnVy9LVDRIQ05SSHo2SGZJckZR?=
 =?utf-8?B?MUtIcEJpSUU4SWdCK1FsZ2kza3FSWWx2TEpPeUk0Umt5YjJ0bS9yUWtuSG9X?=
 =?utf-8?B?OS92UHJKbVhiWkpuc2d6dG1hK0tnK0xpV3NuVG9mRk5vOGNsc1FsVUF0Si9o?=
 =?utf-8?B?N3M0R3BlY2RsazdvcFkwbHFCUnEzQ3Y4Si9WVjVSazFrVllTL1RKT2t2WUQx?=
 =?utf-8?B?U2V5VSsyd3dHa2ZWS0pQY2dObXRBWmFZWlBiOTBac2FHaE1oUjlwbEZGWWFY?=
 =?utf-8?B?RXRWenpIR3p4MlJ3amMvbXdJbGNoakJrUmdTcUFhdVI5ZGNXTUVUbHVlS1R5?=
 =?utf-8?B?UjhoWk5HajMvVUtITVkveG04SEszSkY2RkxVTnk3cDJzWnNmd0xTU3RIWnM5?=
 =?utf-8?B?VUhPY1JKZzdqQ0VpSXJIRnpJNXBYSzFJeENGTG9YbVZxYXJ1d1h4WnZMcklv?=
 =?utf-8?B?bnN1N2hvM3lXYTZ3WGFVS2laSTUxVzNzL2dGdFRQYU43SUQxeVNVWHVQdnM5?=
 =?utf-8?B?SGpKaVNsNGhmMkU2V0dXQUxTdWo4Ni83YWFDUnU5cEdDMUJnYmpOVlFkT0lC?=
 =?utf-8?B?eENHT25RM2ZQNmhvSkJFSEtLRThxd2VIYXRNSVdiNTgyZUZpVXFuTnVOS1BF?=
 =?utf-8?B?MzUxcHNJVXhETm44bUtUQmpmem15cFh3NlF2V2tRNE52VGEyeWNVS2pUM1Yz?=
 =?utf-8?B?ck1yMnIzWXRxa3VSNzlGanhzUVc5ZzBRKzhESktUV1ZkSGw5dVdZdWVCRGpW?=
 =?utf-8?B?ZGFkMHFiV1NUbUNOL081cHExSTRGTEZFR3gwcnRoMGx3a1NoK2hXeFV1cVZZ?=
 =?utf-8?B?dnovL2RZaG5KZUN2OXJFeVZXbW9DVjZJR1BOV0RsWHZoVDc5OHlmOG9yQ21h?=
 =?utf-8?B?Si80dnMvZmFKWWFHUjRHVFRBVURxYnV1WWhWQjJ1SFZIZ2JRSElRRHdQVHlL?=
 =?utf-8?B?RkpqcUlBSEZqbWV3K0VaSllYMjEvbjdpZlppWE54NHlhejhvYXBQRVBYKzVv?=
 =?utf-8?B?TVVkTkJQeE9Tajh0bXFrQVo4RlJmS3VTRU40VFZmKzE4MmNHVE96bW5WbFZ0?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e30570-65c1-402c-5188-08db0df752e4
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 19:20:10.3866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0u09zo08UNt2nBFnD5I1LfpXcxdpaz2A8cM2eQ0ADijDm735wEU49tD8SviyX1DKNojbXCCGo0ZFkzfMogSqgLTAOiXGeufkmBbMN7mb70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6048
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2/13/2023 2:00 AM, Ilpo Järvinen wrote:
> On Mon, 13 Feb 2023, Shaopeng Tan wrote:
> 
>> After creating a child process with fork() in CAT test, if an error
>> occurs when parent process runs cat_val() or check_results(), the child
> 
> I'd replace the rest of the paragraph with this:
> 
> "returns early. The parent will wait pipe message from child which will 
> never be sent by the child and the parent cannot proceeed to unmount 
> resctrlfs."

Note that the description is about an error within the parent process.
In the case snipped above it is the parent that exits early, not the child.
This first paragraph describes two scenarios, (a) error in parent, and (b)
error in child. I think it is good information to keep descriptions of
both scenarios.

The proposed addition could be used to expand the description of the scenario
when an error occurs in the child. In this case please consider changing "wait
pipe message from child" to "wait for the pipe message from the child", and
"proceeed" to "proceed".

Reinette
