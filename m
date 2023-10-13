Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3587C7E6C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 09:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjJMHNq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 03:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjJMHNp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 03:13:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC14BC;
        Fri, 13 Oct 2023 00:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697181219; x=1728717219;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W0K5Jafa9S+IdKSMWcjxJxq1wqlzrzKdBkyM0/jUeRA=;
  b=ldIHTFVPnfM6ogzZHQuL3dK0xWzDlrrozAVmYf3wF/rvKc6fTMlwYzeU
   1srikYgsSSIrVG2dgSiKz+TXEdMSGwii3pxuXY4XGIJJnfWv1w+cx/hv2
   T4GcDguQtLfqwNyFCQvRcfM0K+Xco+WVyV0Fk+p17iTUItorxM+QEMTbD
   mFZSyd00SiXZXvDuYhHI0cFvphAooF7AOXfTK9yB7zDT03ER1QybVw0BP
   r2tNe5riXQjExduWZ9EyEjmGHF5OZBASRBdUIWeRCsMGlnHwmmCfIPdPb
   UOGkoeNZg5rzX45Gb1a/3TxUo92u1j7+lafL68Ms5UdnsBjiSfDKDB25T
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="451599405"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="451599405"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 00:13:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="704517280"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="704517280"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 00:13:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 00:13:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 00:13:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 00:13:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 00:13:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P15OZ4BRKmIO6uD3TBkz/eSa77RgI1lL1f2kZ5defHcg55M09Y3NGKATSnzbxc6GzfEhSO32R9bZ+saT/qVJUixmydKCwb5bxc585ec0/5mn1xvastA9B+tq3+TKmyCs+YmifTztG5hT612QBIIQWW7T35v0Zq0WfeQXc6z8kyzDHzSiSEbSvovq3uE0dprKzK1gjS4ti1lGIdpuALUznqViqor8sRVWqeJjhApMrlnFhd4rZcw+VRofX37/Axng11NM1focrBGKqaPey9ZQoI2nYuQc+RUo5yPstw0awcsWk38RkmAkATw2yhCLopYLr348adOTj1VsVcSSCjnLAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0K5Jafa9S+IdKSMWcjxJxq1wqlzrzKdBkyM0/jUeRA=;
 b=Z6/RWoqqOzRDg2A0HexJq5ZTv9/w04P/tXaRIEY7loiiv9XzrVVPdv+k3Bxxs8p/rXWVo8bQi3idPyUI0jqgqzX2AY6Q4dSXqQJtnemPNux1bV8bfA8zsum79ObJvyZPUHkwv4b/H8lK/oLbCoRlCdeFdnLySpOV1U/vxP2iLOnZq0hOzrdYGR4TCkubjRXCWn1OcNT2ty/qTn+J4OZcWqGodSqGUMmTOg25MqiWfpOuprzDOiDfg5PbYebTcxOlrgWF7ypeAlxtmJSIkUzdRtbeifweVkuuLGsi7cQPjCW/A91y6XLo1Dvwh8tw6WPpwv6++cJeWG2y4AY++XmC+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7020.namprd11.prod.outlook.com (2603:10b6:806:2af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.32; Fri, 13 Oct
 2023 07:13:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4%3]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 07:13:34 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [PATCH v4 05/17] iommufd: Separate kernel-managed HWPT
 alloc/destroy/abort functions
Thread-Topic: [PATCH v4 05/17] iommufd: Separate kernel-managed HWPT
 alloc/destroy/abort functions
Thread-Index: AQHZ7GCN3k0pHsaUpUaqL7OxTm+gurBDfEEAgAMqP4CAAMh40A==
Date:   Fri, 13 Oct 2023 07:13:34 +0000
Message-ID: <BN9PR11MB5276A55B59EAE44DE058DDF58CD2A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-6-yi.l.liu@intel.com>
 <20231010184932.GT3952@nvidia.com> <20231012190931.GO3952@nvidia.com>
In-Reply-To: <20231012190931.GO3952@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7020:EE_
x-ms-office365-filtering-correlation-id: d7538333-58b7-428a-ba7c-08dbcbbbe99f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0zCFRGNwpDHXHVmqkn8Gywju2gI05Som3GrkoxH+hezXAUOryC12eRSYS6sQj+eZ3lfH2czwg+fBx9gaaE7R0B4UArwPbYRBmdSUeGIm55sWttwavyfiMPFrG1BCYfK0IwuctMNSCThoHNJguwbjcj9/RyBmRgeTBzNB9YSw/UlZNuDMERUAOBwnDWAsI4U1+ny6GS4+xGsmxwkVrm8oAxFXGRhe/VitMQQI+2inJB2zdkiacmOBBMz1mRs+WqMa/OmdEVyNHtvX/fWXpRGw68Tn9s6v9hQQe65ZMY2E8J9pqzxY5CoawVBttsjM02UoP3ZhjeObpGTz5bipyfxviVnD9sAXGjqvpQe9UNRcvmWatiPCdz43azWvXQixRDc/KYz/JXaN7/bV6boTjtZR23JNHnOVzRG4hVVdGzfM3oT4rkZjW3s5zzJzuf+EtXcO8Ehvo5O1n0j8Vm45uCaf5ZB9ExuMG/NAxBK3vg3BelKPxyy6yIe74zvRQXpm/CNyz7b0HoHJHSiBNCF8NLO4ekljcCTg1wXPTh3UrFZzerRg267ct2AxF6bLtnBzchddGQG09+X4e3DTc+X8sSYE9WNvoglRV98sssL0Gq3bUm+41zmiH3C3uokTzBuexvXt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6506007)(55016003)(66899024)(478600001)(7696005)(110136005)(71200400001)(9686003)(83380400001)(2906002)(86362001)(38100700002)(76116006)(7416002)(66556008)(38070700005)(316002)(66446008)(82960400001)(52536014)(122000001)(64756008)(8676002)(26005)(5660300002)(4326008)(41300700001)(66476007)(8936002)(66946007)(54906003)(6636002)(33656002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?orE3jFe8lFAvmyDnLD6Mf/HaFg2GzohiDSQtf9RGl/jGq+j35hy0bFuVRnp3?=
 =?us-ascii?Q?TtvDxEmFVvPW6fzf1FxDM0oHsDoB+G28AI7AvYm0ovcInMOCDTADj8d1MrHZ?=
 =?us-ascii?Q?6r57VUInVwidUAO1ggtqigxW0qcDPWhyMdsTWYsNGZeg0qdTtidoIKGJQtUh?=
 =?us-ascii?Q?foofSi58vTxs7SkHz1y/mG4gmGqnc6PzPuSfmX6Cf79j0QjGkd/hIIhtd2DF?=
 =?us-ascii?Q?oIH+r8NV7dzLvMKFNi5hrzrHEBT3SF+GMYWIaYsP2DLBaZOjgWYUwSoWNKgz?=
 =?us-ascii?Q?hBkwRYnSdsDA47e5IlHOcO1MQ6+F6XdPki3brvUvkr5Js0NkHsDdblH7t5u5?=
 =?us-ascii?Q?wQJxIt0EM6kGT2lgBgZfj/OxjcsqzxmZrnQeSpTSe2AU2w6EqwQ/fTPatrGJ?=
 =?us-ascii?Q?zDsKgWkYHHC/taTNhINwnm9AjLUJmpC2gY8dmeeeQbBiQZT5dxq7E7mi0oKX?=
 =?us-ascii?Q?1SQ3JsrqY9Dd2H7piY58OgCetrL63c6xTCV2FoovF3VVltTxYZACrsFTgCbz?=
 =?us-ascii?Q?H9dFCzgy+IKhCXO3UKzJABgv4RQXpkPezr2lxpHRnKwL8tfl/taxgSZbNKaG?=
 =?us-ascii?Q?OVMzuR9yItGI+yeFXGgoTXvPX+20FZv1hKh/jV2FE89ZQmKCyroXuDR8McAf?=
 =?us-ascii?Q?wvcyvGsWiNQ5B9++Wu5bvFalt1vT3TOWfvKuzh5qDnChyzB6aCDwE9w6BcLX?=
 =?us-ascii?Q?w/FAdI1fJIgTUOKPzkV5ZdzgKq8B98vPdNDkGzs4K9MVBe9n92xNaE1Tdp/C?=
 =?us-ascii?Q?pNhQWcbirVW3M7wOgb1guMsT8GiBjwaiqZ13K62p43AR/pCfvpGxHyhvOOj8?=
 =?us-ascii?Q?F+VZYIc6+q/A9gGwO1L22ZtZs8pPrd5A8hA4kPdR7Pnbl7VOV/PnVXwZ78zO?=
 =?us-ascii?Q?dg78BN4UUrJ/WCy7MYwuwT1igcxG0RaIMC0z9eoqkLoGdMumX4pBBUGySIKF?=
 =?us-ascii?Q?3NQBumx3K1UAHYtCb+hrjVAAI9fMk7E+YrODioesl5jNytfloX/kSLgns/R6?=
 =?us-ascii?Q?gsx3t6mS7m94xV6g3/8WMDTXRb9KReei57b/6FabjIKg5uAtzsS2uu2GWbgA?=
 =?us-ascii?Q?f01nbw46VcU/XfGPbPKUhrectRb4F6d6SZ5Jn/rO+9q83P+iZtx/dypgKjLw?=
 =?us-ascii?Q?WukJDu537xlnL6TSvkjFQBbBeKqdhsVPYOFrSQMUNzGRiaArlcmdhTuBaXuX?=
 =?us-ascii?Q?+vl4g/RWLZ6l8eakvHCMi8EXiI+DAxzpdaiiu0PP9EiTIzVQSt3GWwTXcixU?=
 =?us-ascii?Q?Yi2AQ52k4UkP2OFSJEM0seqeYj96XzECYTtA5+yLZ+AMwT6bGTRkSghPvFa+?=
 =?us-ascii?Q?1rLPAfuckD8LX30XskrbmoTUEnDUnxRmoo+Qy/GxlOdpso1NshWvHu0Jg+0W?=
 =?us-ascii?Q?AHRU0KfUdvG7Lw7D0DBzHCHm9e3MBjCtN4kzBJwQ2W3F+4zdEIFLLDgw55fq?=
 =?us-ascii?Q?IjWmlwvzcrRdN1R+OeFcHptd68Mi7NAtoemRD4Q5Up9LrNmed0cw1CgKPrfh?=
 =?us-ascii?Q?hICZjXKaL14/eUYr+9YrR0Hw6+uXr4UXjbOSdbuJksqfG7u8zRtSTyN44A3g?=
 =?us-ascii?Q?fGFE+Jygc/EIyqkU6mweM0H/AOiKS4K36s6bX9iW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7538333-58b7-428a-ba7c-08dbcbbbe99f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 07:13:34.1864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vvu6HpkP3Y0ykNjHnEbHMZ1z/EoosmyKhSad+0GAT5M/r8GF9AnffJCb+m/Cl1nFE4bjI0tvtGgs3grM+3w9SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7020
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, October 13, 2023 3:10 AM
>=20
> Also, we probably should feed enforce_cache_coherency through the
> alloc_hwpt uapi and not try to autodetect it..
>=20

In the past we had a long discussion about this with the conclusion
that user opt is the ideal model but it's fine to stay with autodetect
and existing vfio/kvm contract for coherency detection until we
see a real demand for user opt.

Is there anything new which changes your mind to have user opt now?
