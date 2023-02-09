Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0628868FDE1
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 04:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjBIDX6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 22:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjBIDXz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 22:23:55 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47720A8;
        Wed,  8 Feb 2023 19:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675913034; x=1707449034;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WOynDSlVDPdmclVQMdflRJniYNTd3F5vTfdC96Sinvg=;
  b=bfVHcfmoCDQ6CwraDOiSZmyi0IiJKvkumvMU9gt3ckiXhIog9RrHD28X
   tmrqWWylzSTKt0I1u+htKqkdCTkEiYh1CDCHww/CHILNgm/38Lf+bDcqD
   J5z26UFxfDgH2OINvd1Xb60hpsAN7TN3C9fxV8HHswFjHdtI1LN9ygvc7
   +J1RM1nja4eMu3oG5U81T+kIfnQaBUZOH/dmtZ/n6qw8c+HSxA1H9evX7
   cWMHvRmt02N7WlOSW/ez7vtJWVtdFLypzYKIaHsUvKxpj0anB4jLQeaq4
   sMxZ/TsJDosT7OVtQbkjrofIqVT6zYHvtLbjgkzbQn23y3m3axvALgEG0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="392389449"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="392389449"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 19:23:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="776305575"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="776305575"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 08 Feb 2023 19:23:53 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 19:23:52 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 19:23:52 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 19:23:52 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 19:23:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/AAh/YOtmkKdjZx1ggBQCpAwU2Aar8Xay98orZM+s6utuotyuXXxo7qrgdum8+VntZKxu13rvFaU49Co0LasJCjZxHDwIESLUjz4gljTTPSCHZGvhQBEBZSMu7FXCXoOXrxcNz4Lt4K8AsOvYbwaEQcMrH5w3FcrpIoqC0UOW4A78IZoO8osWaIKnIdgf5jypRO32Gaf5kDvVoswSz+XozclvVzL6HpIIrq+7Carir6y/i1Olq3Ha5eh8v/SEsXX2Vo7mOUwRwhVsH1ga0P3xXn4ioIifiKApoB/YtRRKYHiVKgUEKeIbq2abc6a10ElMWzG9FoR9QJiE60x9pvYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOynDSlVDPdmclVQMdflRJniYNTd3F5vTfdC96Sinvg=;
 b=hciz9ZtWC2KCFH1VDb8Fbwh1GISERydZLR15K1qjUP7/56bRhgzM2iVw451+u4UMfH1ayf349Td2GMdwKjP6ZZSdkAD7RxEZQv5KcDfRuJq4GRD7NLo3VjmCJ0ZmxxiEy7G2z4ZzkQ69gGvR/+oh8y/WFww9+oN9pt/YkwnVBQgDK5ENlZalXrH7AOCXwKYvXFPIt/JTekCzMJST4zxG29oh0lrbGJnD9xAwgM2m4Qm0zfJ4y2JbQGJp3WQpn9tm/vNiOr4GUD3B1kvnlmRGWOU++R3u1lHsSG0RmPG22jOL3dghivnJ9LvU9XwQUniLsPZly5+J2l1fsWzr3Yceuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY5PR11MB6306.namprd11.prod.outlook.com (2603:10b6:930:22::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 03:23:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.034; Thu, 9 Feb 2023
 03:23:47 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v2 07/10] iommufd/device: Make hwpt_list list_add/del
 symmetric
Thread-Topic: [PATCH v2 07/10] iommufd/device: Make hwpt_list list_add/del
 symmetric
Thread-Index: AQHZOzoSQMv1v33l6Eyp7LBz8BGoIq7F9D6A
Date:   Thu, 9 Feb 2023 03:23:47 +0000
Message-ID: <BN9PR11MB5276F36D2F07209AC7155BAB8CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <9d0d4f935c4972771f5aed4b4837d8ae35814e06.1675802050.git.nicolinc@nvidia.com>
In-Reply-To: <9d0d4f935c4972771f5aed4b4837d8ae35814e06.1675802050.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY5PR11MB6306:EE_
x-ms-office365-filtering-correlation-id: 632ef2b6-2c77-4804-5831-08db0a4d0e65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Elgie9PozD5c7wWczrhJ86DD89IueohY0OwOtjjHPtALZ0zHsjwZTrb1GlRjNm1grjma8c3IzfuG9KxzS0xDaru9AbiPbE4SVDJHCr1ppyRKNkjMJEzHZeUL+XgvAbVoqSfNTZPfjjsUjoVLYFrYYSLedsH/BovPXlkR7h8DVj9vyeG/Hdgl8dLwDllVGx5NUH7IywDC9Trc9nA4gFkkiBH9BoIjUVWeWOjjCL+96PWSyL9ByyUTv7lCn1Bi08fkeuDHUDdXq5lONoSPWU+CCtu5NkoeXI+cTPv9gbIXK4sOFtSC9cLi4sSIOgLd3eiqlZFax4fJe4Eae9DNY3GrfbjOMLg2J9xddjwkO7bV415SE9ew+he66Fx6jLqaj2xoYDLmlkgFni5lb6RWeCCCpRFb9fb1rYi8cRu4087y8J2bN41Yqy8OJKxiAyvL9j+pUP/MMABAKsx8Kds7VCy0kvYamK7xC4nX0GiGP5//Ayv06GmxaeUZvYtDXM5E3NmsDHq6YSCGYFupkuCyttp0fRDWf3X1zpJx43PoRmkh0FWMN33OVvuRsCsM3cr9BmlYCDpZSH23+n/65al/hBMZ4RTGRT1Z39hYVd5V4pwlhl4NceKc73KUFmOm+xkT1yI2y6M2ZX9GYumvpHTJMwQXIbf84cw5ivwmZocpaPlzUQSNM5tIMXpKIRPksrtVmvrhK0y3FxdIgz//nQY2XlCnpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199018)(6506007)(52536014)(8936002)(316002)(9686003)(186003)(26005)(478600001)(55016003)(38070700005)(2906002)(71200400001)(33656002)(54906003)(7696005)(110136005)(5660300002)(4744005)(86362001)(7416002)(64756008)(66476007)(66446008)(66946007)(66556008)(76116006)(41300700001)(4326008)(8676002)(38100700002)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?znmL5q96jJFMH2pobBcFi/+l1Trr0Ove1poFQnwYZ8oE6l5e/l58n3Az0aGB?=
 =?us-ascii?Q?BHmtA5WyjKoxNrK84fePLnJwDLnHCCmJ0cJGxv9C/gGYMWUY6c5JYGbRhrHH?=
 =?us-ascii?Q?hjavtSc2wIxG7+CukrnsstCi00zmZ9xjAZzOgr5cHwaA5B9eHBuXWixPqiU/?=
 =?us-ascii?Q?amrnYFRWZxFjZW8k0E23nv3V43biikU39Y+0VdLjszsUr1eqkKXqleFbfVOJ?=
 =?us-ascii?Q?U+pk1rtw9yFJi8dcF1+FQTxIofdDDt3tePT/+9Koi6Ks13R4jDP8YRWYoF5R?=
 =?us-ascii?Q?RJwkD9LFi/csP+mwgNgrzwxM8kUnNaRk7CiTeB1MkMBe0lr1lAwPHzth38GC?=
 =?us-ascii?Q?33EcWtWcDv09s+WuCiqalU20mM4m+XVtfgg+FZNy7WVDHDZ+TNDdLmSIHC0k?=
 =?us-ascii?Q?UaZvICg8EM3X4d6Vi6VwPWeGlLdByfzEwJ5o0xDJW4XC6Az+dxIJseQP9tYq?=
 =?us-ascii?Q?o3n2R4njJHsdC2jXyhWhAQmeuR9KU6McjHJQpJoXNxMG8IYU5RrjPuUQl1R+?=
 =?us-ascii?Q?WWNIDe+tRB2CB0zB3rdfRAEr98mcTMeZx9NjgtdDLPkq6JZMlomLoqnwHoQC?=
 =?us-ascii?Q?cb3EiHCrcnegFAJuJcFWY+8ZxjrDkY8hpsexovG5AaIsSzXMk8Jjh5OVUy8p?=
 =?us-ascii?Q?yEzL4sp5znL+m9P6pOjLhAbe0sgC4XmU+ZpHJ5oytgwkgZq98Y5MrGLtU6v1?=
 =?us-ascii?Q?dGDGOYeDMLUNUcDCOLRJJkijclXbl/6hM9bJBiO8P255ikV5tLM1I9rgVTxD?=
 =?us-ascii?Q?ld4muy8a7x8v3SVtnVFMaYB7HpvdsMDRb2OVXrzdkCG/51ecXeGvEeVTmf0K?=
 =?us-ascii?Q?z4CtSbPs/WPx6lB0Q3pB6LR3bsKZEPMYN9s+7K8FtXGLRIU0xgIqJfcCljDn?=
 =?us-ascii?Q?5z/k/Lu22jDCfXcFC8EoPFPb2q/Fj06N91rlax5MoezfJO88e74njdX1MOuw?=
 =?us-ascii?Q?5OPk86bWlTtHFlgxmZsnfWzbXtHkt78+7d/+caHctP3AW+9uWfsFnHNUYm/Z?=
 =?us-ascii?Q?GJGXQfEAy2IHW+rLHGAvEmFVJeNWF3JXyJ3XMo4Duqw4wZBHYLg2x6E5x1Di?=
 =?us-ascii?Q?y5Be8/QygMqsLEhYSSMMPptIQYPvphwJ6D6zApOw2UeYLZZGBwwVsOtmupuw?=
 =?us-ascii?Q?mFBnc45EFe0xnDfU0C/KrIpR4m3xtSh8+Oi2N1L08UZQDVJu3bPiVJ/+A5qJ?=
 =?us-ascii?Q?1mrLt0+HBhQpziL9kpAQZaBbPvBxit21TbmifBT+IOcgA8O7fbsBAYIoxVpa?=
 =?us-ascii?Q?Xs/elvsdvr3M4pkr6LJWp16eQJLa62HQ36NdWqn6NEz/fy4pGkZ97kMhprbG?=
 =?us-ascii?Q?zTComaOlonfeXxDD1q+YtFZHRgZ12Aup4w4+IdxbmfNiexmHHfolv+0tHr32?=
 =?us-ascii?Q?El/JRNfb3nDKEy4kvHz7whKlYiBiSdfUbw3E+bKLYw5KK4Oa9AuaWyUslpNY?=
 =?us-ascii?Q?pfRHarNYuNBaiNxPp5aDsRriM8xbtDrLW1dwprwbXjSR+BBi4KBSaYvIlFWQ?=
 =?us-ascii?Q?IEOF0Kkz+iIjttWz0f1UhGFBIXe540ztjsiI6pXENqMCPDoj5C5ws9h9SwFE?=
 =?us-ascii?Q?71Qeqn+UreF9LfZk/ASd8pdr0ZJM5gXXbR4w7ISX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 632ef2b6-2c77-4804-5831-08db0a4d0e65
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 03:23:47.2714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fYsdyjO5lG0yFoRdoZ6yevCImEfEBOrpp6maozMwlb1hQyI/IiVuBOyVwWlWwAef6VqxVJeJb9cYZrFkHhKjFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6306
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, February 8, 2023 5:18 AM
>=20
> Because list_del() is together with iopt_table_remove_domain(), it makes
> sense to have list_add_tail() together with iopt_table_add_domain().
>=20
> Also place the mutex outside the iommufd_device_do_attach() call, similar
> to what's in the iommufd_device_auto_get_domain() function.
>=20
> Co-developed-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

shouldn't this be a separate bug fix and backported? double adding a
list item would certainly clobber the list...

