Return-Path: <linux-kselftest+bounces-37787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 489EEB0CCDE
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 23:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98CF4546980
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 21:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFE623B614;
	Mon, 21 Jul 2025 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ejr1l/0B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51C3203710;
	Mon, 21 Jul 2025 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753134703; cv=fail; b=qFWapYg3CWdcN5eBEl0RVptLIAlgF/i3AZ+okC8R5KiiNg9Ah1ofJ0hch6iWz7eoeisd7iu7TWXiLQBUMDB1CpdO59fv/uBck/YOyOmKtx6LMDnwznLW4wCoJpcBXpkGp1SB9PAqd3zhNaycwzL+cZP2Pd4E2bRrmoZIowBAYvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753134703; c=relaxed/simple;
	bh=Z38vyMrzvAkFuGDR3NLHSndgzZHs9vi2P6bRFndFQXE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KV3u3i+ECpRi2QFd/rngK4xPL/9hb9qka5fQOWlQzErIlww+GGzNqEGGUkIkCUteKubPIE2mG6SWStlyVL15S4f53v4gj//emxUTku8L5YfB51go6aXZbkN1tTWYfFaLmLKsTHQllWYbMoLp4rzYd+McmCokoMJ/n0aHI1Rab9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ejr1l/0B; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753134701; x=1784670701;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Z38vyMrzvAkFuGDR3NLHSndgzZHs9vi2P6bRFndFQXE=;
  b=ejr1l/0BgkoVphqibxuMukyWGnsUgk8dAkhKvUm89NxxXI2LwISgRFCv
   pnrrkRa2ZNBIZJ9KHGNIaOo8h03qbVGiuXR5XIVvGxq7/JbaaGTUSZInL
   +NTTvKXeSow3Hd/kmSpTlx5mfXsqCgHVNeI0oEJ+essodhagMROWQZ6Mr
   GcvoY0Ar6LiyLN0NrXBwXlF6/1Clfh6ep8kOUs1fTljX42Own8o+FK42W
   kXU8mhb7Eoz1K11rpU/LBOxCGqTUmz/Gzeht9vsbs9ecoRpDq0STFCOpV
   1saSyBjh0WMRQd7SHoVmBrKJ8v2oMy4aC0VJnuIwygZ1Q9Mzl2hhAevfp
   w==;
X-CSE-ConnectionGUID: XzZkNMCNRkmz7rOAVqaLfA==
X-CSE-MsgGUID: DFhH236RS7WOCUty31gmnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55072127"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="55072127"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 14:50:29 -0700
X-CSE-ConnectionGUID: TKQyzkisTXKejFL9Bi6Fzg==
X-CSE-MsgGUID: Iquqn9PMRkSHJ49Ai/PG/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="159679032"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 14:50:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 14:50:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 14:50:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.83) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 14:50:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EumrUOnMl9/fcSeVLuHm5+qyCPJTXu8fTtA56cKS4hgU0iU9ny/31VoC66l/fiCQxDcEqZnYU6XLNo1T9iS3AdRsvLc+DExLfo7oNzh4eV+5RNJWNAa2e7tQMt8Fk4gtSl5tvN3dNsyIAPh6rv/LRhtsL70rD/Nu+FJPSy0BCTJEZbKec3509/UG8peHLkOWCuoy3LzGAQEo/qXgDsylf56ebA1OgHqon2uODV/4Wdbwam/RrTqab9u+GfIWYa88tC3tMYQ4SDld7hVnLWfqq0PbHvEpQgKwXcv9s/43rq9S/RQRnrrbFYWOFtHPYDfzMfh5BldqDiRhEuQp0v3SDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODe6VpaEeQx5CjNIPpE07UJwU2Y4pxIAp8ZRuC4eNOc=;
 b=tfZ4jL70v5VZFfHjlh6Kf6IE1h4C8pDP9ALGzGYuIjV6rhGhuynJVTD8gFPJyLWRcYvmxK5lAzpbUINDox0Pe523stvdB5SBV3RJuf9WA46kf99GIdDTUotJdlAeC5qXsq8UObB5X6xeiPSaCkFMyWv5VDGOjAvt4AKriAFSEESyzpL/ik5UfKV0i4ggESs9ldM3eN8G8Xxdy/cZnVWGecs9zh+Sqd42TA3gZHmhraFzAnMb/SGpX0WjJjmOpxqhwY7hsoIB7SicDBLFRrlH+7XXBF5JcT/Vdh7Qx7ClcH2Cc+AZRTyVWlggwPcKa6vrzAfD/Wj849/jXiRQt6HFag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by BL1PR11MB5303.namprd11.prod.outlook.com
 (2603:10b6:208:31b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Mon, 21 Jul
 2025 21:50:22 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 21:50:22 +0000
Date: Mon, 21 Jul 2025 16:51:59 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Sagi Shahar <sagis@google.com>
CC: <linux-kselftest@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>,
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata
	<isaku.yamahata@intel.com>, Erdem Aktas <erdemaktas@google.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>,
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>,
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre
	<reinette.chatre@intel.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v7 05/30] KVM: selftests: Update
 kvm_init_vm_address_properties() for TDX
Message-ID: <aH62f9X25LHuUx8n@iweiny-mobl>
References: <20250613191359.35078-1-sagis@google.com>
 <20250613191359.35078-6-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250613191359.35078-6-sagis@google.com>
X-ClientProxiedBy: MW2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:907::40)
 To PH3PPF9E162731D.namprd11.prod.outlook.com (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|BL1PR11MB5303:EE_
X-MS-Office365-Filtering-Correlation-Id: 6953af20-2d00-488c-2a89-08ddc8a097e5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PoBypDBdC4Qq5dTtclgQXp5At/esfmEiVf+oXPaDhtDdur33Vb0H85kUPKl7?=
 =?us-ascii?Q?vpEODl5kBKylNKAX/ZcIv8bRtayjZcRCa5l4F+waQ6hceRi7Q8Yblj7Tedml?=
 =?us-ascii?Q?KmemYtceTxklyBaAsGzAJY6p0bJnQgWQUMaKRxPPsiDnPVOpho3ScPKTDZVG?=
 =?us-ascii?Q?y8ZPx2dpe8K1va/Gn5snFV3Eg1B7jJ+MdOFHREDTqEM0fmJ8gmW6u43kTMC4?=
 =?us-ascii?Q?HxEeKc5QnAX5glP+Y5IiEUqhup4YnjAE1Q5vTARlUo0oh9CzXvMY4EKyLhxs?=
 =?us-ascii?Q?EhLQp1N6CcX2CEfgETq8/q+83c01+OleO6POFRX6dobUPIOaaVHwPJJidz0O?=
 =?us-ascii?Q?/WkeM5Ef3EIN0BgiMQPxKkwqq41vBH/k77MSreuRIfxm3bpdQXttFRczTUUA?=
 =?us-ascii?Q?y6uPB88nNGLelGGsaJ7uLSz/9cbiFVL2+8wxKPD1/ONyyltgceuH+/r1Y59k?=
 =?us-ascii?Q?I9MEdfgXXdLq82zQjwNHUXngmwQ4BBl8yu1sem9u0XUtbY7E+cEa6Mcntde4?=
 =?us-ascii?Q?hzKzkIy+BWuoFao8PRxq1H516wnI+olwI7VHtPFGSZjoVFEp8+S5LteZ2Mqf?=
 =?us-ascii?Q?5fqdYNuE/CRvDUdigya8VrLezVL6sA3xU9W0jNqQGzm/PJ8LOmf+8ka3HZcN?=
 =?us-ascii?Q?D+2SCOWGnG2NNHcJZfa1l2pK5neDxfDJA0piawiMqUgVq+fSMyobLSw6nLfM?=
 =?us-ascii?Q?68Ga0qEAN5emgBkNquDObn0TD0fJmp2b6ydnqimY5+EVkuBWvaJfMAGb90ko?=
 =?us-ascii?Q?zjpT9/fYgXSyku/cANOwPpGeOBBQZ2BJwdr6KbnUCd0BsecaK+LXnamliW+i?=
 =?us-ascii?Q?vJHSBPQCxtKmyuc6kGVnbkk9yB9PrfljGNicYdZgg+s1agYHlYqsvIsEE2oS?=
 =?us-ascii?Q?oNFVQv1+wcEMPaq8cZnhdkEGDXKzrh03AJf3cf9xpIUy9jXriYRmKvGIMLCP?=
 =?us-ascii?Q?3zXCBXSS0tAk2ALUbdlDxndmoS0Em0mZAjLqO8Ay9+6/njUjaQXq1s7cfyqV?=
 =?us-ascii?Q?K1IIlkmbd4+fMB6U//p5QerZfNTYs3/pYcvEVd3Q7rO5W+I7eooQY6ePumbD?=
 =?us-ascii?Q?AOCNLLnc+M1Fs8swJznkIBbibRrBdHl1uTpLCVbSEPOAQR9vDj38wmW6U03A?=
 =?us-ascii?Q?MUpKn8d6MHRztG/7kditavpMwaPa9QNC0QO6wtoRwMpR9qh60oeOA7uKoLgR?=
 =?us-ascii?Q?S6zKAuXOvyTC6a9Ut039D6zxogvwL7gegA1gCKu1ngFz2eARzI4dNzN/c2Wo?=
 =?us-ascii?Q?PgwFNcu+dKqKMiJJtJCMlpbRTv/lUrpoYhvbj+Xv2dSy66Bt2bah6yXdJbL6?=
 =?us-ascii?Q?DGYqWRoZBIjL4kv9cq/ZUzvFWZpL+eDHgxKp6C139ig2FSABbPJ7jKlhglET?=
 =?us-ascii?Q?yIFG33Gc4hB+ovYfBbKVw+eSZXLKcIYyNFXPNIhDP2GfT736MDohEgwt3+Jw?=
 =?us-ascii?Q?k8agusEO+QY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?onH8y+AsL8D9qhnQLA5wc13tWC34xgE3He3GKAWvtqLGyOi6MHnoxcXyBEgQ?=
 =?us-ascii?Q?nN6NgdbxHm4MY6qIZjNo0GmJf8SP/1olnjtODspx9hnPNXDvmRyarwrsiJ3j?=
 =?us-ascii?Q?eYoyfdSXLw38BuOQJ0O/IUCSRQvLd1/fl8rUkl+aXtun4k9FrlH3tcTm9LQD?=
 =?us-ascii?Q?UPNk5p2Uh76dyQbWRKPwfVmfJ4o4q04RKs48NgUgj5O/uFpOYxvSI38W8W6a?=
 =?us-ascii?Q?OVTrHQCuDzSkKCTH1d3RjuoTWAe/pXtjiQ3CSsYoYQfImCVD+QuPb9l6/1Pn?=
 =?us-ascii?Q?mFb6JgkfHzrho6b255liu2xCQTlzefUhl+VCdEMOy7/w1ZD8JFmSfKPyYuC6?=
 =?us-ascii?Q?QsJDtzdtFSZITM0tshyW6x26ngIqbTGdDEN0UxZ5XCOgk1GK+uIvUiPAyuyl?=
 =?us-ascii?Q?0yov7mwRksDjrwK3eS2gSX/6XcBa4ekdop8JtABTfFS7OlDdcRilYaS5iDeU?=
 =?us-ascii?Q?GEAQ540HNAqzsUI3nIzYSL7SSGiSys4h8QRtq3Jg8SlSbuJHXCY8zxSDLrIS?=
 =?us-ascii?Q?xts2lhm7EudDihWGaaUbouhEvE4ViS2Aja1tCgMUDhyajocLIZ47bpH7RSD1?=
 =?us-ascii?Q?u4Rx9KH/MMkVdsMUdj+XPeLoSZH4eTm64HemBvFZHb74VM3fRFiMv2tfwAnp?=
 =?us-ascii?Q?gYuRChayINIOO3CtPhc9A8x2+v0no2mm9lQXrjSrCkbJSGjwp12zDFlGiQQ/?=
 =?us-ascii?Q?Xpc+fmYxM8ED+ZW7MERu47q7SgnQR1D+qH7Xs4924nA3UNB1HGIBh3GEXfKD?=
 =?us-ascii?Q?ik7ZkyYpEbqkMIDHmV70nm2lnRmr71Etw8sooJvoGj7lW+KWT2tvz8cs5+iE?=
 =?us-ascii?Q?boURYpNwdkGEqGkKLZVkYHBdIBzymgpJMuZXndEf1E7Bd6iyxiDu/CaBEwLk?=
 =?us-ascii?Q?hvrfq/3sjXfuxdPm1sFg6cL+QA+oRH59qc7RfL8BuiI0LzU1/JAIFMJqsaUz?=
 =?us-ascii?Q?WkK9oQe6lSAH4vyaoVMJg3fIakBpief3dck/DtxmUdVgWwXu+RBVRI6mvBw6?=
 =?us-ascii?Q?nWXuys6JupD9AT1KdyuzckGWnYGf9bS3KZuuPHRpDk3sXLxPfxqzMLrUEWfJ?=
 =?us-ascii?Q?cLiYerTR7NyBxBAzQnuzKEGKWtLoO99J395c7zQ4cWJFd07BV3bqMdnDGjnK?=
 =?us-ascii?Q?z0sJOwE/inwpDhCV4NxS15QHstOSdqqDhWX1SqnUjiNpJLmIvt6B0vYKuNaE?=
 =?us-ascii?Q?+Xk+znR1SUnHPJNcs9ijf/SNaq23kHYjcY4OFBqzTRQOUu1OFE47N5mkNVRA?=
 =?us-ascii?Q?AvAzPkx3cp6q0ev5E83o/9fpMddDeojzLXpHtmjiZaKzf62Ia7J82RcKa972?=
 =?us-ascii?Q?jJU+6n39cEiVHUofT720XxvJGobPJ+fjb5XdTRGefElrKGqqzR6DdNWfC3uG?=
 =?us-ascii?Q?Xy7MTLkCgFLcrRhvjw7xDYJ1+XIPrZWQftpnYdkKxBPsx6qqZWa8C1aEForH?=
 =?us-ascii?Q?hO8jVDAokl7tSM9WF9pC/6Q7tJPlrLUXDChUNTA/BRXGWiXWOAcLqSesyaQL?=
 =?us-ascii?Q?taghCXBM03yIBiNOdzgwXJknR1Rwb8cua0yuOJ76vmMPv7rwBtEzm5ap5/bv?=
 =?us-ascii?Q?becFtqh2AsTzqN45kPKEQqZ5ce67Yk8fEbzNlvHe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6953af20-2d00-488c-2a89-08ddc8a097e5
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 21:50:22.6946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ArkbZDX+6gZnUp2RHpbQhNqSCZuVeCvPvH+Sk85fjXSX/+im/VcToEE1nHFdUt9XuJSOVR553mudW3cid8UPVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5303
X-OriginatorOrg: intel.com

On Fri, Jun 13, 2025 at 12:13:32PM -0700, Sagi Shahar wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 

[snip]

> 
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index d082d429e127..d9f4ecd6ffbc 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -1166,10 +1166,19 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
>  
>  void kvm_init_vm_address_properties(struct kvm_vm *vm)
>  {
> +	uint32_t gpa_bits = kvm_cpu_property(X86_PROPERTY_GUEST_MAX_PHY_ADDR)

This fails to compile.

Ira

[snip]

