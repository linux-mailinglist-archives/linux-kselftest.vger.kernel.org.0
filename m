Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1C37096B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 13:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjESLnD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 07:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjESLnC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 07:43:02 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D17CF7;
        Fri, 19 May 2023 04:43:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8vyqNZ1I2te/Tu5XT0gv1cy5+HU1CATTaJlNgtyUmOvC7oH6rJEixeE7fQqM//B/3D0QIUA1E6KPQaSn4aM1dYza0lWzRMhYulTXCNQDm1GIeARRkxqkjFRAoEQi9NmbZ2w5X/frOKfUZDIsVV9BMK5t/ZaFOEl9LD2lOJ/s7IOOqneVtP2vXZMndK98hUGUGaRO47SnczWUsBG8oAl6zr4Z8dw0vOj40NyCaRltqEGRITpvG2eFnoD39BIPdqjDdmWycY5ED8/DHZGgn2HvB6KazOCDTITWHB5x1klIr9ojo9EEmhrcp+H9qWebjj7lOql6moxpRBm/RtxxQabhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMEHd4AmSUaZKITjct6nNNjC0tZgyaqgpV6OYEUrQtY=;
 b=X83ahuHaZZtd5237ekQLM7viJeBIlYOZsRhWE3IpxHDARlWzTy+4MYGiinF12JUPePHDp0ZOJU6b5c3oP3XJfv7plcNn4zmec9kzrcjpGngJGufxf0+7Ru3C6kHKqypO7JzXJ4GSR+RfRupm5ZG2jeq4NMrnOvKS9aQKQrjHSsbjcFls9Aue8HiYnYA1WgA20/XIqh9pdTgAyJLA25UtBZgSwSwX1qHZvpHYL92Ai5+e0vCNX9Dexl8XCeIzSUKdryrcR00K8E3Y9Fipc3AHHFqZBZ66BmB4LmfG2KdjvhDrtOmbV4FFl9BxrMeEGD8FRssgELfgZ9mc1D54qBb1vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMEHd4AmSUaZKITjct6nNNjC0tZgyaqgpV6OYEUrQtY=;
 b=V5LbNJ0AG1hmip6RJFUQQ+Yy7Kaw8R5OLiyhrSls1CMA3v7A7/vQvrNqamWR8tn2qh/G205EBRg2FD01WMRnYiSemw1usEvorI9OXk8tZojTGDKUe+NXdBuUgPpW1XhkauaqX81+MUSUaREu+CQTmTPBa1RqX8qh/PqSsFsuO0lpmCc882LH2oLQgvXylrE/NehxaXxUNcM5K9IZXgSMSAsiYl66DgBM8vgyJ4Gk68pfrY4xAnrhxE0tgmbLU33v8jGKXg0MriY5E7jD1N8GV27rSA2V9GcCifRwXQYOly7h/pDcDbtDcyDHE2qiJIUuVdcGBesBoUpLgk8/wcIQ8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA3PR12MB9091.namprd12.prod.outlook.com (2603:10b6:806:395::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 11:42:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 11:42:57 +0000
Date:   Fri, 19 May 2023 08:42:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 03/19] iommufd: Replace the hwpt->devices list with
 iommufd_group
Message-ID: <ZGdgwFI5Ejxq+7F3@nvidia.com>
References: <3-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
 <569b959e-a702-fc19-3d67-0dde4e77251a@linux.intel.com>
 <ZGN2yvhpIvrvu74r@nvidia.com>
 <852e85b3-9fd2-bfc2-6080-82cea7ab6abd@linux.intel.com>
 <BN9PR11MB5276DE1BC30E90B1032C0E468C7E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZGTMCSJKvgpyYxG/@nvidia.com>
 <5cdc1a83-f29b-6862-d513-dbfd5c500807@linux.intel.com>
 <ZGYT8RmGM+vwNzDa@nvidia.com>
 <d99e284d-31b1-6d04-cf14-d7b160ee3f44@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d99e284d-31b1-6d04-cf14-d7b160ee3f44@linux.intel.com>
X-ClientProxiedBy: MN2PR12CA0015.namprd12.prod.outlook.com
 (2603:10b6:208:a8::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA3PR12MB9091:EE_
X-MS-Office365-Filtering-Correlation-Id: 63369204-e348-49f4-2c09-08db585e310b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wQqNrrDeu70nH/GAqIWMJVMAcrHO5kmWuJ6KOFCARgfwgKXWv2/yIrxe/iq37AA6aTCUM0Lco7z+cDK8LS4cLo6+Iq3IHhSwUsId3LD4sM3Z1xAm2OqcP88lWmxf2KJy7+k/9uZyz4jjG7Znjr6+9F3iPXmTqxsCaw6HbG1PV/NeMTrpst0EYU03pevGoYNek8tEWc6zmuK0wyP18ocswwlTtzWkhxqTgIOhM6YIYhitWfCbdU6WjESSnw2D2fJbR8WHUimwBcoV8J+2qrFywXXzmFsO5US7FTH6CMGxRSsajvmK2BfNHjER17yRQTBSr/81ajTckvcDLOrtUmHt/LxuzuhxpRTHmJzEN+SQQfSTsd6YThFYxy/7M7B+xWG8MxP9PPcCZGytTndY04rJvuT28R5GcCExtmo32ZPIdVL1oRrP487RPfVH4cvNqZ7mK09+gF0XS9LZfM2V/E/6E7bm5o9pXjVcQj1wEpu+KjgrWm4QgJ/EmBkz80STwpFGYKY4YFYS797nv3kpL7IBHy7gl/vwDB0kLkcIkf2cDDEaya7dtpPmi5RNvngJPSm6gP3TXWfA1t+7kTuC+z7k4QIRfTgZabwxaJw2J6H1v+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199021)(478600001)(316002)(5660300002)(8936002)(8676002)(41300700001)(4326008)(6916009)(2906002)(4744005)(66476007)(66556008)(66946007)(54906003)(36756003)(6486002)(6512007)(186003)(6506007)(26005)(38100700002)(2616005)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qkje2ARUJBKmqcsOsYzpEOjrwF2uIhHh7bAPRu3R3yjFbf4TtTiGFPeYH67K?=
 =?us-ascii?Q?aLwMIFlJkp1RvbCJ6mfe4No8iAVlSBmdZp8DYIc+QBO5XqLk+BcH8wG24hUj?=
 =?us-ascii?Q?8XY9snKX+WxTXtRKhawnt8GKguxCxMiIx2RDRiJefc6JW9JX/0nMeXjo72Oc?=
 =?us-ascii?Q?rvGNAQecwM8zQvKlJXyrkKhzWkgtLayqyzoNJHocVIlUZBoTZJ9zAkGtaDZY?=
 =?us-ascii?Q?ECc4UBxJNcoWaVGWX52rKDon1843vpgufE6HOmdEHnxxRt4HpD7nJbdpSC8T?=
 =?us-ascii?Q?v2qys95WBc5tFWnEIiyXHyY7KlNd6EsJnLaKLQr9/rAZhAg71s6avWlUiKdR?=
 =?us-ascii?Q?4HfdXpRWtLZsRMJZQExsQ4vnE6NbfD3Ffv4PaPMdbWY+izl4PJeVpuAOMrvj?=
 =?us-ascii?Q?NNjlw+I6lp70OwqYDNZY7GpUrW5o1gqZ371KPTkatUmATx3Sek1ve8Z0QHce?=
 =?us-ascii?Q?VM3mNxXFq3hCkNGOIzcALa+Fot7W9iumG0oip/sW8GSIGwsvGCQQ0OTfzfmg?=
 =?us-ascii?Q?sRCpy1Pvdnv+EAxR1mMPU92IQh1YMtUnX7ZqETaW++0qvsQjxbD3arAJeRt0?=
 =?us-ascii?Q?pUqyqXwbStOxVJM6JYvBiJW8N51hN102D9ASE9+60X6Km5SnAtpzc+XlJkj1?=
 =?us-ascii?Q?wmjTm+3vHfNanX4nFqgD6IxUSLP5f4sslSkNo4aKqP5F75Uwl3lFGPUeBv1I?=
 =?us-ascii?Q?im/ankbsdYr2aSH/9OnZulQL3mBEdmsaq+TRAfue8tMpFXNYETAw3Zd+TYVg?=
 =?us-ascii?Q?oinnG4tH8GQUNLukxG26rs5R8pIywYTSbC8lm+lsfTjPVd6QHy/v7HArTq/G?=
 =?us-ascii?Q?ojMldoqOvnYxptnKM2QhIYmTHbobpwKZH8HLCLHOtIVrV7bmvBrciNcAMiCs?=
 =?us-ascii?Q?91FMXL9QKp3iEw6XHhY7kwZ9ak/j5NNVpQRpKEtiUJg5WEAq/dBaxmiKFMDo?=
 =?us-ascii?Q?O4cLHbkrKdEPlIEbMm5+SXgdUiXmfv0eQHxT4689fNHixOPkjmVpI+O1EvR2?=
 =?us-ascii?Q?obxY9cX3M0EtqSfzGnXSSFbWlShspdr7myvErvb9eInqktLpJwXv1fjCTxIX?=
 =?us-ascii?Q?nB9eH4dMxHjB6+L9CZvC6Wt/yZ0x57KUhVcxsIc3TeJpKnfjlbKLsrsrDu83?=
 =?us-ascii?Q?c9AWJX5eIE+oWAjr24aUH6uFfVY+JEOUZNO/AW3QMZmZJjFc3TpHCIi6NiTq?=
 =?us-ascii?Q?7LixINuRoKjk+UJpUA4fIl9WW+qpZLCqTmLcqaAdEz8dniTAjFjH8CWu5HMt?=
 =?us-ascii?Q?iYc/xNO3oZnT10swXDOFpRLPK+95Q/io0h1GizEVgq8UeuQrRF0uQNBi6D6B?=
 =?us-ascii?Q?qfimM4MbG9k5DwB4Aedm84SRtjEN/27Q44bR8Mtsmn6PJUm2tbBZYcbr4YVD?=
 =?us-ascii?Q?7AsmIo0T7xSMMpbkyYq6zWxdLMd1TXtNq9C7iUmq/qtlrzGRyK+pu4hz8wKF?=
 =?us-ascii?Q?zCgzJjKm/j93dO15aQZvhx4jSjN+1PyhmdPvoud9Yy/4JoM4Ao7maEDjGznk?=
 =?us-ascii?Q?KtfXyDSB0YRAbeTNNrH2eptWpGKVbMdh9ioX7roxT9scQmD2c7eqgUk3m0pC?=
 =?us-ascii?Q?tyVoeoTsAB0qBSeTeAIA+K5Bul6ios1St7bawlVF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63369204-e348-49f4-2c09-08db585e310b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 11:42:57.7304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YgODbkkTYNBgL6Z7QlU4jbZXeH0Mlx3ysde2r2tfg0Z+QkzfznJ33gmeCVmbCYz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9091
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 19, 2023 at 10:03:57AM +0800, Baolu Lu wrote:

> Agreed. In addition to fault handler, SVA usually needs to register a
> callback to mm_notifier to keep the IO or device TLB cache consistent.
> This part of code could also be consolidated to the core.

Yes, that should not be in drivers at all..

Jason
