Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AF962EBE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Nov 2022 03:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbiKRCYa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 21:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiKRCY3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 21:24:29 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB7318348;
        Thu, 17 Nov 2022 18:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668738268; x=1700274268;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=en3VoICR5M82P62XCBtHO2t2Ea2oHwbCTuHkuJXofAU=;
  b=h18RCCPS55N3g0lN3HMZEhFZzTsOSIYwC4+C3SFGWgf87qQnukVoOaqp
   97P2xsXIYfDCCHxN5Mg/vyLOVAB66GeO+rPIq8AMAcj9JRGfqwj8vzE1X
   eRUpmZ5r55RCjqY5T7N5GvuqBBbTJxVzSqZmQK3ClKGyXMsPvoJ+gGXdn
   rqIHAqzy2FF7Jhz7yVhEb2Jm2kIjty1MXhgHkt6yd6pSKwxfx2OsLq+2n
   v1pDiLzKPYCPNFtaFGBTWsbgaz+Nwndeh/ZGVmOFtKs0KDUEoek6Pvp7k
   2NiHUQJRS3LuglnMIMN92qPYnRizF/qbW4FFXCxYUZazFRdDfGSGQwDGX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="310663163"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="310663163"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 18:24:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="634274856"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="634274856"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 17 Nov 2022 18:24:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 18:24:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 18:24:25 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 17 Nov 2022 18:24:25 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 17 Nov 2022 18:24:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCYb2abZ1aGqlYrSCize4/Cq4xk3k+3OD46kapIXJA78qW6O8K8M51i1qKUUf+xz34VKw5m5t54OhIlWwx4NXyOWHljcJnA425QRIdzQiXJa/fb8cGG7JTET+0KqYfsor1UjWxRlPwrLpNbG2wGNYr7f7uT5OkJ6ST47NUFBiNGVxMt0GDRGiuOZdUik1nyF3HN/7qs9V5upnlUm9lh9YVcXhUKAGYYc8uYuc1l1apazMhhy7n3hfMUwnBXbSNvZQT/PjEtM8rCODGNFiKMsQqQPhVsEJPDN3PpmKtkFZHXdjdEt9VEAYh6j2zfBLsMl67QE50y8ubln8zKgr2GIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=touMk3fvGnjoB4TGPQ8BXM09YylRDp/PhCYw5kZu1bs=;
 b=bsOH6BrW/twIAG/PM2mRR+fQ9fXiH+W5Sm8n4VBgEPT5pF8AYu09uUmdDU/2RkUQEW5TlBascSvcstykKDqLeo6E6FWFJzQei0G4bLkrvA8eMHvXXgRtO6exuily1EniFA00smJvYMl/QC/z5VySgjSkQgdTNkFVFleA2WsekRZAXX99xe5WHbAhYB9p3MF3Z+QqbIcJwq1G0UnHtjb275t40NBtSOWXf9+TZrNduwzNVPkCLtdCTMWGrjiY3gk4Q+q0qGb6rH06g+9afu/5LEEkCOeubG/lVZTGr5LkWdJ2f2Yg892xJpsZNyWKTVFkPvNZGYy2KMEAtSPSgav6uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4599.namprd11.prod.outlook.com (2603:10b6:208:26d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 02:24:23 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::9929:858c:3d20:9489]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::9929:858c:3d20:9489%4]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 02:24:23 +0000
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
CC:     Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        "Jason Wang" <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jason Herne <jjherne@linux.ibm.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Yang, Lixiao" <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: RE: [PATCH v5 08/19] iommufd: PFN handling for iopt_pages
Thread-Topic: [PATCH v5 08/19] iommufd: PFN handling for iopt_pages
Thread-Index: AQHY+f+U4QXW8VD9aUSJAPUbFnRCH65D9MVA
Date:   Fri, 18 Nov 2022 02:24:23 +0000
Message-ID: <BN9PR11MB527690223B13E5B57AC6636C8C099@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <8-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
In-Reply-To: <8-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4599:EE_
x-ms-office365-filtering-correlation-id: 3aed31de-cee7-4334-127c-08dac90c01cc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nWF/lAWG8FNY3v69b3/DArlTk09OZYorNqXhLfw31xOxWAP0v4fDeRxB56aMNv8PxudGX7tknK7adhHZGPB2FhCOCvU9MZ9vbXePYxdiyVP6W+ERA3P4G1tCcfGcDPl8CC1IwGI4NQCArRffjUd39/IO6zAcMi89x8H9tMdOzgCcPcEtHDSshffMscDkEWqCi9juaogPAQSSEQ1GRLqG7aemej8NJ3DsiUE2rmMdrwjvSfsiFZpRQYiqgA+VX9d2lyb9cfzr0Bw193V5hNiiHGviYxB2zJ4hxCKKZY/wnnTgC1krAH0LXf427EIGJAzSOAGIwtHzAwuVJ6V5eM8JBURlveGpByFkOshhLrUO56ry+1FGjwuBTL0ldjKm/+5PU002kq+ZJST/kAjKRKBqvJTdvTJRv23vNTrqhutdPXhU0hIP4ZJMbfPiQe+adDSTO6LnLvyUKgfHO8+AIdsYf4HjYs0JfaEOP6xHojxLWtmKPrpF48s/y9gIdaufeYrfFrc92BSfG3EynIXv2Z8+wm/2D6baeH+YvY2y0qvjiVSIA7//0NbogN6HW10RV70gFxwUdwBCZkMSvX0x5T2HJ5wsL0KgUO12xbSyZTpSL3sIfrTQOlYM7g1ls6JQ9Q2K7YyUKWlPvqnIkG5/nO7N8DEjUViw6bcq8FH4bL88xj46MYI+9t9SkxhxdhDKstt7fzJXKoTqreLzbij6nw3Rw9gFZonjWI4UGZl2f7vOjok=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199015)(921005)(86362001)(41300700001)(33656002)(38100700002)(122000001)(82960400001)(38070700005)(71200400001)(186003)(478600001)(8936002)(8676002)(7696005)(26005)(66446008)(52536014)(55016003)(76116006)(66556008)(66476007)(64756008)(5660300002)(110136005)(316002)(9686003)(54906003)(66946007)(7416002)(7406005)(4744005)(6506007)(4326008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sIi8/MpVZakrUmAwzbr9OuWVHksRFSl+5xp977BWDV0DztCoGS/zY3henO1P?=
 =?us-ascii?Q?B5JACP/UcvD3jcp6skBqU0WJ2Jm/JzyxgLDmEZvdZHeS2WgnhA90oD7+4MyJ?=
 =?us-ascii?Q?KwJFzYiMofWY15UmJ1XoSPs/NlqdarNHktkto2m1J7tKzqgPbBnP8ZpBzI3J?=
 =?us-ascii?Q?CpQx+IXrOjCBP3rCnfaKcwjBq2hsMzWP+zyRrs8VhpcEhgWiwcY7Wu5XBcJC?=
 =?us-ascii?Q?zSwXjLGV9kqZTZZJH9fbp9bHUElB2+GqiR6jKLa8JvfYmEC0+PWesRiCpDkF?=
 =?us-ascii?Q?hE2f0nyLYf9bj9yD1MGk7E7A3usd5fvxGf37GbA/UfjjlwgIp8Qt3jYfd7oQ?=
 =?us-ascii?Q?rpgv5gmttb3UoRj9ZweG2ZW2Jh2yJthMO8SiBzokIxoz5boY11YgnHzRnEjc?=
 =?us-ascii?Q?uZHhsYrpHG1AuwKS0y0wgd1gPljhBC7adoQ/eBvoFfUf801Es43EIStrnO1n?=
 =?us-ascii?Q?ZNwwZ6kgMPNDbVx8+ZaXO6KG8V2s/uM0LftIOxRpwwuqgTAtcOlHkJ6ZdMUp?=
 =?us-ascii?Q?mj7zALlDr/7KQVfUIMyqNB011mmnUpif/m7GsAbwadHxJurajFRO0iPJRZDx?=
 =?us-ascii?Q?8m2yST2e3AibWaAMrEDdztyEasgCFredsg0jdBQHIn4MILdzxXg8Acm7sI0D?=
 =?us-ascii?Q?xjcDC/ese9mlAfX6T5pK7p2HQxfObcW0hw6j/edQQaGDj20GtAm/cbPR8D2t?=
 =?us-ascii?Q?UDHI0l1gdeLJb9/GsRI/W5tYOaV85hQ0HIsKNMqPn85XCHnZD1kXSYJjEIrT?=
 =?us-ascii?Q?qM+PWPXc0EBo2OHTySz2hZSFdHdIc3WVtS6hsMZf93CCPiSjPgyBdMrQjNyn?=
 =?us-ascii?Q?mGOn9cojWqPlkUpfeYK79aClX8JTNHxsbeFtIjVXCj2vvYUfKbKUhrGpznDO?=
 =?us-ascii?Q?jtO0ERBHWmb4h9NYUKWXp0nNHeEtqSYF9z6lDenpIZCoORybJDlxpMhp/iMr?=
 =?us-ascii?Q?e4nqKGzRUT2XzaBZvZT04zegeU4GUo99C82HqaAT1XqU4CD5QGhbrCMa3jRm?=
 =?us-ascii?Q?UOZTqFLeJm7jVZbRU+l3dOJHfuA8ICkkpbZ2pP1PYyIdIhDTreUFfpHMEFu/?=
 =?us-ascii?Q?Lg5f+Fb7dtCmuqfwHapR5VBskjso+06/epFhQ/4xW5XTjRQ1VrBacS9vxtrF?=
 =?us-ascii?Q?ysPdc7FDF5Ne4VrksnVYQFFW/7nJIbo7LvNip6wjM9SU4u8xHjnIqAIUaWtb?=
 =?us-ascii?Q?tdFSKzT++Wci0EvzSf4U+/DDnKXTQXLdSoYomFYU+PpDHdmjwc0eGafVwyAZ?=
 =?us-ascii?Q?OyRJZoT+Hh9tDq2FWTApXWifH+8xTKKCbfs7QFL+d5vKJxTS/1UN8iUE94k6?=
 =?us-ascii?Q?jtFh09eWU3R9SzXqa4JzlPDQW08YRYMTx/IIDyCN0WSCFoFS1yd+rdh4TIEp?=
 =?us-ascii?Q?mPgQybbemlxC5Qrk6QJe8rp12r65PhRIt5579zfzhcyj5n8/mrOkFu9ESsPN?=
 =?us-ascii?Q?ODVSsgSLxEgcNly1gcZVgnLIrtoFdI0dzRphazNUlmWJHm39F8pJvPBgBqmR?=
 =?us-ascii?Q?wOJupdbUCSQ9ogVmhlYbyja4b01+uE9RzQu7SqvmAshBOaPzrgX9Bwk8wZFM?=
 =?us-ascii?Q?qkHA5mtbL8QpBggPZpooAMUi09QNKwpSd5jwZfF2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aed31de-cee7-4334-127c-08dac90c01cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 02:24:23.2663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o3DRhwFZSV7tc+HpMcXBDRa8G84RNVDHDlt4yAeVxuhCeldUNDuuuS4abDOeL5jIRt+stZrF8pymQKEH9DdpqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4599
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
> Sent: Thursday, November 17, 2022 5:01 AM
> +static void batch_skip_carry(struct pfn_batch *batch, unsigned int skip_=
pfns)
> +{
> +	if (!batch->total_pfns)
> +		return;
> +	skip_pfns =3D min(batch->total_pfns, skip_pfns);
> +	batch->pfns[0] +=3D skip_pfns;
> +	batch->npfns[0] -=3D skip_pfns;
> +	batch->total_pfns -=3D skip_pfns;
> +}

You forgot to add the assertion which you replied to v4:

@@ -239,6 +239,8 @@ static void batch_skip_carry(struct pfn_batch *batch, u=
nsigned int skip_pfns)
 {
        if (!batch->total_pfns)
                return;
+       if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+               WARN_ON(batch->total_pfns !=3D batch->npfns[0]);
        skip_pfns =3D min(batch->total_pfns, skip_pfns);

otherwise looks good to me:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
