Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0334617630
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 06:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiKCFbX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 01:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKCFbW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 01:31:22 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DE0BC2;
        Wed,  2 Nov 2022 22:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667453481; x=1698989481;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uLKfKb2vG9WeBo77d94cCUuf9HzF2ZIorvpt8M6u1sY=;
  b=elE7/cM/BpcNdyHjh2TK6dfih3p+4X4E0CRzhXqpm771aAE50A3+n0y7
   fHhoigOxVu1v7ealEekSCrMFz5ZH+JO7PTehTeJ1CnODEe/dlq+Dhzn0Z
   RTjBTPhSf4XzMNDNa/11bQrkvjJjuELEETxCKhG9XYL40MX92F4oqVqzl
   YvzUBpMJomAl0ZWXb0VB6HBLMWVyoa2yJrrNQ05ifpUjnEwgT4IP04RED
   NEqCcoNTA+Z0H11iXibZjHIDq1jwZGoYEWtR+GYgbI9R8ZT1I9bxq6YbR
   NHcuAT6LRepyEvA3kTEtVxx7j34/LK0ZaFdJzzGD9WaA6cci1GjI43gav
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="308309169"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="308309169"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 22:31:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="963804245"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="963804245"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 02 Nov 2022 22:31:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 22:31:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 2 Nov 2022 22:31:19 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 2 Nov 2022 22:31:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMZ5b+lm+9sBGmCYMUrYV8DyI/R98Wxoc8deF/gOjKooUmpq1wYiHCOuNVMU9jgvm2FE2uOoYABW2qpmj/pfyWjhaq0Tg+E8eh2/nxfUx2KHs6LA7EqVqFbiNsKvMvQWw4t3cMWtEaPmwD7glKQSH7JQ2B4ifjCUyo2TE6Qxk1aGah2VCqjZRyHAxmtuf49+s4RPQeOhoOfqPEG4GIzaDxwQxAJHkmb1SdzkXHWCW7qeBMvhXq2gGV4BqyMCEKbOuyJAmWV1rZQHkSseyfK5V52EkN5+Ic1r3wI9sA1MjnCkOrJdxHBkZw8UWPONwJjq1/IBqW25kFUn1/9HKjntqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0x7DYIMzJdTaH4kWmpb03ttwusognvDOusSCT/tu0cM=;
 b=e/7d9/GANT1dR4fRKU6yKwJtnp9EUSKlekAeBfbdiJzfDvOScYIK2eyolOH2XF3D6yZoBfqAB0kTpU6crt25aHD4GZ+QBnlwbKdeWLPSQD7AUFsyM1USIrE3aD0XWfotwg/aDFfNld8rHa8WJVZzDEtCkldlDbQ2670/r6w55dsrN/d1lYXwwkyx+mt8nzzEu4bI5CfBWUxrZJInk2AV9d+775PCf2SPuOojyZmZCfvJ99I4CfkAfU40SJGiJJ2Lt1/NBiqfyE2bgpkppFd+ISjuH8E1vWwUm/yskOInIb4w8FQSVk9wpRryOSD1buvDXRPwXHyIT6mCHOCZgfcLJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB6821.namprd11.prod.outlook.com (2603:10b6:806:29d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Thu, 3 Nov
 2022 05:31:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 05:31:17 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
CC:     Alex Williamson <alex.williamson@redhat.com>,
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
Subject: RE: [PATCH v3 03/15] interval-tree: Add a utility to iterate over
 spans in an interval tree
Thread-Topic: [PATCH v3 03/15] interval-tree: Add a utility to iterate over
 spans in an interval tree
Thread-Index: AQHY6J1pV+jGP7pJvkiET+h0q4ynNq4suG4g
Date:   Thu, 3 Nov 2022 05:31:17 +0000
Message-ID: <BN9PR11MB527666424E77F8417DF1BF4C8C389@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <3-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
In-Reply-To: <3-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB6821:EE_
x-ms-office365-filtering-correlation-id: eb20ab92-edfe-48f0-bd7e-08dabd5ca1bf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9anwPCVEM6FJT1+cDMw1jMyTX+HF7u1btfXM/y01B9c3lZXv4ZkXQAr84Ny5lFBa0Qmz41K9z2K8r2UR/5mMPYkd0v7IaBwpJIS6wtidSj8CU4gbl0ccEJGvOE+xhZ2bc8bT5qnLfn754OhLFjPbtUpodZ72RseJej1/aka0OQChxufsCTkizfsuTYTBY0DUYgzqXqghnkD5Eo0wyPiAkdcyPIa7o75jClzIK8joWX+iYKvdudexiKKlitrIsge7tbREhOjkzTHp8ydf03kz2Z7fzAdCcwQviGjsMiHR4iCq7Ro64xbzmxKBgdtf+R6iswlWwKx3O2zTLzae3lZUDLGvbedqo3oxOeCghAn/I4+Zol0W7mhhUFvw+75ksqjI6i7Kmw7mBtOQA/CJHxKZof9m4U3kKJM2MsnkShvF0wrfIdE+luXwjqNyX2WivW9gv80dTxyt4UZlcANRgymmUV7DEJUFjGJ3HfHW+Ag8mcmP/pvZabx/V70OmnGY4dFjRiUSvF3A+d4VICKIH/ioDZOb/G0pJvosTyE3+T5pmaJ4XKfXKr20RLIJhRq5XcFNfc+qdPMz99VFytLMKpO2Tkv2MVa+yjPImOyFSRpN6P0hsPQDtZ1sBj1jY7y15VJ67qeD82J+ZpZw4e7BSOFZrVkjI5IKaaNt0ZdfUCXOH7hp5H7KI8RD/jdRNd5PjYE7JE7MM8gAJucfMHWXgLuyoFtqnYSzrIEgGBi62GEVSnnjAOT3AVhVr6SRFlUiKh4WS5ggOvWMQ0sMGrFaL+uPurvUCaNwRAdLoyEXYL8aum0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199015)(110136005)(316002)(54906003)(38100700002)(33656002)(38070700005)(2906002)(71200400001)(83380400001)(921005)(55016003)(478600001)(66946007)(7406005)(76116006)(5660300002)(41300700001)(8936002)(122000001)(66556008)(64756008)(66476007)(4326008)(8676002)(52536014)(66446008)(7416002)(186003)(9686003)(82960400001)(26005)(86362001)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F7p1c0lnwQJgOPDCKHI9lHZ01FWNOTR7TwvYdCcvjDHlQ+keRlRGXJp4kJuo?=
 =?us-ascii?Q?KpM3rsW1isiM0lBXjKAdFR2VmwizX3PDZJnIzYWD0OxuRUtWMjRpNqiW1dzN?=
 =?us-ascii?Q?F8ZrPCj5pygqm06S0C79lXK+G+F7JVMdtY8VOOcusl2vK8y4y4pGmpQO6NbY?=
 =?us-ascii?Q?Kw/+Aaj/LAwTCBukqFjMaoIJa5F52+9cBE2BDSF3hgJu1UBMOUn/Hg+AhWRJ?=
 =?us-ascii?Q?+BE+wrww0cfDXpF0GsBYSkHIwmyMTND7OObTIZniAW2dTVGt1XzVbCEJcVU6?=
 =?us-ascii?Q?vRCy4afIdM2FKWwwO9jZZadCP1h5oPwJnfWFtdggu4bxpl2ufnffA98n0ZeF?=
 =?us-ascii?Q?/VApkYVEoHiX0h3ANi+VoM3eAXcqwzpqD+n1tIqLTjLfIl2j7zPVQyJh14nR?=
 =?us-ascii?Q?hLUYOf6QfDi9WRfMa3C+FhERwiYg3gPbcYKdMTKJne7zOYx4ACVRN7bxRR98?=
 =?us-ascii?Q?dX0OyNW1lUGThC/eo19KOgKUKBQdkdOhE/qL4LErr1OAqh7ebeDi3PtAPtwA?=
 =?us-ascii?Q?PK1I7X2xZwC49aYHJFEapdbPCxf0Dtg5IBdp4udWWNsfOolm01O2aHvEVyHP?=
 =?us-ascii?Q?DI2HS+hvnGsTehWre0VUiPw2GF2JvtOh9xNBOsXbzbfPv8c8KsO6oAZD70/9?=
 =?us-ascii?Q?GC76It3gpi0AkMZX6Nc9Plv4Ey22FI+hPijq1p9D9j5WpDQb8/joTmv2tsdH?=
 =?us-ascii?Q?gIl2VcAVhgJ0N+ACo6i+pbhf6CoA78gOUQ0gGdWapOw0gaNtcYsRw7Xv89Dy?=
 =?us-ascii?Q?+m3T53OZS1coaa9MYJ5F77+8wf/9Yw9Q80RJ6bcJhwx/++pvEJM5WVzBrLfn?=
 =?us-ascii?Q?vPufeYvjEDr2rRtJjWwysSXmcCXLkJU0HyBIX5/tp24MfGZbmbdeLToQRh12?=
 =?us-ascii?Q?JUl/bwRG6SzupjxmA6So7z4iBtDUh2KPvx/lsPpwynFT9RrqPaP7RT1E+CGa?=
 =?us-ascii?Q?rjrA6r7DVTZD5v6AvTcHuelW+umpxu2nPkLv7SPgBlLxKvr+xQD21IgCFvKx?=
 =?us-ascii?Q?HuEqt1Oe7z4sjb9GEkiFUVoiBgt9m4iQ45ea5BkU0I4+YYGSPtyt5wINRRZx?=
 =?us-ascii?Q?auc/uCs1wxSSQe87029gMRDGIMdNmfhQvuqMxl+DpDFZeV2uLm7Pzu8sWcnc?=
 =?us-ascii?Q?cL6OiUSx4sT3bNXGW6OSa3eFyiwxN92ut4htk5qF4c2dBOd6E88oiwaDDszs?=
 =?us-ascii?Q?yutHbqzJ7aIpEs7/10NFOiSeq8iQSR8OT6z663lxUfDDQy/WmuXousw7j9xL?=
 =?us-ascii?Q?ZlLa5WWi7rYFgP1jGDc6l943InZuB4OiNCbcYrqC8i3IwVBtFNTAD8iGd7Vo?=
 =?us-ascii?Q?emShvMykRFXKQjQf69G6q+ZzBRdYmjanFIL5WyDC3hq0jRNGDk7OZSxGMN9q?=
 =?us-ascii?Q?2ilKdvGZUE4kojwR3oTlg3qXXIsufs3yLFU6wQrRXhgpjetXUMNG3c4ODEFW?=
 =?us-ascii?Q?3M02BnKRdHZ/YA9fnv/NLS36XxvQlfcZCzj+i1UH5Kr5+F5fFFW1W5Pd1t7T?=
 =?us-ascii?Q?l2EUCkQiQEP1iNAu9Xomx/ay6qixC8cpalBoqk1aQYVJGJHc6KweENPOX7+m?=
 =?us-ascii?Q?cstovHI/JWywEe0bE/F4vlWox3Fke0/PQksHMxml?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb20ab92-edfe-48f0-bd7e-08dabd5ca1bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 05:31:17.4060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fa9R8C1XB5Q+zby1eIAARxGuaETF9Hy99KLvG5woTbkZZw3X1ioZddZaugnu26s0DBFeBKIYvnjSdyXGZgWnhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6821
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, October 26, 2022 2:12 AM
> +/*
> + * This iterator travels over spans in an interval tree. It does not ret=
urn
> + * nodes but classifies each span as either a hole, where no nodes inter=
sect,
> or
> + * a used, which is fully covered by nodes. Each iteration step toggles
> between
> + * hole and used until the entire range is covered. The returned spans
> always
> + * fully cover the requested range.
> + *
> + * The iterator is greedy, it always returns the largest hole or used po=
ssible,
> + * consolidating all consecutive nodes.
> + *
> + * Only is_hole, start_hole/used and last_hole/used are part of the exte=
rnal
> + * interface.

slightly better readability if moving this sentence into the structure as
the break line

> +void interval_tree_span_iter_advance(struct interval_tree_span_iter *ite=
r,
> +				     struct rb_root_cached *itree,
> +				     unsigned long new_index)
> +{
> +	if (iter->is_hole =3D=3D -1)
> +		return;
> +
> +	iter->first_index =3D new_index;
> +	if (new_index =3D=3D iter->last_index) {
> +		iter->is_hole =3D -1;
> +		return;
> +	}
> +
> +	/* Rely on the union aliasing hole/used */
> +	if (iter->start_hole <=3D new_index && new_index <=3D iter->last_hole) =
{

"<=3D" to "<"

> +		iter->start_hole =3D new_index;
> +		return;
> +	}
> +	if (new_index =3D=3D iter->last_hole + 1)
> +		interval_tree_span_iter_next(iter);
> +	else
> +		interval_tree_span_iter_first(iter, itree, new_index,
> +					      iter->last_index);
> +}
> +EXPORT_SYMBOL_GPL(interval_tree_span_iter_advance);
> +#endif

Apart from those,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
