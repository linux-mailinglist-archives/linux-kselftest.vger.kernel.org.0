Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D494625914
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 12:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiKKLJQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 06:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiKKLJO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 06:09:14 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEB0657FF;
        Fri, 11 Nov 2022 03:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668164953; x=1699700953;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ROBdVy/Cl2K6jzOJUbSLUZHbzjRbRireyt6TNANAm3A=;
  b=nk1qIXlOrl1Jb23T/pRGjqrqSUFXrrolMnZYkou9HvJkzXCJeZ20YPoy
   Lwh7u3ZGl8QEfEOWXfWXQoK0bNpRRCXfu3dO6kF+KT4HAxUu5xDAbM01h
   TGNtE3RVJXU46I6e3vCkJoBkvFwPpun7DwUCS3e+2QmVmrHWqHvaFsKjD
   h1f4kZ40y28zlQ39qqLqzQvpgYC9qOvX92bPECKBzxmBRhKwo9QqHqbYx
   mfrNWh2Ky1NSeE+MQyprQ3XrmCq2+hvAQE/UNz53KysRrpX4WNHRl0zMA
   sKP/7A5BFrdHBudJgyxiGIxhRrpNC2wSB4kwpouwCKmjqLRS32pbhaz8Q
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="312725148"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="312725148"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 03:09:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="882732324"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="882732324"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 11 Nov 2022 03:09:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 03:09:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 11 Nov 2022 03:09:11 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 11 Nov 2022 03:09:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItS6pCsHMLUx7c66pvS0QPov9f2jkBvVmcrISCReF9KIYwRhp0mqe3yjd+dzLEYlsP6gbkgL3VKsF0xWFIOJFSeJvo8RvTV6PpTF9RKxwsbpMZTHHEyNkBj0REOQOqT2zNtD8pph99rvyaSdtUzode9y+j4p9Ab93jl0LKok88+TI+jyFN9e9UtShlep10Sh4dG2rosaAdUHo0myIythM6//OozXomjaQVK/NzKTPlurSKIvAgwnxL2AxD0OyNrni3A/mtfhfYya/B8YYHunxvxjFMTmJGnFLphzamtw1YywTMXBOmXyHbYkeaifBJJg4LuFiBUTr7ccUnSDjZZPUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0kmwmadrQHJI+W5tCov2P0boJ2+HAjOh8mWdYb2nxY=;
 b=a/8wnsgKu36IUk4OPZKzRlIlqY6WkLgQ0VMBsSpMdujChJyiEvu1O8YUcfLUPio99QeQsVqiEq0xNd6xmkIqkIWuPrL7HJDre/Gi58/Me1HJOZVKZyITiuhfj+EBmYYK/qvQgzmf1wyj7Z4/ckWSsQYzoGuh/ejwQI3wL/0pN1Gs32ul/jpAjiKK8ZFxcMQpkDkKxD8zFjGFe2GaKZ/waHld0PYsu/zk1esQ0iRVhOV87oEIKq8gH6hGH12mevL4H3IBlhRA85H2gqyi0LdcpcKU4GjZ5K6gLkjUe54cE8WaH0UR+svUedTr6sW8DqpmQxq8gKJV7OthVBS+W2Bt5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB6993.namprd11.prod.outlook.com (2603:10b6:806:2ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14; Fri, 11 Nov
 2022 11:09:08 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 11:09:08 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: RE: [PATCH v4 07/17] iommufd: PFN handling for iopt_pages
Thread-Topic: [PATCH v4 07/17] iommufd: PFN handling for iopt_pages
Thread-Index: AQHY8wv9HPFWNovkcEqO1j3PpM9p5K45j8fQ
Date:   Fri, 11 Nov 2022 11:09:08 +0000
Message-ID: <BN9PR11MB5276F9A4AC8861005DDBB3A08C009@BN9PR11MB5276.namprd11.prod.outlook.com>
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
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB6993:EE_
x-ms-office365-filtering-correlation-id: cec2867e-9e35-485e-f659-08dac3d527a3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XS+DCpxaEDfptJuRMr1MdutuBXv00x/8LXtZNIc/t3/dUKvKZhO+svlORJJO0pa1Dbyvu88EfxxqVBGCISMDxSg3alwpNtKjaSCYrYPQv7SON7vp29wwWedlVZoBc9eZq1IyJlAPVTtaErtnaA1/KA/xN8fqKhVUVucrV/kYlNKlEL5h/pJNvVmyvlFM+m3m06Fg+Ayqu62NNfMvU9StZX7vNXK0VRDHPmpkp+tqA2jrGINMVtqen8juTbgjFjGz1f2mru0+QP4edWV9jLLzGYSsqfPqli0GE8Tm5wYbiXxzy60yiCSRwd437lmVi5nwEokkz+iEu/0v0iNCDhzZTD3vSfPpeIA8/tzdX+FnD3VeWr/tEnldxpbpiYviL150QO5mHeN4ZV4fKTHCXkH0DFUyTq5T2YcwaITJ+kUgZUprmwPLh1TD2+BGt7YTBBwMR+6bDSv3qrICUrwu4M63l9dG2Xxm4cLtEm2sUpZlJdvfmsqcZiM2/1hK7srYhfhs23PrrcEGckSj6GJcACSfUAT2Lw2zHqaJZ4SkhaiFl+bgpz9/u01oumQUSxqcZYSwJr/k73vINpJeQy6BSGeBKowlYnGr68vUtV7c7SrYs3dzRhP5pmBHGcvIB+oTrlYHlaSFimq2DhjhEHX0trVjw5Dtmw4vH2eo2Gv0QmPAf/GZ2aP3m52TnqPZg9z5dn4SuAolQsqLl2j/KzKDSKTWcPsp3rk5tu5wlvTO2EXwIyYx/GYdT7eXSsOH1kHrfpgvpHasWcRYM8usaZ3edh4wUSkxWk86dWeY1Ckgwu33upc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199015)(478600001)(7696005)(6506007)(82960400001)(38100700002)(122000001)(9686003)(26005)(921005)(110136005)(54906003)(33656002)(86362001)(316002)(66446008)(66476007)(66556008)(64756008)(8676002)(4326008)(66946007)(76116006)(71200400001)(38070700005)(2906002)(55016003)(52536014)(8936002)(83380400001)(186003)(7416002)(7406005)(5660300002)(41300700001)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xjU14MaJnSzFUlbqTxhodhZSHcxfWi+ygGvYc8RjI1qK31ZQ4kr8DfpB1lHh?=
 =?us-ascii?Q?FkaNgUGmdiKG0K8DgCEZ2YSpYlPW8g13G0IrlNwyjqyGclsFE2wX/yskzZ98?=
 =?us-ascii?Q?MJZbq5d53coGBu3LXiNdrXPi/Vd7Amfpw9q/EUdnAKfTBR247luZbC7qf9VZ?=
 =?us-ascii?Q?/NQbHZz4c3NVcL3/7Jrjg+NKZZ0dvKozZTXUFArOUV2PpiuNQn9BDCInty8k?=
 =?us-ascii?Q?WfyP8D4mcBR7r9W2DKtNegP0FF1/IlrLtkldsF8UkF9/6I7DGnf0b+UQfcUw?=
 =?us-ascii?Q?7SizSM7X0ySduTuUmV5dUtMWpur1BCb6I1OA1cBep9gPj5uSHUUoYjApUtBj?=
 =?us-ascii?Q?kr0+g4POAqJKgus7ExKypgpNq+p2We7HfIzwOtiKjTuOAKiuKk7DffbtyJlC?=
 =?us-ascii?Q?aXO6gXO7DwHGTVspV1F9JIloBvLJeh46e/F2sXmDdDqXxnmjNZIdChVKraNJ?=
 =?us-ascii?Q?KU5xzTvKy4Jo5Nk4VxG1f6rAqlgCBTCFzZsGRpnChlvsHVpn3/q1N/pwDZ9L?=
 =?us-ascii?Q?mX5ZbIsCOJ22JWdkx+VLGMP7VpN8McH6g4OX5RBv4azq1gfqq4BdbVom7etM?=
 =?us-ascii?Q?hiFbpi8Cnf0JLrdvvz5EUXZqmPBDJShCLrjs5wWctJi4EukimukTp6mi5n/i?=
 =?us-ascii?Q?nsduEQT3WRKsWxkQ0o7c7HAfXCjGDl4rTq6FV4EBrsMCFkZbnonor1tsAgEZ?=
 =?us-ascii?Q?9jWkYy11qtOMapI6ErazM8TbYljH5TVK6HBSHYZBhDcaZ9zXM2PP58MKwf3u?=
 =?us-ascii?Q?tDW/v4HDmmYFBexYn9bPte8y/0p8qo8lMIrErkHKjndfEpqD0DpjsxgoKal1?=
 =?us-ascii?Q?ZUxYkAfJaLn4A9ips2ZzJfR+2IpwbZqOG5PtORGZTAU8CeDs7Qhr/5Sw8Shs?=
 =?us-ascii?Q?9AXTgpsb8L77DXKVv56xWcXxC2ryfuG5g8+35Ly7Gskx0xYFntf4/9a90qmN?=
 =?us-ascii?Q?Bx6VQyEVxtDyGTu0lyKZ4X0WYA3ANGMtzCsGkMkssVNNRJIoJa+AdIgsI9YS?=
 =?us-ascii?Q?Q49ipmIq+nB65OS91/1IJvPnuF0yXk3HOvb2vGE4NOfB1dkRErUYLYuSbDMH?=
 =?us-ascii?Q?gGI0Wu1E7FwI4zXSvXmKL7x+Mt+AJmLc0wbDdX/qFsfZlVrtNUvFMpfH31K4?=
 =?us-ascii?Q?XsDHlG804Bdr/Danajx33ZdLR7/OPbghWlVMaTBjmq1cQ29HisPe85d40vc9?=
 =?us-ascii?Q?7PpKSoekPQNGSjdsGf0UBRQi7czuJESmN0+LDCsjfxIHJuP6n3BwfFI3+V/m?=
 =?us-ascii?Q?uuttRudj8UQSZAiMWjm22/UD9OSZb1Awt3AP+KcIjqY4wwuJQFjlwLnqEIQV?=
 =?us-ascii?Q?0QJhyYyX+4HcU7ys2oqhdo3O/A+Cye9IJXF2QW13jelVtxVVkMo5R5fqHoCe?=
 =?us-ascii?Q?sBfgC5VccAu0FzbMSWxc7zdNyiS3PMmtPxzqZhKx6rvWHAzpc/C1zo6w2N0j?=
 =?us-ascii?Q?TysbcP6viNf1uP/CkqOKAjLjdOX5Drc2km9jPDQgMF8sYeJXcBi3G8xOESAg?=
 =?us-ascii?Q?CiwrQGnJvyQUwjSzYSkR8gvgSLLyW35NhG3WNYIni2Nb6zeRLF29sKHqrQOI?=
 =?us-ascii?Q?1onzV82VcfrPXwPk2l1Expn8NTBYsdo+G5sk5IO6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec2867e-9e35-485e-f659-08dac3d527a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 11:09:08.6228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HwbFUd0Lr8vrZi2vYFFel/807MbOsqrYDDMKvCuNmVCyFTG4a7/tPuXGgmmUXZoanYm5rPbQyBmGVShoM4LjrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6993
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

<...2nd part>

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, November 8, 2022 8:49 AM
> +
> +/* pfn_reader_user is just the pin_user_pages() path */
> +struct pfn_reader_user {
> +	struct page **upages;
> +	size_t upages_len;
> +	unsigned long upages_start;
> +	unsigned long upages_end;
> +	unsigned int gup_flags;
> +	int locked;

document what locked=3D=3D-1/0/1 means

> +/* This is the "modern"  and faster accounting method used by io_uring *=
/

double spaces before 'and'

> +/* Process a single span in the access_itree */

in all storages.
