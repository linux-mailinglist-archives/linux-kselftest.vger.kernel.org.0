Return-Path: <linux-kselftest+bounces-18734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2D298BBD9
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 14:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B90AEB21EF0
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 12:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870611C1ACF;
	Tue,  1 Oct 2024 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oMW94UZj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDE319DF53;
	Tue,  1 Oct 2024 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727784693; cv=fail; b=lMXuvxvwKraE58IjpiJSP7h1iNIKYw8eUxqM/GKRkNyY15tVmE0t++pfm46GYc89oDgDjJbc/T6F4bxKLbm5GSTBStZlgo/UlFbM9+mKAgme63ztx5kikUa4NfkSW4kuo5oXOL9EApNfvu8GPCl2nIwzRnNdKk57uJtW0mnDoJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727784693; c=relaxed/simple;
	bh=6gKOLyiUBbdgX7PtQInbsH8CSl/zyBwhNi7yfRZ7Wgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uWwT65qKzSeBU0QyEmqaUWy34tE9MUlA/51bq0Rg4XZsQLuVWB2sslTNb0XVrjyHLHnk7J3/AqS3hrVyICYLWprwiQ+TePCGEqCUx8Rj9Xnr3+SILbH7YHZyCfObK/H1F21e+iqv7vDi//Lnsr3FpZFijq0JKJFhoRlwv69cbuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oMW94UZj; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBKBv09PdBo69mrgcDV0y6wk0YAZhpzYwZt4rkZYEOiQV4r8n9qALD5A3FhWn34q0wGaMc9BMe65XS41+WSMuISfMGXM/RlTjYNYFLzsXZMliYJ2Os12ffyPnwA5I/rdl0ZRkwKBmpmYrdsn1QURxAJUXhE4BEXImz5YebjbnbDiv60FbplPSVhds98BpbtSN1VrmOdmtaTBNAthdehFU2QQubNMxQczfequGqcbblDczGpmxcbVFw5nUs82rym/y+/4+j4ZVuchu0iQ3frasB6FwOiMkPZN3NRwmY2uN5QUcpb+nQ1HdEyVfO0tKoQuMT4bvk1IZU01V9JEC40+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sniU6ndF4DavvTiJR9W8EB4FtxSU9gx8tq89u0F/g+s=;
 b=G9oGwpzdjzygwMCGkKF5kSw8sGN3aOfB8oBKWGFAgbJMsRK6fCMEDuE1kx8x+0iQjIZeAiFiQ0s3B6b45hsGPbO4Ku7z2l76g/Ic51HtoxeJbetrxuBJbOzQoqXAvYIZTxoSxv9xBSiSr5LVkZNtUWn2p3OXZ/Fx6xVMbbuhBHMlxSLeR7Xl2upL023HRCe0FQUW/AEzLX6Q+/eu4LNYMhuCv1AsR3zcX13hOT/sOlmgHjJJlq+rPuI/OPXfzFXJ7N2fFk8yWZlCThZ4HoqNq88ftg7swpp6Ip4dLhXDC6NH0GAteDCfifFYADdVxeMmBlAVZhr7yhaKDWJ8kTg8Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sniU6ndF4DavvTiJR9W8EB4FtxSU9gx8tq89u0F/g+s=;
 b=oMW94UZjOOggai1DGpaDYgPwxK84Ar/FMA5GMwpXSAr3EQxzUtbcEPqytYEg3gDimNRKKmZFUpVqnRkT4qe/lmXwAUBhSwmr6wIC3gEIIfVgpHYAKCn+Xbnmk4buEw0CcD/aeuoWMNfrYCVX1o6o+g2FD+5RglNOMOpi/n6l/j3eJVxSDJyqyn4gG4En2ej3AckMOX5s7SfOysDKniykpet+pRjQ/xFb6oDz4LTCCdt8aFlczUTW9YmOD5xHvfi0In4+JarRi/ZM+fs6Vj9HpuupVUwcTNyQ6LuEWN4D/GrN1ADQrozAevpJWlfRE2jozVQ1XLA6LOlv+PlKg7oTXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB8465.namprd12.prod.outlook.com (2603:10b6:208:457::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.28; Tue, 1 Oct
 2024 12:11:28 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 12:11:27 +0000
Date: Tue, 1 Oct 2024 09:11:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>
Subject: Re: [PATCH v3 3/4] vfio: Add VFIO_DEVICE_PASID_[AT|DE]TACH_IOMMUFD_PT
Message-ID: <20241001121126.GC1365916@nvidia.com>
References: <20240912131729.14951-1-yi.l.liu@intel.com>
 <20240912131729.14951-4-yi.l.liu@intel.com>
 <BN9PR11MB5276D2D0EEAC2904EDB60B048C762@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276D2D0EEAC2904EDB60B048C762@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN1PR14CA0011.namprd14.prod.outlook.com
 (2603:10b6:408:e3::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bae6f33-e77f-4ccb-6c79-08dce2122d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gBiLg8KIXXnQnwd1NrxNDgbVmcIsuHSc9d8hBeYmZglimOezNioU1dAS36Nz?=
 =?us-ascii?Q?1FDtJUGj5rNsNR7P4g3Pg2DOa3Md1vd+TWHQm4B9g8H1W2o8TIi8l6JEswZU?=
 =?us-ascii?Q?SNfOO2OaSWSr6C7VaS3ROzT5wX8LoFZe+d8r0t4PMpF+e4p7j+enu3icuKqn?=
 =?us-ascii?Q?W4oM5e0kUSz+Rc1Fd/WZr5ELE32qMFF9a2PZeYnvOq+OSnkofD9EcvIte2qx?=
 =?us-ascii?Q?+B34wpiNU8j6p/gdHUIC/9+Y/cFTp1PPFTKYhcDNsH91vykBHzuf+0WuQenX?=
 =?us-ascii?Q?oiGHPEnaQJJreEYSFo13WOuvDA8DIspTvHf15sHz1sPxw/ekkG7KHDH+7yqb?=
 =?us-ascii?Q?GCmouvGvqKUg4rPvNOrOmLm/hwrknzNheevJXyCPiW1FxkkwuHsdS4s2e9L2?=
 =?us-ascii?Q?5Rnt7S+SjmzEB7sgL6Ogc2Tt1gP7Wqfoy+yORN1FKvg1RRuLO58H77BtS5A9?=
 =?us-ascii?Q?c5tVzH+ErYs5WtaTczKQFu2aF9s1mgwNS7utCPLAjMdYZf0uIcXU2O+iIjg9?=
 =?us-ascii?Q?LTOOeO7LG1VaT9yY3nTHkSlklibv42EuU1V5FKJfPIiM2lhat3WRzsvfmnai?=
 =?us-ascii?Q?Y2OC9qqDqMMHUmQAKSING/H+GxWfpd6r6NQZpL2MZw5I5oZ8wMiax63UTU6c?=
 =?us-ascii?Q?J2us6K/FMYATKZCaxWVzTnwpjLuy7TFbq47P3BgN/duQs2IVuBuc0kMVVfcA?=
 =?us-ascii?Q?9KkP6u4jkwfabNwdkacYK5UZMKvoOCn+IoVPi+L6dbLRxGYyvwdweo0azALe?=
 =?us-ascii?Q?jL96iaJNSS+00Ga7v6YPhk2PHWNHuOtGTuD51y+SkJOnrp8QDqSXYDWDZTW0?=
 =?us-ascii?Q?7MZA59C5xcjVXSRdSapmJzk8BjAJB2U57tM1phMLOkHQYJ340gBoGwx2IPJ4?=
 =?us-ascii?Q?aHuIJvFg5hiQbXiwan+dl+v3zudxS/DOJcrxubWzY8C0/Lk2njmB9/dgGSCy?=
 =?us-ascii?Q?spU2YYo9kv8Ka+5rDl1YTo8E5z5P5WXZMkFFzvlk4AMR4Gl8cQFdZDU5fIPt?=
 =?us-ascii?Q?TRO+3lm+U+YIGGUa8rK28bXFIh7FmHK9CXYCdpkYpjlvWB20zumY1mtg6YCp?=
 =?us-ascii?Q?Ic7lArWbmp0+LqZcxHXJ93okcyT2YMUACn5WsAPcFsCTrZxuSX+PBPDXT2OL?=
 =?us-ascii?Q?JlMKDmpfiPaQCA1Ycq/Bliew6TrzgRMn+ceuPHIUiJDS2EbA6WGuvveRIYwM?=
 =?us-ascii?Q?+NCB+ARmOuaXMfEnP5apUJLsSNOAc+Ia7Jd86ZY8IZU3FeRaQbcYY2wm/9qR?=
 =?us-ascii?Q?dpN/HwU/Kir3V+PD0eOlotupNCdS7hfSD5Nbf5+Mig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d7JXElPZhxNICNk+sq1nXmKNU0YNG54Atn15x9RprmxFAi1xu/p4dLWBNnx1?=
 =?us-ascii?Q?ZFEAxwvnhBIVN61peMA4r9IKtE+hqYTqASAYI10/SfI6fal2a6+45jDyUTk9?=
 =?us-ascii?Q?M4x3YwldTagkLkrCV54kKeayi87e9g25AkJX4MfLaL3UiCshBlUPIHJOAKL0?=
 =?us-ascii?Q?t0+7wawHbmQSGA5HuWmy6sOV5ulGzymh2Gfn+9cL5stOo0ERTKvjcXY2kkpY?=
 =?us-ascii?Q?2CnZWnv1cP7kBM9zLBi3aQo3NsSGbzjgDR1Fr2GYbsa70vSKteHIac56OkdX?=
 =?us-ascii?Q?OA7Xzba6QrXJoCj3S7cjq0DO4RmO/JgHLGXkyRvfkdB3RRBc9Kk5QWmsUiGI?=
 =?us-ascii?Q?K4J5I3cU45p/XHfgoS/9wzKyRSIYle+lNGmUlpdSpo1hvX59pbHI1ORjvwFc?=
 =?us-ascii?Q?CJJzg5GlUIpICBZsgXIkT00KI358RwmQRoJrpmPu9RmQcW2oAr4IY+UPpQTj?=
 =?us-ascii?Q?j/Vx6X8UMETeooXMaC2aMkMs6BvANEFe+pqKTvOuUnd2K1KkSL2y1vMq6ATm?=
 =?us-ascii?Q?V3IzuSB4dEoN0gUPFnEY4DwZMy21x4zgVYI0koMc9BL0MOp6DmFa4Hy0ZccZ?=
 =?us-ascii?Q?uiYHKdQudhLaTylHxP2dQpXfIjKg9oZ4Tg8o0tJtT9a/7oD+MLNX19OJvE6M?=
 =?us-ascii?Q?cTwlCRQxZ5nXH5Tb5qZaFq5ax1/N6ZsceoJtqcaysjc80eVNPmX0gsFW8PJm?=
 =?us-ascii?Q?/ZZjobiK0of8J1k02+aC4GPXw8548ODLHnrcRVnWEPJtYaH+2xSRY0C8VBCm?=
 =?us-ascii?Q?80nJRSXDPmH2mEK3elTy91L0iYPeImji5auXUU/4/EAXI5QjJJGSD5IpJcvo?=
 =?us-ascii?Q?L8YK7jaLEuGZh1s7Bxh1hc/Opbr9C7gDJYTlhI4TB4fk4K9I6nxC4VoXxZS6?=
 =?us-ascii?Q?C74a5IVA+q8l1EM0hki4lC2eMCyGTtGt4oUoSbflDPSGKnRZEcYM+8sIWb+l?=
 =?us-ascii?Q?1Xc+auq+AP4nhT4nI5CDsJKWYPR/84runqUGaulbodHsTteZFjqcpPLlI58w?=
 =?us-ascii?Q?cWHn5C5pMGnh3I0S6hcEu73M3ec0ZPK6Ar2G47ER6HdIy4beQTykONrwafLd?=
 =?us-ascii?Q?M1515+UBcYE+iBj7N6wO/FSwZBybeVhtS53Ic3e7C9ffTETmzm5ApGVhQNxz?=
 =?us-ascii?Q?imFKYzUDS5VSLI9HS3A+QV84H/tlmASlnXwK/y50OJoXcvEzC54lvPyY+B5G?=
 =?us-ascii?Q?mAqvSSERANuk9iJyTJhH1b+XCzGbWYGTWAvcFuLtejFoIjkgtybLn3sDMeTt?=
 =?us-ascii?Q?mUetyW58+2NSbH2mok4oOsA/c8a1YCI7Mjj5YlGWCNUxfE7Kh2gaMMkhYMft?=
 =?us-ascii?Q?dW6QXtk8LEsXNcsBN9P4iMzB+35Y/CdXDt42SC13hZWqSlkTRwsELMjVzAjE?=
 =?us-ascii?Q?zMzz3xtAlm/dG/eKXrcJCwCP/xs3Of9jEEBHJw45TlCEkySrNq2EGfedVlNy?=
 =?us-ascii?Q?f1E5D3eqrlHr8UCblyAbdiaims+eY5n6B8hdHsRjp/miCc9DPb7TVyhwyIjS?=
 =?us-ascii?Q?9y2wWVREiqNmxCAr6ic7rAvuXuJ6PbSVZZBFgSJnMah/9qdia+Y7WJn1FlOM?=
 =?us-ascii?Q?JTiXvciXQYkc7vcwmJc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bae6f33-e77f-4ccb-6c79-08dce2122d4a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 12:11:27.7943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4ZkfSTdpaULvZXYpP3bWC4y+f15Vt+8kDIGOUR0lh2XYKe8tyLe7bjJ8yN8Ye89
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8465

On Mon, Sep 30, 2024 at 07:55:08AM +0000, Tian, Kevin wrote:

> > +struct vfio_device_pasid_attach_iommufd_pt {
> > +	__u32	argsz;
> > +	__u32	flags;
> > +	__u32	pasid;
> > +	__u32	pt_id;
> > +};
> > +
> > +#define VFIO_DEVICE_PASID_ATTACH_IOMMUFD_PT	_IO(VFIO_TYPE,
> > VFIO_BASE + 21)
> 
> Not sure whether this was discussed before. Does it make sense
> to reuse the existing VFIO_DEVICE_ATTACH_IOMMUFD_PT
> by introducing a new pasid field and a new flag bit?

Maybe? I don't have a strong feeling either way.

There is somewhat less code if you reuse the ioctl at least

Jason

