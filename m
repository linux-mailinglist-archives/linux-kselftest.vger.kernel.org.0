Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224C769193D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 08:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjBJHc6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 02:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjBJHc5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 02:32:57 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5109C1E1D9;
        Thu,  9 Feb 2023 23:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676014376; x=1707550376;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r5HjtV02JBkQZ+21VeeyJZ6m2UZhDlxnNe1IrG1StlI=;
  b=XVAdq474+M1m12SOCrOCUHBwShn0lIoJiIcyHhtyREMc+zS5IDwgptqM
   6cDDerbDnNQQ6wKqCnp2zDVw4dyTT8U+/zOp1lepa9aRvb7fcDQsagwaR
   uf4yWAsboD8POimP37JoIGwERWcXSGDT26/YIUEDCF5FfRGp6l4J4K/V8
   06IhcK2QgBGMtKc8+785Ca95uLBIXP7rNCuLLqdzxZW6CjY9BZt+URtqE
   uKoZUJF8IOGxT85RVD16rnsUctNRRko/FR1x+1ybA92Cb8F6Eh6kNk3Kk
   1vz/ckqxmQwHfFW1VexpS4BbjVc8ui6U+2Yd8vC43FHTpMf5NOVngW+QL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="331662663"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="331662663"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 23:32:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="731643201"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="731643201"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 09 Feb 2023 23:32:54 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 23:32:54 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 23:32:54 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 23:32:54 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 23:32:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0+blaxSgrW2Q3SskExGza94uipUavqhnadvK/tle1eKetNtJxKX+tdPJrfbTxRIoHAHELarZTG+4bCsbbhJI75Ktkcb6NnK8wnxvdFVDlptgHl1Ug8XyKhtT8tefS6ztbXkTaGF3BTHNWoeEvtPxGyrhWgatov9gSUi5pumliPArSyXJ/+r+M8NvPZ+0vgy926fvqqWALI/PE0SvlCanenS14vSQ0IscOSOZnvyU6wDohkV5NAnIL1epiWONLxnPbi+mm9vMOzZF89RU2/32Jjoz8pTA/BRQr9c1F0OHlOXjatWLWWWno55Cw7FWRXhBHj3GC6Z2eiHNsDPsT8hEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0k8BXKAimhZLDUwinJa0hQUtcRw5iA9Os981jN/5no=;
 b=Ebw+fUHYmf2BWmwbo73OQ1zA7R7nQSjo0rnJsTpV1yBu0iEz+/Q2NF/t/MxrHjbRjcfHy3Tw0K/0YSAm/k9rCJJisbVmHLfnc4k7uAYzI6SNKgsODn20Zcp7c9f3kTlBID8xUonyZ0qIL4HTDUp+0ry0juDgF+Pk5QcV0G9bsDpIuDil6rM1X8VnanvCLylRf30A6JMSXERm6BnXPwe2U/t8KmFDzPXaoWf07tI/fjcfO+0+pF+OMn5gJr1xTS4GUF6hdZqJRTZycA4JXBxs1XH8NwV55fEmSEOnwYYZK4OHu54+4pfrqJO9DZOIj5dCyKugAHPIask7AAYp5ubuig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB8105.namprd11.prod.outlook.com (2603:10b6:510:254::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 07:32:51 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 07:32:50 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
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
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH 2/6] iommu/vt-d: Implement hw_info for iommu capability
 query
Thread-Topic: [PATCH 2/6] iommu/vt-d: Implement hw_info for iommu capability
 query
Thread-Index: AQHZPD1a9yG3+uA/9kqOKFY1a3cV2a7HyhmQ
Date:   Fri, 10 Feb 2023 07:32:50 +0000
Message-ID: <BN9PR11MB52763CA91E0D9C0D26000E328CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230209041642.9346-1-yi.l.liu@intel.com>
 <20230209041642.9346-3-yi.l.liu@intel.com>
In-Reply-To: <20230209041642.9346-3-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB8105:EE_
x-ms-office365-filtering-correlation-id: f2e74c99-a863-4dc0-b4c8-08db0b3903ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QXu7pFOc6wofZ6gJMb7Qcb5e65T1yqPQbDy+RcrgK3hpVx2lZEm8rt/MhPvE9NNOQMGyAUi/qd5OwMIP+wgzR9T+P8zYEXldGzbodFP2S16YVASl49D1kBi2xfL1POtXRzqJ5rR5Yl8QFYw5NG10roDw+p9waA0RgUsLKfwtL3NrystwPJ3Phy/9NcpfACrN56b3Il7eGirvtK/gjhyeZ+5SPXIrIZvbv1jzw6z1baghkuSc0l1/+WdFHJRORFO1aG2Wm6rEB8mG8Kybnp6LWN8LsInAZKgxqRATMCAy2/5vbcrA+d8Z3sHo6Dk+2GET88hatt5/q55CReVF5JJzj1chPB5Yak3/rIPW3dJ20Fj98A3VlR7vHm6vx7BXwQnDN8t1CtL/8F9cq63qPtfaeNljVz8DzQWFRvWPvYK+p+CF/hmmQwvFFRS0CM7Mrebx/XZVcJs12/oYTvLRfzTwAnoIjoj+0p6FJiIcuG+9FXYRRpuRyJ4ZwP8wENJvRjI8VRdUt2iQhvLRagTlWuIZB0G7q3sfulIZroV4n3onyNP6L40/4i4oiLMMOls9Fgr+JF8BnR8mvnnjWhqXhJiaaY/8My/dNZAUHqbzaPyVqDZVSYeLy5xJ1nWEHjK2jy0YDDgcpxX6WqH8pQ9oXO7jX8TT+rLSNpBj5mtu72iv6ADrXsIIfMnE+miVoXV49AtWRG7B9TBXmzmdT3KSBmQQKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199018)(4744005)(5660300002)(7416002)(41300700001)(52536014)(8936002)(122000001)(38100700002)(82960400001)(33656002)(86362001)(38070700005)(55016003)(2906002)(26005)(186003)(71200400001)(54906003)(110136005)(316002)(9686003)(478600001)(7696005)(6506007)(66556008)(66476007)(64756008)(66446008)(66946007)(76116006)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0t2hRUExkAAMAMpdb8ykxRmLELu757oOQWUuxVDPQA+zTLdlbSS5afaN2ooI?=
 =?us-ascii?Q?N3Rhu7IEHTlueTlGGc3vifssw/S4jF1sk44A0wS6yPkl6f7w+UgEcKuApH6n?=
 =?us-ascii?Q?UFTB2NnPAtbwqX5ZtkQF4fo8eUiuV/bC7KbQKXOhkidOhYcu7ez4/Y0gxVw0?=
 =?us-ascii?Q?y+XeJaARdpb1eDl9N1ujU+bRouAXcOrWEjuEbrY/q05/9c+AnhJsvNWiDLRm?=
 =?us-ascii?Q?DhaY7FpscVjB4i5NoT3gYFZjbuxPi+3EHLlNmwGZTHfmU3S/qyblISS3ivbU?=
 =?us-ascii?Q?6ksgx7KkzjGo9D62Dv2FEhz/HVMbYbJ++BsXa25yk5alI/k3A+EoXRJk50O0?=
 =?us-ascii?Q?23+gpjCIzGLa1iUNg7kxvbprzAvQAS0vixVNO0v8Nj85D4BwrWNeQk6a+dkX?=
 =?us-ascii?Q?Ci1+wFwUVVudUGTNazabBcEgtvV1CL6MDYSCLHI3NJ8TNs8rIYHEBOZOEsGP?=
 =?us-ascii?Q?zrlcFUjtZyWSN4ibfl0DMNJrW8THokBsqYm02XknV60sJD6aNTZ7CD4kKVtV?=
 =?us-ascii?Q?sVi0YBBWeeEVdl9c53iUiV+aexRjXHoWKQdf7/gYucxJdmzjljyMlRPYQyao?=
 =?us-ascii?Q?7oZYhLAHlduWZfeTw3MJLogDE2D3FzmgjZXuPcZBtw2pwzTJ6o2FLhcj68zu?=
 =?us-ascii?Q?espuLKrJ5PHMJhXIEm5LUfJPPEdXl6QotxiKoT5Vfm/DQ9ymVF7l5fu3ofkB?=
 =?us-ascii?Q?oIOLoix4fjQxwooH/Cukjkml9JHcl+N1V1q0eb/+keYNW/Y+Fc8ebKZ8E7DC?=
 =?us-ascii?Q?wLQMJAwXGMbkli6EFU/gvZ9JvWOPW3xDvYx8jffUNZdue4pRtmr0n29iCy8I?=
 =?us-ascii?Q?9z2IJ/8Cu4yHP9Np+vFm/LNzE9rDea4oURc6LWi4pHh5CqapJgy3dYis86eJ?=
 =?us-ascii?Q?+TVTtgLxR9aXFUlLHJQ2ThbaNDnmmCySuhYyy2fY+hcWhLe0wRCh4zGkQyRO?=
 =?us-ascii?Q?3xQAS9vbcRBWOmediJLmAa3WYHAha+iz0uZzrQsuceD70oB1sBS04pJDuAR4?=
 =?us-ascii?Q?Qix8Vbqgk5tWkzZa3ySpsvANMJAmip4JYXeIzkbmcfBRnbKfxHVYw/tL78rD?=
 =?us-ascii?Q?ARcTtFFHq20fFwteue8za1LW5p6VLgmAGp6l9V+MxjaS5zqoqNHC0wFwon1+?=
 =?us-ascii?Q?+pGHIZHmkhWqtsRIKUqnC0wZmGHwytPGp1HjM8xjn2yubagwH+7c/idcI4Ds?=
 =?us-ascii?Q?lmLmO1zjnTXVxcdfK++Y3RNcUtZW0RHcRGJNLXft/kObs0w4uJNM59AnBEA6?=
 =?us-ascii?Q?JvuC64u4otKCXXO39YsOzaXtBwQPmghzJBRKglMbqn6JlrklfESro1GZGWMS?=
 =?us-ascii?Q?hEbJI/m2Gob0euXeqnUSTkYQyYNVUTJqPtf7QvG57a0pcg7P3VGqSw6Ixsvd?=
 =?us-ascii?Q?ABPBI6AXLJQwhGBkXG/7L673jiZLJCPyx9C1MdFXmctqsZsdOdEs6/wDcSV8?=
 =?us-ascii?Q?tPi+ylgSEN8xNKDl/N4/hT9PmbgJhY7Z84OgcE9MSDDZ1nBnViMbgACZc2a+?=
 =?us-ascii?Q?iI7rY4ndpE35O77ZzhcuNs8yUs/4g+PRQfA/E2LWIRaUWR+HhJHabTo2sEE4?=
 =?us-ascii?Q?tXPsjn1XgguNri8zcG6bTYuTzgUsNqGNCxNuz7Yp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e74c99-a863-4dc0-b4c8-08db0b3903ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 07:32:50.5567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NjRH/LVFXN0fElTYvNeJ9AGrCJuXLfmcFOXxAlDiyS2RJazTknQUV5xcw83BDz4TZsHhTqo2jli/rr4CCvLXmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8105
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
> Sent: Thursday, February 9, 2023 12:17 PM
>=20
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> To support nested translation in the userspace, it should check the
> underlying hardware information for the capabilities.

remove this sentence. that belongs to next patch.

> +
> +/**
> + * struct iommu_device_info_vtd - Intel VT-d device info
> + *
> + * @flags: Must be set to 0
> + * @__reserved: Must be 0
> + * @cap_reg: Value of Intel VT-d capability register defined in chapter
> + *	     11.4.2 of Intel VT-d spec.
> + * @ecap_reg: Value of Intel VT-d capability register defined in chapter
> + *	     11.4.3 of Intel VT-d spec.

let's be specific with section name e.g. "11.4.2 Capability Register" so if
the chapter index is changed later people can still know where to look
at.

> + *
> + * Intel hardware iommu capability.

duplicated with the first line "Intel VT-d device info"

