Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEEB6A1681
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Feb 2023 07:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjBXGMt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 01:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBXGMs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 01:12:48 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CEE15CB8
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Feb 2023 22:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677219167; x=1708755167;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iZNV83UX5MMNc805qKPaoH3EhXhOfTHg6ve48z5OkaY=;
  b=H14nIIxLh40qz1pdsr44v+uRjmoCCmyfn/tCY2ZPLzVPRkxMlhI8UetB
   76RMMvmc4kjjeJSWMJeS0iK2IOlbjqpD4e0snJPVjwyoD+T2TgQd5gf/U
   f6zZicmREpfLYP3NHEKo1z9eAKc7cRseUb76/NzV7o4a8vBebOZfClCRj
   c2fFfpe7Npy0SHUVT53T/180UmYQRPDRBaPRfWHHKMXExsauSmMa3Lalh
   2YRCNgB/okODCWhopNuMiDnG0r6VR3pdYBslmU6rO9ctDymQw1uojYI+a
   wDc3y45XDrnr8cpD6ccMrvPmIxnX5d1BPEYE1QOReR+MzrBiKam/gxKCs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="395916392"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="395916392"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 22:12:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="1001711575"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="1001711575"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 23 Feb 2023 22:12:46 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 22:12:46 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 23 Feb 2023 22:12:46 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 23 Feb 2023 22:12:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZP7m/7YFmuq7IJhACKDFvpjwM1UP2hrgkNz9AfBd+tJqJ9J5RzsDkZM4e9Hokv8EVKDFJ7JLKIpiOM86ZJ2ZQ+SDk/gaD7cTYkfSgRUniFavZe+RVNHIpW2OIoY6cMxkSpDagY18qRiYvOWYbK8N6IFpHa221yK+L1/tb1MvNakrL789D9UwEqvIVli48IAjlYMb/7WG9SLn97IEimYJ8Pzr09KxgMIikq+Eo31li6F2V7sjORBGhgJDfcdTdVJTT1qO5RWXjcnoBY3SBpUasiQykvEk9O8amEU5WjQ9B7bUra8WhdfzjuW2lvL0bkAOrSHe0JcYUv2/M3BrhTx9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZNV83UX5MMNc805qKPaoH3EhXhOfTHg6ve48z5OkaY=;
 b=MXCCBhIUIV28C72XmCVyBcyKM4JGIfz0ZN1Cp7Gr/RW9sO641tFX1LvkrLW8YXe2PWxEQHScTz04isX3+AfeCj1ZDgNfobECBIMqdatIo6DsT1CXuptXAbGktQSegdllPX/Hj+db6UHiBJ4C3ZaoHQ3EX3Iop5BKN//7pXosbcIIH1j+k4fc4B+gcDvHVXwBblCMJujdQfu5y+BpdVyMJy6LQ9aadyKG8taNszUSnvauIaCgnmGDxUy51oVelOPsKINAPkHAw/HmNEY+gZ52c6/q5y/tpheK145NXUdAZPj5/preBcdhRsSC3Xk/NFjDvpuazYDJLdEwfbCvpIfojQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB6078.namprd11.prod.outlook.com (2603:10b6:8:86::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.19; Fri, 24 Feb 2023 06:12:43 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 06:12:43 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 2/7] iommufd: Add iommufd_lock_obj() around the
 auto-domains hwpts
Thread-Topic: [PATCH v2 2/7] iommufd: Add iommufd_lock_obj() around the
 auto-domains hwpts
Thread-Index: AQHZRwEIXrS9duhqUkO8yEIDyvAwp67dn+rQ
Date:   Fri, 24 Feb 2023 06:12:43 +0000
Message-ID: <BN9PR11MB52763F20C39C5719A8B1DD588CA89@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
 <2-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <2-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB6078:EE_
x-ms-office365-filtering-correlation-id: bcdada80-7cd7-41fc-e4c7-08db162e2437
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CIPLyerjlxd//Oub67Fi6skZGHTA5ewn/qkCVkDk2uBztIdtm0+MkMo79dVGBcoyw8ej4BRNSbLQ5TlTj3jMNpfZ9B7prUyN51KgtOZLz1CRO+KSreqrcDKjjRClJVayuaxV85L2T9osL5+Ic+J144kjdOI86JuuDjsQzjSScZzdp1AIVTtYasTizZ8gC2lOYkMr5ozyD/7vDuGe5Ib3KitxW7T3OZGAMJ3260rCQfsnBSOuqfUlRCgL8F5EFBKhbAbLhfdtLhPAbIwsYGTtsBhmuS97OJ7OP2Kk2+FPxmZd0PUIrMwUgaOg1APCEcXWHBrgaZgjqehoyHj2LVZtgmv4Blsv3mSjI9SCFUKmLiF3u8kY9N1RFryBJDlvpjqmKQXPFOpwehaq9M2P4rC2r8/bE2P2BlW+tfdZrf/jgq7DxQ9vfIs6eFfCsCJW14gNe997hTZj3N1JM+8Al1ol0DnzZjKfqShNQiuB9abEASrJVZ0vO5EtblfX3iR6kiwEtF6pB+zeuq9DZbPqKTRM/mTmByqg8MsQYOmFe7B39pXhZJhogHMsSHfjv83ny+F6mZ/n3dTgk3we3Qml4N+t1RbGsQGcbofkHU9jV5JcccN3EP9CAIV3ziei4b4gfufQsrBMCS2bkNl6vhf7aUWVaOD6W8A8H1i39IyXWr9qiQti0Qu+68VyCsltYxMO54BwYTSk3X0QcCTe5S1naonFB7imja+7Ilia8JFW2gELr90=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199018)(122000001)(2906002)(9686003)(38100700002)(82960400001)(71200400001)(26005)(55016003)(186003)(558084003)(6506007)(107886003)(83380400001)(110136005)(316002)(54906003)(5660300002)(41300700001)(38070700005)(8676002)(66446008)(66556008)(4326008)(76116006)(66476007)(64756008)(33656002)(66946007)(86362001)(52536014)(8936002)(7696005)(478600001)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KSKSlUEapuV7jZrW6LsIC/B/kpiqVBNot4hx2da3+EtoxrujVTENIVXE6NGM?=
 =?us-ascii?Q?h8JGMtN/KfsvU8GQU1c/UPu1ODdT/mNextjz6abTVrXwweCXzvyctDjwXiln?=
 =?us-ascii?Q?/UtrYIQCvjGojwAISEwPVijh2oeOqWIC07cQxLG8QFjnTAeZlA17Ejx/oSFr?=
 =?us-ascii?Q?OyR/PBYULXQAKOlrOevnFnye2o7qE3ZakwhqYD75skHQQOtJB78kGQN5f4RO?=
 =?us-ascii?Q?BplEVZ1x91yZNnL7w9M7HEC9mn9XxVIKhydN2KAjmmb6uB3WUYxPuK6xWniS?=
 =?us-ascii?Q?ANP/AN/oAOQ+cAH9gYuwe/D5w27SG/ZYxY1CXWcDVoyrqLXRZsu5p8l1Zbsn?=
 =?us-ascii?Q?DuI+EG5fRPkZimfGOBkVCNz5haDZ74wAuu2g/3eOGq2W0YYimTwHPl9HPA+1?=
 =?us-ascii?Q?i1yY7AWB9Y8eEDeGlTI3v4FXb0yo8GchixCIyA72OXRLKCXxpZO1shhgSosq?=
 =?us-ascii?Q?7iiKgi+pkgXtq9RkN61ap0lQtFL1SsFKhJoO0JaGK7YL64aSREZjSUOHdk2M?=
 =?us-ascii?Q?HdJWTeC0cH7U9PkZqBsrZpp4jYwAa+sd2UTYjbOEw/Ybjafu4lvzDFOc3vF/?=
 =?us-ascii?Q?zbw/mF7+1XthQd7LEJuoFGUdsK/I69ugyoEzDgb3Eefe3Gupol/Q4MDMeLW7?=
 =?us-ascii?Q?C1KO0mNMXPccYCSiefDRjxG5jmD+P5ZaYrEERlWMZTanyrMsT5KDchZOPQu+?=
 =?us-ascii?Q?IPFho0cki/hV7JQ7llDRutoxZpgtQRrfnw1oO335tarTTBrNdXlbkBx2y/jm?=
 =?us-ascii?Q?P+u63xPd0JQByMMBIfy54vUKRlisQCTY9op3f+MIA9/BQz9vSav5wdmwMcWx?=
 =?us-ascii?Q?SEgkVKeqDvkMecDPlk06jCGBdl6ZBsFy0F5eCpZav/92hJ3BDch1LzywlMdf?=
 =?us-ascii?Q?3rN3gJwwoUJZi7YwO1DghNs6yVKLm+DfpR46LHj1ZXcCRCYPszFdGNix3a9F?=
 =?us-ascii?Q?KXMEOghO5S86OQFWhYqYmWUWji4d9DMTsQfYDyn/9bd6en5k7VI0fMmCbksp?=
 =?us-ascii?Q?Q4Gb4pdEGnLOHq3+btbWMngOafLJPSb3EKC3sMNtlcFHMDFR0+QDtFZCgwCV?=
 =?us-ascii?Q?V6pczN1GLg0tdiDJfBp6b0+cl1fKOKMBPoY/woQyY2E+gJpp/YiWFZ1GT2Uv?=
 =?us-ascii?Q?23ueBqbf9PM85Y2pfSqyJT3pRiDbEi1z1XD9tzrSgkbQElNPK2DLvooPpQUY?=
 =?us-ascii?Q?mm4LdjO3KsVp4/qhlP0oRSNDXCyXK444o2L/fgiJccKVpD/eyFa62Vv7YOOb?=
 =?us-ascii?Q?xOepgTccw1jH2UDHgFUZuPtk8asEuNXRPEOG99uMzEXdvn9noLi44cj+oSyy?=
 =?us-ascii?Q?S8w2cK7E9e3BmsGxaBb9xSK5V+jSZJImhZqiEIbofVYjf5UBwyH4MEJh3Gjn?=
 =?us-ascii?Q?2uiJau130v1xYTJ1GrXfy4ynH/4CvGhMjuqONTsyQ+Fq9SYGdBzmgLOUqDWr?=
 =?us-ascii?Q?2ejfFHJkHw5VlmDYgMa2mcwTfgdmGvt5mwYDDA5cCAZTGeNVxhOggxDAOzLo?=
 =?us-ascii?Q?v4eGvbNsMFA5imb/qorBHui/cxUNRpIrGZBbalu7aU2vicP/h7st51/dnvxh?=
 =?us-ascii?Q?O5nCLZXmY4zgCvdXXwpPgVzMpggUB5KjR/cClCA8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdada80-7cd7-41fc-e4c7-08db162e2437
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 06:12:43.4381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h+Sdm9hv6XGjdcyS/YF6Rpo4Os2TIoH8C2XYxnKKCZ8hi75k6NbRPMvMXfZCJFX01tdmOg3qoAIIHe7A48kZEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6078
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
> Sent: Thursday, February 23, 2023 5:03 AM
>=20
> A later patch will require this locking - currently under the ioas mutex
> the hwpt can not have a 0 reference and be on the list.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
