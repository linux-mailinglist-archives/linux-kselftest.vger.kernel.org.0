Return-Path: <linux-kselftest+bounces-4326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BAE84DB6C
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 09:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091921F25BF5
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 08:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A0C6A331;
	Thu,  8 Feb 2024 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0pKfE5D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B040869E1E;
	Thu,  8 Feb 2024 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380917; cv=fail; b=d81rOQRFwZO+ATBY8HQN993jreX9peqgtMfnEI5F7UM43j6c19uHUwtrYTPlOf774DFE920iJwwLcv+XnKxkv/QhJZE6fAPF0AbCj+G8wWQwprQCt7Hfo40xbxRXjE/sFjpbmSnYk3PCBPLYBTAroWT8MjTshyYVWfK0MAmiUqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380917; c=relaxed/simple;
	bh=bzSSRJoEvxvNPuELCvxbGuBkW/uyfa6iMvojuQCtamA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xrh+Avpcn5bUKFo8TFtR3nNnDdilNJwJUhXw4BIszLd3RHQJNlhHWBNjwV0HebuVYVeGHW1J4f0K8StWyl1WqaR62x+PfwzsQ4vDB/4ZvtxveJHHUndOG7y15FuTkpcasF5Kam7D9hEQeaWPNNcB0q4jDF7p6E29S/qtU0TzeYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0pKfE5D; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707380916; x=1738916916;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bzSSRJoEvxvNPuELCvxbGuBkW/uyfa6iMvojuQCtamA=;
  b=d0pKfE5D0smPg36GHO+Iulmjn3Lfv7IBfQBWXsVGsVO/oXYP2pHMhEAo
   GUtgBqCZ8LVZhiZ8sExxsipyMvhU6eAFLDAFh6+/YMMirGTGNI7pYbdL8
   tPx1raLUj+nRXA/mqVyO+2SWr00k+Q2HFykuCUAuJEUCShHrx2lVjIQHD
   4/8OJf1IRWFxqvQ71rovh3dPwseEfkpSybfF+yiha+AnL+r0oHHW9OVHz
   4NgGtpXaOC/C93ntiAMrGg7Sl8QOS+kQm4RRxWsVz7m1JUCZoqqAbNCOG
   8eFoWcoYj28kJE2xXZregZuTH6h9TDC4P8TRnUs6FdyfTOP+h8EwCkkKM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11907087"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="11907087"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:28:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1911811"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 00:28:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 00:28:32 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 00:28:32 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 00:28:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtI9GQhlt864VwrjS8sVbbA4AUoxIDriDjTqWl4tqOrwE6ylK9AtJc537NreS/PsAcLWdqf0Lb6bQY2eu7ho8TfHGh9JwBJem0ksVBct0oWY5wHs+C6rK3zGlu9KYJjCvonoHFRoOsYEMWlOWBl40eKa3eiU2hB08Uvl1LzUCCezkzzqHywvsslDPxwWnyH7HXIsd6MxQ1dsYqJUoWIVMnJTUDq9IPtHJg4gl5KN4xcsodieHWCANU6x7qTyaM6CjnJYetRMN5C9RWtnzrxUYBviOlI7x21+8rTkqdADQY1CsjAUng5UywHvFl3qqC3MoC1RgiMs17dtSEFEv9jceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2i9awWL2S1gYlslki/uD3GAhALCXvr7Vdml5Ao+NqA=;
 b=aXNwM5O1Ae70JxwaSO7iuJ5FRJ00/5jaIst2+mLCFA48WSBDazf2Rv3zDv1ZBhQHInv2pHnyc9oLIjKu/B5oKCPujMECzIzU+J5XzewhvN3UED19lv09dPmqfVZSP3tm/SbHv3BfdyWxmfxVRsqym+dlSHxguNGhhNUq3Tm0emQuQJVUlsEijPB/9U/iLsePUYXJrKmfrWrGN06kA9y0PDdY3wroVqiiAn2+eZjzbEV5aMLZG2KJu11fnAtAb9K3K+l0GkAwOQ5IKdOyI5GnnL23Fg+k7fOXUp/kcBObO35XL8xRxohFd9gDuJVeWoufJDERsXaWQzUr0bkJcxT2Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5493.namprd11.prod.outlook.com (2603:10b6:208:31f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 08:28:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 08:28:31 +0000
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
Subject: RE: [PATCH rc 1/8] iommu/vt-d: Track nested domains in parent
Thread-Topic: [PATCH rc 1/8] iommu/vt-d: Track nested domains in parent
Thread-Index: AQHaWmgR115s+dBXNEus1VmhtnkXpbEAHGWg
Date: Thu, 8 Feb 2024 08:28:31 +0000
Message-ID: <BN9PR11MB5276FA50EE70CAA0DDB758578C442@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240208082307.15759-1-yi.l.liu@intel.com>
 <20240208082307.15759-2-yi.l.liu@intel.com>
In-Reply-To: <20240208082307.15759-2-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL1PR11MB5493:EE_
x-ms-office365-filtering-correlation-id: 0aeb789b-45d8-4738-6c4f-08dc287feeeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hejQtjrPZ+WSRYXScfOP6d1H2VfmvuiNetbxcsISmWAvx97ZyfZNPbQLoApu0+nRO8dE+OS+QPCzktCG6Om05ujwQbjPwooF3B+IMzsZQ5qi/U+ihXzfDD5EqnJtCXLlWwO87LHn42YioiaNPRPvi6tnAu6CalReuPoRttYrMAhWnuKo3nGfB2v6sP/PCAYrJ44Vhdz6WpTh0kyFGfBsIYbO7+r6kNqAWfrGTNNWAVtsLs/LphMDsd1zghjyRjKHuPIdbZkJEvxS+W3JzwCGOjaDFmEHNlrv4X7xHhtShrNd8aBM3XZlJ9S5EhoC9CQXdoQVs+5P/gTIxnZ9z/KFhlVGMTLe+gwrMfBSlYTNNIrSFcbCmC7aXmQ07dw51lqpK2nSxGGu5xNDc47EzLAUi8HujkrSelVTmX+oQsUBZ+zqxHIepKcLBF/5V0yLAFdZC8QiD6iRN6+UsozRbL4eiPeptHG2snQ0x7PUwKvuze8zMMH9hbRpHVG5WhMsspTE9TaQ3KIwbm98jNbzUeT/AHtsfItHXKvaWO4+q1/kpP30DAbpGJj06I1qvxtBORMyPl9HCygXKhAA2sposTxp6HSqIq1+uKY21EWNT199mGk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(55016003)(41300700001)(6506007)(7696005)(71200400001)(478600001)(4744005)(76116006)(5660300002)(52536014)(2906002)(316002)(54906003)(64756008)(66946007)(66556008)(66476007)(66446008)(110136005)(7416002)(26005)(9686003)(33656002)(38070700009)(38100700002)(86362001)(4326008)(8676002)(8936002)(122000001)(82960400001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n1BJqYmUFmLEqAaYpBZi0yT+XBjwXpOfySWPioecjrO6zWmzfDCk1KGhw7bV?=
 =?us-ascii?Q?4z6jV/LSZnVQTG9AL1otSdi0JB+C86pmwoo/4exEX1pg9xdulttkgO+z6Ifs?=
 =?us-ascii?Q?RXt8PT313OndzKLR3v3JzPnwzsKZRiL0BvGz5bRiY83CcqbDk7zMlfyPfvUx?=
 =?us-ascii?Q?4b2ykIGYoijuaOU6N4SHUx+VxxVt9+0kOvgsgoh8+o6jJXCO/EujTDXIiTqc?=
 =?us-ascii?Q?/EmtJQm13jZn2bvGkI/wSQuvZP48htF4jDdsDyXE5OtQ5wATZwWyma2+uJMd?=
 =?us-ascii?Q?UHk/9GKcdJ/csB+QisMj98zG+Q5VGW/G4lW2N5mVoHkhXm+W9xuOKldpDuH9?=
 =?us-ascii?Q?6FOqocIyxmKBkGoMRC6Vd1B+OUMsZwA/wu+nXS0KYC60gGBSt6Dn3SAzI8dG?=
 =?us-ascii?Q?T2ohL6Vw5FNmaIEjlvGKc19nQHJqlfKKCGJfdPhA82wvTnU3k846A64nqJgD?=
 =?us-ascii?Q?eLxP8uVCDBNfBvpq3qhQvs0j4ar9jrhhGPLsCsc345jUjWlqyL8tbmlANOXE?=
 =?us-ascii?Q?9963/OWZKnJOh5f2z3aXbCyPaySC+JUBHpgp+j7r8IDWN/9iR4MeQ8XfmHuw?=
 =?us-ascii?Q?BHnxSy/FEzDrxHFNlk5PM61kd5R/rZsozj9bKwHPyjnNcxRnSBHGATijmNID?=
 =?us-ascii?Q?DP6SQK/vo21GMcjQTd4ExFJ+G7123qf7URyqsTjnW+LnBx8PEXfRJ6EaIgIQ?=
 =?us-ascii?Q?ZIDdr3BFwASTIzkIPqshX5YmC0DkR6G6WdtxIq7XYOegiaMqR8JPDaFeGUDY?=
 =?us-ascii?Q?q5pNqD0UCkKoKJvlhzSFc2arxEqm20MmYCl/nvkG5ksEBZZIcohqif+t5Mao?=
 =?us-ascii?Q?LkysGbnKg7SKQAvbjHH3anv1EBhiMpKimTJR+I4bKjNn6fOta/YiGystCOny?=
 =?us-ascii?Q?iKmSUCDFogBRE5xYxHaDZ4tK2NpaBDdIbo1Xv8t5dI+ComPDHclx9WAEuHRt?=
 =?us-ascii?Q?RTuyqOKYqXfGFKU5ZhVac5knZcD28W4miOd36oq8LjkHpes8uqGLmDN1vLox?=
 =?us-ascii?Q?D1TNkyDLmIbs9Vpb0UUZhZ4rHXg2ykS/YYOopVKZtqW8I8+4x3E3gi7xE/+I?=
 =?us-ascii?Q?j0v+wUkPkUBB/uPSWZjUvIGDqm7TfNQ8iBA8C0hdLPK8+627xgebA7BS3Sp+?=
 =?us-ascii?Q?Ev17bFuWjiaxyMyrSz7DVzW6Osi8I16i27bslyWqBh1GfBUpfy+gPeFU8b/0?=
 =?us-ascii?Q?6Oq9iQ2F44OZuNIZ9YTh4VdK1IB07wrYgcE+RFHnJy9TEuNrIeF1HXPFnGdo?=
 =?us-ascii?Q?OaACOXHD/kfskkeMs+hIeUtWRX4RnjejkfpMCItextMf9fB1uhEGRupJCfQS?=
 =?us-ascii?Q?UhlxZPEo7zlRP6EHCbh0+8OM+RL3Eo7ebmPR4zl32r5yCalzJSLLxBJMG27x?=
 =?us-ascii?Q?c4cqcDGgLvz+0A+0114VKfO1kI6UbS4av/kqwr+pUOnurg1OBIYKePGaEQy6?=
 =?us-ascii?Q?BvM0OfYZWK8Va3bV7ScQ+rxfcf2E03A7SoAOw8XTGuRmjhP5gNAaiFtI2giZ?=
 =?us-ascii?Q?CDdpx67jmlyrBOASRng8oULqPndF3e1ezXf7rbKaD6PRp2QbfITuNdOOi5Yy?=
 =?us-ascii?Q?jMf2mWSuSpCiz2zTpezJhCmiPWI5eCqSEXyUf9WU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aeb789b-45d8-4738-6c4f-08dc287feeeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 08:28:31.3937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NK9hAsf+6yx2gj//dD2Vh4DlQVqZC4QXLhzlQQrrH83skbZki5kNfJi2fYky6aLFFBZg6M6GOo313M/lNunn0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5493
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, February 8, 2024 4:23 PM
>=20
>  static void intel_nested_domain_free(struct iommu_domain *domain)
>  {
> +	struct dmar_domain *dmar_domain =3D to_dmar_domain(domain);
> +	struct dmar_domain *s2_domain =3D dmar_domain->s2_domain;
> +
> +	spin_lock(&s2_domain->s1_lock);
> +	list_del(&dmar_domain->s2_link);
> +	spin_unlock(&s2_domain->s1_lock);
>  	kfree(to_dmar_domain(domain));

use 'dmar_domain'.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

