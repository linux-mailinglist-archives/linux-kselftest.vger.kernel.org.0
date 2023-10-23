Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5823E7D30AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Oct 2023 13:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjJWLBL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 07:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjJWLBJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 07:01:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB542D6E;
        Mon, 23 Oct 2023 04:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698058864; x=1729594864;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eh+jD/P04pGTUitdmn8rtQUMbWxv9s2yXDtYqjhLqIo=;
  b=K91I2IDd1z8MUmR3316ZV1QDYUrm6YVCKGd9002ud5BouGxCthFtFIyu
   Nz3PnTm4CUyM65Cw3aEdeEvocSfhcPCHsf2B++qC0ks1g4twegIYLNAxT
   Af36skFrXI8uNE3zPKLNzfRdakaHjLaRXbkKFHwZVc3UJ3krUAPuHGNkQ
   pxHuGjaD/ec51lHUZ7V1BCIVt04fGpar/ZpjqgbB0P+ZQqQmL9KA73cXz
   hmSPMPU0+C4hDJgendJo9wsEOHV5bXDrCNAY9pNfOA8lL5ri2CSKQEWIn
   Jt8hrSKR+rNknyMdvb/VdH53sMx2dwtxeWp3wD19xbNfqpjtwtfooptyU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="8370951"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="8370951"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 04:01:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="931655266"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="931655266"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 04:01:02 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 04:01:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 04:01:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 04:01:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPGlyJ4V6wvHsBYo72pKFuIF2vxSImaUIrrhQxuDFSU6Z1G61ar7/UsrbvnlW5jmtNpiNXSS/mQNGy8v6KwGzc7iJLJ0PfxsVt92HnLVX19P2NT14YBGxOgSMRgwOWHRYHeDApdPWHlqPeM4RlWIixjxbpBqDEo8N+XK/QM3SSvII7nZ6pyDAqVkTGAy72Vk/agfe6cbI6o1aLppiYWl2FS2aoJ8YaBxYpEi8rPqYiJZdBIN2SeziZ9QuotGZhdZgSvpHTeHq45vMQBd4CTImxemhQJoFL2kOLKiHyzNPqiHspXyKw5wwv9x33o32jzp0fzx9PMl5p3SZUiikP1nkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eh+jD/P04pGTUitdmn8rtQUMbWxv9s2yXDtYqjhLqIo=;
 b=ZKIhtgYrAjA04Pmc6+QqNM0BDuIJLG73KfqcG3LpVvMcxFKx/MuN/Z/uw5QySGSdCtiT0udoWpOr0c2IYVqHKI0RCiiVC88V812CymaGTmSezKSB5arDZS0iRRHSe3JLvvJzA0rEzxh4nZA2vuhQLpKs5pt+cequUxjjuxViTKCbrOIO/9vrv67YzecAlb0BomzHeLU7wSWh2o0ngVrIw81qaY+y5WrTloMKNg9HtdwcKPuFxRJi+onXZd/6ZHgdNgD2VzRmAR5dDapMSt/vtHmQPXkYueY5HhTNBvRzhp9wwsjlGW5Usouoh5a984wCJBQ//CLblRYtOnjKbEEFKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW5PR11MB5882.namprd11.prod.outlook.com (2603:10b6:303:19e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 11:00:58 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 11:00:58 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "Zeng, Xin" <xin.zeng@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v6 3/8] iommu/vt-d: Add helper for nested domain
 allocation
Thread-Topic: [PATCH v6 3/8] iommu/vt-d: Add helper for nested domain
 allocation
Thread-Index: AQHaAzhrZnMEeg4mikyyEkCHpv0KS7BSkHYAgASpZPA=
Date:   Mon, 23 Oct 2023 11:00:58 +0000
Message-ID: <DS0PR11MB75291AC4CFD0B6928ADDD94BC3D8A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20231020093246.17015-1-yi.l.liu@intel.com>
 <20231020093246.17015-4-yi.l.liu@intel.com>
 <d3c2f048-551c-4a35-81c1-212f15c8ab8c@linux.intel.com>
In-Reply-To: <d3c2f048-551c-4a35-81c1-212f15c8ab8c@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|MW5PR11MB5882:EE_
x-ms-office365-filtering-correlation-id: ecf9d54f-cc4b-4f22-6018-08dbd3b75631
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gG+nZrQgkLLplHAD250vJIWjSjGxN5Q28PkPbpHfIliWAwy0hdgznkrih08laxGX+MUyS8QGcOEvfIwLhfxPAHfal0nLs6HQadqMUJg/5iuPkDBOJLW77cy6dDWUEGAjA9JbZD2mQ2CRd37xqqqraJSD/2cIxS+w2ZRnkPkoUDF07KvolUjcI0PPrdXOWopTmFuF2CXvuskZWomySc1Ft/y1z+inV0JtHdEiIdvqWGM7mdoy1u70oyGg8sj72CVmC0E1aXDGIW+/Kbpe92nd92XFw1Mr1FuSMbqTGNZ1nt5WXQRFQDQzIJGzdWJKk2+JZadOzi5wQnNgsN0IaxDjiQoe+I1vQA0mCXZ36pbBP7x6o7fRNEfwhGZVrNk7rrkLyeYvEcZUKFhAEnKve6SYUJ8r08Wnrz2ra4LAfS2mSEVqD9OOciGxmHZ/zuHU6BWJ9btaN1wl9M+d3v86ja122FewuOwVlweyhfZq7F1tCS/eZ1PDbAitvDFktKdCAoMAFQtS2AEM81tzQbuthCGqlbjQgeVhQuVkVF0qqSZFsDRHiOJEp5QyXpGyyNlB8CRQaVGrboy0HiDrUBZCIXTaOfztmjmGa8mcMjgz6IwN1At2Z5m5oBDadtnXDIHKu+aE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(7416002)(55016003)(2906002)(7696005)(66946007)(66476007)(66556008)(76116006)(54906003)(110136005)(66446008)(64756008)(71200400001)(478600001)(8936002)(8676002)(33656002)(316002)(5660300002)(41300700001)(4326008)(83380400001)(52536014)(82960400001)(6506007)(38100700002)(26005)(53546011)(86362001)(9686003)(122000001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejNsVkt1Z2VaOVJYTkFKQk12M0psSzJjZnJHSHdQMDdBd0I5SlYvYmZDblpN?=
 =?utf-8?B?NS9UWlN3NzczRjlKbVZIRjBKQkN2YXZORWNtSGFOVTJIejN3VzV6NmFXalVk?=
 =?utf-8?B?b09YaUNoNW94R1N3MldCNENRUjlvYVJJbEN2cW9jUzBJekkybWxkT2tRNDNO?=
 =?utf-8?B?ZG5XRFBHbDFOOHEvWGtkNlEvQWJNem51aTF6cWM2YXd1a1owWVlndFBrSUxW?=
 =?utf-8?B?ZWxqaEY1ODI0b3NsbUtvZWE2TE5iSmpNeFEvdzVpYlRieHFVaWVadlRIM1E2?=
 =?utf-8?B?Z3dCdW1yU3ZPc1U2YzNEWEFQZHpQSkZuZWlRS0VNT1RDMG9UOWpKdFFPMWR4?=
 =?utf-8?B?SmU4UHlWUVJwcUYyVzdKZGFSK3o1aEFQbno2OG0zYWV0cWwvaHdWT0c4MFVl?=
 =?utf-8?B?MW92ZEFMOXlBcGw3VWJjNjcxZEZURlJXbmRHd1owdVBraVhreTl2YWx6SkJx?=
 =?utf-8?B?U0VxWFN1cy9zNzExcGFvVmlWTEtVZVFpNUM0MHh6R2JuamNOa0xEZStnV3pC?=
 =?utf-8?B?V2NnTlRFM1VBZjFjcWQ4MmpwNWNiditwQzlDNWNOejR4UEgxMUNmSjNXdW1X?=
 =?utf-8?B?QkZuclJwcE1McTdxZ25WVkM4Y0w5c21mWi9HSnFjdjgwSiszVEk2TGNrbUxl?=
 =?utf-8?B?MDFXb3RlTUtWYm5uR2Y3azZ5WklXamcyTlRjY2paM2tFTXFrcmQrYkk1SkJK?=
 =?utf-8?B?bEZxR0IreEx6R2xUc0cvbi9tL0tjWExydTZ3d1ZEbFdvVGcyZDlYenhXRG9Y?=
 =?utf-8?B?YnJOa1JaVjBZSGYvTFcweDdIWnlmd2djUS9IODYxRWNtSWxqK3pNc3M2NFdt?=
 =?utf-8?B?V3RkNkhqOHJmSmJJUS9mZ0lFYmJWZ0tYYXhVWXlYWkdEa2VFVVdCbkdJeWR2?=
 =?utf-8?B?L1lxYUd5YUJrMEJPdEI1Tk5HdlAyallXUWlDSDNNV0graXArSGhkYXByRkZI?=
 =?utf-8?B?Q0hUa3E4NVpsNVhGYVZBRStFYnR5bWlhcWcyYVN2TmNZT1dmbVEvOEFsaVJj?=
 =?utf-8?B?Y1htSVMzc0FLdWtNLytnWUZQaWcwV0tzbnNKMVVtVWtzRlhDdy9LZHhrcWNQ?=
 =?utf-8?B?c3REQ085dXhrbWxhd09STUVoZGRMeTVVVndxKy9iVTZnMGFvWStWdTdxQnVt?=
 =?utf-8?B?M1VvcE9PcUxrRFBJRmdCUHpMNEZ0SHlka0g4QnIwVEd0Q29IeFIrU1pqTTN3?=
 =?utf-8?B?Y2YyOVR2TnVyVjZncERrVmNSOThNTHBWMytabVdhTCtBc3c0NzA2cmZXZFRC?=
 =?utf-8?B?YURUdHdPNG85NE5PY0hkK28zQ1F4RVlpSUJvWldvdS9rZzQ2M1dCc2hwS3Ra?=
 =?utf-8?B?VnhrYmlxU2ZmQTljTm8wUUsyeUJaaHhBWVpvQjRlR1pxcFhTNlhmWnpJRUFs?=
 =?utf-8?B?eEpLSWw3NUZBa0psUjRidkN5bFprWDA5L296Qm5xaTRvM3BjTUdIRU9RdUUz?=
 =?utf-8?B?WThGRTAyYkpCdGd6SG9mN2tGc2hvVHZOZEw3Y2xPU0txZGpmOUtMZThVQXJ2?=
 =?utf-8?B?dW1LTk1tWmJVSnI2M2lOUG5RWTV5S0p0VmtGRSt6RkpYb2duZWVXdE1yTXVZ?=
 =?utf-8?B?ZVZudTFhMlYzWmIxUFF6Ulg3UzhCZFZsemxlK0oranBjbjQ3N3BCbGZhOG82?=
 =?utf-8?B?c0hLLzJIUm9RRzZYQTkxcjVYVFMxc08zTE5uY09tWEtCbjBPQ3BEakJ2WjlC?=
 =?utf-8?B?TUFyVFVFTXh3azhTcnBzdTJaWjdveG5tb08xS2ZmVEhVUFJuYVdCelNLejMx?=
 =?utf-8?B?UnpLVGRGZWxDUlNMNzlFZCtLMjY0eUtXYS9vWmJQZHpDSk93MkZWNXJGNkw4?=
 =?utf-8?B?TWxDV2g2MkdzbkI3MVdIcnFmS3BhUEJwUG5ScUNuc0hxMGtmenFVT0hLTFNs?=
 =?utf-8?B?RGJHSnY2ZFRVYkFXVG90YlgvR2dwNVZWNGxWczdlbzJPME5WdEhQSTJEb3Iv?=
 =?utf-8?B?UWV0ZXpvQ3ZtK3lRczJPMFh4ZlVxSVNZUWJHS0ZrSWdpZUIyaGJCbFd0WVhQ?=
 =?utf-8?B?NkJpWHZNREU1L2I3VUJrakhCMU1DTTRTaFVWblpJWnU0Tm1NcFJRdU5PdTU1?=
 =?utf-8?B?T095dGIxWENhbkdWV0FUeHRlMWJNT0svb054V1BuQU9tc3czeW9MVnltNlQy?=
 =?utf-8?Q?YMSZ5wU5OZ5ymaLIUajnTxy9V?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf9d54f-cc4b-4f22-6018-08dbd3b75631
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 11:00:58.1189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cZT2Eg4wWWC53xBWGaDGqG2ZyNz4aVLQis+zJ7V2JMoOijTRrVCS8NfRRSAfzzqStL/1wv27Ai1jxZC1kqrV8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5882
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIE9jdG9iZXIgMjAsIDIwMjMgNzo0OSBQTQ0KPiANCj4gT24gMjAyMy8xMC8yMCAxNzozMiwg
WWkgTGl1IHdyb3RlOg0KPiA+IEZyb206IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5j
b20+DQo+ID4NCj4gPiBUaGlzIGFkZHMgaGVscGVyIGZvciBhY2NlcHRpbmcgdXNlciBwYXJhbWV0
ZXJzIGFuZCBhbGxvY2F0ZSBhIG5lc3RlZA0KPiA+IGRvbWFpbi4NCj4gPg0KPiA+IFJldmlld2Vk
LWJ5OiBLZXZpbiBUaWFuIDxrZXZpbi50aWFuQGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBKYWNvYiBQYW4gPGphY29iLmp1bi5wYW5AbGludXguaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJz
L2lvbW11L2ludGVsL01ha2VmaWxlIHwgIDIgKy0NCj4gPiAgIGRyaXZlcnMvaW9tbXUvaW50ZWwv
aW9tbXUuaCAgfCAgMiArKw0KPiA+ICAgZHJpdmVycy9pb21tdS9pbnRlbC9uZXN0ZWQuYyB8IDU1
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgMyBmaWxlcyBjaGFu
Z2VkLCA1OCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gICBjcmVhdGUgbW9kZSAx
MDA2NDQgZHJpdmVycy9pb21tdS9pbnRlbC9uZXN0ZWQuYw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW9tbXUvaW50ZWwvTWFrZWZpbGUgYi9kcml2ZXJzL2lvbW11L2ludGVsL01ha2Vm
aWxlDQo+ID4gaW5kZXggN2FmM2I4YTRmMmEwLi41ZGFiZjA4MWE3NzkgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9pb21tdS9pbnRlbC9NYWtlZmlsZQ0KPiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUv
aW50ZWwvTWFrZWZpbGUNCj4gPiBAQCAtMSw2ICsxLDYgQEANCj4gPiAgICMgU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiAgIG9iai0kKENPTkZJR19ETUFSX1RBQkxFKSArPSBk
bWFyLm8NCj4gPiAtb2JqLSQoQ09ORklHX0lOVEVMX0lPTU1VKSArPSBpb21tdS5vIHBhc2lkLm8N
Cj4gPiArb2JqLSQoQ09ORklHX0lOVEVMX0lPTU1VKSArPSBpb21tdS5vIHBhc2lkLm8gbmVzdGVk
Lm8NCj4gPiAgIG9iai0kKENPTkZJR19ETUFSX1RBQkxFKSArPSB0cmFjZS5vIGNhcF9hdWRpdC5v
DQo+ID4gICBvYmotJChDT05GSUdfRE1BUl9QRVJGKSArPSBwZXJmLm8NCj4gPiAgIG9iai0kKENP
TkZJR19JTlRFTF9JT01NVV9ERUJVR0ZTKSArPSBkZWJ1Z2ZzLm8NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5oIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5o
DQo+ID4gaW5kZXggYTkxMDc3YTA2M2VlLi5mZjU1MTg0NDU2ZGQgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5oDQo+ID4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRl
bC9pb21tdS5oDQo+ID4gQEAgLTg2Niw2ICs4NjYsOCBAQCB2b2lkICphbGxvY19wZ3RhYmxlX3Bh
Z2UoaW50IG5vZGUsIGdmcF90IGdmcCk7DQo+ID4gICB2b2lkIGZyZWVfcGd0YWJsZV9wYWdlKHZv
aWQgKnZhZGRyKTsNCj4gPiAgIHZvaWQgaW9tbXVfZmx1c2hfd3JpdGVfYnVmZmVyKHN0cnVjdCBp
bnRlbF9pb21tdSAqaW9tbXUpOw0KPiA+ICAgc3RydWN0IGludGVsX2lvbW11ICpkZXZpY2VfdG9f
aW9tbXUoc3RydWN0IGRldmljZSAqZGV2LCB1OCAqYnVzLCB1OCAqZGV2Zm4pOw0KPiA+ICtzdHJ1
Y3QgaW9tbXVfZG9tYWluICppbnRlbF9uZXN0ZWRfZG9tYWluX2FsbG9jKHN0cnVjdCBpb21tdV9k
b21haW4NCj4gKnMyX2RvbWFpbiwNCj4gPiArCQkJCQkgICAgICAgY29uc3Qgc3RydWN0IGlvbW11
X3VzZXJfZGF0YSAqdXNlcl9kYXRhKTsNCj4gPg0KPiA+ICAgI2lmZGVmIENPTkZJR19JTlRFTF9J
T01NVV9TVk0NCj4gPiAgIHZvaWQgaW50ZWxfc3ZtX2NoZWNrKHN0cnVjdCBpbnRlbF9pb21tdSAq
aW9tbXUpOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL25lc3RlZC5jIGIv
ZHJpdmVycy9pb21tdS9pbnRlbC9uZXN0ZWQuYw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
ID4gaW5kZXggMDAwMDAwMDAwMDAwLi41YTI5MjBhOThlNDcNCj4gPiAtLS0gL2Rldi9udWxsDQo+
ID4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9uZXN0ZWQuYw0KPiA+IEBAIC0wLDAgKzEsNTUg
QEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiArLyoNCj4g
PiArICogbmVzdGVkLmMgLSBuZXN0ZWQgbW9kZSB0cmFuc2xhdGlvbiBzdXBwb3J0DQo+ID4gKyAq
DQo+ID4gKyAqIENvcHlyaWdodCAoQykgMjAyMyBJbnRlbCBDb3Jwb3JhdGlvbg0KPiA+ICsgKg0K
PiA+ICsgKiBBdXRob3I6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+DQo+ID4g
KyAqICAgICAgICAgSmFjb2IgUGFuIDxqYWNvYi5qdW4ucGFuQGxpbnV4LmludGVsLmNvbT4NCj4g
PiArICogICAgICAgICBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gPiArICovDQo+ID4g
Kw0KPiA+ICsjZGVmaW5lIHByX2ZtdChmbXQpCSJETUFSOiAiIGZtdA0KPiA+ICsNCj4gPiArI2lu
Y2x1ZGUgPGxpbnV4L2lvbW11Lmg+DQo+ID4gKw0KPiA+ICsjaW5jbHVkZSAiaW9tbXUuaCINCj4g
PiArDQo+ID4gK3N0YXRpYyB2b2lkIGludGVsX25lc3RlZF9kb21haW5fZnJlZShzdHJ1Y3QgaW9t
bXVfZG9tYWluICpkb21haW4pDQo+ID4gK3sNCj4gPiArCWtmcmVlKHRvX2RtYXJfZG9tYWluKGRv
bWFpbikpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGlvbW11X2Rv
bWFpbl9vcHMgaW50ZWxfbmVzdGVkX2RvbWFpbl9vcHMgPSB7DQo+ID4gKwkuZnJlZQkJCT0gaW50
ZWxfbmVzdGVkX2RvbWFpbl9mcmVlLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RydWN0IGlvbW11
X2RvbWFpbiAqaW50ZWxfbmVzdGVkX2RvbWFpbl9hbGxvYyhzdHJ1Y3QgaW9tbXVfZG9tYWluDQo+
ICpzMl9kb21haW4sDQo+ID4gKwkJCQkJICAgICAgIGNvbnN0IHN0cnVjdCBpb21tdV91c2VyX2Rh
dGEgKnVzZXJfZGF0YSkNCj4gPiArew0KPiA+ICsJc3RydWN0IGlvbW11X2h3cHRfdnRkX3MxIHZ0
ZDsNCj4gPiArCXN0cnVjdCBkbWFyX2RvbWFpbiAqZG9tYWluOw0KPiA+ICsJaW50IHJldDsNCj4g
PiArDQo+ID4gKwlyZXQgPSBpb21tdV9jb3B5X3N0cnVjdF9mcm9tX3VzZXIoJnZ0ZCwgdXNlcl9k
YXRhLA0KPiA+ICsJCQkJCSAgSU9NTVVfSFdQVF9EQVRBX1ZURF9TMSwgX19yZXNlcnZlZCk7DQo+
ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiBFUlJfUFRSKHJldCk7DQo+ID4gKw0KPiA+ICsJ
ZG9tYWluID0ga3phbGxvYyhzaXplb2YoKmRvbWFpbiksIEdGUF9LRVJORUxfQUNDT1VOVCk7DQo+
ID4gKwlpZiAoIWRvbWFpbikNCj4gPiArCQlyZXR1cm4gTlVMTDsNCj4gDQo+IAlyZXR1cm4gRVJS
X1BUUigtRU5PTUVNKTsNCj4gPw0KDQpZZXMsIGdvb2QgY2F0Y2ghDQoNCj4gPiArDQo+ID4gKwlk
b21haW4tPnVzZV9maXJzdF9sZXZlbCA9IHRydWU7DQo+ID4gKwlkb21haW4tPnMyX2RvbWFpbiA9
IHRvX2RtYXJfZG9tYWluKHMyX2RvbWFpbik7DQo+ID4gKwlkb21haW4tPnMxX3BndGJsID0gdnRk
LnBndGJsX2FkZHI7DQo+ID4gKwlkb21haW4tPnMxX2NmZyA9IHZ0ZDsNCj4gPiArCWRvbWFpbi0+
ZG9tYWluLm9wcyA9ICZpbnRlbF9uZXN0ZWRfZG9tYWluX29wczsNCj4gPiArCWRvbWFpbi0+ZG9t
YWluLnR5cGUgPSBJT01NVV9ET01BSU5fTkVTVEVEOw0KPiA+ICsJSU5JVF9MSVNUX0hFQUQoJmRv
bWFpbi0+ZGV2aWNlcyk7DQo+ID4gKwlJTklUX0xJU1RfSEVBRCgmZG9tYWluLT5kZXZfcGFzaWRz
KTsNCj4gPiArCXNwaW5fbG9ja19pbml0KCZkb21haW4tPmxvY2spOw0KPiA+ICsJeGFfaW5pdCgm
ZG9tYWluLT5pb21tdV9hcnJheSk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuICZkb21haW4tPmRvbWFp
bjsNCj4gPiArfQ0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBiYW9sdQ0K
