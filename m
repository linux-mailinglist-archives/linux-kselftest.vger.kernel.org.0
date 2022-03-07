Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7D94CF32F
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Mar 2022 09:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiCGII5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Mar 2022 03:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbiCGII4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Mar 2022 03:08:56 -0500
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8370413E8E;
        Mon,  7 Mar 2022 00:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1646640482; x=1678176482;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HnIgP6LiTzur1n2pCiCBbAvbOdZEfS0CqEHcBuH0cnM=;
  b=VW23kc0CQtO7YQjmK2vPeXay52a49hMQ8EIkS5NU+PLZ2cfLddv1zETs
   7UEdVxBwwURGsnbP9Y+3bGKwO6chE4fZcdlnXTD7GzDiV/zpZw/0Vm0f/
   CJro0GOOJvk6vsi3n8gGbGH7DEELuGziRHZaL6TI5scHAuVwSCoVRcnVK
   XqGX5+pwP0YgcofsHtRp6RAySH+Xnd76JWRyEWGZsKExgyLbv8IE8Z2sp
   kzR3pfvumWfD0M9M6pj7DTSCorH6WK1rWCsCN8vKOCYrXiYjpOBk5hsti
   kQAH6MsP8vdy2CH13LPJ8pOuDmqvnVwaPUyqUuksi9DC7O4ObYpqibsHy
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="50954611"
X-IronPort-AV: E=Sophos;i="5.90,161,1643641200"; 
   d="scan'208";a="50954611"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 17:07:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZ+WEa73UyZvMHGc9lf2aGo/nPPmvF4mA1DM8Zmhq6LlICyrKt4TcIOYZ9c3xjY/vnXebmdsh9aFkumIQ6zip5xJYuP5H7q3E3pVSi4kqA/oCwcPk4H1oULeZEWhzzExSCYLYIfAR/1BkJ93kM/cqAlvcIj1IosgDbRYuPmeQkfSVe72KKvK5b8dGblys70soqZjrxu/N39Yo0gvwAUUXb0EVum//BX7EgFOSJYFMtxaUAtGkux7crfTk+WyM2od6KMJ7G3yVWjg/asWu8wY/tQSaK8u9cWvn5z1J7djlYWwNpl68rNfA6GrivVyv8ud7Iz2vtCMeubU+Zt64mQM3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V38vo//KHXsK99jIJnfOdGasrJBzGp3eDtemCRa2e90=;
 b=JpYto4s3k7ph8L0nRWlKKnSF3JCBg2Q3o+7NijsOKQIw/kJmTu2poevC9I5jOzb7fK1RXdYO+8npt9v0rJwI6aHK9Tj/1DvfSo4XBh8C2017pQtlp0ggtGIfPu7GcNvfYME5kymfVPkUB2AMEqMSQ7bAi/l8kJXAjFx0O0lToGuULOyN9JTiigATdDGx+OprFSrwyYqHaVIJ50416h0JapbZFE9bOKdazlSx/PmXcseu4r6FXIwTEtap5KYfAIYvkdmr7sQ/EsafnypG/iWq3YasuNEOzLiLI90mLDMj+BG6sG0Inur7d5T/sSR2IGx9cEZlqx35pbYlai0NlGlmZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V38vo//KHXsK99jIJnfOdGasrJBzGp3eDtemCRa2e90=;
 b=UrMNNSbblYcDt5sZt0KmTxCFOAxFy0/AOEI+dTJbcKLUz5Z3oz29f9hvFJDLQ9q37TGBK69YFIDveFPBd26O099ps2eFGG/JYbSNpjru7cdN4PYnsH3mhgNCN1JQRDUD955V0sWIsU/QJ6wNdEJRFa0sAg7WCUicqO1UfSV2qYU=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TY2PR01MB4363.jpnprd01.prod.outlook.com (2603:1096:404:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Mon, 7 Mar
 2022 08:07:54 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::bddf:b81c:fc55:3bbb]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::bddf:b81c:fc55:3bbb%7]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 08:07:54 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Fenghua Yu' <fenghua.yu@intel.com>
CC:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v4 5/6] selftests/resctrl: Update README about using
 kselftest framework to build/run resctrl_tests
Thread-Topic: [PATCH v4 5/6] selftests/resctrl: Update README about using
 kselftest framework to build/run resctrl_tests
Thread-Index: AQHYL7QqKoska4eGwUufPkuEBcTOSayvr9SAgAPkhSA=
Date:   Mon, 7 Mar 2022 08:07:54 +0000
Message-ID: <TYAPR01MB63300F931E2003DCE16276338B089@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20220304103834.486892-1-tan.shaopeng@jp.fujitsu.com>
 <20220304103834.486892-6-tan.shaopeng@jp.fujitsu.com>
 <YiJ4YM49fFANO9C2@otcwcpicx3.sc.intel.com>
In-Reply-To: <YiJ4YM49fFANO9C2@otcwcpicx3.sc.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-03-07T08:03:51Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=3ac817ef-e190-410f-b7e9-4a4fb5b5ae6d;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9243fd7-e815-42d3-546b-08da0011954a
x-ms-traffictypediagnostic: TY2PR01MB4363:EE_
x-microsoft-antispam-prvs: <TY2PR01MB436397DBA4897BABBB0B36EA8B089@TY2PR01MB4363.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CHiX7tXbZ7wjw7kYPJqX0KlgJIt8sJUtSM6/XLhIyxOAss6/o0/1cxfY/G0oVNuhC7+PXS2MGQ+BV9krYsYFuUvVUU+i7vCWqDuOaPy5Hkk7/V/NPrQW4LWcLUOtSY1KVQlAsGWHzdVE35GReUS6PI4HB1GMTPEKSyXWb75rM+SqPCCLDCx50Ou+iPGxpSB/x4XwbpSSqdQgEdfgzg744tMYatKJFtkFNvLjP07WDloUwMVpbX7vt4523o8gFDLLcLcOVB+81pqPs2UqCLFU8jrV9YF+BAOsHj0p9d7c2RTbOhtM73scjmuGQQuogv48r0AUu/MAlPBair8kYJS5G/pzrXKwpT9ALtHL6dDzQ81G62eh8YDQQnTtUddusnVww1/MXJvq2PxA8oLEl7bAg43lWoKzOyrEhS9lgAIQPQAJiK4CPBg82OFwUN0bJvt92NRM4TDqQz0Mr5Kd09HeKPGrFXgIbgBTK8YCLjdoDcrvZI161jxn7WLub54qaeol90F9WH5U0UM+IR5DUSZRQpv9NAPlYomaa5ndAPmhzeNnHw2SFXJRKCJVT8A1hs1eCsr+MNpj6WCoQfWfZP+OmbYsQCZhPKOpDWmyfAr5sfZDbmOmoT0BBNbeVsRIvKqyNCkyhRlUjIhpbQEHEJzkjIQFLV4cFk/uLk8zIEvokzdKv9Mo2gbPcoROWNpeyuQwZQDZMVSI0Y1IdYevMop3vw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(86362001)(38100700002)(122000001)(2906002)(66946007)(26005)(186003)(6916009)(54906003)(316002)(8676002)(66446008)(64756008)(66556008)(66476007)(4326008)(83380400001)(82960400001)(15650500001)(85182001)(7696005)(52536014)(33656002)(8936002)(6506007)(508600001)(71200400001)(5660300002)(9686003)(55016003)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?RVJIRi93NTBzRkxCdlVSNUNDR3hEU3Z5WXkyQ2N2MUNCNm93RmNNL3Qr?=
 =?iso-2022-jp?B?ZlY1bmZhSVZvTEJ2anVLZ0ZuMUVLVWhnQ2Q2SjNPY01SaFRTQ2dWKzdx?=
 =?iso-2022-jp?B?TTV6TDhoeU1VVkFOTklOOGRSbEs0RTdOOFFZSjVhSFI1Ym1zS0VWMis4?=
 =?iso-2022-jp?B?U2x2c1owZ2F5OHl3cFhranJKamdwN2M1ajlaRTNwMnQzWVZpSHcwQnVF?=
 =?iso-2022-jp?B?YmMycDBydVRwNGZLYUtvc2ovaW9oQ3EyY1VwdFZ6RjMvbUtVTERvZHF6?=
 =?iso-2022-jp?B?RGV5RzZFZzgxWThwa1dzaWhBMGM1d1VkTWJyWU1uRitXTFFtZ0dYVTlL?=
 =?iso-2022-jp?B?QWUvR1BnRCtCK2hldllNTUQ1bzhwU0JaS2Q2WGJLNkpWZzdNRG5JcHpU?=
 =?iso-2022-jp?B?S0twVnlQdlREdEdWOHdjajFOcjBFRzloeVYvdEp2ZXdhamd1ZXl6STZ1?=
 =?iso-2022-jp?B?WGkxL3lkY1BXa28wbFdYYndMbUJFaU9IZm1VWndWcGJXZHBMQkREbjVO?=
 =?iso-2022-jp?B?ejlTVnRPelpxeDZWa0RyZzF2SjBpaFI0MmdFeSszNkVjNWdJajZiN0V0?=
 =?iso-2022-jp?B?dEV5K3R2b1lPRkZZbDNjL3VkaHpLZXNNWlBHOXBtSUM4TG5acnZXMEc3?=
 =?iso-2022-jp?B?RjArYjFpOHF1WUZ3UW5kQkw2cm9LUHcrTFFMTFpuOW11SjdxaTUrWjdT?=
 =?iso-2022-jp?B?M25pWXl0OFdZa0gyeU1UMi9mcXRiSjI5N2gxQndIaFNQRTM1MXZnOWgx?=
 =?iso-2022-jp?B?UlN0NUNNdUN1TDVmUXRkTWtaTkF0SEJpRSt3QWgzUXFJNEIvM0ZyVUhj?=
 =?iso-2022-jp?B?cUQzV0trOHNRcjdBamMxcGV6Y1pqUEFZVXp5ZkxIWkluMWJXTTJHVUVR?=
 =?iso-2022-jp?B?OGZHVW9JYmNxYXZldHQvWHJQMDFmNGU4bGo1K0ExTHZJaVV0RlY0TFV2?=
 =?iso-2022-jp?B?WXpGa20vNmUxOUhOK0lpcVpwdmxoY2JwbGFqbFBkOHRUcGgyVTBuSTNp?=
 =?iso-2022-jp?B?UDVHVGlyMXU5eWVBeElUSGlmdzBINW12RXN6Y3h2SDJpY2ZsOVE5aEky?=
 =?iso-2022-jp?B?SmFsTlVaMk5vWEVRcmZ0bnhMbzRCNThKZ1NHZE94OG9JTi9YczZOVTJM?=
 =?iso-2022-jp?B?Qm5CUlRQdVo4c3BwL1R2MEdFTnJHTEtwQnlVcVhjb0xwY1hQTUNYOEl1?=
 =?iso-2022-jp?B?RWNSUXF4Q25xeTVlRFF0MXg2a0x1bEdzY2Y1N2psdVBpbmhoaVlqYUZi?=
 =?iso-2022-jp?B?Q1JacU5zakRRVzdiNHpJRi80VFRQT0N4ZGRINGtSOEQ3dHRRWW1OMHNn?=
 =?iso-2022-jp?B?bmhBTXY1MjVWTGFtRWk0YU1UYkJJdkFrekk4aTc0Q0lzV21DQWx6L3px?=
 =?iso-2022-jp?B?SU5QOUtaTHlQaUh0M0dtMzdyZDZlQzk1YXZ0cUdHWTM3L3NLQUliamFw?=
 =?iso-2022-jp?B?MlFhVTJQakhDWkFoQ29iL0dDR3k1eTVIUG40RXJ1Vms1OUZHZWVSUzdv?=
 =?iso-2022-jp?B?ZThvZkdFSVdpdi95MmhuQlNVYkNMaFRTODk4Q204bTZmL09RTjBCeElJ?=
 =?iso-2022-jp?B?K0hvcU9lUkY1NmRGTmFBS3NTMTVoTHlMQjFLQTBHY1o3a1ZQdGdiV2c3?=
 =?iso-2022-jp?B?MkNtV2FKT1J1eGVzalJ0YnBIclJpUkpHQWY3MDQwT0taQ1RtNTJGZWNx?=
 =?iso-2022-jp?B?bEl4Z2MyaW9SRXVOcStHV2kwUmNHdkxVS29WcEx3TkFkbzM5Zjd1a0hZ?=
 =?iso-2022-jp?B?VTZVZ1FDU1RVN0xZMUVDeW9LdVUvWWdtVm1yY000ckVBRmU2T1REL3FU?=
 =?iso-2022-jp?B?cHhpM2JFVFFObzNEWElEZXNmME5tQTRuTkxpTzNieUNRQ21qYm9TbU81?=
 =?iso-2022-jp?B?TDZ5SUJuUmxZQVRoVVJob1dITzd6RlI2UTJCdmxFVzFkS2t0emhwS2dZ?=
 =?iso-2022-jp?B?UWFiY3cwT2dYZDZoSXRwZi9Ed2ptaVorR0FSQVNWcklJUmFwYWllWW9Y?=
 =?iso-2022-jp?B?MzMzZVM2SlM5N3M0ZHIxMEpuaVhWZmZUTDl0WEJqTUNGT01QSlpoTDcx?=
 =?iso-2022-jp?B?eUpyVVFSVkkweGJzTm5maG5zM2xhY1VCZkpPWGV4eWR3SGxHM016VHF1?=
 =?iso-2022-jp?B?OWhMZzBscVVnWkREeGVQS2ExU0dJNStHV29CS0psQlBUenMwcFFSbEdy?=
 =?iso-2022-jp?B?MkZ5bWpJSkMrZFlLOXBkdERkZmZpNXovcTFQcStpd2hlVmlGK3lRVFFw?=
 =?iso-2022-jp?B?TUp1Qm9pYmdDRkVLZGNHZ1FsOXBQQXQ2R3dRTGpLT1BxYWlEdC9CZ1Z0?=
 =?iso-2022-jp?B?ZHBrWkd1dGZKTTVrdmdyMHJGS0ExdGlCS0FQMHdHNG9vM1dlaWRnWXla?=
 =?iso-2022-jp?B?S0FwRURMbmZFWmtES2NTcGlCN2xkWlhuVEJLSkVBODVodzZpeCtZeTFG?=
 =?iso-2022-jp?B?NCtmODhRPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9243fd7-e815-42d3-546b-08da0011954a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 08:07:54.4842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /x1mgC23myxUSiRHmNjloMcbal6drhLTinOAFsgpj+NILRIQrIRbAJZKosNtRg6+xxKqcMFhAH60p2i2k5nbeBEvqDvixiLU8ez2b8m9an8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4363
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Fenghua,

> On Fri, Mar 04, 2022 at 07:38:33PM +0900, Shaopeng Tan wrote:
> > In this patch series, I make restrl_tests build/run using kselftest
> > framework, but some users do not known how to build/run resctrl_tests
> > using kseltest framework.
>=20
> Please don't use "I" or "we" in commit messages. Also the grammar seems n=
ot
> right here.
>=20
> >
> > Add manual of how to make resctrl_tests build/run using kselftest
> > framework into README.
>=20
> Maybe change the commit message to this:
>=20
> resctrl_tests can be built or run using kselftests framework. Add descrip=
tion on
> how to do so in README.

Thanks for your advice. I will use it for commit log in next version.

> >
> > Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> > ---
> >  tools/testing/selftests/resctrl/README | 31
> > +++++++++++++++++++++++++-
> >  1 file changed, 30 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/resctrl/README
> > b/tools/testing/selftests/resctrl/README
> > index 3d2bbd4fa3aa..268cf3f95bd5 100644
> > --- a/tools/testing/selftests/resctrl/README
> > +++ b/tools/testing/selftests/resctrl/README
> > @@ -12,9 +12,37 @@ Allocation test on Intel RDT hardware. More tests wi=
ll
> be added in the future.
> >  And the test suit can be extended to cover AMD QoS and ARM MPAM
> > hardware  as well.
> >
> > +resctrl_tests can be run with or without kselftest framework.
> > +
> > +USE KSELFTEST FRAMEWORK
> > +-----------------------
> > +
> > +BUILD
> > +-----
>=20
> The "---" under titles are all same. This cannot tell readers clearly top=
ic
> hierarchies.
>=20
> How about this?
> +USE KSELFTEST FRAMEWORK
> +-----------------------
> +
> +* BUILD
> +
>=20
> > +
> > +Execute the following command in top level directory of the kernel sou=
rce.
> > +
> > +Build resctrl:
> > + $ make -C tools/testing/selftests TARGETS=3Dresctrl
> > +
> > +RUN
> > +---
>=20
> How about this?
> +* RUN
> +
> > +
> > +Run resctrl:
> > + $ make -C tools/testing/selftests TARGETS=3Dresctrl run_tests
>=20
> Run this as sudo or root.
> + $ sudo make -C tools/testing/selftests TARGETS=3Dresctrl run_tests

Thanks, I will take your above advice in next version.

> > +
> > +Using kselftest framework, the ./resctrl_tests will be run without any
> parameters.
> > +
> > +More details about kselftest framework as follow.
> > +Documentation/dev-tools/kselftest.rst
> > +
> > +NOT USE KSELFTEST FRAMEWORK
> > +---------------------------
> > +
> >  BUILD
> >  -----
> >
> > +Execute the following command in this
> directory(tools/testing/selftests/resctrl/).
> >  Run "make" to build executable file "resctrl_tests".
> >
> >  RUN
> > @@ -24,7 +52,8 @@ To use resctrl_tests, root or sudoer privileges are
> > required. This is because  the test needs to mount resctrl file system
> > and change contents in the file  system.
> >
> > -Executing the test without any parameter will run all supported tests:
> > +Executing the test without any parameter will run all supported tests.
> > +It takes about 68 seconds on a Intel(R) Xeon(R) Gold 6254 CPU @ 3.10GH=
z.
>=20
> resctrl will add more tests in the future. Running time may be longer in =
the
> future. I would suggest to remove the "It takes about 68 seconds..." line=
.

I added this sentence based on Shuah Khan's feedback, but I didn't consider=
 extending this test.
I will delete this sentence in next version.

> >  	sudo ./resctrl_tests
> >
> > --
> > 2.27.0
> >

Best regards,
Tan Shaopeng
