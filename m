Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CA96AD4E5
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 03:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjCGClV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 21:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjCGClU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 21:41:20 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D262C66B;
        Mon,  6 Mar 2023 18:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678156853; x=1709692853;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PVRwJiBXA+7h+UfOa+o0UWKjryownPVPSV2esrvgOCU=;
  b=IeK6vezq4t6A2Mo/lKbj/UsymyDawq2dF57B8nZa35JeWE9XH0UfesB3
   w/soh5RFQGYmw9F2NmpZOvqsgcNxuVQtfIL0Of+8ccKwD7f+jbzbPrvNS
   UwjNY1bjszJy8hSG5wpI4wc6DbDpVKUeXYees7ttCurFc7WlTi9n4TQzb
   pPrqfb4lRPjMQ9ERN3T+0/4epNOv6lA7fK0SzOcPMEULTd4KH0KSM7Bki
   /DsS5udCnuFZxsjVq/QRx8QCsludttYWIPDiuKwjnVgrBHrsfbY4K7fPD
   evkmRgq9gQbmAmrlP2o9yAzxaDE8uWQTmgSoRlOIHgUfAKpIkL8TQZNMW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="337266128"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="337266128"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 18:38:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="653814138"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="653814138"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 06 Mar 2023 18:38:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 18:38:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 18:38:49 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 6 Mar 2023 18:38:49 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 6 Mar 2023 18:38:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y67+gmxbNpMFQ8sKXHTZq4zu+X7qGiTQufTJSXZJVnlQfnhPw+Aw8GelDWb647Up+qwltMGsZguNu4mBMgZLUW+MokuS4DayebPzSqMnUIN/oa7S1+sEdR3bicx0U7J/+hdgOV4/a6fWVIcFJTTHAc+5ptWfHAjTCEyn572X2OSff2XXxWiuiLoDDpMglAndUIWcQB7ap7rZz6wORfWsbkVRc2wZ7mcDSQNrNklicvnHHPKCHeJRum0oZAeUVNhCnZk75j//WMRvWuJjjeehnvzW/1/OTvy06xCazDwY2uf4kHAUYY0pUWk0bpdPyJWSh5bqBkXMwQDHZWeiGNUSVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmgDs42oIJGgCh2rU/0S7Kz7lvMHh3+hvS7vL+FsMZM=;
 b=gVhFmLqibyPT5X9HK65Hq3T4jHg3YFivgZ8XUIx9meAVoijv3e6srqgOF9RWZ9/BZml9udDjyRNQ/okMP+GW6mVKUte7/qajQtH40cOXCs8gmHpEbd3Mp8x2azu6uIgTiTcZji2c99U2q0IHDj2Og+Yciw7KrOWFyE89hd8UjEO30E5Fcq3q6XWH3g7MskD4WWV4iawBiPDs1CbEie8POT/xR9Z0fJ+J89F7AHy2RhVI2D0PCvW+B0dV+OVUkZ5QeDUWM+DH658kh+8hAun8+EtWIuTHcutUzKkQvj1d1EjhPBgiqr1stWQW1CUIN72oaibqSeOK2fN1bje3Bqj0gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB7750.namprd11.prod.outlook.com (2603:10b6:208:442::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 02:38:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 02:38:47 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 03/14] iommufd: Replace the hwpt->devices list with
 iommufd_group
Thread-Topic: [PATCH 03/14] iommufd: Replace the hwpt->devices list with
 iommufd_group
Thread-Index: AQHZSLAPp+svwc7r8E67jgTrC/2K1K7nJ05ggAcaDICAAGeKoA==
Date:   Tue, 7 Mar 2023 02:38:47 +0000
Message-ID: <BN9PR11MB5276F4706574CDA936732E538CB79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <3-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB52761557D23695475CCCF3B18CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZAZLgSxd4AuWJSI3@nvidia.com>
In-Reply-To: <ZAZLgSxd4AuWJSI3@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB7750:EE_
x-ms-office365-filtering-correlation-id: 40da0911-4c86-4e1d-fbc8-08db1eb5141c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8tHruQ9eu7Kzl1TWsNPRBzPJduenObbSUQsITY6yMTmi2KljH3R/xN8IeiBfQ7gaZFI+3fw7PFM9F9hfvUehLDO4UI73q4hv0hd6X4j6kuSkPs6ChxJUAMI0dW4mnH0AtjOJxIrMePzVQNKMaNq6wFdZVTTdM9Km+d/X8mZ/EaCBvJP+cQFGLpF9La7j+hPi3dV5l5nQDgPZ/t6xBtYHrTq5bXoHUaGuyiND/3a8eJlHEROQMA4/ZYNCHwwBoNUS6JKD5hi1S9vQArL9ZPz17YwE6TIe2E5dJ3n3tG9Rsk/J+oKVSCSyze6fZ1UhtNuwuuPBt/NZrgLG6QeOxK17OXYKr3hDK/q0TI9qfaStAf+Dbe7xMpIO8gD9af1K/yJIDKh+kG4l0sry+ev4A3uNXooE4guNoDXRSTJ7u8qXxFd7KX76/bNsKgMtraFlwtnVGiqYeAqJty/wAJJYKimwe35bdr4XxGvSn95038rIsgypE5ehqmJittSPK0lNDLeNCkuxJkNBVym7KQo9cxUb6DInM7/rLFL5RUOB0NqeDce8YDUIytwC8x3OBxhcHoEnQcGOU5Za1j8DTSdEAkQS6QEjw37ZTiFS+h1k4LPH8wplDzKEyntsC/xTm4WZKy4ne4CKYgG3v3qGgsLGVBqeZ/qD7kV3Q8L5xmktPdFIA49dP+/H7cjaIpr7ChWzPop9GbeL0pUt0xsl0zj9ZhUypA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199018)(82960400001)(122000001)(38070700005)(86362001)(38100700002)(33656002)(107886003)(5660300002)(2906002)(4326008)(6916009)(76116006)(66446008)(64756008)(8676002)(8936002)(66476007)(66556008)(41300700001)(66946007)(52536014)(186003)(26005)(9686003)(83380400001)(54906003)(478600001)(55016003)(316002)(6506007)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kkNnJmz87tPkK5XgZGp78rRYjPWGVPcJHEAWhZXgk05dc+rOWiLBH7xIEFf6?=
 =?us-ascii?Q?Y8NBDWJH2jfWRrJFCaE+BS2oQSKbqTQ+IikBoef2PG3U0CjYtGULNhzlCLko?=
 =?us-ascii?Q?U5wBeMf2mup/YVCZ5IpzxsOK715ui0MYXYUj7iCm1jqnjW804BVo03kFkJR7?=
 =?us-ascii?Q?Xh+cJSyCGtasIbVgnOTnnpbqINaK91paG5Z2HuqwryzFHea1yfiFtNc/0bW6?=
 =?us-ascii?Q?ptgJsPAGKvfsM7DpBtPHYCwwBRJI5QvBQODVTBM3J41JBsUVjSzsV4TaG153?=
 =?us-ascii?Q?1r5qqKyZdw1fnQU1OBgG/iks2N5NeH/llDyMP0aT8gS5b1ShLQYytPxqGHTD?=
 =?us-ascii?Q?Ja20OX+cl/D4F03UK3MPJ7H8WzPnNJgzCVcm/3/NRyRAzud8FygC8kUOmWRs?=
 =?us-ascii?Q?KFNMGjJtSJKLdQQO80M4owQ1Wf/8C63Qgf+5oiZUtMzqdL3WD5qCgnFZk3O+?=
 =?us-ascii?Q?Z/lmeX6PH9PO0GMJSVc3xGjqOkdkclvbDWTOaeiBCKTl/eUflsIqQZ39uYi4?=
 =?us-ascii?Q?PmrwG5Q1B4FPk4rItEreQY/46y7c8h6QJVkt6ix42xQNBu+8SMs81xudCzrB?=
 =?us-ascii?Q?QpLGZS4VB+xDdmacpSnIIT5wswXJQpU0YVHPoVm/BLZ3s9Cog7wA22qkwdtI?=
 =?us-ascii?Q?uxraPR+TbQGvEp900KmmDyve3EQH8/am3mdrlSPCgVfm9bq1AWkpGCtqWTPz?=
 =?us-ascii?Q?tEzj6takjkAtQ93Bqwp7pnmC+oevH1L56UA9StpXeNqzsF3sJahZLCfadIlq?=
 =?us-ascii?Q?s/7Y33Hvxl3+kVXVGufWAn8B+hguoAU+elmScGc0+UqOPsNCWqsCSZYd8Xu9?=
 =?us-ascii?Q?a7kFziFuvQW1loFuukNRkOrxzTgIGaAl4lK7RdnTL0lC3UkFwomdSENoIEzD?=
 =?us-ascii?Q?s/5lwMr/tP3r8KWD0TfM9AkdsmpYiS4If/piQNEhXC7uIrjk4OyB+zxEoPXg?=
 =?us-ascii?Q?4YpC7f8K/WV4D515NXJDtN0ZxfbSHwzJQ22dbtTwOWuHMOJgEGvmgy0lmulC?=
 =?us-ascii?Q?V4LsEZwUy9uQ472XLua0xUVEbgsMYFcPg75NrrDmapPMK1cOlQJ3p8dW7bUm?=
 =?us-ascii?Q?QwVIrEG7oiR2+U+1aG5FW+Yxe8sjvjz8IFCdPml0ayw5SWQTVrzVvdN3RuAv?=
 =?us-ascii?Q?7r3MNKKWWFh7m4xeTyWPoEtL2NeAqIToFbIZsg6MCuy3xPWe/tsnw2SjYFsL?=
 =?us-ascii?Q?9/4p5iugOn7RcxQJnVd4UzVQk+pzcbB8TaYgCZh+gEHvHnKxjL+rEylx3yZx?=
 =?us-ascii?Q?bTydjrVJHSyK9EoI0kJsTqGIFzoLfqTzEgvTVmCcV+Xim3ySC7odxxnlVq2D?=
 =?us-ascii?Q?gzl2njIekdik7aCOymIYBNfHAqg1orCUOGfq0J6IwJxUC+7NFBMfx8NBpncG?=
 =?us-ascii?Q?s0Odxm++9ss5wvSIY6ovMkT0V5gk/9bOEj7hRg0hrZWyPn6V6CfbSLhhptaF?=
 =?us-ascii?Q?ayX3Lms4OiC3wCx4XbZdjeWOKyN5/cQWOC1vmLBpuFKboTq1kA6J9LKeptwG?=
 =?us-ascii?Q?fynILvNc8u9c/uGwtxsfeavY16IIzt9XCTruBqYBIUvSppjyfRgC5iOYBHHi?=
 =?us-ascii?Q?7ahFgaSdfHn1eMfHlTVl37VO/FQDD/mv9UpFj13t?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40da0911-4c86-4e1d-fbc8-08db1eb5141c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 02:38:47.8258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LWJcomxPW1GeCSyJUmWFNnJlztinG7Dut/HrvH/rJxGiM0Om/F2raOBLYKEWkYZ84klgit9Po7/fYqhQp1TI1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7750
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, March 7, 2023 4:22 AM
>=20
> On Thu, Mar 02, 2023 at 08:01:00AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Saturday, February 25, 2023 8:28 AM
> > >
> > > +struct iommufd_hw_pagetable *
> > > +iommufd_hw_pagetable_detach(struct iommufd_device *idev)
> > >  {
> > > -	if (!iommufd_hw_pagetable_has_group(hwpt, idev->igroup))
> > > +	struct iommufd_hw_pagetable *hwpt =3D idev->igroup->hwpt;
> > > +
> > > +	lockdep_assert_held(&idev->igroup->lock);
> > > +
> > > +	idev->igroup->devices--;
> > > +	if (!idev->igroup->devices) {
> > >  		iommu_detach_group(hwpt->domain, idev->igroup->group);
> > > +		idev->igroup->hwpt =3D NULL;
> >
> > hwpt->obj.users should be decremented here instead of leaving it
> > in iommufd_device_detach().
>=20
> It is like this because eventually we can't call
> iommufd_object_destroy_user() while holding the locks.
>=20
> So the lowest function returns the hwpt up the call chain and once
> everything is unlocked then it calls iommufd_hw_pagetable_put()

but don't we have unbalanced refcnt poke?

device_attach:

	if (!idev->igroup->devices) {
 		rc =3D iommu_attach_group(hwpt->domain, idev->igroup->group);
 		if (rc)
 			goto err_unresv;
		idev->igroup->hwpt =3D hwpt;
		refcount_inc(&hwpt->obj.users); //first device increases refcnt
 	}

device_detach:

	idev->igroup->devices--;
	if (!idev->igroup->devices) {
 		iommu_detach_group(hwpt->domain, idev->igroup->group);
		idev->igroup->hwpt =3D NULL;
	}

	...

	if (hwpt->auto_domain)
		iommufd_object_destroy_user(idev->ictx, &hwpt->obj);
	else
		refcount_dec(&hwpt->obj.users); //every device decrease refcnt

