Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DE7768BDF
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 08:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjGaGVx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 02:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGaGVw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 02:21:52 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E80510CC;
        Sun, 30 Jul 2023 23:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690784509; x=1722320509;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DtJhtGZLWLhniI99MrMC9DNivB6b401nedxCW1KjODo=;
  b=IbNckcIGvVW+/2PHtdwM0sH60nvKMFFBPiaOcAXTI7sTsxDP5c8ujQ6Z
   J7M4+2Jaw6OcoLBZJ9wVCMfz33TA+vbVjyGdcu2q/WZNon/+MrrehfF3g
   PEjWjZfb9oOv3H+omx7dFw3dXl4bz6FYaM4o65XjQZjTK8k63LIV5mXtz
   1XzL4KCrC2GjwGjrE+L2RIRSz1MYzhhZNfJ8bNYiq/4vdukE26dWwhwV9
   4mloYGA1PZq9HK44e3DQLUc/LWAF8mTsMcaHgWG76tRU4jxUhc1Ldx/H0
   eoT22flyEIICMjaZEa7kSNvkvNRHbrhsK6NPpPQAtuE7zSgPiLkz9NQ9Q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="353847631"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="353847631"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 23:21:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="851914722"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="851914722"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 30 Jul 2023 23:21:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 30 Jul 2023 23:21:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 30 Jul 2023 23:21:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 30 Jul 2023 23:21:47 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 30 Jul 2023 23:21:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/SRjRWWK7vqEWqWekb1rN2mLGgkioeYtJnHknDZr+JFLq4UxK4bLWPwIMO6yBMzMHTkeVWM6hYWRkjySdzaLahjNJGfi1zU8N21rDO/sA2l8exMP3kLoY/1pKidPpoPmzptYpeX96zKT68O9nMNut3r5jE2nvK2BJz4BHsDUTq9yWzYRQPQxXmbIWO8JcdawGu8RHwXG4Tf9qDM/coEsVliboL9X3aH9oA8pns/KK/s1ZL66tcFoBIoOhE+3uO4W2QnzG7ZaPOzbUMJqwDcp9zUjmVEJ/SAZEiuDg4zsDzMoXfVheVUVdsr0Cq/8dDfRSQxxVHTJd5ujXFpkFkojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtJhtGZLWLhniI99MrMC9DNivB6b401nedxCW1KjODo=;
 b=d6pO4OkUAlsQGzUDE7r5sj1FmIxhioOyHfb7ynFAFjtDJfmyDdOBtnuiJcLBs2UxumDRnb+50XcbEkgrYOTQC8pWdCTQ0qFbDGHCd/o/F1fq48DzG7dYWmKvP1cbO2MTKd52VTb/WGi/64L4rT6VX82DvhA/kFAEws9vBKvd7dpbtD6DwDeM6ahNyL+uO2jB7aUWcC5mWL//NJggYYwJNVDNOsG8c5PB+ZLlNbfKBdirr880yRGLmOxTBRI6pq/MTrFL/kKa9Lef0mLRqlRrpDva7cr+hBDecaFBjyIgkO1hOyYCOkb/XJvktpQN71TTY06ij4QFkY3pyRyBRbmXig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6289.namprd11.prod.outlook.com (2603:10b6:208:3e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 06:21:45 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 06:21:45 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
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
Thread-Index: AQHZvh6fEWZc+XbqW0m1tuFmM2sktq/PejEAgAP2ODA=
Date:   Mon, 31 Jul 2023 06:21:44 +0000
Message-ID: <BN9PR11MB52764E058BDC007FCF2F240B8C05A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-8-yi.l.liu@intel.com> <ZMP+lvbhAwEbhjx/@nvidia.com>
In-Reply-To: <ZMP+lvbhAwEbhjx/@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6289:EE_
x-ms-office365-filtering-correlation-id: 64f4fdda-3baf-4ad2-8424-08db918e69d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M+Lv976jCFWValwmAzyFE9hyaI9XAKaJMv1SX14Sv4S8zYQI2iXjCwszmN6rTAEUjSHFZFylrO+qDaYz/RIVU0+TAXPJNPODpVn7QE8oe65xEPJjQjRuyWGdKMYVp9Ci3iXDbEwwPR2kqeH/xH9eDrrNotfohaXXFnS5kq69abtrE6h9Rfmm7wFvg6CiIluHR/5opBKcBzBdHIUVdx0m9W5R0D+tWIxJvGDsEnD/bBj6KJ79U5rRtDliY9njy36v86Yp4NBagjPAtuXBwWi59bL7MXiCZrlXZEKmq8S3l2TpR8/Rt8MYD3e2hLfPxSLHi9AaofiSy7PvauhpbQCnDJxFi8nGbuY6nbx1oQ8OL8GIyPPykrewgVZ+CEkUgta3gwbrVhxA/XMiDhAsdUqigXrcmyeDwu6rMLZrlNH3+zi2/LH9PEv5BdBCGN5QA8KwuYK7bWpEpsMsMcTlGJVMmUofmbDv9vgG0T6z6RZ7u13M/0OfLhqYCt+W8eGauszAjENc4AQvCZYjJXKIcMD0lvniKxWlR7k0DE3ok72H2V5LU9xiwggbf0jx+/VlROiSIGmVmsDLEgNH5v8nIbZC7pTHMInQeL1LSEp60sabyU1PEScAk36Rwlyhs8VDdCLZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199021)(38100700002)(82960400001)(122000001)(55016003)(86362001)(38070700005)(33656002)(9686003)(478600001)(71200400001)(7696005)(186003)(6506007)(26005)(8676002)(8936002)(7416002)(52536014)(5660300002)(76116006)(6636002)(4326008)(64756008)(66446008)(2906002)(66476007)(66556008)(66946007)(54906003)(110136005)(41300700001)(316002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TdphI1DaBX60q7pnhtEQOOkNIfYnMnKTHPUzEFmEo2ExVmm7SwO/fUhMxfoo?=
 =?us-ascii?Q?AEwn1m8per2ZxUVltwAEdSm4YPXBW77IAc78hukCV1msnGWuSVYhkPzuzqr8?=
 =?us-ascii?Q?q/G3dvGoWmTcnIxuKLX28eKj3QHPkkg5mUbO04RqpSFyx+xyqHbbewfhPqWS?=
 =?us-ascii?Q?oFiF8Y+s4qFPXOA4c+BpC541FZKu7RTsH2SZSgN5A2ETmoL/5ImAtnjdgsBS?=
 =?us-ascii?Q?f49bNkSBMaqh3WESPuCNNNMhYTHllJy/s3A2pnzSgjlihG6BKv9bGGx3HiVe?=
 =?us-ascii?Q?C98cQEL1jNsMLdPCxjsjHQtsJrND0m7uBFH9Y9NwzU9LkvI8X08CC+RzWtMf?=
 =?us-ascii?Q?+CCHipW3rI0Gp71qdxRZlmsTBFV9dEH8ZAsd/JY7ANKqfWLIu3A5pRIxM31h?=
 =?us-ascii?Q?HsZm7UaH14vjt5hHmu15TM1UxcFDab47tOlXg6GilivE/zF5HWO5e/Mc+N/T?=
 =?us-ascii?Q?gzWm/2SPtvYaOu4GvWPaCsO316n0jM1HepgwujhZoJ23048BHZkXg7oRoJkZ?=
 =?us-ascii?Q?uqx9wudX3ISmkctowkQRlR52dlqAHXz9l99y4dNqKfRmo32YH0qojbCKyjMn?=
 =?us-ascii?Q?Se8gzqomyGZaMNrvri9jfc6jRkB6VKP/LhNw6Euaez3XrN2HdaqaTGASZBsj?=
 =?us-ascii?Q?99AVnmgINmZTGjtRYlBHrO2L3Flj0Uxm0mH68yviN1FI7dPPgQW1NyuLc61k?=
 =?us-ascii?Q?CFg9o+K44qnRA4za6CT8i2rRvFYnqUT2BGgHueIEDrHr1y/pxhivBGoRgsIP?=
 =?us-ascii?Q?rG9gdYmpQFFDcYbSwqIb7I1qPR7kYbIaZvx9zKEgRaYGBo4lVP14dZz0YOMS?=
 =?us-ascii?Q?LfLMb539zbgDV1/l6yhFB+J8Aft+zu4xrXpCT4W6miQsgCtan3gChearOWEQ?=
 =?us-ascii?Q?T/QRjHfy3OCpazr1xoBb15Zm7G9he7lGbNx34bnTvmFV+GvpddX9hzjvUfUj?=
 =?us-ascii?Q?KnqAInS7tXEdsDVeFi7Qq88VwErr/EeHhYn3pzTSrn0kJn806EmTWj2A2ISi?=
 =?us-ascii?Q?4zaYEg+ZW/Za0P8sXWPo/8DeErFenPIcqVWIo+Zb23UysQ+W9y2gtQemyHvS?=
 =?us-ascii?Q?QTq57k5/JGmyu2M5pxrJlGAd+4LaQJ6AnMjD77ebNnIRflByc4SakVUaF1+Z?=
 =?us-ascii?Q?3OEPaEgSIjVJodq/qTCbbN9Tkh99vJ5Evgcec2SY34CMKsu+Zw5Ph00pj33/?=
 =?us-ascii?Q?xN1IKxXqMt/JByX9caWYFKbmpz1ZXmceXCNiPQl46JoA+4XjNutMt6cxj6Po?=
 =?us-ascii?Q?L7QF3ReQkOZIs/3EZgcJowIT8BVLyJD4ZVXahtF/w7TN/DBzuw7lNYNoDkbO?=
 =?us-ascii?Q?Y51IPxVO6NfMcU91rHI4nJZBMqafumX7fiJTyT/ubHgAzBQhXRanzFrRIoL9?=
 =?us-ascii?Q?+/ToiGWHq40BFOje2ymuk+XUT44LtPOvpR5N7M76mgIGSiaGXAh9LJmsEMIR?=
 =?us-ascii?Q?1zxkg9eL/LvZjWObY9oyZ/JTqr76ppjOvkLH4tMrGE6DzdDRCDyZzUZTmQoM?=
 =?us-ascii?Q?Y/90NWZ9Oz8BdlE4+VWAwpKojI6eXWdiwscYnh8E+NxWdc9QFa4rEZoJ2Jxj?=
 =?us-ascii?Q?uuOEw9qO6ouYBoSSUkaPXEh/09r31hhyOsGonK/P?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f4fdda-3baf-4ad2-8424-08db918e69d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 06:21:44.9551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lviBg6C2hHJNSKm5P2t58y5WV70eraXSTEBjQeb+ZFAZm8LTwrXzN6lQVl5wc6yDAZzMhzpe2RoIbarAONbXEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6289
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, July 29, 2023 1:45 AM
>=20
> On Mon, Jul 24, 2023 at 04:03:56AM -0700, Yi Liu wrote:
>=20
> > +/**
> > + * struct iommu_resv_iova_ranges - ioctl(IOMMU_RESV_IOVA_RANGES)
> > + * @size: sizeof(struct iommu_resv_iova_ranges)
> > + * @dev_id: device to read resv iova ranges for
> > + * @num_iovas: Input/Output total number of resv ranges for the device
> > + * @__reserved: Must be 0
> > + * @resv_iovas: Pointer to the output array of struct
> iommu_resv_iova_range
> > + *
> > + * Query a device for ranges of reserved IOVAs. num_iovas will be set =
to
> the
> > + * total number of iovas and the resv_iovas[] will be filled in as spa=
ce
> > + * permits.
> > + *
> > + * On input num_iovas is the length of the resv_iovas array. On output=
 it is
> > + * the total number of iovas filled in. The ioctl will return -EMSGSIZ=
E and
> > + * set num_iovas to the required value if num_iovas is too small. In t=
his
> > + * case the caller should allocate a larger output array and re-issue =
the
> > + * ioctl.
> > + *
> > + * Under nested translation, userspace should query the reserved IOVAs
> for a
> > + * given device, and report it to the stage-1 I/O page table owner to
> exclude
> > + * the reserved IOVAs. The reserved IOVAs can also be used to figure o=
ut
> the
> > + * allowed IOVA ranges for the IOAS that the device is attached to. Fo=
r
> detail
> > + * see ioctl IOMMU_IOAS_IOVA_RANGES.
>=20
> I'm not sure I like this, the other APIs here work with the *allowed*
> IOVAs, which is the inverse of this one which works with the
> *disallowed* IOVAs.
>=20
> It means we can't take the output of this API and feed it into
> IOMMUFD_CMD_IOAS_ALLOW_IOVAS.. Though I suppose qemu isn't going
> to do
> this anyhow.
>=20
> On the other hand, it is kind of hard to intersect an allowed list of
> multiple idevs into a single master list.
>=20
> As it is, userspace will have to aggregate the list, sort it, merge
> adjacent overlapping reserved ranges then invert the list to get an
> allowed list. This is not entirely simple..
>=20
> Did you already write an algorithm to do this in qemu someplace?

Qemu is optional to aggregate it for S2 given IOMMU_IOAS_IOVA_RANGES
is still being used. If the only purpose of using this new cmd is to report
per-device reserved ranges to the guest then aggregation is not required.

Arguably IOMMU_IOAS_IOVA_RANGES becomes redundant with this
new cmd. But it's already there and as you said it's actually more
convenient to be used if the user doesn't care about per-device
reserved ranges...

>=20
> Anyhow, this should be split out from this series. It seems simple
> enough to merge it now if someone can confirm what qemu needs.
>=20
> Jason
