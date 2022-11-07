Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97ED161F50D
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 15:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiKGOOu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 09:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiKGOOt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 09:14:49 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F311789C;
        Mon,  7 Nov 2022 06:14:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GISWsmNVChXyvb3l2Uh1/BMRowJ96QphPAT24kdst3B9YDb8uG4BNnbMni5mPzfLLcXMsWO+Zq+aCaM97qc+3bjNe3EJ+vAFhqSVEkDsT9J8rDDj0Cnt4P2u8DIsEbO2G7VRkx1KOVoRDA6+7Il2jgapSAKB++zp3zoZ4yM9Np4/fQf39yEN6u2nY3dShBPj7I8kpVt7KL1MgMtBndLmR0nNoZo7yioHmxyc+osYDeEGw8dHpT89x/Scjq9/EXxVpLnNIGeOM104ZilUD8abScHNrdxWdX1gv07JctukeGQnLnhc/TggZy4p/G8fQA+LYhjwtKU8kUM/VcN3huxHaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXgttaQfHltxyMWGO+zM6VumXbijN+cyWbgQHN5Qn8g=;
 b=UWmd1OXihNdj1+9DDEJtY7BR1uttHnb9SVRvsflMsGxOMMzdBORPZWktJkAcNK1cKt1SCnT1Pw4xeoq/iLpyht01ylP+UAUvBcbqfRFcnyC4/sY1n+iUfPE8CfiB+RWwFtzv17P+VySr57t7sJGfXRbtk2mP6VCy4CszfpGdlv5w6IbZbIz2cWxtr/RM1A1Fh0HjYbT27OzsKi1PWM8uOtSBZlWjKZ9OaLDYRvqmqXWunxv5irEKBscRd1CWJhX0aiw5OMXHnCDrN0M8iaXxMp5bM5RqrjdviegGga0TJ++ffrEeCtblC4bzNVpopgBO4nUeec9qh/QmKCZt8hYelQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXgttaQfHltxyMWGO+zM6VumXbijN+cyWbgQHN5Qn8g=;
 b=n1ZGI09t12fbKQfamEqS68Nu+gfk2go2JqgHXP0xpk3F79IhsamsqNrJIYgHsUpsHGQYHHQzGB/QTXfrukmtwOClK927KUEJus0uPx0MrlVi02CptQDFbMgLrT0T8yYzQy/JJKt0q+CnhmaAwbwwSmOu4RdBN1A6QvAFZb/IxZ/i5Y+7ctv7xkErIq/I29sJYaKCFCkdC0WQqRGrVRvUmfCjVO7SAPHKoC6tZZ8NzBUU6qyfgbePJhmXYPM3TBmOw1iQF+ZtFlZdLC1FJM85um9QpCA22ep3fxPPa8zs72DzrqiJbHyuzfaFMzPuJdh9MvcDWIqIYuMjX/KSxDjCXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 14:14:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 14:14:46 +0000
Date:   Mon, 7 Nov 2022 10:14:45 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 12/15] iommufd: Add kAPI toward external drivers for
 physical devices
Message-ID: <Y2kS1d8GUvdNQqVe@nvidia.com>
References: <12-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <b43a183f-b06a-6abb-0ec8-498e2a62f92d@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b43a183f-b06a-6abb-0ec8-498e2a62f92d@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0433.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c9224c-3e35-4ffd-af81-08dac0ca6c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U0sSzzRC4gJGucIzt1Afudy31Ee2i5cjnHvF5w7woeyylHBPAC9Ny0Z4jk3xG5j56rPJHqsqMChOstBIxTg0GzFjATku+pIO5kqflIsNRrIgJ+yeJXIUDgZihywE4wFbrTbddYhltn8MbH08Xdu8AEpoRSyd/VjMqsTMPhpCX3lbDFwgcOKXfHAbqvM/ZIOUe916HzKcvAyzE3R5OukxYXQc4MC+B21Ii40q4DkBW4MFwW0utyEotQaARED09QjQWUQHIYzSbMcOKPyq2qLYmhTIyATJlaFSpuI4xikL/Sdl9RDTB4/ZNgGMifktHtIKTIAZFM/mKqYHk8HUMjzgSIuOZLI7jGc/WM9mW0PKcKtsZ4fuJSclFnGKcSpaj79mKCLDTVrstryJ/O19jNy0OHY+y1C7bS0kAhVlwiIOrihPDxbAeEoHqWQEfQVhYtWrDK2HJCAVP4pcSMCKNnscMXm6pQ985sV3OZ3XKaomCHDBoBFc6RbY6mSLjXrUAn4735w44Xgihxr0at5Zu0WA+DUgbt3mZLDfJXcCFL6c8ygoJSE9WeNKQ2Q6oF6/ai+V0RUrM2euq04fZG+mZfbZjkUtT02wVVEc01XNvh9xY8+G/e507g1Qlj2Tle8RM/NFX7vdsT826ZS4kPTvr1sXrnai51AmBR7CWXWNXUQmjUSFKMKrw50PkFejpnTCTJmLSaVDNT64XM0rT4U+nnvpnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199015)(36756003)(86362001)(4744005)(2906002)(26005)(6512007)(186003)(2616005)(83380400001)(6506007)(66946007)(4326008)(66556008)(8676002)(66476007)(6916009)(54906003)(478600001)(316002)(7406005)(7416002)(8936002)(5660300002)(6486002)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h4QnparRh973IgdavJC7ZBZDJ9R+RglwoJW/fYZmEYJbt+wK3LGiQn7XRz7u?=
 =?us-ascii?Q?uanyZrHQsU1UVxVVJlY2tntMHsjMx6Gd6w4WJB39YkfHXjt+vqTPYbd4s4jt?=
 =?us-ascii?Q?UpQS4NeCJQTE/bMgH2yyNx4XzE0aPLKn5Q9Eenz6PgX7s0s7Zoz5rjkxIspX?=
 =?us-ascii?Q?IMT9HghEBgGjbe/zU4gWOOhyI0HbiBTL9ER8iUFXym4+QXk5AMi00d3z8/n2?=
 =?us-ascii?Q?OZnp4M/rHs9d6+2ynZwCEYcVtgmUokX2eIkIXuwrpM+94ixznsQs8dGXI1u0?=
 =?us-ascii?Q?kzywhg7/EXTQylkt35RtPROGc6UKZZCT+H1go/N7Tc3mFo0bRSUmvgpTjQiI?=
 =?us-ascii?Q?8tSymqzoAMweTBYqIgrbKL/NBPOUBrZ0EE1kCDA2AWGODzfwK5ix4uezCsGR?=
 =?us-ascii?Q?IDps1vwVY4LVmqtk6fxAgL/zEd3L4p96LVTe6JRUt8/BfrVPMrsxzrmuWf5d?=
 =?us-ascii?Q?70ZNPvhMlPG+cQqbnoUs+wATQGw5uLsiX9jTPuuRgX0U7qqyyIjrkOUN0XGS?=
 =?us-ascii?Q?wItGNq/LEtp8YVszyEdRHrVN5e958wwkPWqjhocNIZJGhhzxNyEXxsbcHTdc?=
 =?us-ascii?Q?xVDlDo4nWftp/ILW1w14+gb+XB3LkLBl3FRQt+mn3P6QUpafOO61407Sott/?=
 =?us-ascii?Q?NDTQXaIYRbqoMGCZgxW1fSo36uH85mgcTOcZ84+u/ndO5fUrXbwcknoklG1Q?=
 =?us-ascii?Q?/GBP3Epi9EN9co8iOXZcVmvU5PKEBdWahxgNJ1oTL0hVYmlKEhMdSNq2495f?=
 =?us-ascii?Q?9lo/zT7hWvf15xtj/3wvXGAbxwLPyhXgrFawWGxMpu0IEIBOlLnqEeNdC/NG?=
 =?us-ascii?Q?hm8DoIG8PHpvnysvYT5NeV9NTG2BwMU3JN4MHaL+RycBIwAS2YLW2nzqTuR0?=
 =?us-ascii?Q?nVYlBMpi1Bdi0cSGdHURMhBoNOoKS2diRo/nooxW9jsIYhVsDcr2LICTwcMr?=
 =?us-ascii?Q?bca+ZDAp8aKp3Y5akYIg2KHO4qZXF1zWJBVvR0JEuHtxfp82F5aXH3kRYlar?=
 =?us-ascii?Q?72CkUXOM37D+EBu0779B+Mgm0rynA0EbudPuVqdgTzt/sod/cLUrCsd4+c8J?=
 =?us-ascii?Q?34ls3Fl3OjEqfVt4BuRd8X6lAZ8RwyJlO5ZhVKg+HucT3+15srwTSGzz7mJ+?=
 =?us-ascii?Q?bULXFGDAI4ZKUHf8ovGlODmw+2ks4Crwy3T+eDQIoHy9YCB9EkHZi38jLfp/?=
 =?us-ascii?Q?JwyK6UFfPfHAAHSBvw+asgzzAOzlQ+OnKG6bzjyonEodg4hUSvZlnUqGgymA?=
 =?us-ascii?Q?zbo24WGNpB8Smbx0bxXR0LHsxxUXANaEhkNKnP0Sw5h/O8MsMEQ17d4dQd0P?=
 =?us-ascii?Q?+EMVQ1ePyBh99GbLPLsSuQRG/gFkVkPJqA12hmziH6nCZdXV0OpWxT1LuztM?=
 =?us-ascii?Q?SRNi2BNKC0JN/O0AxYEkGakJWKqtdeCJXoJofCz8TTCR0EQfbqjxBqvb65dd?=
 =?us-ascii?Q?ESsr7qF/xQrGkawM+N6LVzzP9lOPxmPwOukZVP6fWWZWfvisUKpIGn0aPS1K?=
 =?us-ascii?Q?p48fcZDawyvH+hMJ/FA9Mdv2kK24RFJ0bytFnoh9RVRZVGbegZPmjVmSLTw5?=
 =?us-ascii?Q?MW9bxMal8WA7aGgXzT4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c9224c-3e35-4ffd-af81-08dac0ca6c5f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 14:14:46.3307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1QBQTXj3fIxBpwkjVGkLrg8ab1AGmdoJTwMkoAM7nnCzFCuF9/ql5HBN/FzkWXN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 29, 2022 at 03:19:36PM +0800, Baolu Lu wrote:
> > +		rc = iommufd_device_do_attach(idev, hwpt, flags);
> > +		refcount_dec(&hwpt->obj.users);
> > +		if (rc) {
> > +			/*
> > +			 * FIXME: Requires the series to return EINVAL for
> > +			 * incompatible domain attaches.
> > +			 */
> > +			if (rc == -EINVAL)
> > +				continue;
> > +			goto out_unlock;
> > +		}
> > +		goto out_unlock;
> 
> Can the above code be simplified as:
> 
> 		if (rc == -EINVAL)
> 			continue;
> 		goto out_unlock;
> ?

Done

Thanks,
Jason
