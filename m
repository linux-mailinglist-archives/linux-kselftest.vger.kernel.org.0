Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB1B491248
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 00:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238473AbiAQXYM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jan 2022 18:24:12 -0500
Received: from mga14.intel.com ([192.55.52.115]:30875 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235370AbiAQXYM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jan 2022 18:24:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642461851; x=1673997851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=iUbQko9k7Ou5nk3pDqzZkkT1Itgenl5Tkzsne6VbKX4=;
  b=d9u2CDjhUWkHLwEtUBeddCpGDhZuUmsES4Z5w56/suSi5eRqTj3VcDrW
   fLPq4RvOynrk77wh39QU//4+nzIfCrtqCeM/jDbk3NWPOhCO9SWhzsZEX
   eKNSyHOv9+GX0Ne0pzLxoVy5rb6NfCXtXExzmxIPDyvJLwZNyxXTm9nGC
   uta0ijSEPyeJdpOSiYk91X6z7gszrv7zakgDocfLX36kYqR7HTg9EecfR
   6w9FbQ/eHGPaIPhysisxeK6a3a2N1VDpANFcbQd9vUyDgrO5+iFpxO0wA
   Dk+3Wg6rMTfk2/S5GeOlFZp+24NzvkZCbY9Vw0IrxtCWU0N0ysS9rj7u6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="244901080"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="244901080"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 15:24:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="492487605"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga002.jf.intel.com with ESMTP; 17 Jan 2022 15:24:10 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 17 Jan 2022 15:24:10 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 17 Jan 2022 15:24:10 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 17 Jan 2022 15:24:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzfqnOm0OPLQRpUR/hpTZvLjCdt3oyIKCsEeBdRQYEXKT9Z1ylJ6nbpYwuZef3793TMTcpaZH8xjmI8dn52ytfpOOzmh+IK0LQtWuAZ6RJmhQAMx7Pg/0a4OIDm4NzDN6vpVfngFbZpR4/Y3RcVLKpLwvfPCW2B0eQtQRaFSlyp5ImngOwLkZ/81C3PGqcOxaQLTMjsgtck/nIRieXTV2tDJ/run8i7662DOslhB861x2g4drvkenSvv2oIaGhw6k10eFDqr9WIQB5Jbr0AZtmCgz1njt7E9J9xfc1IsrjxrEl80smJOCn6FdEvUeg9bl06t6K1ESbPYEjF6acB1MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OsWuxDS+hItVI7fUSlP8MuloHfRQnuixvGZj/X7cbc=;
 b=GrQ4ioBRO7VIWdWdRXGyTO6i0eYMfh6YV2Axva16HTNLS5EbYJzsdOUEgVivymUy4ddTQ8AgjJYQJYMRELCMoRRAV5pIXGmLOI4751nO9mLoJuUKfZyxNGpglUzYBm2/ONW5CSSfybP1XGkjvPGYgiE7eAwXR5Jzi6lGdjjArJ3hwR5BUYQK05DaKnby09h0FbU3eRJRrZAx6qh1A7twfwfrxsPjjNpY3ZF41sKbUIimDJsq0i2j6qk09VeUMiXzBasWV54aBhhPhLZHI6zlxBuRAlkKiU/qlQth3DX7WtC7d4R9UBKrIZEUuA4H1KSwODVjWIzIf7RXJ8O/WZ4l/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 DM6PR11MB4140.namprd11.prod.outlook.com (2603:10b6:5:19f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Mon, 17 Jan 2022 23:24:05 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::fc15:bd26:128a:f5f5]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::fc15:bd26:128a:f5f5%8]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 23:24:05 +0000
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
Subject: [RFC 01/10] drm: test-drm_cmdline_parser: Convert to KUnit
Date:   Tue, 18 Jan 2022 00:22:50 +0100
Message-ID: <20220117232259.180459-2-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117232259.180459-1-michal.winiarski@intel.com>
References: <20220117232259.180459-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR04CA0008.eurprd04.prod.outlook.com
 (2603:10a6:20b:310::13) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65f7d81c-1bc6-4b9e-25fe-08d9da1073e5
X-MS-TrafficTypeDiagnostic: DM6PR11MB4140:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB4140FF5108C32A7A4793A48698579@DM6PR11MB4140.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HMjWSyNnENcWuopiEIm0EM0gwdwGXu2qIGHa6zIzFKXgst6SiYQfD6rvGlq5f9WpofTsTtYZE1BxfXcv1RbJxIAZ3oRJpL4vI7SLYg/YjpLPPIiIECXu6Tah+mQjR6oj8ff0gPW6vuHBX4gMnwqkr6/Hpi9XhDAYU3aS+IG+Xi/4LVNpr+cSWCDcCrVp4v2/AViTzOTfBgtZrqMLT4v1EMHsb2EVeivnadpGdChMc/3JQE3GjSFVvv5JlUOX96Eq7YqwV5XJHcsTxzWXqz6jn4sFciKzurrtlumB8Dff3uNuqJqYEPhk74kk0f87WOWbb64YdRH3tyYOOCnAf46EmFwIiEZjwOZ8cLWItbaQiE+LYOle3/NsauJRKQrJRAtJhy2EayRlRaSHWolIv0/RP/6CBmRd/Js92Io1d1X6HGqKK4UZsQ3EICFQfo8fUh/QbTF9NJqKqT444Znl3DLanY3pd18igEdGK3s48xboIz0ZAvLarAGHJ3GAXAUWN7IK0f6VFwAJEjdQJ8Zqfg2Vrinl3xNOvGJ04BNqasnaGNxOszOUqoIm/9ditjgH3uqe/+8P8MK/Q3QP8OH8nkfd4mCO8oqtxD+QtNm6IcT0P3+fex5vtSKpWgbD00s6fWBkwzuIVhaWRRChmQCNT/Q2vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(7416002)(186003)(6506007)(82960400001)(86362001)(8676002)(6512007)(6666004)(83380400001)(38100700002)(8936002)(66556008)(30864003)(54906003)(5660300002)(2906002)(6486002)(316002)(36756003)(2616005)(66946007)(26005)(1076003)(4326008)(66476007)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjN3UkpVMG1RRGQ3MnM0c3UwQ0xQcDk3T2tpdHZDekpNNkQySk01cFhyTVBG?=
 =?utf-8?B?TWVtK1ZnWEhFMkdtaGt2K1BoSmE1VCs5cFk1R09FVVR5NHQrWDk2V1BqalpY?=
 =?utf-8?B?WmNnSi96R00zWUUwMHRJcHFOblVFMWpQUUdDa1dNUlJOdE9jQzEyMk04YU12?=
 =?utf-8?B?WlkvVjIwRGNpSG9JN2xnVTZnd3ZMcm9vRWZTQmtubUJXTVp5b3RsenhRZjhT?=
 =?utf-8?B?YzZ0TDRDMlUyVzl4c3JoMjA4ZVN3QkhQUWk4a2pOajNtRFFKb0dtWjdYTXBq?=
 =?utf-8?B?eGxGMUw1Vmh1ZHJUaE5xUjVZSUh1Y2FhZitmRUcrTnhMRTBFeUw1SDBNQnZP?=
 =?utf-8?B?VGYweXlZN3NHL1Z0V1FDWUhqMStDRmw2V21sOWZXR01tREF6Q3NqcVV6ZU9K?=
 =?utf-8?B?VElNdk96SC9QdnBmQ3BkZTB2MW54Q0JiVmloNlNHdk5jajV0UWdRbDRXZnB4?=
 =?utf-8?B?dnluT0lYQnkvbjdvcm9YL1V2R3o5SHNOZG83RldIYndkYmZYUlNEWGtoM2hi?=
 =?utf-8?B?YVpPMGtOUmhQc0wrQ1hkRE40QUU4cEdmMlJlcGNFTHhZSVZTT1Nwa3VuMCtF?=
 =?utf-8?B?WlIzbGVvUGwyeGJWandQVE1NK20rQnJXV09Cb2gvYmppbFNzQXNmenBOWUI2?=
 =?utf-8?B?eTdXalJTSXlGU3RtdHVNOG83Y1FOaWpqV0pGN2JQaWxjSE9CV0E1bkhhQjZZ?=
 =?utf-8?B?VzZWTzA2QWF5cU9OUUkwVjBjWWJIYjh6VXR2ZExkbkM1WHdEbkQ1UWFGZDA4?=
 =?utf-8?B?c2sxWnorRTVGMlcwcUtYZ0l4TDNJSlJoZHFlMWVyRDg1cUF2dHpNRUlCcTEz?=
 =?utf-8?B?QWdTUE9wQ2Nxd0Fodkc4cUVaNzhCSHlvRjB6RmhvZlFlSmtOUGVYYWp5NGFW?=
 =?utf-8?B?YjBsOFRTc1I3QnRHR1UwZGQrN1IxQWZuWGhoTStFRXN4R0tDWUZjeFBXc2w2?=
 =?utf-8?B?dUN0UHB1NU1sdlVuelk4N2ZSU2dPd2R2OEhpMnMrRU5hZmtjeEFaVVVRRHlZ?=
 =?utf-8?B?R2JQQldyUmFNcnliQ3doVi8vMXlqQ08zaHdJTHdDcjFROE9tMUdLR3BKQy9j?=
 =?utf-8?B?cnhJN2VJRG5XUEhHSHo5Sk5VdUNCUkxxRWU5eUc1dnAzS01NR3VqM25nOW5w?=
 =?utf-8?B?R3RJSTNGZUdNRmJFUU9nZ0RLbVJMVlZJc2ZlcVFYSktLVHFWSGlqOS80aUtZ?=
 =?utf-8?B?THcwN2NkOFIyNVQvWTFJT1F1NU1yTjM1MUxpcUdjRC9KK3JTckpSbTI1d2U3?=
 =?utf-8?B?SWV6Um5namRkcFNhNm92dDY1R0FqaWdFOGNJRWhvYjlGRkhqZ3BLaDhQTTVI?=
 =?utf-8?B?R3l1Y1oyMzBJMFpiK3FwU2lDdnoyWjBMVnVJQnBkcTdxQ2oxMzdIQVBKd0c1?=
 =?utf-8?B?dG9PVHVZZC84Z1diSFNxcFdXVkk0MlFIR1hyMGRLbGlFVlNOMGRTdncvREwr?=
 =?utf-8?B?ZTlPNGJIMWhQSHdCRVRFTVI1Tzl6VVlYQ294VUFzUHdtQ1crSjFVUVZ0Z0Rt?=
 =?utf-8?B?dUkyRnM5czNoOUtqckFDbXVCakNhRzdBZnAyYVJ3NTlIa25lcThaa2RTQXZz?=
 =?utf-8?B?NXFqSlRmdzhDNC9DK0hNN3VtZ0NET2t0bmx6d2hoK21lZU9GSjJuNWVnNzJY?=
 =?utf-8?B?MDNzdW4zRjBUYUVXZ2hiYzMrak9yVnpRNXdMcWZycEVwcCtyaitodm8zeEtY?=
 =?utf-8?B?ZTU0Y3ROWFcyREdhOFRxQ2NpODRvTE1Kd2RKaCtORzdOck9jd0lJME82U0ZZ?=
 =?utf-8?B?aThXN0xVVW1zOTY4QTg3Mkp4Q3FNR2VRY2tQblErVlh4dkkzeC93Q1BCY1Jq?=
 =?utf-8?B?UThlQVdHbDdDR0FUaGpEZEd5VkRWYXQ1T0FXVWZERnNvUjNQOENxNEprcmpl?=
 =?utf-8?B?bTk2ZVBteTZ6OEZreGwwWUlaeU9xdFBUV2lVY2kzQ0cvOHdkakIwTW1rMXZz?=
 =?utf-8?B?SzV4dkZDQXpmV2c4R0ZqNUNnSUNoOTBpRWhKaSt0Q284TWhHU0dpY0ZUaGJs?=
 =?utf-8?B?dWtJd2svV0xHeG1KVEgwb1hnSk00ZVhUNkJJUlIveGNla2d2cHpXVWZ6V1Nl?=
 =?utf-8?B?eldLbmI2NFhuZ1Radk5PL3VUQmtLN05GZ0tKNVZkOU5xS2NTeWlCRENJM0pH?=
 =?utf-8?B?TUVvODBycEFuazhIREtsdUpPcUQvVWF5aFdNSkRnWFJycktLVEVjS0tkcytG?=
 =?utf-8?B?NHRseHdLS0l4WU1lR2RIcFl2Z1I1TVkrbGFsUmg0bVJ4WmZWc0NoNzFMZFNu?=
 =?utf-8?B?VmJ5MEp6SWNpZy9BTm40aEJacHRRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f7d81c-1bc6-4b9e-25fe-08d9da1073e5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 23:24:05.1802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTay2zN7gRuQpTq8XSC9hIlMB1WkFGhZlL+81Uf2oJtipGyUXY635L4OVq90VgWOhLwk/Ggf++6jbAXSMbTfcT1J3FoY+1gJko+vN/+wzEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4140
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

One-to-one conversion, no functional changes.
Negative tests were merged into single parameterized test case.

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
---
 drivers/gpu/drm/Kconfig                       |   12 +
 drivers/gpu/drm/Makefile                      |    2 +-
 drivers/gpu/drm/selftests/Makefile            |    8 +-
 .../gpu/drm/selftests/drm_cmdline_selftests.h |   68 -
 .../drm/selftests/test-drm_cmdline_parser.c   | 1680 ++++++++---------
 5 files changed, 802 insertions(+), 968 deletions(-)
 delete mode 100644 drivers/gpu/drm/selftests/drm_cmdline_selftests.h

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index b1f22e457fd0..21e329f32997 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -80,6 +80,18 @@ config DRM_DEBUG_SELFTEST
 
 	  If in doubt, say "N".
 
+config DRM_KUNIT_TEST
+	bool "DRM tests" if !KUNIT_ALL_TESTS
+	depends on DRM=y && KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  Enables unit tests for DRM. Only useful for kernel devs running KUnit.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config DRM_KMS_HELPER
 	tristate
 	depends on DRM
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 301a44dc18e3..550800e81836 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -65,7 +65,7 @@ drm_kms_helper-$(CONFIG_DRM_DP_AUX_CHARDEV) += drm_dp_aux_dev.o
 drm_kms_helper-$(CONFIG_DRM_DP_CEC) += drm_dp_cec.o
 
 obj-$(CONFIG_DRM_KMS_HELPER) += drm_kms_helper.o
-obj-$(CONFIG_DRM_DEBUG_SELFTEST) += selftests/
+obj-y += selftests/
 
 obj-$(CONFIG_DRM)	+= drm.o
 obj-$(CONFIG_DRM_MIPI_DBI) += drm_mipi_dbi.o
diff --git a/drivers/gpu/drm/selftests/Makefile b/drivers/gpu/drm/selftests/Makefile
index 0856e4b12f70..6411c9a957b3 100644
--- a/drivers/gpu/drm/selftests/Makefile
+++ b/drivers/gpu/drm/selftests/Makefile
@@ -1,7 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
-test-drm_modeset-y := test-drm_modeset_common.o test-drm_plane_helper.o \
+test-drm_modeset-$(CONFIG_DRM_DEBUG_SELFTEST) := \
+		      test-drm_modeset_common.o test-drm_plane_helper.o \
                       test-drm_format.o test-drm_framebuffer.o \
 		      test-drm_damage_helper.o test-drm_dp_mst_helper.o \
 		      test-drm_rect.o
 
-obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o test-drm_modeset.o test-drm_cmdline_parser.o
+obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o test-drm_modeset.o
+
+obj-$(CONFIG_DRM_KUNIT_TEST) := \
+	test-drm_cmdline_parser.o
diff --git a/drivers/gpu/drm/selftests/drm_cmdline_selftests.h b/drivers/gpu/drm/selftests/drm_cmdline_selftests.h
deleted file mode 100644
index 29e367db6118..000000000000
--- a/drivers/gpu/drm/selftests/drm_cmdline_selftests.h
+++ /dev/null
@@ -1,68 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* List each unit test as selftest(function)
- *
- * The name is used as both an enum and expanded as igt__name to create
- * a module parameter. It must be unique and legal for a C identifier.
- *
- * Tests are executed in order by igt/drm_mm
- */
-
-#define cmdline_test(test)	selftest(test, test)
-
-cmdline_test(drm_cmdline_test_force_d_only)
-cmdline_test(drm_cmdline_test_force_D_only_dvi)
-cmdline_test(drm_cmdline_test_force_D_only_hdmi)
-cmdline_test(drm_cmdline_test_force_D_only_not_digital)
-cmdline_test(drm_cmdline_test_force_e_only)
-cmdline_test(drm_cmdline_test_margin_only)
-cmdline_test(drm_cmdline_test_interlace_only)
-cmdline_test(drm_cmdline_test_res)
-cmdline_test(drm_cmdline_test_res_missing_x)
-cmdline_test(drm_cmdline_test_res_missing_y)
-cmdline_test(drm_cmdline_test_res_bad_y)
-cmdline_test(drm_cmdline_test_res_missing_y_bpp)
-cmdline_test(drm_cmdline_test_res_vesa)
-cmdline_test(drm_cmdline_test_res_vesa_rblank)
-cmdline_test(drm_cmdline_test_res_rblank)
-cmdline_test(drm_cmdline_test_res_bpp)
-cmdline_test(drm_cmdline_test_res_bad_bpp)
-cmdline_test(drm_cmdline_test_res_refresh)
-cmdline_test(drm_cmdline_test_res_bad_refresh)
-cmdline_test(drm_cmdline_test_res_bpp_refresh)
-cmdline_test(drm_cmdline_test_res_bpp_refresh_interlaced)
-cmdline_test(drm_cmdline_test_res_bpp_refresh_margins)
-cmdline_test(drm_cmdline_test_res_bpp_refresh_force_off)
-cmdline_test(drm_cmdline_test_res_bpp_refresh_force_on_off)
-cmdline_test(drm_cmdline_test_res_bpp_refresh_force_on)
-cmdline_test(drm_cmdline_test_res_bpp_refresh_force_on_analog)
-cmdline_test(drm_cmdline_test_res_bpp_refresh_force_on_digital)
-cmdline_test(drm_cmdline_test_res_bpp_refresh_interlaced_margins_force_on)
-cmdline_test(drm_cmdline_test_res_margins_force_on)
-cmdline_test(drm_cmdline_test_res_vesa_margins)
-cmdline_test(drm_cmdline_test_res_invalid_mode)
-cmdline_test(drm_cmdline_test_res_bpp_wrong_place_mode)
-cmdline_test(drm_cmdline_test_name)
-cmdline_test(drm_cmdline_test_name_bpp)
-cmdline_test(drm_cmdline_test_name_refresh)
-cmdline_test(drm_cmdline_test_name_bpp_refresh)
-cmdline_test(drm_cmdline_test_name_refresh_wrong_mode)
-cmdline_test(drm_cmdline_test_name_refresh_invalid_mode)
-cmdline_test(drm_cmdline_test_name_option)
-cmdline_test(drm_cmdline_test_name_bpp_option)
-cmdline_test(drm_cmdline_test_rotate_0)
-cmdline_test(drm_cmdline_test_rotate_90)
-cmdline_test(drm_cmdline_test_rotate_180)
-cmdline_test(drm_cmdline_test_rotate_270)
-cmdline_test(drm_cmdline_test_rotate_multiple)
-cmdline_test(drm_cmdline_test_rotate_invalid_val)
-cmdline_test(drm_cmdline_test_rotate_truncated)
-cmdline_test(drm_cmdline_test_hmirror)
-cmdline_test(drm_cmdline_test_vmirror)
-cmdline_test(drm_cmdline_test_margin_options)
-cmdline_test(drm_cmdline_test_multiple_options)
-cmdline_test(drm_cmdline_test_invalid_option)
-cmdline_test(drm_cmdline_test_bpp_extra_and_option)
-cmdline_test(drm_cmdline_test_extra_and_option)
-cmdline_test(drm_cmdline_test_freestanding_options)
-cmdline_test(drm_cmdline_test_freestanding_force_e_and_options)
-cmdline_test(drm_cmdline_test_panel_orientation)
diff --git a/drivers/gpu/drm/selftests/test-drm_cmdline_parser.c b/drivers/gpu/drm/selftests/test-drm_cmdline_parser.c
index d96cd890def6..ffe5a483320a 100644
--- a/drivers/gpu/drm/selftests/test-drm_cmdline_parser.c
+++ b/drivers/gpu/drm/selftests/test-drm_cmdline_parser.c
@@ -3,1139 +3,1025 @@
  * Copyright (c) 2019 Bootlin
  */
 
-#define pr_fmt(fmt) "drm_cmdline: " fmt
-
-#include <linux/kernel.h>
-#include <linux/module.h>
+#include <kunit/test.h>
 
 #include <drm/drm_connector.h>
 #include <drm/drm_modes.h>
 
-#define TESTS "drm_cmdline_selftests.h"
-#include "drm_selftest.h"
-#include "test-drm_modeset_common.h"
-
 static const struct drm_connector no_connector = {};
 
-static int drm_cmdline_test_force_e_only(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("e",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(mode.specified);
-	FAIL_ON(mode.refresh_specified);
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_ON);
-
-	return 0;
-}
-
-static int drm_cmdline_test_force_D_only_not_digital(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("D",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(mode.specified);
-	FAIL_ON(mode.refresh_specified);
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_ON);
-
-	return 0;
-}
-
-static const struct drm_connector connector_hdmi = {
-	.connector_type	= DRM_MODE_CONNECTOR_HDMIB,
-};
-
-static int drm_cmdline_test_force_D_only_hdmi(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("D",
-							   &connector_hdmi,
-							   &mode));
-	FAIL_ON(mode.specified);
-	FAIL_ON(mode.refresh_specified);
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_ON_DIGITAL);
-
-	return 0;
-}
-
-static const struct drm_connector connector_dvi = {
-	.connector_type	= DRM_MODE_CONNECTOR_DVII,
-};
-
-static int drm_cmdline_test_force_D_only_dvi(void *ignored)
+static void drm_cmdline_test_force_e_only(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("D",
-							   &connector_dvi,
-							   &mode));
-	FAIL_ON(mode.specified);
-	FAIL_ON(mode.refresh_specified);
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_ON_DIGITAL);
-
-	return 0;
-}
-
-static int drm_cmdline_test_force_d_only(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("d",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(mode.specified);
-	FAIL_ON(mode.refresh_specified);
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_OFF);
-
-	return 0;
+	const char *cmdline = "e";
+
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_FALSE(test, mode.specified);
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_ON);
 }
 
-static int drm_cmdline_test_margin_only(void *ignored)
+static void drm_cmdline_test_force_D_only_not_digital(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("m",
-							  &no_connector,
-							  &mode));
-
-	return 0;
-}
-
-static int drm_cmdline_test_interlace_only(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("i",
-							  &no_connector,
-							  &mode));
-
-	return 0;
-}
-
-static int drm_cmdline_test_res(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(mode.refresh_specified);
-
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
+	const char *cmdline = "D";
+
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_FALSE(test, mode.specified);
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_ON);
 }
 
-static int drm_cmdline_test_res_missing_x(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
 
-	FAIL_ON(drm_mode_parse_command_line_for_connector("x480",
-							  &no_connector,
-							  &mode));
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_missing_y(void *ignored)
+static void drm_cmdline_test_force_D_only_hdmi(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("1024x",
-							  &no_connector,
-							  &mode));
-
-	return 0;
+	const struct drm_connector connector_hdmi = {
+		.connector_type	= DRM_MODE_CONNECTOR_HDMIB,
+	};
+	const char *cmdline = "D";
+
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &connector_hdmi,
+									  &mode));
+	KUNIT_EXPECT_FALSE(test, mode.specified);
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_ON_DIGITAL);
 }
 
-static int drm_cmdline_test_res_bad_y(void *ignored)
+static void drm_cmdline_test_force_D_only_dvi(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("1024xtest",
-							  &no_connector,
-							  &mode));
-
-	return 0;
+	const struct drm_connector connector_dvi = {
+		.connector_type = DRM_MODE_CONNECTOR_DVII,
+	};
+	const char *cmdline = "D";
+
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &connector_dvi,
+									  &mode));
+	KUNIT_EXPECT_FALSE(test, mode.specified);
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_ON_DIGITAL);
 }
 
-static int drm_cmdline_test_res_missing_y_bpp(void *ignored)
+static void drm_cmdline_test_force_d_only(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("1024x-24",
-							  &no_connector,
-							  &mode));
-
-	return 0;
+	const char *cmdline = "d";
+
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_FALSE(test, mode.specified);
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_OFF);
 }
 
-static int drm_cmdline_test_res_vesa(void *ignored)
+static void drm_cmdline_test_res(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
+	const char *cmdline = "720x480";
 
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480M",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
 
-	FAIL_ON(mode.refresh_specified);
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
 
-	FAIL_ON(mode.bpp_specified);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
 
-	FAIL_ON(mode.rb);
-	FAIL_ON(!mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
 }
 
-static int drm_cmdline_test_res_vesa_rblank(void *ignored)
+static void drm_cmdline_test_res_vesa(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
+	const char *cmdline = "720x480M";
 
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480MR",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(mode.refresh_specified);
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
 
-	FAIL_ON(mode.bpp_specified);
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
 
-	FAIL_ON(!mode.rb);
-	FAIL_ON(!mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
 
-	return 0;
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_TRUE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
 }
 
-static int drm_cmdline_test_res_rblank(void *ignored)
+static void drm_cmdline_test_res_vesa_rblank(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
+	const char *cmdline = "720x480MR";
 
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480R",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
 
-	FAIL_ON(mode.refresh_specified);
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
 
-	FAIL_ON(mode.bpp_specified);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
 
-	FAIL_ON(!mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
+	KUNIT_EXPECT_TRUE(test, mode.rb);
+	KUNIT_EXPECT_TRUE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
 }
 
-static int drm_cmdline_test_res_bpp(void *ignored)
+static void drm_cmdline_test_res_rblank(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
+	const char *cmdline = "720x480R";
 
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(mode.refresh_specified);
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
 
-	FAIL_ON(!mode.bpp_specified);
-	FAIL_ON(mode.bpp != 24);
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
 
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
 
-	return 0;
+	KUNIT_EXPECT_TRUE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
 }
 
-static int drm_cmdline_test_res_bad_bpp(void *ignored)
+static void drm_cmdline_test_res_bpp(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
+	const char *cmdline = "720x480-24";
 
-	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480-test",
-							  &no_connector,
-							  &mode));
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_refresh(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480@60",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(!mode.refresh_specified);
-	FAIL_ON(mode.refresh != 60);
-
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
 
-	return 0;
-}
-
-static int drm_cmdline_test_res_bad_refresh(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
 
-	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480@refresh",
-							  &no_connector,
-							  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.bpp_specified);
+	KUNIT_EXPECT_EQ(test, mode.bpp, 24);
 
-	return 0;
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
 }
 
-static int drm_cmdline_test_res_bpp_refresh(void *ignored)
+static void drm_cmdline_test_res_refresh(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
+	const char *cmdline = "720x480@60";
 
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
 
-	FAIL_ON(!mode.refresh_specified);
-	FAIL_ON(mode.refresh != 60);
+	KUNIT_EXPECT_TRUE(test, mode.refresh_specified);
+	KUNIT_EXPECT_EQ(test, mode.refresh, 60);
 
-	FAIL_ON(!mode.bpp_specified);
-	FAIL_ON(mode.bpp != 24);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
 
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
 }
 
-static int drm_cmdline_test_res_bpp_refresh_interlaced(void *ignored)
+static void drm_cmdline_test_res_bpp_refresh(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60i",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(!mode.refresh_specified);
-	FAIL_ON(mode.refresh != 60);
-
-	FAIL_ON(!mode.bpp_specified);
-	FAIL_ON(mode.bpp != 24);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(!mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
+	const char *cmdline = "720x480-24@60";
+
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+
+	KUNIT_EXPECT_TRUE(test, mode.refresh_specified);
+	KUNIT_EXPECT_EQ(test, mode.refresh, 60);
+
+	KUNIT_EXPECT_TRUE(test, mode.bpp_specified);
+	KUNIT_EXPECT_EQ(test, mode.bpp, 24);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
 }
 
-static int drm_cmdline_test_res_bpp_refresh_margins(void *ignored)
+static void drm_cmdline_test_res_bpp_refresh_interlaced(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60m",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(!mode.refresh_specified);
-	FAIL_ON(mode.refresh != 60);
-
-	FAIL_ON(!mode.bpp_specified);
-	FAIL_ON(mode.bpp != 24);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(!mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
+	const char *cmdline = "720x480-24@60i";
+
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+
+	KUNIT_EXPECT_TRUE(test, mode.refresh_specified);
+	KUNIT_EXPECT_EQ(test, mode.refresh, 60);
+
+	KUNIT_EXPECT_TRUE(test, mode.bpp_specified);
+	KUNIT_EXPECT_EQ(test, mode.bpp, 24);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_TRUE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
 }
 
-static int drm_cmdline_test_res_bpp_refresh_force_off(void *ignored)
+static void drm_cmdline_test_res_bpp_refresh_margins(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60d",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(!mode.refresh_specified);
-	FAIL_ON(mode.refresh != 60);
-
-	FAIL_ON(!mode.bpp_specified);
-	FAIL_ON(mode.bpp != 24);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_OFF);
-
-	return 0;
+	const char *cmdline = "720x480-24@60m";
+
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+
+	KUNIT_EXPECT_TRUE(test, mode.refresh_specified);
+	KUNIT_EXPECT_EQ(test, mode.refresh, 60);
+
+	KUNIT_EXPECT_TRUE(test, mode.bpp_specified);
+	KUNIT_EXPECT_EQ(test, mode.bpp, 24);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_TRUE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
 }
 
-static int drm_cmdline_test_res_bpp_refresh_force_on_off(void *ignored)
+static void drm_cmdline_test_res_bpp_refresh_force_off(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480-24@60de",
-							  &no_connector,
-							  &mode));
-
-	return 0;
+	const char *cmdline = "720x480-24@60d";
+
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+
+	KUNIT_EXPECT_TRUE(test, mode.refresh_specified);
+	KUNIT_EXPECT_EQ(test, mode.refresh, 60);
+
+	KUNIT_EXPECT_TRUE(test, mode.bpp_specified);
+	KUNIT_EXPECT_EQ(test, mode.bpp, 24);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_OFF);
 }
 
-static int drm_cmdline_test_res_bpp_refresh_force_on(void *ignored)
+static void drm_cmdline_test_res_bpp_refresh_force_on(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60e",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(!mode.refresh_specified);
-	FAIL_ON(mode.refresh != 60);
-
-	FAIL_ON(!mode.bpp_specified);
-	FAIL_ON(mode.bpp != 24);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_ON);
-
-	return 0;
+	const char *cmdline = "720x480-24@60e";
+
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+
+	KUNIT_EXPECT_TRUE(test, mode.refresh_specified);
+	KUNIT_EXPECT_EQ(test, mode.refresh, 60);
+
+	KUNIT_EXPECT_TRUE(test, mode.bpp_specified);
+	KUNIT_EXPECT_EQ(test, mode.bpp, 24);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_ON);
 }
 
-static int drm_cmdline_test_res_bpp_refresh_force_on_analog(void *ignored)
+static void drm_cmdline_test_res_bpp_refresh_force_on_analog(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60D",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(!mode.refresh_specified);
-	FAIL_ON(mode.refresh != 60);
-
-	FAIL_ON(!mode.bpp_specified);
-	FAIL_ON(mode.bpp != 24);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_ON);
-
-	return 0;
+	const char *cmdline = "720x480-24@60D";
+
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+
+	KUNIT_EXPECT_TRUE(test, mode.refresh_specified);
+	KUNIT_EXPECT_EQ(test, mode.refresh, 60);
+
+	KUNIT_EXPECT_TRUE(test, mode.bpp_specified);
+	KUNIT_EXPECT_EQ(test, mode.bpp, 24);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_ON);
 }
 
-static int drm_cmdline_test_res_bpp_refresh_force_on_digital(void *ignored)
+static void drm_cmdline_test_res_bpp_refresh_force_on_digital(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
-	static const struct drm_connector connector = {
+	const struct drm_connector connector = {
 		.connector_type = DRM_MODE_CONNECTOR_DVII,
 	};
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60D",
-							   &connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(!mode.refresh_specified);
-	FAIL_ON(mode.refresh != 60);
-
-	FAIL_ON(!mode.bpp_specified);
-	FAIL_ON(mode.bpp != 24);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_ON_DIGITAL);
-
-	return 0;
+	const char *cmdline = "720x480-24@60D";
+
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+
+	KUNIT_EXPECT_TRUE(test, mode.refresh_specified);
+	KUNIT_EXPECT_EQ(test, mode.refresh, 60);
+
+	KUNIT_EXPECT_TRUE(test, mode.bpp_specified);
+	KUNIT_EXPECT_EQ(test, mode.bpp, 24);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_ON_DIGITAL);
 }
 
-static int drm_cmdline_test_res_bpp_refresh_interlaced_margins_force_on(void *ignored)
+static void drm_cmdline_test_res_bpp_refresh_interlaced_margins_force_on(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60ime",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(!mode.refresh_specified);
-	FAIL_ON(mode.refresh != 60);
-
-	FAIL_ON(!mode.bpp_specified);
-	FAIL_ON(mode.bpp != 24);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(!mode.interlace);
-	FAIL_ON(!mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_ON);
-
-	return 0;
+	const char *cmdline = "720x480-24@60ime";
+
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+
+	KUNIT_EXPECT_TRUE(test, mode.refresh_specified);
+	KUNIT_EXPECT_EQ(test, mode.refresh, 60);
+
+	KUNIT_EXPECT_TRUE(test, mode.bpp_specified);
+	KUNIT_EXPECT_EQ(test, mode.bpp, 24);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_TRUE(test, mode.interlace);
+	KUNIT_EXPECT_TRUE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_ON);
 }
 
-static int drm_cmdline_test_res_margins_force_on(void *ignored)
+static void drm_cmdline_test_res_margins_force_on(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
+	const char *cmdline = "720x480me";
 
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480me",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(mode.refresh_specified);
-
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(!mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_ON);
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_vesa_margins(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480Mm",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(mode.refresh_specified);
-
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(!mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(!mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
 
-	return 0;
-}
-
-static int drm_cmdline_test_res_invalid_mode(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
 
-	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480f",
-							  &no_connector,
-							  &mode));
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
 
-	return 0;
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_TRUE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_ON);
 }
 
-static int drm_cmdline_test_res_bpp_wrong_place_mode(void *ignored)
+static void drm_cmdline_test_res_vesa_margins(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
+	const char *cmdline = "720x480Mm";
 
-	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480e-24",
-							  &no_connector,
-							  &mode));
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
 
-	return 0;
-}
-
-static int drm_cmdline_test_name(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
 
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("NTSC",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(strcmp(mode.name, "NTSC"));
-	FAIL_ON(mode.refresh_specified);
-	FAIL_ON(mode.bpp_specified);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
 
-	return 0;
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_TRUE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_TRUE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
 }
 
-static int drm_cmdline_test_name_bpp(void *ignored)
+static void drm_cmdline_test_name(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("NTSC-24",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(strcmp(mode.name, "NTSC"));
-
-	FAIL_ON(mode.refresh_specified);
-
-	FAIL_ON(!mode.bpp_specified);
-	FAIL_ON(mode.bpp != 24);
-
-	return 0;
+	const char *cmdline = "NTSC";
+
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_STREQ(test, mode.name, "NTSC");
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
 }
 
-static int drm_cmdline_test_name_bpp_refresh(void *ignored)
+static void drm_cmdline_test_name_bpp(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
+	const char *cmdline = "NTSC-24";
 
-	FAIL_ON(drm_mode_parse_command_line_for_connector("NTSC-24@60",
-							  &no_connector,
-							  &mode));
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_STREQ(test, mode.name, "NTSC");
 
-	return 0;
-}
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
 
-static int drm_cmdline_test_name_refresh(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("NTSC@60",
-							  &no_connector,
-							  &mode));
-
-	return 0;
+	KUNIT_EXPECT_TRUE(test, mode.bpp_specified);
+	KUNIT_EXPECT_EQ(test, mode.bpp, 24);
 }
 
-static int drm_cmdline_test_name_refresh_wrong_mode(void *ignored)
+static void drm_cmdline_test_name_option(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("NTSC@60m",
-							  &no_connector,
-							  &mode));
-
-	return 0;
+	const char *cmdline = "NTSC,rotate=180";
+
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_STREQ(test, mode.name, "NTSC");
+	KUNIT_EXPECT_EQ(test, mode.rotation_reflection, DRM_MODE_ROTATE_180);
 }
 
-static int drm_cmdline_test_name_refresh_invalid_mode(void *ignored)
+static void drm_cmdline_test_name_bpp_option(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("NTSC@60f",
-							  &no_connector,
-							  &mode));
-
-	return 0;
+	const char *cmdline = "NTSC-24,rotate=180";
+
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_STREQ(test, mode.name, "NTSC");
+	KUNIT_EXPECT_EQ(test, mode.rotation_reflection, DRM_MODE_ROTATE_180);
+	KUNIT_EXPECT_TRUE(test, mode.bpp_specified);
+	KUNIT_EXPECT_EQ(test, mode.bpp, 24);
 }
 
-static int drm_cmdline_test_name_option(void *ignored)
+static void drm_cmdline_test_rotate_0(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
+	const char *cmdline = "720x480,rotate=0";
 
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("NTSC,rotate=180",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(strcmp(mode.name, "NTSC"));
-	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_180);
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+	KUNIT_EXPECT_EQ(test, mode.rotation_reflection, DRM_MODE_ROTATE_0);
 
-	return 0;
-}
-
-static int drm_cmdline_test_name_bpp_option(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
 
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("NTSC-24,rotate=180",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(strcmp(mode.name, "NTSC"));
-	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_180);
-	FAIL_ON(!mode.bpp_specified);
-	FAIL_ON(mode.bpp != 24);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
 
-	return 0;
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
 }
 
-static int drm_cmdline_test_rotate_0(void *ignored)
+static void drm_cmdline_test_rotate_90(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
+	const char *cmdline = "720x480,rotate=90";
 
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,rotate=0",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_0);
-
-	FAIL_ON(mode.refresh_specified);
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+	KUNIT_EXPECT_EQ(test, mode.rotation_reflection, DRM_MODE_ROTATE_90);
 
-	FAIL_ON(mode.bpp_specified);
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
 
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
 
-	return 0;
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
 }
 
-static int drm_cmdline_test_rotate_90(void *ignored)
+static void drm_cmdline_test_rotate_180(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
+	const char *cmdline = "720x480,rotate=180";
 
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,rotate=90",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_90);
-
-	FAIL_ON(mode.refresh_specified);
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+	KUNIT_EXPECT_EQ(test, mode.rotation_reflection, DRM_MODE_ROTATE_180);
 
-	FAIL_ON(mode.bpp_specified);
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
 
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
 
-	return 0;
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
 }
 
-static int drm_cmdline_test_rotate_180(void *ignored)
+static void drm_cmdline_test_rotate_270(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
+	const char *cmdline = "720x480,rotate=270";
 
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,rotate=180",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_180);
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+	KUNIT_EXPECT_EQ(test, mode.rotation_reflection, DRM_MODE_ROTATE_270);
 
-	FAIL_ON(mode.refresh_specified);
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
 
-	FAIL_ON(mode.bpp_specified);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
 
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
 }
 
-static int drm_cmdline_test_rotate_270(void *ignored)
+static void drm_cmdline_test_hmirror(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
+	const char *cmdline = "720x480,reflect_x";
 
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,rotate=270",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_270);
-
-	FAIL_ON(mode.refresh_specified);
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+	KUNIT_EXPECT_EQ(test, mode.rotation_reflection, (DRM_MODE_ROTATE_0 | DRM_MODE_REFLECT_X));
 
-	FAIL_ON(mode.bpp_specified);
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
 
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
 
-	return 0;
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
 }
 
-static int drm_cmdline_test_rotate_multiple(void *ignored)
+static void drm_cmdline_test_vmirror(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
+	const char *cmdline = "720x480,reflect_y";
 
-	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480,rotate=0,rotate=90",
-							  &no_connector,
-							  &mode));
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+	KUNIT_EXPECT_EQ(test, mode.rotation_reflection, (DRM_MODE_ROTATE_0 | DRM_MODE_REFLECT_Y));
 
-	return 0;
-}
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
 
-static int drm_cmdline_test_rotate_invalid_val(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480,rotate=42",
-							  &no_connector,
-							  &mode));
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
 
-	return 0;
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
 }
 
-static int drm_cmdline_test_rotate_truncated(void *ignored)
+static void drm_cmdline_test_margin_options(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480,rotate=",
-							  &no_connector,
-							  &mode));
-
-	return 0;
+	const char *cmdline =
+		"720x480,margin_right=14,margin_left=24,margin_bottom=36,margin_top=42";
+
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+	KUNIT_EXPECT_EQ(test, mode.tv_margins.right, 14);
+	KUNIT_EXPECT_EQ(test, mode.tv_margins.left, 24);
+	KUNIT_EXPECT_EQ(test, mode.tv_margins.bottom, 36);
+	KUNIT_EXPECT_EQ(test, mode.tv_margins.top, 42);
+
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
 }
 
-static int drm_cmdline_test_hmirror(void *ignored)
+static void drm_cmdline_test_multiple_options(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
+	const char *cmdline = "720x480,rotate=270,reflect_x";
 
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,reflect_x",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-	FAIL_ON(mode.rotation_reflection != (DRM_MODE_ROTATE_0 | DRM_MODE_REFLECT_X));
-
-	FAIL_ON(mode.refresh_specified);
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+	KUNIT_EXPECT_EQ(test, mode.rotation_reflection, (DRM_MODE_ROTATE_270 | DRM_MODE_REFLECT_X));
 
-	FAIL_ON(mode.bpp_specified);
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
 
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
 
-	return 0;
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
 }
 
-static int drm_cmdline_test_vmirror(void *ignored)
+static void drm_cmdline_test_bpp_extra_and_option(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,reflect_y",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-	FAIL_ON(mode.rotation_reflection != (DRM_MODE_ROTATE_0 | DRM_MODE_REFLECT_Y));
-
-	FAIL_ON(mode.refresh_specified);
-
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
+	const char *cmdline = "720x480-24e,rotate=180";
+
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+	KUNIT_EXPECT_EQ(test, mode.rotation_reflection, DRM_MODE_ROTATE_180);
+
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+
+	KUNIT_EXPECT_TRUE(test, mode.bpp_specified);
+	KUNIT_EXPECT_EQ(test, mode.bpp, 24);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_ON);
 }
 
-static int drm_cmdline_test_margin_options(void *ignored)
+static void drm_cmdline_test_extra_and_option(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,margin_right=14,margin_left=24,margin_bottom=36,margin_top=42",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-	FAIL_ON(mode.tv_margins.right != 14);
-	FAIL_ON(mode.tv_margins.left != 24);
-	FAIL_ON(mode.tv_margins.bottom != 36);
-	FAIL_ON(mode.tv_margins.top != 42);
-
-	FAIL_ON(mode.refresh_specified);
-
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
+	const char *cmdline = "720x480e,rotate=180";
+
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+	KUNIT_EXPECT_EQ(test, mode.rotation_reflection, DRM_MODE_ROTATE_180);
+
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_ON);
 }
 
-static int drm_cmdline_test_multiple_options(void *ignored)
+static void drm_cmdline_test_freestanding_options(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,rotate=270,reflect_x",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-	FAIL_ON(mode.rotation_reflection != (DRM_MODE_ROTATE_270 | DRM_MODE_REFLECT_X));
-
-	FAIL_ON(mode.refresh_specified);
-
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
+	const char *cmdline = "margin_right=14,margin_left=24,margin_bottom=36,margin_top=42";
+
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_FALSE(test, mode.specified);
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_EQ(test, mode.tv_margins.right, 14);
+	KUNIT_EXPECT_EQ(test, mode.tv_margins.left, 24);
+	KUNIT_EXPECT_EQ(test, mode.tv_margins.bottom, 36);
+	KUNIT_EXPECT_EQ(test, mode.tv_margins.top, 42);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
 }
 
-static int drm_cmdline_test_invalid_option(void *ignored)
+static void drm_cmdline_test_freestanding_force_e_and_options(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480,test=42",
-							  &no_connector,
-							  &mode));
-
-	return 0;
+	const char *cmdline = "e,margin_right=14,margin_left=24,margin_bottom=36,margin_top=42";
+
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_FALSE(test, mode.specified);
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_EQ(test, mode.tv_margins.right, 14);
+	KUNIT_EXPECT_EQ(test, mode.tv_margins.left, 24);
+	KUNIT_EXPECT_EQ(test, mode.tv_margins.bottom, 36);
+	KUNIT_EXPECT_EQ(test, mode.tv_margins.top, 42);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_ON);
 }
 
-static int drm_cmdline_test_bpp_extra_and_option(void *ignored)
+static void drm_cmdline_test_panel_orientation(struct kunit *test)
 {
 	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24e,rotate=180",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_180);
-
-	FAIL_ON(mode.refresh_specified);
-
-	FAIL_ON(!mode.bpp_specified);
-	FAIL_ON(mode.bpp != 24);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_ON);
-
-	return 0;
+	const char *cmdline = "panel_orientation=upside_down";
+
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector(cmdline,
+									  &no_connector,
+									  &mode));
+	KUNIT_EXPECT_FALSE(test, mode.specified);
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_EQ(test, mode.panel_orientation, DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
 }
 
-static int drm_cmdline_test_extra_and_option(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480e,rotate=180",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_180);
-
-	FAIL_ON(mode.refresh_specified);
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_ON);
-
-	return 0;
-}
+struct drm_cmdline_negative_test {
+	const char *name;
+	const char *cmdline;
+};
 
-static int drm_cmdline_test_freestanding_options(void *ignored)
+static void drm_cmdline_test_negative(struct kunit *test)
 {
+	const struct drm_cmdline_negative_test *params = test->param_value;
 	struct drm_cmdline_mode mode = { };
 
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("margin_right=14,margin_left=24,margin_bottom=36,margin_top=42",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(mode.specified);
-	FAIL_ON(mode.refresh_specified);
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.tv_margins.right != 14);
-	FAIL_ON(mode.tv_margins.left != 24);
-	FAIL_ON(mode.tv_margins.bottom != 36);
-	FAIL_ON(mode.tv_margins.top != 42);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
+	KUNIT_EXPECT_FALSE(test, drm_mode_parse_command_line_for_connector(params->cmdline,
+									   &no_connector,
+									   &mode));
 }
 
-static int drm_cmdline_test_freestanding_force_e_and_options(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("e,margin_right=14,margin_left=24,margin_bottom=36,margin_top=42",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(mode.specified);
-	FAIL_ON(mode.refresh_specified);
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.tv_margins.right != 14);
-	FAIL_ON(mode.tv_margins.left != 24);
-	FAIL_ON(mode.tv_margins.bottom != 36);
-	FAIL_ON(mode.tv_margins.top != 42);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_ON);
-
-	return 0;
-}
+static const struct drm_cmdline_negative_test drm_cmdline_negative_tests[] = {
+	{
+		.name = "margin_only",
+		.cmdline = "m",
+	},
+	{
+		.name = "interlace_only",
+		.cmdline = "i",
+	},
+	{
+		.name = "res_missing_x",
+		.cmdline = "x480",
+	},
+	{
+		.name = "res_missing_y",
+		.cmdline = "1024x",
+	},
+	{
+		.name = "res_bad_y",
+		.cmdline = "1024xtest",
+	},
+	{
+		.name = "res_missing_y_bpp",
+		.cmdline = "1024x-24",
+	},
+	{
+		.name = "res_bad_bpp",
+		.cmdline = "720x480-test",
+	},
+	{
+		.name = "res_bad_refresh",
+		.cmdline = "720x480@refresh",
+	},
+	{
+		.name = "res_bpp_refresh_force_on_off",
+		.cmdline = "720x480-24@60de",
+	},
+	{
+		.name = "res_invalid_mode",
+		.cmdline = "720x480f",
+	},
+	{
+		.name = "res_bpp_wrong_place_mode",
+		.cmdline = "720x480e-24",
+	},
+	{
+		.name = "name_bpp_refresh",
+		.cmdline = "NTSC-24@60",
+	},
+	{
+		.name = "name_refresh",
+		.cmdline = "NTSC@60",
+	},
+	{
+		.name = "name_refresh_wrong_mode",
+		.cmdline = "NTSC@60m",
+	},
+	{
+		.name = "name_refresh_invalid_mode",
+		.cmdline = "NTSC@60f",
+	},
+	{
+		.name = "rotate_multiple",
+		.cmdline = "720x480,rotate=0,rotate=90",
+	},
+	{
+		.name = "rotate_invalid_val",
+		.cmdline = "720x480,rotate=42",
+	},
+	{
+		.name = "rotate_truncated",
+		.cmdline = "720x480,rotate=",
+	},
+	{
+		.name = "invalid_option",
+		.cmdline = "720x480,test=42",
+	},
+};
 
-static int drm_cmdline_test_panel_orientation(void *ignored)
+static void drm_cmdline_negative_desc(const struct drm_cmdline_negative_test *t,
+				      char *desc)
 {
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("panel_orientation=upside_down",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(mode.specified);
-	FAIL_ON(mode.refresh_specified);
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.panel_orientation != DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
+	sprintf(desc, "%s", t->name);
 }
 
-#include "drm_selftest.c"
-
-static int __init test_drm_cmdline_init(void)
-{
-	int err;
+KUNIT_ARRAY_PARAM(drm_cmdline_negative, drm_cmdline_negative_tests, drm_cmdline_negative_desc);
+
+static struct kunit_case drm_cmdline_tests[] = {
+	KUNIT_CASE(drm_cmdline_test_force_d_only),
+	KUNIT_CASE(drm_cmdline_test_force_D_only_dvi),
+	KUNIT_CASE(drm_cmdline_test_force_D_only_hdmi),
+	KUNIT_CASE(drm_cmdline_test_force_D_only_not_digital),
+	KUNIT_CASE(drm_cmdline_test_force_e_only),
+	KUNIT_CASE(drm_cmdline_test_res),
+	KUNIT_CASE(drm_cmdline_test_res_vesa),
+	KUNIT_CASE(drm_cmdline_test_res_vesa_rblank),
+	KUNIT_CASE(drm_cmdline_test_res_rblank),
+	KUNIT_CASE(drm_cmdline_test_res_bpp),
+	KUNIT_CASE(drm_cmdline_test_res_refresh),
+	KUNIT_CASE(drm_cmdline_test_res_bpp_refresh),
+	KUNIT_CASE(drm_cmdline_test_res_bpp_refresh_interlaced),
+	KUNIT_CASE(drm_cmdline_test_res_bpp_refresh_margins),
+	KUNIT_CASE(drm_cmdline_test_res_bpp_refresh_force_off),
+	KUNIT_CASE(drm_cmdline_test_res_bpp_refresh_force_on),
+	KUNIT_CASE(drm_cmdline_test_res_bpp_refresh_force_on_analog),
+	KUNIT_CASE(drm_cmdline_test_res_bpp_refresh_force_on_digital),
+	KUNIT_CASE(drm_cmdline_test_res_bpp_refresh_interlaced_margins_force_on),
+	KUNIT_CASE(drm_cmdline_test_res_margins_force_on),
+	KUNIT_CASE(drm_cmdline_test_res_vesa_margins),
+	KUNIT_CASE(drm_cmdline_test_name),
+	KUNIT_CASE(drm_cmdline_test_name_bpp),
+	KUNIT_CASE(drm_cmdline_test_name_option),
+	KUNIT_CASE(drm_cmdline_test_name_bpp_option),
+	KUNIT_CASE(drm_cmdline_test_rotate_0),
+	KUNIT_CASE(drm_cmdline_test_rotate_90),
+	KUNIT_CASE(drm_cmdline_test_rotate_180),
+	KUNIT_CASE(drm_cmdline_test_rotate_270),
+	KUNIT_CASE(drm_cmdline_test_hmirror),
+	KUNIT_CASE(drm_cmdline_test_vmirror),
+	KUNIT_CASE(drm_cmdline_test_margin_options),
+	KUNIT_CASE(drm_cmdline_test_multiple_options),
+	KUNIT_CASE(drm_cmdline_test_bpp_extra_and_option),
+	KUNIT_CASE(drm_cmdline_test_extra_and_option),
+	KUNIT_CASE(drm_cmdline_test_freestanding_options),
+	KUNIT_CASE(drm_cmdline_test_freestanding_force_e_and_options),
+	KUNIT_CASE(drm_cmdline_test_panel_orientation),
+	KUNIT_CASE_PARAM(drm_cmdline_test_negative, drm_cmdline_negative_gen_params),
+	{}
+};
 
-	err = run_selftests(selftests, ARRAY_SIZE(selftests), NULL);
+static struct kunit_suite drm_cmdline_test_suite = {
+	.name = "drm_cmdline_tests",
+	.test_cases = drm_cmdline_tests,
+};
 
-	return err > 0 ? 0 : err;
-}
-module_init(test_drm_cmdline_init);
+kunit_test_suite(drm_cmdline_test_suite);
 
 MODULE_AUTHOR("Maxime Ripard <maxime.ripard@bootlin.com>");
 MODULE_LICENSE("GPL");
-- 
2.34.1

