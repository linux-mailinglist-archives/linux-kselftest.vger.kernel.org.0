Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB3B48CF2A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jan 2022 00:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbiALXf3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jan 2022 18:35:29 -0500
Received: from mga06.intel.com ([134.134.136.31]:6218 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233599AbiALXf3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jan 2022 18:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642030529; x=1673566529;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=tUehmT/k35BVT1xNIxYVok58BAokD/oFwajRNvcwLdw=;
  b=iC/VN8wkgIP5slIWU3DJfryr56Rz4LeBMg+oYBDH3aY7kIzfjT+T/GgH
   5zBBkoDrMJKOEctRO6WDlIqXOYwF/gOdFdYIB2Xlco8HA8i/sk2CWp3zu
   4PlUpSgQW0LMT12BltXRhBitU1/lCizNV1qrVIquCDzhmLuIcCDxJUXAE
   AS5RDbW/v6Yu7WhZq/7V9hbhUXnMwhkIEzh4uE5yfq9GzEc/e3SZd35cs
   IEVyrpOQaD33WCCAndkk2xnZ9QQzRboclKBXxrveyc198MwPhfX+GNBQ+
   sH5+JwyNU6RZJBZcDwwfm5xTFfrAanLHdMdd508ovX7T4akejYtjfd67V
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="304612125"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="304612125"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:35:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="620398473"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jan 2022 15:35:28 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 12 Jan 2022 15:35:27 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 12 Jan 2022 15:35:27 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 12 Jan 2022 15:35:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYBI94RisELZTzh01R+yP8JFbR6VezMRQRUAtTG8B2CozH9cRbHR6Agt+BHlmmQSIGM1Q3DnHp8ROJwNOTLPGdFVsktiOCHQmsX7zeX4EIIS5pojtZQ80kfYrDlhQO8CYSKZiz2Sp2hseUuAPyDNT8APfdMpysPaJxr+X07UK+a9+edN3ciKnNrjqyKREZp5aseHsmsBZTg+gh7ksKcSUKabtphNpYgMQ12c2d8hWrBEXKd+i36DTUNTTiwK2p5PeWbQxXSmPHhET1jrTpInVmjllA5Cfuawa3vQ1AUGJVrMKRYZNL4aUWCvFfcPlmz6PsxI56is1gTvGUYi5qFqcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Nxteecxv8M6g6A354YJ2EUr1R0/tN9omuwcMMmOaCU=;
 b=d2pvq+wfMOj8zbepGkVXOQcM/L1+rJ17nrBbFxuBUiabpu5UVyhX82e2XEzkXi56k8eUkyig9QAOZWC3o7RO8FJdOnJeoGfdaaXI0aVPw+mJo/B8zKhq7Bn9yjCuAfJqhwltNaTJWxnuvstF1I2Pd1KGQs5feqZ6ENX2c1mM/e7KZTLaPRzHDAWL2ia8Of9AlcDbmJeRXvV8DkxCmla4PqdYLPJWSrW/82lvVWtxvUsseo69kGntlReppB8GyzZNPIVLH7yTzuJz2s/yoO8mLam0+s2EMypu9CVb/h6zDqtR5TiDRN+cR9fS08mmAqbAQ16DoZVhb3NH3Z9YMu+/kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 DM4PR11MB5248.namprd11.prod.outlook.com (2603:10b6:5:38b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.9; Wed, 12 Jan 2022 23:35:26 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::fc15:bd26:128a:f5f5]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::fc15:bd26:128a:f5f5%8]) with mapi id 15.20.4888.011; Wed, 12 Jan 2022
 23:35:26 +0000
From:   =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
To:     <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kunit-dev@googlegroups.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>
CC:     =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
Subject: [PATCH] kunit: tool: Import missing importlib.abc
Date:   Thu, 13 Jan 2022 00:36:57 +0100
Message-ID: <20220112233657.15886-1-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR04CA0051.eurprd04.prod.outlook.com
 (2603:10a6:20b:46a::25) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d126c340-c4c0-44b3-1e55-08d9d624361b
X-MS-TrafficTypeDiagnostic: DM4PR11MB5248:EE_
X-Microsoft-Antispam-PRVS: <DM4PR11MB5248A04484A989710B2392A498529@DM4PR11MB5248.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IM768MRrvWaXXf5nkv2fANVJA5Q9yT9qtJxkWKJJ4AjoV8s2mkmNUHXM51ZE3iwqZ+bskAfSwKmphvwIdo/+fYzqKOmy6QjarYi8NX78HmsRS1RXSXpP25BJlmvewpr1oasKUkGrbAPpy1mGXtz+Vy5XvFTeKHmPcHTns8frz4RD+9bMlgmyM+oLcZ95Blf6ytUxiFmpStkSLuFq+DvAFc/kwrP+/c2O8J38zPuskT7zsb+iDcWDyPIs7a3Fyb86VwpkuKeP/3xcGl3FPB6aoJiH2yGfsDbGY6Eb5GCoDY6lwH2mLQLaHu9H/6ehjVU8hrD84OZPfSQSBAVZJ0JMtMcbQehGwkavywJA40Fccj7TQRUneNHOPHnWH0DAdGMZt/LvGWye2Mg6rzrf3xVE0bn4BNdvILFvrHlET2TMzGsS9p34AK2qQrVR3ttWJD9bk6YKt5F6tOSN4JImdzhER6ZdIvDpzlI1mbbBMHsoBEk8ABz+MAcm+4J5Ql0DCzJE8lm8W5PI3GLxVu35vsn9CBd7e76AwcHGNSJ7ND02sOcf0PKGYbnGyuQpSfRQJHcQSSImjFf8x0gCXznbZxpe6KVTSnuIIS5HQPJ3t/8hcv5xjAXfNGzPKjKFW5KNOdll6IohdKxQofWkQXk4M7R8Fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(66556008)(107886003)(8676002)(38100700002)(26005)(66476007)(8936002)(66946007)(82960400001)(36756003)(6512007)(6486002)(6506007)(110136005)(2906002)(86362001)(5660300002)(6666004)(508600001)(316002)(1076003)(4744005)(2616005)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzZpWlhHeVdCaFMwR1pCcHpRRzUzWmR6TW5WVFN3SU9xZFErT2ZFcWRvRjRm?=
 =?utf-8?B?OUdRdWl2Wlp5L2M3T3dHUUkyajRNUFprTEMzS2VHUFdSaEJNZWt5L2NZSGRP?=
 =?utf-8?B?MWxpemJYWmxsRTEycURNd0xXZlBSM2g2M3lkNzZVYWRjVXNWTWtMd2tNMEpY?=
 =?utf-8?B?QU04RHJFaHVXRXdnQVFGYytxYVZFTWF0RGJhN1ZCaytJdkg2cWdoM0ZvTk8x?=
 =?utf-8?B?MThRRnEzb3dmTXQxOUd5T1NkUnpFQzdlT2dEd3c3TjJiUy9iYkNwMzdka3pU?=
 =?utf-8?B?aEhBVXRJQTBPcitDZ2ZxV3NCaUVzLzVOUmJxdFRBRGxZcHZVd1JoNWV2bUFR?=
 =?utf-8?B?YzI3SDJ4V21kckl5L2xDZll1RGtGQmJYYVRpbDRHWFhZTkc5S0tuQjF2bTJk?=
 =?utf-8?B?TjdySkIvbnVyd0NYQndXb1lIUXJkQjhUc2ZxdElmajJmMHA5WSt0RWJFS2tk?=
 =?utf-8?B?N0V5dmtIdHpSTW1FSmdxV0M3U045Z2VZMyt6UlVjOXFzL3dZb3N6d2dXa2Vy?=
 =?utf-8?B?d05oNGxRV0d6YmUwS05kd2xBWVNpTzlzakhaTkY2OHliNTdqTndLRTh3K2RZ?=
 =?utf-8?B?S2VyQ1BsTmE1NDdDcC91VGpLYzExdWNoTnZaRWxmVS9nbVlBVWVxcW1uV2F1?=
 =?utf-8?B?SnNrOVFDRkFyK2Jpbi9HZkFmc1U0U2xDZWc1N0ttOUJtVkVSNW1SQjB4bUZM?=
 =?utf-8?B?aHpNbmhhRzkxV3VjWWd2Z2UvTHZaeTZCTjgrRFM5cExYTG1rOWNybDhwemk0?=
 =?utf-8?B?L2swS2ExZE8vY3lFMGZ1U2hHSWdZL1BCY2ZpR2lFSE5rUHZyUFVKcUh0U3I1?=
 =?utf-8?B?VFlIdC8yZGFOZUJjQUd0enhmbm52Q0Z6QnlsN3NmVDBjVFIxbVpreXhqRDZX?=
 =?utf-8?B?aEpzcktTUjJENUlnRWJlcm1jOVN0ZGl2bG5FcDhzTzFnN3NDTDFkSVk1ZXc4?=
 =?utf-8?B?Tmk0YU1leVVvaEY3a24yZjBVWlQyTTRPOE51S2JSRlNGdllXL1QwdTN6cTcv?=
 =?utf-8?B?NVVGZHQxN3cvbHRPOTg1U2lDT2dYMGUxMW03RVFDeWptWE1YeFdHemN2Y0hp?=
 =?utf-8?B?SGFzOFZ0Y20vUlNYMDlTTHZZUU13Wi9BLzNzTG56cERjUDRkdXljMFNBWkVu?=
 =?utf-8?B?NVFiUEtPRjcwT25vRGdWWUsyQU16V25iQm9KZStycDBnRGU2ZHRsRVQ2dTNW?=
 =?utf-8?B?NGJHaUxacXhtek16ZzMrRDZRYWUydTZhTzZsQnFvZU51NmFhck5pR3ZGUllF?=
 =?utf-8?B?NkJEeTlTcGo3cDVRR3dXcWxvbHJQQnJYc3cwQmR1Tk5jZ1pzQndacUg1U1RR?=
 =?utf-8?B?Q0p3YkpDczhwRWgzRU50V01XODI3VzJYdnJsSnlGeTBWaXdtckRGZWxidU41?=
 =?utf-8?B?a05QNmFESmdKak5WaHNweWhVSk9UTVZUaUVZa08zbUFwTktjMzRiTnBCbUVP?=
 =?utf-8?B?cnB1Z3I0aFg1NWpUQWtGbC9lT1BKZzJnNkJEelpYd0RaRHpFc3hwdXRCWHhW?=
 =?utf-8?B?bHdlSnhkWVlYZXJDdDZ0ckROMlpTZ3RiOU56TS83NXJCa0lVR1I3ODNjM252?=
 =?utf-8?B?MFQ0clVxWU9aajc3TjhnNVNhYW1qRlVISzZsQUsxUlAxSHlkcEQyNzQvR3hr?=
 =?utf-8?B?RlZnZ3ZaMW8xY01idUVzOE1Da3VQUTdJeU90ODR0c2dpMHRXOEF1bUlrbEs1?=
 =?utf-8?B?YzVGTE5oMVNGZU5ucVdVbGlmSVNUMDlETHlZbVFFcEhxald0M3RIRW16MitF?=
 =?utf-8?B?VkJSdlVxNE9ydU9PUDM1d0kxYzVubU1pY0xoam5ZeXREU2pSdFlkekVDcXE1?=
 =?utf-8?B?OGtBcXBHUEZUOXdiZjJLMW5uc01BZVdQQmFsVy9hMXUrOG1lSmwrY29MUmNZ?=
 =?utf-8?B?MEpBRFAxWGNab1AwNHdXeWtocUZFc1g1MnlQOTBpYWU4VnU0bi9RWjh0dTJG?=
 =?utf-8?B?NkV4RWZ1R3RTRlZyaU40dmFRTWc5TWt5ZUdvMjJnZWpmaDVISGNPUXQwNmdu?=
 =?utf-8?B?YWdKYnlIbVRJVWdoODY3V1BJWW5BRDk2a0xjQTZZUUVnYUQvVVNVUDUyTzF4?=
 =?utf-8?B?cjZrNGRHMzlocFdJOUhpQlAxdnkva0lRNFI1RTI4TVYzdkgzQ1hNblB1dmUr?=
 =?utf-8?B?MVpkOURsNEQyZ21IUkpTaVpWQzVvc0tILzJNT0hXaTBRaTJwQjc5TFNuOXNG?=
 =?utf-8?B?SFRwRUVzVEM4N2tiajdUSmRHNWZhWlo0TDFlNlQ3cGZpN3ptN2hnQStnQUFX?=
 =?utf-8?Q?ODLeY183M6oJzpBoUEcdPawmy3CWOFeX4Wui7V3eUg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d126c340-c4c0-44b3-1e55-08d9d624361b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 23:35:26.6892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TcYdwJjJYEkJsmbcEmRuUzk7QXrVgo2le7LfZUpRneQSVA0KcnWXSmd/oAa2uVLP+9111MRfbpkJyJh0M+eohhqYlS5WSX0ohfJrS4oKwbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5248
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Python 3.10.0 contains:
9e09849d20 ("bpo-41006: importlib.util no longer imports typing (GH-20938)")

It causes importlib.util to no longer import importlib.abs, which leads
to the following error when trying to use kunit with qemu:
AttributeError: module 'importlib' has no attribute 'abc'. Did you mean: '_abc'?

Add the missing import.

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
---
 tools/testing/kunit/kunit_kernel.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 44bbe54f25f1..3c4196cef3ed 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -6,6 +6,7 @@
 # Author: Felix Guo <felixguoxiuping@gmail.com>
 # Author: Brendan Higgins <brendanhiggins@google.com>
 
+import importlib.abc
 import importlib.util
 import logging
 import subprocess
-- 
2.34.1

