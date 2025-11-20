Return-Path: <linux-kselftest+bounces-46078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB474C72B3C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 09:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E01B53570A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 08:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9542BE65B;
	Thu, 20 Nov 2025 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JqKpyZL5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246FA26ED25;
	Thu, 20 Nov 2025 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763625887; cv=fail; b=kgRZLgk4540KCPqOd3BsZet4alUgXzZLNBNsw4mgaaU9XlbYwkDMinNtAZHbv7+n/00MOcW8lAGkH1loFR4jIbW1AdelBNHJf7x+bDAEu2cd5RrZeeanbzXTD7ZN+kE7qbdRAZKw91ZdlCDaPSMO1nIGM87Tw3Y6ILhmauslKqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763625887; c=relaxed/simple;
	bh=CnLjhgQ7tM/biR4dO6Ua07/YeRE8j/8mTSLL6ZiVDi8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FqmSp2LhEv28bXGkPRjDRYZb0KWxYKaqCHdo36yhD04m0yHLzmccTQlM0WV5ktL8ucyN7fVh/6xOMt1JsPSC+p15YWv5lqx8ar87dfoWcuC+C/tLrTM07fen82C0CaKTAOQf11v7OOoNlKnVtKXFKxhO3bUsZ8VDZj+l/8fOYx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JqKpyZL5; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763625886; x=1795161886;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CnLjhgQ7tM/biR4dO6Ua07/YeRE8j/8mTSLL6ZiVDi8=;
  b=JqKpyZL55PRLiBAPLcyxClG88/0rMY6f3CPBefaccqkPBjl2Wi7K2IUn
   +OuZgIWKv+hS+ZjRXT8NU/ES5ceNsp0PjBS1WqGHcBdVJsgIeLJphtRx1
   ybSHHlW1HrHh8/BZgiwZWtAA47RrOfM/DJOUhIUrTZNkpcMX9RU4LdiLH
   5jGl0jQZxr33FKfSnC/ofqcSVyzUasXnfT9y9mALXKoAlhEP9ikwKCUAI
   3EJoVk2Btp52AFU5eDar8xlI0Orn6c904JNyhZ0nxGfYqIE79ImIad0RP
   2QZkwQ0WY7rs7IOSzLleQJlPni3y7wiUiWNN5zeCwAUESD8QbeXLsEEm9
   Q==;
X-CSE-ConnectionGUID: hlvMI0MISUaKZwPXW5H0kA==
X-CSE-MsgGUID: eztGKHxAS5ODFQKD41b0Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="76014704"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="76014704"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 00:04:45 -0800
X-CSE-ConnectionGUID: 179xk+QQT1GdX4x3uetPdw==
X-CSE-MsgGUID: gfXu6QRSQOGq6Yj4W5IMiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="190546003"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 00:04:45 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 00:04:44 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 20 Nov 2025 00:04:44 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.29) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 00:04:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7cvTlCBvI6BrrahtoVcMcp6Q1HSvQCczEP6LjB4igE6DbL61ZjD/FhKAQLbM1lGCW6TC8/figUY9+Cte/+clLH553h6eITYwdoWmlytMEmiyyjoZhtgQFJXdfpA3xicPX55urApYr6RboeiZg+saFRXxZ9kCkGAw8CT4V35Pa2PXCjCA55dCFL/pB0z/XCexz/+rXDTnx/xOdSwmo0WsK+vnqJGbVNAZ5R2+0t7FkHZXpW2sYxwtV4V87TyDJEtm7Fl2k5TOANoyw7WkVA+sVNJxBDZ7wo8ID4a+OSoyAi81Ee4adBLScaIjFITdd652NHzMCJHeL7dXiLH+CQQgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e10kEwqsdItOBS+Jzo0sxhzsg7+olSLdEjc3bwhqHlk=;
 b=ExUCExU4FC6kKKlF0+wLnpqx+i/xlAVpWAp92FsoKTGm69XcBRtSJL0V5JSU9KolZ6yBBO/ko2eblvFFI4x3vF4F+EyEVF7gosTt+IL8NT/GeNI8gFZY79gItyXp9lCvRcdaXdwtg2JxDkyInWv+ZZ8tKR7PemHc5Ew8ahvG622dnDf8NUtLJGnRIp9J9AmU/MYv7T7AF0kbtRZ7dnH6t5ZZxI1gDx6IbQmtdwaXFpLaStuKENalEJ/Wro1yXXEr8xaxyXnKUB9sB6vTH4wX1+2Y/4Ow5yfFKtHXEEa7nZxEAd8ygmq6ys8SCuOIZR05oR1lZg2CiIDpzvgAMWw5lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8840.namprd11.prod.outlook.com (2603:10b6:806:469::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 08:04:37 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 08:04:37 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>,
	=?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, Sumit Semwal
	<sumit.semwal@linaro.org>, Will Deacon <will@kernel.org>
CC: Krishnakant Jaju <kjaju@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>, Simona Vetter
	<simona.vetter@ffwll.ch>, "Kasireddy, Vivek" <vivek.kasireddy@intel.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>
Subject: RE: [PATCH 6/9] iommufd: Have pfn_reader process DMABUF iopt_pages
Thread-Topic: [PATCH 6/9] iommufd: Have pfn_reader process DMABUF iopt_pages
Thread-Index: AQHcUAaONk5kJe1SWk+KTTlCBzwjRLT7RzZw
Date: Thu, 20 Nov 2025 08:04:37 +0000
Message-ID: <BN9PR11MB52769E70061CE3AB22F9E0618CD4A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <6-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
In-Reply-To: <6-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8840:EE_
x-ms-office365-filtering-correlation-id: 2b428883-57b9-41d8-e52c-08de280b72ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?UEXfmb5SrRNHdNVwjge76WrDeyqbAoJySIQyjoxUQVSCm2dLooK6CN/se4?=
 =?iso-8859-1?Q?CdpUV6t0C8oISJfRexEQBW+471nrBl1D19K4fUevHoAgSbHUzdPcvYyXqF?=
 =?iso-8859-1?Q?H5Oa4ln6TnfjX1L20ypqLVrq+SS9px+GjOqTlmZyqLZYJFv2JZ6OjhwARY?=
 =?iso-8859-1?Q?oPLdcz63NisTz01emSd3UD9duagavrohBQQtBI4NoHNJCjEPTx+qtgaGs9?=
 =?iso-8859-1?Q?vBGbbH14d3n38SP4x4A803sSKCzbjxPSY6XP+zcQLfYW1ne9Fzuw8AFjvG?=
 =?iso-8859-1?Q?2hGSjxr4+0AhcfYJdIC1CLlxdF4D0XV0fBNWdKr763prpG3J6gh/OrhvCG?=
 =?iso-8859-1?Q?2lg8aCZfXVWijHzRqlm/muFAOfEjMqUoVizFpnf7t/aW8RWKKu0rutLMwu?=
 =?iso-8859-1?Q?5wOGq0bnUzzrNPOeeRg5ky49VPyMXkFHFtGbLQiemXVnvgtld8E2tszkqq?=
 =?iso-8859-1?Q?AdrkOsvfQnw5FsLxyHUI6tIG2lsrvK4wN5+MjjUVNeN6Gz/weMC5H7hir2?=
 =?iso-8859-1?Q?bpWkm+tlENCfrHKfdH1gLJ8fRzCF78X3rHBChxem6HfvCI3Cju7mZM1axJ?=
 =?iso-8859-1?Q?IuW4UrNwUQ0pU272T2/yBAERQtVDZnWjY9lTxVqUWqlh7aD4jpj+QTXxW6?=
 =?iso-8859-1?Q?QHDJF1swZ3kndUhg/0lmq8C1fTQ3IfVyta+yECCDdYKYkktS2jr3DzknD1?=
 =?iso-8859-1?Q?BDR9UWll/Zfu+heuFTz5Qg/5x0ep7MkVvGS8HRtuMznKLHnAkdY8Xspstb?=
 =?iso-8859-1?Q?rNQBj0bZvUrGEoQESg0NEEaX/TCsJbF8jtBobAQpCJugUV2QNtiie4HaHj?=
 =?iso-8859-1?Q?6Jh2GlkCrpbHxUY5lIe/N0/Hdla/W0v0OCEwVCmNwAt7aj/dpDmD/LY9aj?=
 =?iso-8859-1?Q?Dr15NovGNv6GqxGhhS3trpt+HECgg+VPNgk0YF+pHqlP3G2lDCBscuT7kL?=
 =?iso-8859-1?Q?W5GHCX7HOdE6xA0KoP4WzyJV/nJgn1wpah5dEX6s2iiQVwQO19GwWTn7Oz?=
 =?iso-8859-1?Q?QkSCqrv2IGMFnegj9qg01JIGI88mHeVHFVu6vKaOv8Gg8GRJkWt+i79jjI?=
 =?iso-8859-1?Q?E3Pkl6TlNL2nhAbLb2grmg+Ikv591PK2E4XUUCTXEM7+DbfWlGqUZ8+bB7?=
 =?iso-8859-1?Q?aAEVt0mt77QNWKIuaae0SLZJLq+4K4jv/ZRC8Mia0YihY108rXx0dP0bLK?=
 =?iso-8859-1?Q?p/slE1iSEQUMzep4zo6c/y0zcBHRAGHNApp5CdGZAkjnvdncE17rEmKalj?=
 =?iso-8859-1?Q?GEEb9vcQydft7JFdFIrtwov1TfuL3T3DNqfcNBqvBt1QrZwSe+wfezOavX?=
 =?iso-8859-1?Q?w6tQ3v8aFgdAVG2ougp/dk2QlexNtYiFU+/3oK4MiugU1gVXjmtmiKslY9?=
 =?iso-8859-1?Q?EfzksSeALRHaL46DhsoxCX58YISkPuVIPim1Cjg4wi430vxnvfiaSK2Lzo?=
 =?iso-8859-1?Q?3JvsBnX+va/F8YkabE/ghPPjIrqzqTK3dUegPgtA97RRImQbw6HQy4Rct0?=
 =?iso-8859-1?Q?cQRiWJJi8wL+3OIVdFuihGG3UPbYgqG1S7mN32+ZlFTbVddtL1dBm83Og0?=
 =?iso-8859-1?Q?WecQ/9f1QW9WTjQjo1WVGpr4obrPJQ9EeG0TYKYa4M/euChzwA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2z2+JbcpTnl5wJ+ZsGQqLlp7tw81NBea/5A2ynIK7UHR8RjaNoEn3PDw7i?=
 =?iso-8859-1?Q?C74W6tXRrTabYFg5wRcJAQyZgA6Jr2e30214UHFTaynWxK1L207vAOmp7z?=
 =?iso-8859-1?Q?ODdpt6Y+8Zxmcsgkg0QnuAFDXACFDqG3l4r8wyLL+iIwxsEqg8iNbajwgO?=
 =?iso-8859-1?Q?TSm6qKh9A/tz6sqLO68k7J7NMbQIoX544NBWXSXz0vx9pRwHoDyElI8XFD?=
 =?iso-8859-1?Q?fp5vnQpjAaMP/1th0XrsDBK5QxrYgAaxWiADXA5SeBRJZZ+Ua1cioAKiQ4?=
 =?iso-8859-1?Q?Q9Pa72W7LUbSEbMPSJSSekR3U/be4gqHShZk6NYkIyCFO4dnThLyJAsLsP?=
 =?iso-8859-1?Q?M+ucRnoOl7wNyuKkTrX5uhSSjAIc2LXWH0N/2PhpDo/0fv7JDHE6KrjjMD?=
 =?iso-8859-1?Q?jG/i1TIabe0b4efGWly3a5M2ukYCh3E9FJhaa2vifljWN3Uj1Lq6OOCpD7?=
 =?iso-8859-1?Q?0BYT44FGmYRpct9vPZc8bNNYtxugSCWerZhDmwPHHB0oe2R7Z3ReCWIxs/?=
 =?iso-8859-1?Q?cSUnW64kurFMgXXwpn3UzafIDXY60fjYPH3FmjDMl6m04WYQ3Kze0fqJMX?=
 =?iso-8859-1?Q?U9SpMM7lyoeBWRVly9iioV/sPow0UGnIamzbyj8+nwkCbrKuaAtTy8dic9?=
 =?iso-8859-1?Q?1yji1sCFcr6uvh4cEB3bSYI9u2jLMxOsKkHSV+1W4AkpXEPNGt/mkbCii7?=
 =?iso-8859-1?Q?KWp1H7EaDusSTxVu9EnteKVZp2Sj4sv27+ddksXmWAnufkD7+//F4S5Ub0?=
 =?iso-8859-1?Q?bsmLitKVPEvmm5303If8kE54oa7cELefBwkVosnKIhbWk/Be3XV9pLnN2f?=
 =?iso-8859-1?Q?Du0gOBNlJy/TPQ3L1mWGH1gUhwyMB/tA5avMkffGyvqQ3eF4Mtm3+S42ru?=
 =?iso-8859-1?Q?PZGbOSUCgsGnvG0y3E/R8quLLEF4/Fz5Pdd1YhBTx27g9j4wgnK1NvKd3l?=
 =?iso-8859-1?Q?vxnLGKFKSIf0J/6lfYQCmvDdgAnBQ09P/NThOgR4Mj1B50DPiUmhd6iDwR?=
 =?iso-8859-1?Q?ERHumBu+P8ow70oYHU5+dGJNfGvAiH5H9pzjqr8EeKOWUDV8eCJzXJ+KXD?=
 =?iso-8859-1?Q?X3XjJiAayK5hxgnxQwFjH/sKeo6Ml50PLOWFs9ufMsrPYn5elVIv+HvVfJ?=
 =?iso-8859-1?Q?gmuaj3/vr7VnaMR3n67Dv7vVWyN8oue2Zl2IEyIbTQxq/zw9MpfPf0vTZU?=
 =?iso-8859-1?Q?QitDDAwBExIk+0lBbl06Izo/TTjW45wsWd35akobe/g/Ny17AJGJ+wzOMN?=
 =?iso-8859-1?Q?T4yTbmg2gwvHHpXuBbMG/mBUitXRIrdAgFVnJtPosU4vEcTO6KVbAo3pHL?=
 =?iso-8859-1?Q?a/iC9MrJTdfLpOK5606I3gkrfCrRA+CdlS2bKVsgcb9fxxJHz2z3v6LOv2?=
 =?iso-8859-1?Q?vweRikMWe3faJVqHQO/lTTRQZbTVS4X1RKPrp7eos0nb0Asd2OFlOsiA43?=
 =?iso-8859-1?Q?HYjcYkvO+r2vL8QgyPTm3vfAiiLJNcQEAPgT4FHdbLnSy23ni6ybypXpGC?=
 =?iso-8859-1?Q?bCE8I3E6p/DauaBjZM5oi2jTQqdW/cYmOUzfSy7RPhjbkpUBgzYwMhpsiw?=
 =?iso-8859-1?Q?zwkc4o+ojU1n3GWfThORVeGPE83OKPlQ0vBuw18TyyzfA6HuqeVcsVtLml?=
 =?iso-8859-1?Q?3sFv1JFpg3Tw4/8pbOhEMAkaaPxHnp/m80?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b428883-57b9-41d8-e52c-08de280b72ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 08:04:37.1026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ID7YfMAeUtbwnMIysWpZwDpXuaCMGs3Tt3Sm6aV6KVHrPnhWADRRrlomIg8n4SrigHHzNGUVQg+sQ0irNDk0jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8840
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, November 8, 2025 12:50 AM
> +
> +static int pfn_reader_fill_dmabuf(struct pfn_reader_dmabuf *dmabuf,
> +				  struct pfn_batch *batch,
> +				  unsigned long start_index,
> +				  unsigned long last_index)
> +{
> +	unsigned long start =3D dmabuf->start_offset + start_index * PAGE_SIZE;
> +
> +	/*
> +	 * This works in PAGE_SIZE indexes, if the dmabuf is sliced and
> +	 * starts/ends at a sub page offset then the batch to domain code will
> +	 * adjust it.
> +	 */

dmabuf->start_offset comes from pages->dmabuf.start, which is initialized a=
s:

	pages->dmabuf.start =3D start - start_byte;

so it's always page-aligned. Where is the sub-page offset coming from?

> @@ -1687,6 +1737,12 @@ static void __iopt_area_unfill_domain(struct
> iopt_area *area,
>=20
>  	lockdep_assert_held(&pages->mutex);
>=20
> +	if (iopt_is_dmabuf(pages)) {
> +		iopt_area_unmap_domain_range(area, domain, start_index,
> +					     last_index);
> +		return;
> +	}
> +

this belongs to patch3?

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

