Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C964766192
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 04:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjG1CFG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 22:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjG1CFF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 22:05:05 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714522D68;
        Thu, 27 Jul 2023 19:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690509904; x=1722045904;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IaoVl6j1h8zIQkbZ579Jn+gDCg6FB0HtFv0nybhDsO4=;
  b=kMObEYQU1FvJDCpmce5VU20z6UPdtC2wGUAMKbmUrSjmlm1ppWxXbKsa
   6DcwVqWbmTFdcZ4H0TIIAQf1+E68JCKNxqF8ozbgG0JEME51RmAsaWlOW
   wHl9Kk4vXJVT6xKzfmEFDHoGORvsxiiK+msbGfCZylwnr1BHHy/IbEKUe
   puqPG7Eia70eX/ThhXrZIu51vPRzSCXNLIdlDipnY+NyCOCakGBLgzhFK
   wa7Ek6Oakec0mCj+xwciwBlcGhvFgaK0dFR0nqcGRU05IR1SeYgyCFm50
   K2dmq/ctnPZ8T+j3mtyn7XoEg1bbo5DoNGJLoGv5XP2Og7thgwLUNhLJC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="434770122"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="434770122"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 19:05:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="817304208"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="817304208"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jul 2023 19:05:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 19:05:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 27 Jul 2023 19:05:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 27 Jul 2023 19:05:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcGeXoAkh3ZTIX3eq8EliWnFz4LmwI4REsg60IWZyzzau+MpuZo1wl+v4nak7Mow/dR8jd+9fPw9WPdRhYJQnmtQuPNdQDuV+rCNLLRXVT/r9Sc1I4ln9UEmY0SYde66pmi9HgT12AOYubzEGMSLAcReURSlMWk1FNZ0yG+U+aa3t3WMl3EMkiX8Wtmw3vhmX8NMxKo2Jn01CLiNOrqxAPRYqj7IaoGxR9JjCA3AmRWqdIlvQDf40XnIJixh5XiLucxuhNNnKnHG8ApwATTTVcdeYYyBTGkVEhURgEHiaFC2uoE3o3myZXb8PQv+Z51tw0JwF+xspRB+RVBVxEGh+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRFole+wjCH8+3pHKBIf1f+nczGU7EkGsBK0CoTO5AA=;
 b=QQz7RSd7WnGvE6QYarV2U1ShaXPA2goJ1PlhCb6+ozwksqWMu8s+FByGf+bAZC/3bLp5JCu7SW59DZJ4VwUELFuW4kp/+kFJXusVKWoB3o98MXb2GqF39A/U85zVVYm7FYspqCyYGe0ZIZmrLrsIkaD1wLG7FtD+/ETZ7F57X7ACXyLgrv5pEXeozCCEr2lZHG31j8jnQXMWkjDeohkd/wpe69IVIJ6XGMZOTpkH3wCW/mtUXYkU9dB5l6sPwXGcUbcZuHIPGTKwdq+OUjXWVxA8AknkLsp4Gl9IaYCW8qY/D6CcDPDGXK745JHhCAi0A8xQxqyUlz23j08D1mavgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7680.namprd11.prod.outlook.com (2603:10b6:208:3fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 02:05:01 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 02:05:00 +0000
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
Subject: RE: [PATCH v4 2/4] iommu: Add new iommu op to get iommu hardware
 information
Thread-Topic: [PATCH v4 2/4] iommu: Add new iommu op to get iommu hardware
 information
Thread-Index: AQHZvh38FAJVRPiWykeLMI4rhnTRSq/NQiKAgABy7YCAALxYUA==
Date:   Fri, 28 Jul 2023 02:05:00 +0000
Message-ID: <BN9PR11MB5276E84169527ECF2D3950E18C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724105936.107042-1-yi.l.liu@intel.com>
 <20230724105936.107042-3-yi.l.liu@intel.com>
 <BN9PR11MB527625066E23A1C4968905D68C01A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMKCd5S9VpNGf631@nvidia.com>
In-Reply-To: <ZMKCd5S9VpNGf631@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7680:EE_
x-ms-office365-filtering-correlation-id: 2fb6ee29-80a3-4ff1-37f7-08db8f0f0cd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SJwda3e0TWqV3ZR79ja5ZeqrHHpf/iFmZfAgxi+GpkE/lTusa9CN231n94H1Roc2BuouTlVO1yzMp9Kw4dnH7ajkMqM8veWzTmsNXCCGZ6C0+1Puz3E/RL5essekXC0BpbdQMr0FDReApH7y4BeS5K2TtUlIr13T0YGOHEq5D3H+wpXvIBPV60sNWu6h2GugR4JdKtAbcxIK2kKphXUJjO1WVz33EwIvwbZfZZ3tX5SXMu3Hm48DKZ+E6KaSqLPCN7Opd48bQ/mWyO1m7vefGhGOAchoxr/5oqjdcBUDj+81iLgWJC+IwFg9vieu3HUAqDV9YggBNS93rKs9n3fp6xENeewVFflCNk1Tc6dxSJHQ3vOe+FSeiiws/nzl1pRBMk9n8k1XCUSS6+yEx4s/t2xj74wo23Rilmtqkcc5IkWpMQHbFCYxEFpXBmT+xDiPyLus8zrn9VBS5EutUttjZOxsalSX++pBeKMUpF5EsO3XHw5dXHNegWF/YJGXHJOprxJ3vUvo5OLHTMP2XdG7H7D1whoFrK01663gGhbggYsmlm31VwVhV50T+ESNBCXzGE0xZpHJorSx1WCgbWJN4oftC5kROEqwVKkcMCFRZwm8+mmCK0CPe6xcKkxcN57Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199021)(66446008)(64756008)(71200400001)(6916009)(66556008)(66476007)(66946007)(76116006)(26005)(41300700001)(4326008)(7696005)(8936002)(6506007)(8676002)(5660300002)(52536014)(7416002)(54906003)(186003)(316002)(9686003)(478600001)(2906002)(83380400001)(55016003)(38100700002)(86362001)(33656002)(82960400001)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BZmXYKpCgCfLoroKIhK/8uG7xD81Egx94W3cvHUTAP5ma6cEsm+p66rawTUV?=
 =?us-ascii?Q?qnxhJZ6fU1Sb7hbt/nSLH0RUOgu3VDh3iDaiJ8ptbTYg/SZGTUfThSbv1VM2?=
 =?us-ascii?Q?R8qgryXywUw6Czzm3Iz3N1wicq+k30/ge5jxnCQlmBA4/yXxMEA98dAVbvp9?=
 =?us-ascii?Q?ncrqIFDLLrDFth+cyS6RInM1rz4NTX4fKWnCAgBNcDcTJ8sUyeGf984V5SGX?=
 =?us-ascii?Q?RCQLSTJmLWx1lOi0We7joca+WqfsPr0R9rzZNLinN7TRijdBX1DYtme0kRYY?=
 =?us-ascii?Q?ExmnwkvDG0LSAmYeZdORs98lWEjPpu+69nfuwFN1EV9bHQ5oHhmHGFQtXXu5?=
 =?us-ascii?Q?+g/ZtvU03LqKM78K4wbvWe0sQuDAYOLDvUYBN9ckGjhEQbSPaGXj9o1+cRu/?=
 =?us-ascii?Q?0JjTFnOPvgtdCQ43eR717XuLsk90r5KyyRTXt3sUYcYW8nuhhaW0QDED+kO3?=
 =?us-ascii?Q?T9/n/VaaVSKMfgEk1lo21gFCCP3+qGfaZ2Sirikk/NyGz4DlAscsyhecL3zo?=
 =?us-ascii?Q?6h/+h9jrwNWus253nGwNjRE7RxikdlTtkwZdTJ0xabX0TKmuUmwZ1g9uZ0ZA?=
 =?us-ascii?Q?2n7WKvlgQOQA+QJ1CFEIo4k2tjmDb3VAlcSEm3poeD/e6n1vGKBHP9LirmfM?=
 =?us-ascii?Q?diagpenhOFr3MvhO24P8gs/duwDRG2j5N8yG3gwiu6Pj1SCKMociJ6bJRSV1?=
 =?us-ascii?Q?6MtAtrjWBQb1/xr1QvdU21xhqRs2S5fNRajp9k7/D86zjY9BDBJYEG+N14yP?=
 =?us-ascii?Q?nrx9EIK7Fy7p29SBR6shcIYKLsHgtke3pw7C+ThLHAeUkhzglQB4eoLwSSFG?=
 =?us-ascii?Q?I+vV94Rcoq1q/IgCm1HzqqQ/1s1f1TDRA7yx5UrO3dRJ8G/SLpF3RRvbbuiy?=
 =?us-ascii?Q?pujEJ/VFdLwpjs7sLkFe4kx3s2sqbkGECHvNci9xLEnWyGg0LmZIAJpCMkq5?=
 =?us-ascii?Q?aI0zGKOPtUbQAodP2Isg46AmK0L54yTdq8k178dTz/M6udVrd1E1brstBNXq?=
 =?us-ascii?Q?Gup6gjJbBH9q3dhFmUViglIlmsNLEHs90o4B6xHP1RHG6pVP9JRfcM5pTns8?=
 =?us-ascii?Q?mnqnzPf3OtemYeqw+q6+eF0xGEt3zwjgnD0pM3vxoB0jjaKvZE0EVPoEn5+l?=
 =?us-ascii?Q?xcqE0AOvsBuntSUIzdTqyqa1Q83BfjJDwI+ghNNvMxW/Ec0K43tEKxFqUVI+?=
 =?us-ascii?Q?qQjF5NWGUdOSO0B8R7L0jqx4hHR0cLzjGG3QUsvyHzYXul1LPx2gUmmE98Rq?=
 =?us-ascii?Q?iCUd2gKvvgHj7ECr5dXMog2MVDqwzF/uPecdu5t3ajr7C8zKrKPlBN6jryVK?=
 =?us-ascii?Q?yjzEXEKCVt6OAOojPwl34WxlPC338xLY7TYylZBOW4FFT//+3CYFfD3NHvhX?=
 =?us-ascii?Q?O5kkN0YTXVeK38dCtW0E3MaA9fSf3AW1MsoW2ojuNtjVQ8WCtp5aNIz4xOGh?=
 =?us-ascii?Q?hhon/6UpsFRtnVrj0CgX0ENmgzGKP0NeoNgrLY/3MnloK7RVNXBi8ZfKYGZz?=
 =?us-ascii?Q?hcXvYjiQpCzst8xs9uZyoooStbLBg/QzGLA1UUbST0EMGHw4xLVpTOyBvFhe?=
 =?us-ascii?Q?sOIetT5ey/LgoU857u8BR0ay1xL5YV9kxSqUmRO9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb6ee29-80a3-4ff1-37f7-08db8f0f0cd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 02:05:00.4955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yrafqdfUJwEKwGsm41Zk+G1ubJc8+A9zYhA4OEQpvmNZo/hlIx4qXqLfKTWPo24UJQXpplHQ9Nev0cQSzvEfCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7680
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
> Sent: Thursday, July 27, 2023 10:43 PM
>=20
> On Thu, Jul 27, 2023 at 07:57:57AM +0000, Tian, Kevin wrote:
> > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > Sent: Monday, July 24, 2023 7:00 PM
> > >
> > > @@ -252,11 +258,20 @@ struct iommu_iotlb_gather {
> > >   * @remove_dev_pasid: Remove any translation configurations of a
> specific
> > >   *                    pasid, so that any DMA transactions with this =
pasid
> > >   *                    will be blocked by the hardware.
> > > + * @hw_info_type: One of enum iommu_hw_info_type defined in
> > > + *                include/uapi/linux/iommufd.h. It is used to tag th=
e type
> > > + *                of data returned by .hw_info callback. The drivers=
 that
> > > + *                support .hw_info callback should define a unique t=
ype
> > > + *                in include/uapi/linux/iommufd.h. For the drivers t=
hat do
> > > + *                not implement .hw_info callback, this field is
> > > + *                IOMMU_HW_INFO_TYPE_NONE which is 0. Hence, such
> drivers
> > > + *                do not need to care this field.
> >
> > every time looking at this field the same question came out why it is
> required
> > (and looks I forgot your previous response).
> >
> > e.g. why cannot the type be returned in @hw_info():
> >
> > 	void *(*hw_info)(struct device *dev, u32 *length, int *type);
>=20
> u32 *type
>=20
> > NULL callback implies IOMMU_HW_INFO_TYPE_NONE.
>=20
> If every one of these queries has its own type it makes sense
>=20
> Though, is it not possible that we can have a type for the entire
> driver?
>=20

sure. I just prefer to introducing new field only when it's strictly
necessary.
