Return-Path: <linux-kselftest+bounces-45719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F39C629B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 07:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B9DE4E6C51
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 06:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06EF3164A1;
	Mon, 17 Nov 2025 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZHakJaE6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9AD314D04
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 06:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763362621; cv=fail; b=kIsNIKEwVuXD981uYoxvsz8UOXET973OgCsgx8H/6dKNeU12vBBIHSl8rL4YFNr3jbqpzCSzQuLaIWFnGt6e3WdoWwYdg2plmWX/oHgM2aiYjT+Av/xr+UqjbywimqnGMgfy8LqWTAx+CDscn8hdhWx4jRAf/4FTniNz3IJhNRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763362621; c=relaxed/simple;
	bh=G7z9+0bpTV5/ZtZLI59/igMe3hRNL1s/Kwj9B20uL+0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eyh9j2x59fXxj6d74+Kom4fwuOHzMJigBSrUfavZE6UrZn09b4x1fpHRzQIH57TvWc9BQ6WaSQ5GJbJJWy3DpGNUyzWONLexvBdTJHuDI/+mEAXi2SR+nXy81i2RELiZ2AhP4MCTx78YricqnYDZ5kowgCzQ3wGK/g6RNXfiu9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZHakJaE6; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763362619; x=1794898619;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G7z9+0bpTV5/ZtZLI59/igMe3hRNL1s/Kwj9B20uL+0=;
  b=ZHakJaE6yp+V1lUOf/unJB7iRcjbAt5AYMJckllbf7UtYnvUgJ5F4ZDn
   4yiYtIRd6MrBbLuNGZon5m5QbljR6o/WMVh0RRe62lip+rfRN/2jvxX5g
   9HkmT5FZOQQnTVbcZJMlk2mOyzLocK3md3NLlwnwqyUUxoGlTfVJ5FcwQ
   Y8RwQGSdcma/rr/RmdGhvJGnU6rLQpQm2iXfkmbqzzUzh64oV3q7G4pFd
   zqQyojV0GkFWba1Y8NxIUZ8c7WkvqqikIKZmZi5MlJcQh7FtxC/6nOtQA
   2KmJPAbBzHYna3oNTrmB/pnY5slpky9W87R8fqKC42V952Ke9u0LMisho
   w==;
X-CSE-ConnectionGUID: 4DUetEx/Rqik9Ss20kujYg==
X-CSE-MsgGUID: F/xM7NMfS0q8Ki+wGgDw4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="82742979"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="82742979"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2025 22:56:59 -0800
X-CSE-ConnectionGUID: KptW3E2xSDOosjsZ4Iz+rQ==
X-CSE-MsgGUID: AZmJgRe8SAKdJ+cP8wnDdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="221015823"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2025 22:56:59 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 16 Nov 2025 22:56:58 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 16 Nov 2025 22:56:58 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.62) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 16 Nov 2025 22:56:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8VXHXIFyLhaJJyJu3f9PCEHk3Le4y/cjnWBUg2m848WB6xRNgy+Xd6sA2f7JT4PujFUOA/wCo8+2krPqDjYTKUbKBGJPFqPURLEHnIXH5ht20/5HBY3z4Qwf1iB+VCH9bC6AN5aZwc+/fLs/e0D2nWxFk6hm9fn7oDyIkD3No80BOt0b5ZVDzkY+qIwlxab7Sccepid5OmFZjMwlmw530+MlYX3DoGBXCZwg4a1AsGhxT190m26QgF5jSWW6WlIOy1mP9n7yAW5MLfhvA4hG9N+IO1AXMi/zwAcYmkhkQQxCp4tMUoB97z4s7JZ0xVuCE2G7BSPqtj45M22bPfWdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8AahdwyT7DPfhXhv6JyyyUv36z+h4KD4g/TnlWxnjw=;
 b=jlOEmnsjP+iUg+NiBMjNd8S2R/B91T4gSELTRV9BMMvnpR8QH25IsG+boFEBFVEMNFL2WLWMuQAOAvG+rW5vNdAMUi+aSzTRk4VNV5cx93GNb5HAbNX0dzr8Ty+85ukVHKueJ/ePY/KQ45+ytc4m8Nn7bc1x4gi6ppXgv6uypbZ6NaYeZTKgm/0geAQpfQsTLTRZBfss/djizlBU9o3vEredzGhY4vnD/IQZ8k8Wm367nl3hkqusnFBZ8oXxGcnM4TBagjE3nrJqjyCm3V23qm7qoVKSZKi00KIaVNBWMiKMMojqEB29XhfbiImrfF+/Mb3l7Y5h28gfIm80j5ty/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Mon, 17 Nov
 2025 06:56:56 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 06:56:56 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, Will Deacon
	<will@kernel.org>
CC: Alex Mastro <amastro@fb.com>, Eric Auger <eric.auger@redhat.com>, "Lixiao
 Yang" <lixiao.yang@intel.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH iommufd] iommufd: Make vfio_compat's unmap succeed if the
 range is already empty
Thread-Topic: [PATCH iommufd] iommufd: Make vfio_compat's unmap succeed if the
 range is already empty
Thread-Index: AQHcTbaFCfF32K7inEe8+O7kS5xvbbT2gmkA
Date: Mon, 17 Nov 2025 06:56:56 +0000
Message-ID: <BN9PR11MB5276EE15198CEECC799B3B568CC9A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-76be45eff0be+5d-iommufd_unmap_compat_jgg@nvidia.com>
In-Reply-To: <0-v1-76be45eff0be+5d-iommufd_unmap_compat_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN0PR11MB6059:EE_
x-ms-office365-filtering-correlation-id: 874b7579-fb3e-4f25-270a-08de25a67f42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?yPVNYX6UW7K0B0nS4idJwhyb/l/d839dvznxc3fhne3D97v/qKReJYYo8AYj?=
 =?us-ascii?Q?IX/D8uBfazR2YmjRW8Ogk6UUFJRCXfPDys4LmS5qBJT7ajZdtTvX0gsHwsi3?=
 =?us-ascii?Q?VL/QMflI+j63vMXsK1lcTpkQ/WJ/hE4jsQUXqsyQYdNxv51IBN92g53J95zN?=
 =?us-ascii?Q?4siBVPj5CeGFdt7mnVxyLur70wg1lNLqeZdPjkDzFF9o6OynrqmnRiQhqyyr?=
 =?us-ascii?Q?c59KkUakpLDuJx9NkngUL1nNqyHXbeHceyvpCNQESvbwfJq5mgiv19bCLT5G?=
 =?us-ascii?Q?nn2m8TCuzHqGFyXMAi0A/Pni3wvaTk/D2MnsXj8xtuDuKpGDrz3gv1D7kg82?=
 =?us-ascii?Q?xCbCjeFu6u2IwAAuhAbfMyTTQ+gNnwTLLJjA5dQcUhcuJ+wf4IodXvln/D0a?=
 =?us-ascii?Q?f8uZRj+Xn9pQ4nEobvzwN/6eqflWFjL3SNvrCs/C2eCncqoZA1W+Osui+T76?=
 =?us-ascii?Q?MDc72QKU65/LOPxn3GwSG9mcAququVydGAjuB2GjdddHA6CIaP89RG3YKEsA?=
 =?us-ascii?Q?Twb6ht88UFHuicZ1XHgY7sNzeJORR8rtU7pt1DOGgsP8MkKqFzgZFdPNvAB/?=
 =?us-ascii?Q?LqcKH/iEMqwTJEq39VC0TkLLnj6C4qFYYlq4OM7j1ju2A4VDSsssJo8gbQ7z?=
 =?us-ascii?Q?m9KhywIps9lxI/yHoldaDiZAbcQU9D9Lq8+Ew+vKRT4g4GnWAggx9nofQpWx?=
 =?us-ascii?Q?n3kGy3kD75J34zCdmXlxS/mfCKLT9qpDRX2T8aEOIGbCZyXu809h17bwBIcQ?=
 =?us-ascii?Q?Xm1OK94rN/vqSI6FhHrOIKM28Yg2e1OS60OL8g16czhysR9neURPwVMvtu8e?=
 =?us-ascii?Q?W8PSlee1JjkzSSCOlqIRKcSxJ+HOnyC+I3TIMheHUzz46rX2vpL2ZMh3lMDe?=
 =?us-ascii?Q?aOqNtquAynDV8oGkcSGZxQNGH9mH1sv9Mv7IFRKrsKlRlDcAC7vJ67Mcs5B7?=
 =?us-ascii?Q?6i7n0ICE1i/GawyENM96RY5lrFZHIqRmtDuyu06wgqXe6GpEfsXJ8ZqUehLQ?=
 =?us-ascii?Q?0gBxDfADhbQJJit7fW4NS8oLF95TmAxJnaTTRag16qVkJYLwmZGrCaB3uGon?=
 =?us-ascii?Q?MOTbZS0fizyTiV0YavRyD/W5xNyHRGHwEVnmpq2mNPxYyCu9f1egKVArNNlM?=
 =?us-ascii?Q?AItSs1N12PrxijVkrvEpwXR9OHXrGKdFolOZcs/4X5fiBh/iDBAEwfGCl0ka?=
 =?us-ascii?Q?213B8FyXB39CLSoJNmSTdK8dt0A58mFH2oE4liGuED6JrF/sgzZeubEOEYur?=
 =?us-ascii?Q?TdscaUMy3Z6OU1i2fvrYeWa7wJGT1wSxOtPiLtRtRj9CmNjSBTgxobhWIrIa?=
 =?us-ascii?Q?XHF1O/kRg8We8gFDN47GIZkvqpRPoxk8PxJQA8iuiaIkrSGRJi3ZkaZfqUFV?=
 =?us-ascii?Q?qog7P6JUupEcEJo4KfADpIRz8L+gU/gwBK6apcaDxyzB84t3SXvqWqENwluo?=
 =?us-ascii?Q?HX03hvXZ/pessa/78AxBIPwuDdxh13t0vg6tCmkETqVJuPI7wSmKHB2uyqRr?=
 =?us-ascii?Q?uJmvx/MlvPfzE62eiXHE+lOTIbxIcvRgTRyL?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qKEp297bXoNVpj7amfqSQqtvbGuI7UtwYMmFR5ddtgYA4/oI9+sCsLcC2V4N?=
 =?us-ascii?Q?9YBoS5Hw2yKcztIpqGtGs7BKbJhW+fccdImpDgUGT19WVRZWCp7PKO/VS2f5?=
 =?us-ascii?Q?FpxKirBWUe9jQq9AvXdGvRLmpWM7stajpudTHkSkXkxpVUhGQLQLCvUjAEmh?=
 =?us-ascii?Q?CkB6O9SghdBLDuZoBMOCSy4HoedLDBZcWTCfxqbJGBxjhiNDNhaN061Z+7He?=
 =?us-ascii?Q?qrLsXgVmp/9CZ/qxegbbc7+HxbbaZyOiIrQNvvzhgPkn983+ujVyBTeGCu0h?=
 =?us-ascii?Q?ALf5fofwvQm8DY06LQQet/XErFANYdpdBXQnow/xLlzC4RM4DRkkfmqjCfCg?=
 =?us-ascii?Q?hJObsL7uwCNVCHRkcTuQCNoAXGx4xoGHqr4LKtEP0SnXT5bvefBY3Gz79Ss2?=
 =?us-ascii?Q?8gOtV4JSYk7UNl0r7xj3U0XIHo4fewWJevZzdR4hRG9OlVhitHpFunmZbaYT?=
 =?us-ascii?Q?L+VpnjkfVvNPYkDjr2F9QvidVSZoBTECiqgW2Mpyu6bEwvCL66NUidbSrzth?=
 =?us-ascii?Q?w/1ojsikIfDXp+g49cyNqKP9N/NTAAete1MPUvfrhMT5YzfHRMTqCD+A7FUw?=
 =?us-ascii?Q?LU+UGUCNJZ0WYJlprgAvzBkr9sdjIA+SNYUEP0xSbhV03MydYB3lj7qqxFNU?=
 =?us-ascii?Q?o2kKCPx5NP9gujlGXJNhgt804PnOEU9/BLhYPiegphmzza+SUQvcV51zvXHL?=
 =?us-ascii?Q?1jgiNDsJETzCv6tB85ZVWjGvhvfoz5etGz/T2wTNoDlbEfJBeXXwwclZtSso?=
 =?us-ascii?Q?jeDP18AVsHa+qGbshOSScEefIRcG6nZP9GUdLfLM4OAU7Zi3tGJ5pFpDCmxj?=
 =?us-ascii?Q?7FoTZmL3UpnUrYhQvX63e57+jvGTOXT3wEGySPa+I3CdEkuZqdaw2+9SOaf8?=
 =?us-ascii?Q?GYV1SCarn3LUNmvcU0wCdFRJ6nbe4tnQ5Mu96IxW5xOrefbCJMytvpjCGgVA?=
 =?us-ascii?Q?Te3IthJ58vSnqPCaBGLC7F9bIUsndmeo5A8cEsNgNOC4lpV14BGi1ZHXuDXA?=
 =?us-ascii?Q?++TP/756gWpAQf3dD1sT/twWiZkwJTkTzQ3W+/v0T4tbE8PT0pGWWNT9PYSU?=
 =?us-ascii?Q?o+dx0qY0ciMEeDgqXLErYdkn7k0eAfap2NF7B5kPjvqyuLyBE8P79XP4KnE+?=
 =?us-ascii?Q?9Hm2pTdhSqQSf7GQJmVU81wbKnVEUknr6s1HIL1hAv/60y/gK93etsdFIF3t?=
 =?us-ascii?Q?KesbjqrETbNt4YApnO97yYOO7S1cxX33nOE7s+agAToSbS8Quj3kX1yQy9AU?=
 =?us-ascii?Q?i7EVZDOaJIqsbGtV7mD/QcnzN1HV8BAwC59QxcIshI7RKuj+J9qOEbe9mwMN?=
 =?us-ascii?Q?WqVbweu42jlx4XQVsG0VkXaTzPONNBZN15ajlHJLULlGuQFx/bpz69TyMdhl?=
 =?us-ascii?Q?KyAB5FyWJH0/ouZkek5TaBIg8AXXmyrFNnlVH/14Fq1LTJ3RMHI/MPGLnuw5?=
 =?us-ascii?Q?lmEwbA2MMLNx/v7I/W06FbwKbyhWhtH5KrxzKMnw+vaoC6QQan5UVw9CqgJC?=
 =?us-ascii?Q?f7QuIQ43cYgK+jOaRKAOWoZVDVCDmFTI4L3qFzo7Zb1Da+D5EFw2GZBbUx6/?=
 =?us-ascii?Q?0A1lX0exK2G+Q3ywdYVLfWyIaT+qiJDzdcmIcKjv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 874b7579-fb3e-4f25-270a-08de25a67f42
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 06:56:56.2909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wO3GECiTDYWgGO3oYLi1Y5hi0YvrYxFT2j5JsOh/FzxVhGvxMUKYgxwTHLoLZ0O1+TqlV5nvkCwI6ST+X752Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6059
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, November 5, 2025 2:12 AM
>=20

sorry coming to this late, but why do we leave inconsistent behavior
between unmapping all vs. unmapping a range:

>  int iopt_unmap_all(struct io_pagetable *iopt, unsigned long *unmapped)
>  {
> -	int rc;
> -
> -	rc =3D iopt_unmap_iova_range(iopt, 0, ULONG_MAX, unmapped);
>  	/* If the IOVAs are empty then unmap all succeeds */
> -	if (rc =3D=3D -ENOENT)
> -		return 0;
> -	return rc;
> +	return iopt_unmap_iova_range(iopt, 0, ULONG_MAX, unmapped);
>  }

here empty IOVAs succeeds, while...

> @@ -367,6 +367,10 @@ int iommufd_ioas_unmap(struct iommufd_ucmd
> *ucmd)
>  				     &unmapped);
>  		if (rc)
>  			goto out_put;
> +		if (!unmapped) {
> +			rc =3D -ENOENT;
> +			goto out_put;
> +		}
>  	}

...here it's a failure.

from uAPI p.o.v. better the two scenarios are consistent?

