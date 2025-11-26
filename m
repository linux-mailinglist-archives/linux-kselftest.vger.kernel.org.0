Return-Path: <linux-kselftest+bounces-46575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B87C8C376
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 23:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F0919345BD9
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 22:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D282F0C46;
	Wed, 26 Nov 2025 22:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DIG5tF/l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1745B1096F;
	Wed, 26 Nov 2025 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764196201; cv=fail; b=E1Hbis48C4+GhBeCFqJrSn1DGO9Y+FZt329p9sKJ/K+9CEbgPQNOcjZLrOpPo3QZoCVPqbGOlF7n7COn1fKpJsGsVERmL4UDe/U8AnbSSJcaHayOlLLLQyguVTmiy6WhLoztxq6isOKPDgUECIcWXIWU0epFAr3twdj/In7DNBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764196201; c=relaxed/simple;
	bh=GHBCQKUXop3N/cL7Or0fLo4YLmNGb8R7oPh556aeASQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HgvcJPI+D8unaIbq6CJS1Mz3EMSMnbdYhNTzvwpcD7zotziqhFsWSDa7mZBLy82qCZ2GO5pXbRb1t0eDIp5B9kQwKTawsT9C5ELSrTZ4ibmiiOZ/CiC9WGg6lFslEGGJfKL69MnPmF52pfyVogN8wuXjlYIzor8L9/S3XaTxBEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DIG5tF/l; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764196200; x=1795732200;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GHBCQKUXop3N/cL7Or0fLo4YLmNGb8R7oPh556aeASQ=;
  b=DIG5tF/l8bjcRTPOQGmsJEXP5cQKThAxWfW9r/vq90DTwN1C9Zc6Daok
   o8NE1051IGeSxrOVAuOH5ebikzMFHsNfPE0laxV2LBV8QAUV211AsBaR6
   pl5egodjBwU5oyBj5RdZg2mBA1zEmVhm/y24ks0QGa7G8+0cXmLdy4U6u
   8Ua0EawfH3ez55ba+kX0qB/cSk2wIPCvR1ZrWSGyN/BeVFVnsW+l/JGx7
   rr/oD+av+BWs3K6zkWHDjs73bFCK/ideQ1y+LCaawlqY4sG2odxivkjrv
   YbtEgeF70NPbT/yXRWa2ZiQBgOJzorn57M9+7eRm6iBkTPvdjS0rC+8Ba
   w==;
X-CSE-ConnectionGUID: R+Hxd2QaQcOmKQg5WT2nZA==
X-CSE-MsgGUID: SNOZ8sGYQdm8ECZMCH/C3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66276178"
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="66276178"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 14:29:59 -0800
X-CSE-ConnectionGUID: D+Ck3910TZeVfE6DZ8JyLg==
X-CSE-MsgGUID: nKFsDl6oSza2TcmPpPk/Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="192193389"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 14:30:00 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 14:29:59 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 26 Nov 2025 14:29:59 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 14:29:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JErDBMTmS4df6qOp4NHQPSXhXWqr8WrO2EOCCL2q1NqkbU2MWIrjoTVgSqJAaelrdUE3H3LIlOS+8A+yHtq6VE482FH+vl+JUJTWLWx4iLYxEik+8KpgnnzEq+rStAPRSYzwAVwA4TlgeiP1snhHkcm6By890JoxSOE4Xq00tEzzA+inAvDf4KWtAWg4FXURSb+9Ui/PwKhsQDOGmrPNFf4L6Bh7GCsXpCdjGzwtV7LDytPjtgRNHFKufQ4iIrr/iz8wSbfRwI0Coy+XYsuxw0QnpC1FjByfE63lq4VKcw7z4npZmn5vxShR/km+EkdJJelBtywQ693Pel5mHkq2vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NU913vrILXoVyFRaq4//BfCrzVRwpUcw7BGTvxbVz2w=;
 b=w7GHBzb1F74k2TC0CqrCiz1xgs8/roqKyShsUqXkul6EruHzXpq3Bny6qxd8dyOAAS/ojyUesOPvDcu0h7eoEmrO4bfTTRuN4/rbODSOZYypHTT4uOpax7p/2THlliDsFiX69yCCHoIROAQ+5wLePlpYdymRfF7lp8VCuIqqZagG5TSQ+ZXN7I8FmprsmyMiCDOHknClbVzVEjSWbTyfTlxa4GteWSA6AndK7pJhdfr4cBQDK0Xxu/vhqh9+KeJ7hrXSZx9i246ZMYbdg9fPn/moNI2cPWieBgqMDNTYfutzbe/pAsE1Zk8Eq6Ajysz3No4gQj9Be4ygiucgd3V2WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by CY5PR11MB6116.namprd11.prod.outlook.com
 (2603:10b6:930:2b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 22:29:55 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 22:29:55 +0000
Date: Wed, 26 Nov 2025 16:32:29 -0600
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
Subject: Re: [PATCH v12 08/23] KVM: selftests: Define structs to pass
 parameters to TDX boot code
Message-ID: <69277ffdd6058_9480d10071@iweiny-mobl.notmuch>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-9-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251028212052.200523-9-sagis@google.com>
X-ClientProxiedBy: SJ0PR13CA0185.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::10) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|CY5PR11MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: 92b8a888-5b0d-44b8-5c7a-08de2d3b5312
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nKd5eZYAMZT5GiUJTYWsMbos8KsL4u4GM4XOeSsDEpDwDAYYXr1nwZBXxOg7?=
 =?us-ascii?Q?bj1ImnW/BtTZJzraCf1JYXbTcwxFYMNCx8at1htnqywf0w31Pq6pyOH7VELt?=
 =?us-ascii?Q?6onTekk34JZmWg05CPxeiAeJQrPaZnBJfmHcUeGxW79YHiZYJ0aD0XQoeVcH?=
 =?us-ascii?Q?7ht9AfnpH1DbDgfem/1Mc/sz8cic8ZOmcGYUwLttz+y7kp6sVshqUfYIWI2j?=
 =?us-ascii?Q?6c3I9WJyghduOH0pzh3sI5WbwGAKEuOvIbFjiZ62Sloy+J6CdlUEf3hya+dk?=
 =?us-ascii?Q?o8R2JNmnLBnztAKqRtvbRiWQ9czSOzog254FPvjcT6E9VBcpyriUMyyCiPus?=
 =?us-ascii?Q?9+KaUKTw6OuqV4ATf0ekfp7ZckQHv+Nxymx6dN7TkGpne5LjWPLIiDJKDHk0?=
 =?us-ascii?Q?bX4ABPHk49XSFo7t2JnSgAdscZxpE+if3YNN7N+KjprD0j0T3b3jutpvcOcN?=
 =?us-ascii?Q?QhH9/jYogd/l5SFfRjDEH9CjDc6Vjzx4vJgwRYc+35s2TSFdR4yhpEj48TrC?=
 =?us-ascii?Q?6wPujIiAcxsNvITb3F5iJ5ELvTQQ4uK2CtmhAZ/qOOWJbwlqfFm6xkB2Iqqg?=
 =?us-ascii?Q?S+u2ZOHf+LZ66/jwfcuaZvN+caCO6hnSLL8B8WYRK2xzCUXCveKgWhBOrTjE?=
 =?us-ascii?Q?KfRRFi6Kmj7vkKjpGZ8TTjeVHqhcksrjxA2/N0fjhLhcO0uUdZ8w3Pn8oUjo?=
 =?us-ascii?Q?w+x4ZfMJe8W1HdNLrvbEndKA/UP1KRtVt4lMKiHhh8qRzIF0cRLZ6is1AHP9?=
 =?us-ascii?Q?FR8wCvjZ06e6WCdkvOy/gxCqolZp8aUswsSbmHRwxOgeCMPSfaN1Qh5XJVns?=
 =?us-ascii?Q?XKvy2d1oDkppVj6mv8vB87EN6PQhjx4WZevSD5TOVIXwwkD1h9OdL5LL9g5A?=
 =?us-ascii?Q?CFPIHfwpVB/hm2v/tYFsb7vURdmyXqB3Qu2je7rTa5MuGnO6iLDdx/phhGtD?=
 =?us-ascii?Q?AHWfCJCrj0kl0PxS5RSfeJIREpx9QMCju+qwddDkalOXL2JtM90e1Kst5+hy?=
 =?us-ascii?Q?WjkfW/UGUUs6xWE2GefuGCWcN+nSnY9D5JOtubWhaT4RqKEuraAqs04kl5O1?=
 =?us-ascii?Q?47k4HvtBvThFAJSu5YJsTW0YQ7aGmpOb2CNk5LogaMJPeVNPbwKZeKI/kkNX?=
 =?us-ascii?Q?Po0+dLZsAX6jPfuXf2kvyS61pELzsb48XFg8NJk/qPOPGedRK0wUq98yRidr?=
 =?us-ascii?Q?edNOaQpN75ryZdX+AL8WpSZMfa7ZiGRnLQQgYInZRyYgE97tksHVGiCXIGha?=
 =?us-ascii?Q?0XcxkE3ZkB0ttWjsBTWe+LzA4wPdKmjg7nMGzFSYyQKJi3jRgBO81qMz/52p?=
 =?us-ascii?Q?ubkUQSxt95yjCkVtezXl+lbJBN16Z8p+77z9g7Kx3HDGnUstVNZzSqvv7GPA?=
 =?us-ascii?Q?mSp+UYT3HHhZgG0PpswUbn8rCXIV7o4uUMdXXLl/B7fKJ9xQje+wjBDqzwQy?=
 =?us-ascii?Q?TjdCwDmq0EihEFw1aVkdER7jAbV1RmvvQDr+xhORcN2cfX6xzGrHQCrRKJzd?=
 =?us-ascii?Q?Em8n8bk0y1mpNOc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jUXKUm+wKkO8tA+qfKc7farnO6/foUCWApwDws34745L6GIAz3HaEf6MIJGw?=
 =?us-ascii?Q?nSm2W6TycKdxgnpquiA/RSYK9mBFjMSG6HSFrnrY8QO9Jbdvl36+bk4djy13?=
 =?us-ascii?Q?hKNIXIaTG7kuu6lOFCrdT7H0R3b4hmJuWwAb+f+xwtYY2znfBwkRWeGerH73?=
 =?us-ascii?Q?7NrIa2uWhYDo4tes3Dsga7GFkEA2Vp/6J3bozGcrTC+V/BAFYp23ax/z+KFy?=
 =?us-ascii?Q?5LJW2uxRFHkYkPxeMl+Lp7bY5NE8D74o20P4eQ6luDqPtWlUO5uBcaD5jVbc?=
 =?us-ascii?Q?ZdI87qlQnJ8BbhpqOM8TAHoEKYwB0IodHqn86h76h2Zw1z70X+4uIDzQHw6K?=
 =?us-ascii?Q?1lqfhvaDal8BJKujQvPfPzdAj59KfIkTY1q3Dx9ORDeBA6jZQoG64ZpBrb7L?=
 =?us-ascii?Q?RcN5vchDDxzePqaF3O5h+mAy7G3r8f4utqeP6pPxkFMEeGHzbW5XyCSE3Krj?=
 =?us-ascii?Q?pnpOIXfQ4W1JMKf/fc+QbBj4SfkUGgBQb1kXi4PIwDHt/R+RCw5p7h607Vp1?=
 =?us-ascii?Q?actnXLFWWIf/aiVIZlnH3b3qHtAethEgGAU0BTDXqP2LHeg9ExfestAC6VrL?=
 =?us-ascii?Q?fXEDSi9wVf7Eq5cJCxpxsAru66M9rrDtjUGM5IlK7pbWKrlDxPSZAocOrd/B?=
 =?us-ascii?Q?8kD70pB/JegrZUNoz/cUavquJz9iv+CIZFuMAsGh79pE2vl4PmFxuZpt4rYI?=
 =?us-ascii?Q?dWm2WpaJ2xzno2TyAMh4ZE4hyAVRMtp6hdCPKhmIfxSqV0V0u2VdTkXugpxh?=
 =?us-ascii?Q?ocmOcQGqweneP2IikX4DIhmarMOhcHE7+PHE/F+RSOHArJoVLldPPUfkfgl9?=
 =?us-ascii?Q?KYw9CJ9vTV0/5AYTN1iuZ4hwB+JEM3LiquH5G5AAkB/y54u7rSjZ712Sa+yp?=
 =?us-ascii?Q?cPMn73Y2oFVzC5L4sv+3frZ8dCU1KQV2d6PTIogFXpLWTfZHBkqyCepxLIvo?=
 =?us-ascii?Q?PBF9Cz/AZ1qYEUxsmWKVEOWbokJ3HzqexklZizDrAaXusfprP+7UDe+bs7db?=
 =?us-ascii?Q?5r7o8VnUnZV4q+kov0WVK69XwXARa7bMcVxFu1pOcXaRIq1izk6XYkZoUQKF?=
 =?us-ascii?Q?C8C1fQRPYu2lC4Z9BxTEfjrYEq/iJli6k4UGWywc5a2tu03aVtNfpzMs9D3J?=
 =?us-ascii?Q?9MvnZDwBwrw3D5cgaHGps38Bma4wrx9c9BqK35+h82BuwmcwOT2/CjSR0XGv?=
 =?us-ascii?Q?RY3wSn00ry4PKDh/+aaJ1tGOvBO+3J6v88cQPI3h90mTiCE4TjfTMVEo8ldI?=
 =?us-ascii?Q?OLfMvY7A812vlNgWR1mVBpn7VY0qoeIsYRMUbn0u4Kf5QDzRxz8he5RiMJiI?=
 =?us-ascii?Q?1pdVUw7TX1YN+e9iA53InZtxNHiN8f0XChbrDU0GJqbZZMeaDtixEu1GnltX?=
 =?us-ascii?Q?O/VzvG19PDk5IXtXRZS0UAhy1UzvhxJjTkoAeJpwYuIAlmPT0xSU7+qmRVCC?=
 =?us-ascii?Q?D5WILXZMVMIp2pN7iRPElSTlv1rjreMsk3TEOQCXR3FfebRM+X7+ttaGmoQu?=
 =?us-ascii?Q?CQ3m1knequBBNZMJKgKn5CC0VEvUNaz69taMMUh7i3ahtSDYDxtlK6SPkCLl?=
 =?us-ascii?Q?S0aGbf25jWRUUVw/3bOVB9n1vOxqAbUkTCj60wtV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b8a888-5b0d-44b8-5c7a-08de2d3b5312
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 22:29:55.5871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PpM+airPc+qN+s3pJtc3nSm/vrJT/QqreUhRXO74YbeKO1iTiyE+8rvShXMF3ZFj4F0K71yuDRYH4WvYz+vUvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6116
X-OriginatorOrg: intel.com

Sagi Shahar wrote:

[snip]

> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 148d427ff24b..5e809064ff1c 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm

[snip]

>  
> +$(OUTPUT)/include/x86/tdx/td_boot_offsets.h: $(OUTPUT)/lib/x86/tdx/td_boot_offsets.s FORCE
> +	$(call filechk,offsets,__TDX_BOOT_OFFSETS_H__)
> +
> +EXTRA_CLEAN += $(OUTPUT)/include/x86/tdx/td_boot_offsets.h
> +

I just noticed we should add this and tdcall_offsets.h to .gitignore since
they are not auto generated.

Ira

[snip]

