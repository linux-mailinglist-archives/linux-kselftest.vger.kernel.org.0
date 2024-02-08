Return-Path: <linux-kselftest+bounces-4327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A181C84DB6F
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 09:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2EF28BDD6
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 08:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0F05C904;
	Thu,  8 Feb 2024 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jKQrABEO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDEB1D54D;
	Thu,  8 Feb 2024 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381050; cv=fail; b=r/6tsNiRFZLfjtJNzsfv9YkKUWvn2CxrKgGSOUNxY1gAHJtv0G3anDTAjNtWGfaWllDBLncCgwDreXzJKRe+zrZVFZhcfhCeIepz5yNI1smiLpsDYYdKq+Y4YxWORZIz8gXbLn3ITkAE6qwaQUpJEJn894AWfRdhhdVMTniXae4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381050; c=relaxed/simple;
	bh=J73122+HFnNFNC51GLrx14jTPC+CRAtzjqyHQkKb3M4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cgsM9z22cp6s/b/xWX4yznPVzlOmK3ZUy3ZR7+vQErDNIdQliEA//QvdGGk7Xzp7kC3VzLAZ9k+uwhbGCloQv6n3SHzok1DFO2JcPsqa2bTyTUrCUY0L5qxteP6zkr9F7i0ZFQMhufPVaWQm9kaVh90GQ24skq24fFZRSNeuZIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jKQrABEO; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707381049; x=1738917049;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J73122+HFnNFNC51GLrx14jTPC+CRAtzjqyHQkKb3M4=;
  b=jKQrABEOHBO4G1gP/qBS5NvpJNVIySqRgWNj0iPllttKHvAJRtNoYpRR
   ZZugF1ROXTr5QwFz/CJOzu7M6JsYLBasgrc8cohUaTYvj785zMEe4kIxj
   f6vfLe0Bghdqb49d29dd8e8rp2vGSkQwWJ/rMRyoJnZ0GmX7CmmFoqUGB
   0B93ADaafSUbdWb9p0ehNnCVe/uKZurG9cv0hg2TUIiJcgwlb4GhQ4xek
   VIMknzmOGTjN+6geyfZzAMHE17kjo62h0jlIdihNWYyDvd/vF/m3eLQ+j
   r7LOqXDFO8jLALqhAm4nVJUbXrchQ39xQ6okdxxXQBmohLqrtBvIbZnZN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1324399"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1324399"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:30:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1583378"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 00:30:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 00:30:36 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 00:30:35 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 00:30:35 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 00:30:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fflJ6eGv5e5iyZJSZwOMKbmD5fPUVI1AU1YEu7pIQWXipVDH6HdO3nq0gKK0csYh21sk1ACI/0E7Q2Js9hW7YtN0rpaRpqumtAY5grQRXYhJz8fnbQiOMZslwm0/x/CbBZ822P1xSbCWyjU41gP9hcZibCW70ujB1NuXNri0aA7I+FkBF0M4/1W1mfZk4HJeraKyJDJZAnfTeDUWZYnxWIu0dRSoHNkqFyX+e+F6Dd2zX4SpPpNtiryUD06W0peS7wYXO8K8GHSNmyTqX3dquetlTZsfqMEfd5dmhcS7nYRQ7+4G3Eo71LggrXCxsHyhmT2YpinHkxTJ6nUrM0PYjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J73122+HFnNFNC51GLrx14jTPC+CRAtzjqyHQkKb3M4=;
 b=kFrBeJZw7zb63Kyx+PdhTQI+DnRxs3fTrSHeT64d0ewZ/DfI2Ij3PLhLDRpB+yn3YciSIqDgUwqnXPloftmPJHCah9xDGIPlHfJQzgl5P904se08VTOnS3spWx9PICFIn8UePKQkNF1euJXczZo8qSjJdpAN+y+HNk+/+kn97Ur/TmtuNRvMbOjwDaZZuL8T5inY4CaB2iWjvtCB1fp+bJR+9wKSUTsQCQObioIu+g0hIRlcIZW6IUaCdy3OZWPPWsqyGPvYRhYqbN6P9Uy4yFDIPV0ikEOrft/XhMpbkBlkCuzeoJVHmun4zloXSjg0Lfx3hqabrt7Hro4jvxUMOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7393.namprd11.prod.outlook.com (2603:10b6:930:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Thu, 8 Feb
 2024 08:30:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 08:30:32 +0000
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
Subject: RE: [PATCH rc 2/8] iommu/vt-d: Add __iommu_flush_iotlb_psi()
Thread-Topic: [PATCH rc 2/8] iommu/vt-d: Add __iommu_flush_iotlb_psi()
Thread-Index: AQHaWmgSC9AgQSzqckCf5bbjXGK1WrEAHTtw
Date: Thu, 8 Feb 2024 08:30:32 +0000
Message-ID: <BN9PR11MB5276D80BCF8CF97DEB3602378C442@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240208082307.15759-1-yi.l.liu@intel.com>
 <20240208082307.15759-3-yi.l.liu@intel.com>
In-Reply-To: <20240208082307.15759-3-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7393:EE_
x-ms-office365-filtering-correlation-id: 52458726-ade8-4395-4379-08dc28803746
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a1ylftFvmvXCdRS4Q1kMzlFviV8Y2OUnLSv9LfqL8qHwZPjr0lcPcl2xQd6jHURpUUBwYc3HzOKexE6assj1/cndEmT6OnwfSBPokOa3rcqM19zlJt+UOq/947Z3PkGRA8Lt6j1cFwf7bHj1OGmubIOamYSVnJ3qQM2P/ffGkqI1c1mKdoi/b4MSN5eUyjuuxdoZ33tD7i4wL9VJntKFvildaghy6n1w0nA0EzKFFhw3B7EzxnTVHYjD/A2jwfP6cTcCqkENudMXKFXAFz5FMEA08o0n54lPBITH/hExLyH//IoDLn6fD6kyujIgoReuhPfa0ffFB8Je/srlutnmX7PImFSDP8M/g0SUxuPnGAeQ7r8R8mhBoJTn86Hgp60FpMPlCAvCoOGzPQyA8pNp9apCjPXBkhCQ59D/afSFrItpv8jn5EsqDRMKEBmffK9RVbC4zb2VsrqblqVRK6BfATG9OUQv/vHQAvbmrV1MQnE/kSoPBrJDT4kzvAry5fYhzkN0JqB9W8+AemJeW+CbRGq1uBIhFLw6yOAEUDytJbkVkJdyGh4GdmDXzlm0S5WTNIPnquD+4qimNoXyLkQv0L+GzOJ6srUdkRRgNehbsYM+rW7wm83FIgeV8Q091KvR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(86362001)(55016003)(41300700001)(33656002)(82960400001)(122000001)(7416002)(2906002)(4744005)(38100700002)(38070700009)(9686003)(26005)(5660300002)(66476007)(7696005)(6506007)(478600001)(71200400001)(76116006)(110136005)(54906003)(66556008)(66446008)(316002)(66946007)(64756008)(4326008)(8676002)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9sHRCbiUwtnIvh4iNOue9Am4cLz6tPC6gsKzpoJ38NhK9f9uo+mCOTtDYTYf?=
 =?us-ascii?Q?DAq+PamhyZELd+ZniQGnBhsaE0fAFHZZqNujgma8X2i2MUZfewHVjhDx6zFe?=
 =?us-ascii?Q?7CBjmlP6LD8PArgEiEPJDirfyxpylF3ljXzT8EqSjhs9eItRObeTkvkRhjeJ?=
 =?us-ascii?Q?hb9B+i9DEqlkUdi8C5v/e+Ya5dx8Ywrmi99LdEIJL7oemp/mT3FaX+yN1N3M?=
 =?us-ascii?Q?GW4yRqBHVBfax5K80/c2rgF27ONTchITkMUIpK8f1WYNGnLc+I71mUFGBJNB?=
 =?us-ascii?Q?jSaOPD6MWWPIyO1y4ZJAcgH7bPrzxz+vq35LZ+a9i1dj0OkAcmActWfsn/gI?=
 =?us-ascii?Q?mINw2bkqC+J5SKhX5uMU5pmHFrGb6+6KKaXM/BEDrnQ9kZtIH0HZnt0nozCu?=
 =?us-ascii?Q?qavBgZwVKlTV2JAZVJ/iIHpiPBu/dfryK9rYalNfUYgUBkc5QcbnDHdfvheQ?=
 =?us-ascii?Q?7dVI7RkvcgMaMlFJz43yGBc8lI2vRjOdGUpTX0OM9O9g8UDHjp2ddFNZnaoE?=
 =?us-ascii?Q?D8MGqP9SsDRczzZo1rpOhcHcmWdFA9fu3sudOsq+w1pj8K31lCXP7kqw+KKs?=
 =?us-ascii?Q?cVj5FuF3CcuWeoSA1V05FyFu0gVmUUYMclgBl62WRDo/NjkpfDVRNFj50yAm?=
 =?us-ascii?Q?ZhwPp/eLFMi8I0Kj+9MvP3NKb6b1echLbSu+gmagU0J32Qg7JmrCZwzhERua?=
 =?us-ascii?Q?sRx6DXjx1ub0BZmf/eQIwqyqA+1RBlVqR4ugV3mxYzG+dHpif9X1gWEsAWrK?=
 =?us-ascii?Q?woVqBLxXY5DB8eP+Duwa+1+M8u8xKOCssZlnHG5R3RNhWzxxKBG+zQudvRHL?=
 =?us-ascii?Q?sPmPYYLaYf9FJ1bzrn+2/sM1p/tAg8hsKlASbyl3InuzawgRXtLViRSwHiYw?=
 =?us-ascii?Q?AazDYBnECuoTCIqy7Vp+ga0MthG5DC4cWAIrCkQzbYi1xSVWy9FceRw+stfG?=
 =?us-ascii?Q?ybdQ95HrAsZWcMFTMMfJMzH/8fDrOnVUppCcy3jIKGM0zMB5KggZR6vWCeev?=
 =?us-ascii?Q?lp5oHyt6fl/SOPg9BpfOgI6lwIe6luorn4rerUIkR+7G64PQ+SZCxUiAch3q?=
 =?us-ascii?Q?NER9Xyv2YiUJo+g8D+ZCv1fWiXSV31S23U0xfWoME3V+eYTKa21xx9jXpIo9?=
 =?us-ascii?Q?sUb+uVNSTAsruhZ8yuoJLMRAUSc8iH5h0tsS8jOmvIN6sXC6ewignclfLabH?=
 =?us-ascii?Q?0v7fA6349tY7/9ihLXPYN8awokRQeXjw58Ow2Ky+KfRuWAFeoHAWitjyhpfl?=
 =?us-ascii?Q?APBZ99B19QzYPdefT3j9wY1qHfqCACaz8fueCatdyJ+8cNpTQzlVgYqtxBv5?=
 =?us-ascii?Q?kGtvGiRsX79mTnQZ7KicntLIjc8ap2i2qoMlK831rZ+XFHF/lsWlXx/SQRgK?=
 =?us-ascii?Q?C6M9AU+Aq83x7fu42Bz3CK7Sz/9L1FurnaKl8fIjzD0J94IihoRsklnDcJZe?=
 =?us-ascii?Q?77rVPsWBf5NelAZZNWLdqdxpIL+jDReivLmak/m6+UzYfKmKnN0dE4Vjeyen?=
 =?us-ascii?Q?3LM1QSvqjEKARO4uq0kMdFN1fh46kwg9CsXIkMSnSFbY/MQI/xHVoO1anCFz?=
 =?us-ascii?Q?uTFDGBBhnNpDlTelqwNPg0TBxnOC6SUbcVymCvo8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 52458726-ade8-4395-4379-08dc28803746
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 08:30:32.7644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zddd3RyPzicIv+diLnrNOperTP2kenwSmZaYymdv7o1aP6ZL/WQ5sIQRJbijQ6Mh0+6ZtR9Ws3QQ0XdatWS03w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7393
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, February 8, 2024 4:23 PM
>=20
> Add __iommu_flush_iotlb_psi() to do the psi iotlb flush with a DID input
> rather than calculating it within the helper.
>=20
> This is useful when flushing cache for parent domain which reuses DIDs of
> its nested domains.
>=20
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

