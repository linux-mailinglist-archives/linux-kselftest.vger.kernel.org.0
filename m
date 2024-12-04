Return-Path: <linux-kselftest+bounces-22825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391809E3951
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 12:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 986DFB2E5F3
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 11:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826AC1B4138;
	Wed,  4 Dec 2024 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhwzzGIT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B611B3929;
	Wed,  4 Dec 2024 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312142; cv=fail; b=TDnG+6A8ZcMBonFBkLfToTEI0tVRmP1L8mJZmPsGHHN6/iaAkqAX5ehXJPtArP7sWmu/WqW67FmmdfL5puy0iMC0ZYopWnxqrZNWR8buyyN2KGu+SkSWHmzqsKFrhoe4DwoUVcmKdqtmX+rkxhQAB9wUo8zqI8BarQAt+yzSA0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312142; c=relaxed/simple;
	bh=u4Gk77EAXNF0sOG0viW/qlGxoZQAkmGL7lWLc+X5HQw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HSO//9q3JckfIUHv5eQLYqnOBloH3FQQk/UoIKh8LhkTGFqa28bvZ+TpbzyosWOdr/0PE0j63WFxhcCgMHKlL/Z3qD0V7jzpCxzW5x18qZm4PNib2O8nRj8btggUExNok19yun3+tkyvGz8wdk1lzX7mwcScKMnLMYfv8rPCzgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhwzzGIT; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733312140; x=1764848140;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=u4Gk77EAXNF0sOG0viW/qlGxoZQAkmGL7lWLc+X5HQw=;
  b=nhwzzGITaySEcyUo/VgoDxUfZHgei6y5BipL6/hA5HxN3Xg10XcDNf6z
   UvhtVDuF84jXJKBEiUMWAXIkRHAFbo9BycvyRsElVPhkQQfaJWZoAClYe
   8kHYtMO+e5P7vZd7MHSeCBZltj4DhrDyHO3jsE7PxQvyASmhSlg6Yva6g
   UlF7g31YkFdIr5AkLcb236A5T6p66GHASnylsYpIrtbV0LsFbyVTo0Ma2
   bvfl7Ty7c8DwuYjB2SqVf0ZO+IazMlPEdEz3FUpm9/znOjZGC9tVzlE+f
   5RvW1qMd9YVdzQFdgzYeUYEcPiu5WAyjQGBlRby7ITXUiVc0YvcL9NJQX
   w==;
X-CSE-ConnectionGUID: KNTlyy/XTfCFrwIp59r/Sw==
X-CSE-MsgGUID: WZs0WBLoRbq4euzj2RCBFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="58986182"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="58986182"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 03:22:04 -0800
X-CSE-ConnectionGUID: H8UVb0n9RzyR6xfXNEo4Eg==
X-CSE-MsgGUID: NOFcXzYwQ8OeAOis5NjE/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93600730"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2024 03:22:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Dec 2024 03:22:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Dec 2024 03:22:03 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Dec 2024 03:22:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKeVS8FFe18mYaWINZZ4P2RIEitLeD4GSqaTEGzZPnTmG7FsVJ6jOWu67MaEsODoVKgPUQmET4RK0zviWl4SBKJQ2JacrJzTo02TRTC9XjtsOWsMj3Oz0RvEeLGLZX38A7j2BDjPCiGNygDkw6Bla6/Rlak3o9Wwze6YlQ64ZkNxtllTvHn7mEeJEuLh8LnmaddES7SQrV2Rcut8EQJ3AkQXR8MWS3XJzd8/DjWnjfgiqqpcrLZvel+KggyFVsmiAjOb81nd2dTm5UhA7xmYp0ltX8RZoIWzpBCjcAA5HEELR3RC8r8JB4aXpQXfW2Y90kMj4BiF+aGthKJNhFaCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aur0cODwxi9kbD6heAjr4J80dxPRh2FHcD9aA3fs60Y=;
 b=h3BhDn4IYYlt4aFz45o2guneI7GTjdqMReYo5spl7WPvS4gHITbvT2VjdxKPMVUOXyV+T5aUfzZtdchAtq8AeQKIm/waytLkN73dUeFOq3u1rNDhgqMUH5GPrG6rpfRgwI3E5Ro+iU5XqcJMY6141GPeQDtLgv6l6S6E70uFrr/hwdsdVkHMwjFwR/NJDyvkMrz20O8QE7xe5bcpNXZ9pCqXpBW21rjGoGinlH4WoKZDB443YjLXy57sY2O4oW3BH2EzEu/gHG+hnBvMyo7c5VJB8mbesFbtGLDTI+Zmh3dwbPcmkCJ9ntUMrj2/xMPfkK5dqxLbL8+uzeil2na2DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 11:22:00 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%3]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 11:22:00 +0000
Date: Wed, 4 Dec 2024 12:21:29 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: <shuah@kernel.org>, <fenghua.yu@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
Subject: Re: [PATCH v6 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
Message-ID: <vnx2c4perhflir6oduvhjo4rqtjggr6lb3e7ls5dptzt53fvhb@pkhare7cm3d5>
References: <cover.1733136454.git.maciej.wieczor-retman@intel.com>
 <c708db702405eef5c6796502863c9142c8a0bff8.1733136454.git.maciej.wieczor-retman@intel.com>
 <d7353315-9183-417e-8501-8beeb4e77085@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7353315-9183-417e-8501-8beeb4e77085@intel.com>
X-ClientProxiedBy: DUZPR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::18) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|CY8PR11MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: bc113495-a8ab-4439-8816-08dd1455deea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Bl4pc0QYnXIqjsNE3rcd0fwf4cuhS30XfqmzzPouFoyhAnhiCCrn6zb7zs?=
 =?iso-8859-1?Q?vPAdMsHM9eZgNr9D1dLQPaGEf5S+bwuHAZjIEjgPGA79s4n/QzHp3UIvy9?=
 =?iso-8859-1?Q?8eXMshmQJhg9Soo5wufpVlQ/mHjMxx+CmnI5uxxgMmYUqwC1fpAN5rWVqv?=
 =?iso-8859-1?Q?eZ8oAg00tKoFO24y79z0Bsxf/yvXGBFtCUHDxsS5YIDzQTpJYNo2cgrE6Y?=
 =?iso-8859-1?Q?8vuYBEnBqMygYlyal81GJeHA9JmPdbZJDBGdbc5Kj9CIJgllaeuUI1MBHI?=
 =?iso-8859-1?Q?k9Mr2tJEaxo4alTQoMvSBCF+x1am9Dl7fETTeLDSbP+EEfrMuoTesp/F6B?=
 =?iso-8859-1?Q?gmlljYM1EiP33tXjm0LqDFJwhywHKnJwgXRFswrkqqtNiLU1ZaZefq2kal?=
 =?iso-8859-1?Q?jdE8jVHNdzeoIk7zsuG6miJ9UiDMI1F1bFH6HCXt+HNEShP9tKQdug001U?=
 =?iso-8859-1?Q?utPUGfZ9Qw3evW2GgaBKu2L5Xl7DOzztr0Mv//hbuqJoNueQpu5mhJqqvy?=
 =?iso-8859-1?Q?8e3hLv/B78lC989VfgajsNMwEkY0O6deXWL6NPJtIQvWyhwFRFI6/ZOfVg?=
 =?iso-8859-1?Q?i1yX6jkGsehgoGpBRfs1fr5GqWY8xE2V7Qy7tHKoWgdyXGX3nKq8asL29K?=
 =?iso-8859-1?Q?awuaKyi/Q1IqP4c2W0mQJdoaIH97yb01kr8gtvZNjVDrc+wnCamRxiHUXE?=
 =?iso-8859-1?Q?r7f8n8J6Om2+6RjP8PTtq/tOq6+xRuB6ddYIOeLawkeB5kbYZDciXdwVxx?=
 =?iso-8859-1?Q?OloeA5k+ta6VJh6/gfcwDXfYko1z6GN+bEhzsJXDIyUmyHG+RBJ+iJYGud?=
 =?iso-8859-1?Q?Gq6jD2nJPvn0NmasxkDzv0dYWAApVGQt7jCB+M8OtFctTw6MQuRKHThFE5?=
 =?iso-8859-1?Q?aNr24RuPLyusQIugPco0/qBU+3w0+z4GtK4a93YEtBfLbgQwhfBP9h9s5/?=
 =?iso-8859-1?Q?mojI14w7m8DRCsNRGzyrp8ZI2F7ZBGj8ixRryBLJt9GM543lrqaQoIdhVr?=
 =?iso-8859-1?Q?udJO/qiae1Nqh4voflvk49zlJkhU+OoaLLqWZocSkcITCgSc4VPN1FGrb4?=
 =?iso-8859-1?Q?QJT+PAKnqDQw6ig2koQ9gXl4v7pt+hzq2dRAbaACliHVapkYDCOQdTYcsE?=
 =?iso-8859-1?Q?qJNOFEGN5Ug4zUnzkYnN6qVImwm3camrvweCyURVtc5Yuw6QBXfRb5BueT?=
 =?iso-8859-1?Q?lqaL+1OZm7llA2a9SCo0cCIyhrLw43vr0VI74v1Y7wwc/ZdtwMTU6dt+KG?=
 =?iso-8859-1?Q?k34Zp0Xk2I8V5JXj560RJJgDZSCQJfbsVVJ0W8OYCCwd2lEkp7TV7S/KIa?=
 =?iso-8859-1?Q?2WN7X0iesOqHMptGGJRFrufyyOko40mGhThaNirUG0IVIEsSaqzCMqP3y4?=
 =?iso-8859-1?Q?S9pL/eUPExEGSUuEufFvDV8XGk7r2EqA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?okkYhpRn0La4LzJgJoHDiJTaNVq6coFTXhvbiCB867fcIc3NNOPP4wC2Fk?=
 =?iso-8859-1?Q?7zhjoy2cyE+ajPoOKB0crBs6S1dK8jhhoduKmyIQBBvwT1cV9/iCyMPP5D?=
 =?iso-8859-1?Q?evbrkEIZ3M8K8zKTBubPjygof+6rZ+XdlrcAXwqYtelgFVcZ9+WBB2OF/E?=
 =?iso-8859-1?Q?Bjcrv4dTHYZYqM6fSjfRDnCzeJtyZH6MRqFJxNFm905g6ZrMIYpCzxLhqf?=
 =?iso-8859-1?Q?CJWLGhItfaTjEYI28YrJtDi0SlDR02ZzWxzwVWy6BInYjWF+kvTzXaxrbh?=
 =?iso-8859-1?Q?nHyEVSq+kmhfVj6OJXZbcwGRoJgapeHfrVZS+CLTzJcdiLht7eoSZ5e2Ym?=
 =?iso-8859-1?Q?A7WJUHSIPJuKtZFPgOHwvYAhFV2WRbpISiuQ+fnrWcIB9uA4GZAlpt8mSt?=
 =?iso-8859-1?Q?TxmnW3tDxtYaCNWfL5GcGMUJ9/QwPsiXXEsQDkgNamPvyg8JthWvEJHpDf?=
 =?iso-8859-1?Q?+pj7IQTQqUOzsSqvIRGeuLLtEHkhL3mh6I8j1ejOQvZdiqSHAU1FqDNQBQ?=
 =?iso-8859-1?Q?sEdrNS5o9RytzSjesHfoHEV49YbsFtt0o1PiEp1xNSuf6pAeme0RbmR9Ie?=
 =?iso-8859-1?Q?FGT1tw8dNOuUSZnjoN0IpyqhsMQzPn98FfTkvP5Cd6VJf15KCEA1elJjVh?=
 =?iso-8859-1?Q?ETjEHM9LOz/Xo0FVQKKJdoYGxN2OcyQ5GLHOYeGH1UtiNy2IXjtwxBbZ3m?=
 =?iso-8859-1?Q?jiHRngph0/SYg+XJuYRDI6aXz8hmDZPD+5Eq0NXuP2v3a11RdyAueCb5Au?=
 =?iso-8859-1?Q?Cd2ua91Id1ZF5SXFj4QgRbnjE3Y+wIPWLzwPgRxnwRHRnbjOA9PA5UPs40?=
 =?iso-8859-1?Q?4VWSkuhd9xHK6HOw15snI4bMUMKY8FpAb+u4MjktslhjWqLmJP17cwqKoe?=
 =?iso-8859-1?Q?jL+wNLpBr70I2PKbfSh780aY3E/vhHojScxmV2f1udrVpMU/NSd0/O7QG8?=
 =?iso-8859-1?Q?62G/8/oYaYZz5dxNltz1ydYGZ7j6a3r+LbancKQfjLl1bkBW4YeBiyob1z?=
 =?iso-8859-1?Q?BhKC0rpu+9LOIPkxl4sIq2Vq1gUn/vlElRgHSWyfGNxCIcPbddr3RStY5N?=
 =?iso-8859-1?Q?imyNNnNJyTQER+8KcxCzcOyw5csOd9h0ylNDf3ajAIbuCVMNbVa3O1aUnF?=
 =?iso-8859-1?Q?TPM9gRNYoObJZbaB/2u1QYpzPBU0WgvZPiGpUqCGWUiF25EfZbWEXFBR/7?=
 =?iso-8859-1?Q?46Rm8sSWps7SBdR7mIqicUYY7luunYXEyuFWVN2J0YgrFEuSpKKFdp2cGi?=
 =?iso-8859-1?Q?MDtrHHjwSLhrDHQiZkip7H4ardxmwBSaO/CtOd0QR1i2YkAQJ7xEAJyAhm?=
 =?iso-8859-1?Q?26N0EjFfuCtiiJLwmGI40v0nkxLw+4xoLXKtOjBx6Jlp8HQrbXwMMLr+tn?=
 =?iso-8859-1?Q?qjYWhIckpVSq/zJ7sHtxLXM9Cykoz1i+KjeZrUha4E97NDGuoaVqVIj6XA?=
 =?iso-8859-1?Q?ZoZ+sKANLs93YIJdwCW+IkkgtQk8UladvjjcOxC0RXx+cTQ24wPxNV650q?=
 =?iso-8859-1?Q?3goDYa8RqvUqrpC6Yr00pXo+XvyvjhXETA/cFqVxAYcazWfQIaaQh6cYgB?=
 =?iso-8859-1?Q?7re5z+WNs3bEidca/0P3Y4hn8CT08xIslqyVempkCt9tIsoEjjblCZYw4i?=
 =?iso-8859-1?Q?q2R8ukARB1wzaOrOPWekOAs8RCKi+YFwBaErFiPjD2/JL5aMd+H9QiD+4a?=
 =?iso-8859-1?Q?V38VM3SVRWt8ISLXYW4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc113495-a8ab-4439-8816-08dd1455deea
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 11:22:00.3244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WlC9HoYG4Ddwjxx7OmIGjKvv0TYGymmKAxzicMpNv22aXxxfLR1DGzimJGo4lS1aAiRkegPw8Ox/aaoAjBEWW6Ydgc1Ngr2J85KcAIYjn0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7364
X-OriginatorOrg: intel.com

On 2024-12-03 at 15:26:41 -0800, Reinette Chatre wrote:
>Hi Maciej,
>
>On 12/2/24 3:08 AM, Maciej Wieczor-Retman wrote:
>
>> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
>> index d38d6dd90be4..50561993d37c 100644
>> --- a/tools/testing/selftests/resctrl/resctrlfs.c
>> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
>> @@ -13,6 +13,8 @@
>>  
>>  #include "resctrl.h"
>>  
>> +int snc_unreliable;
>> +
>>  static int find_resctrl_mount(char *buffer)
>>  {
>>  	FILE *mounts;
>> @@ -156,6 +158,90 @@ int get_domain_id(const char *resource, int cpu_no, int *domain_id)
>>  	return 0;
>>  }
>>  
>> +/*
>> + * Count number of CPUs in a /sys bitmap
>> + */
>> +static unsigned int count_sys_bitmap_bits(char *name)
>> +{
>> +	FILE *fp = fopen(name, "r");
>> +	int count = 0, c;
>> +
>> +	if (!fp)
>> +		return 0;
>> +
>> +	while ((c = fgetc(fp)) != EOF) {
>> +		if (!isxdigit(c))
>> +			continue;
>> +		switch (c) {
>> +		case 'f':
>> +			count++;
>> +		case '7': case 'b': case 'd': case 'e':
>> +			count++;
>> +		case '3': case '5': case '6': case '9': case 'a': case 'c':
>> +			count++;
>> +		case '1': case '2': case '4': case '8':
>> +			count++;
>> +		}
>> +	}
>> +	fclose(fp);
>> +
>
>running this through a syntax checker triggers a couple of complaints due to the
>missing break statements. I think this can be made more robust by making use of
>"fallthrough" and "break". It looks like this can be obtained by including
>linux/compiler.h ... but from what I can tell care should be taken to set
>the include directory _after_ includink lib.mk so that top_srcdir is set
>correctly.

Sure, I'll look into it

>
>> +	return count;
>> +}
>> +
>> +static bool cpus_offline_empty(void)
>> +{
>> +	char offline_cpus_str[64];
>> +	FILE *fp;
>> +
>> +	fp = fopen("/sys/devices/system/cpu/offline", "r");
>
>Please check fp before use.

Will do

>
>> +	if (fscanf(fp, "%s", offline_cpus_str) < 0) {
>
>This needs something equivalent to 
>46058430fc5d ("selftests/resctrl: Protect against array overflow when reading strings")

Thanks, I'll add that protection here.

>
>> +		if (!errno) {
>> +			fclose(fp);
>> +			return 1;
>> +		}
>> +		ksft_perror("Could not read /sys/devices/system/cpu/offline");
>> +	}
>> +
>> +	fclose(fp);
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Detect SNC by comparing #CPUs in node0 with #CPUs sharing LLC with CPU0.
>> + * If any CPUs are offline declare the detection as unreliable and skip the
>> + * tests.
>
>nit: "and skip the tests" can be dropped since the function need not make
>assumption about how callers will use it.

Right, sorry, will remove it.

>
>> + */
>> +int snc_nodes_per_l3_cache(void)
>> +{
>> +	int node_cpus, cache_cpus;
>> +	static int snc_mode;
>> +
>> +	if (!snc_mode) {
>> +		snc_mode = 1;
>> +		if (!cpus_offline_empty()) {
>> +			ksft_print_msg("Runtime SNC detection unreliable due to offline CPUs.\n");
>> +			ksft_print_msg("Setting SNC mode to disabled.\n");
>> +			snc_unreliable = 1;
>> +			return snc_mode;
>> +		}
>> +		node_cpus = count_sys_bitmap_bits("/sys/devices/system/node/node0/cpumap");
>> +		cache_cpus = count_sys_bitmap_bits("/sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_map");
>> +
>> +		if (!node_cpus || !cache_cpus) {
>> +			ksft_print_msg("Could not determine Sub-NUMA Cluster mode.\n");
>> +			snc_unreliable = 1;
>> +			return snc_mode;
>> +		}
>> +		snc_mode = cache_cpus / node_cpus;
>> +
>> +		if (snc_mode > 1)
>> +			ksft_print_msg("SNC-%d mode discovered.\n", snc_mode);
>> +	}
>> +
>> +	return snc_mode;
>> +}
>> +
>>  /*
>>   * get_cache_size - Get cache size for a specified CPU
>>   * @cpu_no:	CPU number
>> @@ -211,6 +297,17 @@ int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size
>>  			break;
>>  	}
>>  
>> +	/*
>> +	 * The amount of cache represented by each bit in the masks
>> +	 * in the schemata file is reduced by a factor equal to SNC
>> +	 * nodes per L3 cache.
>> +	 * E.g. on a SNC-2 system with a 100MB L3 cache a test that
>> +	 * allocates memory from its local SNC node (default behavior
>> +	 * without using libnuma) will only see 50 MB llc_occupancy
>> +	 * with a fully populated L3 mask in the schemata file.
>> +	 */
>> +	if (cache_num == 3)
>> +		*cache_size /= snc_nodes_per_l3_cache();
>>  	return 0;
>>  }
>>  
>
>Reinette
>

-- 
Kind regards
Maciej Wieczór-Retman

