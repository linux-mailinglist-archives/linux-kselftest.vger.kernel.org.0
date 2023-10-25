Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1841E7D61CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Oct 2023 08:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjJYGqd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 02:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjJYGq1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 02:46:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3D491;
        Tue, 24 Oct 2023 23:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698216385; x=1729752385;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t44h8COzR4ouwa7WaS1CgXoeke0/67sV64CRsZQG6sE=;
  b=PX/13T6VE3xTKEED91wskSDVAvphse7Qo3yqpmnp8ravRC+QVdk/5XYc
   F4fPVi3v3cFfHO4PZslCnoKFwPyrgIOJeFVj4YQ6Dh4F+yWe6GmLZWdZO
   +yudFCUsAX9gvgXiC7F+DVmpo7nFnnrJnlGV8LpO8WDP3AUYrQmqzB7LY
   U8ESYF9s3k9xe70eF5foiI2DSKlFaoO1PfCo5p9qR177TSojwwmgklc9B
   9SKtBv4Ah+bl6LNp2JfdpIV4JpcbZBVA95vucduR1743RMmZlUgFR8+gV
   YV9ADL4frzVN6WmK+tF64cMCtN4copxDo+VhAyixI7++dcKr55kxp1kej
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="377617589"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="377617589"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 23:46:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="735290590"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="735290590"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 23:46:24 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 23:46:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 23:46:24 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 23:46:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GD0xeQ289k/VAV2yzT4nu7WdhlSo7P9w32ogjTYM10rY4dc7dadb2cSBPLZyAdDIwNXqrO18UIuSp1YtrL5oM2HSVQt2eKGhxm3rGOrbJTamUSJRYDxKG1hNiAjJLXad92hqsamsSqLaA2l4FNWK+Xa8ej8z/7fDmIdbapClTNz27DyZArGqG3DaHtikyzc58EAu0BUlv81JC2fhuoDdQt5egazQcF0dXQQA9ZyAeen8+jaU9pn2edNYkLS52HNTPPRRQMwXUX+JPVAv3aML91tTw3UC1oDNlaJokwkHWANlkoFAL5+djntgztWowVILa1s6sslJLFXJ8VdH3meeAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4vaq3j3PfDhX/aLrsckHLngqesk9uXIh/INiEU0BQc=;
 b=fNGga7UwH+VgqLSz1RBgc5LVbaijnCRX7YGZ49AcbqBNDlV3hnkae8dG7R27Al5noDMxfXxKIZmznrOEF3OMpSwcRpW6ghjAqPqwMEFW8ktQqXbkW0Ih/j7lhOWa/O84JUoZGbrkNgd+eZvDxUi0fKw9lFk9Oa41423LNqy5XWbLVMWVREThosUgfXcXMdqRUHsr7tFStvgtZb86hpYN1Cn8ww/l0B/DmDXebcQj8JAWQJ1dxI7u8GMQnqNNb6T54g41UrITueRh4SlXXdDJsN0G03DaK2lsW8zuM3zK6SB/mPIXpNq3I8kr6dGyWg2yZT0gFpNYX695LY0MznoNCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB8092.namprd11.prod.outlook.com (2603:10b6:8:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 06:46:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 06:46:20 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC:     "cohuck@redhat.com" <cohuck@redhat.com>,
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
Subject: RE: [PATCH v6 04/10] iommufd/device: Wrap
 IOMMUFD_OBJ_HWPT_PAGING-only configurations
Thread-Topic: [PATCH v6 04/10] iommufd/device: Wrap
 IOMMUFD_OBJ_HWPT_PAGING-only configurations
Thread-Index: AQHaBou2thRR0b1SL06rXFPsnYb7TrBaEGMQ
Date:   Wed, 25 Oct 2023 06:46:20 +0000
Message-ID: <BN9PR11MB5276E2B6AFB5617395E9A5768CDEA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231024150609.46884-1-yi.l.liu@intel.com>
 <20231024150609.46884-5-yi.l.liu@intel.com>
In-Reply-To: <20231024150609.46884-5-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB8092:EE_
x-ms-office365-filtering-correlation-id: 28dc91d9-1bad-4e45-663f-08dbd526189b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gEBk02t2lQdJxhZKI0sjrTwgJynnyk8vC79q4YOP7chmlfVk/bD4FNHTrxU5z6+TKj10ObMi3QGophQ6i8IyQnaFq6/oFO4THzoYiom/WK1G5/oUkbdH0su3s3DTPca+pcbFaFJ/HxEf33wDIJW5aZla47VFJnT7PZm2brj0E8CVF92v5sg5pVOPbl9HvTe/ozyClP8/BlL1PXa74yx49G+R2S+ROCkclASPl0CNQyHlg4ItOow1MuygEE3WPndZ1RFP7qrrbTmaCLstPVX3UOYHpUpLPPvY4pGdQLwE8f7F6cmlbJefMEOmSVkQ1GnITzYVB9+b3sDIU2UgNiC1AXjK3iRVv9k1lRmVi4MQxO0C3upXjREuAa7+owyZFi4NMv+GyxABTkzfTCRebQfMp/2I4F4rZx0wW1tUaEGosXZVoe1hbCHbQm/8aCsxVUVncaCZHpHqut9nGUK6FyQunYk+zSsL0yE0gE/9EJA4RCfEMKG4SS7RtxKyeBUTTOCTlqXJBn8syw3eq5AsjlnIzKYDfdJSbMkYisqBELoqR/HmDfZPE/WHNumMqAehTFbmf8w5zZkv2GbTo2uCrsW1MVQNhDTPVA5iLr+emP8/rgzsiBmK5kKOgsZfD8qGUijD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(4744005)(66946007)(122000001)(2906002)(55016003)(38100700002)(82960400001)(110136005)(66446008)(316002)(76116006)(66556008)(64756008)(6506007)(7696005)(478600001)(54906003)(71200400001)(9686003)(83380400001)(52536014)(5660300002)(86362001)(7416002)(4326008)(33656002)(8676002)(41300700001)(8936002)(66476007)(38070700009)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sG1uOAm/2ruogq9WCawjsqPE9k5Og3ficPCC8Lp3pRObOodlBJhLgxoIlCQ6?=
 =?us-ascii?Q?V+o67LIzAwjB+vUN8MPZznNEEO/lMYn4UzByYdpY0Qtn74/5iGP40i+H0reD?=
 =?us-ascii?Q?S8glKdTERxyjmWf+rjwwdcsoHq+Gm8Iicq8dxz2eEnMWZm2S2mMPvlSZanaU?=
 =?us-ascii?Q?ICy71G9CgaJUwYxWA1YzEz+gzQFy6bEDgl3Cj+oVp2WG+GmXm4BWu41GnKQ0?=
 =?us-ascii?Q?BfMkE0cCYg9W0aTvtrmg7q71NM/b3mmttvDkKN/P/Ir0jvU/clVQHQYYzkLl?=
 =?us-ascii?Q?UPx2SSwCSnDrzv+aVufO1NwZq2amxs4SqcW0S5itaNNJTuvlHOcjio347eLb?=
 =?us-ascii?Q?ldFiRGLbIHb36qiPoWCUgORN370Uw9tDTmHAVMaskMxsTqj9rPDiD7xSFqK/?=
 =?us-ascii?Q?sWMd+iN6h4Kw8HX4xn5/9dLH4ekeoER30L7ym6CynwAAR20Q9MdtWzTcpGS1?=
 =?us-ascii?Q?h6wiiziI+8FLwZae2QMshU9x9M/MwvrTcuAbLMHDA9Km7efuraZIo68gfT+s?=
 =?us-ascii?Q?dIP5XwhQkN4JX09TitriXtE7OeqKrhCufQmo9HZ8rT/MR4wMvKuoUQFslNrO?=
 =?us-ascii?Q?9ZvgtlGBDnwpNJo7d5DEpf32ybxiqPqa633JokaZwpGVk45o3Ddr+YPvhEYX?=
 =?us-ascii?Q?i4HGQwJrZmc/Z/PLHmuHV7RPFiZ1p+SoTNp5VdpMEzb11C8MX50q9rkNCB7u?=
 =?us-ascii?Q?hg/bnjVJ+qFBMAvsYEMyIoxlue+lOFzUmAlzLrxx85MlVr7udIGDDKfM0mBe?=
 =?us-ascii?Q?BbXVCHTUunfPWh1zc35A5CI/Ema4Us6bqUbzT9phfSesu4y9LwKSllrx4zGH?=
 =?us-ascii?Q?c38BkeRDaYu55ngSxUMSfJtzgy5hU+fCqyOR9Xne1z656zKft1DZpCMVf/8L?=
 =?us-ascii?Q?zYau3dY9C19NT7WHyHSKiFxk5BTMcc9uEzJZPi+jf7tdeFcqVnw07DhIWGBQ?=
 =?us-ascii?Q?sEckhxI72mHlqzHSZRD3BATubncEv+gJohY28AmrQkgv88zE+VJgUnoVm9WC?=
 =?us-ascii?Q?WUcqixIpN+RNDSst2o8NQ44498AGLGGBV/tZ1Q2Dslk9HTWcQ5MWLd5A3/xj?=
 =?us-ascii?Q?aHJWem0p40c+a9iq8HVO/YvLPksqj/1jlhrvMd9dg1qLhP8oUHpJsnY4/g1V?=
 =?us-ascii?Q?E29i8tYTy4Yb5Zy6iMaD4FBc8d5c1SWVf1NTyaxY+SmgTsJdWONrSISfNcDt?=
 =?us-ascii?Q?dWT2Rur7SaxQ+ms318/fby9mL0galOYHkXDybQLsZwwkd4KVwnMCXq+sN4mx?=
 =?us-ascii?Q?3P7fifvPgIb4P/ioPCC/0F/WcTrIEOCqyofaXF4Wbw3yQhwZdHkONx2kqMEF?=
 =?us-ascii?Q?t5OWahuv85zI4OhdfTEhWY3YkLf36GNj46uaJt5pcirxkKJUXfe1HPmd05V3?=
 =?us-ascii?Q?bFwmGLtzEl+xEdgAs4G00jjRrvI6kQBNYquY/VaIhYKNlpenmoVysBZKREqq?=
 =?us-ascii?Q?kY4AprIhN2l3x0bMbdl3e5+CTkuRTUHbYTHQ7QQEAPyK9MxfcSq/kMtOFXFp?=
 =?us-ascii?Q?d4hoYsN0NqMOgq22d1CsuW9d9JGVQuHFhS4TuCvtmUywsNMbIcGrTXTVyp+a?=
 =?us-ascii?Q?L5Wan/Ys5lcBUT69B57drbjyLQGUd+fIG2bdLFC6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28dc91d9-1bad-4e45-663f-08dbd526189b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 06:46:20.0891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m2SOYRG+BhYseO3Gy9iBHNiPi8x1HDDmkXrfwbA/sP1+/dKpPNaCdZAGxwU5difKyxC2QsDmVTE/4NJCN5rtGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8092
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Tuesday, October 24, 2023 11:06 PM
> +
> +static int iommufd_group_do_replace_paging(struct iommufd_group
> *igroup,
> +					   struct iommufd_hw_pagetable
> *hwpt)
> +{
> +	struct iommufd_hw_pagetable *old_hwpt =3D igroup->hwpt;
> +	struct iommufd_device *cur;
> +	int rc;
> +
> +	lockdep_assert_held(&igroup->lock);
> +
> +	if (hwpt_is_paging(old_hwpt) && hwpt->ioas !=3D old_hwpt->ioas) {
> +		list_for_each_entry(cur, &igroup->device_list, group_item) {
> +			rc =3D iopt_table_enforce_dev_resv_regions(
> +				&hwpt->ioas->iopt, cur->dev, NULL);
> +			if (rc)
> +				goto err_unresv;
> +		}

should be:

	if (!hwpt_is_paging(old_hwpt) || hwpt->ioas !=3D old_hwpt->ioas) {
		...
