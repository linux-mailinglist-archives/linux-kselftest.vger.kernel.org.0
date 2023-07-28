Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E5B7669B7
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 12:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjG1KDh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 06:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjG1KCt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 06:02:49 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4200A3C1D;
        Fri, 28 Jul 2023 03:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690538564; x=1722074564;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9DS+6FYz9xFrauhUKWrsJKMWcdNhMMsBDd8Z23d5H90=;
  b=QiTKAjjSNr8YV4nWw+XJShxX4RUbTLoVuHF2WUkjpyrbjZNi3ltpZyp1
   QhrztzO/hqwJLLQKpUdl3Ql4sk7f209Z6PUgW5LwALJ5SFu8y4nDNW3Dh
   y2DWe3D9mCwBZZiHEaVjeGdiZ5qq4xiLKc/kmmmTD98YoPgDVPiTEluCg
   vI7BwdN/IRGwnpfBj1CFcRBdo87xOV52lY+rgFGTWr3i0NewqsFaurVcO
   RZTZd/QeG8u4lRLA+DS7AX9huVuNyjUk+UwUrHh7rR2OmN81XLuXCCXNY
   6iqVCXufAyPbFAHunCmjC7NvCNyahszjmP8SvOdhz6eZdQdGLUGx7oWKR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="371257133"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="371257133"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 03:02:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="762572142"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="762572142"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 28 Jul 2023 03:02:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 03:02:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 03:02:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 03:02:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 03:02:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bO0RgvbHc5daRkv0BqrdrWRY271HsvbYG62DgKDFjCODzilBT60IwRZTPX8BjJlwEl/dVSi0wKuwlHWtgzqsPPY0JgJzHc3bsmpcftbdV0YpzkIMGqXmOUDaiLNElQVHhMreCb4mtsBVh1RruJAS+ZFCJH7n+nOceN2xhFRYXO0qyXlWHF/6Y79ptyXTcz97O7raBebAw1gsnoLjeJhcsJlRt/nTLZslx9IaHVQg1zLeJprpDM5Y8gnHh6vvnpV+G6PxaEhUTDpFhVElUGvujBHDopwFA1ntSxKLYuHyik+G/oLoCQ/DFw3Uol8UPuaOiM0wWleMJzqC6lLfle+lDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVN8Clc38Z0g5eM4/KwGK8uWzBa/p8EUiu7LbmX977o=;
 b=AjZjDgjueaYJT/jaEBvBTrhLNqzqAmfEr1bEwU6URwojGNJOsGiF3gT5gcU/uMpjdxACK34i86DFiCPqIScKDC4WZCDonBzavbK1/jZVa6YuQRyYM9BmFpBfSDxxBkSOqJL+M3iaWVMC+GuKH2bnCY6M78JiJaw3V74jFswkmfFFC3iYi6eR3hmcjpwYusaK6C60N0HEeyNoLJVMhILsDsPPRc2s8hJev3LAEX+TPtz1eqOLzW66mOF3ADEW5PNxAztHT/GCyhecxpw8rZwWApaX/4mDu0gPG7CO/V9/2zMD0cmtWg4BfYlXXozNLubBfpQD2N6ik6z84jJh5jZ9nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6881.namprd11.prod.outlook.com (2603:10b6:510:200::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 10:02:36 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 10:02:36 +0000
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
Subject: RE: [PATCH v3 06/17] iommufd: Only enforce IOMMU_RESV_SW_MSI when
 attaching user-managed HWPT
Thread-Topic: [PATCH v3 06/17] iommufd: Only enforce IOMMU_RESV_SW_MSI when
 attaching user-managed HWPT
Thread-Index: AQHZvh6ZyOj60q30G0mrhoPQe4EAH6/O+EEg
Date:   Fri, 28 Jul 2023 10:02:36 +0000
Message-ID: <BN9PR11MB52762EE191ADD610542EB06D8C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-7-yi.l.liu@intel.com>
In-Reply-To: <20230724110406.107212-7-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6881:EE_
x-ms-office365-filtering-correlation-id: 9462d7e8-dbf9-42c9-d47b-08db8f51c50d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q1rSoh514iq089Xb0zI/cJcX9gqHYOKmnUZnal9jB1D3YC8pb9/6PomourzbxL8yLPjWcnjJC9ZE2TtOn0GybDgPtDbQ2vw4wemPN5OyoOc6uQ+i/8OwGHGp74Ni0ShEvupuf/5cDReKf+yenMQFq5rYGDRe0xn0sMHFwbL9Q+CXjsQsObrmhQqic30endWgqFgwPIn3juJGdq2agP5dPsIHcBpn1GDeUS+2xzUDFpCyC6Q4PhgmYypqpZb5fSoaJ9FJqFZmVX4fBQlTZya3kF5WRi+fcMUJUq+V3JS1CZ7zJnDoq35AT33cXkRMdR2xi2zGIVL7o6NFQG8JDpEwEHhC6L6qyAvIfLEuAZxWmPUwXXcuvbiXnnevfzRFkysRr+2gg7ZUAN7rf54bYcgRWbyq0Al/ufy5pydNMG3hLU+84ape4ZNkQWc3LJ6Lx/dYED5rYTgAa8aBopIbGY3pdlHOdJtfnZGE6vw8CzXqP1hb1XR1aOi5hFv4RZoOGt0YoFM/9qemrstP3MrjjCKO/So5iCHrYiq/LLpkS0N5yOdt++1oV0vMOa6Rbrvfch+gQQSZM5WB2Pjo0TVBKRYjdvRPL7tw8pi1lBivCI7Qvph56k3deU/DPLyE2VlUgbPlz0Rqd1pfQWXu0t898tshWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199021)(8676002)(8936002)(86362001)(41300700001)(33656002)(4744005)(2906002)(83380400001)(6506007)(26005)(7416002)(186003)(55016003)(5660300002)(52536014)(82960400001)(7696005)(478600001)(76116006)(4326008)(64756008)(66946007)(66476007)(66556008)(66446008)(38070700005)(71200400001)(122000001)(38100700002)(54906003)(110136005)(316002)(9686003)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?59obDmHrQMhDKaeFfdIAF7wXx+PRO1CWonSW4tc4/Kc9bAohPpfN9L/pgnaR?=
 =?us-ascii?Q?PpaQl0QNrkPTw1WyfuokWdyciCBsFJaMCwhdVrAZTKtOlEUWKcd2ubhtxp/H?=
 =?us-ascii?Q?2+961Rf7A8ptq8557x9IAmB0Zgos5VBkk/w+9F6yvUsgMGazpEL4s5M9yU9y?=
 =?us-ascii?Q?7d6okkMRv6gv0z+IG4Zegt4I95TndsyXucst4qCR9Y3Ng2AGnqEbkNyGaaQw?=
 =?us-ascii?Q?Jzf430hntj08gAC0E4VfNLqflyfdcBymuF+lMAIe3TapOUzWduMdXif1R9AM?=
 =?us-ascii?Q?y4EoctRoj91ArZi2zWE3MQ3zJFT8HiRxwdhXa3mx1LraBLQpgjhdpwnQQ67+?=
 =?us-ascii?Q?HQrrw8fqx5ynLMV+f9/+fQROIPk2sx/4pJ2gLGdWQ5jhHZZZAL/D4ukTAHLT?=
 =?us-ascii?Q?cdrFfDiIF7pXRF5GHZZlaZKAQbukqhKS8+oPx/tDKegHBt+vwQ0pwIi4VpFW?=
 =?us-ascii?Q?CXwqN4guHmP+APA+USaC/eJwkdiMrznG3zDnlZBfIVkCSga6ViiVlb9X7IEw?=
 =?us-ascii?Q?w/TO2UbU1RfnU2O0txqlaqTJ1ReHIog8BesDrtZ6tyzhhOsVVdSKeTumsXza?=
 =?us-ascii?Q?6Xa+svcZrca5X74mGHtCm0ZJSE5qqfxp4tRBh4+nC8lQl2JKFJKV9UuESTKm?=
 =?us-ascii?Q?UHqJf7ayzIOSRVuhIYjHa8E7BU+IJwaNE/yJL1KYeqBAozDj9I1Lxuv5vEn4?=
 =?us-ascii?Q?epWhb2njghu1YUDB9t5iMfLZ4dLC9HCtqJ18VtMGUOVhgYVmazwt0tlQ1+1i?=
 =?us-ascii?Q?FVxj994fuR6gQbUT8CQUn66WE01xTSkcik+d4Hbxokaulx+EztPQpuDUOBVB?=
 =?us-ascii?Q?z9pM6ngiJm7AMil2mT4sXKNEtLbIix4A1I0oKJc9dL3VqCTeudf1KCO4F0eJ?=
 =?us-ascii?Q?sdOnz05KkAkiRZ9tKBneRPt8Nsz4QVoNLCFAf4OJLmgm9wyKAaAUKPsE9bZu?=
 =?us-ascii?Q?mEv/jvfWdB+EohBU+dJvmURdC/xC/3u6ebE9lUknx/bnA+F5rz+GDlIcZPL0?=
 =?us-ascii?Q?SKpNJuPZxCZKdfGKu0PzCR85q78IEdoklmSiYU2fDDIiGx5WJZE0zzJdsCGw?=
 =?us-ascii?Q?WQ1pLhZ9w6f4A3QSU26h4LaQXDDlkiMwNQjh2ZwnwubiwjZygd/cZmHhhiQ3?=
 =?us-ascii?Q?q7Pja825m51lwHCo+sAFImHzmhwY5EkhgDALEFb+5tuiainLOoA7NuiW5jJv?=
 =?us-ascii?Q?lQ7Wue0z2S4/3Ah0FlQDOkBy9G15q/IiRHNyeXgdpx3vH/iTSyGgH1H+XPjX?=
 =?us-ascii?Q?jQdlk1qDaiugRFDgsk3nx0BUHJPOOOXGKI6QKTeJ+C/it55ZAKqC7caL9YAY?=
 =?us-ascii?Q?PejmQfCnu6Aa+Ydva36RS1E+ybW8TQN2TCV7Et8WiRDGA0EBGNFGnMOpkfMA?=
 =?us-ascii?Q?K5XiSxnMiuDDVPplTUq5OWF3ubjggiHTIssXsEa93ixKcTLxb6YkgBqSf/VE?=
 =?us-ascii?Q?CB/lAM6RDJJ0roCbpWv5LD/p6dnykM31k7fTrW8FMFRZl2NAEkuj37XQ4YvF?=
 =?us-ascii?Q?oCAPR+BitfUV1Eh1CK2XDgC+P7WffvH7xHgkQjiaB+4NmIjl/EFJeXx30sFf?=
 =?us-ascii?Q?wn7MfxcpyebZ0m07dA/OQvUv41dloU6WZUVUFPYz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9462d7e8-dbf9-42c9-d47b-08db8f51c50d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 10:02:36.3615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JZXOiKJrKKM3O1ceBIQVx34/Iv1FCNW+eKbwPo7hAaJxXrTN6tvX5nrDHJccGNZE8bJA7CyJhdUwtkBjxZNkxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6881
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Monday, July 24, 2023 7:04 PM
>  	}
>=20
>  	rc =3D iopt_table_enforce_dev_resv_regions(&hwpt->ioas->iopt, idev-
> >dev,
> -						 &idev->igroup-
> >sw_msi_start);
> +						 &idev->igroup-
> >sw_msi_start,
> +						 !!hwpt->parent);
>  	if (rc)
>  		goto err_unlock;

I prefer to not setting parent ioas to hwpt in iommufd_hw_pagetable_alloc()=
.

then here ioas can be retrieved from hwpt->parent and then it'd be pretty
clear that in nested case the sw_msi reservation happens in the parent
instead of pretending the stage-1 hwpt has an ioas too.
