Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7489676788B
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 00:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjG1WkO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 18:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjG1WkN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 18:40:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A963835A5;
        Fri, 28 Jul 2023 15:40:12 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SLiTiX028545;
        Fri, 28 Jul 2023 22:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=qDNGxyGEqTr8PN8AVzv5mVHMp8AvkoN1xVuX238i8N8=;
 b=dQGwvhK2vNznq90LB3hucBjubq15rBL1M5BTprvAjnXTUSkLkEZ+GzSXDrVnJxKgvJSo
 1j5oSQnzrmefDs5XUNWjcyA27zMF9XTQz1OSCyZOrTVWf3I4o30U5SQqne7ZvIjvZOSz
 KmIFGUkx4xkt4gNj69hmTAA68nlhziH1AAuPGWom0GuxL0XBDvA5B6uTJtT3oQj5C+bn
 eE5XUCPB5zik3oBi7M6mli6nXnuTKJJC8F6l9ty6xcyb+gxyrYYFqo3pOEvR8NyUMtaD
 ytd9Y6uCZ+SlhfJ0ZzpjEI9HiwypYYRY+zQLSgUQJC056ewcM/K3+VJhYdUIxmSn2FGE PA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05q24wfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 22:40:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36SMUCQe011825;
        Fri, 28 Jul 2023 22:40:05 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j9y7qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 22:40:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aidAEQcbuaIDM3/FSyIC6YYL+h8FOCTYRok92lq+D3gsUIR2/7kauLV5C8nl2om49jReEI0SnumkqQHHZNK5+SbPdxf0ahlmTKgtraS/M7yCQcDjD9LIfrznQVw/8/cWBuviiEKaBpMTtT2M4Na/WjRGK5WvP8V60wltESe6aQW/I3yoJP4s8p60x1DHdKhnQrkd/QsT+1af25sGssQkSWW9vQMZpzDRa1vYwrSBW8luhBj9VDJKLI+jG2NHA7L6+fV6En7dO2wwfdmp2fcXYyLuXNoNLpcKxjphj3tCgPZp5XpXfOKd95GjIC3Xv8y61gjUzyZ0zHGCP/Y4tzmCyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDNGxyGEqTr8PN8AVzv5mVHMp8AvkoN1xVuX238i8N8=;
 b=AlR8oI/66DC5eGUsxJkDTF+owSyBbzNBhyqXbawYvR3yYXMcN7Nrt2tA+h8sRAQHJEsycTlLVwbtprAsahL+C62QDYzfjYXS0cZw1VsvR06ZEVCbnEy9CABbuqubOmosQM5YPaA5D9qOXIEEPALPwl7v9eepYuRnbhQ5m7FLLIuTfGWXXLYY1VCErYrwVtblPrI6v4Su+is7cXgyYUm0QLYwpvu2T2sJLspTSuekiR6ZZ63OMCafN4axvNVrcWJlyuqXEMBdAfqdhZV27g3mnCGw6mNKEPF7puVyXN9U5UBhBVP9CIyoHBPlY2LHG4wlhyz4dt5EMHtJYf4Lj4BrCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDNGxyGEqTr8PN8AVzv5mVHMp8AvkoN1xVuX238i8N8=;
 b=EouVbaQ71W3nyGgpvITuyCoc2cVGcEC+uobDeRLYj14lmZkhitDInFRHM8MSZStUca/iJUtrak5O9xCLeGfmfYU8vdENa6EKTW8Rt2m4rLVNlQ4Hr8HH3Iws86kfoPHeRhghBdP+w8DPs3Xl79blj65ngERLtOcOHXfjQEILZQg=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by BN0PR10MB5239.namprd10.prod.outlook.com (2603:10b6:408:12d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 22:40:03 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::69d6:8729:ee7c:cc45]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::69d6:8729:ee7c:cc45%2]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 22:40:03 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
CC:     Shuah Khan <shuah@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH next 3/3] selftests:connector: Add root check and fix arg
 error paths to skip
Thread-Topic: [PATCH next 3/3] selftests:connector: Add root check and fix arg
 error paths to skip
Thread-Index: AQHZwXkWbDEKB7ogokq33I6v8z/kP6/PesIAgAAPagCAAAqwgIAAGwgAgAAFxYCAAAT4AIAAB1+AgAAD84A=
Date:   Fri, 28 Jul 2023 22:40:03 +0000
Message-ID: <AD8D16A6-63BB-4953-80BA-6410B29416D6@oracle.com>
References: <cover.1690564372.git.skhan@linuxfoundation.org>
 <2c0ac97f9c8e6bd46b60854c136099c0dd4a09f6.1690564372.git.skhan@linuxfoundation.org>
 <0CB227BA-69FD-447F-BE73-2482A6998F7E@oracle.com>
 <5b283f3b-f176-7f19-5db0-1332a94a44be@linuxfoundation.org>
 <ec809279-cc41-7e0f-a567-29400b4c34a9@linuxfoundation.org>
 <16B47831-5F53-4BAF-B347-A1404D2ED264@oracle.com>
 <957be0e8-2bdf-80f4-92b7-3b9070c546b3@linuxfoundation.org>
 <3242346A-9B09-44F7-A062-8456F83372C7@oracle.com>
 <84048d13-9311-36f6-9eb4-8169952580d7@linuxfoundation.org>
In-Reply-To: <84048d13-9311-36f6-9eb4-8169952580d7@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|BN0PR10MB5239:EE_
x-ms-office365-filtering-correlation-id: d89589f7-be5e-4d7b-3bc2-08db8fbb95ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V5u5IrTzH7e97vsi6qzy7WWGcV6hxrH5Fe1c547uP5w+JV8JjXmJ0eDF4mN84axWpR+mKnJeZUgpkb5o0v18GN0iwvTqB4YkTvbxOa9X6iswJ5jfob7GT5K7WTdw5sgf8TUIj528IYPehNU7HdjzCwTRI6Bt9mL+xCbG7O/bfTJSViwtYVg6AViKeS7hk12a3rT1YszwHfjCY88UESXwB6s5Ymcv4V+OrBSWNyDPbe+p7MwX9f+9cqlt23q94qetqW2NJOgM/JOAXLIO/jXXciDRP6cFBEDl/Cr2yaquYE5w82E+DUxQmflKgKiRqWzPWexbFScuA7vgd/WmmECG9UXkVbvlZ8tuUFjyw1xrGoi8lXpfd75ZgvuDd5RlsXodG0quYU+iOfqxi0C+GlE2zOuZ2BrB8ih/dcpqFCtFCLGLksDNC5r808ww/c81gG3k7Ze4EWI5E7K70yJM/xX1JWlsyLEC215U0qqT1hTbSihQ2OopiS4w9kbmoQoECfO3l4/FszDwdqOQzQqGpt88Pt6YO69zwTE4oHKON7vvtK8X6liHZipeptzwtl1ufhcJ4hXQVxYIvF4Z2UDlAaKR73r0HLRc60SGuVO+XbQ4ozqQq9lQMbyScEdGFFUghu/AwK8o3waG081X/ARcq+Zglg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199021)(8676002)(8936002)(5660300002)(2616005)(316002)(53546011)(33656002)(26005)(6506007)(86362001)(186003)(4326008)(54906003)(66556008)(38070700005)(71200400001)(6486002)(66476007)(6916009)(76116006)(6512007)(66946007)(64756008)(66446008)(91956017)(41300700001)(478600001)(2906002)(83380400001)(122000001)(36756003)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXZEaGhuQXJrUUxsNXM4cVQyM2E0ZnltTUVmN3lKM0l0cS9vN0w2YWRadFFW?=
 =?utf-8?B?T04vOCtUMHhsUEJVeXQxUWtTWTJ2M2dqRUJTVTkrWEEyS21BWnpJTHhmcVhV?=
 =?utf-8?B?ZzU4ZTVmbUZZTUNPdGU5SkpORXl1OGZlUUx1NXJvYk5wZUM0NDRQYVZhaE5z?=
 =?utf-8?B?SUxpMDMwVUNieTB1b2dpTUlSakVqMTJKYllkUnBsbndaTjdjVEVOdy9yNE10?=
 =?utf-8?B?QjRXVTZpQXZ0M2txcXYzZThWem9tRXNMZGJabzNwZTZqVXgyTW44clhBNmxi?=
 =?utf-8?B?WFd5bTFldnVKVklyb0dhUUhEeFZtWHlWdi9RU2VyWDY3YjdKWEdvVThyckpY?=
 =?utf-8?B?cEd6Q1RoSFZWemh1dm1ueUN6M0lWY0gxQ2QvMmpySVNqcHh2TFkweHlWQnlY?=
 =?utf-8?B?dnVSM2pMQ3oybzlxTGdSNzFkbEJTRW5zL3lvaE1UUFh1NjFuT1FjUEJ4Q0th?=
 =?utf-8?B?WjhFZGhqZTR2clkwL0h1STJyZmovVVcvS0hqbm50WXhuVVVoZ0x6UlUveDJT?=
 =?utf-8?B?enBydEtJUjVrVjB1eGlTZmxTQ0NudzJ3d2d1Q2tLNUtxMUJ6QWlPaXB2Ty9Q?=
 =?utf-8?B?djB4bzhXSVJyQWNoRzV6WXk2Q0R0SjZWdDVJWEw3UGtoTHBUZnVyMGU0M2tu?=
 =?utf-8?B?S0JUb0tWNmRiRmZMdDA2L2FVNkU3alUzWS9CSjVmNUQ0aTJuOVY1cHRHRE55?=
 =?utf-8?B?YjhaL2M4NER1eGRCeW1SM0tocDNVSTRWQTZlSStKWnpIYlE0RUN6WVpUZitJ?=
 =?utf-8?B?UUcxdjZlTnpZNExGRzJlYkdrN1ozamo5YUw4WWdpZ2JUWW1RWlFlSVcvS1d3?=
 =?utf-8?B?ZVduNUlhVWdQVnM5WW9icjgyM0ZvY0xGblVjV0V2aTRDTTRrSkNvTTBnb21o?=
 =?utf-8?B?aDBYbE5NWms5bWdJWEJUL0xmNTZmNjlsZ2QvclR3WW1xVWpsTE9QM0NKR290?=
 =?utf-8?B?WFpqaURmWXovSEs4ZndzZnM2Yy9FelhMMU5NS3BuNzYrdnJ6TVJWMkhWcklJ?=
 =?utf-8?B?bEo5QS9tR0pPWmRyTWhtK2ZJV2NjcHQxY2s0bzFzbGVmbHRRS1pKYmF5YlFF?=
 =?utf-8?B?NGU0emVrLzB3dG9aSTVlNEZVby85bjRaQUhwVnRjc0NNbThmQnlCZzNVUENv?=
 =?utf-8?B?N25nSTJsRDNUTXgrM01LSGhBTUlIWFNzYnd2d1oweDdCSFpjeWJydUpCWjhI?=
 =?utf-8?B?eTF1ZVM0WWJVN3dpanppanBBREdDRWxkZURVdURDUW9DbnRtQmN5WFhxQk5Z?=
 =?utf-8?B?M1ptcyszTWo4T2xQQXpzMW9aTzRHa0xXSWNtY3JZYlFmZllCVXVJdFdnbTVs?=
 =?utf-8?B?enVFa21VV1FFNG81RXNBSzdmckRoN2taUzRwcmlDSzBIYXpnUWtRUzVmZXls?=
 =?utf-8?B?WXBYaVdTd2dJOXJkVG9xQmRjb1Zud1dFT25HRkJYZzB3R1ZzTVRMNVdyOFRk?=
 =?utf-8?B?RDRuL3M1U25SREpiODdBcGIrUTI2WmhSNkdROTBaa0FXUXJJVGxiOWY2WSto?=
 =?utf-8?B?U1FBbkFYTTJXOUhMODhmc25hYStlaDB6S2pEZHltUlJsSXBUd0FQWU5iaDdh?=
 =?utf-8?B?NVNPUnhYdkVIUXhLeVJwaWxTMXBDQ1ZtVjBJdmh4RzlzOGZlaVZDYklOaFQz?=
 =?utf-8?B?YjlqNExMYzU3eWl1Zk1MVkxGT3VvRjBDUzByM0RzcmtHeVk3dHhSWVZPZWZ5?=
 =?utf-8?B?VitlSHB0M0FUd0ptL0ZGeTY2SnRrTXpud3FKL0tqYXBTaHEzbkhmOWdGSUVM?=
 =?utf-8?B?ejJybE9jRlNyU2lRdjg5ampObG1DcnBLdEFoTEdKMnVDd0x6RjhBMHNjY3Mx?=
 =?utf-8?B?QVJ1elJHakxOeEVENTdYSUdwMGpoOXI1WlE1YkMxZlZNOWtHL3Rsb3JHMWg4?=
 =?utf-8?B?M1JXVmNmRXAzTzFRQjRZM0FzV3h6K1J3MWdvZWpjc3Z5UXJSaEZxUDM0MVcw?=
 =?utf-8?B?MVlJaEIwSEZpTlV2UUg3cHRlMUQ5SzRnd2o3ZjRJWDZ2eDJqVlRZcEU3MlQ5?=
 =?utf-8?B?Q3ovazZpZUdKdFAwd0lVUDI3aytobWxqdlNjTGVxclJjZnJ3OGZ6ejNJWXhL?=
 =?utf-8?B?Mk5UallTYUJoUlBpeXJRRlFLbE8zK1hMcDBpZE1aRUt6WnFwNllZUUxJc2VQ?=
 =?utf-8?B?Uk1vbE51VTRqZ2FZM0huMncxdlVSNXN4bm1EbjNtanBIQWk5cDd2RW91K09j?=
 =?utf-8?B?RUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DC9DD5A61182E4E869816659BB7D3FE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2ZBR+38euCA/lA5mD0ZXO7oWE/7b9a6R6dhNs4HdH5FSsUhSIees0Q6BHIwlHpDMwnasGdwky1hikuyLtOJS857JIZ10/het164ARWLlAwHNSwk5p/brWbOadNZ6Y3+xdhv52+lTUH6QvS3VUyIwQ8qrAjUlPGnri8b4SxKFQbawvIFf16F1BmRizgmFignV/s/UzKstgeHZ4II8oxaco6M0NGgGzj3IsAeSeCNl9ShAIHUuL+ZKkAwULhX5pNc1phzV2QXg1iU7xpYKWhEn0kpxdaf6tUHdc/KVIGeKcP7ouhyKkeY+IX8EgbfNwb6iEiZNGCCl4VMjxlaJoo08Qchtm4sJRCmmGzDdrRa+0OuNOV/i40RlTMM4pK7Tgn7piA+7TKtdL/Az0SQ5DOMy9pe/s5iN6vclICvBLaTg++alrm0pIzQ+kPSr7Mv/GD1QYzmOugvXCSCsMAxQdCa6Q6UXRIJWseKLIZU6beBDGoiERRZY67FZKBAB8wCI0TG49Me/MlTRfSnmSDWjRPT9TRsAErabxuitXtO5zTpiJHleBNbqmruwq/4Hom+jGCuhEb2jcjpuvKuIKLBAP3NBgGyKzls+FcU+V19OMU006VRSRpbOw9PYrlilwtBr8NeNWsv9czBfT9+htysYQ1y2Wdvwugpa+ALjX2kBV/qmHGOxz3TOnHFsMEJa58P6VURpzarJYnORzUXpRBOKrcFqGmtod4mLlEdRcHG1WmOrWm31hRzLJ2JHv73aRkgBZJcw2J0nyv54ncTwhKQYA+3XiiFIzvIXVfJgl9c7P8dKwwYsJyVok4rNaVun+526HudXY7uHcFm5prgcjIsuza4wYPY3HYAp3ziTpAA+FJY4saZ/lbFzrq5fGSB5cJw4Y8Om
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89589f7-be5e-4d7b-3bc2-08db8fbb95ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 22:40:03.7859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fxe6FRZqxFR4FWuYKMOpHSjgmT7lOqRlje6d9Tc6KABvNMrTqLLNMHkTsWM+yG6qhW7Q75H+ghYi4fs9gZug5BpVPBaAmuFOm/HLGpcu5IU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5239
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307280206
X-Proofpoint-GUID: NvPbiTBJnNfXithlr-3ywxlr6-xKyn6j
X-Proofpoint-ORIG-GUID: NvPbiTBJnNfXithlr-3ywxlr6-xKyn6j
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gT24gSnVsIDI4LCAyMDIzLCBhdCAzOjI1IFBNLCBTaHVhaCBLaGFuIDxza2hhbkBsaW51
eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IE9uIDcvMjgvMjMgMTU6NTksIEFuamFsaSBL
dWxrYXJuaSB3cm90ZToNCj4+PiBPbiBKdWwgMjgsIDIwMjMsIGF0IDI6NDEgUE0sIFNodWFoIEto
YW4gPHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIDcvMjgv
MjMgMTU6MjEsIEFuamFsaSBLdWxrYXJuaSB3cm90ZToNCj4+Pj4+IE9uIEp1bCAyOCwgMjAyMywg
YXQgMTI6NDQgUE0sIFNodWFoIEtoYW4gPHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3Rl
Og0KPj4+Pj4gDQo+Pj4+PiBPbiA3LzI4LzIzIDEzOjA2LCBTaHVhaCBLaGFuIHdyb3RlOg0KPj4+
Pj4+IE9uIDcvMjgvMjMgMTI6MTAsIEFuamFsaSBLdWxrYXJuaSB3cm90ZToNCj4+Pj4+Pj4gDQo+
Pj4+Pj4+IA0KPj4+Pj4+Pj4gT24gSnVsIDI4LCAyMDIzLCBhdCAxMDoyOSBBTSwgU2h1YWggS2hh
biA8c2toYW5AbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+
IHByb2NfZmlsdGVyIHRlc3QgcmVxdWlyZXMgcm9vdCBwcml2aWxlZ2VzLiBBZGQgcm9vdCBwcml2
aWxlZ2UgY2hlY2sNCj4+Pj4+Pj4+IGFuZCBza2lwIHRoZSB0ZXN0LiBBbHNvIGZpeCBhcmd1bWVu
dCBwYXJzaW5nIHBhdGhzIHRvIHNraXAgaW4gdGhlaXINCj4+Pj4+Pj4+IGVycm9yIGxlZ3MuDQo+
Pj4+Pj4+PiANCj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFNodWFoIEtoYW4gPHNraGFuQGxpbnV4
Zm91bmRhdGlvbi5vcmc+DQo+Pj4+Pj4+PiAtLS0NCj4+Pj4+Pj4+IHRvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2Nvbm5lY3Rvci9wcm9jX2ZpbHRlci5jIHwgOSArKysrKysrLS0NCj4+Pj4+Pj4+IDEg
ZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pj4+Pj4+PiAN
Cj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jb25uZWN0b3Iv
cHJvY19maWx0ZXIuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nvbm5lY3Rvci9wcm9jX2Zp
bHRlci5jDQo+Pj4+Pj4+PiBpbmRleCA0ZmU4YzY3NjNmZDguLjdiMjA4MWI5OGU1YyAxMDA2NDQN
Cj4+Pj4+Pj4+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nvbm5lY3Rvci9wcm9jX2Zp
bHRlci5jDQo+Pj4+Pj4+PiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jb25uZWN0b3Iv
cHJvY19maWx0ZXIuYw0KPj4+Pj4+Pj4gQEAgLTI0OCw3ICsyNDgsNyBAQCBpbnQgbWFpbihpbnQg
YXJnYywgY2hhciAqYXJndltdKQ0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBpZiAoYXJnYyA+IDIpIHsN
Cj4+Pj4+Pj4+IHByaW50ZigiRXhwZWN0ZWQgMChhc3N1bWUgbm8tZmlsdGVyKSBvciAxIGFyZ3Vt
ZW50KC1mKVxuIik7DQo+Pj4+Pj4+PiAtIGV4aXQoMSk7DQo+Pj4+Pj4+PiArIGV4aXQoS1NGVF9T
S0lQKTsNCj4+Pj4+Pj4+IH0NCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gaWYgKGFyZ2MgPT0gMikgew0K
Pj4+Pj4+Pj4gQEAgLTI1NiwxMCArMjU2LDE1IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICph
cmd2W10pDQo+Pj4+Pj4+PiBmaWx0ZXIgPSAxOw0KPj4+Pj4+Pj4gfSBlbHNlIHsNCj4+Pj4+Pj4+
IHByaW50ZigiVmFsaWQgb3B0aW9uIDogLWYgKGZvciBmaWx0ZXIgZmVhdHVyZSlcbiIpOw0KPj4+
Pj4+Pj4gLSBleGl0KDEpOw0KPj4+Pj4+Pj4gKyBleGl0KEtTRlRfU0tJUCk7DQo+Pj4+Pj4+PiB9
DQo+Pj4+Pj4+PiB9DQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+ICsgaWYgKGdldGV1aWQoKSkgew0KPj4+
Pj4+Pj4gKyBwcmludGYoIkNvbm5lY3RvciB0ZXN0IHJlcXVpcmVzIHJvb3QgcHJpdmlsZWdlcy5c
biIpOw0KPj4+Pj4+Pj4gKyBleGl0KEtTRlRfU0tJUCk7DQo+Pj4+Pj4+PiArIH0NCj4+Pj4+Pj4+
ICsNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IEkgYW0gbm90IHN1cmUgd2h5IHlvdSBoYXZlIGFkZGVkIHRo
aXMgY2hlY2s/IHByb2NfZmlsdGVyIGRvZXMgbm90IG5lZWQgcm9vdCBwcml2aWxlZ2UgdG8gcnVu
Lg0KPj4+Pj4+PiANCj4+Pj4+PiBJdCBmYWlsZWQgZm9yIG1lIHdoZW4gSSByYW4gaXQgc2F5aW5n
IGl0IHJlcXVpcmVzIHJvb3QgcHJpdmlsZWdlcy4NCj4+Pj4+PiBJIGhhZCB0byBydW4gaXQgYXMg
cm9vdC4NCj4+Pj4+IA0KPj4+Pj4gVGhlIGZvbGxvd2luZyBpcyB3aGF0IEkgc2VlIHdoZW4gSSBy
dW4gdGhlIHRlc3QgYXMgbm9uLXJvb3QNCj4+Pj4+IHVzZXI6DQo+Pj4+PiANCj4+Pj4+IGJpbmQg
ZmFpbGVkOiBPcGVyYXRpb24gbm90IHBlcm1pdHRlZA0KPj4+Pj4gDQo+Pj4+IFllcywgdGhhdOKA
mXMgZXhwZWN0ZWQgb24gYSBrZXJuZWwgd2hpY2ggZG9lcyBub3QgaGF2ZSB0aGUga2VybmVsIHBh
dGNoZXMgc3VibWl0dGVkIHdpdGggdGhpcyBzZWxmdGVzdCBpbnN0YWxsZWQgb24gaXQuDQo+Pj4+
IFNvIHRoaXMgY2hlY2sgZm9yIHJvb3QgbmVlZHMgdG8gYmUgcmVtb3ZlZC4NCj4+PiANCj4+PiBJ
IHdpbGwgc2VuZCB2MiBmb3IgdGhpcyBwYXRjaCB3aXRob3V0IHJvb3QgY2hlY2suIEkgc2hvdWxk
IGhhdmUNCj4+PiBzcGxpdCB0aGUgYXJndW1lbnQgZXJyb3IgcGF0aHMgYW5kIHJvb3QgY2hlY2sg
YW55d2F5Lg0KPj4+IA0KPj4+IEhvd2V2ZXIsIHdoYXQgaXMgc3RyYW5nZSBpcyBpZiB0aGUgdGVz
dCBydW4gYnkgcm9vdCwgYmluZCgpIGRvZXNuJ3QgZmFpbC4NCj4+PiBUaGlzIGRvZXNuJ3QgbWFr
ZSBzZW5zZSB0byBtZSBiYXNlZCBvbiB3aGF0IHlvdSBzYWlkIGFib3V0IGJpbmQoKSBmYWlscw0K
Pj4+IGlmIGtlcm5lbCBkb2Vzbid0IHN1cHBvcnQgdGhlIG5ldyBmZWF0dXJlLg0KPj4+IA0KPj4g
SSBkaWRu4oCZdCBzYXkgdGhhdCAtIHBhcnQgb2YgdGhlIGNoYW5nZXMgaW50cm9kdWNlZCBieSB0
aGUgcGF0Y2hlcyBpcyB0byByZW1vdmUgdGhlIHJvb3QgY2hlY2sgYW5kIGFkZCBzb21lIGZlYXR1
cmVzIG9uIHRvcCBvZiBleGlzdGluZyBjb2RlLg0KPiANCj4gT2theS4gU28gd2hhdCBzaG91bGQg
aGFwcGVuIGlmIGEgcm9vdCB1c2VyIHJ1bnMgdGhpcyB0ZXN0IG9uIGEga2VybmVsDQo+IHRoYXQg
ZG9lc24ndCBoYXZlIHRoZSBrZXJuZWwgcGF0Y2hlcyBzdWJtaXR0ZWQgd2l0aCB0aGlzIHNlbGZ0
ZXN0DQo+IGluc3RhbGxlZCBvbiBpdD8NCj4gDQoNCkl0IHdpbGwgZGVmYXVsdCB0byB0aGUgYmVo
YXZpb3IgcHJldmlvdXMgdG8gbXkgY2hhbmdlcyAtIHRoYXQgaXMgaXQgd2lsbCByZXBvcnQgYWxs
IGV2ZW50cyBhcyBvcHBvc2VkIHRvIGEgc3Vic2V0IG9mIGV2ZW50cyAod2hpY2ggaXMgdGhlIG5l
dyBmZWF0dXJlIGFkZGVkIGJ5IG15IGNoYW5nZSkNCg0KQW5qYWxpDQo+IHRoYW5rcywNCj4gLS0g
U2h1YWgNCg0K
