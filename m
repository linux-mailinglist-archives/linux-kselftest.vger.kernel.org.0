Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C70752E26
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 02:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjGNAIL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 20:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbjGNAIJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 20:08:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516182D48;
        Thu, 13 Jul 2023 17:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689293286; x=1720829286;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=CCmiSoYUKuT1ODM280oVApbQ8zsf6GvZISUZuaJse38=;
  b=P59WtOeJRz3i04E/YoQwB0hSpWz3jOpNhLcKDKiyTKomej+zRXULG+dw
   8/cIEImGXV29vWrfu0nba/XPeV9C4Wdu2JWPkI+LnzwJvnI7gpK90N9W5
   DalfYfpb7DzmMcGfkQAVpMku4148HfM8RwWOuVIB0RCzMbPgTwj/m7zQi
   +5NAOP/EwY6X8sgbRzuxWdVfTHGQI/LtuRM7yPG9l+xoRNKebFpmy12rt
   gHIPFqk3LSILC9MhcNBqsmb1gI5ymTfb1pJNKmtlZz5KaFrNFKI47k24Z
   Gv9Vw8MGxRcr1j35jZ2VNiuJraE2SLd7XXPOlM7IuEWTFFv/9/tQ6mjrZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="365385631"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="365385631"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 17:08:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="896207237"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="896207237"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 13 Jul 2023 17:08:05 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 17:08:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 17:08:05 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 17:08:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5gFiYMUenqFb15IROz8GEzhDQ0orO3Y/5x0egjttv3O7/8oBio3iD2aZNJeRuvnb3jAkii75hGlzOABofGXEhkbEZDXiYir/CZtGDx4KNKMXfFyUazDSyqwVFeshj97rqJvtih0ZY41on/G2uayEe40ff2YNpm5w3Ae77gA4fpqTX+XIFaHolLSlM0tTAiWPE04bXFxo3Ipo251H/iIH6a5Fae2KH67be9Gnap5zi7UnW4iTX8o0XnQKuZrmvJI4Eyu2MwQCLhm/euX1Ys4oObghpVODYUmC3xcjZW+eDjfmjBhPTrf3N8ezpRmXfWsfYcYrgQnpfDmUlGnpuZBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkejuOFVAI3aLc+arOS6n8dYZocPSrS8IqGdW46o/lk=;
 b=mJWVzK3r5grjYENr/MpqqVoi8r5w0n2LRid5lFiAFcwh2FIfmCC6TJWfIbST/lLY1/0g2TrefTLgymOFwjIAijtlLxw635cKtl+iaGcWrPTUZJ1cIYm0H9jV8fn1cNUYSuXRFFup6G3ZPqOe8JJ6rid47nQQVXhu7aZKFfK6+0emAwQUqifM4exCuvt+49L7piw7kOCQxT3n2Cud80ihun9JxkOeVNgCr0ItRbxfo9EOyvvEU7pZx2ISswYMk9+A1qHMDkiOnHEYkaOqe0JTyS9OTZC5bleXBvzXyQ338c/ch6FvMryuihbZrBLyl/jsrw6wP0gf18Tnm4fqzCsf9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB5890.namprd11.prod.outlook.com (2603:10b6:303:188::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Fri, 14 Jul
 2023 00:08:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6588.017; Fri, 14 Jul 2023
 00:08:02 +0000
Message-ID: <16dfd928-9493-339d-b30a-fb76f953c5b6@intel.com>
Date:   Thu, 13 Jul 2023 17:07:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 19/19] selftests/resctrl: Remove test type checks from
 cat_val()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-20-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230713131932.133258-20-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0136.namprd04.prod.outlook.com
 (2603:10b6:303:84::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d021c9c-511c-486f-0bb2-08db83fe63ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQkfNUDYRDF2jKDpHqBKe4f9PL73jI6ms9/FzU941SLYPY01KGoXlENnqo6nSdPrcn6GCKnbIVggatOYLhrkk21mRAB00nfmMJCqZN7Ad+cxfDFpgHj62JlOSxGVjm7wQ7lpl6o6P4zLfFblIr/vNLidXetmgO5nfuJXNE9pLdE1ABo01+9rHyvijKv0JL9W/vS3iXq0vYSwEKmwRB+qg2EoLEtVRIdGF58UNWO0Ck1SqXEzW7hhzNqEqClgRw10mKv/+/Z/xSyfCjihVHh6lPSNcwfvQlm5I8oN1oNqk3fu3vfvAkswGy+cCfg2AjbW0P1smEPIrY6A1oSU3YHxheLgCZuSiPDYbTsjO533dhD2CRvoCYKhVr+uu07Z+qY/zxW+3fdsG/yiPKw+m9nZOPOYl14ttYSHX+iyJqrAtXiIX2lLXPEeClLPJREDlXgG/AKNEJd0qc88C78CAmeIzi21umQh3nd47B95D5nSiHBc0nGVZrgUWsbHO1txPCTLhkeKsDhf6Ffi3nSCOxu59sA8PlBHBATJMFVByi4F5JgaHN4Iz7dcYYU5oCA/EPnAKDGoIxCYzLg+3pN4fH3iD0Fp6X/rT62thah1GTzUypYkOtT7nNPCYf3lwq7Zx8+NCVEZgqRTmBalx8SjHUm3aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199021)(53546011)(26005)(186003)(478600001)(110136005)(41300700001)(316002)(66946007)(66556008)(66476007)(8936002)(8676002)(5660300002)(6666004)(6486002)(6512007)(31686004)(6506007)(44832011)(2616005)(2906002)(4744005)(31696002)(38100700002)(82960400001)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlRoNEFqSmVoY2tITVdoV3VydHlJNGNPOHpFZWx3NjlwL1hIUUdnV1ZNNHI4?=
 =?utf-8?B?SS9VcGMxSGdaWXpRRjNCb1NtRGdVN0VUWkRmVGNXZXNJTHc3anpFeFpTbVVW?=
 =?utf-8?B?UjNNdlpuVTlEM3FvMUxSaHE2Z21jcnRrT0NYUHNucUhZd3BEbGQ5bm1mZDVv?=
 =?utf-8?B?ZUJvNnJmTTRkUzFYWFNSRzQxSGNXTmkxVkU1WitNUTZHYW53azhlT0F1SDhJ?=
 =?utf-8?B?cjR6Umh0Sy9vU2tuN1ZKM0VmelRXOFRyWURjZURialFxRjFkeHBxbjhENURD?=
 =?utf-8?B?SEdCZUhXdWlWYkhQSWp3dmptMUhIKzA2RXpmQXRvUTVjTHlHbjdTTUVGQ21k?=
 =?utf-8?B?MHNsb3ZiUngwM0tQWW9GYjl5T2NxcmpGUzd6SnhudDZMMGdkVmxBTnBqTndw?=
 =?utf-8?B?L0kyNnp1bjFXTWFUOVdQSVhjZmNCMC95YWl0eU1iSGlFU3BLVXFGTkc4RW8v?=
 =?utf-8?B?bVNZRjFQTGR4RFkxU1IyQlYwYWswamtDZWZkNndLSmpFUEZzd2UxcUpzTkpz?=
 =?utf-8?B?UXFKRm44cWplSnQydGxTQy9aUG1tTHJCOUlzMkxoWk4xZGR2YVhzanlteVdj?=
 =?utf-8?B?bFc3bUFXUFp6VHRmNU4zR0pnSk1vM3VlbWU0N3owS21vcVBmR1NIcldxVmx1?=
 =?utf-8?B?UHAyYkw4cytXS2hHWExyK0h1N0NRZklXbCtpRlFYd09CLzRmczl3NXZmc1d3?=
 =?utf-8?B?MWtVSVBhd0pvRUhyR0o0VWt6b2pXYU1aMlo4dVJNbU5HaXdtZDgvb0NRVmlw?=
 =?utf-8?B?YUh0dDF5VHFubFVXNnR3RFFlRm1tdnhkb090ZHNtRTg3WkJaMytydjhncWln?=
 =?utf-8?B?aXlHYk9jME5YU2tBRVJJQ3VVTUJGSHZ1QmZyNUdRWjZRTGhLMEYxZG81emFS?=
 =?utf-8?B?enZ5bDhmL1BMMFpUYWs2VForZ1pGZGhOdVA0OGNrRWVLZytFUVIyVXRRVkZG?=
 =?utf-8?B?dzdVRjVKV29KaTVkL2pWbU5Dc1F4dWs2U3ZONUVoMmIrZXpBbjZxL0g3NkJw?=
 =?utf-8?B?VkIvSXZEZEttZEZXbXRSbWhXQ0J5eDZWMFFlbFV5S1k2NzhXSXowS3JGRjlT?=
 =?utf-8?B?Rll3MjVGWWxiNlMxVnRydDhDbFgwTUdQbVFORjdGemdhSW9JR1czVXVNUDIr?=
 =?utf-8?B?QWRrWi9EY0dvMm11SVhva2Njc2NzV0NDWWprRmhtdzQ1enk5S3RwT1RjaDYx?=
 =?utf-8?B?Q1ZPN1ZSRkxBTVVkM0VXNVVSb1BTTVJVVEJjM1RCU1NhVTNFVHU3RCtBbjhO?=
 =?utf-8?B?azA3M1ZGRG9XMWFKcHBQOHdlcit1MUJxUEZOWXBxcE5FUHdjc3pxVlg0MEVl?=
 =?utf-8?B?K0p6bG4yZHp3OUlpaDdKU3I0S3JiUmJ4V0dxOTVIV2owcTY5Q24vekpHZVBB?=
 =?utf-8?B?TVBrWlNlQXFPOC9RcmpCMkFkazhBSHkyQUpidUlCMGd3dmZmU1VIRDFVL1RR?=
 =?utf-8?B?LzdEeWJjcHZwVUI0OXpIV1hTbW0zWXY5dmxCbEtGSmJvZVB2WUYyaG9MZjdO?=
 =?utf-8?B?QzM0M3JUNDFaYnFXT2pzdDBZUUwvdzRJNm1hR2dnZmNHb1d2VVl0cTBXYTZ5?=
 =?utf-8?B?VGcwSGJiMC9IaWx1bU9zV3RnSkNWcytING5PbFlLZ2N5L1Z0ZlhMeDlhcGhx?=
 =?utf-8?B?Y3RaWThka2JIbHdMVDA5QlJ4ZGNFdzhYRVN0Tmpia2lKWUI2RXVIK2RIUVRz?=
 =?utf-8?B?ekhoQVV5SHJwZHB0TW9xanFvNmczbWxPUS9KT3l3SUFHZ24xVWJ0WS9LMWtw?=
 =?utf-8?B?RitnQ3JYb1VMZzhJUkR3M25GK2hCUGdteHZRZ3JUb2NvK3U3SUc1KzgzRzR4?=
 =?utf-8?B?TjNXdFN0NUxob2lhMnovQTcwREpLdUdnaVQ0U1d4OERheFl2ZjZHamVBaEMy?=
 =?utf-8?B?L0xVcWRpaFVtV3F5dWliMnZKdEg5NkQ0VkZxeWlnWEF2K3gwN2lhdVJJQ1FU?=
 =?utf-8?B?UnFSeE1PSVNYVjhERHJ6S2VWeFE5SUhQa1daNXdFOFFmdWdRVnhIb0VjUmlB?=
 =?utf-8?B?YWxYeG5FWndlaDIra2J1RTkwbW10S3kvdlJQMmpGTTZHWmExS0IzUnZCNnFE?=
 =?utf-8?B?VDhzUk1xYTF0MUNXZUhSaXBUQUNub3I3dVg2eUhON2dxcDk4alp3RTZFSmlW?=
 =?utf-8?B?bGhrSm9USG1Ddi9jK0VXVDQyeWhhUUNoUkw5QnJEWWxTYmhQQTZRWWI4bXdk?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d021c9c-511c-486f-0bb2-08db83fe63ee
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 00:08:02.6264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PXd5f52LypSUz0kCEMZPhkVBgaMvLYrY1jvuJfgLiLs+9gA/LtsFwpJc0zaYhG7ut2NbAfbIbapplXiDxjLq89mnWeJHaObsb8rYsl7iCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5890
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
> cat_val() is only used during CAT test but it checks for test type.
> 
> Remove test type checks and the unused else branch from cat_val().
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
