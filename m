Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DCB6BDD5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 01:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjCQAIe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 20:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjCQAIc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 20:08:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28D5E39B;
        Thu, 16 Mar 2023 17:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679011710; x=1710547710;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A7cB/+m6UPHnEscdJg6Khv3s5Q9z3JooLbJqEcZagJQ=;
  b=cGQtN48bszP5mCbVWOl1K6dG9O5PZiZp+gkWWOR97nFHkJYPV+R561f9
   SVMW6bepxCiOryPBdOmgWQp0buxLS03GFd7xehAxTUBuQAcR5ptv/RcmR
   210hg5WwNG+p4kvT1qqlUUq9Xrd9Q3A2aFKruzW8+h5sh0RqPpgtAoBM0
   OHJn8QSgK0qYF0p8sZ4VVtTgt7oxl3LJruwJ8DLi8fovonXWelOUyg7bD
   O3vdDpSbsp1241CS861CqJsAmpnNDQWm2+HsaRT9/Qiijka4sHOyHd1ZJ
   vxyh3sV8QHalMJJJCGV+fuJtZDMQ75jFmGq/qEpTkKxUEBL2oA6vqrYDf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="336835027"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="336835027"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 17:08:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="854247895"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="854247895"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 16 Mar 2023 17:08:29 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 17:08:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 17:08:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 17:08:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWflYBmbFsLhHOhKDzPKS9SORj9yyjIsqDRS2kG+FfmAx5ERGKXEiV7uxNjsR6hhpuF6/gN8jGySXWkP+Yd9NBgZM4Rl17RAtSaCrv1Php8Tjuwfrkurl0c30d1WTb3vtrOduhmBqMm74dZ4otKSeVwnDK5EsLE2lDbcuvZ13wTXNyN3n/sBkt7lN0WdssF2N6hcl0IZI1ey/DokBmvMen6l96qil7KcnxAx0b84t0sp/x8ndoyPuzv0tuEWAeO8+5cBq+DV9OZU8yUgzWbN0C30QqpP/G+UcPK5J6laaf9J3KhWx/388Zr4Jta8lqCV2gQydx0YqaHJDyinEB8N7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7cB/+m6UPHnEscdJg6Khv3s5Q9z3JooLbJqEcZagJQ=;
 b=K4yGP20zf8X1gaSrgdYI/bWnAmUit8PCpS+UnHOKqUa0Dg98OGzSukcZXGgOW5qspXCzoO9xIxmcDTcOvyKuSds8FZn/7wiGGl+cbwNE7JaKKdDcdUZH+QY6QkkR71WAHJRcLZhPwZ50lf3vlo4HvICpsizJW+Ux6XKcirgSnvGRTRWr9/uLu3Ji2Y2J0GdnTu0HcdbDxGU8eIM6H6IWqEXEeZLkGFvicIdfn4Hh3+/lnAP08ZM4SVMt2KcCrCLbO5yulsASo1Nqr6pFX47X6BeCqwej7e8/KS/cX4ehZwytkH65uGyFNc8g2fhaQ9hVCaNsqsGyDImvcp5R8WcJ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB6799.namprd11.prod.outlook.com (2603:10b6:806:261::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Fri, 17 Mar
 2023 00:08:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 00:08:26 +0000
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] iommu: Add new iommu op to get iommu hardware
 information
Thread-Topic: [PATCH v2 2/4] iommu: Add new iommu op to get iommu hardware
 information
Thread-Index: AQHZUlxYm6GOmk6wmUW710g04eg+cq79GCcggAAGP4CAAQVxAA==
Date:   Fri, 17 Mar 2023 00:08:25 +0000
Message-ID: <BN9PR11MB5276520530F017001340697B8CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230309075358.571567-1-yi.l.liu@intel.com>
 <20230309075358.571567-3-yi.l.liu@intel.com>
 <BN9PR11MB5276C6A0F26954A42B8C23498CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7b588f1e-ddd0-d7e7-984b-29e8be8f19ec@linux.intel.com>
In-Reply-To: <7b588f1e-ddd0-d7e7-984b-29e8be8f19ec@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB6799:EE_
x-ms-office365-filtering-correlation-id: bf2c6756-a2d1-4629-c111-08db267bbace
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g+2XyJs2Nx+kSj1V8lpoYZPbWbEcPLYZZo/5729QbInqAVfJsS2WK4Xbifaxxhv1nIfVPDYNOlxzrHEc+6OYecbYNFQpbYdvQH3Jilzs0wWXdXUqLDVMymt8YQYPauRvkCiKexpjNuNi806AUsrXyO3GpJMAEoUesNat5VtwauLBy4V4DXPefnlpHEt2Z9gbgWPNHISyHCUdKDSsMXNJNJ2Tm8e82cusMSa07Pd3X4REPqeouZzP4wX8nOF7Y/fWU7pRVBWTZqLoKsfH7cmZRxZGqrfVKOnG12DJ2Hj/B1JjKHNgML8XIcBkGE0GVkBM8H5pix5oesGuL4UKiUwo/YY1/AcRIuK1tt/Q3lKmX6Xakdeuv8MBLcEDS4D9GvvtX5sQSIBTW03AyED8Vbiq+KcG/5ovV7t29FBcdLBkT4L62S7pnh3/LLfw3L2duO1k8kv4eTmpj4RXXsXRbHe8+pLFnRkprxqKqqlSr513ZRqvEiJBGTn5SW+Dfi8x28ssNEQ9bKGJDKq8TpqhbUX7ECfNzOQa9YPZH+h56gZfgCzp/Xx6qtgQbzSoLg93w+5DvL/PKFZ2dOz0o+SAdEU7FFC4UG1LQiXxSh+xCC+YsQ8X+yBDcWa3lRiviqvUpkcRiaC5V095HsN5WWDCHBQwppW/7atvlvaOG70i0tdUPNQlt0S3wkHO4vyp47jLArdlQxNNw8RQr2reK/AT9ICklg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199018)(26005)(38100700002)(53546011)(6506007)(7416002)(478600001)(83380400001)(55016003)(5660300002)(82960400001)(122000001)(7696005)(2906002)(71200400001)(33656002)(316002)(86362001)(38070700005)(186003)(9686003)(52536014)(8676002)(41300700001)(4326008)(8936002)(110136005)(54906003)(66556008)(66476007)(64756008)(66446008)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEhudDNXOWlyS1B0ZmNmRm5hUzBKOWtrSWFoSzN2SmV0OFZmNHViN211Q0hO?=
 =?utf-8?B?NWxZRUkvVHBjRWlvMmMxYzlkQ3M5M29ZMUhROEh3dWNRd0ZnR3NKbVcxaUNU?=
 =?utf-8?B?a2UwMThjL0JNWDNtQ2pyYlJaeXNqNFYwOTZvc281L0x4RFJWek0rN2VwcURq?=
 =?utf-8?B?elJONXZsQ2Iyd2EzZkViRE8rTm02Q3dPZDNSWVh6ZndldmM1Y2gxVE52T09D?=
 =?utf-8?B?U3p2NWt6dDZRVlFpZHRiMVBBblI0RU10OUhYcENRL1JhTzR0NUFILys4RTR6?=
 =?utf-8?B?NlVEZnR3YmY2aDlrZEV3ejN2MVgzaTVPSHoxRTY3TlNMQnVjSHJZWjRpTDMx?=
 =?utf-8?B?Rk44anZlR0pyaDR3YWE3bEUzdUp3ZWRWL3dJU2h4Sm0weWR0VFc1RmIrMEF4?=
 =?utf-8?B?YVNWUVpFa1drNVZIYXYzM1VYMGRsN0RSMzJIeUV2OXVhbFduSlJTdVZMUkJZ?=
 =?utf-8?B?bGhRV0pUTW9kVDZlcE5HZ1pUUytBZW1ncFlTc0JVakVVU01UbDBiOFR3ZURa?=
 =?utf-8?B?eEtGMGNJd3BmWXFxYUIrS2tGSWdNTWk0UEdNb254ZkdTaXRFQjR1WDJXYTZX?=
 =?utf-8?B?eG5RUHdrTnFRRVlHQklIMWxTWDdUcWg4ek5YaXJ2VkNsYlQzQ1k5aFFOMjRC?=
 =?utf-8?B?LzdqYm4yN2Evd01nV1ErU0FBOCt0MkRQa0x4cWNHWTd5cmNiY2VDVVhGb2tl?=
 =?utf-8?B?bVAzeEVNY0EzaS8ySlRPRTBLaXVvdno1dHRJVjJaZkRQd09RMGEzZUtYNTNz?=
 =?utf-8?B?eHNEaGJCWmdUY2FkSmliUXljR3M4bmsvNEZFbjd4ZU1MWDg0R0tIRDRYcEs4?=
 =?utf-8?B?MnZlbC9YNFV2SzRPMVMrNjZPREN6M3JxQTRpcWo5NmpUNFFtQkJhc3pZN0JC?=
 =?utf-8?B?RE1rWHpqWVF4NzQ5VFN3SzZJZEYvdmthTndxNEQ5UzlBcGlnanlOQ3Nad09O?=
 =?utf-8?B?a1ZQVmpzc3FUWWJwbk1GYkMvZ2c0OTkzVVFZbW5rRUxZM1JYaDY1aVBKUEJV?=
 =?utf-8?B?TldDYlUySjF3SC9XWFE4WHEyWFVQNHBlb2JVNUxCdVp6N2JVUkxCTEJkSlVU?=
 =?utf-8?B?bSs5SXRHN2g5VEJ3VlVUS25vTFhXMEcvYSsvelRDb0wyUW5YTkliTVJOWmNl?=
 =?utf-8?B?WHZSdURWeXdSZWtJaWRyMjJQei9yNXM5VUwzTVZwTVEzR0wrd2hNcUw4RVJx?=
 =?utf-8?B?djRPT2NTeDBZcHFNYzlBdWZ3U015dEpkcElpaHZHcmRCaTZKeWpneGtpZlIx?=
 =?utf-8?B?Qjc2Q1Ria2R5SG9RcHVDc2J3MXc5dmJRcWVMdzZSWlFXbEljSjlvTGErZGN5?=
 =?utf-8?B?dWw4K256WEU2cVB4dThmdzRoR3pmeXF4bzV6VnZiQ1VVdEtZZWJLMGx2bjVI?=
 =?utf-8?B?R2Z0TVhvOFl1ZmtCUjZ6SS9Tek93Ymg2b0tVMDhrdUhqQjhWaThYWHFEVVNM?=
 =?utf-8?B?OGlDelc4UWhvU2NtbUpiZHJvK1ZEYTdkSC9xdkJkNFpZZldpamMvUURsVzBl?=
 =?utf-8?B?bWNNNVBsR1NTSnZZL1doZmY1bUhyOWpXVllSRkhWVlM3ZjJvZU41R0pvUzBE?=
 =?utf-8?B?b1JUcG53UFJHQ2RKSXpNTzlkR1U4Y1cyYyt0YjhYb09LK0JCRTFWRWNyWEpG?=
 =?utf-8?B?cXJCVEdkVDJzMWE3UG5nSWhTNG5pUG1GVEZXYVBhU3BEc0tOSE9lanc5TnJr?=
 =?utf-8?B?Qmc1SFA5WmVmMndqbHAyRGxBa3lLN0NKWVFCaVNuUUgzNmRVVFpTWG9HK3J1?=
 =?utf-8?B?c3JQZnRQODFJbmt6MnRUSjh3TG9Yb0RZaUoxWkFSYjdNVFNLMVcrYTFWSVBR?=
 =?utf-8?B?emo3M0lTT2JUckVSRjhnTy9RQThHOU5pVEg0dzVxcUZMWWhiVmliTFBHZHJR?=
 =?utf-8?B?Q2ZXYXJUdmJzMFFmK2syYkhCQjVOOW5sOE42anVBZXgzZ295TXdTRURlVHdv?=
 =?utf-8?B?Vnl4OTEyMUZVZ1E4VzdPQm9oWnN5b3JLdmtFV29lNUZZaUxOSEQvUE9FZy91?=
 =?utf-8?B?a2xOcnI1U1M3UTU2R2NYVWVOeHpLUU91NTE5ZTAwUDhJMTJrRHRmMHRJZ3dr?=
 =?utf-8?B?UFF2c251UmR5ODhHbmh3Vlhmc25XNHZlZjlnQ3JYdnlOaEliZGRkTTEwSlhm?=
 =?utf-8?Q?bVNjcubyqLfex9Yk9DXET6yfF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2c6756-a2d1-4629-c111-08db267bbace
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 00:08:25.9533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B+oZi1bji2LRpJuqi7ou/cWcRvbdv8DnuWU8Jboxj3Ien31O4qMK/GExENbUvH8YBZdHsg4ZeI9K0AQRIdKkYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6799
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgTWFyY2ggMTYsIDIwMjMgNDozMCBQTQ0KPiANCj4gT24gMjAyMy8zLzE2IDE2OjE2LCBU
aWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gKyAqICAgICAgICAgICBhbGxvY2F0ZWQgaW4gdGhlIElP
TU1VIGRyaXZlciBhbmQgdGhlIGNhbGxlciBzaG91bGQgZnJlZSBpdA0KPiA+PiArICogICAgICAg
ICAgIGFmdGVyIHVzZS4gUmV0dXJuIHRoZSBkYXRhIGJ1ZmZlciBpZiBzdWNjZXNzLCBvciBFUlJf
UFRSIG9uDQo+ID4+ICsgKiAgICAgICAgICAgZmFpbHVyZS4NCj4gPj4gICAgKiBAZG9tYWluX2Fs
bG9jOiBhbGxvY2F0ZSBpb21tdSBkb21haW4NCj4gPj4gICAgKiBAcHJvYmVfZGV2aWNlOiBBZGQg
ZGV2aWNlIHRvIGlvbW11IGRyaXZlciBoYW5kbGluZw0KPiA+PiAgICAqIEByZWxlYXNlX2Rldmlj
ZTogUmVtb3ZlIGRldmljZSBmcm9tIGlvbW11IGRyaXZlciBoYW5kbGluZw0KPiA+PiBAQCAtMjQ2
LDExICsyNTIsMTcgQEAgc3RydWN0IGlvbW11X2lvdGxiX2dhdGhlciB7DQo+ID4+ICAgICogQHJl
bW92ZV9kZXZfcGFzaWQ6IFJlbW92ZSBhbnkgdHJhbnNsYXRpb24gY29uZmlndXJhdGlvbnMgb2Yg
YQ0KPiBzcGVjaWZpYw0KPiA+PiAgICAqICAgICAgICAgICAgICAgICAgICBwYXNpZCwgc28gdGhh
dCBhbnkgRE1BIHRyYW5zYWN0aW9ucyB3aXRoIHRoaXMgcGFzaWQNCj4gPj4gICAgKiAgICAgICAg
ICAgICAgICAgICAgd2lsbCBiZSBibG9ja2VkIGJ5IHRoZSBoYXJkd2FyZS4NCj4gPj4gKyAqIEBk
cml2ZXJfdHlwZTogT25lIG9mIGVudW0gaW9tbXVfaHdfaW5mb190eXBlLiBUaGlzIGlzIHVzZWQg
aW4gdGhlDQo+ID4+IGh3X2luZm8NCj4gPj4gKyAqICAgICAgICAgICAgICAgcmVwb3J0aW5nIHBh
dGguIEZvciB0aGUgZHJpdmVycyB0aGF0IHN1cHBvcnRzIGl0LCBhIHVuaXF1ZQ0KPiA+PiArICog
ICAgICAgICAgICAgICB0eXBlIHNob3VsZCBiZSBkZWZpbmVkLiBGb3IgdGhlIGRyaXZlciB0aGF0
IGRvZXMgbm90IHN1cHBvcnQNCj4gPj4gKyAqICAgICAgICAgICAgICAgaXQsIHRoaXMgZmllbGQg
aXMgdGhlIElPTU1VX0hXX0lORk9fVFlQRV9ERUZBVUxUIHRoYXQgaXMgMC4NCj4gPj4gKyAqICAg
ICAgICAgICAgICAgSGVuY2UsIHN1Y2ggZHJpdmVycyBkbyBub3QgbmVlZCB0byBjYXJlIHRoaXMg
ZmllbGQuDQo+ID4gVGhlIG1lYW5pbmcgb2YgImRyaXZlcl90eXBlIiBpcyBtdWNoIGJyb2FkZXIg
dGhhbiByZXBvcnRpbmcgaHdfaW5mby4NCj4gPg0KPiA+IGxldCdzIGJlIGFjY3VyYXRlIHRvIGNh
bGwgaXQgYXMgImh3X2luZm9fdHlwZSIuIGFuZCB3aGlsZSB3ZSBoYXZlIHR3bw0KPiA+IHNlcGFy
YXRlIGZpZWxkcyBmb3Igb25lIGZlYXR1cmUgd2hlcmUgaXMgdGhlIGNoZWNrIGVuZm9yY2VkIG9u
IHdoZXRoZXINCj4gPiBib3RoIGFyZSBwcm92aWRlZD8NCj4gPg0KPiA+IElzIGl0IHNpbXBsZXIg
dG8gcmV0dXJuIHRoZSB0eXBlIGRpcmVjdGx5IGluIEBod19pbmZvPw0KPiANCj4gSWYgSSByZW1l
bWJlciBjb3JyZWN0bHksIHRoZSB2ZW5kb3IgaW9tbXUgdHlwZSBhbmQgaGFyZHdhcmUgaW5mbyBh
cmUNCj4gcmVwb3J0ZWQgdG8gdXNlciBzcGFjZSBzZXBhcmF0ZWx5Lg0KPiANCg0KdGhlcmUgaXMg
b25seSBvbmUgSU9NTVVfREVWSUNFX0dFVF9IV19JTkZPIGNtZC4gSXQncyB3cml0dGVuIGFzOg0K
DQoJZGF0YSA9IG9wcy0+aHdfaW5mbyhpZGV2LT5kZXYsICZkYXRhX2xlbik7DQoJY29weV90b191
c2VyKHU2NF90b191c2VyX3B0cihjbWQtPmRhdGFfcHRyKSwgZGF0YSwgbGVuZ3RoKTsNCgljbWQt
Pm91dF9kYXRhX3R5cGUgPSBvcHMtPmRyaXZlcl90eXBlOw0K
