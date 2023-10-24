Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BF97D5A08
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 20:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343610AbjJXSA6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 14:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjJXSA4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 14:00:56 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132BD10D1;
        Tue, 24 Oct 2023 11:00:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ne7CtE8CpNbTwXoetYNNoN0dQSGaVZKGUwsQ/pK4iSWlKF4gHtMDT+yFygt8cis4WBSZNZbB26ynV+IbmfRk+z1VnYHNsmS45cYZ0e/uLbDbZBRKkvODYyvjj7tGTx+Z6BoXnzZ+SCTqHKntGJdBlEO7R/crlNhpTJOu8YzLKXnkynfg1tx9nYJUjp9PimW6R5AMDFoJF7mfx14d8wRIrxF/e5HQipS8HwNbjzzDvLZW+oFd8vqiKFdtbsrL/BrL3i0WPZqyQ4RFTnsh99tP0glZSF6CMXIKMOx6NMIvlnKaDmqlqA6vYeTzgWdYUAmtKiC/1OavSoqDYNVqm4BKFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h81IwE47UPsu103y+Rz/TUfndpGhgKskObSAw4VXh2Q=;
 b=bIGeFBK0YDxyfyvTjZhQIgDqQtP36D239YF7V/cAj4gYfmnI/FemnE1ysvRjwwuMmKky4Qdst7PjSnM0oAe0wieGjx7CtCoQAPlD88DMFf69JKjBrUHoticpBOyvJW182/9lBhYEL8s+TVdqfoPEGjrf3rBJFHHeDBtOVQ41+StHOATJp52TUWdcjoSX07Saoczs4mN4FKB752WjBc1ZcBxTm6XX4gOpEyBApQIeV2dh8tFJAkTZ/XLSIIPI880annGRMDOMVX4PBwTvkBp3q/tC410TcHzbcoH39b3b3MsZPajadZuIDnEyXTQvZv2l+E4S57yg9xcadaR0illLLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h81IwE47UPsu103y+Rz/TUfndpGhgKskObSAw4VXh2Q=;
 b=WF0uGx9T1Ad8MSMjjgHRA0s7JnG+ZnzebbRDu2IG5b1hp01nvSFROwzetKeaWHFxHbvlS5y4c9CTqdsdxicLrDPOqd6yRsAGOcI9cjdof3XzXgscZWmdHDbvxz+MLt7sUIynCBKjudybQkdP2Q2efWHTvsbSkWbxrd/gnHGma48bJ6bLTFehDG4RZgDes5gya1Fc8IlG09ukjy0YWLMOtLaFiwzHR0o+3T3XsVm7c8xKwsv45AqK3La0Bkxcj20e5dCj5gKt7+PZi9Wt0wuHadCKCDp2epk8VLfCwieuIIwXT9UG7B1g5Mu9eyKP+c+Jlww2jzSh85vWAkdDSbicoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6183.namprd12.prod.outlook.com (2603:10b6:8:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 18:00:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 24 Oct 2023
 18:00:50 +0000
Date:   Tue, 24 Oct 2023 15:00:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v6 07/10] iommufd: Add a nested HW pagetable object
Message-ID: <20231024180049.GV3952@nvidia.com>
References: <20231024150609.46884-1-yi.l.liu@intel.com>
 <20231024150609.46884-8-yi.l.liu@intel.com>
 <20231024171810.GO3952@nvidia.com>
 <ZTf+zWJE2qlgkf1M@Asurada-Nvidia>
 <20231024173139.GR3952@nvidia.com>
 <ZTgEApUgriFj1dKa@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTgEApUgriFj1dKa@Asurada-Nvidia>
X-ClientProxiedBy: DS7PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: ff170bbe-b645-4790-f434-08dbd4bb287d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C/W3ofa6Y7x+Nj5DdsrTYV+7lyuHP7Os8O8GhGCrMqCvAtgAuP3lazaQml5NC/4H18BNU0oAZ5TYiqkTjtFpgFebdZ8jwaobT/kwz3VKWnr+x+zIB4UAoIsxhapoNzQTQTAGmA6WjjWhxxVQwGSxcsvqMaLlX0koEK9I1gfEzbSoQwVNSEYa7BIUKtc6H0OcQ/nyJmZznnbjcf5l2DMOv6W2ehaDAhru0b8B2N9HVWMukBDasqlUnULzGzp/fOK4gCQmX0SpSbG+ITedRU9o/lwvb0/f1jT+QLfCrPltDWQbejSL3DqsA0uJmVDbKkNW1geQ/G01ukQtrmkrpdBLfxPCP81/gvxhD8U81ZkdNT+R+K0jOTCHQMPHOpy7eo3nMmgDpg8iLJCLTXbOwYTWeWCxOR1f4P0LkkW8qUtIcnFxmRxPmy2uRNpGuQEwvLXHUKSHErsAvkMqEkQ1ki9glgNfu73TsOKYD1of36cOB+0wp2vJrbGZnJRP8MT/zxAyztCCNKONqaZj1KCbkeB4b7tP9Y0mj1w8lB1YwBJtANqlEM7PPIULna+5a+svmPSg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(39860400002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(83380400001)(8676002)(1076003)(6862004)(4326008)(6506007)(5660300002)(26005)(2616005)(41300700001)(8936002)(6512007)(66899024)(316002)(66556008)(37006003)(66476007)(6636002)(66946007)(38100700002)(2906002)(478600001)(36756003)(33656002)(86362001)(6486002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UaK520VtGfTQ8gU39+F0qInySY2TdLajjjCyI1t29WVv7Ux91+CEGKL/O1jf?=
 =?us-ascii?Q?3EtYk+8tnaoH5LEci4Nq4GK6tSAIwPOsHPiHiJQ4IKIDPPM1QtIXYXK0bO6J?=
 =?us-ascii?Q?LffkopjKF3k7dolKgVpE6OYoTIv2jDZAljf7UbMjoH/wVDTClqFf7OXSVeTZ?=
 =?us-ascii?Q?Jw4MlrwcMtBRNvBqa/FWa8JDEMWSIYshoShGZtRteyPbqZLr6qKCmPEcEvpY?=
 =?us-ascii?Q?NE1kJOqD681AKaVau608u17q2UPif3B/LEpd5gpUdyZ6l2SRdvUeyD4Un//D?=
 =?us-ascii?Q?BmvlanuQQfVUFSTbS5RvYwLqqfhDr1hHR+a001uSiWzJWa/yjHiRj0amkKjQ?=
 =?us-ascii?Q?QAL0fRU6v2MMtv3ijAiVGoK0VD0b0eKq7nprYOxn7oayIhgrgqLluEPsWJ0w?=
 =?us-ascii?Q?KnDyR2MVt+GCe9ESmvltRhZUb4tjED460fMvSusRhgb88HPI59XvL4VKElUM?=
 =?us-ascii?Q?Yy6GnLS5hDrCZWl2406bKbXCMVlSZd8f+koley2lS0VeDoGtlVcyLfid3rqn?=
 =?us-ascii?Q?2Kzw9PgEcpMk7S6uTJmRBjGX9UGblQdREv6Dr+i0ot0wbvo5gQ5XNJ7y/68I?=
 =?us-ascii?Q?uWSS/UzzV+Kc6SKBhT5IcrnX718UWgI856UHm7Sl+lY9daxSwI1SCCqX5kq2?=
 =?us-ascii?Q?qvCmUI3lBvoWd6WT2kZ6VfAzIcsCdD/mkI6BEQd0gIHGNgdvRN2kmXEL5nfw?=
 =?us-ascii?Q?3SN9E/pqW9Pcb7WxMmY80wktwlp6+tUt04i3EnZFzL0mM8ew89iNCz45EEps?=
 =?us-ascii?Q?1ocrbFN2/jjDJXcFMGB5FqehgId8U21WJA7qOCc+gihiYtl7GaKp9jSLNeUL?=
 =?us-ascii?Q?tLNFoHYGzGXIh/Cnkmi9VU3iMhhCguDT1zc11sI8C5KY0UUoxinHzOz+ptKG?=
 =?us-ascii?Q?iApnoU3K1TgcV287szkX1N87eGh3BVsFe24F2/LYxXlJawTM1DtLHF4hl9UX?=
 =?us-ascii?Q?sefuPwkTAyqP07W+HCn5Mlr7zBHH0UosjUSO0nCkvpN4VJ7SaUUIUVCkAluS?=
 =?us-ascii?Q?Dm+PgmV/BNQXQ9fj97YIsUKE423aeMBdnmzsgXD71tMQkfrfpimT/HgKjp+r?=
 =?us-ascii?Q?uB04weyvhKan0K2Tef0HHBPRqsHxL//IxNMxqzm2IN+OKnaoO/7yA68vU18G?=
 =?us-ascii?Q?Txaamc2xJy6p4T/DhRQFpzBh/gMqT0gnb+AvKvs1GlYj2GgQydLwYjL5qR/V?=
 =?us-ascii?Q?n0v0xm/Dzi/gG1EOKt2RLYCTV6kp5DBow/Yyb7XU3mM09zIngIXMGEwh8Y9z?=
 =?us-ascii?Q?xh8dbaa64HKbPjYrBuSjIMG0kTUa/phM+nDe4eWk2yH1EOvhAJzqudFgjCow?=
 =?us-ascii?Q?NhRL3jYUWMUq07n+rzhTd0dhHBo85EmKptIJ393Mv9jB6Ojh28E3thWYqErp?=
 =?us-ascii?Q?J1PL2HJ8qCOVuAmw7kyObZ9+5J2MrvVgwiAjTGEUBm0RLGTxSlxNB2O8gXgf?=
 =?us-ascii?Q?4q+czuEJDN0A2hfoYUfCBKMuxPvzfU4yDCuMh8HP3zQL6rENp/+6FRKPx8Zp?=
 =?us-ascii?Q?KccxxJPAOgDnHdu3oUYlBhDSBB9eK8+D5BQ1jM2YhRJTE6eaqCY+hFUp4WEy?=
 =?us-ascii?Q?skuSajiofQU038EHUM5OOZLq9BpfCQ2bSM17b66R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff170bbe-b645-4790-f434-08dbd4bb287d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 18:00:50.7613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9nmeeK1Q9bAaTeNyZvuXUiwXSPEXND3JBtb2aJb6NGUr6oztXGAUegJSAjco/tEK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6183
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 24, 2023 at 10:50:58AM -0700, Nicolin Chen wrote:

> > The point is for the user_data to always be available, the driver
> > needs to check it if it is passed.
> > 
> > This should all be plumbed to allow drivers to also customize their
> > paging domains too.
> 
> We don't have a use case of customizing the paging domains.
> And our selftest isn't covering this path. Nor the case is
> supported by the uAPI:

But this is the design, it is why everything is setup like this - we
didn't create a new op to allocate nesting domains, we made a flexible
user allocator.

> 458- * A kernel-managed HWPT will be created with the mappings from the given
> 459- * IOAS via the @pt_id. The @data_type for this allocation must be set to
> 460: * IOMMU_HWPT_DATA_NONE. The HWPT can be allocated as a parent HWPT for a
> 461- * nesting configuration by passing IOMMU_HWPT_ALLOC_NEST_PARENT via @flags.
> 462- *

Yes, that is the reality today. If someone comes to use the more
complete interface they need to fix that comment..

> Also, if we do passing in the data, we'd need to...
 
> 280-static struct iommu_domain *
> 281-mock_domain_alloc_user(struct device *dev, u32 flags,
> 282-		       struct iommu_domain *parent,
> 283:		       const struct iommu_user_data *user_data)
> 284-{
> 285-	struct mock_iommu_domain *mock_parent;
> 286-	struct iommu_hwpt_selftest user_cfg;
> 287-	int rc;
> 288-
> 289:	if (!user_data) {	/* must be mock_domain */
>
> ...change this to if (!parent)...

Yes, this logic is not ideal. The parent is the request for nesting,
not user_data. user_data is the generic creation parameters, which are
not supported outside nesting
 
Like this:

--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -286,14 +286,12 @@ mock_domain_alloc_user(struct device *dev, u32 flags,
        int rc;
 
        /* must be mock_domain */
-       if (!user_data) {
+       if (!parent) {
                struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
                bool has_dirty_flag = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
                bool no_dirty_ops = mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY;
 
-               if (parent)
-                       return ERR_PTR(-EINVAL);
-               if (has_dirty_flag && no_dirty_ops)
+               if (user_data || (has_dirty_flag && no_dirty_ops))
                        return ERR_PTR(-EOPNOTSUPP);
                return __mock_domain_alloc_paging(IOMMU_DOMAIN_UNMANAGED,
                                                  has_dirty_flag);

Thanks,
Jason
