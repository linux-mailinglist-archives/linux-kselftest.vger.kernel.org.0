Return-Path: <linux-kselftest+bounces-1315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80C2807818
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 19:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11EF1C20B0F
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 18:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C79645C07;
	Wed,  6 Dec 2023 18:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QXlC+IZ2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B8610C6;
	Wed,  6 Dec 2023 10:50:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqxS5DbEH8sTIZ4p5Ma2s9Nk/3CJlrAfYRd/5CRuOZm2p8wFBViAoOKr3yBzZl3U8PV6BhKS1kxaWBC/fjDpi3zaoNlz6KYU92Hx5zucqVEjhsqw4SiYj3wtPZGRFmlsP94VU3ILgO1NdNgaW40agEnH2bw2CdYuuZ+9yPjR9JfV2Ph1AWak5viv38qQk+OiuGlXo3Vy+/EKEmQ3v7xhWzhbt04ethFTX/Ey6p61rUWX7kOJI8jGf848FHIXyqMQAhUS0EG90q/unZPv7m5li33eFpcgCESOjOjeuco0qvr566HVgUyPkARPxYuOTDwSxFRrND6gXtRt4w6SC+vxuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SatkdO+hNE2tu2QrTSOMjkTks5OvAKaScLVkTEWvIKE=;
 b=QV29APwhdfKzxspoAl+/P9bjBe07QjCY22NM8yq3AJePbEG/rXyROP4612Y/X4YpqyfZpypQWFNep+JTas6+U1OMWzNFxUJILZzVRj35ctS9vHAHet1/VdiuVz3Hao+IgR1B5GgbJTC+7UNV4VGZYAT9+C7vlJ7bGBV6xA9m4N9WDRo/38mv+viWVsSZRohdhEGZiD2NIwXECHCuDuuQKP3+HPmXrWtFL2BzwVvRbC1Z2saNa7cAmc2YA0/Nu1QSUgqy9HeYu+cfR+4wYWROwufghHrNgUlH3Vttcs8fuhWWcBpe9OUY9v2GccjXtvhqMBL+nMc1jMR+4NEF1XKNwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SatkdO+hNE2tu2QrTSOMjkTks5OvAKaScLVkTEWvIKE=;
 b=QXlC+IZ2Wvn5B3bDa5AOhbMDbZjvyL/gSvJdu9OItYTPtGCuffo8qFSuWtiSOvEzEUcNLJkhPrVRsCn5tZGPjLQ+Ww/C/l9suHVOrbtNxjnJSPuV1r22P3+AoiAUMucoWtJEFXi8wgwc6YxHO7lz3pNdNmhpuakjnep+Fp/lBXZ9EaLZ1TIXAjuiPRT5/2XM80Ui6fvErsyVGj5acOuIzHTAqZSz1hZDGv6C9AymWwLOKjLuO2leepuasLzZ7mFQMox6ns8enbOQ+ZXQeeMXF4e4ipjft9vyhxIFXoL+7F65/E7Y3EU+3PoxKHf0AZ+zSqpfUaCejtWyPfuPZsawaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB9152.namprd12.prod.outlook.com (2603:10b6:510:2ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 18:50:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 18:50:32 +0000
Date: Wed, 6 Dec 2023 14:50:31 -0400
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
	xin.zeng@intel.com, yan.y.zhao@intel.com
Subject: Re: [PATCH v6 1/6] iommu: Add cache_invalidate_user op
Message-ID: <20231206185031.GB2692119@nvidia.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-2-yi.l.liu@intel.com>
 <20231206183209.GZ2692119@nvidia.com>
 <ZXDA1uUzvxmLf/o4@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXDA1uUzvxmLf/o4@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR16CA0065.namprd16.prod.outlook.com
 (2603:10b6:208:234::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB9152:EE_
X-MS-Office365-Filtering-Correlation-Id: d80301f4-1b72-4497-5df1-08dbf68c39b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XDgCs/KbTMuf4bWdjH3COZu/Jv1IW2MynqDWAF3KSVPC/2wtuSxl6MDlmfDBMmngTgGxLN99/eMCQM41/6ZYBZWoI9PXyfFuQb3i0whxCfrICtXo+re5a1OHJeAexdz1BfocdTSJpSwn4likAnNgCrjas4D25IHs2hdFqyxnPhR3uGrLDqrprnv0cAyfTJB4qtuGkK0tLKKS2XMjQ+j/IjKU7xwZfeMDijibcK4RD664GwXNLV+gFOLgQsjB/K4uQHlcg2gnnpZJeuIKNhAqCX78Z6mX9oJzrO/wnQoVBN7Ip1BAxGb8SDRBz5HjtKhTAtvr7E1w3psy0V6n6FKZ5Y5aqOH4PeXfZ0fC6ojlN0WVkIq641mMl+exDt0gXFnF6G/3fJy9yJcN0k7yKgAEoIWnWGw1xEtEOLgfSMYm0Ovj8B7Aev0EFET6BgTQbmu9tm5eAtdNotyK0sGPPs+rptXi5IKwrxPIlhx8aa9/K5yOrEmvGjX0Srd+mli3yNaX0f1JN0ZdqR7bxzFCQNpYOiCF23lsAmeOpjKUJRZ8yGY2vvYB9Drk5lTnqiKln8ba
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(6506007)(8936002)(2616005)(6486002)(26005)(1076003)(66556008)(4326008)(66476007)(8676002)(6862004)(66946007)(37006003)(6636002)(316002)(83380400001)(38100700002)(7416002)(33656002)(478600001)(36756003)(2906002)(5660300002)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?edxxcNqAi3vwqB5kKA2ONn01Huk9XHgjcV+QyuzFW21okKB8PE9QEpWZYWlS?=
 =?us-ascii?Q?IcNGuPqNtpCQPiFjMIc2KhRPH4qKGb8GKxoAmr60P0Jcp79/MAz4CbogwZez?=
 =?us-ascii?Q?diEQRXQsgAraMZydYvwkFSLXNQ9lgsZ6Yng6qOslLsxIKbkxU3bhQxN2l9Sa?=
 =?us-ascii?Q?asKtP51esXLqxS3p3BJNCUHYeev4YZD9YgVDI9NAzO/YIriiIJkcCt9REU85?=
 =?us-ascii?Q?qunTFMCQFF/ixdvcFHhy3/hySB8Z5Hq7xXsd5q+2G2OIf6ASt/BubzpjMAg5?=
 =?us-ascii?Q?pXDXSUx4+RJGulLp84i3bQhPJrMydntbHYVaDXqChHxtg3zhabGR65MhaW+n?=
 =?us-ascii?Q?wRDQpQSFLzVPFrvp7cYEupAIgGuwvpz8fgHifDJcJ+nsE0DVXptHO5dURxsA?=
 =?us-ascii?Q?D3TcjXgBQhsYf+tjAie3KsPODDIyXfRpIT+PNZUdNzjB6iWcb9V0SwPksxev?=
 =?us-ascii?Q?FUtae3c4ggiHn7R6SCHIVOFa0HwmU4lLYjs7prFze6alprC8BV1+0f/DAnLu?=
 =?us-ascii?Q?w8eDvU0HS/EARt+ez5717lX9X+CMjXb5sc73aitso8M8Y4zbZyKA5MYFwXAS?=
 =?us-ascii?Q?v9kA9lS1bLkz3VVZWZlkw3w/Tba0T8HN7i7Jxlg1SCdZFGwyy5e693YbLnTo?=
 =?us-ascii?Q?RtEuf3jSy6Z6BDGNYIoI6hSAXF9ZPMYlrv779SdM2w4YTfunq2M8n5TnbMtH?=
 =?us-ascii?Q?M1rfNnusagMKmZGFRqNGGhCrdZc/O5lw5HI4H+4zdCC9e/ExAYs2VyrivwwN?=
 =?us-ascii?Q?93n9jr4MiRpt0go0+LwoTSbQa2LGy5uKolssbMwFbjvEiQ2l0LRcAvZD7ZbK?=
 =?us-ascii?Q?8NfhXYZYd0Qo9de4wN0LLmStDasLe8SHJFw4uw1Y6j+c6E4DIZy9WIsMYxIn?=
 =?us-ascii?Q?ClxHpjPr4oiuNFPSuVeO1qdDrgVob0DEUTahsOd21CNBtEqffwAKE12mXeq+?=
 =?us-ascii?Q?pldpg6ToUEQo2H9fOVIoELvt4XZ1fJCjfgvWIBrwVUkdDx8+EIGZzot3Eh7I?=
 =?us-ascii?Q?aTV+8EIeZoQeyA0HezWQ3aS/WuNlY78wNcXkjCvejwbKwpwt283DxE2KyZfh?=
 =?us-ascii?Q?2HqlGIeIliHvgfiL/C60lOhR0hyCaByznO5SOKRozj3UtRGGHnpyGl44JSQ5?=
 =?us-ascii?Q?MvRggO5G3fmB5wS9YlxcSnRBP1vTTG8nuLUIrexgTzMrF20pFDNbrX2XBrjt?=
 =?us-ascii?Q?97+o4KdCuXbsgWBJy01A8enEx0iQjbVKt8e0IzrlC6Kk/UuOVU9lh13uXtyk?=
 =?us-ascii?Q?H44Z87yDZdpjjIRFnl4JJyCw4s2cfgH2Bk2uE+QhiXUjfbuk3J70nWPm+n1J?=
 =?us-ascii?Q?jhqPs9ymf9wiCf4Y3VZOJ86wZ/3rAoVNN+zsdPEUUKs9qG9STOO4IsQvBq9f?=
 =?us-ascii?Q?m5DfuUxx1obriqT+WbEEwM7afjLFEewZ54JUxvd8gpEPYCFQNDS1nU6i0bjT?=
 =?us-ascii?Q?1k/FfE1Qgj7V1bahRviOKV6h4/2ZrjGhSnRRBaTOTaz56JD7Hywc4Pb6zoWj?=
 =?us-ascii?Q?kzwWcb5cdS6UKGJxYWZio5ZbEDHSoW+H8ZwZyuxbwD7FocHQoKdAV1Vl/4Yp?=
 =?us-ascii?Q?vVwZHPNy8p2YopwNCRBOAz4ra9l4NgVFqCUs6aus?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d80301f4-1b72-4497-5df1-08dbf68c39b0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 18:50:32.8174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UGa0nsXNt3+vEf/j0jgUo0t92/J4UDPsDlmgzeUozc/DGyQA+2Y3+Brwq55GZHYW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9152

On Wed, Dec 06, 2023 at 10:43:34AM -0800, Nicolin Chen wrote:
> On Wed, Dec 06, 2023 at 02:32:09PM -0400, Jason Gunthorpe wrote:
> > On Fri, Nov 17, 2023 at 05:07:12AM -0800, Yi Liu wrote:
>  
> > > @@ -465,6 +492,9 @@ struct iommu_domain_ops {
> > >  			      size_t size);
> > >  	void (*iotlb_sync)(struct iommu_domain *domain,
> > >  			   struct iommu_iotlb_gather *iotlb_gather);
> > > +	int (*cache_invalidate_user)(struct iommu_domain *domain,
> > > +				     struct iommu_user_data_array *array,
> > > +				     u32 *error_code);
> > 
> > Regarding the other conversation I worry a u32 error_code is too small.
> > 
> > Unfortunately there is no obvious place to put something better so if
> > we reach it we will have to add more error_code space via normal
> > extension.
> > 
> > Maybe expand this to u64? That is 64 bits of error register data and
> > the consumer index. It should do for SMMUv3 at least?
> 
> I think Yi is moving the error_code to the entry data structure,
> where we can even define a list of error_codes as a driver data
> needs. So, I assume this u32 pointer would be gone too.

Oh, lets see that then..

Jason

