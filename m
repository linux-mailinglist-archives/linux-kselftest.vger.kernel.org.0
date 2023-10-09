Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8557BD344
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 08:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345206AbjJIGUx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 02:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345217AbjJIGUw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 02:20:52 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C55C5;
        Sun,  8 Oct 2023 23:20:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZL9jt7Snjjo82Pn/S59obJqq7XDsb//iQdDyfnrUMPZLP/B3b5gafFG8lZDpCNMxrUNa78AT2RUAG3fID3QT0bI0NYtxOeO2lNG8tbCp4+0+YF8spdmwbETzNiJE3Qrp8Kb1DgJCQZ98ghEQMQ/YWItuviusVH+T/NfTB0xfzk5bKqP1wnvilUIoU51r00Tu1/I9Cz4++gtf4ZGCMP84Zk6fy1BH4chfqT+3B0JZ3z+poSRcbTVkzMGtp3HDZn42pIiDcTyLq2UfK1Jd0REyY6uSneg5FMn83VeJwDYz3OeJQyQxP6H9tR6f9Mht7b3Sn2gL3wMhyiIx0lrno/NjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mELu/7lmSVXqXkzpX1PFsgB/EPKcf90VkI5o0ttVwpY=;
 b=G5ShuVLxvoxFxCvkSDs6rZoJO2XSu3kG0+ZzB3bbqgLga4COWXx1maNkpZG5H+rosCSyHwpKdIdjX6FkOj2FDTqVOCle4FKXrDU1GYZ9ZxtlsCyyO22oqPMcJq0+tvUoonu/Z4uB84FjnIZ+JGXU4txl3RxgDDm1xbXlT8xrhG7qcDY63qhmTk+ITej1wnGv4xtfOj5QD4xPaihYlhyUclB3o/u/knAODmLQHk9e2Pk1M2mlTVLEcr+rARK15EpNtfjrsBecvFmRmg1RMjHdmrmbtQZYWtVGiZduqb51srjW/qPqUJPUGCxxTUaEqy9VhlJLAOctIPtjXw3ACC2CGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mELu/7lmSVXqXkzpX1PFsgB/EPKcf90VkI5o0ttVwpY=;
 b=O9iddK+HHZDaOq9ySO65cOHCDMXqKHWbHZhn5zHGXaey9pYVwjVp2u75o5nFg8r99qgT3OKe1hxznOzPJQWRKkN5T/Hod960CrkfNEU7ioqVz0VSKrBa1fI3Lr/vm2/LyvFps5hotTMxmnOdEbygIGabacdcRYCICzo8/GsH1BU=
Received: from SJ0PR03CA0016.namprd03.prod.outlook.com (2603:10b6:a03:33a::21)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 06:20:46 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::5d) by SJ0PR03CA0016.outlook.office365.com
 (2603:10b6:a03:33a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 06:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 06:20:45 +0000
Received: from BLR-5CG13462PL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 01:20:39 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     Meng Li <li.meng@amd.com>
CC:     Wyes Karny <wyes.karny@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-acpi@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH V8 4/7] cpufreq: Add a notification message that the highest perf has changed
Date:   Mon, 9 Oct 2023 11:49:05 +0530
Message-ID: <20231009061108.awcfhgr3rj2beox6@BLR-5CG13462PL.amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009024932.2563622-5-li.meng@amd.com>
References: <20231009024932.2563622-1-li.meng@amd.com> <20231009024932.2563622-5-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|MN2PR12MB4240:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb83337-cccd-4e6a-f44a-08dbc88fdfa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yPDocMwgUzpB+Hw5Fts5epdGjrrrL6tbbK83aFArLNrwi6f8UZD8Auurjoqfuh5dA6QQfJK8/mN7E+7N9WAzw6seXABeGEZrv4CyfUXBtEjRsG1yoZM6dbHLJnLrGi8QCvLw9BHJWKklx+ncfegAGzEey4kfmw0NgpK08REOYDaPf6xleCUS2I1O+QOumlw67CbXDCdNhvxNImzKRIKZqlnHrvMkNL9K6UqLtgLhivaRKgRkSqbPqlF8AeK0xWaCaO+b32RH5/epWQMY5u6T+w8HM8tXahreDxyQ8fCHXn8QZ1PZfuMd2Gq38cM/XXQh51FwCIbxl7YLGME3/nrJA6QgKE+Ig0YoN28aaGNIxgL8x5B01K2PCC0H6BAp94nx2K/dTAovhPvTKntZrKboI80gyV2VUqzPNnHS7g9i5Fo47jYHu+RM1PgnLbt9uWnpdQ/RZBRkNetdkehyWxj/BuhKzjWs9+5yz+Bb7S/+KQIT1pFsfxHD5VB3swockUOrao71tEzxzOx4ET6ki0O9E1isYPN5BHi6639FQ/TWgf241CchZn3ZfR5V9slqNiToJqxdO82UmBUr/FajEAongicrj9HclvDgq1xLNehLvL7Vt3Kd78aOagJPkBD/sivhsbd/cRr1n6fPijsKMODpBRvQpeTezAsO2TOu8DYSQkK0b5jVN6LkdsT0mIJZ5/hMfD0Aqn9wejrtwZnXvdd4a0vv5QvSnSQCOGVrlX1eCqqxxP2cd327hnTO7lJiXst0WqkEHb1CaGJzk+ZOmV03fZdM5sDQi3YJ3TiXawVzwV4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(5660300002)(8936002)(47076005)(2906002)(7696005)(41300700001)(6636002)(316002)(54906003)(70206006)(70586007)(82740400003)(1076003)(478600001)(44832011)(4326008)(8676002)(6862004)(966005)(86362001)(26005)(15650500001)(6666004)(336012)(426003)(16526019)(356005)(40460700003)(83380400001)(81166007)(55016003)(40480700001)(36860700001)(226483002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 06:20:45.9240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb83337-cccd-4e6a-f44a-08dbc88fdfa0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 09 Oct 10:49, Meng Li wrote:
> ACPI 6.5 section 8.4.6.1.1.1 specifies that Notify event 0x85 can be
> emmitted to cause the the OSPM to re-evaluate the highest performance
> register. Add support for this event.
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
> Signed-off-by: Meng Li <li.meng@amd.com>
> Link: https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#processor-device-notification-values
> ---
>  drivers/acpi/processor_driver.c |  6 ++++++
>  drivers/cpufreq/cpufreq.c       | 13 +++++++++++++
>  include/linux/cpufreq.h         |  5 +++++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> index 4bd16b3f0781..29b2fb68a35d 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -27,6 +27,7 @@
>  #define ACPI_PROCESSOR_NOTIFY_PERFORMANCE 0x80
>  #define ACPI_PROCESSOR_NOTIFY_POWER	0x81
>  #define ACPI_PROCESSOR_NOTIFY_THROTTLING	0x82
> +#define ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED	0x85
>  
>  MODULE_AUTHOR("Paul Diefenbaugh");
>  MODULE_DESCRIPTION("ACPI Processor Driver");
> @@ -83,6 +84,11 @@ static void acpi_processor_notify(acpi_handle handle, u32 event, void *data)
>  		acpi_bus_generate_netlink_event(device->pnp.device_class,
>  						  dev_name(&device->dev), event, 0);
>  		break;
> +	case ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED:
> +		cpufreq_update_highest_perf(pr->id);
> +		acpi_bus_generate_netlink_event(device->pnp.device_class,
> +						  dev_name(&device->dev), event, 0);
> +		break;
>  	default:
>  		acpi_handle_debug(handle, "Unsupported event [0x%x]\n", event);
>  		break;
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 60ed89000e82..4ada787ff105 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2718,6 +2718,19 @@ void cpufreq_update_limits(unsigned int cpu)
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_update_limits);
>  
> +/**
> + * cpufreq_update_highest_perf - Update highest performance for a given CPU.
> + * @cpu: CPU to update the highest performance for.
> + *
> + * Invoke the driver's ->update_highest_perf callback if present
> + */
> +void cpufreq_update_highest_perf(unsigned int cpu)
> +{
> +	if (cpufreq_driver->update_highest_perf)
> +		cpufreq_driver->update_highest_perf(cpu);
> +}
> +EXPORT_SYMBOL_GPL(cpufreq_update_highest_perf);
> +
>  /*********************************************************************
>   *               BOOST						     *
>   *********************************************************************/
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 71d186d6933a..1cc1241fb698 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -235,6 +235,7 @@ int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
>  void refresh_frequency_limits(struct cpufreq_policy *policy);
>  void cpufreq_update_policy(unsigned int cpu);
>  void cpufreq_update_limits(unsigned int cpu);
> +void cpufreq_update_highest_perf(unsigned int cpu);
>  bool have_governor_per_policy(void);
>  bool cpufreq_supports_freq_invariance(void);
>  struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
> @@ -263,6 +264,7 @@ static inline bool cpufreq_supports_freq_invariance(void)
>  	return false;
>  }
>  static inline void disable_cpufreq(void) { }
> +static inline void cpufreq_update_highest_perf(unsigned int cpu) { }
>  #endif
>  
>  #ifdef CONFIG_CPU_FREQ_STAT
> @@ -380,6 +382,9 @@ struct cpufreq_driver {
>  	/* Called to update policy limits on firmware notifications. */
>  	void		(*update_limits)(unsigned int cpu);
>  
> +	/* Called to update highest performance on firmware notifications. */
> +	void		(*update_highest_perf)(unsigned int cpu);
> +
>  	/* optional */
>  	int		(*bios_limit)(int cpu, unsigned int *limit);
>  
> -- 
> 2.34.1
> 
