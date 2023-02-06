Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C4868B5B0
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 07:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjBFGkx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 01:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjBFGkw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 01:40:52 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3A718B14;
        Sun,  5 Feb 2023 22:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675665651; x=1707201651;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oQcrjKJ6q2hRCP9O1Z+TYzwqWmYBpkRxtsqmRJIXOLs=;
  b=i2hqcG6Ts61x36vJKFdMhOh1JFCwvE+q4e/kSrWNyf3TnHbWEa9AO7WW
   VyqidcnGn0HxIH4F2ctXRMgVi42RScmPRQF/Sxs1tN64wDDqrkNLjvjDV
   tRPPgYsQ1Srk7QhDa2LxQeH0fgyY2pp+XhYI1w5D9m0kEwh28ADcX1moL
   vFiek5VpkDuGEfTsDJkb7Q/p6fihiQT0qJWanqu38x3FPqeSyRwRcx3bh
   dNVtLuyCFWDD/nH1XQUt5JSq/N3QO76A9NUO6VXj+2hH/bWzLOOXiHhuP
   fzYqprSnQ2t/rwn/25lrWz2SQv/mL35gB9Prai+MduQ/XrnAYqJBu1AoH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="393739815"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="393739815"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 22:40:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="755145988"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="755145988"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Feb 2023 22:40:42 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 5 Feb 2023 22:40:42 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 5 Feb 2023 22:40:41 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 5 Feb 2023 22:40:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWtzPQ/Bu0N9RhTf8Wvz34CZkcFvBZ59mUv3rokRIFkzGZ2WpeBiMKcMMZP8c4HrUkUX8iK9OhxTp1dAB0Cbr1G4a9f1YJ1WlN6+egRB1BkyXLlTv0+ttlP1E459pJR1ah0FjwyhIKkNaJiUGOm2eZjFv+QLggsU2nW4IWY2tdxc3BinmG/cyDZVfKyCa+kmZIMvO3ScqFvbb5+AhNTZ5Ka7uA3DrUZI7vUxY2V3hCN5+yDj8J3u3XUSd4Cm/r42njGp4j6VobksRFXqKtA2S85jWNw4F16ft7+DHjH6gvPl8h0mhB+EMV5688bvMxXRGoYONAc2WKSNpW8aHTsHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQcrjKJ6q2hRCP9O1Z+TYzwqWmYBpkRxtsqmRJIXOLs=;
 b=YSawi5ZQtsIo9Q4iV8NVXmBT8TUtwDdgyl+Whn6YkGdq+Qer+KfLv/w2vp+gtGooVGPsq1FhM/nZQdPqrSH1+ME6Lc6Sbi3lU2KOb2IaC7+UkQVPVv8BMuNph20sYFd/iTcdBAbj97rW73jbRLXGnL+2tJyprqEFNxuFDktRwZb5psUtwVk1lpYEiqiiYcmMA6jLbNrtsRoM0g7MtumZZhlWXT6/eTSHUpEmhjNvTcNSMTXqOsV709xkGAFDjsv++r2IktdpPV/nxBtUmGPapHOzivYaCxeYxEbqQGQCSMPIpgVNmtKO6JFyU6sHxfbxhJJf3oRYCoXj2YpgYm+EJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5543.namprd11.prod.outlook.com (2603:10b6:208:317::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 06:40:40 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 06:40:40 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v1 2/8] iommu: Introduce a new
 iommu_group_replace_domain() API
Thread-Topic: [PATCH v1 2/8] iommu: Introduce a new
 iommu_group_replace_domain() API
Thread-Index: AQHZNtTMfIuYSgtAgESqEIXUquWnsq684BXwgACgywCAA/z+AA==
Date:   Mon, 6 Feb 2023 06:40:40 +0000
Message-ID: <BN9PR11MB5276EF2F7FF40C544E7FB49F8CDA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <a98e622f41d76b64f5a7d0c758d8bda5e8043013.1675320212.git.nicolinc@nvidia.com>
 <BN9PR11MB5276BB497D32073A1F4CBE238CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y91IKoDq2xrWp1Jq@Asurada-Nvidia>
In-Reply-To: <Y91IKoDq2xrWp1Jq@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL1PR11MB5543:EE_
x-ms-office365-filtering-correlation-id: e2f4d085-8c5a-42ae-b700-08db080d104b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MZwVBNEv6xqQ/NiUupDR0IGTFC4rOB2UMLKjeE8Sj34KqkKynezDuqoWB32LzMfIya5FKNBWBN46/reCNov6AT9Aj6u9uy+9waRQ/byDIJ5GJo5YUZ3OxcLJBc9rgCWXAavu7/G9nrjQV0TbsCQ+8B7IBNjtfFQcXqQYgjZX6WrQ2Kg1u0WvcgcG6M+VyxCU89bLdhdk8pPw7M7DkpPlTUGDVOD2BMJ0FEamDWBd7/Oo9hhQyT27ilL/53EEl+N7l6PmomwRIVfJsiQjood3AAsWT23WFfd2gxxYvFz5j0AZR4KL/GDFC4UvEQ3v/LRhJ4IPIpFDaNwLZH5psWxBJiMzbQZ1V7cy9M1W1FBGe/bqDtR9z1Bm3RW1xFk+Ncb2nvwcE1F77NgK7FkPUano0LP6qBGaORqJRy5Y5FkhBFhe+YJ6f+9Vk8mLf/GCzXiayJmKSDOyZMmDXEs/4udxdECIvJYok0qlf3NtNI5eiCk2y7TBuH8Jlk1ZVVWde4+pMev7ZIlSbtA6kp4RYa1/AGWzqljb21ft8bFb7r8qsnqK3i96yS9HwMcIn0Fd6bqhIFTUln9Yr043QeAQQxYUQozDcW29foKTgQMh2PS5BsMJ1hkDgQFvqoNdkPVKep3Hgcunhm1WmN2qJe5lQsWypBxE1RqeCV2IU2CKWkI9ZchRV2jbIjIGX5aMjLqU3kvhY2C/w1sTArYf4OHhnanKqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199018)(76116006)(66946007)(54906003)(316002)(7416002)(4326008)(41300700001)(66446008)(64756008)(8676002)(6916009)(66476007)(66556008)(52536014)(5660300002)(8936002)(122000001)(82960400001)(38070700005)(33656002)(86362001)(38100700002)(6506007)(186003)(7696005)(71200400001)(9686003)(26005)(55016003)(2906002)(478600001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGczY2FQanI1elB3KzkwZ1V2NGg4VzN3clVMc1BlN000RFFSa2ZrNmI3eDdr?=
 =?utf-8?B?ekY5SGlNN28wTFZ6clFEa2NjRWtKdGEvcjdVMlZTdlpOdkRIcE1XbEJkZVdR?=
 =?utf-8?B?N2JkOWV5eU5ITW9GeEM0YUM0UUYwVEV0VTdLYVpZM3kxQ1Z6dmZPV09YRFc2?=
 =?utf-8?B?ZEJtVTNMY2FGaEw5SjRvTDhFdDh5S0FDOE1keElOcHk0ekhKcXlBcjlmY0hZ?=
 =?utf-8?B?M21nWjRtbXd2S3ovQWFYWkNKdFl1bDg1aE1QZXlvODBDVlJVc2YxMTFoaW5t?=
 =?utf-8?B?S0Y2UE9iVEF1NTF4dTlmUE9iYktGVWNnQ3gydDRGNS9KSGZKTTZUbmNSU1pB?=
 =?utf-8?B?T2FyR3dFNzQ3ZE9vK1ZoOW5md2ozcUtoUWNNTW0yeUErVWppcE1mUkdPTyti?=
 =?utf-8?B?d2d6U2c1bkN5WjY1TVVmakh4RVU5dllXVmJjOTVEMUNTa3dXRUpGanZCc0tt?=
 =?utf-8?B?dTRET1MzMERTck8vcGYwUlhuY2J0d2tvQjkraU83dDIwMitudGFOR1JrNjlT?=
 =?utf-8?B?WjVXVy9MTWoxUjBDQ0w2UkZ6SDgyUkdPd2w5WUN2RjVBcDZNK2dlTVFEWUtQ?=
 =?utf-8?B?WmNkSXE5NkV5TnR1aTNMdDVMZE5HZkYzYlpYQ0swNkU0MWxNMUxTS2ZML0J1?=
 =?utf-8?B?cjJGWS8rcGFzNStHZXZhb05saDBQRDZHR2xtSlRXSEZ4WVFISTJsczlxT3d4?=
 =?utf-8?B?cmtJb0NDckw4ekNyZFB4NWJnQklTeXdVYk85TmdNNlYwU21oWHpoRFlOMjMz?=
 =?utf-8?B?d1c0MUIrMTBJYmlqay8zaUwyWUVONy9ueWVqNnkwelJoVEFIT05jYkV5YUxu?=
 =?utf-8?B?dDdGSjVqbFltRCtZK3NJM1dpbktSUEE0c2FmMWxobGFtcm1lQk1QaXJnRGpN?=
 =?utf-8?B?eTM0T0ZLamp2YlRmdmxkS3RCYktoVWRhOE9zN3VmRmdMcmRCaUd1RG5sRVpL?=
 =?utf-8?B?aFFnekNGQ0d1dDQ3UnRxY1JlaFAzQWdXZjhjdk91cU96aDJwcXE3dDZpa1k4?=
 =?utf-8?B?TU92SkZ6enFUek5QNWU3ZE9NMmtvYjVPRjBoakxNNkIrbVhzUFNjdGMwcmpZ?=
 =?utf-8?B?QVZWalB4NlJKcUxpWWNENGlEYWZxSDhFTHFyR3d0UzRObThPN2gvVzBad3Zt?=
 =?utf-8?B?WWt3K3dMcmhiMmlPMFRZWVEyQWJGRnUxdVdhLzVscnJhNitWL1pRTzFoZzV4?=
 =?utf-8?B?NGdDY05OcDVtUWoyVmpadzY1ejkvVnArVjExejNnQXFhdkJOeVV5MEpES28v?=
 =?utf-8?B?MFczcHEvak1zaW1sUUpjK3lydFhaMXRnaHYxUERyR25VaWJ0UE94NHZzTEZu?=
 =?utf-8?B?cGVyV0tweHd6Wkw5MHNXemZlaWFCOWdqb3Bkb3hkWjYrSHVmNlVMc0o2UWJj?=
 =?utf-8?B?SnFUWDhTc3dCeTRvbWpNKzh0bDQ4SDZ5MjF2L3didDg3dEZ2czQyZGJiSVZ0?=
 =?utf-8?B?NUNUSVc3OUE3bEt5Z2Z1QUkvNlNDUHhPWVNOQTExYkEvUzQybk9xV2p0RVRr?=
 =?utf-8?B?UEtQeDJRSmxNbHlLdzF3UHVpM2JnTUlDaGJuUjA1aSsxWmtrZGJsT0JQQ0p6?=
 =?utf-8?B?SlZnUERGK1ZGRTRaL3EvdGI0bGpiVmFObnpHUnA5TTcwNGN1d2xsMisrRWoz?=
 =?utf-8?B?YVQ3aCtZV3lKZE1Oai9kTkNGb0hLTjVCSXJVTzdaM2lGQmJnWDdTOHFSZkt2?=
 =?utf-8?B?VFhndHcxemZLeG9WOE82alNrelg1SStEdk54bG9MSGQxcmdHdy9udEp1LzA1?=
 =?utf-8?B?R0twbHMrUzRnb2ovbDZrbTJMWTVDWHh4b05RV2tTRnJYUG9NUmFOYjZnbjR3?=
 =?utf-8?B?OC8xQVlkSHpOMHBLcEpTU2VEZUFJdUtZT3BrZTYwUDFYdkVQRWErU1A2TmZy?=
 =?utf-8?B?SHdMNmF0QkMzOG5oRzRZRXZ4Vmw4a2l6MmM0UFRyWXp0YmRFd21aWXdnNXRx?=
 =?utf-8?B?QmwvaFFYODM3WkZuTmorVUY0WTZHWFRPVW9GWHRJL2pPVW1VOWx4ckpmQ1p2?=
 =?utf-8?B?WjJkTUlUendUOW9RdkZpaXFQZmpmOEFVdHNDelRXaStzeEFsVm41YUxDTVZY?=
 =?utf-8?B?YWNqWlMzY3huR0NtZHZ5ZHpjbzdKcHpLSTB5eVRqTFlaVDgvSUFuQmhsd2JW?=
 =?utf-8?Q?bG5gCi0hKZQ8tzv9JVCsg4m6v?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f4d085-8c5a-42ae-b700-08db080d104b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 06:40:40.3739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U+TcNOIrmrTAeT7qOeFpMUT745YNd7NePEmya6DCMDFxWIVjA9DtNJgZFq1IbtDhOd7DMJM7+MXYqQXI6eAf3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5543
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IFNhdHVy
ZGF5LCBGZWJydWFyeSA0LCAyMDIzIDE6NDUgQU0NCj4gDQo+IE9uIEZyaSwgRmViIDAzLCAyMDIz
IGF0IDA4OjI2OjQ0QU0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOg0KPiANCj4gPiA+ICsvKioN
Cj4gPiA+ICsgKiBpb21tdV9ncm91cF9yZXBsYWNlX2RvbWFpbiAtIHJlcGxhY2UgdGhlIGRvbWFp
biB0aGF0IGEgZ3JvdXAgaXMNCj4gPiA+IGF0dGFjaGVkIHRvDQo+ID4gPiArICogQG5ld19kb21h
aW46IG5ldyBJT01NVSBkb21haW4gdG8gcmVwbGFjZSB3aXRoDQo+ID4gPiArICogQGdyb3VwOiBJ
T01NVSBncm91cCB0aGF0IHdpbGwgYmUgYXR0YWNoZWQgdG8gdGhlIG5ldyBkb21haW4NCj4gPiA+
ICsgKg0KPiA+ID4gKyAqIFRoaXMgQVBJIGFsbG93cyB0aGUgZ3JvdXAgdG8gc3dpdGNoIGRvbWFp
bnMgd2l0aG91dCBiZWluZyBmb3JjZWQgdG8NCj4gZ28gdG8NCj4gPiA+ICsgKiB0aGUgYmxvY2tp
bmcgZG9tYWluIGluLWJldHdlZW4uDQo+ID4gPiArICoNCj4gPiA+ICsgKiBJZiB0aGUgYXR0YWNo
ZWQgZG9tYWluIGlzIGEgY29yZSBkb21haW4gKGUuZy4gYSBkZWZhdWx0X2RvbWFpbiksIGl0IHdp
bGwNCj4gYWN0DQo+ID4gPiArICoganVzdCBsaWtlIHRoZSBpb21tdV9hdHRhY2hfZ3JvdXAoKS4N
Cj4gPg0KPiA+IEkgdGhpbmsgeW91IG1lYW50ICJ0aGUgY3VycmVudGx5LWF0dGFjaGVkIGRvbWFp
biIsIHdoaWNoIGltcGxpZXMgYQ0KPiA+ICdkZXRhY2hlZCcgc3RhdGUgYXMgeW91IHJlcGxpZWQg
dG8gQmFvbHUuDQo+IA0KPiBIbW0sIEkgZG9uJ3Qgc2VlIGFuIGltcGxpY2F0aW9uLCBzaW5jZSB3
ZSBvbmx5IGhhdmUgZWl0aGVyDQo+ICJ0aGUgYXR0YWNoZWQgZG9tYWluIiBvciAiYSBuZXcgZG9t
YWluIiBpbiB0aGUgY29udGV4dD8NCg0KcHJvYmFibHkganVzdCBtZSByZWFkaW5nIGl0IGFzICJ0
aGUgbmV3bHkgYXR0YWNoZWQgZG9tYWluIi4g8J+Yig0KDQo+IA0KPiBXaXRoIHRoYXQgYmVpbmcg
c2FpZCwgSSBjYW4gYWRkICJjdXJyZW50bHkiIGluIHYyOg0KPiAgKiBJZiB0aGUgY3VycmVudGx5
IGF0dGFjaGVkIGRvbWFpbiBpcyBhIGNvcmUgZG9tYWluIChlLmcuIGEgZGVmYXVsdF9kb21haW4p
LA0KPiAgKiBpdCB3aWxsIGFjdCBqdXN0IGxpa2UgdGhlIGlvbW11X2F0dGFjaF9ncm91cCgpLg0K
PiANCg0KdGhpcyBpcyBjbGVhcmVyLg0K
