Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C2777D06B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 18:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbjHOQys (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 12:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238285AbjHOQyP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 12:54:15 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82194B3;
        Tue, 15 Aug 2023 09:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fh3M4N+uRFeywhMKG0KE+oF4rrnvL+sU5HlwGv/m152iJo6BCkHRE3OdFWuGo3pF1/gTz/pvrLCygKP6FB27eABXNRVVu8TTIxmparsCYPFzo3i6rIrgMZONxv9zNgwVMKu5IOoge/abT9sqiiQKBLy/9OTNR6pPCVrL1E+PdQqe3KHAP+HltQ9ebi9t1dWyv/MBzZkM8PMBV3hQiz3vV5PC8BDRQL44WX+3uS80SHH/G5o8Gu/tR+r9kfd5SsDUaOu7gaMbs3x2HMufOSKGdEW20aRkPbRow5mkw0t+Hfg6QozOBth+IsU5sgZVdoi4PJNCWddIDMFTWYazIEYEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpyOD7rwVPBgJYAYGWqNk4qIG10jf3FqAXMyanT8dMo=;
 b=jvxA0yyeGTdrwiQFWMFHavddeqguxOGyzBHaNg3V7yluuxfjWM1Xwv372cjGZHeW3Ux1MV8UW7CS9vp6TpW+QGzmj2tBHvo0J5zGOf4KrMIco1ntsdNs+6QzS33dEaiZaH+Z/UVIBxzqmud2sFcjHKd7whEyIbBHIpXFvP6vrAdG/a0qwQMqKngSbwek42s550rV9upS2IedhvXSc1AouuWLsxkU/ezo4Bx/uVOVYJC8haaZG45CFmXilY8DX/VUklzSECwIVTMoCkmhw9pySH1jZ6xeKbHi54Bs3vzpTtkxL7izMS2ib5+LBLhNBeBsgf5pGrpiezIAFwV3hOHlPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpyOD7rwVPBgJYAYGWqNk4qIG10jf3FqAXMyanT8dMo=;
 b=m+cW2g3VvgyePvgb9AljL7Jz7SPOMNkUcIKAFHjaF5gI9OeAhZMW1ESz1SruT7XfbpcEdhp489skWzXrjbfBHdus9OVBu7MVCKru9FiqIFyuNxrpv8l4/Mm7s1JmDtm09choccF4LQX76ZzcE3Fqp6nUx97LA1LEcWcZ8cROlrKJadUwsH0R9KUd81diDLPK8bjOCpgn7+mx8N/8fCVd8NMki7hLrwEhFNhI2JqlG2f1fzGGbVrrhd3Ku1jttVGnCunIBM3f4PS3+kPrYGKHUIVh0bWTVses4CYqW133HUCHIV70g55j5qDwRwazsOsleKxa8rnal1TQGJ2eEsWkDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6765.namprd12.prod.outlook.com (2603:10b6:806:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 16:54:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 16:54:11 +0000
Date:   Tue, 15 Aug 2023 13:54:08 -0300
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
        zhenzhong.duan@intel.com
Subject: Re: [PATCH v7 0/4] iommufd: Add iommu hardware info reporting
Message-ID: <ZNutsDqWC5iQXttm@nvidia.com>
References: <20230811071501.4126-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811071501.4126-1-yi.l.liu@intel.com>
X-ClientProxiedBy: SJ0PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6765:EE_
X-MS-Office365-Filtering-Correlation-Id: 5315373c-1403-4965-ffbf-08db9db03fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MLuB1BqdcBE76gDnhGzrMU3zMpn8k6WI7tqB2ame5MT2RuEpYxkKy008uYeIjZ6U3a0FJe0PuMFvj+k4sb4sLK0fa2Jjpfti6JgYnC6PBreCT7iUbdqeU3bMUjdJ81Yfli9uIBzWtz+33G+jXPwkStGz19qoJoSqYDf8n9shy93vA0eKLqHK0lLbUm0xaMQ+eMVqyvYTCbZ1zcEQcexdk0W4gBWwq7gdjmZRsIsXz6WCAsthUHPuNo6XvrNgjBCTSkARm+bXJRFEntIpaLjG9yejotox4+2E7DZ8HeTv+FTMKowyFC5Jxrx0oulax/l6utGMN0VRCZfuqxMi/EF0TvtbRKYHKHgWE3j+AGbmbK2WzdEv/5OdY69BsbgH4Z+MDTmV60BmcBF/n16siCvUB2AOMxbz/Obih2vZpELUBNp2h7t0+n2fJgBjc00jZu9JyVITSJ4I9unsUtH3BtbcNhD4O84CA9O5AbuNYgK7rVgCWXDTO7JOxxhJlTs8o8W4U7HXLmr8HpBf25kJy8PeZvHQH6ifLw/itB5FwpgyikcN+QugeJIiZwLPQ050za3dsJZEzuxE4f2zmVVixa3Xo4aQtsp08W74nr89HAso9jE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199024)(1800799009)(186009)(5660300002)(8936002)(38100700002)(2906002)(6506007)(66476007)(66556008)(6512007)(36756003)(7416002)(2616005)(8676002)(6666004)(86362001)(26005)(41300700001)(478600001)(66946007)(6486002)(4326008)(316002)(966005)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ktjLd5HfTlc77WksDVDMxBmdQWK0ubC3EdG9VNcSzZDwznEFTOLU3WMrPVAL?=
 =?us-ascii?Q?rVeWv+/WIBSI2S40pwtZIpMFYoMpcTw3D/iTEJApYHEiRfGWbEcS53tAXZDA?=
 =?us-ascii?Q?oCmIboP9s2H3UX6unfyD1KtXXsVaG7n2jOcJbhrJvlr1zQ1Nf/d92/KH8+Gx?=
 =?us-ascii?Q?mM6gnlHsqPy0k1bea0Y5EzTTRL1huykf7DD7fcQaE/qpf1ePuJJbleXoBjFq?=
 =?us-ascii?Q?P3H/UQhAre6BaSTAa+X9LJJ34X82f0FDV6tqSmicvHjJvjOi3OrUanvUZ3Pl?=
 =?us-ascii?Q?ptY1ROTcPF9DcRjJLMtnRBNdm8QwD+O4Z5lnVsHc0xAJh/gknvb8vI4pfowM?=
 =?us-ascii?Q?OYxG71/6QicvI2UgKdu0FUX8tDwFZVo10kaGNiaTBxRlbxQ9KfNVCidgim/p?=
 =?us-ascii?Q?Q3uCtQSyRLzkpSFLFu60LuzUrGwiciNGV6j/XGYdMMIKb9ieMiUAjOp9V1xm?=
 =?us-ascii?Q?vxXeee2Z/FeFyDamJT3BwcnVGfmEihXkLgJHAevUE9mMvsv6LfYBfC+CsHQQ?=
 =?us-ascii?Q?WhI+BdGdL10oAZmH8oX/lTKtqPjliY3LyyAn1PA+/KzvgGjpRvFQ5Bcc73Ay?=
 =?us-ascii?Q?XddhHEqlqFcMogxfj0Dburcge9RsrBLclKFBUtuZ4GrENOG8K5oL53t1fhsP?=
 =?us-ascii?Q?SBwIBwV3C/yC1gjZQbpvNzGjhuVhNUsgThZSxBGw8YklJUemjrUlxvGlNswW?=
 =?us-ascii?Q?sLqAWrpr33QJ3faUHrt8LxbT1od3djt3MIjvOJVeEV3fbz0kXSLD25Gkg3R6?=
 =?us-ascii?Q?EcBAsgtbFEbocLe6nL9szcQIN7NZNKiDO0V5rGnalS3tHojsiSg7v8iqYkDZ?=
 =?us-ascii?Q?eB+p+ReKibFq2OAB3pJqlua9tJP4rwRurNsKvDfKpIc9u3FicKtJVKmbR57j?=
 =?us-ascii?Q?aNBf8Rpe/T8K7LjFO99JSbn2/Yy7CdzwIvRtghIhuaKM/5WPsZh9sWXjnTPd?=
 =?us-ascii?Q?yQ7Xa8HPnIU30Sb5Gp/sWAK/WOsEElRuj1wmaEslMxiqaGu6wBU5a2NGTGns?=
 =?us-ascii?Q?KLqVJnZ9BTS2+dns2sqJbEOgaBh98c6Z3pxdwn5FWo8Q/DcAYwda+Aake37F?=
 =?us-ascii?Q?zbCYoSOZFwQDmttoUJDWWhAuz5It15jdrdO7qdsZlmap2G3Eo8JSIFCsvYsh?=
 =?us-ascii?Q?7e8ZFdy2piQ4JXkJb0Jx0xB+NfrDa39hZ1kryy2Dn8VuapDVXB0aKFYE65Po?=
 =?us-ascii?Q?hlHVLjgF+HEXgY4kkEOBJIsYJuQ+OnzpBnKrLAK/cWSsmGPzzDHpIFUTeuNg?=
 =?us-ascii?Q?9MqEP0HUC+9oAmd8BoJ+hDuOPRW48X4d+2b41NaUexRV1NbOEmH9kD1PEix8?=
 =?us-ascii?Q?2CpubTPvBxcy2Vi5+QSKf2t+Bg3An3Bxw0td01pfmnYrF1JhQ2L4/gGZ2Ren?=
 =?us-ascii?Q?DUEOTUgMSCQBmhVAxqNgi67k7hPBmlZSeJeVPVKD5EMI6x62pEFX+QFbfANR?=
 =?us-ascii?Q?PKlA2sEQ4rIZRqJyNZi5LTf+P9S4SjQawni8B0lr/coN/UTKqRm8KBFsgoze?=
 =?us-ascii?Q?lEtBEGJMkGZLvXJXAl1JLG+fGLa84ZSmJmPpoqQ0pJoeYLAOIiLXtcdg3zph?=
 =?us-ascii?Q?ctrji64UN2S6vdc7gFwRFFyhg5kcLZ8rY5nxQqr/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5315373c-1403-4965-ffbf-08db9db03fda
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 16:54:11.6887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ib5fyVT2bo5QIB8fj1Qx/8Yqm6YigYU4dcjd+L+ZdxGu1Wb4ZSqWFOlu79KMtzTB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6765
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 11, 2023 at 12:14:57AM -0700, Yi Liu wrote:
> iommufd gives userspace the capability to manipulate iommu subsytem.
> e.g. DMA map/unmap etc. In the near future, it will support iommu nested
> translation. Different platform vendors have different implementation for
> the nested translation. For example, Intel VT-d supports using guest I/O
> page table as the stage-1 translation table. This requires guest I/O page
> table be compatible with hardware IOMMU. So before set up nested translation,
> userspace needs to know the hardware iommu information to understand the
> nested translation requirements.
> 
> This series reports the iommu hardware information for a given device
> which has been bound to iommufd. It is preparation work for userspace to
> allocate hwpt for given device. Like the nested translation support[1].
> 
> This series introduces an iommu op to report the iommu hardware info,
> and an ioctl IOMMU_GET_HW_INFO is added to report such hardware info to
> user. enum iommu_hw_info_type is defined to differentiate the iommu hardware
> info reported to user hence user can decode them. This series only adds the
> framework for iommu hw info reporting, the complete reporting path needs vendor
> specific definition and driver support. The full code is available in [1]
> as well.
> 
> [1] https://github.com/yiliu1765/iommufd/tree/wip/iommufd_nesting_08112023-yi
> (only the hw_info report path is the latest, other parts is wip)

I made the changes I noted and pull these plus the single vt-d patch
into iommufd for-next

Let me know if it is not OK and we can back it out

Thanks,
Jason
