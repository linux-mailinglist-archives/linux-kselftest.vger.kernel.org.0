Return-Path: <linux-kselftest+bounces-15352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA0D95252F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 00:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F094B2147C
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 22:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518DD1474D7;
	Wed, 14 Aug 2024 22:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZqMkm04B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D584B1459EA;
	Wed, 14 Aug 2024 22:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723672948; cv=fail; b=E0fQXU14zNQAp09RHnF92RQp1MOcmkgoBR0WJHoWVudjiNiRFeoZSIy/1xjRaJgw9xpMRYiSnLJeSkqD+bovAUF9XNgSv08oHSyjwPH0UxRYhOWdLnXwd1vC0qf3icthNvdJt8DxMLAVZSd4Bu5ZmAm9K2hiIcWv1DjveeqMwwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723672948; c=relaxed/simple;
	bh=u7N+gefs3HOnE3Y+MrArvGj9URkPApSveoDmJzhG4xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=syVgwgehAatnKmm2yxx7tZBoJovitejV41SnEOmB3W0RaLyWlZ0hdpaD0rV3SMHxJ48L8teuEWKquZl/Y3NC1oY5uj15715CMwaLjokAe4NbgTwKH7XiKK5OnlhfUtBhrn2FbMkxaT3fMNJ7ZeTPjPhJW/BWXNEkGymcZrCPoFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZqMkm04B; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMIjnR5GX1v1nBMPSK1y6CcwprV4b9e2BqF7dXYl5rhH3YJnSOiy/Q8T+Jvgsk5jiVr0d/oCxR0hAX55TxlGoulecNo7qaewb1FB3dN/L0BS/8ufRiIpxTFgDG6vIlt8tEnYr/67ioGfpMrhKcXL/oXKXJX7ngRxvBnXhrXaQIOAM5yLMFd3Gzy3v8rqv/OVo+/0s0eywYZ2GiUB6lRDyrYMZR+zeZp2eITMEIJ4aU/iRQwJVrJlmqzz4bEC/REtL7QD8eyCxZIPleE33Dd4/bXrDB8iETYvPFiZMBgH+aq2w/uM5uDGYjHoDGZFhr2EnLYVrOHSOS4s6J3z5cKOlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGddz5WzOh9QEH86TpYJTPHODLpBXajraZr4nTi3DBI=;
 b=aDPRhdE+gW1XVebqViEDPJe5fb/mpVijvZyJ8onpxVGSHm/7JK1bV8XziZX1iebsINqjVTj6DAet7ASYHD+B1gqAEVb5ivUkvc9HnnhzPPe4B0KogdPuh0rchcgjZcGxlMe6z6G6O/t0HojcnZHtepYPGdadp5jYKUq9rOGtYsLGP1kRDH6b+t6BJxOTY+T+FmzV2fSzJ/NNQtSm978S/1TzBfwEAORGnGfN68wHlFFB3/DSMHig7xaRrA9lSr4j2Khnnhz1f9U2oczKlSayT0J94AUBp++w5yPtrp2b0PuEUYt9aIar3BK8Fe/WgL/ZBp5O40Fefi2Fxj+sxwcy3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGddz5WzOh9QEH86TpYJTPHODLpBXajraZr4nTi3DBI=;
 b=ZqMkm04BtBVs8WK8MXZkhdmAYkPZqbY/g4SNzYAUuupyEs9lNfLJ+SECcksaWr2yIER0LwEr0NOtcDIoXyOxv3Zu/OpldMKqMiVpTrX7BKOJSHy6/ti9n/QGsUtxi/QXAZKaH1U8DkKfW5FZzyOvBgOGCyo4ehiht+KbK7xGEODeblpjrM/2IPvCJC8DLQjs5q52d0bdcu6d3VmCqZVOG7VlwU4LShCK+JtJxzp01WBlkyHwHQtKZeQdbifh/G79QxX6iQSU2Q+gdK3HAlN0m8ujXlWmIm59xvDqEmckJQLGiOJ9KpJO+lvEC64hWiWnpSSAcgHsnCwO3tGje4fLIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16)
 by CH3PR12MB7594.namprd12.prod.outlook.com (2603:10b6:610:140::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 22:02:23 +0000
Received: from DM4PR12MB7767.namprd12.prod.outlook.com
 ([fe80::55c8:54a0:23b5:3e52]) by DM4PR12MB7767.namprd12.prod.outlook.com
 ([fe80::55c8:54a0:23b5:3e52%3]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 22:02:23 +0000
Date: Wed, 14 Aug 2024 19:02:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 05/16] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <20240814220221.GZ2032816@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <e35a24d4337b985aabbcfe7857cac2186d4f61e9.1723061378.git.nicolinc@nvidia.com>
 <Zrzkwu7srmLTch+a@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zrzkwu7srmLTch+a@Asurada-Nvidia>
X-ClientProxiedBy: MN0P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::25) To DM4PR12MB7767.namprd12.prod.outlook.com
 (2603:10b6:8:100::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7767:EE_|CH3PR12MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: 58b4c981-cf75-4677-6a08-08dcbcacc69b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	PSuWzYCqWMv4Sz/+cJeChU1aPhuBACE5dsMXDuzJ3xUaGklpQir9EjEUFG1JRneU8jOJzR9HLNOXNkbbwmu/FxLh+1V2QW81dur7k/RfjzebFWTfApW5QJOUrCpTrhh9oIlXljFUeMUmbVvIg78vPboWVaUjTj0GxGoEMxSSsx1qJVMND8fD50t/okRZHA45mtrc4ontfEJBCSdwx5EbmfopaYk9IuQfwOwnLKMubPD6nKCPZ9KdWbDCgRKbB9WLQntFUeGAj706M5AnmD6ktUhTBPDh+egtpx8HkmplfW2ML6VoHP5bPWXwW3+X781zdyfmjaWOe4FWW7oPnNM8vNvUTWa7nGkdBbEzgbxExmsazqmcER8tDDFsLao8cl16p/RXiSFb/VlgQpGE/0WbBDC29RSqN+vo5egzrLONB+80emyU4ZJsqRr49Kfjep5BtuDABAyUAXZke5Fef43DqokvZKG3qrXKjexOnAHfKC5VLe+u2ZodnV+U8jbnX5ep9b00xbeH4fy4qHn5YdWBPPyJYTVGKjtpa/GbqQ64p41TPi2IwJb/Zk63y5P2Yo3Tdku3RwSxuzUQPKvTuO/jSDS9BiLgIbthy8nhdCwIiDbhCiEGMc3ECyJIQqlPk4IKeD9H2/32kORzGzma7nu1yGL0RexCvV+V5EPbqmPBx+Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SEiWds3PYSXyYCKOK016wNBqDdbWGV+H7tBXIwKqyyhOZl65CIJ6FUV7UUXD?=
 =?us-ascii?Q?fJMkdwuAp5OWpRvkP11phQgpPSOYLwUBQqWKznvDTb+O9WQ+Dnn4YtpvkLZa?=
 =?us-ascii?Q?iF9uq+UJDJyYkm5fDTkB4vHcmPPkp7pFI7OLr1z0QoScMTLBpNQpchKI8RjN?=
 =?us-ascii?Q?MyHpA79cFjANaizqrwfG7G/ml/4+cXRmpLs1N5MFHnkB/NiLMPk6LeSyQu9B?=
 =?us-ascii?Q?+xYVbhtefzayFLcF5ApkHNR2Z61EH4Y92jmH0/Pluo0hlnOZPjgu9p2krSZZ?=
 =?us-ascii?Q?4Xtb/qElOwxP6gm337OjdSpcAeCA5f9N5pGnKaKPXJxOE+vQf2VGVj7NG8n1?=
 =?us-ascii?Q?dxDEUvtNREnYXMsQuKuYPgpTyO4yI0j/fJsY94pz62Ps7f6qySX0FEYJ0kYT?=
 =?us-ascii?Q?NDe/IN59HXclqdPw/hyRxboeFGBp3gOGyNZXpuLbO3D4NoF5QiOggg9uBPmH?=
 =?us-ascii?Q?0uf35RUESiVzsAUwuRyR/vy3IDI+7K2PBQVrfZcjRKJRCfENMa9MoRPa/tXo?=
 =?us-ascii?Q?x1HF9WdYYXeqrkNQ7TleQWAAKNEqX0VLZCOKsC7iJTlSphxeFltg4H5fh35o?=
 =?us-ascii?Q?WRfsRnSglrdQHpvmgBH3rQLSVPIGmtm+Uu4wfXVj9DYsa8VbuT7OdGujKxlA?=
 =?us-ascii?Q?KdUZhj29isdU6pHeRmd7X+M1+cIFaO4Gmn5h19hee0IiqwtmgVXmELCTTrLe?=
 =?us-ascii?Q?4a7bFQF3MH4JsZRJQ412ILsoW+fg9bZY2LG3WmLj7JaSpt0gzZhkAPtocb3j?=
 =?us-ascii?Q?GdsYFLEa4NIj+hzcBgoL4z2+S9E6Co7KD9g8QlY0Lbcyfk7V8ir9tEgWzC58?=
 =?us-ascii?Q?M8W2eLU4AmoKDvgGl87nvaeyb8dMNXGVT6IejPxo/JbZ+FFYirNqmLt5SQg9?=
 =?us-ascii?Q?GnO026bqN+ED1+P5IBuD0PBw/ir6AspEDybjAM3arHLSmzdjCSdjvgd15uPM?=
 =?us-ascii?Q?IcRei9crRTGJjiF9hf/xeEp2YRIV5zoKz8E1UfTmQMLikrWc0DawkMHmM8q3?=
 =?us-ascii?Q?5YPBVsNZB95UDzwyPdhntnVtTSzqI0L+Mn+ja0D1OlCj6UXbYT3SsTEPuAFK?=
 =?us-ascii?Q?YuFdrr8PE36aZuQluMkultaNon5nPX1NdM6dSocoHnfJiCSH9FE3CO7RiV5Y?=
 =?us-ascii?Q?+BYza9CHoO3g0pgPPRH/+MfTsO+o7v+LCjow8On8+vTWD6pv/3QvDQrBxIHr?=
 =?us-ascii?Q?JCfGslsx0QfKBeGVAVgEkSHls/7iLS7Rw4kc8hu7nGW6ZCRq3v6/49H7crj9?=
 =?us-ascii?Q?JQx2C3LSIN/Ep9lkvDwP81LaEqs0n6r7+BI283ZEDlqvSHZlG0hyj8KUU3PH?=
 =?us-ascii?Q?rXYd1FbwO7O9+gaHV+BcJARt3vfj9mhg+RDRT1RWvST7MnUuvwWyDEp+vC/e?=
 =?us-ascii?Q?gWBgO3hRlCSg2/qasCJabaTaeXeNnEy/n4ZfBtaomnJLH8EWZth/XjhqJJ0K?=
 =?us-ascii?Q?tWxJ8oQmEhsYbwEv7vO3kTD0BqRsux0bsBcoK/fR3sormOQ7E5TG9LG1dWNS?=
 =?us-ascii?Q?f/rBB7OOMxNgmTW1aeWRsQckl9UXjViB7zDrkzBP7gtuRrhp6sUlhwtvqO3h?=
 =?us-ascii?Q?8HEx+kow/mRg5/fkLrY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b4c981-cf75-4677-6a08-08dcbcacc69b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 22:02:23.3892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/Ci0KRnX4zWPhpovg5MJzCOw+V/9PVnGDhmMBGFKnjpq0ev3jhxJGO2coz+qhXB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7594

On Wed, Aug 14, 2024 at 10:09:22AM -0700, Nicolin Chen wrote:

> This helps us to build a device-based virq report function:
> +void iommufd_device_report_virq(struct device *dev, unsigned int data_type,
> +                               void *data_ptr, size_t data_len);
> 
> I built a link from device to viommu reusing Baolu's work:
> struct device -> struct iommu_group -> struct iommu_attach_handle
> -> struct iommufd_attach_handle -> struct iommufd_device (idev)
> -> struct iommufd_vdev_id (idev->vdev_id)

That makes sense, the vdev id would be 1:1 with the struct device, and
the iommufd_device is also supposed to be 1:1 with the struct device.

Jason

