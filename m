Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45E97BD1AF
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 03:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344728AbjJIBK1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Oct 2023 21:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344690AbjJIBK0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Oct 2023 21:10:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4F8AB;
        Sun,  8 Oct 2023 18:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696813826; x=1728349826;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wC92ecu2o1qBaMqQyPW3Siz/0aSZu2dEuuFrfk/BMrk=;
  b=YqtM+pSt7NSS7Xyhl/PTmwvsZ7O5wqlbBSAbMtROVWeLTZxNUZtXW+bd
   a3T7vNkt0CNGAf4yetnjuzK41YCEvjOzHHT8fbda7UtSNama0/5gfXoOW
   DlvuLI2wIz+hbSB8G18XbDp6LkVjDW/7EhgXWHFia3JnTsuslzCESzVXS
   sONptaIyr3/ixmgoMfYLE85f5plHbMG1lLxNuePjBpYHmp5DZXq3ENv3J
   ePaty5QWws1M4tUvBIMmwTKZCw1OEkkBY58nxFlS7gn9eWDCTf2+4eXtI
   /iymy01VrrtyanQYn5VE/bji+XtcaVIFAmnXO1nWLGII42Po88ffA9Npc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="2649213"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="2649213"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 18:10:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="843525174"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="843525174"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2023 18:10:24 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 18:10:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 18:10:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 8 Oct 2023 18:10:24 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 8 Oct 2023 18:10:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCHIHqaZ/++7BeGpC6UNwsAWLW5c9WM4ZtDUGmPpMkz79MbrRoRv57NXqwFNgSaF2PusKcNlOgpbhCbYEYcu1Lx5SvmsJo8p29NTibjP2WLPrtO7JgRCrMtovm5r5K+qu+wUYgYNKdyytfnhHumz8p/KgJcnREe3zbFqKvdFwgztqf+MOHlc9V+n76AfByTBCs1QrxQ0kymI8FXPqoAjJpWQXGT+820m5CsNLtdYLY21tUa3q36CwK2VyI27O/b+zR5AUI674Zm+oYf3ZWOBJoMQnSPMfPuSTTiAVDAD2ZmeFwNSVLxOzXNS7ff0vIhYPmG2kxf7jWgEJ/HC/ktObw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wC92ecu2o1qBaMqQyPW3Siz/0aSZu2dEuuFrfk/BMrk=;
 b=FlRDpg3e/Wm8Hb9sGtdKhGlw4P6lZxpyGM4Z+bHb2FHsfRXjpl5X4bVLV70GmlEcoGwdgq5RYLuh3SrEfkthVRGbQgH9PFXiwADx5iG2RkdrAYC31U/J1Yjyl/MIw6ueH1CIYtO656CDq7Qg2ORdj7mNm3MdX+JiwumIGb239uE2bDdZNXjUHkl3SOKtZdsm5mqH5obqhhfWFYrCNqPMxj60y8SAfr3SifIMDhxc/TnaBsmuVLqpQOqVQPBYgr/RUiciG8tTEHcHrCe5Q99dS04gbS/kaymn/rYT27oVHgZ4hHDUQt0X5fS8LAloTFPogwxaxCycI3rFHVXgBrUuOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by BL1PR11MB5445.namprd11.prod.outlook.com (2603:10b6:208:30b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 01:10:21 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::53dc:1b11:86de:ff9c]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::53dc:1b11:86de:ff9c%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 01:10:21 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
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
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [PATCH v2 4/6] iommufd/hw_pagetable: Support allocating nested
 parent domain
Thread-Topic: [PATCH v2 4/6] iommufd/hw_pagetable: Support allocating nested
 parent domain
Thread-Index: AQHZ8dubtd0+6gMft06r5SnVY6lTTbBAtuvw
Date:   Mon, 9 Oct 2023 01:10:21 +0000
Message-ID: <BL1PR11MB5271BFDB1A27D07E192B929D8CCEA@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20230928071528.26258-1-yi.l.liu@intel.com>
 <20230928071528.26258-5-yi.l.liu@intel.com>
In-Reply-To: <20230928071528.26258-5-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|BL1PR11MB5445:EE_
x-ms-office365-filtering-correlation-id: bd9db7dd-ab1c-4767-8415-08dbc8648245
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7+f3SO/OGvolVQX3fC+n4z/uP6p0OX0xbKTiMLp0vDpfZ9NteyIDTI6GMPFfFF/P0oNhZi6grEeg70fSmPW0Mx1y717mm+ttOePxnmsD2FvcFGA+HU/tbemjc/4u9cFLjB1hK3yqRhqdkYD930w1PU9IahscAlUGOvYECOkZn9nYVOpmGIVXV6kCU2syuVIN20KZo++xUxkh/rPAF43eYFw3BO2xUBGWlhkPwbM8ZnGQh6VwmmhqGtzEo0KkfizullKKsnPvY2PO2dZcAf5QWuGobT18yBqkueSmfjYd/Bxc/C52W8FZpQMC3bYPTtY//S4ak192iwVvuj1V2bhYrwvIJ1rnEukMcyNBbtsvNvfzkKuwag8Q7r/ePMzAy1sT4F0szjnlvDW66joICyRb/GRGQtpZXwzYYwPyVBMcTOkWCwTWzhqL3SAvcv3uhNhC6tnfupx3abpOEPAoqudgt2wCAkiPj7Z2Qlj3PuDDJfKt++JiXqjPCw2TJr+8qIssWCFlQBJyuUHK1MWyvpNbGusNVGXqJyoQybWwn8m2CE2ZeVJaJQDxwKrut8uWYrKJjomSiHDK+p61n5pJnHQ5iDRCrsROi6XVEL7cjnarICb7m7+fL8rxund1FuZym10g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(55016003)(66476007)(66556008)(66946007)(54906003)(76116006)(110136005)(66446008)(316002)(64756008)(7416002)(8936002)(8676002)(4326008)(5660300002)(52536014)(41300700001)(7696005)(6506007)(71200400001)(9686003)(2906002)(478600001)(33656002)(558084003)(38070700005)(38100700002)(82960400001)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fjq5DJ2UH1+CmqgWLtxv0wYK62L3Ap/eZJwJcz3U65hYBpeq7M1PIwoHXBT2?=
 =?us-ascii?Q?2wMrNnin3wNDwbCDH9IxMMZTFMF1uOq8eXroJTCCxc3UIbypbPYL6TfIgM3k?=
 =?us-ascii?Q?O1p4B55KTFliVZx/NEvoth8JnJl5k03K/LlLuknH1SB0IqdKRsBzID/UirX9?=
 =?us-ascii?Q?8TDucQWuSBdqcYwQGP+Yeo+Si/naJO8nLIh0XbCo8cI6hMMYVTQNRF1FK5H2?=
 =?us-ascii?Q?xG8aw+UpjwL6ynpLyi/+P58dQf1BfsxfIIvVlE0hvXTpXW9vreEal2I1ib0w?=
 =?us-ascii?Q?Og4unPiuGl0UYZ6pDQDVTFGQ9kEHBy6F/JIgbS3S1hPE/C5rD83njY+2IEHH?=
 =?us-ascii?Q?u/e/eHn4eSWBobFWtntKp57y3mupRzPM2hwsRFfG9ghfGzGEHcD52yTrEfYG?=
 =?us-ascii?Q?4C4QZKVZYegliM7mG9bC8DTtRovi0iXB1NJUhDzskjMd4MSoCct8QEBovqCI?=
 =?us-ascii?Q?poPwGpz/yB2rEtiBUoovnNaDJjAMgtVSGE+Js8oSVmjV34VVixIwdPJPBgeU?=
 =?us-ascii?Q?Est0hZYRYrtNfEs92ZaJNeE8L5gtY1/Kek9DTBcjp1lPCdSn4yIlm/oMEYCV?=
 =?us-ascii?Q?lbrVA4JugnRy/aS6V03ZVzWq8fWpbzabHNTnlbOj/ew4N1TROJahhXaAVuz5?=
 =?us-ascii?Q?ZNyvbCOI1cjkmwv9+vsTYcmWc5JPQLVEK3+LDT7RSiceRwSB/oi00+vZj9Y8?=
 =?us-ascii?Q?4AriwUTskANGwozQLuriQdeeUprVWlHsruyWiSGAKJCh/DYmv8AOAVBnSQq/?=
 =?us-ascii?Q?xD4QXvNYM+iJLHVzlCKjHIMVAOpfegc37rMfquwkD/AdCkJ8WQemfniTAykc?=
 =?us-ascii?Q?L2ve3ydTZVCFtakk/B4QN1ijaYCq1Wej2e23/Ol97Rs+H8kkJsPptf5iFJ2x?=
 =?us-ascii?Q?LNC2bWLfhuOsq1FXz+1pXUxY8JzVs/SzTr5p7aLdMd4Nzed6eZCksQgNb9xY?=
 =?us-ascii?Q?OpwsbZLgHQwzaPZvxT8VS+/+TyqkL/8mGS3ufIOfbRpdlYYnBaT1qNLKakVn?=
 =?us-ascii?Q?RU3W4fie0vEWIoXak+QJdZkwYYAv/5eaT6HCVxrT4rMth6l/iw74YAijCI2/?=
 =?us-ascii?Q?vIZozTNYbURHwdndDlrVbnLRbeXbpKnT07dxYMew2UWR5C9z4c55VW8taaRJ?=
 =?us-ascii?Q?gT70H98uw3fVDu3srEhs3y5WeB469MdskGznlPvuLtN1G6FFDlZh98gBCWa3?=
 =?us-ascii?Q?nGPuaUUlmIZ3mRvCmsLBuzzHQjzgJE5h4Q8Mf1mf4HHGuStehPKeWn7/pu9e?=
 =?us-ascii?Q?+FEobdV7cNF5051hrE44cQY8n4ibbzKJ+doBy7uuAF4oD2cOwm5TCFCviv9E?=
 =?us-ascii?Q?yWcRK2Q/oQ8WpjL6l42agDK8706Cir1QnijP2E7m5AMi3W3bejtg5C89Qd2c?=
 =?us-ascii?Q?gwoIPZLe8x62ZImuz+K763MxJkm6C9t3oOAhF9uoS/1YAEmGi2GMxzvbbMQA?=
 =?us-ascii?Q?N471umnGZbGkGSMLhyLGl4N8P5UMrROuFOwi1ZzM3Umuap53GUZ3ohidVAeP?=
 =?us-ascii?Q?mXB/xHjU9wnW54fpG+X/NfvnUg6uB/Az+ktFEGtcNOq965uYdNZVtlVuvw?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9db7dd-ab1c-4767-8415-08dbc8648245
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 01:10:21.0600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bpAIVb6hENOdIcvaWgXvh/KjeQXpTm6yddSfhVtrln1Dh97sviqSRhoyB//Yl9DZw6hJ2Nwem7QwN0NQKFsyeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5445
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, September 28, 2023 3:15 PM
>=20
> This extends IOMMU_HWPT_ALLOC to allocate domains used as parent
> (stage-2)
> in nested translation.
>=20
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
