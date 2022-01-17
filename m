Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE48F491253
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 00:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243797AbiAQXYt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jan 2022 18:24:49 -0500
Received: from mga12.intel.com ([192.55.52.136]:55081 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243793AbiAQXYs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jan 2022 18:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642461888; x=1673997888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=quUmjOVA9Wz2OOMMVV+W8akBlwHVso4xSDK0aYlLTGI=;
  b=OlXOnKlV6ugWD5ARL2tN9kNMTQUyfenrjREDeWgA6z5+IrNeeuH/bUkW
   oUkcG7dIX96Dla0V7Eu+Id1CupFf6pBESBNroQAZSgN7tlAU1ZBB1RzJ0
   fUk7vuYod1q/uG0CwmL9DpajhW5ePOJb7HQ5eqDvZ7Vxl2Mz+K0SRcADJ
   x3yPC6bdw1uJDz1+THb/KQsJazC4cc817sxre8T67xv7C5pLv0a3pTdl7
   97RLhcLGXW1HmnQwImQZtrc8SIPRjqV9VNwcscjKrcGzOfeoQ1dFuraSy
   VmRLc9nsh1sSul4RZJE0qt32sv/tY9W3P17iyocVwedvtSgwq1ccLD5TW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="224683773"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="224683773"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 15:24:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="517554427"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga007.jf.intel.com with ESMTP; 17 Jan 2022 15:24:48 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 17 Jan 2022 15:24:47 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 17 Jan 2022 15:24:47 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 17 Jan 2022 15:24:47 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 17 Jan 2022 15:24:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLLmztMb7BhOJ6vS30/zz6+faR0H7kzaMMWcF1czJOB8w75pRCMAY2y5SEoOgJv9O5koyyj9V7tRepLgkY8NFmJgUxQ9LdxH0ZLvnwRZhjDfW/tVf0yDa3wcT1kufx0aYXgqarVcINx7RFDxySiAYdFl+OlQH+84At5z7xl/tt5tPQ3t5EQ6WQLc9E+YIx1OGn1XefMDGK2BdWyvy5s4of01kvGZCqQ3KZRlhNCYhSxC1/37LZjatR9h/AYLFoX7R/CseLsidSozwU2uF58MeW8fNP/QDpn6dk/+Uh/Lut7VTlhcDvu7Rki7WJB2EYjHKGwTVGBTCirbSbH9NGYHdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeXNZdnDA2vS/Z+sC48PAkzUL7vTuZlZ96DW0e/2av4=;
 b=D8DQdm5mwQeBRThi4vUacMTekNH4f8vCaBTNqE/pEKe2Oae7g6UXxOSuEDArDgd6hFGhFaNrE48ae/lUINiippDSLv2F5mIFuHqZjSv38jx1EjbE/FDNx5S3cUfveHye+BHonXeb2vw7clTP+ytDU2fFx1KOD37awNxNcoyfPpuIVP7hlDgxiseGqhVpTWedT1ld3bocTgapf/PTknRDYC+bYm1su0bRTDw8s9WH38ga4sRAjRoFdr0yVrWUKCEWaRl1mHdmFjdDZxKkpWynciNfR/p/SFgxnmCbOTO3B3TSwlPGEpfymcjXWfkiVDinGVNsZO5QDiFhXTdakNkCGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 DM4PR11MB5550.namprd11.prod.outlook.com (2603:10b6:5:38b::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.9; Mon, 17 Jan 2022 23:24:43 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::fc15:bd26:128a:f5f5]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::fc15:bd26:128a:f5f5%8]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 23:24:43 +0000
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
Subject: [RFC 07/10] drm: test-drm_rect: Convert to KUnit
Date:   Tue, 18 Jan 2022 00:22:56 +0100
Message-ID: <20220117232259.180459-8-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117232259.180459-1-michal.winiarski@intel.com>
References: <20220117232259.180459-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8P251CA0016.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:2f2::11) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcea89ac-3b72-43c0-3401-08d9da108adf
X-MS-TrafficTypeDiagnostic: DM4PR11MB5550:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM4PR11MB55503231545B863916E3FB5A98579@DM4PR11MB5550.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:549;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u5Hzi/IG4KCGfvStsW6TLkay3yvPHjzUXKvjo942EBv7/21VSEHSsmUqLkrDE7C+cR32Sip359MHEvySdnKf1/AUz/sR9kE2MycDTU22C0VJ7gbifXVkVmqQuHd9640tsV/0nI4oCLQZVhvZvgQ7VfNxDlqTy9BNsgLMVcyCojE2aONsgHGamwnXEPh4u9LgAM5hqrqTDt+wKsZXNypQr4EGRiaNb5l4NVNU2UMh7PEFbYi+LK4V/Q57/L1cFrfmcfgEMjphkJXUievR923WS2KMjnr4cRBVGPUPE80654W9WZLuraOUSPBfstavStcpswp+Cy463BqzBMVA2z/00ayp+VW0gIh0etvBGxxkR6j//IyOoo36exn8iucU+RoCymbhcRQurodcLcoFuq2Sn3b7b9XluIZADFNQOWD3aNOJO/BfW1SHNhvTBXObOfTT9aohSEvXPKUjkTpZJ0p+HR9eTpfPLRfo38znrDxzb57tF5+Fo46NcLOHAnsPhz0vASfyvDDK9gjFxb89XEe1T00dhTF/sUpWYdnVdaRZO1BYPUebGCTBhnKMDe2ix5SooSBTEp7wczIgZLau83u2FzXN7GzG1i6XpF1o0hlb9KMH6VNU8Pu9BQz0QR3FAeI8IXG1pjVstOBJmuWpcmKFlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(82960400001)(4326008)(5660300002)(36756003)(186003)(6506007)(7416002)(1076003)(54906003)(6512007)(83380400001)(26005)(66946007)(66476007)(66556008)(316002)(6486002)(38100700002)(8936002)(508600001)(2906002)(30864003)(6666004)(8676002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2tEZG5ac0FDNG9qZ0FsbGpnWExZQWNTaGNBdGcxTlhoOHVqdElFVTdBZzEx?=
 =?utf-8?B?enN1STlrQkUveVk0YkUwVlhLTE5pRHRDOVpFZ1FlYUlHYmo3NDhFWGEwZWg5?=
 =?utf-8?B?RS9YeVh6OW0yZzMycVN6T0s3NE16aWppVnNEOHlaR0x4VkJDR3lXa2wxTnhz?=
 =?utf-8?B?bDNuZ1AyQmpyQzh2N1YzMlV6R1NSUGk2QmNVY3JMRXR2c2tqODZBOGwyQTBG?=
 =?utf-8?B?aUxHT0x3Z1A1MnFxTzBZOXZQTEVlSWhCcDZRTERoMlpBY3JtdmRvRUpXbHJC?=
 =?utf-8?B?bnJyaG9lOWhLZ003a2pQdEpqMVJHYlJSbVM5NzloaG1PRE42elova0FhOFd6?=
 =?utf-8?B?S01BK0QrS1lhVHRpTWtFVEtEL0ZNWFBMZEtyK2ZHRlhnMGVmWDJuU09TSFBv?=
 =?utf-8?B?Q05ZanBWYWZIUHFRRFJRRkZncTVFMFVYSDhPeGs5UXVjWERGOWliOW1zeFdL?=
 =?utf-8?B?QVlBeTRURzFXY29Gckd1TmdSV0kvbHZVSGNIL2w2ZUx5eGc3ak5VUEJGSGRk?=
 =?utf-8?B?TmViUkYwcW5QSHp1MWlmditCbWVJNmJKQlNNNmdiUmtSb1lnVmVSYU51cUxW?=
 =?utf-8?B?MFlSQmw0TUp6dC9BbkpkU0dvQTByN3R5YU9Qa0xHNXBPcENLaUJQRXJ2QXVC?=
 =?utf-8?B?VGZRdWlqYnA1SURxM2t4cUZ3MEVCcTZ4blJRcWUvcytha1pqbWVVdW9nWFhs?=
 =?utf-8?B?ZmdzSytqTzl5RFR2SzZoR1QzcW1vWVJMUjhBQmxZaXhCbEdMSTVQMGVjMG9k?=
 =?utf-8?B?QkVxeWFnYkJRVGFJbFBnbkVzdDZZd1NiZmZNbWQ1cGVhYzdZQmRVdWVud1lo?=
 =?utf-8?B?aTJpZUtOZDNQV0hzY2xIV1pwMmVreGhONkhtUXZGRnd1KzQwSFZSM1pJczQv?=
 =?utf-8?B?aFA3RWpxOXZRcUIwdlI2R3VwaDgxdUZGcjRnbkVYcFJ5a3RmU2NoSUJVTkE5?=
 =?utf-8?B?SGxndGhIV3UydzhrcnhrWXJsdWlKQ1BBTmx6cUU3Z0l6TTF6ZEhJU1BwWXhy?=
 =?utf-8?B?NVhNVkwzZ21hQWF0Qm92dTVPOHRHK1ZHL1lhbmlldUE2N1JycnRMMG9KZFFr?=
 =?utf-8?B?UkpXWkJkbmJiYnZPVTRVNUlHUWEyVnFob0VQTlQweWwrSnlwL1d3bEFaR3dk?=
 =?utf-8?B?MmpyQ1puM2pkbDlRQlJsNTBwa0Z3SEQyVEVWUFY3Y1JuVUZaU3VDdjFZZ0w5?=
 =?utf-8?B?Y3FMcTB1c3pHQmdCdit5eEtpK0luNkdwYXphSlovUzhyQWxyQXNmbUs1MFo4?=
 =?utf-8?B?WUFxOU5VQzNYR2NkRDRSQWt0M2FrYmRHd0ZybTl2RW5McVJVMG9Yb1dQdzJ5?=
 =?utf-8?B?bnJhMjFDL0dMbVRIYzF1ZlR3UmVzYkl6VC9RR2ZDR1A3WFJIdjdja3Y2Y25v?=
 =?utf-8?B?Y2lLNll6cXQ1SXk5UGs0eXdRY0NXMTFPNDR0eFNGTUpoWWQyeTJCSXZvRkp3?=
 =?utf-8?B?aXVoRnpBRGp4d09oaStmK1hQOVRRc1ZnMVhOMzRWWEc2emNzM0o2OHRiMG1p?=
 =?utf-8?B?TUE2UnhOU2ZCRGRpR3NES1kvUmI4dktJQit6ZFBUUWxWZ0tqUnN0SUY3Z2xH?=
 =?utf-8?B?WmFReDhNaHEydE5WeDZDT2Z4cXVDTkpxQ0JQcVY2NjFpSWFDT2pnWDRTTGxN?=
 =?utf-8?B?dkFpNE1HWkh4eDBndDIrd2JYaWlVWnVaTmN6SGEvcWl2eXhzeEdrbUxyZFJ6?=
 =?utf-8?B?OGQzbWJ4b0lhL01TaHhFbDgxVjhhUlJzeWp0d1ZJTlc5LzJoV0xCbHJSektL?=
 =?utf-8?B?Zk1WWTRMeERCR25kMEY4NnNzSDhjekJSaXc4eTlkMGlWTnM4bWVzaGxEVGJK?=
 =?utf-8?B?dXhVdjJzTVdSSHNzOTJXVkwyWkpnVWJtUkpTZVA0YVNSeHg5QVRCalNkczdC?=
 =?utf-8?B?S2RlLzBhU1gveFhMUFhKRjkzSFNBOXhqbHVRWWEvcXdYSFNRaWRmRXBUL1hG?=
 =?utf-8?B?NDAza2lDdElrWXNtamVCU21jZ3VhUVJiSFN1dnZSL2lCdEwzSG02SXFidXdT?=
 =?utf-8?B?c05WZkMwMWViUW4wYVRmeWt3VG5nZktBSWFvTFlHeXVjSVdQVmJwUUpnd2lK?=
 =?utf-8?B?YnNFdkl5U2o4S0cvNlN3blIrRUhoYzF2MnhibGkzdzNORW9VckoyTEVmQVlD?=
 =?utf-8?B?NWpQRWlxclBKbGp3TlBmVWtCVVJvbG4vc1JWVTAzZHMyZWd3SFlGNFg1a2tq?=
 =?utf-8?B?ZEpKYWtidUpQVFpjQTZ5TEJOdDdycm5Ra3NnM1l4Y3lPSDdycUpJeEFPcUFi?=
 =?utf-8?B?L1ExdTUydnpXWTcybDVJV1NUVmZ3PT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fcea89ac-3b72-43c0-3401-08d9da108adf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 23:24:43.5709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GE/y6zwZdaXuLHlwAa8iKXkyV71L7OOH+bLXHYya68FHAjeAmMjghZI47+VoHN8EOrzpszJ1TBfXIkZ5P0BzK3iIHbnbIT02Nug26ULEjrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5550
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

One-to-one conversion, no functional changes.

Now that all of the modeset selftests were converted, remove the helpers
that are no longer used.

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
---
 drivers/gpu/drm/selftests/Makefile            |   8 +-
 .../gpu/drm/selftests/drm_modeset_selftests.h |  12 -
 .../drm/selftests/test-drm_modeset_common.c   |  32 ---
 .../drm/selftests/test-drm_modeset_common.h   |  24 --
 drivers/gpu/drm/selftests/test-drm_rect.c     | 212 ++++++++++--------
 5 files changed, 122 insertions(+), 166 deletions(-)
 delete mode 100644 drivers/gpu/drm/selftests/drm_modeset_selftests.h
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_modeset_common.c
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_modeset_common.h

diff --git a/drivers/gpu/drm/selftests/Makefile b/drivers/gpu/drm/selftests/Makefile
index 77e37eebf099..2d524eddb4e3 100644
--- a/drivers/gpu/drm/selftests/Makefile
+++ b/drivers/gpu/drm/selftests/Makefile
@@ -1,11 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
-test-drm_modeset-$(CONFIG_DRM_DEBUG_SELFTEST) := \
-		      test-drm_modeset_common.o \
-		      test-drm_rect.o
 
-obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o test-drm_modeset.o
+obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o
 
 obj-$(CONFIG_DRM_KUNIT_TEST) := \
 	test-drm_cmdline_parser.o test-drm_plane_helper.o \
 	test-drm_format.o test-drm_framebuffer.o \
-	test-drm_damage_helper.o test-drm_dp_mst_helper.o
+	test-drm_damage_helper.o test-drm_dp_mst_helper.o \
+	test-drm_rect.o
diff --git a/drivers/gpu/drm/selftests/drm_modeset_selftests.h b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
deleted file mode 100644
index 630770d30aba..000000000000
--- a/drivers/gpu/drm/selftests/drm_modeset_selftests.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* List each unit test as selftest(name, function)
- *
- * The name is used as both an enum and expanded as igt__name to create
- * a module parameter. It must be unique and legal for a C identifier.
- *
- * Tests are executed in order by igt/drm_selftests_helper
- */
-selftest(drm_rect_clip_scaled_div_by_zero, igt_drm_rect_clip_scaled_div_by_zero)
-selftest(drm_rect_clip_scaled_not_clipped, igt_drm_rect_clip_scaled_not_clipped)
-selftest(drm_rect_clip_scaled_clipped, igt_drm_rect_clip_scaled_clipped)
-selftest(drm_rect_clip_scaled_signed_vs_unsigned, igt_drm_rect_clip_scaled_signed_vs_unsigned)
diff --git a/drivers/gpu/drm/selftests/test-drm_modeset_common.c b/drivers/gpu/drm/selftests/test-drm_modeset_common.c
deleted file mode 100644
index 2a7f93774006..000000000000
--- a/drivers/gpu/drm/selftests/test-drm_modeset_common.c
+++ /dev/null
@@ -1,32 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Common file for modeset selftests.
- */
-
-#include <linux/module.h>
-
-#include "test-drm_modeset_common.h"
-
-#define TESTS "drm_modeset_selftests.h"
-#include "drm_selftest.h"
-
-#include "drm_selftest.c"
-
-static int __init test_drm_modeset_init(void)
-{
-	int err;
-
-	err = run_selftests(selftests, ARRAY_SIZE(selftests), NULL);
-
-	return err > 0 ? 0 : err;
-}
-
-static void __exit test_drm_modeset_exit(void)
-{
-}
-
-module_init(test_drm_modeset_init);
-module_exit(test_drm_modeset_exit);
-
-MODULE_AUTHOR("Intel Corporation");
-MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/selftests/test-drm_modeset_common.h b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
deleted file mode 100644
index c7cc5edc65f1..000000000000
--- a/drivers/gpu/drm/selftests/test-drm_modeset_common.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef __TEST_DRM_MODESET_COMMON_H__
-#define __TEST_DRM_MODESET_COMMON_H__
-
-#include <linux/errno.h>
-#include <linux/printk.h>
-
-#define FAIL(test, msg, ...) \
-	do { \
-		if (test) { \
-			pr_err("%s/%u: " msg, __FUNCTION__, __LINE__, ##__VA_ARGS__); \
-			return -EINVAL; \
-		} \
-	} while (0)
-
-#define FAIL_ON(x) FAIL((x), "%s", "FAIL_ON(" __stringify(x) ")\n")
-
-int igt_drm_rect_clip_scaled_div_by_zero(void *ignored);
-int igt_drm_rect_clip_scaled_not_clipped(void *ignored);
-int igt_drm_rect_clip_scaled_clipped(void *ignored);
-int igt_drm_rect_clip_scaled_signed_vs_unsigned(void *ignored);
-
-#endif
diff --git a/drivers/gpu/drm/selftests/test-drm_rect.c b/drivers/gpu/drm/selftests/test-drm_rect.c
index 3a5ff38321f4..f3d26c31ee66 100644
--- a/drivers/gpu/drm/selftests/test-drm_rect.c
+++ b/drivers/gpu/drm/selftests/test-drm_rect.c
@@ -3,15 +3,12 @@
  * Test cases for the drm_rect functions
  */
 
-#define pr_fmt(fmt) "drm_rect: " fmt
-
+#include <kunit/test.h>
 #include <linux/limits.h>
 
 #include <drm/drm_rect.h>
 
-#include "test-drm_modeset_common.h"
-
-int igt_drm_rect_clip_scaled_div_by_zero(void *ignored)
+static void drm_rect_clip_scaled_div_by_zero(struct kunit *test)
 {
 	struct drm_rect src, dst, clip;
 	bool visible;
@@ -23,21 +20,23 @@ int igt_drm_rect_clip_scaled_div_by_zero(void *ignored)
 	drm_rect_init(&src, 0, 0, 0, 0);
 	drm_rect_init(&dst, 0, 0, 0, 0);
 	drm_rect_init(&clip, 1, 1, 1, 1);
+
 	visible = drm_rect_clip_scaled(&src, &dst, &clip);
-	FAIL(visible, "Destination not be visible\n");
-	FAIL(drm_rect_visible(&src), "Source should not be visible\n");
+
+	KUNIT_EXPECT_FALSE_MSG(test, visible, "Destination not be visible");
+	KUNIT_EXPECT_FALSE_MSG(test, drm_rect_visible(&src), "Source should not be visible");
 
 	drm_rect_init(&src, 0, 0, 0, 0);
 	drm_rect_init(&dst, 3, 3, 0, 0);
 	drm_rect_init(&clip, 1, 1, 1, 1);
+
 	visible = drm_rect_clip_scaled(&src, &dst, &clip);
-	FAIL(visible, "Destination not be visible\n");
-	FAIL(drm_rect_visible(&src), "Source should not be visible\n");
 
-	return 0;
+	KUNIT_EXPECT_FALSE_MSG(test, visible, "Destination not be visible");
+	KUNIT_EXPECT_FALSE_MSG(test, drm_rect_visible(&src), "Source should not be visible");
 }
 
-int igt_drm_rect_clip_scaled_not_clipped(void *ignored)
+static void drm_rect_clip_scaled_not_clipped(struct kunit *test)
 {
 	struct drm_rect src, dst, clip;
 	bool visible;
@@ -49,14 +48,16 @@ int igt_drm_rect_clip_scaled_not_clipped(void *ignored)
 
 	visible = drm_rect_clip_scaled(&src, &dst, &clip);
 
-	FAIL(src.x1 != 0 || src.x2 != 1 << 16 ||
-	     src.y1 != 0 || src.y2 != 1 << 16,
-	     "Source badly clipped\n");
-	FAIL(dst.x1 != 0 || dst.x2 != 1 ||
-	     dst.y1 != 0 || dst.y2 != 1,
-	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      src.x1 == 0 && src.x2 == 1 << 16 &&
+			      src.y1 == 0 && src.y2 == 1 << 16,
+			      "Source badly clipped");
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      dst.x1 == 0 && dst.x2 == 1 &&
+			      dst.y1 == 0 && dst.y2 == 1,
+			      "Destination badly clipped");
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible");
 
 	/* 2:1 scaling */
 	drm_rect_init(&src, 0, 0, 2 << 16, 2 << 16);
@@ -65,14 +66,16 @@ int igt_drm_rect_clip_scaled_not_clipped(void *ignored)
 
 	visible = drm_rect_clip_scaled(&src, &dst, &clip);
 
-	FAIL(src.x1 != 0 || src.x2 != 2 << 16 ||
-	     src.y1 != 0 || src.y2 != 2 << 16,
-	     "Source badly clipped\n");
-	FAIL(dst.x1 != 0 || dst.x2 != 1 ||
-	     dst.y1 != 0 || dst.y2 != 1,
-	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      src.x1 == 0 && src.x2 == 2 << 16 &&
+			      src.y1 == 0 && src.y2 == 2 << 16,
+			      "Source badly clipped");
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      dst.x1 == 0 && dst.x2 == 1 &&
+			      dst.y1 == 0 && dst.y2 == 1,
+			      "Destination badly clipped");
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible");
 
 	/* 1:2 scaling */
 	drm_rect_init(&src, 0, 0, 1 << 16, 1 << 16);
@@ -81,19 +84,19 @@ int igt_drm_rect_clip_scaled_not_clipped(void *ignored)
 
 	visible = drm_rect_clip_scaled(&src, &dst, &clip);
 
-	FAIL(src.x1 != 0 || src.x2 != 1 << 16 ||
-	     src.y1 != 0 || src.y2 != 1 << 16,
-	     "Source badly clipped\n");
-	FAIL(dst.x1 != 0 || dst.x2 != 2 ||
-	     dst.y1 != 0 || dst.y2 != 2,
-	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
-
-	return 0;
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      src.x1 == 0 && src.x2 == 1 << 16 &&
+			      src.y1 == 0 && src.y2 == 1 << 16,
+			      "Source badly clipped");
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      dst.x1 == 0 && dst.x2 == 2 &&
+			      dst.y1 == 0 && dst.y2 == 2,
+			      "Destination badly clipped");
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible");
 }
 
-int igt_drm_rect_clip_scaled_clipped(void *ignored)
+static void drm_rect_clip_scaled_clipped(struct kunit *test)
 {
 	struct drm_rect src, dst, clip;
 	bool visible;
@@ -105,14 +108,16 @@ int igt_drm_rect_clip_scaled_clipped(void *ignored)
 
 	visible = drm_rect_clip_scaled(&src, &dst, &clip);
 
-	FAIL(src.x1 != 0 || src.x2 != 1 << 16 ||
-	     src.y1 != 0 || src.y2 != 1 << 16,
-	     "Source badly clipped\n");
-	FAIL(dst.x1 != 0 || dst.x2 != 1 ||
-	     dst.y1 != 0 || dst.y2 != 1,
-	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      src.x1 == 0 && src.x2 == 1 << 16 &&
+			      src.y1 == 0 && src.y2 == 1 << 16,
+			      "Source badly clipped");
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      dst.x1 == 0 && dst.x2 == 1 &&
+			      dst.y1 == 0 && dst.y2 == 1,
+			      "Destination badly clipped");
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible");
 
 	/* 1:1 scaling bottom/right clip */
 	drm_rect_init(&src, 0, 0, 2 << 16, 2 << 16);
@@ -121,14 +126,16 @@ int igt_drm_rect_clip_scaled_clipped(void *ignored)
 
 	visible = drm_rect_clip_scaled(&src, &dst, &clip);
 
-	FAIL(src.x1 != 1 << 16 || src.x2 != 2 << 16 ||
-	     src.y1 != 1 << 16 || src.y2 != 2 << 16,
-	     "Source badly clipped\n");
-	FAIL(dst.x1 != 1 || dst.x2 != 2 ||
-	     dst.y1 != 1 || dst.y2 != 2,
-	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      src.x1 == 1 << 16 && src.x2 == 2 << 16 &&
+			      src.y1 == 1 << 16 && src.y2 == 2 << 16,
+			      "Source badly clipped");
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      dst.x1 == 1 && dst.x2 == 2 &&
+			      dst.y1 == 1 && dst.y2 == 2,
+			      "Destination badly clipped");
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible");
 
 	/* 2:1 scaling top/left clip */
 	drm_rect_init(&src, 0, 0, 4 << 16, 4 << 16);
@@ -137,14 +144,16 @@ int igt_drm_rect_clip_scaled_clipped(void *ignored)
 
 	visible = drm_rect_clip_scaled(&src, &dst, &clip);
 
-	FAIL(src.x1 != 0 || src.x2 != 2 << 16 ||
-	     src.y1 != 0 || src.y2 != 2 << 16,
-	     "Source badly clipped\n");
-	FAIL(dst.x1 != 0 || dst.x2 != 1 ||
-	     dst.y1 != 0 || dst.y2 != 1,
-	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      src.x1 == 0 && src.x2 == 2 << 16 &&
+			      src.y1 == 0 && src.y2 == 2 << 16,
+			      "Source badly clipped");
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      dst.x1 == 0 && dst.x2 == 1 &&
+			      dst.y1 == 0 && dst.y2 == 1,
+			      "Destination badly clipped");
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible");
 
 	/* 2:1 scaling bottom/right clip */
 	drm_rect_init(&src, 0, 0, 4 << 16, 4 << 16);
@@ -153,14 +162,16 @@ int igt_drm_rect_clip_scaled_clipped(void *ignored)
 
 	visible = drm_rect_clip_scaled(&src, &dst, &clip);
 
-	FAIL(src.x1 != 2 << 16 || src.x2 != 4 << 16 ||
-	     src.y1 != 2 << 16 || src.y2 != 4 << 16,
-	     "Source badly clipped\n");
-	FAIL(dst.x1 != 1 || dst.x2 != 2 ||
-	     dst.y1 != 1 || dst.y2 != 2,
-	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      src.x1 == 2 << 16 && src.x2 == 4 << 16 &&
+			      src.y1 == 2 << 16 && src.y2 == 4 << 16,
+			      "Source badly clipped");
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      dst.x1 == 1 && dst.x2 == 2 &&
+			      dst.y1 == 1 && dst.y2 == 2,
+			      "Destination badly clipped");
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible");
 
 	/* 1:2 scaling top/left clip */
 	drm_rect_init(&src, 0, 0, 2 << 16, 2 << 16);
@@ -169,14 +180,16 @@ int igt_drm_rect_clip_scaled_clipped(void *ignored)
 
 	visible = drm_rect_clip_scaled(&src, &dst, &clip);
 
-	FAIL(src.x1 != 0 || src.x2 != 1 << 16 ||
-	     src.y1 != 0 || src.y2 != 1 << 16,
-	     "Source badly clipped\n");
-	FAIL(dst.x1 != 0 || dst.x2 != 2 ||
-	     dst.y1 != 0 || dst.y2 != 2,
-	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      src.x1 == 0 && src.x2 == 1 << 16 &&
+			      src.y1 == 0 && src.y2 == 1 << 16,
+			      "Source badly clipped");
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      dst.x1 == 0 && dst.x2 == 2 &&
+			      dst.y1 == 0 && dst.y2 == 2,
+			      "Destination badly clipped");
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible");
 
 	/* 1:2 scaling bottom/right clip */
 	drm_rect_init(&src, 0, 0, 2 << 16, 2 << 16);
@@ -185,19 +198,19 @@ int igt_drm_rect_clip_scaled_clipped(void *ignored)
 
 	visible = drm_rect_clip_scaled(&src, &dst, &clip);
 
-	FAIL(src.x1 != 1 << 16 || src.x2 != 2 << 16 ||
-	     src.y1 != 1 << 16 || src.y2 != 2 << 16,
-	     "Source badly clipped\n");
-	FAIL(dst.x1 != 2 || dst.x2 != 4 ||
-	     dst.y1 != 2 || dst.y2 != 4,
-	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
-
-	return 0;
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      src.x1 == 1 << 16 && src.x2 == 2 << 16 &&
+			      src.y1 == 1 << 16 && src.y2 == 2 << 16,
+			      "Source badly clipped");
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      dst.x1 == 2 && dst.x2 == 4 &&
+			      dst.y1 == 2 && dst.y2 == 4,
+			      "Destination badly clipped");
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible");
 }
 
-int igt_drm_rect_clip_scaled_signed_vs_unsigned(void *ignored)
+static void drm_rect_clip_scaled_signed_vs_unsigned(struct kunit *test)
 {
 	struct drm_rect src, dst, clip;
 	bool visible;
@@ -216,8 +229,21 @@ int igt_drm_rect_clip_scaled_signed_vs_unsigned(void *ignored)
 
 	visible = drm_rect_clip_scaled(&src, &dst, &clip);
 
-	FAIL(visible, "Destination should not be visible\n");
-	FAIL(drm_rect_visible(&src), "Source should not be visible\n");
-
-	return 0;
+	KUNIT_EXPECT_FALSE_MSG(test, visible, "Destination should not be visible");
+	KUNIT_EXPECT_FALSE_MSG(test, drm_rect_visible(&src), "Source should not be visible");
 }
+
+static struct kunit_case drm_rect_tests[] = {
+	KUNIT_CASE(drm_rect_clip_scaled_div_by_zero),
+	KUNIT_CASE(drm_rect_clip_scaled_not_clipped),
+	KUNIT_CASE(drm_rect_clip_scaled_clipped),
+	KUNIT_CASE(drm_rect_clip_scaled_signed_vs_unsigned),
+	{}
+};
+
+static struct kunit_suite drm_rect_test_suite = {
+	.name = "drm_rect_tests",
+	.test_cases = drm_rect_tests,
+};
+
+kunit_test_suite(drm_rect_test_suite);
-- 
2.34.1

