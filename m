Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3BC793D71
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 15:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241117AbjIFNJq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 09:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbjIFNJp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 09:09:45 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6C7171F;
        Wed,  6 Sep 2023 06:09:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpFf6ciOqwFVrTe1zp1lqztNemZIVbrjcgdWJKrFw19sTWcqhXHlstFEuSSAwZ0LaO8uyECfioCwU0rClgMUQ5Z8TXA1/FKeBDrMSWMb28xzulTW+CN2JRa5luzkcGJ0yBfKdiJ210TsaIxkbuY+E4NgJzKM7TTR/mQgyxy5VfbiEKQvB+CtcAYpBhbrSBaziXWKp8Ptb4g3uZ5gIh3ymoKnrOq+Tpm/+lf2e6ehKW3w+oWHs0Wqge6keO0gGrAyrqZgCh/McRqXxb7Sfste0vpLmhniVU+bDHMmoY8R/roNBt/LLGUA4XtXGjytPaUBl14aATvU92a/c2zuKdqbsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7v2eo49vRVmpwgCX2GwXh5xQ6bgSGwOyk/NBikaCi4=;
 b=gC3RVP1fUEv0p0AeyGATUDYh9G/LoRXPcTc5vsbGCj1YPSR4IpKKKRqCgen8JK0NK9hLabqF965eKxkRXdAFkJkO+n44POp30TPLUkpnZBNQ+xbTpjOHC3HRtQmG5M+aB4C493P+FkC8s/Mm9YzQsPMKggfCNItmEfgwme7FcUKFYvyXXJM9qoBtDBDWcDclC9x+3Ls6Si4nJta25YezRijoW8f0zbA3x0YZQQgFaA4iBKt20w1P3cfMvsd4Y7ppBpDyxs1KMjhxrqc3RDUjIQfkllsbCJ5UY7W8UZbgslfCsizo+7cRArt8QRdHNJFrTuYfE0rwPaN1VZIRxEkIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7v2eo49vRVmpwgCX2GwXh5xQ6bgSGwOyk/NBikaCi4=;
 b=ahfFzC6RohiPJx2NQ37aQjSMrEnfS1FgMIoPybZYB7j9wU8dUCClaTd2sSV4D80BZxEyAMLr9ymbpMoFLuPaWK8/Ch5nwA6cfoskVaG7QOBLrIVKYI43neOjwvf362S7VQW30Ip7T3Z0YqLZZi3MPe1DP6V+ODj6zs+P9t9khmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by MW6PR12MB7085.namprd12.prod.outlook.com (2603:10b6:303:238::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 13:09:38 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::da13:5f6:45:fa40]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::da13:5f6:45:fa40%4]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 13:09:38 +0000
Date:   Wed, 6 Sep 2023 21:09:11 +0800
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
Subject: Re: [PATCH V5 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for
 the expansion.
Message-ID: <ZPh592R5lNOyw/tY@amd.com>
References: <20230905015116.2268926-1-li.meng@amd.com>
 <20230905015116.2268926-2-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905015116.2268926-2-li.meng@amd.com>
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|MW6PR12MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b86e0c-035b-46b9-d01c-08dbaeda861d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F/+e+d/lIwsgGj21utf3FOletuD2+F1reMzytEvGNXXwoYgVZufU1I0Q15KQxjHpiyrTcQCOaqEw6Q/bI4UPKKG++zoJ1U/e7afvYVRWbLtM9IMCOQL/vvHphOMoGF1De3qcb3vw02VsxzP1gJ8EpPh7/u4xJQbJOAC0rs5i368RnyEc+RtAXMuuC10Vkl5VSJIV2ksIiO7hx4QbbJRpIix8DXnQFHTCcQzokHQe2PjIWvUGe4JKQ3HAPo+aMCgWoKWInVWcmtF5I10HeqmOppr8jiqIYwe6WuFDrd00NRdBwLWQMgdRquc+TYnYAx9up6cmebatl4goAKVJn/53JfxZbG2nD9QhqmjYthtKjb0RoBaPvmkcpJWIMJ1qMOzeLvJqyst1qL9qwlvbLosHjCf/wvXBRY0Izr8jAT8aqdbxgvqcrLYS4/RNR3r/snERJNjSzb5GLgpo4d7PhGKtGEUnCgi+7qFcIBRYgLHYxJH15gfAfqz5N3MLh3cME4g+3usMoTkVMDqdxsn1i5jN5RxFU6nQ0hPYdAA+VqhMLlrYJo0mhlnSDXr6CMzI82tJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(396003)(366004)(1800799009)(451199024)(186009)(38100700002)(36756003)(86362001)(6512007)(6666004)(6506007)(6486002)(4744005)(478600001)(2906002)(6862004)(4326008)(5660300002)(8936002)(8676002)(41300700001)(83380400001)(6636002)(66946007)(37006003)(316002)(54906003)(66556008)(66476007)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YdS+zrcsbF0aXa8N0lMq9lddKbO1JTKsb8KYyDEm/0pfBpE8fOEDVG6dpvus?=
 =?us-ascii?Q?YJfUjUn2xGb3qpvxIqp+mcX8MO7itSFaZMdzeA4e21ayl0rv539+8CTbscyC?=
 =?us-ascii?Q?qJZTaTN9MIuIWrk4T/nb1iqJRptDMFXj34T3FhhzaICGAJRjdQcKDUDow0BJ?=
 =?us-ascii?Q?2tvl3X1ZI5XHJM2rf/L1pj9dnDtcKqbiwoqxdYVBY4GLbaLZE4hP1++xiyX7?=
 =?us-ascii?Q?eMvlZh8HD/y9myoT14/slPj4G55G3pNoWmp8rFORv2QMit5OyCeUD3j+CfBl?=
 =?us-ascii?Q?A33tsD0o8atwDUvNv/dIWq8mI8vNvNGKy5wP5DjVrC2F0YES4UVQPBEcNs7j?=
 =?us-ascii?Q?GOZS4gUDthZaeZS9PRjIlYjCkyB6XRU5EmaA5UDtl4jL51pMI3dHFlTShzF4?=
 =?us-ascii?Q?WbXZTz3BafzYOmkKq9SI5Bd9SbP/bPDpzuaczaO5BegEPSjeb/uMr7T5oZvb?=
 =?us-ascii?Q?XNwaYyuvjRTci2UZ4TbL/b9ZVbna7CHq+Cd8Go1zRfPmy/9cXpcsZS1A8/GN?=
 =?us-ascii?Q?P608hIQl8NFe27k3HUdcVbUTT88BRvscpkDPc+9AS/rg1ih5x1nYk+r9aCFx?=
 =?us-ascii?Q?3nee4isTEVZhgXGd+aSvwyJ2wpPk1+dGB//qjAepmYDKtAxmAlJ+EHnYmGTj?=
 =?us-ascii?Q?AE5h4YvrpeVKOH96dq2cvTXYANykWag9FNMDkSSq2N97WOz9wWz9iLsyp/Nx?=
 =?us-ascii?Q?dJGUgBCjUXww4URTfwXT1bJgSF8rGJxV5HpC0FNInvQQkkO2bPbg8Gs10sZa?=
 =?us-ascii?Q?X6vsYesyIV46cKLjNf76Ouigfo8hHBDSowB0bZKsIOzGJVnclFWC7Ao5UnD6?=
 =?us-ascii?Q?iowzN+5VNflK3kxPuQsJ4bIWM0K8wyXkbRqBRaNZSsojQstzEu70JR4favWw?=
 =?us-ascii?Q?HbHybBC6dstHNwieTs3NP8hNaCjuZ0y7Q8LoQ/daUm1RGvguK35teieW59dD?=
 =?us-ascii?Q?YCE7xhmH63ExhtMWzaJqYXb7D6y2/i6g+G7afqvkETxMzok3vCfwrQjQxv9A?=
 =?us-ascii?Q?x9x1Dc5RMATDCSlcTvbWTMeFqul3KuLGCdB819u+k8KfJqP0a5m7CrJWnPWd?=
 =?us-ascii?Q?Ni/XbonR3HZRwn3IjLpyzkhED4HEsyoJ7Mq8kHhDBpbx+Adc2Pppb8tp9J9/?=
 =?us-ascii?Q?DQrfETDkVpWH1ITNC3Far+uLXgkFAtQQP/gorqaUGHQ2tuAj4T3oty7FJwan?=
 =?us-ascii?Q?WrkbjaqCI1ISNR3o8ILhgs6XIsTwoP7jBFcvwqb5GD2WbLjIgeueiaAI9cCk?=
 =?us-ascii?Q?aha869mqQqsU64/b9rHpuyoOoDmhKEUKbvTVTawYHZ9ImpP2RTAASCScBnwO?=
 =?us-ascii?Q?E6jSr1O+qZaN7nzDNigHkr7RNMbv5NgZTPsYjTr1EQP5qTS81GjwfsLeMhjE?=
 =?us-ascii?Q?ZQctsf1/ZNJkl/WyP89x/ohp//SStG8D9zYFiPfxkOQqYuqf7AfAcKdFtfn0?=
 =?us-ascii?Q?rzGFHyUWbM6C28tjUbdpKl5NV6WJJcog9wvSHpaS5jO1yUrwJbwI5GU3BN0d?=
 =?us-ascii?Q?TnfsmgqtpvIT8nBIU/ihc5l6t5d/a52D/8+8QXhRIq8kCoOtyL7rDlaAHUbH?=
 =?us-ascii?Q?HG3bQTDJkxlmizToY0Ay6r3Q6pMKHvpoR6VdTx7b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b86e0c-035b-46b9-d01c-08dbaeda861d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 13:09:38.1205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kK1NMOgVqAKizFxAMhYAgJKzi4EFmJa2fLYSKLxkCQHerg4xj4lslmo0P5xgsT3UXcsMQroKCPNgfgAFgkUHQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7085
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 05, 2023 at 09:51:10AM +0800, Meng, Li (Jassmine) wrote:
> amd-pstate driver also uses SCHED_MC_PRIO, so decouple the requirement
> of CPU_SUP_INTEL from the dependencies to allow compilation in kernels
> without Intel CPU support.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  arch/x86/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 8d9e4b362572..887421b5ee8f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1052,8 +1052,9 @@ config SCHED_MC
>  
>  config SCHED_MC_PRIO
>  	bool "CPU core priorities scheduler support"
> -	depends on SCHED_MC && CPU_SUP_INTEL
> -	select X86_INTEL_PSTATE
> +	depends on SCHED_MC
> +	select X86_INTEL_PSTATE if CPU_SUP_INTEL
> +	select X86_AMD_PSTATE if CPU_SUP_AMD
>  	select CPU_FREQ
>  	default y
>  	help
> -- 
> 2.34.1
> 
