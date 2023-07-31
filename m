Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F4676A376
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 23:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjGaVz3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 17:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjGaVzX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 17:55:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7BE173F;
        Mon, 31 Jul 2023 14:55:20 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VKfrxE014580;
        Mon, 31 Jul 2023 21:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1hP2JfxCVH1QjwfAPSEzylq96vDD4nePWYuMvvwWWlY=;
 b=Z6uSoBQlLTS7H4JmTWhOMBcfiSABD2Loz0EV34eJXUkzPEr787wofQmdxj8yQvujvuBb
 BNzJhl07Jn2Iau5Ztkyf0/0eNrdwdrIgJVzTxBDIShnLeSYYj7Ap78fhBop4NYGrApxH
 y6LXHbjtpkncqO+uX6FqA8By62MWxdW5TiqYdGu0Fhrq9frUe54W7RHrAcCGD0DLovt6
 NC4lszKlQlBCA6edTYpDzFtu8GTYQRQxfjVbgXvZXoAEC0Yj2eVWaqlB8dKg34kbs6UW
 jtDPOOK4OMWu9+W6dGOi/qmx5AwTGiG58Oq8C5DrRlvsAe1BUv9Qs/YD5zjgSh9I+LZq /Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4s6e3p05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 21:55:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VKGgxK000605;
        Mon, 31 Jul 2023 21:55:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7b9tcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 21:55:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfFlsHp8LDTBoI2GIheX20r69Affa++lOf9WVr4F5dCd+5ISzA1/Y5RCu4Itc8brUJaA2okxFZte5ejRzZMPDSEDag9bIffDDMo/jL1GsX8JeSRprszCObduP8ydYjO8fdkuaJ40MVWE+Qn6S+JV0jB5ZJEy9iFDnZF2ui43b1X/x1oqDBEMJcc1VVAjqgD7XDHHzZpgiCClZ1wIH4klPnCYbp7qFCQwTAIfN2HxtAFOliwnXiFI/WceT9qqP9MFqkoIz4kjj+3i6UPIM39ppvvoGa2ZC80ppNRnjBwVLSqnpVnJGA1PokQDj16DG6yP8UW1rTuqQKy4GGTSmD8yig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hP2JfxCVH1QjwfAPSEzylq96vDD4nePWYuMvvwWWlY=;
 b=AP3XHuuuFlX2u0bZt9J+IBTpPE6WyHjtyuWFO0hbgNTAI40LZMdmxOrVCmbJPP8Qq8PNXWR2JYpEcghlosQCsymBH7c/4fwg1KwyJ2/OeVKE/DO31uC7OowzJb9sre4iryaxV9GcCvz5zqPRcRXZun9IVB887zLNJ3MsfhWRfliw+z2b9Wae6BqgRYEyD9Rm0jUZEo9sRKqH9tmtw6/Fej/JAyTRrNKVjabPvk9Mc4YkmcCUh0jcS8/PoA+mrsTDxL4lvaWC5pKCcEzmH2B2hRy+JFbIkQAZndhY2uOhcS7wW+jtv/dPCqD7SSzOt49u+qNL8g4eUsDQ9c8W6U4rDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hP2JfxCVH1QjwfAPSEzylq96vDD4nePWYuMvvwWWlY=;
 b=it11XnGAz2eI/A8Xj5GNK/Wr+vCDi8+pos9Ih3QvNBXdOTu3tO3gjTdmDQIiL4UZlknpgipv/a+HCHYKhTijYRjcwbZoa84EHajuB8zNq7fSOXrSlPifpEV0SE19n0qCcDfWshIOPhTDQG9csfnv6gLV1FZ8+vu7aG6SOj1ADuQ=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by SJ2PR10MB6963.namprd10.prod.outlook.com (2603:10b6:a03:4cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 21:55:06 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::da5b:2093:7a3f:24a1]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::da5b:2093:7a3f:24a1%2]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 21:55:06 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
CC:     Shuah Khan <shuah@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        "naresh.kamboju@linaro.org" <naresh.kamboju@linaro.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH next 1/3] selftests:connector: Fix Makefile to include
 KHDR_INCLUDES
Thread-Topic: [PATCH next 1/3] selftests:connector: Fix Makefile to include
 KHDR_INCLUDES
Thread-Index: AQHZwXkVWe4Q1iwpjkepN88/mps7Ia/UcGGA
Date:   Mon, 31 Jul 2023 21:55:06 +0000
Message-ID: <AC6FD641-54FA-4B60-A0C3-27987C7588CA@oracle.com>
References: <cover.1690564372.git.skhan@linuxfoundation.org>
 <d0055c8cdf18516db8ba9edec99cfc5c08f32a7c.1690564372.git.skhan@linuxfoundation.org>
In-Reply-To: <d0055c8cdf18516db8ba9edec99cfc5c08f32a7c.1690564372.git.skhan@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|SJ2PR10MB6963:EE_
x-ms-office365-filtering-correlation-id: feb7a648-b15b-46cd-3567-08db9210cd24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X85ZqK9dNntac2HlSIB9HefbBHTwJnw85ISJfeKUtrARL0imcrTNHXTtgZKxKcvcgHSvfvMc0X14K3UfXf/+inXwpUbuhkp73ls6trcFsBhKcoXzmdLcy11vbuQOs4z4tGvjSmxOcfkGXCzL8nhbM7fwoix+ttDBiAaQuqVqP3f3ahRq9QJEbUgnDOZN/meuH6AXagkijulT03/dwMKN6ZsO8yhqIL8FIBOaOO0aVQv6gtmqNQC/OEtg4IOnD9AzI6W+IpUD20BLxQ6fDt1k2xRxZ+CKhBrMs9Z8NmijSpehz6LWj2kPGezCGJzIiEmbupsaf2xtyiz2k8xp3B99PIAHrkqLrUn/7rif9DRgQKy3lQfu33MkhY6gvk41lz3sd2hTgMIzsQhA1rz1flXZFw5cg8rWlBOYK37GDzsw0mihKk9keH22gh23munSQ9o+CvzFkAVpnmon/i38ts/6sAg55TX3k8LQ/oabgmXS13qvThvMd47GW3i28Uf+NVwlINo17alq34c1BZv+JQTiOMvWHWHIXfuAGmVmMMCR72Uzd23b7ludF2dizp70Wh/suBjMhBUz2JnIPZUWhCvbYemhbcWpw7TfpkiYAFt3pnvYhqDULmGX1D6wjbhxocKFF+mt4r54jW84Y9stjlLMIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(38100700002)(122000001)(86362001)(38070700005)(33656002)(36756003)(6512007)(966005)(71200400001)(478600001)(6486002)(2616005)(186003)(53546011)(8676002)(8936002)(6506007)(7416002)(5660300002)(66556008)(66476007)(66946007)(76116006)(6916009)(64756008)(2906002)(54906003)(66446008)(4326008)(41300700001)(316002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3JFTk8zOVpyd1I0alJtSVNsYjZGbnUxUU5TOEM1dEJocWU0N2FIU3hjNWQx?=
 =?utf-8?B?dWdCaWRsM1NHdTlvTmcyUG1FcEx2OVZ5S1BteVJRQjRTa1V3Vy9qVFVPZS9Y?=
 =?utf-8?B?QkxualV2eUJsRUlOYXRQTnFGQkE5dEZwRGNjUXV1TS9qVzVKaDN1ZDJhR0NX?=
 =?utf-8?B?QkowTkttdm56NFVNNzlHWFNIUUZoOE1rWGlBalhJWUltc2xZMThiRXh6WVN5?=
 =?utf-8?B?bGNaWVVQemMwOXNreXN2NEF6UTgyYVREam1NeUN3OGpHOENWek94VGNDbDAy?=
 =?utf-8?B?Tm1yVFRUTjZMOVA1OU9GQnlubXIybEZiT1Q2ejBzTDd5OFk2bkNSSHgxKytz?=
 =?utf-8?B?KzVtWU5SRkFsZWY2UmlBNlo0dUlSUndDMDhQQTNoOEtwOExlRStPSjJ2UC9o?=
 =?utf-8?B?QXJSYk9TMUlUWkVnSmdwbGM0NGNRckxSdUlES0FzL3B4UWFZWXlZVEUyN0xx?=
 =?utf-8?B?WTA4YldkMlFDNDRvd3NhMXRLVEdMbUdVM3JkNlViWG1lNm4vYWxJbU45bHdt?=
 =?utf-8?B?VVc5bWVtNmxoQjZ1MkJGc3ROczhuZHdvRXM5Y2p1MXRLbnRCaHB2YS9TeTdr?=
 =?utf-8?B?K0tBTGFCQXZZWE8zZUpIdDJ4QnRHWXBZVVFHaDM4WEdFY0ZtWHBFZnoybVo4?=
 =?utf-8?B?SG44MGEzL2ZmaUxhRWZDTG1IbEtWQUtxcGI1U21uRmI5YzJmN1NjUWRFaVh2?=
 =?utf-8?B?T1J6bitPMGdPTVh4STBGMDhXNjlnekZyK01RZDI4N0tib1ZMWEN5aEpnY1Q5?=
 =?utf-8?B?ZHJJUnMxZU91VlBjZXF3Q1VDeGlTRkZkSDBMRmZvaDZzenl3cC85a2RsMHQr?=
 =?utf-8?B?VkM4Y0hxalJDNFIrRGdIdlpWK0hvOG9pdXRjd01uT0poT3gzUHdORzJ0eGRl?=
 =?utf-8?B?ZEdoZU5kN3FRdi9WU0RRMWVsZ0hCRDZNZTJuSmtxU3J4VXZIQTRvbVFyOStE?=
 =?utf-8?B?UlpyK3lCRDhIaG93VWhaMG1xb1MveG5qS29vR1NrOXBxQ1oxcHlUUW9NUG4v?=
 =?utf-8?B?ckRLSzNPL0EvUkgrUlkvcm0raFlrNWV1LzhjeDFuUXo2RjB3K0lqR3c3dEdo?=
 =?utf-8?B?OGZIWFRFTDNqSE5COENWUGdjM3ZHUDV1NnJCSTA2V0xEdk80M2FXWDBqU010?=
 =?utf-8?B?aWRleWlrQVZUMlVwcTJBYTA0ZDN4N2x2Wi8yY3JKbUp4Zy84RDB4Y0VGL04x?=
 =?utf-8?B?anFTb1Mycy9xSXFDdnd3bThDeTYyejVRZHpFT0xYODF4d0VnS3ZnU01hRitY?=
 =?utf-8?B?NlJGQnlLRkE4dWlxSHR5clFyMzlHV1BiRC9LM0VBdDlaZ3d1RVdZNjlQUHNQ?=
 =?utf-8?B?NUpQR3l6ZGpVbUMzZlk2UVJEMm1mVCtUK3p6M01qMHlrTmE1cm8yVXRZeUtM?=
 =?utf-8?B?VnhSTHg1bFNncEEvTWtkZXM0KzlYeEp0ek5XckdlRzhaTXAzMXUxMmd5L3FQ?=
 =?utf-8?B?Wk1aWWc4WndUVlVZaUNBSzQ1eTZvYnJNRWNlT2pBQUdFc1pSeHg0SEVYd0RL?=
 =?utf-8?B?UTdQOUxTZUJLckRkWlVpeElDcWw3WXZZZnZ6T1h4WnJtSzhUL3g3MWMyMUNy?=
 =?utf-8?B?MmRQK2YxUDB5L21pakZ0U2JpbjZiRGdQYzRwUzRjUVdVckh2Q3I2eUt1WHFY?=
 =?utf-8?B?Vkt0TWZnN2JoZVRpS2xqYkdIYmE4RmFaWnJ4M3RwN3pBWU5DWHhqdlg2UXdU?=
 =?utf-8?B?d21mRFM2bkpGQVYvSENLY0xDWE04c3V1VHhtamt4d2VJRXl0bkMzYW9INWJM?=
 =?utf-8?B?T29kejFKU0tYQ2VIZUN1ZmpYeDJiMVlvT1NDamx2NTcycFBiYlIveTNIbDJC?=
 =?utf-8?B?MGI5U1d6ZHkxRGZZemlUbWFRTFJzeXJ2S0hHUGFxbDBDWXFpK3NxZGsvSGo2?=
 =?utf-8?B?aFBHUzBNMDhNUWQzQS9WcU1OWTlTUUdrcmFMSkFWRnBDNXV2OGp0S3Rrck1s?=
 =?utf-8?B?Qk0zY2xST2Q3cFE0bGM3TUdJbm5Xa0RVS1JabEJ4Rk1yc0Q0QnJFNUMycm42?=
 =?utf-8?B?ZDk0ZG1tNi9aZkFKLzd3NjdxVkVnMXREYmZzZ3VHa3FsNS9ZMGhRYkh1SWpZ?=
 =?utf-8?B?MDFUWHM4aUliUFpiclNWK1U1TFV2bVc3cWtVa3JtV3plNE5EcUE1dDBSQUdD?=
 =?utf-8?B?K1NhK2lnOXpXNUdjelFkZmZwVXZiNmw1RE45YjVpU1BKUVpMRGxFNnRXWVN4?=
 =?utf-8?B?dUtIa25KUEhHY1ZRQmlveDRhQWJpTUlZRFdqeUpKMUticzFDQ3hzQ2V6L0ly?=
 =?utf-8?Q?QQCS0f5LEYkLm267GhnKfsYAbeKxAMeiwlm1h50ku0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25EEE78047E45B4CA3B07D912A334F5B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VFFhY1pHamdBbmg5UVAvdXI5K3BnQ0dueGZzQVVhWTNSeitwL0VLOEF1VGwv?=
 =?utf-8?B?YzB0RDc4bnhtL3ZlU21JSzNGb3VBQjcxZzZHNkgwMkZxWUk2Ym9VWmFiRDIr?=
 =?utf-8?B?elMvWGVqd0VUUG5UbDdIaFFIeUVPa2luSWpwbGlUUEFkZkdjZVF5WDAwcCs2?=
 =?utf-8?B?TE42d1J0MXBqdG1NYzUzb3E2VW41UnNDY0IrcHhmVWRrY0kzOXR5S1hvdWlZ?=
 =?utf-8?B?MmpmK2lHVnYyZXhnVEpzVkZteE9zSWFEeTJoL21ORmFON0YyUTcrQTdLZVFY?=
 =?utf-8?B?YWxDbjBiWlNkenNrdkdaZEZRb1JRSnhlY21tbE5vU01Pa3gvYi9NNDI2d1BZ?=
 =?utf-8?B?ckE0TDJoM0U5RUVFWmx1SHQxTm5XSkYvOEMwV2owUnUydGtTTHRTakJKTmxZ?=
 =?utf-8?B?NDJkTEpWSk42dm91U2lVdHNLdE9HZEE0QW9EbWVORXNRa2RpdmE3N0NJNnN4?=
 =?utf-8?B?NFJMZmRTRnpSQVU0QmRrQWg1RWUzRkFFSUN4OVZBQ01EY0VoWFJZZ0oxb0tL?=
 =?utf-8?B?VlpyVHErQ20yTUswdEdwWHlvb3dGZVlFN1JscTNFSjN0RXdaeUp2YXRTU2x4?=
 =?utf-8?B?SnpIMzJzWEpTbmhwUEdFL0krZXpUS1pQWXlUVzZvRm1XSGlpS0pqWEwzcU9S?=
 =?utf-8?B?NzRYclU4MS9mS2h1TFFna2RMdFpjcGptKzZkckt5cmNlcEFGbXpLSVpFSy9k?=
 =?utf-8?B?Ti9vd1ZCZ3B0VFNzVUZCSlQwaTArTWd5YU1MM2VpOWdNYUdLbHhaSW0yVzlL?=
 =?utf-8?B?VFMzZkdTSERJZ01Ba3hsTkRZa0ttNTR6Sk5vSkxRQjlOVU1SbkVCUTFOOEhN?=
 =?utf-8?B?VG16em1GM1dNSjYxcnZwTndUaVozT3hUMFVzZWJyNHdzU2xtMnhsSU9XRkQ1?=
 =?utf-8?B?YWU4NmhLcW4yaTFkNWJGMGJrbjdxRktuMUMrMXpXY3NJZW1mK3JvQkdkeEdE?=
 =?utf-8?B?eU8vNVRaZFVPWWtOWWw0UEw1cEJxald2QVpLNHVGQmFxZ3liOWJNdGxzQm5L?=
 =?utf-8?B?YzAzb3JJUkRlNGNaUU5tcjZDeDVwczJCRm1uZjdiWXE4Y1EzTW5HaE1RWUZM?=
 =?utf-8?B?SWZEc0NqSkNzaWxnWWxvMnJmNHJsUlNabGd4K3VDUFlXVFJ5M2l5WEh6YWFs?=
 =?utf-8?B?Ymc5YmZHeEovbjhmNFpaVGNUYm45TE9jZnRDa2VRMS9kZlB3SXAvaVY2Qkt0?=
 =?utf-8?B?eHRka3dKdGdXZHhFRjVZSVgwYjVMTG1oSllzcTJQK3lJdTFSWDBKU3RrNS9x?=
 =?utf-8?B?aHA4S0krYVN3OGh4TVl5cVE2RTgxL0tQYmxlcmV2NnlPQ0gyM2tvNi9LMVds?=
 =?utf-8?Q?VyKp/1r1UdXKefX8Pl7aYP05Er5+n5OguY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb7a648-b15b-46cd-3567-08db9210cd24
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 21:55:06.1833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 99STVeKQguiohJfufFLFKmj3TXuEVFX9xvdryuOEDDNzvNmk+5FZsf6DCYUof5zIOJxT4cbGU8oZAPO4oXRKwrebI3hFCXq63UDc0jUB/NE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6963
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_15,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310199
X-Proofpoint-GUID: ldfP82YP0vGfkvfjOs3v-52s6-wL8MY_
X-Proofpoint-ORIG-GUID: ldfP82YP0vGfkvfjOs3v-52s6-wL8MY_
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gT24gSnVsIDI4LCAyMDIzLCBhdCAxMDoyOSBBTSwgU2h1YWggS2hhbiA8c2toYW5AbGlu
dXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+IA0KPiBUaGUgdGVzdCBjb21waWxlIGZhaWxzIHdp
dGggZm9sbG93aW5nIGVycm9ycy4gRml4IHRoZSBNYWtlZmlsZQ0KPiBDRkxBR1MgdG8gaW5jbHVk
ZSBLSERSX0lOQ0xVREVTIHRvIHB1bGwgaW4gdWFwaSBkZWZpbmVzLg0KPiANCj4gZ2NjIC1XYWxs
ICAgICBwcm9jX2ZpbHRlci5jICAtbyAuLi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jb25uZWN0
b3IvcHJvY19maWx0ZXINCj4gcHJvY19maWx0ZXIuYzogSW4gZnVuY3Rpb24g4oCYc2VuZF9tZXNz
YWdl4oCZOg0KPiBwcm9jX2ZpbHRlci5jOjIyOjMzOiBlcnJvcjogaW52YWxpZCBhcHBsaWNhdGlv
biBvZiDigJhzaXplb2bigJkgdG8gaW5jb21wbGV0ZSB0eXBlIOKAmHN0cnVjdCBwcm9jX2lucHV0
4oCZDQo+ICAgMjIgfCAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKHN0cnVjdCBwcm9j
X2lucHV0KSkNCj4gICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+
DQo+IHByb2NfZmlsdGVyLmM6NDI6MTk6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhO
TF9NRVNTQUdFX1NJWkXigJkNCj4gICA0MiB8ICAgICAgICAgY2hhciBidWZmW05MX01FU1NBR0Vf
U0laRV07DQo+ICAgICAgfCAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn4NCj4gcHJv
Y19maWx0ZXIuYzoyMjozMzogZXJyb3I6IGludmFsaWQgYXBwbGljYXRpb24gb2Yg4oCYc2l6ZW9m
4oCZIHRvIGluY29tcGxldGUgdHlwZSDigJhzdHJ1Y3QgcHJvY19pbnB1dOKAmQ0KPiAgIDIyIHwg
ICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihzdHJ1Y3QgcHJvY19pbnB1dCkpDQo+ICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fg0KPiBwcm9jX2ZpbHRl
ci5jOjQ4OjM0OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYTkxfTUVTU0FHRV9TSVpF
4oCZDQo+ICAgNDggfCAgICAgICAgICAgICAgICAgaGRyLT5ubG1zZ19sZW4gPSBOTF9NRVNTQUdF
X1NJWkU7DQo+ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+
fn5+fn5+fn4NCj4gYA0KPiANCj4gUmVwb3J0ZWQtYnk6IE5hcmVzaCBLYW1ib2p1IDxuYXJlc2gu
a2FtYm9qdUBsaW5hcm8ub3JnPg0KPiBMaW5rOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19f
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NBKkc5Zll0PTZ5c3o2MzZYY1E9LUtKcDd2SmNN
Wj1OamJRQnJuNzd2N3ZuVGNmUDJjQUBtYWlsLmdtYWlsLmNvbS9fXztLdyEhQUNXVjVOOU0yUlY5
OWhRIUxKSTRyaVY4M0ZkSVRtem9YbUNmeGxIS0dTZWV2eGctd242X0lTYTd0eHBFVFlXUHhidFZr
QXR4U2c2SVpHaTNrNW9oMkJLTXlyYm45NDY0a2NoSFludXFQRWFVJCANCj4gU2lnbmVkLW9mZi1i
eTogU2h1YWggS2hhbiA8c2toYW5AbGludXhmb3VuZGF0aW9uLm9yZz4NCg0KUmV2aWV3ZWQtYnk6
IEFuamFsaSBLdWxrYXJuaSA8YW5qYWxpLmsua3Vsa2FybmlAb3JhY2xlLmNvbT4NCg0KPiAtLS0N
Cj4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY29ubmVjdG9yL01ha2VmaWxlIHwgMiArLQ0KPiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jb25uZWN0b3IvTWFrZWZpbGUgYi90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9jb25uZWN0b3IvTWFrZWZpbGUNCj4gaW5kZXggMjFjOWYzYTk3
M2EwLi45MjE4OGI5YmFjNWMgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2Nvbm5lY3Rvci9NYWtlZmlsZQ0KPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jb25u
ZWN0b3IvTWFrZWZpbGUNCj4gQEAgLTEsNSArMSw1IEBADQo+ICMgU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjANCj4gLUNGTEFHUyArPSAtV2FsbA0KPiArQ0ZMQUdTICs9IC1XYWxsICQo
S0hEUl9JTkNMVURFUykNCj4gDQo+IFRFU1RfR0VOX1BST0dTID0gcHJvY19maWx0ZXINCj4gDQo+
IC0tIA0KPiAyLjM5LjINCj4gDQoNCg==
