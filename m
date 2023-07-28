Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E92766160
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 03:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjG1BjC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 21:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjG1BjB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 21:39:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A623584;
        Thu, 27 Jul 2023 18:39:00 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S12u3h014605;
        Fri, 28 Jul 2023 01:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=qS63BiLmSuUpleX6PS78ZK92GJWuyxYTTscCJfUOEvA=;
 b=rwfIjfEEWMgY1kzl9/5q6JoscpB9ngx4s/IIdWwhgRt236kY9CbBUKH/6KgU8mYBBMQG
 NFtY5VA4YVZgtOn/FoUJReF043f5op9z7ulMy+k7JMgMcMpYDZ98hPcw4hz3ZXbJES3A
 Gl0LGNuzzlE84dgEnel34Rr1kmJDSAiJKNeX6oJI76uZx2sqGjFwmJKU9D6YEEO7/KqJ
 r83sJHa4uO8R6JSoQQjPU3cSnErad7PQyuVEyQOTOe3FPPKh2RxhQN3JEdO/4X+r7hrU
 tPVgIxV/kYSqnj3WeDeQDunNeecQloDeO8/TB6UYTJRSYOuD31UMnjCe9my6Uf2VlZTB 8Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s070b2y77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 01:38:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36S1F85F025318;
        Fri, 28 Jul 2023 01:38:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j8vb8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 01:38:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnwAQtkW75qLnZpHBpZClvfaI9htCREoxhBzz1uI3jsG/CgrwT6jaRlyKtLk9rT8zT3/58CW0tJ/LdXmDEBiYVRWcPvFVdVsPHh3nKs7my7XDVhXnlkXjyX7OtHTz4qve4f9X8Phl/hRvDAHd9pQdCXuwLMc+e+H3f2bBfHBWs/NUFi2RIIKUQv1DeAj7Qj1kUdxMPPYS8JMdqqEyDoA8Dtap62m+DwwgQxujQZZVA4NP9O9PQZ7xZBOX7KAaMBKZHEAqMKtZmGlin6SAMDkp7L+ubcV9kLiV9xmljdknSKIktMcyZi9PoBjnci2bo5pryv8GT8NAHWkRF2ZBg6KkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qS63BiLmSuUpleX6PS78ZK92GJWuyxYTTscCJfUOEvA=;
 b=W5JPT2TKoepVxyE4KEWSDWhccYh5qZylHN5u7yfmneH+kqrTWVIBN2kwll7VL8KKFzttd0S2hQuHZRsOY6HDO/7C87eJ5tOp6PU82lBW68Jla6knNWNOUKxZ8/uKe5lbYFPQnf2Ds9fnvdRyjgO9M1wYnO/06HxnT7tYxjr7NL5YFBYG6whpvrVWJpkz6hjmtDTo9YexEv/Zjnen7Apfw1xpa0z/VrAkEi1FmSIJBxExGI5wcdnVFtVZhH4iYADwavBNKYDpJPsytNfD7uzmbDeBldBod67xpTvAu47V0Cd+qXW0BEJwQQEOTZUBgrYdYJuzfymQK9dq6Rtc7nO4GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qS63BiLmSuUpleX6PS78ZK92GJWuyxYTTscCJfUOEvA=;
 b=s5wvmTCwxL27cho52uvZ2LuEh+zn2iwrzdSrQKDAzvLS042IuVT9R+ftgGGTnaUDiFZNhP+nNuhSAzRU3lt5ZnzUlGDdJnkE2lpHu7vF4K5ouLUEe285BDzAVIhoZvFo1uhMhDAhgnY1nVKo6TiBxvhlvn4rWSfA6Nz+MMivX3k=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by SA2PR10MB4618.namprd10.prod.outlook.com (2603:10b6:806:11f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 01:38:41 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::69d6:8729:ee7c:cc45]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::69d6:8729:ee7c:cc45%2]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 01:38:41 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
CC:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        Netdev <netdev@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Liam Howlett <liam.howlett@oracle.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: selftests: connector: proc_filter.c:48:20: error: invalid
 application of 'sizeof' to an incomplete type 'struct proc_input'
Thread-Topic: selftests: connector: proc_filter.c:48:20: error: invalid
 application of 'sizeof' to an incomplete type 'struct proc_input'
Thread-Index: AQHZvvi/xI4ekXqIdU+9CLD2lWipK6/KsaiAgAMxnwCAAHfvgIAAD1EA
Date:   Fri, 28 Jul 2023 01:38:40 +0000
Message-ID: <DD53AFBE-F948-40F9-A980-2DA155236237@oracle.com>
References: <CA+G9fYt=6ysz636XcQ=-KJp7vJcMZ=NjbQBrn77v7vnTcfP2cA@mail.gmail.com>
 <E8C72537-4280-401A-B25D-9734D2756A6A@oracle.com>
 <BB43F17E-EC00-4E72-BB3D-F4E6FA65F954@oracle.com>
 <799d6088-e28f-f386-6a00-2291304171a2@linuxfoundation.org>
In-Reply-To: <799d6088-e28f-f386-6a00-2291304171a2@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|SA2PR10MB4618:EE_
x-ms-office365-filtering-correlation-id: 1e81fa7a-85d8-417d-aea5-08db8f0b5f52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mRQoT28XlJYg84pFAFPl6n0YLgqMjgKAIDErUQsu6pC1PJDMyv7lH7TguP33b8aP3Xzv2FlXXsFNXkdj1AohDqAvFaswpaHXD0oRqvG7YpVkT0f+Rfbe9comAvb4HDsZROSTt5rzUFUKFw9+ST3S4rpb5Xq75IHybeAejst7DdLg+RyKYn40MujRsqkvVpJ3Na147fbtbbjn9jUz5+raJ3XB2BMoRAGixCNaT4nLDfwdxjXdlbb1WrNZGwe+nQuDAwwlW+yKhLpJr0Kz4+1Kfqu1Pm4CJzYz+DZFabFe8qfHMWedTx4hk6fVtfH0UaXSt2ZuXInX3+SrvWtgAwVREZL7M88oGZ82VNzis7xn5X6sC5OxpTKS4462PhJl7CjoMImxlPMmT7C48aBWMI5O6WwRwioZY7kmlEnUyYZ2W9xu6kNMoEHapuEMio5KhSRu87Qa6TSz4eHKsF2mMjFPx+Q18Ord69WX07pPq8VfsLupS1xaTWvjUS5a870FXpLCd58EDaQjtooEB0tbE/izl0s9WnsiWOJ1w28mgS7qRnfqPGxJbkq8aYW9OUWKzICHp5Ds0NAxMjhvpSHrro5rYn3gmnS8pUK9lwkynLg655rLATfZjxyOelOblyOwlEcbzhLnEbsj2+KwkOq3svxs/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199021)(8676002)(5660300002)(83380400001)(2616005)(186003)(6506007)(33656002)(53546011)(86362001)(8936002)(7416002)(71200400001)(4326008)(6916009)(316002)(6486002)(38070700005)(64756008)(41300700001)(66556008)(66446008)(66476007)(66946007)(6512007)(122000001)(478600001)(76116006)(54906003)(38100700002)(2906002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enlZdmZXcUIwMkdyRlFhUnc5dnlSeTRUaHJPMjJ0cDE2TTE0R2g2azI4WXpK?=
 =?utf-8?B?SDB4OWZjUkdSeU9uVEtmbDlORTJpYlpXRkhGY3BweE1BOUNzV3ZqaWxtenJk?=
 =?utf-8?B?UFhVQjRWc25hamYvckJZdy9HcVYyMkJCNStCV2JWRkZZRVN3UlplQXV2TEFD?=
 =?utf-8?B?elZJaFJhak95bG54b2NaSEx3MHJkNEpBNnBYR1dUZWIzd1IrVGFtcFpLZWFC?=
 =?utf-8?B?bjUxNGpvTlpFdHRxTlNaeUJndXVMcGM3MS9BeG94ajFrRzlMMXYxUjhWR1I2?=
 =?utf-8?B?NkR1aEh3bDJtMU1hYUUwb2FSclA1Tlh2U3F5dllQZlNyWE9MQ0xCanVWeDh2?=
 =?utf-8?B?bzdhQURsRnFkRHpLZDlZa3ZVNW9aUkRlY2FYbTdScDR5NXRsdElxSThGRjgz?=
 =?utf-8?B?Y0xXUlp3eTdUYmVVdVlwY3N3cHg2MHluMWN2R2QweXlVQ1ZuTEdUU1ViZ1BZ?=
 =?utf-8?B?RnpMQUZ0NVpyNEE2a251akhFWDZJd3o1Mk9nQVRLWXh4b1cybURWTzBPMWR4?=
 =?utf-8?B?YlZObFU5TUJuK2FDaHZpUVRNWkdQSjA4V2lnbDlCNjMyYkExaWV4MjJmcXZq?=
 =?utf-8?B?OG1nWENiT3RiblZLUElJbnpnRE5KMnhON3ZmVWloRVByQ1k2UVBOZmhGMUZT?=
 =?utf-8?B?SzdrV1JiM2szYU4yUnVQWDNiTlVYZGxWZjQ2MWhxL1owREpmc25UbTVZdkc2?=
 =?utf-8?B?cVVxMTFLbEMwWmh1NVhxcjhjcVhZeUR0M245c2pHSlc1UUFDaVJOam9hOHR6?=
 =?utf-8?B?ajB1WEdVOVRHTGdCMEV6OFRuUVgwcm9QQnRIUlJhWXR0RE9TM1FpdEhpSFU5?=
 =?utf-8?B?UzB3cFh0NXlMVXM5alhYZTI0VzNWSk4zTVZhMnVrZkd0TEdhcDN6R2hvTmdr?=
 =?utf-8?B?QWY3R3hJcStUUFBUS28zTGZBeXVkTzFqTzJncXF1WldZWllOUHdScjI3ZURI?=
 =?utf-8?B?a3Q2ekFpSG9tSWMyeldPQUVNbE5NVmx1M1dKSG5SY3Ixb3RWdnVML0pNdkU4?=
 =?utf-8?B?ZnUzYTNMTnpqU3FuV0VUWmd0RXFtZVpoc2Z4L1Q1L05QcGo5bERKaHFOSjdi?=
 =?utf-8?B?UHVCN015UjVYM0toOHBncUdGM1kzR1Btb1dKZVRNa1NNbm55dktDSzRwSDh3?=
 =?utf-8?B?QlFnMVlObnNkcHFtOEJ1NjFuaVA2TndxbDU5a0J3RVZjbGIwVnpTaGZpSDlN?=
 =?utf-8?B?enlDWE53eEM1clJBTDFBRHE0WVEvdkJERGZTLzNQUHJrSWpyNDcyamdMWG9m?=
 =?utf-8?B?c1lxUE9JdmdoYmlNMzVkaHd1c2FkQUlrczZ4Lzd5TGhKWkczT2ltZ3YyMlZH?=
 =?utf-8?B?Y21TTkZGYmdPeGl1emhwNGgxb2V6NjJReEZGUXBMY2pUalU2cGR6QTBUamNa?=
 =?utf-8?B?TkZWa2ZzTE5ub0lFT2w1MHNEY0d3YmhnODNsaklOODRvTld4MjkzTUxPM1h0?=
 =?utf-8?B?SlVRN0lkVitaRmJna0E5WksvSldoMDVMQ1c0dGdFcHJNaGppMGlTN3RTWWVz?=
 =?utf-8?B?U09GZ2RHMDJzQjU4UXAyQksyMFg3SVdIWXZMUElaNDV6V1loOGdBd3gwUmNr?=
 =?utf-8?B?ZjdkdXNqTmRFSzJIWURSa1dRa2tCc2N2Tk05YmljaXdrOGRYQzE4RW81a3h3?=
 =?utf-8?B?VERpOWNLa0EydVBHNXdLN05NemxRQlBEa0FQQlhHVUFKN1NnZlpQRnFCSE1V?=
 =?utf-8?B?MGNrK3lEVkdkQ0ppTHFlUHFBc0lkRmJJZ1prMlJ1aVg2ZndtSXU0QjF0ektL?=
 =?utf-8?B?dmtxWlgyUlk4Z1ZvZCtkbE1RNUUxaHJ0V3JxZnF1elhKbHpXYzRic2l1dDFW?=
 =?utf-8?B?MXJZRU9OZFhySFVMUVZ6WGxqZFdpLy9vSmVnWDN1TFRtZ0xDSXh6bWcyeHlP?=
 =?utf-8?B?cGNZMHEwVjVMUnduamdPWHNpMTAzNmJ0d3lwRWlVZHRzZ0pmclpSN0JpRDNF?=
 =?utf-8?B?YVJtVEttMmZIdnpYUVN6aE5WdFFHZ2lhY21uaU1UZHRKa1JMTDg1ZERtU3A0?=
 =?utf-8?B?RlU3Z0E0MTArZ3NsOFZ5akREZmE5aTVKb1pyTVhtNU1JMk4yTjJvSDJ0L0w4?=
 =?utf-8?B?dGx5Zjk2N09Ed0RlVk9HTUxhUUlmTkRHU2FqbERzWkE2WVN5MldpRTNLVmxX?=
 =?utf-8?B?NGhZb1U0SVJXVnVkWWpjOVUzZmp2S2daUTZhNVREbFp0b0xSeHB3N0tmRUY4?=
 =?utf-8?B?cFdpdllHSHlJcUJOWk16RDVBV3BNTmZlS0hFN2NEZUZiVXNZYng0MmZFREls?=
 =?utf-8?Q?hmDT8nsxujNrH+gNtDjt2O1KbvRaRFTAMutRSt4WGg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5763E104E80B94795D00E3B1CCBCE5F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VWxOL1d1ZHdobXBBVE1hdHVZTEpEck05R2NlOHZzSlVYbkxsQ1F5a0NLN24y?=
 =?utf-8?B?K1U5RWM0dEk2cURDUG1WdHMvSHRhQ3BFbDcrc1Y2V1owdVZVc04rejluZHhP?=
 =?utf-8?B?UDVhd01IcUdFZkpkQjZBY1BkZVhYUksxVGpRdzJXS2hwN3p4Wm9VZGIrWG55?=
 =?utf-8?B?QVdhZ0MxOVpsbkN2NTJwS29Eejh2cWNBRHRablFhaDlkd1NsTnYzaTZRNHNi?=
 =?utf-8?B?bTZKRUtDNWJpak5JMUVUL2d4UXFFT0laWVZVZmVJanVVOHZpcXJWaEMraWlz?=
 =?utf-8?B?YXR5cFdTci9ZaXp2NHB6RUZYeHg5R3FWNmdEMzcyVGtmVUs2UzQyWW5tVmx0?=
 =?utf-8?B?ZEZzajlQNDkrR3JnamIrNnhQa0tDTGdtdSs1YWI4VTB5bHNldmNKUjJTY3dJ?=
 =?utf-8?B?elFWUVZlVDZBcDJzeXYwbkUrSEdWYmRod0IwdHhBbGRqdjJVay9XdFZqT2I1?=
 =?utf-8?B?U2RoY0ZsZG5ZUFR2YWtvYjU1aXc2SWNRN1NlTU4wZjlqMFp1MUNOR3BZUm52?=
 =?utf-8?B?VnNjY3FIUWxiMWhwWkFvNjFvNmhEMVBaTnF5aDhwa2hkMXdTYjBBa2J3TVdD?=
 =?utf-8?B?SU4vMGtFaXhxb0ZPVm5jYVFIa0VhR2xlUWhjOHZwVnZyc3R3cVhvNEFYQWpK?=
 =?utf-8?B?R3B1bFdtMS9WRzR1bDhEZXovbzJ6K2VGenZadEczelgyRE9vS01GbDhwZGxV?=
 =?utf-8?B?YnUzNGdtdURRSlpoeUc5VnBEaFFEQ0pSem9xRldaNjJpaXFrZkZpbS9VN0ls?=
 =?utf-8?B?WHJpOWU1ZVpnYzhqcFFJa3p6S0dveld3K2o0NUhXSGphMEFRY2dEM1hQRzhx?=
 =?utf-8?B?TkczdDl3V25HcC82ZzFYUnpMV3Jmdkt4Vk51TlRGb0xscTRPK20wSVRIZ2Za?=
 =?utf-8?B?UFhTZXczaVRsQUUwRDhUVHRwaXAyMHhDekhhS2U2aFlXSWEzZk5SbFVRT0NT?=
 =?utf-8?B?Si80RlllSXA4cDNHT3UvVzI1cUg3NGIyUVhDQ08rL2RQbHp0YXMwV1FMbWt3?=
 =?utf-8?B?bnp4QzNBRG5mRUJrdjhuS2dac216QW5jSVBYWVFoTDJORUw2c3U2aldRaXJ3?=
 =?utf-8?B?a1BJalRZd2xiNkN1LzRkb3Z0SVhHMmNnbEVYVmlGaXlnWXJTNnJJKzl1dEt3?=
 =?utf-8?B?U3VhMnlRMkk3YjVLU28zSW95S1VFakxlZWxQelZHSE95Qm9tZVFyanRKeVBB?=
 =?utf-8?B?cHVOVHRGd2kwTEpqYUtmdmZKd3JDSjYzeU1QMTJwKzNvcExOb1pDL0dteXJi?=
 =?utf-8?B?Q3JUdmgrQU5pZitna3FhR3BNSXpqbzdtcnQ5ZmdrMzNVMnVSOEFmVFVWM213?=
 =?utf-8?Q?aHtxtoSoI4j5i6hy+T5bjUE9KGGuAYzXET?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e81fa7a-85d8-417d-aea5-08db8f0b5f52
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 01:38:40.9697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GXaz2lc98AtjspIQOciz60ffxGjQ0Pgx5sNbK9PDR3SUTwZri85Wbz38KJXTJt1AVsPGLOCkOv3mpv1ALz/lh1g3m7KKsrEz1cPGGYExSbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4618
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280014
X-Proofpoint-GUID: ydYlCL-D5vpw-fQHsW2WtHMoDMbne7P0
X-Proofpoint-ORIG-GUID: ydYlCL-D5vpw-fQHsW2WtHMoDMbne7P0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gT24gSnVsIDI3LCAyMDIzLCBhdCA1OjQzIFBNLCBTaHVhaCBLaGFuIDxza2hhbkBsaW51
eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IE9uIDcvMjcvMjMgMTE6MzQsIEFuamFsaSBL
dWxrYXJuaSB3cm90ZToNCj4+PiBPbiBKdWwgMjUsIDIwMjMsIGF0IDk6NDggQU0sIEFuamFsaSBL
dWxrYXJuaSA8QW5qYWxpLksuS3Vsa2FybmlAb3JhY2xlLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4g
DQo+Pj4gDQo+Pj4+IE9uIEp1bCAyNSwgMjAyMywgYXQgNjowNSBBTSwgTmFyZXNoIEthbWJvanUg
PG5hcmVzaC5rYW1ib2p1QGxpbmFyby5vcmc+IHdyb3RlOg0KPj4+PiANCj4+Pj4gc2VsZnRlc3Rz
OiBjb25uZWN0b3I6IHByb2NfZmlsdGVyIGJ1aWxkIGZhaWxlZCB3aXRoIGNsYW5nLTE2IGR1ZSB0
byBiZWxvdw0KPj4+PiB3YXJuaW5ncyAvIGVycm9ycyBvbiBMaW51eCBuZXh0LTIwMjMwNzI1Lg0K
Pj4+PiANCj4+Pj4gUmVwb3J0ZWQtYnk6IExpbnV4IEtlcm5lbCBGdW5jdGlvbmFsIFRlc3Rpbmcg
PGxrZnRAbGluYXJvLm9yZz4NCj4+Pj4gDQo+Pj4+IGNsYW5nIC0tdGFyZ2V0PWFhcmNoNjQtbGlu
dXgtZ251IC1maW50ZWdyYXRlZC1hcw0KPj4+PiAtV2Vycm9yPXVua25vd24td2FybmluZy1vcHRp
b24gLVdlcnJvcj1pZ25vcmVkLW9wdGltaXphdGlvbi1hcmd1bWVudA0KPj4+PiAtV2Vycm9yPW9w
dGlvbi1pZ25vcmVkIC1XZXJyb3I9dW51c2VkLWNvbW1hbmQtbGluZS1hcmd1bWVudA0KPj4+PiAt
LXRhcmdldD1hYXJjaDY0LWxpbnV4LWdudSAtZmludGVncmF0ZWQtYXMgLVdhbGwgcHJvY19maWx0
ZXIuYyAtbw0KPj4+PiAvaG9tZS90dXhidWlsZC8uY2FjaGUvdHV4bWFrZS9idWlsZHMvMS9idWls
ZC9rc2VsZnRlc3QvY29ubmVjdG9yL3Byb2NfZmlsdGVyDQo+Pj4+IHByb2NfZmlsdGVyLmM6NDI6
MTI6IGVycm9yOiBpbnZhbGlkIGFwcGxpY2F0aW9uIG9mICdzaXplb2YnIHRvIGFuDQo+Pj4+IGlu
Y29tcGxldGUgdHlwZSAnc3RydWN0IHByb2NfaW5wdXQnDQo+Pj4+IGNoYXIgYnVmZltOTF9NRVNT
QUdFX1NJWkVdOw0KPj4+PiBefn5+fn5+fn5+fn5+fn4NCj4+Pj4gcHJvY19maWx0ZXIuYzoyMjo1
OiBub3RlOiBleHBhbmRlZCBmcm9tIG1hY3JvICdOTF9NRVNTQUdFX1NJWkUnDQo+Pj4+IHNpemVv
ZihzdHJ1Y3QgcHJvY19pbnB1dCkpDQo+Pj4+IF4gfn5+fn5+fn5+fn5+fn5+fn5+fg0KPj4+PiBw
cm9jX2ZpbHRlci5jOjQyOjEyOiBub3RlOiBmb3J3YXJkIGRlY2xhcmF0aW9uIG9mICdzdHJ1Y3Qg
cHJvY19pbnB1dCcNCj4+Pj4gcHJvY19maWx0ZXIuYzoyMjoxOTogbm90ZTogZXhwYW5kZWQgZnJv
bSBtYWNybyAnTkxfTUVTU0FHRV9TSVpFJw0KPj4+PiBzaXplb2Yoc3RydWN0IHByb2NfaW5wdXQp
KQ0KPj4+PiBeDQo+Pj4+IHByb2NfZmlsdGVyLmM6NDg6MjA6IGVycm9yOiBpbnZhbGlkIGFwcGxp
Y2F0aW9uIG9mICdzaXplb2YnIHRvIGFuDQo+Pj4+IGluY29tcGxldGUgdHlwZSAnc3RydWN0IHBy
b2NfaW5wdXQnDQo+Pj4+IGhkci0+bmxtc2dfbGVuID0gTkxfTUVTU0FHRV9TSVpFOw0KPj4+PiBe
fn5+fn5+fn5+fn5+fn4NCj4+Pj4gcHJvY19maWx0ZXIuYzoyMjo1OiBub3RlOiBleHBhbmRlZCBm
cm9tIG1hY3JvICdOTF9NRVNTQUdFX1NJWkUnDQo+Pj4+IHNpemVvZihzdHJ1Y3QgcHJvY19pbnB1
dCkpDQo+Pj4+IF4gfn5+fn5+fn5+fn5+fn5+fn5+fg0KPj4+PiBwcm9jX2ZpbHRlci5jOjQyOjEy
OiBub3RlOiBmb3J3YXJkIGRlY2xhcmF0aW9uIG9mICdzdHJ1Y3QgcHJvY19pbnB1dCcNCj4+Pj4g
Y2hhciBidWZmW05MX01FU1NBR0VfU0laRV07DQo+Pj4+IF4NCj4+Pj4gcHJvY19maWx0ZXIuYzoy
MjoxOTogbm90ZTogZXhwYW5kZWQgZnJvbSBtYWNybyAnTkxfTUVTU0FHRV9TSVpFJw0KPj4+PiBz
aXplb2Yoc3RydWN0IHByb2NfaW5wdXQpKQ0KPj4+PiBeDQo+Pj4+IHByb2NfZmlsdGVyLmM6NjQ6
MTQ6IGVycm9yOiBpbnZhbGlkIGFwcGxpY2F0aW9uIG9mICdzaXplb2YnIHRvIGFuDQo+Pj4+IGlu
Y29tcGxldGUgdHlwZSAnc3RydWN0IHByb2NfaW5wdXQnDQo+Pj4+IG1zZy0+bGVuID0gc2l6ZW9m
KHN0cnVjdCBwcm9jX2lucHV0KTsNCj4+Pj4gXiB+fn5+fn5+fn5+fn5+fn5+fn5+DQo+Pj4+IHBy
b2NfZmlsdGVyLmM6NDI6MTI6IG5vdGU6IGZvcndhcmQgZGVjbGFyYXRpb24gb2YgJ3N0cnVjdCBw
cm9jX2lucHV0Jw0KPj4+PiBjaGFyIGJ1ZmZbTkxfTUVTU0FHRV9TSVpFXTsNCj4+Pj4gXg0KPj4+
PiBwcm9jX2ZpbHRlci5jOjIyOjE5OiBub3RlOiBleHBhbmRlZCBmcm9tIG1hY3JvICdOTF9NRVNT
QUdFX1NJWkUnDQo+Pj4+IHNpemVvZihzdHJ1Y3QgcHJvY19pbnB1dCkpDQo+Pj4+IF4NCj4+Pj4g
cHJvY19maWx0ZXIuYzo2NTozNTogZXJyb3I6IGluY29tcGxldGUgZGVmaW5pdGlvbiBvZiB0eXBl
ICdzdHJ1Y3QgcHJvY19pbnB1dCcNCj4+Pj4gKChzdHJ1Y3QgcHJvY19pbnB1dCAqKW1zZy0+ZGF0
YSktPm1jYXN0X29wID0NCj4+Pj4gfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5eDQo+
Pj4+IHByb2NfZmlsdGVyLmM6NDI6MTI6IG5vdGU6IGZvcndhcmQgZGVjbGFyYXRpb24gb2YgJ3N0
cnVjdCBwcm9jX2lucHV0Jw0KPj4+PiBjaGFyIGJ1ZmZbTkxfTUVTU0FHRV9TSVpFXTsNCj4+Pj4g
Xg0KPj4+PiBwcm9jX2ZpbHRlci5jOjIyOjE5OiBub3RlOiBleHBhbmRlZCBmcm9tIG1hY3JvICdO
TF9NRVNTQUdFX1NJWkUnDQo+Pj4+IHNpemVvZihzdHJ1Y3QgcHJvY19pbnB1dCkpDQo+Pj4+IF4N
Cj4+Pj4gcHJvY19maWx0ZXIuYzo2NjozMTogZXJyb3I6IGluY29tcGxldGUgZGVmaW5pdGlvbiBv
ZiB0eXBlICdzdHJ1Y3QgcHJvY19pbnB1dCcNCj4+Pj4gKChzdHJ1Y3QgcHJvY19pbnB1dCAqKXBp
bnApLT5tY2FzdF9vcDsNCj4+Pj4gfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Xg0KPj4+PiBw
cm9jX2ZpbHRlci5jOjQyOjEyOiBub3RlOiBmb3J3YXJkIGRlY2xhcmF0aW9uIG9mICdzdHJ1Y3Qg
cHJvY19pbnB1dCcNCj4+Pj4gY2hhciBidWZmW05MX01FU1NBR0VfU0laRV07DQo+Pj4+IF4NCj4+
Pj4gcHJvY19maWx0ZXIuYzoyMjoxOTogbm90ZTogZXhwYW5kZWQgZnJvbSBtYWNybyAnTkxfTUVT
U0FHRV9TSVpFJw0KPj4+PiBzaXplb2Yoc3RydWN0IHByb2NfaW5wdXQpKQ0KPj4+PiBeDQo+Pj4+
IHByb2NfZmlsdGVyLmM6Njc6MzU6IGVycm9yOiBpbmNvbXBsZXRlIGRlZmluaXRpb24gb2YgdHlw
ZSAnc3RydWN0IHByb2NfaW5wdXQnDQo+Pj4+ICgoc3RydWN0IHByb2NfaW5wdXQgKiltc2ctPmRh
dGEpLT5ldmVudF90eXBlID0NCj4+Pj4gfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5e
DQo+Pj4+IHByb2NfZmlsdGVyLmM6NDI6MTI6IG5vdGU6IGZvcndhcmQgZGVjbGFyYXRpb24gb2Yg
J3N0cnVjdCBwcm9jX2lucHV0Jw0KPj4+PiBjaGFyIGJ1ZmZbTkxfTUVTU0FHRV9TSVpFXTsNCj4+
Pj4gXg0KPj4+PiBwcm9jX2ZpbHRlci5jOjIyOjE5OiBub3RlOiBleHBhbmRlZCBmcm9tIG1hY3Jv
ICdOTF9NRVNTQUdFX1NJWkUnDQo+Pj4+IHNpemVvZihzdHJ1Y3QgcHJvY19pbnB1dCkpDQo+Pj4+
IF4NCj4+Pj4gcHJvY19maWx0ZXIuYzo2ODozMTogZXJyb3I6IGluY29tcGxldGUgZGVmaW5pdGlv
biBvZiB0eXBlICdzdHJ1Y3QgcHJvY19pbnB1dCcNCj4+Pj4gKChzdHJ1Y3QgcHJvY19pbnB1dCAq
KXBpbnApLT5ldmVudF90eXBlOw0KPj4+PiB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5eDQo+
Pj4+IHByb2NfZmlsdGVyLmM6NDI6MTI6IG5vdGU6IGZvcndhcmQgZGVjbGFyYXRpb24gb2YgJ3N0
cnVjdCBwcm9jX2lucHV0Jw0KPj4+PiBjaGFyIGJ1ZmZbTkxfTUVTU0FHRV9TSVpFXTsNCj4+Pj4g
Xg0KPj4+PiBwcm9jX2ZpbHRlci5jOjIyOjE5OiBub3RlOiBleHBhbmRlZCBmcm9tIG1hY3JvICdO
TF9NRVNTQUdFX1NJWkUnDQo+Pj4+IHNpemVvZihzdHJ1Y3QgcHJvY19pbnB1dCkpDQo+Pj4+IF4N
Cj4+Pj4gcHJvY19maWx0ZXIuYzoyNDU6MjA6IGVycm9yOiB2YXJpYWJsZSBoYXMgaW5jb21wbGV0
ZSB0eXBlICdzdHJ1Y3QgcHJvY19pbnB1dCcNCj4+Pj4gc3RydWN0IHByb2NfaW5wdXQgaW5wdXQ7
DQo+Pj4+IF4NCj4+Pj4gcHJvY19maWx0ZXIuYzoyNDU6OTogbm90ZTogZm9yd2FyZCBkZWNsYXJh
dGlvbiBvZiAnc3RydWN0IHByb2NfaW5wdXQnDQo+Pj4+IHN0cnVjdCBwcm9jX2lucHV0IGlucHV0
Ow0KPj4+PiBeDQo+Pj4+IHByb2NfZmlsdGVyLmM6MjY0OjIyOiBlcnJvcjogdXNlIG9mIHVuZGVj
bGFyZWQgaWRlbnRpZmllcg0KPj4+PiAnUFJPQ19FVkVOVF9OT05aRVJPX0VYSVQnDQo+Pj4+IGlu
cHV0LmV2ZW50X3R5cGUgPSBQUk9DX0VWRU5UX05PTlpFUk9fRVhJVDsNCj4+Pj4gXg0KPj4+PiA5
IGVycm9ycyBnZW5lcmF0ZWQuDQo+Pj4+IG1ha2VbNF06IExlYXZpbmcgZGlyZWN0b3J5ICcvYnVp
bGRzL2xpbnV4L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nvbm5lY3RvcuKAmQ0KPj4+PiANCj4+
Pj4gDQo+Pj4gVGhlc2UgYXJlIGV4cGVjdGVkIHNpbmNlIHlvdSBuZWVkIHRvIGhhdmUgdGhlIGNo
YW5nZXMgaW4ga2VybmVsIHRoYXQgd2VyZSBjb21taXR0ZWQgd2l0aCB0aGlzIHBhdGNoIHRvIGJl
IGluc3RhbGxlZCBvbiB0aGUga2VybmVsIG9uIHdoaWNoIHRoaXMgaXMgYmVpbmcgY29tcGlsZWQv
cnVuIG9uLiBUaGF0IGlzIHdoYXQgdGhlIHRlc3QgaXMgZm9yLCBhbmQgdGhlIGNoZWNrIHRvIG1h
a2UgaXQgcnVuIG9uIHByZXZpb3VzIGtlcm5lbHMgYXMgd2VsbCB3YXMgbWFkZSBhIHJ1bnRpbWUg
Y2hlY2suIERvIHlvdSBleHBlY3QgdGhpcyB0byBjb21waWxlIG9uIGEga2VybmVsIHdpdGhvdXQg
dGhlIGNvcnJlc3BvbmRpbmcga2VybmVsIGNoYW5nZXMgdGhhdCB3ZXJlIGNvbW1pdHRlZCB3aXRo
IHRoaXMgcGF0Y2g/DQo+Pj4gDQo+Pj4gQW5qYWxpDQo+PiBHZW50bGUgcGluZyAtIGNvdWxkIHlv
dSBhbnN3ZXIgYWJvdmUgcXVlc3Rpb25zPw0KPj4+IA0KPiANCj4gSSBhbSBzZWVpbmcgdGhlIHNh
bWUgb24gbGludXgtbmV4dCBuZXh0LTIwMjMwNzI3DQo+IA0KPiBQUk9DX0VWRU5UX05PTlpFUk9f
RVhJVCBpcyBkZWZpbmVkIGFuZCBOTF9NRVNTQUdFX1NJWkUNCj4gDQo+IEFuamFsaSwNCj4gDQo+
IFdoYXQgYXJlIHRoZSBkZXBlbmRlbnQgY29tbWl0cyBhbmQgc2hvdWxkIHRoZXkgYmUgaW4gbmV4
dD8NCj4gU2hvdWxkbid0IHRoaXMgdGVzdCBwYXRjaCBnbyB3aXRoIHRoZSBrZXJuZWwgcGF0Y2hl
cyBpdCBkZXBlbmRzDQo+IG9uPyBDYW4geW91IGRvIHNvbWUgdGVzdGluZyBvbiBuZXh0IGFuZCBs
ZXQgbWUga25vdyB3aHkgdGhpcw0KPiB0ZXN0IGlzIGZhaWxpbmcgdG8gYnVpbGQ/DQoNCkFsbCB0
aGUgY29tbWl0cyB3ZW50IGluIHRvZ2V0aGVyIC0gaG93ZXZlciwgdGhlIGtlcm5lbCBjaGFuZ2Vz
IHRoYXQgd2VudCBpbiB0aGlzIHBhdGNoIG5lZWQgdG8gYmUgKmluc3RhbGxlZCBvbiBrZXJuZWwg
b24gd2hpY2ggdGhpcyBpcyBiZWluZyBidWlsdCouIERpZCB5b3UgZG8gdGhhdCBhbmQgdGhlbiB0
cnk/IA0KDQpKYWt1YiwNCkRvIEkgbmVlZCB0byByZXZlcnQgdGhlIC1mIHJ1bnRpbWUgZmlsdGVy
IG9wdGlvbiBiYWNrIHRvIGNvbXBpbGUgdGltZSBhbmQgY29tbWl0IHdpdGggdGhhdCBkaXNhYmxl
ZCBzbyB0aGUgc2VsZnRlc3QgY29tcGlsZXMgb24gYSBrZXJuZWwgb24gd2hpY2ggdGhlIG5ldyBv
cHRpb25zIGFyZSBub3QgZGVmaW5lZD8NCg0KQW5qYWxpDQoNCj4gDQo+IEl0IGlzIGZhaWxpbmcg
Zm9yIG1lIGZvciBzdXJlLg0KPiANCj4gVGhlcmUgY291bGQgYmUgcHJvYmxlbSBpbiB0aGUgdGVz
dCBNYWtlZmlsZSB0aGF0IGl0IGlzbid0IGluY2x1ZGluZw0KPiB0aGUgcmlnaHQgaGVhZGVycy4N
Cj4gDQo+IHRoYW5rcywNCj4gLS0gU2h1YWgNCj4gDQo+IHRoYW5rcywNCj4gLS0gU2h1YWgNCg0K
