Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CAE767A6D
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 03:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjG2BAD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 21:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbjG2BAC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 21:00:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49ABC5244;
        Fri, 28 Jul 2023 17:59:30 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SLiSB2028534;
        Sat, 29 Jul 2023 00:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=RYvI+fZtj3iBmZuJ+i8I/DabGLCGqs6SPjCUed0eobA=;
 b=yZ8rJ3YCUY1xVjT0PpT9NxtQsiWdHa2r4oVhV9FyFqG2zW+Ca5xmkHz+Xf/I3jvRxzc2
 lzqhbwnp7664sIsACr3LoGGYQI3tPv3jR5rikdXMJiCTQsi0urWrvjidO0tMKdY2xO9E
 Sq7PPAd0b/UDj8/adCNtaDPkElF34ACEEfwnWYFcU1nDXQEhEKHn20vfvRokIlPTcJLN
 VmVdyGL+9p6JR6wOO9U0Po7i5YnG+edZ8pCdIqBBl01DxLKWFwgqVntE5bX5eucvnLeB
 6HI8DJuxW+Sm7wUjjpDWcVCbdsfJw5qR8pTwddgZe/gLIhJsNOitr0CA5XXi1s0743x2 gw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05q250ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jul 2023 00:58:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36T0eWCI029454;
        Sat, 29 Jul 2023 00:58:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j9tmk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jul 2023 00:58:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cm1H4eiuTKFoTXF9O+J/2bR3pUg3neFH/vQ2ErAxjzf9ajmXd+ZRb9yYTvedN2Va903/LEMOoYbdQtimF8Y+bw3WmEmjR47igsjvAfOFgMOcpZ6psOKh13OjI37rcZ3cD53RXC8B6tRJXwEmmqA+aJ0CB0zucqyMDi0KqZUa77T2UtdJa2zy2gom2NtslpTZL+O37gTeDxLusgUKuEEJteLaF3roFyJ9ftnMSOeHkGb8sh02yWy3vEri2jgY+y7iKsj6iEU6mwWwoeXMh48p9cm1K8ZSKg3TkB7T2vqw4axcEk7T1AcU6KLNjPRoktPhebxaRg3oTpqtEj2S71I43A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYvI+fZtj3iBmZuJ+i8I/DabGLCGqs6SPjCUed0eobA=;
 b=mdpltEC4sZVOl4tymJb/oo+ztY9GY2qu+oLy78ficbmhEMFZ7uDTu55B76nvs+3qpQDOy6fZhXd2207Jz74PTStr/vd25d17iacjYl3Hbodb7z2HG2cDXMe+/2sEACq051kv20/ruCVEBWljCieZwqjCOQ06IGbvVkP/M8sDsXsiWqe/X+/VHqJ5ywQGXI68mqpskpH25wkNdOJ2KzLDpe2W3MUo8fcdZrJxZ/VTr/Y3HuTqGbaNEekblI24iXaI/CE2VhsCBbyULkIcTwbFWlWasdcBwLh5fjd2DssmRfg0w2roGSvOEjFX49DuBovQKIZUqolHOGe3S04AQ8BAKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYvI+fZtj3iBmZuJ+i8I/DabGLCGqs6SPjCUed0eobA=;
 b=JVMu+W0UtgQgJQvuv9w1+F5MjMTBd210BLwE3VjcFg9rRAeJg+/nSBpoecbqzXp7uGmcWz1kJl9tpe1ezACgddT1Gy6HkUyHQxYzkXOTQiP6ZLJCBPelEsUbQrJ01CWRiOXRJsGizMvQkXd0Q9wSTzeHsvbkKW6J6JdF0ZEAHcI=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by DM4PR10MB7451.namprd10.prod.outlook.com (2603:10b6:8:18e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Sat, 29 Jul
 2023 00:58:26 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::69d6:8729:ee7c:cc45]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::69d6:8729:ee7c:cc45%2]) with mapi id 15.20.6631.026; Sat, 29 Jul 2023
 00:58:25 +0000
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
Thread-Index: AQHZwXkWbDEKB7ogokq33I6v8z/kP6/PesIAgAAPagCAAAqwgIAAGwgAgAAFxYCAAAT4AIAAB1+AgAAD84CAAAWZgIAAFj8AgAADoQCAAAcvAA==
Date:   Sat, 29 Jul 2023 00:58:25 +0000
Message-ID: <CB80A570-F4C0-4FDA-A224-DDB9E93AFBC0@oracle.com>
References: <cover.1690564372.git.skhan@linuxfoundation.org>
 <2c0ac97f9c8e6bd46b60854c136099c0dd4a09f6.1690564372.git.skhan@linuxfoundation.org>
 <0CB227BA-69FD-447F-BE73-2482A6998F7E@oracle.com>
 <5b283f3b-f176-7f19-5db0-1332a94a44be@linuxfoundation.org>
 <ec809279-cc41-7e0f-a567-29400b4c34a9@linuxfoundation.org>
 <16B47831-5F53-4BAF-B347-A1404D2ED264@oracle.com>
 <957be0e8-2bdf-80f4-92b7-3b9070c546b3@linuxfoundation.org>
 <3242346A-9B09-44F7-A062-8456F83372C7@oracle.com>
 <84048d13-9311-36f6-9eb4-8169952580d7@linuxfoundation.org>
 <AD8D16A6-63BB-4953-80BA-6410B29416D6@oracle.com>
 <8c92599f-fcb4-3aba-f367-17abd9b52451@linuxfoundation.org>
 <C3669401-536A-4CB0-80E0-5CCF2DCC36D3@oracle.com>
 <1e3d6e78-9b74-1da0-cb33-7caea5ce7a3a@linuxfoundation.org>
In-Reply-To: <1e3d6e78-9b74-1da0-cb33-7caea5ce7a3a@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|DM4PR10MB7451:EE_
x-ms-office365-filtering-correlation-id: 7ce50cab-dba9-454b-dfd2-08db8fceea34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MMruMIisaqDtuc2iBE+CYCKmfxEfVmLWR1sx0QHoTz8euJlXGvOEiydCC+hYyb5NcJZjoKe1QpWyJia7dhwjBLF0lm9276VVK9wZ0i+5G5muCSTVRbe2BcJXuV61TSmzkNrESuRiLRC83m5GCB50YEpdhRW9Vkb5QZ5jU5KaM4RHpxdKyAAGKbbirdpM0oID80WhTDXjkiRceN4tk74pmJR+CNtAc8TR8AoPAjm3S+WVcroPiQ3OYegKTLtaLrwczh8pWnTR1SR3TMae3dWC6+zxmzGHUE2VNrlIkkSFMRR/82a+3CGPgHdhzM1cvm2AIgZzP1qM8xmKUL6DcmNlhCh4XjbaYcjIhqutEPx7RJcddEE4IKvupx1dUQ+y8ADmsQ/EnGDmCbbR7Z+YjzBTWtI5ZwV3wx9AQYlRRIDWUVOjrUu8Jc2oTFzk99FVGHZ2pZ4C0MXNjOqzjC0JI/Kyvu8OTNXmss8ZqRr3DviHs61Yly2KJh34R4hEx8QLj8c1GkQw0TPOb3cIKG7Y8v4N6wzjHrOp1kAKiSlKFAXT31D71m2+/6rlelY18+AjrAzZTTmUgAADrUGLEHSZ5oAFJ37TilJHaeuhQghEBruy3OR2uo0QHvr/CIREDAdxGhg2gCAbXyWotwIddusm8tCNKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(66446008)(122000001)(38070700005)(83380400001)(2616005)(38100700002)(86362001)(5660300002)(71200400001)(64756008)(66476007)(4326008)(8936002)(6916009)(8676002)(41300700001)(66556008)(316002)(36756003)(186003)(6512007)(6486002)(54906003)(6506007)(91956017)(53546011)(26005)(76116006)(66946007)(33656002)(478600001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3hiV29SZFhMOEdHcWZBNUo0RU9YZkxsK1FDVkM5QVliQTdQZVB0V1FYT0Uv?=
 =?utf-8?B?NGtHUCt2TkdtZFBkMjZyU0x5ZWt0NDVMeFF2SFJHWWZqcElGeDNKQ2h0YjB3?=
 =?utf-8?B?N29NM1hFaGFBeEx1WkJrclhxczIyRGpJVXFsbHZHYzhwY2xwOUFxTU5scEhs?=
 =?utf-8?B?TXJDdmhlTzlFWUJCUUd5ZjNKNjlGYjh6bW92ZlVHVEQ0ZlB3cC81TlBVOGpk?=
 =?utf-8?B?NVlRSy9hWlA2Q2JKVk16Rm0wVndRdDhESzUvZUJRL0tFd3p6R2ZwbVR1ZUNy?=
 =?utf-8?B?L3dONk12Z3NudGNRZUMvVWd5ZDRERkpGQmdrbUZ1emRSWmNJaXRDSTl4cXRC?=
 =?utf-8?B?TDU2T0lDd3NTZHYzcnlTdk82dDdyUmdTWE1uVXRlb3Z5NE1zbS96KzhrOVdv?=
 =?utf-8?B?Y1BNODJtQ0RPYmkvLzl3TVp1dlhqK1UwaWQ0L1NadG5Wc1R3VERKNkdSOTJS?=
 =?utf-8?B?ZmN5R0dTdHFJaXYxTWRUbjhRMTc4VlFhamloTTVLeTFSdWszb0JUbXQyeWh0?=
 =?utf-8?B?VlMrdVFkNDk1VGNzMUN5Nk9iN0VjajRZVGJBRHRyVmRvMnRxaE9sYTFXR2xX?=
 =?utf-8?B?NzkwYmU5VFB0TXlGdDhReUp3Z2VkUFVHZG5FV0N1ODZkdlF6U0RrQ09uUlhQ?=
 =?utf-8?B?RjlDYlF6T1BLMjIxcHRobjRmcGtzMFlzVk43Q2NnTFV2eERISVByYkM2SXRy?=
 =?utf-8?B?anBIMk9NMVhjejVpTkNJbzJGT3YrMkRHN2NiY1RwRnB2VkMwN0lEeHl3ZjQy?=
 =?utf-8?B?LzZBOXVmL0x3VUpMVW9BcnFpY3VXUzFmYlRPS1BDc25EcDVGTCtYQ0lRRDBB?=
 =?utf-8?B?S1QxeFlqd2FMY3NodWNlQ3JMdVUzNk5ZYUJZVkdlN1d2U2RtcUVPK1JCVDJt?=
 =?utf-8?B?bjhocENUZ1kyYysrd1d0UXk4dy9RaVJVTWhvamFEeUZMZURzTDdvKzh0TFdm?=
 =?utf-8?B?Nkh4NDBXQ3RxVmc1dlhvUXlVb2Zad3N6QkVNRjh1UDdEd2g5K0ozMGExQTZr?=
 =?utf-8?B?S0RLZUJFcnYrOVY0ZVhHWlJ1UTV6dTFKY0VYYWl0aFZsSjl1dlFzNjU4VHlE?=
 =?utf-8?B?bkw0aGdpdHBaYkRQcXcreS9TT01lSXE3Q05hcWlFTUtPZHFNcWphaGRocXJZ?=
 =?utf-8?B?VkFlamlTUFJHdXU0aHZLSkswYnQ0RVd1Nmt1dHd4UUxSOWNjdStTVnB5dnIr?=
 =?utf-8?B?VnpiaTdlbjg0VU93NG9wZ2hMYXkxKzlGYkFPaFhjR2ViZVFjSGRucnhpQU11?=
 =?utf-8?B?WTBERjNtcVl1U1lZbGZEU3R4OUxnTk1iK3NXbkdlUTNKZUF1cktUQWNNeUs3?=
 =?utf-8?B?L0NZakovaVlhTm9ZTG5Jd1NCclRHY0k1Z01zY1BIbWlMOGpjRk1GUkhYL0hL?=
 =?utf-8?B?c0N4TktEcGVtZjZYOUJ3dm1URGV6MW1teFBtemFFanRDMUtQeGhoWmpNM1hO?=
 =?utf-8?B?N1YzRWhQZysvK0pFWlFacUNPbjFTdWVoVTFOZkVGR3RmYWJzNHM1SXlva3BK?=
 =?utf-8?B?enMxdVY0UytReHdpblZRZHRTYWsraXJQZmsyTzdEMDJzYWk1d2RBbkxJK3pl?=
 =?utf-8?B?eXU5OEQwS0t2VXJ2RUhFdkRNaTBzeHlzN1NqcGtlZUI2V0M1Q2wrdXViS0V5?=
 =?utf-8?B?WlVsWE9ES2diMmhNNXduL0U3NUtJenNYcUdaL0FoV2xhazZOZzVJZUh0SUll?=
 =?utf-8?B?dzdUL0JNTU1IaXpxeXkxcFNwRGtnQkZuVkVUOTFjdGI0NHVONHlaQVBUS2pp?=
 =?utf-8?B?VDZIQ2lySElFVFJSb0VJdC85d29MaXR0RTdiSVR5ZVR5QmczRHlZNTRQWXFp?=
 =?utf-8?B?enJ5bGZPSG5SMUVLMkMxQTlGeCs1NERlWm5YSEM1dENjTU5DSExPWnFIQTA0?=
 =?utf-8?B?UjU5ZVduZmk4dDNpSGY2Y2F3aGNYS09pekdGTkUrWXQ5VUMrbkc5R0dkbGJx?=
 =?utf-8?B?T3E0THk3YVNFSENhajBxNGNVME1LZFhVRjFqWXlBN2d1UHUydjNtMG9GS1Va?=
 =?utf-8?B?Q1lrdWNCRncyZTJPaC8vRkZxeWw0MDFvZWl6Q043MDR1bkFLYkZOKzBwYTNN?=
 =?utf-8?B?SGQvT0lrS2FBVStkVG4rOW9FZUx0M0N0d2tuL3pLTU5sTmorQTcrQkRlRkxK?=
 =?utf-8?B?VWl2RVBmZkpPNzBSdHR3SitMQUZLK1dLbEVJUlJtWllMQ1djUkRFYTVWTkxE?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9414DD03A2DDC942BD18F970E4077842@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oEkcmBwZvezJYDmwej744W4x9mnpUKH7ywkZOJxWXcnGgBbPq1i/avmFOTN9Wfy+aZCiM7FDIdV5H6cJ/Dcl8wTaXIsX+k7u/+6GXIQmPrQ2cfiLe10ZgL4WB3zqcsVzIEXaH7fr6mzFa6C5CIj+drjNiYACYIVBwhYik3qn07xSA7ZeXb55hbJ88YJI1jWW3B+zG8IkCRbIeL+v8qjmtBudCQGqiTLq1lEnA8zqB0cuvNjdqeD6Wo/inK0PUta3f/3FoqPjQ0EZJVpGovJ7Lqg2nE0p3xymACCh5xShdYdeAeHjxZn9SkHaXjYyHaSINsPLrHL7eWkzQS9Xq/TXZTQ9HeLOKQhR9GQZJfdX+9oDtkJqtmS5SRhTxbJbifwjOCblRTOlDdDrgBturqoB1csDTbvbeKr4jZSULO9sMyvuKSZRNxkW6H4KdXVc7LEDbQgZEIenT7KyZiL58ttLqDLvVOi+Zsgv/Xw6aNP7pX80KeqfLUIP+q0HNlwIyfDwWI9a33caE6NciA4h7L0ddte1dJ3x2cwZKIO1f+DEmGuCkYAP2jWwAItNQnnR/Ed2XRQr0ufmFLfIF1lTMTFBcUvhuRJZpIf2CIjyPqc/nSsuy5QVytePl9jNo2cqjxztpdYJBmrOfPw2R3DwW3nwZO5e0buZ+1KTdFJPegWmvQuUHQpA9ARrPLooWnwzT95nG27d+S6loLIFsJyX+8pWkGnTeT68TaukUFPMdRK1UbbdMQETvu9+7yNAXxwLKgAVqg44MnkJx+8ZnfdYitczzogJmO0WDj3CH3/sc2S+0/3Zh3fN1I2bNVkronGviwhPVnf2vyQgczsgeKfxwseEamM2ijsZ8BquMjBucTUKL6bMQB+opqjQLn7feXi8lF9Z
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce50cab-dba9-454b-dfd2-08db8fceea34
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2023 00:58:25.8164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JF3C24eMuNYwlLEa9QAp8rS6dabjNvc5PC/ewCAL/Tc0LbVZaj1tyL58eNyPRqf+5CjdYigcJh6TTH2JICjthtn7xCzMPj/xwoN42enmyvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7451
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307290007
X-Proofpoint-GUID: 5wjOXVg-4DVw-K3EuetDWdKxCHGYbFda
X-Proofpoint-ORIG-GUID: 5wjOXVg-4DVw-K3EuetDWdKxCHGYbFda
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gT24gSnVsIDI4LCAyMDIzLCBhdCA1OjMyIFBNLCBTaHVhaCBLaGFuIDxza2hhbkBsaW51
eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IE9uIDcvMjgvMjMgMTg6MTksIEFuamFsaSBL
dWxrYXJuaSB3cm90ZToNCj4+PiBPbiBKdWwgMjgsIDIwMjMsIGF0IDQ6MDAgUE0sIFNodWFoIEto
YW4gPHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIDcvMjgv
MjMgMTY6NDAsIEFuamFsaSBLdWxrYXJuaSB3cm90ZToNCj4+Pj4+IE9uIEp1bCAyOCwgMjAyMywg
YXQgMzoyNSBQTSwgU2h1YWggS2hhbiA8c2toYW5AbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6
DQo+Pj4+PiANCj4+Pj4+IE9uIDcvMjgvMjMgMTU6NTksIEFuamFsaSBLdWxrYXJuaSB3cm90ZToN
Cj4+Pj4+Pj4gT24gSnVsIDI4LCAyMDIzLCBhdCAyOjQxIFBNLCBTaHVhaCBLaGFuIDxza2hhbkBs
aW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IE9uIDcvMjgvMjMg
MTU6MjEsIEFuamFsaSBLdWxrYXJuaSB3cm90ZToNCj4+Pj4+Pj4+PiBPbiBKdWwgMjgsIDIwMjMs
IGF0IDEyOjQ0IFBNLCBTaHVhaCBLaGFuIDxza2hhbkBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90
ZToNCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBPbiA3LzI4LzIzIDEzOjA2LCBTaHVhaCBLaGFuIHdy
b3RlOg0KPj4+Pj4+Pj4+PiBPbiA3LzI4LzIzIDEyOjEwLCBBbmphbGkgS3Vsa2Fybmkgd3JvdGU6
DQo+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4+IE9uIEp1bCAyOCwgMjAy
MywgYXQgMTA6MjkgQU0sIFNodWFoIEtoYW4gPHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdy
b3RlOg0KPj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4+IHByb2NfZmlsdGVyIHRlc3QgcmVxdWly
ZXMgcm9vdCBwcml2aWxlZ2VzLiBBZGQgcm9vdCBwcml2aWxlZ2UgY2hlY2sNCj4+Pj4+Pj4+Pj4+
PiBhbmQgc2tpcCB0aGUgdGVzdC4gQWxzbyBmaXggYXJndW1lbnQgcGFyc2luZyBwYXRocyB0byBz
a2lwIGluIHRoZWlyDQo+Pj4+Pj4+Pj4+Pj4gZXJyb3IgbGVncy4NCj4+Pj4+Pj4+Pj4+PiANCj4+
Pj4+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBTaHVhaCBLaGFuIDxza2hhbkBsaW51eGZvdW5kYXRp
b24ub3JnPg0KPj4+Pj4+Pj4+Pj4+IC0tLQ0KPj4+Pj4+Pj4+Pj4+IHRvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2Nvbm5lY3Rvci9wcm9jX2ZpbHRlci5jIHwgOSArKysrKysrLS0NCj4+Pj4+Pj4+Pj4+
PiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+Pj4+
Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9jb25uZWN0b3IvcHJvY19maWx0ZXIuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nvbm5l
Y3Rvci9wcm9jX2ZpbHRlci5jDQo+Pj4+Pj4+Pj4+Pj4gaW5kZXggNGZlOGM2NzYzZmQ4Li43YjIw
ODFiOThlNWMgMTAwNjQ0DQo+Pj4+Pj4+Pj4+Pj4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvY29ubmVjdG9yL3Byb2NfZmlsdGVyLmMNCj4+Pj4+Pj4+Pj4+PiArKysgYi90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9jb25uZWN0b3IvcHJvY19maWx0ZXIuYw0KPj4+Pj4+Pj4+Pj4+IEBAIC0y
NDgsNyArMjQ4LDcgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkNCj4+Pj4+Pj4+
Pj4+PiANCj4+Pj4+Pj4+Pj4+PiBpZiAoYXJnYyA+IDIpIHsNCj4+Pj4+Pj4+Pj4+PiBwcmludGYo
IkV4cGVjdGVkIDAoYXNzdW1lIG5vLWZpbHRlcikgb3IgMSBhcmd1bWVudCgtZilcbiIpOw0KPj4+
Pj4+Pj4+Pj4+IC0gZXhpdCgxKTsNCj4+Pj4+Pj4+Pj4+PiArIGV4aXQoS1NGVF9TS0lQKTsNCj4+
Pj4+Pj4+Pj4+PiB9DQo+Pj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+Pj4gaWYgKGFyZ2MgPT0gMikg
ew0KPj4+Pj4+Pj4+Pj4+IEBAIC0yNTYsMTAgKzI1NiwxNSBAQCBpbnQgbWFpbihpbnQgYXJnYywg
Y2hhciAqYXJndltdKQ0KPj4+Pj4+Pj4+Pj4+IGZpbHRlciA9IDE7DQo+Pj4+Pj4+Pj4+Pj4gfSBl
bHNlIHsNCj4+Pj4+Pj4+Pj4+PiBwcmludGYoIlZhbGlkIG9wdGlvbiA6IC1mIChmb3IgZmlsdGVy
IGZlYXR1cmUpXG4iKTsNCj4+Pj4+Pj4+Pj4+PiAtIGV4aXQoMSk7DQo+Pj4+Pj4+Pj4+Pj4gKyBl
eGl0KEtTRlRfU0tJUCk7DQo+Pj4+Pj4+Pj4+Pj4gfQ0KPj4+Pj4+Pj4+Pj4+IH0NCj4+Pj4+Pj4+
Pj4+PiANCj4+Pj4+Pj4+Pj4+PiArIGlmIChnZXRldWlkKCkpIHsNCj4+Pj4+Pj4+Pj4+PiArIHBy
aW50ZigiQ29ubmVjdG9yIHRlc3QgcmVxdWlyZXMgcm9vdCBwcml2aWxlZ2VzLlxuIik7DQo+Pj4+
Pj4+Pj4+Pj4gKyBleGl0KEtTRlRfU0tJUCk7DQo+Pj4+Pj4+Pj4+Pj4gKyB9DQo+Pj4+Pj4+Pj4+
Pj4gKw0KPj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+PiBJIGFtIG5vdCBzdXJlIHdoeSB5b3UgaGF2
ZSBhZGRlZCB0aGlzIGNoZWNrPyBwcm9jX2ZpbHRlciBkb2VzIG5vdCBuZWVkIHJvb3QgcHJpdmls
ZWdlIHRvIHJ1bi4NCj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+PiBJdCBmYWlsZWQgZm9yIG1lIHdo
ZW4gSSByYW4gaXQgc2F5aW5nIGl0IHJlcXVpcmVzIHJvb3QgcHJpdmlsZWdlcy4NCj4+Pj4+Pj4+
Pj4gSSBoYWQgdG8gcnVuIGl0IGFzIHJvb3QuDQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gVGhlIGZv
bGxvd2luZyBpcyB3aGF0IEkgc2VlIHdoZW4gSSBydW4gdGhlIHRlc3QgYXMgbm9uLXJvb3QNCj4+
Pj4+Pj4+PiB1c2VyOg0KPj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+IGJpbmQgZmFpbGVkOiBPcGVyYXRp
b24gbm90IHBlcm1pdHRlZA0KPj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gWWVzLCB0aGF04oCZcyBleHBl
Y3RlZCBvbiBhIGtlcm5lbCB3aGljaCBkb2VzIG5vdCBoYXZlIHRoZSBrZXJuZWwgcGF0Y2hlcyBz
dWJtaXR0ZWQgd2l0aCB0aGlzIHNlbGZ0ZXN0IGluc3RhbGxlZCBvbiBpdC4NCj4+Pj4+Pj4+IFNv
IHRoaXMgY2hlY2sgZm9yIHJvb3QgbmVlZHMgdG8gYmUgcmVtb3ZlZC4NCj4+Pj4+Pj4gDQo+Pj4+
Pj4+IEkgd2lsbCBzZW5kIHYyIGZvciB0aGlzIHBhdGNoIHdpdGhvdXQgcm9vdCBjaGVjay4gSSBz
aG91bGQgaGF2ZQ0KPj4+Pj4+PiBzcGxpdCB0aGUgYXJndW1lbnQgZXJyb3IgcGF0aHMgYW5kIHJv
b3QgY2hlY2sgYW55d2F5Lg0KPj4+Pj4+PiANCj4+Pj4+Pj4gSG93ZXZlciwgd2hhdCBpcyBzdHJh
bmdlIGlzIGlmIHRoZSB0ZXN0IHJ1biBieSByb290LCBiaW5kKCkgZG9lc24ndCBmYWlsLg0KPj4+
Pj4+PiBUaGlzIGRvZXNuJ3QgbWFrZSBzZW5zZSB0byBtZSBiYXNlZCBvbiB3aGF0IHlvdSBzYWlk
IGFib3V0IGJpbmQoKSBmYWlscw0KPj4+Pj4+PiBpZiBrZXJuZWwgZG9lc24ndCBzdXBwb3J0IHRo
ZSBuZXcgZmVhdHVyZS4NCj4+Pj4+Pj4gDQo+Pj4+Pj4gSSBkaWRu4oCZdCBzYXkgdGhhdCAtIHBh
cnQgb2YgdGhlIGNoYW5nZXMgaW50cm9kdWNlZCBieSB0aGUgcGF0Y2hlcyBpcyB0byByZW1vdmUg
dGhlIHJvb3QgY2hlY2sgYW5kIGFkZCBzb21lIGZlYXR1cmVzIG9uIHRvcCBvZiBleGlzdGluZyBj
b2RlLg0KPj4+Pj4gDQo+Pj4+PiBPa2F5LiBTbyB3aGF0IHNob3VsZCBoYXBwZW4gaWYgYSByb290
IHVzZXIgcnVucyB0aGlzIHRlc3Qgb24gYSBrZXJuZWwNCj4+Pj4+IHRoYXQgZG9lc24ndCBoYXZl
IHRoZSBrZXJuZWwgcGF0Y2hlcyBzdWJtaXR0ZWQgd2l0aCB0aGlzIHNlbGZ0ZXN0DQo+Pj4+PiBp
bnN0YWxsZWQgb24gaXQ/DQo+Pj4+PiANCj4+Pj4gSXQgd2lsbCBkZWZhdWx0IHRvIHRoZSBiZWhh
dmlvciBwcmV2aW91cyB0byBteSBjaGFuZ2VzIC0gdGhhdCBpcyBpdCB3aWxsIHJlcG9ydCBhbGwg
ZXZlbnRzIGFzIG9wcG9zZWQgdG8gYSBzdWJzZXQgb2YgZXZlbnRzICh3aGljaCBpcyB0aGUgbmV3
IGZlYXR1cmUgYWRkZWQgYnkgbXkgY2hhbmdlKQ0KPj4+IA0KPj4+IE9rYXkuIFNvcnJ5IEkgYW0g
dW5hYmxlIHRvIGZvbGxvdyB0aGlzIGV4cGxhbmF0aW9uLiBUaGlzIHRlc3QgaGFzIGp1c3QNCj4+
PiBiZWVuIGFkZGVkIGluIGNvbW1pdCA3M2EyOTUzMWY0NWZlZDY0MjMxNDQwNTdkN2E4NDRhYWU0
NmRhZDlkDQo+PiBZZXMsIHRoZSB0ZXN0IGhhcyBiZWVuIGFkZGVkIGp1c3Qgbm93LCBidXQgaXQg
YWxzbyB0ZXN0cyBrZXJuZWxzIHByZXZpb3VzIHRvIHRoZSBuZXcgZmVhdHVyZSBhZGRpdGlvbi4g
U28gaXQgaXMgYWRkaW5nIGEgc2VsZnRlc3QgdG8ga2VybmVscyBwcmV2aW91cyB0byB0aGlzIGNv
bW1pdC4NCj4+IFRoYXQgaXMsIHRoZSBjb25uZWN0b3IgbW9kdWxlIGluIGtlcm5lbCAoYmVmb3Jl
IG15IGNoYW5nZXMpIHdhcyBzZW5kaW5nIHRvIGEgbGlzdGVuZXIgdXNlciBwcm9jZXNzIG1lc3Nh
Z2VzIGZvciBhbGwgcHJvY2VzcyBldmVudHMgLSBmb3JrLCBleGl0LCBleGVjIGV0Yy4gVGhpcyB3
YXMgb25seSBiZWluZyBkb25lIGlmIHRoZSB1c2VyIHByb2Nlc3Mgd2FzIHJ1biBhcyByb290Lg0K
Pj4gV2l0aCBteSBjaGFuZ2VzLCB3ZSBhZGQgZmlsdGVyaW5nIGJhc2VkIG9uIGFuIG9wdGlvbiBh
ZGRlZCBieSB1c2VyLCB3aGljaCBmaWx0ZXJzIGJhc2VkIG9uIGlucHV0IGFuZCBnaXZlcyBiYWNr
IHRvIHRoZSB1c2VyIG9ubHkgZm9yaywgb3Igb25seSBleGl0LCBvciBhIGNvbWJpbmF0aW9uIG9m
IHRob3NlLiBUaGlzIGlzIGEgbmV3IGZlYXR1cmUgYWRkZWQuIEluIGFkZGl0aW9uIHRvIHRoaXMg
ZmlsdGVyaW5nLCB3ZSBoYXZlIGFsc28gbWFkZSB0aGUgY2hhbmdlIHRvIGFsbG93IHVzZXIgcHJv
Y2VzcyB0byBiZSBub24tcm9vdCB3aGVuIHJlY2VpdmluZyB0aGVzZSBtZXNzYWdlcy4NCj4+PiAN
Cj4+PiBDYW4geW91IHBsZWFzZSBsb29rIGF0IHRoZSB1c2FnZSBmb3IgdGhpcyB0ZXN0Og0KPj4+
IA0KPj4+IC0gV2hhdCBzaG91bGQgaGFwcGVuIHdoZW4ga2VybmVsIHdpdGhvdXQgZmlsdGVyaW5n
IGlzIHJ1biBhcw0KPj4+IHJvb3Qgb3Igbm9uLXJvb3QNCj4+IEJ5IGtlcm5lbCB3aXRob3V0IGZp
bHRlcmluZyB5b3UgbWVhbiBhIGtlcm5lbCB3aXRob3V0IG15IHBhdGNoZXM/IEluIHRoYXQgY2Fz
ZSwgaXQgc2hvdWxkIHJ1biBvbmx5IGFzIHJvb3QgLSBub24tcm9vdCBzaG91bGQgZmFpbC4gSW4g
dGhpcyBjYXNlLCBpdCBmYWxscyBiYWNrIHRvIGRlZmF1bHQgYmVoYXZpb3IgYmVmb3JlIG15IGNo
YW5nZSwgd2hlcmUgbGlzdGVuZXIgdXNlciBwcm9jZXNzIGdldHMgYWxsIG1lc3NhZ2VzIHJlbGF0
ZWQgdG8gcHJvY2VzcyBldmVudHMuIEkgaGF2ZSBub3QgdGVzdGVkIHRoaXMgYSBsb3QsIEkgYW0g
d29ya2luZyBvbiB0ZXN0aW5nIHRoaXMgb24gYSBrZXJuZWwgd2l0aG91dCBteSBjaGFuZ2VzLg0K
PiANCj4gVGhlbiB5b3UgZGVmaW5pdGVseSBuZWVkIGJldHRlciBtZXNzYWdlcyB3aGVuIGJpbmQo
KSBmYWlscw0KPiBvbiBrZXJuZWxzIHdpdGhvdXQgdGhlIGZlYXR1cmUuIEl0IGhhcyB0byBiZSBj
bGVhciB0byB0aGUNCj4gdXNlciB3aHkgdGhlIHRlc3QgaXMgZXhpdGluZyB3aXRob3V0IHJ1bm5p
bmcuDQo+IA0KPiBTbyB0aGlzIGlzIHdoYXQgaXMgbmVlZGVkOg0KPiAtIENoZWNrIGlmIHRoZSB0
ZXN0IGNhbiBiZSBydW4gYXMgbm9uLXJvb3QgKHdoYXRldmVyIHRoYXQgbWVhbnMpDQoNCk5vdCBz
dXJlIHdoYXQgeW91IG1lYW4gYnkgdGhpcz8NCg0KPiAtIEl0IGlzIHN0aWxsIG5vdCBjbGVhciB0
byBtZSBpZiBiaW5kKCkgZmFpbHMgZG9lcyB0aGF0IG1lYW4gdGhlDQo+IGtlcm5lbCBkb2Vzbid0
IGRvZXNuJ3Qgc3VwcG9ydCB0aGUgbmV3IGZlYXR1cmUuDQoNCkl0IG1lYW5zIHlvdSBuZWVkIHRv
IGJlIHJvb3QgdG8gcnVuIHRoZSBwcm9ncmFtIC0gdGhpcyBpcyB0aGUgZXhwZWN0ZWQgYmVoYXZp
b3Igb24ga2VybmVscyB3aGljaCBkbyBub3QgaGF2ZSBteSBjaGFuZ2UodG8gYWxsb3cgbm9uLXJv
b3QgYWNjZXNzKS4gU28sIHRvZGF5IGlmIHlvdSB3cm90ZSBhIHByb2dyYW0gdG8gdGVzdCBiYXNp
YyBjb25uZWN0b3IgY29kZSB3aXRob3V0IGZpbHRlcmluZyh3aXRob3V0IG15IGNoYW5nZXMpIC0g
dGhpcyBpcyBob3cgaXQgd291bGQgcmVzcG9uZC4gVGhpcyBpcyBhIGNoZWNrIGluIHRoZSBrZXJu
ZWwod2l0aG91dCBteSBjaGFuZ2VzKSB3aGljaCBtYWtlcyBiaW5kIGZhaWwgaWYgdXNlciBpcyBu
b24tcm9vdC4gV2l0aCBteSBjaGFuZ2UgdGhpcyBjaGFuZ2UgaGFzIGJlZW4gZWZmZWN0aXZlbHkg
cmVtb3ZlZC4NCg0KQW5qYWxpDQoNCj4gDQo+IFNpbmNlIHRoaXMgdGVzdCBlc3NlbnRpYWxseSBi
ZWhhdmVzIGRpZmZlcmVudGx5IHdoZW4gdGhlIGZlYXR1cmUNCj4gaXMgc3VwcG9ydGVkIHZzLiBu
b3QuIFNvIGl0IGhhcyB0byBiZWhhdmUgY29uc2lzdGVudGx5IHNvbWVob3cNCj4gY2hlY2tpbmcg
Zm9yIHRoZSBmZWF0dXJlIGFuZCByZXBvcnQgY29ycmVjdGx5Lg0KPiANCj4gdGhhbmtzLA0KPiAt
LSBTaHVhaA0KDQo=
