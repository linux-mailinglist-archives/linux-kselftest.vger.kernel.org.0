Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E497677FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 23:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjG1V7m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 17:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjG1V7l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 17:59:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC671DC;
        Fri, 28 Jul 2023 14:59:40 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SLjSUI022687;
        Fri, 28 Jul 2023 21:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=OtHT8aLtmgKCxciGYlQPGUuVLSsiHgmQY8zfBOzFhGM=;
 b=vR1/CEH1hUPs1NH+RTb1xtvWmHznxDOU66inogC6caiF27vY6f9L/InFF+pfQUG7gx0O
 tc0eEh9vC9FoQ1chW01cCkVZNCAg+2/hN4P6Cap0P30r7QixRtkj0xZjcAHRrJT4SEC9
 VsXfQ8UGJDTJzA6eOMM2jCvOi+a+HBlkovqyqhazINlSKGT3MCjj7tF+2WUaT5GfOWz9
 7ojVo+HR1CKXZXwXoPVLcfDQ36JcdnE7LxYiuAtr7OgCERFLCSJGPkJSHDI/YBQaQg9H
 KnEzbR70AU7ag16D5GXSoG2WMXOsNpVyh02fT+kYrz7U9EyX7i0rWj7EPNpZNvsUo28x Qg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s06qu4s3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 21:59:35 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36SKFjHO033357;
        Fri, 28 Jul 2023 21:59:35 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jfyqjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 21:59:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJ/g2fR044rCkuBH1+F7yiessyEMtU5roOLmQI7tPl4CSl8jR5j6gAX0unHmpRpNBH5LPd3usDxtOKedqoa5O9UKsvGzGRkm60SzcGqtSqOXDV5oKDFmtdXbStbNOZ6XMGSGPPYY1kEGFAx5ePJFpKs1Fq+GhqpsGly/DsKqpDF0foxGtkFp0PtH90ooeUnMFXOiKHlJ62W8/RuPsgUy+zjCe/x7V3S/KL+aL+taYJZzKOlz5RZsZtKmLTsFfaDQirKDwSRl/Xl4TwR0zayiQVjzEoYo3mPPBRQxQgDJomhnG4mc6qdV1rNm+wlRNA8mNG046CpVdwkQgLfuIBfyjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtHT8aLtmgKCxciGYlQPGUuVLSsiHgmQY8zfBOzFhGM=;
 b=SHzNkqv9jIMU+lf6Zb21QUxfVxoJDexLdowjAGFaRbIOlPVUBzO4EQJ41veC6/F/0VClKj2dC5HBxiWPBcMH1xKSiiDS45gIRnWpk4vevaqHFNG7jbjwyXL6wxu0U5tysgWhEqp6oK7OD7mIt7Rt6yQ+i89v/5tfmPE9LYS5gEZveoi53Ggpd7HU6tiPVDp9o86s+yQcJIr0TwXNu/T73Ek1yItHaIczcerHTBzbzhtQtQXw4v+8P5dv5dGDhS3U9H3t+kvNqZVX11ae1Lv4kFp95YM8M1tCk+fH/UYRLi7ovDJ8bmbT3h6VspyIZohZAuc9ie93i/LVCsJ+aGAc0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtHT8aLtmgKCxciGYlQPGUuVLSsiHgmQY8zfBOzFhGM=;
 b=QGNZkbfOfm1rp070BXOz5xkgweweE0ZrJGWrNqv7HwGNDoLWWedw78CvAeY4/kunxMF42xitjMwZDeTYiyhzUQsEh2gs+J4Pvjd01QYr8YeFuphRU08Zt5VIbP9/SNaLp1+24su2J8m+N6AG+u6xukNr0BsEdcK1Y28qBy7eAno=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by DM4PR10MB6157.namprd10.prod.outlook.com (2603:10b6:8:b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 28 Jul
 2023 21:59:33 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::69d6:8729:ee7c:cc45]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::69d6:8729:ee7c:cc45%2]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 21:59:32 +0000
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
Thread-Index: AQHZwXkWbDEKB7ogokq33I6v8z/kP6/PesIAgAAPagCAAAqwgIAAGwgAgAAFxYCAAAT4AA==
Date:   Fri, 28 Jul 2023 21:59:32 +0000
Message-ID: <3242346A-9B09-44F7-A062-8456F83372C7@oracle.com>
References: <cover.1690564372.git.skhan@linuxfoundation.org>
 <2c0ac97f9c8e6bd46b60854c136099c0dd4a09f6.1690564372.git.skhan@linuxfoundation.org>
 <0CB227BA-69FD-447F-BE73-2482A6998F7E@oracle.com>
 <5b283f3b-f176-7f19-5db0-1332a94a44be@linuxfoundation.org>
 <ec809279-cc41-7e0f-a567-29400b4c34a9@linuxfoundation.org>
 <16B47831-5F53-4BAF-B347-A1404D2ED264@oracle.com>
 <957be0e8-2bdf-80f4-92b7-3b9070c546b3@linuxfoundation.org>
In-Reply-To: <957be0e8-2bdf-80f4-92b7-3b9070c546b3@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|DM4PR10MB6157:EE_
x-ms-office365-filtering-correlation-id: 1732b638-1949-4bba-26b4-08db8fb5ecdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KkH/IuiGrnT08y/J23zhps1dlS16HGhDDZUBhDduCU+PsRPh8AKZQCXp6fHJ6KQgQvMwwOl3WrD+UPbxsRCqrHEwKSJx0mqnDX51t9rJ+8PXdNZDBkqbIKJRUHZWzXqXlFiAW8M7SOG2uQ98MqawJyO88bucSJpNBqTAHWMQBix+7ZL2vQ2UuMnvNto5XSOWQOsojA16jDd+UXwPb9ByFnqyk6pOj0MFNrHMPA4CrbheSDd+M5QLlepvzfkZhe91cgI19jVJs0oPFkaFO+uVJDsWbob8XCnTdMQe8byadh9GlnQb/91Dos/p0j91Ib3LDVoLYLJii/QLyhQPqdHiDr21exyIoHPUnS39SwuYTSDldX5snJolwuJ/xM4WK4ooNdrHEdEDWD6vVK5XkyMsOXrtbq2deb52AIgYbXxQTY3cFWkrb0e6IAAjcR2r4v13MqIKuOQKt52f2KbPPslB1lpuQLk6UDO20VAp9MVmRviYYnpgkooPDQSA6dCw5XEyt+0vB3t0VkQMxpcMedJQu2mVE3y3HIVajWtorPbQSwU1SAqqguo8UusIXtffdjlMWvmwBT2fC4UpQWFoe+c1QkE+p1xYIR0FK3im38NDGoehcd/KZ4SLds0p7AC+3Ocwal/tC8cRDNwyHph+1zvPoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199021)(36756003)(186003)(478600001)(33656002)(71200400001)(76116006)(66946007)(6506007)(4326008)(64756008)(53546011)(66556008)(66446008)(6916009)(316002)(66476007)(41300700001)(8936002)(8676002)(54906003)(6512007)(6486002)(86362001)(5660300002)(2616005)(83380400001)(2906002)(38070700005)(122000001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THYybGdsUWJaQnNFNFNIYXpEVDhoZDRta05QclpuTG8zZXJIa01DWTQ2SG9D?=
 =?utf-8?B?K25US1prMjRldDB6ZDBDa2N0blRsbmlnRldKWFg4L0twYkhieEJWTTh1OXE4?=
 =?utf-8?B?bXdnRXBoQmc4VUNUSGxQODBLK1R1OEU5RCtoUjdEdENOT25oUWJYWUxjQm5u?=
 =?utf-8?B?bHhOSVl2YVBBSGpYVlBXVUhtL2tpU2ZpaThXZ0ZiR25uRndBYldibDNwekRM?=
 =?utf-8?B?dDU5aThUSnU0TVFBbnhpUDdveEVGbnBhME9hVEg4MXVzbjlwYkFnd21XeHR5?=
 =?utf-8?B?VEs4QzdIa2JKRUxLR3JoY3dpWkxGTmRFaWlKdGRSZjBYaDRnb0FHOFpIK0tB?=
 =?utf-8?B?M2RLc0d3blUwODdZRUZ6K21CdE1LLzlGZkFmSnp1Mk95Z256VFdUbUoxVzFm?=
 =?utf-8?B?OGxKV1lwRmRmc3lZQXhka3NXVnpvOUIxeFJjTDdrNm5Pam1wSi9ySlNCT1J2?=
 =?utf-8?B?MUZyS2lYdUFRWmwrb201dEVPMVBvUXY4aDhQcDhoeXJicVdWVllZRFMvMHFx?=
 =?utf-8?B?cEEwM3g0M2VVZU5NMlBVS05Rb3JRa1V0WW5tdWw1c3dFWVQwcHlQd29teEhQ?=
 =?utf-8?B?Vk1TUTNzM2NUNTF4ZlU3bENjMlBJOVZiYlh4NUU4RGwyWUhjY2NFT3BOam9i?=
 =?utf-8?B?TUpuY0c5WUFJeVc2RTJQdXl5U2tBdmVRcVdWbUpyMElwejhSRFZpNUlZNGFB?=
 =?utf-8?B?VVgzcXIxVWF2eUJrdGVvV1Z3ZVV5RDhNTld1UUxFTlhOeFBOM3R2RWVoc09l?=
 =?utf-8?B?dFkyb0Z6K2h1NytUa1JOSnFpMzdZNUZvc2xxcFhDZXkrREcrUHQ1N3ZQSFJm?=
 =?utf-8?B?QlpyT1c1UXkvejlJcEtUVEF4YVMyNCtjZkRBQmkxZVNYYkFMS0tKRDJHTEY2?=
 =?utf-8?B?eXdtamd0ZGQxc2lmdWZ6ZUp5YzlzMkhGeWlmMWlGRlMvbjdBelNubS82enBs?=
 =?utf-8?B?SWFNaTBzU2lMMnRuOWFycEV2T09vTGZQdi9SNW9NY1I4UHQvTlhtbHJmVlhQ?=
 =?utf-8?B?aStIN2NKVTlPSGptS2dNWTlUWWR1bzJqc2c1TENlQWI0bWNrUkR4VUtTY1J2?=
 =?utf-8?B?aUJDVmxiekV2ODBBRXVoNlZqRnp4SGw0MWl3RkhlbXhZcnJBUk5sR2NYRGIx?=
 =?utf-8?B?YTQrdlJiL0U4WFVuMWdFQURob0dsRjViK1paVERPZzBwamtJRTZyRXErWk1o?=
 =?utf-8?B?NHllcEpCMjgxNXEwUUM2Q1k2SFc0bEdlR0xiQkxDbWRWam1DdStRZGZZU1ZN?=
 =?utf-8?B?a25hcTVKdGpCQnFHNy9icGdNNkZVdU5CNlhVR2FlQnlibXE5V0V5bllaRmor?=
 =?utf-8?B?QnUxejBSR3ErNUNwS3pHdFBSaCthR0FESVlZRHdJbzcxYVNCVGs4bVN4VXJU?=
 =?utf-8?B?NHM2a2d6MFlqRlJ5aFEzWml1elVuUzU2b0YwcDRwQnBUejhBM1g4Y2Vqa1pG?=
 =?utf-8?B?bWRQcnlyb09vNmU5clgyaWRCeXhuaU9jd1EwanZvcXRRYUk0U0tteFNCQmF6?=
 =?utf-8?B?dzhnM0JPdmJFaGJNbVBCRU5HRE9QTmEySlRkZUdqa0V0TERIZU5IRElNbENw?=
 =?utf-8?B?azg4cDRQaS96S2cvUE81RWw0NUVxV1BubXVDb2ZPYk1RbG9ENUxCU3JwclJt?=
 =?utf-8?B?eDV0RzNpUVREZFlaeFUwd1d0eWxZemo3bG1GK29Sb2dVQUY1N0pxMlI1Qm4r?=
 =?utf-8?B?bkp6REllNzFyN3Jib09vbjJtdlFVYml4Z1ZoOWU1V1FSaGdYMnhvQ1NZOGpI?=
 =?utf-8?B?T2dkbU1HVjMrdHNRL1luY2lvWHllbENVdjUySW9ObjJ1M2VYMjI2bzlSRXBG?=
 =?utf-8?B?N29XTXlCaVF6TzZuK3lQMjF2VlpGaEhyR0VNRkErSXFlTGpNbTd6WmpiR0JU?=
 =?utf-8?B?dFVzbHRQSEIxRXVOaVhwclQzOC9kRTdwOWFqK0l4bWNGSmY1QnBvWkFRUUhK?=
 =?utf-8?B?MHNlMGRNN1kxWDNuNGs1RStIS0N3TDJ5ZHF2NFQvRkFPVW1NWHYzeVdpeTd4?=
 =?utf-8?B?ZnhqRUFFcHo1cDlpbGlhcTBXQTdveGs4cWE2dUMzVzFqeEpoOU5UanVtbnBH?=
 =?utf-8?B?N2lwSmt5SzJLTmFIck41aHlVa2hoYXJkQWcyeDJQTE9EbVNWa25aKytNRjhl?=
 =?utf-8?B?d0RIM296ZmxBcWFSTmowWTJxd2VMVE9sUHczV0tYTldxZGZmUlFoRWJqb1Ft?=
 =?utf-8?B?WjMzWkhmYndjNlBGdEQrdTJpcWVEMVRqcXEzUUdTWEtGMi85dkVMZld2cDBV?=
 =?utf-8?Q?UH0OMciClLY5PwitAo/iN82JqZpAoEmaTIvamICPzw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9287C1C2094224A92486337518C0E93@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cW9P4EflVUq2MA50iPUTL44tJJxl2kDULHE+N/ivIfNDzVtKLXbOMDWm2QKuy1CowZGA+ASv7zwLIdh/wJ8Mb+ejSdnPr6fEvxWr5UAIYJdJDwgy2tYjpqHk92WWUo9lDrKFJ/KeIKBX5UlFlFSV2Stpz+V1aal2ZFZzCWZLmhxiFdg70aMgjH9lL4GL2juiny4icrtXPbJERwAyWvtwDo2vJqXWaAHm4a6kV6izZm/DpSvx8hjPr6Br3/CHWCxtsZ5WkXCYNCN9vrKxX6wg4nehAa3RpLJZoiYzKavRyQAEtlGWk7yTbuYQHXiFqRX13bX0xzndQZHJNsTQzjzsnuFpKCm9dvp0hzKum6ajiEE8NodB0NSZG3ENcPPueJ7aaG/5ZjXnxosZ/3Rf8x01DgflLnMc5jjfgQZmqSpx1ZLZqUxJFlA56IRA3gmJsipzX6wtdlYK0Oxy7RbxO75h2YLKNgMsStF8i2K66R3rZ9ZvPB8YrIFvqZd2EJCR5TaMKjC6LF9+H1yCNFZcbsGuJ2PPz9C0x7Yj16MySJ3H9DPsEwTGih4miUTlvTFbKnU13v/0bd4JUR3S/h+OOgnASVXGWVMtXN+zOO5TUlWCJwinfwhVqUPPobvBvUVyKZHEjkgOC9eo6Q2fu5n+WSJTjZois4DtDEfsxtAKedfZdS9IBtvMjYnkZgyIndq5eFxs3Qm4dp826IzoLSZnoypQdVTu/b3i1H2tI1QtqIy6jtQHhf4grKEGpjiZQmVbVoVsBfCMdFYqnraXw+xsCOrM6Cz5f8l/1f8rQWZPNrfvXfDJMh5PNaT7AqyMgo9rElnjCtw5iNoYyhhS+RQ8dZ/Yly3HDVMQWE2hu88/yKOeg/1iBp+nnX5aM5CjaslKe7+r
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1732b638-1949-4bba-26b4-08db8fb5ecdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 21:59:32.8414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qzf87CWLLSRL8ANmFH5woBCrFjrUQuLiZZh7sTNw9EHrT2v9dJNDaTvfZwdj1fkiUn0EHvRqv4EqnDjVaGHxk6PvZF/0Z6kcAcqKsdlyOU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307280201
X-Proofpoint-ORIG-GUID: 0msTk2VgcG1FUh3MwpjydO0PxFm1dUMS
X-Proofpoint-GUID: 0msTk2VgcG1FUh3MwpjydO0PxFm1dUMS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gT24gSnVsIDI4LCAyMDIzLCBhdCAyOjQxIFBNLCBTaHVhaCBLaGFuIDxza2hhbkBsaW51
eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IE9uIDcvMjgvMjMgMTU6MjEsIEFuamFsaSBL
dWxrYXJuaSB3cm90ZToNCj4+PiBPbiBKdWwgMjgsIDIwMjMsIGF0IDEyOjQ0IFBNLCBTaHVhaCBL
aGFuIDxza2hhbkBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4+PiANCj4+PiBPbiA3LzI4
LzIzIDEzOjA2LCBTaHVhaCBLaGFuIHdyb3RlOg0KPj4+PiBPbiA3LzI4LzIzIDEyOjEwLCBBbmph
bGkgS3Vsa2Fybmkgd3JvdGU6DQo+Pj4+PiANCj4+Pj4+IA0KPj4+Pj4+IE9uIEp1bCAyOCwgMjAy
MywgYXQgMTA6MjkgQU0sIFNodWFoIEtoYW4gPHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdy
b3RlOg0KPj4+Pj4+IA0KPj4+Pj4+IHByb2NfZmlsdGVyIHRlc3QgcmVxdWlyZXMgcm9vdCBwcml2
aWxlZ2VzLiBBZGQgcm9vdCBwcml2aWxlZ2UgY2hlY2sNCj4+Pj4+PiBhbmQgc2tpcCB0aGUgdGVz
dC4gQWxzbyBmaXggYXJndW1lbnQgcGFyc2luZyBwYXRocyB0byBza2lwIGluIHRoZWlyDQo+Pj4+
Pj4gZXJyb3IgbGVncy4NCj4+Pj4+PiANCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBTaHVhaCBLaGFu
IDxza2hhbkBsaW51eGZvdW5kYXRpb24ub3JnPg0KPj4+Pj4+IC0tLQ0KPj4+Pj4+IHRvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2Nvbm5lY3Rvci9wcm9jX2ZpbHRlci5jIHwgOSArKysrKysrLS0NCj4+
Pj4+PiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+
Pj4+IA0KPj4+Pj4+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jb25uZWN0
b3IvcHJvY19maWx0ZXIuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nvbm5lY3Rvci9wcm9j
X2ZpbHRlci5jDQo+Pj4+Pj4gaW5kZXggNGZlOGM2NzYzZmQ4Li43YjIwODFiOThlNWMgMTAwNjQ0
DQo+Pj4+Pj4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY29ubmVjdG9yL3Byb2NfZmls
dGVyLmMNCj4+Pj4+PiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jb25uZWN0b3IvcHJv
Y19maWx0ZXIuYw0KPj4+Pj4+IEBAIC0yNDgsNyArMjQ4LDcgQEAgaW50IG1haW4oaW50IGFyZ2Ms
IGNoYXIgKmFyZ3ZbXSkNCj4+Pj4+PiANCj4+Pj4+PiBpZiAoYXJnYyA+IDIpIHsNCj4+Pj4+PiBw
cmludGYoIkV4cGVjdGVkIDAoYXNzdW1lIG5vLWZpbHRlcikgb3IgMSBhcmd1bWVudCgtZilcbiIp
Ow0KPj4+Pj4+IC0gZXhpdCgxKTsNCj4+Pj4+PiArIGV4aXQoS1NGVF9TS0lQKTsNCj4+Pj4+PiB9
DQo+Pj4+Pj4gDQo+Pj4+Pj4gaWYgKGFyZ2MgPT0gMikgew0KPj4+Pj4+IEBAIC0yNTYsMTAgKzI1
NiwxNSBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQ0KPj4+Pj4+IGZpbHRlciA9
IDE7DQo+Pj4+Pj4gfSBlbHNlIHsNCj4+Pj4+PiBwcmludGYoIlZhbGlkIG9wdGlvbiA6IC1mIChm
b3IgZmlsdGVyIGZlYXR1cmUpXG4iKTsNCj4+Pj4+PiAtIGV4aXQoMSk7DQo+Pj4+Pj4gKyBleGl0
KEtTRlRfU0tJUCk7DQo+Pj4+Pj4gfQ0KPj4+Pj4+IH0NCj4+Pj4+PiANCj4+Pj4+PiArIGlmIChn
ZXRldWlkKCkpIHsNCj4+Pj4+PiArIHByaW50ZigiQ29ubmVjdG9yIHRlc3QgcmVxdWlyZXMgcm9v
dCBwcml2aWxlZ2VzLlxuIik7DQo+Pj4+Pj4gKyBleGl0KEtTRlRfU0tJUCk7DQo+Pj4+Pj4gKyB9
DQo+Pj4+Pj4gKw0KPj4+Pj4gDQo+Pj4+PiBJIGFtIG5vdCBzdXJlIHdoeSB5b3UgaGF2ZSBhZGRl
ZCB0aGlzIGNoZWNrPyBwcm9jX2ZpbHRlciBkb2VzIG5vdCBuZWVkIHJvb3QgcHJpdmlsZWdlIHRv
IHJ1bi4NCj4+Pj4+IA0KPj4+PiBJdCBmYWlsZWQgZm9yIG1lIHdoZW4gSSByYW4gaXQgc2F5aW5n
IGl0IHJlcXVpcmVzIHJvb3QgcHJpdmlsZWdlcy4NCj4+Pj4gSSBoYWQgdG8gcnVuIGl0IGFzIHJv
b3QuDQo+Pj4gDQo+Pj4gVGhlIGZvbGxvd2luZyBpcyB3aGF0IEkgc2VlIHdoZW4gSSBydW4gdGhl
IHRlc3QgYXMgbm9uLXJvb3QNCj4+PiB1c2VyOg0KPj4+IA0KPj4+IGJpbmQgZmFpbGVkOiBPcGVy
YXRpb24gbm90IHBlcm1pdHRlZA0KPj4+IA0KPj4gWWVzLCB0aGF04oCZcyBleHBlY3RlZCBvbiBh
IGtlcm5lbCB3aGljaCBkb2VzIG5vdCBoYXZlIHRoZSBrZXJuZWwgcGF0Y2hlcyBzdWJtaXR0ZWQg
d2l0aCB0aGlzIHNlbGZ0ZXN0IGluc3RhbGxlZCBvbiBpdC4NCj4+IFNvIHRoaXMgY2hlY2sgZm9y
IHJvb3QgbmVlZHMgdG8gYmUgcmVtb3ZlZC4NCj4gDQo+IEkgd2lsbCBzZW5kIHYyIGZvciB0aGlz
IHBhdGNoIHdpdGhvdXQgcm9vdCBjaGVjay4gSSBzaG91bGQgaGF2ZQ0KPiBzcGxpdCB0aGUgYXJn
dW1lbnQgZXJyb3IgcGF0aHMgYW5kIHJvb3QgY2hlY2sgYW55d2F5Lg0KPiANCj4gSG93ZXZlciwg
d2hhdCBpcyBzdHJhbmdlIGlzIGlmIHRoZSB0ZXN0IHJ1biBieSByb290LCBiaW5kKCkgZG9lc24n
dCBmYWlsLg0KPiBUaGlzIGRvZXNuJ3QgbWFrZSBzZW5zZSB0byBtZSBiYXNlZCBvbiB3aGF0IHlv
dSBzYWlkIGFib3V0IGJpbmQoKSBmYWlscw0KPiBpZiBrZXJuZWwgZG9lc24ndCBzdXBwb3J0IHRo
ZSBuZXcgZmVhdHVyZS4NCj4gDQoNCkkgZGlkbuKAmXQgc2F5IHRoYXQgLSBwYXJ0IG9mIHRoZSBj
aGFuZ2VzIGludHJvZHVjZWQgYnkgdGhlIHBhdGNoZXMgaXMgdG8gcmVtb3ZlIHRoZSByb290IGNo
ZWNrIGFuZCBhZGQgc29tZSBmZWF0dXJlcyBvbiB0b3Agb2YgZXhpc3RpbmcgY29kZS4NCg0KPiBU
aGF0IHNvdW5kcyBsaWtlIGEgcHJvYmxlbSBpZiB0aGUgdGVzdCBjYW4gYmUgcnVuIGJ5IG5vbi1y
b290IHVzZXIgYW5kDQo+IGl0IHNob3VsZCBmYWlsIGlmIGtlcm5lbCBkb2Vzbid0IGhhdmUgdGhl
IGZlYXR1cmUgaW5jbHVkZWQuIEkgd291bGQNCj4gdGhpbmsgdGhlIGJpbmQoKSBzaG91bGQgZmFp
bCBmb3Igcm9vdCBhbmQgbm9uLXJvb3QgdXNlcnMuDQo+IA0KPiBUaGUgYmluZCgpIGZhaWx1cmUg
c2hvdWxkIGJlIHNraXAgaWYgaXQgaXMgYW4gaW5kaWNhdGlvbiBvZiBmZWF0dXJlDQo+IG5vdCBi
ZWluZyBzdXBwb3J0ZWQgb24gdGhlIGtlcm5lbC4NCj4gDQo+IHRoYW5rcywNCj4gLS0gU2h1YWgN
Cg0K
