Return-Path: <linux-kselftest+bounces-30058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CF8A7A2EF
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 14:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2CD87A4377
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 12:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DA724BBE3;
	Thu,  3 Apr 2025 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JX/F8wIr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ED435942;
	Thu,  3 Apr 2025 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743683753; cv=fail; b=QG/iSZzMtWrN3nfCe3JTuWJL1SAXI6l1YS+G4OdvUFM+XssU66LMLIWJgKRnJZ/U4e6RwxLhlOZX9v6t6NNM6bxivkZyBbivuhb447i65nUoi3pNyo1EOWG2d7uxnSKvlKYzEaLo20k/S5ffQ/LDxBJOQZ2S/OkIdjP2l/uUMg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743683753; c=relaxed/simple;
	bh=5E9ZnQr2odQy6iU7mesCMakpIng4posiu0AYDmjet1s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cc+/3wSBgej7jCIktsjerP6yiIQo39/W1MuEsPCHWR3jCwnS8zCfSpXM9RJctqdLAFWqBbtOIHa4+soeszCJg/FX7zshOx4JkEIqz1GGU2mqKlG/vbk6U7NKxYDLu87CA9enZRGN8FW6KdBJi3m4qdSJypsKf1yHPqXQTu4i3kI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JX/F8wIr; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743683751; x=1775219751;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=5E9ZnQr2odQy6iU7mesCMakpIng4posiu0AYDmjet1s=;
  b=JX/F8wIrJzMImfZ93YrZURx+CR2Pcj3wB2PSSnbR/TXHUcflBzXzjqgj
   gOpGej306582xFV1s/vMxFMyXyQ3eZ25tPfcyN/wV94fwXn99QiXw7cjt
   RTPT0pkaEIR8AfGmf2WAGeU5yC3KnKG/HBK/jstbuki1/UWZKvigFOgZC
   QidNKO2SvXHqcB8VfB/lPUVZRw6YqrhqSnUj0aUK+KHRnjsI3ZtKbifNZ
   Kh5vT0lNLV0UnGQg2Ub8MsG6qi/MjgAGRZaIo3IN35wTQlQItTfH3cYsR
   YKD92ruX/Ti4Jozd/UQvTueqvd0kFZbQP/yn0JDbIcuYPwxSeMH9YtLlC
   g==;
X-CSE-ConnectionGUID: 3ULPC+0HSOyoMuvtCb6OKw==
X-CSE-MsgGUID: 1bwKIQMnTJqcqM0qoeUuxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="32690771"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="32690771"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 05:35:50 -0700
X-CSE-ConnectionGUID: 9mPk6JAeRhOBuwSTL99Wrg==
X-CSE-MsgGUID: /hyjbmdfT0muLNhTCCJ0uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="126950414"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 05:35:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 3 Apr 2025 05:35:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 3 Apr 2025 05:35:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 3 Apr 2025 05:35:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mE7l81BGjwH2DFr6UqglNoiEKNHAIuY1bhT8oEToEIHSx3Qp5XNvB8AfaZ7aeIXUaYBJqv4F1cZF4E2OYqRvrG+wkc4Ykq5LW0FKiebLIcLXUDEBzh6w1TZ1Qz69wcwa2Tn7JzqtdRl6NLdFuqTqBzwvMl/b54UPS9OQufdnoU7q8Eu0kFoL9TeQh5EVVOLjMePwHrJY9zZ8Z0E5lITDBz3QUIzdEr8RpBskwODuEy40LBsmd/B5qsJbaPMqLO7xfqIGh3kVBzTsXQ8hc/cVtEUQProxR7IZTnBbFpNsFBLl24qgbu8TYYFZAZSr0lijNfVl0dNDOs1qmkzrBiONcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAaUxmFIAK5aQVU9l6tdF8waL0Qk3EXWnYRE9O/24yk=;
 b=t23duYy91Yl1yof0LnjG5NXnOEV4g+13pJyCGFCUmzDzhaT+8umRHBKeUbS0VJ6UlywTsIQfqB40Tfy5aCqJtmOlaoSvyrJQby/dcxrzygx4PykoGc4a4oTidxivrFcRycWQmLLUbuanQmT0sVSrizPN7/mFJxmQHp3Ueh2F6rX+tsJwOA9XvNF9ixIPABGWlPz/1H+tH77h5zw3jPsqhgHMhD1TRrg5hjEArcGZQctILAEb7yFInbBWVXRJbS2HZswwNq6wosqVeXN1q0NzyX2YlgZFMT9+SMWfWcvdgC0rB5BAoVPbIIi6g40gZm/b9bS/GBAiMXeysSZ5EkUpbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 IA1PR11MB7919.namprd11.prod.outlook.com (2603:10b6:208:3fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 12:35:19 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%6]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 12:35:19 +0000
Date: Thu, 3 Apr 2025 20:33:31 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: <tabba@google.com>, <quic_eberman@quicinc.com>, <roypat@amazon.co.uk>,
	<jgg@nvidia.com>, <peterx@redhat.com>, <david@redhat.com>,
	<rientjes@google.com>, <fvdl@google.com>, <jthoughton@google.com>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <zhiquan1.li@intel.com>,
	<fan.du@intel.com>, <jun.miao@intel.com>, <isaku.yamahata@intel.com>,
	<muchun.song@linux.dev>, <mike.kravetz@oracle.com>, <erdemaktas@google.com>,
	<vannapurve@google.com>, <qperret@google.com>, <jhubbard@nvidia.com>,
	<willy@infradead.org>, <shuah@kernel.org>, <brauner@kernel.org>,
	<bfoster@redhat.com>, <kent.overstreet@linux.dev>, <pvorel@suse.cz>,
	<rppt@kernel.org>, <richard.weiyang@gmail.com>, <anup@brainfault.org>,
	<haibo1.xu@intel.com>, <ajones@ventanamicro.com>, <vkuznets@redhat.com>,
	<maciej.wieczor-retman@intel.com>, <pgonda@google.com>,
	<oliver.upton@linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-fsdevel@kvack.org>
Subject: Re: [RFC PATCH 39/39] KVM: guest_memfd: Dynamically
 split/reconstruct HugeTLB page
Message-ID: <Z+6AGxEvBRFkN5mN@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1726009989.git.ackerleytng@google.com>
 <38723c5d5e9b530e52f28b9f9f4a6d862ed69bcd.1726009989.git.ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <38723c5d5e9b530e52f28b9f9f4a6d862ed69bcd.1726009989.git.ackerleytng@google.com>
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|IA1PR11MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: d31d6b8f-b994-4bf9-1aba-08dd72abfe68
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qXyx+j5Mo2J+jDkeoiApSW2C2qTuE4IPXSaVrEmcFbCywU/9AYhJmFmn3TSw?=
 =?us-ascii?Q?3xNbyXOae3412z7HsO2qvaWv/BuLBlPvuQdbqn1E/D+1NJ3ZOtE2ayfpJom1?=
 =?us-ascii?Q?VWJvtjcVUPWs6LnKcQkSynnXjUotLa6KVHyrlcJeFzZJbLljDor2fgG6/B8H?=
 =?us-ascii?Q?CAZJO8gWRTPLrMGThh3cK3UpSpn8ENq+UTySMSOb42k9cz+eyQcZ0QGQOR4H?=
 =?us-ascii?Q?Il03wf72g6It1/Gz0/VS4Ax9uhwE0Jyj8cvRizbwj1dFtRT9G/oJS0oextQj?=
 =?us-ascii?Q?S0E6vquGlXAEkoSahLhgt5O/H49s6h/RgH0ToqaPdhbkP781Jgj3hiJ7s1I4?=
 =?us-ascii?Q?yHwmHUXvI5ivW4936YIsUd0RdnSmtu6IwAQo+wO8DSNEGzzzX2tM6OhFyhY4?=
 =?us-ascii?Q?z8rOfH7AlEiiZ9jrSk9ewQncacqKqTkPdSl56qEmyNaYumceDWeEiPUXkwEU?=
 =?us-ascii?Q?4IvbhYnDE+n9TEkURbgXy6roGwZGcmzdU/b6/7JSZKHdCp6lXLi9JBkW0nyx?=
 =?us-ascii?Q?SWnL2zrsRbQgd1MtoNSgYUOkFBByDcUrl7RWn2EtjeW3x6YYaabtBIqaQ2G4?=
 =?us-ascii?Q?uPWj2oDBYY8DdRWXq7x9SRckls0suvtj3Er715Qb4UDRUaAawAMX7QLtiDN4?=
 =?us-ascii?Q?pZqpp5KsKr0lcqmUhZsvEwe01iHhI4p1oVUwXlOf4LwdMi920vpj3lZGzzWI?=
 =?us-ascii?Q?2OvkoxIqW6b8D+3NqRUL+U+GyIqU+IGXHSZqZTsufPJKQrVNz+xp18ScuUtv?=
 =?us-ascii?Q?lpQZu70NPLgk886K/gGD6cSyH6Mri+USnbti2N6D5xCItkcIYB/iCIbDsOmV?=
 =?us-ascii?Q?6relM+MdPEPO7dNtZclQEqXTl0RyqFg1XTPts1FlBv+kdEmcf5AjqiL8wpEj?=
 =?us-ascii?Q?Bf0hrk2JGOL+mx90S569pWE0bvI7cPycSXmy0nH2XhKXuZfBHPUm8Bn80Yql?=
 =?us-ascii?Q?WenB3c375YadhQIiE8xbirrWbRw4GGVliPNZ3Aq5Xa8bHzN7/r/+Bi68HO7K?=
 =?us-ascii?Q?5httIPay5KE8IHYD8x3TT1spCHqflJufm+ejjDmhAf9AHlSjFhb2r0OTerv5?=
 =?us-ascii?Q?bV/E6teEHpMmo2DAYEE+rQRmGKo2SPF7K2G4vtcY0HLUmKELPRPsJs+B6ejW?=
 =?us-ascii?Q?V6FdSWSWoCMIPNOcmR6gMynRRCDL/TETJtcqd5aGnFZQDbfGQ+w4eDkbTI+S?=
 =?us-ascii?Q?/PW93f1D/+967X4McVS6qWOUlu+5Yu7bN3RCvhUtg/o184on422gbOuDYpOz?=
 =?us-ascii?Q?pmITw22GamvnZnHAlnSExvB7+mheG2SW/MH2iCOfblwxH/Ouz2UqO+bDqoEK?=
 =?us-ascii?Q?f+JLQKL1weWswRQCYfHex0smmXryq7R3s8CjDCN9N6OwKsvLt+FdZxtyfHF3?=
 =?us-ascii?Q?WZK8TExQnfhfQJoMIi5G/+0fuY+Y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Xxf8yBcH5Etmo87onIGC/chovSrxFQ7cBOcwHpoO7IuTRZEMeNp3OX6l4a4?=
 =?us-ascii?Q?qQ15eaG/rrJhbjTVSV/tzHQttDynRuIEGECPaaQJw0gcqk8sPdXFyMTbWwrl?=
 =?us-ascii?Q?jgRNc8gqZRUbRg9t+Q8AmYDsY9aIwQ3/Ayh0GBlxZq3mtd8S3KEKf0nMf9/2?=
 =?us-ascii?Q?8WtetgsBrs0VAj60B50QT0BWiVk7hsUI6nB/rfcTrFLkqSLVEA9XqNoCCDhs?=
 =?us-ascii?Q?pKbmxSHTGOwI7vbmoKCh4rqSIlAhLm9zA/CUnYLNOL5vGihFW3mf9xisCJa9?=
 =?us-ascii?Q?fQ9Npe5oD3G7SxE321YBJDBnCiF0h+YnkKk8Vx4QOpCi90SG7wKqL/wPbE0f?=
 =?us-ascii?Q?j+yEMK5uvJj/2QMbjoqCAzm+BoQmV/fdZ4BOSX0+u0oTZlhOUw7ooRm4sd6W?=
 =?us-ascii?Q?y26n030fICvjYM5PbPI8yO+qLS84cWDx3bzJ0QvT3MjGgKchnu+1KF9WOkeS?=
 =?us-ascii?Q?fWshVCoT6LyIn0u7HKbJ/ZYq9pM6LGuie/Mh8UZMZV/W5ZlcI6/4yeeP0R9N?=
 =?us-ascii?Q?yV4iuVp8cu/Ku4NOPlpcsa0GwjrSwq4kRiB8xGJbJKGSIg3Eg1sYgrNS69ql?=
 =?us-ascii?Q?CV6NGXRgzN7IKZ0uYXun4YkMVaSb2prsoyyXfyBK67TssVjcSbf0S8/cs8+Q?=
 =?us-ascii?Q?33XCFkvdmLHftAJ9MCue7+SxjKhzfeNN5XqM//ZD6y66FHkoaKB1ns/4xEzs?=
 =?us-ascii?Q?O7f8c1nZMmRsrMFst93zb4PTpgQsQht1cvWU84Gx3KlJMWRGJL3rj1JV/ry0?=
 =?us-ascii?Q?1dOBtBrw6HXre5cexZmK25CukQasb6qrtqaw59UvGcDrjyA0/DsjURIz4ymO?=
 =?us-ascii?Q?mcDwDMwrtoGpd/BKYmeFDJX0Ri8b6zbZGe419NRDRjxiY9pHI2VQRELt0KaU?=
 =?us-ascii?Q?uwMoiNUWzLPjaPEW3YoUTD0Gt5E0Gq1rMnfrNeL3lFXnyW8ZcrmNBXXswUzD?=
 =?us-ascii?Q?UfXfFOZphNX1DrVP9cwYBB3w9yGvduXEJMTKCvksNuVc/4/Le+68vwNVikXk?=
 =?us-ascii?Q?GBr2R5x9qMO5+OQEQ35qSpXNyzioAbMV6UoZF8nqw8P10cjrxMduRsSyovsp?=
 =?us-ascii?Q?72Y/VvXyZg9iW0eMPpK0prf9DexquB0NWqmRKnCCHCa6Ycemw8YKNb3JGmRF?=
 =?us-ascii?Q?GF0OiZE1PEcYOuQogsEFJfrG8XWioE4VKXM3r9maolc/7G7QSdl/LwCZLZxU?=
 =?us-ascii?Q?XM4tp7nghh8MJB2rVS/gAvcrRpPh5m2LRcFYqn+eMW9HGULHG0Uyqsi7pd2L?=
 =?us-ascii?Q?GEsqSxdgW/24J8wGy6Nxke7uUmPnbACc7U65/xcyuGihFYUT5n4hlVpbaEI3?=
 =?us-ascii?Q?L80d/pD3rV8eX2fnBgodZFMDcaZKDxsA0NKzoLAnQb8coKYQ/a1OpL0zocYQ?=
 =?us-ascii?Q?CeXZt9d6jYqHP9CDb32jzrNCdN6NFSPLulMtuAMpDHNu6lPkSU/PrakE0QX7?=
 =?us-ascii?Q?xXzUZXa26vW/v+I4YMq4GVEi50jdpAm+GjfQLEeFz/bA7VnmNnjqhnBU9eGe?=
 =?us-ascii?Q?hlKDNIEW9NCYm6o+Iy/yYn3HPC68HuofzgAkFDlgfUEClhyZ2C/neuE/t3OQ?=
 =?us-ascii?Q?wx6VmDlaeBHNw2iViG+iuG2jy63b4DO1bTnAgB9G?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d31d6b8f-b994-4bf9-1aba-08dd72abfe68
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 12:35:19.1862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fjwQ6GnSKDDwqPx6pq0VTTcW87goFidti/+BoZebVG4flvtFpb2qJWsqm9qZdWnVqwmvALbhLJd9JffaO7y3Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7919
X-OriginatorOrg: intel.com

On Tue, Sep 10, 2024 at 11:44:10PM +0000, Ackerley Tng wrote:
> +/*
> + * Allocates and then caches a folio in the filemap. Returns a folio with
> + * refcount of 2: 1 after allocation, and 1 taken by the filemap.
> + */
> +static struct folio *kvm_gmem_hugetlb_alloc_and_cache_folio(struct inode *inode,
> +							    pgoff_t index)
> +{
> +	struct kvm_gmem_hugetlb *hgmem;
> +	pgoff_t aligned_index;
> +	struct folio *folio;
> +	int nr_pages;
> +	int ret;
> +
> +	hgmem = kvm_gmem_hgmem(inode);
> +	folio = kvm_gmem_hugetlb_alloc_folio(hgmem->h, hgmem->spool);
> +	if (IS_ERR(folio))
> +		return folio;
> +
> +	nr_pages = 1UL << huge_page_order(hgmem->h);
> +	aligned_index = round_down(index, nr_pages);
Maybe a gap here.

When a guest_memfd is bound to a slot where slot->base_gfn is not aligned to
2M/1G and slot->gmem.pgoff is 0, even if an index is 2M/1G aligned, the
corresponding GFN is not 2M/1G aligned.

However, TDX requires that private huge pages be 2M aligned in GFN.

> +	ret = kvm_gmem_hugetlb_filemap_add_folio(inode->i_mapping, folio,
> +						 aligned_index,
> +						 htlb_alloc_mask(hgmem->h));
> +	WARN_ON(ret);
> +
>  	spin_lock(&inode->i_lock);
>  	inode->i_blocks += blocks_per_huge_page(hgmem->h);
>  	spin_unlock(&inode->i_lock);
>  
> -	return page_folio(requested_page);
> +	return folio;
> +}

