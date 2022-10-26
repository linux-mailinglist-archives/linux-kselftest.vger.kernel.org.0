Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9099360E607
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Oct 2022 19:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbiJZRB5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Oct 2022 13:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbiJZRB4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Oct 2022 13:01:56 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E079D508;
        Wed, 26 Oct 2022 10:01:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFKdECJe+d06k4+Y9HIZXACOQcpDXVwr85rqW8Z3M63uLef11Muh3zMsHpDrdygqRzOwo2IjwMf9ZDj0F1LqLzCo7mpyxO/5s2+krEJPgwwaZTzSFuzT/GeB4f3thjgMlZzJNIZLPDmVTL54yHGu2R0TlmFuRXH937sgNhuMqgVjGLef4JfzVlxHTzd/dqKfGleOCu5/sn52y0/LWtJceb2GOFchmoBsTWxJfCDKRBAarHurKdb8PwmDQYn6GWWUxDFD4P89mgJu19bnqraPw2TPqZm6JIjI5kt+0dAHcKw1XIqNhpsS7gnZbIBchzryBs2k2NVDTHUolQQmG961Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxxmhU46x+zNn2PlhEreZ1x7TY2qU5BKofHXmTFywok=;
 b=CctnNN0qCdGxaUllTC8VDjNDJI05FA4JNdwpVATuAE/SrzW884hFfM6+n6FdKmW4nSuvS+GUBJzTegZeYNBt8bT+ARXWAbDG78JCGJfQ9KN497+49cT2kNRzMHdB3qo0PkB+vUuwgQuf1YhB60Tsvd1HQB/RQYSdnxT6y1YGY+wwH05cVwn1wiqEfanok6GfDFxHbgQrdIwThBmRm7dnno98MJDDfBYv9knVP7pnQLQ/4vi+OGLjWj5vzkxYOlEQEQtfCfeTMEjs0DaslmmaKPz8qKDgA59boZAjB2SflEe4FSv1bBZ6MbyWHCjQnWYHLEdFHfthrnvo6BQ/3FS7TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxxmhU46x+zNn2PlhEreZ1x7TY2qU5BKofHXmTFywok=;
 b=LU0PT/ozAHd3e4uoD0cobRH8Zh/RKQGFnc6VNWUqIVcNrTCV6hLBLZz+QncTYze6sh6F8N57H283R5bT16JyOBqKrkjClAmaNtKWciNp7+kW8SIB4bkQG8TZwtMjUrYIgHWzZt5qtmB4r2V8OkUuqv+TTWfUJwuyi6PLjbEjH60z75LSf5NdAClgJC3u1GiTTpNxg/D0uHYWrLtSawlD/j/YNnwR+/U/NTHMK6ttc0k8mOOvw5J1pP6bRtRUHYSLNoTAnoLJv+miLRg71EMmRGiKOcawCyF/Rm5wqP8s2QENYfgdwN6LcnsUybKr6oZ0KArhM8Arx3GEqUVP6x+8fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 26 Oct
 2022 17:01:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Wed, 26 Oct 2022
 17:01:53 +0000
Date:   Wed, 26 Oct 2022 14:01:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
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
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
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
Subject: Re: [PATCH v3 10/15] iommufd: IOCTLs for the io_pagetable
Message-ID: <Y1loABCH2VDy1bry@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <10-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0323.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c676962-4e14-4fd4-bf17-08dab773c841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WOVmOjFiCX8JDINa6EyTHMhFecWEhIGZID+FGlLKO5AJs32YfkTfYsaGLqad2toyNM4dd+XZ12SZ9rJrtuKzo3+QNgsjB8/eLVIlB0/YTHX3uHHc/qIyjtkCLdsGfMqFavMEdhbQDTsvZ33nMUbPlAvzGf1P0BkSdcDxYTM9VnCrXITnxMh499KwOgO5dom56tZWskFQ8jSXUQ6xbXUSu3sjUC82yNw8cvOeIQ+YhqF0gkxZDbDxZ9s+FoohTtTIs4wp2Od+7xtJhLrgtxmefEpsF+FcmEL7uUhvt0edASRy93QuF4i/3npX70C5shrDFqmACRef+IYWeHWiMGWNRCg6BAyEO4r4yfF4apC+971yga1T/2bTbr/2xI9o3eKuCtrUPMTP9yFG2rObejclkjhQfQvptDBisbr9OkSLewhKERcaQ3d7GK0WYrfnuwVSR2teXqLTChIcigwwBJf5ksII+ThzgqclEFBHZkXNOzCXXoJ7gPfrsspaZ0PXeGaky6694VezDnVRCBCHSjbPeelnZE7AAhB3exg8pOZwTOutKnBKRY7NQ34/hOdOSQAZjEdff2QKoIj47k2bopmPXNxtgV1qyQgVjr8Tnip525D9Heuf3/di49tCEbIY7o8tSW+dTivsonz/euSiZA25DJ0axr6ujsdcv/GIG9uXI58eBlrofKMCRSnMrKTz6q2YEi5Mzq7lid1SJLjM3zgZRKmTyev78fazfkN/pCwxpYv+O8n05Zm7C9Z+IM6ZqpRZ8rpcd8iuvHAF6x2QkpiJaSdrppmE+zolRQ7aDSjuags=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199015)(54906003)(26005)(921005)(8936002)(5660300002)(66476007)(7416002)(6506007)(316002)(110136005)(36756003)(7406005)(4326008)(66946007)(2906002)(41300700001)(4744005)(8676002)(186003)(478600001)(2616005)(66556008)(38100700002)(6486002)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RXiiBnNsSyegJjqaTFbwueeobgcBFM+ghJ+ZHORqz3ZMLgXOE5ouhahmCZXJ?=
 =?us-ascii?Q?m7+m+utRvTuj1PicUAqDdfBg2Ibee+FLuKsavSH2bMtliQtka43A88kl/xEY?=
 =?us-ascii?Q?HO8irLGS+3tJ62QYRfcdciyv6b3Rsaf+cKvw3Oszg2av5PiPa8/C5yGLTfJ0?=
 =?us-ascii?Q?hgXq8l9Przq17mnVPFQfxlA3V+j5eHTSeC67L/bIikiQn7ps+wtUzaCHyzOn?=
 =?us-ascii?Q?iLHSE/LLZGnXmQQVCZ9sqWg6A2ZkV9wyrCTvbrVKQ/73TQLfDgRjXKeB3jPK?=
 =?us-ascii?Q?D0sgqmdgtA+euEILpbj6ZZzK505N2YY+eyBMlIBVXnCiBe/w0lYyu3sb2Ljx?=
 =?us-ascii?Q?nKb58M9fOw8hiHCL9Bi1eyXAXApooOF7hOseLI/9aXBbKcpbnPqqM1wyBbU0?=
 =?us-ascii?Q?ObqslR6GukMZClah4ZKdgDCGCpLsmXD12WiBeznIbdzpZfokPZ7wj9fmk/mg?=
 =?us-ascii?Q?owK9wTzMC7j1R0y0VuJwDPAtyhhFm2YZR1K0+LodtrXpq8Xee+s/2bbswqyw?=
 =?us-ascii?Q?O2+lwp9IR/V4JPZB7+x3JbIFF5Pab40vvvEH5m0GTSc6DexEAKu1lUdXXX8D?=
 =?us-ascii?Q?29RJbOVayu4cc5pGzkwqQs0Nruc7gHfzTORSbHdYkDP0FBTgn86PZ3bTf/uK?=
 =?us-ascii?Q?GOmpz7Vc6ESE55m1+L+V/o5zhCvUFEhO9kXGqwXV3EHeiCCl4o29CQ3BZIha?=
 =?us-ascii?Q?kRPOoQHZbShwyIN6J7G3L75SL9pwgzID/txAGnGrPeKI2XiNv14dDKqxIgSQ?=
 =?us-ascii?Q?89cOkcd+5/KaJK17PZcamXAZDGHZlkB8gsVWQpesSoQhI4f1mez2r2kSAmPb?=
 =?us-ascii?Q?6Ha9NrHDElbsCElOqsOmBHtLmudAwakdTLHugHSDDaBTE9PB7NQvgvHy8ddG?=
 =?us-ascii?Q?QQndefaR9SA44AgZ4SgtEpkmZuMEPoqNUsUV11rVkvi1a9UdUQutIFqCGMRM?=
 =?us-ascii?Q?orvVdySSu/b44Z1MW0Ih/EPdPi6VMVFv39S/h2CKk0/lQWU5YD3YL/WC56J3?=
 =?us-ascii?Q?uNYLnk2XrFfy2haaPq1MTQen7zVscQDkXgdJm4KEk8g8ClbTpNlQJfnQwJmj?=
 =?us-ascii?Q?0qp8zSzuvmw3ibQ6MhJ+mprTcH5R2s0N2hnAt4EKyg027pLbwA7MsrQPqAeb?=
 =?us-ascii?Q?nQlbOTm8c026C9m7SWQA3dJ1MgthSUhe0xal5fsyMwZQTGeS8+ryYIAVAQNb?=
 =?us-ascii?Q?E0FN6MJ+Vg+5VkrOkW5Tdzr4iQWS6tr1G4959Lgs2EzWdCigS/Gay/uz3t8c?=
 =?us-ascii?Q?/mpl1+pgCfBxZD1Ax29rYljzHyNtLUaQ5oY7ZR1ySYlp4YqatbfBUM56yCyA?=
 =?us-ascii?Q?c0pAOQd/7VtrJNAdLvQkpWmuVM5VqlKf+IFw1vQTs2Lft72RTfDIdJMoYzQK?=
 =?us-ascii?Q?Lay5ICB1o8GldPHg3CEZMeVJ/WWZnxmRUizlGHQVPGKWBj7xRk/tr1hX/Sc0?=
 =?us-ascii?Q?GmW8aADpX6DZhyIn5Irw7CiCVc/dH370A/7JopojT4IeLA4ZSOV1Z90XkS6n?=
 =?us-ascii?Q?Z9R4HMqFWoj0/JOhvH1KiYMLl2b587hboBv6ZouODVGtX0ef+jpiEUy9snR9?=
 =?us-ascii?Q?qbrpCTNSgFprrilSCHk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c676962-4e14-4fd4-bf17-08dab773c841
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 17:01:53.6938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M08RxEDcGGw3KqozZZLnTeIKBtVO0WkJVIkiP7ASpFli+z3ILjSJgnVtbNXR4YsW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 25, 2022 at 03:12:19PM -0300, Jason Gunthorpe wrote:
> +int iommufd_ioas_alloc_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_ioas_alloc *cmd = ucmd->cmd;
> +	struct iommufd_ioas *ioas;
> +	int rc;
> +
> +	if (cmd->flags)
> +		return -EOPNOTSUPP;
> +
> +	ioas = iommufd_ioas_alloc(ucmd->ictx);
> +	if (IS_ERR(ioas))
> +		return PTR_ERR(ioas);
> +
> +	cmd->out_ioas_id = ioas->obj.id;
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +	if (rc)
> +		goto out_table;
> +	iommufd_object_finalize(ucmd->ictx, &ioas->obj);
> +	return 0;
> +
> +out_table:
> +	iommufd_ioas_destroy(&ioas->obj);
> +	return rc;

syzkaller says this should be:

out_table:
	iommufd_object_abort_and_destroy(ucmd->ictx, &ioas->obj);

Jason
