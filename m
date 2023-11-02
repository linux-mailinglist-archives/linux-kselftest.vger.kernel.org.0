Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643417DF92F
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 18:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjKBRvs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 13:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjKBRvr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 13:51:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148EE111;
        Thu,  2 Nov 2023 10:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698947502; x=1730483502;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oD5XJX8xl1C7D8wkoE5sJQ11davkP3nC1h0ev2L35Dw=;
  b=JBGURh4u6A9o8HSvyDStEFJBAkY4Kc/GR7FbGHQgNwkp5C7bB+bZ03f5
   7oUREk/GAuEVawQzgOejhLDE1w+smZuobVefvFPFGaLTXi/XLva3ZIEBP
   KOz9XdGtbLhl2o0103HUXbb+7JFDw/DyKmibsLekIluyh1IHds+RNNWjf
   c5nY52ST1NRI/K4oBW1uQ5nHtvO5Q/GXBXPLONHUp7LX59CBPNHve4oI7
   uCUKkhq+fYZ7iLHw94YHn2R9POEN7WkfqQXDf5E7qN/ywFWVU2ANs4eVF
   idroP6K53U4GoUNY3VVB+G8FDmoZp4QKFiiJuOGpXM2WDJBo9cyH0BT8o
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="7413448"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="7413448"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 10:51:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="2631798"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 10:51:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 10:51:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 10:51:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 10:51:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 10:51:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oO+3S9AISb7pzPdPKoxjjMIs/p5gGhzRf8vKmYYuQkqCGw37mwyztwvcURUdprb49+U98CLIsJep9mV/9vT2vRsVg8ciHVdaSh4ftLyWLjy32n2ZecCvtK7KM/g8owN2BIJgpLpbEtxhuCC+e1Y6Kf83VWIuuZPTmG5lcGlwvCahOiu+KAOVWRdgPxU3Br8gvglgjiF4mNk/8+vPvHokpiZBVMkRE3XGx/lYgBrPoOViIY1KCw0HfbvlX+LC1FwYkz8hCi4OPYvgYUXeiFPREAfD4WI3amCJ3nvk0iH9hcmdT6Xi5FSeisHOKMu4ccbz1ymxNGIygh4hMDdAtWoEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbktBlHTBCvvPsHqbVMquWxoCF7aHT8foX7VW4NWKnU=;
 b=ZzR0aSQLYn8+tZ3xD9NfaToTUEIy3ScHKubvUJnKuRx21F+PdW/bda7GDBbNYYl+5SnVKBSAbztwO7h1yLlY65HHJW2O8MwYcrl85ti/Fph1UPqF7tsgVHeHibHngXFVjqTugJXdqWBhZw8n8fQSnuU4JzxSmRyFiclBpAxLZsZxnK3h57Na29oELnp0nO+ngzvVNUj7N9SW1BB0TLcSZ35PFxn8qZLnCMktFZYc/S7IQ1pxasPF1H6eKcsOIYOd5Mc36WoVxQhAXPNEpTTWpSKhvPHkOPHC52k3nuWV2SrdW6lqooFCaVeM/mbqeqA6Pxa05G0qcbgxaqlOsvtp+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB8361.namprd11.prod.outlook.com (2603:10b6:610:172::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 17:51:29 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 17:51:29 +0000
Message-ID: <fe5284f7-c27a-4ec3-b12f-f3556a9bb456@intel.com>
Date:   Thu, 2 Nov 2023 10:51:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/24] selftests/resctrl: Rewrite Cache Allocation
 Technology (CAT) test
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-17-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231024092634.7122-17-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:303:dc::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB8361:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c856b2-a0d2-427a-52fe-08dbdbcc57aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bTxG9nfWOyEws8DEapJ2XYK2v1S4evDiPEHe4yZHXjnSyqurAp4HgbH22sYVTlSSjvls8uOgmm2Yyt+0adjMQOrisA4At9nbbjC86VpFPb6zlM48E1egKg7WSo7N0z60PeStZ9d5CWjmFK3FJJ+cpk66V4xH+EwdluvW9alqdnCVcUf1K9LooKCZNj9CQBXRxHkHuJ4l+bGGU3WrPZ3V+g2sShKM6QSn5yt0RfR7omKxivoTosYb20OOugOVK9OSolYg1xZnMyIFeK9srL/RwW+VDoPIVwTRht0my1Jw7fcmwtjwtPzW77X97nhXyrOXCKyxeLFfyq0sWGYiXLGddlLvm1yW+2abLD2Qkfwo0yutkb5R8XK+Lt+O1lqtmw5ZofSdHatGedYnI63IS4YGxkIfz8vgJ/CPeDVCTSj4Ffaw6+8xe1A93BivP6ST5eWFxhibP5TU4Xk7GRzy7XpbFVmsVKhHcY8p7wNJTlahkGS7SMIqBds93Lf6XzZvSUaOeVUtRth7iezXtv5wMd45mAFUF4AJpInsipZjLlIEzaqJbsN1KfEA8WZ3MnG3FRG6QINjATXrIlCUyXytBAAuhYOP0Jucwaa7oLwscGnzYM38IHc0Wi2V89/o6KB23e4dZ0NFuSNfKYmxGnZP0T7H/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(39860400002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(36756003)(6512007)(6506007)(53546011)(26005)(86362001)(2616005)(31696002)(38100700002)(83380400001)(478600001)(66574015)(82960400001)(41300700001)(6486002)(31686004)(316002)(6636002)(110136005)(66556008)(66946007)(66476007)(8676002)(4326008)(44832011)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGFNeGd1NWYxN0lDSHpHMWdsTzg1NGh5bU9abGdUbjkwbm1XWW9tOGZWVEx4?=
 =?utf-8?B?cFNnUTlKM0RqRk52NWRKWVJISktVNks5UjNIUkdwL0cyYVUwd1RQeWR0VjhE?=
 =?utf-8?B?SWpWVkRxb004M0wrajZMS21tMUxDRXhlaFFidUh5SC9Dc2hURkdvNVg3aFYv?=
 =?utf-8?B?WTBsTmRJSkNFUjRONzhBUWtlRGJRSzVGUVNzKzdPSHgyMFM4cXc3OVh1dVhs?=
 =?utf-8?B?WlFHUjZUeXlwL3BjTXhFbG1rdGtHa00vU0ZweE12ZlNva3MycWpjblpjOHpl?=
 =?utf-8?B?WktCbVJCUnp0U0hhSVllTmpwYnJSc0J5dkxHRFoyYkhod3dhTG90alJ3UWZI?=
 =?utf-8?B?ZmtDZlhnSmdKRlI3ZVlCYWpvUDVjcllyN0NhWEIySGlROUVzR2VmWURkbUQx?=
 =?utf-8?B?OVB1dkRYOUl2OU0zNHRtVEhPL3RIZHZUOURxZ3dYclBmV3JrRGY0LzcybEFV?=
 =?utf-8?B?QXZVT1FObEFYU3NyTFV6eTZDRFJXMlgvcnNFZlI5VVhQTnBoRi9uazQvNXQ1?=
 =?utf-8?B?N2lmMTlLVjhKeHdvK1V2UVhOQ3dnSDl6cmUyb0s2R0xJWS9CemxUeUV2SitB?=
 =?utf-8?B?ejdURllMdUZIVTRRSDdFUWNxenh4eWpHQUt5VXFuSDlVc3dvUkwxc0pHVVFD?=
 =?utf-8?B?ZlMrZStQTlpEVWk0VG5WVitQd3UveGlFcmdVcXpBZkxpZmFEZTJwWlVWS0JG?=
 =?utf-8?B?TDA3RGg1VjJiWTQwbkJIeEU2M2ZoS2FpNThZWUh6eHVyL1kwRUt6d21Sejdv?=
 =?utf-8?B?LzN2QmpPOHpqRFJaZTJBRzhLUUxxNVFoMjExdHQ5eDhKdzh6QlJoOFJnYVVs?=
 =?utf-8?B?L0VaWVd3SlZlUmJzOXdyTFlLOUx2djBhVlppTjZNMmtVYWpKVDF0bnNVZGJH?=
 =?utf-8?B?amtRYVkvY3hLcDBzeHoraWdEMmhxd3BGWHBvNVZicmE4RmFuUUxhM1pOZkN6?=
 =?utf-8?B?NjZKWkYyYlNaNXFGbnBVSStpN1FSMlpqZDVtcEE3RkRUeUZPRlRGVDRiN3F6?=
 =?utf-8?B?RG1pOGh0NDZGNyttSDN5R3h3R3BhN1NLSlNvd1NjR0t2c045RDdHZXZoRzJV?=
 =?utf-8?B?aWVaeGxpRlhLZnRVVkloalU4LzN4WE9ZdDhuK0ZVNk13a3dNQU1Kd1RuL083?=
 =?utf-8?B?QjROTFhtMXp0YS9HUEdONGFPcGoyS2lkSndkcHhqVFMxTVFaNkNFdHowYlVF?=
 =?utf-8?B?S05GcytrQTRwTEs1Ti9OV2VqQkVHVEhxaEdTb3NJUjdzRzNOQWxzQlZzOHhn?=
 =?utf-8?B?YkY3RlYwR1drMHBzL3dUZTc3SGRIL0ZXSzl4bzU3WUFObER2ZHkvc3g0RG96?=
 =?utf-8?B?UFRJUSsrWTFlYTFVVHI1M0JDMEtUOVh3Q2gycGpSVmh5b0RUV2VDQ3VZdnhR?=
 =?utf-8?B?Nitxci9JQWJ2UGh5ekJ1VCtnak5MRlBsTFppL1ZiMjF6RW5LanFyVjNVeWNL?=
 =?utf-8?B?bnZjWGREZkh6OHpLNWs0OTRRSlU5YVFHb1dYRVl4YUJ5VSs3S0hsWllsOHhG?=
 =?utf-8?B?SmFyZTUxU3I5dnFGK0wySHJNMmt0dmVOR3gyL3FrZnBCMkdyQTgxZEVyVmdp?=
 =?utf-8?B?cFZ2cWVkZm9vQlRPRUxrUm5jUS9Fa21zam43UkpIeUdFV2hKVzR3T3JlcU1i?=
 =?utf-8?B?U0xrdTVZYTdoQTljMy8rTkdxZ1FDTkpVaG41V25jQ2VkM3lJVlB0MGhvMmlo?=
 =?utf-8?B?OHZscU02WURtZkkrU0xNSE5xbmVVM2picXh4Z29zNkZndWM2VFlWZHhqU0xm?=
 =?utf-8?B?eDR4bkZsYlg0ZWlhTFJXb3ZEck8xWHg0WmF2ZmxlRjBBU1J3QXIxekJoN2F1?=
 =?utf-8?B?dGRFazUzOXRzb3hLL09ERFEwNVpybU9UaHBVSWc0RFF6aWVVb0JMQUlNS1BQ?=
 =?utf-8?B?eVQxNXpzbEIrT1NscXBRTGFYd294d0wrZFlIRWk4bGc3YzBvTWMzY0JpYjRC?=
 =?utf-8?B?bGZxcTVTOS9MRko0ZHA3dWNQVVlOd2ZmbUVnWTVwMnBsMEtVVlFsbjdFeElr?=
 =?utf-8?B?ZGpJcmlYc3lLbmhDVWdvQ2VYTUdnWmhIQjYrMTdBQmR5czcyNHlUOWJhcTJN?=
 =?utf-8?B?dlQ5NVNzQVE1MmhLRUgvVHNsZk95WFhQTENLd3J3TU5YQWFDUDNFbzlQVitS?=
 =?utf-8?B?eThuKzVaNXRRb2g3Tk12VGVpSlNMSnZERGpTQjdHNU12ei9iclJuQVl6TWVu?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c856b2-a0d2-427a-52fe-08dbdbcc57aa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 17:51:29.4936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4x+EcQmpPw3R0onsoCe2VwB++i00WYMGzXchEeOJYJl+I9EnuJCKbF6AGp568kgrrfLRW652Lr+YWNRyoXN74M4jAOviatrMECILn7hTPTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8361
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:
> CAT test spawns two processes into two different control groups with
> exclusive schemata. Both the processes alloc a buffer from memory
> matching their allocated LLC block size and flush the entire buffer out
> of caches. Since the processes are reading through the buffer only once
> during the measurement and initially all the buffer was flushed, the
> test isn't testing CAT.
> 
> Rewrite the CAT test to allocate a buffer sized to half of LLC. Then
> perform a sequence of tests with different LLC alloc sizes starting
> from half of the CBM bits down to 1-bit CBM. Flush the buffer before
> each test and read the buffer twice. Observe the LLC misses on the
> second read through the buffer. As the allocated LLC block gets smaller
> and smaller, the LLC misses will become larger and larger giving a
> strong signal on CAT working properly.
> 
> The new CAT test is using only a single process because it relies on
> measured effect against another run of itself rather than another
> process adding noise. The rest of the system is allocated the CBM bits
> not used by the CAT test to keep the test isolated.
> 
> Replace count_bits() with count_contiguous_bits() to get the first bit
> position in order to be able to calculate masks based on it.
> 
> This change has been tested with a number of systems from different
> generations.

Thank you very much for doing this.

> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/cat_test.c  | 286 +++++++++-----------
>  tools/testing/selftests/resctrl/fill_buf.c  |   6 +-
>  tools/testing/selftests/resctrl/resctrl.h   |   5 +-
>  tools/testing/selftests/resctrl/resctrlfs.c |  44 +--
>  4 files changed, 137 insertions(+), 204 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index e71690a9bbb3..7518c520c5cc 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -11,65 +11,68 @@
>  #include "resctrl.h"
>  #include <unistd.h>
>  
> -#define RESULT_FILE_NAME1	"result_cat1"
> -#define RESULT_FILE_NAME2	"result_cat2"
> +#define RESULT_FILE_NAME	"result_cat"
>  #define NUM_OF_RUNS		5
> -#define MAX_DIFF_PERCENT	4
> -#define MAX_DIFF		1000000
>  
>  /*
> - * Change schemata. Write schemata to specified
> - * con_mon grp, mon_grp in resctrl FS.
> - * Run 5 times in order to get average values.
> + * Minimum difference in LLC misses between a test with n+1 bits CBM mask to
> + * the test with n bits. With e.g. 5 vs 4 bits in the CBM mask, the minimum
> + * difference must be at least MIN_DIFF_PERCENT_PER_BIT * (4 - 1) = 3 percent.

This formula is not clear to me. In the code the formula is always:
MIN_DIFF_PERCENT_PER_BIT * (bits - 1) ... is the "-1" because it always
decrements the number of bits tested by one? So, for example, if testing
5 then 3 bits it would be  MIN_DIFF_PERCENT_PER_BIT * (3 - 2)?
Would above example thus be:
MIN_DIFF_PERCENT_PER_BIT * (4 - (5 - 4)) = 3 ?



> + *
> + * The relationship between number of used CBM bits and difference in LLC
> + * misses is not expected to be linear. With a small number of bits, the
> + * margin is smaller than with larger number of bits. For selftest purposes,
> + * however, linear approach is enough because ultimately only pass/fail
> + * decision has to be made and distinction between strong and stronger
> + * signal is irrelevant.
>   */

...

>  /*
>   * cat_test:	execute CAT benchmark and measure LLC cache misses
>   * @param:	parameters passed to cat_test()
>   * @span:	buffer size for the benchmark
> + * @current_mask	start mask for the first iteration
> + *
> + * Run CAT test, bits are removed one-by-one from the current_mask for each
> + * subsequent test.
>   *

Could this please be expanded to provide more details about how test works,
measurements taken, and how pass/fail is determined?

> - * Return:	0 on success. non-zero on failure.
> + * Return:		0 on success. non-zero on failure.

Is non-zero specific enough? Does that mean that <0 and >0 are failure?

>   */
> -static int cat_test(struct resctrl_val_param *param, size_t span)
> +static int cat_test(struct resctrl_val_param *param, size_t span, unsigned long current_mask)
>  {
> -	int memflush = 1, operation = 0, ret = 0;
>  	char *resctrl_val = param->resctrl_val;
>  	static struct perf_event_read pe_read;
>  	struct perf_event_attr pea;
> +	unsigned char *buf;
> +	char schemata[64];
> +	int ret, i, pe_fd;
>  	pid_t bm_pid;
> -	int pe_fd;
>  
>  	if (strcmp(param->filename, "") == 0)
>  		sprintf(param->filename, "stdio");
> @@ -143,54 +168,64 @@ static int cat_test(struct resctrl_val_param *param, size_t span)
>  	if (ret)
>  		return ret;
>  
> +	buf = alloc_buffer(span, 1);
> +	if (buf == NULL)
> +		return -1;
> +
>  	perf_event_attr_initialize(&pea, PERF_COUNT_HW_CACHE_MISSES);
>  	perf_event_initialize_read_format(&pe_read);
>  
> -	/* Test runs until the callback setup() tells the test to stop. */
> -	while (1) {
> -		ret = param->setup(param);
> -		if (ret == END_OF_TESTS) {
> -			ret = 0;
> -			break;
> -		}
> -		if (ret < 0)
> -			break;
> -		pe_fd = perf_event_reset_enable(&pea, bm_pid, param->cpu_no);
> -		if (pe_fd < 0) {
> -			ret = -1;
> -			break;
> -		}
> +	while (current_mask) {
> +		snprintf(schemata, sizeof(schemata), "%lx", param->mask & ~current_mask);
> +		ret = write_schemata("", schemata, param->cpu_no, param->resctrl_val);
> +		if (ret)
> +			goto free_buf;
> +		snprintf(schemata, sizeof(schemata), "%lx", current_mask);
> +		ret = write_schemata(param->ctrlgrp, schemata, param->cpu_no, param->resctrl_val);
> +		if (ret)
> +			goto free_buf;
> +
> +		for (i = 0; i < NUM_OF_RUNS; i++) {
> +			mem_flush(buf, span);
> +			ret = fill_cache_read(buf, span, true);
> +			if (ret)
> +				goto free_buf;
> +
> +			pe_fd = perf_event_reset_enable(&pea, bm_pid, param->cpu_no);
> +			if (pe_fd < 0) {
> +				ret = -1;
> +				goto free_buf;
> +			}

It seems to me that the perf counters are reconfigured at every iteration.
Can it not just be configured once and then the counters just reset and
enabled at each iteration? I'd expect this additional work to impact
values measured.

>  
> -		if (run_fill_buf(span, memflush, operation, true)) {
> -			fprintf(stderr, "Error-running fill buffer\n");
> -			ret = -1;
> -			goto pe_close;
> -		}
> +			fill_cache_read(buf, span, true);
>  
> -		sleep(1);
> -		ret = perf_event_measure(pe_fd, &pe_read, param, bm_pid);
> -		if (ret)
> -			goto pe_close;
> +			ret = perf_event_measure(pe_fd, &pe_read, param, bm_pid);
> +			if (ret)
> +				goto pe_close;
>  
> -		close(pe_fd);
> +			close(pe_fd);
> +		}
> +		current_mask = next_mask(current_mask);
>  	}
>  
> +free_buf:
> +	free(buf);
> +
>  	return ret;
>  
>  pe_close:
>  	close(pe_fd);
> -	return ret;
> +	goto free_buf;
>  }
>  

Reinette
