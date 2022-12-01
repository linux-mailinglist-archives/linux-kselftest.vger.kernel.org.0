Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A3B63EAEF
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 09:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiLAIUV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 03:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiLAIUT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 03:20:19 -0500
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC44B2EF65;
        Thu,  1 Dec 2022 00:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1669882818; x=1701418818;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7fBx6T5qfwr2EpKS1g5TxHYyT74e3l9HoFJpO587zHc=;
  b=biCAvGz9abnVj4FwHBGE0ju7DXWzunz+WGKL9FtsmUmKEG/m8RoMX+sR
   frPJ///HiqWIZ2B5GFmjt9d9Dwgo5Xtv0m8gF+QEf6dcHbpQOD6PGioR9
   QncCcjiNXPagYvjOhdwS324XKZXBCSLaFVXo6+CV4qVsm6VZ/qZX/2Hnf
   chk/xBzQgkmualu7Of/g1XX4lFkNkuw+GMeQbur8ZxkiPHuBZDraTUbOI
   rCp6Ppb67u+EwlemqWoC1ZK05gjhMtTQUyuzNA/ArU9uHLciBT36TaCtJ
   HfdqRF6JdNrKiVeHSaj9pHmmZXw8W2Sl2zhDdEfo7wBmDerL0fxJ9i4ao
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="79204054"
X-IronPort-AV: E=Sophos;i="5.96,207,1665414000"; 
   d="scan'208";a="79204054"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 17:20:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHM7arvSuwNKHbMBwuYXuh74MtKrn+ZMwWjslLg6kpBBJ4xatGzMPUDV4SPyTnorCNtGR7NnZM7YWojRblCENleFznMJPiVsy9BP+jOzBtd6qZp4JcxgilKW6wLI1+DbzGrpV7xc7i5jP7BMFWw3vGp+ziosHORps1k7ftkRKYTOUQG/BKyMs/m1IsCRCUhRVUDwbqTjqjvRaInUc9k8E/ewYAxWFRN4mzooK8czqqMxcnEEY+lyu8rtTZg0qtTkDKfLs90WF5N7Ps5DBIXgBe2o5eG8zCOlCVnchWnduNHzNXkCAKjKPADa9qlnBca6SDWnVTHwzwW+VofUtJ3P1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fBx6T5qfwr2EpKS1g5TxHYyT74e3l9HoFJpO587zHc=;
 b=J0NL62gfrChu/tdTirMU6tJlU+weV2mfZ4X5NKUL6p9MYcTzEFaNtuK1Y6gbBRXD/EkPYwfkOb5eY38ubjEousSIOtoChaw9HOuMFPck4hFd4K4A2DF24DSKOTEOgGiRMxZjnhUhTNmujEAVVfZ9ovQIf7ay+hZ0hMdQJNj+b3F9u/CkT7FED1vjrD3Iac7eD3P/VaHulit/maGJXBoBAInJUcj4/35pqXivuMgIPD1pt/CQj/lFpFmPLjyAmzM057dcfDrk7m6ypmvBVKuYp4SEvTcpXmXDfJqk1UEZChosCQNR/NelW6IzMV03ac1r5G6SfQER3ikm/Is1RgeFnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYCPR01MB8088.jpnprd01.prod.outlook.com (2603:1096:400:101::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 08:20:08 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::2d81:9d85:cd8d:e41a]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::2d81:9d85:cd8d:e41a%8]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 08:20:08 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: RE: [PATCH v4 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Thread-Topic: [PATCH v4 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Thread-Index: AQHY+iGKVtajSkrGmEuJ9jg67HQSRq5M00IAgADx+yCABt9YgIACkaeQgACIj4CAAQYgIA==
Date:   Thu, 1 Dec 2022 08:20:08 +0000
Message-ID: <TYAPR01MB6330FFB9E5BA7CCDC652EE3F8B149@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20221117010541.1014481-1-tan.shaopeng@jp.fujitsu.com>
 <20221117010541.1014481-5-tan.shaopeng@jp.fujitsu.com>
 <af1b4e59-2b4b-ddbb-2218-0e2808b718a3@intel.com>
 <TYAPR01MB6330CDB2C59C58EE77B912538B0F9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <ba5a9ef2-b4ca-5c90-cc03-2296586455a6@intel.com>
 <TYAPR01MB63300F91A0755310E78D98308B159@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <ce549bc3-7e54-b1d3-7ec5-4cde66bd468f@intel.com>
In-Reply-To: <ce549bc3-7e54-b1d3-7ec5-4cde66bd468f@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMTItMDFUMDg6MTI6?=
 =?utf-8?B?MDJaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD1kNWRmZjQ0Zi0zM2JkLTQwYzgt?=
 =?utf-8?B?ODg3MC1lMGY2ZmE0ZTFlN2Y7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 014a56b0ffea474a9b39992d44d23d45
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYCPR01MB8088:EE_
x-ms-office365-filtering-correlation-id: 00076d1c-de14-4d18-28f4-08dad374dbce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MXyc/BUV2PLCNSO/u75S2R742QqWgsf3IEezCGfWpEsXUeW9BN8OHA3zTc3jZjx7zukkaMo2RHZcvIdl3eq9SGP8cirFHc/GQ1TqRS3jRVhIwvkCojVbRspv8DMRRNraXiCjBMb0of8/whKknJkK0C9pWpyt8nR4arrD65LTPke8+kwcx+3TSRvc3FP3qXvKxbx8M95MNZ0OkeBcSqwKHy/6zVUjYbQUnXvL0kGPRHYrov7vy6nAjKlCsLFSV/2TDeGQKfYExc4YswNwsaoOV5quu6IB+0203Hg8sJFj9b+HR9P8cKuZndyK3CN18w4Cd4QAwyeHGiz9x5/EvIucsQ1q7uNowiK55r7POYOsUlUmS167Ql+gVtkoWNC82GLqhxhCX364Fdf091uolk6q49CnhnebyNDdQNMxMo3wMsMunoB5qMvpvWobqFxyClgnv63WDchi8UAVR+s8lgK5LhfX2tKI+kInhdNx0I27eQjaeNy0wKf3QZqdAGERauMcXbBabphu9ke2T6HGgg+2fpqMeY2QEAguuZoPg5z5IutcSCoRTMGnAFnG8ViVIfCV9U3rtI/glzylZGR5B3gHqoAy6Vh/CN2CVaWqz64Hik+bq9Zlb+5aNNCWpez+94tNkdqhPdpZK+7zswy4bmAsxUhHSKP9baNfHGAdwlh2UazMJeKzcROqW6S8IJbum41oOA/rEYVzOH1JNOP5df9gyRQfcIj+VXaSY1ulKoDoDOE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199015)(1590799012)(478600001)(83380400001)(1580799009)(53546011)(2906002)(82960400001)(66446008)(110136005)(71200400001)(54906003)(85182001)(38100700002)(5660300002)(38070700005)(122000001)(26005)(41300700001)(8936002)(7696005)(66556008)(6506007)(66476007)(4326008)(86362001)(64756008)(8676002)(9686003)(52536014)(66946007)(55016003)(186003)(316002)(33656002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vnd1V21XQUNLdzk4Q3I4V3l5emNLNWI4V2IreHBwWWgvemNnamI5RTlWSmha?=
 =?utf-8?B?V29RU0dtRUFQR0kxOXhNRDhkVXRqRjdYODJjTlhmQXQxRTVXaEowYTZwaEdT?=
 =?utf-8?B?Y2ttT29oRTRTMU1XTktGYzRLeThUOXA5Q2RmZ1Q4UUsrcFgxVVRsMjk5RHZz?=
 =?utf-8?B?eDg1QURzQkg5WExGRXRmbWc1RDFmSDlwTEVxaHNSb1hkVEZHVkltb29WQm5G?=
 =?utf-8?B?YmdIbFdJbmtKWlZ2bzdWYkI2djc4Yi9vZmNDQTdFdWJHRTg0UTNZNlNlSjVK?=
 =?utf-8?B?SzhNdlF6dEFSUk5kQUo4NWI5VUdzTExQT2dMS0YwWkRKdTN6Ujljc3MzMDd2?=
 =?utf-8?B?bzNLUTd2ZmVJOGNrVmhJcHJrZ2xwcVNpNG5uWGY4UlY4TUNMN0VxQ2RWbE8v?=
 =?utf-8?B?OXNaS2dyR3NyT3lIaUFGY0ZEMVVqTXF2WnhFdDZQUTZRaVpmaURLSmgrdGp5?=
 =?utf-8?B?bFVoMEg3UFJuNlVNdzRvSERKcXZORTlEaE5CMEJndStub2RTUGZxTVJZSzJO?=
 =?utf-8?B?UHBjajladTNJd1krSkhOR28xbGFnbmx3eWQ2emQzSVR0cUhUVFJncjNYQzRS?=
 =?utf-8?B?NDBtS3RVakxscUE4NElCczVKMFRjRHRXaGlXZmcvSTdCQkZiV1QrZWFBWGxW?=
 =?utf-8?B?VGE1am5Pb1NxSjJNL2QvZGlEK2VEY0VDOVVITjlEeWd6c0sydmdjYXpSbWh3?=
 =?utf-8?B?dW5pdzhjWHFmeC9HZ0VISTAvdEVjS2NsUzV2Y3p3cWZzZDI4akQwQzZIYkpP?=
 =?utf-8?B?eEhSWTZXMFNka29ZNEt4dXFUYnNtRmpPVTRpcmo0ZXFtd2E5SHdyZ25pOFMw?=
 =?utf-8?B?VFBld1IyZ1VEcUlnRzhqM2grRzVGVVdDZlBHNmlHM0J5MTMvUDh2ZDQwR1Ny?=
 =?utf-8?B?dW5lcEYxcHBDTXp4TDFuYkhhUXdJKzVBQ0x4THc3U0MvNVQxL2lzamFZSUU1?=
 =?utf-8?B?RzNLa3g4MWJId1o5WFA1cCt2Sm5pbm1kMldZbjcvV2ZYZWhoaUhpUHYxMHlZ?=
 =?utf-8?B?c1NJajZEb3JsZlZOVnIzRy9uT1VyVS9PNkprckdBTDIyYmJUZDdwQlNQTjNv?=
 =?utf-8?B?b2pBQUxOV1EyL1B4cjY2U2tsMExiZW14K3JFeTZXWGE0eUh5ci92d0l3OVNG?=
 =?utf-8?B?b3ZoSWtwWXhUWmVETlJnZnM0U2ZQNE5CbkJMdU9yVHc1YUdNRXFrTU1EdnZG?=
 =?utf-8?B?cm9ZZkxqdzZHWi9SNE1STjBBa1FuNVZjWDArZHhzbXduTkNRS2FXOWd2TFdG?=
 =?utf-8?B?cmROOWdXa1pYalN3Y2pjM0tRQmV4WXY3eWx5NlVVWDFwejMyU09ibUUzNWpO?=
 =?utf-8?B?VEZ0OHRSSU5Ba1VzdGEwN29Hd0RQSmYwRDZaNXNsMGhocnh2L1AybURiM0N0?=
 =?utf-8?B?K2RVeExOOUVtUzM1Q0pFTXZhM293SnNQbTJlUkhFRlRtWHhJYSt4SnBjWDU2?=
 =?utf-8?B?UmZQT09kNTZGSWc3d0M4eU9PV29BaDJRcXd3d21pQzFIQmpNSkMwS1F5M0FS?=
 =?utf-8?B?TFVIRG1aY29yQ0gxaWkxenB6R29hT1Nza1JmR2RYU2hWQ08zVThXdnNiVTkw?=
 =?utf-8?B?TzRUK0I0SldpaGk1NUg4S3ZXdG41cEl1MzJuaFZEcTlWbHpVb0wxK3NrdWJG?=
 =?utf-8?B?c2l0NzREY1pqdkxCcHBMTmV1WnAxR2Z0d1ViTlNIVm9TRStrUVUyeitYU1BR?=
 =?utf-8?B?ZGV5M2JUNm1iRFI0UXJHQmpydWFmYzNTSWdOSC9BVjNZYndnTzFDdjJlc1FI?=
 =?utf-8?B?RlBWa2UxeVZVWWZnRlhLL0xVU3ZhZ081Lyt6UXdSSVdyYS9MVHRnTHMwV1pm?=
 =?utf-8?B?aVpIcWdHS1hPQzljVWpXT2FhYTBpNDV6dXFZcHg2K3dxWHg2d2I2YUU2Wmpx?=
 =?utf-8?B?RjhoM2dvSFJmK25wZVNXbXNXYzlNV0ovMVFBQUZjOXN5NXVYRnJ4UDhIajB0?=
 =?utf-8?B?eE1WejkvOUY3RVJMTVRFbURDWHZSQ0Z4NTlOVElzNEJvMERxeVZ5WmtwRFRn?=
 =?utf-8?B?MWRRcGV5SHBON09WZ2JiY3A1b2o1K1RWVjB2TXRHcy9QckRObFhZL0lqNWhU?=
 =?utf-8?B?ZnlwczBDT3VpN2dWeElnL2dKdzZNU0xWbndVbWJDaG9leVo3bGdrTEFDRE94?=
 =?utf-8?B?VFJFNlhzRkR3ZVlxQUVsYVd4VUlydTA0ejZwUm9WYlR3Vmg2Kzd6RWtlZTZw?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MEJUVnhvQ2N1WWhuVmN5ZjN6bFZjaGY4a3RLanppbHpvcWV0dTJONkhjUzhG?=
 =?utf-8?B?eW1pRVpOU3grdG9Zb1N4bzB1Z2tMQmRmdHZmaTI0Z1kxZEZlTlRLWFdadEI0?=
 =?utf-8?B?QnljTnRtSEh3QUdUUXVIN0dhc0pYeFhMb2MvWGdvV0RNekw5K0kxOXNaMWQx?=
 =?utf-8?B?QXdwaVRkM243T2NHeHdyY2hycFVHMzRITmxzbVBUNDFDY0YwUnRSam5YYkZB?=
 =?utf-8?B?UHc3OXRwdHRMaWdPekJwYUIzT2VBZWwzTU91Z256UkxsUlpoUFNBazh3U0o4?=
 =?utf-8?B?N2dRTFZrdHR2eG92UmVFbmorcmJHRlc4NnZDZHo3NkZ4ZGFsTEVEejZBWkxK?=
 =?utf-8?B?cUNyb3M4Ung1MnV3bEljK3NteDArZ0hJMHRqbFBZb1lmTUUybStVTnNNcEsr?=
 =?utf-8?B?ZkQyRGdoZ2JnOGxpV1Q4S3daT2h0MStQaXlGQ1ZjenZDTzlNVU5FRFgxOG1h?=
 =?utf-8?B?dHdhUnN0L2NTZGN3c0ZnNkJwSXdjdWwrRGQ1U1BPN3o2MVQ3ZTk5c1JkSHJo?=
 =?utf-8?B?Vkh2OHdydEhMN01ETW9WbVZxdEdJSklTdE8rcW1WcEMzVm1tS1VlaTVYVm4z?=
 =?utf-8?B?SnppcXNGd1VxYTl5c3F6VllhNVllVFBVcUx0V1FIZFRxYTkvTWFKWDJnRStZ?=
 =?utf-8?B?N1BSSEwwaGVDMnQwSFdycTUwWFFWb2NpQ0lQdk9Qcy9zb3pDS2JSaHh5MnEv?=
 =?utf-8?B?M1JsUjB3U0ZVc2VUMGpUL3Q4ZzZJTW5hTVVwWUdQOHJJcS9XbnowbUNjMlN4?=
 =?utf-8?B?bzRGazVrcXhqZ1doV3pKaFptNDlaYnhjeE9TS3JDQzZYYm43cG1kZXJ5c3c3?=
 =?utf-8?B?c2piYWh5UDc0dGp1OVhYWFg3alpzNEF4N251alB1bXcrVGlFOU42TW1nNHBX?=
 =?utf-8?B?TitXR1dPai9jdlZvWm5jTWRDV29uWndsTnQ5cmJRUlpRc1Y0WnVUU2h2N0lH?=
 =?utf-8?B?VjVPYUNGeWlqNmJGOThQUitKM0FRTXFQZGRSOEdQS0xyYXBodUsyRlJpUGxF?=
 =?utf-8?B?cWtkdlpkYSt3RFgxRmRlUWVyVXhmMHJGWWRvOTUwbkp0TjA2TjVkMjlVMmRM?=
 =?utf-8?B?ZGNITlgxU0lmbjkwaEZuSVEyNEZ5eEpIb3oyM1RKTEtxTmpHVStEdXp1RmdH?=
 =?utf-8?B?VUZQbG5ZcDlHbk9jNG5IZ3RxallRaEYvWE9Ra3RtMzZYcm5IZzhKaWZoV2xE?=
 =?utf-8?B?TUhZNXFHaVEvWkthUjJpQ3YrSDV1RExnWGZ2c0pzUUd4V3JQTzNhKzZQc0Fx?=
 =?utf-8?Q?iYyrbJgvpZJyghc?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00076d1c-de14-4d18-28f4-08dad374dbce
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2022 08:20:08.3422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xtAwj5yLkg1Wv7FmY94uyt9s8XvoPeA1sJvLBNahIpFjBIZwIqJAWgPYFz6pvx4cSpsceVlheZio5/YJLnsYis4F8fgGjCXocEF0Gv4sjPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8088
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgUmVpbmV0dGUsDQoNCj4gT24gMTEvMzAvMjAyMiAxMjozMiBBTSwgU2hhb3BlbmcgVGFuIChG
dWppdHN1KSB3cm90ZToNCj4gDQo+ID4gUmVtb3ZpbmcgY3RybF9oYW5kbGVyKCkgaXMgb25seSBw
YXJ0IG9mIHRoZSBmaXggaW4gdGhlIG5leHQgdmVyc2lvbih2NSkuDQo+ID4gQWxsIGZpeGVzIGFz
IGZvbGxvd3MuDQo+ID4NCj4gPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJs
L2NhdF90ZXN0LmMNCj4gPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL2Nh
dF90ZXN0LmMNCj4gPiBAQCAtOTgsMTIgKzk4LDE3IEBAIHZvaWQgY2F0X3Rlc3RfY2xlYW51cCh2
b2lkKQ0KPiA+ICAgICAgICAgcmVtb3ZlKFJFU1VMVF9GSUxFX05BTUUyKTsNCj4gPiAgfQ0KPiA+
DQo+ID4gK3N0YXRpYyB2b2lkIGN0cmxjX2hhbmRsZXJfY2hpbGQoaW50IHNpZ251bSwgc2lnaW5m
b190ICppbmZvLCB2b2lkDQo+ID4gKypwdHIpIHsNCj4gPiArICAgICAgIGV4aXQoRVhJVF9TVUND
RVNTKTsNCj4gPiArfQ0KPiA+ICsNCj4gDQo+IENvdWxkIHlvdSBwbGVhc2UgZWxhYm9yYXRlIHdo
eSB0aGlzIGlzIG5lY2Vzc2FyeT8NCg0KSWYgZW50ZXIgImN0cmwtYyIgd2hlbiBydW5uaW5nICJy
ZXNjdHJsX3Rlc3RzIC10IGNhdCIsDQpTSUdJTlQgd2lsbCBiZSBzZW50IHRvIGFsbCBwcm9jZXNz
ZXMgKHBhcmVudCZjaGlsZCkuDQoNCkF0IHRoaXMgdGltZSwgdGhlIGNoaWxkIHByb2Nlc3MgcmVj
ZWl2ZXMgYSBTSUdJTlQgc2lnbmFsLCBidXQgZG9lcyBub3QgdGFrZSBhbnkgYWN0aW9uLg0KSW4g
dGhpcyBjYXNlIHRoZSBwYXJlbnQgcHJvY2VzcyBtYXkgbm90IGNhbGwgY3RybGNfaGFuZGxlcigp
IGFzIGV4cGVjdGVkLg0KVGhlcmVmb3JlLCBjdHJsY19oYW5kbGVyX2NoaWxkKCkgaXMgbmVjZXNz
YXJ5Lg0KDQpJdCBtYXkgYmUgYmV0dGVyIHRvIGlnbm9yZSB0aGUgc2lnbmFsLCB0aGVuIGNvZGUg
Y2FuIGJlIHNpbXBsZSBhcyBmb2xsb3dzLg0KLS0tLQ0KICAgICAgICBpZiAoYm1fcGlkID09IDAp
IHsNCiAgICAgICAgICAgICAgICBwYXJhbS5tYXNrID0gbF9tYXNrXzE7DQogICAgICAgICAgICAg
ICAgc3RyY3B5KHBhcmFtLmN0cmxncnAsICJjMSIpOw0KICAgICAgICAgICAgICAgIHN0cmNweShw
YXJhbS5tb25ncnAsICJtMSIpOw0KICAgICAgICAgICAgICAgIHBhcmFtLnNwYW4gPSBjYWNoZV9z
aXplICogbiAvIGNvdW50X29mX2JpdHM7DQogICAgICAgICAgICAgICAgc3RyY3B5KHBhcmFtLmZp
bGVuYW1lLCBSRVNVTFRfRklMRV9OQU1FMSk7DQogICAgICAgICAgICAgICAgcGFyYW0ubnVtX29m
X3J1bnMgPSAwOw0KICAgICAgICAgICAgICAgIHBhcmFtLmNwdV9ubyA9IHNpYmxpbmdfY3B1X25v
Ow0KICAgICAgICAgICAgICAgIC8qIElnbm9yZSB0aGUgc2lnbmFsLGFuZCB3YWl0IHRvIGJlIGNs
ZWFuZWQgdXAgYnkgdGhlIHBhcmVudCBwcm9jZXNzICovDQogICAgICAgICAgICAgICAgc2lnZmls
bHNldCgmc2lnYWN0LnNhX21hc2spOw0KICAgICAgICAgICAgICAgIHNpZ2FjdC5zYV9oYW5kbGVy
ID0gU0lHX0lHTjsNCiAgICAgICAgICAgICAgICAvL3NpZ2FjdC5zYV9zaWdhY3Rpb24gPSBjdHJs
Y19oYW5kbGVyX2NoaWxkOyAgLy9kZWxldGUNCiAgICAgICAgICAgICAgICBpZiAoc2lnYWN0aW9u
KFNJR0lOVCwgJnNpZ2FjdCwgTlVMTCkgfHwNCiAgICAgICAgICAgICAgICAgICAgc2lnYWN0aW9u
KFNJR1RFUk0sICZzaWdhY3QsIE5VTEwpIHx8DQogICAgICAgICAgICAgICAgICAgIHNpZ2FjdGlv
bihTSUdIVVAsICZzaWdhY3QsIE5VTEwpKQ0KICAgICAgICAgICAgICAgICAgICAgICAgcGVycm9y
KCIjIHNpZ2FjdGlvbiIpOw0KICAgICAgICB9IGVsc2Ugew0KLS0tLQ0KDQpCZXN0IHJlZ2FyZHMs
DQpTaGFvcGVuZyBUYW4NCg==
