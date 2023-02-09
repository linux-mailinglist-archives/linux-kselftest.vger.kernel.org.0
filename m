Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3CD69122B
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 21:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBIUjn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 15:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBIUjm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 15:39:42 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEEF643F6;
        Thu,  9 Feb 2023 12:39:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVl0I96zQarHsW//hBZW5Rt0Wy2uTiYB8gC8i4EovTfsjMeTDxqcRkpMZbnXtcCivSWAQ3iOh6f619bIgZeWf7xXApZwqllr2dJdJ8PCxK65GwJ2PLxTRswIs+15DZkmOeWcSxURRWVjOw4a+5QgbdKNnsDVNtVBJXFLsUQ2XLcNqekR83wirXlIfzm2sxdWu4NrUdOxDyd8MwD/Q1sY7ldkuJNd2DQDbkLGM+GSyjtfpYYBwRMwlOjT1n4nBwp6oGUYjuV15t5kyBCCZEotAuMM1zESClkdvvhwo7Rd84JbsHWRHjn8I24SLlIAFqXY5UJWm4McO7CUlostZgXngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paWjbp+k6dvZ82HBiEmDE6s5UaWHF93I+mRbpVKXzEA=;
 b=Si9EiqxA2tI0RzDtp9E40aOo3s5tbsRF3aAIV2fzXkaFGPy1qahU3jWzQzdbvxAi8npqJtG1LG6e2NCOawUAxI+wljwatNV9BN95FQ5C5fNhumXIo9fLX1HkI8Xv5C9GBKOt+jo+ZzDBePb3IgoyD5XGmEMzfgje4XSsuby0rUyuhenhSeKZ/la6U5i6knxd4rc1fpCbB9Ci5SqbYK2zFOp2zCeek/hNYLLiniCDhu+c4tzdyTPtS1BShwQNCk7uw+lFVKEmuiNRBQcQEoVscIf0/qZMlQ8FUdqaR3OBOXgGLWkYNvbXwTIwnZVByvhT9jRq7vzj6h3boWMWbkksyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paWjbp+k6dvZ82HBiEmDE6s5UaWHF93I+mRbpVKXzEA=;
 b=ZXBrIZDlAhj0gzSLWhieLi6d8vF4reUw+GRYsaMyYytjfOndNNjgrFg6txVm7PBpGUNhEd084GGoccqPjfe1O/5dyoDeff4o8Hx81EvmempommCOtMLOzR4NXjMLW+Ly6i4ysR1Ewr9xoODltcG7cdquDrS/FsLFOrm7t2XeF7JJli41DncEny8Vj8zV8W95LQEWvtV9EeihYEImTK1uHwc4fCqaG3LORLYOWtvC399rAAcxbiNyyIg8vhCvR4egpih49UJUUIkH4j+B2hGXCkx/PQkh7QpBdWc6PnhqhrhGNthUOwCpp8GHwfmq+9vh9SPTRTxt+W3ZK6k37QcmDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6004.namprd12.prod.outlook.com (2603:10b6:208:380::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Thu, 9 Feb
 2023 20:39:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 20:39:39 +0000
Date:   Thu, 9 Feb 2023 16:39:37 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Yi Liu <yi.l.liu@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>, joro@8bytes.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        kvm@vger.kernel.org, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        baolu.lu@linux.intel.com
Subject: Re: [PATCH 06/17] iommufd/hw_pagetable: Use domain_alloc_user op for
 domain allocation
Message-ID: <Y+VaCV7DRR1+mLYY@nvidia.com>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
 <20230209043153.14964-7-yi.l.liu@intel.com>
 <25102c92-1831-be52-677d-60bbf2e11772@linux.ibm.com>
 <Y+U9QX4p5YX3/B3k@nvidia.com>
 <Y+VOw6dTnGapMm9L@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+VOw6dTnGapMm9L@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:208:fc::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ed5932-7b12-4138-739b-08db0addc37f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cQ8Fz82AnfgT4MaoC7aEfPegkFcZ7OlO6LGx4exFKklbBlVdw+gQXT2wkHf8CBh7P0qBFCPq5Bh9wT9DmUOh9pA++RpLdfO4CpYjMsxi2F+Yk0IUy+PplvTUy5hIAKjaFocOwBL2BpD8/4lJr2IGAPZtDjp7N/fXFWAIDt+zfl/XQrtfFAt+ep0yVlU225OOPQXjChUf4oIib20ZL2Siypz2LctPsqq4aPGkmt4QwsqyVjTMoWjDsE09hg+PfG6Q02ON5vzQkXUeWI0DPqzny+5+jQEu9W/Iq843A/sflXwyU9wmtB09bf+fSCu/o8v7dPXkKHOguWdFAiKD2MX44rHqvJsOFsJC7X2dVOKCiOqB7+NVjD4reQFKzSCwSYnbxslcxkf/vNN9LgYqArkSvPprEv09vLMwqJusrJ+EbR1spshO9qOXWqW+7d9JFB5OWH8q3DfBwmdTzOLy2Lq/fYFQYpBZyVoPK7hmhYOXeUV0Y0V88X4REpLzVmASai+osPeX5Bs45GCXI8W8/4xHXl3PQzNTBXJ3EoMZvzQXY1v5v6xkf3tPPpEsI62irmtRvte0DNHgSqqm0I0IVIAW5Fdqgq7ILF/7PQhJgmOgV6AqGjeDooOzpn9e8zDC/SpW/9IdrwSqpZ1oXsiG9uq5Tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199018)(2906002)(7416002)(36756003)(8936002)(5660300002)(41300700001)(83380400001)(2616005)(66946007)(66556008)(66476007)(6862004)(4326008)(6636002)(38100700002)(6512007)(86362001)(186003)(54906003)(6506007)(26005)(478600001)(6486002)(37006003)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fgGm/6R/6jT9TbLryd1i5gyiCurpgBhrnAKZcJ8bISwBFHtqTH11mUgYSAht?=
 =?us-ascii?Q?jg4xbRv1xj3DzX/aKe3VkvveYFDHeVQ33XlL95+8fikGGME+2WI30+Y6G2+B?=
 =?us-ascii?Q?Utt39dN/kTOWbJLFyhg5h0bcyAwfVN2tcMrrAqenLJi6LMFYY2ZUVIpNH+4n?=
 =?us-ascii?Q?CZMcPDvVdrWlgy90HCxW/si40WyihPox4iP0sQ9bcwJ4oBrlciS6ptu/1Qdz?=
 =?us-ascii?Q?Tp1XEQuvtflbBj+xwhJxB1m1lT1ipZcyh8AKqxRop0ykaprX9GM09zTiWpOq?=
 =?us-ascii?Q?T9MiCkF7PPUv/Dz90E6JkU38BFGLiP+CAnIeMhTJnGmlu8BIPG+DRAWMSg+j?=
 =?us-ascii?Q?WajKCfM2wlg+NdNcMdp/MJzZOFY45AHmQCjJyeJWOU/7PQiaIHp6YxUjJqCX?=
 =?us-ascii?Q?m0VXjjnBYCAueI5+Q2FWu389iYXK3SGv8w1i+z4Nvpnujl2zWnfpW44J+UZJ?=
 =?us-ascii?Q?/0raaGh79x4Cd/DmWDDtHl3Xk9C0d9gslWdGzZl0FC1eXcb6hbNFfUVYzWEf?=
 =?us-ascii?Q?V6FAJ9HVA6nbWDY1VpBy6A2ML8IGe3xqr4aTqKTz4BblfieEOvvTZ4JGjttf?=
 =?us-ascii?Q?PL3JZxYhLLn5dz3jZAhIGi0jE4wtjPcIRbovvZMe+2eCPv0YmiKqPWQlvGEo?=
 =?us-ascii?Q?ezSvMIBNtIAffDCcUFlxxEI3xrbsZRQwk/MF1zmmMWSAFpCdr1IDQ2rhMBw9?=
 =?us-ascii?Q?i5JYxD4iyE/hWhS2oIGQqppp196rsDNocQ13ZYMidTLj1M3HxxDPxCwPGqC/?=
 =?us-ascii?Q?ONGtetO+6yUmPeUckzTOaEC+LFO4pyFS14QXr+ofn2XBIWh7J8BVs4oguAaS?=
 =?us-ascii?Q?ZWD6j3YhuLKIIqa9Vsd9sfuZLBwrMWoC8TX3Db5oZnHrXc8KZ5EifSzU6qJJ?=
 =?us-ascii?Q?NyM1C3UejJ3ZtEduzi/1Q465Wiv4C+v0n5o+AAOXuY+Zzdt7NeMp0EslKvV7?=
 =?us-ascii?Q?HfQcajTKBzZ+d9KL11rbI17hQ8GeOpDXY+NweatvnIh6hUfck7RLR+Ruj4id?=
 =?us-ascii?Q?uEnsx42kiI+4eWIgsUrHIfiz6DX/eBJJihuHHFb29JrQidgdgD7jyPf1xPxx?=
 =?us-ascii?Q?fysxOj9ybN5DVvCIgEVcW7vs5wbTBRL7LNSAKblf/8OdG8ghelQXGtzVd86Z?=
 =?us-ascii?Q?UrNiMTIu6qWDO/AqzjoooNnehGJV6GMJiIEiFOiDqLXrMoXh/EC86fTWaBt9?=
 =?us-ascii?Q?5QOyM3sI9qeQAcVlSUV7LUuJbclzk+wArRtjX7eTgYZLwV+QU9W9cuTb5ldL?=
 =?us-ascii?Q?h6w/7Dun7urtfkX9vMNuf/tjMoco8CuDFQf4aqUtFMkzl9Q20hAFp5iP8+NW?=
 =?us-ascii?Q?vZ0r+U1ZuOvguweYNBQp/YakHWfc7672ElpXrx5PVl8YniGP4N3xXJ0r3nfb?=
 =?us-ascii?Q?DoNcAl+ZSfsBSFDooXixMh4Qm396Mcniwv6deeVco+igrMrfoRJipeSATAtA?=
 =?us-ascii?Q?DrzWqzo4gQ87OBv46n5Il2Za6QDd4xG/ulfA4xFH9JMOuDdkzUPuAqhDDAfi?=
 =?us-ascii?Q?ecX3adex0ZIkHejxomXW1iMqzPjAe9oH+TxDuyKtMrJC5IOYLqr0WnbJ+fYI?=
 =?us-ascii?Q?wZG9y+Jqb0EQUHvNvxhpBXmF+GXbldzwMm0xMxRx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ed5932-7b12-4138-739b-08db0addc37f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 20:39:38.9060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VpIAJZWWqK1q7uqKM4PGHnhh/ReviyYExCPsFCXxmXJrAOuADYef/AwJv2KPR+pJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6004
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 09, 2023 at 11:51:31AM -0800, Nicolin Chen wrote:
> On Thu, Feb 09, 2023 at 02:36:49PM -0400, Jason Gunthorpe wrote:
> > On Thu, Feb 09, 2023 at 12:59:58PM -0500, Matthew Rosato wrote:
> > > really should highlight that).  Otherwise, conditionally calling
> > > iommu_domain_alloc(dev->bus) when !ops->domain_alloc_user (instead
> > > of returning -EOPNOTSUPP) seems to restore the prior functionality
> > > for me.
> > 
> > Yes, that is right if the input user data is 0 length or full of 0s
> > then we should call the normal driver function
> 
> Maybe I am wrong, yet I recall that doing ops->domain_alloc_user
> without a fallback was intentional to rule out drivers that don't
> support IOMMUFD?

I think we moved away from that to the idea of using the dma_domain
patch I suggested..

> To be backward-compatible and concern about SMMU, we can opt in
> ops->domain_alloc_user upon availability and then add a fallback:
> 
> 	if ((!ops || !ops->domain_alloc_user) && user_data) {
> 		rc = -EOPNOTSUPP;
> 		goto out_abort;
> 	}
> 
> 	if (ops->domain_alloc_user)
> 		hwpt->domain = ops->domain_alloc_user(dev, NULL, NULL);
> 	else
> 		hwpt->domain = iommu_domain_alloc(dev->bus);
> 	if (!hwpt->domain) {
> 		rc = -ENOMEM;
> 		goto out_abort;
> 	}
> 
> Yet, even by doing so, this series having the PATCH 07/17 that
> moves iopt_table_add_domain() would temporally break IOMMUFD on
> ARM platforms, until we add the ops->domain_alloc_user to SMMU
> drivers.

Drop patch 7 and 8

Change patch 12 so it has a unique flow to allocate and IOAS map a
HWPT that does not try to share so much code with the existing flow.

The HWPT flow should always just call allocate and then map with no
effort to attach first. This will fail on ARM SMMU at this point, and
that is fine.

All the existing code should work exactly as it is now and not have
any need to be changed.

Where things when wrong was trying to share
"__iommufd_hw_pagetable_alloc", I think.

Don't try to consolidate at this point. Once all the drivers are
updated then we could try to consolidate things.

Jason
