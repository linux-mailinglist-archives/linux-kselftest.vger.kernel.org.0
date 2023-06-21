Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB188737DAB
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 10:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjFUI3Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 04:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjFUI3U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 04:29:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27711738;
        Wed, 21 Jun 2023 01:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687336158; x=1718872158;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J9L+AMq5EaTwp7LSWkx5Dn7XEP4V3OIjMi0dg925fyw=;
  b=aRtoAQO2rwwsRJ/4mLMot6LF3lpE2xmCd1MUwwQlFFRdK5oioAYDuysj
   z3gBaBM3f0eVnJJirmm1gwbg8UAZ0/Aw3sqdzwB2APxGx6ScUpdePWcOg
   ecMY7XKxo+rB+PB+rY5hVr9Bx5xJvNOw5QzBABb0prhDvYHdYsf4PlO+c
   5TGKMC1sm6STD9u4KfRTsDjuFVUeY6RuEZ8zHoXSbnuUamfHurraylhs9
   vhibm9kASz8LNOfy1WIRrBjbwm1LM7APxG7oYczBKKgMZgI5mzU+Erji6
   GUQ4Ap6OPTqk2v9cfKOxP0LJQy4VkKvyf0ZneLgV263vJM/ylLeTaYuul
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="339726814"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="339726814"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 01:29:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="779765320"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="779765320"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jun 2023 01:29:12 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 01:29:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 01:29:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 01:29:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jr89pMkf1/QKnCAqQ2LiQX6UYksQmFLBNZPOuOXIJpEQ+bSz1MnrOSRARoKSJgAOjbCt/z8DC4I8w1Gry3oE3mTstXYeRf8oNVx1ic1hjP8G6OddcQe4Ef4pfOVatgMdoikDoVRHng+GX+eV7cck7K7yWn6CPw8E732nimWOD+5cYOG/tMP3vKutdSHmPz0FpO4gCHBlqfi6QOUGaE0Q12wAH9QnKda3G3doja9HKBH3Fs9jgb8QK4BzMI394C4IGpZT0PzJu/EOy8+DHlLWlRIYj8zoAlj7zPeXjD16hEkafRk9ncboHoICD38uHSiS5r86/DDwULslrdXoBDNNIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dboX/IC5sYCvY5YbRc0z93ezOlbEYc31nQKYf+jX3s=;
 b=VG5xh6mBM+16CFBhuDg71SINR9QID1kFYZLdKnqbnWtv612a4DOHK96UcAfEM9RY3AmHHT16CBqFsQbnTv6x6mIXZdy8gMantimC30+I8hS9uPKdE1F5nuEmBsuekB3n5SMw5kDDW6xJL4jZItxvixiVOYRGwBUYq+WkPNPI/oAQu9vdy59WrfGnAQoe4UwNjCQxARKqzzjWF0v1wq7BXDxSH7bNbIhvi6rA4dwm0kwastBQd3K+gDNUhnReYSUF2sSFF5RDZBvYt7DFPgK9zSSkDSKKwQ0j+8X1PTh9EHjYt1jhhRweWk4x4oefXMgL7P/A7o9gbiScB+81g7NI9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA2PR11MB5098.namprd11.prod.outlook.com (2603:10b6:806:11c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 08:29:09 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%5]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 08:29:09 +0000
From:   "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Thread-Topic: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Thread-Index: AQHZhBZTPfYFvaFemkeojX3Tn4M4A69haBIAgAAfs4CAB1VTgIAVHiGAgA71MYCABVzrgIAA28cAgAC5cgCAAUcGsA==
Date:   Wed, 21 Jun 2023 08:29:09 +0000
Message-ID: <SJ0PR11MB67441A87771D9140D1A1F2DC925DA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <BN9PR11MB5276DAF0A11809CF8433EE338C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZGdiS2m8jcd5OOt5@nvidia.com>
 <BN9PR11MB5276A74B2DA86C79908A420B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZH9AGWf1yRDu/86q@nvidia.com>
 <BN9PR11MB52763C7B838B04D3200322FD8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJBL8QLLBiwRsUSI@nvidia.com>
 <BN9PR11MB527663567ECB8AD52D3170818C5CA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJGf3sgLKr9HLZuE@nvidia.com>
In-Reply-To: <ZJGf3sgLKr9HLZuE@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA2PR11MB5098:EE_
x-ms-office365-filtering-correlation-id: ab1db489-9f87-4094-20d4-08db723195d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SByMN/PLpoO3ltsqu1VsUJZjitn4m1IixcQTBiWMN4Y56Fl5Do1PnmfH3YZvDRYgbVBSYva3R9fwIup+z7BFUxIfZaOk/PxsLv9mB8u1TqOZae/aI6aNgDlk1uTLBNZsqmJNs1MB3fZjXnCDQK8O+eP/Wnf0ljo0T+tg7/djalVjvCsfldPATuPoMynz/A2rGH6CH8TUzixUasDJcUgMY0RGH5uDezSrLBaQ2SSSxJOcbt9N3K4I/FSy0yrebDMtY2MKr/+CtJ+EsivekPisIdccCbbuHTPeBF9giPyZAt5KYeCIcUW6fVLUeQhtL1EVaSoHNZSP39Jmagp2uvw5HcUaunhcS6mJS5Nv63Q7v3JCkgH/3L7ASGXuYxd4Dxkc3SRHz7oJ3vLhkPZ/SICrLnX8Gv8CmehSBA6eXQ6gIMnOnWp4gZcPEftS0UUGC0gCQTDxFDUI/WXB7/TRBgxu3e+DiEJ+4SJeluq9qnR7NodmjOSwBAt3jYP/5bquqQYQcGrqidXyHez1MYNiveA4s4wxZdrdL73IlIyDsib8hMiujEJuWO3WbeMae9S526CPEIAs1s4CqmA4e8CXPK9IVW/noQoomtfX6THzSlUNJAU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199021)(7696005)(71200400001)(478600001)(110136005)(54906003)(76116006)(83380400001)(86362001)(33656002)(38070700005)(55016003)(2906002)(66946007)(186003)(9686003)(6506007)(26005)(38100700002)(122000001)(82960400001)(316002)(64756008)(66476007)(4326008)(6636002)(41300700001)(52536014)(66556008)(66446008)(8936002)(8676002)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4BiYAlC/oxd1NE5inmZZ2h/irA9xoOXvoQAoajdmB0pdi4PfCMnjX9ikvKuT?=
 =?us-ascii?Q?zoUzRsvGnd7tLR1TyQ6jT0k1+as8Sg0fa1loD3utB4Da3PNjt53d0pr7ovHo?=
 =?us-ascii?Q?bPzZFw0CnzZDbcRig/yIlpTr0voF/YBD/Oy2gGEc5zhvRunPRXZHVdfhmLx2?=
 =?us-ascii?Q?irk8LxGDamYktojUIdpVR2AmohMAtDjSjr7RPv+giOiufpdq1rxArapUyRWV?=
 =?us-ascii?Q?NEC7oc0iKm0JzDnBj62HNZV8i+1c2Og1L5QKewbgXl/4hGDBTOFO558+ZgJH?=
 =?us-ascii?Q?SM0jZ7o4wI5jT/HRkCI3ME0NLcl0feX1SlxqBFybb3duKd7nP0XfkfUY1Nkk?=
 =?us-ascii?Q?wMBg2NYb3hOj/jIK3+qpQCvIfQwxum6QIREJOnasSCqe3mUgOZkld5rQwMFq?=
 =?us-ascii?Q?ElYRg9ZKPmdERm1pk4hq1WOpml4rpbNc8Xx6prJ4EeMaXMaKnHCHSoezwQQS?=
 =?us-ascii?Q?U+gLAEuNTWh9UOusyrAMb+xEbd1SVq+xHRzip/62tIHpKdmziT0/bzefulWm?=
 =?us-ascii?Q?DsO8euyg7sc8lOukSk0CxaNF1Ua1ZGNuU6+xI5ccYfnbnXHs6tqoWJl6a3Cw?=
 =?us-ascii?Q?b3SnXGTKsp0Rbj38Y2EWRBLrEThvifXgcZwSsctt5YfOOp+LfMaWP3uKkK6A?=
 =?us-ascii?Q?VQQwuDd8ITgdTGRAfMw2vZ0kJ2gX7sywd6Juf8MeBSQ1uMUQEA9CqQwmRE09?=
 =?us-ascii?Q?gFZbVkGE6e7VpgcWVj/mfcJfGwf4IPHK+8/3NgCYe19zIckxDBFaPNPD8BMd?=
 =?us-ascii?Q?yEMAtVgP+cPJfRQj7nqRP34boulBg2TB3L7AKDTVwNjA2h63tw7vYPRWgl78?=
 =?us-ascii?Q?H5ZGzhYef5976Lb/77XXCq8hvk0J2J3Snv4D/Tl/YLHRJyQp3h7zd0j88uS1?=
 =?us-ascii?Q?MRaadP5BwMajotBajaRd3wbgegetqVv3L/8EudD6DbzsIyid/LxxXoDGqlbp?=
 =?us-ascii?Q?jYRLYbqJMUwayvPLnHQFsXrpTFi8B1U8wLx38pcApxMDiju2xXbu3mgJyjvn?=
 =?us-ascii?Q?yUq9S4y8x97TCge8znbJZpZF4kYP5hgm4mOw1KXzbXSCfgGXAKgRGGHi3yM1?=
 =?us-ascii?Q?J/ZhIu/42cPwvpIOsGWXW1hMblotYbN6lF+lUqdoAheEAUMfKdDkPQ+01oAl?=
 =?us-ascii?Q?RrUfcGp+kTnmxmYq0JPadH22Y/poxCHjQgOB3GQEXOkxp4XjEeSm9CZdc9tL?=
 =?us-ascii?Q?6mm3zXciCbJvwAqPgrhsOO/G4eRIZ4etEqN1c5gRwYpw4ieuzeDHvo/+NgFA?=
 =?us-ascii?Q?bQnEJ+qDutOC6MHhTo1vc33Vg1SF0NshP4wE0ya5AVYa89032XRzvSbj8cFX?=
 =?us-ascii?Q?Ltn9m5OUV2eATrEWfmRUwno/3C4UrKUUdod3WGjnNaduKHQAcVmoxXF4m86O?=
 =?us-ascii?Q?Qu/zG7KIXA7Is0yKF4Bji8r3j5QE6Pq0O/cU4JhV2XxqNjxlavHSqj0p8j7n?=
 =?us-ascii?Q?TX2E/KI8H+t/GZug9r0GJGwv16wqCUjf90szqNZFoNESkD7wHH0gqGLjCDX9?=
 =?us-ascii?Q?KdsHWNyTlY61wR6S/tc5xzmhUvCEfLvS5fdaPKCOJxmmcyQ/tpRXKk7how0D?=
 =?us-ascii?Q?Q3UJG+92TH+DlTbWMZZsQFhhLGp15Yc2uHCj6Tcz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1db489-9f87-4094-20d4-08db723195d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 08:29:09.5324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fUujk1zuSk8uwPtFJMOBQPwpkMGPS/M4t/6acgQZlIs0kN9bjnZa54nSB0B8IaW12bfg2/SRVqp/zPAOwClE9k0c27eIfBurgQEfbkubkbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5098
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

>-----Original Message-----
>From: Jason Gunthorpe <jgg@nvidia.com>
>Sent: Tuesday, June 20, 2023 8:47 PM
>Subject: Re: [PATCH v2 00/11] iommufd: Add nesting infrastructure
>
>On Tue, Jun 20, 2023 at 01:43:42AM +0000, Tian, Kevin wrote:
>> I wonder whether we have argued passed each other.
>>
>> This series adds reserved regions to S2. I challenged the necessity as
>> S2 is not directly accessed by the device.
>>
>> Then you replied that doing so still made sense to support identity
>> S1.
>
>I think I said/ment if we attach the "s2" iommu domain as a direct attach =
for
>identity - eg at boot time, then the IOAS must gain the reserved regions. =
This is
>our normal protocol.
There is code to fail the attaching for device with RMRR in intel iommu dri=
ver,
do we plan to remove below check for IOMMUFD soon or later?

static int intel_iommu_attach_device(struct iommu_domain *domain,
                                     struct device *dev)
{
        struct device_domain_info *info =3D dev_iommu_priv_get(dev);
        int ret;

        if (domain->type =3D=3D IOMMU_DOMAIN_UNMANAGED &&
            device_is_rmrr_locked(dev)) {
                dev_warn(dev, "Device is ineligible for IOMMU domain attach=
 due to platform RMRR requirement.  Contact your platform vendor.\n");
                return -EPERM;
        }

Thanks
Zhenzhong
