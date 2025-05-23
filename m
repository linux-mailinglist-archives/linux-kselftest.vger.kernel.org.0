Return-Path: <linux-kselftest+bounces-33617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B6DAC1E34
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 10:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90FB51BA6F9D
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 08:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFED289364;
	Fri, 23 May 2025 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gJo00Kqw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051C2284B5A;
	Fri, 23 May 2025 08:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747987475; cv=fail; b=M+OMerIx2rjVQC5CoJKZdNfuWmoEz0FBRsP8fgmrMJF/1c1TCMIHHUuN5unqVXuqaFN6+BEJbOWDzYN5iVCTLz1+JHvZJUMCdAJSeFdGnOKu7LKmXPGhCdWvy4fFiK9xvO5wE6fXE7AgAoffOedvaDdEN5sFxe+mrsAgP3XZ4aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747987475; c=relaxed/simple;
	bh=O/GH8Ndw5NAFd3GjdvFiWtqVZxPpeyT8lIc5FGF/xRU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ey5Pl3PpjEAtP+AclGcdyfjsvLgK9l+JigSGdOMtIm2Nier5DBiRlbthEUqmvpuM2NxqXHQgFuI8ceQc4YXHbWHs/h2eIaieWiyUFzldDNMqw5j6pR+RgM7hhyte0lKSML8EqGMPv4vxIPTf8Ts2juJmrRwQANh4yi7f3SJQ9dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gJo00Kqw; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747987474; x=1779523474;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O/GH8Ndw5NAFd3GjdvFiWtqVZxPpeyT8lIc5FGF/xRU=;
  b=gJo00KqwArrROCyg9dcbuD5KQH0UZwjAMJ4E/9HeXx4qnZqNbuVcPa1y
   gy42WkfrIARrX2QhWt4w/CaaUIR+4NyOFqTE+dRsoLb8N7bhwcbV29g2y
   Tcr+ywzSkHGgzLrRLnIlUQVtxac29sJAq8XL14RHCgceSGWRkKQZBz5ZN
   L9NO7MzrMzO/kfG76lmbJ/3VnMywVgVJbnY5t4kJSGRTLYVlP+xM0q0hT
   4mK38D4SD4g7ASKK5t+Ho/PWm8ugIWKyudpAChy9XVmDbwMHErG1hiFZ6
   RAzJ0mKhvrYNSXMKe+S54Do4ku7aAyX/ooplJJ0kQ0bfQvVB6iDRUa4xy
   g==;
X-CSE-ConnectionGUID: N3dexVe9TlKS6PBqph/4og==
X-CSE-MsgGUID: I9y4exHHRAiVIwMlOT2dHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="50027616"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="50027616"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 01:04:28 -0700
X-CSE-ConnectionGUID: PhDI0rSaSYeidVM6J2tkvw==
X-CSE-MsgGUID: 7uSmqgWYT5mi3VgWjwOwaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="140911181"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 01:04:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 May 2025 01:04:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 23 May 2025 01:04:23 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.84)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 23 May 2025 01:04:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvimDIeaVHrCtDFWXNGbQ5ibuYKIflXzXnF1sD9VEnHdE0V89ek3Nw8jN62dX/RBDuUcTkWfAsb+XNt6mMJv0up5O1BcrbCvd+GNXCc7I6uA5QfSZiPoa26d2l2LNjm+4f5dyMGjPXCI4p2mtZCizVu7ocC0nyuHF7ISLWPbwqE7TMlJiKATRCeeTSxY24TWdsUlPynu8D3Z+INgR6024O6tve5d0P+W/3bmqWsqp7uf6qZMhCVh3Kn22GKV20VaNivFFbDs5zHVKfM1LtT+AdG2VdXMSF5SyyNO1IjOvvD+E2wREfnK9tI0htA3TnjC/zYmIMQTzOaHPAf9JXEi1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cPhP47s/3xn2d/tcEE42DHaLla/d5TRhMi9XMefFiw=;
 b=nOMUhuRLW/ERefkTH6VwjAcutJzoHgN3w3QNopqirV9DCZa19MD3apowvfhjhj140pEBPYkA5T6ry8ov6vk8upSUCwF+FPApYjGsqYgwIPNkyQcjMRZrukYjWbONRwUr+yhVbX7kfVF/1jhE9DyLwVDCpOio399ErfID5jZb77NfW4ypZ/Unnwb7pPWcYTqvniREs+5PBii0Zbg8ZzVHDn6pbPDOW2tETUT3AOkj29pr5wP6CaCmjveInH8/Bxiviy8MZaZse03Xkb6IHDniDo6dLRZXxXzd5qroVqUq6xCYoptTiap/BKU1EdVT7p+tg/Y9bB2heYMCqLFbXyv1+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB4896.namprd11.prod.outlook.com (2603:10b6:a03:2dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Fri, 23 May
 2025 08:04:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 08:04:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>
CC: "bagasdotme@gmail.com" <bagasdotme@gmail.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "vdumpa@nvidia.com"
	<vdumpa@nvidia.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "jsnitsel@redhat.com"
	<jsnitsel@redhat.com>, "nathan@kernel.org" <nathan@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "mshavit@google.com" <mshavit@google.com>,
	"praan@google.com" <praan@google.com>, "zhangzekun11@huawei.com"
	<zhangzekun11@huawei.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v5 20/29] iommu: Allow an input type in hw_info op
Thread-Topic: [PATCH v5 20/29] iommu: Allow an input type in hw_info op
Thread-Index: AQHbx6QpdqKkE0Ig8kGR3G1GrIWMfLPf4zEQ
Date: Fri, 23 May 2025 08:04:17 +0000
Message-ID: <BN9PR11MB527693D9F175417C244C1B748C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <d75b14f77997836603650bb12437ccaf50afd2a6.1747537752.git.nicolinc@nvidia.com>
In-Reply-To: <d75b14f77997836603650bb12437ccaf50afd2a6.1747537752.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB4896:EE_
x-ms-office365-filtering-correlation-id: b3ca39ad-abb5-4260-6a19-08dd99d06aae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?/ealDyZ36wF2qUAni+3eUPD3C/vfAkbndjqX7k3d61jkEPxgP9dhn17Zga1V?=
 =?us-ascii?Q?kIC2jaeRIM00b1ziYDfpPTksfBT/gIjlwHbHBkBXGD3wdaptZbYgZXpil9yh?=
 =?us-ascii?Q?ny6zF4HS0zW1bGN3wZS8Ylo+2xUTqENlU1sRCak7hum4a5tKV3/+R+RPKjWt?=
 =?us-ascii?Q?ccc7HzsztG46eODOdxR9HAjt1LPSLXRv9DKUwRt/TP3yiILlnQfOI5Bm+wN9?=
 =?us-ascii?Q?tyMlpHpHK8UvvI8Pl7PDo8jNdh5USHpo7fSZbMpR1oc/kmiQ7lvDj0qE/Xts?=
 =?us-ascii?Q?UlRjyvpFZmSZWtsHI4rNXgKFqiX46N28fM8PMoNZXa9NfEi1Z+IjbR/do/Jx?=
 =?us-ascii?Q?BboOBF1dEV6eorkPTJGbMJ8V+512Ivzzd/oxAvJrXd53E9XpjxujogyZLchI?=
 =?us-ascii?Q?FYmh6x7KjwjmftFZnXukMxallTFoV5L7XDUsGJH8t+yui2TPbmn96Q9xU2hw?=
 =?us-ascii?Q?FcreVPw6t84MO7QbmWNVKfZVSoxuEPhczeFJ5aRznvuULDc0FK5LUN0Oa4Jg?=
 =?us-ascii?Q?OVAUDCwVuxNhTcycJzBnqfuac5VdRjnQ6HXvRcRvSiaXW/GkuMFRp5goNBNs?=
 =?us-ascii?Q?inRYerKEZ2oWVTzyLR9uLHuDhdlmy0i0u9l8H0kLN8/pROBT3WgnD05c4kHU?=
 =?us-ascii?Q?r/kgnyaBxxLfRtuhBXNntwhM9rZQDBQ9WJrgnJS3ug50/+OX7E5aNFI0C/ea?=
 =?us-ascii?Q?Bll7VFiNqNu7cy9wtStDO2fBp2wA6rM2zGeigFqRD509yRqnLk5qxRY7EPvO?=
 =?us-ascii?Q?FZPhPEJ2CvYIYzgBw495Hoh+ag26u6tNqQPxUoBqlNMrj1jSbjuGYXtc3q3v?=
 =?us-ascii?Q?ICIU958xXmb0TmYSoYjWb28NmPuTDmIFRWOCmiZSfNiMdsMMV6woWB5VxIlJ?=
 =?us-ascii?Q?5AlAoBQ5qYaLlnpNB3GHWi5SesNTtRlDK8ji5ni1s1SejMzDfSdl10KNcxxo?=
 =?us-ascii?Q?2gV9oaYPlWYXpXrQo1W3vhriTyJhNZiGZbJ2fcxFQr6S19SiAO4zVdsXeEXc?=
 =?us-ascii?Q?9Yo7R/X79veEHn56ZItpXEh6tHtXmrL6QV3s29QS2RFwxr+b/d4UEY9hPimx?=
 =?us-ascii?Q?xWObZkXb2uw6NXC76KQ5ac9sWN+yoVBMmhTD/XBdyH0zN3hlwd5AwkAFdjME?=
 =?us-ascii?Q?OvSJVsgNfIb2qAAFUGXBmCqJbkcnaGw4MLBz5TLd5k9me4VS7NrnH/iG0MFF?=
 =?us-ascii?Q?pwAgYSIeh8tvteGog9XXAae4P51JaiSjldj/FOW2daJmK16T1jz3JO8I1y/x?=
 =?us-ascii?Q?tmZZLxZ5kmYeCWImPVMdeoTP8hCdwsjMiE9pBs+xAnHeAUZC1l5wBMZFsGWi?=
 =?us-ascii?Q?sMyATmHVn0gTJXigKUQc/LNYDQmvdI38xbPxN+ODh/oyoDw0WFMUmxIFUFpI?=
 =?us-ascii?Q?TC76JRFUyqNCcnhFIhI/Ico709ihn05UqGyPFqUAuBrU0m15RmaKkj6it9oL?=
 =?us-ascii?Q?QTj9IsEwP/jW5XH9LgchWjkl39+RTqgFT30BLdf27LW33OX2Z+zT/g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r3J1QEuOFcjY1lmVf+K+9s6CJhvcKGT6YDsSMQwDVWCV2E6m2e9lCmmI8UrP?=
 =?us-ascii?Q?SI49wrGRuq+MIMk8MtTC5uCG3idqI811IyWsy/U4WHDB0XLUkJtHFSPXZLp8?=
 =?us-ascii?Q?nEF26Pl+WCOk7aaf9fyyli6O385XtP3u3M+WhkiGy8xkYO4YSnEi0yKfeeSe?=
 =?us-ascii?Q?DLRCO8wTy+53Hm21pIvTg4Vy757mqDlIErH9MscQM+s0h4bEXPvGOYU77Mmq?=
 =?us-ascii?Q?suX1XGq6Jmp06QnS6Wg02T6oUJmPRz7/ehCK7ZwlQ4UH7XefIKvNvwJqCLHz?=
 =?us-ascii?Q?CWOhA5buJd+GUsYGojl7gYbewK9krPPSEUwv1IN/zWPMwDF8nra8JD2Hh3Go?=
 =?us-ascii?Q?TPXo6Gx2MzhkYqUaAYa13leB6tF7/5L5XKbEPRTbQ5ytb1WXy3cPpw4wSmvw?=
 =?us-ascii?Q?RX6o6GEThInlElBcY/s+4yxtgDzLIXJYGazsh0VbnLCkyTZb/SYjztI43oBK?=
 =?us-ascii?Q?6SZuFzNMJvEt8jY6wxRumJylbupqkY+UHBedzjXTmWl8oHSfsnIo2yy5AYo4?=
 =?us-ascii?Q?T7E/c/aJbPqUTREb66qtkqtEY1ITsrZW27bhzIwQeOsManrguSmMgkaG0SaP?=
 =?us-ascii?Q?cerLfvTXSu6cwiKg9i9SVGzPEp+hejRZMBeMEnPdYkH2IkzklB32c45DVMMe?=
 =?us-ascii?Q?M+X+ghL/foj/88TUNx3xLAtjW7V4RHwD+DNMABew2WhPgVpwrpbxRKY8aBGC?=
 =?us-ascii?Q?YOjMxJAYNOEU0N+rb1vXymNviSfrQ6U8AuY0lQgmO5VBcp4EVeMwB5yEwBd+?=
 =?us-ascii?Q?J5lhSpSjWYeeQ4Qq/9fjD/IerlXnAspzOJvkStuFuHJKGmi0MY4XUnzUahaY?=
 =?us-ascii?Q?gGEutSWTogMG4+lvJVnrQ6pj8MOLeCtcgSqbN42h/IouoZqQQ8gqBUwZmI9i?=
 =?us-ascii?Q?jp1JRrjygf4B3y+qm36MzfbOL7XwZDInV68cc7eh8SHEprAZGmDYE0gzJL+R?=
 =?us-ascii?Q?ogkNdD6wOhGQ0yyr2qfULgNzDCx7AwuLApdOokzxk5R4qbTQ0/Y/P1mQg84v?=
 =?us-ascii?Q?88xxcf3q5hweBkfPvH4YTCo97ligLW2E1FR/BJ6LhpNgc5lGrcc8x1H1qJgm?=
 =?us-ascii?Q?ZrWjF87pXGvRk5yvnc07kiJTsoe/0Me/+QV/gnVX1NoWtm3nw7jvn1u5It/x?=
 =?us-ascii?Q?n+TQQCrNUPJjaqriXGKdOX1kuQYp0iMgXd755D6wfRC6TlO3nkAr1cLzhJyV?=
 =?us-ascii?Q?RU7ydTykuRjFsTHQbHrtkcyJji5kA2QAbgo577+mfrm4l5v/bTi6k+zVPV+l?=
 =?us-ascii?Q?toQyhdPhMAGhU9ksQm4PuBTAr8vN6q/cfF5BGpPExEN39oy8mGTJSf2q5wij?=
 =?us-ascii?Q?Rxf1wPwz48OLgS/FQmMq+UPuCyK70xSSLXg4tcJBoldHsBqLtODqQStT7fJA?=
 =?us-ascii?Q?aDszs/enB9dMocTxQ9x0N8CV/r+3cE0+xxOtOQeFTDTZNbAjtoa17OtYUWv2?=
 =?us-ascii?Q?yMqA9ExUFrRoT0HycIuAqcYrMCSiVNUxd+2XEJBv3cB2YMYlfYod2jUgTI05?=
 =?us-ascii?Q?B1d2S4C4Y9R5fGKf/IXQS+/TjIGQpWWC3xQ8pe1plAwyj9cBG9/q+YtTipBX?=
 =?us-ascii?Q?vKOs9LBjhN7dMEEgSUoRRvRJK+sh6qT0Ims0C5oo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ca39ad-abb5-4260-6a19-08dd99d06aae
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 08:04:17.8306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TxEG6reZufDMClysGitnmn3ODuq76+B4xYrU9S1UEbTDx+/NbqPHU/Qcuf23gzwklZFaoZnebQEkR/Wvb1cV0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4896
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Sunday, May 18, 2025 11:22 AM
>=20
> The hw_info uAPI will support a bidirectional data_type field that can be
> used as an input field for user space to request for a specific info data=
.
>=20
> To prepare for the uAPI update, change the iommu layer first:
>  - Add a new IOMMU_HW_INFO_TYPE_DEFAULT as an input, for which driver
> can
>    output its only (or firstly) supported type
>  - Update the kdoc accordingly
>  - Roll out the type validation in the existing drivers
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

