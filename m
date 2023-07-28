Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3199767789
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 23:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjG1VVT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 17:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjG1VVS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 17:21:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B892D4D;
        Fri, 28 Jul 2023 14:21:16 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SIEFGW021560;
        Fri, 28 Jul 2023 21:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=RBx9ZSWMp9kgLyTxojAXuw0SucPqXVJ+Jy/SSid2Oz8=;
 b=eWqDTXf+XmWBNFGinDskGa/4DQeV11TxFsnh/D8Bev7rXS7pX0GFjK5olJTj6MebMTd9
 VN/Mq7dvCiN2MEhns7YlIQbWI4HSAB64LRlu8Caonld1Q7iRiLXQIVnd833BG3hZmNLF
 T2gix1Rqb80eAD00tCRvQM/H+KRBJVtFyqV2qSR42mpHgReeWpPqycpEl+tog+fTyloZ
 VvG+beDFlr5gxJveswX2SrT0c3l7wkbclizJG7qad8o9bv4dqEK+5GG5b/q0TSHffnQp
 b9G9rVqmJe46U6oKqL/7UzRywVXkwfyGgq4NuhDNeya/oWvlr89QUOxR+jfj1tTGn4bE JQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s075dcwgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 21:21:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36SL08qJ025271;
        Fri, 28 Jul 2023 21:21:09 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05ja3w2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 21:21:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+FhAWMZ0pmFnI7WdZi7aBXsvfgD+enqo1SgJ0eWfZ94PIAByWEGFqqr/MV0f1nyn0956//F3UCanfCZtORUj8n1UtvMEK2f0sAoxFH7GN0dq+j9l2o8cLGS/7LnsDO10VEkT0Lx4c0oUgEacrntDVqI3VaeGxNxkHUDxsKCrK0MKQSQBq0K0sk3KQnKEYWRer5SrKbBPgOJpnXU0N5cAMDJWKgZ46WZaJKFQtsZMAvj2oKfpRsD1YTAMuCbnhU/U/+zFHzvvf3AHiAnzqpbClSCuAto/vAovYF2xJmO9ycSA59LohjfG+4k3rk9MEBgpFWoBemtmlLNRf892yVDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBx9ZSWMp9kgLyTxojAXuw0SucPqXVJ+Jy/SSid2Oz8=;
 b=D6MocyP31FndkoF0JAJjIO9PheRHVL6jz+6Txjg0Op8G+zK1lcQHw6mdoD3E0Cwh7rc9eC2AukCvhEQk4f7aq26vGi9kC0CG8MsVWOLHCsrdeQJ0RXz5cgNOprzI10jmmFRLIcTYkGIfuK7nP5+gGFB+Xq/MJ6jNKN8XmiFbJ0J6fSs+/Fzq0s3hN7PM70/v9shW8vwzxFeLG3HpXG26FNBdKP1H5CZumXq4PPBsbAD4RVva2a3ngal7pNWiNrURUwfiCj7/uZc/dZ0QnAPj+lotXlihOcGV/iU2WYeO7m+HEwsMZHX3LaZT6nCHgecXE/HLBF8TFDKAca2vEDAm6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBx9ZSWMp9kgLyTxojAXuw0SucPqXVJ+Jy/SSid2Oz8=;
 b=iWcCjjzeZ6CrbBkwto4SlxskGdxV9Cxt2PtPhLP5ecldfxmN5j6lSV7xAoSKr4Dz6cY3qSzb4fXA9JCzXScnTzxTgpU9l2FRsQzG8tHNDgsWeER9YSNEKWFCVmZML7axyhIKqxAgXFWxoPaIP22TWNGTllv2anMVEY0hmr5sTvk=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by PH7PR10MB6402.namprd10.prod.outlook.com (2603:10b6:510:1ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Fri, 28 Jul
 2023 21:21:07 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::69d6:8729:ee7c:cc45]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::69d6:8729:ee7c:cc45%2]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 21:21:07 +0000
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
Thread-Index: AQHZwXkWbDEKB7ogokq33I6v8z/kP6/PesIAgAAPagCAAAqwgIAAGwgA
Date:   Fri, 28 Jul 2023 21:21:07 +0000
Message-ID: <16B47831-5F53-4BAF-B347-A1404D2ED264@oracle.com>
References: <cover.1690564372.git.skhan@linuxfoundation.org>
 <2c0ac97f9c8e6bd46b60854c136099c0dd4a09f6.1690564372.git.skhan@linuxfoundation.org>
 <0CB227BA-69FD-447F-BE73-2482A6998F7E@oracle.com>
 <5b283f3b-f176-7f19-5db0-1332a94a44be@linuxfoundation.org>
 <ec809279-cc41-7e0f-a567-29400b4c34a9@linuxfoundation.org>
In-Reply-To: <ec809279-cc41-7e0f-a567-29400b4c34a9@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|PH7PR10MB6402:EE_
x-ms-office365-filtering-correlation-id: 75559669-358c-42d1-c6e5-08db8fb08ec0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EKHeIInJg4Ts6gO0eAOjFNaceSj16YRIlQvwgych+JaqHRkXwPofGyaGXrxg+tdHGN+S/HPVRX5NX0K7OhBzq8V9de7e17KR6qPYcBS9IZLT+DvLHNVMWJVuOYGT5+Ua8k7rEkppj9Q9e+sVpwzven3fpce2NAuOnZRQH03NZ+Ts/WUtlWElk++rdPoB8Qnn/HGSbh49fgrDQXK8iadXj1McJd2v3tsrGmCNajZr7m1+EQQOuPkEEq5amiM2o4Wm3UKTafUlQd1zBVuVFc+p61FFDGFqTDa/EM0svsNRFzLbMPiIz4Xwt2t7I76AaaErXyfGF4MPFJz9FE9mmqrKe0ex7fjCYjF93G2dwjCfeO2Lm8EIUqiCmcfY0bkE/MFx/KZiKCHMOsxwt4ZGu712UHUD585Ng5bUsJmCv8MUnCPTgS69x943zf0HGeTRO8JKWApGMLPGxGRLmt/AlyJ/owQyRzudbfCSP3WxXQP761iihL28Z08o+ikFQZceZh0QVPBgSTgsbiHA5bjM+TPz2z2AWyZHhfav26loKWbRC5nmvzY4jgdxoWxRiQv2PMandPEmB5wSRtsS9HJhG92fm/fSQZjU9xSVVNSEKgkQr0BcDzi5YRaIiDPlwZv2+3HllPv78zTHBQKHLeNtGHZsNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199021)(36756003)(33656002)(6506007)(6512007)(186003)(54906003)(53546011)(71200400001)(6486002)(478600001)(76116006)(8936002)(5660300002)(2906002)(38100700002)(66446008)(66946007)(6916009)(8676002)(66556008)(41300700001)(122000001)(38070700005)(4326008)(66476007)(86362001)(316002)(2616005)(83380400001)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RU1GTmhBbXdzQmJyRjRUMU44WHdPWTRyb0FSSHRWa0s3UFZnR3hJNzdtRlk5?=
 =?utf-8?B?eWYzbHl6R3FkcEg0L1h6NGRDUENMbEdtK3dRZlhVc2pxRi9xVTQzT0gra0Ny?=
 =?utf-8?B?MVovdk52ZlFjQXdTbFBCSTNZdkkvTS92SURESXlyUEI4QXJmeVRoZmpxQTY5?=
 =?utf-8?B?WUE1eFN2eHJ5cVY0ckFjejRGZ0pCTFgwU3N4K0NyUGZmT241MjdUa0hLOW9q?=
 =?utf-8?B?REhjbjFhb2JUQk5wU29FbWtuZ2QyT25SK2tYWHA2aXpURlZONHZDOWtLbXFZ?=
 =?utf-8?B?SmVsSWhiSjZhQ2w4MVltck9JVGptQmw0MkJBa2NuQnNPbXU5N2xwdHJVOERn?=
 =?utf-8?B?TllZL0ljRlBUdVlUYUxucWlkRTFaRkFROXBjcklWbkhyTnFlMU5zaTlFRTlk?=
 =?utf-8?B?OXZhNHRDdTNZQVFPRHZpRDNvTWlZMEpOMHVkcVdVanJlK3ErNE4raEliMjlu?=
 =?utf-8?B?ZGZFbXZJUExtdW1iamxmRlNRWXp5UmIxanZZeDZxQ2x4VjRFRUMzSXBpUVg1?=
 =?utf-8?B?ZG1ISU94R1V1SCsrazNHQ0o5U1JHWU9xMitKTHMyRlB6d1VoaFVBYm1TRjkw?=
 =?utf-8?B?cGEwY3ZwQVhMaEhBTytCUkJXb2wxdGZqZFFaR3p0YStKWUMyV0IxY2h3bHNJ?=
 =?utf-8?B?VWxLK094eTlKZWpTalB6YURHSVpaem1vQjMvQWM2TGZBVFNQZ1BneE9XNTB4?=
 =?utf-8?B?UHBwVUwzUWcxNDIrejZiVkZjaktIaWNGU0NIZy92dnA5WnlqRUdmTDJTQXN1?=
 =?utf-8?B?cjhtcld4RnNNRk1nNnR4akxtWForL1ZtVWhwaGcyeHArdHZ2NlNXVGMrWnA1?=
 =?utf-8?B?bGx3U3lNamNvcDFWb2haY2VUZmFreGZ2cVBiMTVaRU1LYklIZ0VMTk5KRCt5?=
 =?utf-8?B?cmhWNG41VlJOeFNFK0Q3U3NKa3RrZ213WWh5TDVFRXZQaUZwSHlsNWJXZUt1?=
 =?utf-8?B?SGRMZDFKWk1VdVNiN3hDWHQyMUx1UmoxVFJ2SWRoamk5VjMyWHlSYkxIK20y?=
 =?utf-8?B?WFV5bnZ2T2hlT0JGejhsZGtTN2tnRHhIMjlNN2FOeUpnVElJRkN1d2dPdXhE?=
 =?utf-8?B?bDBaK0l5Y0J5cFlpdlJyNDViaVFuVEtNcjhyRHp3MnVrWU12VVhaQzRhLytn?=
 =?utf-8?B?UHZaUlNkdDY4RUpCZGsvT0VrS0JMRU14VlJCRG5zM1FGVENiaSs1cXIwUXZQ?=
 =?utf-8?B?VHRZTzh6N0VGTGxPT3ZsN1lnL2N5NHByV2NVMFFOT3h4dk1OdVFOOU1EZ0wv?=
 =?utf-8?B?bHg5NnVvV0pwdWRmZ2RuYmhQOWFyTGwwV2E5Q3d6SFF4YTRldHpFandzMEs5?=
 =?utf-8?B?QlMxYk00eksxamZydEpTT0t2Wk1weUYxSFlENDJjYkpSdVNOSzBSbjVwbjln?=
 =?utf-8?B?eHBaZ0M0endQaUt4blRkdGNrcGd4M1l0TmJnTENGbmFMUHU4QUJFam9ENXR3?=
 =?utf-8?B?a3lGNFlEZzhzNE1aQVRhUGo2N3QvSHF1eFhuQ0pOc0xwSjE5L3VuNDBmWW5G?=
 =?utf-8?B?TkVzUDAxdHZaZU1OOVErNzVJYnhCQWxJZ2ZBdW54K3ZVQ3VZKzdocS9yWTYr?=
 =?utf-8?B?ZjQwZ1ltQ3JlS0g0Y2xOSk40cFFpWmNPb0IyUm1GU0E2L0ZPMWJmN3IrNzRl?=
 =?utf-8?B?VXdYRnRNUThBREJSTVN3Slhhcnk3MGttWGNjSHBoWlR4OE5lYVlueURGSU53?=
 =?utf-8?B?MWRxbWpHZmdTdkRaWGxkWmRsUUk1WTJNeUswZ09BZCtKcTNlS1phaGlUSjg5?=
 =?utf-8?B?MHA2Smg0K210VWtIeWhmY1ozM0ZJN3NmcitUUXFHTmVmVURNeWZVMUFvWEdo?=
 =?utf-8?B?c3c0NTEyQXJhN3FSZmx2UWVCMG8zaHNqQzlORUxkMXpWNGF2c085bHkrNW82?=
 =?utf-8?B?SEJVRTk3UFo5Z054bDVLeFBocUJCMUJSc2ViZU9GMzZzbTRpbDloQjE1Wjdr?=
 =?utf-8?B?VDRHRnBLSTk2bFBJaXlFNnR4NXJNM01QZmM1K25vN3RRU0oxYUFNNGlYM2Yz?=
 =?utf-8?B?eGtZMm9uUjlzRkIvS1E1WlhXbU9uVXhaRXZYaEFyTzV0dHFTOXEzVVd2bHA3?=
 =?utf-8?B?SzA2UXp5TlR3OU5hK1VPSEIrZFpKTWxVbXREdWFtRWVZaFpMMkMxajF1b01S?=
 =?utf-8?B?K3JSMFNqSVdyYkxKODM2OHQ2Wkl2RmExVlRKQmEwSEUwUWpOb1FyV05xR3Bq?=
 =?utf-8?B?bUdZVU4yVUdkVWpyd3dCSzNWVEFzaUQyTjBKbWRvc0RRd3ZET0MycWFvdzRG?=
 =?utf-8?Q?rGpwPB9mZXnie1hboiP20BzbHZvqeUTfHqu5Io9O0c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83EFB4312CAC5E4180378CE58A92BC93@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0FH/nWUt7V3e+o1QofWZd5N8ER5ZADSZphNwr+/lUnUhES26mJYcp9LcGmUSUGEKkUz8b29NGDvBaYR35YxEhW9jDQwgfyC7jkyGc8+VKvCu9Ox+wPGjIltdxUrZ1SUFJunXBUvE1A8TeS7G96tpjLy9q2b5I9JtZ9HWoleHFZmoAhS4AZ0ReF7Td958NQn8SuutWTHix5B9iiSLzqARzYo//i3K4a/OuLMr5NBQ1Rbpq9jym0D2CO/dZKc5TwLGufp5qf8i57I1EadBqI+C9+RGEJt/DdENM7oMVq2FrpYG5H+Wib2f4LQac75F8jGrm709SP8B3N8OYWVvHOoPddV922SBm55WMQa9rv6XZgkCNi37MS0VbGhH/iKITLC2iA4AdYY+xFr/uHog6RudYlUi5Z+wcaorRfaeAnyQI2CX5hCqaL9d1XGxtuQYdDyKbxTrnX87mB5gGW9Mhl/RlhtbGf1GPkVPPjzN2vqAWS3KEKzYqPjXtLP8GcgfxpQYtPBAnX/VxRcLbsLnTzqpIrzD8UUuNlitdMkVykl8mi9hMY1w5xwuTdjXMJLBDrm5vqolsGB5f5snnkNYWWGWAUawZZY1SeGaKHh7NWUKMDLRSIAIk0F6fLyaGlJjiixjnYgfdO+ic5DW6Xo4/zEapLwHcObIF4G6DEEXO0NHOpRrrmyu+HwJVnGvzlYktRk6w33sv8qWw4GsvaH37HuJNC1RViRi6bs5gSzgyKpXI4Tvo9vmP3EPLbczUIF/U7uY/2uBu66mlDmzJiuwxumYvbZhygPDT35Xy65qGg2N2cOWhYIvJjr18qykwH5QlwQrYVCxy0JE3w/Xgz1a4R3cmrxp8CmWdm0j/C8w0UXBEOtOnTk5ynV/Qh8jFvg1zncr
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75559669-358c-42d1-c6e5-08db8fb08ec0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 21:21:07.4897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3RQIOqYYIdNuFGIe4k235DMJQhpm5u1kFySkMaQpx9xJR2jHUrVPEJuBxWEATWZEZ9dGXxeP2l2h5PtD/4eXVeETxqn5kOhlccYGe6+e2aI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6402
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280194
X-Proofpoint-ORIG-GUID: l4CttkczV9GNrr6bukkxF7LJI4LWihvG
X-Proofpoint-GUID: l4CttkczV9GNrr6bukkxF7LJI4LWihvG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gT24gSnVsIDI4LCAyMDIzLCBhdCAxMjo0NCBQTSwgU2h1YWggS2hhbiA8c2toYW5AbGlu
dXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiA3LzI4LzIzIDEzOjA2LCBTaHVhaCBL
aGFuIHdyb3RlOg0KPj4gT24gNy8yOC8yMyAxMjoxMCwgQW5qYWxpIEt1bGthcm5pIHdyb3RlOg0K
Pj4+IA0KPj4+IA0KPj4+PiBPbiBKdWwgMjgsIDIwMjMsIGF0IDEwOjI5IEFNLCBTaHVhaCBLaGFu
IDxza2hhbkBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4+Pj4gDQo+Pj4+IHByb2NfZmls
dGVyIHRlc3QgcmVxdWlyZXMgcm9vdCBwcml2aWxlZ2VzLiBBZGQgcm9vdCBwcml2aWxlZ2UgY2hl
Y2sNCj4+Pj4gYW5kIHNraXAgdGhlIHRlc3QuIEFsc28gZml4IGFyZ3VtZW50IHBhcnNpbmcgcGF0
aHMgdG8gc2tpcCBpbiB0aGVpcg0KPj4+PiBlcnJvciBsZWdzLg0KPj4+PiANCj4+Pj4gU2lnbmVk
LW9mZi1ieTogU2h1YWggS2hhbiA8c2toYW5AbGludXhmb3VuZGF0aW9uLm9yZz4NCj4+Pj4gLS0t
DQo+Pj4+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nvbm5lY3Rvci9wcm9jX2ZpbHRlci5jIHwg
OSArKysrKysrLS0NCj4+Pj4gMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4+Pj4gDQo+Pj4+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9jb25uZWN0b3IvcHJvY19maWx0ZXIuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nvbm5l
Y3Rvci9wcm9jX2ZpbHRlci5jDQo+Pj4+IGluZGV4IDRmZThjNjc2M2ZkOC4uN2IyMDgxYjk4ZTVj
IDEwMDY0NA0KPj4+PiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jb25uZWN0b3IvcHJv
Y19maWx0ZXIuYw0KPj4+PiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jb25uZWN0b3Iv
cHJvY19maWx0ZXIuYw0KPj4+PiBAQCAtMjQ4LDcgKzI0OCw3IEBAIGludCBtYWluKGludCBhcmdj
LCBjaGFyICphcmd2W10pDQo+Pj4+IA0KPj4+PiBpZiAoYXJnYyA+IDIpIHsNCj4+Pj4gcHJpbnRm
KCJFeHBlY3RlZCAwKGFzc3VtZSBuby1maWx0ZXIpIG9yIDEgYXJndW1lbnQoLWYpXG4iKTsNCj4+
Pj4gLSAgZXhpdCgxKTsNCj4+Pj4gKyAgZXhpdChLU0ZUX1NLSVApOw0KPj4+PiB9DQo+Pj4+IA0K
Pj4+PiBpZiAoYXJnYyA9PSAyKSB7DQo+Pj4+IEBAIC0yNTYsMTAgKzI1NiwxNSBAQCBpbnQgbWFp
bihpbnQgYXJnYywgY2hhciAqYXJndltdKQ0KPj4+PiBmaWx0ZXIgPSAxOw0KPj4+PiB9IGVsc2Ug
ew0KPj4+PiBwcmludGYoIlZhbGlkIG9wdGlvbiA6IC1mIChmb3IgZmlsdGVyIGZlYXR1cmUpXG4i
KTsNCj4+Pj4gLSAgZXhpdCgxKTsNCj4+Pj4gKyAgZXhpdChLU0ZUX1NLSVApOw0KPj4+PiB9DQo+
Pj4+IH0NCj4+Pj4gDQo+Pj4+ICsgIGlmIChnZXRldWlkKCkpIHsNCj4+Pj4gKyAgcHJpbnRmKCJD
b25uZWN0b3IgdGVzdCByZXF1aXJlcyByb290IHByaXZpbGVnZXMuXG4iKTsNCj4+Pj4gKyAgZXhp
dChLU0ZUX1NLSVApOw0KPj4+PiArICB9DQo+Pj4+ICsNCj4+PiANCj4+PiBJIGFtIG5vdCBzdXJl
IHdoeSB5b3UgaGF2ZSBhZGRlZCB0aGlzIGNoZWNrPyBwcm9jX2ZpbHRlciBkb2VzIG5vdCBuZWVk
IHJvb3QgcHJpdmlsZWdlIHRvIHJ1bi4NCj4+PiANCj4+IEl0IGZhaWxlZCBmb3IgbWUgd2hlbiBJ
IHJhbiBpdCBzYXlpbmcgaXQgcmVxdWlyZXMgcm9vdCBwcml2aWxlZ2VzLg0KPj4gSSBoYWQgdG8g
cnVuIGl0IGFzIHJvb3QuDQo+IA0KPiBUaGUgZm9sbG93aW5nIGlzIHdoYXQgSSBzZWUgd2hlbiBJ
IHJ1biB0aGUgdGVzdCBhcyBub24tcm9vdA0KPiB1c2VyOg0KPiANCj4gYmluZCBmYWlsZWQ6IE9w
ZXJhdGlvbiBub3QgcGVybWl0dGVkDQo+IA0KDQpZZXMsIHRoYXTigJlzIGV4cGVjdGVkIG9uIGEg
a2VybmVsIHdoaWNoIGRvZXMgbm90IGhhdmUgdGhlIGtlcm5lbCBwYXRjaGVzIHN1Ym1pdHRlZCB3
aXRoIHRoaXMgc2VsZnRlc3QgaW5zdGFsbGVkIG9uIGl0LiANClNvIHRoaXMgY2hlY2sgZm9yIHJv
b3QgbmVlZHMgdG8gYmUgcmVtb3ZlZC4NCg0KQW5qYWxpDQoNCj4gdGhhbmtzLA0KPiAtLSBTaHVh
aA0KDQo=
