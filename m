Return-Path: <linux-kselftest+bounces-8434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF108AB0A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 16:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73AC1F24BD9
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 14:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AECB12DD93;
	Fri, 19 Apr 2024 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e3qNCaqP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E3712D1FE;
	Fri, 19 Apr 2024 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536599; cv=fail; b=qqhxTvJ5hulDPOdfjgdpdpGF1h3DRNbZWgWHjOa3Y50ox1w+t/g9xJU8MdhlGSNxUCvDvzSCSdoGixYpTLMK1n/QEbO+ObfGar0EcGpuHCfCTVNqrk9kykKj0pbOUQaeieFMv7ii7SWeX5xQN7CDjBhKxvqkJwP+S7y7CuBkerc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536599; c=relaxed/simple;
	bh=JMP20GAUWmPV9I03LcIelqciKjb5pfL1AEuuMHBGFJE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LnJLnK3ow8irc6ot/yWMhnu7YJdlMU0ztPtEtwd0L3vWGrPbXiqUc7YCrTYlQnRhacOgzgiRy2idSQuukoBAKQudhDgsT5qdm3PBZCSUer07EZ3zkVmHjpSDMiW3A7ds61i6U+l93dZoBHAmWaENnDticBlidQWH3ITMQFDPJ3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e3qNCaqP; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713536598; x=1745072598;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JMP20GAUWmPV9I03LcIelqciKjb5pfL1AEuuMHBGFJE=;
  b=e3qNCaqPtx+KtbRVBxXY/B4vuJ1itJBDMHHfbykYIlUYTEOA/BYYuG3e
   2O+o8f+JHEX9WVQWrTgm0ojA4aFfRBD8y1puorvu7nQprcOPfMQ126jxg
   RMhXut1l19DVM+Tf1nEyRkBnbltU9Rtdau1vlTr3k9C3UeJJnzmf5JgTK
   4v7nQrrZx4C9d4Ln+xqR82bJmGPZGgn6c3Cr8VRzcZIGRJzvQFsLD7246
   rbjCxT2R7c4IePCS4ZMVwwdni8Ujp8XU3OkfqOB6im4z5avbuhRTPLtzF
   JxSBfrp5GgIOGeesQHn565k0mBrPpsovvxXZ45/MhuoyV0YEIWZ6VAI6B
   Q==;
X-CSE-ConnectionGUID: Xj4n+/gVQZiAI1q4TBXSJw==
X-CSE-MsgGUID: L8po+NGDSxSMY643oTvAqw==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="8999488"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="8999488"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 07:23:16 -0700
X-CSE-ConnectionGUID: X8eD0m/IQMKoaCGx+svZUQ==
X-CSE-MsgGUID: 7oFq8H24QqyHz1In4A/OtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="28123889"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 07:23:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 07:23:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 07:23:15 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 07:23:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdtKek+OaG0mFgAZOTlT/oFQ12M0Y7K63EUgebFADWg+WRjUKldeObp+MWw7nRNeHePYy8GqZ2bqRvxPaz/u6fn3uzFUD1Bev9iNHHzIEPFFMRdW/QkeobcRmrKJXfSLE5BPu4zpH8EthqfJn7mQc7OBTzIzlFCLJ8wJ6BZrHk40Vn7yJbHxFXIzvA8vFkttNcOTptXEC1IqEzaj5NQ4tZE9sK95yY4Bi50nzSisvUTjywDsH44AVmfllwGYXSjsOwixW6PF6V2Meos3kn4zy8HWY68y0FZk+dKgVJZo+jKqh2YJ87nFv7TYHhYwpmg1lAV29b6OBn1aYn2NlxpsrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5H1MFBKUvGGZY7QMKCPvgTVXxrWvINgVdoI5NYLig1Y=;
 b=GZbkuplMjHgVj//UeYpQ0JbrdUmOQnz253LEW4q9Y+A3/hd//zCEzzQ3Wib9kFFDNUKjt0wmj+grlSPN4hy6f3GPPzhEm5KNNh684NuI08hLK0PurNyWCjdUD9j35QJTJMqIOWts2/vObpYZK+J80jKEBRKC/gzZchcPGPtuQtI8DqCexDoxz2ANdaU/spqL3wY6eA4GgPt5qLOs0r9JOVhxPvQcQKR1lJhqIslG5JjKGOJ7USbGY7gDPXg//qDbpfzKZ1cHO93oOFo3/BMzMYu5X7uPDdWu2r7POKsQu6nve3/bVhSC2sgLREQDEf6wk7bdbGpCy9txzSqzM2McIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by SA3PR11MB7627.namprd11.prod.outlook.com (2603:10b6:806:320::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.14; Fri, 19 Apr
 2024 14:23:13 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e%4]) with mapi id 15.20.7519.010; Fri, 19 Apr 2024
 14:23:13 +0000
Date: Fri, 19 Apr 2024 22:23:02 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xin Li <xin3.li@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <corbet@lwn.net>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<shuah@kernel.org>, <vkuznets@redhat.com>, <peterz@infradead.org>,
	<ravi.v.shankar@intel.com>, <xin@zytor.com>
Subject: Re: [PATCH v2 09/25] KVM: VMX: Switch FRED RSP0 between host and
 guest
Message-ID: <ZiJ+RkHDJzalqN05@chao-email>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-10-xin3.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240207172646.3981-10-xin3.li@intel.com>
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|SA3PR11MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: afc8f0bb-fec9-446b-f706-08dc607c3f22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005|7416005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dnSkaHkN3zEewrdcB7avWETtcJL4Bo5RdlVojswCGVEc+Ljw8hJ5iuP7X2Gd?=
 =?us-ascii?Q?0pMHUsEpop/eOlA1LdcCriMQghOQWSkz58pq4WAm8bI/W8nu1qzEr1i0fipn?=
 =?us-ascii?Q?kkE66mjIRbdo8zwLMGslmtLxuczBnHnl+JbL2/DVyLJq9kadoc34u10BJASZ?=
 =?us-ascii?Q?GZ6Zv9h0QvEW62j+wJwuiTENM4SfSVIVbbpAFWqrZ5+3Opk2jgcXuahW7rF/?=
 =?us-ascii?Q?HNwuuEbB47ty8CHONq5W4eGCCzR8yIKiXWnl9UYrT4etCBDqAnWXI5m8GpkE?=
 =?us-ascii?Q?hrE9N+Tf6vdN8aKpfSG/fdcEWJbIDBwP9vM+s3AROli5fbbQ159qcXxdErez?=
 =?us-ascii?Q?k80hgiv4JnpXPtI2zfWHHDxPQLh65TYOe/edHiXfjqQuk3vX3AnZzTZnIHd9?=
 =?us-ascii?Q?0uY3RWzu4ZL459UM/hhASbAc9cWQjzHs1VKtzLMe7tC2V7+PWdAvZgAgpjdO?=
 =?us-ascii?Q?VjORuxV5geXzo6eDqwQAsaTvVpWueF3s2L9GwWPx0EorIWZEN9QHPj5QJ66L?=
 =?us-ascii?Q?zGRVjExGBkpER/6QzqGHVYeUs+VbX3uhJPXvC2LWRImVY94Ep72eNVt9Z1eh?=
 =?us-ascii?Q?b3Cga/STSZYdE61pdtJqjSYGaOzcOzoRJGjLrkDm22xklw1l9e1CJF4RVoa5?=
 =?us-ascii?Q?duq4wPvr7QPz4ftUHnYGtKI6NgblREQsnQLgNg2KFJFK8T54ohVhQQxUqjgT?=
 =?us-ascii?Q?0RPH9a56SZRtSoA1sV9USiUq6hDIDEs0rmd9BCBnGkk/Nng683iPSgEdwuTB?=
 =?us-ascii?Q?TSH0AroLZAa/feXiLuvQGdmlIoCmFCkVDfbC1qmQQEi615vUsiI14UMPrCRg?=
 =?us-ascii?Q?j9sbtT8jqGDrfKcGIxXyn5iGOmwR01SWmQzWFJJ9eYzaS3pUAo3690cGoeq3?=
 =?us-ascii?Q?tAZlwxVSEPvIzsEdqvn/AcP/Ii5g8BROXNJvQsebJ4l3cGU1qOzN5OYwXVEo?=
 =?us-ascii?Q?dDNb2dk5iygVt4OlPbcHKoqC4JYM1ChvPnhClNi8TiUF5oIU2R4gVLRGOQBB?=
 =?us-ascii?Q?EGj8X68rgsVoX/gG7QJAfV7DtMct2Tm9g4fx6iSGLyjNtExVLpKp9SCDRDtV?=
 =?us-ascii?Q?ozSCh7QifXkMqR53K0+5rFi71pNhpr0L2fRICFF1s7+x0DCB6w7bumQkNC9C?=
 =?us-ascii?Q?PUGHn6TKQ5kxfWsgXsQtXAWfEOuMOjYGUgbgQFVVFp2yWOc+A/knE7XBoKge?=
 =?us-ascii?Q?WjyaJ2gaW7IfBZ7U+t/NmyyGUtUaPspBqM08f3H+neTQXZ3x2opi7SS8oCRy?=
 =?us-ascii?Q?kmmNGjBok9zHMHB8WuzSQ+DRjXY6wFTJwY2OAD3PiQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hh54OvC5sfi6XgVpwMwUWvHc9vsfnPtsNezF5XX1JpBYpeT8ocYhRQtU/7F5?=
 =?us-ascii?Q?aXDtAfEFbREzwWzxVTX63BZmiQ0DptL00XUhv/ZSvVyzTWctsFdwHgJu5+fI?=
 =?us-ascii?Q?okYttAEa6D/L90deWN9am/v0hGuFkSjV4yT3p91qoVMKfpdVsGTSdsoJbBkG?=
 =?us-ascii?Q?XHW8hQ9CT2BFNID9bS2Y049q+NR9c6Vo3e/x2i3eSamhK/+dKsx+HE+teW8Q?=
 =?us-ascii?Q?7wDGS3PnNQ5r7i54J2PEtvOvzppMp9hcsICFLsNKMTMe7kh6Bgdu3nTmVbhS?=
 =?us-ascii?Q?jeYYHQsDXIDSfUWZGMx5pSHcfu44YwncFvlxYqazv8IDRacSDnz9MWsIHm51?=
 =?us-ascii?Q?o75GB1HzZChLGhMFJmTMJKwSLHtDfqbuYdXSmQGJy1ZJ1g3Un1Irh9w0T6EZ?=
 =?us-ascii?Q?K3bSJvO8EYW02iOJy5uUq35lZRQf2e89Qy6MgTy1d5cM+Cq1TWF7nOevhbNH?=
 =?us-ascii?Q?F4iPTexGTe8IKO1X8OnUBKOiJ1NxnlLz8AELWCvRJtN+weW4bEzBANlt/S9y?=
 =?us-ascii?Q?pLr11tITtBzoKHXbaFvWxUrPeibKtvkIDmoiwZKwJF7033tSNn0nZCw3DVIc?=
 =?us-ascii?Q?Ku2eGtjHq2/1xp/3pDPkCHv2qpkwvuE3blCi3pF99W3mQWpe3zrW2kmClynK?=
 =?us-ascii?Q?fcNmpMtd5xNUeZEVKmRDHIGa6NQjufbA6HkkGvWBvaIzab8PVismj1S6NABj?=
 =?us-ascii?Q?akiA0cs2G7PvKcQDHVblQkMHSPUWjZTWve0onz5BhZhbOBrcNoCC89NbXdWc?=
 =?us-ascii?Q?oBUiwxuRoGVu8Guu5iIYYcPvwFXnrzX5QlUmc7Gm4nSwGBzw51sVs90wZwEf?=
 =?us-ascii?Q?jrmIe+IShaX1iqkt4wTIUXc/XQN5R9JI1bD0IxHFMkUbZQXeMyzyTqOSwV8b?=
 =?us-ascii?Q?dcDweZCrEXLINV73E6Diy8xOfKyR9vOU5dfy1iNx18yEXHmrx4hrQchUjsiM?=
 =?us-ascii?Q?Dqv7kwDO4Suh/tnw1P0RxnMSYDKirGrXkBr7WRnEVAAL5+ZSsOdaJ1I9GIj/?=
 =?us-ascii?Q?VX4nWqq78kyX8NvbSBibhZ2VayHJ1j62v8fSHwY0cdGOOZe0j8WFoS2Xf+u0?=
 =?us-ascii?Q?2PHa1OEVbEFBrw+E/uCqyIfjT6xPPK/3rZV76UkWAIxUnkS2vc80k/IAzyw2?=
 =?us-ascii?Q?3ovK7nF0oHMEfOEsnCSwxQEB8IrlTFyQY279QG+t0LhtmqV/XVLaeS+yJZpp?=
 =?us-ascii?Q?FsOl5SXdt3WRjWDfHs+rpz22DgNbylNg7aS2WpXCzJD3xbwc3v6YxToncAXa?=
 =?us-ascii?Q?5UFwqGakNJoEQ7hJPptopzOj8zGMNLQGGEQdltVZyKcAIf/BWT7Guj/2B2fi?=
 =?us-ascii?Q?9BZX8Y6pCfX7tHR14It2pZjptclZdS0+XGdwwV6YtN1llB1pZEUtNps7YAbd?=
 =?us-ascii?Q?TGWID0sxc5ymqL8FtPVi1uTv3tKljr7kwChDsuhVEpcBg8PJq8hacqY1/A7Q?=
 =?us-ascii?Q?/2Iux8Mf17qtMuXQ6i+vOnSSH69VMCCE8lSkd6p/W3oK4HaLp9Rdk01TQ+uM?=
 =?us-ascii?Q?0FukJGHsMSb00wxFQAGibYElqcG921v1q0CPe6o0Cr8G4NKGiRWlsD7QTrBm?=
 =?us-ascii?Q?TWLwrwYBRE6X1arouxHPA6unGlh1q8Rynii9uM9w?=
X-MS-Exchange-CrossTenant-Network-Message-Id: afc8f0bb-fec9-446b-f706-08dc607c3f22
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 14:23:13.4679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sq8iKgDyYpdNTshhcq/kn74YRCwAiC4Gj2JSGSibAYdKklNvVhpPLq5PFdEzaZUCl85za5ioj69XQ1+ngOj8bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7627
X-OriginatorOrg: intel.com

On Wed, Feb 07, 2024 at 09:26:29AM -0800, Xin Li wrote:
>Switch MSR_IA32_FRED_RSP0 between host and guest in
>vmx_prepare_switch_to_{host,guest}().
>
>MSR_IA32_FRED_RSP0 is used during ring 3 event delivery only, thus
>KVM, running on ring 0, can run safely with guest FRED RSP0, i.e.,
>no need to switch between host/guest FRED RSP0 during VM entry and
>exit.
>
>KVM should switch to host FRED RSP0 before returning to user level,
>and switch to guest FRED RSP0 before entering guest mode.
>
>Signed-off-by: Xin Li <xin3.li@intel.com>
>Tested-by: Shan Kang <shan.kang@intel.com>
>---
>
>Changes since v1:
>* Don't use guest_cpuid_has() in vmx_prepare_switch_to_{host,guest}(),
>  which are called from IRQ-disabled context (Chao Gao).
>* Reset msr_guest_fred_rsp0 in __vmx_vcpu_reset() (Chao Gao).
>---
> arch/x86/kvm/vmx/vmx.c | 17 +++++++++++++++++
> arch/x86/kvm/vmx/vmx.h |  2 ++
> 2 files changed, 19 insertions(+)
>
>diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>index b7b772183ee4..264378c3b784 100644
>--- a/arch/x86/kvm/vmx/vmx.c
>+++ b/arch/x86/kvm/vmx/vmx.c
>@@ -1337,6 +1337,16 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
> 	}
> 
> 	wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
>+
>+	if (guest_can_use(vcpu, X86_FEATURE_FRED)) {
>+		/*
>+		 * MSR_IA32_FRED_RSP0 is top of task stack, which never changes.
>+		 * Thus it should be initialized only once.
>+		 */
>+		if (unlikely(vmx->msr_host_fred_rsp0 == 0))
>+			vmx->msr_host_fred_rsp0 = read_msr(MSR_IA32_FRED_RSP0);

can we just drop this and use "(unsigned long)task_stack_page(current) + THREAD_SIZE"
as host fred rsp0?

>+		wrmsrl(MSR_IA32_FRED_RSP0, vmx->msr_guest_fred_rsp0);

any reason to not use wrmsrns?

>+	}
> #else
> 	savesegment(fs, fs_sel);
> 	savesegment(gs, gs_sel);
>@@ -1381,6 +1391,11 @@ static void vmx_prepare_switch_to_host(struct vcpu_vmx *vmx)
> 	invalidate_tss_limit();
> #ifdef CONFIG_X86_64
> 	wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_host_kernel_gs_base);
>+
>+	if (guest_can_use(&vmx->vcpu, X86_FEATURE_FRED)) {
>+		vmx->msr_guest_fred_rsp0 = read_msr(MSR_IA32_FRED_RSP0);
>+		wrmsrl(MSR_IA32_FRED_RSP0, vmx->msr_host_fred_rsp0);

same question.

>+	}
> #endif
> 	load_fixmap_gdt(raw_smp_processor_id());
> 	vmx->guest_state_loaded = false;
>@@ -4889,6 +4904,8 @@ static void __vmx_vcpu_reset(struct kvm_vcpu *vcpu)
> 
> #ifdef CONFIG_X86_64
> 	if (kvm_cpu_cap_has(X86_FEATURE_FRED)) {
>+		vmx->msr_guest_fred_rsp0 = 0;
>+
> 		vmcs_write64(GUEST_IA32_FRED_CONFIG, 0);
> 		vmcs_write64(GUEST_IA32_FRED_RSP1, 0);
> 		vmcs_write64(GUEST_IA32_FRED_RSP2, 0);
>diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
>index 3ad52437f426..176ad39be406 100644
>--- a/arch/x86/kvm/vmx/vmx.h
>+++ b/arch/x86/kvm/vmx/vmx.h
>@@ -278,6 +278,8 @@ struct vcpu_vmx {
> #ifdef CONFIG_X86_64
> 	u64		      msr_host_kernel_gs_base;
> 	u64		      msr_guest_kernel_gs_base;
>+	u64		      msr_host_fred_rsp0;
>+	u64		      msr_guest_fred_rsp0;
> #endif
> 
> 	u64		      spec_ctrl;
>-- 
>2.43.0
>
>

