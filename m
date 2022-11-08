Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6190620483
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 01:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbiKHAOL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 19:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbiKHAOK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 19:14:10 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71D71EC7A;
        Mon,  7 Nov 2022 16:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667866449; x=1699402449;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lYc7r4g9rqFS4BndqqdhLkOFnpImUx7p0mbd3Uplmb4=;
  b=Lbc/ZCB3RBAk1FQG0YdpZUWE52XSeygKByrXZuH4A7y9NXs88hVrQ8lD
   RnwXncO/1rOSWUaJKF/Vom3Cogeuvqh105xMQW7odCwHkwTu9OwHQBMKs
   en8N/bZt1sMeahM9jA0vrmwTEudcr/RTP/AZM+8Az2SMLEyvJEIaqihkT
   3gXOP4WPvuqJumnwulqrvCMkaLOKK6NJTMwBVeIeU3kd8SNWO/HgMnRbK
   03lCGMMRJX6DFegWBjgTm1Tw28HFgJ6GFtveeD/Zo6o9sLkvuK65jq4He
   Nhb8sV/zj4aIvthBarfo2W7jJk57B4KgY37stlKwExzXuAOKgpx8g9/Uf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="374829161"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="374829161"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 16:14:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="811034564"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="811034564"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 07 Nov 2022 16:14:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 16:14:07 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 16:14:07 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 16:14:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVMUIx8fH05mM5TPJgQvjSzNkM1BcEfoUPh315NgXgekz4gpettBFti3f4v96gdj9KSvYbPxLBaiRe4OqNsU+3NZq8ym2zpEB32wfhCNYIqyf4XC3N+7Fh2XCrzS4phk8VfhtSJxW4UJz7pVL3w33V31bGRiyjTGKFS0O3KdHfLc2npP8ljme2OcgZVOXuDSlm1A3RMAt9/KGpmNo4KQI/ZFKrSiS9GHcthktoy9TZg3BlgNyy1DreXCJtPvFULFUv9AUvMEmEUCY6ji486tq2pDvUjpslYJ5k2SqAJKlEiKHQrz38uWfUOxCEE3ctDrE6cts0UQh4+8WvhKplFlsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYc7r4g9rqFS4BndqqdhLkOFnpImUx7p0mbd3Uplmb4=;
 b=dVGs7yG8tNj7ESWb6fse9HDLrm7eRLB58LQM0G1qVHExh9/+HzxYeGQe5k1nfDdbGNH2oo44zIke8wVadHqSrTSUjDb3PJhYucuwTkDSle7WJP0Z8w1kEvtGnZhZ+snhaz+UPpGaj/gr3Q6+eyYWRekiq69Hy9XlmmZAf4Oy4rJmRd/Wuqf899kSFsSqccBf9aH99W0Fmf82b85O+ZcnB9nZwSMeL7QNbGd9QpbYwY8ox2O+6sk05mpK3sAkJryjCAkN7E9NoTbNzUalw3cMUnlOr+807GbKUL4WK2224L0Gv5vtV0BPyoGcjZKKKzTD1W8D6XSi7ITfWL1vqo8RlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL3PR11MB6362.namprd11.prod.outlook.com (2603:10b6:208:3b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 00:13:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 00:13:55 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
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
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
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
Subject: RE: [PATCH v3 14/15] iommufd: vfio container FD ioctl compatibility
Thread-Topic: [PATCH v3 14/15] iommufd: vfio container FD ioctl compatibility
Thread-Index: AQHY6J1rgVJHY6EaeUmpkBEcYy6wd64wHMEwgAOpDwCAAG9EkIAABnCAgAAARAA=
Date:   Tue, 8 Nov 2022 00:13:55 +0000
Message-ID: <BN9PR11MB5276411B47AC310E928BCFDB8C3F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <14-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <BN9PR11MB52763ADFBACFE7AFE11F5F078C3A9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y2k7fkxSzxTPTXkN@nvidia.com>
 <BN9PR11MB5276EA038EAA0345CA0ED0438C3C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y2meOyG2zY4iMupy@nvidia.com>
In-Reply-To: <Y2meOyG2zY4iMupy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL3PR11MB6362:EE_
x-ms-office365-filtering-correlation-id: 69744265-9fa5-4801-abd7-08dac11e1fb0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9lgbFHWKNXBNKJUEVtUtvHkACPGPW6UXN6PXKeUbgFRJjId7lWZ8TzbA3iR0RKAZ9n2ccWZapTV6giPbLk3R96aGbRRIlIyMMnyEAQTspROfiRIsq/mdqia4zQdM5PEPX0uRevGlWPjiP8LXggkJeWWOe7OJfLZncWpEAUhekkqzveWI4CSK2XyK87AyRyRDwaJYB8Nl3PgfD1PefZUUp7zoRNdk426TxPQ6+eS6I2HEbFMNN3jcFkKu1RgqOpbKp0R+x3X+oE6foBi8GbGdSUE/LkwU9gUL9nNBxEwe0nbibOgDmPWC2ifYJMJ4NsqkMcwJqiufH8XrpxIkQOxEskQE9HcgoTDbfyg2V43m7S7554GhrvRPsMLxwrf/oVNnuhnXSd1eiG8ruxAHvf9PYDNUFfOxUeoatSDVkmSpoof5ZrFt4qvKHe09xvxpAdPRPAo+xz9e5D15bg6X6oLnqHJXNWGwSgEKQa5DSf11EICdiPWCJnVALm+FHKlg1k5E9iBKaqpRK2aOGguRuJQsT0IUUGzr9Y9r4namNtVzvmDL1lbZ+0gHBS0MS5ze2kfzBN50PWn3ZP0TGgpyrGLyy2Q4DP1JVkGJrrz50apqfuQARArzOQzFNoWbhMZ5FRO7ttVdpQINT0bfLmwL3t1l0shPkSV098yILmrncd4d9AosYXsljEzXwCi1c/3eHH58IvTI3/86jFMHzKfkWvAEj9nEQWktfHsXNVtZOaqU5qGWU31H9VLbD7nAzxpi1Gw5j5G/xFnVtX7VrdOB+nVuWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199015)(33656002)(122000001)(38070700005)(38100700002)(86362001)(6916009)(55016003)(5660300002)(7416002)(7406005)(2906002)(7696005)(186003)(82960400001)(6506007)(9686003)(26005)(76116006)(66946007)(316002)(71200400001)(54906003)(478600001)(52536014)(4326008)(8676002)(66476007)(66556008)(66446008)(64756008)(41300700001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lMPUZVyzVwXBabWz0lNfw40CeBLaeQAvkZPjGxTluX3qepN8gVv7PJ+2Ac6Q?=
 =?us-ascii?Q?OR31RkW+Ch0cZA9CHs2EY/2TPvY+te1aNJv07kaZCyT5dd12TdKrl9G1yw/a?=
 =?us-ascii?Q?KrcX5720z+Gprj5N4wth/GIaqyIWSX24XjwA1PfNkLKLgyiQEk/SGvkxtWX6?=
 =?us-ascii?Q?91IOwtOR8uGrZckAazac1jhmy3gH7qhvnBQ0z0uWqhba0l1BLBea/z+B8GfJ?=
 =?us-ascii?Q?d2tjqIAt0XhdJrYp8YuwPfLX0if5L5igKcQgkVavKDtP/rnb1CPKM/Tf1Hsv?=
 =?us-ascii?Q?NjLiLhNcfvrj76BWXJReBpkOJhWudnRiF3AJ01gIM/7AEqv0CSxv5sRjPVum?=
 =?us-ascii?Q?r4lsQLrKPfq5LrvKD5hOKwwQZ5qdeLvX472rZuy9j3Phvva7xA3SiSax/xBO?=
 =?us-ascii?Q?KPVlep8gLdpPQcrlbNmrxz6amn2NPtDBLZEeTXZC20/SNckTLUVIa/pemeyv?=
 =?us-ascii?Q?2w5F6KS1jM9vgVgnNhzWnvOGrvilVv+xVNEe0ET0ex7Zz3gY3VdZdnNm+6GU?=
 =?us-ascii?Q?k9OdNIKoj/DX+8KKuMA30+XOx4fngdlfmw1qulG16DWQHj8XhWQIkCmaK2Tl?=
 =?us-ascii?Q?wwmUIvJqawTnyVk36xEPiXg0LiHDmCgjqBSdLnTzJiR34mWd5kFAKWggbhp6?=
 =?us-ascii?Q?Djw2lgYh2hWQYZilmAtbLCrbU7ITxSoqKknXgRex+g8XG9Pa9nIPvwxU/Rns?=
 =?us-ascii?Q?gYH8bf40H/D1MZp2nkJohkcaEKxylSRcc2dmtlnqsHEW4j7Ia2aQeQhbebRv?=
 =?us-ascii?Q?VQJ/KsqmySWaUyGiv0YmZpEyT6Uw29Kis8G91+Dr8Sk08O1z24hiB/OfKnGL?=
 =?us-ascii?Q?+V8Ng5CWAtoLFqWHyxZG8UZnfXsAgoiTJJzLnu4t+/H3SPNtHKCdBSUUZ/EF?=
 =?us-ascii?Q?B3e5Dt73ydxH9lko2UDq1YGqYXiHvFhzY7UDzEEqlZpGrfN/+kYCzywgQPwU?=
 =?us-ascii?Q?/DNa4GLqW1TKweN7FOcqXjyfuLe+seFbS7CqJLD8GA2XR3H/MZC86K7Zja5t?=
 =?us-ascii?Q?xmY+gOTu5SNTrchSZoqxyXNZ6jTFrOjoYXbaTdcmzbgkIDV7VdHQhVwzTrzb?=
 =?us-ascii?Q?ITu7x5KBD0R4q4z7JZm/QD59zPSnWGzfsHFDg/PYwwkaSKi/QsiBpuTEfuga?=
 =?us-ascii?Q?4eVv5pSzg49xqnvd1xhVep1nnnnl9bhrnhOq7esNL1upC2aDOmTMd5mWCpHH?=
 =?us-ascii?Q?7lsglXvFw7wLHkhCz1belYl31icppa8zYWUSjWFAD/7ezltXf8SA2x9UVm8u?=
 =?us-ascii?Q?UTjJGsRUs0lSUofF+lLOSpazjOKlK1dmhBBoI9EHYUXJceF/LUas8CzEFKED?=
 =?us-ascii?Q?e2RVU82+zzRyGDMQpVXnjAnmuolbn94iqHGBova6zk+DFzPro9RnGzbXomja?=
 =?us-ascii?Q?chUDUcmlYDF55WYATx9D/uq2E9hbL4K9/95SBYO9qdeZP3Nt6bSSbh/KNXan?=
 =?us-ascii?Q?E2+3+rFaf/E3/0TW++2kKlcq42jDTAR9Bj1a2Fp/l52Ne7+pwVCNqRWuIkTv?=
 =?us-ascii?Q?mEie+7pFYF6o9odCsbp8qPJeLkJ7oCfXDlS50wcyieeMGOANlrrfaKAsXue9?=
 =?us-ascii?Q?s0FuXnd4EKXk+Rc8Vu8nQvzEcm8Ibw4nFZMq3JmL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69744265-9fa5-4801-abd7-08dac11e1fb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 00:13:55.0729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iW8NRuNHzdPbtDyDoY+JUQ5k9cy3fONBoSbxDEa3gRzBy7KhL12sBDEYvjsH1xXn1671jPSasBBs9pTtUHfrtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6362
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, November 8, 2022 8:10 AM
>=20
> On Mon, Nov 07, 2022 at 11:53:24PM +0000, Tian, Kevin wrote:
> > > Other than that, userspace can change the IOAS it wants freely, there
> > > is no harm to the kernel and it may even be useful.
> >
> > it allows devices SET_CONTAINER to an same iommufd attached to
> different
> > IOAS's if IOAS_SET comes in the middle. Is it desired?
>=20
> Sure, if userspace does crazy things then userspace gets to keep all
> the pieces - it doesn't harm the kernel.
>=20
> The IOAS is bound during get_device, and that is one of the key
> conceptual things we changed with iommufd.
>=20

what we changed is the timing of claiming DMA ownership (from
SET_CONTAINER to GET_DEVICE_FD). this is fine.

But adding an interface to allow the conceptual 'container' tied to
multiple IOAS's is kind of overengineering IMHO.

yes no hard to the kernel but also no benefit to user. It's simpler
to constrain the compat layer based on what vfio legacy has today
and then position all new/fancy usages with the new cdev.
