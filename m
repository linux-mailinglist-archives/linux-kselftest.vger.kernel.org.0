Return-Path: <linux-kselftest+bounces-1311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BCE80779D
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 19:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2AA2820F3
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 18:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EE536F;
	Wed,  6 Dec 2023 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MNCKfz0I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB7E122;
	Wed,  6 Dec 2023 10:33:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5+ZP/FAGdyUz6fZ4qa+W92H69Rc5ca+ou8I/eocnBpG5a8tYwsNoU8yZM/Vv4GnDtPR44DrFRbOYGb2voUc0wf0Okc8ne3mU8Q1BxdImBC7fREjsC3D0O0Safqn0hUYUzLUivBiRFWrrTXCckCKBgWTGkQrAi1XVrD1gJnGMifLHB/G2xdvW1cDI9YupQwKo1abHq7/6M8xpChBSlsajFQcCmCS6GROw2WgMl2By5jKBCOlc/ahmdHism9gW3ZX9VJZqS7y8Y61X2QG8X0er+gXZ+TDNKHaUh5KKmnWvDjJ0MKJlYCKEUeY99IJMWP1ed7agfajoIiH680KjsyEDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVpyAn4mPlzj0VTK+lRp34jsIrjhl7sz/wv9bulDzWs=;
 b=GrlUOB3S2CYFx7Dfe2kRiT7XooX4ebJsaeDaLzLwRnB7AQR1hgI8CYwq3p+vO+f96b02UxRgL3bcuQJPX2VjddgB3tiorXgY5cXQag5/2tx77sU1BryiAzD+O7AaVQFbPKtRAfdcR+cQjyQWX8pEApv8p+2aLgrt36ptmtr+/8Vr5Hyc0cqyGszhzCL+xi+UBy6TKd6CGA01zLoMfifMnxVyyipKcF1VADAD/swqF2uSg9XTdKb3CRhAhYm2QFZqiIADyNOib7TifzIezNPVNn1mEkjhHurFOztCwL7Y56Ga3+TEV0CzcYDUWgMLPrQb9Gp9zuNvDjz3HJHZBndqeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVpyAn4mPlzj0VTK+lRp34jsIrjhl7sz/wv9bulDzWs=;
 b=MNCKfz0IzVWCoiImUD2fd4ZlRkxUtISsXEcbeRTQWq/qpRZWSPLUhFyYADBzd60Viizokow1ylhzQ/v6qzms1I7XGrAaa9QcF+Usp2Zp9SWXqlinXQ94NvW7TKQBSQMm79fzOg96+UtAZ8+lZsARaCUnR0BlkZZ/ffmqCvXQc2Q6FxZHULIxs8mTd4TD5UcYrq6DdfJrP7UOKn6Jofiv1gQeQ87cowx9UbfaRf/+trjxfKU8Eky9vUEn+UdxD/hmcmZs69/eLytL2oXtal3R+O5C9swpHbJ3Gplu/7RXabR28IXqTPjL5xNeV7wifFxyWYFZuQfqXSGbGaOlJ4TGNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8930.namprd12.prod.outlook.com (2603:10b6:208:481::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 18:33:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 18:33:01 +0000
Date: Wed, 6 Dec 2023 14:33:00 -0400
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
Subject: Re: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Message-ID: <20231206183300.GA2692119@nvidia.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117130717.19875-3-yi.l.liu@intel.com>
X-ClientProxiedBy: MN2PR15CA0065.namprd15.prod.outlook.com
 (2603:10b6:208:237::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8930:EE_
X-MS-Office365-Filtering-Correlation-Id: 610beef8-f223-4ee4-fd38-08dbf689c727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i3z5EsCRAaz0WH0FR0oexnXLqRrITUsMpbhLi+YhH/+a1Cw1vnUEOj0KK/wIq8xMfA1HJKmiVeWQxbiwsjUfTOKiuU1Uqfw008M7mBUEmpjVA/G0iReHo7/N3vTf/lg2hToyJLBinIFqoxXI02sxE6tnimFw8ETMhELhbYdbzGS561i9P5FqUCUHfyM0Em5r4dT8IPwjRVua3E4FmQ8sOgzXHbJFy3fHrI6WZpWcTM4zHK4l1BInxligW2deXr+jAnbnzF4Q0VDOncwOV1H+MahTREZkBl0VSYvH7KNmcHe6yPOXp30Um5iMybTlFZljy1kVLRDfXXszxkVZ5SF1/bkcGuVHBn5a94XBM16H5nQ8gXOO35p3qgE8NcUEvlB5vnlfqDSLEEj5GJbl2hOMzPEJ/bx6voa2JfxUBJRFRAnDQKnlQ8EQw29ALehnPP0NKByx3eS/mRocjcmD1fc+Tg46R10HECOrQnYc/7f/1pP9lEHrmDnKr7VbI1g67C+N1rrODbbmkqt6LRW8h+cmU/IFE9lJFvrV+gywnRWHy/BMqAyZow5ClDHg1HgFP7Ud
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(7416002)(33656002)(2906002)(316002)(66476007)(6916009)(66556008)(66946007)(4326008)(8676002)(86362001)(36756003)(8936002)(41300700001)(5660300002)(38100700002)(6486002)(83380400001)(478600001)(26005)(1076003)(2616005)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WiLUZytmuPZlz3vru5XraXNa8BC6puODwl23wpgb8ZB23aPyYWMON17wio2U?=
 =?us-ascii?Q?LTuV7HwAMFVhTZyJrOHvELi3hLY7zjbMVVFnGlhDvAOhR+mk/nLJF19Ver5Q?=
 =?us-ascii?Q?INQliH7D+s/ni6XY3rwdBUD3OPuSkPog0xmHbxgwJJjVAPL2PABcs5EwhgqC?=
 =?us-ascii?Q?3ExMg0P2D/87M1CtPDG95KR0qPXzg5pOY5wF6O0pFmE+aVdFwd8YCSjCegzU?=
 =?us-ascii?Q?Od5zBCdzT4ZgTz+TREhQLK7AM1leOZ6wIH7p7qHBY8PNlCY8pGQHObo+mlFW?=
 =?us-ascii?Q?b+DvArYIFS3M0qpPSfAjJoA9ZeoNP5coHTtJTdcec0wxu8VZNPXOSFrPbLmT?=
 =?us-ascii?Q?maJCcjr95djv1qhjfZnO5dqLJofI3RiIBumJ7iDJQlNmVYM8cYUEZyVl9XbE?=
 =?us-ascii?Q?ue3x+SM6EQqmGboEc71gNwjJJEK5Q0vG5RaOkDxIASCGwRj5wVez5SKJxXlC?=
 =?us-ascii?Q?LDnMbgqC0OpPUOUFj89MOo6LkU/usPUCtFj4cMFaZx49EsqrdzO+Y9jjobYt?=
 =?us-ascii?Q?P1Mz2iAVr35R8vKATG1q/HRwQITOrjFzvE11GzVcpM7/WEeXzbumIAuZKChe?=
 =?us-ascii?Q?wLeYuttdBmPbdWMDQA5+Ri3+Hz71CphVEivo3JVruAqSqEvz/OwTriplGBgw?=
 =?us-ascii?Q?pFD1XEEFHvoG4xlm+lAq0NWKDZkY8OMrx7Xn5DIkxN7hH67/9ZvRjEZfHw6u?=
 =?us-ascii?Q?mph+A5yHM8LoPd4fS4APFTqiaE+EPEFVsn0mmXyML2v25PB49uOzUbfJJNj6?=
 =?us-ascii?Q?H6nvEFjqtDVqVw1R2f7FSJ2FnspfCFcEMk17DUXzVBAS7fxNxHufz64Q6+68?=
 =?us-ascii?Q?k6TT96b0kT72qRd7iXZxzXzXbJNbWlJYbrHYGal3jlrN5Bxq3W2h9Uy7fD3Y?=
 =?us-ascii?Q?b6nrnNVbQfPYA5DJVq7Rq8YqK3zsK99+Hy/E2zjpNH6cOyuygVjVVt1J4pQn?=
 =?us-ascii?Q?Zdry8XMVI+vVkGc5ekueORdQ8JeqgW+7Ukc/L/jBumR6B57ZHCTKFzhulNUE?=
 =?us-ascii?Q?2lZCxOfnQW5wBfU1h39TWvtDY3/5x9OIicDFGvv3nfhBb12Cvt/G/xCQ/l8u?=
 =?us-ascii?Q?AzOXWg/+iWGcRaTOn/eWVY+Z/mxGg7Sm64ghXq/YuSBsfB+Y1ttxU94m5wXN?=
 =?us-ascii?Q?NxqBAur01Rugu6irt6lQGmishMsn+SO9yHCEjAkKlYoCZkNeH0f+bWui95Pv?=
 =?us-ascii?Q?PMNb+LX8PojHHACxJpCb/3yywuve/y9yq9DOg4Qq0CU5g3WsAM3jR6Tbw2VA?=
 =?us-ascii?Q?yC7/CWb6IPObPhOkh/q/4AjT040y6L/Whl+VQWYOgIBZxsPKAOegM0vcQHr9?=
 =?us-ascii?Q?sADyLBTi2ayGodFgLR1QtDL51De63GMVdbzQGjCpW7RzMJ0Cx7H4bglFypzl?=
 =?us-ascii?Q?Nh0at99SBzdf5l1GTUSXv7id35Tmp3YY6+1II1kRv2Hx0PQOs0OKfKGf4DS5?=
 =?us-ascii?Q?fzYfdloNxZvguk8RRRaRkA8RuZ34XSnVt9zKPs1TyDjK9DG0aaZX5tM9zFyw?=
 =?us-ascii?Q?V2Eu2NW6zC+WdPE3cH7Y3IE/YSAqMtye8MKLq6pD5+qQbF4k9x1IOHP2cUxw?=
 =?us-ascii?Q?ISxOLRlg09DkhdPx3yC8Khnt/arB0mWt2WVJi7zv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 610beef8-f223-4ee4-fd38-08dbf689c727
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 18:33:01.6918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/xBm6NlJJCQr8Jpk2PG8b0wLMUggv/SNTinlQjS+Pc9fx73ZgLBPxVd1nVyPKfM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8930

On Fri, Nov 17, 2023 at 05:07:13AM -0800, Yi Liu wrote:
> +/**
> + * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
> + * @size: sizeof(struct iommu_hwpt_invalidate)
> + * @hwpt_id: HWPT ID of a nested HWPT for cache invalidation
> + * @reqs_uptr: User pointer to an array having @req_num of cache invalidation
> + *             requests. The request entries in the array are of fixed width
> + *             @req_len, and contain a user data structure for invalidation
> + *             request specific to the given hardware page table.
> + * @req_type: One of enum iommu_hwpt_data_type, defining the data type of all
> + *            the entries in the invalidation request array. It should suit
> + *            with the data_type passed per the allocation of the hwpt pointed
> + *            by @hwpt_id.
> + * @req_len: Length (in bytes) of a request entry in the request array
> + * @req_num: Input the number of cache invalidation requests in the array.
> + *           Output the number of requests successfully handled by kernel.
> + * @out_driver_error_code: Report a driver speicifc error code upon failure.
> + *                         It's optional, driver has a choice to fill it or
> + *                         not.

"specific"

Jason

