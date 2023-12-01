Return-Path: <linux-kselftest+bounces-932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191518002F5
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 06:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3791C20A85
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 05:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFA279EC;
	Fri,  1 Dec 2023 05:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+CmbapF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF8210FC;
	Thu, 30 Nov 2023 21:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701407958; x=1732943958;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5D4sYBMTjB5R5OaNXv4qTW184DtnR6MKXDXExqGSeBo=;
  b=P+CmbapFsWNIZ0ofgJpxXo3uLaTRAB1FB2S0EmyUWgy3DR+AyTQE0jJf
   xGYUlKVEMKak3CKkfnPqOD0gr2FMatnjfCaufQURqV/nuOaglq7lhzGhW
   QLSvJSURXYeJnGVs4iZBeIBqZLadMlMlIeLHB6QG7lsn+X52AC9gMF3vU
   mxtVrN9v8rdANlRZ2W/t9rNdOD4s+VmgZwu9wOw7go0RYEN0iPMKuFj5L
   GXQOnfIc/O4KjTlMAxbIfmJsLpw/WT/XzNoFuldrA0LiKJFlyK0xc9UCt
   Z9ltwKyQkHBoOQEhDAt39B6sVqX0jKuWmSPK/vpfBF4ldmgOuc5KkOk03
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="449214"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="449214"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 21:19:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="840050564"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="840050564"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 21:19:17 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 21:19:16 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 21:19:16 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 21:19:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuleB4n+rID2XvSyulbxwFmrB1LJHKRzUJjI5mPvUQPuhPpCyNaHLHU8/5XjBAHQKydi6iNVat2lBcTedpHo6b3qghnrgKES0P/IxvIJ5LyJbE4CsDXxUgOcZiUCfZVwYi3gPd3q/t7gKPbpKcPcf/N/hTvkR8BS7IC2hOTYOXYztJgrfmUIG75gyYkLcfXTeEzDth+qcuEjK1mFuI6maWqhIHlisix7exLyeDONwIu5uzbhGc35VFTloJ8hdYCTrjDj8goITEjkR1jY7wGRwToJle2e3QyhdgzDhd4ZSok8eaPdfdb5NWDr/nngE5tnUrLBXWnuZrT5BCYmJdA5+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5D4sYBMTjB5R5OaNXv4qTW184DtnR6MKXDXExqGSeBo=;
 b=M67rQqMvn5R5qJtzstxgOhmFlOaiDC+3obp9kxfDLVx4gCpZM8hT0uuKZquVahgpG2Ov67DimUZQGHQQVdEVf0ddxIptcbt6DjMfAVYwb4st08LHC7bNTM7SA+rR5O0zqg/78U8E+grI+CCeZkGkb/7N7qsA2Dp+01eK32buBxNc05+upGUenb9g5ESIgKZka0zuoVfcVdh3kr5i9/BdqJQXpI2bzHcYJVM7MiiYqtdH4SBttOarVS9rkc64YNADUmvK7idA1JoG0PSdSOO+/0oEX/w/KV0Y9yyHd3qunDEp289n7zY9uInPhTA4eg2vPqa8fD+sSMf29gPrhD+08w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5182.namprd11.prod.outlook.com (2603:10b6:a03:2ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Fri, 1 Dec
 2023 05:19:14 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 05:19:14 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
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
Thread-Index: AQHaGVcJ4nFLu64FV02Qq9BjVpwSvbCC3axQgAAHEwCAAAD1wIAAl++AgACaJQCAACuAgIAEgqsQgAXeCQCAAMsJ8IABGqOAgAABpoCAA1VUAIAAEHmAgAADm8A=
Date: Fri, 1 Dec 2023 05:19:13 +0000
Message-ID: <BN9PR11MB52761168800700D7131D601D8C81A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <BN9PR11MB527659462CCB7280055858D98CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVuZOYFzAaCuJjXZ@Asurada-Nvidia>
 <BN9PR11MB5276C8EACE2C300A646EA8A18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVw/BXxgGCuCZCA6@Asurada-Nvidia>
 <BN9PR11MB52761A9B48A25E89BEECE6308CB8A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWTzoBTDDEWAKMs9@Asurada-Nvidia>
 <BN9PR11MB5276FD60A0EDF8E3F231FCC88CBCA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWaLCSAMIOXTlghk@Asurada-Nvidia> <20231129005715.GS436702@nvidia.com>
 <b5f86fde-eaec-47fc-8b4f-36adb0e9e1a1@intel.com>
 <ZWlmD1KDUyR3qzdy@Asurada-Nvidia>
In-Reply-To: <ZWlmD1KDUyR3qzdy@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5182:EE_
x-ms-office365-filtering-correlation-id: 20cfe8c0-df61-474b-8e9b-08dbf22d0ee7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SZVj7/FgxPiforkwSaUDhR1nITA7fjhgcOV5hchU5Jd1l4jiV+ulOuHW1RrYkZx9iFclc8rlhdqkDwPtgIYALZoOUakm66p0s1R4V0f5yCmDjWLA5XS+S5fSCuDU9+PwT0TDFpRjnHIQHkgZEW4k2PSD0IhzznJsP0OyeKj694SbJ6v2+QMYKapOlEjIerNSAgh0YTqnK9KITVKxy5FesEKUj+SnZ7/WWcC7Fhtbxt1vOgeI0xHVrmtuFC+mV3lrAajDuqMBhriNci1n2m6lRa+LQbi8nWSrUrgLeGWkSIKhBoARWKOMcXaoK8QXUNOXhS3E1wibyUAQJWYDKqx71SVtZ19FAUbTyNN4PhlWW9V8XLOqWdgkk7sjLBfdGswS4V83KWIH+fHMhNY9GTEEdhDaAbqKoY2acduE3kDbnsmdVlhoZfdjIYNdtfq29AQLu/AF6yjqZV3JgDZS/PHrpU68pYJG/sVpnGo7FUpchYugve/CVsPpmVcZfNazkEDu5v3Um/4heupxUl819vCpqbDEY16z0sMCuGkpITPORrzEJ2NUE0QqZjrVd2rPc6aGaPhd8GdsYob5cYwWBsEo0bI5wF0QR+0FpUdKerCCtlNLVh0UrS8AzAqai5DSeazs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(55016003)(9686003)(71200400001)(26005)(478600001)(82960400001)(38100700002)(86362001)(122000001)(33656002)(38070700009)(83380400001)(6636002)(41300700001)(52536014)(66476007)(7416002)(6506007)(76116006)(4326008)(7696005)(66556008)(54906003)(64756008)(2906002)(66446008)(316002)(8676002)(110136005)(53546011)(66946007)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8+nZQNjGDS1N74aBa6xBP+h01e0swZiTF6H8hwoVjLFnabsKr4ZQyKz6s/3b?=
 =?us-ascii?Q?DM0ck//RZHdMxqXxeOnLtamZOdwOzUCHP0vdIOKiLj6PeCNnYr8xB7NnJiNQ?=
 =?us-ascii?Q?xw9GT5MQ5NsAS8AlpIaeBcm4iFCKlH2ZWaGhBJO8VZqlQsCW1w2I87dLR0ky?=
 =?us-ascii?Q?cybdJ68s/EnAmEcGBlHXgFRB7+dFdSnyrepOnlPra9PCnCy7iwQCvdoKyXC5?=
 =?us-ascii?Q?abj/RxjN2M78+fypqzG/Iq8/83UZzB+fYYguFo1fye4jJrz02a7On2owWzNj?=
 =?us-ascii?Q?Zc+gXc+QQnF8MuQs/8iJDpFXU8yD4rB53qNakLpcIlDT39PGi1pFnBc5IMTO?=
 =?us-ascii?Q?Zc6Cksi/tDFsDDAkS5Z3aW1puWjMwnOiSN3pHZdyq+iPSO9hqpKrdzWVz/fP?=
 =?us-ascii?Q?xxwzKfHrAnZVl97Gup75fu41vghnH5iDBaiBcLHhzuqbZHCGgcptrNQzGYKg?=
 =?us-ascii?Q?muSw5VwXgX/A74a4bfWdOBnNvs/Obrys/5sQ6bYeJJVIDsSmew5N5Ip6niGH?=
 =?us-ascii?Q?jDUtgpsW4XdvMpya5Mu46r7lpjIamJcVSnRahb1TvIXvcznzf+MzgBxfq8Ag?=
 =?us-ascii?Q?MDRQT4c2XytwrK+LQjg8jA+ceuz2Qzjge39JuUpt+GkfkapY6xPeF7EeSx6R?=
 =?us-ascii?Q?7op2JVF7hK0LU/TtUDhDwe/9jhii3mfTo9nw9rGyNSd1JACHS64DVJlNV42K?=
 =?us-ascii?Q?RKjp4VGiTDiTb9NFXux9MnqlRQBXUhKR/eNU+3BBfoXlPpI2D+MgmufUAgqc?=
 =?us-ascii?Q?L9gQOMnpyNt09SZsNVefbHR2nRP219asANtTYNyFCavo7YlDO6TD1zCHpYKv?=
 =?us-ascii?Q?oo9WC9BjqNncMgkVyMBfw+WKLV6QIf4hboOxy3S+qjjE11XUyQeHbR8L/PR0?=
 =?us-ascii?Q?SzhQLfVMkNXCUhPKV7TArW8wYSc2TkxVPTErvGZ3fyndjwsvnSxu5ti/x58p?=
 =?us-ascii?Q?sA6NePXy5IAhyNsi9PMhNTfdOy2YeKUVNxG19Eeqvy3PV2WSe1+/uK0YGq1X?=
 =?us-ascii?Q?vaFVXtineYbZiawEMdG49m8LnF17lJO7ULguLE0tX7dZF/VDYbJdeia4IUcg?=
 =?us-ascii?Q?L5sre7LI45Zz01ykKsOdHW+SYiGUYHYyNP/pEPRUFWvU6yL/q7vKqz5HnD52?=
 =?us-ascii?Q?upyrgM7zexSOOhFu9IxFSlyU9qKV2r2Xrv40agbcl9+NO+iyzuujyfK7Oh01?=
 =?us-ascii?Q?EOsFpbSG/vzgk4pJdzHwdPQk6Fa4Zea02BsBwh+9R+hKkwrSgn6SDY0QCLtM?=
 =?us-ascii?Q?xNAi+L+MXjH55CNFfOSHLxXCAgI7EOjzli4j5y3epiZ66VYW2cWRG16t//wv?=
 =?us-ascii?Q?ZcUezfPDzVb/li2vhDv1LMKZkNQAbE5Mf4eMPQgTiwA8VwbuH9NYT5TWzm8Y?=
 =?us-ascii?Q?CEPUfcGQ/s8YxF28o+REplmGrWwAJIXseZGjBh2tqdnnDcK9IsI7ULOLHRLA?=
 =?us-ascii?Q?LQRirWBXq/wTHxYKcTmhTS4Wb2icJg+oykErpvksmgP3UCjolbGqD484Nuyg?=
 =?us-ascii?Q?JXfJwhZDOVc36qwXhUrz7iqQjTseg5kEUXhFtkh5aPGafK4s7d0N88xTS3yk?=
 =?us-ascii?Q?M0Kw4IvTS/N8j/PhoE2dyQ2y0TwxyVh93tTm6brj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20cfe8c0-df61-474b-8e9b-08dbf22d0ee7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 05:19:13.9966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c7h4ZTrsLRFZLG7fQ4P5/I362kURiJfuLlPnE2VYpc85F9rrMImKE00PT1mU2xmOwe36OPiYSY+FrS+FmU0Uww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5182
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, December 1, 2023 12:50 PM
>=20
> On Fri, Dec 01, 2023 at 11:51:26AM +0800, Yi Liu wrote:
> > On 2023/11/29 08:57, Jason Gunthorpe wrote:
> > > On Tue, Nov 28, 2023 at 04:51:21PM -0800, Nicolin Chen wrote:
> > > > > > I also thought about making this out_driver_error_code per HW.
> > > > > > Yet, an error can be either per array or per entry/quest. The
> > > > > > array-related error should be reported in the array structure
> > > > > > that is a core uAPI, v.s. the per-HW entry structure. Though
> > > > > > we could still report an array error in the entry structure
> > > > > > at the first entry (or indexed by "array->entry_num")?
> > > > > >
> > > > >
> > > > > why would there be an array error? array is just a software
> > > > > entity containing actual HW invalidation cmds. If there is
> > > > > any error with the array itself it should be reported via
> > > > > ioctl errno.
> > > >
> > > > User array reading is a software operation, but kernel array
> > > > reading is a hardware operation that can raise an error when
> > > > the memory location to the array is incorrect or so.
> > >
> > > Well, we shouldn't get into a situation like that.. By the time the H=
W
> > > got the address it should be valid.
> > >
> > > > With that being said, I think errno (-EIO) could do the job,
> > > > as you suggested too.
> > >
> > > Do we have any idea what HW failures can be generated by the
> commands
> > > this will execture? IIRC I don't remember seeing any smmu specific
> > > codes related to invalid invalidation? Everything is a valid input?
> > >
> > > Can vt-d fail single commands? What about AMD?
> >
> > Intel VT-d side, after each invalidation request, there is a wait
> > descriptor which either provide an interrupt or an address for the
> > hw to notify software the request before the wait descriptor has been
> > completed. While, if there is error happened on the invalidation reques=
t,
> > a flag (IQE, ICE, ITE) would be set in the Fault Status Register, and s=
ome
> > detailed information would be recorded in the Invalidation Queue Error
> > Record Register. So an invalidation request may be failed with some err=
or
> > reported. If no error, will return completion via the wait descriptor. =
Is
> > this what you mean by "fail a single command"?
>=20
> I see the current VT-d series marking those as "REVISIT". How
> will it report an error to the user space from those register?
>=20
> Are they global status registers so that it might be difficult
> to direct the error to the nested domain for an event fd?
>=20

They are global registers but invalidation queue is also the global
resource. intel-iommu driver polls the status register after queueing
new invalidation descriptors. The submission is serialized.

If the error is related to a descriptor itself (e.g. format issue) then
the head register points to the problematic descriptor so software
can direct it to the related domain.

If the error is related to device tlb invalidation (e.g. timeout) there
is no way to associate the error with a specific descriptor by current
spec. But intel-iommu driver batches descriptors per domain so
we can still direct the error to the nested domain.

But I don't see the need of doing it via eventfd.

The poll semantics in intel-iommu driver is essentially a sync model.
vt-d spec does allow software to optionally enable notification upon
those errors but it's not used so far.

With that I still prefer to having driver-specific error code defined
in the entry. If ARM is an event-driven model then we can define
that field at least in vtd specific data structure.

btw given vtd doesn't use native format in uAPI it doesn't make
sense to forward descriptor formatting errors back to userspace.
Those, if happen, are driver's own problem. intel-iommu driver
should verify the uAPI structure and return -EINVAL or proper
errno to userspace purely in software.

With that Yi please just define error codes for device tlb related
errors for vtd.

Thanks
Kevin

