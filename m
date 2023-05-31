Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4067171767F
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 May 2023 08:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjEaGDf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 02:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjEaGDe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 02:03:34 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F6511D;
        Tue, 30 May 2023 23:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1685513011; x=1717049011;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=WcB+T04eKMBXr3+IIdLWtml33u12gMvmuJwnvpNFFKk=;
  b=x4oxX/T2f/vVuMpXFGJT37Zw0YguxeA0TFNtbqiRJ47uj76ztLXorUS5
   fM1mldYYmgB9jN9iCz2zUSrayhVgFbsMJ0+gUe0iyoIHBR5JkZatgXOsX
   +8T4KENEIyNyT6e9vPgQpuAtlQCMEfe2GVPwLwnl3o45+cmFgCH38yPV4
   kSMlXcls3UtPSxfST66TE9ZjvBBSxIUTnpXf8HfY5pGqIIHBQh0gXgYxa
   p5cGlalwo00NtUfxI4M/RTvHGdggn/8VVt+g3kQNh2mWEtuTrvNMnCemI
   kPujgeNBE/jz+HPiRL9vkbZ7tdVlpI6u8RlKkIX/0mWqwzphJ0RH5mRdi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="86010619"
X-IronPort-AV: E=Sophos;i="6.00,205,1681138800"; 
   d="scan'208";a="86010619"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 15:03:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQKheESHig19dsqhpi5/L4DeexGB3dudKPgo6yDE2GYNVnzl+akKMxQISOI9MkFW7I4hSqBhqHeNnfn5MOI1SWB08wRywpnFEPY7TuOKaFhY9CDvxFK4PtXvOYxur6DzuEMA8OiByRzEzQFvrUCNsAhyfgFUuqjm0Jcau5WCepZ4C1Id5M+qo4Hgz3R5at53lSTaIn/+RwOdUOKohUeD5l5Aqn2x5OIpW/xfWCr2LT39/x84sCK6OF+S/a+SK6KfCr8Q+6vvoMm9MO/ZaBXujzElVQAUdxIXwgkbcetZ8ueat/h7kXtgHOuXkjTjWI95o2PPliYwq5UFKsum5k010Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcB+T04eKMBXr3+IIdLWtml33u12gMvmuJwnvpNFFKk=;
 b=aM5PQbbFeWoLpVgpTQDJ31QrMSTqzrjTjRRE0UntcWmaieGSg6NiJSJFWkLixpbZxqj8kHhfrA7+H6jL+f9O8tznkB3EtzmiyCc2ZenBIEQMHvnj8Q9i31c498wRIXnMA50DjI4RifDKb8bw3nZojqWnWr6UBQ5+xaZ0/w2tt5Zc+tGyZ/vfJbrzjp2D6z8IoFhaIrOEATI/e2SFz/QeXJfpbmaNwYTBRpwQ6y2n3ZSiaXt5046wG+vBxemI8wOyeAVj4iw4FRP4HTbZ5ZIk90+IoKgNc4hd4onsYzCjBPScC17rm5YWcoiPG5/xeaivKYArMxmIFqT+AkvtOo3ytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6328.jpnprd01.prod.outlook.com (2603:1096:604:e8::8)
 by TYCPR01MB10747.jpnprd01.prod.outlook.com (2603:1096:400:297::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 06:03:15 +0000
Received: from OSZPR01MB6328.jpnprd01.prod.outlook.com
 ([fe80::cc8b:a287:185b:3ea9]) by OSZPR01MB6328.jpnprd01.prod.outlook.com
 ([fe80::cc8b:a287:185b:3ea9%4]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 06:03:15 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     =?utf-8?B?J0lscG8gSsOkcnZpbmVuJw==?= 
        <ilpo.jarvinen@linux.intel.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 15/24] selftests/resctrl: Refactor get_cbm_mask()
Thread-Topic: [PATCH v2 15/24] selftests/resctrl: Refactor get_cbm_mask()
Thread-Index: AQHZcetolUPYZRJogkCmAHAfC6SkvK90Jr3w
Date:   Wed, 31 May 2023 06:03:14 +0000
Message-ID: <OSZPR01MB63280E04EDAE0CCB21B591978B489@OSZPR01MB6328.jpnprd01.prod.outlook.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-16-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20230418114506.46788-16-ilpo.jarvinen@linux.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDUtMzFUMDY6MDE6?=
 =?utf-8?B?MDZaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD0xOTk5ZmRlZS1jYzRkLTQ2NmEt?=
 =?utf-8?B?ODE5Yi05ODg0YTM4ZGM0NTA7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: aea7480baebd45e1aeb4892c12e3f51d
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6328:EE_|TYCPR01MB10747:EE_
x-ms-office365-filtering-correlation-id: 64d6701a-e7c5-4a3e-cbad-08db619cb8fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u7Zayl1ZbtjqFw+3aaxxF1wDcRg+j24Ws3UHkhtWv3j8j2LySUquRcEH23rHmqGTGNucELNuUVKDNF3KJOr7Z06Vj9heBYc+1CdtEu9xFvK8sptmmbatDFgerzTw53sKti5dNgh6YtUlWHgLs1J3zHjDRgr6QH12AJT+LcSeoKynnuTimq/Jbv9JxbfjNCc1YKU+vCDgA5QH0rVPF6DKQkK1A9ij2WlmQHAwI5WNIuWZ4HHMqXsNE/g2jTQnbLF+Bq+TTvesw3+tr5sxRoLxmRqGFJFBL89mq2yWPvXN74L3bT4cKUe3y5bD6lVAAy3z397IvSaMAxm7OK2xlH4FLgSiSrJnHpbgLfrLhEiDKE5ADqJ9BZT6HXsFvCbqvymstye3TY4zmND4xkYbbBNEwTolO0jcyffSRjLuQQn0te2ENf9fpmjA5/Brh6eguD8cZkO4wPNiFTWg7cdJ9Ja09oc/mAJEVwhf7Cl8lVONnxKwRduRMDKOxfLTmzFWjss7A5Wy1E4qRQPMFCs7BORuSBHaHlkLQd4svgPZwxHKXNKnE6zVpZJzqZkpJLe8C5X4YLJHLUIsw3uBPOjXKoOWQsl56cDwzOgKYUb7CQNScyMCpi6zhYZ3rplOOcFP4pXR4b8uWwnqMa9pIcwtpjLZRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6328.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(1590799018)(451199021)(186003)(71200400001)(33656002)(316002)(41300700001)(86362001)(7696005)(66556008)(66446008)(6506007)(66946007)(66476007)(85182001)(76116006)(83380400001)(26005)(9686003)(66574015)(64756008)(2906002)(110136005)(38070700005)(478600001)(52536014)(1580799015)(5660300002)(8936002)(122000001)(38100700002)(8676002)(82960400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q05mVFpscUV0d2RUZ28rdHZKblRWSmRsSy9HZ1hZT2hmYnphcE0xRWkxcGtu?=
 =?utf-8?B?Z24zZmlSdEN2MzdVeEc5aW1peGU4VUozaUxhWGdaOUl2WTVpR1BCRFlCU2g0?=
 =?utf-8?B?RmhpaUJmbkxkZ3ZKazFrQ2dYNkJYWVg0V3JYWk5rUGZqdCsrY0g1K3lscVNP?=
 =?utf-8?B?Nkc2UnhHUCtkc0VLUXdEQkFHbWwwYlZEam05SUl6OCtoS0QyVmFMNnNwelg3?=
 =?utf-8?B?WS8wSUJWR1F2cUhZL0wyUlZGL2ZQZ3NPanJCZnM1R3hZaHpsdXVYMkJZeDAz?=
 =?utf-8?B?RkZTc0l4UFQ1LzFWSHF3NGNwUHhqNE9vaC9NS0dBTzVIc0tQZmNyVkdqNDdI?=
 =?utf-8?B?K096VzlNSi9KWDlxOFFlOElndW9FbDJZV3ZVaGlYY2NlbTZEbEZJTUM3cW9W?=
 =?utf-8?B?ZmN3RnBkQzNTaDMvaU93aFkxbTRhQ3FBMFpYSjQ3U05Rc05qR3Z3ZlFhbU9q?=
 =?utf-8?B?ODdRUERQczg3cGRiVUFzUi9lbXNyZ055THp5ZVJGb1QremtCUmpLNi9pMHNp?=
 =?utf-8?B?MVltdlNoMGJkMmJBWG84Z3JOWTJIeEgrUURabUJ1NUlydS9BS01UM3NWWUlK?=
 =?utf-8?B?ZEhyYkRNQ1ljZDdxMktQUGtUcWpqMkgrOEI0MjV6VGFnUHREL0RKcjR1MHRB?=
 =?utf-8?B?UGU5Y0tBam1obXVBcHcwZ1dXNjdxT2NBaG1PQ3RDdFZPVldiQXhUOGZOck5R?=
 =?utf-8?B?SlFOZUZrMlh5Rmg2WGsrQUpJbVNHZDY5aFQ5ckJQQzRwaVZVMjBWSmI0U2hY?=
 =?utf-8?B?bmNHSnRnSGhkRU83cEpOMW9YVXAyeThtVDlxb2o4czREbkFNWTdrN1h0R0tP?=
 =?utf-8?B?L3Vma1puY1VyeVNXVHNJanB2SzhvNHdSekZVSEVGN1pIbUFhVUN3d0oxVW5w?=
 =?utf-8?B?dzljbXZZVXM4U25IeHlXK3QySi93SVFTT1F1YXB4ZStVbDlGZ2dLZGd6bGsw?=
 =?utf-8?B?ejZlcWREa0FjNGErUDdzbFFscnJ3RmU1dEFUUFR1QktLdXNWNjJqUjdTc21R?=
 =?utf-8?B?eVgzZkM2Ui9QT1FlbzhOWmsxdWpPM1B5L1hXRVNZNWdvN3MrY0lOMUdIM3d1?=
 =?utf-8?B?aEwwZDJwUDRFODR2WWdrM2ZqR3ZlcFkwbjFhYWE3VzB1cmJmN3ZGYm5RSUli?=
 =?utf-8?B?K3kxYTJ0RitrQ2RqQVFiQm1nYzVZY0VXbGg5NTNMMkI5cGpDM0hWa3B4eldN?=
 =?utf-8?B?RHBUUlMza3ZDK3luQ0lkeWlUbTR5RjlIQlZ6N1VCM0hseHpVbGhKZEV0Snha?=
 =?utf-8?B?VTljb3M5VUxnNDJERmpMSS9iZ3RBUmlXYXhBMGdyYlhEYUhraDMxWXVpVDRp?=
 =?utf-8?B?MlRMaVFOTEhyWHlwbVRHMkF0YlM0VUk2L3QzakRFL1lXOGVJS2lKa3VQRmJs?=
 =?utf-8?B?RktmdHQ4dXNLLy8vZjVPcmNkRE41cGRzUmJMNUVLN2RBNDJJdldrWlIwWXZL?=
 =?utf-8?B?UVFjU096U3V4eDRJakgyQWtTaFE3cTIvcmtGOEoyRGtNa2hJd3I2SzhMTUkw?=
 =?utf-8?B?KzBWK2ttWlhxU1lTY0pBTnJ5RnRUTHVaZjdIeXdDaW54WUJrTFFaTlBrM01G?=
 =?utf-8?B?Y3cvMWxoNkw0ejFTK1htSjBEaDU3QVcxNnp5SUlYVnByNXdUQzlYaUxpU0Ft?=
 =?utf-8?B?ZGt5em5SR2xXbWkxMmVzMk1DeEJoMHppaGgzYlZYUFhtQ0Y3U2pmbHhpemt5?=
 =?utf-8?B?V0IrbWMxQXM3MWEydDkyTCtjSm1taWZnUkdneGtBb05nK1AvaHhOSXpBaWVV?=
 =?utf-8?B?eS82c2FiRzY4QXlsekFCdXdsdDkzNThLc2xsc0hFWU5rZHdzNkJTYlB5Rkxv?=
 =?utf-8?B?OFpOaUhqZGJ6aUFDaDEyQkZTcWNPRjdDbGJRRVZKQTZFN3NsaGs4dlhBMG5S?=
 =?utf-8?B?a1BZdHFqNDdRdXJSdXFObW8xZDlZci9qL1ltN0hUaDRkTVVHbE93NDdYNFQz?=
 =?utf-8?B?OCtBNksxY1h2QWltNDRtTHBzMEQ1WlVvL1dZQzFwcDVabmsrNjVmb2VrWUJi?=
 =?utf-8?B?c1lveGYxTkN0cWQ1OVJiL2Znb2dWTTlIbERlYTk3UUtXei9iZElqeUhPQXMr?=
 =?utf-8?B?UWR3Y2cvSFZxWGlJVGpGdXJESDVZbm1DT2txQWF6QkJGd2JBVkE1RTJRb3Fv?=
 =?utf-8?B?NXlFRXlad25aTXlGSnZmRVkzVkxnQjYyd1hITEw0Q25LWG1sSXJKQTFjaXdm?=
 =?utf-8?B?cXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oqj8DviYau6VAgG97KzgSJfa/z+BGo+2lAyt8JpphVZ0q7QvmYOFbyBPbp5M3t9kyjLIwPrADje348rjYhLpsa3r9hEovjpRXQM9aZKyTsnNFwB3efdrBbuJqKk8akJ7ADHwVonotQlplWpYvqJKTpLV8HKiuCIfygHgigR1pnmu/iz+mgjrxkUnherH0ul63T1l1BNiDa3lH+Y+eCdVJVi4hxGNqbtlr4Lj2RQkBOUT4P6Xu6z397apE0N/X0O94O4hYK0mGqYadWuzUSBCF4/llXH17dTX2F54E+QkonfcA4MW+dycPaQspfnhS/eJvwIZ1ANtNU6bUDt7bkxxtt6E8CSEIIiJHurFtkYB+95cWzSUyEvJ75uT1xh61zS/xDMn0XA9o7KKIB0kHR87dtZDxG2MQXo1oLOF3wIXkng+n3R1QC0z8lEM/PG2zeivHi+FDFP8HjWgO97s35k2E8osE4Fe/PC2lwyeAS71/m7SnKz1U5h3T4wgglxB0BwJWypcAuc7hcnHWQI2qjZZlhwtyLaFszvxLdn7KaF4eaYW3QFrUv9qEeY7qods40wn+4wWZYIFM9Xwkb188jfwyZrwQZug0QArK8VyDxxCVyuLg6w7JEecm6Lr8vUzfs34QWngJ4BKvR+BrIKm9OpPXeLT+L6Hfs/UMrGKbH5S+YSabdWqJ4k5v88+sLcGdvPRSIHinm0jHBpSew+SsHNH0XMtmwt0UEZMN3f3GdyQAhV42/tr59gKQTn6IOXaH6pjO4kwegum8mhpPLECZkxTSNG2ecwSjzAoxuQ7IlnxHOj9qoovtra15ILAIwciBDxia/dThcwtzH11gixDY0s4XTZuFmYCjnRYwGZ5gCYJrq6M8IcWmEHsS8oMJ+grWWHM
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6328.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d6701a-e7c5-4a3e-cbad-08db619cb8fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 06:03:14.9185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fbSNAeHm0gl8BBQ0ukyzVTUdprW+Y0Ky6e+4FkD7It4khD+bn/ycL6ewts5itj3u0X8S7VtRoybf+9p8FiDtfV0Yw21PmPGuY3+AwPg3jRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10747
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgSWxwbywNCg0KPiBDYWxsZXJzIG9mIGdldF9jYm1fbWFzaygpIGFyZSByZXF1aXJlZCB0byBw
YXNzIGEgc3RyaW5nIGludG8gd2hpY2ggdGhlIENCTSBiaXQNCj4gbWFzayBpcyByZWFkIGludG8u
IE5laXRoZXIgQ0FUIG5vciBDTVQgdGVzdHMgbmVlZCB0aGUgbWFzayBhcyBzdHJpbmcgYnV0IGp1
c3QNCj4gY29udmVydCBpdCBpbnRvIGFuIHVuc2lnbmVkIGxvbmcgdmFsdWUuDQo+IA0KPiBUaGUg
Yml0IG1hc2sgcmVhZGVyIGNhbiBvbmx5IHJlYWQgLi4uL2NibV9tYXNrIGZpbGVzLg0KPiANCj4g
R2VuZXJhbGl6ZSB0aGUgYml0IG1hc2sgcmVhZGluZyBmdW5jdGlvbiBpbnRvIGdldF9iaXRfbWFz
aygpIHN1Y2ggdGhhdCBpdCBjYW4NCj4gYmUgdXNlZCB0byBoYW5kbGUgb3RoZXIgZmlsZXMgYmVz
aWRlcyB0aGUgLi4uL2NibV9tYXNrIGFuZCBoYW5kbGUgdGhlDQo+IHVuc2lnbmVkIGxvbmcgY29u
dmVyc2lvbiB3aXRoaW4gd2l0aGluIGdldF9iaXRfbWFzaygpIHVzaW5nIGZzY2FuZigpLiBBbHRl
cg0KPiBnZXRfY2JtX21hc2soKSB0byBjb25zdHJ1Y3QgdGhlIGZpbGVuYW1lIGZvciBnZXRfYml0
X21hc2soKS4NCj4gDQo+IENvLWRldmVsb3BlZC1ieTogRmVuZ2h1YSBZdSA8ZmVuZ2h1YS55dUBp
bnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEZlbmdodWEgWXUgPGZlbmdodWEueXVAaW50ZWwu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBJbHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51
eC5pbnRlbC5jb20+DQo+IC0tLQ0KPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9j
YXRfdGVzdC5jICB8ICA1ICstLQ0KPiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL2Nt
dF90ZXN0LmMgIHwgIDUgKy0tDQo+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL3Jl
c2N0cmwuaCAgIHwgIDIgKy0NCj4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvcmVz
Y3RybGZzLmMgfCA1MCArKysrKysrKysrKysrKystLS0tLS0NCj4gIDQgZmlsZXMgY2hhbmdlZCwg
NDAgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9jYXRfdGVzdC5jDQo+IGIvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvcmVzY3RybC9jYXRfdGVzdC5jDQo+IGluZGV4IGE5OThlNjM5NzUxOC4uOWJm
NWQwNWQ5ZTc0IDEwMDY0NA0KPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJs
L2NhdF90ZXN0LmMNCj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9jYXRf
dGVzdC5jDQo+IEBAIC0xOCw3ICsxOCw2IEBADQo+ICAjZGVmaW5lIE1BWF9ESUZGCQkxMDAwMDAw
DQo+IA0KPiAgc3RhdGljIGludCBjb3VudF9vZl9iaXRzOw0KPiAtc3RhdGljIGNoYXIgY2JtX21h
c2tbMjU2XTsNCj4gIHN0YXRpYyB1bnNpZ25lZCBsb25nIGxvbmdfbWFzazsNCj4gIHN0YXRpYyB1
bnNpZ25lZCBsb25nIGNhY2hlX3NpemU7DQo+IA0KPiBAQCAtMTAxLDEyICsxMDAsMTAgQEAgaW50
IGNhdF9wZXJmX21pc3NfdmFsKGludCBjcHVfbm8sIGludCBuLCBjaGFyDQo+ICpjYWNoZV90eXBl
KQ0KPiAgCWNhY2hlX3NpemUgPSAwOw0KPiANCj4gIAkvKiBHZXQgZGVmYXVsdCBjYm0gbWFzayBm
b3IgTDMvTDIgY2FjaGUgKi8NCj4gLQlyZXQgPSBnZXRfY2JtX21hc2soY2FjaGVfdHlwZSwgY2Jt
X21hc2spOw0KPiArCXJldCA9IGdldF9jYm1fbWFzayhjYWNoZV90eXBlLCAmbG9uZ19tYXNrKTsN
Cj4gIAlpZiAocmV0KQ0KPiAgCQlyZXR1cm4gcmV0Ow0KPiANCj4gLQlsb25nX21hc2sgPSBzdHJ0
b3VsKGNibV9tYXNrLCBOVUxMLCAxNik7DQo+IC0NCj4gIAkvKiBHZXQgTDMvTDIgY2FjaGUgc2l6
ZSAqLw0KPiAgCXJldCA9IGdldF9jYWNoZV9zaXplKGNwdV9ubywgY2FjaGVfdHlwZSwgJmNhY2hl
X3NpemUpOw0KPiAgCWlmIChyZXQpDQo+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9yZXNjdHJsL2NtdF90ZXN0LmMNCj4gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNj
dHJsL2NtdF90ZXN0LmMNCj4gaW5kZXggMmQ0MzRjMDNjYmJhLi5hZTU0YmJhYmJkOTEgMTAwNjQ0
DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvY210X3Rlc3QuYw0KPiAr
KysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL2NtdF90ZXN0LmMNCj4gQEAgLTE3
LDcgKzE3LDYgQEANCj4gICNkZWZpbmUgTUFYX0RJRkZfUEVSQ0VOVAkxNQ0KPiANCj4gIHN0YXRp
YyBpbnQgY291bnRfb2ZfYml0czsNCj4gLXN0YXRpYyBjaGFyIGNibV9tYXNrWzI1Nl07DQo+ICBz
dGF0aWMgdW5zaWduZWQgbG9uZyBsb25nX21hc2s7DQo+ICBzdGF0aWMgdW5zaWduZWQgbG9uZyBj
YWNoZV9zaXplOw0KPiANCj4gQEAgLTgyLDEyICs4MSwxMCBAQCBpbnQgY210X3Jlc2N0cmxfdmFs
KGludCBjcHVfbm8sIGludCBuLCBjaGFyDQo+ICoqYmVuY2htYXJrX2NtZCkNCj4gIAlpZiAoIXZh
bGlkYXRlX3Jlc2N0cmxfZmVhdHVyZV9yZXF1ZXN0KENNVF9TVFIpKQ0KPiAgCQlyZXR1cm4gLTE7
DQo+IA0KPiAtCXJldCA9IGdldF9jYm1fbWFzaygiTDMiLCBjYm1fbWFzayk7DQo+ICsJcmV0ID0g
Z2V0X2NibV9tYXNrKCJMMyIsICZsb25nX21hc2spOw0KPiAgCWlmIChyZXQpDQo+ICAJCXJldHVy
biByZXQ7DQo+IA0KPiAtCWxvbmdfbWFzayA9IHN0cnRvdWwoY2JtX21hc2ssIE5VTEwsIDE2KTsN
Cj4gLQ0KPiAgCXJldCA9IGdldF9jYWNoZV9zaXplKGNwdV9ubywgIkwzIiwgJmNhY2hlX3NpemUp
Ow0KPiAgCWlmIChyZXQpDQo+ICAJCXJldHVybiByZXQ7DQo+IGRpZmYgLS1naXQgYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0cmwuaA0KPiBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL3Jlc2N0cmwvcmVzY3RybC5oDQo+IGluZGV4IGJhMzZlYjVmZGYwZC4uYmNjOTVmYWE1
YjRlIDEwMDY0NA0KPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0
cmwuaA0KPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0cmwuaA0K
PiBAQCAtMTA2LDcgKzEwNiw3IEBAIHZvaWQgdGVzdHNfY2xlYW51cCh2b2lkKTsgIHZvaWQNCj4g
bWJtX3Rlc3RfY2xlYW51cCh2b2lkKTsgIGludCBtYmFfc2NoZW1hdGFfY2hhbmdlKGludCBjcHVf
bm8sIGNoYXINCj4gKmJ3X3JlcG9ydCwgY2hhciAqKmJlbmNobWFya19jbWQpOyAgdm9pZCBtYmFf
dGVzdF9jbGVhbnVwKHZvaWQpOyAtaW50DQo+IGdldF9jYm1fbWFzayhjaGFyICpjYWNoZV90eXBl
LCBjaGFyICpjYm1fbWFzayk7DQo+ICtpbnQgZ2V0X2NibV9tYXNrKGNoYXIgKmNhY2hlX3R5cGUs
IHVuc2lnbmVkIGxvbmcgKm1hc2spOw0KPiAgaW50IGdldF9jYWNoZV9zaXplKGludCBjcHVfbm8s
IGNoYXIgKmNhY2hlX3R5cGUsIHVuc2lnbmVkIGxvbmcNCj4gKmNhY2hlX3NpemUpOyAgdm9pZCBj
dHJsY19oYW5kbGVyKGludCBzaWdudW0sIHNpZ2luZm9fdCAqaW5mbywgdm9pZCAqcHRyKTsgIGlu
dA0KPiBzaWduYWxfaGFuZGxlcl9yZWdpc3Rlcih2b2lkKTsgZGlmZiAtLWdpdA0KPiBhL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvcmVzY3RybGZzLmMNCj4gYi90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0cmxmcy5jDQo+IGluZGV4IDdmZWY5MDY4ZDdmZC4uZjAx
ZWNmYTY0MDYzIDEwMDY0NA0KPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJs
L3Jlc2N0cmxmcy5jDQo+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvcmVz
Y3RybGZzLmMNCj4gQEAgLTE4NiwzMCArMTg2LDI5IEBAIGludCBnZXRfY2FjaGVfc2l6ZShpbnQg
Y3B1X25vLCBjaGFyICpjYWNoZV90eXBlLA0KPiB1bnNpZ25lZCBsb25nICpjYWNoZV9zaXplKQ0K
PiAgI2RlZmluZSBDT1JFX1NJQkxJTkdTX1BBVEgJIi9zeXMvYnVzL2NwdS9kZXZpY2VzL2NwdSIN
Cj4gDQo+ICAvKg0KPiAtICogZ2V0X2NibV9tYXNrIC0gR2V0IGNibSBtYXNrIGZvciBnaXZlbiBj
YWNoZQ0KPiAtICogQGNhY2hlX3R5cGU6CUNhY2hlIGxldmVsIEwyL0wzDQo+IC0gKiBAY2JtX21h
c2s6CWNibV9tYXNrIHJldHVybmVkIGFzIGEgc3RyaW5nDQo+ICsgKiBnZXRfYml0X21hc2sgLSBH
ZXQgYml0IG1hc2sgZnJvbSBnaXZlbiBmaWxlDQo+ICsgKiBAZmlsZW5hbWU6CUZpbGUgY29udGFp
bmluZyB0aGUgbWFzaw0KPiArICogQG1hc2s6CVRoZSBiaXQgbWFzayByZXR1cm5lZCBhcyB1bnNp
Z25lZCBsb25nDQo+ICAgKg0KPiAgICogUmV0dXJuOiA9IDAgb24gc3VjY2VzcywgPCAwIG9uIGZh
aWx1cmUuDQo+ICAgKi8NCj4gLWludCBnZXRfY2JtX21hc2soY2hhciAqY2FjaGVfdHlwZSwgY2hh
ciAqY2JtX21hc2spDQo+ICtzdGF0aWMgaW50IGdldF9iaXRfbWFzayhjaGFyICpmaWxlbmFtZSwg
dW5zaWduZWQgbG9uZyAqbWFzaykNCj4gIHsNCj4gLQljaGFyIGNibV9tYXNrX3BhdGhbMTAyNF07
DQo+ICAJRklMRSAqZnA7DQo+IA0KPiAtCWlmICghY2JtX21hc2spDQo+ICsJaWYgKCFmaWxlbmFt
ZSB8fCAhbWFzaykNCj4gIAkJcmV0dXJuIC0xOw0KPiANCj4gLQlzcHJpbnRmKGNibV9tYXNrX3Bh
dGgsICIlcy8lcy9jYm1fbWFzayIsIElORk9fUEFUSCwNCj4gY2FjaGVfdHlwZSk7DQo+IC0NCj4g
LQlmcCA9IGZvcGVuKGNibV9tYXNrX3BhdGgsICJyIik7DQo+ICsJZnAgPSBmb3BlbihmaWxlbmFt
ZSwgInIiKTsNCj4gIAlpZiAoIWZwKSB7DQo+IC0JCXBlcnJvcigiRmFpbGVkIHRvIG9wZW4gY2Fj
aGUgbGV2ZWwiKTsNCj4gLQ0KPiArCQlmcHJpbnRmKHN0ZGVyciwgIkZhaWxlZCB0byBvcGVuIGJp
dCBtYXNrIGZpbGUgJyVzJzogJXNcbiIsDQo+ICsJCQlmaWxlbmFtZSwgc3RyZXJyb3IoZXJybm8p
KTsNCj4gIAkJcmV0dXJuIC0xOw0KPiAgCX0NCj4gLQlpZiAoZnNjYW5mKGZwLCAiJXMiLCBjYm1f
bWFzaykgPD0gMCkgew0KPiAtCQlwZXJyb3IoIkNvdWxkIG5vdCBnZXQgbWF4IGNibV9tYXNrIik7
DQo+ICsNCj4gKwlpZiAoZnNjYW5mKGZwLCAiJWx4IiwgbWFzaykgPD0gMCkgew0KPiArCQlmcHJp
bnRmKHN0ZGVyciwgIkNvdWxkIG5vdCByZWFkIGJpdCBtYXNrIGZpbGUgJyVzJzogJXNcbiIsDQo+
ICsJCQlmaWxlbmFtZSwgc3RyZXJyb3IoZXJybm8pKTsNCj4gIAkJZmNsb3NlKGZwKTsNCj4gDQo+
ICAJCXJldHVybiAtMTsNCj4gQEAgLTIxOSw2ICsyMTgsMzEgQEAgaW50IGdldF9jYm1fbWFzayhj
aGFyICpjYWNoZV90eXBlLCBjaGFyDQo+ICpjYm1fbWFzaykNCj4gIAlyZXR1cm4gMDsNCj4gIH0N
Cj4gDQo+ICsvKg0KPiArICogZ2V0X2NibV9iaXRzIC0gR2V0IG51bWJlciBvZiBiaXRzIGluIGNi
bSBtYXNrDQpJcyBpdCBnZXRfY2JtX21hc2s/DQoNCkJlc3QgcmVnYXJkcywNClNoYW9wZW5nIFRB
Tg0KDQo+ICsgKiBAY2FjaGVfdHlwZToJCUNhY2hlIGxldmVsIEwyL0wzDQo+ICsgKiBAbWFzazoJ
CWNibV9tYXNrIHJldHVybmVkIGFzIHVuc2lnbmVkIGxvbmcNCj4gKyAqDQo+ICsgKiBSZXR1cm46
ID0gMCBvbiBzdWNjZXNzLCA8IDAgb24gZmFpbHVyZS4NCj4gKyAqLw0KPiAraW50IGdldF9jYm1f
bWFzayhjaGFyICpjYWNoZV90eXBlLCB1bnNpZ25lZCBsb25nICptYXNrKSB7DQo+ICsJY2hhciBj
Ym1fbWFza19wYXRoWzEwMjRdOw0KPiArCWludCByZXQ7DQo+ICsNCj4gKwlpZiAoIWNhY2hlX3R5
cGUpDQo+ICsJCXJldHVybiAtMTsNCj4gKw0KPiArCXNucHJpbnRmKGNibV9tYXNrX3BhdGgsIHNp
emVvZihjYm1fbWFza19wYXRoKSwNCj4gIiVzLyVzL2NibV9tYXNrIiwNCj4gKwkJIElORk9fUEFU
SCwgY2FjaGVfdHlwZSk7DQo+ICsNCj4gKwlyZXQgPSBnZXRfYml0X21hc2soY2JtX21hc2tfcGF0
aCwgbWFzayk7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIC0xOw0KPiArDQo+ICsJcmV0dXJu
IDA7DQo+ICt9DQo+ICsNCj4gIC8qDQo+ICAgKiBnZXRfY29yZV9zaWJsaW5nIC0gR2V0IHNpYmxp
bmcgY29yZSBpZCBmcm9tIHRoZSBzYW1lIHNvY2tldCBmb3IgZ2l2ZW4gQ1BVDQo+ICAgKiBAY3B1
X25vOglDUFUgbnVtYmVyDQo+IC0tDQo+IDIuMzAuMg0KDQo=
