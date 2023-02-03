Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3CC6891A9
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 09:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjBCILA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 03:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjBCIK0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 03:10:26 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8817893E2F;
        Fri,  3 Feb 2023 00:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675411775; x=1706947775;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=izvsBwld6Q2c9IHGVwJNyUtXakTaDs7d0aCIN6VJsTs=;
  b=TlQT6InCfvKbuob4LkwuGipPkDbAFy6Q2iKNHypTUS5Ax5nXmbK/2z7z
   EpOl4T45Sj2DinRiAZayy7b4lzAC/0A/QbFVSZJu8/53tIw/roJmUJfoC
   8X8M0qjduYkkwWAJD8dAtla3ciVAz3k++dZyVaFBcFBvpekZrfUGbAq5x
   2MVwa2hrGAhO0tW7nuTaOHXvq01/SBxfntLA5zPuq5w98slAk/eDjmZLn
   gqoH3UeeoSR9BPrf3yzZxy7b/RRg60cUsBvDnOZTWnr9I9GAKDHRGZsdz
   KfvZ30SEsOlIORMiljBv/AhRYdZhzqtTbawXUjy9BPb5nCJ2cCQmtvuv+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="329972023"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="329972023"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 00:09:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="808272273"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="808272273"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 03 Feb 2023 00:09:34 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 00:09:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 3 Feb 2023 00:09:33 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 3 Feb 2023 00:09:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLD8i2Vb7akQmDbZ8khwq3obXOH9crxxMMJUTYKnTwpH45sAVbBNZ4FGOj/yDBrXULITjPcCKZq71UXsOZrI1bPBsx45MgFbl37Cgj/iZ/DQ0ntr+G6KN0b0IMm+/+9lKKGC3WSOoPx5ifen/eEUO/8pjSjtY+aH3qUUsG/cN14e8NIIyMXv9+bgtnkebTl3KC5DYpn+eRcsVY1P4lgBbeFZcDNgF97/T3lWsfzHcjRwEn3VrHNEboLjKrALSAgsEDAoxr/X8Jasnb4Gfn8HQHVKuCmkzRxzCcviEMBZmPxPcodLvdY2/ZJ0wAEvi/iFzaub9LPqcVYjqFAptPuwBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izvsBwld6Q2c9IHGVwJNyUtXakTaDs7d0aCIN6VJsTs=;
 b=mqQmvrCTUjuH6eBXVIBRPh0L6iCD+1dKLm4WQudWaYK5tZpN1X26zpoiW/qSIfnIZFsurqiZl4QUVmTnxglMv7hnh3jcRh7PsGJkeqlzKKjgiDC0xP+m1d3pib89zgSojhNgcqZhinZWCeANFhTyUsaS9+vrSnvu0WsbjEaeZKk0YIO0sHL8dNmF/XXbwYs7WmHPVxt70TxXzcMT3oXRD1F1bTc0nrBFwdYeFYLkDvKBSRDKdRk0r5pFs6IxT1utbWpDdvZGl5GzJYvZKmlCZ1dxESwBQlw6qhrB9K/K1rskylB1tYKKT+FotIRxjTdf01ES14w/C/izFZNB/ujSaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6095.namprd11.prod.outlook.com (2603:10b6:8:aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29; Fri, 3 Feb
 2023 08:09:30 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.027; Fri, 3 Feb 2023
 08:09:30 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v1 0/8] Add IO page table replacement support
Thread-Topic: [PATCH v1 0/8] Add IO page table replacement support
Thread-Index: AQHZNtTGXgNRh4XDNU64JbwG3sv0b6683tSA
Date:   Fri, 3 Feb 2023 08:09:30 +0000
Message-ID: <BN9PR11MB527680F63EC5443DD7A5E98A8CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
In-Reply-To: <cover.1675320212.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB6095:EE_
x-ms-office365-filtering-correlation-id: 6428ab0a-381c-498f-78c0-08db05bdfa1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iJKCaeD49Q60cZ7QsPxwlKGx3+hjmgXL0z0Sh3q8cpZR4+pgjMffufUkKoRanH7hCHQKQbhuHNnpgyjJYDuyZc75sxXy+OdNZE/0l3WoXV3k8/YsqvUFQGDqZuciqkxYijOpQAQh5aeoExtkdvIaQ20JvO17ZcpMAI4CkJECESjciP7uGSuVOk+ZypLIeq65CIJ3Ydqz+ES4OE3nzn1i1EpHDrxZKvE0oznKKcHZgB2BqsFLNakde9MXFK5JbSche/wG21K/RRr1PjQ+rYlLodAKtbWFnY/PrwwNXSz6RKodK6MT0SZkWbAcfoO29iA90A8OjU7w8EKtSobWNi29rVCsH0/Uaw0q4v+Z8XSvbBtIK75BMz91buw3JvQmQ3h9LSeNfyK6buvMiUpB4cPQVWHMZYrOqZMXSqa93Xbps3H4bOabYXPhFv1NjGhj+Ab6jcIBjYYvNRtfw9zsbUYLlMzjSO7Tek/Q2M8nuXH0D/0iwbz/NMYEbI8Q+dfeR6dGzSR4dyAODFqANQH2cnpppo3MRdJQbEdgdfALFL9B3Zhyk+fn7srMbSZ+J0EZGkoMffo+G2Z1+SIC3/FT0BQeMTjUGIZICya26VNnyi8rEe87FNSf0RINxmIlGRVXtqRGrQKnaVxJrgBxCXP1dmDWVVMjhvNT2UovE7u1XRFO3nHQb4WFwlW6Hvcvpp37pSdv3kE2a8VK5gxGmShiEztOF6wDKM86AlA4D8owRz66QxiyaW0NqJ3CFBgdR7jhDD71TGQJAOv0ojpOV1foXfrICg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199018)(82960400001)(2906002)(5660300002)(7696005)(7416002)(52536014)(6506007)(316002)(4744005)(38070700005)(9686003)(26005)(66446008)(64756008)(66946007)(86362001)(66476007)(66556008)(76116006)(33656002)(966005)(55016003)(8676002)(478600001)(4326008)(41300700001)(8936002)(38100700002)(122000001)(110136005)(54906003)(186003)(83380400001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dS83ZmthaHVBZmNKWEpiVDhoK0cvSGJ5aGtzWVRqSlkyNm9rZVJXRlo5dG5u?=
 =?utf-8?B?K0xSa1JjUzY0ME9EYzAzd3BFNkMzTTN6NktMVitEM2lReFlMQ213VitBMkpt?=
 =?utf-8?B?S25aam82Rm9YRGFxV2ZEM00wVXAxQVhaUkIzS0ZManBBdnFUaEF0VUFWZmNs?=
 =?utf-8?B?YkdWb3drNG1KcHcwZ1BodktSSTBUZkU3M2FRUWxGd0hIU3N5QzMwMXJkeUNR?=
 =?utf-8?B?VlQ3UlRXbHh6OXhqWjdLUndzRlFLd2JLNkJpRTlWdEwvbURIbEFBbndjVzNJ?=
 =?utf-8?B?SjNpS2hPNUJKd01BWG9nb0pyYjFHeFhTZU1xb2xHcUJ2MmdYeTl1MGVMd05l?=
 =?utf-8?B?YTBad1NDNDQxUFp1YWYzcldNWTlBZnJkZGUwVjk0bzFXWUdDU2VvNTBJSWVv?=
 =?utf-8?B?ZnloNzV5S0dwenJoY0VXZzhBVWM5WXA5S1l0QmtxKzNJYjZKQ2pvaFZkWGpC?=
 =?utf-8?B?WXFvOUl5bTBQd2MzNmE5VlpXWkhVQTd6MDJnZDM3cmRxMUhMZXdvN1BKdGk1?=
 =?utf-8?B?MnZiRXFmcXhaU21FWEpGcUx2N2VobytzTDBKMFBsQ3hGWWNqU2lnQTRRaWZQ?=
 =?utf-8?B?UnhvRDRMc0REMGEzMW52NFRCSEhQajBEd0s1MG1hMVozaFlnTThhMksrTitF?=
 =?utf-8?B?L2NnU0hBNlNyTGh2NDdQSDlTZFdRelR1VzhwQi9JOGt0Y3ZqUHJvQU9jVjZv?=
 =?utf-8?B?bWthSWpLLzJvbWQzbW9iYkRlWGxwTVpFL3VNOUlHL2J1R2R1dnVkbk12dWxQ?=
 =?utf-8?B?OER1bUVSK1RVakdVMzJ5YjBNb0x6UXVLdTE1bnRMU24xSVI5eG4yTzZVNU1S?=
 =?utf-8?B?dlJjYnk2U2Y4NE50SCtWUCtnTzEreWlUc1pnZ05ZRjl3MFVwTTFiSFNXMDZN?=
 =?utf-8?B?d01MS0M3L2Mzb1dLaE03ZDBSejdUYkFpd1Z1Q1dXekozZE1TK2N1S2RpUzRl?=
 =?utf-8?B?aFN4RnBKZEs3RXRjRXVremtXQzQwL0lIMGN4QW5DRG1LeEdmK1FqMkJuU2o0?=
 =?utf-8?B?ZW5qbnRQeVROT1JyNXA2Y2JyNjdqdHBuVURwb0IzSENidG9xZDlKQ2NvSU5w?=
 =?utf-8?B?SThBNEI4ZU1weTZZL1QvNlVqRjNXUGlURnZrbUNES1RBSHF2U2ZNam9iVUh3?=
 =?utf-8?B?bEJIam9lUlpCTlJYWlFiSUt1NXVKYjdnOCsyb3BDdzdBbHFsSWlXeHcxQldD?=
 =?utf-8?B?bEJiWUI5N094MjNDYzRxdkJQQS8xUnVqY29kOWFMdEo4QzFIempta2FVQVUz?=
 =?utf-8?B?b09wQWNlOEhyNjRHNzFTVlJtKzB3djEwMWd6RjVhZWRRZG4rRktxVVJJQStm?=
 =?utf-8?B?YlFreTR6blY3Y0ppaGs1V0V0d1BhRjhnQnM2c0c2VWtWZEh2MTZ4Rk4wVjBE?=
 =?utf-8?B?MkFHOUpocVFQUGxmNXE4NlZEQWFJaUhFOTV3UDVYRittbjVncGpqNmNld0lk?=
 =?utf-8?B?ek1jVHd2YnNRMWdBVTU4U1Y3OE9wSVdBQlF3TU1HTUdyZmV4ZlhTWmc0OGsr?=
 =?utf-8?B?dG5tRFRwQ2JvUFl4dDJCZ0kxazhZTWhTeEJtSHZ6TTFnY1lYMDNIV3Jac2tV?=
 =?utf-8?B?SXBnWmg0SWFSZzdtVkFiNzN5MUtXSzEyazhaL2NDR29IVTgwZ0pRekZMYUFa?=
 =?utf-8?B?aS8xWFR4c1lNN3dKZDByVTVxd3FubzlUOVpmdk5oaEFyM3JrMXpPQ1h1cTlp?=
 =?utf-8?B?Rmc4Q0RQdDh6b01WcDR0c0dEN3NQeVA2RWdPak93RkJQdVhVcUlYMzlNODNa?=
 =?utf-8?B?K1dEcWNiNThLaWRKOTJ0dDM0Y3ZRN3A5SlFydGRMQzBjeUVkOVhOemxRUEZ4?=
 =?utf-8?B?bjNQR3MxWFQxT3VNbEJvWWxBS3k5YURMdnh5NjJRdFRYM0wyZzZqalRnc0pP?=
 =?utf-8?B?azVUSnk0MDcwaXA5UWhFNURuUnQ3VTBMWEtjRk4xN2ZKT2RpaHQ5ZE1rTjBW?=
 =?utf-8?B?Mm4xVmg2TXkxZE9HbjZUNVB3Y3RhcmxyNXk2K0NMVHdENXVXOXZhT0ZOUVBq?=
 =?utf-8?B?bFl2c0VxL1F2TkMzNS9QVWU4Y2hxM3B1czZTMG80QU16TGkyWUFFQXZEQm8r?=
 =?utf-8?B?SUlKcWVEOUM3bUR1bXVndllMazFKYWFzNitZdis3WDhaSXN3cG0yWVhpZG5Z?=
 =?utf-8?Q?7Wp5ZQept47ASnQKJOmMDI98g?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6428ab0a-381c-498f-78c0-08db05bdfa1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 08:09:30.5912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ASB0ZTmtohXSitN+HKTsUloffJPAz4h3peXX+3bY1qjqhw5DIyEG8kBt5OPgODIbQnEFxRamw7PuKJfTen+S6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6095
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBGZWJydWFyeSAyLCAyMDIzIDM6MDUgUE0NCj4gDQo+IFFFTVUgd2l0aCB0aGlzIGZlYXR1
cmUgc2hvdWxkIGhhdmUgdGhlIHZJT01NVSBtYWludGFpbiBhIGNhY2hlIG9mIHRoZQ0KPiBndWVz
dCBpbyBwYWdlIHRhYmxlIGFkZHJlc3NlcyBhbmQgYXNzaWduIGEgdW5pcXVlIElPQVMgdG8gZWFj
aCB1bmlxdWUNCj4gZ3Vlc3QgcGFnZSB0YWJsZS4NCg0KSSBkaWRuJ3QgZ2V0IHdoeSB3ZSBpbXBv
c2Ugc3VjaCByZXF1aXJlbWVudCB0byB1c2Vyc3BhY2UuDQoNCj4gDQo+IFRvIGFwcGx5IHRoaXMg
c2VyaWVzLCBwbGVhc2UgcmViYXNlIG9uIHRvcCBvZiB0aGUgZm9sbG93aW5nIHBhdGNoZXM6DQo+
IDEpIFtQQVRDSCAwMC8xM10gQWRkIHZmaW9fZGV2aWNlIGNkZXYgZm9yIGlvbW11ZmQgc3VwcG9y
dA0KPiAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9rdm0vMjAyMzAxMTcxMzQ5NDIuMTAxMTEy
LTEteWkubC5saXVAaW50ZWwuY29tLw0KPiAyKSAoTWVyZ2VkKSBbUEFUQ0ggdjUgMC81XSBpb21t
dTogUmV0aXJlIGRldGFjaF9kZXYgY2FsbGJhY2sNCj4gICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGludXgtaW9tbXUvMjAyMzAxMTAwMjU0MDguNjY3NzY3LTEtDQo+IGJhb2x1Lmx1QGxpbnV4
LmludGVsLmNvbS8NCj4gMykgKE1lcmdlZCkgW1BBVENIXSBzZWxmdGVzdHM6IGlvbW11OiBGaXgg
dGVzdF9jbWRfZGVzdHJveV9hY2Nlc3MoKSBjYWxsIGluDQo+IHVzZXJfY29weQ0KPiAgICBodHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjMwMTIwMDc0MjA0LjEzNjgtMS1uaWNvbGluY0Bu
dmlkaWEuY29tLw0KPiANCg0KTm8gbmVlZCB0byBsaXN0IG1lcmdlZCB3b3JrIGFzIGRlcGVuZGVu
Y3kuIEluIGNvbmNlcHQgZXZlcnkgY29tbWl0DQptZXJnZWQgaW4gdGhlIHZlcnNpb24gd2hpY2gg
dGhpcyBzZXJpZXMgaXMgcmViYXNlZCB0byBpcyByZXF1aXJlZC4g8J+Yig0K
