Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA779759785
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 15:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjGSN5c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 09:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjGSN53 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 09:57:29 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A041BF5;
        Wed, 19 Jul 2023 06:57:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yrtmbe4o94yrI2Sly2digJt5GyCs28ixFN3WwlHLOGFDBUZWU+5j5SFfadkh1KOEUUUQh9NzSHMA3kQYN+czX4Fi0xB7aLKJ8BQ4Pm74xStK8GTsxnTphrcMitHtRJ8LY8RoLqcjMEWabkehXoCdIzK+5OrWp7NgQVx6IHveG/Bi/YFbsjC7sQ+RgDImuBAqAr064Eqq4n+rr+ShBbyfTFFAiwCjpi9gZ5FgHgudhf213v0C9xDPkB+8yIOaCkRmd6Z1RFGYkSAqSUxSvMCYT8nK8Cx62pKc7k1AFsTXwhstiUu2VIIihnzn6ww0AXRqGoTl+c+C+5Ik4lJSaMguVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxpO4bcWuo1MgkT2NiTuTmmshEYXt3etyzvEDEnQDdc=;
 b=KXeFyAMV53etekt76F0m6VpNOdd1g2qhclpP5r0ePB7caO7VdWrbcizTWRXfhpQfzssJJNKLdhhDM6ZvFIbHuYojL8p1A8D1YlVZ38FTyD3JSTC8PI2yom9/f7RvugFHoOwcLWy6Wui1IuPCKWrE38xbVqBthrmV+itP+b5GTddsLf2e9+62XTprBFOJzbX1TmPvMaIbwRKBDXLaDxdKODFAJ2b3X8+44nA4d85Qu1hZwsDnRViQbA08b0XaOGHVSJ0CzxNvsOI8IaBYWgfpnvlypcg0r25gWjXxOiDc5MaKzQwObERsTe68akodF8lV6/Ks5MS9L85SEFLRcUaE0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxpO4bcWuo1MgkT2NiTuTmmshEYXt3etyzvEDEnQDdc=;
 b=M/QqG0RHUJ0mOgTGuSUhQwrO5g7m+/dfWUcagmAqyOqQlmhpJI5dA45PJBFk4u7q+Q7fMBmDZ4wbAf0H13Jz6TLvbzAP7NTBAgI1y/YFf9/7D+BwV/3jP9je3eX/tR+cibAK5YwZyHORiQdSUnQMRyNnH0CNyidkruDnflHqgaycatSn+YOc2q33gwD8rWw5JeE78nEWcYqile9KYhMCGn9Ks6A5y2cPBpc6YBFG801Htk7hvo95fc60ZtwWs/feCgzg7xjT73uUkqBSFCEM9VLBe0TFGZ7YK14L0DWh89L1nieKqBWcXdI4fxl7EBb4nU7zcmqMCmpd1+rS8s7qSw==
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by SJ0PR12MB6687.namprd12.prod.outlook.com (2603:10b6:a03:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 13:57:22 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::982f:232b:f4af:29ec]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::982f:232b:f4af:29ec%5]) with mapi id 15.20.6609.022; Wed, 19 Jul 2023
 13:57:22 +0000
From:   Benjamin Poirier <bpoirier@nvidia.com>
To:     David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 3/4] nexthop: Do not return invalid nexthop object
 during multipath selection
Thread-Topic: [PATCH net-next v2 3/4] nexthop: Do not return invalid nexthop
 object during multipath selection
Thread-Index: Adm6SPCTjLnm6ZDF2UuYdzGvm4mP9w==
Date:   Wed, 19 Jul 2023 13:57:22 +0000
Message-ID: <20230719-nh_select-v2-3-04383e89f868@nvidia.com>
References: <20230719-nh_select-v2-0-04383e89f868@nvidia.com>
In-Reply-To: <20230719-nh_select-v2-0-04383e89f868@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXP288CA0028.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::40) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
x-mailer: b4 0.12.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4373:EE_|SJ0PR12MB6687:EE_
x-ms-office365-filtering-correlation-id: 1b305924-6441-45d3-f67b-08db88601311
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9SrbSJxm0ffRrFOZu2eWUcL5lVO6wXLc73ytkiYB+nmL874YjRJh0J7BmDRlYwY3JgaxdgeQgOdGhzqBrEWpks0SJKR0SwQoorAW5tS8G+qUdyxDX7HJ2SSfYDOPaKRcNTxAxLhyo/1FEnNgs8O8jjWODd8deMLbs7u2MWcOBmOzhZ/w7lpDelrOaKt+fxypL9Wh3C6HmtLve8EIHlTFZQGxxctZfXXlP6DR6XWk1GPq3kIbrpt4IfV8VIQUpuDhx+jKMok3rtj1n/qCNONsqUemS32NSCBnllyTXoQ7rNJI/RMMiNMjgRnReIm07Bzx5f7mJzeuapAheonhepFrNOg4+jgvePasOEtTVYRGOggxfBySciPMz/7cOGeU0nSbs2pwzpWw6dJeXtAPKi/UhbozSDZYIqr2ahbFV3tLzG5vEWyKI8Ye8+9yQPraox0HUiyq3gdBQd0/fl5BjFV8GqDs6eahfTjVN1wE9h2XDWm6FlO4moLiCz78c5R9zFfQod8qLUHIjwbz56QQB7lF/mOXZKaQcjyf2Xu3qQo+c+KTZO3jWYW4Cur8aVwj3v5Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(71200400001)(107886003)(38100700002)(122000001)(2906002)(6512007)(6486002)(2616005)(83380400001)(36756003)(186003)(6506007)(26005)(86362001)(64756008)(478600001)(4326008)(66446008)(41300700001)(8936002)(8676002)(54906003)(110136005)(66556008)(66476007)(316002)(66946007)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnhrOEZtU0k4eGIwYkJ0eGJ4WGM5blJuRkwyMUh2ZWhZK1plYzQwVU9STzlD?=
 =?utf-8?B?MFcrcXQ5WEhEN0ZHVlN2NE12aFpSdWdNU3V4N1BhOFlIeFJxaWpreVFLVXIw?=
 =?utf-8?B?d1Q2Z0dlRFFWSldTMGZRbTFWOWttL3JvNlZvN2oyZDcxVW5tZG9FZ3BaTER6?=
 =?utf-8?B?MUNYYTlBd1d6ZE1OR3YxbHRXQjZrcDBhQUlsZWM0ZnNod2RYRDczSVVQbG56?=
 =?utf-8?B?aU9XbGRCU3hOTnk2NVowQThHajlwS1h1Y2NQMXBLTkZubm45YzhYTmVFejRh?=
 =?utf-8?B?RVRxSTFuRTdkdVV6a2o5ekZjUG9RWDdaZW9zQ1JkL3E2cFdsenZobXUzQmpH?=
 =?utf-8?B?V2UrZ0wzbE91ZWFqN2VYdWNRNWxrbGRydjVUKytWN0N1MTB4bUVYbm9xaXNN?=
 =?utf-8?B?NlJ6QW44R1I5WmpuZ2sxVFoxUkJvTUNJbloxSjRWbC93TDhXM2dHZDcrM1k3?=
 =?utf-8?B?dGlRMlNmenp5Y1ZWb1lHc1dVYzV6MzFxNmNOUWtFTHVNL0lpRTh1NEVCelQ4?=
 =?utf-8?B?dU03T0dKS0EwQ0NQTDd1NHJDN2V1YXRaREkvUEFDT2I0d3g4N09nWlYyQ3gx?=
 =?utf-8?B?bk9ydU8zQ3JyQVlEdjkzVUVRbVpZblgwWUVlMXh2VzRPUk5hcStIR3QvbWpM?=
 =?utf-8?B?VTQ2VVhLY2syb2hyeWp5ZThqbVVMRkN6bC9ZYzNyR3p2YmJoMXlPeUplMlFn?=
 =?utf-8?B?YW1NdVE0YnpDZElwc0YwK1V0eHdhNVcvdzRVb0ZlTk4yZ0ZpUkFuMkpEZEE5?=
 =?utf-8?B?dG9oNk5JZmlZNGRsVEFEZkE3bWNJdG9pWnhQbmtvdzBSbXpTQklxSzVlMkVS?=
 =?utf-8?B?M05Zbzc1dnVlRWlqNkFPMFRGQVVDUHNBa3ZtZ1phekZUQlI0L2I1bEhNN2xv?=
 =?utf-8?B?Z205dTNpQ3h4N01rMFZ1ZVlCdEUvSHpjc1ExbEQ3eFFkVlgrMTBybDNla1Fi?=
 =?utf-8?B?dHpYOEU1aVVmVXdsaERyUGtXZ2Qyb1l3S0JKV2Q4SkYyNUczNEFRV2h2NFht?=
 =?utf-8?B?OXB0eFJQY2ZOTVlWejd3Nno0MDNDSmJrNmhOU282VE4vQkNOZkpUdkliWFV0?=
 =?utf-8?B?NHhHQ1FZcUo3bTAwc1gvZDJyMVgwRFM5UkxWSnlVNmR5K1FqNU9sVllyU1gx?=
 =?utf-8?B?cU5jaWxyV3I0djluMXJYSlJnaThhdFZCRWdxMXpwVjhyV29qNWZDOFY5cU1y?=
 =?utf-8?B?T1NSMDlOSU0rQzM1dFppYjZrTnVZc3dLZ0lCYW9nZHBLS3VHbzlUNUhLejNt?=
 =?utf-8?B?bG1reTh0eWwybkQzL1EyV1l5aGp4cGh2UGdkcXg2SEhBc014RjRkdDhsR3cz?=
 =?utf-8?B?ejFPNXFiVzU4VGZCT3I4cWF1OU5WRVpIdXdYS3BuRTZHUkRvdmhLOWVXMXYx?=
 =?utf-8?B?N0dEVlM1T09OWjVJTVIxQ1BlbStlNnV0SHJhZk1OeXRkN2xnRkRucldiMWRZ?=
 =?utf-8?B?M2hHUG0xUEo0cXZqYUJzOEpDamE4MnZrd1cvSkN3bUp1S29vOVF6emNxYTFk?=
 =?utf-8?B?dWpWdmp4NU9vTlI4OTJLL0UzczhHOTdBTUhhRUlUL3pLcms2THJUby90bDdD?=
 =?utf-8?B?cUlSTWVIM20wNDR5UnlhK25qZ0pja0UrdTl2dnI3Vms1a3JsQUxsMTRTMnFM?=
 =?utf-8?B?VDR1Y2NZYTZFUGNtRkRXUytSVDg1SFowdnFVcGxDNklCRG9vc2tlUVVDUGhT?=
 =?utf-8?B?b2lqenRNU0Q0azBXQ1B6TlBZdjF2MkpQT0VCOEdHNElNTE1wQXBZU20wcms2?=
 =?utf-8?B?Sk9YOW5QY1JRcGFmc0NUZWcwTEhnM3Y1T21RQkVsamVFVkE3cXY2Rkx0VzhZ?=
 =?utf-8?B?Z1JZR3hIdVU3NnhXQStpd0NMWGN0VEcvWEk5ejBHSE5kQTlkUS9vamFqUkhE?=
 =?utf-8?B?Y2RqdWE1dFFmODdIV0dRUW9DTko2M3BpMXgvUG05MmJwWnRSQmtqR0R5WG85?=
 =?utf-8?B?YlRUemI5VFBSV01JOVY1YUl0REhsVXZMd2wwYVdHMjZ0TlRNQ0szcVAyWnJI?=
 =?utf-8?B?emZQRDJTZm5BOUlsU0FyZ2I4alZBeGY1UDdZQzl4aytpbkRqS2cyOSt1UlNQ?=
 =?utf-8?B?VjBUTFRENGY4RVlyd2VWdE4xOUlheUc2S1FCZkZLZ1hGdjN1eS9kL2RPNFZD?=
 =?utf-8?Q?Jx5z4XGGvn11slyk90C4F656s?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6E6BEB94A864A498B608021B0B12A1D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b305924-6441-45d3-f67b-08db88601311
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 13:57:22.1009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CFRE29vqlxDz3Z86gHnSe3hJ4JNyZ37NqhkAjrkUcg7ckagKEYODgck26oEOoKRFL3Y+SEYWaW7P2B+13M7aQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6687
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

V2l0aCBsZWdhY3kgbmV4dGhvcHMsIHdoZW4gbmV0LmlwdjQuZmliX211bHRpcGF0aF91c2VfbmVp
Z2ggaXMgc2V0LA0KZmliX3NlbGVjdF9tdWx0aXBhdGgoKSB3aWxsIG5ldmVyIHNldCByZXMtPm5o
YyB0byBhIG5leHRob3AgdGhhdCBpcyBub3QNCmdvb2QgKGFzIHBlciBmaWJfZ29vZF9uaCgpKS4g
T1RPSCwgd2l0aCBuZXh0aG9wIG9iamVjdHMsDQpuZXh0aG9wX3NlbGVjdF9wYXRoX2h0aHIoKSBt
YXkgcmV0dXJuIGEgbmV4dGhvcCB0aGF0IGZhaWxlZCB0aGUNCm5leHRob3BfaXNfZ29vZF9uaCgp
IHRlc3QgZXZlbiBpZiB0aGVyZSB3YXMgb25lIHRoYXQgcGFzc2VkLiBSZWZhY3Rvcg0KbmV4dGhv
cF9zZWxlY3RfcGF0aF9odGhyKCkgdG8gZm9sbG93IGEgc2VsZWN0aW9uIGxvZ2ljIG1vcmUgc2lt
aWxhciB0bw0KZmliX3NlbGVjdF9tdWx0aXBhdGgoKS4NCg0KVGhlIGlzc3VlIGNhbiBiZSBkZW1v
bnN0cmF0ZWQgd2l0aCB0aGUgZm9sbG93aW5nIHNlcXVlbmNlIG9mIGNvbW1hbmRzLiBUaGUNCmZp
cnN0IGJsb2NrIHNob3dzIHRoYXQgdGhpbmdzIHdvcmsgYXMgZXhwZWN0ZWQgd2l0aCBsZWdhY3kg
bmV4dGhvcHMuIFRoZQ0KbGFzdCBzZXF1ZW5jZSBvZiBgaXAgcm91IGdldGAgaW4gdGhlIHNlY29u
ZCBibG9jayBzaG93cyB0aGUgcHJvYmxlbSBjYXNlIC0NCnNvbWUgcm91dGVzIHN0aWxsIHVzZSB0
aGUgLjIgbmV4dGhvcC4NCg0Kc3lzY3RsIG5ldC5pcHY0LmZpYl9tdWx0aXBhdGhfdXNlX25laWdo
PTENCmlwIGxpbmsgYWRkIGR1bW15MSB1cCB0eXBlIGR1bW15DQppcCByb3UgYWRkIDE5OC41MS4x
MDAuMC8yNCBuZXh0aG9wIHZpYSAxOTIuMC4yLjEgZGV2IGR1bW15MSBvbmxpbmsgbmV4dGhvcCB2
aWEgMTkyLjAuMi4yIGRldiBkdW1teTEgb25saW5rDQpmb3IgaSBpbiB7MTAuLjE5fTsgZG8gaXAg
LW8gcm91IGdldCAxOTguNTEuMTAwLiRpOyBkb25lDQppcCBuZWlnaCBhZGQgMTkyLjAuMi4xIGRl
diBkdW1teTEgbnVkIGZhaWxlZA0KZWNobyAiLjEgZmFpbGVkOiIgICMgcmVzdWx0cyBzaG91bGQg
bm90IHVzZSAuMQ0KZm9yIGkgaW4gezEwLi4xOX07IGRvIGlwIC1vIHJvdSBnZXQgMTk4LjUxLjEw
MC4kaTsgZG9uZQ0KaXAgbmVpZ2ggZGVsIDE5Mi4wLjIuMSBkZXYgZHVtbXkxDQppcCBuZWlnaCBh
ZGQgMTkyLjAuMi4yIGRldiBkdW1teTEgbnVkIGZhaWxlZA0KZWNobyAiLjIgZmFpbGVkOiIgICMg
cmVzdWx0cyBzaG91bGQgbm90IHVzZSAuMg0KZm9yIGkgaW4gezEwLi4xOX07IGRvIGlwIC1vIHJv
dSBnZXQgMTk4LjUxLjEwMC4kaTsgZG9uZQ0KaXAgbGluayBkZWwgZHVtbXkxDQoNCmlwIGxpbmsg
YWRkIGR1bW15MSB1cCB0eXBlIGR1bW15DQppcCBuZXh0aG9wIGFkZCBpZCAxIHZpYSAxOTIuMC4y
LjEgZGV2IGR1bW15MSBvbmxpbmsNCmlwIG5leHRob3AgYWRkIGlkIDIgdmlhIDE5Mi4wLjIuMiBk
ZXYgZHVtbXkxIG9ubGluaw0KaXAgbmV4dGhvcCBhZGQgaWQgMTAwMSBncm91cCAxLzINCmlwIHJv
dSBhZGQgMTk4LjUxLjEwMC4wLzI0IG5oaWQgMTAwMQ0KZm9yIGkgaW4gezEwLi4xOX07IGRvIGlw
IC1vIHJvdSBnZXQgMTk4LjUxLjEwMC4kaTsgZG9uZQ0KaXAgbmVpZ2ggYWRkIDE5Mi4wLjIuMSBk
ZXYgZHVtbXkxIG51ZCBmYWlsZWQNCmVjaG8gIi4xIGZhaWxlZDoiICAjIHJlc3VsdHMgc2hvdWxk
IG5vdCB1c2UgLjENCmZvciBpIGluIHsxMC4uMTl9OyBkbyBpcCAtbyByb3UgZ2V0IDE5OC41MS4x
MDAuJGk7IGRvbmUNCmlwIG5laWdoIGRlbCAxOTIuMC4yLjEgZGV2IGR1bW15MQ0KaXAgbmVpZ2gg
YWRkIDE5Mi4wLjIuMiBkZXYgZHVtbXkxIG51ZCBmYWlsZWQNCmVjaG8gIi4yIGZhaWxlZDoiICAj
IHJlc3VsdHMgc2hvdWxkIG5vdCB1c2UgLjINCmZvciBpIGluIHsxMC4uMTl9OyBkbyBpcCAtbyBy
b3UgZ2V0IDE5OC41MS4xMDAuJGk7IGRvbmUNCmlwIGxpbmsgZGVsIGR1bW15MQ0KDQpTaWduZWQt
b2ZmLWJ5OiBJZG8gU2NoaW1tZWwgPGlkb3NjaEBudmlkaWEuY29tPg0KU2lnbmVkLW9mZi1ieTog
QmVuamFtaW4gUG9pcmllciA8YnBvaXJpZXJAbnZpZGlhLmNvbT4NCi0tLQ0KIG5ldC9pcHY0L25l
eHRob3AuYyB8IDE0ICsrKysrKysrLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9u
cygrKSwgNiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL25ldC9pcHY0L25leHRob3AuYyBi
L25ldC9pcHY0L25leHRob3AuYw0KaW5kZXggYzEyYWNiZjM5NjU5Li45M2YxNGQzOWZlZjYgMTAw
NjQ0DQotLS0gYS9uZXQvaXB2NC9uZXh0aG9wLmMNCisrKyBiL25ldC9pcHY0L25leHRob3AuYw0K
QEAgLTExOTQsMjAgKzExOTQsMjIgQEAgc3RhdGljIHN0cnVjdCBuZXh0aG9wICpuZXh0aG9wX3Nl
bGVjdF9wYXRoX2h0aHIoc3RydWN0IG5oX2dyb3VwICpuaGcsIGludCBoYXNoKQ0KIAlmb3IgKGkg
PSAwOyBpIDwgbmhnLT5udW1fbmg7ICsraSkgew0KIAkJc3RydWN0IG5oX2dycF9lbnRyeSAqbmhn
ZSA9ICZuaGctPm5oX2VudHJpZXNbaV07DQogDQotCQlpZiAoaGFzaCA+IGF0b21pY19yZWFkKCZu
aGdlLT5odGhyLnVwcGVyX2JvdW5kKSkNCi0JCQljb250aW51ZTsNCi0NCiAJCS8qIG5leHRob3Bz
IGFsd2F5cyBjaGVjayBpZiBpdCBpcyBnb29kIGFuZCBkb2VzDQogCQkgKiBub3QgcmVseSBvbiBh
IHN5c2N0bCBmb3IgdGhpcyBiZWhhdmlvcg0KIAkJICovDQotCQlpZiAobmV4dGhvcF9pc19nb29k
X25oKG5oZ2UtPm5oKSkNCi0JCQlyZXR1cm4gbmhnZS0+bmg7DQorCQlpZiAoIW5leHRob3BfaXNf
Z29vZF9uaChuaGdlLT5uaCkpDQorCQkJY29udGludWU7DQogDQogCQlpZiAoIXJjKQ0KIAkJCXJj
ID0gbmhnZS0+bmg7DQorDQorCQlpZiAoaGFzaCA+IGF0b21pY19yZWFkKCZuaGdlLT5odGhyLnVw
cGVyX2JvdW5kKSkNCisJCQljb250aW51ZTsNCisNCisJCXJldHVybiBuaGdlLT5uaDsNCiAJfQ0K
IA0KLQlyZXR1cm4gcmM7DQorCXJldHVybiByYyA/IDogbmhnLT5uaF9lbnRyaWVzWzBdLm5oOw0K
IH0NCiANCiBzdGF0aWMgc3RydWN0IG5leHRob3AgKm5leHRob3Bfc2VsZWN0X3BhdGhfcmVzKHN0
cnVjdCBuaF9ncm91cCAqbmhnLCBpbnQgaGFzaCkNCg0KLS0gDQoyLjQwLjENCg0K
