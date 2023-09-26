Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5D97AE521
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 07:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjIZFg5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 01:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIZFg4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 01:36:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BA0F0;
        Mon, 25 Sep 2023 22:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695706608; x=1727242608;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mpgmOSMEVw3AAW5AregGv9tcEN4qGrvjULGn6Hx1lCw=;
  b=XTHDrg2OpcINHknlhYp5HDiS7+n2oujf3Fp2GUgmA1BCofm4zvZ1H2+e
   pdJXE/Ve0dGGXgmMOTOFVlPmXjkBeYqojZl1Y4WQxOVeHZv1b0JML99nG
   c9PNLgVbg7k3oSQKynWN/DqAQNcB1XqUyi3T6v9tGnpHQHptTfTuEf8eA
   a0ZiX2BigzozpLXtWAVKnTuVVSK2+/PaUKqOryDNWnkCBMebwOgVT1UPm
   nO7nE27hR7Yju3wXDTsqoVVpIyWQHWSNC/vfuA3eZ/cBFdZhf7XJc8MwS
   kySTxcn241ZO9MozdfxNUiTdYWB61DSvJQgAVgAEfdCMqUEpzgDtIcZ+9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445621621"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="445621621"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 22:36:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818924523"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="818924523"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 22:36:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 22:36:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 22:36:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 22:36:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 22:36:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzhvuL9f0sy9jBPagvFcv5d9Wo836SBpj9/zoYFzkYTnBazaByWA/R6OXA+6KsGfkk0ZOV0zgljrKs9z0erhsPlZImeiRodg0Hw+MkbWvW6Nux7jfYN05IBU4MoS5PYNdct9L8dlvfsZi5cQQOn3DbTUOikLI+0bjlZT5Vh/iafQnnP0LZ9rPTDFd8Dd5q8t+bxSQh4aPLId31Nq82AJ36PmkG/GO4OMjOs05elHzWSO4/6J3lMCWH+7tYt16q3x856rOKglTVGLxewg19da31MtcNfRDTCPNmTpWm+rkKf9rlAKaTC4dJZ9m6iQAevkIhWLJtE6cuX9do2HCM8U0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpgmOSMEVw3AAW5AregGv9tcEN4qGrvjULGn6Hx1lCw=;
 b=QYwn3bnqzYSRMNdFKoCi3TNgCct/rn8SnAZvGZqlMZFDxfHe25SkSXqw23RQ+0FQBX6SXN4ePk2vidK8i0AvBiTEVgb/l16dA7Tl2CRoEaBwqQ6A28riQxhbPiZa3SQvm5N+kFqgpuRlMWeaFtL7XnW4VQrcJKQTMN1y96xqe7xBXFyl+g57MK78DaTlzwgtn+UXE5kd4v53CcmO6Y+8dwDxOKU9E9GHCAFC7n8LS3Iaquuhantq8e3xBJwVCYjUkBHk271n+c0Y7RIHwx3H4DbJvhrnXFpLD1+BpzHnfAux1KO7SD/50hFMaTuMmA8OC0Nk9fJgYiFwS/M9QjwsCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7339.namprd11.prod.outlook.com (2603:10b6:930:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 05:36:13 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 05:36:13 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
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
Subject: RE: [PATCH 6/6] iommu/vt-d: Add domain_alloc_user op
Thread-Topic: [PATCH 6/6] iommu/vt-d: Add domain_alloc_user op
Thread-Index: AQHZ6ttUIY4d+/+Cm0ybhc12Lz+8RrAjMOqAgAB/mQCAAAFQAIAAzySAgAgf1MA=
Date:   Tue, 26 Sep 2023 05:36:13 +0000
Message-ID: <BN9PR11MB52761E9638C05D7D199A87918CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230919092523.39286-1-yi.l.liu@intel.com>
 <20230919092523.39286-7-yi.l.liu@intel.com>
 <7aa8fd9e-e43d-db68-bdb6-fe4f891255ca@linux.intel.com>
 <20230920130522.GV13733@nvidia.com>
 <DS0PR11MB7529609BC4574A17ECE469A2C3F9A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ea19494d-8de6-e907-a735-7f2e5f98f9fb@linux.intel.com>
In-Reply-To: <ea19494d-8de6-e907-a735-7f2e5f98f9fb@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7339:EE_
x-ms-office365-filtering-correlation-id: a89da875-4903-4880-d777-08dbbe527f4a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P/p38zMVUrILlIj5VTe8CNuNHbT7Z7Teo06gSF3ZlIAcT4FPd+j/zdCO7/BPW6YJbfBsEuvsGWjjvrrUxDN5yz9ObIJFfZYO3VU3V/7Lo3k9NrfwF1Vnwzv7feW0hVefAdaLrCjXV1S8N+jGSpw2T+K6QKt+971iGjw/BMNg/J1p5mkX0zpeMu8y52uy6SroVboykba9E5+o+nxFssBbMPz+tufy8/UE4FZuWjhP5lz2Xjhh0n+1A3TCCYSv0pOgdAwSaSg3fF1GVfyktcXI3vIKMJ17XdEttY0DXiBAk037KnmU+HC8cOiF3jPBEgDSYHaD5daaK+z7kwPQ69z4+PM4w88U8KiVKaA45XSAinfhIiSDGsaiDnxV0vqdlYGSEJlZcMJ84cvC4NZ84jgVMxbt0Jd55gf6F/fmc4/DWUMNVeGi8f/og1mKONClChJHgQbrVpTRIone6PyffHJ/Dp42er6Zc4jRHdEOQhuhwVeMV1xF0c5tgwq2WdSBZuCLDFna34+2rnLukT/KXvEL5DD6H1PQVp2jdBOwKrJUDXQEe1j00OSXaTjOvL0cIYCOKyEg6g3VhLGZSTNtXJ+TSsEcDfJIlVUY7NG6VNRm/KICtceftzxzHVDylL1LCeT/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(86362001)(38070700005)(8936002)(8676002)(38100700002)(52536014)(4326008)(5660300002)(64756008)(76116006)(66476007)(66556008)(54906003)(110136005)(41300700001)(66446008)(316002)(2906002)(7416002)(33656002)(66946007)(4744005)(478600001)(55016003)(122000001)(9686003)(82960400001)(26005)(7696005)(71200400001)(53546011)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzFqS05RRllMQXJPQjBjMGRjRGpxK1BCdUlXZVMvTUs2Sk43akMycUdNdFIx?=
 =?utf-8?B?RHFUNlEzVGtRZng5dGZnY1hoTDBMRjFnOWZQUnJCWDZKUjV4bXdkTjA2eUJy?=
 =?utf-8?B?YWNjTDFRRSt3bzBqQ3M2ellFUzd1ZnkzeWszdVpjRkl5NzJWUjlFVXRuSy8w?=
 =?utf-8?B?S09DbnhwL3RXTTlaMHFCOU82Z3BDdUVQYnFrbDdoOE5HSkJxNm1kWDVadTZ5?=
 =?utf-8?B?K0VPd1l0bEVCMWQvQVdLWllWcG9GMkVQbEtnMTBYY1IvZHJmMlVUNWRWallq?=
 =?utf-8?B?MEEzaDlzYnU0emF6TGpkV1lzM252T0VMckdwcXU1YnVoUk81VllmeUhCVDNi?=
 =?utf-8?B?YnNpVW5TY29JWnVPSTJ6amwzYXNTVVhNeExrSEY1VlF2V09PQytvY1E2ZTBT?=
 =?utf-8?B?ZUwzc3NXcG1RMFU1VXJEQ1BxVUdUb1FsclJyV1FZb093MGpTRGxGa1U0M3RU?=
 =?utf-8?B?UGowcGcwQTZwTlFUZTB3eTJoR2xNMGRlTUlWUHpUNWE1Tks3ZmY1R0VvUXAy?=
 =?utf-8?B?KytGTy9DdWVaQUtLZERibGF1MENXN24zaW5ZSU90d1JiQ0VpY09TUDVZeW5m?=
 =?utf-8?B?MHp2Mk1IaXZidTVlYVpub09FSGxVcjlLemZ6RWpOTkFmTkdkTERhM0wvWHlm?=
 =?utf-8?B?VSt1L2NObC9vMUxESE9JZC9OQUxTZDFNK1A2azRBeGJlbmtjTkVUc3JvcWRZ?=
 =?utf-8?B?b1RNYUYwdGQxd1JRQUZYcmVVM29iaGczMWh2eldnZC8ySFVVZjJxdDNsS2ZU?=
 =?utf-8?B?djJqL0hwUnZOanhVdEFIdCszT09yUWVDUHYxd04raDJ3WUppQ2ZsUGtLanpH?=
 =?utf-8?B?L1BpQ01JcXJhZTBnb2xrQktrNEpOeDlkajBQVG5jTXhwWEZvNjkwcWhVemx1?=
 =?utf-8?B?NDJCOTZTbnJCV2VEdUkwMjA4akE0SjBwK3ZQZ1BWbjZXbmNDL05WaU9SWU1S?=
 =?utf-8?B?S21RczN0WnBwcEM3ZjRzTytrLzYzZ0dVSnV6MjNBNkQ3eTVlOTBneW1PTHZm?=
 =?utf-8?B?cDZDcXpweGtpWUNlV3NNUHR5aStJV1FjVC9XdzFKd21tMWx2Q2xaWFhQeE9M?=
 =?utf-8?B?aVhCTk1TRVIwTG9xKzBmRjI3d0R6aHg4YjZkYWNwVDd6RU9TNGtMZmx0aTgv?=
 =?utf-8?B?QTNiVmczQWFPMkhlWWRoKzI4TGtibDlydWQwU0tKaE5lb1FWZ3hxSGp4TFlm?=
 =?utf-8?B?R29KUFVUSVdQWDg0bWcvZ2pFZjNYVW1OVjNaU0ZwU2RjRW9nQi8zbDNQdGxL?=
 =?utf-8?B?UktwRWhRVm1nQ0JHNWEwV0FFTWt2TlRJV1N3ZWl6SjRqMk1UQnJmeE1UUEJ1?=
 =?utf-8?B?RXpZelpiTEI0M2g0REdqYmxJMHMxaEV5UkZDT3paZVZwdkVtZGZmRFZCMUVy?=
 =?utf-8?B?dmlpM0NiSWpXRHhsb2V4bXhuVENBeHZIY20wREpmcDRkaDJ1Z1JPZm93U3I3?=
 =?utf-8?B?WG5EYmt3am9BQkdUWXR4c2crUzB5RUJQNnJKV2R6clpsRzNaclNUZHlaanlN?=
 =?utf-8?B?RHk4ZWhDcmdVZG5CcVBXU3pBQWFUV3BkWEFJWjJxMkFKbUpaeGtNaVlRa280?=
 =?utf-8?B?dUZ4SEIrcUVDRyt2aW9CbE9xUkROY1p1RElaOUVFc2lLTFZtQ2VvYXpUTkds?=
 =?utf-8?B?NHg3Z0x3TGp1d3NSdEZJOUFlTWdadGcxRnJNelhqSlBqWEJNaWJQWC9nSzVq?=
 =?utf-8?B?ZnVreFlxYldYT04yZEVaNUJETTdRNDl0Z0xkWXd0cERrTm9HbGZQcmlCQlFS?=
 =?utf-8?B?TVE2dmRqV0h0MjhsNHlyeWtBMHBQRlRqaERzOFdOYU5hd2xxeWF2cWE0aHdX?=
 =?utf-8?B?Q2JWbWxRakZNWmIwNC82MXR6M2tyRndIQ0wveTJVTElETHQvbEc0VEROblJP?=
 =?utf-8?B?blViTkF4eTFIdVJNUWJQbDV0QTNpNmhGNVMvT1BmMDVJa3ptb2NKdjQrSitJ?=
 =?utf-8?B?S1lMOHhMWlowSVJGa3Y3VGdtWXUrbHVYaUpNN0NySFZpa092dlp0QkExd1VY?=
 =?utf-8?B?UFpxOXUzdUtqZDFXTkRoQnducTdHT1BGWjFJeDMyZGNHNVdWbmM0Z0Z1VHA0?=
 =?utf-8?B?VWtqcktEMkIxZ3pKVkxTcVlTdVVrRUYvVEF3NjVlZmI5ZGZ3Wkt6Z0xBMVBm?=
 =?utf-8?Q?6AZtIYUYZJDa/vvTuCBizoSmb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89da875-4903-4880-d777-08dbbe527f4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 05:36:13.4814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u0FEn1Fzjg+YA8PndN3SH8xg2X4eFIOdsAQA5w6W6zvp0cSFECzb+Of8jBlIdEhFxNj2+hob99u8kienVSMq+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7339
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgU2VwdGVtYmVyIDIxLCAyMDIzIDk6MzEgQU0NCj4gDQo+IE9uIDkvMjAvMjMgOToxMCBQ
TSwgTGl1LCBZaSBMIHdyb3RlOg0KPiA+Pj4+ICsNCj4gPj4+PiArCWRvbWFpbiA9IGlvbW11X2Rv
bWFpbl9hbGxvYyhkZXYtPmJ1cyk7DQo+ID4+PiBObyBuZWVkIHRvIGJvdW5jZSBiZXR3ZWVuIGNv
cmUgYW5kIGRyaXZlci4gSnVzdCwNCj4gPj4+DQo+ID4+PiAJaW50ZWxfaW9tbXVfZG9tYWluX2Fs
bG9jKElPTU1VX0RPTUFJTl9VTk1BTkFHRUQpOw0KPiA+Pj4NCj4gPj4+IGFuZCBmdWxseSBpbml0
aWFsaXplIGl0IGJlZm9yZSByZXR1cm4uDQo+ID4+IElmIHlvdSBhcmUgZ29pbmcgdG8gZG8gdGhh
dCB0aGVuIGludGVsX2lvbW11X2RvbWFpbl9hbGxvYygpIHNob3VsZA0KPiA+PiBmdWxseSBpbml0
aWFsaXplIHRoZSBkb21haW4sIG5vdCBoZXJlLg0KPiA+IEkndmUgYWxzbyBjb25zaWRlcmVkIHdo
YXQgQmFvbHUgZGVzY3JpYmVkLCBidXQgaXQgcmVxdWlyZXMgdG8gZG8gc29tZQ0KPiA+IGV4dHJh
IGluaXRpYWxpemF0aW9uIHdoaWNoIGlzIGR1cGxpY2F0ZWQgd2l0aCBpb21tdV9kb21haW5fYWxs
b2MoKS4NCj4gPiBTbyBJIGNob3NlIHRoaXMgc2ltcGxlIHdheS4NCj4gDQo+IE9rYXksIGdvdCB5
b3UuDQo+IA0KDQpQbGVhc2UgYWRkIGEgY29tbWVudCBmb3IgdGhpcyB0ZW1wb3Jhcnkgb3B0aW9u
Lg0K
