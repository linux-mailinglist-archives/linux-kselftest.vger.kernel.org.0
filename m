Return-Path: <linux-kselftest+bounces-31479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9C7A99DD8
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 03:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE78188C996
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 01:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4591F13CA9C;
	Thu, 24 Apr 2025 01:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OxaEJGoq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D1913A3F2;
	Thu, 24 Apr 2025 01:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745457106; cv=fail; b=JjYO307LN9mUAYXG6PTIOj/gnq41fxriqjdUyS3e7trrUm7r8AQisSSQ9qukCMEcoX7xnyb99mLrWk7b+nOurCH7ly2Acok7tf5LxGaA0MaHHPKTaWyvVEGKMb2+GeIaIg2l4AtQbHix1ldjreg3VLm747CkOgjly8tDojMtQmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745457106; c=relaxed/simple;
	bh=b0e65BCuFqZboFg2Hui3/Sc3YbyJ6UgaT1WtU6AWMik=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fDHNH6/PXaVKixzMyu81GljrQpvIm42rgkdFBiG+YtsjjYGOMCMynqlBsZvzbckD/g3b9rQSXNzyyHm9eYrjs61azEqt0kIXNUsvLFeBY5iGQt5cXV5irVx84OsHR7M/5HNf1zQD8rGAIwSSRF5jBmyrENYYJHoJHc5jLpkzed4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OxaEJGoq; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745457104; x=1776993104;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=b0e65BCuFqZboFg2Hui3/Sc3YbyJ6UgaT1WtU6AWMik=;
  b=OxaEJGoqTLsQqQtEGmidFj5s3JXwdzLfewYRzk59HDkwMshVv6Ij1Bxj
   jt+GopQYQPXvCR+9qDFXKusuQBjPTw4NQcS1tGUDF5tt96Venzn+iSDPW
   TTEI3hxEf0CRRYORkXznZoO++bMpEOM2pDu923Ujozrve1mFdu77rHKhN
   df7zJ85AqgDK95QRWz6K2+MxqTBQePK/lWltcP+mckipv+E9oODYj60A0
   +7R0urMKfwir/iF8DGEqql3cSH7tWm5k/anM/oq8GgmS5KnH5GYhw94sV
   xnlcStGzhCBbYlQr9Yv6xTFTwp7y96VU9C8pro46+F71fYhCh0KTysZJA
   w==;
X-CSE-ConnectionGUID: RIRst9+uQ4W+eEEdvus9bA==
X-CSE-MsgGUID: oU527AYiRO6dNS1N8L74Ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="46192382"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46192382"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 18:11:42 -0700
X-CSE-ConnectionGUID: B+GFs0zDQ4e5byQIFbETOw==
X-CSE-MsgGUID: ftCYJxPvTcqhDQISSpMxxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="137640773"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 18:11:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 18:11:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 18:11:41 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 18:11:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+gjt/mymgw2UiwmVUbnanLiBSaNFX9l4/E999zmGJ/iqAJ7sLnXjAzvgvHVJMcRWJek2ibpf3OtgJUj6+kAgPsjQw2FwQiwfBWzsqEtBk3ykr8pWtueS9fdpXxHkvwxhsPnqD9845ug76lFU52va8/Ikxgp7B2fn8h9AQHzewKlbml0ATDUdtq5KauXdhZ4difhLOvTK1jh9momK34gs8RFHL7kthOofJo9Jym8rmrJ1x/N1T7b8QP6u7EKFHzmOgUAM5ryBiyI42VI6Zzit5bBhBJOiQcOmvwNCtr6FOpoYDMAdM81XN9z1crM7eEmtz8j47bDZFAfgUwVel/BAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBCC/sjtlo5q33neWo1CeJ8eRPX4O8dGue7tBQiubkc=;
 b=yX9UY17tdWnZSIYF2UxR9l21puxEsVgJHncEuuYqIacBDprUIVmErxnzeSU2V93JDRpv0V/ilEBDHf9yWzKK2GpdzpcQI5BnBEzA4PxeOsA4XUvp9Ji4rqXvKKZF+og+iwXEfEKoTpKYvupENr7FawwaE25r0YymP5keOYVKTPhAcUuT78N3zrHP0j9Tch3hN47Ega7u/Wip2pdMQ7cB7xSjJV0jqtH59nzXaGQRUzuVZZlEF2NzObkbdF5JoY+YHrHLXOzPKCW3RcJY+wR5K9t/QEcS85wyHyF1Hx3EnUh6rSWgnZd8550d29wA3vwDWBvfUm2AxpHzFCqPLQPM8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB5964.namprd11.prod.outlook.com (2603:10b6:208:373::17)
 by SA1PR11MB7697.namprd11.prod.outlook.com (2603:10b6:806:33a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Thu, 24 Apr
 2025 01:11:24 +0000
Received: from MN0PR11MB5964.namprd11.prod.outlook.com
 ([fe80::7a0e:21e8:dce9:dbee]) by MN0PR11MB5964.namprd11.prod.outlook.com
 ([fe80::7a0e:21e8:dce9:dbee%3]) with mapi id 15.20.8655.037; Thu, 24 Apr 2025
 01:11:24 +0000
Date: Thu, 24 Apr 2025 09:09:22 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: <tabba@google.com>, <quic_eberman@quicinc.com>, <roypat@amazon.co.uk>,
	<jgg@nvidia.com>, <peterx@redhat.com>, <david@redhat.com>,
	<rientjes@google.com>, <fvdl@google.com>, <jthoughton@google.com>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <zhiquan1.li@intel.com>,
	<fan.du@intel.com>, <jun.miao@intel.com>, <isaku.yamahata@intel.com>,
	<muchun.song@linux.dev>, <erdemaktas@google.com>, <vannapurve@google.com>,
	<qperret@google.com>, <jhubbard@nvidia.com>, <willy@infradead.org>,
	<shuah@kernel.org>, <brauner@kernel.org>, <bfoster@redhat.com>,
	<kent.overstreet@linux.dev>, <pvorel@suse.cz>, <rppt@kernel.org>,
	<richard.weiyang@gmail.com>, <anup@brainfault.org>, <haibo1.xu@intel.com>,
	<ajones@ventanamicro.com>, <vkuznets@redhat.com>,
	<maciej.wieczor-retman@intel.com>, <pgonda@google.com>,
	<oliver.upton@linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH 39/39] KVM: guest_memfd: Dynamically
 split/reconstruct HugeTLB page
Message-ID: <aAmPQssuN9Zba//b@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1726009989.git.ackerleytng@google.com>
 <38723c5d5e9b530e52f28b9f9f4a6d862ed69bcd.1726009989.git.ackerleytng@google.com>
 <Z+6AGxEvBRFkN5mN@yzhao56-desk.sh.intel.com>
 <diqzh62ezgdh.fsf@ackerleytng-ctop.c.googlers.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <diqzh62ezgdh.fsf@ackerleytng-ctop.c.googlers.com>
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To MN0PR11MB5964.namprd11.prod.outlook.com
 (2603:10b6:208:373::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB5964:EE_|SA1PR11MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 04271af8-7c1f-4692-7228-08dd82ccee2c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fZZXymp5xS0e+Myqn7yhBKd2ajlCztxsgKRYx5hGflA1hLZ2xWwL3R1GARwI?=
 =?us-ascii?Q?PdRaPkizyzY9ietBGmBDNZMiaZB0OzJ+n3h4FnhSrYKjwi1gxDzRyhN0/ZEH?=
 =?us-ascii?Q?lHrNJPxxffi52ssmkKUxgR90uDkATBKsLkNncZeg/JUM8KyfPIVwXJk3DHK9?=
 =?us-ascii?Q?PWu1zTg7wUec4f0RaBR60xRD8UwiTsYCQZvAmJz0tBfqMKp46pHOjqqol5DA?=
 =?us-ascii?Q?AMHRuYmzgTr+X0s3fN/B14oS0i2CFLWaUIW8/5mpQH2oxq4rXcnwLBZqeuji?=
 =?us-ascii?Q?2vvjQ5NVk+dzoFAZ2ekMfR1kFs+xiNGCU9IggYpcpzIxrgIk7aAGSWhIi/Bo?=
 =?us-ascii?Q?aP1Zwpz6Xxn8GN9Jvt6BSCEBagdOr/+nDCtMDujJGKd5eYe9rLBgWuqt1fxB?=
 =?us-ascii?Q?ufttY/vuwsiHisvDPzKr6ImXnWl+bnhlY9JpCZg+rNdRRfR1Dz3fDKwEgZWd?=
 =?us-ascii?Q?PBylCSaAxo9J3r2x5G08M27gk0x0qJBQYiqC2MX7nglmsmsmKmGAMWFEnYeS?=
 =?us-ascii?Q?kaCcu6Ky530nO46pSS6Vnl4hsgemv2ZfEeQ5jUh7pU2uokJA2pcGsiP8xlu3?=
 =?us-ascii?Q?SJDieyjBWfIeeTBXVJKnmKIlXSIE1ib8gGD0Os6etuRN8C9CMw3pmgH4430k?=
 =?us-ascii?Q?tFbGodolUfL+8a7MRNz0tTooHJizQZVG5z/IgxaSZ+87ufDZrzCfGhNEefsV?=
 =?us-ascii?Q?9b5YICMykF8Qa9KVqaZjCDsvUrbdU9/tSfYW6CGdh9DwHy728+smxKb3rPJn?=
 =?us-ascii?Q?6GU6OQTM4Om+xF5N0S9db4Zn2G2c2GvkhISYVLitwQMkwmjVr/2z7e2Fgo+t?=
 =?us-ascii?Q?WMB1zxZ5o8PmKv0JhbfJwxlX6jSh3ptM1h8aZsDwCJbO8b1cfZB5v5c4GC2S?=
 =?us-ascii?Q?iikJec1lYvmE5COvayoveytbgcXr7fHFv3u3lpnNR3KvdoQ+XkThvXgStO6u?=
 =?us-ascii?Q?2tGoHfftxySl+0PUD388yQL/JALpS+Rgb/WIhsgXj4QFetBYcE6smRUoMeNk?=
 =?us-ascii?Q?785/QRCvMTvaJ7pu2k95r8P9TYeS6liWJrXENo59l/UTOSLuWsXgonklLp8b?=
 =?us-ascii?Q?yMqhBOStRR/SRxl9F7MPwgjg59YmXaUhXNy2ef38zDJuGGhJtsfsYic08KLN?=
 =?us-ascii?Q?FwkraDz2L1Stt1il/cHNYwU8QY5gpFauRu/9j5mnaYmzoKB8dBzL4LfEHgnG?=
 =?us-ascii?Q?evOH6TGO3Vuo8T6rE3JUIVDdHGFujoh45a6Pp6zm3V5QpT8lcwhId8BXlY3U?=
 =?us-ascii?Q?MoOUp6FWP6zG6ppe+9VET3eHeg1VqrMsO+vYXE8GDninnkDpXLevUdsSTi2T?=
 =?us-ascii?Q?Zc2H0Ac9QI+C5PCDhpxCFdhQM4RB+72GgduR2fPkRxCq/JnwisNL0sC9Z64A?=
 =?us-ascii?Q?3rscftDBjfWc1MX8FXLXGfMAQpSMI1iH2sGmA+2KdP+i0dLTg7tCj0Caz5TJ?=
 =?us-ascii?Q?6qzgIgjZgZo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5964.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Jh+RP/18oYGZMN4T4orqgutcHGAG4IPEaOA/+ANKUSC+pTh2yBMy7faJqtS?=
 =?us-ascii?Q?cGr5dOGfPsd4XFX53uKfxV9M6ere0IFeYLManHhsmMbvBiDPp+nFr4/zwFig?=
 =?us-ascii?Q?yH3YaZRMy7LBbxVWLQWuXVXJ5HA38fS9++JCNViH2keef7C+46TgZDsxUC2m?=
 =?us-ascii?Q?xQ0rLb52gmVgJw736jaSTZvVIFKbXv7CsXShTFfDRVVDRDPbXGd88qdL0ena?=
 =?us-ascii?Q?JSsKIHEZLl2247EuM17y+9DNUN22Aa+PqFvCjliFcGdsIwxRUzaG2ZabpGFg?=
 =?us-ascii?Q?GJhYPxxnyAyesO0Lj94p9xMuqjCc59kRbJ+rMMl0l3VLOvIYGj1MK6ROgSDY?=
 =?us-ascii?Q?hP8k0AwOmmWHxeqZC4fXmw5bCAERx4ABYyL+ikwEFbO69Xkon1l9+Fv/6Ee1?=
 =?us-ascii?Q?ak8FJ8GHwng6Zm+As8LqQxK+zeuzNDvlk00JbSabPEptsFu+GvYDHUexujgY?=
 =?us-ascii?Q?S0lxTSokv8AEIiBHDzMRheivZBw9o6pK6GI5Jub3413A3ihshmOC2qcju88l?=
 =?us-ascii?Q?xmZgSHmiW4z7gKJXzEZuenTry8UXQwEITq+ilv5/XIklr6RZDoM8pB4Rwfr3?=
 =?us-ascii?Q?f3QDNKAFB+402Rfs0VjOvmjAaOf7pKzUyvCSMHhY/uLB64cD5Ecz5gH/99pR?=
 =?us-ascii?Q?TkbOe71V2Aa91v0TNtKuZmQaaY6YOJuGyHZ6i4DhXNTPxb3RFhQLU9TDl486?=
 =?us-ascii?Q?eyRkabYHVxREgo8QfUUhJn1bRHA0KbXVQHC1zDmhn9FvZ3uwdAR7Nl3d+KDO?=
 =?us-ascii?Q?B/0jhSmk0iHl04ubUE71Utp8vHzxik6HaKYu9QtZeeoVrjJQNDB7K/HPeKEd?=
 =?us-ascii?Q?t5VYSvLowMj3YJnaZFClFywiWrAYvsjsRiyyBcpZ0mwx0KfRTSGeVnZhczGP?=
 =?us-ascii?Q?9v/KOHktDyn0ykde4totK9MMR8GZXe59jDsk0cxttjKZrFzzpe5AFuDukLiz?=
 =?us-ascii?Q?I4vdITNV4AhGgvWOrwdMxH4+4esnjB0ZqTu23nvNl+H8ZoiX0/LdCvik70Ts?=
 =?us-ascii?Q?tt09npmdJSEgCwt4+KyX4c5rpa9iMiqrrUMaJaXxQjKgHgAFVoYHjwSbaB/i?=
 =?us-ascii?Q?qmrkFJpNzbdg3OXYfTfo5roZZU7FEdBDjOO6auytB9MnmuRpMhGGQiJQ3+zV?=
 =?us-ascii?Q?YCeH17SVQgb2qaedlcG5B3I8L3PPT5v63wR7100WybZDqgVOFIDvlxNXg46p?=
 =?us-ascii?Q?LjiOg4PI4WhdbmDVBQZ5aKcnlvJWpVuIts66JwwoIQF7J7+iLylyfVszH/ip?=
 =?us-ascii?Q?p7ji3IbLfrHqxvaSVn7npnqqN3eJdEFa9InsLY9iUI2sZL+yN3Q9gNgcHtLl?=
 =?us-ascii?Q?0ESjpP37BdXafPrOzFR5XyQK/Kdk4eGa7u0d9EZ4XhGiMtL4wdlrGd7l2oF+?=
 =?us-ascii?Q?ZkDipfHHzFmOlTWQv/9SC+8jQOWZCqx17myzPV8z158J7biHCaaxVXQ6SUKz?=
 =?us-ascii?Q?YFtf2Uj0RGsF5MallxtCtv1oK3/zlcixYuYYkkfiU0OBny4ZWa2jbrLimsLK?=
 =?us-ascii?Q?8bbC1qEUKIIJ+CvKWpvSVvV1/RVoKnySZKYCcy5W2p/QGKqGLWCU5Vb2nKFj?=
 =?us-ascii?Q?etl2uvFGuyX1A6o10BrpEeuDv76sNym8eRb9RQUE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04271af8-7c1f-4692-7228-08dd82ccee2c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5964.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 01:11:23.9388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxTRCQ0jR7NfDWxXvFwh/q6W3DkHh9Ok3Sev8c51yMO39k6dA3iE/scWV8g2isZqVFwK1wIphdaXmz/Ol2rWvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7697
X-OriginatorOrg: intel.com

On Wed, Apr 23, 2025 at 03:02:02PM -0700, Ackerley Tng wrote:
> Yan Zhao <yan.y.zhao@intel.com> writes:
> 
> > On Tue, Sep 10, 2024 at 11:44:10PM +0000, Ackerley Tng wrote:
> >> +/*
> >> + * Allocates and then caches a folio in the filemap. Returns a folio with
> >> + * refcount of 2: 1 after allocation, and 1 taken by the filemap.
> >> + */
> >> +static struct folio *kvm_gmem_hugetlb_alloc_and_cache_folio(struct inode *inode,
> >> +							    pgoff_t index)
> >> +{
> >> +	struct kvm_gmem_hugetlb *hgmem;
> >> +	pgoff_t aligned_index;
> >> +	struct folio *folio;
> >> +	int nr_pages;
> >> +	int ret;
> >> +
> >> +	hgmem = kvm_gmem_hgmem(inode);
> >> +	folio = kvm_gmem_hugetlb_alloc_folio(hgmem->h, hgmem->spool);
> >> +	if (IS_ERR(folio))
> >> +		return folio;
> >> +
> >> +	nr_pages = 1UL << huge_page_order(hgmem->h);
> >> +	aligned_index = round_down(index, nr_pages);
> > Maybe a gap here.
> >
> > When a guest_memfd is bound to a slot where slot->base_gfn is not aligned to
> > 2M/1G and slot->gmem.pgoff is 0, even if an index is 2M/1G aligned, the
> > corresponding GFN is not 2M/1G aligned.
> 
> Thanks for looking into this.
> 
> In 1G page support for guest_memfd, the offset and size are always
> hugepage aligned to the hugepage size requested at guest_memfd creation
> time, and it is true that when binding to a memslot, slot->base_gfn and
> slot->npages may not be hugepage aligned.
> 
> >
> > However, TDX requires that private huge pages be 2M aligned in GFN.
> >
> 
> IIUC other factors also contribute to determining the mapping level in
> the guest page tables, like lpage_info and .private_max_mapping_level()
> in kvm_x86_ops.
>
> If slot->base_gfn and slot->npages are not hugepage aligned, lpage_info
> will track that and not allow faulting into guest page tables at higher
> granularity.
 
lpage_info only checks the alignments of slot->base_gfn and
slot->base_gfn + npages. e.g.,

if slot->base_gfn is 8K, npages is 8M, then for this slot,
lpage_info[2M][0].disallow_lpage = 1, which is for GFN [4K, 2M+8K);
lpage_info[2M][1].disallow_lpage = 0, which is for GFN [2M+8K, 4M+8K);
lpage_info[2M][2].disallow_lpage = 0, which is for GFN [4M+8K, 6M+8K);
lpage_info[2M][3].disallow_lpage = 1, which is for GFN [6M+8K, 8M+8K);

  ---------------------------------------------------------
  |          |  |          |  |          |  |          |  |
  8K        2M 2M+8K      4M  4M+8K     6M  6M+8K     8M  8M+8K

For GFN 6M and GFN 6M+4K, as they both belong to lpage_info[2M][2], huge
page is allowed. Also, they have the same aligned_index 2 in guest_memfd.
So, guest_memfd allocates the same huge folio of 2M order for them.

However, for TDX, GFN 6M and GFN 6M+4K should not belong to the same folio.
It's also weird for a 2M mapping in KVM to stride across 2 huge folios.

> Hence I think it is okay to leave it to KVM to fault pages into the
> guest correctly. For guest_memfd will just maintain the invariant that
> offset and size are hugepage aligned, but not require that
> slot->base_gfn and slot->npages are hugepage aligned. This behavior will
> be consistent with other backing memory for guests like regular shmem or
> HugeTLB.
> 
> >> +	ret = kvm_gmem_hugetlb_filemap_add_folio(inode->i_mapping, folio,
> >> +						 aligned_index,
> >> +						 htlb_alloc_mask(hgmem->h));
> >> +	WARN_ON(ret);
> >> +
> >>  	spin_lock(&inode->i_lock);
> >>  	inode->i_blocks += blocks_per_huge_page(hgmem->h);
> >>  	spin_unlock(&inode->i_lock);
> >>  
> >> -	return page_folio(requested_page);
> >> +	return folio;
> >> +}

