Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824E56A4591
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 16:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjB0PGx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 10:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjB0PGt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 10:06:49 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16BA22A04;
        Mon, 27 Feb 2023 07:06:39 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31REhqwm004644;
        Mon, 27 Feb 2023 15:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=rOBm+C44w8pa3ju3WgC1GtJ0tt3ssVQCQy4c3bPLbOg=;
 b=Oqwro+cnOIz3XqLo+XH7wwaKgUt4RM2bV8JhGBijg+O+zgyeomCkjgN4OLGXtuFWAh31
 6gtxWkvxQsxjlLHJslsEPnk1OI87ZapLTaJktOpPStXpr7DRPE9nrxxcEx8qPgCfuJs4
 D1EHFCzIdefNISL4/OiBM4Ch2gnLCYWohoJMj1thdITOITywoylfWXTjunbP4c87Np+Y
 vm2316VMSWwsbC74chY6S7mgIweSeUZb21pSyKQvujM+cSYukXNEbt4qh+PK6X+f64cC
 rQIct9H3DBXDSUVG0Eu7b7YVWVSr2KQBT8/Rkv/vsDr9fJ95FIsBMT9bIRE1pKxXLj/W 8w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb7wkt18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 15:06:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31RDq8ge028656;
        Mon, 27 Feb 2023 15:06:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sbe6qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 15:06:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gzju+okJo0lrkYS9nZ+c9MjylaDU4OpDMWdX5I+WqJtmY2gIqLOHvWt+63O3D8YbgZqRDqq0Zi94v7mzZo+PZJ3uT3DIUyPzJXszCdKTWo8ptnIDrWB6+CNuO1JQE85fIjYSoLSJAX3g3kmC29jlQ1haL5+WOk881X1J0roegBVLtwCadGMVQ91d0GXpWY3gw4MLqrp4m1uGfWH0sSx8aWO6rkFHZkPN5a0QqxomBpHhiAARwTVnfxix8Spt3mNDxjFIVnxplXNJ58WxO+YgXfR/19p9ZyneebDU0CozXq5MMFYI0qx9K7cnJImfGhk9+MNkHooCGdl2TWnXcPeaKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOBm+C44w8pa3ju3WgC1GtJ0tt3ssVQCQy4c3bPLbOg=;
 b=SuGvvGh3WQc0FIXRetnDvMBDig6+FAIE3hzE119Fmy1g6EosOVf9Xcrx9DmmnzpwoEqFqVJB8FtZMcaS2qLgC/lphf5wQTkVe3+89ziWEUd64MQv2oAoxWXzPTbHq9bQf2wEVvVy94psQxhmIK3FVFrZRUqEL+PBYoWW5BWfHOEBVhHamgAAcwj3nnEh1wTs+gkBdcyFJFUkWpeooTfVddH1OPsn0cNTiveXYG6xQYkFVEzP8Lok9wEJdzT5J7WdhntZtn1dRnU4hrrLdw3Q0DNGgSEi6OyTj8lSDecqd460ZarBd+s22vPa2ZsDKQKJ4TUJlIYfCh4Ycpx1HtASAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOBm+C44w8pa3ju3WgC1GtJ0tt3ssVQCQy4c3bPLbOg=;
 b=VasC8VM527JlgE7PJ3czDRgyoV8Cdb4NJ0dogk8rBBkQq/TpCHomk+xYR+rCFQXZjVM50bygJdZccDA1cc7GE8j4H87B/HxoUb345U6Dz2qzEgye89KSvgwxYMFI7vy9ChuSdwPH0F6qO9hac4uZkatxfq+Fu3AUlKqtg+4Yd60=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7488.namprd10.prod.outlook.com (2603:10b6:208:44f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16; Mon, 27 Feb
 2023 15:06:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6156.016; Mon, 27 Feb 2023
 15:06:23 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "simo@redhat.com" <simo@redhat.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH v2 00/41] RPCSEC GSS krb5 enhancements
Thread-Topic: [PATCH v2 00/41] RPCSEC GSS krb5 enhancements
Thread-Index: AQHZKQWoezbV6gQfMU2hAYqKspg87a7cvOEAgAAPVQCAABV4gIAAEUWAgAAJZACABdO2AIAAWAOA
Date:   Mon, 27 Feb 2023 15:06:23 +0000
Message-ID: <7ECA014B-3910-4E65-9084-32F790A733D3@oracle.com>
References: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
 <b3e0b5e6-1d0-cdb2-186c-6b4f50e0a3aa@linux-m68k.org>
 <D5221DC2-2A9C-43DC-AC21-FA96E7F76E5B@oracle.com>
 <CAMuHMdVtsZ-jU5foR7V_4XeXT_0f3Nx5vfoJo5pH2jMga0SpWA@mail.gmail.com>
 <58CCF033-58C3-4AF0-B958-BE1AAF1695F3@oracle.com>
 <CAMuHMdUG5cthYp3u6GeYqTqMaNgW0Ernq_ce0AZ22rgFQ5J24A@mail.gmail.com>
 <CAMuHMdXYXO+D==BrN4h57cmuNyOG2Jd3_NwOWNgpjaoBdWQvOg@mail.gmail.com>
In-Reply-To: <CAMuHMdXYXO+D==BrN4h57cmuNyOG2Jd3_NwOWNgpjaoBdWQvOg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB7488:EE_
x-ms-office365-filtering-correlation-id: 2a6190af-aeca-467d-fa97-08db18d430e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6aZS3tkbTlrgowx7kEkZQ2W+x5q9ONg5f8rDv1C1FyvdRt/QJwa32DBltOaw7GDKmDCBg3mEzVzsd2jtYtPjTXHxvSZ8lY7ElzCKYLpMgAOoFUna6gORH01hbcj1ddzICo1wg7HFRrR3LZRe+kpBb+4IPwxb9ofjpXNsXTu5BiTxNR49ssMxHFgLXKIHrI5M6OEBdYeCeKw4cvG3NOD0M/L/Un2is+tITcizrdj1+k6awaYP0RQ0+pfCChEdLsvphTHzEYg8ELsLzZZ6cAL3gnjFIJnVFjbCV9mlNfwbPX/MA/ouNQgIgLTanbY9gfKFndZmZU6l0Bv6mGT9Ps9qiGE6UGoRZyu9pLNjoX9C7zF0O4tEAFqqgNkR1rQrWj0fXWvgMTQxMvjmObWXqR8fH594c8PmDTdGqbkmegzMpSuQf8zhIQ7mi1E09Zv5hOJ2I64d11TU2p2A6+OAe4g7ceobH3EtulGaGw3gUlsolVzkT2HTeDNEhPjKXkQxQfWmB8iSRCi83hC+86ytqd0rXNQmYozsMA9thNwV1ZHSsFOGkY1j1LZd/dcL3i8WGVyqbzf7r88rvgH0JatHQSjusYaKEt+N1FRGziWclyqUVm3mee+FO4LqQHTFy2jjIPjyurcczx4YTKVNwVJ1dWMXJ/FR9N35VfXcP1+8xatyIJRMc155jEUfaD3oIykVvht1gZkYoe9ZrRfZcREgv2/iOpj/YU1E99uEG4XyxOqT93J3SzrhWHviuQBJhBTMD8+Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199018)(6512007)(186003)(71200400001)(26005)(478600001)(6486002)(8676002)(316002)(91956017)(66556008)(66476007)(83380400001)(66946007)(66446008)(54906003)(76116006)(4326008)(64756008)(53546011)(2616005)(6506007)(6916009)(41300700001)(8936002)(5660300002)(122000001)(38100700002)(2906002)(36756003)(86362001)(38070700005)(33656002)(2004002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmRPSVA2QllTUjJUTUR5cEhGR3FXb3NiY0tjZEFTSVlJVEw3YXdFNDEyaFhn?=
 =?utf-8?B?MUtwYXcrZ2lYdVR3aTNZR21tVVp2OUpwc2g1bjVOWjFHR3FJQmZEeEw4YUNp?=
 =?utf-8?B?UGRIZ2ltMDR3bk9vM2xCREJRejhXd3FCK3RWc2QwUW9jeE9uV3dYeFJtUzZu?=
 =?utf-8?B?QzFHeWRaY2E2TThtNjBGRVhWdHJWZ3ZwVUx1dEk5cjVXTkF4WUVJdCtoODU2?=
 =?utf-8?B?bnMvOUYydUVjR2xEcEVhWkt4R0VxcExUcnNkMFNROUtZOVVaT2s5Y09lR1Nr?=
 =?utf-8?B?bXFHYnlMbDI0SGRGNmhqRWVyTG1SME1qUEdMME9ISkFXRi9pOUFIcm44SVVY?=
 =?utf-8?B?dHVncXYrNnJxbjBRbGxQMkpCZlNaa2RiTmxidEhhaVVzb3QvZStva24wUGJt?=
 =?utf-8?B?VGR1Q1VyQWhUWmk3S1BWTVM3Wm9NQ1dKdG9XOVZtQzlsVndmWE02ME1RVU5R?=
 =?utf-8?B?R3dSdGJ5UlVjOWhkTDVpcjFWVUZxQlVVa3JqZEExQkNqcEFKbUIwNFdUc0tr?=
 =?utf-8?B?RnNpMXhEMzkrYnl3MEszVWwxejVmZWV4NlZqbCt5aG13TFdiRTVDWjZLcXZ6?=
 =?utf-8?B?OUpiSm1TY2U0VGZyUFp2R2MrK0Uxd0psOFlKeVQvbVgrOTExcnJmOVgrY2dC?=
 =?utf-8?B?djN5dWFhczljRVBnS1hrcUZqOVhid0ZEYjN6NFplQmhxaEhtZC9WTzdnSnJP?=
 =?utf-8?B?NXRXWFBnLzE2NE9Wb21HOE41MWYxTkYwRnNWemk4RDk0aEtxMGRLdU1YNDVO?=
 =?utf-8?B?ZHpLaTB6eUNqeC9BcEczc0o4ZDhGSEJ2anR5YVczWW9zQzVzM0F1QTJNOVJG?=
 =?utf-8?B?VGMwVTJaR2VyZUZQYjJjL0NQd0lta1VaSmIvc3JUZTJSbVhkMjhQZkx0WHBm?=
 =?utf-8?B?UzFtL01CM3AzL21IakFIdCtqdlhWeFNoMU1IYjlZYzJ6anZyMTh2b3JkOGl0?=
 =?utf-8?B?OVFDenJCZy95ejJXNm4zQW5GTmU0ZXhLRUM0ZEpMRjloYWxBWWRsTFNzZ1ZS?=
 =?utf-8?B?WXhpdFNhYzBBN2NtODBSYlZnK0dFZEkxM2VvSzVWSFlsTUJ3Rk94elZhQ1RM?=
 =?utf-8?B?SWx5dHVsZzhlKzZnaUNiV1EyMDR2Z1htMUxIb2tTTDFGWVVqVkFWSkZtOHYr?=
 =?utf-8?B?YUJKTUpjZGVwMnBSOEdJOWNZcUtUTVF4WGs3TGV2NTVpMXRmaDJrV2dMS1cw?=
 =?utf-8?B?ZitsTU5TUWQxV3RqejdSS0Rla2MrVE5TYjZ1d0tNV2ZyU0psdlpJZnFQakhq?=
 =?utf-8?B?VEN5cnVHcnU0cGZzWnFFeFVJamZHVjRHUHJ1Y1VvRWRhWCtxZ0tvTng2eVRS?=
 =?utf-8?B?VEJBODhnNW5MVlNhTFlIb2I4WmJBNjcydkgwNDZ5cWJROGJzVjllWDVwbm4x?=
 =?utf-8?B?bVl0ZkFobzZMdmFrVHlPZFlPdStiQWVNVEFGd1ZORnlLSjQ3ald4ZW5NRldz?=
 =?utf-8?B?aFB6ZzY2YmljbGpFY012dGxyVm9DU2xvVHJMTDY4Y3pqcW9RRkJHcTVPNEw2?=
 =?utf-8?B?QnZIbGlUZmhJMWtsSjBTejVBUEVid2wrYUVEbVBOSjNRWEgwanVjZjd4Umx1?=
 =?utf-8?B?Sm9JWXNrYnhKOXZzV3J1dTZLMGdOL2NjempSM1B0V1JLUUtvbUFaK2k1T1VS?=
 =?utf-8?B?TmRjeTNtY0pSeFEzbXhESUw5b0VBWWFXZFdibEQrdHJGNmZnY1ZQZGxySlY5?=
 =?utf-8?B?cDdJbEFyb0ZjV2sxcEZucFhyYkxwTTJBcW5MRU0wZ0RwMlVidzQ0aUV1blU2?=
 =?utf-8?B?M1czcHlqWGRwRVJvUXZTYlZnS0hPNFNUNUZya3ZyTUhyVTdHMDliVTZpcG40?=
 =?utf-8?B?aWV5NEJiR3FkWVpvZkNhQVUyK1pUZFdqcSt0bWZTSU9VR2MrbDlFWldyWjRv?=
 =?utf-8?B?MUhrdzIzSnZ4RG1Ca3phM3pHN1Z0Y25OQVJKMmgxVlA4VlJnNFJleldwZWxu?=
 =?utf-8?B?M0M0RDNlSjQ3dFJjOGVWcGFJMEpDZi9pVGErNGlTWE1NL0NpelhlNDExU0NX?=
 =?utf-8?B?L2VYQ25OVkNGZ01RT3NVSVdKUXpTUmVJekNhakJ1L0lpS25oTXQvMEdQYis5?=
 =?utf-8?B?OGVGeXM0dHZBNjVHVk1PUVZ1Z2dFKzJZNFVxdXNOUTNlWm9TZ0czUXh1NUJi?=
 =?utf-8?B?U0Z4d2Frc0JObjViWjE0dmIxdFltTlByeTc0TjJFLzNvSHdVR1Vua3BUWTZo?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9C3344A801A934F9BE3D3483B641CDD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: votkkYHQmJK9CEOEvM2JIVY+bf+2cSvB/3PDwQfC+3JBmupmwjQL5DRgfl1JTVa3nlJd90nA1wosJxjWGvU2yDo3W+Bttnp4o1ZSLeNmrP8LOgjR5a60X7zAcff/7sY5Vh+qhx5HQAaND0VEbJBIi+E2ygQy8CwZK27PsZ0JoY/Rw+CS/MhpC6XlgBuvqiD9NZfGiqxbnVmK56RBXljvoUf6j7EGVBEBLv1Q127O77KNRDDnLHHm3ArFldCL6CQyzgv7tZiy6BoBxR8ixYzqhbh5670383LTQBdJqXI81/VWu1RX2O8sfxjFGRwBpyDh8UYtAjKX6lx7WrR8IO7SUGgn6XXRNI8xsm4mhGU4RUGpdnW8rYSqMeVdv6fm/1O9mXE/LWQtGg6BhgAQMBrO9mlq8FBUo32Ye2JJi888PVgKmPtwh6rmed0H/N8aqshOuAxcK3l3GM89mAqPOA+shUaHz/QEBr4EMSXwJ/6MskxBd7Eh9V0BLmos1MJ1KfcEvTcF3cmkr1Ec0L+ppoW2miv2uI1O2nqLwrjGubuZbAza+PDJwbbovMy5R125fiac8O3U7lom6jvjbpy8R5G5PPv4IkmAKpe1Hp/lJ4f197XD04gA5Nb79se9c/8+sQhCeh6bZ+eF0Gw6NMGM/a28RiLNnIxBr13DAwRM60BdC/lnvWSCOs4dNzz+4caVi8HjmXHRUvyMQeb9V/fvnAPbvgYvllgBxOMCcFRtWddkoS3C2Cze+5hJ0rG+wqpw6Dlhe21rhhmh2z2MnJO5Eab7ZwsBCK7TR4kSlFD+PLLu9+f8EW9IFjL306q+3bHkQvQGdaOyzK1zbKkuFEdI9YblgWmYWMDgsiMSjdUlVevOeDsgxmrU7E+OUpH9lSVPmJ8uxzfp1849AAaMdNXmUvuqkC0TrWexipsmJpcerJeGXbU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6190af-aeca-467d-fa97-08db18d430e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 15:06:23.4837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hw8fSUboXEAS+zluxZN5m2nK/JsV6v+7XMKH6tc6hrB/F2+eYBx7JdVlzuSUwC6fyrsTen7y+SzlXY97fpd2fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7488
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_10,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302270115
X-Proofpoint-GUID: EifN7DCXWBpfjKzUVfb9jPjKXcCmAxo6
X-Proofpoint-ORIG-GUID: EifN7DCXWBpfjKzUVfb9jPjKXcCmAxo6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gT24gRmViIDI3LCAyMDIzLCBhdCA0OjUxIEFNLCBHZWVydCBVeXR0ZXJob2V2ZW4gPGdl
ZXJ0QGxpbnV4LW02OGsub3JnPiB3cm90ZToNCj4gDQo+IEhpIENodWNrLA0KPiANCj4gT24gVGh1
LCBGZWIgMjMsIDIwMjMgYXQgNTo1MiBQTSBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4
LW02OGsub3JnPiB3cm90ZToNCj4+IE9uIFRodSwgRmViIDIzLCAyMDIzIGF0IDU6MTkgUE0gQ2h1
Y2sgTGV2ZXIgSUlJIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToNCj4+Pj4gT24gRmVi
IDIzLCAyMDIzLCBhdCAxMDoxNiBBTSwgR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1t
NjhrLm9yZz4gd3JvdGU6DQo+Pj4gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgYWNjZXNzIGF0IHZp
cnR1YWwgYWRkcmVzcyBhZjA2ZGE4NA0KPj4gDQo+Pj4+IEkuZS4gYSBzbGlnaHRseSBkaWZmZXJl
bnQgY3Jhc2guDQo+Pj4+IEFzIHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gdGhlIHR3byBjcmFzaGVz
IGlzIG1vZHVsYXIgdnMuIGJ1aWx0aW4sDQo+Pj4+IHRoaXMgbG9va3MgbGlrZSBhbiBvdXQtb2Yt
Ym91bmQgYWNjZXNzIGluIHRoZSB0ZXN0Lg0KPiANCj4gSnVzdCByYW4gaXQgb24gcGh5c2ljYWwg
YXJtMzIgYW5kIGFybTY0IChSZW5lc2FzIEFQRTZFVk0gYW5kDQo+IFNhbHZhdG9yLVhTKSwgYW5k
IHRoZSB0ZXN0IGNyYXNoZXMgdGhlcmUsIHRvby4NCj4gDQo+Pj4gV2h5IG5vdCBydW4gdGhlIHRl
c3Qgc3VpdGUganVzdCBhcyBJIHN1Z2dlc3RlZD8NCj4gDQo+IGt1bml0X2tlcm5lbC5Db25maWdF
cnJvcjogbTY4ayBpcyBub3QgYSB2YWxpZCBhcmNoLCBvcHRpb25zIGFyZQ0KPiBbJ2FscGhhJywg
J2FybScsICdhcm02NCcsICdpMzg2JywgJ3Bvd2VycGMnLCAncmlzY3YnLCAnczM5MCcsICdzcGFy
YycsDQo+ICd4ODZfNjQnXQ0KPiANCj4gV2lsbCBsb29rIGludG8gYWRkaW5nIG02OGsgc3VwcG9y
dCA7LSkNCj4gDQo+IEJ1dCB0aGUgaXNzdWUgY2FuIGVhc2lseSBiZSByZXByb2R1Y2VkIHVzaW5n
DQo+ICIuLi4vdG9vbHMvdGVzdGluZy9rdW5pdC9rdW5pdC5weSBydW4gLS1hcmNoPWFybQ0KPiAt
LWNyb3NzX2NvbXBpbGU9YXJtLWxpbnV4LWdudWVhYmloZi0gLS1yYXdfb3V0cHV0PWFsbCAtLWt1
bml0Y29uZmlnDQo+IC4vbmV0L3N1bnJwYy8ua3VuaXRjb25maWciIG9uIGN1cnJlbnQgdXBzdHJl
YW1bMV06DQo+IA0KPiBLVEFQIHZlcnNpb24gMQ0KPiAxLi41DQo+ICAgIEtUQVAgdmVyc2lvbiAx
DQo+ICAgICMgU3VidGVzdDogUkZDIDM5NjEgdGVzdHMNCj4gICAgMS4uMg0KPiAgICAgICAgS1RB
UCB2ZXJzaW9uIDENCj4gICAgICAgICMgU3VidGVzdDogUkZDIDM5NjEgbi1mb2xkDQo+ICAgICAg
ICBvayAxIDY0LWZvbGQoIjAxMjM0NSIpDQo+ICAgICAgICBvayAyIDU2LWZvbGQoInBhc3N3b3Jk
IikNCj4gICAgICAgIG9rIDMgNjQtZm9sZCgiUm91Z2ggQ29uc2Vuc3VzLCBhbmQgUnVubmluZyBD
b2RlIikNCj4gICAgICAgIG9rIDQgMTY4LWZvbGQoInBhc3N3b3JkIikNCj4gICAgICAgIG9rIDUg
MTkyLWZvbGQoIk1BU1NBQ0hWU0VUVFMgSU5TVElUVlRFIE9GIFRFQ0hOT0xPR1kiKQ0KPiAgICAg
ICAgb2sgNiAxNjgtZm9sZCgiUSIpDQo+ICAgICAgICBvayA3IDE2OC1mb2xkKCJiYSIpDQo+ICAg
ICAgICBvayA4IDY0LWZvbGQoImtlcmJlcm9zIikNCj4gICAgICAgIG9rIDkgMTI4LWZvbGQoImtl
cmJlcm9zIikNCj4gICAgICAgIG9rIDEwIDE2OC1mb2xkKCJrZXJiZXJvcyIpDQo+ICAgICAgICBv
ayAxMSAyNTYtZm9sZCgia2VyYmVyb3MiKQ0KPiAgICAjIFJGQyAzOTYxIG4tZm9sZDogcGFzczox
MSBmYWlsOjAgc2tpcDowIHRvdGFsOjExDQo+ICAgIG9rIDEgUkZDIDM5NjEgbi1mb2xkDQo+ICAg
ICAgICBLVEFQIHZlcnNpb24gMQ0KPiAgICAgICAgIyBTdWJ0ZXN0OiBSRkMgMzk2MSBrZXkgZGVy
aXZhdGlvbg0KPiAgICAgICAgb2sgMSBkZXMzLWhtYWMtc2hhMSBrZXkgZGVyaXZhdGlvbiBjYXNl
IDENCj4gICAgICAgIG9rIDIgZGVzMy1obWFjLXNoYTEga2V5IGRlcml2YXRpb24gY2FzZSAyDQo+
ICAgICAgICBvayAzIGRlczMtaG1hYy1zaGExIGtleSBkZXJpdmF0aW9uIGNhc2UgMw0KPiAgICAg
ICAgb2sgNCBkZXMzLWhtYWMtc2hhMSBrZXkgZGVyaXZhdGlvbiBjYXNlIDQNCj4gICAgICAgIG9r
IDUgZGVzMy1obWFjLXNoYTEga2V5IGRlcml2YXRpb24gY2FzZSA1DQo+ICAgICAgICBvayA2IGRl
czMtaG1hYy1zaGExIGtleSBkZXJpdmF0aW9uIGNhc2UgNg0KPiAgICAgICAgb2sgNyBkZXMzLWht
YWMtc2hhMSBrZXkgZGVyaXZhdGlvbiBjYXNlIDcNCj4gICAgICAgIG9rIDggZGVzMy1obWFjLXNo
YTEga2V5IGRlcml2YXRpb24gY2FzZSA4DQo+ICAgICAgICBvayA5IGRlczMtaG1hYy1zaGExIGtl
eSBkZXJpdmF0aW9uIGNhc2UgOQ0KPiAgICAjIFJGQyAzOTYxIGtleSBkZXJpdmF0aW9uOiBwYXNz
OjkgZmFpbDowIHNraXA6MCB0b3RhbDo5DQo+ICAgIG9rIDIgUkZDIDM5NjEga2V5IGRlcml2YXRp
b24NCj4gIyBSRkMgMzk2MSB0ZXN0czogcGFzczoyIGZhaWw6MCBza2lwOjAgdG90YWw6Mg0KPiAj
IFRvdGFsczogcGFzczoyMCBmYWlsOjAgc2tpcDowIHRvdGFsOjIwDQo+IG9rIDEgUkZDIDM5NjEg
dGVzdHMNCj4gICAgS1RBUCB2ZXJzaW9uIDENCj4gICAgIyBTdWJ0ZXN0OiBSRkMgMzk2MiBzdWl0
ZQ0KPiAgICAxLi4yDQo+ICAgICAgICBLVEFQIHZlcnNpb24gMQ0KPiAgICAgICAgIyBTdWJ0ZXN0
OiBSRkMgMzk2MiBlbmNyeXB0aW9uDQo+ICAgICAgICBvayAxIEVuY3J5cHQgd2l0aCBhZXMxMjgt
Y3RzLWhtYWMtc2hhMS05NiBjYXNlIDENCj4gICAgICAgIG9rIDIgRW5jcnlwdCB3aXRoIGFlczEy
OC1jdHMtaG1hYy1zaGExLTk2IGNhc2UgMg0KPiAgICAgICAgb2sgMyBFbmNyeXB0IHdpdGggYWVz
MTI4LWN0cy1obWFjLXNoYTEtOTYgY2FzZSAzDQo+ICAgICAgICBvayA0IEVuY3J5cHQgd2l0aCBh
ZXMxMjgtY3RzLWhtYWMtc2hhMS05NiBjYXNlIDQNCj4gICAgICAgIG9rIDUgRW5jcnlwdCB3aXRo
IGFlczEyOC1jdHMtaG1hYy1zaGExLTk2IGNhc2UgNQ0KPiAgICAgICAgb2sgNiBFbmNyeXB0IHdp
dGggYWVzMTI4LWN0cy1obWFjLXNoYTEtOTYgY2FzZSA2DQo+ICAgICMgUkZDIDM5NjIgZW5jcnlw
dGlvbjogcGFzczo2IGZhaWw6MCBza2lwOjAgdG90YWw6Ng0KPiAgICBvayAxIFJGQyAzOTYyIGVu
Y3J5cHRpb24NCj4gODwtLS0gY3V0IGhlcmUgLS0tDQo+IFVuYWJsZSB0byBoYW5kbGUga2VybmVs
IHBhZ2luZyByZXF1ZXN0IGF0IHZpcnR1YWwgYWRkcmVzcyA3MzY1NzQyMCB3aGVuIGV4ZWN1dGUN
Cj4gWzczNjU3NDIwXSAqcGdkPTAwMDAwMDAwDQo+IEludGVybmFsIGVycm9yOiBPb3BzOiA4MDAw
MDAwNSBbIzFdIEFSTQ0KPiBDUFU6IDAgUElEOiAxIENvbW06IHN3YXBwZXIgVGFpbnRlZDogRyAg
ICAgICAgICAgICAgICAgTg0KPiA2LjIuMC0xMjQ4Ni1nODVmMzQxMjcyZmE5ICMxDQo+IEhhcmR3
YXJlIG5hbWU6IEdlbmVyaWMgRFQgYmFzZWQgc3lzdGVtDQo+IFBDIGlzIGF0IDB4NzM2NTc0MjAN
Cj4gTFIgaXMgYXQga3VuaXRfcnVuX3Rlc3RzKzB4M2NjLzB4NWU4DQo+IHBjIDogWzw3MzY1NzQy
MD5dICAgIGxyIDogWzxjMDJkMGU1ND5dICAgIHBzcjogMjAwMDAwNTMNCj4gc3AgOiBmMDgwOWNj
OCAgaXAgOiBmMDgwOWU1NCAgZnAgOiAwMDAwMDAwNg0KPiByMTA6IGMwNjlkYzMwICByOSA6IGMw
NjlkZDg0ICByOCA6IGYwODA5ZTU0DQo+IHI3IDogMDAwMDAwMDAgIHI2IDogMDAwMDAwMDYgIHI1
IDogYzA4YTg1MDQgIHI0IDogYzA4YTgyZDANCj4gcjMgOiA3MzY1NzQyMCAgcjIgOiAwMDAwMDAw
MiAgcjEgOiBmMDgwOWU1NCAgcjAgOiAwMDAwMDAwMA0KPiBGbGFnczogbnpDdiAgSVJRcyBvbiAg
RklRcyBvZmYgIE1vZGUgU1ZDXzMyICBJU0EgQVJNICBTZWdtZW50IG5vbmUNCj4gQ29udHJvbDog
MTBjNTNjN2QgIFRhYmxlOiA0MDAwNDA1OSAgREFDOiAwMDAwMDA1MQ0KPiBSZWdpc3RlciByMCBp
bmZvcm1hdGlvbjogTlVMTCBwb2ludGVyDQo+IFJlZ2lzdGVyIHIxIGluZm9ybWF0aW9uOiAyLXBh
Z2Ugdm1hbGxvYyByZWdpb24gc3RhcnRpbmcgYXQgMHhmMDgwODAwMA0KPiBhbGxvY2F0ZWQgYXQg
a2VybmVsX2Nsb25lKzB4OTQvMHgyZmMNCj4gUmVnaXN0ZXIgcjIgaW5mb3JtYXRpb246IG5vbi1w
YWdlZCBtZW1vcnkNCj4gUmVnaXN0ZXIgcjMgaW5mb3JtYXRpb246IG5vbi1wYWdlZCBtZW1vcnkN
Cj4gUmVnaXN0ZXIgcjQgaW5mb3JtYXRpb246IG5vbi1zbGFiL3ZtYWxsb2MgbWVtb3J5DQo+IFJl
Z2lzdGVyIHI1IGluZm9ybWF0aW9uOiBub24tc2xhYi92bWFsbG9jIG1lbW9yeQ0KPiBSZWdpc3Rl
ciByNiBpbmZvcm1hdGlvbjogbm9uLXBhZ2VkIG1lbW9yeQ0KPiBSZWdpc3RlciByNyBpbmZvcm1h
dGlvbjogTlVMTCBwb2ludGVyDQo+IFJlZ2lzdGVyIHI4IGluZm9ybWF0aW9uOiAyLXBhZ2Ugdm1h
bGxvYyByZWdpb24gc3RhcnRpbmcgYXQgMHhmMDgwODAwMA0KPiBhbGxvY2F0ZWQgYXQga2VybmVs
X2Nsb25lKzB4OTQvMHgyZmMNCj4gUmVnaXN0ZXIgcjkgaW5mb3JtYXRpb246IG5vbi1zbGFiL3Zt
YWxsb2MgbWVtb3J5DQo+IFJlZ2lzdGVyIHIxMCBpbmZvcm1hdGlvbjogbm9uLXNsYWIvdm1hbGxv
YyBtZW1vcnkNCj4gUmVnaXN0ZXIgcjExIGluZm9ybWF0aW9uOiBub24tcGFnZWQgbWVtb3J5DQo+
IFJlZ2lzdGVyIHIxMiBpbmZvcm1hdGlvbjogMi1wYWdlIHZtYWxsb2MgcmVnaW9uIHN0YXJ0aW5n
IGF0IDB4ZjA4MDgwMDANCj4gYWxsb2NhdGVkIGF0IGtlcm5lbF9jbG9uZSsweDk0LzB4MmZjDQo+
IFByb2Nlc3Mgc3dhcHBlciAocGlkOiAxLCBzdGFjayBsaW1pdCA9IDB4KHB0cnZhbCkpDQo+IFN0
YWNrOiAoMHhmMDgwOWNjOCB0byAweGYwODBhMDAwKQ0KPiA5Y2MwOiAgICAgICAgICAgICAgICAg
ICBjMDZiNjE1NCBmMDgwOWQ1NCAwMDAwMDAwNiBjMDE0NDNkOCAwMDAwMDAwMCAwMDAwMDAwMA0K
PiA5Y2UwOiAwMDAwMDAwMCAwMDAwMDAwMCBjMDg4YThjMCBjMDY5ZGQxYyBjMDY5ZGQzOCBjMDY5
OGQ2YyAwMDAwMDAwMCAwMDAwMDAwMQ0KPiA5ZDAwOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAw
MSAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMA0KPiA5ZDIwOiAw
MDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAw
MDAwMCAwMDAwMDAwMA0KPiA5ZDQwOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAw
MCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMA0KPiA5ZDYwOiAwMDAwMDAwMCAw
MDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAw
MDAwMA0KPiA5ZDgwOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAw
MCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMA0KPiA5ZGEwOiAwMDAwMDAwMCAwMDAwMDAwMCAw
MDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMA0KPiA5
ZGMwOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAw
MCAwMDAwMDAwMCAwMDAwMDAwMA0KPiA5ZGUwOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAw
MDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMA0KPiA5ZTAwOiAwMDAw
MDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAw
MCAwMDAwMDAwMA0KPiA5ZTIwOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAw
MDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMA0KPiA5ZTQwOiAwMDAwMDAwMCAwMDAw
MDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCA3MjYzNmUwMCAyMDc0NzA3OSA2ODc0Njk3
Nw0KPiA5ZTYwOiA3MzY1NjEyMCAyZDM4MzIzMSAyZDczNzQ2MyA2MzYxNmQ2OCA2MTY4NzMyZCAz
NjM5MmQzMSA3MzYxNjMyMCAwMDM2MjA2NQ0KPiA5ZTgwOiAyMjU5NDc0ZiAwMDAwMDAyOSA4MDAw
MDBkMyAzZmZmZjA0OSAwMDAwMDAwYyAwMDMxMzYwMSAwMDAwMDA0YSAwMDAwMDAwMA0KPiA5ZWEw
OiBjMDg5NDQ4MCBmZjc1ODNhMiAwMDAwMDAwNCBmZmZmZmZmZiAwMDAwMDAwMCBjMDY5ZTUyMCAw
MDAwMDAwMCBjMDcyMTg1Yw0KPiA5ZWMwOiBjMDcyMTgzYyBjMDE0MWVhYyBmMDgwOWYxYyBjMDMx
ZmQ1YyAwMjUxZjRhMiBmZjc1ODNhMiBjMDcyN2YxMCBjMDhkOTMyYw0KPiA5ZWUwOiBjMDcyN2Yx
NCAwMDAwMDAwMiAwMDAwMDAwNSBjMDgwNDIwNSAwMDAwMDAwMCBjMDcyMTgzYyBjMDcwMDUxMCBj
MDJkMTE2MA0KPiA5ZjAwOiBjMGNmNTM0ZSBjMDUwZjQ2MCBmMDgwOWYxYyAwMDAwMDAwNSBjMDcy
N2YxMCBjMGNmNTM0MCAwMDAwMDAwMCAwMDAwMDAwMQ0KPiA5ZjIwOiBjMDcyMTg1YyBjMDJkMmU5
NCBjMGMwMTEwMCBjMDcyN2YyNCBjMDcyN2YxMCBjMDhkOTMxOCBjMDcyMTg1YyBjMDgwNmNkMA0K
PiA5ZjQwOiBjMDcyODc1MCBjMGNmNTM0MCBjMDZiOTgwOCBjMDZiNzNlMCBjMDcyMTg1YyBjMDcy
MTgzYyBjMDcwMDUxMCBjMDcwMTVmNA0KPiA5ZjYwOiAwMDAwMDAwNyAwMDAwMDAwNyAwMDAwMDAw
MCBjMDcwMDUxMCAwMDAwMDAwMiAwMDAwMDA1ZCBjMGM1YzAwMCBjMDgwNDIwMA0KPiA5ZjgwOiBj
MDUxNWRkOCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAw
MDAwMCBjMDUxNWRmMA0KPiA5ZmEwOiAwMDAwMDAwMCBjMDUxNWRkOCAwMDAwMDAwMCBjMDEwMDE0
OCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMA0KPiA5ZmMwOiAwMDAwMDAwMCAw
MDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAw
MDAwMA0KPiA5ZmUwOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAx
MyAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMA0KPiBrdW5pdF9ydW5fdGVzdHMgZnJvbSBfX2t1
bml0X3Rlc3Rfc3VpdGVzX2luaXQrMHhjMC8weDFhOA0KPiBfX2t1bml0X3Rlc3Rfc3VpdGVzX2lu
aXQgZnJvbSBrdW5pdF9ydW5fYWxsX3Rlc3RzKzB4MjRjLzB4NDFjDQo+IGt1bml0X3J1bl9hbGxf
dGVzdHMgZnJvbSBrZXJuZWxfaW5pdF9mcmVlYWJsZSsweDIwYy8weDI1OA0KPiBrZXJuZWxfaW5p
dF9mcmVlYWJsZSBmcm9tIGtlcm5lbF9pbml0KzB4MTgvMHgxNDQNCj4ga2VybmVsX2luaXQgZnJv
bSByZXRfZnJvbV9mb3JrKzB4MTQvMHgyYw0KPiBFeGNlcHRpb24gc3RhY2soMHhmMDgwOWZiMCB0
byAweGYwODA5ZmY4KQ0KPiA5ZmEwOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMA0KPiA5ZmMwOiAwMDAwMDAwMCAw
MDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAw
MDAwMA0KPiA5ZmUwOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAx
MyAwMDAwMDAwMA0KPiBDb2RlOiBiYWQgUEMgdmFsdWUNCj4gLS0tWyBlbmQgdHJhY2UgMDAwMDAw
MDAwMDAwMDAwMCBdLS0tDQo+IEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBBdHRlbXB0ZWQg
dG8ga2lsbCBpbml0ISBleGl0Y29kZT0weDAwMDAwMDBiDQo+IA0KPiBbMV0gODVmMzQxMjcyZmE5
ID0gZjNhMjQzOWYyMGQ5MTg5MyAoIk1lcmdlIHRhZyAncnByb2MtdjYuMycgb2YNCj4gICAgZ2l0
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3JlbW90ZXByb2MvbGlu
dXgiKSArDQo+ICAgIGEgY2hlcnJ5LXBpY2sgb2YgYSBmaXggZm9yIGEgcmVncmVzc2lvbiBvbiBt
eSBhcm02NCBwbGF0Zm9ybXMpDQoNCkknbSBzdGlsbCBub3QgYWJsZSB0byByZXByb2R1Y2U6DQoN
CltjZWxAYmF6aWxsZSBvZGQtcmVsZWFzZXNdJCB0b29scy90ZXN0aW5nL2t1bml0L2t1bml0LnB5
IHJ1biAtLWFyY2g9YXJtDQotLWNyb3NzX2NvbXBpbGU9YXJtLWxpbnV4LWdudWVhYmloZi0gLS1y
YXdfb3V0cHV0PWFsbCAtLWt1bml0Y29uZmlnDQouL25ldC9zdW5ycGMvLmt1bml0Y29uZmlnDQpb
MTA6MDQ6MTRdIENvbmZpZ3VyaW5nIEtVbml0IEtlcm5lbCAuLi4NCkdlbmVyYXRpbmcgLmNvbmZp
ZyAuLi4NClBvcHVsYXRpbmcgY29uZmlnIHdpdGg6DQokIG1ha2UgQVJDSD1hcm0gTz0ua3VuaXQg
b2xkZGVmY29uZmlnDQpbMTA6MDQ6MThdIEJ1aWxkaW5nIEtVbml0IEtlcm5lbCAuLi4NClBvcHVs
YXRpbmcgY29uZmlnIHdpdGg6DQokIG1ha2UgQVJDSD1hcm0gTz0ua3VuaXQgb2xkZGVmY29uZmln
DQpCdWlsZGluZyB3aXRoOg0KJCBtYWtlIEFSQ0g9YXJtIE89Lmt1bml0IC0tam9icz00DQpFUlJP
Ujpyb290OmdjYzogZXJyb3I6IHVucmVjb2duaXplZCBhcmd1bWVudCBpbiBvcHRpb24g4oCYLW1h
Ymk9YWFwY3MtbGludXjigJkNCmdjYzogbm90ZTogdmFsaWQgYXJndW1lbnRzIHRvIOKAmC1tYWJp
PeKAmSBhcmU6IG1zIHN5c3YNCmdjYzogZXJyb3I6IHVucmVjb2duaXplZCBhcmd1bWVudCBpbiBv
cHRpb24g4oCYLW1hYmk9YWFwY3MtbGludXjigJkNCmdjYzogbm90ZTogdmFsaWQgYXJndW1lbnRz
IHRvIOKAmC1tYWJpPeKAmSBhcmU6IG1zIHN5c3YNCmdjYzogZXJyb3I6IHVucmVjb2duaXplZCBj
b21tYW5kLWxpbmUgb3B0aW9uIOKAmC1tbGl0dGxlLWVuZGlhbuKAmQ0KZ2NjOiBlcnJvcjogdW5y
ZWNvZ25pemVkIGNvbW1hbmQtbGluZSBvcHRpb24g4oCYLW1saXR0bGUtZW5kaWFu4oCZDQpnY2M6
IGVycm9yOiB1bnJlY29nbml6ZWQgY29tbWFuZC1saW5lIG9wdGlvbiDigJgtbXRwPWNwMTXigJkN
CmdjYzogZXJyb3I6IHVucmVjb2duaXplZCBjb21tYW5kLWxpbmUgb3B0aW9uIOKAmC1tdHA9Y3Ax
NeKAmQ0KZ2NjOiBlcnJvcjogdW5yZWNvZ25pemVkIGNvbW1hbmQtbGluZSBvcHRpb24g4oCYLW1m
cHU9dmZw4oCZDQptYWtlWzJdOiAqKiogWy4uL3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjUyOiBz
Y3JpcHRzL21vZC9lbXB0eS5vXSBFcnJvciAxDQptYWtlWzJdOiAqKiogV2FpdGluZyBmb3IgdW5m
aW5pc2hlZCBqb2JzLi4uLg0KZ2NjOiBlcnJvcjogdW5yZWNvZ25pemVkIGNvbW1hbmQtbGluZSBv
cHRpb24g4oCYLW1mcHU9dmZw4oCZDQptYWtlWzJdOiAqKiogWy4uL3NjcmlwdHMvTWFrZWZpbGUu
YnVpbGQ6MTE0OiBzY3JpcHRzL21vZC9kZXZpY2V0YWJsZS1vZmZzZXRzLnNdIEVycm9yIDENCm1h
a2VbMV06ICoqKiBbL2hvbWUvY2VsL3NyYy9saW51eC9vZGQtcmVsZWFzZXMvTWFrZWZpbGU6MTI5
NzogcHJlcGFyZTBdIEVycm9yIDINCm1ha2U6ICoqKiBbTWFrZWZpbGU6MjQyOiBfX3N1Yi1tYWtl
XSBFcnJvciAyDQoNCi1iYXNoOiAtLWNyb3NzX2NvbXBpbGU9YXJtLWxpbnV4LWdudWVhYmloZi06
IGNvbW1hbmQgbm90IGZvdW5kDQotYmFzaDogLi9uZXQvc3VucnBjLy5rdW5pdGNvbmZpZzogUGVy
bWlzc2lvbiBkZW5pZWQNCltjZWxAYmF6aWxsZSBvZGQtcmVsZWFzZXNdJCBnY2MgLS12ZXJzaW9u
DQpnY2MgKEdDQykgMTIuMi4xIDIwMjIxMTIxIChSZWQgSGF0IDEyLjIuMS00KQ0KQ29weXJpZ2h0
IChDKSAyMDIyIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgSW5jLg0KVGhpcyBpcyBmcmVlIHNv
ZnR3YXJlOyBzZWUgdGhlIHNvdXJjZSBmb3IgY29weWluZyBjb25kaXRpb25zLiAgVGhlcmUgaXMg
Tk8NCndhcnJhbnR5OyBub3QgZXZlbiBmb3IgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9S
IEEgUEFSVElDVUxBUiBQVVJQT1NFLg0KDQpbY2VsQGJhemlsbGUgb2RkLXJlbGVhc2VzXSQNCg0K
V2hhdCBhbSBJIG1pc3Npbmc/DQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0KDQo=
