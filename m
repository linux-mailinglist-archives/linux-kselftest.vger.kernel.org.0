Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B54B714F6E
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 20:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjE2SnJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 14:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjE2SnI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 14:43:08 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E6CC4;
        Mon, 29 May 2023 11:43:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c16SjvmOEYbCHDyKHSXu0x4vyROL7u07xkzxNmknHvdZ11H2mdEwfO45bWn0Od0Pu+A6pwVWac5Hh/lJzWvRXgcscHHtAvUiN6SRAXBKIiFyS38OcAZm2TlQlQ/MBLxa2/R3WANfS7DV9zrtUu1/KMsCsa87YMvEYjTB4Ck1VcY5Rqehzi+ZqGOpuEscyRKQJ81nZ1QCugNptUoouj8GcKsvXFeCk3O4TlfJcxEKaXv7qelHBYcqnwY0lsKt35BHrpuu0xJiFeoM3YPjYoMG4m8wNWz9XnpAmzK2lvGYfDqtbqvOgZwunkZ523JGugB3jDyAkSNPYhD+Tpgp1DQ3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfXuU9mfF5d7TnOtbhROXKSnjZbmGRkDmwztLMla0Gw=;
 b=Wj1PHCwo5aZv2fUsWvGmNOg1Q0RxIqlLhPNJ8GNAauZlqmH8SkVT+aqM0thBxCnWOheR0sF+p3KJtX/MADr/0sn8tAHrzDwMn2pG3ORLDQL8Xt8Z2wTayUvWoOJ/O6xNZeTSmCx2JHAJ1ASwj5MeZxeyEDH7YOUQDK87EyZKwlyhRIQoGw9T203OcqknLZ3YwAV1uLkPYQ7vE5lqFPKjYrDzvtx+IyO/3laa4L3BC+2IXFXOpWfBEtgr5+co6FxWpFOVtYHYc99yh72DZz4mBvtY8dFVbZHLnaK2J4jUrBF7zoJJirMdkypOwtsOx8rzfbMyn5RE3bOxotKaMy9nQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfXuU9mfF5d7TnOtbhROXKSnjZbmGRkDmwztLMla0Gw=;
 b=EGGNLsM4WXqkIbtYKB33OgnlfitIZ/7zEGGziM/jsArKa19xiJKEZD9E72p84jg8Zk+T0xIH1TTUkekkaY6eIVggmnqZglEDV/8KrEuQ3Mq47iHHuIq97owzxzQu2lktA00Wu+RlfdTQELdtigl5HalH+BJaygitQEdAVUszQAkvgQsHVfL6wM02fcrRp4b3AbNnBZAPS1TT1t0iitT0r2AYW5Bs9TL11bfgcIP7RU0bdqaWwxc6IJJUG68CUFcXgDqwQoEK/FB+5X3qzab2wU1SHuvhnJuOcBWgyX7KTg1ivlpjUm9P//VN1ViSFhZbsK9TcQhntQRKarNTTtaBaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB8104.namprd12.prod.outlook.com (2603:10b6:806:35a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 18:43:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.017; Mon, 29 May 2023
 18:43:05 +0000
Date:   Mon, 29 May 2023 15:43:02 -0300
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v3 00/10] Add Intel VT-d nested translation
Message-ID: <ZHTyNgnjj/bOkIgi@nvidia.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
 <BN9PR11MB52765FA8255FB8F8A1A6F11B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52765FA8255FB8F8A1A6F11B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0292.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB8104:EE_
X-MS-Office365-Filtering-Correlation-Id: 89932efc-28e2-4904-6cab-08db607489f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XS5X71pmuTPCRKqOk6VVWOoGh37ZmRrmJ24EISOoDzpLHcFiAmVVJiNB3uM2N6hzHC/e8KIJkUern2OG0XMaG3bBADUbeIEved3EmzodmdVG2nrtsRBv4UUfPMq2CYYcdwkHnqN1MMc4nAdNIU2XMl9z2kNF1B87lVM3XdOnwpmDVOk2d6HLRz/xiBDhAimPPcMPNcGzYq/elckKt6yxi9Uk5b1s+zTGXq1/hNWX7U6S/AA84knoSwFu4YqgrBPaY26nS2G8750bVlfDkolHWeXtb6WnyfjDICg21VV6hGxp8a2LI8NE0gHcoKGcDnaZVe4oXu3QnA8ED2yDdttUi4vUcF4hBrZgW7WvA5tuotXVWQFfB4l7nvKWsZCnheuOjsbWuOFiAcv5p+sD+QfyFlCvcmeT40tIC0iME9FwSFmUxkNYB4V8UHJeGC2xF1GnIjOaedDRQIGmchryLnNmJKUtAlK5lK1l2jgTecXX5Y9uKyQGBU7BavZR+CrDLOsDIUqLHaXNvp7mAt4m8hva6jC+84eZhePlYnJBLvOC42Uu/MqlDYDxUJKjBuvaZ5IN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199021)(186003)(38100700002)(2616005)(41300700001)(6486002)(6512007)(26005)(6506007)(6666004)(478600001)(54906003)(66946007)(66476007)(66556008)(4326008)(316002)(6916009)(7416002)(8676002)(5660300002)(8936002)(2906002)(86362001)(558084003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DxHU2APywsIEybaOhGKqBnjKlepfmWbP9XOklNBZTycUfL+NF57Mi5Q39hp9?=
 =?us-ascii?Q?VklOaV9IfN56kO0xWmXlEvgJRBpdyCLCpPkAATUntb4iT39yTn8r9/vBCS5N?=
 =?us-ascii?Q?NyB6O1D6TIe8lxon4kdBZMPxHBaapsFQW8Atae5oTA1bmfh0dTWtKo1Nd7ZX?=
 =?us-ascii?Q?C277oWeUWG4VCyLwzEOyWwPa5g9B7EMOM0IRD1nydRk9J5NBBPlv5Wf0m1W5?=
 =?us-ascii?Q?m2daLbkjADMdWADmSXriy687NPVl//wyDwpfMr18a71CZWeXjzBnrnOvCiQS?=
 =?us-ascii?Q?I+XtEqaXL3+asPC+1JEPTutYJGGTSrFW8gziJlgNYgL4L3jfBTnyejX/q6MA?=
 =?us-ascii?Q?/2fgztdDzV5t/ucz7HrbwGJpsAKSjNprAWwax0fPK2PHd1V6R+3MWTdy5qTf?=
 =?us-ascii?Q?YKCqbzb3103JHOToh9+19zxyRx6csNWNgiFi0CjgRtuqqjOWCg3AP0N5l9tV?=
 =?us-ascii?Q?WsdX0r8TlHGEfUgEB//RztJBMTZOWLUqQHcMOzPM7jPTs0umQkchvOAMVXWw?=
 =?us-ascii?Q?+UI1Ijh1qgDuc+MEhcLGwyv4mvSqyNTbfOHUkBrgiiFStELVKWFzOfRVsAzB?=
 =?us-ascii?Q?t3L4WT9rFf0/W4+AfXciqn1Tj8rdSQUzpdJttbJyXvkJncx5oPQu/ygG01xw?=
 =?us-ascii?Q?Md542Ldz5XooqfxUzPzQjdQmEbcVhuc8fPb7t0MT+4I9jOyiuuj+LCEomF/p?=
 =?us-ascii?Q?6otRdE38FyoSty2QnRfvrKV8Oye+k/6ZbonZu+4mOqwVZefgw8qGYee+BXgz?=
 =?us-ascii?Q?6Q8MBvDS8iaeN3kjxNh5tboOqMKkkdmjc8gICKCp7/zbR8iprZyXOEQxLgL+?=
 =?us-ascii?Q?HqA3BI52VOH7/lercozZslp848tsNfySQx9EpVP8jtsrYzsTgaVzIUZK4Cd3?=
 =?us-ascii?Q?6C1u1R0PjMQIsd816AzDtquAZ9Lz9yFpxSQJygprE17IFKgTfJrhfY1IwoOE?=
 =?us-ascii?Q?q4JDNYJ2UJHydeTIVlyF0h35wD7CduseM5CnzGbsQ99P8MtZ9DkTpMoVxDcY?=
 =?us-ascii?Q?6AEcVj/VzfNvQi8ZLQnRTdylckrLpekU9qVtSZve79maoq+tNB6Xrg5fLFFx?=
 =?us-ascii?Q?BH6Vpq8K53Qsogt67a/6m7H+riUnqHgfnqbeVgOp+Dn60b7lQgOgcKjTA0TV?=
 =?us-ascii?Q?VRsjuME7JCLyQ+S41T7IrsWpbv+SY7OITTJ557ubBaXZpqw6wsNVF4MGQHe3?=
 =?us-ascii?Q?WHVVWmJmFcJ0N2Y66ibPVI1F0Omug+XZeYfF7ZpX0/CTqjTLi120EE963K9/?=
 =?us-ascii?Q?GeCYd6ZA9Q17WexaKM3kWdPSc0yGT6pw4V+IURoAIK+4f3Q9TJ1/HXnkR34/?=
 =?us-ascii?Q?3fk7GGZVlb4BxjrUlscMcWFZQdZRRk5EVIT5zOKGLFfOQjI5bCMzqCabiN4d?=
 =?us-ascii?Q?Wx42RzUqege6Zvbqb2fC7vItfoASNNdYsoerI3APlTEkzTanf4S4izPNEV+k?=
 =?us-ascii?Q?uUll9qBc/l/f5hrV37J7V4tCDVnM9SLc/4G5yOeXA/PIBaBQYTLF43VgKs+y?=
 =?us-ascii?Q?Uz7OMgQvkuZ9C/LZFLEsqzkGNDxwEN4Z7KCk2ngeY/68fKFDUoFcQxV2Igf+?=
 =?us-ascii?Q?8vI0Y8D4WT2XIj4ud1CO9GNFyBNpuiN8meMK/2H0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89932efc-28e2-4904-6cab-08db607489f9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 18:43:05.1795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5e2yFRUijJDiNlrR2wf7WeNFTvMFPUd9qbk8bqh/fOU9UrsJ+k8OOjXqhLoyNmO4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8104
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 24, 2023 at 08:59:43AM +0000, Tian, Kevin wrote:

> At least this looks a reasonable tradeoff to some proprietary VMMs
> which never adds RO mappings in stage-2 today.

What is the reason for the RO anyhow?

Would it be so bad if it was DMA mapped as RW due to the errata?

Jason
