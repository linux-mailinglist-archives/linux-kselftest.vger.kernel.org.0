Return-Path: <linux-kselftest+bounces-19994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFE49A29E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D781C2098A
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 17:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4BC1DFDA1;
	Thu, 17 Oct 2024 16:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T9TU4spi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4DB1DF99D;
	Thu, 17 Oct 2024 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184046; cv=fail; b=KD14yUwKc6dIV2wXkm6Bc4eMxMQkC009AtAZXkug0vx1f1uKuzozd2vtZ1cHW8vxLQdTm1BQuZGe3ol7Vn4M/+EJjUqLh75yfWVfbjKwjIYENSfn0UfTYHRUW6Tv6GGkbuq+sLkWTad9jAPh8WhSbJm0YsOL4eXf/SOojDMsq60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184046; c=relaxed/simple;
	bh=S5vHnN8MMLX9Z6Aon4AGEMiAaymJ4WScqZzABP/zrso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A+sdd1iRsQWyGLmwmyqNB1E32sqPrF7do8HGj07fSm+v1RN0fSlI4YipXYEod7nndlREbLaRREA3KJ07Q/lOQuzlBVO3785lmNirWIaGyJCac7xP8oc1lMdLuvOkg+IrUbFx5amqpEvlG5byWHpOQfZSBWI+PEeAdj4+zoMxG9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T9TU4spi; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCTYmeE7u1p/IWUlZ8tX+BnxIkKDiEhbgvKx/9G3uBHwF/OOoToWF3+q+ZFXh5AYT4+1cwprQT7AhcdWocx8j3IqGHRw/We5MvG4/9p8mBWMmxXTOtHv3KNo0rXcnn1vRwxzAhZzWzrh3J+l0JopsQe2eM95P2yWTEkI3pWM56RIsMpqRrUAcOQqRTtG6xGwPBVOslXHgmXDuHgdhVADEe+PjZHhq7m7CVC33QOY7HhiZMLhGDZwxTYzR9crJhb6luPATciJ+a3lJwst/K8iAQ/OtLRVoIuZb39TpSRqCIDY/f1lQZ0YUWEEiPjYmJjQ6rjqtIx9sQDXyrKTym4nbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DfQYKhKNXeiOAwE+wo5TY+XKlmDHc4gQ9agQSAgr0Q=;
 b=ey9NelhqzCwwZDfGQzW+nNiL6j+GdmJsWQJc7DaPHJTK3KIYj31Au3OXknDFHXK2FLs9sq4f6LBQ7pioFHOyG0WlSbgeLqBr8KkRxMceT90WbFNr+9GrF8E/cBsZGBe7rhOEtaET/uznHtmm+tP8MdIu+OaFaWwTH+O4Kyclke1fw9yKHxi2b4MswScUUySEhZhqJiicCFlXkyKWoS7R9qm3ueFRZKmeW4YLpFUSa7W7oGQbsmxMx449csNU2V8OOirP7wO5ItpQneng2a1gLSU0fRl4Z6wM+OXfeQC3g18cDJ2tIK4XpRcwZ0vq+MTPWB5QahOlC1oNx4XU8XG99g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DfQYKhKNXeiOAwE+wo5TY+XKlmDHc4gQ9agQSAgr0Q=;
 b=T9TU4spio8h5UtxpbgcmxVYtV71lXVWcmIW6vAEi7NisqewQHpPhdBs49XwTnxZRoxwEZh2TAvWRvvPPlXnAoHW7P2VJaThVjam6VIkpSvrDT4xIuAOVPxWLuR1e1oueCIzRdC/Mce2Uqy4RSSDtlGqykXxiCY2zmp3rOJsC3eVv4cvTUAbmRFGVXydbCC9tgkeHJDcVLqIMDSPc5KwK4v/+2jz2Pg5Qc/5ePXZYGKAE0Uw53DY6gKo31wninBp4g0dyl3Ru7B9IlsDoty8RNA/NnjLgGhvOl0FK+zIladLx7KoCnfgHiKMEjVKcHq96ZeI2J1HnhVM9flSJzNz5uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Thu, 17 Oct
 2024 16:54:01 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:54:01 +0000
Date: Thu, 17 Oct 2024 13:54:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, patches@lists.linux.dev
Subject: Re: [PATCH v3 02/11] iommufd: Rename _iommufd_object_alloc to
 iommufd_object_alloc_elm
Message-ID: <20241017165400.GA1041092@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <dbfc718cd3200071765007c7ca0a2ba242181d05.1728491453.git.nicolinc@nvidia.com>
 <20241017141416.GZ3559746@nvidia.com>
 <20241017153749.GA3559746@nvidia.com>
 <ZxE3U+9lUXwDEBx5@Asurada-Nvidia>
 <20241017163507.GC3559746@nvidia.com>
 <ZxE/1+Pe82Rrjd8N@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxE/1+Pe82Rrjd8N@Asurada-Nvidia>
X-ClientProxiedBy: BN8PR15CA0072.namprd15.prod.outlook.com
 (2603:10b6:408:80::49) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 62a77d83-faf7-4f2a-99f1-08dceecc4d1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GEzK0JmcMvyd0xY6M6Q/cY3ileh69p5uOA+YGQl9MoEchiDjE5KZSCdwxGr6?=
 =?us-ascii?Q?lJJR8OAfWZg00nRzLmUeep6aY7wNK2Bp91hKfuP9yIfGyVgtLe+e7H6mBsJp?=
 =?us-ascii?Q?epeYEWVUOfCLJyXpPunuSfSwASPblRNesgKdNsoNzlXIUHVz/WsNxhEdw/yh?=
 =?us-ascii?Q?vhw2F78oqFfdXXZqNwflPvZ3dB2eZsxOul/S6/v2NKjhz4wF7R29pC0r+c77?=
 =?us-ascii?Q?+eQGq1xRZ3gDvOf5Hz2sd44OaTTp1NVWtYqXvaLQvRZmzBB40QFlrHirGiJL?=
 =?us-ascii?Q?cvIjeAsKCnStlNegKWEumMeYcA9n50k4hsshKOXIXELuKyKmwoNwkEuoZ9kg?=
 =?us-ascii?Q?S99Mz2CDfMi3Tka1F2YIj/osxCiV7WRYyDKotT/Hqc6z3972pjGsLoAeiLVT?=
 =?us-ascii?Q?oI2BscchZGyOpHQkVAxjARqTR7naMn9eEPgDsnsNWggGnS3xLuyTNtB1Sz5z?=
 =?us-ascii?Q?XU7md/kkGwCJap0s5AUcmglWa72Rpo1tbntbyeQMKKmgk6KU5Z2MExvvd5DR?=
 =?us-ascii?Q?OchQDrGvc0UijLNHkiijal/ZrO/5q6smRxQZy3IDqgigXo74QPy+8g53482m?=
 =?us-ascii?Q?sXUJYsxOpBGsAjRamaYGrofq2nDycKNVghrNZv4God+o62nMJZGNYcSWBtnh?=
 =?us-ascii?Q?1xZSVf4Es0cXgRMT5vuDP631EzY6cMfyI/NS8xeZOGTvLN9TIsDVxJ8wtZjQ?=
 =?us-ascii?Q?/m2Qp24IwQPx4Caqt46Vpb76sGYeN9Vq11pv2WunTJA2z8uspn7fKznFwb4o?=
 =?us-ascii?Q?OIUjLfOTFvXDbpBCFzCEtvYvoI2q8qqzAkCP7NrJroCGbbM8Xf5t9U7ibW/T?=
 =?us-ascii?Q?/CG+0rtK+SST6u8e5XJGOdq8TaOsNxflH3VmndqL5wepEHWE5CqY+4wXrUNB?=
 =?us-ascii?Q?r7zfGBJm7sWcUCQpvmw0WI5F6+QdNTHuYrpc6U4CoHLcPl1SJLKYlckxq0VA?=
 =?us-ascii?Q?75tHVaRyfPqlLEHdIbxHOkmZbczg/WpWEun4jH97loH06+3K8iwSliVcWeS5?=
 =?us-ascii?Q?FHLQFrard1BbbTiDDmqF9OBsrTbj6iYRwfQPq+KuAnxbOBIOcBJ3tK6YtAou?=
 =?us-ascii?Q?jSIQ/LDLDdGMEjACTFHx/Yl3iam3RNC2kGkFWIjcKUHOX9kZ8+t8LK5lPBbm?=
 =?us-ascii?Q?0qFuA8/udsRW7kE/rylQf26Qitv32zTwv9BF5xWpUQE/mj4JqYPNDN5UD1gP?=
 =?us-ascii?Q?Jj1jjKiGVL/OJ5hZYTWnUTQf7Rr66CkW48ycR2WmlEgWlVjzll5pkWyUtmf/?=
 =?us-ascii?Q?LMubTy2sSjs57VNG2hgKceUfeXHo/g1QL9rUdJQ4VjX5jSVQ1JfZNELuaQSw?=
 =?us-ascii?Q?V+inK1RdjuzZrgrHFTsKfO+C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9tNFbSq96gdjTkwzDp90f682B+krUSsYG45JN/hmH+UWsIOWco9Po6QEdhRW?=
 =?us-ascii?Q?Go8nXR0nFlBdauhv02sERSeZjD3Hen/bszLDNU5tjhcf7kXGpvh5heAYKDzj?=
 =?us-ascii?Q?JeADnyDHm3mockZQdyHXP94kC4ED3lZZBmeOZVqCTpXrPd37Xt9eOP19yC73?=
 =?us-ascii?Q?gOhVyFV6TCisRBdnQqQQQBCrgYmK97u5+k5+9HRXQiymkR0jYvJkGzmcQqIi?=
 =?us-ascii?Q?jPiFZ8JDYICpepeFl0sf7xGPWDjHYMU+qJPAL+UM7QQD9cU74ardrv0VWGJl?=
 =?us-ascii?Q?+qQ656kxyAY1orSzUUyEaRQlH28XYHyb5D5U1VvDCQ3bX5AZvmzKVqqpbH7M?=
 =?us-ascii?Q?dmQdIyB9ou6B6vPADSPSn26aEEWbEMgDcrjqKhlYcOjz25IZ/JT9T7CC8FFX?=
 =?us-ascii?Q?CxFpJi0UPJnDqP5tvCoJfh3OFyGtxJYax83CJZBcOdfJz7lF1scymfkOTtdI?=
 =?us-ascii?Q?UlFzX0zUzhkwqlB+V+v73zCJ0y6YehL9sC817Zvetw3Em5QC+HFvJEjWvOUE?=
 =?us-ascii?Q?Y76bedlFALao3RWS5SA/xUkl8Y+3b2FYs/A42AEY/38gd25eqkStOYvP3FqK?=
 =?us-ascii?Q?g2whAa6m+wqEoCuQ+qHdmJLOkdkNMMwgt7s5AvcDi4CYeg6GempY4c3wBwhJ?=
 =?us-ascii?Q?EsqJuOuMj3S1qKCCb8UP2EIBOKCsW6fVmVVa1LdTcVj2A5XIqG1VzX3sJgLH?=
 =?us-ascii?Q?QmpYBwpe0r4MWLZXMv3o9ONWL+hDrRaKOb2hxt9dTlNndrGm5eRPbBp42rPV?=
 =?us-ascii?Q?q5n+TUl5su+TOEnF/k1QMtVb9P2DdNRgF6Mn2gwZPJhaJMaoBaaYJRCEL5M5?=
 =?us-ascii?Q?Y2C9GTVnVKgOUs6fuTig0sS6jLTnuhwqi9xPhtrUe+DgY1w/vusN30hqXHJ7?=
 =?us-ascii?Q?9/A35K0vVWYF2smmV75OWAytlUaT/NvcbTf4yPCnIrQJrT4AOusIFNmVa8Fv?=
 =?us-ascii?Q?lGEvO9auODia/V/pXPH4sN6JYysN71kxdw2LiLRPzDofCIXwFmn0J4S5M3/o?=
 =?us-ascii?Q?Vh6YFtIYtIXDfjKnG6vuPerpWwhCCz217LAvQwKaioFWUKsP7g7t4U5X95hr?=
 =?us-ascii?Q?NhNODPv6djA2cfR0o7PcTPq794CLodrh3kATackHaw+bTiAxI/m0jCF9XAFJ?=
 =?us-ascii?Q?6QXFb/UTRJsHBTiuBMv5iKWLY5qvcSVNWHFt/lYHcOW/QHmvUJVzL2elvksh?=
 =?us-ascii?Q?s37XR1PQyiC6xlNE/3Raa44ajMNp77WKzNY9KECsMVDCKzHTmhsGFqyGcKXo?=
 =?us-ascii?Q?i4BXOHzwDIEmq03HR9Qr4KNLcZdtiL/z3OYoRj9FI2GsDdWusHcPL0E82M2+?=
 =?us-ascii?Q?mAVGLIgpFuVVkWUpsboIi/CyCgDun45ZYDaTdkhSHL0u5gKb5d22hCG5m1Il?=
 =?us-ascii?Q?MkmXe3J1Zp7509yD6viliIq/Kanvw186oJAtDGh4Br3B8VSbl0NDQLVB9XpO?=
 =?us-ascii?Q?iGVzbtOKl9HWFk4aQDpoYb5cAHXqUOwJ1kHguIR+pJkrPde47bWonpZmNMVS?=
 =?us-ascii?Q?cpMK8/S9oazOtL+72DY03VbXvfh9mEgUmcAjIbAYjHlrBsZtm7QQ4U+40PlV?=
 =?us-ascii?Q?XKMhZxQTzIQl/3dn4H4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a77d83-faf7-4f2a-99f1-08dceecc4d1b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:54:01.5932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xauE8AqPsbbxfaQmUCUWQ84gcgwCbyV8On0InmXdIgfG3q+yyX5VB46aUp6KlwJj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7795

On Thu, Oct 17, 2024 at 09:48:23AM -0700, Nicolin Chen wrote:
> On Thu, Oct 17, 2024 at 01:35:07PM -0300, Jason Gunthorpe wrote:
> > On Thu, Oct 17, 2024 at 09:12:03AM -0700, Nicolin Chen wrote:
> > 
> > > > Then you can keep the pattern of _ being the allocation function of
> > > > the macro
> > > 
> > > If I get it correctly, the change would be
> > > [From]
> > > level-0: iommufd_object_alloc()
> > > level-1:     __iommufd_object_alloc()
> > > level-2:         _iommufd_object_alloc()
> > > [To]
> > > level-0: iommufd_object_alloc()
> > > level-1:     iommufd_object_alloc_elm()
> > > level-2:         _iommufd_object_alloc()
> > > 
> > > i.e. change the level-1 only.
> > 
> > You could also call it _iommufd_object_alloc_elm() to keep the pattern
> > 
> > Maymbe "member" is a better word here than elm
> 
> Ack.
> 
> level-0: iommufd_object_alloc()
> level-1:     _iommufd_object_alloc_member()
> level-2:         _iommufd_object_alloc()


Keep the pattern:

 level-0: iommufd_object_alloc()
 level-1:     iommufd_object_alloc_member()
 level-2:         _iommufd_object_alloc_member()

Jason

