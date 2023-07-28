Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A9B766955
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 11:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjG1Jw0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 05:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjG1JwZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 05:52:25 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E2C2727;
        Fri, 28 Jul 2023 02:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690537942; x=1722073942;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6PpBCkd3OfzTEaNVPxMLBpV2glavXLI1cuL/iQOXcpQ=;
  b=L3CE05JAZnxtSCKGu0zCY5bIk0v7ZdyM4JIwgqToTYIftWt/jkm1sUJp
   EiMyCh4sgxjSSbpL5uyg9Tt/GFxZvBdqRXjOG9x82kHdY7BmTL+cuibIf
   xW+WEoOALS75lVEyQR1F46lg0q8XMw97/V29u6cC2ZTV1Jmd7aEDnBL+K
   enggN3jtd07oBi7c5iBtQu4/YVjRInS9Dzu0d67/Evv9NA6vnNiHcAJU2
   +lgIIPA3+HsWIXIAOB/jScnxRXNhWZCA/IJmw0UJ8yeuYW7ZzuupmwDAK
   i1AE5Qnodart6dVtJodRA07AHnYNTxwKuqNx8h+DSDz3Oh9NRYuFXXMAe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="348840352"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="348840352"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 02:51:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="797394330"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="797394330"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jul 2023 02:51:49 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 02:51:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 02:51:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 02:51:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ov0BFntUAaQUG+6wOchugGSOJa4SRhRsDwRtIw+rplDO/i+aQ/gssiNXgpWExC+nH2Qn5FuuyGIAZtH72Sr6joWMyt2/Zv3tEkxWPQ88pG9sy29R6xRae50I9FHd22bqWWn0hgHI31Fn+FsRL3UW2RSzr4gUGta0n9ssXqGfhClIvZXRNgjC0UbXHqBeM5GfxPHdjzQwMs3RswU7ax/lDiIlkj82YWW+M9rHAWOzUBBzOvL7/NmvRv1bdybIe3rtYacaDWB0lsn1Va6yDNAgJXymVsBWANM3JhkRixO7wuyJ7lMSkppQBrMBwGhLAajXLTjZP0byNlDlEd5E9R9Yag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PpBCkd3OfzTEaNVPxMLBpV2glavXLI1cuL/iQOXcpQ=;
 b=AgpYW+G1qeWWbYnKFbo9oWwONd79KKoYt9GE4eyd94TaOwnoZE4/+YI6jpmH/xkROSLvUDPby4Er/5wFc2RH0s7DD7SFgDYDtz/iDK3/pjUrel8BFrvbIwpsMkzJhrYi0wqV+/5dQHnZG+XDM/pO1Gzgpte1O183YNiowc4+fTwMtgdS3zjQzH+0tc+CumqT+hPfwDFaUVrBIHqXtYt76BRQe+jYZJcLnM51+3yICPytQe+7g9XTtqDwo9cAxVGNVzyE7I7ONqDA1Fx0lYuci+4RIdKqTfJbcvpVdflLNGVQfa/ErCoyOUz+wMFeKHmiBf1SWOTlIaK2b/f0T0m5qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB4867.namprd11.prod.outlook.com (2603:10b6:303:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 09:51:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 09:51:47 +0000
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v3 05/17] iommufd/hw_pagetable: Do not populate
 user-managed hw_pagetables
Thread-Topic: [PATCH v3 05/17] iommufd/hw_pagetable: Do not populate
 user-managed hw_pagetables
Thread-Index: AQHZvh6ZxId1XVzHr0+H0890CzrRca/O9eog
Date:   Fri, 28 Jul 2023 09:51:46 +0000
Message-ID: <BN9PR11MB52761FD2163A8B47FE8418038C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-6-yi.l.liu@intel.com>
In-Reply-To: <20230724110406.107212-6-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB4867:EE_
x-ms-office365-filtering-correlation-id: fea6fdcb-77a1-4551-9ead-08db8f5041f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KERPeTYrCKB+MXR6FYdeHnXesUXFJei4NzXkcPTdcFOOl5TIdZpau3YsBm3Iz69o0a4o4iYaJsFGuuFm0mdTfd1j8qkosF6sSPUd+QwganPXHcpy098EP1T+ZebIz2QSOd0Y/JalRYsdchS1AWGDwB27K0eeIFCMwnOiO2ZrzWYO4woollme6E6qpYOAXQwkzvF19Vxz/+CBSk0PtMkWQL4wb8aVkOpam3FKF6HLl9i8KoKQdJAFvVVAIYuNU4VfvhWM7WubbdhOCTk0ez8uORjVdt4l12CiQLdo8FvV/5lsA65VC2xbkVx3YvaxxZjiXFFpcx1ZOHytI+h2rjQPRPU3S5lAls8d8Izarfi9kZMxA2wFDbGIeBgot3LOc3LlJOpLMBdO2CJQbJTElb5hj6PNUKhxIYFvmmsEcMVdzGkCScfeXNv2vi6kvAwP+k8dr6Y75CEXHXrplUkS084SPfX8WV44FrV5zo30DNaAXfoG6zNwcLf1CP47C1DedEl6DL5tH8kaExcw+Y6VdxHF3vCS2NBn1xMn3vwcGR+oZ0MlpqL7ZFy7C/3UY4kTO2QpJ1fa5BJlb9T7XJo3rJ6314CZAwQo0UAssBgOuVN//cf+HiW5Wn/uD7EjGcxVi/tQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199021)(54906003)(7696005)(110136005)(9686003)(478600001)(33656002)(86362001)(55016003)(38070700005)(2906002)(71200400001)(4744005)(66556008)(66476007)(66446008)(6506007)(186003)(64756008)(26005)(82960400001)(122000001)(76116006)(38100700002)(8936002)(52536014)(316002)(8676002)(41300700001)(7416002)(4326008)(5660300002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SG++11GKhwwZwlU9j2Gk60pdDspiVo/vyCNNW/7qqlEub6d/WKeFBOzGZWj8?=
 =?us-ascii?Q?5QpXSnJ7yCFacYHpXYpPALNOOZALBWm7KTXNOup9CTOjJmiPmKhW3DWxtGF1?=
 =?us-ascii?Q?AgieVjnhIwDu8VyYKrDDUZSpZ+MGhPhe63gzzYX6vzgu/KLUDAASggs+RpWY?=
 =?us-ascii?Q?CNX7Ealgir0zMEwJxPSAvC7PqFD8dRWVLqKZCiWd7vltfF3PLe+jaU2lKkeF?=
 =?us-ascii?Q?07GPSwUt8tioy5KWBJIROc/AaNvdraSFj7JK4yXn4wSLSaXD1OIjBeCYiRVB?=
 =?us-ascii?Q?JAl0l5lb/4MzOKoDUZ7PA4UGOW/0EIBzuNST+JNLpBcmPBCjegMdm8gczhuK?=
 =?us-ascii?Q?et9IQ0veCS8sAcgivtAE5pOp0e4pG4ecPsAYW4hEvuAyTnTaTGH16ITs18kD?=
 =?us-ascii?Q?nHvJh5adAqeLDsBEay8qe7vc6CyHc6o3TV5rx8Dqv9CKIHHYlXes1UjGfsCz?=
 =?us-ascii?Q?pRFTJP6rKKssT+Sy1O8nlTtmsfiMFbg91JvyUqx3V6KhDtLq1OS8Fc56eFSi?=
 =?us-ascii?Q?fhjTD9+TA/B+7MCWo38rpRSdF9jqvQO4VoqpqVia+XsHulNks2bIJdfV8ca3?=
 =?us-ascii?Q?FrUpeMC66x7My0Pzg5DcEmJeLBweHTfI8GJWNKpm7AIt7qBfuNDwHHWVumbF?=
 =?us-ascii?Q?zdrKgqP6ZUTHdHM7IqGiNWVZz+IAU7Mz1BN872tSylxGUgEaGWsbn0VpvIjf?=
 =?us-ascii?Q?sosOGWvcQfi1m+vYcr07uXNjK9iABC5JS66XQTomzVa0N5od8aJlKF/4WpnY?=
 =?us-ascii?Q?2Fa+FFD7001zhOrRMXVHkpTFHqO1LGqCuh1aIMKbD3+31Tt+srYP62Qnpb1l?=
 =?us-ascii?Q?K0MiPQadUscwx8tlqh3EfXRsNZNwbZjNLUGwhporYh+eIZzn8WfZGR1GGHYV?=
 =?us-ascii?Q?7XXVFyxSUxOQ2s7rzmtysccOwteXTe1a2UUYwN7Hgejp9zCKPpNDp0J+fBzn?=
 =?us-ascii?Q?3OMJ/v2dxh6cHioT6GwoejwqXx/dXKCW0bAKa/DWcBtA3Q2Ou50MXsJ2i7OM?=
 =?us-ascii?Q?3uaJDntzDJcvXiwq7ELkHJjhEATvBb9Fw+OU4XPTV86jp+UpSVaUYgkCcNza?=
 =?us-ascii?Q?7zh8rIHdM8ZEAGhUnU7felooqAxNvilu+asKXqmMnI0mpiKXccorRM2uqPax?=
 =?us-ascii?Q?GQcrn4Svy2Soqunqgeiem+6B5lyNZ3Y3KlLGzJe5bSktrVQDMjxxx7us6PHv?=
 =?us-ascii?Q?S09F0+cwOYFTgJhE/hukWdPcjyykhoYxL7rqSv5m3pD3cKoNFTyeTIFR+xva?=
 =?us-ascii?Q?wJXOpmA9gaOWhBm6pgTYPnO6vrdHkZaF0yXvxU+Aw++EStCn7c2sURGe3lm+?=
 =?us-ascii?Q?t0CEwzOZX2yDDG52ul56Bq3d/9Ox0qFTnIfKSmdzewYr5lSfT90vEE0IWM6f?=
 =?us-ascii?Q?XD+qpD5LOp39iuyNsFlG2++OIIXQKlPCKuRexELhV21mK2DfigZ2ReWTkQMj?=
 =?us-ascii?Q?KJGdxSRv7pXg98pd+IWVKIN3i2QdO9zszqQ4c919o1ZhhfAlILKz2RCA0040?=
 =?us-ascii?Q?e7ozaaEJFNpPMCrcn2sbZ6i4BiU/u1Yig/POuwhusW4oXEsTh2IKAtbYuDED?=
 =?us-ascii?Q?agUqC+fSSpRhQ3uY0RHm4ed4RcFWyXLQ0RLrJZid?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea6fdcb-77a1-4551-9ead-08db8f5041f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 09:51:46.9915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nsIDDrNyuLL4HqRpjdXXPIhl766XY9Rmexd5fc2JbAbOEEDxQnuYGSr4NdudMrSiJMdl9SXTIxFYdpvkvKVy9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4867
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Monday, July 24, 2023 7:04 PM
>=20
> From: Nicolin Chen <nicolinc@nvidia.com>
>=20
> A user-managed hw_pagetable does not need to get populated, since it is
> managed by a guest OS. Move the iopt_table_add_domain and list_add_tail
> calls into a helper, where the hwpt pointer will be redirected to its
> hwpt->parent if it's available.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
