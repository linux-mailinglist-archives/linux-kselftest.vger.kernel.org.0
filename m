Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69D37204A5
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 16:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbjFBOkR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 10:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235707AbjFBOkQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 10:40:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D887E43;
        Fri,  2 Jun 2023 07:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685716800; x=1717252800;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ugovOH+0cRQh8aBYa3udjbCU8/iA8sQMCsRcf9uVXYM=;
  b=dNKMDdh8+dNsVwS6iEGB61+vKhB9dzSB4gZ+0W2v0feypobalBq+qKSO
   Rvn7QoRBZrRdc8f/zxthZV+Nk6XfA35U6wiSQ7Ej4Z6Ch3WZZjNt/uF4I
   byok375KByPqb84BZbjeKBgeslErQcn85gHXHsw3CWp6GoOyT7TKV9o1b
   x+19JNKteYO39TCoR11YR8TeUgGWNuMnKQ8OsemdZr1dml+sns+QTyGUk
   Tkwbt708gmgIGfskt0Zsftu463kBss04B75bCA4kmGmE48rU2k7hTzaBj
   MtOKSDlrikcsNyTAZsuwY5+qfQKSalBFgIBDGgC5/VbYcosc6b+og6UXR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="354730140"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="354730140"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 07:39:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="832004588"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="832004588"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 02 Jun 2023 07:39:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 07:39:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 2 Jun 2023 07:39:58 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 2 Jun 2023 07:39:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/5lWpRrOLeZB+ZBd9vS3xYHi2QQQckzW0yRjE34KGbcnvIQ6l9wsi/stcdT4KHU2RD3MkZGIsryFmuNGoBpFRuhT66CjTND8B+2uJCtGJxty80r2jWY2DJz6mqR2oDf5cC95j2/GJRpJVCHmbDaAmHwMjxrLQAeAgXIWSR9oUN6LqFs/Shd2UPwc3y2wmD4o4WluTNbetnbltzafEloMCi5evoAubxgUHMYusxecT4lA0H/vGx7h8uU8MhDEJyPbLoNqEuy6own8P7928ngbrmCEi4Mxs9RyP8A4ej3zp3+yo9hC8eayJbiUQWpXOmET9+4EHNYzK2WLvRC5m28mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qroy97Vfd4a2eS1TDcYITQ0cWTKEge1tQyCiKcscVVY=;
 b=UhnVIYDg5USBjZOT/54xI4gCAqIt4leQPM6lgVKo54GaG/wWKcAu67cKR+EXJ2NI1XaQcyqLQdF5dyKuTD755WuKA69/JSbvcpt/s2qZo6TA5yEHpdOQoV1TjDyT0Q8H6l8SIt+ZcUIngpIvkkxw5VTSzC2cIE4VpMb7W1WUQ1BXe/gPGv9BUXulnITarmcCK9TaeOUVrMXxg3lt88BCspQKAeqVspGC0NdaueLtwJKTgrETZSRe3EeBLFjNDTJU2w//c1AKOHpAI+xt9T4jT7Hjy47PqughyzTdif6ILUv8cHBqf/nC5pTZMrJaJahZni6TJN/dupY7lieBjHYq6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL3PR11MB6364.namprd11.prod.outlook.com (2603:10b6:208:3b7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Fri, 2 Jun
 2023 14:39:34 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6433.025; Fri, 2 Jun 2023
 14:39:34 +0000
Message-ID: <7446607a-5049-59ec-08b7-e9ecc9d22c44@intel.com>
Date:   Fri, 2 Jun 2023 07:39:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2 21/24] selftests/resctrl: Read in less obvious order to
 defeat prefetch optimizations
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-22-ilpo.jarvinen@linux.intel.com>
 <OSZPR01MB6328F2713E40CC7D383035A48B489@OSZPR01MB6328.jpnprd01.prod.outlook.com>
 <c21fb16d-d3ad-bbcb-daed-28f153b64525@linux.intel.com>
 <TYAPR01MB6330025B5E6537F94DA49ACB8B499@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <6d9933e7-63a4-dcb0-9128-12bcf77bb725@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <6d9933e7-63a4-dcb0-9128-12bcf77bb725@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL3PR11MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 03663334-bffc-45b4-f707-08db63772eba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKdJzigWy5Dg1gTJ/bexMXYokMxmquCBEQxoWhjGDogh5LsKjOeCsAG0oTlhUy4mXZsR2qnqfr2naXEKR07F45S3BN0SrcwFzp5aqjTCic4BZM+I31mgsD/nm57dLzdcgvdEtMgxncTP6ylPhvSxKOIEXIGi1oHUJfc/+S113o/yPJ35TUEZdcdwPjdk2az11NNoIKedtnOCUfE+Xvz0CmbSUfufNxfM6Sy/EjrBMGXxMpjm606X1WTTjLYVB9eucH7MXRVAYL2BOq/c3kJR0dBdeD2JyFYrPdtwbvUvansKd/caqGRwqRCFclwJ/YsER9ttP2qcAYZZWgLbKEBzYwHPmk2oagtRnKrnuiMUrC9IslUnYabF5bQ5lGRhPXx3Ehk02DmbxAfRvY/UU9MWhjfuFw4MqB5jlIHP/zRJAG7P1irYMKd1VJt2ktp9k8Aj4m3Y8xxs7WRO0dGxGPA7uDCQ6Nzl6t1lx3NXC23VOX/N54J4FBIbK98rP0z5DlpumY+LI5WTJs3+tIu7RKZXGZuP6onWfnxf1IzTkjX85zyGzCwcrUHSR25BJaCJDb9UWiqfOvbDsjXSDxq46VBxL5xS2hq/aTKDD3dR+a8B/vXqdmKdA8NJVWDnV9RZL0XVIf72tpdnWL/LtkrIEfoCpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199021)(110136005)(86362001)(31696002)(36756003)(38100700002)(82960400001)(54906003)(478600001)(26005)(31686004)(5660300002)(6486002)(4744005)(44832011)(4326008)(2906002)(66476007)(8936002)(66556008)(66946007)(41300700001)(8676002)(316002)(6506007)(186003)(6512007)(2616005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzNEY2srZFovNU9TTUZoYUV0eHo5SWE3THh5RkdVSitYbTlNQ05EUW5zQVZN?=
 =?utf-8?B?QUlhQm1JWkhMTllCdVlMVTY2cE1Rb2tJaWpZU3JUaU5tZFZoRm1sdTRzYWRQ?=
 =?utf-8?B?RHMvbHArVE9XN2ZhMGRPQm9qVXlNMFVkNWJRTUwyOFhiaTBLVit5UUZGS2VT?=
 =?utf-8?B?dUY1c0tBSHh4Q0NsekQyREFMNlJzUUZBZnE3QzNyWll5UmxzMCtvZnlDUWpO?=
 =?utf-8?B?RWRGOW9Ec0N3RnpqOFZLVFFLSTlCVkJIRHNOSm82TUJMdHFXSWR4eXE4NUdr?=
 =?utf-8?B?NnhvbnZvcjl4b1I3c1B0YllsU0xRWVRWZ3pYTnFZbDRJd2d0UURQU2FJMTh4?=
 =?utf-8?B?MVNyTHNvWi9SNmRwd3FyZUxOK1JVMVphZ1kzUWw2UjQ1ZFI2Ums2R002dWhs?=
 =?utf-8?B?VFJqUDIzcUtybWVUbE1nbkNUTUhEaU9yY1FGejNBdlRwUFpNNnpRb0pnQkpI?=
 =?utf-8?B?Qm1Ycmt6TmxzLzRON0lKVlJ0RHhuSUcrOVpYaDVqVnFHMXRFbysvekdSK2ow?=
 =?utf-8?B?QnF2bjVkZGc2ejg3RGx6a0Y0SllVMm04c3liZDhubVdQODJoWXg1SS9ZZ2h1?=
 =?utf-8?B?SUc0N2V5WmJSeUI3T2xxUUdMSHdGdDY1VVQ5YkdQWityS3JOL2VsUzZDUzR3?=
 =?utf-8?B?dWQyVlJPc3BoZXNSV3Z1Vy9OQTRHZHZJdzFnc2cxQWY3S2JyVXJoY09vME1L?=
 =?utf-8?B?dUpqNjlIRTY5S3lmeWc4dEgyakwwenZ4L2loRUg2cHFMbHVjbmlNVElQdmdW?=
 =?utf-8?B?dklPTUJNSnVEWVY1dVk0blRJQ1NGSDAwVDRvSXFXWUxqQS8zV0h0bTVpME5G?=
 =?utf-8?B?eElQZjJDU1pZUXUzMXBMWktxN09ROGJDbS9NcEhnRzhOY0NDQzBndjYvQ2lK?=
 =?utf-8?B?ZTlFaXJTcHV4ekdNOXJDYTY4MWpyWm9RS0RsN1lvSXc2VzZTN0N5WUZCbW51?=
 =?utf-8?B?M3ZHOS95REQ0dGUrWUpScmdVcW1GZTU5amhqdmgvVlFvc2RZdUV6RlNDbTRB?=
 =?utf-8?B?UkYwU24zZWYzRTBOY3dhYlU2cEdGdWZucmh2MFd2b2lwMVFUQVFidkpzbWMv?=
 =?utf-8?B?RkxBbVBaMm8zd2RZYTh3cFB1cDRlQXJLWDFETUlNUjlmTSt6UDZOdGJQbmFK?=
 =?utf-8?B?bnhIN1ZkQXF1bjE5bGU5MEdqVUFBbHdjUkkvY1BwdEpaYWdMME5hak1YbG4v?=
 =?utf-8?B?QWZpZkYxV1VOdy9DK2t0c1FBejI1R25zRk4rVklscUF0ZUw5WWxQQ2hBVXl4?=
 =?utf-8?B?RkszQ0pzNWdyM001RTNFUUtPQVFEdTdyaGEvY2hJbXNPUlMyZ3Y3V2lUUlpF?=
 =?utf-8?B?aytOUmFraVhTblcva0tlOTFxQ3FJRE9adTB4NlJiQkZpcTF3SUNLUUtDRFcv?=
 =?utf-8?B?WDZiRTNpcU1hZ2RpV3VobFBINXN0ck0yaERCdGNsdG40cnN5YXJjRkhXOXZk?=
 =?utf-8?B?bTNSS2V2SUs5UW5nbE5OYmJlRmkrVURkNUhTZXM2cjN4WTlJNG43NW9nSWd1?=
 =?utf-8?B?RHVFZUVxM1AvK2s4azBVZGpxRy83Z3prcjJzL0tRRkRkckFTSEpueGhickM3?=
 =?utf-8?B?VzU5aWJJSDZQbGd5WXE4VW5PdElOTkNjRDBueTJyOWxZcW1DNW5XZExyaVE0?=
 =?utf-8?B?Zm5XVVdWZDQwTXVJU1BOcVE4VmttNWVhVnZvNEcrVXV3djh4eU9lckRBRmp3?=
 =?utf-8?B?OWU0ZWFFejdmMk1sV0E0VzJ6aFNMVVFPNVk4aWdNWVIyZDJPMlgyUFYxTkEw?=
 =?utf-8?B?SHord3hPN1hnUWtKYlExRHgyMHZKMjJTR21mdCtCeDlKWTVzakNORVhtWktj?=
 =?utf-8?B?aENVWFZ4amhpa2tURmRsTC9xUFgvNHBYNFFEckNjNldMeUZUa1V4SFg1aHlW?=
 =?utf-8?B?MXdKZFNlcVBzQlZSc09SMWVJUmRaYUhROWdjcEJ5QU84N1luWGlROEExdFQ4?=
 =?utf-8?B?bGlieXEvR3ZoWDh1NHNTR2R1bjJUS1F2c3czNWQzbUFrTGhzKzF3OWFCRmpw?=
 =?utf-8?B?MW1YS1dGWS91ak9uNWxRcEJseEFqMmR6ZDFPMHhwSWVHMFZ0OHNuc1A5R1BR?=
 =?utf-8?B?bkl2cy8rOFM3UjRTTWs1Y0kveGxKcWZoVkhaL0xLc2ZXR3BrY2kzRS9nYXVk?=
 =?utf-8?B?V1o0dzVaTlRjZThiN21SVGVudkptOWJDZG9LaFpGa2NSdDdqUTB2QlNEdHRS?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03663334-bffc-45b4-f707-08db63772eba
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 14:39:34.0769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOi+hUUnESmIeVvtt1e9EZGwC2g2vmwe9osmdqVAwK4mHL7LcCAALTSr8Hufke3Dr4r8w0Vnb9hsMeP5PqTdREWeNjjSOFoTEo7MgneP/aM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6364
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 6/2/2023 6:51 AM, Ilpo Järvinen wrote:
> It will probably take some time... Should I send a v3 with only the fixes 
> and useful refactors at the head of this series while I try to sort these 
> problems with the test changes out?

This sounds good to me. This series is already at 24 patches so I think that
splitting the redesign of the CAT test from the other fixes would indeed make
this work easier to parse.

Thank you

Reinette
