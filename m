Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E3B6C6AFE
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 15:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjCWObE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 10:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjCWObB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 10:31:01 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0361F490;
        Thu, 23 Mar 2023 07:30:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0H69iRME5ffAztq/ZcvSMFNsG0BW9pBYbrtiA/C3DDgWrDWwLPegYO+JGBfKiTXNxI2wvL1vsv+Hn8kav9S5ZZGw7gnH9blvD1YUCb4zfUUkTpipntzvvEFV34qjy7goxCSK5R9nLVpA0za4ac5E0Uz8ggq7AWvJYEchnbw0+FVdBiB4I4aaDVFcNurI+TsxpzNhyLfPpcJB6qNAOPe4Lv9fkag2k3F4IZkvYCgnQ78B1gbHuD/J/HSeSmOY0qP4uOKacskwwBcwwmv0/vHPJRNeoOZjkIj8Y6qgSbOLE3aDA1Y5gxf/7JY7e5gGpjNyXyVJwxfWXryjF9wSScjJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3YRn40NUmSb7Mel9mPmLWw5tU1BD737CQQAEZ6Uf4U=;
 b=NZET2iuWz3USqHc9TWuWMvYrYffy6bX5ufNleUddL6CR5zliIXUS6N4vb52b+evmtB3dzqtNeAolPaUL0ilnQxwVT/zHRolCtr176CWg95pphjNYBIuMpY14satgjYoYlK3rE+RMqsRg8ZTgjtb5cU6I1gNkMMeXkZODNskFdGcDCfMyeGaYpWRG6wmHr/X8DD1u+Cy/d/89i8kzlkmr3WNaItEiQJktODv31bWJ3/kDVtbPbwFOtFpR66OCLzzRgw5mHXhOb3sT+UulWsIGi4st5kVn719mCMiLipE0BhybSrYYTfS8USz6f2ZZ8KNjJuv16ESNQuDJqFRUKDu0uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3YRn40NUmSb7Mel9mPmLWw5tU1BD737CQQAEZ6Uf4U=;
 b=Xllku7w78CkNJOd62pEj4mp6dpsyegMqRpeEzXKM+l/LwUfD0xwh6rt4gr5RpR7+FjaKdVFGOcAfu87SAQRWhzEdZUjpUPUEX6jREWqe8JcrytRSo+/LsuRRWtwh6grZapht8w0pszE5oKfiTF7tNAh/hDbb/gAf3bhw3HKEYn+oB1fxHoQbNxdlvU7I8qycfJ41JTHMx69LY98QgBt9+MQs7u5+MZGIx9YFpc1U8F8vYQVfy6rYMgFXQkwm62YeHb8gW8HrVPGrqgidMp/Nl7vjOGDjugdK768t43BmHemrV1C9YpQpw52rvhEThfwASsQpvx9BdEvm0tCC8tfDAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5498.namprd12.prod.outlook.com (2603:10b6:510:d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 14:30:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 14:30:58 +0000
Date:   Thu, 23 Mar 2023 11:30:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v3 12/17] iommufd: Add iommufd_device_replace()
Message-ID: <ZBxioEDUtPMro+ew@nvidia.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <12-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB5276B73DF56654BEA4EA51AA8C879@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276B73DF56654BEA4EA51AA8C879@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5498:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a06dc5-6f16-4284-c276-08db2bab37b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cL8wxIjGSWAqauCdH1JLc3lMDkJziG2sHxIKuxY2fL3JfxNThOg3auzCx6sXiU8suOGQcziF23CqLZCO+i+4NiJT3ynzK+6h1utMqR/8mBrvs7NLarzIh4ga+TcE0vjxW3PpkRajJKWQN6VJk6214xUZT9Z9qJ6Z5PWRD81DFxi5b5m1Dh5jyoyhiwr3DwmlYk0TYiVhr5HnAavEHiIDVuBrfWZPd5W82KQ/2Lds/j8vyjbMBsY/In0SL4E4tsTLVyyVNQfnfhG0YKISuY4bJwDWGo8i/ej1HYtsD7ooc4dcemRugamqijP+xRYUXJVFsJzQJCSK2O1k0LgFbcIxJMJnE6HEexZmzBTwoUyC3UIbEmn2kB7Nz1cFP94e9xtVTCU31Qxaq+yoows+IHX5x1Bf2NufKHyxIQBVoIUKHWbREb7wjH8COQPcE68IK1qMWuquYql1650Eh1uJN0NecHQd/RKryI4MeUX6u1H2pxodvfmwQn6E64oyu3DDdRrcYkC+i5V9zxNeETfGkoLZjZTINS6RQ6rgVZ0VDHfkjdwbJxa6xlxBxoLdrEOLB6IGUydlBwG7qe8+Q3xI1tCng1W9kIc5Wtg8FNj2WQot9zNuNFmBgckYjP3pXi5+XPZD7DHw2IZnnj1qHDf1NkYUpmLUBaWHT3nOcXgwTtn9/dyM4aM7EnSbucM7HT82T1zv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199018)(86362001)(36756003)(38100700002)(2906002)(41300700001)(4744005)(66476007)(4326008)(6916009)(5660300002)(8676002)(66556008)(8936002)(2616005)(66946007)(186003)(6512007)(83380400001)(6506007)(54906003)(478600001)(316002)(26005)(6486002)(66899018)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TgiJAq8Z+KXLNlawvqT9Tkg0iV3WESuEUTkeCIA2fPkjoxIUEtkDQ/j+/lRS?=
 =?us-ascii?Q?gkkxXY6SdMvs3IpLpYL0h03MJarYQ/mk6weBkC/W9EtQjbZuxHkqsMP4DcyK?=
 =?us-ascii?Q?6Awn0R93ai9v53flS5VHQ23BuDBH6GaJqpfufTMw6kDtxYjoL6grq7eo3A6e?=
 =?us-ascii?Q?LivO5TDlZ27Cwca4SoG4Ct7t4UnaVZa0zkxo7BUsTsAsvJtLMVejH3F7zhcl?=
 =?us-ascii?Q?XDaOUkmXCV7hVFqN1Xf1XreCFzZbtzbgZqAwmpRa72i7g0XKybIG7sskEEfn?=
 =?us-ascii?Q?yxLOt+/iQwmWKBnAjDCyPiNxKNHtO9ZLSU2C+hKya3628z3dqAHSH55+uWwe?=
 =?us-ascii?Q?0K1rlUVzn5j2XOV4iYHwbtYQN9oi0yvf68B/5my9imbq8ve/eRq7Up7ubZwI?=
 =?us-ascii?Q?3BVj4qug2hNjjfLG7O5oLYohPXGK7Me2KrZftzxT67q4d8jWYX4YyfJOHlpQ?=
 =?us-ascii?Q?swWS/5WY1yxmkORr2KIyvzyx4qtfUq68jt3DzLvvfMrNza+y5u5HY21DF4fd?=
 =?us-ascii?Q?Pf91jTatBtn5up48qGrtuKQ3OgsBZOfo80VP5a/PNxA1ghgNMttJLfutQDKD?=
 =?us-ascii?Q?e3fCWvNGgR/97KQmv8wByDK7k9OJeBoqY4o06xgIp13JHcjyJtcUxTb5uzHq?=
 =?us-ascii?Q?6KPQ25wqMX0H4+MGUEJ6OjaZmSHcNY0YnL0ISjbOK/Jyt3tuol6y6mCtY7Nf?=
 =?us-ascii?Q?rMJRs2bWYbz9zrcjQiXdp9p8OKUvgAgAx0yXNTWO9jZA0L95b3yGHKrvVfyi?=
 =?us-ascii?Q?5CpHOB7vyE4Cm/9pXL9g/aF3oeoTKwI9p5CcBqzXxG0LBgz/j+8nd9hX5d00?=
 =?us-ascii?Q?qqXOOcuXVrDJQZSgqXUiJXWw1VYvLyx+8SjNWoZIitkPAgu58DQfD7E2b7Ek?=
 =?us-ascii?Q?ESE6UM4EFLcrG3tkcfiFw2+zmBJhLx45zzjup4VZvAs0c00grnKuZRr48Qg/?=
 =?us-ascii?Q?gPa5sW0gqWqZhe1uCAyVe7sENcjK9/0FSm8wgkbpsNwS0ClxDLzFREn3SWMi?=
 =?us-ascii?Q?8HOb9gHOL7eUpavuSKaYDkzcwGKKJAXnpyWG6KG9cIdNq+7yHYHqL9gjRoEG?=
 =?us-ascii?Q?aMpsk0765+WO8hH1l6LC904RtMccYqNd4wsuvP5OfCEifEu23Ym3+Ladoy0+?=
 =?us-ascii?Q?szYjDp9xn91AHcJmHsb6qlMc6TmOYFQPudbz1fDPiO90CAIFhumOZ7kv76o3?=
 =?us-ascii?Q?R93XGOLA67Q/65feU0bIs8wq73kxl6C3ts2FhXOnqa09zkN4Jr1QuPtDXKio?=
 =?us-ascii?Q?eoUSq8v3d0lMmAbu5hf6gDHDRxnp07Df4rtvPDlJ0/DGBMlmT87rWQrK/7lN?=
 =?us-ascii?Q?UeiNgQhguk/LMbZ/AxmnrU0eDxMvRGSBoKTbZZJ3ky4T+uZcno5gWV17OJin?=
 =?us-ascii?Q?IlETX1UmPLUAuxdp+2meGBZHbjRF/PfDpdtEjfLQAdtcZOvYj/AAx9z+e+gA?=
 =?us-ascii?Q?u1kT+CSRWThO36LAJ0mPYoi7K8/cQmJ3UKOYBauFvvmHKoaQmkrA5H+FpHwD?=
 =?us-ascii?Q?yTzKI445t3F0mU6dkDRx2VYF0DXT924VTS2F3HgjWoWfEeB9naJr1N+EDtQx?=
 =?us-ascii?Q?6Yr0hquaXhQSCqSfQZtXchY4RsYsd4srcESXkAxO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a06dc5-6f16-4284-c276-08db2bab37b4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 14:30:57.9239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5PqV94KM7lw5wwSnEy6/zZ66U5dZjWprSaXs4M1lHsIzgbiLw3PXCEMuWJ/sIzS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5498
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 23, 2023 at 07:31:02AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, March 22, 2023 3:15 AM
> > +
> > +	mutex_lock(&idev->igroup->lock);
> > +
> > +	if (igroup->hwpt == NULL) {
> > +		rc = -EINVAL;
> > +		goto err_unlock;
> > +	}
> > +
> > +	if (hwpt == igroup->hwpt) {
> > +		mutex_unlock(&idev->igroup->lock);
> > +		return NULL;
> > +	}
> 
> goto err_unlock;

No, this is a success path, it should not jumpt to an err label or use

  return ERR_PTR(0)

> > +	/* Move the refcounts held by the device_list to the new hwpt */
> > +	refcount_add(num_devices, &hwpt->obj.users);
> > +	if (num_devices > 1)
> > +		WARN_ON(refcount_sub_and_test(num_devices - 1,
> > +					      &old_hwpt->obj.users));
> 
> A comment is welcomed to match "caller must destroy old_hwpt".

??

Jason
