Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C6B67B7EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 18:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbjAYRJS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 12:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbjAYRJF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 12:09:05 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC3146BF;
        Wed, 25 Jan 2023 09:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674666508; x=1706202508;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hs+dKMEZ20oOsDwasypI2/5YXQKUE8zIQGkKs9OA6os=;
  b=KuNCVgB8Ml5GLsLz9aIqhANFBlR303XOFKO569Jj+UEDP1duI/pY54L1
   mJ/OU8lnISjewIdOYZz/LcFzoHjmDOOne8bWhJU/bGrXYD7NsEjfVfY5/
   1Ut84ttiVJJzPOWizaaFWnIyUYfmZiJx4HwImjueXCvHTnXOUQcxN5Fby
   VPy7nijo/xUM7LppBQLfAfbyTeIh2LL2HV8M4u/odtRlWkFaEaSIjoSvt
   0Q2cE1ELfJECYDTWyEI769a/7S667qdR+wiWOLsBlNKeM/INBUeRQiv34
   m7PAHMcqIQ3j9mOyUrF0LnbpEn3iEcEcZ/fmABU21m2a6paN1TbnLSMnF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="306958844"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="306958844"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 09:07:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="655860042"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="655860042"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 25 Jan 2023 09:07:24 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 09:07:24 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 09:07:23 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 09:07:23 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 09:07:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkfX77/ArrZHeLZK+Vhb1AEK8pLBRy9ew88OWRgvGTK1Uq3s4BldTOMmaP0m9fSc82ZaRzptg/j1hmcrXystDO062YNhvbIX+VtI6yTAsXOGVzVXFV+i24GFA0ydpXgZgoZicg2WP9SZpupn9VQb5PuXbuUymgTxje59t0dzEW6EQgPe8Jz1CH5fsmeCslPyKaUAG98h65FSpcaSEQWYWOGgGz7s9Xz+xh4RE1SVju4xRbqIZ2CjHXnmmWQmNPk1I4I17SGyCy+nFWdxR7RjTddeUNV1fglMEnN0RxnH6bQ19NqLInMZ0p7ZgkmNzsmRAEHpJMWTMj8/owcXZ7m/5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqvjEqbZDZM6OgfIYbFQ7YFYl0tdFQ1m0Do/E4oJbgw=;
 b=LGxW7IrqSHfs/6bfaTqKs/n55cZwM4X9BFyo9tvL5Y2t0ZCYuFZPVmnYpddfO7GdBZwoCkWOkG1oj3ROQq1V0roIatyoVOvNe1Vtgor8JBLdHb/0iuCEgRPJGh5aZba0GAT6pLCZTN4jZt7xdPHIU6dazbtL0mCoH6r1FIqbMQNVMY+qsWnLa2j2pfYhbUjcAOMDAOcS2L4/fc/F+HgU05t65SOE1McW7j/df9ftZBV27B20Pqv8HpAK4NNrroBJKy5l321T/aPpqzI9WVRKgxjXi5kQsOK4mfKisuBQIldwBiFuWLkkBnfMf/r4soqTmdHJNllKDKuCbQu+v2k4UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by BL3PR11MB6337.namprd11.prod.outlook.com (2603:10b6:208:3b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Wed, 25 Jan
 2023 17:07:18 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::59d:4c93:47eb:9811]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::59d:4c93:47eb:9811%5]) with mapi id 15.20.6002.026; Wed, 25 Jan 2023
 17:07:18 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
CC:     "H. Peter Anvin" <hpa@zytor.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
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
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v5 0/2] sysret_rip update for the Intel FRED
 architecture
Thread-Topic: [RFC PATCH v5 0/2] sysret_rip update for the Intel FRED
 architecture
Thread-Index: AQHZMHAoqvs/lwdyjkiVXoNdsc7iCK6uxqlQgAAHsQCAAI69wA==
Date:   Wed, 25 Jan 2023 17:07:18 +0000
Message-ID: <SA1PR11MB673480C4129F7A7EA9DFAF4AA8CE9@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com>
 <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com>
 <20230124022729.596997-1-ammarfaizi2@gnuweeb.org>
 <20230124022729.596997-3-ammarfaizi2@gnuweeb.org>
 <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com>
 <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org>
 <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com>
 <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org>
 <20230125034958.734527-1-ammarfaizi2@gnuweeb.org>
 <SA1PR11MB67345C4DFEE720C08D30D93DA8CE9@SA1PR11MB6734.namprd11.prod.outlook.com>
 <Y9DpNG+jb8G/lhA1@biznet-home.integral.gnuweeb.org>
In-Reply-To: <Y9DpNG+jb8G/lhA1@biznet-home.integral.gnuweeb.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|BL3PR11MB6337:EE_
x-ms-office365-filtering-correlation-id: c3d34c03-4d1b-47e2-8085-08dafef69d79
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cnsWs47Gn9JWOGu9Qrb0YvRTuFipitbFUmixx7VCPfdbab8zSvwn1JnPtq6vdNp2CpL0neeAV4/cOFm+iVRD/dDikG7AYmSTYtOyZSMirKL373Or4u6W4OLYdyla0R01EjQVTS8pNsNIsXrPfmTkCahU9sUQD97x8dYk0GsCNtk9Bn7Ga42hylMpnLburWxzl8v2fy/gFKgYOG8iJ63we/Q7f8DKfIUDQ/xQEKQBKgz5qNuAEgr9ApE61OhMNP0/sHJRdqQP3o1sgdHs+zf6mnHEAsPKPIBfGLe5jWlEvy766jhFoTwlWjyvW7R9Iubxyid9/pzpM713N2wPsSdz9hgJrmc5HRgkFnR8FZz9s40kKomHZJZVrHXQ2KohL74BBf6Li4JOQlitP+hZdPRMA3BeDoeDzNfRG+YsGZxKUT4K/8PcB+QFZtqj8KenEks3X4BOPLXRbDZ6YCiu41ymO9TXbHt+2hRwFZ/C+Bl5te6UtNRj9JvYFo14ZAiGP+LTyjJOZwjojLokTIPPfBXgBghcaKXs2XQh35p/Sv+giqmWgEjAN6ZQTUWWydXT8hY1NZMT4c6DZtpyZdi2ZIbge71PWu0HRhzeHQjYR8BWfaoQR1n/fY2dEY2sLDMeIiN2LJMRa++CBUzhKOAMoNOByA4C0S/YQGuwFCzWDbpOJvAkmt0GTVngdI+n9WPSk4fiIQpbXc9V8zcyD0oFWOjE4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199018)(41300700001)(52536014)(8936002)(38100700002)(122000001)(2906002)(7416002)(82960400001)(4744005)(5660300002)(6506007)(86362001)(186003)(26005)(478600001)(9686003)(7696005)(71200400001)(64756008)(76116006)(66946007)(38070700005)(66476007)(66556008)(66446008)(55016003)(8676002)(4326008)(6916009)(33656002)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H2ZiMXU/SpiX2RnHr8kolimDBu9qdkbTcrLt4pJb3gbkMdqyA+dVlArQHLjL?=
 =?us-ascii?Q?IY/OcfPT/eZBLoGZug2UDkCEETDXKhRcDLC+ZZFZHpDzRqNAGiQC5ajQ+/kv?=
 =?us-ascii?Q?m3s+oCpGNunuqzLkfeRmlUy0TMen712F3aHKkS4q2iuQtyEaBXP24M2lpJ0v?=
 =?us-ascii?Q?KGvMBn9qSEVizgM/0nXZkBPtjk9yejbfSevZUIFLhfFvLWW46YjiarF9WAmb?=
 =?us-ascii?Q?ZFc+0yfWM6a05aDRfRgHLtNSg5KfCVYvDZrLQXeLXXUkMRRn0BpoIizKgTVk?=
 =?us-ascii?Q?E/WzgvL5cOiil0GsOA4xrNfXCA5KMWEWw4UUfuGYk5DUfDVMAUK7qEDx1gle?=
 =?us-ascii?Q?pPUhCKMuLqhcUi6yUwZj+b+OzueRyISLvwSnDieKoOOm/VVDGFhu1+Cvmof3?=
 =?us-ascii?Q?LZygVx8RAmSkOL8zzzAGfvb1Z2WLXT9tnkIvx3FFxyXrKOiCapaUd4yMTz0m?=
 =?us-ascii?Q?DCde5uKFE04UwisHabQGrimvFrTflrEzbI+wRsPigyPLDb3gXQe5Xj0yR/WO?=
 =?us-ascii?Q?XC4YTwDiqp6PLqgGl8wBlbfeDvasZQgXwmihWx94MaTmBcD5xx0rhUomI4fv?=
 =?us-ascii?Q?H1r7RRg4XjNgTWT6gbn3YEE2ypODfz2SGTeC3SHbo+/0beuUB6MQLTByXhbq?=
 =?us-ascii?Q?Nu/tS8PkHVqJvWeGk58I3gCgkpQvu9Sj5oemuGqg6GEVNEU9npjaUMIinyQW?=
 =?us-ascii?Q?rcHn1lYURJ4E+euI28oAw74SA/8QGNjIREiNmDs4cAF2ykj3kmPmmnnnZEHA?=
 =?us-ascii?Q?P8iGh1g4OLositH/ZzCKEyAqgQyxu0z5LzmwPO/3S2m7Owqmq/gzGtRS/WCQ?=
 =?us-ascii?Q?QysYz0Rc7Q7D72kG7gNHOgpDMTqTwyJ1NKgneaclekT/s2YV7eMFxX/bOMO1?=
 =?us-ascii?Q?nTdogoK92lKi4LnedldcjaSBXcr8JJGfLLVJ5d8oPGegOpgcnP9UZ/2+cj9u?=
 =?us-ascii?Q?aqAfDbTGX34V9pkcAJybSRk4ef2xwU8X9BaQmjn5/iQbXI0vN5oUQh9fdzRJ?=
 =?us-ascii?Q?6uBiljvo6SIgKVN8brRvelCkGRjdzc4y5kyo+hAXYZZYs7Dw3g+7r9DU7a63?=
 =?us-ascii?Q?5cB4jjtf/vbZ8Ly0YAaSn3Em3DjyQ83QYFIRkrcKwhAWOob0bPHb1pvhiC8j?=
 =?us-ascii?Q?XCGIjQH7EixBHyBevavltZm0ptCxnDuaQq2F4HwK31WOGdN1GDe3I+zo94Bd?=
 =?us-ascii?Q?jiNHcoy+V75bOjz6LwkW3aLKUdkHyuNG+TVCGQdzdVmj9o2dujkL+CELgn5E?=
 =?us-ascii?Q?+CbbZR68Aemg4XJbf5ZMj/b1jN2Lj6a2sx4/kd5TaMcNpYzhkzFitRegJxTk?=
 =?us-ascii?Q?B0JTn6wrZ9mj1xnHbGgV7663V4Rvvxa3R52+NrfldK0FdPakK0D9nqfkVnZB?=
 =?us-ascii?Q?YhiQQUf2RYxstTBdPKzazSqOW9KAEtmy6UwDsgjmd7/xeajTL5eDvbpNfBKD?=
 =?us-ascii?Q?cD9gKz/jzPHSKzaMHDn22Oyx6Yj8rd80wRQcaSJsmIJGdA0UWnWzHonmr1kW?=
 =?us-ascii?Q?baHAH93zv0UJC89p0ITjoswZvfs4+xa7bqBFDVbeXP640K6U/StNJuuEiRHo?=
 =?us-ascii?Q?AKS9RLWU5XoUddQvrIJuHC1u/yysN3tAZMBI5lLF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d34c03-4d1b-47e2-8085-08dafef69d79
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 17:07:18.3429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DgVbJSr/8Tek/wfVfVg2K1SngS/1P0lJD229knxGAChGI7JbH9YNLTDC1lMmzB5iGB6pGfnQkciVeTrdbrjhbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6337
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> > This version passes on FRED, thanks a lot for quickly fixing it.
>=20
> Great!
>=20
> Can you pick these two patches and include it in the next version of
> "x86: enable FRED for x86-64" RFC patchset?

Would it be better to get this patch set merged first?

Otherwise surely I will include it in the FRED patch set.

  Xin

=20
