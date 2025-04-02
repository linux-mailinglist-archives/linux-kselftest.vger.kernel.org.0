Return-Path: <linux-kselftest+bounces-30008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 486A7A78712
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 06:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB0D188F876
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 04:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C377C230BC1;
	Wed,  2 Apr 2025 04:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MfXa4OWt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69BF20AF87;
	Wed,  2 Apr 2025 04:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743567010; cv=fail; b=YtEf6N7v6+75aQ6L/rGPjgdr2e6FWCRbiZHmVrN6xmfYddS915ljfTIDpH8Cap1fQHxgJazLZ2OQqDi3dNipK0ab/E6QfTPLV3qwWY+EyLcaDk98GINNS/tq6l7ArOgcCgDmjGO8p7OGA2GNXnx23cNLSXqymt15ZhMu2CK8DLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743567010; c=relaxed/simple;
	bh=+Vge+qiTodADSjBZoBi8BwymOthUEj9BXt/6EDuo42I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AFOJvLzNZvbJM6nKjWQSm+9U9fHxDALVgYfCXF5VK0sYiDmOS4MlYRoxKju3U57bcm+eavjrYDLjs93Ot0kONFYRibWlJctYpX+IG4fYZOuvuygVreDc7CWpiDHN/OVF/CQol8LEqhz8BXGDVZ3uauIF4g6CoQxrNBPvlnj21DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MfXa4OWt; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743567009; x=1775103009;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=+Vge+qiTodADSjBZoBi8BwymOthUEj9BXt/6EDuo42I=;
  b=MfXa4OWti39S91M6v9IYdV0l5CHOecIaYwDAsJKoruXPggT0vb7dpzdo
   yaQvj2UIDROWSVXgcQYphWoTPXfeQY54LFb1tgdTiy7MWwnd/zX1bxmAZ
   +SuMoc/EyvhL+RhwqaEvAkGsW8TlOHgRktZjI0H04jNFqdULYDZwXBWd3
   NE6qpHWuPXUNG58PiFvOUPwo6wnMYue08ml2rOXrdcIgIPi9X5E1qBurC
   yTtmvtj+cwDWwNCr5H62eXT0lQ5mXTW4Wdjl7YINnJibO5GwqH2q/xj9s
   xMK83976uQG6cyr0hu7QdNdpGYFQlIBgl4eoldWRBb1TgxcG4u+Lix6E2
   A==;
X-CSE-ConnectionGUID: EsBF7cVASg+vFpGw/Vj8Tw==
X-CSE-MsgGUID: MSIxGahyQCeOFOr8HwLFKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="62448684"
X-IronPort-AV: E=Sophos;i="6.14,295,1736841600"; 
   d="scan'208";a="62448684"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 21:10:05 -0700
X-CSE-ConnectionGUID: 49QMl2BKQiKdAQZS3P+8IQ==
X-CSE-MsgGUID: hgv8+tO9Q3uOwlG7vOR4uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,295,1736841600"; 
   d="scan'208";a="131769414"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2025 21:10:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 1 Apr 2025 21:10:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 1 Apr 2025 21:10:04 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 1 Apr 2025 21:10:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cr4Aa9kEq7fvv/CW53Pl/94JtG2AwccuMQidW9VsyTT9ZQrrHhyW1O5aJy4/ZaVNPqisuFL88CHHxGEvBR1O/Zu8fqH84G4GiQBvshKCYnKHvxZEXdofAKV8gN1XlcqG2DwOYtaxt+r9OYl4IoKSmtLmGhC5FmAjMTP7Bxv1b3wRJRZaKGW2NchnxGyiysLsAX5kCieo+aRiTL1b2ZAB196lkcjWEK8BsfJP2PJSNGI5Odt9HowZ1jCoT0Fe7oIXJxhSa6mV6kq0vz+MbYRRFLYbYdXc0jHnjLxhpl5Y7Ep40RO183kWjnYa6mCKYekxabYU8gj/fnKj8rWeLFyp/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UA36HeRmoeWBMVwDtR4gcMctW6R6YJKTVxPXORtcn0o=;
 b=kjajQBgRe/48S79sC7VTw99R5H0WCaPhRVF/ebtrtqYCt79v8cch7soRKhMSep8/u5XVRCeggSSzkXM/QXrmXhktLCfmkzudngAuMi5utAr3lafWIm7Yml0yf0fXhRA1tv+4Ab58r90s0l/SHrMB250dr6dYJ3+yqUVLsZJQkg9ZlrHoPkKBmgWB9Lb1J376r+933XiScJDgcE8lcoRrCmfv5Ou7YkALC+yxDz9lY0IeDiQTYauD0pCOJ/nDUprMcZNNQ/U5Uu5aabQSebS7ej8o+8WyAs6cGdeu3z1WkR0pJGKpA5aPtA1FZqcxXypNdYwD4JE01VX3qaD7l8yfzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 SJ1PR11MB6177.namprd11.prod.outlook.com (2603:10b6:a03:45c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Wed, 2 Apr
 2025 04:09:34 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%6]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 04:09:34 +0000
Date: Wed, 2 Apr 2025 12:07:47 +0800
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
	<linux-kselftest@vger.kernel.org>, <linux-fsdevel@kvack.org>,
	<rick.p.edgecombe@intel.com>
Subject: Re: [RFC PATCH 27/39] KVM: guest_memfd: Allow mmapping guest_memfd
 files
Message-ID: <Z+y4E3tcOCOJxCiS@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1726009989.git.ackerleytng@google.com>
 <5a05eb947cf7aa21f00b94171ca818cc3d5bdfee.1726009989.git.ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5a05eb947cf7aa21f00b94171ca818cc3d5bdfee.1726009989.git.ackerleytng@google.com>
X-ClientProxiedBy: SG2PR06CA0202.apcprd06.prod.outlook.com (2603:1096:4:1::34)
 To DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|SJ1PR11MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: b6015ab0-7da7-497f-2e77-08dd719c2d31
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R2DN0XJzSzhGduJAr9Al5fh+jznBU9SR2Ijd6ROWT19Vsmq4Z+LrnWfZtr8O?=
 =?us-ascii?Q?Mi61invQ5k4u0oW538QAYpH9bBfdomObcN87GebH2Fnrkskid+6iuouM5tlh?=
 =?us-ascii?Q?AQVprAXMj1aUGyAfCH5nh8kT/U82sdhuLRzAdEu0kGIow/XV3J0pPHo2dFLb?=
 =?us-ascii?Q?YQEwtnI+XZAtCkHTY5/Eq3rG5FDckhEZpebgRe9RcBzJDBwT/GwhqVpDBB4j?=
 =?us-ascii?Q?moX4YxfO8bvwhD2NSaYWdOX3fvMdNcSCkEuT3ko+WjUnu0hj2YTL2hvoIRSQ?=
 =?us-ascii?Q?T4l9H/eo0X2/6bqrDxKIN0pbmlH437zW8HNZKQpJD864EW2c8wSu5/JPfcOW?=
 =?us-ascii?Q?TwhZWBp7bjz2ybAEqa/evV/XF71rE578JtMnUOe9sDFwDSxAYITHnHBemAS7?=
 =?us-ascii?Q?tKeGkbIxwECzKUpNVW+T+Nwi3n5J9pAUDlWXJH2r/ZgiacL9qVGpTFQNAm2c?=
 =?us-ascii?Q?Aa97WsMjkKejZwyupnMKxan+QFNHy4FCSnDTPXlaEBsud9Uz3q23LoViIUb9?=
 =?us-ascii?Q?ON3mq7MzMDXpMo0irL+7649Hg8l2VKgsMjTIl8LinEeQXBiUQkIH/y6a9y+R?=
 =?us-ascii?Q?hHZGb5xV8HcsJnx600ZCEbergIkovYl0KSDy0e7px4J1okWKmx7A7ho0bHcj?=
 =?us-ascii?Q?05iNREar5CVfioVuLr9WsUvSzuxX38/fV29feYyYt20+5QqP+xevHg5DHr7p?=
 =?us-ascii?Q?iAOqyxTC8tq9WRt8Nd1nIVRTaLQ2Qy/tk+qPDlC1mav1+2g/FAb3uO45Ga8y?=
 =?us-ascii?Q?L9rP3wm6l4XmEh9UvyD81Dw5/sQKzfRuLZABc2zGjCbn2LibbZzWOPrddNi/?=
 =?us-ascii?Q?VL4zMMfdPWTzc/+5o2k0qOXKWZ+R25hSjsJzF+P3mnb5upxX3mCwNpiF80Hs?=
 =?us-ascii?Q?FE59jm3JROc6lCLSKSOEBKyr40KKRXKshPfnGit55t0djR/lmF1JICYVxX2V?=
 =?us-ascii?Q?wYlp/+Pm7NgvNtB6gOLBeHZV+8kmei2h/Zj6k/p4MjvoOycqHjyP63NRfw0C?=
 =?us-ascii?Q?VcRN9X8dIQu8IBvAISHJJsj/w0eNjyMd03AyqbW38RVta53n+9Ny+UPuMWZK?=
 =?us-ascii?Q?oH6JWPCKqqsz5ZEpWnRMhjhujHjGi7eyUSkPJbzEOJ6XkPNdvXwLT6Ff+r6F?=
 =?us-ascii?Q?W3G09zPesjrPO+Y8qdPqVPAL7iH/+p0FJa+YD1vZ2cVEgj+3E24T0b3YkS/6?=
 =?us-ascii?Q?tbzwacnqK6opkmDSnSb4tLzhHE3pO4h5rmrfCegGHwqqmf2zDmkSxRoMLQWD?=
 =?us-ascii?Q?toP6pdx3+bG0+04RMSxnEBsZqBXLgi4BM1hMiHYpKqe4fAWgxKPCU5vBFIhP?=
 =?us-ascii?Q?moKA5t9l8EXiJahPMYAqKEZ4UqG4qoOeEk57Mtz9OUOS+qvIBbYmaeqyPw44?=
 =?us-ascii?Q?DsLQtrCjiW0AcqyVCXXT45KH4f5Q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D8QyeMPYQO2Srhn1K9Nzp39ZUgtRljCaEbwpFRNHdrl7buGYuvmq8uDMbNdr?=
 =?us-ascii?Q?vAvt2OMKOwX+aFWpGaitEKUgSbeVX1GYemcFK9Yq7aOHUp5K/oWTzWnr/a69?=
 =?us-ascii?Q?zpY+fSVLHpkQshgcHlZ6KKTUvfb3hDZXCGJaDkIBWHjbnwlrhaKYaWjG8mx0?=
 =?us-ascii?Q?4drS83WUo4KSlrZz0neciwYjfyntvfCDBXI39LbX/ioBRdpluIZSeVDuzXa/?=
 =?us-ascii?Q?qvCH+xQQaOo6LK2/4Gdbppr00uHRGTd6xxqYwvTcsDHQ5dnMb9bf0JnPxhNN?=
 =?us-ascii?Q?WN+EVQmwyysdbSRb7ybJkcxv6otYKbBi/amGam5ln+CSiyDS4D24xmogyjIy?=
 =?us-ascii?Q?6YA4XRqS0t6R6GagHzv8BDuwcA1ppyW0DPDG0ZnMI4vlrxHpLlvL03E8qQNe?=
 =?us-ascii?Q?zV08gdAOhKC1+4UM/OtoPb4PxsxZUtDgEFo+rtprqH93D84SjtSxlVaSNDbz?=
 =?us-ascii?Q?TeIMpy11tMhBhUuYvqLubDkXXbn+5prCMJDnXQOgIviJIYbO5A9Pl5EduZI3?=
 =?us-ascii?Q?lTEdHg94wOnDONEahTSI1FVv4sHtKHVgXfmcqsMZvpfEViPTXslatZT/lD3c?=
 =?us-ascii?Q?YlUw8Nsx8foSu9YuqBVVXECtVrOVyy5GzZkdz498gVNG8bkbUDrxsx5wmxaB?=
 =?us-ascii?Q?/UIeTXs/YQKCce0CIzs+QQ1un94sBWjPxYcO0tFIO6dC3GZtYL1ahueut1Mt?=
 =?us-ascii?Q?sPGB3VxwjCzS85xHFPVhpvB8uXCNTyu3DwkKtaDZ/XUnhr4lOFE57259J8YG?=
 =?us-ascii?Q?H20zNbA/ohWTTZaIW4Z7Ou/daW1+LcT1KEthUlBBCCBCa8BZ4e27+NSXeCgi?=
 =?us-ascii?Q?1yDhbjHwm7qn99WmI+3zS8eJIeEK+Lc4BLxCRxWNji32LoFjor40KPWhMzz+?=
 =?us-ascii?Q?ArScoSInNBzMrbkb7HNE6C8h8BiUTzM/aSAnNl3ajAId+gTa9RYfFzBaVOJE?=
 =?us-ascii?Q?v0WA8z0h2oo4MnfkqGUV1x3DCOmVdOGcbU+RmIF2vEAAPXIlRy3OwXJHOqhT?=
 =?us-ascii?Q?iGZRHYFZimLqJjyEBRKp13xY0gZP+zhgTP9nU6Ef4JaUOgBbHT0G42q/uRxK?=
 =?us-ascii?Q?QNic+rUJgWsJHjDejlywr5aHBR0NFr05ViJXBkSxJaACAX5Vxfb1ZtxYvu2U?=
 =?us-ascii?Q?DVFXGwUDcw4eD10x5OnqbN+j72KH58ssCODshw0Ji+Py4BFufqNNUNnYjPHg?=
 =?us-ascii?Q?25bd/WTiNiG8X+Elmcgw8na5OJA6RuTYTXfJXVUSHf0YytRkMj0bUB4Rwjeu?=
 =?us-ascii?Q?XDHtG2hQwKJTB+WZXntXm/gWNg14C91ak9+bQNaHuDCKB5vFpCVKJ/lOQ9N3?=
 =?us-ascii?Q?wCde2/k3A4R6DvW4gr8DW19Q8ICUXqhK1S5b1CuPBm56H3I7X/veMmZC8Prl?=
 =?us-ascii?Q?jPXjVKsnIUI2apG23rMb5sHrYAdu6Tb9SlufUN8CKnR8JHDe9erkI51zmomR?=
 =?us-ascii?Q?9oyCQlhVuUW79JpyuwKrNopjRmIhbjbNF4AEGjHfcs+iVzsRRgZTT1XWeUHZ?=
 =?us-ascii?Q?E6nYCeJaUSPOw5gyr1+MxhveFXaBh4TWwxvhHbneoSqg2zag5w9vF4vZd2pl?=
 =?us-ascii?Q?musE54k6MN+PNTsNK+mD3DGROnX7MQbY/d23COt1zIeSJLlf0w6kSs+yUahZ?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6015ab0-7da7-497f-2e77-08dd719c2d31
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 04:09:34.4872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZShPNhFtW70cnMUDAg0GyKANDYQNnXJbF9ltijd5spthpfiUz6UelpCVGd+tjLbmyd0KCkv37vI+36tS3IDErA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6177
X-OriginatorOrg: intel.com

On Tue, Sep 10, 2024 at 11:43:58PM +0000, Ackerley Tng wrote:
> guest_memfd files can always be mmap()ed to userspace, but
> faultability is controlled by an attribute on the inode.
> 
> Co-developed-by: Fuad Tabba <tabba@google.com>
> Signed-off-by: Fuad Tabba <tabba@google.com>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> 
> ---
>  virt/kvm/guest_memfd.c | 46 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index b603518f7b62..fc2483e35876 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -781,7 +781,8 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>  {
Hi Ackerley,

If userspace mmaps a guest_memfd to a VA when a GFN range is shared, it looks
that even after the GFN range has been successfully converted to private,
userspace can still call madvise(mem, size, MADV_REMOVE) on the userspace VA.
This action triggers kvm_gmem_punch_hole() and kvm_gmem_invalidate_begin(),
which can zap the private GFNs in the EPT.

Is this behavior intended for in-place conversion, and could it potentially lead
to private GFN ranges being accidentally zapped from the EPT?

Apologies if I missed any related discussions on this topic.

Thanks
Yan

>  	struct list_head *gmem_list = &inode->i_mapping->i_private_list;
>  	pgoff_t start = offset >> PAGE_SHIFT;
> -	pgoff_t end = (offset + len) >> PAGE_SHIFT;
> +	pgoff_t nr = len >> PAGE_SHIFT;
> +	pgoff_t end = start + nr;
>  	struct kvm_gmem *gmem;
>  
>  	/*
> @@ -790,6 +791,9 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>  	 */
>  	filemap_invalidate_lock(inode->i_mapping);
>  
> +	/* TODO: Check if even_cows should be 0 or 1 */
> +	unmap_mapping_range(inode->i_mapping, start, len, 0);
> +
>  	list_for_each_entry(gmem, gmem_list, entry)
>  		kvm_gmem_invalidate_begin(gmem, start, end);
>  

