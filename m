Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E606A7450
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Mar 2023 20:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCATan (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 14:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjCATal (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 14:30:41 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF45D2CC55
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Mar 2023 11:30:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GW7NhgtZ4BRumSK53bCqM9IOMGzdbKP9zaSUOrPbKnn/NJ5Dgdj9C1O+9GKVRelZQILD9wK3rM/63D/YMt0XxkWOkHqz4pcz3wc18aNYuQhH1mIoxtWbzvXBGXTxSwbbt7vrfd3q5XM+/Xe/AW7n3Zpp/TAJvIYO7UOMA6db37cLy1omENq+KBciMjADSx4OEVrGFnrGtW6s6XamyTqjyTU1IM2EVMEEdDwN5NluTpddGSzgJrFOfN7CIS8TVOX0BHanB+YbejwBwH6/bPDqwif8VsKu9PFtpYBvkwL9rfJJT7rKpBwUwgWAwb4bqf6Mn3647zOv4BfwjwnjciSsPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmbvk6MSIOPvSvISloY8rVrf4cMCwMHXNe6zriI88SU=;
 b=WiXdafyIt0P/nb2QaZORaeVGFeMRxB4QsyIW3oDZN9HZ4nRvPGkGCxCKrBtWnj0DxSYKggUAvDZgj6eUdNubb00kKy+6BQAZVgC89N1QwNh1kCZpmfcPrjqDQVEwkWQqj/Gn3oxpLcsOLB3WLbQTw4vGtgQUY+2v7C3xeY6sTRcOHhJNnjqx7o7AV/PvjxkE8EA2fvnerCTG4vpQRsfN4OYAQN2DTznGn17AZhY9er+uOSr/1bgxBPFafoe50hNrjCJkfRe3pyOsO+k5hLxpquW4cEkKo8mpGMRqUGe6RHLPKbLUnd5W0IWryMS+bUU8biUV/U1hb+z1GFc9aLYEsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmbvk6MSIOPvSvISloY8rVrf4cMCwMHXNe6zriI88SU=;
 b=mrEd/vW9smynNigSmqo7nhm1Bm8zgGYM1ZbALSoHF1Z6l3nV21C5FaR44Ri3jfWCnaIZ0TEDHxyKtl/LntKCHF6MG7+tvoou5hI+hDrAOZ6W7Hpz0aNXVo465+B6NdBY90yHq3Y7k/8CBU0S8Xq5htb0rlZww21tAJjV1GqOPk6sy8vcF/xutYLV/OWFzZwUZ3xP2u1nbqUvuc5cxloO3KwSzMTT72IG614Ajmv2cWKdihHiVi6/qwJkYaJkjDyRUXA3RChNfsPoqWueM3B9rFkNO8yvjAZ/zCNX+YmfpcYMxBDE0e7nHvk130DgQOSj102snBrg8HZDO1FHEUEBZw==
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
Subject: [PATCH v3 02/12] iommufd: Add iommufd_lock_obj() around the auto-domains hwpts
Date:   Wed,  1 Mar 2023 15:30:19 -0400
Message-Id: <2-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <0-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 359d6280-6f72-4803-45b7-08db1a8b6cb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L9W0dyUy2kBIE6crvPQ48pMNcjP5vSe9oiIqwaHEvJFiA3d2AVRTD9HVAVCBQlUVEzFD0wbiDRNnlYcLqNy75Y1aE4E6DNIb9wHB37oVNMt1zjlWL0HAx4qUuMUU2PrZqpJQFe3Jwx2crAby02ixb8Ur9TyuEDTBrKOj4voi4InPv50lzD6J+OagopM6sSbVDxFdA1J8pGYw6p4bK7Qx0Mss3KiUeHsA7nO4ahFJ/jLDmN3S05sYdBwrry1qoRPUda+QwJN5vawE2t6sqnyzGlASvOY3RIAQ2VOIwCkIYSwqmKvIWMS2Jgh22A+ELOiCwFgpTYEfi2cRFT/v7L8BMSk1xRdnOmaaRej5+u1FS/Npk1c5Y0IC3veXYc9JeadVIlTYVOqS+Mem8blIoc2e9JjFE7/XoYLdkbdJyaFy3s5m1mK36ei0MChKNq1pzCpE+49crnIBfdGEnrg2SL1wCSmQhQA/lBSG5ifq0aGhTWXA+ErSIjF/D2wSz6ZSBI8lkJGe9YxqXrGa573CZcvOvVo9mZl9ZBArlFasSPvwrTyOI4AAcqf58rYyRkWRCRvJsdigQA7K7Ekpb7MJyN7YhFkZL4ZpoOOP0Kg2AWYwmin9248pZoULRI1TGS5gEf63zhbxbXxMuy2WDalRusSjiaUYz3edhnMM31wJksrZg/fAkKm361i885b16VXWy2yezlhHhtgOOD8L3+tzW8+rrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199018)(186003)(2906002)(4744005)(6512007)(5660300002)(38100700002)(26005)(6506007)(8936002)(4326008)(6486002)(41300700001)(86362001)(2616005)(8676002)(66946007)(66556008)(66476007)(6666004)(110136005)(36756003)(54906003)(83380400001)(316002)(478600001)(4216001)(17423001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W3Jcng+jIWlkDB8R+jyV/fGMv65l0xyGcaUwO6ZFbvwcp40dP/9iKcQ1rceq?=
 =?us-ascii?Q?16Hb2NFVYtHm6lI11VEhgXqG2DTBBF3GT9OSE1R/GNegoYRTSJau8NoZQUTY?=
 =?us-ascii?Q?yBW0wbbLdmqJRWRuz2/lgZo4Fo74PSzhNFnCzr1RCTh+KeJ0/Y9z+oYHhqKx?=
 =?us-ascii?Q?qDLTnxrF7q9Ln3N/HbUKabs+XLuN2Ud5/ikMsY982HhQcvqMPcBCZlysgXfZ?=
 =?us-ascii?Q?96qi+ji51HpMvCsx/YWfqo/45iCBDGjc7ekiR1XKwOsrkynuWJbMFQnrAngd?=
 =?us-ascii?Q?zpdOEmgwB1U/7utWPdJ2CZkURYc4Jd+0yL/NjB4u1qmscd3HohRuZKs9XrcV?=
 =?us-ascii?Q?TF3zkQuAJEIisEsyvlgT6/Q5aXlKQVNGUi64MpUTK9shm3hVSIT0y+uiZBm5?=
 =?us-ascii?Q?fBmvF4Ghy1xKz0FJYWjr2hZhNIUCA5iyMOEUQzjwtyoSnpMY2rxS7F98blIL?=
 =?us-ascii?Q?6u2xo8e1+wK+FbrdNt+/AO+H2rMV7KizaACNwP9uL+RR4Ok+3RCRXiABMxLn?=
 =?us-ascii?Q?+ayEA/CQHNR1NwUyCIki7DmmTrP+vXPc7FebSZGcbcQrcOdTH7xJ6T0rhMUu?=
 =?us-ascii?Q?nBEb9uy65usoZMqi1ANeuE6gCqsKjkevScx0bZY8q/NWiUy8PevEK/+mwGel?=
 =?us-ascii?Q?ySRVmB8VInJ1hXPoOF5e5UclbXFQLD/Vr9sCe/L+UWEFFWgMDfVkdDzAuaix?=
 =?us-ascii?Q?iBqSKK9cag18+j5XrC+MX0E5zBJugwWZNcZV1kg5IthMcL5ZlT4CzUMVHWuQ?=
 =?us-ascii?Q?GgbJ9UlDKtmRYBLjc/3BEfRL6PLGKC59Us9vTGHGUmnk41zR4BOx/eh6yLvV?=
 =?us-ascii?Q?WIk5BK92xG5NMhjwxWQ30yg0LZ5YG/Di7JAmCN1hEvi78T1szFEOFntKDGxi?=
 =?us-ascii?Q?yId57RJuOQ1V8EWg5AlfH1t08BE1JNnb/uEyZ6YiFa2N2qEdQHOxbNT0gL04?=
 =?us-ascii?Q?yE2MoBwSHl6efQ1cwZ90JYewFi9ir95Yd6tYrGhrPGCFRXaFikac8DID9Z+T?=
 =?us-ascii?Q?pjBdXQMbDI82X4WZcPR3PcPZjSZWqMG4qs8+sP4FLUJILxPZtBgVvhFzfbyt?=
 =?us-ascii?Q?WBZcYcojDg/TLcb9M+E2NjLy32hpyQerYKlp3Ir7sp+8eBtK1qiC2EOd0Eg5?=
 =?us-ascii?Q?peFL2P41cMr6Oonig5NobhBzXxZ/d0ryrQQj2GlN0H0JztkGp66RFbCc2x6d?=
 =?us-ascii?Q?i6DGlJjhNyMPp3uMpoj9jd7MBQx5sojb14gKYrhHEWoAShdRM9/oh5hsaCjg?=
 =?us-ascii?Q?hUTEgcjGxmroxdZesGzMcwLqCV8IpD+EKp1PorzM6hLl0RGVv06kAHr0oVmS?=
 =?us-ascii?Q?ZXn4w5AfMWNHgp26zBhs6Ao89PdEvbl9Hmx/vRHBQBWs2yWg9gPdBzhH/QfH?=
 =?us-ascii?Q?JTnGc79Jy/1mK9i05Uzpvoo8PrchJ3lGvAlTc5H/LOeYFbAKBepTQFR5H77A?=
 =?us-ascii?Q?9oDivarPQ6ctFQ/n9wfoyqpK64lyjREVtFSU/vlvg0wL9RsOgzSPYLQf0wQC?=
 =?us-ascii?Q?NXr5P2wuKqg8J7GSnw37lIYrdnXX31s3ZH10wZ6AFVRaGCpgzBqL8pRZI7p5?=
 =?us-ascii?Q?AR4i1TdYMmL51fDAY8rlaKED9+z8k29+DxjFDPRz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 359d6280-6f72-4803-45b7-08db1a8b6cb6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 19:30:33.0967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPrKoTGtNrbeWO5r0WGhHdI8FMA09DzVpQ6y0lytid6Ow9Qa+9QNOZIOn/fDqoqw
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

A later patch will require this locking - currently under the ioas mutex
the hwpt can not have a 0 reference and be on the list.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index dcfaf6567420e0..0a80ff7b2e0d79 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -282,7 +282,10 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		if (!hwpt->auto_domain)
 			continue;
 
+		if (!iommufd_lock_obj(&hwpt->obj))
+			continue;
 		rc = iommufd_device_do_attach(idev, hwpt);
+		iommufd_put_object(&hwpt->obj);
 
 		/*
 		 * -EINVAL means the domain is incompatible with the device.
-- 
2.39.2

