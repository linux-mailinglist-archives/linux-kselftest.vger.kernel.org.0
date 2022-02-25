Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6964C3FB6
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 09:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238334AbiBYIDp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 03:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiBYIDp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 03:03:45 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Feb 2022 00:03:10 PST
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB0919BE57;
        Fri, 25 Feb 2022 00:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1645776192; x=1677312192;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JRVVzqghekEzeKAzsqnIzcJNwvoZL+oewOTih0DqfP0=;
  b=CTi4IPzQKcXXvxoXNKvE7NOpjAcidzZXIf/jKZio35xWdq7Y05V0tA+z
   V8WxUfLwHH2+6o0BP4aEoph5/XgB5zZuzLDtH9me3+PO8mCAL6h4ztmBp
   lVdJazVV7fnimRtGWhj0zcXLLNNzaeue/SyHrttDsdX8CiXWounJRJNNO
   CAtpCCplAZ82fB3PVtWGd/rhNe3fAdsL4Kk/hlmbQDAGErGZfgTRDG600
   mm7c9SAz7BZ5u8buEnOkf4EJlwSHVOXXkL7Y5ipEbGetb1m71nOOizVeh
   Kl3yEZbzfF79Ffg66jJUSXNLCsHx0JBxLmx0DPszRmcDeucs0lAhQtCwn
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="50502121"
X-IronPort-AV: E=Sophos;i="5.90,135,1643641200"; 
   d="scan'208";a="50502121"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 17:02:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=An7qj+1ifJ8PzLbIzO6Lm9xckJyiwl5kmOOQ4Md+bulJkD6/MOwgJcHycjQit81Pw39PxdXaKcLpK0+/I2QVQxE0gu/uotZBdWEGXZ4Rb+Y2eS9eeT7R7gYd9q5LSdeZnuL/dO44B5f6pfDbY1mQyDNK6rryVymhYHHLL6aDiajnS75dubZ4PPI/npogJwKIoAaBSvI15bfkv1S9K063e8GqNXjFwtayiHEPxREX2Gm8SQeiOXBVvA2JLWYZhHq1zSmJmtOagilodMcbfFfRPFZY1ImNTmfbpRXAwdjERBHov8fqMO1HoUFZTfgrI+o6BiFzOkp7O154oLei/9XGWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Di0Lza1bK3XGz/lgscsYd0C7zd0TRVZjPmJKcBZ/cpE=;
 b=CjlEzAJ8uVVLvTaRumrVyXoVFeJo16hvkKXjl0O+BEv2MRoNsFNqo1Cx13uUHpNcKs4rgaOl6JANNl14st0QjHqCCMpLRGz/s+U+V/aTt/XbDCKZeeHrVHYNq5Pi67rw/Ug5XObxwb8oiQPKSa16UE+bscm1w0qubp16Jnp4hYDzzPPVLEVn8Vwr/2ejeIBddcYEO8t0ZGOPNKpuKtHwC6AEa8swQqO/exCVZGrUGzBQZVcG/CvKaPvryVhOvwy1CNls6Vu3Q1uxeLDFUu4jKm+LOuQ+W0AG2avV4hZWtcSLYZSOJflOxdY6qWHvh8++9+GSqj/cKlwVA7Hd5Cpyxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Di0Lza1bK3XGz/lgscsYd0C7zd0TRVZjPmJKcBZ/cpE=;
 b=jbZlbTJWtIZb0/UJ/AAe7180MpHX3WsSvjGOJ6GmvVuW2NjRw3r0YE/mefkaEoPnZcs7XEIh2QWUiUTb8ABni0KZCSO/ZMtJtL4pjuSvaHJxY+rIqrivnnTVkkKaPykMlsdCDAlihELTXqLM2OACMpy7zBjXwdPrUJRGc3eYsLo=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYCPR01MB6687.jpnprd01.prod.outlook.com (2603:1096:400:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Fri, 25 Feb
 2022 08:02:00 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::bddf:b81c:fc55:3bbb]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::bddf:b81c:fc55:3bbb%8]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 08:02:00 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Shuah Khan' <skhan@linuxfoundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v3 2/5] selftests/resctrl: Make resctrl_tests run using
 kselftest framework
Thread-Topic: [PATCH v3 2/5] selftests/resctrl: Make resctrl_tests run using
 kselftest framework
Thread-Index: AQHYItzk2ZSlsGQE1kGaxUOyn+5ZpayZxhMAgAV2X6CAAqR9gIACFABA
Date:   Fri, 25 Feb 2022 08:02:00 +0000
Message-ID: <TYAPR01MB6330E0C641FC7F0EEE0DCA688B3E9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20220216022641.2998318-1-tan.shaopeng@jp.fujitsu.com>
 <20220216022641.2998318-3-tan.shaopeng@jp.fujitsu.com>
 <1bbc4049-2c08-39be-d82b-9d98ee663e72@linuxfoundation.org>
 <TYAPR01MB63302321D2A50D9A690993AF8B3B9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <5200cb0b-6417-d97b-7f17-eae4bf4b0901@linuxfoundation.org>
In-Reply-To: <5200cb0b-6417-d97b-7f17-eae4bf4b0901@linuxfoundation.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-02-25T07:57:28Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=79b9f5fe-5cf9-4f0c-b78a-bf25dffd2f5f;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 937a0ffa-13d9-4375-0c75-08d9f83519f2
x-ms-traffictypediagnostic: TYCPR01MB6687:EE_
x-microsoft-antispam-prvs: <TYCPR01MB668711CD83FD4DE6DE9C14788B3E9@TYCPR01MB6687.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ei+sJ4UhwCzJrOPncbts/MHRLOn/ouRdilE/02IUhSGWaVVJXGGpg1ay68R2Np34P/jB5a/Mk5dO0Qlx7QL+A2hcFww3bk2M5nJzyT958/pbSPEspq0yarJ1HaFpxjlRyrp2qvyOQy+mCqY0G0fsLIN/C+WHZt7V8m0R04vOj0XNZ2Q5jFQNQmJEgq+3OsPR5zwhvC8q2Fx4XtdcaJV5ff+s6Wssl3bHsUV3k4tDMoOsZwHTRl9DnRlXe837ldRafwcdprX9KTL9GVG6qPFXr4Ordhjb6CzO+g5AzUqBwzCRI8eg1dJsbyMpue5pgZYQEajFHmNtLkqwoosvSJ0Bkljjws3+Rg1oCaQ5w7nXwVhHgLqxuhT84cH1ubNBk2PMJGkEVE/YU4LJK/TYSDdCfJ/wawZI3BZSt5pWIk6UbQlnB0mPG+SRzLuQXLMobSK+Id0BUNWf22lP4GrmgUGP2Q/+gmDj0eF0DZtabk8o3fu7xMu1TjifCBX6S78BrFn43qTzSA9NwYmlWqNmqsSWV9sedE3c/af84tzaZxn3Y9gBBKjsYIELxutHQPOHGKeixQxytn1a1ng0EIs3dDU23AjUgPCfUn4Al5OiaEYV07e1vKuImrN+xoDwjdbmhh5nn6UtswD+OXlRJpc8MuH2FvFt1TiheHeUfLdrwjaepggzwkv4kpQEz9CCi6IlAhbzcf8P5p7/vFE9eYQeju8fKY0OPuIL4UJkntHUpIQADAfbv9T59wYD710NZ+CcwjceT+VSinyeECyiMQUdZekMs5sqTXSAw2FcCNOLCdEWhBF+L4X+XxWbqBbj+N2cDmZlEfBiMLVf8KnvAZwmCSESg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(76116006)(83380400001)(85182001)(7696005)(6506007)(4326008)(66446008)(2906002)(82960400001)(64756008)(122000001)(55016003)(8676002)(66476007)(66556008)(9686003)(5660300002)(38100700002)(54906003)(316002)(508600001)(52536014)(26005)(8936002)(186003)(966005)(33656002)(53546011)(110136005)(86362001)(38070700005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?Y0ZqWlM4NWdmUVc5ZVFUaWZyZGtCd1FnZXJzWkhSV1dwS0g4OEJWUm9p?=
 =?iso-2022-jp?B?bjV0akFPbGROWnRBTVVNOXFZMGJFc3BSamtwOXk1aGdyVHloVEt0dzVY?=
 =?iso-2022-jp?B?dTNUbERZajhQeXN5YndBNmNLUkV3c0l3T0hSbC9vTTVIVUxLT3lhbWZk?=
 =?iso-2022-jp?B?Z2hNMHF3SFlFY2Y1R2RSYnM0SGx5dS9JdEh1eUlCYUZlOENWbXFtdGx6?=
 =?iso-2022-jp?B?RWRnS1dmZkJZQm0rWkhId0pabkhuWjFqeTJNSW1zaFB5WER1OXg3QjNm?=
 =?iso-2022-jp?B?WCsvSTVUNXpRSUlDdlVBc254b0RIWkliSi9wNXM2QzNWTlFWVjhaeStO?=
 =?iso-2022-jp?B?OWlLejVKL0lSSXNjTFErcmdWUGMycEJablRYMUxla2FQYXhvank1dDNN?=
 =?iso-2022-jp?B?Zkd3UTJLYnBFd0NsbUFHWDAzY282SWZzL0FLRk1HYTBVd1ZNZXFMZTI2?=
 =?iso-2022-jp?B?amZnMHdMYzQ0TUFNMXh0Uk81L1RINmVZV05VSGVTWWFKTlRPdUMwVWRJ?=
 =?iso-2022-jp?B?eVFMM3dtNTNVZ0hEMkVkelA5MWR5TEQvRXMyL0cxTnhwR2daRXJ5cWtQ?=
 =?iso-2022-jp?B?V3A3ekhaZXQ3WWNVQWd2ZXVzTnRzMkFJcVIrcXVIZk1rUjhMamcwdThP?=
 =?iso-2022-jp?B?bFJpNFlsWDR5VVYxakErOFBlVnlvSXZ1OE5WcS9RQ2JkVFBHWWRuUVIv?=
 =?iso-2022-jp?B?d2dSZ0s0VmpKQlh6MVBFbWI3Vmw4a0pvMHdnd0gzUCtRYkRaNTRPYktw?=
 =?iso-2022-jp?B?YzJvNmFRUHRjSDg1L0pEQ0Y5OWxBUGRvVkRKV0tXUXpzZjFUQURKa3No?=
 =?iso-2022-jp?B?eGIvK1JBdEdXcmZSL2c3b211N29qTFErbVB1ZWFjaVpXUlU1dmtOdWYy?=
 =?iso-2022-jp?B?VittZXBKSTJ2RnMzSnRCcER5c3g1T2syVUJub29TcnFzTy9MUUNoQyta?=
 =?iso-2022-jp?B?TzVMWGRpdWxhcTRDOWdjRkxYZlZRRHNHc3QxbFlZSXJaaFFaM3hPdjVM?=
 =?iso-2022-jp?B?cUxQRmRQOUxHc1lCZk15bW5OMnR5c09mL0xteW5qL1RrQ1ZqQ2MzVzFR?=
 =?iso-2022-jp?B?aUg3aEc2alJXVk50VjFpaC85OTZYcXVYajlEcXdpdU05dncxU1JDdnl2?=
 =?iso-2022-jp?B?YkNJV2taWEsyL1VxV0JxckhPT2I4Q2dzNGFqRHJ0Z29PdnVTT2xnQ2pR?=
 =?iso-2022-jp?B?WHZWeDU3Y2NZblVFR3RqK2RMMXJVUS9xZHJQODMzREFvMFhIK3hXN01E?=
 =?iso-2022-jp?B?ekFaMUpQM3J0VFp2T3dRdG4xTXFsSmpNaG1EalRkeko2VWUxOVVLWkln?=
 =?iso-2022-jp?B?eDQ0Vko2YnNQU0ZtU1ROY0hDV3JVMnJQZUkwMDNyY3VuSVptZXplMDE0?=
 =?iso-2022-jp?B?L1BtcEhKckJ3QTdxM2ZoNEx5dDgyak84N0o0djJ3OEx4SXpYclJJUWlp?=
 =?iso-2022-jp?B?NEVWOHRrMlBlOC9IMDZQODNIZ2xDOXE5ZTg4QVhXcWU3ejM4Nml2Y1dh?=
 =?iso-2022-jp?B?MDExektrTDZjSUFDOHVreEJiNWUvUHVWUDJMbHN1YXp0SlJZOHdrRi9O?=
 =?iso-2022-jp?B?cWl0ZjE5My9wRDZYNmJkMHpQWnNodWk1OFROVDZVakZiVXFpd0xGcUxi?=
 =?iso-2022-jp?B?VDhLZEVheVVMNVFySE5NemMwUEJ5UjlYVXlISmtpcVRZZnYvTjh1RzZW?=
 =?iso-2022-jp?B?dXovdHRaTThiNlRCaGQrSlVGbDRPdDRxZ1JuQVdqMGd3V1JOMERyam5U?=
 =?iso-2022-jp?B?UG5iNFBRVTFZcE4xZW8wZDJYWGlPTTFKMUlrTFN5UHh1Um9uZjNKVTJj?=
 =?iso-2022-jp?B?aVJGaDFkVDZjL3JKYm1GTVJFbjJES2FkZnR2VVBZd0lncHdiN25ZZzVJ?=
 =?iso-2022-jp?B?czFsRXJmQXB5bmR4MUVBQndVVXJEQjVDVHg2YW5IcjNxUkJJQytsTlZF?=
 =?iso-2022-jp?B?b2s5TEtlUzV1eGFrR29OYVJtcUY4WWg3TXIwclozUEFIUmtYQm9nMHpZ?=
 =?iso-2022-jp?B?T2JnRURiUEhWVkp1ZjN3cW1VajZUT1Q1TGNzUVJGeTArM0xpTEJJQVlT?=
 =?iso-2022-jp?B?eVlpWE5WcVhxblU3cmNOREk2dUxxeS84eEpZdk1IT1JaRm0xbWZhc1Zk?=
 =?iso-2022-jp?B?K211anlzMjhSSGlBMXVIM3ZSclhqVGhkb1ltVWF6bzcra2ptQUJGdDJN?=
 =?iso-2022-jp?B?c2hUZHByV3dMaXRyZlVIWjhSR1JHclExeVVJN1IvNXFEWUMzN0plT1Zu?=
 =?iso-2022-jp?B?Z1FwM2F4MGhFTkxLQnNxcVFaNW01S0NaNlhtOHNtQ3dUVVRReXIrODFu?=
 =?iso-2022-jp?B?QVVpM0dCOHV1dTJlNFVwNThDQ1N0S3ZBd3l2Vm5SbjR0NjkxSDJnckV6?=
 =?iso-2022-jp?B?WlYwNWhROExLVnI1NitpOUkwRkNlSis5bkVjU01ZQnErZUZESUc0am9Q?=
 =?iso-2022-jp?B?bGJ0RmlBPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 937a0ffa-13d9-4375-0c75-08d9f83519f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 08:02:00.1103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uIyFiW7k9MtkHsIXs1AO79WzpKzTSqETvsA60SmCPGrld/9CwcwYjDOisHeAw676jxNEEU4GGerms+5Zsmq8MKSBiRviVyzTsJ69q3qhhKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6687
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

> On 2/22/22 12:55 AM, tan.shaopeng@fujitsu.com wrote:
> > Hi Khan,
> >
> >> On 2/15/22 7:26 PM, Shaopeng Tan wrote:
> >>> In kselftest framework, all tests can be build/run at a time, and a
> >>> sub test also can be build/run individually. As follows:
> >>> $ make -C tools/testing/selftests run_tests $ make -C
> >>> tools/testing/selftests TARGETS=3Dptrace run_tests
> >>>
> >>> However, resctrl_tests cannot be run using kselftest framework,
> >>> users have to change directory to tools/testing/selftests/resctrl/,
> >>> run "make" to build executable file "resctrl_tests", and run "sudo
> >>> ./resctrl_tests" to execute the test.
> >>>
> >>> To build/run resctrl_tests using kselftest framework.
> >>> Modify tools/testing/selftests/Makefile and
> >>> tools/testing/selftests/resctrl/Makefile.
> >>>
> >>> Even after this change, users can still build/run resctrl_tests
> >>> without using framework as before.
> >>>
> >>> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> >>> ---
> >>> Some important feedbacks from v1&v2 are addressed as follows:
> >>>
> >>> - The changelog mentions that changes were made to the resctrl
> >>>     selftest Makefile but it does not describe what the change
> accomplish
> >>>     or why they are needed.
> >>>     =3D> By changing the Makefile, resctrl_tests can use kselftest
> >>>        framework like other sub tests. I described this in changelog.
> >>>
> >>> - The changelog did not describe how a user may use the kselftest
> >>>     framework to run the resctrl tests nor the requested information
> >>>     on how existing workflows are impacted.
> >>>     =3D> I described how to build/run resctrl_tests with kselftest
> framework,
> >>>        and described the existing workflows are not impacted that use=
rs
> can
> >>>        build/run resctrl_tests without using kselftest framework as
> before.
> >>>
> >>> - tools/testing/selftests/resctrl/README should be updated.
> >>>     =3D> I separate the update of README to a new patch.[patch v3 3/5=
]
> >>>
> >>> - Why is the meaning of "EXTRA_SOURCES" (i.e. what is "extra"?) and
> >>>     why is "SRCS" no longer sufficient?
> >>>     =3D> I referred to other Makefiles, and found "SRCS" is better
> >>>        than "EXTRA_SOURCES". So, I updated it to use "SRCS".
> >>>
> >>>    tools/testing/selftests/Makefile         |  1 +
> >>>    tools/testing/selftests/resctrl/Makefile | 20 ++++++--------------
> >>>    2 files changed, 7 insertions(+), 14 deletions(-)
> >>>
> >>> diff --git a/tools/testing/selftests/Makefile
> >>> b/tools/testing/selftests/Makefile
> >>> index c852eb40c4f7..7df397c6893c 100644
> >>> --- a/tools/testing/selftests/Makefile
> >>> +++ b/tools/testing/selftests/Makefile
> >>> @@ -51,6 +51,7 @@ TARGETS +=3D proc
> >>>    TARGETS +=3D pstore
> >>>    TARGETS +=3D ptrace
> >>>    TARGETS +=3D openat2
> >>> +TARGETS +=3D resctrl
> >>>    TARGETS +=3D rlimits
> >>>    TARGETS +=3D rseq
> >>>    TARGETS +=3D rtc
> >>> diff --git a/tools/testing/selftests/resctrl/Makefile
> >>> b/tools/testing/selftests/resctrl/Makefile
> >>> index 6bcee2ec91a9..de26638540ba 100644
> >>> --- a/tools/testing/selftests/resctrl/Makefile
> >>> +++ b/tools/testing/selftests/resctrl/Makefile
> >>> @@ -1,17 +1,9 @@
> >>> -CC =3D $(CROSS_COMPILE)gcc
> >>> -CFLAGS =3D -g -Wall -O2 -D_FORTIFY_SOURCE=3D2 -SRCS=3D$(wildcard *.c=
)
> >>> -OBJS=3D$(SRCS:.c=3D.o)
> >>> +CFLAGS +=3D -g -Wall -O2 -D_FORTIFY_SOURCE=3D2
> >>>
> >>> -all: resctrl_tests
> >>> +TEST_GEN_PROGS :=3D resctrl_tests
> >>> +SRCS :=3D $(wildcard *.c)
> >>>
> >>> -$(OBJS): $(SRCS)
> >>> -	$(CC) $(CFLAGS) -c $(SRCS)
> >>> +all: $(TEST_GEN_PROGS)
> >>>
> >>> -resctrl_tests: $(OBJS)
> >>> -	$(CC) $(CFLAGS) -o $@ $^
> >>> -
> >>> -.PHONY: clean
> >>> -
> >>> -clean:
> >>> -	$(RM) $(OBJS) resctrl_tests
> >>> +$(TEST_GEN_PROGS): $(SRCS)
> >>
> >> This patch breaks the test build - the below use-cases fail
> >>
> >> make kselftest-all TARGETS=3Dresctrl
> >> make -C  tools/testing/selftests/ TARGETS=3Dresctrl
> >>
> >> Also a simple make in tools/testing/selftests/resctr
> >
> > Thanks for your feedbacks.
> > I applied these patches to the source below and built resctrl_tests
> > successfully using above use-cases on x86/arm machine.
> > (1)
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >   Tag: v5.16
> > (2)
> >   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> >   Tag: next-20220217
> >
> > Could you tell me which kernel source you used to build and what error
> > message you got?
> >
>=20
> I tried this on Linux 5.17-rc4

I tried these patches on Linux 5.17-rc4 with gcc version 8.4.1=20
and resctrl_tests is still built successfully.

Could you tell me what error message you got when you built it?

Best regards,
Tan Shaopeng
