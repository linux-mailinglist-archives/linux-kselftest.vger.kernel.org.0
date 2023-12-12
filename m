Return-Path: <linux-kselftest+bounces-1690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265F680F0D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 16:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 618F0B214C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFAF7764B;
	Tue, 12 Dec 2023 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U+nm3yQL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384B91BB;
	Tue, 12 Dec 2023 07:27:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fT0dL1y4+InzUQYZbULggi3FP/iKtsJUlphsaiw8lk4qNTsW5UZ5zkPzb6OxN9bgThyXUpXqsTG2EeICoWpwtkA+AsJEsPpveN7AUypmazFro54+BCZrmGsQvtBCxOvRGLEcYGLZphSI11uYlWX1+MjV9zGjrVADPTVed6lpqoKG3MD65J4U2mqwz8ygfpVxOIvOdcoxt96u0po5sHECN+f7DDhR4TxwNroSYGKgJPFXlu+3/DWUWDk/f/FNwQV3EQyK7fgU2tGjSpFWKBJfXieNUhfkoCq7MQbUIE7Oi9h+ZiKLrbjuPYT2WKrCTHKmwI0AwebyIBr6xPCvFKQDaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQUksyKm+pFhshwRoJLTzl73PNpTOPvxYX+gSXXmY1s=;
 b=d//9bYqVPmlgZFAmJC//quCqcE2Eis5hT1sFEreNWwAjHaYzXjWexfbM8LWjnNS89AbfE1wIM34UCxjwdpVm+wLbLNS6KAll14fZK8lfTW1yDxP4qhGgsRpY6ILKDxs+4O/NpqxDyr4WnJJ1/9chOrOfl4yk4DVJnTxipCBSIOJ4+f2jv3mKtu5psA/WmKrJzjoU57+BK9q/e+6Ad2TX8XklTsaC+GMZ2m34Eo9qSKF81AViHUjmUZJcZkBqqpmOICUbiQ7ET2AuuCKOESGw1Jfkbxm814hTJxq6gBSi+piapvPbij/ktuxdKcMebeiqhxhHcrI0l+YHm1h0kMtfKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQUksyKm+pFhshwRoJLTzl73PNpTOPvxYX+gSXXmY1s=;
 b=U+nm3yQL85alwOKfphYE19m34Ua0jEm0Kjj/RV9s33E/vxXez/TfP7Iqt/XInv98SqShrbyxhTzSsznGHlghZ4otRVSYJ9Zr59boJPH5F6k3gcQfDe9s60V1Swuo0HrVAPb16gbGCyh3Ir5yIkdBkGIbIDcbrZ8WYD5bGr99c9CuymLrnn2Q+J6MNxXuXj06eL7vfYOD1VNauSY0bBgRk3mwAT7c36P7hGiOcbqrQFbSydoyDCWRvt5KYvpsyoUO55Serrqq/EGpF+wgUW/WxCmQ5HKnnxN54DRQwuCHIEc31wqHl6bvHU5HjwJp/Trkr6j3lZ5cIPTxrVBnPAAORA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 15:27:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 15:27:26 +0000
Date: Tue, 12 Dec 2023 11:27:25 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"Tian, Kevin" <kevin.tian@intel.com>,
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
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"Zeng, Xin" <xin.zeng@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>
Subject: Re: [PATCH 3/3] vfio: Report PASID capability via
 VFIO_DEVICE_FEATURE ioctl
Message-ID: <20231212152725.GJ3014157@nvidia.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
 <20231127063909.129153-4-yi.l.liu@intel.com>
 <20231211110345.1b4526c6.alex.williamson@redhat.com>
 <SJ0PR11MB674458A8B7319F30A67FE55F928EA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20231211203946.35552183.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211203946.35552183.alex.williamson@redhat.com>
X-ClientProxiedBy: BL1PR13CA0191.namprd13.prod.outlook.com
 (2603:10b6:208:2be::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5103:EE_
X-MS-Office365-Filtering-Correlation-Id: 3146ec9d-f590-499e-d1df-08dbfb26d843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ma53xfCnGhDFqIE4nUbvD5V+TrgqnvthLmSVJuddMrNhTs8Yw7ACpEkji9prFsRHlmLol1QRwe0c+EZHNj0z+c/2CH7yBElhdvF5nMAen+HZPc/sZIuD6YcbzmXWvebQ7/CifI0Ual/Z1Ls2qT0/eCAKYuDB31tvnAGcQEkXeVuf1oMDPwDT9o64lZzM06JNdIwTBDaEnQH4nm6ss9rBgS3NraOEolnrR5r23Mjx3Vc8nW+oLszSHF5GgYXqJcMibYhqPrsCuS0XYgiEFCnrG1ODL2sX1AHg1x+667Jk2d2kB/WKiUgj8m7jcKQo37ZdsV5vd8VvrumqEiBAO5rMC9bsfzBbeVFH6lsb2KvGPM5TXAVAD0ocB7yqXgz/vhtP4x4VJMLnDL8IAKNz4gZhAcbgdB3MdsY3O8/xJO0er05pI2DhmDfJrjMu2TyO83UF8iZU7ZtIj8D8S/B654a/VmCKoYM68RTpqMdrRqOLIKBH4aMNaeJubr0n+h3P+QRCtPd1XzPugsNCmT2M7+JM4q3eAzCTic6limZliV0jqOUfjo+3ThvAM34ZmL/tCW1Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(396003)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(478600001)(6486002)(33656002)(86362001)(316002)(36756003)(66556008)(66476007)(54906003)(6916009)(66946007)(2616005)(26005)(1076003)(83380400001)(6506007)(6512007)(38100700002)(41300700001)(4326008)(8676002)(8936002)(5660300002)(4744005)(7416002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5ngGbAmEXeevY3OtsuhtR9rrUJ59jBHpa44kYjJX7df9PAwIK/IdDu3yiN1m?=
 =?us-ascii?Q?SGDhHSd4ir/TWuFBzXj/vDYUfyoBcwOp1HkIUNIO3RMmqL5C3FztDhzDxN1T?=
 =?us-ascii?Q?GuvT7KPhsBBZdCatjNoUkr7mq7a+gHMpNUkr6PrAgcIS7QZMP1b/zu1zaUC0?=
 =?us-ascii?Q?fqVcECZwWpm8Or+VIDbahEP3O7b8cW5WpkufL+FW3CeCCJSjmrgCHrIX/teY?=
 =?us-ascii?Q?RSY/ISb6TuGja8GDtHKuGveOyLpU3rPJ81oV/EYJJybYGTMnhnPQeGBUhhw6?=
 =?us-ascii?Q?UHppHYgrDrq2A35oKNTdF43fTm9y9Ud51io0rgBCwhFGGkGI64pMISMXCrmC?=
 =?us-ascii?Q?9QPB7BnqiQuM6UorIk/TKQ/eC8clmIU37YQ0/m78mQh/Dc9gPVTYMR0VlROn?=
 =?us-ascii?Q?1Duo+/WfKjfETlxpGTfGrjEMgmzE3yEf3LxsAHlH94GD2Wjff9SDf90FPSXj?=
 =?us-ascii?Q?OtiGnfvm65vKBTEgOkI83gTF8k4QmUVqAyZzgh3HvczdFybT0Yqp9GfRs2bu?=
 =?us-ascii?Q?O52jlhrCfGTIq9rU56wzSWI3QYl3o0lIYliAYBurOvReGOkOIXzVUduIpYP/?=
 =?us-ascii?Q?rgUo2imUKCK8DSy9wwsf5t9aYWDHy9fDlc6QynZ8HM9eHZVd1F6Ll6wVBDsy?=
 =?us-ascii?Q?2NclVN66RRFMrxBH0tbMAaQ+kRJDe0gumSm1a0iebfWX6xzTBOKklOlSTTYM?=
 =?us-ascii?Q?o/CTDQqch83+lnii6P7F8S+Rx0sxx6f2HvpodkaO/lOO5ZZChuXRzBw//UPf?=
 =?us-ascii?Q?xjFiUuf2RnBlnUjtN8NY6Tqugw0Pa8t5zNvyX0cTLxAkkYujgEV5cBBnxzqM?=
 =?us-ascii?Q?/IIK8sRlbuyclhvXLq7UdSmJFptAjDYM9LBpBPLpq6OU1KCvPU/uC/L7t4fz?=
 =?us-ascii?Q?uPYqOYoizoMZE/aDofjvQsAD+b8/uApcnh/Aca5yvUjdv5cGujuPXGCeDSVY?=
 =?us-ascii?Q?O6bAHbJULBVOdohztaGbdhZ78CHm5JqDfK2IiKtLH1e54xGStC6a1EhDM+YV?=
 =?us-ascii?Q?s5dtcb/fSJRmxtjavj+1yUzr1CE5qlZ/dZL4CaX3YhWGUUMCq5m2sTTRcaj1?=
 =?us-ascii?Q?Pg6TXWbP7y/cJ3e7FNYqTbX9Plm8F9ndP/OTIlJX0X7jfSi92ey7nYSHb8nf?=
 =?us-ascii?Q?EBjQkUw9jc11e2RsMCjnvT6PKYsncPkI2l/HyL2aFbnReVojjvX12a7+JDvd?=
 =?us-ascii?Q?EVAk2m+sPI7HLY+AdHICgn/rKUebdCjya/l2ImLCKzORokuJ07XQu/zPC7qO?=
 =?us-ascii?Q?pDyGhlBQFrvfi7ATxz5EhY6b3LzLGdB7yfz73kS2QrqrXhAgmZbkDt0R5us2?=
 =?us-ascii?Q?mrQKLhdKB8XLxcfq9NNgtZ2zJGk8s9ygWta4uhA0B7Db4PuvgeW7JdIdZXuO?=
 =?us-ascii?Q?cdAae29HWR545mQjD2tUkqL/+USoORFJ72e7mBwhtLG4U7wUOaZNdS4zOXW8?=
 =?us-ascii?Q?xs58nLsNCf2XD32YFCd8CTvc040U6+pqCOxZqRvpeyzapTuOyulbgEe4VFfk?=
 =?us-ascii?Q?Lohct5hJstiXDgB3TUfE+1kTDTzfTLNC43D7zQVPNYH4tHB8LxtNsnYCY2lY?=
 =?us-ascii?Q?Ed32Dia7j+Q3RXp93vgUeOj0EclTfJG3DhegeeI8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3146ec9d-f590-499e-d1df-08dbfb26d843
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 15:27:26.0151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wzMEeQoibpKBM97xAB3NFdw6b3r1KSZGzCBDwngf+0TUORuDgsBjvISnUE93VlF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5103

On Mon, Dec 11, 2023 at 08:39:46PM -0700, Alex Williamson wrote:

> So how do we keep up with PCIe spec updates relative to the PASID
> capability with this proposal?  Would it make more sense to report the
> raw capability register and capability version rather that a translated
> copy thereof?  Perhaps just masking the fields we're currently prepared
> to expose. 

I think the VMM must always create a cap based on the PCIe version it
understands. We don't know what future specs will put there so it
seems risky to forward it if we don't know that any possible
hypervisor support is present.

We have this problem on and off where stuff in PCI config space needs
explicit hypervisor support or it doesn't work in the VM and things
get confusing.

Jason

