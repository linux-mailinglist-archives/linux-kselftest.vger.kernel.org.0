Return-Path: <linux-kselftest+bounces-2636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B7D8243EC
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jan 2024 15:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF631F249A0
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jan 2024 14:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84325224DD;
	Thu,  4 Jan 2024 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jVrNHJDM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102B222F1E;
	Thu,  4 Jan 2024 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMcjyTBTnIlfGFNaRC9rN6m81NznHLLQBhCi6shyv823A2cORR9mt4WEcNI8t+YRQMSwYAxkStqUp0GwNsTvv0iUJFxAew7EPJQvoVRQ55QdZr0Ko7BRwtum9s0d7t40j246uSBqtIgZ/iCYYm6cw1wwltaj1GIbPaC7ipg31zULGASqJPUxfivtK7mddC2Gbhm4GmUIJwkRHOxH9jTQjvsJPpjt4DdmAg01jfy8sbNefiiF75mwEnaTdyfa4CJ8YNu+uHliIxSP5du3tToUs6JJ+wWIbHRDpZeEeNbYERncj4R6p37MbrwdMfBABQPOQ4iCx74GTAH+J4VqpX+Zkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3vHBKP0CN+tFQ/Mi6KsfDwzVYnuKaZemeY+m+2XsP0=;
 b=ZElp4PI/fBBowkJmYSDQKzu+/PjkxdtEZ3SaA9c3WEpA5xFArvpaUlkg2NaU1tp4iaYFJAybZQs/ZFrY/kL0pJtgcNRSQyCTcYNBSlmeQZGIz+pGm8r5ld1ut8QQvqfUiWPaTAMx0mycwaa2taN+V1XU72a6Nx9tJ5nlNstNH+z5KxdIswCatP6NbbCtQrSTaysfaZORyKM06tzABCv2jS04WejYDfV/cuNRP6cQblXvPkKL8SGUW/ZqgsNZXNfZsj9S5tr3zvd3k8pF9/tY3+E/3r1Va4js4W8HLhIHlpgOOe0TILKPOWLI4QljqtCjlFVk1cES+aaEDcpF+FmO6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3vHBKP0CN+tFQ/Mi6KsfDwzVYnuKaZemeY+m+2XsP0=;
 b=jVrNHJDM18UokZXbjbk65DL+1M1/WWnxQtHOvlqAvATt9JdB7DaVdnpReZBXnFCTTOm1WafDCQQwVXB1+vb0UUDzrR1OnJ46i2kt8la4JShc+CwKQnHghC9yxCrvi9VWJZiJKo8CRC+JtJFPq/kGRNDrk8jGxpMkyksNzlnUSiylj0xEpU3STwNAhZG4jmQVxS2xzfa9SEBXuN2K8OTz5fSAEBFGb80fWy0hCQ9GiGLnplDGMw29nBD9sXkFedRCoGIGQRtjvWZzfvD8kanJBsvxp7VgrterhTfHFI2V+L4mN0iiOnYd1KzN6r0r1KjAe+4dFwfpt3m+O1yOCTQWnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 14:36:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7159.015; Thu, 4 Jan 2024
 14:36:59 +0000
Date: Thu, 4 Jan 2024 10:36:58 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
	robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
	eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
	mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
	yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
	suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
	xin.zeng@intel.com, yan.y.zhao@intel.com
Subject: Re: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Message-ID: <20240104143658.GX50406@nvidia.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
 <c967e716-9112-4d1a-b6f7-9a005e28202d@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c967e716-9112-4d1a-b6f7-9a005e28202d@intel.com>
X-ClientProxiedBy: BLAPR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:208:32d::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5072:EE_
X-MS-Office365-Filtering-Correlation-Id: dc1e945c-94f6-47c7-9c2a-08dc0d329bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/w3z8+NA9mpfdavTF0aRzMkZEJqnw5tnhkBKofnO045oEnk8Rh8aP+Z5wz2L+wsNwxMDxUdqFs1s1iNxC9vqVVyiEve2OOfM26COwyp3lygHVzZEDt8wzf1DF89sf/5CldLGLBZJ3fru8baDRO/Rn0cs7Mzfeq056/OIdx19CpscBDmao89o5uKuuMSRfeHkDQn+QRrfjruXYH28gxs5t4ZG/LFJYetjpa0V5+D+lYCUlqLm2K0rMTlh72NbJ7l9/ze21hNTvGUN+svO0KfIUt6eJ9GWCRoIMAIWvKOoTeG9Bzg99velaIw4cILlpykEkJ+pQFpUDjMv0g+hpAQwj+fHPrc7ECSMV8WWsrK8JvTeL/4BLKPZbG2wHuHevzkMPDy7Jkmi4puGlDs6sQGtFbUs/kZprADWIoEg5b8+FCe7HGuJes9j/u3CcyUZvYxz23+cBDtExjlg58jni2Io/VYr5S0JCBv4RAT1CH39rG9yggYHSwKE8mNQBjPdXfMIxFJ62ltIHx6n4reKwONKfFU3Rp2IvMEFE7tWTPQwLWwv4KAW9rqYi9KiLeRBDAry
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(86362001)(36756003)(33656002)(6506007)(6486002)(478600001)(66556008)(66476007)(6916009)(66946007)(6512007)(1076003)(26005)(2616005)(7416002)(5660300002)(2906002)(8676002)(316002)(8936002)(4326008)(38100700002)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8l8o+adqCgJoKsiMLTvfKHMvNfFylr+5bnhR7b1kkqjhzbWGvaWEnkX6tpb6?=
 =?us-ascii?Q?9HWf0TGlMvUIdFRlbwEvrxAK/qkt5V9d+/iGxsw/z1E0/qjK339DD3JlPXl2?=
 =?us-ascii?Q?NkehyLkgiFSL4lHOJu0E/zhJnBjOwUYLxfwEzjHulGT9z0MXb4nzYBg119/K?=
 =?us-ascii?Q?SHYekZjpuzbl8q+4zy4fhUEpaNr802WyM+N8gPExLbSatfI1G7p2LDsm9Q7E?=
 =?us-ascii?Q?esn9i3aE9SdGW9/3nGeckORjSSy76uCdm7DcHW87b5f0mgHo6hZ0hZrerZE0?=
 =?us-ascii?Q?pQDioYbjVY9BA9NgdNcyoPPFZnvITaRKfAkfTIu/XEfrVKGyWFgCxpQCeRRi?=
 =?us-ascii?Q?9HcjCJhWVTuU5HW4RHVo/fkVfay1336VgEkeey9qjLscXpMW8kw/auzmu+GT?=
 =?us-ascii?Q?kiiM3/7J+1hzcROJ8GTP7teELowDFZ3un/VZ2zyZR3Q5vsqYgM0YF2dEiu/U?=
 =?us-ascii?Q?GSjlZvcIxkRdnNErdcgFj2BpXpK5aTmek6UpqKUkUzo7zS28bUt0lUWfJprD?=
 =?us-ascii?Q?vR4fwCOoM60+UN04Sdcgtf7SpNqiiR6FFxJ4ACkpI3fi+RaygfoAgJykvzsk?=
 =?us-ascii?Q?yNNwRja6oD4KnKC8qmETH9rMRbe5szb9SmvsyESX1JSxN1WnXx5mYmXMYDZA?=
 =?us-ascii?Q?RHZQpYu4jh1Snc76AXidPe9tSpUHUpg5z7Hur+CclNCghclnwRncbxN4ssfT?=
 =?us-ascii?Q?NbVjfz5EpNGCuOP3y+BJ2Gb9ubVFBijYv8Jno2fcy7HfxqJP6zzASaKM4rHV?=
 =?us-ascii?Q?H2Z9QrjXKpH0UNApebE74IlkbJbAdreSUAvQihcFw1IrcJFuErrt3GM0gOzs?=
 =?us-ascii?Q?omtn7YO1F2Y35gAKHGts1IREOnG7JpjSPwHA8Gc/D5pvYBRksRYoA9H2UV4h?=
 =?us-ascii?Q?6zMKAOfOwxkxGPbOo5a1M1OXlNFXN4ydWnYwu0TVxGHtCTh19vMPqeNchBF2?=
 =?us-ascii?Q?yu8pBhLA5yY22SAoYJf2HyD06QQyyKRxqWpHImrcZpSMO/p5s3LBqeARv92L?=
 =?us-ascii?Q?DJKqcMb1H4YMfObhoX4G8+Gf2hCrDaZC+cGz6uJoE21h+YRj/fgu75j08CQa?=
 =?us-ascii?Q?GE7FLdgdGCc4vxz9dMae0i2TNM5Gh51v+Gqz0lqNTkEkJpLiO/x8czX8i9n/?=
 =?us-ascii?Q?LuRXh1mzQ3XGeiiUjkOeoNpyDb35en6UF6HICDBc25B28XPEJSr39UFpDE1I?=
 =?us-ascii?Q?O21O5xctM/q1Zn+7/StnacNgt1r06cpZiTxlNgxX9gza+WQQymEt1xxB+D1a?=
 =?us-ascii?Q?fCyrh40HkIlYH8edBBwS6qWpcF8GyrH/a8NDn4XG8UjtNmHuMJiddm9SHIiN?=
 =?us-ascii?Q?NJBCw/sHzYknkNtrkWv0L6RZa4nhNGDHFgRMzgouTPGS+7Q5dY3BoLVcv7ga?=
 =?us-ascii?Q?6ZP2jYipCRWJKsvUYY3LgFcUkZ93RZiIdDAP9o2kJkugUHL6C403q796LMoS?=
 =?us-ascii?Q?5sfaFHbYVaaYHW5TbY2nI69cPf5L58nxOcIPSIUJkyOj54JQsy32JWEXFE38?=
 =?us-ascii?Q?M+lPHXjkRJ2fJIlpj23fjcs4mbck/a+zouXaiITyNec/6AsgaTQVstbl9VW1?=
 =?us-ascii?Q?PJFEDROLk+7qMf04XVkqOHnE4xSQ1hMvTOjKUakZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1e945c-94f6-47c7-9c2a-08dc0d329bd7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 14:36:59.5578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJxy1/sHJnXVg89OefCFULf6RHk04nfbWkRHb3teoDwQg57gCtVbLua2YNg8rmbB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5072

On Thu, Dec 14, 2023 at 07:26:39PM +0800, Yi Liu wrote:
> Per the prior discussion[1], we agreed to move the error reporting into the
> driver specific part. On Intel side, we want to report two devTLB
> invalidation errors: ICE (invalid completion error) and ITE (invalidation
> timeout error). Such errors have an additional SID information to tell
> which device failed the devTLB invalidation. I've got the below structure.

IMHO all of this complexity is a consequence of the decision to hide
the devtlb invalidation from the VM..

On the other hand I guess you want to do this because of the SIOV
troubles where the vPCI function in the VM is entirely virtual and
can't be trivially mapped to a real PCI function for ATC invalidation
like ARM and AMD can do (but they also can't support SIOV because of
this). :(

However it also makes it very confusing about how the VM would
perceive an error - eg if it invalidates an SIOV device single PASID
and that devtlb fails then the error should be connected back to the
vPCI function for the SIOV's specific PASID and not back to the
physical PCI function for the SIOV owner.

As the iommu driver itself has no idea about the vPCI functions this
seems like it is going to get really confusing. The API I suggested in
the other email is not entirely going to work as the vPCI function for
SIOV cases will have to be identified by the (struct device, PASID) -
while it would be easy enough for the iommu driver to provide the
PASID, I'm not sure how the iommufd core will relate the PASID back to
the iommu_device to understand SIOV without actually being aware of
SIOV to some degree :\

(Given SIOVr1 seems on track to be replaced by SIOVr2 so this is all a
one-off I was hoping to minimize such awareness)

Jason

