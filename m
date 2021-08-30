Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F723FBEF4
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Aug 2021 00:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbhH3WWh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Aug 2021 18:22:37 -0400
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:47762 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230140AbhH3WWh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Aug 2021 18:22:37 -0400
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17UMLUIO032066;
        Mon, 30 Aug 2021 22:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=KSxTjHd47qMwDMbOluyCsWiUUcjo965C8pNK6QyIo6c=;
 b=lbbHWlMz/D0PZ8qePudQ4LIyliBN20csh5zlKdQc95j+QzIoXSwBYNTN7aYdInCsN+xn
 IdsGD+xEN1e7j8XR+dotW8/N7aD6P4FQZStYw2pvtx3skGd7oSvY3bMdDBml7V/wxISC
 H+8Dgo0n7zdEvNxMPDrMTzlQGJihW0u/Hgz7AlWvmRoEiBC1Sjzkv3+Zd9W72gUbgaR/
 Nr+FOhpfsoXVf1UPxyrFYWZ7gw43mnTlMzqIdePCopTddyz9PzQd3bqKg5Q5IatMOn1O
 8yzXPnLywlqcxgl2DRUN+QrKA/YSdAxOBoBjRGpG/jHWevluvHtCjvh/ztEV5rigQ6Gd wA== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2049.outbound.protection.outlook.com [104.47.56.49])
        by mx08-001d1705.pphosted.com with ESMTP id 3aqf46scr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 22:21:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3voNnNQ9H5TY+FjA3EW/r8c0Da96fjwPHCa2aXH/nrtg+nyWND2eW3BrtCO1bHu9/gFB7nh+7dRhefXxCFdt5dBOsnyQBYbOFnNCDXJDQbo/zEUUtZC7IkRbmdqmU3yhl+grleCA58LiH9RNtIdmL4PNNWhMftEnpptg7ptqXCflD7vSY9sO/4kNkPQXNWSKaXxOvcWiwFMvdxvrIhIB2Ge8/NHt1p+nuzD+ZZhYkiUFxHZzaUpnY/mki0wTObisZn26c+IV4RkgmVs5LdEYWFhbl2fc2MV3eoXDPq3Orfp73WokpwwGbp4XM5q3oMSH6VUDa0qxC/tXiRo5XIMig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSxTjHd47qMwDMbOluyCsWiUUcjo965C8pNK6QyIo6c=;
 b=grh/J3d0WVbTZLsMt4+6EWk5TYHdYeKBu3mH5IQBy2UPLbMJ8WzIxv9irVo2/4fnjM4ouqm62ynvOagEVsjjsQbo5X6Vhv4Cg/z7Mq/zjEyU5xeo7KsMY79jgSmiZ4CccsycDP3cqVytfpZCfOymGqVhuVDAkiGDiJ3y7S6TsDxED2YyUPcVfdvuziYEEcQ0Ru/jxkXck+1EJ1sJWS6C13dt/NAfGepayPflt4Heo1beYRl5MVaTHjimVlRTRk24+RtkwuHkTi+9jezvyVuxpgHNlHhyzk0sfF/fOsGpcIx0FCojmb+PDKMj7jxb6UjvvGl3Pm+lotgOq+dOw8ZVxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by BY5PR13MB3666.namprd13.prod.outlook.com (2603:10b6:a03:22a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.10; Mon, 30 Aug
 2021 22:21:26 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::5190:4162:72e8:7998]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::5190:4162:72e8:7998%7]) with mapi id 15.20.4478.017; Mon, 30 Aug 2021
 22:21:26 +0000
From:   <Tim.Bird@sony.com>
To:     <keescook@chromium.org>
CC:     <rmoar@google.com>, <brendanhiggins@google.com>,
        <davidgow@google.com>, <shuah@kernel.org>, <dlatypov@google.com>,
        <kunit-dev@googlegroups.com>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernelci@groups.io>,
        <guillaume.tucker@collabora.com>
Subject: RE: RFC - kernel test result specification (KTAP)
Thread-Topic: RFC - kernel test result specification (KTAP)
Thread-Index: AQHXjj7+R2tK76sch0Cg3jcbmYTJxauIrqsAgAOyNyCAADVlAIAAJTYQ
Date:   Mon, 30 Aug 2021 22:21:26 +0000
Message-ID: <BYAPR13MB2503A8C61639B2C25358F03FFDCB9@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com>
 <202108272330.AE55FCD@keescook>
 <BYAPR13MB2503A4B79074D8ED5579345DFDCB9@BYAPR13MB2503.namprd13.prod.outlook.com>
 <202108301226.800F3D6D4@keescook>
In-Reply-To: <202108301226.800F3D6D4@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=sony.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1418cce3-60ba-4af1-825e-08d96c0481ef
x-ms-traffictypediagnostic: BY5PR13MB3666:
x-microsoft-antispam-prvs: <BY5PR13MB366632D355CE907F4BF59028FDCB9@BY5PR13MB3666.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1AO3ngSf4AmyEpY7C6++NWRZCylgaXX/iA4zrB3SkblZeQe/j0qjBCCfREj2qT97SkTF9vJV/XjzK4eFszqANdnnSWSkR9VQzgeyEKQKJM0i3KSyFTDpWBtL2i4HyHLkWPt0RFbyNEN9JWE4XRQJmd7adITgReQ+cP5KEvrCJuUwq1NwsiyTr8qKI0PkcA1zPghdlPPU3prnMefGZyHZbqABKTIzeCZ2HVDwpv3/Xb0sDFreBrCi7ydfn2C65Ff6aR6tzHJj7cBnTxHnA26+EfMdot3sK414nO/TW6q2sH4rRrqOdPy+4VUDbhCiYDGbcOImk26Y8sCDg5tR3E/9Ny94gIELqv7TxErA9m1Nx8G+FugVoqnOc4kOB9wXTTcU6PBxR9VciYwWO99/XEC+d03txtYrps9TYZKY50vazOJgNe0iJzLzzZtdg1ipp7nIvvfWI3NghiaS3QO4rwFPrZJcyRo2WapgtQ33kcMm8x1bid/mmUDU/PgRVjZZjDknOpSQlUfW9uKH30PCBGT353o1hT09zVyDAZ6NJU/OqIjJw1C256kHDbVHG9r1mCkrTdswo4rs155mHb2vVMiHuVSeIDJg6R7H5c2GriG3rGlAjWO0POP99dE29RBT/DW6wjM+t+9+Dkz4rY0M8koqb8Ts4gUZEvHV7n7y1g4yGOyGvSKwQIb/dsW5vshXCN1kvjEgBhkQvKQoIOicPO9uOC8uL3uzW9uxj+/z7n6WHMyP2mtXz/YbNJ4Kdd4hesC68A471rGqyOT91fWxwRznKlR/+ncZWkmBoCJSI4cX+gk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2503.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(316002)(26005)(7696005)(5660300002)(4326008)(2906002)(55016002)(33656002)(966005)(8676002)(76116006)(8936002)(66476007)(122000001)(54906003)(86362001)(478600001)(66446008)(9686003)(71200400001)(38100700002)(66946007)(38070700005)(66556008)(186003)(6506007)(6916009)(64756008)(7416002)(52536014)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KDiC2tgAIUIg3okmA51oUUKq3n3t8cqxlMojEqr+jOlisAJu/SYYyJoWXoFy?=
 =?us-ascii?Q?37NM1228ycBf3XT5JiFMJd2YFEHcd0kElQYX6QrmW1gieJROwOJs3X2pLquR?=
 =?us-ascii?Q?WXfy7Dc5zr3rIsDkMqGFA9CLYVuqhEJuXGrQ9i+GRcTXyRSOAxYviHbGC81t?=
 =?us-ascii?Q?ELMYLX8KsXMDe+FReMoal2auZhgvfJYwJ7IVKd6ZCrELz5AenSKfGdMbgYu0?=
 =?us-ascii?Q?+NvXXQ6JvW3Xk6/EMgUrtn5XEqyNIrz6y6c0JFqeFt+BnfjkoJ9FdE+nQf1f?=
 =?us-ascii?Q?DfCx1h8JmPLf2qWzUVmRdBctAc7OMEHTmzDgnTdFdy3d9gS20gMJBhdfKmKy?=
 =?us-ascii?Q?USQXJFGBFVfhBdtTzpQ5utQ3Ng6WO8gCrMT7nxr+id07NGtexbtBxaT3JtrY?=
 =?us-ascii?Q?zcdW5M47jO5W+wAJMgI3NlbvmHv27X/cad2DXq4VVYBT888XDEhuTQsgPf4m?=
 =?us-ascii?Q?/zPfRoJs2PbRf0YeInbygqT2/zgIc5qI5Y+2m4vlQLVD+Wdj3RREP1BHlmQd?=
 =?us-ascii?Q?FKc0M0wtwzJjzQVkUa/exJ4ibFfHyF1ctlFESgLOEQ0XsYraRzcwhaJnaZ8v?=
 =?us-ascii?Q?PBn+NiOCR3X2S/4XBlhAoe0A5PZZ2aseoD5x2ZfQWL/l9wGjOmMIO1ktgRQ6?=
 =?us-ascii?Q?Qma382AFUgWBtsWJxh0/EJ9SChydy3I3cgz1ey+4a48rZe7pKPuMMJgJ0Sn7?=
 =?us-ascii?Q?zjm0VrA1dRFJI8vwFA5HyevNAfcK7LbxiRlCKaOCuARhm26hr4r1DW3dmkxN?=
 =?us-ascii?Q?BAhggR7gZ9F36QIYdjIqnqY2882rqdKXws2e7hvnYRzLr5Qu8JHDbG0IELjw?=
 =?us-ascii?Q?qBmyiMGQ/DNhM1XhOlO00b1O3nN+niGMciENiRcEZL7R5QZSwGmuE1K++9oF?=
 =?us-ascii?Q?x0+uDUmMPGXoKojmKRmCTtawLwSWNXcwExYXwUhXisWApmDC92shz2lh5eMF?=
 =?us-ascii?Q?LI0vrx1v2z50+Kp5Uk1ibGsfoSjs7zf4+NQFSq/r54Kzd5NqREHYT4m0kbEq?=
 =?us-ascii?Q?mfyG8Bhxu8gyreKeZB1Gg8AOnXrBztwB/KJcmjbYc6fXR854lqNFANVr80Ni?=
 =?us-ascii?Q?tZ8d4AQ425SkU24o06BYX23UKgAm4jduU1g0wwCri9KPaTMjeyd9M1r02JoG?=
 =?us-ascii?Q?PS1gPVCBuLOGExU8ujRseOyD10rGzpBz5vYlov1fmtpFchd6R83g8UctKCLZ?=
 =?us-ascii?Q?9DFdzTX4cBxkZduM0+fcPPz9XP6lwDScEY9HEHtb/O5qRBzJsw3XKxsWaGxL?=
 =?us-ascii?Q?KjAl1jRVXSXAtRKCKS1R4qRMcc4JD9pod/N+GbcLSmNDCIaSppSnlKtcwn1o?=
 =?us-ascii?Q?gSE7vCpHj7ltmkr05MrNSu75?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1418cce3-60ba-4af1-825e-08d96c0481ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 22:21:26.4022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: go1rlRNdsrarQYSMeEVSqVmYpUYEYybRYxRyPwiFaqy8UMegqUSHTFEgFLtsmYjeTogh6PmstLsEvYOrtfk0TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3666
X-Proofpoint-GUID: Qe9QhCF8xMgOEe4kVA9GU59Mc6uZKXrR
X-Proofpoint-ORIG-GUID: Qe9QhCF8xMgOEe4kVA9GU59Mc6uZKXrR
X-Sony-Outbound-GUID: Qe9QhCF8xMgOEe4kVA9GU59Mc6uZKXrR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-30_06,2021-08-30_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108300141
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: Kees Cook <keescook@chromium.org>
>=20
> On Mon, Aug 30, 2021 at 05:48:07PM +0000, Tim.Bird@sony.com wrote:
> > From: Kees Cook <keescook@chromium.org>
...
> > > Yes, though the optional "- " is strictly part of the optional
> > > description.
> >
> > It's mildly annoying that "-" is optional.  It's trivial to deal with i=
n the parser
> > to just ignore it if it's present.  But it has no semantic meaning what=
soever.
> > IMHO it would be nice to either mandate it or remove it, for consistenc=
y's sake.
> > This could be based solely on the consensus for whether it added or det=
racted
> > from human readability, since parsers don't care.
>=20
> I have no strong opinion on the "-". I was surprised to encounter it
> as it's not part of the TAP 13 spec. I would prefer to drop it, if I had
> to choose.

The TAP 13 specification does not mention "-", but a dash on the result lin=
e
is used in most of the examples shown in the specification here:
http://testanything.org/tap-specification.html

In the top two examples on that page, the first one does not use dashes and
the second one does.  It's kind of irritating to have that kind of loosey-g=
oosey
syntax in a specification.  IMHO the syntax should be more strictly specifi=
ed
than this.  I don't have a strong opinion either on whether to use dashes o=
r not.
But it would be nice to make it consistent.
 -- Tim Bird

