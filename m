Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4117B1073
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 03:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjI1Bqm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 21:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjI1Bql (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 21:46:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E077102;
        Wed, 27 Sep 2023 18:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695865599; x=1727401599;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kTXJU5wczdOHsZeYH5KKHDwJl4OXXqeHunkTw242XQU=;
  b=A6BwqWB1RGJrVY3mxdhzTk+I/1de8yuzKAw8O6O3oBZyxgvm09AoZ6IS
   7X8RJDHDH3SSfVin+K678ohTjn2GaqB28Yvy5EKNgJvzv7R0i6gxeamvW
   MuwpthOmM9shyPFy/TLaxh9A3yLSncDCW50YaGgPxk2gkWUy7arZ1zx7z
   jf6zpbDS1fohE3BB8IUr4pZXybgZJZPCrow4zhXMYmIvbRBM5gpuWIDNI
   1iFchdQG7Zvh1gfOOi2aPimX7MNYpuXHgdJby3ctpBlUROxI8iSdsyn9s
   wGBlZqC7o0I13iFp5530eyU22Blms7e0hXkZCofM+apOq5UpqFqC9Zgy8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="381872514"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="381872514"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 18:46:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="1080393549"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="1080393549"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 18:46:38 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 18:46:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 18:46:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 18:46:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 18:46:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8V8g0VxdoCZ5bZJ3oKkVPq8sPt4RuhjQn3p0XvmgitmmMsTUrmSkroy+5Lw4b3M19hpKgyIg3BWwSqkjX5nz+1AeVQCbBk5NysRslwitJR4VgYEE5NQHZgxNaiZo9NAk9YAuAhZYKgXE/BtuOQQpuIPuDwVuuKSZB7jPRctv2IQ1q+f6PcOYM/N1dAPWEktb6Yr2VdPemZMmyhD/H88DNNhluBzv2VpRozPRpEwgwvIQKsroa+g3sh3TGtY2IRE4MB9DwWhZVZm67k1074toJ5uGtQa94RkEh3kAj7pC7p0+jj2CDYcOEqF7Y2JE8H9/D23iu+Dan6usHXz0fqYOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTXJU5wczdOHsZeYH5KKHDwJl4OXXqeHunkTw242XQU=;
 b=mA1jFL8bJEDet4T4uD1kIEnjJS5bCIraz7pcOjH3FMvB7oxkk2gzunZ7j0ItARAx2fn3VjL1Wn6aVQO/XXSQxCyBRb09502Ojsgyi3TsZ91tDeIUtXGf+WMVJ9Xt5tWQtcXsiI+geS18qe3A189X/nkM6JabktOGMIThMiuUey9AWUMeTPx0p1xzrkPZzxH1OwT1GfOrwcfEuH6l6aezjgnetP1khJ7VXiBmDhSICVpA3B6CwB/xcHnCoKKfB/yxpJ6JsZxgwcnBAy8N4oDmIgd85xZcL4mXLNnZS2dpZomOa0VAMbcuU4KOJy+ry3s/aT0oEp+JLR06lpNxrjDq2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB6296.namprd11.prod.outlook.com (2603:10b6:8:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Thu, 28 Sep
 2023 01:46:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 01:46:35 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
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
Subject: RE: [RFC 3/3] vfio/pci: Expose PCIe PASID capability to userspace
Thread-Topic: [RFC 3/3] vfio/pci: Expose PCIe PASID capability to userspace
Thread-Index: AQHZ8FxBOJ6q7SodUkevUoT08ZF/YrAuTq0ggAC4JICAAHENYA==
Date:   Thu, 28 Sep 2023 01:46:35 +0000
Message-ID: <BN9PR11MB52767C2D7688CE54BFB20D0B8CC1A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230926093121.18676-1-yi.l.liu@intel.com>
        <20230926093121.18676-4-yi.l.liu@intel.com>
        <BN9PR11MB5276375C4BE33AC0632321A68CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20230927125231.3aacde62.alex.williamson@redhat.com>
In-Reply-To: <20230927125231.3aacde62.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB6296:EE_
x-ms-office365-filtering-correlation-id: f22bd943-904b-4ceb-9f84-08dbbfc4bfbf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DCJ+dfCB91b3xYC6zxg/hD5LkVaQY2WZtIP/dXiJNl3YvlNWamjh2AwdRt67EjWnE0a/scq4WNQlBA1vrEqCUcXvBgvzoYH25uymTrK2OXTMQoOoqO4H1xdeAS9gNR0L9kbcH4rEPORBZLteGUFE9H5HyV5GtFDeZaDlGL8HrbfgEUhBTWyMeJWwLKFyRjIPVFKxdfGQ2hTYXq/L5RhQePiLxeQEwyA0GSyhZY54XuckWkjiHrS8lgtn9L/DOWu51jYqnwn3KKTFY+hudb2FsyuLIK+YSka/DQIMnCz7FeKemlb0qQD0T5tNLq6oPAhSU08xTeMmgP4gpWdMep5qfUthSXLEvb3UYgug7CBfnk0Y0d+GRJbIKJWn1nJ3g+8y2YLwabjlwwXJs6UXCGHgMfDYtZ83B6cLNKmrM59bXRfnQpc7lmW4rHsVewjxBJ8kPCIQhUupSteBJwc/ETXgCcTekGUum77pRsZyZfCQTRMqU2lSfOMqeHVPwIYmWfOwTs9BRAffVt35o8qtfMyIA069WedFhuMooof5Iiy6wJcsswQGnMeud0rxe8x+CzVVkZ3QrWj9Mk1GOAocc9C67aFUj+L5N/rEY7LKOieZw3B5dmRbJgfiw9SbC4kjA8pFVNSCK4kUxr0CDvEyM6n6HQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(122000001)(45080400002)(55016003)(9686003)(71200400001)(82960400001)(6506007)(7696005)(316002)(6916009)(41300700001)(64756008)(66946007)(66446008)(54906003)(66476007)(33656002)(66556008)(2906002)(7416002)(38070700005)(8676002)(8936002)(5660300002)(52536014)(4326008)(478600001)(38100700002)(76116006)(86362001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjNvTFhVUGtld214aXdXZjVzR2tPckcxNnBjR3pJbWthRk9DOUlQQ2g5cnVV?=
 =?utf-8?B?eldObVBKamZUQXBHdkhwZGNUMC8wNXNubHMyTzdlYmFtQUVOVWRxWjJBR3g5?=
 =?utf-8?B?SXROQUFSU0RkS05GRXh1R3YrNElCeHZLaldlMmZZa1RnUlhhSjlJR2syeElk?=
 =?utf-8?B?UDNmU2ZjWmVWTGVjTGRvd2g3WVJoRFJmU2pXOU5OUzFGcVp3MDJYdFVPdUFj?=
 =?utf-8?B?SGVsaFc3cmtHY1pVV3VMYTliN0lDVTR1SkFTazk1T1RpeVFsbVp3RmI1Zkhw?=
 =?utf-8?B?ZGxMSmtybWxRWWFIUFVMaTRicjh0cjRtcDdsVXlzSzQ1WEJ0eUhkT0hSZW9i?=
 =?utf-8?B?enl5UlhhTHdCVVBNNzI0dGZaR25rdmtCdHJld3ZKWVE0clg4WUFQcjJoZkhm?=
 =?utf-8?B?QjNlQjg5Ym5VM2IxQU83ZkdZZDRMU1p5dG5BYy9ESnQ0c2dZZllaNTN4TVRq?=
 =?utf-8?B?ZEx4WjJmZndwTnRkMVpzVEJnNkdDOGk1TGluUDlZWC9aTFdlT3dsQlBYMjVy?=
 =?utf-8?B?T1lXdEhqZVJxU1ZZMFpUY295UFZua3cxUTk4bjhaamxqdjkrNVZ0Sm54WVFl?=
 =?utf-8?B?SmNKOGJxTC94bnVYUGpZc0pJdVJ6akFvYllBOXcvSjZkeVJhYng4Y1ljaWRn?=
 =?utf-8?B?T2Y1bHJTMXBaa2dzK2RKcXlIM3ZzamNTeHVRK0Mwa1lIc3pyeHRRekh1MzVx?=
 =?utf-8?B?Y01pUTNadW1yMWZ5VURwajZHbG5nTTlycFc3REFxS1UwQWlOZUY4aGZSaUdL?=
 =?utf-8?B?ZzQyZzM0ZW5rV2dMd0ZoeVozcDBJNTQ2L3MxcDM2YzdpYmJZYWYyeUpEK2ls?=
 =?utf-8?B?c3JmaXdwY25uVVNoVkp1bDBlbFJKUXBNVUFwMElhZ1ZtV3dRV2xTUWQvekVw?=
 =?utf-8?B?NXZhdndQek8yQWQ1Z004K2ZQbytDMXJaNDNoTWpWT2NvZHU2dURNamw4bTJw?=
 =?utf-8?B?TllYT1JqNVd3MGxYT1gwdW5rMDlySEcySVdxb0daNnVTNXRRR2RxMDlzUDlG?=
 =?utf-8?B?OTc4aGo3RlBKVWwrMG1QN21ndnlTdGhscm9tSkdXdlU4UGZrYnB1Zkp5cXF2?=
 =?utf-8?B?YytueURSdG0rQ3YvSDRaQ3RTSzl0Tm03OG81WGwyUG95TUN6dWpvTERIcS93?=
 =?utf-8?B?RVVWU3BYeU5OUUx5VTQreWp3VGc0M084MjBtRWRwVEpMV2cvZCttYVBjdkdw?=
 =?utf-8?B?aENDbDlyeUdZbkJIN3RSVHFLNmtZMlFhUWphMVFLUUxmQVh5QU5jSGcwMDY4?=
 =?utf-8?B?THFrOUdSdjBwbXY4ZTJoWFdPVnlWR1RsbXZPZE9DbWFRR01WcW1NRENjZm1a?=
 =?utf-8?B?SXRDVUNhM0dpQis1MCtERTVLaHNTa09Fb1k0WnlFV3RicXMyYllKNkwrRy9F?=
 =?utf-8?B?RXAvV1VVOG1CSysvOTcrdW1xV1ljLzN6YlhtV1g5QlpMc0RqZEVnYUJMclFT?=
 =?utf-8?B?c1J2NDFoUGhKQWovWWs2OW9EYnU2UWljcDRGQVRqSnNFNzdiSjkxbzBLWmVW?=
 =?utf-8?B?SVQzdVo4MVpJUDhUQjc1a3lleE9Vd2tRbDAzRS80UzBmUWk0WnJsaUIxdnpI?=
 =?utf-8?B?MEpxSFZ0SFdRMVJKc3d5NFFMNmEyaU41NmhKNHhnTTZNODdTbWNKeXRjNExk?=
 =?utf-8?B?UWtJWXB0RnZ0eUxuNTE5UTdyRUxZQUEwenYramxISnUySm1TMm1SYTc1NFRn?=
 =?utf-8?B?ZXRCejc5Nk96OVFnUlpLYThiMm9LTnU2Vklmakw5VmlUbUN3dzEvVkhIc3gv?=
 =?utf-8?B?RjZpSW5Rd0JDV2U4dWt5KzhDck8zbzVtMWh3K2ErMzIwZzliV1VvaFAyeGNT?=
 =?utf-8?B?aG9Eb1pNaGxOUjZLSUtUVE83TjRJcnh2TWVucmJINFNreVY2UjRWcnhvQ0t1?=
 =?utf-8?B?SkpPZDh1MVd1MkpDYlRqUUEvRTFRc2JmdlVVd1djd2YyNXZXVkZ1bjExejZo?=
 =?utf-8?B?aThPbDdkdG1nQ1pMc3F2UG5Ua0gyM0FRVDRXOHhpZW1NMUFMalZMMDhqQXk2?=
 =?utf-8?B?N1kvQURiRjhIMGZ3bW9TSGhvdnVoM25DV1lROE1RVnUyOS8vc2F6TzBPdDVi?=
 =?utf-8?B?eUJ4cDhidm1MTEdCTlNybDI5N0FnZlVQRTc2VWFTMzczL1JISzZTa1BTblZ2?=
 =?utf-8?Q?c3ubXUAXAmBGK5uL/WnDe+aB2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f22bd943-904b-4ceb-9f84-08dbbfc4bfbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 01:46:35.3991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: otOAoyKNyPLZX5Yn2NXHtjhO75UJj71m/YCiIF7VRJ9hCyKfoi9xaA/fDbp/OF9xfzKWXo9O5Fj6x7OTdr/JMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6296
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

PiBGcm9tOiBBbGV4IFdpbGxpYW1zb24gPGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tPg0KPiBT
ZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDI4LCAyMDIzIDI6NTMgQU0NCj4gDQo+IE9uIFdlZCwg
MjcgU2VwIDIwMjMgMDg6MDc6NTQgKzAwMDANCj4gIlRpYW4sIEtldmluIiA8a2V2aW4udGlhbkBp
bnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiA+IEZyb206IExpdSwgWWkgTCA8eWkubC5saXVAaW50
ZWwuY29tPg0KPiA+ID4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDI2LCAyMDIzIDU6MzEgUE0N
Cj4gPiA+DQo+ID4gPiBUaGlzIGV4cG9zZXMgUENJZSBQQVNJRCBjYXBhYmlsaXR5IHRvIHVzZXJz
cGFjZSBhbmQgd2hlcmUgdG8gZW11bGF0ZQ0KPiB0aGlzDQo+ID4gPiBjYXBhYmlsaXR5IGlmIHdh
bnRzIHRvIGZ1cnRoZXIgZXhwb3NlIGl0IHRvIFZNLg0KPiA+ID4NCj4gPiA+IEFuZCB0aGlzIG9u
bHkgZXhwb3NlcyBQQVNJRCBjYXBhYmlsaXR5IGZvciBkZXZpY2VzIHdoaWNoIGhhcyBQQ0llIFBB
U0lEDQo+ID4gPiBleHRlbmRlZCBzdHJ1dHVyZSBpbiBpdHMgY29uZmlndXJhdGlvbiBzcGFjZS4g
V2hpbGUgZm9yIFZGcywgdXNlcnNwYWNlDQo+ID4gPiBpcyBzdGlsbCB1bmFibGUgdG8gc2VlIHRo
aXMgY2FwYWJpbGl0eSBhcyBTUi1JT1Ygc3BlYyBmb3JiaWRlcyBWRiB0bw0KPiA+ID4gaW1wbGVt
ZW50IFBBU0lEIGNhcGFiaWxpdHkgZXh0ZW5kZWQgc3RydWN0dXJlLiBJdCBpcyBhIFRPRE8gaW4g
ZnV0dXJlLg0KPiA+ID4gUmVsYXRlZCBkaXNjdXNzaW9uIGNhbiBiZSBmb3VuZCBpbiBiZWxvdyBs
aW5rczoNCj4gPiA+DQo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9rdm0vMjAyMDA0MDcw
OTU4MDEuNjQ4YjEzNzFAdzUyMC5ob21lLw0KPiA+ID4NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcva3ZtL0JMMVBSMTFNQjUyNzFBNjAwMzVFRjU5MUE1QkU4QUM4NzhDMDFBDQo+ID4gPiBAQkwx
UFIxMU1CNTI3MS5uYW1wcmQxMS5wcm9kLm91dGxvb2suY29tLw0KPiA+ID4NCj4gPg0KPiA+IFll
cywgd2UgbmVlZCBhIGRlY2lzaW9uIGZvciBWRiBjYXNlLg0KPiA+DQo+ID4gSWYgdGhlIGNvbnNl
bnN1cyBpcyB0byBjb250aW51ZSBleHBvc2luZyB0aGUgUEFTSUQgY2FwYWJpbGl0eSBpbiB2Zmlv
LXBjaQ0KPiA+IGNvbmZpZyBzcGFjZSBieSBkZXZlbG9waW5nIGEga2VybmVsIHF1aXJrIG1lY2hh
bmlzbSB0byBmaW5kIG9mZnNldCBmb3INCj4gPiBWRiwgdGhlbiB0aGlzIHBhdGNoIGZvciBQRiBp
cyBvcnRob2dvbmFsIHRvIHRoYXQgVkYgd29yayBhbmQgY2FuIGdvIGFzIGl0IGlzLg0KPiA+DQo+
ID4gQnV0IGlmIHRoZSBkZWNpc2lvbiBpcyB0byBoYXZlIGEgZGV2aWNlIGZlYXR1cmUgZm9yIHRo
ZSB1c2VyIHRvIGVudW1lcmF0ZQ0KPiA+IHRoZSB2UEFTSUQgY2FwYWJpbGl0eSBhbmQgbGV0IHRo
ZSBWTU0gdGFrZSBjYXJlIG9mIGZpbmRpbmcgdGhlIHZQQVNJRA0KPiA+IGNhcCBvZmZzZXQsIHRo
ZW4gYmV0dGVyIHdlIHN0YXJ0IGRvaW5nIHRoYXQgZm9yIFBGIHRvbyBzaW5jZSBpdCdzIG5vdCBn
b29kDQo+ID4gdG8gaGF2ZSB0d28gZW51bWVyYXRpb24gaW50ZXJmYWNlcyBmb3IgUEYvVkYgcmVz
cGVjdGl2ZWx5Lg0KPiANCj4gTm90ZSBhbHNvIHRoYXQgUUVNVSBpbXBsZW1lbnRzIGEgbGF6eSBh
bGdvcml0aG0gZm9yIGV4cG9zaW5nDQo+IGNhcGFiaWxpdGllcywgdGhlIGRlZmF1bHQgaXMgdG8g
ZXhwb3NlIHRoZW0sIHNvIHdlIG5lZWQgdG8gY29uc2lkZXINCj4gZXhpc3RpbmcgVk1zIHNlZWlu
ZyBhIG5ldyByZWFkLW9ubHkgUEFTSUQgY2FwYWJpbGl0eSBvbiBhbiBhc3NpZ25lZCBQRi4NCj4g
DQo+IFRoYXQgbWlnaHQgc3VwcG9ydCBhbiBhbHRlcm5hdGUgbWVhbnMgdG8gZXhwb3NlIHRoZSBj
YXBhYmlsaXR5Lg0KDQpZZXAuIHRoYXQncyBhbHNvIGEgdmFsaWQgcG9pbnQuDQoNCj4gDQo+ID4g
TXkgcHJlZmVyZW5jZSBpcyB2aWEgZGV2aWNlIGZlYXR1cmUgZ2l2ZW4gUWVtdSBhbHJlYWR5IGlu
Y2x1ZGVzIGxvdHMgb2YNCj4gPiBxdWlya3MgZm9yIHZmaW8tcGNpIGRldmljZXMuIEFub3RoZXIg
cmVhc29uIGlzIHRoYXQgd2hlbiBzdXBwb3J0aW5nIHZQQVNJRA0KPiA+IHdpdGggU0lPViB0aGVy
ZSBhcmUgc29tZSBhcmNoIGNvbnN0cmFpbnRzIHdoaWNoIHRoZSBkcml2ZXIgbmVlZHMgdG8NCj4g
PiByZXBvcnQgdG8gdGhlIHVzZXIgdG8gZm9sbG93IChlLmcuICBkb24ndCBhc3NpZ24gRU5RQ01E
LWNhcGFibGUgc2libGluZw0KPiA+IHZkZXYncyB0byBhIHNhbWUgZ3Vlc3QsIGV0Yy4pLg0KPiAN
Cj4gPyENCg0KU29ycnkgdGhhdCBJIGRpZG4ndCBwbGFuIHRvIGVsYWJvcmF0ZSB0aGF0IHRyaWNr
eSBjb25zdHJhaW50IGJlZm9yZSB3ZSBzaG93DQp0aGUgb3ZlcmFsbCBTSU9WL3ZQQVNJRCBpbXBs
ZW1lbnRhdGlvbi4gRXhwbGFpbmluZyBpdCByZXF1aXJlcyBsb3RzIG9mDQpjb250ZXh0IGFuZCBo
ZXJlIGp1c3Qgd2FudCB0byBtZW50aW9uIHRoZSBwb3RlbnRpYWwgcmVxdWlyZW1lbnQgaW4gY2Fz
ZQ0Kd2UgbmVlZCBtb3JlIHByb29mcyB0byBnbyB0aGlzIGRpcmVjdGlvbi4g8J+Yig0KDQo+IA0K
PiA+IEEgZGV2aWNlIGZlYXR1cmUgaW50ZXJmYWNlIGNhbiBiZXR0ZXINCj4gPiBlbmNhcHN1bGF0
ZSBldmVyeXRoaW5nIHJlbGF0ZWQgdG8gdlBBU0lEIGluIG9uZSBwbGFjZS4NCj4gDQo+IFNvcnJ5
IGlmIEkgZG9uJ3QgcmVtZW1iZXIsIGhhdmUgeW91IHBvc3RlZCBhIHByb3Bvc2FsIGZvciB0aGUg
ZGV2aWNlDQo+IGZlYXR1cmUgaW50ZXJmYWNlPyAgVGhhbmtzLA0KPiANCg0KTm90IHlldC4gV2ls
bCBkbyBpbiBuZXh0IHZlcnNpb24uDQo=
