Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DBC6CD6D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 11:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjC2Jr1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 05:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjC2Jr0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 05:47:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E899B;
        Wed, 29 Mar 2023 02:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680083246; x=1711619246;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WN9mN95hSjdcagAKl9OnymVSM9o0BPLJvf6c+GU40vo=;
  b=MkOiUOY0mCOn8h0pgjUeNJxXtlIPIeGrUSN16h+4h5RN6KE0CvctX+64
   ZnoCuWy72Vnfen+G0lWmXXTC7bZZkCXi4bkFifKLNnO4GZu3j7HWZjwBN
   NoYiEDqaGuju6JuuQBK/Jsnf+3U+lzjoMcgL7yAql+aSCfErErytfCoRl
   5BSsHjgA5s5Vdv7tZE9LeENODxVL3QyzRR0K1CDHVn2paGmQ5kNWQsM3x
   vC6DoDt3/yf118ELCbaWuwvlbHMOQJq6DZM06KMkrVwIox4tF8M1FubQ7
   8X0rnu+bWOgjGuOAfrR40Q+HutJxKw/XNJoRSMn0cDmG5EnMebetYQCJR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="342425160"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="342425160"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 02:47:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="634414243"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="634414243"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 29 Mar 2023 02:47:20 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 02:47:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 02:47:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 02:47:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxcNbRxr08NFWSiZQiZdcNfVVgw/32cwef43ZzoFwIogO5GDWXwLwLQ2nlL+LY+Sld7YL2sdNsZj23KkQQRxSzxZXuRAmJFGcGJ4U6P5gacmu7OdHewEseDXrPIvE9w3bzdz0rITkocMHsWSZ/5GuebOF4wdkBTOht/hoaX54QTxPgaAzBy8SunjtJHTh3X4RaKWCKIFVKFEDi0ndmdRbf2cJf0EgSfWS8ZN+kLbRLrl3U3XKb8CTx1d9volUePo6aaD6vFHMLl4A9lrgcazochmembs6tjnOfXXDGRnLFfEUaOfvbIYhVg92yaHL9NYhuVh/9mYArxFkTmVXtWd0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qI+uCuD+JZdKWwQ6LxJB9wwzjTUpwW+9KVhQpav92dY=;
 b=DdPGd3J/08qPWwbqyFeu82ibB/sENU+SKLneIMn4LreMmYeo30v88QD1wiQuDQV+QCTp22kKdzHDlRuSOIHJRwMnOg4fFgl9S2Ug+aAhgMjXdNBEkRpK/gEwnsMpm8rbSx/igrV4Jx3xYhXX0agaoYLhi2kc7lIxK8xdXmV6FuvbiVdUWWCCjZMV7du34mg7v96WN9c972RXN/5j75JXxhkpne3Vh2A7A/x1zShA5DceK175C7di46/6rc9qygVR2wfNpLTS5psVVqD9JUM4dvJBtBrG5WCtRAfZUZd1D64z5OsB8ZgU1i78pHmhkEA2Gp1vqaH03ruIPz8AoXBLlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY5PR11MB6488.namprd11.prod.outlook.com (2603:10b6:930:30::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Wed, 29 Mar
 2023 09:46:51 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f%8]) with mapi id 15.20.6178.041; Wed, 29 Mar 2023
 09:46:50 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>,
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] iommu: Add new iommu op to get iommu hardware
 information
Thread-Topic: [PATCH v2 2/4] iommu: Add new iommu op to get iommu hardware
 information
Thread-Index: AQHZUlxYZTZJ0kRBX0eZOURtx2ZWra79GoaAgBR353A=
Date:   Wed, 29 Mar 2023 09:46:50 +0000
Message-ID: <DS0PR11MB75297955136ECD62A825287CC3899@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230309075358.571567-1-yi.l.liu@intel.com>
 <20230309075358.571567-3-yi.l.liu@intel.com>
 <BN9PR11MB5276C6A0F26954A42B8C23498CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5276C6A0F26954A42B8C23498CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|CY5PR11MB6488:EE_
x-ms-office365-filtering-correlation-id: d8284672-9a32-4b45-b987-08db303a8526
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +jMCcvqiQqVjFPBQdE/AcMbBOfDgjixu8/Afew/l4IdrnQpW3LtRjOwPZiW+szeIgzUBxPBwXoD8fc20ubXeasvlOiZ0E4OgwLX9uQF8nFFii5dq9Hc/wd5NT/keUjm4tqZjXGK/6sQANVDXnis6FwdU59kBu1dYOSbjeai4V0RQS3Ke/Jp0OhvQ2fgPXpw1M3AFITx7A3T3uz8egY0euTSh8CYlAU9ZS2sEUR5fZj8N1Q0JM9d40Z5OJt7jCfId0/8xgdv+MaHy5We6Jx7QATiAnuCnuLPkN6Zaz3YeZH7H0Mk31T5MwL04j24YyOo8FU7ATKydeZWz2MGX0j2bYzQx9gb9SSqFk3FdRU5r31S3p8WiyF8mSH/iUwcvt2Q/ppPSTpPdskpRb9tnWa+5IhCkUdYlaP25qWy/vyVSi+56wNhx5r8iaYDXLksnX+VMGTordxxca6prp/ea3jxV7BXcaMeFfOnmip/Jxjf1vp6+eD/gbmggHBFqIIh0pRZgMFmnVIS05189CKejEQHTy/vm+cuzaMc/R3FqaYa4SgKsYWW+EpRaDaa1B7bQ3BTd6S94lqN6WzkNatmH/M9ndDibq8x7AkzSc0G7/Gpt6z22kPr1LgU6bO1pNgySMSsnT6v/YqiPfEGbB0J/KQ7sr01kMj+LohV8TI9NdBtAKJY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199021)(4326008)(26005)(41300700001)(6506007)(5660300002)(2906002)(7416002)(8676002)(38100700002)(9686003)(110136005)(8936002)(52536014)(186003)(83380400001)(71200400001)(54906003)(66476007)(478600001)(66946007)(316002)(86362001)(966005)(7696005)(66556008)(76116006)(66446008)(64756008)(122000001)(82960400001)(55016003)(38070700005)(33656002)(13296009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MHbQpE3qhWxlOnAYqnFoToPxr1On9FEUBFWvcMT+o+ORPNPQUBhj3qbcHpyf?=
 =?us-ascii?Q?T318ZUBfJv9TgOu86dWMUSNRs/GxuqnpTtlcn/Pa2V0B67cAtm1Uak73OrGE?=
 =?us-ascii?Q?z8kLD0hVPYh8VYWfI35p41Zl7UVxaBkyEtxu72ARe0hu2pdDJ8ERf6T7SuIN?=
 =?us-ascii?Q?RjeOIt4poAVrvdOJvX78p1wzdbLQfbaj/iOhyQC568bgG1Sjn9ss32PzdhLs?=
 =?us-ascii?Q?6OBSgv9+vzZgyc/xUFgUAi5BXuTetP8sWu5N3/sIGnwJJJY4Zg063uNBkl2u?=
 =?us-ascii?Q?2hbr2VNqdDDKUVJskuoPntUyu5yYDLBl9mW+JSVSpm7OtDiZznNhz3v9+J7q?=
 =?us-ascii?Q?GKZ3fswKgMRVAS5TqDsgECxMTMOU1Jq906Bj3hzpVq5t+7uMdycXDMna5+Gn?=
 =?us-ascii?Q?HNv+j1fgXysK9atOYDHcmr+3Cbtddsv05Yp4HBy+XVLtLJ1A9kN6F2CSUvjc?=
 =?us-ascii?Q?LVrXeiCKM6RDUxf23jomdmyPOWlzxfHDHek9LqvrenekC93UAqo91bWpqoIv?=
 =?us-ascii?Q?x3YkitkBRmd9VouW2jTFL+1WqIgZiIPD3WlD4RRJg5S8T/AYU2oDLK5+iGnI?=
 =?us-ascii?Q?WX2TDN8iFHBYunu7Ug1HgQKDjZHPbFkG5b62mdm5y1+JTYnujEI9OyBWEUHy?=
 =?us-ascii?Q?q7tvxqYkhX1rVVCxrwrWJDbzLEhsDbeIu98j9nwWIXXuSbGn6z1Uz7JdMU0O?=
 =?us-ascii?Q?FLCqsY2z3vW2pQiSKt4V+ICwogOzoMQCro3nqchQmJFrGg4D1RF2iUnVLGRy?=
 =?us-ascii?Q?0x5wu2qqVywPCdpq87iUafmbJ06ZEej3d/X6QdVTHMSnh4IBof2R678+PaQx?=
 =?us-ascii?Q?mMsA0IV+sYPvZm+vo9e/K/f7SciFAlPEKFE86KScuvIA0rTvOcrRC20wqy1p?=
 =?us-ascii?Q?ymwtDMUOk6JAZOUfXdTthIUhCyRKjD4zEdHRAJKf3p99LFM7gSbXHpF1Cvdt?=
 =?us-ascii?Q?VoxiVooNusgSB3Ri3rUJIM900OfKiSijXKvSh5WxaIMbzF9u18y0IbZPbeVl?=
 =?us-ascii?Q?JI15l0E50Bv/qJRa9CiICNNyi59Ww7/QlzO1Mr4jAFVohoiJgwo087NlDiJb?=
 =?us-ascii?Q?8JBg1oORyLTKwaH9soDHfEknASFrAYN002A/i60VrYnMNDIkJHGtRYttiWp6?=
 =?us-ascii?Q?zL6DPP1VKVGp7Ba46+vEm714y5UK3SU14Zv/56GakmY1yeuFfG+r1Bv0+VpU?=
 =?us-ascii?Q?aoNxuxCpC31M8T9GW+GT5g3z65mv161Mfmo/4cOejZ/RmfsI1x/8yWtqE+OH?=
 =?us-ascii?Q?rtALrA8XJ+4Un2AwnR1RLL/+Qp/IsqpBP3nZiMK1By7liPcT7zRg5bTgf3BX?=
 =?us-ascii?Q?OOpD5Rd5/kS5jTnTjzwriVCkUkCpP9qOZ6tGKkQJbEkwU/0etebHileT6vf7?=
 =?us-ascii?Q?VXVZhOhzutqgziYjfnFFYiPsb3u2e68os+4Pvn1RH/4p3pnOEzTe/d9Y5XDf?=
 =?us-ascii?Q?1osRaWHa3IKuj25rjQJw3brj1fn3wfWIzReiLSUxBJDPBxeobC9kAMQlM2Pt?=
 =?us-ascii?Q?uTz0BhpIs6qi1BdDb9adv4QmTlBrRnpPJt5P7hYjJ6B4N9cZHexQh27LceFI?=
 =?us-ascii?Q?Bq+nKyb+atdDLUQ+Q6u/5O51iMYlvYIqmLyuKcQw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8284672-9a32-4b45-b987-08db303a8526
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 09:46:50.2732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OZuFjkUGr/Nx7Fu9aVQsHGstYNRzwAinrEDHG6UjXcwQdTJO1SdZn4M4HYdXCeAh1CHgWWx4bPcPFuOt3KA+Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6488
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Tian, Kevin <kevin.tian@intel.com>
> Sent: Thursday, March 16, 2023 4:17 PM
>=20
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Thursday, March 9, 2023 3:54 PM
> > @@ -222,6 +223,11 @@ struct iommu_iotlb_gather {
> >  /**
> >   * struct iommu_ops - iommu ops and capabilities
> >   * @capable: check capability
> > + * @hw_info: IOMMU hardware information. The type of the returned
> data
> > is
> > + *           defined in include/uapi/linux/iommufd.h. The data buffer =
is
>=20
> "The type of the returned data is marked by @driver_type".
>=20
> "defined in include/uapi/linux/iommufd.h" should belong to the comment
> of @driver_type

Sure.

>=20
> > + *           allocated in the IOMMU driver and the caller should free =
it
> > + *           after use. Return the data buffer if success, or ERR_PTR =
on
> > + *           failure.
> >   * @domain_alloc: allocate iommu domain
> >   * @probe_device: Add device to iommu driver handling
> >   * @release_device: Remove device from iommu driver handling
> > @@ -246,11 +252,17 @@ struct iommu_iotlb_gather {
> >   * @remove_dev_pasid: Remove any translation configurations of a
> specific
> >   *                    pasid, so that any DMA transactions with this pa=
sid
> >   *                    will be blocked by the hardware.
> > + * @driver_type: One of enum iommu_hw_info_type. This is used in the
> > hw_info
> > + *               reporting path. For the drivers that supports it, a u=
nique
> > + *               type should be defined. For the driver that does not =
support
> > + *               it, this field is the IOMMU_HW_INFO_TYPE_DEFAULT that=
 is 0.
> > + *               Hence, such drivers do not need to care this field.
>=20
> The meaning of "driver_type" is much broader than reporting hw_info.
>=20
> let's be accurate to call it as "hw_info_type". and while we have two
> separate fields for one feature where is the check enforced on whether
> both are provided?

It is filled in the uapi structure by referring ops->driver_type in next
patch.

> Is it simpler to return the type directly in @hw_info?

Per the current description, if the iommu driver doesn't implement .hw_info
callback, then it will not set driver_type field neither. Then this field i=
s 0
(IOMMU_HW_INFO_TYPE_NONE). The GET_HW_INFO ioctl in next patch
would fail as well. Under this implementation, returning the driver_type
(a.k.a hw_info_type per your comment) in the hw_info callback may be
simpler.

But I plan to update the implementation per the below remark from Jason.
The GET_HW_INFO needs to succeed even if the underlying iommu driver
does not implement hw_info callback. If so, it's still much more convenient
to get the type by referring ops->driver_type.

https://lore.kernel.org/kvm/ZAcwJSK%2F9UVI9LXu@nvidia.com/

Also, per Nic's other remark, there would be a bitmap named hwpt_types
field added to iommu_ops. Then it is also easier to referring it by
ops->hwpt_types.

https://lore.kernel.org/linux-iommu/ZArgAXMUpNjDfFgZ@Asurada-Nvidia/#t

Surely, we also have another alternative. We can enforce all the iommu
drivers to implement a minimum hw_info callback which just returns the
driver_type if it does not have driver-specific data to report to the user
yet.

> btw IOMMU_HW_INFO_TYPE_DEFAULT also sounds misleading.
> 'default' implies hw_info still available but in a default format.
>=20
> probably it's clearer to call it IOMMU_HW_INFO_TYPE_NONE.

Sure. Makes sense. So _NONE means no driver specific info is
Reported back to user.

Regards,
Yi Liu
