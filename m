Return-Path: <linux-kselftest+bounces-10664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315F78CE40F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 12:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D44C1C21620
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 10:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6B385931;
	Fri, 24 May 2024 10:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eUB9klHo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C768985936;
	Fri, 24 May 2024 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545698; cv=fail; b=hQ0Nqzm6kgVixTTqkKRiX3qiEO/FimHBf43AQHNTZJhnmQ24KfGLWT1Mj8Q7VQcWMTWCB4zL7P7yurxNmhF4VKUg7Kst0ELUD25u1Y1dZQ7Y5hmYu8JuI65qPAv1+t0fBSHnagN5qJ7HGLp2sF58xXmaEp2x6Q5y96nJ7FAbwyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545698; c=relaxed/simple;
	bh=+r7MznVugleUz6KEp136UUq7JkJGOhRvu9/UEOkb0bY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ONlThwlK47wTPEf8FNeN012K5jIYsVkf1+xGGNzuM8zmHcniYF2HeIPcWoc2eBCTy5cY4BIBE+vTmpWORNJNva4KxBjQrqOYz1w1TqHqL9xu1YwQqyD1SRhdUK8n25dbJezsxnn5t4u5N4kLCv0YFy9py6MgIpcUCTausCZCmqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eUB9klHo; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716545697; x=1748081697;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+r7MznVugleUz6KEp136UUq7JkJGOhRvu9/UEOkb0bY=;
  b=eUB9klHo+Avlct7A+sfmVLlatkN4YGOF9b0BUetLCJrLIhfqeF2U4QgV
   16pTdKq/AnQ5MkFxuBrLNRBagSZkWGcf7wgXGKj9+S94uu686jOx5VBck
   c1JAizrR5WVwN6DnF5l3quwHTBlLYKQcZl1G/91Kh4acnGwwQlWqTC3Xa
   VVqsB3lyhOhK4jW+XbRbgHXLjJLuBfgzRVGmh7j3398ed+xqm3fWbUdJX
   eMSa0brsM5/TF0Jb0W26hD9scFJenLW0UynpI58NPQLUNcOXOsIDwF6hd
   dXCjPcpYkFAbXEMw/Q53wDceIqoVT8L0SzGt30QCxhYGLin7iVq3hZm8n
   A==;
X-CSE-ConnectionGUID: FjdPrVxpRdOAquPOUclliQ==
X-CSE-MsgGUID: 3sGUmHQBSqyT5qimzWfyyg==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="23524587"
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="23524587"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 03:14:55 -0700
X-CSE-ConnectionGUID: vBVWMPSnTq+rrh7Lc7ql1w==
X-CSE-MsgGUID: Z+x7soISSqOxm1g58Nn9ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="34069614"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 May 2024 03:14:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 May 2024 03:14:54 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 May 2024 03:14:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 24 May 2024 03:14:53 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 03:14:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIIlyAWoD93ZG40KIH99YqMapJ+PrysNamq8JAnGwxR6idUNJ1DrW0kn+wn/W3SRrZAvzDbfCxDceiYcpqayLeQMI79uxeNvK1nvM65kvnm5lU0EahuJ+XuaYyCVaQ4kkpOil47ZC5StaAEEIQh3d0zGsaP7ZW58ZwMVy4sAvGxIRSLjm649KBzQ6IK/7PXFLzYvHHBYUEpHnBET170TeUqLv8gnuNVNEx3wwrxLmcaOqEJ1G4yLUZfSeC/UU7wcQ1/snJa1qbLqZj5LzLuWWZ0lMGysFX6JDTR8dmum/w9thtYMaJnyQvRc+OVekOJSD+6m1Dnw0BdRgyyqZcHd/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAK0Iw8E3Bk5kdz2PNnz42/yXzVNJxvY0uDsJW8Ut+I=;
 b=RGOYJ/1vFc0uXlAedbNTmu5u0BCVxoy7t7gyDWZ6QqjxF8na5xnfaet4E3wxk0RD7yy78K+rO7wExe5ImzOIEG9K9nnu14jZ0Pg7/U5zvEYphK6GqXipeHyiL7Mx4A8tXWQ2Z1sl3v1UpaACfdOQA4eS6BB/e/DMHIvGphBBjIF/GKYJZ0XrheX5vfHoFSJrKHrA8tzwqrtjpWgMyiPLgSTQLFu4+P3rsgIbdLFYFiMwzA/j6020+XvqPlPFQWaqizXPpyM9pUbZtt2m8PXpBd4qZPQ3+ZGXZwNVrPwoR8Gq/yJ4NtURP85YQqahGH+Df6Co+ZqiiMjxBIaPATZ+Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB6518.namprd11.prod.outlook.com (2603:10b6:8:d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 10:14:49 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 10:14:49 +0000
Date: Fri, 24 May 2024 18:14:41 +0800
From: kernel test robot <oliver.sang@intel.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>, Brendan Higgins
	<brendanhiggins@google.com>, "Eric W. Biederman" <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>, David Gow <davidgow@google.com>, Rae Moar
	<rmoar@google.com>, <linux-kselftest@vger.kernel.org>,
	<kunit-dev@googlegroups.com>, <oliver.sang@intel.com>
Subject: [linus:master] [kunit]  3a35c13007:
 kunit.VCAP_API_DebugFS_Testsuite.vcap_api_show_admin_raw_test.fail
Message-ID: <202405241710.148db8b0-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: TYAPR04CA0020.apcprd04.prod.outlook.com
 (2603:1096:404:15::32) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB6518:EE_
X-MS-Office365-Filtering-Correlation-Id: d55d69aa-0884-446a-cb79-08dc7bda5802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pdDcbLfvTNyvrRWEWPwkDaCYxPu0JS7vjhtZ2ufWkJjJboRJfCc5IK4tVWoz?=
 =?us-ascii?Q?zk16JKKJOkJqv7eEr+2Zu8uT4LYdcsq1i2aXQ0S74XM2rXHN4X+lDxe9gwan?=
 =?us-ascii?Q?89PGplCIdIe6PHS/SPdMozvsgP5tV8/iIfYE1m6tOc5LXlQUR3WHMQiBYqhF?=
 =?us-ascii?Q?1JqqQ2EIFmk4k6mGWpgIfOwSdwotVw3eveaXxSqR64PjarYiGqA7NDbaYG6v?=
 =?us-ascii?Q?DoSZtiewVnrVilJdEzUtmYNS+C8Jh9S3LTloQdJYgMg9HqcdVRDL3glFv9Jg?=
 =?us-ascii?Q?eCCv9TNB+iQ1FkPGiKxOFN1qf1SvbREfpF8CAxk35/VddTceWCA4l38W22x8?=
 =?us-ascii?Q?HP1+y3z+6EDQYyo8Z1ikPxMuat5V8gsgAa8QVNOquvC2xjjTQVF33SPyJ79V?=
 =?us-ascii?Q?7Q6RnfkZGQkkWg0IOGZJElZPXy2Urae6mIouYwNv+AZ26S5SVdQm77O0lANe?=
 =?us-ascii?Q?xlpr+3rJMCUjuwpKkm+RxCMljzLaJOuVolY19hV3VZNviynyLna/i1//fkRi?=
 =?us-ascii?Q?YV9Q47oUQH+1uINiERcWHYzx3Vg/7ApAYV4BF45QT5i7+3ryUycnDkQNNmSQ?=
 =?us-ascii?Q?Z34xR4wQU16YqIdcmkhrD6JN/7fH5U31o0t3vz7k61GOAl1AEjGjWx9zPMfM?=
 =?us-ascii?Q?xI5WGPZMhvZQu9O5sueB1SauDoaJ1rHZ7lfRTUTVI5bSGK66lENyzriAUsXU?=
 =?us-ascii?Q?6Bts5+J47LYdgATrOvXYl/63AWQvm2U9h9BLfphLQ2sXVud+5lxBIGZpc+RZ?=
 =?us-ascii?Q?IfhPD8VsqX3ETrJzvw8Jgq/xoLugD1MtMB6aCGqJ+LodQx0FKpltNTEU5RJE?=
 =?us-ascii?Q?+wqRM5IjpEu6UuZnoAv2czyx/1g+WKKb+79vgsjzfV0uNkf4ebhiTTFSdQUy?=
 =?us-ascii?Q?PCN/KiIl/IeitlSHyi/dHempTATB9HG1h2xthr5bv/f+/0asggqi8A6yEXB0?=
 =?us-ascii?Q?OByvSPgtiFjJ/fGCAOG49deExNgIWF4FMZhKr5d04fGq3AhsAubxmnZH/j7J?=
 =?us-ascii?Q?ZHos0bKb808ovKu+rjfyo2nj5hej4+q/L4DMzjgcvJ8QSOkdBxizOtgq709q?=
 =?us-ascii?Q?IubSR3piQWmXYBfCJEZGDR/OhLj9RGOdoJeh93PWZIHLc+qek/7WVr+p72vf?=
 =?us-ascii?Q?f6Zoa2CsaKYYKNS77V5BaKopkXPmNrfFAbwlKOAYd/FYdt6zEGYwAcEaingI?=
 =?us-ascii?Q?K3aW3BNn/NpTWDM9roJPN0XYnHcG9SiIW36FpNF/Og1CHSNvsv5y8CB88H4?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sRyXzldtocaYCd0CI1BYrqfXXpApS4UygJJjfy7w6tJPDE7B0LlXgWq9EHrA?=
 =?us-ascii?Q?ERokxMGo1FqyWY/jfxkfDNLVv5azemG+basDj4afGgEnB/bIKKERn9j57dwI?=
 =?us-ascii?Q?KKvktVHyg354jGs43KrHesiGW0jh6OgCUw1UmNZNsQyWZ2LcUKvXie/FA0TG?=
 =?us-ascii?Q?WMkJPWLUpPGLz9c6srHEgH9zoy53Fc6522RagkdsyuJXDMqx0hwmDczOs6wv?=
 =?us-ascii?Q?u2c7O5wBB86XGfZk6KlPWQ8rg/puQBt0mHgLCYDSjbewwiL0oqJSgRxbvEE4?=
 =?us-ascii?Q?5JZcPpbiM2xhkTHB6d+9YutJYBxuZKQ3hWIvpMpTnFLenH3L9T4ZMC3FuFYt?=
 =?us-ascii?Q?HmcEDUhEvNMRM0OO0omk6sx/hL7Z7wZZoTLnAnzGpgMeUYQAPH73MZLMQmfv?=
 =?us-ascii?Q?dpX752yd8M5D4biDUy2GcennPadtbgP8HaKYRb0c3QDNlg2KrlcUKbB5Maw4?=
 =?us-ascii?Q?/05YLtmn67gNL8HNRgZaOFbxWFzEmSRG0o0ZZ34xqjBS/OygCCUaMzrR8FFU?=
 =?us-ascii?Q?UjI5v6TELuvgvQ582oop4WLVHGV4RsygOGYM0LFqRmu6JtAxOo5pOlneYbvo?=
 =?us-ascii?Q?m+NfiEmsYux+NSG+h+19Kp+wfFZpk0isbe+La7V6r/aeGavN9xatKu1kyTLx?=
 =?us-ascii?Q?wGJ7i4WLfQP3sfWqZJKPg4nmOTmg4pTegniW5DZx6488DFfkp0EG3bfOVJ2X?=
 =?us-ascii?Q?IQvxQAwgbsO1P0ImSt/UMI1XVtdp7KWt6vBBDH3HrECGMcjg+r9CVdPUdr75?=
 =?us-ascii?Q?8YU7WdmK7fBn3bQdPUckPW+aPNUh06oimb4HkLTmq4qejvJ24f+hSBzmyrTx?=
 =?us-ascii?Q?+SWPKAyVBUHhj0Aec38ZZZamgIxBVInUUma0k8a4oVgFz1phXO+fVNBIIzBO?=
 =?us-ascii?Q?y8F8piUbZGaEm7qMC8md/BoUScmzzuAiOJ30tSWemPwtvlB7aGcOR1ePMtBo?=
 =?us-ascii?Q?Dy88muUApkM3A8GF2xXeCOyr0TdeBKeP3LDS+oCwyLvlM2gXaRU5qfR+PXLk?=
 =?us-ascii?Q?xKCDSqSmFgT5dHJPBULPF5vMgWtkS1VHmqjwXQJFFVDlkSi8Lg0ivmXyCGFA?=
 =?us-ascii?Q?wsGQ65nQ/wa/Xv8mVNJcHLfGssKM6KVYxLpwXR5/CyHQmLCHxYeU18jqszpj?=
 =?us-ascii?Q?2Bhy/nKGCiAlnq4PQf0QrQrP4NoXB4oXu5q54DVaL4+d+02Zk5ezgBm5AX0X?=
 =?us-ascii?Q?if3bH+nDgeiUkv0mFiPogg/G7cPNu06gjI/Uq54SFomzGKwu2ujiNENG/xWb?=
 =?us-ascii?Q?rRXnH0hvjckruOGgzBuJs+FdtjwhjfaR9dR4pkUUubGKMDPAQFiI6Dx3WE1U?=
 =?us-ascii?Q?qs/Qa9XZwx/9vAzPWLB+nq4BtHzjn9KCsMajKx34AqRzJCwvHahF6BoFZT3O?=
 =?us-ascii?Q?VOYF5PO1RYZ7xovbFKCYGFuppZtYXICWCUIJMRV5Zb5X9d2sMw19R59EiYLg?=
 =?us-ascii?Q?Pz8P+BCcKPgXjmahOynhT9Xd+5AIjjMSEcuPzsvJSCWxZoOHecBqdkQrhdaq?=
 =?us-ascii?Q?wR8/Yf7yJgoByEm4b17tx6exeQbHDufxRbBU6TL93hT4mhh9D4D/2KWdkZZ/?=
 =?us-ascii?Q?vovbyfbIaxnVByr0GCugsKVuMwy+qI8sf5R3Ax9zt2dq60zuAv6HjKRgGXQJ?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d55d69aa-0884-446a-cb79-08dc7bda5802
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 10:14:49.0248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVTo3nHfSiEygmtrHu2FvjV3dtzoFjqzs8eHpGvAmNgaYpH3QMPM/o3xi11250YhSmWt959LFrL61hX57aVVFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6518
X-OriginatorOrg: intel.com



Hello,

this was reported in https://lore.kernel.org/all/202404151340.5b152d96-lkp@intel.com/

since we still observed same failure after the commit is merged in mainline,
we just report again FYI.


kernel test robot noticed "kunit.VCAP_API_DebugFS_Testsuite.vcap_api_show_admin_raw_test.fail" on:

commit: 3a35c13007dea132a65f07de05c26b87837fadc2 ("kunit: Handle test faults")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed in linus/master      6e51b4b5bbc07e52b226017936874715629932d1]
[test failed on linux-next/master 632483ea8004edfadd035de36e1ab2c7c4f53158]

in testcase: kunit
version: 
with following parameters:

	group: group-03



compiler: gcc-13
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405241710.148db8b0-oliver.sang@intel.com



[  116.216583]     # vcap_api_show_admin_raw_test: EXPECTATION FAILED at drivers/net/ethernet/microchip/vcap/vcap_api_debugfs_kunit.c:377
                   Expected test_expected == test_pr_buffer[0], but
                       test_expected == "  addr: 786, X6 rule, keysets: VCAP_KFS_MAC_ETYPE
               "
                       test_pr_buffer[0] == ""
[  116.222467]     not ok 2 vcap_api_show_admin_raw_test



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240524/202405241710.148db8b0-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


