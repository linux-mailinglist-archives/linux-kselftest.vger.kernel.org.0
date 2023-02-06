Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0BB68B5AD
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 07:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjBFGjg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 01:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBFGjf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 01:39:35 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C45F18B14;
        Sun,  5 Feb 2023 22:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675665574; x=1707201574;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+iztsFrw7/NakCtjk3d+F8W1qtZsidUn7960771S8jQ=;
  b=PMT5U1THsyNcT/31nl9KixM7Ul0c+JEH+VLmvVOiTTCIVoQ1viyDaMdE
   yh9OMMwK7LQqllzPskUgUvxa8Us3CWhUrbvO9O9smtyDk9q6KGA9mQU0A
   VZPDJ1ffxeGY6mV3/N58AstLOuQSCOR0i6aluzLpgm++f41Y6P2ISDKk8
   OT0vdZobvzs5FOecic2BlElwuiT4c8S8T1wRlRfQuZUTTMZ2XuqO1Viv1
   92LlzJZolLr5BspUy/MnCxWDiJo5DQIBv5AFf2GnOUzrGU3oc6GZ1po05
   5DNGipDafvsVgZVkkeUskADXYSIzeB/ShpHrQyyb00EWAuAFA1NBksz2T
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="393739560"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="393739560"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 22:39:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="755145801"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="755145801"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Feb 2023 22:39:33 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 5 Feb 2023 22:39:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 5 Feb 2023 22:39:32 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 5 Feb 2023 22:39:32 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 5 Feb 2023 22:39:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=da+OGr3wGdbGJPP5+aL1Coxcsj1hBEq9bVNomanJOT1ORcDyU87lCSH+VcRFZTsRIHSROuzYrxJzhwavsOOY8MVAuby4P9FXP4z5yUzqKPhjxhSAT4wG9dDaUfjfrrVkix8VHRS91SO0UfbLjaC79KKCokphhRNkx971aK659WTuEaegA+NZl3CZe3EsEPSZl4Vwu6DjarDJTijfgOHJ8+WwAszWF52nRVDRGPH7qSwWQT7DZDESmE7WHr30GImG8julLvIr5FTPazHeHZngfpZimkIy9XtV6iqFXwHXDRsEtGWlQLc/Tt5HAxSw78fgWwY+d1RuEx8Xuv7jC8TF7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iztsFrw7/NakCtjk3d+F8W1qtZsidUn7960771S8jQ=;
 b=GqAhOYA+CXzPkqGjETQgvRGp/I7g/36MXYrAgf5c08p1/gmpzCsJ1+i7vBjm+mtnKXQA2Xq2qBFuY2WuZ4KmKWMSqxx8SbuQotnnFeYVzBc5Q2inc2uoRChgVeTgo7zXzJN1ciZ3CaeoCDGfnG/rK82yrowWOuHodti9+cpT3FwAb8Jay1nL6q0+OOxY8hMhfBPje8IZl/YLUXDvadl4xHPgW/mTOQUTLZLzwbgD42Cs8NQGCJikXOGxT+/U6otnbKSQmOAl4i93RCtse6zR+XhuuBsK2XXQQAKDzpNcVCW+ef8D9GeRTqlb0rd+AfZ/zXMOoqysnUAYNPVyFVpQgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5543.namprd11.prod.outlook.com (2603:10b6:208:317::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 06:39:30 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 06:39:30 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
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
Subject: RE: [PATCH v1 0/8] Add IO page table replacement support
Thread-Topic: [PATCH v1 0/8] Add IO page table replacement support
Thread-Index: AQHZNtTGXgNRh4XDNU64JbwG3sv0b6683tSAgAB1HoCABClQUA==
Date:   Mon, 6 Feb 2023 06:39:29 +0000
Message-ID: <BN9PR11MB5276A84ABA311151949215518CDA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <BN9PR11MB527680F63EC5443DD7A5E98A8CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y90ieTgl7I2GZfsX@ziepe.ca>
In-Reply-To: <Y90ieTgl7I2GZfsX@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL1PR11MB5543:EE_
x-ms-office365-filtering-correlation-id: 48956fd6-aa0a-45a5-e49f-08db080ce65c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yAXa7mDHKQbYJ+8vr5vr53jYxCP1dt2IHQgPWeeC1EnBpAJ4h44K7CiSHOVWnheV3JlfNyQR9SBMre5ZigFU4jb9+4WS+9KAJYZgOxtcoo3S7j3xQnSk/qPVkNAmhnXqcTJ3GnhmyLh7Ze30Jjokhj5jreDkAEenF9q2QXfqxGT4SNtfh/ELbN35NPmN0Nh+jpRxGsi3D/+Go/U1elpQ+7rnuTMaANoiodtK3FqNtrcrywWFJ5O+cNKvAFM9p7BDbTTXngc0jFhYeamhiiEocr6k+XbgRmYWa5v9/RFVRNU+xTID4kbrNfsCpNYj809tbz7MoNJbpyhNx9INIfzlSp4A82jZKAmPjv/IWRcQIEEsOSx7ou2KUT7fUcOhPX3yKyuzzOjPFF2ZP0DQvM+or7fADSfsMiB/UzRzOMcZQqt3llxF4/tmMTyCHDL4stQbrYW1KyMtULXX+k+kgkwmIlK1hrnRO5iDIl79D5GeMeCDRtzzYs/F8XaL3rFHTOKnmuA5WW1UUrVbArHaVbF1HS57PnlgtLjiTiILmJvRJfvQTUKgEM5/mlgapOKlU1dtr6urKKYHk+Wu96IOE4IU7L7ZMy0wpNvZ6x8hxc++NiZ7jF3PKQ9FvFyZMXz86OvwITkhDjLxvzh5HUF9AQLObqGSuZBo97j05But2vJXT5pL9JgfOvxsooQiGL3qaPKd4fG2nk1Km2pWwU89yFV2cg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199018)(76116006)(66946007)(54906003)(316002)(7416002)(4326008)(41300700001)(66446008)(64756008)(8676002)(6916009)(66476007)(66556008)(52536014)(5660300002)(8936002)(122000001)(82960400001)(38070700005)(33656002)(86362001)(38100700002)(6506007)(186003)(7696005)(71200400001)(9686003)(26005)(4744005)(55016003)(2906002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/dzCgmGzFSuO9vL16oC/v5WfFFNatBZXlSOZ1YJNl5ByeGgYvbvSrwpdQduV?=
 =?us-ascii?Q?qmKGRulEv/o/ReI3UkARCIq9b3roQb3GGJkAeDchxvWOI2x9izmOi+zkOVYM?=
 =?us-ascii?Q?ppLn3sQtfYYQyVFLmrIbMk57GQ+3SGkNSkRGHma4iKzc7nVfwa9aFjD8S2lb?=
 =?us-ascii?Q?XqVOD+jOXEnHFk2b6wWorCbVgDctoGS3wqHoPLmJXok6y3Ul2eP2GKlWhkf3?=
 =?us-ascii?Q?ZZJ3OrjCK/aD22mr4SnMqeR3aC2EMsVLuncySyvDBx7r482gxm0RQeU++3St?=
 =?us-ascii?Q?du7gbldAVITaM8h1f9Avg6/PLp1mAJl+MEjtQc+S2pVJNIdj5T0qA86Z0bLj?=
 =?us-ascii?Q?plQ77E1lVN4ZYB0vUto0Z5n02FEIXG5TyD5PQt+cIsoGKS6emWfouCeVkqIo?=
 =?us-ascii?Q?jVKVdqgNvE6DJ44iQY4myT4DBov1eWd7FiTltcAuFfga10gutKrvi+kTMyiU?=
 =?us-ascii?Q?inuCI19gNeRUiHXb8xZTJLakaCJz4rxWSG6lWq/p4MlEq8Ww0eBWPvJZ8HvW?=
 =?us-ascii?Q?Cwmqb18OKG2EdezBo864+IEBQ3oJZGaAKgFzpNmYub9Us1s2ZrADhbST5pBi?=
 =?us-ascii?Q?Gtz+igXJa47Bz68V5UV3e1jyTBzL3tb/PdGy7DCaF6MQWuM4Lc6f/Kjl1lUe?=
 =?us-ascii?Q?zQVLXGOcs46fiQ6VjKPrQN8b4JOJw1giG2+HsRtXiN1ARQ3DkXMt46mF3eL0?=
 =?us-ascii?Q?zUUEBXzi5L4NUV+vstVZSDvjjnTyssBzCpjXT2WwESlDT7l0jVkO5AdY0LhE?=
 =?us-ascii?Q?XGTSHp3e6WCGe/Q1LdL6TnVRhDXYKa3eoJG05UTAKTj6NpW6Gef1fBc0PXW5?=
 =?us-ascii?Q?AhCdPi/ZzbxLhIyZ6AutZHftZtIZRRFwHhlSfwurUxJbrSfv8VY3FaukJTG8?=
 =?us-ascii?Q?nqKQG6DGTE7CrkM+bf41bUguJD850kv1o49XegzjFPLSTzoorOh92btQrQ/e?=
 =?us-ascii?Q?PwNgflwU+e/dCJIvpmq/qZVgurSZbyGe6F3oAzQRnaun6nTrzXkfWswBsExl?=
 =?us-ascii?Q?NwQwn0wRrcKB0KEpRGZv8Tq/CCDxS+pgDWIYajhTWCNChEHsJOYM6JRLdARw?=
 =?us-ascii?Q?bHEIxhcXBC8eND32s1wPVgAONUFdt+TaqW83UDEY6hEaZaeVU2J5hFH7ajWF?=
 =?us-ascii?Q?KzGdu+qHPPp2B6RJfBQABLZiL2kiNLEMXRfIYWwnZdWRce3P9zUcjIvx/dHx?=
 =?us-ascii?Q?apipttC3temxXuUmLmfMmz71Ve4dOyI88BG6iqjjVcSTxmmKMUUhwcJ6iz1w?=
 =?us-ascii?Q?8gsntHjowIeU1JaXFi8jHJeEOJEqDnZWALk1xhwZ7XQLtWTtlHXH43NuNyx5?=
 =?us-ascii?Q?4B0VIkt8C1MAfs/K+gob31Y4EGtbtj0097VejDewJq0fLlvK8C70S9nY2xtV?=
 =?us-ascii?Q?8zaz/iLv6duI+slsCyQxKDbrcoXEGTq9BxbDUyHOs+8rePLw7VCF8y5kMgCj?=
 =?us-ascii?Q?d8yrLKfQDviyhSpoNPSdhOaAHBCN80S10Sl+0oXtopUmuVJ6Mvdk/Iyi4Vg1?=
 =?us-ascii?Q?85wF8inTwRtqCn9Eln3i4p4o8fHhuBQRaVa+F5y11OcKnSlQ17qRwB3uLHO9?=
 =?us-ascii?Q?uoFgR+WMD+Oph1DHiBlJO1FmkhHX8ZOvpYr9Ahww?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48956fd6-aa0a-45a5-e49f-08db080ce65c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 06:39:30.0066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3qwFCG9HRfmgcDdDL7YkQWJ4xce2Mio0lcGd7H6A7m3zu/iEBJP+xOgZUZ2ff6siHMReadE766/uy1aZsEta6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5543
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
> Sent: Friday, February 3, 2023 11:04 PM
>=20
> On Fri, Feb 03, 2023 at 08:09:30AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Thursday, February 2, 2023 3:05 PM
> > >
> > > QEMU with this feature should have the vIOMMU maintain a cache of the
> > > guest io page table addresses and assign a unique IOAS to each unique
> > > guest page table.
> >
> > I didn't get why we impose such requirement to userspace.
>=20
> I read this as implementation guidance for qemu. qemu can do what it
> wants of course
>=20

sure but I still didn't get why this is a guidance specific to the
new replace cmd...
