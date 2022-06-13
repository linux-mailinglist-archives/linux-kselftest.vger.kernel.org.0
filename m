Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B025482D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jun 2022 11:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbiFMJOl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jun 2022 05:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbiFMJOi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jun 2022 05:14:38 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120088.outbound.protection.outlook.com [40.107.12.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A84A12D02;
        Mon, 13 Jun 2022 02:14:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6HjeS1CjFOD8quwWKhhYTMB/n/Kqn3OijmrfQKPrRDss5Sqc75Mh0rxPXQeZZxQPE3XHGnJw/ms/en0NuHFdnyeVaqhwtPvqv6ffftIVnWK2YBrLpaxVqFeGRYFEZMGNYkb1Cj9LY6zz8IV1mUh4braK/0TFFgEsqMJ1/8dxcFnV4ZjTne5FphhoPnD5OdbBkzVUtltdZ50gGrNtv8iYwSZchXfYCI+65xGRXVrsDaQUtvFDYiMTBGnMCX9AHYkTRkJv9kG7YvX7OZuyq99QW36FX0fIMxGrMZE+XlPabCFiYHLazBoacIySwo23uycCjTsxkjY9EXV0McGxI3oLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilMgrddDdpwgnp0BZ7jnLhPyP5ylM0/5EkA2NWLyJRM=;
 b=VtBXUdqUUqNinHh3pUkB4yW/ErA5/GHV7UyGB65njGZ+JdGtCCt1EIG8ATWutGXVAgJVs67UI9G5xkDnmZ0Cg9bFQlWlSR3BWpOE+gVpgo03Qg/Hf8J/sCe6KFLRAh1HbdPJAjz8U1Ruaawbu1IirkyyPSIxnbLcFJ3m1917JukHpXdj+lkyFhOMqc2XdD0CEauMqlJlki3CxBBNViG3LchR36BSDEAInvltTt8Q4gqD2Rugl8mUV8Xgs7suzACVSASE8nDRGzRoBnU62/pWWhCljm8nUA3MFGnuIRNIYzQkKKwoPD+fYV4gb96oO7FuEfg0Eu28AuE50xOIsiRejw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilMgrddDdpwgnp0BZ7jnLhPyP5ylM0/5EkA2NWLyJRM=;
 b=Vft3WnW3ivmu5BzsNg2xVSBs0ggpYYZASf+rRsDXnP4Bz+jdQf3BrxzTFs3rqhX7Zz34CSSobcvtYIEeU6QWTicV/q6TbI+P6xPHvIxbBu37yhGRAne7Foc39i/Pr1fxQxLOV2vslziW3C4Yjvz8nt1ngJPBwsIy4hP/KykmLkFkCX/ogrjIqSNpOSotsMWzGXkzsJVWB6iu4dmq8ZLCkQaZhThS5mVAzQeHsIgWu14ZbohlIoe91Mkyg4xe71Ox2tWcTzu81cfoUY4Yx50yzXMd9fURG5VOpgid7Nx59g+LfnK0UVZ5DmlDqA6ikEN7xyXr41u/RHwW1pMloWexlA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB3363.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:2a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Mon, 13 Jun
 2022 09:14:33 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356%6]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 09:14:33 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
CC:     Florian Weimer <fweimer@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "clemensb@chromium.org" <clemensb@chromium.org>,
        "jkummerow@chromium.org" <jkummerow@chromium.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "ahaas@chromium.org" <ahaas@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gdeepti@chromium.org" <gdeepti@chromium.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "manoskouk@chromium.org" <manoskouk@chromium.org>,
        "thibaudm@chromium.org" <thibaudm@chromium.org>
Subject: Re: [RFC PATCH 5/6] pkeys: Up level pkey_free() checks
Thread-Topic: [RFC PATCH 5/6] pkeys: Up level pkey_free() checks
Thread-Index: AQHYfSL1T8w3QDCJrEOT6oDyrXT74K1NEbYA
Date:   Mon, 13 Jun 2022 09:14:33 +0000
Message-ID: <e4d447cc-b9f7-97a7-83d4-b41978f656d3@csgroup.eu>
References: <20220610233533.3649584-1-ira.weiny@intel.com>
 <20220610233533.3649584-6-ira.weiny@intel.com>
In-Reply-To: <20220610233533.3649584-6-ira.weiny@intel.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1adeadeb-1947-4633-3cf3-08da4d1d2130
x-ms-traffictypediagnostic: MR1P264MB3363:EE_
x-microsoft-antispam-prvs: <MR1P264MB336334C1ABDC714006B94B0DEDAB9@MR1P264MB3363.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CX4ddUizt4gVlC0hJwwwkTVGhBXzMbFCZ1lnz6MviWiE0KrxFUKNSdeTE24UiBzNKFO/jiAAZ/PvqOpfvn7Fs5s6ZDMPZ3GXrFYUgPBiXU6N/fs7pRRuHtu1MDjccQ9DfXfC1MNg9OjdDNwOoIdyB7RmMB6XRpkb1PCa83L7mvVVOf6Kchu/+3xubAAlVHX2olSZR33oFKsPUsTzXNSixdvEe/XYpcHUWio2pqQGUy5XrJju7wWBO8to/8250CCA8WlDhcy+2mhbn0QKdeyG4ppXTwhprSulrt58DUYsJ5gAuQ0u3lkc2AO35mESe0lzf34x3Z7vGEwPMV5xG6yPm3c37SdeNd4SG317MSykerhBlxVhJ3VXwatreg6VW7cvbe4E2dZH8ypfDNzLhrbfsbyoth0jBYo2DRz8WfdqkSSmGXxkcLED8WJn8v4O5HiZlu/6ScxA7TtGZ8KG+m8nlwlhegboKfFmM+DuE04oC/VQBo1pOEpi2d7SPfnGI2o2kGDVJcF3qLTNeA4ps8pJfVE4QHBe4fp4VCalZBs6u5rVBlyJojN3aiir/uCqdQLXUohLUzSRXB4jFcpIW8fVvKmACsXXD3atUF+Z36U0daHVytYpBneyR6h5bo0z6W+rLTmKOG1LE+YNAjA/bCWnnTn2XXTwmiv41C/GGg/ScfTGg4aXZxkdNkmDz9xlGgnTKnOpQBfj1bE8WkuHna+pjN19mCd6dhdHM+WCGnIDSpy4x+BqU5+ZpTkXHUuscDqtxhYNFr2uF50IZt8FPY3vUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(508600001)(66946007)(316002)(6486002)(110136005)(91956017)(54906003)(71200400001)(6512007)(31686004)(86362001)(36756003)(44832011)(66446008)(7416002)(26005)(76116006)(5660300002)(66476007)(4326008)(64756008)(8676002)(2616005)(66556008)(2906002)(31696002)(8936002)(186003)(66574015)(6506007)(38100700002)(122000001)(38070700005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDBnQWlHbnEwbXBCQk9XZjVhcjhUMGhucHhTRENpTThWRnNoeWtBdytNUmJU?=
 =?utf-8?B?U28zV1VwNklxT2d0MUY5dVhPTGpNeEZKZmtGK3l4RjlXWXhJUWVod0lld1dF?=
 =?utf-8?B?WXZFSnd2aCsyNXoxQTd4Tk80L2FoL3kwTG1kSVV5RTRXck9FY0tlUTV1UlhO?=
 =?utf-8?B?Y1pYcXBpNjRONVdtbkNORG50ZEZyd2pZN0d2dUxmSU00MTdTVkZWZHVvMjl4?=
 =?utf-8?B?VlNrUnN5SjBjSit0cG5qcGFYakdpUTE5WVVmTmRWcE1ZbkRtSzhhSTREQnhW?=
 =?utf-8?B?TlAwclRxSjRadlNjRlVhVldIOSs4anEzK3FwU09MaFJpdGVHTDl4WncraWc3?=
 =?utf-8?B?R2RBTERZcTYwUHVzWjJMRkQyd0E3MmNxTHhqRUdoalBLVWhySVk3dDJRL2s1?=
 =?utf-8?B?MlR5YXRrY3JvbHN6VEhCdFYyZ0JBdGxnZDlTcCthV3NCQ0FkUVBwL2VzZXFx?=
 =?utf-8?B?RmpmQ1JLR29WUVUvOHd5WEJyWGQ2WGwxNjdXUGFIemZNSm9PR0JmK00xd3R1?=
 =?utf-8?B?cDZmUHdLcVhRTkdNd2crNkVzT3R2bGtxZWgyeElGQ3JaNjRWK0wwbnVmR0Z0?=
 =?utf-8?B?cHdyL3huMDdrUnV1WmtPK0RMaE1tVStDZlU5ZlQrOU13NlNvbHV0MUxYSC9i?=
 =?utf-8?B?akFvN3o2UHczSWU5UERtYnpUREdXdXVvaDdCWmlnN1FEUlVWWHFNM0ZHcVo4?=
 =?utf-8?B?NldLSm9Yb0VxdEx1bEJ3b0h5a0t3RmM2Q2FZbHFjbzBNUVhVSm90TG1SSytv?=
 =?utf-8?B?NGJRVmNaUHFrKzFNQWt3b2xucXFPTTlkR2pZMy9iUEUyWUl6QlpjUTdxSGJC?=
 =?utf-8?B?RlFTRHc2eDJxMWM0UFBtRVVkUGxMSXd0cms0MzZ5MG0wZG9QOHdvei9BcE04?=
 =?utf-8?B?ZXpDd0p6NWk4Sm0xbUEyUzd3K1NVb0UrV0x4UWsyWTlsdXdESm9WdHFkOEwx?=
 =?utf-8?B?WkdXbkxSK0MxdUl1TzMxUVZ2aXNOK3NPeUMrV1NGVXYxQldocUN3QzFGRmxM?=
 =?utf-8?B?SXNJem1paTZCT09va1NiNVpZRU5IR1ZDb1c3TzdQZnE5dUY5cmF4WjExRDlu?=
 =?utf-8?B?Q1BQMmJFZVJhYUMyVHZLUzZzTEd6M3RLREFsempNOHgwUnNFY1ZmaWdUU01a?=
 =?utf-8?B?ZWc0RzYwdHVNVjR0M3J1MFdYc2ltK3BuVW9RRG1Gaytoc1hPcFBKYWtsc0I1?=
 =?utf-8?B?MmtkeGk2cHFLVmlkdENhTzhCOFRPNUlLc0dYekF2bjJSaUtBR3VkOTZNRE05?=
 =?utf-8?B?UXpEYVhCWDBJSGVyMDdYVGZqb0d4Rzk2eTFiZnBadzArSC9yeHNlNTNSelZT?=
 =?utf-8?B?SndnWFlJdXZHNkEyTHR6R0syKzZkZUl4Yy8rVzFvVjhBaUVkeVp4NHVIREor?=
 =?utf-8?B?aG1kZVFNcnJNOUtibTB5QlBydC92NEd0MEJvWkhEUTVjODE3VDY5UHJUSHlk?=
 =?utf-8?B?bE5ZM1ZoWVZ5TXNiTDlHWkM4eW1hRy9KdHJzdVdHYzNZa25oMmdaaGJzMFlu?=
 =?utf-8?B?V1U2UngyejVBMVk1SVVtdkQ5dXFIcW10RkQvV1ltVnFuWE9yOEt6V2k5STBJ?=
 =?utf-8?B?d1labTV6Z2Z1SXlJQWQyRENZdDNnYjYxYVdQYlBBOGZOcmFrM1MzdFdWT05X?=
 =?utf-8?B?MEpZYVJVNm53Q2wyUzUrKzVsSzlCa3l1dDBDc1ZsSG5TNmpLaEhkRDFCNDA3?=
 =?utf-8?B?SzJaRmZIOGNRT282aTFoTitWQzZYbWFIRFlydDFmdE1obWtpbTlDa2VYbmN6?=
 =?utf-8?B?YVBlZmZFR25sMVJ1RElDY1FDNzlyVy9yMWRWSGxJVHg3aVpYYjduWGk4SnJB?=
 =?utf-8?B?MjR4SngzV0k3dHJYaU9sMmhFeDF6dkVlQzRNb2MzNkxsYnJzdVFSN2RJV29N?=
 =?utf-8?B?Y1YzZVlRQzE1QW1PeFFBRXZTVnBvcnMwekhrb2pJMnV4Y0gyQW5PTXQ2Mmp1?=
 =?utf-8?B?TGtsL2dIUGR0ZVhRV0t2c3JwbGxlcHFvcndsMVgrQUp2L3RGKzFhYnZleUlP?=
 =?utf-8?B?RXg5UW9NdW1sbVN4NCtwVUVJc09GYWlwZ0gwZENKelRSNUVlUm9WQ29BTksy?=
 =?utf-8?B?Zkg2MHY4OHB6MUN2UTBJZWFOdG9NVzFIRUI2ZGQ3UnVyTndEQzgvT0dBVkx2?=
 =?utf-8?B?blNMY2h6Njd0QXJJZnVPcDhJMEZuVnBTYUFIZzNMVVYvK1VkaUNWMjltYTFC?=
 =?utf-8?B?VEhBN2xRRWpZaVJCTlNiUDFWMFFTRVBLSlNRZ1RodjFKM254UTB2YURoSlRJ?=
 =?utf-8?B?QWFCbFZ0TWR1R1drTFJrc0FlZXVyaU9jUEp2OUtpR3B2WldQTkcxOE14STAr?=
 =?utf-8?B?dlo5blU3dVA5aTZVbWJjWWtwb3J0OGhmcmNSbTlUb3RqWVB5QUMvOUc2SCsw?=
 =?utf-8?Q?Lkpl6eYzzjP4n5Vq7MWr8te6plgnQAFpHOzIA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E39F38848A2F24A9FF4A92D5AF32418@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adeadeb-1947-4633-3cf3-08da4d1d2130
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 09:14:33.2390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EC0dNWyq2D+sIBSnKQJvyFeI0KmoGA9Q7P2sLW9Of15PbZp0sbtuvlKQbUmCc8l8rAk0UacGROUODqZIs3Ojzcw1TK4O0dJJI0RAYt9RRs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3363
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCkxlIDExLzA2LzIwMjIgw6AgMDE6MzUsIGlyYS53ZWlueUBpbnRlbC5jb20gYSDDqWNyaXTC
oDoNCj4gRnJvbTogSXJhIFdlaW55IDxpcmEud2VpbnlAaW50ZWwuY29tPg0KPiANCj4geDg2IGlz
IG1pc3NpbmcgYSBoYXJkd2FyZSBjaGVjayBmb3IgcGtleSBzdXBwb3J0IGluIHBrZXlfZnJlZSgp
LiAgV2hpbGUNCj4gdGhlIG5ldCByZXN1bHQgaXMgdGhlIHNhbWUgKC1FSU5WQUwgcmV0dXJuZWQp
LCBwa2V5X2ZyZWUoKSBoYXMgd2VsbA0KPiBkZWZpbmVkIGJlaGF2aW9yIHdoaWNoIHdpbGwgYmUg
ZWFzaWVyIHRvIG1haW50YWluIGluIG9uZSBwbGFjZS4NCj4gDQo+IEZvciBwb3dlcnBjIHRoZSBy
ZXR1cm4gY29kZSBpcyAtMSByYXRoZXIgdGhhbiAtRUlOVkFMLiAgVGhpcyBjaGFuZ2VzDQo+IHRo
YXQgYmVoYXZpb3Igc2xpZ2h0bHkgYnV0IHRoaXMgaXMgdmVyeSB1bmxpa2VseSB0byBicmVhayBh
bnkgdXNlcg0KPiBzcGFjZS4NCj4gDQo+IExpZnQgdGhlIGNoZWNrcyBmb3IgcGtleV9mcmVlKCkg
dG8gdGhlIGNvcmUgbW0gY29kZSBhbmQgZW5zdXJlDQo+IGNvbnNpc3RlbmN5IHdpdGggcmV0dXJu
aW5nIC1FSU5WQUwuDQo+IA0KPiBDYzogYWhhYXNAY2hyb21pdW0ub3JnDQo+IENjOiBjbGVtZW5z
YkBjaHJvbWl1bS5vcmcNCj4gQ2M6IGdkZWVwdGlAY2hyb21pdW0ub3JnDQo+IENjOiBqa3VtbWVy
b3dAY2hyb21pdW0ub3JnDQo+IENjOiBtYW5vc2tvdWtAY2hyb21pdW0ub3JnDQo+IENjOiB0aGli
YXVkbUBjaHJvbWl1bS5vcmcNCj4gQ2M6IEZsb3JpYW4gV2VpbWVyIDxmd2VpbWVyQHJlZGhhdC5j
b20+DQo+IENjOiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiBD
YzogbGludXgtYXBpQHZnZXIua2VybmVsLm9yZw0KPiBDYzogU29oaWwgTWVodGEgPHNvaGlsLm1l
aHRhQGludGVsLmNvbT4NCj4gQ2M6IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBsaW51eC5pbnRl
bC5jb20+DQo+IENjOiBBbmVlc2ggS3VtYXIgSy5WIDxhbmVlc2gua3VtYXJAbGludXguaWJtLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogSXJhIFdlaW55IDxpcmEud2VpbnlAaW50ZWwuY29tPg0KPiAN
Cj4gLS0tDQo+IFRoYW5rcyB0byBTb2hpbCBmb3Igc3VnZ2VzdGluZyBJIG1lbnRpb24gdGhlIHBv
d2VycGMgcmV0dXJuIHZhbHVlIGluIHRoZQ0KPiBjb21taXQgbWVzc2FnZS4NCj4gDQo+IEFsc28g
U29oaWwgc3VnZ2VzdGVkIGNoYW5naW5nIG1tX3BrZXlfZnJlZSgpIGZyb20gaW50IHRvIHZvaWQu
ICBUaGlzIGlzDQo+IGFkZGVkIGFzIGEgc2VwYXJhdGUgcGF0Y2ggd2l0aCBoaXMgc3VnZ2VzdGVk
IGJ5Lg0KPiAtLS0NCj4gICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vcGtleXMuaCB8IDYgLS0t
LS0tDQo+ICAgYXJjaC94ODYvaW5jbHVkZS9hc20vcGtleXMuaCAgICAgfCAzIC0tLQ0KPiAgIG1t
L21wcm90ZWN0LmMgICAgICAgICAgICAgICAgICAgIHwgOCArKysrKystLQ0KPiAgIDMgZmlsZXMg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vcGtleXMuaCBiL2FyY2gvcG93ZXJwYy9pbmNs
dWRlL2FzbS9wa2V5cy5oDQo+IGluZGV4IDJjODM1MTI0ODc5My4uZTk2YWE5MWY4MTdiIDEwMDY0
NA0KPiAtLS0gYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vcGtleXMuaA0KPiArKysgYi9hcmNo
L3Bvd2VycGMvaW5jbHVkZS9hc20vcGtleXMuaA0KPiBAQCAtMTA3LDEyICsxMDcsNiBAQCBzdGF0
aWMgaW5saW5lIGludCBtbV9wa2V5X2FsbG9jKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQ0KPiAgIA0K
PiAgIHN0YXRpYyBpbmxpbmUgaW50IG1tX3BrZXlfZnJlZShzdHJ1Y3QgbW1fc3RydWN0ICptbSwg
aW50IHBrZXkpDQo+ICAgew0KPiAtCWlmICghbW11X2hhc19mZWF0dXJlKE1NVV9GVFJfUEtFWSkp
DQo+IC0JCXJldHVybiAtMTsNCj4gLQ0KPiAtCWlmICghbW1fcGtleV9pc19hbGxvY2F0ZWQobW0s
IHBrZXkpKQ0KPiAtCQlyZXR1cm4gLUVJTlZBTDsNCj4gLQ0KPiAgIAlfX21tX3BrZXlfZnJlZSht
bSwgcGtleSk7DQo+ICAgDQo+ICAgCXJldHVybiAwOw0KDQpJZiBpdCByZXR1cm5zIGFsd2F5cyAw
LCB0aGUgcmV0dXJuIHZhbHVlIGlzIHBvaW50bGVzcyBhbmQgdGhlIGZ1bmN0aW9uIA0KbW1fcGtl
eV9mcmVlKCkgc2hvdWxkIGJlIGNoYW5nZWQgdG8gcmV0dXJuIHZvaWQuDQoNCj4gZGlmZiAtLWdp
dCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BrZXlzLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9w
a2V5cy5oDQo+IGluZGV4IDJlNmMwNGQ4YTQ1Yi4uZGEwMjczN2NjNGQxIDEwMDY0NA0KPiAtLS0g
YS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wa2V5cy5oDQo+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUv
YXNtL3BrZXlzLmgNCj4gQEAgLTEwNyw5ICsxMDcsNiBAQCBpbnQgbW1fcGtleV9hbGxvYyhzdHJ1
Y3QgbW1fc3RydWN0ICptbSkNCj4gICBzdGF0aWMgaW5saW5lDQo+ICAgaW50IG1tX3BrZXlfZnJl
ZShzdHJ1Y3QgbW1fc3RydWN0ICptbSwgaW50IHBrZXkpDQo+ICAgew0KPiAtCWlmICghbW1fcGtl
eV9pc19hbGxvY2F0ZWQobW0sIHBrZXkpKQ0KPiAtCQlyZXR1cm4gLUVJTlZBTDsNCj4gLQ0KPiAg
IAltbV9zZXRfcGtleV9mcmVlKG1tLCBwa2V5KTsNCj4gICANCj4gICAJcmV0dXJuIDA7DQoNClNh
bWUuDQoNCj4gZGlmZiAtLWdpdCBhL21tL21wcm90ZWN0LmMgYi9tbS9tcHJvdGVjdC5jDQo+IGlu
ZGV4IDU2ZDM1ZGUzMzcyNS4uNDE0NThlNzI5YzI3IDEwMDY0NA0KPiAtLS0gYS9tbS9tcHJvdGVj
dC5jDQo+ICsrKyBiL21tL21wcm90ZWN0LmMNCj4gQEAgLTgwMywxMCArODAzLDE0IEBAIFNZU0NB
TExfREVGSU5FMihwa2V5X2FsbG9jLCB1bnNpZ25lZCBsb25nLCBmbGFncywgdW5zaWduZWQgbG9u
ZywgaW5pdF92YWwpDQo+ICAgDQo+ICAgU1lTQ0FMTF9ERUZJTkUxKHBrZXlfZnJlZSwgaW50LCBw
a2V5KQ0KPiAgIHsNCj4gLQlpbnQgcmV0Ow0KPiArCWludCByZXQgPSAtRUlOVkFMOw0KDQpEb24n
dCBpbml0aWFsaXNlICdyZXQnDQoNCj4gKw0KPiArCWlmICghYXJjaF9wa2V5c19lbmFibGVkKCkp
DQo+ICsJCXJldHVybiByZXQ7DQoNCk1ha2UgaXQgZXhwbGljaXQsIGRvICdyZXR1cm4gLUVJTlZB
TCcNCg0KT25jZSB0aGF0IGlzIGRvbmUsIGlzIHRoZXJlIGFueSBwb2ludCBpbiBoYXZpbmcgYSBm
YWxsYmFjayB2ZXJzaW9uIG9mIA0KbW1fcGtleV9mcmVlKCkgd2hpY2ggcmV0dXJucyAtRUlOVkFM
ID8NCg0KPiAgIA0KPiAgIAltbWFwX3dyaXRlX2xvY2soY3VycmVudC0+bW0pOw0KPiAtCXJldCA9
IG1tX3BrZXlfZnJlZShjdXJyZW50LT5tbSwgcGtleSk7DQo+ICsJaWYgKG1tX3BrZXlfaXNfYWxs
b2NhdGVkKGN1cnJlbnQtPm1tLCBwa2V5KSkNCj4gKwkJcmV0ID0gbW1fcGtleV9mcmVlKGN1cnJl
bnQtPm1tLCBwa2V5KTsNCg0KQWRkOg0KDQoJZWxzZQ0KCQlyZXQgPSAtRUlOVkFMOw0KDQo+ICAg
CW1tYXBfd3JpdGVfdW5sb2NrKGN1cnJlbnQtPm1tKTsNCj4gICANCj4gICAJLyo=
