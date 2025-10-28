Return-Path: <linux-kselftest+bounces-44186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B011C15438
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 15:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D241897C36
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 14:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7203025B1C7;
	Tue, 28 Oct 2025 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IVVFPWTI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A92580DE;
	Tue, 28 Oct 2025 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663228; cv=fail; b=mLe0HlIujNlnxlOnXpjh770KWTS15pjqCP1WewX7cBDsOM4Qa7CbAoyLcRUNgP+3EdjK8erX/sQ1IHOJ63Ss4RVDqY0Q+DVnmShkqVA8AxuZZ/STjNoWO5C9l6hjFZxvfu5I1z8/jsXQAnLsPmyI1rrgMQHwCJNCYZ0kMefhUeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663228; c=relaxed/simple;
	bh=ojsshZ/SH4Woesio8hzrJffNLATBfc1Wig+1YZFcpiw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tiIUuPMf+jWfBtgiYZtyXue1kuWJg9UfgWBed4wYxoBepm/azEPa9UUGcm8LWluc4PqqW1frGA3JQVINTsyW40HjyoGFERF5YI/0SHs5xjd1XNdYWvi95e0/L2EK9hVRpv09ikNIHHS915BoscgWJeBV2hbeKUjCjXQRpGq9Jc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IVVFPWTI; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761663227; x=1793199227;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ojsshZ/SH4Woesio8hzrJffNLATBfc1Wig+1YZFcpiw=;
  b=IVVFPWTIa0X2tXC9bc/+v3cFzRf+HPEEf74ERU02wgcLT37mBo6GSxxM
   e0TjUOhXpI6+mAQQb0j1jO7Js0jTiGAKWc6WfZLAZCRvvri6YDdtHkwiF
   f2M5QCQeu2jbGQGp768vizuDBcb7wx+eYDd93ALWA+6zQf9oGuUI5RXR3
   qG+VJ2PA1hyJl4aBhEcvduQRc7q12oMqJq8/qC1+zdpZscKOVpf+USJL2
   An4hDIi55SnpAauFyNJOlJUxvUftJDY4mADqN9yVqkL4nWsz0osy3rBTG
   k9xAuDE7G2vK7a0szQ/w/Upvy7OBD1q9Pl460k8qOQcrW6C7LAPqgHBdY
   A==;
X-CSE-ConnectionGUID: VI8/LvjgQsi9j1DSs/0TOg==
X-CSE-MsgGUID: vlP4G4dPRS2beIH7NpuAHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63691697"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63691697"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 07:53:46 -0700
X-CSE-ConnectionGUID: Zbw/unEbR3iXmVtvo57+0g==
X-CSE-MsgGUID: T5ioaCuMRfm8JXa51eC4PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="190556531"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 07:53:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 07:53:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 07:53:45 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.68)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 07:53:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykxr7jVtGPExwu4uwcQRVXDWGNXTVvjXLQmH9fnYtQpljTGCbRIuAUr92V/lp4cnqJC1nxi8eDRdl5NIppRytzbHFrcIzWL9bvkMzgi0OBULIHOAv6b6CBY6/66Mrctb3mnfp5Oxn68xmB8mVM+95J75tS5UNs3/d6JD2eCpeCCpHf1lzPj/elXdMPIHPDnzILyIVYZwVV/8MMravGSy/b87XYokQmDzt/J+9ecuSquqZ7Dn8mhj/J9eUQAVOhcL86G0FGCHdnYvOg/1+4NM9217HXyV0LRH0TO0Bi+GW8DIFyXyGX04qlbjc05FavdmaKgLc8bMCeawHfnTPdRaaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMW+VmMnyNDEwrLbbuJCUIxu3JUeFnMZl6dA7RhUbQo=;
 b=bqW1e6xNPKvhHi9MeTLjt8KGAbLfdbrUpj7jtOGKQvYmmht8A8FCrONld0Ko4zobC356hNZcnbBPxw4OFUQZjVxf1sR5mgzyXQBQgsQWT03c8YM/yzeTQUYIStN98Wly5nIulKdhWZ/s86pY1ao85WWvNYeIF3xHnz3Rge3kQFKrbQrW1SOl1Bft08MeK9SJJSE3NkisYYSPjn0eZGDTHW/8UjDLQoTZBg4sylOi4+jWlaIezPUWaJOfJ44vHWf2hgIaQP769qaIClRm6hgvZUvhJjV7MShBFIkqjJZcZOr2zaqMkBSAztaNoAQBGmweAEeQwUNy3ZtNhm+26xzP3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by PH7PR11MB5795.namprd11.prod.outlook.com
 (2603:10b6:510:132::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 14:53:42 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 14:53:42 +0000
Date: Tue, 28 Oct 2025 09:56:02 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Sean Christopherson <seanjc@google.com>, Ira Weiny <ira.weiny@intel.com>
CC: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Ackerley Tng
	<ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, Andrew Jones
	<ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, "Erdem
 Aktas" <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>,
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Chao Gao <chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v11 21/21] KVM: selftests: Add TDX lifecycle test
Message-ID: <6900d982c71b8_2047f31001f@iweiny-mobl.notmuch>
References: <20250925172851.606193-1-sagis@google.com>
 <20250925172851.606193-22-sagis@google.com>
 <aPum5qJjFH49YVyy@google.com>
 <68fff9328b74_1ffdeb100d8@iweiny-mobl.notmuch>
 <aQADUmrDSRAydBhI@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aQADUmrDSRAydBhI@google.com>
X-ClientProxiedBy: BY3PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:a03:255::15) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|PH7PR11MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf99407-55ba-454d-ad60-08de1631c952
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v0vrWmlfrIRVZ8B64fdxszGoIWuRvDBaH9bTD032SXTCapTeb2raF1ILCm82?=
 =?us-ascii?Q?8a5RU6a7G+5cmCj7acym3DELRRB1l0oInYaA0WWj8n8Y3SKI/ugXmPtU0ITO?=
 =?us-ascii?Q?/NNzD5LttuXZakZf5M1bd8GOERIm/fAT1HDF+LYEf+5z1JxJtFoyNKhimn1/?=
 =?us-ascii?Q?DxRKA77NVxAq5un7KRorYDXEIbw+0hNSklkdSUZj1iLnRb9KdR6pkWg78Imm?=
 =?us-ascii?Q?MMndbpDvoLrRWvwFuuVxUtFwVkmT8icgM+UKia7gD/PGf5wbbYuLwkPPtofC?=
 =?us-ascii?Q?N0lt68e4VvfNNx8mcjhsbi1a1/fT9D953yznmxq/Ut71wUePzFPNtr8FDkQe?=
 =?us-ascii?Q?zGAtLIRaIKyIf+VYrLnQCKHpVu/dlS71RSh8zBTxEWielU6S7dAR25wZpQA8?=
 =?us-ascii?Q?MMrWKdL1lVXhEWtAYf91+KMv1jExlOVWO+WMEELTvAe3RQhDDLoPenQ249Zp?=
 =?us-ascii?Q?iYqIaEWXcxYuHqK0EV40TVopMSTeaotuiOgZBlwMRws8DrjtyNFvW5lkS7ah?=
 =?us-ascii?Q?L4lsCluAvC8xotg5KioiuED6QJu9Y5iD7Ba9KouzKlO38WBLuvjbzY5qHnBT?=
 =?us-ascii?Q?lmpvk2mEotmor2st5yz6m7E/mNeOO6KILY8DFPTElYSzFodYX3zyRRErdhhE?=
 =?us-ascii?Q?A5dfm/HgXAuYq7ZPP02bwutHvZyB61lQX6fZUAiw03B2bvw9+5wxSTzLrKzm?=
 =?us-ascii?Q?FFydlt7QwKC2RKGcFPAnUTHlzGQJZMZeR6XhqkNkEvIdtLKF/qsrKrnu6U7w?=
 =?us-ascii?Q?o9UR2ovTCCKYLfis6P6K2IdkJJe78GSYX/vp03upy5HBBk5fzLVJuCL3Nn4a?=
 =?us-ascii?Q?scJNihRUKvUGNFVwVmwo64HsTJQpnZbZezQc/WzVuEkS40gUD0Eh4xmhaslZ?=
 =?us-ascii?Q?GcYW+Z+JzSORPeyu00z6OLyrCOCTouMD4cqjJZYjiNFDPa40bLVNzv62ken1?=
 =?us-ascii?Q?nQIdxujIFp55GbGqOpNkCrgjF6OIREHlJTiDkNVU0Kt76YMLwGK7RH3V6phj?=
 =?us-ascii?Q?QxPbJZijVyd01aUIsXbiQN+yzyeZcRZ90gkJJQ/lyPqqVoDVV1MbZVluw/8E?=
 =?us-ascii?Q?Vsoz0om7ynioN38lRRJx+1XGyoTs74+vuBnqtZNwe6xpl2bym0ZtXDe/JEtR?=
 =?us-ascii?Q?wFmu3AtAWKOD9s0qIrsKtpoHPxfwchbrosxCvmrmU9rOaSZsbLLc4MSfLTQr?=
 =?us-ascii?Q?fsfhnD2kTKhCgbaBdN28c1yqErh7MZu2ootIAcOiswAD4hg630E9oMJOOyix?=
 =?us-ascii?Q?//rmkSvFwQFDuTF5SGVDNz0642JZC0XFQHgn0zStM94mYtC51ZHkalHsdqmM?=
 =?us-ascii?Q?B2bPgUEnu/Wf1JPTkD25rlzp/hE/oMOPj3FXTWOFLBEEsY0uElw44Gtldvc4?=
 =?us-ascii?Q?+b9LH0Au20hm1JaW79OXTJkDzOweqJjndl1fKB0HIxavb8KkYAa/9BouQU1M?=
 =?us-ascii?Q?fUNCMWNVOW8mF+7qCAElPurAxIPV6MjQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dJy8CuxT84R9BzuSjUJwT5Xt9F2DnVEJo4mYmor+5ARS+Ou1YvYqnT0JPbMY?=
 =?us-ascii?Q?w4dOjaQb4C8ut5UMD4WKLqaedQEppT1Z1MaEwqrYR5ywv3zzG6Eq8AdiLiMw?=
 =?us-ascii?Q?IfnpSPqsF5BitJbVyN2zIwc4yRcWzGb88yzPUicSQ25PqWVDdmB/aM6mNY3x?=
 =?us-ascii?Q?6HeRID5Q1ZmN9+gU+uhCu/U5PJ4Bv4pNtb9IFgEsKJvqETjvnh83czY8m5dl?=
 =?us-ascii?Q?GA4+D2yoE/UK/sJVJ+W2+UrYNenymJ4nqj/e/7KUQD0457MJaFgtUbqnfhSi?=
 =?us-ascii?Q?fwPwUm2K3wXqCOzx840K+drh0n7zQnCAVuEO7yahVf/heF0ptk/03sAo4+yb?=
 =?us-ascii?Q?jttFhDXtrigrO8TSQKSKvLUk8y4FpkQl231G9HbY33PycC0CHh/IgV06we7q?=
 =?us-ascii?Q?pOMAePlwCWm5frnxfeULR+1u0Sy7O5JH9pb7ULzh6IAvzymYlc6yE12vlIvk?=
 =?us-ascii?Q?pAK6XEA9ceCE1Jqt9W7TdxvQkjgoc98DXGUQp30QBiEnhyUqgfIc2c9yEJ6L?=
 =?us-ascii?Q?hFkCx+6baGLI6aF9/8qRWmFye5SROuOfoCDMHkPth66SntUIuHX6w1Gh/cWr?=
 =?us-ascii?Q?eSqst8cI19GK18PNXN4tqgbf6B+A/C1lXWMmxmWdWcN/dfoAvvUtM7R+ca4H?=
 =?us-ascii?Q?F4T1qgZX2W18zo5COWHbUipvZF9NpY97Ein5XtowOLBhcaaUwIhmENSTO/19?=
 =?us-ascii?Q?0vy0ETCMCkS7/NUEBpWnjlXozgJZlO8aD3WvCj0Cu2uR2qKSDaGvZKXLZDIf?=
 =?us-ascii?Q?DXs5G0wQidk5wilDdPtA1oh10fp3+lW0E+fCZErLry0PDDZQjaZYVJjbwfap?=
 =?us-ascii?Q?nJK7T8dpsf3dhga77G/O+Sndy0x77pkK3Vt0KEIgvF59Kx7a63YPeQbVvHIi?=
 =?us-ascii?Q?O2mCM7K8/G9WA3UaOAchghcC3tHk00t9zXsiR7O41Z0AG0e+8YekXDka1HXO?=
 =?us-ascii?Q?Wsmm6RImaFl0h28uVjpfjfdovMM/OdyuE8OZrsKJM/5luAzN04q+IxSuN7OL?=
 =?us-ascii?Q?DXVxi30CZgtm9x9cCWO/CkQn07ufx9o/nMhNektAj7JtAUzkl2dH59ckDZdT?=
 =?us-ascii?Q?z7qTF0TI74Wq3zXA8y/Yk5PzUw1rUSCG+VdF60im1/dl8tCqpoxSX1pESk//?=
 =?us-ascii?Q?ybPXtQXHjCSa+FesP6nffhVUM0e780mgRO2YSZ57Xp0b/b3g1tAuEDWq1Hd3?=
 =?us-ascii?Q?J0yb7d+gikNcNx0ka49Mt8RJr09VQaGPP/Yc7bB3NPzkKMSXtWzoi4gurNVY?=
 =?us-ascii?Q?GETZJa/4cfR7bVaDBmdabn/GS0oGAmxsdt6js6+b1OW34IT06JKYXxsFnmAd?=
 =?us-ascii?Q?A2kuLg+4nLAZAJbEYxSZOw9QwBPSR/W9bsseeYs7LmhEJbcItlbe0OdKrPv2?=
 =?us-ascii?Q?0eg2DW+qmlVj6dwIHw8XoW78vW9LupA17dbnpCLFXl4zBEeHRdnsaub8Y92h?=
 =?us-ascii?Q?/1myozCta9keM20ISNiYQ5Jfus4CJvyERxOWibURnND0dxMMTTv7lid7tQEl?=
 =?us-ascii?Q?8tElhA4N9V4BtW0pwzFMvMvv1jNwedD6mDnkt3UNBagHo03zrTlq605iazxE?=
 =?us-ascii?Q?tSubyMn8YakAcm+JfBy9UJAMwOmXivMzbEP6/lUC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf99407-55ba-454d-ad60-08de1631c952
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 14:53:42.2618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nl5GtTRSseaXp+WFYMDvfBT4K3HrVSoSp59iTxlQz3PUSFWH3VjlzpCPmFkWsJ3DjZs7FEB8kVsVWP3vhfeavg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5795
X-OriginatorOrg: intel.com

Sean Christopherson wrote:
> On Mon, Oct 27, 2025, Ira Weiny wrote:
> > Sean Christopherson wrote:
> > > diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> > > index af52cd938b50..af0b53987c06 100644
> > > --- a/tools/testing/selftests/kvm/include/kvm_util.h
> > > +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> > > @@ -210,6 +210,20 @@ kvm_static_assert(sizeof(struct vm_shape) == sizeof(uint64_t));
> > >  	shape;					\
> > >  })
> > >  
> > > +#define __VM_TYPE(__mode, __type)		\
> > > +({						\
> > > +	struct vm_shape shape = {		\
> > > +		.mode = (__mode),		\
> > > +		.type = (__type)		\
> > > +	};					\
> > > +						\
> > > +	shape;					\
> > > +})
> > > +
> > > +#define VM_TYPE(__type)				\
> > > +	__VM_TYPE(VM_MODE_DEFAULT, __type)
> > 
> > We already have VM_SHAPE()?  Why do we need this as well?
> 
> VM_SHAPE() takes the "mode", and assumes a default type.

Ah yea.

> The alternative would
> be something like __VM_SHAPE(__type, __mode), but that's annoying, especially on
> x86 which only has one mode.
> 
> And __VM_SHAPE(__type) + ____VM_SHAPE(__type, __mode) feels even more weird.
> 
> I'm definitely open to more ideas, VM_TYPE() isn't great either, just the least
> awful option I came up with.

No this name is fine then.  I got dyslexic with mode vs type, apologies.

> 
> > >  #if defined(__aarch64__)
> > >  
> > >  extern enum vm_guest_mode vm_mode_default;
> > > diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> > > index 51cd84b9ca66..dd21e11e1908 100644
> > > --- a/tools/testing/selftests/kvm/include/x86/processor.h
> > > +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> > > @@ -362,6 +362,10 @@ static inline unsigned int x86_model(unsigned int eax)
> > >  	return ((eax >> 12) & 0xf0) | ((eax >> 4) & 0x0f);
> > >  }
> > >  
> > > +#define VM_SHAPE_SEV		VM_TYPE(KVM_X86_SEV_VM)
> > > +#define VM_SHAPE_SEV_ES		VM_TYPE(KVM_X86_SEV_ES_VM)
> > > +#define VM_SHAPE_SNP		VM_TYPE(KVM_X86_SNP_VM)
> > 
> > FWIW I think the SEV bits should be pulled apart from the TDX bits and the
> > TDX bits squashed back into this series with the SEV as a per-cursor patch.
> 
> Ya, that's my intent, "officially" post and land this SEV+ change, then have the
> TDX series build on top.

Sounds good.

>
> Or did you mean something else?

No.

Ira

