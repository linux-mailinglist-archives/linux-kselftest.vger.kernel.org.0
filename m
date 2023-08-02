Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0EB76C1E7
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 03:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjHBBJn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 21:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjHBBJl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 21:09:41 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAF612B;
        Tue,  1 Aug 2023 18:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690938581; x=1722474581;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YtZi+T1HKTwRggoNHyrsufeqpd404rCNyZbTvZIOKq0=;
  b=f/mxzWedVEdLg+CznT/AdcLUDVvk0/BQOB4FkoEODZazWqwX8DYbv2k+
   rPTY4hB2TmGJ5yYuq7M+FrDEYeEh5Sju6WktJyQ+bCvAOT0C+CL5fcHDT
   Dlrb7/c3gXOS44Xb7oFa16RGyctge6WhdfU+VbLsnLQJKunKY/iWXLLSX
   1ygNXHFqBliMmOmoVMtoVFFHSq+X5BT8JNT5XV9b1rILQAYMOcvDOHD6p
   BSfke+i3OjTUxW9JeYZHIG+jVbmgG1AcDIiVzbTqbcn2jIzOgAr/LKZpr
   oorDd98aoI1xllJgYhmvwpOpEzrgq88vkaJCQrHOBfuFSA2gW0q+avB6V
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="368349916"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="368349916"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 18:09:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="818989399"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="818989399"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Aug 2023 18:09:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 18:09:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 18:09:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 18:09:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 18:09:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYjIt/DlA9j8xkSbo9RWDdOghkLF71fnvqwJlRWS5MQkOBqRgXJc1vDyG11UJe5TxNIITZvDB7p/RcPvxyRnv1Fx5DkVY8rJUUnln9glye1t4sSms6l2K4WhvwKjnpBvGxYgLs8i29HKFgtfkwf/paDpe4XkRgRpey9Cklei96BAHYGxth0J/menfM5pda7CMO7JwkAqOKrmp4SIll5Bzmi40XeXtvmQVMA8ADuqEdjKXBj7vV9dq0Qk1ewCnOllMc5MwawKEA4BjoclygMKkSxtFZR71dXifB3S3DIinsr49Eqzix3NMR5DV5XQITMM5p4GifjfAEsYJvzqbQYGYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtZi+T1HKTwRggoNHyrsufeqpd404rCNyZbTvZIOKq0=;
 b=SzpKNYKGy/6tn3EbGUVXpZBn3KAWfxJn1RtYywPs8H+QeB4W71X3x848/tx6vLcDC4K1IkXG1YD0I0KFw0P3WO2itj1H4NgxAiZ4NZ/1hNPryF59ZJKMsMlMC9AhsQO3ZqQ3/SAvSTEnjb9sNgdXO/gvr6IMltnySeATn8oNphzImkiN+cmEkZ7frFrdXyU4dBJyfQrcfjldBnZq7uBSsZiUrdsH8JRF1L3yN1sNfn5UnpO7SCs88r5ajiCVjZST/v+jLKfpZBYCnMTrG1OXE2mc6oqMNsCH5OsLdqFYDisbQNOvUDxk1o1KlA1CMAiTdPPJMftQRg9KlrL5Sb4QLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV3PR11MB8695.namprd11.prod.outlook.com (2603:10b6:408:211::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Wed, 2 Aug
 2023 01:09:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 01:09:29 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
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
Subject: RE: [PATCH v3 07/17] iommufd: Add IOMMU_RESV_IOVA_RANGES
Thread-Topic: [PATCH v3 07/17] iommufd: Add IOMMU_RESV_IOVA_RANGES
Thread-Index: AQHZvh6fEWZc+XbqW0m1tuFmM2sktq/PejEAgAP2ODCAAHfRAIAA3SWAgAEItICAAGrGAA==
Date:   Wed, 2 Aug 2023 01:09:28 +0000
Message-ID: <BN9PR11MB52764C401206FE8D7A4731628C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-8-yi.l.liu@intel.com> <ZMP+lvbhAwEbhjx/@nvidia.com>
 <BN9PR11MB52764E058BDC007FCF2F240B8C05A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMe14r37YkdOKulU@nvidia.com>
 <BL1PR11MB52710D1257B38E4627BC61118C0AA@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZMlNcRgMYatv/YqO@nvidia.com>
In-Reply-To: <ZMlNcRgMYatv/YqO@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV3PR11MB8695:EE_
x-ms-office365-filtering-correlation-id: 12298f12-ed24-47a6-8296-08db92f51ed1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SzR1IXptEHFkYnoBcQmP3vKlnA0dgg38G5cnRbYlPip3rZNck+RAXXHPkEy39Py2ThWHAN7ImHwaCak6EBu9FIaxlEYQeuv6ELjUy3wYtg3iLDcGKdZoAmjK0EPWFcceAXM3keFW/92WvdVLdZNWYx1SZoLFuVOlbuWWcgQwkjSMzwqo3PcxTCVGUHG6BXANln1jKeozY01gOnIQUfnycxKsvCnfDqc9+KAOZgLmabdqXzFWp6em1kmBBTJKBM9x2bwwT1/NJTJJ8HHYG5K1eH33hTYgWjdr5duYF3NdCaL6IHOtzHs+OxEHQwg85TT0cKIEA8g2Tyc82PWuNywvvmdX13/oJn3SU0sQt1Lw6tcKGlvaGJNn4H75YHA0pY3U8FS3wyRuKGD85vfJUiWEOs+vUYY/a8oTEH4PfbZVLLpu3mBF5M38Wl4uzkcxhQeGtAmHEmqpE/YMrRHgvRqnhShtOieuw8VrLzjdlfzMsfqGGpl4+rQwrVyftszD5Lx3nemPbaKhavEaY2iZdlRco+vj17ufG30fY0+VqAU7wzX+Vflx0bj7RXgnbjncH8qLzrlLCNe27Z6KpVdZDKJnwXKA3ZMIyLON/jDYld50CWEt5Zm2h3GxoJtYuFuUYs+s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199021)(38070700005)(2906002)(4326008)(6916009)(83380400001)(41300700001)(186003)(86362001)(316002)(478600001)(7416002)(38100700002)(76116006)(9686003)(122000001)(54906003)(82960400001)(52536014)(55016003)(5660300002)(66556008)(66476007)(66446008)(64756008)(71200400001)(33656002)(26005)(6506007)(8676002)(66946007)(8936002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yECtGuJ10RbTcquIZA0YFc+KCD9XzgCYXg2MXHEM5LaZFjzw74isixPPk7ae?=
 =?us-ascii?Q?tvvDREKJ3kBT1dp1bQTgy76AuvRQIXNKxG10LazrjbAvOdZ4jHXKoCgo9/qs?=
 =?us-ascii?Q?DZVfcKu4G99QlBcdfIyrsgHQTtHJwi+nfjNfQ4UMyM9Qk2wkozC2t9hI1/lH?=
 =?us-ascii?Q?dAAuDTWU8mcJ0tQQIJ8Owqu6gH5J9vnjSiTjNiqMlo/Ti7d2sVYPxIdDCMm0?=
 =?us-ascii?Q?keiJSICZUDM78O7s4MB83sFxQ1Zimwy/TDTxSfvR5PkwEsk3AuC0oPwh8Zk1?=
 =?us-ascii?Q?Qib39ZAX8FKGA/A5WdbAVHoThoMa1SjQA0jRVneqI/yr93zJ3v2ZiuoLAVgc?=
 =?us-ascii?Q?dzAizKKXMME/qoHOouV5D9YMNt+LC0pDr7k2I40bnaruIdsTkJIDtSP21p3s?=
 =?us-ascii?Q?W3veUVZ73GPkOnHxEcaVYKXl3dUCDPvVpnhpV9iVNHxRDV4VxGsoD7k99QGT?=
 =?us-ascii?Q?GMfg5DVQXeGrNFTzzS3HAzPRyKLg0nE7B2Omyh29lJRol83GRF1QKBcmR5Ms?=
 =?us-ascii?Q?WIDsXiOS2l/tUn8rNkhc6d0PN+TtVP2l4MyDtlxfVKoNEri/SKf+1r5wGjCr?=
 =?us-ascii?Q?J21qeWhSaitTF7SZJidS5NECbajhh2Rvr7ENxP4lhp1qW2UCSlg7swHmBtck?=
 =?us-ascii?Q?hLHOJmWdMp8tWtTLEKUe7Wy3cf/qlqZQME02MWfx0DpIAFkp8gGrYymGxB2I?=
 =?us-ascii?Q?t8IZwGNPQCTL2ifJCzIRTPY7g4phV0xQVuzkwOSzoarisaa0KR4SwejapaBg?=
 =?us-ascii?Q?eDpERJMRQrcn2h0kRfgRObZjcLycw/O38W+tQ7nt4nOAmupfSKZ/48+t/Fj+?=
 =?us-ascii?Q?Lc+npBSuM4CerTy05mdBBUBroRX/1weI7NS7Qkkp5FUrjvU1r+yYDqa+vzZL?=
 =?us-ascii?Q?CZTdIpuPtoxbXMdAJOVm6gQyjj+VDwyT3DL2FiWkQyalB0p/amEJlBMgVQSQ?=
 =?us-ascii?Q?q0Nb6lZyBsUoIVJNh+DC6Cj9wuRFgdjASfDNUIvOxcAO6Q4n7YibcqWnNMmq?=
 =?us-ascii?Q?6/DITwuXGF3PKn22MRECecQ2FIN5m+Mhe8+DS3CdRlF+W/1o0y0DFnlq92j/?=
 =?us-ascii?Q?A84C3938cgn0RlXFR0yxpPmxFImiKx505vofnTijcP7SKGZZ7VOrJXhHJZLq?=
 =?us-ascii?Q?FCgynjPGp0FsuPU3kbRxPMdH+o7SN5gbumH+3sdjkqlf+uX/nJXsIKp7ZJi8?=
 =?us-ascii?Q?JmOb8DD4qoUQVEA92Hn8OmU2lH5El+V31eSaZZFBhdo9al7+TnioDOPzsa/M?=
 =?us-ascii?Q?uyWRIyuhFUAMkKEwj9NMyBKa73AmyUDv27GEH6JrKYdpEU03zDT1qPQTArDW?=
 =?us-ascii?Q?2WME25BRkcX8X206b9ZwwKVeJWQ3RraQhpbgTdcoYoQ9bh6N45o8IGLvkf/r?=
 =?us-ascii?Q?dYqR6vcKRSbmHaZ+i/Fswf3+VrkHCoSNzX5CrP+CmGWPOJeogLRSfbIMxYsP?=
 =?us-ascii?Q?FPBbKDrs4dcNmgneKsgzXRW6JSsfOvZYXSiNB6Sp/cfDAPx/BBAO96a+flAM?=
 =?us-ascii?Q?bdtzKLBe7fEbq2n1+cl+6WE3BO/hdKZLvOrypXKLp2QMMc5eohyCpdQOIMOf?=
 =?us-ascii?Q?FsfhxJNhkKE/ZTID+EnruMLzp4iv7NNBWON4hy5t?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12298f12-ed24-47a6-8296-08db92f51ed1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 01:09:28.4545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2n8g/I7OvMIsKoitKjNYpOqjbuOj9aLcyj9o2k5pAb5yPk4SaxBWwVsekgQ7ozjWv5ckt5DB15nD01wRbi4FjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8695
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, August 2, 2023 2:23 AM
>=20
> On Tue, Aug 01, 2023 at 02:40:44AM +0000, Tian, Kevin wrote:
>=20
> > > So, I guess we should leave it like this?
> > >
> >
> > Yes. Along with this discussion (including what you explained for sw_ms=
i)
> > let's abandon this new cmd and leave it as today.
>=20
> You sure? This makes it basically impossible to write a "correct" vmm
> that is aware of what the physical memory map must be early on
>=20

emmm... I thought it's what you meant by "leave it like this" and the
fact that existing VMM's memory layout happens to match the reserved
regions. Nobody complains lacking of such a interface for years then
we may postpone supporting it until it's really required.

btw even if we add this new cmd now, getting the Qemu support to
use the aggregated list when creating the guest memory map is not
a simple task given currently vfio only passively acts on change
notifications in the guest memory layout. It requires a new mechanism
to enforce strict order (probe all vfio devices before creating the memory
layout) and then injects vfio reserved regions into the layout.

Preferably let's not making it a hard dependency for this series.
