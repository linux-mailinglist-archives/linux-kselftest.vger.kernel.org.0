Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCCC769055
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 10:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjGaIiW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 04:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjGaIhe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 04:37:34 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B119310D7;
        Mon, 31 Jul 2023 01:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690792444; x=1722328444;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EBtnvixORDeEFv0+Zb199ZvX35REcW76o9wOt0K5WhM=;
  b=NFoJo2hdGph47AQ5F3DZS0y/w1Cnam4w/LbMgFvaDxom68xqszJ+IDvA
   iyWpl6qPRG0hqAxUpCHPG84zMSvADpZiu5GWB5nyc8AKD4HkHxeuDuu9u
   jAtSRUowPP+1OT7q5TtrblueGOE6gGuFv++ygrFPEDCGiarjpZjIfYtRf
   MEqA0JLxPxHEP3IUQOuV3SjT6wGP4IjAkd3Jwc+7XTzD6BSE9uife62nQ
   pC2V3g3JP+9sJgvrJw759n71qll2EqiWTRtXIbo3iO83nrOKRnt48mIN3
   iN4g33N0BjC9ixf9ScPk01c2h3dD4T/xAg4q8g71EuywnzhMDa4PHq5ek
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="371665648"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="371665648"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 01:34:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="721987135"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="721987135"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 31 Jul 2023 01:34:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 01:34:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 01:34:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 01:34:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGCSM/Mv3UW7Ecjlm2zeUFGw/e/KeCI0S9gxTJCU86C2/ij8qG2oPYak6EtJii5fCE6zdfbre3OnYm0KLbGC22UpgAWELVDrEXjlkz/3VEooads5T9tykkHdBbIQHsW3yePCzxH+k82WyHCUbAC3WNgL+p6JDnG6gAlt1aSWcoIf7LJ6e9hNLN97NCaeSiYhdJPVZJ89KW5d3hhlGB5KCFl4yKOZHoJT9Qymwzm/vJ/BXMVrakLg9w+OoCNTQG6FObBOlA4zth0gUfIVV1le+BHjer3DiWic7uRDhGAULxz02b7F7axmT8cyha7oJ8hpkmSVWcoJ/4YFf1t62ew1aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZU1fOR343dMPkjuM0taz0clTnFjocRlye0FIgYIigKQ=;
 b=F5+XB/gp1CUkjUUQfuhA/nIPTbZIMKboprKufb+sLam//BP0cw8I0Nwy1rldcQRsTZkGzSxvW9pK8YI5baICnNRcA5/dB9Iw2M5HJN/Q7tVYEfi5r6kUGxyNdaCzDTMtP0AbR1YnqGYTlPv7HndEDlqqQERWkezJpGMna1k49E7OFaO0UQZ+LkS+uBeu2vcsQkGDsqXCHT19MOseQGA7L25sX5NDMa+rB5sxBNz9prqrOGTqGT39YyqgzaEgHKTAu1+XqJYJ4UOpc4WUrkYvoCRUN5XnmH1c+ry3gk7ZmkLCHBn8zUrcL+PAv6/1GZO23jmEWc/Rsi3I07vR9XggZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB7365.namprd11.prod.outlook.com (2603:10b6:208:423::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 31 Jul
 2023 08:33:56 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e%7]) with mapi id 15.20.6609.032; Mon, 31 Jul 2023
 08:33:55 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v4 2/4] iommu: Add new iommu op to get iommu hardware
 information
Thread-Topic: [PATCH v4 2/4] iommu: Add new iommu op to get iommu hardware
 information
Thread-Index: AQHZvh38uw2j1Ty0jkmb0/Y/kPed8q/NQ+CAgABxL4CABeBmMA==
Date:   Mon, 31 Jul 2023 08:33:55 +0000
Message-ID: <DS0PR11MB7529F6D703B42835B0F8A92FC305A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230724105936.107042-1-yi.l.liu@intel.com>
 <20230724105936.107042-3-yi.l.liu@intel.com>
 <BN9PR11MB527625066E23A1C4968905D68C01A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMKCd5S9VpNGf631@nvidia.com>
In-Reply-To: <ZMKCd5S9VpNGf631@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|IA1PR11MB7365:EE_
x-ms-office365-filtering-correlation-id: aff63c82-b872-4817-faf3-08db91a0e098
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 914e9aS1P0vJKdJgshhGU9x5gwMSLxV2wFzFj4QKX8Rt7A5ZAue4pB0LpLizIF0kMzV7/lk0NjDhGSAtNx19+dFKgsBB3ZXscKrxKW9pf3hT3y+W8H4lnwAT9r0QKLkraFgjR7ITWiGw8SpYUBIJZRtwOJj9pIRAEWi1KlXY/rg15W8+jmGbpgXsM46+8mJddcn5t4Z44qs0yGQjn45gpmju8DVyA/EC6FSXodNJADtBjI9kTpl+Ohc6GdOM2xcOkq33Q4jorBeXOLQom9PTzp9mmNok4JeGXxOniNDi2lmZPBL+L5aMoZ+A8b2PICJZPC8ZEXzrouL3nqJBJ438l7XxEzQsKidg4NwvouR7XyTRYOAyTVn7U7Z0htBKIoFYqHa7PU5ojomzZ8RLnPTGhgroj4QI74UYjwoLb6krxEHvNA3zYyAT7D0Wmx+BZLeB6iQsb5uPD4qxRprcWoSRceKTuiYH90wG7WZJkBkNtgyrlBYfid8i8SwsfmP8pOwn+Pa53gMW9Lc6jboVe/16hRKufWC5sZ6z664YsHMyToqM6ia7pYQz/nVS88AhCshhZ0llUt0w6AEf88ywoZ/Ny70KHgUlM06SlfccqKTYJ9V3IasaAYgy8+iFmEURPoj9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199021)(5660300002)(66476007)(7416002)(8676002)(8936002)(41300700001)(316002)(76116006)(2906002)(54906003)(110136005)(478600001)(9686003)(71200400001)(186003)(7696005)(6506007)(26005)(66446008)(66946007)(64756008)(4326008)(66556008)(6636002)(83380400001)(55016003)(33656002)(52536014)(38070700005)(122000001)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4G7G+DwJ3HFAXT3J5OT6PY84EWBlUmR0a1aVwMytm339EorXLfOp9d/a63jv?=
 =?us-ascii?Q?10fZtKq70AiMRoaPbuLk8IKUKkAJf4Rzr68oo8fcfNFy3Js4811f72ev7E2t?=
 =?us-ascii?Q?jO7uKP1x+VmCIBD+/kCwu9yaUeFWSrxcLgzqjwefnN3pPKyu2YGHhoYra+kn?=
 =?us-ascii?Q?LRzGcjLQfWxwKjZTR5z+n6Jkkx7X0h7PB7eRqfzG01QPkyWKuEOtn6UJoM+a?=
 =?us-ascii?Q?zwyceAPONLOpdPVv+gRqsZ9wZTIXPatxWFwkr4JSwT4DFgtfUm+/lw5A4AeF?=
 =?us-ascii?Q?jQY/RFfx1viQED9VfubtLkvjboMvkecZa2c1/p/2Y1L9btddBT3hiPHVp02M?=
 =?us-ascii?Q?iiyh8BoxBUh4ykR3GF5ZusKed2UL4YGcaApdU79ZYyObsc5XqQOMH+oVS5SQ?=
 =?us-ascii?Q?TcqMW4POFmk+zse2oBjCUiMODDL9qy6/6O2a2lovPkArS00Tpo8Jzbr9bUy+?=
 =?us-ascii?Q?CCntBETdmBqCMKhpd2YsNJSICzYgQs2G/t53hn3b0tXDNIwUsKKnAo0KM+/M?=
 =?us-ascii?Q?vNvSVwozOnW9Dr39XoMR5lP+Yn7ddWqlo8f3gm8j7qFLJrltddLCN8KKn/JI?=
 =?us-ascii?Q?1BqEI5LuY2KxfMdKTPpEOnTnGzruTXDfUYzMcxNhKV7bb4m0Ia/RPAP52SgG?=
 =?us-ascii?Q?MsSmC6pP79t0R/z/n7ZtL565WCl9AQ3pI0z0aJ8zSq8XEQ5mq2u8U85ftuYy?=
 =?us-ascii?Q?BYHrE5Q6GD06vZeCt2NQaQFvN2Fh+eWfS9rXCLrpMXYiUy3r9kzlR9gcoYt2?=
 =?us-ascii?Q?L3nGL0k21QUGX/RHyC4YBAiCeUAmhb2JK9onC9pDQziIYRWfbEx//DaCCSXy?=
 =?us-ascii?Q?7fuzgB2Vxuj6mpEP74R9IDIz5BZ2uaklp+E1JM5VQTOR5BLUyVaYRYOvsLNG?=
 =?us-ascii?Q?hX7lSA96oJUzgjo7/V/OqBfRyFBdbi492AP5MycoFNLUicd+2Yq9ZM0iAYrs?=
 =?us-ascii?Q?xlPUHqHXOj5rRxEjMmWeTW+tpHHpl5FIPt8i5+PAo34EzK2zT15Ty4neU01p?=
 =?us-ascii?Q?RYqF4Xyj/coOQ7bliUL2Qab8ksG0rCRtl/b1lTPKvok6EaT4bVyjO+n73TN7?=
 =?us-ascii?Q?ogrmmymS1JZyEYcrRYt6XTnu7X61a51C8HKG0+YK8rGGmZ4NRufrIaDCCZ+Y?=
 =?us-ascii?Q?+99KhTGqZrUWX2Mwo05xyrtSVfG41+x5WWdLq1V8Zbx3y2aRdeUU1iVVZvlj?=
 =?us-ascii?Q?q81mgXWXxvjhP6WBov1QnegvTxxtpNTcpvaD0VxB6M56xO89cizf9Uypvu7p?=
 =?us-ascii?Q?kZhunfRKMUuIhVf2Oi3eAOcqaEdwdVfDVm/N/saNabjqmyozbRc78QzFabYE?=
 =?us-ascii?Q?X/InlMUq3I64XWBiRTcSeeFPzBzd5qxdDkgZtc3625xmj8sjqLwV86M8fhhY?=
 =?us-ascii?Q?27H/0sJH79LoekPnTqx7LKloh4cqaD0M67xKRYbm43JjikS0pSOwCZCVTz9v?=
 =?us-ascii?Q?UQRJzRMFB+WJYCF01zv0yDa5Wh4LmQavtbCgb+oOuWJzT9WteEshy+4uyOJY?=
 =?us-ascii?Q?EwTd8BRowI7zmCSS5frC1FH/Aoav9MO+IPBSxk8o8kuVc3EX1xWsuaQHsGaO?=
 =?us-ascii?Q?3utt7DpjpX/xHEaCMFoaiJOdAodUQqQgy2Z9WM16?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff63c82-b872-4817-faf3-08db91a0e098
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 08:33:55.1678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HriU+uutuoHOaqwbGuOL5JqtRHJGMQm9nH9joBJrQdxzquMdrF44y3GRChHM25fFM2CO7C/qWqJiYbZuP3r7eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7365
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, July 27, 2023 10:43 PM
>=20
> On Thu, Jul 27, 2023 at 07:57:57AM +0000, Tian, Kevin wrote:
> > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > Sent: Monday, July 24, 2023 7:00 PM
> > >
> > > @@ -252,11 +258,20 @@ struct iommu_iotlb_gather {
> > >   * @remove_dev_pasid: Remove any translation configurations of a spe=
cific
> > >   *                    pasid, so that any DMA transactions with this =
pasid
> > >   *                    will be blocked by the hardware.
> > > + * @hw_info_type: One of enum iommu_hw_info_type defined in
> > > + *                include/uapi/linux/iommufd.h. It is used to tag th=
e type
> > > + *                of data returned by .hw_info callback. The drivers=
 that
> > > + *                support .hw_info callback should define a unique t=
ype
> > > + *                in include/uapi/linux/iommufd.h. For the drivers t=
hat do
> > > + *                not implement .hw_info callback, this field is
> > > + *                IOMMU_HW_INFO_TYPE_NONE which is 0. Hence, such dr=
ivers
> > > + *                do not need to care this field.
> >
> > every time looking at this field the same question came out why it is r=
equired
> > (and looks I forgot your previous response).
> >

The major reason is that not every driver implements the hw_info
callback.

> > e.g. why cannot the type be returned in @hw_info():
> >
> > 	void *(*hw_info)(struct device *dev, u32 *length, int *type);
>=20
> u32 *type
>=20
> > NULL callback implies IOMMU_HW_INFO_TYPE_NONE.
>=20
> If every one of these queries has its own type it makes sense
>=20
> Though, is it not possible that we can have a type for the entire
> driver?

Not quite sure if I got your point. Is it acceptable to define the
callabck in the current version? or Kevin's suggestion makes
more sense?

Regards,
Yi Liu
