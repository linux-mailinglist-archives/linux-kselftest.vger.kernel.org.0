Return-Path: <linux-kselftest+bounces-49179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D286DD33968
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 17:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85FBD3028F6A
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 16:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939D8399A4B;
	Fri, 16 Jan 2026 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oj5WRS++"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1461D22F74A;
	Fri, 16 Jan 2026 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582372; cv=fail; b=AuchsCVQChPXCBrjC4ii+ZA5Bi3+QBA7efAU+d2hYp2dm2Ms6XPcQ1GEyryZlgeR8shszvv/y9DLitBwU4qJr8TEvW0N4mS1u4/zayO/UWadSQwE2xrYvufwbvfD5Z/uXYJzDFc3o0jtsYyqRcB/vcez716pGvlqSdkKSwweVEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582372; c=relaxed/simple;
	bh=JfbVf6b+SA+B/fsevhyaUvMsejy8DcMbqgQbZeeDiuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aw2vOcXuhxXAr6h4WOzQqon+Zblm3ZT3TNZHWODwoKaf8+hamultP92FBDjCHoFaEAJWgj3WO602Z3jJsTvWeboYO9X2efIx6uA4u7rp/ERI8bYrDoAEFI/aitROMK6vc2kb9af2yjkxppLNO5U6EbNMARhi9U6v9c2XRitVO3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oj5WRS++; arc=fail smtp.client-ip=52.101.56.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phD0hSmFkSFK7vI42GNvHp6HjMsHIbn788jdtc2uEXEteiZX+1HNaKJCFA5JxyXYFTzd3LltauICN7ojBAVqOzgQd7Z68EjY6q5brclP9YY9JnCnTXNw22rQn27aKacKkiraYSLSTANgRGwAlIYH4ddI0zBzv3MMjVyk2ELa2COr0K9vmYHD1j1pe5sFkibrBh1qIN11Sh+hfnS9YdohGLjeK52HvGrEyyPlQzsAhZuSeUJqQ8xG2mjX3Bh7CX2y3KFykNd84WsK1CROJBlrq1ioIbfx6CmsEyHQWaQagMYdK1ZitJnYQpeZdxkTiZQ/Oj0ioFpc9HbqbX7J3CpQGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pd+6F2gV2fREj6ZByoOtgm5C//pVWzl3/g80wS81cZI=;
 b=ByIpkPAezuiTESyOpszF2vIt9OPbdiU9D/y0kCwmSjIigNTTP8YUmmhs8WUcvJvu+Zv+WbjIzsgkMyYvSoWR3Qwm400saVrMD6Nb16DzF5aeEweb1MA+138CvqEP8QEsaQsJGD5jDvxf79fwGKIPpgMYC2yGQCFwRE2o0UuP79JuCukS0f/pSor0cm3+7PfPIU4YoVaRgXT5EX7hYpseVyf0BaUG7C5uTZOAuelIpvpZjTx4TR4BTu0ryq8qOP/k1mgL1DpwWbtfu1+6C42Zr3ARRplvFqTr1Pu/1TCK+d2weGl+S0swkj79ssXi6JnKRgR3B0Qlm2JzXZOWvFZ/OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pd+6F2gV2fREj6ZByoOtgm5C//pVWzl3/g80wS81cZI=;
 b=Oj5WRS++GFfc3Yu6lJEPQkDKOhogFpNE+jgvl+oL+PteVxAZf8Y4Pm6IoCbwLP/sP10s/6Ed5nApNLTeu/Q8eV/zd9noO1lPT288CKWFQQ4bA6OtAFVCzshPGgUO4YxJ0lyosx02vNGmXkEF1R1bc2W6tSpK5j65Hnl8GfE01xhfbkTB+LnVvu4FpCg5MdAf41XIFyyBbzEPoB3X314DqGlxDHGA5SPl4CjS3VT6QMmTLODOW0OGQgmJ0BMFBU8o6YKj6royj7uYhYepWC9zYLJRHQX+Vk0Zylb/JhgyfqDP7YYwJwWz7XW/28NVcorXwRzg6LZ9sjG//epl8nqnqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 16:52:44 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 16:52:43 +0000
Date: Fri, 16 Jan 2026 12:52:42 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linusw@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v7 0/3] drivers/base: Introduce revocable
Message-ID: <20260116165242.GO961588@nvidia.com>
References: <20260116080235.350305-1-tzungbi@kernel.org>
 <2026011607-canister-catalyst-9fdd@gregkh>
 <20260116160454.GN30544@pendragon.ideasonboard.com>
 <DFQ5D44A0348.PZJIGPL972N@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFQ5D44A0348.PZJIGPL972N@kernel.org>
X-ClientProxiedBy: MN0PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:208:530::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: f45f9277-89c1-4888-54d7-08de551fab32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eOi24Am/3+uieIW2r3VQWTQfESqODezU42ugjAuZnLjXc7K1LyRHOx9yvL+W?=
 =?us-ascii?Q?BtoVp1HYj1rRwtsSTDglXfKr6bJRmqO3TWGu/edtQSMti+MnRg+ouQTPKPA/?=
 =?us-ascii?Q?yweuJhv8CQHAsvM9joR3XqSh83Gh14XC3UlR6cfoBPw6/dr8uKn3jQylX/87?=
 =?us-ascii?Q?fpZ120P2EZYrTM/gJyKr/VvNmZZSJSAJaLDtpsRIuVsqVXY7qi2IeNKeRTRo?=
 =?us-ascii?Q?4uOYGSzY4hEmKjvgNdPTkQ5fjEqYv1RKvoD8g7Q4Yg7ExgqGqe3L5uJDkyXB?=
 =?us-ascii?Q?7yVdzGHOnW4QZ1Tb8O26X7VHUmEnYwivl2xGIvauMAeyrFb3xul6lRKHaaJn?=
 =?us-ascii?Q?i/PXva0V1ssuaGJCDwHmC+SNt5HotJxjf2Gzqt2dDDituZlaPk3FJiUZ+ntm?=
 =?us-ascii?Q?iljITSnB5jB90ew9LgfxvvRx9qFX6V+Nri3rM7V4ljJFuHCUyx2GaHJelMag?=
 =?us-ascii?Q?O4QP2vlipCj6bAfZRbJLkxS81+VR5ReFanxvy7l9AA37EwJi4DC8fFeUD63K?=
 =?us-ascii?Q?gfrNXSQnrsTB3Xj2okmuaChyS+jAVjqc1tfWgnG4tjJdiBLNAP7qcmUHpbHW?=
 =?us-ascii?Q?o6qjKnlY3F+yEZdSSN3i6tPmgBiLTB653z76UzyFLbio+QLBvU1IZzzZg8EP?=
 =?us-ascii?Q?gdTauI++8d/o2WLuuF+ybhV91CNKMPJfnpnonQcl6lLjCO9fXf/hHBLcukQJ?=
 =?us-ascii?Q?dbSo6b/KHg8saxIYHbOar4GUtjRNt6v7ewE2uVCxM4i+rCbnW0bVXh9Xpqvo?=
 =?us-ascii?Q?wDqZs4unVDJXTce+3qmskE/Kj7bDHWoH40c8rJQ84ZtQDQvrb/EnB4QYXbVB?=
 =?us-ascii?Q?Am8oncNcEO0/mJhxpI6gbJAfAQZnGwAwL2IVgzv7ShWJiNgNR4q9Vh3I+udS?=
 =?us-ascii?Q?WpwNxCzwcErXRYOPlYxFH8qGDrqHMxLh42yrtTtF86LfxJ+oio6UjTbu1QPv?=
 =?us-ascii?Q?Gy+g+N2PvXWhDpqG3DX5Sei7gMAHYnb/vGqIWe9K9r8Cwg8sH2ECTi+xUeek?=
 =?us-ascii?Q?tr1rP7VHOdnmZ7cARgzgA0mfQha9MjDna8Ly/rW+jc7mjuKbWBWAjFOflbVj?=
 =?us-ascii?Q?UiyCDrKuhURFvVXGHKwI5IPjP2pwvoMp+KdO7hE/mBEubuQ9DXsyVFJlJVl9?=
 =?us-ascii?Q?nDBpNWDkiJujg2R0P5JbrDsV2so2dcJXiVybSX1eDd+v0EwfNKdppRNUlpKr?=
 =?us-ascii?Q?wbRj7pdw3gDLcYy2Cpa+KZDAulojvCmP3+w9k6WimEzDCydsNNcDlv0NB9mS?=
 =?us-ascii?Q?Mb99TWojTge0U/6l/oBIwLHw30XhaaXkuMROU7AEO4yma5WQ5SlN5GPfLAbO?=
 =?us-ascii?Q?eaKzEYaCadPBynWsu7EVPzFrtknqdkhknM1yVfSzfiNpMfI3vhweet8PzMqC?=
 =?us-ascii?Q?xZ0qfJf1Cvj2BTkDZJ/PvM7gqV9EASMSIk5Y+JL/IdfdONH11ezByxcRdiDC?=
 =?us-ascii?Q?+OyI6Q7SaamCULgRPmUFtMvcUU6ixgLcRk7j3VHig/e64FWz3rdPFw35+QjN?=
 =?us-ascii?Q?qyVyytBTz2VSU41ATX5zmL6XTKC+z15Ys6V4FItXlDlNDe1+4+i1zxRN0QXg?=
 =?us-ascii?Q?5HW06b5EcC90UFTNdzk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lk3HSrafo0dSQEcasOn4dBNBIvzLDaGjzM8BRUvTb3RHRHK21J4UOi6CsgFd?=
 =?us-ascii?Q?yKyuS3zfJq2pP4v3ZbuGa9bJ69f8Gzwq6N2cXXVyqpCRuOiTVBJm6weX+xQA?=
 =?us-ascii?Q?cLklhPopylT+QLJhtaiibP8NdzEnpH+GdrMJ5t7NOzUpLoy26LJ+FW1/11hp?=
 =?us-ascii?Q?WyNS/dj57YINbb//b/qx/hqAxqOJ03Ji0S9c5K0BCzo2FxrsecPJEKm1k1Nz?=
 =?us-ascii?Q?t1TYivBxkUkEhgjoPSVIa0T9Gvy6Ze8oTkmArG/LOVEduQ2mwVABdmfq+aZZ?=
 =?us-ascii?Q?o6QqqSDRqqvHdPRMhwu72bciw8LWDILa/Tc6XDWWAgYVA2mQlB2NPu2JcETt?=
 =?us-ascii?Q?c9h+FnnQ1VjZFTiUfeeCufqltaxpF6bJEsjDRww3chwxwcZYOgkKw4D0M1an?=
 =?us-ascii?Q?NlhJE05T4kskvCbbJGY9z6dSRLldSj59CyF1g2BLDrkDey0S1/cLgBByM4P7?=
 =?us-ascii?Q?GlajO5vuZt8M9aFVZdMDD5BVDqxste1oL7dVZLht6jZFuaAp9P0mAYC8xTE2?=
 =?us-ascii?Q?ThJvBjJlGboCgccHXlN97c/3680tQlmMKs19MJni60ddK8d7l+whKJkvUZCz?=
 =?us-ascii?Q?Ud5YTQyIYnnA+4H0SuL3Cl7tPAJTwWA+qdz1FdK3l/nmvFIx/MnxLdjuFmVD?=
 =?us-ascii?Q?ZHsk3yzXWGzx/dsJHp9msLMmxNIHD9Im4cQnOe6yF4qFXwRe8+IdGRGV+zvQ?=
 =?us-ascii?Q?rHgPSJoeXXrsjL9ZlNlajlw7xWvBYUyqaAbyJDbX6tUCa7zSTbVkXHI2RrA2?=
 =?us-ascii?Q?iRZFDNJxBf5pFTvPd8aWkU+fW1g12tJocVh70cH29d4nmAb19e/FAkk1/ZnS?=
 =?us-ascii?Q?zmlWif+cKbySgXQSxW81NMCqv8IF8KrfHDQsqtWnfE8DieuhGIBLYGxg1S5e?=
 =?us-ascii?Q?2um9Y4oyFihrsrG5XNJ7f9hq7aHUKWbR1X0T2uHlmMiqqD0PNhnmJjJF5IOn?=
 =?us-ascii?Q?mzbSqx5bG9ghEJvfnQuD39VWHBKkjsAZ89wqOj16O+FPYlbcxYFqe+obprmW?=
 =?us-ascii?Q?xqjxEEvZIbkCyRQpAgIQyd/kcqEFcshuK6aqXkkAnAX5YDRF9ClgZczrtLUk?=
 =?us-ascii?Q?HSPf7kP7QO3l7YfF0CrgroFDJ2dyPSskFIkQjLXTkglFe/0NGspVsgpVip8W?=
 =?us-ascii?Q?tC3rft1jNStLfEm/WXJMIcjFbNnQR86W5hu7wmSf1lKuUpKFouTSzSZK0WpT?=
 =?us-ascii?Q?n1jZlEdXCZVMWQlRdyNfk9wnxk4jZCL4H+wrWUOH0v2l5jigCgzH2MKCKu2/?=
 =?us-ascii?Q?X9Vf1XKImoWZTUNVLUEXk83BN198pbpoMSj6/HnX3+immz4VHvNsbFIukXba?=
 =?us-ascii?Q?2/GgZ9k0l7HE5ShHkeb/qC2feed33aYd4P0wtkbDajmO0gYlmzhjqSQ1RpD3?=
 =?us-ascii?Q?tLTUiXg1lakZAUw4D6xjFluaDIm1Ktwr1Jle/O1YA7q7JyvhOZClfthnoK9D?=
 =?us-ascii?Q?5RWiuoE8fjlMFDaK/O3JsiCPsS39vQfqGHG0U0JubKT4+FbB9uoFf8LQD/3W?=
 =?us-ascii?Q?RBtzw1dLplNiOz+fMaTLu/k+LyH9ldinSP/M49ltxCxniojz3b+aAKq3TOkX?=
 =?us-ascii?Q?zTcnSFRvlm9JHG6OE9g8eIAMQk/gD8Ia+BLDCaydelMT/WIctyRZPEfRsTtc?=
 =?us-ascii?Q?kzmGLZ95LwwEXAHa+eLm4G7EgCBWYVkjF2MuBKFuZQMin5SuDEdGWBKqdzEJ?=
 =?us-ascii?Q?GxQ1k5pLnkcIuAkgxooPnSCnVwko350GjKiZGLNHI08iME7Zoa5Anx+lkudw?=
 =?us-ascii?Q?vtt2Bt3SdQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f45f9277-89c1-4888-54d7-08de551fab32
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 16:52:43.9357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdoXzAPtQB1RHAdA4AVILbXtju++vomT+2emL8jTswZZjAWsJDFloVwNX/8PwoEs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245

On Fri, Jan 16, 2026 at 05:16:58PM +0100, Danilo Krummrich wrote:
> On Fri Jan 16, 2026 at 5:04 PM CET, Laurent Pinchart wrote:
> > The revocable mechanism isn't the right solution for races between device
> > removal and userspace access.
> 
> I think you have to differenciate, as it depends on the resource:
> 
> If the resource is a device resource (e.g. MMIO resource regions) that must not
> be held by the driver after its bound device has been unbound, you have to
> revoke the resource from the driver, i.e. you can't just fix it with a reference
> count.

The C code doesn't really work like that, it works on sync teardown
flows. If you want to write correct C code you need to think about all
the concurrency the driver has and ensure that removal undoes it

I think Laurent is referring to the lack of a sync unregister for
fops.

In this series patches 13-16 are all fops related callbacks.

#17 kind of looks like a cancel_work_sync() is missing (ie what is
preventing this work func from running after the module unloads?)

#19 is all sysfs stuff, and sysfs already has a sync unregister, so
maybe these SRCU's can never fail?

Jason

