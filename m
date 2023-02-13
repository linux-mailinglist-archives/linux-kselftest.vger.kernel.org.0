Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2090693BEF
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Feb 2023 02:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBMByW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Feb 2023 20:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBMByV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Feb 2023 20:54:21 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75589EF97;
        Sun, 12 Feb 2023 17:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676253260; x=1707789260;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sEpt0T38DsLBoLnS933Po3XgycGa2RG8vzAErHBP3kA=;
  b=lwvDqfj9BiyaFbRvJhpbndL8h3Bc4ZOSBnrWEazDEfO2SBm4uonxCAHk
   mOiZMVl/StII2CiBfYq0rK0wpJ4oeKjH0+bUpDwK4sx0pfa7x/V5+dntN
   1rQ/7IdMrfutTBx5du2SE7MrfgLscGdGsw++PWXfdZxPrmVzRpXYM4mIu
   5aIKJj/GpzrHFGAfVwxVRxxt+KPIgUIoGOVZ0oI1qSDUiTDEWdoypv/y+
   kR1ZMTyXVXgZsDmLBPWSlMfDa4k7HfTN8BM+zl8a5dvHq66Oq8I2ffFw8
   Q5ODqODNxUQCTibcRAav1LwhDiqHK+qnlyk7OXjIrXNFn4a0D5rh7U67n
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="393187482"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="393187482"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 17:54:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="842604318"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="842604318"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 12 Feb 2023 17:54:19 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 12 Feb 2023 17:54:18 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 12 Feb 2023 17:54:18 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 12 Feb 2023 17:54:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2xY7r5HtBfnNlBy114/3Sy2A/fshfq6jD4ooPnpvsQjDPvBfPcr49h/doeRSXvSHz3d3Hq+PhfncloYaahaEdcZkFAl5kZcymyKExyMWaiUEXBYO8UE5H9zZrCyn5Ep6Z9+oTo52t79/Btrm3WuTvODgxJ+Awf2Vgm93gv2bYTxaPd4d207K9AUqjuEQjVygokPdrIX4tsmsrepttHRDrNDqqPm6N3Lum1xfyY+KQi5XuX/vV9PFBT4rMjltQ50rp44bta6IZu2BnryXFUJFdJmlOsgm7frUfRkPPOQbTFm9pWcztK4b0Cl8fPdlTWlwQXlxZhB2RBW2Qd62h0Taw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEpt0T38DsLBoLnS933Po3XgycGa2RG8vzAErHBP3kA=;
 b=i8nDHQ6IIHBGsV53mdijm275gb2/CKmjvUX6JqLvVLSozBtF7X5vd20xLfmhWc2/eAC8hfOcwq500usx23S1ZqEuiraIaQHSrWr2mDt8nCf/fJQq2cziPcJTy6MSviuCriVmGMAkqHzzoYN7cczwes2bvR7gZ9APfSmYSDPhFwlwIyraoWffb5+UJ43H0qGok8O/6cSoIaYFSVlcGLbkS/rgpNcNuPu107YYMphga8wR5HWExm4WBl36nvAYLCKjNZR/AG3aOoHFINu1D/BvuqjNDxfcZtB5XQa6w/oBIVHTvdDrfBukOx3yOaNMeGOyMGJywGu0ZXHbJ4jV3BVQmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB6916.namprd11.prod.outlook.com (2603:10b6:930:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 01:54:16 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%7]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 01:54:16 +0000
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
Subject: RE: [PATCH 1/6] iommu: Add new iommu op to get iommu hardware
 information
Thread-Topic: [PATCH 1/6] iommu: Add new iommu op to get iommu hardware
 information
Thread-Index: AQHZPD1VEVujMOhMCUmoab2cFB5/6a7HyazggAFTpQCAAwY+oA==
Date:   Mon, 13 Feb 2023 01:54:15 +0000
Message-ID: <BN9PR11MB5276071461BC318B76A379348CDD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230209041642.9346-1-yi.l.liu@intel.com>
 <20230209041642.9346-2-yi.l.liu@intel.com>
 <BN9PR11MB5276CB88298F97177A7AAF448CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <8665f299-fd4f-738a-6492-59f0deef444f@linux.intel.com>
In-Reply-To: <8665f299-fd4f-738a-6492-59f0deef444f@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB6916:EE_
x-ms-office365-filtering-correlation-id: f103f54a-07f6-44c6-ac3f-08db0d65365d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Av+wiqFdpjI7Wn+pUM59bEL43Ysj1GjgUh6lFybSorL5rZafZxkrtVgXnvRqAHs4mfGAvb6T/QnC1pwYn4kppfVTmjePygoDeXs5RHE0QCC3MGBg34RKKDdr15HwJYVKi3x7Ve/CZUMngvpV9n8AsXOeim3aNoNnBeteLbt5Mqb1x7/gZb4FTbojQto7DwTMvJrlTt7LCgzXDfzB0rMvo9df3oIbLoDzXpZIYM+wWiPm1MsdWWNKw/lKK3Sw35Bw9SZORjCYwSZPEOLOd3Qy386BDyInIENj4vhR2f1SvMP+RlfCkAtBwb3baGES59jJi4L3SbCLdhr6HqDuneWmE9NOf5pUme+t9nVTBX3jZpWigzICz+2ByDQUYH76Cue9y9fRR5R6WS7V33GN/osb5hwwJxZw0v1l15nAQqGFQAhhSzoZu3b98QpphHnjNzdqpUpCrQCRk2D8UuNr1CVRMgwfJCNLqtDEVrPFM58B62FG0qIfnyYn9/noD97zD9HRFOgiozRHvz+v2g8hKxMXv99cspeDg8zmLdS8kXpYc2dQm4uuqRCnzonMR+Sl7RO5p/vlQfw213+rEZxtyBJ/hYqbXPbqlgiKgQZ7MlAwzvWulrwD01axZd64MZVfyfH2AVlQcG2ZMgwQODWkSz8kE8PW1VbUoFvW8hvXFbD3Dcf9lYxermG2aqF3gwx40tjfKFK3G+ADg7qIs6cvoJ86sA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199018)(7416002)(5660300002)(4744005)(41300700001)(8936002)(52536014)(38100700002)(122000001)(82960400001)(33656002)(86362001)(38070700005)(55016003)(2906002)(7696005)(316002)(110136005)(6506007)(53546011)(54906003)(26005)(186003)(9686003)(71200400001)(4326008)(478600001)(8676002)(66476007)(66446008)(64756008)(66556008)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXM2bVdsYTh3THZ5NnJ5ajRBMy9zNTVDalh6a1ZLRG1oTHhTaldpNUpoSE8y?=
 =?utf-8?B?TXQ4Y1pqRlhjN1lOTjNXZXloN2JZdzNTNnliSnNuNEs4eTFUZExYcVdwUVdQ?=
 =?utf-8?B?N2hBZkxZaGYyeUk5anpwQ3QxNTJjUWJ0NGx1MlM5c1NoVGhPN0FyVjIyRFlz?=
 =?utf-8?B?UVpXZXpYVnRpeHdhSnhza3lvNnhROE1hRE1EanpBK1FJcXhNbHR2Ti9sZWZG?=
 =?utf-8?B?Y2M0c3U3TmEyVHlYTVk5c2hORlJIWEh3dXErZW9Eb1gxbkQ2UjUzSXg1ZGQ2?=
 =?utf-8?B?Ui8wM1h5bnVZWnhzazc3OEhvK2hBd3hndHhMcVNCT0FPb0pDMnBRaEMrSG9s?=
 =?utf-8?B?MVBxTTNwWkl5SDRQc3ZMMlJ5WmlhaXFzRFVsYmplODAyT2V0ajQ2VnJXN2sv?=
 =?utf-8?B?dGRyNHF3VUFubGptNmNXeTV4Ukp6MHVjY09XdkZHOWlxZDVwMEVhM1dPazM2?=
 =?utf-8?B?cU1lTER5d1lYVnU0N0d1RnJjTU1MNXl4b1RwNmlVTTQ1TmlRaU5naTJ6WmNH?=
 =?utf-8?B?SW5LTkFkeGNCaDZQWTJWRGhSTTZXaXYyOUtVT0hGMm9WQVVSYWRGUFZYNks1?=
 =?utf-8?B?Z0p0TUhERDlwZkQ1M291Y3EyK2JhQXZneEEySitjczZOU0xERHR1QUFBazN3?=
 =?utf-8?B?SkU4QUZpUVhOWFIreXpsT0QwVkZoTzRhQ2RPdEpQZi9WSnR5MG5yUmV5WnI3?=
 =?utf-8?B?bHFXTjcyTkNCUHRVQzkzM1R0NG13ekRKT01oMEFPYytMMm5iUm1aOUt1MDlv?=
 =?utf-8?B?LzE0V1pENUZ4MzdRcE1CSXRRaXpxYWhUQXdmWlRTL214a2hoQjlNYnV3Nzhr?=
 =?utf-8?B?SjR4SVREZ1dvMEVoSG5JQWdaNTNLbUswYm1ZNnEveVhwUGltem1vNDU0WEMz?=
 =?utf-8?B?VHZGZnlLVmpieExGeEhHWFhvM0pNcEZ2VEtJcWE5ZkQ4R3M2SzB4UmF6SjRz?=
 =?utf-8?B?dGgxVVNyTVF2N3c5V2g0YURXZlQvY1JBTTBLKzJMaWtQNkJhUlc3UkhGa1p6?=
 =?utf-8?B?MmJSaStTdmhZandGbm1vTytMMGZ2NlhiTDN2VU9PcDVlVy9NOWFXUjZ2U0R3?=
 =?utf-8?B?OUpvVEt5TjRjbW9QU1NJbEIyditNekVLdlNSMzJhWGhYRXorSUpNaE9Cd3py?=
 =?utf-8?B?OGE1eng4UzVzZkdSa2tiNkdBT241QzF0cnArU2lrVnRYb0dkempHN2JCWW5k?=
 =?utf-8?B?QjJHUVVaS2Nra2dIbXY3SHcvWWVRM21PN1VWUVhhOElsVnN5L1pVN0xKbmRx?=
 =?utf-8?B?QUNLU09yTDdRVktjUWE2Q1R4Rk56MXEvMVI4d0NOWVhwUHNRam5IWElTMXZo?=
 =?utf-8?B?V2RsaTlOdHR2SG43ajQ3K1NtYlV6Z25PMnFDOHErUmF1TDBvbUVLVHdZYnFj?=
 =?utf-8?B?a1YydG1KSnp1TEhNdjd3WVgxV3VRS21mRWlFeFNEU0hoY21ZdVQreW04WnBa?=
 =?utf-8?B?b2NzM2tVYzBTZUYzV241VTZDYUUzNUJCRGxEdmRFZi96QVZONVhqMDBpTldn?=
 =?utf-8?B?bjB2aDRFYWZ5V1JrcDdDdDBKV2ZZWFlqYk9tRFNMVXFNeW5BWk12SnVsc25P?=
 =?utf-8?B?SUl5YjRxZFhOeTN2cGwrZncyMFhjdzRWL01MRWJPVVZrOENqVk5YVDZzaUpC?=
 =?utf-8?B?bEpPNXFJYXZvSXhuR0ViUG80SklCTmZpS3hZTFhwU05ZYUdNOEIwdzFuNUJH?=
 =?utf-8?B?eTFyOE9FR2RNZSsvTXFUSVpLOTRRSUhWR1JZY0tkMzVjREd2clVKN1FLWWJ5?=
 =?utf-8?B?aEtnMVVmVmo4M1RoWHJQL0pDMG5ScjFGcFlEMUwydDg1aGluMEk0NzlLdUx6?=
 =?utf-8?B?c21pKzQ0T2tDUEhPQmVFMk1vMXkxeGtpOHhQSDdZTyt4eFNVNnpGdGxhRjNs?=
 =?utf-8?B?M3hUdzBwQy9qd3RlTjNLa3I5aEkvaVl6anRBaXZONFd6NGMwSmRZelhXZTRy?=
 =?utf-8?B?dzdyZDd5YTNFZFBZTk1VRmtGTVlWU0kvc3FUamg4eDVhazhGUGJCZUR6bXdB?=
 =?utf-8?B?aXp2LzVnMFFvUENubFNBdVRJRHVxTnN6Wk1MTDNSaThreWxuRitYeW1GVXhX?=
 =?utf-8?B?YytBVnFzS09XQzdBRmF1TzdaMW5MMnJnODRtbFQ2T1hqbGxHZUhsWUJDR1Nx?=
 =?utf-8?Q?yD+UooFgmls5NXGqQBJE5VLJ5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f103f54a-07f6-44c6-ac3f-08db0d65365d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 01:54:15.7398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X7PO3WIWrkUL3A0ML+HG0aXFzMZ+ViG+LOPaJbyPacpnbnvlQUX0oD8LtqFNFKVT5CCndoiBwxC8VNAJLdx34A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6916
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTYXR1
cmRheSwgRmVicnVhcnkgMTEsIDIwMjMgMTE6NDMgQU0NCj4gDQo+IE9uIDIwMjMvMi8xMCAxNToy
OCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IExpdSwgWWkgTDx5aS5sLmxpdUBpbnRl
bC5jb20+DQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSA5LCAyMDIzIDEyOjE3IFBNDQo+
ID4+IEBAIC0yMjMsNiArMjI0LDExIEBAIHN0cnVjdCBpb21tdV9pb3RsYl9nYXRoZXIgew0KPiA+
PiAgIC8qKg0KPiA+PiAgICAqIHN0cnVjdCBpb21tdV9vcHMgLSBpb21tdSBvcHMgYW5kIGNhcGFi
aWxpdGllcw0KPiA+PiAgICAqIEBjYXBhYmxlOiBjaGVjayBjYXBhYmlsaXR5DQo+ID4+ICsgKiBA
aHdfaW5mbzogSU9NTVUgaGFyZHdhcmUgY2FwYWJpbGl0aWVzLiBUaGUgdHlwZSBvZiB0aGUgcmV0
dXJuZWQNCj4gZGF0YQ0KPiA+PiBpcw0KPiA+IGlzIGl0ICdpbmZvJyBvciAnY2FwYWJpbGl0eSc/
DQo+IA0KPiBod19pbmZvLiBJT01NVSBjb3JlIGRvZXMgbm90IGNhcmUgYWJvdXQgc3BlY2lmaWMg
Y29udGVudCwgc28gaXQgaXMgbm90DQo+IG5lY2Vzc2FyeSB0byBkZWZpbmUgaXQgYXMgY2FwYWJp
bGl0eSBvciBhbnl0aGluZyBlbHNlLg0KPiANCj4gUGVyaGFwcyB3ZSBuZWVkIHRvIGNoYW5nZSB0
aGUgY29tbWVudHMgYSBiaXQsIHNheSwgIklPTU1VIGhhcmR3YXJlDQo+IGluZm9ybWF0aW9uIj8N
Cj4gDQoNCnllcywgdGhhdCBpcyBwcm9iYWJseSBtb3JlIGNvbnNpc3RlbnQuDQo=
