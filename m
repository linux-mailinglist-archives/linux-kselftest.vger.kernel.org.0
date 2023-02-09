Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C8368FD5F
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 03:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjBICxo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 21:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjBICwx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 21:52:53 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFC05FCE;
        Wed,  8 Feb 2023 18:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675911042; x=1707447042;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/ZoVNYyZe1Zq8hcZACCznKC5EdmWPdCXK5A/0uXJzaA=;
  b=JuxrvczAjeGPqLH0dSrxummT+jBerCA24x7spy0hNxWvz2gS/zM0o+mn
   QfSMqMUF96r67eIRwDdHCMypfx/HBk1sEVSltacZfr+aTXG8EzGp2YkJO
   YH9yikXq+xewIdmgLaemHi/8au+PN91kDtgOHnVVXGo8mm90ycvvgjsmN
   HK9giIiz9pKySDX55Jt+WWa7fXj+PR7HwTYgnHw0bHdqtgLaNQ1VIeImv
   1GOKsFfb3wqGhRq6fuBV7C8qOyo4LTbjteGavAu6YN5DXHvTg1bfqS82E
   YwxjT+XiZC5aSY7ScU+60Iz1pcfr8SxBe6pgJbfVgmPwL/VF836Zcy/vv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="317997576"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="317997576"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 18:50:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="841427907"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="841427907"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 08 Feb 2023 18:50:41 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 18:50:40 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 18:50:40 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 18:50:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHf+6uNOLSQM1LKqnzY6GBxifs/lgPdiqC2K8qpjCr+4b3sRSCQnqHVSsBYsdUgF8b402dWLOqgmzDTvaPcavD0j+cBaXSwq+f5WAZTRbLcY7/2SCNd9aDU8aSB2gYlQNgvY1nTSZcHAMI2uQ/C9a/+SSLVQkU4Wl1Hfs6TpIPi/UcfGTDgPA38myIWFo0FgueiDH8v53YXXFZ1zLZXKBKGiZGgUWG4hwlQ04Aducm5n6i23WSFPo6v3JjuOJRX+K7JTvbvm7PPsdWkQAv+96YqQ4O4cs3Nsire1F6L+MrsDRfvJOCTvdj94jJ/epcJ3SoWcxwFBBLcN4bxwlLCvMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZoVNYyZe1Zq8hcZACCznKC5EdmWPdCXK5A/0uXJzaA=;
 b=oJV0mYeYIGZnrEuBZMR2aYFGQ+TFYmw/i7uJbt+Yvxo/zQYnUHkKa7mchYOVRrJ+jvh2pS5p2mTZK23dvLg6DgkSQIOPsBzl8FNJ0sJke42PkWV0+S5ep7SEnYoZ7d17CkRsgDZl9RNrPMKwCGmm3h8PipWOXCcAP/bE2SfV7ri1BUib60WMPIzJydREluSfm+rAYxSHmhCVdhwcSVff4fxb+T1UNxD0C5rkVWl1aJI7Dl2vhUs8JQd0zcaF0eSiOZ/7O3PSPZyl71o6bwnpQcLfF42Py92J282juzI7qGrWJ4k//wc8BfkY2w+lBggP2OkN+tr/AzDRGRReAGwD9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5202.namprd11.prod.outlook.com (2603:10b6:303:97::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 02:50:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.034; Thu, 9 Feb 2023
 02:50:39 +0000
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
Subject: RE: [PATCH v2 00/10] Add IO page table replacement support
Thread-Topic: [PATCH v2 00/10] Add IO page table replacement support
Thread-Index: AQHZOzoLaTccvosdo0yw+4v5PUyMbq7F7ADw
Date:   Thu, 9 Feb 2023 02:50:39 +0000
Message-ID: <BN9PR11MB52766A6DDAAB9E80A5830D038CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
In-Reply-To: <cover.1675802050.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5202:EE_
x-ms-office365-filtering-correlation-id: 802605a8-585e-4a5a-bdf3-08db0a486d8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cJkbkRAcS9VqT2oPQ477pFVp5UsLGYUyR5hoxHrQU6x3rv/AK2C9TD17j9a6MAcCsGxeAh+PlwpiUD8qgP9b+WBEIQPwrYQoxrOVydPe9uBAkNE6xi97477rseKEhzv+0EfELDKZbx9yNNfPs7s5e6w5glHhtuYWacXX3WKx/zqZXfg/OMJIxfyN7jxkaYJxDCK+FNgbJZqxRFPYfAgfvz60nbqlQrypNFnscl/Pxmb9IQnAD5oXK3YmJFJ9+bZLriF/gBEBYKtw+ebg4RSkd5PpBFyUslKZ65Xpkm/xJiGXKdt5V0C06/N7wNrZx3vPauAWEqFr9K/SPo0bO8ZFE4Xrh/42SVETzVwGHTZ/AWIRkQBQCY2oL1us5vvdYYc6uR4eL9654xIKv/EbfOH6VDdmqFjh9nC0O0fmD3AYV1SvRbDYdbxwmHS5xbNnP0rbIBCAMFAmqVO8jLtm7n5lQrkFFuBP5JcPiW/DjD6THDe7KkKo9i5Vl3wgDtAk8EkS8Uv4r0a0l98fUvEce+4O3s8kO1X1MPGgoSI/HiY+8XnGkZUG2jxGSe8bTNg8N7K3166Va3Fl8XidLh6cIrpWXpTQ9HHq6ymrONjfMDKkD6gZTzDBYRIa0qgeqgkxhOvz6NIaTE+VQQyDHu/n0x/mdznOo9RhdwLkHUu/Yf3PDnk3PNIQJbzL8lQkeu9GDm5t13G+19tl+OxFEKobwU59Sg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199018)(316002)(8936002)(52536014)(55016003)(2906002)(33656002)(7696005)(71200400001)(478600001)(86362001)(122000001)(4744005)(54906003)(5660300002)(66946007)(7416002)(110136005)(66446008)(66476007)(66556008)(64756008)(38070700005)(6506007)(76116006)(41300700001)(4326008)(26005)(186003)(8676002)(9686003)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?btFht1zb1DqlfLO5+J6Y1TYhs1Yr5wzdIF9bTux5450be489147rZKn3Vmxp?=
 =?us-ascii?Q?x7X4YriIOTZ5Trr/YmTl9wruoamTqxRMnLdTD6gdUJOMGPOdsGktwiYqqv6H?=
 =?us-ascii?Q?2dSZJg4zOqSGeWp8IxCHyGlxpJJlg0KDn9F+HYgLoZuOgrEXKsfaG1Vwbn+b?=
 =?us-ascii?Q?V897WS4A6jyaUaxARmDtaSNngCus6dfV4mGo9cSulbFMgdZ8h53Rj8FezBT8?=
 =?us-ascii?Q?v6sbJVhCcVyDM78WEw0zURpl7SDrVXwsBFNpV3TOfR4SEtQrnmT2N+cjJ44w?=
 =?us-ascii?Q?oPnz11bx9pmHRkypMhR82ELSDeS+cGUV/Rj5On5mfshHFSCNhvtpiih3H/H8?=
 =?us-ascii?Q?mdVZgdrZ2e3nDHFoS4HmWZu5x4H0KAbnh9nR5DKpSK8agNpAmfKYHZiTlWp+?=
 =?us-ascii?Q?fRDgH/7LY2M8T0nohWgN6j+mLjSQiK04k1m3sZciT0xGBCDyp6kvpOOs3ARz?=
 =?us-ascii?Q?H11MXxuFKf5QethdKUCpX+MRUGQHkl5qFJO99zYCb74gXJbx6pVWV/5rTtsw?=
 =?us-ascii?Q?RfIGmwxETdAWcHO44JUvEg8aBvYvC7RbwK3RsdHNjAejAZBTrYKXcPa+4iS3?=
 =?us-ascii?Q?3cssOac8KHhKcva3hdbshpBPM3yEgVsDzmyeLvyil1oPPXP8UQ0Dw/yIkonO?=
 =?us-ascii?Q?uJCBgYonkK/0Jnj1rwaORdr+Ef/PTdg6PllsenIsyZ1KEtc4pDWGXBSHCVyx?=
 =?us-ascii?Q?Px9bwQJ5Ea/sz493CfBAUBW/2WqdesbGBamrh04ytIFBa+uvgdwKpzwVWCU3?=
 =?us-ascii?Q?DK0G/FYgi/qXUEgPyQ6wUr9H300pWqX/LtddJH47hEpcYPK9JwU2H6kBw5ZV?=
 =?us-ascii?Q?KwYdTtBiIpnp3G1LzF2g+UHYYMT+l2ZwEyAzij0c0pwmc6Pokg3mP8PJh9Pi?=
 =?us-ascii?Q?ZMUZIcXANl27yyOsiHq5/WmvALpWdBNYteW0nC/2YyIf7kREHLZo3bl5Zv/z?=
 =?us-ascii?Q?RgpiMMQYVKxy5dXx6o94/AgG1seaSeNzQiQSbdrRvbUXr/UEWXAi3Rj5k3lx?=
 =?us-ascii?Q?UemnK9m7vqKsSPS54LQ7f3aFTwsicyVkTBXgj7U1alb38dOpMXU8V7mqaDnD?=
 =?us-ascii?Q?YEBNU6+F7t0fznVgOxpvCGR/e7TzXrPgJL6qBIuCFfeK2qerNVqfnhcWNY7w?=
 =?us-ascii?Q?seW3OiOQHkCc2MkBT1FsNZ9Dk6FoGlWl/s28rPju1K20eiv7Cj9pcMiN9eG7?=
 =?us-ascii?Q?UT1yZW6k0+hbM9XE33l0Bv2ehq0iZJw+rN2/Vl/1Igoh5RCsopW/zuKgH0/y?=
 =?us-ascii?Q?8IZoAFzRt40e1iR6yGd69bpUDJK8Af+TFRb5DKVGqmqB8EAjDhCbLMUPJ0zt?=
 =?us-ascii?Q?ab9d0PMNyxoqhY2790xYmRLGK0cbfm7aBbAs9BaR6knhe+0Lau4j2GWMEGJD?=
 =?us-ascii?Q?NsP/ZDLcetVVeFFwToxoNMauIbfUfT4rq9/2YueRRJKe1VKoP2orqD+svQRw?=
 =?us-ascii?Q?b/m/WGhflPUwiCeUNi1ESuCLSUL56t0oLgi7Ah/7szipGy335P4T1Hp6xqD+?=
 =?us-ascii?Q?JZj3PQULWxXKPAwFFUBfjRPS0IovBIVOPI9ixII43+Mn+fIkOpsekZgqLv+y?=
 =?us-ascii?Q?kiF97z3pGhB5vEtXNzZjPmSjmAa81RHDG9itQaca?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 802605a8-585e-4a5a-bdf3-08db0a486d8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 02:50:39.4633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: derV+t7gMYG9ILeVH9dNijE+o3PnPHoJEZB1I156y1YEJsU7E3K44YbLK5/eI/jqp/6wL6kiDZFEPGcNDVEPQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5202
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

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, February 8, 2023 5:18 AM
>=20
> QEMU with this feature should have the vIOMMU maintain a cache of the
> guest io page table addresses and assign a unique IOAS to each unique
> guest page table.
>=20

I still didn't see a clear reply why above is required. Please elaborate.
