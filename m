Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D0B49124F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 00:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243794AbiAQXYc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jan 2022 18:24:32 -0500
Received: from mga17.intel.com ([192.55.52.151]:36575 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243793AbiAQXYb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jan 2022 18:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642461871; x=1673997871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=6ro2lSA7hpfMrYO7xKE+6JLlzdljkSfgu8tKCG0dnro=;
  b=A4GR9rxxkMMJzHGqNG2bKgkrLVM9/zXkloUUUhzzWfhhk65uFvISbBBc
   rmWL3WJmyHRmVy3FWJdrECBJFQWKuz+RQrDFXNF7Gl+oJA6A2j8tiau6M
   hN0ZQm4sBjTkZwKt2EfNdFpASLoLdSr9p23iJR016B3+BY25UtSp6XsZI
   CQpacD+aw+yuKHcfItpG70M0uiQ91nd1gIpARV64SsRurG00XiTUhQNHq
   CK/CcZUtSeKk3GWLGgtx62DGkdjsMJS18mVd7hTnPeyXam2mH1UNmF8eT
   Xqhxs36js4cX0hP94s6kZBIWdkz+PQZkiXXmXCO2aD0lixnNNAAj6GBJr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="225384350"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="225384350"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 15:24:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="474580654"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 17 Jan 2022 15:24:31 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 17 Jan 2022 15:24:30 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 17 Jan 2022 15:24:30 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 17 Jan 2022 15:24:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8yZPYS3WG7uNRk02IKjRfwdiS+ZWO6J1i9K7CeljYYlY1x3OsLFnl0+sodVkFCEm59F2vb2+FpjkO0qdMiZknlyJT2vC2GAqDzvAP7IQfrsAckhLAC9Nu2eVifRRngXzXxk+lRctYHbMGxCznL1cG8cJjiivG85wOoasIMR5yO4UXakMY/PRHA6gbn9FXc3Av7KHZQap8MPHmnt08IiU6bokJ5FwYqbtJE4I+PNWJcgsBdeKnd2xA1kt8Bk/7WFwYhP5JoAReFjIYTkGGNIbhqBcD3ATeRXPvncT9VKyiUtWwiL02EAPpU03CnCfJlawDdmQTFB5dYvsfIb+j+lvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+0w12oZdbhV960T8HqB6zptTXT0vzEbEfPf+5/egbs=;
 b=Iwff3E1mPDtZIgHiOYclZo3FTiA8BSrzWPSi2dq2Gwp5Vpnfu0Lvl+UyKoAn3/wFrE9p3/k5hjM0yuButX3wG6SpvLJIBvy2uQI7mgVcD7zq1Ef4k60ZfgKn2ftG0nK9mfGpLV5JPhF/2dMZxLrjBXE7VkAw26fKQUvb3LKL5P4Z31VgkM6rHLm83Lxrkgjq8MDUVSZSHFr5wSjNOy/umo7NScDfOYYfGv5XMiPVpUsFEOFfoFfdtfoam3UYQC9nVOhSkZvXuxJkUfcdISSmicANBup4x7syMWcRJ3YfYYG+9ycXjaDLVzPkApxPpstwsvWZy4qqNFkBqiwTgMSaBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 DM4PR11MB5550.namprd11.prod.outlook.com (2603:10b6:5:38b::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.9; Mon, 17 Jan 2022 23:24:22 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::fc15:bd26:128a:f5f5]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::fc15:bd26:128a:f5f5%8]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 23:24:22 +0000
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
Subject: [RFC 04/10] drm: test-drm_framebuffer: Convert to KUnit
Date:   Tue, 18 Jan 2022 00:22:53 +0100
Message-ID: <20220117232259.180459-5-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117232259.180459-1-michal.winiarski@intel.com>
References: <20220117232259.180459-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0310.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::34) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ac34f83-9d29-44ee-cc29-08d9da107e5b
X-MS-TrafficTypeDiagnostic: DM4PR11MB5550:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM4PR11MB5550FAAC5C1BCA39C24D940098579@DM4PR11MB5550.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:381;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mGywa6Xq6oLHE1NwBCYhYAtMGzFUbt0liYVDTMxDyTwaDDohBmEUw1CAVT+jWqiBzJey2CD6drSXk4NfukSZCqAcwcBaMp9zSATI4wkSEc1rcUMgH4/sFJbbLR17w46Y7iexDTldQAR0hsSX1nd81EY1v6iasnQ8/dLeEOTkvixbXOhuo+sh5QdT3zKuux+sNK+hf7gflrxsD1Ap9lyUr9Nc1Cp0Jf5FezH7LSQhY7Egxyxsp6gx7a+DDXYAvH3y1ZA+IirdAA5YtbIwEebnBeaprr8/9PCs4w1+mCbVetvDdBLEphfWMTTxqdmSieGeI/OqpOH6OnfqA1P0VCFGtiZR9tcAvXaVJfU1iD3DvSJDYcNWEXkW+UcSFJ0+fP1lc71q6338t8bWwBg1zwdunCjFpLWq8qHBq3m+H/lFQAWvl/f5AICG0XkUfhdhqiB044Rqrwgu2zzqHl3yHBU3ZqCzlFBotMRCRdiadFjNSAivJeSe1lmxPokZ0JcaZ57fSTC/GytHOFS9HRxvxn7GJ7KHdILXT2MttBgbrStCNF+mhoVHwLyUc+kh+oNtpWfs+GtajyKne/gEz/6oNV8Wz43OTp2cVLuxNJxwZrQWGphBZuZbJXLOxcJRFQNcYrFrGGJUYOax0L3iMBagFOXsPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(82960400001)(4326008)(5660300002)(36756003)(186003)(6506007)(7416002)(1076003)(54906003)(6512007)(83380400001)(26005)(66946007)(66476007)(66556008)(316002)(6486002)(38100700002)(8936002)(508600001)(2906002)(6666004)(8676002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkZQLzFJVTN2eW1GUkVGWjVKNFhQYUxkOHNJUzUvOVdLT2xnU3pQU0U4Z0ZU?=
 =?utf-8?B?a3hLSDhud3llZm85VDU1ajMrYTF5REI5YzRFTUt2MTBtVUJNKzZNdHB2cCty?=
 =?utf-8?B?cEJUb2NEVWt4eVFsU3BIMWhsVGtWemJ1VzlIdGtFV3F2Q1E0aUtHV3ZObUhv?=
 =?utf-8?B?SWRndTNyaWp5aTJ2YUxTaGJOcWZUaEo5OXhLcTFtY2gydjNwdnlDZlB2WFFq?=
 =?utf-8?B?akNMNnpLREFURFVuQm1RNjJySnFSbEE4bHRsQ3Y4cUpidExLTzN1eTJiaUxV?=
 =?utf-8?B?VnAxd21jdWRNY1FvWW1YRXppNWJaTVJjUjE0SE01bHFXaC81bCtYV1lXU0sr?=
 =?utf-8?B?STFVQkdQS0w1bDBtVGNFMXZIa3JWUFdKRmVaUjRsR1dzeUVmWVBkQWUvWGlO?=
 =?utf-8?B?UUVHelk0MFpCT3NPWFVxS2VzU0tPUXhzTWl0SVhueTVnSDBVbXlLOXRnWVRp?=
 =?utf-8?B?enRlc1VsSnlxbU95bWJWbU9mY0E1d3AxNmp3cS9zWVhPUTBOOUM4YXF6V3pP?=
 =?utf-8?B?MStyS3FkNVBDT3BNeUFNeStKTGhpQTVSa1hpby85NnBBU1plc0Y3N1BMRXBU?=
 =?utf-8?B?YUVXN0V1TkRzRFh4bSs0ak1wSERQWkJZbm5JNWVnU0tkTmZkckFDY0RpU2NM?=
 =?utf-8?B?enVBUVUxT1dQdHNlVmRQZmJ1dnkvZkMycjBPVWt0VEFoQVlBRGludVVxaFFD?=
 =?utf-8?B?YXdKNmZSa29zZmRVbTZaRWtCeStVZHIxVW1vNHBoR0tJWlNndXJhdjUzR1F6?=
 =?utf-8?B?L3VvOFY0QkE3V0wvNGQwd2lWcDFpUHdLbWRqMzVqUXV2a09CbXNoSHg4NGxB?=
 =?utf-8?B?SFQzSkp4aEliUjVJWXc4M2VRbVhFTDQzaVB2ai9EU1o1ZDRkMXFxUlZKZmhV?=
 =?utf-8?B?aER5MjRSVi9DWnVYOHo5VmRSeUltbmI0VzBwQnZYc3pyWjBlWHRiZU9oa2wv?=
 =?utf-8?B?eTUyQVVaSFNPVHVXNFRXS1RIRisrYVprYnUyNmpGM29IZndqRW5xcmcyeE5t?=
 =?utf-8?B?R1ZRK256MmFVVnBqUitYVDVKNUhQd1Fsa2FLeERqZGowR25GZlBlRU5OUTRj?=
 =?utf-8?B?OHAvak1BRExJY29lR3g1WjJWQmduQnNWeWtjWVFXOUhtOHplUmg4TlBJZ3hE?=
 =?utf-8?B?YUJ4SkY4VDFMMlBtR1dKZjBRZnk3d0daNWhlOUxNTmxJMTdmVExIdUc2OGJr?=
 =?utf-8?B?L2E2VkFnWUdHM1ZoVi9WZm45aDUrRGppUEJtdUw4N2drY0xkZVB0MG1rdTF4?=
 =?utf-8?B?aHE4bmZrNm0yZFJRTUdOY3JWTzdGZkpaWk82RWZYS1kyYktwemVCY2pONXor?=
 =?utf-8?B?emlSWUZLT05ZMDk5ZmRvcmNZTytkTHJtM0l1ZU1mYk9DV1BjVW9jKzVGekMv?=
 =?utf-8?B?ck1tdzZIWFB6aG52enhWYzVZTE5tdEJHMTZ2Q2N6QTI2d0xCWnpwMjNzYTlv?=
 =?utf-8?B?cVpPVDhmV0NyK3dRb0s0TjRBdGlqdHAvYmpsV1JqaEFiNXhwK0VGQmo3dDYx?=
 =?utf-8?B?WlBPRGlhTzRHQ0pZUjF0c05Od3d2cjAvd3JiNHlDZ0RkekJ3dXZkN05Ja2Jo?=
 =?utf-8?B?eXFhR1JOVzVXVlVPYVJFT0VrTENpQXNxT1c1MlgzL0RRM0JyR1liRGZTUUlz?=
 =?utf-8?B?UC9pUnQ4Y3ZNbmFPNkc0Nzl1VDlVMm5pRXgrQkRkWU9xRmFDeThKblZYUVlM?=
 =?utf-8?B?MVR6eXpvcHNMU1VuK3ZybFNKK3U0eit3TnN1MG9HRnRPSU5SMW84dXdKSFJQ?=
 =?utf-8?B?S0Y5d2ZYYndzSEdtYW5DeGx5dlVXTW5BUTUzMkEyVEhOVExxZWlDUnFOanFk?=
 =?utf-8?B?aUNJK2pya3ZpRFByMUtZY3JpNnlkN3B1aW95V2pJUmt5aWJpUlZlNEM2U1dv?=
 =?utf-8?B?U0dzbTdQMG5FZTQxTGk0aVhDOFBPcEtHaU5XSTh4MThMcHIwb21Cays4L3hN?=
 =?utf-8?B?ZU1ZUWVuRUdDVUwvZ2hBV0FZaGUxMXM1N2YyMURhUUF4UTFkZEhCUFlzWlp6?=
 =?utf-8?B?RUVkUTJTUUVrNmV3YzN5YURKR20zYmYvN2ZBZFdybVNPdDh1VGJwS0dtWHZX?=
 =?utf-8?B?NWNRMktrVDE0bHBjdDFJVFpld1F6NWJtY2V3ZUhncFBBRjBDSWhGV002d21q?=
 =?utf-8?B?WkRVTDZKUjVWRU95R0NxY2I5bktKWlpNbEZGQzV3aGNEczZpS0xOUTVKYnJs?=
 =?utf-8?B?S0s0bHRsWFdtWDVCUW8xQUhPME41Z0xkQjJmYzExTWp2S1Q4cHdheU9hRmxP?=
 =?utf-8?B?TjZ6c1c4bmh2RmRzbHB0SDh6TWFBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac34f83-9d29-44ee-cc29-08d9da107e5b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 23:24:22.5318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epdm6xJikI54BwTdZLdyQzokKsPOXjBUiENGvyopAn/4Kf/rKe5NdIs5rN6uYt3QpRXAn4inHhH6ohZA8beIJx+OwF1kNaZI4/WqknERXnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5550
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Mocking was moved to .init() in order to separate it from test logic.
No functional changes.

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
---
 drivers/gpu/drm/selftests/Makefile            |   3 +-
 .../gpu/drm/selftests/drm_modeset_selftests.h |   1 -
 .../gpu/drm/selftests/test-drm_framebuffer.c  | 109 +++++++++++-------
 .../drm/selftests/test-drm_modeset_common.h   |   1 -
 4 files changed, 68 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/selftests/Makefile b/drivers/gpu/drm/selftests/Makefile
index 76c127613d1a..1235eadca884 100644
--- a/drivers/gpu/drm/selftests/Makefile
+++ b/drivers/gpu/drm/selftests/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test-drm_modeset-$(CONFIG_DRM_DEBUG_SELFTEST) := \
 		      test-drm_modeset_common.o \
-                      test-drm_framebuffer.o \
 		      test-drm_damage_helper.o test-drm_dp_mst_helper.o \
 		      test-drm_rect.o
 
@@ -9,4 +8,4 @@ obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o test-drm_modeset.o
 
 obj-$(CONFIG_DRM_KUNIT_TEST) := \
 	test-drm_cmdline_parser.o test-drm_plane_helper.o \
-	test-drm_format.o
+	test-drm_format.o test-drm_framebuffer.o
diff --git a/drivers/gpu/drm/selftests/drm_modeset_selftests.h b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
index 5f253d9e573c..66f6b31e1a7f 100644
--- a/drivers/gpu/drm/selftests/drm_modeset_selftests.h
+++ b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
@@ -10,7 +10,6 @@ selftest(drm_rect_clip_scaled_div_by_zero, igt_drm_rect_clip_scaled_div_by_zero)
 selftest(drm_rect_clip_scaled_not_clipped, igt_drm_rect_clip_scaled_not_clipped)
 selftest(drm_rect_clip_scaled_clipped, igt_drm_rect_clip_scaled_clipped)
 selftest(drm_rect_clip_scaled_signed_vs_unsigned, igt_drm_rect_clip_scaled_signed_vs_unsigned)
-selftest(check_drm_framebuffer_create, igt_check_drm_framebuffer_create)
 selftest(damage_iter_no_damage, igt_damage_iter_no_damage)
 selftest(damage_iter_no_damage_fractional_src, igt_damage_iter_no_damage_fractional_src)
 selftest(damage_iter_no_damage_src_moved, igt_damage_iter_no_damage_src_moved)
diff --git a/drivers/gpu/drm/selftests/test-drm_framebuffer.c b/drivers/gpu/drm/selftests/test-drm_framebuffer.c
index 61b44d3a6a61..faa01cefe4e5 100644
--- a/drivers/gpu/drm/selftests/test-drm_framebuffer.c
+++ b/drivers/gpu/drm/selftests/test-drm_framebuffer.c
@@ -3,6 +3,7 @@
  * Test cases for the drm_framebuffer functions
  */
 
+#include <kunit/test.h>
 #include <linux/kernel.h>
 
 #include <drm/drm_device.h>
@@ -12,20 +13,67 @@
 
 #include "../drm_crtc_internal.h"
 
-#include "test-drm_modeset_common.h"
-
 #define MIN_WIDTH 4
 #define MAX_WIDTH 4096
 #define MIN_HEIGHT 4
 #define MAX_HEIGHT 4096
 
-struct drm_framebuffer_test {
+static struct drm_framebuffer *fb_create_mock(struct drm_device *dev,
+					      struct drm_file *file_priv,
+					      const struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	int *buffer_created = dev->dev_private;
+
+	*buffer_created = 1;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static const struct drm_mode_config_funcs mock_config_funcs = {
+	.fb_create = fb_create_mock,
+};
+
+static int drm_framebuffer_test_init(struct kunit *test)
+{
+	struct drm_device *mock;
+
+	mock = kunit_kzalloc(test, sizeof(*mock), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mock);
+
+	mock->mode_config = (struct drm_mode_config) {
+		.min_width = MIN_WIDTH,
+		.max_width = MAX_WIDTH,
+		.min_height = MIN_HEIGHT,
+		.max_height = MAX_HEIGHT,
+		.allow_fb_modifiers = true,
+		.funcs = &mock_config_funcs,
+	};
+
+	test->priv = mock;
+
+	return 0;
+}
+
+struct drm_framebuffer_create_test {
 	int buffer_created;
 	struct drm_mode_fb_cmd2 cmd;
 	const char *name;
 };
 
-static struct drm_framebuffer_test createbuffer_tests[] = {
+static void test_drm_framebuffer_create(struct kunit *test)
+{
+	const struct drm_framebuffer_create_test *params = test->param_value;
+	struct drm_device *mock = test->priv;
+	int buffer_created = 0;
+
+	mock->dev_private = &buffer_created;
+
+	drm_internal_framebuffer_create(mock, &params->cmd, NULL);
+
+	KUNIT_EXPECT_EQ(test, buffer_created, params->buffer_created);
+}
+
+static const struct drm_framebuffer_create_test drm_framebuffer_create_tests[] = {
 { .buffer_created = 1, .name = "ABGR8888 normal sizes",
 	.cmd = { .width = 600, .height = 600, .pixel_format = DRM_FORMAT_ABGR8888,
 		 .handles = { 1, 0, 0 }, .pitches = { 4 * 600, 0, 0 },
@@ -304,48 +352,25 @@ static struct drm_framebuffer_test createbuffer_tests[] = {
 },
 };
 
-static struct drm_framebuffer *fb_create_mock(struct drm_device *dev,
-					      struct drm_file *file_priv,
-					      const struct drm_mode_fb_cmd2 *mode_cmd)
+static void drm_framebuffer_create_desc(const struct drm_framebuffer_create_test *t,
+					char *desc)
 {
-	int *buffer_created = dev->dev_private;
-	*buffer_created = 1;
-	return ERR_PTR(-EINVAL);
+	sprintf(desc, "%s", t->name);
 }
 
-static struct drm_mode_config_funcs mock_config_funcs = {
-	.fb_create = fb_create_mock,
-};
+KUNIT_ARRAY_PARAM(drm_framebuffer_create,
+		  drm_framebuffer_create_tests,
+		  drm_framebuffer_create_desc);
 
-static struct drm_device mock_drm_device = {
-	.mode_config = {
-		.min_width = MIN_WIDTH,
-		.max_width = MAX_WIDTH,
-		.min_height = MIN_HEIGHT,
-		.max_height = MAX_HEIGHT,
-		.allow_fb_modifiers = true,
-		.funcs = &mock_config_funcs,
-	},
+static struct kunit_case drm_framebuffer_tests[] = {
+	KUNIT_CASE_PARAM(test_drm_framebuffer_create, drm_framebuffer_create_gen_params),
+	{}
 };
 
-static int execute_drm_mode_fb_cmd2(struct drm_mode_fb_cmd2 *r)
-{
-	int buffer_created = 0;
-
-	mock_drm_device.dev_private = &buffer_created;
-	drm_internal_framebuffer_create(&mock_drm_device, r, NULL);
-	return buffer_created;
-}
-
-int igt_check_drm_framebuffer_create(void *ignored)
-{
-	int i = 0;
-
-	for (i = 0; i < ARRAY_SIZE(createbuffer_tests); i++) {
-		FAIL(createbuffer_tests[i].buffer_created !=
-				execute_drm_mode_fb_cmd2(&createbuffer_tests[i].cmd),
-		     "Test %d: \"%s\" failed\n", i, createbuffer_tests[i].name);
-	}
+static struct kunit_suite drm_framebuffer_test_suite = {
+	.name = "drm_framebuffer_tests",
+	.init = drm_framebuffer_test_init,
+	.test_cases = drm_framebuffer_tests,
+};
 
-	return 0;
-}
+kunit_test_suite(drm_framebuffer_test_suite);
diff --git a/drivers/gpu/drm/selftests/test-drm_modeset_common.h b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
index f6cfce2a5863..c09f38b791ad 100644
--- a/drivers/gpu/drm/selftests/test-drm_modeset_common.h
+++ b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
@@ -20,7 +20,6 @@ int igt_drm_rect_clip_scaled_div_by_zero(void *ignored);
 int igt_drm_rect_clip_scaled_not_clipped(void *ignored);
 int igt_drm_rect_clip_scaled_clipped(void *ignored);
 int igt_drm_rect_clip_scaled_signed_vs_unsigned(void *ignored);
-int igt_check_drm_framebuffer_create(void *ignored);
 int igt_damage_iter_no_damage(void *ignored);
 int igt_damage_iter_no_damage_fractional_src(void *ignored);
 int igt_damage_iter_no_damage_src_moved(void *ignored);
-- 
2.34.1

