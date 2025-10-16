Return-Path: <linux-kselftest+bounces-43355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF84ABE59A0
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 23:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98BC74E32BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 21:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289F52DFA4A;
	Thu, 16 Oct 2025 21:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oCdTYrwU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EACE3346BF;
	Thu, 16 Oct 2025 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651507; cv=fail; b=pPethE85yH3N4Z5XdddqcrJimDs21Tbjuq1HgLZ+g1uKHtU3tr3pxSiotWZL5/ex5SI1iufeK1iwtgqcZhUlAOypanlzEfLxKGZyfIwEzChYNQovXZCl49JbFz0uIFCF4Vb5/VjFusCY3mZ5L1UUxwK0JTQUinx/HxaXzON0eyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651507; c=relaxed/simple;
	bh=S5C+mly7T2PjXyrROCaRCPXiLCsfiwpzaeaPAA/Q53M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q77GM89BAiR7CItpivyWkPlSftzfJuAfUmhUXowlgUtdVBl03SlH0+YMvm5ukv1pjPHlxDKRQXbGrvS+E/sZ+Jr4OX7XV7YZB30gpG/vHrpMtjP109pLXbMvwJH96QGkA9v3jfFTIVJ/TUNbgSHL3CZlom6PgKVauxxEhvHuXEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oCdTYrwU; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760651506; x=1792187506;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S5C+mly7T2PjXyrROCaRCPXiLCsfiwpzaeaPAA/Q53M=;
  b=oCdTYrwU6UFqrzu1CHH0v6SUfjGMhAdWAB3Lwde64uE2VNKsfjz9a+18
   yAKG9xVkmgmZWbOaZG8e0OkoS8bb7271/QuofbKa5W3GhLD2fZL1aNaIi
   pEKXHM/rGaXdQIvRuklum28eT+GyB3DMX9C3AFRbt22GGob6e9CbViVkX
   bDz5MyouufeSnfkR1dlvEMEuirxruoYkcaX44NdkyS+wm/tPWFgGCHvGK
   HKvFqlEqpdBRzofSOs1oScHNqYNQQ4A6OW8qp9KPMbCbY5FVoE6JLumuZ
   5xtkzVxIGU2aGyTs8jt+tXIXfcTJ5ed+ULAY00nxomkuRIXYyBW82k/rK
   A==;
X-CSE-ConnectionGUID: g4W3oabrSdSHnUPBg/2BMg==
X-CSE-MsgGUID: 6oMnQn7iSFuIWABLj1e3JQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="73145094"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="73145094"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 14:51:45 -0700
X-CSE-ConnectionGUID: FLNub8JoQuecPzHg1ohzHA==
X-CSE-MsgGUID: Yw9nzK1+TqCb1+9w7J2hGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="219724501"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 14:51:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 14:51:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 14:51:43 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.66) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 14:51:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAm0ftTxgEuFatE/6uPLp3ni7Wkdlt184EZNbrvH+VpOno0XkFJ4oJk+Vhr8B4JGkDWRDzI7brhrcRb/MsnPj2nOgwIBBU3fV/E0lnLxg5XPVcVQqt6BEMbUL8ix8zG6WfRSmPNp0F2xaG0glK2706Qo0DeUqVkEeSA8UnI5S2WTyXGILC6V1XxCTRe1CSJZo+8AuHQjGXI8VcF1/xQnKbniqVNP7K1WC7xXm6z+kITHKCTalcq8f7DhII24xdMoQCccTgSbE35LEPJdozvHNuCyc3zb10aCwKESXA+00OBLdcJuH1r45t+ExzZnYKzSgLh39GajW1IVo32kgvHzpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5C+mly7T2PjXyrROCaRCPXiLCsfiwpzaeaPAA/Q53M=;
 b=jHdp+wNqEC+m6NvaYXZdrr1znAu7rqRJ3QZ2r0TKNA+odowZa15Kotuxv02+eQn04Y3od7IvTgg4Q0VT6vt+Jg/RRmC4OBrMcyGo+aMQ+Dp6qTYoDFNhPKPq9+tAN56LutenFl/tiL61zQ6wHh6+IWyvU30CQXQrncPWQP/+1rV8oabw//WZcys9DF/i3oJx4b97k31lLuGlfaYiY4RvfG1xMN3fu9dzmR5C6v2N8sVB95XW4b2CTc3bXqtsM4JSiZcl0Z2G7g79IUTFJtF0ROj4GViD1YMHqHr5Xqd5SQ6RIfkD4J1pMMj5lspirKecI64Dr1HOyv7R60g+79aJ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA0PR11MB7751.namprd11.prod.outlook.com (2603:10b6:208:43a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 21:51:39 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 21:51:38 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Jonathan Perry <yonch@yonch.com>
CC: "Chatre, Reinette" <reinette.chatre@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, James Morse <james.morse@arm.com>, Roman Storozhenko
	<romeusmeister@gmail.com>
Subject: RE: [PATCH 0/8] resctrl: Add perf PMU for resctrl monitoring
Thread-Topic: [PATCH 0/8] resctrl: Add perf PMU for resctrl monitoring
Thread-Index: AQHcPqvDD+Xv8G799UKrxFq2AuUTDLTFSZSAgAAGg7A=
Date: Thu, 16 Oct 2025 21:51:37 +0000
Message-ID: <SJ1PR11MB60837F4BB475207D990C8293FCE9A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20251016144656.74928-1-yonch@yonch.com>
 <aPFi5eQt1CmYXg_X@agluck-desk3>
In-Reply-To: <aPFi5eQt1CmYXg_X@agluck-desk3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA0PR11MB7751:EE_
x-ms-office365-filtering-correlation-id: b1b2b2c2-cb74-4419-9495-08de0cfe2ed2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?L07xlSQPuupc2sS3p+/fJ/LX+F76umh/JIXR0lBuZz/gTYHn4H94qw6eDMmL?=
 =?us-ascii?Q?DKqDrhN0XP72et7S+alk1uFy2Z5IK5bHbboP00A34dUR/IojJ5FK2M8ZDga3?=
 =?us-ascii?Q?hlRkH6PFA0Awod5dsS8TfdZCG+5JBibY0qaGtLaQ3XHvIaVQ1GSaFZvmFetF?=
 =?us-ascii?Q?zKn7U/WUzP/MP0I3KDn7Hdd5WoC4NAk3aJ7uhQQDIVAXrVD6YnmvHxLTOYZW?=
 =?us-ascii?Q?MGwpJinZuoP88MkQniA8AfM/jQvDTHmSDJFBKfbols8vb+W70C9cBAoPpu23?=
 =?us-ascii?Q?xpSK/DAn3by5zbfErYikIq+fVt9/Erq2S34O93TTMXK1tTT47THHy4BticRH?=
 =?us-ascii?Q?xMVG3/ew6z4QZclyE6w56Py00mEPKVfTp26k/+jS5BPtFKP1mop6ag07SFbl?=
 =?us-ascii?Q?TKZ+6EZY+unOUTJa4Bhmnw7zDi1GtIossJKJeD9RNAQgZ9CKeQx1t+9zjG3u?=
 =?us-ascii?Q?9xFBtARS3FjWPvqpui2oVMawEGpaKc/Uaxfd2qTHexdLxTFJy2Iwn6Bsp8hp?=
 =?us-ascii?Q?vLmt3tHXrZKulWRITa2PqQ33Apjzmhstmf7glOLztU3lwfTO8tbsAlnexmXr?=
 =?us-ascii?Q?mKCRraKYQpK/jIz2Dtu5IrAh/iY/J01FtXgyemkDzDQpVBD8kSoTbtPF5ELO?=
 =?us-ascii?Q?+1fF4Iib3YwwNK8YyLepovMpYWviBZ+W8Nbu6Wp22VQHGpEZeWLpVkB6p87B?=
 =?us-ascii?Q?xoawSNOGWs3d6vYiLq0sFzkZ8XwNjqSXyvWlP1vTVKg9djQnAGClmRJkNWj3?=
 =?us-ascii?Q?aC9YaKazwRRzs6BGFq9qkMYCDRiFZR8cIaeEANycS51lwE5/GdJGmoeLtsHu?=
 =?us-ascii?Q?3FfnbKnj3GtqvJXEfMfgyem6e8zDtFSVDA+Ba80W/CuNuXkF5388Lc3we/M1?=
 =?us-ascii?Q?k2l5zq2WVEbjR08u9r15wFTs0SI8RBHWFoHB4zW+a7aZOTxAQfRiZxfHcSG+?=
 =?us-ascii?Q?vb2TxAiKRdMiyiMcLnfGXUcFs43gsZldGKhhPHizZRc4+OhRat8nntP4NB6d?=
 =?us-ascii?Q?97mMrZCJZrQMySkkF9YLZ83NZzPZm8BV8wgfjfa3LcnX/GRmzE4yzRm9ibl4?=
 =?us-ascii?Q?TbXSaBUCRzIwlGbpBn8IhlRdRAhD7UgB6C+Vn1qyiAA9FBttTbuuNqEth3V+?=
 =?us-ascii?Q?d6nhLX1VBJkbeR+x9RWQhl95LkfQVumo6Z2tWZD75FzdzribH5MStI1QE/Hx?=
 =?us-ascii?Q?rWWy2DgzlgyqDWhwJeUJ9U50r3hqlc+njf3HLlmwcmZtUsSe+7bZjLJ4mctC?=
 =?us-ascii?Q?gt3T7H+4sEswdv9o0gUkVfpvoH1uObcdLdcp2BaPELNj/RH7z0dsxfeJbB4r?=
 =?us-ascii?Q?sAalBVhQkq/WEQeayA+aXWP98JwMpEeDzJkQuY5wK70EZ84GIGjXdFDN3pQE?=
 =?us-ascii?Q?0M4ipxR44xwQ1+9IoPEynASzbJV1fqmzB95ocVUEb7aVfgR7AflS5D9WmNiW?=
 =?us-ascii?Q?tkgSBrDm89lAGQo8FvGQxQLp6kEJYu1ksgKX5LgRdeWF01cLd5mUByoBAhnQ?=
 =?us-ascii?Q?4sx3ljgXUNH9JDeZrFD970BBYud2HfB2MC7R?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lu34eewW+bJqFPQvulygXHNamBAAHTsi8yX2nKsamBjBKX1C2deyTWB1kAm5?=
 =?us-ascii?Q?IIBiKrNHPjBPX2tufTj7iUvX0bc1xVzqzR9uVW0OCl9bWHFeIEDsmrQd754M?=
 =?us-ascii?Q?y6FYBLgcCiygo7zWcVqvjCj8OuHrT5fo7fEKNz445RDutIUiMUwz1fTmcVLU?=
 =?us-ascii?Q?pTEoKhLaqvw14DR7Djy8pD6fpLlztP4eayUPP0NU3BNTYlzJLYUd/I8jvGIL?=
 =?us-ascii?Q?4NFryPeJUfjmBc7eaBKw/uOJwB3gTF8srejv2MvWq1LLiIoD1E9lyEeTLEYI?=
 =?us-ascii?Q?A+tnBI/Rj8Hb/TpMqFVbupdTonlyIOB3Ig3V5g6+8n7ugVsPiQTQBmfvwCgz?=
 =?us-ascii?Q?ZnJ7ka4cWnqha+7cAy7vZ///6/69Pp/NcwYpAujj4jIR7Wr5KzCH5ISHDa//?=
 =?us-ascii?Q?N+My1AERVgyN2eDgZLjk+TG8A8BWUIE0AkyD9DkIYjf5YqNRP8FAzTngIruC?=
 =?us-ascii?Q?PSVkvaMjBcQxOqJPyKkkqn5Y+/CkVzblwILi/UYr67fD6U+QTFNxLqPxy5Oh?=
 =?us-ascii?Q?0Q1RJ40jRJ1hJaOm2AZ079rNOPqtYUKS0jWALEn+2Ug5M8g+jrtCgjvV9f6l?=
 =?us-ascii?Q?TXc05hMsy7T88bSqgSd/BdZPQxcskWZIxWa/geVI5DSfvxDNfc4DABTrTqwg?=
 =?us-ascii?Q?A0kYQnLodxyOhYWYAfDA8CGzqftA+o5ubVWosnhpc0/GARkv6SQYkkJ9xEUY?=
 =?us-ascii?Q?2oh3pt48TnICTLHP7Rsh2OMCQKMJRjKlA9rgQrgAzks2Ra6CJxPzgY8E7lvm?=
 =?us-ascii?Q?+KB9Z+J+9nW42w1JoxTAabWggyjnhG7F9uGsjaHPiiy4kGEhcaH45kXJaEIr?=
 =?us-ascii?Q?ib0kXiLEFJcaFVYnzY8Rl/xqO0rVeC4NI9QwSq7ahZhxDhKKWqZ5S09ZJb/i?=
 =?us-ascii?Q?yEjrOVXXWyIwMHx+qP2/xRi/sLPACXH0QUIMUxiqO6Ih8uoTZbCD/7PXDy3H?=
 =?us-ascii?Q?HGRCXOjVhrCeTUGNGKHmMpw/xwXGxYTJNQf9HbxQhUr3swYgq23S+0ZmmLH7?=
 =?us-ascii?Q?O4Km5DHIsRRxEoBNHIYxGyiPRMpU+L6Hv9SIeMPzl4cQCFUyhiKBD8bwnfVY?=
 =?us-ascii?Q?Z4lYUz324S0LFLwSAgtK5+hnaaqOBZVu7nhm9NCBWt6EdpqJJnxHdP58drgr?=
 =?us-ascii?Q?GV1qc0yqpvjRsaIE3Ta8EoZ77N5m4fnIY4gzu6xyV3QKS+t87al4HD6xiR1w?=
 =?us-ascii?Q?HXvZOWgpOpP/YjgDUiuChWAB82BWfP7VpX7bF0zksLCppHo0BWax//yvTQoy?=
 =?us-ascii?Q?/r/j5QD4mhQbPpKrE7sJBQOtGZz69mJO4ByrdjvM4Z/cSRUtEPF9WA+LMOGS?=
 =?us-ascii?Q?2tjDLh04XBcirYIFaJCv49mxHBfw8v/hseQL+BseReXsk5hWjpcat/0G6srn?=
 =?us-ascii?Q?SGaE2SXCigV6Xb4TTFhcM28xFP5znx62t4YfHSsEWEvS5pWwVfWxFPcGDszc?=
 =?us-ascii?Q?Uumnz1GWT/YsaeYwfUfadhbFA9c7WxzEgFO4FYeXIsehn0+8WtX7sMIhllJh?=
 =?us-ascii?Q?6UTzorKLuDQOaPxhaR8PEZw8hpUwqYMH4ww9W0fCmfaqVxpir5aW8dO6K4gV?=
 =?us-ascii?Q?6ppXLMZvqAmQfrtTBSy1b48xtpv3kV6WidzlQ7bn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b2b2c2-cb74-4419-9495-08de0cfe2ed2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 21:51:37.9075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L/LL8/DgSy/fKVoM9A1e/RgJRhCkoHfcLJrKiXVOgAz5/2JouLTEEa21v3nFj3F12YIxRNWNM0HeaZAZ3hRFcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7751
X-OriginatorOrg: intel.com

> > Motivation: perf support enables measuring cache occupancy and memory
> > bandwidth metrics on hrtimer (high resolution timer) interrupts via eBP=
F.
> > Compared with polling from userspace, hrtimer-based reads remove
> > scheduling jitter and context switch overhead. Further, PMU reads can b=
e
> > parallel, since the PMU read path need not lock resctrl's rdtgroup_mute=
x.
> > Parallelization and reduced jitter enable more accurate snapshots of
> > cache occupancy and memory bandwidth. [1] has more details on the
> > motivation and design.
>
> This parallel read without rdtgroup_mutex looks worrying.
>
> The h/w counters have limited width (24-bits on older Intel CPUs,
> 32-bits on AMD and Intel >=3D Icelake). So resctrl takes the raw
> value and in get_corrected_val() figures the increment since the
> previous read of the MSR to figure out how much to add to the
> running per-RMID count of "chunks".
>
> That's all inherently full of races. If perf does this at the
> same time that resctrl does, then things will be corrupted
> sooner or later.
>
> You might fix it with a per-RMID spinlock in "struct arch_mbm_state"?

That might be too fine a locking granularity. You'd probably be fine
with little contention with a lock in "struct rdt_mon_domain".

-Tony

