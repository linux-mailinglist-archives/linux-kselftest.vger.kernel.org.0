Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124067A70B8
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 04:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjITCvY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 22:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjITCvX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 22:51:23 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A0499;
        Tue, 19 Sep 2023 19:51:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6DH7swfciu15qhzvDs5a3JM6IQJPx7lnSNjjZwqso755gwgIYFHiCxGafOJO7hoE1li7KH7uaeJ7jDEjjs0N7ep7Q6hO1J8NyYOWjcZ8BumXxmdzfPxnWmJeYWFavvuteOYW171DMX+oANVwJ7oL0hEsy3vpPZ4+V7jMsVUvfl7WJcA7Swrcfi2OPYvYUNW5zel3EBt/dV97mn1aL/Af6oAs7EsMgcd6Cd0mD3w6k6Kb+tQu8teSUNVDC16wPNYlknm/E37nDWe8LJDSY1F4Yd/C4nHPnLEG/alSusyLkrF3ule2xqsnwbb7/zkGijw3+JciFZPPidlDPLtl2BEIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQG6iKWgClvTcP8ze8L0GYNhdVz+5Y11TSTkzhE8th4=;
 b=KzH5+6b41e1YvAJUGqwYYlY4S2htaLrLxT8veAA3SfMqCx0rDBUZwnftZI7Ob+INo3WcBnrVPfx5H4JITuHvCprAMcXirdTrB29XAlrIeoDZhT5z2VtaKqHfo4B6fd0cq/1EpLHigUeokoieSI97fzWEH29B5asT2nWmFIugN0JkNw1pN8DtvNtR31PE0kEYBz1vK7pVTRvxjNTiDVutJgdjpnfNYJ1mf6N/16Mtz0/TvW7r7ncFm0/TEQDHkgGSzdtnH3XNujL7Cij/bYw8adDeLcrfV0Ioluj5SrFRteZEMATy7PL5LhX0+XNxgRK35tkcomfFuknwZ4nAGuI9ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQG6iKWgClvTcP8ze8L0GYNhdVz+5Y11TSTkzhE8th4=;
 b=C7wJLFlFiuKS6eo34dbGlha3FiKcXBIrk8q1gv1Go88Oy89R7kWMkkRggMv0udQp6w3zWG0+kNQcPwEOWEMHTcKVC9sYMsE2eQdxXn+9LuLZPsxkVqJ5UYjCe1gT9kc4MEP5eAb4AA4TzPUrME6TIu9p/RoR1tzT+DCquwl28+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by BN9PR12MB5242.namprd12.prod.outlook.com (2603:10b6:408:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 02:51:14 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::c3b:811:fd1d:c33e]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::c3b:811:fd1d:c33e%6]) with mapi id 15.20.6792.021; Wed, 20 Sep 2023
 02:51:13 +0000
Date:   Wed, 20 Sep 2023 10:50:47 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH V7 0/7] amd-pstate preferred core
Message-ID: <ZQpeByJeE9ygy2bd@amd.com>
References: <20230918081407.756858-1-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918081407.756858-1-li.meng@amd.com>
X-ClientProxiedBy: SGBP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::34)
 To SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|BN9PR12MB5242:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad5150f-fb31-418c-7963-08dbb98473f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y13CPyWMrzi6LCWlzXQu2Lz7fX9lwzIEpTd1a+2ZKLbp8uFyRc+hFGr+MH6BOhYxfWXerhN8AO7fysn8bmRtX6mvD55zxVC/p+NHcxkKnZ/bSi1KYszXIwx3OZr6nQvJLfUvSS9OOZfc+CfT5x1Q2CXU1Xdai8nLHoGdZ1M1hrPFDNDfWAFu4yhfI5qtApoBmrdbkVWatjYUbShYyU14UAe9Az2PA1bUUkJlaS/P2utHoJbEtg64C3FYQ14+3HrOd7d1yFahA/anB2CzD7majRH/NR+AgsbQefuzOTTbhXwKJcoypcymLqE2Ny+HudyvCbMLw06G4n5qZrdRbGRf5+SE2nqpUt+wVbSnZTYRr2duznbUugv2lAHuh2+QGB+R5PGQJd0ygA1whkLUxoFa4v5+Zw8L9sBep5jkMcAtVlhZHb3X7x0RaEychAlr5DhSW1F8a3EqNJP58X24UBUzb80b0gPUN2rsN6J5NK5NqX+lEyb+OQjzQki0IZTd4hZ+c8jaer9z0orl4g9ImYlWJLsHVO4+vXBB9STD1nWwVAMIe81katvSRWoxvuYns4M8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199024)(186009)(1800799009)(6506007)(6486002)(6666004)(478600001)(36756003)(38100700002)(86362001)(2616005)(26005)(5660300002)(6512007)(83380400001)(8936002)(8676002)(6862004)(41300700001)(66556008)(4326008)(37006003)(6636002)(66476007)(54906003)(316002)(66946007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JTSEI0qaBibyLrorghjm5QYlkTHigsgjeyjBkMuVulH6utEQS1qps8FX58uR?=
 =?us-ascii?Q?jRWBw2/LPTSiFxddq8D66b7X7/MSsd5sChdc1RKXRSUEfrLo6MFA57K0E9Dp?=
 =?us-ascii?Q?fsxfO4Ym2H0vIVOGsJyzjOSiWGkdBtQl9o4XIQtmwYpiDTRtLoJKQWdcuMwc?=
 =?us-ascii?Q?VzHK5nwHka2fDwn37zXw4AB/CLa16UmJ/ZwjkdGM2AiMI//Ims1y0+hEKkaB?=
 =?us-ascii?Q?4UwsrT5icmf62ilF15ArF6ulan9tHD30+4uSlDcQuXxftUj9VtHQR9kaWq0V?=
 =?us-ascii?Q?tiubgkAQm1wDCOZcQybRwmzg5mtXzwxgdKeycmg/zHhWrCq8B5F2hv9+X04P?=
 =?us-ascii?Q?X6Qeb+mtq+PR0uXQIWXAqCh7Olbr+SRLSrnSbRxg23thb4WHr5Xlw1ZYn1b2?=
 =?us-ascii?Q?sLfV3YQS1x9iFq78cKsUeQDUGPsufrT/8oxuOB8N8pvO/XHcfiDItkfUL9Fm?=
 =?us-ascii?Q?0AoWT7bHGwhihhhjWarrtu0nTvkMPZB2JatUX315ptXgZMqCWYjsQ+mFcrHJ?=
 =?us-ascii?Q?hPs4S5Lqwwe4j3EA6fPvPTG/89bvgLy97DC5zAPrJ+wCZZwmJXb7z4GpqNtm?=
 =?us-ascii?Q?Om1t2xCdTCE6bU9/51oq9LEJf+LQ+3ivd7AqHyZtve/YOUEJaffUzqvmtvqb?=
 =?us-ascii?Q?+sPchwz5PpoA0jBsP5lXEv90BpLErvwXg15uJDkLlobtKaDWC4jSoo5AKooz?=
 =?us-ascii?Q?hfZfYrRii8cjjqLGYp9PVchpPk7jz1eCIrL/5WHK3sJN2NA0Hw70BQUiCMr5?=
 =?us-ascii?Q?E8i4rJCA5eHJBkpRJwHsyj8y+JcQrTupopky3cO/E/h08tmX6g1pA+E23Au6?=
 =?us-ascii?Q?F8W7/SgCuZvpKbuaMtmgBp/xhKqIMVg8T7FaN/3DSZdffADqLcw8hNHm2NcF?=
 =?us-ascii?Q?fUVo8cJV5MJe+9HEWjb+BU+QeZpmnD3swgwVj/wRcFKOIC4k1giNVhDFS3p5?=
 =?us-ascii?Q?SeL/FZsoUCG+xBQ/ac5rOsv5LiKeR4Sv1hh/przaiOiQzJf2CQrfc2JqXRZk?=
 =?us-ascii?Q?w7Dkzxa7TYJY5mx9Umxq2Qtw78PIwmLSqmLCzRNK13RxuIgJsgq8yQGFExIs?=
 =?us-ascii?Q?1fr9zoUusF72hp/ZM+S2R45kvAED2vwyXANmh1ApBckstbQ7GP5CcYDHyQQO?=
 =?us-ascii?Q?aylZ3WJ2duzdVET6jqB3XWEafDUmD+oYMikLRv/Z9Jmo5ZAbBH9VB5m+0v18?=
 =?us-ascii?Q?vRINK5ZzN5HoodpkWHbCvOv+LuId3+x15kRTZLh+AxUEhJxf+m7/5UAiHE1M?=
 =?us-ascii?Q?srk84FX67FdZFLndRBztQ9ksIleRsjTZ0PW27UJqrbGAUK0CF9mN3M4MrBHL?=
 =?us-ascii?Q?ZxiRMEtSb9qigfqz8UwUwW3uNQUEjzqt29QXnHiNX6I+iFb5FfDCQEz+/c32?=
 =?us-ascii?Q?7+DN0o1H/k2hwDXDfcmFV/rkUGdLHagDXD05DOQ3qXeFb2Z2OEiujH5tdBad?=
 =?us-ascii?Q?IuHCuSM3xpavfJxQ5H0IT25CvdxEJcEHaUv2C1Zi5VFW4nVqVmnmyRCXubJI?=
 =?us-ascii?Q?NyYyW5Wx3PRn7aGWzIV67BNVO1rVKK+uGVbB340U2Ac7SpTout+lqW6wTWhL?=
 =?us-ascii?Q?lMB1PoBKrHN89sMvsdLwrdIDWTZYzSXPypKY9KOO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad5150f-fb31-418c-7963-08dbb98473f7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 02:51:13.7433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEPdOUKArrBY4UWehoGvg/BeNcPAfkmNFhfJ/kKPTBloqKrcrn9oe6nkBr/azRL6JaN8U4Zok95ts0NC3FVPKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5242
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 18, 2023 at 04:14:00PM +0800, Meng, Li (Jassmine) wrote:
> Hi all:
> 
> The core frequency is subjected to the process variation in semiconductors.
> Not all cores are able to reach the maximum frequency respecting the
> infrastructure limits. Consequently, AMD has redefined the concept of
> maximum frequency of a part. This means that a fraction of cores can reach
> maximum frequency. To find the best process scheduling policy for a given
> scenario, OS needs to know the core ordering informed by the platform through
> highest performance capability register of the CPPC interface.
> 
> Earlier implementations of amd-pstate preferred core only support a static
> core ranking and targeted performance. Now it has the ability to dynamically
> change the preferred core based on the workload and platform conditions and
> accounting for thermals and aging.
> 
> Amd-pstate driver utilizes the functions and data structures provided by
> the ITMT architecture to enable the scheduler to favor scheduling on cores
> which can be get a higher frequency with lower voltage.
> We call it amd-pstate preferred core.
> 
> Here sched_set_itmt_core_prio() is called to set priorities and
> sched_set_itmt_support() is called to enable ITMT feature.
> Amd-pstate driver uses the highest performance value to indicate
> the priority of CPU. The higher value has a higher priority.
> 
> Amd-pstate driver will provide an initial core ordering at boot time.
> It relies on the CPPC interface to communicate the core ranking to the
> operating system and scheduler to make sure that OS is choosing the cores
> with highest performance firstly for scheduling the process. When amd-pstate
> driver receives a message with the highest performance change, it will
> update the core ranking.
> 
> Changes form V6->V7:
> - x86:
> - - Modify kconfig about X86_AMD_PSTATE.
> - cpufreq: amd-pstate:
> - - modify incorrect comments about scheduler_work().
> - - convert highest_perf data type.
> - - modify preferred core init when cpu init and online.
> - acpi: cppc:
> - - modify link of CPPC highest performance.
> - cpufreq:
> - - modify link of CPPC highest performance changed.
> 
> Changes form V5->V6:
> - cpufreq: amd-pstate:
> - - modify the wrong tag order.
> - - modify warning about hw_prefcore sysfs attribute.
> - - delete duplicate comments.
> - - modify the variable name cppc_highest_perf to prefcore_ranking.
> - - modify judgment conditions for setting highest_perf.
> - - modify sysfs attribute for CPPC highest perf to pr_debug message.
> - Documentation: amd-pstate:
> - - modify warning: title underline too short.

Apart from the comment in patch 3, others look good for me.

Please feel free to add my RB in other patches:

Reviewed-by: Huang Rui <ray.huang@amd.com>

> 
> Changes form V4->V5:
> - cpufreq: amd-pstate:
> - - modify sysfs attribute for CPPC highest perf.
> - - modify warning about comments
> - - rebase linux-next
> - cpufreq: 
> - - Moidfy warning about function declarations.
> - Documentation: amd-pstate:
> - - align with ``amd-pstat``
> 
> Changes form V3->V4:
> - Documentation: amd-pstate:
> - - Modify inappropriate descriptions.
> 
> Changes form V2->V3:
> - x86:
> - - Modify kconfig and description.
> - cpufreq: amd-pstate: 
> - - Add Co-developed-by tag in commit message.
> - cpufreq:
> - - Modify commit message.
> - Documentation: amd-pstate:
> - - Modify inappropriate descriptions.
> 
> Changes form V1->V2:
> - acpi: cppc:
> - - Add reference link.
> - cpufreq:
> - - Moidfy link error.
> - cpufreq: amd-pstate: 
> - - Init the priorities of all online CPUs
> - - Use a single variable to represent the status of preferred core.
> - Documentation:
> - - Default enabled preferred core.
> - Documentation: amd-pstate: 
> - - Modify inappropriate descriptions.
> - - Default enabled preferred core.
> - - Use a single variable to represent the status of preferred core.
> 
> Meng Li (7):
>   x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion.
>   acpi: cppc: Add get the highest performance cppc control
>   cpufreq: amd-pstate: Enable amd-pstate preferred core supporting.
>   cpufreq: Add a notification message that the highest perf has changed
>   cpufreq: amd-pstate: Update amd-pstate preferred core ranking
>     dynamically
>   Documentation: amd-pstate: introduce amd-pstate preferred core
>   Documentation: introduce amd-pstate preferrd core mode kernel command
>     line options
> 
>  .../admin-guide/kernel-parameters.txt         |   5 +
>  Documentation/admin-guide/pm/amd-pstate.rst   |  58 +++++-
>  arch/x86/Kconfig                              |   5 +-
>  drivers/acpi/cppc_acpi.c                      |  13 ++
>  drivers/acpi/processor_driver.c               |   6 +
>  drivers/cpufreq/amd-pstate.c                  | 197 ++++++++++++++++--
>  drivers/cpufreq/cpufreq.c                     |  13 ++
>  include/acpi/cppc_acpi.h                      |   5 +
>  include/linux/amd-pstate.h                    |   6 +
>  include/linux/cpufreq.h                       |   5 +
>  10 files changed, 291 insertions(+), 22 deletions(-)
> 
> -- 
> 2.34.1
> 
