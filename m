Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1384F7BD1B2
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 03:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjJIBNF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Oct 2023 21:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjJIBNE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Oct 2023 21:13:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E89FAC;
        Sun,  8 Oct 2023 18:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696813980; x=1728349980;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v4a+F6AtyIDsVAaEaH18oQmTESWgk5FYlZ0SYiIFJX8=;
  b=XdW0Z4jjYEW4pvTs82iZPeXm/7AON233+7JBRMRlwJTCMiNqk++BYJRP
   +tKbup5V3YjmJxt7gaIkpFBLCE66zi8OvTiPY7vZPYahcmz7xbv9SJRw7
   JM3BV8nQsyYStY2gclkCHNX/BtRqI25zUA9rTS/03RbBSQoEAVMn1i2t9
   JuJ40G9Xf03TDO+1SSd3vdauxn24ef/cw3VufPfMVhHI1hiZ4t9JEb77N
   dvutXiGrvJeslQXD+A/0XhL+H3dYMuYL6LfOitpDPXyYrGBbSw68bsLJH
   IgQbSR9+WDcMmxOnIGqSe4mcqJZvjc9ChJJrNFnkfPS082Jm6oV+fEVbF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="386885779"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="386885779"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 18:12:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="818665778"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="818665778"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2023 18:12:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 18:12:59 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 18:12:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 8 Oct 2023 18:12:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 8 Oct 2023 18:12:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6YSBrGHSTKkJpQWluq/brSdX/wXxHZNoA9bn82YSNfZnqKVcAqyZm05A337+CAbuQLwFiVqbLB2DmycLSUxwaLbK71eASm1vPPggmFWkCcRsmjovCCZ3vQ5rooJmY5oQSfASTPDBN79lSDe23nbV0jQYmrGXcBksU+GkveVsiNGL+xo+Pjq1MCQgtRrQDxcLm8ROXosQJUE40RZtSjG1LCDjO4OMN8dksd04BHhma+F+lMbO3nhw2lyR3tIBEqPiMnLAhMcbO4jRfRwYFlRLVLCXw9gB2uWeKFA/chxFpDf+b609vMBswl3CR/EBO1QOAZ+bBeYNHlibAEH7SdPtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4a+F6AtyIDsVAaEaH18oQmTESWgk5FYlZ0SYiIFJX8=;
 b=I7HB/00RV1wT35hFKwWlZXRyHTB6q+BtnnMZkxwZUI0AOUv04VRqY7T/0fjbHcor7KsbpCInjWL2MylZ4RuwefDT/20EQ0J0bRS/REF2hcxlB/9t8WheZfWOdE820ukErhnDKMaq/XwGdOjcom7eyr3f2ifkJlGmLkSP1wRcDVpfqEuahHoC/GzjkzltxglWOIqBYW/hszB/Q8GX6Qq1BsSc71kTSo2Krv6V9+FF3A1MN3473PcLu0OUFs1Rmblq3lKpom2Cxn3APtz2MwlYJ5Pielt5SHMwCb1o54jbyabISQaU1doE+an/bsIX1irXWvN6mD6Mqr8tKvdwZmEOBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Mon, 9 Oct
 2023 01:12:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4%3]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 01:12:54 +0000
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
Subject: RE: [PATCH v2 5/6] iommufd/selftest: Add domain_alloc_user() support
 in iommu mock
Thread-Topic: [PATCH v2 5/6] iommufd/selftest: Add domain_alloc_user() support
 in iommu mock
Thread-Index: AQHZ8duZh4gHOz/+ukWgqHcQC6sl4LBAt57Q
Date:   Mon, 9 Oct 2023 01:12:54 +0000
Message-ID: <BN9PR11MB5276DDDEEED3BEFB4810C8DD8CCEA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230928071528.26258-1-yi.l.liu@intel.com>
 <20230928071528.26258-6-yi.l.liu@intel.com>
In-Reply-To: <20230928071528.26258-6-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8278:EE_
x-ms-office365-filtering-correlation-id: 48826a7a-a005-41cf-aa4b-08dbc864dd78
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lkishh/UfVbjtCDiMq21NZ4TcY+8W2A4X2QVwyq+lXzHoTHv30So8nMh5iunpHBz2FfHUVnXpB6I2zQ/iRcVV9j54hMsVJwkyGIfOfcC1gyNJ6XEyMZnwx7KwTUALcB0njCoPUJ34/l/Cde2uu99inG71JBQKoGDMkSMTOdfUpaoXaQPb6Q5zfQbXU4TWurGaWqpaqkcDYm7+PIqppOtVnLeT4Xs9JNCCi4pl+Syq5p3cfSGzJ2sxrE3FWdzCVs1HY3FpeUWGxviWVIhP4skESNqTfVWnvAIg/0oMgF1yX/Eecplr59zdw8oQTgLogBHb07e6NtKXN8eEdE59K0rYF7y2EULNsZAm6uik/pH0p3RQjtdDpcG4mYduTrsdAXHUUb0ELpTwMupsmMJDih5lR4l98eTEqqugYnjLzBQH85Qhksl6sLaTqu8aNNoBjrOxLdixGZ3+f6y/Ojn/rhr7wN7unCQqOMqmHBgJBVbAFQ09/HENH4a04lrVtjc0sFw3XavYNsq3FOjtHpHUp53S/AYjBm/NQSUe1u7vPL2AeqIeHluWHgEyd+uP9/E1INn6/DkqF8qAsZhpvlc9rTxdJcT9SslY9BKLQAv95U3B4hA11dfU9cZJVxD6exO991p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(136003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(55016003)(66946007)(26005)(316002)(66476007)(66556008)(110136005)(66446008)(54906003)(76116006)(7416002)(64756008)(8936002)(8676002)(4326008)(5660300002)(52536014)(41300700001)(7696005)(6506007)(71200400001)(9686003)(2906002)(478600001)(558084003)(33656002)(38070700005)(38100700002)(82960400001)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O/WVQ4YnIa+rhd/Y+0S4h4UofWGhwU6gtCgh0N3WLRD8aWWgiaFkQ7O2YCx7?=
 =?us-ascii?Q?lgqeUWoslkOExlG/g3zMfBMRi5oalaErHci4zlBC8ffYBjsaDfxBQLf2sup/?=
 =?us-ascii?Q?zWpvjVSwkXvaMU+p02hUACOPsRx+Fb4d6NUPZK+ajo0p+C/GgemjavqRKLQB?=
 =?us-ascii?Q?oQ462QRIPsB3fPMPiD8cwR91mvQKc9sIzMZW72yqUYCm/zm+ztueyXAXSs2i?=
 =?us-ascii?Q?u8dqyzEkj/Q0ZIljeEVo0OvmDbShhFzyTIbpakzzZP9WsirhH54njQ+PKvT8?=
 =?us-ascii?Q?3T4VHuWSREVnO3t4tmaK0ROSPcqZxP8/2/12h4LS/ebUnPeoOU64JX5mb02T?=
 =?us-ascii?Q?7wXBlccnuQg90gK5ZoyKx6ib4mCC9WVnKIzd5Ig7hH/O02eNngUfgPRt8TPX?=
 =?us-ascii?Q?fos0sjA9Vb0t53/RSSn4bMVV4lD9rGkNSvBL43iV0UGkqPdhlLc7JTAt9qTA?=
 =?us-ascii?Q?h20QvROlfWa7UffXvL5SgSYu0dIDValfyAtdnimix0lv9cJa0UsH7WiokO3A?=
 =?us-ascii?Q?QaW1pv8WcNnQQt7URZtjV4HtcET6v3ngGk+0Dptn5IxaIUYxtvGqdzDpMY5w?=
 =?us-ascii?Q?Tfdx68EuQ+/JXr9lVMMPjCSOb9Izm/Z+417rc2h5AfOUn9J1mNNaF2gFrmEI?=
 =?us-ascii?Q?MXoyeaRy0RmG/MipW1kCQZnI0kh4XKuWW4YP2aG4bHUFO+Ug101HSgeQhB9A?=
 =?us-ascii?Q?omHQz74kuZcXAY/Y/D4PZKMkjAQQOWVxxNV703yc1rnFgQEHAmlzGxXCdH9S?=
 =?us-ascii?Q?f6Q0i5ie9GOHX4EbG33ZN+cdxAx2g39yr8Ap4KSXeMVG01kfpdF4cO0WB8HY?=
 =?us-ascii?Q?DAG/uzugaVmTF0hUZxwz6yX4PMKvcbWsyN+/wi8JKfusFZCqiBLNnr8IsnYe?=
 =?us-ascii?Q?z5ZGOKWLmvirxJJyjjGUKwzwXW0qorNJyLfq2pxLSkOTQhBSnP+VdwQDyK1B?=
 =?us-ascii?Q?juqd+4xCv5t4ge7lhah8jl5APx+3fclyrU+hKEFQnhf+IzgRr6IZDia3xyWx?=
 =?us-ascii?Q?IlLq1Jv7rmPnd96i0zl0FmBPGJ9sjTh6q1ScAL6/0dsbnDWJgBszJz/r34C6?=
 =?us-ascii?Q?n2zYzYBFSeiKeUgO/nqE73CbdUz0XJRsT9ZC3qQk1civy3jrlhGwUjrncIne?=
 =?us-ascii?Q?m+mtfMXisddHMtN7h96EAEOMTZq9W33hlMHUi4TJmPgRIqNdizW/AwEyVIzp?=
 =?us-ascii?Q?k/7GzKY/7NoN/yTBZw9qGNVqsEv5MmdJE6r8GZhMAmv9+YmVF8Rg3c79yeTF?=
 =?us-ascii?Q?kc+NLGkRexTKx7p6/9qCiE9ipCQV92OeL+rlCYrV1XSOZQWdm9pAEfiaIwXh?=
 =?us-ascii?Q?WbOsEeWC8kXGw1/uWfuTa7pQTuq0ASVpCEwEdIuMoZtAFFx0iMgmHiSubbkz?=
 =?us-ascii?Q?4JAozXjwx4xcRRJj09t54VpnHXk5hBmjyoM5X3T5ZHetUxaUCfSfmTi1+G4Y?=
 =?us-ascii?Q?mN2McqPn564WxbGRtsJZ1KFaWImjyfYVWBTCwvxDxaNQPaBTnmzv8EC/IQxp?=
 =?us-ascii?Q?4XLy7ZqHyTlMQu26GovGEH1LdRTQDjKMjK0UQTkHoy5aQm1IapzL/Fli3sK+?=
 =?us-ascii?Q?j/N6XDGBzwEqqvJnvsJXobwo9/ztOZC2jkzs8Dyt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48826a7a-a005-41cf-aa4b-08dbc864dd78
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 01:12:54.0782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fpFJKvzarCj63jM8xgYujwq2TDN2wyUjyi8FQClr4VPfWivKVz0Qetm+iiKkaxVGYZJi4t3WNqGhA6iPkT8DfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8278
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, September 28, 2023 3:15 PM
>=20
> This adds mock_domain_alloc_user function and also new test case for the
> new flag IOMMU_HWPT_ALLOC_NEST_PARENT.
>=20
> Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
