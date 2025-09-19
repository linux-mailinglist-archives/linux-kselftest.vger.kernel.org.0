Return-Path: <linux-kselftest+bounces-41918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6AFB885FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 10:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB6E37A3736
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 08:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033782E2845;
	Fri, 19 Sep 2025 08:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+9I6Z/B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EB22D0605
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 08:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758269811; cv=fail; b=YpweEc8CG6NOXy3b2Ll8pqTn9MNGiXcAJ9rBmVver5+rT8dNkaKd+ouFaT8tdvNj8nefAB19PqZapHt6OIx4pufaanAF/lwo5l6zdNWfWfxMdRTKHKd56YHFbv2hJ+nHv+fVIGrk0KIdNNfoHZzJz1f0AGAVNfCp7WfXjl9LmTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758269811; c=relaxed/simple;
	bh=797AA41VvdEok/nyXEJfw9B1LcCyKOpuIt4AAAuXuto=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=popLwjYLdtJb7pTbnZkbiNnDHZDKKSTc29sgsajn4ENA9EV5uoxAuMWOkjDyM07xTP0M9mVfHUddOV8EMtevB61SG8DlIZ5m/3AiAKJwZcm/gRqCeStqh5zE6kqGEoaEkVxsiUocaRT9PEejajLrqPX7XK0P+Tqa5asYZ7nuO8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+9I6Z/B; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758269810; x=1789805810;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=797AA41VvdEok/nyXEJfw9B1LcCyKOpuIt4AAAuXuto=;
  b=a+9I6Z/B33/xzuvhJp2mQTFiQH7+sOQXdIFtO3T2lfiJj5kE1ei2sPUb
   kvUYFi6C035knUEqEI+AJIhnUNV9SAfsEiZR04X0mZIymfD4aTMFU/xRm
   axpxRfa/1ql8WslKvnUu+ibTDpVX3HQfeg6Quwq2v0eACKEOg+3eclci4
   3hxMRdSYM1lZ06f4IAaeA2OodKCh3J+F6+68VBVJT/YVXHxfZ4jQ2poFd
   or22jSkOg7pW/3JskVSTaH8aOYTRiW3s2jWixhRYzghpXOcwqSkKT+i/K
   jW/RYx42kqHKKFf0/OM0iIdI2QHGueD9w6zkLPqPioeg1U5VoaQnrITsJ
   w==;
X-CSE-ConnectionGUID: VKcQ41hhQIuwojhphBpPMQ==
X-CSE-MsgGUID: y9DVepjQQOedKlSNvwQw/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="59653570"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="59653570"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 01:16:49 -0700
X-CSE-ConnectionGUID: BETkjTn5TLi3S0BIWgJnvw==
X-CSE-MsgGUID: G+elOeNyS/GaNLwUyEr+Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="180194442"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 01:16:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 01:16:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 19 Sep 2025 01:16:48 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.27) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 01:16:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoqUyJZVXur61UpQLc7Q0dU1Ug62x9JNhDGV5MOlbxpNAmZJv9QFCwnPZ6pDDuY9+0g6/Y3N28p3PP8tWwxyIMVKSVFtvG0jffd2pq6xx7hRo8p8hvC/hsYyB7GSQCgPT9jkBm2NlUIhwyemGM/HjZSGnCBHEh2xH4XyjD5AwaO+SNMkdQzkYdDBJlFk0Hfq3tIPcWu0qemOwcN72HxlffY9m1c5ztlc1qzYaUy0+FvE9JG65ra3762ZB9BO9C+K3kLnTpShQotTY1nNZ85UWsj6jj4A8nVF6HLgfQbqLLP2eDoWsnGmdtAMoIGUD+ZNOCA3yxw9M92Ryo9MXGjN0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=797AA41VvdEok/nyXEJfw9B1LcCyKOpuIt4AAAuXuto=;
 b=F7+bBY0P++Wni91kcvwwDqV0jGnTj4NiRG8pz0BPBnhEomTeBPn2AdSLY76WwqST7WTlIeSwH4mi7WhgG6vM1h5RJewiB6HpwTEqcwY4Fpww6nQMKqhPT1oIy/Zc5cK8mn62jgjD/10FEnnNOziU+SxtZ0xBwRIyijiTg4NaYkT93NUwJ3bOwYTfqBepNqX6PLya7u5uk2/uPU+wtqjIdc+q4Mgtms0tCoZELYfjU+O9cM3v0O/FCkow06URAmMfRYY+rDpyU8XZaLt7dqNNYMnP6js5JIjceUrRlZbAuVfo2f7AxRYLZ1Xa8nU6tCQyeZ5BEwQ8dJqK1RevUdAfaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5796.namprd11.prod.outlook.com (2603:10b6:510:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 08:16:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 08:16:41 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, Will Deacon
	<will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>,
	"syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com"
	<syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com>
Subject: RE: [PATCH 2/3] iommufd: WARN if an object is aborted with an
 elevated refcount
Thread-Topic: [PATCH 2/3] iommufd: WARN if an object is aborted with an
 elevated refcount
Thread-Index: AQHcKA4LKqYCZx5Ha0ih97pE575oW7SaK0Nw
Date: Fri, 19 Sep 2025 08:16:41 +0000
Message-ID: <BN9PR11MB5276587D86D1C100C97C976E8C11A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
 <2-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
In-Reply-To: <2-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5796:EE_
x-ms-office365-filtering-correlation-id: b230f2de-978a-4ca4-84d3-08ddf754dd56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?wLAjicPTcZp6Xsauck1rQ/fRyNIUgEfIv3iL0oDWtDW2PUc0wQ8a02Dt/RHc?=
 =?us-ascii?Q?1zZ0LX3CDXKvGcKOfuzJLW3yhmPBaF0Nix/YuncxaEgvXndDO12e/CIRWgI1?=
 =?us-ascii?Q?dgXYoop0cGxGqv99yjWCe8gDJG2cjRFzVIFx4Gdbzy+QlX806j+nnTNmNYlt?=
 =?us-ascii?Q?WB721uHraATABQxh9MPY5du95c5+UOOUmP9Ccwy6GxzUUgg6Zmn+q+YIu/DC?=
 =?us-ascii?Q?LqGaDiPaMszqD4LbBrhjWTJw3EEeF8I/IOG4ReWWihioqjT2wHdjeqZsJpK9?=
 =?us-ascii?Q?KoF28ozba09Ie2La+0fXQN6KhKJ5CbdVtqa5CCvARvRzvMPi3SI8aKnBt5Qo?=
 =?us-ascii?Q?npyV8O4MEuzDTp27YOo9rlBYnxNBKC6m0gdmnBrTpTyTsAVG6C/c4DdKChNg?=
 =?us-ascii?Q?dmgGuIPGBZA5bTdqFDEl4KNTD/Gwth+oHir+8AWqCI+EbPqKC+8v1+FKvOdZ?=
 =?us-ascii?Q?9M7d1KxOpzdmtKAI6FW21mHoZZuXJdY4DOgkYgIW7e9XBjU2lg70/DcWcWXu?=
 =?us-ascii?Q?ZlODe4BHFKxkxTbuqLuytBgbZ6YQZsjy0vKacWZ468+wP9XNLy6IeFmaSzXR?=
 =?us-ascii?Q?FdYB9sR8M561p55NsbMj+Ti2t00DerPhRqukonxcgbI4ceMZjYO3tY/SMu1P?=
 =?us-ascii?Q?cWGDiJMZ0lUFWHHWnKT25uCKLOH/rlY2dSoPHRujlWJiQ8or1WvI6B0u9/yX?=
 =?us-ascii?Q?+++klMqGTLubA30Q8cUSEd4DyGrzl+TTCEUqNUvVmoAh374J6OahPlnoVYT6?=
 =?us-ascii?Q?9xA5B0UPR6h+Tx2+wegWa1aPg/rwlU7z7mXFUg+kG/WPnsLblElic+GK4oMX?=
 =?us-ascii?Q?MbUme5vHsUbQO5ZMtpHoOTPvP4XJD36MQiFw/RFlH06QGAnUkwb9CTAATMUm?=
 =?us-ascii?Q?LPnaE/mMuzWIFN/cWfi+uvwgeY7PnsN0ruv7TPrjpXaI0a1oRVSpcoRLkl+b?=
 =?us-ascii?Q?GsgXZnVq0VyazbZ8skGznio6XSqvx6K6iXzr795e8QFlNyr/8Cq16hXoAIXs?=
 =?us-ascii?Q?Z7E/G+9LCH6Rw+ZPQB4sqsmpxjkzGkpjTgb/KBI3opP1nSjC61/z5VSTgp55?=
 =?us-ascii?Q?KOaLsK0mM4KgA2txSStx3VRDHUxdIpd8VRVSfWRTRyiWMbG5GcHfGY/PFguv?=
 =?us-ascii?Q?3ZnrligCKv5miZPN6pUTGVvpBR+1LlY+Jo00ZdHltLTaUHsl48P4tLocMQT8?=
 =?us-ascii?Q?UKE6UwLOAupou87eslPFyyOzYZ69vSNl95/FimhWoNX+EE1XsVRWXjtubcpD?=
 =?us-ascii?Q?5xCof9/CWsqlvYkSSGm9JrSu8+f9PINBi8VWCgptjdMSt3aEF+N1+YmPhqSZ?=
 =?us-ascii?Q?HW4n6NbJKZZnomiUJh5H3MIyJnjjwVkSF3LPqa0XlV0S2Ay0PqUvYy1stHDO?=
 =?us-ascii?Q?jeHUvw0gw1ZuVvUnlKtKHuewbkwstt+C/Am9W57t9MAq0Oe2Za3KWHkO9WQF?=
 =?us-ascii?Q?f3OOLby3SRgM+LpZsmqA5nb8ihSyNmLWobdzborniaVsZg+TGu+8dA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9iydEiWpNnNIs7DMtCOkOcnIGwwxTFF3uvskQUJCix4tx0GQY2X66cQWO25K?=
 =?us-ascii?Q?rglGNdoTK+3ie0LimKdHoZKAo/OpP4xXnT0NYrwA1ns5w6w+//rRhFv9eSkt?=
 =?us-ascii?Q?vxa45nNq2K/L/Bg7A92TMR4G0pj2t8pODxEPAeq1kOfE/JrRdZhB/Vxz0uzo?=
 =?us-ascii?Q?CC2BO4f4Ged2FgJK4pUMj58JCMa8gaQXtkENrV+edLT9OKjuQRrt19CxyoJH?=
 =?us-ascii?Q?IoHkhOLAoq9a1ZXw9R2cdJynPe2pP6FZjbwqxAqtnk8MgdNKR/UK+SOXpjlA?=
 =?us-ascii?Q?e7KYGJjLr4AWM6tFar1RywVYbdn/R6LeF8CaTs9X5XIh310MXmDEksTj/h0m?=
 =?us-ascii?Q?jyaYFLis5D/3lOoCV0msb0TQniNVn5TApL8icocaB213OtPNyVUX+FAl80rd?=
 =?us-ascii?Q?8y10aejJvm5Hq8NHJ55RqVoHP55G4BVgGoFR6bgbH5eTvcrR2lXC5iOxnRuX?=
 =?us-ascii?Q?30F4EzLi0GgLnwJvOX7S7DzF47k9sBQRK7qExfTWKJHLoxfUQGPw2ozS0sv7?=
 =?us-ascii?Q?omVEIVK5ALs2iNNEelLtwLO5nS0W2UAYBPwHrcKMSR6VuGe3KVHz4jt0GAtJ?=
 =?us-ascii?Q?lB7pev/mjMrkpdjc2I2YAhv4F3iEsCcmjliu0YC4vYjtevf3AbzVkee3v25n?=
 =?us-ascii?Q?HDMM8UK7C9BNtYnycCptc3J+rlXKbb3HaKd3dCAWy9WIjE03jESLdmPiEz91?=
 =?us-ascii?Q?mbfFY64+MXdmpgkE9UCoqb2f+xUf81hgKLUxyF0iOcyhNdQSUo0iReHXxwxS?=
 =?us-ascii?Q?HesuMwFW/AEQl3XXl8BiDV/tINuu8YP9ylp16ZKl6u1GbtYo4aWekyOmPpG8?=
 =?us-ascii?Q?K4+OOcNPEusLkrQcz1lSgeP/jPBHlp/O7VnM8vfbh/oHe5hqZhUNrVsfiI2U?=
 =?us-ascii?Q?3/h9ZlUYzaApyyI3IjMP1xdJUGWZ5IaKW7QpGqxUdHP80mdplbYMQ6W56F+2?=
 =?us-ascii?Q?/5raXJvvZGLXatZaUh31amj9foHH9mt1lns7B3M/y06lUOB1aFh3ZCBWtHKo?=
 =?us-ascii?Q?4ZupzWCrucFFKKDgpXZcSuZk0V/poDOPeNrOjU7YtR/GzTZe0Zs3ANMEkmTQ?=
 =?us-ascii?Q?CmJ6+HH8q6JByhNsvilPhMO+eSu5D6l5T5J3uCtEeQjWbVs+RKINPDDFkQaG?=
 =?us-ascii?Q?0JKyg2WtInlufa5GkXuy/bO6783EO+XCCp+7K3VtUMJNyxBjB0Tdnj7Vaw22?=
 =?us-ascii?Q?lklKnSe23ByW/sSzeDNUxU+gOihzzIYKL4yT9sHtbb/87oANek9WVJuhDdt+?=
 =?us-ascii?Q?ajvwGBidoq2PkStnYtaasKFA5lxHDhSBLMx5285D28yHw761Tf6Zf7vY+/HS?=
 =?us-ascii?Q?Pz3byq/2+5u3Ca8YwT6fW/ZMWuTsPfSxyVrN5+krfdco7uRgbEjy3J2U9GUM?=
 =?us-ascii?Q?Bu+jiykMvvu/o3cxECCBk84Wf6zWWL+AJ3pLpADF+crVsjm/scro4vY5GvMl?=
 =?us-ascii?Q?/GEHh2XV4XUX+xmGDdyttsSBBxlAVX4t1MDrOJQk6ePDEBSe+eZlgllS0QQu?=
 =?us-ascii?Q?RE+3kHhk/FMzu+JOiLItU28z8ce9y887yXQ491xnJTGw3N3jDsQ0P2WNEmj4?=
 =?us-ascii?Q?AXQQwgrzRWQn/R5rDiQo0ibLVaqDnmvnYn2n76sR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b230f2de-978a-4ca4-84d3-08ddf754dd56
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 08:16:41.9018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 20RgC4E9qcK3gtKSZx2rHBpZmoUUXJ7k9VwBQOj+4g5X21Ia9GWbkCwdd1kT7wCxICWgWfO/cTj671yaubiSdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5796
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, September 18, 2025 4:02 AM
>=20
> If something holds a refcount then it is at risk of UAFing. For abort
> paths we expect the caller to never share the object with a parallel
> thread and to clean up any refcounts it obtained on its own.
>=20
> Add the missing dec inside iommufd_hwpt_paging_alloc()during error
> unwind
> by making iommufd_hw_pagetable_attach/detach() proper pairs.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

