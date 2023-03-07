Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA5B6AD4B4
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 03:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjCGCc5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 21:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCGCc4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 21:32:56 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2407435B9;
        Mon,  6 Mar 2023 18:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678156375; x=1709692375;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rrxqefR49HD7+vLFxVVGpYST/i5VRlKo4AoIxdCzujE=;
  b=m10eMyo+JHiOj9eFaM5vwMnb1Qnf6bGt6Td5/4J2K+OLpAhrSdhnEspV
   xy9495omI+/MRUaK7Fq5CFOuzcAgR3/nssUbFkd3bGUp2LR+HGFgskig6
   F2oVBgA12QwN5+qghzY4Y76hV6oV4bYOJ+BAAyjLWp9NnJhD8jNLsek5z
   sJRsf2ZT8IJWoJNL7GQ2tgVccuSnUHVIg4aUVzx08/rSTbWYGBNT+QLZa
   OLkNa66TgI3aO7oiJjT9i00aA49mWqyFCh+R7EArMgrF3i7AXEwogCIWq
   VCFtdJbfUxkSYJ5a0cg1aLRUoMCPYDEx+nM1WwQGYU0td9S/6AFbNK61Z
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="335763322"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="335763322"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 18:32:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="745285598"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="745285598"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 06 Mar 2023 18:32:53 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 18:32:53 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 18:32:53 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 6 Mar 2023 18:32:53 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 6 Mar 2023 18:32:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvS78kww2N9SwUPPU5DRzIR68usJK34IukBDOOxhUxoEcVi/R/nCs8RbDoEH7yP5xYUzh4VrGI6JjvMg7m3tvl1GJ3BUg1kgLQSqyVQSmBbEaNRriLGB0ERh5R94ZatyFsrqS5oAhRva2DZL9PJc/8vKQNzDz5ecHirhEFiwf5veloSZRuf4/UkmjTQeK1khWdvs2VQU23HohVCs4guDL7gM6U6xk9iGaZ5uyyapGVd9tVYwZMy61PlZNQi0cyBAZBedrj2Wv2FqB+UszJ+gP4sFagPuOW6DRnq8aC+4gP0pK4vWHWmcEFQKlES0yApH6QkFKIsytrj4uihNm5IQFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZ9XeqgHrONfYm5n4X7Zf+MtmifR4vGjNenC31uS+Wk=;
 b=PuxJdhNCYanDE9Xv38AsKQc/BEX+8JFgNcl9M8+JeDzvJ/N3z5OUAtB2QEPDlygIN/1SD3g2is52XdVPQ3V74VetFLGjgZ2u5nNzYhhqOroGOj5/dhhEEWdcYVci3vNlnzxyjfiwt9/WQTGcCg708nkKzKCG64lEwEtY8N5Q0JSiehw7y0fM0TwXYe2pG9lALFK5qXLZWOl4Ij8bHqMdF2HEbQH76F5213fsKVF23pU3OfYZEZR2Pk68UHMOfxHm5IHJ3oShD2N8XbsPHaA/6uSrYFycD4OnELbnjwBMH0SWf2GydELfkHsW23btkRzi8PJrsItP33ddUdErCjbFAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6514.namprd11.prod.outlook.com (2603:10b6:208:3a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 02:32:51 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 02:32:50 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 02/14] iommufd: Add iommufd_group
Thread-Topic: [PATCH 02/14] iommufd: Add iommufd_group
Thread-Index: AQHZSLARxLaEke/AGESa0unZyuRN0a7nJK9QgABVcICAAN62sIAF1iEAgAB5wxA=
Date:   Tue, 7 Mar 2023 02:32:50 +0000
Message-ID: <BN9PR11MB5276849EC9A770DECC2C4D478CB79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <2-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB52768565CB65BCACA4E3808E8CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZACb415lOsmjaJz1@nvidia.com>
 <BN9PR11MB5276F5AC80DE63A6F5B020ED8CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZAY8FI398003FEPX@nvidia.com>
In-Reply-To: <ZAY8FI398003FEPX@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6514:EE_
x-ms-office365-filtering-correlation-id: 19818684-2f45-46b7-877f-08db1eb43f5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RPbfFEG1RQUEmm4lMvNoiZzfCD8NmopkWyVxTGwTAFgON85aeI3ZabwFZ0vXU4aBRzmrMefNNh62Axv+NcyxxCv7NbolMkEgZs55vjVGeM34lw6XYx8K4BH94rV2OUDpgW71Hu6vXMiwDyndFeadR20raiSP+NyHvpmsA0HimPM5Rpxcsmpy56cUKDh8jKoAnWa9SkSg/NadQ49kbIfZx/ZnzMHXS79I2g9F3A16UbVGQHq8izjwNrX64o7iyHQ9Qyu1Ejvyc+na9vJnWUZcTUZczDXgYRxExCsud4aC6ogASet/z1ARIW6Y8Lda03IjzXMTboRxNFpgLqLlF5cuis24jyotUJ7vu8lCsEhvACQpCNhSRm5Kcf0bzeWP3a5QBp5IH3ck+pODZ+O2KGs4Nl3VqgQM9STpi3urD+JHoCREZo97SD54HZ3PLff72umDR4zggk4pZH/8Q+QRjcmHqYuqMDwmZrWCFmqh47LP0Q0e72rADLOEmWzcm26sAaWQhHhdh6QodXeZUqXecj1XM73r100HbKrzFmh2ldcWoAKjgRTmXgYnvr3GWsbL2rqbIfCCxgd48Dl8MlUS+t6uzO6DFlmja9XuCXUcR0Ds9cfXjRPHYTd/Qbq2ze5UP57Or0jBCH/zEcIgzn9gTyq4yhzHAeyAyj8ZTnDObKbZ52AqX3vL6z1MDRxXnA78y9mmMjSaaEQFKdUYRfri37TRCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199018)(52536014)(5660300002)(8936002)(4744005)(66476007)(41300700001)(66446008)(66946007)(66556008)(76116006)(2906002)(64756008)(4326008)(6916009)(8676002)(54906003)(316002)(478600001)(7696005)(71200400001)(107886003)(26005)(6506007)(186003)(55016003)(82960400001)(122000001)(33656002)(86362001)(38070700005)(38100700002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xgjymndInz9kWGdA0h/0HDFiuXzCUFBUIil51fH95FOEDK/jdxk2Bn1JD8EV?=
 =?us-ascii?Q?OCgaFWAM3F6j92OJ+RDwf6BXt67JhLctJpXKkHraNjS5nH0xOF5K5kCgDs7g?=
 =?us-ascii?Q?wz3+ZzPWWNtR7ywzBEsmBD+51enk1H4Y2tNDTq+0UBXzZFyM9IvjZB/8qd2I?=
 =?us-ascii?Q?mSPPHUboUVimPNWDHsPWBqJkJne5EmLwXHGZRQ/jJLrJyXA0I5UyIgROE8bT?=
 =?us-ascii?Q?/ihTmdVyrjyApZ048OHYVZdZx4+llXZpbbuBTnt9ELxmcxJ3FhSVimBz0tSi?=
 =?us-ascii?Q?9VQfsD0gu8fMXTBUg+7xBGR7SQcvRyhF3fD7GssxXcIGGUduGi99RP6B3Bhh?=
 =?us-ascii?Q?i38/zjB4Qh2d0dKECrcWCi1cvTg7djh17/9rzkc1SW+He/Z3GZmzw+U8fxQq?=
 =?us-ascii?Q?dv+WJMJzKI0l6FtRAleQmXqrgiiAHU3VDxonVz+JToWzCvWVVjyPVqouIn1c?=
 =?us-ascii?Q?FaaFX8UE1mwnJo1k3r5bexWx2pXmVWAZpKtHs3VTQdcp+gEn5Da8CU6spIDd?=
 =?us-ascii?Q?S6awWuRvFh1oL2G+iCEiDbz+93TgCI97POyeITxnk/yf/yu+o1vP2pU56PJJ?=
 =?us-ascii?Q?O8mr6RbBo7Y5bUxQbo2BQvjezzTHPB9JXN1pX10v8qvZDnXRVUABVnMOgL/R?=
 =?us-ascii?Q?I8lWqdWYlwcZkr7Wy2C5Om4G5rk2/tMaGHh9gds9gc3W978yFHXaLH0sKbZD?=
 =?us-ascii?Q?klEPPNMZRTEa9jruG0UIYxQhkArrpfMY0QRHVcVhlkuZX5XbMqRKZWUrQb6F?=
 =?us-ascii?Q?nEdvpdNupEBDvKPv7J+aljJEQuFx2ocXmgCOgpp7TpR7QruhGQOH1aOcJYGH?=
 =?us-ascii?Q?LmsiQgcOkFesCJILAbLFC0mdhg7mbSq4a0hCmWh1jo+ncX+VH7F3JbN0mon/?=
 =?us-ascii?Q?mLNYHCjSZzZyg5T2vOiIiRIQDmJjn56TwFPPdfpVJdlyDoWCyP7HeEei3QGm?=
 =?us-ascii?Q?oQc7kmLq7K/6+8E4MRKy9OYBRa2UKgacCaoQjlEWHuzWyuDd54Ey8M32j8nB?=
 =?us-ascii?Q?B2oCIoFuh9FqMkI5j37+t7pwQolY7WkWaina8goLF/gq1n+CK/z1pvh80KNb?=
 =?us-ascii?Q?iDW1UB+TODvkUhuD6aaEJ8e4WbwQM32t7ClMZdl4c4sSZ3rwgHD3eyW5fCJu?=
 =?us-ascii?Q?7Q6N8lh+G7iBMOjKw28OonnlFBMuT9ERZftMNKwuO+1wMolflsJb1HUD3yEd?=
 =?us-ascii?Q?QCuLUQHB/YDWosIJuhca2C6xXEhUhl2UcA3PjQPYCDGYOxFOAPcCvLrWvH/6?=
 =?us-ascii?Q?V5c2Uz5SsHzpEh44EMT8b4SEQ2xNAsuRkXfHDcZkdQkAsajf0YzK+NP3ELHm?=
 =?us-ascii?Q?HVmlEwdnkIrVSF59ph/U76K+Jl97usViBlY5Hr4+7s74tXDlCZhPYyx1og0W?=
 =?us-ascii?Q?+KieEtEvGpGvgep9offjojqQ6ZwSG1dKM7WpkVjJs3G69GX0Ug+zpf3Qdva/?=
 =?us-ascii?Q?D22W6lgjZ2SC844HOwxc1Up2KQipKa97IMD8GBFG0Pbq4Vn7dq6Y4dDXqMQu?=
 =?us-ascii?Q?ztxoSL2rXyVbEbds6oKLOOjYC53AfYWtTYf6jIgnTUBVXBEKoFnYbLliRUTc?=
 =?us-ascii?Q?/naJBbz/9hisfT6/ZFYErRsq2x4wwyQk+7UZlbrF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19818684-2f45-46b7-877f-08db1eb43f5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 02:32:50.8694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 38QO4sPU5T82TjCw4KUmrn5dcTK44hWzZn3/h0w7iOAsTl/wgpNrfcFXHb5DN0j4vBMrf67dJs7v43pRM/yK0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6514
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
> Sent: Tuesday, March 7, 2023 3:17 AM
>=20
> On Fri, Mar 03, 2023 at 02:13:30AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Thursday, March 2, 2023 8:52 PM
> > >
> > >
> > > > > @@ -98,7 +195,7 @@ struct iommufd_device
> > > *iommufd_device_bind(struct
> > > > > iommufd_ctx *ictx,
> > > > >  	/* The calling driver is a user until iommufd_device_unbind() *=
/
> > > > >  	refcount_inc(&idev->obj.users);
> > > > >  	/* group refcount moves into iommufd_device */
> > > > > -	idev->group =3D group;
> > > > > +	idev->igroup =3D igroup;
> > > >
> > > > the comment about group refcount is stale now.
> > >
> > > You mean it should say 'igroup refcount' ?
> > >
> >
> > The original comment refers to the refcnt of iommu group.
> >
> > Now that refcnt is held by iommufd_group and no movement per se.
>=20
> igroup has a reference as well and it is this reference that is now
> being moved
>=20

oh, yes.
