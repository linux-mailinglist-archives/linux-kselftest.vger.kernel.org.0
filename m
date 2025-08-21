Return-Path: <linux-kselftest+bounces-39546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 106DAB30351
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00401BC861C
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21058283FCB;
	Thu, 21 Aug 2025 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ckOiryLy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0F81B21BF;
	Thu, 21 Aug 2025 20:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806585; cv=fail; b=cbSO4gxEAuKPUm+0GCF4WNecOIvsHgTMcPgfyN+NSDi8BtJusHhs0Fsxw0LDr5N0jy+ow9cb7O3WlpcTXTbpLLGbY6V2Nc1HSJpMWxdcJ1qH3waDHQ9o/DUNgcil4ntSArboSx5QEiCMd2g0yd0MlOcvXDWXjnKGcXw8oADSrws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806585; c=relaxed/simple;
	bh=KVqXS/ZOmePgrDp6CthSqI2IC/y2/rAZO8qAUnbnmaY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D5cBT0AmBkxSsZT7oUe2QyNGY1re4yHG4+nLVtQtplG8k5PJbJ++yUqTpU52ZTmS6ZD//M+oeKG6WDLMM5udZLeWUoC+ZTFeViB5/GUXCJKwfAZTAkzFKT0a+UWtY4AL5w14OeJJ8CI714/fZEpRDKo7HxDGgti/hMzhAifnugY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ckOiryLy; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755806583; x=1787342583;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KVqXS/ZOmePgrDp6CthSqI2IC/y2/rAZO8qAUnbnmaY=;
  b=ckOiryLyxhuogUOZIpbUZZjkEtkEwZSn50VHVRWSbQdrN89UT2nZ+vsd
   tzeOeaQMQ6nrVcEngcrq2C8Ppx0qjvyhibTW15aU1VhAcGKgZ+yqFamUS
   XiJa2yULubP7bk9e36M3iX+oCimESQY6QbWNMUpIQVxmHedXFnnk4qEhP
   3oj9r23AmoUzc4GVCZ7sm3nMaSdODkIRCnK/laSOKs4hpcghIQlExSmMK
   gs2hhFyYSaud7ZfHl95EiOOpeCFnupgPh+Olwsu37cjMlfzVyWp7aRkfH
   5hqKzjl37ZksQnKwSTIMSPjNV4RJ+EiVWkDu8JQk0P9MWLW8XOr8SG8iT
   w==;
X-CSE-ConnectionGUID: yiw82Kd2S5qPWqo3jUHNKA==
X-CSE-MsgGUID: P9go42vYTxa/myNhvShs7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68816308"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="68816308"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 13:03:01 -0700
X-CSE-ConnectionGUID: oxIXsRAoTK6QSGIQDnnyeA==
X-CSE-MsgGUID: 3Vzgc2SEQXy17iwGvRqAaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168001446"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 13:03:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 13:02:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 13:02:59 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.52)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 13:02:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHIuCixFki2s7GhA2Kgs+pcxJtCmB1D9973OTh6Ub/z5WQOBT8oL9mXFR/tN0biOD5UNbi+UAbNFNSRI5Sl9wl/qoOa1Mk2VZ/l2hZ+lCK9dXQ+dyhSX8R+q2L4xjPCLR3xUyCbtc0MtcAUz/61+0GivoehJBs8HXgEkrXg38oXJCAvTk4ZG28H0bjntd6L8M4JzG+XIigpjg4FMEq8JKYLZ57asquL052A7iDmp93Zu9OO9scE3LMce4kq4WBIyPHZOUr3OVRBGHGdRM1C5ktGz6U/NPLCPSG9JAl0z282lv0TMiHhCgh3XutJkNoGIsEfaLzgydzTwAPQvNtOzWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0h5x/x06ZWYOS2aqwzmTxlWV/ztA9GWxGHNTYyjhvQ8=;
 b=uinf07np4KgRFue96BYgZYyZq7A5bbKiddh3d33ay8KhnumbFZyCPwXNcu94E7nU9BB9ESCl3sfXFLdSUKJhOY7xImzStD/yEUNKBSjXix22ZqCyrjBekjhY/JbXFvWgL0oigsljheKCVb+KY8h+e5rS/F8KivM63r+NtLiD/vrcnXSDTyKw1fVJyS77kVuANFDfCYC1TRdbqv4gXD7XgQzKS1PKwZHssidmReQQCk9lsPsaTblgrahE/1bvjtKPadkRT8GPETNzlka04i2kWIG4EiF+WPhBNUSGaV8/+K9ad+uXN6sh0bvDXn7dyuvPv3KOD7tcTpfWr2j4Z05luA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by SJ0PR11MB5893.namprd11.prod.outlook.com
 (2603:10b6:a03:429::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 21 Aug
 2025 20:02:54 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 20:02:54 +0000
Date: Thu, 21 Aug 2025 15:04:37 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas
	<erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Roger
 Wang" <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Oliver
 Upton" <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, Chenyi Qiang
	<chenyi.qiang@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v9 06/19] KVM: selftests: Expose segment definitons to
 assembly files
Message-ID: <68a77bd5bc524_2a6d02294f2@iweiny-mobl.notmuch>
References: <20250821042915.3712925-1-sagis@google.com>
 <20250821042915.3712925-7-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250821042915.3712925-7-sagis@google.com>
X-ClientProxiedBy: MW4PR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:303:8c::21) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|SJ0PR11MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d01e90b-2fa4-4422-c289-08dde0edb75d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?byb1yHxEqszaiMWYKhNZC8ilRYO0MUJeYqWLJAjbpny9Rime4DbXF58ZeQlr?=
 =?us-ascii?Q?9Gdv44VEZ+S1qhmWtxUexlHmqMdP5P1hZFEfVH2YiT7b1M5CKMt/8mlNBrDB?=
 =?us-ascii?Q?A4IBJILgUb5HIKMgGOXvBvn9Y7YU3D4uymw9L7YOz3P46aKdpZZiJMP9/f5q?=
 =?us-ascii?Q?5itJrrvD+b1Zdp1wo8dB2SrI/LsFilBqhm0zpq+PHn8SSDVPyk8WzLwOLB+6?=
 =?us-ascii?Q?Dy4X0/n4/7899nJEbP0iSWDyaJQiAfm1+oGMxNzfmVnajHNPsR6/zmhgNqWN?=
 =?us-ascii?Q?K56g7R6t8j/RwH4yi28B7rKmKtRC/xNulK7b6Zjvu2s0aL/3FV6OtlC2cpFI?=
 =?us-ascii?Q?nbUqRzjgMvY+0HCfz/cxJmVJeOiEznc7Pad6EPc5EylnTCvebINIeqd913N/?=
 =?us-ascii?Q?ht41T5JXQQcLuJDOC+sC3W2YwFBlfSB4javdIz+Xwgt5eCT5UHTxRPv3HcqV?=
 =?us-ascii?Q?uJaMoSrg1bbjyKtHIk+OofpI9ycGwuUu0/eIabzLlzlynQIvhLUrCEgqTi86?=
 =?us-ascii?Q?WU9y9ZBefhcK0eaqIdiwOCNnlp+WCMyDDDzZAV8YyNQR0Dns2ekol3ymwLIa?=
 =?us-ascii?Q?JQR3osxoUA7u+yRejRL5aCHmCL5HNsp+dd3cX1rCTnJmVz0hbJhpLR/sjkeR?=
 =?us-ascii?Q?rxXIeZQ5RX1LHTOEM6y15x7QNkb3dPy5KoV0pN81G8xTdveWuQ++wk+/1HW9?=
 =?us-ascii?Q?fMiQ4XWsqe4kV6H2/Eq35xzKAiO77HkiiRrHoNJ25eryw9axsAwl3dCaDepk?=
 =?us-ascii?Q?C40Xmtr/qLmB1vx6q6q0JyEUqAftaP3KdeOeVyzubTFDQeBplJyacfotNDlf?=
 =?us-ascii?Q?3u1MA/920JYRT7aBmW7mNJojY11VGAfOIxgHaBb84w3bpmMssuoOf/QNy/0F?=
 =?us-ascii?Q?mBYYpgwP4rQHkmoxgiIoAzLgqkIkNYb5eZqnVN62YE0vW7NNC2ISXwKzR587?=
 =?us-ascii?Q?UVLTxHxn0ZxmjgrNFR9srQUhbWT+n6Whjo3ruyfaw4IqrXaG2ag9XHZsOesf?=
 =?us-ascii?Q?gaM/CRtlXznayR2sg+qyJUOOU3F5weCPvEsTFnb3NFkQ4DLZ7cgefzwkYT9x?=
 =?us-ascii?Q?Cubo8CuxBgMC9ClmxSZmZzo2zLc9GSDP4eozuy0ESeHw/7ZmXAUulJQFYZeO?=
 =?us-ascii?Q?NrleFSis35BDzdZxCjZtqf8eBKwpuFjaPetFuzFOcEKxi3rh8jaHTPInTEYE?=
 =?us-ascii?Q?YI5wfZyp3ijJ6MhoR1WxQ9FaHwB51lqvmKwTH7aNpX+3OAnhqqlb7/h6KUfh?=
 =?us-ascii?Q?LlSy/o3k3VjVqKtLoNv2mmWVQDP7HJQQ1aU90/T0Ntq62c1triMmXlLs3Ark?=
 =?us-ascii?Q?ZdHjJDr/9yccw/GbBtrxhVAfbVQCYvbTe0p1emBgVpXFVPjs173DneyRsfMV?=
 =?us-ascii?Q?6hL0uFT5c3R6874W3YpqYTNdJB7xlvgfdulZdLjUfB99fKdL6SnF+X4TC4l4?=
 =?us-ascii?Q?eDgamGubvi/BhW5jy1Oz9/Is3hUgO0FK2ikKL3T86Xub5UqE8LQESA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+GmpbTe3jAxwZ+p3VZjjB3U0KtJA/JmRsI8F5nojYaAsXSvdJ9bsw/+9ynBL?=
 =?us-ascii?Q?pIF+rV5M8OcS6iTXMEzavzxV83MY3Y/VWd83vLjH1kbAn9XuNz0nq1cmLjTv?=
 =?us-ascii?Q?SF8bVL0sCGHAROHFdq7/zx1fuHjj1E+VbHgwyrqBm0tOHFFzUJrYFsNLMunu?=
 =?us-ascii?Q?y9c1nBw9lBFTS9/hXgmIDt3w2/2a4oFPk0AsEv/0Qj10ttVjnhtlXZxEsfFx?=
 =?us-ascii?Q?UR3deOIvqjBnw0IZV/WeeBahocwtU1b9tILeo25vQ7mj7SRYAsY406kNvXn9?=
 =?us-ascii?Q?ipFbiVNUfAXnnEIFDtjpJS5ABZwwXFXPJpaS32A3Y/Ed7qowuuBwUU3SOpJg?=
 =?us-ascii?Q?unf3m1W6vxW0dsN6BPVOQUGL1WCv1U3jSP5vA+wj24uIgMPrSP5lmu5Wft9K?=
 =?us-ascii?Q?U5T6K/jEcuki4BJO2u0oAJk7C/ABKIiUXVVo4U2jBkVCfhgY+saQDLnFVjlg?=
 =?us-ascii?Q?lEXU6kaXBoqO1dlW/tmU/7XI4ZRqV14KhaY0o0RdtxLmRd3Q/YlSmi4e+jtS?=
 =?us-ascii?Q?RrbUujx0zUeXBnBfJivRpdWBStnVZwtxGvL3TguzzyOPH6n0nK2DRVg31kFd?=
 =?us-ascii?Q?2ZmzasyDjMwsu1TVcmFucajPGSIBVZ5xPkBG3ItzOOFecdqDcMen5o6MYnRx?=
 =?us-ascii?Q?kpnbpw7tyrwdUacMiFgsU2K3Jp8v2kZFYtxABa78lLDjgVSAmL2Tvij1JcCU?=
 =?us-ascii?Q?Bcb1G/BhEfXPpALtWfIZIpvazd6Cxn6CmqKvbk6pmHAzObMPwx4gtJ38dnka?=
 =?us-ascii?Q?P15X8+GyZFksbEK2qTYDFuFj9e/BWXw4oYgiZBEFgMC7XJV5worS4HdUrit4?=
 =?us-ascii?Q?SS6gY5NVvvIYRUqu6zIrbNVIxvjlG2CufHY6X2+/lya7EXiK5qLO07Bur5iU?=
 =?us-ascii?Q?t/N8SgaMUozM+1bcfy5Y5ws6NJE5sX+BUiKeZQNekUAJqKUQQT3wsdOpWI0O?=
 =?us-ascii?Q?Og4vDePzaO9iKvedGk7/DTYkYoaHmutPxnvF0XKGz3z4/USZTUjTNAb+ezhT?=
 =?us-ascii?Q?Q/P9QUXJBAsNEJeZ2oDvADR8t6P4qiOWz85Qgr8GDu9lfmQAbr85pD9BinpW?=
 =?us-ascii?Q?gpoKbVx0qvyBlMehPg/k5VQ/uWQFTaJ5XYxhykVnVOp9FBxqs1Oh8SUV9fqA?=
 =?us-ascii?Q?KJCeXkDYwYPIz2UUo4ON+KyeFgGC5AQNks3EiZwehWw0eoiEhAZ0Cj14xpcI?=
 =?us-ascii?Q?tcImuN/Q9an15B2YKc6hiYAQZTaLh+4sCLjbOezkZvxZmOKiDwyIyvNmSh3W?=
 =?us-ascii?Q?2xfb8wZbJJHtMr+DsrltIV9RnjpoRjU5ngTpHYg8UYPCi3QCSqV1/ugMdrJK?=
 =?us-ascii?Q?i7XMpfFPLKWmW4Fou2OJJTXBi0mEYCH24PU6Qxnu9+yUDwr6H5zvII4RHihM?=
 =?us-ascii?Q?K5ODbj9W+8p2mMhXVQ5o0LVI83M3ZGynlgt+8kPAvezSC2025mp/QkrtoEUS?=
 =?us-ascii?Q?3k8h2LQQNHZXJQff1HGm15+C42f4Z+K+NEcswXAC0Ck0W6/MbsMb5ZI8GnWj?=
 =?us-ascii?Q?94k7cOq5GH98cqqng3SNUZgsD1QZClj7xUTPXN2ACUxT4PvFBUWoeqH1ECiY?=
 =?us-ascii?Q?AxyBLaETFoTy16BxLf2TALfvvyPQaTBjOB6iJQwbHcVTRloAYpd5Hk8Ld3u8?=
 =?us-ascii?Q?6nSk5Ue6KG7VGikEh8Bogq9Vy9j4+S9TS986dBXsLTQ3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d01e90b-2fa4-4422-c289-08dde0edb75d
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 20:02:54.6475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoKjWQBcSGB1K1zCTmf81xusXOejq1zu+SMzK2ooMC03KfYjg9AxseIwGQOq+BVuuhOc1kQxqhAsOHj1fdaIHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5893
X-OriginatorOrg: intel.com

NIT:

Sagi Shahar wrote:
> Move kernel segment definitons to a separate file which can be included
                      ^^^^^^^^^^
		      definitions

And in the subject.

Otherwise seems reasonable.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> from assembly files.
> 
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>  .../selftests/kvm/include/x86/processor_asm.h        | 12 ++++++++++++
>  tools/testing/selftests/kvm/lib/x86/processor.c      |  5 +----
>  2 files changed, 13 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/x86/processor_asm.h
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/processor_asm.h b/tools/testing/selftests/kvm/include/x86/processor_asm.h
> new file mode 100644
> index 000000000000..7e5386a85ca8
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86/processor_asm.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Used for storing defines used by both processor.c and assembly code.
> + */
> +#ifndef SELFTEST_KVM_PROCESSOR_ASM_H
> +#define SELFTEST_KVM_PROCESSOR_ASM_H
> +
> +#define KERNEL_CS	0x8
> +#define KERNEL_DS	0x10
> +#define KERNEL_TSS	0x18
> +
> +#endif  // SELFTEST_KVM_PROCESSOR_ASM_H
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index 6dbf40cbbc2a..4802fc81bea7 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -7,6 +7,7 @@
>  #include "test_util.h"
>  #include "kvm_util.h"
>  #include "processor.h"
> +#include "processor_asm.h"
>  #include "sev.h"
>  #include "tdx/tdx_util.h"
>  
> @@ -14,10 +15,6 @@
>  #define NUM_INTERRUPTS 256
>  #endif
>  
> -#define KERNEL_CS	0x8
> -#define KERNEL_DS	0x10
> -#define KERNEL_TSS	0x18
> -
>  vm_vaddr_t exception_handlers;
>  bool host_cpu_is_amd;
>  bool host_cpu_is_intel;
> -- 
> 2.51.0.rc1.193.gad69d77794-goog
> 



