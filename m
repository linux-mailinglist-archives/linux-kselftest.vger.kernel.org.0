Return-Path: <linux-kselftest+bounces-34077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A99C6AC945F
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 19:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA4C189C831
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 17:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8949C229B3D;
	Fri, 30 May 2025 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rQTbxuqY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053D514D433;
	Fri, 30 May 2025 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748625003; cv=fail; b=l2LB7n2JS3AsV4Rx1X4dhlq88SacM4YOgY9jjXoArKPS03HXtPlUhWEGSYB83cIygn0CDPKSHTfUe/tOwAbr0ZBH+eyFMQzer/rIjB9mK0rtk5hvM73qmijIs4T+G0/TIfAYlmon+SomiCJqvVeI+27zwkXO+5DHgxjFeGBhpco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748625003; c=relaxed/simple;
	bh=HAHHO/89JseoL9w8nweOrI9iqyd8iDK0XX9fcybK9GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=muFjq1zDkMfL99m9WYvudWUu4xUEmfs4ddehCuDVsWU0H9wdqFy5vfFVCofC/RbPqXGefpw3HAbcrTUbfrwrLg4SPv1HXCJbXopgOMP4JTg0ykNlQs0wcQeA+43uj/p3WvKYdIoPNgxys0g715sgqZOoo1b++ci/iduxPgwy0gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rQTbxuqY; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q366WKJzqti6xO69in+rGnotp29fHE0IvD/ntWO1tctngis/9C+sBEclt+4EeREmZufrZ4x+nBTUG92B86E4PcYOqQJI4iMz9+vqr2Myk0RGqrGhPrL6y+ocjgr6PtVfdYS8B9t643qtlHUgWmDchR0G7k6311NXy+EyS0P2QX7A9nSkVO6mmjhQdUQympUqZM4o2/RWnc0XCCbeFGZ4gFL5fbWkfPJLQD6A9WUQEvcxdPaEiN8FLCGG9XCG6QMEJJx2kabUvGfxasUKfonQdlwEb9gj3Cyg+5pAi9ky2Dmf5Qax9sPXI4iwPH6JgZMu6kLpVjaaluAf3mmhAGjvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+4xMD2Cu4gvH68XR5RRTFdZa72eShFfTLTqOQqyfvw=;
 b=uFi1VsyojYrH/HvkSjtoY3su4Zn+1OS2vYdcS73gG4NVEmihRG2nly+u9ImHJduIsFs0WsXAk0JRKMgTW7iXOqXR123bWXp103W36XWYBPxPRursjlM3y2I5Cpo5gjH81Agdra9YIJzo9AcmofKgeOMi+JmT+PCa43l3GQ6IxcKvixxJTo4pFg05BZKUVKRzz4Da6ZU/0ywtW6FCtj9yY50Z/OsCtcyme9lVspN9WiFwDWMafR7KZAzD0BhIuiF9XnaAo5r7MjMFHZ+++fOg4xqV7JrOvbBBrMkbgKGL8Uvs3Jd8ERXiQ6sc05uGL/X05KyrFdRPAt+p4EtNzc/QQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+4xMD2Cu4gvH68XR5RRTFdZa72eShFfTLTqOQqyfvw=;
 b=rQTbxuqYUx4vyCvKykBWDag8/2D9tmiJDcWkMEMMWhc7WbIMfcsrT8TUsy4LlLS2wVaR46OYd9hSMUkVXJs2NjQLkFv1JSqWqjxUWWxazjLH+Ch0ucfaXPvmc6vObr6ylBpLtChWRaIrvkS8OX+6LeErZGlQjAQ7r3xlkqJOMP9ud2GlCIub1GxmHtSG/1XNi2tVWDMNCo8d73LMx6Y6gUooM/n0wWaOsEPSXOS/aaROFTc1QBIYun34V8TleBVx6gDKrbHR/TKF6tdzOYP6NV1KTcBLXDMIPUHmHRgN+DeKmwuEBKc5kChzuInLXiXpWBk1Mh0Ui94MmJXp3FmNhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB7329.namprd12.prod.outlook.com (2603:10b6:510:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 30 May
 2025 17:09:57 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 17:09:57 +0000
Date: Fri, 30 May 2025 14:09:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v5 29/29] iommu/tegra241-cmdqv: Add
 IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV support
Message-ID: <20250530170956.GL233377@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <97202a556153921ef3c0ab2b85622326f762bd8f.1747537752.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97202a556153921ef3c0ab2b85622326f762bd8f.1747537752.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0243.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB7329:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3d5c09-d8d8-4e24-56d3-08dd9f9ccdeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i8xQ/GkyvofKVKikIvdP2VaItXJYpzeXpdo+GaVkq17hS6tyeVZ5Vd7yFr+w?=
 =?us-ascii?Q?2qNHo2GE9Tvw3R01dlHJjr3N1SmIN3mj6qN3PbnOfSZWEwOnFtZT3w3fgU6i?=
 =?us-ascii?Q?1TfivuhJ74mBbBSmbr9IJgCT4oJCVaFyLklosCoI4e8iVz4eoXye76Z/F7QH?=
 =?us-ascii?Q?TOGpRMs5TRyeN2mip0GC/mrFthuNtC89IYpE+W5OAWX4b/dK/8qLvZfO3H3z?=
 =?us-ascii?Q?9COEOzC3QM1LHzXQ3EsKFktGaBMR2HOgAgc0rSmFlXccYXkvTwhabX3AO7Zg?=
 =?us-ascii?Q?GbcUJ7ViBBBItyvDy7LO/6ibUk0iyrXUYUyJjR1ww46XlbcegB3OvVmoE0Ct?=
 =?us-ascii?Q?m653Q87a/4G1TWupx7NiTW+hcUJ77DBMZDsnptdgAJnVQ/tKrMh1L9aapF8V?=
 =?us-ascii?Q?UcqWWJoOsxAh5u+DPM+6p+UmitZLO05WIf3ZmY9Qr8w9YJLh3dswKrk0TpXf?=
 =?us-ascii?Q?F1wse8k6J4YRWtg9ZBppTebfnh5Krs3n1i1XYNzbhSK1hm1Jip3wby7xAPYC?=
 =?us-ascii?Q?agG22sBda3g6KYlrXbezF1gns/GB0vLr7IWC67Bo7mOO6wCaK5tTr7g14UvJ?=
 =?us-ascii?Q?w0PO9Ch9yasTTdUq//QRcsUzSmBM+594Qw+rLjfV52oYly5YxlRcvyHBtXdn?=
 =?us-ascii?Q?P21lGcPTkqbyxayx7rP+xOPYY1+1+b5SA0nvhdt9g/GyTW4iC2+w+tU2v7An?=
 =?us-ascii?Q?Y0szJTufLftsuzUc2JsRyFJaNk7m56RC/WlEQQDOBgpoEVcuaUMqgAyyOJF8?=
 =?us-ascii?Q?A2/TF16AcM0e4VDs5jS9cnZZQzNENbqdS6SVfhNqx5MdqLvH9BG4VsgSI7TP?=
 =?us-ascii?Q?lg3E2MHc5TuZ5Hm2GwMN6dDpE7rAJTRFnG53c4pmAVs162gcJ9hBKUx51OZY?=
 =?us-ascii?Q?Kn3CJE+Whxw/Ax/FXmrLIyeWmvdtSpJ6KMQt3qyFz5rWEC5t4VMHv785ZnSP?=
 =?us-ascii?Q?IbFZI11auD5mSeQ+Y9a6eCZzPWzjUYnum17J9+TEaau+71trvloH4CDwTVNl?=
 =?us-ascii?Q?y0OqTr/LKNuMVPu5fXTiI0650iZMnZhZGRVYP0W1Lx6IcL6a+GjsylN4Cv1Y?=
 =?us-ascii?Q?KwunMJVsAx5dzK+0RabjA99V3MEWfXuibd3OhROeNnLEQ9svjBuQuqIeGtsf?=
 =?us-ascii?Q?sxXDDDwN/T2bDE7bK+t1gU3PRWy4lD2sQiE/18d18Vlh6OsVSf2B3jCoNc8+?=
 =?us-ascii?Q?gyEO7uNe/kQ3kQiTkn4vGcjnWpHJQ7rKPJX1p8AKW0d5nqI5BI33GPT+sXgY?=
 =?us-ascii?Q?X71wwpsYN5t98r7L5ZCscztZ2wNY6djmL+OQGYHNR6gHdjUYHHpYyv6OUMCT?=
 =?us-ascii?Q?iTdk/Z9grajIDfESncJ63VHxfNNadrgLB9PqX2ra649LMkkUQZa+liNvLuEB?=
 =?us-ascii?Q?KpWz3AlHuJaViE8rPZ/YcDo3imwhXvAasesdnPw1Gvm5so8sX5GmdpWpw2tp?=
 =?us-ascii?Q?4H7uhjc55kc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+awx3QU1fm0sLr7mW8sObA0nN41vYqC5kzGewnuAfuJry+kvLSTVuGi4uQbn?=
 =?us-ascii?Q?bRwdd7Sa2ZJJUBALzWDrWhgj0A1rHoaPFoinnykF03CuaaSjSSxre1wgKLoS?=
 =?us-ascii?Q?Rp1jJYU9Iy1BqfE5LtTVfokkNukshr6/YgmewFhQOJLZaZQDJUOTN4aQScyF?=
 =?us-ascii?Q?tmoRtxri+HZOV2V7zNDg5i9buVhh0vRHHKzSjPqKkJZA2v80v5ItV74n7Keb?=
 =?us-ascii?Q?TPQErE5T7fFMwmXlplExPWR3/yrItvOjqUaSqb9VUvemFVJdgbrZG4b9E2QU?=
 =?us-ascii?Q?iT/8uT5emnB/fRUJR++zVYWmp2uOgB/Dq76Ln+B6n/YHUxo049G1grkF27q8?=
 =?us-ascii?Q?8/zS76EXaaQ2QAu7QsmebyXsbW4/Pu/HZduwm1McELySnKcBX4cx3gOQ3SEA?=
 =?us-ascii?Q?dg0kes7TKEf6np0iVHthFfZ5BmZhhI77/5z+Fk0MJy2KlQ0h964DncRD5HI+?=
 =?us-ascii?Q?fXTxo43TzTsSKeh/UHIl3OUOyoqLh09u9KipvO3DbYCbvhLrDhPo3F2xgiOD?=
 =?us-ascii?Q?IyuHq3n9rEAfs2Qi+P4NEuWR8PQgA9muEKBMVgfJRXfDvVXxHjJft14z8Brn?=
 =?us-ascii?Q?rVrevyEI19fsGF9BqMVRgJi7GU+Sp5axJZthcYyjP3AN/ILVSVjeuQFwjYjs?=
 =?us-ascii?Q?9oqSXahgCV/2ZsqDjbjrdWnHP/4QUctVT04iM9m6+lqrCTUsHyzd52QEJcU+?=
 =?us-ascii?Q?7ycvHv1BuPPySvT4SHgUfZ3uXq54tiAPi38PY+9euGd7AHcN5QBcJkHiQp/w?=
 =?us-ascii?Q?jv4PbtYY9PRGAYn56vt9x0egYze5s+HXvFtT9NBE/Q7LbB5LAjVBAunPOY9/?=
 =?us-ascii?Q?vMIsPpFruvz6L7PLjYL6NkUg7wKMQrPLlkZHGzwo1Ch4l1BcYhDFmWmYL4qk?=
 =?us-ascii?Q?qGzimsGvjiyLtzsdrqHxZXNOd3kSEwGVfmsrNX/UwkKiW6zCWd1z5UYk47XD?=
 =?us-ascii?Q?LGeaSpSRE4dvQTuScJKvez+JFTK2TNUqBQ49VAFIiiOoJnmlbrXXHLjxHUSQ?=
 =?us-ascii?Q?4X9c5d7N7k0ITYlxsa7jGw063dCZYPuTZuY40fIQlcbs1n8vbbE3WF4uacTS?=
 =?us-ascii?Q?9EzFpRz2EKHhv8Jwht3+r3NX0c7b52FDog0WD/p5EwM4cJNZIkb9OxSYMxui?=
 =?us-ascii?Q?rzriGEIDN5LKxM6v31iXsItdt9BKWmW2WSdIpwZxqBFAB40PWALqcTRRJ2bJ?=
 =?us-ascii?Q?ONH/GTQMghrKrLvQuUN+eaTnRWrqaK9yC8emeBb/tuJW0d8fQSu/l8UOj3VU?=
 =?us-ascii?Q?WRQe3FvISZ9pBIxfUxjGLmyl8EVl5fefdbx5zGS5NjkRE0jQV49KMQoBAGP4?=
 =?us-ascii?Q?rcTaP8ZxyINk9taKPIKkgt4YuPaThAlj46JVomQw0usrc4vPQSNafhCl6djJ?=
 =?us-ascii?Q?vk8MlXMGjlbuozd0OBpxRG/35I9PbD2+8q99pJ5oB+5Yk4C+9bhA/T51BsFD?=
 =?us-ascii?Q?y8XdbJQSM4L7rQEq7qcKydbRaKfsLu0PexjNxYA3uhlqov8FHRrjF+teYIs6?=
 =?us-ascii?Q?ORNUBcbkdxXj0kPG3qoww0QIrUhN8f+iVtshE4RX3p/v0aP7mueizcFq6KrF?=
 =?us-ascii?Q?k4h7QbddNuJv1jxpnxu3oX8MCbcPj2HEc+hoVNvm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3d5c09-d8d8-4e24-56d3-08dd9f9ccdeb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 17:09:57.6810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLgCMGrrHl9wGIzlr3zq1itIdRmneCUQkYGWn8LTPqmupNmRnfyDUPUHA120qjvZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7329

On Sat, May 17, 2025 at 08:21:46PM -0700, Nicolin Chen wrote:
> Add a new vEVENTQ type for VINTFs that are assigned to the user space.
> Simply report the two 64-bit LVCMDQ_ERR_MAPs register values.
> 
> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/uapi/linux/iommufd.h                  | 15 +++++++++++++
>  .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 22 +++++++++++++++++++
>  2 files changed, 37 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

