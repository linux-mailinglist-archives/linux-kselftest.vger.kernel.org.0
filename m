Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B19702F16
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 16:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbjEOOBA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 10:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239368AbjEOOAz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 10:00:55 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF02D1BF0;
        Mon, 15 May 2023 07:00:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nR7Q0hNbAzURvdUP7i48+p5glMrotTsd1I2V+zeMBWWv1xex5g5Q/0spY7Tqbpmy3NkfYJv+OF7FxPZD4go8Rc8Jo78K9TtCf4TjRASiF8KJ7vENeJB7an7HnnO7qWiAPwmvx8PPhCZLrLeR1wnU+CwdCRvvAjeOGuWl3ARoZvO3aGjPptWe2HnU4kp9+wumc/W5953kCyXSBUuDxD1LC/F6VJhKcdRxsZYMthyDimbew9VMQixpGELSiQxnRdPgexGls2i8Zu2wcWrNXp+JK02gR7X1LSQ7nSTmA22nVFku3b3h9tn1ia4qgafFD4o4180K6uwHz3gBVHoXiErXgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tr9daLsL1aNCFr5AsxyhDDU/5nBie4tjazawW5BzZNQ=;
 b=OtQPWns6HEse4PlohYRzde5MrucC0r0oIgRn7dFUxuvRlj0c37ra9lrEm54OFMVqSt14FKHzTNEW4cnnKRJTDLoUrlLwiyPnnK81xQFEqrf/SrMbMSboTh9rBUpNN6UgJImKjVTgnF4MjvCdqJJ6n0J5U2XfoTFM3gRqOB83oKzOnALeaWRdJXIMesDFbzmMEkEU7W67316DhHQAMmRwFkBuByNsoyeVnhwkGGsRKBD09V4Ly5+wmeAR5m+UH3jV1Jxh32Uq5RVsZnzrOZ/Js3Ewq2B0+00rfv8kCDHymnQTsJLeYXDNuuHPEbdDux09D2P8xpg/sfioBhghEaQKKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tr9daLsL1aNCFr5AsxyhDDU/5nBie4tjazawW5BzZNQ=;
 b=jm8sYy9ioqGFbaBxR8wzn86MstBUW6hS8E4l2dvfnLx6q2jh1f1dKim11/P9+R4uyyS6HrFMXuOqoFHAF6JKTQJgvJFgIaCK8VBw4yexLD56fvlecW4+jkIvkLJyKIZUWPAvBgQXZpllA6Mh6kbRAoh3fmsgPDFfaRI6KRW1pcIJ8pnOFV/iL7xu1MPW9j08DO52eMYfwa0Bw3kk55Hnd7dtZYDff88sOaq6mpd2TH0vcp8nYziTEtzLHdOkxKOo2UU7Y6tQpbkg/5Ws8xtbEH/j3KBA1rYOv1RTZ2+ZuNfeLRgXwUFrvPVEWG57jt86Yu6N9voGyzP8FCaVZ/8t1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:00:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:00:45 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v7 11/19] iommufd: Fix locking around hwpt allocation
Date:   Mon, 15 May 2023 11:00:26 -0300
Message-Id: <11-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0034.namprd17.prod.outlook.com
 (2603:10b6:208:15e::47) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 656f6183-6516-47c6-77ad-08db554cc272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RhtQ1c6TP5Lql1rsaOilp8c20Ncp7cidhAFdGikYKlQHw2KbRxKv6QbCS++13+pO3ZjnRykWJJYfDlDW2o/QSEBqbktxCUkrf3jrg8eukSw4yevZ1qAwd7USYQDYeNNXHi5vSY3HJGyU5xR4e3c77Fkz0jrd1u+NpPEFSakwLl1/YS6HOCt2QaEA/ob5osuoKhHjfTBTQbBw4LNb3NAuj9SqdpQkrMNUvEziWkesrdEfnII+HJeCXe9HpKRZWDL0+aXYIOLSav5SJ5Lvj2cW1BKChzLhlANktMGwdHPaR9kdhDlsh7YnWLeevRSLqs33MiU94GxrLE4XSkkZIQBHs36L1CK91UzbISPsQpjVu9Of2Pc4+M9WwFYNJNSTbbIvQNY1d1WJaB0MjJVkeWG423aKKSNbS7HnXeoWEwoaVUG8WzHRzIzAll8Z4S06PL25j8gE7ffKQFyz8f3N8BYjRFTfLIBse597GMdOyMi4VHkv+Xb6xn0VJG0O41LhWt94LUMZXFtsptT/kY1an3HTz9SonuqOjdsZNPLj1i4geTcWrmVx3rRUx7LeechQ+XAF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(6486002)(26005)(6506007)(6512007)(478600001)(54906003)(6666004)(186003)(5660300002)(86362001)(8676002)(8936002)(36756003)(2906002)(316002)(4326008)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TDSVVMkI94etiTsKi6aSoCRnKVXcx2Wm3qecKbuB9ahb+G/Z1FwZiE5fnkNd?=
 =?us-ascii?Q?3FJAGvkiOAl+hpFX9JXBWjPEWGkVEI7I5svXrEQMJFlBSvwOaBUtlI6gc8aU?=
 =?us-ascii?Q?9XF0uH9UY/bfCQtK8avoPOsTS8GWEHMFDjWbjAeZG6xowgDiGD8dmY7B86Yt?=
 =?us-ascii?Q?U2IJyyg3W3F2fzUXH3SLPUuK4u+T67la584BNXAwxvETKvfyk9GbLwkCFJIq?=
 =?us-ascii?Q?VWQzSnZhqwoqDv9w5d9T2JXviHCdJbqvxO5nONyGxy7Ew+HjZcFDATZ+aVXo?=
 =?us-ascii?Q?WjSK10T1MgUu1vDApW4p899CjUIx79L+FtHAoLZTPdIcWrlMTNkE/BpoQz4L?=
 =?us-ascii?Q?RmuVg/XfxftQND7TqgV0G+8tlR6wP1G4Lru5oqNX6WkI0wmFdHLDiPx67hkQ?=
 =?us-ascii?Q?N7TZPogMRuDHpVyF6HxagfaLa3jqUefgFzqJYX0oa7ZKXE2fnSeGOSdQd/1x?=
 =?us-ascii?Q?SeZmrhKpISQ+ehO/lixFLF5si+jDOK0Cds4Pe6SF2hdaFWC1V0GSe0Z+IYRj?=
 =?us-ascii?Q?BAGmo17fOuNq/E840MaPqu39Q+Bbj8cvYFXfXhY+1JrfLKIuVrnB5in9un2v?=
 =?us-ascii?Q?NQ3gYepjAvzhpFtZsgqn+gIt7i5gz5V4YT73B50A+4pTa71St7/jDtfuj5wg?=
 =?us-ascii?Q?dmFJfdiUO2xV9TgKadI9+TRIyM6BcTZMB0v4+f40odu9ePdFkFGoEqcqnnpd?=
 =?us-ascii?Q?lausMvXv49leU8M1aGqnInzH3nKh6ceOqgbevnRaFP+MHFL9JjKDnBzsci4U?=
 =?us-ascii?Q?/6GZOT8q2ErvnJevM0iFzTbbKEswAXl1stNyZDhKp4SSEulhwghllQHQxIeG?=
 =?us-ascii?Q?R2uAuI4R6xDSUfmM8YrzpVjkVQnp9ZkggIVF4ZdoTKjXV+Y8a3536Tu43Rly?=
 =?us-ascii?Q?yq4HXWeRGlU9bl9qBN5JFRqD7tsMPDrRNhnLAXam4GFa8dp+JcY2T06VydCP?=
 =?us-ascii?Q?7jwvx3ry94UMiQ6CYLKvERLb0/WG8WeiQCUpULHSwtvjJedN3bL3iOKKymf/?=
 =?us-ascii?Q?rJV2Ur5hsjjzg2cZosAJFxEkAfkXx2RvP027GP/nf06yrtNY+LvbAXo7JlS9?=
 =?us-ascii?Q?BAq4Mz/dw6Mb3707biBDATRYG0BAJK+mHP9QXvqtruDuQ9vJMHP8J/68Jjsz?=
 =?us-ascii?Q?FO3oAdhe9qj3kWyhcrQ8RPT0mTNFwYwXrf0Jz3ofOHKtsbgMEmVY/1tnPuhA?=
 =?us-ascii?Q?oCQWAx/1D4IVUNY2L49eNtaSF67eqJcD65oaX3OMbTZAyIZOchrrpuj940wa?=
 =?us-ascii?Q?jCGoDFwyDtfHTBbN7skWXKlR6YlYCyfJvqeK09KAxOM4/+KeEPRNSIdeFQaZ?=
 =?us-ascii?Q?IYj04aiydMpJQ1it6G/jFqN6cATSK0H7REcZavHZ5cOTMpynl4J761gDDHlk?=
 =?us-ascii?Q?nrZDU1TU18mt2tmyumIo1wKtl1jKpfkdE/JQMIX0RrJUkv25biqSbjy88bKs?=
 =?us-ascii?Q?fsZxwkQiaVMk6BHb/Aik5p6c1mKcoefmGE+imeXN/6HZ0VwExnpFPi1Sxtlx?=
 =?us-ascii?Q?QpG6Wmboshrw3EHCJNhoVmyCuBmebu3Dy1X6kccFloqSgMZ2zwrDOd9LzOWR?=
 =?us-ascii?Q?zDc3ZEcOoUwfyvrd6/i/GYIcrP7mtUA+/onzagkP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656f6183-6516-47c6-77ad-08db554cc272
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:00:37.2290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqjE1mufLEeTS/qeLyvae8TcuuGVYTmMjWYCgCW/LefSuTSWyi7EUV8v64Sctotg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Due to the auto_domains mechanism the ioas->mutex must be held until
the hwpt is completely setup by iommufd_object_abort_and_destroy() or
iommufd_object_finalize().

This prevents a concurrent iommufd_device_auto_get_domain() from seeing
an incompletely initialized object through the ioas->hwpt_list.

To make this more consistent move the unlock until after finalize.

Fixes: e8d57210035b ("iommufd: Add kAPI toward external drivers for physical devices")
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 2eec53c5d00e74..dc437409e70ffe 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -398,8 +398,8 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	hwpt->auto_domain = true;
 	*pt_id = hwpt->obj.id;
 
-	mutex_unlock(&ioas->mutex);
 	iommufd_object_finalize(idev->ictx, &hwpt->obj);
+	mutex_unlock(&ioas->mutex);
 	return 0;
 out_unlock:
 	mutex_unlock(&ioas->mutex);
-- 
2.40.1

