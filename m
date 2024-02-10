Return-Path: <linux-kselftest+bounces-4485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 623B685015D
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Feb 2024 01:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CEC628938A
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Feb 2024 00:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F0C149E0F;
	Sat, 10 Feb 2024 00:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FW/BBrxC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3678663C;
	Sat, 10 Feb 2024 00:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707526601; cv=fail; b=TtA3nQxrKUf39LSqye1c8WsJH2bRmDdGsS8SOSiV5Hpi3PDMlOjs9UBX9K1WGuQVZYQGJdzSu22G6DGrBlbvgKRWHk1zp2ItFX1EWLeLo7U/0RU9qMg5lQuq8l9lwqUCjn/BrFlZcfxSgGgFjcuiOImFOxHsrvmbjYAuk8MU0Jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707526601; c=relaxed/simple;
	bh=eHLB97awJEJ/C5FMiZKCcLeJA5HOwNV1xUMwsHwO2hM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IoxeHZXwrbKun4MfFkjnYgVz/OexNHvp92ko1OwVEeXZj3yC7Iapch1CAz9v4A/9vWMW0NkPDrendu4dNeNIpt88OlK4T55nVUMN8V5t/UkwpCITzdijDoPNMIO4AIw8n9mpEVFsyhntKiczFOqdC1YjO3KBNUAnpQEjvsuSki8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FW/BBrxC; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707526599; x=1739062599;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eHLB97awJEJ/C5FMiZKCcLeJA5HOwNV1xUMwsHwO2hM=;
  b=FW/BBrxCuArwROQldaBhMVqRORQyLdaHTB0LJJLfTkCseAfqHW2F7WQZ
   wF1wBkwthvhrKbCkSDhjxShSSCPxhET297xdq/rXPe4Z/KS/L5c15d0Nd
   9aIbq9c0FVuEwK+HMD5Js27qqtsTNv2faMZViaMzzJlP15eJkr85ZROrB
   Vh646gFrJJq71YLs1OrAQ1eM19aJJUQo0/sJDRRzw1eKQYv604HoE0fz2
   E4XrNkvb6Xj9xfxAuDvnHtBnGYApD+OIE5vgivms6Y27PWPxjGoJm3CyM
   vSWjjCSKrD6vPW8fxTpqdJ4A6BdqYrDitZ98QnOPjPsko4a+gotFgayxo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1389713"
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="1389713"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 16:56:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="2110044"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 16:56:39 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 16:56:38 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 16:56:37 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 16:56:37 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 16:56:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZp71Co3qbx6n4K6q8epcrt5Huk2jj0q95eH4+h33fbdXCV8u9vtCJYIqGTY7Syvei5iUjtL8yrsQmOYg475Ekz6NfYVEB0QlbsIKq43jun2rmH4t1FC7+mTFTxPLaHk/kDb2irzIbkcKlHQ+QDHzxHtW55Kt5v4XqR/Cy7Cs1nMeCL5cQgQUrixC4456C9u9jxd2M4ijwCxA+lor+uj6FvtASzGhz/QKTSMLWI8kanHf8gKauC8uTqf3aURQHwosGcJu+aqnh7XwadLag/ZRwBvyLA4I40hAT2o4ZyLcLIpCj7/rHPbQdsCbcYLvvdpsYx4V3ShWxCeXfhc923EuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHLB97awJEJ/C5FMiZKCcLeJA5HOwNV1xUMwsHwO2hM=;
 b=cA5ZqI+aF5LNB3CipYR4H7Swe2wKApkEdWnPjE0eSkE4IaowXnqyJw5xzgyguSXiP9F9eph8maTJLS+QtdPi9bCU6OHBFKPvPWhvZAsMasYZ5rrBdTKVbXeOl94Z6lS9ZW304+VOMgVO+OIj6DtA4Dd64ZwlNDrJaLA9XKSZZTEeC1aLR03GKfZl23EJEarVg/S6bUVpFXAYxINDAxaNlJUBrBMKbTrSdxaIkQ+LDHs7Qu47/x4xNTXj+bf8JPFVR6abw7CRq3ve78ujA+7iFVWB0x0Yt4e7OJXviLUZSSCr+WFqNRpX/bExS8f4RiAqULsQTCBxdKdYwf2UH2r0eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ2PR11MB7715.namprd11.prod.outlook.com (2603:10b6:a03:4f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Sat, 10 Feb
 2024 00:56:36 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409%7]) with mapi id 15.20.7270.031; Sat, 10 Feb 2024
 00:56:35 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "Szabolcs.Nagy@arm.com"
	<Szabolcs.Nagy@arm.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "vschneid@redhat.com" <vschneid@redhat.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "bristot@redhat.com"
	<bristot@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>, "bsegall@google.com"
	<bsegall@google.com>, "x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
CC: "keescook@chromium.org" <keescook@chromium.org>, "jannh@google.com"
	<jannh@google.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH RFT v5 4/7] fork: Add shadow stack support to clone3()
Thread-Topic: [PATCH RFT v5 4/7] fork: Add shadow stack support to clone3()
Thread-Index: AQHaVjTM4mh9/kTPoUSvLm4ofHC7c7ECy5OA
Date: Sat, 10 Feb 2024 00:56:35 +0000
Message-ID: <e8da3414f4ba9311dbde3945cb19297feb79df82.camel@intel.com>
References: <20240203-clone3-shadow-stack-v5-0-322c69598e4b@kernel.org>
	 <20240203-clone3-shadow-stack-v5-4-322c69598e4b@kernel.org>
In-Reply-To: <20240203-clone3-shadow-stack-v5-4-322c69598e4b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ2PR11MB7715:EE_
x-ms-office365-filtering-correlation-id: 9f739078-f937-4ff7-a78d-08dc29d32186
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: woWUveDtO28kBx1oWWquRFt19v3Z+eytEb7cX8uxCBeUFWVi78G4vCV1YAmFAhzf5c3RTXVdhi4ZBMC8gnSj18I08pKfBduOkR4krIoKZb175tr4rDd3LdJN+eYk11NWil+43uy5Q7rO2PsKOl+PU20gx5rqM08BTh8pbyslg58fd28a2hcLy9PqYOx3ptgngLAnqoQa/gUuqyA9IZ88hXPABmg5lVPb/dfIbr3u9E5QZRjIao1egfrqckif2b50DLih/dTxTOS6uRSAuhrFUV3C0vRQbijpMiGAR7iIM8ntXENOQ73/L6sK+wiRfORnHARLGL3OxOmOXzHbQ13kO3V+964IFaYkGS104w0RKSRZT/8FTLzKFTCL1SvMJnXOYaM4UheySJpNl1OUW2ke7N/YeChro5SdUZK0FM8tB1m8SXTOGyIdGDZfsM1lTlMPfXcCZHzXhiOU0ymW85Ap4CzX2lAtzDXwIGz/oVopzG2ttdc09PdgyPwcpIkmqwf5+En9cbq+OrWJFKCL7t5GcOrCFKJn7Oo2mQY6eBV2gHy64OQdnyGSLn+iwfQWk78qiY7jeg+6+wsy9Yc9X33DF/FzXVlpv0PIBbYCRuUsc9bqE2xkfsWyWinm6bQl1zzAlWS8fAONw9ADyNPxUKxDzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(396003)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(4326008)(66946007)(8676002)(5660300002)(7416002)(76116006)(8936002)(66556008)(66446008)(66476007)(64756008)(4744005)(2906002)(26005)(38070700009)(921011)(82960400001)(122000001)(36756003)(38100700002)(86362001)(110136005)(54906003)(316002)(71200400001)(41300700001)(6506007)(6486002)(2616005)(6512007)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWxpWEFaOHJ5Y0gzRDl2ODF3U3FOTW56bUlha1NjNVZaY1k2TXNVTDllRXo2?=
 =?utf-8?B?N2RRNUdpdmNNbVVGeURDWVh3VXpTeGlLSm5WbWl2L0tmeWVvNjI2VXR5NlVC?=
 =?utf-8?B?ajVacnNpbmdCM0ZpRWkyVHlUU1JpVTQrTWlpcEpxVDFuYms0V1U4SW43ckND?=
 =?utf-8?B?UWowWWJZZXJpcXh6NXZGRHFkb1VmTDh2L2RQVGkzaFpscEExdWVZekJ3WEw2?=
 =?utf-8?B?OFpMckMzejdWMWtDd2gzY3V5UXFaeWRTeVlDOEFMd0g2aXZyU01ISW9WMndY?=
 =?utf-8?B?OEp6NGhOSnhYQmlBVFVaNHU5VjQrVWxueWRKS05Kcnp2dWs4OGpBWkRRVi84?=
 =?utf-8?B?ZGd3d3lzMUNKUW1FZVZYWW53Y1dpVUV5blZRcU96MzhXZGxTYUh5SjE1NjZT?=
 =?utf-8?B?ZU9sZGRMWGdwbTMwU3Vtcm8zRFZLU3NlaEVueTZNZm5mVkV1eFR2ODlmMjVt?=
 =?utf-8?B?NmxaMTdaVDQrWFVqNmF1SERpeC9vRXBESTZRZXYzdG96Mk14Q2xvOXkramt2?=
 =?utf-8?B?VjlBWlp3R2FUcEJKN3pWYnpCK01XdCtmTjQwNFg5dUFrQmFSWExxcHZCSXJH?=
 =?utf-8?B?UEE2ZUhrancwYWJYN3NnajlQeHVoSFptdW1BWDc0UGV1cksybmR4Y0dIZUZ6?=
 =?utf-8?B?NXduM2dCUlJrUFVKS1NMTDl6TVZwQjJ5TU1PdTM3aGFJYkpxL2hEV29Bam1x?=
 =?utf-8?B?Vzg2Qk55cTFlc0xRWisybmNJQm8yczZYbGVWREZCMW9HM2JPcjBFdDg0M2FW?=
 =?utf-8?B?TXVKMWNsYVRiTmJGYVg5WWttTlVYRndEYkY1eDNMY0NsTjRpc3liZytEYXZ3?=
 =?utf-8?B?NGdpR245T2trc3pHTzV4SUtqRmRWdzZzWncrN2N3VWVIYVNkOEdTS3hPMVFL?=
 =?utf-8?B?OStYN0Q0L0hyaTJHNzJmVHNnUVF4d2hkYUlnVGdEcnJ6ZlBZSkxFeC80Mnox?=
 =?utf-8?B?UjBwdUNwRitoZXFxb3E5MHIwV3dDUm9GcU1MWXNNZ3JvRG1qdUFURWNqQ1pm?=
 =?utf-8?B?WVlTVmVoTmtwN3F3bUEzZGVrUnF5blozdndIbFNMT3gwMjRVYWZKUEhjYW5Z?=
 =?utf-8?B?Q3lWcE85dG9WbGlRZnhRdkk3VnNocDhITVpsY25iRmtOeXp4cnpXc056NnlD?=
 =?utf-8?B?eDJFbW9VdUV1dVllUDl3NTgxbGhLZC9SajBtZnZzRGZ5U0tVQzNvMlk1UHl5?=
 =?utf-8?B?enQrdkQ4LzNKeXd2SnNVejUyWm56d2phM2ZUYmFCTTM0WldlUDlwOEhpaVI3?=
 =?utf-8?B?YUJISzhPZldHZ0pkbkhZMkxYbWprYlc5VWZKSTU4K09kZnBPWWUzQ2JmNWc2?=
 =?utf-8?B?UncwN3VyNWJxaUtYdE50VkFSbHdDYVlEYTJPNWRjTnB0L29BMFdLZmdCTnZ6?=
 =?utf-8?B?M3BrVVoyY1N5Q2YzSXJCUDREMUdBZW01WmwwdWtONEx1bXh3UWx4MzhqR1Nw?=
 =?utf-8?B?Nmo4VDVpZnkrM2hjS0hCS09VOHZ4TXdqcXlGTXI2Z2JUbTFnenRkQjZnNlBY?=
 =?utf-8?B?ZVJVSldLKzBVMjdSWmE5TDA0dWtmMlNKYzdSVUluZXo1THFCdlp3aGpWMkRI?=
 =?utf-8?B?Q3ZvRlpHc2ZRVzFkZm5yUHVTbHVlYzFEWEE4cXlTTTZDQmF2N3VJWFZHZWdZ?=
 =?utf-8?B?Nmp2aWxCajhwTG9SS2JJZXVqMVhVVk9ZOGQzblBVaTR5bTRlamd3UzdtUXJu?=
 =?utf-8?B?NGRVenRwa2NXOVJteXU5TWM4ZWVLcldJQ1VHbE9CaTNEb2NZZFZNa3NUOG5h?=
 =?utf-8?B?OSt3dzV5L1pqdGErbURCcVRVYWhtUko0RSthWG1zSWNmdE1uTTdMZUFrdk1h?=
 =?utf-8?B?emdsZ0dDQnJYc1kwVWFJRjRQYlNqaEJBdk9MUmlYTjBMM0dYNDRMZE82MzQ1?=
 =?utf-8?B?b2lSMEgyZjFIRUxjMVdQMXN2OEdVSm9nTkcxaUE2Nlo2TkpOT3VmUGU3Q0hi?=
 =?utf-8?B?NWI4RDF2VklhTjF2S2FoQk01L2tqWTYrNkY2VGVCa0ZBRDh6U0NtZW9Tb0RH?=
 =?utf-8?B?WmRVN3YzenJPMzI2TlNmVU80NG1RZ0l1OStPRVFnT1VrZGVkVDlZNUFBcU1J?=
 =?utf-8?B?d1pLVCt1UWU2RmdaTmhlNmRFZkNOZUFhZXdGb0NBRWNSdzhPWGhsUERzYnA5?=
 =?utf-8?B?S3lmTllYY0kxWExWUGZmTTZxTXFnMUxDeFZoY3pKUjVqdUxrRngvQU9QNEZD?=
 =?utf-8?Q?GmtQcDwvmQoCiPpyLbG57bA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCB07F43C4400747975EB25B77F38E12@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f739078-f937-4ff7-a78d-08dc29d32186
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2024 00:56:35.6436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 67t4qdNELBIsfsXPRlh8BPGm+IG2k3pxTWnNEHum52GRpfec7c4t7SIkpf4LadnSLrPQC7//aE6whYF3gEeOCN0Ye9Smns3JJitPXGAm+eI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7715
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI0LTAyLTAzIGF0IDAwOjA1ICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOgo+ICvC
oMKgwqDCoMKgwqDCoGlmIChhcmdzLT5zaGFkb3dfc3RhY2spIHsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgYWRkciA9IGFyZ3MtPnNoYWRvd19zdGFjazsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgc2l6ZSA9IGFyZ3MtPnNoYWRvd19zdGFja19zaXplOwo+IMKgCj4g
LcKgwqDCoMKgwqDCoMKgc2l6ZSA9IGFkanVzdF9zaHN0a19zaXplKHN0YWNrX3NpemUpOwo+IC3C
oMKgwqDCoMKgwqDCoGFkZHIgPSBhbGxvY19zaHN0aygwLCBzaXplLCAwLCBmYWxzZSk7Cj4gLcKg
wqDCoMKgwqDCoMKgaWYgKElTX0VSUl9WQUxVRShhZGRyKSkKPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmV0dXJuIGFkZHI7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oC8qIFRoZXJlIHNob3VsZCBiZSBhIHZhbGlkIHRva2VuIGF0IHRoZSB0b3Agb2YgdGhlCj4gc3Rh
Y2suICovCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghc2hzdGtfY29uc3Vt
ZV90b2tlbih0c2ssIGFkZHIgKyBzaXplIC0KPiBzaXplb2YodTY0KSkpCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gKHVuc2lnbmVkIGxvbmcp
RVJSX1BUUigtRUlOVkFMKTsKCkkgdGhpbmsgZm9yIHRoaXMgY2FzZSwgaXQgbmVlZHM6CglzaHN0
ay0+YmFzZSA9IDA7CglzaHN0ay0+c2l6ZSA9IDA7CgpUbyBwcmV2ZW50IHRyeWluZyB0byBmcmVl
IHRoZSBwYXJlbnRzIHNoYWRvdyBzdGFjayB3aGVuIHRoZSBjaGlsZApleGl0cy4K

