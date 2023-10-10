Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00ABB7C01EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 18:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjJJQrw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 12:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjJJQrv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 12:47:51 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7A48E;
        Tue, 10 Oct 2023 09:47:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyDfAVbcAYA4nPsSExvglwNtS2U2UYZY+YtDjuOouJE0WFGSq122U4AWMYW7N/FBVV10F1UbzjfnaDLmwRMqO7mk7YaEAJMcXh4esekj6F2oSPIIpfknbo8pPSW4mAN0fo+XgfPazhCaLzQFG07RZoezGFTA4wSTrRE4aFvS7UJ6VaNLGbqjGJ3uiKBbHHvFuyGP7ZiXwkWTsdHJFBAr2wtaE6wmOrltZIFg2mgXjY4ru3UQ1jv41wLFeMRNQzsiXMnSFBvqmsMBhyYdJvenxYZv7NfpiloqBZzRnBr5rEp/zkRMzjQNk5hENeDC2qXXVXLOf9ifJV6N4TZVqbf4BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8u3WTEtO5/Y8hSesWA5NhSfQiR5joN3XqhkOGKaPJA=;
 b=AqskfYEmyc1cKKYeGv5RZXPHVM4otMtXzo0hRGJUq+O7PLGKEcLwJ6xdLfV9lY2621XMXv/c8zGTG1hSje7tU5b6JBUWXV0FcKIVykj4nxSg5CZ759FApNxJvl69OUCZlNYglz2K81Gm5BMsQhHAaaga3fHZRTB/Dm9f29yc9SBBA7WcuitJFp4w1NbVF/vhxzhk7RlQemdcL0Y4/edTkpF1X+SXzge3c34Jgca6gRAy4thm8gSR97Qmdb04XZQXLtKKJ9psZBQ3XFe1ffXYu8V78c5Lv4RKIyo58WWTTFhdGMt7a4wucY1uYa3YRN70B6iHiTKVrC5vVhzG1FII5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8u3WTEtO5/Y8hSesWA5NhSfQiR5joN3XqhkOGKaPJA=;
 b=MCQJD9Uq1ck0ZQjHiwyZ6B16GUPs9DYaYfl5q5ePim6oYEEQZ22Vbupfo+SNMvTIDfBKjcKSD+mkZzdWOD+jvKzoLg5PUTfR7nDk+W5F/aaHqScHb2h6D2YLd7ASyVBNA6EdC22Skh9pCfttDikhkSoTLAfuWe1ex6UuJpNNSo+mQ4/jLivxCjgw+k+zxmHf++7/mj0sSMa6Z6qEZI4B8RNCfCB8ajuBXJx561h0/Za7R3DZ/0jSkHuy4QuIj839+X8w3TdjhyCVG3VWlCRVbaJwLV3ldzCyAOG7wo250bPCcvLV5y79UdLV/xVSoJPgjHwuzFcMVwtSrvGfRKwCCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6029.namprd12.prod.outlook.com (2603:10b6:208:3cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 16:47:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 16:47:44 +0000
Date:   Tue, 10 Oct 2023 13:47:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
        mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v2 0/6] iommufd support allocating nested parent domain
Message-ID: <20231010164742.GA75531@nvidia.com>
References: <20230928071528.26258-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928071528.26258-1-yi.l.liu@intel.com>
X-ClientProxiedBy: MN2PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:208:134::38) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 491dac1c-6dec-4b6e-a0ae-08dbc9b09fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N/HI0KP4isfIJMFtaIVznS1tz3EQEFBfC1AlMvFGx3vA3plmrxxQfnmCjsoxgfrL8gFTRbQLjNuOq7YX1q0R0mdXfS00bub41Vk/mQbcCgoAUFwH1n8NDc+qdyHFsIUBLtB5rVwYPlQ4mGAuBbwgKU3vhp+91555E3LcuiobfppGAcA/sPa9WjxRZFks/hcX0kLd/pO59wo7/ojnu7WkLLOTWq8Rp+hwHD9/IyXbY4MngAGpbC5atPLPEbMT/52CldFd2HccvE/hDph4/yHAohoz2EB7U6sc2Ja8OVtHcUJ4vhIfmFsKr4tfyy29LcEz9MRTBWMZU12nYojxNP2u+9f3vno9k3OpPkKlyTTGWZuVd2DwuwGeW0BJcp2io59FQSEYqjk6uS+snZyyuao6kRd9wZQTJPvZr4TsdHNnmpBpO1+ugTWUM/FXnYwG3irrZnm/bHWFI2h1QkrPrRloxcRbZ18nJxqboipNLFyAWhrALwQbWd5w2r1D7vceko+W75IwqKv8YohfH1WpfCI6TC+d0XXWpwi3QtjrgwUz+/dkfuaGixqiJLynCnPaUmaG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(86362001)(38100700002)(36756003)(33656002)(6512007)(4744005)(2906002)(8936002)(478600001)(6486002)(8676002)(5660300002)(41300700001)(4326008)(2616005)(1076003)(6506007)(83380400001)(66476007)(66556008)(6916009)(7416002)(66946007)(316002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ABAfZJnGdJMHQVBxoW+86egLGYfS7Q3YAsBEt2tKdh1iDWJWH/7zFQ4g7+ks?=
 =?us-ascii?Q?jyaW1zwrBfTMRLfm7Dx7nCkql5hMMSm+osyzpm30T8i+7hAB8Bc9sPSlHLQG?=
 =?us-ascii?Q?gULK68WFPUjJu9RcPj1R5rVi7+Q/cHcJuRXmkdVnEdmDVlMytEP3GoT2V48J?=
 =?us-ascii?Q?o1AStYR0JCmgAt1O/WHBgZNiUAX+L4nW3oRscNOvTopaA2FKzKngantf+/nd?=
 =?us-ascii?Q?gsYipE4ANUKEaC1KIzXDdBx7Ncz6pQZDWSbh++cWqUHDUgNubOBtt99ymwRw?=
 =?us-ascii?Q?v3kGhu0dQ+ID+btQWYubN/iLy29degNgCZamETx/XDfgwR168ZteLgbZxVOu?=
 =?us-ascii?Q?WY7gul0ta6f7sPoLmHTfTVQ6porNzelhJNBV1DZhxO+oe8GPGJCMfShUhEJT?=
 =?us-ascii?Q?wneVUaBjPfgBBCSH4T7WxTHXNr7z6e4XOoLQkQb94WPCDaS1yC3yrjPd+RNw?=
 =?us-ascii?Q?fn6VMXaexzKavKfxu/Sx5fwecFpkQSDZxYhVtYOJaLpPDwcXjyT0AUb8qOdW?=
 =?us-ascii?Q?GczRQKkkxhKgZOa5xLUHSU1bf+S3zL8/c1akxgDDjbKFbfT6568PM94hr0y3?=
 =?us-ascii?Q?wdAzWRkwY8XCOVoh35zytdltV595ig6XZB0oh3xNqzlDatavT/ei9VniOJf1?=
 =?us-ascii?Q?U2Ga5wahaclqNglxOo2DE/iUQ8S4hdXMAHgpGoppeYDjtkH7GCcTwdawSX9L?=
 =?us-ascii?Q?Lr51r/ZQqilZhzo3FiIKidEXwLbMIUQi3ixHeQEI4pMlLjY1jmRXaiOH7jg7?=
 =?us-ascii?Q?hp2AlvH2gOGUR2/lLLkfpKhPLJDfhUH8n2ywlapAzocUvW4mz9ECLh+nx9YY?=
 =?us-ascii?Q?84QbbeShdtrTRp+ahc+HfzxMVSoMywj1QB7fmWqgb45vah+ivVFRGP9Pdn6q?=
 =?us-ascii?Q?+iF5w1jB/45wRLQm2y1WGJX2HQFP92RnLFaQ0K7rJ+Q43yhsr2l9rDxWaa00?=
 =?us-ascii?Q?VZJQU23csmVwG5cpTBy6CJ34DKHWmhoicFVTj9j31Cf4zd+prbS0Mxq7VMPC?=
 =?us-ascii?Q?M8Ufg1W0Yfai1GCGfRWOwgHFfXg8DXcg4Uv6cLJxKVU7vaEC2tDuXtah4HBj?=
 =?us-ascii?Q?vT1S6HyZ0I3dfyeyXaUBI78kDKIjm4qJuSTc13c53TSRO8EMWMdXcunj1mDd?=
 =?us-ascii?Q?2WIStHRhmFOnC8K30BJScMyxbaX0NoAKVLX1J/SAGzDv2W576h+eK2nNRLRZ?=
 =?us-ascii?Q?AQBYbWH3icCWj9GCxcTeTDMVGGLa9Vx0OF0I57kj82fioSoPilYTjxVbqbYZ?=
 =?us-ascii?Q?V5aJxvgoTlcwAja5mpG+0SMfaHG7SCgMSqqoymK7qjoV88xL4Xd/Wqz81Gb8?=
 =?us-ascii?Q?8a6rkvo1j1EMQteDVHgqvGnv8Kuy2gAgZszp1ob3XJOYNE/qO+TTInuijkxL?=
 =?us-ascii?Q?zMwed25Tfd+bTyIJL8jhZPrH6hNMfAe9B3i/cQbHBy8zkEWqPtOmgzLs7lnX?=
 =?us-ascii?Q?dNLtytcv6Nz/FGe9Od857qQtU1ys714G0+93pIpXi9vAprrM65KQhXGNof1c?=
 =?us-ascii?Q?fWclDrzFVNowRg6ZBiZuCkJWUFTfp/Yu2bvQS0gVNU7S5hWnq6h6TWJhnS4y?=
 =?us-ascii?Q?EHxPjbGGckfepLW/LYXOEpEuF/2ES3+Jw1fUeKMS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 491dac1c-6dec-4b6e-a0ae-08dbc9b09fec
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 16:47:43.9669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Y2TdvYZuuN44r7kFTcYSw63bIzPKkvlcnMdVt5+tgRxeA0a9/XQs6/R8bS6sMKI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6029
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 28, 2023 at 12:15:22AM -0700, Yi Liu wrote:

> Yi Liu (6):
>   iommu: Add new iommu op to create domains owned by userspace
>   iommufd/hw_pagetable: Use domain_alloc_user op for domain allocation
>   iommufd/hw_pagetable: Accepts user flags for domain allocation
>   iommufd/hw_pagetable: Support allocating nested parent domain
>   iommufd/selftest: Add domain_alloc_user() support in iommu mock
>   iommu/vt-d: Add domain_alloc_user op

I copy edited the commit messages, and moved the hunk adding
IOMMU_HWPT_ALLOC_NEST_PARENT from 'iommu: Add new iommu op to create
domains owned by userspace' into 'iommufd: Support allocating nested
parent domain'

Otherwise applied to iommufd for-next

Thanks,
Jason
