Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3037662068C
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 03:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiKHCRv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 21:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbiKHCRe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 21:17:34 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA1B29832;
        Mon,  7 Nov 2022 18:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667873851; x=1699409851;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=esWn/xuktYF9JsjPizp4PEWQBDfaCpjDYiZY4dMbnrk=;
  b=j/JrSXlpgvIUmNV5wSyE/6Q8Gh01afNENFBvOg3obuBlmuRCvmXu0gqQ
   JY1UjCDwcOA4cfTnCx2dEkPetNwf6ioJDIfl/y1CxhjJmWGKvASLV3YRu
   E3I1bZIvwOl48P5VCgS83ri1kYb/GJSfCCxQByeX8CgoNbvMjEWTGahw9
   o3OKy2NcCPxU2TDTyiHKZFjVxtJYqTf/oo5euwSREIyP8ADvJ3uPQ85tB
   kS7AitEmkM+PBYPd0JMKhtHD7M8evlUlgYCWTVEBKyP+SbFEso7TI/i6J
   4k6J8ho0BBi0BwviHuPp95oZdonw449pJ2RN3sCi9P1IN6joJvb0olwvh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="293949115"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="293949115"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 18:17:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="667410429"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="667410429"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 07 Nov 2022 18:17:30 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 18:17:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 18:17:30 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 18:17:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cliIQFU5h1sYueHiv5z/jv/1/jX9JYXFNHYu28npVfw18zh/ryjJOnjN+llcyyZK15Qy12sDrltN8r4dsCPBvna9cBT3gZma8cS3LfbSWr8LgYQw/5dHqnQSnW+9KeefU+9q0IQ9NVEXO8U3kmZjoF96D8RfH5NfbUfQbTvUA9gUpVkSkp4JeVEqZKHpeXOMdjeMeCRJgAeEOJ8bz6LiAXFM7KUC76n1j3sXK3ErlryltC1FdMGbGukY6TrgMtzFxmPdQZHd6cjvWWSyzJpa/inHYfjNbTqLxz7sRqYbzpp5/vRLBxHFpH1yvGcdnv+ODMeKOcjc0x/Lj1PKtL1/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mpfal6LkIIYJn6ho9PgUQINq8dTZAi97pqPyDzAFkhQ=;
 b=bzKFU6RbhxGE61FZbCqElCy/nUVjiztLU11H9bkS2rgp3Vv45F867R+7GbQNNmKf664A69Vq7iRPPPT58TL/4it4BMj6j+FTPnSEnOyXFDLMSrhHMdCpO4fDBnjpsctLmkLQv65/4GOMgTfdQerkQmBo+bX4Oos4qNfjJxZ7Eti5VqFFUUfOtXH5TMtLbqa3Dn1dY5N9U8KT5w9XmKmn+UEp3BKByTfJLQBafA6OfJpJmaGqgeq8u2Zf9uGKRPeJRN65Q8zWqcaqVkAEjBHE6R4ya9/wvfYvg6oEEsdEXaOiFHERnfhPL+ZgNRkOmls71UyvicVJC32Q6srPPs9oBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7108.namprd11.prod.outlook.com (2603:10b6:930:50::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 02:17:28 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 02:17:28 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
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
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
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
Subject: RE: [PATCH v3 12/15] iommufd: Add kAPI toward external drivers for
 physical devices
Thread-Topic: [PATCH v3 12/15] iommufd: Add kAPI toward external drivers for
 physical devices
Thread-Index: AQHY6J1oarnsuDEKTkWD4LgWN5EHf64vnT0AgAQ1jgCAAIvswA==
Date:   Tue, 8 Nov 2022 02:17:28 +0000
Message-ID: <BN9PR11MB5276A1D1C32CA9F70A2BE80C8C3F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <12-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <BN9PR11MB527617D35DE59BD0EF10F7098C3A9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y2lGYkO9X0neQTP5@nvidia.com>
In-Reply-To: <Y2lGYkO9X0neQTP5@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7108:EE_
x-ms-office365-filtering-correlation-id: 9e1cea1c-ec2a-4bbb-6a4b-08dac12f627e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /mhiFPGQzSNwEOUMmWShzZTrU59ZhgpU7B4gXwdZtJbJzEnxLE+QM7UGcdMQVWCMPMX+w6g+2bil7qR5HDwQIauGOXcTKsPSGpZaDKciSDcUimr9PGyQm3NqLVSQKfYTpkehS5ZElKtJqL0m+vUg4MM6+2BzmNsqIwQZ/JXQr3a0ohQ2rA2UjoWrb6CS9qpU4E8umctqtx2G+OnG6nLKW12dkZr09qlhowJJDdqokGm9hwKwKihMct3dfQ/Q/AVskIn1NbORwZxa1ff7xiXVHhw6z+irGj3y4StKx/X6mCw2WCd318/VNaBmEoXHQ/ek1Pb8iY+s1HvrWMCtW6eYH9Kvm6xX3LPkfDKeZ4Rgtkv9uBHAHwoxLFirRvAQjg8mMUL8JL5E+6F4avR3d8HYzG9nDeauDQqxmkkZ0bI7FwYzAVZkisDxfnjWy8Mcsk2oKUHMquRVRkN4rw0b/cMBeCwd7GsdiV2/h0ggOEQYoYtN81wGRmHZ3kwJ+TQnk5TyC5skcH7lKQUWdFJ6MQLazqE9kAhN8704kSDLPidcYNkP9pxWKvtYHKFXQwWRkRGWMt0TZAx4iqWhd0qEqCA5r/oIBC0NH7o4r4aT3viCff83Z56AGmgbXk2IiHKEldU/hgKbzKGM0XZyHbgzttNI6IzQ3sQyb56osJHaHFqZTPyeY3SVLt/wL0PTUQO5mZC/anad6S+Pku1ebosBGG9ctltVddqXHsD1GfPF5L5Z3JQ+mxsK8Sobp66qEy/C2xi1qb+5x7YzWtj1OqQZ8ReMxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199015)(71200400001)(2906002)(55016003)(110136005)(54906003)(316002)(478600001)(9686003)(66556008)(66476007)(76116006)(66946007)(7406005)(52536014)(4744005)(5660300002)(7416002)(186003)(7696005)(8676002)(8936002)(4326008)(66446008)(64756008)(6506007)(26005)(82960400001)(83380400001)(33656002)(41300700001)(122000001)(38100700002)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wru0L6i8tgTn5LuWX3/2rdVEG/nmxkDNBheQCdO3IIT2Zh5wCMoeSsYWwYK5?=
 =?us-ascii?Q?hFNyajKkCfseyNVsjJCc0bsXg3RQgHWLtTHZ6qTo+VLkXLTJS6+XhHwFYucI?=
 =?us-ascii?Q?zeXHWqYXw9CjLa0lA1463tUSGcBSGKd5kDqsfV61Rq4EMsiUKWeA5+GkCyeC?=
 =?us-ascii?Q?Qiro7Hz5atuL83N5SvMuxYEE6349y5V8GJeebS2H8uDQ5zL7LB/4lV2WmVgE?=
 =?us-ascii?Q?n2vv0jrW1Ta6KpZ5AzbL+EOdhmwuW37257IJ67ap9cANlhLcIDqDB2t7REFW?=
 =?us-ascii?Q?8SRQmbz3HRZ6NXIzR94/PiPKugP2wRIK4oMi+yhqRhex/McvUaK9a1fV5DA8?=
 =?us-ascii?Q?/MgJyJzL5YlWcC9QqQJps7h2+I1JsTxjw4B7sguwNeR72xg+X5SXmk/fV1Nq?=
 =?us-ascii?Q?Z/C7GIkiK38pekDkn1cJbocSKLse4BBmqws81ocyZU1MAzuhaWCe690ylYe+?=
 =?us-ascii?Q?kJzY6gxMxztPwzdQvuZWUPMXNvzj+9C9HNKfqpaXzOO+CG63Z2XljiTmtfj0?=
 =?us-ascii?Q?G4yMOHOaO41x4MFYUpG3CO/1Yuf+EV0yjWDUGvr8YYNZTxqjeCnQxuDP3NBF?=
 =?us-ascii?Q?heLBMyh73IwOtOM/h+vz9HcQhF36VHrIVCcS/D1LntPENKwq42UXzo+UvffR?=
 =?us-ascii?Q?sMKNYYRjosw7OeAKr2Zf2FNnyMAVxp9tuNJmEp5F3tbFKf5/TJEis1b9DZYy?=
 =?us-ascii?Q?Q24A9Dphbim9Tc+6HPl7CRiRIkYeLHQKAwQIYZEl+ejYaUfsisz1D/n8lf2f?=
 =?us-ascii?Q?IogU9z/G3KoK97NcgYZKoUpKE+VdoMo8zy1OW1eRXOQzdgV3JoOhoR8Nmfus?=
 =?us-ascii?Q?rQhQ/P5IPCZrFW8NEyV63uAdT0sWGBllJcd2WZ4kHmKhNm+uvIebGRcXWPvT?=
 =?us-ascii?Q?EBcNYB+KF7JSYnfjv73fIa0oaI6nsn6wpFhlroESEmK772Mm5pLcPAJyViJO?=
 =?us-ascii?Q?LJuYRJZlLSZ/FpmhSDAHu89HA1nEHX1nqeESmjMpFFRQIV3bASt5eVl5Lvgr?=
 =?us-ascii?Q?0JvU8LUkk+cue+MaXyKqgN4XX4eNT5YZX4lXcecQYSvzRYrM+1XGDoYDKHty?=
 =?us-ascii?Q?Tr34xour+IMZqGMm2P7zFK0mzNPInsfcsyMmzChhdfeDKsLlCGydpWX+l/D5?=
 =?us-ascii?Q?Cjp3eOibtjLoGa67x/ouaJuCeGq25xQ6cnXi96A49w5usD1f2sdvm6T+FCLO?=
 =?us-ascii?Q?dwlpGCXBrauXr6LWDeBiopWLUoeTrUDBooKjN0zwYZ9cwYIDWfqsfJSqevwk?=
 =?us-ascii?Q?CnexljIeG8IRH3nzRFuvvpq1kf5Yi7ibt79ttBn/5daWQX+Lg+DzJC/8ga8f?=
 =?us-ascii?Q?rfgM6NK9KUA/W8k3Rc3zWeJgSyymYiaWmPfeKAmxsyk2SbR2JvCmV7tYZv2D?=
 =?us-ascii?Q?HR3e8dcZj1PbXNmxiieGrvF9dz+PP9oeEM8FjmkiIdOuvqiLff3Rja7g8JZQ?=
 =?us-ascii?Q?zRYIdcBeTCX//K5pIiK1suy26XSWj0E9ZNLFJ1aj9wX0F22uS+IPBvJz1gMg?=
 =?us-ascii?Q?tgW/i/k8Xn737+gIdpAxkXkD6PdmRnw/xYrouxr4z5+PdTk8MDpLiwQ2cYzP?=
 =?us-ascii?Q?pRQbz8Vu393lPPWXC2DD+K7LPaVRSplkuW2yk9tr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1cea1c-ec2a-4bbb-6a4b-08dac12f627e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 02:17:28.6265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /XI2dkatDRDA8vMNKcAZpraohgvGq8FZIRD5qe9xrUP5uUH34uSohBpA0UQjAwp2OCsJOZh+7q7GqCRqZb1O6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7108
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Alex, is any trick behind checking -ENODEV overlooked here?

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, November 8, 2022 1:55 AM
> >
> > > +		rc =3D iommu_get_msi_cookie(hwpt->domain, sw_msi_start);
> > > +		if (rc && rc !=3D -ENODEV)
> > > +			return rc;
> >
> > I know this is copied from VFIO but a comment is appreciated why
> > -ENODEV is considered sane to move forward.
>=20
> Huh. I actually don't know. It looks like it is here to detect that
> the static inline for !CONFIG_IOMMU_DMA returns it.
>=20
> However, if we have !CONFIG_IOMMU_DMA then I think we also don't get
> interrupts at all. Ie iommu_dma_prepare_msi() becomes a NOP and
> nothing will map the ITS page into the iomm_domain.
>=20
> So let's drop the ENODEV check, it looks wrong.
>=20

