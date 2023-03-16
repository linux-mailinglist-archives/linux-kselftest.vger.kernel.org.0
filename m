Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2866BC211
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 01:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjCPAFK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 20:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbjCPAE7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 20:04:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C3D52F58;
        Wed, 15 Mar 2023 17:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678925057; x=1710461057;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=wYMngcbA+LGt7OIJ5X+CnkTGXJSgZc8cI08AoxkUBg8=;
  b=dsvBDPLvnBnZDpHaxqOdCdHyTid8T47iEzuR89IrPAieiflbB2z1hwME
   0rUjA0RzPXcmOPop65bbYfD/6EmJFVg/w11QbSyUPGhbzZWuRaKHGz6y1
   NkNZuMS0edRdMAnMst1xobf/3cY1HkAJ/G5Tq0XEowaZiFczzvAKaeF1/
   mvjLUWpd4zxrMoYR3tYlSQKMcO8XH59Dz9sFw3SpJqrYefVjnKMHdkz/L
   ZeopUoS3E1D+ze3xKluvT2dqp7YBfdcKZTg6HryQBLWZPwzMvaz000vrc
   x9oKRk/AERW6P5e4wnDaQvOzlSA+UXJi6jJd5k3iVFlvzQ6iJpAy+lN9p
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="402717619"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="402717619"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 17:03:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="709861580"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="709861580"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 15 Mar 2023 17:03:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 17:03:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 17:03:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 17:03:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 17:03:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4vMJnqdQPowJIltPUmxu0lbFw6qRIB/2bo9PjfphIXxnzjq9k60dmLxcF4kKkbDIu3tQgBZHtXFTYAyPGR+EpI8X8PCzQ1NEdJDGEoRfIQHAVfq4Ysu9UVlpm1dxSD3QQhvxmFo5H6tIOHY7c5tfpYmgeOgEfVM97iU6unAVbxp8xy+5nQ4eoLau3IMAQfp31mYxbqDVe6marMwebWGMcKMUy90arrnp151qJD3zKvDWtfI+ZiY/KcqgtNJqG9fMniphoda8Zre9x/WvypoaTR+Jeyiz8eVboVjsNLr1HdmVXlpXPjHU8vaHk1bGRjLas+AgoLgMhiqhhBVJ6vzDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrFNLSuVvwVKMHlLDoJkNdWFf/PmqQ7I0ZxcVA+EE7Y=;
 b=J26VQ5LUlYotQ7Bd652d/6lWl2tWaknHhCFe5N75Gpt6t4kBt0jrwcz7KhYN3qYwIOLq8FRY5K95tt7FoKoklklHkWzxzAz4nHXpb3e+/nLej7lL3hVPHHrN/xVMkbHcv26nr/lUUCtgqRVIJD6SlkfAfXTVRj9UoKYBmu8RckXw2hUkvu1r8O84zAaDqubddUQ7Q8z4ILkyPfzqMfjT4Z49C8euMo7gQ6gmyVLxq+2FlMtfsWBKV6lGUp3QQYYuDoJEHKDM7lWX1f5lDeV+x/pwEo/e/FifkbNckXnar8bRlBYf7rjcWG76/rigzBKIblk5tLpt7Heezd7gqG9ToQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BN9PR11MB5340.namprd11.prod.outlook.com (2603:10b6:408:119::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Thu, 16 Mar
 2023 00:03:22 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.029; Thu, 16 Mar
 2023 00:03:22 +0000
Message-ID: <d95bdf27-1584-39f1-e227-0d5fad707279@intel.com>
Date:   Wed, 15 Mar 2023 17:03:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v2 6/9] selftests/resctrl: Change initialize_llc_perf()
 return type to void
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
References: <20230215130605.31583-1-ilpo.jarvinen@linux.intel.com>
 <20230215130605.31583-7-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230215130605.31583-7-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:a03:180::32) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|BN9PR11MB5340:EE_
X-MS-Office365-Filtering-Correlation-Id: 58b8de12-f858-4d99-8251-08db25b1db06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1uquELcvMY8rIYXTGxYzctQx5ozy1TMNsf2WJ7pGgWYEx79rX68ou6Y6TyjjS3QaRokCxfMcXzzT/ZiIt7j65m2DpFHWXlhHVJrHzF9DrJlaXIs8unq28AtOKY2lApt+r8tlR6VBn1lzmozXWEj9KFss39izxFGwALY0whl3RZ+efSkhZ8I2r6ht9Fu8s9jwa5oj8fSb7sIxOV7CTHUgsZ1gi+XsokeCTVZ6Y87ofzU1BVcWngOVFi4yWL0QtGeom8aeSoNiZS8Cy9omIHZKLYlG7Itt0kQkRy4hKHL2nB70eUpN3ra8Zvyg8GPidDfPsFVEX4MK7JYhgZKz6TUfCN89UwXrU7w3qPsgEDpLWqdXADfVS/MYqz9wiX2P0XZfDW03SLBiyijB2/mRzCgpnF93t0lvIEV6/1mJStCznwKQwxeDjmOi7dX2o+EHBWulE58H8ZnB7FGxjwFbCaDLoHfmuk+/Iv6VgXxtx3QVfEoF2MAxqc5eqGchfpj+DmwBGzmrzf2trfUsP/zIzqzAC3450VamKngW7kyXYfw0tu9JaYZjW5Guzlwra8oxg9PyDtkneus9Q3h3uKdIVlNgJ7UVuwXDXFmu2JXLJEZGlzUOouUE6lZnqjaVF54tO5dh89/uDhSqxsEcn4mYJzk+Qn4aleHrQ84eNQ3ea58NavJtU4ekTpNYFR2wP1YtnadJcsMkuqM9jORrvZJXiET+K5rkq524jmUDO4IOiKgh6Sg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199018)(82960400001)(31686004)(2906002)(5660300002)(4744005)(36756003)(44832011)(186003)(86362001)(110136005)(41300700001)(31696002)(66476007)(66556008)(66946007)(316002)(38100700002)(8676002)(8936002)(2616005)(478600001)(53546011)(26005)(6512007)(6486002)(6506007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3ZDTW5LOWRNQWlCK1ljR3hVRzVMT2NvS1RxS21RaG5oSkxaYUJ4VlkzdG44?=
 =?utf-8?B?c3MrblZUVmZScjJqUUxTRncxbnc5OWtudTZ3N2tLejBBVjJkZHFXQmErazVl?=
 =?utf-8?B?dHVJd2lqVnlkSXFHb2JoM2kycjRzZnZ6aTBqL2pRaVRBVHhvZzRkcmVnWjFy?=
 =?utf-8?B?RHg4Tjd5clR4YTlqcjFpbkd3Z1RlaFVWTURiZnBwYWNpeXRVZWNUcFFYK1JB?=
 =?utf-8?B?L1h0SVpmKzltUzA2UEl5UmVsVzhrbmFxWDgraUs1OEtIczQzOUpsTkJGQU9M?=
 =?utf-8?B?OFpEcHp6Z1Y1THMvOENiSW41aUo2bExyeWJwNGJBekVtSzY0Q2ZSNWdtRGt3?=
 =?utf-8?B?RVNJM2NuNkZ5d0hGemQ4dmdWK1dZUW0zcnJHN3M3M0RBRlVrRkJuVnpZWUxB?=
 =?utf-8?B?Ui95QTIxQWdCYXVtMHBKQTVlRzJISys4OS9WQTFaenhIVHAxVElsMXRBQmxL?=
 =?utf-8?B?MldBcnNhYVpvME15RXE5c2FENGdDRmZESXBwUHljSGVsTUZ3cXVKOWczRnNI?=
 =?utf-8?B?Y2VUTzQ2cktCa3NlT0o1dHorMVoraFZaYktYSXljK20xQWRRRkNPaTEyTGJU?=
 =?utf-8?B?ZnBhbGExL1Frb0NPUDY2a1UwSTNIaDNtUGVOaDhLY3hQa2lWYklJQXZWd2Yw?=
 =?utf-8?B?enRnZzNDTzNzVDRFZWM0QnFhM002Um9ZR2lWRVpoUW5ldTlML2ZOczE0MHdF?=
 =?utf-8?B?VDZCaUxiTmZJbnptdTlLZVhxeDBrdWVSaFdVMmdLRHhvUFNFZ2EwSVlqUUoz?=
 =?utf-8?B?QU05QUpjclhOZC9Uc0tpOXZBMlI5SjdPUTVLZ0trcnBwbjBSMVkrUE1aOGQ0?=
 =?utf-8?B?RDZNdjZvMXJJcGkrM1JncDE2UU1SekxMeU9QYk9YYnZLZmZxZ3pHeFlhRVpI?=
 =?utf-8?B?cDB0Vlhsa2tIczcyajlUYzVTbGRkUitrOFJWSi9ucFNOZkl2czZyeTVmcVVs?=
 =?utf-8?B?WGdoOFlCUWNjOGsvTUU3WlJFc2taemFTVGtnZDJ6R3Y4SXJPZDZOZ0U4Mk4x?=
 =?utf-8?B?d2l5Zmp3YXhrcms4Z3RkUVRKVzhNSHRvdnVnVzZCTk9UUEIrYnNielFzQ09B?=
 =?utf-8?B?TVlLL0RhYzcreGlVMjViakJjbFVkVXJmYk1odDlKUGxYY3paYk0zOUpDRkJi?=
 =?utf-8?B?ZXVsSXd1NXBZTDNwWXpRcEtFVis4WE9ZNWZUUWx5SU5tb2NhdHN6c3g3cWpq?=
 =?utf-8?B?UHczemRYWGkyRUhET1NUVk1lYmlONzc2bTdJc0U5bnE5N3Eyd05ZS0o1bkJa?=
 =?utf-8?B?WElrOUcveDAxZzdRaTRaMS9xUDlMeGZNSjVYbGxUM0NsRVp0K21mbkc5Sk9W?=
 =?utf-8?B?aDRiVC9JQ0kzek1iUUFCRDAvem8zZVE2WGlnczhKWlkxemR2Wkp3NWE5OHZF?=
 =?utf-8?B?MnhIbFFBTitySTJMWG1jWFQxWHYrSHJVVUZjMXYrY1Q5YjhtUXc3d2k0TE9P?=
 =?utf-8?B?QmhpbFU5Y09kY1dQaFAxTDJnU1JoNmpVemF3TU9EdXdNalNGK010YmM4TjVC?=
 =?utf-8?B?RzR5MWFEanlRYUJMbEN3NXczSVFCY01makx3aEFqTHJXTW05NUVidmxaMTBT?=
 =?utf-8?B?RnBxNE4xeWNtamM2SytXSTdieUZJZTlnQ1JEdXVTWlBHZVRvc1dFdVBXbEdU?=
 =?utf-8?B?NDRVT3BtQzFZaGtlN1BNQytyd055M1NpdlcrM2RyQnFPUnpRemYvS1JmY0JL?=
 =?utf-8?B?M2tuckRjQTIvd2t5YUlRb2M1ODRGbmhmNGEydEprVm9HMkhOeDhmaUxSNDVP?=
 =?utf-8?B?U090QXZIVnFIeUpNUllwbUhnZ0c1SG80MmhXVmJNNFd5Qk9yRFlBOWczZVNy?=
 =?utf-8?B?dGtCVXhWMGpsNjZqeE5JdHFTVjBiUkxhTFA1dDF1cWVxVXAxZWpDdmVMYW5k?=
 =?utf-8?B?VnNkZElkMlIwaUNWYjJTb05KV1pHZERaazBwRzVIdEpLdVpSWDA2Y1V1TlNr?=
 =?utf-8?B?NnhFdHRjQUQvN3VxclZTL0s5TkZWOU03WDlwdjhRZHZ3aEhqVUZLZDFlRHU4?=
 =?utf-8?B?cVNRN2xNUzZSL1d3RzdFVzZ6cGNyNk8zWjJTUnBYL3pmSVU0SThCWFVIL3VE?=
 =?utf-8?B?RWhRcGMwRnJwa0d3WUlKd09pZEpPYk5peG9jczJ3MXYzVlFrQzI5enNiRkNC?=
 =?utf-8?B?TlpwclB2MkZXV2JDdVczUFNXY3RHUHBkUHptTUszd3FybXF3NS93Z0llQ0wv?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b8de12-f858-4d99-8251-08db25b1db06
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 00:03:21.9007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MbUELGJTc6z7Vt/soRCeKA4MGSQG8f1gtR+vH5zVgaIQKWjJZttzXyL2V2rqlInyxiFKdiEfZmRkZ0YLzmQA8oe/PIWdmtvLP4pVoTd0dW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5340
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 2/15/2023 5:06 AM, Ilpo Järvinen wrote:
> initialize_llc_perf() unconditionally returns 0.
> 
> initialize_llc_perf() performs only memory initialization, none of
> which can fail.
> 
> Change the return type from int to void to accurately reflect that its
> return value doesn't need to be checked. Remove the error checking from
> the only callsite.
> 
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Thank you

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
