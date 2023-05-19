Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662327093CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 11:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjESJj3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 05:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjESJjI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 05:39:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AD7268D;
        Fri, 19 May 2023 02:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684489070; x=1716025070;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y77eJ7Ux5fL394oMCz97yFURVDCHyqMyUm4cJWqwyYA=;
  b=T7CYUdBC8qTak4XOJdexz2UrG+CqAOCl1q5drDvoX7QTHXqLEFPk41c7
   GD9UCiVDjLou2ehluwEOfXBiT5RlHLnEvcIprcAShdHGm9PtSLNw3rIP6
   qnxTHF4GVHWqlv5Mj6yqfXO1JmeU0Trt8OLinxPA/2ml7SevuqTKbYriw
   a3RiJQusfwz9IiQVwOVmBI+olqccwhvwRuI8eh7O+uOzd4Mi5tOMfTRtv
   GgGmyGRGpt9Un8F4wUpVrY7X+Of2H0ayyWSdcTU54YT1tMaptmW562OCV
   2ctzDINIt0HDMjd5k9q21HZ4Hyjubsf1N75Z3IulstYst90r7yrkHZoEu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="355555001"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="355555001"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 02:34:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="876786808"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="876786808"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 19 May 2023 02:34:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 02:34:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 02:34:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 19 May 2023 02:34:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 19 May 2023 02:34:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJlSbiGvWe6VS0llI6AIYMX7jDvGcob23AnAulBGva5DDb27CgTe43DoHnNq0NRvG9qtCE2ggyON4WY1jXKSM2GBhnbHbE6dAvFEDhNCpyY76M8wR0MlTloU2cywRqmm8veX8ebvAcQGg810rP+UWHjLA31oOedAx76++TfKWFicMAqVf5AfWQ9iM3mygosIjrpDhDxL0XcebN7OGcmcsN9k6AaUaHHWpVFTcc1c5ojdIeRaaN+Pa24tTd6ikIVRtCztbVV1uIL0RzVa9+5Eet/V3nL9Uu0CRHkIPLJTYKzs4e1Yv51J5g7uIGR1XJPO2YkF7dIIjd7hcEwbz2OYjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSxN5JAwJsJk7RwluF4hFZLvhcNk3uLfw87G6RJ84Rw=;
 b=gGKD6I/skRLQSuFoxS66/GgHVruA1sK+TC8TJ14Jbeirc27V0o0F+VoPrq7ubF0Psb86slNE8uJpehiqyZpdAkaKuZvxhK5wTTJ0f7P7aiEPJoVWcDE5C4qG6gYvsJmIOkcJYSqNRAnp3Dgs5eNFn3FBfRZcoQRFUGfOHoxz57Oxwy+2DYOz4Ds+thxLccUxFeNxBLIMpUFYpDdn9q40ahgqVpKRRQsIMY/iujGdNrr50zgbgVNL/L2qujOZ84e0qmDZ/IyMxEs1jO4v6jnVOPTEu7mxURjT1KjP57JcxF5fd6uarwuxzhBFO+OzY6gUGF5vZgFynccfts92gFZCIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB8131.namprd11.prod.outlook.com (2603:10b6:8:190::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 09:34:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 09:34:38 +0000
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v2 04/11] iommufd: Pass parent hwpt and user_data to
 iommufd_hw_pagetable_alloc()
Thread-Topic: [PATCH v2 04/11] iommufd: Pass parent hwpt and user_data to
 iommufd_hw_pagetable_alloc()
Thread-Index: AQHZhBZVjU0+oTnptEmcGUc2PW+bOK9hYeOA
Date:   Fri, 19 May 2023 09:34:38 +0000
Message-ID: <BN9PR11MB52764DEA24B824F640FA0CD58C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-5-yi.l.liu@intel.com>
In-Reply-To: <20230511143844.22693-5-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB8131:EE_
x-ms-office365-filtering-correlation-id: 74336dfe-8ce7-4401-0331-08db584c43fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kdZveEn7TY2BM0Dl17d2jtspzqyQ5QFRmgI5SAE09Zzjb/ivez4q3x5oOcfUQYCRk/Zi0/R0a4zo9DpFF/K5tA2Qa2bzcMrnJMq+X505Ch0mK45lfgEBVhoNV3LUBeJeTBssJqMgeLoRJspRu+sviJRAT8rCYqsdyXOBwGXa3Kg+vnlfo3idqzLRxr4e4HAIXNEkh1l73j0IZcTJqUFQjc58/dEoAH/AVm+R/gkHL4zuZcPDyT3lCl7h3vWkRCZfEjd6fp6QnaEu6XkW6IoN23SBz4w0ge1hGZuV6nNdJIg5bS0f4Atu0Y2kUS/lf7n3DoemGDQhLM3QTYieijx6c3xwpckFMgTGx9SapNuXt7H7K2SnUFlxHIDXdQBUqNDROWo2DZzFFtIUGYRbXTBGeyA/b6jgf6JDqztv+tIuaRclWZLxP6DLrNSBHrXmb/SPUfmPAJqYmaUFH1xJgrmVi4+3yqpLW5PEiXUfUsRzE4DwExx8U/iK2t+Hj6t5z1ISZcTcpduTHy6KzFRSS7TVP9MO198A/qrx1nHpE9RgvsYG7r5CUvYo0kWvEeZSxVz8V2pXU8NCtrEHMIrZIyldrjKZ8VBoDlbt6rFtboCnTzJmIv7NLdB00cXUKKkSwGsi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199021)(66476007)(64756008)(7696005)(66446008)(76116006)(66946007)(66556008)(4326008)(110136005)(316002)(478600001)(54906003)(71200400001)(41300700001)(5660300002)(186003)(33656002)(26005)(8676002)(7416002)(52536014)(9686003)(6506007)(8936002)(55016003)(2906002)(4744005)(38070700005)(82960400001)(38100700002)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?75X3yzkG2Dj3WCsrYXSF/ZoCOPVjqN2kDcPcxuFCqxBE9yg3CxGaS8c8eVPK?=
 =?us-ascii?Q?E0wJWglJKY2BaIRFzpX04u1hB5G1dlcl8NC03BUZjN57XokibposvlboQuu7?=
 =?us-ascii?Q?skH5nVBmzkvNYdsvUFmiUxU0cHR36ZO3bR1rlmp3H8v+9q9HjF0Vre8l0tZg?=
 =?us-ascii?Q?Wp2X6taWkb/MYFnxyjLrfVMmNnzURBJU5neYL9Y+qP9iRig0dfK4Twqy35YP?=
 =?us-ascii?Q?ihDfLqYPztcn3rdjaQzDqYvZkvMXqcRV9Pv3Wwy/FuJ0mUd9E6V7Jhme9U7t?=
 =?us-ascii?Q?W+0esdluaKAuQ1/llpFmefRFvXyqZapEnWl7TxWP680CMN8opy6j6FJJx1lG?=
 =?us-ascii?Q?qOQMNVJzZFZkPn3GjjV0qFusf7S8eRqr9VnyaKN6v12NEwFAu00GHmLY+aPS?=
 =?us-ascii?Q?ib1WGKpDssQM4E7z78tiSc409MO0tdYrDr3pIFRbNCqVWuVdRvFZdZOheirB?=
 =?us-ascii?Q?RkS9vdYyob01I01arQAp4Vuc68HngOe95+DLP60YGVm3HoY5eUavrljlSBSK?=
 =?us-ascii?Q?uRb40kczrNe90KjsD5nelbAPZENn7f5Lv5WHmj93B71l0PmjDzbnd0dphmrS?=
 =?us-ascii?Q?+d7/W+wTx4/zhVrL1F3TVTx8/zineWHXtFetzP2flwnZxiOoK2xOhxXjG4AH?=
 =?us-ascii?Q?c4bH58yYfz2rtb8olUOS3PFtxkauQdmJ+8m1aDHyAhU87vq4gB7uecG4IdTC?=
 =?us-ascii?Q?4NYrwFxD3bq6Iwd5Eb4UnxwYTEvC5BmIs9Kk/h3L4aHdEsDwxdqamssVcGSo?=
 =?us-ascii?Q?Bazfs7yGNoCDi4m81kYarb/8Z3MBdIBjHx5b7WkEQEjtmBzLUW8DVexestUl?=
 =?us-ascii?Q?HllKaYFwmMQhp5mC1va7RgpKxLT9a1L8/QUWYXiveHYI+gSqNDiGtMlcxpdk?=
 =?us-ascii?Q?yhMvIAh6v9YTeqFlzMilQUZY6+fi5CswMowzxdRfRZQDvPENus1Hlilsr+Qn?=
 =?us-ascii?Q?Sq3ZPBoFmMoKyHsAH5/8QFw66tV9vFvbAM9XsGaCMDcdDszH5Z5U0QIcZX/5?=
 =?us-ascii?Q?nzc7P9bqhyrZrlypmJT8mjZ+5hD2kTAIBljUWK6evqrd9t9GwS5XzX552WSx?=
 =?us-ascii?Q?+lF5XTtlZtVV8l3LuiLDMJhPZaLgRgFX+T7kalHl/Wo+dh+78lR1ISvTOKUP?=
 =?us-ascii?Q?MzNIMwICdxygr+R7e+WykT8IYm9kik6ShRuXMJYAvlHNLgGOYCtWzyp/Htnb?=
 =?us-ascii?Q?C9lXsUz6t2zbFO9RfvuRWyajhwqGI2kaAiNzD8vqVA66O5DGiO7yGYQ87xzG?=
 =?us-ascii?Q?VmFLSKT4Pi5XAc9r1BWpzYnqNU0PmnIvH3tqYWSXiW0kZtF5tI3HYuME5KG+?=
 =?us-ascii?Q?eSBeHDNL6YHISuvKS07EkgEGdYv2YO/5xij2gW/rCDylytmmuz7z9jjtejSM?=
 =?us-ascii?Q?xm7+GC0VExyAefhnU4IgKSlm4k0zuCZ36ZA+bvYXNXERPzFXs8NaHLWkxNOa?=
 =?us-ascii?Q?UtrQtpudIqWxfpZ0HoB20s+X3wqk0/M+1gpvZUqyVYSp0x/FCakYmbT0npvE?=
 =?us-ascii?Q?L0ebNYh10L7QF/Xyu3iq7IHR3fpMYWWSt8IxNZP2aI6NR+3CRm8D1BQIGD9B?=
 =?us-ascii?Q?i8mxMlluRMbjEA20IUdrEHEKdpw0ocZBNzhA0sy8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74336dfe-8ce7-4401-0331-08db584c43fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 09:34:38.4184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oqFrZa2ltdnSOsi1Pw6Fk6yYsHlczY4sfLc/jFzm31OhpZthh9NAkQNqEtJLKbge2isg9WIxIJjw6z9o4x7tWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8131
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, May 11, 2023 10:39 PM
> @@ -89,9 +101,15 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx
> *ictx, struct iommufd_ioas *ioas,
>  	/* Pairs with iommufd_hw_pagetable_destroy() */
>  	refcount_inc(&ioas->obj.users);
>  	hwpt->ioas =3D ioas;

presumably a user hwpt doesn't need store ioas?
