Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AEE5A9C4B
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 17:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbiIAP4N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 11:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbiIAP4M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 11:56:12 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2069.outbound.protection.outlook.com [40.92.52.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C707696F;
        Thu,  1 Sep 2022 08:56:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVkDrXTx8hD3zZWLuTQgO6h0Vxr++tbO+CQ5QgUwI44IOg6nVfSsqJciY0kOtGGahNrLxMcPmI3LRuY7+HS+rTtl0smGMwgUVViI7EdCUSl6+cdVK4rbKfoDX26k+sqdWQEC3+mkDZa1FzzeUmcQ8mNZjOadfxRRRsoDXNeenY+C0vSnXq3xTxn3mrHK8NQQTaOY0Prlw9CvN9HA0M1vWHW1KdataN80i5P8pjsUYlfQRgZFWYqk1dptBgUeBTjpT/AilmidH9mIXc60MVJSQUOPeG2WoZlBwKfCrg9gu58Jy9CwkhpebK1HhzM9NywrrEePY1d66EQmCvhpVmKXjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYtNqLB5ypkMPFG6FYxLkpC371tHUPuserYLllbC7Nc=;
 b=hWJXKH6U8nqO9PXag3p9Ap5lDcOtJibmfK81V7+QQcsTJtsJj6L305WPtFG7qEMkzErAz16zCQplEl7Mq80zo2PYnPYC2iOsbCbrrTSTdRFFGoMsDbtuo0T5X3gvNweFlZx7e/G/a/RVK5KeYCZla+21/eBkaBCScWcC2iid6gGZsoWN2wABuuj2QzwDDMxqnbBJ/FIsIi/GR3A3Uj/0m7jgi/RLozOQIuXDHakyjR9fQHTFQFSXIEVVvm29kBiTcRQmTZgUIjiOasQNSRCOWrBM7on6eq8Hgh7pLwerLfadhsLWjTUemNCzI3i7Q2w8r7P7I4qzGB+n54+Z249pAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYtNqLB5ypkMPFG6FYxLkpC371tHUPuserYLllbC7Nc=;
 b=RUST0A498Y55LDx82bIgNKIJior/qUNdErpXI1FcsKdT4Kr0bw6xQQi0ITGZqo133yzY0i0/mfps5GkCK/keSL8zdLcmINhqA0NOUGW5TKz1hxiNzZzXq3dG2Ibtj6+xwpVxt2RYW57MA71QN4QCJ0jTpgeSxcm7+USrf3RyNFV/Qtxw1qmz4hnhKi9xhNbEmM0H3yDqzQgLpjAH+ZqVPd7QMpTZMw+eMZrvVVY8wAL9R37KZSply2d3DmNZCor+xfeO6nIJKP5hQG1CM/ZNwe8g/aWucoOcPDTyGRknK7wHIDfL2sv4J9x46mbDUfMSxzMMb0RLE13DYCoLL7Wgzw==
Received: from PSAPR04MB4167.apcprd04.prod.outlook.com (2603:1096:301:2a::9)
 by HKAPR04MB4020.apcprd04.prod.outlook.com (2603:1096:203:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 15:56:05 +0000
Received: from PSAPR04MB4167.apcprd04.prod.outlook.com
 ([fe80::9a5:16f2:9f1e:9bf2]) by PSAPR04MB4167.apcprd04.prod.outlook.com
 ([fe80::9a5:16f2:9f1e:9bf2%8]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 15:56:04 +0000
From:   zhubojun <bojun.zhu@outlook.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V5 15/31] x86/sgx: Support restricting of enclave page
 permissions
Message-ID: <PSAPR04MB416734EEED145D832A04B936E97B9@PSAPR04MB4167.apcprd04.prod.outlook.com>
Date:   Thu, 1 Sep 2022 23:55:54 +0800
Cc:     bp@alien8.de, cathy.zhang@intel.com, cedric.xing@intel.com,
        dave.hansen@linux.intel.com, haitao.huang@intel.com, hpa@zytor.com,
        jarkko@kernel.org, kai.huang@intel.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-sgx@vger.kernel.org, luto@kernel.org,
        mark.shanahan@intel.com, mingo@redhat.com, seanjc@google.com,
        shuah@kernel.org, tglx@linutronix.de, vijay.dhanraj@intel.com,
        x86@kernel.org
To:     reinette.chatre@intel.com
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-TMN:  [ikOeEeSyE0b+R0x6bwm/dMgWsEvYxiN6]
X-ClientProxiedBy: SG2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:4:188::18) To PSAPR04MB4167.apcprd04.prod.outlook.com
 (2603:1096:301:2a::9)
X-Microsoft-Original-Message-ID: <2120EFC6-48FF-4AC1-8D72-20A5AD1FD210@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4235a04-6e01-4247-a5ed-08da8c3279e5
X-MS-TrafficTypeDiagnostic: HKAPR04MB4020:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xJqLne5K7AWuwHOzISSWTlJIPIgR3SHICE2pljzg4N1MtvaJj7e8I4a+dm3GsCT1p5uTsViLHoG1ZW8DTIjxep3wBofXvAFrTgeV+h0UZJNoPYH+lCJdCSLVlmFqum1u0G9eMsAczwRJVcM8CmTbYG9FhLXpjNIW1vp1X29EnvhY8lsgUBnWJQ9pqfqnG2MT0si04FTiJargKEZcJmETM4xeKnfV9Le8ImcbjtA4ra4apYuRaVpfAXhYkVJjSsmT2Rk5fzsE8ka4jX/SuYGQiKohiEyfQTQud3fhUQpTeIjlw1VFsNWJGOSurG2RieeJNuLyMs/ZZkOoY4+sDppHcB5xPjuh8kRbeAe0zLSWQ8fD3kUIyTkfSBxoiGk4gbsT3Sb6ImPDM9Uj/DjNMbJzp2sZqylVazbH6kfk6qF1Pv9cQKvH4vmradXGXsCGSwZbTWZg+gzgKg6qvnkkyPHoNkX91z0e4YIAZseCJhOqHivzE/Ffz84Jj0qOHQyD8BFp4sIzNZSRC6IsGNylxVkQgrVbl7WJwoMYnwblimZ3SrXnA/M9y09ZhfErG8kBaeLOdKQvAGc4po5ZjrI0N84SnJhQojghObthblBcoVkHCztFUBAvHcAge6jlj8G9RkURs7IEoRUqwNXI1eGoFw26H1tl0m9r3dMG8pICQ6rPL/evB4x6JMC9V2ji4GBZXwr/
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akdOUjlvaHBvK3JXQm02UW1qc2hLajFQcmNLeEY1aFB1aHh4S3dqT2VwL2l6?=
 =?utf-8?B?NHFWYUo5Rm10T2luOHdTci9RUmVZREhRWDBEcVBMb1FPQnhEQ1FScG9IcWJv?=
 =?utf-8?B?WjJlcEExMTU5eFdQMThNQXorOURyMFBsOHAycjVtUlgxczQxdjlRby92YW4v?=
 =?utf-8?B?YVFJV3c3VTVkV3Z1TGxYcXgxWW1XWTJJbUNSNDE2UFVpT2lTeHJQci8xbDJk?=
 =?utf-8?B?RHFkOU93RUk4NU8za1d1QXpVSExZQkhwbUo5bWxPc0tHcWtrZ2dYT0xaMTk1?=
 =?utf-8?B?bFRaOUQrL1BianlmWjZsaWxHclhRaHFpQzlXWHlxbzBLSk03a1d4ZHI3RDdk?=
 =?utf-8?B?YmIzK29vMmMwQzBYTkZ6aXBjMHVnSk9jajRaY0NNUU1rbEZoMkpuQTZsUWtF?=
 =?utf-8?B?aGlhWWdEQXJmMDgzOUJ1QTBWOGJLYXNML2JFMXBsdnhqd1BCTkI1cnkyT3ln?=
 =?utf-8?B?dUhvQVRpcm1HMmVobDZtaVNFOEczS3hZMXpmU2tNeTFKZVYwZDVOUnpndEdC?=
 =?utf-8?B?Mk1mYnpKZkNTeEEybEdBWXNDTGhFRGpTL29UNXJsRm5ORit3SnBjQ3BVeHZn?=
 =?utf-8?B?a3BSWmdsbmRhbWErN0FTNmNndmQ1OGxFaytPOVhwK0grdUxuWkh4T2kwa3NY?=
 =?utf-8?B?M2VMb0d5UzRQRlNuYXZxRGoyMElsZlE1NmZWQ2FLS2cwdFZYc3lsZ0xzWU5t?=
 =?utf-8?B?cFdteXhHQmFNK3pjT3F5ZFBObnk4Tm4zY0lWbXNUZkJjbDJwMmliSDhNNDRV?=
 =?utf-8?B?cFBrV0NJbit3TTlGb1c4SThFN243c2gvZXBFQlVpWG0wRWczeFd6NWc4TWh4?=
 =?utf-8?B?THo1R0JBVC9FUlEzbEJhcXl2VlIyODVjc1ZJUmx0YTdCRzg0M2pqMndnVHZQ?=
 =?utf-8?B?TGtLVzZ2cnVyRHp2QzFzQzlxa3VsMHk4SjJhU2V0UzgyaGU0N0VjRnpEYWU5?=
 =?utf-8?B?UmxDYnQxbThySCtKanR0NGhPS0xoRnVDMXBxY3I1SjFaczlrUzJuWkVhOGNK?=
 =?utf-8?B?S0w4NFo5b2szdHNwN1VYb1doTkxyaUtSb3dYZmRncHp2Sm0ybXRiOS9BTi9W?=
 =?utf-8?B?eW1oc3AxZGxzMEZlMkEyM1dHajdMWERXaUFSRW5jdUlzeWxEYTVBU1FXbGwx?=
 =?utf-8?B?ZnlNamQzWnM4bm8rWVhWVjZHWkdnY0lRNmpEYWtnSkRteThaWmNjclVBM1Rk?=
 =?utf-8?B?WjU4TWFCa1VQbk85SXJPdVVTZS9zRVFNbUMwdHk1cGlqT01rSjhyUElrQTZm?=
 =?utf-8?B?QldyUHltaXdtVUw4ZVRNVHQvUjNhTDdxOHFxZE9SSEkveFA4aUQ1aXRPaml3?=
 =?utf-8?B?dHhEa3czNkdtNm5BUDBzQnlKTzMydWZqejJKbDhDRzRsWmwwdXNmcGtJb3hD?=
 =?utf-8?B?S01IWGVQTjJ2K1dSck01cEhNRmtLd09kRnVZZ3NSUTJWRHg4clRoelJJSmdv?=
 =?utf-8?B?bktKemduTHZTYjZCb0JyRlVUZG9JSldOaUlkbmRiV2lyclg4VlJuM1JZT3dO?=
 =?utf-8?B?SlIwN1FmNUZkU0dLbXJ2Y1AwR20yQzZHSVNVMU5KRTVWUFFXZ05xM0s0dTJi?=
 =?utf-8?B?VW9sdHBnV0JXc2JFTS9tREFEK3lMditBeUJXUTkzRzlBblJzTHBvQ1c5Z0Jv?=
 =?utf-8?B?MlJZZHUxdUwzNjhrZXFiY05OZU1ja3pzeUVvVnRJaHArMmRISzh6dmhpWFBm?=
 =?utf-8?B?Qk8vNWVtc2F6aDVMMXFwMnltQ0ZqZWliVDNHenlKbGNDU2YzT2hVNjhRPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4235a04-6e01-4247-a5ed-08da8c3279e5
X-MS-Exchange-CrossTenant-AuthSource: PSAPR04MB4167.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 15:56:04.9255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HKAPR04MB4020
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Reinette, thanks for your great contribution for EDMM Linux kernel patc=
h. I am trying to follow the newest patch now, and I have some questions on=
 it.

It seems that `sgx_enclave_restrict_permissions()` is able to do permission=
 restrictions for multiple enclave=E2=80=99s pages. After driver invokes EN=
CLS[EMODPR] to restrict the page=E2=80=99s permission, it should then invok=
e ENCLS[ETRACK] and send IPIs to ensure stale TLB entries have been flushed=
. Only in this way, ENCLU[EACCEPT] inside enclave can only succeed.

Current implementation invokes `sgx_enclave_etrack(encl)` after every `__em=
odpr(=E2=80=A6)` in the for loop. My question is:

Can we move the `sgx_enclave_etrack(encl)` out of the for loop? After doing=
 so, `sgx_enclave_etrack(encl)` is invoked **one** time for multiple enclav=
e pages=E2=80=99 permission restriction, instead of N times (N =3D `modp ->=
 length / PAGE_SIZE`). We may gain some performance optimization from it.

Please correct my if my understanding is incorrect. Looking forward to your=
 reply and Thanks for your time!

BR,
Bojun=
