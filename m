Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F1977BF42
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 19:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjHNRt5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 13:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjHNRtw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 13:49:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52AD1711;
        Mon, 14 Aug 2023 10:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692035382; x=1723571382;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=92F5fX0Qdw2yL0d7ZwfSGdwXcsadFHGgVA144zRPWRA=;
  b=T708BCmmQhhgUDbVzIfK9PyXGWsjLCQa281TmDMuiv+XUIFC7BV6IDk7
   vrhPMcYtCZlAFyVbl7V/Usr5ilFCeuXlqWaGQ5AlAXQiEq7AwLjmiPyT0
   Fs0hoq2PziXY0A2d0uJGYNiugvpeC5d2oE/qwlbQJ4a6PQiDi+MpByGwh
   FicNQS3IYI4kedhgrplCb+bRRqwXcIOzhEcyAMfCcrhj+JlNGotK4MfhM
   Ebiuhgg1927yPXeFt7SgJGDXfv65gstbm4tsF6+peyb7GJkdJp4w/kwqw
   p06yPtnDNvMZ5+H1S5ZDhsZ8EGiRN8/ObjBg955i5eGA5J4udyklWDPwf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="357066617"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="357066617"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 10:49:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="736603741"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="736603741"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 14 Aug 2023 10:49:25 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 10:49:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 10:49:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 10:49:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eItO8nW91HSJGDKWgR6xtuZCL34NxuWEwLoLa4sKR5ScqmuV061Rzvumdwqt3Eafc/45syQZBEC2kUvMxcVkY9PND7My9X5N655FMhmCyaowSyDSntv0ozK5NAyDw26C2hoO/g85ttTU5HfurRYc4+WRoUbEfmN+qkq06fSjVYgN4tTCPyWr6ZWEV8Rm6Tp8bdIqdPTSpVsq1tvMcqAGkTTw6yZC6qkYGmTgX7MksMR2S6edxDWytxtIJe5rXD7/7aQLN3D4/fjr1xmpJ7EuITrei2QLEyXHY3S87dcjYpxyRucZ5tJZKtPpwugyZ41RQtVhi51m1YcYmdJIuaaIaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnU5mLk5O8OwSeblHfoKwvYj2VVr82YHLxLwZUh0IAk=;
 b=OaAReZas76lXPfdetZT19LoM0BvqX9hyi4/6t3wzUJ/PNT7f2yRuflvlpZodGpZpJVoi3IOsj/TThfqrwE8MLZ6RcsH/bX5WyAl5M7ofGCkRmcV3A8PUJ+Ko7FMkLOHhPCA9Dg/qgoGvEJyzXI/VuMUUIKaEUBtWRbzHdFZYcmaYZUJFg73MrslSPMCXp5XLqMpIcPqwrROfw35JsipfLmHt562cHivlJ5zm/HPkrYqtoAkA7Q18Gx3Veif0SALqxsacNwGrp3hvx5+WAQelWW5paMr0n2oKCcxXgyn6USd1uwwj215lmWp2X7rbsW1JjWY9rbCiksUo5ZtJK2eY/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL1PR11MB5317.namprd11.prod.outlook.com (2603:10b6:208:309::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 17:49:23 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 17:49:22 +0000
Message-ID: <a5cdcc14-0115-2863-eaa6-4c3cac87485c@intel.com>
Date:   Mon, 14 Aug 2023 10:49:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH 3/7] selftests/resctrl: Remove bw_report and bm_type from
 main()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230808091625.12760-1-ilpo.jarvinen@linux.intel.com>
 <20230808091625.12760-4-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230808091625.12760-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWH0EPF00056D1B.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL1PR11MB5317:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c87bed-63ef-4c9f-297e-08db9ceecb1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fBXbXKrx6I95QFi4OcxQQv+N2DvKQRYYplI4o61gvHNSvqsYFqCaxrAgwplCxvljUvuy8F8OBZyum4q4V0U+ZAfXzrOM+z1DZDxZhp/5tp62coq0sBGN2sUBz9wu/jFIbc+CbRKN2cUj7QU4Tnz1BqpFhgkryZQJn7WNw71yyvuD5zcpfH1hMRVox1xozk2ZqDgJStuDE6JRLDxsqLS8jl+U2Eh/nERjvGGbAfTWe959ffCEgjvxG5vL2y8nvTuDWBEqSSU92FnT8uAkKpfLZtygfov4i/8Pfz3LL5uHJiqlsCrnzvWN8SoEuWHwnO03PSgYYKeYFo/8MSTahfWUJviDA/guzu5XKw6dlp8SoWoiZpm/QvuPmWP1+BNBzq2W1o0gE7OtX7d9p5OPSUNjuk/h7Gw4UaKJ5l+oXljQ+3VL49Fb/+C+vEvvhqGBQdTezET7W/pzDPZ079NTuyzO9z+geGVodHs6bz/ehEX8RUPbEkN5gTmakVxcgtFegFecq8icLlEJK5/RtgAtEYioW4zZiRr8HMtlr+mdLe+WMJCkHdP0oibCpWdpb9rTYg/waQczLwjhCApxztG4HXTHm+CGgaDbsq7r9GMdWF4ukNsPS3d0zDVqt9bjeRv+B3umPdoJL+TKYieTAsg2Y4Vp9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(366004)(376002)(39860400002)(1800799006)(186006)(451199021)(6506007)(53546011)(26005)(8936002)(41300700001)(66476007)(66556008)(66946007)(8676002)(316002)(6512007)(31686004)(2616005)(6486002)(478600001)(38100700002)(110136005)(44832011)(31696002)(36756003)(4744005)(86362001)(4326008)(82960400001)(2906002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlpDK3ZOODY3ZXBxc0ViUXFYV1B3WXJ2WEJHZmwzTzBZcjErbzFVTUxJYXhZ?=
 =?utf-8?B?czRKNzFaTGcxNEQxS0E5SFFOQURxTWJtN2VWSmh2R1d1V3V0Qjdqa2tBOUJr?=
 =?utf-8?B?SmhNSXM2Z1Z3R1RLNWFaVW5pL2UzSkprb2NialFxQzlXWUZLNll0NnZlcVVE?=
 =?utf-8?B?UWRybnV4b0REajNNa3R0WEtGb0o2M2xyZnVYSE5OaXNZbm1KTytFUmhpa2ky?=
 =?utf-8?B?V0k2Y1M0cmNMN0xsVjlOMmcvcGV4cDQvblR4QzBQalA4M1krUkFQZm1VQXdp?=
 =?utf-8?B?YStCdWNnWmZuMFFVOTV6UU1UUzg5MzRpY0h5NVRPOGY1VXBkQ3E5Sm5uVTA3?=
 =?utf-8?B?YTVncEVTSUVuY3ZTSktsRVg5WGk4aUFTcGorUDRVRWw5RFRsZHExbHhoczlV?=
 =?utf-8?B?bmhFblRuRnduVVFlelJXazlQKzNCUE40bjIwQzJhc1Ayc1RjSGx1c3FWOHRV?=
 =?utf-8?B?V3RrVkl6MFV2UGZDWW93N0lUVkNiTXBvWHBPeUNvRkN1cS9TTHVHNE5Sckx0?=
 =?utf-8?B?RkNZdVZjcWtlKytRYSttb0tQWm5Yd2F4eGNWMzZ5V0VTYVBuQ0ZjQmxqOUs0?=
 =?utf-8?B?UmFMRVNtNXlTYTN1ZktFSWNDMUtmUjI1Vzl4Ni9tZXRuam5kRWl5UXNScWVh?=
 =?utf-8?B?Wk5EL0ptTTFpcTZwN0ltWGhnMm55ajJuZSsrYm5tcU4zdlplTlEveVhVaVZ0?=
 =?utf-8?B?OFJRM0VWL2FsNzcvdk1GWWhkdllCbkdWaks3UWYwNHNmNVZjZHBiUUtnN0NO?=
 =?utf-8?B?ZjFqVEpQODVoQXc3WllyVnBpcng3ckIvckJKdDNPSnRvRXZMbGpHbEZlekwx?=
 =?utf-8?B?YnIyVGZKTnV2MElXV0RzTVBOajNPWk84VlBDRE5YdVNPUDJpdmJPdmZwd3pr?=
 =?utf-8?B?ZWh0bEZ2cWlCUnQyOFEyQmc2WkdMYWVacVVGUGNCVlRxZ0NTd1ArZ2VQaWRm?=
 =?utf-8?B?a1pkQTRQOTE0c2xraUE5UGRiTlVLSFJsZ3N6bXdteC9HZUhrV2NETGhFL25P?=
 =?utf-8?B?bUdWNitvTXNyYTFocWV6U25uMi81QkhPZVFNdUp5L00xb2RDOXRYT3lVMENn?=
 =?utf-8?B?QjJ2bUVQc2JVbVUycDVuRjVJTnIxbVFMc1RIQ0UxNzlQb2tReTdCaWZzK0R3?=
 =?utf-8?B?R1dsTTJCSmhqQWNzbXJ2UmFpN2dmeGRHSnpLb1RXV0RLbHJKbFcxK1lGUGl4?=
 =?utf-8?B?bEFUM0VLYitlVUMvL0pVaExXM0tHa25jeGJjUWJuZ2lIL09sRkhsbUhOU3Ew?=
 =?utf-8?B?MTlvalBtT3NFdHVGUy9MOCttODIzc0NIblc4R2VaYklmeWVITk5GY21vaFU4?=
 =?utf-8?B?T1gvU1FLVnRtNFpXaHNXTmZrVUZxQ2w2REJMYTFDOHA0NUtsa3MwaFZ6SHAx?=
 =?utf-8?B?aWR0VnA3NWNHdExPWnR0SXhwcmlyUHBJdXFqWXp3eVZFa3dJalpIK3U3WUxK?=
 =?utf-8?B?WTFsYmVvc1Y3SERDWXc1WEJRNWNYS0dHYjJ4YTVTOG0rVzJ4RHZ6TFB6TVYz?=
 =?utf-8?B?dWlidnUxUlNHZEdHTGFBYUVyR1h4VWJ1VnpZemptelhWUjk5M3o0U0Iwa1JG?=
 =?utf-8?B?b3RoczA5TFJva3dUUVVUNGJWUXl5cExaekdJODFJMnpSdkZQY296RHlzYUxO?=
 =?utf-8?B?Qi9wZlRwZDlKeVkvZEo5RVdBTG82MGltR2x2RFRLU1hpVUZxSjlHSk1mZUtN?=
 =?utf-8?B?cXdLUUFtZ2F0SlNac25vbDB3UExQWC9TTjMrTVJGb3pvc1hqV3k3OENJOERk?=
 =?utf-8?B?a2RTSmZLa0hOWDVMbE5nVnhDb2E3cWo3alRkNyttVVMzQnVJQUszaVhENUVy?=
 =?utf-8?B?QXZ0VlhxQTI3RkE3dUJJWHUvWFBMV0FKcHhVTTlsbHdsaUsyU0JjTmZ3VDRa?=
 =?utf-8?B?RWFtaGI4TDg5czhDbDNwOC9kUDUxNW81Qk5seDV6Y0JJNVhsNHJwdnN6eEN1?=
 =?utf-8?B?OW1HZnVCeXRaRVJhbmt5L1VTa3hnN3gvMU4rRnlwcVRhS28xOFhyNDJWdEZB?=
 =?utf-8?B?V0cwT1NCN01YMWI5UllVazJVcEdQNU5GRzZkTGFpNzhod0NsL2x0dE9vWDZP?=
 =?utf-8?B?TUozY3NIcTdDZWJqYTZVdTA2Ym5oVGhXd0puY3RMYWhycmQzYVI2allkSzhN?=
 =?utf-8?B?K2VsN3luMW5lMUdVVWQrSXNyNnFhSHhYa2QyQUlPV2lvMFA1Zkl3a2JTZHNt?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c87bed-63ef-4c9f-297e-08db9ceecb1f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 17:49:22.8774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYHiyLGMZ2QCuz0QV4Gr7tjkUocCeWf3PBEyGeSoqx/+RHIJijAS/iWiXOMLLOwhn+uGxP4K4M6bywnvQLQRxKq1c+NPVKGcA4wpGQbC4do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5317
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 8/8/2023 2:16 AM, Ilpo Järvinen wrote:
> bw_report is always set to "reads" and bm_type is set to "fill_buf" but
> is never used.
> 
> Set bw_report directly to "reads" in MBA/MBM test and remove bm_type.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
