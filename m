Return-Path: <linux-kselftest+bounces-18568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D784E989B1E
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 09:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E228282325
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 07:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A719414386D;
	Mon, 30 Sep 2024 07:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UscbCJS4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ACD1547DE
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 07:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727680511; cv=fail; b=fDeUXx9Q/Kue8QDDTmLCZk+0liokQt/H1SPy0hODQNzaDNlEpNd/DFTFDyJiKR380Oty29sgOOQyhEK5mi5aKQYY2Xfv5dvEMekgIBdfj665+4AxgwynZdQSIoVI+ensa0B7+gC+U420+xpic/QfULqeGBWvlzQFKNyQgf4mbZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727680511; c=relaxed/simple;
	bh=l5K+IfvokKLjNfB0zeTvxfuZTrhAhPAh9C8xbWwlpR0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dRbFQD5GjH0XagbwRUoEnDK11jZAztjNHQCxJWIYZDPXDJ45Ac7ddopz1lKjioAHEW8YniJJm/9pT3Ya+qC0jeOUXINL2YEpjDN9p/dW23yZK62KwVsbKq1UkT1sbaXQY+4kxm/xllrXhAhtIJfZH06qAGKzGZxLIZKSN6PkYMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UscbCJS4; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727680510; x=1759216510;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l5K+IfvokKLjNfB0zeTvxfuZTrhAhPAh9C8xbWwlpR0=;
  b=UscbCJS4wGQ6bwrkb0eKcn1W0NRTg/XfYMBwcKwKx+8kkHP2hL8Y90aJ
   HcbLzAJYmZ10bhe34SL7CW9QGvLYh8pjVzZJVqTQyx7AIIjqWwl30Ka7q
   1NsTCNHJjyLE+fVdWertuRnoNP5qhRlTEa31TgGJPdUBOuYFLWVYJJ7Er
   NAw16rIA41jQ13Te0lZvbYPOb2pfpeAUViKu80zG/Em3F8kqvdu0NbNCc
   4guwx/Cxb2yCCqSyEClQyqSH/qlYjVXs/Z/2Dvfu5zziUQbauYPbn4NPx
   mcqO9jd1eU9nK9fGxbFiGJTz/7LhxvuCIYjWhz24ga0XuPif8bepb3ThZ
   A==;
X-CSE-ConnectionGUID: i0k7FuXYRhyRwbQoqyotcA==
X-CSE-MsgGUID: prQL8mUSSIalxlSWJCMVQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="37313446"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="37313446"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 00:15:10 -0700
X-CSE-ConnectionGUID: p7jNwy4cSbeZdL7t+d1VHw==
X-CSE-MsgGUID: IXstsftdS0CU4/lx/m6aww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="73514899"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 00:15:09 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 00:15:08 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 00:15:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 00:15:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 00:15:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgqFiJHlcYzU5zykPoQmZWYQ6vEwLgwsWJrKeyqUZQupk6i3wt6Fd0gXfwpN38SxohxmpjTcnbNsul40zzEUIDuavhE9WOyNv5Sr2yjJf+z9FMWhG8TDTb0vK+HBuvW6OGoUzfJxZouY29cBtiwPasYa68OYx9326dH6JXQE8unnDKYD+UDFp5W5565/pJHpKpwOLnpghkJyuOluHPLpocxXTkYq8Pu/wFLPl8OATSLziIrjuRyMC6bUmBP1yuSiLRO3k+zhxt5IYFzOpmZorG8aDxHjz83obiVkDF6Sn/kpgJNUXJUlbaeCCte0VjVnvEiE7U9/JOaLE89Tk1h2kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5K+IfvokKLjNfB0zeTvxfuZTrhAhPAh9C8xbWwlpR0=;
 b=TNd5ng8BRWcsMgXaAbz1+u8D+ZygOfaGWMA4MBkzzzKrwKrcWs+RPuooKSj5AspTg3UK4fJ34rDWDsfTULiPLqDP6YFt0nBOdmVca32ZGTYdP16HwMX0rrDV7z1GCWm0Z0n9enqWWh+TRjr8jOd/zDNRKoKWeeJL468IptLR8+39aeyZCyOy1fJIGPD2tpPRIDFv6+nvz70iAKGDmXRLB/TySttUML0lry4/Ykp1YWGhaLsVSCg8xIWsn8jmP9iWOlXO1pxWbnyz1au8XzDnGMnbMHrQQmbgXEp4T0wRsTMPgktCclJ34qsRk6PooMzWz94KHjF1yzFn2c3E039Ung==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB8227.namprd11.prod.outlook.com (2603:10b6:8:184::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 07:15:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 07:15:06 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>
Subject: RE: [PATCH v2 2/6] iommu/vt-d: Move intel_drain_pasid_prq() into
 intel_pasid_tear_down_entry()
Thread-Topic: [PATCH v2 2/6] iommu/vt-d: Move intel_drain_pasid_prq() into
 intel_pasid_tear_down_entry()
Thread-Index: AQHbBRRalc4QeT/MPkicaJI9tNznZrJwBgIA
Date: Mon, 30 Sep 2024 07:15:05 +0000
Message-ID: <BN9PR11MB527605C26374C9D58A1F83138C762@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-3-yi.l.liu@intel.com>
In-Reply-To: <20240912130427.10119-3-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB8227:EE_
x-ms-office365-filtering-correlation-id: d9d3bce0-e909-4b79-6e9c-08dce11f9c31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1GqFNTpVGUPZv+0namyioVNTV6geOAFGr39RC05XqF0AsrtKLF7FCrWjzBJz?=
 =?us-ascii?Q?69giMfBmeT7STDT8vnESity2/lMK0BKMOKob+Zl1VNDIgGRUk8cSTVSRnWm+?=
 =?us-ascii?Q?WeU1ORXyJGf9V2WhEC4txzpnEsin+nGMOalIqzHGp+jeuPsBFdbvGXuxa2IU?=
 =?us-ascii?Q?Ue+7Yb73B9zSfBZ+zpFtsFkz4Cu5oCYYpx/aa78S3JiRpxtY8yvtYn0wYPvl?=
 =?us-ascii?Q?0fNoWV1PIh++V4AJsHJ3yr0MwaUrNmKepBvs1CiWcAQnasYzKafZE90432uN?=
 =?us-ascii?Q?PT4UYAldGKkOZx1Oc72gZgdMT9q3Fl9TzYaT0f2H9diLE6Zh504OnXRRye4Y?=
 =?us-ascii?Q?CcIN69WyyAYlJPwb0x6en57xnYezEWqHc92PtPNuqn3uPGSfJ+JEb6jv6Gbe?=
 =?us-ascii?Q?aLYVMLdKxBAFINj2RQOXbNC1hJY4pGotB32uj1WLEO9nzsW74M+cXSnE73vQ?=
 =?us-ascii?Q?O+EC0MqyRlhNTGSNSnaKgG8nrU5NyyLjsb5NIBnP563Rr6IQFNApBsk8m/HI?=
 =?us-ascii?Q?S4TBudZOtOq7lFcbWcaa5zrkHa6Ui5xOKX5QNNnLq1KXSg9R6QoHOyQAsNVq?=
 =?us-ascii?Q?G88kGTGoRZjPnqDZqO8WV/8OtE757vzG0l+4AZ0npJWDPdIHTJqODmZqJc55?=
 =?us-ascii?Q?Nmv+t33RrRj6MDYjEDqy63uRZSDUHiC5CbDb+iQIaTBUBxeKGTCmYdklU/8j?=
 =?us-ascii?Q?FAUWc+e9Gu8QYcq/m0B6/Q7kJC9NoanqWKGGmoA9QWIuPOGr8SwvefZfwxsT?=
 =?us-ascii?Q?1+Wu8ivvVsBIM2Td6MQlfiMQIMtr46cxB4E2v79zHcVnOsidWlayIiZUWnXT?=
 =?us-ascii?Q?rFA0uT7A0O3n4HKxIOKjKp847ibbK/l3JD40cPN+UNdUUPtoX3srHJv2jaVN?=
 =?us-ascii?Q?prv3AmSLZqiCvSLO/c+DOo/nUenTUB5rN8JBFJnqjfyC/g9snLKXRRxhgElK?=
 =?us-ascii?Q?RT/77TOPNOPMzoCch5qgDCAdyJg6Uf8H6jaxtFNLWY+iMxgQKzu/A/l88zdV?=
 =?us-ascii?Q?sPMm+/RIkKizm1Q8icAsiu8VN1WNrmo81qqZwDn8Zhca5zw7SgoWUR5ZPuXc?=
 =?us-ascii?Q?1c6Nvu1xaQSfKx+PS8fFi52govN+S4o225LFlqRz8T3gFAmE9hzkG2mI1Wgr?=
 =?us-ascii?Q?AFC52JczvZMSsyHsg9PntS6dpmmYHBpgyZG8LVhj/zf47/TqmRmK7N4zseAS?=
 =?us-ascii?Q?GrSILWBZdkQ0NCSCt5kL5zopK1xEbkp2dQGm4un9VS/EXLVQhWTWweRHl5kg?=
 =?us-ascii?Q?oLWDRGEQucnK80LYXhUFRAHXAKQJTC1TosI3IHzyidVP2V0ciF4Z4PHahbyL?=
 =?us-ascii?Q?LrqTcs6WBHSGW4C3FkYE/MmujYS/+3IhibSzUjZujKtpEUCjH94mhCdkHxbr?=
 =?us-ascii?Q?2ehWqYXyN/LK2/eb1A3VFIvWRG5TwCtTjFR2N06XZSTRXZnkQA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8yQ3Dfqpg4zIWjQXPdj4uD/nPHC86UEgE2bTmEsmeRH6buAaccHU6OPlBC4j?=
 =?us-ascii?Q?9rWzkgBfT73JrDEPqJlS7QI2E7odBT0wXvONVjB6Azf2uYgKRJIZ/dQGlspj?=
 =?us-ascii?Q?HUHR0o3CFyYqDC9t4dv7kLcav3+u6AMx76RUrkjjx4Xigfscv3dLxshZP9IL?=
 =?us-ascii?Q?Rnf9VOopFhoOJAjlNH8fpw/VZx6vyTT+EDO7LnEYtfiofG4QMKHPAZawH0R+?=
 =?us-ascii?Q?8s3XKoTesCSdc5cF1cMx4mDudKP3UqkGc4oanohd0IiAgDjZoTrxzNTyJBEA?=
 =?us-ascii?Q?ONU/fXDla0fDsfFEcbEypHrG0OGapFNxEeifq9gLvqqRCgHIoQfRSuNEnOKD?=
 =?us-ascii?Q?KjUHXDja2X7et4nwijJsRqeG6omkKO2vGrGoJX+l9GBKd0P1+GjCjlRDH0dK?=
 =?us-ascii?Q?ESPqXBuCc9DZwQmWSP7s3rebto1jKntilH2yzoMfnl5jhK4h7VkJu1uGkLE0?=
 =?us-ascii?Q?4k4bwkl3L+JSRIgMytf7LmUi3Sf2Kn/m9o/m0C3z0S1nfd0Bfj2M3l+He0R8?=
 =?us-ascii?Q?6LQOW/VgMwc5mHY303/k0xFvxMH9BiV0Q/rDCigqquhMJWXaw2IvuVMY162a?=
 =?us-ascii?Q?b3fh4v8aSuB250iTHHzr8lLIaG3PYHackIEP9hOpCEAofosol8qyGTIwTZuZ?=
 =?us-ascii?Q?Jz6umh4UlQhnq+WZc0E9LbwfbH2CFW33YhQmIsMuOt9+5TQwejUYiIVlGgLW?=
 =?us-ascii?Q?k4o2yKste83NVOlGphoXCEpbdW0eBRD+MpJQ2/KQUIk6JzDm/XkgOsRDoRGl?=
 =?us-ascii?Q?RR74z8WKKCJs6znL4cHjxwbcP15ysEjFq7pEHMFwQJRubQZffQ6feOnALwqR?=
 =?us-ascii?Q?/NawfeUhE3HeHnhMBZ+yMCfTS6klR5TPSmerJ/FtAL/CczgoA2AMQEzBLdNb?=
 =?us-ascii?Q?mJM97dg8FQaIWe6+kyR4oJ88dEX5kLI48LEhKTifBAfxc0xdyvSDJ2Q8g9H4?=
 =?us-ascii?Q?8IVBUVwMyNrTATwSFdLniEgggxA2Z0cBYyfUJzAPT88PA82YoOvxTyLECyqt?=
 =?us-ascii?Q?EnRcbSTVkgsIqHM1XE0paVI2waqMFZWyn3FXG6DmsVE2MFlkn1QQlx9DhKF+?=
 =?us-ascii?Q?JI65SzBko39H4cllY0a3txqePchLqaz58Sk3GLkn40Q8W/XiB4TbqvhYrVZI?=
 =?us-ascii?Q?wkvpwojd9xunhdtqtd5ig50H6X0Zwi527zrnEcEcpReCFW5Rs6fJxg/Tc6vW?=
 =?us-ascii?Q?d4TI/HCCXkZ1tOhO4r3OG4GiWwbjh6/L7sSnq3Pk/AaEJkF0NrrQf+djzYFh?=
 =?us-ascii?Q?XueqigPZbRYveBIh2YVye1zNK+zZTziwns8UUyx/14qg8URdyhkaXb3WsJ6e?=
 =?us-ascii?Q?6acVvcF8JVQkttv6grU4uxTTQD/zuAFwWjfzBH3ZXYcDQCXV6yXNmHT3y3Pb?=
 =?us-ascii?Q?4FeNeOH96eQucpJRvnZfz4gV0zz1zmDiNhqgsyk/Neyd9/Ntn0bnU4LrqRkZ?=
 =?us-ascii?Q?ELc80K0NzJB7BanV4T/kmaQRiadiq6lizCnaLSPxBjTwmK1l0NkWjP7W1QFq?=
 =?us-ascii?Q?IeUUDb9yLq4dYjVNKYD6knDf6Cx7tC7TWhzIAAjHj+asQwuK9Kx612j9UW/x?=
 =?us-ascii?Q?PwWiSiV/H17H6gABIWWIGTmQZx0f/pJxV6yzI4II?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d3bce0-e909-4b79-6e9c-08dce11f9c31
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 07:15:05.9919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AGL6GYP8xCKmq0bQAMlFZg9Px3XbWsBFK363dTA7JHBYnr+MZpfsnQrBBDcqeHQHBM86v4oPjrfO3qxYAcuZ9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8227
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, September 12, 2024 9:04 PM
>=20
> +/*
> + * Not all PASID entry destroy requires PRQ drain as it can be handled i=
n
> + * the remove_dev_pasid path. Caller should be clear about it and set th=
e
> + * @flags properly.
> + */

/*
 * Caller can request to drain PRQ in this helper if it hasn't done so,
 * e.g. in a path which doesn't follow remove_dev_pasid().
 */

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

