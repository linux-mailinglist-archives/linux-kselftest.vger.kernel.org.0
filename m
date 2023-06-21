Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189DD7382F3
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 14:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjFULmc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 07:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjFULmb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 07:42:31 -0400
Received: from CO1PR02CU002.outbound.protection.outlook.com (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0384AE65;
        Wed, 21 Jun 2023 04:42:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjJepwppxBE1bO2kkVELfc3Za56QQTkWwsWKijSFLn4FLjWeAZuRqsKP3pZ7vE4rv7FZxLdSB27ew4RIUD7ZKKZHPSAvQPvtjKrxwKVJkBCzCeFGIVzXTycelT1WiMYc63c8zMvfqUlO6xbTRsvW5/kwczj6+o2BFGWf0MVeNj+5YTWbmz+0/u1K4DnxyW8VrDnJ50EXqS7MF3x9H3ygf5YLWRWYT2ZI0JNs9ISiCUiPExixV9F8+FpRiwPTOhGE55vDoGqwqv2LfEnLwKkec/mY/aK67UqVwve6DFQxysIeWVw0hyNfbIDE1CLUKTZN/Jo4L3s8ocVWlaWe1FF8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfJkaeeJ6CoE8s+WzwJyT1yFKe/6XhTuBtswDYKe1ok=;
 b=bBPQOE1juRrN4O3v8LOf209XW5X/POEdiujpnbxHgVf67cdDcSajYUai2V6ZDZR9wcyAvJhBgwRa8yOloiFjYhAq+R3AZFXyL7M6hxC6fqusOZsC19hY7B1joSIshuMtCIynXg9QrKUs0bgKsRj5wyEk/7Oiwpj4bCE+P7PLUd/TSbnY4OKAzNlMRmrjIL4n/ZKnx4KW2jMYHV20Njn6QpVdLy+Zl8Yz+NV/0D4rGfyuqaqSfCCe1HHTCxpBrBE3gCrDja67rVu4tCH5PeQXdeA1oeutov1UH/5+lH7FMzqjwueGxngQ2xNlKr9SSFiBsDtlRcdr0VP6weOcNiwqXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfJkaeeJ6CoE8s+WzwJyT1yFKe/6XhTuBtswDYKe1ok=;
 b=yegJAlyqP3SsfYGydBl5xd2kKgV70+ayI1z8tzza77hvyfnqzdK7nuyK+jebAdO51GnbEJTO58pdjBxoMKF6TXVcrUqLe9A/HSZgYGMtGVPK7qgh3Rr95wjLPhbdorCTntA68jY7VF4YaFQuTWzg31o5+ZeLCTP0jwgWks2KPbU=
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MW4PR05MB8748.namprd05.prod.outlook.com (2603:10b6:303:12b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 11:42:24 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::4f1a:ecac:2dab:7044]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::4f1a:ecac:2dab:7044%3]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 11:42:24 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Ching-lin Yu <chinglinyu@google.com>,
        Nadav Amit <namit@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Tapas Kundu <tkundu@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>
Subject: Re: [PATCH v3 00/10] tracing: introducing eventfs
Thread-Topic: [PATCH v3 00/10] tracing: introducing eventfs
Thread-Index: AQHZlGeSoCEyu7THQ0iKwxE3Uhr81a+Rt6wAgAIv+YCAAVpjgA==
Date:   Wed, 21 Jun 2023 11:42:24 +0000
Message-ID: <1C7D95B2-3DF0-43AB-8F8B-7D3F7AE7FC0D@vmware.com>
References: <1685610013-33478-1-git-send-email-akaher@vmware.com>
 <34E6364B-2B3D-4597-8143-1EEA645B6CDD@vmware.com>
 <20230620110227.6a944a19@gandalf.local.home>
In-Reply-To: <20230620110227.6a944a19@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR05MB8703:EE_|MW4PR05MB8748:EE_
x-ms-office365-filtering-correlation-id: 419292aa-2d0f-48f8-e5fd-08db724c94d9
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hzx0ebq6XCeoEgbriDSjEG6Bgk5BC6KwQdsZWMd1yv0CI9YGX5Vi+lVAcaCmQkaWKgQT1hciBEVh50h7lGyfgqLACgBOpgVXlRovsRTVXc/K6YMQ/J6i0/7A15MylDh+YCabhGSjQiUcrlknZI2qJLJeIHHcwEa3qhcipsWdnbPHsqXG5pmjphOhMzCzEs3V5J6JWT6SDpkMg4ccWwVBWaAhZZJkoUAYZcgxjHw5q4rgNz3OKZVN3SaV1nNTQr1Uy1P8L+DRjAnwVTkhovUxa9l547fGtpj6NAJu9IxvHIUg02JBtBb7H07NtDVvzlPx/6JFMg9V+p95s2m1cl997gtQXnUFlUSoh0GQJQgGYYVFTIPPBT2tC2a0nTJqq48+xuz8ohdmJGEMAh4/0NsQtwS7FEal7Cx6uJZ+XJykkWusHIpSM6dC495pqZBZzxEY5bCy4MauDHsQlN52C7kD9qjLoXls7LZn679a/JyvMK7trtL0ZudUK85dBRvrGw7FBRsS3hXOvq9blPtJCXcU56Po6xTNjjmoIHPrnig7tI/nKqazbK2Ym9OxB2ETrxYzGOY6fJxAtFSsOmjGIWmA0yOkAm7Oqmtgptr4lIRBImRJNDDSNBMF1k+htSgvHh26iEgP7SV/Hvn5QK0q/5cBFyo/qkNPfi7YV6ACWGkpvdWmI/O4jA0xA5IdwKbYeFc7PVpuDKb93yKCSZguyJ03wSigvHsE7isBlAPmEYW2TU0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199021)(76116006)(71200400001)(64756008)(66446008)(91956017)(66946007)(66556008)(66476007)(4326008)(6916009)(2616005)(186003)(122000001)(38100700002)(86362001)(38070700005)(26005)(6512007)(53546011)(6506007)(83380400001)(33656002)(36756003)(478600001)(966005)(6486002)(54906003)(8676002)(8936002)(5660300002)(2906002)(316002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?drgu7pXgjLKhXNJpvB/hf40CHqwg1r+KCpeBxankHwJqw9ihlVnawyboedz3?=
 =?us-ascii?Q?NSLm9ey/6Yi/dSflEJQGqDM2fNNIWpFrUdTBxwHUZdcJJLFc5O5i67vsYvgY?=
 =?us-ascii?Q?ZgNdd8hndgFOTwGUANbKp0UBwa1PVpVAzlDgelfaU4VOckJabGWRTfL/OlQY?=
 =?us-ascii?Q?rSWkOF2qwe2zrIHFCuHSHrQaAVgp4QYkIgXSS0yBqzjE32PGhxwiAPfFgwdL?=
 =?us-ascii?Q?87ZTWrUOfNpHx/8ntgbolnnKKj+/hXbq0ro5z6DWTKmyTDvOA2TLLPo9QBeW?=
 =?us-ascii?Q?QrnqqeNFjyeM0S/kzL9BMRV60xTsyz0KBS+cvQKvrKJiuHmahuh8ZUrwEPRb?=
 =?us-ascii?Q?vLBisa9S4CtsQpKR5HV/k0EJNeX7JT7qvKqsDFZB6a09J+s+8oyV03y9v4Dk?=
 =?us-ascii?Q?eLjTfrzhMRvyfHDk6Iy98cQOmKfkJs4zIwsbQ2MvbGg3ehZf/H2Jlngjsy8Y?=
 =?us-ascii?Q?CKE8StWuZU4eVd7zZ97kxE/qZT5LliFfg3DRqcoO8M2nYRlh2QA+qrUUfrpX?=
 =?us-ascii?Q?Jyal0UQTISZ7RCjqmunWThTyKi4H6IDL94/uu7deosd+Uxuuwvk/KZmJ7q29?=
 =?us-ascii?Q?dAT4m+QBwTT7yYicOeuibKZlLj3Z81kcSopwv40vATOnQM9IYJpdiO9A+PVO?=
 =?us-ascii?Q?iSiVf+2G2wI59oHhCTf0U/G/lga3vm5rvZ5hrbbNgP5uA9SiCVYprd3l2Hpx?=
 =?us-ascii?Q?LrFOWGJfxh/ZjLOaOHA/OOCooHhzGiPQldr7b+ObVHayBSNdhqaog3QXZ8oW?=
 =?us-ascii?Q?up1vRth9jwjUDFR4w2fFSFwgP3xO5O9nfTjQEJoo5K/UvSxKGyBY5IKa+mP0?=
 =?us-ascii?Q?h2fQCWxZX+dv/VbbYgDHJwRHacFQQZixFSZWs+aexaOdcVbqbOJc360KaaUZ?=
 =?us-ascii?Q?KtlgU2D6E/nr3/y3pL/SG2lhwPRz4frBxwwwhHJOpyJKlfxWUfKh+X9Zze3R?=
 =?us-ascii?Q?OpViMzadTrMIbgF9/ZKq972+1E1tRKystcDkdNyEfYWv6LbyXEN3cqxjuAXf?=
 =?us-ascii?Q?fxqyN7NT5j9lOtLDg5R1b6kc0FpjXEdEopYGC/GMfs4XQz9ObFW46BUi+Lpx?=
 =?us-ascii?Q?FpZq1ZIdK2EhEoup3CYp1BmzvrjLtoVmiMopTH+W6RxDBYzv2HNBZyW3VVZO?=
 =?us-ascii?Q?8CeJ0w6jhNOfY5q6T/vEoamuLLI3MG7fxjyTdPOGLwRUjyqHNJ8ZbgB5N/Y3?=
 =?us-ascii?Q?t57RRzzXkaKB6t4/tnwY5wBlIS5UJqFr47QHjWbZpuce9zxSTDnGdOWA8weY?=
 =?us-ascii?Q?4uDgjtzr0Wdp6au4C/KNwHA4JIxWYFyJo197c3q/J+KcqnJ1CBpadh+s4pW6?=
 =?us-ascii?Q?tVRxTjxx83R03pTcUxzrwhPhoHhxAqqxEQAN0WnWyIcinMOmJOIN8iqtN3Ck?=
 =?us-ascii?Q?wAwZFJZYIYIu3TinuxJJZqI/aR0hNf8xBIa+axrjIYbVAjF+c9imkObsJ1yo?=
 =?us-ascii?Q?J3er19XvDZbtEjbSOj7sbXEJ0qoJBjUco6to4i6Uv7MwUWG2vTZOch6JOA44?=
 =?us-ascii?Q?TCan+63K1m16vYrmRcPXyCMYb7g4TMf6zRZAGm5OftUhNNztTLXizLfaEk6W?=
 =?us-ascii?Q?7Fkmr9Ut643bODjbgbpshUPXK3QY04b9fYoi2GJy?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D8AFE35DE4DAF740A321E3D0ADFDF2CF@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 419292aa-2d0f-48f8-e5fd-08db724c94d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 11:42:24.3001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oZUZLYhQ8PT1ckj27D9l0NBx+BU2tjRMQYAbpSDpViNuHEKOaDHAtSSh11Nwv4UCzQP7d7gsKZtTcI/StCh9Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR05MB8748
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On 20-Jun-2023, at 8:32 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> !! External Email
>=20
> On Mon, 19 Jun 2023 05:38:25 +0000
> Ajay Kaher <akaher@vmware.com> wrote:
>=20
>> # of passed:  65
>> # of failed:  3
>=20
> Unrelated to your patches, but have you checked why these fail? Do you ha=
ve
> the latest tests running on the latest kernel?
>=20

Failed test got passed after enabling /proc/kallsyms, using:
echo 0  > /proc/sys/kernel/kptr_restrict

Following is the report of ftracetest on Linux v6.4.0-rc7 (with/without eve=
ntfs):
# of passed:  68
# of failed:  0
# of unresolved:  6
# of untested:  0
# of unsupported:  45
# of xfailed:  0
# of undefined(test bug):  0=20

If lockdep is enabled getting same warning as reported by 'kernel test robo=
t' for v3 09/10:
https://lore.kernel.org/all/1686640004-47546-1-git-send-email-akaher@vmware=
.com/

>> # of unresolved:  6
>> # of untested:  0
>> # of unsupported:  44
>> # of xfailed:  0
>> # of undefined(test bug):  0
>>=20
>> These results are same with/without eventfs.
>=20
> I'm hoping to look at these patches this week.

Yes, please. Thanks.

-Ajay

