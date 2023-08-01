Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C7C76BC43
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 20:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjHASXl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 14:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjHASXl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 14:23:41 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B3E26A1;
        Tue,  1 Aug 2023 11:23:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kc6hBIgyrPVdN4A5aFXzLsKBykKpId9nece3rvu8zU54s05YSX0ZNKVimpeOHqX++ES53utEL+UzzR8qMS3R6r7t1vjxrSpBPZ5DdQc9ab4RD8BC0mCk2NuAdQCR2q7WF+4SzL/3WJIieNzWg2JbIAtrpFlMJy9vXHgxLG1cbmfoO2ameEUQ0z/KTND1FKmFt12oRBQAztTgLE4LlktPl5VsIucPK8N8qnqZq5lg5Ugcy0KQOPmeKOEvdFbP6w3wZRx8Sl9Fplntvk8njyM4UAHtttJfT5lzt+GBD0bhR7e77drCd/e6Jr+cjgN/7Dmq4dAMudhwfSBLhf76mud1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oL5AF7W1D4dCSBoNCZXHk/qbZCzTbwvo9gQC88C8+mY=;
 b=EmXQx/xD5TDCdD7af9I0yVicBljhQhLb8mzSnVooePgT59QbFcEngU/OAIR7HWg378QA4Q83+1eCvrT+5tvVDwQKaXHxvsOHllIhd/W12kGJW/LlxHufcTcjG/LhcU9J8U2GTKRWwmxRhJLcKbuJhFwVBjTHz5lKjPHEF1EEBHYj7rHyJhm5r+cbAWuPZEzwKvFv1T6a+7k3PxaMhxp8mWzwD/siQhDK7HTsuiQM4dw+lIlmEud1zjQ3ceZTkOcD0kMfPajrhJ2Pd5Rv0/TLqtFaahsIuG3G6BnRmIPp2HoGcKOoAuy8WDxD/lLh3BXjMD38ZL5Y1R33pmtDFzcdHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oL5AF7W1D4dCSBoNCZXHk/qbZCzTbwvo9gQC88C8+mY=;
 b=Pdw6uEPkquvzmFq954YHmb1wbGU8Tb6FC6zlwnXqvssDRdtfzY5J9vdel7m8TwKijn/kRE1/EMA/uFZ9dE17Yo5anPiFwPE+mHZd4DLHy5w7QZHKsJO4lfaoFs0kSa9NSN2ewGrbCArmq4KTLdOwXkD4BQlUZWq7AabvT7TaFUuSNdrZ7d1n3t53wDDHVzGyPj9xwHJB7Dpo2c4CcHf1n9pI41Gtc05hb5RiqCZzzPoUig11EUyEfTMGmwi34ne2+BXsWqho7jfPcJtwrrbf0vbFKi9Y92sYKl1gQLnUs8SF0vas8ArFuu0fZKtEUzrCuhYXa1I8pYCU88XooQfMhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7332.namprd12.prod.outlook.com (2603:10b6:510:20f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.41; Tue, 1 Aug
 2023 18:22:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 18:22:43 +0000
Date:   Tue, 1 Aug 2023 15:22:41 -0300
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
Subject: Re: [PATCH v3 07/17] iommufd: Add IOMMU_RESV_IOVA_RANGES
Message-ID: <ZMlNcRgMYatv/YqO@nvidia.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-8-yi.l.liu@intel.com>
 <ZMP+lvbhAwEbhjx/@nvidia.com>
 <BN9PR11MB52764E058BDC007FCF2F240B8C05A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMe14r37YkdOKulU@nvidia.com>
 <BL1PR11MB52710D1257B38E4627BC61118C0AA@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB52710D1257B38E4627BC61118C0AA@BL1PR11MB5271.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0417.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c5c1d15-6229-487c-2dc6-08db92bc4c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 73A2ZAeDzJ8lBZ5W1vDWhx0dAYeNQtEL6yX7amqH4BTOHitrETHEFESAXW3vdqUNAv/CAQA3fQ7TzMvIT4GeFrts8AQ+RQXOlYzMz6QqNHpLXtaeVeGhEums9AVAXybAVuE7cvvr6g3bONjdaKzSDHkzMtcQZMERsZonmRLsb4Q2vP+z+7kSjnGMFOaIoT8rGh1W8LXj72WsC6gURjlOudJ6+Aevj8xIjZX9q5rEYvVMst0r9q8Wr1ZfRbY2NI9i9CjzSKKu/7bswypajThNciumuKa83VsinOaH3qd2kLOUimhKISxd9Sr5xnVWfQzu+Yw1qChO95oW4r3ko8tEKO+yK/1Tl6Sjd5eY/N6o3Cz7UhVTOugCh7CaQRNZlo5MyumCKRRTrbVUQE690UDUJYhi1BzhWGnhiBWfWhNfNv4cObLyWFcFFiEttiecrdl6FDignfe0gqkRJLe9a1spFXvQdIlez/FNTZpJO/kaiAF7eNoG8TuFOAgRwR5SQ0r1SCNuhEPe4b8UyiiNQRhtiX93QjaMATi1KQlu1SbwbkMxZ11oSVWaKtRm+wyFBTvr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(316002)(2906002)(8936002)(8676002)(7416002)(6916009)(66476007)(41300700001)(4744005)(4326008)(5660300002)(66556008)(66946007)(36756003)(2616005)(26005)(186003)(38100700002)(478600001)(6512007)(6506007)(6486002)(86362001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MFmwk2sLxCfnjkVN31O1SrQA5VQbDfGLLyiZQ9U6HKzZUN3FH/JRPwvPrfxk?=
 =?us-ascii?Q?THrtJqhRdd8AAV7KVxzgKmjlw968vT26cCEqhJFFVnTFluMBA2fgiv7MOHH3?=
 =?us-ascii?Q?pFyw9dTGr5CyODY4bWhfwin+2h7ckxrub28aaFIfVkHlsjWUCXkKt5x8B85r?=
 =?us-ascii?Q?HA7cgFGakUZLwv1AOnN81CJCsX+XLe5zL+UnA78PqNFemzuTjVLMQnWI9Ps4?=
 =?us-ascii?Q?8EV4ZpwtP0F8axCBqSFXt9UpdqHjj0wtqHrYVQIEScQtfY3gAWapvwbGyJWq?=
 =?us-ascii?Q?8tHa/H0/ftNFxGYlw0PgJk9ONFsPlXt8DVwi02BepXgQ0yDASGw2Pcla7/tC?=
 =?us-ascii?Q?5dOm20PHr2+l0Sqiy8JHeVNZKKdsEZjl0qtmjjGJ4cDgxr4ShoMQBXY4pkoR?=
 =?us-ascii?Q?6g2Y1X0Gz/LSTFoL8qGbfAUR4+Od2d9GHpy8Pq1MwAcah2oFzn97j58Stmhb?=
 =?us-ascii?Q?zeLMrkG6FuIhC3yi/sIWULROdV0VNV3sb1KfM49Ut1JkbYWKCU1l2TucXrQs?=
 =?us-ascii?Q?gnYblLgKAxF/vwXEPlgWUF7r66KR2XoSEwVAFEC8ik3f9545weMh4SdTA2rU?=
 =?us-ascii?Q?0+BIBT9SfANt4b5nQIlx+0Z9xGQ/TH5qkz3MStq636LlB8alyItPQYtgt3Jk?=
 =?us-ascii?Q?imF4zjpfUYUkiuArw+6T0kY9EycPtaqqTTWfJxLe5cJQshNH+cb4laq6WOze?=
 =?us-ascii?Q?1C7CB7AiyFdRQldzjBrKPTIt7Chit00qFLiRZJQBwsC9XQHiJFTI4/Tk3GYw?=
 =?us-ascii?Q?ZAME7qL2YsF+nUb3/TPoiNDjQx9CQIftufkBgQZUkyWdXIgSkuvZo9nd9hkG?=
 =?us-ascii?Q?cVbrZpkZhPoYjNO2HwvraZPbf705/uAEqjCQHUdBKURMHytVQZN2O25ByVHl?=
 =?us-ascii?Q?b6AyXahXB3qrqOFhMKPPyx0GP01VGbvOB58jwJ90Aa5ITH0NqJBcJ5a/7gDm?=
 =?us-ascii?Q?CVVnwcnoK+Cewb90fIsStwVPrSEaTMyUdfAPBgmNJu4sqzQfVNkCfCDa6W2n?=
 =?us-ascii?Q?JdefIH9OFzz1c/uwbePmpoIT3I+rZhPTP7eFCS/hxFkJcs0BEqjuE2aVPNaM?=
 =?us-ascii?Q?21TADgxVReGsEbRWa0g/hs20QgpxX9TysSBah7BxAZiUknLB4Pz/+odPT7iu?=
 =?us-ascii?Q?wxU2OOa/FfkJFvodvFSB0CcXQv7VX/nCW5R9yqS9WMq+pENfzmSpYVkjZvc/?=
 =?us-ascii?Q?0SL4EdqcoQmSBpno2Ox4bqpEAiQKb80ys+VQJ42e+x7w7V/BLiqkYmtSMFLg?=
 =?us-ascii?Q?g+cpiTTRgmCLomPK2yvwiaatIzGqf5NwAW3yTPmtH1hbtIwlVztc7l+7FiH/?=
 =?us-ascii?Q?owTZyLJaMCx6Y/7+iJ/hZa2S+bGfohigB25PDxCWypa/NjWixqSi9ls6sqJW?=
 =?us-ascii?Q?5tw5ESp8/uvc8/aeAC2ak+66sHXK6vvhWEcGtLXLardvn0QKFThLG0s9Kvx8?=
 =?us-ascii?Q?Q6M6jxzhfwFYhZ2V4h+mfZC3YGg8j4ZcLvWy0/le5yRVd6dXvKgoM9sjLan/?=
 =?us-ascii?Q?7CIacqC4wMql3xpVihZgBYdMFJYhhgg8YxTQiPqbjMWW58oOryLOwmcrHb8a?=
 =?us-ascii?Q?QKSBLzSnp9emMOOmBzHdxvCrSOmdEybICggk+4Pq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5c1d15-6229-487c-2dc6-08db92bc4c15
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 18:22:43.4429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWDSKiU5ygZQ9qSNqrc6rR1Wm6nhZR/mcv6upDmtjdbkGKzPIcbwI192NOV32wxq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7332
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 01, 2023 at 02:40:44AM +0000, Tian, Kevin wrote:

> > So, I guess we should leave it like this?
> > 
> 
> Yes. Along with this discussion (including what you explained for sw_msi)
> let's abandon this new cmd and leave it as today.

You sure? This makes it basically impossible to write a "correct" vmm
that is aware of what the physical memory map must be early on

Jason

