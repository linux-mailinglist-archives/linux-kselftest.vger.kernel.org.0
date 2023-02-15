Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6FA69743F
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 03:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjBOCQJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 21:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjBOCQI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 21:16:08 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C87A29E08;
        Tue, 14 Feb 2023 18:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676427367; x=1707963367;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3dpAAfGmGYENyrl+OR+NBhAcI4Z1sDvqI4OQ5m/kRKg=;
  b=hd2t43L4R08V8/pL96amw5cMYam75QyPhAOYL1Yh7xSWdFnXQazQlq99
   SgMeqdROtYGgCHMSDIKpoUVJpJLHxMvHo3JW62Jm0r0iEmkkgRuIbjc3Z
   e13SIYkME91eQNPVfWo2cOsfRcpDASVB1LY5HBs2UCokrVenFGVBvrW/Z
   VjKAYx++eRya273IES7DjZcv8NpxSLI2Vr/BVoy/Z2nOT/lDufpKB8gBp
   y/mWMR2ftNc/FeuXuv25MRLA9iLYO53RADqDbO8yePcFSAHOrY9ftZ+2c
   BBuH+lqD82gG34QqbQc5gNtdwXo+d1TLVt4J99/gw3Yo9sN/Ko4DbeAJr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="358743370"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="358743370"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 18:16:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="793316600"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="793316600"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 14 Feb 2023 18:16:04 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 18:16:02 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 18:16:02 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 18:16:02 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 18:16:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frYuDptog02RZgyHjroeG0NTnYmHP0oDl8nqtTCo0mMVtp4ZIPt6nmsGktsOA+J9diBmyPJDVhpQ1HcoV5k5nLviOoVQXH4IpeU1FDGsuhY3frtdTC4rBgpj41ZNLqRZtnnHBuKKvCLxBOumu/97p9/1bEoWqYdy/DV3RPyCUPhEyqmdhV3VzaW+1xGR1JFcwx8mvbBV6TiOsC4T0a+qFUOvZ1o6UzlSf3WkviTe0bnH7fCxyHmExmsOTkQjzW36m+xRfPU9t1HMhB+jlMStA2qPQYaOpunDrPckUxsITnov6MIU8HsajriPziZibi+gFvTTcux5apC2KO2MXgluRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaePTqKFJepw93WDPR3A0VhycAhFQKcZ/cRZG0GN2po=;
 b=n68My1q9UN42M7pamv/Vd680PqS5klYXhG79iUJLFCSY4ABI3ZBENjC3bWvILhvfjjQ+bdyshBhxabPIclNoWvvDx+wS2yw34joUaEvC2YS8QsD1VsDcVXuZT4wD8mIYHURplXHwOkQFypa2Roscmu0xRTb9LJSXRLsxbMG16t+TH/Ni0GN7OcSqeIDXry/0o99GJs/t4rsSusdYcjIL615hNSC6coMIq02Dkv0dWfUU3/M1CEXlCycDr0J7ncOkmQbWvh7UybVrae/K9XsKEYDELe29O64WnkBabQdbX2vyVQ+2vQEB0IHiozjwbqUFfsGQ8EoxRxp2q/oEMM7l9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7732.namprd11.prod.outlook.com (2603:10b6:930:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 15 Feb
 2023 02:15:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 02:15:59 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v2 08/10] iommufd/device: Use iommu_group_replace_domain()
Thread-Topic: [PATCH v2 08/10] iommufd/device: Use
 iommu_group_replace_domain()
Thread-Index: AQHZOzoV+UAbwLQwnEuO17sJd5b+0K7F+NzggAEnS4CAAE2/cIABdh8AgANLy2CAAFjcAIAAdaUAgAFQnACAAPZWYIAABlAAgAACwKA=
Date:   Wed, 15 Feb 2023 02:15:59 +0000
Message-ID: <BN9PR11MB5276FA23E61977389D0C1A198CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <4653f009c3dacae8ebf3a4865aaa944aa9c7cc7e.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276C1807B710CAD3E5820D78CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+Vh479cDD7LX2x/@Asurada-Nvidia>
 <BN9PR11MB5276268D3ED0360913A05C368CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+bc8OrWfw3Fq57n@Asurada-Nvidia>
 <BL1PR11MB5271180A1DE8C739455AD06D8CDD9@BL1PR11MB5271.namprd11.prod.outlook.com>
 <Y+nrTsIz2UHH/1lD@Asurada-Nvidia> <Y+pN/vtO8I/oiMOJ@nvidia.com>
 <Y+toXAUa2Cbwn7I0@Asurada-Nvidia>
 <BN9PR11MB5276CBCF780BD7C61154BF8B8CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+w8TJ2jfDATftbr@Asurada-Nvidia>
In-Reply-To: <Y+w8TJ2jfDATftbr@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7732:EE_
x-ms-office365-filtering-correlation-id: eb39a4cd-e5aa-48da-f00d-08db0efa9432
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RerWB7s2nmtOkkWPKwxx478UE4JFPbKolHfNyCoAJ1pBAIGyCTSPCuwWg3sO54h0Q9BBCB5nrwEHT6qYs616jbEgini2gPenZnQqP19saHgXxLt3Z1lwCyzhkobQFRArrsVH6g3NpxDARE4tp8ormv7pNPv3XeAq5thCxCaTFzVkKCzo8kW5c6miGKOe4sKSWyPx2A91N2T0OZNXtfK1VZIo0CWQ8DCSy7L76f4v+U1Xjfv/LxUQwU+7aBVm1/6RA6n3glO5kv9SLNdLhGg+RQz6848iC4UPeeEsWeyLbStCtNHYYXf7SxoXY3kXsGQMyPqHfbu4ZU2Gn7EmfPB2fLVLBqbn9WAv4fmfKCAhdJzi0eu6PERa93sgiV524KsP6n/cwK4FW5PqBlyhXw+FhLhHprzyETizkCaPGxY6IMm2y3qtlmxpfBpGEwPS5ChT4ZNte3n0u5xB1bBTngd1WmlQWapI0NnOhoMNX4Pf1KuxZI13mJk7gL/lJSnpkG0cYVxKzPawu8iQ8H6RaUG9Ut5qZS3308J9mFwnQFLGXumGOIdRN0Fjs8B1Nu73PgVfzFI7GieF6yy8sp11bOGe3j6Rsy6L+CZndx6Rzm1ay/65i+Y20Un1BVaKqYIDEjw2hGODQEyfNZPj1kr/8lbpIj5hS0n5nNkY+8XvfzRFU3OU4QUS9hVCv6ydchqwdE7SZnOY9K20C5S1qDuQCBufPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199018)(7696005)(83380400001)(66556008)(54906003)(8936002)(76116006)(66446008)(5660300002)(41300700001)(52536014)(316002)(6916009)(64756008)(4326008)(66946007)(8676002)(66476007)(186003)(9686003)(26005)(478600001)(71200400001)(6506007)(33656002)(38070700005)(2906002)(7416002)(55016003)(82960400001)(38100700002)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qUsGKEbND7rgyZ4p+vRAE7/MV5iGOz/LNWZcLHkL5u+sA7UnC8tlLev1Ar/e?=
 =?us-ascii?Q?QLTQuB5o0ICxdAjsT13a4dUV/Hk9eoQjhLbA7dEAKQD5f013/9VHQZeJft2s?=
 =?us-ascii?Q?Rmlo4YuE6YWoIyOkCtDPjuAXSFfljW2iDZCBxIdQvJhqBF3EmW4wo8DWPtHy?=
 =?us-ascii?Q?BNogETLodYdgjhulUkqx67vBTG5qj9SFV0h4ihwoyxGBdPzGLNiVB12JktR6?=
 =?us-ascii?Q?t+cIx33q74iO8nJUlneQSJ89dZCtJy43jOMOHeXRcAKNb2ZuQnp3+mwN1xLy?=
 =?us-ascii?Q?IwjLNcGSqaEf9SK16uJYHiuWngoUVbNMwNJ/m8WCs97r9WDK++P0e2ibcCEa?=
 =?us-ascii?Q?KHG8hlMjA+Kytp5thejl9E7gZIHttMxNmp9FTF5iYU/JUWVcVXCBEFxbfJI5?=
 =?us-ascii?Q?F0y3bpn5651RZhBy5uJFDPBtvKPS5cRyCi9vYWpRzWlZMhtPBxd8T6aiIuaI?=
 =?us-ascii?Q?Ok8fK33woFH9Sdd0QW7Zu72oTWbYIDyYm6BAqDwG3hxf4P9etHqPgYS50CO5?=
 =?us-ascii?Q?7NxjA/wKG7MxjbbYxBMaWBfaT6wXQFizV1PdYwkOGMTBzE+FunyIekVT0AVv?=
 =?us-ascii?Q?lz/euHmNk1HUv8uGr/kIgcU43cdjfzw06lUy5ZWEnefr14DxSgKKz4Yh4sov?=
 =?us-ascii?Q?fiV2m3d5I7P6S1Zi2AsGGNMCUgP9OZP2QZcBXSXNuFskRic9dFPUzANyktlO?=
 =?us-ascii?Q?0/nYQHK3/lRfixSZOVjWJonkuyun+2WkuEm2ObV2sbaAbYHc38L49tJ0sVk9?=
 =?us-ascii?Q?x6w32v8le/b3F28ESRuLb3lSm8hTg9p6cogrc7NX+ST7szM6bYcQBhdVhTcO?=
 =?us-ascii?Q?NO/q1vx1X/0ygl7Xgh0UX1duzWeQzXCMMnTqJByorhGoym9CtEzphP6mRdyw?=
 =?us-ascii?Q?4nIwCxgojfyxuxBzzBnq85WKXgcl0CAt6M/4/7IRP5Jo7PMO0QeeEEWHdY2N?=
 =?us-ascii?Q?6IedC3PXbbMzkGJ88IGJkjODq/liptWXXf532DFQT9o1pcA7HNlox3fOMEqq?=
 =?us-ascii?Q?k4ClH5iLaGNjChqeHtMiNWXtFK91hP7Q9EDf/MUEs5Y5x309uQdCg+waGDd5?=
 =?us-ascii?Q?c8JnIFelh9kEirMlvgnVP5iJo8iFQfCPne+NVlKOc22O/RGfcHVmNbkX0nuX?=
 =?us-ascii?Q?nJCBNIjI0kgteIUqAxkI/2wKSfeqjZeb+sih15wTFMFGP0ne4ePg4jUnivEk?=
 =?us-ascii?Q?lseh0nPo37DTUy7/C4pqUga5XQNglQLNWwfhsBA7fmpYrh7q5Hh/uRuiDfG7?=
 =?us-ascii?Q?SmunwS1ukmQGPhqiz77qvUQQwwSCrItF0r57rPeQiY7jgVxtVe42y9k89y2d?=
 =?us-ascii?Q?iEjMXIcQ/wSAgPSuMSMJLr61/DG/IxATsUM+ujZbKW87TsBd9ljgv4vheTmK?=
 =?us-ascii?Q?2KG/UuYBtszoboyTmc5ptz4vaVABq+ULr3EeaelMuH2qe1cstAMcRmrrJLaF?=
 =?us-ascii?Q?yLJebSHGL+yaCfJf2tSFlZVkdjAjkk00GwUxLbD8et9sRtIhCoi1VH+wdaJM?=
 =?us-ascii?Q?EsNhKwmVVI4EOQlS6P4WduFxubREizZqAPzIdgS7OojSE5EMnYF5ayatOaIM?=
 =?us-ascii?Q?z076hyoOaUfAgLueG/VT9WdAEOn16lNsOWIk1582?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb39a4cd-e5aa-48da-f00d-08db0efa9432
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 02:15:59.3411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9UuUILihVQmj96JbMAGoc8CJaZmEGa8mMP70RVHzPkB0/zkHMs7XVj21fgu/C+HHeVIJb6TGQMGF0ne1vLrfug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7732
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

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, February 15, 2023 9:59 AM
>=20
> On Wed, Feb 15, 2023 at 01:37:19AM +0000, Tian, Kevin wrote:
>=20
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Tuesday, February 14, 2023 6:54 PM
> > >
> > > On Mon, Feb 13, 2023 at 10:49:34AM -0400, Jason Gunthorpe wrote:
> > > > On Sun, Feb 12, 2023 at 11:48:30PM -0800, Nicolin Chen wrote:
> > > >
> > > > > What about point 1? If dev2 and dev3 are already replaced when
> > > > > doing iommu_group_replace_domain() on dev1, their idev objects
> > > > > still have the old hwpt/iopt until user space does another two
> > > > > IOCTLs on them, right?
> > > >
> > > > We have a complicated model for multi-device groups...
> > > >
> > > > The first device in the group to change domains must move all the
> > > > devices in the group
> > > >
> > > > But userspace is still expected to run through and change all the
> > > > other devices
> > > >
> > > > So replace should be a NOP if the group is already linked to the ri=
ght
> > > > domain.
> > > >
> > > > This patch needs to make sure that incosistency in the view betwen =
the
> > > > iommu_group and the iommufd model doesn't cause a functional
> > > > problem.
> > >
> > > Yea, I was thinking that we'd need to block any access to the
> > > idev->hwpt of a pending device's, before the kernel finishes
> > > the "NOP" IOCTL from userspace, maybe with a helper:
> > >       (iommu_get_domain_for_dev(idev->dev) !=3D idev->hwpt->domain)
> > >
> >
> > I didn't see what would be broken w/o such blocking measure.
> >
> > Can you elaborate?
>=20
> iommu_group { idev1, idev2 }
>=20
> (1) Attach all devices to domain1 {
> 	group->domain =3D domain1;
> 	idev1->hwpt =3D hwpt1; // domain1
> 	idev2->hwpt =3D hwpt1; // domain1
> }
>=20
> (2) Attach (replace) idev1 only to domain2 {
> 	group->domain =3D domain2
> 	idev1->hwpt =3D hwpt2; // domain2
> 	idev2->hwpt =3D=3D domain1 // !=3D iommu_get_domain_for_dev()
> }
>=20
> Then if user space isn't aware of these and continues to do
> IOMMU_IOAS_MAP for idev2. Though IOVA mappings may be added
> onto the domain2 correctly, yet domain2's iopt itree won't
> reflect that, until idev2->hwpt is updated too, right?

IOMMU_IOAS_MAP is for ioas instead of for device.

even w/o any device attached we still allow ioas map.

also note in case of domain1 still actively attached to idev3 in
another group, banning IOAS_MAP due to idev2 in transition
is also incorrect for idev3.

>=20
> And the tricky thing is that, though we advocate a device-
> centric uAPI, we'd still have to ask user space to align the
> devices in the same iommu_group, which is also not present
> in QEMU's RFC v3 series.

IMHO this requirement has been stated clearly from the start
when designing this device centric interface. QEMU should be
improved to take care of it.

