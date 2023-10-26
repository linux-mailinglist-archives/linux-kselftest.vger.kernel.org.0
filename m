Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC98C7D845B
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 16:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjJZOSE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 10:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJZOSD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 10:18:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ABA1A2;
        Thu, 26 Oct 2023 07:17:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwLOge4LN6oCe0M+8u5Zggl0ZB+chJqz+Y87wKnbtYsFVlzbQlxEyJtDuNBVfy/TYYKRDzuuXzJr4gs3QbWIUsRhEw43KQu4L2+DyER+OvJeb1SjfonaFqP5lLiyTvBU2EACxm2dM4YG18zFPGwS/gXQ1t9Nff4vkR4t5ujaFQUc8oHF6RV0UCL+zb3YG3mg1L5NhVKqv9SC6NNYq3J1H9CiTmp07LhE3HF6sBkuPk0ucRRoWbB7DGx8vPBTGPmxlIhuGXN11nhReoM9al2b/BZOm8XiPw/WK4GaNfO4UsdG4yTx/xUu/il8DdITRhbFNeUYIOvoetnaUJra9wr/Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g87BlNZ7IZC40yNAzTgy9pyNdOMKdAfW6/gnEIVl7Og=;
 b=Rh6G2XEACfxSkI8dCI+11Pj2nkRyU0MYYNOqSFSRkwiurZmP5nHdVXJaq7/L9EyDfbeaLal6nFYuAruubvCttmH5zP4djTrCyDg4rlEbhFQLDCc2W/21THMyohNInvvTwA1O4DLfwcuiXt3ay7JEQO36Tb6iH1/l0UUPP9IlBzhw0Cxg0ypPK3Er0a0dZ6ChrlC+yuzESdQVQPs5lvLI7KL7seC4mGpE0CLSRIVHblwGmt1sWn9M4Hxm7enGVCwdcDNi+ZNOwiMdwB1V2BwoOWXMdCfPEWVEmAmwzrC24nm/SAlNgEz7LI5ILN6XhfkR99TPu37zTW+dGxBzTog5EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g87BlNZ7IZC40yNAzTgy9pyNdOMKdAfW6/gnEIVl7Og=;
 b=Xmt8zn4hDqIA9imyZbGACMT1TXe5e3twZf6G/Iw+0cgW5oxf3Ajfk4tK8dAXHWnv3a3ShRF6F5Ax9/xicNzYKO9duizroTJw6pzEhgxUVrhgYglw/MB66Oc20TPJWgRnjjQYXl9e9skgsVI4yIaLVO+XO4wwbK2Hbh6yg1EaaeceLENF3MAnSXK2hUpR77vkPrQUh2envvT0j94eQDsk0PSbF0oXVs8EvoIRL8xWCJLALgEqf8wskZtstgEdMXBwOSWDezcBq+gzfhpAehJH9rOoNVT8UXK/Z6I10ZG5NOD9KNB5ZVNCXdMS/bev57Ei1G++J1bNK95D75DUdyCv4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 14:17:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::11a1:b0c7:7c88:9480]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::11a1:b0c7:7c88:9480%4]) with mapi id 15.20.6933.022; Thu, 26 Oct 2023
 14:17:56 +0000
Date:   Thu, 26 Oct 2023 11:17:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
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
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "Zeng, Xin" <xin.zeng@intel.com>
Subject: Re: [PATCH v8 7/8] iommu/vt-d: Add nested domain allocation
Message-ID: <20231026141754.GP3952@nvidia.com>
References: <20231026044216.64964-1-yi.l.liu@intel.com>
 <20231026044216.64964-8-yi.l.liu@intel.com>
 <BN9PR11MB5276DB4C494507CA5271975D8CDDA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276DB4C494507CA5271975D8CDDA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: DM6PR07CA0048.namprd07.prod.outlook.com
 (2603:10b6:5:74::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e7b71eb-5eff-4d12-ae5f-08dbd62e594a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j0qCfBgiyuxFNaiZREeL68APExRgxlfUYM5LAUdIomiO9t8pmRd+b+HbrGlAkNuR4BfV09a6AYOUPbiZ829Qq5+c3sU8VHXDSt3UsUYbqg1DluGzFFLPD4oynAFRJfmHOoP5qJTqtmrFyE6mRYqFk9nFDZb9dVupnuKbUbx1hG21L2spjA68iVQqL7QjeNTHVgn+0/aFP0h4d7QDFDWESbHbbfYk8i5bS16MYZJ5Cz/SsOhKSuSMi0Fz/Wyo1vS+KGiCvB9Q8EoWHAKYpTFxX62RE52mq+SNlWmPye3gOq95U43tSukXYsyIX/j0JFc2ehXvhoX/NCuZNymNPvFO2UXnEP2VNbxTtEyV+kNxBXu0fdJ7LUBgpu40PcRAQLMIZZOuZLsvlz3nfd/3l9RG7fThUshKwbj8+ame2gp659gXGtuKE2g8AwQEPp/fc9iENXG2YhVtUG18H5WvlUf+lPcZfrL5OvTl6uCyvoAEC3esKaWK07A0GhPqOAS0dzprhPcAomC2hPOXUnFNN5X5Wil/+vV362ix88WM6TpRGL4p4FwNu7hRIATvH1azyHvG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(36756003)(4744005)(316002)(2906002)(66476007)(26005)(41300700001)(33656002)(86362001)(6916009)(54906003)(5660300002)(66946007)(7416002)(8936002)(66556008)(8676002)(4326008)(478600001)(6506007)(38100700002)(6512007)(6486002)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ve7CGH0cKSQrLbFsTSzJBQ4KwpBlZx9aRFr1fIScuiGuHUGd4RywVRnqTX+5?=
 =?us-ascii?Q?8pALcCiNExMXM4/ojcRNWFcF9/+wiY4V/N6V81fDIvkrFAxgvdQoCBJdN5XM?=
 =?us-ascii?Q?Kwl+pWh8oCqKr22HjMK9hpNW24i0Ud5M+DVp7BP5Ktd5Q8Q96Db+a51LlM4k?=
 =?us-ascii?Q?Xwj+QEb3HJ4h4mPaRIq64bgdJg5Z+X97dUX5pNfRoXOHYTIY5MihuIiBxtwt?=
 =?us-ascii?Q?N8i0JFUzShKN/Z7+jUNNr+SoksBic5Mf+BUs0Goc0WR9kg//4m5QkVh3EF2o?=
 =?us-ascii?Q?Fm84as+WUXS/XDQ1h19q1l6SKXbDyEByOm6yALd18XhVGmag4fdO2hGrFbYW?=
 =?us-ascii?Q?vWnNwNgx5S0R6V+2Le9KKl3UAJqHhnVZ8fxvooAcRjT7Sq7xYT22pubo6T/i?=
 =?us-ascii?Q?onLjXdUbVWcxJc8z2B4ItmCpGrZy/5tm7AkUGD02+Z6udZ2YA9wiXcluEeTM?=
 =?us-ascii?Q?2K2h2ahau5baJp25WGbc7+T75c11oSQWDu9VIRuBLC/DL8jlXLlLf7depb9m?=
 =?us-ascii?Q?8Vr2VdT4wJoIA3yiOhvQPJ5uEiZCKfXqKo9WVOcjbA3VKtAZ6xd3RTgEHDpJ?=
 =?us-ascii?Q?pkneAxjd2uFRdy0TNXjds24Yb6VSyndwEUZe/9W9sJ1mVoF7E8tSyQtBuWGV?=
 =?us-ascii?Q?SlXzLpPrhLvnds4wSoPHUnTKIzZCKhTk8nGKSKS0xrlctVJwgNkxI+OVQqiF?=
 =?us-ascii?Q?FTDyr4eWhEm/TyKDy2dwM9InVILu/OCIMfDTEyDX9dS/WDq/yqwSAwvCpL/a?=
 =?us-ascii?Q?Egrc3ssoXjIAg9P+HruM+iAcplbYHLou0nmisNBfY+dhL2tEDk3NGcoE4NBd?=
 =?us-ascii?Q?qVsG9/S9UStbAT+PcFN6oxlGbaVq74xn7E9I4KbMXRZGCs/ofvYwqDIM1QjB?=
 =?us-ascii?Q?p0ClFkDnyvAw+hehyNwsNlZsqRqMFan0zNBBJEfjSxj3U6GG4NBX9tKnE+/2?=
 =?us-ascii?Q?q3OwD+rsVQH8reTkjT9yKChMxTcrDfdFiuuVghM39Exx9rolJ8vCWFBIRpc0?=
 =?us-ascii?Q?wXx4qDfywHN971REDYMG+atFMfIxQ1ER+PZixcoEdcdeYBk7eb+Vegse34vH?=
 =?us-ascii?Q?ojzgowdLhemKUnttMBkOqk1BLORbYjh3qCVPz3yyX54lyXvexK2MPBJQXh8k?=
 =?us-ascii?Q?R4h/uW/ESS9FiHjvTu41m5CKMh7xxdh49VGL/nHE2dZkgAYs+uS6a/NkBO45?=
 =?us-ascii?Q?PzkyViGtFyf7rXCqcyBlXreLNkTYPSGL2FmmDCcfYSi+O3vSEgZGtxGe5Wc8?=
 =?us-ascii?Q?a7IWgJTlB2+A1xWfN3A9FgDhBsaj1Gc65EszmeMrSRd7MrhhxT9ytmAQM2R/?=
 =?us-ascii?Q?6wVIpJbAjOL/wZ7xzHl5ZtNyWoAK0sWXhb7jVRXQ9UYmvpptcnnER2RWT42+?=
 =?us-ascii?Q?mJfJM4b/1m83ENVC2tRLwY7az8hpGV/v6Z5AWzX2TYbkDriTPPJsAG9/iVoj?=
 =?us-ascii?Q?HSA77dDRXO+hh7eaFFWnPldiz5SWGhJY1b3jEmgGk5yI6itpG7rLBRoH6YLS?=
 =?us-ascii?Q?r6gHFjk5LMEIyhm6ERkPNAChDVHsWT/PGNFp38BbAbMcypp0o5uvE49qfD5O?=
 =?us-ascii?Q?PPgSI+R+SOUbL5AbVIU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7b71eb-5eff-4d12-ae5f-08dbd62e594a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:17:56.4271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrg1ojHu6xLXNZ6ds12eZzb4LM1KjE7QNrUxXrWWOZ1YZu77Si/HUlK4lQXm2rIm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 26, 2023 at 05:24:24AM +0000, Tian, Kevin wrote:
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Thursday, October 26, 2023 12:42 PM
> > 
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > 
> > This adds the support for IOMMU_HWPT_DATA_VTD_S1 type. And
> > 'nested_parent'
> > is added to mark the nested parent domain to sanitize the input parent
> > domain.
> > 
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> I have given my r-b on this when replying to Jason's change in
> last version.

I fixed it

Thanks,
Jason
