Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DBC75977D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 15:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjGSN5M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 09:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjGSN5K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 09:57:10 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB4C1A6;
        Wed, 19 Jul 2023 06:57:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnUlXwuxVS0BfATw9o2pvUNbmYczuWaBVCVnN1A5DGqxep/go+xyLREf7tbVAYgI/liYEuwcgEx5Mi4xbYjT0EN4YjOe8W3Qh4MHuuLX2OGumVAeM11ULHTlXu8T55glNGFOae8ylsDp7jCNDR0E9kaAXjLmyqz/T3iCszfLEWa0TZBaNnxbcXaa1xWc80PY7GKADk5oThKnwhGLzm7wsr+AgLzXqk6D8QVK2Z4YGa6H4erxTKPOZhc+8mzyGTQpCwM0EvsscdgPNai7v3CtUoC1iqol8QPvoLOPrZgzFbHS9ldNVokxq2f+CTgoLVqGKv7CiUvPSnO2Z5Vmid7Exw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8qym46ezgNLckAquWwjj52z0sAT/TNeBm2ZDzAWXwA=;
 b=QkxXmsSD4Jh59QEOPdBg5oEXxx3nmyO9IRWNw77XKwvXzmJFMFSC6eLiy9t/PDE/QPoxLgihhc7dWQzN4LC8u3eCoxPyPDBzRMK2YHhI+rhprRAhWjEaYs4lZ6NIQNcyT/xvbKYadMHPLFoggTLvb2pUkC0fR3wBGr5juoSAP6F4Pgw3fxdW9R7K/jUnnizqyr82FGOzZiCJURsXBB9v0ql3WG38PsphPxt/GQ0xCnZYnVfhZ2+27ivnfzDCjG8DDLB/2sikmwGWX9zdKaUUxKmv01ZIopF5Ae7XUiJqJgaYJiKPAsfW6EtjGAnMOhzkGnp6fePxm4GkHiE08MfNqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8qym46ezgNLckAquWwjj52z0sAT/TNeBm2ZDzAWXwA=;
 b=AEFDbI2lVGto4iHG+vNu0qGvTf/Dzfy1j15yq1oQj/KR3vM8sFJTc48S2WBe+HurS1mvkl8jhFNAKM9nMHABpsjhJa6BIeTC0UCx5FnEDqabh4+ts2uNo3LthA3D4OB4psnBxlHWcL7UPq23K1vYSxqTZQnGZ0YfcKy04pJRRJLlJsO6tig2u/cku9J27GdO3by7fX2tG+8uXC1J2B0NnJjCn1gKnz8H9YnBofj0SmGymMa8avcjqkHjMu8nY/7ZBQUmXBRL8AR2o9+14JpNU6TqY4qED3VCrzzLjWpMQS+7GTmCdakpfa1zaFVzWTdOirfkagk0a0988eq/RLpPkA==
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by SA1PR12MB6994.namprd12.prod.outlook.com (2603:10b6:806:24d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 13:57:06 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::982f:232b:f4af:29ec]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::982f:232b:f4af:29ec%5]) with mapi id 15.20.6609.022; Wed, 19 Jul 2023
 13:57:06 +0000
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
Subject: [PATCH net-next v2 0/4] nexthop: Refactor and fix nexthop selection
 for multipath routes
Thread-Topic: [PATCH net-next v2 0/4] nexthop: Refactor and fix nexthop
 selection for multipath routes
Thread-Index: Adm6SOcQ1ibIthrqHEOswUMI1khpHA==
Date:   Wed, 19 Jul 2023 13:57:06 +0000
Message-ID: <20230719-nh_select-v2-0-04383e89f868@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::15) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
x-mailer: b4 0.12.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4373:EE_|SA1PR12MB6994:EE_
x-ms-office365-filtering-correlation-id: 1fea5227-692a-40d9-0004-08db88600989
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sKAJbf0fUoZVHbqO2hk3a/IN/I3RhpJI210Ms06RumzMZf+tNaHWkocQrCLz2VzcdpJuMT2DYCEzf9A/ZAvUd4eRk5ydLCBbPXjUXu8UxbJRZum+HNv1vJfn2D1+/1bVAKny4LH2/bq33RTjCjjE8hPCbhAAhVWXRNAO8zbExRf3BI+1lXpQXhJARSvj6amdrUf2dmPrz6Au32NPhe+1Vivevo/h97PdSU0SX/TVJ3vPfO7TJ/8KLLgNWe9XWG86ldB4pxEcHMqhfzosfSir17879oYKnu90IodogOyfqyj2wuybMHwSocW6HaFNnHR9jdef0FbB52DM1HW3LMnQPAgLxg40/U8Nt+kt3bi/irb6ZDpVbCcezL9MbQO1VQOcUTwHc4qjYDZy/D99ZMUsXeeQdUsucm2NYFr1R9U7D8kPfFxmlgt+R8XlPp+NrVS+kGx1A2is1pqCCLD05/zIrR/xAQ2WhTqVr0tfXe7kcDWI8BkrF+QDUDpFUAnrq4bwLGdtz3y9qQIT+AQc4P11ZVymHPtY1u6WxYYdqlyCz031MOqwbmzIhGiR193g1JhivDeWhB8iwYR6EWAP09ouJdhvL8+zKRxqjv5jckDb9kE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199021)(316002)(41300700001)(66476007)(64756008)(4326008)(66946007)(66446008)(66556008)(5660300002)(8676002)(8936002)(2616005)(83380400001)(86362001)(38100700002)(122000001)(186003)(26005)(966005)(6486002)(36756003)(6512007)(6506007)(107886003)(110136005)(54906003)(478600001)(71200400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TldPSU14azc2UFg2NVZGNDBybGZEdFNjYkl0TDkySlorSC84UGgxZEE0QTBy?=
 =?utf-8?B?WHV5QTliOExwbC9ERHlQdFhwRUc4ZEhsYXNLTjdFQjQwMFN4WE90Z0owenc2?=
 =?utf-8?B?dmgvRlpnM3NTNlIzbnZUTmY0dUc3akZIek5FQ1lMbG40VE5UMzU2TjFXYnBQ?=
 =?utf-8?B?N2JkS1hPcnQyY2d2dWUwVEF3QWF5U0xaa1FmZTdIYUtqbExFVHhUa282d25u?=
 =?utf-8?B?WEhuNHZ6OGNlcEg5VlJoYmFDRlY3WmxqQU9nME4vRi9oSHBIcVhEVkhidjRr?=
 =?utf-8?B?RmVYbll0KytTZHhmSUlRL0JGcVlpcmdNQjdJR3ZzZzFYSnVvZkx2UlQ4NnlW?=
 =?utf-8?B?eGdsRnNjQmxKWkJlZHpPaXE2cDY1MTV3WklGT092U01wZU1tMTA3bGpSWksz?=
 =?utf-8?B?c2dsRnUrYmZLSHJaQWFLbW9RMGd1UDMvVGtLUm9TWDlGbGx1Qm9xcDhlMXdG?=
 =?utf-8?B?Y092bDVOUlc0a2VSQnh0QXhxK3ZHNUx3dHR3aHVsQW1aeFEwT0RFc3dIQWlj?=
 =?utf-8?B?SmpUNWVZRHlDdXFFU1BnQm43UXFXZ3JJbDdrU3BOZ2ErdlpXRWdwaWNQUTdu?=
 =?utf-8?B?cHB3c2NVVDhOYmg5R1gyRkFHSDNBaGsxN1k1TC9lRGZlU2libS9ZV1d1eVZs?=
 =?utf-8?B?Uk9LMEdVOFlwL2NHYlMreUhrVG1aOGhXSzUxV2l1bUpZL2R1UTlrVy9DTVBv?=
 =?utf-8?B?dEduUE5lOWZJQjNWSlhzTTdDSWY0TFJwSDBDbnJyZTRJd2NiRzFkZnpJb2VS?=
 =?utf-8?B?V0ZDY0F5ZHJxNVpIZnBnNnBBQVJmSWtrMzMvNkl5L0xjQVAyd240RUV2d2ps?=
 =?utf-8?B?Q3JiR0h2V3h5WVZUdXhTU0d4b0VKYXd4L29ZaTg1OFh4VXM1K1U3Uzd1Qm9E?=
 =?utf-8?B?ZnJVUy9mVzBHdGF1eG41cVJRZjk3WEhlMDNTcmZ1Yzk2Y0Mwd3FQY3F6K3k2?=
 =?utf-8?B?RUwxY29UZ3QydHdkcExBOENTb3JkYzlSR1FwNlNxa256Skwrd3ZIUjlWeHNh?=
 =?utf-8?B?ZWZYazMrSzNVSDQ1WnRLUk1tSVFOU1V5eG5VVHJRUENxSFUzbFRGR1E4eGpB?=
 =?utf-8?B?OU5qTHhuM3FOelFackRMdU5QR0Q2a1h5a2J3cjRmZEVYWmhuTlFISDdqazJq?=
 =?utf-8?B?SkQzRTQwUUd5VU45NTdmZCtycUt0elhvSkgwR0tnb2wvUkpRek8yZ1VvMnRR?=
 =?utf-8?B?YnI5NEpXQlcvb3JxNThrOStYenRYWXN1ZzdHYVhCRlZhMUduNGF5M3pQMmdO?=
 =?utf-8?B?dUx2cFphK3lSSUdMY3dlVXp5cENUWFJhTWJaVGo0dTY0MEVsY0VJVkJLdGdC?=
 =?utf-8?B?c0pVNVZ3NVp4Tlp3TDNHZnU5WlhLU1JwV0pEdHBIWWhyY3l2OU9GcUJVdXls?=
 =?utf-8?B?YlhHOE9na3VQMFVuQW1kRFg0UHI2Zmp3eUpqaDZSYkkrYTE1eVJON2pWTkc2?=
 =?utf-8?B?d1BwRk1xTm5uREwycml3d0U4MUpFNlZrajJVYjd0emI1YTRLN1NNQmk2c2w4?=
 =?utf-8?B?M1BISDJwVkJ5eFJNa1JoempvU3NDRnJCdmdJQ0ZaUkFPazV6T2R5d0NwNExI?=
 =?utf-8?B?WHRtbXRlUVhzdTBWMmQ5YUdPeXRLODd5QUhJaFN6WC9JVlg1OWNhWVFCNFYv?=
 =?utf-8?B?WERYNlhmUHFuY2xuTE9GeGxrekFkblJnRlFjRXFJOTllUzBianhEQ0dXcmRj?=
 =?utf-8?B?M0JCcEEwdi9TSEpWL2l4Ry9hd0lYTTd5MCsxWDVqTGorVXg3ZE9LNmJVL3Nt?=
 =?utf-8?B?TndJWTBTVW5VUGZiTzdMYlJiVW1aVXlnY1VvNDVXZTVhNkt5SzdVT20vUUZz?=
 =?utf-8?B?b0p5SWJ1Wm1WS25nUjlJS3l5TDkvRXBVYkQ1Y1premZBVXR2NVJ6bzJENXEx?=
 =?utf-8?B?VjNjM0lzYm1nY0FxOSttdzdqRXNONE41bkg4Mkd5Y2hhTXZBZ2FCbndSV1lq?=
 =?utf-8?B?L3UrSnZDazZKZzRScnVjcmM5RG5MQVdxR01jL2EvSG93N0tBT3lrOElNUXl1?=
 =?utf-8?B?eDZyY0FDNTBNRVF6N0x2TGpjSjhrUG5pWnZjU2ZtdDNvQ1VodEEzdnZ1WXJu?=
 =?utf-8?B?K09CYlZqU0N6SDlPUGdpZ2VUTUw4dDRvaFVjWUMrbzJvMjlQbmp3U0c0d1Nr?=
 =?utf-8?Q?NrZ/ZhLCEKHZ/AfQccR/4bv6a?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E9D4BB7EE706245B6BA73BAA5750378@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fea5227-692a-40d9-0004-08db88600989
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 13:57:06.1225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2fEl6yldKqbnGaKyqmAHdj+K3iDJ4gSGsfr7EdlhgaL1mF1dJro4S+qnmZ4FtScMND6DB8c7dxtND9dNGK6yLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6994
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

SW4gb3JkZXIgdG8gc2VsZWN0IGEgbmV4dGhvcCBmb3IgbXVsdGlwYXRoIHJvdXRlcywgZmliX3Nl
bGVjdF9tdWx0aXBhdGgoKQ0KaXMgdXNlZCB3aXRoIGxlZ2FjeSBuZXh0aG9wcyBhbmQgbmV4dGhv
cF9zZWxlY3RfcGF0aF9odGhyKCkgaXMgdXNlZCB3aXRoDQpuZXh0aG9wIG9iamVjdHMuIFRob3Nl
IHR3byBmdW5jdGlvbnMgcGVyZm9ybSBhIHZhbGlkaXR5IHRlc3Qgb24gdGhlDQpuZWlnaGJvciBy
ZWxhdGVkIHRvIGVhY2ggbmV4dGhvcCBidXQgdGhlaXIgbG9naWMgaXMgc3RydWN0dXJlZCBkaWZm
ZXJlbnRseS4NClRoaXMgY2F1c2VzIGEgZGl2ZXJnZW5jZSBpbiBiZWhhdmlvciBhbmQgbmV4dGhv
cF9zZWxlY3RfcGF0aF9odGhyKCkgbWF5DQpyZXR1cm4gYSBuZXh0aG9wIHRoYXQgZmFpbGVkIHRo
ZSBuZWlnaGJvciB2YWxpZGl0eSB0ZXN0IGV2ZW4gaWYgdGhlcmUgd2FzDQpvbmUgdGhhdCBwYXNz
ZWQuDQoNClJlZmFjdG9yIG5leHRob3Bfc2VsZWN0X3BhdGhfaHRocigpIHRvIG1ha2UgaXQgbW9y
ZSBzaW1pbGFyIHRvDQpmaWJfc2VsZWN0X211bHRpcGF0aCgpIGFuZCBmaXggdGhlIHByb2JsZW0g
bWVudGlvbmVkIGFib3ZlLg0KDQp2MjoNClJlbW92ZWQgdW5uZWNlc3NhcnkgImZpcnN0IiB2YXJp
YWJsZSBpbiAibmV4dGhvcDogRG8gbm90IHJldHVybiBpbnZhbGlkDQpuZXh0aG9wIG9iamVjdCBk
dXJpbmcgbXVsdGlwYXRoIHNlbGVjdGlvbiIuDQoNCnYxOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbmV0ZGV2LzIwMjMwNTI5MjAxOTE0LjY5ODI4LTEtYnBvaXJpZXJAbnZpZGlhLmNvbS8NCg0K
LS0tDQpCZW5qYW1pbiBQb2lyaWVyICg0KToNCiAgICAgIG5leHRob3A6IEZhY3RvciBvdXQgaGFz
aCB0aHJlc2hvbGQgZmRiIG5leHRob3Agc2VsZWN0aW9uDQogICAgICBuZXh0aG9wOiBGYWN0b3Ig
b3V0IG5laWdoYm9yIHZhbGlkaXR5IGNoZWNrDQogICAgICBuZXh0aG9wOiBEbyBub3QgcmV0dXJu
IGludmFsaWQgbmV4dGhvcCBvYmplY3QgZHVyaW5nIG11bHRpcGF0aCBzZWxlY3Rpb24NCiAgICAg
IHNlbGZ0ZXN0czogbmV0OiBBZGQgdGVzdCBjYXNlcyBmb3IgbmV4dGhvcCBncm91cHMgd2l0aCBp
bnZhbGlkIG5laWdoYm9ycw0KDQogbmV0L2lwdjQvbmV4dGhvcC5jICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICA2MSArKysrKysrKystLS0tDQogdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0
L2ZpYl9uZXh0aG9wcy5zaCB8IDEyOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogMiBm
aWxlcyBjaGFuZ2VkLCAxNzEgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pDQotLS0NCmJh
c2UtY29tbWl0OiAzNjM5NWIyZWZlOTA1NjUwY2QxNzlkNjc0MTFmZmVlM2I3NzAyNjhiDQpjaGFu
Z2UtaWQ6IDIwMjMwNzE5LW5oX3NlbGVjdC0wMzAzZDU1YTFmYjANCg0KQmVzdCByZWdhcmRzLA0K
LS0gDQpCZW5qYW1pbiBQb2lyaWVyIDxicG9pcmllckBudmlkaWEuY29tPg0KDQo=
