Return-Path: <linux-kselftest+bounces-2714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013C9827059
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 14:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B91F1C22284
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 13:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B6B45945;
	Mon,  8 Jan 2024 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EA06J147"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82B944C99;
	Mon,  8 Jan 2024 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lh4Tpzwur/YB3+TvFrHpCSB6XtU7J9q39IXLbuHo0g4p0X10pTg/K9DsuVxr2chjiz5xJ06VYrEcxVmIHE0681bBo9EiOICBB0EYTJm6NPyGqIpta4ZJo/bf3T+9frajxlSDb6Lw1yULvmzG9kdRzoOLEP2C9JIQb3lVOc+CQPsoi93NBfYaUuaesX5g1fD5g9tHTbnNzUe3cv4a3j0Yw8LY2TJUR3T9v9eHhRQQgHV/4VKt887NqO+kHd3Yvq3Hl22/bpGax1g7+Lu9mrV2O6nYBLssrRLIw6jUFwCUs1prB7/rz1k+0hqW/Amor+ylBH2TEBZUoEMxKGEJuMRSkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJ5Vi1ZBvCQqoh+E5fmJh5uYInDiBpZ7YJqtfosDNtk=;
 b=DQ3KlZyYIKtznU+UxRQChXQBK8RbxI8ewIcOL01DFDgdvIlN0lU6631APufij9h70iwjDUwVXr1+ffunLn4vMbOsLMgq2Fj1yFq/fZhMrGAJ7CZ9PZM2YFSjxviQNlFrA1xyAk9nNzhK2SvdArvc2N1woFTwdp7bxuanztBvDuC4CpZevpBkqcKwKyBntMpOj43xqhdPqgLNbCrFWFm/V/8cOulSYAxqWjAfEhimqigIlk24j1fXJROPUccYGglAvypJhpV46B5+x8JqaqRGEPfbwV7Dr6QP6slX8BpcqFUrhQCpK42fN0XmYUy7gkcIYxGB99fIIKsxeM8iFqhfiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJ5Vi1ZBvCQqoh+E5fmJh5uYInDiBpZ7YJqtfosDNtk=;
 b=EA06J147aFtQxKE4UYa0ww2TmVVEhW/s9VgVkWEoDenU7CAfTHPQGBmhElSW3GRmI3ecpvgU2G5AZDZzeVlW0nFZalKUHgR+2QvREwPW1djk2gKd/GOQsF0vJu52VBIcdsmOwQqSC4E1iHSmourjK8OtuUQQ90gM+63d7Pmqv8uAZ1HNWggLLpSwHDLN/kUFgSik5v+Q91mcnSMInCK5rsXYB7egAhdbe+F1BDU+AYqNz0zHwBYqmOzU/qeMZ50ZJBsNlN9BkprW9p/J5Urh76Mje7HLt1zuFsicymhETMQ0XF/Q02CmQk1rS8vP4VMnMxu9iuzW2lbix5zMGC5OKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7443.namprd12.prod.outlook.com (2603:10b6:806:2b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.19; Mon, 8 Jan
 2024 13:51:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 13:51:33 +0000
Date: Mon, 8 Jan 2024 09:51:32 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
	"peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"Zeng, Xin" <xin.zeng@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>
Subject: Re: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Message-ID: <20240108135132.GI50406@nvidia.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
 <c967e716-9112-4d1a-b6f7-9a005e28202d@intel.com>
 <20240104143658.GX50406@nvidia.com>
 <BN9PR11MB52769EEDAE2783426144E2588C662@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240105144516.GC50406@nvidia.com>
 <BN9PR11MB52765C91893A28A7D21D324E8C6B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52765C91893A28A7D21D324E8C6B2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0375.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: dc05106a-8c1c-4458-299a-08dc1050ecd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	88cEMUaLWcsWYEzBxYYFmRCXGkcRauBLzd2twV+cZZrYhBMJB8wNdYTX6WMBU3n0tHHRvNS0P3zpUC21Ar8Gbzppg9iyC07zSCDvMRvGF6xVpdWVaX4Eb/m8BBD5gnX1LjeNZUdyEB5neSmGMvUvklujvroIvvWLl2iOWzeSQwka+r5Hqtpan6zhkWvQw4SsSuChqweqjR/IQ1v9rXeDq9wFDpTXJxTIvL+Ooqq59L9RcV97HHspcAKd/Y4HK9VnzVzCi37Irji/U+oaWtRN/1gJGuSffcHNzqhpKg8kd+bKVFELNP/U3LihyFMnZ/98arWwUcdp3MAmBN+KtcRPnUbZWt2C+6NTcUUsd52yBciOyqzsSTXzWhToPDpM3clwOii8bDLYKX8lO58dPpmwXZO0lKfbW3FptetLeIZOCyF/WkU+PPrI6eTPHP84EFUKLHR30diMUw/XETZdG5KigX4nQMfJunCM2fexGx+DhX6+d+Efgpo8cpN8Oa5OcWbyEyrJwcz+jhdld16Kcm3qC7J/1G5SiL088+pCD2W5NgpJi9bSkqANLlC0aEQ5jAXF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6506007)(26005)(1076003)(2616005)(6512007)(478600001)(6486002)(38100700002)(86362001)(33656002)(36756003)(2906002)(41300700001)(7416002)(5660300002)(83380400001)(6916009)(66946007)(8676002)(54906003)(316002)(4326008)(66556008)(8936002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9GwLurVp1bsa3b/nxpR89Exp2XSvuPgO1wXVOTqWhgttDISUFRK7VxD0+Pkw?=
 =?us-ascii?Q?jyS4cxpMNh8CRDZzRgrx0LC0ccve1wgK5L1WfhrOgFb2NC7/bdBs1mapUzub?=
 =?us-ascii?Q?RUHTGoLeDpOvzzREcvw0AJOcPa0vylZqyGIpxqCGg0047JssU0uMKLSwcoSy?=
 =?us-ascii?Q?tZNbD41d2tmubORVDNVTxSjs3Ta+nvRvg9Us6xD5ATs7gz2uyI/4nl5jtL3S?=
 =?us-ascii?Q?6ioP1ipm0MZxRqoNt9xFnhGPxBrDMX2PKtx5PVSOfot8dfZP14hU1oXK6UYE?=
 =?us-ascii?Q?HAwO/ktDfTJDkqVZsTadQTfmHot1jO0TPJvebqDyeXXxrmHqaVu8gsjMo9Tb?=
 =?us-ascii?Q?ABvG8r74RoOr/5vunqOy5VxW6Wms8phIJdUcCLiPrE23TATo1wq1U1qKSpav?=
 =?us-ascii?Q?O9MJAD23zxf7xx8ntkgTgLsO+OCX/3iPPUXBX12xJ8ptmk/uer2AacaJNd3B?=
 =?us-ascii?Q?KFlsXklePdP+fL2Tws89zsO+lr7Wf3EjvZCgycHEo3e+74obSiOXEDVrKXl4?=
 =?us-ascii?Q?JSxJy5eskSKbhz6IoKz1cMCMwVQBWfipfUfXk5gi0GAbME2FIdgOEUKvAC1n?=
 =?us-ascii?Q?WdDGRMRwmDfQZQL+zmChJ4enZUkzWWLtsTa5OshDmWEjHHRn9IaY0T4tsE+u?=
 =?us-ascii?Q?8yn/1IL+9LNYl8wR4IMef/DcZPb5shS/a4u2YO7Zj7wH2JQ5UgQojKr3hsRI?=
 =?us-ascii?Q?b1NM9BEorll3pY61H2dGtTBlScvIAv0kv6NWDtSK4C6HY1V3nPgyAhmYMJ7f?=
 =?us-ascii?Q?wPduUYzPCyVJkFR3Ne9OlrwP3i/xkMvJUIe9kaEGugv6RU/rJzQZ6z2fJpBN?=
 =?us-ascii?Q?DW6XygQqO9qwX2M41EXPtpNgT4SrLUy5VhElGM1wqcxCzx8/SVkbngMUMXE1?=
 =?us-ascii?Q?HgxGW7duyw+mDhorWeBQszb4d5KxV7aMsz7mBabmFD8ZROANorM/UTTEf6xp?=
 =?us-ascii?Q?PRUvMobD8qXBxfSLvwPFmx9g753oWVyrxbQrgoPtMF+z7WRSLwSLMadpOQLP?=
 =?us-ascii?Q?hrJDsq6d+x/BAAfxFT3Gb9qAx2eR6Hk2f+xqz0FX5uxp9dUQ7Fx6GC1Yi8tT?=
 =?us-ascii?Q?vJ8WbxexK2ISmA1YtGoeWSRf6f1H2sZm6Z7ZHfUznhyaE8HX9QZ9Tbo7as+3?=
 =?us-ascii?Q?qNHkCMCtqzie9LvAZvFqo9pePCOSj3oUiOsakNJUZxNBOoUbJ1rq54RcdJB4?=
 =?us-ascii?Q?NbiFCyXQ/3UmK1EumqsA6a4EJ76PwfDq/lmvmHCc8QAkHHkD/Mm57j5xCx9d?=
 =?us-ascii?Q?Ff1w6F13u9n3KYNGUwl87LT9yKviExS2Zt33BWK7Fmg59lahHIWWcH6TRhau?=
 =?us-ascii?Q?+z8EGwV9UWEJzUvBd8OP1cG6kd5wS2UkYoSdTx1NnNio678A+2vDvrcuvhe6?=
 =?us-ascii?Q?Yvr+jo9QZ2dknR1kow4gX8p3hs+pimXb/fgr6BDO2U5FAOoZ5GpipDdHSfb+?=
 =?us-ascii?Q?YU8WY3aJ2Js1kHtOvJxYrUZOwmi54keP7A6YZvhZCsd86wGrOCk0TwQCtrnL?=
 =?us-ascii?Q?3CMUzmJ/uEzytwzgMiwy3aoY7UIPieDwM4JILmfCPWwPczp4Kr8aUQd5+kQo?=
 =?us-ascii?Q?8orT8d0qc2PMHH/rUJk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc05106a-8c1c-4458-299a-08dc1050ecd7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 13:51:33.8450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDY5yDRbDaspQzG0KtbGC7p1xNO3J/QYwAKEzkgcTXqGZGqSZ9BE5kNrHunvpSaU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7443

On Mon, Jan 08, 2024 at 04:07:12AM +0000, Tian, Kevin wrote:
> > > In concept w/o vSVA it's still possible to assign sibling vdev's to
> > > a same VM as each vdev is allocated with a unique pasid to mark vRID
> > > so can be differentiated from each other in the fault/error path.
> > 
> > I thought the SIOV plan was that each "vdev" ie vpci function would
> > get a slice of the pRID's PASID space statically selected at creation?
> > 
> > So SVA/etc doesn't matter, you reliably get a disjoint set of pRID &
> > pPASID into each VM.
> > 
> > From that view you can't identify the iommufd dev_id without knowing
> > both the pRID and pPASID which will disambiguate the different SIOV
> > iommufd dev_id instances sharing a rid.
> 
> true when assigning those instances to different VMs.
> 
> Here I was talking about assigning them to a same VM being a problem.
> with rid sharing plus same ENQCMD pPASID potentially used on both
> instances there'd be ambiguity in vSVA e.g. iopf to identify dev_id.

Oh you imaging sharing the pPASID if things have the same translation?
I guess I can see why, but given where things are overall I'd say just
don't do that.

Indeed we can't do that because it makes the vRID unknowable.

(again I continue to think that vt-d cache design is messed up, using
the PASID for the cache tag is a *terrible* design, and causes exactly
these kinds of problems)

> for errors related to descriptor fetch the driver can tell the command
> by looking at the head pointer of the invalidation queue.
> 
> command completion is indirectly detected by inserting a wait descriptor
> as fence. completion timeout error is reported in an error register. but
> this register doesn't record pasid, nor does the command location. if there
> are multiple pending devtlb invalidation commands upon timeout 
> error the spec suggests the driver to treat all of them timeout as the
> register can only record one rid.

Makes sense, or at least you have to re-issue them one by one

> this is kind of moot. If the driver submits only one command (plus wait)
> at a time it doesn't need hw's help to identify the timeout command. 
> If the driver batches invalidation commands it must treat all timeout if
> an timeout error is reported.

Yes
 
> from this angle whether to record pasid doesn't really matter.

At least for error handling..
 
Jason

