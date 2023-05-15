Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E7B702440
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 08:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbjEOGPB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 02:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238267AbjEOGOp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 02:14:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C97099;
        Sun, 14 May 2023 23:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684131284; x=1715667284;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gpWKo+TJnH5xCMDH+u8DBX2PJ/t7iJyjxTUwrgaKfDk=;
  b=QY5m9M1rRSgQtD/ArD+MmZ3m1y8ay+ddL2XpUx9eP6NtIZmf6JC0qCwa
   QQxEvgnNRpQmZ9irQV4Y//pKvcRwSWOkQdtZX4yK2qLTToaf0ZKYzWBkP
   4Z49E8+QrAsVHPqGvsS3e2/00vEJV1Or7XEVWlqxXu4iAi/owRbGcJRzM
   9AdirX/znP1vPBJogneuXmhpfS+UbBqnTs8SGAyTdc0bIJPntLaKILl/0
   DPe1QDNBac9nV6W1f384MiyoihJ97NqN5M6ciG4ZW1NAm1+cRNzKaKP8H
   OvRgGr6gnDxehcUR1sSsmSovWC7f6G7HOchXMIMrfEnBNzuLRJvUKBMX6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="330738417"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="330738417"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:14:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="825049669"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="825049669"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 14 May 2023 23:14:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 14 May 2023 23:14:32 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 14 May 2023 23:14:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 14 May 2023 23:14:31 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 14 May 2023 23:14:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWenrwxpZNdvzfkX90taeRvcm0LuZ/G94/t2U+YHer0JQns4Rpx7By1ucNehEbKZ4r3QKeqAOYyqfVsMV++MmINSNrs9nyDswYRQ1WVwSWQdYJuJSrHMB1X/KLPEMgQGaJDPZNZ+bv5cCxTn83PODv/hYgulptNospHEmcuNr84ocVUjFxVh25YYejiM8qh6ZaPEk5Gxxf+ZMTgcz+/ybneJdpje2I+svVkU4Sb7wW4K9iklPpwiuinw3JbEM1zPLcPWetqyyk3qlKxc4FgZ2y2wc/L90wGeqjbROuAa8o1itz9d0+43hvu9S+RDECvHyRNCqVnEsZgS1sc6rQKhCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpWKo+TJnH5xCMDH+u8DBX2PJ/t7iJyjxTUwrgaKfDk=;
 b=XF/pB1drdVA033OuzRsmcAybXGD0EOvep6doV1yDw8ifVHyNkNWKTwyqnEE0sAbgSPLANXvpGdi0+CdvZKHOR3MJgfR+Ov9N+paWVT+ILI+OwkQqggVw4cNsGj0je9gwzilvHAS5CTfEIQYe+qC1NK9fEePLN/NuNFO+/cqQrsypaAbknarLsRqL5hWk79NqbRptGj9t5t3BGsEweAzemRCKHljszCVDg5NrHVhhPKbK6EnGNf2vvMuQGr6kLey+XPA8jBgIw/kl8Eiilb5wmrJRENRwpRaveOprr/autAvFOiD9/ncSE6diX8wQudjy0Djt9LDguaV7B9H/UiFl4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA2PR11MB4828.namprd11.prod.outlook.com (2603:10b6:806:110::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 06:14:29 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::5b44:8f52:dbeb:18e5]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::5b44:8f52:dbeb:18e5%3]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 06:14:29 +0000
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v3 3/4] iommufd: Add IOMMU_DEVICE_GET_HW_INFO
Thread-Topic: [PATCH v3 3/4] iommufd: Add IOMMU_DEVICE_GET_HW_INFO
Thread-Index: AQHZhBUv/QZm3TE7k0ulJ8YTBH4NW69WH82AgATASNA=
Date:   Mon, 15 May 2023 06:14:29 +0000
Message-ID: <DS0PR11MB752940450312B2E0529C3DC6C3789@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230511143024.19542-1-yi.l.liu@intel.com>
 <20230511143024.19542-4-yi.l.liu@intel.com>
 <6ab2d63e-4dcc-6562-9698-d23300c7d1ae@linux.intel.com>
In-Reply-To: <6ab2d63e-4dcc-6562-9698-d23300c7d1ae@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|SA2PR11MB4828:EE_
x-ms-office365-filtering-correlation-id: bb3f60a0-5d93-4fad-6811-08db550ba444
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ejnhuxp2V4gbkJpe3LjJ/zXeOLFnYC7dU32eB+EF0uOTfkR4zlwL+yy9aICsMmp966MG8+qZwit3I8nPRBf2IEkGZatFktB8fdBKGKrxXXbu3igjDsu5+Ylgam1aKO/PyuiIItQxNCw20E4/cjAPrN8HIfvsyQSMGOZDK8c2G+GQKG1J33bMJLaVQZQ+UZSdQhdwsvGWZvT+ptByzTdJz5HibBtnoTBns112J5eB08iMME3Wjh8/LxZvkoP7c5XptZXR7vN43aWJF//ZuHBPY+Cr5cEBDanAzoylN6fEmClAEujQLY97FTJ3kzeg27Cly9I0zT0yCAIh3Zd2wzPS5ig84g4on3s5ZMw4/WJ/sVMfXr7wyDAsNM0JMobG4S+fTYvutGUeie5seGv71wZzVn1EQn93hK4+HF/D//BFKH43fKOjElYkeU1ki3co+V7Y0QY8T7nW2HokBtBKM/2iATcNL9XBRfTpla/symW3ID21D0gzZI+1yRc4qOLAlaF7EVfyf20TfXId4cwW2QkBTJpsisDm563LYjm2yklgAu1k4FYwvU5YAzSZcbBiZMGvT4zpMHQ67T+8aQbewPjXDZlXOTB27sskk5LGkWZfuak=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(966005)(76116006)(66556008)(66446008)(64756008)(66946007)(66476007)(4326008)(478600001)(7696005)(86362001)(316002)(54906003)(110136005)(33656002)(71200400001)(83380400001)(186003)(53546011)(9686003)(6506007)(41300700001)(52536014)(8936002)(8676002)(5660300002)(7416002)(2906002)(55016003)(82960400001)(122000001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDVKTXF1WEdRVmpmekNJRVFhN05mUmtTUXhsMnRuc1pWU1hWNCtPNVovaHFG?=
 =?utf-8?B?cEdmaVphcXc2cDN2MDR0ODd2NDVEK0NLOXdaVmxjWS9tVi9nc21CMVdJUmt4?=
 =?utf-8?B?eWhEd3pMU005Zi9WZEd4TkltbGFtZkw2VHh3OUNlZ082N3lJekhHYWxwSGlG?=
 =?utf-8?B?MmxYbW4rdHAySVFFNy9PR1ZzQ0RrNkFkQjgzWDhickxiSTFsT2lrVVNPMzcv?=
 =?utf-8?B?WWtsazg2eUEwcDRzam5oVzlVZUVvUnh1Y25EeWNTTy81UDN1OFZtMTdZekFG?=
 =?utf-8?B?SExleTRZTEJPZzVrU2xzYXlhZnRiREhQRVcrUUU4VzdXajlQZWFrS1hQZkFz?=
 =?utf-8?B?Mkc2NVhDMHFDTmpEWnJQWVJHcStJWGNtWTQzaGhmNnpQRVZMVmY2Wi84N05o?=
 =?utf-8?B?K2p5c0hXb2o5SHdaUi96K3VYM05kcnNxN1NWWkY3RlUyM3czTkNYK1lGK2Q5?=
 =?utf-8?B?b2UwbEl1eTVScGkxbnE3R2FkRmk5c3RYaWs3UmhTUUlEM2Z6N2lKRFFmU1Bp?=
 =?utf-8?B?Nmo0R1hINnZvalZiVzB4Y1FsQXFjUzNSUzZndFlvbW0zNFZCSmdnT2JPNThN?=
 =?utf-8?B?bUlsTkQweGxMdjV1ekdlTmFWaFFXWmxyMDV1K09CcTZjZitZVlcxc1dVRDZ5?=
 =?utf-8?B?TkRGRzVuSlpuOVFXWUdNSlVsN2ZyUjJ5ZWEwN05mZDF2R0x1TXZQOUJIdXd6?=
 =?utf-8?B?ajVpT0Fiam5NcmhiZDBNNW1kaXRnZnNKTDlURWN4Ly95MmQyaWhrVTJLd2g2?=
 =?utf-8?B?TkNNc05zRFBYaEZqaDhtMkpXQm5LRmRWTmlFclB2aXR5RTEwRFhpZTFRZDha?=
 =?utf-8?B?Z1JqLzJvRHQwUUdxSzdKQ3pTK2NWVGsrdmtoSzBlMkJ2dDRKTUc2bmY4cGk2?=
 =?utf-8?B?M1MxZ04vNzQyNUVubFpyNER4UTZ2SklhY1pOdVlYUVJDNkhjQWhqRnQrNEF4?=
 =?utf-8?B?cUdEVlBWZkMwMnQyU2kvS2xtR3BDcmtqUUliRHpwbG5GeDFvemdaQkQ3ZEFQ?=
 =?utf-8?B?NE1LZVRGMG9FVmtKYTRGSDBmTmxZMERQM3gxKzdmZ0ZEYjg3eGE1WFlxWS9x?=
 =?utf-8?B?d2p4c004ZmFwTUJ2ZVZPRjRMS2R4U1I1Z1FVSkdUdlJHRW5STWxVMGk5ZVpo?=
 =?utf-8?B?Z0JNUS9yUkpSbG1CcmpPaTdMNmZRbUNjWkZVR2p6aUo2bGh5Ni9JdkxVM3hP?=
 =?utf-8?B?T0lWQ3BDcjFaSERzR0h6amdNODBaR2dIYnltQnRJcEIvNUZqNlJYT0lTREFS?=
 =?utf-8?B?cmdBN05samtJcFpkNlJnQmVuem5sQ3luVmdzWmdYd0gzYWpXRDVDUHR0RUpl?=
 =?utf-8?B?TVdjQ0pXYVZRN2hIRXlyZ2JPbktkRDREdGFLd0dGNitCTnJad1FBeXU0bWRK?=
 =?utf-8?B?Yk8wZ2kvLzU5ZktuZ0lTb3g3Z3BKK1FNNkZjQjk1SEkyT01ERThCSVlTVHdX?=
 =?utf-8?B?emt0U0FINHpPbkJRS2NwRVNwUnpXaHVKYmYvTUgvRnJuZ2x3aEM0L3o0UExC?=
 =?utf-8?B?QXA2YnQrR0dxbjUwSWJBVW1pR2dJWnlYd2FmZjVqckltM1YyL2xNSUZ4aWNq?=
 =?utf-8?B?RnJtVkNEaWp4YkhSL2ZZaWQ3eTltaERxQmhBVGo3QVUxWU1QZWNZKy9CL0Vz?=
 =?utf-8?B?c0NpWllIUGF2SnFla1B3bWxrakRNOEV6ZnprTExiQXFnRmlMbU5WdWVucFAy?=
 =?utf-8?B?VUZId3hLNUNxMmQ4ZnVaUHFUVERWak9SSlRNNUFzWjVZN3BMYXAyenN2aHpT?=
 =?utf-8?B?KytvenhMVk9TTUVBc1NTQ0JPL3BhUEtrZzBtM1ordHRCK0hWSnlRZEtTbFZy?=
 =?utf-8?B?Q3kvdHNXdmxaL2pFeTBjWmkzTTF1MVNzOCt0L0hHNk85M3NmTlFoZXhmcVp6?=
 =?utf-8?B?OFpMMHRndEdCV2hVaWpQOGg2WVMyOVFuVVNqQ2c5MTI3V2pDMmhQVFlBMmk3?=
 =?utf-8?B?cVMvYkU4NzBOU2wxdHYxVEloeXNKVnc5U0hDdVFBYjRZQkU1VkJ2WnZvcmRL?=
 =?utf-8?B?R2FNVVFDbkV5bjQxS1dHdGExZjUzS1hzTHdROEhubm5zUGY0WitjTnFtQ0lw?=
 =?utf-8?B?a2J6L2tjcHhIMEZNR2l2QVU1VWttSWNyZGowQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3f60a0-5d93-4fad-6811-08db550ba444
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 06:14:29.1853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n4ScVX409g+rXz4LchJImUM+vCSRpX5nDsll7c/haDXBFRVrof/TwBJHiRRLHaCTZAvE5ubygie/SraT0HZFVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4828
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFvbHUgTHUgPGJhb2x1
Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXkgMTIsIDIwMjMgMTozOSBQ
TQ0KPiBUbzogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+OyBqb3JvQDhieXRlcy5vcmc7
IGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tOw0KPiBqZ2dAbnZpZGlhLmNvbTsgVGlhbiwgS2V2
aW4gPGtldmluLnRpYW5AaW50ZWwuY29tPjsgcm9iaW4ubXVycGh5QGFybS5jb20NCj4gQ2M6IGJh
b2x1Lmx1QGxpbnV4LmludGVsLmNvbTsgY29odWNrQHJlZGhhdC5jb207IGVyaWMuYXVnZXJAcmVk
aGF0LmNvbTsNCj4gbmljb2xpbmNAbnZpZGlhLmNvbTsga3ZtQHZnZXIua2VybmVsLm9yZzsgbWpy
b3NhdG9AbGludXguaWJtLmNvbTsNCj4gY2hhby5wLnBlbmdAbGludXguaW50ZWwuY29tOyB5aS55
LnN1bkBsaW51eC5pbnRlbC5jb207IHBldGVyeEByZWRoYXQuY29tOw0KPiBqYXNvd2FuZ0ByZWRo
YXQuY29tOyBzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb207IGx1bHVAcmVkaGF0
LmNvbTsNCj4gc3VyYXZlZS5zdXRoaWt1bHBhbml0QGFtZC5jb207IGlvbW11QGxpc3RzLmxpbnV4
LmRldjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta3NlbGZ0ZXN0QHZn
ZXIua2VybmVsLm9yZzsgRHVhbiwgWmhlbnpob25nIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMy80XSBpb21tdWZkOiBBZGQgSU9NTVVfREVWSUNF
X0dFVF9IV19JTkZPDQo+IA0KPiBPbiA1LzExLzIzIDEwOjMwIFBNLCBZaSBMaXUgd3JvdGU6DQo+
ID4gVW5kZXIgbmVzdGVkIElPTU1VIHRyYW5zbGF0aW9uLCB1c2Vyc3BhY2Ugb3ducyB0aGUgc3Rh
Z2UtMSB0cmFuc2xhdGlvbg0KPiA+IHRhYmxlIChlLmcuIHRoZSBzdGFnZS0xIHBhZ2UgdGFibGUg
b2YgSW50ZWwgVlQtZCBvciB0aGUgY29udGV4dCB0YWJsZQ0KPiA+IG9mIEFSTSBTTU1VdjMsIGFu
ZCBldGMuKS4gU3RhZ2UtMSB0cmFuc2xhdGlvbiB0YWJsZXMgYXJlIHZlbmRvciBzcGVjaWZpYywN
Cj4gPiBhbmQgbmVlZHMgdG8gYmUgY29tcGF0aWFibGUgd2l0aCB0aGUgdW5kZXJseWluZyBJT01N
VSBoYXJkd2FyZS4gSGVuY2UsDQo+ID4gdXNlcnNwYWNlIHNob3VsZCBrbm93IHRoZSBJT01NVSBo
YXJkd2FyZSBjYXBhYmlsaXR5IGJlZm9yZSBjcmVhdGluZyBhbmQNCj4gPiBjb25maWd1cmluZyB0
aGUgc3RhZ2UtMSB0cmFuc2xhdGlvbiB0YWJsZSB0byBrZXJuZWwuDQo+ID4NCj4gPiBUaGlzIGFk
ZHMgSU9NTVVfREVWSUNFX0dFVF9IV19JTkZPIHRvIHF1ZXJ5IHRoZSBJT01NVSBoYXJkd2FyZQ0K
PiBpbmZvcm1hdGlvbg0KPiA+IGZvciBhIGdpdmVuIGRldmljZS4gVGhlIHJldHVybmVkIGRhdGEg
aXMgdmVuZG9yIHNwZWNpZmljLCB1c2Vyc3BhY2UgbmVlZHMNCj4gPiB0byBkZWNvZGUgaXQgd2l0
aCB0aGUgc3RydWN0dXJlIG1hcHBlZCBieSB0aGUgQG91dF9kYXRhX3R5cGUgZmllbGQuDQo+ID4N
Cj4gPiBBcyBvbmx5IHBoeXNpY2FsIGRldmljZXMgaGF2ZSBJT01NVSBoYXJkd2FyZSwgc28gdGhp
cyB3aWxsIHJldHVybiBlcnJvcg0KPiA+IGlmIHRoZSBnaXZlbiBkZXZpY2UgaXMgbm90IGEgcGh5
c2ljYWwgZGV2aWNlLg0KPiA+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBOaWNvbGluIENoZW4gPG5p
Y29saW5jQG52aWRpYS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmljb2xpbiBDaGVuIDxuaWNv
bGluY0BudmlkaWEuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50
ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9pb21tdS9pb21tdWZkL2RldmljZS5jICAg
ICAgICAgIHwgNzIgKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgZHJpdmVycy9pb21t
dS9pb21tdWZkL2lvbW11ZmRfcHJpdmF0ZS5oIHwgIDEgKw0KPiA+ICAgZHJpdmVycy9pb21tdS9p
b21tdWZkL21haW4uYyAgICAgICAgICAgIHwgIDMgKysNCj4gPiAgIGluY2x1ZGUvdWFwaS9saW51
eC9pb21tdWZkLmggICAgICAgICAgICB8IDM3ICsrKysrKysrKysrKysNCj4gPiAgIDQgZmlsZXMg
Y2hhbmdlZCwgMTEzIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2lvbW11L2lvbW11ZmQvZGV2aWNlLmMgYi9kcml2ZXJzL2lvbW11L2lvbW11ZmQvZGV2aWNlLmMN
Cj4gPiBpbmRleCAwNTFiZDhlOTk4NTguLmJjOTlkMDkyZGU4ZiAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2lvbW11L2lvbW11ZmQvZGV2aWNlLmMNCj4gPiArKysgYi9kcml2ZXJzL2lvbW11L2lv
bW11ZmQvZGV2aWNlLmMNCj4gPiBAQCAtMjYzLDYgKzI2Myw3OCBAQCB1MzIgaW9tbXVmZF9kZXZp
Y2VfdG9faWQoc3RydWN0IGlvbW11ZmRfZGV2aWNlICppZGV2KQ0KPiA+ICAgfQ0KPiA+ICAgRVhQ
T1JUX1NZTUJPTF9OU19HUEwoaW9tbXVmZF9kZXZpY2VfdG9faWQsIElPTU1VRkQpOw0KPiA+DQo+
ID4gK3N0YXRpYyBpbnQgaW9tbXVmZF96ZXJvX2ZpbGxfdXNlcih1NjQgcHRyLCBpbnQgYnl0ZXMp
DQo+ID4gK3sNCj4gPiArCWludCBpbmRleCA9IDA7DQo+ID4gKw0KPiA+ICsJZm9yICg7IGluZGV4
IDwgYnl0ZXM7IGluZGV4KyspIHsNCj4gPiArCQlpZiAocHV0X3VzZXIoMCwgKHVpbnQ4X3QgX191
c2VyICopdTY0X3RvX3VzZXJfcHRyKHB0ciArIGluZGV4KSkpDQo+ID4gKwkJCXJldHVybiAtRUZB
VUxUOw0KPiA+ICsJfQ0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK2ludCBp
b21tdWZkX2RldmljZV9nZXRfaHdfaW5mbyhzdHJ1Y3QgaW9tbXVmZF91Y21kICp1Y21kKQ0KPiA+
ICt7DQo+ID4gKwlzdHJ1Y3QgaW9tbXVfaHdfaW5mbyAqY21kID0gdWNtZC0+Y21kOw0KPiA+ICsJ
dW5zaWduZWQgaW50IGxlbmd0aCA9IDAsIGRhdGFfbGVuOw0KPiA+ICsJc3RydWN0IGlvbW11ZmRf
ZGV2aWNlICppZGV2Ow0KPiA+ICsJY29uc3Qgc3RydWN0IGlvbW11X29wcyAqb3BzOw0KPiA+ICsJ
dm9pZCAqZGF0YSA9IE5VTEw7DQo+ID4gKwlpbnQgcmMgPSAwOw0KPiA+ICsNCj4gPiArCWlmIChj
bWQtPmZsYWdzIHx8IGNtZC0+X19yZXNlcnZlZCB8fCAhY21kLT5kYXRhX2xlbikNCj4gPiArCQly
ZXR1cm4gLUVPUE5PVFNVUFA7DQo+ID4gKw0KPiA+ICsJaWRldiA9IGlvbW11ZmRfZ2V0X2Rldmlj
ZSh1Y21kLCBjbWQtPmRldl9pZCk7DQo+ID4gKwlpZiAoSVNfRVJSKGlkZXYpKQ0KPiA+ICsJCXJl
dHVybiBQVFJfRVJSKGlkZXYpOw0KPiA+ICsNCj4gPiArCW9wcyA9IGRldl9pb21tdV9vcHMoaWRl
di0+ZGV2KTsNCj4gPiArCWlmICghb3BzLT5od19pbmZvKQ0KPiA+ICsJCWdvdG8gZG9uZTsNCj4g
DQo+IElmIHRoZSBpb21tdSBkcml2ZXIgZG9lc24ndCBwcm92aWRlIGEgaHdfaW5mbyBjYWxsYmFj
aywgaXQgc3RpbGwNCj4gcmV0dXJucyBzdWNjZXNzPw0KDQpZZXMsIGFzIG5vdGVkIGluIHRoZSBj
b3ZlciBsZXR0ZXIuIEl0J3MgZm9yIGEgcmVtYXJrIGZyb20gSmFzb24uIEluIHN1Y2gNCmNhc2Us
IHRoZSBvdXRfZGF0YV90eXBlIGlzIE5VTEwsIGl0IG1lYW5zIG5vIHNwZWNpZmljIGRhdGEgaXMg
ZmlsbGVkDQppbiB0aGUgYnVmZmVyIHBvaW50ZWQgYnkgY21kLT5kYXRhX3B0ci4NCg0KLSBMZXQg
SU9NTVVfREVWSUNFX0dFVF9IV19JTkZPIHN1Y2NlZWQgZXZlbiB0aGUgdW5kZXJseWluZyBpb21t
dSBkcml2ZXINCiAgIGRvZXMgbm90IGhhdmUgZHJpdmVyLXNwZWNpZmljIGRhdGEgdG8gcmVwb3J0
IHBlciBiZWxvdyByZW1hcmsuDQogICBodHRwczovL2xvcmUua2VybmVsLm9yZy9rdm0vWkFjd0pT
SyUyRjlVVkk5TFh1QG52aWRpYS5jb20vDQoNClJlZ2FyZHMsDQpZaSBMaXUNCg0KPiA+ICsNCj4g
PiArCS8qIGRyaXZlciBoYXMgaHdfaW5mbyBjYWxsYmFjayBzaG91bGQgaGF2ZSBhIHVuaXF1ZSBo
d19pbmZvX3R5cGUgKi8NCj4gPiArCWlmIChvcHMtPmh3X2luZm9fdHlwZSA9PSBJT01NVV9IV19J
TkZPX1RZUEVfTk9ORSkgew0KPiA+ICsJCXByX3dhcm5fcmF0ZWxpbWl0ZWQoImlvbW11IGRyaXZl
ciBzZXQgYW4gaW52YWxpZCB0eXBlXG4iKTsNCj4gPiArCQlyYyA9IC1FTk9ERVY7DQo+ID4gKwkJ
Z290byBvdXRfZXJyOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWRhdGEgPSBvcHMtPmh3X2luZm8o
aWRldi0+ZGV2LCAmZGF0YV9sZW4pOw0KPiA+ICsJaWYgKElTX0VSUihkYXRhKSkgew0KPiA+ICsJ
CXJjID0gUFRSX0VSUihkYXRhKTsNCj4gPiArCQlnb3RvIG91dF9lcnI7DQo+ID4gKwl9DQo+ID4g
Kw0KPiA+ICsJbGVuZ3RoID0gbWluKGNtZC0+ZGF0YV9sZW4sIGRhdGFfbGVuKTsNCj4gPiArCWlm
IChjb3B5X3RvX3VzZXIodTY0X3RvX3VzZXJfcHRyKGNtZC0+ZGF0YV9wdHIpLCBkYXRhLCBsZW5n
dGgpKSB7DQo+ID4gKwkJcmMgPSAtRUZBVUxUOw0KPiA+ICsJCWdvdG8gb3V0X2VycjsNCj4gPiAr
CX0NCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJICogWmVybyB0aGUgdHJhaWxpbmcgYnl0ZXMgaWYg
dGhlIHVzZXIgYnVmZmVyIGlzIGJpZ2dlciB0aGFuIHRoZQ0KPiA+ICsJICogZGF0YSBzaXplIGtl
cm5lbCBhY3R1YWxseSBoYXMuDQo+ID4gKwkgKi8NCj4gPiArCWlmIChsZW5ndGggPCBjbWQtPmRh
dGFfbGVuKSB7DQo+ID4gKwkJcmMgPSBpb21tdWZkX3plcm9fZmlsbF91c2VyKGNtZC0+ZGF0YV9w
dHIgKyBsZW5ndGgsDQo+ID4gKwkJCQkJICAgIGNtZC0+ZGF0YV9sZW4gLSBsZW5ndGgpOw0KPiA+
ICsJCWlmIChyYykNCj4gPiArCQkJZ290byBvdXRfZXJyOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAr
ZG9uZToNCj4gPiArCWNtZC0+ZGF0YV9sZW4gPSBsZW5ndGg7DQo+ID4gKwljbWQtPm91dF9kYXRh
X3R5cGUgPSBvcHMtPmh3X2luZm9fdHlwZTsNCj4gPiArCXJjID0gaW9tbXVmZF91Y21kX3Jlc3Bv
bmQodWNtZCwgc2l6ZW9mKCpjbWQpKTsNCj4gPiArDQo+ID4gK291dF9lcnI6DQo+ID4gKwlrZnJl
ZShkYXRhKTsNCj4gPiArCWlvbW11ZmRfcHV0X29iamVjdCgmaWRldi0+b2JqKTsNCj4gPiArCXJl
dHVybiByYzsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgIHN0YXRpYyBpbnQgaW9tbXVmZF9ncm91cF9z
ZXR1cF9tc2koc3RydWN0IGlvbW11ZmRfZ3JvdXAgKmlncm91cCwNCj4gPiAgIAkJCQkgICBzdHJ1
Y3QgaW9tbXVmZF9od19wYWdldGFibGUgKmh3cHQpDQo+ID4gICB7DQo+IA0KPiBCZXN0IHJlZ2Fy
ZHMsDQo+IGJhb2x1DQo=
