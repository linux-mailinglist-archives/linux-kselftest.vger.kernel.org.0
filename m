Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC4649124A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 00:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbiAQXYR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jan 2022 18:24:17 -0500
Received: from mga09.intel.com ([134.134.136.24]:63914 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235370AbiAQXYR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jan 2022 18:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642461857; x=1673997857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=3hUWtiKXjg3cJE6CMKMTkwKwRYB2s1i3CV4QtKLxeyw=;
  b=Rv54X/cvosusqB7OftykPQn3PsYv5eMad9NOndyHmc8p0x88QJruEyPn
   iirWsHkY0N9599QRKyHeTH2naEWmmXFvUetILdaPUNeDxaMtBRF0LCH2I
   A26kNIk+a7nz43BW6rMDgO5DHREnXcyd4TdHMShmX1vARxLqNo9dpwcfP
   wgQw5c7PSxhTTjpP1Wieu2r84BoNm27Uf1iM2qIa9sML7XVdkTchX+Nag
   O64A54n0N12B0V6I44rw6t6GypFgAGz4joLjP/b/tmdX1MGwjJDpQiOqu
   W2MM1Gc2OPhRwMqdLBzvP2qGhbPxqv2iJg83mE4LRUKFq2SAXw8oIBtJG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="244501822"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="244501822"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 15:24:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="474580633"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 17 Jan 2022 15:24:16 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 17 Jan 2022 15:24:16 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 17 Jan 2022 15:24:16 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 17 Jan 2022 15:24:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3vll1c83sRjeoBdhEWuvzGjYVWjYIgnS1g5PpALLCcWSlsmHouL14VDcqF7AhbYQA2tajPajzTC/cfrDYq+uUw8PIM0obA3ijUdOIl7i/VUXyfKNbrm3IaOKAahtKQCXEDA0yd5XGnF9RhJzcKKzgAzPp8l11B++pjSZab3zpDIjjVvTWlbYUyhBtfqGYj52/++7UQ94MZLw3HSr54OMRUun+Zwl7VtF1on2MmFT6dci5/lRC+MBTEBkw/DwwaqIecxB2u34WgmaqFjLe2oE1TSjq5j7x78tRGpV0gZVDkcr4PnEWhH9GuJ3yLg7RRLmfVT3QC7j8Jgx6SuK5V95g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejnFkLnjeyaluKXsi+Sc4X3UbMwkT8iuOVvEia2FWvo=;
 b=RvW8NzDPSykHVjDhUcldnfYsxmwWaIVSqFjaCLpsS0RlolnM2bj4zOPOosZ96TLBC+OXMKR0CR+sbk0wWV4AEnFgHMNaNeNhxTeV5/GBJuDbQeQhNRuRyRKnJCX6gLvE3bQoqodYTDk+SnkpyPgbRFsyxOS0/BlKmmHAmRzUdvnsfs7pkQbwLjZzX1uDiD/EP4E8itMq5KsFw1q7Gs/LhZiSfOCIGvtH+CjaM4Vyp8ULPlTHO5lwDVOfhwRXAgLBhZfglujf1WTp14Uga12So2J+9FoFStZEAhikBuMF3XLinbucwongYmI/1GHodPb2TEbgtkDf8nPk52WxAXyHFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 DM6PR11MB4140.namprd11.prod.outlook.com (2603:10b6:5:19f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Mon, 17 Jan 2022 23:24:11 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::fc15:bd26:128a:f5f5]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::fc15:bd26:128a:f5f5%8]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 23:24:11 +0000
From:   =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
To:     <dri-devel@lists.freedesktop.org>,
        <linux-kselftest@vger.kernel.org>
CC:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Petri Latvala <petri.latvala@intel.com>,
        Arkadiusz Hiler <arek@hiler.eu>,
        =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
Subject: [RFC 02/10] drm: test-drm_plane_helper: Convert to KUnit
Date:   Tue, 18 Jan 2022 00:22:51 +0100
Message-ID: <20220117232259.180459-3-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117232259.180459-1-michal.winiarski@intel.com>
References: <20220117232259.180459-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0014.eurprd06.prod.outlook.com
 (2603:10a6:20b:462::8) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb2fc346-6551-4805-3bfb-08d9da1077ca
X-MS-TrafficTypeDiagnostic: DM6PR11MB4140:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB4140E834A8315AD62743C94B98579@DM6PR11MB4140.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eyEw58PhmdEnu4PRdmSwoiUtiiGNUOe5fBBjIodulWfISVWqvkCo6yzeaW07Q52BcMJgIFAbbBdfOVE8zadbDxuVQO6v1PpYlWA1ZujY9brvvSmOGEzd5vVGFLLDE8DqRRq1NkWdvCDG4YtZZv+PbjQYOSJ+62nyl7fq23Wvd+Yr1TWT+Ku90kdqlaTz/07HgFK2Bh2M38hO6oaay53JKSZAnX8pK+L5WmPt3sVp5u2vk9PZZiZs1QCFLUmncHFkwwzwxH5wlgjuYxngbBtNMwt43wuADtjOft+6409/AOWAEtQNfh0uKP4XGDVrjDPnenctLpHgOZHyipX0OkMu92uB6jsxdgv61YP/SxQK85HkDx9rqgcEkbjf3CVHPGr4RNa+RvmV2viOeEoNdBqxuYEWoNiTbm52bsV6BHl61iakU82JQ9A4HAgT+9+Q4xYdpHl6ZbJ2utbxqy0NBIl29URjZ34GnO7btAsT1RYNuqiUC8jz25+ByLjJTc2NC+9fgxgmSvuf83nZB4My9OX/jG3Jiag75xyfKiDlDHrI9uvpXwrBT0HYr1Uj0tc/qjhkpIO7sqwkarP0tDHE2+nb9jxFhYJOcyBBgbV7QAWePzShlEJe0RPB8XcmXDym0EyuX1Qa4gwyjRdF+DLGKwRzGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(7416002)(186003)(6506007)(82960400001)(86362001)(8676002)(6512007)(6666004)(83380400001)(38100700002)(8936002)(66556008)(30864003)(54906003)(5660300002)(2906002)(6486002)(316002)(36756003)(2616005)(66946007)(26005)(1076003)(4326008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzRkeGZyOEVOWmFuakRBVmJRL2ErQU1xRXVGMUZlNzRoWGVrUjNlcVBxQXFr?=
 =?utf-8?B?ZEJScTZEcVhvWE5KNCtQTVFMQ3JtUkY2dW9tUlFJdmNib0dpVE1aTHFKYmUw?=
 =?utf-8?B?MFByL0tsR2poTDliV3ZHRi9Wd0hiMldKZ1JBcFhLaEphQU9BMDlSUEVCV2tV?=
 =?utf-8?B?UGtrMzROQmFLU0VuVi9TdFBTZmxKRXRUQTNEQ2tvWW5YcWtXdE5WaERqY0FW?=
 =?utf-8?B?SGNYVW15VGduU2VmdGw0TjIyK1JCU251Y1RTajZGM3VCbkN6V0RTUk9JVEhz?=
 =?utf-8?B?dHkxTXlocCtLTDFlVGx1bmo2eEo3VEw0eU9ORStkWFhsVTF3cWVLNlNvTTVi?=
 =?utf-8?B?M3l6ZWR0WDVKTnpZakpGT2Mxd1BiL0dCN0lzeVpMWGNMSjA1RmwvMWxiaUVH?=
 =?utf-8?B?dzhUV0FRV2FTU2FzN1JDdktMMkIybFoybGhzTW1rN1pXRlpBNGg2V0dRY2Nl?=
 =?utf-8?B?UHpxcnNIdnhSaFhGU1JQMkk5WXJYaWdzdWd6WXVNakN2WElDcTNBcE5yaUJ6?=
 =?utf-8?B?VkIwR1V5d1RHU2IyRnhBTFEvQmJ5VXpVOXRnWEJleDdIanNHTXgvN20rQ3I0?=
 =?utf-8?B?Zm4yNTBqMk1YM2UrVEorS1ZVVVQ4cWFoQnNPL0Vnd3BydGVnY09OeUxZZElz?=
 =?utf-8?B?c0VOK2lkWkxHd3pQNFdLQnZHRFk5MmVPOXZNMEMzU3ViNHRHNXI4VmUxcUhN?=
 =?utf-8?B?dXc3eDgrMDZFK2RLdU84SkhueklFTE8wc21sdE9MejBSSGZuTHhQelFTLzRk?=
 =?utf-8?B?alAzS1krQUtwQ1gxOGVPYkFBSmk0aSs2NVBQTCtzemgremlDYmpuQnZuRXBr?=
 =?utf-8?B?a3MzRlg1dkk0WFJFZjdUeUxOUVJnMFdPeHAwekZNVVl0eUE1THVLY0M0SWk2?=
 =?utf-8?B?Y1JVYUFuTzJGK2J0RnpyN0YySDJ6Z0V6U01DTXZBdTB3VFNpbGhDUkpmeXVX?=
 =?utf-8?B?T0wrSXRrVnRTV24wbE9jZXl6ZmNTV1JvTWJocitTRnlKV2MvUzdvOTQ1R25h?=
 =?utf-8?B?dTNiNm0wMVZnTm9pWWtTZkxlRWRyakVubisrbExTeEhjOGV5M1VOZ2I1VEhQ?=
 =?utf-8?B?SmwvMVJPU2llYXhMa3djdThXS0FvaGphTkNDZFVvb1IzL3FNUXNwcDNVSHZx?=
 =?utf-8?B?T2xkYVAralovZHRCZ0NFWHIyQUQrZ2RrbDc4NWRiR1ZPRWc1OXIzY1dMdHRU?=
 =?utf-8?B?N0NWMkRvVnY2Ti9DSjBNdTdZN1pRdGtPNVAzalBNRVNNTlFHcGxiRnBMczZI?=
 =?utf-8?B?Ym80Z24vbEFzckIwUi9lY0xQOW90TVI4dnlKa0xnNnVueTFmKzIrem45ZDJp?=
 =?utf-8?B?akZJb3NUVXErVGhYMUlwODZTZTVzSWMzN2hUYUNCMVNReHdkYUd0VzFMendi?=
 =?utf-8?B?OUs1SHBLN3NlTFdUcnV2ZkxwNHZJMWcxa2pBL3c0MVJLMTFkL01PSjJFK0Er?=
 =?utf-8?B?YzhwOWFiU0FpM2F4bkFuenY3RDhmN2J5Q0tjUTRYZzQ3c3YzNmkyL053VTNo?=
 =?utf-8?B?bERaQ1IrY2hyS0NTZ0E0Rm04ZEp0VlVCUEk4dEJQNEptQjRDZTJ1YkEvZzVO?=
 =?utf-8?B?V0N5cDBPV2k0WDlyb0JhRUJlQjJrT09kY1FZSTBzY3lDUmZpOGlFZUlFY1NP?=
 =?utf-8?B?TGRnZnNFYTM5V0kyOEpRYld6ZlZmOVBVQlVYU2ZaM0pWclZaZ2o1MmZyMVJq?=
 =?utf-8?B?MVVFSEZUbzRBRE5EZURJd0NUZUJsUExsd09xWUNWMTN6RjdWTy9HTWpzdUMx?=
 =?utf-8?B?bkhOMzkydkY3b003R3IzUS9zSHdLc2lFS1d2K2JELzVHazVJMVVpWnRYS09h?=
 =?utf-8?B?cXNLbjF3NmFnanRjSjU2Y3RNVGlQMTRBUTBaSm03QW9KRzQ3NkZwR1NZckVw?=
 =?utf-8?B?UUpGK0FyU1FwK2szVEpQQW9rME5aTDRVZituTlptci9KVWxqVmlWeFZwdTFC?=
 =?utf-8?B?b1RQcWdzWlgvQlJGajd1SXFmd1cremlsSkZoQWN4aDd5cnlneUg5WS9mMVUz?=
 =?utf-8?B?SVZGZk5YUm9lNHYvTVI5dm1FbERNNFhudUxhaVduNm1mdFRRYUJIQWxJZ1FU?=
 =?utf-8?B?L0J6ODBCaGdTSE1lQllnT2ZjVit0VW81ZkRncEdwL0ZUeUI2MHJBTHF4alhh?=
 =?utf-8?B?aUtFMms0cTlRb1JiMTZ2dzd3MWJWenVnQW1tVkMvalphRXl3dkhvQ3BOeTlE?=
 =?utf-8?B?ZGFIVE9zcHJGVmhCYU15aVhpTFNHVUZLdTFQQzJuamhUVmhaOTZpT1JLWlQy?=
 =?utf-8?B?YW5JaWYvU3JobytlbENwUk1mdW1nPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2fc346-6551-4805-3bfb-08d9da1077ca
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 23:24:11.5741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nYBgYqBITnPlsBI8YPsfkye92+RW18dVR0ZhyTDA+TZmXA4lbU0g47/BXs8sLqihIkCL4QjvO1Ee15izePK8+QTzIom4smq8mjPHtiZPXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4140
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Tests were converted into parameterized test cases.
Negative tests were separated. Mocking was moved to test->init().
No functional changes.

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
---
 drivers/gpu/drm/Kconfig                       |   1 +
 drivers/gpu/drm/selftests/Makefile            |   4 +-
 .../gpu/drm/selftests/drm_modeset_selftests.h |   1 -
 .../drm/selftests/test-drm_modeset_common.h   |   1 -
 .../gpu/drm/selftests/test-drm_plane_helper.c | 483 +++++++++++-------
 5 files changed, 289 insertions(+), 201 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 21e329f32997..89be0df7b0e9 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -83,6 +83,7 @@ config DRM_DEBUG_SELFTEST
 config DRM_KUNIT_TEST
 	bool "DRM tests" if !KUNIT_ALL_TESTS
 	depends on DRM=y && KUNIT=y
+	select DRM_KMS_HELPER
 	default KUNIT_ALL_TESTS
 	help
 	  Enables unit tests for DRM. Only useful for kernel devs running KUnit.
diff --git a/drivers/gpu/drm/selftests/Makefile b/drivers/gpu/drm/selftests/Makefile
index 6411c9a957b3..82e568665ace 100644
--- a/drivers/gpu/drm/selftests/Makefile
+++ b/drivers/gpu/drm/selftests/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test-drm_modeset-$(CONFIG_DRM_DEBUG_SELFTEST) := \
-		      test-drm_modeset_common.o test-drm_plane_helper.o \
+		      test-drm_modeset_common.o \
                       test-drm_format.o test-drm_framebuffer.o \
 		      test-drm_damage_helper.o test-drm_dp_mst_helper.o \
 		      test-drm_rect.o
@@ -8,4 +8,4 @@ test-drm_modeset-$(CONFIG_DRM_DEBUG_SELFTEST) := \
 obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o test-drm_modeset.o
 
 obj-$(CONFIG_DRM_KUNIT_TEST) := \
-	test-drm_cmdline_parser.o
+	test-drm_cmdline_parser.o test-drm_plane_helper.o
diff --git a/drivers/gpu/drm/selftests/drm_modeset_selftests.h b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
index 782e285ca383..19d1142725c6 100644
--- a/drivers/gpu/drm/selftests/drm_modeset_selftests.h
+++ b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
@@ -10,7 +10,6 @@ selftest(drm_rect_clip_scaled_div_by_zero, igt_drm_rect_clip_scaled_div_by_zero)
 selftest(drm_rect_clip_scaled_not_clipped, igt_drm_rect_clip_scaled_not_clipped)
 selftest(drm_rect_clip_scaled_clipped, igt_drm_rect_clip_scaled_clipped)
 selftest(drm_rect_clip_scaled_signed_vs_unsigned, igt_drm_rect_clip_scaled_signed_vs_unsigned)
-selftest(check_plane_state, igt_check_plane_state)
 selftest(check_drm_format_block_width, igt_check_drm_format_block_width)
 selftest(check_drm_format_block_height, igt_check_drm_format_block_height)
 selftest(check_drm_format_min_pitch, igt_check_drm_format_min_pitch)
diff --git a/drivers/gpu/drm/selftests/test-drm_modeset_common.h b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
index cfb51d8da2bc..8744fd840406 100644
--- a/drivers/gpu/drm/selftests/test-drm_modeset_common.h
+++ b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
@@ -20,7 +20,6 @@ int igt_drm_rect_clip_scaled_div_by_zero(void *ignored);
 int igt_drm_rect_clip_scaled_not_clipped(void *ignored);
 int igt_drm_rect_clip_scaled_clipped(void *ignored);
 int igt_drm_rect_clip_scaled_signed_vs_unsigned(void *ignored);
-int igt_check_plane_state(void *ignored);
 int igt_check_drm_format_block_width(void *ignored);
 int igt_check_drm_format_block_height(void *ignored);
 int igt_check_drm_format_min_pitch(void *ignored);
diff --git a/drivers/gpu/drm/selftests/test-drm_plane_helper.c b/drivers/gpu/drm/selftests/test-drm_plane_helper.c
index ceebeede55ea..f2c0cd37a949 100644
--- a/drivers/gpu/drm/selftests/test-drm_plane_helper.c
+++ b/drivers/gpu/drm/selftests/test-drm_plane_helper.c
@@ -3,221 +3,310 @@
  * Test cases for the drm_plane_helper functions
  */
 
-#define pr_fmt(fmt) "drm_plane_helper: " fmt
+#include <kunit/test.h>
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_modes.h>
 
-#include "test-drm_modeset_common.h"
-
-static void set_src(struct drm_plane_state *plane_state,
-		    unsigned src_x, unsigned src_y,
-		    unsigned src_w, unsigned src_h)
+static void expect_src_eq(struct kunit *test, struct drm_plane_state *plane_state,
+			  unsigned int src_x, unsigned int src_y,
+			  unsigned int src_w, unsigned int src_h)
 {
-	plane_state->src_x = src_x;
-	plane_state->src_y = src_y;
-	plane_state->src_w = src_w;
-	plane_state->src_h = src_h;
+	KUNIT_EXPECT_GE_MSG(test, plane_state->src.x1, 0,
+			    "src x coordinate %x should never be below 0, src: " DRM_RECT_FP_FMT,
+			    plane_state->src.x1, DRM_RECT_FP_ARG(&plane_state->src));
+	KUNIT_EXPECT_GE_MSG(test, plane_state->src.y1, 0,
+			    "src y coordinate %x should never be below 0, src: " DRM_RECT_FP_FMT,
+			    plane_state->src.y1, DRM_RECT_FP_ARG(&plane_state->src));
+
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      plane_state->src.x1 == src_x &&
+			      plane_state->src.y1 == src_y &&
+			      drm_rect_width(&plane_state->src) == src_w &&
+			      drm_rect_height(&plane_state->src) == src_h,
+			      "src: " DRM_RECT_FP_FMT, DRM_RECT_FP_ARG(&plane_state->src));
 }
 
-static bool check_src_eq(struct drm_plane_state *plane_state,
-			 unsigned src_x, unsigned src_y,
-			 unsigned src_w, unsigned src_h)
+static void expect_crtc_eq(struct kunit *test, struct drm_plane_state *plane_state,
+			   int crtc_x, int crtc_y,
+			   unsigned int crtc_w, unsigned int crtc_h)
 {
-	if (plane_state->src.x1 < 0) {
-		pr_err("src x coordinate %x should never be below 0.\n", plane_state->src.x1);
-		drm_rect_debug_print("src: ", &plane_state->src, true);
-		return false;
-	}
-	if (plane_state->src.y1 < 0) {
-		pr_err("src y coordinate %x should never be below 0.\n", plane_state->src.y1);
-		drm_rect_debug_print("src: ", &plane_state->src, true);
-		return false;
-	}
-
-	if (plane_state->src.x1 != src_x ||
-	    plane_state->src.y1 != src_y ||
-	    drm_rect_width(&plane_state->src) != src_w ||
-	    drm_rect_height(&plane_state->src) != src_h) {
-		drm_rect_debug_print("src: ", &plane_state->src, true);
-		return false;
-	}
-
-	return true;
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      plane_state->dst.x1 == crtc_x &&
+			      plane_state->dst.y1 == crtc_y &&
+			      drm_rect_width(&plane_state->dst) == crtc_w &&
+			      drm_rect_height(&plane_state->dst) == crtc_h,
+			      "dst: " DRM_RECT_FMT, DRM_RECT_ARG(&plane_state->dst));
 }
 
-static void set_crtc(struct drm_plane_state *plane_state,
-		     int crtc_x, int crtc_y,
-		     unsigned crtc_w, unsigned crtc_h)
+const struct drm_crtc_state crtc_state = {
+	.crtc = ZERO_SIZE_PTR,
+	.enable = true,
+	.active = true,
+	.mode = {
+		DRM_MODE("1024x768", 0, 65000, 1024, 1048,
+			 1184, 1344, 0, 768, 771, 777, 806, 0,
+			 DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC)
+	},
+};
+
+struct drm_check_plane_state_test {
+	const char *name;
+	const char *msg;
+	struct {
+		unsigned int x;
+		unsigned int y;
+		unsigned int w;
+		unsigned int h;
+	} src, src_expected;
+	struct {
+		int x;
+		int y;
+		unsigned int w;
+		unsigned int h;
+	} crtc, crtc_expected;
+	unsigned int rotation;
+	int min_scale;
+	int max_scale;
+	bool can_position;
+};
+
+static int drm_plane_helper_init(struct kunit *test)
 {
-	plane_state->crtc_x = crtc_x;
-	plane_state->crtc_y = crtc_y;
-	plane_state->crtc_w = crtc_w;
-	plane_state->crtc_h = crtc_h;
+	const struct drm_check_plane_state_test *params = test->param_value;
+	struct drm_plane *plane;
+	struct drm_framebuffer *fb;
+	struct drm_plane_state *mock;
+
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane);
+
+	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fb);
+	fb->width = 2048;
+	fb->height = 2048;
+
+	mock = kunit_kzalloc(test, sizeof(*mock), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mock);
+	mock->plane = plane;
+	mock->crtc = ZERO_SIZE_PTR;
+	mock->fb = fb;
+	mock->rotation = params->rotation;
+	mock->src_x = params->src.x;
+	mock->src_y = params->src.y;
+	mock->src_w = params->src.w;
+	mock->src_h = params->src.h;
+	mock->crtc_x = params->crtc.x;
+	mock->crtc_y = params->crtc.y;
+	mock->crtc_w = params->crtc.w;
+	mock->crtc_h = params->crtc.h;
+
+	test->priv = mock;
+
+	return 0;
 }
 
-static bool check_crtc_eq(struct drm_plane_state *plane_state,
-			  int crtc_x, int crtc_y,
-			  unsigned crtc_w, unsigned crtc_h)
+void drm_check_plane_state(struct kunit *test)
 {
-	if (plane_state->dst.x1 != crtc_x ||
-	    plane_state->dst.y1 != crtc_y ||
-	    drm_rect_width(&plane_state->dst) != crtc_w ||
-	    drm_rect_height(&plane_state->dst) != crtc_h) {
-		drm_rect_debug_print("dst: ", &plane_state->dst, false);
-
-		return false;
-	}
+	const struct drm_check_plane_state_test *params = test->param_value;
+	struct drm_plane_state *plane_state = test->priv;
 
-	return true;
+	KUNIT_ASSERT_EQ_MSG(test,
+			    drm_atomic_helper_check_plane_state(plane_state, &crtc_state,
+								params->min_scale,
+								params->max_scale,
+								params->can_position, false),
+			    0, params->msg);
+	KUNIT_EXPECT_TRUE(test, plane_state->visible);
+	expect_src_eq(test, plane_state, params->src_expected.x, params->src_expected.y,
+		      params->src_expected.w, params->src_expected.h);
+	expect_crtc_eq(test, plane_state, params->crtc_expected.x, params->crtc_expected.y,
+		       params->crtc_expected.w, params->crtc_expected.h);
 }
 
-int igt_check_plane_state(void *ignored)
+void drm_check_invalid_plane_state(struct kunit *test)
 {
-	int ret;
-
-	const struct drm_crtc_state crtc_state = {
-		.crtc = ZERO_SIZE_PTR,
-		.enable = true,
-		.active = true,
-		.mode = {
-			DRM_MODE("1024x768", 0, 65000, 1024, 1048,
-				1184, 1344, 0, 768, 771, 777, 806, 0,
-				DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC)
-		},
-	};
-	struct drm_plane plane = {
-		.dev = NULL
-	};
-	struct drm_framebuffer fb = {
-		.width = 2048,
-		.height = 2048
-	};
-	struct drm_plane_state plane_state = {
-		.plane = &plane,
-		.crtc = ZERO_SIZE_PTR,
-		.fb = &fb,
-		.rotation = DRM_MODE_ROTATE_0
-	};
-
-	/* Simple clipping, no scaling. */
-	set_src(&plane_state, 0, 0, fb.width << 16, fb.height << 16);
-	set_crtc(&plane_state, 0, 0, fb.width, fb.height);
-	ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
-						  DRM_PLANE_HELPER_NO_SCALING,
-						  DRM_PLANE_HELPER_NO_SCALING,
-						  false, false);
-	FAIL(ret < 0, "Simple clipping check should pass\n");
-	FAIL_ON(!plane_state.visible);
-	FAIL_ON(!check_src_eq(&plane_state, 0, 0, 1024 << 16, 768 << 16));
-	FAIL_ON(!check_crtc_eq(&plane_state, 0, 0, 1024, 768));
-
-	/* Rotated clipping + reflection, no scaling. */
-	plane_state.rotation = DRM_MODE_ROTATE_90 | DRM_MODE_REFLECT_X;
-	ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
-						  DRM_PLANE_HELPER_NO_SCALING,
-						  DRM_PLANE_HELPER_NO_SCALING,
-						  false, false);
-	FAIL(ret < 0, "Rotated clipping check should pass\n");
-	FAIL_ON(!plane_state.visible);
-	FAIL_ON(!check_src_eq(&plane_state, 0, 0, 768 << 16, 1024 << 16));
-	FAIL_ON(!check_crtc_eq(&plane_state, 0, 0, 1024, 768));
-	plane_state.rotation = DRM_MODE_ROTATE_0;
-
-	/* Check whether positioning works correctly. */
-	set_src(&plane_state, 0, 0, 1023 << 16, 767 << 16);
-	set_crtc(&plane_state, 0, 0, 1023, 767);
-	ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
-						  DRM_PLANE_HELPER_NO_SCALING,
-						  DRM_PLANE_HELPER_NO_SCALING,
-						  false, false);
-	FAIL(!ret, "Should not be able to position on the crtc with can_position=false\n");
-
-	ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
-						  DRM_PLANE_HELPER_NO_SCALING,
-						  DRM_PLANE_HELPER_NO_SCALING,
-						  true, false);
-	FAIL(ret < 0, "Simple positioning should work\n");
-	FAIL_ON(!plane_state.visible);
-	FAIL_ON(!check_src_eq(&plane_state, 0, 0, 1023 << 16, 767 << 16));
-	FAIL_ON(!check_crtc_eq(&plane_state, 0, 0, 1023, 767));
-
-	/* Simple scaling tests. */
-	set_src(&plane_state, 0, 0, 512 << 16, 384 << 16);
-	set_crtc(&plane_state, 0, 0, 1024, 768);
-	ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
-						  0x8001,
-						  DRM_PLANE_HELPER_NO_SCALING,
-						  false, false);
-	FAIL(!ret, "Upscaling out of range should fail.\n");
-	ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
-						  0x8000,
-						  DRM_PLANE_HELPER_NO_SCALING,
-						  false, false);
-	FAIL(ret < 0, "Upscaling exactly 2x should work\n");
-	FAIL_ON(!plane_state.visible);
-	FAIL_ON(!check_src_eq(&plane_state, 0, 0, 512 << 16, 384 << 16));
-	FAIL_ON(!check_crtc_eq(&plane_state, 0, 0, 1024, 768));
-
-	set_src(&plane_state, 0, 0, 2048 << 16, 1536 << 16);
-	ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
-						  DRM_PLANE_HELPER_NO_SCALING,
-						  0x1ffff, false, false);
-	FAIL(!ret, "Downscaling out of range should fail.\n");
-	ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
-						  DRM_PLANE_HELPER_NO_SCALING,
-						  0x20000, false, false);
-	FAIL(ret < 0, "Should succeed with exact scaling limit\n");
-	FAIL_ON(!plane_state.visible);
-	FAIL_ON(!check_src_eq(&plane_state, 0, 0, 2048 << 16, 1536 << 16));
-	FAIL_ON(!check_crtc_eq(&plane_state, 0, 0, 1024, 768));
-
-	/* Testing rounding errors. */
-	set_src(&plane_state, 0, 0, 0x40001, 0x40001);
-	set_crtc(&plane_state, 1022, 766, 4, 4);
-	ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
-						  DRM_PLANE_HELPER_NO_SCALING,
-						  0x10001,
-						  true, false);
-	FAIL(ret < 0, "Should succeed by clipping to exact multiple");
-	FAIL_ON(!plane_state.visible);
-	FAIL_ON(!check_src_eq(&plane_state, 0, 0, 2 << 16, 2 << 16));
-	FAIL_ON(!check_crtc_eq(&plane_state, 1022, 766, 2, 2));
-
-	set_src(&plane_state, 0x20001, 0x20001, 0x4040001, 0x3040001);
-	set_crtc(&plane_state, -2, -2, 1028, 772);
-	ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
-						  DRM_PLANE_HELPER_NO_SCALING,
-						  0x10001,
-						  false, false);
-	FAIL(ret < 0, "Should succeed by clipping to exact multiple");
-	FAIL_ON(!plane_state.visible);
-	FAIL_ON(!check_src_eq(&plane_state, 0x40002, 0x40002, 1024 << 16, 768 << 16));
-	FAIL_ON(!check_crtc_eq(&plane_state, 0, 0, 1024, 768));
-
-	set_src(&plane_state, 0, 0, 0x3ffff, 0x3ffff);
-	set_crtc(&plane_state, 1022, 766, 4, 4);
-	ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
-						  0xffff,
-						  DRM_PLANE_HELPER_NO_SCALING,
-						  true, false);
-	FAIL(ret < 0, "Should succeed by clipping to exact multiple");
-	FAIL_ON(!plane_state.visible);
-	/* Should not be rounded to 0x20001, which would be upscaling. */
-	FAIL_ON(!check_src_eq(&plane_state, 0, 0, 2 << 16, 2 << 16));
-	FAIL_ON(!check_crtc_eq(&plane_state, 1022, 766, 2, 2));
-
-	set_src(&plane_state, 0x1ffff, 0x1ffff, 0x403ffff, 0x303ffff);
-	set_crtc(&plane_state, -2, -2, 1028, 772);
-	ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
-						  0xffff,
-						  DRM_PLANE_HELPER_NO_SCALING,
-						  false, false);
-	FAIL(ret < 0, "Should succeed by clipping to exact multiple");
-	FAIL_ON(!plane_state.visible);
-	FAIL_ON(!check_src_eq(&plane_state, 0x3fffe, 0x3fffe, 1024 << 16, 768 << 16));
-	FAIL_ON(!check_crtc_eq(&plane_state, 0, 0, 1024, 768));
+	const struct drm_check_plane_state_test *params = test->param_value;
+	struct drm_plane_state *plane_state = test->priv;
 
-	return 0;
+	KUNIT_ASSERT_LT_MSG(test,
+			    drm_atomic_helper_check_plane_state(plane_state, &crtc_state,
+								params->min_scale,
+								params->max_scale,
+								params->can_position, false),
+			    0, params->msg);
+}
+
+static const struct drm_check_plane_state_test drm_check_plane_state_tests[] = {
+	{
+		.name = "clipping_simple",
+		.msg = "Simple clipping check should pass",
+		.src = { 0, 0,
+			 2048 << 16,
+			 2048 << 16 },
+		.crtc = { 0, 0, 2048, 2048 },
+		.rotation = DRM_MODE_ROTATE_0,
+		.min_scale = DRM_PLANE_HELPER_NO_SCALING,
+		.max_scale = DRM_PLANE_HELPER_NO_SCALING,
+		.can_position = false,
+		.src_expected = { 0, 0, 1024 << 16, 768 << 16 },
+		.crtc_expected = { 0, 0, 1024, 768 },
+	},
+	{
+		.name = "clipping_rotate_reflect",
+		.msg = "Rotated clipping check should pass",
+		.src = { 0, 0,
+			 2048 << 16,
+			 2048 << 16 },
+		.crtc = { 0, 0, 2048, 2048 },
+		.rotation = DRM_MODE_ROTATE_90 | DRM_MODE_REFLECT_X,
+		.min_scale = DRM_PLANE_HELPER_NO_SCALING,
+		.max_scale = DRM_PLANE_HELPER_NO_SCALING,
+		.can_position = false,
+		.src_expected = { 0, 0, 768 << 16, 1024 << 16 },
+		.crtc_expected = { 0, 0, 1024, 768 },
+	},
+	{
+		.name = "positioning_simple",
+		.msg = "Simple positioning should work",
+		.src = { 0, 0, 1023 << 16, 767 << 16 },
+		.crtc = { 0, 0, 1023, 767 },
+		.rotation = DRM_MODE_ROTATE_0,
+		.min_scale = DRM_PLANE_HELPER_NO_SCALING,
+		.max_scale = DRM_PLANE_HELPER_NO_SCALING,
+		.can_position = true,
+		.src_expected = { 0, 0, 1023 << 16, 767 << 16 },
+		.crtc_expected = { 0, 0, 1023, 767 },
+	},
+	{
+		.name = "upscaling",
+		.msg = "Upscaling exactly 2x should work",
+		.src = { 0, 0, 512 << 16, 384 << 16 },
+		.crtc = { 0, 0, 1024, 768 },
+		.rotation = DRM_MODE_ROTATE_0,
+		.min_scale = 0x8000,
+		.max_scale = DRM_PLANE_HELPER_NO_SCALING,
+		.can_position = false,
+		.src_expected = { 0, 0, 512 << 16, 384 << 16 },
+		.crtc_expected = { 0, 0, 1024, 768 },
+	},
+	{
+		.name = "downscaling",
+		.msg = "Should succeed with exact scaling limit",
+		.src = { 0, 0, 2048 << 16, 1536 << 16 },
+		.crtc = { 0, 0, 1024, 768 },
+		.rotation = DRM_MODE_ROTATE_0,
+		.min_scale = DRM_PLANE_HELPER_NO_SCALING,
+		.max_scale = 0x20000,
+		.can_position = false,
+		.src_expected = { 0, 0, 2048 << 16, 1536 << 16 },
+		.crtc_expected = { 0, 0, 1024, 768 },
+	},
+	{
+		.name = "rounding1",
+		.msg = "Should succeed by clipping to exact multiple",
+		.src = { 0, 0, 0x40001, 0x40001 },
+		.crtc = { 1022, 766, 4, 4 },
+		.rotation = DRM_MODE_ROTATE_0,
+		.min_scale = DRM_PLANE_HELPER_NO_SCALING,
+		.max_scale = 0x10001,
+		.can_position = true,
+		.src_expected = { 0, 0, 2 << 16, 2 << 16 },
+		.crtc_expected = { 1022, 766, 2, 2 },
+	},
+	{
+		.name = "rounding2",
+		.msg = "Should succeed by clipping to exact multiple",
+		.src = { 0x20001, 0x20001, 0x4040001, 0x3040001 },
+		.crtc = { -2, -2, 1028, 772 },
+		.rotation = DRM_MODE_ROTATE_0,
+		.min_scale = DRM_PLANE_HELPER_NO_SCALING,
+		.max_scale = 0x10001,
+		.can_position = false,
+		.src_expected = { 0x40002, 0x40002, 1024 << 16, 768 << 16 },
+		.crtc_expected = { 0, 0, 1024, 768 },
+	},
+	{
+		.name = "rounding3",
+		.msg = "Should succeed by clipping to exact multiple",
+		.src = { 0, 0, 0x3ffff, 0x3ffff },
+		.crtc = { 1022, 766, 4, 4 },
+		.rotation = DRM_MODE_ROTATE_0,
+		.min_scale = 0xffff,
+		.max_scale = DRM_PLANE_HELPER_NO_SCALING,
+		.can_position = true,
+		/* Should not be rounded to 0x20001, which would be upscaling. */
+		.src_expected = { 0, 0, 2 << 16, 2 << 16 },
+		.crtc_expected = { 1022, 766, 2, 2 },
+	},
+	{
+		.name = "rounding4",
+		.msg = "Should succeed by clipping to exact multiple",
+		.src = { 0x1ffff, 0x1ffff, 0x403ffff, 0x303ffff },
+		.crtc = { -2, -2, 1028, 772 },
+		.rotation = DRM_MODE_ROTATE_0,
+		.min_scale = 0xffff,
+		.max_scale = DRM_PLANE_HELPER_NO_SCALING,
+		.can_position = false,
+		.src_expected = { 0x3fffe, 0x3fffe, 1024 << 16, 768 << 16 },
+		.crtc_expected = { 0, 0, 1024, 768 },
+	},
+};
+
+static const struct drm_check_plane_state_test drm_check_invalid_plane_state_tests[] = {
+	{
+		.name = "positioning_invalid",
+		.msg = "Should not be able to position on the crtc with can_position=false",
+		.src = { 0, 0, 1023 << 16, 767 << 16 },
+		.crtc = { 0, 0, 1023, 767 },
+		.rotation = DRM_MODE_ROTATE_0,
+		.min_scale = DRM_PLANE_HELPER_NO_SCALING,
+		.max_scale = DRM_PLANE_HELPER_NO_SCALING,
+		.can_position = false,
+	},
+	{
+		.name = "upscaling_invalid",
+		.msg = "Upscaling out of range should fail",
+		.src = { 0, 0, 512 << 16, 384 << 16 },
+		.crtc = { 0, 0, 1024, 768 },
+		.rotation = DRM_MODE_ROTATE_0,
+		.min_scale = 0x8001,
+		.max_scale = DRM_PLANE_HELPER_NO_SCALING,
+		.can_position = false,
+	},
+	{
+		.name = "downscaling_invalid",
+		.msg = "Downscaling out of range should fail",
+		.src = { 0, 0, 2048 << 16, 1536 << 16 },
+		.crtc = { 0, 0, 1024, 768 },
+		.rotation = DRM_MODE_ROTATE_0,
+		.min_scale = DRM_PLANE_HELPER_NO_SCALING,
+		.max_scale = 0x1ffff,
+		.can_position = false,
+	},
+};
+
+static void drm_check_plane_state_desc(const struct drm_check_plane_state_test *t,
+				       char *desc)
+{
+	sprintf(desc, "%s", t->name);
 }
+
+KUNIT_ARRAY_PARAM(drm_check_plane_state, drm_check_plane_state_tests, drm_check_plane_state_desc);
+KUNIT_ARRAY_PARAM(drm_check_invalid_plane_state, drm_check_invalid_plane_state_tests,
+		  drm_check_plane_state_desc);
+
+static struct kunit_case drm_plane_helper_tests[] = {
+	KUNIT_CASE_PARAM(drm_check_plane_state, drm_check_plane_state_gen_params),
+	KUNIT_CASE_PARAM(drm_check_invalid_plane_state, drm_check_invalid_plane_state_gen_params),
+	{}
+};
+
+static struct kunit_suite drm_plane_helper_test_suite = {
+	.name = "drm_plane_helper_tests",
+	.init = drm_plane_helper_init,
+	.test_cases = drm_plane_helper_tests,
+};
+
+kunit_test_suite(drm_plane_helper_test_suite);
-- 
2.34.1

