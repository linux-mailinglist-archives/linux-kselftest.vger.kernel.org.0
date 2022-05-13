Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46318526DA2
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 May 2022 02:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiENAC2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 May 2022 20:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiENAC1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 May 2022 20:02:27 -0400
X-Greylist: delayed 5559 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 May 2022 16:52:32 PDT
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259E83D17A7;
        Fri, 13 May 2022 16:52:31 -0700 (PDT)
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DMF7UX007882;
        Fri, 13 May 2022 22:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=rN77T/xF7ONqp72o34WrAJCQC3qKPJI7gt6N6prw9D0=;
 b=QTnZxhZBnKXNTiWjW5+fa9Tu6TpZhmRuBRsIBjl+v9aiKS+wg+pTLj3hFMzy5ofd4WLs
 08BLZk5wRtoIlmQtrZ8W5gFGfzoFo6SJr94p8sYOqUZk3fnYlX+dbImjYtmz9m4FsgMZ
 ZSiW6ZTO14fZrcThNe1sdXvRfo5ft1FQggferYCKu4voBMy3zkfIFuse36fMSClaj6lh
 cGqsAPXP0xFvyCxwNmZcgLZ4C0MfRqopw51i/uY22qNNyXBPp8Y7gPzjgTodXHg8KLt8
 dsFu11+YMePYqft5980Cs4CkWPP8xSjq2t7yF0O02PBl9zokKTBpEZljySZ+Ages1lYi Vw== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3fwe0xyaym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 22:19:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcAE8RBnQ2jnhNm3xuqK6YzffRIbmsYj2loABmrGcU9ISOKA1/xqhtpl4KUndNNhtsktIQ9DBbJULhMinG6yAtru0pr4JA76LJ3Mv4idXaZqZ30soJzNUtI0Fjihhvm8UlG/wUaspgGHbikeCr/WBM+XshtL3V6dXEj9S28go75LeVdK2BI+JnGx9vKyQTjWg/aLgzKyj29nL0BKhc0hsgIbRwq+/1jKmSWRexUXM44QqYfON44ZEzL/iWg+Fmz74sxxNEDojGO8KC6z8Dx7qXGxf71nYKJio+wxVdOeXjAIccILIgCB3OPhJcw7bI/n88D/miTKzLkZVWg6MRSnqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rN77T/xF7ONqp72o34WrAJCQC3qKPJI7gt6N6prw9D0=;
 b=cJWxX15uFA5b7MLL6+UaRT0Ig0xpenmF7hH3vsllIIqLo/g4XdKswYTnOzyzr0H9/iR9/RlH5G8Gd7Wn+CJ+mEtSZJw5NdPeh/V3e9cvO0wp2yBYqR8BUkXgdlXNqZCRQYt6nyGl5lowU4x8DCZpI1LhjdhgnuNoToWZJFuvm+lIvmbYuOw/96uqzI7meUUxYL2wQJ+UsuwGOVdbu/vcLtlHzUyKx3SbkLRtscDcg9N8Kaqf58+FeziS0oFr8REt5cYDNXyH6EhvnkGZtOaFOyJqK06Tbb5nHMW/Yi1dozSNeU3/7ySoeSLrrzA7wGzr4Zef0P3O8K6i+S5tGl+I3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by MWHPR1301MB2160.namprd13.prod.outlook.com (2603:10b6:301:34::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.5; Fri, 13 May
 2022 22:19:32 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::61c5:661c:f216:e59a]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::61c5:661c:f216:e59a%6]) with mapi id 15.20.5250.012; Fri, 13 May 2022
 22:19:32 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Frank Rowand <frowand.list@gmail.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Brendan Higgins <brendanhiggins@google.com>
CC:     Jonathan Corbet <corbet@lwn.net>,
        "rmr167@gmail.com" <rmr167@gmail.com>,
        "guillaume.tucker@collabora.com" <guillaume.tucker@collabora.com>,
        "dlatypov@google.com" <dlatypov@google.com>,
        "kernelci@groups.io" <kernelci@groups.io>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] KTAP spec v2: prefix to KTAP data
Thread-Topic: [RFC] KTAP spec v2: prefix to KTAP data
Thread-Index: AQHYZcVvxa8MGa2M7EqluXAE9d+LyK0awBiAgAKi2MA=
Date:   Fri, 13 May 2022 22:19:32 +0000
Message-ID: <BYAPR13MB2503FA8B94998018D64804C6FDCA9@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <bc6e9ed7-d98b-c4da-2a59-ee0915c18f10@gmail.com>
 <1c89133e-7bd2-862a-bd57-7fefdffb77ae@gmail.com>
In-Reply-To: <1c89133e-7bd2-862a-bd57-7fefdffb77ae@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee9c59c9-ab8b-4889-8609-08da352ea78d
x-ms-traffictypediagnostic: MWHPR1301MB2160:EE_
x-microsoft-antispam-prvs: <MWHPR1301MB21601E6C2283420ADDBCB153FDCA9@MWHPR1301MB2160.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cnIM+MjOql/tSnBlKtyC1j/ORC0tbfQ87FMkWlKkEqh5PMo1oNFsDFWGU0WCeWDe6eTDzXSNLm70fnvOFfWjY8PiLNmnHAgllWW4StNdD5Gldugjycmzm1fMlbhgkFlJ1XMFttSIdXYuNh/maphCmVPZV5rghFYQ31R1vtzbePDwqOQuBOOAj7zsEM/piLG2wcHhK/2t8NS26fsaz/4MBj0W46/CIJTB4+97aMlEGAhQHRn9UqQX9NJIqbyNsTQ+LsCHez+YpjlZYxBybfz5+y/Imr6iEscsCFO/8wVPLdmlWNX1s387O3Qk1zrN3SDvBNjkdwGtsTRDEX47rCXDwjmIouREO7fV4PRe+94oyac1VC3LXn5uimIFi+SI17qxDp8nRJrjM4RWp8qZNKXroY0KhlOqD+wFEc8Ee29TqQPhieFZ1lRkU91OPfduj03T5odL66hVPVVNZ3kSYJAAFF2NyKcSv3QrQBPp49gjzT5X23D2LDa/zHYFU0i/xIn41MZ4JMeEY/D0Ss+u2c5fSdji1uXqHDuwqim9DO7QTnb6JEsV8VWm5l7gzlUcDE0vc2HxhO/FIzvkmUUOtjjq+BBObLZDcwvVUpBl3YYpYdo400X99CdZ7L47uj6nmMAJ6T33KgGdYYtAztt9DdDvF7yS/+Xj1QhrBpbWf66gnlF7J9sUbZgJMpE5gvFPZcuKCppOy8mPeQjqvQMMyUkHu93eGczsYAyYgSneywoyDo037u++mszVCLJ/6hb1kI+C1Nxrjr0yhs9npaXCuKf1iAJYIMdcoocZpFfS/qtRJHrEqUPFOocnYxP+aAv3Zl+2otUg4mpIdxshwVpwqnRR2rGC76QhHQfkHsjrQTJUK4jcQXZP53NuHzyp7T8cSM5qRt/jW4kgQNcxXJ87xDeVsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2503.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(83380400001)(82960400001)(186003)(71200400001)(45080400002)(7416002)(7696005)(8936002)(33656002)(2906002)(38070700005)(122000001)(38100700002)(966005)(52536014)(26005)(5660300002)(55016003)(110136005)(316002)(9686003)(54906003)(53546011)(6506007)(66946007)(66556008)(66476007)(76116006)(64756008)(66446008)(8676002)(4326008)(86362001)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Znl3bnYrTm12cWhEcmI5ZDZ5b1BCWnBmRUlJT254dU03bHhpTHkxcmlxU3Y5?=
 =?utf-8?B?aVhvMCtrbUMwRU9QTFpGMytwYjI3OU5malo1c3RRTU1DN1RWSUZVb0VRMFNx?=
 =?utf-8?B?bVFmREdSMTJNQ21ZSll5MmpPTUpmaEJQVW1RSncrL0lESHp6MmJRbXhXRW9y?=
 =?utf-8?B?bjlXYUExOG9LWmFNTytzZExxOHg5SGJCdjdQamE1QS92QzNYR3UzZDRGNlFH?=
 =?utf-8?B?T3VGbnNVbDhQWTdSaFR5cUpDTmdXbmpUdFk0Nmd3MEFkNDhLbllWWlo3empE?=
 =?utf-8?B?bmh3REtVYU1Qc0ROenp4WmlIVEtjNDEvZXVYWjNEZjhEanZHSVR6N09oUk9q?=
 =?utf-8?B?Wks2cjJsZWVma2NWbG10WVg4a1VVRmVyL2ZTZGJDbW16MUxoc05nV1g5STBG?=
 =?utf-8?B?U2dXRGhXZVdUNVorK1pYRzdGTGYxcjFsUnV4MFpnNzhvZy9EaVhBdXpLU1dp?=
 =?utf-8?B?NStscTZabFdta2REWmRRMUZ0WXRVOEgxSjRJSndQQS9CeGEvUy9OTlpvbzk3?=
 =?utf-8?B?RCsrNHFiU0VCQ05IVnlFK29XRkJOdGJiYmorckFZdWk2UkdNUTZNZzg2M3Qy?=
 =?utf-8?B?ejd6VDZReFpHZmNLcnhyZy8zd1NLSXYrTTJKdmtCWlNwVHNrU20yWW5qQ3NY?=
 =?utf-8?B?bTRPVFlSelZCaHQySXo3ZENFUVgwWDdxMlduWFRZS1hhWTFYeEJCcTdaSU43?=
 =?utf-8?B?cFA3TXpiRlFPVmtoQnJsOHVvRVMyYWxrZ0tCaFRXc3I2MjBrU2dsbTByNlcw?=
 =?utf-8?B?MW1ua3BFYmROczRaUUduNWZGNEZPaHVnaGZTcEpBZDA4M1JJYWlUWVZxRVVz?=
 =?utf-8?B?YTZMc1E4dmdRVVlObEozTndvUTZpZDhPNHo4YXplYTNpM3BxcFdJT1JFMURY?=
 =?utf-8?B?WjZJTFVabGxrMkpDWVN0ZjRXNTdQb010OG5mNUcrcjdlYXhWcVRJZnpyaVds?=
 =?utf-8?B?WjR0YVhMemN6Qi9jYmdGZUVwN1FhTGtGWkRQeE1nMmRSTURkaXdsRFBMMGN5?=
 =?utf-8?B?WGRXTjBOZmpEVGcrdlpQVlNhMUZPUGZ3T2NOa1ljUjFVdmc3MjZzT1lnbDQ0?=
 =?utf-8?B?Z0JkMlpmMDlmR1dGYnNZd1VKU01WckpUZFExcGlHYkNVUFNpeFpRUTR4Zy96?=
 =?utf-8?B?WkpWaWgzNkpvSmltVWxFL3lPSkIvVUJtMXZhekR0WjZ1WHIrVU8yczhTaUhm?=
 =?utf-8?B?di9aU0Nrd0RaSVdHWS9keUNqUUxUV2F4YUhRejZ3YzlaajNQUUVaVUFHMk91?=
 =?utf-8?B?OFk2S3IvRkgzb3JsOXhqNTBQOUVQTjArd0JhUFE2SnRwTXZNMEZ3dk5FUld0?=
 =?utf-8?B?aHVSTC9kRGtXZlJXcDQ3dzN1dGF2S3d1TUpsajN2Y0tPNkp5Rmd4ekt6a2Nq?=
 =?utf-8?B?OVBDL09sNHZSMzJrSWNpNXFUVjJVbnRYdmZRNGdNT3pGaU9xcE8yYmlnWVFy?=
 =?utf-8?B?T1FtMVZ3MHBGL1c3clJydHVHeERHSkFUWjNrZ05nSjB5dU1oZUZZRlNPeU5a?=
 =?utf-8?B?YVFpOVJDektBM3diNlpTbUo4QUNoZDRoNmJaM2ZpbVF1RDgxa1YxZkdLSzRp?=
 =?utf-8?B?ejZzZ2NIRFRYOGRZOXM3MlE1VThuZWlMTm1YZ2pONHRmMWtLWkhjeDFHWGVF?=
 =?utf-8?B?SFdTT0h4Ulh1UnN4ZG82clJXMkVGNUd4ZExvYTlzUDZSSVJFUmQvbXJ5bm55?=
 =?utf-8?B?S0FoVmlHSGZ0WE52dW9HanR3UVJjOFRTNFFKcFU4Ynk0Zm9HTTBmd0g1Uk9U?=
 =?utf-8?B?QkNkQUhVNjV0NTdPYXVnRjVxWHArY1lvWVJHbk9CMXNHNjY2dkdkL21NKzlt?=
 =?utf-8?B?YlhGZS9UUkMrSnFrK1ZvWFRuTlVVSXh2Qm5pQ0NySUljUlJHeDhxOVRRMDdF?=
 =?utf-8?B?MlpaRkdoK3ptQlAwbE93ZVFTb1hheG9yYmV4MWNOS1dmcW1YWWl2anRpV1pX?=
 =?utf-8?B?Skl3T1hnVythZGdESDQ4dnF0ZHlvVjU2Z2FzRDhTalJ5eGNEc1RsM0dSb2pF?=
 =?utf-8?B?V1N4cUlCbFR4RVZzdXBXQ3U2WXFteG00ak9XTWZtMVZCZkRCZDdMSDh3UnEy?=
 =?utf-8?B?L0Zkd3VDeTZWNHlIY05PSlFoblJKc3pYQjFhV3FRcXNCd1FRSlZwZU5kaURp?=
 =?utf-8?B?L2wxVnk5U1JnckhqWnFON2pUeGppRGI5U0tndm1MTkJlUmE5WG1kckxSMmdH?=
 =?utf-8?B?azIrSVA4WHdSZDVocEVSQkgwdjFkcjd5TXowR216VXBQYnQrazdnRit1aXAy?=
 =?utf-8?B?UkxGcVJKQzNCZ3NtME15RGpSWTZ6VlZ2cVllNjFlRWpvMGE1S1JHblpwc2pu?=
 =?utf-8?B?alhkN1hVUW9ScWtSNFdxbFdzU3lyTXU0WFF6TFJYdGJWalRCUVRzUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9c59c9-ab8b-4889-8609-08da352ea78d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 22:19:32.1871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 23hKWZycSUu3PU842c/aDi0SnNvPIR+ZHqsq0Hw6j3n2Z9W9VO4KhbNoI8aF9NtaKxDKgc8s+dHoV90AeYCo7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1301MB2160
X-Proofpoint-GUID: k3yANTlZ24vqUp7RNgvRZy80YOvQN8Rx
X-Proofpoint-ORIG-GUID: k3yANTlZ24vqUp7RNgvRZy80YOvQN8Rx
X-Sony-Outbound-GUID: k3yANTlZ24vqUp7RNgvRZy80YOvQN8Rx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_11,2022-05-13_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRnJhbmsgUm93YW5kIDxm
cm93YW5kLmxpc3RAZ21haWwuY29tPg0KPiANCj4gT24gNS8xMi8yMiAwMDo1OSwgRnJhbmsgUm93
YW5kIHdyb3RlOg0KPiA+IEluIHRoZSBtaWRkbGUgb2YgdGhlICJSRkMgLSBrZXJuZWwgdGVzdCBy
ZXN1bHQgc3BlY2lmaWNhdGlvbiAoS1RBUCkiIHRocmVhZCwNCj4gPiBzdGFydGVkIGluIEF1Z3Vz
dCAyMDIxLCBUaW0gQmlyZCBtYWRlIGEgc3VnZ2VzdGlvbiB0byBhbGxvdyBhIHByZWZpeCB0byB0
aGUNCj4gPiBLVEFQIGRhdGEgZm9ybWF0Og0KPiA+DQo+ID4+IEp1c3QgYXMgYSBzaWRlIG5vdGUs
IGluIHNvbWUgRnVlZ28gdGVzdHMsIGl0IHdhcyB2ZXJ5IHVzZWZ1bCB0byBpbmNsdWRlIGFuIGlk
ZW50aWZpZXINCj4gPj4gaW4gdGhldGhlIHByZWZpeCBuZXN0ZWQgdGVzdHMuICBUaGUgb3V0cHV0
IGxvb2tlZCBsaWtlIHRoaXM6DQo+ID4+DQo+ID4+IFRBUCB2ZXJzaW9uIDEzDQo+ID4+IDEuLjIN
Cj4gPj4gW2JhdGNoX2lkIDRdIFRBUCB2ZXJzaW9uIDEzDQo+ID4+IFtiYXRjaF9pZCA0XSAxLi4y
DQo+ID4+IFtiYXRjaF9pZCA0XSBvayAxIC0gY3ljbGljdGVzdCB3aXRoIDEwMDAgY3ljbGVzDQo+
ID4+IFtiYXRjaF9pZCA0XSAjIHByb2JsZW0gc2V0dGluZyBDTE9DS19SRUFMVElNRQ0KPiA+PiBb
YmF0Y2hfaWQgNF0gbm90IG9rIDIgLSBjeWNsaWN0ZXN0IHdpdGggQ0xPQ0tfUkVBTFRJTUUNCj4g
Pj4gbm90IG9rIDEgLSBjaGVjayByZWFsdGltZQ0KPiA+PiBbYmF0Y2hfaWQgNF0gVEFQIHZlcnNp
b24gMTMNCj4gPj4gW2JhdGNoX2lkIDRdIDEuLjENCj4gPj4gW2JhdGNoX2lkIDRdIG9rIDEgLSBJ
T1pvbmUgcmVhZC93cml0ZSA0ayBibG9ja3MNCj4gPj4gb2sgMiAtIGNoZWNrIEkvTyBwZXJmb3Jt
YW5jZQ0KPiA+Pg0KPiA+PiBDYW4gSSBwcm9wb3NlIHRoYXQgdGhlIHByZWZpeCBub3QgYmUgZml4
ZWQgYnkgdGhlIHNwZWMsIGJ1dCB0aGF0IHRoZSBzcGVjIGluZGljYXRlcyB0aGF0DQo+ID4+IHdo
YXRldmVyIHRoZSBwcmVmaXggaXMgb24gdGhlIFRBUCB2ZXJzaW9uIGxpbmUsIHRoYXQgcHJlZml4
IG11c3QgYmUgdXNlZCB3aXRoIHRoZSBvdXRwdXQgZm9yDQo+ID4+IGFsbCBsaW5lcyBmcm9tIHRo
ZSB0ZXN0ICh3aXRoIHRoZSBleGNlcHRpb24gb2YgdW5rbm93biBsaW5lcyk/DQo+ID4NCj4gPiBU
aGUgdGhyZWFkIHdhcyBkaXNjdXNzaW5nIG1hbnkgb3RoZXIgaXRlbXMsIGJ1dCB0aGlzIGlzIHRo
ZSBvbmUgdGhhdCBJIHdhbnQNCj4gPiB0byBmb2N1cyBvbiBpbiB0aGlzIG5ldyBSRkMgdGhyZWFk
Lg0KPiA+DQo+ID4gVGltJ3Mgb3JpZ2luYWwgZW1haWwgd2FzOg0KPiA+DQo+ID4gICAgaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvci9CWUFQUjEzTUIyNTAzQTRCNzkwNzREOEVENTU3OTM0NURGRENC
OUBCWUFQUjEzTUIyNTAzLm5hbXByZDEzLnByb2Qub3V0bG9vay5jb20NCj4gPg0KPiA+IFRoZXJl
IHdhcyBvbmUgcmVwbHkgdG8gdGhpcyB0aGF0IGNvbW1lbnRlZCBvbiBUaW0ncyBzdWdnZXN0aW9u
IChhbmQgYWxzbyBtYW55DQo+ID4gb3RoZXIgaXRlbXMgaW4gdGhlIHRocmVhZCkgYXQ6DQo+ID4N
Cj4gPiAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjEwODMwMTIyNi44MDBGM0Q2RDRA
a2Vlc2Nvb2sNCj4gPg0KPiA+PiBPaCwgaW50ZXJlc3RpbmcuIFRoaXMgd291bGQgYWxzbyBhbGxv
dyBwYXJhbGxlbCAodW5pcXVlKSB0ZXN0IGV4ZWN1dGlvbg0KPiA+PiB0byBiZSBwYXJzYWJsZS4g
VGhhdCBzb3VuZHMgd29ya2FibGUuIChBZ2FpbiwgdGhpcyBuZWVkcyBMQVZBIHBhdGNoaW5nDQo+
ID4+IGFnYWluLi4uKQ0KPiA+DQo+ID4gSSBmb3VuZCBUaW0ncyBvcmlnaW5hbCBzdWdnZXN0aW9u
IHRvIGJlIHVzZWZ1bCwgc28gSSBoYXZlIGNvbWUgdXAgd2l0aA0KPiA+IHR3byBwb3NzaWJsZSB3
YXlzIHRvIG1vZGlmeSB0aGUgS1RBUCBzcGVjaWZpY2F0aW9uIHRvIGltcGxlbWVudCB3aGF0IFRp
bQ0KPiA+IHdhcyB0aGlua2luZyBhYm91dC4gIEkgd291bGQgbm90IGJlIHN1cnByaXNlZCBpZiBz
b21lb25lIGVsc2UgaGFzIGEgYmV0dGVyDQo+ID4gc3VnZ2VzdGlvbiB0aGFuIG1pbmUsIGJ1dCBJ
IHdpbGwgcmVwbHkgdG8gdGhpcyBlbWFpbCB3aXRoIG15IHR3byBhbHRlcm5hdGl2ZXMNCj4gPiB0
byBzdGFydCBhIGRpc2N1c3Npb24uICBNeSBhbHRlcm5hdGl2ZXMgYXJlIG5vdCBpbiB0aGUgZm9y
bSBvZiBwYXRjaGVzLCBidXQNCj4gPiBpZiBkaXNjdXNzaW9uIGxlYWRzIHRvIGEgZ29vZCByZXN1
bHQgdGhlbiBJIHdpbGwgY3JlYXRlIGEgcGF0Y2ggZm9yIHJldmlldy4NCj4gPg0KPiA+IC1GcmFu
aw0KPiANCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gQWx0ZXJuYXRpdmUgMg0KPiAgICAt
IEFkZCBhbiBvcHRpb25hbCA8cHJlZml4IHN0cmluZz4gdG8gdGVzdCBvdXRwdXQuDQo+ICAgIC0g
QWRkICJDb25maWd1cmF0aW9uIGluZm8gbGluZXMiLCB3aGljaCBhcmUgdXNlZCB0byBwcm92aWRl
IGluZm9ybWF0aW9uDQo+ICAgICAgYWJvdXQgdGhlIEtUQVAgZm9ybWF0IHRvIHByb2dyYW1zIHRo
YXQgaW50ZXJwcmV0IHRoZSBLVEFQIGRhdGEuICBUaGUNCj4gICAgICBvbmx5IHR5cGUgb2YgIkNv
bmZpZ3VyYXRpb24gaW5mbyBsaW5lcyIgcHJvcG9zZWQgcHJvdmlkZXMgdGhlIHZhbHVlDQo+ICAg
ICAgb2YgPHByZWZpeCBzdHJpbmc+IGZvciBwcm9ncmFtcyB0aGF0IHByb2Nlc3MgdGhlIEtUQVAg
b3V0cHV0Lg0KPiAgICAtIEZ1cnRoZXIgdHlwZXMgb2YgIkNvbmZpZ3VyYXRpb24gaW5mbyBsaW5l
cyIgY291bGQgYmUgYWRkZWQuDQo+IA0KPiBBbHRlcm5hdGl2ZSAyYg0KPiAgICAtIEFkZCBhbiBv
cHRpb25hbCA8cHJlZml4IHN0cmluZz4gdG8gdGVzdCBvdXRwdXQuDQo+ICAgIC0gQWRkIGEgPHBy
ZWZpeCBzdHJpbmc+IGRlZmluaXRpb24gbGluZSBvZiB0aGUgZm9ybToNCj4gICAgICAgICBvayAw
IDxwcmVmaXggc3RyaW5nPg0KPiAgICAgIFRoaXMgbGluZSBpcyBlc3NlbnRpYWxseSBhIHBob255
ICJUZXN0IGNhc2UgcmVzdWx0IGxpbmVzIiBmb3IgdGVzdCAwLg0KPiANCj4gPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0NCg0KRm9yIHdoYXQgaXQncyB3b3J0aCwgSSBtdWNoIHByZWZlciBBbHRlcm5h
dGl2ZSAxLCB1c2luZyB0aGUgcHJlZml4IG9uIHRoZSBLVEFQIGxpbmUgYXMNCnRoZSBwcmVmaXgg
Zm9yIHRoZSBsaW5lcyBhc3NvY2lhdGVkIHdpdGggdGhhdCB0ZXN0J3Mgb3V0cHV0LiAgSSB0aGlu
ayBpdCdzIG11Y2ggc2ltcGxlci4NCg0KVGhhbmtzIGZvciBmb2xsb3dpbmcgdXAgb24gdGhpcy4N
CiAtLSBUaW0NCg0KDQoNCg0KPiAjIyBDb25maWd1cmF0aW9uIGluZm8gbGluZXMNCj4gDQo+IE9j
Y3VyIGluIHplcm8gb3IgbW9yZSB0ZXN0IGNhc2UgcmVzdWx0IGxpbmVzLCB3aGVyZSA8bnVtYmVy
PiBpcyAwICh6ZXJvKSwNCj4gZm9sbG93aW5nIHRoZSAiUGxhbiBsaW5lIiwgYmVmb3JlIGFueSBv
dGhlciAiVGVzdCBjYXNlIHJlc3VsdCIgbGluZS4NCj4gDQo+ICAgIElmIHRoZXJlIGlzIG5vICJQ
bGFuIGxpbmUiIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIHRlc3QsIHRoZW4gdGhlDQo+ICAgICJD
b25maWd1cmF0aW9uIGluZm8gbGluZXMiIGZvbGxvdyB0aGUgIlZlcnNpb24gbGluZSIsIGJlZm9y
ZSBhbnkNCj4gICAgb3RoZXIgIlRlc3QgY2FzZSByZXN1bHQiIGxpbmUuDQo+IA0KPiBmb3JtYXQ6
DQo+IA0KPiAgICBvayAwIDxkZXNjcmlwdGlvbj4gIyBbPGRpcmVjdGl2ZT5dIFs8ZGlhZ25vc3Rp
YyBkYXRhPl1dDQo+IA0KPiA8cmVzdWx0PiBtdXN0IGJlICJvayIuDQo+IA0KPiBUaGUgdHlwZSBv
ZiBlYWNoICJDb25maWd1cmF0aW9uIGluZm8gbGluZSIgaXMgZGVmaW5lZCBieSB0aGUgdmFsdWUN
Cj4gb2YgPGRlc2NyaXB0aW9uPi4NCj4gDQo+IEVhY2ggdmFsdWUgb2YgPGRlc2NyaXB0aW9uPiB1
c2VkIGZvciBhICJDb25maWd1cmF0aW9uIGluZm8gbGluZSIgbXVzdCBiZQ0KPiBsaXN0ZWQgaW4g
dGhlIHNwZWNpZmljYXRpb24uDQo+IA0KPiBXaGV0aGVyICMgPGRpcmVjdGl2ZT4gaXMgb3B0aW9u
YWwgb3IgcmVxdWlyZWQgaXMgZGVmaW5lZCBmb3IgZWFjaCB0eXBlIG9mDQo+ICJDb25maWd1cmF0
aW9uIGluZm8gbGluZSIuDQo+IA0KPiAjIyMjIFNob3VsZCAnWzxkaWFnbm9zdGljIGRhdGE+XScg
YmUgaW5jbHVkZWQgaW4gdGhlIGZvcm1hdD8NCj4gDQo+IA0KPiAtIC0gLSAtIC0gLSAtIC0gLSAt
IC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0g
LSAtDQo+ICMgW291dHB1dF0gcHJlZml4DQo+IA0KPiBvayAwIG91dHB1dF9wcmVmaXggIzxwcmVm
aXggc3RyaW5nPg0KPiANCj4gICAgPHByZWZpeCBjb250ZW50IGlzIGEgY29uc3RhbnQgc3RyaW5n
Pg0KPiAgICBOb3RlOiB0aGVyZSBpcyBubyBzcGFjZSBiZXR3ZWVuICIjIiBhbmQgIjxwcmVmaXgg
c3RyaW5nPiIuICBJZiB0aGVyZSBpcyBvbmUNCj4gICAgb3IgbW9yZSBzcGFjZXMgYWZ0ZXIgdGhl
ICIjIiwgdGhlbiB0aGVyZSBhcmUgcGFydCBvZiB0aGUgPHByZWZpeCBzdHJpbmc+DQo+IA0KPiAg
ICAjIyA8ZGlhZ25vc3RpYyBkYXRhPiBtdXN0IG5vdCBleGlzdCB1bmxlc3MgdGhlcmUgaXMgYSB3
YXkgdG8gZGV0ZXJtaW5lIHRoZQ0KPiAgICAjIyBlbmQgb2YgPHByZWZpeCBzdHJpbmc+Lg0KPiAg
ICAjIw0KPiAgICAjIyBBZGRpbmcgYSB3YXkgdG8gZGV0ZXJtaW5lIHRoZSBlbmQgb2YgPHByZWZp
eCBzdHJpbmc+IGFkZHMgbXVjaCBjb21wbGV4aXR5DQo+ICAgICMjIHRvIHRoZSBjb25zdW1lcnMg
b2Yga3RhcCBvdXRwdXQuICBGb3IgZXhhbXBsZSwgaWYgdGhlIGZvcm1hdCB3YXM6DQo+ICAgICMj
DQo+ICAgICMjICAgb2sgMCBvdXRwdXRfcHJlZml4ICM8cHJlZml4IHN0cmluZz5bIzxkaWFnbm9z
dGljIGRhdGE+XQ0KPiAgICAjIw0KPiAgICAjIyB0aGVuIGl0IGlzIG5vdCBwb3NzaWJsZSBmb3Ig
PHByZWZpeCBzdHJpbmc+IHRvIGNvbnRhaW4gJyMnLCB1bmxlc3MNCj4gICAgIyMgYSBtZXRob2Qg
dG8gZXNjYXBlICcjJyBpcyBwcm92aWRlZC4gIEUuRy46DQo+ICAgICMjDQo+ICAgICMjICAgb2sg
MCBvdXRwdXRfcHJlZml4ICNYWFggdGVzdCByZXN1bHQgXCNcI1wjIzxkaWFnbm9zdGljIGRhdGE+
DQo+ICAgICMjDQo+ICAgICMjIHdvdWxkIHJlc3VsdCBpbiA8cHJlZml4IHN0cmluZz4gdmFsdWUg
b2YgJ1hYWCB0ZXN0IHJlc3VsdCAjIyMnDQo+ICAgICMjDQo+ICAgICMjIE15IHJlY29tZW5kYXRp
b246IGRvIG5vdCBhbGxvdyA8ZGlhZ25vc3RpYyBkYXRhPiBpbiBvdXRwdXRfcHJlZml4IGZvcm1h
dC4NCj4gDQo+ICAgIEFsbCBzdWJzZXF1ZW50IHRlc3QgbGluZXMgYXJlIHByZWZpeGVkIHdpdGgg
dGhlIDxwcmVmaXggc3RyaW5nPi4NCj4gDQo+ICAgIEluZGVudGF0aW9uIGZvciAiTmVzdGVkIHRl
c3RzIiBmb2xsb3dzIDxwcmVmaXggc3RyaW5nPi4gIFRoZSBpbmRlbnRhdGlvbg0KPiAgICBkb2Vz
IE5PVCBwcmVjZWRlIDxwcmVmaXggc3RyaW5nPi4NCj4gDQo+ICAgICJEaWFnbm9zdGljIGxpbmVz
IiBhcmUgcHJlZml4ZWQgd2l0aCB0aGUgPHByZWZpeCBzdHJpbmc+Lg0KPiANCj4gICAgIlVua25v
d24gbGluZXMiIG1heSBvcHRpb25hbGx5IGJlIHByZWZpeGVkIHdpdGggdGhlIDxwcmVmaXggc3Ry
aW5nPiwgYnV0DQo+ICAgIGFyZSBub3QgcmVxdWlyZWQgdG8gYmUgcHJlZml4ZWQgd2l0aCB0aGUg
PHByZWZpeCBzdHJpbmc+LiAgSXQgaXMgYWxsb3dlZA0KPiAgICBmb3Igc29tZSAiVW5rbm93biBs
aW5lcyIgdG8gbm90IGJlIHByZWZpeGVkIHdpdGggdGhlIDxwcmVmaXggc3RyaW5nPiwgZXZlbg0K
PiAgICBpZiBvbmUgb3IgbW9yZSBvdGhlciAiVW5rbm93biBsaW5lcyIgYXJlIHByZWZpeGVkIHdp
dGggdGhlIDxwcmVmaXggc3RyaW5nPi4NCj4gDQo+ICAgICMjIyMgRG9lcyBwcmVmaXhpbmcgYmVn
aW4gaW1tZWRpYXRlbHkgKGV2ZW4gZm9yIGEgc3Vic2VxdWVudCAiQ29uZmlndXJhdGlvbg0KPiAg
ICAjIyMjIGluZm8gbGluZSIgb3IgZG9lcyBpdCBiZWdpbiB3aXRoIHRoZSB0ZXN0IDEgIlRlc3Qg
Y2FzZSByZXN1bHQgbGluZSINCj4gICAgIyMjIyBsaW5lPw0KPiAgICAjIyMjDQo+ICAgICMjIyMg
ICAgVGhpcyBxdWVzdGlvbiBtaWdodCBiZSBzaW1wbGlmaWVkIGlmIHRoZSBvdXRwdXRfcHJlZml4
IGxpbmUgaXMNCj4gICAgIyMjIyAgICByZXF1aXJlZCB0byBiZSB0aGUgbGFzdCAiQ29uZmlndXJh
dGlvbiBpbmZvIGxpbmUiLiAgKE9yIG1heWJlIGV2ZW4gaWYNCj4gICAgIyMjIyAgICByZXF1aXJl
ZCB0byBiZSB0aGUgZmlyc3QgIkNvbmZpZ3VyYXRpb24gaW5mbyBsaW5lIi4NCj4gDQo+IA0KPiA9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KPiAjIyMjIGRpc2N1c3Npb24gbm90ZXM6DQo+IA0KPiBQ
Uk86DQo+ICAgIFRlc3Qgb3V0cHV0IHByb2Nlc3NpbmcgcHJvZ3JhbXMgY2FuIGRldGVjdCB0aGUg
dmFsdWUgb2YgPHByZWZpeCBzdHJpbmc+DQo+ICAgIG1vcmUgZGV0ZXJtaW5pc3RpY2FsbHkgdGhh
biBBbHRlcm5hdGl2ZSAxLg0KPiANCj4gQ09OOg0KPiAgICBNb3JlIGNvbXBsZXggdGhhbiBBbHRl
cm5hdGl2ZSAxLiAgKEJ1dCBhbHRlcm5hdGl2ZSAyYiBpcyBsZXNzIGNvbXBsZXggdGhhbg0KPiAg
ICBBbHRlcm5hdGl2ZSAyLikNCj4gDQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQoNCg==
