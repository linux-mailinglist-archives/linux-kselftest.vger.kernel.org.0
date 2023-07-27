Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163FD7649AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 10:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjG0IB1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 04:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjG0IAx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 04:00:53 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535144487;
        Thu, 27 Jul 2023 00:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690444699; x=1721980699;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bfJlTHWdRCxfGtN+L+WqFQs+wjZG3ISuhUSLHhZxnTo=;
  b=dJ/NqIqx/vjjGIesP7TqvRwocxjHa7SX8gI+CfbIKI2U1eaSV0JOAGYK
   ISlE28EKrH6sM8WSAYwN4PWcYBzOGOCU9/O1jWpA5+qxbDsVafOzJK9Qq
   5Rx4Rcj1WqqBC/CDrv1feO1m9lOIjnRke/tE3qHUYUpMUKGqWZFi6pEd5
   CEvKGF6LpizUcvY1bEiZlio2fu+Hv2be8r3cmeqnZIaNz+288hExzQJmV
   GtgD4Ma8LnwabkNWyvjG1t0onkglOruJrRwipHiGYCzR3wIl/p9j1egE9
   7vulkn+B4KoWYSD6aOTcopqEd1XEwQEidRimvTGlnz2JGw5g9XsPaXu+R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="368256783"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="368256783"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 00:58:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="900767545"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="900767545"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 27 Jul 2023 00:58:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 00:58:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 27 Jul 2023 00:58:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 27 Jul 2023 00:58:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJs8A/uwW2hhNTFGVRQn/brgFu37cEBOARaKDHKPnBJWAD2zyTSoD+ApAJPFzoQNTpmnxKg9em3RxM1ayA4qw428VfJf6BWawlxcsr9iQQQGxaUelof+DStOAkHgrvMCIs3Xbp+abJGkjUMOzkbbJEEjvdBaFLG58pNMvzia2vELKq86FK5AyHINGF2oFBGNeykx6FYtww3gkr/u1ksRo8wYeRoesKlB0zvOzAxqkVHP7tGubILDoNr2xpDnyFQTjN80xOiG6H6iqJo9VrRtw/f+0sg1u1WJd6Q9TfHM/8mLG3v9PGbS+FG0QXmwewMQB7BbiuAwnzIDyllXanas1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfJlTHWdRCxfGtN+L+WqFQs+wjZG3ISuhUSLHhZxnTo=;
 b=O0MfSWZh+d0BBao/BO0mionBa+rNN1CdahoqGvSW8D4IChlrbY914UYdTlvl2F74dCtan8fs6/Mj/b3NEW4aDqc/1veM3mPcLVSlraesmI0lqRJMyCIwHmExDO/TmU3D6AHiIZX0rT1XEfxdcCN8rVnAmJSUeUld+MeN4VzJ+QZ42n+UB3FlqXMnbdFkJySLay9BVkNu8FzSGh5DJE7QV2JDipXR6lSps8jrCh2MO6ssnXd1PWis6XQ6gCj5BxA02Rq59xKIgIfPgTGpfHyHE4BroU7DWxkxdR4AyvTRi0LOHWLbHztXr3PamNtitrdCKck6DOYSVyVmEODmOGx5Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:57:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:57:58 +0000
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
Subject: RE: [PATCH v4 2/4] iommu: Add new iommu op to get iommu hardware
 information
Thread-Topic: [PATCH v4 2/4] iommu: Add new iommu op to get iommu hardware
 information
Thread-Index: AQHZvh38FAJVRPiWykeLMI4rhnTRSq/NQiKA
Date:   Thu, 27 Jul 2023 07:57:57 +0000
Message-ID: <BN9PR11MB527625066E23A1C4968905D68C01A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724105936.107042-1-yi.l.liu@intel.com>
 <20230724105936.107042-3-yi.l.liu@intel.com>
In-Reply-To: <20230724105936.107042-3-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB7493:EE_
x-ms-office365-filtering-correlation-id: 2405e8f6-b38e-4ff9-c402-08db8e77312d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 68O1nHEVeVcO6xmOmnR0+zJe44YGCyjERepgR6NHkr50x3os+xP3QRcLaY9eHqJ5PHAe8w1Wl/A7ciDMrKYYf3mdOR5TqJzU8roVVpKZPyeITFdcoZO8BlHXbsGEx4v+FSJMUxH81QBG802YbvR8JdPWdxaoFw2KoIVNUIr0doRtPNB03fUkXeeouciionmDu74etJcMX0ADhbupgF6BwmDbByOEQaPto/BKnidyubU1xSa4WToWqXHp4joO1c/exwzLfl7d/+CC/Vz2NI1vOPcOVf+Aw+VQd8GIKZ7gFbkwW9g4JwgrnSpZXSSrn+JnU6Nq0KK9Gq/qDIfyP/shSUWNOHqBPp0OyVo2yGF5ABLuPNJ0rxvJj0nl6Ew2ilqXlXT9t1t+JmQJKbVNhQKsHkaARF0abjkQwXp3SLTkwF6Kpjeb7PkH82e3d+92SXlxwwkXEhGPyF0x+SNAs2vtQhtEpVaLXFKgRxOQal8xSZpCkeuo0XFr/hR3D0GRM0T0kzjaVEKvfFhIfLglKYJy3Yhblckptzu9lD6vhThyIMUNunP5SWJvD/MIYnYZfDR88Q5f7JOIRLoJIySG5ZIoL7cATnnde/NRifarCtX/ThUwwCt8nAn2gzqXV43n0c4L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(38070700005)(2906002)(83380400001)(7696005)(71200400001)(38100700002)(186003)(7416002)(52536014)(5660300002)(86362001)(55016003)(33656002)(316002)(26005)(6506007)(8676002)(8936002)(41300700001)(4326008)(66476007)(64756008)(66946007)(76116006)(66556008)(66446008)(9686003)(478600001)(82960400001)(54906003)(110136005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rm9EekpZdFZ1WTlpTE45S294RVZ0bkJFR1RSaEkvb2FCZDA5NllLeUoyWWVu?=
 =?utf-8?B?N05WekdtMC9PN2N2RE81cEI1WVREMnZXUjRxREdWYTNhMDFmSjBVNFoydzRt?=
 =?utf-8?B?Zk96NklFQ2pRdTMzOXllVDgvNThxQUlrZlJCOXIwWWxURCs4NFQ3UHYvZjRh?=
 =?utf-8?B?R2NkZ2tJaVl6U1NVdVFGMGV4RUdCUTBYZ1NNMU1sV1VaMUpicjJXb1ZPR09X?=
 =?utf-8?B?eERCckhWQlhJTDZ2akozVGZjbVpaMUdhakIzeW0xRzN4WkRwcWNENDJvdnQ0?=
 =?utf-8?B?blhQWWYrTmg2Y2JINEp1blZXM0RCeit4SXk1czQ4VGNEM1hibml6OVRsUG9v?=
 =?utf-8?B?NE1kd3VkN1RPa25qalE3Y2Iva01kNk5aNVloNTR4RWV3ajE4UTByYnQydnJR?=
 =?utf-8?B?aHFINTNMQjBhYjZadVdBSmRKMCtyVWR0SGZYNVFobjNtbXBXVEZzSDcrbnI5?=
 =?utf-8?B?ZzJzZEJLNUdkVkJUZVRHTEh4ZGlFck5UODZyUVk3dlUvSHJMOTFRemhwUWhB?=
 =?utf-8?B?UUxyeTllTUdsUEE0VlZVYlI0c0t6ZzArOFpYaGZtV0NFWi8vaHhkVTdwZHV4?=
 =?utf-8?B?ZUFIN2doWXMyOGVnT3lxdEg1YkJid0tFbzZRVW50Zm1lYmZROVFQUUlYeG9K?=
 =?utf-8?B?MjlxZTdXbTUwanFMS0pqcHc2S0o3OGlBSHljYXlhN0RRVW9jdlRZOWp4Qm15?=
 =?utf-8?B?cTlEVUdFUFo5eDVGQzE2a3BGajBOUHNVL3V5ZHRNZ29PKzQ2RlhpemQ0N3Zp?=
 =?utf-8?B?VmNPUHNVRElKbEdUR29nNnFVUXlXNmdnOHJjNkRoR1E3Ui8xMDI2MVZYS1J6?=
 =?utf-8?B?dGxsd2ZJMkU1Z0FMQnZPdnFMZ1gwT2YyUFFhK2kvUWZTWk5MV0xWQjJrZlRs?=
 =?utf-8?B?TWRYV0FoenlWcmJ1OGc4eUFpc3lWY0x4bVBGbEQ4T0dMd1NlY2FNZUFDTk5J?=
 =?utf-8?B?b1VTb210RlhiRjdZYm9lVUVnbTdJb0h5NW5GSEtDWXRiUVBYWmk0OUFMaFhW?=
 =?utf-8?B?TCt1MDBLME4rZ082UnV6VkxGNVNmTUJzbFBURkpTeXp1T0Z0bmRhR0laMTFC?=
 =?utf-8?B?UXp6M01CaGhDVXBJaUlZZW53QmlLYWpRUG9vMXZsL0xJaG5SSll5K1JxVnRi?=
 =?utf-8?B?emJpdVg5Q1FwMVIvYzFmczhmOW5EK2JkbjdzV3dmZ1ZCbTNucGVzbHdnbTVI?=
 =?utf-8?B?SkxWTlExa09GbDJtNTAySm5xbC94V2R4NkhjdmE5UEpRTWJLT2oxbUZwN1o0?=
 =?utf-8?B?QTNVNWZ5azlmVWtxbWtoczRiSHlUVjhBS3k2eFRBdmJPWndQVldNdFhqbml0?=
 =?utf-8?B?T0FtQ1Z3YXZqQlh5Z2hTOU5MK0h4TUpjVGtsSEtDMEhVVzd4SnFxQWxGM1Bz?=
 =?utf-8?B?QlRqNEVtMVREMHhuRUQvWDAvKzRxTHlCelZsRnRuRDdrcXdCSXhJS2I4MWhj?=
 =?utf-8?B?ZEVXdFh6VndLbjU4TXlJNFdGTGFCMVRtK1dScjBxb2RQVkZkRzNNUklKTGVY?=
 =?utf-8?B?KzBybC9BalZtQnZINVhERzFFcTZ5RHBNeFRGYUV6cmxhYWFiQmpvbGt5dENi?=
 =?utf-8?B?QlNSNEdBS2dFU2h3YlNZV1FnZnJkL0J6enI3Z283MzdUem5ubFNXb2s4UkNu?=
 =?utf-8?B?bzZOeGxjTi9nNEo3WFV1L05mQUxjRk1PYlkxNFdEN2I5TGk0L3FkdUtTemRa?=
 =?utf-8?B?ZGNMU1FsTk9ZbnhXYUIxZ0dJWDJHTHl3blluSEc3Y1pZVXFvTFFOTElYaVJa?=
 =?utf-8?B?MThINys2ZVp3SFB4aTIwKzViL1BlcXBRb3hPYXpVdXVDeWN4aGtlOUxiR21n?=
 =?utf-8?B?VFp5Uno4ZlUrQUUyZ0dlbFZEOW1oYWtZSnJGSi9RSDJxMHRaQmxvcHFaRUJB?=
 =?utf-8?B?OHQybm1hRi9GWnpRSmN2QlM1Zlh6aHhFTTVYMXk5SU0zcVA0bllzOFdpVXpT?=
 =?utf-8?B?OFFGZWtHTEdoRUYwUVp2ZjJkUkNiS3kvaCt0NmJlbVNaNmFDRnpsV2xhamF5?=
 =?utf-8?B?eHVMUTJYelN3L1dBQlJCUll4WmJDVTU2MG1WTXFVMmZEWWZwbmRuTkV4K3pq?=
 =?utf-8?B?c3k4b29zMGFvQXVNM1pKKzJOWUtTekhXOXRsV05hek5vYlMrekprWmFSNEll?=
 =?utf-8?Q?bsnMvHl2zS6r3a9t/hFACiZY1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2405e8f6-b38e-4ff9-c402-08db8e77312d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 07:57:57.9898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nu76yK3IQbTagWT43gDTdA6tz7d18z5g2sbiGkrXHqs/yP3NLcbYrOtnM7Ashw6N9JCdkQDLCb+Zg1swcqaCEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7493
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBK
dWx5IDI0LCAyMDIzIDc6MDAgUE0NCj4gDQo+IEBAIC0yNTIsMTEgKzI1OCwyMCBAQCBzdHJ1Y3Qg
aW9tbXVfaW90bGJfZ2F0aGVyIHsNCj4gICAqIEByZW1vdmVfZGV2X3Bhc2lkOiBSZW1vdmUgYW55
IHRyYW5zbGF0aW9uIGNvbmZpZ3VyYXRpb25zIG9mIGEgc3BlY2lmaWMNCj4gICAqICAgICAgICAg
ICAgICAgICAgICBwYXNpZCwgc28gdGhhdCBhbnkgRE1BIHRyYW5zYWN0aW9ucyB3aXRoIHRoaXMg
cGFzaWQNCj4gICAqICAgICAgICAgICAgICAgICAgICB3aWxsIGJlIGJsb2NrZWQgYnkgdGhlIGhh
cmR3YXJlLg0KPiArICogQGh3X2luZm9fdHlwZTogT25lIG9mIGVudW0gaW9tbXVfaHdfaW5mb190
eXBlIGRlZmluZWQgaW4NCj4gKyAqICAgICAgICAgICAgICAgIGluY2x1ZGUvdWFwaS9saW51eC9p
b21tdWZkLmguIEl0IGlzIHVzZWQgdG8gdGFnIHRoZSB0eXBlDQo+ICsgKiAgICAgICAgICAgICAg
ICBvZiBkYXRhIHJldHVybmVkIGJ5IC5od19pbmZvIGNhbGxiYWNrLiBUaGUgZHJpdmVycyB0aGF0
DQo+ICsgKiAgICAgICAgICAgICAgICBzdXBwb3J0IC5od19pbmZvIGNhbGxiYWNrIHNob3VsZCBk
ZWZpbmUgYSB1bmlxdWUgdHlwZQ0KPiArICogICAgICAgICAgICAgICAgaW4gaW5jbHVkZS91YXBp
L2xpbnV4L2lvbW11ZmQuaC4gRm9yIHRoZSBkcml2ZXJzIHRoYXQgZG8NCj4gKyAqICAgICAgICAg
ICAgICAgIG5vdCBpbXBsZW1lbnQgLmh3X2luZm8gY2FsbGJhY2ssIHRoaXMgZmllbGQgaXMNCj4g
KyAqICAgICAgICAgICAgICAgIElPTU1VX0hXX0lORk9fVFlQRV9OT05FIHdoaWNoIGlzIDAuIEhl
bmNlLCBzdWNoIGRyaXZlcnMNCj4gKyAqICAgICAgICAgICAgICAgIGRvIG5vdCBuZWVkIHRvIGNh
cmUgdGhpcyBmaWVsZC4NCg0KZXZlcnkgdGltZSBsb29raW5nIGF0IHRoaXMgZmllbGQgdGhlIHNh
bWUgcXVlc3Rpb24gY2FtZSBvdXQgd2h5IGl0IGlzIHJlcXVpcmVkDQooYW5kIGxvb2tzIEkgZm9y
Z290IHlvdXIgcHJldmlvdXMgcmVzcG9uc2UpLg0KDQplLmcuIHdoeSBjYW5ub3QgdGhlIHR5cGUg
YmUgcmV0dXJuZWQgaW4gQGh3X2luZm8oKToNCg0KCXZvaWQgKigqaHdfaW5mbykoc3RydWN0IGRl
dmljZSAqZGV2LCB1MzIgKmxlbmd0aCwgaW50ICp0eXBlKTsNCg0KTlVMTCBjYWxsYmFjayBpbXBs
aWVzIElPTU1VX0hXX0lORk9fVFlQRV9OT05FLg0KDQpvdGhlcndpc2UgaWYgdGhlcmUgaXMgYSBy
ZWFzb24gY291bGQgeW91IHVwZGF0ZSB0aGUgY29tbWl0IG1zZyB0byByZWZsZWN0DQppdCBzbyBJ
IGRvbid0IG5lZWQgdG8gYXNrIGFnYWluIG5leHQgdGltZT8g8J+Yig0K
