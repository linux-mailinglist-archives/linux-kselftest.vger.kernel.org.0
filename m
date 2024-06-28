Return-Path: <linux-kselftest+bounces-12915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AEC91B90B
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 09:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954D71C2141B
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 07:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11AB14373A;
	Fri, 28 Jun 2024 07:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GfDmae4Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40602558B9;
	Fri, 28 Jun 2024 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719561159; cv=fail; b=tpvsSz1ojEyKbrXgXyZ7tKp9RqGUQXKj2/RYE/Ptd1fMgiVGP2gh5h3z49g/H1O1pvfRcTSwFZ6JmIGSYpGKvfYdVN2kFw8IHgajUEqDRaCzBK75DP5LKdQZX7CSxtr1KgZY/TEkT+eZPVB5QZ0hk41npMlGFvWaImfjruyV39E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719561159; c=relaxed/simple;
	bh=dF0ZgMHVwPSI/V2/Azak6+JYIu5KWq4Uq/ARSy9lvaA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JODMwyIOzm+b8H7VSnEmuISCqwZYYqSQhzOO0QSBoOwVULGERo5sc2jb7jTFV0cW4RCfDs9R+fGPXMg1d5F9BVD/VdSS5tE6/PAJ2+YgbJRd6rbVpyZGESwNheEU1FLR5ONY4mEMrtjss2PxlegKfuBLnqfQF3vWtFFpoVk6W6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GfDmae4Z; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719561158; x=1751097158;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=dF0ZgMHVwPSI/V2/Azak6+JYIu5KWq4Uq/ARSy9lvaA=;
  b=GfDmae4ZGRdg6hI/yUQWTl5lWvAGE4nbjmJCcTE91J2sCwNMTnPdHW99
   XTg4TrZxvHJkV9nzmkg2gFB9AijzUX2Nd1BrhEaiqkseWqskfpWR601CK
   pczeIcoY+CC8G71gsCCeU/xTy8eHaC1F+FBR04s8R7qLIHLVEezIqiqul
   bqSz3h7n7TvtZA3nlA003vLGSDuZbpbKMYxuFKc3cQM5bJsF5CA9CzUl6
   agh+wvyTiGhmpIu8CzyeTsjO+J9RfLyaIo5ANYQH1vsE9KGb8R86ln3e+
   24SR0rgKKHt/PcnKDzun6dzindrFsJ3L5Qp4shs9nDRLcLAsACazNJsQv
   A==;
X-CSE-ConnectionGUID: rXOrqPpATGqw4FocI/L53g==
X-CSE-MsgGUID: UGz5fsemQb6Ub9wIBmBIOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16410859"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="16410859"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 00:52:37 -0700
X-CSE-ConnectionGUID: J2NMFl7bRnGKzjhj2WBXcA==
X-CSE-MsgGUID: GOVaVvMARfqFwDqEwi4cmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="49615224"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 00:52:37 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 00:52:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 00:52:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 00:52:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeN5CijNYAypl6vmGEx6e/n7o0xIGizEgOL/MNY/C5dc4H0rMAmU7cAU1D+e8DfzPglMR+QiG2Vn/IvpMhDsBMtGtkqdCc+g0hSAqxDHYBRofGZnB2qeEKlvDRcNxzcQHr5sem2Eek1G8EMSsJl7RYRmyWmC9IAwtZhHWwB3dgjslWhJH0RvwUtKsm8agze7cawJ5AA2F/WWuEVTsJ2X+kH6bTqb3iswklQ3N8W0LCW6oUXcMadO7jOWEpBWmADxVlP44iQa4QD+zXsRLGOhwOnbFVUEli7Gm3rM4yO6mSHM3hITPhozGcZi5dFwsf0YykhKnenQf2Sj9M7EvxFfWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbWgJ6Yyk8Ty6BWrygcEU/QaQv59tfln8Pupllr0lKs=;
 b=Jj6yCSeUwKqgkh0c216EbHPNw9Z6EPUus4xWqoDlzkOOxk+geFTVXhRHIV57VTU8ppaEYk3yNbmhLghgAY6R8r1wKMeV6Gd4kzQJ6jZzrn3S/w8k6sOY24QHjlekCW4rr99IXQojxyAVZLzn8pQzmD49Nh7wzZc7IGxhZFZoUggUJQhxo97+Dmotpb/3cAn8FbcSkydGyxz4Lh9+hIYb8NCdXykBVZM0VAiN6dGvPZWIl0A9vRmEs3dppuZq2vJplvAVReI6xGpJWAXWbx9l5UyR4KIQlt3cYbJEmEHnR/HEcY6E0ad5pfDBVJOTp7f3MeT++6QT4aw2DlXw7EMLBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SA1PR11MB6965.namprd11.prod.outlook.com (2603:10b6:806:2bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 07:52:34 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%3]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 07:52:34 +0000
Date: Fri, 28 Jun 2024 09:52:18 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
Subject: Re: [PATCH v2 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
Message-ID: <6t37aaepgw3r4db4t5usfc2zz3mv3ugzcreleig5md7wlyjnzc@5eie6g7m3hhi>
References: <cover.1715769576.git.maciej.wieczor-retman@intel.com>
 <fe9295c6be677d187b1607185e23993dbfe74761.1715769576.git.maciej.wieczor-retman@intel.com>
 <9fa47acf-86b1-4602-8790-39ed80fd775a@intel.com>
 <n2el3evhluilmjhrwgpkkb7ld2g26zhmctxvm77b3ome6u6egf@hym7rnr3h2o7>
 <9b976e89-0320-430f-9f0f-48e25612ec98@intel.com>
 <b5xggwzdvavhqmxpaeisovp3e2xzjjhvkoqcbt6hg3sv3wzh3i@a7qaatwfpbf6>
 <5bd8e17a-5810-49a2-a07b-88c05ca21af7@intel.com>
 <ewkiaarsl4s4aofw2uykhup3eyutnzitlow3muzbaqqf4xp53g@6lgc5o2dkmor>
 <ded7afa5-7197-48e1-98bb-066b9df285fd@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ded7afa5-7197-48e1-98bb-066b9df285fd@intel.com>
X-ClientProxiedBy: DUZPR01CA0321.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::15) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SA1PR11MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d2685f-9850-4f56-af8f-08dc9747453a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?MEFBfj9B3r+EaRhBOrWtOH0j5WHY6AVLqzlEzeT3xdj+0PKE6YDPJCUcPC?=
 =?iso-8859-1?Q?SJTF3ygQaTviT/VaWdt5pwsud6jvohMYXMq7eW+X/HTBOcb4fow/HFEd/4?=
 =?iso-8859-1?Q?tUb3+jaPTaWtUWFMX2TJaycuQ7eDIG46qd2/++cANU8j69EEabWOiIK7kn?=
 =?iso-8859-1?Q?Y+NCz4Y8KUQOeb/lYN60PRsng9jPEWo+qxQWtBEtR5aV0IPf92WtvJ3WFz?=
 =?iso-8859-1?Q?hZE+BwGsp9HCAfdzG3QIERmW5JuZzAsNB+QiSRdVBS8lMMn3jnSUJsr/mO?=
 =?iso-8859-1?Q?5C8uYDLEjWEqsXlqcqiXLH0TRSYdNHF9T8HhNkV8P+j7qz+cK5uTPaG3/b?=
 =?iso-8859-1?Q?aS4q8EcZxdcq9jTTvgd7qZO56HNOIt2RMCj53YAwasndizHrddTf18OV81?=
 =?iso-8859-1?Q?nhxvVirFp0rNhSL7V5eyvWPCxwim7LeOOMhpz1vziYIBqI+WWffTnwagHO?=
 =?iso-8859-1?Q?HjXALsSiMXrJgjN0ZzXWkkU7je+arRji2AfYAbIyoX3MzDot/Xfoch1Vsc?=
 =?iso-8859-1?Q?6TbCRqIohpGmqnOP3KSmI73tky84oFCqyW7CSG4BA0ehVoi7IBCYggOKf9?=
 =?iso-8859-1?Q?5TWk6FBtMT3cTPAU9lRDsLASZ0x0JFif5UzjkjMBpRG/RwsQdvvAwDb/XQ?=
 =?iso-8859-1?Q?nL79O16ns8WvLavcmhwYuULVbQawrP5ZqBjJ8By/W91ohTmi39cYBQH+PZ?=
 =?iso-8859-1?Q?MTZ5YGOffX9L+WS4r4UkEQmbbQlerOp7anVkY7uozpOg6t/PF0ZWOOFqD0?=
 =?iso-8859-1?Q?euri98cehfJXErSq6k7GrT1KxTDvKqtVKk5cyRdI3KT/Jl662m6GkBPpnp?=
 =?iso-8859-1?Q?8dEFMV8ycNozHbpqi3NuW51n2zWcQgSNYh8YSOUDQOYxdiuX1Spa/wfYk+?=
 =?iso-8859-1?Q?Z9i3bQTGNh7reQuVPXSAjsZvFtOptS+BtLAkNM8b4nfeTMymFmlkUEGOf2?=
 =?iso-8859-1?Q?xq5kzKRhJM+tCya8D5ZHpzn6I+OaTRRZLBYPNwm3W+3XB3uDC8qN5MNweS?=
 =?iso-8859-1?Q?yU1yY3kScSjhvGeA8zcrOQSN8VG3QeJeQuwJRSQUC7fieovnFkEt7VByHx?=
 =?iso-8859-1?Q?82tUeF7jbjuUNVxGGWZBxFfi7ofZ80k7L2U6kFnf3Lk1O0VBwLHP9fE8qS?=
 =?iso-8859-1?Q?X1GmXW0CJFc+3zRqAgRgsOCNBdN4BUbQ0xsok7r2Co5+DNOc/OyIfM57LR?=
 =?iso-8859-1?Q?FM7LkNwoPtzqGRn06dUHf2VFvzrj3xW4HGqUPxtOVfQVgFI0cDq46Y34mT?=
 =?iso-8859-1?Q?+PFWYW9FnH1LJ7She7MNScuPSFP0inBVNsfGNYljmilmkasMGyYdHrXPYV?=
 =?iso-8859-1?Q?BoOOPUyZC5Hcn1tBToUMwJCelYbB1qL4XF09kq0VGmijHRMPoClF1RFMbL?=
 =?iso-8859-1?Q?jNh/G+sTzuPUUvmdhErsjdnXcODUAGUA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?0CLabb8vGycDx3XQdgiXi6S2BF7RXJn/Hp2OT6Zt0DbP8HHPdnTkARups3?=
 =?iso-8859-1?Q?mUyoV3nkYQl7bUTv7K632ThszzstysMYDCwWt0kuvYlMBbMiBxgxvfhn/c?=
 =?iso-8859-1?Q?swzQoQEAClT/Z4YCrXUxbh7SiplpoBVfKI8uYC4aGawsRgl5D/sPVqPX/u?=
 =?iso-8859-1?Q?lJBfFRODqA4+8UUJnOMflKbcUhe4S4RAratydJw6hTUGhT5VoeUO6aeNni?=
 =?iso-8859-1?Q?NFK5QsVLfA5w4gFyNOzXsg/DkuI8M6f7046v+cfR1NIANZVgS5YYFtdSji?=
 =?iso-8859-1?Q?jGtq7YucPmP/H/5ZNm1fS7t9BLhif56LTZ1zDjuj1Xwt5Cb49t3qqSMODZ?=
 =?iso-8859-1?Q?eZ8oUBUmRp+XnXtPmI+hBKh/DgvpIfHunD5zxZdef2T/AVkNsq9zt9Pyov?=
 =?iso-8859-1?Q?ETqezzwBUCjmaU79t7gZnZYruZBIhrILlg3jgFpciUZ8ByUrOvw1e/c8Bu?=
 =?iso-8859-1?Q?WK7IgZzrMKE1IWsOrxlIBuyI9JwQlUiCzxnirsDeUmQUPv2LhabhpR6uZt?=
 =?iso-8859-1?Q?DGPjfmRTDL3S/bID51/o9clV2TSnYamp3XloFdzSp6EbW68ERNMhASog7h?=
 =?iso-8859-1?Q?sd3GnpejOlg0d1wLVQYx4x3hdBGGnqRA5UsimtbGqjoPg+PtRQqvO2T+Vb?=
 =?iso-8859-1?Q?nIyhGR/cZ5JVOIMTSyJMbiHA+lD9juPOkYH7WTxCqCnako4nRjDODHpX7i?=
 =?iso-8859-1?Q?pB1OTyqU86CnUvR07ItG1uQC7yyQMFixbBPL0MeOQGfIc57CF2UsmubuJA?=
 =?iso-8859-1?Q?lJwe+DqPNlTGoA/2fEoQ8MtZ+MJ4DRQTtYd8G0zikbuUG+XaSNIYD4pro5?=
 =?iso-8859-1?Q?hYtflHh0M+VKy0r1FsmxYXED+CVycbgVnFiWYNEyYg/KKoSHugdmBw2s+2?=
 =?iso-8859-1?Q?v6/vb443yPPZRYagDM/d2Zzuf7yRRXplxxf/JsmIlZLCS72b2XRYzCl8Nl?=
 =?iso-8859-1?Q?1yFMXrCJ9mYv0PKAZibx+rqX8UVlFDElz/Yz6WvYUGQIYI+cb99Jm+ajt8?=
 =?iso-8859-1?Q?MqJkT3MrEWwFd+igCfPIXBkbFGwRKZ5X2rqHSamx14Z5kCz69eGCqgKIhM?=
 =?iso-8859-1?Q?12Npvf9K2mkukKlLkoRuFzbJ/vbhDqJtD6TQ3fGz2maJ0bgmihqUtA8/AL?=
 =?iso-8859-1?Q?nIk5ywIbAfsHfkRYhvu3ftlHP8F+/5eT378fhhhx9dq189kdyX0JyP3HU5?=
 =?iso-8859-1?Q?n1tTUVXRTrhMA3icz8Rt1JGLaxPCNzwAr8dTQ8I+scYwVWImHbtyhEDLEW?=
 =?iso-8859-1?Q?9cY5UqMFg0vgtYLvBeG2j1h42zUG4yspt5VZdC+eqKlq3k18YzvGd1IH+b?=
 =?iso-8859-1?Q?WBYeQXjeYCFpS3qqexkHMdR/LCmrcz3bL/eR7bPDjC7U0kqin3P0tsdbVw?=
 =?iso-8859-1?Q?bhthuLb4F6C/9gmDMFG6XuWiLfOtlk2xf5Qnj82xilUbQiQI2aayIX0MiT?=
 =?iso-8859-1?Q?/ND0l2EzV2NW5PqzPw3JGc3pu4vxHonHB4ZFSOa5FWc/GER+FBHvoUWLYP?=
 =?iso-8859-1?Q?Nv0TnudoWodWT9QXPCjNSoHnrJBzH11YIl5byWJyZrJAJ6la8s/B2VOq3n?=
 =?iso-8859-1?Q?qMJLPVjqbRd/Gx1vXJ/mT9q8S+FO/t+XcvDHIwUNFNxIujfJ+WmizsHx4v?=
 =?iso-8859-1?Q?P3khVDhCPQOsNUuh2AT+Xj0LfOjm9dQUPr2pT3h3bwl6v/0SHigXcYY2eM?=
 =?iso-8859-1?Q?rOFiECa8mscAM0swT0U=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d2685f-9850-4f56-af8f-08dc9747453a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 07:52:34.2170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptsxud9teRIjleqtiIFPx7P8+KN0MXfi891a/GWy+3hwC270+DLy+lPTyRluQOGQU8v+l7TQr9P78AMr9ex61jsQtuisBFEvNDR3W5mwcaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6965
X-OriginatorOrg: intel.com

On 2024-06-27 at 09:30:24 -0700, Reinette Chatre wrote:
>Hi Maciej
>
>On 6/27/24 2:50 AM, Maciej Wieczor-Retman wrote:
>> 
>> Yeah, I've been thinking about what is the best way to display these for a
>> while. Maybe you're right that messages at the top will be lost. What about this
>> set of messages:
>> 
>> 1. First run of run_single_test()
>> 	1.1. For all tests:
>> 		- detected snc mode (if > 1)
>> 			- check if cpu/offline file is empty, set the global
>> 			  variable and print a message saying snc mode might be
>> 			  wrong
>
>When SNC detection is considered unreliable, everything else becomes unreliable also
>since kernel support for SNC is only visible (in future kernels) when SNC is enabled.
>I thus think that if it is found that SNC detection may be unreliable then the number
>of SNC nodes should be hardcoded to 1 and a default message about possible interference
>by SNC should be printed at all test failures.

Okay, that sounds good.

>
>> 2. At the end of tests
>> 	2.1. For CMT, CAT, MBM, MBA:
>> 		- test failed
>> 		- snc detection reports it's enabled
>> 		- kernel version doesn't support snc
>
>Sounds like the "all goes well" scenario when SNC support is reliably detected.

This was supposed to be the error message that was already there before - now
I'd just add the information about whether SNC was actually enabled.

>
>> 
>> 	2.2. Additional message for CMT, CAT (since the cache size is divided):
>> 		- test failed or succeeded
>> 		- snc detection reports the offline file is not empty
>> 		- kernel version supports snc
>
>I am not able to follow what happens in these scenarios.

And this I intended as an explanation to the example I mentioned earlier - the
test succeeds but the cache size was miscalculated due to offline cpus. But
after applying your suggestion above to just set the snc mode to 1 when SNC
detection is unreliable I guess this doesn't matter anymore.

>
>> 
>> The 1. message will be printed at the top since it's more informational (what is
>> the SNC mode?) and then 2. messages will deal with possible issues / failures
>> and will be nicely visible at the end. What do you think about this?
>
>It is not obvious to me what the messages may be but the times/locations when
>messages are printed sounds good to me.
>
>Thank you

Thanks for all the tips and great ideas, I hope to send the next version between
monday and wednesday after trying to trigger all possible corner cases.

>
>Reinette
>
>

-- 
Kind regards
Maciej Wieczór-Retman

