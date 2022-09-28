Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2289A5EE0D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Sep 2022 17:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbiI1Psi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Sep 2022 11:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbiI1Psb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Sep 2022 11:48:31 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFACD8251;
        Wed, 28 Sep 2022 08:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664380110; x=1695916110;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MPPzl7mZOc6pNjo2ExiuqC/dHLw3zcHO9HV5rKf0AGs=;
  b=nKX9Cdwq06BWJqjVPYuRHBHvNrURTQCdhYwxAhzN69OpOjmyCWuh2d/Y
   MfnWHojPC7qJW165dLodIyUe4gv9mmyILqJWt+C1p8chKlx+R1I+3bqny
   LhL6nYDPcDU54drE52Cklc8eTXbiAf9VwCFFm29OL9xMwAL+vU8GqOUEY
   7hOgnSyLU49/K6CRUWQDkItZ3gFSFpn8OX/IXitJyYKBRHAjWXV79RGim
   vXlukrD1P3/nR/U+WMtVKTOryK6Exskz21+Oi0VCiqwOCQ32GrWcM8F+N
   ZryeOKMT+j8xcEoCFjDZqsmu1dxQbji44Bq+QaE+CZET1/npEuHJdJy1e
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="300354977"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="300354977"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 08:48:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="867017761"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="867017761"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 28 Sep 2022 08:48:30 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 08:48:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 08:48:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 28 Sep 2022 08:48:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 28 Sep 2022 08:48:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYuBRvtcQ1cjSMFCXa5mLyMjIlMn3F007/+TrGf9PVORSNKqRaQUv0BXAYb4930k3RZ26msez2LP5tKq7I1VJiyGNgOkqs+CllAuMAEkwdSw7JWIAysW0zTreJ2loqj8qxrWEli0u0UGmjqELeMeUtv1PGx15upvCqD9wBFbPNyB25raRDemeTgp7gC+Ai/WAgNkY3Q20pxrg/yDxdgMU9u6UBpSt202BKPZMGD+lsRSXr35Zc+EKhNZX+56ESChACpa5LUmoFOWnMZCLkdR4a8kr4o7xmtmltQgHeaAuj4tM0m6xmGpDVaw0SDLX2jEzC6xcR8O3BzaCltEJDtdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pu21bJev3m3FC8t7qHrJBPGKH4BR6c4ijYZIerpDwiw=;
 b=Y4dsAqr4pd3BEROzmw6gElS9HSayZDHUZ/Es/gg+Mx4yXyrz5LhgstzlGSYUMi1aj5YjhmReZDUcGPejX5nVzmRZQbX6eTP0CE6se8yjTjfADhchb3KHAzxxTVDrHgkgGCUvnYs4KoA75FIhAW6jw9N+EnX8sqjN1ZFSBAX/YVyVj2WgwiFP7yQNNC+acy8ojGKu2Aoo9Tf0ryPt/iuIcX7kky2XXCsrr7Nhv8KMGSAnDAx/aD7BN1FVwgLb8cJEzdRUPpxI6K97VxnBzZCA77pfXR+MDwpAyMTJzl/95vQm1TQTOKvnrtRiUubBPviGXOu+98R54C7RMbZPniq5CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MW5PR11MB5930.namprd11.prod.outlook.com (2603:10b6:303:1a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.22; Wed, 28 Sep
 2022 15:48:13 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5676.015; Wed, 28 Sep
 2022 15:48:12 +0000
Message-ID: <580b7e0f-1303-bb27-0f9c-f05f793a30d3@intel.com>
Date:   Wed, 28 Sep 2022 08:48:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.0
Subject: Re: [PATCH 1/5] selftests/resctrl: Clear unused initalization code in
 MBM tests
Content-Language: en-US
To:     "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com>
 <20220914015147.3071025-2-tan.shaopeng@jp.fujitsu.com>
 <24cbb6e4-d853-6c7e-cffc-daa7412d1eab@intel.com>
 <TYAPR01MB63300E751096E8F613CC7F398B559@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <TYAPR01MB63300E751096E8F613CC7F398B559@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::23) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MW5PR11MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: dae7b708-8343-46bc-4e29-08daa168d9a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V1qAdQlyLuERkW36yDlNI9vCMfK3vHd2ibS4mcUuAB9+bfp9864iX6/mXrOroTDCwTDenolfs2DpilPQsbZn2gwnkJmL+5wyRcTQenIzD7bYBCeto67FpC132dfQaAg3R43PGU8yOMnrApLwKp/ZrFPjYVKSV2VKw+1eYYzDVk1MbdNhRjKbLwMr9pgKplgRyYI6XdeJ+Ui3Z6s6wOOoIv1oRRTK8QHGkJtIlUlR9z/jSwvVr/Xxw+Wgaly1N4k6rU+jZxQkEDhgGF/UuAkZxtDNrWCkBZi4/1JqI1KOReX5MiRoe+T7a5LJM8oQdiOFvfKwXYcbhbH6fJGHcST2aBOFe82jk5bEN+fHic3Yul9GhAUp58QsSCTZ4TRoiGUOIB/qWyn1nNvg9ENQWq+kq1IUkgtGnryXT1khb/Sgmi8HEejm9fdPe3rg/OmE2IINwSv7pbLh4fQqDbVROPok9k6KXWwR5xg2M9wVeDiUDkDKuUuBuP7ZDSkVaT3LZrhROgZojZoUSlQPoLvNYUVnElzK0byItfiC1tjaWa+aqNvCOANUMCCIpW2gBkTqoDre7I8D6KuQRFzpV/Q+8C6DZ3i96uGE6lg8cYsHjdPxoB0HrPik34hIkjsuM3g344KtOgDGUR9A39N9zU44eIMaeSyA8rFcuWftEUhF/m61Jarumu48M3jJQcxNil+lRPpzO3rg8HghZtbcUEZ4OSondX7br+7+tSvr8cnqZRHPe1k0wrPw2kG9uWJ3aC8scaRyIYk5+xXk8x+r2fO8+3g8Z/jQnDaGIR7iE/zGB3/R9Jc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199015)(44832011)(8676002)(66476007)(66556008)(38100700002)(66946007)(83380400001)(36756003)(31696002)(4326008)(6512007)(41300700001)(26005)(6506007)(86362001)(6666004)(6486002)(31686004)(186003)(110136005)(8936002)(2616005)(316002)(5660300002)(53546011)(54906003)(478600001)(2906002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1lhVEQwSVJRWHlnU3ROV28zNGNWSjdpdGtkYTNjQzMxd0FMaVFEaEd2Q3lr?=
 =?utf-8?B?KzFmY0NBWjRDRVp3ejBZN2o4YnNHa01MeWVzRzZqcUpONitFanl4Y0wvZmh4?=
 =?utf-8?B?ZS81dFNtZ0VTVWFjVWVVY2Urdi9BeFhkQytZTGNUaFdBK0gxTXZMZnpFWUdD?=
 =?utf-8?B?SVp3SUZqOVI4aHgwVjlJNUxFWHlZWWhLcC9xRGk1ZFB3S1VxaW9rSjBpWTcr?=
 =?utf-8?B?M0NWV3JaUFJYTm5qRWtxVll5d2Z1azFnaHo2RHlsWmlXR2VVT2ZKNzdTWm5N?=
 =?utf-8?B?aThLbmdKOUcwR0w4aFpGcElXQ1crZm4yNFZwcWxnc0FhYk9JTEtUbmNoUFE2?=
 =?utf-8?B?QmdpanozNGVtZS9KQ055RWdsa1VFUGQ5WkRjWXM5dkl5VkczL3d6UHRFMnFV?=
 =?utf-8?B?YmluQTBpL2JwNHE1VEcvaHlaMFpMSlNiYkZzZ3RPamZYSzBqR0syRHdYdEhk?=
 =?utf-8?B?MnJlVDdKTDlicWxKWXdObVkwUXdKeDg5OGxneXUyd2ZqNHByekwvcHFLZzdk?=
 =?utf-8?B?MVR4ODlZRGpPU2JpSjJITkNzVHBSWlFwUExCd20zc1JpdGRVWXZ5dmlVRGFO?=
 =?utf-8?B?MUVBM1M3SmJva1l1V3QzcTdCV01FNTRMc29DeWx0ZE5FcG8vYXdKbkJaZEM5?=
 =?utf-8?B?dTdMVXJDekt6U3IyaEk2NDFYak5rNW9tMUZwM3NGNGVhcmhjOGdjbHhybjZj?=
 =?utf-8?B?S1J2SlF0alZVZjVIQVNRL3E0eXJ3UkFHWnlGSTZIOFFoRS9EVGVEZGlMQWpa?=
 =?utf-8?B?U1I3eFlEUTY3aTRDdzg2Z05DSGFYL3FDYjJOclMvWDhFRm50eE1waEFGbTJQ?=
 =?utf-8?B?OGlzbVVXZko1dmVITU40cnRzcHN6MkVRNHQrTUZoNm8zYzZQcEtCWVhiaWFV?=
 =?utf-8?B?NUdpQWFOdWJEN3RrUXhjWlpDb2tsNDFodUphZEVvU1ZHcDlMRGgwdUtDeWQ4?=
 =?utf-8?B?NlRxaWhRb0ZSdVRrQmp6TDVYeDBGOVpaNDcwdUJyTUpBRWJ2dUNEamkydWpL?=
 =?utf-8?B?VWlNYmc3ZGlQNXRUUUZNVzVrUWtCdHBPRENZbFc4VDZoV2ZCZm9nZGJTTVAz?=
 =?utf-8?B?WkJTZFErRUpVYkZGUmdVSFZtVGZHZUVTYmRuNjY4SjZyT1YyRU5iT3p0TnU2?=
 =?utf-8?B?dWl1YkxqZlVlRjk2Y2JZSllzYXU1bXBGc2hrWjdFMjlPdDUyeWJacy9XenNC?=
 =?utf-8?B?VXg4RGs3Nkxnc3dUTG5hWFhKNHNqcFlEV1lUYzM0RjVma3JuK1BDWTlnYlZV?=
 =?utf-8?B?U05YVE5BK0hXY2l0OXhZWFdIWUdCRG5KUDdoZVVzTEdNWEo2S3VRNTNmUTI5?=
 =?utf-8?B?TEgrU2cyVFlOY0R4RW5SNVVqcG85T3Fhc0hDdDk3UndKVWlxWHBjaWhwRVV4?=
 =?utf-8?B?aTFoekZvOWZQeHlFQVNkRzdvQlRMTlJKTE1Ea2RSTjdhSzU2SCtobzFyTG42?=
 =?utf-8?B?NEdrNlg3Vyt2UDlSUGFhaExqRlVPZisvZkxVVWJ0WUk4QVVNNUYxc0grUDNl?=
 =?utf-8?B?d25pMFBEV3gyUEp4QjRON3ZpS3ZvUnNONGtpb3JlWVFiRjU0NG1zcXRjUHRV?=
 =?utf-8?B?dHVzTmZDei9rUjZDekhzd09SN0N0UVE4dmJlREFLUTRVTUpHd0lxUUptUFY4?=
 =?utf-8?B?VEVKUi9Vcm5RcDh6TXJ6TTNObUVBV2R4cllXV0dQNkFxUEEwRkc4QkJVZC9j?=
 =?utf-8?B?RDRSbFdNTkxXTkcrSVV1S25zcVRkMW90U0RzTkNTdHRMdkIwWGJuNzdYYXJC?=
 =?utf-8?B?TUVPbk5INnpSL2dFTnhMN0JTR3BtZGdCVWgzR1J5TE5ML0pkelJSUWZzR2NW?=
 =?utf-8?B?Z0J6NGF2UW9zRWhqaGpnaHdJeTljQTk4VERuUytKdTRZV1dSUXNPS3hTemVx?=
 =?utf-8?B?RzhHbzUyWEtPL0pXRW1sTlNjcGJVSlM4Rk1yMUEzRWh1YjZJRGVtSFpKS1Y5?=
 =?utf-8?B?cjlLclNOeit4d3JWMElza2QwUGQ0SVk2QWdvbUdzenNqY3ZQTFV5VUtTR1lk?=
 =?utf-8?B?cUlFeEdOYnBMS3R5S09PcGVXckJTTlYrejBSUkMrdDBFUXprYUs5UnAvRFBq?=
 =?utf-8?B?RFVGVWs5MTF3VHlYMlAzVzFYZDNDUlpNd2VRdmdWN0VBVE1lV2hiNlM4bGIv?=
 =?utf-8?B?cWxnaGlQQWgzNmZzUEhCbllraW5Xc3FDNG5sMFUvZmpEWDBQWWdsWlI5TUkr?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dae7b708-8343-46bc-4e29-08daa168d9a4
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 15:48:12.8159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U72aa1STTW3xx3i5n7/Y+1yLNtDwWNACfS25emGsTG21tYqw4HrBWEE8iQo1tmfMakhF7rkLPBi14S+tLBDLOpE9kYLEtGGnYSs9iiTo5cQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5930
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng,

On 9/27/2022 2:01 AM, tan.shaopeng@fujitsu.com wrote:
>> On 9/13/2022 6:51 PM, Shaopeng Tan wrote:
>>> There is a comment "Set up shemata with 100% allocation on the first run"
>>> in function mbm_setup(), but the condition "num_of_runs == 0" will
>>> never be met and write_schemata() will never be called to set schemata
>>> to 100%.
>>
>> Thanks for catching this.
>>
>>>
>>> Since umount/mount resctrl file system is run on each resctrl test, at
>>> the same time the default schemata will also be set to 100%.
>>
>> This is the case when a test is run with struct
>> resctrl_val_param->mum_resctrlfs == 1, but if the test is run with struct
>> resctrl_val_param->mum_resctrlfs == 0 then resctrl filesystem will not be
>> remounted.
>>
>> I do think that this setup function should support both cases.
> 
> In mbm test(mbm_test.c), resctrl_val_param.mum_resctrlfs is set to 1 and never be changed,
> and umount/mount resctrl file system is always executed.
> So it is not necessary to run "if (num_of_runs == 0)".

This is true for the current usage. You could also add a warning here
("running test with stale config") if a future test sets mum_resctrlfs - but
with all the current output of the selftests a warning may be lost in the noise.

I think it would just be simpler to support both cases. Having the tests be more
robust is good.

Reinette
