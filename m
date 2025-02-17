Return-Path: <linux-kselftest+bounces-26756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8444A37AC1
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 06:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC2A188761A
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 05:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3F81624F9;
	Mon, 17 Feb 2025 05:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uy1gegBr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85A4153BE8;
	Mon, 17 Feb 2025 05:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739769026; cv=fail; b=StpzibbEApFoWg/OZbd6b0iFpRTt5wR0swPQh4Lv+k2USUwm4zgYLzblvKn+G8W2w/QttxwMt7LblkEQWPOzd/Zh54x5eLuO+8gGlVSPsi96+eEIdW1p4qeJh2mYDA8pWJiwuw4fxudzAqs8c8yta36sj7u06xMJ+RaOZ0tfoOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739769026; c=relaxed/simple;
	bh=VYLAfK/guwq9fcPc9vVELoMaJcMAJRFUD7rcLQTmhfQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=NPuQawrsbOcnUqVu/nlLN3ETBh8hLdGR5PPoFwhzlc1WiBhwd5TcaQefCs+dFzLYleUrCGkUIvLvIdzejEA5d0OsVuQlK9nOJrGupMJSJE8aPUy3jRFX69ayS0EUP2aNUHZH7o/m+Vxd5btxdGBdZn3twkhxoveHrxN9Ydlbsas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uy1gegBr; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739769025; x=1771305025;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VYLAfK/guwq9fcPc9vVELoMaJcMAJRFUD7rcLQTmhfQ=;
  b=Uy1gegBraGPDqGG4o5HAz4QwhMqXCKSAOUG+ZIS63xFIiW2mQ52k7UBN
   XpDMwDoEZ+xbS9C37BaoPuThhY4n75b2pr+LUNIVIsj/PmM3mtPFhayBZ
   AKavLYCAJhxCJQCsMsV7A0gnxWBVsopWDqrC2LgU1rPVm0ROSODeHMz3N
   f7CX22tsiqCEBw/PyRqitN+5lNWYwigNcTYyl/2GoU4AOGhGPuIxwDVby
   tq+j/K7gvfU1ITbaY5VGZ0Y7s631u0Jo8u2BgZkoD8laQzAL6w9UORew8
   xTljjo9rwoEm/ITVh5DMNzOggTqrPd+ElxX7c7Q0FsS2B3vWE8xS+NMiH
   w==;
X-CSE-ConnectionGUID: D9RfUic4TD+ocyp+4zFZbw==
X-CSE-MsgGUID: ldHmcAPsQC+BeEEstbhC/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="51087605"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="51087605"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 21:10:24 -0800
X-CSE-ConnectionGUID: KtyhzZ7+QUudRg0AxPQJgA==
X-CSE-MsgGUID: SHp+zX/+RbCCdPaA4jtXfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="151188953"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2025 21:10:23 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 16 Feb 2025 21:10:23 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 16 Feb 2025 21:10:23 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 16 Feb 2025 21:10:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7IXdaO2+eNs0K33TmNqp3HgXFw5hCroVbJ/s94OpyjumNOTUBkty4DqiVvN2XLJifqeKA+OiEIZNWxfWQnCEv2oVbqAMdhaOOp7MRQ1tD/6ctPnhC8soj1hb8YRbm5XaLr2JGNUIqt6jWRCf+dI4+r9yiFo3wqIoOcw/cohIGTW5ph/8MbzNoid8taE9zSGAnMiyY8h7BVIfgGEMKWAkW677QfuHpNLw+SxqTtYGC4ZhjrNgwDAvxqCahauhBJaK8GiytopVZUFMtD5Eq/AK+C9/T6kWCs6s8Tun9KMBKmuRnEwxfrQs48xuYymLzzZfAQQkklNh43MECpse4gGOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pr11BhBI6DEHyASU21/O4MHcsEz1Ws+y9+H/Y7t+y/0=;
 b=PP+vX/yReDMAeGs0CLrR/1yRoClFr1+hCaVVUw5FToKIO7n31U4lM0hgr3/vk2QLx4JKmFP3SDS5T9wRaa+AYhDViGIJT0IJjITB2r5bNjpbpPpJ+uEENSpLHnQISNRQkndnKVs5fnDcXg4raBlttl4UT9YxxTcRWmn5xK/GYbJ98L/zHoKTiDEWhPAfJlSkc1X/4zpg/qxKS3ViC075mQADL/SBzNgbZEHb67vEu6WNVNS9gu7NlTFJdmtCdlzuPBcJWEOkIR1clGE0tR7AOWoFzL2bwwvK/rP7KH4Nf8egcTiwLK9yyTEgO18zoGiXfwiCo0rQFZb5JaK9InYxhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB8571.namprd11.prod.outlook.com (2603:10b6:510:2fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Mon, 17 Feb
 2025 05:10:20 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 05:10:20 +0000
Date: Mon, 17 Feb 2025 13:10:06 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Tamir Duberstein <tamird@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Kees Cook <kees@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [lib/prime_numbers] 313b38a6ec:
  kernel-selftests.lib.prime_numbers.sh.fail
Message-ID: <202502171110.708d965a-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ade2cc-36c5-492f-c1dd-08dd4f116039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9FWGUIEqnFGYrn7fdmkd3JlETGVSUjWzJQ1P1tr4HJwqzZSrhnUMJNrtpdiw?=
 =?us-ascii?Q?uo7vaeJtX8XAAuXQxOt8tFlJefylUyvY+sO8y929me+thgYxmd8zGPoT0Y/h?=
 =?us-ascii?Q?BaaC2r1ou1e5HSKTAV/BHfjhGFJRmHKbSiIKKkekJJUyJIe3OFct4LfWQ+Zm?=
 =?us-ascii?Q?IfX65Cd/WrXgNu+fnSyJVQpyJ3BE5BT7jIl+mBH1soWPngiRzP/P1bg8o/tG?=
 =?us-ascii?Q?jGPJCDM56UTx4cGr56QgxJXapGK2uFZ+q9fq9uKW+ro6UQgoKltcLKyOKhjJ?=
 =?us-ascii?Q?KYIaJgziWLxsB5avmKWRsX9uVwqnyevJHPJtMDAx0h7SrGRvKpH8XHMI5LFP?=
 =?us-ascii?Q?W8iIIYgvVsVAcCkJPl+mtaDIaDig1SfGtPEsT2l/3GwspMLUFyZbMO7X4Cdw?=
 =?us-ascii?Q?PT8SIzBHnpqm58KUvrmvNrPHjUGMC79nhFUUwusbdrl1zx014q+gJXL6MFSt?=
 =?us-ascii?Q?FvdD+fsGc6TB/EXAKjwbFn7b4d/SI7ItsVUKbcNstQSmr5mIBAYLxQsmZh5X?=
 =?us-ascii?Q?WLITinJn6i9f7mp+Rkxq+DMVpw+cM2kLXPuRLZtmlsVzvwWtU6e0Z/sXN7DQ?=
 =?us-ascii?Q?UfnookLViavZ3kbTa+feRqrTebkraMJSy+c7cN7aFpFm3awkFdEp5UVxWQm7?=
 =?us-ascii?Q?WgOMyp5vWiE/AhE2AwLRlRGsD/pcBnjLbZr0mBhOFCfb6YUPzbRcmY27QwtT?=
 =?us-ascii?Q?3qHqLgfVYJkXWNgKoC2tLkxlTNTn941IEpGnXv1jRbQocq9Nwk57DqPdMybG?=
 =?us-ascii?Q?qbgV4doKO2Win1z5pz0k8oQLSzSpLK+tmn6ZHMcgUKkYHmv2TEbHpMIr80/W?=
 =?us-ascii?Q?KWzRlZhdXrjXLUcSQDICq9mv2NhmghRFUAiFWyW+YUEVYmy9LkZbYoI2IPCG?=
 =?us-ascii?Q?RVLAIF2LFkTj0mSOJLD9CRFi16fy8V0LVmD8pPhyjEuhgnav9K8Ed71WWohl?=
 =?us-ascii?Q?72TMoCwyMmTQbkn0VDNehwqcS91T06J4/pIxhDddfiDauNL5WSote6diKwIW?=
 =?us-ascii?Q?55UMrT6LL3YytDefTSp02jh/j8DxNjrdk4tYETysV3tVhpBIFEsEU1O/VV2e?=
 =?us-ascii?Q?e9tzFWZpHwhKNRYZkvCw4HMBpl+pIFmBhWtiuhCY9rjtw46Z/0eKQ2InY3HP?=
 =?us-ascii?Q?J5FZ0CnadpE7uZbbDYXUm564Rf+W+el4tpxwh7Z6BVw2mcgkCRL1b9eLNz2r?=
 =?us-ascii?Q?DGPsS/xZYaoFDvqpbNnp3tKXGyuVaSNQ6rwWjc5arkaoPPM+VN2X9mOxS1oZ?=
 =?us-ascii?Q?9KaMk1Y3o19IMG1M5G7Ot3yWa2NtujCIOnUv/RAqRNuvZrGk1mWpKAH9rhVx?=
 =?us-ascii?Q?ZphxOkjkDibgB7S/6Y80nBOeY5ETBtVlVOv0+9Vw6SlswQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yb/XDXPB0MzcUDCpPzqPsWDkrVWj1brOmkI2mVwDulRSDLSeO+2p6sTCJbmV?=
 =?us-ascii?Q?E9p4oTXVMGlYcTI8XHnB6MZzFzWr3NHk7jb4+FYynOB0IS9rYLhdYVNbhfEK?=
 =?us-ascii?Q?UKampxPJ4hdM9KWnKuMd1uV/s2c5VjLqYYJIopHQpwt0XIFL5Z/ioU9FZ2JG?=
 =?us-ascii?Q?NfAXZUO55VT8CV4cr51WlE02N5tKMk1TKx+xI85iukpTMtajoKPnWUNcZuYc?=
 =?us-ascii?Q?pD/UzIFWoA/qwNj0whmaxlLsROn9dAPhACmMj5M1AqZAHxMElQE+SWwxGQYq?=
 =?us-ascii?Q?NhPDgmoz4PRVdYohgHuUAwPV6fDhljmBPOZVIwmM+keJbaykVwUYhfc1da6s?=
 =?us-ascii?Q?ZbFfSa78SNWz2H4x+n/eY1FF+NoMwTJRX+M+l4++9ktRqzKFhYfIG+yZshez?=
 =?us-ascii?Q?pqCiALz2WuN7+NrWsB/v9Cd36nNKI3okGssOfk1xEqEtGOUKLW+J/00xTPG5?=
 =?us-ascii?Q?ZpXFXfQtMBVKoq6BbQ2IQAiU2JE+oiUaHSj3YQnJOy/wVjWO6r0rjZAvQj50?=
 =?us-ascii?Q?EuF8hHQjanjVDaxfOljAN6UumVKQ7pAbxDF+7zyLi6wKNYXk7tWGiWbcmfTd?=
 =?us-ascii?Q?GdPMiOOVSqdHdC/B5b3t37cBciHGxNwGNL7cDCrpm6Ztxus/hWxfmgrqdH2l?=
 =?us-ascii?Q?38caS5a6VNVudxdNF4oNmj3xN+Qk/WDxJTGAUI4wfO81KsrMQPdSlF4KdT1f?=
 =?us-ascii?Q?LWqCPl+DVogdccopKvTQPcsCCX3knGbD01BB8tqbol0Ca/Iay7sBG2YX8VBs?=
 =?us-ascii?Q?ZZI0Zh8lQ0p4YH9Y5d3SKmYa+4MCfRznjAudliAcdV6agjOL/ngzoPm4xbe+?=
 =?us-ascii?Q?atHoZwnWQXqCUbCQya1aUMSkvq7APcNTP+9TbrQRV/4F+QWVcv4IntLCosng?=
 =?us-ascii?Q?Ee35JM8SXCnLZuthEBiecoyIUV85fwDHI0Da0Z5XKe/VJazO0pJPNWkz9NLJ?=
 =?us-ascii?Q?JN1lGMiQBkGJe8/1UdhynGdZmBXFTjxSfjjBnxFIlRBGMIRSmdisDv7fP3dZ?=
 =?us-ascii?Q?4sz54mh12lK/bN/nwl+GYJlntonhtkfoGCivjdzvqDS8t7BpzjyJqLUlpUmn?=
 =?us-ascii?Q?+l/3+Fp6axUz0uT3T+F5mBfZ20X1SSyE8IenTxAnD6F6lGuKqzi8czl1AC1d?=
 =?us-ascii?Q?L+3J6X1ybslBrFNMXnJKoMaTzCahQRzuR/G9uQnzVr0zzu3KZvTsxChKbgFD?=
 =?us-ascii?Q?+1Owsv8Tfjdp/JzuaKn4enLv8pWzq3lm2c1jgCYCAxBHvTUr86w0zCXk4oPK?=
 =?us-ascii?Q?DPqzQWYaghS7aH55hOopElIzUPlcspEm8DyUR0qZFXX4/HKeh9HbEtAlyqAx?=
 =?us-ascii?Q?qUMQTe/m9R1YHh1RD4DtLrs+VfzDqc/oRVPegaUUOE3XMV4gBE37h61YOw00?=
 =?us-ascii?Q?5/usr6yEBXL0z60ULZRtQ+gzJoWmrrAdS/MaRjY5P8FZqeu/T5szLuNAIrtc?=
 =?us-ascii?Q?DTVMZUCGRCREdf8uCLlLR3PqAj/FOeXxsxpmJX3Be+XC9KQ/ESPCWDxuvRku?=
 =?us-ascii?Q?BcVJBT/YewyMxkFDx6ppUscLbZpX+RWV1n4ltiLrhC00X7M1AqvNNsA5tWzl?=
 =?us-ascii?Q?MIZeXhkAJ2ft3F/d/ctey3davjOPJbeF3AP7Ei4w6qznxN6p9/anl5PX8H3P?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ade2cc-36c5-492f-c1dd-08dd4f116039
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 05:10:20.4782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqdFWyszX1bKRM6tGYT/5mbneVCmPayzkMph6/kn1PCZ/+8HtHG1nCAIHjfe9xucNTY4PDh3ID0niTi/UdHXiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8571
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.lib.prime_numbers.sh.fail" on:

commit: 313b38a6ecb46db4002925af91b64df4f2b76d1f ("lib/prime_numbers: convert self-test to KUnit")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 0ae0fa3bf0b44c8611d114a9f69985bf451010c3]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-78a632a2086c-1_20250215
with following parameters:

	group: lib



config: x86_64-rhel-9.4-kselftests
compiler: gcc-12
test machine: 4 threads Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz (Skylake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202502171110.708d965a-lkp@intel.com


# timeout set to 300
# selftests: lib: prime_numbers.sh
# Warning: file prime_numbers.sh is missing!
not ok 3 selftests: lib: prime_numbers.sh

(missed the change for tools/testing/selftests/lib/Makefile?)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250217/202502171110.708d965a-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


