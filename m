Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5131697C56
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 13:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbjBOMwz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 07:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbjBOMwx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 07:52:53 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE663865F;
        Wed, 15 Feb 2023 04:52:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCGbv7hO4Yzqu1pp1N+GqjyhjlifFvQRKpjIRqLgtgaLHQz1HSxm69RbuRxe4KtR5htP6be6SBWFRJ1fVWEn9AbrVaiz5wJLhwW5jipdZ3yW3wiQ7RR9GJJoDbndJpget9JoNDhoM3nJkVGY8wf8IB2Uy+APaP5WrL98oWGLMXj602FD1bgIt941A/HBvPLdEr/Snvq0KKTKt7oc1N6e3DYzj6x29yUVfQ+1OzrYDQH0xHOHlnaMYk8lot/zfZZw0C8xJIC26FJLMlNMebMJgOct9sbe2uPx0X8S9FtE2G+YOMTdpjxxpXTBsJwiJBXi0OKJra3ar6jXp36+pe5e3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grkFW2zWagbujz5B4qK/LDgVhRC6GJFDNgJnK4HC3sU=;
 b=EEHSyZaiqEcQjRQa35EO6BhGWx37yuA/zjhqmCQUm3KXdvZQSHMdySUYC4cJqPNgy4YISRW2ghLocXy+0fk6BPHJSl8EZxqUArNNdUsgn8AIvLeQAEBc3GMPZX7Lu3u/9oa4t7z5rqOhPRReuBdjJ6yUuvfBi+2rvxCRSXSv95cIDtBakCJXdrWePp4+r97+3AzDhKWO5rZkiYthzZjnroUO21+nT4KaALgW5dIJJiRy72S7QyQnkjDxk/j6F6LQH+M94L/KTpcM+Go5G09IAp+NudGD3/HLr7haWoJTGxOLgPjGgKQirqet+mNgW2TQifTk5gFlLopPdiDk9++qyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grkFW2zWagbujz5B4qK/LDgVhRC6GJFDNgJnK4HC3sU=;
 b=isHgUxTfxSIrzJ528rNRgmT4VoMsLeYTFlAPmB/bcSdnlhju5XjVgElWDJox7AuOlc7bwJ8vUKNsRCFHMEICBi2hkV4+vUy+vMGrgIGFrwesaSBowkDPy324UhlFgLpJHA+RoHX1QgGgF7nciP9cuENU5PA09x7efVL03jgymIKyVsgjUW95nGTdI2UOyshosOCS4phzJSsON0IBTonKTa/OBDLYXh8yCVN+BE65TwSkZIDFKhauveYZIlBVBOOl7/3530J05N0SFrz6yrIR/1G1GfZNtPypmH2l0kTzI2ew2qCcE97iDAv2iKGfW4nJFRdawgj67lCsKTtR/cbsxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7890.namprd12.prod.outlook.com (2603:10b6:510:268::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 12:52:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 12:52:39 +0000
Date:   Wed, 15 Feb 2023 08:52:38 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 02/10] iommu: Introduce a new
 iommu_group_replace_domain() API
Message-ID: <Y+zVliMV/R0ALrlT@nvidia.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <fa81379dca611c1d9f50f9d8cd2bca0d4ec7f965.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276941167B52F7C0A7A4BA68CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276941167B52F7C0A7A4BA68CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR20CA0018.namprd20.prod.outlook.com
 (2603:10b6:208:e8::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: 39bf6b21-e462-470d-bdd7-08db0f5384d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WwqaSG3CzjgEftR5e7h3OGiSroDbvJ/gjTxrbJZCujEQ0ENfa9PWUixLCGZaYa2/tq4KtMYxXc4kCaVqHSHKPaKvR9exnDYGXXsFEG2cUiDOPYUTgACAzfWj5ojZXEBNjnNNLEVXckURr6q+7uzyV7ENIeMuYD97sVOHFqt1XDLVT8Y0vCfgbkunkUZuHz+Vdf8JgMYgxQplyXCBtJwKk4pdW7RTHu6u8RaSRGAyqcexb7+xDZB5FOSaKLmm1wHpC7DlWRjcjoyRWvmZkZN3E4+3PsocRG+pjSYv502Bh9yDr7riMsvKIKEW8Xb+JA0e+zqddZJ1wzF5sF7f+c8gfeUN9OCWbLAidEN1jYus1c919OxfO7CuBUJ1xh55oblvLlDlZLuTfbzMUrGoXpNob86lM0f+QQMMUvHadnQIDa7hbJIP44QupdoRAvlOKKDZx2uSVXyHgLu3XnUtxR7egZRdnj7Hi9GrpdQq6L50SrOkbbo6GbO1Cj/6ZfAo0UyKcj9/ykbEo5ziAwrY/VzD5Ls20gwMyQxQpSCQ2ElyDecdRP5A4frWS+HSY2/Ni1N1hDWVOEF/lXicFZgYiZfRijZrFh65kgGm7suNoKXpOQ03UItbnkx9ZMkfGED+xRKmGWvAtb1SpfQ7iR634AndIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199018)(6916009)(4326008)(66476007)(8936002)(316002)(54906003)(6486002)(2906002)(66556008)(478600001)(41300700001)(66946007)(8676002)(6512007)(26005)(186003)(2616005)(83380400001)(6506007)(38100700002)(5660300002)(7416002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VLDy1il7TsSMhKbPNPEx6o/kFONDjuXDu4+6vBPxNdg+ktWsGVBcGMh8gNsE?=
 =?us-ascii?Q?J4+vxVkWKCCMWXSV0Q5bXFY75g1Wj0khfeWVkXRxnqiqVhabCdPauDYX1WvL?=
 =?us-ascii?Q?BTVPHCIxM4FT37yCKUkDgjOBWTPagT3f7R96NGOoWrC8ZvKI5KUCBor8tB4F?=
 =?us-ascii?Q?VVTLzC156ZIcKRoSP0h7x1LCX+cVDrrgkSU9zSMaKi6128Cu2+WEDXXFvpjK?=
 =?us-ascii?Q?CPjhb5HZuVYl32Ru2UjvU60sb9U69QK0Ebvod2V9slY1rEdV3jVW4eBlJE7w?=
 =?us-ascii?Q?OQhIKYdYfKg0iypd9xtTYOWlE11upS9O+Slal+jghB14Qs/gGD9fntUPsFtb?=
 =?us-ascii?Q?MzONpCEim33GHwDKpxY19L/aGj7BDgAW/9tVcBuwnHmEk3syYV/Fp1IXPAya?=
 =?us-ascii?Q?uuU6oLEri8fFzcTJNVjDjpFsbxXxmuys3U4Qel6ktHxlNKs4v91srasgKx1K?=
 =?us-ascii?Q?huAlDx01wtYIaqi2NiBZYSZzihqEA/NZwsFOmxgC1PJ5s0bEPE0qLW9nYjQP?=
 =?us-ascii?Q?nE26EgXmC8b+CfWT/YpSD7SRcOcbPawU3KgBBj5g2mBudxgXIRT94zcaAiFe?=
 =?us-ascii?Q?tjuq1jCRYp8iLvDxsqaK/LmXAxkn0jamQ5Qk+Tu9Ht4SqVagbh2T0mSOc9xM?=
 =?us-ascii?Q?ehkfdnmhVsfakMBRRcK9twbWxg+AZM0baNcpttrNkMfh8E4ALizKU2hqhGze?=
 =?us-ascii?Q?HpxHaBjD3AixxCN2qvYxiVhhMQkqLIJNaTBrcV/DsWZIeL/Ew27Tf2CjSfVf?=
 =?us-ascii?Q?RGqXyjgi9Y8NKBLrdFziEORl+8r49h+AVl9ZwerSufmeKGhMpQbBnYHNfjC5?=
 =?us-ascii?Q?k3I6fZxroRVeYi7NLP5ecCV63UE7wcgYVH0ZvU5L/Ic5BNHLF93AAGpfWkJc?=
 =?us-ascii?Q?ieN/+nXQ+Eluh0dnwLTe7bF5ry4OH7JE93vbckflLQgBt8dOFqP66egUhzDj?=
 =?us-ascii?Q?shoDGkeDQJKuYs7ENtG95DKCCUn7NsngwiBKRhIW4k0XgW7hSX8iB9VpAn6F?=
 =?us-ascii?Q?FM2ySsiycm1TMowKtWFfOUcyGf6wikcwPfPzWV7gG5966LCIaFpwNfEpjUco?=
 =?us-ascii?Q?mI/zAjSbdfney9br/tzASJL1IKJHJ7p5FCz1SLf46tFTa+CYuLNFou3svDV3?=
 =?us-ascii?Q?EBdL5JzKUxD4VQZRu79dKXHhQFEIRbu4mZj2LaQnbsO7ZEkgU5e8C4KyKGEi?=
 =?us-ascii?Q?w9rFwVptRB9ubd7a5OfZvdNFO8MN3oMnGxNhurVQwbYPgRnK0E7GtRDKQzt7?=
 =?us-ascii?Q?esSnboBxKHZHUDUoya69l+NYQiL+vPPvvLcBSybVu4lQ42xQqYS6MFKniJ7I?=
 =?us-ascii?Q?vZFTri7aWANjYg1vjlXCKSJKwKH4dr0VZv07QWhLcR9xCCfhkZSqkGqwQ8i4?=
 =?us-ascii?Q?CD/UCScK4hRgIa7nlzbmxepxWfb9pLQkoUA3unBfaUIm1RL3WN8h9NY1EfgY?=
 =?us-ascii?Q?a+Oqd9YExdE1ZAj5reR0En9t9Xqbz+yq9WSjQl91rsGGuPnzHGzLJ3FUAL+0?=
 =?us-ascii?Q?bft9IhfgeUUR3WCZ/YoNRqccelHU3rRJYt85A6NdyZAzIuU14Ir/c3+57X83?=
 =?us-ascii?Q?tzbgWpUro7FX2HTPtW1+ujCRFIekkbfKC2+c43rp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bf6b21-e462-470d-bdd7-08db0f5384d4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 12:52:39.3293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VkbmFghUA01e4go0DWsZiGzIu9gMJZkBtT87SAOiMfJtkv18Xx/t1N4NwYuv0Ze
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7890
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 15, 2023 at 06:10:47AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, February 8, 2023 5:18 AM
> > 
> > +int iommu_group_replace_domain(struct iommu_group *group,
> > +			       struct iommu_domain *new_domain)
> > +{
> > +	int ret;
> > +
> > +	if (!new_domain)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&group->mutex);
> > +	ret = __iommu_group_set_domain(group, new_domain);
> > +	if (ret)
> > +		__iommu_group_set_domain(group, group->domain);
> 
> Just realize the error unwind is a nop given below:
> 
> __iommu_group_set_domain()
> {
> 	if (group->domain == new_domain)
> 		return 0;
> 
> 	...
> 
> There was an attempt [1] to fix error unwind in iommu_attach_group(), by
> temporarily set group->domain to NULL before calling set_domain().
> 
> Jason, I wonder why this recovering cannot be done in
> __iommu_group_set_domain() directly, e.g.:
> 
> 	ret = __iommu_group_for_each_dev(group, new_domain,
> 					  iommu_group_do_attach_device);
> 	if (ret) {
> 		__iommu_group_for_each_dev(group, group->domain,
> 					  iommu_group_do_attach_device);
> 		return ret;
> 	}
> 	group->domain = new_domain;

We talked about this already, some times this is not the correct
recovery case, eg if we are going to a blocking domain we need to drop
all references to the prior domain, not put them back.

Failures are WARN_ON events not error recovery.

Jason
