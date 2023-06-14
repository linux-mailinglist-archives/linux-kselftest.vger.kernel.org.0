Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F7372FD6B
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 13:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243961AbjFNLw4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 07:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjFNLwz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 07:52:55 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F4A1BF3;
        Wed, 14 Jun 2023 04:52:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKGjutLgHbV5Obwzh9+ZYr7Mxi0TAku/QB5ghO8lJy4VByeANhhzoVqLmPkXV/2dJznzithchbdyu+ccOMdoxHZYDRyq5+t7Xaz7FaCUKgImiRX5cYGYk6sG+cTjx4hvqYAIte8nRZNvJDp/7sQrFmB0QY/4aslWwfIP6fnnOwQE1hvT7/P/PhKpZHwFtTpANpaqQmDpUa0x+5RQDcijAP7p57fh0EodyrFhbcEHuUrHrnkdjRM+x7QUfOTIz2LCelaeL69f0WBngNnwZnixBtXlrZodPEscrqKVqp8tv2la7rswMAAkziTW1kFnC9yToQX0fyx7y08xbQjtXE/tEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwkUQq7bXC3QFqlS4jAf+w/NtuH95RA0DfP2hnm5J9I=;
 b=GynbzcOxEEHzOGC0nhnuc12xo5JAoo1143yDM9WRFvUUsWu4sLEK7PWgh42bfEiE/A4m8+Ge3+eDiEPGpM+Y+/HZ/2JWT/Dfg0mCUzCBD2B/WqrjfkxRFACT1eJgYhNy8SS47a6SCn3qt19tbBf+wlQfW4CbcINaT76zQ+93uVpjEA0+C4J6Wo5XhT26nwp5Im1xZi07m7mrzOSjHSw/wFAm5M91bnZn3OwSm5mW6S0jyNVG/8fYPPj16b9i56K80u7xTU0MbZuPiGm8/5jpfFqMtWAwIt5orjLXzQ+QmTbD2adJjmqzQdgOnjGB7CP5YcTvZ2BVKDW0EyljqA4Z4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwkUQq7bXC3QFqlS4jAf+w/NtuH95RA0DfP2hnm5J9I=;
 b=g3evwp6zeTT6nEuQQTE9ulwMnm4o0tRWilMJ8/ZL1TDVHQqygzSQ1p2RKUOKv/6O+d3S0Hnd5yEbL63lj1PrVj7OOht0hudFsI6PJYMHK9ICfBRTrqDYM4uzd03kvpzeEnkRHPVLs0P6daoxvDLstr3PLDwYFASg8rshG0OwLmOUNEEraohUh+G8hu6c5lE9MEptcmFQVK80/NhupR8PzIkHXY6tWrb/jVoMrbDrPuSscj6WieDVPZw1b59rS1xebF0BZi3D2O86w+mMBHSe2gGzMqBWFCa5/6DsTkdM9/Kc46G3h1N2TPYeuJeDzU4wWpBfIlKYqbOp2VYsOswpIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 11:52:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 11:52:52 +0000
Date:   Wed, 14 Jun 2023 08:52:49 -0300
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
Message-ID: <ZImqERPS0UV6mBsG@nvidia.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
 <BN9PR11MB52765FA8255FB8F8A1A6F11B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZHTyNgnjj/bOkIgi@nvidia.com>
 <BN9PR11MB5276B15B4709F595B2A5A84A8C5AA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276B15B4709F595B2A5A84A8C5AA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BYAPR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:a03:74::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cede1bd-078e-4a22-7d7b-08db6ccde206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UbzHHhqDNw/hiwiKPjw/slMzHdGhcI5Jj2v/rRiQw6DPfbtSRYG0ExUYnUp146LqsZmF4cwVvllThHlTiqaqM7lsZG0gtmSpvs3lhhp3W0uWOLqGCwM6r1B0Zkg5Grkdbwxlw9232bmb7Fpib9wsoiCByXX70ACO6hmW2UV7eIa0E7rUlRabohUfFh8kRy+tpW0H9LP6ophvofMRdVkfPQ/PdbFcTtXnnrdQ/uxkXzDo8LnyIJWYPxf3OyuSEhJkCcnqcmHOikk9G7YKoG6LBD2yEkGWh78bJsSV57XfiRU8z3nIMvKkw8RaTfeNn5AvvfgywR/0qNLfeUkg/5TOyrc052VYU1WwNPkWqxSyvB0FI/Me1V232HgF98fLnhwAAW7lpESWVayHKIYHsFJtmqZdbT9DWv612W7hk72WZNG9KgYlA+NhG79xS8A5dvb7RKkxkk4Qz6xBDvWgR86dknzT3RMfHuHL3fRIXN+joT1CGkdybyqV4Tp2NFDeu1oaFQaxvqZOiwEYzcVPuqSSW0DT1jTVEgtS78L0jjCXNDG7Xu42PkFKlLEJtl0SkgE+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(26005)(186003)(6512007)(6506007)(38100700002)(86362001)(7416002)(2616005)(2906002)(4744005)(6486002)(66946007)(66556008)(66476007)(41300700001)(316002)(6666004)(6916009)(4326008)(36756003)(54906003)(478600001)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?59D7FWtHi5QvKDstFNEIW5B7d+YNnto6hm+p1GGNLCb1nAqIQ7W0VnmqPIY2?=
 =?us-ascii?Q?+4HySCCt0CzgCa4toV+Id53H6kIkL12l/k2cRT0BjcN26goSjK8PqR+UJOra?=
 =?us-ascii?Q?l3nK7LeCMEnSlC0AxngzemUI+rWWlxZtj1apoQSs3mrNeY7fiy9scUhlLIwb?=
 =?us-ascii?Q?R67V61EXXVIY3LBdBOSmCDBqe57DPuRMlj8u/j+ZjJoR9twOHvyeMgseGqqg?=
 =?us-ascii?Q?q+UqMvFywaGv7H46zA/ASMdvQMqYozkwkHuaW7+FdLcP+A5Yrtmzk6sSzSiE?=
 =?us-ascii?Q?XF8oxNSoJH5LD05NKuUzonYsxT181VDhHUfXWTK4asYD3sbAVH654i7kI6hF?=
 =?us-ascii?Q?zAVdUAWeZEjyG/Ny7dYHisM1h/QsIHYfs6TVuSve2a0nFDJtwSI49YH1ZCtd?=
 =?us-ascii?Q?ATXuZLRKHpv8poU9wxt22ZvUAa5+8v3jdBc5YnnscpJJswjcCt6o+znyvEa7?=
 =?us-ascii?Q?PPesU8jkksqc+0j+pU+3TZWFf8PYZZ4OXT5Eslcf3QEcqUl/hox1m68jJc4X?=
 =?us-ascii?Q?kYd6h21OsEVtcu2ebFpfD3K6xhI1A/LsH5p3aHWrneOoE2Xnk7IGsSn10TjW?=
 =?us-ascii?Q?0vNt2x9cmsbQwKyidx9uqGlxTN5yxaTCh7sGo5HYOV8j71+CC2ERu43WRgwf?=
 =?us-ascii?Q?1n72UYsB8S+NWTxVv6mmEaddl+OG/0dwhg3aHflu9C4jpGisU6VJNQi5yT9u?=
 =?us-ascii?Q?FdMqB1zhmvg5NLtSm7VGGIJEImGqUwKz+JDxNhNovaY3173E98TTv8POV8pl?=
 =?us-ascii?Q?2vvNOQjQyboAfL23COP1jdbd5v+Z3XqjnA0Es9qb4uhqOC7JOxPQP0O3lg/m?=
 =?us-ascii?Q?bn8xflSB4A9EFp1A4Yal+jY+vvYQKGlEM9HmyktKEs8Z5dHk7yM86NGqPwny?=
 =?us-ascii?Q?w5nae1pYbi7dc5HFM8eiDZsraP2qKKMDcYrsHeWqfZWhWtOK76OuG4pJIsvK?=
 =?us-ascii?Q?wFx35+AbZ0hOA0EbiVGrrCnZnOnqs0xErtrSY/099qYeRptp6x8RJ/SVw3+b?=
 =?us-ascii?Q?HRi+4xJ2XzGbemztxr+/brJpt+kq1Lnt9z1XkHfUN2SXwD6TuClgVSYK69p/?=
 =?us-ascii?Q?/YvxEU8niE4uF1vXMZS80qrhZH0wBFdUoHEWAIRfDNNWxvW1RezVQ5iT762h?=
 =?us-ascii?Q?NixXJwOBRA9uEPFjjBTIwEwDDYef8wtnpBw3CMvaA9JE6BHVILPVLz+79NUB?=
 =?us-ascii?Q?IkRISfefts3uV+JUQ6nLCDQRKFdfiQqK3HRFspUIbCnhIGJL0rz/hX13Ow4g?=
 =?us-ascii?Q?dPa/tUUqoeN/lnM6r5t3ddZiZ37b3GS0CJMXxxA7zFl80ZwX+3X+bQyl87Gm?=
 =?us-ascii?Q?8OCRt7Cx41m7NB+hdPSTAPTuiUhoGtZ+nESGVX0nzbDK3OVt1/2CuvfVrmjv?=
 =?us-ascii?Q?q7jMpCLei6AyduR65P3h9LnrmwmeLoGbQ10tS+CpHTojtWmIVgzJ77C/gwIO?=
 =?us-ascii?Q?q/SgErfzlUA6A2ajbCMithgJ2EsvDZU4p6LzlqwtnQrHHgIVDqAiO6nj8nqJ?=
 =?us-ascii?Q?wVRGf91dyKMRNQ0pxNf19SG3pcOY/kbKrxuThRLPqFR/Rp46w8pvkBP6MDpK?=
 =?us-ascii?Q?zJ0GMAt+sXZ8VkdYTEgOaj4xsfVJLhza2Wkf6Ony?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cede1bd-078e-4a22-7d7b-08db6ccde206
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 11:52:52.2656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s21TLjNjIlRhwI7c57C705+tQx/GUinN/rcgFSSxADK1YlRH+zei02LXo6EVXVta
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8358
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

On Wed, Jun 14, 2023 at 08:07:30AM +0000, Tian, Kevin wrote:

> think of a scenario where the vbios memory is shared by multiple qemu
> instances then RW allows a malicious VM to modify the shared content
> then potentially attacking other VMs.

qemu would have to map the vbios as MAP_PRIVATE WRITE before the iommu
side could map it writable, so this is not a real worry.

Jason
