Return-Path: <linux-kselftest+bounces-2867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7F082B582
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 20:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC41E285621
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 19:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF58756754;
	Thu, 11 Jan 2024 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qfozSd6o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5792D5674D;
	Thu, 11 Jan 2024 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3pYBddL/aDjBHTM7C6mC+zcZLCxUUGjuTueZpI94nu1FVjWPLN6do6aTo88sAgFVsJgurdHqCSCOPkWEgiKUmWuanmlYUTk5YWzSwSugNcl4kFknpRpG56/uy2mDPxFZT64K/ADbievtaAbw3YwzJxlORz+sjnY6MA+2yMLrrnh/Vynal+QFbrnr8y4iCWFkSjwo1/CEDW3GVccRCDTduesLuaAYOeBm1h7V9ZkLETm6iYhI7oD9zRzcp1nwb2O/KyJk0zbKJ/gSzCAVX55EKInt+8Zo+3sJZEr0UGkgUfLlybI+7RrFaScVQ+LwQlvpmIeE6K2eE/LR+NEF33NcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UV3YkAndxTNOoMR/BQ0lg3DaGpgHeXF/5qN6kir1Jds=;
 b=Gu4fVGeiAhiCdz1ASfYnBak039rrh3OhYUIdkIi/rwcPqjk9DIBLNzlEAv2+yipzGdR7T/Kt4b5ruyEuWL2u2kJsJ3KBZpj8MYF/hFv97y/LDY2EK2Wuph8VHXChkwPwjMYJYmH0UNPOKaf0pop8c/Y37i2OGG7uwiUTJnDcctFNS+zL0noBbVzAkUshJuSwKaGX8PYgtwPNPpsFenHDvUvPv6TU54z4ltfN6cPnE6S82v2J6LBxC67ez4D4rTDbKFeZkF9rsuMFusX4AodxZTd8dNnzpLWz0h7P10u/IMUIte6+BYSSgyNR4ndc5Swc2FlXKm3uw0oCexJCyuZ8TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UV3YkAndxTNOoMR/BQ0lg3DaGpgHeXF/5qN6kir1Jds=;
 b=qfozSd6oahXPZXgldq8G7DwYEZFdViPvyUlJPrL7yGIJdWvOHSgkeiKpkg29LabQVafstnoMzVbKkjTBm1LKpHbNQ5C9S8fq9SjysAZ09hDt6OZ21gX8xcHfALASdtAQSSaRnbNbTZKmdKqrSCwifIMAo+U9n0n2dqHgDo/UDN4vlpI/njZJDg/Ha8cwFO44+RL4CVUwn7g/lhS9ftRJQfpNFiH+uRzrk/bntn7r0CIZ2d54h4sAUsWeH+GntNpGIkeO7Txa/bj2tE66EmD9PPwhnCWtEEu4KvA/xtAzaQ4FKzCkwwNndeudeZdFmTUhsLCtAU4EpxHEK45IrOUCJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5467.namprd12.prod.outlook.com (2603:10b6:510:e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 19:56:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 19:56:44 +0000
Date: Thu, 11 Jan 2024 15:56:42 -0400
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
	xin.zeng@intel.com, yan.y.zhao@intel.com, j.granados@samsung.com,
	binbin.wu@linux.intel.com
Subject: Re: [PATCH v11 0/8] Add iommufd nesting (part 2/2)
Message-ID: <20240111195642.GL439767@nvidia.com>
References: <20240111041015.47920-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111041015.47920-1-yi.l.liu@intel.com>
X-ClientProxiedBy: SN6PR16CA0062.namprd16.prod.outlook.com
 (2603:10b6:805:ca::39) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5467:EE_
X-MS-Office365-Filtering-Correlation-Id: fde2d281-51c4-4b4e-3ef4-08dc12df6ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	58ixyRw9ywLf54dY+TZfjB77QrJX+14PlC4hD3MxjDH+D5hVzhFfB4ITPH7q0FzGqiZXqa8s1dzp8MA2mShWMtSI1VdF8i11Kj/g97jUXxjn1QExEbxdiBqmw636FhbW9Usux65FO8zLyzuXqP4YgrqGsho5O29F9HvlvmaC/6SNhWo3AxuPeVJkwaObcLA8v2BdZ+gdWPiZH7gTko47b8hm5RGlztRSwMCvd4Iz43Qc4YUxa6shuScr70klzpWlLufcMTkqlhqg3eQZMdxh5M5VPh1xi4Az80NAKMcTaJFRrg21INee6R/r3wp7CtWpr68EkUzXi2EvWO4ZAIxPP5+uos1z/sZq9gs3ij7Ack+0XawoRH+9JMlAi3UcLywQT4mQsJIXDuCpCk8SctWFcDDEV03ijLuplySalbkJyBhwVtsuDiMdAVTkVWwYONTA/hQhRWItDcNQRApzeNyGO7yTfOzxPMfl4PJtRwxCinASZNZ0uWoXLUJalsZZiZFAh93/Rwz7BaU1rv/MQz3m5vmsNCbPZfMpa1SAAaOXUImEsSsh0iyFpiaBSYol5uE9jAcppS+365ibZb5zU9TWOpUmXMCulT0LtuZU9t5VNG6STkffb+E/h/aGIR5sse4f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(86362001)(41300700001)(33656002)(36756003)(38100700002)(6506007)(6512007)(66476007)(5660300002)(316002)(6916009)(478600001)(6486002)(8936002)(8676002)(4326008)(26005)(2616005)(1076003)(2906002)(7416002)(66946007)(4744005)(66556008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PyWioxlvOtPbHR/2Om6sZUpSYP9y6CI4V1lSOTt/yhgy7HXgCVmENx7Aky9x?=
 =?us-ascii?Q?AzaLbpenwFzB1nQNRsfqu0x3NPoM8skJvN6tt5AtCEwvHq1WVHsW9zNjJQ/L?=
 =?us-ascii?Q?r1GweX1wqMYuNSf6wUynQHA5WjEqg0X4BXBZC/0WOsM/XqyATHbb/Vn2ZmYy?=
 =?us-ascii?Q?q7MAguz5VyFVVsKQnPoTviiSHz9KL2IKF8ra05ak1MdQb3dUdAFmr3D0pm5X?=
 =?us-ascii?Q?U/KBr0T0TFzPJSwD4eDZvGuXbhEMAIn2FQ81j/MSChprLI8TO8RuiuIR8R4G?=
 =?us-ascii?Q?xKmJ+bjeE2ICYFf1jbsztcTGkZbQ41lWykqOgzTcI4tYBK7+7QSCx/FIJjql?=
 =?us-ascii?Q?iI2LB7+2h4UMAyFztsm2lUhVwvR9vH3HW6LEsfA4Of3m/flu5S+Lxru1labN?=
 =?us-ascii?Q?/rfME24rvqlDwgxoLVozqkT9S1t3j4Rgf3hGg8xA3Kh2QhGUG9dfvswz/9nT?=
 =?us-ascii?Q?dNc029d/hAS1tp70Fc8fKwdXtgTduyP6Xv3Xc7rdfSEoI6cnY8r1qRqgPGd/?=
 =?us-ascii?Q?xKiPojKuZtypoZjzLYK+QhrxTFhFKTVCHBDLgYRs8OwyRwLfaLQU6b1ZFSkW?=
 =?us-ascii?Q?7UIsM3bLN6xr6DY0/FsX5t5/Re9yG2SbVvHDDAk7/jt43iGEj0+2EkMafoe1?=
 =?us-ascii?Q?RXGpRd3+4SrYsaVd+kRSmfGBPA84Wo+YyOt9D9fmbCzTCIUnWAeddByvNg0h?=
 =?us-ascii?Q?2xkX4vi99+BJegkv/mLvJ0gHzvHC/DYDbCym4GH431dk2Zp0eb+DeIZKdjr6?=
 =?us-ascii?Q?SrXbL1yZVrVrJlFURc6kJBg9jqD2zYXZL4FBEhSbuN+LDfxTMq9WEZ0cJu/b?=
 =?us-ascii?Q?FHhjbhxWHHT8KQlu8COBhHtEIguouEQP6ApRGKPQOStlPS+iBFwLTZn3KJdX?=
 =?us-ascii?Q?jlIEKkiFPfuvKe1pwBNOl8TpTcKKfT2mtNU0lCGKSovzFv9QQGhpWXTwF8LS?=
 =?us-ascii?Q?4CYbC0BolHKOGPxWjeJT1ujhbVkzPsUoMSp6YSU05nTtUI7U7lQYRN8TKHVM?=
 =?us-ascii?Q?Tlzph8aONp09eoRsD7xqU/NdY5dg1H0zSwvrtPuLqj3xnfXL1osVsrBmcr+o?=
 =?us-ascii?Q?YvZiJEV2h/ydscn3y3kioztqXu6529bNyzumY7UgYz923/7JtGHcnL1Yd6OE?=
 =?us-ascii?Q?gnrwLbpnGbAYKvWkwS7Mq6U1sBnMpHo7DuuPsXOyQW24ZyUuZmbeTVCRAey5?=
 =?us-ascii?Q?MhMmGEwVRlw2794P7UGChk9x9w68AY+YZP0xBQjCPum1Js0eQqq2/dXp+oMq?=
 =?us-ascii?Q?M7NdB1njdJ50qLKG40lC3PVqhcNSA9sjs/Q6I3JCh135fL+315eQtcDTQKMW?=
 =?us-ascii?Q?KQWahFft9Ck7sEQNsoSdoxe1s7JnYkt3PiPsE60PWXI4mirmxw7LvpEPv4Jy?=
 =?us-ascii?Q?MLOC8NNjByO3y97Y6h/GNwWqfGAyMeC3xIlR8xVPOmU6xyREiKXoyi8Eg4ix?=
 =?us-ascii?Q?Sohh7Dt0FOTo4s1TWMC7Qm2Y6xNW3b3DYJR8npb7dsS5ySw+Tn9jHUkKwoB/?=
 =?us-ascii?Q?6M6tS6Z1+sNqbvihJvewfw7/02VssIaIWj62eIYD5viYwtgkWcnh7sce2wmW?=
 =?us-ascii?Q?93libGUtDFYcceAwkM4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde2d281-51c4-4b4e-3ef4-08dc12df6ff4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 19:56:44.6618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmGTscUikkWCTLQkXxqAJz/3KaEVs0J7viUd4q5VNYwhJzfPBvBHju1/QstziCH5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5467

On Wed, Jan 10, 2024 at 08:10:07PM -0800, Yi Liu wrote:
> v11:
>  - Drop hw_error field in vtd cache invalidation uapi. devTLB invalidation
>    error is a serious security emergency requiring the host kernel to handle.
>    No need to expose it to userspace (especially given existing VMs doesn't
>    issue devTLB invalidation at all).
>  - The vtd qi_submit_sync() and related callers are reverted back to the
>    original state due to above drop.
>  - Align with the vtd path, drop the hw_error reporting in mock driver and
>    selftest as well since selftest is a demo of the real driver.
>  - Drop iommu_respond_struct_to_user_array() since no more driver want to
>    respond single entry in the user_array.
>  - Two typos from Wubinbin

Okay, this is very last minute but I updated the series.

Jason

