Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1212549124C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 00:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbiAQXYX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jan 2022 18:24:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:50746 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243793AbiAQXYW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jan 2022 18:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642461862; x=1673997862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=swnG8/c7DsJ5oPG4e35lbHo5YFh8MnajcJlYvRMPnv8=;
  b=QV+VKvNjVtD6o5Pd1NEj/99ntGDbmjSDMIhEJ/16AymqwOs2VITImc+6
   TPDrDBMMdI9nGbrDJhdh7pzeSp5weeI5roATopfTKHhn0UPm7SZVAGGTi
   Ewr+ZhetJNzCLXKc3BoSZy3z/iOessmdmzluCJU8M4mgokn0tcacZOmz/
   heCWRtzU47Ob4VjvriuYFERR5nfb4BaOUCyvImjHY/lqZh1m7rLNesYNw
   fPdMR8DulW8Htxzk+CB0+Mh8ilddkYi0y+D7WnGboTww7Vj1XQwrvvXor
   ZUkZIg0OfOTM9rRTvXpHQSQt5ceLLIl+JV1YvgZ5IQdJVDj6g58kQ6QXa
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="269082567"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="269082567"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 15:24:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="517554371"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga007.jf.intel.com with ESMTP; 17 Jan 2022 15:24:21 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 17 Jan 2022 15:24:21 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 17 Jan 2022 15:24:21 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 17 Jan 2022 15:24:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFrNGfu0Ak55TZwGFO2W89o0G4XRxXbUFeTtpiPPcAbW4/5n/XBuMbJ2jh53HlUbktpYSibr0+rXGNKXzRmmwCnRkZdN6CXyC5BzkZ6jGJ4aRJZ76q170wlo8ef4hDNTJVXsm8AX33aQNW5kKSuRkNpTa+Ny2x3VUZVxSC9DUcMD/GqzZP+Bl4ueLRsKbyRUtyE95fPEmg9yN82/241OQoa3bhVam7ZPoWlOfCmic/AKH4aHJEe0rofWN5ePzQku0mZ12j3z4qbhJXo9cJvklhCnYnsYXWq6ZempnreRGcoQhvs8DOytrtd0WGc5lUBMgRmGsMxXCH9c5zG9E/dU4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHyPfEys4IQHHru+dAQdDzI2mIXlV376xQC14vdPoSk=;
 b=O6mwV5DlTzMNwJsefk3ZkWMoe0dN5bN1FgDQHsgV6nKPov3LvmyOrI5qzB1v5PG3j2AJJQ5c+m/m8h02OS7gFZFjcy8F1KC+AV5AnL3yEVLLBsITjiwJmZ/LDwNcvRVIqiJhr+C0fzQd7sl8/wOoe9y3hJssToYm4LuzK8VVMy1kDH1SGDBBaamP77nzeb0iLGRQfn3djVqqWwX7GCVXliCEWMGGNIQr/w2GHGDXSwU70NTbbK782OelF/85o9ciwjSjOBn4pndpNg+UEQiLuYb7Z6ZP4A94GEbbo4K9bPo0VhwKpTrd/7Cc1JZfXNnGhV0Qf+Dj1h6OqB+K5PoJ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 DM6PR11MB4140.namprd11.prod.outlook.com (2603:10b6:5:19f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Mon, 17 Jan 2022 23:24:17 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::fc15:bd26:128a:f5f5]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::fc15:bd26:128a:f5f5%8]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 23:24:17 +0000
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
Subject: [RFC 03/10] drm: test-drm_format: Convert to KUnit
Date:   Tue, 18 Jan 2022 00:22:52 +0100
Message-ID: <20220117232259.180459-4-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117232259.180459-1-michal.winiarski@intel.com>
References: <20220117232259.180459-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0003.eurprd06.prod.outlook.com
 (2603:10a6:20b:462::9) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e99b73e-ca08-43ee-a9e3-08d9da107b3c
X-MS-TrafficTypeDiagnostic: DM6PR11MB4140:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB414011086B4C7796C61150FD98579@DM6PR11MB4140.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ywP3NHXO5Qk9wFnAmhSuGl5sAbtFQGEHIqiT3tBRiGOI0gVeFJa2pK5w1Pwz/v4+TVVkRiy2z6y4pQDXL9SpewsVpCbLiM341zw++hD1NDmUUFo+vbVKAjxP2eBPHDieIPoXsJu+x69XJBcFRflaM7XyqCBHb/vJrJHlGoPIVcgTYjqBH7cMwhG6a2ciQbXTY6gY4OFYzix0l4/fpl8Cn682MI5eqs2DJA21m29QYxGj8r6xRgCmdW9DKbGD+BpZv7i3d5ISlGo7hdvDVO9mSslpVNJI6/OShuWzJ53d7yr6ervQjQXpwxXbiIlGjx+t2wurFNCHM9cHbSYlsVIYooMCYTxkuu1qm5EKBdnLw2nJpNX+0enEvOswuguFbPedVLTYiwJYOKAHvBX2oXYhZ7Vd2c3XyGflUmi0lCwFxVxTlfpwxZjNMsyaCqriIBpy6dQSwg9huzDadpTuH9G3Pztgi9HzrGoRgLOuxbU9b0xg2zaE53HgpVIDEikVfhLrJKSl8lGqDWZ/oDFjrj1LSSYgwYruqML+xedBQdjTM1ZDT6BZkHk+rvy7p9gb/cb9Vuso1g/ch8Q62lIppdove2UGssp4Gh9wzOp+RGw8VnkdwMAMF75/7QMJzN04NImVjFPfEmxXlxcgTeMNkBT/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(7416002)(186003)(6506007)(82960400001)(86362001)(8676002)(6512007)(6666004)(83380400001)(38100700002)(8936002)(66556008)(30864003)(54906003)(5660300002)(2906002)(6486002)(316002)(36756003)(2616005)(66946007)(26005)(1076003)(4326008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU9XTHc2d1pvbEVKOWRBRVF0V3lJMG8wa0pJbmkyMGxiTElpSkFTR3Uramlx?=
 =?utf-8?B?NTVFUGx5b294aERBbWlVNXh3MW9CVTRPejVuYkl3d25rZnJ3R1phbDZEbndu?=
 =?utf-8?B?dmJFT29ieHhZWFdZeW91UzAzMmFuNEFtQm5Yb2ZGK2JHaHBlb1F0T3k3L2dG?=
 =?utf-8?B?UHFMeWNoR1hWM2lncktBck44M2hpbE5HNTRvOHk1ZnptZ3oyb2lLSTZCcmU4?=
 =?utf-8?B?Z3psb2pwV0ZaQ09NNHEra0s1MUtTbDNIV3UvTHl0dFFZaE9KbkNuU01tN1Rm?=
 =?utf-8?B?c2N6K3ovUUc3T0NrbWFRQkJySjhtblppTHdCZU5rbjFrNVVYWXdxeFRJcEtm?=
 =?utf-8?B?Nzl5c0d0cU9uVzlEOUM1enpPYUZCZDZVajZCZElUN25EUnBKTjFhUmo2ejdE?=
 =?utf-8?B?NWZGOHlsOS9lQlFqeFN5K3NJL2FoOUVkSkVKTFJkaUZRMXNMR1N2Q1BwSVNm?=
 =?utf-8?B?eFhRTGo5Qm1uYitmYksvVmVjT2RZd0dzSHNPbnJrVURUUGk5L1VCQUxnNFl4?=
 =?utf-8?B?VENJZmZjWjRTWENKWDNrL3o0WkRZVGtmVU9VRE1qM2Nhd2tXSGtFNGxRaFB3?=
 =?utf-8?B?aThDN1pFVjJ6TFI2TkZuZzZqclFoczN5RkNhYWRWVHlsY2JtamllYjdYTHlJ?=
 =?utf-8?B?eUM0VmJpUGRtTXpsNS9ubkx0VUNIZCs4N2R3bTZRR1U2TnYwQzUvQ2t3ZVE1?=
 =?utf-8?B?WmROV1ZYZ1E1dFdTazNSUnM1TjZkSnJLWUxMU1pQQ053OXBJZTJTRWtDUm1x?=
 =?utf-8?B?RkdUaG8wcnhLVWtlY0t2NmlUaGIvMWlPWDRsL0lsRE56ZVhDdE1wek84Y1hM?=
 =?utf-8?B?WGhHaWNVYkFlUEU4cDFvTEVOcERYNE5hK1duWFZ2SlFZbWwydGUzYzNDdEFF?=
 =?utf-8?B?cFlDMG1OL3Fra3ZzRzlYRm0yNFdPdVNHS3QxbU9XMG04T3d0N2VJMVVwNUlZ?=
 =?utf-8?B?bjJRTXladTgxUVBNRFhrekVycndJbGgvRXF1VnJXa1kvVTJoUENvNmhVOGJF?=
 =?utf-8?B?dEROeEV1NCtrdWpYYUFvcFFuME5GQUtteHc1cm1LUHdVUitpM0dkd1F6UFJy?=
 =?utf-8?B?SFVjdyt1SFBMSWlKd3hlVkxrRjB3UG1QWStNcDBTc3VzMmFLRW5Iai9jUnlO?=
 =?utf-8?B?c05XOG8vZ1dxZGF4bUdYQ2lubmxmLzVFeU04VEE3bEhZSS9SZHhFT3hTNjJo?=
 =?utf-8?B?bytaUlVjTk1ncmFlTlNsVzZ0clFFRHIxekFLM2V0WTRrTnJXNC9udWY4V1lI?=
 =?utf-8?B?V01oQVNlUTZxaTU5VUdNR3BUMGw3elE2anVZeEVPWHkvRm8valVkN2hmdDlh?=
 =?utf-8?B?RTdQRlhOZEZiM01KV2tNNEh5UmFudW1RampMVzFiVDBybnNjUG40S3dkTCtX?=
 =?utf-8?B?cDQvUm9xUGFGcnp2bjg4NVE3TlFLWlJLT0V3eThiVmh0amtqcFBDbG5RSW8z?=
 =?utf-8?B?eVp1YzFCblFuU0Zjd2hSMkFVUDZWWWsyUXZiMTFkeUlPd1k1a0hMWEZOZ3dt?=
 =?utf-8?B?d1c3NTRuVFVNSFA3Q2dnMlBHak04K0JTZ21UaWhncXVFQ2xEeTFHcGl3QXFZ?=
 =?utf-8?B?OVhiZlRYMnF1cUxkakM4R3drdlBRK2xKYWxhOVpXL2lUR0MzcGtQZ0Z4Y3Ar?=
 =?utf-8?B?M3FYK1FyTEduL3pQZDZRb1NxN3Vjb2xsQkYwMTh2c0tic3NKS0crQ2ZZa0JH?=
 =?utf-8?B?RWdzcUoyNXplVlZSL3pGUHF3eDRPOFZLNlc4QkdaZjlIVXlzVWlWS1B5UmZV?=
 =?utf-8?B?dm9EUWp1dEcvTTlGRTdBelc4ZHlka0dzYWZXSFM5Q0drRXFsc2NuaWpuVnB1?=
 =?utf-8?B?bjdQZTJpMkJNTlV4R0p0Ni9aV3U1TmRGRk5hVExqRmlCN3o2WG1NbHAzeXZ6?=
 =?utf-8?B?RHEyaU1MVFRJQmRENTNmdE9jS25hRU8wOGJDZVdCdi9yZnkzVm9HMjVTVTRn?=
 =?utf-8?B?UUFETnZnVWpvYW5OdnZHeElISVJPQWJEdmdKdHhQNTZYYmR1elRRbWRxYmdS?=
 =?utf-8?B?MXdoaEQ4a2d6QUx3OTRJYTI5dnorYjFxMUpaeE1ZbjVGKzd1NUNweU5rZDRP?=
 =?utf-8?B?NUhkWmNUVG9ITC9HcWdVRlBJWlliV29ZdUFESE01dDJXNlBiRzdoZ3ZacjVy?=
 =?utf-8?B?U2JvV2NLN3JzNC8vOW9sSWlUZFlrbEtnK1JLbHk5MFpLUGszMGFoQm9VMmty?=
 =?utf-8?B?S05QY3pNYUpPaVpYS3NxMVVYMFIyT29MREd6WCtreHpiMlMwVEhuY3ZJTDJv?=
 =?utf-8?B?NE92ZitUN2U4Yk1CenJhMVFKRFB3PT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e99b73e-ca08-43ee-a9e3-08d9da107b3c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 23:24:17.4509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mlu3DtV/Tu+n7zTZCxbthkfzgUqTYE359N2J2FBxTdGKamZ4CVVkfaWcao7OKNt2zhM+F41yvFd7BAxKM7Fv2dcb34BFSyn++bU2LswIZRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4140
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

One-to-one conversion, no functional changes.

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
---
 drivers/gpu/drm/selftests/Makefile            |   5 +-
 .../gpu/drm/selftests/drm_modeset_selftests.h |   3 -
 drivers/gpu/drm/selftests/test-drm_format.c   | 538 ++++++++++--------
 .../drm/selftests/test-drm_modeset_common.h   |   3 -
 4 files changed, 310 insertions(+), 239 deletions(-)

diff --git a/drivers/gpu/drm/selftests/Makefile b/drivers/gpu/drm/selftests/Makefile
index 82e568665ace..76c127613d1a 100644
--- a/drivers/gpu/drm/selftests/Makefile
+++ b/drivers/gpu/drm/selftests/Makefile
@@ -1,11 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test-drm_modeset-$(CONFIG_DRM_DEBUG_SELFTEST) := \
 		      test-drm_modeset_common.o \
-                      test-drm_format.o test-drm_framebuffer.o \
+                      test-drm_framebuffer.o \
 		      test-drm_damage_helper.o test-drm_dp_mst_helper.o \
 		      test-drm_rect.o
 
 obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o test-drm_modeset.o
 
 obj-$(CONFIG_DRM_KUNIT_TEST) := \
-	test-drm_cmdline_parser.o test-drm_plane_helper.o
+	test-drm_cmdline_parser.o test-drm_plane_helper.o \
+	test-drm_format.o
diff --git a/drivers/gpu/drm/selftests/drm_modeset_selftests.h b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
index 19d1142725c6..5f253d9e573c 100644
--- a/drivers/gpu/drm/selftests/drm_modeset_selftests.h
+++ b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
@@ -10,9 +10,6 @@ selftest(drm_rect_clip_scaled_div_by_zero, igt_drm_rect_clip_scaled_div_by_zero)
 selftest(drm_rect_clip_scaled_not_clipped, igt_drm_rect_clip_scaled_not_clipped)
 selftest(drm_rect_clip_scaled_clipped, igt_drm_rect_clip_scaled_clipped)
 selftest(drm_rect_clip_scaled_signed_vs_unsigned, igt_drm_rect_clip_scaled_signed_vs_unsigned)
-selftest(check_drm_format_block_width, igt_check_drm_format_block_width)
-selftest(check_drm_format_block_height, igt_check_drm_format_block_height)
-selftest(check_drm_format_min_pitch, igt_check_drm_format_min_pitch)
 selftest(check_drm_framebuffer_create, igt_check_drm_framebuffer_create)
 selftest(damage_iter_no_damage, igt_damage_iter_no_damage)
 selftest(damage_iter_no_damage_fractional_src, igt_damage_iter_no_damage_fractional_src)
diff --git a/drivers/gpu/drm/selftests/test-drm_format.c b/drivers/gpu/drm/selftests/test-drm_format.c
index c5e212afa27a..2774990768a7 100644
--- a/drivers/gpu/drm/selftests/test-drm_format.c
+++ b/drivers/gpu/drm/selftests/test-drm_format.c
@@ -3,278 +3,354 @@
  * Test cases for the drm_format functions
  */
 
-#define pr_fmt(fmt) "drm_format: " fmt
-
-#include <linux/errno.h>
-#include <linux/kernel.h>
+#include <kunit/test.h>
 
 #include <drm/drm_fourcc.h>
 
-#include "test-drm_modeset_common.h"
-
-int igt_check_drm_format_block_width(void *ignored)
+static void drm_format_block_width_invalid(struct kunit *test)
 {
 	const struct drm_format_info *info = NULL;
 
 	/* Test invalid arguments */
-	FAIL_ON(drm_format_info_block_width(info, 0) != 0);
-	FAIL_ON(drm_format_info_block_width(info, -1) != 0);
-	FAIL_ON(drm_format_info_block_width(info, 1) != 0);
-
-	/* Test 1 plane format */
-	info = drm_format_info(DRM_FORMAT_XRGB4444);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_block_width(info, 0) != 1);
-	FAIL_ON(drm_format_info_block_width(info, 1) != 0);
-	FAIL_ON(drm_format_info_block_width(info, -1) != 0);
-
-	/* Test 2 planes format */
-	info = drm_format_info(DRM_FORMAT_NV12);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_block_width(info, 0) != 1);
-	FAIL_ON(drm_format_info_block_width(info, 1) != 1);
-	FAIL_ON(drm_format_info_block_width(info, 2) != 0);
-	FAIL_ON(drm_format_info_block_width(info, -1) != 0);
-
-	/* Test 3 planes format */
-	info = drm_format_info(DRM_FORMAT_YUV422);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_block_width(info, 0) != 1);
-	FAIL_ON(drm_format_info_block_width(info, 1) != 1);
-	FAIL_ON(drm_format_info_block_width(info, 2) != 1);
-	FAIL_ON(drm_format_info_block_width(info, 3) != 0);
-	FAIL_ON(drm_format_info_block_width(info, -1) != 0);
-
-	/* Test a tiled format */
-	info = drm_format_info(DRM_FORMAT_X0L0);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_block_width(info, 0) != 2);
-	FAIL_ON(drm_format_info_block_width(info, 1) != 0);
-	FAIL_ON(drm_format_info_block_width(info, -1) != 0);
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_width(info, 0), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_width(info, -1), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_width(info, 1), 0);
+}
+
+static void drm_format_block_width_one_plane(struct kunit *test)
+{
+	const struct drm_format_info *info = drm_format_info(DRM_FORMAT_XRGB4444);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_width(info, 0), 1);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_width(info, 1), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_width(info, -1), 0);
+}
+
+static void drm_format_block_width_two_plane(struct kunit *test)
+{
+	const struct drm_format_info *info = drm_format_info(DRM_FORMAT_NV12);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_width(info, 0), 1);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_width(info, 1), 1);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_width(info, 2), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_width(info, -1), 0);
 }
 
-int igt_check_drm_format_block_height(void *ignored)
+static void drm_format_block_width_three_plane(struct kunit *test)
+{
+	const struct drm_format_info *info = drm_format_info(DRM_FORMAT_YUV422);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_width(info, 0), 1);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_width(info, 1), 1);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_width(info, 2), 1);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_width(info, 3), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_width(info, -1), 0);
+}
+
+static void drm_format_block_width_tiled(struct kunit *test)
+{
+	const struct drm_format_info *info = drm_format_info(DRM_FORMAT_X0L0);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_width(info, 0), 2);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_width(info, 1), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_width(info, -1), 0);
+}
+
+static void drm_format_block_height_invalid(struct kunit *test)
 {
 	const struct drm_format_info *info = NULL;
 
-	/* Test invalid arguments */
-	FAIL_ON(drm_format_info_block_height(info, 0) != 0);
-	FAIL_ON(drm_format_info_block_height(info, -1) != 0);
-	FAIL_ON(drm_format_info_block_height(info, 1) != 0);
-
-	/* Test 1 plane format */
-	info = drm_format_info(DRM_FORMAT_XRGB4444);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_block_height(info, 0) != 1);
-	FAIL_ON(drm_format_info_block_height(info, 1) != 0);
-	FAIL_ON(drm_format_info_block_height(info, -1) != 0);
-
-	/* Test 2 planes format */
-	info = drm_format_info(DRM_FORMAT_NV12);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_block_height(info, 0) != 1);
-	FAIL_ON(drm_format_info_block_height(info, 1) != 1);
-	FAIL_ON(drm_format_info_block_height(info, 2) != 0);
-	FAIL_ON(drm_format_info_block_height(info, -1) != 0);
-
-	/* Test 3 planes format */
-	info = drm_format_info(DRM_FORMAT_YUV422);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_block_height(info, 0) != 1);
-	FAIL_ON(drm_format_info_block_height(info, 1) != 1);
-	FAIL_ON(drm_format_info_block_height(info, 2) != 1);
-	FAIL_ON(drm_format_info_block_height(info, 3) != 0);
-	FAIL_ON(drm_format_info_block_height(info, -1) != 0);
-
-	/* Test a tiled format */
-	info = drm_format_info(DRM_FORMAT_X0L0);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_block_height(info, 0) != 2);
-	FAIL_ON(drm_format_info_block_height(info, 1) != 0);
-	FAIL_ON(drm_format_info_block_height(info, -1) != 0);
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_height(info, 0), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_height(info, -1), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_height(info, 1), 0);
 }
 
-int igt_check_drm_format_min_pitch(void *ignored)
+static void drm_format_block_height_one_plane(struct kunit *test)
+{
+	const struct drm_format_info *info = drm_format_info(DRM_FORMAT_XRGB4444);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_height(info, 0), 1);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_height(info, 1), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_height(info, -1), 0);
+}
+
+static void drm_format_block_height_two_plane(struct kunit *test)
+{
+	const struct drm_format_info *info = drm_format_info(DRM_FORMAT_NV12);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_height(info, 0), 1);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_height(info, 1), 1);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_height(info, 2), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_height(info, -1), 0);
+}
+
+static void drm_format_block_height_three_plane(struct kunit *test)
+{
+	const struct drm_format_info *info = drm_format_info(DRM_FORMAT_YUV422);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_height(info, 0), 1);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_height(info, 1), 1);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_height(info, 2), 1);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_height(info, 3), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_height(info, -1), 0);
+}
+
+static void drm_format_block_height_tiled(struct kunit *test)
+{
+	const struct drm_format_info *info = drm_format_info(DRM_FORMAT_X0L0);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_height(info, 0), 2);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_height(info, 1), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_height(info, -1), 0);
+}
+
+static void drm_format_min_pitch_invalid(struct kunit *test)
 {
 	const struct drm_format_info *info = NULL;
 
-	/* Test invalid arguments */
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, -1, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 0) != 0);
-
-	/* Test 1 plane 8 bits per pixel format */
-	info = drm_format_info(DRM_FORMAT_RGB332);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, -1, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 0) != 0);
-
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1) != 1);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 2) != 2);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 640) != 640);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1024) != 1024);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1920) != 1920);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 4096) != 4096);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 671) != 671);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, UINT_MAX) !=
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 0), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, -1, 0), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 0), 0);
+}
+
+static void drm_format_min_pitch_one_plane_8bpp(struct kunit *test)
+{
+	const struct drm_format_info *info = drm_format_info(DRM_FORMAT_RGB332);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 0), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, -1, 0), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 0), 0);
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1), 1);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 2), 2);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 640), 640);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1024), 1024);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1920), 1920);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 4096), 4096);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 671), 671);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, UINT_MAX),
 			(uint64_t)UINT_MAX);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, (UINT_MAX - 1)) !=
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, (UINT_MAX - 1)),
 			(uint64_t)(UINT_MAX - 1));
+}
 
-	/* Test 1 plane 16 bits per pixel format */
-	info = drm_format_info(DRM_FORMAT_XRGB4444);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, -1, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 0) != 0);
-
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1) != 2);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 2) != 4);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 640) != 1280);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1024) != 2048);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1920) != 3840);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 4096) != 8192);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 671) != 1342);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, UINT_MAX) !=
+static void drm_format_min_pitch_one_plane_16bpp(struct kunit *test)
+{
+	const struct drm_format_info *info = drm_format_info(DRM_FORMAT_XRGB4444);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 0), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, -1, 0), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 0), 0);
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1), 2);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 2), 4);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 640), 1280);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1024), 2048);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1920), 3840);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 4096), 8192);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 671), 1342);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, UINT_MAX),
 			(uint64_t)UINT_MAX * 2);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, (UINT_MAX - 1)) !=
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, (UINT_MAX - 1)),
 			(uint64_t)(UINT_MAX - 1) * 2);
+}
 
-	/* Test 1 plane 24 bits per pixel format */
-	info = drm_format_info(DRM_FORMAT_RGB888);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, -1, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 0) != 0);
-
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1) != 3);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 2) != 6);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 640) != 1920);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1024) != 3072);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1920) != 5760);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 4096) != 12288);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 671) != 2013);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, UINT_MAX) !=
+static void drm_format_min_pitch_one_plane_24bpp(struct kunit *test)
+{
+	const struct drm_format_info *info = drm_format_info(DRM_FORMAT_RGB888);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 0), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, -1, 0), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 0), 0);
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1), 3);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 2), 6);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 640), 1920);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1024), 3072);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1920), 5760);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 4096), 12288);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 671), 2013);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, UINT_MAX),
 			(uint64_t)UINT_MAX * 3);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, UINT_MAX - 1) !=
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, UINT_MAX - 1),
 			(uint64_t)(UINT_MAX - 1) * 3);
+}
 
-	/* Test 1 plane 32 bits per pixel format */
-	info = drm_format_info(DRM_FORMAT_ABGR8888);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, -1, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 0) != 0);
-
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1) != 4);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 2) != 8);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 640) != 2560);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1024) != 4096);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1920) != 7680);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 4096) != 16384);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 671) != 2684);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, UINT_MAX) !=
+static void drm_format_min_pitch_one_plane_32bpp(struct kunit *test)
+{
+	const struct drm_format_info *info = drm_format_info(DRM_FORMAT_ABGR8888);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 0), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, -1, 0), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 0), 0);
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1), 4);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 2), 8);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 640), 2560);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1024), 4096);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1920), 7680);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 4096), 16384);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 671), 2684);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, UINT_MAX),
 			(uint64_t)UINT_MAX * 4);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, UINT_MAX - 1) !=
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, UINT_MAX - 1),
 			(uint64_t)(UINT_MAX - 1) * 4);
+}
 
-	/* Test 2 planes format */
-	info = drm_format_info(DRM_FORMAT_NV12);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, -1, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, 2, 0) != 0);
-
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1) != 1);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 1) != 2);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 2) != 2);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 1) != 2);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 640) != 640);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 320) != 640);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1024) != 1024);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 512) != 1024);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1920) != 1920);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 960) != 1920);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 4096) != 4096);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 2048) != 4096);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 671) != 671);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 336) != 672);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, UINT_MAX) !=
+static void drm_format_min_pitch_two_plane(struct kunit *test)
+{
+	const struct drm_format_info *info = drm_format_info(DRM_FORMAT_NV12);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 0), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 0), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, -1, 0), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 2, 0), 0);
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1), 1);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 1), 2);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 2), 2);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 1), 2);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 640), 640);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 320), 640);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1024), 1024);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 512), 1024);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1920), 1920);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 960), 1920);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 4096), 4096);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 2048), 4096);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 671), 671);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 336), 672);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, UINT_MAX),
 			(uint64_t)UINT_MAX);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, UINT_MAX / 2 + 1) !=
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, UINT_MAX / 2 + 1),
 			(uint64_t)UINT_MAX + 1);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, (UINT_MAX - 1)) !=
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, (UINT_MAX - 1)),
 			(uint64_t)(UINT_MAX - 1));
-	FAIL_ON(drm_format_info_min_pitch(info, 1, (UINT_MAX - 1) /  2) !=
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, (UINT_MAX - 1) /  2),
 			(uint64_t)(UINT_MAX - 1));
+}
 
-	/* Test 3 planes 8 bits per pixel format */
-	info = drm_format_info(DRM_FORMAT_YUV422);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, 2, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, -1, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, 3, 0) != 0);
-
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1) != 1);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 1) != 1);
-	FAIL_ON(drm_format_info_min_pitch(info, 2, 1) != 1);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 2) != 2);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 2) != 2);
-	FAIL_ON(drm_format_info_min_pitch(info, 2, 2) != 2);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 640) != 640);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 320) != 320);
-	FAIL_ON(drm_format_info_min_pitch(info, 2, 320) != 320);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1024) != 1024);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 512) != 512);
-	FAIL_ON(drm_format_info_min_pitch(info, 2, 512) != 512);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1920) != 1920);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 960) != 960);
-	FAIL_ON(drm_format_info_min_pitch(info, 2, 960) != 960);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 4096) != 4096);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 2048) != 2048);
-	FAIL_ON(drm_format_info_min_pitch(info, 2, 2048) != 2048);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 671) != 671);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 336) != 336);
-	FAIL_ON(drm_format_info_min_pitch(info, 2, 336) != 336);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, UINT_MAX) !=
+static void drm_format_min_pitch_three_plane_8bpp(struct kunit *test)
+{
+	const struct drm_format_info *info = drm_format_info(DRM_FORMAT_YUV422);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 0), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 0), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 2, 0), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, -1, 0), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 3, 0), 0);
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1), 1);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 1), 1);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 2, 1), 1);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 2), 2);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 2), 2);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 2, 2), 2);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 640), 640);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 320), 320);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 2, 320), 320);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1024), 1024);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 512), 512);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 2, 512), 512);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1920), 1920);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 960), 960);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 2, 960), 960);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 4096), 4096);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 2048), 2048);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 2, 2048), 2048);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 671), 671);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 336), 336);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 2, 336), 336);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, UINT_MAX),
 			(uint64_t)UINT_MAX);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, UINT_MAX / 2 + 1) !=
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, UINT_MAX / 2 + 1),
 			(uint64_t)UINT_MAX / 2 + 1);
-	FAIL_ON(drm_format_info_min_pitch(info, 2, UINT_MAX / 2 + 1) !=
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 2, UINT_MAX / 2 + 1),
 			(uint64_t)UINT_MAX / 2 + 1);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, (UINT_MAX - 1) / 2) !=
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, (UINT_MAX - 1) / 2),
 			(uint64_t)(UINT_MAX - 1) / 2);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, (UINT_MAX - 1) / 2) !=
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, (UINT_MAX - 1) / 2),
 			(uint64_t)(UINT_MAX - 1) / 2);
-	FAIL_ON(drm_format_info_min_pitch(info, 2, (UINT_MAX - 1) / 2) !=
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 2, (UINT_MAX - 1) / 2),
 			(uint64_t)(UINT_MAX - 1) / 2);
+}
 
-	/* Test tiled format */
-	info = drm_format_info(DRM_FORMAT_X0L2);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, -1, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 0) != 0);
-
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1) != 2);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 2) != 4);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 640) != 1280);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1024) != 2048);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1920) != 3840);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 4096) != 8192);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 671) != 1342);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, UINT_MAX) !=
+static void drm_format_min_pitch_tiled(struct kunit *test)
+{
+	const struct drm_format_info *info = drm_format_info(DRM_FORMAT_X0L2);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 0), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, -1, 0), 0);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 0), 0);
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1), 2);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 2), 4);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 640), 1280);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1024), 2048);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1920), 3840);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 4096), 8192);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 671), 1342);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, UINT_MAX),
 			(uint64_t)UINT_MAX * 2);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, UINT_MAX - 1) !=
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, UINT_MAX - 1),
 			(uint64_t)(UINT_MAX - 1) * 2);
-
-	return 0;
 }
+
+static struct kunit_case drm_format_tests[] = {
+	KUNIT_CASE(drm_format_block_width_invalid),
+	KUNIT_CASE(drm_format_block_width_one_plane),
+	KUNIT_CASE(drm_format_block_width_two_plane),
+	KUNIT_CASE(drm_format_block_width_three_plane),
+	KUNIT_CASE(drm_format_block_width_tiled),
+	KUNIT_CASE(drm_format_block_height_invalid),
+	KUNIT_CASE(drm_format_block_height_one_plane),
+	KUNIT_CASE(drm_format_block_height_two_plane),
+	KUNIT_CASE(drm_format_block_height_three_plane),
+	KUNIT_CASE(drm_format_block_height_tiled),
+	KUNIT_CASE(drm_format_min_pitch_invalid),
+	KUNIT_CASE(drm_format_min_pitch_one_plane_8bpp),
+	KUNIT_CASE(drm_format_min_pitch_one_plane_16bpp),
+	KUNIT_CASE(drm_format_min_pitch_one_plane_24bpp),
+	KUNIT_CASE(drm_format_min_pitch_one_plane_32bpp),
+	KUNIT_CASE(drm_format_min_pitch_two_plane),
+	KUNIT_CASE(drm_format_min_pitch_three_plane_8bpp),
+	KUNIT_CASE(drm_format_min_pitch_tiled),
+	{}
+};
+
+static struct kunit_suite drm_format_test_suite = {
+	.name = "drm_format_tests",
+	.test_cases = drm_format_tests,
+};
+
+kunit_test_suite(drm_format_test_suite);
diff --git a/drivers/gpu/drm/selftests/test-drm_modeset_common.h b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
index 8744fd840406..f6cfce2a5863 100644
--- a/drivers/gpu/drm/selftests/test-drm_modeset_common.h
+++ b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
@@ -20,9 +20,6 @@ int igt_drm_rect_clip_scaled_div_by_zero(void *ignored);
 int igt_drm_rect_clip_scaled_not_clipped(void *ignored);
 int igt_drm_rect_clip_scaled_clipped(void *ignored);
 int igt_drm_rect_clip_scaled_signed_vs_unsigned(void *ignored);
-int igt_check_drm_format_block_width(void *ignored);
-int igt_check_drm_format_block_height(void *ignored);
-int igt_check_drm_format_min_pitch(void *ignored);
 int igt_check_drm_framebuffer_create(void *ignored);
 int igt_damage_iter_no_damage(void *ignored);
 int igt_damage_iter_no_damage_fractional_src(void *ignored);
-- 
2.34.1

