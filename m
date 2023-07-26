Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C911B763F0E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 20:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjGZSzC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 14:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjGZSzB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 14:55:01 -0400
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11013022.outbound.protection.outlook.com [52.101.64.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227171710;
        Wed, 26 Jul 2023 11:55:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCDNGgruBK39IOMLzB6Dsoy4P77n7eI4XlRZJ9nn11mcHZhsYbsPYeHsGLMV4d0gPzn+1lpRlBlOSz5jOUFETIADR5tBjiJ+fzNPgK8ZF49+uhI/nf+zsU3ZQDjTWIq9p6GnYleFHU31W67cPe/+xxMYeGxzIwWI++QHSXU1ydRkJSGYwKYOGJzGrBJ+zY7ZkQCTezVR8/ktbcflyFsqdaA4N0mfaI92UEVp9wBkDiSKbh3A9RE53aST1s19WjK9idRK7k+oK6IG+i+CX8b3iBZRonBQdgeT7TV7s6Mb2W6GJLbsSua5Wrs7lO+UOrFhxNz5eh/+5sEwn3hVqA71ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UP7AeeRe9W+Jo0Rh93kIN7oA/+dKakOzZqQscDFiWk=;
 b=CSl0Ac7pVI5OxSkmxCD8sTovN/nvf67MX8hgWP7JMQlX8Bks1VbL9O5V7qX4Z05osCVmvWu0p3tRhi7O6rc5eRVwXr2GLux0YKQ836KwUbW5EWWZ3UXW0ztDEbtTMTnyk1QEjM/fIfCdH5KEs79W4lZmTSRCBoVIbXwSlYqO0z+M17jMA3chih9Ow6XZdj6phf6zQOZ91Dl5kl5Pua9L+JqPG9BKsNuo++VLKegSnpTlMTDYcbBRZqPAyTDmNuShHoxAKusttUOPxx9lglmlCa9o0nu+JeD6rdfDYj+iAMynwe3kBBO7mXtC7WWDs8CRK9lDwQCzqgQf+uN7x+4WlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UP7AeeRe9W+Jo0Rh93kIN7oA/+dKakOzZqQscDFiWk=;
 b=ptrZFJXuMk/kzFlDCXcM06F22kT+zsQ5EAQO5XKwZA+F/L60bGD9m7sqGw2DsSc2mE2fHHf3YOWVE0rQViC5Smq0RuNMKua1KgX7fx+FhLE2c8c/AsdCdGFU6JWylYD/MP236CV2ebWtfiNpanDI1aahfMbr63GAUWSD/Uginb8=
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by BY3PR05MB8098.namprd05.prod.outlook.com (2603:10b6:a03:364::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 18:54:57 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0%6]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 18:54:57 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "shuah@kernel.org" <shuah@kernel.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        Ching-lin Yu <chinglinyu@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "lkp@intel.com" <lkp@intel.com>, Nadav Amit <namit@vmware.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        Alexey Makhalov <amakhalov@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Tapas Kundu <tkundu@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>
Subject: Re: [PATCH v4 00/10] tracing: introducing eventfs
Thread-Topic: [PATCH v4 00/10] tracing: introducing eventfs
Thread-Index: AQHZtX3ozc4V8XrumUqju4s3WlXUgK+54mYAgALJloCAAuPAgIABWruAgABDowCAAEgDroACwj6AgAAIs4CAAHsSAIAHvi4A
Date:   Wed, 26 Jul 2023 18:54:57 +0000
Message-ID: <F4046C54-0481-4C51-BD5E-A46AE3F9B1FE@vmware.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
 <20230714185824.62556254@gandalf.local.home>
 <883F9774-3E76-4346-9988-2788FAF0D55E@vmware.com>
 <20230718094005.32516161@gandalf.local.home>
 <2CD72098-08E2-4CAA-B74D-D8C44D318117@vmware.com>
 <20230719102310.552d3356@gandalf.local.home>
 <899D0823-A1B2-4A6F-A5BA-0D707F41C3D4@vmware.com>
 <20230719144046.746af82e@gandalf.local.home>
 <20230721084839.4a97a595@gandalf.local.home>
 <20230721091947.0df9fd73@gandalf.local.home>
 <20230721164016.68bbe69a@gandalf.local.home>
In-Reply-To: <20230721164016.68bbe69a@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR05MB8703:EE_|BY3PR05MB8098:EE_
x-ms-office365-filtering-correlation-id: 66725b76-661f-4eb4-75a4-08db8e09ce94
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4GlhkBbpJHzat46vP2Z0bCKeCUNne7cZRv/Uw9pcUhdVlp2uqzwEVb6+QQW/v7rBrOal3LTRoCnhg/4xJCUP+EvKm70rFPY0lbYjCWXYZs17vRCUodV2Z56SCsAf6f/kr01vdbyHgSZwhQdRgtUeBp6xx7W4OXf5kbNGI8l+cLQpu1XEOiRvxrlvOYW430yv52jfztT2UoYvUxRaq2BKWmf6bpvdvJfSBrHB9ebzJqFchaI5Oxmy6L+4fL71roYEFIOSsw+BiZVKYjmEREpbLCfOx+g8WMTTRZCIz1pEd2tyz4Kby5xV7+vTxLp2SQ0wrXedKX7SLiPp9b4y/ysx1wPIGYwOpvCkeQSnITPZ9MPeA7nkymSZvFhyJIWTQFmaVPecZwTq5o/0EQHDmKNC4LizCe7BMyf1JJD3Kiq01rKoQGC97F/mbsTUL7ojQXxDSLsmmVm6+JkH/+ew9Ms4OeZqsvG39exftmCvDbEUwDXkTDIx3TXC0miPsKJJjLjya9ZVPf+bUVGWjtLVVA5T+Rrzq/qg2uX6qwSX/4SmKi6n/Bklb2/rXz2+Ms6pe0T8dtnn4wSbMBSlwOeomOIZ+5okjPhiJkMpBPM/F5LHviDigXG1oLRXO9EurNl5nAzzx1q/dNHwutWAxG+caWJ3WVL6SJO1r1sjN7sKX5yNHtC9Mom4KXCoypRX7la32TfXzXnxVI04SWiCitrNaXBcGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199021)(5660300002)(8936002)(8676002)(7416002)(2616005)(316002)(33656002)(53546011)(6506007)(86362001)(26005)(186003)(107886003)(4326008)(54906003)(76116006)(6486002)(6916009)(38070700005)(66476007)(71200400001)(66556008)(66946007)(66446008)(64756008)(6512007)(122000001)(91956017)(41300700001)(83380400001)(478600001)(2906002)(36756003)(38100700002)(4744005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d1zb0XVPVMB0R6g+ZYj7eMBDjLxMnNmfKxFjVsm7aq1d6bKtC8Ua6f8t16yE?=
 =?us-ascii?Q?4C89UTPXwTtV7SbE2o7JeWTgoaUGPO6XN8rdANMawko4XvNIWPuMPZ+h0UCn?=
 =?us-ascii?Q?Upr9vEBScwbvETI0kzJ0SOjNM31G3W4QxNo3bWE5HNrZm01zl3/xftpoF5ig?=
 =?us-ascii?Q?Gpbtxzqb0UpSDz+wVvPQR84RBi+ttgJ+nGdfDAlyjRdl6fN0Ve6k3kowkmj3?=
 =?us-ascii?Q?X3/3wTsAOC7qfuo7jfYorTtEw0ttuUz68yjyrKffNQSM681g/Lj/pbxEFcPB?=
 =?us-ascii?Q?yZhL82/0q/tnSwhzxL9p4iLx1sjy9zh/aD83CKjwN4uQAEzBocx9N+4mG81b?=
 =?us-ascii?Q?MpoMfTH1XP5MdDItx3agmMCb246tj+XrhtTIDfwRnmB8ebvQiA1dMBbgrcFA?=
 =?us-ascii?Q?ar2BVKuo7VUa45g+/lWGWkXYMssj++jqoY91KBCLv4zL0Kuc4yizqiKN47J+?=
 =?us-ascii?Q?s28lN9SVbNjga8Peud2VHvOLnndUCafWLMcN8J0+jre6Z2fuT56u1cQHFE3c?=
 =?us-ascii?Q?lo01TaWwyjIcklRAkqJKSRq6y9TD3vbsuAkF6VhuHM0Dg58xUYGjvuihnutC?=
 =?us-ascii?Q?9Si+MRSsD9O1WNH0A1wPUiOMBR1WnkktwRXksor2Mkh2kvro0hxSn+e453FG?=
 =?us-ascii?Q?1dtoYbihpMdcV9WF/AyiuPFyW1ImNncLA0PlBNitcHgKTB74wXCuDQpBsKnd?=
 =?us-ascii?Q?pvCcXepKFCQzbapFbStndEIaMYQnyUWffXLk0veONMJLVHSk5XfVs6i/A6n2?=
 =?us-ascii?Q?y74kDC7ytdK5KS9fTOkjHQR4umPhrkodSBFCjMwmseaRje/NVWO7RLREBSQd?=
 =?us-ascii?Q?+grcxrRj0kFLoPlpsaQ6btcE2HZDLxZ5U3n98Gjg+QqvHbpwpmDwPVE1D8gH?=
 =?us-ascii?Q?11z2TtLBmma0CuC5gJySS4MDP36paJhw0KOgv4IJMrDh5S9hJVFcmbXo0S3F?=
 =?us-ascii?Q?vcGCDRhmNh2xKZ3DnzDJbHrHzffVcsegZR1KJv7QdxnQB+l6CcMk4IlBe3cy?=
 =?us-ascii?Q?u2Ba0unrAyzpS4xtzHrfwYEXhUWZYUwO7RoZyHEuGDJDamvL7DLPjC2HXG5x?=
 =?us-ascii?Q?9btqCK6a7EtMCdRsMiNFNYTqLcTZOBWKQPV0mMAf6GPBY12cohzLpBiGR/6D?=
 =?us-ascii?Q?5GblVSv8g49qxZLNVTKuiiIA49nUPYo0a6Vs52oREUvXaoRVZuN2xpmjCki+?=
 =?us-ascii?Q?68+fvbvfUp9TGoqC1TdNzmXvrHiCFELhlEviTiu2MkLdwC/yfxQEF+NmPhL6?=
 =?us-ascii?Q?xHJ6yQgFF9S8mgeZo+qkjlRX9YIlcJqGC6jJhhJfgfXkcmi206CwBtWUKyK2?=
 =?us-ascii?Q?i2JM0yjF/2bggXpq30RwJxBsFO53Xh2lYDeHggPUjhv9bN9hmfPGBW/Vlxec?=
 =?us-ascii?Q?ajyKF8a/qhwnBrlyKClWKoEfZW6qP93MJ47e7sQMGS3uqVxUSlxK3+93HRb6?=
 =?us-ascii?Q?BjXFxIg38pf+MUBG8jmPw2EkjKxra6UxFFTNdJybuMZzoFQbGsngXN1V9EEy?=
 =?us-ascii?Q?87I+Wky8zujb+TQXrBaR4jMX/G6/24RShmbdsplfLfK1iT6cNL9jZEYnrEl1?=
 =?us-ascii?Q?h6ATAkWxnxF4ERrycjneKftJ6LoIaXm5F8g1gcZf?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12D6BF9C361F1744BE762B3EB8698698@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66725b76-661f-4eb4-75a4-08db8e09ce94
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 18:54:57.4612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: udt8ilava/KIDJhe9iiGDyOZNdByOLLkTvQGk3BvvHcS63IURzF9QZ6x3fFzMP1uqTjw6ks12FpDDEhPB3faAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On 22-Jul-2023, at 2:10 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> !! External Email
>=20
> On Fri, 21 Jul 2023 09:19:47 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
>>> +   } else {
>>> +           /* A race here, should try again (unless freed) */
>>> +           invalidate =3D true;
>>=20
>> I had a WARN_ON() once here. Probably could add a:
>>=20
>>              WARN_ON_ONCE(!ef->is_freed);
>=20
> Yeah this should have a WARN_ON_ONCE() because the only way to get here
> with having a dentry and the ef->dentry being set is if we have two
> dentries with the same name in the same directory. Which should never
> happen.
>=20
> I think we can add:
>=20
>                /*
>                 * Should never happen unless we get here due to being fre=
ed.
>                 * Otherwise it means two dentries exist with the same nam=
e.
>                 */
>                WARN_ON_ONCE(!ef->is_freed);

I missed WARN_ON_ONCE in v5 06/10, I will add in v6 06/10.

- Ajay

