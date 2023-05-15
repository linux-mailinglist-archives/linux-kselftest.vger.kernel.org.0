Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6D3702F17
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 16:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239720AbjEOOBF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 10:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239253AbjEOOAx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 10:00:53 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B5B1BF6;
        Mon, 15 May 2023 07:00:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHB/PvnRCbCwfOcmLW4XEAItZETMTGbV66298KHkLZIpsB/aloRLlyQRFGjyLCtoVLP9aLM2HYqzYp35T+hWbJvZ/GhcMKzwovN8cbGfd63Ea1KMswlr43kJa541k6DnNQncNBFp72ez49Me2c726FiB5/Y6hOYt2rAlayJg+mBP9pIpNnm6eJ47SFO44R45rChgNMD5W8Yh7nwdPSlUXXxn3mmy5qAEaSqOEgclX02GjKLmIj+9fc8iSzZ+WNQcnUDarDzVsF6Kne2/Y/0wkLECi+4qbberPERHVi/owq+0hnxVW6PGocP6/c8aM19rjF5aDV1zv+ZQbvjJBfyv5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOk+FveIMfNh569AeWS8L0vksvO6HF1UyqO1/hEKydo=;
 b=gnu3u4yKQ0O49O+GLzvICXOTvzc7TUIUmA3eLWUQAMYrEl04NMq2ntlWq3CmD+SrHfbW7use49aHgEYgtKYx/NdwOjFmXXmBIAH4x0LOK9M56M27gWf2IlMyW6D3OgLG2FgGsryNxvcw4S9mXHhkeB+241V/g6gXl8lBm3Hy8eR3COE/KthpY1nBgaN6PXqJ0vL9Us+vV35aPfVmYJ1V+mcLKK+SHYWVRlFJcxlndFsKxFFxHWly6FINk/8cNXAu89TFVpW6pKnlOwX8uU86kzNqfnOnyCLMH8q5Uz/BBvj8Kg116vQzsf1pp7tJJP9POn+ITiTcncjiomyiV3jtmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOk+FveIMfNh569AeWS8L0vksvO6HF1UyqO1/hEKydo=;
 b=hyYXTW8FLERx81Wnaa1v6exDm9ykQjyXxZmZ9d5QblPS07TMg7juwuHwIGl0/GTy9B/8WQllRHrvZcRMrtc6Jcgcp837mpOlsSraklFRzd4+3cga8bxlDYrdXnbcOXeTTyQazWkW9cGDiUe0VJ3ZLIv9oD65DE2y8nlFPm13VKCQMqBE5CF7jhP86uuv+NL3vrYy7PTKbS4QmGET5DoP05m63jTCdgGgs6Zd/QuNlHGD6aelSxaFjOrsfZkaKfFCFXJWfVtMJ7BRVHiVPe9y31v9WaAfUWVzbrIQg8296vNjE9L120Jy5lv8/UWdZX0KeIcPORqcPJvyHfZHT89M1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:00:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:00:44 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v7 06/19] iommufd: Use the iommufd_group to avoid duplicate MSI setup
Date:   Mon, 15 May 2023 11:00:21 -0300
Message-Id: <6-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00013DFE.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aa42e53-f6cd-4459-77ad-08db554cc272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /JcDLfFX0Ud/21vpHvMOLdCuR8alFY1+/J+Wj/WYCYTqjAl8BrYdKmI/95V8dP6KwOie8OfRtmI1c8W/QVoO9ekwyWjP8RSBpzQ9goNlUm9pdvknWSqze+WinFDC4386/qnLRf5OMgOYX0IRBiaN64c7R60YXBUgBLDwQDaPdlEmsmyME3Vcf53Ww1wQacUbeMHAMHvSiKCNjmouK91VaUdnGTNcG+1Yj44XmGNAyxVDq7US20ey36jZFn4bDkv9Kc2Y9vHZz+IR47bEjzEtk6q2UhIgaN5ZzGkXmcF9fH1L971AMiah154cSV9C4osX3MZOqqekQAnG1iGXYFYncMBlcMLndvdZrMl+8VKObkPgIUhqmwnYMc23pt9NB+1gfD2ms7IB6F44bB3BYRHBcjJYSHs34Ij7SduA20QUT9VfODvMcE7vZ+X2FxoTPIUWCDQUAXTowbVHO5tPnVGFLu/7bIZAlDJ1+mgXIFPwr9oVjq+i8bmyE4qQTcipJ8GbbSND57v79/wgAMv2QJfbIg6DVly8JwYeP08VnRjgU+pnTE/QCMK3O8ft4FGXezlsb5Y7G59jIpA+JmBmeCoSAtDSDK7RFPGFOEf2U1Tqjvs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(6486002)(26005)(6506007)(6512007)(478600001)(54906003)(6666004)(186003)(5660300002)(86362001)(8676002)(8936002)(36756003)(2906002)(316002)(4326008)(41300700001)(38100700002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SrSOZmTdyIBjl5oUXxlipPFyIwTqakFXjg9ElwHEM5uQHEIZHTRsLMPzxaRu?=
 =?us-ascii?Q?9VZ4CPMswQTwb5+72rakL2Uvim8VL3b414xRHFs5I2iIaiAAXKzK+afj8VVa?=
 =?us-ascii?Q?AcfGFqmQ91vfV9gO8AhG+KYKS55PeEJneKM3nWf0vUntgp7N4hqo02zYt/TP?=
 =?us-ascii?Q?uvnIGJ/bhnwk2rUq0heu1NuuG5lUGXy+PBldl2l7VkYRsdO9gjPNo/Sx3XCG?=
 =?us-ascii?Q?tiypzYWtZXk5LqPHjd0r1kXSPK5yfFWZuQPVKZew2vuiawtqfUd2kfAHdpw+?=
 =?us-ascii?Q?PIOJqU8eztxGTxkxEkPFJHdjKjSr8UdI57VMt20SBN9JUw5mrlL6/6Zc3Utm?=
 =?us-ascii?Q?L2HHA++6Fbyo6yZO1xIeSipecFgCrATHnXIiIoyPc0YXgWEArmXAAeGpj66g?=
 =?us-ascii?Q?KYfHauxlNoucDXVRJl56UNpoRbWmd9vtly0PP4iVCxYdEH4hH/2SvsmYqwbF?=
 =?us-ascii?Q?t5RmtjN9uJkfLnxc2ZtWTZggjcb+VIN2gPZjKQQeC4DCtD978PKRO/jGwJ0M?=
 =?us-ascii?Q?2JMBnCH52NfLMsKw4XrnaFiLjwh2KaDNlx+0v1EjWtSAFRLuov9P52oHmTA9?=
 =?us-ascii?Q?zt8qzK9B/3ktJb3DLWE2UTE34E7MaTIk89bi4gZKabF8EL/rJxrdskMVJu2U?=
 =?us-ascii?Q?/td9tMQ9JjcdQigVaVyhxsG5LQ7vybtKymNs5ZvsKoIARa/rQJsJblVbQ0hN?=
 =?us-ascii?Q?OKfcEWfvqzCfgm6CERh71gZwOgdGDvJHWrZ9IRJYJSEdRpbNBiiYeaqjjTOR?=
 =?us-ascii?Q?xuOBxlKqtA/F447GFEdYtl+YT1xzq3HTX5rncQ0RMtEVrQKmzDPN/LHSIWks?=
 =?us-ascii?Q?8KR6C0ikiiLWdre9ahHLN1X4OfgAn5y3oRLu+F+/j9qJ1IsxtieahFKCjZAn?=
 =?us-ascii?Q?oGQA/GIr9TU7xsBu2ZF5G210hGWTZn0R3PiFnhNUm8SeF7B+15+I2o6t5X0I?=
 =?us-ascii?Q?+5xW623UgFZTR3Gqix1O8req998TLuKBIzL+9gOSALSKHUYBwaqsH6g0sM76?=
 =?us-ascii?Q?pz64Yh3CkJURK6LC4x7uveVwNUCaM8LBHAUzH90EaNFGzqIqz1KB3bUfPi2R?=
 =?us-ascii?Q?n2yaR77hOSKLU/CQZxADJgHvgZ1K3g7qXN7oN9aJTcX1EGG15oalF38kXXwz?=
 =?us-ascii?Q?XxuBi5D2+ugCEsSrKRJLrLU8gONgkcIxEERHNZ2W7hqfwpjp+G60ySf2jmxK?=
 =?us-ascii?Q?smBmjAaH06qu56FGQKnvaoi5hQ4WWSPus8JyhOsDyYWoPW+jNiaGhBHCvUF3?=
 =?us-ascii?Q?QsX9rhXtKW5O/Su+7+Ng2OJAmWKx20rWhE0q/zxB3DATwdUYi/ZpnLcOlExk?=
 =?us-ascii?Q?ShhHvRKlDzEZq4nI7TC37E9Ld+0cuOn1nG56+85kIKV6n0QrgXrzhF7cwOdK?=
 =?us-ascii?Q?qHamU+Sh22cTrmkOw8UocR8TVmoVgUe1wF+j4HCxNJfsWyVQkAPNIGerq29T?=
 =?us-ascii?Q?RserVdy6bg9H2pAuMHvKscq45TfzvSSXnDiAtxtBCJZCRL9ZRRehfYD8/NuM?=
 =?us-ascii?Q?NEbOJYwvL+RPJdejIkXk/Y0YzZQSE+CdnKMfdsfrHD4w9v9oZWf2sVYiEj6V?=
 =?us-ascii?Q?O9Wn87gehDtTcaSZUNvuwrf8s9PMmQkPTo5T0AqB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa42e53-f6cd-4459-77ad-08db554cc272
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:00:37.2063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+VKc9OZZGO3nowiTe1qKr/zEwsWToUETU/bd5sEVMkxyv3HaaH9ak1nD7icRfPU
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

This only needs to be done once per group, not once per device. The once
per device was a way to make the device list work. Since we are abandoning
this we can optimize things a bit.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index cd8ded265495cc..548288d9a5c167 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -318,10 +318,6 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	if (rc)
 		goto err_unlock;
 
-	rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start);
-	if (rc)
-		goto err_unresv;
-
 	/*
 	 * Only attach to the group once for the first device that is in the
 	 * group. All the other devices will follow this attachment. The user
@@ -330,6 +326,10 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * attachment.
 	 */
 	if (list_empty(&idev->igroup->device_list)) {
+		rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start);
+		if (rc)
+			goto err_unresv;
+
 		rc = iommu_attach_group(hwpt->domain, idev->igroup->group);
 		if (rc)
 			goto err_unresv;
-- 
2.40.1

