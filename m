Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C943B6A0468
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Feb 2023 10:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjBWJDi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 04:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbjBWJD0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 04:03:26 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6204A1ED
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Feb 2023 01:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677143005; x=1708679005;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ntAAgVoKnmIqH53V8sTN5vch2kV9AVPV71ce5r/H894=;
  b=VDqg3Jvzl+/p1r//tHe09l+igmscuUMtYlMC1wHq3qtT6XrPtOkbDzrw
   kaN5dgDlgnVXeFhOj6wfp6OkoexPwpWNkfbvy9NPRGbYyeW0b9ogXJoCf
   3yn0KBabVxAEfBwvUgdi7fhN+h81/lyV6RUbhMLcm1bIafSRcpIDHi5np
   QqlWbifjXRfEqQpMy6eBPMBdiGbGXC29LNwTGOYw1Iti3NWOFi3iOiPT7
   tIHgvvwjKhVWD/oMj8YJCcTt8z21zTAcWXxieXYJw6N0qkc8YwcwiaMZT
   HBCUMnM3sqL2CGn80Wt28nQ8TTZgldi1GJx4fKeQE3JYhImr6EcWivzfB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="335362109"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="335362109"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 01:03:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="846482160"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="846482160"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 23 Feb 2023 01:03:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 01:03:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 23 Feb 2023 01:03:22 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 23 Feb 2023 01:03:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4zcO18XZdnkYCEG3SJ4wjMw4nXN/kAUQ03QKz2nV+1DelUHDcQhOasPp/UBb6r7HhfyT4f9zpjVPQUrC+udGWmSaiMHNshg6scKFjIqW6qyMI9xGKAoJM3U0ORGnwQLd9Zs85xQrxsWfGpx1uHEJWsGhArx9ovqxBckCuOlA7TJaTaX6Z4liQsIz9ud9PCoXGuyJPiHKvHAmPB0O7MM5SGiSr0dUJZUvopIDvckgR4xLk0+bOGlb86V30zA+Zzg/BcMwFKt4Ry6zgFIWZGkV0msD9R7ZbG8PpWzSMHWsGvnjxt52Q3ZzCKPpKOUspVLbM49uGaa/2LKNA07no7+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evbE4I1PDjNi4rCO8LqcgJP5yujIh5V6tLQEWvk9Yuk=;
 b=dZ/sZcdz+bj72bQVZ28aYwSZEUsKeuoyBQDuOmmhVCJ1db1RJNRHPbzHjgOvNXkN+rhsJn2LJE4tt1ulA+RW6gLhtP0xp4FPGlwRIPeUWb101WO6+S2XrqSQ0XhHzQk903pJ18cOkmCgd1dzc9xWIkIZi4Km7iUOmbA4Jg6DNsT2TSrIlrnb1yZtKOdSuvK9zWFded6+blVXFyi1d18oWVaDqvblBtoehJyGJO5WbQnOpMiti0VV1QAhMHzH5bLy6Mgu22KyNTrRq/P/ZswdFcpnlJl4nWJJfG9MH2F9JtcOYZGHhTmdskmbhbuVwzZzQS7Nk0f3Z7UfALQ4lFxN0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by MW4PR11MB5775.namprd11.prod.outlook.com (2603:10b6:303:181::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Thu, 23 Feb
 2023 09:03:14 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::38d9:ca7f:b9fc:ef7f]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::38d9:ca7f:b9fc:ef7f%8]) with mapi id 15.20.6134.021; Thu, 23 Feb 2023
 09:03:14 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 5/7] iommufd: Make iommufd_hw_pagetable_alloc() do
 iopt_table_add_domain()
Thread-Topic: [PATCH v2 5/7] iommufd: Make iommufd_hw_pagetable_alloc() do
 iopt_table_add_domain()
Thread-Index: AQHZRwEJjmcTUIufy0K/NtdPAAEd4K7cOsnQ
Date:   Thu, 23 Feb 2023 09:03:14 +0000
Message-ID: <BL1PR11MB52714B54BB1BE16E99AEE11D8CAB9@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <0-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
 <5-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <5-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|MW4PR11MB5775:EE_
x-ms-office365-filtering-correlation-id: 0738f23e-a92b-459e-57d8-08db157ccbc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2E1tLAYX2aWCZn7Xxol4tcPyQco7PwrG1r3DgIvI0fUni5Av9cycWhF4dYo86R6MGhXymilPhhUrlzZsFiTHpIj7oNfdxqQ+4uEQ7YGaUE4B/KHyUbKAYJ9DBjMnui2JTZSD2NfEOKpn/sRdKPe3lww3BYR9wqYGalgNoX1jajwU2gDLNfe9IG9NuGwbDZHKcF0+21w8aDM3tPc5J++sqzk7JqWr+W8r6/xqixa9l+VFZwmauHC9RAcLtMrIA8AgEBtHLG39ScmBOlAKLzml7WhZB53oYiiWEyY0Y1eQs9ilHOawPh2CzdEztv2H2OKWdcmsBaiaxmck8QTXbHzJyJ91VZRFb86CkEEQd2BlT9q0WMnZAtxl0D/j3PQrAxz4LoK792Wpz8fsQ0HrXc9rj916t/8ZNTvOzhigGq5zJxFbQHnTHCY/fDSPLhe29E9z7f783OR5siGI+5dds14wiW5aP/Z6OFQL0kwDzr+sqnni7GpUXle2LJmEBDZDNj/WP493uUHc9SGnvroiwtklwuaCGgaeVxklk+u/tPTRbGJF3VewcWlXWomUD0iXYzhPvYYAzDSwCjBt5YgkDgr8EXgvhBgwSHLfZD7BHjb6KsrpqhGPowjNP/b4EEa3LacreffcaBGu6r8MEA6ab4iDfD1kWv8dtJioT9eyJlA8ZeuiQjTCNvIC25nitKy1MTvrcO+wQNRtTlvNfyhH2Iubyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199018)(478600001)(83380400001)(316002)(110136005)(38100700002)(54906003)(122000001)(2906002)(82960400001)(86362001)(8676002)(66476007)(33656002)(66556008)(66446008)(76116006)(66946007)(55016003)(8936002)(4326008)(64756008)(52536014)(41300700001)(7696005)(5660300002)(6506007)(38070700005)(71200400001)(107886003)(26005)(186003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zZdWui0JJzbroOlEVPMNB3cwGs4Dztq1GBo3ErapV/IMMOE3tDsWsTsOkXXK?=
 =?us-ascii?Q?FqyFw5I2ukD6GHnOkror2sE4ys6ZP9NILXFVxSDlX1CtSnc/RI1ULHZHmr45?=
 =?us-ascii?Q?CTxJsaduid4lL4Y5S1AyqZQzYNUH2NsPPdTtyYkDa9dViWSaO2HJ6MRkaoUX?=
 =?us-ascii?Q?1Y538S6MvmXY8K+iMwsK/xKUYC7kgs5Q/LuU+D0i28kqjlbcY21HGbbYkVGt?=
 =?us-ascii?Q?YrLvz2RzQy+OPUhnRnTyvM509SP6LEgS3R5jryWSdf3kkJlt7D7jVURqNEFj?=
 =?us-ascii?Q?FEkpn63rUJtAybyiFRf4DJt+axM1t+NnGVKdHll/t/CqpS3VSfO+NI+jpWqv?=
 =?us-ascii?Q?nyhNW0VaYWawyrdZqCFdXGsjb10T0TWEUMiIC5t21rfDJlu3E/f6LfJvcKME?=
 =?us-ascii?Q?cUJZvNSm1yY6wE69PeJCcTSwOowmxZoXpE4mnDr4dOdcbQif5Rxv75D7BTt+?=
 =?us-ascii?Q?q3XalTaXNavO77sux2F96MFWjdZVcvmgGZ72qskgbLFkVLJtIQkcftoNZIHs?=
 =?us-ascii?Q?V2TGbAJQzxjwKYZZNlNscHwHyKrWwWrV6Cn4Oh64Z+h5OM3DwmuVNpUpOjS9?=
 =?us-ascii?Q?vcSO4GbrIY4O3FMF0a3gdkttoJ/Z7nHaNp+R/CefU3isNEC8piAePLZHCrUZ?=
 =?us-ascii?Q?3vso+7kOo4ieLcfieJC7yuO9SfGr0NobUeR9IFG2u5AWVHlWkarXyxpsRYV+?=
 =?us-ascii?Q?XNCzOqYIt3S1fT5Uuu2LZzSgvRT3EuYFygLBpLrso7GjMJxqGsTweIpDmyDG?=
 =?us-ascii?Q?BqqF0JhI4T+CDkyBY2TeA/m9Opq6IpbcYu0Yj8Ex5ZD7Sqo280DZuwsSeE7Y?=
 =?us-ascii?Q?k0pgXw6REqgCmgrzzGu9mdpP8HK95ftbmdPA1jAs5EdfZHnCoqlbHq5VQY1O?=
 =?us-ascii?Q?+OV0s12/qrMiGRDPK/kg/u4fr95DfI+Wt5GX5yerpmaQMW0A1TPDnAG0U7fv?=
 =?us-ascii?Q?e6HQC8cCoT6GqsgbTm4B3DbiYsUYcAxtVNh4qe+tFcVADpDOJnWp2Vel/90g?=
 =?us-ascii?Q?diqzO8vdriI+z1YBNT0ADd4SYJkSNaTK+/n+9zWHh5MezfaV4QCZ8M/NN0L0?=
 =?us-ascii?Q?U33STa0Zzhrr3SzEAscbr95Of7+nIu7TVV0rTEVJK/ZBIyxC5d+xGRJz878y?=
 =?us-ascii?Q?QdGF3JeX+BmFec24I4aeEVuTc0up++zu5z1D8T+fQpqmBc+YhvRDgbXqN4/G?=
 =?us-ascii?Q?KmMAnl5ezlFapLpGTFcchEJDps5dLSRLXXwkYk/l6ba6nurHCf05aeCEvdAV?=
 =?us-ascii?Q?rhV1o341reyQAYKSEoN3u1TrhN+CdFGJngzLei91xQ7wEJezb45reE0uEeI6?=
 =?us-ascii?Q?mN0LGWqNkcLCMnKnE5/xy6u+ggUcfJH+BJU4FDpY9quIvQObAXGuxpnhJLrK?=
 =?us-ascii?Q?T6VvN8hvnHLyRdhS9v1qo3E3r/OpZStUxoXCoaOKDOgd2rOpNj+YJ1jwvSSw?=
 =?us-ascii?Q?jUP1IDWmWayFr7Rrjlklovjdokp+HccN2xc/pKTQxF83d0VJExGNAUC7sg4u?=
 =?us-ascii?Q?zqh9DfbRyvtvAYdkguHhrUV7qIAUYuOy2bsttZLI8x3zOq8nGoffUM3FuWhg?=
 =?us-ascii?Q?2VEQWEjoc2DnweapLv9j+NhAzupyb5WGOw2ng8mR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0738f23e-a92b-459e-57d8-08db157ccbc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 09:03:14.1227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F5ai9fbvxl6VrBkRzwttBq+PRfEEBaefi5F+3KgE8Y4yZrCnPSCHigLbUf0oPAOLHphUdEFNQ7IIeGjStrULjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5775
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, February 23, 2023 5:03 AM
>=20
> The HWPT is always linked to an IOAS and once a HWPT exists its domain
> should be fully mapped. This ended up being split up into device.c during
> a two phase creation that was a bit confusing.
>=20
> Move the iopt_table_add_domain() into iommufd_hw_pagetable_alloc() by
> having it call back to device.c to complete the domain attach in the
> required order.
>=20
> Calling iommufd_hw_pagetable_alloc() with immediate_attach =3D false will
> work on most drivers, but notably the SMMU drivers will fail because they
> can't decide what kind of domain to create until they are attached. This
> will be fixed when the domain_alloc function can take in a struct device.
>=20

Is below understanding correct on how to retire immediate_attach?

1) immediate_attach=3Dtrue in auto domain path for back compat (what
   this patch does);

2) immediate_attach=3Dfalse when adding hwpt_alloc() uAPI and VT-d
   support;

3) fix domain_alloc() to take struct device so the SMMU drivers can
   decide the domain info w/o relying on attach;

4) remove immediate_attach and enable hwpt_alloc() on SMMU.

Of course 3) doesn't need to wait. If it happens before 2) is merged
then 2/4) can come together.
