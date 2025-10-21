Return-Path: <linux-kselftest+bounces-43660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC25BF6F80
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 16:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E07518834C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 14:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E60F338909;
	Tue, 21 Oct 2025 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Out97IVd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010050.outbound.protection.outlook.com [52.101.193.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44A032D446;
	Tue, 21 Oct 2025 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055638; cv=fail; b=ZMrjOSQwwDL+OWCRbxKj/+tKzL48mYqRj//0eQmhhs42iotUy9/nhUNr8jeSq6wGTPsaxweSWEc584+jyR/8SFzV1HlU34c5AqS+jz1PtS6GyyJT7QchUhFjOxhZUNru/v3lwuHHV1VstfBti/29WQJdq/TYSwqel69OgAlo9o8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055638; c=relaxed/simple;
	bh=yCjZVS5q1PwhlDJ6b0xBiY4ujiS7YtGY5ofgM4rPYxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EDDZbdVN7GIliMsP8zCFaK8zIAXqBH5E8SrB35GWqHMiMCZE+VMAhMXEEtazI/4rj9XbLeOJed2qQLnI7GNJKICjB22eQ6FfQs1hnL2THEV9J8EsTifCvGxmg+dTIEIzq4n4kcQ0rVji2YPgm0CHQRTCA5z4781Tf7UPW2qlxAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Out97IVd; arc=fail smtp.client-ip=52.101.193.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTfYDEq/fUzszM2PmPSRrHHB0geQSyp1dasudhJvu5igbzIP8oDCh2xZIUhMBLbm0hlz0yimIRnKMDuwCf0aZ3BenqYD3Qm96nu84xPVWSVG5WrL7/GJPkKosGDCXfuihdMYOBhJTsdr6w2gR0fdG59PNhUQPQU1ANr8JLqOwE0rQkPiUJODUCobkbgey0a4eykbbOdmNmpmFBpjCijR10GxFxyd/gGU10rcn/sAMgPGpbddSvBQNyT+vP4xp7R34lr3I7/YgF5p56gb9rwEL0TTo4M0BzFUhn8pJtw0OpsOBK/Z6byWTTHG1tXKQj+iGrKh5A/nIcl1PiJWoMaozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imeLNZ7Bpd5sjf46p3aay1RpCMbjULqrmh0HHSZEJ18=;
 b=K96TXveMPloe7KcrVhO9bnp9hbNG2lJdCyKRDjkF1Fpbj11lN3daeuxSXAIj7THUjhvAQMk2fSRCQuBxWe3g+qJTzDRYdxkWlcUUI3Db5mWyzpwyO16Fbhdg2H9ur0ONUnMAyIehR1B59xvGWlqmP/JjXHnzL5Ebroak9hLl6AsMbnCp0BeGXN8ACDLqKgzN/y1oqPXyBkdhttJrE5IfkCnOTeFqRpxfyBnQi9dEkzxQUxBdzX0ysIu0penzgXojG75yOIwT78lYwvWstOWUdLSZ7aL7HwFwhj9YwHS6wnJAnGeiEc2XA0tpLod4WFzOGqcUwww1SoMQ5QQljQB3gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imeLNZ7Bpd5sjf46p3aay1RpCMbjULqrmh0HHSZEJ18=;
 b=Out97IVdy5PiVHmdIKqcQeCYInYAdDCBQCchPSx2tDOpDPdNPdzBI/dpdmcXVGlrPc8rIg5u5Vcmh0me9r0YLIoMwYhSQFXha9zbufyk/0ftLFhv3n7N8CwsGSbZaAGEe91qmp2iQv1I/M7A1kQN+gZxOE7lLwS7GsfEV3ApfzsitZ4hWAyvQDqCrCqAF7xJeQiBv4tCZVEBND3HFKK2yEZ4uStP48fOPeooASN1Es9z2MAYYT6BwPs/KFU61AIUzOtq+Q0zEltehy01V/c3aiQIu8iIWbfh+puIAiM2dH1s+f3hy2fAD/QsevKfkCInw/ERq5E+AVKrDPLTFaEaYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3604.namprd12.prod.outlook.com (2603:10b6:408:45::31)
 by SJ1PR12MB6026.namprd12.prod.outlook.com (2603:10b6:a03:48b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 14:07:12 +0000
Received: from BN8PR12MB3604.namprd12.prod.outlook.com
 ([fe80::9629:2c9f:f386:841f]) by BN8PR12MB3604.namprd12.prod.outlook.com
 ([fe80::9629:2c9f:f386:841f%5]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 14:07:12 +0000
Date: Tue, 21 Oct 2025 11:07:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v6 03/15] iommupt: Add the basic structure of the iommu
 implementation
Message-ID: <20251021140709.GE712833@nvidia.com>
References: <0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
 <3-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
 <BN9PR11MB527642E4F4290938CCB4BE8D8CE8A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527642E4F4290938CCB4BE8D8CE8A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SN6PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:805:de::29) To BN8PR12MB3604.namprd12.prod.outlook.com
 (2603:10b6:408:45::31)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3604:EE_|SJ1PR12MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca3359c-9aff-421d-1426-08de10ab215f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N6CxyZtLHokpaZwTkqn9+UmpTeCx1EKVwB5HbE4kpOF19CZG9Q1cMkEyweou?=
 =?us-ascii?Q?Pmm5m2J1cx92dh2p4FJETAM3ULlc/4BMBy6xq4j3MNamkVFMf7Hklm8DG4+j?=
 =?us-ascii?Q?bquV3IqtBVhl5wnexuYSokriPhUWRWKJ36BBHt36N6tzdSKpQJxzqU3TrX1T?=
 =?us-ascii?Q?sk9Lnbz18q1qIdPDQokC8Yhza1J2kiJCsAXHEnFiSs027cQQ1mQS9XBnDnHN?=
 =?us-ascii?Q?cfkyiIbMdlfc/136IdkMCj4mqlODHijTgWB9wjWSMEZ+Qx19vfdNGw3K/6eT?=
 =?us-ascii?Q?cCRI4qStftJuJ7lSoOdxd33CUI7rXY3fuD7hvwwzY+ra55+OmJdSIYAnucyn?=
 =?us-ascii?Q?Pt7UIOEKI7RLTGQEGogq17fxbBJv5YlX9uTO++pRvYUs/yRzluwFv1Ynv8kj?=
 =?us-ascii?Q?VEEMKuNWNPCRiIwXdCTMb3rg1kjbglzWj4PuQh2eJ6YxJw2pbMLIgmbKvlq5?=
 =?us-ascii?Q?VbbkIOpBQuxjn+xja1/HKBC0IE/URrTVIohYWOY/zTai+HaGwx1qXziXnqrA?=
 =?us-ascii?Q?3IjUnK3zDt2qWb/5SlIhoUiTQiB158WB7Ghq6H9NXTskY+uxTLugC327RMWV?=
 =?us-ascii?Q?MKvmy9wxg1z+pDCnv5ksqjwCw3nbognoEWqb0TVSs36CDf3P8modt7hhzoL6?=
 =?us-ascii?Q?pI1JJa5hNxOULfC4pfO+jJyQwjB8kUz7CQOSFIGRf9Afqi5ECI4YuhYn/+dK?=
 =?us-ascii?Q?Yb9RE4a1Q+0tj9v2dNyJrsuMeDZXGextzKjNdIAaT1zsMOO4CNQyU7xmf20E?=
 =?us-ascii?Q?inDdG5Phk6zzUc/3Qr9BJ3QkHKOHuIYy4aZ7DKfu06VItujkT7DCVIKZlFwY?=
 =?us-ascii?Q?gweaxPMvo8mGUDrD9nHtOIdb1xWC2DAOETgxpCRXu19Ez7DP8Z68D7WxJi9l?=
 =?us-ascii?Q?jjtSR7jt2qkt+BiCUoTbB8HuUTE1xR7HLWDbwLZCGLt8abK98vqf1p+G64l2?=
 =?us-ascii?Q?PbAVMdSAJYre/mSwHdSRs2M043JI4jqJ9xwVL8j/FmPcVw8Jd1mPBTIiWIad?=
 =?us-ascii?Q?ULIlbHbeN5CNjnsPdCf5PEE31MLGXjImsczQWUyK/P79Tg8DZMzzH4SLQCia?=
 =?us-ascii?Q?IrPFNanlGyG0Rl5gayNmdcjjzFteMfbTCTpwFajLX8zBdVbxciN+p9kfEAMz?=
 =?us-ascii?Q?4F1KGG46dr0iD+YgYvM+eOeHip1VwzYGh2+fhrIBHNsfcbdJNoKQJ4lbQWkr?=
 =?us-ascii?Q?oEF3WvLm2sdlng/c89Qlh6g+3Cbj0hrdQY2UfkqtY6tiYd+aMue4TsV6q2gY?=
 =?us-ascii?Q?Kpu4RJRAbJArNKf8VN1Tb5xMfIAZsEJ07wxSydRVatJXjHPQOdOAQnPheNma?=
 =?us-ascii?Q?+DjyZx9EJMQdjGn2cnNixMk+3gWHgoPNpQrAbDIrz/L7DTbPP30CIivgHMNa?=
 =?us-ascii?Q?/WJHCkidz1xOSY41YPxuywKIVfrDU3B6CBCmw4oic7sIK4399K+fAMrPhe5P?=
 =?us-ascii?Q?41ZfKhguqzH7ZjdkWVuTUXfjVbZF4ip7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?six9c+9KTjC64mTQ8JQCcC0o2UnB6pw3o5/8Dvl/0Venfp8hk1/aRNfs6VOo?=
 =?us-ascii?Q?JmCylaivutgpxFFpuSGahwvTBUHywH2ZP5XprMN/1uIAfe27lWZvRJAKJTCy?=
 =?us-ascii?Q?jUIFGyilSjEuHS85rPWAhSN+HNs1sjIeqiWN8dlPVIMk92W+PQDUO90YW2Ss?=
 =?us-ascii?Q?TXg4NmBiemw5NeC9IplPkCet8n9V1NlHZzbZGq+vwvAYKKGh6Y4pKpyyRLNn?=
 =?us-ascii?Q?q1dXuTA0einMlkaoJnQpI3fU2KiDMcx3yn97D5IuiWbL3Sp8urfrAxVrGw4B?=
 =?us-ascii?Q?+tVkyz+a0P2cP6CDwgNR3eKsVm6cFm/pakmBlnIfClYj7XgHk6gNTBuGp790?=
 =?us-ascii?Q?7DjSgVSGUmZaP5r1RhjEEmyXmiJJKcEnDbipW5KLQ8omv4tE6/IR783rxgIy?=
 =?us-ascii?Q?wNxLZJINeSQp5e+4kGAxxBoSupPkZrrGeD2tX80gCzkIk9zBT3punTMp8CPE?=
 =?us-ascii?Q?d0PwXgr4cQhAYmOkDERue0tGHTsmi7guiXEvw9Aojb9VHB8EHjekUy72ngRA?=
 =?us-ascii?Q?ATKEkPSovmINPAy1zj6uv7A7FrLy5ZwvNR4UgcBeE+4XP7TQ6gwKimQQYZgg?=
 =?us-ascii?Q?c943oPoZn6GWtJd7P1EKDXfXeS7twG2t8pSciO5DqDK8AZBn6SCKMLLbqj8P?=
 =?us-ascii?Q?tdr01hr/u9vU+v5rk2LxVyYAUJs28W/ELUpHnfA9HkRS7nj/SY5tnSrFM5SD?=
 =?us-ascii?Q?HJ2Po2lE7aYGhqwyeRu5R/7ch8pvvXG0MAVLUlZrwG3Rq5JNjDaG3ike5RFX?=
 =?us-ascii?Q?noNw2iCpqcHbvOzLaD3AbwYTsYUjtxMTcbt897pHG1dg37CNgoCRyNxGZ5O1?=
 =?us-ascii?Q?SsFBw0etIA1UG9PbopORZ6X1J3JmoJO2nnsrsFn9GOZtAc0XtzgBJJbD2+3P?=
 =?us-ascii?Q?Rmxdd638Xb1B3bx0Go+Y4iZMV4p+54u8pDL/cKAuRsBf43ARJD17H5H9Qj0T?=
 =?us-ascii?Q?6uhAy1oikYqe72himPlog0d/dS0Ex/+wEr18oF3F2qflT5gfKDg+t+78fn1Y?=
 =?us-ascii?Q?HY+QPVZb6zueGUBjDHP9U0u1b71q/skbFdoOGfYQesDmWwgPzKKTaa+/GKD+?=
 =?us-ascii?Q?cersywkPtM4TXMl5NlRpAMcowLlqvKk8E/Vk4RF5ngrazR9z8g6/ScDpkCCi?=
 =?us-ascii?Q?qIo3nkWokNFS3bOhhtSHjxCOlKa/FdssFkdmqKKSe4UEIblFvPSxxJAO1w08?=
 =?us-ascii?Q?INbhy/+KxuCwlVe+cNXn5EGdhWXk0eJRuFeJIAHTcJtt1eXpUU1IyRvLM9U6?=
 =?us-ascii?Q?tpbcHfWW0+3oiegIkvMPTEbPbphZJah5pxSfM7g6MHMbn0ct3WPUnZaAkGcD?=
 =?us-ascii?Q?kZv8k/X7E9YxJRq3dlWVaX3FzS3KMB599flIQ+B2l0z4dFeizzsZtGsbE5sp?=
 =?us-ascii?Q?YkY8zrXWDsfTcxJmyROqDGNvEWbkHewJ8viFMacEVQcgZ7di4g8zWk1Lx2SB?=
 =?us-ascii?Q?m9JCRrqxjUlbORPjvxabiK/y5gcobXWV7QQzD6ezvy2644u01RhnsTPoC0dH?=
 =?us-ascii?Q?op2VZP1q/5+ihfwE9xgEcJTD9LNQA2NJQqequU8EWe1HiIgSkYR+KoByX8RV?=
 =?us-ascii?Q?7drcG9vWd8tpWoYgJV21P5SuJY0UZGslZzGkgwiS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca3359c-9aff-421d-1426-08de10ab215f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 14:07:12.2825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MBzp3b5Q9ru8EPLiusPk9ILiwqcB2hzlHXE4o5F+YvbUL1cRwXUskbvpvu4Pe0t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6026

On Wed, Oct 15, 2025 at 07:25:49AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, October 8, 2025 12:12 AM
> > +
> > +config IOMMU_PT
> > +	tristate "IOMMU Page Tables"
> > +	select IOMMU_API
> > +	depends on IOMMU_SUPPORT
> > +	depends on GENERIC_PT
> > +	help
> > +	  Generic library for building IOMMU page tables
> > +
> > +	  IOMMU_PT provides an implementation of the page table
> > operations
> > +	  related struct iommu_domain using GENERIC_PT to abstract the
> > page
> > +	  table format.
> 
> "operations related to struct iommu_domain", and probably split
> the long sentence

	help
	  Generic library for building IOMMU page tables

	  IOMMU_PT provides an implementation of the page table operations
	  related to struct iommu_domain using GENERIC_PT. It provides a single
	  implementation of the page table operations that can be shared by
	  multiple drivers.

Thanks,
Jason

