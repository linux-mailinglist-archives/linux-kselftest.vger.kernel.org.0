Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623FD691064
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 19:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBIShN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 13:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBIShL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 13:37:11 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5712530CA;
        Thu,  9 Feb 2023 10:36:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cg+f2AimCNCngFfELy34emHj/1m9qRw1pbi+8S9uhyONApWlM81+dsaL+Jl398z2dzXCp06pjytoMoFyCqQ/dh02gS23btWm2z0YVB0BhgwpgxNiGETkTJX596G47+CqS0wDtFeYJH5lB8v4QAt6o0/gYsXE4XCUXdD4svsv4VSfDpTmac4eOnqc79Dl/cbqpX97Tgc71QNmLwzTI/IecM21dN9hOQi9aczOH/1ScmrW3CVTgji54qkv6J3rPFRkyVE/QhYlhb6Q+UobqLPcgN3EXiXG9m2WKmfC996KmqCBeH6jonT4U9cqXn6lmHEp5ba8W7+wTAejFB7pCnDPOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nd5r2/9rNmC98EljcTYlYwgrVvKeH0+t7p4gQzKf9+s=;
 b=KqLa+p1cuk9eKkcS+eme68DabJC6noyOUSx0eCOV89xSIX0jgunyZCIOG3EqH/g9eC4tGYNEGcyT2KCSwH4dVUQ3gUGeQ96NOHGP3ahmyE/H79cDPPTCx++hlNHPrO3VD/Ma2ieVAXTExDoy0Qsy0uESmOrchrNp1wLFhUVCSj3BbeCfKqpPqTgvbWy1P0CFBnVDhjw6UTWcSHpdQnHnApqMn/tv47W+bD2N45V8hK2i8Pbi9Vhf9CeVX4fk4t5lARslts4UwSllKT8y2bcHhTuQI81Rt+3w+PXiLX+uQtMHa5zeFSmKeJR45Ln2IcR6RODPfCkT7ueQCTRdlQ5iag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nd5r2/9rNmC98EljcTYlYwgrVvKeH0+t7p4gQzKf9+s=;
 b=WlD8SY19UMPXvO0dxjMr6ncIbjD9B0nlpwl84K9CFMsgTbkvM24LQozi8KrdetWcrrEm726PFWPXULMi0qHkKlzAX4higmDYuAfQ1VDbvFpjyczKmEFlMplnDlL+cARef+zD9bmSNvUpPFmtnlz7riniwN+JX9RDnbVmk0xaBHznJPAAUW24ac9UWLMOcoTgmbUarcKOcY2Y7KRvTum/TXHjeRT/2xMaj23U7qI1XfeTnQShoFHJi335esd2u84XxoDPqOuF4ZcDAsIU5wFBEZOA4cYdMzeQw3ctI0zEzAyQaM4DkVSBlAadqDjK+7C4n8c4ObAz/8OAa1FjRMF6Sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 18:36:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 18:36:51 +0000
Date:   Thu, 9 Feb 2023 14:36:49 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        baolu.lu@linux.intel.com
Subject: Re: [PATCH 06/17] iommufd/hw_pagetable: Use domain_alloc_user op for
 domain allocation
Message-ID: <Y+U9QX4p5YX3/B3k@nvidia.com>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
 <20230209043153.14964-7-yi.l.liu@intel.com>
 <25102c92-1831-be52-677d-60bbf2e11772@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25102c92-1831-be52-677d-60bbf2e11772@linux.ibm.com>
X-ClientProxiedBy: BL1PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac2514c-1bc9-46ab-a62f-08db0acc9bdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5mBWGr2hGjaENJxPAp4mmZ/Hbiq3g+yipGKRX5yrQW05djW9VzR3rWoPS7tW93yGiwr0Jp3dZxfw1ynSKOZZe6r0j5aeNZTR6X4eiiCm8Zuk8T72svi6LILojxNxkzXdRkCimjHPqsJ+wim4sw32LbHZiF+ea3iro0JenKGLstWacIZnTTgxID4UzJVkBx7nyQuNpo5CGMH7x4jqjZxazouJypWzrfkCeg4bex0yaAnqdEJE/TAiLwHBL+BpzeMjn67Pu+OpajzyCMXKGhzyVWLlkKaxCl3w3QMnjO0akCP+tzN5AKuH/EoR6PRUuQmiZ4Q6WXXgcyH9Ktb4drgda9D70SADO5Tp4qEQhRA+vCPrxwYmV3Uz3Csl47pq40JQD5qliRmZlCBNALG8V59PV5GX1fhftZIsHbhgP5AcPsFF7Xbsygb3ukD12QrdgEG6Zi+mPJijWsM9pRRcrhWbqbZ9eXFfmbLcn0oksHvrzAYLTsI6YtOtNi59H4ZqdBKli9Ref7ykpMHu8563BRYqMWm3aLLH/udh14bHZw2JWnJ3ICFmkiqFW4/LVDzUTNURePXRM+lMKgU3ySOoL+GDmC2qzDbJW6wCQBjVsMG/4hGdW2iKU8srZl3W2Su/mz4jlydydB58m9gXadakt1dLLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199018)(4744005)(7416002)(5660300002)(8936002)(2906002)(83380400001)(66946007)(38100700002)(316002)(186003)(26005)(41300700001)(66556008)(6506007)(6916009)(66476007)(8676002)(2616005)(86362001)(6512007)(4326008)(36756003)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sXYAkk6/E+EFfE5oeA1z83aWgHtmhGkKnMdQ+W/wNkxYVmo1zOx3SyFc+2W9?=
 =?us-ascii?Q?l3MbTkcHVTvsNeecnd0cMPmk6O6tNsgOi4MFcPoYf6Venb00qS6WEMqE/7o8?=
 =?us-ascii?Q?/AxC0BrZkRIBKGv7RD+pZq4ga3aq9h/tJopdkg/cB1aGFFrxOnnPold2vg/p?=
 =?us-ascii?Q?kKHZpHnUpDYouhpqBPl9pakfV8eTg24VIBZcYL3awHz5gja/LAeLXfNxQ0ca?=
 =?us-ascii?Q?McW+mxG8iQFeCeEXyeL94RnOkPNY+FKkEBGYF3XVJ99ho6Q7zAWd7ACE9V0+?=
 =?us-ascii?Q?RTYiqzC5MvcLW+rkWOhGN4al/4JSlA/nsK92kCux3VSCljQNYrtM9yccZHE1?=
 =?us-ascii?Q?ohZVBwnkBAsVAB0vGZA4yqD+lRWbPsNhtNGu3pNd1BOPtEO5DX5FEZCVzyo7?=
 =?us-ascii?Q?AyfmcbRqmtY/+vZQM5Yt0HWgYan2CDNuRNvFHTmXNP60ggLpJpKo1YQK/jBl?=
 =?us-ascii?Q?3uQcjhbtjImTOFKPsDVlPCNwytctwIEi4dVfvFlk2tLxWG5ZOR++GHE1N1hv?=
 =?us-ascii?Q?XLSjJx+hmbYcDlw3eM+PB7Q7GAfk6ybo+vyt9iKTu3ajeOdbhARggpQ1aDIk?=
 =?us-ascii?Q?PgQGUcfR4kLXabIO3kQf1Ii8PZ7UqhqDSnrxjzbym0ebuh6uWPoVcec3oHA9?=
 =?us-ascii?Q?jExG9cfTBqbi39xtKEdQ+f0XNxcB2Ob0PcnnKqIxRxdXLsq4opcd2NdVTSFM?=
 =?us-ascii?Q?V3m4AY/t+VdvqwrGI543oixUbl+3zq1k25SFthMMfcOuVnOpvUNpEM+f7EVy?=
 =?us-ascii?Q?Az9dp5Ij1BIKwrGRaPawmDolfBp6bzPqVuDTYMxpTn6Nc04XnKIwENUYve4o?=
 =?us-ascii?Q?AYIJI0hAuAXHlizhR0d3IIHZYtM9I0jAj2xAKx2bR050YgaO3obRdJpwqWXU?=
 =?us-ascii?Q?JaeOjn4T6zeE+LzH36/SU3/PxtBGWwFK1OH7E8K+yJ740BOYfYrImQf0wqzD?=
 =?us-ascii?Q?wCMyokxXC+EwD3RqAStRyVHUzR5HzghZKKq2y6gMemNok6jpLBKMV0Nt59wd?=
 =?us-ascii?Q?w4RmVFXrCVHui4sF75kcfKvlcNpUwVR7DSDzz5h7h6msV6rAyhxqPtfYzgMm?=
 =?us-ascii?Q?KT58fD3FRXEOUVKZFXeozs1oT3J/85HDeXijx8Slz5OJw93EasuZkwlqVhJg?=
 =?us-ascii?Q?DuMGUhbNtpG6z60GBoAZaNu67pC0j+8kBKMybWVF4UqlL3n8/2PuFn9/sgZL?=
 =?us-ascii?Q?2VGRqhcvZ5h+sEZaUGv6hq65M0hCjqdr0CuKBFZ7s91Ogh221Uj7YvyD15qZ?=
 =?us-ascii?Q?a4icP9IcgikLNySCIVws6bmWl0Z7UdVXEAhsdMB19bjv6KhdQNi7NmlcpNoe?=
 =?us-ascii?Q?7RwCI/nv6JSDwnGZwblz+3jPjM6ZZoAY5WYWjpoc+ykFA3ialQ7Ul3XZr87C?=
 =?us-ascii?Q?6XiIC2YokFrPxaO34/xP2FXorgjzQ9zCYjEUBqKrOZTK1fG/MaiX5HKQwdon?=
 =?us-ascii?Q?yAq1LY2CYD4McsshgIgcnKNu0874xb88lR0Ii1gps97WbRnqnoVOvuWv7udK?=
 =?us-ascii?Q?NUUI4ZMZBIpM9aywIiydfozHdhqU1YZoHiqX6lmEjdzRXWPhFtUYuxvnvv0T?=
 =?us-ascii?Q?xBc5fwhxD6Irtc8wPuK6R7Aatn9E0KYLbrZx+z2Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac2514c-1bc9-46ab-a62f-08db0acc9bdf
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 18:36:50.9663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jDlMBrzFnrMnY5KaV7CuMjQKNSgmY6LG4gdNW4rHyK2wRqEhkW0qJ5J4u657RgBv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 09, 2023 at 12:59:58PM -0500, Matthew Rosato wrote:
> really should highlight that).  Otherwise, conditionally calling
> iommu_domain_alloc(dev->bus) when !ops->domain_alloc_user (instead
> of returning -EOPNOTSUPP) seems to restore the prior functionality
> for me.

Yes, that is right if the input user data is 0 length or full of 0s
then we should call the normal driver function

Jason
