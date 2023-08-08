Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F70774019
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 18:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjHHQ71 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 12:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjHHQ6G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 12:58:06 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7754EDA;
        Tue,  8 Aug 2023 08:42:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5yh/Y7Nq9iqplbTakJFrm7Swk5+KAQW/C+qLMCN53Bet3mCBoPFDZn5bThTzW46pi6j/hRReOBmoz6/1nCd2wTFE5F93cIYW1NQFlP26oFNaWEjMtwNQv6jVVf8sPWFCGucyOhVNKGldCVUiLzYdwKllqq/SuD4x0CgT+JUwtNOEJM7aW9cgLWhTv7btkca3KP3N8c2aOZinwR2DUkX/jxi/jSjg0oxxDURHf/25Eta74MnJZpvrB3Ogdp4KxSwv0YNJ2y4MAWq8/nv78TfWWBJ6JI6ETY40EswErkizRaMEVeJvjnp9BmZDG+qq/EwCiW9Slhs61E9xrsCCfOUeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1fC8DZLTuCRl4nSasLfysjQ0eY8xcxdb3h2/rUXBcI=;
 b=W53/8NvqXrp6CNXZjlige5pk0PHwd3PLgEx05/06VUMxlLrVZ9ZWirThFFB2Q2QqKG3wpMeCTlyC6pp1jZV7rKEZkgY6GNbAt1IYB0qgIQfNXjKDb16rh/obThMYBw5eiEh6Olqj8Y/azuSky08BVDXcxGaqBlRkWdrEudIQCsn0ZidZJ6bZMDQkubDF64R8BNK+XLSXKuRgIgXZXkmq1VeYMnBJBpc50ZTRs56sNBSmgFtNdQlXI3BrCkgMy6dCX2UFILUiBkdnWelAQh0oVXjgrBeAQoVqX48OvEZQ4SWD8z0omOvQNjjRZlL+PKpls7F31rZAuXqoNQiJguXkBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1fC8DZLTuCRl4nSasLfysjQ0eY8xcxdb3h2/rUXBcI=;
 b=XsHQnH2HGXxqiCktkdndJchdHrTjAIy5nrmT6G3W1z+rzhwJlOO/2OpZdlTxDJ0VtRibQOQoII+LZyjD5nds5vdWoV4Lzh051eS8oa8Ma1PhOErH2qdQjsjI33p7CyClc3AdYqtqE2AvIdEvr9cggvPjl+ZZldNdIQlJTJB5sdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB7580.namprd12.prod.outlook.com (2603:10b6:208:43b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 15:37:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 15:37:08 +0000
Message-ID: <631c5c8c-2a7a-41cb-85fa-6bdded27670e@amd.com>
Date:   Tue, 8 Aug 2023 10:37:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 6/6] Documentation: introduce AMD Pstate Preferrd Core
 mode kernel command line options
Content-Language: en-US
To:     Meng Li <li.meng@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-acpi@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>
References: <20230808081001.2215240-1-li.meng@amd.com>
 <20230808081001.2215240-7-li.meng@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230808081001.2215240-7-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR14CA0051.namprd14.prod.outlook.com
 (2603:10b6:5:18f::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB7580:EE_
X-MS-Office365-Filtering-Correlation-Id: 6167509b-e78f-494d-640f-08db9825531f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e3YjS8BpHP85/DsIjddo10ekR6nBvU9Fkzp4og83FW1Ieukc6iYbSFw3fJCkMgenv+141AYA/7IXatupSAsou2Q3B9oxwT0K+BezFdEfdBA1nvoZMpcMJt1fvik6z0iI6iA9FrTmfv/zpLSpq5US44EL8ql5r4/phX2kaadlI44l6UPSz4rPA9UyrXGLMfrzq4Ta4qlYPtE//OlNzCzsmRMYWCeZJVINAbKjUh8sgLTdFXmXOASTBq7hlQDHxqU05+fkyPIkzffngJB9YqcUXZumXmsY++SlFwM9O4bLIo4z1QVf1tGiq9DNqKtkI+pNqy+Ej4ZoPom9uG8oyvA1cwbSxAcjJmltm9rhskXcfLyE2ocYGhIhzO5N7nzOdf0kgY1cUPWC+vC5SMSlo1C47yUVgmloVY62wp6JBP+rEE7l68ZGv3RKlCtJKIL69alCBeLOVh+4eovxkGmp+sEMjQ1+AYgbANM5XPxPcD8rpNSk8qUR0mn6E3TPmXWXZ0+m8BW9VaWdeInXjBA3dH5QLicFt9k5BIaBbMDqSaWZB3OQPSsTCYhqyJRK3ABA2D82QWPZM4TIQmdqXQOz+uYkojBPPXiWP4htI52MWEnyN0kcmmOPYSbJx1V+sJXihSKn1anW49Vz2vfT+hsJNLIXQFvB9AfFEbkgSeTZXhUROBzLOgZb+qiyplGJQvJ4NXID
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(186006)(1800799003)(2616005)(36756003)(6512007)(4326008)(316002)(6636002)(478600001)(38100700002)(54906003)(110136005)(66946007)(86362001)(6486002)(66556008)(66476007)(31696002)(53546011)(6506007)(26005)(41300700001)(8936002)(8676002)(2906002)(83380400001)(5660300002)(44832011)(31686004)(45980500001)(43740500002)(14943795004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm1WcS96Tm93YkRmK0hmV3k4ZzRMWFNqSHB5OU9VbVR3NktsOUFVRkJuOXNU?=
 =?utf-8?B?OHRmZEowWEJWaEJRblg5d2RMdytvb1puNDZzU0lONWlWTlJaL0lndUQrUmFm?=
 =?utf-8?B?VjBhVDFtbENHb2t3RkxjKzhManVsWkZBbEt3ZEJ0ZGpRcGw4QTNHenQ4MHNl?=
 =?utf-8?B?ZEhrS1BiOGhkenlmQ3RtcUdjYUp3dm1KUG9hK1dhajBDQ0owWEk4UXZ0V2lk?=
 =?utf-8?B?VHRoVVlweVZkaCs5UEFaT1dKdzBwcmJ3NFp3OGV1WVN5NTBXOHBSbTQwdVQz?=
 =?utf-8?B?amc0RnI1TCtPaGNBUTFIV2N0YTg4UmtlNzhSSC9IdXB5eXdnWkxUL3QvTkNq?=
 =?utf-8?B?ZTlVdXY5MXZDdzNrWEJuenFRMTRQQ1ZVRzBtUFdJVEZLMnhNWTVIQjZ6UCtx?=
 =?utf-8?B?dE90UFJFYTlmM1k3ckRXR2Z1eDhyVGczMjFIZjd0L1dCTURFb1NieE5yWDNr?=
 =?utf-8?B?NTVQZ3A2WnNuTkZVMVlVRVM0b3FScHBWUm45SVdWQlBBcUdJQkFHQVpRdTEv?=
 =?utf-8?B?TEtVbzBlVHRRTVBjTUJnSTUxdVdBWWsycERTT2QrdStIdzJESHVhWDZqQ0Yr?=
 =?utf-8?B?OGtmZGFESSswa21HYXMwQjkzbDBvZWtGNnBLd0tWc21odHVFWHp0NUJBZFdi?=
 =?utf-8?B?b3RCSWV3cEdUYVJKT0swcmh5N1NHUkFOL2ltWUhET1hJSGcvNVZIVGtPcERr?=
 =?utf-8?B?dGhhREoySFh2azZYN24yR1FVR3VvVFdUQkErZ1o1b1lUeGhGd1ZOWnVEbUFn?=
 =?utf-8?B?VVRsVlRHZVhzZDV4ZUR3Wjd6b1BJbWpJMHVHTFhmZmphYUNIWU1UQWNVaEJ5?=
 =?utf-8?B?eFZKUFRHbk52SWplTDNBQVgxWDRSSnNRYXVheEJpVEc4MWcwYXZyWHI3R3pM?=
 =?utf-8?B?T0V1VkExSTdvaW1ZL3pFSkRvbEVKVm1pQkJpcDVPSERCNVAvbzRJZDRIcGNF?=
 =?utf-8?B?OS92M3kyejg4REhKS0dnZFRSbUhlczBjVDhFZldTWDVQcVV5ei9RUmMySTN2?=
 =?utf-8?B?MFB3d0l0NnRldzdvNGU4WG5oaHJHS2NlTGwwdGdGZjA3dzJrMkdrdkFSUFZB?=
 =?utf-8?B?MlRNME1UaGRqTXh2S0xud1J1MEI1TG1DZ3NJREFvRnhGK3NCMWZnUkJTa282?=
 =?utf-8?B?dm13b0xTcGhyKzAyMWlZQTRyZnRTaFBKdytIeXpsc2JNT0I4WUFLZmZqd3lo?=
 =?utf-8?B?RTBuRjVPdzNYRnVocldIU1V4eE5OdmFBcEp3YjByZHYxUTB0aFRnYzVuRUp0?=
 =?utf-8?B?Y2xHL1JrWGxXR09vei84a2xKZUVadmFrTGROR1lPVnFkMldwWWdTMCt5Um9W?=
 =?utf-8?B?aUt1bjJxWUk4bWZXbTZVSGcxd3lmWFpiRTZrNnp5ZktDS2w2VFBKNVgreFcr?=
 =?utf-8?B?TVRiQTYrNDRUcjVsSlZ4TEZBV1hUYzlPaXBDWWpidVZYRGEzclJUQzNweUJL?=
 =?utf-8?B?NHpRbmFHUWs4SjFXLzU1NjJhN0xpQ09xU25QdkVxeXpPc0J5YzNwd0FwRkgw?=
 =?utf-8?B?R3lOM2JiSVB2R0NhdENCM1JiUU0yV0hpUUFCTjUwNlBCVk03TUh1blV5bzZs?=
 =?utf-8?B?bGs0ZExlMEhnZHRBZVR2Y3IvMjdzR3N1dFB5TGZ2K3hoK1cvOHpyai9waWxV?=
 =?utf-8?B?dURqY3hYR0QvOWtIK1UwaEpPSXFyNXdCKzVOaDM2cEw3bWp2QzdqMnIrajN4?=
 =?utf-8?B?R3RwSWZ3cFlGQjJzbHNjUVVJcjN3bEpzMk5lRVlFRzlGRlNsdjZHMWpOS3dk?=
 =?utf-8?B?UjB0aTZ5SDIyemV6OVhEcmpZYkV2Z0N1K3duMWVaQk9nQStCYmNqTFhXVE9H?=
 =?utf-8?B?ZGtXdEFRZVl0Z2JTZ3ExdVh1d0VXdEk3Y1NuNTNhM245eHJQY1pCWVB4YnV6?=
 =?utf-8?B?dXB6ckF0UHd1b2xXSEExbzc0OUsvc1V4NG4yand1VDlyWFVCQWduZk00TXUy?=
 =?utf-8?B?S1VGbkFzZWlOSTdKbDRYRXovaVB3WElMYzFUazFENGNLdE5SR29maEliYUxD?=
 =?utf-8?B?NnB1WkFDbTNGbVIyK3RhTnEzb0hIbWcxVWp3NmJUYldJVTMyNUY2cVFjeUZI?=
 =?utf-8?B?YTU3RU94akd5MFNpbDcxSi9qNCtRWFZSa1ZURTh2cFExWUJ2TzhRSjdzTTlh?=
 =?utf-8?Q?JvTGyWslEbZxu/qBFUWRdlAmm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6167509b-e78f-494d-640f-08db9825531f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 15:37:08.2956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQ2jwEqXSoJ8XqDsBBWWDHtfTVW+RpOsjh6wlr4WQdpkV9C4H9URItQIpScGTzJO5BX+NuVS12NQ07YH+AXXcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7580
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/8/2023 03:10, Meng Li wrote:
> AMD Pstate driver support enable/disable Preferred core.
> Default disabled on platforms supporting AMD Preferred Core.

Why default disabled?

Shouldn't this default enabled and then let users decide they don't want 
to use it if it's causing a problem for them?

> Enable AMD Pstate Preferred Core with
> "amd_prefcore=enable" added to the kernel command line.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2de235d52fac..bc92e178431b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -363,6 +363,11 @@
>   			  selects a performance level in this range and appropriate
>   			  to the current workload.
>   
> +	amd_prefcore=
> +			[X86]
> +			enable
> +			  Enable AMD Pstate Preferred Core.
> +
>   	amijoy.map=	[HW,JOY] Amiga joystick support
>   			Map of devices attached to JOY0DAT and JOY1DAT
>   			Format: <a>,<b>

