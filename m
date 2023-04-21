Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C554E6EA4B3
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 09:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjDUH3e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 03:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjDUH3d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 03:29:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6E57EE3;
        Fri, 21 Apr 2023 00:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682062169; x=1713598169;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nIZ5+5oCcCgZEjicymdMXZF7tgDIp8kbX2LdGrZy50I=;
  b=ltRk1TQT1STjslJIjamsZMm3rJaFYb2USdq8Cp1CKYTUhL/Q/fJOd6k/
   Q7XoEWfJ1YwJURfNTbK880zNaTAJe0fDktLOEGa60yfZnwLwlTraT028U
   w2FqWZDOaL1aSGrWcTp1DbCxfoOTcgyBjUULNc/LFi+Bbn/YrdG4a9U1h
   jR2rlXLEDimC8MAq78Hyfxkrv993j/sYWFgn6xhSr5GGRlurVdkSTHDaF
   43JJtWLI1PJ8CUE+TM++hUQaMMxAG/HGYlx0Hlx23hPJzEbdkLVt8WZAU
   ZCGeMHrPZKWpgPqFPVBS2yUQnTkS/3ZRlPY1xwhrPWaoW2A+e9oXAkkng
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="334809762"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="334809762"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 00:29:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="724717721"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="724717721"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 21 Apr 2023 00:29:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 00:29:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 00:29:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 00:29:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 00:29:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f40kedBXmmYWc+jr0Vqn2yZp2cu1NwcDWsmxQ0QGGVX3gdzRQ2BjC99fP4GlAtyqh7Z7haFk1uqa2Z1pA2SFPQetgTcBOVSVlkdB1ra6Mye92bFt2RViJABqIPofT/PG5A9NNYqYKZN1hK1vQ622dFmtsB2VirjLBJAJuCSlCNZAn1EzLvzwpBk/CjFK6QgjfelByb2hjmm8B0IqhsBxoOptu8alqU1fqRd71vI4ciRbBF9mPilfZ4f6RK6wA56qqijd7X+rvz2fEFTPdlDQC8o5f5ybfQieKW7kkS4Ye2jfBD6zFTfd8raizgeoqM3++hSmbiP55tV7ZOQKrgD44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIZ5+5oCcCgZEjicymdMXZF7tgDIp8kbX2LdGrZy50I=;
 b=Ou1dpRrEtcCbj/XSgQ55gBZ3YoGDb1A/yNdGsFLnb21LMsQi5hz5UyzfhIjJmJ6lWLhRmPLKQ8iaK+UyHkrGIy1a3AHrhXY6Urr2VuKhGjEpMW1pyFNtjucFy5A2b9IIu1V+piUo0Zh/KWNv8sZqHf2/yiAVhEZiHJK0taPLAc/8GEtm7ton+4a6U4IxlntUXVEJU/IzXg5HnXb3nwmqL7k52Wdv3Ipq8dObU/iVzFAAV3dXK4AxCwC0sLL25H2clt2P7D1ZLIdb2Lq/IiAsraSVvy0B393DsJCjs+RPJ7RTqqtlmPfnc9XwUJDnMu1zjrPGX0HljYxViza6S7CUuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB4949.namprd11.prod.outlook.com (2603:10b6:510:31::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Fri, 21 Apr
 2023 07:29:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%6]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 07:29:25 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Yang, Lixiao" <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v6 10/19] iommufd: Allow a hwpt to be aborted after
 allocation
Thread-Topic: [PATCH v6 10/19] iommufd: Allow a hwpt to be aborted after
 allocation
Thread-Index: AQHZc7krvZse2gIcMEGenRmCeejy1681XnTQ
Date:   Fri, 21 Apr 2023 07:29:24 +0000
Message-ID: <BN9PR11MB52767CDBB5A3E2D8D62E1D478C609@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
 <10-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <10-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB4949:EE_
x-ms-office365-filtering-correlation-id: ae9cb16f-eebf-481e-f809-08db423a2211
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7fr5U2m/ZxmUD6qz7gfkW7O2hx0ar5r+UBgBM5JXwmVBeSK5YweuiMgdYYmvO4EaVItgeas4dvi5uoOAVlvhYOPVruwpIzxBbaCgT7COM943Lbp0s7ba3gatIJUqRTpKrUKa5ZyPwLkroy8pZVKHRcv3SsdlwxktbtN3rjp/sexT3EnJ3Tg5BQzAOslquS5PbTtYnhIcnOMINddTZZUCdAJ38iHakEUD9HDO2A584t3qKuE/edRFoMtnWFmWn+dIyyX72vLOsugyXX38s+H59esGv+TyeBTBNlOBlKrzBgHHW2+WG0KwZusnkmqq4ifvyUG6S2BhSB+IvllobqPw/hntHI2VMgRIjmZp3xF9onTeG09RF+ahN2KhirAUL05TkGSM8jBVzgrnsIVGweFT5wGW73yIOyVA63fUNJ4raneIV0YqOX+K9FZ8SqOn0B9uqafln52ge3JBcvwX7Yf9hOQR0PPpUP1ww2NwTMKGE5kK22a5nUe34o0XGhB0LgA64fBXWPK0u2nO1Vst+zoE521VfrrigScD+vXLnCfUSRqx5Rs66ooJsNaUJqCohKVH24mMoTDUu7lZYs1N494ZxRg5Z4AHFK3RQxxdZs2TVU/0jter4gt+LH+GW4RR+OF1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(110136005)(66556008)(54906003)(316002)(66476007)(64756008)(66946007)(76116006)(66446008)(4326008)(186003)(55016003)(6506007)(26005)(38100700002)(9686003)(83380400001)(122000001)(5660300002)(52536014)(8676002)(41300700001)(8936002)(478600001)(71200400001)(7696005)(38070700005)(33656002)(2906002)(86362001)(4744005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XY11t7YB7EgsWqteYtIwvLeneXj9Os6is/05YBKnuL7BWmlPwTjsXcBF3sEr?=
 =?us-ascii?Q?eF9UBL5BialQMItyHqljidFVs6hLK/SLiUUEKvzVxF/f7C9odmF7Y7s9VXLq?=
 =?us-ascii?Q?tqSl0SN4nnY5w5h4lh3F3F1vEQGWeWqeKxh0mOrax336w6Do+ArZp0HASBy4?=
 =?us-ascii?Q?6qHI+O3i5Q7puB7Kb/fVQdKmw1mTxMU9fjITEsNrrWc63DNWHPyyXs7PmIzr?=
 =?us-ascii?Q?IyAQAMfmspJULoVoadvSL9xHj5bXAgrxDy2VKQDDXViUX9nLGdxRVy8gEwIl?=
 =?us-ascii?Q?AtwoFnanZ3+hhYR18Y6wbHm9EjmIICP5rHU4CLXpYM7p+7uIYRsiHD6lUGew?=
 =?us-ascii?Q?ea3a5FLja+iENetexz4FGm5NoTY++S+wn7+7bvbFXg+LNL8oKCnZ6cSztBy0?=
 =?us-ascii?Q?1k6k/S02dJNhAhK6NPGsUWXVK3IVI3DVFpuNFkXLCwDDo0iK1UD486jKGBlH?=
 =?us-ascii?Q?APB8GD32z3oWbwdATA0mwNzUhNuGHRk75se5JJ4SQc0OL0fLLDa0PBTFds0W?=
 =?us-ascii?Q?zBGreayH6M72c9HZc6yFkMuYh/ZFgTwHMpouNN98pCmtbH4LsJWjUDq6khU8?=
 =?us-ascii?Q?wGrVoTy+euN4zRTKD/lK+rHLnkvKynYFQmoTmPKnLCwltQ2B/0MQ+VpEecRL?=
 =?us-ascii?Q?CZjwgvCQq9ZfvKcGHqZPrL/Rc00MfKtN6EbMp8JeGbpZ9SGou7zBtVilsAYM?=
 =?us-ascii?Q?p/5HCafP7mKsEPeznliVtNUeZoLDbYW1rNKIq5kgttFssgJGn4xFRgjo8uVe?=
 =?us-ascii?Q?uR76LgvugeJxDSCaRp1Pmb9DbdHvu6rDbVk8FUOLj55dJZfY6FQUzpW+5OBU?=
 =?us-ascii?Q?NHZv/m6DrFkFJxnPht2PyJWpx+qqAVxgpD+fO5Z/zo2tniX0LeDEQwbYadpP?=
 =?us-ascii?Q?MRgjlluia1xqkmkXozUoGY5a04jMkP97h1mJqU9hcDsg4YzqGO6Nz5mLR9bT?=
 =?us-ascii?Q?Yo5XLJaXTQFKskOdqlNObCqi4TDT+dhbZmfJJcAyFUcJQ3APypjHar1LIJRg?=
 =?us-ascii?Q?1AZrx9477KLvX9Mh/B/Fey3ShW4AnXdURG+FpLOonjCAQLkYwMvdO3GluwGp?=
 =?us-ascii?Q?w68C8CvdFbcRC8ny6kqdnH4c+fsE1cHiXPToSjiRCAc3xfd2ofqgrz39bycG?=
 =?us-ascii?Q?CSoAZt2f9tVSsKhvpMUPRU9r9iJQhBfh+N8WbbSFezASRZm9i3DuRgmMebCn?=
 =?us-ascii?Q?4gMcjC3nTmSR5KvsVvbpHs9CdJGqFCfivnaqrulJaIUAnC9wN1YJMnV416jj?=
 =?us-ascii?Q?0RaUnSyRIUe0gVKTf9klFhEadcX6E9UHXteDIPiWUTxFAI2tFVWOFbjzUE0e?=
 =?us-ascii?Q?v8kr0aYtpbwH/tQe8P/6llH5a/XMSL74FV/pCfDfD9FJBiwn/+WygdgfX3PJ?=
 =?us-ascii?Q?VOJw3UycUDb59OssANFBq/bu95jldU/KRU+2tCHA5Qc4KH6O4GieDvOB0eID?=
 =?us-ascii?Q?v71d4fUOgGvqQLhaqbppTF9oSwA6A2RthHGQLts8VVx3sL+jVxir2ahxQOw0?=
 =?us-ascii?Q?j9ObyGEli2w2h7UQs52+5ps/g24VLwpyikHeRgGvT2AOub+yE5Q++rPyvRJz?=
 =?us-ascii?Q?53BNRTDrYdcGnCf3CRhvW6c3kZSZkuOVeg6oe6uD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9cb16f-eebf-481e-f809-08db423a2211
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 07:29:24.9815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u4xjAMKMB02PIszD/IVUORynY9t5PTccPQn7IBegEZH8C+dMPiBCkJA3PZomHFPrgW8PDrSaZQrg3pyUyWMMWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4949
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, April 21, 2023 2:51 AM
>=20
> During creation the hwpt must have the ioas->mutex held until the object
> is finalized. This means we need to be able to call
> iommufd_object_abort_and_destroy() while holding the mutex.
>=20
> Since iommufd_hw_pagetable_destroy() also needs the mutex this is
> problematic.
>=20
> Fix it by creating a special abort op for the object that can assume the
> caller is holding the lock, as required by the contract.
>=20
> The next patch will add another iommufd_object_abort_and_destroy() for a
> hwpt.
>=20
> Fixes: e8d57210035b ("iommufd: Add kAPI toward external drivers for
> physical devices")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
