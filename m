Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9524F7AE519
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 07:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbjIZFds (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 01:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjIZFdq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 01:33:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EE2D7;
        Mon, 25 Sep 2023 22:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695706420; x=1727242420;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zeYcsgdQMv73tIjwrFi2EpDLxrjapyRb74ot7ktYicU=;
  b=nrv/DLp7AQWmfPuB0/2OSHMbQ0+3K2U3KEKnkoVBJibZjr5QTpzMYT1O
   BhJqldp79BGGNukBVG8pP8lPmxJ2orOyjlw21yA7IrCqMj6Q37YRETcwD
   z7WtnIXm7N2YXOKPxbvY+GZz1a5nFCyGY+Jj7QM8Rqw3KOE9UXzEaUIZt
   8lncnxpJedB29Ju5A6OCQZ5r+1k5PFn8yYHOxsr1Wmgsz2LsV5ZhaDRTb
   sGw+XpBzoSROuSKm8f2FPF7vP717Drk5Flm/GyjtTqnFgCRzzHiqDdD+Q
   o1UxwPvUW9bfJbxOjpPr1WGfz4fw2IekivAKjZjOlpp38ExQPvzcIw9DH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="384267507"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="384267507"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 22:33:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="864280710"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="864280710"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 22:33:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 22:33:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 22:33:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 22:33:37 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 22:33:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3cgWKqYUHGFHYryUs7XzM9YEiJw/+Ndmu/ODVlxygapvegDGD0q3rqurClG5Tboo9kytx6ov9zOUiQhfEu72Mza4qfvwBun2PKyaYnhhj71evrSAFVvzIu2CuHMcFz0L1TJY1APqf47ScJpEbTe1ngUvX+JmqwnNz2u382xKUnFVk54/LvSgHv+xo5OSjU0zZfGcud6wP3END+lFNL3W9DH7NEJOWfOSea/NPqRGmHSWg9pFJcrdeBUfvZAMQ6FAcrsvjKt1ioWvJM+AUfPj1a6uaAl7D/Ikkzpc+Yn42aB/CNrPVIW1nS/C6B+lZrfRV/kiOT4O5BloYEqFacqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIMDeWU92tbx+q+kmVeA78l8LkQYC9wvIkbwnY1fc3s=;
 b=MAfc7Y9c4tHsgsdhUT7/bUBpSZQGgNI0ZgtnzvLrvEVMktkKBHi0CQR3TUaMAhNNsWk926YKELQzwtoRpAGZAvR9OjEcAgOgRyen7y83IxBXoqBf6Pz8GdSK4o3wTJJHWgrCRamMDkuVE0T5tmTLUHOuWORUsDsY/7qEUlgY7WMNu40OfMLCktbEIpps2t3H8WDn8B8zpmP0MTiPq6X6rYBRZS2+7z8ZeeKwkpeXjFdzmMe/Znw7fo9r8QJaVDDCp25fuj7/8RKY5OLfGeUc82NLUenYmFY4UA2Nv/TlbQm+IUbx1imYJa/CiGgLqz1LvwxZsOOKr5IoEXYGkiDA3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7339.namprd11.prod.outlook.com (2603:10b6:930:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 05:33:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 05:33:29 +0000
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
Subject: RE: [PATCH 5/6] iommufd/selftest: Add domain_alloc_user() support in
 iommu mock
Thread-Topic: [PATCH 5/6] iommufd/selftest: Add domain_alloc_user() support in
 iommu mock
Thread-Index: AQHZ6ttV/g1CXLu7bki1yXEe1xeP7LAsoA7A
Date:   Tue, 26 Sep 2023 05:33:29 +0000
Message-ID: <BN9PR11MB5276119BF0D036AFAA936A0B8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230919092523.39286-1-yi.l.liu@intel.com>
 <20230919092523.39286-6-yi.l.liu@intel.com>
In-Reply-To: <20230919092523.39286-6-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7339:EE_
x-ms-office365-filtering-correlation-id: fb666f40-da2b-470d-5012-08dbbe521d45
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PtcGvEYIBYe8Ds0VSyNtyXcXYsYeX4FNGdOCEGQd+uj6JFkHmxaHu8ry7WgI84VMw7RsSC35Di2IieqPGYPPLTsET217Dc2ncnDeS3kP+Zko8/BwIBuTMnuEUE2eQAvX0u1HGfP5yNNnUUTCSZBEGrSzDPJDB6bPvvce5O8W/UZp2ewT9Q9O7Q63R7ItXzRnIlM6ELu5LCNJB+/5OSLILRto7wwIT/ON766BALCrZP1dv8y2RKeupLEmkI1jJNCPqs5fI53alYFvAWzDEA1QhkFZ5xL4+OYGqlio4+ViyfuJAZKOfjr5ezUoZEg2FdcpbYAgcJOwsIC0i91W2j8H0mUhGisiacYxcEXcog3jjv4jwtWqUy3zwDeU+xlX0s80WZwAiGyrkmI9eW3aWyz7aU5nNDXUoWY+5JGi7jxladWlHhsvuL5CfzaKJ+PNiQmm1fzTs954//EXGLm66ZUfQ3W1e+cJOCzt3jzEhiQMvuSJaF73+DCAQe8A9nZPEYLTy4Y21siQylD0OwbUZxgCi3qy6eGAsnq0n5IDjMiSt3G6dY5orwD+/YYwej9xBoGQGwgLzICkJLBrrqg1MeSdpbanGhX+oGrqAQzvlUfGvuKFFtRpWF44HUV3NbHhnwm/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(86362001)(38070700005)(8936002)(8676002)(38100700002)(52536014)(4326008)(5660300002)(64756008)(76116006)(66476007)(66556008)(54906003)(110136005)(41300700001)(66446008)(316002)(2906002)(7416002)(33656002)(66946007)(4744005)(83380400001)(478600001)(55016003)(122000001)(9686003)(82960400001)(26005)(7696005)(71200400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4NO8bMnrP3hMYfInLB9+Ew6QKmN1QztCJnc8wjRobYhKK/STf4RdpZ0OtghY?=
 =?us-ascii?Q?1dRCHFBA9gtBMeE+/j2ciDiG9T0XasDffpUNpaWDOxaPNbegAU8pKlIBbCvR?=
 =?us-ascii?Q?nC+VZBK8H2YckLjxrBbsH3UcOvzWvBEgwNPE0KxfyM9ZCAGOSjwITEsdioax?=
 =?us-ascii?Q?fC4yIO6sl1UqLFb0HleRN6M1Ty+Gd6D5xqqrVnVmusQW9ndioZtEPocwdgen?=
 =?us-ascii?Q?Aq3xVoY5iHluvEw6OHcPbJX5Hhce7UVttMY1A2mj7ieeKyz72SgXkXNSvmbI?=
 =?us-ascii?Q?t/ITggIRWC9u5YQFOSFXxh2dAlcECAXWNNOJ1Le8j/5tNWc4EUmU2ctzAZQu?=
 =?us-ascii?Q?nVYmrq65TOh4mlgnYIodPFstIKVbMBpxB9VMxe0Hnd77Bz3G2t+VqhVl5Shg?=
 =?us-ascii?Q?64FlTyy1qZtUPrRdLFfr+O7k8P6Tpc7eTVwNQ1DWquO08Ttp7jCBUoPObr9y?=
 =?us-ascii?Q?Tc6V0LjYLlj514eI1AX95SsVcIZZmfAPMf7XDUCf5mj3JgkPIKR+WABWSfox?=
 =?us-ascii?Q?vdfRvV5lBAxDvIU336d0SzE+YfJMR9pZyfVHbtBq2ExqzjdLRvSicgPEYhtl?=
 =?us-ascii?Q?NoQD3+QzXuiGUz4yltm5pXtbcyjVWFVZgYiATqotORXq4dzvWK0fdZNyaHay?=
 =?us-ascii?Q?nwekJrDKyVIVfUmCSzmmXUkFSpCiKuOzhetldN2Ix547vqBTkrUQ/T0WQT7e?=
 =?us-ascii?Q?ZbdlcwbFvCHABBLSrMdbuRu6tRtvATmiXcKna6NXtfGA0F0FCxsfIp95wB0I?=
 =?us-ascii?Q?cAwEnwnimeJqqCoYyUJhRc90qpx3aqgmAkkbEl6CFFycMMn1Qv1BQO+xzQkj?=
 =?us-ascii?Q?d529jq+7CAZRL5kAwbTQuwGslcp2iRMsrFkFI1kGJ+xIUnOJcPPcWhTYVEAT?=
 =?us-ascii?Q?/6r7Tt3SQS7NJVYEwcb6zd6RvkCXumtCzXlwwlY1heIrtptoK7zi84iRciXh?=
 =?us-ascii?Q?6BFmWzXZ7YY+YQhX+mFnujZgjIVPJ7c8/XBVTU+oymyK68DYPKTMVN0BfADf?=
 =?us-ascii?Q?KbFK1k9rmv1gK1otLBkQGYzE4zdt8VLdaX2y80bkN6u2k99Eg4zrhePm7Ird?=
 =?us-ascii?Q?Bjlt8wuAa6iYLCmWVE/0bcvhhuugqHw/NziN7C27RGhdArfV8uAHCaY88PJZ?=
 =?us-ascii?Q?yrIwV0F/zjhkN1+3QX9qIRxB/ERtqyKK/D8G3qaQc+SM7CpCsQnq/KhTS2sd?=
 =?us-ascii?Q?R8+vRCM3snX7zHNHzg81uT2pruzrhBHIePDwS8RNIXV/sLzQq7ifsEehQ2vA?=
 =?us-ascii?Q?9ZWDrn+quSkT9fR78pUQZCQzaWC33IMq6tkL3/zdDPMd4KKtcf5l/rR9Uscd?=
 =?us-ascii?Q?U/U5px2TQ5B5CEGMmGA46Vz12GkOiAantwykdegkqLaqgjsEcdgL5JV9JeTl?=
 =?us-ascii?Q?8adKy6maUAZcOpy050PqoJvfCKQpsHcNoUvV3Lq24xMT6BJblWACXoE/Mdpp?=
 =?us-ascii?Q?24kq9W2J/bEbQHgwu6omrF9baKaVlcSXjGFZjKqblxgTMNkiQJul4oWzUHoZ?=
 =?us-ascii?Q?NEUZnH5CA11nO8f/o/l/Vhg9HhWiTG/zfzoGnormTxjHwUdZtbYkxFUi/4i8?=
 =?us-ascii?Q?mSUVedKLu8TO5qbxkNXCAhjzWNBkRNHOVL8TgBV7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb666f40-da2b-470d-5012-08dbbe521d45
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 05:33:29.0657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f7OCoyy+4CEQzfwwCl8KxOgKwwGV+ufLy8MUh0p9DrKApjXnezSIEP6Twrlsj9AJ9ngBj2OOx8nW65W3vtxu/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7339
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Tuesday, September 19, 2023 5:25 PM
>=20
> +static struct iommu_domain *
> +mock_domain_alloc_user(struct device *dev, u32 flags)
> +{
> +	struct iommu_domain *domain;
> +
> +	domain =3D mock_domain_alloc(IOMMU_DOMAIN_UNMANAGED);
> +	if (!domain)
> +		domain =3D ERR_PTR(-ENOMEM);
> +	return domain;
> +}

this also needs to validate whether the flags bits are supported.
