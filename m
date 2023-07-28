Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA7076725C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 18:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjG1Qt2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 12:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjG1QtO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 12:49:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33DE5BA5;
        Fri, 28 Jul 2023 09:47:38 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SF52M5029668;
        Fri, 28 Jul 2023 16:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MRjQ0Pxaox1uye9AQkB2tNXY374EZs6ZOIyo8LMv+5k=;
 b=OdnH+xy4LjmgRvR5nnsLRHMXSzkQxcSBvIhxt3f6/wfUIouHE9mnCblOP2/BI+lUvmLS
 4kBBhWZ7yV1Fj9K4LH8fkmNGGBd3nXVbdwOatr8fao8HZPzOMxqoRSlyjpOYNT3lyxp3
 fUUva91Br8SeXxlsF/2xpA+e4nzBmazfG07mDEl69Als3SuQfbfLnZ04619vkn9iW4Xi
 MsUbTod4k81r7if3ZB/I31dVUZ8U606+0ERrT7xdRBWM6+Lg+kiKkPXjfochmNGcycP7
 J1t1JWundFpjRKga3qacm67uzyn63/6Yg2n2VPw6+UpquAPg+VmoDadszUa9HgGCYg27 Hg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nuva35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 16:46:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36SFIB9Z033457;
        Fri, 28 Jul 2023 16:46:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jfkpw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 16:46:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U93qaDwr8qs9GHBEnFjtGubHVptdj6ZRblnkedeAPwiS3Aosr7P7hRC13wHDl6x1fRNeVzF30too3AlSn2kVR9MHpVVyO1T9mh1FO2sCXrTa8Zl/MJZ3hFNRY4SgmDMhZvMlv145mnWWX8ldwyO63jgkZewgDi9j4o4e/M3RCiJn+wYwdNPWoNOlEj5YQYcvSYu7LrfaN2aVK5RAmbwp05R868CUOAQ3jm6G2tay/uRHR7I8+nDUrqsP1TW+SBQbP/sorPp49VHlQpFyM7WxnsWJmI09yLs09MHiWgLmj3ruilvC2bYUNfk2Nw83UwyQgi7ErqOs2J3qSDF/JeX+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRjQ0Pxaox1uye9AQkB2tNXY374EZs6ZOIyo8LMv+5k=;
 b=F7CxeeK/Jepq3eq1zeRHACItsyNCj3g2wq5luKB77mErZY138DPWH0bjl954p0kgiI5uXbslZJyHqIUc2KfsHfFlU9sbi8Okl4REnHfJ9n2B+ggxALm3FUNfzA8fnleFjFT10ZJwkk61JOthKY8VPYml1fw6urYvjUV3u/KNx+OaCQtD4qKa5gMZ5NBOvmcsCioMxvhDQ3ju+mqrxkMT71zZFBYPBWXMBlGsgzQ7rMbY2fVjYtRK6He5pgQ4Gi6nbW73P2g9Da5UjhAD9O82u6UWdSz8JA4mgECfExcnxBvWXHwrZ+8D9zhCsrqN5uNGh6qJoUo2rk254JKfO/Rquw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRjQ0Pxaox1uye9AQkB2tNXY374EZs6ZOIyo8LMv+5k=;
 b=q8Cwse4wc0AiNf49GrQEHyH2vZa7HvR8F9+OUpLXCgHWKPUKhddDVGEfLMpI/sB2MoziQnbzcSNyuiILcseeN6JxW2PpXHZaVMuUZO7U96H0kU2ZvMGp7x2E7CN7GI2PkpzM4hDVWqIXKx3RDfp0l8kp9snBCBfzltHE6zKqIVQ=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by SJ0PR10MB4512.namprd10.prod.outlook.com (2603:10b6:a03:2dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 16:46:27 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::69d6:8729:ee7c:cc45]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::69d6:8729:ee7c:cc45%2]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 16:46:27 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     Shuah Khan <skhan@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        Netdev <netdev@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: selftests: connector: proc_filter.c:48:20: error: invalid
 application of 'sizeof' to an incomplete type 'struct proc_input'
Thread-Topic: selftests: connector: proc_filter.c:48:20: error: invalid
 application of 'sizeof' to an incomplete type 'struct proc_input'
Thread-Index: AQHZvvi/xI4ekXqIdU+9CLD2lWipK6/KsaiAgAMxnwCAAHfvgIAAD1EAgAASBoCAAOubgA==
Date:   Fri, 28 Jul 2023 16:46:27 +0000
Message-ID: <5844361F-E776-4C52-BA8F-7E13D6B4EDE1@oracle.com>
References: <CA+G9fYt=6ysz636XcQ=-KJp7vJcMZ=NjbQBrn77v7vnTcfP2cA@mail.gmail.com>
 <E8C72537-4280-401A-B25D-9734D2756A6A@oracle.com>
 <BB43F17E-EC00-4E72-BB3D-F4E6FA65F954@oracle.com>
 <799d6088-e28f-f386-6a00-2291304171a2@linuxfoundation.org>
 <DD53AFBE-F948-40F9-A980-2DA155236237@oracle.com>
 <20230727194311.6a51f285@kernel.org>
In-Reply-To: <20230727194311.6a51f285@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|SJ0PR10MB4512:EE_
x-ms-office365-filtering-correlation-id: 65e91bfa-15b3-492e-210e-08db8f8a2fe5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c38D2/2G6y4JXK0mSMOERko/CFLsxfQQxzrQWzCJf7EE6gLBwInuVzC+Y4+P3SPMofs5bnc2zCVmUURl6ZHPIz+ovtmyTXL+JyFES/L7VngHK9+XUMX0pYkO5HeKjhYfDBGV89ZiLdVBvy8Eqhjs4Ybhi0WEFI1jf+hKgJhU5RTyhSFtm/DOiGkxagswMskJQpFHzqYQww1x4AP8sqvJJdGHiI91Va9hpUgqfUxKN3BG7MDPLlHw7Y14N/KvAh3vT7xxddAtvKIvcrKX1+TuPBSDbRQPfj7VHAuBeIyCA2Y3lT0UyFBDb3gFM+g8Fye/Up2YXZ5XJpHDkWTGdZCgyjUmhrW5ZpLb1KeZ53pV09JT6xzV3Q/d3tiNahh9/IYppYtx2yR49btlrlgGFvy56dVPRcDhqVFKC9i7WbvHdWvd8Gn7vZndhDnwOovd5UprlMo2dU9gGYv1JAriuKX4Eb0UaEvWhMXqJuQoDyiWIX6s/Y0ALFBji8Rjv+OnPEkPkl1DAhh7MG/2jMkgx1AIci7Axd15A9kAH43Ehh1/x/0vUl4dXDB9YeMSzG8JeRfHQGUjjaZePVDri33/6j2whV/1XDVcA/TGPRiFL6gJvxVnbpmX+Qcy/m5ORz8e8/w1kgPXni+QF0/CuOh1Bt0iRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199021)(2906002)(71200400001)(6506007)(4744005)(186003)(316002)(64756008)(38100700002)(122000001)(107886003)(2616005)(53546011)(83380400001)(66446008)(66946007)(66556008)(33656002)(76116006)(5660300002)(66476007)(41300700001)(8676002)(36756003)(7416002)(8936002)(6916009)(54906003)(38070700005)(478600001)(6486002)(4326008)(6512007)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KaFmcNvmGOpCMvpYK8ilgC1IrozSKGVpMoeenmnZoagierjg0jVcVsTTr/AM?=
 =?us-ascii?Q?0TfhfBCocnw7dmyMe0VAJYYPEYDvIqga02M93rIQxCAeAeaYx7XG1LnqQe1a?=
 =?us-ascii?Q?mgY+/Ecq1Y6o9Meb/14Vr9F97OTATUY+T7BtOCpYHV9sGihazf+Q2zvN71ax?=
 =?us-ascii?Q?XswLTJt232XhcSwZ0fD8zdZpHDXiA8T0nI9axUnfGujfBTzbHQOhsi2RLNXc?=
 =?us-ascii?Q?njodN9v6HMPqjt7PQTQx1Y/3JLo99MB6fC1Yg4EKx6lCz7tuLgwKn7b8Lxdy?=
 =?us-ascii?Q?1SM7l6cRYOJszTM+EMdmZGtndzhLVr53akXXU6P+0Ay6ItMt/xTaSNeNeXvu?=
 =?us-ascii?Q?JNAzue26rj3Cvka7VLMNGMqRqrgbhD6hj7ZUoYrf9RwEN19/Q7X+rdqU0K1h?=
 =?us-ascii?Q?RYQwgz0IA4oF9VJaWWy8nQin5FmtQGwnK6QU7a8oL42mQgfNBe5PK7uCmWHF?=
 =?us-ascii?Q?rHuRhmuEJx1H++vo9e/t1fnmToz8mcq4sP+5kT94RpMqKY4EUl5LAmQcHFKf?=
 =?us-ascii?Q?EWaKCEkZxr409CP29mLKS0gQwdQKo+WNfHInnqNYVx0CyPzVEPjIhZWchZ9A?=
 =?us-ascii?Q?zQWGQi4eUKEln/vGeVQck2XYoTTcTTigHT4LuQdlGVoTMpO8yC6fqKBOhzcq?=
 =?us-ascii?Q?3eJK+IR3xEy1iVA4JwmNpzREI679z7t6w6TOnxm7amQIj6b5OQ5mTCB+53kW?=
 =?us-ascii?Q?EzqRTxXFl3ID8I6mkDssgpxLI9jHLu6E/0VNxK0iOsP3+jY9xaHGom035B9F?=
 =?us-ascii?Q?FM6y4Fa75ySzyJ5n33OQetsH+vOjRZKdMuxGvHF/+MnX6rFPrY6C8fhJytB6?=
 =?us-ascii?Q?UllHHia3nZBRjMCfamjIymmLf9SYRb8p3gORZ72TLv6rKGB0GTHIbv/VCgg+?=
 =?us-ascii?Q?S9z1qHpBHb/YoIQbhsHANutWwQ7fHj20KAqlrX5A8/icXF6LaFkEJiw50+u1?=
 =?us-ascii?Q?aotKBtVYX2YOzdQO1c9ImPxG9Z6uNsp1wq1fwC3XkU6MMhSLrX7hCbEPPg/e?=
 =?us-ascii?Q?yGN40EiUklfBTnMsfabuJCAaFkTv75agwY+ojPOSF6fCadVpYGNT4j8+YA4w?=
 =?us-ascii?Q?fFEPAwg+KVR953HM7aU8/Z4x4mWPsGQ4BIBI75TIcTpReeVY4CAwxuWH1nx4?=
 =?us-ascii?Q?rytnVRkBkPL/7WRT1xEG+ykljdPEkOGqMq4HH7P9b3NjlT6F+TkVFpaHp54O?=
 =?us-ascii?Q?c+VO1BfcgR6pLP0GJlpAMeI73B8LHbpiIp+orex14mpmqQbiFe632juE85U2?=
 =?us-ascii?Q?FbKwFW2qZb5rnGxALIOSPi+qgI5DhnFPNOUUABv28IzSiwn1T2rCvZG7yhE6?=
 =?us-ascii?Q?DqiC4Bao/aMuFBDT4vov6LSUMq9AanhseP9dgSU0nujCpfxchtz3m9UGQePs?=
 =?us-ascii?Q?wgBw91J0vYVPde1vETjJMT408kpKkPFRu1/sAWN6rxXPSWZ3GMUBYRgi3ENp?=
 =?us-ascii?Q?9IjaoAgIlRpzYur+H01MloFIW/EFXrqFkL6ujxFAr6N1GiGlf8dlltr8EeGf?=
 =?us-ascii?Q?wFknHAtd6ikjQqW78qXJbWWX0pbafhmpQtBKhrbkrvvUctweIVLUi1pJwSdt?=
 =?us-ascii?Q?YPOyswXe0+fqfh7tw1XcK8uGnqCrvsmwJQ3g8fm3vEvQvDKVLen8qMolLsOI?=
 =?us-ascii?Q?E7125QVO9H56wmRmCych6U+v6tiuN5zvQLhj53hEHBsQ04MRlh0tYE7o7Ur1?=
 =?us-ascii?Q?NjTHKvM8eIJhGX/pUZlvss1cBUA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <474EC3FB78CC6640B3FEFF310FC0C042@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?M4qwgpOty+Fv/zUlFRKfW9gfVQXZ3Snh2kPM4IX/fZB37sabMKbYLOWQpbYS?=
 =?us-ascii?Q?DJQIwLHZEsj1wP5e0ikO5BUhKQmXI3mGuc3TAAlXu5x9miey61u8RYL3KXUm?=
 =?us-ascii?Q?gyw4J0QLEIgYaUzCvlHWZwm9bIGVjmku5gJyMUjXvNidmfM5KRDdGkZb3SRk?=
 =?us-ascii?Q?K3lCWUHLuCHbOJ1wzGR788RL1IdvgmTJNB6Jp77Fyik+WsRYUFgphKFct/PK?=
 =?us-ascii?Q?5CROMsYYXRBSiuQJP4PQSzjGFHcKIkiK4hMzJ5mHIy8B/CrQA9kxwRUngYI7?=
 =?us-ascii?Q?E5E6oqMISiMJ/X5nCzw0KUx4xMYMnHwV0l4GqJh1GVFfyB3MUWSaEvDIYX4X?=
 =?us-ascii?Q?+TVY857c4s49OduUS5spGxrfImdKl9L5y76x1FcuwSt+1WUhtBgX+pPXhQEK?=
 =?us-ascii?Q?V72obOjsLh1UVDdfO3R7fVAjKdviLbKwUsXe5C+xj9AgPwEDhQ+lQy81JLTg?=
 =?us-ascii?Q?Jza4T18qauPY0qqgWcHR/gmWJ8PrBhUwRtmS2r2rfBnmdGJhWgdXy8GyEec0?=
 =?us-ascii?Q?Qk2JzDzcq7r7AOMp8dVi7+ZN09pOwhBBoI2RLRlNpY2bBEcNBcbWcd25x37W?=
 =?us-ascii?Q?kxtMtkLc5Pr6X26xS/PLiLB5QXSjyQqCcedhnZRmK0exitNUOUNdJi89N8h7?=
 =?us-ascii?Q?pyRgDdmOChBcZZp/iRJPavIyHhaM5cspFkiZQoedF7BShoPvZzvNqaRWuUxs?=
 =?us-ascii?Q?0UNpRkiZByf64rYlFn+GKfG5xUxo99zfc+Z2C0Iex9pZeU1rap4xh0A2ViwD?=
 =?us-ascii?Q?y/FYaXDfT9tcXeMDKcIcuheHNHhr6Qq+NP86IJlzrW5CirdwLUrTYlG6fMyc?=
 =?us-ascii?Q?74Q2F/AJl47TF/0UXoCw7Tq1W+c9WIloYc2g8IssABUg41kj9uxqiOozVIyA?=
 =?us-ascii?Q?7+rlflgxvxADVOjkQO0ihxCCtYV9Xvelk5BQpaqr4xcRHeQcDn6gk2RqabOh?=
 =?us-ascii?Q?vjJkLj//g61z6nLiK6MJTTH0CA5MjNK/kmoVoIX+koDKfcHHXubAU2LStoMx?=
 =?us-ascii?Q?bo59?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e91bfa-15b3-492e-210e-08db8f8a2fe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 16:46:27.4626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ghgsG44GbRdHWTDKkZqgp9K46OS56POVU0M3CJivgXTtWvsDvXCEGcgVEoJ+hObUP9q9ERLm9tyoC7Z3emgLomtklwplFQ9+tDlh0E5rFF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4512
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307280152
X-Proofpoint-ORIG-GUID: lExakXqnVmbY-RcF4sAHKP9-zsnydMm8
X-Proofpoint-GUID: lExakXqnVmbY-RcF4sAHKP9-zsnydMm8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On Jul 27, 2023, at 7:43 PM, Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> On Fri, 28 Jul 2023 01:38:40 +0000 Anjali Kulkarni wrote:
>> Jakub,
>> Do I need to revert the -f runtime filter option back to compile time
>> and commit with that disabled so the selftest compiles on a kernel on
>> which the new options are not defined?
>=20
> I'm not 100% sure myself on what's the expectations for building
> selftests against uAPI headers is..
>=20
> I _think_ that you're supposed to add an -I$something to
> the CFLAGS in your Makefile. KHDR_INCLUDES maybe? So that the uAPI
> headers from the build get used (rendered by make headers).
>=20
> Take a look at Documentation/dev-tools/kselftest.rst, I hope
> the answer is somewhere there.
Ok thanks, I will look into your suggestions.
Anjali

