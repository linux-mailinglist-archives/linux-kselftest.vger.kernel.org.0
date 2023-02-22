Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1719F69FD57
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Feb 2023 22:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjBVVCw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Feb 2023 16:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjBVVCv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Feb 2023 16:02:51 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1F12A999
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Feb 2023 13:02:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdyInJ1SDWKVIwOVBgGUQFuY8SDDfJrJtgV3ce9P8nnYGbj6JOieiUMtGHjtofOl1tpka+sOL7bMTgo1KfnexZSiJEQvwgpKD8eyIeMOLopgFngDpNXoS4B/dPF5qavoXVbcCYHoNCgMG/ZLNVPBTiaT8sucTAl8+zqijNvYV+U0jsBL83u3GuiQQ2cXdm9c2AYPcPf11RdcuPMX/ZPG2aDD5PI6pZjueVly26zKuhnr7EDKAq9qHFi85eVOcZsUVkFEONbW97R9PMyw6IDHTV7+PHHNMXITxQ0UClPyXIV0LmggAo7jrgw5G9x9ILkcvyZboTehW2a9zpOzogixaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHDOod6wc4BoYe9V10lD/rg7/WdZq7f9tpS/HuxZuGU=;
 b=KnZAk/f5wu9XSqqSFx6jAYX6vHdM6cmdF8FpYjvTDKPtbj5fJ11aIafmZPTn9q3VY+ztKhQHnCCEbiyg8W5b5BXpJzx+w/av0NgwMIbFhc280Wq3oUpXdMDckxUOXJAMiZlOeqyCHpRQ+TEKtNZXiZLtkpaHUzyl/IxbW3fUX+C38hhTwZmjw4qt33LF3+YNpuFRPu77DWcvW4/gyao8GL304wED4BCsyOv4VnTLY/q3NjB+E82hfxfvKYxCbLg8jFeiO8dWIOf44GDrkGePeE3rLgDWjWoJgeS4uduQFAiZiyRhBRao4AlJ4qHmgwVC2WypyEPWoRXdtu9FgTofCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHDOod6wc4BoYe9V10lD/rg7/WdZq7f9tpS/HuxZuGU=;
 b=nw8gk3ci7HDJMF8g+Lm/P/fmkG1dhysCAhTTobnbvtgFkhR+IwAYZABfe4P5XMICLbnwrwO6f4bvTOzLDQ7lGziijxASNlywMON1oBWh/RvGr9yHVlNDr8WrMj80N9rC91eLdAtgbHQAIDyBFgF6f41zl52lI4PUUeiyDI6HNtNPlJcEMuX1HKBXSz6ueNd76JalW0T9M18+mLFTj9fic+Ql91jFnBvu8tanXsunev4BLm7rS87czcV/s6y03qnbwjo7qDjZcVVKCB/zcIqz+xNkvdaq1sahYf/HvzM6Ejx/sOPg5VzThmjPi9ROWhRH7s7LmakBYwcBZTaHOHgVPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CO6PR12MB5395.namprd12.prod.outlook.com (2603:10b6:303:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 21:02:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 21:02:45 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 7/7] iommufd/selftest: Add a selftest for iommufd_device_attach() with a hwpt argument
Date:   Wed, 22 Feb 2023 17:02:40 -0400
Message-Id: <7-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <0-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:208:120::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CO6PR12MB5395:EE_
X-MS-Office365-Filtering-Correlation-Id: 76069f90-58bb-4830-6fb6-08db15182429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RrnShVhadC2khrKLPDJrToVPhgrnrHMi5/FSRkBmySTdnutc1v35t435wXVvqxWjtlMKaRqEOroUzJgzKdL6H2bxwsf3ifRTIMMIO7J+kAJfsOt/VLRZTw1CMtflwXKhtkZb4K2JO/OW5mesoOLHWuHzWPoap82kaKq9dB0E+Vg3adxDvdQHEZfwMFZflbAh36uEhV1wjHNkJthvvKk+S7v5XVvtCUGK7SXp/4eE+UQEekPsw2+IprwXbJKZBhXP/ZSjFLStJA3SCxgnZ8S47PlghdhDt9ni4ZcmC6hjA+mEg9HRfZH1zclNKdDb3hLcw/hpExlVJWCKgZVIndFYlmRfVgV3eJ890Vivw+qs0mzvETdIB9tpLvZnAkUo+znvH6WEkOo7j7Pvcs1G5iS/VlNDeuURfcZDSNgNBxpYev38VeEVYR8U/2r3PfNaCFXra+ij1hAebwVuW9aYP6xGyOStyAnfVbKarNeigkBHfEDStK3H33WaYCOdRW60NTC91ff8fyalLCf2EAFafQI8ruAb3GuPF3whOElF0KFFHmDGnbCKiZ3VlWoOQL0L+iH3QvYUFpS+4c5VXsyMhsdoe6VODmji3cA9EsgC/YJ7dA4AUlrkC8rysIm7M2K0wdqA1FdoNavFDPnEAjJANADr5IB/ZkjMj3dLkIrYFDOFFQgEzKMox+MCkuABppZbnjot
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199018)(478600001)(38100700002)(5660300002)(6486002)(2906002)(8936002)(41300700001)(2616005)(110136005)(54906003)(186003)(6666004)(8676002)(66556008)(66476007)(26005)(66946007)(6506007)(6512007)(316002)(86362001)(4326008)(36756003)(83380400001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Eqn+rLJypVcWMcg50OJjRJIbrYC/oYv0kER4tyLbIXPv/Do2FOFGXSp84jDi?=
 =?us-ascii?Q?qxj05Vfj5VXjl9ntg/yjRxfURpq8OhMNl2RJyMeGuTxQoCU/RtBSkJlQdUfA?=
 =?us-ascii?Q?/lZbuWnRk+zDFM41otQBZthn+o1PasQfkw2v6K2TZQhawvhLNy6bI/g/xExX?=
 =?us-ascii?Q?5WsOfTBIk8bhJt4pOffTxnIDp9rdSyNNkikMcE2CXJgF06M5I57FNrzYdXem?=
 =?us-ascii?Q?WiY1A+TkP0RT++msF1x+u+zDFKE0Ded+byScyV96u1mIaGjC4wnWfb6RvPbI?=
 =?us-ascii?Q?A+FjRIVuNMxyNpTrERK6kCDPLyr8XvnCn0BuibMCCK+2pkjBZOsv3ULJNGWn?=
 =?us-ascii?Q?qaK6I/Td3SAOJl0OP64do4OeVqm7qc//osEHVyJY1C8POixrQGRJf6FQi+lt?=
 =?us-ascii?Q?9H0tP8F3V+F+WaXgovn0S4kfawxM2eXZmOCbgTv9R/o0JJ2zOX0TgehuPncp?=
 =?us-ascii?Q?inR8CUTfEmvqfM9LSock0fEDpzWwAChILMaNK0xuVxeFV/nSQ2MB8bxePB6+?=
 =?us-ascii?Q?6f8sQPGpp8i1+o9zbij+QvmK4ptYQ0uSUcHXYTsVqvmDWXqrRgSUtB8sovJi?=
 =?us-ascii?Q?C2DLImjDYr7MJURoSk2pxGpM6Re9GQnnI8nesbY4neey4W06p0RkV1w9ARZr?=
 =?us-ascii?Q?dk0Nri7OllqvUqSyw60pOtTcY6uuE9VmjVN8nXDOmqd0TNticRsTCOZQ3v36?=
 =?us-ascii?Q?em2ly60WfXYBObBUFE7SaGfV05nG8XSssa6srMowF5+N6jiSAyYoNuDkGMta?=
 =?us-ascii?Q?KSp2BRCviM2/OWG71Pg0pU10lCA3rLZG2l8CFl0mADdZGbswB6OUj8Nq6Kmo?=
 =?us-ascii?Q?OXigvbw/Uf3JH9Q0ACVohmP1qudZ/UFdL1tj9yCvkphAAixMHtTfNtoCSg5t?=
 =?us-ascii?Q?ZdzlpilmzBm/aaZKy3cfRqjYWQPMx4UJ+d2Tpcbd7/iGfmDtGx0+Os7RajFi?=
 =?us-ascii?Q?uos5MmL8a0yqwImA/8Wce8jMVtyh+bh8Fp5QzzvY+mBrhiHTVJlSV7fQAXpq?=
 =?us-ascii?Q?tM17EJTM0mXcen0ie6i9M0gEiMJ/Ua+ygPnWv8yRy9QyKoV744SqJP1COLDb?=
 =?us-ascii?Q?n6jz832u1aDT2gAg1hrvotihcXRlGH2HYzLrhwBk5vzsswGqNzzbnigtt6WM?=
 =?us-ascii?Q?LgrHGQqucO76+cUoJ9Pe58fVF9x1rZzUuyf1ub+A3UxW9kxiMMBwdH8AhAHT?=
 =?us-ascii?Q?Klf7J6w2DnJF8VRA0UTs4gTQr5dPHI5h4UsKD4jZWKxq6r33JVzMqyjWN0Wz?=
 =?us-ascii?Q?6cH/kNhKC+CDLUb9ZrA5OZPa66Wwv6hOXn0EgIBqzuNDMdlYHVK8dBdXe62v?=
 =?us-ascii?Q?A9RrR7+EBAmzNLZJyPPNwUf0GwqYgk56f91iY1rkz3McGX4oW8HC9tQB2ksv?=
 =?us-ascii?Q?Bwv4Lx4X8WGYOnhOTsCKZgWQBHWWRuURvGfbZcaFePCO+ZEj8rjJOfkkhxBW?=
 =?us-ascii?Q?To6LUKP4HXu8WU4HHYyKEEmkQoAinS0xwQ6TGdcQnlUyyQBLJdamiWipnMY9?=
 =?us-ascii?Q?hCmY+Dl2+csMtUWCqapENFYvBaQLn80SHbTVunKoSg9OJnto4nx512RlVh8p?=
 =?us-ascii?Q?LiUTIljsVwAaVv/oF09uugF+QldFN2ay9+svJD1k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76069f90-58bb-4830-6fb6-08db15182429
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 21:02:43.4899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGtJVhHjscg3IvlLc7jkio2tghY4oYyehjp+ozgwl8/tw6/Km0iur/hKCeRgxVfd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5395
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
 tools/testing/selftests/iommu/iommufd.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 0c4bbd4079a425..69cb79d6a0711d 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -187,6 +187,7 @@ FIXTURE(iommufd_ioas)
 	int fd;
 	uint32_t ioas_id;
 	uint32_t domain_id;
+	uint32_t hwpt_id;
 	uint64_t base_iova;
 };
 
@@ -212,7 +213,7 @@ FIXTURE_SETUP(iommufd_ioas)
 	}
 
 	for (i = 0; i != variant->mock_domains; i++) {
-		test_cmd_mock_domain(self->ioas_id, NULL, &self->domain_id);
+		test_cmd_mock_domain(self->ioas_id, &self->domain_id, &self->hwpt_id);
 		self->base_iova = MOCK_APERTURE_START;
 	}
 }
@@ -259,6 +260,16 @@ TEST_F(iommufd_ioas, ioas_destroy)
 	}
 }
 
+TEST_F(iommufd_ioas, hwpt_attach)
+{
+	/* Create a device attached directly to a hwpt */
+	if (self->domain_id) {
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
2.39.1

