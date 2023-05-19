Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9547092CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 11:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjESJPl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 05:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjESJPj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 05:15:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA61FB;
        Fri, 19 May 2023 02:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684487738; x=1716023738;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DcFxlIhXKKN2HNKrgJDRbqvXJ+OnIqzO04Jr/N13Tus=;
  b=jtmiWn81CTd6YmhbOWKmOwcI0Qd6UYf4YEzoxnmL3tM1S7vlydUYprlb
   eJxxcEE9R+B/xONtYcNu1ZctciyFn+SC0zQF+9+jIaCIN/rgM/fcUSBVR
   C9vchBLmKyTPa+zk0VPzsgngQAV1mJoQNOJP6z9Lyu2C1IUoSM4Z61SCU
   SDmJLBVQmRf7rGVdLXWJ2DSAisAC6jceNvfbH8rhZYxISOfATFpWL1gey
   wnXl+oJGTcy3TKu4zlIvD172pW7fbERchQOvBHiyS5MooPe23R8w1ZamQ
   68g+RKkaPrjOV8GHK87KY71HBFzLBkOxy7lg9keuNymJi5NVJBjvidS7g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="336916771"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="336916771"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 02:15:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="876776546"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="876776546"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 19 May 2023 02:15:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 02:15:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 02:15:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 19 May 2023 02:15:37 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 19 May 2023 02:15:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBnzQeeDTkTeXVvk+zWyurK3jxbdykJ+IXAKTMhDHhIU11T8g7g6rc4KOp3j8k7QGCKv6ctcAnw56XeoZkSU6iC7u2dpG5oaGY3Z/joq2eZV4U5F7eivDgu8jvzZ/5FkQJaBuw3bAWeu4ABbqNwTUie/w9tBcye1UdQNj4ie3XuLdH+KM3Ovgvf4nSCND5tUkJNbKfvIoYSuhrIfUPKaG+Fhh+uZ8ya3O3NYnK7YNYBuOfhG5vTNZUl0LUUKMaRV+6K1+jLThiro93oSoWzjZ1UuxU4lx7BQom1qDIWIziz5Nx/SxKUayBC0LPIk0+PZ9lXucVrjB+V7wyCayTrV4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayGD94ChsMFbAYRZ6VtS9Prb2aJbfvJslS3zNOSMwiA=;
 b=gKEsyoVuonYTeZxv1WlIQpAMlKZgnYWG/fR6s+tNfKnRelKyMzpxoozo+M2+4v0MvqfEjJow70U+YgjqVVo0yAab1mb5eA/yJ1IMiBbrOEWXH9KGk/8EdjMEUSHAKz/UKeYwVIy0uVdJBixhANQlvkyuTTINCR/4FlJ0MJPwDm/Q+CQN/IUyJNEhphGMzZixsx6jDBBubQUN7AcR1nUHt5tXC0T5s16OFo2DjeLxyO9wiCwWId5Spgh0n0NmXNzMoStOALBaq+hqK00KhYu47MsTAh8Yf0wYCNOO8z8dxdGlyM+BPn3d8NAVdVk6JJ+WhwRBMBs/6FxXPaGuhj5nTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB6973.namprd11.prod.outlook.com (2603:10b6:510:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Fri, 19 May
 2023 09:15:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 09:15:34 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC:     "cohuck@redhat.com" <cohuck@redhat.com>,
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
Subject: RE: [PATCH v3 3/4] iommufd: Add IOMMU_DEVICE_GET_HW_INFO
Thread-Topic: [PATCH v3 3/4] iommufd: Add IOMMU_DEVICE_GET_HW_INFO
Thread-Index: AQHZhBUvZZEu1sIxqEeJFXndXH1dUK9hUM+AgAAK5eA=
Date:   Fri, 19 May 2023 09:15:33 +0000
Message-ID: <BN9PR11MB52765198C3DBA60DC3131E3D8C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511143024.19542-1-yi.l.liu@intel.com>
 <20230511143024.19542-4-yi.l.liu@intel.com>
 <BL1PR11MB527177A3860E10818E9761938C7C9@BL1PR11MB5271.namprd11.prod.outlook.com>
In-Reply-To: <BL1PR11MB527177A3860E10818E9761938C7C9@BL1PR11MB5271.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB6973:EE_
x-ms-office365-filtering-correlation-id: 81737e21-71e2-45c7-2b4a-08db584999e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BsLjxFWFVHVc7oxZ7ZnHvgc8UYdAD6vsDsjwBkAB7Jvy9vIA9w3Gn+4jLByi4Gc0S5iVBLxrCvGB6u0fe2PjKoSX/3euVtOfTIvOk+u8swLFZxT5wOYUVqtndPRXJK3AcgVTtqOmwq7kKuMG7rLjJHE6GEnptbho8pbXEHVfKZ09Kj+CLqvOmImw4k9Q/OmwfbtG/UQTQxnMUn7cmeV+fr5oVSTUOK1wemH+c+7B1bIQ+8nry/je8BA2v+JWNJwRJTcovnazkoBLPCSZ+bUeLA7YLJKUwjZVBGNg6kAJJ+amVw6l/HVuBsSHaZzizO8AmUR/sLjCiqX1XfhzlnUMHS7IhHSj09sqjPgJXv3QWaJv5O8s6Z6mzyeXZCBqTm+jGV3HDzjFSfzENieJMevOwRyjx7+VbMOul3GwxRKQbgd3HfGsDZWRDaBG3yfwchDdZofSKfQ8VeMDMyacB9Ofg7/zMyaQQvR4jz16AUnwcTI9RDRmIHrjqX7J25b0EPDszX01nI7HjUxe0VxvbjcUjvGhYxL4Vfqqm3ZwLx3CYnFzuRugM5Y+f62/6+T5BQ13qY8+PR/TSzgaH7rfNJTTqCJkfmrTh7skYvD467ZoZKq7dSGKk/yq7uyVxocrHR0X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199021)(66446008)(64756008)(316002)(66556008)(66476007)(478600001)(4326008)(54906003)(76116006)(66946007)(110136005)(33656002)(38070700005)(7696005)(83380400001)(26005)(186003)(6506007)(9686003)(71200400001)(86362001)(5660300002)(2906002)(8936002)(8676002)(4744005)(7416002)(38100700002)(82960400001)(41300700001)(122000001)(52536014)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5VVWJ0vXhiX+gSzBMsc8nAQHs3JpA8DD/2qIlbrPndpsCOsWSghQzMOh3Rom?=
 =?us-ascii?Q?x6tzyUUDMvQYS8TNUkxKl8WR5Eol7rCSZgeh3A2kaE5lLY3BiG7o8VAx5zwh?=
 =?us-ascii?Q?/F26e6axR4obEHA9QrS2A9fEaF2XxwQJ/REEX3uX83V3QgM75dwDCIsTPFIt?=
 =?us-ascii?Q?iQBlyfb2PBAFAiaPdGD91V0xpS9oAda19q4OXMesLUwG26NcFp3Uj6aCg7PW?=
 =?us-ascii?Q?4cLEalK7/TQu0jFe3+gTsUfgTkcXNqTgN3ctrViGeq/ChbGvxJo21jvASzsH?=
 =?us-ascii?Q?Rpd9Ws6dCWj8457YpMKaxjrf5uv4i6rCaF2HEPzKY+nKs8GsPY3jY38M+TQZ?=
 =?us-ascii?Q?ZJ8nZSnj8tjvjO3+wYkODegbC+VqcoHLibA8eko9mBgp5wy7PcwGV/RF0jV/?=
 =?us-ascii?Q?6jiBJ1SdILqZoKPFwABPY54l7769yVpWU4IZrxCYxvOIywgjUKVj37s/Qe/H?=
 =?us-ascii?Q?2tooAw85LHLeFbEtHKTPgowceVyucFvwuuMZ36ldSk1Zh9e9ZxYHAAU6Kyrx?=
 =?us-ascii?Q?cVg6ozy2w6Dv4tpnt/yvSE5FacKWUVXIurBB/dfzwaxk8KzURd0QT+dxFhd7?=
 =?us-ascii?Q?yMpIUE4r6AHyF2d7PIDQxLD9JMGttTJ65NIMwCaP7kqGDHc3U5DWNYOqaQMR?=
 =?us-ascii?Q?7l/mBlx3K/i5dseojziqxB0Oh9plrFxpFjjvvg77PjER6MCDskc9nhM8H6Do?=
 =?us-ascii?Q?NDXCy6dVBZ1d2ZoksCy/okK06f8X/BCiFyqWr7O31ZUKwVVd81GdCgJf2YE2?=
 =?us-ascii?Q?MpbAfLrzA89/jWcieJK/kG2wp15ueIqFQeGPDjy5/dbUDKmx3vAzMlwQ/maU?=
 =?us-ascii?Q?vxUQ4taKX8VgB2mfqDZvXkHhE1pdu/9tik5F1/D7VzhWy2D2zkbeeOggw7A9?=
 =?us-ascii?Q?EZobN29M9d6eghZvfpr/+rKNje9usgdG78DqpK3af36kdFWeGvceckfpmxhg?=
 =?us-ascii?Q?A+BjjzlbiJJ3qYxCrSqHDCdETto8o1L5kZ5BU1IO0LQI18g1KCn5M2BJaqA2?=
 =?us-ascii?Q?xg2WYgTVxoioUdWmMm5MBDKakrd/A8l5aOkwYbyPGxybNkgmblBpuae4mwYd?=
 =?us-ascii?Q?F2oHHh48V+vf8ByPRRkScHGKosGHnTn2YpneHpmG0ES7mswHL5SB41CBGkkU?=
 =?us-ascii?Q?Acl5PHiQHaj2wKiqMatIwKGYnquEwyjGwSMoJ8tD7fIHwdDKfj2zWfhcbovC?=
 =?us-ascii?Q?XaixxY2/7PzIQmPuJDXb9q7aM88xvRwW9WMUvx9VLWyohsJ4LjMfLdV6Nlv0?=
 =?us-ascii?Q?2Siu8pvoYmicgeMUVE+JLbL9HFxSxbd3ViH4gvxVFfUpe4QXOx5qdpDilFnI?=
 =?us-ascii?Q?EhBEWpdB8gDbYm5L9CAMcyI1QEStBs7kBm9mz6OrIPhMLi7qFLuglS6+ajN2?=
 =?us-ascii?Q?n8VyecBn8ZGtHf9cp8rqnZR4/nnPgENTWc4Jz5l5VXl0JkgS9MJQKLf3UveA?=
 =?us-ascii?Q?3OiRhv1I1oPQktaHofpVJxBTStp5hdvnRD2XbmzdqTTnlTmmeEy2tjjN81rL?=
 =?us-ascii?Q?vZfBWZZLfmYm5RPvMnfRkc6NZEUs2gZSsKVTIep53ODvY/1tDYOtEntJL8EW?=
 =?us-ascii?Q?1N0qMu+MaLqv9CSDXrVNvI28b8UZkeMIaD68/sYF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81737e21-71e2-45c7-2b4a-08db584999e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 09:15:33.9935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EpP7UEvaphhgI27IebfqLfw2hfctVBDYPo73ENajLuaarpwdPuGOcTeCeGchy3HCt3gRsPFJCkA/drKQ7/WBTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6973
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Tian, Kevin
> Sent: Friday, May 19, 2023 4:42 PM
> > +struct iommu_hw_info {
> > +	__u32 size;
> > +	__u32 flags;
> > +	__u32 dev_id;
> > +	__u32 data_len;
> > +	__aligned_u64 data_ptr;
> > +	__u32 out_data_type;
> > +	__u32 __reserved;
>=20
> it's unusual to have reserved field in the end. It makes more sense
> to move data_ptr to the end to make it meaningful.
>=20

Please ignore this comment. typed too fast...
