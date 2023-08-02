Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E9A76C579
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 08:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjHBGok (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 02:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjHBGoi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 02:44:38 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9482102;
        Tue,  1 Aug 2023 23:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690958675; x=1722494675;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KMCEy203Brp4ofy7/xi1hDb7ePH/a6hKReJc7fCo1lE=;
  b=FIydU6DE3cwvH1iviMHyPrpYsQhcESHUP9wxt+DqA7o35TjTZtMSUKjH
   OS6par2o8pZGFFEyx8Z9cAnxCzSWiQNIxrH3u3n4mmuoeKksg9MKOJ+ny
   4V2QZjnH4T8PnlZTF3ho0CgKx02GqiWGlBUNfDfEZ8svUFSupnxUOnLQe
   jqmOgLTNbcUJnQ4UceyUPDwrJK/ihV7Uxsma5AMRID6IGMHoOmrOMIVn8
   /NwxvIWEztmtc2qYYkOR9AiIDeDw83SZbh+gs2WCYqvJUov6ialeyNHB1
   ysd8VUfE7onfIYIWK3pw1acvnrRnMXPjr9V2L1CZK87YAkA1KKtpK4RqY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="433337269"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="433337269"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 23:44:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="794468343"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="794468343"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 01 Aug 2023 23:44:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 23:44:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 23:44:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 23:44:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqN2de+1h3/f33CMqCFKDRCKiXvI2epRVCpwW7TQa9SAO3hx4HEbTZ5IFSGXws+tyyIgMFMn4zqHwavtpoomjn8s3V8qqhHgldZCVV2bRG7R38vDtQlNauIbpl0CIv7Bph1KBznbd+eZabCMGB4BPzPFYkvD/qt54EAHo0/r5WkpmDZFNRb31sKndhdn06y6nFk9JNg0tS6to8UiRrq59rBV6G2ArYlTV7M7/lfyFEIF6XM1tMCaz+ilfD3WYXByjigQogGcV32FuN5OBxcxDd0cPEDkjlOGmZjSFjxsFy1j6Qd0JZFU4aZCfXfQcXzAscGlmgN1oJvN1Ssq5N1qLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMCEy203Brp4ofy7/xi1hDb7ePH/a6hKReJc7fCo1lE=;
 b=VU+nAh+5McooY6i03+UGkl5x3Wy61mL0+qma/urrAHji+6/wfnxPJCYXmr5erbJ80W7eDxQbR0vmiPTAm2MT67KyCOzTcf15ndPtbg5PoJZ0BYLZ3fAx64OqhdA+QIysN5IIgYbcbIKeZOCOtQOwmgrQpcs+d6rbM93Ge3/bbTtn9p7O/Bapu2SAdlpsfMfm2a+om2Lgbe+uj4fBbsNx2iDH5DewVoCvyPjPU8VXHcDj+3plmLQl4QBzZ4qxqXecYA9Cg5AHqLgc3XzoMNYYi4d+J8OBmLp7ELM/v89c5lXSWYe8I9Shz79Lm4lzH82/gEsJu87OyFqSxnbVvFftAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB8465.namprd11.prod.outlook.com (2603:10b6:610:1bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:44:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 06:44:32 +0000
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
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v4 03/12] iommu/vt-d: Add helper for nested domain
 allocation
Thread-Topic: [PATCH v4 03/12] iommu/vt-d: Add helper for nested domain
 allocation
Thread-Index: AQHZvh/sLdr+TLi1E0yqYcTnM5QM2a/WnTuw
Date:   Wed, 2 Aug 2023 06:44:32 +0000
Message-ID: <BN9PR11MB52761A3129CDEDC27E1189218C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-4-yi.l.liu@intel.com>
In-Reply-To: <20230724111335.107427-4-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB8465:EE_
x-ms-office365-filtering-correlation-id: 7a1598d0-e4f8-4dc2-1968-08db9323ed8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FfRNTeDFHj/UyIYe3nMxdKzccCKXwSe4PXY01NSySbIDPhE2OR+UpSXy+t29JlSEHLa/HnLAUjDGTLocENWj/sPgSrMayEaCmwqlDx51WEa9nABW9e+x2I7z4za6AJgHWtXwvabQpt9kYnvnR7o12mqR8Rrt73rpU7ZldYhbmRJX2rwB33rpTt2bdpoavfZLRBSyi79SX/FGmKnxCYbyUfOSexXaxzreUXyEVd+loQjifgt1sL1dWqjKVPs8/GlroV2TQ/sh0MssdnE5cVeST4xV37EaFrysq3IM9JpOGF04TiyeHps6Wz4wP2bhlYoqcFTyvSg811w2bpPQjfeSrWeYsGmmhNrNucuhcjyiEdqR3Vku2BJIVMMIVRSue9uZysXbDUmOnztj251o5e3s+BVXc3L6/A/AaAWD2w5kPXSqpcSDByXAu+fyK6/8UvixQX970tdpEBBONY35ntjUODRebW2rknpzr6T8Sg1YZPeY1BnH9RayL4ydUoH0gST/chc5WcamNPyQg6UK57BRqPGmhlvqGWCW5ASW/CcXbLN47bGbz3rR/0yLfP5thrxfUCGGKMyeOatlC0WlJMuuYocHeu10qr5W06Kmg0Ounb08UkulscVqdjQxNTlRhseM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(66946007)(2906002)(76116006)(66446008)(64756008)(66476007)(4326008)(66556008)(7696005)(33656002)(71200400001)(86362001)(9686003)(558084003)(478600001)(186003)(82960400001)(38070700005)(26005)(6506007)(38100700002)(122000001)(110136005)(54906003)(55016003)(41300700001)(52536014)(8936002)(8676002)(5660300002)(7416002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E5DxttJY3DcEbEPzAi/1x0GDe/d0NmPCt/KDIvVGjo/FqiQDM/M83soXtXUl?=
 =?us-ascii?Q?9dc9bLTEFGTvmeHUbmUp+oL/Zi/3npgIvUCncv219dy7ogpzGRWGdPRuKH5l?=
 =?us-ascii?Q?dFo1CpvzVtOt0DTwZD3bQIpDMVIzKm51VtXcwQXoyTDdotp/rPrPNSe3MCfV?=
 =?us-ascii?Q?Q8a23cx5nBoyCrEG07V1NagRQS9lWxfsGx7Uijgfll8JRDW5H3H3wMzNuyGp?=
 =?us-ascii?Q?tOxB2IA4bpsz34F+aj04MWXAyUGTLRePAWXwSoICoV+nEbTS8cyWgxinM8BB?=
 =?us-ascii?Q?3l/qQqr/X/CyQ5sfTbeOl63/ag0TGzGKX1qcjS1WHJS7jzCLcsN7EYB3buC1?=
 =?us-ascii?Q?l/HCBxKujOyBll3vZv6/fii3zkxErhlPTYcENsnmS4RBQM7quDzl0XyV96og?=
 =?us-ascii?Q?AXJrVuI6S7USw1N4sVAkyzIKqvg352/16jQRktM1Z7UNDhWeds9ADVxti+dB?=
 =?us-ascii?Q?UrhYyE6164uEe7k4EVmPHjTsxiQJ/c5asc6MuBsJMOzK2XmHPeFrRVbfwCXg?=
 =?us-ascii?Q?bJqA9V5o4F/l3FUvoC/VrinXXsJUvk/wXJyRh770GKiUA38V2EXsnGPobM3E?=
 =?us-ascii?Q?oBaMa2JVRyOyu23JakIrZ+/pDMewSU4T93xUgV3WMY+csf7KF2yXhmrNxHfq?=
 =?us-ascii?Q?YY/jn00xf7i4Iycf7y2TlShTcuYawrKlp37Vx0DoP7OziW8tyxLTSJ5Q4yp1?=
 =?us-ascii?Q?tQQY+tNDGwMTbxNf4Yxv1knRVHscMA4LIEN4HumFsbOOKYwooihY2t9621HV?=
 =?us-ascii?Q?l4yjVOecr1tsuLr9XFOpkVekyyUBvhhR7mPw96dkycJ9HklWOUXNp/womn0c?=
 =?us-ascii?Q?X8XAP2IgDaIG5wJNY1IZ5iJqzQT6Pvl9lwGG3WjRIzHg7jJVJbP5rAbHAc/g?=
 =?us-ascii?Q?MnW/AH007PHORlwr5R3U2z5XonXMJX2gqxLFj4eG2zRtcF3wBGhJa0vasTd5?=
 =?us-ascii?Q?TLlFxDccUGeLdLF34KeA4Tik0zILtb1hEj3MOvmyg/HXJ3p54tUKlhdrFNYf?=
 =?us-ascii?Q?RfCOSmwmfaq4ytMWsJmnltB5fhLhw7w3HK10vz9JLMb7Lsdn4gWaCMiT2ZFV?=
 =?us-ascii?Q?NYGqZZCgRmMurPNgE89cdS9UYT3CHH0KeIltHHy0RQ/ivBzwTI4Y1QjNBPIt?=
 =?us-ascii?Q?+92knXMuzhoB4yKV4Q5tS0q2kvRBQGGDoBBPOHPxvoRfbrDDlyCun3koVMK+?=
 =?us-ascii?Q?tDknQ99sq4dRTNlqIv4fDZCS0zfdMW6CAwWq7tQFU7t04xrAafNYF2qv0+qK?=
 =?us-ascii?Q?f3wI18H4IKpMZoMO6g18wybh8tY4PkiDy02c/4IenCMCfFRF+sK1/XtW8F5n?=
 =?us-ascii?Q?opwwr6kc1ybsGtbCYNBuOKDyDbc6aCylubwUqD3+zLn6vhRh4/r6ezxGTJjY?=
 =?us-ascii?Q?eO83YKsPqGZ4t2t/NtV2xR8nwKZQI1QMK8hKwn8jPcccSLD0ADK33a8iLDCO?=
 =?us-ascii?Q?8p34W23jnsbKAGordOgteAUqLAGXgpc8X80894J+5S+qijCD0MqiDddfgVTs?=
 =?us-ascii?Q?EBdEwtu1SV95o0SDwUiUcJsKdCsmBCtwc1ayXh5IFgtthOvmIF03GA7O6oSr?=
 =?us-ascii?Q?PFb9tMU5RIIj21nJScrn5BPrJyqlobGF0DBNpKRy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1598d0-e4f8-4dc2-1968-08db9323ed8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 06:44:32.1100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PRTOmmq4RUmNKayfVta0xSXmC5UDbP37X/3xo1iN2Y36VQ5WXqUYoEUsUlSL//qhMcUIYwteeuZhp78bg/+Wsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8465
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Monday, July 24, 2023 7:13 PM
>=20
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> This adds helper for accepting user parameters and allocate a nested
> domain.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
