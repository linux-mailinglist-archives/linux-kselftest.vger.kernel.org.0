Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B770B7D0B87
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 11:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376552AbjJTJXC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 05:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376761AbjJTJWt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 05:22:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28F11726;
        Fri, 20 Oct 2023 02:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697793742; x=1729329742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=1m5rhtKzGFKo17wJSpmLAnTXQJF+wAV+CBZeDs8PfH4=;
  b=IB6xhURK1q2qJlzIEJdupchUUbAiJVr5MNdzeI9dg2enoU+zfEgNBD9K
   QuNP1Ab6SyeIyvXjEwKC0J1ENdrsCnWWPgJlEHoJ+scv0OBfyTfcvNvGZ
   PfDEEH83mT/eGrtRu6h+EZhFAxHPOWxi0MOQooAI1JvRYBxOsxRvG8jns
   hw2zePp5mciTV0lAnWDHgC/inb0VBza7WBpYA32D6qAUGM/nkzCrjyTzO
   XH205ehgqK9dINyH3p2HTyIyNHz2p9iM+8gvAxMh0TVQGDjYBjpWI1fm0
   KmxoKoobWeMqCyyFwTZhsbjxV0z6NXFttzXEf4IgQIxnwzC9p701MDcq5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="450690376"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="450690376"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:22:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="1088690975"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="1088690975"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 02:22:21 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 02:22:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 02:22:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 02:22:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b23UDiyjoOXtpJIjj50/IJwcCyT0EEexAiPY6oxNs8YOsfw5jyOp+spnlMmQKrJrQhSrv9Rc5GGH58MZKuVbE4iOkUB+zKNhOHcDdf/HBWsYEr8a0Mk55gbVkTkRzCU9WNK58FGy8umiU5miEcJW86WW/GV6N+RBPgeglZhNUWFRYkeus9WP3FqJwnDkyPem5ehNgkT4u9vDHsVbHVfTmjUSBbc5o87XCsYk4YHsSag1N61ZDjDmN9PSh8f5lSyINXqnTl5Ik0B6wy6AGJxIg4KMBwRuvZ3Uh+NGdUhkdrQkOjqiEIUed9rhZ1RP5Q1yQzLessJAn08sBpfdsOKgFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWHWOug2betCR+iG4WmIhP4k/VBkTB1sRifIfTpQJG4=;
 b=E5vtZcP5mnqBE0rh4qzZ3+werrf3PmXItlAkEAh8/F9ko0XYfzQX1h4thHrwJSm4+RsUJDmt0VHbf9d0n56EG9RP+oSukE5NPPFQwQ4JEI0l5mjP12iaHyotCMTYZlKuRvTSyxpIEsxdeQtvbZvgC0aIGNHJ9zLaD1KQRmMvdgZ8iZczhh+1y188db/awlLX+Xx3bTJvY/MCwxtVfADVRXWxJG49n/2t+kiymTUqf6CCR7dBKJkfQPYscreigXIorvUMzL+8PlZk1uAliR9Ec3wLS0DOzc5b0xm7DRJnBfyM6w8URbbxYk5e+VFxZcr14REgc2H3t3F6cmYQpJrlBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 PH8PR11MB6877.namprd11.prod.outlook.com (2603:10b6:510:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 09:22:15 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::cc5d:d2c9:b39a:3de7]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::cc5d:d2c9:b39a:3de7%3]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 09:22:15 +0000
From:   =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
To:     <llvm@lists.linux.dev>, <linux-um@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kselftest@vger.kernel.org>
CC:     Tom Rix <trix@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Richard Weinberger <richard@nod.at>,
        Jonathan Corbet <corbet@lwn.net>,
        "David Gow" <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
Subject: [PATCH 2/2] Documentation: kunit: Add clang UML coverage example
Date:   Fri, 20 Oct 2023 11:21:59 +0200
Message-ID: <20231020092159.2486063-3-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020092159.2486063-1-michal.winiarski@intel.com>
References: <20231020092159.2486063-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::13) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5373:EE_|PH8PR11MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a3d30d-4f25-4277-7e91-08dbd14e0c74
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xvy61vmBV0br+JEAmhc0/7T31+IpQjEb6zWbITG+gbqLfQq0Bvu8O+M8W0Vojax3arpkxDcrUuGufN3arELv5cSMwtXMEtzOCL9lv1MQvpQpOePXLSnlSKXtE0Cm5ocf2GS08TBIY3XPCJNFF9i9ylodgJl9vQhNdb4+f+FS3tap2H0x8Y80xYT2ooT1wsK3PdqH3Ys94NWES8Xdj84fdHOx0noV8F5pGW5hHBUqS+d13nPlZYwOXEB43wGN3khwX1tYEvJMZ0qLPmjG4vYbxq4LbdrU2wtuJnWXfQxkPMWXxBI9OXPbM+XoVbfs0BFXFv4z8CdorkM+Yk+i3kOKiy3EbDQwvJAsPil/wl6tpAjpFmBhHVWIq76ESmp7tZt/OPCJ3LTeRiogQE6F+c6Fmbj2VuVjXe427tGzWChB12ooQLpm2P4rXhS3OiC2+tefgXUtqH5o1VmV6pxj0dz2wvGmxOsqbo3B4hF8IwdSwM3qv2ZOfPoW3/dcW6QGHqWehuIgrB0HFtsxslBIFhLbYELwz5VnrHcSZDQDPbznA+eyXRopudQFe65Nr/2nLvA9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(2906002)(5660300002)(82960400001)(36756003)(86362001)(7416002)(26005)(478600001)(83380400001)(6506007)(6486002)(316002)(2616005)(1076003)(6512007)(8676002)(4326008)(107886003)(8936002)(41300700001)(6666004)(54906003)(66946007)(66556008)(66476007)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnYzWDBPSGx1NGVwSW1OSW1Hb1k1RkxKMXFIcldlbDQwWVNKaG1aV1MwaTZh?=
 =?utf-8?B?MjY0OUFWN1A1TEtkTzg4R3JiZVZPNld5QlN4NnQ1ektVaFBZaTJyRG8rUzlq?=
 =?utf-8?B?OE1oY1Q2cUlPYW1BUk1DWmg3UnZlYTIvUWkvSjN2S0Z3V1BSZDJoYUJ3eUNy?=
 =?utf-8?B?U2haRjVqSVhPMWtmalNkUkZ6bHYzNWJ3QWI1VGFsdUVVSTdHdEs0OXdnU2Fu?=
 =?utf-8?B?U251azZPTVRDcnF4Wms4VjJ5K3RudkZaYWxENlJqMkl0R2JNdnBJakcvM1Ny?=
 =?utf-8?B?WFpvVEYzbkhsSVgzN1BUM08rbmxHVzZhMS8rOTJRVytHN3VlN0h3cnR5V01n?=
 =?utf-8?B?VDkvZVBGUkhaV1pVZzlqanIyeVBGVGtmQjBoQjQ4VEwzcEVBMEZCSWtkdXpE?=
 =?utf-8?B?Sk8rRUkyRXNRb0tZZzN1K3JpbWUwcFJjSk9rSnczejV6TFV6UHdzYWJMSHov?=
 =?utf-8?B?Z0tlUzg2VFFIWlhxMVJmMG9BTnlxd2Q1TkVFeHFtWmNzcngrNldBVWE3TENB?=
 =?utf-8?B?NVpNQk5halhVcmNaT0pjU25QcUx2UUt1Y1JZcFZ4cUg5d2YxajRVZjF1cFR6?=
 =?utf-8?B?eGY1T2dlNzJUN1Zsbjl5SytqZmFrNXN4czVMR1JTdHIrZ3lEcDNud0VDcmJO?=
 =?utf-8?B?Q1ZaZElpY3B1RjR4QnVtYzJwcnNZdEdmeGxsT0pXNTB4aVFUMjVCd2hYOW1j?=
 =?utf-8?B?cVFHbEowbU1aeml1WllwckZBTVBaeXVuSTdGY3k1TUFHV1N2YWlUYlJGUVBs?=
 =?utf-8?B?RENaL2NSTmQ0cXBsTUNTWUhpeERlY2I3MXc0MUNNenM4T1ROZnBRZjJNaExG?=
 =?utf-8?B?TDZWanNqano3blQyWXByR1BsR1gxVlhnYzlhTSsxamRUdnc5ZGdGOVgzV0RC?=
 =?utf-8?B?dnpJSDVLMEVEdll4czlwcHgyZ1hwYXViMmU5OXExUWFobjV2eUpNVVMwQ1h1?=
 =?utf-8?B?UG9jYURvNXJMZnczWlZvZkZLUURKYWlMYi9GNUc5Zy81WmZJdEhJK3gwNndD?=
 =?utf-8?B?cEh5bkhKSHhNUUI1TkgvWCtSZ0wvRkNleE5IRzFESEg5UjdMSzJScHVlVEMw?=
 =?utf-8?B?NUhnODEyT2tHc2FyYzBtQ3FnT1RIV3pyYll4SUExakNjVGt5SlcrMDBJOXRE?=
 =?utf-8?B?eWprUXBMNTBCdk15S0pZbE01cFZxNTBmemM5bVF3eEkzemw4U0RkSzBINVZX?=
 =?utf-8?B?NVE4elZmZ3VmUUMyN3prMVd1c3lFWFZDK0VqRitmQTZNc0hMOWJlcDZMZzg1?=
 =?utf-8?B?MVk5ZTZtY09KOFQvQzhpSnpaVm53eU9MeVd1V2xYcDhra2hyYnNqUno0Umpl?=
 =?utf-8?B?NHZ2RVVlcFZnajMzbVVIdmxCK0g1SVRYY0xtU0IwL3NSM1ZnSENNb3hnWEdk?=
 =?utf-8?B?UmZVV0w4SnFjRndQL2dta01ESzlXWXg1N0FBTFBGa0ZCOW5LVXZtK0cxa2x2?=
 =?utf-8?B?SXBxbXFjejh2enN1WGV3UEFMTUJwOGFndHBib2FVOUlHVUd1M3dnOG5BN0tU?=
 =?utf-8?B?RzFoaWxnQ1F2bFJoam5DUlJLNjlwSjNhMkEyTGEwNXZnL05TRHJOSkh4YXB4?=
 =?utf-8?B?eGJKTWF0UzV4WE1FT1pJbzd2YVBWbWp1alY4OTFOSFBPanZISm40aWpVUk5C?=
 =?utf-8?B?eGRMcWRXa3lwYndEZGtpa0dZNnVQMXlHTjY4ZWxLSDlVQjNhVkVwbkNOeDFJ?=
 =?utf-8?B?dGxPa3l1ZVpabWhVRkZoeE5zNEJmYjBYOEdRdFl0U0FCQnFoWkF5YlJGdUdw?=
 =?utf-8?B?U1lnMWg5dzJudjVIQVBWNldsRE9mcThNYzNBMldUL1lycVFYUkVOWm5oaTNp?=
 =?utf-8?B?Si94VzJxanBpUktNVyt2cUxBYkdzOEVKUnlmZHpnRCtzT3BYTjdnTVVqbkpS?=
 =?utf-8?B?SExmTHJvZTZ4V3g2ZmVsdVVXUlFVNXAxeVF2RS94UzBZLzI1OEdoR1IvWENL?=
 =?utf-8?B?d0JuU25FTnJucE0ya0Z2ZkJDYmZwaGo2MTdka1dCcHZmWnVRTHZIcTRxbUJS?=
 =?utf-8?B?RVIvTnZWM0VrNkxESW40YjlneFlZVTAzZVh4akZNRDR4QU9XL3N0Rlo3N3dQ?=
 =?utf-8?B?cjNNTTdPRUZLQVMzTmJ0QURoUXVRakpVSDdpcHlwQXdxTVlpY042SHl5Y1Y2?=
 =?utf-8?B?QmdoZEtxNUI2Y3ZZSUdXZ2dxajRNN21pcmZDZHFFUkFGWXZsdnltSXpmNVRp?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a3d30d-4f25-4277-7e91-08dbd14e0c74
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 09:22:15.0725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJlSKd8oASG7LkW35fZmY9uK4NiH672ltyhIYqAWwnjTA8MDxRVwwIR1dZ/dFt8e4pLE18qqTOiIGI4stCI3Kk/NZ6z5/uugmcT/mrZ6+XQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6877
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

LLVM-based toolchain is using a different set of tools for coverage.
Add an example that produces output in lcov format.

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
---
 Documentation/dev-tools/kunit/running_tips.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
index 766f9cdea0fa..9f69c122dee7 100644
--- a/Documentation/dev-tools/kunit/running_tips.rst
+++ b/Documentation/dev-tools/kunit/running_tips.rst
@@ -139,6 +139,17 @@ If your installed version of gcc doesn't work, you can tweak the steps:
 	$ ./tools/testing/kunit/kunit.py run --make_options=CC=/usr/bin/gcc-6
 	$ lcov -t "my_kunit_tests" -o coverage.info -c -d .kunit/ --gcov-tool=/usr/bin/gcov-6
 
+Alternatively, LLVM-based toolchain can also be used:
+
+.. code-block:: bash
+
+	# Build with LLVM and append coverage options to the current config
+	$ $ ./tools/testing/kunit/kunit.py run --make_options LLVM=1 --kunitconfig=.kunit/ --kunitconfig=tools/testing/kunit/configs/coverage_uml.config
+	$ llvm-profdata merge -sparse default.profraw -o default.profdata
+	$ llvm-cov export --format=lcov .kunit/vmlinux -instr-profile default.profdata > coverage.info
+	# The coverage.info file is in lcov-compatible format and it can be used to e.g. generate HTML report
+	$ genhtml -o /tmp/coverage_html coverage.info
+
 
 Running tests manually
 ======================
-- 
2.42.0

