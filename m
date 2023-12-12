Return-Path: <linux-kselftest+bounces-1672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D13CB80EDEC
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 14:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C12F1F21661
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 13:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857106DD02;
	Tue, 12 Dec 2023 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4eEOxO9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0024783;
	Tue, 12 Dec 2023 05:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702388721; x=1733924721;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XDnSvwHG6DzPrPwLmkarrwCh/b3pcA40M/AKJcEoZgc=;
  b=E4eEOxO9r6tvxiqXHv6d1c8z9/RqORUNffehT+zKnr7vPIQgTrHS9+p+
   IA+CRttMJempfujQiGSVwpmpoSosPjA/oelZxdagbuTUO/PCG48Roqk2x
   RWI10RTDVZrPFuuQI9xRkVAiTDlhJ6/63OinatsPfnlmPcVrd6jOVdpyp
   EWDQ+5h9Xp8N0k2IiEsfOBfzAlA4X0ssK0xOr45GOdnoCCvrVmZSDkDuv
   mp/rEaqdfVGGD92yLYs9dP7vvrUr/F7Q5NBOlApHVvn+lpITxbihGuhUJ
   5w3pXM2k/Beoax59dmfiZKXTZYTUfUT03gVA0uJBApJz0xQCFOyuwG8yN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="461281743"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="461281743"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 05:45:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="917291222"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="917291222"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 05:45:19 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 05:45:19 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 05:45:19 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 05:45:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oInTgK5Ggk4U0KftlwB4hZIXs2MUsucgeeN3XtqFaFRSLMyG7qAF0JO2WwMsY9CWu10gLAEkeKj79k/I74vLIyATNSWEOCCq8kJZzGPjPjjwj5dvHfAA1t64eYPM4XIDZ4irA/ACHPYN1qHGf6Q1jpvEPYjqMdHO7Jj0p4+sdJ6obQPSb42ZH5sRggP27Ei7Y7P9v0IpktaFXmqaTBzZAUvEqoYoV5w8kpQIv6b5BDoJwWx3amBnZvbQoAwLCyeii40Oa+Ju1SLswvw+6q3bQWPxM7UPwRo/DG7Oh5hBw7HXT/34Vc31FKTt1tfqpXmBbD+rjWupd4cb+V8ZTzxK4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1ytdPgqMoNVXYVLA9up4cIXM1DWcFumzH6IbPB3DxA=;
 b=U4dXlRtV/Eo9oErk09tc+pRJk991Z+jliPQnGM9Zeso4tWx4q/Co5cEbUVORtjkiNgrAbsCD2bdL6VO/b2CpG/eDBl+cTmXBWv1CxHZ8i7dOTpokxt9KxNazNq6CzGUhnn827W4XlWPie3al2+evuqMc8l5+TpjCoV0dS+AxMVLDA2q5gy0fn8Phxb6HSEJBxQbNNjcDUqaRYOVOrQAnFivIY0mdAJluq53s/BGfNe55bL0qLwGVlOmJL0UGELwLMq/h2vtYPWcO7oPdehCgZffPaiAdHzghXwsKF5nifroN7w5ELS197PK01xOSL7EXgrRbCIe5343Kfj3nTrggsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA2PR11MB4828.namprd11.prod.outlook.com (2603:10b6:806:110::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 13:45:17 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 13:45:16 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
Subject: RE: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Thread-Topic: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Thread-Index: AQHaGVcJJtyCzgqkgkqBUoie7tgMvbCdgxuAgAAi2QCAAF55AIAF1zMAgABbn4CAAZh0MA==
Date: Tue, 12 Dec 2023 13:45:16 +0000
Message-ID: <DS0PR11MB7529AA3F28F4418A80D869B0C38EA@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-3-yi.l.liu@intel.com>
 <112383df-3ea3-475f-963f-5c53232a1bf4@intel.com>
 <BN9PR11MB5276283CAEAB7A24871B4B188C8BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231207144208.GJ2692119@nvidia.com>
 <8c05763d-1668-4b99-af35-b43a34e966c2@intel.com>
 <20231211132135.GF2944114@nvidia.com>
In-Reply-To: <20231211132135.GF2944114@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|SA2PR11MB4828:EE_
x-ms-office365-filtering-correlation-id: ff048ec0-e6a1-4908-5507-08dbfb189314
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ejw3cH9MWbfEBbSuLpF7hQs826vcsjZRo0PGW+MQEJ8P0vaQ2IJm9yd4nfVTr6YxIh/t5l9wX7cla+nGr8YzzrlrgW3d8F8OIhtkSIhRlV28n8rqMc+EGKCNVfvVYtBm61xd9qFruA1u9EpRFKlwkW6phlFvUApPFGs5smjoFcIIeMzSgh/RrXigVGSv3guyBp4Olkftk3Gi9uGb4KbjRGJCyJmukrODOTBYQ3oqlwHjli+huQ76boVhjG4TtWYdcIMCLdfZmAW+O9cH3PIPaBqv+Ts/TusHPsWmaZRE1tohtwwM6MX82dGP1oMhY81xBQoLwtRxB+S+3jA+qsaQ+fNWB5xvYTme4C2kPViKpISmbRx8PS+kmUEN6c34+gj4oWhAUhzxopdv/bZkJDj3iBpQWk+owRJGFdPdw4pSqNoFJZJJKhg5jyXvjpF6RQmAEvP4fUrrxsBnnlP30JlMq8x4P3cmkJUvM9CdP7GMHl5+AVKP3daVfRPaFV5MmjzSJw5SJG7DncoeBBJV9n4kETM1DOJb6aJzQBbyOYY4BLy/+saBZvNGQLEuJhIM9Z7VPUQMxpSxaIkniB7sZirb20NN15gelxZpNJnXvyu6MIvtQtOdMQ6y0fOqwdE8lX1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(38070700009)(5660300002)(7416002)(2906002)(6506007)(9686003)(26005)(71200400001)(7696005)(478600001)(55016003)(122000001)(38100700002)(82960400001)(8936002)(4326008)(54906003)(64756008)(66556008)(86362001)(33656002)(316002)(8676002)(6916009)(66446008)(66946007)(66476007)(76116006)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HuLu+f93dK6JQr1d5D1f670XXerXD56mzBQPtuPlLQwwFLHHJVSgHbmBvfmF?=
 =?us-ascii?Q?U9KMArfT1tPsIX6zc516OLctccW/MZ4WnI7Ji9tqQFths8DtCPZ4s4sOhTwi?=
 =?us-ascii?Q?EACCcrCps/scacupu9p2haZA1uXzB6Ok2xNM3CQigjWhYKccgR/0E2sJagpt?=
 =?us-ascii?Q?i2mw1HMED6RF+2IjuYgGyMGLy3P8RZZ0oKtlXpOgF37Yk4l+RgdWQHsHEtwF?=
 =?us-ascii?Q?59n7EV2zbGsZokPxsm19iX0Q1ZIjGkQpy4FdqYaBUVKnA0zOZsi4vljc9sDW?=
 =?us-ascii?Q?8y/Yg6C+AGPGiUw6Ga1MA0AWrsUyx3I2LP8wmw5LhIduhSNvRgGKjcGsWYOa?=
 =?us-ascii?Q?n40xlwHavgjjZ9uySYa+IRinHDdVim6mTMuQbh5UML8zX5cWGYl8Xm5Y21Ha?=
 =?us-ascii?Q?qzVHG93OmhU3mrNk6V0QLF/x9Ip8nRWtyRZunOu1XwxKKqTGcvdgnBzEilih?=
 =?us-ascii?Q?Q/jv2ueevQRynxA3nOiZXSJ82Eg7msugpFTzlKYD/i9I8y+tyEqPRBWzA9kc?=
 =?us-ascii?Q?AC8Ibaz7o32rbd8+W8eqM0HtHEmhU4raAfzMT+H4acZl3x6RsbWZ8uJB3NVK?=
 =?us-ascii?Q?eQgVzncPXnWn1URjMiwB3QAXQYzCgvyjPo+cWd/QSTrHAD+gxeGelRXJ/X5/?=
 =?us-ascii?Q?i3pRL4QUAI76+RMy/5Bfr2zk6H13kkFmvQWk45UDO8GYGAE7sPo3544kj2KI?=
 =?us-ascii?Q?jRJyG4H3tGquRL26ybDFDDZPA+zPvsD15ZWIgiqbAVoSPR+r/qFoAJuRwqGZ?=
 =?us-ascii?Q?dUrmrFVVM1zeaRYk8eEEluDb31Lr3QG8Ug1vNsEJ7BxJYC+2NR4WiU6HILbb?=
 =?us-ascii?Q?nieMP+FdQMUFckGEEwVuGZwWqedMEQn0V/y2XK/bmL11Yxmcq4r0GepQX1Tf?=
 =?us-ascii?Q?FLfpVoGz8L9V4m5N7Id/4H7Jb84H16FtQvizw9pakMYv7kt2/qAcyR+d9Rxg?=
 =?us-ascii?Q?k8/QA96GaPz8fNM4ujSd43OzrboLITs7I4FnMnTipVWvOaT/W0cF3WCduJ0o?=
 =?us-ascii?Q?t13GglhxLpiZTR4Mug/CLDZJsSk5zVRLxH+y8DjmOQQyF72xQSV+OYbrs7Ct?=
 =?us-ascii?Q?z62mSUAFxHtcMpqdTz1yhAPDSWhCDjzuPO1q0I2k0z2S8aDRsjD6ABAJ1yX6?=
 =?us-ascii?Q?V5psNWT66QVwO6vlYJcyxk9OkZhON8OlMR195+bcUbq+JL0FyfotunpzioL/?=
 =?us-ascii?Q?DgarBkpvAnUqHJ/r5qjOz0yHWbZYvfmqmSeUkeKkqNYaEiHSYjdAerkU8TGH?=
 =?us-ascii?Q?CetxcXg3PSqUQvsGq14N31XDtEzAyejK1Z5zS06VncalMVCAvt4ZbWx+9QC6?=
 =?us-ascii?Q?ycOkrdgS9/8rLk6tioNAQosL68Z7gBFj1bmiXsT4Y2ilC1RofSdk0PR/1v9M?=
 =?us-ascii?Q?M/h90X+uk5Rn/zJ2zauywEd0BXWSBTEFShABbxASMiafMPVrQl2dwGvtEtvN?=
 =?us-ascii?Q?6Awbt+Nl3XIsJJ0BWd+manIuo9HfivMCUmqZoc2YPkKl2srD8fTcoCmguzIO?=
 =?us-ascii?Q?U1hjG1k45K1v6ySIG2Ujs2xFe9AJLNrWJ/o6v6IlxSjzEBnHyV8p6cuFGMyE?=
 =?us-ascii?Q?ZrG6wGShXJQP8ely2vWpv5nPcbX9L/3QX4qJy1We?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff048ec0-e6a1-4908-5507-08dbfb189314
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 13:45:16.7932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uPhy9wwPx+yTRYf0y2v8pCLTjRd0VIg6F9JXbyCTL9k3btbmM9sB2crP+qVeapLgGUnMNJR/tAVmMubDeLYVXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4828
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, December 11, 2023 9:22 PM
>=20
> On Mon, Dec 11, 2023 at 03:53:40PM +0800, Yi Liu wrote:
>=20
> > > >  From that thread Jason mentioned to make the invalidation format
> > > > part of domain allocation. If that is the direction to go then ther=
e
> > > > won't be multiple invalidation formats per hwpt. The user should
> > > > create multiple hwpt's per invalidation format (though mixing
> > > > formats in one virtual platform is very unlikely)?
> > >
> > > I think we could do either, but I have a vauge cleanness preference
> > > that the enums are just different? That would follow a pretty typical
> > > pattern for a structure tag to reflect the content of the structure.
> >
> > Is this still following the direction to make the invalidation format
> > part of domain allocation?
>=20
> I think you should make it seperate

Sure. I'll add a separate enum for cache invalidation format. Just to
see if it is good to pass down the invalidation format in the hwpt
alloc path? So iommu driver can check if the invalidation format
can be used for the hwpt to be allocated.

Regards,
Yi Liu

