Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825FB49125C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 00:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243803AbiAQXZK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jan 2022 18:25:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:48918 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243793AbiAQXZJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jan 2022 18:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642461909; x=1673997909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Jt8teGclXTWX5oTZQ7V9oXxpvPlu8NnFH5sJhhX0uEs=;
  b=E5MrGPXLLqadzmVf00aefn/N4owF6MmZc3dv6S+u3m8PSrAifPkIb8Bc
   aGqXF4d+q8idU4j6k0ZlvT/wjqUn+oNT1K84vvvSVdx+SxcU4Hv4/5cjd
   P3/MoumUeCkvoKsvuD9r/l4WHzUbrjA8gVeggKHP6JmLcC6cb3aqdCxQH
   knpT14cR/qbFD9u4gWyfJnxWvzfNIftLVqyMcPX4P5GtP/hPAY5gp+Y2P
   cYaKuThtrPIEmT2Vu2/Luje3ZqAwKJ/grau1v2gZURxanaQACXSajGLaQ
   4DnopcJQiHd5mEMJ4eIeuOBojfaR0OmGQMM1mhPqFALsMlDCbG8FBU5uv
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="308043748"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="308043748"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 15:25:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="625325455"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 17 Jan 2022 15:25:09 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 17 Jan 2022 15:25:09 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 17 Jan 2022 15:25:09 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 17 Jan 2022 15:25:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rnvaxf/Doxy9L1u0W781iICAJEGt5eI8LuDUCNG06T2ku6EHyFnFQBEhzjLQlRxApG+95izfMAawyFPsrYQfmdC8M3QpujzL5ZfmSTxDwwKO88M8IJ0B668AFeDwNlUgCLbewG3NG1/qH7nsMFv9rYhBMS7eZjZ7kOVybp1+UxnqEzf1Jpty6JGe4Zq0LpUh3cFCWRV9qDDqrzOZ1cImuYQhrzV4kYmRDeuWVxvW/yepLySU+jMiDzOKtM25/b7Fi/xdb++Bo0cDHa9TIA7w9fDHgI+wdQ8NIGbfJ/yc2KatK6CCRX6HYXnf87ekVNn+dCooysV6UeX1w9c9hLtO8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MX5FQiSWbnqIeMSJ7Sc8zY0Jc5rSneCC7mu/8gKVV4=;
 b=F56HfRTnoqxzTOE5fHtxwRLJ7szeiT/lCo/dFfXoqwM0CpTY6+PHaoH7RQ4SwsWriQQqAQbUSbNI0Yh1ph5umEs/zVJqzUYO4g3etwypwbNEbAMUmsmosAmfs5VD5RyQBCajIQ6AWx6pY2je/GBV6wii4CJrEm53LExpLTh/vDSUehJ45AUD8RJ8JJ3cb+2IK4wZVEMUXeWvDmoezM+cpen0T0/tzxhsHa3CtkA/tVGmMQ7aRfDgs+mELhoxs+Gbwgcj1M3OgtObTueZb6IRsVVsfJdCeyfskCwG2/lrMA3LXXc5ZKSjHiwujrqygGysw7oghgoMxerZJd4oJmqgWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 DM6PR11MB4140.namprd11.prod.outlook.com (2603:10b6:5:19f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Mon, 17 Jan 2022 23:25:05 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::fc15:bd26:128a:f5f5]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::fc15:bd26:128a:f5f5%8]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 23:25:05 +0000
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
Subject: [RFC 10/10] drm: test: Simplify testing on UML with kunit.py
Date:   Tue, 18 Jan 2022 00:22:59 +0100
Message-ID: <20220117232259.180459-11-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117232259.180459-1-michal.winiarski@intel.com>
References: <20220117232259.180459-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0377.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::22) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72fc8e1a-5aaa-4d55-bef9-08d9da1097ad
X-MS-TrafficTypeDiagnostic: DM6PR11MB4140:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB41408E310AD08AABBA028E7E98579@DM6PR11MB4140.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LvmuZM26OvJZY3g4MScEkibXR/nzOYE36E+kGt3s21iS+Pp2bw8j2TIOB98ejmjVwyAgEtaXieMw3Mt4rqyuQhoLOCeFQkUX7ltzdMhbmz4bJX+XIymILFPqkT16TQeltnQJMlJMMmdCVSMTaCehnItUiwmFaolm9kHOm9njq4wlCFk29y8/cPDHkiYEAfcA46hh+wsEswZVx1G+0DPH3hcmn+122MgZDRqZXsaXIrYF050AdyW0TstcLEOV9zIW8aYFq0ZnLoiQGlgvLwH9q/ZUGPuK5upuq0CP8dM1W4KAg1r+A4XoIvlcjSst4aI0oOvkNzr63DKASWwxrDzG65vTRv5TC9MmWARXvF7CZo5zY85LGTg+83jV8kELd3qAdy9qFuvKHzjqzC/2CXPlnVc8xiwroZT0zaGA5HFNEsbiw0prfZ4/K+L3VVUN+T9Y4dh/uVxipyq/QaEyuH40cclGCnkxD1lm95zcB4vKDEXDsw3/mvT/YhfMZ2hg8fukmoLmvUJEVgX7PE24kGnU5fVnuEGziwujyO93DKJreklJI38oIWrpUzgWX2TfISuJaOFQbnsySub3shsUPTnhx7TXib4FLCDcYmMDwvyWWcYqBrnL156E0RuV3e0iUe5tLupQkgR6fQhBWS2vvU0BUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(7416002)(186003)(6506007)(82960400001)(86362001)(8676002)(6512007)(6666004)(38100700002)(8936002)(66556008)(54906003)(5660300002)(2906002)(6486002)(316002)(36756003)(2616005)(66946007)(26005)(1076003)(4326008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3VISDJKNXRnOEcrQWhoaEs4TElRUnY0NzMxMDVIa3IvNFZnSnRwNGJZQWlO?=
 =?utf-8?B?TURaakxvbVpYMmlSSVBkMUZFRTEySkZiaTA2V05VMWp3YnZ2LzZMNnF2WmNG?=
 =?utf-8?B?YkhGVXpvZmJSUWxNdzEzbHFWZmNVeVYxeEtwYVk5d3RoUWVZUytiaXhMc3JO?=
 =?utf-8?B?dCt6cVQzNC9mSnNNNGZBd0xmRXNkOGQxbUhHL0h0V2xRRFpCK2dCMks5dHda?=
 =?utf-8?B?UEVNMkxDRThpVjJPVktKV2gzTWpTNDdiNEhYUmpZc1hZRklMRjdsazZtdzk0?=
 =?utf-8?B?Ni9kU0N3WmdiSVcyMjdZN2ZrM0VsYzFVeVNIR1pMZ2tlL3p5aVV2WEgxbjdC?=
 =?utf-8?B?b2lIRXN6Q3pSYnN2ZUZDdzM3dHdlWVJrR08xSVYvVUxwOHdLL3JQRDdyMzVl?=
 =?utf-8?B?dVdaNGEvZnU2WjJaUFkyQ3BvdW1vamVoSVN4S2MwS1FETWl1K0ZnQjNBZGFz?=
 =?utf-8?B?UlV0d1hyTVJhYXU1dnIxaWhrTTJTR0tCMjFCdXJDZkpVQUlXaVhaSS8ybEpV?=
 =?utf-8?B?cWRCK3A5c2xOTlpZbnhrL3N3UDE2eUt1WW41OHc5eUdDeDRJUHNjZTlCN3dL?=
 =?utf-8?B?VXRoYjFnMzhjajRkbXNJR2RaM3M3T1lXRTVKbnpkS1M3V2lGcnVIQ3loMWlp?=
 =?utf-8?B?cGZEb3ZSZDUyQXpKeE9hMkdRcGswU1pxTFkyV2wra2VxREg0VGw0V3g4K1hq?=
 =?utf-8?B?NlJ3SW1TV0RCdVF1Ym1KZ0ZFbjZ4QUMwRXkzekFEZ05WVFlCeXpzQ2tGaXJk?=
 =?utf-8?B?UThSOGh3WGVnd1Z0a1I1Nkl6aXhNcU1HRGVyT3o3YW1naVNLUWMwT0JaQXV4?=
 =?utf-8?B?d0MxRUNxWXdQYUpEam1QR0NrRTJRUkVLVWVIV3lVNzRCdzF2NmNhUnFHNnIx?=
 =?utf-8?B?S3BHWTE0UEIwUWh1aE1EQklDT3g1YzRPTlRrMkRtMVBlSGFyU3N1Y3dOcXZJ?=
 =?utf-8?B?UkExMjd0bmh3YkkraTBhSWJqNWduMy9BOGxscUh2TVJ5clZ3RDNzV2ZFazJm?=
 =?utf-8?B?ak0yWnJJRStrZU5FL0t3K3BXdjQvMmR6NFgvV2lNVnlRM1JaSWJkVHc4YzVD?=
 =?utf-8?B?VUVybXZka1JoUmRhTTB3VkdVS04xT1BKdXFiVUhhQ1crTkVEK05YaTZSeUt3?=
 =?utf-8?B?ODdPOVNDWGNOZ0RpWGVuRkhiYXFZL2JhdkZYdGhEZEdXNjU2VWVjbjcwVlZu?=
 =?utf-8?B?TmF0NC9EQVFKWWRvK3JqRVVFVk1ROHp6SGRUaGY2djk4bVNhOFhWaG0rK1Ns?=
 =?utf-8?B?ZDZwL1FyS2NLbWIwQ0ZETUJGdHlIN1NEZWQwZkxLalZEbTducmRQakVnbVgw?=
 =?utf-8?B?eFFZMi9hcm9PU2wrejcrVG1SQUJCYm12cVNZVEZaN0MyY3Vka0J1aXlPUHA0?=
 =?utf-8?B?Q0RBTUhROEFFek12OTZVdm5HR0JkU1hOS0lzQlRKMDluUDRNanVjWEY5eXNn?=
 =?utf-8?B?cVNUcGJlTFl6OFVYNVpib0FuQnd4RWhxTXpjdFVSZHQ0bS9IenVqRFgxWS9D?=
 =?utf-8?B?OTNqU3UyL05mbnBEOTNlbnZWREpQMkhDMHNFditoYTdZdHoyNzQ2SS9xcUg5?=
 =?utf-8?B?c0Z2WkFxSVNaamNQRzFLcEU0YXVaYTBMakJIMUtNbnhQVHkrR2JYdlpMZnAr?=
 =?utf-8?B?UGF0SzlaZytUSVJaUnZNQ3RTc3pSbXpETk53czdxSUMyNVIzb0k0WGNVdzRi?=
 =?utf-8?B?djFaWWFBaFM1VFdtaWhBRVRpcUZTRkpXLzJsMjYvb0Nzd25kMk1FSllucGx2?=
 =?utf-8?B?dU9CYmxiYmw5MUEwdjZvcDkrbS9HUnp5MVN5UjdzTHlRN1lsUlpXMEhKQXMy?=
 =?utf-8?B?WS9hYldqYTdJUmNQd2QzNG9LSTNKV0UwYTJnY1Vla1JWU0w3TEN4dy9qVnpH?=
 =?utf-8?B?RmdYMkxzRE85cnZldW5leE83Q3VsbTdSWE5ibTU0VGZ4emE1RzA5RXBwVTE4?=
 =?utf-8?B?bVpFQk9DclVxcWF2bzFUYnEvcjFOZTIrMFBqZ2VzZCtub0RXZ3IzVmRVOWl0?=
 =?utf-8?B?YnZ4RUZIamJCalZMMEozeE82ZWxoNHkrWDBRVEZock1RN0NzS3ZkREtxVGJ4?=
 =?utf-8?B?b09XN0lXQlBiNzJUSDBJbWpqS1dJUFhXZUlobFFMZkViRmtuS3duRTBPbkZ1?=
 =?utf-8?B?QnVUREUzWExTalcvS0h5VE9QV2dvZDZMZWxGOFJGVHN2NjFSL0tMdUNGbUhL?=
 =?utf-8?B?UUswRUNiNWo3U1BXeEVWL3Nxa3g2b1ljM1JLdGVHL0YvN0dySklwSWVZVTVy?=
 =?utf-8?Q?fJThWhJLXOdGvnZSxZ+spAEbFK3S1A54uC49pF58yQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fc8e1a-5aaa-4d55-bef9-08d9da1097ad
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 23:25:05.0431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dP/dmuA+t0eUJZ723cqyePaB+n36W7J89FkvDgMpg6GrAMx+VNiqru2xA+wTmgWqdS0I1Fi02pXBvMCS2TZurtFIMthXGLYZTkJV3Zai0nU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4140
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DRM depends on IOMEM and DMA, introduce an additional Kconfig to pull in
IOMEM and DMA emulation on UML.
Also, add .kunitconfig to simplify running DRM tests with:
./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
---
 drivers/gpu/drm/.kunitconfig | 3 +++
 drivers/video/Kconfig        | 4 ++++
 2 files changed, 7 insertions(+)
 create mode 100644 drivers/gpu/drm/.kunitconfig

diff --git a/drivers/gpu/drm/.kunitconfig b/drivers/gpu/drm/.kunitconfig
new file mode 100644
index 000000000000..6ec04b4c979d
--- /dev/null
+++ b/drivers/gpu/drm/.kunitconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_DRM=y
+CONFIG_DRM_KUNIT_TEST=y
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 427a993c7f57..0e6028f9b09e 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -46,5 +46,9 @@ if FB || SGI_NEWPORT_CONSOLE
 
 endif
 
+config DRM_UML_IO_EMULATION
+	def_bool y if UML && KUNIT
+	select UML_DMA_EMULATION
+	select UML_IOMEM_EMULATION
 
 endmenu
-- 
2.34.1

