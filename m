Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C99C73E029
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 15:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjFZNFt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 09:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjFZNFs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 09:05:48 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F743E58;
        Mon, 26 Jun 2023 06:05:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SittrBTfLLNT/F53hdPWZxUDxCiorb5JlIR5GzUHGgfUkChua06R6M/o6+ZBuZL+aDOsJqZdofi/BnHasiYmuFV4/4H/1XcpC4uW65G9pIS0BFOhumgZCJskOAw5fPi0uNW253Co9IGiOW95hfCA4PW00NO4lI+TgUW6Yu882qB0FoI3ji4sel3ZHj7ddqZeGJR0T9zO7n6VrV9UQ8C/py+lrLy/wWaajWcJYm/uv7BhfULaEFxZZ1kkDpl4p9gGKJq9mW/oMD6iGAIThctRurDAIjjnHFhZ0KBeg8AnqHCvB3bciwFXTvZGTz18mKbrWX0qcDdNsylLc1SVucQXdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ee1VDoC8dTrpC5YlNqJVv13hU7iKH4ZYL2NoelFTOCQ=;
 b=NmSSNx/iTiUTW6DdrC9CNR6zodVgiH1tY6msSdStHknAzFMQMKUcv+X6elsFlhp6eXo7Yv3cRD55F1FV6OwV66+nqOfOIjKMiThICmOJB8xNBWRvyB/kg+yKPtzKO2uJ+2U/9tqn406A2Jdfa2MXwW0M4vEjOnZrZFVTVrR5vtKIuxq8WzuHFid3NzaxigBIcayM/qSlAMGDUFRoQJQozth38iM0b8NQ+TvtHSTheNS7rU85t/SpdJIVLG9inT82ZGIiy03lVkdFP8DB5Y7WR1AjvTBkwZpCb8DkXxiTo1EoTZY13im8kdZnERYQxN6A52woufjn4PO/CI/ROXOvCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ee1VDoC8dTrpC5YlNqJVv13hU7iKH4ZYL2NoelFTOCQ=;
 b=FI0/LD/e5ppHgdZGBC3aV5ZtYElGVFycvTEV8fPcCSZldTLkAi9rvMDTjcHD4dslOg+xb/DyXzeoZj4zQ7PL6XmelejP1ag7nDOu+kyvllYbMVTxabQiRsquB4dDdU9tDLFdZXR75CWfb4ZOm5bXNuNttqsKpaXdtojdDGbonF4woBUxFDH6cUQ3SZ4YGLS7pHqwjUDMAbDjCNVUfOaeFZD1LMwhcW5cInVTsO1TKBkYSrjKR4XWi12qo97/HTh/84Sg1DPpzqfOy3UrV22gFGSKMYpcIfK4umZMs2DpmYv/FZlZLVFIcKTLbPF/OT/lhVU0P5XOqEImYFWwV8F7GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6788.namprd12.prod.outlook.com (2603:10b6:510:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 13:05:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 13:05:41 +0000
Date:   Mon, 26 Jun 2023 10:05:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
Subject: Re: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Message-ID: <ZJmNI9aUEdON+nta@nvidia.com>
References: <ZGdiS2m8jcd5OOt5@nvidia.com>
 <BN9PR11MB5276A74B2DA86C79908A420B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZH9AGWf1yRDu/86q@nvidia.com>
 <BN9PR11MB52763C7B838B04D3200322FD8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJBL8QLLBiwRsUSI@nvidia.com>
 <BN9PR11MB527663567ECB8AD52D3170818C5CA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJGf3sgLKr9HLZuE@nvidia.com>
 <BN9PR11MB5276B852A32F53BE8EAA1A7D8C5DA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJMvtMe5QHPM0OEJ@Asurada-Nvidia>
 <BN9PR11MB5276D6040E41595B929843168C26A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276D6040E41595B929843168C26A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0386.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be61d77-ae26-4a2e-bf3b-08db76460b20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bILG/n2pBf13wo3ygMlYK9AHqGrvLCgEpjkgFORPT6SS7IIBh4cbltIrDvLxjizdT+/MC0bWGMxKica02+B026JJpXllhORgPmcXOssvi++DC+i6dIWXMkivhz83h1HolytfxGfUxa/4JyGgJCpSaVuHkhiCqJrkjff4LV7KFrtf2tyXgfHy/2npQyClmyuvMervyXmck3RNW4TrLjqnB7z/Nmo5O4hi7NRkqcJnNOx7NwA2ibap9oyeME4vXp/v2Q0d5iKf/APRTNY9eaKPKiZVey6LkWujLZBbcmg6FXAbIt2jQpa5q+xC1rbeRj7A46V0srPW0bikUq6zex5eQEiWC5sCxkqCFFBVJBFxNuryeZgkviH9yaAgkde8fwLaLuOVN66MJzaBq7P7+6hdgfq67WYi5ezqZ4xYIvbpYwrfMrQKBQ2A9zUfalo6C2FOseqvPtcsc8aYxef7UxGxott6E2Wm3eRnS1hOtNBmKVB/DjdVHJ++tO4hYK5SUUxGaCyh4ICkbmFOh3Akr/lL7eNbZ3nnHOvteZGWtpj6jnOCduvg8Q/xNbI3m3KRlCs3aVEBXY6VJPVro3TTmxnmjhXiqSzdh3u87QmajPejpNM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199021)(6486002)(478600001)(54906003)(2906002)(6512007)(26005)(186003)(6506007)(66476007)(66556008)(66946007)(7416002)(316002)(8676002)(41300700001)(5660300002)(8936002)(38100700002)(36756003)(558084003)(6916009)(4326008)(86362001)(2616005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4SABRLTfSggVaPqQPn/SiRWtmniPLGHw+Zv5hI04haiuWGkLJ+8mKaTdGvyt?=
 =?us-ascii?Q?wwy53xHNMAST8khCoZiJ56c3V/BORwjtSIfZAES8o7zonGRqR4XeotJnQcDn?=
 =?us-ascii?Q?ebbh2Ab9KjBS19iKiouhfLoI0R0fouXXHuEUpvLuT1SQ0PBnMObNEFTns0so?=
 =?us-ascii?Q?huSj7s5CFits35+85074a0oAQpbzAcqZwHDpmWXp0o67/xib1XJNBFJa9P/W?=
 =?us-ascii?Q?O15u/rkdiA4UxN6EGc5WOtqAfTwniLCeH95weg++U1JMCavR3lOcY4UEy63g?=
 =?us-ascii?Q?vkv6H2AT/YIpK0qpi75UnFewuJwebCZ8TMWqLF5RWMYJ2GetABAT6tNFiuLk?=
 =?us-ascii?Q?KhwGbkYvYOyknLYJpDk4RM15Hg8bTY23sgCgqfUbx3sXq7xrOBl+7fbZpMIp?=
 =?us-ascii?Q?VJ3KLl3mpbcS6ZzvJL2JAtXTYMLzVATPHUjyZmWpmxHhukMVbDm60oMzYNA4?=
 =?us-ascii?Q?XPW0a6w4yyafo0Ik3Dhgs2dZApu0wAEKS/2xfjp3pUzcYsqywKnzOoDV+Xab?=
 =?us-ascii?Q?WgXGg9MEDf5Pq91DXIPCrUduHKUuaqjmDWxJnqaDAWyrVhJMhwNDzBSsaUqv?=
 =?us-ascii?Q?hlacx3pijvShUN8rFj6PG8uInpryFc8n9hMKZxm9aumMSwjmsTzxYM4FwZDu?=
 =?us-ascii?Q?ioZbxpdsA3OdS+os759Kpl3YC3Xm6P31HOyIeHNsJBZnRJ5pWY2VN6azI+j8?=
 =?us-ascii?Q?+1nfdDvS8HAafipcpeHmsouigBf3mQ0Kb59FRPGX6YJffMHyLoP1Tu9P9O3D?=
 =?us-ascii?Q?gPuyLfaDX5VNmaBl3Z53OrrIh40NX/k0bJYtf0SuFVgcp+J68czJAkN4hE2V?=
 =?us-ascii?Q?5pJyhQfXZ+NY1sowDte2YBCXb32mTfeFEiTVgDo3cpxbfPFLrRmzSUgP6quU?=
 =?us-ascii?Q?YhP0tGYv4K5LqwF0KcFiAO0kULxHlqAmcNKXY/cvgy01LRKtPwIjqVAbgMBC?=
 =?us-ascii?Q?vEgbqwtwxflKsetwBRGDIr+m4owBeFCWlpz6+x7wiVjHdssERQaO6rTx4QNP?=
 =?us-ascii?Q?YG8sMbGMZVjVxPx0qtIRlYejHnn5zejCb/1kPeF51QgVD0pWP4mTurGKbdVC?=
 =?us-ascii?Q?Wn+P3xsvRM8xdaP+ZWCCzE6ONwMFiCtJD7g64dv5M+OHsSSxxq2I+8p9ZbeG?=
 =?us-ascii?Q?0Jge6JhliG82utDz8mmmtuFswHoxQy7lcPkVvCo+AYyp5jRCNMZERoFupgzm?=
 =?us-ascii?Q?mwHwbCzoWK2BenOzbcO0Hd1HL2+LO2UeQb0yRE1zutwqqWVXB8FGAe/Kfn3h?=
 =?us-ascii?Q?ee+R/6mn+znGFwExP1nbH5EeEgzhXZ36KogKaLbKw+RetRybljQwCf034tbi?=
 =?us-ascii?Q?HNAiCyId2kbf+MbfA94EE5CI8bNzE+yDTzZ83K145CHHj2W4FUdcampcrPGk?=
 =?us-ascii?Q?7aKKS2OW5kzXqb4io5xT8/L/kwm1bZOUgAJz/LEoaQnD7iq4wZml/JPOUEgu?=
 =?us-ascii?Q?QSARCMFAQ5bIWqHpGvgIVE/UJgvCkiT8dwHznCOkrdNxqi8/57Kqu5Lr1fe8?=
 =?us-ascii?Q?lMxzthqFs+1/nZyJpcZ0ev1OpPZoh7Wbaqq4zMx12WoK2mYbvioa+IPM93CG?=
 =?us-ascii?Q?jeej205v+AAFJqmykYa31jDEOk9k0gdc/1O94eFA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be61d77-ae26-4a2e-bf3b-08db76460b20
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 13:05:41.2136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbDlaJK5KI0/YRsWBPDI9lJBItrQ5dmNK7pUCzB9h0F4iNBfBgYh787W2fvQocL6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6788
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 26, 2023 at 06:42:58AM +0000, Tian, Kevin wrote:

> I'm not sure whether the MSI region needs a special MSI type or
> just a general RESV_DIRECT type for 1:1 mapping, though.

It probably always needs a special type :(

Jason

