Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212E7752D4E
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 01:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjGMXBD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 19:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbjGMXAz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 19:00:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FA7273B;
        Thu, 13 Jul 2023 16:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689289253; x=1720825253;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=y7IgqqHQM1enRmr6yW6U+rHCX+nj57a5KP0KiGWD2dM=;
  b=buD4mFIhvZ6+Rn8pNvEsZQaZuqjIL+p3oaSlAsVYOaLMLnz8/0ul5CW6
   OHFg54pRL63Fegq25U8hmwatr6+1RNWOopFBzpyeFvruZigygHeX0WAXO
   Iw9VHlzLc9A6AFjcM9fv2XDaJEpa744aW+K6L8x/aHNJLWBWrJeKqWPn5
   db89OOQEanKX68Mz7ZHqRSsgTcfqbduiRwrM6AslkYv43z5yzKWIpagNV
   fTDYK4qKsHkE3MClixtjLbxgUY/X8b4r5tD6yy4V4HtQNlvWQakuY43j3
   t9HN1HE5Fsz3gRqycafyLB2ijCW38Bd3zyilHTETWyzkGbT1cSYkcfKd7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="344931392"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="344931392"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 16:00:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="1052816265"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="1052816265"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jul 2023 16:00:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 16:00:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 16:00:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 16:00:42 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 16:00:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWJy19/jRpoHkRXZJuEKJDIdYcaMBFQnza4EfcAkpdfD+dzUfAFH/5QZxO9KWFsuMW5XIWNFC79D62hLrWHQeV++ArR5bXPs5Ct5y6w1P4xJp9ElpvRJoVrixZV9LN1aS9/mowlkmE7U4P0MucDGhTkIdPRLJB4KbNstfoChsiNap4bE+qGa1PVmbDtNI/UCpnOiua8AEIAEBPwUsfeZsj8WpFAdqtRsx/lWhBWWj/ZcEcsIOOv9uNv61hckud+hMgJr/kQp33FjzD1SWaWjre7JLMRi2/E0WPvacVco3YSCSOAH5OPPYn05Zkgi8zy2Xxd5GmoMSrX8UdhQcenDxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hm3jcx3BY9Za1UEasINCgmbPkCTIb0JwTaPeJCxyneI=;
 b=jzdToJpLSuWj18y2E9+op+dzaFFjW0IvIXWJClqwFsrVpnH7be23w867Ig5LBNByL3NzllFnHi1+bkh/Fx6SOoqi2lZ8w6Th375LHp2Wde3XMO0uewPhjGEKzcuQmKITqDgt5oJ0ejBxbE09xmgI+FvylBXyFucTketRpCOZa023TM3BmoFwHSkO34BR1/vJmoLBc7j1Q+Ov187tX+hPfqXNbLJhbJl9M/fbibNbwaDmZL/Nzv8ZGe0oHFRtCcJPVcQ9xfayPGhweFexzXIdReF4e5zdyp6E+uVHP9p8fTQ0Az7nisFt7CNExUumyVfsMLxY5hwu72UoJdPWHOFq1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO6PR11MB5586.namprd11.prod.outlook.com (2603:10b6:5:35d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Thu, 13 Jul
 2023 23:00:40 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 23:00:40 +0000
Message-ID: <1dd10447-b03d-937a-fe55-ff324864c358@intel.com>
Date:   Thu, 13 Jul 2023 16:00:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 10/19] selftests/resctrl: Express span internally in
 bytes
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-11-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230713131932.133258-11-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0261.namprd03.prod.outlook.com
 (2603:10b6:303:b4::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO6PR11MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: a28a2cff-bd28-45c6-ab40-08db83f4facf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r/1ItLdeIeis0eRAwu08L7MRIJQbrOh6BHjGYcJ9cxFXmdKr01+pMSVAGWAp9+0FK6RDkpEeanFHuPtYhsOnWA+qbWwE1/gErCSlqN/GhYcHBNLdEkeDWheuYiFTok5/92DaaMLBZad2+/pyxldrHdsNn0JasQX7xBKS+t2c2koCiwWD6b0IDVZIZDV0FXW+GYRgEo1VoBVk7Jdbw1rIdsCzfxXnZq/OPNdS0/Xuzo8UBUNCKO8K/ieTUM/aljFp5ym9/CDZDS3xHVxHpJezEGX4JC9dT6nOsb9/drM5cOHwVJNozmpDVhE+kanFIVB72M8LQVIvjUiBx9AuvrMMFgTMNjgBjqOTD9P8LhZdanXy22s1G2sc0fGW0mWz4edZ+GmBzFV8HNGiZzft+uJURfJZ646M6ZhYvundD7b3RXc38putqfFWDHywq/vNZoDLyavCCeJJzdEZYjGKH330O6GnV/2oTZkRRIgnGbh4xI0kMOJNeRDJjbUZsEEQzNhcplKwZbaTlGS8nrFARaxt/S5gdHphTEfPemR7z8G5IJ5K2zZ39gSFe47Xfho5edD51meHr8MQ6ZBSgrx3kdn620LweWRk0c/KRTTvX9jjYPE9icVx01I8XOlfmMaZvlNeOi9hyx5KmkP9wKnICHEsow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(110136005)(41300700001)(44832011)(66476007)(66946007)(66556008)(478600001)(31686004)(5660300002)(2906002)(8676002)(8936002)(316002)(6486002)(6512007)(82960400001)(31696002)(86362001)(26005)(6506007)(53546011)(186003)(2616005)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXFYRmV1MVlza1Eza08zUjNqd1VJMFRZeWdQNkVmMWFlMjZBdklyWWl3MFdh?=
 =?utf-8?B?TFRMaXFiUi9RSkJNMHNZdFU2WEF3SFVuY2M2WklyWTg3Z1VzMVMwdnlDcTM0?=
 =?utf-8?B?TWRQV2prQ1Eyd1BOZHNaMytUanlTUXE0aURlOFcwN1VINjU0RENjaGNDcDJN?=
 =?utf-8?B?UTJlOWtuNGN4bi9jUmN0alRWQVBPRlp1Kzk2WlpaYzRNREcweFdQLzNiS01B?=
 =?utf-8?B?anZhZExHZ2tmaU9wRllUenpkOHcycnh0OHp4VVZNZUhaQnAvY0IxSFYrejFx?=
 =?utf-8?B?RU1za2p3eEF1Rndnb3ZKaTkycjBqREdSaSsveTBrdUVwL1hWV2czZzRWMGsx?=
 =?utf-8?B?bU1saDJCYThJTzhwUGphTG5EV1RvemJ4WUYvRlhSNk5qY1E3TytvTkhEU2ZE?=
 =?utf-8?B?bSt4TzNjZW1ZaVFoeGVaRHdQLzdqRENvbzFKYVpPdm5la1Y0YWZGTitYRys5?=
 =?utf-8?B?czI3RGw2ekE5NlhmN0NIK3NkaTdIQWd3ZFBaYnJtNWNIMW5yaFNqNlZ1Szd4?=
 =?utf-8?B?dndvVGZLTDlaTlpSM3dpbmZ5SldoVnh1SkpXYmxtYldxUFJEUEdmUVp2aDRY?=
 =?utf-8?B?cVhzekJHWi9EcEZlcUl3bGE2T1lJbTNYaGxjbC9LVVlyZ2N1ZXVsU2VLeFZP?=
 =?utf-8?B?eW44SC8vWG1zTmt4VXljcUpVT0JpK0N3ck15TXRzVk9Zclh4S2hUUm1hTXdy?=
 =?utf-8?B?MEVhVU5QeW5SVVZOUFdKdTVYTXJqVlk2YlZmOWRCVWZDWm9ueWthZWxmbkxI?=
 =?utf-8?B?aDRFZSt3K21KNm5tOWpiZU9TTHpCb0FnNjVLcm0yS0VFTDBnaHkrRE0vSDlM?=
 =?utf-8?B?V1BUdUVib09zN3ZFRkVEZVJicXJtWG5YY0pQMlQyVFQybEdiamd5WEVYczZX?=
 =?utf-8?B?RngwL3lONmhocm1TMXkxSk5nbWpHcGlFNXI4N2R0N1M2T05YOWZRQjQ4Y00x?=
 =?utf-8?B?T284cjJlSGxQTXI4aEVuaXVOM2h3ckhZL1JKb2VWZ0YwbThRYXY0cXh2dkMz?=
 =?utf-8?B?THZ2dmdVMDZCRC9QbjFPUEJNNlVOTXpoaXIzNVhsNEEvUWdTTS9kdENmWi9E?=
 =?utf-8?B?ejZuSHZRalhiQzExMzEyK2pFQWJxVmdTVVV0dVMwcURMS1lTMGRwalVEK0Rk?=
 =?utf-8?B?RHdtakZPWnFXN0FKSlJjdVpkaFZTekxhUzJPMDZhd0hwbW9SMlB5SEdCSUNq?=
 =?utf-8?B?bjg3SW8vS2x6Q0FYTFhET1VpOEljaXdKRFJSaWJZS3VtdFlVUFFWQ0JiQzcr?=
 =?utf-8?B?ODVKZnRPTkdEUmE3UTdWSmRrT1NSeWdzUkRSSSs2UDAxZFBWSG5kVXc2V25R?=
 =?utf-8?B?aVMwZkRqTWVVRFN5cjRsdGpDWWoyWmF1UTFOcVgvM253d2RsTTZxSnFSNEVJ?=
 =?utf-8?B?dUJhYWcyUUcxd1hqaWVxZ3FUNGNPOTg1czViaTd6anppVTljOWJYWGZtVHNi?=
 =?utf-8?B?RDhsSzNESXJtdEN0WGtoWHgzSXhCZjBlNmVJcDlTYkhCa1gzTWovM1VhRWNu?=
 =?utf-8?B?eGdDQzRlbHJsUDR2aWhjdlpnZm0xcDNoRzl4dDZuUVROWUY3MkNyYTVsblR5?=
 =?utf-8?B?SEg3bGhhOHA0a1pLRURzNUJGZ3FURmozVExuVStsTTVoVzJCM0pEcWwwOFVX?=
 =?utf-8?B?RFh0eWhQeU5VdmJRYmhVL1JORVEwejQxdCtoMmg5WHhRc1lQMlpVcktiTWlu?=
 =?utf-8?B?RUordWlJRmF4RFR3M0NTUXdxN1FVd2p2ZDdwNUh5Y0xFK3loYkFHVHYxSTZO?=
 =?utf-8?B?WFpENlVEVHUwTFRYdkRCQXFXWjJXWTYra0R5NjUvbVVaSm9qN3V0Y0lyWWpi?=
 =?utf-8?B?NTlZWFEwMnZlQXUvTzdXOWJmTU5zNjdxQndOaG1zTTgzR3RhdnN1c3BZOHRx?=
 =?utf-8?B?eHIrcjFwTFBMaEFLNkVmWnJObXdUeEgwVzFSUGdqQ0tsbG0rOW5iSjRKb29C?=
 =?utf-8?B?ZStOK3VXN0ZTSjFSam1OVTlxdHFIOGZ6TThkRjBnQ1d4Y1lGOTJLbzZHbXBI?=
 =?utf-8?B?MFVlRU5KVFY5Yk1yTnRVa0VhUVVVZjFnV084UVVtd1luSDFaSW1OTkk5RzNP?=
 =?utf-8?B?T1hGTXE2cWxJMWRlaE1iNG1lSXd6c0J2S2N5ZU1oRWYybVNmM3BwQTY5ZE40?=
 =?utf-8?B?aGZGWFNzNFcyNHpjeHdTNy91dEVsVTRVOGJZMXN2SXZ5djN2T2dmN0xwbXpn?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a28a2cff-bd28-45c6-ab40-08db83f4facf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 23:00:40.7429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIrEuJsvPF2Mt9oWLnX/vNFXU+8uJCXP0r/4JOtQDBdvOkQJTRq62ym2GgAH61VKhXyoRS458811Di29ShamxPuCo2UfZmM8l6ksi7MG+T8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5586
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
> MBA and MBM tests to use megabytes to represent span. CMT test uses
> bytes. The difference requires run_benchmark() to size the buffer
> differently based on the test name, which in turn requires passing the
> test name into run_benchmark().
> 
> Convert MBA and MBM tests to use internally bytes like CMT test to
> remove the internal inconsistency between the tests. Remove the test
> dependent buffer sizing from run_benchmark().

If I understand correctly the intention is to always use bytes internally
and only convert to megabytes when displayed to user space. The above
implies that this takes care of the conversion but there still seems
to be places that that do not follow my understanding. For example,
resctrl_val.c:measure_vals() converts to megabytes before proceeding.

While MBA, MBM, and CMT tests use resctrl_val() for testing it seems
as though the function still exits with the MBA/MBM data recorded in
megabytes with the CMT data recorded in bytes. That seems to be why
show_mba_info() needs no conversion when displaying the data.

Reinette
