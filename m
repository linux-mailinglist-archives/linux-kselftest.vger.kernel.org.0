Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0986D752DD6
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 01:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbjGMXOX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 19:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjGMXOW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 19:14:22 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26E8AA;
        Thu, 13 Jul 2023 16:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689290061; x=1720826061;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=0x2KsEg6ljyK9DHsvT70rgnaxdVoLMPkc2P2mbI4R08=;
  b=O3tJjUZv0C7MVT8SF3MWnCSUSejMLGtEysOi6Soxsl2HxUF8NnxMhXAo
   M86msVUYjchiG4f/EZYTswmHNpK+e8MCGHEswdYXU2FIYkP4zRj2UN6Al
   7MLhKb+quohTF9BRROb+YYlEzE4iJIaTBu+3a5MuASy7ZowvF5rmkNVKk
   MNgL9irirMRWuvv718mnLgnu/M36CWkVCgxDGhGyncczJNAOS03WIAyrp
   sJI9BqL+3j0emHi5sCM3Y0UVUGb5QaKyJsK2jGtDzYoYo82Koh4kU7V/F
   wIn8gqXZEIYc5CBnqKQ2MuwAzlGg65ENYd2zSsY8GluIsHPufkZCqAsBi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345656146"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="345656146"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 16:14:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="699440082"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="699440082"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 13 Jul 2023 16:14:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 16:14:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 16:14:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 16:14:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXsdHL5oNS2JsN/MkjNSZDVtlCqubuyp0CMVcL2guypc59jELhiEQC9vCX9tI14EMvCgEIFrhcaSvuldLhlned1GmTB2Dchxus2dlkEfG0ooZOh1dqsDuhMG9SBmlll8tqBE2XHsfdtkNBYzqiSbk3LazOCwbSy3tqI5a7pXpC9uS0hJxSueZusjfD3IO17sx/6oANTG+U0Wh0iL0P1nO+SLkBra4orqt6Gg/k2YqBajl+rN2wWS/JacTKHDxIeuiSrMD3iJw9Gx5rcTwixihhHnVnNA4pf/Pniz6G+qrVt/a3yM5rXDKZqaR74ViQ4uaOwm12kpbkXAjpXhShOkiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwEcKWnn7r57aMBH5DdKly4/iwSZapx/d1qEHlpKoM4=;
 b=Ared4fOMXCiPnT2aB9qz/Y/V9UME8ePJlhwztxVplztxlY3LjNguduQGp3Irqalz27CABV11mz7mGWE/SdzJl+gpYBSnBAlKhtWSWXV0mfPQ+DcXt0CoBnxUru1xjii7ll2GvYdzE4DEoxr/chkzoNExxQFtxZ8k3dZX6Nzw7a0L5mPOixRkWWgAevSK+l1XLMDo19LOEO0NGbMU5HV6bSxL+rNN4NBOChATL4dVLbNIGow+2w4Mb/DUUf2iWkbd0ymFFTAYh5/rAb007o9wavmJqPp8RWqIghPMZynKBQHK97R0mBoSQWUaZigpbtrLFvMVgYM6DSh43orRgBVbDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH8PR11MB6708.namprd11.prod.outlook.com (2603:10b6:510:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 23:13:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 23:13:58 +0000
Message-ID: <26bbc621-dcc5-cc5d-ef53-db9ea7598042@intel.com>
Date:   Thu, 13 Jul 2023 16:13:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 16/19] selftests/resctrl: Don't use variable argument
 list for ->setup()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-17-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230713131932.133258-17-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0273.namprd04.prod.outlook.com
 (2603:10b6:303:89::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH8PR11MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: ca4634d1-4a67-40d8-2b3b-08db83f6d5f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u1+LrEB5Lq5JmYFnWwDP3yEToYzpQd2ACVM4Jz0DwwuWIwMhQDI3H/0f4fsk0frThUXT3Kh0lNy9cPSov8WxZa34nWlwKj4ygXgX/+viVKNmzQKqevJpk6MsVC+Asbel8DP+oEsPVxqBwx9gHfHuo01ZvhRgfKLaWc2IED37Q+WImcB0rk8u6yaLJOEaXc3zeHUAA7rOwbyn3kpOzUaBy8UebVkH6B40MY844qpf8JsIybU9iSIjsimEkBfxEivjrehVtjDQHmbEXYOBVVEupCdkzmMzGQMMEQg+HKOihkv9swrjao2w7qkmXZaUjkLaAbSDi1UByPXNYx09LGE/qRaSvrcnxuCp/Yk5v5oyGSGimGEJbz5fhA3ZIJuMQx2YRrUCOzO1694LEN0X+5yFRFc76Ta5irdjjrhMzDsH2k/TpQzZXvqpeINZ+yS2V3/NjSlFRrlADi8UMM9wXPbTfRQtjsQlGY9j0g5FPHbX2gMxWdPRw7iNvwNXJe3bHaAKiZ49S/Bb36MrAOcapqy0hQEKJ0n7gDqXFkwOxAidUuNr0X1Gql8wR4qoPbTxMiOuV/9gOQbB0Kg50te6Q9n8Ei0+c4A0kzJeSdFP1zLTihRs7eMN6EwcEwbeDRqALVYzFhu2Jp/MJ/LaEn+EKPBceQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199021)(8936002)(8676002)(82960400001)(38100700002)(186003)(2616005)(4744005)(36756003)(2906002)(5660300002)(31696002)(86362001)(44832011)(26005)(6506007)(31686004)(53546011)(110136005)(66556008)(6486002)(66946007)(66476007)(6666004)(6512007)(316002)(41300700001)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjJEWitPR014eXhUdEJkbG1rek01MSs0a0puRjNXblVMU2xqRnpjWWk5MHNZ?=
 =?utf-8?B?bCs4M2x4L0RNTHcyOHRQY2t6YmVSclA0Q0Vla3gxSWw1dzJ2aW9MTUhjT1NM?=
 =?utf-8?B?eW9hbG9kTXpac2N4cHRKNDdHaHY3LzR1cTQ0UFQ2QXdMSi9POGdiK2YyL0ha?=
 =?utf-8?B?S0FRL2hiK2p3ckppVXNEVzVmM0E0S2loUXBUTlliRjRrRnZETHhlb25lWkRM?=
 =?utf-8?B?SFJoT3c5TDFaSkRNRktCT01XSjlJUjlEc0hBOENOdml3eXZSZFZZR1hOVm5C?=
 =?utf-8?B?VVVSU0ZZekRwRTM3cnJWUnNzWXFGaFBVR29FN0VLYnZJTHRlaHo3dGV2bitY?=
 =?utf-8?B?cE1pTWQ1RFM1OGVQZ1BidW1SS2I4WG1mS0xvTVltZDNyS0tpU0R1NkVGZzY1?=
 =?utf-8?B?OFp3ZUE1SlpOcm1oKy9iSE9XUk5GMHRlYXJPZ2FYOXoxYzh0eXkwa1RwOEJY?=
 =?utf-8?B?U08vdHdzL0pvTkc5VGhkUkpPOTVyVVdQMVFIVk9KVnVndVk5WVNvRlFwSURn?=
 =?utf-8?B?aThBYTRmSVp2WVNtZkxVcHo5REY5QVdMU1hTWmVTRUpzSXVLNU1GR1M1T1Vp?=
 =?utf-8?B?cjJqVU81a1dwQndpT0x3MXVjcVNDNFpqT1lrR2xlQy9nejNSdG1UN21oQlNx?=
 =?utf-8?B?Q2YxMVFZN2RDQmF6cUtjeUFYeWtkR1dwMDFiQnU5ZE40WGl0RC9RTVV4ZERx?=
 =?utf-8?B?U0svRXBtU2FOZVN2blM2WnVSRHRPRWhOWWR2MFozTGMxcERGRlBpbHZ1QnRM?=
 =?utf-8?B?akFwRE5xcXhkQ0xBa1ZaalNIMTJjbzdrYkZ0dXhjdWR1ZDYwUFpEZ3l2UXds?=
 =?utf-8?B?ZFc1N01hSWVLUnBDYTNpZ1Z0QUN3UGZqWjNCY2xwTHZ4N29XUlpUQUZoL0gx?=
 =?utf-8?B?NEhkUWtsQVp2aGZjWDBTQXlETWlMbFRjRDRwRWJCRGhDTFBUUERJMWZWTDBC?=
 =?utf-8?B?ZkNCVGNzK1dvNWJoUFdCMjZCcDNXTWp6eWxZMFY3Q2FxekxVaGxpUVNkU2JO?=
 =?utf-8?B?eHhHRFBoVnpWRTZiQ29MSDkwZm8rVGZjWXBWOHZzTkJXSmw5VG9IY2NMcmpR?=
 =?utf-8?B?MmdjYUdHTVJqZTZjVEpwSFI0aDJnMHpPSXpUZlhXQWhGTmNSTWtpOFU5WStx?=
 =?utf-8?B?bGg2eFBBd2hHeGZ2ckRLaXZ2ZjYyd2ozYWsrR2pxZm9nU1VIV05hY3U4dTlV?=
 =?utf-8?B?VTRSSE1qN25tbzVEM1JTU3c1Q0tjaGFqOTExQUc5ZWpPOE9HSTNpOGF1eUNk?=
 =?utf-8?B?aTRrR21vNEkrU1RyWnA0SVVmbG5BeXhKa2ZERVhHQmJMWHZ2L1VTNGN6YVpE?=
 =?utf-8?B?MlJIOFNsUlQrTG41MW0rMGFaOEZIeXRYeC9UOHVPdzZFTnhTQWNLVm9lVFA4?=
 =?utf-8?B?Zk1zQzRtYWx5WGVCUS9ZZlB5QkhuL0FSMkRUNnQ1NnVXdlRpMlIwdjFFNzdU?=
 =?utf-8?B?WExyd3NPZVNtUDNITWdNc1JvMWJoWjlyVTJJRng3QUlKeTBHbkYreFMrcXA3?=
 =?utf-8?B?RUVReFUxT3E4ZlpoU2JEQlRsaTNhOGZ0TFlCcEdMMkZRRUhhMWozdzlSU0x5?=
 =?utf-8?B?Njlkc1hqalJ4Y2I5WmtMdGdTNUNLTktSYVlraTNhK2x1TjNaNWs2MDJCRlBC?=
 =?utf-8?B?dGtJQzQwbldPcGVwVFZWRExINlJ0bUthZG55Q0x3a2dXYU5uMktWd3FEcHVr?=
 =?utf-8?B?SnU2dDVTelNXYnhjMjRlNFhycjQwNncwdDN4TDhrZ1ZrdzdoODc5bmJxQWhR?=
 =?utf-8?B?MEZuZ29UK3l3SE5BNVBqcnFRVkVJa1I3LzZXWmFBWldqTmxTK09qT21pV3FQ?=
 =?utf-8?B?Umk5Q2ZEcUJLZU9TV3hnbHVXK2xkdVdYL2cwaGhxUGk5MWc1WlREVjZSOFVj?=
 =?utf-8?B?RDR1TUFTMXoxYmYxVWgwdnIrQlBiQ2dRdWwxZkd4UW9WaGwxc2VsMTIzU3ZU?=
 =?utf-8?B?NXJKclY4MWhJNzN1QVdpTkJmK1laTFBiRUtobWlBTnprOGxINkV0TStZVDlP?=
 =?utf-8?B?V3BtSGFNOEYwMG5OaThUTDFhbjVIbXc2anlJdGROOHE0YzQrVEE2T2VNOElC?=
 =?utf-8?B?UmlHUTVJN2Z6eEIzdnJsYVpSUXIrbXpXZzNZalB1ZXBYenA2RjBkVDREcGo1?=
 =?utf-8?B?Ynk0SkIvSHdxM3c5c2p1ZWVYUy9wUTdXelVNT2ZpQkVVY2E0cGtSd2hTMFh0?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4634d1-4a67-40d8-2b3b-08db83f6d5f0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 23:13:57.9440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vw8FUPN6V7C3hgWQZuB6kAEGVcsbWuCmITra62uhsqEYU6IMm8BaiNCsgVSKE/umtYy9Opjep2g5XPuNTxt8sX5scMNRnQ9YXM0b5+RTs4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6708
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
> struct resctrl_val_param has ->setup() function that accepts variable
> argument list. All test cases use only 1 argument as input and it's
> the struct resctrl_val_param pointer.
> 
> Instead of variable argument list, directly pass struct
> resctrl_val_param pointer as the only parameter to ->setup().
> 
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
