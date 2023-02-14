Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965EF6955A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 01:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjBNA7T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 19:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBNA7S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 19:59:18 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32AFCA1B;
        Mon, 13 Feb 2023 16:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676336357; x=1707872357;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=7JQ28Hp0NAG2XW0Vs0Cn4V1Aw+hokuVpytwMaBraGUE=;
  b=g2CYMyRT2st+d3F2dJLqo4XStOMeFcPSJtmXIYC6Ev0aG1Tv7ny8gNTB
   tm2aMWB897cmC+mdvYt3FEuQdPQF1gtiZi46orsghdGrO3yg5EAXD5J+Z
   ODl87SwgHHcoMLxNHKkulGCdNGW+PkkCG8ndQJ3D/qNG4vUkWm4yH9FMV
   BHJuD5rHsReSM+UGF3ctV/lm6633aCQmg6dgQNLA8TV7VDm5a6I3mA6Wd
   Vk4uOcjl3upIPKQjwen3uJSf5sGkFym+agJr8aswW2ompsYTu6pGsYMbY
   XaerLsxI6psOH2B2kcJ1FYBwZZ4jtH5Wno1zw2bLezCCTpMEifIFC0Kmh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="319074251"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="319074251"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 16:59:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="662383407"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="662383407"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 13 Feb 2023 16:59:17 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 16:59:16 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 16:59:16 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 16:59:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4A3R8X80oABzBe4xS5rr6a+tSeG3suU0bPYBsX1ofrFffCpUB3IvIoyQx/9GJaW9zJyhx4kM/4SuFcaNS7UetWm8Mbajub+DgqXpjSlWdlqUM44apTLcRo/g8DfZMiFgNBzsqKdIe07QLG0fmnbly2hR4zq0VC6pcg8Gm4xoWUM/N7DoJjHPZTmFRs0lNI83w0SLlRo2q9W8nY57NKvbZk/WMwJYotWdUeRlX084zw7214la55uJro6/o7CflBxlcxDmnCaBsfOtXLsflH1/OyshH4jnlMV3vR7v3ZuzAxZKxVXLuhgdPQ7975QcCnHO9BAJ2J8Ww8HWMJLN7vqnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpXiHQj1iFh8K0e+HdyaFisE0kHx+Lzm+ujofuB/VIc=;
 b=VVZNMv6+HIUFtRDo2PyoAGvrQWLaHzQSl/rhUvnMfO0FgS1x4WPJroWZ7aglPJQS5NjjVErUe5vguOFFAZPmmjDzQRnOCZRskPBZOjydv5FiduryJnGga8eRo2DuSFnjANdppoDoQzTg8tQJt8ARBifm4Wo9fRhDvHVeOmkCU+h5JX/SIeisicJRFulJkL2AmCE012wiDLRYrwOgt4htvGGCTB0DhYDev6XALZY4an82vbvCDe/eyxzbOWdGi5D/TgEckUqRe4p29WALwX2cNPfikf9gtGFJ6o1u5mEbp2bno8Zf8dLCYvpkMV03S1zk/CRC4erpdf1TMoYeQ7nF5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MW3PR11MB4602.namprd11.prod.outlook.com (2603:10b6:303:52::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 00:59:12 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6086.024; Tue, 14 Feb
 2023 00:59:11 +0000
Message-ID: <632ec3c6-0a1a-1c65-f85a-06f594b72a9f@intel.com>
Date:   Mon, 13 Feb 2023 16:59:08 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH 1/4] selftests/resctrl: Change initialize_llc_perf()
 return type to void
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
References: <20230208094026.22529-1-ilpo.jarvinen@linux.intel.com>
 <20230208094026.22529-2-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230208094026.22529-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:40::32) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MW3PR11MB4602:EE_
X-MS-Office365-Filtering-Correlation-Id: 914e9fae-845c-4e7b-1580-08db0e26aefc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ESY6IRNEFAC6BryA0QkkdHIEYMwwy7Hf3NHpTyxvWK0CffS7WyiaN/J0WlK0T9pHFwoI5ivUGmjmaV4hkH+VUNj32BGUdHatV+8fyw/pkmC1Vqzuk21hX2xVM2QDN+OFGlWaFSWCWMV3l0PX2BwKw0bN1JIbuqFVZxG5eWk00Y05Csxc3ieSoZsFDbVvc+Cu5zIOiAwlimU7WfyhwttzbzYjFkd6nLEVQprKHmMcv/gAb92I4Jt2S7yXpEAuwN9Q2fE5rX0qFg38cQntcOwhrAeGlHAIiIWmpG1zeBZjfB4IIfHHy9VG7+4XFyoiFb69AdDqbJeZoid4VlGiQg5DY9XOMcdlKsCiMguZ6HmFQy5vG4zY0AW4aJyIcFuZtJ3ynqzUIJf8FXO2DfGibBK9lqUbTB742b28f9yLABqIBJ9gtdax6n0IjyvU2lPWPPPrNmYLknPm805SHfYvtIfSiYB9AccnyVN+0Dokypmwizl/qfaQrK+ep2/yDlXTf/QHuRj6yZYqHTdFfoN3OW4TY79db7TThqWFnw0VQKPHu6jhjBo04Fqur3W+Q9OiGEFi1FvROct+1zGtR6s327cI2eXZEQ/+ukC6hijm3nI2/boi0c4rSMhi0qTTyyagQXSbD2YsBhf3KmxdiOsH5Ow6tM+y/zxg3Gyw5EYndF6uV8YaV3fEThsFah4EDrLIs1wGxnX8XE1cuE8jsG6fH26uYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199018)(2906002)(31686004)(5660300002)(8936002)(6506007)(41300700001)(66946007)(66476007)(66556008)(44832011)(8676002)(316002)(110136005)(53546011)(6666004)(38100700002)(478600001)(966005)(6486002)(186003)(36756003)(6512007)(26005)(86362001)(2616005)(66574015)(82960400001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVE5SFA0WExDRkRXNlNhVDVCMGlFd05aTWlSUzlNSldXZncvaVFKV0VlcjRM?=
 =?utf-8?B?Z1d0ZDYzOXlTY1NPY0lZNEFBOGtTOFhUdURuNVBWTExiRCtNdjlpTU1yWURo?=
 =?utf-8?B?YzR1NExPZ1lpeGhnWFZmRm1Md1ErMzNoNmxHVG81eWZyUlZ4NFNMN2R0YzEx?=
 =?utf-8?B?V2M4SjhoSGh6Uzc2ZVlXQVVUUi9YeUVoUm5hMXdUV3g5c1JGcW15YUNpWWJF?=
 =?utf-8?B?SDRiZ2VmaFJ2d1JjRHRRNlp2TEJ1WUZRbkZqU2tqUG40a08xazhvQWgwVGRZ?=
 =?utf-8?B?V0ZrYSt1OG11Y3pnUWpiZ3YrQ05wRHRrM0h2azBOWGdZdnRzZVdCQmdoNTNt?=
 =?utf-8?B?SzZ6VmRGczhVR3prcElQVS8vajkzUHJEZGJmY1F4djVDVDJ5WTJFbURXeUVR?=
 =?utf-8?B?bnQwMjV0elZLcGdkNXZaNmR5UkRxSlJvUkdRRWVNYTVuOGhBVE9yZ0hES1JJ?=
 =?utf-8?B?NCtyWVJMT1d6L2NydXNyUk1RVUlZOU15UmxCcmg0YlJ5VGNRdnRSeno5QXB6?=
 =?utf-8?B?VTArd0Q2eTEweFRZOGdXMkhYcnZsY3R5RXpYUTI1U0hMVThMUzF5a3l2N3Rt?=
 =?utf-8?B?VFFyQjF5ak90cU9iakErbVN2WGZHcGZIZk9SdDVMeWNCdHlmTUIxRkVEQkNk?=
 =?utf-8?B?NzRjOXQvR0xDUEhUSUN4TGwxWVRUdmJjY2FERlB5NlN0Yk93R1BHZXVBNXZD?=
 =?utf-8?B?bVlENFh4cHMrUG1mSlZZS3dwSFpJaHRhTVBqczBRRG1QK0RLN3o5VXBQOUVR?=
 =?utf-8?B?K2htUVJuaytuWlVKUUdUazZWUE5HRXl3bFMrRG9ybzJib09WTlZtdXJmRzFr?=
 =?utf-8?B?R0xmeGduZ0hCOVMzR0JnK1QwRWQyeGpVcnI2V0diNmFjdzZyRi92TklWQ0ow?=
 =?utf-8?B?VVFrM0h2d2VzSytaNmVxRnRjMExRTm10SnJoZko2R3pkY0RwUUh2UU9ZZmlP?=
 =?utf-8?B?RWpGMzhNQ1pJTEVEdzRRaHZuMWs1WWdMcForbmY2ZjFCVTk0RHM1NEJZak1S?=
 =?utf-8?B?eDl5TmtOZDIvY2FJajZkNEpWZWRoTzZjWW43YXh6Rk5kVGZSeVk5VEV2OXUy?=
 =?utf-8?B?NVBnSWFaRWZ3VTd2bENTM1pUNisyV2pLd1RUdlJIc3JkNk0wVjdkdEM3TGFE?=
 =?utf-8?B?dTdqTWsyOUg3aTh5U1h3eDA1UG9JelF1a3F4Y0p2N1pqeUpHZ2FhTWhLN0pp?=
 =?utf-8?B?TlJ3QnJ6WXNUckJHV29LZnlTdzJPWHg4MVdYQ3gzR3lkT0I2SWdVVldjWEFV?=
 =?utf-8?B?bmRLcHJid2k1VUY4M2ZrOXVZMXREajRJS0o1OHdreFB4aldsYUZMRURJTmVT?=
 =?utf-8?B?ck5oMi9sazZRWmw5Slk5M3FHd3BMamltZGtnRG1sMnpGdGJtSUlSalZ0Umw5?=
 =?utf-8?B?MFJjUDBxTDNyL1ZQcEk2NlhzUHlsSk1XQTNpbFhNbTdIRjF2Y0hRMkl0bW1J?=
 =?utf-8?B?VStwa0o1b2NmdUxRQkhGNDZpK0FxQlBmR0xpWWZqMWxjTUcxdjN1c0pRbVlS?=
 =?utf-8?B?d1JPYmNpYmU0SUdtcGxFWWdkR0NhTTdpS3QwWkVKU0Rod21WbWhVVEFQQVJD?=
 =?utf-8?B?UThSak4xWTd1di9zUml2NmFZcnhVckxMckFIWmhKSVdNaU9QdmRTQkVRUjlj?=
 =?utf-8?B?TVk0NlB1WjgvY09JdGVUUUlmeEoxaEMyUVFwanI5bFh4U3p1a1pHb1FUUEx4?=
 =?utf-8?B?YmtNMUJjeEhaSE1HZVNycjExbGVWSWFxMnVIYTEzWUNVMXJXc1BFU2lxRWxi?=
 =?utf-8?B?WHJYS2syZjMzby9CaUdqWld2SnRkUGQwamF1dkVqSTQ1RG1NbVZxTUh6TEN3?=
 =?utf-8?B?QzAwVzgrYzMxUDROS3lhZnFrVmJIOS8rUU8xbWhDbVRLMW1GSVFHTmFsN2lR?=
 =?utf-8?B?aXlWZm9NODRlUlhKcGpiU0hBcEJiQVZPeVFPcVpGdlh1aFdUWDhOTlZpM1Zr?=
 =?utf-8?B?emE3NUQrZU56MkdRM1JZQlJvVnF2enU4Q3NqYVRqMEtmZWlHWG1iSkVVN1dM?=
 =?utf-8?B?bzBtWm5tVXd1TVVVUi9RYS8xL014U3BYSHQzL2ZPZXhJMENlNUxzQlc1TDZF?=
 =?utf-8?B?SVZtSHdSaUo2dXRVbDFMMktZcUd4SFpXUDNWSWhveVJCNGxkVmo5MTI5Wm42?=
 =?utf-8?B?YnJ1ZW1NQkhLQ3ZyWjNCdzMvWlVoN1Q5WFV2YjllNHduTzU2Um9FL3dvWXVy?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 914e9fae-845c-4e7b-1580-08db0e26aefc
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 00:59:11.4421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbMBmaAFhI7koySWiDofdz7kDMJTxMTBe778BCAcTBtuvC3cXeAwYG09pqPbRm8JU/+stkzojWoohHPCU2k4Z9dUkS59RnRe2nf/Kgp4IZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4602
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

Hi Ilpo,

On 2/8/2023 1:40 AM, Ilpo Järvinen wrote:
> initialize_llc_perf() unconditionally does return 0 so no point in
> having it's return type as int. Hence, change it's return type from int
> to void.
> 

Thank you very much for contributing to resctrl. As a new resctrl
contributor I would like to share that resctrl follows the x86
style guidance and to be consistent this is for the most part
true for the resctrl selftest area.

To that point, changelogs are easier to read if the context, problem,
and solution are clearly separated by placing them in separate
paragraphs. See "Changelog" in
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-tip.rst

Please compare to a changelog as follows:

"
initialize_llc_perf() unconditionally returns 0.

initialize_llc_perf() performs memory initialization, none of
which can fail.

Change the return type from int to void to accurately
reflect that there is no checking of return value needed.
"

For such a small change as this, the changelog could possibly be
simplified but the context, problem, and solution should always
be clear to the reader. This may be significant changelog feedback
for such a small change. This is because it is your first patch to
this area and my goal is to point out the style that will help
your future resctrl contributions to have the pattern that
x86 maintainers expect.

Reinette
