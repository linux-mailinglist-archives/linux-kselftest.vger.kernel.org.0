Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7561767449
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 20:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbjG1SLP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 14:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbjG1SLG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 14:11:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893F44234;
        Fri, 28 Jul 2023 11:11:04 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SF4Odw031155;
        Fri, 28 Jul 2023 18:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=kWvy/JHQrY4dT5nyGbt13f/GOgnWvWM0bdkdv2YjiX4=;
 b=fjr/vnNCqBfZ/DLozz7u3dF3HoWGlqTHvk8qmekYBUfxPk2CfnrH8BoUVIdw5QhqH/y7
 KlpgJY3coc/mVIBNRy+UDyV6/pqdKnLuVQpeG962uJKrPldXvb8aoStaRnt/D7ztuP7N
 MZzxBsP2sW4XJA4PGb7Uq0q9oJhKhRkHg1JkDQLizhmYU0Sw6PIqMve3vUK51MMFdPWv
 arnB6TpbpyD0nq+tjbctPnSUrVrXIau57obC0Je7t98sb/p2c/nnuEZurG/YwRtDP/NI
 7j6BL88+jqmfZQld8qBsccsyiiYQOHm+zBLzAj85gevQR0e8e9ESSw7WgG4TD6y6Fmvn yQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s075dckp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 18:10:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36SHUH7p033463;
        Fri, 28 Jul 2023 18:10:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jfqanc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 18:10:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4dL8l6aXiyaojzuieGRpZdiQtI06qH21xfXgOlPciARNf7s0/vhZvBZsxQhSSPQvLWVkg1yvmbLjUIt3va1n3a7wOyITmPrfDxlfG3ng5YNND8CfUtgDP2iz6u0hOBAKHgWzc4FCfvmT7pjsqDqJ6VJbjhBRSgUhBlO7qpl0ISUzngfDPkaZVT8j9PysmoJvwdxOxCd20Ls6mhJohxSoXAvQ62BegFT/ZNeeJ10tSF/sP+bAsRjgCkxRHzn7F2ia34KbS1cPp+c+6aQtwSnOCeTdAujoM1xuWfkDV3ygm7Sm52R7u1nT+OSglNDlkHAK/zDDGZTczhm3vOUVW4CRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWvy/JHQrY4dT5nyGbt13f/GOgnWvWM0bdkdv2YjiX4=;
 b=XaNI12ylzfMEM0xENmYxu8G4hSlWHiGPrIDi96o5XdYoiDxfssu40prLoOrYNJoYx1gPQ7l1PernB+eMonoPNWxjjhbQ1HU6TbenPzydCkGhj/N1wxmLem3/fg/IJc5uV1VRKofbTmLoijIPYlgXI0hRIgzIUabOGo/otKJMGzC8396YyRVbJ9enKDbomvVZFq7So0qAX8lH22LvkfDV/SePV/ZzYLAH/Y9IHIitIMjoX/afvD6n4Np55qGjxNidJz56xOaFsDk6VJvN1HZAlGNmWgor6GMmlmxJEyE9Cv5hOrgQIpqHTH/p43vPc3rRGumA9p7yoXedADiDxxVLjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWvy/JHQrY4dT5nyGbt13f/GOgnWvWM0bdkdv2YjiX4=;
 b=BrIr6W4BES5PV35Ud+TOs68nFSQJwKBAKFl0lDW6M8LciXkGGjGysDqR1Uf9lC8tiBGQSL+0MireMD/GeSI62vnWwcByMlg8oMAddntdNs7nuzPMJHCRg93u4fbAlz3xomtd3Vl1065wQgkIK7haiuVYtCPROwqGPCXXTZ+pt6I=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by MW4PR10MB6560.namprd10.prod.outlook.com (2603:10b6:303:226::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 18:10:57 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::69d6:8729:ee7c:cc45]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::69d6:8729:ee7c:cc45%2]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 18:10:57 +0000
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
Thread-Index: AQHZwXkWbDEKB7ogokq33I6v8z/kP6/PesIA
Date:   Fri, 28 Jul 2023 18:10:57 +0000
Message-ID: <0CB227BA-69FD-447F-BE73-2482A6998F7E@oracle.com>
References: <cover.1690564372.git.skhan@linuxfoundation.org>
 <2c0ac97f9c8e6bd46b60854c136099c0dd4a09f6.1690564372.git.skhan@linuxfoundation.org>
In-Reply-To: <2c0ac97f9c8e6bd46b60854c136099c0dd4a09f6.1690564372.git.skhan@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|MW4PR10MB6560:EE_
x-ms-office365-filtering-correlation-id: b1d60fc7-6a45-413b-7232-08db8f95fda0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PN0M7wJ3jhNn0ZAQoxMWTphu1Taa/Hf+Wd5eiayyJiuV0am2SqT94EeScdm9qHwIzOfD31c2eAIoZLUU/086OZcwhvJHz0bviOVuaqxyW7HASNXSdArvaPUaKiIfgh+Er7UxamSnDcwdkgvhdJ+YCkOTjVQ5WPwZ5/WjXiFgMiEi8uFbQzJODg25+5gTlxrFdzMoFg6wtWLhoXYvScT/p8xjtK/SwJyxNEfOf15oMMe3zBSYnuMJe7D40fi3DiKgLeZutTYVgro+8SwNx2CiRMIbx9rOExRPZm8rYynvBavZkYzQdEeYtTiOZ+UV9ThJYqb08b2H64JwcLIYNhJn7Xn7elVr49VjMqQhr8xdQx5jlvhYJfY0nvk7zKnSkAnQrZa44f5ItlgWdpdkXwqZyG0lgknDzACuBU2Wgiag+mIwr0chUXtYRi9/slnbFtP4pQVdVtr13IH2277dGmy39G/fgL9m/OY68cT02M3a4yKMeqzFNcWOKntGhE8EFzx+Xdvb4ju0XwEi4wT718th77cmicyz4yvAEsMsLmMNXZUfGXlC5O4U+5x3AAsFd3e9GHLZM1GD4otyNYHf2VFGyOvWedY/H7kVme2lhos+x7NFiwM9ZFnLn+OvnM0qZQwo8ttbTJbtUzSfy4moNKxcMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199021)(2906002)(41300700001)(316002)(38070700005)(8936002)(8676002)(86362001)(33656002)(36756003)(6512007)(6506007)(53546011)(478600001)(5660300002)(71200400001)(6486002)(83380400001)(186003)(66946007)(66476007)(66556008)(76116006)(66446008)(38100700002)(6916009)(122000001)(2616005)(64756008)(4326008)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dfj6xtdk2BQs2jsBAVS1KVRLS0/VAukddCJk1Gpphv0riAMuRIRCk72YvE2J?=
 =?us-ascii?Q?XsOZSG5oaXg78efA9R1KeFbAz5ps6OhoW2OicU9wHwEL1T/x66yWnEmyOyzq?=
 =?us-ascii?Q?bBKOwcnkqBhsKbtvRbsGPuiXcMXQs900cq/vxzf6LONtJ7b/EdIdXKg8/oX+?=
 =?us-ascii?Q?elaVjDYyv+TlQoVJcGFNrpftJ/BZRzWkecJ3MwEASHlXF/SCiHJvEDfgBr28?=
 =?us-ascii?Q?Cr8gJVWxKQu9m2+TkC2TLDpDbId1mkzGjONs3iDLqqiTn4pfvFCa+05MrrOw?=
 =?us-ascii?Q?6ca567bdudN/n4Dj6LV9Q+O2CAMBYe7dknjtM7lZjkZ1s+jN/UucG9JKIz+N?=
 =?us-ascii?Q?lSwI0I19zU4t357ylEIDbAo4FtSmPc04UqmK0jj5wBLKE2O4ELO4Fqv9FJbw?=
 =?us-ascii?Q?O7LoM6nCJr6abhJu8nmssdKrTl1V3Fv0P1mucPsK63AHFf6WXvZCmd9qqTui?=
 =?us-ascii?Q?R582Tz8CezeF3d0y0p6/QYGctGfB8MbQLARNOo+YgKVRY04FMa9LdFPDiyTr?=
 =?us-ascii?Q?oI+rGalgQb+9L4TGHGq6/9LFO9oHUOS705SzuEDGjopQu8EE3o2KOxFPbcBe?=
 =?us-ascii?Q?1FIDNEoTWYPVjULyzaxNSDde4gT2csoQV5VxIFbo5RnFORXaPbzT947M9yLc?=
 =?us-ascii?Q?3kSqqPMPjcZbUqaJg7N9V7KIAp6m5NwvEp4Mpkff3E8YyVhNX3/l8U8rclHU?=
 =?us-ascii?Q?3M++TYdge76c85fMSCkVpRF40G/4u9M7e2msdX8LtKNVC94HZuH9PEVaUAfY?=
 =?us-ascii?Q?zdU2EzaQINKwA6CMlyWFqO/lC3lT1uRL4UJNZMBfOfVbLoHIttdZJKoALb7W?=
 =?us-ascii?Q?XzUtmeo+HjRPQeRh3EdZsKdQeZxq39KuMa0XJl6O6r4MT/BxtY1eqrnXF1fE?=
 =?us-ascii?Q?BVGGnB4XTOQDpvHl9QdkfffmOExO7Pa1I0cGBXIhwD7rh2qtnsXxWcLzJ8f0?=
 =?us-ascii?Q?9ECI0z0XE2RHmzBvRAzn90zckTbC7mHTRyakkrsfx3X5ckvGF9kFZBRbUEwe?=
 =?us-ascii?Q?lrRLre99R0M9JvqYf0K6Ro95qCXy7LE1NuwcK2T+BVC2AH8Aq/k0F/rVglOs?=
 =?us-ascii?Q?7kUv9HcZPKqyGJZ7GpDuJoZAm3is9bwh9NcQeV+9jIBK4ly7UtiVZxi0aSW7?=
 =?us-ascii?Q?W7ZenT8e6HDek1ilqG3AWTQ6YAhytyyuW29Sx74lwR3n0UukKFQBBjNWlc7J?=
 =?us-ascii?Q?SVWw6Ky4GJ117xINSHYwo9LxKmA4DZU86tTTk7GL3zTCjJc+ZhtBdPHkBL3F?=
 =?us-ascii?Q?9CSMZlCectNLcwKIEHSI0qbEIYkAwUrFegrrvtGXFBxFpRA0F4UUVW79uMe0?=
 =?us-ascii?Q?zy9uVa/zEoKB/QHqtMwdv0pGGSy5cWMG2z+f6CKLZ3sbFuR4KsiugAnFoUmd?=
 =?us-ascii?Q?HjcFhzx1aing8WGUN/5r3KSUXFrgcGYVqyZ2YZ1Y5WAkPbjR0uXdK0qfuHbl?=
 =?us-ascii?Q?pkTfn9P7200VwCzd5YAtF5OZ1pLvkFNHZaLom7WQToOoOxZXInSqp6tFsFOM?=
 =?us-ascii?Q?BY4EqKqq63fbZV145OtI/92HxTHb/uA5UCCEWktdrOHCMf40xEgrjUiukaxp?=
 =?us-ascii?Q?jqcnoYaRX5+OhdhFKmygKawojOO1On/DBfuHp09vrl2hToCJr12FgyGYFyuE?=
 =?us-ascii?Q?OkgsXp5LxYQJlUeZb/haQuOOmO61SdgtLPvBCz7KqsGlmpebczYoJVcVKwOR?=
 =?us-ascii?Q?y5qG9cdfhPhf5hwJajJUvjPUSMQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <70A68BFD5BB4BB47ABEC89ABF69FB3FA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6WlZtdobdyc61RUUZIEpxehl69lxX4sNbp6zubbUCmw9VfyzJ6iAvxtqQ6hW5GHqYpWk8kuyybLSt6U8eKcUrwpAqQnX9I+YkDeFS8Vq8Q3qJ3SlyglRfi64aDFoNm1vBmTIpfjJvOLI0LXn+UcHrO5kIM+5zUnSTqLZMan9okUyCqtk2pevJuthhbX1PJQa+kKyEMQrEgQSlydjlzkkIURdAgHPH6WZcot8Juy8a18F1q4MXofnh9+NsAxsF2TQFxeiYTQsqubJVRsRlwPdva8+54hLN4Sh1iWkPxKubjz0sqshPvKSUIszuVWtdm/R8UF4AOkfrj44/B6UnNDYupZkSMV1UfXzB1MuZRrpe1IHACEXLC98xuOnirH93XRHetKN9wtvBS7ePdXiHzZUHS28V4ODrR2GzMvfKCfyut7D1quu804kucCAfuvUKb1A75pWlvS4YzuO4d9yQlPSUQmpKIDvV41Y7y5Lvs7Z+8QAQCUDol5KwfMYJ8vkOEjvWK5O+ZsKKDuonUccUTkonORGQcMbrejlPxYlTl0cvO3YbMyPWzsTTiGOgxguIr0Rus9E4unSskjRgFi+lbugZnlklqP5R8j6MP1lLXCC3yzl3KswYyNYJcdZh3PbzXCoT3eTnA1ePowg0NOQroxyg2mJAETIeLL6KQm6Vn/UkTIZ7LUarO12aBBCl+W9DO0RtRwSp9LCY9E37ny0SYSN8xg0bjcvEw2FjpGojKtbRxe4LkXJUofl8V8MEZPU3VkCHpj39R9uLcDza4uuYn25Zu+/qmGS0TV2u8mrO96Nuo9ZuPIcF5N+RtzDdQGXncxX5PSJ5vq/Nt4Wqh7Ra02xGC+YHpIxLWI9FX3r1ouqDZifYCOwEBQ0L2c110ei1UWA
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d60fc7-6a45-413b-7232-08db8f95fda0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 18:10:57.0875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IDiY1PcoSyPvUfpPred37YxsobVa9AzigAX/D4iiZYi4vKjGqdqmxNWwfXTh2oFf8EYOqEB62j1Bis9aO1vL+ySs9wlZpyLkXLE8L/KPQYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6560
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307280165
X-Proofpoint-ORIG-GUID: xqSjhWR92XmyYjXFh_2U7agtJNzfyPWg
X-Proofpoint-GUID: xqSjhWR92XmyYjXFh_2U7agtJNzfyPWg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On Jul 28, 2023, at 10:29 AM, Shuah Khan <skhan@linuxfoundation.org> wrot=
e:
>=20
> proc_filter test requires root privileges. Add root privilege check
> and skip the test. Also fix argument parsing paths to skip in their
> error legs.
>=20
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> tools/testing/selftests/connector/proc_filter.c | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/testing/selftests/connector/proc_filter.c b/tools/test=
ing/selftests/connector/proc_filter.c
> index 4fe8c6763fd8..7b2081b98e5c 100644
> --- a/tools/testing/selftests/connector/proc_filter.c
> +++ b/tools/testing/selftests/connector/proc_filter.c
> @@ -248,7 +248,7 @@ int main(int argc, char *argv[])
>=20
> 	if (argc > 2) {
> 		printf("Expected 0(assume no-filter) or 1 argument(-f)\n");
> -		exit(1);
> +		exit(KSFT_SKIP);
> 	}
>=20
> 	if (argc =3D=3D 2) {
> @@ -256,10 +256,15 @@ int main(int argc, char *argv[])
> 			filter =3D 1;
> 		} else {
> 			printf("Valid option : -f (for filter feature)\n");
> -			exit(1);
> +			exit(KSFT_SKIP);
> 		}
> 	}
>=20
> +	if (geteuid()) {
> +		printf("Connector test requires root privileges.\n");
> +		exit(KSFT_SKIP);
> +	}
> +

I am not sure why you have added this check? proc_filter does not need root=
 privilege to run.

Anjali
> 	if (filter) {
> 		input.event_type =3D PROC_EVENT_NONZERO_EXIT;
> 		input.mcast_op =3D PROC_CN_MCAST_LISTEN;
> --=20
> 2.39.2
>=20

