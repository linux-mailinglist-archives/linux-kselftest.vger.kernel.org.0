Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1757376A37D
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 23:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjGaV4Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 17:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjGaV4W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 17:56:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2657C2115;
        Mon, 31 Jul 2023 14:55:50 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VKSSnO017803;
        Mon, 31 Jul 2023 21:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4+OLmM9hPw7BUmJDvOPaH5vRglyI+L0qkClJkZfosug=;
 b=hfna57WeOK2hwl+Td4YwORCwIsieN0xzDAXfPr6dW/vCIexP2L5a1MOC4xqEBiemmfUW
 Xu/fTBl+HqDhgFoCda6h522a96yjrD3mDnRAqLT5PLT0CamkWZ+1eVr+8jpqO5cZanK2
 ustiaE+fX2hoGrj0ZC5l5qP+Jvs8dwRP7X89d8nPf+FaCd2pcsHZ/I6TrL83gcxtnvp3
 MzS3dZOxDDn+DqSoV7L0VbHOH68WCXisgd6JNqEy7tKTUK/kEFM77TjPfvqXAa57j/hE
 yR5ajsJWBjkM8lQbdKmLZ6c+jc9Pf7/X1pnxD3TIPCdgGZTk+SzTegg8V/5Kod1MwNWl NA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4sc2bpcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 21:55:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VK9KF7013543;
        Mon, 31 Jul 2023 21:55:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s75ht5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 21:55:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDJ4mY0hVAfvItv8g2qvoNoL3pzdbS5i4ESDPxFOP4y3DeOX3deTnrg53e+cQMig3tjhVF7i4dJsFTJRGdgf6tTEIIY2ReXoBfPJl9ejkcnsquizBiuoS6RjUiRnBB6lBJo5ocmuGoXyXe3Vw2T7Gyx0T5q0hZaVEqnG6LaBwPc6C/kdatV6h1F9YIAiAaSR8AiAk3AlO1KQ6Ytkl4U3DzIbmquOacIU4uyFjiT5FuRtwSFxRhS4GBiiR/yBnoh1QDczMqZzcfnW2CrCj8szBUXDlVEsFFpnrenL9/90DbGiCwKvcUTUc5folbU5ROYGlBsfWGa9SidLaMKCWgNqnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+OLmM9hPw7BUmJDvOPaH5vRglyI+L0qkClJkZfosug=;
 b=HnC/kRu7nGS9BKfBV2JuYjam+gZ3y1w3LFsD18hnJtdbekEP+b/Lgjhn2ITWGgZpKAMt+K+WkFpS9qcZMkJGtTf0vM7hc+Ue8r3lfQtXKk+LoHBAocc16Fx+42GJMqS3VRvDJ+yHlXkUUlggHaA5z0Q3OKuyaOCEXPW5kMc/GXLqekBRwdd3doqX0qeNCD6fmPu6pktCi6AmOSmvatCnuIuhc77d09AFOLtuYbFfysZaMgIKge/lC4RRBk15zNTobWUgfxUESGk+Pulliofg1STFOYdfnBF/A+1h7zlo3o1rZnl5SpBkm1aYGf3NPQYzRHMAvv8JS/jk1nfLO4gmqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+OLmM9hPw7BUmJDvOPaH5vRglyI+L0qkClJkZfosug=;
 b=Oj27ojWKF2PLzFVtEIscy+viGmpuyro6oZN8p6lTEbXcX9cragVjlfM9iUMT2x5NF4bVSbXSV8M2UWUKD3J4UTTBrjFC9ScffrTSUB6hUOREQP5KNlB1/23TNHkZDNfj1Ds/w08ONNFR/jPfT2LFCy9SikhrDE3bvmhTUjiLkDY=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by SJ2PR10MB6963.namprd10.prod.outlook.com (2603:10b6:a03:4cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 21:55:41 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::da5b:2093:7a3f:24a1]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::da5b:2093:7a3f:24a1%2]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 21:55:39 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
CC:     Shuah Khan <shuah@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH next 2/3] selftests:connector: Add .gitignore and
 poupulate it with test
Thread-Topic: [PATCH next 2/3] selftests:connector: Add .gitignore and
 poupulate it with test
Thread-Index: AQHZwXkV+zpZeLueJ0Sm30//fO7xWq/UcIkA
Date:   Mon, 31 Jul 2023 21:55:39 +0000
Message-ID: <644777E4-ABBF-4242-A094-5E229827F8EF@oracle.com>
References: <cover.1690564372.git.skhan@linuxfoundation.org>
 <e3d04cc34e9af07909dc882b50fb1b6f1ce7705b.1690564372.git.skhan@linuxfoundation.org>
In-Reply-To: <e3d04cc34e9af07909dc882b50fb1b6f1ce7705b.1690564372.git.skhan@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|SJ2PR10MB6963:EE_
x-ms-office365-filtering-correlation-id: a958c372-5437-4145-4248-08db9210e0d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xGzTK2zpUiKRZhFNZ74dymlLxwZzPCmMgF/mfGwc9LiuconxQGdAh+hQNKGV3NaQwvUWKEN7SBeU9Yr+nr+YUvL9SP40RT8ddTaiurHnCVTpBw4lPeig7EsE+XL9aPOZ12ZlALQe2gOF6mrQ6kb58MWlt95hkmOw/CppMMIWMQ+19ixpTkx6ikYFVt/qbptY41AmWu+OIgCzmGLADO6EMA2Azz7vslOufTo/0uZa/iukGD+UyqwLEAqWzYWs69YX/vV7NqCWBg908oEuSZBJL/Z/IENKiUTG2zIK2rrjf6+tRNspYxOA68+UI+BeqW1Gn0rWfhJOvS4PZgX7hbYbpJoQjCKNuDgRksoi/Gnj4FS9kRgq8DhfxB8IlgjDT7AeZha6ZQBMoOxc+ze2dQTu3ljDW2JIhC9O6bGSOI4Puy34nyg9B0x4GqS6J4RU/SqCjd1rsZRaxL5HL+eijFzCSP2fnSjpsc2TltwK1TWbrQ3re1jmYDi/lrFsEIWUFMXmNl8FvXHNC77qgSO+YJqJRBh1ZrSXa9aDKU4o9FWiovQTMmH9KrhpwVmNbC7t6VWAFZ7ShYcJ4v1Wk8PbvWNiZOhNbSDIri9MHmtyseUSdiVn9Eb2jM0FgAY6WtIqKIpHLxOezdCVwO0Z9tSpcNDd90Uwinv4vdYQIb1a/rfo892T/Z6npdvrzYtyaJlXvawr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(38100700002)(122000001)(86362001)(38070700005)(33656002)(36756003)(6512007)(71200400001)(478600001)(6486002)(2616005)(186003)(53546011)(8676002)(8936002)(6506007)(5660300002)(66556008)(66476007)(66946007)(76116006)(6916009)(64756008)(2906002)(54906003)(66446008)(4326008)(4744005)(41300700001)(316002)(142923001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ns5XZ3UPHgrSMZtq9q9eRlKZpeuox7GkrGyoXsenxry5UMWrkOr9QPbBIqsJ?=
 =?us-ascii?Q?lAnQJso3/lWwdwVDmi1aHAt/x/BXhka+YdsaD8LmDWHJEGn7C1lrCySGtgL3?=
 =?us-ascii?Q?krd82YaZsLvu1fcSSI4KWP9BN9tckXj15BXDj/W+IqKwCjC/Uw94UXoeuFuQ?=
 =?us-ascii?Q?cVJXcbOiMimV08Bhn7a7NqDh1pmD3iN0qnK3kh1zc+2HIhWTEhup8IvrBXsp?=
 =?us-ascii?Q?tp45GHlBkqWjcsAeXwwp7sZ2cxxffmZaES45JAKaOg6ka9oFWCSEn4Q9yW1D?=
 =?us-ascii?Q?705+50/rYJ5Ox4gijhosmKGgX0REX0lj3ap3w8Fl/ZzY+JMenbmdRVvCIrHq?=
 =?us-ascii?Q?sj4jWatm0/MzLg9BOw3thveci5tb4z2i16d1En+am+RPcwiRWSLFAIJAqMks?=
 =?us-ascii?Q?iT7P4nMKd5VbOaHbl/ViEAHfo/QhCNSJfwDACKJpH3xkmLOs1W9KENVT50bt?=
 =?us-ascii?Q?SstAP89K+mc3pUPPJatAiYvx3sQhcC+w4/1biP0LpyLQU5oyrpTwD3AxmktM?=
 =?us-ascii?Q?9LJ0DqkXiIqghq8GCFnPrrMGoALaTMduAd6PH3LXvqrdufyNIKoAukivmoGT?=
 =?us-ascii?Q?Pv17vZMbg01svFuYYGFNQkqHdnGh81JHhixdjprtiRZ3vKt6BxtOv58A9/mh?=
 =?us-ascii?Q?WLd3musxEo4NDbQiN1H3CKW1y9O6RXcSjbkL7uVHhctDhnJ1T51WSuIWYGfd?=
 =?us-ascii?Q?wCn87yNN1plP6jxy/bzgXbL2LEOjhCWpuAjybVn+rPcImg3WAVGPwu0QEJBA?=
 =?us-ascii?Q?a2CbUMTFT531MN5pgunCWLW7XCRGZD0P6l2OD6vxa1Eit6xfGndN3BQ7f0Un?=
 =?us-ascii?Q?7IQw88NvSLFov1DXu04zvxkEz+n8XMrkK3hSdkbhQb3Dgi7g08sVjExdyowk?=
 =?us-ascii?Q?zuCdPETQmhYsnxECFWE7NZelvgch6s6ZYxal4Ra4e6tw0spvDU6Y2abMZ9/h?=
 =?us-ascii?Q?y3vgd4l5hVYImxCXmCK6eKr7otvoQVVXSo6dNJya9UaBvZFZ+NKfDcgqpeJ0?=
 =?us-ascii?Q?pm7n7z8EtgDagNRcXQZ2q8lQGgwe4DcqR6kyyZ0u/SR4P8iviggSfxoTecny?=
 =?us-ascii?Q?fSdJhpLxGQjYyjM7rAjeMKUxitbe7dDTUF3dQL0+dmfxpaifRldhYq+iVzPS?=
 =?us-ascii?Q?b3xr2vFibV/R4hXczwV9atqNNUzT3uQImHoPNC8G7NQSYyAl2jlMs3NqRbgb?=
 =?us-ascii?Q?zW02qBOARs8qWXOsfhIaScm7vPUxoeRUzOOLWPniXDiLdi99/5nKa0Hv9p7F?=
 =?us-ascii?Q?dz8+1OIqqvOYmUOZRw3jOAxk0ItQh/ps2E5E6BToGA64kOca9N49VMEmK94q?=
 =?us-ascii?Q?a9B63ZHEFRV1jpPSpwkSVvnexGopkefxHwaIbZpcmceS1o7w01H8z1b3qzug?=
 =?us-ascii?Q?3hbgN6PEB5j4trqp2bPpIPWfA0anm1ssscSEecLxvWoJqI1+5EAOVBOmB8C4?=
 =?us-ascii?Q?hObkqvG7g6YQwYBeZECCvzQ1SjjgHYHeNJBkM+ItgUm5/LW/N2m0hSD+3hz6?=
 =?us-ascii?Q?oC/GJLmH+7L4ys54BsjFmLwxlgvktceG0UJd5isjUSfbuivizAcq8JVTJV5D?=
 =?us-ascii?Q?7qyH/YP32OPAKC1bmBYDmFhLoD/yqIXsDcVdT2E7pPUHeEMOeaAYWXB0yfrz?=
 =?us-ascii?Q?WG50SPo4ki/HQVaakzlWJcBsLHUMNSk0JD2phFglngiqqfxgESKZNtTzXagi?=
 =?us-ascii?Q?FGiViSOezNFXA8mJjDDfaT+Rc5A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D5797EB5F4A49045B0EA5007194B8D50@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0v860rD6frdoZ+ZWmvw2jUvie+4nlaKwuELE/ViEwfJqURweRitG/J0sBKF2KoPe6ah1NVOoa2x696Q2u20rWb2ngA8ibLgvZbAoH5bXM6lS3mmXGrMos6sxKyBPNJ8ZX2qwP+vPD8v31fFtz6QnmEzcjj/hofjWbcXj2lWF65wFlR408eHWHJypS1oPm2JU1Txj7OzNyu3yWvY0Uobtl2vZ1bzYlwmzUvo0zcEX2Ck1QSLNy8XYSvxPoon7vnuIsYIDGhpLgdowaiNMS5PiNl3t3vP8xqVwiz6iOuenfZ717bmd+fOM9ZELcPiHmxZj747u1inKKEtaVHLaxuDfCJFJUJsu7NERmkSTn8ccylJirY8QxnPTHH4zuOHDVE1cOGNt2p+1gOx6Wb2Ac6pEcohC95v7r0I/n/HvmY1r4k1wvLdWRR5sKbVKGl4Ju1XhmUSVXeDC3SgLp6i5u/5AFm/u1umfNWXWd3BIMdD5PESm1iNx6E+UKRsBo/vrD550wNinSx85YnzaieQwMFQMkfFGT2qjBwnmAWRX4oHNQmVpSpiCdezthXcGvdGt8JWn6dakQ/DoR2CAxMPZj+PlDD4K0QvcjA0RHws2BWcfXgCPHmfDi2q+BMuO5qpa6/T1+cD2FEo43dAf4b3VcBA6j11OL88TnhyvGc+6Q+um3cXPZR+NSS6ET7a57YJBvy6Fm9X7AGAIxscSkfHZxWMvOm6e3ck4LPZriADbC7VM//P0sNpCfeWBLMM8t2WGBHJTYAmM1tZhHVPfB3Am+wrwC8YM/lzfrvsxJbXqMLS1OE65oF3uqGoLAW811dzoOuH9VGyrvnzSi2vDjKuUP8ajneQG8nzM2o2adWLNe+4cSJHYHEZepXxfuwzV/Zqk+PPp
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a958c372-5437-4145-4248-08db9210e0d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 21:55:39.2295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6gfLLI/vpReNANPnFpsJsvPgSvt5C4UPJ7As7hFh8eBnhz4PeeRNJOqnyQZooyYSpUyOtXvSSBCTFBtenzT9gAF2kMQ/izt0Hr/Wx9rWO3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6963
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_15,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310199
X-Proofpoint-ORIG-GUID: bsjIxC5NPsd_mZnJiTmVH7INJglI3RiE
X-Proofpoint-GUID: bsjIxC5NPsd_mZnJiTmVH7INJglI3RiE
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
> Add gitignore and poupulate it with test name - proc_filter
>=20
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Reviewed-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>

> ---
> tools/testing/selftests/connector/.gitignore | 1 +
> 1 file changed, 1 insertion(+)
> create mode 100644 tools/testing/selftests/connector/.gitignore
>=20
> diff --git a/tools/testing/selftests/connector/.gitignore b/tools/testing=
/selftests/connector/.gitignore
> new file mode 100644
> index 000000000000..c90098199a44
> --- /dev/null
> +++ b/tools/testing/selftests/connector/.gitignore
> @@ -0,0 +1 @@
> +proc_filter
> --=20
> 2.39.2
>=20

