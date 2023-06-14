Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF18772F770
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 10:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbjFNIKz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 04:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243600AbjFNIJc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 04:09:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBF526AA;
        Wed, 14 Jun 2023 01:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686730161; x=1718266161;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CCfcdMfnrRFbA50VDNIAY+0VkjRL4W1jgv8pyQphDhA=;
  b=KmsGmTFbZD1L+ZshudheHlokF3O5+jpPoFLGs0pbkI9afHqbPCnhSEeD
   7ZWqOURu0M7j78sCFbJmTOM7S08EJoNU6UW4EKN0degvo/b4yTWNaMXBv
   HCoPPFCeznfTAhfSbp2xXH2h3JJyYIc5wE5ma+mOG1y/jnXaPdDdx5wa1
   g6fQzS6jz1yEVdmH0SAzWx0vF7x9/YT953lfou59bMVnoiBakbueq8oKp
   vXHI1mLXYB+pzksvBd2o2dM8dL+umsEVcP5ERp1caDU3/g1WlWtMrKosz
   Fl5bow3QPlMIiWz01KN9Rqhtg8c6XbRpL6Z/C7YKlm/4b+EX9aVCdgOEU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="422150029"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="422150029"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 01:07:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="886136948"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="886136948"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 14 Jun 2023 01:07:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 01:07:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 01:07:32 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 01:07:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nisW7UJPp4ugrwddRta8FVz0Pey4tKdlWRRceu3dTqVYoVrpM4v2IRqWLWU54FY/ThUHy9dSR4q4UuW02TrvJ7hwP2Bo5Ff4TQmnhg5McdegnWoF/pXeFVjmgw586NeaJDj5+IblC3V6avoZ5AxIKcPWXCRbNO0GYNQMi6WXV5YTPJvBjMMbtOsFyld4K8eWNImlKbko3CYqA6V/6o3cEY6y0bi4kBxfH6KLVa7e+9fL3WMJivs2LqI/UsQ+IaS/7OPFgMm0xllk3suuArKs8AL8gXnZ7z0Rl5umCYcUGxDb/wFG96aFuzot7zIwFTjKLQvisw5Jz3kGHo5w7g8v/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCfcdMfnrRFbA50VDNIAY+0VkjRL4W1jgv8pyQphDhA=;
 b=fCz5gS1KUdTSTUoj0WmU+YOn88Gp6Zwp6h400V/MA9mKOoVZnVKAen02EzoTLkgHJxhqZncrh5NyJA9SEA5Am0808xD2BO86mK0r1xdVNs1FrDIHCKCroEI8JX5/XDl4PobZjgbZ2sPce2Of/jKiv6jSJrQ/R00e4/nMJi8n1MemrA7AQz1E5Mg2KxPcG6xzdPcmURDCxqeOPjKuZb4gOKQCnyVpd4tEt447RvQCzcLwa3yJ1v5FKTXXNRrb7zzUv3LnQIFF8ZuTn8bkxCYHw45kVFy2P79WAT+Ni2ixdy+d18HIV7mOcsK3Mfqp2EQYul1zPUzlQ9853GXXKDmlSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5243.namprd11.prod.outlook.com (2603:10b6:408:134::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.38; Wed, 14 Jun
 2023 08:07:30 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 08:07:30 +0000
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
Subject: RE: [PATCH v3 00/10] Add Intel VT-d nested translation
Thread-Topic: [PATCH v3 00/10] Add Intel VT-d nested translation
Thread-Index: AQHZhBgNtWChyqGR00+u6nwW5Oa+KK9pLIFQgAiGGgCAGHH8MA==
Date:   Wed, 14 Jun 2023 08:07:30 +0000
Message-ID: <BN9PR11MB5276B15B4709F595B2A5A84A8C5AA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
 <BN9PR11MB52765FA8255FB8F8A1A6F11B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZHTyNgnjj/bOkIgi@nvidia.com>
In-Reply-To: <ZHTyNgnjj/bOkIgi@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BN9PR11MB5243:EE_
x-ms-office365-filtering-correlation-id: 06a8b3f4-c25d-4b46-d496-08db6cae66a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FYsEXwYG/v9k+855EkL6dhnVZTYWRj5RfchOEWBPxxaQU/dl618m2IsFxDvQn+Xgx+f/1K9vklTwNaudm30nwVfkbzMAwxwr/xzWE7AZ22W0dn3Ul+a7L8Ly9B9kFuS1h2kUxd40LM+H/jQW0+fkdOGPRRentX3EvMNeUtINWpTDFFwv0OnpGdTMLW5AMHXPD8PwlWHcx07ppu0/H7surPAugf6zMSvFkvNrK4lrHCX3+YyCQFKwOWpcfnkkmtFNgETXMDzxVMPY99rMIn7QWiR0he+tTsfFU3Zw/aPqwWTuUQ+Fxe2cmrKdzKsvcTNWVSDvaN25Zl5rWzpqyl+3cFzOnxq5bzX1GoB4o5uj2oLxoXjgcOO3f01GAf166lQPo84yyoTTBpYy/BTrw0VCnmgzz5cD4eA6fsX0bvG7FyoszKGR3BO+bE/pyFEmZx3u5oXXtEiWT8W88fVTfqXaHq2u1RJSNiANBUmdKgOXIPkOz/LyzwW377bXBetSeo1iY71KpJDCnEptt8E7Zgi/a473rVKjBaWDkA6hwM/7/VtdZg+GGrLtyXg/vqWjgEXqkXnjYEcSMAzDLJUubaqy+Q0xwL1ZH2tQ3Lex3UWqFRre0gZeV67Y3uj6XgWch56y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199021)(186003)(38070700005)(38100700002)(2906002)(33656002)(4744005)(86362001)(7416002)(9686003)(6506007)(26005)(55016003)(82960400001)(122000001)(316002)(7696005)(4326008)(71200400001)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(6916009)(478600001)(41300700001)(54906003)(5660300002)(52536014)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?avNwTYFAoURwrFVNkoSmOJUKGOKVl+iGjv/x0I1qQuN0tj6WRAQ5t4bcG8CX?=
 =?us-ascii?Q?YXGn7pN7lpIDBAcbKRcCZiu3dGKsG5pjWed5q0QntqYUyZNl4QrROnpwLh5C?=
 =?us-ascii?Q?PC2i6V0CXvgk2aAqJFpIb+HNy/5vpbzch4Dmn34jC/K6t18/pR8ZOrHfMpSr?=
 =?us-ascii?Q?phL7JRhbmCEYGwDkj+iGHPyfFQ99ENTL3RKIrol2F3N8CZsXy1eZgee7FZRb?=
 =?us-ascii?Q?cPQS5KYMEBUUTAhxUvQqlJ1TpWwxsCzYgqNE2mBvtnze5/c6RO7dcXnIIIrz?=
 =?us-ascii?Q?7kIjabSwwpAsPHgf/szVMoiayUwsP2frPBkUjn16z8TRRh697pFM8CSY4plH?=
 =?us-ascii?Q?2xzRtZsN9oVi0Wof/TRlbPqFCPD9iNRq365O+/ExoU6Dg6iUMBFI8LEOyPXH?=
 =?us-ascii?Q?313wjv9uogkVXdA93k8GWacRz1leHaSs5/1bDUubY6lSoMBJYyWd8vKTX3zH?=
 =?us-ascii?Q?BXZ9edCG/vAvAnB13BB+qHLm8w1Ve2ge1+Q5cLMxNFiY1ye16qC9Nse9NzNu?=
 =?us-ascii?Q?KbVs/dqFN4auBaZMhAPWiQEFWdFgpZk4t0luv9bprFPTB1D3KjsNoHbklSyD?=
 =?us-ascii?Q?WUR1OmMd7/hgP4DJR7Z42YE13DSbcL9cDm5QTy1QZtebKtjlHWm2EOpjAuBJ?=
 =?us-ascii?Q?DScgVwlT3yHzXQY8wL5b20lUcleB9/mr5xG5SwmjfiuPX12w/Fip/vbSnez7?=
 =?us-ascii?Q?x2dN3lnnoU60rbEgC3tx9n3TH7tU6iVgvOjAWqmyGdZbop8IiSXsW+ZJ9KbQ?=
 =?us-ascii?Q?i2rZTqKJYY4eLfHxO6/2ruLEhBipgGme+C8VWlQjyNblWyph9c35TZyIcSpu?=
 =?us-ascii?Q?T2Rbg/OMTIZL4+NLGIHxxrLDU9fMxvAimEYwya+NST1BNN3Bpxqxx+SM/oHA?=
 =?us-ascii?Q?rnUUgDWVjIXvKbhRB8/hzt/ZKSsAZDWgDhSGDptIjw+OKde0HDvIhgEFGJOm?=
 =?us-ascii?Q?wNmwbJmVNSExx22i+vYd14b/p1sn0VgpulGDwOywkb2M6pKVxyTQo4xVbIcP?=
 =?us-ascii?Q?xbkMNWsnorAp015hLxMn+RIZQS5lMpnuQYl3Ep8lQHgtITPOTsAcdWXZfV5O?=
 =?us-ascii?Q?OVwlPgAq9GQRgGdQnqTxPsRQDj444PJTFCF2QJhef7F1qyo5OiZlUFvokcrL?=
 =?us-ascii?Q?ty+uBFHbLt724LHnNfsN581mkwnxo7jyRyDrXMoPyIj6g/0C66VWNHbQW/AF?=
 =?us-ascii?Q?fkDBa3ai2ERooIuq4KngHy5xwevfRqFAR5a1Ea5Uf4eNqxJXEZO5AcEMoRlA?=
 =?us-ascii?Q?wkfSxEFi48xnEAUwQm0H5gpKyjwA4csOsCeNi1NThvyCAOkS3aFHtMDMgVv4?=
 =?us-ascii?Q?KvFlFb7jFWyRoC4K0noyozhZY027iAZJYYwXkMhGe8grbvoSqNX7hiEs+CxX?=
 =?us-ascii?Q?md+rMWwPJ/FJkZ7JZQUqvtBAoayJXoxnbk0Gm/xryIi5OLmI1a2PqQL1Ypth?=
 =?us-ascii?Q?sSV+3bm6/l9Z3GIqZjvOx0LC2yrzmoAbz7JoQz6kS/meJUnmr4js3N7CXbhQ?=
 =?us-ascii?Q?K/r9E0/B9O8GVracpjguj4nxZKoFDZCVfhHina7jBKLMV2wHTK3oLJvRYj/E?=
 =?us-ascii?Q?Yddmse53uEtymaN8hmikFdhpKqJlqy1WqJJ8LECW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a8b3f4-c25d-4b46-d496-08db6cae66a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 08:07:30.5052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GQcPoTkXST1Cw74TIvneGQ913tJEPM/d5T2WGNV7I38s3fDPhkwE2uBXcOvQC9ke6AHND5/a9U3yUA2+/brRqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5243
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, May 30, 2023 2:43 AM
>=20
> On Wed, May 24, 2023 at 08:59:43AM +0000, Tian, Kevin wrote:
>=20
> > At least this looks a reasonable tradeoff to some proprietary VMMs
> > which never adds RO mappings in stage-2 today.
>=20
> What is the reason for the RO anyhow?

vfio simply follows the permission in the CPU address space.

vBIOS regions are marked as RO there hence also carried to vfio mappings.

>=20
> Would it be so bad if it was DMA mapped as RW due to the errata?
>=20

think of a scenario where the vbios memory is shared by multiple qemu
instances then RW allows a malicious VM to modify the shared content
then potentially attacking other VMs.

skipping the mapping is safest in this regard.
