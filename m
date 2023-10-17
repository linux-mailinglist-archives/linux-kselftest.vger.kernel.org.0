Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB87D7CBE2B
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 10:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbjJQIxH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 04:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbjJQIxG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 04:53:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEB393;
        Tue, 17 Oct 2023 01:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697532785; x=1729068785;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KWu9IyONdDPnrUi/IcB8ad//hUm4MfjFflOQ3rPcPno=;
  b=YK1BQ69TssnNFao+6UrHGK+vcPqG0insPaBSysAHBxLK6rAdRZJPL0sg
   kO7v4GDCJ/ewgnxjPb365FtD89p/eQw1TI6kIC67OaQ0i30qmXe1Jwyxe
   1a63PCNNgpVEE+n3ooBE1/1PrEQxdtVt+VduG0B4CS4YN+PN1UHp6Su8a
   FDNXAJl/tDniIsSXS0gIqoUu4B6aiTiGYUa6HuNPV67TePqP92At4IRc4
   Fi6c9E7coIMTzSbzoz9enyhfZ1lemohEpAh6HDrDSP0yXe/FXPpFnDZdL
   JbWXwrI8IHkJe+2g7PztL8dp4kop30lsP7ofbRaG+6Ukfy09FP5JRD12Q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="389604293"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="389604293"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 01:53:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="1003276817"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="1003276817"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 01:53:00 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 01:52:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 01:52:59 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 01:52:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Be1ewYW7QBnpo4audgRTXqPvKhdCpPqcLdOlCXDbVO6iMmSqyqdfpKUmq2ZVIzWafXHkpg7JXml4kKfQJqSSTcJ5HK5wSJA2Pf9//xTza+GMZX3v5MQRlVdrEvVQjjm7ppzR6rKn8G07PH7Spb/1IoSzPY7ln4ZakWVzWIChaom9pDggSv112Z3c8zPXvq9V7IvMeLGyNundoCc/n4ABPEmBNYBu7aJJRysHcAl4YRzCOAffWJmLSuk+1H8rFtGfWgo+6zgfHXqtA2uVWoAWkVBRZ2CPvT2pQAEeirQvh3Td5hkXspekL4j3/17AbFowbW18AfBX78fpqIpmmKMN1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4g1Fl7hMYhctzfpV3FTfrr2gPO8TjewzcmT9cUXKLek=;
 b=LPpfmlrctuEyYYmgVhSFBXwzh4YSJ3bY/ihN4Ptyq8Vae6sQpQNmqOIt4F48nrMYQI38Rady3W4KN7JwYQLxHzqT6wo4RbMA7qttGc0k3S9eetHK3WLV44SppSCHo5M3Nnda5aVUDcHMEt20xrQ5usSNAnY5ZjBRjzHFTHxiN8R5cXRP59voAD5qHOO7kdVKSNwqUeC7x+azqbcNR+nM6kbv1PYbqtAKcvK0VSRF313mgTUH7GJpscMmLwajRh+Uxr5BqJmoy6n4RTUzjhI0bsf0+JzFhn0OroPTz4U83z5bSK9EbskHhpkbmRfgk4Ml0B3UmT2HbLNGm+SYDS5keg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB6708.namprd11.prod.outlook.com (2603:10b6:510:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Tue, 17 Oct
 2023 08:52:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4%3]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 08:52:49 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
Subject: RE: [PATCH v4 08/17] iommufd: Always setup MSI and anforce cc on
 kernel-managed domains
Thread-Topic: [PATCH v4 08/17] iommufd: Always setup MSI and anforce cc on
 kernel-managed domains
Thread-Index: AQHZ7GCNzWxyrCHnVkqPkBvqOzEqrbAsylxggBvMMACAA6lO8IAAN00AgAFSUcA=
Date:   Tue, 17 Oct 2023 08:52:49 +0000
Message-ID: <BN9PR11MB5276FDC375685CE04A7AD93B8CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-9-yi.l.liu@intel.com>
 <BN9PR11MB527658EAF017FF3576667EEA8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZSnkiKoCspmG1+/j@Asurada-Nvidia>
 <BN9PR11MB52763227866603ED7795AA068CD7A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231016115736.GP3952@nvidia.com>
In-Reply-To: <20231016115736.GP3952@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB6708:EE_
x-ms-office365-filtering-correlation-id: 3f4db636-b9d4-45ec-a75e-08dbceee70c2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XGdfRPOrtBKxk6nO5jJdByuuRdW+OFTMHU2X4G1dtKrHSbrtEa39oQ6xnBpKJ6/paszRJxUNW0zJoNNAB4qacFNC5LbjRP3gIpmLmhpxJm1KyxNq0RxRUykhkVSWYrge4QgUVSyfgmHb3ekLfp8LABF1GvV08MAbYRD94cTTZBK5pxmHfNUsSlZCBu0bXP6/zl1uf2Pt37CDRT2cVaU/gz5WQT1EtOzjE5T/bHhMKnuWHXxPsCsvA2Dt7qSi1izqwYXk3Dn5Kbp6ZXK/VyZCWXBNflyEb+3BnEcWo4Apz3FRrlVUqd5vO4YtaOrGdqekSzGy0OGZrcWwkNK9zctbbBELoRawWSSHy9xXcj79zkx6ACzIn2dqb1Kjldf7LkVEsKP528OmT0R8BcERMkOREW5tkBvVMGFkJQlEIH2+vkJavRBO4sxqH0FSd6onybGqCVaPL//HtqxOJfRoRVGGriWuF6itTEB9IBKdwF8PoAFCYKksaaBJNSvxeh5RIukxpMdSGZSOAzoz0963rfMOAHahJBSdCnWlIFQgAVbX1u8srkcHbzrpSepgSYwpqJHRUxKxJtDUC+yDPqb+SLjneZCVN4tUB36O4i389UiJ7IMILQjxuv4BZGrcz6XJu47D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(55016003)(26005)(6506007)(7696005)(71200400001)(9686003)(83380400001)(41300700001)(7416002)(4326008)(52536014)(5660300002)(8676002)(2906002)(478600001)(8936002)(76116006)(66946007)(66556008)(316002)(6916009)(54906003)(64756008)(66446008)(66476007)(38070700005)(122000001)(82960400001)(38100700002)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DL2oWco3zKaNTaX8j1eq+5F10VLWCqVyuQafOiCa1Mb8/Cy1DNY/ciVM7Jxj?=
 =?us-ascii?Q?QSHy0SABlRdN8AQOlTBnTfUNEdvt90w7y+drPpHdVHLcXM78UfU3E4xRtyTz?=
 =?us-ascii?Q?aGdYxebzzMkSTwZ+QOuTCGJqrwwPlZ+mEpmjTQzTk6Q1Fyu1ZWFCRADgw9hC?=
 =?us-ascii?Q?p/skQs+THL8WpkQXS1lCI78cc4nr77kqM1L2f11JIM2Qw4b4W4WJpdZOnSxA?=
 =?us-ascii?Q?g5LmoA568COTUkVB+KX3teJAElz3Bw3LiGXiRFb4Yj2YH4HGAhCNNOHtI/tg?=
 =?us-ascii?Q?yI0wuc43ADVeiSm9NZN7KnOJTmNynISXo632nmQCePR2ezmPgW8j4qKn77tz?=
 =?us-ascii?Q?eoUpBOsHyDyBsqNdyuLt8epDn0MDg4xIeLyVjJ+ZbMJKNgugQbz+CP5gaj7T?=
 =?us-ascii?Q?nlKbNuqHK/PLHwugSJZx6tWAh1i8zmsaYovBIYY3E/brvQup8pqfR+WnWukH?=
 =?us-ascii?Q?XHE0TVi1xE6mNL0SJJphiBUy/z1eQ7am0A0/cdE7AzGlQ6eBZVM5nh13cKb/?=
 =?us-ascii?Q?VroIhYppSuAshHoLIvZ+NdINXSw0GL/qJUHgesr44gPjN8Y3SzmZILjV7JuG?=
 =?us-ascii?Q?GvJ1jCc5JqowIucOsY8uUHBKJtgEXmAXq906NSMzMp7XlWqwcv0wj8bSMC45?=
 =?us-ascii?Q?ZLk8V62DN6aFol6OerqA9/EkqZNR4bDLlx/EbpsE7kttWpT8b6/HNjNbzP8b?=
 =?us-ascii?Q?zs4n69izrZ8atVK7oqNllzv2QTmj47tUpBZ3USZOeZy4044XnBHz9dkSa8c8?=
 =?us-ascii?Q?bN67ysdrT+1PcQYit3PDLIRe7b68HmO+v0BDus8LEipsSHjyV9/jnZCd8nF0?=
 =?us-ascii?Q?B4Es1qAQKcvCFFhT4J8UqcX5L2RvGnBQdb2o0tb8cMjuB+v8DtBmIEUl6uz9?=
 =?us-ascii?Q?xI8gnoKh+bKyNms3RsvxmqfsZ2cDPG5g1Px6GnfnwmMk6Sq1nekuIu1Z6zQE?=
 =?us-ascii?Q?K/NOLRivazMlcIJctc3flP6jxEBEsyv9cwCmRcEPtCvlM4J/l5zdOsLOJeEp?=
 =?us-ascii?Q?jojQZeNDl+tEw/FK+vZ0leYWv0m/b3hnDaIVY1X0TqkluXbE4YCoCXD3Z43q?=
 =?us-ascii?Q?J6OYDHIRJQjntfFl2daBCHnOrdbgBsXQ94cu8tKqrkUBTuflRYrIr4aGdCJO?=
 =?us-ascii?Q?WB3OJDh8omx/sWbTL0XYKy5deCxxAD59UC3BNjUTbBkdVTQUE83O8087QZHG?=
 =?us-ascii?Q?isDQ8ziHQEpAYo5pPrP1WaB6nuyuhyry+vOrtdsnJvTyY2Txx+XCfCTRpWUo?=
 =?us-ascii?Q?IXpzTGtTEVjOR3VsqpQ6CULuOnBf9poOQohGHsaAHQy7G5lFRv34LViAMe/L?=
 =?us-ascii?Q?qfzJb0NVaE2jLffEsAEI8pXHa7yWsWsM95gnssiPegrDUXgVzexzv+2X2Z4G?=
 =?us-ascii?Q?h/F36bwLzvqCUF43j5+PocYrHUFR+BHZF/z7A2rbhfIMpYys9l1Q4hqN7a7T?=
 =?us-ascii?Q?4ZqgPh+hyqfwUdFJ+g0UyPgT1szcFUvGR61jdrV7TFHwamuqRZl4Q0/lbTJG?=
 =?us-ascii?Q?O/z6wAqOvs4ZJJ6jZQNcMQRvNsrndvUhqwTvr9zsBskQ157uQ0HwLeCls9vt?=
 =?us-ascii?Q?w7k47sGmdILBEAIeJJW/jRgcRC5Jk8pXxfqzHupN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4db636-b9d4-45ec-a75e-08dbceee70c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 08:52:49.2272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWx1YeSq4EQqhW014I8R7dCaEgip+bZW31JZsjZgguM9sv591zkKapovEWYYZ5krb1CJSOYpk1KBiytzPyLnrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6708
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, October 16, 2023 7:58 PM
>=20
> On Mon, Oct 16, 2023 at 08:48:03AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Saturday, October 14, 2023 8:45 AM
> > >
> > > On Tue, Sep 26, 2023 at 01:16:35AM -0700, Tian, Kevin wrote:
> > > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > > Sent: Thursday, September 21, 2023 3:51 PM
> > > > >
> > > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > >
> > > > > Now enforce_cache_coherency and msi_cookie are kernel-managed
> hwpt
> > > > > things.
> > > > > So, they should be only setup on kernel-managed domains. If the
> > > attaching
> > > > > domain is a user-managed domain, redirect the hwpt to hwpt->paren=
t
> to
> > > do
> > > > > it correctly.
> > > > >
> > > >
> > > > No redirection. The parent should already have the configuration do=
ne
> > > > when it's created. It shouldn't be triggered in the nesting path.
> > >
> > > iommufd_hw_pagetable_enforce_cc() is not only called in alloc(),
> > > but also in hwpt_attach/replace() if cc is not enforced by the
> > > alloc() because the idev that initiates the hwpt_alloc() might
> > > not have idev->enforce_cache_coherency. Only when another idev
> > > that has idev->enforce_cache_coherency attaches to the shared
> > > hwpt, the cc configuration would be done.
> >
> > is this a bug already? If the 1st device doesn't have enforce_cc in its
> > iommu, setting the snp bit in the hwpt would lead to reserved
> > bit violation.
>=20
> I suspect there are technically some gaps in the intel driver, yes..

double checked. intel driver is doing right thing now:

intel_iommu_enforce_cache_coherency()
  domain_support_force_snooping()

static bool domain_support_force_snooping(struct dmar_domain *domain)
{
	struct device_domain_info *info;
	bool support =3D true;

	assert_spin_locked(&domain->lock);
	list_for_each_entry(info, &domain->devices, link) {
		if (!ecap_sc_support(info->iommu->ecap)) {
			support =3D false;
			break;
		}
	}

	return support;
}

>=20
> > another problem is that intel_iommu_enforce_cache_coherency()
> > doesn't update existing entries. It only sets a domain flag to affect
> > future mappings. so it means the 2nd idev is also broken.
>=20
> This is such a gap, intel driver should not permit that.

yes. @Baolu, can you add a fix?

>=20
> > The simplest option is to follow vfio type1 i.e. don't mix devices
> > with different enforce_cc in one domain.
>=20
> This is why I wanted to get rid of this bad mechanism going forward.
>=20
> Manually created hwpt should have a manual specification of cc and
> then we don't have so many problems.
>=20
> It means userspace needs to compute if they want to use CC or not, but
> userspace already needs to figure this out since without autodomains
> it must create two hwpts manually anyhow.
>=20

Now there is no interface reporting enforce_cc to userspace.

Actually the user doesn't need to know enforce_cc. As long as there is
an attach incompatibility error the user has to create a 2nd hwpt for
the to-be-attached device then enforce_cc will be handled automatically
in hwpt_alloc.

I prefer to removing enforce_cc in attach fn completely then no parent
trick in this patch. Just keep it in hwpt_alloc and leave to iommu driver t=
o
figure out the attaching compatibility:

  - attaching a idev with matching enforce_cc as hwpt is always allowed.
  - attaching a idev w/o enforce_cc to a hwpt with enforce_cc is rejected.
  - attaching a idev w/ enforce_cc to a hwpt w/o enforce_cc succeeds with
    hwpt continuing to be w/o enforce_cc. No promotion.

above has been guaranteed by intel iommu driver.
