Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F9D7BF5E7
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 10:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346697AbjJJIa5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 04:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442787AbjJJIa4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 04:30:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9E3A9;
        Tue, 10 Oct 2023 01:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696926654; x=1728462654;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oJrnmT+nsttH7piJ0NIo7HMQ79huZA8URmEG23iknUs=;
  b=bhxBpuktUJEm0RlMEOSMGxlSwuMEs860zx2TIloCfAOhuDQ7a2JOjf3B
   I7ghrzgUIUIPN3bbKhYwZAxr5rGFKDcY3CZY9/3BwmOYJidbdPoG2Sb9w
   Nu65LOGWxmbEyfY8xahB+WSnYsdBcMKJXfPLv5st+NchVrVIXF5x30GMJ
   p9XEHz+OS/1FBKG9+SmJKs/2st+uqcdIClm3iUDwtpmssRbsQNGhyTjn+
   cpOrUmnSfiHzF5PKLOfGpnpqwTACbuQEYZKbyU3MZAf9pzeENHKKS6Q1Y
   KtIimzmQQAHcUSCpESp9tbqc3qtDKLLRjKe0+xtaJwUrPwegj0dg2RWL0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="363689197"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="363689197"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 01:30:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="897084599"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="897084599"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 01:29:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 01:30:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 01:30:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 01:30:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjJg15oYVzCEgpUoikcQCZ//g6V2zOzd0KPQeLR/VKsxOkGGHx0GJuEZgpUI2aydWADqdXghYkfYJyq9+1RMkHw3SbeMztJD3/UhED463TIhM1lQVFovVCivFrQCd7JUfHPMtnBmsapWXcTbgK2+DsLQ7Gf5GU/c3Ju1jScWEaXjKlYXxT94oMB91l6zOOsbPKooNZRIAktbMh7cmU7JSAUYqXG2DGwd67GVlrTEKi/yuGztk0QNtjSkd1gkNaZ70vNARFeIpsl4fWhgDU+VDWb5vah3WUoMYHWNPvTeNoZuXCbU+VrxB0FinCHwkr/ef+w6pU5AEMOAYT8dNp6iog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/MC6T8n5liB1DVdFH6omXv9sSocrZC44QRANcGgGnw=;
 b=YrWIWWTJ+cqS5GvyRub1ohxRSH8djqR8vmepD5V66aF2mly4LZ4+vHsacoufs+UZCtFqi93Z90EUV0Ul9nnw7IiwvPCjdkKHBnBpYbiAIjArY0bvBzfbQXEMgC58l90sLLtvLOv6idzfTTQigcgPbEtwkZv6dq3tklRzWLl8XW4eKc1WlDwK4MO4Mt2nMbnyxdNwAGPhV/u8NIFBcxi38KS5KNdTgLt0HRtqZmQOGu7KsWNiEcT5vrUaeYoVwPGVnqAuhV6QIAu0nTTd9ujO2tKhRrQuBnVaNtBcwlqkI7AeQKktlASO3T+WWsdZfRjq45cramYrKFAAuk2DiXbx/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5316.namprd11.prod.outlook.com (2603:10b6:610:bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 08:30:45 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 08:30:45 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC:     "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [RFC 6/7] iommufd/selftest: Add test coverage for SIOV virtual
 device
Thread-Topic: [RFC 6/7] iommufd/selftest: Add test coverage for SIOV virtual
 device
Thread-Index: AQHZ+o3TxDEbyXSioEilwXFwg8S19rBCsXMQ
Date:   Tue, 10 Oct 2023 08:30:45 +0000
Message-ID: <BN9PR11MB5276A82597B194611BE01DFE8CCDA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231009085123.463179-1-yi.l.liu@intel.com>
 <20231009085123.463179-7-yi.l.liu@intel.com>
In-Reply-To: <20231009085123.463179-7-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB5316:EE_
x-ms-office365-filtering-correlation-id: 5baedeff-31dd-4e8f-d481-08dbc96b32d7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8P3HwP73KR9eRTMhtq1t5AmFnMbb056e1fCuK7+1id1UDKig5Nrr/mj535Chekj6pIj52zrI1XuVTzSKQVSGnDo3to5iDNmDbNS/XzldypNDhb2kKQKaVsc1zo3exwP42iKIEChC7kuNSrN87HbT88NJRnIvOx/M4G+KAuaDXX392N7slZw7WEWWXcspq6Oz5pKiDw7Z0FxJGKAVqb881xMz63DAa7Y23TiSIR63cXW4aGpYC1TgFm9hcsGSX2DbkM2PUkB8nZOO09QMVJTx1jaT6bM0wjaCrVBBbvWtWw/8egIC+WsarZi+rXfflMXEcYteJIRCc/r++tjG6wRdzxHA6DYEwS6pppQetgUvtUn33sv/pTCc4AthYcVSDGbMfVHEkO2AyLYCXevKljDfttgzoSHGL3xNiLFwlxor3ELWxHezj/d8ZXCvIV+Z2mB5jO/pRXuaANTxLmYxbLbgsk3ZTupagBvy1bEBRQgldKmXPUMmIH2/h2AmCEPx42AY63g/1YpDZ6sWQVzweYnYFTgwcINPKF0Gei+B3mZobbmGc212HN9tjfhQtCsYKs2HrNceZiRLnmjJ4Y54v9k0QzGupvTqO7mzVT2KLPavMquZpfEoZJqr0cpcr1hZ6N7c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(55016003)(38070700005)(5660300002)(41300700001)(122000001)(52536014)(8936002)(8676002)(4326008)(33656002)(86362001)(82960400001)(2906002)(7416002)(6506007)(7696005)(9686003)(478600001)(71200400001)(26005)(316002)(110136005)(66446008)(66946007)(66556008)(66476007)(76116006)(54906003)(64756008)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KadJkG+sb/He/mSkG/C4PCx/eKvtC3ratz01uUgOUbwUn1kft2KWt45DV0GW?=
 =?us-ascii?Q?e5DCL6dYePKf90pzLrGCbbg+9op87sF6prtoscUHelRPSBQk1j284lk+BOgz?=
 =?us-ascii?Q?H+Zc0NXkut6vUzmioOCRRslX3ktSu5tLI0Oqa1ezkoDSAQTY0WQWLtkRp6Ty?=
 =?us-ascii?Q?0QYskCueYjOlUtrLCPDnDBlQWQJwAd4rrA/YZvD0WLyIHzZlG2Pj1excVzsN?=
 =?us-ascii?Q?w3Z7mvP5oXzHQQipZlcg8UdoDwBLOTxGm1IX3Gxl4heDxbzLFsTpjdQHgsxH?=
 =?us-ascii?Q?VLXp5bNoHbZebO1zMkm+LGUKMTt1euuQUykn67n1luMJ+vhWRTLGj1mwJ+8W?=
 =?us-ascii?Q?WHJ3IyXPZVbmvSzrZE50lkIypJwtzUiC4JbY7m2uJb4Xd/zn9me4Jozkt4dG?=
 =?us-ascii?Q?hwjw1RPg6lSqk3Rmih5d8EJGX7T1FEv2ErWEnS+L8/BBRkAF6yoPuRQdHgzp?=
 =?us-ascii?Q?RXMFLSToA7VnMKxBtfcVjGVJJEZwBZIeLQ7UdpNiwBkbq5ohrb0IfULQa/sZ?=
 =?us-ascii?Q?A7ukJCu2Ltl3x7aDVSGD4nTRytoF5ZEilPPNrAG+CDLZCMOjXItwPQPi64q0?=
 =?us-ascii?Q?p6Z2yfHU6Z6zuyCNXHRnHPepTLoutNDIfKoIde1HeuARrb+u8GP2TLbu+D+S?=
 =?us-ascii?Q?7kFh1Lk+XcB9hPDThD09FW7gnNMSjhQLJ2/lBGMG3HcM2zEAnkRqGSrrAh83?=
 =?us-ascii?Q?LyNtWeLYS5Dy/pBIirQJSz4dCMJOH60xVG4eJjnhcMJBw7CZyVMGnEkjSCzJ?=
 =?us-ascii?Q?BtwiakMakMdOu9nvluVot6pOt9HkHDURBT2ONCbDktAsQg9HGG9804CpAScv?=
 =?us-ascii?Q?Kn95oIPpGK4O+HGoI/o+ousM8FWeljwoRSp97qkWYL0jR9387SVPAMmtQe0y?=
 =?us-ascii?Q?GCFub/cV8/sic+73vKR5fWVxJ543Kb0OMZcnSoJvn/EJoT6GGv7Jn1r/aOJd?=
 =?us-ascii?Q?qNVxxUjL/zYOLXQV0dDCq75v0lmdFSZWnZ3bFszidd+EzuVsWMCjJuvNDzJb?=
 =?us-ascii?Q?IO/3osSCkq8bF94B0pSmoos5eJWJXImyWPoUPOaUax2OaNiR/Drr+ghXMCdx?=
 =?us-ascii?Q?YvLWbLy6yIMowMvi4BcCpXvBCSuI7MpYSDJsNzHikF8cLWaxfcwWfXb4rZEk?=
 =?us-ascii?Q?7mJrkxubejDWky59MwBedr4wmshpDIiGZS/a+1ZJRMaazewCg0lx6eqJ6+hG?=
 =?us-ascii?Q?xoxFKOkfhxCncySxRQr1L3JS5qGZoy8pIZ6eDwW9USBg6tRyYfIMdFh7+ZGR?=
 =?us-ascii?Q?YlVpSGNwRxLvR4RoYtKOZ7esbeyO8D7VL/ytcyXTU5dj6G99goCyLNZ7eMVE?=
 =?us-ascii?Q?c6A0Nn6icM90LoFPlAWeRyx6YSVLmmkmvuuV0AKL/k6L21hGFX8rxi1k5TsU?=
 =?us-ascii?Q?79h7axwXrBZKVrU6zQEpSusTMdKi4c+HA3o4NIMUnxUjNpRuAKK33jiPo5tJ?=
 =?us-ascii?Q?pqYrxDhwYl4xtyHeM86MV9IkbLI9JW4a52yo2SJVvZuk1P1yo1gbQr+bY+wq?=
 =?us-ascii?Q?xY89pkHsGNTOu107nfdeShcxVqq2d//DafxeEEVxIESQeDas/9OliGyBNvAz?=
 =?us-ascii?Q?91EvZGbLftuO1KBtrIzLZXBJMuyKNlSfwdmyRev7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5baedeff-31dd-4e8f-d481-08dbc96b32d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 08:30:45.4491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vFOrgnzgkYD+A4nFUArwlNzcR+L2uTApNEl6i1982a6zml9x22H4c4K8evfjVrzSEZvDM4CS1raVLuy9gXtLDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5316
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Monday, October 9, 2023 4:51 PM
>=20
> @@ -2071,6 +2083,43 @@ TEST_F(iommufd_device_pasid, pasid_attach)
>=20
> IOMMU_HWPT_ALLOC_DATA_SELFTEST,
>  					   &data, sizeof(data));
>=20
> +		if (variant->pasid) {
> +			uint32_t new_hwpt_id =3D 0;
> +
> +			ASSERT_EQ(0,
> +				  test_cmd_pasid_check_domain(self->fd,
> +							      self->stdev_id,
> +							      variant->pasid,
> +							      self->hwpt_id,
> +							      &result));
> +			EXPECT_EQ(1, result);
> +			test_cmd_hwpt_alloc(self->device_id, self->ioas_id,
> +					    0, &new_hwpt_id);
> +			test_cmd_mock_domain_replace(self->stdev_id,
> +						     new_hwpt_id);
> +			ASSERT_EQ(0,
> +				  test_cmd_pasid_check_domain(self->fd,
> +							      self->stdev_id,
> +							      variant->pasid,
> +							      new_hwpt_id,
> +							      &result));
> +			EXPECT_EQ(1, result);
> +
> +			/*
> +			 * Detach hwpt from variant->pasid, and check if the
> +			 * variant->pasid has null domain
> +			 */
> +			test_cmd_pasid_detach(variant->pasid);
> +			ASSERT_EQ(0,
> +				  test_cmd_pasid_check_domain(self->fd,
> +							      self->stdev_id,
> +							      variant->pasid,
> +							      0, &result));
> +			EXPECT_EQ(1, result);
> +
> +			test_ioctl_destroy(new_hwpt_id);
> +		}
> +

I wonder whether above better reuses the device attach/replace cases
given default_pasid is hidden inside iommufd_device. this pasid_attach
case is more for testing user pasids on a iommufd_device which hasn't
yet been supported by SIOV device?
