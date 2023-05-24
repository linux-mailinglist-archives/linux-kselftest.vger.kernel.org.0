Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C06C70EFFE
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 09:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbjEXHzr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 03:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239544AbjEXHzq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 03:55:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11AEA1;
        Wed, 24 May 2023 00:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684914944; x=1716450944;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6NjKOhrrVnPz/RKh3At26fPPOUGJL0R6YTqhtCx8nuk=;
  b=e4I5l7lBQ4q+MhnUCx8ioHfw0El7nucLfUItxBfRki/4Ak+JjOLr5mtL
   DBz29iymrgDvITSb9tZPLdSaeLUrUdsqsNPn6CcJrELQ1jrBlXyuglANY
   gK653mc1WaXgkM9FIVZhOLT/gDMFoVHKIsILvTsdkl5/WxZhTCV+gVhuB
   wC5sCE+U5I6O1rnfYmseVSm0ZdVpPAXfclOb0CICjuId53HAns8T1E/L2
   0KtU/yoCFG4bM94wvUCx1lgrS/DKDxmH5I37f5sVnkexXDoKd3vrBGhhe
   4kTncniHouRGuPqlxm24o9U6bVuC/MlTHZB1QZw5h7gdhYWJfmhIImXtM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="439842842"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="439842842"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 00:55:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="794087221"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="794087221"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 24 May 2023 00:55:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 00:55:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 24 May 2023 00:55:43 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 24 May 2023 00:55:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oB6dSJiigpcFcHiXbl5WcCi1AgSK5SIhgcbJHw5fwhswUnYmJgR20boJhbBvOZpw9vL5ARvJRlK0Tlyu91UKXi6rNJiFk2UjIyvTBRe2iuXKv9TndayItpdyGRNWkZ0Xcu8cTEr0uAIW+TJW3LUW8aMZkp69RvRQClPz7++h9T1r5ALKUlpaQj3RyqPT9Pwr0mZjW7rI8I/yClljTUWINeu/GAcFuJFfV+yiQDE/vw/LZJtjyQUIo7b7bRZIKhBjGI5DW9OdfqKVO29Xfj72AvOW/02YFSJFGNVMok6LWoX+w3zkBkStX7p1vKO3MJEbIR+4gPsoO4ZgOEqbDo5CaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NjKOhrrVnPz/RKh3At26fPPOUGJL0R6YTqhtCx8nuk=;
 b=cbffQmfv5zrCzEG1hIKL14hQqjvtBnXMxNrqbFHMPo2dplqYd/8N4XwsBiHvrK+gr9vh7bxRc2RFGDdoc2EAr3+Vq7uUSRo1TONLd2vzkJbb4yZ0SsCNWU3/Lp4aYt9kovsfP8y8Ev/p5jkLzVrACLaIkxjhUDGT0SwSs2MrhYCGE0kIOZqY/qT70DqL8epOZ/5uor8vroEClbsPLqodcc5PFxOjBUwM9I9uSmsgyYbZGWSyq6TtwGl+P+JM161qqfwIyDa+GNiOG0ot2AMBnydwHAFM5NyW9jvun9BzoaaaSdnJCtWEzEJzX41zwX3GZTlVkDexGC8QnkhDeFZb9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8327.namprd11.prod.outlook.com (2603:10b6:806:378::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 07:55:40 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00%3]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 07:55:40 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
Subject: RE: [PATCH v2 06/11] iommufd: IOMMU_HWPT_ALLOC allocation with user
 data
Thread-Topic: [PATCH v2 06/11] iommufd: IOMMU_HWPT_ALLOC allocation with user
 data
Thread-Index: AQHZhBZXnOm7clyQUE+6OxnZdoaXBa9hYn+QgACrGICABubsQIAAB92AgAAkwLA=
Date:   Wed, 24 May 2023 07:55:40 +0000
Message-ID: <BN9PR11MB52768BB6427574C67232692D8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-7-yi.l.liu@intel.com>
 <BN9PR11MB52767257B1AC401121F3B24F8C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZGfSjYMA06PmaI+Y@Asurada-Nvidia>
 <BN9PR11MB5276FCE1CAA5556E0CBE0B628C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZG2jWQvl9tdpZ1Vv@Asurada-Nvidia>
In-Reply-To: <ZG2jWQvl9tdpZ1Vv@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8327:EE_
x-ms-office365-filtering-correlation-id: 20b0d1f0-8dc6-4397-d2e9-08db5c2c44b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GlYqwQBshz8EkSI1UntWd2bPtl8g5hi+VTofHm2WigwFhVtFLcnbQOFDr4IFOhFrwTfVQLg0SOrZ7MFx0ek9l7j6nDffeWMWuHsfbi28jdFvUTshCFsskkYHsUpAyD/RSezL9WMdxMNi4mcKyKxuGkcqUMAOvHx8wQl71KdfaA7HmgMSF22xMJX6byCl6QYuUAGh4V2y/airLvAYfx8r52h/EtAmF5xHy9G8ZNsOiZD7TWs9vF71UYz82L7cA5hOaeuNv8pzyuiLHb+1f/1fdjZbPjuFJZNs2fXYSGOT/feyw53fURoRK1FPJraUeFevTE9CM2YLhiwkhPQdOqkfY9JdP1+oGkX17sv+FTp+3kQes1mKuWkNJyBP3A3rEcWY9aGdbWCXJtWqXFvb5IupF4q7C8q/2Aid4Gd2LD0bqb5FlHbl5hrtRmu1zFFAfApC8vRFGLZjewyxLZLKomdExmoVAJeffzva7mUjMjki+P8u5uSQy4EgO9DP1f9IaWX0ar5prmTnd3Few+XXsfgIifSe0A73EnKn9GCThixEaITHxDPm7W27K+YxuWEedE2MGoiC6j4BS5mKvW3YK4wpoHRn3Njo++XZFICP/TRnjCikXOBR4twtiTZxFjZNS9jC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(9686003)(8676002)(7416002)(8936002)(83380400001)(38100700002)(82960400001)(86362001)(38070700005)(33656002)(122000001)(6506007)(55016003)(2906002)(41300700001)(71200400001)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(6916009)(4326008)(7696005)(316002)(26005)(5660300002)(54906003)(52536014)(186003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QU94TU0yNlAzTmRvQmk4R1FudTZqdnVLUC91bXkybDhKU3dPU0RFWkxHWDdw?=
 =?utf-8?B?dlV1RnNXTksrSlNpUUFRbUpybHV6V0hZUUthbDRPYjlXalVQd3FSeDhDbGVT?=
 =?utf-8?B?Q0lRUENOQTBvRXdHQzNOd0FkanpZMEQ1VjhzWFozTVJlV0JjcGlkb2U4MEJC?=
 =?utf-8?B?NzJ4S2NzU2VmQUJYQUJPMHBtOXgwVTNqa1BkS2dsVVBCQW9JWmJQVjNNcHBk?=
 =?utf-8?B?U2pGN3NaS041TGRKV2NBNWVybWV4Rm5VOExsNkJJWW9CTVlJQU5yZ0RQdzIr?=
 =?utf-8?B?Q29TbWdsMjlNYm9LckpjdkdtUklWSFIvSTEzNkJHNktub1VMeXVVQ0ZsUmVz?=
 =?utf-8?B?K21heUdCanlOVzNhZFhyMmlFbDZtSjFKWTdSa1ViVmZYT3pJZURYZjJmMzl4?=
 =?utf-8?B?ajRMb0lRTFZObCsvN1V0c1ZJRllVbllXWmRTZU9MT3hJWE56MFVERDFPdFlX?=
 =?utf-8?B?VWdCbDhOY2RaRy9WUlBGWmRDVkkwWlZCcEhLTC9zVFdBVHBuWkZYOUJ1QzR4?=
 =?utf-8?B?akdrZWRXaUtHWS8zalhmU2IxY201T0M0dWlOZC9rUTdVUGFHTk11RzB2R0ZK?=
 =?utf-8?B?Q1VJT3RocEk2RmRLWWxIRUZGbU44ZVpBV0wvaldmRUFyakxvZVkvRGJjcFJr?=
 =?utf-8?B?S3laNFBzd1lqZUpCYzJZYUVTV2RTWWtPU2l4dnhid1NaM1hTajZveHZ4Z2RW?=
 =?utf-8?B?RXAyVGxUczdKOUQyNFcwMi9ta0N0UGhSbzV1WGQ4dXc4V05hRm42elhQMlVF?=
 =?utf-8?B?anZFbUdQMk9jVEtXUksrck92QitmdkN2WSt1TS9Fajh3bmlpeU9SbFRvb0dK?=
 =?utf-8?B?aWE0UlROaW5TYU41aVFBSnA2d1ZUNVRKT2c3OWs5MzhHYzhVeTVzcmw1MXhJ?=
 =?utf-8?B?eWwxTkdNSCtVUGtWcjZpcUhNSUpWL2tZMHBEa3BOK3hDYnd3M3dVcWZhS29U?=
 =?utf-8?B?a1pPQjBHcEJUODZ5dEJNYllISGV0N3k5QThXdnpzclVuSmk2L3E2R0I3SGV0?=
 =?utf-8?B?K0wyWGVKemV4SWtmYTBZRitmNmVuNktTOWFWY3p3NHRmVm9maGI1N2NhS1RC?=
 =?utf-8?B?aU9Pd0poL2VOZ1p5a2ZpWHZLVzdTRjRLOWhzYitKVEtlL1NLNnFTOVZ5S2ox?=
 =?utf-8?B?MUxNSzR1VEhoMEZwQXAxTjFDc0xTbFpwNDF0cDJYZXcyV2FrQWtTTjQybzFo?=
 =?utf-8?B?MVc4U1NXNWlaMU51eHEvdlY3RThwbkpIc080V1hOOU9vS3dlTEhrbXlIR1I0?=
 =?utf-8?B?RmNUV2QxY2xxOTBQY3dsMk1iTjR5N0MwMzNvT1o5OWpLT3JCenN1Q1R4cGZz?=
 =?utf-8?B?TlBkOXNjWmtHeVBGcGZtbEw3eGJVMkNFaWs1RlQ2TFNrMEhpQVVoLysrejlW?=
 =?utf-8?B?MkRIL1ppL1V3bTBvUkZMbHpWMVAzM1pMUGt4ZHplTkZ3SDhzWjR0U3kzMnoy?=
 =?utf-8?B?OEN4bTI0TDVENi92YXZaZW5YbjlJQ0Iwb1Q1WWtESzh0RHcySkg2Ryt6akdX?=
 =?utf-8?B?WlJOZko0Q3N0M091b1BOL2t3WjRCNXRiYm56WWhYYXdjYnhXNm1Obk5JWFpx?=
 =?utf-8?B?K2NxSk9MZTM2K2ptSllKNVkwR0MwbUpIYm83NGNiZFdnYUJEZTFGdWpqbU9j?=
 =?utf-8?B?L3FzQ2c2bmdhMmpUK2VzckFmaDRjaEkxdURPYnpWWEJsdnh0TFN4STdiZ3hW?=
 =?utf-8?B?NkNuVWNRYXJFVm0xWHU3d3NqaDQ1SVJMZm5uMXhVb0pIcTJiejJOaXpxa0lV?=
 =?utf-8?B?eEo3RVp5MWNGNWhmcFNKQ1dINFFoUk9aenlSZ3RTQ0IyNzNmaEtSY3dtL2JK?=
 =?utf-8?B?dFN1cFJpK1ZyNyt0S2FqZHRLS2lvaG1mUFBNVFErYVNrVzlhMGIvemV2azQv?=
 =?utf-8?B?VVprOEw2aGZOMWNtOU54eFBvM2JOUmFWWXRhTmR2YXo5dUtMTTNobnBqRTBT?=
 =?utf-8?B?SUNkckRLdTM5MHRSL1ZBVUkydCtBRVNHMU5FK1pDdlcyN3o1Z3YyNnNpcUhm?=
 =?utf-8?B?WkpSa3dvemg4VmtoZFVOMGJuZzF0UHhhVFJyYVVvYnJRMUF0R056cm1BcXV6?=
 =?utf-8?B?UFpPWEp5T0hPM2FQMDhDRVJpckxDa01mOVJicXQ5WFkrTk5tTlFwY0V4WWZT?=
 =?utf-8?Q?gaexICaDz/ZVWsqGyufLAScji?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b0d1f0-8dc6-4397-d2e9-08db5c2c44b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 07:55:40.3697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4LZHcusDs8GCAuk1WyWo9g+PTb2nwEQXE6TJvUk9semDPsG2qf8UOp95KP6xRj9QAunnhfVYTfl1Lou5FC91+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8327
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

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgTWF5IDI0LCAyMDIzIDE6NDEgUE0NCj4gDQo+IE9uIFdlZCwgTWF5IDI0LCAyMDIzIGF0
IDA1OjE2OjM1QU0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOg0KPiANCj4gPiA+IEZyb206IE5p
Y29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gPiA+IFNlbnQ6IFNhdHVyZGF5LCBN
YXkgMjAsIDIwMjMgMzo0OCBBTQ0KPiA+ID4NCj4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAr
ICAgICBzd2l0Y2ggKHB0X29iai0+dHlwZSkgew0KPiA+ID4gPiA+ICsgICAgIGNhc2UgSU9NTVVG
RF9PQkpfSU9BUzoNCj4gPiA+ID4gPiArICAgICAgICAgICAgIGlvYXMgPSBjb250YWluZXJfb2Yo
cHRfb2JqLCBzdHJ1Y3QgaW9tbXVmZF9pb2FzLCBvYmopOw0KPiA+ID4gPiA+ICsgICAgICAgICAg
ICAgYnJlYWs7DQo+ID4gPiA+DQo+ID4gPiA+IHRoaXMgc2hvdWxkIGZhaWwgaWYgcGFyZW50IGlz
IHNwZWNpZmllZC4NCj4gPiA+DQo+ID4gPiBJIGRvbid0IHRoaW5rIHRoYXQncyBuZWNlc3NhcmF5
OiB0aGUgcGFyZW50IGlzIE5VTEwgYnkgZGVmYXVsdA0KPiA+ID4gYW5kIG9ubHkgc3BlY2lmaWVk
IChpZiBJT01NVUZEX09CSl9IV19QQUdFVEFCTEUpIGJ5IHRoZSBleGFjdA0KPiA+ID4gcHRfaWQv
cHRfb2JqIGhlcmUuDQo+ID4NCj4gPiBJIGRpZG4ndCBnZXQuIFRoZSB1QVBJIGRlc2NyaWJlcyB0
aGF0IG9ubHkgaHdwdCBub3QgaW9hcyBjYW4gYmUgc3BlY2lmaWVkDQo+ID4gaW4gdGhlIHB0X2lk
IGZpZWxkIGFzIHRoZSBwYXJlbnQuDQo+ID4NCj4gPiBJZiB3ZSBkb24ndCBjaGVjayBoZXJlIGl0
IG1lYW5zIHRoZSB1c2VyIGNhbiBzcGVjaWZ5IGFuIGlvYXMgaWQgYXMgdGhlDQo+ID4gcGFyZW50
Pw0KPiANCj4gSSBtZWFudCB0aGF0IHRoZSBwYXJlbnQgcG9pbnRlciBpc24ndCBzcGVjaWZpZWQg
YXQgdGhpcyBsaW5lOg0KPiB0aGUgZGVjbGFyYXRpb24gb2YgdGhlIHBhcmVudCBpcyBzaW1wbHkg
TlVMTCwgYW5kIG5vdCB0b3VjaGVkDQo+IGluIHRoaXMgSU9NTVVGRF9PQkpfSU9BUyBjYXNlLCBh
cyB0aGUgcGFyZW50IHBvaW50ZXIgd291bGQgYmUNCj4gb25seSBzcGVjaWZpZWQgaW4gdGhlIElP
TU1VRkRfT0JKX0hXX1BBR0VUQUJMRSBjYXNlIHRoYXQgaXMNCj4gYmVoaW5kIHRoaXMgbGluZS4N
Cj4gDQoNCkkgc2VlIHlvdXIgcG9pbnQuIEFzIGxvbmcgYXMgdGhlIHR5cGUgaXMgSU9BUyB0aGUg
YWxsb2MgcmVxdWVzdCBpcw0KYWx3YXlzIGludGVycHJldGVkIGFzIGNyZWF0aW5nIGEgczIgaHdw
dCB1bmRlciB0aGUgSU9BUy4gT25seQ0Kd2hlbiBpdCdzIEhXUFQgdHlwZSB0aGVuIGl0J3MgdHJl
YXRlZCBhcyB0aGUgcGFyZW50Lg0KDQpJIGtlcHQgYSB3cm9uZyBpbXByZXNzaW9uIHRoYXQgdGhl
cmUgaXMgYW5vdGhlciBmbGFnL2ZpZWxkIHRvIG1hcmsNCnRoZSBwYXJlbnQgcmVxdWlyZW1lbnQg
dGhlbiB0aGVyZSBjb3VsZCBiZSB3cm9uZyBjb21iaW5hdGlvbg0Kb2Ygc2V0dGluZyB0aGF0IGZs
YWcvZmllbGQgcGx1cyB1c2luZyBhbiBJT0FTIHB0X2lkLiDwn5iKDQo=
