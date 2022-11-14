Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE40D6275AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Nov 2022 06:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbiKNFvH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 00:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbiKNFvF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 00:51:05 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFCE167CC;
        Sun, 13 Nov 2022 21:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668405063; x=1699941063;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6Hq7jYuGqiNwVDANDDwBPNw48vRy1kwsrbuZ2KxrNwQ=;
  b=nGdHeJL8rV2W24F+3xSSHh6P+vcgqQZ2C9CpBELGb2WyumjY7pPNO8Fq
   e9tFID3Axxr9Vx8XcFoEC40PxE516avuhlZEVC/pzfmRFnP9bwgHvMpw7
   pCC/U0y6/WMiK+R3S91RXjC3HyKtE592Qw27ajdtu+plrT/DNhnvDcmqY
   6M4Upb5LVew2/9FUgZSSg0xO/ba64rW2GQWOTJSVghBFBEd/tw7+OwQBb
   OlSh4WF5KlkNJW2r/xYrcPIH2KuKHlTzGFWLt8T8k2I7qML+u9JFJdeVE
   gH9FJd3KVxhmZ56RKt/oYMtN5dZKVulStCPynkvlGqMMeGD1NYHZUbLRA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="313036116"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="313036116"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 21:51:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="638340118"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="638340118"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 13 Nov 2022 21:51:02 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 13 Nov 2022 21:51:02 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 13 Nov 2022 21:51:01 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 13 Nov 2022 21:51:01 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 13 Nov 2022 21:51:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxNwYQt83jI4OsuODpM4ACulcRs7bLIQzmjM7939NwplsB30YiVGXDjiJAmVgcOhuyFyjhlf1NsgonjYbsfYo0uFe0yWFn/pjPjJF9oAgiOH8KHN555C+pWKbiHQzv4Jxtigf2FY+KF9c7jGLiQjyM8XZ1g7dCh9nAjy74icpc2du4Kki/k+xs3IRcjreScGQscSlY3cUw+Z0UbF/6pZXEOMniKShY11UTQ8oCfQtmqDBRKy7WfcnunvEdJ/Fw4VoZF93HkloR91MhV0rjSgaGldNY9gRBGkmzSG8QKPmuJajUR0xaoJ/FyhJBKVfE3ISIeG5mhmY4UJczzJ+z7V+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtdh97mv9LtKUeuIAJ9rgoMOahPLkz4M3BfZGSDb8SM=;
 b=THQzTHvAOztO+XWl0w5ynrpvouFW0OgrpYkwT1ZPtbD0s0YZUielqlkNbYuRbyRsBfVakRuviRPlIG7PchRJ2SAITIcTFCSSy6faOHxWnweWMr1HKyg0zM+zx5pO/cf/NHtUIAXG+DlAN3XlltTVxfWIc+oOOlCa6Cs9fRCOn/3W6EOWk21YBCB/E8MJA3aSoylRcxDV71Hrda8AFHYrl05Q8F+OcJrlq4yNTWxZqBSwyM4qQWa5T81Wc2RrHxEVeMYb2V3NYhmVd5AnNmprCtwvWmATuXELso/v/tiWK4/k3fD28zv1IyCinwgntbMOJxhMUtYsywqyVN/GFqwh4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4663.namprd11.prod.outlook.com (2603:10b6:208:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 05:50:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 05:50:50 +0000
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
Subject: RE: [PATCH v4 08/17] iommufd: Algorithms for PFN storage
Thread-Topic: [PATCH v4 08/17] iommufd: Algorithms for PFN storage
Thread-Index: AQHY8wv0HC8jKTqbBk2RHRrOWTCfU649tSKQ
Date:   Mon, 14 Nov 2022 05:50:50 +0000
Message-ID: <BN9PR11MB52762E5ACAAE7D7B398730D78C059@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <8-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
In-Reply-To: <8-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4663:EE_
x-ms-office365-filtering-correlation-id: ee56fdb5-648e-45d9-3781-08dac6042f7e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cQ2HPZ+xvavLBJjEmOkYlmRyfxYa8Et3d78lPmUCRNBGcVGFAQmilyFWdfjMtQahH7qprcUwYE40i0P5ROOX8NTBURv2/KjCHIwN6C2wPxdikZXRBgGZWJmdYc/L1DmpkDbXmgzSBqNdI6vGWkvOwqJDZzoYrIGYTWF19l210bhKnJeaQDIhEIlGEehh/xh+35JlY34o8arsf+MA+5QdVwadqATcgbPk4nGfl7dlspaaiaZbbwCDPQCbVsgHDfplIaAFXElevmasQXKVvvtkLiual9hxxc4fx6K8x78KXGwZhCCRTxWGddinVJt1k9U55uEr26byXS1GlSq66dtaTREbGs4nmcGPT7DsyJFZrFb36aGQwiZuKP64gtOlo86PU5k1e5iZ+eOqq7nbJu9ddBnfvlgZKKXPb9Hzmoyd0wDBs9WBgzNu0j4Va2GGbCMZZKKRnItiY6qw7wPjMcinCiBlUrSKmWe26ONqWgdFBrSYCl/+anpHdk2+WPVaSd/3Rc6T8blI/w8hXOBOgBnqCNUTdEPS5U07gym6N9dYAl6nNbfeJGj4CNe8XTEhgVYAkF0SxK4cSHyHfdncBhECaSlY96eaHVobpBEVr4rXCVfRFfG9CUvqF6tZGd0hHftUkmmF7wcSWpEJZ4fMwodeat7RUiBvosChHjQ1Uv4ev5D7WpXKU2QF5BgnSt2M+zQ5EYZZLHM9/+R+KVxIdQizRHOPw8XRRilIhc54I/tq/ElUd5Er76E4t3mMaH7OghAXr31P9nBCTqbNX96gouXgigBY75SWnjW7bc18WZtxOYfOsTMUZiB66bcMNYpwf5/X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199015)(2906002)(66899015)(38100700002)(66446008)(64756008)(66476007)(66556008)(66946007)(8936002)(76116006)(5660300002)(7416002)(7406005)(83380400001)(4326008)(8676002)(54906003)(82960400001)(122000001)(52536014)(110136005)(33656002)(316002)(41300700001)(921005)(86362001)(478600001)(71200400001)(55016003)(6506007)(38070700005)(186003)(26005)(9686003)(7696005)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zVvOZaq/1ecPms+j4Ho91RHVDrR1vGfTGr9Lg7fDHyAT34eyxTIsGpZCnJWK?=
 =?us-ascii?Q?mfQc41NCMP46oQYEj5i95vCsDMlUOLb1GGnJPdze89X6D/fixcKZd/lL6vlO?=
 =?us-ascii?Q?r4On/qz6err4EeIXu9HNBlnmxTrHQCWA3nWsPAoGnpq0AxC8tL1tBrDaRFqR?=
 =?us-ascii?Q?+qFOB7RNKRDY+mF9PB70zVkJKUPNC2dVWqfog09+6yt2Y1WLHY9PBHiB9fhl?=
 =?us-ascii?Q?2GU7ZPb6SwEjwiTWfBXTu+uFjuRmLFZNeF5vuBCO78MRx1v+EtuOYtf95bCH?=
 =?us-ascii?Q?olEznG0UXj49VN6TksiPFVuGNjlLl4XRdCUaPqUSpO+MEl9PpIkWymR9MvTV?=
 =?us-ascii?Q?V2rDdp2zg5CWm46+7kq1c0u5gA9PUqC2kFfkq9vL8XZcq3om4b865Lf5PJvO?=
 =?us-ascii?Q?bVs89fa8S+Bc4/9h4bCbMwyDonbvZvf125HiehoAz70GedF0ANpiDWsXNAGW?=
 =?us-ascii?Q?YSRWF8QWy8+FB6iXSwT7cOVJqby28OJfd19QID+fT1RHRI33XupLbD7zOSgs?=
 =?us-ascii?Q?4XZHkwC5Fyt7IeOKW1+q28NrzHtxPhi+xSKRG0OYCgPd11OyDm12fpa0j3Ls?=
 =?us-ascii?Q?6zFrAt2HZRZOD7pZlna+vNKNY1NpybGcEC95QBGrfgaxCbXl3HHn7fsoDF56?=
 =?us-ascii?Q?BMUlrn5cQCp+x1u14g/s2TgK1MLnD/U9oI1I/4fHdl0J8ZxPPo6NKFtmAkT7?=
 =?us-ascii?Q?Z11kM0fKu8ZSePLAG0GjsuGbDtsBIMzwZIN8VBX6htldb9SGnuFc8fPQyA8j?=
 =?us-ascii?Q?HujjA+WifwEWAspzxMHI9bq4LApCkyI8s+v/AUhZarij4Kt21DBbqbBz5HYC?=
 =?us-ascii?Q?vbPjTuYp0ivs9YKBa0BKw5yeVDr0hqWQwaf7k2gomXT9XsPvMsr4biTaTA79?=
 =?us-ascii?Q?WDgPJ14eB29qZuExr2c2J83d3oi7Kv709iNkkh1+z76FNHTczQSzDVF4bzle?=
 =?us-ascii?Q?INhCsXkzvc2W2O2Trw7Wmd9aRXnFVwu40wmhgDOjiqbNNBm8yfEN05scd3OR?=
 =?us-ascii?Q?FhpA7uamuMC0UmN6tObn6XjHpFQzx4qMT2r3SOkzkKut2V1dkcmdH6TPNj9g?=
 =?us-ascii?Q?oTG2rS7xnozCGMuyQlUQPNggCdnviCXvU/104BcCq06+94pExdBjvu2kysAW?=
 =?us-ascii?Q?aTKZwdci1fdmVucUrUAwjUIBg12Emr10OdXxe7I0CX7d98Qx53dsI48QrHTk?=
 =?us-ascii?Q?j6yTOstHBpfwBffxe9l2ai+Fy9FWVpzGZf+F9vUUnK5Ct81G9sb6xqDXd7MW?=
 =?us-ascii?Q?3z6eJ4FvU1Kv0TEux6ymn4SQgTGbpPMVXTHmbsSZL47ovgCiitTYLu5dpkSG?=
 =?us-ascii?Q?cQbiZ9Q/2cB6IyO4R1rmLHUS5rCTtG0OSF9j7imd6zhh4JLqUxVsRmiyBUyl?=
 =?us-ascii?Q?ytDD1XyIryux1vFbSEaRZj+eSRY1sDQqMKsWGDyFY8tQcODApudNwxo8VmEf?=
 =?us-ascii?Q?JQaP2l27xWqhrjgaJuBdZ8TMT+S0neQOMZetkYKaediDkXLd55pknGZA0TB/?=
 =?us-ascii?Q?55cLo6yvieMB6p6dsZrf0Vdm7dymr3eFfTDukn6awKzFUN5Q2auv7tz8AmJ1?=
 =?us-ascii?Q?fbrKKh9t4jw4SESxEGIZ0voKBQDK9wq1JV0VLXcx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee56fdb5-648e-45d9-3781-08dac6042f7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 05:50:50.4691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x2uoqbMG+96U+OYU6C50i1lxSyC2YtOPvP3BJj+G5jIPwRcHoF0qAoHa4EpxtppyLXptbKWE4wk2QokiSuhIjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4663
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, November 8, 2022 8:49 AM
>=20
> @@ -171,7 +183,7 @@ static struct iopt_area
> *iopt_pages_find_domain_area(struct iopt_pages *pages,
>   */
>  struct pfn_batch {
>  	unsigned long *pfns;
> -	u16 *npfns;
> +	u32 *npfns;

why not making it u32 and removing later FIXME directly in patch7?

>  static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
>  {
> -	/* FIXME: U16 is too small */
> +	const unsigned int MAX_NPFNS =3D type_max(typeof(*batch->npfns));

use lowercase i.e. max_npfns.

> +static void __iopt_area_unfill_domain(struct iopt_area *area,
> +				      struct iopt_pages *pages,
> +				      struct iommu_domain *domain,
> +				      unsigned long last_index)
> +{
> +	struct interval_tree_double_span_iter span;
> +	unsigned long start_index =3D iopt_area_index(area);
> +	unsigned long unmapped_end_index =3D start_index;
> +	u64 backup[BATCH_BACKUP_SIZE];
> +	struct pfn_batch batch;
> +
> +	lockdep_assert_held(&pages->mutex);
> +
> +	batch_init_backup(&batch, last_index + 1, backup, sizeof(backup));
> +	interval_tree_for_each_double_span(&span, &pages-
> >domains_itree,
> +					   &pages->access_itree, start_index,
> +					   last_index) {
> +		if (span.is_used) {
> +			batch_skip_carry(&batch,
> +					 span.last_used - span.start_used + 1);
> +			continue;
> +		}
> +		iopt_area_unpin_domain(&batch, area, pages, domain,
> +				       span.start_hole, span.last_hole,
> +				       &unmapped_end_index, last_index);
> +	}
> +	if (unmapped_end_index !=3D last_index + 1)
> +		iopt_area_unmap_domain_range(area, domain,
> unmapped_end_index,
> +					     last_index);

a comment marking that it's for the last trailing used span of which
the pages are not contiguous to previous span.

btw it is not easy to understand how this func plus unpin_domain()
actually work. more comments are welcomed to help readability.

> +/*
> + * This can do everything and is fully coherent with what a iommu_domain
> would
> + * see.
> + */
> +static int iopt_pages_rw_slow(struct iopt_pages *pages,

Can you elaborate what guarantees coherency in this function and how it
becomes different in other rw variations?

 +/**
> + * iopt_pages_remove_access() - Release an in-kernel access for PFNs
> + * @area: The source of PFNs
> + * @start_index: First page index
> + * @last_index: Inclusive last page index
> + *
> + * Undo iopt_pages_add_access() and unpin the pages if necessary. The
> caller
> + * must stop using the PFNs before calling this.
> + */
> +void iopt_pages_remove_access(struct iopt_area *area, unsigned long
> start_index,
> +			      unsigned long last_index)

this is called iopt_pages_xxx() but the first parameter is iopt_area.

also it's not balanced with iopt_pages_add_access() which requires the
caller to hold pages->mutex and populate area->num_accesses.
