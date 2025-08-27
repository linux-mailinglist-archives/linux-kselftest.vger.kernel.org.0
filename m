Return-Path: <linux-kselftest+bounces-40027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D26B378E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 05:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309077C25E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 03:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4A830C378;
	Wed, 27 Aug 2025 03:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gMPHApC5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E70304BDB;
	Wed, 27 Aug 2025 03:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266817; cv=fail; b=R5i7sFRTxu1nLVmAxVbAsnYRbvj5MuRqroekrZYJlXgQe14Veh/FbbkzwRqOErQEq5+qt1mseOrro1l3LtoiUMjSnyT7AaN4C7+NIvs3OW1LuQnwnwsG05vfqFhLll6Zad5heRVRlMtcUcILXcVWG+1AMccDLMKcJFO4sbjfdGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266817; c=relaxed/simple;
	bh=9y+0mBRDAWOsLMPojBDKCpVxLXOB1TymAbxU4IHMedQ=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fruqVyR5dTmVlkcWPO8zrcXLw5N0XPMr/DmpppXauZ5+/j4LAnauPV9UwSqkOiawBLK3bo70JWMZF3HkBoVScNp9dn/AAmvOCSHFMMYlwze4iER2mqWuMk53PLk/64w4/DGzjo/bb1FPT97wd1LS2Tu0FZWqhtQ4pMlBDrwC5/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gMPHApC5; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756266816; x=1787802816;
  h=date:from:to:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=9y+0mBRDAWOsLMPojBDKCpVxLXOB1TymAbxU4IHMedQ=;
  b=gMPHApC53k1IfgRhmvMkVNHkGPH6KNIMRUJUPibC8vAOH1nLQn6RBcVg
   YT21ycAsNIPwRskx9TbQye44cD5Yn8Nv3AkYaqj6jUTutuF/eqAPC3Nmn
   /LII0+es6ttLhQJLjk9qKOrAwlBt/m8LyqIjSBUVRi+ze2bsFmpc+lleq
   LFt+KN1VcLFIy1vAVMqRB285pACTsc/XAhTuuM8y+siROedCkIOJyVOqe
   /G6bE/skn23LQxzXAdONrWhBRp1W+Wsxtpiccl8aWvOCS95J1KDKx/1/h
   rNhkLpqW90jHYKS+xYPRWnzB5P49zcMRkx1eG6x3m3EW89ziAvVwkv0Ph
   Q==;
X-CSE-ConnectionGUID: 89ZXWUZ9SIyk5587rLI9JA==
X-CSE-MsgGUID: NDPMXcImSAaJCO/a/sqfIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69106565"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69106565"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:53:35 -0700
X-CSE-ConnectionGUID: PKL5labITjGldQhQNcCJZg==
X-CSE-MsgGUID: K58QTyk1QZOhQ9eUYymCDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="168984245"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:53:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:53:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 20:53:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:53:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQcJSQcyAHvlKkYgRTCzWgEgNa6XCwYRj5S0Sir2g0dmw6oPb0PO05y5DFF5gNS2VpPlZtGt+IQwNxnsUvPIkyXU5LoGSwd8sugwzTPBSayHP6QKOMyiMnHJrbYZpTez0bfDeN9UDmiYqbsQLysJIBo3baa35qwDW4lJaBNJORX9an+juFOLvy6OCtXM8HiEQcbxOjv1BwSmQotgpWWYiWnD+klkcRLyg/+GnTaW9mLy0V37gghez2QypOsE3efDnEPpTf+hBC7msshY+1M30H1jHKvxBBKPoOURjFjkx1ytInFZeOhxN5Ma3hEmgeGipneEpHHv63Scu9BhsEwZ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnQvYKRG6dmunaRH/1yAtDpT5r0j53e51ecUPfTSJi0=;
 b=yXyHGPLZHtUVb/ChiOp5l8S7lwfv1JaolDNOKsozk27iAcaGP6vvlX+m1+eznY0fAnE/GLF1FZEQUZ/359q81Knvz5SAwUYDT/BDxqrdP+qren6mPggI7YnmsYKCqmyCEu/2Mw3hNHHVBr0KD5qJOWJRaQ7HBEXHNNCNcoVhJTnMkoxRc20SuSGP4Cvsidc4xe641//uvVmJRkv8dDLi5FWnnfrNoWAlYqHoET/CKlGJu4QnEKrWDExIzRhvNBkY4Hf70sJw3bD3KdEG1eT/UJZ/LeE4arxSOltzVSdYxfKOqg+yJxAnxAQKmo3UaoIi4C62Z+fF6QD4x9fJqUze6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 IA0PR11MB7379.namprd11.prod.outlook.com (2603:10b6:208:431::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.20; Wed, 27 Aug 2025 03:53:30 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%7]) with mapi id 15.20.9052.013; Wed, 27 Aug 2025
 03:53:29 +0000
Date: Wed, 27 Aug 2025 11:52:37 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>, Sagi Shahar <sagis@google.com>,
	<linux-kselftest@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	"Shuah Khan" <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>,
	"Ackerley Tng" <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>,
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata
	<isaku.yamahata@intel.com>, "Erdem Aktas" <erdemaktas@google.com>, Rick
 Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>,
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, Chenyi Qiang
	<chenyi.qiang@intel.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>
Subject: Re: [PATCH v9 14/19] KVM: selftests: Add helpers to init TDX memory
 and finalize VM
Message-ID: <aK6BBc/qrfxJKUUf@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20250821042915.3712925-1-sagis@google.com>
 <20250821042915.3712925-15-sagis@google.com>
 <aKwhchKBV1ts+Jhm@yzhao56-desk.sh.intel.com>
 <CAAhR5DGZnrpW8u9Y0O+EFLJJsbTVO6mdrh4jbG4CrFgR13Y60g@mail.gmail.com>
 <aK0IxsvmlNvc/u7j@yzhao56-desk.sh.intel.com>
 <2a97db5e-ee82-43b0-a148-e4af1b93ca10@linux.intel.com>
 <aK5xKg58V5BLAPDr@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aK5xKg58V5BLAPDr@yzhao56-desk.sh.intel.com>
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|IA0PR11MB7379:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d16473-b871-4057-aa11-08dde51d48e7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHh3dFRzNFJLV1JhWmNKOXg4eXJWSnJYSDlReThTUmRXQnViSXBMc1VTcDBG?=
 =?utf-8?B?T1ErSXY3NjRmOXQ0UFlGTTYrdk1CVkd1SGFXYkJMZ0xjMDUrcm9IK2Z1RDJ5?=
 =?utf-8?B?Q1pxd3VrWC8yTXNFNW5WcjJsM0tGanRPQkxzcUd1M3JkWWZBVXl4T1dhaHNy?=
 =?utf-8?B?ZW8ydjJwSHRQV3ZYbHJYaXhWTXloTzdhYWdIeTF2Rjh0L0N5RUxEUkY1T05y?=
 =?utf-8?B?ay9ZMWw1SlpGL0RHRFM5Z3JDZlI0TWRhWlJHU2lxaTVCQmwvVC9Kc0pSNExi?=
 =?utf-8?B?dGIxWUg0dnBrREZ3bXl1aXJ4LzRoemVlcEN3SFZKRG4zYnBQNk1zTEV6WlBF?=
 =?utf-8?B?ZEZodXBGT1k5cVFraU16WGc4RmwzUVZOR0F1UHdXM1dUWEtqcTdoTkNwV0pK?=
 =?utf-8?B?QXVxSnUybTl0RXB6MFh6bzQrdEo4MUZhamRJbHlQOWVyeC84dFBlL0lsZzc0?=
 =?utf-8?B?TStBVzhvR052SkQzdkRHV21wYkxCQ0wwUk9pQVJCV0dsQzZybXozdWo0SXRl?=
 =?utf-8?B?RTNVeGhCMktCcnZKYzI4QVdzRllIUE1JaExpUDNrL2VZOVltKzdBZUdMd21m?=
 =?utf-8?B?UkpFMWMvbDZhZ000bVFHNSt2MklabDh4Z29PUUJRZ093U3VucFd1VWxrd0xs?=
 =?utf-8?B?ZUtFQzI4TDExUEdaTm5tWGYyaUx0QTRVdGNiUitveGNvZlU4VUJIemFrL3dk?=
 =?utf-8?B?aVo0Zm90WG84Y2t3Q0VrMzVwRm5wS3dhN1BCaUJhK212d3Jqa21FV3ZJRWV5?=
 =?utf-8?B?MmR6T0NQbkZIRmk5Q3BhaS95TmxXYlpnSTBONHdtbzlFa0dmbjBqSzBnc3dz?=
 =?utf-8?B?ZEJva3IxT1dKdzBBYXE3WTl2Smt4dThxVjNoRVVxdjlkQnljQ3Zrc2VvTFVC?=
 =?utf-8?B?RjVqVHJwUThxRTQyYnJRaHZuR0c3TmNCRGJRZHVreWVtMUd2b1BQTFVBdllr?=
 =?utf-8?B?OEhzekhiTjlvVXBlWi81bTl4UXU4Y1RvY0JzTGdFd2xlMWY4WXF0cHgyZ3g5?=
 =?utf-8?B?YXloRjZhT1BYN0pwWWsxcG5TUWdObzNQMnpMMGFuVmtzUzgvY0wxLzdPTk5C?=
 =?utf-8?B?aEpxaDNucWU3cWJadWdzWkdlcUJVYTJ2c1Y4ZkNiOFFtQ3poSHFaRlVmYVhB?=
 =?utf-8?B?WXVUV2tEVGsrejNMSG1XSFlVMmNZeTN2WStqZ2dpeGtIc252ekNjYVk0M0JS?=
 =?utf-8?B?SklBMXJVQSsydVhhSDZXZTBqY2NmM0lTdVYvaUt2RzZtYXFQU1ZmVEkvN2Ux?=
 =?utf-8?B?ZmVHK25aTytxbFNDaVpIZWVUckE2RklnSzJvTGlCMlVXSXJ3TWZpcEw2cmJk?=
 =?utf-8?B?aFh6ZmxGS0EyR2dseWVPY3JjYzZQRVNBejU0QXhQWksxQndGb3dBZlI3dEZq?=
 =?utf-8?B?NFZZeVFzenNVb2lwczJEQ3BMVFd1SE8vVTBEQmt2Y2lheU9JdkdlV2d6TFFQ?=
 =?utf-8?B?TGVlaWlBWWQ4UHNpSkIwOGU2S1BXVzVWcDNpNFdrekpXSHZveHI1U3VrNXlY?=
 =?utf-8?B?RTh0MCtOQ1h0cGJLeFhRK1Fpbm1GK0ZoTGE2clZUYmQ4ZHpCNG0xSzlYQ08z?=
 =?utf-8?B?c01Jd3ltMm9pN0IwVGQycVd6aHBIaVY3c2VJZjNZNEhRS1luTDB1Y2pRMWgz?=
 =?utf-8?B?WDRXUWM1TUcxcFdsbWlXYmRSbnQzSXF2NExaamRpZ2lBa1V0NmpsR2J4dEpn?=
 =?utf-8?B?L1JYcEZaeXgzSDQ0Y2hNOXVQSS9vTTNTdWF5RVN3amZ0Ry9YZkVDK0gvbEdN?=
 =?utf-8?B?SEVDVnNtejRCSTlhNWpyVStHNWNWdUFzVFREMTBCRHFtTHpSRnV2NytWOEov?=
 =?utf-8?B?SklXZWJzVlVFZUdyams1MFp2emxvejlPZk42SFlRVytOanltY0t1bXh6bDJG?=
 =?utf-8?B?aU9YQjM4aGxQN0Fqcm53RFJFUmNWOGZNdjd0aDN4MmtOd25MbFROajVXcFRH?=
 =?utf-8?B?VG5aOGRSZjYweVhGTkVUaE1XZ0dmbkF2TFV6ZXhpTFJ0anBxdjNYWUk3ZEZT?=
 =?utf-8?B?c2plYVRubTNnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEpRbThvcmlRNkNnL0xzRmVzYUp5ZFoyNjdWdm9iSHBjT1M0NTB6MkNpUjly?=
 =?utf-8?B?cmJJTXFENlNQeVBHeUdNUEkrajg1U25mS1VKWWhHZ0d2dHYwSlFmTGR0VVJr?=
 =?utf-8?B?RWM4aytsVVl5ejJFM3hBRjR6cVhaWk1yWitRRjd4bmtNWVp5dnBuMEFKVThO?=
 =?utf-8?B?a0g0S3d2aUVxSkFIUkNyS1FQREMyaWxwYlA1K012N2tHYWoyT3BoSTFzOFp3?=
 =?utf-8?B?U25pTFpNVzdzVnJvbVlXMEpGTHpNTVlLV1lRbU1Db2dsdTYwUGFVSzVSbjhk?=
 =?utf-8?B?OTZ4TjlJRi8vaEdaeWlxb3lmampHMktVa2hvWC9uRUkvZUxvZ3p0T3FEMUVJ?=
 =?utf-8?B?end5RE1DRG9keXpuOTFrczkzWWhSUW9hQkpXMVZySTV1bzdibFcrL25udlV2?=
 =?utf-8?B?a0lMNFdKSTA2RFlBcVRYV2lGTW5yd2NXbnA0bFBYNHBCZnFZdS92SkU2YTlG?=
 =?utf-8?B?SVdzcCtOdlhWSmZ3ZGRFUkpuU0J4K1FocjBUMDRjMzZBV0tIRTFHVW4vSTgz?=
 =?utf-8?B?dFR0bHhKSlJiVlBoVGRKZWZ2Qm9HSHFrMllzOFRxdEttYVR5aFMvSzFXNXpH?=
 =?utf-8?B?M3JJVk9FVFRmY0doZzloa1F0cHhnbVZrRWE1LzBjL3R3QTI2WTlDTEtRQTNK?=
 =?utf-8?B?M0JIY1l3eEREYnh2ZWV3YmlsOVNrelhibngva2phM2l4SllxWUxNcWhmYXIx?=
 =?utf-8?B?OTdzV3M4K1pWQ2dwUjMzWTBUb2kzYjd2MkFtSFFBUUthZ1E2ZjJDbHdzWWE2?=
 =?utf-8?B?QUVkck1TZFdQUjRCdjRxdkVrZzh5SzRaVkNLOE9QN3oxZDNVaGpvWU8yb2xq?=
 =?utf-8?B?bWwxN2ZWY2VXOVlIRG9OcW9jdzhzeExPWFlBem4zRVNXeXpBVmwrODhqUHpX?=
 =?utf-8?B?ZW5NYTNQc0w0TCtNc0NGZGovMVM0bUg2RU5VMzdHMjc5NjZ4bFVCeEdxMG9X?=
 =?utf-8?B?V3J3VGZVQytHSDdBcDVNam53dmoxMXVwZm1xWDEwMlZiWjV1dzFlckNnZTY2?=
 =?utf-8?B?WStjVStNOHhpMk5IcC9VeFRBQXB0bmNzNEVBdXhIamUxYVhUQ2ZjT2hHUVhM?=
 =?utf-8?B?MlJrU3kvNTEzZzhRbXBFS1pIOXE5T0hIRUdWUllBbkNuMDhGSTJ5Rk1lTjIx?=
 =?utf-8?B?ZGh2NHA0cHRQYWhjbXRrOFRxdHBMdFZkaERBU01XcExxcjlMWDhJREo1MlRw?=
 =?utf-8?B?MzRYU2ZycUo3eXB2N2k1UHdiSm4vQmFWdGtlcmI1MGMwT1RsVUtrc3dRT3lK?=
 =?utf-8?B?T3pyNTFKbGJWR1JPT1hGdkkrWTZ6N1JvYzJrZXhpbGFQTmxMK2hjUUt2bkNu?=
 =?utf-8?B?VHgwTnJlTWZXMU9UVFlyZ0lacjhZNEFDdis0MmkxSVVQYVBwdUJEZzludHNi?=
 =?utf-8?B?RWhBR2ZkeEdXTEFWT2VDT1gvbVFMRXNtTldTVEhYbjlYMVRnNU5FUlhyOWox?=
 =?utf-8?B?VzlKKythYkp4NzFlYmx1MEp0cTlrNVRwYW9hZ3J6NVgrbXNwRDBJSG1DcSt1?=
 =?utf-8?B?Q2gxNkhuRG4vN0lMNHBtRDV2UUtPSU4wNUtoZnQ5dk5oRzZTS29PYndJWHhV?=
 =?utf-8?B?RkU1RWFCVEs2YW90ZE5Kdy82Rk13QjZJZnFQZ241cmhzSitrWEtlWm9SM2VS?=
 =?utf-8?B?N1IzL0lhZm5YVGt2R29XYXN4TkFKL0FjRGNZMTRrZS9LUERhYUF0dHhuWEZi?=
 =?utf-8?B?elMxalpuNkluQUdBSHo5VVRqNDExN1hVTVNoNXRQZnA2UXBOdVRsTXJHakxa?=
 =?utf-8?B?SGx1MDF5elRKRnBydEd0MWlhdmlZK1hZZmI3V0VjTTBBTUVuNGR2c2xNYno4?=
 =?utf-8?B?WXhtYUVhYkIrY3BMTjZBR29FSVJpeTM0N3QxSDVvUVlQM1NvWmpVR0xtRjZZ?=
 =?utf-8?B?Mi9qalVDWWN3SkdnYWJia3pnUkNmT1MyOXYzdUNISHd4QTJaQTR2VGhZQmJM?=
 =?utf-8?B?NXM0czhCWU42NlUya2p1ZTJ6UFYzNG5va3k5d3hmYks1ZHBoRFRVa2RMbFQ4?=
 =?utf-8?B?R201OXVIKzA4NkdxWTI1OC9JQ1p4cDVFT21UbnNZYjNCUXBjK2ZVWUdZQUxm?=
 =?utf-8?B?MXVaV3ZhYVc4MTcxOThnY2VKYzlycGx3S2VERDZ5YjVtMk1IQ2N1dXNRbUNu?=
 =?utf-8?Q?1PFUM8+MKnTW4Z+dydnJmfGMj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d16473-b871-4057-aa11-08dde51d48e7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 03:53:29.8470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMFldtfoUfQ6tGRBXddW/ySyEXHRtJMs7YyfBWon9ZcLIhQMXaU7/jwNjjdmldoyluQt1Z9TNzDNvMYpbP7fLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7379
X-OriginatorOrg: intel.com

On Wed, Aug 27, 2025 at 10:44:58AM +0800, Yan Zhao wrote:
> On Wed, Aug 27, 2025 at 10:24:03AM +0800, Binbin Wu wrote:
> > 
> > 
> > On 8/26/2025 9:07 AM, Yan Zhao wrote:
> > > On Mon, Aug 25, 2025 at 02:02:00PM -0500, Sagi Shahar wrote:
> > > > On Mon, Aug 25, 2025 at 3:41 AM Yan Zhao <yan.y.zhao@intel.com> wrote:
> > > > > On Wed, Aug 20, 2025 at 09:29:07PM -0700, Sagi Shahar wrote:
> > > > > > From: Ackerley Tng <ackerleytng@google.com>
> > > > > > 
> > > > > > TDX protected memory needs to be measured and encrypted before it can be
> > > > > > used by the guest. Traverse the VM's memory regions and initialize all
> > > > > > the protected ranges by calling KVM_TDX_INIT_MEM_REGION.
> > > > > > 
> > > > > > Once all the memory is initialized, the VM can be finalized by calling
> > > > > > KVM_TDX_FINALIZE_VM.
> > > > > > 
> > > > > > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > > > > > Co-developed-by: Erdem Aktas <erdemaktas@google.com>
> > > > > > Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> > > > > > Co-developed-by: Sagi Shahar <sagis@google.com>
> > > > > > Signed-off-by: Sagi Shahar <sagis@google.com>
> > > > > > ---
> > > > > >   .../selftests/kvm/include/x86/tdx/tdx_util.h  |  2 +
> > > > > >   .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 97 +++++++++++++++++++
> > > > > >   2 files changed, 99 insertions(+)
> > > > > > 
> > > > > > diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> > > > > > index a2509959c7ce..2467b6c35557 100644
> > > > > > --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> > > > > > +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> > > > > > @@ -71,4 +71,6 @@ void vm_tdx_load_common_boot_parameters(struct kvm_vm *vm);
> > > > > >   void vm_tdx_load_vcpu_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu);
> > > > > >   void vm_tdx_set_vcpu_entry_point(struct kvm_vcpu *vcpu, void *guest_code);
> > > > > > 
> > > > > > +void vm_tdx_finalize(struct kvm_vm *vm);
> > > > > > +
> > > > > >   #endif // SELFTESTS_TDX_TDX_UTIL_H
> > > > > > diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > > > > > index d8eab99d9333..4024587ed3c2 100644
> > > > > > --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > > > > > +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > > > > > @@ -274,3 +274,100 @@ void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
> > > > > > 
> > > > > >        free(init_vm);
> > > > > >   }
> > > > > > +
> > > > > > +static void tdx_init_mem_region(struct kvm_vm *vm, void *source_pages,
> > > > > > +                             uint64_t gpa, uint64_t size)
> > > > > > +{
> > > > > > +     uint32_t metadata = KVM_TDX_MEASURE_MEMORY_REGION;
> > > > > > +     struct kvm_tdx_init_mem_region mem_region = {
> > > > > > +             .source_addr = (uint64_t)source_pages,
> > > > > > +             .gpa = gpa,
> > > > > > +             .nr_pages = size / PAGE_SIZE,
> > > > > > +     };
> > > > > > +     struct kvm_vcpu *vcpu;
> > > > > > +
> > > > > > +     vcpu = list_first_entry_or_null(&vm->vcpus, struct kvm_vcpu, list);
> > > > > > +
> > > > > > +     TEST_ASSERT((mem_region.nr_pages > 0) &&
> > > > > > +                 ((mem_region.nr_pages * PAGE_SIZE) == size),
> > > > > > +                 "Cannot add partial pages to the guest memory.\n");
> > > > > > +     TEST_ASSERT(((uint64_t)source_pages & (PAGE_SIZE - 1)) == 0,
> > > > > > +                 "Source memory buffer is not page aligned\n");
> > > > > > +     vm_tdx_vcpu_ioctl(vcpu, KVM_TDX_INIT_MEM_REGION, metadata, &mem_region);
> > > > > > +}
> > > > > > +
> > > > > > +static void tdx_init_pages(struct kvm_vm *vm, void *hva, uint64_t gpa,
> > > > > > +                        uint64_t size)
> > > > > > +{
> > > > > > +     void *scratch_page = calloc(1, PAGE_SIZE);
> > > > > > +     uint64_t nr_pages = size / PAGE_SIZE;
> > > > > > +     int i;
> > > > > > +
> > > > > > +     TEST_ASSERT(scratch_page,
> > > > > > +                 "Could not allocate memory for loading memory region");
> > > > > > +
> > > > > > +     for (i = 0; i < nr_pages; i++) {
> > > > > > +             memcpy(scratch_page, hva, PAGE_SIZE);
> > > > > > +
> > > > > > +             tdx_init_mem_region(vm, scratch_page, gpa, PAGE_SIZE);
> > > > > > +
> > > > > > +             hva += PAGE_SIZE;
> > > > > > +             gpa += PAGE_SIZE;
> > > > > > +     }
> > > > > > +
> > > > > > +     free(scratch_page);
> > > > > > +}
> > > > > > +
> > > > > > +static void load_td_private_memory(struct kvm_vm *vm)
> > > > > > +{
> > > > > > +     struct userspace_mem_region *region;
> > > > > > +     int ctr;
> > > > > > +
> > > > > > +     hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
> > > > > > +             const struct sparsebit *protected_pages = region->protected_phy_pages;
> > > > > > +             const vm_paddr_t gpa_base = region->region.guest_phys_addr;
> > > > > > +             const uint64_t hva_base = region->region.userspace_addr;
> > > > > > +             const sparsebit_idx_t lowest_page_in_region = gpa_base >> vm->page_shift;
> > > > > > +
> > > > > > +             sparsebit_idx_t i;
> > > > > > +             sparsebit_idx_t j;
> > > > > > +
> > > > > > +             if (!sparsebit_any_set(protected_pages))
> > > > > > +                     continue;
> > > > > > +
> > > > > > +             sparsebit_for_each_set_range(protected_pages, i, j) {
> > > > > > +                     const uint64_t size_to_load = (j - i + 1) * vm->page_size;
> > > > > > +                     const uint64_t offset =
> > > > > > +                             (i - lowest_page_in_region) * vm->page_size;
> > > > > > +                     const uint64_t hva = hva_base + offset;
> > > > > > +                     const uint64_t gpa = gpa_base + offset;
> > > > > > +
> > > > > > +                     vm_set_memory_attributes(vm, gpa, size_to_load,
> > > > > > +                                              KVM_MEMORY_ATTRIBUTE_PRIVATE);
> > > > > > +
> > > > > > +                     /*
> > > > > > +                      * Here, memory is being loaded from hva to gpa. If the memory
> > > > > > +                      * mapped to hva is also used to back gpa, then a copy has to be
> > > > > > +                      * made just for loading, since KVM_TDX_INIT_MEM_REGION ioctl
> > > > > > +                      * cannot encrypt memory in place.
> > > > > > +                      *
> > > > > > +                      * To determine if memory mapped to hva is also used to back
> > > > > > +                      * gpa, use a heuristic:
> > > > > > +                      *
> > > > > > +                      * If this memslot has guest_memfd, then this memslot should
> > > > > > +                      * have memory backed from two sources: hva for shared memory
> > > > > > +                      * and gpa will be backed by guest_memfd.
> > > > > > +                      */
> > > > > > +                     if (region->region.guest_memfd == -1)
> > > > > Why to pass !guest_memfd region to tdx_init_mem_region()?
> > > > > 
> > > > Not sure I understand your comment.
> > >  From the implementation of tdx_init_pages(), it also invokes
> > > tdx_init_mem_region(), which further invokes ioctl KVM_TDX_INIT_MEM_REGION.
> > > 
> > > However, if the region is with guest_memfd == -1, the ioctl
> > > KVM_TDX_INIT_MEM_REGION should fail as kvm_gmem_populate() won't succeed.
> > > 
> > > So, I'm wondering why there's a need to for the case of
> > > "region->region.guest_memfd == -1".
> > > 
> > > Or anything I missed?
> > I had the same question in v8
> > https://lore.kernel.org/lkml/4b7e7099-79da-4178-8f16-6780d8137ae1@linux.intel.com/
> I agree with you.
> In patch "KVM: selftests: TDX: Test LOG_DIRTY_PAGES flag to a non-GUEST_MEMFD
> memslot", virt_map_shared() prevents the non-guest_memfd region from being
> searched by the load_td_private_memory().
Specifically, there's no __vm_phy_pages_alloc() being invoked with protected
being true for the non-guest-memfd region in
verify_log_dirty_pages_flag_on_non_gmemfd_slot().

> Otherwise, the tdx_init_mem_region() would fail on this region.
> 
> > I guess the code path for non-guest_memfd is due to some old versions of TDX KVM
> > code before upstream. Currently, KVM doesn't support private memory from
> > non-guest_memfd backed memory.
> I guess so. Maybe just drop this case and assert?
> 
> TEST_ASSERT(region->region.guest_memfd != -1, "TDX private memory only supports
> guest_memfd backend\n");
> 
> > > 
> > > > > > +                             tdx_init_pages(vm, (void *)hva, gpa, size_to_load);
> > > > > > +                     else
> > > > > > +                             tdx_init_mem_region(vm, (void *)hva, gpa, size_to_load);
> > > > > > +             }
> > > > > > +     }
> > > > > > +}
> > > > > > +
> > > > > > +void vm_tdx_finalize(struct kvm_vm *vm)
> > > > > > +{
> > > > > > +     load_td_private_memory(vm);
> > > > > > +     vm_tdx_vm_ioctl(vm, KVM_TDX_FINALIZE_VM, 0, NULL);
> > > > > > +}
> > > > > > --
> > > > > > 2.51.0.rc1.193.gad69d77794-goog
> > > > > > 
> > > > > > 
> > 

