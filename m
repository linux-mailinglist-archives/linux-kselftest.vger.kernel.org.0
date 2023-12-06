Return-Path: <linux-kselftest+bounces-1316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23194807838
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 19:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5034282044
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 18:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A56F4777D;
	Wed,  6 Dec 2023 18:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ae2BqefS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE469135;
	Wed,  6 Dec 2023 10:57:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDoP4ap8lbIrqSpixS5FncTXoyrYs7bxJNnfvrKEe5/58weEyJjanvfGgKf5UhHfqmlxBDv6KvBnPtWQTIQTnisBzI37xtaT8Zu2PaqHQVBQCa6aL0Jhi2XjFfCRrXqqblATTJJO7HEywzVwX6PcJsnJZoUepaT2zh7oyfUvA4pv28m/PdqB1fw7ltrgkifYRleGjb1nQZIgnc1AVyF2/5MnPWQ7kLfAg7G/vkhBiw343UXM6eGAvHYdxcI88ctxxm/8bWSP2GT+MrKRwgOKW2IBjvMt4jLTAlimQbTxKgUEOfYQm6EzeXOsBf34AyOQsScme05w0UlBWo/TMdCh1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQmo138YafK38DlduIoaP0BZK8uIclfvmQmYz3eyR1s=;
 b=hFN9ry/izTYQybPygloniRH5u6RP6/1HXTKH8U0suxCwivFiMN7qRMFdapBY3Aglgzzv1DosfA3MQhXuxDNgT/z0H3olIP8r0N2ViIY+DQpj3g0iHZ+vDSB6L9Ls4RT/qO5Tfd6cGg6ToMR+OSX7y1ztUrikJ+OwlhFDgnOuBiklqoXNtFdqgIDxsygUmSXNf1Ou3+853w2Grt3jtFtQE4LKIunqNuLlPw7LFrejUgrT60cRXzomGU9Xc6tSRlXbHtBl2KrXBWPwvQ/kfcuSvgF6CcYi+XBJizLJ/THbdJRGQ4lzL2U0j4fB+yxmoSPAXnwFNTBRyHoq9uBq0TSPwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQmo138YafK38DlduIoaP0BZK8uIclfvmQmYz3eyR1s=;
 b=ae2BqefSRt1o2nP7uaOC7om4O/miC0CIqH9GVhrBCH5Q++8lvg6iJziEiRvYMNiI7lk9J9MOB52LZSUVA09hZHuOyNZc1g9DKv0USCBDvpaiMoT+NWvfRID9ubjkgXksey+aPlNsvkw6AfAv2tQir7ScYW2jKzZq6Jj4MwHXW7StFMA9k2FaxX14eJ9k27GBbTmMhrDTWM7kU10UzogeDlSvUJEns2sOt7EehIQVewhyDg9cCnWpyqKC+zR447HHEUxmajybzHnAP24A8E9QJ1fpknn0/Dv/RIQr5G1WM0VKHJhZD4hcuVDi5V3XfLfKMJbEhpYTg7Ju2tsPh7snDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9211.namprd12.prod.outlook.com (2603:10b6:a03:55e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 18:56:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 18:56:59 +0000
Date: Wed, 6 Dec 2023 14:56:57 -0400
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
Subject: Re: [PATCH v7 3/3] iommu/vt-d: Add iotlb flush for nested domain
Message-ID: <20231206185657.GC2692119@nvidia.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117131816.24359-4-yi.l.liu@intel.com>
X-ClientProxiedBy: BL1PR13CA0436.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9211:EE_
X-MS-Office365-Filtering-Correlation-Id: 21327926-6b38-4993-d729-08dbf68d1fca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rFvIhzn9BLWCQC7hjFk6aWH6j1di0kuA2s4uzWZVkVkgA6faWY2gpYI0ep6Qnhn3+45sLQth4tSqFrkrhHdyM9zhSwAig+CyvzbQjrljV7VzMoH1akTJz+JYsZN1WsQbyXL0h78zyAHbXBmJ/8cblNSUVibyqswSpXsRUbp1EvkdYC6PFhH4T7SSlmD6HExJ5VzOI7fF5Wa9CumipFT0/yHGAuX6M8jvodDfN6PkLMCS+UogLsX1QQ3zfi+jRhTNnLOgEdV/fTyFJU8vPzAp1QiqJ7tp1HJt6fXzIcjmh++S2fxqX2OIRkswcauUCYhnqM+nc//nl842XqQJID6iwEFN1Y2T26wSSLTpCNq8k9hkL3OEZvcpDgtyGVzvWL5KIbbG5PsXwKmYuL9bRLWeD/o/e6bdow8jgS5MsMm3sT27YtpKQoKlz1JOXe2RfrAOUqDi42oY7Vf3tE7C1xIjmrpVeL2Dwm1hjH7PbG6fmsnuDFQ3RK1Mth4uyTDgPV0HuBoBFGBpb+ApKmyUVE22Nb9n4/FV8K9xY0ViryDWwXo9EVP6dMeGyKwRMDJMpJRk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(7416002)(4744005)(2906002)(33656002)(316002)(66556008)(6916009)(36756003)(66476007)(66946007)(8676002)(86362001)(4326008)(8936002)(41300700001)(38100700002)(5660300002)(83380400001)(478600001)(6486002)(26005)(1076003)(6512007)(2616005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OzZakPdjdbJRFEK1PxwrN2pGyLuRNKhDdKUnAd6isVoXAOteuRo90kZ6pt6W?=
 =?us-ascii?Q?xJigNud9RDX8TtrPPRN08XF1AdEVQleZ1SUlznulMxLTEUhBuc7bJKI+TSsY?=
 =?us-ascii?Q?hToDxmEAUay63jtg0VsTFZ/jVn26c/KWQTnYayci/MPuejd5UgGSEFqYtniO?=
 =?us-ascii?Q?mkx37BXSw221GIB1eD+5IHD34yhbR/lNC3cHWQEBDxnuf0IArlSQK5G9J6wE?=
 =?us-ascii?Q?A3z8cQ4U8mQFnu5IQ4iLz+/FU+NUNIRpF0HoI0RmSx+RtPlWliRYBQDoUIda?=
 =?us-ascii?Q?lSyBJLPQe7ItZjrerD+jc+nbQTWK1cl8/XggnEAl47XGy5AdEzHgf7EG5y+t?=
 =?us-ascii?Q?muIuTjYFr19tKMNXijCn2yWiUD/G3c9KhcLndVSNjx9Z8pEKu1mqfMQWRPaY?=
 =?us-ascii?Q?K7fDvrTHzFqMNLt08qFSvlLNlByhTWni1kJtSAxEz/+EWC4WIqw/WLJEnyKR?=
 =?us-ascii?Q?gto7qXvky5xO389OCXZ1KiR6/iS5c58qalA0kPpNv98x03w2LAQPflOYXjBO?=
 =?us-ascii?Q?GgKi4si1wGn92rTpStGBWlr1BP/RxHLaW4EDLPeU3HQ2xuiGuD3vFvO40HNj?=
 =?us-ascii?Q?MdpiM6471rn4q2vUePMtY43wluHuG9gt3mOKue5IpsbFspbyrX3cbNfniLxO?=
 =?us-ascii?Q?KQMRrDrNuJFmD+/FjJBgpAcxHF+3yqEzRIFEchWSWWYIaDFAsc/r+ucasKVx?=
 =?us-ascii?Q?Sevlf/UgC4UZQ/sKfyuEDzDkeiCZGR1v2yIM06BNCFR6LBiGRjZZgYAW946I?=
 =?us-ascii?Q?3lVj4U5oRpFmyJX04NA7zPMKhJjIE4gLrIkrLmzf8CGDxJgtcV8zaeylaI7R?=
 =?us-ascii?Q?QhlAuKUsP58WUK8+RIuB1a3VD4nscciFDdnU1HEfxvZiZsslGwHcnNokU2GG?=
 =?us-ascii?Q?5KtBgIzUVbzOcrQ5lBOABeGZK5iiwgeHZ38IvE8KQwrdGpF0d8s6UIDpwEdS?=
 =?us-ascii?Q?NfedUCviZ7cvavxkqF7daUOHLFvE0dH3UBcWWDSVYv0y66s3Z4ez4t+NCDDo?=
 =?us-ascii?Q?PHmb4PRYZ/j1UzmTH8L7nqQPFSYXqgJP8LQjUHwyoXHDTLQZFapBJ+SpY+CI?=
 =?us-ascii?Q?meI4wtbwz1fQ8c6UdLwdGDwjYHyNWQJfHOwNpqUoidMjk7+3hPsiQTuNY4oC?=
 =?us-ascii?Q?fUqwPK9tk97spEW7ZUEFcDaRzD4kL1qQKhXPJ7VBuplXpLZUdV63Ufz3Afue?=
 =?us-ascii?Q?FyO2sH6KNtEXLllQ+/dGKWV4CSXA82u7ls+Y4rJ/Nn5xICoFnAn5Vn6VwNID?=
 =?us-ascii?Q?XMAqQ+X+bc1c578OIQDiQnqCaPb7TViXtWXYqpsP74/8Ltt4IZ5qYaoYcS3f?=
 =?us-ascii?Q?AGgI599wTTEIBuloIWwohFNm4fvEZ7AC8XR/y8ARtcrcj3UQrVahQYKdBCUp?=
 =?us-ascii?Q?gwL9SldejFfX2n6vJ0Y+R2qSGjaYfzMBDfg8EQqTCx1CC6ILIbYz8jmBSDDb?=
 =?us-ascii?Q?5pUHU9vjr0+Seu1qA9SeXlaitZdpi2oBU+2AlBKTBXmGOQQKd0MleEhpOicu?=
 =?us-ascii?Q?i/syOHqXPUDqSTRHaLbRJ9WeX4tNKdvyeIDhxJFrPXkbc2UOdPcsTEFmoyHG?=
 =?us-ascii?Q?Kc+R7AiV1fBmoc1G9cfG8QEkqx9nEF40c2yJe1cy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21327926-6b38-4993-d729-08dbf68d1fca
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 18:56:58.9676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmDbYFupTItlLaCKLQgc3cLl5etBV3nAl16clfUno8jduPkWsj3pEuFVpf3dIQkj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9211

On Fri, Nov 17, 2023 at 05:18:16AM -0800, Yi Liu wrote:
> +static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
> +					      struct iommu_user_data_array *array,
> +					      u32 *cerror_idx)
> +{
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +	struct iommu_hwpt_vtd_s1_invalidate inv_info;
> +	u32 index;
> +	int ret;
> +
> +	/* REVISIT:
> +	 * VT-d has defined ITE, ICE, IQE for invalidation failure per hardware,
> +	 * but no error code yet, so just set the error code to be 0.
> +	 */
> +	*cerror_idx = 0;
> +
> +	for (index = 0; index < array->entry_num; index++) {
> +		ret = iommu_copy_struct_from_user_array(&inv_info, array,
> +							IOMMU_HWPT_DATA_VTD_S1,
> +							index, __reserved);
> +		if (ret) {
> +			pr_err_ratelimited("Failed to fetch invalidation request\n");
> +			break;

No error prints on ioctls!

> +		if (inv_info.addr == 0 && inv_info.npages == -1)
> +			intel_flush_iotlb_all(domain);

-1 is clearer written as U64_MAX - same remark for the comment
documenting it.

Jason

