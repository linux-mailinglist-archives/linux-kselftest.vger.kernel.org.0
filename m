Return-Path: <linux-kselftest+bounces-2862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E75C82B362
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 17:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89197B26BC8
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 16:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F6B51005;
	Thu, 11 Jan 2024 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dk42r/OA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9206F3C694;
	Thu, 11 Jan 2024 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlPXaZdpeAqmSYOeL754hICR4rOKuTJsQcpb3pHU7lTqHtgwS4hUYUQXLSe+PF8uWJKaS9b/JqdDLNSw5RN5QIlQ87Hi95zprXMfdGTyhPXGohuDH/q6xVmTrx1eg8r2kaX9oDN5ZUMC6Pg20gOgwhbtIGfCAKnuBQle3fjQ9HPqfboTCIWKV9Jq3MKTQQwAqq7zoU2qB9bxNQI4C29kV2EiSn/3VKiXPdLw1IqAdlyB/YgQ5VaFwALkFNz5cMAVUAT82/i+8a3aQym++wIVBjb7rkEWKKqQ99YIKCw6q679BU4JIQ9vmZAtqJEXa4yvanfAvZjYAFUjW6q9lu7lfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuoIfTcMX0lAvZcCmYgGH/1LgLrXhXydIq6UdxHTfMw=;
 b=mFBWFMrvgBYvAlfUd/OBbSBAVGGnmPWS2ilMiP3KYk+EmMzxOLVKwI26GssdzMAFXnSQiVfx/2KrUxpzK8NWf+TjyB2La0+fHQQCZR97ACpsLV2CA7w0lsImTTkpuACyUKWR5FCDSIJWX6QWMz2Q2fuhUOto+LG/pdz8rIxLKE6/iZ70QsXhoVm+1XbQO2YZ111R4Scw899WSk1lQe4e3JANZ5WdsZ7gNYWDsjSsvx5uFwAF3uUzQIc9Zi9eIAwjqQ574oC+meTFHiLCEuN06fM7G/dn2yR8X+esMzKNQ/Iqkg5tMAsgqPVnialoYb3qrHYMOSr0+a6iE6sLVwtYMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuoIfTcMX0lAvZcCmYgGH/1LgLrXhXydIq6UdxHTfMw=;
 b=Dk42r/OAnGjI2i8hxSkqAOJJGq4/xlYYXXGwQA89FJqhBMnlHJRWTEyW3xdCrqq1dRD5UEKmTN58X0KtUj5R4nYIaTHUIzDPGvNdGbpxUOqYjRY9mYg0mZgONtYSvQx6HeIQPID6u0diJ/SXu6TZzJEemVPUxm9ljVHnNS4kyK2R31PUvvR0yBHUPY1iQ6pExXI1ALCIUDUPEPBDbOPQtC6opOygTn8zm6RTeUn/z13rsrpzm2a7fMLAu+81fJhEHQd1DZwXkBgS5hnIDBhUrqCHVKk0hrrwrSN7PEhOUnJv6x15S2hP1W5HsqNlHVrgKMyUWKZRXHqAlZmmgHW+ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV2PR12MB5775.namprd12.prod.outlook.com (2603:10b6:408:179::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 16:54:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 16:54:37 +0000
Date: Thu, 11 Jan 2024 12:54:35 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
	alex.williamson@redhat.com, kevin.tian@intel.com,
	robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
	eric.auger@redhat.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
	chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
	peterx@redhat.com, jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
	suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
	xin.zeng@intel.com, yan.y.zhao@intel.com, j.granados@samsung.com,
	binbin.wu@linux.intel.com
Subject: Re: [PATCH v11 6/8] iommufd/selftest: Add coverage for
 IOMMU_HWPT_INVALIDATE ioctl
Message-ID: <20240111165435.GJ439767@nvidia.com>
References: <20240111041015.47920-1-yi.l.liu@intel.com>
 <20240111041015.47920-7-yi.l.liu@intel.com>
 <ZaAcZXrhhQPhKTHq@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaAcZXrhhQPhKTHq@Asurada-Nvidia>
X-ClientProxiedBy: SN7PR04CA0082.namprd04.prod.outlook.com
 (2603:10b6:806:121::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV2PR12MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: fd2dcb73-c96a-4adf-f4b2-08dc12c5fec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x/TdEU/vneGv44fqBwY1T8bsw95Vj6JxgBaHxGkIAdTViSkIwESKcfWGR0vi1ZtaoiLZmrqd0Lws/Tp3htYhD5b5rHNANr7yuuDfMxfZozC7pKfpGS4rfQu6H01gzPRnweoK+lygegDEtVeT4fFsrqH46rcExGR00ewi0z0JAnswL/xFKi9G/qlIXx5faGXvqpjBI5M+0tCONOhnFz2QLkZaDJjD6IEYNaK0N79o8gggdpdLSgy9CIKBv4WswN9hTcPG3VkbLuhubAKNS9hqNsDLbsGWfPh63cTZSNkwGFqa+Jdhhl5RloyaysVKWdTpfElce0F1Aot3zK19GFrNUB9XsVKtgXzcVi2qqiVwVmT6PyFvbdZGF2I/Z2Cp8DvFQAbStwMbqrQEuWecV631iuADlD2LLRQ/WwirRY8TLSFkzSnOn/0j7UL4jXYGoYSQPJJDKq9b4jjZNkMWneDQOT18l1cGi++xdgtVpObYVqXxurnP/NEf1GhjJby0jQKchZI49qjnEvJ4EI3EiADnoVs6ESdP8thzLnmg1BYChig7emUpdqpDKU7JvQfw2NyELLK4MpchXtO0WAzF9RqHU7idgSfzWaSnsj3FYEgzzFf3VTVyy9QRAKKqWcZU6Qo691vaIHdWPQV44P+7i8W/wZcK67ub4OQ7+Ie/KKYcpwg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(396003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(38100700002)(36756003)(86362001)(33656002)(41300700001)(2616005)(26005)(1076003)(6862004)(4326008)(6506007)(66946007)(66476007)(316002)(66556008)(478600001)(6636002)(37006003)(6512007)(4744005)(8936002)(7416002)(8676002)(2906002)(6486002)(83380400001)(5660300002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fs+KeC0TqfyvQdlSdSHN/hkj/CAhdjZ1ovUmujsdOJEmP1TSBGds36b/4Mz/?=
 =?us-ascii?Q?amN/5HYLYFL5IjsdZcr4XiaNBmsCDv4CbEsxLFMP0RGFUS0uI5RCQ6Jec7oO?=
 =?us-ascii?Q?+O2XUPZ1JKtkKTzDlL4L/FWzieeaG0DfJBsYd0WGZyWAzdgcN5ABFBqY/PAa?=
 =?us-ascii?Q?cK9fLzQOh63rs3ZO7PKz2e7xJs9m+NnlprrlyBazqUNeyflQDTnuhPdUzNMG?=
 =?us-ascii?Q?Vb7v/Xv7spw9fC+6HUWBJxYcZa+/+0QwRKvew4T8e6rVFXfREgJQjM+jCky9?=
 =?us-ascii?Q?PJeSi1Y9CDExp47APJte6SRM9UVcfxEzjPwBbiQ+9tcSur+fllVlJEpEywtk?=
 =?us-ascii?Q?99HPKw/OTuPD0KJ17uZAXiLec1DFQ8N8l9nwdHKq+b4EXP8VQl9BFfjyk/vG?=
 =?us-ascii?Q?2FDDhjVA9AFdBvuRY4ONcFufbnU9fwtxu6OTmf6kQiik1MDHQuaFbAJ8sIc8?=
 =?us-ascii?Q?59hknUp1Z9bG5Vu7BHuITzkPVN7QZMNd5SoERtwhB+5HtZ7Aupf2Xc72JDZS?=
 =?us-ascii?Q?0hfzHILX8XNbI4WqJu/IiALQHRybZMMkf8IGtE44Cb4/hNyklH/krnX5B7t7?=
 =?us-ascii?Q?1w/cXIQ2QMVclazNPkzZP0Me/ZFLpbA8u38UQdHIG+dJFe4qXjZ1zn0x6zs8?=
 =?us-ascii?Q?L1D3EcAxNiD2JEuCBHtJi+MQNwsZYq2aAyYAyW+Ne9veolAKCZ5TROKs0meW?=
 =?us-ascii?Q?ZX1V33bYDAS1vxHsUL0wjjw/T9sP82tv82lcpo4HwOk2Z54XLXtuEpVvR97I?=
 =?us-ascii?Q?mRZEzy9blY/hLs4GrOiLxquEoT2BuuorDlfGta0KmyiIPjUjDI1cTc/MoH4y?=
 =?us-ascii?Q?+7K+Tk3ct4blaee4uEv/Gq9dzQLFoJJhJrHEsRTR6En7KvNFca0qVNoy/TkP?=
 =?us-ascii?Q?7OjMH16z28w02iubHUik25/PblwDRBftdZYh0mpUG6rJJsgJx3cwNW0xKZf3?=
 =?us-ascii?Q?4/miNFThgJ/zHEcPfPu1jmTbqdM3DmrNCjlXP3d+hdLwjwh28/lMH8t8yZWg?=
 =?us-ascii?Q?PFFhCd8pteoDC2GuRE0YCTaMAwXbNvfTutsKg1Stq4E297nPBM7BnplyIG+2?=
 =?us-ascii?Q?IG5icnVjGUGw18DPyk7wum8dYRmFOSVgpMqNrNrlHcCgjdVB3ziOxRdTJeOO?=
 =?us-ascii?Q?URvQ0CybPFM3q1hWzclL0fMxygwjR3PLsWBQVZAlTmAn2hcq3fb36AAfwad+?=
 =?us-ascii?Q?72OIaoGY48nQB1xUyhh7vpUMPprUAmiC00B5C4wh9w0cd43aESPCjm2OzY/M?=
 =?us-ascii?Q?nKFIHvGbLchgPc+zHEytePZvlT8fYeXutslxOmYtfK/HQ7I03LXwK45rDE9I?=
 =?us-ascii?Q?QvRONXrx3RUu1e/hz+g5b51gJZTiWKNxNhZw38c4wJV9nNLA43Snldbf4MaX?=
 =?us-ascii?Q?96tngxwoB/Lv0iAdaxdrCJHgJ1Uj3g7lZPsXyfaEKt4nqVgCnkGKWKUlM6kr?=
 =?us-ascii?Q?P/+yLv0raOb4tM4Fck+NrOQowHHSOIvuXi9iQqS8bLHa2vs0PW1eE78JvuQE?=
 =?us-ascii?Q?VtfXW2J+p8w3x+8DmeDuV5inSAqhUZGHE4RKX4AOdakg4XeZVUbOxhY4L/Ji?=
 =?us-ascii?Q?kK+/gbWawXMMY0AvheA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2dcb73-c96a-4adf-f4b2-08dc12c5fec9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 16:54:37.4176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTBuqqsfpQZG+tFfDjKZ0xlgLedJheUZhHXL6/hYdXoZGJvC+gtefARAWuoOoS0b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775

On Thu, Jan 11, 2024 at 08:50:45AM -0800, Nicolin Chen wrote:
> On Wed, Jan 10, 2024 at 08:10:13PM -0800, Yi Liu wrote:
> > +#define test_cmd_hwpt_invalidate(hwpt_id, reqs, data_type, lreq, nreqs)        \
> > +       ({                                                                    \
> > +               ASSERT_EQ(0,                                                  \
> > +                         _test_cmd_hwpt_invalidate(self->fd, hwpt_id, reqs,  \
> > +                                                   data_type,                 \
> > +                                                   lreq, nreqs));            \
> > +       })
> > +#define test_err_hwpt_invalidate(_errno, hwpt_id, reqs, data_type, lreq,    \
> > +                                nreqs)                                    \
> > +       ({                                                                 \
> > +               EXPECT_ERRNO(_errno,                                       \
> > +                            _test_cmd_hwpt_invalidate(self->fd, hwpt_id,  \
> > +                                                      reqs, data_type,     \
> > +                                                      lreq, nreqs));      \
> > +       })
> 
> Nit: spaces at the end of the four lines above that have string
> "data_type" are all misaligned, probably because of the previous
> replacement of "req_type".

I will fix it

Jason

