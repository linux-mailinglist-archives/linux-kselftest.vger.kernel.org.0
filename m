Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7A17BF12B
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 05:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441862AbjJJDBj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 23:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379344AbjJJDBi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 23:01:38 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1679893;
        Mon,  9 Oct 2023 20:01:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXxIImbw1xsz/RHqjjqX6YTfu0U/aYo/CG4OluZJtLBRrrwhTVUQsRiANtr/+DQ+KOJDN8V0QgX2Tt8LT9tAN1eSdT8KRthQbUM+svn48Ss2KdWIbiRMjslAkb7i61tlCuSdQdJS022gfhCGrKrpdMlcEyi6bHZw7ZYP5WnjQ72tpj2IwzSRU5l8Wd/+sfjPqbCbH+1PGF8SSip0FKke7zPJLbv19VIMYajLUrXmgG1K1pirr9Ztbq0W3eSNfiptDC7hiheE7Nz+SUSbIl6lIPkkfh0/VkiDfO0vANLHcg7WS1itKq8On8NBC8/AROFFxAWG4gEN+LQ6+0lF56fiJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rP/hXxBV7bCDmW3pWuGpChFJbfVT4XqHO0ps8ptxoAc=;
 b=jD7WZ+LfVaMf18htUT9TcNUe5dZmzP4SBJeeuTucLF1zQcFOg3rNU+xpKxQPmlPzOogvCJSG+Zb9w8KTgI/tOKnnvDasbgF7OVtQaCA5QwgsCONmAip+16uA0oEPsBovaaJdkww5ZBM3b945aERTuKbPghm75ff0LJQin2P+ufcRCKmvgosmtMgaYJuFse+LozgwblWNn8s5wtJyYe5sn8G8XkKhPm1PMSS4tjDvXVdzCzfcyhTdp6w7+EfRyd6FwNzWC9OpIvGiijFaRTPIGvpB1QW5NOnP517u9M/p3OYOyPC+t/cUiaSQOKn5pf2CEJE4J2ApYMWzQE1cqTx3Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rP/hXxBV7bCDmW3pWuGpChFJbfVT4XqHO0ps8ptxoAc=;
 b=lTyY9qjWMZHEO8uPqCXCGZ7rFjB6pmi7vzPwgk7mqJ61Fx23u+pCrskJH4exLVXB6YC95FYYmmEP9ESOq1V4sp+6FRTLgo1BXRzRH73lUy0NlMO4pxqxMsS24Re6/Mk8EJRpnQsDPKpyuWdfRGYWoMRdURejLWbG+AmUbmUlPLY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 03:01:32 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::c3b:811:fd1d:c33e]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::c3b:811:fd1d:c33e%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 03:01:32 +0000
Date:   Tue, 10 Oct 2023 11:01:09 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Meng Li <li.meng@amd.com>
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
Subject: Re: [PATCH V8 0/7] amd-pstate preferred core
Message-ID: <ZSS+dZKdAGyTbCex@amd.com>
References: <20231009024932.2563622-1-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009024932.2563622-1-li.meng@amd.com>
X-ClientProxiedBy: SG2P153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096::19) To
 SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|SA0PR12MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a5cfa9-77a7-4f71-d901-08dbc93d3508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2l/5HqSXUk830Rhu2LcurVEn/xChZielfOdLccDszb5o04toE4OAcEZZlTc+OXcAiQAraSEeTLQdlDZ4ou8p68Lr15H9TB4K0kk/hTgmYehwsUPmDjsHbdrkPvV2Yjlx29qQZF+6f4zBcszGEHFB74ZAC9I8P+k253BXXqIN1kaRuM2y3pPPT+oTqg0OeeN+oWMor7LCOBWWMDmFwzcWimaUeC6wtNGfaqgx84TAcVLvrSQltGdGo9ICXyECzflKl6bdCPMulCz93RCp9JRbykSdBtlIztm9deV8tQQr+l1YkEwAC3998DOUI9JxiuVMUiOxC752F9xLhL+GwNefPmJg0Pj4qVwNsZeJZ955ej8L7Pl25n3LaX7xmUJUxZwLe4Xk/T9yFOqcAPLuWjVSKFMrgVySPARDntrai1K12/ZyxqlPuAY4TqJ40Q9w+NCNEslDV6oPa3paGUoq7KcklodK44fnu850x420T+OjUeIHk9L3LyWI6zTpvFkewKtPHNk29vnK7+b1SmqwlS0pPi1WA3wHgNkjcWztJEJTKAERgWAjE3/QcrM9BquM+IjOujNxP0GdEa3cQJerVHEKY4cfsRwqHHHI308RGcslhF0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(376002)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6636002)(2616005)(316002)(83380400001)(26005)(66946007)(66556008)(66476007)(54906003)(37006003)(41300700001)(6862004)(8676002)(4326008)(6666004)(6506007)(8936002)(478600001)(2906002)(6486002)(6512007)(5660300002)(36756003)(38100700002)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2NANINmLvcE8i5FAQeVpxV+2zdRKIoT/MVoLDeI697ZJ5CwhqK1LXbB+p24F?=
 =?us-ascii?Q?MjBomvLYz5eJ/Xr+k8nL7Yrc1Tl4SfvjVIcC8U6Ak71RMeMZrWvD3iJfYKAB?=
 =?us-ascii?Q?sb4JTyTdh1w5xeOrU0P2V7GAoGiJMsd4BPIOnwBZLCw1Uw8vC+rPqfP1YWFb?=
 =?us-ascii?Q?weBtFZ+QgzeSAFubd4aJkOOuGvyZZJQ0iCQqJF6Vax4P/NnL54AV9bEHQgo3?=
 =?us-ascii?Q?eGjeEMnIGU1tSH93qMt4ArWLYCs+A3CKR8OO2rOuOxK+IrexsOHrdmP7NnAZ?=
 =?us-ascii?Q?EsytyGn3b+yq/CWOyTcQ2KUpdJV3oEaHOq+PbLo0OJg050caPDhzWJWt+ihs?=
 =?us-ascii?Q?Fzgd0hyBTCHaXeDkKR8Zucsyw0H87faUDC42xF9CC0Ik1fqKGqNtwwjdh7xi?=
 =?us-ascii?Q?r2U3PHHbIGZVJ05e1lWBESgp80f48V7b5ZPNFWVplK5grFgyRn8Mhijo0q95?=
 =?us-ascii?Q?nxwjRDBPUTNjMp02NUW9mx0FE3XYrjv9Z0+S8XDoXJG7xUzj3FQ1l3xoMycT?=
 =?us-ascii?Q?0ibOm7yBNrcC5i9UT20fr7mBSpLD0oBtdd4KuFKD217tWe+unIH2lgSFPtp4?=
 =?us-ascii?Q?HhH4IEPkDHd/E7ZBqMfWGv9eJz47cAkWbwf7doZrq7i7BfdJpWCKrnQPSnt1?=
 =?us-ascii?Q?/h9zSydA8fy+AKw0TGQuYeLTB5nHEQ2qjIZ/F3YrSLipGUAQbrLlCMhF2nI9?=
 =?us-ascii?Q?Tup3490ppjdXon5hGM+wBRV7zK2dXDf84dO5WbxzAypOj1jXb3kOBioHtLys?=
 =?us-ascii?Q?M+p8+shyScOjP1eotuHggSsQvKhLJuw89I47HvM4B9r9t4y6NZ3TD7mUibbV?=
 =?us-ascii?Q?ZnkZkskHycEZgkoAI4Pu6RIICWTdQ1XfKFFe8TT89EJUgT495a1pwO6qniWo?=
 =?us-ascii?Q?LzD+3b5LCgRR+h/pjO7P2f9wK2TxML9tlDclr1S4MdyoQnzGQDpVTP6RcJXR?=
 =?us-ascii?Q?6oH7r3ZO8bgrlP5eUIIPy7yMHsiRNIRp8yQOGBxPFq7czxtOUiIkeWo83R8h?=
 =?us-ascii?Q?T0k234yJ33dEDZh3arbd1rKtuTcLuxzL9L5K0dFH+dQuUsbuffwPw55jyefj?=
 =?us-ascii?Q?GNxQj+IBpVQfLmQNcAY9CEEqFzCa4ut0l4IFdX1bO/vlSSjjnHubL69MZPfz?=
 =?us-ascii?Q?ax8UmwlRECNDep35yw1Hvxr1hUlcj68Ba421YIOiuZVlByUZib9FGoVQ/n/a?=
 =?us-ascii?Q?+jTAQVCA1eoOy5pTeXbSfp778/Tm8zJLIRoqiLnHJiqV4o5UqSAj23JogQo7?=
 =?us-ascii?Q?WcqanxtZ/8xXbxNCJP9nUzTWn2ZQ0MiB24Yyy5ZDOQNkx8YdsupHvQ92Jirn?=
 =?us-ascii?Q?u5U1Sh7ieUPbrcWVNP1AhnQCn/YP/CVvtqn0v8zJ8Gm8YeXAz9Q3hM+yLaCm?=
 =?us-ascii?Q?sOVLf8UZzNKO+xBLfn+zl026rA9BzcR3MUE30bj4imltCtsZRuthXYvJg1jm?=
 =?us-ascii?Q?uHnWoYTtDeNvKQj5gsWabBuZdZxV4jOzBBy3OE7z5FasxeweThcjQgsjvHsN?=
 =?us-ascii?Q?QcFXwBDd+DaK7IrXSaRXhvALknXFZXIUXE8XnGmC2X6djOHDv14qe8yPwa2d?=
 =?us-ascii?Q?YMlLYa0u851GYzNJnFErD2zU5MoSkFt7ewNjpwdF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a5cfa9-77a7-4f71-d901-08dbc93d3508
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 03:01:32.4466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzW7lFjUsGRFH1RjhkIVRTxu/29KR0WDWihlJ0LYzhwSitx2TCToyomIBWePQUaaYaskehQuQ50vcQxm0wSn7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 09, 2023 at 10:49:25AM +0800, Meng Li wrote:
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
> Changes form V7->V8:
> - all:
> - - pick up Review-By flag added by Mario and Ray.
> - cpufreq: amd-pstate:
> - - use hw_prefcore embeds into cpudata structure.
> - - delete preferred core init from cpu online/off.

Thanks!

Series are Reviewed-by: Huang Rui <ray.huang@amd.com>

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
>  Documentation/admin-guide/pm/amd-pstate.rst   |  59 +++++-
>  arch/x86/Kconfig                              |   5 +-
>  drivers/acpi/cppc_acpi.c                      |  13 ++
>  drivers/acpi/processor_driver.c               |   6 +
>  drivers/cpufreq/amd-pstate.c                  | 186 ++++++++++++++++--
>  drivers/cpufreq/cpufreq.c                     |  13 ++
>  include/acpi/cppc_acpi.h                      |   5 +
>  include/linux/amd-pstate.h                    |  10 +
>  include/linux/cpufreq.h                       |   5 +
>  10 files changed, 285 insertions(+), 22 deletions(-)
> 
> -- 
> 2.34.1
> 
