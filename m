Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F21697782
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 08:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjBOHnC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 02:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjBOHnB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 02:43:01 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D85B213F;
        Tue, 14 Feb 2023 23:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676446980; x=1707982980;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eeAD0TyXs1xHxnVpGVzwfeoAdGViEiejlgpkZmPf8Y4=;
  b=A4MXvye4NmxwQl8L7H9Olkw7IQpGUmy2YZNCY/liNaj4+VsZzVcvZSAd
   qwKU5bRnuvYaXy3lKVtcWY57o7xOCwp7PTdsaPPFOuHqy/VAPsPCODwJ3
   MWTiFyuHTms4gERsf9gacjBzzB5elRWfQAgpoDD4r9EYVP21iHPN0Cu6S
   C+9TkBCt91bJ6ZC+WYgOTTFgBB/U9jBMelfD5HaX8LpcA8Povbudn1ocY
   3ByvImNJHPXvLQXGwOOSnEaHOPGbCSlLXb8pgrR3IS4DW1oL+qvJx/byK
   936XMOUVay4eUMjd10ceY3twPedtUFordZ/2NoRjHD0wkqP4UNTUwMjZB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="358788006"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="358788006"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 23:42:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="915054358"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="915054358"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 14 Feb 2023 23:42:57 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 23:42:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 23:42:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 23:42:56 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 23:42:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAmTxlhCpPS6ytOsu+NDhbTimB/+JHift97KcC2dTu4WsNkrsQ2idBZ9J8zwuxBEIm5PMYE4K1QyHYA6dOUC9VutWHoZy2d6woZtsqlHjb6+rnePNTcnuClBC89bF2eh62AKWbbPm182qMpVoBdvtX7d2jwPAoSnNctDyDDhawPQj/aVMAasV1KrCJ/DjSuPOGXV/Dh9JLlbpQTrjKGInCbnhzXeWYKtKLxZcfa/yDeiY7qeAE679zZHFTZyBTHXV1GyWRnUiVU7TFMNaBDwWZs/4pSjiqrgpylHrP3uF1aZ3Xz4mDVF57iL8WJoCTOSB/xwAt5TGpxfxL61Mh8DCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeAD0TyXs1xHxnVpGVzwfeoAdGViEiejlgpkZmPf8Y4=;
 b=Pf7SJBqj4GBrI5s2ffkV9c+/Rutgvqz01YPMgUwtYiNRb0ybK4klhONyCqQqD4fEV4tDGq7zExkg8nYk3hmf2nCZWrpiHfjZlsf9Pwdv4YID+susziAS9FZit9MaGc3EKfW59DNvdsDMp6ZoC1xdJmks3S0WdIv5zWpfvUySYoSbl8LzcvnE9kxTInV0RNIf366GuOBXz1w4MGM1SirwnI2lMZFHB7mCHSNJkcc0thsElex3HbqIQmO6QqFdiJ5MRqSSkvIKfqx+aXF2mxMPQGrsui0OyDgg/HjBovrVb7u6zXvs5QaKiWytcHirk+tcLfLbJ6t/DFqAcikdmBhsdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by DM4PR11MB6213.namprd11.prod.outlook.com (2603:10b6:8:ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 07:42:48 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::59d:4c93:47eb:9811]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::59d:4c93:47eb:9811%7]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 07:42:47 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "Li, Xin3" <xin3.li@intel.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "H. Peter Anvin" <hpa@zytor.com>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        x86 Mailing List <x86@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v5 0/2] sysret_rip update for the Intel FRED
 architecture
Thread-Topic: [RFC PATCH v5 0/2] sysret_rip update for the Intel FRED
 architecture
Thread-Index: AQHZMHAoqvs/lwdyjkiVXoNdsc7iCK6uxqlQgAAHsQCAAI69wIAABdgAgAAErQCAAABvsIAgWPew
Date:   Wed, 15 Feb 2023 07:42:47 +0000
Message-ID: <SA1PR11MB67342D0472C023619BDEFB26A8A39@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20230124022729.596997-3-ammarfaizi2@gnuweeb.org>
 <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com>
 <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org>
 <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com>
 <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org>
 <20230125034958.734527-1-ammarfaizi2@gnuweeb.org>
 <SA1PR11MB67345C4DFEE720C08D30D93DA8CE9@SA1PR11MB6734.namprd11.prod.outlook.com>
 <Y9DpNG+jb8G/lhA1@biznet-home.integral.gnuweeb.org>
 <SA1PR11MB673480C4129F7A7EA9DFAF4AA8CE9@SA1PR11MB6734.namprd11.prod.outlook.com>
 <A5C220D5-BCE6-42DC-8115-ED41CD011993@zytor.com>
 <Y9FpxEz2+LJc7vJP@biznet-home.integral.gnuweeb.org>
 <SA1PR11MB673454F82DEBD8A1C7009C79A8CE9@SA1PR11MB6734.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB673454F82DEBD8A1C7009C79A8CE9@SA1PR11MB6734.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|DM4PR11MB6213:EE_
x-ms-office365-filtering-correlation-id: d4d38688-dd3c-4818-43ba-08db0f283b6d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qe0cnzDqpJ0ZXFfiHi+BMTP9QrS3Xi7Xezkolv7fjcfyc/VMNuZ2oxnZCDDgrolwEhniCCNM8d+XUpBp8qHEd93MMaoHrG7yjnsve+C3u4tvxty2HV3DoJwf02bdJv6MBqBGL/mPdcogDS4Mf2VzG5I+U8PPrFZZHll0xLLn69oH1n3uqhdRlIxFIshoOEJ1RYZMRHFwK6agbLvg8sP+WfckQ5CIdLc8P11g8bX4QGVyMr4q6I8QWHnJTJQ/zGjQxzqNN1wadttRzQHoQ/Uv4iPzZ5Nv4UyRri2/e6CC8CyANiCsHhu2FydvX0j4ZU0e9PqhIsoD1qHanAIe4uTJJ9A8d1jLgUVaf3x5gezMnjQ4zfQXA7BradlM/L5vycCGCuG+Aan/+O3tyEsazftn9OGelGQ4wBbcwn/y1SmvLbP0akHF/SEm/JpCUjrgSOpioRwy3K/fTqC3lB7TB82qJdNBFz1La5UdBcGe/E+Y5VTsBeLFQbMKf+T2436E15ym4gxRnSmxVIPscLwRkunzWAtTyqZtfd9YPFWLe4hsYff1VkFN5L0TSMTicD8/NcEz+rKs5WJHJa05PrZMpnqCqh03wC0TE/o2l4K3DdiPK2k/t7jD0vL8Go9m6vtuFHM+GhN9FNIyEOBXIwvWvdwfqD3ib96jCK/pT352zJ/yWD/YueqhM6Q76ztKEdxDVqD8KV0IqCPtegC6caWZ8Stp+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199018)(54906003)(110136005)(33656002)(55016003)(83380400001)(478600001)(71200400001)(7696005)(6506007)(9686003)(186003)(26005)(38100700002)(41300700001)(82960400001)(5660300002)(86362001)(8936002)(52536014)(38070700005)(4744005)(7416002)(316002)(76116006)(66476007)(66556008)(2906002)(66946007)(66446008)(64756008)(4326008)(15650500001)(8676002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gda7zemqYPsc0yqBKAKcX8ey2k/lPkeiKAtnvyeZ32Tuhp5adD0EBpUaTkMj?=
 =?us-ascii?Q?29Suzg4/saCuOtjSlVibu9IBEFi+O3wU2/RMI+ub2PejDOeeSvQCgjW6GlDS?=
 =?us-ascii?Q?NTdRvhQpU6AiSSXdD9mXZlB34maKGN+66WDqwqdZLoyG14H7r5pNWK/Pr3hx?=
 =?us-ascii?Q?BBpRtgEukmEqSha7c/bGv964IHhq68qy9RxGdvny+R/7HUZIhft0pK7kFpyx?=
 =?us-ascii?Q?AUaFUAEhZx2YF0Kw4z8dT8w5Gh66Q1hh9pjIB53iXIwpJdDRxElvJa1z0dMC?=
 =?us-ascii?Q?0jJ4b42fImmdTVngNqqHJ6Yg4iQE0uBZvEldQlvL5VQczcB0UtgW5YKZEi8f?=
 =?us-ascii?Q?fbg3LV2Q+z9eHrzoXB+PXweFcctnVOnaJQ3SASHcYdfKKpjtpcueFBIS438i?=
 =?us-ascii?Q?cgHiQyW3O4hYvKYyonmjRLKifQ0pqTeaXOgT+Ai9Juee6SSvXOi1RCz+AXkC?=
 =?us-ascii?Q?7dNHUhGOdZKHxo6vShM7T57KpwrTxrpM6Gf9JQz6Zi+eZ3XiYfI8KCKEADvH?=
 =?us-ascii?Q?OR+aO3LyA+csR70S7sTeoy+AfgtUpLE0daMFyUHULwbsWPNOYOkOuyPxk5OE?=
 =?us-ascii?Q?ePCa/60hu2MX5dZcQ1Vdtk4bLLNqw5ZlfRDtre2f7uNTMOLbLDi8IkRPHtOE?=
 =?us-ascii?Q?btE4B+MFPzqIRirf3D5F6nJA6fzCcN4M1ivsPodrOC0I3POydoe9IV/Yd9u3?=
 =?us-ascii?Q?7yjn58cFkqtabkccMbgR+GltCAhsneditGvZsPhvYtl7BSmOvcotxX7l5da+?=
 =?us-ascii?Q?MNcuI9hMHLJ1j86BcUxBW5lUGYqilq08HVG1n7fqdqrG+JIn4BGkCNALdn/x?=
 =?us-ascii?Q?ak2JLENi3oEbrVbRryMS8MPAzeBVgpDPh2kQ8YM1MITdoithPBiBHTqjvKps?=
 =?us-ascii?Q?67saxtu2cMY4auhs383mkNO2okVizZTKLi0qj/5e9ykMVqKgBlqdfZFRGTT9?=
 =?us-ascii?Q?c7T5uTNUvBqEZ8blaim5KOLI/sOZ7iQUKmIV5qT+nIqzipDgmYf7V9zOK227?=
 =?us-ascii?Q?D4dWItx5XFyfeLgRhtqMrmwgrOewH2LHUIgzBRAxM/xhH81gK7X+tAHGQpvB?=
 =?us-ascii?Q?P9OfNaqUPf//okGz4NstDloh7w2FhGmZZcXnN/jmgCjUqRUpX2v3DJ2QSa9W?=
 =?us-ascii?Q?O7rZbxHtZDzB05pwfBXK3kqNiWba94lSfeqkl+eF6kGU+Oh+mamNspJfqDkw?=
 =?us-ascii?Q?9pedjs9WVTktUsHPwx6Dey5L6ifW9k+lDH9rH6bC4n4Q4kywMh3G3mFWkkRb?=
 =?us-ascii?Q?RhjOTL4M5EyHuDyxpKZQMdzQhIwGrE/0R7UzFhN/dNCnV9dUNXgwmpgkGCUT?=
 =?us-ascii?Q?ksuh/l4EIl4zyQlTGT7gdy9QIXkyf+eBoq4ansDOz9yDo1ULSHZniJ0Ex8FH?=
 =?us-ascii?Q?8qDXkfSro2aklLP0mXNI3gER2CD+1w5suGKO1YpjA0+m4JANll8HShkdSg+w?=
 =?us-ascii?Q?nIeK0dScif09WPzpo4jhvg1gU0VKBwSZeiRsENm05qMBTyCnXCtuekVCAk3A?=
 =?us-ascii?Q?TbDR7PP0bFAjj/HJgUcsicR6xN0LD1k0x9ILf9wVBusoljaCVz/4INh/TKoh?=
 =?us-ascii?Q?0DaOWHBotvt5gKgEyy4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d38688-dd3c-4818-43ba-08db0f283b6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 07:42:47.2557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TuwQyksh/bmZBuzq1htWzl+2R0I4uCc/RXJ1Gka+s1aXSDkD9z8jyFr9EEBWHOarIu4g6ZHPzs72tnQtLwU0Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6213
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


> > > > Would it be better to get this patch set merged first?
> > > >
> > > > Otherwise surely I will include it in the FRED patch set.
> > >
> > > If the maintainers are ok with it, it would be better to merge it
> > > sooner: once we have agreed on the semantics, which I believe we
> > > have, we should be testing those semantics and nothing else.
> >
> > OK, let's keep this patchset separated from the FRED support patchset.
>=20
> Thanks!
>=20
> This patch set first makes the R11/RCX semantics clearer, and it BTW fixe=
s FRED
> tests.
>=20
> To me it's more of an improvement to the existing code.

Hi Faizi,

Any update on this patch set?

Thanks!
Xin

