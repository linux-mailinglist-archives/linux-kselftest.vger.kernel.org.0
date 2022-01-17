Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC05491246
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 00:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbiAQXYB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jan 2022 18:24:01 -0500
Received: from mga06.intel.com ([134.134.136.31]:23325 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235370AbiAQXYB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jan 2022 18:24:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642461841; x=1673997841;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=+LuqyvzIVWbDrsQgB4b1R5PvMixjLTJt5tRX3TTFcH0=;
  b=frBcWFQLm52jje9oxYjq8J697MYfo0MYT/TlYZS/jT+o9uuFVdiOZbS1
   uQgj9mGvJZx6ye8S9muB9JWL82bcjeC1cc3yKxNPgHT4LyHRYcmj74a6V
   K8/R+0fqDi6c5Fbg1UARtXDIumXLe2n+H0FT42aOLmfjfrKkHNl+QXpIn
   xxhqsurQHbvZMPvv3AWKbE6eUkawFgnxvSIhTPj7lA/kMIqRMj2mrsqol
   UGkiZyAIyeWRVYE++VRIZ2cKJCpZXzB/oVOFo1tQ6RbJAiiZsuM8W0Kil
   rz0NGy5kgth08WYPV56KKBQWmPTASrvEhmotBSFRkTFQQwwV2tRBZfUCd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="305438151"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="305438151"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 15:24:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="474580596"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 17 Jan 2022 15:24:00 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 17 Jan 2022 15:24:00 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 17 Jan 2022 15:24:00 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 17 Jan 2022 15:23:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPAO+birnV8arpjMF9/LrAwJwp8Bwq9t+H73wfrRSJrWVTk26h1Q91YkQ7Xv8qJwvUfbfRS+avjG6BAmp/z0EL56W7Zn1gz4tbmcXRBrJ//Ybpq8/USBWtQGrlp+Pc38YOmCwLsAeAhyjmca4ym9oEEQJqWxR+QTV5BnVZoVDRwNUHYHDZrv1ggZtcGGppDv5peWWnlA1NlFErYlQnn7QOYOZwAgUkOOaupL90gECRTh06yt+SZcf6fM/AEhhrFm6YbXE9GnZXmNIURXg9MKw4UJD0dVuVMp7XB3Lpe76y3hnonVjbUyKNsw0Mo1IZWuO20XqYDm5ysobiIFzBBa+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHOexDPOdH8SjgVToC8z7hwLPHJKkf2LtkbbNxWMql0=;
 b=eYulv1mAITGMUKd8KcAHO+amTeWKlaS2q1xXw6+4HGJPDA1TYkij41FKoldm1dKr3V4c2Cm3Wz2anx9QQ0fF9y8F36zZ1MPM0DGXueZo9a5lvqLsJUWX1Nm63Z3de9ld576bkbXqiEw8US8lD+G8/HpxzOoUbw3H4Ham+NzKPFSRCLttDlZ8iqwQaTbQ1QuhJdQNnkDNxvOxy/xbBM6qBbW8Pnur0l4t5StFISCAtZBLryWu+pY8BuHjjVQ6z+jMdK70t1LfKeKzFTmcFW5i6w61apUX0s7ThjMTbxKPwt2gBl+eWJ9hrJkoOpGZexB2/AmMA7UTOI9zsLBEp4TXWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 DM6PR11MB4140.namprd11.prod.outlook.com (2603:10b6:5:19f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Mon, 17 Jan 2022 23:23:54 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::fc15:bd26:128a:f5f5]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::fc15:bd26:128a:f5f5%8]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 23:23:54 +0000
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
Subject: [RFC 00/10] drm: selftests: Convert to KUnit
Date:   Tue, 18 Jan 2022 00:22:49 +0100
Message-ID: <20220117232259.180459-1-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0432.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::23) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e178c91-da1e-4596-58d2-08d9da106dc3
X-MS-TrafficTypeDiagnostic: DM6PR11MB4140:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB41406AF9D4548FE0C890B52898579@DM6PR11MB4140.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46EULeB1aEjhxxZVyHCB7/TfIc2MfeOPJwwxdpYipLCyUsCsGUDUULIdYoxSTwlFtvwhVCkc8ZX/ujkDLxtzvgtvNjHHGgImPT5dXZGpakpXFik8T4iGh2Fjcq7+GSihOhXEhaUgNT9rFh/3PxkWRLm2aJS3P6OajxlZcKII8p0D9w7+jkMCgZEHqZB8HQvraJnOKjZOi/QQTlYNV/RNLmLbnjDSNA9BW7a2kM36iHMowoikSBHd90HpgcZhtp9WrkvTdrGVu7z7rlo/Y48W9pjt6FP01w7IbilEkED0pZkFimZ5bbATqVDKuWR8QUVuU8QCJoIBFuN/WcBcguM51JhEccHmqt6Lw2x55QF7dTjoxjcZM5E/c8TK3f2RseyN2kH/ArtQku+iCAivKa028Bv+30vynoougJ83eXqj1+/GHRaQLgFmIVY3teu9Vcd8erloD5TB5yqaDpyQKt7s6P6gCLHf+s/I6549VZKU7v+sT5S/ZwNy8QDuHiaUqEuysYyVpt8FrToDCHVb0Kp+hXNtLl3nT/pEdK1bor8xD2fL7NiJOkOaFjufpnLVmM38KioexQDCYnn3rAOxAvCH89TU533ZS8JQI58QMpgYk93rCrojAWI0UQWETQ6GguPvQxvLbCyCzqW3iEKyN8R8mA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(7416002)(186003)(6506007)(966005)(82960400001)(86362001)(8676002)(6512007)(6666004)(83380400001)(38100700002)(8936002)(66556008)(54906003)(5660300002)(2906002)(6486002)(316002)(36756003)(2616005)(66946007)(26005)(1076003)(4326008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGp3SDB3V3Vua0ZGaEw5b2h3NllraXVQeDcwUDJTWE5tREJyMzhXL3JJK3Av?=
 =?utf-8?B?TU5pMHNPRnIzaXJBOGt3SnZlMHVUUk1RL2hKYWZTNFF4djN2M2R2RmtDNWEx?=
 =?utf-8?B?SnJtQWNtcStWTWMxTTM3V2s0T2tyMHFBaitpU3Y1Q2JNWjk2NURGWURsR0t5?=
 =?utf-8?B?Si9rQVVyakt0d1dCMSt3UXk1akF4VHZhMmU2SGhQQm1JZVZwUG03bUl3NEFv?=
 =?utf-8?B?UWY3UEIwYktsQkVZMHF2UFl0bzZMcGlFZFc5T2xXVDExVFZoYUkvam9YRTdB?=
 =?utf-8?B?dWozSEl2b1NYMnoyYU9LWDZvQXRqb2tVM25RdlEvZ3B2WHJTb2w0Qjc3QUFI?=
 =?utf-8?B?SWI0S2cwbXdUazlNOWhsMy9oVFY5VjlPVVR6cHZ5bWF0KzBhVmJ2d0ZJc3RM?=
 =?utf-8?B?emhTNGFhM1E1MVVMU3Zzbmo3ckREWjFpSGpNaHhWdUJZTnBVRnBUYzNIQTRB?=
 =?utf-8?B?OVphbm5OZ0p1Y3AyVG4wL0NRWldMRUcrOGV1V28vZjBxWGtrY0ZPS1pWUkhE?=
 =?utf-8?B?RlQrdFAvMzAvYVQvQ1IxQmVTdGp2cWVGMGZ3Qk1sQ1ZnVDBPdCs5S254SFY5?=
 =?utf-8?B?ZGhjeDFLY01YdWhiZ3RhOXliTHNQQ29Wa3Y4QTJLYTNtVExYM0xlN0Zuc2Vw?=
 =?utf-8?B?aHMvL2dLSTczaVM1V2VkaVFzcFQwUnJOSzlRSE95TTRiUy9mU1dnRHN6a3N4?=
 =?utf-8?B?dW51TU9Va3hIMzk2M3AxQ2paM1pxQ0syN3UzMEtMK1pERUt4QWVRZVVuZVJI?=
 =?utf-8?B?Z1E0ZDR2T0E4WFZiSEEwVDJoRTJpNmgrZzFBWC9CUG5iem1uWDdXa29qL00w?=
 =?utf-8?B?UE41TWxRSmRFcWFNbE9YcHpMTkJ2VVF0UTlKYUFGL1NjYXhZYi9hckpSNXpx?=
 =?utf-8?B?RDJDTXpjWEFkQ3Jmd3ZJbURBRzhGQjBSU1RLcUtXVGpuM2JXekVGcmQydjEw?=
 =?utf-8?B?aXNBbjdaN01lRW0zQmVYUHlyK3pZZGVmL0Z2L20wRlBFUDJ2NGNLY1FrdzhI?=
 =?utf-8?B?VUEwMTJGU2hPR0k0QXJBMFJnMmFMQVZ3VmZFdldaL0RGaUMvQWRHU2VUdnQ4?=
 =?utf-8?B?bTBZbnc1TC84U0FEUFc3YTNIWXNYS01URC83eDE4c2x6K0crYmpXNFdoSkw0?=
 =?utf-8?B?SUhsZzhRRjk3YjFPUENZSWNKaDlWZWFMMnFQU2ZjYlR1dXpWUVZIRXdpQW51?=
 =?utf-8?B?Qmd1bnJONnc3K1g3T1dlT1BvNDl1SlpPeUYreVFMdTVXNW94N3ZicXZPbk1R?=
 =?utf-8?B?TTB6R1c0OGQ5RWRHL20vNFFwU0xWcmp0NGFXZGVxSE5SNTJaRGdLU2lscFRt?=
 =?utf-8?B?bHpVenFyR0xoRzJnNjZWaHAvNDdCbXJUWkwrTlRrT0UyUUFEenBrRTlKL1N0?=
 =?utf-8?B?VS9sbUNVTVM1bzRtVmc5Z2NBaFpBWkRRUU40MXJvL01OdktsK25RNXNIUnhM?=
 =?utf-8?B?eVhDOVBXMTdHa1U0SnB3OUo0YkdqVnZGemJtRERYS284MFpqYXd1N2dxejM4?=
 =?utf-8?B?cEVoTTZoTTBSbmd5VTczclRWdktNK1dKTElsRUxLTE5sVVFPQVk5a3Bub2Rr?=
 =?utf-8?B?Mmp2cFpPVnJTOFFvaWkzQmViOVZKRzU4c0JmL09XSEFCdFRxR0tIOVNFcTZJ?=
 =?utf-8?B?MUhoamlVajA0RU5majhidFNhOVJ1cjhJdVppV0gwT1FKYVBIV0hlcmVTbHA4?=
 =?utf-8?B?VTVEZU1oU0RSc0U0eTNiYW5tdmZsNHI3T0kxa3NxWkhVa04ramx1Y2o5MHNL?=
 =?utf-8?B?a1NhMEwwaDYyMUFwKzlQbjgvMnZiam5Ga3FOdzUyT3Z4V0RCUmRtMFpSRUlX?=
 =?utf-8?B?NmlmM3ZIRXhXOFN6VzVmRkp4dDB3bmJBK0lpTkNPMFN2bkhjVXZNT2lMOFdl?=
 =?utf-8?B?SzJ5dWRuT0VVT2xSVmRvbVRXWEVOTTFPRzFhS0pvaWlTSkdYd0pid0hFaTIy?=
 =?utf-8?B?RXBsMDRheGhnOW5LcStkT1dEWGZXTlpLWVg3anRhNmZ4RGpwRnRSVm1YSVFN?=
 =?utf-8?B?bDcwMnlRT0JUbGtrN2lGNktKd3BoeS9LRjN3MFNqUC9pSHVmaEY4VnJLRXRT?=
 =?utf-8?B?cUFpZnFaYmRzRXNoUlB3c0tEbnkvNSsyZnVvQXhIZS9wclM2M3hFZkV0U2l4?=
 =?utf-8?B?Rk1yci9WZnlMY1ZKZUQwMGpQM21BM3pmblk0V2RWM0tsZHArNzZxdm45U3Vz?=
 =?utf-8?B?ZXdMeWFSZTBWWnVZU012L2doNGFlMHNRR1RvUnFUeEtGN2NBVDNreEY4c0h6?=
 =?utf-8?B?YW5XUXVDMkNMSEFZZWtsUVkvZC93PT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e178c91-da1e-4596-58d2-08d9da106dc3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 23:23:54.7048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0ylaHLBBxQmk8j33N8IOgrP39XPFyouaU4zn4aq9n3eEOr/qrUXi31PW/CImoRyT5a7/W63dWiyMkhkohcrcSMustAF8Zn20e3vrKsWfC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4140
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KUnit unifies the test structure and provides helper tools that simplify
the development. Basic use case allows running tests as regular processes,
leveraging User Mode Linux.
For example, to execute all DRM unit tests:
./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm
(the tool also allows using QEMU instead of UML by adding e.g. --arch=x86_64)

For developers - it means that it's easier to run unit tests on the development
machine, tightening the feedback loop. When using UML, it also simplifies using
gdb for debug (since the kernel is just a regular process).
For CI systems - DRM tests can be moved from being executed on device under
test (that's also running IGTs and so on) to being executed on buildsystem
during build (just like checkpatch.pl).

All tests were renamed - IGT prefix is no longer used.

Compared to selftests executed by CI using IGT, there's one functional
regression - KUnit test runner is not catching WARNs.
To solve this, we could either go in the similar direction that UBSAN went in:
1195505 ("kunit: ubsan integration")
Or we could expand the test runner to catch WARN signature in dmesg.

Pastebin to preview the output and execution times:
https://gitlab.freedesktop.org/-/snippets/4139

-Michał

Michał Winiarski (10):
  drm: test-drm_cmdline_parser: Convert to KUnit
  drm: test-drm_plane_helper: Convert to KUnit
  drm: test-drm_format: Convert to KUnit
  drm: test-drm_framebuffer: Convert to KUnit
  drm: test-drm_damage_helper: Convert to KUnit
  drm: test-drm_dp_mst_helper: Convert to KUnit
  drm: test-drm_rect: Convert to KUnit
  drm: test-drm_mm: Convert to KUnit
  drm: selftests: Convert to KUnit
  drm: test: Simplify testing on UML with kunit.py

 drivers/gpu/drm/.kunitconfig                  |    3 +
 drivers/gpu/drm/Kconfig                       |   22 +-
 drivers/gpu/drm/Makefile                      |    2 +-
 drivers/gpu/drm/i915/Kconfig.debug            |    1 -
 drivers/gpu/drm/selftests/Makefile            |    7 -
 .../gpu/drm/selftests/drm_cmdline_selftests.h |   68 -
 drivers/gpu/drm/selftests/drm_mm_selftests.h  |   28 -
 .../gpu/drm/selftests/drm_modeset_selftests.h |   40 -
 drivers/gpu/drm/selftests/drm_selftest.c      |  109 -
 drivers/gpu/drm/selftests/drm_selftest.h      |   41 -
 .../drm/selftests/test-drm_cmdline_parser.c   | 1141 --------
 .../drm/selftests/test-drm_damage_helper.c    |  667 -----
 .../drm/selftests/test-drm_dp_mst_helper.c    |  273 --
 drivers/gpu/drm/selftests/test-drm_format.c   |  280 --
 drivers/gpu/drm/selftests/test-drm_mm.c       | 2487 -----------------
 .../drm/selftests/test-drm_modeset_common.c   |   32 -
 .../drm/selftests/test-drm_modeset_common.h   |   52 -
 .../gpu/drm/selftests/test-drm_plane_helper.c |  223 --
 drivers/gpu/drm/selftests/test-drm_rect.c     |  223 --
 drivers/gpu/drm/test/Makefile                 |    7 +
 .../gpu/drm/test/test-drm_cmdline_parser.c    | 1027 +++++++
 drivers/gpu/drm/test/test-drm_damage_helper.c |  667 +++++
 drivers/gpu/drm/test/test-drm_dp_mst_helper.c |  429 +++
 drivers/gpu/drm/test/test-drm_format.c        |  356 +++
 .../test-drm_framebuffer.c                    |  109 +-
 drivers/gpu/drm/test/test-drm_mm.c            | 2426 ++++++++++++++++
 drivers/gpu/drm/test/test-drm_plane_helper.c  |  312 +++
 drivers/gpu/drm/test/test-drm_rect.c          |  249 ++
 drivers/video/Kconfig                         |    4 +
 29 files changed, 5558 insertions(+), 5727 deletions(-)
 create mode 100644 drivers/gpu/drm/.kunitconfig
 delete mode 100644 drivers/gpu/drm/selftests/Makefile
 delete mode 100644 drivers/gpu/drm/selftests/drm_cmdline_selftests.h
 delete mode 100644 drivers/gpu/drm/selftests/drm_mm_selftests.h
 delete mode 100644 drivers/gpu/drm/selftests/drm_modeset_selftests.h
 delete mode 100644 drivers/gpu/drm/selftests/drm_selftest.c
 delete mode 100644 drivers/gpu/drm/selftests/drm_selftest.h
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_cmdline_parser.c
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_damage_helper.c
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_format.c
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_mm.c
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_modeset_common.c
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_modeset_common.h
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_plane_helper.c
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_rect.c
 create mode 100644 drivers/gpu/drm/test/Makefile
 create mode 100644 drivers/gpu/drm/test/test-drm_cmdline_parser.c
 create mode 100644 drivers/gpu/drm/test/test-drm_damage_helper.c
 create mode 100644 drivers/gpu/drm/test/test-drm_dp_mst_helper.c
 create mode 100644 drivers/gpu/drm/test/test-drm_format.c
 rename drivers/gpu/drm/{selftests => test}/test-drm_framebuffer.c (91%)
 create mode 100644 drivers/gpu/drm/test/test-drm_mm.c
 create mode 100644 drivers/gpu/drm/test/test-drm_plane_helper.c
 create mode 100644 drivers/gpu/drm/test/test-drm_rect.c

-- 
2.34.1

