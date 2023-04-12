Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434116DED8F
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 10:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjDLI1o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 04:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjDLI1n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 04:27:43 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27F45BB0;
        Wed, 12 Apr 2023 01:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681288062; x=1712824062;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=12vvPJwinNRrRrzacyKbx0VY0turGkVmScrkZXeilno=;
  b=bkcLUUMmTkTi8Vw0peQWTEAm5HVNsOSi32xUJGluuW2CZGJRdSiwNw4V
   0084vFjyA88ighenGo3FAxalApxlisTCtDH7l9CRp4OKlUlbkfCFwGVb0
   4pDYtHDVCPiIG1eHjLqrK7RX/e5v7TMnhBW3gfQmJ1SXemntfdOELyI7Y
   T3Au7qlE2KqTz0WBqgblB3FvxcZ1O3m2HU5EOZW9zgorECfRMoPIy0fPU
   Y7STg7BcrPJ6hW+TRVoPe4IV7H9cX3QgZYSt8WbTGdbLxECFiyhxkCsz8
   dnoebPciiynoe4ZDZ2quSQfBVl0nMtWtWEM12jlIMsEwFbp0nOkMmUYZW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="324201961"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="324201961"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 01:27:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="778225842"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="778225842"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Apr 2023 01:27:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 01:27:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 01:27:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 01:27:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 01:27:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYLLM96FRk/Y57IhKVaziO3QMYnDKhu/YXjZYmsyuJvOFLHiwxCcJfVVUKV2eQaT5makPbEzEVydgRZpgi8y/HK6mkFqIN4mNsjFVNhV4o+8ngcnOBtFdu8rWvM7IWbyqbjB3EaWK8tGGDF18cnIjH2dKakvrOsqZWUaHkL093r4UjcdOXVmYWlk1oy8QRVJ0VYsQgTnEjro0cHBzOX2olcI3uO6AH/7A6lWuKITWTXQzU9rJdR9t36yKD6U+DuTF4QalRa3LKfqxQYm4/xMvlJ8/x6w9WdQguxhx7jraNWR1DX7oOklGcycExue7vziwwt42xtcmgIEZhjGDV7MZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PN0691ECfXbjI6FkcFkP5uc1BOK+w/E9srBE+Ze3ewU=;
 b=j7j7WlIDPgqAUE+3VTlu6lz4Q7jzJJdrUDX5OGhDoM1/Dfr+xxzM27kzrDPvHbSJAGfH77U/IkRWOC2bpjyl+MCM4KK8KuHU3Q3JlMkcsZs9YOwMbdn0PyybdAk9ltCn8nM4uUp2gVcS71VEuyCn8QYM0+QCnXh8LRjmU5AUkcL2kvUGZlozkk3iYMbSE4a2tfPh2l6D8PmEmtk+1H/h5SA6CVFAVNax8Xm2Qg6JJDQvJqT7NoGh54q0rX32AqxSvX9m/x8LuZzK/PDDlgoQpIuGkLBSnp8yP83fmdl4dpAMIDnL1i9pTGcyqnwU5c8IqZOJjZ7BRaGiYrKlvnNCtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB7633.namprd11.prod.outlook.com (2603:10b6:510:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 08:27:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 08:27:39 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3 03/17] iommufd: Replace the hwpt->devices list with
 iommufd_group
Thread-Topic: [PATCH v3 03/17] iommufd: Replace the hwpt->devices list with
 iommufd_group
Thread-Index: AQHZXCmFXuCDj8eADEa48b1mh4jx9a8H8avggB5ahYCAAStoMA==
Date:   Wed, 12 Apr 2023 08:27:36 +0000
Message-ID: <BN9PR11MB527661A29A11AE1E7FC655018C9B9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <3-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB5276E42B629C3E5AF019B6748C879@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZDVvLbSN2TR1Er1c@nvidia.com>
In-Reply-To: <ZDVvLbSN2TR1Er1c@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB7633:EE_
x-ms-office365-filtering-correlation-id: 4dc4ff74-c512-4724-52f4-08db3b2fc547
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V8GY3ta/ndXoculnPX7Gzw0K2bxYmq4KMTR+iYWqrFSieGklDOVW1eCWCO6stFZVaLpeapBFhFRCXShY9qtbjxaTrUPJXf8ehuPO90Imq0CDKHTtqLy35xvnxnvXc77dZriWvZcLyTcAbzZX3qktn9/aUNl7OgayB4BmXhfax+t+pzDpkKzb9amedjT1mF55QlOQVga0wCwmAWKJCkX/mXqr37tznGwIQffrQSc05o01SiqoRVDE/6rDWfGlW8go2+rzDQKMBvRD3Ay1JiY/csB6RjddggarnBiPiUf6l2KwAcPf9Vr2X4YsokQ4T4Y9mcWZaGhKRtlVbyKnKo42w4s9cSTLA4K8xgZCPqW5k0MyGVusKPAyBa87Xzl28YOBo0ixMEC1FIV9ROEzsxeydjf+g3hU+wNqq8dsLQfxOS/tXdQPrgji99I7XKqI9D3s+7JTYlN/qg533/6irorhH2sVY7E8Rikd7M8t4AjeZJ27egxbKWDwlOzHYhCMFxfRvza2hj0Wia2xSAzFs1hliJRaNN8dZE9yIZR81PKOtDTh+8hzhqaFPb+XB030A+0s7KfmhGyPs9R8CKewVj01phaLoy6XX4Auvf0/g9CeljA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199021)(316002)(41300700001)(6506007)(9686003)(26005)(122000001)(38100700002)(186003)(966005)(6666004)(71200400001)(7696005)(38070700005)(86362001)(83380400001)(82960400001)(66446008)(66476007)(66556008)(64756008)(66946007)(4326008)(6916009)(54906003)(55016003)(478600001)(76116006)(8676002)(8936002)(5660300002)(2906002)(52536014)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oB/7+LQbnU9IVaVBdT/yy7HtGSHAI9A99SwC4whsNTluAt20fJlWB0vvyw1z?=
 =?us-ascii?Q?CyUar14MFSm6KWhT9028QzykGRmLR06g8D8Aort4jo1EfC1gKlAsdL4HQy5T?=
 =?us-ascii?Q?gh7pEc4Fl4ub2njykmjIKfBRX/RcdTAIKM0g9k6dDGNgYeoJArFmb3nJ/nNT?=
 =?us-ascii?Q?CvcyXbQkE4q9IvFBDC280GVIVTaug0Ejz573jKVh0gPS94SiaGNrZjJX7R1X?=
 =?us-ascii?Q?3ZDeziszMB3z5ouzWeLOyhN4XA0YpYPvECNRqJc6UhWDTDbm9Oi/pS6oKNM2?=
 =?us-ascii?Q?b46t22gD26cV67xPbQwbZHY8MBmyGE96p5Oo3TvY7sHfuDXgI7DYtV1RmhtS?=
 =?us-ascii?Q?oQ8yLjbHkptCRh3ALhyB2bSv3MPQ9GtY6lBBRkNPbjksqj6zzpqQGmWO4ANa?=
 =?us-ascii?Q?V6/CY84OLvuu0LmGOpCtH6QogVTgl4T6e2Hb6IHCb2sxcD7Zr6ObsDRem4iK?=
 =?us-ascii?Q?e2wTf5KiObA+pyBjdEwBncXduivven4RTS0SoVjgBLIPF7I9lQAeZxsDO0HP?=
 =?us-ascii?Q?IsDOR9W0iIkoNBQEouvbPf1Ri4QQYRPafRsgHq5vEA/dZxxYzKIby3Lw3T7f?=
 =?us-ascii?Q?k2MGL1uiOwp0OrMTx9hlkMnH651lGYjbBmkS2ZqrM2C7+kzrpLCMY4TurSfY?=
 =?us-ascii?Q?axHhZm4gjKoNio4fOpJ0cv65uLlf0pbiO8z6BDKKVwZMRn2+6uNhafN3CjVi?=
 =?us-ascii?Q?90uLPCgTzgNbaI2fneHCJm6LcVtJp7SZ9keWroQS2AyURKTO2g3Np0gZqYi7?=
 =?us-ascii?Q?wu72cm6J2MkdwI5YpfWrJf0oYxEDvIADqGPbDyifLvfDV7QNKrMvW92efSbA?=
 =?us-ascii?Q?RfOzPduOHmcg37O5LungnNScRb5UMG6muhnpjXVGdsC7kbOR1dkLF06m5GDW?=
 =?us-ascii?Q?lYm76t/UGot9IJEhrVi2rJ2+TAFX3B310H87/uvSRcZip2Sb/fiqmFiYwGes?=
 =?us-ascii?Q?CWGPxDpv2BH8IqFLqUIbbEyD7BhyCjad4Qrla9gStQXEi9PX04rYtSGAmI4/?=
 =?us-ascii?Q?ta5dkLM7Kvbc/pXRYT8sLkI5iJHpMJLST+JcS+ShryIsxO8iMHKToVlAwlM/?=
 =?us-ascii?Q?I27pKXKWMyf6FSYPyV79uSMZWVRcB+uJ5hWIOF7IGsipI1LY7mZ+LL8Lew7i?=
 =?us-ascii?Q?NLOd4ga8hWSkaZDRCxs7CPtIHho7YOZiuIod38nBP9C9yrCTEBqBV+tsU62O?=
 =?us-ascii?Q?5sRtBsYDG/2lIiPYO+dv9Vaoo3CFbvuJz8mvgd5Nh3UY1yl8lLqm9Y23j6Do?=
 =?us-ascii?Q?ImmIKLZx1+269QI+K91iUhAnXKe17CJ8yxp6HlaF57m7k2BXETIUh6e+bqs8?=
 =?us-ascii?Q?O97iSjALBDerUiCyw1xB12UUJXgoo9JNwpnqhqWW2mbzOcR0jcC1aFAvyvyw?=
 =?us-ascii?Q?Oimp73SvSDjxYyADUi0x1mc9dQrsHA9Km4+kzXOn/2GWJJOpFpG8K5j8DlLi?=
 =?us-ascii?Q?CoNMxqjMGYnB4Ch134N8j4L5jihGWfGPBDVOmtvsLEpa2n+b0DODBJ4ggEgv?=
 =?us-ascii?Q?R0zEk2b0nZThjrts6btv/r4DAHV9aNY/tt1TLmsgMQ5xgabQoGrIGPrLnxvi?=
 =?us-ascii?Q?j0htXCK7hLDSDK1qnXy4N5r8nBhXQYlFazOLyn7a?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc4ff74-c512-4724-52f4-08db3b2fc547
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 08:27:36.1906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jcN9O8z0oeAEGcg1dkNUWpCoZMciq1Iuzz+SQzPPig0qFC4ongulIwqgSaqXHF5UMnYZ57nU7D4wg/OkQHfGCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7633
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, April 11, 2023 10:31 PM
>=20
> On Thu, Mar 23, 2023 at 07:21:42AM +0000, Tian, Kevin wrote:
>=20
> > If no oversight then we can directly put the lock in
> > iommufd_hw_pagetable_attach/detach() which can also simplify a bit on
> > its callers in device.c.
>=20
> So, I did this, and syzkaller explains why this can't be done:
>=20
> https://lore.kernel.org/r/0000000000006e66d605f83e09bc@google.com
>=20
> We can't allow the hwpt to be discovered by a parallel
> iommufd_hw_pagetable_attach() until it is done being setup, otherwise
> if we fail to set it up we can't destroy the hwpt.
>=20
> 	if (immediate_attach) {
> 		rc =3D iommufd_hw_pagetable_attach(hwpt, idev);
> 		if (rc)
> 			goto out_abort;
> 	}
>=20
> 	rc =3D iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain);
> 	if (rc)
> 		goto out_detach;
> 	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
> 	return hwpt;
>=20
> out_detach:
> 	if (immediate_attach)
> 		iommufd_hw_pagetable_detach(idev);
> out_abort:
> 	iommufd_object_abort_and_destroy(ictx, &hwpt->obj);
>=20
> As some other idev could be pointing at it too now.

How could this happen before this object is finalized? iirc you pointed to
me this fact in previous discussion.

For this specific lockdep issue isn't the simple fix is to move the group l=
ock
into iommufd_hw_pagetable_detach() just like done in attach()?

>=20
> So the lock has to come back out..
>=20
> Jason

