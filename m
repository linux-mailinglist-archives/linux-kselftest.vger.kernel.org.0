Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3EB491250
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 00:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243795AbiAQXYe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jan 2022 18:24:34 -0500
Received: from mga01.intel.com ([192.55.52.88]:50756 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243793AbiAQXYe (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jan 2022 18:24:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642461874; x=1673997874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=oYnI6gON5CS6yEm312AIdaVVPuYUAG9qPC59+khH82E=;
  b=aPKN/YNmlPoJtojL4QQ1NThv2Ki66FlChpaqcfHU9UxjbXeMHJ19u10j
   kPlCdoRl1yVxHcSDpD7+IfialrCpzAJp6bYUUmR99CqFIkwNjjAw79zYg
   ie/M33QfmE+hewwxnV/W41BxfYpSGEF9X9fsVLSH6uIVyICspcD+VP35B
   TQsI47y4lUL9sZvp+xDlkUz+iHw/HS+Xz/GZJVQi49kb5TzAYFk2WwI7E
   wSWZ47efVouCtWpf+km0BhprIKb4EsdtWRCYAA2W0hW5jlFR1gXcYpry8
   iiqL4+EPhXVbbAqbQ9W8GSNYY5jS4+yL3q7+7/J1wgS5iuZq7BfIRy6pl
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="269082577"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="269082577"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 15:24:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="625325314"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 17 Jan 2022 15:24:33 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 17 Jan 2022 15:24:32 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 17 Jan 2022 15:24:32 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 17 Jan 2022 15:24:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUBIr3Xd2I7jxkbDhGr2i4QXt0kTq/K07mTgnJVoy14MMIZrPTZpwvmqv0QovcRRu1xvt/6oYWk55AbCgnMsKMvO6ek3/u/SKyMlxyYxk9XF3bXk2J3r9RJjLWx1uJmcNt3t7WdcgCcKTFX1pdQIhKxNRFfJtzqMiIFlQ5POOTb82ltxkyBoRuUe2cSTqEfHNrqpn4noPRhPxqfKd0IxlkLvfVU35dDS24fM7LVHbuFqvMkSKYxlXKc9RLRii6bduIFEv5L7Zw26UuvYFNIIxG6My2Nq2F4n3ORFsXy5s+RbHwm3Ww4Br+zAlXDISyW8M5WHi/HjTt7BrAq0Gr08Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2PuRVqATPEecC6JGnykRvb2bjxi/0Gls7O7GDI7+2c=;
 b=YcMKscNRjlSHuinSp4pClvLcJqrQp4Y9FWYBCU8D7/L8VvabFPKDPqyh4GwybYxVi4rD3ByWJ+7V7iLnKhRVLAWDP4ZsRY58sF1mmexDy9ptRgJmWuFV02sCmMBNen8XMTGTunGZpi7GtHE6Q28AINOPn01cXVREb3M852M+dcUTuM6vL7WSlBCoawJhF/lzldUJVZC78sDKoGWB970vQY0ltRD6hptmYKLa5YbRJtXPO5R1PSehBhdL1n6c9LGyEL/SWKdu0Ryqb2XUz7KcKuT4i30eiVT7KOYkRb+YX0tEWD0y7TPsv65pYQhSRbJ9Z5hf8rlNkaEqXPGyYTEX+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 DM4PR11MB5550.namprd11.prod.outlook.com (2603:10b6:5:38b::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.9; Mon, 17 Jan 2022 23:24:28 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::fc15:bd26:128a:f5f5]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::fc15:bd26:128a:f5f5%8]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 23:24:28 +0000
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
Subject: [RFC 05/10] drm: test-drm_damage_helper: Convert to KUnit
Date:   Tue, 18 Jan 2022 00:22:54 +0100
Message-ID: <20220117232259.180459-6-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117232259.180459-1-michal.winiarski@intel.com>
References: <20220117232259.180459-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::19) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bbc1bf1-fd8d-49b4-b16a-08d9da1081fd
X-MS-TrafficTypeDiagnostic: DM4PR11MB5550:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM4PR11MB55500FF98A15B5E1E2015A3E98579@DM4PR11MB5550.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tk7wE5COz5pWTCvRV92fq7EGYYSAvOpglnauX8LIoR0egvUPUAvxR8GmryVvQblQN8BtU+72OgUlVSlsvbP5F7QxIlavc4em8ERhq6MRnb9Z/C2aUaAMijRBkzFHNOVz97fWYZ0h8grVcKnm9oUwv+BsjFgdRM63AQOv7TjgQLdNYlczSOZ+B6pvAsdN0o/5/cOAw1LofwEjtx4+3j4KlrqBzSOddEPa5VVbXYTEDW3m8i7HVypjTqvRQ8mbVG5mYVy8UGUwsGoDxHGNBe688Ejz/jQ0yfFY+x2twleRnl1kzVT/410ZXsbZLC1i59BhUZCam2AhG8EI3Y4LymBdHDkuIE+RVlmpiD5ln4nHccpLvYClg1yAf0A6mAh+YRG7u199Pb3C5x0y+InmwXhekj1IJgj2gX4vW3gc+oT2raUA+j55ahYP05GLcZuEh2KlTcG7gYfdN8guqlts9MT/WP3jDil9xC1pu6iJwHAsV+nDww16LoKSzSTTkMimWQKaNBtdG5zunh4Ya9SrMeo5D+XFSCuCXFQbIc5KBqRb9Dk8PS3PuTrh3Jnoo6tbijseoalljVE6gQfXs4MKfSMsvnplaGDvOxn9Sk/s9rl80/ZiVBXUVOUd9dMh9FByrtCjQHuJS9ncxXoHLwwqArWJeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(82960400001)(4326008)(5660300002)(36756003)(186003)(6506007)(7416002)(40140700001)(1076003)(54906003)(6512007)(83380400001)(26005)(66946007)(66476007)(66556008)(316002)(6486002)(38100700002)(8936002)(508600001)(2906002)(30864003)(6666004)(8676002)(2616005)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1g4NEFBWmxiYUZSQ0xNczhWemx5VFc3WVFKSElza2lrS2RKV0hna2NlbzVH?=
 =?utf-8?B?UHRDaFBzLy8zcm9SUlI4T1NMM3UzRi9ES29KM0I0bjM4S3dvczdITnRzWDFx?=
 =?utf-8?B?VmVxdThaZmR5ajJLWkJXeU5RNXczSzJoN0F2ejhacTdjUVVFOVZ3QVQzTnF0?=
 =?utf-8?B?TmwvRUp2SXkvckxhWG1kWHh3UFRsc1I3bE1tbU5EaU11UnRTRndrSG9LQ0hz?=
 =?utf-8?B?WnBRbWdJdG16S2o2YStDdmw1OGRhOG5YeHp6aTNidDRHdHZUbmlmTm0vZytn?=
 =?utf-8?B?UkhTakZDVFNsY2swL0hneVR6c3dRZUdiUUs1dGZTbWFDYkJvM3dhYytMSUl0?=
 =?utf-8?B?NFJZYkNCNlRyQUdxdkJQb3ljb25PV3d0TUpxTmtCYzBBQXhEanBBWGhnNUFy?=
 =?utf-8?B?ekRIdjdiaHdsQkxRaUJYcDNQU0V4dHpLd3Y2bGFrV3BDUGZYRHh1ci9mR2RG?=
 =?utf-8?B?NDFoVW03U0d0emE5QnpibmNMTFVUUXlGeUpYOUdJTFgzN2V6MWtZSkZkZGp2?=
 =?utf-8?B?VzhNVkNwcm5UMnp2R0kyL2FmcW03TURXeUMvVWxtM2VMM2RBU0NhbVhCYWds?=
 =?utf-8?B?Ym5lOGdRV2QzeGszREdvZmoyR0hZUGVKaGYvY2VMdVpJZHNzZGIwVnFlOHEx?=
 =?utf-8?B?U0p5VkxJT3czYjVadExhM3RVc0U0RUZIVDJsT0FtM2o2bzRHM0pLTEhPL2t3?=
 =?utf-8?B?MDJBa3N1RDdLeDZ2NitzYlYxd1BjZXJ0TlNWNUpuSldsNVpFcDN0WWh1cURJ?=
 =?utf-8?B?aDE2YTE5Mm42czA3RDNRL3VKR0I2ZS92cWRvRmtVUDhnMCtETVBxai9Ram1R?=
 =?utf-8?B?VmJ0Vmk3aXJwU0V2eXd0elFnU21DVjNSWHAzVjR5MDU5elU3SEZNcy9sNi95?=
 =?utf-8?B?dWlob2Y2MFlmTTZyY3o4aWppV1NhdE4yYjJWT0tsNDRkSTJuaUdQVHBrUW1x?=
 =?utf-8?B?RjFHTksvcnNsVVhERmtCUC90UUN0KzNmOXFxNklMbVNERkh1bm9PTkgzbWw0?=
 =?utf-8?B?cXRuVFZQbnFKMG5TbzlXeVBwM3VHZVlzMVRHSEZuL0lWYWpTazZFU25XU0VM?=
 =?utf-8?B?d2ZJZEdSNS84V3ZUTTd6eGNadUxpQ2cvdmV5WTVVb1lpVWdyL21ZR0FPODZo?=
 =?utf-8?B?NHdxdDNRNFk4Y1RqNHhQM0NzWHhLOThIS2o3aitkUVVZSFZWb0xKaDlZM1Fk?=
 =?utf-8?B?cTVoNlhUei9FQTlzbzJET0o1M3p2U3RaTFZhK3JkSkVoRmlpWll3eW1pZTFa?=
 =?utf-8?B?aGFoaGk3cG1QREpWUXFoUThtY3dDcmJSaHVxQUs1L1hDUnFHbzdnS0hhaGg3?=
 =?utf-8?B?ZndIak4veXdUUmoybVpnV2pEQ2lpdWxRc0g5QkFJVjlabC9lV1YxczJZOWU3?=
 =?utf-8?B?emk3dEJuWUFVOTJ1bm5mMDA3Z2VmSDNUOXBBZTVoSnVlRGtKQkswK2xYeDYz?=
 =?utf-8?B?MHpBY3JqRnlkYVc0L0hVcnVza3Jma0NPWFlvOTkzck8zaFBuNjJjOU9MWVFN?=
 =?utf-8?B?WlZFNFNRU1ViWkZwK0pxZytSSTdPZG94YlozKzRkKytuYWJxSWJWUDQ1VERX?=
 =?utf-8?B?RDZuOHlIVlc2cEVkcVdaS0RyaFJoUzRzb3d5cDE0bnBoMTRVblNxN3d4Z0px?=
 =?utf-8?B?YlQzRVVzZlFDemxVMVdFOHVTcDd4dWhLZzB3VHJXL2dpK3RIQWpRQ0xEQ05s?=
 =?utf-8?B?ZGxlYnNlVGVBdytycHUxN251NWY3aTdOYnFOTmJtYjlYVGpVdWNFV0ZpWWNo?=
 =?utf-8?B?TVlzekEwcXlrSWVmR1F0aXA1a2pnNlBTT05FQ1U0SWZOTUwwdjFNdncreFdQ?=
 =?utf-8?B?MXlhSFB6L3NxTHA0bHlnbDBRNnhua0NubnA5dXVLT2VRWnd4YXQ2eWk1dzRQ?=
 =?utf-8?B?UVdmbmd5elVkckdYallDUFJNN0xVY3hEQ3JkYzlZUkNMY0pwNmVOSjViSmh4?=
 =?utf-8?B?WVB3aVlCaWJCTWRmN2xscUVUSWJWZHBoRmZxT1ZwTU1GUkdBSEZOZlpVS29y?=
 =?utf-8?B?dUlmUm1IQmNUeVVEVnIyYzlTNjNHMllubEprTk1XTWg4YnVONHhIbkswWU5J?=
 =?utf-8?B?TldBNDRha1hXV1JwYmJGUUJOb1dXZk5NNWVHM3NzcklLZ0ZaRmZrTzhoTktU?=
 =?utf-8?B?MUo3VXhNS3FwWDZ5MnlFOHdKZzFVZHVGaU5yNENpRTJnMFNOYmZJNHhyeDlR?=
 =?utf-8?B?VFdNRCtEL3F5dncvOE5nTVpTb2djS1FKTVhTMFZYRlBuTGx3cDF0ZE44M3RV?=
 =?utf-8?B?TlNYeG9iQjRSRFZsZXNxT1RERWNRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bbc1bf1-fd8d-49b4-b16a-08d9da1081fd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 23:24:28.7197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DbasW3cf+ht8s2e6G59HJqAOsDhAHkV1RsmHRHcmLOT0IoHNOj5Z34iIOTaWHn9GeLWIkQJ2qzI/HfbIfLpd98bGVdBuBCUvYyyNDIKWng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5550
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Mocking was moved to .init() in order to separate it from test logic.
No functional changes.

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
---
 drivers/gpu/drm/selftests/Makefile            |   5 +-
 .../gpu/drm/selftests/drm_modeset_selftests.h |  21 -
 .../drm/selftests/test-drm_damage_helper.c    | 570 +++++++++---------
 .../drm/selftests/test-drm_modeset_common.h   |  21 -
 4 files changed, 288 insertions(+), 329 deletions(-)

diff --git a/drivers/gpu/drm/selftests/Makefile b/drivers/gpu/drm/selftests/Makefile
index 1235eadca884..35f2f40dbaf3 100644
--- a/drivers/gpu/drm/selftests/Makefile
+++ b/drivers/gpu/drm/selftests/Makefile
@@ -1,11 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test-drm_modeset-$(CONFIG_DRM_DEBUG_SELFTEST) := \
 		      test-drm_modeset_common.o \
-		      test-drm_damage_helper.o test-drm_dp_mst_helper.o \
+		      test-drm_dp_mst_helper.o \
 		      test-drm_rect.o
 
 obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o test-drm_modeset.o
 
 obj-$(CONFIG_DRM_KUNIT_TEST) := \
 	test-drm_cmdline_parser.o test-drm_plane_helper.o \
-	test-drm_format.o test-drm_framebuffer.o
+	test-drm_format.o test-drm_framebuffer.o \
+	test-drm_damage_helper.o
diff --git a/drivers/gpu/drm/selftests/drm_modeset_selftests.h b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
index 66f6b31e1a7f..b6a6dba66b64 100644
--- a/drivers/gpu/drm/selftests/drm_modeset_selftests.h
+++ b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
@@ -10,26 +10,5 @@ selftest(drm_rect_clip_scaled_div_by_zero, igt_drm_rect_clip_scaled_div_by_zero)
 selftest(drm_rect_clip_scaled_not_clipped, igt_drm_rect_clip_scaled_not_clipped)
 selftest(drm_rect_clip_scaled_clipped, igt_drm_rect_clip_scaled_clipped)
 selftest(drm_rect_clip_scaled_signed_vs_unsigned, igt_drm_rect_clip_scaled_signed_vs_unsigned)
-selftest(damage_iter_no_damage, igt_damage_iter_no_damage)
-selftest(damage_iter_no_damage_fractional_src, igt_damage_iter_no_damage_fractional_src)
-selftest(damage_iter_no_damage_src_moved, igt_damage_iter_no_damage_src_moved)
-selftest(damage_iter_no_damage_fractional_src_moved, igt_damage_iter_no_damage_fractional_src_moved)
-selftest(damage_iter_no_damage_not_visible, igt_damage_iter_no_damage_not_visible)
-selftest(damage_iter_no_damage_no_crtc, igt_damage_iter_no_damage_no_crtc)
-selftest(damage_iter_no_damage_no_fb, igt_damage_iter_no_damage_no_fb)
-selftest(damage_iter_simple_damage, igt_damage_iter_simple_damage)
-selftest(damage_iter_single_damage, igt_damage_iter_single_damage)
-selftest(damage_iter_single_damage_intersect_src, igt_damage_iter_single_damage_intersect_src)
-selftest(damage_iter_single_damage_outside_src, igt_damage_iter_single_damage_outside_src)
-selftest(damage_iter_single_damage_fractional_src, igt_damage_iter_single_damage_fractional_src)
-selftest(damage_iter_single_damage_intersect_fractional_src, igt_damage_iter_single_damage_intersect_fractional_src)
-selftest(damage_iter_single_damage_outside_fractional_src, igt_damage_iter_single_damage_outside_fractional_src)
-selftest(damage_iter_single_damage_src_moved, igt_damage_iter_single_damage_src_moved)
-selftest(damage_iter_single_damage_fractional_src_moved, igt_damage_iter_single_damage_fractional_src_moved)
-selftest(damage_iter_damage, igt_damage_iter_damage)
-selftest(damage_iter_damage_one_intersect, igt_damage_iter_damage_one_intersect)
-selftest(damage_iter_damage_one_outside, igt_damage_iter_damage_one_outside)
-selftest(damage_iter_damage_src_moved, igt_damage_iter_damage_src_moved)
-selftest(damage_iter_damage_not_visible, igt_damage_iter_damage_not_visible)
 selftest(dp_mst_calc_pbn_mode, igt_dp_mst_calc_pbn_mode)
 selftest(dp_mst_sideband_msg_req_decode, igt_dp_mst_sideband_msg_req_decode)
diff --git a/drivers/gpu/drm/selftests/test-drm_damage_helper.c b/drivers/gpu/drm/selftests/test-drm_damage_helper.c
index 8d8d8e214c28..685d87575c3a 100644
--- a/drivers/gpu/drm/selftests/test-drm_damage_helper.c
+++ b/drivers/gpu/drm/selftests/test-drm_damage_helper.c
@@ -3,39 +3,55 @@
  * Test case for drm_damage_helper functions
  */
 
-#define pr_fmt(fmt) "drm_damage_helper: " fmt
+#include <kunit/test.h>
 
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_plane.h>
 #include <drm/drm_drv.h>
 
-#include "test-drm_modeset_common.h"
-
-struct drm_driver mock_driver;
-static struct drm_device mock_device;
-static struct drm_object_properties mock_obj_props;
-static struct drm_plane mock_plane;
-static struct drm_property mock_prop;
+/* common mocked structs many tests need */
+struct drm_damage_mock {
+	struct drm_framebuffer fb;
+	struct drm_driver driver;
+	struct drm_device device;
+	struct drm_object_properties obj_props;
+	struct drm_plane plane;
+	struct drm_property prop;
+	struct drm_plane_state state;
+	struct drm_plane_state old_state;
+};
 
-static void mock_setup(struct drm_plane_state *state)
+static int drm_damage_test_init(struct kunit *test)
 {
-	static bool setup_done = false;
+	struct drm_damage_mock *mock;
 
-	state->plane = &mock_plane;
+	mock = kunit_kzalloc(test, sizeof(*mock), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mock);
 
-	if (setup_done)
-		return;
+	mock->fb.width = 2048;
+	mock->fb.height = 2048;
 
 	/* just enough so that drm_plane_enable_fb_damage_clips() works */
-	mock_device.driver = &mock_driver;
-	mock_device.mode_config.prop_fb_damage_clips = &mock_prop;
-	mock_plane.dev = &mock_device;
-	mock_obj_props.count = 0;
-	mock_plane.base.properties = &mock_obj_props;
-	mock_prop.base.id = 1; /* 0 is an invalid id */
-	mock_prop.dev = &mock_device;
-
-	drm_plane_enable_fb_damage_clips(&mock_plane);
+	mock->device.driver = &mock->driver;
+	mock->device.mode_config.prop_fb_damage_clips = &mock->prop;
+	mock->plane.dev = &mock->device;
+	mock->obj_props.count = 0;
+	mock->plane.base.properties = &mock->obj_props;
+	mock->prop.base.id = 1; /* 0 is an invalid id */
+	mock->prop.dev = &mock->device;
+
+	drm_plane_enable_fb_damage_clips(&mock->plane);
+
+	mock->state.crtc = ZERO_SIZE_PTR;
+	mock->state.fb = &mock->fb;
+	mock->state.visible = true;
+	mock->state.plane = &mock->plane;
+
+	mock->old_state.plane = &mock->plane;
+
+	test->priv = mock;
+
+	return 0;
 }
 
 static void set_plane_src(struct drm_plane_state *state, int x1, int y1, int x2,
@@ -69,8 +85,8 @@ static void set_plane_damage(struct drm_plane_state *state,
 	state->fb_damage_clips = damage_blob;
 }
 
-static bool check_damage_clip(struct drm_plane_state *state, struct drm_rect *r,
-			      int x1, int y1, int x2, int y2)
+static void check_damage_clip(struct kunit *test, struct drm_plane_state *state,
+			      struct drm_rect *r, int x1, int y1, int x2, int y2)
 {
 	/*
 	 * Round down x1/y1 and round up x2/y2. This is because damage is not in
@@ -81,587 +97,571 @@ static bool check_damage_clip(struct drm_plane_state *state, struct drm_rect *r,
 	int src_x2 = (state->src.x2 >> 16) + !!(state->src.x2 & 0xFFFF);
 	int src_y2 = (state->src.y2 >> 16) + !!(state->src.y2 & 0xFFFF);
 
-	if (x1 >= x2 || y1 >= y2) {
-		pr_err("Cannot have damage clip with no dimension.\n");
-		return false;
-	}
-
-	if (x1 < src_x1 || y1 < src_y1 || x2 > src_x2 || y2 > src_y2) {
-		pr_err("Damage cannot be outside rounded plane src.\n");
-		return false;
-	}
-
-	if (r->x1 != x1 || r->y1 != y1 || r->x2 != x2 || r->y2 != y2) {
-		pr_err("Damage = %d %d %d %d\n", r->x1, r->y1, r->x2, r->y2);
-		return false;
-	}
+	KUNIT_EXPECT_FALSE_MSG(test, x1 >= x2 || y1 >= y2,
+			       "Cannot have damage clip with no dimension.");
+	KUNIT_EXPECT_FALSE_MSG(test, x1 < src_x1 || y1 < src_y1 || x2 > src_x2 || y2 > src_y2,
+			       "Damage cannot be outside rounded plane src.");
 
-	return true;
+	KUNIT_EXPECT_TRUE_MSG(test, r->x1 == x1 && r->y1 == y1 && r->x2 == x2 && r->y2 == y2,
+			      "Damage = %d %d %d %d, expected = %d %d %d %d",
+			      r->x1, r->y1, r->x2, r->y2,
+			      x1, y1, x2, y2);
 }
 
-const struct drm_framebuffer fb = {
-	.width = 2048,
-	.height = 2048
-};
-
-/* common mocked structs many tests need */
-#define MOCK_VARIABLES() \
-	struct drm_plane_state old_state; \
-	struct drm_plane_state state = { \
-		.crtc = ZERO_SIZE_PTR, \
-		.fb = (struct drm_framebuffer *) &fb, \
-		.visible = true, \
-	}; \
-	mock_setup(&old_state); \
-	mock_setup(&state);
-
-int igt_damage_iter_no_damage(void *ignored)
+static void drm_damage_iter_no_damage(struct kunit *test)
 {
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_plane_state *old_state = &mock->old_state;
+	struct drm_plane_state *state = &mock->state;
+	struct drm_framebuffer *fb = &mock->fb;
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_rect clip;
 	uint32_t num_hits = 0;
 
-	MOCK_VARIABLES();
-
 	/* Plane src same as fb size. */
-	set_plane_src(&old_state, 0, 0, fb.width << 16, fb.height << 16);
-	set_plane_src(&state, 0, 0, fb.width << 16, fb.height << 16);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
+	set_plane_src(old_state, 0, 0, fb->width << 16, fb->height << 16);
+	set_plane_src(state, 0, 0, fb->width << 16, fb->height << 16);
+	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 1, "Should return plane src as damage.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 0, 0, 2048, 2048));
-
-	return 0;
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1, "Should return plane src as damage.");
+	check_damage_clip(test, state, &clip, 0, 0, 2048, 2048);
 }
 
-int igt_damage_iter_no_damage_fractional_src(void *ignored)
+static void drm_damage_iter_no_damage_fractional_src(struct kunit *test)
 {
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_plane_state *old_state = &mock->old_state;
+	struct drm_plane_state *state = &mock->state;
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_rect clip;
 	uint32_t num_hits = 0;
 
-	MOCK_VARIABLES();
-
 	/* Plane src has fractional part. */
-	set_plane_src(&old_state, 0x3fffe, 0x3fffe,
+	set_plane_src(old_state, 0x3fffe, 0x3fffe,
 		      0x3fffe + (1024 << 16), 0x3fffe + (768 << 16));
-	set_plane_src(&state, 0x3fffe, 0x3fffe,
+	set_plane_src(state, 0x3fffe, 0x3fffe,
 		      0x3fffe + (1024 << 16), 0x3fffe + (768 << 16));
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
+	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 1, "Should return rounded off plane src as damage.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 3, 3, 1028, 772));
-
-	return 0;
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1, "Should return rounded off plane src as damage.");
+	check_damage_clip(test, state, &clip, 3, 3, 1028, 772);
 }
 
-int igt_damage_iter_no_damage_src_moved(void *ignored)
+static void drm_damage_iter_no_damage_src_moved(struct kunit *test)
 {
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_plane_state *old_state = &mock->old_state;
+	struct drm_plane_state *state = &mock->state;
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_rect clip;
 	uint32_t num_hits = 0;
 
-	MOCK_VARIABLES();
-
 	/* Plane src moved since old plane state. */
-	set_plane_src(&old_state, 0, 0, 1024 << 16, 768 << 16);
-	set_plane_src(&state, 10 << 16, 10 << 16,
+	set_plane_src(old_state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(state, 10 << 16, 10 << 16,
 		      (10 + 1024) << 16, (10 + 768) << 16);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
+	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 1, "Should return plane src as damage.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 10, 10, 1034, 778));
-
-	return 0;
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1, "Should return plane src as damage.");
+	check_damage_clip(test, state, &clip, 10, 10, 1034, 778);
 }
 
-int igt_damage_iter_no_damage_fractional_src_moved(void *ignored)
+static void drm_damage_iter_no_damage_fractional_src_moved(struct kunit *test)
 {
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_plane_state *old_state = &mock->old_state;
+	struct drm_plane_state *state = &mock->state;
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_rect clip;
 	uint32_t num_hits = 0;
 
-	MOCK_VARIABLES();
-
 	/* Plane src has fractional part and it moved since old plane state. */
-	set_plane_src(&old_state, 0x3fffe, 0x3fffe,
+	set_plane_src(old_state, 0x3fffe, 0x3fffe,
 		      0x3fffe + (1024 << 16), 0x3fffe + (768 << 16));
-	set_plane_src(&state, 0x40002, 0x40002,
+	set_plane_src(state, 0x40002, 0x40002,
 		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
+	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 1, "Should return plane src as damage.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 4, 4, 1029, 773));
-
-	return 0;
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1, "Should return plane src as damage.");
+	check_damage_clip(test, state, &clip, 4, 4, 1029, 773);
 }
 
-int igt_damage_iter_no_damage_not_visible(void *ignored)
+static void drm_damage_iter_no_damage_not_visible(struct kunit *test)
 {
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_plane_state *old_state = &mock->old_state;
+	struct drm_plane_state *state = &mock->state;
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_rect clip;
 	uint32_t num_hits = 0;
 
-	MOCK_VARIABLES();
-
-	state.visible = false;
+	state->visible = false;
 
-	mock_setup(&old_state);
-
-	set_plane_src(&old_state, 0, 0, 1024 << 16, 768 << 16);
-	set_plane_src(&state, 0, 0, 1024 << 16, 768 << 16);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
+	set_plane_src(old_state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(state, 0, 0, 1024 << 16, 768 << 16);
+	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 0, "Should have no damage.");
-
-	return 0;
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 0, "Should have no damage.");
 }
 
-int igt_damage_iter_no_damage_no_crtc(void *ignored)
+static void drm_damage_iter_no_damage_no_crtc(struct kunit *test)
 {
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_plane_state *old_state = &mock->old_state;
+	struct drm_plane_state *state = &mock->state;
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_rect clip;
 	uint32_t num_hits = 0;
 
-	MOCK_VARIABLES();
-
-	state.crtc = NULL;
+	state->crtc = NULL;
 
-	set_plane_src(&old_state, 0, 0, 1024 << 16, 768 << 16);
-	set_plane_src(&state, 0, 0, 1024 << 16, 768 << 16);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
+	set_plane_src(old_state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(state, 0, 0, 1024 << 16, 768 << 16);
+	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 0, "Should have no damage.");
-
-	return 0;
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 0, "Should have no damage.");
 }
 
-int igt_damage_iter_no_damage_no_fb(void *ignored)
+static void drm_damage_iter_no_damage_no_fb(struct kunit *test)
 {
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_plane_state *old_state = &mock->old_state;
+	struct drm_plane_state *state = &mock->state;
 	struct drm_atomic_helper_damage_iter iter;
-	struct drm_plane_state old_state;
 	struct drm_rect clip;
 	uint32_t num_hits = 0;
 
-	struct drm_plane_state state = {
-		.crtc = ZERO_SIZE_PTR,
-		.fb = 0,
-	};
-
-	mock_setup(&old_state);
+	state->fb = NULL;
 
-	set_plane_src(&old_state, 0, 0, 1024 << 16, 768 << 16);
-	set_plane_src(&state, 0, 0, 1024 << 16, 768 << 16);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
+	set_plane_src(old_state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(state, 0, 0, 1024 << 16, 768 << 16);
+	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 0, "Should have no damage.");
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 0);
 }
 
-int igt_damage_iter_simple_damage(void *ignored)
+static void drm_damage_iter_simple_damage(struct kunit *test)
 {
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_plane_state *old_state = &mock->old_state;
+	struct drm_plane_state *state = &mock->state;
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
 	struct drm_mode_rect damage;
 	struct drm_rect clip;
 	uint32_t num_hits = 0;
 
-	MOCK_VARIABLES();
-
-	set_plane_src(&old_state, 0, 0, 1024 << 16, 768 << 16);
-	set_plane_src(&state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(old_state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(state, 0, 0, 1024 << 16, 768 << 16);
 	/* Damage set to plane src */
 	set_damage_clip(&damage, 0, 0, 1024, 768);
 	set_damage_blob(&damage_blob, &damage, sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
+	set_plane_damage(state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 1, "Should return damage when set.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 0, 0, 1024, 768));
-
-	return 0;
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1, "Should return damage when set.");
+	check_damage_clip(test, state, &clip, 0, 0, 1024, 768);
 }
 
-int igt_damage_iter_single_damage(void *ignored)
+static void drm_damage_iter_single_damage(struct kunit *test)
 {
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_plane_state *old_state = &mock->old_state;
+	struct drm_plane_state *state = &mock->state;
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
 	struct drm_mode_rect damage;
 	struct drm_rect clip;
 	uint32_t num_hits = 0;
 
-	MOCK_VARIABLES();
-
-	set_plane_src(&old_state, 0, 0, 1024 << 16, 768 << 16);
-	set_plane_src(&state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(old_state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(state, 0, 0, 1024 << 16, 768 << 16);
 	set_damage_clip(&damage, 256, 192, 768, 576);
 	set_damage_blob(&damage_blob, &damage, sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
+	set_plane_damage(state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 1, "Should return damage when set.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 256, 192, 768, 576));
-
-	return 0;
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1, "Should return damage when set.");
+	check_damage_clip(test, state, &clip, 256, 192, 768, 576);
 }
 
-int igt_damage_iter_single_damage_intersect_src(void *ignored)
+static void drm_damage_iter_single_damage_intersect_src(struct kunit *test)
 {
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_plane_state *old_state = &mock->old_state;
+	struct drm_plane_state *state = &mock->state;
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
 	struct drm_mode_rect damage;
 	struct drm_rect clip;
 	uint32_t num_hits = 0;
 
-	MOCK_VARIABLES();
-
-	set_plane_src(&old_state, 0, 0, 1024 << 16, 768 << 16);
-	set_plane_src(&state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(old_state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(state, 0, 0, 1024 << 16, 768 << 16);
 	/* Damage intersect with plane src. */
 	set_damage_clip(&damage, 256, 192, 1360, 768);
 	set_damage_blob(&damage_blob, &damage, sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
+	set_plane_damage(state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 1, "Should return damage clipped to src.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 256, 192, 1024, 768));
-
-	return 0;
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1, "Should return damage clipped to src.");
+	check_damage_clip(test, state, &clip, 256, 192, 1024, 768);
 }
 
-int igt_damage_iter_single_damage_outside_src(void *ignored)
+static void drm_damage_iter_single_damage_outside_src(struct kunit *test)
 {
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_plane_state *old_state = &mock->old_state;
+	struct drm_plane_state *state = &mock->state;
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
 	struct drm_mode_rect damage;
 	struct drm_rect clip;
 	uint32_t num_hits = 0;
 
-	MOCK_VARIABLES();
-
-	set_plane_src(&old_state, 0, 0, 1024 << 16, 768 << 16);
-	set_plane_src(&state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(old_state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(state, 0, 0, 1024 << 16, 768 << 16);
 	/* Damage clip outside plane src */
 	set_damage_clip(&damage, 1360, 1360, 1380, 1380);
 	set_damage_blob(&damage_blob, &damage, sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
+	set_plane_damage(state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 0, "Should have no damage.");
-
-	return 0;
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 0, "Should have no damage.");
 }
 
-int igt_damage_iter_single_damage_fractional_src(void *ignored)
+static void drm_damage_iter_single_damage_fractional_src(struct kunit *test)
 {
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_plane_state *old_state = &mock->old_state;
+	struct drm_plane_state *state = &mock->state;
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
 	struct drm_mode_rect damage;
 	struct drm_rect clip;
 	uint32_t num_hits = 0;
 
-	MOCK_VARIABLES();
-
 	/* Plane src has fractional part. */
-	set_plane_src(&old_state, 0x40002, 0x40002,
+	set_plane_src(old_state, 0x40002, 0x40002,
 		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
-	set_plane_src(&state, 0x40002, 0x40002,
+	set_plane_src(state, 0x40002, 0x40002,
 		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
 	set_damage_clip(&damage, 10, 10, 256, 330);
 	set_damage_blob(&damage_blob, &damage, sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
+	set_plane_damage(state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 1, "Should return damage when set.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 10, 10, 256, 330));
-
-	return 0;
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1, "Should return damage when set.");
+	check_damage_clip(test, state, &clip, 10, 10, 256, 330);
 }
 
-int igt_damage_iter_single_damage_intersect_fractional_src(void *ignored)
+static void drm_damage_iter_single_damage_intersect_fractional_src(struct kunit *test)
 {
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_plane_state *old_state = &mock->old_state;
+	struct drm_plane_state *state = &mock->state;
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
 	struct drm_mode_rect damage;
 	struct drm_rect clip;
 	uint32_t num_hits = 0;
 
-	MOCK_VARIABLES();
-
 	/* Plane src has fractional part. */
-	set_plane_src(&old_state, 0x40002, 0x40002,
+	set_plane_src(old_state, 0x40002, 0x40002,
 		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
-	set_plane_src(&state, 0x40002, 0x40002,
+	set_plane_src(state, 0x40002, 0x40002,
 		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
 	/* Damage intersect with plane src. */
 	set_damage_clip(&damage, 10, 1, 1360, 330);
 	set_damage_blob(&damage_blob, &damage, sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
+	set_plane_damage(state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 1, "Should return damage clipped to rounded off src.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 10, 4, 1029, 330));
-
-	return 0;
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1, "Should return damage clipped to rounded off src.");
+	check_damage_clip(test, state, &clip, 10, 4, 1029, 330);
 }
 
-int igt_damage_iter_single_damage_outside_fractional_src(void *ignored)
+static void drm_damage_iter_single_damage_outside_fractional_src(struct kunit *test)
 {
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_plane_state *old_state = &mock->old_state;
+	struct drm_plane_state *state = &mock->state;
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
 	struct drm_mode_rect damage;
 	struct drm_rect clip;
 	uint32_t num_hits = 0;
 
-	MOCK_VARIABLES();
-
 	/* Plane src has fractional part. */
-	set_plane_src(&old_state, 0x40002, 0x40002,
+	set_plane_src(old_state, 0x40002, 0x40002,
 		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
-	set_plane_src(&state, 0x40002, 0x40002,
+	set_plane_src(state, 0x40002, 0x40002,
 		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
 	/* Damage clip outside plane src */
 	set_damage_clip(&damage, 1360, 1360, 1380, 1380);
 	set_damage_blob(&damage_blob, &damage, sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
+	set_plane_damage(state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 0, "Should have no damage.");
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 0);
 }
 
-int igt_damage_iter_single_damage_src_moved(void *ignored)
+static void drm_damage_iter_single_damage_src_moved(struct kunit *test)
 {
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_plane_state *old_state = &mock->old_state;
+	struct drm_plane_state *state = &mock->state;
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
 	struct drm_mode_rect damage;
 	struct drm_rect clip;
 	uint32_t num_hits = 0;
 
-	MOCK_VARIABLES();
-
 	/* Plane src moved since old plane state. */
-	set_plane_src(&old_state, 0, 0, 1024 << 16, 768 << 16);
-	set_plane_src(&state, 10 << 16, 10 << 16,
+	set_plane_src(old_state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(state, 10 << 16, 10 << 16,
 		      (10 + 1024) << 16, (10 + 768) << 16);
 	set_damage_clip(&damage, 20, 30, 256, 256);
 	set_damage_blob(&damage_blob, &damage, sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
+	set_plane_damage(state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 1, "Should return plane src as damage.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 10, 10, 1034, 778));
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 1);
+	check_damage_clip(test, state, &clip, 10, 10, 1034, 778);
 }
 
-int igt_damage_iter_single_damage_fractional_src_moved(void *ignored)
+static void drm_damage_iter_single_damage_fractional_src_moved(struct kunit *test)
 {
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_plane_state *old_state = &mock->old_state;
+	struct drm_plane_state *state = &mock->state;
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
 	struct drm_mode_rect damage;
 	struct drm_rect clip;
 	uint32_t num_hits = 0;
 
-	MOCK_VARIABLES();
-
 	/* Plane src with fractional part moved since old plane state. */
-	set_plane_src(&old_state, 0x3fffe, 0x3fffe,
+	set_plane_src(old_state, 0x3fffe, 0x3fffe,
 		      0x3fffe + (1024 << 16), 0x3fffe + (768 << 16));
-	set_plane_src(&state, 0x40002, 0x40002,
+	set_plane_src(state, 0x40002, 0x40002,
 		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
 	/* Damage intersect with plane src. */
 	set_damage_clip(&damage, 20, 30, 1360, 256);
 	set_damage_blob(&damage_blob, &damage, sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
+	set_plane_damage(state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 1, "Should return rounded off plane src as damage.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 4, 4, 1029, 773));
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 1);
+	check_damage_clip(test, state, &clip, 4, 4, 1029, 773);
 }
 
-int igt_damage_iter_damage(void *ignored)
+static void drm_damage_iter_damage(struct kunit *test)
 {
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_plane_state *old_state = &mock->old_state;
+	struct drm_plane_state *state = &mock->state;
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
 	struct drm_mode_rect damage[2];
 	struct drm_rect clip;
 	uint32_t num_hits = 0;
 
-	MOCK_VARIABLES();
-
-	set_plane_src(&old_state, 0, 0, 1024 << 16, 768 << 16);
-	set_plane_src(&state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(old_state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(state, 0, 0, 1024 << 16, 768 << 16);
 	/* 2 damage clips. */
 	set_damage_clip(&damage[0], 20, 30, 200, 180);
 	set_damage_clip(&damage[1], 240, 200, 280, 250);
 	set_damage_blob(&damage_blob, &damage[0], sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
+	set_plane_damage(state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
 	drm_atomic_for_each_plane_damage(&iter, &clip) {
 		if (num_hits == 0)
-			FAIL_ON(!check_damage_clip(&state, &clip, 20, 30, 200, 180));
+			check_damage_clip(test, state, &clip, 20, 30, 200, 180);
 		if (num_hits == 1)
-			FAIL_ON(!check_damage_clip(&state, &clip, 240, 200, 280, 250));
+			check_damage_clip(test, state, &clip, 240, 200, 280, 250);
 		num_hits++;
 	}
 
-	FAIL(num_hits != 2, "Should return damage when set.");
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 2);
 }
 
-int igt_damage_iter_damage_one_intersect(void *ignored)
+static void drm_damage_iter_damage_one_intersect(struct kunit *test)
 {
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_plane_state *old_state = &mock->old_state;
+	struct drm_plane_state *state = &mock->state;
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
 	struct drm_mode_rect damage[2];
 	struct drm_rect clip;
 	uint32_t num_hits = 0;
 
-	MOCK_VARIABLES();
-
-	set_plane_src(&old_state, 0x40002, 0x40002,
+	set_plane_src(old_state, 0x40002, 0x40002,
 		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
-	set_plane_src(&state, 0x40002, 0x40002,
+	set_plane_src(state, 0x40002, 0x40002,
 		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
 	/* 2 damage clips, one intersect plane src. */
 	set_damage_clip(&damage[0], 20, 30, 200, 180);
 	set_damage_clip(&damage[1], 2, 2, 1360, 1360);
 	set_damage_blob(&damage_blob, &damage[0], sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
+	set_plane_damage(state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
 	drm_atomic_for_each_plane_damage(&iter, &clip) {
 		if (num_hits == 0)
-			FAIL_ON(!check_damage_clip(&state, &clip, 20, 30, 200, 180));
+			check_damage_clip(test, state, &clip, 20, 30, 200, 180);
 		if (num_hits == 1)
-			FAIL_ON(!check_damage_clip(&state, &clip, 4, 4, 1029, 773));
+			check_damage_clip(test, state, &clip, 4, 4, 1029, 773);
 		num_hits++;
 	}
 
-	FAIL(num_hits != 2, "Should return damage when set.");
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 2);
 }
 
-int igt_damage_iter_damage_one_outside(void *ignored)
+static void drm_damage_iter_damage_one_outside(struct kunit *test)
 {
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_plane_state *old_state = &mock->old_state;
+	struct drm_plane_state *state = &mock->state;
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
 	struct drm_mode_rect damage[2];
 	struct drm_rect clip;
 	uint32_t num_hits = 0;
 
-	MOCK_VARIABLES();
-
-	set_plane_src(&old_state, 0, 0, 1024 << 16, 768 << 16);
-	set_plane_src(&state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(old_state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(state, 0, 0, 1024 << 16, 768 << 16);
 	/* 2 damage clips, one outside plane src. */
 	set_damage_clip(&damage[0], 1360, 1360, 1380, 1380);
 	set_damage_clip(&damage[1], 240, 200, 280, 250);
 	set_damage_blob(&damage_blob, &damage[0], sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
+	set_plane_damage(state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 1, "Should return damage when set.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 240, 200, 280, 250));
-
-	return 0;
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1, "Should return damage when set.");
+	check_damage_clip(test, state, &clip, 240, 200, 280, 250);
 }
 
-int igt_damage_iter_damage_src_moved(void *ignored)
+static void drm_damage_iter_damage_src_moved(struct kunit *test)
 {
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_plane_state *old_state = &mock->old_state;
+	struct drm_plane_state *state = &mock->state;
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
 	struct drm_mode_rect damage[2];
 	struct drm_rect clip;
 	uint32_t num_hits = 0;
 
-	MOCK_VARIABLES();
-
-	set_plane_src(&old_state, 0x40002, 0x40002,
+	set_plane_src(old_state, 0x40002, 0x40002,
 		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
-	set_plane_src(&state, 0x3fffe, 0x3fffe,
+	set_plane_src(state, 0x3fffe, 0x3fffe,
 		      0x3fffe + (1024 << 16), 0x3fffe + (768 << 16));
 	/* 2 damage clips, one outside plane src. */
 	set_damage_clip(&damage[0], 1360, 1360, 1380, 1380);
 	set_damage_clip(&damage[1], 240, 200, 280, 250);
 	set_damage_blob(&damage_blob, &damage[0], sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
+	set_plane_damage(state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 1, "Should return round off plane src as damage.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 3, 3, 1028, 772));
-
-	return 0;
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1, "Should return round off plane src as damage.");
+	check_damage_clip(test, state, &clip, 3, 3, 1028, 772);
 }
 
-int igt_damage_iter_damage_not_visible(void *ignored)
+static void drm_damage_iter_damage_not_visible(struct kunit *test)
 {
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_plane_state *old_state = &mock->old_state;
+	struct drm_plane_state *state = &mock->state;
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
 	struct drm_mode_rect damage[2];
 	struct drm_rect clip;
 	uint32_t num_hits = 0;
 
-	MOCK_VARIABLES();
+	state->visible = false;
 
-	state.visible = false;
-
-	set_plane_src(&old_state, 0x40002, 0x40002,
+	set_plane_src(old_state, 0x40002, 0x40002,
 		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
-	set_plane_src(&state, 0x3fffe, 0x3fffe,
+	set_plane_src(state, 0x3fffe, 0x3fffe,
 		      0x3fffe + (1024 << 16), 0x3fffe + (768 << 16));
 	/* 2 damage clips, one outside plane src. */
 	set_damage_clip(&damage[0], 1360, 1360, 1380, 1380);
 	set_damage_clip(&damage[1], 240, 200, 280, 250);
 	set_damage_blob(&damage_blob, &damage[0], sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
+	set_plane_damage(state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 0, "Should not return any damage.");
-
-	return 0;
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 0, "Should not return any damage.");
 }
+
+static struct kunit_case drm_damage_helper_tests[] = {
+	KUNIT_CASE(drm_damage_iter_no_damage),
+	KUNIT_CASE(drm_damage_iter_no_damage_fractional_src),
+	KUNIT_CASE(drm_damage_iter_no_damage_src_moved),
+	KUNIT_CASE(drm_damage_iter_no_damage_fractional_src_moved),
+	KUNIT_CASE(drm_damage_iter_no_damage_not_visible),
+	KUNIT_CASE(drm_damage_iter_no_damage_no_crtc),
+	KUNIT_CASE(drm_damage_iter_no_damage_no_fb),
+	KUNIT_CASE(drm_damage_iter_simple_damage),
+	KUNIT_CASE(drm_damage_iter_single_damage),
+	KUNIT_CASE(drm_damage_iter_single_damage_intersect_src),
+	KUNIT_CASE(drm_damage_iter_single_damage_outside_src),
+	KUNIT_CASE(drm_damage_iter_single_damage_fractional_src),
+	KUNIT_CASE(drm_damage_iter_single_damage_intersect_fractional_src),
+	KUNIT_CASE(drm_damage_iter_single_damage_outside_fractional_src),
+	KUNIT_CASE(drm_damage_iter_single_damage_src_moved),
+	KUNIT_CASE(drm_damage_iter_single_damage_fractional_src_moved),
+	KUNIT_CASE(drm_damage_iter_damage),
+	KUNIT_CASE(drm_damage_iter_damage_one_intersect),
+	KUNIT_CASE(drm_damage_iter_damage_one_outside),
+	KUNIT_CASE(drm_damage_iter_damage_src_moved),
+	KUNIT_CASE(drm_damage_iter_damage_not_visible),
+	{}
+};
+
+static struct kunit_suite drm_damage_helper_test_suite = {
+	.name = "drm_damage_helper_tests",
+	.init = drm_damage_test_init,
+	.test_cases = drm_damage_helper_tests,
+};
+
+kunit_test_suite(drm_damage_helper_test_suite);
diff --git a/drivers/gpu/drm/selftests/test-drm_modeset_common.h b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
index c09f38b791ad..1501d99aee2f 100644
--- a/drivers/gpu/drm/selftests/test-drm_modeset_common.h
+++ b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
@@ -20,27 +20,6 @@ int igt_drm_rect_clip_scaled_div_by_zero(void *ignored);
 int igt_drm_rect_clip_scaled_not_clipped(void *ignored);
 int igt_drm_rect_clip_scaled_clipped(void *ignored);
 int igt_drm_rect_clip_scaled_signed_vs_unsigned(void *ignored);
-int igt_damage_iter_no_damage(void *ignored);
-int igt_damage_iter_no_damage_fractional_src(void *ignored);
-int igt_damage_iter_no_damage_src_moved(void *ignored);
-int igt_damage_iter_no_damage_fractional_src_moved(void *ignored);
-int igt_damage_iter_no_damage_not_visible(void *ignored);
-int igt_damage_iter_no_damage_no_crtc(void *ignored);
-int igt_damage_iter_no_damage_no_fb(void *ignored);
-int igt_damage_iter_simple_damage(void *ignored);
-int igt_damage_iter_single_damage(void *ignored);
-int igt_damage_iter_single_damage_intersect_src(void *ignored);
-int igt_damage_iter_single_damage_outside_src(void *ignored);
-int igt_damage_iter_single_damage_fractional_src(void *ignored);
-int igt_damage_iter_single_damage_intersect_fractional_src(void *ignored);
-int igt_damage_iter_single_damage_outside_fractional_src(void *ignored);
-int igt_damage_iter_single_damage_src_moved(void *ignored);
-int igt_damage_iter_single_damage_fractional_src_moved(void *ignored);
-int igt_damage_iter_damage(void *ignored);
-int igt_damage_iter_damage_one_intersect(void *ignored);
-int igt_damage_iter_damage_one_outside(void *ignored);
-int igt_damage_iter_damage_src_moved(void *ignored);
-int igt_damage_iter_damage_not_visible(void *ignored);
 int igt_dp_mst_calc_pbn_mode(void *ignored);
 int igt_dp_mst_sideband_msg_req_decode(void *ignored);
 
-- 
2.34.1

