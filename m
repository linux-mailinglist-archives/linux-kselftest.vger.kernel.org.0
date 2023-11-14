Return-Path: <linux-kselftest+bounces-69-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F147EA9B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 05:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85096281012
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 04:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4A48487;
	Tue, 14 Nov 2023 04:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ciCYDKPA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C058827;
	Tue, 14 Nov 2023 04:42:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549E711C;
	Mon, 13 Nov 2023 20:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699936951; x=1731472951;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9XnCf0y9drO+80R7CgYMtxrbeEqxUO7q87PG7aSrLK0=;
  b=ciCYDKPA/BAExqyjYh0QKowFQY07lR0DVEamGbWk6o8UhcbGPyKD9ewj
   +RnRwY5yGF2iRBEcGxqHrR6YlvzkkbYuXBcWk1DGSCVF2sAOLjUEJ+o/N
   wK+sHUcv++Gyeys2nLPJRKz68fS/XPWkfWLT27oQkSxq1K3+CjSX3/arZ
   7L5tVBu/E4iDZQK7kX3r5zGWKvBaMPbd5LctJ/PlsBVtfWQQpdz/h2DnC
   UEasU/wSOI0RANRs3T2QnL6JcHr2dHqFVw4DHOpX3kPapgkEb1efNK5tl
   XzCbpAeItGkSoFVsArcUCMG0M3jsJomSgUQYG2Vw9mfx9XcOC2O3Okl5g
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="380975527"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="380975527"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 20:42:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="12671397"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 20:42:30 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 20:42:29 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 20:42:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 20:42:24 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 20:42:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2BG8A+d1WMf+pvRIF63m2oArDiu6OccjW+kxidBn0D6lFJ3Agl8Ze9YQdCUduQ7o/GZjqpBKcNZgndwx/ls3onPWlrVu4z+2x1Yd6DMtd/e0TqZzLcTcWk85WF7gfroqNQpmiuUNTPxdqwwqwr9MwhiGAbTVXJW1DYaWqLICfg+ndpYFbAlp3aG6ykdXw3PkMr0GEh8ZMkyPoIO0b27SZVj7osWEUxmyqC2bhqK+85e6zyFt6nFak4UHzaljRRYhz0P7ramxGCfbo5upgrXtvy9gjqk1oyYGCV8i/yUH6guBmDgJKpjfcXkIyr3g5mqvjP5PSWYr+NFj9FHUSrcqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IU1m0rBYfUD/FOC2mLTgCTUBk4cQPR+fCCRNTMjmGG4=;
 b=PcF4nAmPcKK5A6vauNtPKbVMcSn8fp4nCZoTt5uhXxqK97s1cBuk+4g3Jtox/5MkBMNnygO6ff3eS8bTRf46GSTsUOeyacV84s0MW5ngTpnsRL5/XQykDMUjBbMb6SoFjEUFJ7qcmqq7zaPEIo2ZkFvADcX2lXAptmNu0PIBV53gtpDO73LJXq73vKKOM0/irFTU3Rz+5KvO55AtyrRkUIkAzgVlBS+HEJ3Es/y//G6obeMk4B8A7bWvOj1DUtW3B2f5Dh2WJUyQvWGMbnnn4YjNeuQNRw0CKcQYBuN0nh5wnEcm0wYkaOKAuMPq4kvKxfZ9YubUPlecVAV5MqiaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by CO1PR11MB5074.namprd11.prod.outlook.com (2603:10b6:303:97::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 04:42:14 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 04:42:13 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "Cui, Dexuan" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "vkuznets@redhat.com"
	<vkuznets@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [PATCH v1 11/23] KVM: x86: Add kvm_is_fred_enabled()
Thread-Topic: [PATCH v1 11/23] KVM: x86: Add kvm_is_fred_enabled()
Thread-Index: AQHaEnYQluTSIDRVa0GExAiuYWhTULB34v2AgAFfwqA=
Date: Tue, 14 Nov 2023 04:42:13 +0000
Message-ID: <SA1PR11MB6734074A2E482AF6F911693BA8B2A@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-12-xin3.li@intel.com> <ZVHRufhNmVTvJYWV@chao-email>
In-Reply-To: <ZVHRufhNmVTvJYWV@chao-email>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|CO1PR11MB5074:EE_
x-ms-office365-filtering-correlation-id: 100d8161-c21b-417d-0f27-08dbe4cc1245
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V7oY8iydFgtJJVHf4SmS091Edzo14Nn1d6PhWEFxEfl+83/CWLxVMX4MSNLxf2NV2sgbiIaUiK+E9ynFmd8RezXexsxfFEAukB8uRaHo4vyyiTxJ15ntqyCVYepT9LG2GS4pqVgxcXD7tiWIMbHVYffJn+nAn3w9KaXegTVsvkzQhykO2EI1/FiKJ00czDr4cNXQ2cdJbLJYfyx48xEXFt/85ASX4iwGU6i9f0BYZjs9vT3034jxZLrwXi8VOFH/VxXs0JEGuveBzS+8kPmS4s19678nsky/sfhb5oYNmktCaYTL/pdAqUBIusfu/lS86XIj+zoSuh7pGNkQC24WvXze12ol67kNfotXMjJUe1Kt/7K3r1LY5oDzje6i4Mb0i9MR0lQaKfXHLebNQFJN7Ndr6475/d+CzlHPlJmvUzB2lZG3A89+VzB0kfi7++r92nwRb163ZLnovjIGVssxxmZzYmioLSqa/3sTe+VnPj4u8/IUw72CCVPsriVBUyULB90TsxRktwymg2z1EYg5JNi2OBIJoIJgQtBqw30zlKDknn9CSOE719+G9i3YRqrpfcBCnIv7XNCnTAOpHNdkgz2ckN8HQJHF9djG4s+fD7c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38070700009)(122000001)(83380400001)(76116006)(26005)(82960400001)(7696005)(6506007)(478600001)(71200400001)(66946007)(9686003)(55016003)(86362001)(5660300002)(7416002)(52536014)(33656002)(41300700001)(2906002)(38100700002)(4744005)(316002)(54906003)(66556008)(66476007)(8676002)(64756008)(66446008)(8936002)(6862004)(6636002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a/M/rUy/RUJfqLIn47BsE354SDDzYmt5//puPxf3sCoXfCLoHyi+0jjvXF7t?=
 =?us-ascii?Q?SVlF12JUE2XsmoANL0GlItGAJ8giRIFrvGRq9MLtEgW1CZzDtVG2H+N/c70q?=
 =?us-ascii?Q?xagHwK1uvhQkkgdy1kxmTzSO9E/cAjQR2k6Et4osAHxYT4H8H+ICGe8tTsKV?=
 =?us-ascii?Q?sogrWSjMww+4vuktfORdV9FDtj9oCcGSoVwdYiZcs1wPVGr/Q6vgMK/0fsz5?=
 =?us-ascii?Q?4bJ6h5Sc/i9taBsYSFPt6Ub/XM0nrxVmrQCVj6DbU2+4PM5OI5cjb79kIM9L?=
 =?us-ascii?Q?PfJUzCuqloWB/Yx9vV84qPqtDLEs3u4dsQYsvNnjhhVBkrf/yr3cH++hBtPa?=
 =?us-ascii?Q?bjTRAsWxptJPU+k5cy/TyNiqPwqr91YrpNdVkT9awiNLL/G69E0RXBB1x20W?=
 =?us-ascii?Q?kOSz2lnebpKIF5jqI0zD/PPG5tezFaJpc57QaeYbvROOxthlHbes1ffPzRQR?=
 =?us-ascii?Q?QqPJYeAZ8PHrDmVXerrE5c6TQp21IVuNdArMgnbBkW2BJSkGTgNkxTLz2hv+?=
 =?us-ascii?Q?B/gtuPs2ZVZ+vgjYJTNz1q9B8PnBkN1PASTDjN/wptLAaQMPyX0BDaoCLqje?=
 =?us-ascii?Q?N9EABsnjz0qvCTBV/qWPST6+Ak/k4GItzqDsQlAKd33bZiWDXC+2VYj5q54C?=
 =?us-ascii?Q?q4XjM4Yu9j+UI/W3jC19xi6nn35CWFlms/hbQz2becu8MtkUqMlGvMixKywX?=
 =?us-ascii?Q?K1t7ri1y/Zqj9ihERDQ/2sTZ0dsuGDoK+vtJpHjctV10z4f/dNeKy9P2ebsJ?=
 =?us-ascii?Q?KrMcVliCO7MAMsc+SpBnACJKQ38DP3Zh+6Y9/U792PZhctiS7B1ro0Ym6VgH?=
 =?us-ascii?Q?NlBzS4ovLj6F+ajRqe6vkghiEWyNXtFB08HlaJKjFASErJSUVbL5+HFwhLRI?=
 =?us-ascii?Q?6OuYXFGaTadBiHPmJQf47lm1kl42gpelnscaJ5MM8CYCGh3lBcTnivAvDp6g?=
 =?us-ascii?Q?OdM0prsfu7hkedQUC9FKyAzR27jC85NX8LaBfEzNx9R5niAhhgwqV0s+YQ1H?=
 =?us-ascii?Q?6tMXi1BRzi47nKtOL0T3D1TyhfPgQiVFCfX2U1uEQsooyQ/iBPCGUuOwWwEX?=
 =?us-ascii?Q?NGTIuNK9k5YiZQeb7TJJ13qJy1N+5BknZien2McMn4aybZOOX93lEZLohQNN?=
 =?us-ascii?Q?0xOQXNHGu1mRYShAf8uYaQSeByZoOupLE1M0B3bTsYGFEWOiL+vGlbMoOk20?=
 =?us-ascii?Q?q3+WlpUYmtu0bWpFB8BPGzFSMj+BuNDlegYS8jDtfvVl+ne/f58b4rgAAf1D?=
 =?us-ascii?Q?EyGirN69rwcBN4EGkETaQO0CxoFibDlf7JmvbyFaHSPU/E7lOtjeSJblNQyt?=
 =?us-ascii?Q?ZXRVv35hsXEXNM/ypVq6WiaSspWttcDMn2uX1L0ou/59DJlYWzozOA7nshwf?=
 =?us-ascii?Q?/qq7AZioax1mphr5QZLatfQJWeh7HKlkoGvQhc5+RN7vJqD1swZAAG5Sw3IM?=
 =?us-ascii?Q?Fjfq4JrfDCG6SwDtKJ0BWWEMDzufaUe8RAnjMSBAk5Bd3xgKrtFj73ppZSs4?=
 =?us-ascii?Q?4X+gvUSy2wtZ7Zm5ZDJsWoBKIEeDdcTWu1vp7pVN9ITBQUsKub1S6dbNh7rG?=
 =?us-ascii?Q?C3+kyKM1Lqg9yIK1sbc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100d8161-c21b-417d-0f27-08dbe4cc1245
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 04:42:13.3464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jUVmlBUK2Abi5T33ecukzUv5rNG+6My/nNMN1C773BrCMMKNrpEYuIU+Zb+qTKechVvI3zEImM2aqClYK/8DSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5074
X-OriginatorOrg: intel.com

> >+	return cpu_feature_enabled(X86_FEATURE_FRED) &&
> >+	       kvm_is_cr4_bit_set(vcpu, X86_CR4_FRED);
>=20
> FRED is enabled when CR4.FRED =3D IA32_EFER.LMA =3D 1. Any reason to omit=
 the
> check about long mode?

It won' t allow CR4.FRED to be set if not in long mode, I don't expect it
at runtime.  Or you have one?

If you are talking about save/restore a corrupted vCPU state, a following
VM entry should fail anyway.

