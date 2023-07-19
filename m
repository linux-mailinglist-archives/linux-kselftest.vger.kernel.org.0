Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECD5759780
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 15:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjGSN5P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 09:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjGSN5O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 09:57:14 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8760912C;
        Wed, 19 Jul 2023 06:57:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I62xG8eX7qsyxlAsn7pH+uR8Y9LLdWY7b9HEG7yKKwo1a1EmZyJHJ3Y2QizASdSbS9KrGQNK+uYMOQAfnEQ3yCVTau2ifBssMFuN74CjmmYPH4X3FHRzRRCNyYPZVbhLPbhPPcjSSdLgqhv0J3quXwhm04foP+cdRi3TvRlquxPPCkclGrjyiJLkXAl0IL0LYqYEDmE4JkD0R4RbehbBKzKlCIOynMn5FOgtbGlgVsdZIV0NOGtiOu8URqBymEELIY4kURANuLbFJO7Ktu/EVCJcdf2XnWbZyN8ZhLgmXXlGXSnFrorrFjx1ar4GGSYSjA2JDiyYCgf0pDWG0rW+hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUeV8oIuvHrSih9x/1pXMDjhs4xpnIKANIY1SsSmAiE=;
 b=mE0BwpAAqQHjPAr5cHA2rmlGpav2jvYayl1CW84ozB0KsOuZbFAcMNTGk9TNRU4F1Fy8aQVhnWijWWc37TsxLs71n4a9LuEna09kJ29pX0WxNhXGK6Zzj6JiR7rrBvWc8Y7O1MWTahX/ocWtXu4CWAdkDry3XpzZft3mH/ymtH9q6sw1xWkiBGvqwuqiRseF4tYvthT5gY9zfpWvTIl65doImMeBZgF+KW2I7OyNXM4netzk0Qm7+wOtjGbcB2nTJE4J1+7xwIC6qBidW315JKCWwk5QHdWKnyhV9f6IuULL8z+p+l4lvE0wwqaTuBPZLB9/hbOUQElbZzr1eFa0qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUeV8oIuvHrSih9x/1pXMDjhs4xpnIKANIY1SsSmAiE=;
 b=aUiWmK2/wyWjNwxBqRm+mVkC69aYaM5QzZKfJ2I7tFoJ0/xoI59ZalAWTa3eIK3Sdg4DOyr1AKd4JN7uqLhMWpCkd5nhkjKNNx5U1vhBZQVhe7InWenDj8p4DSsR16dz+gmWNqIKdNuXlXWASuU7dQX3M0ETiZ1Zpc9Faz50mDukHLMRehGeoYlzsxJimuK7v+sRJ7H2I5vdtTauNU63VNJbgLjvWXkZXV8Y/BO1/HW1iQtzpAf/iyqcEcgACPxdwAnJDWJzg/NU4giqQNy4+obenMb9u7/mNBc0N2uMuD/rvks2+7S2/FcrNpXNA4OLk+iivtPd1oKlIkizS0vTPQ==
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by SA1PR12MB6994.namprd12.prod.outlook.com (2603:10b6:806:24d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 13:57:11 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::982f:232b:f4af:29ec]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::982f:232b:f4af:29ec%5]) with mapi id 15.20.6609.022; Wed, 19 Jul 2023
 13:57:11 +0000
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
Subject: [PATCH net-next v2 1/4] nexthop: Factor out hash threshold fdb
 nexthop selection
Thread-Topic: [PATCH net-next v2 1/4] nexthop: Factor out hash threshold fdb
 nexthop selection
Thread-Index: Adm6SOo2pRJ1b9JTe0qaFpcgHytNCA==
Date:   Wed, 19 Jul 2023 13:57:11 +0000
Message-ID: <20230719-nh_select-v2-1-04383e89f868@nvidia.com>
References: <20230719-nh_select-v2-0-04383e89f868@nvidia.com>
In-Reply-To: <20230719-nh_select-v2-0-04383e89f868@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::11) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
x-mailer: b4 0.12.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4373:EE_|SA1PR12MB6994:EE_
x-ms-office365-filtering-correlation-id: 0179fdf1-1668-4f01-79d8-08db88600cb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wbZ2KqZq0jkWSbxmd2wET4D2USkpHJ0X7keB/s4+Boo7TVRtRbZ/Ve8b/1PPG2bff+XRaqo0QOxunpQBHnYNLlj/QMbkzlOQAkmVkdMpFn7qIZ/GlnsWy9+hOtJoL9zHPNwfj6OtyBUBdL964J//JG/dYlgu0kzarfLKlDn+3LvadTENXS4eQ3ZN0Xy0/pARBiCYt52onele1lVxIuZEwesTU85R+2k6DzVU7AbOsh5Deg+oKJioJO50bn6nImoSbU/VhW52xm6GCel5T2C5jP4h7LYff7Am/HB8wlJQmSD1+Cj+Cuf/sDEIq9JBVWw2scwCCd6iwdNbZN5dGo6as9HmTjS9G0cZn++0elo8oH4LZFYXpFcQyg1mvLFn5WjeNbhQ3stV6ObrMRGnPnH1LshIkLf9cpyba6jMYfSZwAH20u0/oIiIcvJuf2x5qhzGhoVTTu82wQPHUTwGOtNwPFeNBOId1VglGjY0IPkKa4DFuAehtOF9lvu5lRd7B3364bQAjTMWMrGCC/60WoR0LieQeKLB2SmeklbwSBIH32CzNTas7wX5cJh4EQgYJm/K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199021)(316002)(41300700001)(66476007)(64756008)(4326008)(66946007)(66446008)(66556008)(5660300002)(8676002)(8936002)(2616005)(83380400001)(86362001)(38100700002)(122000001)(186003)(26005)(6486002)(36756003)(6512007)(6506007)(107886003)(110136005)(54906003)(478600001)(71200400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWhvYUNheTFKdXdvRWd3ZnUzMDdpQWJNcmZGS3FMQXNMVHhFMm9QM1hFclVR?=
 =?utf-8?B?cXhMSlJoUlkzdXM4dTJEYTkxeVIxM1NTaEJnZlA5ZUJJTHlOV0dUd24zWmY5?=
 =?utf-8?B?V25tL0xrdHFPVkxUekNTTXNqVDRTOWhNT01lK0w2UnJDUEtQZGx1NDNhcnR5?=
 =?utf-8?B?NWQxTG40cGM2dEpsbEpMM2xCU1YwUkNvaG5JVHhRelJyNUF2TkErYktZK0pE?=
 =?utf-8?B?d1RSaFc4RFZUY205M3hFVXV2Wmx6bXpQWkUwVzdaeUtxTkUvQnJzNmRSOVlP?=
 =?utf-8?B?cFBHMXR6M2NoamlXM1ZJTnZrUGg5YlBkL0V1MHV2WlIvejZBS2NJYS9WM3Ri?=
 =?utf-8?B?Y0JxK2NxQ2FYbjd6RnJUL0k5NjNjeW4rT000MDlhTUZxM2dHM2d4ZU4vdWNk?=
 =?utf-8?B?WVVOMWdlQ0ZXcHlLWUc4MGVPUGRZWnlKSjRaN2k1bjVzaUVSbzNDd015aU9C?=
 =?utf-8?B?QTJsUVlCY0tsSVVhK0RzMEtlM1FJa2xkczUwR3FQK285U1V3N05XdUErc1BQ?=
 =?utf-8?B?UnBEWnk5aEFKU0UySzZ5dllQUU1IcjR3QmVSYTcvZ0VJcGE4WVNuK2JUVXph?=
 =?utf-8?B?aUNaaDhTbWZ3YVlwQ2xYTUxTZWw0MU5QTHlyK25HNlRoTEJzVTBnU3FNRFRh?=
 =?utf-8?B?cE9vQ0E5NGo0VVZzanY0SWRGeE03QkN5TmFvdzBaMC81emtEODBydzhBdUEv?=
 =?utf-8?B?ajFPd0ZiSHVCcHdsOXhvSElHRGJqWFphc2JlM1pjc2syNkI4cUZjWGhvWW4x?=
 =?utf-8?B?eXFVN1cwTzFNN2h3eUlTVWlBZCt2TlBkQzNJbDkweHA3MStBN1U5NllHMDJN?=
 =?utf-8?B?N1FaOUhrUldRSE5lT1lUcStRbXRDaDJtSXZBc3ZPZGxaRC9sa3o3YVlNaG5h?=
 =?utf-8?B?NVNFM2dxeGxsd0dwRE9qeVd5enlVYlcrZmlwbC9zQ2UxUkMrbEpLNE8yNEJH?=
 =?utf-8?B?RFFKZ2xsYVNqN2JtOVBZbnVkeUZBZ2poV3QwR3R6SlNMUTRHb2U2SHcrbHN6?=
 =?utf-8?B?M2V2ek5MV3BNV1ZyYmxLMUUzSUsxMitzci9JZ0ZQZnpPTjVQdTdNdW9qS2Zw?=
 =?utf-8?B?cnFGRU1EaHQyazVycE9kcmtnRldTOGxwUWwwWEl4Q0EzaGZwM3RSY0V4NVhi?=
 =?utf-8?B?Ry9lSkhqY0FEZTc0anBjeXc3R1RRL2VTcERua3VKWFI5ak0wNXpnL1o4dEJN?=
 =?utf-8?B?bHRwdWdaY1dSaE1wMkswUTV5Yzd6aUhaUlh3bitCM0FMUXZxN0dNSmVSTkg4?=
 =?utf-8?B?UVBSbi92b2FMQXE1cmJFMFhiQ0ZEeE9oQ2o1UHJjRVhuN2gydm1Bd3FsekdS?=
 =?utf-8?B?YmhEbGVyeGJPR0lwWWZJOVNkWmxGQ3FDbXVLVjJlOVMrTDVTWU1JQjNKdUZ2?=
 =?utf-8?B?WHY5R29tUVM1Qzh6WklkMGN2dEY4ZTJMQTRrTVJwcDNDUDUwWHRIaSt3SFhQ?=
 =?utf-8?B?cXJodngrNzlMSGp4ckUxV2t2ajVlbmRUUmhhNEJEUnhBMkFpT3pPTHR2SnBL?=
 =?utf-8?B?QjlWelo2TDJkeUZOd2I1ek81QmZBZnM5aUVQOVdxVnE0SWttT2N5WHdjT1FG?=
 =?utf-8?B?cUFHV0RRbFlUVDVxMGVEUmZIVjAzTDNvVmg4R095UjMxamtUbjNmMEgrTnZR?=
 =?utf-8?B?czgrY2dYRTlwMlBJZjhvQiszZVo2Z2x3dm00Rk5HaVFqd29lQjVtWVJmWjRm?=
 =?utf-8?B?OXlEbkY3czhpbGJPb3VQcDhqa1BQV3ozQk0xR0lqNmp4OGJaaDQwMmNCTlg2?=
 =?utf-8?B?alpOSXRRRXA1N0lpNCsrM0tMT2F3cGxlV0hPYUpWTnJPUUp1cDJmMEhCMExV?=
 =?utf-8?B?Q3B2TnpDZG1PVG5Cd1BIU0RaclJsSWFUR3hKdGFoK2FDRVZpa3RFSUlydVRC?=
 =?utf-8?B?RUkvenJCbnpCcjVaMU5VMG5qWHJtWHdiazhMbDNybXR1RzduMkluOVl6RUE0?=
 =?utf-8?B?NGhhaHZDZGF0eHpxZWlLeXVubVlXd0JQeG53ZUM2Nk1naEFRRUlIQmZOTXlT?=
 =?utf-8?B?SHk3dWpLTURWMDBVS2hZay9iZnRnMHltdCtVbjBtTnlYeGZqazg3ejBBSHQ0?=
 =?utf-8?B?MHJkYmtXa1lxRjEzaGZCUzkvaEdRY1B6S3FabzdkMCs3eDBrYUxhaUY4QTBF?=
 =?utf-8?Q?iJ4Qkq91i2Zwh5LkB6gvZTKJY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3226475388E5084BB5AAC618C3FD29AA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0179fdf1-1668-4f01-79d8-08db88600cb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 13:57:11.4082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rcJb5PL7M9me788VnfNIwydHdacLzuF7J/dmujJ0sJ1vpOmfZVCwHMgY+Z+GfxKXrrKaQJkKiGtnzgTuEejmfA==
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

VGhlIGxvb3AgaW4gbmV4dGhvcF9zZWxlY3RfcGF0aF9odGhyKCkgaW5jbHVkZXMgY29kZSB0byBj
aGVjayBmb3IgbmVpZ2hib3INCnZhbGlkaXR5LiBTaW5jZSB0aGlzIGRvZXMgbm90IGFwcGx5IHRv
IGZkYiBuZXh0aG9wcywgc2ltcGxpZnkgdGhlIGxvb3AgYnkNCm1vdmluZyB0aGUgZmRiIG5leHRo
b3Agc2VsZWN0aW9uIHRvIGl0cyBvd24gZnVuY3Rpb24uDQoNClNpZ25lZC1vZmYtYnk6IElkbyBT
Y2hpbW1lbCA8aWRvc2NoQG52aWRpYS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBQb2ly
aWVyIDxicG9pcmllckBudmlkaWEuY29tPg0KUmV2aWV3ZWQtYnk6IERhdmlkIEFoZXJuIDxkc2Fo
ZXJuQGtlcm5lbC5vcmc+DQotLS0NCiBuZXQvaXB2NC9uZXh0aG9wLmMgfCAyMiArKysrKysrKysr
KysrKysrKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9uZXQvaXB2NC9uZXh0aG9wLmMgYi9uZXQvaXB2NC9uZXh0
aG9wLmMNCmluZGV4IGY5NTE0MmU1NmRhMC4uMjcwODlkZWEwZWQwIDEwMDY0NA0KLS0tIGEvbmV0
L2lwdjQvbmV4dGhvcC5jDQorKysgYi9uZXQvaXB2NC9uZXh0aG9wLmMNCkBAIC0xMTUyLDExICsx
MTUyLDMxIEBAIHN0YXRpYyBib29sIGlwdjRfZ29vZF9uaChjb25zdCBzdHJ1Y3QgZmliX25oICpu
aCkNCiAJcmV0dXJuICEhKHN0YXRlICYgTlVEX1ZBTElEKTsNCiB9DQogDQorc3RhdGljIHN0cnVj
dCBuZXh0aG9wICpuZXh0aG9wX3NlbGVjdF9wYXRoX2ZkYihzdHJ1Y3QgbmhfZ3JvdXAgKm5oZywg
aW50IGhhc2gpDQorew0KKwlpbnQgaTsNCisNCisJZm9yIChpID0gMDsgaSA8IG5oZy0+bnVtX25o
OyBpKyspIHsNCisJCXN0cnVjdCBuaF9ncnBfZW50cnkgKm5oZ2UgPSAmbmhnLT5uaF9lbnRyaWVz
W2ldOw0KKw0KKwkJaWYgKGhhc2ggPiBhdG9taWNfcmVhZCgmbmhnZS0+aHRoci51cHBlcl9ib3Vu
ZCkpDQorCQkJY29udGludWU7DQorDQorCQlyZXR1cm4gbmhnZS0+bmg7DQorCX0NCisNCisJV0FS
Tl9PTl9PTkNFKDEpOw0KKwlyZXR1cm4gTlVMTDsNCit9DQorDQogc3RhdGljIHN0cnVjdCBuZXh0
aG9wICpuZXh0aG9wX3NlbGVjdF9wYXRoX2h0aHIoc3RydWN0IG5oX2dyb3VwICpuaGcsIGludCBo
YXNoKQ0KIHsNCiAJc3RydWN0IG5leHRob3AgKnJjID0gTlVMTDsNCiAJaW50IGk7DQogDQorCWlm
IChuaGctPmZkYl9uaCkNCisJCXJldHVybiBuZXh0aG9wX3NlbGVjdF9wYXRoX2ZkYihuaGcsIGhh
c2gpOw0KKw0KIAlmb3IgKGkgPSAwOyBpIDwgbmhnLT5udW1fbmg7ICsraSkgew0KIAkJc3RydWN0
IG5oX2dycF9lbnRyeSAqbmhnZSA9ICZuaGctPm5oX2VudHJpZXNbaV07DQogCQlzdHJ1Y3Qgbmhf
aW5mbyAqbmhpOw0KQEAgLTExNjUsOCArMTE4NSw2IEBAIHN0YXRpYyBzdHJ1Y3QgbmV4dGhvcCAq
bmV4dGhvcF9zZWxlY3RfcGF0aF9odGhyKHN0cnVjdCBuaF9ncm91cCAqbmhnLCBpbnQgaGFzaCkN
CiAJCQljb250aW51ZTsNCiANCiAJCW5oaSA9IHJjdV9kZXJlZmVyZW5jZShuaGdlLT5uaC0+bmhf
aW5mbyk7DQotCQlpZiAobmhpLT5mZGJfbmgpDQotCQkJcmV0dXJuIG5oZ2UtPm5oOw0KIA0KIAkJ
LyogbmV4dGhvcHMgYWx3YXlzIGNoZWNrIGlmIGl0IGlzIGdvb2QgYW5kIGRvZXMNCiAJCSAqIG5v
dCByZWx5IG9uIGEgc3lzY3RsIGZvciB0aGlzIGJlaGF2aW9yDQoNCi0tIA0KMi40MC4xDQoNCg==
