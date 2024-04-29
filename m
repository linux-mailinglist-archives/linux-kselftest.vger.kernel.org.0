Return-Path: <linux-kselftest+bounces-9008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C910F8B5313
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 10:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9246B2188F
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 08:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6886F171B0;
	Mon, 29 Apr 2024 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QcLweRUZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16FCC2C8;
	Mon, 29 Apr 2024 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379098; cv=fail; b=JW3iRYOmTKONVnfwn925YLTIK4lBp4FsjfZESCaMGb6YhGxSFmdZPDQ7tA96AM3EOeTXVMNRbVZsBf5pxdUJundprMlzls1r2/9fscl9KWTUWqnNPiiiUqb2IcaKYZOEbwkovErAjHtvnb94NuU05CtKdLa61q+574jzFUlOo0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379098; c=relaxed/simple;
	bh=m1BuMs8kjPXFyLZ8Nq3z0PPo0OhPoW4XWXlA3PrwVTQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=izN557sK+RPMfHnLkwiwqpMbZoFBj/cZe7bRzNZiVX1vReSKpY9tRLSSkPk/n+u897SDZKjl2WktInXhkj5vlzUSmxH7ZaDak1pFyR0xFy7jHZNlJ05PYGhZsSvOVO8M4zk4NMZ9ex/e8MOwMMo2PhIswoiD8jkGmSK5KJuQaEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QcLweRUZ; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714379097; x=1745915097;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=m1BuMs8kjPXFyLZ8Nq3z0PPo0OhPoW4XWXlA3PrwVTQ=;
  b=QcLweRUZR7Tsx0Iy3BPYVWBgrJqzfQwmSLZtUViXWf53Ijh3lk1V+axy
   aWIRyLui6P7MNXUM7MTlNP8azeDMvUb69KdcQVR8TbHgI0H1/CprvzcWk
   gd22i7M/UYYkyw3OxqLqe93NLotn6OXbzLS39xDN/tcabvkvHEoF0GjUE
   BPdJ5Q8pEkqTcJ7WeXH/uTMduJ11kAAQ7NJQFP7Oja7/qmALKAFmt396o
   M4A3eDltO2E51Ayl0qtr6rFNLnIRtffD9olSZTcgPC8xHWWglRLrY3SMl
   XvvttXjDKPABMTs9KQCsnZKGM/x2fCSFhfl6y/8MwNdUA3umOBQzvm8HH
   Q==;
X-CSE-ConnectionGUID: N5/o0WyeRcSIegfp6Py4HQ==
X-CSE-MsgGUID: K3ZY0M3zQNqqFFS6TZkJ4g==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="20716508"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="20716508"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 01:24:56 -0700
X-CSE-ConnectionGUID: MJBUwL0TRI+KklCWBPY/Tg==
X-CSE-MsgGUID: +R0rGF3WSxu181e4SqN22w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="30498174"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 01:24:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 01:24:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 01:24:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 01:24:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 01:24:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuzewmpIe2rFbmcy//Dp529EpT4pvRRI02aFfrNwL01FodTeKz+5k260eUCfoR/YJT8NNr/VXoD0YB/RTHHodrh8j9g6aFMYupc2eIqAuDaJeFVxeY8Edq2AghqUvQMSTI7Xhwg1NIs+rI5BMTcGkJTuHopxG8v55Gn7CmJVYCjEjOYHwSO4q+P+/ZjbvSy5XeTcOeJOKAtWecEAQPLTx1iw3d8eQHHefgRxaFIutwyYzBHmjQz+H311Dr/rfUwKqVsbB4aGb1UlHVmNShX+EjyWETk+g1zeer0/3S5WO3UAPbECVL8vrsda/JD8U+q8gwL9hDdW95yq+6N/Vso4og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uT1t1K6STjEQnT+Bnu7JVmqsm8d5kwGplG875R5I34I=;
 b=FlDCyhPVFYmKa1cv/qb5eAWPxIY+nB2a7R/UuM+kDSjbX29mBlL6qjLMzj2SDog5ieVzyiSthE75mQKGAWz9HGnnTvz5jZdhUlb2LSp1HNgM5j4qoc7mDVhuHu4kA6ZhwhG2AGS50bMvW+vrltTeeqX8DUlEv/DJMeq/m9P/D2GhPuT/eRbNIFzjG3vRyg/0trHn81OtXjC6UuczalWw/x41H9jM1yUvbycl+uCIjqZTE79ghYpNMvqwAtYdhidQPxyndKMcQZxYCP2++xkjFsHCTyFCn1I+RXAYan17RKhM2OS3Ar05njd8NIAXVoCO1NDOwpch5Bk3LNv0zGgy8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by SA1PR11MB8575.namprd11.prod.outlook.com (2603:10b6:806:3a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 08:24:52 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 08:24:52 +0000
Date: Mon, 29 Apr 2024 16:24:42 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xin Li <xin3.li@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "Shankar, Ravi V"
	<ravi.v.shankar@intel.com>, "xin@zytor.com" <xin@zytor.com>
Subject: Re: [PATCH v2 11/25] KVM: x86: Add kvm_is_fred_enabled()
Message-ID: <Zi9ZSuwQXl8/Ncs/@chao-email>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-12-xin3.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240207172646.3981-12-xin3.li@intel.com>
X-ClientProxiedBy: TYCP286CA0252.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::10) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|SA1PR11MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c341f85-7c94-48cf-3002-08dc6825d79f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hnRNzy0Qo5W5Oix0OdxvIrrjaW88PPliKgvkFoKowDSqV9waQbRzrO32rjUm?=
 =?us-ascii?Q?gO6qGsVnPcAtwhpoWFQ/6h+nfhRHojjc00dsHvIxpo9oz4bdTTbnVor0/SYB?=
 =?us-ascii?Q?Mh1CGzzp7nFAKjUFVkfDjkJl85ovd0TXEKmUG2hptI+kmrMcOk/UYExRLscy?=
 =?us-ascii?Q?rOAMV1KV7e/Zt49BiR2xexAIMdHBzq8LRAW5HFcelvc7oaZPNV7OFqZLj+Hs?=
 =?us-ascii?Q?U7+UM8MDo9TPGkT5/JSV/FIV74+x5Sy9wq4c49h9Oq4KBOsn8MBsNDvUiI87?=
 =?us-ascii?Q?UquYlRHn3c1TYnEF+YDpHoBSSLKdwHhg2xbntnYT3rmcmp3Lnpmab1TzRv4Q?=
 =?us-ascii?Q?/w9sng8yHxL8tm5dQb26DKBn9mZ3XDnyWLRAnYTmDnFB27ARw40UrI/rA5SM?=
 =?us-ascii?Q?67eqzdlXJ2kxl+SK+fU5NFdM0Q/jUwK50pkr+WEf/4BLbbljltVUIFgZpQex?=
 =?us-ascii?Q?F30mtwF8h6lzqsQjzhlnPNOnQgaeUn4nsPYAIC35Yr9/Ec/PLN7U+nGoG1Zo?=
 =?us-ascii?Q?VRPvKJy4vnWkJwRvQr2/4U7Yx/UpSOmbp2w8Ei4DIgnCgcwCpzs4H0aDB+2x?=
 =?us-ascii?Q?Zh7nPVmGOQsgNDAp8K9OWRszuTDnGam0SJy23EDrO95G/f4iTespVdVpoQwS?=
 =?us-ascii?Q?GGt8uOPeqADZeW4AAumnB29t2MZ2Z204T1S6hrZm27iVh4LoRS9Ib4MKySbe?=
 =?us-ascii?Q?ra7UQWaDe0TVO84ZJC6RrmVXUJ0Balkl9LItx9/sk1YwxqX7KLrpwFzd7+Hw?=
 =?us-ascii?Q?eMvF0AEW4Vfd3CRv3fWi+Cq3pu2kn260OrY8ISY5uUXdDQm/JSpGFKgzc+D2?=
 =?us-ascii?Q?ZkXRyR9C0U8T8Ir5HR9eeX0JRq2iE8N/mvAO6kd8+gP4o+qhSG3TabYcGiAr?=
 =?us-ascii?Q?pld+zseGfM96pgenl1/yo1pJfJxCocjWrNLB6jqTx/MLy8oZO+oEjiyWnz29?=
 =?us-ascii?Q?CVXepGR7J5bfOn2eYWtxfX7epuP5B9kQSc6tDY7tOgCJrXEJuRf9DEYqh1ui?=
 =?us-ascii?Q?ktqYyRIMPdpK1/1qcwmjK4mKHC0QGhxxcNyzA6rATiJ4j7e9Y1c46R7UJRaW?=
 =?us-ascii?Q?ZkfTJxK+dTsUponHOEI+QBsfQxcK7kl6KSlkZXHOoYm/nwsHrswwU/3Fzx5x?=
 =?us-ascii?Q?ijfcMSMD2ce8bCNqaQY6TsjkEhIo5NeW44NaFXnUKNPu0FPr53P9UJXcoISJ?=
 =?us-ascii?Q?hRO70bxZkaWwzvj1D7RRRna/TevvV195Jayzj0lUI1XIL+qnLNWhvXTEu/PP?=
 =?us-ascii?Q?EhmUhY4e1PV8tY3RtGQ5gzZ250ZWIdbK1DqeNYYJ2Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rIlJQ2kdfe1JKbZEtszZheabW/RLeJRdwmh3dcA3b9djtWBXY39wGz8XHhWK?=
 =?us-ascii?Q?vQMpvpCXJp+BdIWbB8GviRTpj2HjFCX70685DHiJ6VtSOqpe1rZZHmmWujoU?=
 =?us-ascii?Q?d8HxhLsO+cog71Lpw82f6GFYDtJPZTMHkZYbLyJ2CqLOyf30yvUeg6Q3H7P8?=
 =?us-ascii?Q?fpsF26kIBS8JpGO8MWk8DkCyoo6Bg4T6C7EthtVFrrdTmYm7cEUsKL2+56yM?=
 =?us-ascii?Q?L7/rsub9mA49pUy7xMj3I+ZnXQYlDsjQjtE7CtRzjWT3qHkPM88nbxf4FRyu?=
 =?us-ascii?Q?XYmfLQ8EuloqOqVh5NkKDi4tXAAXpkO4KObnN4756cG4f3tA5Q+vya7PXxfQ?=
 =?us-ascii?Q?o/u6pJ13ino/4zBR72JGEGfLcnsvH0N8WqwWbDLB7VXoXr4AG+/nkuE3LjxF?=
 =?us-ascii?Q?O43IsCBGR4ItigIX87EtSiLuWIEFUt3vdsKKyB9LYYMjvjEUkmhx9UDjY9DT?=
 =?us-ascii?Q?0Y/EPlRpCK8O7EPHaJhiHjJURWSXCmwNDuzD/got1yIqdAJglwe41KxkU6Ey?=
 =?us-ascii?Q?4v5KdVjnCj2wJ0Ztsf7USjkIJ8HpatmjX6rhIus9axg+Dyvk9unZegEA9xYK?=
 =?us-ascii?Q?dBOSeOF9+5kg/WAGc2zJ2ikxOH9YcRJV7KSU8+0EKMcaLNL+Pl7j4Dl7Uy9T?=
 =?us-ascii?Q?01epgltVJCRtGaDaiHP5QuvfefFkFGrNTQrao1iPQ1abtLhUZbvg/L2mDAzi?=
 =?us-ascii?Q?M/PgCPCH2PhCZ0XIZ+z71TkI5NyOYMpsJdyLoEP48zbp17IUaF2wDUgpiRBc?=
 =?us-ascii?Q?FRroYV8Qe7vWxni2XZqGqxbbXOQdNF4+rgs3mgqnpbSvsBMYstRitulhNW8h?=
 =?us-ascii?Q?+zlU1qhbZb7Oc/QDo8rLb5atiDIVkG350p7POYM7kPnW3LfhPT0HHUQHUVVA?=
 =?us-ascii?Q?O9e3h2Ykw4rMoI5kIRn1F05i6YHJXssEkkCyca6JFEbTrUF0Wek9Mh+b7N5T?=
 =?us-ascii?Q?fO9XfDv+Ok06V98vZKhlcOsT+8NDCFCRyRAjyg19TR88PEYiQ2MvoTw6LE3P?=
 =?us-ascii?Q?373iK79l+0kWHneH3gelfEfuICiFP2K6RuJI2t9FKEaiHTiwshaKgMpTUDDh?=
 =?us-ascii?Q?sfFVwuf/7t6+tnKVQQ1Jdc728R/5qiNtxGl0/3U043+reNbYamxdPbZd+Vsz?=
 =?us-ascii?Q?pQ/BkPALhxoThhzGJkKHSCCTEqlBzc6CYcCP7fxfeRIqW4VZl5xQK+vi6kWV?=
 =?us-ascii?Q?VmKGbYGhzcl2kyCDh1cMSorCGxuaklxEjLAtP0u8JN1tdRExTWgDWPKJfgQF?=
 =?us-ascii?Q?fkgR1J+0a06UDbh4Bs+vlLOujjivkZFYNi7dmGl9t3cJYOQ4Xq/2FsJdE/or?=
 =?us-ascii?Q?8HcvSa5p94stVs+Vkk2Q1DbV4xiUpduJbZlPCoo8assEK0HdH2wlUlHTJ8hU?=
 =?us-ascii?Q?C0lgTHUBpoh04XdYZI73Ta8iOwWKWJXImlUFZ6p7puuazDxOG2aAzfCZFj7w?=
 =?us-ascii?Q?64BrhQJqc3XuRT+ISeErEGXRJOBOAlPoJkLJd9ETbMn+vXXbUJM1D7ABDWAM?=
 =?us-ascii?Q?/t1WG4txGUNKrsy2CVKl1HHtZqdUQqfJhJ1aEnr73cvWhgLGDZx6XMLD2NfL?=
 =?us-ascii?Q?op/Cb7rMeKW8S/5z7sLK0cyhz3waZblLa6hMS6q9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c341f85-7c94-48cf-3002-08dc6825d79f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 08:24:52.3281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vg7SFE13iXj30A5gRtr6mUu3jAgADFfMDm2r2ZhKsafh9C2HeizjQ2v1WmV9LFgvZej8McTtVRk1BRvWspfvXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8575
X-OriginatorOrg: intel.com

On Thu, Feb 08, 2024 at 01:26:31AM +0800, Xin Li wrote:
>Add kvm_is_fred_enabled() to get if FRED is enabled on a vCPU.
>
>Signed-off-by: Xin Li <xin3.li@intel.com>
>Tested-by: Shan Kang <shan.kang@intel.com>
>---
>
>Change since v1:
>* Explain why it is ok to only check CR4.FRED (Chao Gao).
>---
> arch/x86/kvm/kvm_cache_regs.h | 17 +++++++++++++++++
> 1 file changed, 17 insertions(+)
>
>diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
>index 75eae9c4998a..1d431c703fdf 100644
>--- a/arch/x86/kvm/kvm_cache_regs.h
>+++ b/arch/x86/kvm/kvm_cache_regs.h
>@@ -187,6 +187,23 @@ static __always_inline bool kvm_is_cr4_bit_set(struct kvm_vcpu *vcpu,
> 	return !!kvm_read_cr4_bits(vcpu, cr4_bit);
> }
> 
>+/*
>+ * It's enough to check just CR4.FRED (X86_CR4_FRED) to tell if
>+ * a vCPU is running with FRED enabled, because:
>+ * 1) CR4.FRED can be set to 1 only _after_ IA32_EFER.LMA = 1.
>+ * 2) To leave IA-32e mode, CR4.FRED must be cleared first.
>+ *
>+ * More details at FRED Spec 6.0 Section 4.2 Enabling in CR4.
>+ */

I think we can give more context here, e.g.,

Although FRED architecture applies to 64-bit mode only, there is no need to
check if the CPU is in 64-bit mode (i.e., IA32_EFER.LMA and CS.L) to tell if
FRED is enabled because CR4.FRED=1 implies the CPU is in 64-bit mode.
Specifically,

1) ..
2) ..

