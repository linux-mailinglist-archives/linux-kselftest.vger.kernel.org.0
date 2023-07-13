Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953C1752D2B
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 00:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjGMWoy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 18:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjGMWoy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 18:44:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1979E270B;
        Thu, 13 Jul 2023 15:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689288292; x=1720824292;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=tIHXQWWcf5sodIcjbkEr4g5dXXSvsG+6fvdJSYKzqU8=;
  b=mqgRyXcg+aAlTUENUKKe+Rbliy/+vYLuCBI5W/miKIjwPCRJJ5/m/JNt
   37EJimerMCoo1e2DoBZIASY337b3wpUSogXvbE9pIGNjVXwakuGQaKntT
   C13w9YeIeX9QS4/hZt+NHelcHK4xJq+sny9XHNLRiMC/AM4YlJ7YrkiwF
   U/X4kroWnw9nnzFTnUgA+aCA29MGdp3WRS1e1I60CbfIV9JP94w5rqVCN
   Sw8cTZjktwTeWyWCiufy+N3zx/43BdEwraZRFIGEj6qje2UCzCb0ao+Ng
   87+/Pzdr/1IQaEDavakf9Q6YxqFd05a8taQf+mMUw17N1/F6g0zHah78b
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="367975626"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="367975626"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 15:44:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="757345807"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="757345807"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 13 Jul 2023 15:44:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 15:44:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 15:44:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 15:44:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 15:44:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IK8nB6aa+UbUZn/8xv82z8HAcZPgnBVkL/HO5xseFR2Ojb+F6Ux8NI51ETybmKrFkzCUS48kmNBBw9Y4dFUYPrnCPsxINe46Z9wGfXAxOMHCSdPoDLsHYzwz0aEGFfg23YJairtGBB0OEsDQu/XQYO/7rKXJOVUEoUa26dckT7NClAP70FHoy2hAaffJTSvRa047kvp+2fSOH4Sj4MyFJYsVnrbjswO/HIRFnK7OH6Vc0nTYEm7t1imnPWY2AkcOhd3msVqT/DMDLZdsd/5wriqLFOvdlyWwkSRlKUfQZbuzJEu4JqUYWEe7iSGja5hI6crl7dZViuFHnkUsLBN96A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TcPZGGU0QJlD4Cy/szr4hRYM7vqaavaNnLp38omotg=;
 b=Ssuvm+5wUNVTQc6vcs85q0Fv2umFf2HUsCTefUHtWGj3+d7eIvjSgUeRcW9c2/s2S/AwO+VZGRtJP3C5FgcGihfmM3OchLa2FI8SB5nQQDJAKKjaoj/pUAvtxS2Hv+aMi53AKTdfXnqqJV3jFcaKxunzMx//G9bjG/ZRHH9ZEruUPf/Df21DKrShZSHIbI+lu3zTFeFIUyb8DfveAYtzVhSvXB4pikUhoygcpnpOBGWQ4OAyfCnkN1QRWZLZP4DrsSq8haI+SzC/V+DETsbYCXJFClhSlO/xcQhaf0N2cy+uYmOpzTLnJZ1jbphy71FwO2k0vi/lQFWMt/MWP6Cp9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB7370.namprd11.prod.outlook.com (2603:10b6:610:14e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 22:44:43 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 22:44:43 +0000
Message-ID: <69a1669a-25c5-3bb1-4d73-00079ef9d2ee@intel.com>
Date:   Thu, 13 Jul 2023 15:44:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 02/19] selftests/resctrl: Don't leak buffer in
 fill_cache()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Colin Ian King" <colin.i.king@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-3-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230713131932.133258-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0304.namprd04.prod.outlook.com
 (2603:10b6:303:82::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 841738b9-85ad-4854-3c43-08db83f2c053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S/4kCxsZBRvRsjCqKj/0BdH4bpriQACAumuicR8w5hHKPubFriVldi3vZ0Aayt1YZ1Zim00xlVrGgceeHyc+rUBlIRMPb3Als4w7ZyPmrVQpRrpuHdgZQBCWUF0Z9icnQUozNFyqfnRdJXQ1iImGCLwACkaFznaFB+PZ1Ee5E7PbA/hMH8XN1+r/Mpn+i94nPgXqHo8TZnfBBXb1j/5UY1oUhKKyB7hGukN5bYhHFIBMk0tzCiRkgy66bRHvWuZW8JMw4yEMObPtphaw3Hsi/Ld2ihGyWYe2kHAckCcDCh9soRXjlftL7VNe+CYkXbXN4uythIG6Dq7cfdBWliSPBmuarHG/F/UKYMKHapUrG0o7+IYV/kc8Dg2icYDFrFtvzdIblA2QovqpYT1IuKWn5EnTCSH0QRm3Ar5J6BTRAU1vMCJUpoyhujvkjJvn3Pi4MZxQt4zBQ9oyZdE2+7Qfdb9lT6sD2h0YO+Rze/7yJAkbS9p2/eMLwlU8CA1nXJttSeqxfM2tfvPOAeWEaMBDc/Bc5R3oKOlxNRrls8UC+yRk8IGN6fFSasdpOM6FeO6LhisZCpzRtEh2054bzSFUdU+J726yCrxQfYKYyq35PrRVPZ+K2uFG8WAAcKtM4QoBuHQ0VXGNBxTaVHhINZDZ3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199021)(6512007)(6486002)(83380400001)(186003)(66574015)(36756003)(2616005)(38100700002)(31696002)(86362001)(82960400001)(6506007)(26005)(53546011)(66476007)(66946007)(44832011)(110136005)(66556008)(41300700001)(316002)(5660300002)(31686004)(8936002)(8676002)(2906002)(478600001)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWVFM0lVQmR4bk4wdHNjdHpFS0REMGRFNk9tck5WbUVwSWdlZG5zT0VmSDZu?=
 =?utf-8?B?NjBqVDVObVZNOEJjeFZKVnNGa3BjM0Rud3BYY1VKU0hlcStzcVNVVVJPQTMr?=
 =?utf-8?B?RUY0N2tXNnFodVV1ekp2THIvQnJCSHoxSkpmS2gwaUlEMUZPc2U0NDllUHlJ?=
 =?utf-8?B?Wk9VZk9IRldDZVkrN3RWN3ZrSUJJNzJYRkpjMmF5eG1sMC8raU8zRVE4TCtt?=
 =?utf-8?B?RFViSEhiZlJrQk1zSXJ5OWJhd1dDZGc5bE5EcDNyT29oLzg2Yno3Zk5JdVBD?=
 =?utf-8?B?b3MxUzVJYzNZZkpFWUVCUy9sdUpzSnVLNk5HK1pxK1BGdll3ank1ZFdoVm1m?=
 =?utf-8?B?MUVwVUdRdm5jdUN0R1BaN3NWVXFhMld0Q01Wc2dwdTh5U3FEM0NkbmRLQWxp?=
 =?utf-8?B?MDh6UUdaQ3BCRlpMb0lIbUl6T1hreGRQVHZ4Y1JRVk03UFVtSHpHWFJHblpR?=
 =?utf-8?B?WWhYamlpOXhvSVBCREltYkFXcXYzZmgzSUJKdzRUdFNYcUN4dmcvcHkxZHVC?=
 =?utf-8?B?Y0oyVEpQaXA1NGlmV2tDOStFR1ZxVW83UmdMVUFjMzVla3FUbDdmQ1NBMjBu?=
 =?utf-8?B?YTVoM3FhRld2QXEvNER3TmZDcEpFM2drS0VsK0EwTTZXNGYxVVBIdkVwSW5h?=
 =?utf-8?B?ajI5UEVzTXNFUDlhZlU1ZytDb1hGQW9qWk1pT3Qrb25QZmJVdWE1V1RMNm1B?=
 =?utf-8?B?MFNQTlNzajFtVEQ4Z1VrOTRmMDRhL2UzYjNOVmhVK2N0Mnd2NUx5VWpGZXg4?=
 =?utf-8?B?MkU0MGorRnc0QTFlY01JSVQ2VVdyN0dybnNYS2xWenQvQ0FSMnkwd0thZjA4?=
 =?utf-8?B?K0ZlQ1p4bzZlaXo4dHNYTk1rTW9pOEdtdFcwMEF3VmRHZEcwT0wzOXBiMlZR?=
 =?utf-8?B?WFRKbE1RODFrWVpiMDJDQUJrbGhQam00bnNmeVRjaStzaGduNDdIVDIzWkIy?=
 =?utf-8?B?cEI5MXJ6VDdwQVIvTDkxYnZsTDFlN0J3ZVdNVy96Rml6cE8yNUZqd3hHZXZV?=
 =?utf-8?B?NGNyeC9KN3FZd0pvcEVaZzc2S2hlYmtoeE0xbkx6MS9vZ25qanJuSmQ1LzJW?=
 =?utf-8?B?R2tiT1ZOS1NTY0pVMTZrT2FmMUlsSjhZRkVoRHZOb2lrcWxza1o4L2Z2U2Fw?=
 =?utf-8?B?Y2FUc0gySDZPUEhScGZXQ1Vmb2EwbjVJNHhCazFKdE1jaU1zUzQxUHZtamxE?=
 =?utf-8?B?bllzeUM3OGJmNHRnM0grdWpua0pqUnJwQi9rcFd0V2xVbitxbUlEdzlLUTBX?=
 =?utf-8?B?bGxiZzE2bVV4UVRqQ3YrSkU1MjIzSHhGOGg2NTFrWnhIMVZtTlJBdzJzdW5w?=
 =?utf-8?B?WkRlbjUyeE5sZzRTMzBBaGlwZWxNQ1dyRXJaVlU5dnhMNU9xYnVvT1RKYUpK?=
 =?utf-8?B?akswRXRaREZxVWNXOUIvaTdRNkZtSm9vNHJKbU9nQlcvanRmT2x0cEN0NVg5?=
 =?utf-8?B?VU9ySDRKSXRhaThiblJpQWZKQ01IUE9mVExxMGJ3TzExdnd2NUIvMnRHSUo4?=
 =?utf-8?B?M0FpdDU2UUt1N3ZUU1hYamRxWEMwTkZzL0x3YTZLbkg3SW5lQUJhNk01YXF6?=
 =?utf-8?B?bm1FZ282UnVrZjMwVStBcWxlMGdKaS9jam80dUg3alBibld1UlUvY3hoc3A3?=
 =?utf-8?B?Si91cU5MRFdnYXQ5WHNVSkZ2d2JFMGdBSXJyY0R0MzdWSWM4aGQ4ajQ4eU5G?=
 =?utf-8?B?T0RCRUd0MHAxdEt4bExvaG1tUGU1YmwyclBHMWZmNUpGZnlCTzkxSjk0S25L?=
 =?utf-8?B?WTJxRUhSaXU4eHZVaVYwc0NvdWQ2UnBhNm80N1R6eTN0OWRPSTRIM3RORHJB?=
 =?utf-8?B?dWhoY1RMcFdxemhmRTR6WW1CeUkzaldQd04zOVFJT2pqZjBHY21pRy9ZVkVm?=
 =?utf-8?B?RmhTRFFPNkhVOUlDME9RVjlPZ1dsWmY2amZGdzJubWRnckNtcWNYZnUzYnZj?=
 =?utf-8?B?S1VCVVhJa3gvWWJieGhhUG80WlZDQkh1ZTdlbFk1bnlyOFg5SEtiK3ZuVUYw?=
 =?utf-8?B?NjFrN3krRm0yRjk5OFZPekRueVFwbTIwMEl5RzFvdVVMa3V0U05MZjRNYmlP?=
 =?utf-8?B?ZkZhK3Jsc0JWMSthd3VuNE9tSkoxS0RNZS93UTlYRnBjc29WWUU3MG5xcHNj?=
 =?utf-8?B?ejA0SjZzd2VJRlkwSExPRk1oQUs4MnA3Q2VKRDBJckFGaFkxL2hFNFhOSUNp?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 841738b9-85ad-4854-3c43-08db83f2c053
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 22:44:43.6212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwyVtZYy8TFLn1zhM2EPyQMNRMtX699ZNw9jlzPUWC4QYXhI3UkPSJJDJT71z1LjCQCO4aQggdoIL8UxfSHIsrSpoamdOfPUx+qOV1+gRfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7370
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
> The error path in fill_cache() does return before the allocated buffer
> is freed leaking the buffer.
> 
> The leak was introduced when fill_cache_read() started to return errors
> in c7b607fa9325 ("selftests/resctrl: Fix null pointer dereference on

Could you please prefix the sha with "commit" to get a clean
checkpatch.pl check?

> open failed"), before that both fill functions always returned 0.
> 
> Move free() earlier to prevent the mem leak.
> 
> Fixes: c7b607fa9325 ("selftests/resctrl: Fix null pointer dereference on open failed")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thank you for catching this.

With the changelog update:

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
