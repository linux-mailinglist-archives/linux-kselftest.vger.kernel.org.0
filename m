Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5EB7BEF21
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 01:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbjJIXdy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 19:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbjJIXdw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 19:33:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DE2B4;
        Mon,  9 Oct 2023 16:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696894430; x=1728430430;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LBFBe4wSRIRKO5P0QX9Hw3klraLnxEdNgZzz/M2ttuA=;
  b=fn7rqCdGslqi+Z7dVGaDlV0SMZ0zCzx9DANGD+k3Rr3eZqjmktuD4fxw
   YY5RwJ9VmM5ntTRBAtN30bzSz1qgKRNHYq7VMlcNIKnsIF04C395YJQiJ
   EXb6fl5TXRfQDbdwKvXewi8C3uMMdaq2LVxTszYp2/icc1j860WyUbM9I
   anTqU4aTUoOZ5D4uPQiqy18n83BhkBfqWGa6jdPftWCw2OVggx+/oGRLC
   zke82tO2iOHppfcML0mbvb5LvAJZbxbZC35c7GLh+o3Mx0fAlyQZVKk8y
   oenqPQ8VBHDRmC/c46EMmYbcBdz4nRsCI1IHGwFrr+XubLE2dGj+L4QIb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="363623568"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="363623568"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 16:33:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="819003348"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="819003348"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 16:33:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 16:33:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 16:33:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 16:33:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 16:33:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGn57lQRk6CKGMGkBvcyg6Y/MMEbp5s9aOOGFGZwZQaP6/zIUX7cbt2qQStxPoqC8GFjN1hLIBtcqDR+YOuP9VAzDZMuxv8ZViUc12uZKUwzKI46mUwqApG+untTHe9ymYN8cw4FLmBiVRnWfUsuYj0uTyYlxdulc/WV8LOnm/v+joPFlZm3iwCyan+R9NETe4ajuAy10kdUEcv3ld0ZJvp3DuCiBlamZ3NQTBD2IYdA7GqaHgPYttMbvvL/elDphFjPrDUSXmmqs51qXMr0tjKe7q05V8uVpFHf+1q87KpTZCfRxd1sLJH6Afxg4BcaRTXfqwvjogZUokJBrzvKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBFBe4wSRIRKO5P0QX9Hw3klraLnxEdNgZzz/M2ttuA=;
 b=Xx3z/j30Znph4e/zQ6Cfr6pyzD23dhPIRTXyD38AqHJG9sjX4EIkWdDcWu+i4WlmgYbqdoa1bbVhsokaltiW9MGRQVjN99fudX/I716nLzFGXndbkszzExEaT+vJ85D9WP72Xb49OeAbyuHgKPoUMDi/cXjrcQOKp59LgxdVQtvh+ZL/tqCfeACVjJXFZQerA4OwQ2AsjOhqpfywdOc1xtrNyfv9YtxRWzch3g5fjHqzKSqjFkaJt0q2FpKDL6k09Z58JV8xDzpdK+aGlm9cYg0ykRc9+fVN6IMyKTJKRN5pofkxMBxfYZ/OqE5a+NGuibtEUH1tDWK5f+OYhlJg1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN0PR11MB6058.namprd11.prod.outlook.com (2603:10b6:208:376::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 23:33:44 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4%3]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 23:33:44 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [RFC 0/7] Add SIOV virtual device support
Thread-Topic: [RFC 0/7] Add SIOV virtual device support
Thread-Index: AQHZ+o3OMaCbtqkNIEu5l1gzwLPcX7BBcdmAgACn7HA=
Date:   Mon, 9 Oct 2023 23:33:43 +0000
Message-ID: <BN9PR11MB5276A19AC2CA9DA2B528822F8CCEA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231009085123.463179-1-yi.l.liu@intel.com>
 <20231009132115.GA3952@nvidia.com>
In-Reply-To: <20231009132115.GA3952@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN0PR11MB6058:EE_
x-ms-office365-filtering-correlation-id: b1096b94-0d0d-40a6-0a66-08dbc9202d5c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZvfKMfF+O2Kjh+XckE/FZ1V9KuJs1AaozjrsObF/7MAqhDhhU9mG4Au7PUeGvb7FjceoLBlL+bp17n2BjleAgpqBeG5rJEV3aNSr8EXGCDXgrBPMVXrle/rPsQw7GxS+htMhUGvtUdBdgtU3OXSsNyKKgyawht6NX+2zzbJGqekuo6eA7k6HcfQdtehWreMagPDdqsxP7M5zvjr5fcZ2DxNs2T5az61GNeLADKliQxTA3FkJlHfNnFDzw+GFmwSXwYOospzVx6FXteLCtQwoOMEnLpOJ4dmiZ7fTR/IOwCW1I/4ayKXXGvus3oHjppIgtt7NnZ5JQXIPQFl/j09Cu0ixY1iQLgAOlO7IqHoFqvq2xfOAuyWUByjRZevk+v7SMybLb0aL+13YN0TVfvh0w6nP/XUi+T8E2lt7Nau5HsK4SgTp85nRo7lKBNfVI/qS33WJD5ukMoaSjXA+SI/8ZvoQly9XyqnjuqjbY+lR/YQ9g/gG8ikYXOpzHIoKiVjytVTjILUNKc1fluO7kjyaD4P1z4rpeGMEGhVmVmPIGqUwijl9QTk/jErLRUB32s7w+Hcd4OB1C8vM1GjnhEfYo8vdufhAFuEtLrnW+fL2yRQ20DMq1RIHIXsOtAnv4mRV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(346002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(9686003)(26005)(71200400001)(55016003)(82960400001)(33656002)(38070700005)(86362001)(38100700002)(122000001)(8936002)(6506007)(7416002)(4326008)(4744005)(8676002)(2906002)(478600001)(7696005)(66556008)(52536014)(41300700001)(316002)(6636002)(5660300002)(66446008)(110136005)(54906003)(64756008)(76116006)(66476007)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWJoN2NyRGY1MmllUGdzRXY0aHdEdWxTVlVHaXZZamdRdENzTVl0L09JMndI?=
 =?utf-8?B?RHZTcHJpTENiNnozOG05OFJUYTlpRjhUNDg4QmlFUGVLaGNzQTJyTDljbDVT?=
 =?utf-8?B?R3dBV2ZSRmZnMS8zR3lnZHFXak9WSERvMlFPL25RVXFpQU5ya3MzbGN4dnZH?=
 =?utf-8?B?b1E1NThDMmJ2c1o1S3ZkNFNSN3lHbTJRWjJndG1sd0ovUERBN04rN1huTkhU?=
 =?utf-8?B?K2JuSmVUN0pGVHp2R21sNEVyL091dmV0LzJOWUxwOHJnRGY2QXFXRmdWTkN2?=
 =?utf-8?B?RDVBcS9OcWo1RFZNVFM0M3p6Nm4vVVNqTkdnaDlyb3ZMWjhmaGU4RTVyemJB?=
 =?utf-8?B?WW1icTgrYnNSdGFsTDlJOThyK01lTG9nUUFKbkgxemJEN25yc2pacmJQbk9R?=
 =?utf-8?B?Y2pZYXRObkVrMyszSFBCQW5kbG5YdkFDMzExc1ZZN2lmeGR6QnY5TzlIUE96?=
 =?utf-8?B?Z3p6cE1RWEdyNVZ6TzZFazlLNDhmNGl6WnFhandMVkVjbVphL2daT0Z0eEx4?=
 =?utf-8?B?VWhlSnBqMFFvRXhwRk9zbStzbmNlUEt6OVZRb3BZK3ZxNXJhOWM1YlBneHhR?=
 =?utf-8?B?SVNXdkpLR24zZjhxSTZodWxJOHVHdFp0NzR2VFBVSUs3Y0pycnpoY25yKzA4?=
 =?utf-8?B?NGZmTENzQ2VKT2V2UWJNN0NLemM2SStGOGFBQkpkUlRzQlVjZHhkSjFYMEdv?=
 =?utf-8?B?ZXAxRGI4UTM1cTV3bWtocThzYWoxcEZkZEdCemZ0dnRUU2Jxb3B1M2t6bVp0?=
 =?utf-8?B?ZEtuRWhsd2hzbDh1MXJFZnF6Z3RqMGU2SjllQmVsSlczeXB4TzVrQ1dVQ2NT?=
 =?utf-8?B?T1M0VDY5N2dPekc1eFhsRWRVTURqejdnMHdkbG1GNmNZTlBnNWd6Y1JsdlJQ?=
 =?utf-8?B?RkNWMk1JT3crVkd0c2IxRER3OTd1Q1RmUklYMzJMZWlyMkpOZ3BRMldJbTVu?=
 =?utf-8?B?aTFjdktIZWViRFJ0bDZRZ3dEa2xZL001NGtkeVJhbWx2RTBlb0pRM3diY296?=
 =?utf-8?B?QXBWMFVZNjdXQlJhN2M3Y0lneWZnaHo5MDFUbTZQeHR2QTluemJqZE9BWWM5?=
 =?utf-8?B?Uno5ZWF0N0E1MjJ6REMvM29rdUZlR29NT0FkdjhmS2FPVmVzamJEOUtDbzFE?=
 =?utf-8?B?NlF0MEZQUC9IZk4zL3RvTlZSRW43VXhKODhhTEMwZUZnNWo3TmFXbHlTSkNp?=
 =?utf-8?B?WHhORDJTbm5ZTWVBSzRjN3k5cDIzYW1OQTA2YnBrNXZOR3JOUllwa2tKUXhy?=
 =?utf-8?B?WE1mMFJ4SEUwTnFqZlhPeUJMQjRSa3BOZU44a3p5ZGdBa3BPbXlCclowY2dM?=
 =?utf-8?B?YVFEaVM2UThmb3NXYSs1NGd5VnBlQlBYQmRhODBjbU1hc3gvVFpXQmQvT2dk?=
 =?utf-8?B?ZGJBUlN6UWxxMWlzNFhFdW9OdC9ja1ErUkVCb3UzMzBnMFV5T1JHQjZTOU10?=
 =?utf-8?B?ZDZFSU1vYXN3MTdyZTlkNmw5WmNYSDh2QkNNOFNYWlAyRXo4VytSVm4zc1R4?=
 =?utf-8?B?NVZiN203a2NJb3F6aVNidFhWL2RyemRFZmhDUVg3QW9JRERFYUxQYmx3ekE1?=
 =?utf-8?B?b0JDR1NTbzJhYkJBK3grNUttTEpkNWhVbVdPZkE3VlhEMHk4Mld4ZWRPNXdw?=
 =?utf-8?B?eHJiRjBQTnlXUVpyNEsrOERJU0pBdks1cExWUVZQdnQ2aHpqSEM2VzZHeTBl?=
 =?utf-8?B?ajNsT3ZESHYyWEhqVXN3cjZPanJsN01NT3dCRzJKTk1FK0RqS3huUmdJR3N3?=
 =?utf-8?B?UC9sQzMwZzVqbkJycGVVUEZFL1JneEdGUWxSYk9CY21kSUVlM3crSW1PSHdY?=
 =?utf-8?B?Q1J3dkdaN3JpblZPWFJKeVpvMEs4NS9aZXZqbmVhdTdRTWxEbTBsVzlGclRY?=
 =?utf-8?B?dVBaVjJxMDUrV0tZcTJVeUVpZXM4R0t3NzRIZjRPL24rdzVpL3AxUjhOZnNV?=
 =?utf-8?B?VlJWRHJjWnBVMUhRMk1ockpha084R1UrSTRQMTU1em1QMnRjQzg4TTJySmd5?=
 =?utf-8?B?K2lJVnRjdlIwUGxidFZORnNhMzFxSjBHTktVVzRBS09ncEs2amV5TnRCcHha?=
 =?utf-8?B?QURBZFZiZ25CMnlxbGZqWEYyU2psdWRRT2xBaWpNNjNMZ29PcGVEZStpUTJq?=
 =?utf-8?Q?rZ6QjQRHWJd8y3pq7C0FBFlpV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1096b94-0d0d-40a6-0a66-08dbc9202d5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 23:33:44.0056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ojzoTM9SbUDfFtd/9s43t60he7sqbdM6Mk+KQhglZClAS28458V4r7DkHFsu1NKikWCRr9lRnJhCUIl1mMEswQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6058
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

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBNb25kYXks
IE9jdG9iZXIgOSwgMjAyMyA5OjIxIFBNDQo+IA0KPiBPbiBNb24sIE9jdCAwOSwgMjAyMyBhdCAw
MTo1MToxNkFNIC0wNzAwLCBZaSBMaXUgd3JvdGU6DQo+ID4gSW50ZWwgU0lPViBhbGxvd3MgY3Jl
YXRpbmcgdmlydHVhbCBkZXZpY2VzIG9mIHdoaWNoIHRoZSB2UklEIGlzDQo+ID4gcmVwcmVzZW50
ZWQgYnkgYSBwYXNpZCBvZiBhIHBoeXNpY2FsIGRldmljZS4gSXQgaXMgY2FsbGVkIGFzIFNJT1YN
Cj4gPiB2aXJ0dWFsIGRldmljZSBpbiB0aGlzIHNlcmllcy4gU3VjaCBkZXZpY2VzIGNhbiBiZSBi
b3VuZCB0byBhbiBpb21tdWZkDQo+ID4gYXMgcGh5c2ljYWwgZGV2aWNlIGRvZXMgYW5kIHRoZW4g
bGF0ZXIgYmUgYXR0YWNoZWQgdG8gYW4gSU9BUy9od3B0DQo+ID4gdXNpbmcgdGhhdCBwYXNpZC4g
U3VjaCBQQVNJRHMgYXJlIGNhbGxlZCBhcyBkZWZhdWx0IHBhc2lkLg0KPiANCj4gSSB3b3VsZCB3
YW50IHRvIHNlZSB0aGUgaWR4ZCBpbXBsZW1lbnRhdGlvbiB0b28uLg0KPiANCg0KSXQgc3RpbGwg
bmVlZHMgc29tZSB0aW1lIChhbmQgdW5mb3J0dW5hdGVseSB0aGUgZ3V5IHdvcmtpbmcgb24gaWR4
ZA0KaXMgY3VycmVudGx5IG9uIGEgbG9uZyB2YWNhdGlvbikuDQoNCkluc3RlYWQgb2Ygd2FpdGlu
ZyB3ZSB3YW50IHRvIHNlZWsgZWFybHkgY29tbWVudHMgb24gdGhlIGlvbW11ZmQNCmNoYW5nZXMg
Z2l2ZW4gdGhhdCBwYXJ0IGlzIHJlbGF0aXZlbHkgc2VsZi1jb250YWluZWQuIFNhbWUgYXMgd2hh
dA0KUmVpbmV0dGUgaXMgZG9pbmcgZm9yIElNUy4NCg0KQ2VydGFpbmx5IHRoaXMgaXMgbm90IGZv
ciBtZXJnaW5nIHcvbyBoYXZpbmcgYSBkcml2ZXIgdXNlci4g8J+Yig0K
