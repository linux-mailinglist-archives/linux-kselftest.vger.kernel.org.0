Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7034C3FBA
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 09:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbiBYIEY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 03:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiBYIEX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 03:04:23 -0500
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D67E1BB720;
        Fri, 25 Feb 2022 00:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1645776232; x=1677312232;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qle+JTbwW6vfRfq29Jwvv8JmrEotnniW0pOlFm9KQfw=;
  b=Z1jwSSu8879xC6PPzeWXCGZ4JmteZZ9BK4WKaGPbAKhNIDFF/T6PdHIw
   8OphSY6rs56z42QGiaVIxQRJ2NkIHYtQ3yE7C3nNusz/iljCpVks+iVV/
   IyGDYsShm5QHomO1bGrccWujfYd5BB7MeUj/758u7Dto2hhDUhfe80BFu
   nrL7sm3rWiCIX6SWUnNHZAU9ZSh66svhmg9bq13UkdqgD2hYaYKZ1Jl9C
   +4uXuEHlpcE5D4SJyASxK1Y+9Jr/zf3C0dizUGC6GvmqgpBf+RZo1Gk0L
   mpiA+K7gAJjsaodBkEXJVqXt3oHSW7+FOaKcBVX0UYYoHHMEztYC2XJSz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="50294931"
X-IronPort-AV: E=Sophos;i="5.90,135,1643641200"; 
   d="scan'208";a="50294931"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 17:03:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/Y7EmmfE/qjd8/Eypg6ZZ61doIP5UOOUzCI9qdtc85B/c3cE+FSLCzv/tRvUo85CBHAe238ny8dQ2AIk61g0CsolEp+mQuB/6cpq4LBMyu5j8zUAKQmBnA2NngQoeoYpInM5YeHGEUVsF628VSw2AXzNI/KR29nJ7CrC9dIkfKvlbi8p9PcI/GX7evu5XauJT4UDiLoAAohYhK8jtbLiuAHXHc9QaCldVW54m/N1kIEepb9ixskq4LgspzkbZujivIWbadP2C13fmOv2NLY7uuF4GvY3Nbgo7S6eXm0B+gj6+bfBTUwIBNF07+naJsVC6mGZnzEB14+xLnE79a8uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlfFO9j1qaM59jsS8lK3mkMkfL/Nu85+e28Rke8AQ+o=;
 b=BAqxkoyS2NrlqVrLrcrn+WEy7ydO3pKlDa8DpC4DI5YO2X6Xtl7LxT8QRpCzISoam5BP+NIaj/PMBGrfhA/XExFidhxXcnOyx6MWJwYz9WraB7QxcB3CsUIWRY2sPeEfVLFtmcdCDivNauYBA6HLI/LMiZe8++djXUkpSDrHkMzbpVz8WOrb4Qd8KyUOjyp40Op1IcHXc3Em9ZkhZQJYGNK1aKD1TqoSjg/BYOSKES7JjUxaXbzdl6QgYgXprcVTkaKt9EtFhAbDMIbRNDTmmSdN3uqnBvty2CaX2sAH0reFMRkYeZBxsowDzWsd4bhd2jiT/jnYV0vlyfGKftYIdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlfFO9j1qaM59jsS8lK3mkMkfL/Nu85+e28Rke8AQ+o=;
 b=kb1ZzsBg6IBcB44iF1yEZoO7S7X7jAN2sUeqMfO+uVcNDDVPT3Khxm6UNmhYPgwmC1d5ith1Vt2e0AvlrhA04KJcDvwjK6NqwgUcGe1jEgFwIG5nKgdcSRbTC+JbXtkWizvCHzBVvU2CeO9H47KMxs74UxQ/6IwhIW2sRssWZ10=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYCPR01MB6687.jpnprd01.prod.outlook.com (2603:1096:400:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Fri, 25 Feb
 2022 08:03:44 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::bddf:b81c:fc55:3bbb]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::bddf:b81c:fc55:3bbb%8]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 08:03:44 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Shuah Khan' <skhan@linuxfoundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v3 0/5] selftests/resctrl: Add resctrl_tests into
 kselftest set
Thread-Topic: [PATCH v3 0/5] selftests/resctrl: Add resctrl_tests into
 kselftest set
Thread-Index: AQHYItzO2ercakXqEUeObD27CshNzKyZytSAgAoqjVA=
Date:   Fri, 25 Feb 2022 08:03:44 +0000
Message-ID: <TYAPR01MB63306F67590849B0354D8FB78B3E9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20220216022641.2998318-1-tan.shaopeng@jp.fujitsu.com>
 <d9f81a0f-5f25-9304-fdca-fc164224a786@linuxfoundation.org>
In-Reply-To: <d9f81a0f-5f25-9304-fdca-fc164224a786@linuxfoundation.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-02-25T07:59:03Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=933e9bb7-a2a4-4928-83db-35d5ce3dac4c;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 911de4eb-44fc-460c-103f-08d9f8355803
x-ms-traffictypediagnostic: TYCPR01MB6687:EE_
x-microsoft-antispam-prvs: <TYCPR01MB66872940A86E589FD32786408B3E9@TYCPR01MB6687.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vbYp4e/wdOnVZAuBf/n8KyFQxESNAoHAScPn+PLckzlREPLaDwpgw9EpjtxpYYGlDOiE01CFHT0c3kKkDM+Y7i/wqPo6Loj43OBuXGrhp7wmrmVE/zNk7eNrM0GYIIwD5hpOIdBNcpCQp3vFLnAjPg/ZaeeQs/iIxkrx/2hv6Rwa0dT/1Vz4Z3xn62QcxJ/Gmm/NnMVDJs/B6NGCqHKjpG1R3pS1ryp/vyHTKY3Q/OL1CxQWWmSJGzxYuEhMc9x4vKbaFygVaTb30hW+hgauu9JJVBs3qkz6ybtKCCb+glgaRrQWCd1pZvrR37QnoU6Vl73/7oEWe4UwK6GGGpPIONSHUSZZb1h9t3X72nJMSQXEm2Yq23HMc2jg8Owam+2oNdPJDkl3pH2phpGbA8cFZM8wbutaqI5R2WkL/4n1CCd/yw3xwYLwp2YtviEf8zJY7u0fqGYI4ZBcemL/3TumTBu8X2+hZ5YJDd6eakv4ml/ezayenhG0cS5C5SWBDGb0xN6kwyIzCdYUR3l2VjMVSfgm3lMsBeJVQxM/5K778cHGrlHcnC61mqZPLaRZ+6J/FxuMrM6cinGE1yoTUPtwmJNTUo/A7zER9bs1DNuUq4lJuJksmaY5WJ2n1yRe0O1J97c6rMkUQqROq/z06wC+3BQfVWb+ZOenKCi5wyrFsfzDMsvDE4zqg3uEHmn4mZkTHNljToE7pOyk02H05anvzZxiWu3c3Q9tPPSdw4MaZ0DnaHWstyvFXGHt8uoUfw3jI40Wtv7OrUOLFL4/7RGzO4sfdnTJK0MElJA+0W7z51Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(76116006)(83380400001)(85182001)(7696005)(6506007)(4326008)(66446008)(2906002)(82960400001)(64756008)(122000001)(55016003)(8676002)(66476007)(66556008)(9686003)(5660300002)(38100700002)(54906003)(316002)(508600001)(52536014)(26005)(8936002)(186003)(966005)(33656002)(53546011)(110136005)(86362001)(38070700005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?dkhYZHlNMTBsbmxId3pzTFExVUhMQXlIVm1oaStHL0ovaDBGa2lSd0RK?=
 =?iso-2022-jp?B?Qk81ZGxVdTJueFVNcUgzVklpdEZFRnlaNzBFL25FbVc0SUVNSzIzSkdD?=
 =?iso-2022-jp?B?bDVwa2NtcmdiMkZ4WjRuOXR0SkIwYVlNY0g5V0l2dXF0MER2SmczZkxp?=
 =?iso-2022-jp?B?NE52NFRBNWhtOCtqbGUwc2NFR1ZSdHhRNzZONFpFYmlwUDBPeStZQzFi?=
 =?iso-2022-jp?B?VE1Yem5IWkU4NC9mUXl6YWxYUFROenQwRXN2Qzl6RGM3ZHRtV1U1OEg0?=
 =?iso-2022-jp?B?WVFNdENpc0I4bmlRd01UNVlHZ3VUOGZVOENGNDJJM004R0luVUx4TTJp?=
 =?iso-2022-jp?B?a0lRWFF2aW9rSnk5M0F4S1FPMnp1SlNVYVlBNktYbzdOMkNibHhId3Uv?=
 =?iso-2022-jp?B?UG9ubWZ5TUhQcEh0Z294L21STlBrQVZwbEY4MjBSSi9IUDh1M3U2aVhr?=
 =?iso-2022-jp?B?bU9Qcnd6ZkFoWUVMWkFjWGRNZXdKUlk4MnMzNk9GWnlQc1NNOVFLOE1E?=
 =?iso-2022-jp?B?ZFNxNEREMDhTa05yZjhIYWE1d1VoUkZaNGNsem80WTNKYkltbndLdTlK?=
 =?iso-2022-jp?B?WDl5ZWd4UVR6Y1N4NHV5UmM3YnZuNkFDeEJZYUUrcjArNDE0TFZiaGQr?=
 =?iso-2022-jp?B?TzVjY09NV0JmME1ra2FGeVBMKzBSKzdqWnQyN1I3U3AzNzdhMXMxU2R2?=
 =?iso-2022-jp?B?UDZtYVk0TkgvaEI3dGt4YUZBQWNHbHAxcUFJMzN2RDgzY3Avb21vcVJy?=
 =?iso-2022-jp?B?WXBaaVZPYllwTVF0UlZkUVZtRHY3cDVGSkZMNzRFcXZQVXQvRFFIaWFn?=
 =?iso-2022-jp?B?MzdNdkptaUd5K01MSytqMWNqMXlpSXBCeWRQVzcrenpGWDNGVjlvRmRP?=
 =?iso-2022-jp?B?Um9iV0hVZ3AyUklSUHBRMm1OOVlBT1NUajlrS2x0em50NkFXakZRc2Qz?=
 =?iso-2022-jp?B?UmVUcUZZTmVZYXc3QnBVVHNCZ2M5SjI0bEJuYkdLVHdvdnR4Qzhwb3VV?=
 =?iso-2022-jp?B?enhJS2lFTW9mNnZkM21lMm1qeXJDTm1yczdmbUxGOHlrbk9xWjlaQjU2?=
 =?iso-2022-jp?B?SFdwUjRXZnhtbUQxZTMydTFKbzFnU2l1bHVPbXBVdUFvQXF3dXRHdzFt?=
 =?iso-2022-jp?B?YUJHVTlNZUY3YWhmd1NkUnI0UnlINWJjMVNKSmdZN1JxQ1ptY0ZqTlp0?=
 =?iso-2022-jp?B?WE5CeEN4NlJ5SndtZzNzMC92VXMwMGkzcTVBRHlBRHZTbFcvQUxGUWQ5?=
 =?iso-2022-jp?B?WS84VmQrUzRsMHc3ZWRFSkJPY0dJREszaHNxVjc1cGU4L083YkNDMWp1?=
 =?iso-2022-jp?B?aGR5S1VuSk1pRUMzODI2S3BkKzh0K2hjZU9NVXltN0ZneHZ2VXM0S0No?=
 =?iso-2022-jp?B?R0pFWXQvRUt5MVRVWFh5ZUszU3A1S1pZZ2dkYk1saUxCdzREbVJ4SVVi?=
 =?iso-2022-jp?B?bTBSckVGYktVV2Y5U08rMTBacmR4cW1WV3BkR28vQ0ZzY1FJQzlKRW1x?=
 =?iso-2022-jp?B?NlBFTzd4MDRxSFoxb2xsNWVIdGtpeENkY1ZoL1dKd08ySzc0NlB6NHEw?=
 =?iso-2022-jp?B?ajg3ZndrY0hEY1NDYlE2cXB0blhuSGRsQ1lScDNTZUtOVDNJL0FST0E5?=
 =?iso-2022-jp?B?RzQzcjlKMkFIbTJydVlLWlVCcU5EYllmQlFGS2d2N1RlbGd5Tlo3blAy?=
 =?iso-2022-jp?B?RFllT2dQWnE0WENKWXNPVzFpNEk2Wkt4YkhvSy9XL3h2ZFNDd0ZjNGZL?=
 =?iso-2022-jp?B?RUI1aDVrVzNxSVUyeGFSY2U1dEgvRGR3d3RoVVpRT2Y1Y05WKzZVbHJG?=
 =?iso-2022-jp?B?bXNkWDJnZDhSbm5YbGZLZlRaL3RkazhTM1dmQ3BhS3JldEk3R0RvSlVX?=
 =?iso-2022-jp?B?ckhhdTduU2d4ZnIyYThLQllkLzU3ZFRwVzhKVmN3bURFcWE5WkkzcG15?=
 =?iso-2022-jp?B?WG9LeDdEOEd0blhLbGphcHgxdTNwKytqQ1FyZjkwSnRnTWcwWDNnS0dL?=
 =?iso-2022-jp?B?VWFnbnNjb2oxd3ZCL3pkeDhWRnBUc25oZHRYd0hua0ozdElpdjBaTTlB?=
 =?iso-2022-jp?B?dHp3TzlCa2oxZG1yalhLaGdOSys0TVk0b09nTHROVWRuVEhzTlJmRGVO?=
 =?iso-2022-jp?B?VUlNcFNoZFE3elljdnp1ZGxHSjUxZHpPbWhSZWFKbUhqOUkxSWV4VFFr?=
 =?iso-2022-jp?B?TFRDMG9oTCswZnA4dUw2WXlZeXlCelRMUUdVeEhRaTJqTUVmUjRuWUp4?=
 =?iso-2022-jp?B?cVIrVkhFb1pxRUYzdVU2dHNtNlVWV0pRU3llSTA2ajF6Mm1mczByZ2Q0?=
 =?iso-2022-jp?B?RWs5aDNSaTN1b3dIRERmcC9GREUyeHRpRXBZVzhUMXBuQXhndVYvbWtK?=
 =?iso-2022-jp?B?RUovZVBMNkY3Z05sQjU0a3QyTm1MWEcwTDZaZitqaTJ2dXlsSEtoZlF3?=
 =?iso-2022-jp?B?Uzk1d1dnPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 911de4eb-44fc-460c-103f-08d9f8355803
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 08:03:44.2561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ASme2L0seSWqlDFK+S5Vu1xrk7johasTUCyvxFH5h3eY58ISYrxhyHDZ/HqYjA3TE15PcN+HeuW1tgYpbfohtXphRT8zB0qWTQMbC0FLXiM=
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

> On 2/15/22 7:26 PM, Shaopeng Tan wrote:
> > Hello,
> >
> > The aim of this series is to make resctrl_tests run by using kselftest
> > framework.
> > - I modify resctrl_test Makefile and kselftest Makefile,
> >    to enable build/run resctrl_tests by using kselftest framework.
> >    Of course, users can also build/run resctrl_tests without
> >    using framework as before.
> > - I change the default limited time for resctrl_tests to 120 seconds, t=
o
> >    ensure the resctrl_tests finish in limited time on different environ=
ments.
> > - When resctrl file system is not supported by environment or
> >    resctrl_tests is not run as root, return skip code of kselftest fram=
ework.
> > - If resctrl_tests does not finish in limited time, terminate it as
> >    same as executing ctrl+c that kills parent process and child process=
.
> >
> > Difference from v2:
> > - I reworte changelog of this patch series.
> > - I added how to use framework to run resctrl to README. [PATCH v3
> > 2/5]
> > - License has no dependencies on this patch series, I separated from it=
 this
> patch series to another patch.
> > https://lore.kernel.org/lkml/20211213100154.180599-1-tan.shaopeng@jp.f
> > ujitsu.com/
> >
> > With regard to the limited time, I think 120s is not a problem since
> > some tests have a longer timeout (e.g. net test is 300s). Please let me=
 know if
> this is wrong.
> >
> > Thanks,
> >
> > Shaopeng Tan (5):
> >    selftests/resctrl: Kill child process before parent process terminat=
es
> >      if SIGTERM is received
> >    selftests/resctrl: Make resctrl_tests run using kselftest framework
> >    selftests/resctrl: Update README about using kselftest framework to
> >      build/run resctrl_tests
> >    selftests/resctrl: Change the default limited time to 120 seconds
> >    selftests/resctrl: Fix resctrl_tests' return code to work with
> >      selftest framework
> >
> >   tools/testing/selftests/Makefile              |  1 +
> >   tools/testing/selftests/resctrl/Makefile      | 20 ++++-------
> >   tools/testing/selftests/resctrl/README        | 34
> +++++++++++++++++++
> >   .../testing/selftests/resctrl/resctrl_tests.c |  4 +--
> >   tools/testing/selftests/resctrl/resctrl_val.c |  1 +
> >   tools/testing/selftests/resctrl/settings      |  1 +
> >   6 files changed, 45 insertions(+), 16 deletions(-)
> >   create mode 100644 tools/testing/selftests/resctrl/settings
> >
>=20
> Reviewed the patches - patches 1/5, 4/5 & 5/5 don't depend on kselftest
> framework improvements. 2/5 and 3/5 are.
>=20
> Please reorder the patches - move 4/5 and 5/5 up and make 2/5 and 3/5 the
> last in this series. Also see comments on individual patches.

Ok, I will reorder all patches as follows, so that independent patches come=
 first
and Makefile related patches come last:
[PATCH 1/5] selftests/resctrl: Kill child process before parent process ter=
minates if SIGTERM is received
[PATCH 4/5] selftests/resctrl: Change the default limited time to 120 secon=
ds
[PATCH 5/5] selftests/resctrl: Fix resctrl_tests' return code to work with =
selftest framework
[PATCH 2/5] selftests/resctrl: Make resctrl_tests run using kselftest frame=
work
[PATCH 3/5] selftests/resctrl: Update README about using kselftest framewor=
k to build/run resctrl_tests
[PATCH] selftests/resctrl: Add missing SPDX license to Makefile

Please let me know if I'm wrong.

Best regards,
Tan Shaopeng
