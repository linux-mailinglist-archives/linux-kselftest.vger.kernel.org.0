Return-Path: <linux-kselftest+bounces-4329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255E184DB97
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 09:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5821C24472
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 08:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23496A348;
	Thu,  8 Feb 2024 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdBkzpXG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89EF6A354;
	Thu,  8 Feb 2024 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381631; cv=fail; b=uiKoWORRyR3d9jJst3nbM7ntEohc0Z3/8kJb9XRlFlu4uK2vj9poYIqNlTJ+D8vojcOghBNRckjBY2/wrU3RGSJEnx/E+SpQUp2nYRCG+uXX0Gvf1DfQZ6e8V1tmlii39WYjpsROWpSu8bJX9DRUvaKFjRMEcIcrEWIWgmFaxbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381631; c=relaxed/simple;
	bh=Ag+p2Za1s3BIqdowKT38MFGe0WN9H0fULs89LYv4Ft8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U2sCtsYyBs48YKAoPPDzyZDYghuIRSn9PsyYnAkChAAYnMtBqr+PYAuhgirPJe/0l/8YtDHNPBbq2+EvqvyZTYoyWKxSF8m20W8SeYAPnciTz4vcZlqVDhEqTQGz54o6HZiUv8njzxYvgaNT/of37N75mEJMKi9M5lwaRGZRrpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdBkzpXG; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707381630; x=1738917630;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ag+p2Za1s3BIqdowKT38MFGe0WN9H0fULs89LYv4Ft8=;
  b=kdBkzpXGQkWVxDsyoy+/ianAKpFCfjIQ0j2dZdL4MFuGvq4ZUMni39f6
   Y/w0lqDxTBhuR6Lu65DrQQjEYSFWlHquFNoPVfA1V76iEoFQARBwWVjqR
   1Tl/RDbsX8e9dSZuBDJnODemERU74uKP9zTj7wejgN10HevKGKn5Y6W/c
   f3JwEAhhM/LtjIwmKFFBcbFMokwgo/AjfSbaVfb6NPMPwsUZZScNvyqY5
   vstlJiMKEQS7+7Q0nkiY8yRIAx6VsdIZiMD+7bBRZltVjhqZOwOx0rE3b
   +Dlitdaxj+xCmBQ+jKMEsJHOZvtFRN+9gXtTxIZGEXqEfC4e73ySr6SAE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11908989"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="11908989"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:40:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1914217"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 00:40:29 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 00:40:28 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 00:40:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 00:40:27 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 00:40:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erb7FIkbCoQNpLzWcS48yekfMdBPPCWcHd29BGAQqhJskY8RFA+y3Uw+w4EhPe4WNJ8/IfTL9itHhwF4ZoIYAgtjZNRdwcjs0oO0pMD6IO9X5LOYG7ErcBXO9NGizWlBJ7zad8oeRe/emjJDxM3wv3hjYhUUuS7La0El0FPoI5a7SC6ohqx/dOVrIBiO3SHqYgv3Db8ON7oCUb/Fjc/Rk0mn3HRwAScDNgn2UyI5Rsa8qekXQspMWu+HNJrHir5rSR6lCjaObuqkER+Eylbx/oAD2j9m5CJQauibj54vf+eYyRCym0sGXiSj/dsQPZGFLtfNjPwY+kZSSwBmjc9bwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ag+p2Za1s3BIqdowKT38MFGe0WN9H0fULs89LYv4Ft8=;
 b=T2j6oSRAzNcx1SRadfBO/zPyEHlQ4izEH48QkKM6SHydYFZokDf11Qnhyaum7Wpu1V7+Clg0CWHFb+YA6LVZwsCDpUdvapCpEqQaY2iV/BBiLJNrXBh8dLFAYtNSDkTi2FFX+JkA/9hLIvf3YJ9fxKqsO6ClC+McAqW411lGAmTnFPCXOpIf8SUYyJHj2SH6fuG4LIFvf0D3LKbVVHpuC49V5YlP8vdMSkwOY6H1duCwS/SZzywKMWNzjaaU31IYmLRVNnuC3MbxdKPOZffI599SxOgnKS+J69pLTMAvRmf4Cd5VI7hMGTNIsaygl0X7HxI8xvasXmS0nNx1pk80Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8255.namprd11.prod.outlook.com (2603:10b6:806:252::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Thu, 8 Feb
 2024 08:40:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 08:40:26 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>
Subject: RE: [PATCH rc 4/8] iommu/vt-d: Update iotlb in nested domain attach
Thread-Topic: [PATCH rc 4/8] iommu/vt-d: Update iotlb in nested domain attach
Thread-Index: AQHaWmgT0mMYrFa3uE64U/MqCrwpi7EAIAkw
Date: Thu, 8 Feb 2024 08:40:26 +0000
Message-ID: <BN9PR11MB5276A9FA70F207CC454E6AA18C442@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240208082307.15759-1-yi.l.liu@intel.com>
 <20240208082307.15759-5-yi.l.liu@intel.com>
In-Reply-To: <20240208082307.15759-5-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8255:EE_
x-ms-office365-filtering-correlation-id: 4ac1dcbb-665a-4856-fabc-08dc288198e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T/6MVO7vZo+K3qC+cyOJBk0XNYOAtbJ/ZzHLhmtOoPegZPYELrfcCoJfgoV0ZpoM4S/0Y4Aq2vQxufvMXW2resyp4e3drtN7OBLCcjzhi0MzrucxorJ7v6ojr0PWXgdLaIdsZ1+DIJNCr/e75MWuVRQL/WuU8ia+yMUjc9f9imJDDPUce1bErLzKYR4eUhh31o3oy4YrLm1etume2qBOeKbSaTNACgFCJqSZhsGf+Qhi7rg3KYIaoPr2y74CIuVYalsPKAYa9qwFyeTAwniKDoar56NUyhcmWaDmX+k9guCGqZAbntXCyEYDk7WCAyGXKiwLFNk9pM8c9avF8OxddtVkjIgEakYCoS3kuLCICsaT8XeimHRBZa6ME1gbyFXKvlWsyIs8139GKBXV7CNzprgHKWoSuPmg+IfSEN/bJ2jzTsrX3kFM2wjgUNTlsrbtIXUYIcEdKADOQQjqvmihsLAOO43DPiC1es4c+XMHa8fPRK5XudFcTB7DgKXR3H2I7+h7h3zHTntgjKz8g/QzSrk5JiZcl6SEeLkTaLv5zI6ddJUPAGKoDAwoQKMVyDoxle2HDhh2hBDhC15LBSwSsWBjb8vTe60LjJeaSxoeet5zsYOJBYW1A/YOfLOBnOrf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(136003)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(15650500001)(2906002)(55016003)(4744005)(52536014)(5660300002)(8936002)(8676002)(4326008)(7416002)(41300700001)(82960400001)(83380400001)(86362001)(38070700009)(26005)(76116006)(66446008)(64756008)(66946007)(66556008)(66476007)(110136005)(7696005)(6506007)(71200400001)(38100700002)(122000001)(316002)(54906003)(478600001)(9686003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?toI0UhBnTbZHn4LpXY8BLIsKWiiqH0BEwmp/k6lXlMpnrexzE8rL6C4Pv0WG?=
 =?us-ascii?Q?ph+Ai5E32EBOC7sqWDRNu+OvF2TEjkL5/ZKiYCwAyx9LrQMcIWVjum8mlf5d?=
 =?us-ascii?Q?eo/t+Y2rRrMo4bpiBNKwCpA7916q0owj7CB08tWu99ZozZKukQaNJH+1SCDx?=
 =?us-ascii?Q?zxTonl1yO0dYTcoWip8HEmG/K2lyDkWZb0Q1k29lyqvBseTk4fZC4ub8zINp?=
 =?us-ascii?Q?ifvA6rIq3ooj+SAkTav2JvOvBxoFaglgVJW2XyZ0A801W/gCv58jMYW45HIm?=
 =?us-ascii?Q?8WVqyJbHk9m5S1wthe8CIx8/t49lbkVn86yIqM5KHv6pQisQkV93oC6bOppC?=
 =?us-ascii?Q?LHKSQKpd1IsB+/4aZge0xwC9Pq/JpxEM0zPHaZXYkcgzFkrXCDFgGcGUQbc+?=
 =?us-ascii?Q?gZFe985BXjZeO8jzvmF6wDhC2ByMOxA9AvLqrdfCc0c/yimgDUvvkahGTknJ?=
 =?us-ascii?Q?uv2qVThclNHhiCmdTdIOU2eOVQBjynMouP6GKFcXzcbkcfnKi7kI/9bwjH3j?=
 =?us-ascii?Q?AtbCrs58OBsq/zM7Y7hBVztKrbjhYMZ6NiWeeH1ouSWzPHwNekyDPWOmSk00?=
 =?us-ascii?Q?rH14csthMBhCwIydvIbupaDh/6ZDnIxyTrOThm0Iyv10tDQO9THjZ3vEqt8y?=
 =?us-ascii?Q?N7os5VVqufZHcU0Td1UKsd+7fGVHo0cwKpTX835SSIgg7LOt1PJy2BxqJM1H?=
 =?us-ascii?Q?3INGiLeL4X2mGpSWTL8xJo8fLilQA23HNiOL9grS/un25TVHDMt2DgnkS4oZ?=
 =?us-ascii?Q?RdqbkfS28GespES/QNbDWqSjd9Qmm1INXiJdQdVwJ6966M4ZjNe+AMpIwXCc?=
 =?us-ascii?Q?5cD4X03Z1d/UD8b0qNfVma1EvLJgA+NaWKBQxuAj3lvTpLtJwHf76Bw15E8q?=
 =?us-ascii?Q?t96jllLUhHScYP7kCxdmiYJta3TsebgPBE46XpoiqbCPSg6o2fenO11tZOlZ?=
 =?us-ascii?Q?8zm1/Mff20cmypp/ndzp/nWh1IH2nU06AGcS4J3PLZU2BR5hzxjeXakg5CNG?=
 =?us-ascii?Q?lkudGxrIJnnhD2tdE7ePZlyITEWWDrc8GaSawJVa+3qjvG1XkSg1yj2MWW2J?=
 =?us-ascii?Q?feYiIk7jozKmL/MGguhOehZuu53J8HKmqUDxW4a88M4kxjYioG3SajcJxO+s?=
 =?us-ascii?Q?5YZerB5VrPGoRwDGZX9j9wuKKkKAIKKCbb1ky6cCQZo7rx7M0p//nN47X130?=
 =?us-ascii?Q?hmNq2V0Y7tagOSeIOsRzucfb8DEOfV7Drb4PrPHH1J9SUOtV1Sx+hC5+Ud7n?=
 =?us-ascii?Q?tn4jtLM2Swj3a3fz8jjKAPCDFoV8UXVO+AgI2Y8mwBG8CH8LfyudKEB6pnjE?=
 =?us-ascii?Q?Ra7DnUmZem7HqyJoqSmJA3WCe3X3mLuxiCGbHGGRshHHS1BuFrrLvi3Ns7jP?=
 =?us-ascii?Q?Adao3nlzQIY4h4fULyIM2B7gnZ/LavcL6Q5IyEZdz48JuZxZdwbrWP5le69e?=
 =?us-ascii?Q?1UoE9SLFj8NIjt+9vp+S64Bh+KUMQEk+vXzJDfrPis3Dz8vSgHK5cprvD7Bo?=
 =?us-ascii?Q?ONzOWjuyKslMCIiJeh/nFerSGRi/bQo+rJUOrwKTlqzD3Wwthsso1tqtucdZ?=
 =?us-ascii?Q?BSfJkZqaf0skI+c690S/Yjv2tUtcUCt9DlQrM2AQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac1dcbb-665a-4856-fabc-08dc288198e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 08:40:26.0426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ii5CmUgABVCUowWo9FUaCTggsvMQC6bHut7JFwPWM+FE57iQMmJd/j26rleH9xqjPr2a/MrSJyPu9+FbYloxQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8255
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, February 8, 2024 4:23 PM
>=20
> Should call domain_update_iotlb() to update the has_iotlb_device flag
> of the domain after attaching device to nested domain. Without it, this
> flag is not set properly and would result in missing device TLB flush.
>=20
> Fixes: 9838f2bb6b6b ("iommu/vt-d: Set the nested domain to a device")
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

