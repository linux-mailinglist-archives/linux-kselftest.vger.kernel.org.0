Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3D649125A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 00:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243798AbiAQXZD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jan 2022 18:25:03 -0500
Received: from mga12.intel.com ([192.55.52.136]:55097 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243793AbiAQXZB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jan 2022 18:25:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642461901; x=1673997901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=7SZ5FkscuxR8Fu6Dmn9NNsNOTopG57Z6VqpuNtW5J8E=;
  b=R77yLJfNyp0l0U4uO602QR+xH8NBmAhccHtgZAkTH0PvmBoS89DivVMU
   Q6YE4p9dHLAUsY3zhmlcyOlQVATbPANwRQrecX83Q8RPiGQ9cdrCO99yK
   gqMoL4J2aiWyjwreQH9BdFwOaKvbUHk+dM0YzdwqNKTvP0unRUxqyHt2A
   Aqq7Emd3biSbYcNNPBMAgzWVAAPXC6evlyJoBKdU8FZzHOqHmMMOF49hz
   kO229CRCGkWPnF4aAdZXP/zkULiH+HOF6RidRfljJOo1bwhzRCPB5i/7R
   1FQUCJWVh51E6GO/mVtRYv/Ql+5SjjCdFz+VfOPUCsEOBn0Z3+KxGKOXq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="224683797"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="224683797"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 15:25:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="517554470"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga007.jf.intel.com with ESMTP; 17 Jan 2022 15:25:01 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 17 Jan 2022 15:25:00 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 17 Jan 2022 15:25:00 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 17 Jan 2022 15:25:00 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 17 Jan 2022 15:25:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0Ghs3ihrHzAChHBnIY0YYjHuaKG6n5NvPim9I7wbZ/v4fs2qdxmuJrn1J3x0Q0RC2uZZDsXwXrNcZ+lj2TIN5FmBl1saXdM5vLur2n2h5hTolHZROmkhIs0C1oN7yoAOPFzuyEC7tNSel9Y+tFL0VN1dMGQ/Dc30sBlyzab3gib64IOQCxV32u8B3j+E5whi3XHMkXPfx/fhXEngKVdc/tQzD4oDJnwGl89QXl81hMJxXqDmC5TJp+EmPxdaQeRGbnBGOl73TcPjx7NF9MOjjc1r+/wnPDpCm5DmrQ0TTZzB3Uvn/L9Q07YJP+6Zp4i1NbpTON3UVJ2ENezT96Niw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKlHknuBE7WK6xRv+9R+AldWiYg3irUWS2IbYi9xaQo=;
 b=P3gUgdf5GkRE2Dr8VEaSXbKoVD7/OYNP45OWKMO25sjthP2QoC9nocb/mdHG+ayrcfKLeCO0Qu+m3NNY0hF72L67h4563s9JEp85EPouFepjV4Ds6uu0BTRm5MklncLSXZLkGHLPCcGJ4ugYJlFdyK4rdRIcWrWNdpMHUM1HdUxTMiDsOFSvUjkqA9WDm1igyW/fJQnwK/XPDGcUPz5YLA8ZfADlqjKGMpwelX7JknrimK7wA932gycrJXj+fvQPwO54i7eZMFglDe/s8EhvwpWImQejznOeyyxJvhYYZnKNTBdZ712FFkNUnA3sJjxFWoEygNmBIM76QpTy2BIWKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 DM4PR11MB5550.namprd11.prod.outlook.com (2603:10b6:5:38b::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.9; Mon, 17 Jan 2022 23:24:58 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::fc15:bd26:128a:f5f5]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::fc15:bd26:128a:f5f5%8]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 23:24:58 +0000
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
Subject: [RFC 09/10] drm: selftests: Convert to KUnit
Date:   Tue, 18 Jan 2022 00:22:58 +0100
Message-ID: <20220117232259.180459-10-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117232259.180459-1-michal.winiarski@intel.com>
References: <20220117232259.180459-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0409.eurprd06.prod.outlook.com
 (2603:10a6:20b:461::18) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8064ead1-3a13-439f-570f-08d9da109389
X-MS-TrafficTypeDiagnostic: DM4PR11MB5550:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM4PR11MB5550E04A4420DCC05B10133D98579@DM4PR11MB5550.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ktiPXdK1Yd1LWonUumMbng9XDIEiz9nVmFya20gGVrcPoEEUE98vKbmQfxpeSt/F4XOSzRaEySCmkBHd6LW2csWrHObh3vF/Su1AtRlVHYJcUBxOxuvpOBHM0LPmRw2Fq6ETYLvVP1UAQR/dFIfIcGe4tQM8phJ+dzJH3191DBjjqT3Z7n46Iv75FeNvXkpMGPVlZMHQFdlzxoN406k69K5cCxtODeBkecafL5Tsb8Fqsd+ScxhMX090UGzQc2SEwNc6sHnQNNmOOJGHTGHySz287bVQYub4lGJmyt1JSmZkmGo7Ag4eR5JEdHddOG3hTL6zaj6ErUnsn1hZ+ugxBQmMJJf9pS4VIRdCv05R+GxFiP+Vxpg6xVOT4q/99DSR+eHNAVNZ2QzOnSGs77wGrEc6jRPWt5+U9SH3n/r4lIcIzbWwq3wDrCpzADdAzJ7/mYHmdswXFKlvaZWrslz8frD0Cnke/1GCFCpBKrfbqRrMckqlkunZiURVVQbsj45WQrFENnMdY+1Owdpf22iHYVxEN4aeqlxiA1nj4qAhLMrcEt8/F+boFuBSE6tYZMKTXncbwPbMXx0ZbPLjM8K22BULnmuPzFjhcUvLpeyfPIKHE3Dyd5JZ8OwEtRUBsIuM9I0Lr9W6zk3CfKZo22Dddg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(82960400001)(4326008)(5660300002)(36756003)(186003)(6506007)(7416002)(1076003)(54906003)(6512007)(83380400001)(26005)(66946007)(66476007)(66556008)(316002)(6486002)(38100700002)(8936002)(508600001)(2906002)(30864003)(8676002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFhFUmVoNG9zWHlmaHplV1E3enFaa0dId0NoRWI0UGVJejBaOWxkakNZaXV0?=
 =?utf-8?B?KzJqRnVRVXQvd2ZVakg1NG16WDhhRXoyWmM4cHhYZkM3ZGlQVllQV2VISUo1?=
 =?utf-8?B?WDg0NHZFb1hqc1F0bGVRazl6Um5wdUJ3K1ZGMlROb24wZXJnQ2cyL29yTlpy?=
 =?utf-8?B?RTZyK1d0OWh0Sk04VjViTDBSY3pUWlBIYmNiUWd0eHdJbi8vUFI0VFpnTnkv?=
 =?utf-8?B?U2l5QWJYenZtRzZYckw5d2d0MVEwUlFCcnJsT0JyK3VKSVdVNlc2WGNEbFBm?=
 =?utf-8?B?SmVFTWxQZ0NmMFZ0K0xIcWtSYkFjUmQ0RVdtSGtYRGtFN2Y0WGFYdUZib0lJ?=
 =?utf-8?B?OGtlNkhkTDN1TUZUNWtwRHdxaEZGaHhSOXhycEdIeHNmSEk2S28rd01KQXVF?=
 =?utf-8?B?RUlCcStpUkhIQnJhZ3JpL1NZWjMxNGNRQ2pWd3kvTnpZSXdHMXp5RnFEUkZV?=
 =?utf-8?B?dWkxS0FEM1pMMzFROEwrNXd3Tlp3dWVtWWlLY1hDOHZxaW1LUEVWemxIMk9h?=
 =?utf-8?B?akMydFU1eFdkWXRLTXFIOG9GMG1maXZtQ01NWERxMkEvZTZIUUNtN2xqZ05l?=
 =?utf-8?B?aWJHRTBDTUd5L1U4WFk4YjhFZmwzUnNMK3JPZFNnQlpDQmVGNm9XUko2Q3Iv?=
 =?utf-8?B?SW1WRTJIYUVNLzl1MS9vdUpGZ0syQjdFaDBKOU01bWFDdkcxWEF4Njk3ZU1t?=
 =?utf-8?B?ZnYyVENDcktKSkJiQ2xVMVl0YVM2QXhiRjU1M05Fbk50S3JZbktVWVFPbWZj?=
 =?utf-8?B?UlV6a1p4ZnJDWjVma3VvZitJbEhZazA4dkVxK0w3RSt6Z2cxdERjNFBjMXo2?=
 =?utf-8?B?N3lIRGxXUDhnZzVWM1NjSkpBVE5RK0VuU2dqMkE1TnBYdVBxZkdicUZHK3ZX?=
 =?utf-8?B?VDhBenV6YVYyR3cvRTQxVXBxZ1BKaEtPZldYbnJ5WDhCZVZYNE56dWlGb2ZR?=
 =?utf-8?B?L21RYysvSjRpazdhb2o4OUViUjVYS3BYWWkxODlGaUZqWDJSQ204WWhJeFVK?=
 =?utf-8?B?U0dldkVKYXAxWlhvT05OMHJQYW9PaU1XcHpWZDBuRngxc1NpTjlDcXNSQUxu?=
 =?utf-8?B?MjV1TlZ3YmkrQndTTm01L2xTR3Qzd2kwOHdQYzRoSklnMXc5RmY4NHNMSGRD?=
 =?utf-8?B?MmhvbDlIWjlxNW05TFk2UENTV1RSZVZjaVViSGJhL2xhQlJLSWxTZE5mcXl6?=
 =?utf-8?B?WjhVeWh2R3NwUzFKZ3l3N2tHZDFjZzVjVHRvVnVGb2s3K2xZbHdHUXVYWGNu?=
 =?utf-8?B?blVIaHFmT1pHam1DKzlEU3ZWTFFRZ2dPQ0NsL2d3dGh4dDJVNi85OXJCSWl3?=
 =?utf-8?B?K0FkZU82NXViTk4zL0QrTENGZytvUXM0enA0MDJta3EvVjVJeFZLcFFhNVFs?=
 =?utf-8?B?S1RIS2poQ25zazZZMGdrakJjYnRMRlJ0b1FWOUthMXRHNnhpY2xEcmp3S2l5?=
 =?utf-8?B?VDIxclFxbHorV0s3TEd6M2paUUNrcVlwUkdLVTY1a3AwV3Q0ZlhlaWhibkNj?=
 =?utf-8?B?U3ZZcG9yWkFmVGFocE5tMGlFbUdqQkM1OC9DSmg0L3NMTERGV2tpZzlLNGpN?=
 =?utf-8?B?eStPb0xrb2tCZ1lPeTQzT0lQWCtxckgrMzVZYmZrcnR1dVZuQ1g1cCtXWnVJ?=
 =?utf-8?B?ZTNMdDg0ZDg0bzVIYUc2UjE1dGRKa3pVdzAzaDc1UTJDUHhMdGlyZ1VEaHdi?=
 =?utf-8?B?K3UzZTduTUlxaTd1SFFRdWFnd1l6OXlQelBlWSt3L1JoQjVteUVMejYwZW9Z?=
 =?utf-8?B?YlBmOUhJRzFtWXNjbTFucDdMUUFDSlJ6bWxzY3h3a1Y1SWY2VTdPeWI5dHFp?=
 =?utf-8?B?M0l6OURrV0g1amErenlnSjJlYXcyRFdTb0w3WVpGcUgrYS9FS2JIaThxeG8y?=
 =?utf-8?B?QVFTTHpUMVZSUFRFNU9WczA3ek8vaUpRK1cvWUcvQndaTnhQanowOUU2TWdG?=
 =?utf-8?B?REJZWDdOODVMbmpOc3A4NURqYUttQmgxamtUbW9QVDJKMm9GUEtYWElWaGcv?=
 =?utf-8?B?REduaXoxaDdkVVp1LzlXUXdWdmR3ZjUxczJUVUVISUtFRk5zaTJyVzlPVThs?=
 =?utf-8?B?U2UyQkdjVGxYYitkY0hNcVNUZG9wUTJXT2x6RGVLV0ZjdCtvWGpnL3RXZDFM?=
 =?utf-8?B?amk2V3RHQ2RjM2JWSGdOV25CMG03U1JVakRQMENDMyt6VTV1clYvQ3Q3Q0xU?=
 =?utf-8?B?aHloaVFkR1I4Q0dXSEZyVS9JSjZ2TzcrRzk5VnVEUUgrQStaSmRDWlhDcm5K?=
 =?utf-8?B?ZG9qT0RYSTRRQ0JROFFHT2dGajhnPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8064ead1-3a13-439f-570f-08d9da109389
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 23:24:58.0312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XawDAc8gBKZyQBAIVbzg2W7e80Pi4Z4h/OMPtQf5cRaPbqTIPOO98iOctAZtM0LoYDDGlh5tYAbtOQoVtzX0axqWyGmwODyeovrzW3MfKD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5550
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now that all tests were converted, remove the content that's no longer
used and rename the directory to "test".

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
---
 drivers/gpu/drm/Kconfig                       |  17 ---
 drivers/gpu/drm/Makefile                      |   2 +-
 drivers/gpu/drm/i915/Kconfig.debug            |   1 -
 drivers/gpu/drm/selftests/drm_selftest.c      | 109 ------------------
 drivers/gpu/drm/selftests/drm_selftest.h      |  41 -------
 drivers/gpu/drm/{selftests => test}/Makefile  |   0
 .../test-drm_cmdline_parser.c                 |   0
 .../test-drm_damage_helper.c                  |   0
 .../test-drm_dp_mst_helper.c                  |   0
 .../drm/{selftests => test}/test-drm_format.c |   0
 .../test-drm_framebuffer.c                    |   0
 .../gpu/drm/{selftests => test}/test-drm_mm.c |   0
 .../test-drm_plane_helper.c                   |   0
 .../drm/{selftests => test}/test-drm_rect.c   |   0
 14 files changed, 1 insertion(+), 169 deletions(-)
 delete mode 100644 drivers/gpu/drm/selftests/drm_selftest.c
 delete mode 100644 drivers/gpu/drm/selftests/drm_selftest.h
 rename drivers/gpu/drm/{selftests => test}/Makefile (100%)
 rename drivers/gpu/drm/{selftests => test}/test-drm_cmdline_parser.c (100%)
 rename drivers/gpu/drm/{selftests => test}/test-drm_damage_helper.c (100%)
 rename drivers/gpu/drm/{selftests => test}/test-drm_dp_mst_helper.c (100%)
 rename drivers/gpu/drm/{selftests => test}/test-drm_format.c (100%)
 rename drivers/gpu/drm/{selftests => test}/test-drm_framebuffer.c (100%)
 rename drivers/gpu/drm/{selftests => test}/test-drm_mm.c (100%)
 rename drivers/gpu/drm/{selftests => test}/test-drm_plane_helper.c (100%)
 rename drivers/gpu/drm/{selftests => test}/test-drm_rect.c (100%)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index c567324c96b9..7b18540a1b8a 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -63,23 +63,6 @@ config DRM_DEBUG_MM
 
 	  If in doubt, say "N".
 
-config DRM_DEBUG_SELFTEST
-	tristate "kselftests for DRM"
-	depends on DRM
-	depends on DEBUG_KERNEL
-	select PRIME_NUMBERS
-	select DRM_LIB_RANDOM
-	select DRM_KMS_HELPER
-	select DRM_EXPORT_FOR_TESTS if m
-	default n
-	help
-	  This option provides kernel modules that can be used to run
-	  various selftests on parts of the DRM api. This option is not
-	  useful for distributions or general kernels, but only for kernel
-	  developers working on DRM and associated drivers.
-
-	  If in doubt, say "N".
-
 config DRM_KUNIT_TEST
 	bool "DRM tests" if !KUNIT_ALL_TESTS
 	depends on DRM=y && KUNIT=y
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 550800e81836..6fe8143c43e7 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -65,7 +65,7 @@ drm_kms_helper-$(CONFIG_DRM_DP_AUX_CHARDEV) += drm_dp_aux_dev.o
 drm_kms_helper-$(CONFIG_DRM_DP_CEC) += drm_dp_cec.o
 
 obj-$(CONFIG_DRM_KMS_HELPER) += drm_kms_helper.o
-obj-y += selftests/
+obj-y += test/
 
 obj-$(CONFIG_DRM)	+= drm.o
 obj-$(CONFIG_DRM_MIPI_DBI) += drm_mipi_dbi.o
diff --git a/drivers/gpu/drm/i915/Kconfig.debug b/drivers/gpu/drm/i915/Kconfig.debug
index e7fd3e76f8a2..425189f55d37 100644
--- a/drivers/gpu/drm/i915/Kconfig.debug
+++ b/drivers/gpu/drm/i915/Kconfig.debug
@@ -38,7 +38,6 @@ config DRM_I915_DEBUG
 	select DRM_VGEM # used by igt/prime_vgem (dmabuf interop checks)
 	select DRM_DEBUG_MM if DRM=y
 	select DRM_EXPORT_FOR_TESTS if m
-	select DRM_DEBUG_SELFTEST
 	select DMABUF_SELFTESTS
 	select SW_SYNC # signaling validation framework (igt/syncobj*)
 	select DRM_I915_WERROR
diff --git a/drivers/gpu/drm/selftests/drm_selftest.c b/drivers/gpu/drm/selftests/drm_selftest.c
deleted file mode 100644
index e29ed9faef5b..000000000000
--- a/drivers/gpu/drm/selftests/drm_selftest.c
+++ /dev/null
@@ -1,109 +0,0 @@
-/*
- * Copyright © 2016 Intel Corporation
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice (including the next
- * paragraph) shall be included in all copies or substantial portions of the
- * Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
- * IN THE SOFTWARE.
- */
-
-#include <linux/compiler.h>
-
-#define selftest(name, func) __idx_##name,
-enum {
-#include TESTS
-};
-#undef selftest
-
-#define selftest(n, f) [__idx_##n] = { .name = #n, .func = f },
-static struct drm_selftest {
-	bool enabled;
-	const char *name;
-	int (*func)(void *);
-} selftests[] = {
-#include TESTS
-};
-#undef selftest
-
-/* Embed the line number into the parameter name so that we can order tests */
-#define param(n) __PASTE(igt__, __PASTE(__PASTE(__LINE__, __), n))
-#define selftest_0(n, func, id) \
-module_param_named(id, selftests[__idx_##n].enabled, bool, 0400);
-#define selftest(n, func) selftest_0(n, func, param(n))
-#include TESTS
-#undef selftest
-
-static void set_default_test_all(struct drm_selftest *st, unsigned long count)
-{
-	unsigned long i;
-
-	for (i = 0; i < count; i++)
-		if (st[i].enabled)
-			return;
-
-	for (i = 0; i < count; i++)
-		st[i].enabled = true;
-}
-
-static int run_selftests(struct drm_selftest *st,
-			 unsigned long count,
-			 void *data)
-{
-	int err = 0;
-
-	set_default_test_all(st, count);
-
-	/* Tests are listed in natural order in drm_*_selftests.h */
-	for (; count--; st++) {
-		if (!st->enabled)
-			continue;
-
-		pr_debug("drm: Running %s\n", st->name);
-		err = st->func(data);
-		if (err)
-			break;
-	}
-
-	if (WARN(err > 0 || err == -ENOTTY,
-		 "%s returned %d, conflicting with selftest's magic values!\n",
-		 st->name, err))
-		err = -1;
-
-	rcu_barrier();
-	return err;
-}
-
-static int __maybe_unused
-__drm_subtests(const char *caller,
-	       const struct drm_subtest *st,
-	       int count,
-	       void *data)
-{
-	int err;
-
-	for (; count--; st++) {
-		pr_debug("Running %s/%s\n", caller, st->name);
-		err = st->func(data);
-		if (err) {
-			pr_err("%s: %s failed with error %d\n",
-			       caller, st->name, err);
-			return err;
-		}
-	}
-
-	return 0;
-}
diff --git a/drivers/gpu/drm/selftests/drm_selftest.h b/drivers/gpu/drm/selftests/drm_selftest.h
deleted file mode 100644
index c784ec02ff53..000000000000
--- a/drivers/gpu/drm/selftests/drm_selftest.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * Copyright © 2016 Intel Corporation
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice (including the next
- * paragraph) shall be included in all copies or substantial portions of the
- * Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
- * IN THE SOFTWARE.
- */
-
-#ifndef __DRM_SELFTEST_H__
-#define __DRM_SELFTEST_H__
-
-struct drm_subtest {
-	int (*func)(void *data);
-	const char *name;
-};
-
-static int __drm_subtests(const char *caller,
-			  const struct drm_subtest *st,
-			  int count,
-			  void *data);
-#define drm_subtests(T, data) \
-	__drm_subtests(__func__, T, ARRAY_SIZE(T), data)
-
-#define SUBTEST(x) { x, #x }
-
-#endif /* __DRM_SELFTEST_H__ */
diff --git a/drivers/gpu/drm/selftests/Makefile b/drivers/gpu/drm/test/Makefile
similarity index 100%
rename from drivers/gpu/drm/selftests/Makefile
rename to drivers/gpu/drm/test/Makefile
diff --git a/drivers/gpu/drm/selftests/test-drm_cmdline_parser.c b/drivers/gpu/drm/test/test-drm_cmdline_parser.c
similarity index 100%
rename from drivers/gpu/drm/selftests/test-drm_cmdline_parser.c
rename to drivers/gpu/drm/test/test-drm_cmdline_parser.c
diff --git a/drivers/gpu/drm/selftests/test-drm_damage_helper.c b/drivers/gpu/drm/test/test-drm_damage_helper.c
similarity index 100%
rename from drivers/gpu/drm/selftests/test-drm_damage_helper.c
rename to drivers/gpu/drm/test/test-drm_damage_helper.c
diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c b/drivers/gpu/drm/test/test-drm_dp_mst_helper.c
similarity index 100%
rename from drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
rename to drivers/gpu/drm/test/test-drm_dp_mst_helper.c
diff --git a/drivers/gpu/drm/selftests/test-drm_format.c b/drivers/gpu/drm/test/test-drm_format.c
similarity index 100%
rename from drivers/gpu/drm/selftests/test-drm_format.c
rename to drivers/gpu/drm/test/test-drm_format.c
diff --git a/drivers/gpu/drm/selftests/test-drm_framebuffer.c b/drivers/gpu/drm/test/test-drm_framebuffer.c
similarity index 100%
rename from drivers/gpu/drm/selftests/test-drm_framebuffer.c
rename to drivers/gpu/drm/test/test-drm_framebuffer.c
diff --git a/drivers/gpu/drm/selftests/test-drm_mm.c b/drivers/gpu/drm/test/test-drm_mm.c
similarity index 100%
rename from drivers/gpu/drm/selftests/test-drm_mm.c
rename to drivers/gpu/drm/test/test-drm_mm.c
diff --git a/drivers/gpu/drm/selftests/test-drm_plane_helper.c b/drivers/gpu/drm/test/test-drm_plane_helper.c
similarity index 100%
rename from drivers/gpu/drm/selftests/test-drm_plane_helper.c
rename to drivers/gpu/drm/test/test-drm_plane_helper.c
diff --git a/drivers/gpu/drm/selftests/test-drm_rect.c b/drivers/gpu/drm/test/test-drm_rect.c
similarity index 100%
rename from drivers/gpu/drm/selftests/test-drm_rect.c
rename to drivers/gpu/drm/test/test-drm_rect.c
-- 
2.34.1

