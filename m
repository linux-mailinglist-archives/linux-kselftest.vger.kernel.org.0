Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB9376DF33
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 05:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjHCD7P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 23:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjHCD7C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 23:59:02 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AE33A87;
        Wed,  2 Aug 2023 20:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691035127; x=1722571127;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ul4VNyJE+rXEA9PowXFWUqQPDxn9trs6cEp35KLllyY=;
  b=BW9f++LXPuw3XlZnAAeJFaycZjL2gQtClHCMwg1ai42cEqAr8C/29eiP
   pSLEnAnKHl5UbtjVIZgULz+cT+HnfSGXPef0+CfubD+pMDQS2HStFGjf0
   v1Qeq1BTrMOTYGaqQwdwsB/Kmabrb/dm7u/W+4Jdh1V+TtE5hxRkZvrYJ
   1yTJmxjgkIMVN3vrBso4deGaCS99M4M8zUp0Cn67SnR33NaGDoNyIZSl3
   0rZys+vUkpjN3lxisgtdl00cBwn9crhcyR4b8AY4zOIytulugz4jH2PLu
   HZY2BNWs+eXylk7ukq7ljjjv+By5DxAkgQ81jccwAzGupLqgI0/MHeIH1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="368662516"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="368662516"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 20:58:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="758965569"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="758965569"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 02 Aug 2023 20:58:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 20:58:45 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 20:58:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 20:58:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 20:58:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8wtRBShywyDEGjbLLb7/XQUPrELwI4pEaHhkMHCD1Q51CPS3lTtULY3bN4v3Ay4bZHCA6PgxV8/aBtMjF7VQ5jIhGypq2JqO6SqzKj5fASvJjfirzzOyuE7Q4U4qYBjlSdOGWxxZYUHw5UtklzFSIFO4aYsVx2qNasEmj1rI7SFYW5rQspNNFHBR/53MfS+pKha8sWMrVGMmR81aY0QrMRIT1BG7DA1ga8V8LJb3Wugrauuc2ujG97CqfIyWJ7XPjjlblmnxKWdjmiOdxqVsy5+aqdkh9l/5r7Q/5AmeVhtfc5GJvJLVCQRtw6S4Cb1X8D1G/iYmqLAmrv4k9jw0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ul4VNyJE+rXEA9PowXFWUqQPDxn9trs6cEp35KLllyY=;
 b=A58sFtk3TK5qEhuqG7nIPMVreVdVHZD40TkDVMKl6n04ApuULhrAm9gDhYIEhEoB4c6xXxk+wTtpCSNII/OZiBNgTfS/G2Z3MWNs4WR2DqyIJIZwiPe+atv0YAs0wiBOUmbwMu2SzrkiHKOb4zcLGEdrx0lS3cdRr2u1l4AOM0H2I77+B2bSMpvDGZCV8LWtUPlGJjkAt5WeA2s8Xfb6TlG3wvBDygRPuA0BJEu5b4goA0xd2w2raLN9qvlJFlblni4SzJI4wjpdG8QvMXVgLgQcOmdl177HfqHSaIV/Fgahq1xMfikSPGzVcG4PSgDk+1L45AcbOWPvxv1IB6XB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB8763.namprd11.prod.outlook.com (2603:10b6:8:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 03:58:43 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 03:58:42 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
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
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v4 04/12] iommu/vt-d: Add helper to setup pasid nested
 translation
Thread-Topic: [PATCH v4 04/12] iommu/vt-d: Add helper to setup pasid nested
 translation
Thread-Index: AQHZvh/rKXvA0HWuiEqGDjpQbJoG+q/WoMHQgAFT4ACAAAxB8A==
Date:   Thu, 3 Aug 2023 03:58:42 +0000
Message-ID: <BN9PR11MB5276D1F7085046F5A86C905F8C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-5-yi.l.liu@intel.com>
 <BN9PR11MB5276C84A20C48B4041BE07B78C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d57dc99c-4970-fe0f-53f9-ea6f926910ca@linux.intel.com>
In-Reply-To: <d57dc99c-4970-fe0f-53f9-ea6f926910ca@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB8763:EE_
x-ms-office365-filtering-correlation-id: 1dad1f07-380c-4663-4e03-08db93d5ed73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 56xQa9aZ/NyKH0/gBKU6okBYPKMgrybT+xQx6J5xKVmSb61feSn1GA8fqqJFR2E6GPKscV3SXRy8UeJk6TKNH4mlhBgDaX9cO6niUS9FuhXgEXpOuGk2/UJ7y4rs8ZVMJqgjhhgj5si8ah9tRojqG9paKJKfBv7qQFvfPKSzapEpbmPOaNq5piFMNW3JjJkWkoer4RL1YhyunqGCJfAMj2kTMWXje2PtkXxlObNVixkb4q8E+tPkByis0KJjbiZrI9j22+eI6r1/dkqdehkAr+sW0lbuxeP+X342vD1fwwlDpYJ5jR5KpmEFLaOwD39AfkGKklDVRTBngEovrl9r73u34qO8R5w6KGNlXY7D4G5tjjkk+kV6Kqqvm7APw7RTuMgbNxUiLneDUsdStf7DXOwsjTv3L9hGf9FdaP1unGFXhhdZ+iSf52b/j5Q1yi3jNt38R8nUv/gGnlSVg5lPvr2njY+JooGFb8l00I3KWD+90uMvRqwyDTQN7qlzhjZ6xmfDS+AE5BpMVz+A7LlvCQGYui2NvbhUY/i7yf/aaankwv1OgBCqfJbvejODDNJziHsGKVhV7Fb2f9y2OwNUqUEZQaWCWuMPWgLbcCPZ/EgIR22pXZ5PJ/TdxD0e/tDt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(55016003)(7696005)(9686003)(71200400001)(38100700002)(82960400001)(66556008)(66476007)(66446008)(64756008)(4326008)(66946007)(76116006)(5660300002)(316002)(41300700001)(54906003)(478600001)(110136005)(38070700005)(26005)(83380400001)(6506007)(53546011)(186003)(122000001)(52536014)(33656002)(7416002)(8676002)(8936002)(2906002)(86362001)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzdnMGxsR0g5WHVNdm8yUnVjbVE4UnVpZ3FtWi9YbVlQeUwxRHR3NTZ3OUgz?=
 =?utf-8?B?aFhCbm9iNElYaFRibFloMm00NWwvVHdkdnpaTWh5a2xIVEp4eVlFeU9XZ2FR?=
 =?utf-8?B?WU81ekgyQXVkUmJ2TUdEeWl5cnpZTHJaMHVNa0cvbjg1RW8vcjl1L2t5WkJo?=
 =?utf-8?B?ajFncVhOd0l2czVkUWtta2hwa0E0VFBIWHZvL1U5dDZ6bm4vaHFDYXlFTzJL?=
 =?utf-8?B?Y3lZcEhlT1FBL0FNeVVLODd6T2hTSDk2SWhjVDVCUzFOSVhjRG90MWI1bU54?=
 =?utf-8?B?Zy9LR054SG5wMWh6L2FRRXQwWTYzSTVWa1g0SWFWRk1jT1IzRDZLUzNieURT?=
 =?utf-8?B?WFNGS3p1NmE0VFRpT25iMTRhcXdQNWVXaE9SQkJkbHBIUTh5WU92eDZXMEN3?=
 =?utf-8?B?eTNwVVVKVlg2bk5pVG1HZHFjZWlZMFhmZ0plVXZFNnV5UnZqUmJkMExuOG9p?=
 =?utf-8?B?U3M5aEVJV0huOWFaZFAvODVmQ0pOMHdlYy9Id3IyZlhLSk1ucGQ4VXZwdmE0?=
 =?utf-8?B?RzBuVFlPcDFsOW5PaC94Q0xvYXQ5YlpJdXpNTnlGN0NMS3FYS3kyVXlPdEts?=
 =?utf-8?B?bEtDcFR4VHpKYVZkTEsvNXRDUEZGL2FKYVZuM1lMU1phYTVaMEVkWFZTM1pJ?=
 =?utf-8?B?ckRCV0dCWGpFUjVqQjZHSmE4c3hTMzV1V3RDbjRBMU0xbnplQ2FSRE5BaG8r?=
 =?utf-8?B?VXFwTjI4d3VGbzJScS9RZEtSajUwcit4YjkzMUVZa2pvUzRxMFVvRHNYODhP?=
 =?utf-8?B?NTV2b0dhcDJKaC9nd0VuRXhtbXZqKzhSWVVueERZT2VVSW94TE5Rc0ZBWDY1?=
 =?utf-8?B?SmFLbkYyYXNHMDZ5R0tuQThhTVMvaW1ORjdoQmJ0TWlsVWlTaURROG5aZ3VO?=
 =?utf-8?B?V1pwZkp6YlVXMXZMRUx5MUhiQzZLbTFKY0VZUy9leEVyZWZTOHBDVUVyQXZU?=
 =?utf-8?B?RnAvN011VEI0NHNVS3dvbWZtdnpmS3lJYUJCdUc0NnhjL0NqRU1kNzdXaGVX?=
 =?utf-8?B?aXBEOXZRbnVJcU85VUd2N1BmaFZ1cXVYa1FxeU1FVTVpeEV5QmN4STNQZXlw?=
 =?utf-8?B?b3lTL0hkdGQyS2xxcFkwSDV1QTErT3NVNlV0VjNzckVLYWQ4MDRON25kVnR4?=
 =?utf-8?B?ZTZONTNob0grb1BjOVF5TmcxK1E5NEhpbFBaUU5MLzlhdG5kci9DcjFhSmFZ?=
 =?utf-8?B?a3RlZmxpR3lHNTlFNm1hM1d4U0NxbS9ud2FYQW1nSHE2Wm1yQ0gzbEZOb2lZ?=
 =?utf-8?B?bjlRSjV2TUtxMnRXb3dJeTlHYk5XU1p2NG5kSTk3TnVQaGpabWNNSCtla3BV?=
 =?utf-8?B?ZTczblRtdVJCcER1dTltamIyQkdObER5enkyVlp6eFoxOERGQkllcER4R1c2?=
 =?utf-8?B?bWp0MVdmejlkdngyV1JDYVlGdE1VTWhzRWRzVnJlU1BUR25YT3YvV2lQeGpC?=
 =?utf-8?B?NWVmeEdNSUhMdFF4N1kraVRFYWY5L1NzanNXSDZXNjIzVWZ3QXFkQy9WTlQ0?=
 =?utf-8?B?NDNTTUFsTnBGaUN5RWNobVRnQTZuZmdPa0VsVzZNZm1ZZ3RxaDBMa2Vna2tL?=
 =?utf-8?B?Wm4yVFZ2ZWRVTXRiT3FtU3o0b3JYMjQySlBEZ25ha1NMZG9lR1dNOFZTVDVq?=
 =?utf-8?B?cVJkMTZHaUdxK2N1MThVVDRYeDZYcGQ3SzlkTzhpbFZ4NGVoZUYvQWd1Yy9y?=
 =?utf-8?B?Z0l0M2JlMGZNMEN4UGV6NG14NFZLdEY3cExoZ25rd3RxaGswei9GZkJTMnpT?=
 =?utf-8?B?U0RJQ0ZtNkhad2o2WUM1SVdWSGp0TGtXRGNpKzhZbXRsZlkra0F4OVAvUHJO?=
 =?utf-8?B?NTB2TFRYS0J2b2NSTjdTR1JmQkswNVQzVWEySGJyNEJjamRMQ1JaRi85N3Nq?=
 =?utf-8?B?YWlsVTRPT2RWclpoWHFiSUlKRGhVanVsWldZWGlROEJsMGZ3NHh3WEo3Y3NU?=
 =?utf-8?B?ckNwWjlRdkNMUGVHM0ZJaDhQdmo4MlpxbTZjVVB0QWUyY2dzZ1lDcS81ZWVW?=
 =?utf-8?B?OTRNeCtrM0t6dXk4b2ZnenNONzM1dUJrcVhpVHJLU0ZvOStKVkh0d2s5UTJH?=
 =?utf-8?B?S1owamVHZ3dqODJiUUxyNnh2RW9XMzRTNmgxT0Q2bUJ2bFVoaWZURkRxemN6?=
 =?utf-8?Q?SKJkKl7Z4dHt8Sendjq1d7Unu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dad1f07-380c-4663-4e03-08db93d5ed73
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 03:58:42.4012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mx5UAAR/uWFnztnJqUO0t7cs4FnlJw3hl69vpSnulOiUFryWMEJi2JfQYuDZPJHmt0Uu+MCg3ckP1Uj0FfTtRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8763
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgQXVndXN0IDMsIDIwMjMgMTE6MTMgQU0NCj4gDQo+IE9uIDIwMjMvOC8yIDE1OjEwLCBU
aWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTGl1LCBZaSBMPHlpLmwubGl1QGludGVsLmNv
bT4NCj4gPj4gU2VudDogTW9uZGF5LCBKdWx5IDI0LCAyMDIzIDc6MTMgUE0NCj4gPj4gKw0KPiA+
PiArCWlmICghZWNhcF9uZXN0KGlvbW11LT5lY2FwKSkgew0KPiA+PiArCQlwcl9lcnJfcmF0ZWxp
bWl0ZWQoIiVzOiBObyBuZXN0ZWQgdHJhbnNsYXRpb24gc3VwcG9ydFxuIiwNCj4gPj4gKwkJCQkg
ICBpb21tdS0+bmFtZSk7DQo+ID4+ICsJCXJldHVybiAtRU5PREVWOw0KPiA+PiArCX0NCj4gPiAt
RUlOVkFMDQo+IA0KPiBUaGlzIGlzIGluIHRoZSBhdHRhY2ggZG9tYWluIHBhdGguIC1FSU5WQUwg
aGFzIHRoZSBzcGVjaWFsIG1lYW5pbmcgb2YNCj4gInRoaXMgZG9tYWluIGlzIG5vdCBjb21wYXRp
YmxlIHdpdGggaW9tbXUgZm9yIHRoZSBkZXZpY2UiLg0KPiANCj4gU28gaGVyZSwgSSBzdGlsbCB0
aGluayB3ZSBzaG91bGQgcmV0dXJuIC1FTk9ERVYgYW5kIHRoZSBjYWxsZXIgZG9lc24ndA0KPiBu
ZWVkIHRvIHJldHJ5IGFueW1vcmUuDQo+IA0KDQpZb3UgYXJlIHJpZ2h0LiBJIG92ZXJsb29rZWQg
dGhhdCB0aGlzIHZhbGlkYXRpb24gaXMgZm9yIGEgZGV2aWNlIGNhcC4NCg==
