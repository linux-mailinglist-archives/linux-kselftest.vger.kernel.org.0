Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8DF7D28B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Oct 2023 04:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjJWCxe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 22 Oct 2023 22:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjJWCxd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 22 Oct 2023 22:53:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413F7D52;
        Sun, 22 Oct 2023 19:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698029611; x=1729565611;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uACNq+b7iFAtTrxNFkNJbPKhm47mXby+ImivCCaDcKs=;
  b=BS3+fwljzOguDgacqEj4AlTaMuDjXTcMS0Cs/+LgrPVmPscaCzeOpChB
   fOW/df1LF6Dh8vDDQkwlHbkJbo08SeJCv4WLaq/6qB9dW21Ip+AlJXvmQ
   NgvPB76cDF6hGPnti1dC0oMXCCABG3pVIQow11lrtt7BXp7AxzQVWJwWL
   jjIvB+L0ZmvOABtag9r45PbYhp8cksoS7S5xdv9XRlK+Xf3HF7ujsXJ7L
   68InrSnHcj716XjIap+9NPKdEUpERzFTJsuISKdh6pqJjSOKt00+/F/Aj
   lUjthxGRwlsrHmmcKW8HmxJ4KiFMqXG/f2CVZLhXs4FirgqZ1U6c0WIUq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="366981735"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="366981735"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 19:53:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="1005165224"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="1005165224"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2023 19:53:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 22 Oct 2023 19:53:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 22 Oct 2023 19:53:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 22 Oct 2023 19:53:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 22 Oct 2023 19:53:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csfkxSx+efBGWpfVGs/ulK+PqX8Db0oTm0D68f7G3jsWNeodjp/P6AhlJy25NrYTnwtI4kwx0lXabq8el0V8tGQ2AZvhh4WRYvLvGVyGQ1t7mzNmQ7DYeBE3+37G3Hs6T2lE/bFF8UcTuxtRjiUn/rJkEeKBvI2eGkMJflQ5fuOD5JOaoHeBXl7sFTbYFK4T2BQcK5k3WsdC5uVZZAx2/XJoZ7E4t6/TV0GSWF69MEomfM007d2h4Czh7BtCRsAY5jNz5PzMLf6w5dBWW2rqe3OrBsGsKNuSIeeRKuhPOd19E/Scm1cgLjfzZ4ekqGA5pj2y8Hk0UP0UkpzvnrU5oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uACNq+b7iFAtTrxNFkNJbPKhm47mXby+ImivCCaDcKs=;
 b=XowToU0GFKYfZZcWLwRaBjeKzvWBCjOaH2X+jFq2sta7u+6cKyI1i0TTrV4wz22gUCRGel0XxtCIYmSDdNCbgnx7X+Co781/NauPndAQ5D4Kqf/n+vNQszcuBEcIfSaIYZ0DzLv1El0+J4ZZF5SuOASlsJdzc1v0Vx0C4vPV3QfpgPWp/abKyiZbN2TxreAQRIvFjsj3fEDZPkTRpA0kJykexnfukAMzv8RsfKXZNpPdfd2sJ87AKc8OIozl50EaI7sCb5LsQmbhTfNkcVnypIKKrjwRW+dojAKBOuxk/rbyOWus5CwKHWrlBZrHipWOoUwkG+r1Ex4K5Y0VnpL+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by MN0PR11MB6086.namprd11.prod.outlook.com (2603:10b6:208:3ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 02:53:21 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::3bbd:f86a:80ea:eb8a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::3bbd:f86a:80ea:eb8a%3]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 02:53:21 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [PATCH v4 08/17] iommufd: Always setup MSI and anforce cc on
 kernel-managed domains
Thread-Topic: [PATCH v4 08/17] iommufd: Always setup MSI and anforce cc on
 kernel-managed domains
Thread-Index: AQHZ7GCNzWxyrCHnVkqPkBvqOzEqrbAsylxggBvMMACAA6lO8IAAN00AgAFSUcCAAIHKgIAARKGAgAFd9oCAAJQLIIABdF4AgAAqZRCAAMChgIAAVP6AgAFq5QCAAhLagIAAKSsw
Date:   Mon, 23 Oct 2023 02:53:20 +0000
Message-ID: <BL1PR11MB527173DCAFA9DD1D9270A8D78CD8A@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <BN9PR11MB5276FDC375685CE04A7AD93B8CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231017155301.GH3952@nvidia.com> <ZS7nb+mKanGFXhZY@Asurada-Nvidia>
 <20231018165113.GB3952@nvidia.com>
 <BN9PR11MB5276B9994AD06E91E07B7EF08CD4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231019235350.GY3952@nvidia.com>
 <BN9PR11MB5276A64DA68586AEFB6561148CDBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231020135501.GG3952@nvidia.com> <ZTLOAQK/KcjAJb3y@Asurada-Nvidia>
 <20231021163804.GL3952@nvidia.com> <ZTWabb6AbOTFNgaw@Asurada-Nvidia>
In-Reply-To: <ZTWabb6AbOTFNgaw@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|MN0PR11MB6086:EE_
x-ms-office365-filtering-correlation-id: 5434055c-dd86-442b-7d4e-08dbd3733727
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xn9K0JdcOXHEP/3iJ3ECBghvhZdld24osyJlKRBlavBvIs6pggRkz/Y8ip1+Fn78HvWnlEvWNf0s0n7JDultkIUBPf3qAm4MyNx23l1VM2yT8YAOYgoeNmbe8i8I5AQMwA5aH99mz1QJ7JgUuU2kST5Bo0cSuGFOEb14SdxoUPJscDt/VhbBf53giB6SM9srB0ruuNKdTm/SS4aaveGWE7MFqRpOV8NkjD0ld8WSvWAH2mfJcDiO6N4eQnieVGPMTDy1A9bzwBhpyTkKwCocQUKcxSkX7nIW3gGb+Afvlx8iFLWfPqsrxc9R3OYsQx9bi5LH/Kl2uwb3xdmXVg+p9A5so/JI7QbNq3Aqw5j4EX4A1oL37EPLI2frH/ocSoFZ74Ed+TBUxSW+JNf0wh+sCDcvt4wEEPgUVjKabIFs+2iK9iQ2PWB5rRFfQF5m7YPrcu2fY8Bph5kzc8MtR1bN9/pRopQf0EIR77zBBPLqyUSRwpUO6qhn1MMTnSzOJ0t86lIuJ8vInLp9MQtafMUbJtb0SZnGDEDsSd2q+UjLHsxU5nPVlzRGHOjUxDoFPNwbz/IrilHxFkm4lzKKaT3OxSnL6yLKkHf3KxpdUAjkHmM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(71200400001)(9686003)(6506007)(122000001)(82960400001)(7696005)(66556008)(33656002)(26005)(66476007)(66446008)(64756008)(54906003)(316002)(478600001)(55016003)(966005)(38100700002)(83380400001)(110136005)(86362001)(66946007)(76116006)(52536014)(41300700001)(8936002)(8676002)(4326008)(7416002)(38070700009)(2906002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djN1TTdNTmI1UWJuY1B6d0VTNHpMUDk2bWZBeFpmQWN5T2hnbk5Gemp5VEt2?=
 =?utf-8?B?cFo2ekRHNDRrazIyZUZadVAwT3hKQkRNcGw0RnBmbjh3dTFoQ3IrNllOaGF0?=
 =?utf-8?B?RUE5U1BRZmRDemVkMmp0Z0tscUYxV2IvZHVQQ25ldTNpclZ6WlVMT1VkODk5?=
 =?utf-8?B?YVU0OEY3dnJoeXFjS1pzU0V0UjZ0UTNDOVVTaVd6ZExpSjVIa05HSHFoRDhy?=
 =?utf-8?B?SVI2L3RQd0hJbVRaamRCaEprRDhiVlBNTGUrZy9ydXliRGo2RDdGWjEzZlJY?=
 =?utf-8?B?Z0tRRlhMV2ZyNkppL2hRejhDdjdmTlZMekI1cFRWbldxZjdXU2YreHpYVTIr?=
 =?utf-8?B?REpQZ3hiM1BPY1pvMzloZWh3S2RjdkF5U3VuQnBxNFlGQW9mTWdQSkFUcGx4?=
 =?utf-8?B?NHB0WlpKcEJpSG5nejJheTBmUXBKQmRuM0tUNFNaZmRiZDBJZzByclorbnA2?=
 =?utf-8?B?MVJTeDBGNEIvQ1I5L2QxQklhNEdyUUtvbVdEZVRMbG9hMDRFR3orMXowSUM5?=
 =?utf-8?B?ZEJBRE1RMFNsTW1GTjNveW9tL1pleFl2WGhlLzVCOFVMZy9ueThZY1d0VSsw?=
 =?utf-8?B?bDFvTWEzeXRacGdVdlVvNDNVeGZYUUlickNTemxHc3FCbUFZRmhqUDhiMG12?=
 =?utf-8?B?MHRzTXlRZlB3bGkrL2FuQXAvU2RkMEN1ak54cGwyWUl3cXptenRIZGdJeE1u?=
 =?utf-8?B?ODNveXdSdjJ4MzcyVVVVUC8yMktSQlcyaXVueS9ZZGFXOHVHaUpPcS9iR1pX?=
 =?utf-8?B?YmxNUm80VXliZFhUK29aZldzWDZGSk5jTHhBQjFKanZWVzNQdGQ5VmU4U1lq?=
 =?utf-8?B?NnA4aWhDZXk4ZEdlZTlJZUg1TTlDWDlobWtwZmVpOWM4cmliUW10VmVxS1du?=
 =?utf-8?B?amZ2OGFxdmRqOVYzOVpTLy9ZN3B5dHZYc0NqaHRKQlVRSzllSXEzTVdTdHZw?=
 =?utf-8?B?blovT3crTnhSSE1obFgxZm5SaEkwMlc2RFhyS0NMRzVORnZNYk5FQTE0V2hl?=
 =?utf-8?B?L1Z0eUtZQmt0ZnU5MWsvdGQwWXd0M3ZBRGhSS2dTRlZOMm5DODUxbWU2MEtx?=
 =?utf-8?B?TlE1RFQvaElGamVKT2FnNWlsYlp2V01ONGJ6ZkQ2eDdFekpONlhWVlE0U0tE?=
 =?utf-8?B?cGt1NlBoUzRoSWJGSUdrUUp1bXdnVHNVdzVmWU80RDZLVDBwZ2NuL1MwT2lF?=
 =?utf-8?B?aHNXdU5LcW04NElXSDkxMVZwc3BJMlkxbkZxQis5S1BjWWhVaWRUV25DMjZi?=
 =?utf-8?B?QmhZZHRQbDRlMzBTSGZHNk9KODhUaUZzc3lnQ1BkbU5vNkc2bmdySHYvQmg3?=
 =?utf-8?B?VTYvcG9FcE53YUJmekNDSURtb21ZcGxWaTJRRjkySjBuRG5lM3NsMmVkV0xi?=
 =?utf-8?B?R1ZKdnMzSWhIZWhVODZ0MWovbjd4d0NEUUhjRE1ZMlFwNlBicVI4ck14ZGp6?=
 =?utf-8?B?RHdUQTlMc3VuSTI3NWZDTWR6NWk5c3RhcUhoSWRjZGJheEJVYVg3Y0IrUVdt?=
 =?utf-8?B?SUxVRVlvMHdBamtUd2JGNXQwQWNuVE0rajZrYlN6eGtLL2J4dmxCdHBYdWxL?=
 =?utf-8?B?TlFZejJKYlhjNWF6VEpvN1htYVRpVm05Y0FtbFFIN3YyaU5JVlBuMW1XQ1dB?=
 =?utf-8?B?Z3h1cEdDSkI5dzVxMVNCMFZoVWJNSGdGWVI1UkZOUjl3eFNMLzJiTlVTTkRV?=
 =?utf-8?B?bUxzd1dha3QvMkpQTjQzZFhOU1dGckFsUGttQ0JKeDN1VklIQ2padkxLdnpJ?=
 =?utf-8?B?VlRpYlpPUGg5c01Gd0hPQjhySkt5OHQxN2xYL3BZMEhJRmo0bTJaTTVJeGdE?=
 =?utf-8?B?ZUZjb2NIR3FCeDZ1ektnL2hnYzFlUjQ4NXk3MEN2OUhsZWlzcGY1TTVOTnpX?=
 =?utf-8?B?UVhlTnRuMS9iZDU5dkNCYTByZDdBUkN4ei80a0J5dDh1YUFTMkE0WEtFVTR2?=
 =?utf-8?B?V1ZRK3FhTkh1Ym1uZ0laRkJHK3NuVHJWdDlOaW0yZEg0dE5QeHBkRk9WU0lY?=
 =?utf-8?B?cWczenhGcWhVL1VITFN5MEJaVE8zWms0K3Z0MkZjOXBjblF4ZnpSOVpvUHlH?=
 =?utf-8?B?NkZmUHBoaFhMSG1aTmwxWEVyQVVLQU4weFY4QkhpVm9leFJkWVZFOFRJOVpS?=
 =?utf-8?Q?n2LQb4uEZm43EAPbkMiSzFoBx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5434055c-dd86-442b-7d4e-08dbd3733727
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 02:53:20.2776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vUjqKyedjMDbgYJin6srtA9gYnUVTD5qsbb4rthXdf9x2SqInzz+/QtTkkDj6sUs5G2ZU2/O1zY3eA/j6CrWPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6086
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IE1vbmRh
eSwgT2N0b2JlciAyMywgMjAyMyA4OjE4IEFNDQo+IA0KPiBPbiBTYXQsIE9jdCAyMSwgMjAyMyBh
dCAwMTozODowNFBNIC0wMzAwLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gT24gRnJpLCBP
Y3QgMjAsIDIwMjMgYXQgMTE6NTk6MTNBTSAtMDcwMCwgTmljb2xpbiBDaGVuIHdyb3RlOg0KPiA+
ID4gT24gRnJpLCBPY3QgMjAsIDIwMjMgYXQgMTA6NTU6MDFBTSAtMDMwMCwgSmFzb24gR3VudGhv
cnBlIHdyb3RlOg0KPiA+ID4gPiBPbiBGcmksIE9jdCAyMCwgMjAyMyBhdCAwMjo0Mzo1OEFNICsw
MDAwLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gPiBCdXQgdGhlIHVzZXIg
c2hvdWxkbid0IGFzc3VtZSBzdWNoIGV4cGxpY2l0IGNvbnNpc3RlbmN5IHNpbmNlIGl0J3Mgbm90
DQo+ID4gPiA+ID4gZGVmaW5lZCBpbiBvdXIgdUFQSS4gQWxsIHdlIGRlZmluZWQgaXMgdGhhdCB0
aGUgYXR0YWNoaW5nIG1heQ0KPiA+ID4gPiA+IGZhaWwgZHVlIHRvIGluY29tcGF0aWJpbGl0eSBm
b3Igd2hhdGV2ZXIgcmVhc29uIHRoZW4gdGhlIHVzZXIgY2FuDQo+ID4gPiA+ID4gYWx3YXlzIHRy
eSBjcmVhdGluZyBhIG5ldyBod3B0IGZvciB0aGUgdG8tYmUtYXR0YWNoZWQgZGV2aWNlLiBGcm9t
DQo+ID4gPiA+ID4gdGhpcyByZWdhcmQgSSBkb24ndCBzZWUgcHJvdmlkaW5nIGNvbnNpc3RlbmN5
IG9mIHJlc3VsdCBpcw0KPiA+ID4gPiA+IG5lY2Vzc2FyeS4g8J+Yig0KPiA+ID4gPg0KPiA+ID4g
PiBBbnlob3csIE9LLCBsZXRzIGFkZCBhIGNvbW1lbnQgc3VtbWFyaXppbmcgeW91ciBwb2ludHMg
YW5kIHJlbW92ZQ0KPiB0aGUNCj4gPiA+ID4gY2MgdXBncmFkZSBhdCBhdHRhY2ggdGltZSAoc29y
cnkgTmljb2xpbi9ZaSEpDQo+ID4gPg0KPiA+ID4gQWNrLiBJIHdpbGwgc2VuZCBhIHNtYWxsIHJl
bW92YWwgc2VyaWVzLiBJIGFzc3VtZSBpdCBzaG91bGQgQ0MNCj4gPiA+IHN0YWJsZSB0cmVlIGFs
c28/DQo+ID4NCj4gPiBObywgaXQgc2VlbXMgbW9yZSBsaWtlIHRpZHlpbmcgdGhhdCBmaXhpbmcg
YSBmdW5jdGlvbmFsIGlzc3VlLCBkbyBJDQo+ID4gbWlzdW5kZXJzdGFuZD8NCj4gDQo+IEhtbS4g
TWF5YmUgdGhlIG1pc3VuZGVyc3RhbmRpbmcgaXMgbWluZSAtLSBLZXZpbiB3YXMgYXNraW5nIGlm
DQo+IGl0IHdhcyBhbHJlYWR5IGEgYnVnIGFuZCB5b3UgYW5zd2VyZWQgeWVzOg0KPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1pb21tdS8yMDIzMTAxNjExNTczNi5HUDM5NTJAbnZpZGlh
LmNvbS8NCj4gDQoNCmN1cnJlbnRseSBpbnRlbC1pb21tdSBkcml2ZXIgYWxyZWFkeSByZWplY3Rz
IDEpIGVuZm9yY2luZyBDQyBvbg0KYSBkb21haW4gd2hpY2ggaXMgYWxyZWFkeSBhdHRhY2hlZCB0
byBub24tQ0MgZGV2aWNlIGFuZA0KMikgYXR0YWNoaW5nIGEgbm9uLUNDIGRldmljZSB0byBhIGRv
bWFpbiB3aGljaCBoYXMgZW5mb3JjZV9jYy4NCg0Kc28gdGhlcmUgaXMgbm8gZXhwbG9yYWJsZSBi
dWcgdG8gZml4IGluIHN0YWJsZSB0cmVlLg0KDQpKdXN0IGxvZ2ljYWxseSBpbnRlbC1pb21tdSBk
cml2ZXIgZG9lc24ndCBzdXBwb3J0IGVuZm9yY2luZyBDYw0Kb24gYSBkb21haW4gd2hpY2ggaXMg
Y2FwYWJsZSBvZiBlbmZvcmNlLWNjIGFuZCBhbHJlYWR5IGhhcw0KdmFsaWQgbWFwcGluZ3MuIFRo
ZW4gaXQgc2hvdWxkIGFkZCBwcm9wZXIgY2hlY2sgdG8gcHJldmVudA0KaXQgZnJvbSBiZWluZyBh
dHRlbXB0ZWQgYnkgZnV0dXJlIHVzYWdlcy4NCg==
