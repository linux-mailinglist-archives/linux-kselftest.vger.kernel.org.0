Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16AF73255A
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jun 2023 04:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbjFPCn3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Jun 2023 22:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjFPCn2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Jun 2023 22:43:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F3F270F;
        Thu, 15 Jun 2023 19:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686883406; x=1718419406;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1AjThEKn7IAFO3+MOtCwp9ogewGBqJ9Y27NFqmEM+gU=;
  b=RbXWDsIswD93VyuzMgKBT00SS0HAnNIY+mpBtDzGEC/3sAHZ2BrTw+yy
   HvqZv94Dm+14XDhXYipctwocaHjm7tNpypxbYFn9JaT8sGOAjTP+shlNM
   Xvsa5sPmJ8vDh/1KWRbIr4hoGDpudTnUJ87Swg/oNMY3lE3aaPTn/Dri4
   KA0Myqwva02Rd1+6QiwJvI9Q6qZ6MqvogI85y/q65/xT9mEsjb9le9Crl
   5/4zAyVPSdDqPrndxze3vwYTdplKFkwrvGcB4OVtkDrzBNV7etOUc6u/C
   yJKWlEXYQXwZSeY1cxPi49mBESM4avm4tWzB7cRO5XHYN47OUNF5Bk1j7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="422740228"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="422740228"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 19:43:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="825544468"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="825544468"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jun 2023 19:43:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 19:43:16 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 19:43:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 19:43:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 19:43:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTB4NtMS9STw2j2rWCDNnkZXPLjFSDTiIi5VomtkUyp1nO7ZhwiLbxjPQrMP9kOjtS8L/ZJPjlejXyLXx1i/qGVsbsyXPaB/+b5O2cYtycURAKdzTaP4s+c3Ta3YMmYO0XhpQrGZUDjITgkoCue/qvR5gm8/RNILucLuu1D0YQh4nb1hdRgXjVogXamooTdwnwdvjq/ulpiFhGhpXd+rjRCjWdws/cxtPWFtjDM8YkDFSjTJ5T1LLyLNUNavliKVVvJRu5Amq+qPCAT8XtETo387chGtuSPAUMkr678izMSlXd7g/J4nEaL7pClvuc2T5vQi1itImKA9YO9+UdP7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AjThEKn7IAFO3+MOtCwp9ogewGBqJ9Y27NFqmEM+gU=;
 b=l/tPYejec7E7iK8tPJBr5rilPIZzp29ldusNijlko2uF9v8I1aGok66nCq9VmhXBnTr9lKotFuyBUZH3M0ZJkfvC3eiQ6D4Fwvk+d2nxfclVTDn5aeud6WC9rtmAiu5MQ4ES6eipFpleHhE/bcBnmXMSopZ+L+JpKJvutih+Vv3OaLaw7Zdn67MPcz78v7cHFg/q/tPsYw7QU9Xpb6OJYZubagJUJYOBJwIfozyuKk1nDiM+6jeDa5/ZfI/XaemseRlZOXRs1aaRnw9PwpYCRLjDKZF3YPA5Y/Pf5hCB2CkGdLA4D89fGW47SITnyvYFN+QtP1cjlBrIkLnHr3v1Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB5874.namprd11.prod.outlook.com (2603:10b6:806:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 02:43:13 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6500.026; Fri, 16 Jun 2023
 02:43:13 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Thread-Topic: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Thread-Index: AQHZhBZTNX7dDuLMFEel2CdlG13MGq9hZYMwgAAiQoCAB0Y6EIAVLTqAgA7xydA=
Date:   Fri, 16 Jun 2023 02:43:13 +0000
Message-ID: <BN9PR11MB52763C7B838B04D3200322FD8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <BN9PR11MB5276DAF0A11809CF8433EE338C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZGdiS2m8jcd5OOt5@nvidia.com>
 <BN9PR11MB5276A74B2DA86C79908A420B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZH9AGWf1yRDu/86q@nvidia.com>
In-Reply-To: <ZH9AGWf1yRDu/86q@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB5874:EE_
x-ms-office365-filtering-correlation-id: 6f602eaa-290c-48ba-6747-08db6e136e5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4NAnCfAV4AylAxNbgYB6J9O5LevSoGYPa0tNkW3Z+HDbFUObJ0o6xSNfSouOEq+DA8S++EDG7i3ATMTL7bn1QpSesjPYdQjPWlC74ucBNXqF0MiV9tv6nBPl9kXnxXcrr9DqRG6ROA8Ym+ra7AbN14BdBpkzkpVS7K90dK24juTt89Sixfj6uKZuY80sQCt37x9KpSC/waKy91MHlTI9VvEpG0JNEqBfHiZR9SJKrme5Fd3SV4k8kO1PWQ42QJ64q7yM71s5aO5WMlajELo2SzoezuT2ueAOEAWQz85gJyQt4PAmTGVXygmeAHvs/SLVeHHtANaFUgsR/dm+KPE9y+7fq/sCijFDIXenpVFV5SiYQ4UDk1t9aTenoaxSr1JPo0kV2ntMPrRvyU4f/0EuIeU8DsZuL//HpSyDigNntYf7v2Xftoh52JNHaniozpM5ztgnGkzpsS1pBruAz8ccuLHDOg1duZQVMIXOgZLeXKqmD6qbfdoC+VgSiClF+Q+4iLAY6hpmRID/0lE+RE4NYv5pVktUUm8mDxZ6WgQPmCrW6nF/3S7KARiZ6KgdYpg+k/s3sXYDeP6qMnG0iSYLAV/1HVzW6/TryyfMdSyfsoAi77nim1Vy+xRQ5p3kmKJo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199021)(52536014)(5660300002)(82960400001)(122000001)(186003)(38100700002)(83380400001)(2906002)(6506007)(7416002)(478600001)(26005)(9686003)(38070700005)(55016003)(66446008)(6916009)(66946007)(316002)(33656002)(66476007)(71200400001)(64756008)(66556008)(8936002)(8676002)(41300700001)(7696005)(86362001)(76116006)(4326008)(54906003)(66899021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXNmZURaSHByL1lHcU8zbTdLMGxQdExIc3d3SEJTWDJScUpVMTlmc0pOd1Fo?=
 =?utf-8?B?eUw0Y0JxRXRkVnRJYndudCtSVGM5VjE0TmJSR3ZJNEpUbk5GT1NKVkVyc2J5?=
 =?utf-8?B?RmN0TGZNd0tIcGF1REhUZjRPNXZhOTBWeVVVSnc4YWJHNjBqc3lnajFwL3RC?=
 =?utf-8?B?MlVIMlpzOTJPOVVBeWtHU3FuUTFLWHRsemQxY0IvWjUzSWlMd1FTYUUyeENq?=
 =?utf-8?B?M3dyYWsvRHVYS1BnYjRDdUxEemJJK1VlMTVzNWFud0tIdmNVWnZvQjY5YVg4?=
 =?utf-8?B?K0FuaEZGKy83QUxrWWdnTHNnalZNWWVUOTdtdjY0VFh5aG1kM0VhQ2NGZWlF?=
 =?utf-8?B?WGk2VFRWYkxGRWpxK0Zqd3RqeHNmaXcvU0pXOTFMMkx2Wk9zSEUraXlqSE9K?=
 =?utf-8?B?RmZIYjd2a2gwaC9qY0VtVHVERzRBY3RJN2s3Ulc3MHFXeXNDc0JnenpkQjdD?=
 =?utf-8?B?bXdSMlI0WDkxM0ZpN3ZmTHpQZFNzU0FXSjdJa0JIUlE0U00yL2FGb0dHd3Ew?=
 =?utf-8?B?SlBXbGZOQTBsY0QzdjhrcmdhU1NPZ2tqbSs2d0IwYVdYeDNnRmlsRkFjaUtw?=
 =?utf-8?B?cUdYd2U2cEdlMDFtcVNJbXBjbHkzc0s0TjhzVlM3VEhVUUJxdUQyK3c3eENy?=
 =?utf-8?B?d1g5ZzB5VHErb1psaHZQNWptRmFUOE9MRFhpTlpXekg5anRLcGE0a3FOaFZ6?=
 =?utf-8?B?azRoMVRjekZSTi94ejRsVWVReUxJeEFBVFRvR3JEU3dmYk5NYlEyeVlYN3dx?=
 =?utf-8?B?WVArRm1wN0dxam41Wks0eVBxY3JxVlNKSEtkZW04cXMwVnhoRkFtNzhYSk9u?=
 =?utf-8?B?Q0M4c211bjBzVWtoYWlUYjNNZlZjZXgyNGEwSTlyRlZnYkpCMkFPTWRJak5o?=
 =?utf-8?B?SWQ3UTNlL3kvZ2hSWnBjaExGRVg5RVIyZVVNY1dwWFRSRDdhbFlVVmJCOFQz?=
 =?utf-8?B?aVdzQVhqcXh6VnVoK0Y0dVNieTNnNUtqK3RBbWdNa2tzRVNqUytNdldxK3J1?=
 =?utf-8?B?QTQ3WmR3UytneFZmbkZPajJlSHNabGZjMFZXZ2k0eG8vZkw2c1V2ekZzNmI2?=
 =?utf-8?B?SEJMeXRXYWozWGdJeGUzalNFVzV0cnBhUC9LYWhVMFlNdlNjTmVRZ0tGMC9m?=
 =?utf-8?B?WS8xQ3A4cGNtRkR1QmREOXpTdE8zbFp0UTBoMlhTYlVndlZtOFd6cUlHVUo4?=
 =?utf-8?B?S3htaWlZcENPYnVqWXlBb0FFMmlPUm5LUlA1cVlTekE3Nno4aS9EV2xtZUJI?=
 =?utf-8?B?MXNzWmFSUkVzamNuN05yZEV5MlRJM3RTQXVRb0prMDRMamNpU0hZRlRtOXdK?=
 =?utf-8?B?Y0svQVhINGg0YTN3dTdsQ2VDakdrR0ZnT0o4U21qRjZPam1Da1RpZmkyb1Vv?=
 =?utf-8?B?WnhQa3loZjcvUC81UklHUzlCbnZheTRKcUdTN3BZSTJmaFQxUzdrOG9kUWUx?=
 =?utf-8?B?TE1kbmdSUHl4bW1NNWVnelFoWGZaYWRickd0Y01ydmI3K2tIUW9NR0lBY2Nw?=
 =?utf-8?B?RGgxZUZGSG0vUWxGZlFYcnJLSzFWRFFkbkNNNm9EZVF2OE82b3BkYUxJc1Ix?=
 =?utf-8?B?dmFVLzgydDB5SUFFNmprcldxWk4xR25jUHQveWl2dnJ3Slk0SUhMNDYxck1m?=
 =?utf-8?B?WTR0bFgzV2h4WGFkVUlDMzJLMGc0WmlSVUNhUjg2b3FhMkZpMU91UXRUZkkx?=
 =?utf-8?B?dytUdTZFSjRRaU82eC9NWUNETkRsZksrZkVYVzJlaFZpR1o1cGR2Z2czUjBE?=
 =?utf-8?B?ZEZJTkQ4Uk1MZlNxS1N6RHRBa0hycGNlNXJZd1JuQ0cvWkJjcndqWmQ1SDEx?=
 =?utf-8?B?TU9Ib3R1V2VkNSttNVcveGxBNFN4cFJydmRzYjFDNU52SHVINUMyU2loSStK?=
 =?utf-8?B?M2xwRFltZ3lRTWpjSVk1bXJlM0draExUeW5XSmszeW5hM3lZb0tTL3djaFUx?=
 =?utf-8?B?clA5blFhSUtLVjkzNFJYSnk2VFZjNWVXdjQyakN2SU96cXBDc1lkWHdUUHU0?=
 =?utf-8?B?OW15eGVWNXRDc2FBUEw0dllkZUUrZXFzdVRFd0xJS2c0U3dreG9mRXpyUTFz?=
 =?utf-8?B?RFFEWWV1ZmJsSXhuY1o5RlJObkg2bmpTYllJTTN1Z1pTWUFTa04wOUlWU3Az?=
 =?utf-8?Q?3snFebFO3l6Eq1gz7eSYHByKO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f602eaa-290c-48ba-6747-08db6e136e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 02:43:13.7567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sl2g7O5FzsMdZOJIGgavnpOGVWmR1nW3aGU1NAIc0aG/0R3njhyiOUmH/ngKvE/7BVgnspsYiU7h/q1RonIbyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5874
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

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBUdWVzZGF5
LCBKdW5lIDYsIDIwMjMgMTA6MTggUE0NCj4gDQo+ID4gPiA+IEl0J3Mgbm90IG5lY2Vzc2FyaWx5
IHRvIGFkZCByZXNlcnZlZCByZWdpb25zIHRvIHRoZSBJT0FTIG9mIHRoZSBwYXJlbnQNCj4gPiA+
ID4gaHdwdCBzaW5jZSB0aGUgZGV2aWNlIGRvZXNuJ3QgYWNjZXNzIHRoYXQgYWRkcmVzcyBzcGFj
ZSBhZnRlciBpdCdzDQo+ID4gPiA+IGF0dGFjaGVkIHRvIHN0YWdlLTEuIFRoZSBwYXJlbnQgaXMg
dXNlZCBvbmx5IGZvciBhZGRyZXNzIHRyYW5zbGF0aW9uDQo+ID4gPiA+IGluIHRoZSBpb21tdSBz
aWRlLg0KPiA+ID4NCj4gPiA+IEJ1dCBpZiB3ZSBkb24ndCBwdXQgdGhlbSBpbiB0aGUgSU9BUyBv
ZiB0aGUgcGFyZW50IHRoZXJlIGlzIG5vIHdheSBmb3INCj4gPiA+IHVzZXJzcGFjZSB0byBsZWFy
biB3aGF0IHRoZXkgYXJlIHRvIGZvcndhcmQgdG8gdGhlIFZNID8NCj4gPg0KPiA+IGVtbW0gSSB3
b25kZXIgd2hldGhlciB0aGF0IGlzIHRoZSByaWdodCBpbnRlcmZhY2UgdG8gcmVwb3J0DQo+ID4g
cGVyLWRldmljZSByZXNlcnZlZCByZWdpb25zLg0KPiANCj4gVGhlIGlvbW11IGRyaXZlciBuZWVk
cyB0byByZXBvcnQgZGlmZmVyZW50IHJlc2VydmVkIHJlZ2lvbnMgZm9yIHRoZSBTMQ0KPiBhbmQg
UzIgaW9tbXVfZG9tYWlucywgDQoNCkkgY2FuIHNlZSB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIFJJ
RCBhbmQgUklEK1BBU0lELCBidXQgbm90IHN1cmUgd2hldGhlcg0KaXQncyBhIGFjdHVhbCByZXF1
aXJlbWVudCByZWdhcmRpbmcgdG8gYXR0YWNoZWQgZG9tYWluLg0KDQplLmcuIGlmIG9ubHkgdGFs
a2luZyBhYm91dCBSSUQgdGhlbiB0aGUgc2FtZSBzZXQgb2YgcmVzZXJ2ZWQgcmVnaW9ucyBzaG91
bGQNCmJlIHJlcG9ydGVkIGZvciBib3RoIFMxIGF0dGFjaCBhbmQgUzIgYXR0YWNoLg0KDQo+IGFu
ZCB0aGUgSU9BUyBzaG91bGQgb25seSBnZXQgdGhlIHJlc2VydmVkIHJlZ2lvbnMgZm9yIHRoZSBT
Mi4NCj4gDQo+IEN1cnJlbnRseSB0aGUgQVBJIGhhcyBubyB3YXkgdG8gcmVwb3J0IHBlci1kb21h
aW4gcmVzZXJ2ZWQgcmVnaW9ucyBhbmQNCj4gdGhhdCBpcyBwb3NzaWJseSBPSyBmb3Igbm93LiBU
aGUgUzIgcmVhbGx5IGRvZXNuJ3QgaGF2ZSByZXNlcnZlZA0KPiByZWdpb25zIGJleW9uZCB0aGUg
ZG9tYWluIGFwZXJ0dXJlLg0KPiANCj4gU28gYW4gaW9jdGwgdG8gZGlyZWN0bHkgcXVlcnkgdGhl
IHJlc2VydmVkIHJlZ2lvbnMgZm9yIGEgZGV2X2lkIG1ha2VzDQo+IHNlbnNlLg0KDQpPciBtb3Jl
IHNwZWNpZmljYWxseSBxdWVyeSB0aGUgcmVzZXJ2ZWQgcmVnaW9ucyBmb3IgUklELWJhc2VkIGFj
Y2Vzcy4NCg0KSWRlYWxseSBmb3IgUEFTSUQgdGhlcmUgaXMgbm8gcmVzZXJ2ZWQgcmVnaW9uIG90
aGVyd2lzZSBTVkEgd29uJ3Qgd29yay4g8J+Yig0KDQo+IA0KPiA+ID4gU2luY2Ugd2UgZXhwZWN0
IHRoZSBwYXJlbnQgSU9BUyB0byBiZSB1c2FibGUgaW4gYW4gaWRlbnRpdHkgbW9kZSBJDQo+ID4g
PiB0aGluayB0aGV5IHNob3VsZCBiZSBhZGRlZCwgYXQgbGVhc3QgSSBjYW4ndCBzZWUgYSByZWFz
b24gbm90IHRvIGFkZA0KPiA+ID4gdGhlbS4NCj4gPg0KPiA+IHRoaXMgaXMgYSBnb29kIHBvaW50
Lg0KPiANCj4gQnV0IGl0IG1peGVzIHRoaW5ncw0KPiANCj4gVGhlIFMyIGRvZXNuJ3QgaGF2ZSBy
ZXNlcnZlZCByYW5nZXMgcmVzdHJpY3Rpb25zLCB3ZSBhbHdheXMgaGF2ZSBzb21lDQo+IG1vZGVs
IG9mIGEgUzEsIGV2ZW4gZm9yIGlkZW50aXR5IG1vZGUsIHRoYXQgd291bGQgY2FycnkgdGhlIHJl
c2VydmVkDQo+IHJhbmdlcy4NCj4gDQo+ID4gV2l0aCB0aGF0IGl0IG1ha2VzIG1vcmUgc2Vuc2Ug
dG8gbWFrZSBpdCBhIHZlbmRvciBzcGVjaWZpYyBjaG9pY2UuDQo+IA0KPiBJdCBpc24ndCB2ZW5k
b3Igc3BlY2lmaWMsIHRoZSByYW5nZXMgY29tZSBmcm9tIHRoZSBkb21haW4gdGhhdCBpcw0KPiBh
dHRhY2hlZCB0byB0aGUgSU9BUywgYW5kIHdlIHNpbXBseSBkb24ndCBpbXBvcnQgcmFuZ2VzIGZv
ciBhIFMyDQo+IGRvbWFpbi4NCj4gDQoNCldpdGggYWJvdmUgSSB0aGluayB0aGUgcmFuZ2VzIGFy
ZSBzdGF0aWMgcGVyIGRldmljZS4NCg0KV2hlbiB0YWxraW5nIGFib3V0IFJJRC1iYXNlZCBuZXN0
aW5nIGFsb25lLCBBUk0gbmVlZHMgdG8gYWRkIHJlc2VydmVkDQpyZWdpb25zIHRvIHRoZSBwYXJl
bnQgSU9BUyBhcyBpZGVudGl0eSBpcyBhIHZhbGlkIFMxIG1vZGUgaW4gbmVzdGluZy4NCg0KQnV0
IGZvciBJbnRlbCBSSUQgbmVzdGluZyBleGNsdWRlcyBpZGVudGl0eSAod2hpY2ggYmVjb21lcyBh
IGRpcmVjdA0KYXR0YWNoIHRvIFMyKSBzbyB0aGUgcmVzZXJ2ZWQgcmVnaW9ucyBhcHBseSB0byBT
MSBpbnN0ZWFkIG9mIHRoZSBwYXJlbnQgSU9BUy4NCg==
