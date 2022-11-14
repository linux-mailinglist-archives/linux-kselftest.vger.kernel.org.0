Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3288627781
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Nov 2022 09:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbiKNIZt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 03:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbiKNIZs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 03:25:48 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3516461;
        Mon, 14 Nov 2022 00:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668414347; x=1699950347;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Cfo37hU4VkNhb1Oe9uP+irZf8E2+CWfOcptKuWUXGaU=;
  b=b4uEkUjCvjWd8b2S7W3n/6nqSDMAWBO20of7Rh1fWdTy8OEr7EuDih2/
   vlL+MD5/HJTdeH/GqU7ekoqAu8grpb77ipOos6pqsnwa4IvQvt9rY8Ld+
   g5CjTxsh29ZPJ39aIH3Oo6BsWZNLAp49jFpsGO+nOLQmZL1VEryWcA8lD
   sgXOVabOP1CgCtT1ZgUbk9YnXJmpSqy3NCvGujU5vQjXhs5rSy+b23in7
   VxSaS5smMXJ9El0Y2YIz1Wp3sRK8JFAGrBac6NSoHyB+7nHP3rqNR0aS4
   w98tDSKjn05L0DHcEB8aWk61GnultHUYq9XZv4TfySM9/J1XXJnh6N3YZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="313059159"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="313059159"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 00:25:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="967478238"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="967478238"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 14 Nov 2022 00:25:46 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 00:25:45 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 14 Nov 2022 00:25:45 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 14 Nov 2022 00:25:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZBBumBLSYMgKIsjnVS3sqGg5W4Y79FziCw4VxfYgFEf8ZoNGibiWnUg5wJSupGz56PVN+paeg1DBs6QoeL71BsRJsmUpKXPlUR+mph2uWqyj4RsL4R8g78K+fqh+k74as/mHn8q3gqxSn4x+wEC5w7dos781m2gQ6xZCX0CWXHioa3so8py2wotuc9GKys4Yb9BFXGkDqi5n2qm4vCruqxRUbI99+jD7ZbSNCwlvIW6sZErDibt2AM39pByJzhiMdUqXSJzuhwGYZd9tZze+QfUStHSEDMyspCUvnFbxN3DMtEd5L/ojuk9n1RqYgDba6f9Og7eNp3V9IhHDFntDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kNRa2bg3sblfXKx+DDLJTO1qqNSZm/1SfK8yUk3DQY=;
 b=BU7uIHnAS/qxHQgNFg4K/STFGi7AhQTOi6U9kidQwDBuYacChHvZ8jTcParXYurzk09nJrRp+aQYiBe9alI1bvCmg84XvI0BzMoySrsRedhNzHMB8PA9ddDvAd6vsF9Gg9L1Z7Hj8uruYQ6Ys+unvocuFFHpfaJDwTYAed7Fr7sC910RHyKiKa7eZ9oqoFJn8uXavolC4iJHDvTOSlXTFjZBv43b6n7XhCvmZn80ZJH+YdAXQtIi+pQT79GzwhGgdANKpp08Ok52GEklmZxr81LciRPbgqLIJSKFhk6KjlPBBlLqbTwGDfPe32IW08vEwgxzCMWene5OMYnQrSsLrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6148.namprd11.prod.outlook.com (2603:10b6:208:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 08:25:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 08:25:35 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: RE: [PATCH v4 13/17] iommufd: Add kAPI toward external drivers for
 kernel access
Thread-Topic: [PATCH v4 13/17] iommufd: Add kAPI toward external drivers for
 kernel access
Thread-Index: AQHY8wv6S+fTLk0xmkaHkKlyIDkL2q4+F/iw
Date:   Mon, 14 Nov 2022 08:25:35 +0000
Message-ID: <BN9PR11MB527648D864FB42027975487B8C059@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <13-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
In-Reply-To: <13-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6148:EE_
x-ms-office365-filtering-correlation-id: 8c708e46-d7f6-48df-999c-08dac619cda9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WZix9OsfT12BL9CBmVLDnJ74xGkBXdoFhZpwasvGQRKu8A3VIBEOl/Y1cFQkR/ocLxj3peXiaKq3qCKEsUkVwNxD1RX+kmDbXlOi7wb+GTxxv/HlYFASt0RJcwivANI/CaYbSavm28W59QgfJTttx06ffnOI8yoTpkyBucMgRFop9+3zuBakMb4cYM/SR45bwC+cNpqnC/HLxY5B0w/vSy+AvfDp7+V6kBP4yXU+gTumnv0SwaePlZrROwApr7I106e6TH3kYrH3Gj1Z5nMlHnNvMxIgTdYf+27HX0oCsE5k5F9E7DUyHyIVxHKMuG5ZxDLvtQL/1eeDglN/0eHzkxZAhR1LPOMUUvQck7O3Q8Cg61IFVV35cXbGGgkJpS1MliiGCYNdEOaNIRy7e3O/IK5E7LPhBZJKWs2eKQMt/aa3O43YtyNZkiCzU8SI4g/SfQLhs6+Aj7NHeNhoIJ4lB8PANRf5fIXLfQ97MKnV/nr8y6dw0bkWk5vF7fswjFKTjBXdvDKkkPgyQTdZqrtvQpQ+d3PZTdFoFmloAHM9J0a25FiOBghcX2Os7hl9E3NIwVso0LbQa6C2IaMeG47+QAvmrrV0Sc9bPqueUv3ujmwi4OtExcZA8s1/54UtIni0la0EYlaLnBERsxEWEZ0656zYARaCvJWmypq24idJjxymz93x/t/+9Fr+pA/Cpx3T+iDaxApXCcTPLIWZ/99XZgxu48JgEK9dxl2gK4UlI3LvgnqyeM2b0EH4h6HYkn20Cnr7SM5dgnbLaUDi8JL4/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(136003)(39850400004)(346002)(451199015)(52536014)(8936002)(38070700005)(478600001)(7696005)(33656002)(5660300002)(2906002)(54906003)(122000001)(316002)(110136005)(55016003)(71200400001)(66446008)(921005)(86362001)(7416002)(76116006)(66476007)(7406005)(66946007)(66556008)(41300700001)(186003)(8676002)(4326008)(64756008)(26005)(9686003)(82960400001)(83380400001)(38100700002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b4G8WLSaEbb7qlMdPPUEee4ewQUGKtQjxXcE7jlpBTBMxoCmu6DdglLGhVx0?=
 =?us-ascii?Q?mc28sJRpRJPF/fy0FWCMi5U00oa4ovetg4/e6xtZHKW5907T5xinqJ5S4ic8?=
 =?us-ascii?Q?K4cSkUuErDdQr3oX7TkanbCDvJzNW6WzZr7ctDEgxTUFAeYyJSKW0hsrqIDt?=
 =?us-ascii?Q?IhOq/Ty1LaPVyT72Gle1UvNVMt7h8bZPDoJRK7oE334d2hwLpbuho3P/jwhd?=
 =?us-ascii?Q?sRCuJELFXUOD+6Ta0DafsqBrqeMpB+WiPN/kqfhtnm5wcXYFFA0ERQKJMdYe?=
 =?us-ascii?Q?wJoiI5B3xEtD9IE3lusVbJKaaBdDaQ3VCmsTXCxiwlSk1nWRbrkNjh4157jU?=
 =?us-ascii?Q?k/Xh2lqwj1RxfYoSnav/X6QeiqmI2Gx/3jxqKzfTrQueUV6Kd1e1Gi4WdrwC?=
 =?us-ascii?Q?35QLtY4PXzcsRL0m99SZVsasOsl2w5Cq7RvrX2+CTXRu44zjR7tExa8kpDwP?=
 =?us-ascii?Q?FEBdRy7DM41+xSPuKh36LYsD4xbCjUVmJa6rd1l5TvPdcbvfNXdiVlCQa41W?=
 =?us-ascii?Q?X2yCLqYfYPGKp5WuA7jPQj/5a1ZYH9vbrwT4OBwL0RON3GgCBt1ZXVrqLAZT?=
 =?us-ascii?Q?o6UQO134zN6EXAVXUuulAhNnvxwp+C9oQpcOA3ykU/mhstWtQqPB7pNHMWU3?=
 =?us-ascii?Q?Y2b36CxB2twZbu8f9cwC3zbPaDdHgsBsToYtiTqew9XLs57JOo+he/g8YYgZ?=
 =?us-ascii?Q?6+kxjFIxfoOr8T7z0+LkRmojHwW7QbMTUaoBaOmX5bYR3gTdejOYEnyu00mF?=
 =?us-ascii?Q?I/isTmvbgetEMKUnO5365jhQNnVReGcsIYZ/jYfLHCAb/nF4qHMhgzXlBQzv?=
 =?us-ascii?Q?EI5qFjEUb9Gdxb6WDRHIfRVo2a5A+z2S13FBSlaKcm7+Db28UR9mrIR+YXdn?=
 =?us-ascii?Q?YARdlvIoYMmMKOeDIEbkqNejuTYmz4znCUGf6aTriXIgceQsG3SZASJurqBj?=
 =?us-ascii?Q?10uCIuBnuLfRcfn+P9bmEjvWb3googuf5g4JTtyONvv9aT+qOHJVRLMc6ZPZ?=
 =?us-ascii?Q?Y0V2SCSlrsYezKyMKHJkF1N1nDEsn49Z+Gw+pg3tZIjpYeagG+t99H7eJpO4?=
 =?us-ascii?Q?fIO5u8XEzzXwVm2qfg7ed+pymWDsxa2l+hVrkI7mAQ5e9v56P95IwMFWpz41?=
 =?us-ascii?Q?bStbDwfejwNRf7TU2JlGyHtUeoynvE+bEYMyIAan8GLsPf7F+zQ1P7BigUEb?=
 =?us-ascii?Q?fs3B1q8t+7BBnLSQIDCpf8EgJRHm4ZgnDU8mouwdneehBwLnDzYzI8TsOy7n?=
 =?us-ascii?Q?6jUVhuZwYPdlehZ23GAV9exX3cd4KsXudUjdtHTYk8KHtTXHXfTyAJKpZ/5h?=
 =?us-ascii?Q?NJESxQBdjWy06hFUITqH1lHI/6XLEi2vpESCZnuWWFZ2JlH7N17JVHnZfwSZ?=
 =?us-ascii?Q?clgXdPtLZ6wpm5+bgwiaU8o5G4h8FL5sy3VLa1OW5A0XM1TlQNeT7tF2p1sO?=
 =?us-ascii?Q?zazC4S0gkJluFlqAXqhJku6rn5nly2vPc51dHSM5PH+Y5tlAavNZXyrleyeW?=
 =?us-ascii?Q?ovI3PsIBZ9m5Y+ZnjZpvcryPwKddA+eMFFdF+/x6I0/3uvekNnjmlZkxKuuQ?=
 =?us-ascii?Q?ASm9z0Cm/3v7+j1EhKUp99RwxQaXYrNHwgADarNm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c708e46-d7f6-48df-999c-08dac619cda9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 08:25:35.2960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n2uxDsUU8JPUYZpEDFxlr2CgA/iOnO24see5Y8J/pdCbLTZRfDQ+Hc/fCaUwvKVryFJq27/jLDJVh/uLckZy4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6148
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, November 8, 2022 8:49 AM
>=20
> Callers must provide a callback that immediately unpins any IOVA being
> used within a range. This happens if userspace unmaps the IOVA under the
> pin.

with 'must' then let's add a check in iommufd_access_create() on the
unmap callback.

> +struct iommufd_access *
> +iommufd_access_create(struct iommufd_ctx *ictx, u32 ioas_id,
> +		      const struct iommufd_access_ops *ops, void *data)
> +{
> +	struct iommufd_access *access;
> +	struct iommufd_object *obj;
> +	int rc;
> +
> +	/*
> +	 * There is no uAPI for the access object, but to keep things
> symmetric
> +	 * use the object infrastructure anyhow.
> +	 */
> +	access =3D iommufd_object_alloc(ictx, access, IOMMUFD_OBJ_ACCESS);
> +	if (IS_ERR(access))
> +		return access;
> +
> +	access->data =3D data;
> +	access->ops =3D ops;
> +	access->ictx =3D ictx;

I didn't see other places referencing access->ictx before this func
succeeds. But just to be robust it's always cleaner to put this line
together with iommufd_ctx_get().

The rest looks good to me:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
