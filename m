Return-Path: <linux-kselftest+bounces-2511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEA281FC9A
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Dec 2023 03:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76637B239C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Dec 2023 02:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2894517C4;
	Fri, 29 Dec 2023 02:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVqLiSNm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7C423DF;
	Fri, 29 Dec 2023 02:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703818371; x=1735354371;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gJn4+vKecDtjEsIKkKJqtHewg27WUoxPjM5iUhe+4LM=;
  b=WVqLiSNmP1UHhYGOQiz4Sim/Tt4TF5uMQH7OLa9u1pXs92+W/fExBku9
   Q3LHE9rrQt+3QLQut7mtXy8QSERtHEsMcUd4gDMMxWi9oFd2J+hp5ae4Y
   fvFix1aQG58T8iEOBq0Rw1+jVmUC2xVGrSu1I30e4Qq6fO6HWVHM5ckgz
   xO/ikKxyTQuE9FxhykdOp49nE1d87MV4WKAjYyoxk0/SqQ3T/sebmKhX8
   Q9IepKr10YJz+xt17ND7DgeEpDGPDX5tZgvJJtDIRcGmgliUbCmjTbVto
   nxhzXsrSderoVbm7x6mpiX9FmxvNot/8N6M0khEQNPn3PQTe7RJ5N7yHz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="3910073"
X-IronPort-AV: E=Sophos;i="6.04,313,1695711600"; 
   d="scan'208";a="3910073"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 18:52:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="897385841"
X-IronPort-AV: E=Sophos;i="6.04,313,1695711600"; 
   d="scan'208";a="897385841"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Dec 2023 18:52:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 18:52:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Dec 2023 18:52:48 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Dec 2023 18:52:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtyexUSI5gzemtPVZ0RltHPddufO3D+IzeAvpOadCmiK0pXw3vdl+FGW3ja6WXrT9fWZ0pk/GVZUuffessscqiF7uOu3gXdRlzsdIhHBl4QSz+M8m/TCVo4PhaFS6XmtaUHY84wCKDAw0ndDJ/n4LhqNa56T154O5ONrkU7LymtEE9mJcW6rwpkGhgvBpQPL0V/xtjeYqWF08q6wy5ak3Ml+EEHss9yBviOnhitnrY1lOcXoZOVYXPkvCfMPOeyYwakIdRf1JSyRnDCBr8RpAM2cmWJdcxLBLcE3P7WvPPW/PCGO36owZ+K6HsDphwI0QJMQ+X0ns6EnYJaGhBVz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zRCbQ80xpyHdapo2LerabgaaSPasaE5AcBhYa8whB4=;
 b=hR2AuzY3gqtXSpWP4vVN1/ikYv8+z1BjH1zZ2EQnv4HeIm+OgI8+szLe1HnebgQNiqXDZlz7/sou0CREwB2ksX9EEUcdnpGpR/ppHKXxFOhgcBIsbE9SfjyZ3ceJqARZlhF6J9RtiggO20cBeD/yEJuKX9WM5xnb8Zw1ucQP32Cwu9QGOvrQTnB5ser5mzam+y9k8Pk+Kz6c8YtAosrV+smbOBZvwJ8nURh/kmzhLBXNtkLy0lNnZYWy+2kGuL1CCRtMZ5IMTZPPBR42p5m6V3aNDWE3onpJRer1/qWFGITou8yzHB8JIDHagSkIV9sSq1vC2kcHKce4lLyedw77sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Fri, 29 Dec
 2023 02:52:45 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 02:52:45 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC: "cohuck@redhat.com" <cohuck@redhat.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "j.granados@samsung.com" <j.granados@samsung.com>
Subject: RE: [PATCH v9 07/10] iommu/vt-d: Allow qi_submit_sync() to return the
 QI faults
Thread-Topic: [PATCH v9 07/10] iommu/vt-d: Allow qi_submit_sync() to return
 the QI faults
Thread-Index: AQHaOZ99+qkqHFwLlEqW3QiqUnTcO7C/jljg
Date: Fri, 29 Dec 2023 02:52:45 +0000
Message-ID: <BN9PR11MB52768F21FE29A81060ACA4AE8C9DA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231228150629.13149-1-yi.l.liu@intel.com>
 <20231228150629.13149-8-yi.l.liu@intel.com>
In-Reply-To: <20231228150629.13149-8-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB7024:EE_
x-ms-office365-filtering-correlation-id: a313c46c-a66d-401d-0bd0-08dc08193c23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rgg4Qym+OdlN/JUfMaP89PZqU4cyVEzVBLagwvC0ZbJXs0AUmYVzr3nfV5/gqlBnmP/UxKhhx7gLEbaCx9HdiOZ1P5Z0oh3kJ34JLPyvVfSQQmalnruft5DzF1JOX9H159d7VXTeixCGZ/s0PmVlYkN690kBZAImEv+P0HZWLBNu4mGImdgPkOH9p2BjY4NgHN3ov1cIPuBT7TnPfGqZc90G+XfU8M5/x9tgay1YMuWYKMhR06vbuQZNYbhiQlzqwRVPTTQPzHIftM/N5DSY8yNTdglyRgUD26f4WeYg6/Ou0yO5RVfuFet8DWUyyPBzhV7MC05nzMGA6LaprNX9RcrwkC7XzNQ+VhvTfdIV/VrZGxW5uu/7E4E4Imym/p+OTGoB52Fn0filXt6mynVcUOr3MUSzT5rhKPStGwPAZfBour16yljr3NZOkjt+lxrF6d/A8+kKxtdSF1F8dWnu/CmqqJ0vjeRJxtvI4LnIKz0Gi5L2R1T4bfoU1rRVERM92SxZDsmxO3tPHQOMwvNvnJcxkBAdVlb1U+eT1eJtllh9mOob0jsE+ZrTqTC/zf0xHIcwu53SxnlLpUKFY+wp3zQXL0VxTZ5PG4C8ECf6VT4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(71200400001)(33656002)(82960400001)(478600001)(966005)(6506007)(9686003)(66556008)(110136005)(86362001)(41300700001)(64756008)(66476007)(66446008)(7696005)(54906003)(76116006)(316002)(66946007)(55016003)(38100700002)(8936002)(8676002)(2906002)(52536014)(122000001)(4326008)(38070700009)(5660300002)(26005)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bg4o0z4SG5B03P0msZQDprukq8y7LK8iQpNzzi3b0d/VhRK3t3G/p6xIBfKo?=
 =?us-ascii?Q?qnr442gulO1ll2ObEyCXkfkQFrLgzTdZWmFjsHW4lQbSd5Jmo5RGhb12/+ET?=
 =?us-ascii?Q?aMHU6ZSN1LMkOoJ44SRp8hFGQZmbaV9cLZl7WMKXlLCjLIFJ/+P4YG9AxBTu?=
 =?us-ascii?Q?Jx3WOEXKd/aoxAWTocPCf4VgpdUu+E65ZqdhK10O3Uns4iLWfyrCoALdFBzw?=
 =?us-ascii?Q?9Ra+NBH8sk/wVr4088gdaZHKIN1fchZCuMWyw8tppxlPmidYeNWl1tA2pP/4?=
 =?us-ascii?Q?CanpOF2YilAVDZKRAZ/C/u61ep+tdfqu3OvT7YaR5u7rcD8oltVCD9pL9f+3?=
 =?us-ascii?Q?5be2J45UVs4uwGxOnsbn+n/qltyW8BrlOwOoA8Pnegtj06BxNRjLlSyhxjPW?=
 =?us-ascii?Q?Af1MxyLhVoftzw8/7T45vqtGm062KXpfgdFLFyJghbA3T4jnE2iJgz/1AoM7?=
 =?us-ascii?Q?cJe8ufLI8/acMa86khDh1h2vT+ou4QtYPnty/EgiZCoz8+96UnXog6ddcZSu?=
 =?us-ascii?Q?2g9Qp5r8V6asQkZsKZMdaYKuYfSLe685NSr89LdXnb+rA73gjgys1tPlCOQL?=
 =?us-ascii?Q?d0fFh4r3vwqEt4cSlP1kqkfTxl3i5ehdUutkMiMmPypOBFgLVxqNu0MZGlz4?=
 =?us-ascii?Q?WlTEths8PKTOh/zAXJ05OdlyY61QQmtxATqWfs8ODxItVcfLcltUc8CE1/sU?=
 =?us-ascii?Q?sBza9yNRHu4VXR+swL0DPfafyKkC39otHXMMu5iC7vcTqSmqYE9wFMrPu3r0?=
 =?us-ascii?Q?3bUapI99/Gqqofso5mZMhWGCnhVjDguxZksPIzKs/aRtXyGrRyK9GmRR6UV7?=
 =?us-ascii?Q?huTz7/0rT4FB0mtgR9D3zcg/zDGcwZF2XcRNrWHPg3YFaBL8d9vzgBhAbIjX?=
 =?us-ascii?Q?r1OsIeZmzsINIXRuZXXpQKEaLmAtbQuq4kyaAUqGlhEL6hG/9isNWNieD01m?=
 =?us-ascii?Q?XoLOzkpiWr1NrPK4j7c9+kzXRwSVgbRFcyNDObTBdcduPMZyolH5h770Cybi?=
 =?us-ascii?Q?kL865tViGyFQ5BpApWPMd9iQo0p5miRvHNjIUoJRYTdKtxXHfM6+uNkyFzKH?=
 =?us-ascii?Q?MKBDzYLyC04hyy2InJ9WbyFmqDTRMHzN68Ba05VR8sSX72cbsBs6y5+pbGoY?=
 =?us-ascii?Q?/1Fd3q8jTOMiRMWxozNeNw8TDzoKQbt5yRda7VTUktr25+7ghyowKlGIZIXz?=
 =?us-ascii?Q?uBknQDTUXw0WpFcNDLmtEC06L8r/EBMApuz+uui8sRWguAddTde8OcWlRK/v?=
 =?us-ascii?Q?y3Zr4cngyDcyY8v32t0GN68uPlFoDfrJicIybjIAFmn7Drc6xzGnSoiLqiQb?=
 =?us-ascii?Q?fVXBx4gCzdRFIv5SBTA51L14ALBd8MG1DdZSOozpxHOurdBqZCVqosVjm5us?=
 =?us-ascii?Q?23wI6/3caHNvmmFihgBY0PRl7JWpg8Mf5tOMRW1ylD9LvCqqdOAXVDA03RWb?=
 =?us-ascii?Q?IvSr5c+tyQGLlUxIEIFpe88gK7oS+GCKFqD3aC53AAQZxfgl01+ZnvTUOIoE?=
 =?us-ascii?Q?B8CMvY0TVOYoYhKMCqO55uBQdjWxN7oUZ9gj+8ep51Ava6B9bD2Xw2J1wacS?=
 =?us-ascii?Q?K5hmGAcHv0M4yFc7/C8K3c92asGT7o+HyLTLusBA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a313c46c-a66d-401d-0bd0-08dc08193c23
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2023 02:52:45.5495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cKMZC3rPWIew0XP29nosaEDYNH0cMtNJBo0eD+kUAN1WGmJAKSmUuBf62O6cLPL0Nj+YGpxLxYANXF3sqSfWhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7024
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, December 28, 2023 11:06 PM
>=20
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> This allows qi_submit_sync() to return back faults to callers.

this might be useful to add a note that the retry logic itself is being dis=
cussed
in a separate thread [1]. Here we keep it intact and just make sure no retr=
y for
the newly added user domain cache invalidation.

[1] https://lore.kernel.org/all/20231228001646.587653-6-haifeng.zhao@linux.=
intel.com/

>=20
> -		if (qi->desc_status[wait_index] =3D=3D QI_ABORT)
> +		if (qi->desc_status[wait_index] =3D=3D QI_ABORT) {
> +			/*
> +			 * If the caller is interested in the error, no need
> +			 * to retry, just return the time out error to the
> +			 * caller.
> +			 */
> +			if (fsts)
> +				return -ETIMEDOUT;
> +		}
>  			return -EAGAIN;

indent should be adjusted and it changes the original logic which returns
-EAGAIN only if QI_ABORT is set for the wait_index.

the simpler form is:

		/* No need to retry if the caller is interested in the timeout error */
		if (qi->desc_status[wait_index] =3D=3D QI_ABORT)
			return fsts ? -ETIMEDOUT : -EAGAIN;

otherwise,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

