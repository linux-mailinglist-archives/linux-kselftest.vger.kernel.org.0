Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA76A62765C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Nov 2022 08:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbiKNH24 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 02:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbiKNH2z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 02:28:55 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DF110BD;
        Sun, 13 Nov 2022 23:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668410934; x=1699946934;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rQEp1DYTfk0/sNmYgNtgXJRPsmI5L3klH0NR3PgKyDA=;
  b=m+8ffcq2yXbFEpNO782BU3CveuiiBceCT4DGl6Gfi5K5JS9DG/ERUlpu
   or2rUZKPGZ9tXs8lkTheKy1iYpwIicNxYzqGeQdCtT3vlcupv+JDszqio
   cvUhklEXBM5JE7gIzIRz2ROcE2dzEsb8XayraS3rMSnS/r1YM76xFL6nE
   plYfTcM8OJjXlgCZE+2PJca4pR9kkftDNOXf7cLJiE9ghUEiFOAUEO4JE
   B3rSUsQ7O+aUlYDtp9M5z79gvHOfMW49B7h1GBue02Q3FP+GSXXWsPYR7
   U04TZu4y2CmAePgSSWvAlFlogK3yb03xTNDo1qT/qw7zy9UPjt9VxGkHA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="311907660"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="311907660"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 23:28:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="671454469"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="671454469"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 13 Nov 2022 23:28:50 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 13 Nov 2022 23:28:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 13 Nov 2022 23:28:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 13 Nov 2022 23:28:49 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 13 Nov 2022 23:28:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvL1f+7OafidvZtAhfhIdU5So71L2E8rvKYnhWKh9lLTAMkM8KG4WQual8JVk7nEa2uUBbEbBkY7GUBquFXXoVM6daFygT2n3VZMoe5MSbsU5IzWSVAx0XxdO0I0pckHyaph6jNcr3L2ariWHqcWYGQ6ZjxOXDIjs548YNCGQMBFa6Vo/5LZ5lneWWQ5T1nADWHHWGGpFQSm0jcx9FR8IND8IbeKX/CSX9VLtzK1TSnaPS2yWd1f/YC1h6VBtPO2OCoP4p1a/8AulFKHB00AwlG+dJeTdY4NXKnxf7rX+TnMgznQgOpRV7jP08MRmX1OAvWeT4kdTiWCG6+DNQy3cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PL/Gopc4d01NEw/hqk8JQzHDgIIbMgtnu2zV+Xkd6GM=;
 b=kWhfXCX2n5Rgjw194USqjKDwdRsMh6SXAZp9PHx0dw99greDWraPtMyehy1j0k3EInz+Jht8nASkYfDf88WEYfkryOG96rV7LUVC7itpja35RKK+8PYGXXtGOoORzOfg5cYRf+UIBUNtxp53S1Gv0XHzSfgkvHswxdVVUX4i4ih7iHZ87g6d4OPGVKmT8SPRQ2cg/ypSFh98OQ8bwkvrH+ihLXw0gUquPZLxjVMwoopQdY2r8Bf/ROIf40zW6F/TQAXbco+ZFMlPauBJ2sYzbGM6oDUVXYU8EDzZgPWWfXtiUm7AVwxfvdYx4pELezcdmQAYbpR9VBZ5+aM/rMOAfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM8PR11MB5640.namprd11.prod.outlook.com (2603:10b6:8:3f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 07:28:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 07:28:47 +0000
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
Subject: RE: [PATCH v4 09/17] iommufd: Data structure to provide IOVA to PFN
 mapping
Thread-Topic: [PATCH v4 09/17] iommufd: Data structure to provide IOVA to PFN
 mapping
Thread-Index: AQHY8wv9weOL8WzpqkSvohFTeBt9pK499F6Q
Date:   Mon, 14 Nov 2022 07:28:47 +0000
Message-ID: <BN9PR11MB527638FCF4A1351DBA1A644E8C059@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <9-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
In-Reply-To: <9-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM8PR11MB5640:EE_
x-ms-office365-filtering-correlation-id: 01dc334a-8bba-4db2-33c8-08dac611de95
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qwz8ySOde8t+mjPLQTR2QR1mAvLrlEFJSNTDwEU90ekt8l3OLAvsjgxrEQDqeCQB3l5zPL57KqtWA/wLfghfu1BUWZFQvV/usskEBWay5E+pIx6YEwlQvW7PzYtnzhSxXBXN3VHgFggDWJA+apC1gGKCNuyuoElqWlcwY3TV1tShIjqO/SMNMUtwFA1sYbiDdwWht9+Yq7iVVmDDVYcFuQ8nS6zraq9Y9CBhpAPw7pBhKpuoadjZCPdnXOgvDfCopO4ZfBKsS8grlaS+FUMvIj9JY0Y8OXXWLGXn0XZl/QNij3M4jefZTXDTfJB+eAFHEa71mmvM16FgINC3bsLALRRsEzhZchleycegN+a0OMgRjTWJogjDpMOYS7XXiEcFdyH7OpyjiiScnlsk5D5wF8sknaTpT/tWaPNCow3RErcEqfrbUvgTGq9VXxrMQU2YYe9drcX3utQjb16IS7EZBHSotxLs3RVN9zUpt9e7fXu5B21++g9d6A1E6VeY+uzAWg4KjTO37DKGdGrcBkHsGy62xIeoDU9U7eZuZi6FVxcufPHEKtRw03N1i+sNlZdyx9ifHgKF4vE84AqcL6Bhi96IdkyylkoePnQWWYsHSeBOJ9xc4jMWeZMUWW0fC+kV4RWr2ew+vvF70JRtOsq9URpvI8KwtRehGBwIWzD88fxLzkMUWgTapQ/b7wrnpTHTdv5sA4ZJHFGSvvr8NCHU27Q49Oo7Zn/NjOhJQziNjhSG57aKUZsHqnofFtY6ok25+Z9q+1KL0FHeLW5/X2YVt6TZTBeizknF0FJwdXNaHDk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199015)(41300700001)(7416002)(7406005)(5660300002)(86362001)(8936002)(52536014)(33656002)(2906002)(122000001)(186003)(9686003)(82960400001)(38100700002)(26005)(83380400001)(316002)(110136005)(54906003)(66556008)(4326008)(8676002)(64756008)(66446008)(66476007)(66946007)(76116006)(6506007)(38070700005)(7696005)(921005)(478600001)(71200400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ltObIQKrjQlBDFN2yJ+9OswkwgDHyvSdKulux6X7VlAy+j118tVvX+DX+tf9?=
 =?us-ascii?Q?Jy992pvd6LM1YGTckHcOI90toiIVltpzli9O4vwSk8SeYi/NO3F3IDcZlACd?=
 =?us-ascii?Q?6Ec4LXdxgttW5jPIsF2Lqojy36onJhAHDlR7ClBJ8diqjKljZzBfaZveHVZb?=
 =?us-ascii?Q?SIqpnqE47giOq6e84clETFAyPk2J8T8tycZSVy3WJ+2w2c7k+VtjxYeJ3aSY?=
 =?us-ascii?Q?bwaJID0SeJTxUN0V1dE13lGYFuXr0UNWyREClPyf+6dKMKFzXdIstrY3WXHW?=
 =?us-ascii?Q?FhtVaYv6sQCUlxjsaKe9b2WCUHt2K0nEONbn1WXDyV3NXBbM5nzuvG8T9ZHK?=
 =?us-ascii?Q?kNxVqJTaiL8B5XxzBC7jBCfL/My+3oj8xz4zqHzSuLGlIN1ne2i8cSkyJHgD?=
 =?us-ascii?Q?astaZ8wVQ3izFcwALF0lc2KFErmqCqITsMX7Ow1Xf1UNqVTnN2LkDIH4ah8p?=
 =?us-ascii?Q?bJl5jmtIVUsiEKbUDXuuOdB7rUWCLMuTTkhGxUZJijtYFZHBj/iUkWT+6SX7?=
 =?us-ascii?Q?PUOi1NvxvOrpQtxEFdG008j/6qMmuDUIRs0cKgKkENHeVaUfw4Bid1yAqL6i?=
 =?us-ascii?Q?1sIcP6D3fqJHv3EwZbKGeusyGQQZLgWei8UpGTmq/jpjjJogmzKNI8xqQXaL?=
 =?us-ascii?Q?VNds6SwLNdVMl5EuKUadJpPfluOfSkrWqo8QDilcDUkqguuiGiZ++m8Ka73f?=
 =?us-ascii?Q?PAMy3WNOb7X3JC2/XsG6I141BJt+qpc7J6smDL20dwSMttuYZ42VxQfuRa2w?=
 =?us-ascii?Q?TglRdiD7ARuJA1nX9uhBaEAF87ef7b2QZjkwG8LBlG0JQCK9Ijn401GqCTg5?=
 =?us-ascii?Q?zvd8aLbM2S1PPMLY1FkKaRJNReiRH5MFQ1Ze9Pl/7xwpwKc9sS2oROzk8UTB?=
 =?us-ascii?Q?LPysnNtsjMNxRmXMkKPZgLJkpKRTNJsQ0+uRXZVQ4QUZgHnIpD2BuGkl8mV/?=
 =?us-ascii?Q?TwOAKQMDqKbnCqYdnkaZHN36kaa6Gfx73DzpuzbJJFD0BeFO7ra6B0u6C1jI?=
 =?us-ascii?Q?fB8MrX8dhkOZLHUsNcBreGGTcRvd3rDdr8ycfHx9N8kED0Cidb5gT2eh2uMu?=
 =?us-ascii?Q?gvL66YvIB2t/nPIQrXT6ZHmpJFHsZTyJfPuut149Ge02dCAk9/Ejxbgf93tc?=
 =?us-ascii?Q?3G8zk/kpkMUks4dH0jUcAzREkiaKkIZnEjT1wFDr0QF22wl4w3jUouNkzTYa?=
 =?us-ascii?Q?Q/ZDp2d8QwltHoAjKK24YBD+iduHzK/Lzk2/PwYJz+7BAcw8M+KN3waUTTCt?=
 =?us-ascii?Q?qCZLEIKex8g/NjNwIkQCQt9hyN3lYdxCWyXhVLOYezy8NAZKF58rTW23EYjS?=
 =?us-ascii?Q?YXVBP+lRBfYNI5UWsgUUNbFeYB/vxv5lq82Tq/9QamHotvoEvmrLxHRCzzEG?=
 =?us-ascii?Q?FeOEd+/cPLrv6/NuSfLxu2w0YJbh3ltvE5mlUxd782lQ+pNlrA3fnS96aQfa?=
 =?us-ascii?Q?P+GFMEuMHiV5E2BlbWIdzKKAa8++bCzsFI/4MkkYTYctbpCAarcF8/98pjYK?=
 =?us-ascii?Q?FHh8Z9lhNpbfuMNV1W1u8MdEN9o3fZu7O81p0UfjfNa6XWJx4imAVzHgYNOe?=
 =?us-ascii?Q?ifoiE1kGVJ+r1DdH82C550lozbiZYGw+DY9CbrNV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01dc334a-8bba-4db2-33c8-08dac611de95
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 07:28:47.7254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NPEpJix8HTMMcw5ECp+Mq9WDbl3J1sYXoiRU0tfcmoVtQb8JSuk79j0poXk09ePeJwb2u2SfmXP7he5HCoJbYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5640
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
> +/*
> + * Automatically find a block of IOVA that is not being used and not res=
erved.
> + * Does not return a 0 IOVA even if it is valid.

what is the problem with 0? should this be documented in uAPI?

> +	interval_tree_for_each_span(&allowed_span, &iopt->allowed_itree,
> +				    PAGE_SIZE, ULONG_MAX - PAGE_SIZE) {
> +		if (RB_EMPTY_ROOT(&iopt->allowed_itree.rb_root)) {
> +			allowed_span.start_used =3D PAGE_SIZE;
> +			allowed_span.last_used =3D ULONG_MAX - PAGE_SIZE;
> +			allowed_span.is_hole =3D false;
> +		}

statically initialize it when iopt is created?

> +
> +		if (!__alloc_iova_check_used(&allowed_span, length,
> +					     iova_alignment, page_offset))
> +			continue;
> +
> +		interval_tree_for_each_span(&area_span, &iopt->area_itree,
> +					    allowed_span.start_used,
> +					    allowed_span.last_used) {
> +			if (!__alloc_iova_check_hole(&area_span, length,
> +						     iova_alignment,
> +						     page_offset))
> +				continue;
> +
> +			interval_tree_for_each_span(&reserved_span,
> +						    &iopt->reserved_itree,
> +						    area_span.start_used,
> +						    area_span.last_used) {
> +				if (!__alloc_iova_check_hole(
> +					    &reserved_span, length,
> +					    iova_alignment, page_offset))
> +					continue;

this could be simplified by double span.

> +static int iopt_check_iova(struct io_pagetable *iopt, unsigned long iova=
,
> +			   unsigned long length)
> +{
> +	unsigned long last;
> +
> +	lockdep_assert_held(&iopt->iova_rwsem);
> +
> +	if ((iova & (iopt->iova_alignment - 1)))
> +		return -EINVAL;
> +
> +	if (check_add_overflow(iova, length - 1, &last))
> +		return -EOVERFLOW;
> +
> +	/* No reserved IOVA intersects the range */
> +	if (iopt_reserved_iter_first(iopt, iova, last))
> +		return -ENOENT;

vfio type1 returns -EINVAL

> +
> +	/* Check that there is not already a mapping in the range */
> +	if (iopt_area_iter_first(iopt, iova, last))
> +		return -EADDRINUSE;

vfio type1 returns -EEXIST

> +static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned lon=
g
> start,
> +				 unsigned long end, unsigned long

s/end/last/

> +int iopt_unmap_iova(struct io_pagetable *iopt, unsigned long iova,
> +		    unsigned long length, unsigned long *unmapped)
> +{
> +	unsigned long iova_end;

s/iova_end/iova_last/

> +static int iopt_calculate_iova_alignment(struct io_pagetable *iopt)
> +{
> +	unsigned long new_iova_alignment;
> +	struct iommufd_access *access;
> +	struct iommu_domain *domain;
> +	unsigned long index;
> +
> +	lockdep_assert_held_write(&iopt->iova_rwsem);
> +	lockdep_assert_held(&iopt->domains_rwsem);
> +
> +	if (iopt->disable_large_pages)
> +		new_iova_alignment =3D PAGE_SIZE;
> +	else
> +		new_iova_alignment =3D 1;

I didn't understand why we start searching alignment from a
smaller value when large pages is enabled. what is the
connection here?

> +	interval_tree_remove(&area->node, &iopt->area_itree);
> +	rc =3D iopt_insert_area(iopt, lhs, area->pages, start_iova,
> +			      iopt_area_start_byte(area, start_iova),
> +			      (new_start - 1) - start_iova + 1,
> +			      area->iommu_prot);
> +	if (WARN_ON(rc))
> +		goto err_insert;
> +
> +	rc =3D iopt_insert_area(iopt, rhs, area->pages, new_start,
> +			      iopt_area_start_byte(area, new_start),
> +			      last_iova - new_start + 1, area->iommu_prot);
> +	if (WARN_ON(rc))
> +		goto err_remove_lhs;
> +
> +	lhs->storage_domain =3D area->storage_domain;
> +	lhs->num_accesses =3D area->num_accesses;
> +	lhs->pages =3D area->pages;
> +	rhs->storage_domain =3D area->storage_domain;
> +	rhs->num_accesses =3D area->num_accesses;

if an access only spans one side, is it correct to have both split sides
keep the access number?
