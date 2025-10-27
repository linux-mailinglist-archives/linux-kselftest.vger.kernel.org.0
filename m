Return-Path: <linux-kselftest+bounces-44147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14918C11EB1
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 23:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80C774FC795
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 22:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C76230C37A;
	Mon, 27 Oct 2025 22:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UP95p7b3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BDF2F692C;
	Mon, 27 Oct 2025 22:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761605815; cv=fail; b=XuuKU7Vk53Y2U58eRJ8hHCq+83CO/opx3gB4lCmIwyedmwl40mBTW2BThiAPszvDfdSLoRD1on2AmbSxOMFw1s3lVxkFLGOEO7Q0+zAT2OvEjqZZV5/dCuZvKbyxzDKDZ8iKLqdoBdm4aYiJRXn44K6z1c5hFvjV/UVw+SkqiN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761605815; c=relaxed/simple;
	bh=KoXDkdLv5ADDOuQKr7zrQUDzAO1r14QHuCGq6JzFj9w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mUjZvTlgJ5ABff0M83DzRMFCD7tTo0M5ywokS3nJCv98IWKKT0SndkJRF/FDT9OywBGVNdQv7yY9nDhpZ23G1hnoLkVD7IsCW7PznsCI4XdFtQ3x6WJ9H8BZk0P2FY+L9Rc9cUPtZhBNrZ+ZCAWhVpCTiVuUN2rA67fE4hekBtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UP95p7b3; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761605814; x=1793141814;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KoXDkdLv5ADDOuQKr7zrQUDzAO1r14QHuCGq6JzFj9w=;
  b=UP95p7b3vNkm69DWHYz5RNZ1gtiGf4sZJGRP2uMZvDl7JzKPKYI2+pU5
   TcwAUb1YG7fpjTfzEWYxMYZ61HNYcZvQ15bbW6rsiTZ9iR6gEaM//exns
   ycWbgslXogS7WgYUWRvu7HXjBg05WxGViNmrU3F2DFgP7D2JnsMOzWGI+
   5BGK1NUhei0kwMASmo6MzMj3V4alD3mnpXga1Cc2SNRfGYdVrj/zLqetp
   azzHlWysXe2lfn9p89yyy3r9QbWGeO6He7WbDNO8ofC9P+aHpe/Nmy0Xp
   NuCed3R4VXM2CCRBtaVWtmzmS2YgLM/Xytj3fSPlG8P10nv/ofAnbs3EY
   Q==;
X-CSE-ConnectionGUID: SpU8xs7PSM+wrzaZWQl/ow==
X-CSE-MsgGUID: XRbuyr9CTqm3L77ud6UwLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63624828"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63624828"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 15:56:53 -0700
X-CSE-ConnectionGUID: MKBgEyQiQ8ugjgxbndTl6A==
X-CSE-MsgGUID: DiXvWZoKSNaWn0ZlazGRzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="185075692"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 15:56:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 15:56:52 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 15:56:52 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.68) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 15:56:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdW40sOWdFfcwp7qpjz6q/CwI5QrtPQLNnTI3dI0V+uRoKqodTK1FsBgwfvr50yucXZjdubg6dG3gC2Uof1Fppzh11CY6lnbW7NF8QO798UwxcSCeeN34WR+B4RdtuJejAxOroNJpn9UuLiimpZg65qiPj5i+sifSOvgKBNom31K/L+5Fe9gRb2ZjYuNC51tPmUAn1WgzR4cTl92fhfSoFlUUBnFAe50ady3OWXPJaxGDZPSYyxyJm6NmMmX1Ao+a8782+75Eo0n9x3pWMqxhobopgkWp4YspYzs6j2q+HwzD5Nu3kR8+sa5gyWOgmmWPzXMlMOA4aMFdVmeFqWA+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVjlu9942mdjQ9jbNqtb1grWscVdcY9KTfE+R1sbOmc=;
 b=fKkvxGd4p9mNgNr7fb8mQKrmtvsTQZvJTFOHcDOO5SnjiDJNb80TV147nfxCQLGsfry88h5LXDzy+dWm23O0kkmjDEcwPgvDGarEHUEExj4fyEWj1fudpLWC56jUDY+1OZJY1Br4QfK8pC37VdLhG3bjI/N2jgaN+37Oy+5UvfJ1Ipktb8AjW681bmS6OcDDyFbhaVnzU3HhvNJP//dDqAz+suNEwxl7DhPBYMYZoKugSLWjbz+Dp92gwGSYv9/kipBFDLQwVo1Wpw/mz8yYCuMA43HWNU8HJRxX2LaMR59MPLxsjh290sARX47IpiiBw6+6tdTBBFarPcGd39XSVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by SA2PR11MB5196.namprd11.prod.outlook.com
 (2603:10b6:806:119::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 22:56:39 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9253.013; Mon, 27 Oct 2025
 22:56:39 +0000
Date: Mon, 27 Oct 2025 17:58:58 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Sean Christopherson <seanjc@google.com>, Sagi Shahar <sagis@google.com>
CC: <linux-kselftest@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Ackerley Tng <ackerleytng@google.com>, "Ryan
 Afranji" <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>, "Isaku
 Yamahata" <isaku.yamahata@intel.com>, Erdem Aktas <erdemaktas@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang
	<runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton
	<oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
	Reinette Chatre <reinette.chatre@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Chao Gao <chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v11 21/21] KVM: selftests: Add TDX lifecycle test
Message-ID: <68fff9328b74_1ffdeb100d8@iweiny-mobl.notmuch>
References: <20250925172851.606193-1-sagis@google.com>
 <20250925172851.606193-22-sagis@google.com>
 <aPum5qJjFH49YVyy@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aPum5qJjFH49YVyy@google.com>
X-ClientProxiedBy: BYAPR21CA0019.namprd21.prod.outlook.com
 (2603:10b6:a03:114::29) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|SA2PR11MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: 25cdd386-17e3-4e93-52a1-08de15ac1694
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ovcvt21j1F/S/wH4aImXvEpNffv70u48PPNs0SU/oAvXmcAbO6cYXaPKrIUF?=
 =?us-ascii?Q?dTeSUdkctZRCm2JxDNnxDpKRJHCk2TAPGewLXjEN69KZNEiSDQHFE7uLLQSA?=
 =?us-ascii?Q?0WtgXc7p6h8/bqXiDkMPx3DYJsmMvjL5u4lZKeA1nd7jpXoCq2VYSPdTxU6P?=
 =?us-ascii?Q?qg1SqSF97d8fhO1zewIK/37wkBLoZ/U49Qe6WC2x66gBdR9Id9E11O6e47aW?=
 =?us-ascii?Q?tiXc2x6KAjyHeNvQi3rUQL4FxLFH9e1CCt3hAWPkyi9nVI0h84LAnzm7k/2v?=
 =?us-ascii?Q?X+d4KZAH1RbgaBwId/+2aljIJC6d/FQow06ABV/yhtP5c6iFmSZnUZI9vjiZ?=
 =?us-ascii?Q?FNGHjIX6Fjku6T3poJMdnajXGtVdU1TeHBwVjilu/eknnv+jDduGTFCpiYJD?=
 =?us-ascii?Q?s++oTDX2FT6kqKXIWtEp8Tw/FMhmhLgdFlF/biMuhX1jBLi8a41wEPTDU0Cn?=
 =?us-ascii?Q?J0igQK2xu3793dRzGXEYFY96iUl6Qvz41c4u7IM45BN32MLFa3FBaBv1++Wa?=
 =?us-ascii?Q?ZAjhZowOZWRln/q6quBUgIbMdgNLz9oTBSCZECIWVkmDJZHKyHTLGhXK5ffF?=
 =?us-ascii?Q?IiKBSbRpUoJTqDwJjoRyvR6Lnha+s5car0AsoPgMEH0ArMp7WhTgWtBSL2N/?=
 =?us-ascii?Q?95MksEIedTM75ANHfpZRTBiknYKEauxup6wfX/TzzI8DTWTxojMuOdWRxPHe?=
 =?us-ascii?Q?IJiDCjqc6cTDE02xcCr/yDvZPvxlunlF7rzgROzKDCuPtxhRbxwB2bLjvZn4?=
 =?us-ascii?Q?ky0oKqThAy4B5qE6DaNcFHDc59IW7LJuwhlXJyhP0ARfGKWg59Rihp1IJPhK?=
 =?us-ascii?Q?Qds0DXW3VKPgCuWytgtZsuxM1B2VVcPc5WgC3qPxMuoAB6R9o6nYJQivrDa0?=
 =?us-ascii?Q?/+wQ5KNouqrK5bIqRCv+dkndYnaFjEX/23ZaTgmh5G66o46rYrRqv5Ue8oXy?=
 =?us-ascii?Q?G/hQIDHgL/2odC3+5HxW3ArUDsXW5Rdmgn7sioTnkoKMoGkW+kPMCv8QG7EX?=
 =?us-ascii?Q?hsMIgFFJFM+9/OR/dJ6fSOEVVFiW2YOHT5xrvXGnXx1vebEhWIj7PGUKSmmt?=
 =?us-ascii?Q?1o7Bz/BISdKlnd/hZ8Ff8Uz3CAzAeHAa3l4Fv0yYCBHYwh1gU2rIcCGzanbD?=
 =?us-ascii?Q?dF/WVqe/Y3IuSbfVnCMxCgMdjG7E1DzGAIKqFVmXE4954XAbqCwZhzTk/bY9?=
 =?us-ascii?Q?t84z0UH+MyEvW8uHiuWLA9HOfzQoS7T9klIbu+GEuugwhAzs7oMd0yhQ+nGr?=
 =?us-ascii?Q?NOMa2F3EFxOxxJ22CfnQqsC6Fvi/lW2Q/ljRSHDxEQTQfgMplnl79fvyIq5e?=
 =?us-ascii?Q?MDfsJusXGktIxEMVW/3JzLwBF7s3q7LUM3TUhhHo+l9StJKaRVOogT5EgvUp?=
 =?us-ascii?Q?oaR67pd7394g14akO7Sy/rWn8o2GczYSrM/sAzOQgHx3Blk9T8aG46HV52vv?=
 =?us-ascii?Q?C/Qzy697bn84eZyR4CJH+J26IwV0dPav?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6sQ7WVfzwcIEVRVP/zGq4CBfn3VBK9HE/5Q7dWEclMyHmM62eia27EiPAzog?=
 =?us-ascii?Q?Rb0R93GvZqnIJGSfn4StUlS7nIPMQeIAVvSXKssShUI49SrbrOSxILri+7w/?=
 =?us-ascii?Q?+aqL7AZpiMUe3aLu7AkfrP9/phpLQw760I1KwHDIpGl2LlyJcNOhkMHl9Gtu?=
 =?us-ascii?Q?aidjA+rL5b4S7VGFMtvBTsbr4WnC3Cs+RP/OuZO6J4YTtwttdDaopTI663FP?=
 =?us-ascii?Q?KJ1AQBlHcPlhbJ7p8AvjwT34vUBy0KotTaM5oDCJjRZKCznmBmBiOLS4Vtza?=
 =?us-ascii?Q?86lV5wBI3i+hCDRrCRJ5Ncf3qYZHsfmhUc/qZFjA2LNMYeHJb/cfq5uCNzJA?=
 =?us-ascii?Q?xt8ORzlh7a0x/4TiMiP3kh9nYmqgC1qkPnlcOZDI67OmSwDsKDxZKZh4OR5S?=
 =?us-ascii?Q?xVjEx1iE2HVOWKe5MFY0/fd8rqvJqqNNEPpFi7eFswQASUNMBhUcjqlAOE8l?=
 =?us-ascii?Q?vqMFJdoTP20fqux271ca/tdkeSbtOlqqDlAvMyC1AwnucB6sVWqh+Ngv/tOl?=
 =?us-ascii?Q?ktMrIS1HKQ6HXKIVHhcwicNIGwMD5IVPJCnNQShC64RIvxmbtSMYcAbAdqSj?=
 =?us-ascii?Q?tkOH0LPql4W67pkJ40R8dk52Rs14VfaREF0Vtak7eU3RDNTtAF23Sy/bcJlW?=
 =?us-ascii?Q?MsBQyrHVySee5xyvw4L0KGbtVEw2VYJDV02hDgaR5cy0SPFWIwN3V6wOWIXV?=
 =?us-ascii?Q?eE8ATJzgjnlz4b9eD1WZvSqYXsocn9dVeN+uSuK4Quti+m/7EfLkdjsuFXyA?=
 =?us-ascii?Q?wK1/fD6/ilZ8DJW60OfSfFTWA9wfAdOrIv1kHb6MzpPoD6ENkauE1eyqNRg2?=
 =?us-ascii?Q?nFENQYeSk91YxWIajvEWf09eXUAWL0NA6glWWXu2kcB5HvRV6Kez+c9QB214?=
 =?us-ascii?Q?ZurWBvqKKLptNwX+4Mej0O8sapzOh9p0ofZqeEF4dxWFvvnhUkU+WSmpw6UP?=
 =?us-ascii?Q?OtL6jeyybbNX4cOI/y6wV4yjfz4R673sEPzRqjByuh0BnLxbuBSs+LyZLmz7?=
 =?us-ascii?Q?zxOVWpDYbMVR+xTNGHJWoeSHs7fAz6ZD8Fg5Aabx2yu2IA+1bY+B/LvXfSm4?=
 =?us-ascii?Q?2KMQ2auVWZcsu724yCm3y648l3sEdxDkpcIbyCZo10HPkV3tbnHklDSHmJhr?=
 =?us-ascii?Q?aVDOgzxFGKeG5F+MCf0BUEE44g35wlaPRTmya4Q0n0xCBRA+QSm+/i6l9Reh?=
 =?us-ascii?Q?WpAWu2DWbN3s2APyjS2fEk0XfjEssgJ7uZvgQSRnlOgqhcTXkgMmpv/eecX+?=
 =?us-ascii?Q?QPh7hpC5/FEc5qL2g7n4bVxE0EVbjBTENO5+JAZnSE2rzo5lK0oGR53DWWuM?=
 =?us-ascii?Q?6JtLRQ8crfh9mgpzmgaiv0RR9Ionm/eJpuL9z6B4V+H8SmLv6jBMmyrsgAm0?=
 =?us-ascii?Q?TOLAUQ2Ll/VfzbdymC6f3iOAd1H5AR+3uTEjTYMsPMyt2SLCQJPCXmsY09XI?=
 =?us-ascii?Q?JesthM3wxHmV+vA/4ORadI9qEOHzhZhN+PkHI1Xx9YagS/mSTuDYlalIK7EB?=
 =?us-ascii?Q?UWMNQazyJzoylnBBNXZxmBZ6xlROU1f/nw/3mhpg0u8IxaY2Dh6o34ZR4fUX?=
 =?us-ascii?Q?pXX/LO6m7zxjOTV+GPentmpYJCPc6yBbc6UvI5yc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25cdd386-17e3-4e93-52a1-08de15ac1694
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 22:56:39.3555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEu3pYspsATt9lcUTcUQglqPQ6tvafG/YRRjYhc0z6bxhddIH9JX80Ig417EraUKAsJgEFoNIl5Waa8BZkjggQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5196
X-OriginatorOrg: intel.com

Sean Christopherson wrote:
> On Thu, Sep 25, 2025, Sagi Shahar wrote:
> > diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > index 53cfadeff8de..714413e062fd 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > @@ -328,3 +328,21 @@ void vm_tdx_finalize(struct kvm_vm *vm)
> >  	load_td_private_memory(vm);
> >  	vm_tdx_vm_ioctl(vm, KVM_TDX_FINALIZE_VM, 0, NULL);
> >  }
> > +
> > +struct kvm_vm *vm_tdx_create_with_one_vcpu(void *guest_code,
> > +					   struct kvm_vcpu **vcpu)
> > +{
> > +	struct vm_shape shape = {
> > +		.mode = VM_MODE_DEFAULT,
> > +		.type = KVM_X86_TDX_VM,
> > +	};
> > +	struct kvm_vm *vm;
> > +	struct kvm_vcpu *vcpus[1];
> > +
> > +	vm = __vm_create_with_vcpus(shape, 1, 0, guest_code, vcpus);
> > +	*vcpu = vcpus[0];
> > +
> > +	vm_tdx_finalize(vm);
> > +
> > +	return vm;
> > +}
> 
> Rather than add a full wrapper, and duplicate all of vm_sev_create_with_one_vcpu(),
> we should just add macros to convert a type to a shape.
> 
> E.g. with this, you can simply add:
> 
>   #define VM_SHAPE_TDX	VM_TYPE(KVM_X86_TDX_VM)
> 
> And coupled with Ira's suggestion regarding vm_tdx_finalize(), there should be
> no need for vm_tdx_create_with_one_vcpu().

All sounds reasonable to me but some questions/comments below.


[snip]

> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index af52cd938b50..af0b53987c06 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -210,6 +210,20 @@ kvm_static_assert(sizeof(struct vm_shape) == sizeof(uint64_t));
>  	shape;					\
>  })
>  
> +#define __VM_TYPE(__mode, __type)		\
> +({						\
> +	struct vm_shape shape = {		\
> +		.mode = (__mode),		\
> +		.type = (__type)		\
> +	};					\
> +						\
> +	shape;					\
> +})
> +
> +#define VM_TYPE(__type)				\
> +	__VM_TYPE(VM_MODE_DEFAULT, __type)

We already have VM_SHAPE()?  Why do we need this as well?

> +
> +
>  #if defined(__aarch64__)
>  
>  extern enum vm_guest_mode vm_mode_default;
> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> index 51cd84b9ca66..dd21e11e1908 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> @@ -362,6 +362,10 @@ static inline unsigned int x86_model(unsigned int eax)
>  	return ((eax >> 12) & 0xf0) | ((eax >> 4) & 0x0f);
>  }
>  
> +#define VM_SHAPE_SEV		VM_TYPE(KVM_X86_SEV_VM)
> +#define VM_SHAPE_SEV_ES		VM_TYPE(KVM_X86_SEV_ES_VM)
> +#define VM_SHAPE_SNP		VM_TYPE(KVM_X86_SNP_VM)

FWIW I think the SEV bits should be pulled apart from the TDX bits and the
TDX bits squashed back into this series with the SEV as a per-cursor patch.

Ira

[snip]

