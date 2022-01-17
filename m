Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E15F491252
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 00:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243796AbiAQXYm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jan 2022 18:24:42 -0500
Received: from mga11.intel.com ([192.55.52.93]:21981 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243793AbiAQXYl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jan 2022 18:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642461881; x=1673997881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=GcWP1LRMN7SxSYJ3pSTe8V2ey5lZyLVzDF6iV8Uf3kU=;
  b=Ogz/IjPEuxt3RsBqDtuAqAYl0wy0NLo+dPkCH6GPKR8Q7Ya9wSwhTJpG
   /AmqM95rBx9b13xm9QzgFRzshCb0zEIMHOzN4HcZXGeCnALZoTITGFJzS
   ByKGraOf2qbH4cw1urW37zWqXaN0oK7kAA2TyBwTVW7m4D78GfNyHQDCs
   HbrtaNGuISbA1vWWBKtn1G2Txe5psYY2YBQWbRiGJQoK0B/t14eGwDeao
   S2a44i8WYbRyJpI0Bqw6X/zgzjVjDOiskvxkaOug9XrAv/J1f198jHEyT
   5F8wz2Ipd32asEYeGqTQ/hDvM+WzNg2iEu2dN7qOc+7CdaUdYaTDty8YU
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="242264065"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="242264065"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 15:24:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="517554411"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 17 Jan 2022 15:24:41 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 17 Jan 2022 15:24:40 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 17 Jan 2022 15:24:40 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 17 Jan 2022 15:24:40 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 17 Jan 2022 15:24:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/ypTEqIjI5qLpdPy4LDBxwrPbLrip+xUz4uUm6gIVzDsGXK+GQTdhuMIeEptzOHstzA7d6rhOkJOieB0QMnFPGQt+UfOTAt42WUVXu5jZjgrJ525shE3uw0XT7qNUKQ6Wmh2zbDfSy5oVlifcWGhV5MPUPeIPaPvnS7c0HpOApmYehBEUq7bJ9lzCsbe8L6M1pInvH2wVdEUiWcx21q7vNHWoGwl2nQ2aoyH6Lm4JoJOd51+4RO4T8VaQw+yQyVHreX9aEKUFvhuFaGSBL+4hlKkqLuHbqlTUA1GhVe3E6V7JyZQHG5rgcf9kkx7R31KsBwVHaN/eubxkq+4MoTdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhPMBEpU7fSd99CDkUXlfjakSYRMf0JwjL0TEAu1GOU=;
 b=h3FOo9bebJvnzqGJdzoQHMN8DMhc+5i4sg8rX0n1VUYx/h/kKOBpcYPRaXSg2UjsE2YO3YyKhhqNqSKmHa6wMN4aqvUTNAye429uJffCk8jb39j5tyR2yMDapOdUgrsnE0oP+xL7uKv6/dcHXAntp2OUjdFJtN9eIk7yAY8XzQm5nEUD/SuJ1U/zXyW0nDPgMYza23lVFgq01pU5utAN9/gEpg1xyt6T7ABGHvxTbw9PlbH+63l8iGKMFfnOH9YVYJWZXHxKoBniZyPcX7aULNc9hlZc5LZHvx15SAEl8gKMUiSBwPEzLJUYaOj5eFEPFYJFG6Bay60PVpUfWfGYRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 DM4PR11MB5550.namprd11.prod.outlook.com (2603:10b6:5:38b::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.9; Mon, 17 Jan 2022 23:24:36 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::fc15:bd26:128a:f5f5]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::fc15:bd26:128a:f5f5%8]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 23:24:36 +0000
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
Subject: [RFC 06/10] drm: test-drm_dp_mst_helper: Convert to KUnit
Date:   Tue, 18 Jan 2022 00:22:55 +0100
Message-ID: <20220117232259.180459-7-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117232259.180459-1-michal.winiarski@intel.com>
References: <20220117232259.180459-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0056.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::20) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6f0c31c-b6e4-4d26-4f1a-08d9da1086a8
X-MS-TrafficTypeDiagnostic: DM4PR11MB5550:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM4PR11MB5550824F58F8D6843FDC54CB98579@DM4PR11MB5550.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MMH3H+zODFnfLnkgrcVVhwPO8dhv0wVelBCByc4e3XMtvVKH5TZnlb5Vk/reg4GwsQ5tILrzdBPsyDIXXBUGqk91qyREbly6qfB56GkhhiFkdBiqR6ldue8pqO82zDaCmq4B3nmTBlYlpAvpJkD1tr0B6j2Dsjo8ThYXPiG9lTQDHkfBDzSrhJ08zPXciwFeculN0dAq9wDxMKKNNr3J+5KOOKjsBo4Iuq13sTl7btZDmLDD/hBFv56m+iw3e2krtvo274yK61QoDSvv58XJc6U1LxvamoYxUNAWtq32TWVHtK3erPlDIrWSz2AryuDZKyttl8dJJD2NGkS2KPBIh0Oai1y3DdmGD3qaRpJ7dDwKUPhASovOG+wtABANixyQY0X5HZ2N7/v8rKyK/6pvMslvuaVM9Ilm5cI9iroCPxtcrS1Rn1XrWKBvjcuwYrTRYyZXoAP1CN/4q/ljfkGPbRtNj3hrq1pFIKkcMZFTsAzTz3tOk9NlkbTVDGD7SqcaQ/A8tRVKkiFo7J4S25SvSdJg3L1Zzp+rR904KUsHWVIUiR1nCRVEyltM1uAHhP2pYDHoPvJ8+ahrsAEDM+GzyVGbPJYp1lyUN2/4OouF7Z1WKyOpt8Sj8CNSU9MgsdcmlyyBF2BQ7TKHB7gMJ5vUKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(82960400001)(4326008)(5660300002)(36756003)(186003)(6506007)(7416002)(1076003)(54906003)(6512007)(83380400001)(26005)(66946007)(66476007)(66556008)(316002)(6486002)(38100700002)(8936002)(508600001)(2906002)(30864003)(6666004)(8676002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDBrTGxldXM4SThxaEJSVFFLZmJyNzRDalJDSnhXMldDWEh0ZnRTTXl3b1oz?=
 =?utf-8?B?MjkvNGtwcldRelpycVQvdkhHTVlVVzVwdms0L1JVUWZWaHI3QVAvQmg4QUdi?=
 =?utf-8?B?QzNNY0o1dlRzamZuM2dkNnUvdFVhd3Q3Wll1VVZBRVRocUorVEtMQS9CMStS?=
 =?utf-8?B?ZnVXRkd4SWlwc1FWYk84TjBKeWQwSXRrZHNFWHV0TG9mWFJuNVVyV2wvZVRB?=
 =?utf-8?B?SnhsSFh5N0xaWDhtYlNnSGM4NGZVaEk2SHZZL3oxQktyZ09KcjNON2NxVitI?=
 =?utf-8?B?bWRwekVRbFJVSUtZNWZabDFCNHJ0MWFEdHBYSFFGTTJBb2R0RUdlOTNqZjIr?=
 =?utf-8?B?WEszU0FuV3FrRTRzU2VmdncvRHgxTm8zd3hDZUp0TGt1QXVoS0JkajFsUjJt?=
 =?utf-8?B?bFcwRWFNRS9DSkNEVDRtVWlJQnI5Z3R3cmp4TGozanJNZzNTbTRScVZNUnh5?=
 =?utf-8?B?ZnVmWCtURm1xM1I3YUkvTkxuYWc3NFJYRXBaWFArVERsanhRV1FLZkJpUUpm?=
 =?utf-8?B?MTZUeUkwdmlhTks3Zkd5VGVlM0pNVXd0bzhpNWlvU1owbDdpN2NNZG9aY3k3?=
 =?utf-8?B?NnRGby8xWU1ZQW1yVzJncTM3ZGwvTlIyQmFKTXUrM1RXa3kvSVo5V3FWMmk1?=
 =?utf-8?B?eXdZalZUc2hRU3FORlVSYWhSNFNsaWJvUnU0b2dDSHJNUnl4V25tVGZZdUFV?=
 =?utf-8?B?SWdSaFZHYTdyajVWeEI5Ymt6Q3gyR2wvS3ZYUUJtRGgxbnk5WTdFUmZJa083?=
 =?utf-8?B?VFFIcTlHanhwbURha05NZHo0T2RFQ2VrUkdPTTMybDdIN3UzWXVXc3Z1dFdN?=
 =?utf-8?B?eWg3MVZ3SE5qTEI5K0tmWlgxSGtMekJ0d0xIbGpUM2lld1lwdVAyVEtkU2hS?=
 =?utf-8?B?Z2d3akdCRFF6a0RHYXdjd0pURVp1Yks3bzd5MzFzVFJUeVRMRTJoTzRmRDEz?=
 =?utf-8?B?VlZmTUppOU5HUng4Y0FXK1lodUdMQ1ZaSkZVQ3hpUE81UUN6aU5lK2NoU1FF?=
 =?utf-8?B?S3Q1clM5RkVYd2xRYUpQbGh3cGpieFU4UzJIQzBJd2pTT2dXajlYWUNkU2tk?=
 =?utf-8?B?dHJRYzJVQXc2eHUvTitzYWhVYkRDVTBDRVdheHg3Q3JQeVkva0l6azdaWUx6?=
 =?utf-8?B?U1NrSnBlU0lVL2VBWGFiY09WdXRWS0txc2o2Y0piT1lqeFg1SnBzQTdURm9Z?=
 =?utf-8?B?aFZ2aU9vc01OOUtoU1JROUZWdlFOUHVmRVZZUFFGZWRjcWZqaFpaVkE0T3pM?=
 =?utf-8?B?L2NTV0RpMTROZTRuNktyaXYzZ25zTG0rMDFwY3BDbmhZQUtsUFlYeEZzQi9q?=
 =?utf-8?B?cG80MlNnclRKOUZxVElZRjd2TzlOYU5zWHJFYzdTZjFuQnVpNDdVNEt5UDlN?=
 =?utf-8?B?T0JEemtlQUZJUHdueHZDQjQ1ZFlFS3BXWDl4UkZVbDB6VExoa1d4ancvVnZE?=
 =?utf-8?B?WnIzNEJDVmlVTzg2WDh5QUVEM1hzNUlId2N1NFhHdnc2SlRBbyt3ZXRCUzN5?=
 =?utf-8?B?d0xvVVM0SU9FaXJ1WFBsVmtmWnVISkJRTTExUmJIOFlkVlJPeGhDenZML0dD?=
 =?utf-8?B?eHpBSUN3YmRLaGFlZ2R6UWxGbGdnS1BuYm1MMnROSThYVkZiaFZpNDF1RHRp?=
 =?utf-8?B?QXd0K043VmFURHBnOTVuaHJrWFBQTmZ4eU5BQXpBejc4eXFSYVM2MmZMZWhJ?=
 =?utf-8?B?dEsvS2VxZWJibUdjRTIxdEVkTGl3d1VBZERXNmgxTDJSSjRJYXdZNENRQysr?=
 =?utf-8?B?WFRqRCtZMVFJcU5Vekg5OFNsLzBWbFM5VGQ0QTVyd1ZiR3FvS20yOVU0UGdi?=
 =?utf-8?B?OGlqSDdVeTA5MFQxbTQ5a2tlVEsrNWgwd2tYS3l3YnIyN0lyM083cXR5Ujhv?=
 =?utf-8?B?YzliSVZhcDFTYkNRaUFlRWxWM2pvSjR5RWUyYlpwYThEOWYvSTBRd1dEVVYr?=
 =?utf-8?B?OTlST1JuZ0huVUpWN08rWmx4U1FCek9DQkZYSjN6MkExL0I4SlBTZWs0Z2xq?=
 =?utf-8?B?UTllSG1TanY3aWQ0M3h0TWNwajZIMVVWZkN6VW8vTWpPcWlzSFFiYnZqcmpQ?=
 =?utf-8?B?MndSdFdGYlJrMnJIL015VWIwYmcrTkQzMGR3akdnTWNNVVMxUHJhZjdEV01Y?=
 =?utf-8?B?T01WSCt5K3JFQzEzV1poNHFZZDQvSi9LSEpDMXMyRDdQalpkNVhLejFkOFBU?=
 =?utf-8?B?TjZqckZjOERKSnFGOGlSSW1lMUd4OUZTR1dkRDhlT1c2TjN1Y2FEcy93NGtl?=
 =?utf-8?B?MTFYQncxYkxxTW5SSTJmVWRGUWRnPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f0c31c-b6e4-4d26-4f1a-08d9da1086a8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 23:24:36.5010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSwUeou16kHll76Z9u25crM6JAydeUjriX5t0N+BIJo+ErS8UxKcIUsVVQrIU3ILa2cGP1lPbv5nCG9YnTXPG7yv/j3+qp2Iwm/FA0dYNYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5550
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

igt_dp_mst_calc_pbn_mode was converted one-to-one,
igt_dp_mst_sideband_msg_req_decode was refactored to parameterized test.

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
---
 drivers/gpu/drm/selftests/Makefile            |   3 +-
 .../gpu/drm/selftests/drm_modeset_selftests.h |   2 -
 .../drm/selftests/test-drm_dp_mst_helper.c    | 502 ++++++++++++------
 .../drm/selftests/test-drm_modeset_common.h   |   2 -
 4 files changed, 330 insertions(+), 179 deletions(-)

diff --git a/drivers/gpu/drm/selftests/Makefile b/drivers/gpu/drm/selftests/Makefile
index 35f2f40dbaf3..77e37eebf099 100644
--- a/drivers/gpu/drm/selftests/Makefile
+++ b/drivers/gpu/drm/selftests/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test-drm_modeset-$(CONFIG_DRM_DEBUG_SELFTEST) := \
 		      test-drm_modeset_common.o \
-		      test-drm_dp_mst_helper.o \
 		      test-drm_rect.o
 
 obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o test-drm_modeset.o
@@ -9,4 +8,4 @@ obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o test-drm_modeset.o
 obj-$(CONFIG_DRM_KUNIT_TEST) := \
 	test-drm_cmdline_parser.o test-drm_plane_helper.o \
 	test-drm_format.o test-drm_framebuffer.o \
-	test-drm_damage_helper.o
+	test-drm_damage_helper.o test-drm_dp_mst_helper.o
diff --git a/drivers/gpu/drm/selftests/drm_modeset_selftests.h b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
index b6a6dba66b64..630770d30aba 100644
--- a/drivers/gpu/drm/selftests/drm_modeset_selftests.h
+++ b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
@@ -10,5 +10,3 @@ selftest(drm_rect_clip_scaled_div_by_zero, igt_drm_rect_clip_scaled_div_by_zero)
 selftest(drm_rect_clip_scaled_not_clipped, igt_drm_rect_clip_scaled_not_clipped)
 selftest(drm_rect_clip_scaled_clipped, igt_drm_rect_clip_scaled_clipped)
 selftest(drm_rect_clip_scaled_signed_vs_unsigned, igt_drm_rect_clip_scaled_signed_vs_unsigned)
-selftest(dp_mst_calc_pbn_mode, igt_dp_mst_calc_pbn_mode)
-selftest(dp_mst_sideband_msg_req_decode, igt_dp_mst_sideband_msg_req_decode)
diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
index 6b4759ed6bfd..d0719f3c5a42 100644
--- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
+++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
@@ -3,54 +3,97 @@
  * Test cases for for the DRM DP MST helpers
  */
 
-#define PREFIX_STR "[drm_dp_mst_helper]"
-
+#include <kunit/test.h>
 #include <linux/random.h>
 
 #include <drm/drm_dp_mst_helper.h>
 #include <drm/drm_print.h>
 
 #include "../drm_dp_mst_topology_internal.h"
-#include "test-drm_modeset_common.h"
 
-int igt_dp_mst_calc_pbn_mode(void *ignored)
+struct dp_mst_calc_pbn_mode_test {
+	int rate;
+	int bpp;
+	int expected;
+	bool dsc;
+};
+
+static void dp_mst_calc_pbn_mode(struct kunit *test)
 {
-	int pbn, i;
-	const struct {
-		int rate;
-		int bpp;
-		int expected;
-		bool dsc;
-	} test_params[] = {
-		{ 154000, 30, 689, false },
-		{ 234000, 30, 1047, false },
-		{ 297000, 24, 1063, false },
-		{ 332880, 24, 50, true },
-		{ 324540, 24, 49, true },
-	};
+	const struct dp_mst_calc_pbn_mode_test *params = test->param_value;
+	int pbn;
 
-	for (i = 0; i < ARRAY_SIZE(test_params); i++) {
-		pbn = drm_dp_calc_pbn_mode(test_params[i].rate,
-					   test_params[i].bpp,
-					   test_params[i].dsc);
-		FAIL(pbn != test_params[i].expected,
-		     "Expected PBN %d for clock %d bpp %d, got %d\n",
-		     test_params[i].expected, test_params[i].rate,
-		     test_params[i].bpp, pbn);
-	}
+	pbn = drm_dp_calc_pbn_mode(params->rate,
+				   params->bpp,
+				   params->dsc);
+
+	KUNIT_EXPECT_EQ(test, pbn, params->expected);
+}
 
-	return 0;
+static const struct dp_mst_calc_pbn_mode_test dp_mst_calc_pbn_mode_tests[] = {
+	{
+		.rate = 154000,
+		.bpp = 30,
+		.expected = 689,
+		.dsc = false,
+	},
+	{
+		.rate = 234000,
+		.bpp = 30,
+		.expected = 1047,
+		.dsc = false,
+	},
+	{
+		.rate = 297000,
+		.bpp = 24,
+		.expected = 1063,
+		.dsc = false,
+	},
+	{
+		.rate = 332880,
+		.bpp = 24,
+		.expected = 50,
+		.dsc = true,
+	},
+	{
+		.rate = 324540,
+		.bpp = 24,
+		.expected = 49,
+		.dsc = true,
+	},
+};
+
+static void dp_mst_calc_pbn_mode_desc(const struct dp_mst_calc_pbn_mode_test *t,
+				      char *desc)
+{
+	sprintf(desc, "rate = %d, bpp = %d, dsc = %s",
+		t->rate, t->bpp, t->dsc ? "true" : "false");
 }
 
-static bool
-sideband_msg_req_equal(const struct drm_dp_sideband_msg_req_body *in,
-		       const struct drm_dp_sideband_msg_req_body *out)
+KUNIT_ARRAY_PARAM(dp_mst_calc_pbn_mode, dp_mst_calc_pbn_mode_tests, dp_mst_calc_pbn_mode_desc);
+
+static void
+drm_dp_mst_helper_printfn(struct drm_printer *p, struct va_format *vaf)
+{
+	struct kunit *test = p->arg;
+
+	kunit_err(test, "%pV", vaf);
+}
+
+static void
+expect_sideband_msg_req_equal(struct kunit *test,
+			      const struct drm_dp_sideband_msg_req_body *in,
+			      const struct drm_dp_sideband_msg_req_body *out)
 {
 	const struct drm_dp_remote_i2c_read_tx *txin, *txout;
+	struct drm_printer p = {
+		.printfn = drm_dp_mst_helper_printfn,
+		.arg = test
+	};
 	int i;
 
 	if (in->req_type != out->req_type)
-		return false;
+		goto fail;
 
 	switch (in->req_type) {
 	/*
@@ -65,7 +108,7 @@ sideband_msg_req_equal(const struct drm_dp_sideband_msg_req_body *in,
 		    IN.num_transactions != OUT.num_transactions ||
 		    IN.port_number != OUT.port_number ||
 		    IN.read_i2c_device_id != OUT.read_i2c_device_id)
-			return false;
+			goto fail;
 
 		for (i = 0; i < IN.num_transactions; i++) {
 			txin = &IN.transactions[i];
@@ -76,11 +119,11 @@ sideband_msg_req_equal(const struct drm_dp_sideband_msg_req_body *in,
 			    txin->num_bytes != txout->num_bytes ||
 			    txin->i2c_transaction_delay !=
 			    txout->i2c_transaction_delay)
-				return false;
+				goto fail;
 
 			if (memcmp(txin->bytes, txout->bytes,
 				   txin->num_bytes) != 0)
-				return false;
+				goto fail;
 		}
 		break;
 #undef IN
@@ -92,9 +135,12 @@ sideband_msg_req_equal(const struct drm_dp_sideband_msg_req_body *in,
 		if (IN.dpcd_address != OUT.dpcd_address ||
 		    IN.num_bytes != OUT.num_bytes ||
 		    IN.port_number != OUT.port_number)
-			return false;
+			goto fail;
 
-		return memcmp(IN.bytes, OUT.bytes, IN.num_bytes) == 0;
+		if (memcmp(IN.bytes, OUT.bytes, IN.num_bytes) != 0)
+			goto fail;
+
+		break;
 #undef IN
 #undef OUT
 
@@ -104,55 +150,65 @@ sideband_msg_req_equal(const struct drm_dp_sideband_msg_req_body *in,
 		if (IN.port_number != OUT.port_number ||
 		    IN.write_i2c_device_id != OUT.write_i2c_device_id ||
 		    IN.num_bytes != OUT.num_bytes)
-			return false;
+			goto fail;
 
-		return memcmp(IN.bytes, OUT.bytes, IN.num_bytes) == 0;
+		if (memcmp(IN.bytes, OUT.bytes, IN.num_bytes) != 0)
+			goto fail;
+
+		break;
 #undef IN
 #undef OUT
 
 	default:
-		return memcmp(in, out, sizeof(*in)) == 0;
+		if (memcmp(in, out, sizeof(*in)) != 0)
+			goto fail;
 	}
 
-	return true;
+	return;
+
+fail:
+	drm_printf(&p, "Expected:\n");
+	drm_dp_dump_sideband_msg_req_body(in, 1, &p);
+	drm_printf(&p, "Got:\n");
+	drm_dp_dump_sideband_msg_req_body(out, 1, &p);
+	KUNIT_FAIL(test, "Encode/decode failed");
+}
+
+struct dp_mst_sideband_msg_req_decode_test {
+	const struct drm_dp_sideband_msg_req_body req;
+	const struct drm_dp_sideband_msg_req_body
+		(*f)(const struct drm_dp_sideband_msg_req_body *in);
+};
+
+const struct drm_dp_sideband_msg_req_body
+param_to_dp_mst_sideband_msg_req_body(const struct dp_mst_sideband_msg_req_decode_test *t)
+{
+	if (t->f)
+		return t->f(&t->req);
+
+	return t->req;
 }
 
-static bool
-sideband_msg_req_encode_decode(struct drm_dp_sideband_msg_req_body *in)
+static void dp_mst_sideband_msg_req_decode(struct kunit *test)
 {
+	const struct drm_dp_sideband_msg_req_body in =
+		param_to_dp_mst_sideband_msg_req_body(test->param_value);
 	struct drm_dp_sideband_msg_req_body *out;
-	struct drm_printer p = drm_err_printer(PREFIX_STR);
 	struct drm_dp_sideband_msg_tx *txmsg;
-	int i, ret;
-	bool result = true;
-
-	out = kzalloc(sizeof(*out), GFP_KERNEL);
-	if (!out)
-		return false;
-
-	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
-	if (!txmsg)
-		return false;
-
-	drm_dp_encode_sideband_req(in, txmsg);
-	ret = drm_dp_decode_sideband_req(txmsg, out);
-	if (ret < 0) {
-		drm_printf(&p, "Failed to decode sideband request: %d\n",
-			   ret);
-		result = false;
-		goto out;
-	}
+	int i;
 
-	if (!sideband_msg_req_equal(in, out)) {
-		drm_printf(&p, "Encode/decode failed, expected:\n");
-		drm_dp_dump_sideband_msg_req_body(in, 1, &p);
-		drm_printf(&p, "Got:\n");
-		drm_dp_dump_sideband_msg_req_body(out, 1, &p);
-		result = false;
-		goto out;
-	}
+	out = kunit_kzalloc(test, sizeof(*out), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, out);
 
-	switch (in->req_type) {
+	txmsg = kunit_kzalloc(test, sizeof(*txmsg), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, txmsg);
+
+	drm_dp_encode_sideband_req(&in, txmsg);
+	KUNIT_ASSERT_EQ(test, drm_dp_decode_sideband_req(txmsg, out), 0);
+
+	expect_sideband_msg_req_equal(test, &in, out);
+
+	switch (in.req_type) {
 	case DP_REMOTE_DPCD_WRITE:
 		kfree(out->u.dpcd_write.bytes);
 		break;
@@ -164,110 +220,210 @@ sideband_msg_req_encode_decode(struct drm_dp_sideband_msg_req_body *in)
 		kfree(out->u.i2c_write.bytes);
 		break;
 	}
-
-	/* Clear everything but the req_type for the input */
-	memset(&in->u, 0, sizeof(in->u));
-
-out:
-	kfree(out);
-	kfree(txmsg);
-	return result;
 }
 
-int igt_dp_mst_sideband_msg_req_decode(void *unused)
+static u8 data[] = { 0xff, 0x0, 0xdd };
+
+const struct drm_dp_sideband_msg_req_body
+random_dp_query_enc_client_id(const struct drm_dp_sideband_msg_req_body *in)
 {
-	struct drm_dp_sideband_msg_req_body in = { 0 };
-	u8 data[] = { 0xff, 0x0, 0xdd };
-	int i;
+	struct drm_dp_query_stream_enc_status enc_status = { };
 
-#define DO_TEST() FAIL_ON(!sideband_msg_req_encode_decode(&in))
-
-	in.req_type = DP_ENUM_PATH_RESOURCES;
-	in.u.port_num.port_number = 5;
-	DO_TEST();
-
-	in.req_type = DP_POWER_UP_PHY;
-	in.u.port_num.port_number = 5;
-	DO_TEST();
-
-	in.req_type = DP_POWER_DOWN_PHY;
-	in.u.port_num.port_number = 5;
-	DO_TEST();
-
-	in.req_type = DP_ALLOCATE_PAYLOAD;
-	in.u.allocate_payload.number_sdp_streams = 3;
-	for (i = 0; i < in.u.allocate_payload.number_sdp_streams; i++)
-		in.u.allocate_payload.sdp_stream_sink[i] = i + 1;
-	DO_TEST();
-	in.u.allocate_payload.port_number = 0xf;
-	DO_TEST();
-	in.u.allocate_payload.vcpi = 0x7f;
-	DO_TEST();
-	in.u.allocate_payload.pbn = U16_MAX;
-	DO_TEST();
-
-	in.req_type = DP_QUERY_PAYLOAD;
-	in.u.query_payload.port_number = 0xf;
-	DO_TEST();
-	in.u.query_payload.vcpi = 0x7f;
-	DO_TEST();
-
-	in.req_type = DP_REMOTE_DPCD_READ;
-	in.u.dpcd_read.port_number = 0xf;
-	DO_TEST();
-	in.u.dpcd_read.dpcd_address = 0xfedcb;
-	DO_TEST();
-	in.u.dpcd_read.num_bytes = U8_MAX;
-	DO_TEST();
-
-	in.req_type = DP_REMOTE_DPCD_WRITE;
-	in.u.dpcd_write.port_number = 0xf;
-	DO_TEST();
-	in.u.dpcd_write.dpcd_address = 0xfedcb;
-	DO_TEST();
-	in.u.dpcd_write.num_bytes = ARRAY_SIZE(data);
-	in.u.dpcd_write.bytes = data;
-	DO_TEST();
-
-	in.req_type = DP_REMOTE_I2C_READ;
-	in.u.i2c_read.port_number = 0xf;
-	DO_TEST();
-	in.u.i2c_read.read_i2c_device_id = 0x7f;
-	DO_TEST();
-	in.u.i2c_read.num_transactions = 3;
-	in.u.i2c_read.num_bytes_read = ARRAY_SIZE(data) * 3;
-	for (i = 0; i < in.u.i2c_read.num_transactions; i++) {
-		in.u.i2c_read.transactions[i].bytes = data;
-		in.u.i2c_read.transactions[i].num_bytes = ARRAY_SIZE(data);
-		in.u.i2c_read.transactions[i].i2c_dev_id = 0x7f & ~i;
-		in.u.i2c_read.transactions[i].i2c_transaction_delay = 0xf & ~i;
-	}
-	DO_TEST();
-
-	in.req_type = DP_REMOTE_I2C_WRITE;
-	in.u.i2c_write.port_number = 0xf;
-	DO_TEST();
-	in.u.i2c_write.write_i2c_device_id = 0x7f;
-	DO_TEST();
-	in.u.i2c_write.num_bytes = ARRAY_SIZE(data);
-	in.u.i2c_write.bytes = data;
-	DO_TEST();
-
-	in.req_type = DP_QUERY_STREAM_ENC_STATUS;
-	in.u.enc_status.stream_id = 1;
-	DO_TEST();
-	get_random_bytes(in.u.enc_status.client_id,
-			 sizeof(in.u.enc_status.client_id));
-	DO_TEST();
-	in.u.enc_status.stream_event = 3;
-	DO_TEST();
-	in.u.enc_status.valid_stream_event = 0;
-	DO_TEST();
-	in.u.enc_status.stream_behavior = 3;
-	DO_TEST();
-	in.u.enc_status.valid_stream_behavior = 1;
-	DO_TEST();
-
-#undef DO_TEST
-	return 0;
+	get_random_bytes(enc_status.client_id, sizeof(enc_status.client_id));
+
+	return (const struct drm_dp_sideband_msg_req_body) { .req_type = in->req_type,
+							     .u.enc_status = enc_status
+	};
 }
+
+static const struct dp_mst_sideband_msg_req_decode_test dp_msg_sideband_msg_req_decode_tests[] = {
+	{
+		.req = {
+			.req_type = DP_ENUM_PATH_RESOURCES,
+			.u.port_num.port_number = 5,
+		},
+	},
+	{
+		.req = {
+			.req_type = DP_POWER_UP_PHY,
+			.u.port_num.port_number = 5,
+		},
+	},
+	{
+		.req = {
+			.req_type = DP_POWER_DOWN_PHY,
+			.u.port_num.port_number = 5,
+		},
+	},
+	{
+		.req = {
+			.req_type = DP_ALLOCATE_PAYLOAD,
+			.u.allocate_payload.number_sdp_streams = 3,
+			.u.allocate_payload.sdp_stream_sink = { 1, 2, 3 },
+		},
+	},
+	{
+		.req = {
+			.req_type = DP_ALLOCATE_PAYLOAD,
+			.u.allocate_payload.port_number = 0xf,
+		},
+	},
+	{
+		.req = {
+			.req_type = DP_ALLOCATE_PAYLOAD,
+			.u.allocate_payload.vcpi = 0x7f,
+		},
+	},
+	{
+		.req = {
+			.req_type = DP_ALLOCATE_PAYLOAD,
+			.u.allocate_payload.pbn = U16_MAX,
+		},
+	},
+	{
+		.req = {
+			.req_type = DP_QUERY_PAYLOAD,
+			.u.query_payload.port_number = 0xf,
+		},
+	},
+	{
+		.req = {
+			.req_type = DP_QUERY_PAYLOAD,
+			.u.query_payload.vcpi = 0x7f,
+		},
+	},
+	{
+		.req = {
+			.req_type = DP_REMOTE_DPCD_READ,
+			.u.dpcd_read.port_number = 0xf,
+		},
+	},
+	{
+		.req = {
+			.req_type = DP_REMOTE_DPCD_READ,
+			.u.dpcd_read.dpcd_address = 0xfedcb,
+		},
+	},
+	{
+		.req = {
+			.req_type = DP_REMOTE_DPCD_READ,
+			.u.dpcd_read.num_bytes = U8_MAX,
+		},
+	},
+	{
+		.req = {
+			.req_type = DP_REMOTE_DPCD_WRITE,
+			.u.dpcd_write.port_number = 0xf,
+		},
+	},
+	{
+		.req = {
+			.req_type = DP_REMOTE_DPCD_WRITE,
+			.u.dpcd_write.dpcd_address = 0xfedcb,
+		},
+	},
+	{
+		.req = {
+			.req_type = DP_REMOTE_DPCD_WRITE,
+			.u.dpcd_write.num_bytes = ARRAY_SIZE(data),
+			.u.dpcd_write.bytes = data,
+		},
+	},
+	{
+		.req = {
+			.req_type = DP_REMOTE_I2C_READ,
+			.u.i2c_read.port_number = 0xf,
+		},
+	},
+	{
+		.req = {
+			.req_type = DP_REMOTE_I2C_READ,
+			.u.i2c_read.read_i2c_device_id = 0x7f,
+		},
+	},
+	{
+		.req = {
+			.req_type = DP_REMOTE_I2C_READ,
+			.u.i2c_read.num_transactions = 3,
+			.u.i2c_read.num_bytes_read = ARRAY_SIZE(data) * 3,
+			.u.i2c_read.transactions = {
+				{ .bytes = data, .num_bytes = ARRAY_SIZE(data),
+				  .i2c_dev_id = 0x7f, .i2c_transaction_delay = 0xf, },
+				{ .bytes = data, .num_bytes = ARRAY_SIZE(data),
+				  .i2c_dev_id = 0x7e, .i2c_transaction_delay = 0xe, },
+				{ .bytes = data, .num_bytes = ARRAY_SIZE(data),
+				  .i2c_dev_id = 0x7d, .i2c_transaction_delay = 0xd, },
+			},
+		},
+	},
+	{
+		.req = {
+			.req_type = DP_REMOTE_I2C_WRITE,
+			.u.i2c_write.port_number = 0xf,
+		},
+	},
+	{
+		.req = {
+			.req_type = DP_REMOTE_I2C_WRITE,
+			.u.i2c_write.write_i2c_device_id = 0x7f,
+		},
+	},
+	{
+		.req = {
+			.req_type = DP_REMOTE_I2C_WRITE,
+			.u.i2c_write.num_bytes = ARRAY_SIZE(data),
+			.u.i2c_write.bytes = data,
+		},
+	},
+	{
+		.req = {
+			.req_type = DP_QUERY_STREAM_ENC_STATUS,
+			.u.enc_status.stream_id = 1,
+		},
+	},
+	{
+		.req = {
+			.req_type = DP_QUERY_STREAM_ENC_STATUS,
+		},
+		.f = random_dp_query_enc_client_id,
+	},
+	{
+		.req = {
+			.req_type = DP_QUERY_STREAM_ENC_STATUS,
+			.u.enc_status.stream_event = 3,
+		},
+	},
+	{
+		.req = {
+			.req_type = DP_QUERY_STREAM_ENC_STATUS,
+			.u.enc_status.valid_stream_event = 0,
+		},
+	},
+	{
+		.req = {
+			.req_type = DP_QUERY_STREAM_ENC_STATUS,
+			.u.enc_status.stream_behavior = 3,
+		},
+	},
+	{
+		.req = {
+			.req_type = DP_QUERY_STREAM_ENC_STATUS,
+			.u.enc_status.valid_stream_behavior = 1,
+		},
+	},
+};
+
+KUNIT_ARRAY_PARAM(dp_mst_sideband_msg_req, dp_msg_sideband_msg_req_decode_tests, NULL);
+
+static struct kunit_case drm_dp_mst_helper_tests[] = {
+	KUNIT_CASE_PARAM(dp_mst_calc_pbn_mode, dp_mst_calc_pbn_mode_gen_params),
+	KUNIT_CASE_PARAM(dp_mst_sideband_msg_req_decode, dp_mst_sideband_msg_req_gen_params),
+	{}
+};
+
+static struct kunit_suite drm_dp_mst_helper_test_suite = {
+	.name = "drm_dp_mst_helper_tests",
+	.test_cases = drm_dp_mst_helper_tests,
+};
+
+kunit_test_suite(drm_dp_mst_helper_test_suite);
diff --git a/drivers/gpu/drm/selftests/test-drm_modeset_common.h b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
index 1501d99aee2f..c7cc5edc65f1 100644
--- a/drivers/gpu/drm/selftests/test-drm_modeset_common.h
+++ b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
@@ -20,7 +20,5 @@ int igt_drm_rect_clip_scaled_div_by_zero(void *ignored);
 int igt_drm_rect_clip_scaled_not_clipped(void *ignored);
 int igt_drm_rect_clip_scaled_clipped(void *ignored);
 int igt_drm_rect_clip_scaled_signed_vs_unsigned(void *ignored);
-int igt_dp_mst_calc_pbn_mode(void *ignored);
-int igt_dp_mst_sideband_msg_req_decode(void *ignored);
 
 #endif
-- 
2.34.1

