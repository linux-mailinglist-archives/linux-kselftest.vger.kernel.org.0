Return-Path: <linux-kselftest+bounces-37985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C68F7B11DAE
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 13:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907213AA4C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 11:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D20F29E0F8;
	Fri, 25 Jul 2025 11:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ktr5UIRL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1115C2E49B8;
	Fri, 25 Jul 2025 11:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753443386; cv=fail; b=mlK+iTNI5jzv7R2nS4X2F4Gb3UBClX3+FWfQMx4XNb7WtWtTx/sRSbaogbF1bc9NZfU1fkJ4l5IvD87zrmIBdpoLXnKAQISfvGuVoXpT9VLSiK8VBiL7GQtFt0YL0v7VEgcFvkW6bJ4JAisXJXcEpzlUm8vxm9EGqybNCKwsqdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753443386; c=relaxed/simple;
	bh=JQurv4BE6lZ99FaPVp7F51rsMHAgTDA4e4XNWYyruu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qRd+2Tf5n7WY6qqO6i4ig8yNT7QrhTKs52THCSkkXh1y2Tfx3F0nlgwl5i7+Fkle81KOD2H01mZZ2iT+dciGOMVnz8XGzpIS8nclFiQ/frRyulP2SGfQcYbf2ouKEOt2pu6V+MJYWKoz59YsxSlYoA9veM7Byrs//vEz3LJ06os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ktr5UIRL; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXW6eppJAL81hPWAaba7WFxirKqoW8qNZgVGJfx8R/DXrqXim/q1mYRrHh0/0gdQ8Tf+7Wbx9DkomdQUTdyTkYDyGOrrFqxjCnw2xlH1hLyxvWdauw24iqmBLFs3u0IpybbBRL9p++MfIbe5F7+hDyiDadSJXZkFwHSTQQxCxrWpoCvYIdEkYqzxH0YSoxETYg7AaCtG23KsCLefgw/MnD1Eie8xQZ6scJpYN6CT9Ofv59IxV3HCDsqgeSywKvlqbyD8AUIuyDdP7zab4cib/YVHM6Rb0R3/jN9eczE3lMEd+qBJqUPbpJMuatKg+6Tlx32xTAMW4Du9IOaJsMlV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lu+lNZSGh5k7v9QJbYnciMZz9hUQh7sKxLo0qLIPSnc=;
 b=Eko3QxjveWKVxHnumbhVV3XXIpW0QR6oXwY/YopiZ+nz1A+zdoKpUE5E4jN+7LaT7UByvfWyqNflRJMK5s33zbzSJPqjuY70RNPy/FuE2+49G0wEGjdh1W/wJywZjDr/a7UqNiABgLAl4CNyHQAm2fsJHgMLLyIyu8qB0dDq0xZo6/NdWw1nhKqN28ROAT20tTBp438alPQwO20DhoFpUT5HsW5CFRVmr7Nvb8UeihXqMjeTUPavxPT10H3Y+ih0l7l5QwyA56FYFh5nSZD9aUgvpPCudWF/nlC2Xx/nEukax8YAqeksSSbXMN9Zfnj97qM//yOLPU3ixglhAsAkBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu+lNZSGh5k7v9QJbYnciMZz9hUQh7sKxLo0qLIPSnc=;
 b=Ktr5UIRLO4bHayuRSw9QfQ3czieNt2wFIZa/m27qjRknySqofzPvQ7lAYaXhD/lrbrdjHxRMrMOXFYaLopAzcf24CVnBqGg4QZa5Zyc/1LJmCXmw+wo6Dyt7s6q8kLQ8ocb9e8Sp6NjWLnX2YDXC10CodaHYx6XmT+9P3NOGWJNdGuLmlZySMWdYEcbpV+lplUcAN0mE2kpxj9PejBjpfDbyeAzg4JUAUQ13SLhJ/CuS9PlgmjSPDs5Nwjzj/GvAqZn4fkNSJhJ2+AE1kFay30F1k64731aSfngNeEj1GcKpug0YenCpHz9udv5ES6Nm3tKaUy4ObLpt/dnWFkYFYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7361.namprd12.prod.outlook.com (2603:10b6:930:53::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Fri, 25 Jul
 2025 11:36:21 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 11:36:21 +0000
Date: Fri, 25 Jul 2025 13:36:14 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	shuah@kernel.org, sched-ext@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] selftests/sched_ext: Remove duplicate sched.h
 header
Message-ID: <aINsLvsssT9NvSvn@gpd4>
References: <20250725090412.2040782-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725090412.2040782-1-jiapeng.chong@linux.alibaba.com>
X-ClientProxiedBy: MI0P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 3032f410-8d6f-4863-972d-08ddcb6f7a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?akt0kKLrCpreT2tjFnrznp43iWQ78o6zBiEFsRtpVvJg+khyxi2UJWaG1cgW?=
 =?us-ascii?Q?anvNGnfxvRFF7LNIdfap6HMWcXvl5jOfFf0+s2Q4zk+pk2IJucK5PnH0Rl0M?=
 =?us-ascii?Q?VTo52LuaUzGsszWsR7R+yTP+1V2KtWrUAwae4fXdY51v0RbRSRhGjVN1+qWj?=
 =?us-ascii?Q?A2SXlO5TACP+V8qvJuESdqwYDx7QcQqtqOKqA3kAZH/9sflqnCQShK1J8UGh?=
 =?us-ascii?Q?uJbnn05z1j/iID0JLNtwA8Izx5V8avCw/y2CvqAB3xhwHgielOHPusfV3kx8?=
 =?us-ascii?Q?dX4YIwDzFt6HjvuNcxfN+bbtrYOO3qeQkHn1m8Q77dixKh7/Lv6AY5y+tc75?=
 =?us-ascii?Q?AgWh1rC7R2E7phHAxGT8nvoKPi6o3zjIypTMU4C4aIYyptdnK0oPZyS6qi+w?=
 =?us-ascii?Q?hlvUjkCuhh25tcUIvvV3hyCaE9ZPmbAPMGPGY2MhdCtAeYL7xHYJG4wGJioT?=
 =?us-ascii?Q?M11e0aj7TaDXfD3+xAzTGw1hVXPYMXaXzvYYe6xUoFpos48eJ1StfgGwoGKr?=
 =?us-ascii?Q?R9vocKnDyQjZRDqbr9XBn+W0sQy90hZWpFRfOuJllOs4VvG7+o8rCn4NCOe/?=
 =?us-ascii?Q?F4atPE7DHiP4n9ojbM8arRZ8wuG0rCCqxqWSY2evhljidlUUkKsta+nOarFE?=
 =?us-ascii?Q?hFvNyou61DdiSaCI4swpK0+xVQ+tHXI3vFXEgHxmylOFr0tiPJ3J0vOWdELI?=
 =?us-ascii?Q?QSHvMF+UVdrwgxujlRN+Sgfv4vTkvOQ17Ss/2yFCyrpA64/UK3EqXIT/ekHN?=
 =?us-ascii?Q?jGTG8MYTep5frIagdID7nTf5j8s6EomA6bVT2R+hqFcVWtlXgBRG80g7ur15?=
 =?us-ascii?Q?0lBvAM5oq8SItRVv439VcS/Klti4oQPZwzmFmzj5vJGoQ7IKAuf1/Dy25d1E?=
 =?us-ascii?Q?IMd5fOIhTtoFpnZB6JMoTwAK+s0dsHxZYLlCyN2KBYoSMRQeVHTtSgQHuOje?=
 =?us-ascii?Q?bofiPxVI19fq8lRWAuTBF6ymLt90P8y/0I8XfYr3+GVXF8XswlTe5VAaAdyE?=
 =?us-ascii?Q?thYgHDgySXVZtBmpO80C0JeEOdgg+pbzDzOofgKt2D2xuu51DEOMYi9sL9iq?=
 =?us-ascii?Q?jWKB9hMvDVjuuW95MLKD/cukk3l9lZxYG9W/117koDMGxMGcF7rcgiUM0Q/n?=
 =?us-ascii?Q?vufSKxenkUYtuLaOkHUxC01se7ip8Ifio01r2tL5Sppbi5FFTMlacyJCjyMN?=
 =?us-ascii?Q?NT5LUAqC+JnFbMsmqBJgt9WmzWfDPXC8C9V1QCcWmMTWlwz3aS9lLdMyEd88?=
 =?us-ascii?Q?2NAzqf0n6ZrpfMb0I3eqS2JAdCL4JMnoN7cZiRTEH9ZbGdMryUwMqPxCHLuw?=
 =?us-ascii?Q?X12N0xaycbDooYSWsquibikt6xvUYZulRPLjinzWmoLmnDS717U3nN+SdLMA?=
 =?us-ascii?Q?dFdFthtvoDbfpWseOripci6pPvT4w7OP8XWPUKbc8Zh6AWPASsuZHK05WjgB?=
 =?us-ascii?Q?EZCwntDLYww=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l2XKi9HMS4od2bfQPvIlYILyc1ZN7L2sl/XMEXuLoUDYC+DPFb6IRCtq9K4b?=
 =?us-ascii?Q?ysUOEHHUE5I8k3yW4uqLxwkT0MMY+/ComBDfsbQzNhnCexyzS0B64ku+58QT?=
 =?us-ascii?Q?ken4yIqYQGvsdHOGkrHUUAgv16Ts/Vkyvsm/Nlo94vkimwL1sxfx11OIEj2s?=
 =?us-ascii?Q?FFbby9mb2gcaJPYpwohbg4K63SPWm/fNXyKKZVxJnQg8q+A9+2AAKibK+QoU?=
 =?us-ascii?Q?kUA7LD1TY/EZpLgOrNPDkSeG7xgnF8FIjlXJaz7R+tVPxQVaboOQQD2/B+B9?=
 =?us-ascii?Q?l6lD1Q0i5A0EKEaBoIunvV9kpShzX+1DJaubbKGy3x1nn8ZLzXKzPhAnKjwf?=
 =?us-ascii?Q?jGkqrShJM5JqePdliTdOtgJekQINVcmpQlUe4yDcH/S27lLgkcwXor+8uCkE?=
 =?us-ascii?Q?7qSAnpVkDrDgaSinJiq7GbW+cZ81LX7TEa2HNs8L0Qz08b/RJ0bV0AiyNxvB?=
 =?us-ascii?Q?/GPYl4GpBnzsDJ8y7f3J1OPIfk3c4P/r40CLaHFWMfuSLfvppb2jA1foCVpG?=
 =?us-ascii?Q?9i7ahlmrzCk+Idfi8o3jiDrKsFWGpOGktHMWB/LYpUV45cqtC+VjcRSZh+Gb?=
 =?us-ascii?Q?K9JxO6K9LEX4e8oBZDMM1iv+TpITbpuiz3guLNXTDxiqdXtlby1ZLpGPx7h4?=
 =?us-ascii?Q?SFRvxtrdiDX5Xvr4WSKfLNIBfLXAfOA8KzO4wEHh17bIzbHoO+Z4fhXqauGn?=
 =?us-ascii?Q?aOTtyML/cdVeIfEooP1YFR+GfnHQI0wb1MrHYCyteIlG9SgGQlTxtrbQT+r8?=
 =?us-ascii?Q?LSwxCD0BUkln8FZyd8OCO9NJEYjzZG36nkqRsmaYQ8jiiE+koonmM3PUq3Ov?=
 =?us-ascii?Q?Szl1ASXBAr92A9FVqD9Se6WPYzT4u0udOj9d0Jx0duGPp0iseoL3L1aNbOTb?=
 =?us-ascii?Q?DXU63L3UuE7FDR/o+mTlXHm3wjqKhcjKLf+CkmHeimRmw24AJ5hX4FC+xW4p?=
 =?us-ascii?Q?roVoAscFIHVUmO/w6Kqm3ifwZpgACQKZ32sh/8A5xsGCW2Hf0y5+tG/DZsl3?=
 =?us-ascii?Q?XZ1iY8gnpoiepm5PJq27z0Y/V3d/cMrJX6ySdJ6dNiqbMOrg0ATd1ulBGfxb?=
 =?us-ascii?Q?063Ul73HdKhC4F02PyB3b3Q/OJLdfh4DqoSrcwgRNwHm0a37ATd5Pcw3fA6g?=
 =?us-ascii?Q?vx/yEi6b/Ov9n1QxWEAvRos6XuSA5EzvltuGFTv66UYS8xOS9uXR+PCwknVw?=
 =?us-ascii?Q?1H4pgO6nMQnQu/kEe9AQVrXBqBcz99lL+FddaXzsn60ZBsCz0z/CFcQ9Bbfc?=
 =?us-ascii?Q?pNgQOYuQsTja7ZOjelvLcOV3IBQfdBPk5BCs/HgYhPuOcYe10zD7O05fWKxb?=
 =?us-ascii?Q?Q+Zki2BhXdAt5yJRLZ3oECceB3c9Mn5KHD9PeY5N/7wRJbLQwm3JLhM7sASK?=
 =?us-ascii?Q?UrKWKCsuPq/OssstBNu017sQPkZCehw6BwoCiJy/GWroYQrrNqsRwunCSUD6?=
 =?us-ascii?Q?5EMpCA1BktZScXLcx9xzKKBdhJgdHCV/t4d8bxC+qh7R6GTz+NkfQfHIwWav?=
 =?us-ascii?Q?hkq+XYw1pbekNnamVcEyi1ANuAYZMYxNCyw2Hwp3kNUyUpwjCPj9Lh3GQyL+?=
 =?us-ascii?Q?DnxrRnLiyy70wZF8/i+KhjfZ2jo8NiHqh9U4DADF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3032f410-8d6f-4863-972d-08ddcb6f7a89
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 11:36:21.5897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAA8nhKqvDo9WxmOHl0d8RAhCJY6IL6QT24oWD3WtkT1K1K6RsWtdnCHx0nxjq/GgjuDrlWjLDFeP0oEjISWQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7361

On Fri, Jul 25, 2025 at 05:04:12PM +0800, Jiapeng Chong wrote:
> ./tools/testing/selftests/sched_ext/hotplug.c: sched.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=22941
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks for the cleanup.

-Andrea

> ---
>  tools/testing/selftests/sched_ext/hotplug.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/sched_ext/hotplug.c b/tools/testing/selftests/sched_ext/hotplug.c
> index 1c9ceb661c43..0cfbb111a2d0 100644
> --- a/tools/testing/selftests/sched_ext/hotplug.c
> +++ b/tools/testing/selftests/sched_ext/hotplug.c
> @@ -6,7 +6,6 @@
>  #include <bpf/bpf.h>
>  #include <sched.h>
>  #include <scx/common.h>
> -#include <sched.h>
>  #include <sys/wait.h>
>  #include <unistd.h>
>  
> -- 
> 2.43.5
> 

