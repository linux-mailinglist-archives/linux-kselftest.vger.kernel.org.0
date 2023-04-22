Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2ACB6EB644
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Apr 2023 02:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbjDVAMn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 20:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDVAMk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 20:12:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC86BDD;
        Fri, 21 Apr 2023 17:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682122359; x=1713658359;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8Pa+qd8/nZniz7fJtTYPH6jq6FoWtvZ5EcEVzL/LTho=;
  b=g86AxYIBuySNSpavVv0uEOUG8XerbVMWxW9iTfBjJga0DhbbYZDEQQeu
   fosF2C8gJvSEG67PJozJ/Fd4anVXY5hWGpnbqC8+KwBtjlx3KSJjfoXXt
   5BrupzBehoB/QDXfGIo0h+M/UBgddjBBnifRixEqQ2DBU1kiXBiLIGPCV
   G89D76o8qwEVAMeaN54jvWeIvFw+oI6I5YpmJm0ZTTSuAaWWbaVnP9Vtn
   S/F/CzERgfFDbw51ERHiFjEtCNbc3hBV8uU5edVaXxIO9nBAfw1xBOpYB
   SibhheGG8Q74BLJ4XQPS30Gv0NlAfrgKM3lEU8cF9BGtYh4HmI4qI53Dc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="348905660"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="348905660"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 17:12:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="781776103"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="781776103"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Apr 2023 17:12:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:12:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 17:12:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 17:12:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4F1+ChyW5uHTFxzvvke9Y4uNek+2usPoGzagYojohTC4Z189WsI7vuaQgjIG+oyk3QOGPKI6CcsvkNDOCa8gh9Uj9ATOPc/e6mV1v13uI3HOyZb3hP7qrsAnQeKs8SOPPvVLswLA2+YQ/DhzEp4bPzOAH87QgCF9AD1kfcup3ATA55KIEDsK1RqKYyhR8DantK4CFh3tT4Cmb9v5ekccHXiJIYLvBNWWzUWrzJABfqvJxXRy31or+dv5yGxybck0OUYUEjGvABUg5NiXCDAjvtMO+JdNDtHQeJ5pNNTXmgl4Mv8tWTPRGRlP+QqbCBCgxHfXZD9u/6KIb63ROUMlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UnQmxYaREBUybIr/NfxclRvo0dalm+dl8HvhBi6WBc=;
 b=TGXj4jcTbVBip5kZsgTlRj9g2scjj7kz6aGYIt3fjZ2S4u9Sc7D3NoqnGVbfsrT3mZrrSgrRi8vV4dpq6O8Y0HSMhR69ZSTJdx0YtA4UXrVZUU9/S7IjlFaziBXc0Ircep6kMx+cDQM0uh37CAU4edVMRBdM95ja78QFrTB7nnqZBXI3IIfI1/qml+dk6G87JsGQrh1pR9hc14ORdNEp5Q2sWyo8VFmRbn6UUz/QHKcAJE4DVUoAPFlKAiyeHDUmctzeK7Pg3YGr3X3KNHNUFw0wVdz+UZgoznC2bO7ztJE811zzhB9QRKE7j286DwsCisOP49Z2cgZMuH4TBlDK/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BN9PR11MB5227.namprd11.prod.outlook.com (2603:10b6:408:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sat, 22 Apr
 2023 00:12:37 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6%4]) with mapi id 15.20.6319.022; Sat, 22 Apr 2023
 00:12:37 +0000
Message-ID: <83a61c92-01bf-0ac3-709d-7ba2ed0259b2@intel.com>
Date:   Fri, 21 Apr 2023 17:12:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 05/24] selftests/resctrl: Make span unsigned long
 everywhere
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Shuah Khan" <shuah@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-6-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230418114506.46788-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0014.namprd21.prod.outlook.com
 (2603:10b6:a03:114::24) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|BN9PR11MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: 7897c56a-3acb-41df-108c-08db42c64706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ps/29u689C06d8xhXeic77M40iyIuo51oqe3aNmOmlXbNtq/oY5eJZwMPLyml9vNL+kq5fPXIv3eRzo9lo3NH/TVQwpHCve7OqDfBSmli69Qj84ootQ1+zR11AFk26WtMIAatVkGlkXqqejoyoh6qHOsnLuqAGhP8LYBDNuyn9XpnF6vXXgVgJsQAZ3DNekDgDmD7l0IN9JGi4gpUXY0qharU7LUvIxrh9ggwwWJ4nygKCJUMTBd73E6HZG4AIPaCwAqdeZNLb67CVK8Pnxg83QFsrAJGWjReCLswJFWRIVgtT3Qk1LfLPSaEr2MmOMmbk1BrxGngbKSUhdxJTbdXrHjWpGRCYWKCT8VwZV0LDAddkZ6iv5hIJK2mr63kHYeeZZSzJZDkjTFCWr8kYLY/jnV+oMg9gWVcJqfL9dU+Ze05jUZHOMx/f7zHzrmcne9pkPOxPEFM3+Y/r7vgYIdzE/RAVNzRZJcdCdEAwDNYHIhJpDCVWRsjDxzCP3CCt27qi5j11JZpjWH3P44aj0gjty/Qwp5+GydQkxgALjEy03qfXmzXjx67ycY0mTtayhswaZA2rHUMEZ0/LkzrmzcCeWyHBUjaoyZSC6Tr9DeJMbiF2njJns51VSmnJWry9zD9MUbeqPk7CTg480omq0++w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(4744005)(2906002)(8936002)(8676002)(38100700002)(44832011)(5660300002)(36756003)(86362001)(31696002)(6506007)(6486002)(6666004)(6512007)(26005)(110136005)(2616005)(31686004)(478600001)(4326008)(186003)(316002)(53546011)(82960400001)(66556008)(66476007)(66946007)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTZPVmhyOHM3UTNkanA0SzhwNTFmcFZJdFBBSTBJVU04TzI2bkJDMG55d3Rs?=
 =?utf-8?B?SjJsUXZ4VFJkL2VPTzlBU09TS0VzRFlIT1ZWd0JLaUpsSGRtczhCTVF6YktB?=
 =?utf-8?B?YWUrZlJEMVhUTjNXSWtGT293WW5nb3JxbGRRZHVqVnZKemtCaGlvUlQwa0NG?=
 =?utf-8?B?VkNkR2xiK0xlOFFBWlFtOXFJK2JnMGJsRXBzNDVzbVdKNXZiMVdmeEE0ckE4?=
 =?utf-8?B?V29CNzVhbVoweWRNWFZSZjRCWml6Yy85S3pmK0E5YVcyajV5SnBGSUo5SlFu?=
 =?utf-8?B?UFQ2UjdOWU1EZ1lqdmNuN3BGSnIxeElOaHc0cFgzemtJVXlPMjQ3cjN4M0R2?=
 =?utf-8?B?TXJNT3JZN2lJdEM2Yk9ZaHlyUC9VenVKQ3BLL0VPc1NHOVUvTVAzU0MvY3Nn?=
 =?utf-8?B?ZlRWU2JWZWlqNkkwWU9MbEN5dGxwVGYyeUZBMGZVZXdmTktyclRjL0dGSkNn?=
 =?utf-8?B?WUtPMEpvSnB0RnZrT3Y1UnRBUEZyNlN5K00wdklDYllSb1ZMSURwR3JNVnIx?=
 =?utf-8?B?V1hKeGloY0ZXeklrWFRyc0l1TDFTNnJGaXI0eGFqN29DMmtiOHg2Q0I5L2NF?=
 =?utf-8?B?WkJTazQ2czVER2VZaFdEN1QzU0RhZldNMUdFZlBxWnlZQzdtVGkrc1cveDhu?=
 =?utf-8?B?VG5nTjc5N2pRZnVXT0hOenRBTFM5S0lGRHhnRXpkT0c4QVNpaTdxbSthSTFn?=
 =?utf-8?B?enBrRmI2L3czRWUxV2h3N3YzejFtUWxZdTlFNGpNSVhBbjFDbm0xNFc4SndU?=
 =?utf-8?B?ajEvSGhzT0c4dk1SM20xSWMwZ0JtRmFtS1BBdWNmaHdkVFlOQ3VJemY3bmhU?=
 =?utf-8?B?dEhpYi9UbWY1dGJDT2xPRlc0TGJBeC9DUGdobW1NKy9wOTR2SVhzL1M1MlRJ?=
 =?utf-8?B?dDUyQ0dCemxDSXhOZTZoSURIaWdGNGpnZzd4WVlyekQ2Y05MSDhsQ2IzSXJV?=
 =?utf-8?B?YXloVG4ya3F3bFkybHNmWXREMUNNWktzeWhNUnpQYjNvQkJWZ0JZeXY5Nkk3?=
 =?utf-8?B?Y2UzRWVLMkZ1bDUySzZ1VjVkVWhhUDQ4Q1hwM1BwNHJLbFJ3bjRBMXI5WDRB?=
 =?utf-8?B?dWd1dk5WWFF6S2RmVWo5aCtZdmJCK1l2ZnlpVU9KTFc5OTJ1Q3hsODIyRnJp?=
 =?utf-8?B?NVRDejVKQlMrUnlZTlZ6eHJkbk1uQTVSNTI5Vk1Fb1R3bDI5NnpscVVpQ01I?=
 =?utf-8?B?YWZsVmVpamJPNVVmb3FLM2FqUnVBSnllMkd1WEU3UmFGWUFLM2VwOFZZcXBG?=
 =?utf-8?B?S2JxQTlSN2xKMUhzejdYQUhVTTM5OWN5ZDRZdGtsMzBUdmg0QVlwU1RNTlhY?=
 =?utf-8?B?Vk4yd3Q2b0s5ZmcxdnU3UzhXcHhnL0FjQlFSNGN1TmNUNW8rSFpRdWd4VDh2?=
 =?utf-8?B?VmNwdERLRWpwTkRCbW5MWlBWb3g5SHorL25RZSsrUC81VFJMaU9hU2NpOVl2?=
 =?utf-8?B?MGlpY0lGQ2o0ckFtKytlL1JjV3lpMWFEamR3UWdPWFJkMG00R3B4ZlVsNGRL?=
 =?utf-8?B?dlhscjJsYWY1OTBQUm5RY0FzRW5jMGJyQ0NCN1UyQ0laMjdtTUVkNERNRkxR?=
 =?utf-8?B?aFY5TmNPaGlobXpBblRnb3RPWWg2ekxtM3BIcWJ3cWQ1SnZIQTkxbFVDdllL?=
 =?utf-8?B?Q0ZFZ2JEd0dDb3dldUR5b3J2TGdua1Rna285R3BxRENGczN6bGpWK2dZeWVp?=
 =?utf-8?B?K1FKRHppcnJSZHNBdzZZRkFNM2Y3YmVzS2RQOGRGZnpvMUNhRkI3ckNnbGp5?=
 =?utf-8?B?cFJNcysvY2tYYW9rLzBsek5YOXFRcGJzN1RFUkhsS0F6Z1djYU1nSEVZWFlQ?=
 =?utf-8?B?VlI0Wk85bUY0dVBTTzJqWk5ocWV6aUdnanAxYXllYkp5SXlna2VpeDUxQUl1?=
 =?utf-8?B?VHIwV1UzMngrNEdaNWF6Z2RLaVNvTW9hbkFvUDRIdCthQ0JVenRYeHVUNlFa?=
 =?utf-8?B?aUhSN0tSUCtHVE1oMnNjQU1SUG1rdnJ1elNNQjVnT2VVaVc1VFJ6VXhRa0M0?=
 =?utf-8?B?c1YwRG4rN2RYd3FxOG1rRS9pWitFTTJldUcxM1FyVjZYbm5JejQ5aHBwSWd6?=
 =?utf-8?B?M3NiUnJoRDl0dUZmVDhNNkgwUCtnY1Zkd3RrYTAxa0RQckhVdkJFME1KMDYz?=
 =?utf-8?B?YWYwV0tBaG1ZcEh6M3Bldll2emdUeXdhNk5OT29XUmh3VUxHSUJJa2s4VEdo?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7897c56a-3acb-41df-108c-08db42c64706
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 00:12:36.8120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k96zGqYZtkQcdAiDEmbiQhxb63gfE+QpblSJUHmhgZpoCsRMQxXOLX+Bz3SnQhiAZH+ZnrR/Ijp63EoXlU1w6fok+D5qqMgMiy2zSbkAsrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5227
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 4/18/2023 4:44 AM, Ilpo Järvinen wrote:
> fill_buf(), show_bw_info(), and resctrl_val_param.span define span as
> unsigned long.

There is no fill_buf() in the code and show_bw_info() does
not define span as unsigned long (it is even the first function
changed in this patch).

> 
> Consistently use unsigned long elsewhere too for span parameters.

Is unsigned long the right type to use? Tracing through all the
indirections I do not see how making all usages unsigned long
achieves consistency ... have you considered size_t?

Reinette
