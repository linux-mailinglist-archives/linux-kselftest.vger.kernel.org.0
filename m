Return-Path: <linux-kselftest+bounces-44359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAAFC1D66E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 22:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BEB2188E393
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 21:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3722F7454;
	Wed, 29 Oct 2025 21:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JCxXBnDI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E090613C914;
	Wed, 29 Oct 2025 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761772641; cv=fail; b=meShn/A+TzoeUUzXu0VDX408kHHnUaR5bdVWzYvAGv/pLoELXJEgHdgo8lKpWEt8shNZMCb9ICkNhpK0bUDNv9JfxJ0qIH/FjdeMGPosHx/I3I83DCAPgZ2Ogd733G03pfx/KdkhkJIbrbiNVSx/uuS0VP8L1wndlSZ2XCiUWlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761772641; c=relaxed/simple;
	bh=btB4bG5UCW6T12vBcM0taBXRVs8CYAPsZhOD2zMh/Bk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yo9q2w9uRZIZ5y7WzzYH3bP7uJZrpO3O2vYbqpWbqD0SF1cl5VZHurSUt2pvCedw5fYepUugk4MDJx5oGJgxhNB+D/WIZmxZ+rtn9MEfNFUc5VKeu84d1vOvANXa4Tg3FDX4W0X8FF3kqWj026Zoq8nqll6XlQJX+Z2zNciUcmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JCxXBnDI; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761772640; x=1793308640;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=btB4bG5UCW6T12vBcM0taBXRVs8CYAPsZhOD2zMh/Bk=;
  b=JCxXBnDI0WqxMtB/mIvE2pMeDBjOaaAR5+8r47HqWXTr3fug78do9pKd
   gW+7wTS91K2hKTIhab8AyxFVVfcFXYwJsQAh0cFcB9yZURUY5sBRwvjBI
   lss3KBywB2BQfUF8pSKLRyA19xVH6lBzsHG1OLGtzhB7Jf6z2US3tN3f7
   kAden3Gf11NiuNKJxbFmhuSOVXcZPT/PEvRtWrCcnyzgne8YrFmv07y3p
   rwb3+Qhj7VFPMl/ElOBB+EAhQR/HORkP7JaL7nlSI0N+RdqknlANLkflG
   c198KOj8eJWW5uyWERMPDrDOIEJVkLq7sgWhq5m9fSMMQXMMQKVMDk+fc
   A==;
X-CSE-ConnectionGUID: 6l496TaVQpq5lLhpjkYwiA==
X-CSE-MsgGUID: 04XPp7YQR6qM8CB20AFe8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="62930868"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="62930868"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 14:17:16 -0700
X-CSE-ConnectionGUID: xJmNJPoOQLevSkaN2FDcUw==
X-CSE-MsgGUID: l/WB/rtvRempmwyjzaeX9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="185023119"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 14:17:16 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 14:17:15 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 14:17:15 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.65) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 14:17:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8K6NOxu0fT1yO/Wf8A+1MgVqd98GcqpDCWwulv6YGi3h6i1XoGIfeN3PZGvtyt66cBBWs7/fsrZpppbnOofIGJRCw7TJIIUgYHO4Ew5Ugi5tHUSaYheoKoJxF1Qk/okgA2EaH1iL5YT/hshJ/BSKWQMv+ZtOZWbEXqFRDUX1oVUJZJtEIGRGQYqnRH0oxNzBA9zhAB8jGR+F+9LHlGlcEi5PonhjQhVxctCENVxsA+b5NXQY3b/lnZUtYoLene1EBdg8N3sZoJ337xw75MOgLF8V8YiwQQawBN3Y43IrEBps6L5hEIXBmPaZghp5mPHnp20I+KPsYvIlC33gfz2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhl91LHLUnXhMPZE0ccgUH8jikadie49mDpqFFbCqlM=;
 b=hnDHHGDiK1bO3tDEECZ6iK+OzTsZn7m9ojDCUT0naWhQmmhGooxPiflNkafzZ5QPq3jMY/oAelAtv+VfOqlHFnNsKJHOh8EywVjUFbt/IiGH8n+5/nzZefV5P6iBmXE2dnchuCkQbVnY7hRwl2aTo/yoKWggtu6s/s3LcMGR+yk92wjaWAxxzxxd5ikk5H+qpe9Vwv5kOpWvRLgX7jI6eI/5VB+AHEfkrkKntI0Gwb7EHNJBMma8ddXlOxNVYA0wg1CDyIQQcRVClze6P96EI9XiG2DEJWgTSBeww6QBB+2Uo14oltfzKPm/sLiUZHwd4TlUvENynfy4Za5D51C8vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by DS0PR11MB7999.namprd11.prod.outlook.com
 (2603:10b6:8:123::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 21:17:09 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 21:17:09 +0000
Date: Wed, 29 Oct 2025 16:19:30 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas
	<erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Roger
 Wang" <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Oliver
 Upton" <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, Chenyi Qiang
	<chenyi.qiang@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v12 13/23] KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES
 to validate TDs' attribute configuration
Message-ID: <690284e259d30_21ab52100ab@iweiny-mobl.notmuch>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-14-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251028212052.200523-14-sagis@google.com>
X-ClientProxiedBy: BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::15) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|DS0PR11MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: 85420d28-d062-42a6-ec0a-08de173084f8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g30b/hmfPEa7OiLRHZbHOC9ivt8h29F2QgD39NFgXk57NB79FE5ZYFIFhcwx?=
 =?us-ascii?Q?uf5XAP/obqRxJ14VqVmVGde2Qm2htE4igOFu8cMW6ZVcNcgxM2IMea0J0fSL?=
 =?us-ascii?Q?tKCaq79dNnS4SigseAO3YTFEX7yYmmGc2tlxfBWF1052w5Lf2PMT/q35P0Yb?=
 =?us-ascii?Q?V4kAtwJX/qEC6QvAm7wkCyIdleqeU+2I7v/abB/w2iHnXzlk8P2iv3Yj8r8c?=
 =?us-ascii?Q?rsjJXd7EE9UnYYy/HiYBQuvkqfIz4H0TEQaoLxSc00bbJe4Alb7sI2PMPaTK?=
 =?us-ascii?Q?RuenOIvomGwvpnbDEIJy3gf9dfai7NMiZjbfchV2JsmjOOxT+TJMW1bqqqjH?=
 =?us-ascii?Q?HBmMC4RMRxas6FP4wU5R2UnNsS4nbJu2/bqqbkRafwtnXqGcL7Pt4pQNKCSD?=
 =?us-ascii?Q?zUoEP05uYZS2o+GD7KEvASHBVNP9yk81W+uTeBqHkKNdY9geviGD+fd027yN?=
 =?us-ascii?Q?dBrMg2se3jVJ237Fap36rzLPqSn9oVOSRchsrm+jA6pVAx4D6qLBwF8eSSey?=
 =?us-ascii?Q?LIAY4XEESw6Cc8b6d+RPr2r9eG7WVjbp8ZFYmy1JkftLfBsnDr74nxugT11B?=
 =?us-ascii?Q?MpMnUIfRaFyhT6DR+I/SAFQ0kH/rV5NAvo0zEH0xEycWSVQU7m1V9DLxj8ow?=
 =?us-ascii?Q?tx8q74CLCPf7bH8TEZSfOzGJsVyDugnGqv/RfngrEHiRLC2pVhHxVuHelKkY?=
 =?us-ascii?Q?SIGfbeQcnFnusov1eT0yU7Th66WXn9k+Tz0S0Lyy2GjKXS7vM5Fyi+OoQMQ0?=
 =?us-ascii?Q?uFrPeGwvMiTZx5Nm8VHB/dN1DlwIaG69O0u+zguq9FfbCyFnxiFe0pmbhvmh?=
 =?us-ascii?Q?Odc07IbOC0b2H9WrvcoX/UCwKWEtSsTMKKzdXIsOz05dz4BIesnkoS/1W6sP?=
 =?us-ascii?Q?OIRNM0LFKJmRRxqmKmQh+ulxpVMpnfIs3xM7HN8ghjIV0tyvr7HoPWyAW9KK?=
 =?us-ascii?Q?VfKYxMaNBvCNV4T34eb8oChDcg9T7NfMXNideD/2axkK2kZTz3+AO3PWS6Jf?=
 =?us-ascii?Q?DeN4ciWww1+CCV74CQffJd11lpoqHFdgskPH6o4wm0XKPmq7xiA+7UwkM5Kf?=
 =?us-ascii?Q?6S1je4XZ2FmSiCR24q3dnFxyjZiuIAsKRpCGNOjXcwjT2w4J7RjUky0I+RC2?=
 =?us-ascii?Q?T0GtG6/dYfwCRRKoOsNW2WimtQK/rrGWJkJ30gPWxLRcr1ya4+3hxRFWF4f1?=
 =?us-ascii?Q?M8osSQYOHNijHI17sUXdeQKGYRZuoOoaaTxCtbNxtR562Jd4xvYm/aM5JzY9?=
 =?us-ascii?Q?1URmfkd5PZgQ9R05mU69LxWXcDE5Vch+OU8md7oQ2ui2Kyg3eYvRoUw485wp?=
 =?us-ascii?Q?MEshnR4sVgPKTvPDbnwDh9cURuA7bR1bH53WH7VCzab/hxISlmX5IpriktuE?=
 =?us-ascii?Q?jGv8WiG0HRh37TYIm6mdkYrK/xQrk9SpyPd55iyxXhLvpl85eqgBCrnBpHP1?=
 =?us-ascii?Q?1reUqJpevF5tJTQM948xsSiklRYn/ZcxTraDwxKVkzOmfjLdpMiZhx811kPy?=
 =?us-ascii?Q?0h4U1Z3Lcwj4FdY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a5ZWQSyuKbVJ52p8YaUMBlN5tVDjtjLaeQPk6GUmyEwYrqT4RscBsahMR8ei?=
 =?us-ascii?Q?l9QHyTt7JOZhu30Axa7z7fgCipOdaDs9c0+cLFCDMes661hQHXJyI+uuIWJ1?=
 =?us-ascii?Q?0odVwWP9IRqNqo4ekvCjPMLekejStirYBCrd3Hk2/Hl4d4/ANYqGf3wkLNg/?=
 =?us-ascii?Q?tGKBhUnw3PzXg1F6AhDn+RT7Q3mxS+SBOulnUVJQTSOGRnJLDQLnVzx7pQli?=
 =?us-ascii?Q?nt3tCmJn7XCAuu68sWBfjn38NyXW5lUsVRLtlJTjb98NNOkC771CTz467W42?=
 =?us-ascii?Q?uc+ZV8hsJdbszzHtd9AWwvlO7gBe9aiMQrThpKzdhxgSRxx0KE4OI49cOdSf?=
 =?us-ascii?Q?wSQtloXK1NbmvTicAi2i9yucw7LuAUs6Cb6SVGuckhKmlXwSUalypQwa7EYz?=
 =?us-ascii?Q?VeLRfzo5yNf7tIMyqX0iwpj3mbWqn23KXzQyfog4ZaoZxQ03Kv2RLgdPfrUW?=
 =?us-ascii?Q?+vYipr+5jwfguMxlUycwtMV3PYmOuD031AUPWbO1thbfq4TFOUPwP434zrcn?=
 =?us-ascii?Q?IA/xkSzwvK1RRQELWlUmP6EfuLxnRiwN+GS+tw7gmUlNqGR/onGrKCnLSgCK?=
 =?us-ascii?Q?Fy97e1G0EM1P93o2TMON8eXOh2mZ1FEX/LKk2qAKrnFDRqz/QB21/s9xDsDy?=
 =?us-ascii?Q?JA3RYWIA4WtbpeT9Mypr075xObEB7lLIcNcVbb2v5kA6DOxZdvVofYy2PNu8?=
 =?us-ascii?Q?mBxMI+VliEpoLH8ANnVu085P4A9R6FcTs0k7OvJJnBU7ihSY3SiiWMPs3ra/?=
 =?us-ascii?Q?Czlpo7WUuygXFyCB+AXKCaHvlaAqG8ecLaio1AbvD5o79VAKS+sLeB6osIIN?=
 =?us-ascii?Q?3il1/q1x0DF7yrv1clHIEzCF2rdymx0SF9mkHnqGJqR/d8qrH4C/SWWoK+iJ?=
 =?us-ascii?Q?HGmXwhRFLR4BQAfGosMCS5vpAEN1ED+8uhVQMNhT9xKJUkgqw4TTsCKA55OZ?=
 =?us-ascii?Q?eiog5kgCtCHdVpI5wyjNIQTUantfZyhBETkqLP8jXLPKGaD6ojDQatZsJYOc?=
 =?us-ascii?Q?4EorX94s8PfZSH4K+a1Zdm3BCgoUY0ytArXXLS2ZHZv3M7TnaDnKo86d+5sq?=
 =?us-ascii?Q?che4sOKKl8XyCq7qaaelTeBbXKNz5+lIiw7S+MeUxwfIPKhRPIPz3JK+PkW2?=
 =?us-ascii?Q?rZcf9lbjbmxl18CNAcxuCMA36YEWkd8zFu/D+JPotmShL28HDBfEtumY2qXt?=
 =?us-ascii?Q?6UHvtsjDhWGfG+dk2/5gy7483ucH4nK+4LtFK6pvlcb0m7Kk1u1Futrs3m4q?=
 =?us-ascii?Q?eFY7nUnQ78FMiKccyh4XIFIiXvdNuXlactCWSLAuUhQ3zmOtIN5tQbj5IBgD?=
 =?us-ascii?Q?dEHRhkgLf3TX6UDD3vrNCB6igitS72CaeU6R01eN3yf7UV83CqW4Mj1fRotM?=
 =?us-ascii?Q?yg9KAzVZQIMyjqG6suLIoJnqEftjEf7f3AOTnoaHiD4Maw10LoeErm4jdRUt?=
 =?us-ascii?Q?gl/MEoe/ILl2+zvC536yzIUu4k+hv0M94awlr7WpRPZCvIepaHkIDsL4EW1X?=
 =?us-ascii?Q?qaDcKFMz02Mg8m/laJ3LTAeX03E/CuwKQze3K/Au9FySsK4VjgOjasHibOL7?=
 =?us-ascii?Q?aBfxKlm34Sr4ps1kCHT0zO2IccMFPnpnQ6hXoeldiFIFASnOYxDTiwznWppn?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85420d28-d062-42a6-ec0a-08de173084f8
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 21:17:09.1687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2/Kc9GclVQ3ABmw0M0khZzlDR/5re+Ya0AMmfXPo8UVUJ+IfLs5+CRE60T/5c4kgpAb7iKjU1PnkvDOUCROjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7999
X-OriginatorOrg: intel.com

Sagi Shahar wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Make sure that all the attributes enabled by the test are reported as
> supported by the TDX module.
> 
> This also exercises the KVM_TDX_CAPABILITIES ioctl.

NIT: I'd strike this as tdx_read_capabilities() was already exercised in
the init path (last patch).

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

