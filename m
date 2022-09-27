Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6AB5EBDF3
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Sep 2022 11:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiI0JB4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Sep 2022 05:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiI0JBz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Sep 2022 05:01:55 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFBA5071C;
        Tue, 27 Sep 2022 02:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1664269315; x=1695805315;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g0Xv1r95W3YrJKHeSS9qNvS4uq6E1HRvTCMsQ+Y7tXU=;
  b=vTPzX4azAholpl6KQyuE+U/nQewF7U5tnoo8sDITfxvBZsoI9OharEMB
   Ed0EcytTo9yoOhekeZGHpKcZLI7IfanTU335fqLedUGqCY5eRV9k07mDH
   villMdvxIh3ufVVwDUd1ngalWK+vjgcjmfeBb00mGonqMiITKduZ0VmuM
   fAjFvKqwzI0Iz/41lPidlKiC0cbwwU9zOq5c0BgBWpBSdBo2kbnswviMl
   OxJKs3ChKsU0JMMw2huQg7lcanwNlYZ0D+r99cvk0crvOzMgJ3VKpYxcS
   qZa+cLO6MliSzdZQSPQDovGNnicSgqrP2JRUYSbK3cmhLzCq2l3r+l3oN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="66037927"
X-IronPort-AV: E=Sophos;i="5.93,348,1654527600"; 
   d="scan'208";a="66037927"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 18:01:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oS7n34HFYvmphSf2iO8NgiEKJFBrAXY0sIJnO+6MBTfew97D2OOO5XA0GWN2LEKNBUQVdkfppmXLCidU2YQOoGpuI2+THsMkGPA9ulQjfE634WqsDbbadQx38a47HKzWcuzoNwpwQunVcXoPwSDdbJFZgojxT+oFqGqPOWB+Tq2yvfMdDaduGom5hx1fL/f/KKOClyhFhYPsMn/4srh7dNK5s881KGFtUZ0Aj/1OXjZZmDEE8dYwz11kTlXBAhAcONzjKmVfnxuGS41ICMNhGBFhC27lzWw4y2vhJJug49ABZSUvvhFOy+8MKPIqsWuEDg5CaX4yV46BQ+RQ2RCWQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0Xv1r95W3YrJKHeSS9qNvS4uq6E1HRvTCMsQ+Y7tXU=;
 b=MOXiwBvksWoEc9dLCtOIb1fN8iWL3ELAU9GlFdkIE+S9tP7RHgqD1yygUWAiDk6eQRSJLrIGUfe5Lzfu6VlMrxZyvXXRnGC9YUmaKyTPWz0kCxLqvGTsQIGwoCUmvAhOCXhiIoWMzyy8U/1s9hlDSEkcPDOoN7/4nuUL9AQC6OnsJQ/ok1wq0aYwz3y2WZxRAlX/CzgP142r20JBC5yR4UspSH5Ntn2orZ4Ig/ogIAqM50Ef583bOxrsFByaie+KvDfut055EnPXcDslm6eWAMwjs0c9vNFl3cuGxStjo0RFQgSzEMSshIBiexnawTn4IpluSo2euo4mrr3OFmbqVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OSZPR01MB6229.jpnprd01.prod.outlook.com (2603:1096:604:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 09:01:47 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b0c7:c573:a888:8099]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b0c7:c573:a888:8099%5]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 09:01:47 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 3/5] selftests/resctrl: Remove duplicate codes that clear
 each test result file
Thread-Topic: [PATCH 3/5] selftests/resctrl: Remove duplicate codes that clear
 each test result file
Thread-Index: AQHYx90D18NEehSOQUCX8ddKN/e4oK3rxsWAgAc+rMA=
Date:   Tue, 27 Sep 2022 09:01:46 +0000
Message-ID: <TYAPR01MB6330988D96E4CD00C9A03DAA8B559@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com>
 <20220914015147.3071025-5-tan.shaopeng@jp.fujitsu.com>
 <bdb19cf6-dd4b-2042-7cda-7f6108e543aa@intel.com>
In-Reply-To: <bdb19cf6-dd4b-2042-7cda-7f6108e543aa@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMDktMjdUMDg6MjQ6?=
 =?utf-8?B?MzlaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD1kMGNhYzkxMC1lNzFiLTQzYjUt?=
 =?utf-8?B?OGM1Mi1hYzg3NTdlMTA3OWU7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 6d4285f4ca1a421ca1c7f8fd129ceb54
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|OSZPR01MB6229:EE_
x-ms-office365-filtering-correlation-id: 3ce61507-2aed-4a85-41bc-08daa066e846
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XtjEKrhJeLH2Uz6Ks5s06EOutMGo3GNwcYOlYlZAb4kgIu2OcyasQGWDGYI3w41Mkaiw8ER40rH04rMOBmQn5/nesac+t+naCECf8WscklBhJzQ92Rwi2Z6DiUMzhxanIIntnwNtVO9oHt1q8PmmuMYFjtny2crzAOZ2u9O+I4MTJTPCG4eHhvo7WDJyvG68ts09nNzIeAT/w3RYGTuJSUKsJVIGcjlWYA1+DBmCHUaa5Z1IZ7wZdSgtrVc+s0W1ZN5IUay5dG9DeXU/RiKXn6icX2vkxDrkAPwEXlQ8OiB58qiIsgEgTSR/7yWis2i5z4Tk5h/H1LaMBMq35iPdAfnFHQjiW4yLP9XPBJXYh6yeUVWa7n2J86FVvK8/ogjy41uqXWtwn8YqH8Ci88v/baUMKbBRqewwhgKRNJqgJUanH5NnMCiAOwxgZhBC/Qr4SlnIck0iB9KY+avWJhKKpqPfSCLSQW9c/RCD6hjjfBRL8HHqTtlSWIla6QHRUlMbnDC/Y3siFC9YQp4lVOAkMAJXVGRu9g5StWpnH1nBozLx9r+G7Cli8JplpkcRS2UAR/zthe8/EvHHSdhTtbT7kQ8HSlkeg2OgM1r9HrRg/vpFurYyulqbClstBYvVI+AX32L2Y4NleS5JLBHH+giFThn74ntA6JRpj8n94Pb2qWFTXfylj//TqabWfSEhz/Dge9sUff3LPjWmJdlbDqBCr5HzDG5cGj0tkv/EFL6AWReZr+GenDyXViuklAL5PnKjLsYS6396WJNLsYWtFsL1rbcZ1IxQ6XMhOOnlWqYqcTY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(1590799012)(451199015)(55016003)(83380400001)(186003)(122000001)(38070700005)(82960400001)(38100700002)(8676002)(4326008)(64756008)(66446008)(54906003)(316002)(2906002)(76116006)(41300700001)(5660300002)(66476007)(26005)(52536014)(6506007)(53546011)(8936002)(71200400001)(66946007)(9686003)(110136005)(66556008)(7696005)(478600001)(33656002)(85182001)(1580799009)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnFqTXI0KzNUdTRZNGk4dVNTSnROTFV0MG93dnQ2WHBKZXlad1Y1OUlFMXFI?=
 =?utf-8?B?NWlRL2xxcUVqY2s0ZldJYmlFd1lPZXBRWm1WVndjQ3JHc2hCZ0JjVlhSVFVO?=
 =?utf-8?B?RFEva3Urbms5RWIraDhaNWdnb0p2bGszNGs5Q1Q2UmFPVE1kMEp2THAzU1Z0?=
 =?utf-8?B?ZGpFeDNyVGRMRWRpN1Voa0hneVNhRyt1cnBsbEZRc0dTSXJaVEhpVmJSdWlX?=
 =?utf-8?B?d05Db2tGRmpTaUpxT3FweHhoNG9Jbk80d05NeVQrMDV2QXhlN1J3a1hJVXAx?=
 =?utf-8?B?OERRU1ordTg4VGxTS1MzRitWOENXcDdad1pFdkVrbXhWRUdvVkY4UDErK1kz?=
 =?utf-8?B?ZDBjeUVCR0g3RnhFUHk3aTgvQSt3WENQZVpERzFLTEJHVVhuWC9VZ3FuU0Fx?=
 =?utf-8?B?Vk5FMkNqSlgxWW91UC9qNW9rNkRFdG1RMll2cEd5cTFBRmZTMW1lTmNvb09o?=
 =?utf-8?B?OGcvUG93OG5TUXluVEplaVB0RFhqby9zcnk3WmVlcDlxNm15NFFieGYwYTlZ?=
 =?utf-8?B?RG9XUHY2eTAvMDZaeG9RUUFSRTNIcFRlRkd3VVA4RWhvVXJqOS8vQXRlQ3Q2?=
 =?utf-8?B?cjV4anBoL2lkTGZzOTJQSlpzdEV1Vkc2NEdjRmRMSzRCYTh4Q0p4eWxZVUFW?=
 =?utf-8?B?aFRrcWphakNMaGZkVEwvVzhVeDByVHc4K2NXeitBelVZMVpxMmthZmpBWU9h?=
 =?utf-8?B?b0FzR3YwUENMRng2OU42NHoyZk5OcWVEUW1qNVJ6dUwvVUdDeVkwZ2NBQTBl?=
 =?utf-8?B?NnM4bWlBeGt5eHpzelVhSS84M3JjaWd3dVpKN05UblpVYTNkbDBDNnQzdDdD?=
 =?utf-8?B?Qk5FRnQ5Wlg3MEpUZFFaeWkyVFFScTV2UWxUQTJvUjFhZVlFS01Ma2JTSThh?=
 =?utf-8?B?MXNIeU5hN3NRbklReGZ0RDluZWVreUhJdnpCcDdiS1A3N2UxSVdWNXk3a3NG?=
 =?utf-8?B?NnB0dTlRdUdEK3Zvekt2QjNTeVJrVEl1elJYMWVOV3QyT3FaQ3BjamFSZ0Ft?=
 =?utf-8?B?ZSs0VkNuazc0b2Z4UG1IQ2VzVVZlWE5DQXAyV01Zb2tLQTZhNHl2ODVlZzJG?=
 =?utf-8?B?MTZrTmFFWE9pRVJDQW5aNExxOVNXOTBDUGJYS2c1aVkwQ2w0N1l1eExKTWVo?=
 =?utf-8?B?dTFpOWxqSEk3UlpmSnJyQ3diOWY1K0xtVEhDN2ZLQW1sRmJucllJTUwyVm0r?=
 =?utf-8?B?TEZlNUpJU3ZaMG8valorb1pRUzlkZ1lZSEVwNDBjVUFWamVDSGhIMVpNUlhj?=
 =?utf-8?B?QlZKWlFveUtZaHgzZXpIN0pRd1AwVnRoVld0VkNLc1kxeFl0WHpaVGdaaDVW?=
 =?utf-8?B?ZGJva3pyV1dHcWtwSGV2czZxaVlodCsrWll6RXU1ZFhqSnN1c2h5cm5KV2tK?=
 =?utf-8?B?WGRXaDZFYytFQmkybklyTzA2bnN2dU9XTVYxYnd3SXRFQ2Y4Vk9QeHhXaTY0?=
 =?utf-8?B?TzVQZzVnV1VrZ0Fwb2hXYldFZkZnU2ZKYysrYlRoVThsVGhlY0ZzaVJYa0NC?=
 =?utf-8?B?bU4yUlM5V0wwYW1ReU9zWWppb0NsMEFjUXhLQjNQVkFpUlk1bHhCRzg5NVJY?=
 =?utf-8?B?TkcrV1ZjczZuNStjc051SkhoREpSczB4b2pjT1VKRjV3UTRWVWlIZDRxeVFi?=
 =?utf-8?B?MTlFd2FXRmxqOWdlVlk0aUVsd3A3RE92R1c1ZGhzbXZhdFpOdjZsVDVUcGFH?=
 =?utf-8?B?VDdsalVRb2xWWnZpYmhKY2FFaVhRMmp4NnN4aWxFZ2x5bW5DcXgrTEUrN29i?=
 =?utf-8?B?eTF5OENqdU1ScFhxM2NwUy9FZzNiUG5BbzVuZzY3MUlSNHJNMGlBdURybFpy?=
 =?utf-8?B?NlAyKzdURHBwRUFzRlFNdDVMQVBxQVVjQy8wbUczcU84L2ovbTZzNGVEbHVz?=
 =?utf-8?B?Ty9QM21zV1k1M2dxYldnREhMS09HS1dLVkVnSGRQQW1VdlRudkpwVEZ0VjBD?=
 =?utf-8?B?Ymh1NTBWREpabngvUWRLMWQwdlNVZHk5SHo0SzhKcmo0OHY0dWdCVVQ1ZEVN?=
 =?utf-8?B?UUVZeXdpYk9JcDVVRlVwZjBOZWI4QnhVSnBIdW9GMlJsUGk4V1NtK1FiM3Vv?=
 =?utf-8?B?ei84NjZDdU9iOU1QQlh3ZnhXSlJyVW0xaDFXSkRpR01nYmp2a1ZSL3JRSkRI?=
 =?utf-8?B?SnM1K0ZjUlU4NkY4UFc5ZTBqVzB0ck16cVZzeUt4MmpZaklwZmhYTGRBMnFU?=
 =?utf-8?B?NXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce61507-2aed-4a85-41bc-08daa066e846
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 09:01:46.9735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ojQUUhmeNsZTgG58/g77LQeUO75SZn39IRqORlzejxs2v2qXSa7gSTJZ2pgIFJ/oM4Ry4AdnIGzx8+kUrntT9/OSqt43a+h/GSu/ulIx8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6229
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgUmVpbmV0dGUsDQoNCj4gT24gOS8xMy8yMDIyIDY6NTEgUE0sIFNoYW9wZW5nIFRhbiB3cm90
ZToNCj4gPiBCZWZvcmUgZXhpdGluZyBlYWNoIHRlc3QgZnVuY3Rpb24ocnVuX2NtdC9jYXQvbWJt
L21iYV90ZXN0KCkpLA0KPiA+IHRlc3QgcmVzdWx0cyBhcmUgcHJpbnRlZCBieSBrc2Z0X3ByaW50
X21zZygpIGFuZCB0aGVuIHRlbXBvcmFyeSByZXN1bHQNCj4gPiBmaWxlcyBhcmUgY2xlYW5lZCBi
eSBmdW5jdGlvbiBjbXQvY2F0L21ibS9tYmFfdGVzdF9jbGVhbnVwKCkuDQo+ID4gSG93ZXZlciwg
YmVmb3JlIHJ1bm5pbmcga3NmdF9wcmludF9tc2coKSwgZnVuY3Rpb24NCj4gDQo+IGJlZm9yZSAt
PiBhZnRlcj8NCg0KSSB0aGluayBpdCBpcyAiYmVmb3JlIi4NCg0KPiA+IGNtdC9jYXQvbWJtL21i
YV90ZXN0X2NsZWFudXAoKQ0KPiA+IGhhcyBiZWVuIHJ1biBpbiBlYWNoIHRlc3QgZnVuY3Rpb24g
YXMgZm9sbG93czoNCj4gPiAgIGNtdF9yZXNjdHJsX3ZhbCgpDQo+ID4gICBjYXRfcGVyZl9taXNz
X3ZhbCgpDQo+ID4gICBtYmFfc2NoZW1hdGFfY2hhbmdlKCkNCj4gPiAgIG1ibV9id19jaGFuZ2Uo
KQ0KPiA+DQo+ID4gUmVtb3ZlIGR1cGxpY2F0ZSBjb2RlcyB0aGF0IGNsZWFyIGVhY2ggdGVzdCBy
ZXN1bHQgZmlsZS4NCj4gPg0KPiANCj4gQW5vdGhlciBnb29kIGNhdGNoLCB0aGFuayB5b3UuDQo+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoYW9wZW5nIFRhbiA8dGFuLnNoYW9wZW5nQGpwLmZ1aml0
c3UuY29tPg0KPiA+IC0tLQ0KPiA+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL2Nh
dF90ZXN0LmMgfCAxIC0NCj4gPiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL2NtdF90
ZXN0LmMgfCAyIC0tDQo+ID4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9tYmFfdGVz
dC5jIHwgMiAtLQ0KPiA+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvbWJtX3Rlc3Qu
YyB8IDIgLS0NCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCA3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvY2F0X3Rlc3QuYw0K
PiA+IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9jYXRfdGVzdC5jDQo+ID4gaW5k
ZXggMWM1ZTkwYzYzMjU0Li5kMTEzNGY2NjQ2OWYgMTAwNjQ0DQo+ID4gLS0tIGEvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvcmVzY3RybC9jYXRfdGVzdC5jDQo+ID4gKysrIGIvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvcmVzY3RybC9jYXRfdGVzdC5jDQo+ID4gQEAgLTIyMSw3ICsyMjEsNiBAQCBp
bnQgY2F0X3BlcmZfbWlzc192YWwoaW50IGNwdV9ubywgaW50IG4sIGNoYXINCj4gKmNhY2hlX3R5
cGUpDQo+ID4gIAkJa2lsbChibV9waWQsIFNJR0tJTEwpOw0KPiA+ICAJfQ0KPiA+DQo+ID4gLQlj
YXRfdGVzdF9jbGVhbnVwKCk7DQo+ID4gIAlpZiAoYm1fcGlkKQ0KPiA+ICAJCXVtb3VudF9yZXNj
dHJsZnMoKTsNCj4gPg0KPiANCj4gSXQgbWFrZXMgaXQgbXVjaCBlYXNpZXIgdG8gdW5kZXJzdGFu
ZCBjb2RlIGlmIGl0IGlzIHN5bW1ldHJpY2FsLiBTaW5jZSB0aGUgZmlsZXMNCj4gYXJlIGNyZWF0
ZWQgd2l0aGluIGNhdF9wZXJmX21pc3NfdmFsKCkgSSB0aGluayBpdCB3b3VsZCBiZSBiZXR0ZXIg
dG8gcGVyZm9ybSB0aGUNCj4gY2xlYW51cCBpbiB0aGUgc2FtZSBmdW5jdGlvbi4gU28sIGtlZXAg
dGhpcyBjbGVhbnVwIGJ1dCByZW1vdmUgdGhlIGNhbGwgZnJvbQ0KPiBydW5fY2F0X3Rlc3QoKSBp
bnN0ZWFkLg0KPiANCj4gU2ltaWxhciBmb3IgdGhlIGNsZWFudXBzIGJlbG93IC4uLiBjb3VsZCB5
b3UgcGxlYXNlIGtlZXAgdGhlbSBhbmQgaW5zdGVhZA0KPiByZW1vdmUgdGhlIGR1cGxpY2F0ZSBj
bGVhbnVwIGZyb20gcnVuX2NtdC9tYm0vbWJhX3Rlc3QoKSBpbnN0ZWFkPw0KPiANCj4gV2hlbiB5
b3UgZG8gc28sIHBsZWFzZSBiZSBjYXJlZnVsIHNpbmNlIGl0IHNlZW1zIHRoYXQgdGhlcmUgaXMg
KGFub3RoZXIhKSBidWcNCj4gd2hlcmUgdGhlIGNsZWFudXAgaXMgbm90IGRvbmUgaWYgdGhlIHRl
c3QgZmFpbHMuDQoNClRoYW5rcyBmb3IgeW91ciBhZHZpY2VzLCBJIHdpbGwgcmVtb3ZlIHRoZSBk
dXBsaWNhdGUgY2xlYW51cHMgZnJvbSBydW5fY210L21ibS9tYmFfdGVzdCgpLg0KDQpCZXN0IFJl
Z2FyZHMsDQpTaGFvcGVuZw0KDQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3Jlc2N0cmwvY210X3Rlc3QuYw0KPiA+IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVz
Y3RybC9jbXRfdGVzdC5jDQo+ID4gaW5kZXggODk2OGUzNmRiOTlkLi5iM2IxN2ZiODc2ZjQgMTAw
NjQ0DQo+ID4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9jbXRfdGVzdC5j
DQo+ID4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9jbXRfdGVzdC5jDQo+
ID4gQEAgLTEzOSw3ICsxMzksNSBAQCBpbnQgY210X3Jlc2N0cmxfdmFsKGludCBjcHVfbm8sIGlu
dCBuLCBjaGFyDQo+ICoqYmVuY2htYXJrX2NtZCkNCj4gPiAgCWlmIChyZXQpDQo+ID4gIAkJcmV0
dXJuIHJldDsNCj4gPg0KPiA+IC0JY210X3Rlc3RfY2xlYW51cCgpOw0KPiA+IC0NCj4gPiAgCXJl
dHVybiAwOw0KPiA+ICB9DQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L3Jlc2N0cmwvbWJhX3Rlc3QuYw0KPiA+IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3Ry
bC9tYmFfdGVzdC5jDQo+ID4gaW5kZXggMWExYmRiNjE4MGNmLi45M2ZmYWNiNDE2ZGYgMTAwNjQ0
DQo+ID4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9tYmFfdGVzdC5jDQo+
ID4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9tYmFfdGVzdC5jDQo+ID4g
QEAgLTE2Niw3ICsxNjYsNSBAQCBpbnQgbWJhX3NjaGVtYXRhX2NoYW5nZShpbnQgY3B1X25vLCBj
aGFyDQo+ICpid19yZXBvcnQsIGNoYXIgKipiZW5jaG1hcmtfY21kKQ0KPiA+ICAJaWYgKHJldCkN
Cj4gPiAgCQlyZXR1cm4gcmV0Ow0KPiA+DQo+ID4gLQltYmFfdGVzdF9jbGVhbnVwKCk7DQo+ID4g
LQ0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvcmVzY3RybC9tYm1fdGVzdC5jDQo+ID4gYi90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9yZXNjdHJsL21ibV90ZXN0LmMNCj4gPiBpbmRleCAzOGEzYjNhZDFjNzYuLmE0NTNkYjRj
MjIxZiAxMDA2NDQNCj4gPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL21i
bV90ZXN0LmMNCj4gPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL21ibV90
ZXN0LmMNCj4gPiBAQCAtMTM0LDcgKzEzNCw1IEBAIGludCBtYm1fYndfY2hhbmdlKGludCBzcGFu
LCBpbnQgY3B1X25vLCBjaGFyDQo+ICpid19yZXBvcnQsIGNoYXIgKipiZW5jaG1hcmtfY21kKQ0K
PiA+ICAJaWYgKHJldCkNCj4gPiAgCQlyZXR1cm4gcmV0Ow0KPiA+DQo+ID4gLQltYm1fdGVzdF9j
bGVhbnVwKCk7DQo+ID4gLQ0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gDQo+IFRoYW5rIHlv
dQ0KPiANCj4gUmVpbmV0dGUNCg==
