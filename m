Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533406A744F
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Mar 2023 20:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjCATam (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 14:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjCATak (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 14:30:40 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369FB5FCC
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Mar 2023 11:30:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlQOIqG0qZDTkj5s3XCrU52lWbypxfUCtjkjguuSYNQ++kdq+YfhyNH8pjCDapz2UHYyiQq9vMYxTONOQ+hotdClmecfQtCudT6nsM/iSUQ68HfmDpmZ723vGvOSki6Can3KCSF4Z4NHZYNoOX6pNyHu/UTMWpjuvMgnagnHWypriedD+x3jP7dWS9Xs5TVwRalQ8L9eMa0DpGNDzAs4kR54K0pnajT0aMiBkCT5o+KG8jlO8Zo9ezCNKblGOleMB+WZL/pdcYds/D7oZO+18ZstGU7xOFTfUCkMBpUtHfYKmPV9xrPaI+pp05TfDA3bPkXiM+UuHVWImpgDyFseoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzH44awttjEIYFB/9CCa7a822Kp/hPgtX2vkljezwKg=;
 b=jBo+cK5KESo5UUusXArgZS03o99imeBSuGU7iVetxrNajCbA4l8NYKZqNaZHR4Z1Lhzhbr2Uhw9IQ2Vil9iXeFkToCAhBoaimf6P8ZYdJRxEWtuTRT5aRPN8HRP2H8neMUl2KnOcQswpSnHtxJ9pwGr1J9+G1tr0jTJsd7Ua5pRsb2o32YT8TK3l3MKMuyIYEFm18H5SpmgVLmtSBQxsVi4FlMLPE/SoYZBgHSdR5fhGwuFX3fI4GuYvHegaosjfx+XcaTdrwjaKKQu6ApXcx7gjTRHj8IaYY+2ozSTv+qpOjD7xG69EUTDr1UrkEMJOmCI8nCRHVAr6th3gwhD1+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzH44awttjEIYFB/9CCa7a822Kp/hPgtX2vkljezwKg=;
 b=pWjo0dPa9bKMGO/X4359SANEYJAVRUZGfFR5hfSnTOqdVER3C1svTLGsHGhASOudPE16xv2dBlc4y1lGVuasCAFDpePixvCR5YLHKJ01L2sHZHojtmZ3Fif4FtcsxEkqUxOnFWAQ4vGa6Fp7ERf8Gga0Kgz54a7RPodYMXpG90BlFuX4EBV9dzX419wQLrEgbJU78TL41YByAxzNqhNFCUeXR3FRHVXTHrmOMoAaNlvtg3xIka5fy1ITvrw0DS1B08XVp+SGtDufOCv2WrH9z+A/1H+tLoJFq3jFtWM62VEY8XBF1hYPXNJjYuYqo1Ghb26I9hWjYjKTdsS8YJMjHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 19:30:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.029; Wed, 1 Mar 2023
 19:30:35 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 12/12] iommufd/selftest: Add a selftest for iommufd_device_attach() with a hwpt argument
Date:   Wed,  1 Mar 2023 15:30:29 -0400
Message-Id: <12-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <0-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: dd099b2d-49d4-4cd3-45b7-08db1a8b6cb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ukS+p4U3YvRJ7tM/V+AyeNR9H509udbfu9pZDJxi1z3RQOxnT0E4sLA2K3JuhjctYxUvZ4zqhlzzvgJ7DkVHI8i3knWjk66pj71WSvpgp4dy/1lXy4IFPF+fFjw9Xv+Jl8MiIbAEJeD5gf2+y8OFEH8szt1V7aZ0IFc/CDsz9hLeBJlXKnU8zbl5VdqssyDwMrRiNpdM/oLk4ynUek+/fziXpTNk1xb0XeEeoG69zdEMFKsQv3a3LnjUKq2WyYylXfigTBEcHZzvQlTXZnVwYFIGSTMw41Sy9IYACcdh5WrqwNonT+3z1FtdhYqvPxd2xAWSsvWsEK4tJehvj3yksGlvJGR5bHRWIYQzx6av/svfogYJjW2UGxPgr7tZ2VjUN8EyTMwpM7P7R3pf108dT5yPHoa00sgx43xYVN/kvBvo9pCSc/01Iky0F/VvhZ0RNGvKgbiqJDMP3NCOEyfMgV2KIdTobKOFLV0hGulWT8jW2+1S8T0AmPRzMYDv6PwpS2Vw/l+o72yMP/NDm94LJ9KdAX/V/ktAYigFZNi63FtCs9FUxeitfuN34prBwbYn6RHCrgWw8EqFT7eyRdVROXUkaAK5WcFwP3JYv+7cGc/10Ckh8OtkizYP1f8+ejoR4t14FJIRDGZZQntSFNTl6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199018)(186003)(2906002)(6512007)(5660300002)(38100700002)(26005)(6506007)(8936002)(4326008)(6486002)(41300700001)(86362001)(2616005)(8676002)(66946007)(66556008)(66476007)(6666004)(110136005)(36756003)(54906003)(83380400001)(316002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?So4hTuD/E9/jrk84Eld6j7fVt8rjDTZiPu15aFn1wpUQI3fy8OJGVZUqcDnC?=
 =?us-ascii?Q?5IfkKVH4JfkPfJFKFLFYYFGdqNxwMyUt+biXUm6HZyuNBcxr8gE3TIxN8j75?=
 =?us-ascii?Q?G57x2jdVSWnTjgounWlDkFql140oguod2kNx7te/p0L5e3HYn04ydlG9tfO7?=
 =?us-ascii?Q?lGOCRptJFIq3CLW2UbVtd1kBa8m6vsxFogBdxQOC5yPogBgUnRRWtepbRU2c?=
 =?us-ascii?Q?86hgn0Irdx1prhNu712hDipCSMPd/WrF0JLS5DPfi9YVD27V1sEbdaH1Eap+?=
 =?us-ascii?Q?rVi4e2nFDi6B43cVjng2v3o22L0+NBW5kIIR1FWMjXzZ4Tinfc5u2aN4OrZW?=
 =?us-ascii?Q?J0DVb0+tYdixgFx2fkV6LAaY6F3uVdNRQ4TrPoTzlhkOc+PGc5tOnBSLO1KF?=
 =?us-ascii?Q?Z85Vokt+RHWHL4cmaWWEZ9YN9JtWpakVXwUvUvxG8+1sXP6UeXljYAxif72e?=
 =?us-ascii?Q?qp2kPKkFUYyOvuYXnIJxCZyKYTIMg7kPYtc0xwUCdhPbF3Iz7cbAnTRi/jeE?=
 =?us-ascii?Q?FVmGG/4hevJvl8539Ei9E57MU5NgV4beB9BFGC5ERiCEUqWHw/td8WMzt7Uc?=
 =?us-ascii?Q?rYESgAttKZX+h1P6e+NLh9OlVbnQbQfQDVYXGuks9MRLm8znXdUIC3iLoyVx?=
 =?us-ascii?Q?yfuXV9wMFdWO03wlWYNR4DNM8r55klqS8EvYeMaRqvcWhRo8W4JlILEovnGU?=
 =?us-ascii?Q?d4yeDQgNI384/8pvlesAHaCtdEbF3g4aJTsrm3dtV78XP6440wdv2giCuhlG?=
 =?us-ascii?Q?CPyC1uJEzpFZlrAZNmZU8i8nXLFD3lLLl6nfuQ05Nj7rDbQTntVkwkmEKKDo?=
 =?us-ascii?Q?ykVNeKSTpIhLqFdTiZeeN5rC9TgOfsnzbpdPzBFXvfZg/b/wNeOMLft0PDsf?=
 =?us-ascii?Q?nObX1SrfwLUyFGp8lWV68BBdMn+I4kKPXEqaQfeqdjDpjVEcShnkHLA0sMaA?=
 =?us-ascii?Q?acantDz0Caori+wgy3I9oJWQXGwfv1qVrgk9pl1dvVFsZNhGNyWVkkBM0PvZ?=
 =?us-ascii?Q?aiKGGOxwgQwYbhoeUGN2kAvS4Q1i0QiMaoFDdAqke6oDxitARi2qAYnLSoub?=
 =?us-ascii?Q?FeiVORS9DhycCr6Kto7KDLVTsNC7cvhRtNSs4qavPgtzpeZRFrvpknO+o5jL?=
 =?us-ascii?Q?/rFUE8VlevtG1PS6n5VNeRfiGfNnYLQGzsc5weTbLPPoli04NFs8hBLwbJHf?=
 =?us-ascii?Q?Skhe6pkMD7wB2i2EThBgwKcFMgD6Ay8pGks3OLD85jm9KaEIeqxndgIXroPg?=
 =?us-ascii?Q?Mug9wOyr89iVqGYAh+0yBE/ii8sayx01CbNUNh8y88x/gQUMXuO0R+Tp5QDI?=
 =?us-ascii?Q?RsbeDPVHpjOhwKxImSYeKD0FElUUoIywnqEzn0i8udmAPqulFtWXK+pNyF21?=
 =?us-ascii?Q?vR8TQRrC2MnZadP0F5B71jR2VBBAWVINdk/igEMD/VHMCivX/q42DBAdz2z0?=
 =?us-ascii?Q?hvMLrLEWBi0sHM1GF+S6RCZbfgPl1+pNOM7jlQC92n8pKGFy17BNt1mNfh4T?=
 =?us-ascii?Q?i8vIW+P9dYav5wLqtu/4HYCm1syoHPCKFER23EuAhGpoODgYjFVkQTO5JUV/?=
 =?us-ascii?Q?QK2pOlKAH+nRcg3Rsk8OeMSVNkQMIc88sONdt17L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd099b2d-49d4-4cd3-45b7-08db1a8b6cb6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 19:30:33.0655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czV+sAYL1/d6JXrw8OSxnkVyWYE/Mic47RkF1nSM4pE3MP3g0jgV1Vq4MvDCBPRq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This can now be covered since we have a full struct device.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 113dab3a0cd631..7aec1d5386d9bf 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -187,6 +187,7 @@ FIXTURE(iommufd_ioas)
 	int fd;
 	uint32_t ioas_id;
 	uint32_t stdev_id;
+	uint32_t hwpt_id;
 	uint64_t base_iova;
 };
 
@@ -212,7 +213,8 @@ FIXTURE_SETUP(iommufd_ioas)
 	}
 
 	for (i = 0; i != variant->mock_domains; i++) {
-		test_cmd_mock_domain(self->ioas_id, &self->stdev_id, NULL);
+		test_cmd_mock_domain(self->ioas_id, &self->stdev_id,
+				     &self->hwpt_id);
 		self->base_iova = MOCK_APERTURE_START;
 	}
 }
@@ -259,6 +261,16 @@ TEST_F(iommufd_ioas, ioas_destroy)
 	}
 }
 
+TEST_F(iommufd_ioas, hwpt_attach)
+{
+	/* Create a device attached directly to a hwpt */
+	if (self->stdev_id) {
+		test_cmd_mock_domain(self->hwpt_id, NULL, NULL);
+	} else {
+		test_err_mock_domain(ENOENT, self->hwpt_id, NULL, NULL);
+	}
+}
+
 TEST_F(iommufd_ioas, ioas_area_destroy)
 {
 	/* Adding an area does not change ability to destroy */
-- 
2.39.2

