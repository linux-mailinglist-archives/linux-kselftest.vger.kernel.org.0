Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5DE62576A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 10:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiKKJ5T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 04:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbiKKJ5S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 04:57:18 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A327F67136;
        Fri, 11 Nov 2022 01:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668160637; x=1699696637;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iLvGecEV64WLEZn4D53ab7i96z/lU1rfwOb5OHXbCJ0=;
  b=Gb+d8Ye8sM4JdFV4jjD31I1Um/EV69FTALmFbydbNBGLJwb/F6/CL8XX
   GUZUflb3pc8yc/HidiI7LJUkHFeQi4rQJVb/WUfJBaYYCQKAjbipYTyYT
   uFMtsVmXKf8t5E2g/Jt8zE9A9iS124vEyNwBiTWU6GvUpBizKaeDrrRad
   ac2AK5aVoNG3hBWhxDEDNaaS/JwSW6o6eyLjrnxQOK7gTP/EFaIKGnhLh
   mJFVUk0OKxWZ/rh0FdnS/rJ395CHXZcqtkdM1sIAJIh6i8VwzxW9dD2hO
   Uov6BLSWFdhYFyWmAr4tYPnp4j/RRvldz957JPNBzinye1MkjVq18ceRs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="309194984"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="309194984"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 01:57:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="780128593"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="780128593"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 11 Nov 2022 01:57:16 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 01:57:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 01:57:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 11 Nov 2022 01:57:15 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 11 Nov 2022 01:57:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyLRHRIjiGH4OgVy+DaCFBqEIsDgQNzzUsTm8CUmKX/JDEHd8SvthgDJUqySmJuyMVy0eeuT/V02M22rck/NLHW8SK5l3eA6s8duhs4K4/RW2iZS6zvddLzBwGYo0UtBMdwgKgK8vRl2QdFvD2OH3ASVH2bwN8eSFu1acM7hDwjh9uiNG8D/bAUNDnR5zNLP2jgK8PYfZWXXfrEq+cN+RquUu3KBPG1exFqqd61VUE1aNedM8DwtZzgDsXSsFvjLNx/pMZ+iuELAAQKWQhTFemsvIwIq5e5boBgkd25GY8aZpOsBPMilbZf5GcLW3VOFXoTnfEJGTTvp/cYgqRVLHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMPi1YtLNQ+wQ1pyMl6UBh1aHrwH/MrczhKg6TVTrJA=;
 b=iaarp72ASVTypk9yB8lxXph7iCj24VjKKoPvCZ2Um4yuMs2dn6XwWI11X+kKuVJThYLmG2LibUWlqVHLLhh9hbSeWArWz8Cz21uM2AhmtAz3tpc0tiecH8v4gvqdpmkpkHtQpGlCagWCOOQ0SlmGaMKJkaabLwFHz6EwI4n7OcBVAPP1vSzh64hTpls4UTaMH9UkeeJ2yjI1UKVJkM9nBvG1he2MwTbj9tnd9XUrf7lOq1FFTF7Za7PlLNFK6w6euf9yeMq7VDv3aK2ai1lXVNRBU9jeFlFw4N/hwax3FWb5AcILnhbxYoQdA4gVxt2WG6bMCQtf4VJfyNJ5lTv/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4680.namprd11.prod.outlook.com (2603:10b6:208:26d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 09:56:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 09:56:59 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "Joerg Roedel" <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        "Suravee Suthikulpanit" <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        "Jason Wang" <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: RE: [PATCH v4 07/17] iommufd: PFN handling for iopt_pages
Thread-Topic: [PATCH v4 07/17] iommufd: PFN handling for iopt_pages
Thread-Index: AQHY8wv9HPFWNovkcEqO1j3PpM9p5K45QuUg
Date:   Fri, 11 Nov 2022 09:56:58 +0000
Message-ID: <BN9PR11MB5276A7603D48E46D82B763118C009@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <7-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
In-Reply-To: <7-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4680:EE_
x-ms-office365-filtering-correlation-id: ca43a3bb-53a9-4fee-4e5c-08dac3cb12f4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +1d5kc7I6LZktDGpEt+SzL4dMi5C3/D07+8VzBXHS+9DfL6bzf+NVMZ0ZjKyEmYfTsRhKGYr2ordvt5e4VKZcBXhvPKi8Rz7jTMPvVEjrQGqBScTS2W6VPct+cbHgUBf6CYh49Wuwb7zo1tWrDeTbgseNeMeVZTsgVznb5TQl8m5eOVsXztTESfWSUjbpykO5ubnnhJqfoLyQ4K77t7hTJ/Cbcx+asX5IqLKkOBouJ0//Lpdl1glatlLlAV0QT4sTgQafkjm+4ZdfTHxRJG5yizUSrp/zrxVfMwuX2wPMtS9jMSGVO3f602LpMuJPjAfJhY3rwdH6fOChLtV8gvj10qSjMmuvwgiEZEk7ocCrRdjzynTPCawORkxwmshpjmNpK9fzG+2Vc/bYIYoQUhv/G5qF+O8JzAPo781Un8Rhpi6dWdJ2d6/i4QLTMLHqVrtj35t9rcrtppLRDQy2yLn0aW7u+gz8L9o/One92LXbin0Ol+IlkV4loAF62gG6ZJFaUKL8Qsk+Oqody7pQdBAV98QE8aIv5c+uyCnWBN2uM197yO3TUna6o1Y1MkLZzikhUpvoRa/8P/al6JAj+Mqju//3/Tjfk+1tqkJqg1+RaEC77rL5Nsz3s3FsIqSmRn0cv0hiCBpbvBIBiP8SqFrukM7+VSyxoNTuAr6zb/0zAlsQsx9n7Q7oyTcPJgZ8Cj7obh0XQWgfhMGlsj7aGhKJMhLrtAg6nwsOpA0t/5CeaYfTpdqi6uQdj54HbaBoqMyNfJVZZvs0AZ75yL4MCZ74crNxLNygtxVegHZ9yFhp1g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199015)(66899015)(2906002)(33656002)(4326008)(7406005)(6506007)(38070700005)(921005)(7696005)(122000001)(38100700002)(86362001)(186003)(7416002)(41300700001)(5660300002)(83380400001)(54906003)(52536014)(64756008)(66946007)(66476007)(76116006)(66446008)(9686003)(82960400001)(26005)(478600001)(8936002)(66556008)(316002)(110136005)(8676002)(71200400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q3XGQXkUR/mF3m4gjDwQETiJdG18UccFXHhI+2evQkYk5UBPq8yOci2bC8IQ?=
 =?us-ascii?Q?yos5JaRBOSLOZv1Y3DW6WyB3v84eD2RmUtINSuETaVAc32wNOrWvUGnkrz5g?=
 =?us-ascii?Q?1lNX9eFph41mjiayoV3jDYpYg48nJmIWeZT2hFEj/o0B/Cfy9m5StTDXxTto?=
 =?us-ascii?Q?G/6BYI0OliZQrVNVvRNgbhouBmsRXHxIi2A8fAb9Av8+JowDmBTqNVyGVDIn?=
 =?us-ascii?Q?nv2ZOpnUuZxIT86CBR+n9GD2v/8tDMDRF4VpGAEOHg2jx66vzsW0kA8z8d/J?=
 =?us-ascii?Q?cdPdd2mONTuwA0TdO6heVpUCeOM0gkXrKoaU3YBEPp9wR4uohe8zDE9sW5SD?=
 =?us-ascii?Q?3YsYJk1/ogtgyiGSSKcTZCY10BDaOLxMyeBZy4O+sYb0gjiKZnNRpbnt36hl?=
 =?us-ascii?Q?rlS0pwNZrNicU6DctVNp+ep4+0IQzT/zgRv4GwGTWqlgpyxJZM2vt+ZEB6N6?=
 =?us-ascii?Q?8zLd2sNHmhPHpGUl0ecUfxKiZR+QJ3NsHR6pefEL/Cm7febKljRCdhC2CMdJ?=
 =?us-ascii?Q?UdD5S6WBLS5aZG/k1mRKhS3V5iDONc9Bxi8HyJgAJ93W97j2S4/nPicE1zVw?=
 =?us-ascii?Q?d8F+AHx+4biwXb8d1RyaU7wwleAjfnBF8O9XWZRUyBXrkFLhpw9B/DY6UypM?=
 =?us-ascii?Q?3+Lrz06/x5eSogNlAyKRzOKrqLe2xkdioc+MTGym3P8Q7zI9+84AT5x2fitX?=
 =?us-ascii?Q?iXer7+wwj17M9sG2oEOCsZ4pBS0zXnMr8MtYoi4uvIprIG1TVBYBPCejjvrh?=
 =?us-ascii?Q?ex8p2TOAja9h70jEUUjtv4++HnJMq0CQqFHExbyt0jYYfSxBxCg9E0xH6KvH?=
 =?us-ascii?Q?xdkxiLWgKoDBB3s+wHuJ6SQKigNWzSfC5Z5nMabzxEL8vfK9umaHaGGtGahX?=
 =?us-ascii?Q?36917zBwLxl1mYMvWUrzWnp+FnFHa3LdgAJwtiat3+PW4aqcfGnVavZ0mjtT?=
 =?us-ascii?Q?4wbWHQrEu19BUKucV0OboTWGNhQbyD1MAej62yCDRM7vh1TAvqf03A7unqJe?=
 =?us-ascii?Q?WzWjvrYHZXYHtdVPZZU7fK+0zXsmscMDwC9iNSfogUaPwzFXiASVL9vuYg5R?=
 =?us-ascii?Q?2pkfZ5tcqtrDN5JLwsx0QQhRYHlE2NYy21w87oYJFBak+Fyz9Sf2waFDOx1Z?=
 =?us-ascii?Q?UGywexeAjeT11AyVn9OGe5NPdChGUsWIs6dXLJAAg/dKmwpN9uVQye+NPB0x?=
 =?us-ascii?Q?y/RA4aF1WLHxM0kkzgjurfgQzMi7+xJsGegSuf5J6V6Twtm1gEQMFdkeY09e?=
 =?us-ascii?Q?skipapmEHoUVW0PMYq6B3LDSmN6hPNBAYSb06mrmLfUEbwwN7dFbdB0aTs+Q?=
 =?us-ascii?Q?YI5MOH5STY7FEeLr6QBvuachCfZuePOFFlmerXsUs2ofTBCJypXtsqPFdO0w?=
 =?us-ascii?Q?MRqa9Rytx5aN0zOYoUzCYGwV6k+PiGyen9FJOyueteIeJ3dKKQeeyejd0huW?=
 =?us-ascii?Q?zzHaYYzJaM/ucWbniDehbt1HiFOadpo8tYemv1CyknFJShYyoyVaQKGzw3Hu?=
 =?us-ascii?Q?lNUoJF1CWB29nKNdJjRPQIpN7f+wpUVZ1lCJvp7qjwULUfdASlX9UOCeBMT8?=
 =?us-ascii?Q?88ON67IOV3HO4YCQfBSByVkC1kBvgnpcUl92KM+z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca43a3bb-53a9-4fee-4e5c-08dac3cb12f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 09:56:58.9656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XLF1ic1PVZ6A6Ds+yIG4FKJHMW2kls4OG7TyN5/DGG/V1Yq+lTPx1TmBkFd7ogBukvlLF0ayPbP8MT8HRyRTLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4680
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, November 8, 2022 8:49 AM
>=20
> +
> +struct interval_tree_double_span_iter {
> +	struct rb_root_cached *itrees[2];
> +	struct interval_tree_span_iter spans[2];
> +	union {
> +		unsigned long start_hole;
> +		unsigned long start_used;
> +	};
> +	union {
> +		unsigned long last_hole;
> +		unsigned long last_used;
> +	};
> +	/* 0 =3D hole, 1 =3D used span[0], 2 =3D used span[1], -1 done iteratio=
n */
> +	int is_used;
> +};

lack of a comment how this expects to be used as done for
struct interval_tree_span_iter. e.g. there is no value
representing used by both spans which implies this is used
to find valid range in either side. Those should be spelled out.

> +/*
> + * The IOVA to PFN map. The mapper automatically copies the PFNs into
> multiple

what is the mapper?

> + * Be cautious of overflow, an IOVA can go all the way up to U64_MAX, so
> + * last_iova + 1 can overflow. An iopt_pages index will always be much l=
ess
> than
> + * ULONG_MAX< so last_index + 1 cannot overflow.

remove trailing '<' after ULONG_MAX

> +
> +	ret =3D iommu_unmap(domain, iova, size);
> +	/*
> +	 * It is a logic error in this code or a driver bug if the IOMMU unmaps
> +	 * something other than exactly as requested. This implies that the
> +	 * iommu driver may not fail unmap for reasons beyond bad
> agruments.
> +	 * Particularly, the iommu driver may not do a memory allocation on
> the
> +	 * unmap path.
> +	 */

didn't understand the last sentence.

> +static void batch_skip_carry(struct pfn_batch *batch, unsigned int skip_=
pfns)

add a comment similar to batch_clear_carry()

> +{
> +	if (!batch->total_pfns)
> +		return;
> +	skip_pfns =3D min(batch->total_pfns, skip_pfns);
> +	batch->pfns[0] +=3D skip_pfns;
> +	batch->npfns[0] -=3D skip_pfns;

what about skip_pfns exceeds batch->npfns[0]? looks this works only
if batch->total_pfns =3D batch->npfns[0]...

> +/* true if the pfn could be added, false otherwise */
> +static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
> +{
> +	/* FIXME: U16 is too small */

performance or functional impact?

what would be the fix? and why cannot it be done now?

more comment is welcomed.

> +static void batch_unpin(struct pfn_batch *batch, struct iopt_pages *page=
s,
> +			unsigned int offset, size_t npages)
> +{
> +	unsigned int cur =3D 0;
> +
> +	while (offset) {
> +		if (batch->npfns[cur] > offset)
> +			break;
> +		offset -=3D batch->npfns[cur];
> +		cur++;
> +	}

'offset' usually means byte-addressed. 'index' is a better fit in
this context.

<to be continued>
