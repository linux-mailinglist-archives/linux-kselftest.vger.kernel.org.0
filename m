Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7744E6C2771
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 02:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjCUB0t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 21:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCUB0s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 21:26:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AECB1BA;
        Mon, 20 Mar 2023 18:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679362007; x=1710898007;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LtUJ07a/truYX+NEfV4ZLkuSkiJJV/MaVr/UNe2ZYw4=;
  b=JTdaaE3tAo/ujtZwBajUTvkHFImwGyXqjLMZHS+khu0ssOzztvmJjEdZ
   0uhP8CqccVJCcyk8b/J+lhw509tGKgevh87seTi+hTk+jy1mR1El/WjpT
   mOYhybRXWZL3JnbGHe4Nvnk1/+UNSJ4GsbdccIhzae72wDTSXkgB/dYVr
   +mDQi/856cjVuw9y6ahmZqmiFRZ7S6mAMKgDzXfwUJ+C8JbcGQUTgeLpj
   YamUyGaSjJbzbfdNWRQ4V9DZ3VRF1e+h8ekktF8NJmtqwwC8Jooz5t84Y
   POrOr6ZTk2pxvsqJcGEvFdl22skvXHRZUgNz3IbAWhZMPxAeRMLTjeoLW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="401393816"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="401393816"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 18:26:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="711601182"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="711601182"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 20 Mar 2023 18:26:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 18:25:59 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 18:25:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 20 Mar 2023 18:25:58 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 20 Mar 2023 18:25:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlU/sCq+cEupyM4Vz70cOkFqBERwno8A1UJOu+z0HxGSrIj9p0eD9MpLKrhZE+g/B+DdutlXAFSRN5mec5+bEz84Wl1rbLcvZAP8NmPLFdc1SRIV3Zbm5UKA+b6TSkwTcKXGmfI/Wod6UvsjCI6U94mJYIW+r+uWcKpAHtOhO930BanloZD1+puV8WXCUV/ifhs+I4snS/mOsXgpXfCT/SN2HflqTliFZmWqHKn+PokTrSOelBk3fYLgu96Bosj7d0cCGJX38rOTyv9s0sRSxJYkgCsbun5i/Ltcyl+GdPNyhmKwjQzN9C9xl0MJ+w0ry6S6nIhvgFo7IN0/0UGkdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbBbhHSYFvcA8YICf1URyY+7PHcgnbHkzzbiHrSqW+g=;
 b=is5EYRIM1Uj3AdOCigbxwYlBVLTJWum1rkW/zRvwZzLjmUoBI504cEaEyDw4xiK22gXTcvscvoIajBVxHwcBvhs2NxtR1XfcosYAEt9wIsQvyPQZNqxe7FiTsbmIm1AyZaejcqzreJyuYytzyGThFxvORbIDlkP5+0EKNQJ0mAkdLOxZymSvJKtHaFMKvwFReHSWLOoaNiQeSKyMZHolCl/52uOb2I2Vsl0f+xpm6D9yTF3LTEyCaB+W2pXP+q3Jn3cSdzIMk52bdyCxEs5iWd5IWiKQrGl43CUx7xCNU7LF3BHLXGdZSSSsrlN/s6yiWLahXq3dyPWAlQ3yKloPyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB4807.namprd11.prod.outlook.com (2603:10b6:510:3a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 01:25:56 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 01:25:56 +0000
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 04/12] iommufd: Pass parent hwpt and user_data to
 iommufd_hw_pagetable_alloc()
Thread-Topic: [PATCH 04/12] iommufd: Pass parent hwpt and user_data to
 iommufd_hw_pagetable_alloc()
Thread-Index: AQHZUl5+74r99ujM3k2mVNy7XlBGXK7+0CWQgATfRQCAANJZEA==
Date:   Tue, 21 Mar 2023 01:25:56 +0000
Message-ID: <BN9PR11MB527689FBADB059536F0265F48C819@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-5-yi.l.liu@intel.com>
 <BN9PR11MB5276815B943E2232F158C0128CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBhVyqEeAbnJJqNW@nvidia.com>
In-Reply-To: <ZBhVyqEeAbnJJqNW@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB4807:EE_
x-ms-office365-filtering-correlation-id: dbd5bf53-7f39-4bca-6565-08db29ab387a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VbQpHQIDABg8j9VCO+qOOsy4JO3vp4qbsGSxrMdx2sYY2A1kTsxftKsAJplcqB3c4M7eQ4+a+/NLY+DBZeyHiJwPM/OnEub5Dic1mtkOVLReUyoYOl8CY2LZwUUjehrQ912rk7TDFvp0sWiA/+RKyOWo1Tmsxq2KiZ0XwCxiMXc6MNrVqnUpCmlRoQZpdI1/31TTy1i7NlNWpQ41uHYjEcD1EPUplCSu61C73HmvI9ttPhLhr/UCmZ13r6X9pvRDUQw48pDbrUJsN/DT1f6GshrxAwCSdDReTW860CbIqUoJYOGvnhU7bvVUo1o5jC4F27B+ath6NAJ2uSqfjRmUjzUnl8MLtw7S+GjUZzZanuWkGa5+KOSoFwEe1ofny8WzVCd3ikzt5mSXMxQaJXt7jyXlweJdKV6FwkJ9S1mxOY6RT7dpb2EWDOPLYaG8FveDddfGvg1cdzaRKWX+686YhBvTE+8crxRZIKtA4N4jbQlOzSRow/jpJhPQJlgEDFEMmy6uPeFk5is9iqKw48im2Hhk+Oxm/rB2E+/qnAbsQPfhjxuQgUee8XGBU958lTHzA6ziwx/EE664kHRPunqZB7rBdfVGxyTQdDT80WKOritswhIusYPWht6JSFmUoVrelYdHBaCJqQpZwNQ2UbzaybzgtExI3yOI6PHh/bGdc/70gHdMHIkSe1KHPaC/iUNqHOzP0n8xH1GAM792Y+nUWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199018)(38100700002)(71200400001)(7696005)(316002)(4744005)(55016003)(54906003)(33656002)(76116006)(6916009)(8676002)(66446008)(66946007)(66476007)(5660300002)(66556008)(8936002)(52536014)(4326008)(64756008)(41300700001)(7416002)(478600001)(2906002)(122000001)(82960400001)(86362001)(38070700005)(186003)(9686003)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pKFkFzi3a1gKRP7bObNBttYGWELowe0K/dlzt8ArFtpqHAvZ+qi3rj370uY+?=
 =?us-ascii?Q?3+Tv2LCkwQyiU/0R1BYMmpFJQxOF/JFzL6A64UKH9Isr2wuwFo2FAWxpj+Yk?=
 =?us-ascii?Q?LYGg4KrB8+joT02SXzd/7n6QbuHJ4lrqIiScCdrAuqww+4OgCkONrhgwQaGU?=
 =?us-ascii?Q?IO/lwSDXOOoUIcuP0II7a+aSQwvr8/1KQ1a9QwLF+Qr0ATChzTCj9Ag9/kSR?=
 =?us-ascii?Q?FioY//JooEpOPFlVpMu8pOHw93JYCYF5OZwIMmLyTotSJWVSpk/Lcc0IHUoM?=
 =?us-ascii?Q?eytfmbgY8iV3NtXjpJUcOgRu3wgCBKWogqAJUusaL/I01LKfGrbR47I4ZtSm?=
 =?us-ascii?Q?/CNaIm+Od4QEqItJWhUPdwivrtsTf7sAaRH1ZQR4c0oW1npOSQw7jMykL0Wg?=
 =?us-ascii?Q?EsuaGZjZbBud23QutWT3HfVko9wUzc7i7ZpSEshWHVJU/pSUDi2wICeTF1yt?=
 =?us-ascii?Q?wOsvK+EMDHE8NIR/La0KI1d3eWYOeF1DMA88LbnE+JusCBCBipLqRDI6v83Q?=
 =?us-ascii?Q?oBLIgZIkSTlMdh9PunxO82GYR23DPE4UydRD4Pre0fN7rUI4xbqXOxD4qBIN?=
 =?us-ascii?Q?Dg3iux7vAHGiW135EnWhYj/UPeoIkcXSYoaQLTFj8ueNP7CaVYiGpHnnbRp+?=
 =?us-ascii?Q?FaDM3A99Q/PQwGOZ0KxMEJCLELWbCFF7rIwTexUgBRiw17/Sz1bo4kqbr30t?=
 =?us-ascii?Q?i4VMJDBarGcflMXTFCTYbm0Ia5WxffHu21shAnXBk2Vqc0HpCJtCH+UsAL9a?=
 =?us-ascii?Q?lixS94idgDlt8bgPEdhWHKBznior9WQcYb2YAPzPwgx3i1VTVUgAo031HO0X?=
 =?us-ascii?Q?keEx7Q+UMHl3wWEFn3CG2AQ2np7xyrahSiAsk/0MKz5Foc6E5KT1s+HLnf8q?=
 =?us-ascii?Q?tAdC4F22Owprl3uVF/gMsiTIm46ZzeWm4n3Rb6sjWtogJLP+QUKLfIozRPFT?=
 =?us-ascii?Q?fcZiHR8LjeuBQd05zNp4RiToQZ6KKvWvKd4D7zmnYLOoZVKupnkx4NuTfAwL?=
 =?us-ascii?Q?bIoop2e3y7P2h7knlqY4oJx30vt5a8Gaqkq66mM6p+LGjREmirjdmc0AFj6J?=
 =?us-ascii?Q?+XEksf7WBYw7drJSqy2YM7PifKHX+WTREgQwvooan2HZvsXRZaSVk4vgLNJz?=
 =?us-ascii?Q?EtJ+TzW/ZlYSRrypBV7wimOWU3spaY2ZD3wc3xu8XjkCp/SzfzXZiVPZQ3p3?=
 =?us-ascii?Q?VNaDvECN03iZWfSCVOqdH408BZexXTnPtZoeR7eplmvlPBVS9iQ+C1LY3v9u?=
 =?us-ascii?Q?gUnuiHh5RKpxo7Vu6Q5LSg7su0T1FPINY765PZGddKZem+HwXzFbfQzt6MMA?=
 =?us-ascii?Q?ApBSYi0O+uhnHw/Aln24eZkNrHzeOtJQaoj1+CVmAvw5/0EBtptXtaMjd07p?=
 =?us-ascii?Q?+h9xzMcv1rVijn6YEx72GoTG062faLVBfvnEDzii80xsOA08QN0gaIuMyvzT?=
 =?us-ascii?Q?oed7XMhQE2EEGWyAedOd5vsfQMaNAN1xF6VLQNse1Dh6LEWiz3I+i5G4ov3Z?=
 =?us-ascii?Q?p6xqIlApwV5cKG3MMrjImQafbguY+X2hcGzTmlsrrq5X8lHMXLDJmJOt2uIR?=
 =?us-ascii?Q?SNCfVso/xp+eja4h9zj/lIJgrj6A4heReU1hDgvR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd5bf53-7f39-4bca-6565-08db29ab387a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 01:25:56.6267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XkdwgufhKVUstJw2xJeqhajnnrRiXZTbTUzWsbKgchaw6WmQZCLYgF5E/ScjKRyRYafd4+iHE2/biLk5/hz2aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4807
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, March 20, 2023 8:47 PM
>=20
> On Fri, Mar 17, 2023 at 10:23:54AM +0000, Tian, Kevin wrote:
> > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > Sent: Thursday, March 9, 2023 4:09 PM
> > >
> > > +	/* It must be either NESTED or UNMANAGED, depending on
> > > parent_domain */
> > > +	if ((parent_domain && hwpt->domain->type !=3D
> > > IOMMU_DOMAIN_NESTED) ||
> > > +	    (!parent_domain && hwpt->domain->type !=3D
> > > IOMMU_DOMAIN_UNMANAGED))
> > > +		goto out_abort;
> > > +
> >
> > WARN_ON()
>=20
> Wouldn't that be userspace triggerable? It gets to pick the hwpt used.
>=20

The domain type is set by iommu driver instead of userspace. A sane
driver should pass above check, if it claims to support nested.=20
