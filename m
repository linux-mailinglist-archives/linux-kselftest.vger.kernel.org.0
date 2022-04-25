Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0499450E9FC
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 22:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245159AbiDYUUS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 16:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242284AbiDYUUR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 16:20:17 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F0521832;
        Mon, 25 Apr 2022 13:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650917832; x=1682453832;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RX1s0EZ6OWqS1g5UEeygI9Ah4t8RnTweft38C1mjaS8=;
  b=DBrAdUIL11kI/Pb/Eg+1dZIr9RTIPxCW7cQuLWlpI5ZSZCoNR3OS0uem
   DKeOInpJRCOMXNk9vO27mZ6anbbFQ8uMMU1zr/0V7fQRo90nNyPw8ehm+
   DPc9AErbC3tdqks0Krmb8FacmsN1CUdrV78ba0/BBgcUG2E5jnhazYwQ4
   Y8/tqxteSmBG2ejF+ZkvhoK2f1D8em3cQsWL1Hp60t5TXed4XMnFt13rx
   tXhuw1KrmszrqHtH+RlF6oF9rPU4rDp/pU2PtIPiN5Uu4D+NLJ84QBVfx
   cwXr2R+Llb90rhooIfrKu6MlA/CiQvcwgoC2gLCawOYQgZVU504epS45n
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="325841423"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="325841423"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 13:17:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="729897086"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 25 Apr 2022 13:17:11 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 13:17:11 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 13:17:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 25 Apr 2022 13:17:10 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 25 Apr 2022 13:17:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6szHhYqUz1L81XNxN5YQxpiFTQji2r1JVg3LMadTvhUJi8seksqZuYgzS8sn7nKJUswK6cNph+Zef47Vtak/FQYf09696B+ZQ4qFuJ/dMdDBvXHyvJvZq/WfrNIHuqoh/ISlsHBkm/7na3GwPOQVDCOE/nb8+e9LbcBiCk0HhcTrr4fauqKUUmWXjEVC+pnDUrIKg9pYoQ3DGDgavybJp2564bg8E1ATkPre+orD3L7NoQLlZIRMCIPKJ+zm8GfMZlaunYt3hWDd7NM4Y+ULMftTMwXINGexRRRiSR9a7tEd8hMy9txn3on2lHFM2OHwHfEOLBhcsARIGsUoYJ1QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CphdIbXIUxAG0qFDwBRjl/DNoSjH8SPgpkYUOOVQlws=;
 b=EIy0vo0J70mla9BzbgRMGC5fkY0dkMp+UzESFE4TkZFrPqqHfJq1aYb6foYUE7EBpBszG20F0HDb0lVw0c62TaxjuYvLBmgWlwmtzOKX7mUtpngB7lcXYFEF8HFfP4caXpl1Kx2NSzyEM2rqRMD8cUz94I/1aXuE+gkUnDYeCQULr+atKhjTGwmOrTZ5smAQfcjKYwH3IX2kWYs1NvEJb122byrTttqgSKZjHftT+smdK8Dz/tMBp754EiZE6066ZUsZc4awf0shTRkSjYBN846MxGGyguo4kaC6ralRbkjKNmS+4zP0LdveaMolBBlDEAlvN92GR9MPG2QA9wtraA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5591.namprd11.prod.outlook.com (2603:10b6:8:38::23) by
 DM5PR11MB1308.namprd11.prod.outlook.com (2603:10b6:3:e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Mon, 25 Apr 2022 20:17:06 +0000
Received: from DM8PR11MB5591.namprd11.prod.outlook.com
 ([fe80::14a4:94fa:fcb7:3089]) by DM8PR11MB5591.namprd11.prod.outlook.com
 ([fe80::14a4:94fa:fcb7:3089%7]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 20:17:06 +0000
From:   "Dhanraj, Vijay" <vijay.dhanraj@intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        "Chatre, Reinette" <reinette.chatre@intel.com>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4 00/31] x86/sgx and selftests/sgx: Support SGX2
Thread-Topic: [PATCH V4 00/31] x86/sgx and selftests/sgx: Support SGX2
Thread-Index: AQHYT3rxs23shhvg+k2Ofp5Co3ZiHKzvRb4AgABWSQCAAAX2AIAAGVGQgAR87oCABtb/wIAARCqAgABg5YCABW7NMA==
Date:   Mon, 25 Apr 2022 20:17:05 +0000
Message-ID: <DM8PR11MB5591CACC6757FE71B3E19FC3F6F89@DM8PR11MB5591.namprd11.prod.outlook.com>
References: <cover.1649878359.git.reinette.chatre@intel.com>
 <2f4338f37943c2b067db16ae65c9af665d3b51d9.camel@kernel.org>
 <9fbf26c8-5808-20c5-8653-d4f36bf398a4@intel.com>
 <42a52a6018e8dadb4c3eebefaae4dab31c0d5721.camel@kernel.org>
 <DM8PR11MB5591BBA189BC4EA5CFE2C7EAF6EF9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <54f053d8bb6b72725b2351fc2016d20b65cebbf1.camel@kernel.org>
 <DM8PR11MB559180D1BA05B0E77D354467F6F49@DM8PR11MB5591.namprd11.prod.outlook.com>
 <a94e4098-f5c1-f9ff-fab0-c2e5210cf188@intel.com>
 <YmJyYwp9UHRLWaTw@kernel.org>
In-Reply-To: <YmJyYwp9UHRLWaTw@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0b67a41-bfd4-4234-ee81-08da26f89160
x-ms-traffictypediagnostic: DM5PR11MB1308:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR11MB130883E58B1564F474B4DF92F6F89@DM5PR11MB1308.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +7MCRU6yxF9yuvmxZH1bBTeuaOk30CN4QYy2ZIaU7hNqMTNZw8JwAPQEQOueArIHOQEmWjVc6bB/l0q3wlUqw3kbrSplNCwgZIkkzjnbmK4PcGAsx7rYyfSjpi0S/09tlGY+6+mLhCasVAEv2HanLv9qoEqaRvpcKaekGgaTrSd0xeOYA+/kd6LL16yqfQlZEwLBXbqnMLpJW3SiPqimzoJLomgQLgnLpagl85s8vRwTqsbXLebs4syc5MChBmv7Vyeu4lQr/RGSTFMtVCAJ1JYvzmFqQ4wCKyCW9dkBhi425D5xpnchFLLUpKvUfEo9Qu4Cqb9kgyujExv8ydmHE3NsnOUGbS6gVVzbcQkxBcq4mp+l1m3KKyUZqsR5jHm+msC/8jwxXW8OU4/ERJPWhQLDkt2A7NPB78FxJ9Cc1XFO6QmU95swcOOEcUyMGP7Ba5XZ4Lda4Rxh0Y15wgEwrOjjxQqMko1k7LvYp1HbqO6OcFpPA+1QUgAqGyusw0fr83CLlEW1wmTaNnuNkedqNlqA6OIuU9Zz7r9f8sRMCL+ivHwaOp5jpV79W6VeMUgEkkXEKPBzw67eAaoEvNwtRI+MdCOYQruOJctuukDtZJpMfd0jr6nqcQHNAmvHKbJsa3IFSmsMMh8ZlyUbkXOy+9bjsg8FWiDM1Z3gDo55Qzjfs11+ndIPaSLqNwrME2YBdL6UdJeS/sAYV2rhHLT/qQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5591.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52536014)(4326008)(7416002)(8936002)(66946007)(8676002)(316002)(83380400001)(82960400001)(86362001)(122000001)(508600001)(2906002)(110136005)(38070700005)(38100700002)(66556008)(64756008)(66446008)(66476007)(5660300002)(186003)(6636002)(54906003)(71200400001)(76116006)(53546011)(26005)(6506007)(9686003)(7696005)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E94H1aw9orXzqWy6NIaoHi0flqUOGY8xH//npLLVle9s3RVHEZc/d2BLLDlY?=
 =?us-ascii?Q?jHtiRPeYU1qO6FbFRpyEGMAm8BVTaAKViK0iydkAidWcCLBtg5FrDk3mo/Lq?=
 =?us-ascii?Q?JeUdyv24ih+97d9uQ9YGeFJUEqXmcvBngrTLFBCo9xE13ufngpTDxjtrOyMW?=
 =?us-ascii?Q?4B5TQuaTyhaYLVT+pCLH0DLifckTCTGrDshZLDfSAtcJ7ubojcOmjlLpXVUi?=
 =?us-ascii?Q?z4ym3kpX5rxwGnSdnGE+j0CBtlwPeAe9o8IJcT5KKR34+qxlnIv5pMyIpJjg?=
 =?us-ascii?Q?MPtQ0t4os2ysmF2kZn4+G5hSfT6bCA/d4n9L+WpHxfGeFMp0HeccTdd+wrQl?=
 =?us-ascii?Q?2HEy1lhkgl6dLsvTANqyZuoFJ/E18+ZTN8JGr8OJ+39R/ypmAkTD4JR8HG/I?=
 =?us-ascii?Q?cpkyRregjsrTv93HYIAdZPVgL/MjFC0drO9HPWEpqfOIFFFTBbq2aNmS9AQ1?=
 =?us-ascii?Q?kZb2k40qwpM0CN/bo3ngf3Fzka8qz0D7vaklbFArjhaCHwZg/dLUH8X3HxDq?=
 =?us-ascii?Q?a+7cXZEumSfPoxfh3L1y+2PTE44W7ec/MUTCW0qQC67PkwDf/+VWwyJQUm7X?=
 =?us-ascii?Q?FlBPTPL1/6pWRhzPoi4u+jCpa7DruiCyTL8GuKB48sgKHIILwpfs30MmuMYS?=
 =?us-ascii?Q?0SobIQ7Tqu0sjdGkLj9wO2Qotq2JJ/DJgxGMbFpvqrdOAYpkyoSzKzFVQ61+?=
 =?us-ascii?Q?kseM+GGQytAXpnWCnEi3EWQYjrpcwgdR50ZEPBWstAq9VI/gihWYuN9kWu2Y?=
 =?us-ascii?Q?gMTvIUGqsmwIttrmMS/Kr3YuT+fs0vVIPAGRJeY5n/2bpzdl/9lO+GWrFyxF?=
 =?us-ascii?Q?LRM+qCmTJT9Dz3JqJvPQKw4qH92ZjctXaI5EDkurZmYqnxe5bGrrBS1eHBZn?=
 =?us-ascii?Q?1RS4ztkw3HBpZH2y8zHHLM+wA8nYIBgWVCin0WOH1bp6msstI9xR5YQgQe9X?=
 =?us-ascii?Q?oFHN8kNNbguCMBqj2+asgdZaqXLN02VnyNxkN2h+4j19snCjFbDYJp/IcsZg?=
 =?us-ascii?Q?NXMpnHD5ph1G/UTn8A4zT9wAnoodKKMQ90ZT2eH2qjnlYNsFlmfTUe/n5FN9?=
 =?us-ascii?Q?I7eQN5d4hl2cO/wO6KBwZVoLJTRRAs2Gsz8Aeh8cCq9yn+AvKjbxt+34LP2c?=
 =?us-ascii?Q?dXxazqlTdjFXoSnhYMWDgfy64azP1kOIDOthIMJnaNwn7cNnO1BF8hpTAhtQ?=
 =?us-ascii?Q?fupSsDnPO5cDxVpCg0/d44xTv2FsdPrQ8Juzv3KqtbfCTOVpCmqjlE8gadIn?=
 =?us-ascii?Q?7z9UvZJE3shQnaONPsUXjQy/n75pafEZsNNj4mRObJef8uTFXdFFyQK5hQ2G?=
 =?us-ascii?Q?10bgTGr3kg53Sj8HnkanhVvUiUJtGLykGYsyxWshj3GTEdCdHudeBoSpim/h?=
 =?us-ascii?Q?pR+dMpWXKDZok9E+GPFZygU5QIlNO2QTr5wHA+z4E6KRFlpbEXLYbJzGgOEX?=
 =?us-ascii?Q?nMr8Qrmk4MyPcXlm4n/4mycUbtAJbyX1Xh+41mYVC7NAIlqlHTukiirYKjyH?=
 =?us-ascii?Q?DiK7VOt2BhUctLgoAEyzmGhYFprhCinma0FLWFa9L8h7AI6fS5iKz2OUKfvi?=
 =?us-ascii?Q?7BxeqZBJvpRlAQWk8By9mOpAGhMXwHb6IxI+jmoC2p5PcXVC1+KPFHqxDs5j?=
 =?us-ascii?Q?aN8wOKf3rx4bSHvGHw1tnMoehG9KGcU1jnAKC7C1fRWEuW7Mj6RPT5C3CPlC?=
 =?us-ascii?Q?PV1YMZDBpy0a3nu5+ArYEUm9IJ6OJthIANdVZI7uQT9KeNwzZD3RlWtCWJGr?=
 =?us-ascii?Q?GOHsLnc9IA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5591.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b67a41-bfd4-4234-ee81-08da26f89160
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2022 20:17:05.8515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yA2qcqc//qhYdyArkVNOkvJaMMRJsf9DN/zpwf/AzL1a4e9T4/tDbkKT8aGr0j6h9g8JUbzfNt4eHLcZ3C7DmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1308
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Reinette and Jarkko,

> On Thu, Apr 21, 2022 at 08:29:31PM -0700, Reinette Chatre wrote:
> > Hi Vijay and Mark,
> >
> > On 4/21/2022 4:46 PM, Dhanraj, Vijay wrote:
> > > Hi All,
> > >
> > > I evaluated V4 patch changes with Gramine and ran into an issue when
> trying to set EPC page permission to PROT_NONE. It looks like with V3 pat=
ch
> series a change was introduced which requires kernel to have at least R
> permission when calling RESTRICT IOCTL. This change was done under the
> assumption that EPCM requires at least R permission for EMODPE/EACCEPT
> to succeed. But when testing with V2 version, EACCEPT worked fine with
> page permission set to PROT_NONE.
> > >
> > > Thanks to @Shanahan, Mark for confirming that EPCM does not need to
> have R value to allow EACCEPT or EMODPE. Given this, can we please revert
> this change?
> > >
> >
> > Thank you very much for pointing this out. I can revert the change to
> > what was done in V2 where the only check is to ensure that W requires R=
.
> > This is a requirement of EMODPR. Could you please check if this
> > snippet results in things working for you again?
> >
> > ---8<---
> > diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c
> > b/arch/x86/kernel/cpu/sgx/ioctl.c index 83674d054c13..7c7c8a61196e
> > 100644
> > --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> > +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> > @@ -855,12 +855,8 @@ static long
> sgx_ioc_enclave_restrict_permissions(struct sgx_encl *encl,
> >  	if (params.permissions & ~SGX_SECINFO_PERMISSION_MASK)
> >  		return -EINVAL;
> >
> > -	/*
> > -	 * Read access is required for the enclave to be able to use the page=
.
> > -	 * SGX instructions like ENCLU[EMODPE] and ENCLU[EACCEPT]
> require
> > -	 * read access.
> > -	 */
> > -	if (!(params.permissions & SGX_SECINFO_R))
> > +	if ((params.permissions & SGX_SECINFO_W) &&
> > +	    !(params.permissions & SGX_SECINFO_R))
> >  		return -EINVAL;
> >
> >  	if (params.result || params.count)
>=20
> Just adding that it's fine for me to revert this.

Thanks, I verified your patch and now I am able to set EPCM page permission=
 with PROT_NONE.

I also verified the following SGX2 interfaces,
SGX_IOC_ENCLAVE_MODIFY_TYPES
SGX_IOC_ENCLAVE_REMOVE_PAGES
SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS

And also tested dynamically adding pages to enclave using #PF based approac=
h and this works as expected.

Please feel free to add my Tested-by for the below patches which test the a=
bove IOCTLs

[PATCH V4 16/31] x86/sgx: Support adding of pages to an initialized enclave
[PATCH V4 15/31] x86/sgx: Support restricting of enclave page permissions
[PATCH V4 18/31] x86/sgx: Support modifying SGX page type
[PATCH V4 19/31] x86/sgx: Support complete page removal

>=20
> BR, Jarkko
