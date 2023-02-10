Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA11691642
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 02:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjBJBfN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 20:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjBJBfM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 20:35:12 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BCF47EF2;
        Thu,  9 Feb 2023 17:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675992911; x=1707528911;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=unh464rOyvlNx5uiDoTDVgtbmIbnoy+kFUJdUH4Ufl4=;
  b=av2WocxN61fN9AZr7XBMh+QwwjHIRw32pX+qXNdXnbmRXN/w6eklmqOO
   GCJCG5gJHl1MClOdpA7dZAG1Oyo6+J3q/W0MxeNCZWU1FBFZqS2M1JE+T
   FalqOGl95SnE+WpNE56KBjMceA8XsChCQHT8NWZ2Vnp3ePlFWdkLqexxd
   IeZclgmC6ks4IpJmR08UipYEc3qRvYJ+jiZSBxoiunBNW4SH/sWmQYMKe
   Lbw3m0qW8JdGes7x2OM98AGRUGf8g2LUGUvh5WSduxLfA5HdNyIDh/n7q
   WKha3wJECgPUVnYxumuuB9o0a5aiSIAoHKqcSQ2ddea0qOUH6lyEjRUG8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="313950383"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="313950383"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 17:34:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="667889681"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="667889681"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 09 Feb 2023 17:34:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 17:34:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 17:34:06 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 17:34:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtRVIm5ua5igyJZBAgneoJSaySju7zSFep3gxHB8Yqsyiwbms/nuIddTgnGPL/RLcf9PncGvrFxghgF/c5lnSx27YMRROKgFjiy03GSPfA6lg/a0fF/EXHINx+QiQcIiRi+CoBB+shOzf+1ynMZf3hcnEdKtDfOos+f4EC4r9u9yjcwpUbdDpsun8e7Sn/Sen10n/hdmhGxWjOwHKHBsDIqrenlTREN0zceGuMwhYx0NL4fKix3hf6PlnT0nsYj/v3t6ckdf4qYb3RAm0kiICNnlFuDR9B8sVVvvL8ccmDnkbqRRYXHzKtXR68NIVZ7VDviCVOluzqpI+lIZnansfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unh464rOyvlNx5uiDoTDVgtbmIbnoy+kFUJdUH4Ufl4=;
 b=g2Z58KFpcWwPNrK4EBA6o3m0ZS548E9CWxi1ZTSR2CxTqOnhgXbGHwOr2dz8/HPbBtM69FtKByRxDArJ7O8SOsbwgDcmjpFnoKoe2CD/GTbL6KFzunzPSBlAXhBtZ6eW0gq2NOjmllRrt61S6tHvV7+hEGgpAZVD1UYbwqgNdnTbHVoNXMIT4n1AlhG6qSJPRuQTXEHTknGsZfYbNjFh+VDMAvBiKtJtZvAZHwDDMbVIpjrNdSzdnN1T2CQoQU4h3XFKnNi1zoaXKBjTdx1TwHMXQjkq8cukkl/sbbvYATSBcuQqx7x7XhKPw9btEsWHp3SOK69Zi3AcAzIg2hefyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 01:34:04 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 01:34:04 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v2 00/10] Add IO page table replacement support
Thread-Topic: [PATCH v2 00/10] Add IO page table replacement support
Thread-Index: AQHZOzoLaTccvosdo0yw+4v5PUyMbq7F7ADwgADgXACAAJwpcA==
Date:   Fri, 10 Feb 2023 01:34:04 +0000
Message-ID: <BN9PR11MB527636FD0A6CBC26AF344E378CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB52766A6DDAAB9E80A5830D038CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+UbmJ8Y1lT/mKSl@Asurada-Nvidia>
In-Reply-To: <Y+UbmJ8Y1lT/mKSl@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA0PR11MB4719:EE_
x-ms-office365-filtering-correlation-id: 8faf96ea-3287-48f9-9555-08db0b06e534
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E8t1Q1Uicng9B/jYcNVX/eS4IS2WYWpnoLkm3UrQq3lzpfSmThgsg4YWFH8TXBdsYjhzX2NLFf2qDRy70uyVXjAIHzGkbyfqpmGGHC3Kb/haTHEES8hPi3dBwY4wp5BGm79iNTr4scV3shAP8K4PDvxEmMHCNc6w09/A/KykDwUeS9agl56/5Iu1kijT+KBymXmX9Zl/da12x7ohcxB8aocjaz+pia1Qo0RazSi8CPM06rdj+vHCQ26gY+d6BanNnem8NQ250Yq5dbvA1KoMjLFFVrxKuopMD7hWdSkgXCmvY7gIlJMSwdocFxO/kM6U1U5EQLm0CRBIgw9O4toLou8NrLRW4TeYvyw4K9o+Crevnyczno3W1/ZwgJ8W9hTjHiJfkXxhxkq5o3Ll3VjQxo7nUwMXC0Fatb6nbU3a+BJgXcoFr/uAJYnpfdjJZvCmgw1mM8UIA8I96OhD43bB0r04I4tOtiQYc9QDyzb/eBNtnNuTAOiEU1oVpQzTgEQgFSImhU4TjM3ojcteM+CfGRrTXVxpwsr09s8Ux7iWEGXEZZwxYxU8ihLEgfT/CxYuwMpSnbl8+baRZY5+EJTnFn4hi5wvXn9k4ddtsBeteD1Lc3S4HDgIYZdEnZZ9uv/xof6JkYOv+FURoqflb7zm62BLCbBUHYfE+tXDl8TX/ZeVFaI+ZoeuN6QzaqM+PBWbCvqw2E3CTMb8yqGN/vjPWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199018)(2906002)(52536014)(186003)(7416002)(86362001)(122000001)(8936002)(5660300002)(38070700005)(26005)(55016003)(82960400001)(7696005)(6506007)(478600001)(71200400001)(33656002)(6916009)(9686003)(38100700002)(316002)(64756008)(41300700001)(4326008)(66946007)(66476007)(66556008)(8676002)(66446008)(76116006)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tGJQs8F0YUF/mXO4XfeqkF1oElRDr8pZNZC/XFCXvF2SPdeOJ6Je38OuUq7Z?=
 =?us-ascii?Q?yNvIFulDEjmsn2W3UWS+dzsD7PfwIqMNxg4RxBvLbYps0JjoKDS2EG6fNvNX?=
 =?us-ascii?Q?0AphtwndaoblVEdQDugrQwVfEZ1IBhkmN3Xf4Bf6NImYBPgfeX/ZO2r2Bdz8?=
 =?us-ascii?Q?OytVufbvHxLhAvHD8vBjcasxS7ZKvHU6ib9860/kR76ea4O3z/OFFJ3VwSsx?=
 =?us-ascii?Q?3N6OOxvTYItlUmgXMaZ3lwkjX5HzINZ5wj7aNLm37hnqoawQq0dOJKDdIPhS?=
 =?us-ascii?Q?KxFb5OvbUvKEhZacPfF+u6AwTJovrF+RGsPC2N0myS4HsFll/2b4jyAmeyQ1?=
 =?us-ascii?Q?HaCBe3F9KEJYWXNpb4Nlf9IDhpJ5S4lz5h1IHMmzl5CP35lCE9rR21+Wzt4M?=
 =?us-ascii?Q?6u3IgrBuPyu0vthQWNQRSLHiQw9iVot9lFFaew80k0EPN6yPG/YfbzPSNhG7?=
 =?us-ascii?Q?mY64uVYI24RCV2x41r1jNZbyAgvOOb96N8+uTqzWOFwqnd+EhB8cGnWt4Pk3?=
 =?us-ascii?Q?WAghFj752dK9uq+NEhjtbdTn7JU4XmX9zh3gdJIMjhGj/l4rWMIHj+Ptokws?=
 =?us-ascii?Q?7gzPiWtYUqnj141ny694Cg2UkdKFYRZ29N4GNrdooGlQDwvhsV6qBtWMpO6T?=
 =?us-ascii?Q?YDAoU62x95wQVX8U4fr4TlYtk8ieaQHf1U8gKvFdWxpD9Qk4lkVl/SiC004C?=
 =?us-ascii?Q?QEaLS4WXntXX8pyz6pIy3R6+1kKhBpNRVH4izgmdKFwBApmlTMSlRSKqDLQv?=
 =?us-ascii?Q?BPvJSPZq7hFuKMaHhO95THwdU72Rh977qx53qsZGNk14bMb+kvrlq2j/9wzx?=
 =?us-ascii?Q?x1MRTfIwJdMamvROrKQARBz7ZRvi84eoVRag3PhxbG8HMT/I1/nfpmIPoeAp?=
 =?us-ascii?Q?yR+XdtVwqJtDQJYDPGR7+TcE1fZV4W5XxE7q1QrC9Pho+1MM3tVEZBl+I4wB?=
 =?us-ascii?Q?CkHy502sq46OKHFgllv2A5KeDQYSd2LEVUcBctAOkCRYQXt4C1Obs8asZs9x?=
 =?us-ascii?Q?sPt9pRu+4lNS7ZPfm1njPwg7Nwh1LVhkdyJ5pUydxYfYXhi8Jkw9w1+rI7gC?=
 =?us-ascii?Q?8xgPY7wojlULQUXrTry6ntxDaCpTMX/Bj6ys6RyuGC3+4VS8omPlB6akq4ZD?=
 =?us-ascii?Q?ahEGPgE4+zOeOxDQ3glAGfKuwXGfeOG8e+6pTB7EcEr/4FwbzNOlXsXrsMpk?=
 =?us-ascii?Q?wBEAPA03bGJ94E+0h+CVuC/9hV5m0zgk9Qel6ldHJ4jg0LIC/iZ7vBeUiwB0?=
 =?us-ascii?Q?Ia1UJJ7yR8gOvhg1bGeQvaYFpluk1pAum6bqN0lX0m3GtzSdQ7ETIPAF6d5r?=
 =?us-ascii?Q?AoJCmo7f5f2zGChgZTI9rEtMrfK2a2DmnrsIzWUIVLeAQ17pcWvg213S0mZG?=
 =?us-ascii?Q?6lz85Ug6CXE4Cpguq6T5cJ5sOupeSVP1xvEczPT3ErVmvj2Y1a4okuYwSx2L?=
 =?us-ascii?Q?wtzof5EbBu5zVrTKqzWPOdAvQ5BOBu+ysVMCTy21lyRBkPmf3c8WlyFvU3YI?=
 =?us-ascii?Q?vVxIIBRVAxhI12fBQF/ABlMscbqUmnCQZi5PjFl57iqysUwd+9ObBMmCjuMK?=
 =?us-ascii?Q?hBDaxEgpSOdvPorCtJohcuykcdtpFozoEQw7oDJY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8faf96ea-3287-48f9-9555-08db0b06e534
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 01:34:04.5882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I/xF0aqptaj6Yx6p6j07XP/J/JadvfvTWxBywW17vn3w4lQYGuP52fkevgbIs17ttEii/U4FSditHpKu7arcDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4719
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, February 10, 2023 12:13 AM
>=20
> On Thu, Feb 09, 2023 at 02:50:39AM +0000, Tian, Kevin wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Wednesday, February 8, 2023 5:18 AM
> > >
> > > QEMU with this feature should have the vIOMMU maintain a cache of the
> > > guest io page table addresses and assign a unique IOAS to each unique
> > > guest page table.
> > >
> >
> > I still didn't see a clear reply why above is required. Please elaborat=
e.
>=20
> Hmm..this piece was directly copied from Jason's inputs before I
> sent v1. And I thought he explained in the previous version. I
> can drop it in v3 if that makes you happy.
>=20

Jason's reply was:

> I think the guidance is about the change to VFIO uAPI where it is now
> possible to change the domain attached, previously that was not
> possible

I cannot connect it to the above statement. Anyway if you think
that guidance to userspace is necessary please connect it to the
replace semantics to explain the motivation.
