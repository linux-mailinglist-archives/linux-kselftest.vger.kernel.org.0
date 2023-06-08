Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4489D7275C0
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 05:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjFHDdE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 23:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjFHDdD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 23:33:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F31226A1;
        Wed,  7 Jun 2023 20:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686195182; x=1717731182;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VvP+oTPh/Bvlo4Gg4jwtlAqo6YOglhQBc7hV4blfum4=;
  b=VotR03GhkE1SWdMKN2ig1dLJlzcRULrQq6UVx8SshW8eDf0DOl+orutP
   6wGs/ldfNTP8PskB7BqWdpyQCLplR1vU/XwdXA/D/XudFP/kHD5fYKAZC
   YxSZCp1mHeb455IAgdwvDB0bmgDN9X90/g9OGbvf7IYVREr9rcDCBRnTI
   S9ReVrVN9GVmTwE5mgasVtO9WPlxoITWPcTojfVuFVemPbPC32CM9ES3p
   K/0mIckau2emriIyauTfA/1tcTfQ2lxWqZQNmynlI3KBrN1dJ0GOIiGVc
   ChS6+r+A19kqP2/pzWGWBbXXTFRChf9h5ImrEOBiSZEu2hH9vrPn91BXf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="423035816"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="423035816"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 20:32:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="956552795"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="956552795"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jun 2023 20:32:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 20:32:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 20:32:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 20:32:50 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 20:32:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJDnjuNhHSl3BB0wwxs1n/Aw9vk1oJ2cUsvmCbPRr7ySkxAwWzNI7b/zFVZBB0pl9x2H1xRcahvE7Ri2RfA3hoQls1rn3LErzvWB0p9CfR3l01ov7DdNS14dsaUQ3zMbKgYbnznn+OWgayj0+/fjVEavDHGzM+DZwY+/2E0mTzILPaUufKHqRQx4JSSFaQ4cMyfC5Gcw17gMo1H34fe/XfNah8ojvl8oPg9fGOj/h9Wo27VDbR5Thkq1ER0+Oix+phRbXiamCHzy5+I8ZZBGf7uLc1LOn4Eae8wbZpLYlhiI+Nyu/zBx4cS89Klq9m8gwJEn5n5/rLBP1pcZKW8O7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvP+oTPh/Bvlo4Gg4jwtlAqo6YOglhQBc7hV4blfum4=;
 b=gS5BWo3eRTmS8kzdegRVnF7NuwehvWTNectdYgcAb9+5dAg06fXGWaTPQjvg/Ui2IWZhQ+HUnARMWbRJZ/hYJY+1yPffuwrEf7BEbm5CvrgD/Zjof6XUt3z3ZBdG4+hnjcFQeWuH8JIG5Uf4QNCWCnFmZXZrJlwZ1025BkEhrE8l1gqABQGozSzOO0qnruFjOJXETncJy3k4ff7daneES3WYoRy5aF9hm9T3TJmcpn5dnF8un+w4CEbXj44oG19+g2eUYTPj8agqSYnYn2q21lzwFv12ChRLZ7ygXg/vFWFm3WmPbWGH8KEIB2G1jNSd2UqzE42OVmqiOXh5sZTwBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MN6PR11MB8244.namprd11.prod.outlook.com (2603:10b6:208:470::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Thu, 8 Jun
 2023 03:32:47 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::5b44:8f52:dbeb:18e5]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::5b44:8f52:dbeb:18e5%3]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 03:32:47 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
Subject: RE: [PATCH v3 04/10] iommu/vt-d: Add helper to setup pasid nested
 translation
Thread-Topic: [PATCH v3 04/10] iommu/vt-d: Add helper to setup pasid nested
 translation
Thread-Index: AQHZhBgTX2uvl5TO/kuvRR0OMeFUCq9pFzmAgALyQQCAEyLzAIABPsWQ
Date:   Thu, 8 Jun 2023 03:32:47 +0000
Message-ID: <DS0PR11MB7529D902C77DC521A0AEFFABC350A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
 <20230511145110.27707-5-yi.l.liu@intel.com>
 <BN9PR11MB5276A52907EDD2155D42B3C08C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <6fbf021b-5f53-0290-d565-f9e765b51f88@linux.intel.com>
 <DS0PR11MB75299F04622CD9E6633C6464C353A@DS0PR11MB7529.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB75299F04622CD9E6633C6464C353A@DS0PR11MB7529.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|MN6PR11MB8244:EE_
x-ms-office365-filtering-correlation-id: 916ae4b1-65e4-48b1-77ba-08db67d10769
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SsKyXnrkxogz9NOfVuo3thvBxAf05WFHAUOJ4Z9Sk+96Wg7pYvp4t3zfcvS+2PX++GQno8/6ioss1tTHPl8bzo0ePrC/hBvQ69UI61MKt08EOcXoeLjdWJRu9NmQ6KTDNj9Tu/ay6NIuXh+t5ReATb+x0SzaHULA0P0KE5w2U5NLYWhd80WnKpjmPO3R7e6reK0UGhhv/Bqr8O509S86Qr3DjDZtAg5i/hMxHQNPAAWz2vJiDu2agjLdfPE41Bj0cv0kaze58bYCgl2qOD4OfmsqWhlFDLU7cuqj7ccG5kpCzXV8eardGHtdcVlCWCXXaJc1E1jjirRVBr/k/jJSWLMIwfXS799n2NrabZ+kyXvIMxXgCIIyrruI2caYfQANFhm66yvo8L+UMVGcltOV8q5zalVaJaHvpP8uFECM2moae5MNptIjr33TQxK3FXVe+fAvbwYZTNqJUPxDyp+ZkCJ/HV+KZe3LhHHaCxjPS4KP7A5p6OH0L/g9n3G3XxMx5WG9QjJlMT8COVEqGznY1aH9OqLst2npLeQFci+X5za/rWNlxZjoCnM7xcN5afRObzPT89oCA8XMKPdYsIysOsGJZCbeGuU9WlNziUlDKTqrYshcs1ga7/888Wk7BncYZiQJ63r5fQ5B2qb93YaVAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(33656002)(55016003)(26005)(52536014)(6506007)(41300700001)(186003)(5660300002)(9686003)(8676002)(8936002)(83380400001)(110136005)(54906003)(478600001)(66446008)(66476007)(76116006)(4326008)(71200400001)(66946007)(64756008)(66556008)(7696005)(316002)(82960400001)(38100700002)(122000001)(38070700005)(86362001)(2906002)(7416002)(13296009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGRoYStMTG9uc3FkM3JLOWNpcStJK0FWbi95b290a2MzMTlLb1RnYVBrMHpP?=
 =?utf-8?B?Mzh5WHZNNFZEa0JTbW9aeXN0Mi9TdTRGdWZDK1g3MDR0Y2xvbjI5bmhwaWk1?=
 =?utf-8?B?cGtTSGQyMlQrNDNmd1Q5RjZveWFKVm1YU0NZUWdwTG14bEdVYVM3amRaRXVy?=
 =?utf-8?B?Z0ZlOTlFNkhpN1ZTVkgyMmp2Q3RsWmxHR0ZRSjNJbjNFUFdvMmhXS2xJYjdi?=
 =?utf-8?B?N256bFV2Nk5xcTlCV01NTHlqWWFBU0YySDFTN2xHVFFMYlJlZ1RncUF1d0d3?=
 =?utf-8?B?YWVYS3ptVCtndVlCNFR5NkFrczljS0o3ZjV2U3dpdkdwYlFobjFLWW1YR09O?=
 =?utf-8?B?UTNrVFEvY3pvNFpORjJXZi8rSHVJU1d1TW8vRm4vSERTeHZTcjkvWWI3MHJm?=
 =?utf-8?B?c0daRVBqUUJrSjZTTU9GZ0M5blJQUGZMQSt0THh4MXE3NGZnRE96UXZnMGIy?=
 =?utf-8?B?cUJvQm5BMmpxRC91ajAzTXJiZFV2dFZ2RkxScytLZUdXZENLSkhFdm43Slgr?=
 =?utf-8?B?MHR2TWxWN05qcGRCblJ2Q1Y1d3RvV25CWjA5c0toOGZQMzhqVnNENWFtWXpN?=
 =?utf-8?B?SGs1SnkxZlVqcVE4d0wxWHUyNjZrL2o5dXJkOFhtcXl0UVNCazF3RWFLTDlJ?=
 =?utf-8?B?WXl5TUFRV0dsN1hIYndYc0pITUphMzVYWExCdVdOWEY5cnJpNUw1RlNqY0Er?=
 =?utf-8?B?ci9PbTFJdllZSGhHSDNVN1hVaFMvQ1BJZ3dQSWkzajdLRDdHSjhIQkUzNWQ0?=
 =?utf-8?B?cTlQSXgyTEN4b29RMjU3NG92U0ordzkyNmtkQlRkWGV3aTNYaVcwQmVZMUY4?=
 =?utf-8?B?YkwvNTNXZC9UUWplWURXdXkvYXhxVU5OeEpsdExQSmF4UlVTTmliejYxcXVp?=
 =?utf-8?B?TnVpcWs1UFE4d00rQXhoeXBTMXU2WUdBcXJZdGxFTEp6VVNWd09DSUgrU0dM?=
 =?utf-8?B?NU1VbXZPY2grUElLeVd3M2NqSG5OOEQxMkUrWlp6emdLWFNnYlg5K3pvT0ZV?=
 =?utf-8?B?T3lJMU9GNE5zZ3I0THBobVZJOExhTkJJTStjOHVUc2h5Nm51QmhHNlpKWFJ0?=
 =?utf-8?B?b3RGRVhCRmpVbnB6NUhNV2JxUmsyV0FESU1zNFdxN0NTd0xpaS9SR0ZmNWp5?=
 =?utf-8?B?cldpd3pNVGorRkZEMUNTSThrdjdvbG5ybEM5M2U3QW10b0cyb1VJemFXbmFD?=
 =?utf-8?B?aldXTWtWUlgvc1NQUXJJaGF1dzhEVGRIWFdpcmxwMWgrelgyd3FLR3ZkUFQz?=
 =?utf-8?B?bGd4Z3IxSTNOSEN2Sjk1Q0RNUnFGMks4clBIRkFEVUx2bWpab0dYYyt2R1RP?=
 =?utf-8?B?SEFkdDlFR1BpTzRrV0Z0b1QrVUlmT3luWTI5Z1hqS1ZwdEd3NzhzdnJFZk9E?=
 =?utf-8?B?SjJaeWIxeWh5U0VUK0FWUW9tcCtLbkg2Ty84U3JSSjh1NlVMN2hQM0RrZS84?=
 =?utf-8?B?b3Z0N3BkT3ZBRSs3VDlRcFp4WUZSUStjUVp6bWwvWEVnNjBnTGIvYW1kWUNr?=
 =?utf-8?B?U3hYbG0xN0FBQXRuaG90eTFQY3QwMVdubkNMbHZtbGoycHE4bDhqL2lkOXpl?=
 =?utf-8?B?RmpqVFJDWmh2K2puUTk2TC9ybmRSdjEySFVDbXAzVHVYSGQvcis0TDRJY1Vj?=
 =?utf-8?B?b3RzcGorckVLb0lpYkl0dzY3U0R6bE1iZmIwaVdENzNaRUtSOU4wRzV0a1Q2?=
 =?utf-8?B?MEJLY29oNll2SkZ4N0ZEam1ITFFYc2ZnUDZiYWRRN3RJSEdhN0lXYytOTHZK?=
 =?utf-8?B?VUQyd1hlUEJSN0xjZkFOSW1wNjVwbUIrd2hOSXJwdmNGRklja0xQZHg2M0tJ?=
 =?utf-8?B?djYwa1RsRytXd3dGSS9tbk5MMlpCMTZZTGVmOEc4aWlpSEpsQlJmZmNaRzg1?=
 =?utf-8?B?MUJmcHJUUXZXWHorR1hzVmhYcGJoMCt0N0NkZC9OdUVIUk9mSktvTUlGU0Q5?=
 =?utf-8?B?NnVzTU9wYmJmTk5FK2p3anBGU0Rya3Q3eHF2V3NMUEVvNTZnUXFEeWcxV2RX?=
 =?utf-8?B?VW5TMGNIOGVjTmlsQWpocUduVWlmY05wOG1Tc3RTWEZCNGtBUVFyV1VDcHEr?=
 =?utf-8?B?MEs1L2NIcG9KT1hIRG5RNE9MaWoySFVTTlR4VTgyNDJBTHdBVHUxSmh4VWJw?=
 =?utf-8?Q?y01YXnIn4rrDBo38fjRNHZbAm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916ae4b1-65e4-48b1-77ba-08db67d10769
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 03:32:47.2944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RYevI5r3iNxYIGoxAgFDL7VSbbu+P9cFQBkA21XQfkxXrGBnraFpaq/gOMXy8VzerM7mSMjTM886Vion2KFlOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8244
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

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5
LCBKdW5lIDcsIDIwMjMgNDozNCBQTQ0KPiANCj4gPiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVA
bGludXguaW50ZWwuY29tPg0KPiA+IFNlbnQ6IEZyaWRheSwgTWF5IDI2LCAyMDIzIDEyOjE2IFBN
DQo+IA0KPiA+ID4+ICsNCj4gPiA+PiArCS8qIEZpcnN0IGxldmVsIFBHRCAoaW4gR1BBKSBtdXN0
IGJlIHN1cHBvcnRlZCBieSB0aGUgc2Vjb25kIGxldmVsLiAqLw0KPiA+ID4+ICsJaWYgKCh1aW50
cHRyX3QpczFfZ3BnZCA+ICgxVUxMIDw8IHMyX2RvbWFpbi0+Z2F3KSkgew0KPiA+ID4+ICsJCWRl
dl9lcnJfcmF0ZWxpbWl0ZWQoZGV2LA0KPiA+ID4+ICsJCQkJICAgICJHdWVzdCBQR0QgJWx4IG5v
dCBzdXBwb3J0ZWQsDQo+ID4gPj4gbWF4ICVsbHhcbiIsDQo+ID4gPj4gKwkJCQkgICAgKHVpbnRw
dHJfdClzMV9ncGdkLCBzMl9kb21haW4tDQo+ID4gPj4+IG1heF9hZGRyKTsNCj4gPiA+PiArCQly
ZXR1cm4gLUVJTlZBTDsNCj4gPiA+PiArCX0NCj4gPiA+DQo+ID4gPiBJJ20gbm90IHN1cmUgaG93
IHVzZWZ1bCB0aGlzIGNoZWNrIGlzLiBFdmVuIGlmIHRoZSBwZ2QgaXMgc2FuZSB0aGUNCj4gPiA+
IGxvd2VyIGxldmVsIFBURXMgY291bGQgaW5jbHVkZSB1bnN1cHBvcnRlZCBHUEEncy4gSWYgYSBn
dWVzdCByZWFsbHkNCj4gPiA+IGRvZXNuJ3Qgd2FudCB0byBmb2xsb3cgdGhlIEdQQSByZXN0cmlj
dGlvbiB3aGljaCB2SU9NTVUgcmVwb3J0cywNCj4gPiA+IGl0IGNhbiBlYXNpbHkgY2F1c2UgSU9N
TVUgZmF1bHQgaW4gbWFueSB3YXlzLg0KPiA+DQo+ID4gWW91IGFyZSByaWdodC4NCj4gPg0KPiA+
ID4gVGhlbiB3aHkgdHJlYXRpbmcgcGdkIHNwZWNpYWxseT8NCj4gPg0KPiA+IEkgaGF2ZSBubyBt
ZW1vcnkgYWJvdXQgdGhpcyBjaGVjayBmb3Igbm93LiBZaSwgYW55IHRob3VnaHQ/DQo+IA0KPiBJ
IGRvbuKAmXQgdGhpbmsgdGhlcmUgaXMgYW5vdGhlciBzcGVjaWFsIHJlYXNvbi4gSnVzdCB3YW50
IHRvIGVuc3VyZSB0aGUgcGFnZSB0YWJsZQ0KPiBiYXNlIGFkZHJlc3MgZm9sbG93cyB0aGUgR1BB
IHJlc3RyaWN0aW9uLiBCdXQgYXMgS2V2aW4gbWVudGlvbmVkLCBodyBjYW4gZGV0ZWN0DQo+IGl0
IGFueXdheS4gU28sIEkgdGhpbmsgdGhpcyBjaGVjayBjYW4gYmUgZHJvcHBlZC4NCg0KVGhlbiB3
ZSBhbHNvIG5lZWQgdG8gcmVtb3ZlIGJlbG93IHdvcmRzIGluIHRoZSB1YXBpIGhlYWRlci4NCg0K
KyBIZW5jZSB0aGUNCisgKiBzdGFnZS0xIHBhZ2UgdGFibGUgYmFzZSBhZGRyZXNzIHZhbHVlIHNo
b3VsZCBub3QgYmUgaGlnaGVyIHRoYW4gdGhlDQorICogbWF4aW11bSB1bnRyYW5zbGF0ZWQgYWRk
cmVzcyBvZiBzdGFnZS0yIHBhZ2UgdGFibGUuDQoNClJlZ2FyZHMsDQpZaSBMaXUNCg==
