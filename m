Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D855E67B8CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 18:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbjAYRsO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 12:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjAYRsN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 12:48:13 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDEB166F3;
        Wed, 25 Jan 2023 09:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674668892; x=1706204892;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+0G80xp/Ky5PV5IZLX3VGTLQjuh5OTsKqEFgeQYe3RM=;
  b=F+Na5cOSU2G1ks0l47pLWl0UiyxnkOdgdPlVQfS9crESQYWixk3bJ0QV
   XzBRIJ9pEOJnMtKvBsy8cQm3eNBqgLZPqIy8o+FXcHWKmdUYWmLGQJ1sw
   hXLSXeooLlbjhJ5uUUbpL+DQ5udZ5VbtlM7gE1mdlEsjtMY8D6RHXAwf1
   Sgsy78c+Xulrt4IwHrJjcozbGMVcGLPLstquaunoqyEDzYTPOHSGNW8es
   7EGMHwDPwCBKpaxGmZRCCMbdvPazL3ZDc7O3XdTXe6YET7CIN9EIkjuiU
   iTZpPDtL+DXpOWMoEF3ZbGH7ZoYcJ0j2ahZH0zoaWD7V19J0CdasVDdEq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="310201297"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="310201297"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 09:48:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="751293834"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="751293834"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Jan 2023 09:48:07 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 09:48:07 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 09:48:06 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 09:48:06 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 09:48:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+QDvdbd8gmGwzab7B14mDSEMH9E7v1rmuLaIS8/TZoWDwwvZ+BJzGtNMjBGYJM+bPiOwe7qoZ+y9E7yO9Lrj4t4CcYbcKHNLNS+w0EiHfVKVTj4u2JNFjNX1O7zkNMDvhJqb77C8iFQm+9id3t4ceLkdU3xISaNGd/q9SX75R7+ZdNGsoEYJHCt0cYFUqARZ+jTOQWevuhgMqF2nCQnlDzZ7bSS08EheCwDuyY5fP07XGDhLGrkbtJDpRum+N4YHoici34LPcpjyANyAoV0WTti1O8pdUo72SG0z9oD8DnH9QIDZY90Xd8OfRlJqsDYT6szI9VNkcSFX5IKKrBVUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0G80xp/Ky5PV5IZLX3VGTLQjuh5OTsKqEFgeQYe3RM=;
 b=IxLIeesNKLGJ61UMQ9pRNOPOACSb9y9GPFIX/YbHHVCT/jPjMsBCqcefVQH1VN4AD+Ap3PqF0DYDM5F6GZ2kgfl6Y/R2durKUa82LBhr+AncFBJ4t5HHToxPxXdhdgEiqO50FfYuxPM+CtrHxn1WMVOMCqqRoI49ZZCh/i53mYzWOmL/TdEUebayz5vymslKhwX62knlDzku6MLwXFKee+SElFPESO5dA87wzIMOnXgKHg2cKsw9GE3zDe0pjZF9e0Nz5DfFLezzuV63KAin8Czfr6+5WPsEMCBX9MzqNbHhSOpe2kY9Us8064zCVP5alX0IX6ROAgMVOjyPfki9nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by PH7PR11MB6554.namprd11.prod.outlook.com (2603:10b6:510:1a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Wed, 25 Jan
 2023 17:48:01 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::59d:4c93:47eb:9811]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::59d:4c93:47eb:9811%5]) with mapi id 15.20.6002.026; Wed, 25 Jan 2023
 17:48:01 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
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
Thread-Index: AQHZMHAoqvs/lwdyjkiVXoNdsc7iCK6uxqlQgAAHsQCAAI69wIAABdgAgAAErQCAAABvsA==
Date:   Wed, 25 Jan 2023 17:48:01 +0000
Message-ID: <SA1PR11MB673454F82DEBD8A1C7009C79A8CE9@SA1PR11MB6734.namprd11.prod.outlook.com>
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
In-Reply-To: <Y9FpxEz2+LJc7vJP@biznet-home.integral.gnuweeb.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|PH7PR11MB6554:EE_
x-ms-office365-filtering-correlation-id: 8c89b223-1348-48ee-3a68-08dafefc4dc7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EbzK8p6zVcoPOQRBdfZsBvB6yzMcSY31N6y0ItXEw5AYYZYPdjzFkxHUSTETE1tBOCAFNVwgU7XGY4ChFoOX51Atm+g7ahf6k0r8Ztamwg3R8TywxWTJdOXiY3fuUhzNWs0JexjC/e+yw2eH8PRpamaaLSIeXAsrUGJ8uZuXpRUJA6VHcD57YmpIJYBewsnytGLMJxFtopAw041DdjjoBJDNMBnUUGPRhj3lijy6MdQkm8SnEGJ9P8BZr3fyqomO3aoQOqPXQVS4cL0z1yOFNFJ2Ht7Kvev9fdp4DJ3G8ssImHBZk5Y+P67/rn7JubqHTP5phGL9RapmJ2ArXFOtJoAUF8AzWWALQodyM15qnkqA6znXiXdhO+rj0AZmiGbtfYL1n8PMCKKIw7CgF4xjqTzLIM11Tobl6ZJ771FvXBJDQ+WCN4WgBEqk8kQOlUkCFNo8mNBosPn7j3vzDhTsBprkNafi/HkWiAgkK31GancKDpsAXsFrasPBdBr89GJrtFFu11ozN0utQH2pmAsVsEbOBNtKJh/o4WKsFiKQXN6Jmvuui+Fa5YaW3ujgwA1UntGgTPGwWN4lFN6z3SfcKWXgnP6ENHHuxSahb9OMr9OvFpnzRAIBnEqc/GxW3JozpxjyfgFpIYXMTFGJ2uKNVxSRgDfEsjZNoW6kxyZY4z3jQMRO9aJXpXp9VuYIO+c42dTbxihGh62d4RqRCxSBKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199018)(7696005)(71200400001)(186003)(86362001)(9686003)(26005)(478600001)(54906003)(316002)(33656002)(110136005)(76116006)(38070700005)(66476007)(66946007)(64756008)(66446008)(55016003)(66556008)(4326008)(8676002)(38100700002)(41300700001)(52536014)(8936002)(6506007)(7416002)(5660300002)(82960400001)(4744005)(122000001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1x443KXDOtjC3Z6sbPHVM1R8BZB4Z8JPZ4XTAYsa61VE8Nu9E1RfdIxEGBkB?=
 =?us-ascii?Q?ew75klI2Uk17RcAsgmm/srd/je2AtWZmIPtz1hOWC1aUcVsnJ21p2CKGFFee?=
 =?us-ascii?Q?3IhGWri2EUuW//syA0hzW0SJRullqwOdNVJu5b+kD5f2rto4uFEpcL22KajN?=
 =?us-ascii?Q?CssJzVbj7QQlIacR5JKZ2wQHpwS0UAy0r7SzhLwXwvrFcmNw/RNuIvzIe1OO?=
 =?us-ascii?Q?poZ6rQClYD5mdmKDbAkPcVVSxuE0qWxXqqYtPC6CFkvhoek18M4etVZpS2p7?=
 =?us-ascii?Q?EJly/2c54Y1ky/wEggjZSpGDhSaIlfLVVZieFhbi7qdUNf/jKDQ3THPRoaIX?=
 =?us-ascii?Q?BWXeaY5RqP6T8jU+DLp5mE3rIhGihNvK/SPX5U4b/kl+FGqdwFUrUSiO4YNz?=
 =?us-ascii?Q?Wqb9fdlP0WUXnuQs5Dp5TdSkCSC1Uf/Nxm5J9LEiF384qtzss3qlXZ0oKvYF?=
 =?us-ascii?Q?ku5UQhaEW7RDh+BkFb6zoE2JC1FYHT4FaWc1C35KGmF2gMn7H+ATq84VBIgI?=
 =?us-ascii?Q?7S4dxbJzXZhzjrtRAE+0ucvZz4/+J1uOoAc2fSmE0RZBuS74V+cWURaz39X1?=
 =?us-ascii?Q?vtMGYDdFO9FbspeCQqoViaQ3ZiE9P2B9kxui36gfTqO2bSa+SKkeWcZvPnF9?=
 =?us-ascii?Q?DRVMLardQS05HUskSpHF5JLuWR1rn9IEI+kidTuN9cr37IZqPfJPwH8Dl1uc?=
 =?us-ascii?Q?nXglAdqQdZcqIqVSKbH/OqEISs/KHSmDCkT9j980nWxQmf4+KSKGRWuBcKhW?=
 =?us-ascii?Q?CHLrqhQGjDpoqynNLvx/PfuQ1ziQXSDio4YtTg3kCcFCV/Dqt6L+9CfDLs+k?=
 =?us-ascii?Q?DTP5ub3IYjKjwPGyLkVqVdr5+xnIAo1QZ4AqgF0tCjP3c+c4fuZGCx+mNozH?=
 =?us-ascii?Q?GYXZEvsk+t15AMDrwqVF5cThI49Ba8+IqcMDNEtA7opV6lxRyOIy9NNvshSz?=
 =?us-ascii?Q?4OgFLOA2bYTLEjosdF8ds4PKTSdHnfFCdGuZqW/Hq/2G53K09UdkNSTrgIuk?=
 =?us-ascii?Q?I8wbgbC59BG/NraIB4bx6TIxXM6rDUejFWR1Y3PwxJFHm+z7jNlCl0gkEmuD?=
 =?us-ascii?Q?HszlQuMkAUyd9LCHoEDEnauhn5hUP6zzYT7P86m7RBexre4neU2n9ekNItgD?=
 =?us-ascii?Q?6qbbk3UbigPlEr0g+O/9/jhiogmZBaGWSefQi4QeSf4k+2E3Fv+wOPRSel8P?=
 =?us-ascii?Q?VkirosuJlSsDyo+DQ7hi+05NlXq4Xti2wQ183DX3x7jhcRAaDhh2+18YXJoQ?=
 =?us-ascii?Q?1C1813ZSLLrN0Du+BPZ6pyZEd4iE239Z8ggmmq5bahRSHMJdFzExR85XmQBb?=
 =?us-ascii?Q?MwiGv7EgOYnPsw9DWSTzVbiCQA0og8iYmZP94Wbk8n+FNy4Gl72BzRAB1lGs?=
 =?us-ascii?Q?07nVJjy2pXNfGMUE5lU1YoSbmXG4e2g0EH6/gIM0b87feZFGPxa2uYNdY3uY?=
 =?us-ascii?Q?dqHsYE42y8mcSdhT2hLbPp71zGee2aMvo+s5XgMUNF1WV34CeHltXQD/x83Z?=
 =?us-ascii?Q?X1hswkITi8BtexUzpFXvJD4pT7O4PfW/c7VDu81dsW9EW99kZoCLS0xzWBec?=
 =?us-ascii?Q?Me6xuvOSs0ndYkOJTDDCTxqaQunJMGLLcMLojRXz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c89b223-1348-48ee-3a68-08dafefc4dc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 17:48:01.6150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WiXTFAG+xjDEzUJdzJU+IBWAd0kaGZIrG0qJ2X28sllo8I0edj4MuMdCp7CggGTW1uvvyDXUZokI2IjM/Nl26Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6554
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> > > Would it be better to get this patch set merged first?
> > >
> > > Otherwise surely I will include it in the FRED patch set.
> >
> > If the maintainers are ok with it, it would be better to merge it
> > sooner: once we have agreed on the semantics, which I believe we have,
> > we should be testing those semantics and nothing else.
>=20
> OK, let's keep this patchset separated from the FRED support patchset.

Thanks!

This patch set first makes the R11/RCX semantics clearer, and it BTW fixes
FRED tests.

To me it's more of an improvement to the existing code.

