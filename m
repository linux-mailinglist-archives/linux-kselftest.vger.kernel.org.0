Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCE77AE512
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 07:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjIZFcd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 01:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjIZFcb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 01:32:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72110D7;
        Mon, 25 Sep 2023 22:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695706345; x=1727242345;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qzsO+9TlVpYCrbD/sSPD9G4nL4CJ7iPpivBfgagu+AU=;
  b=kStuGkJkwZgv2heBFrQXJUNrqNoaoUzv9UMcLQcQRt2wohoSqhnpu6ym
   qy3QIqUZ/kL/2NoaQWZZwZtYpM2od0LBrC/ipOtQrQeNhu/0wFKbg2N0V
   9ss1QVt+/PorSwNRn24xU6FVO2fLur6+o4ycQI07fNTTAB058HtF1dgII
   mJOQrbL3Qozeb1kcsfYb0/AbtcKEDapMvUTu4xU8A2GTzsVHrO90UCnU4
   /x7t7vwliQrCqIh6HEE78EB6YDe5dDuDQXyuCKPKhdTQY+Dk7Zvw2X1UF
   NdoynENpZR5gyxtaXQgdrRVA6nqHGpXCopNyOu55ror3w/aHiFCHqWkye
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445620801"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="445620801"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 22:32:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818922236"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="818922236"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 22:32:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 22:32:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 22:32:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 22:32:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdzqboJ0b+cbGEP540TaiKAFFt5lVPKd9mMdfJEQuyxtIW718jeawIAQeu4vvv4XRa34BzccXkuUGrDoFzBBARcOzxTrsXNmcKgPVbN2p+n0JM/kRGH8PYMiB8PQvmW0an9zstFLMkkAuSEPy2GRNMRSTpZJa3bklMYT916KhI+juPma268lQZ17zHEsqH45nquoAsDfib22aSgYmu+boXIsNI9I3AqCrzJOwWoaBt336TL8i1cy3KHro+80fjsFw4+ZFQ0k891PwQUparMc4sAvJkBprPtOcK2bui25+EdV+8uowUHSUmMhqXGtVP0eePphSDnJCtm136bFwTdHAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYp+2kmpyS3tKkjktRhIEahXzEbCG6C6sCJaatqTubU=;
 b=AK6R7+pl/bKRUP4tP0/enVZ+ouFalon8LZ0pDzyS99NXJgApW0l1KgUYHuo+mivb8ObNvdVdeclUEfad5UGf9mx0I3M+DRtiF5AwSq4kKVS+LsBPxMePADDb/RmevCn4o8SR0Y2jmcSsaMg7GNEvhyf4eBkOhQUSLyrs68c7GSAPULfp+ay+LmQQkog4hzJHn2VmDk5egyQeijAOAwXYSV6EVVEGD5mgFF/ZXjBqbAfj+X5gRHAnVS9FONXzuFzEeXKdI/UaI32n4c0mNLw/TM+cfZBoEhBuIKhSaz/UDEiNfru/ByqBlcjBg4VvidscUHWmxQCPW3MQs5EWqnDUHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7339.namprd11.prod.outlook.com (2603:10b6:930:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 05:32:09 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 05:32:08 +0000
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
Subject: RE: [PATCH 4/6] iommufd/hw_pagetable: Support allocating nested
 parent domain
Thread-Topic: [PATCH 4/6] iommufd/hw_pagetable: Support allocating nested
 parent domain
Thread-Index: AQHZ6ttUjfPwGBMFl0qs/bqpL9atnbAsn3Ow
Date:   Tue, 26 Sep 2023 05:32:08 +0000
Message-ID: <BN9PR11MB5276DBCF4B2DCF894C4E53278CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230919092523.39286-1-yi.l.liu@intel.com>
 <20230919092523.39286-5-yi.l.liu@intel.com>
In-Reply-To: <20230919092523.39286-5-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7339:EE_
x-ms-office365-filtering-correlation-id: cd2b40bd-e0e1-4d93-6ea4-08dbbe51ed21
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SIe7KUvyCJoxQ3sARM2lwi9XPzWa+k6a0fu8kv43LKxCgdKL/+Px8PCYuW3YnNCHkpu7ii6ALY7SDE2u+kOg9I8HF40lFykYRZ1w/BPixxw7qvd1dIe0I2f/mahq9vdb6dUYLBrxO9xRWClhVa7vEPkizsMMhAmkkjH4jggx3ejXuHsywagLyHJ3Oa9nM+Z1z1PcithRXS+egFnr/be0efX5aE6SGs7Fvt2d616jR3Z/aFewWdAflOj/o4LgKBXi/2tOdiezqmlVS98gQEaTkeH4kzCCUYj5401Q04FiEdThvfA66ZJrRWkzxrkA1gZiwGasiyMDg8MIVn5pzasgpYdIeXDSdxxlsWjuZGNKf2i8nBYHAMt4mrqjR1QKU/NsXuUiqdD/gXaDZTXJPQ8c9M+v5LtA6kKopD63R2V2LNMA9sPaiCdQ/MRDyCyv6ag3O7oJXEXHutOMHiPVA35V8qOSTkgP/6K5dg6+O60OMxgdtJcQJcDM6r5Ynjhsf8YFtshHCh6Fiy07HH9lTD60ZUrSc3fbnnrprTui8kJtpv0mt3RSHgAVAiFpTpAQfU55+u0h73UQj46WprX7JAnb6js81L7tLWDknkzE5n3rqeWG264ERgwkJwsvT6Lse9+L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(86362001)(38070700005)(8936002)(8676002)(38100700002)(52536014)(4326008)(5660300002)(64756008)(76116006)(66476007)(66556008)(54906003)(110136005)(41300700001)(66446008)(316002)(2906002)(7416002)(33656002)(66946007)(4744005)(83380400001)(478600001)(55016003)(122000001)(9686003)(82960400001)(26005)(7696005)(71200400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2Cjjr5shgowALZjSNFS6e1pmw8QYK31HKZj4Rtk09G9f4RK8rKLC3WhzvxN3?=
 =?us-ascii?Q?0FWUI73XL4RkGrqlbR6MAMAUU7Se4tASw6xM2Fu+1WegS6cj1IxgrhSimykC?=
 =?us-ascii?Q?0fbI9dU81W2GAW7Lj30s1lxsE3XeGr19grVOLk/8ygedlwEg1JoDSndJr1kE?=
 =?us-ascii?Q?veEecP3QJqn4VVGzud1EI6AoMV4sOx97Avxala3wPFRGGz02Nh8bBAyJbqBT?=
 =?us-ascii?Q?hbfaradWomVZQ+XVOWWrILU4HgFiCPnpkSM8z+DslZ9eAkEiSO200o6ZX6CD?=
 =?us-ascii?Q?5SqVasRjCShr6pZJciu6aMTOmApQ5eMRHyA0WOxQc3ZvcXZ6nNUcCg4cpKDV?=
 =?us-ascii?Q?M+EQXi7u7jqMeKBzfXEq6t7GZZsrso8vIfUTog7pIGrEE9m9M4/enZZd9Oko?=
 =?us-ascii?Q?QC+WgzoL1RMRrVUoAbitjwdDDGrVKMcEahg48DCRhBCK1I9ZX4Qz3yzioJwX?=
 =?us-ascii?Q?mOzwG453GwXLMOaPpLkWpS67shMwYq+3sP55vfd/VuY1lWsrRzbPlZM1QWKG?=
 =?us-ascii?Q?IXCqTDKNvK0aEKzR0nIbvaSCQW63ss7lyXZaZSV/gO7p7Ayt18AHF57+DgHe?=
 =?us-ascii?Q?pDPzEa2HhrOblZ74RyqgEeY2wlkY4H7lSctsbr3leu1syRKvGhhtJjGP6bBx?=
 =?us-ascii?Q?NtZJ9UzRCxz7Pno2/uyHJMvwgTvZ29ew5v+hzv50hOQzhnaWRSSUuyKLZfd0?=
 =?us-ascii?Q?pH1iy9JjSEFsG35CceI8zVfAh4SPPomLwvkPM445EMmVzcaZd5S5gJmGrrwJ?=
 =?us-ascii?Q?Pj41i6ar/tX2yQdfC1dcOFx1gQ5IE641EoL9p9KZw6gNpANUlyPFjVhGey9L?=
 =?us-ascii?Q?MtupccXzpGlh097WFhF8bWVqc+EDCdR35KUZM+v3mBcD3AjdmFSrEifO6R1W?=
 =?us-ascii?Q?DgnPMaDj87XtCqPtY7LiWvQ74tXfH/l3Op6eC4n8vBtN/j4TTjuSNebkPJPX?=
 =?us-ascii?Q?E7GbcxFDz1H4+tVtoj1lV13PWbOnVHTb+e+z3VrnRYZmKoCbOXWms7LJeWoL?=
 =?us-ascii?Q?ueSUsgMWr6ZljAaE9oyyplAaXhIhapa9MzsH/GfkcoPP0X2xSAKMTdXURLn0?=
 =?us-ascii?Q?L2WmRnRyOFImEmb0QGLqJfwgcyjKo+022wG5dPZLg3QE90yt3O+oJUdcQais?=
 =?us-ascii?Q?GVUlH5nvntSni7yrcv2clE5JpnpyZ79Y69n/NvmIYAxAWVuGW/sFhfcghLId?=
 =?us-ascii?Q?VMtDcOZE5H/tYqd96pbx+DlO1Y4IDyh3ki2M7r6XlPIeDayg/9ACuMVQGfbp?=
 =?us-ascii?Q?SLMccql55bOssE1xm6BIzXVB2a53aRRCxQvpHS/klBCGkPuLzoG4dCJpBUeb?=
 =?us-ascii?Q?xXRs20cq/L9wvgEIFPgdinelqs+29p4Y3KHj204ViMEgaNgUu+tO+bD1lVUM?=
 =?us-ascii?Q?bm2TE9HpcjBbEeT3YEzzRJofD4DFoHDZULDeJ80+tSxgYKIZ5iHnqKD5YQBV?=
 =?us-ascii?Q?zLVE1Ik812c2TSACzy6wXGO3vsyrHM2EVSiAYNvzmzvdUusldiGgNL0DadpF?=
 =?us-ascii?Q?jqS4raRyCS54Q6aKCRAs97UMPXKZZAms/zyzrJoMpM1/HDJkOHHlFbmoW2NN?=
 =?us-ascii?Q?xjGHk2kity90VPucVrUD6ZJYstX8ciogcrNJBF6N?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2b40bd-e0e1-4d93-6ea4-08dbbe51ed21
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 05:32:08.2995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G/g3BqZd8S0+AqSDHLmGdpR90meLuho6qOCTDhWGqoXy+5iwSY18tCYcVAcdgeupcer8kmtyVOOlA0QDC1WNRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7339
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

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Tuesday, September 19, 2023 5:25 PM
>
> @@ -83,6 +83,9 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx,
> struct iommufd_ioas *ioas,
>=20
>  	lockdep_assert_held(&ioas->mutex);
>=20
> +	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !ops-
> >domain_alloc_user)
> +		return ERR_PTR(-EOPNOTSUPP);
> +

if (flags && !ops->domain_alloc_user)
	return ERR_PTR(-EOPNOTSUPP);

as long as flags is non-zero we'll need the new alloc_user ops.
