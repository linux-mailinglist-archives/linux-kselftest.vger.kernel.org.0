Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EAD696AAF
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 18:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjBNRCw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 12:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjBNRC3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 12:02:29 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A112ED53;
        Tue, 14 Feb 2023 09:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676394121; x=1707930121;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3h7/RUKssE4FxkrHfuI/X8/biz37E8CNKUkB8VWIkQk=;
  b=kZb2qx5eYTMauqiU2o8vWYiN1ghVPt74SCBkZYkO6QcsO9gOmpUzMIWt
   E40/lHCXO92MTiz2bwrdls5ZP996CK2oWG/8xRTpIAV8OdXOPgIFrQDUK
   Got+SjWKqcRz3818+f4JbkVZ3hrx4430msynMjyXvg8jqRlgk8smvm4+D
   vBDIw83TOuzXqTw26CB9PO/PGF0igcxMSpzHoY1SORpW+6NDu/PIKyQDO
   6N4SaapY3Msf9HuNZ3Sr5cgHSDv0C2GpQ2nDMmWpuDptdGCJ9ygujol01
   pZAazAJ7VvLwjBvx0HgLIm0iG1/Y16wWVaZS+rIyU+ayCCr+ZGLV6BsYx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="311569010"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="311569010"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 09:01:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="646822514"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="646822514"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 14 Feb 2023 09:01:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 09:01:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 09:01:40 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 09:01:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leMSvoE3bzXccVqRxrS9yWX2WJXkKgjXnSoELFWJJYen8PdC/ze5YdWATOQNg5/zNF4C6XHhEHYarsNrvj9100bY5jb09om9trHkU5xN4Ypzt1DsrrdABqneEhbTsRBB1cHuqgeHjsEfm/tLycZJ5E7GROhzgznvLipytJTdC2L++ERbUBPAQCfTGdJP/gyFLAWmgDpCicUzJTh5Lj8XGgCLZkXx4YfCA+8IuE6A8t3iejOmOQqvKU5sWyDtP5bDLIci3ifmeHiMa0HPm3APkzpq/UCalyoGtRIOCcjcrQiSFT6Q1U3Wgts2Zv71MIeXjdErlF87Q4c9Ly6zQSfCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H52paUuU6n65PK+TAC+OlUd2Ns4+UFXm/MAXzelWwdU=;
 b=bHkOLlhN3Pdyxylarqy1sYQY1B81//lidJvabCE296ZPOYsklH4gmbgmtl9Wr3zIOZWznkkqyfN0houIaUiOZMlVSIa54wqgFYqoS385CXEv/o1HeLrjWU+jMlzI6GfCljCofXod6lPOkXZqLW3jqKL14cGk4SOf96LYiNq71RiRMb9+z3ICkMl3bWjrAGn2/ITlBeqaaBxepogMiwJ1NkUyVBJLHSjyMi2EwSd2JSsyOqRx2E1qodelXsj/EpR6HaK1DRYJU/YaLQuXB28D388ivuLVV7jDFl/eGx+eXHFQax+TWJ3dUiGxBSij5QYBuK6NZ7iJUuuYpit/lwKVdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CY8PR11MB6914.namprd11.prod.outlook.com (2603:10b6:930:5a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Tue, 14 Feb
 2023 17:01:38 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6086.024; Tue, 14 Feb
 2023 17:01:38 +0000
Message-ID: <14087d49-1d21-afa7-601f-f43a90665052@intel.com>
Date:   Tue, 14 Feb 2023 09:01:36 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH 2/4] selftests/resctrl: Don't hard code divisor in MBM
 results
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
References: <20230208094026.22529-1-ilpo.jarvinen@linux.intel.com>
 <20230208094026.22529-3-ilpo.jarvinen@linux.intel.com>
 <8ed0dcbd-86af-2658-95de-fdccffba7728@intel.com>
 <346283c6-b5a5-ad35-7a90-fd17858be46f@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <346283c6-b5a5-ad35-7a90-fd17858be46f@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CY8PR11MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c0099b4-434c-4a73-0b34-08db0ead230f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tj9thamndTa2LiyRovAdpmFNVQ7wQGTQl9XUvaBeEa4mA6U6hTxEfV7/4SGv5aVNXTqKUDsYpXmLnsreBfPzWZlvQ5elf+cC2xC2cPGahchmTHjuxswi5sgN3KkdiXNQrubegFz4MGpTopW9GkIpVSA3KS8Gz3rZbBUhJQMSIjRhtAy+pxj5CahNZJDCCJNBlSNQYF0gZ8a2w89J7AIBGMBeodPZOz5m1dlnJOSLILP/1hnfkOVCDgGF4aRRGlPUU83G6OkQSiMufEVIR8kqsiUtOqCBNC5TDf+OsAI8DxBq7L+HhO0ASCJmMK7P9zn6DknVPmWxCf40RyMcFA0lSNl+8NNTASlMqzh7yf7+9IQNt8d/PnzQA4lbSvbXxI556ASgKemWHh/bqrPvVCdWx/K7u3laNjvFpZnvYC8h3jFLx54UIqapTX6gnS+a+P1Qx7M91UIDsoCXQd7GiSiXOK8JTQLj25Qpji3Srq3dbrAkDb6y1XFrZY9PeIJKUNP0iIxRMCXQuatE+/tVgefhSkO6oz/eRXVTJBvA+jGAb5c5ErvAQ09uQ+Az8J5yGVw60rlWNsB0njlcIInMwkIxZfXDM92CglAp1/2uYtyEjK4L24PfoXt0p0mXjKEB+vTHqQPFG3jFNGajcBA3ll9F4YcWDejB0SIme5rLrNPxnXC147WijM0ZxPg4XcYlnAYLIDw1muulX8bGf1/mAiWbDdVAOL5nQHepgYDSxDtPlPQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199018)(8936002)(31686004)(5660300002)(41300700001)(38100700002)(66946007)(44832011)(2906002)(4326008)(82960400001)(66556008)(66476007)(8676002)(6916009)(316002)(478600001)(86362001)(36756003)(186003)(26005)(6486002)(2616005)(54906003)(83380400001)(53546011)(6506007)(6512007)(31696002)(66574015)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dis1ZWhHTzBSQTJCQmllak1nSkxseW9YMUtQNUVJdEFqYWQ5a2NRbzBPNXF6?=
 =?utf-8?B?WHhjeHgwWklxdSszaGRka1NueUVRVHU4ZlpTNHQ2OXMzeVc3dktPUGc0UUJz?=
 =?utf-8?B?eDMvTGdIbGNvK1FoTFZqc2VPNkxtV2lvNlNEUWgzTjdJbEdVSTNUc3V3bzho?=
 =?utf-8?B?SnE2TG5sOVFXTkpuakpaSEpTSG0wMGhKMzVXVFVPclA4S284WE9vRHpzM0ZT?=
 =?utf-8?B?NFkzRGNuRmpDVWE3M3dYKzkySzJ1Sm05dmtyd0p0TUV4c2pVSFVPSHBzYmw3?=
 =?utf-8?B?ZVIrY1J4K1JaNGlXOG1uYVlKUllIT0V2WnJaSGVTZ3ErZFJQdDM5bTVsWCsx?=
 =?utf-8?B?c3laaTVvZE9FMkhyOUR6NjNPUHI5UHdlUHQ2RFNidU1TendhMjBFajd4UkJ4?=
 =?utf-8?B?QkE2akt4NFhiNXI4U090UHp6d1I2SFJ5VjZ3a0tIWHdCa0VBeXNqQkxhTVlq?=
 =?utf-8?B?MnF0UGM2aEZMaENBWjYvSURWeVM0V2cwWnhDUFBVQWZzblJlUXlyRjVhLy9w?=
 =?utf-8?B?SVdXRlR0VVowbElRbFZ3dzdIL0RPV3ovKzVwZGZWa0l4b3NJZWo2aFc3U0hZ?=
 =?utf-8?B?Y2o3NnB1S25TK3d3UmpuTHhMSWFNMzNsMnU2RU5oK25JQy9WSGRXQm5VSDJZ?=
 =?utf-8?B?cStFN3lGZ1A0VU93UG95cmY4aUd5dStlWDNTb2hjYUo0cXNBNHNkMkwvZzBn?=
 =?utf-8?B?SExUMlhONWdwTURsdWFFTkVReGI5SnNFUVMvYmYyemVpeGRmV212a1QzaVgv?=
 =?utf-8?B?K1JuS3NvcWVUTnArNXRHcmd5UDVEZUhpaFVpOXNaNlo5a0JOWnN5L2wxRmlT?=
 =?utf-8?B?M0l1Z1JqSkJac1YzVFJoL3g5cndoZFk4NXJocW5zNkdCYWtxb01nT0t2Rndv?=
 =?utf-8?B?REZodGI5VVM5TFdXYkhyT0RlNEphaU1iNWNML3A1eGNraDdXOVFiTU9mVjhz?=
 =?utf-8?B?UTBSdjNHQWMvOXg0R25WM2FHZjVYMWVsQXhSbGl1cFRKUXNFK3ZMUC83ZEtm?=
 =?utf-8?B?RkdBRlhwL05qdlh0RCt6ZzBCblVyelQ2aWJxMGtJR29XSEtjUHVxbUE1cWM5?=
 =?utf-8?B?QjVSKzJvL2c5U0puQnk5ZDBvZUVYdWd4Ynd3VmpyUFMzZ2VZRXM4SVNFeVJX?=
 =?utf-8?B?c282ZmxzRDgrMHBiYzB2RXpXRVJOSTErSUpJbGZ4U09LZVlSYU4rdmVjYTVH?=
 =?utf-8?B?UEJla1VRZnpBcW1nRnVoS3hWRFU3amozYTlML2JrQjFCckdVa2k0NU45SFZH?=
 =?utf-8?B?dm1SWDIzYkI2SEJMcTR2V2hZeGJNSzRuSy9YcDJoSUI4QjBJanMvRmNadDRN?=
 =?utf-8?B?cEovQXZ1L1kxcWxXTTU2OWdTRFVRUWVWZFNIQzRDMnV5U2ZsSkxta1JqS3pv?=
 =?utf-8?B?ZTJ4dGgzcmM0bmxQUFlOMUw4a2lPZDE0OTVvNjdVUEEwMmlPUVYwWlcyYWJ6?=
 =?utf-8?B?MVRwRlZzMVJDTVN3UU5VejJMYktmbTVJdmdCb2Y1MXV0YlpYK3hjaWlndGhq?=
 =?utf-8?B?Zlg2b2FvbWRRSUd3UHZuZ2lFS1ZwV3ZTWTk0eW5IUXNvbDNVb0hsdnNRT0N4?=
 =?utf-8?B?TzdMbnBQN2dlYjV4Mmp4bktKTG02U212RXFmRk8yL3R4V0wrQllicVRmS0pk?=
 =?utf-8?B?K283K1JIYkEzbHZzS2E4dUJ5dDRZM1ZuUWdmZUFyNjFpTkZIT0tlV2xoUUtK?=
 =?utf-8?B?Rzh6dGp1U2Z1cnZEelgyMlcrMkxHeGE1YlRWRmZSM0NpSE01cW5RSS9HQzc0?=
 =?utf-8?B?OWMzL2FLTk95cnFMY3JITllWTnE0ekN6VVpBemdvQWY5NzFoQml0b3dxbXZF?=
 =?utf-8?B?Q2VzbU00dUhFV0xkSkpPMmQreldwclVkZjI0bFlyWDdjbkhvMk1OT3Y0UzVt?=
 =?utf-8?B?R0xQbDE1YnhPWHVwbi96QURqMmYycGYyZkR4M2x1RjdBYnRPUzdhZE5IWnFo?=
 =?utf-8?B?K0pWVUNEWEZ1alR1MytPSkFqaVVseWJWYmNXTk9MZWNuaFJhY2NaeTA0OTl6?=
 =?utf-8?B?bFRDZ08reWZQOVg4eklIZ2tRYlpCQ3NPQmhaR0xtMWhEVUZjd1E0QW0zeUYv?=
 =?utf-8?B?OEZVRW9mYm1ZSnFhTFUydHM4RlQ3YXpFaTZPci9EajliWm9UUHFvR1lRZStT?=
 =?utf-8?B?MDkwNzBVL2Y3VWNPREpwMElHbDkxTXRmdlZ2L0xVSUh0anFmTVMwbDVod2R1?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0099b4-434c-4a73-0b34-08db0ead230f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 17:01:38.5564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOBpbCKYhVnQDpVupT1rnWUeCo9aYovSlrbpSTX6k8IIg30QcBPW5L9CAEWKDXeTXPSiBg/mSDAyn7YOlEzqQ/6Kq6OuwAipRC1uBFOa/+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6914
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 2/14/2023 2:00 AM, Ilpo Järvinen wrote:
> On Mon, 13 Feb 2023, Reinette Chatre wrote:
>> On 2/8/2023 1:40 AM, Ilpo Järvinen wrote:
>>> From: Fenghua Yu <fenghua.yu@intel.com>
>>>
>>> Presently, while calculating MBM results, the divisor is hard coded as 4.
>>
>> "Presently" can be removed. Here and in the rest of the series the usage of
>> "presently" and "currently" can usually be removed to improve clarity.
>>
>>> It's hard coded to 4 because "NUM_OF_RUNS" is defined as 5 and the test
>>> does not count first result and hence 4. So, instead of hard coding the
>>> value to 4, change it to NUM_OF_RUNS - 1.
>>
>> Are there any plans surrounding using struct resctrl_val_param::num_of_runs
>> instead?
> 
> Actually no.
> 
> What I'd want to do is that the functions which call these result 
> calculator functions would specify the number of tests they passed
> into the result calculator. It seems safer because the results are read 

Would it not simplify things to pass the test parameters (struct resctrl_val_param)
to the result calculator? That contains the number of tests run and would
reign in the hard coding.

> back from a file which could have changed (or got deleted due to an 
> ipc bug prematurely cleaning up the file) and would better take account 
> those cases where the first value is skipped when reading the results.
> 

This sounds good. Thank you.

Reinette


