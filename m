Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0626A438F
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 15:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjB0OAh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 09:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjB0OAf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 09:00:35 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15F912064;
        Mon, 27 Feb 2023 06:00:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5xO2EHVVg9i4BREYTH5hFVgNvdVvh36BQaCBdvYs+p3ZKb6Ic6ljG4UbE9tr7d+aQwLDTX1F7k6uDF5WaYiWbQTNOqiTlwswhHtSuHhlxNeD8fsbN+St3TMJxXr5lvsJrvqe8gWSG5eIU5Chr6oxipv+kky4s9UhNyQVLrsuzphfanh50ZuW+bXkzm2h69DYaTCgKt1yWn0YLA7XEjNNFTNPY6TUeoJAVM/IrCOAoewZjvpZV8CnxTlkll0JcqBj3P5NnxPHYfHCJn4/rOGXOkH2uQeGrRLtosJ8T8p1rFgpUqxtJ/aIjGvuQGsXryQtv0VIIFu6phki/JLRmzJUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYfkqvIp2aJo2Wu9/j86NB+gIRKso1wugOeDUGf2Odg=;
 b=ZWsy94CCps89ha33ISSa3rMH5IJX+y5Ek/p0dOqpvpxXT5wpG+buUdv0+5KKpaM+j+Mg2KmTpgi2/9inVBbCZhT7CbEkwS4OqbkfIJ2w05WQIWDHV+N1iAVOva5ox/0k599pDZ6J3thDvExQM1WqIJKWG0aRW4ilyVcRORkBLA9MZ/GCs7fXs//12ArdJ5Ji1XqPwbRffXRjkvf4Ear+rbVxHHqcLrwwyJPqnDQpK6ZCMXBIGqaAj3sF8MjbWdrsq8K/w6Ni87opeWi3PK0YoyzuymWhdcDZEwXx8jJrUhBkmOmjzxmqhxL3aA7YdR3nNytZPopMB/kFUX93ppse5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYfkqvIp2aJo2Wu9/j86NB+gIRKso1wugOeDUGf2Odg=;
 b=eQyoOAaGs1D6GRuGMtEn+EI0yta4oDzSpnV8NR8VCZriUs/31rSM2OHHw4abi0c+wn+Tpp1+k7hmrUy1PNPvXghGsyLLEXfyPxu44udT2sEeAO33rzH/T71q2UgcBub/PBDacbUsLJ2Z1TDQG1iFpdjHYWR6aUyyJDUznzO4hz+KhsxCndLbAD42VgNVQygLVwZudBSyFT4JmMSagrgHYCsTY1iKnu5px21FFta3vaiGe0Qy6ZobsDxXkb95Iz5NeT+uiKQkKKqXCGjN9HlBtSug70tDPjZi4NlXY4qJKQUjFaKY7nTL/v17YQ3RNSpYP+XdLDcrRqEQeVO/LE/dFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6638.namprd12.prod.outlook.com (2603:10b6:8:b5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.29; Mon, 27 Feb 2023 14:00:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 14:00:31 +0000
Date:   Mon, 27 Feb 2023 10:00:30 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 09/14] iommufd: Add iommufd_device_replace()
Message-ID: <Y/y3fnSJZB7QhAKM@nvidia.com>
References: <9-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <909ee61a-9cbd-eda1-89a2-349348eeb735@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <909ee61a-9cbd-eda1-89a2-349348eeb735@linux.intel.com>
X-ClientProxiedBy: MN2PR20CA0039.namprd20.prod.outlook.com
 (2603:10b6:208:235::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a18dab-9f8f-4092-8587-08db18cafd01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y7l8pmNM2nZX1MmAN92O9rJTw7F+q6u46o9jxJqPbRdXplxorUrWM9ZwPu5EfhAjAheg9kndp+gVMwYSGIy4LEFkdFIXTMtQ9ypduegvNwhr0U9eunyAU/QUmBrkrS6Emd7sCGnNoaf0+d4hXfxw+Yj39qI8aX/S+P4aHgv9CqTvGIN1GgKltuSf5BV1pvZ0rsNqF1WQn5EO96GbvMQNxDGcAgas7fxevmJmP6dH9ZF+7zqcM33fCqvAxKihZ1VieySR9vldCY4OANOtMlemMN+V/rrXAYz3qp3AltwJdmwxVg8yNcow2kGh+b0+OEJAF8I6UfUoRTUVgzcccRxS6ZfsdBS/9eSy05wPg8vzBl4ZyrYZWuPZvICK6IDvEB9dt5CXJAZkb8NHbV4iW+uH/qB/pur8maADLvKl+dho5lpCSMk++ljoGE/xrg+6r2wLQdjU3960O+k5EakjmcO94kZo1IX5ulk3srZDb2ZtLD1rWIHCY7JZpcDCd754E2VFg+cIgVhQV/Rog0jpNDOsqzqcqI/dmCSu8281V6n+V0YMSOXOfMv9on52+ZEJkZ9HQHM9Q4jriASd6KAajlBYT0w+zvWMlqKi98cCvm5rDHSeV3Y3tUjFZoubhsCvRVKePNk2++zaZ3SQlc79d39mmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199018)(36756003)(66556008)(66476007)(8676002)(66946007)(6916009)(8936002)(41300700001)(4326008)(5660300002)(2906002)(86362001)(38100700002)(478600001)(6486002)(316002)(54906003)(6506007)(53546011)(26005)(6512007)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fF3Ai1beD0BFBS20yMbL2Xd4eXP7ruDTr2LcQCjaAyd5jAyQW+T7Xqoezl1s?=
 =?us-ascii?Q?3T6gbQoNiey6zpMsaLJ1I4PAA2Ze8lsIZ8poS/Xwniky4Wz9+ziErG8F0EWg?=
 =?us-ascii?Q?q1XOBrYMz+elqLpBysHL2yiF/Cjpp6LR5Aaz849iTAgeHgqIB8balW9ItgIh?=
 =?us-ascii?Q?GitGf+EHbQjJWohCx+M3hLNC1E5J4iVQPVhbb/+QJscqmVeYcQGtmtyhXTEP?=
 =?us-ascii?Q?Z4eQX6dLXHLkNI/iwxNdePp4V3UHOz4VJyE+Pk/Bz/h4D0C3jqylF6+aknW3?=
 =?us-ascii?Q?HKjpLvU3n15JasY8JXFWv6XTnGC9LjwxXZznA+TtJJdUS0JvEbhkcxQVOKU9?=
 =?us-ascii?Q?efX65H6Z/ayNJCeB58CN6RtVzZuF2MXvOw4PQZaYVdidL3b/VTU28T1xrn81?=
 =?us-ascii?Q?gbrzioAwH8V3b126QHc732P0jD2GI3YUaCeuzLVtDlKF0dBBPUXs+5upblYr?=
 =?us-ascii?Q?H0czEaukHBLKa61CR1T3d+HIR8EReAM+wZo2qWaqXDGw3/8c2Y+GTi9yfhdJ?=
 =?us-ascii?Q?spz53Brf5pxU5PmtqB3qBnIe9mo6ozJmxXs1pFKkwnK84GO+a4Tn+K/x2Rj6?=
 =?us-ascii?Q?6w0V0riwHFaCxMW4yRb+qs49TOob6xfTH2SUtZO/lFyKzIQXBJ9MUL/0U2mB?=
 =?us-ascii?Q?NgslpRtFJeLDESEJMRC/wNhKYuKx/K97ELXS/kOo9omkbGJdkMmMfMNrGWHC?=
 =?us-ascii?Q?RbsL8qjQXs1G14Xy39iPSSIty1DzDCDw58YrsLWOaStHP72VCEfK2DQwm90L?=
 =?us-ascii?Q?+8d+y8XFpx4N51mSb1o5gZgGxpCtRjS9CbpfgEdo1CobX67Mfnkqqp2cfLTh?=
 =?us-ascii?Q?U2dP2Bn2CP5EXfIEif+0WYoI/QyDi/Vgd25sjpPnppsr2EQoPzMSvMz1ozFS?=
 =?us-ascii?Q?6j4tKrKD/TnWSPKjvJfqR6acIFby5LIQ6G7cn8iWDICG8aYn183uDGvLaIAz?=
 =?us-ascii?Q?387w5ChuagQmgcnGINLmI2K52p/P4agO0T969vxHQEhp2K0/EGri6t+Bzdqf?=
 =?us-ascii?Q?zwRDRxNeDDPwGAgtCZ30wkkp4QMvz+fVrWMU0JReaaA/iRAu61VfS+gfCUCz?=
 =?us-ascii?Q?uBu0YNsvfcPbnUk66LnNl6UOe/v1IPRT128gl4JRZ/Bp2/hg838ZShufZo9S?=
 =?us-ascii?Q?52IHCkjQV37kexN28a6xHPmSxZwt0EmYXmEwsCHf6GWVqvwRvGiFkJMm+ooM?=
 =?us-ascii?Q?DoMmqHxYZjXYE8L2t44KtB6vf5+aZo2Q6uz2HofCOy6mO++K/3ggj+4BW7CN?=
 =?us-ascii?Q?GcjgfkwSLh8AOS/7YBCBk8cV7S6tRtpsEtacA2AFFMIPbkZQLC3pE3VEZ080?=
 =?us-ascii?Q?aSzl3sxPNyJ1vHKphSDU6aGx4GEVa0tV7cXgX3QEKHxdmzdrH3GLnA362zJO?=
 =?us-ascii?Q?jR05KZxcofdfqRFi3f6v8Nv5s3OQt8zwoorQx7BV1TbShNOZf1NKTOR/9eGY?=
 =?us-ascii?Q?MZBgPIVcvjIsa2rqu3SE/lshNR01T8wR3u0mrEDZcKf49HGcVCQRueWA47uO?=
 =?us-ascii?Q?7BS09sh6jtFK6XVHg6fOOVg5XFInVuoLR743YDlmX/qJVNrgO/oP5N0KdBU2?=
 =?us-ascii?Q?E7gYkIqJBRkkmFPjMU42yIgjPGyR+ieU7aEwXnAD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a18dab-9f8f-4092-8587-08db18cafd01
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 14:00:31.6657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaaqc+lLkQjF5YZpB8BwjoEQBKHLyvcf1Uqym6XOhKxokP5aED9Kn+RHmtjweUBA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6638
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Feb 26, 2023 at 11:13:16AM +0800, Baolu Lu wrote:
> On 2/25/23 8:27 AM, Jason Gunthorpe wrote:
> > +/**
> > + * iommufd_device_attach - Connect a device to an iommu_domain
> > + * @idev: device to attach
> > + * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
> > + *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID
> 
> "Output the hwpt ID" only happens when the caller input an IOAS object
> and an auto domain was selected or created for the device.
> 
> Do I understand it right?

Technically it always outputs the hwpt, if a hwpt is in put then the
same hwpt is output.

> >   EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
> > +/**
> > + * iommufd_device_replace - Change the device's iommu_domain
> > + * @idev: device to change
> > + * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
> > + *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID
> 
> If my above understanding is correct, then replace will never output a
> hwpt id as it only happens after a successful attach.

Replace calls iommufd_device_auto_get_domain() which always sets pt_id
on success?

If a HWPT was passed in then it just leaves it unchanged which is also
correct.

Jason
