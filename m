Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0381B78BFE8
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 10:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbjH2IIy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 04:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjH2IIY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 04:08:24 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A089BF;
        Tue, 29 Aug 2023 01:08:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KltUgCmfjJEarCImZn3du6JO9TzWdjxn2bsg7IigrMYvDz9m8OjR1uZFJUo4T2N05wGwTOXp4KOmgQecUnEgeWJw2U7FjKw8PD+Av7d/Rfrxwb95vtzGr02pNKxEbi8YMpQa/q+av7enPpdsn1BYhHt7xpIRRIMr2ZQDp9a88novKpCMveFc5X+0Xtc6dyfh6CCa8sk+bV3i0OgcnJdRMMcmlHYYnRFPsp868wu3Yn62gqwVnXT6BoBWQYj1sGm2Nu9UL4FhB0lv363j0+/p1+DdVp/24VmR3Nk9FVKX6aZdfaTYXruWif/yWq6mPMb/aoDHf82cGnVPXKaHd6YIYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oB0TdLTgOEIjEEiApRqdMo2GkOhICc6QrTNqzMzlvgU=;
 b=GQXxD/UFOtmPBPS//o5+GMl83XAxXmzNJmiDUOK7a0U6om8ZUsITnPC8gzhyd44osrV1PC4/izLqJStiUK0M+2OPXwf6/eCJ8Pedt4saOXDe8qH+f1KX/S6SYwtr0Ew0JJm269iiU0lwAqG2QK6Djq4wZ1dgu8zhCKMbk40608/fu4KRZ6Dsgg6xNb62LcKvww24/v5i027RTSfc6h9/TmoNtAepFQSWTVdAXwGf4U2DZ9yoG71TCpel8QQioDk9TLjCIFcvnxS+aSAUqaf/l/+9vRc1mL8z2uBmxErnVsXQM0TJ8hYR7HSSI6pJzrNxMEpRunz/EB8VsWXJzzJITQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oB0TdLTgOEIjEEiApRqdMo2GkOhICc6QrTNqzMzlvgU=;
 b=gsqCNzslEscmXXF8NHfSOkVvbVHOpVniSf+SeUxtXAg9iDTTgD2rh54gdtmIBQvvmqnJPOU0dSWAeOkCHNAwc01DzKI33agmeA2ywO8yJJ1ecGr+6b58QMYVJxQiMwMH1VLf2Ii598rfjSP/LwtfCBLcwV/cnrjeX5bqF6u5wSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by BY5PR12MB4920.namprd12.prod.outlook.com (2603:10b6:a03:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 08:08:18 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::da13:5f6:45:fa40]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::da13:5f6:45:fa40%4]) with mapi id 15.20.6699.027; Tue, 29 Aug 2023
 08:08:18 +0000
Date:   Tue, 29 Aug 2023 16:07:52 +0800
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
Subject: Re: [PATCH V4 6/7] Documentation: amd-pstate: introduce AMD Pstate
 Preferred Core
Message-ID: <ZO2nWDqXZR/qGBO1@amd.com>
References: <20230829064340.1136448-1-li.meng@amd.com>
 <20230829064340.1136448-7-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829064340.1136448-7-li.meng@amd.com>
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|BY5PR12MB4920:EE_
X-MS-Office365-Filtering-Correlation-Id: ff605495-1bbd-4f4d-20bb-08dba8671a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nNMK6K7oN233psmxp6h3x1hj62tGrmzATrb6C/mQCb3RCODIfYGJuF5vJk1n0ZjByJnISECcfdTcHQcrNnDB2GiqCagdWjiVr0+TIF1oxlBcIfjMFbvWL80gf2EyIFkW/ny90gyw3bZKT84kQ80drHbGAxshOjEk8uASTwmUr7qwWr2bF6+me3eMHwRkZI4ytJ53XP4Opb9OOETsMnblCvF3tJwtJlUcS7HVa1V91dO/wzSCdAYAo4QYPl+3ahzXh49YAVnfJR6dOhHDRCSILp7k0vDXJtk7JOSKBvUmczS7zWZ1cSb9NMcQBW02mcKP3U7zISzXE5hHTwKNQxGrFyOkGlYHbKpWJxiNeqUTK74ifBXvZSgUEUcuRcWbZaO52FLgxtJZrn871Ncp0iZR9Y/YqL0EosNOmA4aR6G5mVdyv/L/OBdHsQo18I1PHzAOVXsC/XMxh8iprYW7JYS0qLRQqr82ckq7R4Nnc3CdoVkKpRhO6IlauurAPLLFYY77DUQC0Yj+pS857+ypPwJk8wdrKvi3UPW63+0+R064xv9iCsiUxi/97kwlrC8URfYx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(376002)(136003)(1800799009)(451199024)(186009)(6512007)(38100700002)(316002)(37006003)(6636002)(41300700001)(4326008)(6862004)(2906002)(83380400001)(86362001)(2616005)(36756003)(26005)(5660300002)(8676002)(8936002)(6666004)(6506007)(6486002)(66556008)(66476007)(54906003)(66946007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ugIDJq/ltP8yQgHlRD+2V5AFiWb9zaV8/lw1k851lYqaY+P5RtHZV58O0KSI?=
 =?us-ascii?Q?i4+s5oylUV+gqd8I0BDkwtz+i6pUduNZ26tDgwDNQvdKnDtctYZlp0ZqcEAm?=
 =?us-ascii?Q?5PV61QymeS1E9mfmhP5CWB2CF+OPGvpE6VgQY9hfk9Uxi07t07yAUjnMIhAr?=
 =?us-ascii?Q?MZb1zU4KI7t1Xu6AzB3PEhucdkAR5ke3M8RqF5YAgUn8xYIkE7jKuJ0pIPsJ?=
 =?us-ascii?Q?WcCkrPJwsouC+aq1k2RNX1NqWE8fyWwvl0hrsumLw0xHYDTo0fyfJf80w/xs?=
 =?us-ascii?Q?BWatfD1WnvD7mxnetzQZgCM7rN7Oa/KaBhjR+pLm5KnZbHd5DovEccCD3a9K?=
 =?us-ascii?Q?Zer0ILsjCPjmDQUWcdvwC5fKn6L+x3JZDgPPRtswXt0rar2SLzyCJZtPxtmq?=
 =?us-ascii?Q?7tBWy5Dp13dqI4bHGcXtgTxafVrdjv5D0kgLRMNqo87eN4IXUi1WQzZGbigy?=
 =?us-ascii?Q?WZIzSa7CNFRwF6yjfiy97EGYTdNvyI54O+VD52Pnhs+G05UEkWTYRF7yU2NR?=
 =?us-ascii?Q?uOPp2ummCjAOcQ5GJFMepcCtlYzFFA0E+ZRhgpAJlURKjWIOW5lWKuKMmVsf?=
 =?us-ascii?Q?JcgbA3YFicThsZUvceAl6CAgnIDMgeWopZsVB5Q+verb44EHOW0HXHsAJsCR?=
 =?us-ascii?Q?5WxVncHDuANraAJ7AYC7oG1WalmoWaMc0J1qLn5vjQkF+oRNBD3ng6Txazmd?=
 =?us-ascii?Q?Og3cxtzdetwJ5VyMkmusOfWTZ+7YCuS2p3tPKztYTCR8VH4cR7x+XOMPmyR+?=
 =?us-ascii?Q?qfembwLAegDEYUkoV1/ftr0N1k6o+kDE6o6Rc9XqlIH/iuRfSpxt6jSKvTFs?=
 =?us-ascii?Q?EFanyeY8gvKvu4BC0/RAyTJuekWxwM+gZAOgQuuzRgG4VDfStYBmtPTh6JTf?=
 =?us-ascii?Q?qlksRSC/FaSC+flWbg3p7lBppr+TjI2wx5bOmoz9h94aomz2j/qUT1uOCpNq?=
 =?us-ascii?Q?GF6Bkg25ad1ybB2yD1G1mKbjvnHQqB76gdencc5YrnAwgphd7L/geZ1o2lbU?=
 =?us-ascii?Q?mgGETU8AUC32YPRiEVwNiXnpyYPKktcEaDZ7MqorRVjZoDhmCrDilGH/DgjA?=
 =?us-ascii?Q?UcwGSkpXeY+7NSFRCmKXYhkYHyT+Oih5ROFpea9N65loCcb5aC/uJMVXMDs9?=
 =?us-ascii?Q?Chx+G7hBFEtBaMNgS8vntkZ5Au4cMB8Wm4QgL4iq/UYBUfURaaHp6XIvRnjj?=
 =?us-ascii?Q?MM3yMagrH6PyABvCTWOk7WohO0DEeM2OkKfde5/a4vceIVtTn6FMWRcfu0BW?=
 =?us-ascii?Q?yLAb0rMH8w1IOv+CspYVCObUHaejukuzE76QaL5VpTqTD/LzJDzIB2sxcLue?=
 =?us-ascii?Q?7XNsQ+wI7e+Pq/EUVVRRL6ln7rXTJ/ki6LdDcQnURgz5/oBLJLODpUk9auEq?=
 =?us-ascii?Q?zNpoSeT4vX1c9hMBxo4ZID2mEvTueN3RUe6gc4F/vfMWcdJZ055oS4k+VslH?=
 =?us-ascii?Q?YxHaWBEPlnYuYTcfXKxCoxHUBTxFzCDMKdg0Gs4+0x4nA9eeg+85Z0wzL2iN?=
 =?us-ascii?Q?ygog5RvGZWsCWWuDDL3hUSsskzrNxK6lLNUw36fZ9St+pSvgLx6ApFsaj73O?=
 =?us-ascii?Q?2QXEM0Tq2cEGkSOIxIsSWc8JoZY4+8Ub7RFK8Y+R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff605495-1bbd-4f4d-20bb-08dba8671a59
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 08:08:18.2000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/sdNos7/i5IsKvFsyLKED7NHCxl4Cq5N9DAae9mGnnGE4zdEp9+nO3TO2U80Umwp3EVq6XsJaAni6S40xhFiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4920
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 29, 2023 at 02:43:39PM +0800, Meng, Li (Jassmine) wrote:
> Introduce AMD Pstate Preferred Core.
> 
> check preferred core state:
> $ cat /sys/devices/system/cpu/amd-pstate/prefcore
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 54 +++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 1cf40f69278c..400264d52007 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -353,6 +353,48 @@ is activated.  In this mode, driver requests minimum and maximum performance
>  level and the platform autonomously selects a performance level in this range
>  and appropriate to the current workload.
>  
> +AMD Pstate Preferred Core
> +=================================
> +
> +The core frequency is subjected to the process variation in semiconductors.
> +Not all cores are able to reach the maximum frequency respecting the
> +infrastructure limits. Consequently, AMD has redefined the concept of
> +maximum frequency of a part. This means that a fraction of cores can reach
> +maximum frequency. To find the best process scheduling policy for a given
> +scenario, OS needs to know the core ordering informed by the platform through
> +highest performance capability register of the CPPC interface.
> +
> +``AMD Pstate Preferred Core`` enables the scheduler to prefer scheduling on
> +cores that can achieve a higher frequency with lower voltage. The preferred
> +core rankings can dynamically change based on the workload, platform conditions,
> +thermals and ageing.
> +
> +The priority metric will be initialized by the AMD Pstate driver. The AMD Pstate

Please align with ``amd-pstate`` in the whole documentation.

> +driver will also determine whether or not ``AMD Pstate Preferred Core`` is
> +supported by the platform.
> +
> +AMD Pstate driver will provide an initial core ordering when the system boots.

The same here.

> +The platform uses the CPPC interfaces to communicate the core ranking to the
> +operating system and scheduler to make sure that OS is choosing the cores
> +with highest performance firstly for scheduling the process. When AMD Pstate
> +driver receives a message with the highest performance change, it will
> +update the core ranking and set the cpu's priority.
> +
> +AMD Preferred Core Switch
> +=================================
> +Kernel Parameters
> +-----------------
> +
> +``AMD Pstate Preferred Core`` has two states: enable and disable.
> +Enable/disable states can be chosen by different kernel parameters.
> +Default enable ``AMD Pstate Preferred Core``.
> +
> +``amd_prefcore=disable``
> +
> +for systems that support ``AMD Pstate Preferred Core``, the core rankings will
> +always be advertised by the platform. But OS can choose to ignore that via the
> +kernel parameter ``amd_prefcore=disable``.

As the comment in previos patch, we would better to let developers know how
to detect this function in the hardware.

Thanks,
Ray

> +
>  User Space Interface in ``sysfs`` - General
>  ===========================================
>  
> @@ -385,6 +427,18 @@ control its functionality at the system level.  They are located in the
>          to the operation mode represented by that string - or to be
>          unregistered in the "disable" case.
>  
> +``prefcore``
> +	Preferred Core state of the driver: "enabled" or "disabled".
> +
> +	"enabled"
> +		Enable the AMD Preferred Core.
> +
> +	"disabled"
> +		Disable the AMD Preferred Core
> +
> +
> +        This attribute is read-only to check the state of Preferred Core.
> +
>  ``cpupower`` tool support for ``amd-pstate``
>  ===============================================
>  
> -- 
> 2.34.1
> 
