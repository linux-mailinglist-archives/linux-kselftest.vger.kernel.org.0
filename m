Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3851949C2FA
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 06:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiAZFTT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 00:19:19 -0500
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101]:3445 "EHLO
        esa14.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229691AbiAZFTT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 00:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1643174359; x=1674710359;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w354+iA3r9EV9zZlhoghU/gBgsKWKaINENblzSjClJM=;
  b=FqAi800tZStXu5fa94ALIltxmFz3UMTzMI4Lz2GtECRdAtW5xz6O+yjR
   pj/zi3cRUji6Ue3pTHQrrFRpKBjhpdftRZ96NHmLL/HTr2fNPhHLnLg1z
   c8dUwWUPy894AdZFTGn+4LYvCcdCPHUQokh0hpKadE1UrFbi9G6xoeRQH
   SM3xnopO1d9xtyFajETzA/vLAzKV46I6x85+Pxr0j3zWWPnHk+Evvnu5v
   4LtwGmy/MKbm/dHtrhFDVoqdPeiTFcEhPehdOw4nEmZH8f8Vx2dhwvp4U
   rhHlxW9xeH1868wsJ+MS/ZjHDianmBt1CIHAeYLaRPeEwLhyBT/ga6MOL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="48253216"
X-IronPort-AV: E=Sophos;i="5.88,316,1635174000"; 
   d="scan'208";a="48253216"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 14:19:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZP8nYKQfk+pUCZy7+YeoLxMHv71sXJHu8/HZhqC7G30hrPEuQ4gLx/TiXk70+H4Hxgf1cj2gwIumqqFpBDspuAd27gWRKuqQNkBvWdNGsDetv4OTqHI/UXPLLNv0WCCVXML/xJ/7avdJ45F7MnFzX+Jh2e3ZFCuk29clz1rTMPmbjifIselzo5LyAcFt5jp7d6hdqIqxIdeaHg1CUvlZaBMVOB/vTyPz09qCqd7UpjtcM++9OhuUfzi2FHYwaBm/kHNvVb8WB+3YWzxumLNCwzNwn2aafjec+u8jS3yGHtlTeM6pGQYOjXQfikCixgMmO0N+vw2fBgSm+SbH68pYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w354+iA3r9EV9zZlhoghU/gBgsKWKaINENblzSjClJM=;
 b=VZL9DN5CX/uRoESrBVYaXtuOvfAm75n7dx9YvgK9WN/9aa3h1rH4vDcI5Gf1cstsjalXT4NkuGHkrdJZTpV3CPh7Vxj5YKq0BtvEiHQbYXrasZHlIcL4MnJD4EVOQ/jU2k1/9qlzx8EIuFCi284sbDXhes2GSAGjCk32G09CivfGqvSc+6cLSZvs+V9DZQFuN9iTIM5t7hQczS+8RtO5UHiCBdXnGsPsRawksc0ifTODPBJCL7Aw8UqBah3ZzW1FIFjaEAwkIfrV2g3P6pODvNibyOnrhtZxjgvu2c7qMFAST2iDPJbv5QhYKq+u2dJRJjgi3WCIAvQ1w0hOXjr4pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w354+iA3r9EV9zZlhoghU/gBgsKWKaINENblzSjClJM=;
 b=qO4RjXZuLMgc54oH7ONp+BmvLV+UW9j9NbMLw7dR2Ei+e6esvnO5WTn7pbs5RJLtT6BOZPjBaJLrb1LBVrfWBaP0wP5Kl/lpBdpkAioEg3P5ghf00OnM5j9dNdDp6uT8dVx0vAqal5wW8tQXA/5pDNmlbiYRJI6p6ze/KChVHAQ=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB9450.jpnprd01.prod.outlook.com (2603:1096:400:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.14; Wed, 26 Jan
 2022 05:19:12 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f%5]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 05:19:12 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "naresh.kamboju@linaro.org" <naresh.kamboju@linaro.org>,
        "aleksei.kodanev@bell-sw.com" <aleksei.kodanev@bell-sw.com>,
        Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH 1/3] selftests/zram: Remove obsolete max_comp_streams
 interface
Thread-Topic: [PATCH 1/3] selftests/zram: Remove obsolete max_comp_streams
 interface
Thread-Index: AQHX8ZoRccDmFZwZgUelgvXxKr2pqqx0cnmAgACTAoA=
Date:   Wed, 26 Jan 2022 05:19:12 +0000
Message-ID: <61F0D9F7.1080200@fujitsu.com>
References: <1639562171-4434-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1146337d-718e-a369-1012-224f06bc9c2f@linuxfoundation.org>
In-Reply-To: <1146337d-718e-a369-1012-224f06bc9c2f@linuxfoundation.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d13af72-3c7e-4f67-2f09-08d9e08b63bd
x-ms-traffictypediagnostic: TYCPR01MB9450:EE_
x-microsoft-antispam-prvs: <TYCPR01MB9450031F82A03DEDBEA98F8CFD209@TYCPR01MB9450.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7NF1cERAJBDuv7ECVXBkwjWMuCj1X6KXCZQT6Tvq8O2t3rE7HpkfWxY7KG6fvPQw4W4cJ7XIZL6OHO34N5kdRZUPRgi5cE2Vaq6K1ofthmC/Hv36CmNTq/fUvLFsIiBZoxJ1KkxkiAUaayaFk03zX4dlF3g14HBfDvaJFCUWMTQ3kYqMIkyflsPI45Y1PC0z1hspAondTTqiduI/kbYBvNM9Tl17fZyM8clHS/bF03FuZ50Ftt8Ww7He4uv28Pf98MX/nObiEyVrLO5AHzWD4qYiMh8GmOH6w8IFdoOV3cQT/YsujHk4MNJapMAYQ6je//JvCWCnLpJu5ZTPrnK51Q55Kv8hdYCUchhRKpmBzz2EHXAw+kpg0zylFqErN52oxVTpLSTpW8g+ZsAuJdcx84g0GPPqNZ/KNIavNMc5p5HmAubUPauy2N5kP8pLkX146sxUyTgONqX+7EV9Wz/9snJE4q5c+OuGj31qHcnCQ64ZbI5AX5aKFsTl3yRq+uQA7R8lHd8rTfAn9KvTIdqG8ox0BL2PekXwNBX32BdF4LNxJphnE2TJ6vik42TM/LU9ZfzrL0sBwVuQL9fzsz45RZqrrB2IGIEdi5mZk0OPdRAUQsHNXKxkaXtyWLKh+3wZJl0em8iGKTpz/1nrQm+vkLZ+eYqsE9Oe3xthiwR1RAHb2/Hsub1NUqBGBc8FKvvNzblodelrwLpWkha1VmHI2m11O38D3fjgUpDa7AQPDGuvQZAkHCky2+UUblQj0YkenO2lRUCysYzVvaddi4rehxfvb2yqtXQCtGhtJvc26Ts=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(87266011)(82960400001)(6916009)(5660300002)(6512007)(8676002)(8936002)(38100700002)(122000001)(86362001)(53546011)(85182001)(186003)(6506007)(33656002)(6486002)(71200400001)(508600001)(966005)(66556008)(64756008)(66476007)(26005)(76116006)(38070700005)(36756003)(2906002)(66946007)(91956017)(66446008)(316002)(4326008)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enpWYnJiSnN0dVNoVWV0VVp2c04zZFJGMStUM1NMTDVaUXJSYzlWY2JxeDJo?=
 =?utf-8?B?bURYem9oRFp6cE93KzMzZUloS3JnUnhtRkM3K1JEZjdVSGxMREZacGZUOXVE?=
 =?utf-8?B?cDBQemQ3UGZYOGJsRWRlRzZKZUJJZTZmcndrTEp6OC9YVmNwbFhPSE1lMGVx?=
 =?utf-8?B?WUNBc2xCaXZva1lSb2JPc0pValhLVXB2YjB2anhKVXBSQkNxdWc5TEE2cnE5?=
 =?utf-8?B?Uk9pWDhSKytoVCtzWVJKeXhPTHNscDFObmNiUHROdUlud2ZYQUtCMnB3VGp4?=
 =?utf-8?B?cjErQ21rMzdkVWhNYWlaT1dwNkorWTJ2TU96Z1JXMWJXaHJEVlEyWWUvRnBk?=
 =?utf-8?B?TkxmUHAxdzJGZmF4eUtocm13T094cHhXWGt0ckJSVmtxa2hVMVVsZVRSR3dR?=
 =?utf-8?B?aGJlZjZDU2xLOFZnMW9raFVrWHFwQnFwUTU2bXh1ODFkZm9oRGwxM1k1VUlH?=
 =?utf-8?B?Sk5NWjlTU3pESHR3aGtmWll0TW9ZSlNJN2N1WkxtUTF3aGVFbEpBcnNQNDRN?=
 =?utf-8?B?TEFGUlRXZitENUtZeWNlcGFDVENRZ013ajF1eHJXZzdTcVVVaGJrL0lKdnNr?=
 =?utf-8?B?VVhhejFiK09XdEQrOUZKc2V6Z3lkUXRqTFNEdG90bklEL21mQ2hObVdFb2pC?=
 =?utf-8?B?MHN0TjVFb2JWY1RwSWtWUkM2bFoxbUYxTmxFUzJVMWlvbngvU0poOE5ObXBL?=
 =?utf-8?B?ekFUNU85bXMwN1JxdlZLL3FaK0NlKy8zdExydzFMRW03bG11M1Nvb0kvQ2RO?=
 =?utf-8?B?Vk83bWl1Sk1aN0tkbGt6bW5RUGgzb3N0T3R3aGNVaFZEeHpKM3hnR3VKelpH?=
 =?utf-8?B?RVNqanBaVitVc0kwMm92eUc3d3Bmc0gwSDBXcy9YQTRzdnVuZ1FlckExOWNw?=
 =?utf-8?B?KzlMWlZEV3haUDY5U1FGZWJvam5QYS9RbGU5M3l0SXlIcGJKaHY0S2NJMUZm?=
 =?utf-8?B?K1FtY1dwdDZFd0FDV0hMczJJMko4T1dBUVJRai93N2dUNWpoRVdjVUdEaDFq?=
 =?utf-8?B?ZW92aXJjR1RzVW9GOUFnaldrY2MvSVVzSXIxZXJxeHhyUC9FclA0RTkwNk5N?=
 =?utf-8?B?SWkvMjB3SFZxYUxwT3hpL2lNUnlhZzNOMzZhTlVoMDQvTHU1R2s3OVU2Vk9w?=
 =?utf-8?B?eVVxZkxUSW9LR1ZoRGp4QmVoK3d0ZjQvY3lmR0M3N0lydWU0dk1XeTNOMVZv?=
 =?utf-8?B?Wnk4U3FNQjJXbUkxZU9oQm95R0w0RmVDZEFMQVBaS1dXZUM1Nm54QkN4WnpL?=
 =?utf-8?B?TUVPT1BmZ0VjLzc1MjRMZGNPU1Y3b3BOdEpKOTcvN3ZKaWZWcXoyYUd6SVVI?=
 =?utf-8?B?dFcrZDlrZUNHUkF0T0crNm1XTXZRekpVSUdoUzFwLzVIb3NtS3JRUE9kWUZO?=
 =?utf-8?B?T2FVQ3l0a2p4OHE2OGRibk1BWlJzQy9iYU05cy9OU09wQ2Vra281UkhndUdZ?=
 =?utf-8?B?dXEzRFhaS2hsMjJnN3hmNnJ1aFVOMnV6SHh1ZjVjT1JDTjB2RVRueGExbU95?=
 =?utf-8?B?c3FVZEVBMmpIYVhHVmpXbFVSR3ZSQ21pUWk5ekpWUHRCNXVmMGdOd1ZnQ0F5?=
 =?utf-8?B?SEd0OVBObDNUcTNmVEttSFVGSXo5WFBERHNhcnpsMnViNE9RdiszRTBpRDJJ?=
 =?utf-8?B?KzBVSjlFWlVveGhXOUN4eExpMis0TmVNbUNuYUpHRjVmNHV5blhMMFZOVUlF?=
 =?utf-8?B?UTY0K0JEL3pUcngwSWdjc3pBWjVHcHRLUVJtS1dnOXRqNDJGVStPbnNuRXkr?=
 =?utf-8?B?Y1FvZXNWelZxUFh1ME5qcGdodWdJQkVxdzI1Q1NEZXZXZEorZ0hnZERkaFQ2?=
 =?utf-8?B?WlJVbDkzNVBISjdrWUc1UkhNM2R6OFJNQzFVWFhwb3RyVUtSTjlJeDN5NW8x?=
 =?utf-8?B?NVJxYzJOaVQrUkNLQ0Z2bHZtQ1lxeWdlWVo1RUdBNkYxRGY0WVJPUEFna1RH?=
 =?utf-8?B?ZlpYVVQ4akNuSjVwUUNOYldJUmU4OGRzcFltaTFEcmU1blhEL05NMkdaV0RF?=
 =?utf-8?B?ZjgxZHRwYVE1V2dST1BUbk82V3pSTllXT1dVOEZ4SVd5SzFFTlFjZGpkd1BY?=
 =?utf-8?B?YlFmTXNKSWhyTXIwOERCU0x1bGtHK2dQb21jUnVocnRpamJQc2dQbmFENkdl?=
 =?utf-8?B?OUZKdmRPbllpZFhGRTNsOWlURXdPRGErdHJveXkxQUs0MFhNUUdxaERKbDF0?=
 =?utf-8?B?RGJoWjBubnh1THBPQkZXS212clFlUE8ycWRxdHgxMFJnYmNuVFhKVWRBNWd2?=
 =?utf-8?Q?STT6jaZgS4pI6Z1YodPburNtHCtJiys6ykKExF1JAE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CB4707AB9317B4AB9CF9DC57D39E6D4@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d13af72-3c7e-4f67-2f09-08d9e08b63bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 05:19:12.7585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R6qGtUeWtbm+vfKYa1MdaiOgupF4fQrFX8P5rWDayB0CYXCWb5oRzXtH9vU2F6g6jZ+IfIR/3Ka2wSH8nmh8VTnrBnHkH/PDGlXkN5V5xB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9450
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

b24gMjAyMi8xLzI2IDQ6MzMsIFNodWFoIEtoYW4gd3JvdGUgOg0KPiBPbiAxMi8xNS8yMSAyOjU2
IEFNLCBZYW5nIFh1IHdyb3RlOg0KPj4gU2luY2Uga2VybmVsIGNvbW1pdCA0MzIwOWVhMmQxN2Eg
KCJ6cmFtOiByZW1vdmUgbWF4X2NvbXBfc3RyZWFtcw0KPj4gaW50ZXJuYWxzIiksIHpyYW0gaGFz
DQo+PiBzd2l0Y2hlZCB0byBwZXItY3B1IHN0cmVhbXMuIEV2ZW4ga2VybmVsIHN0aWxsIGtlZXAg
dGhpcyBpbnRlcmZhY2UgZm9yDQo+PiBzb21lIHJlYXNvbnMsIGJ1dA0KPj4gd3JpdGluZyB0byBt
YXhfY29tcF9zdHJlYW0gZG9lc24ndCB0YWtlIGFueSBlZmZlY3QuIFNvIHJlbW92ZSBpdC4NCj4N
Cj4gSSBnZXQgdGhhdCBtYXhfY29tcF9zdHJlYW0gZG9lc24ndCBkbyBhbnl0aGluZyBzaW5jZSB0
aGlzIHJlZmVyZW5jZWQNCj4gY29tbWl0LiBEb24ndCB3ZSBuZWVkIHRoaXMgdGVzdCBvbiBvbGRl
ciBrZXJuZWxzIHNpbmNlIG9sZGVyIGtlcm5lbHMNCj4gc3RpbGwgc3VwcG9ydCBtYXhfY29tcF9z
dHJlYW0/DQoNCkkgcmVhZCB0aGUgZm9sbG93aW5nIGluZm8gZnJvbSBrZXJuZWwgc2VsZnRlc3Qg
ZG9jdW1lbnRhdGlvbg0KaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvZGV2
LXRvb2xzL2tzZWxmdGVzdC5odG1sDQoNCiJUaGUga2VybmVsIGNvbnRhaW5zIGEgc2V0IG9mIOKA
nHNlbGYgdGVzdHPigJ0gdW5kZXIgdGhlIA0KdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvIGRpcmVj
dG9yeS4gVGhlc2UgYXJlIGludGVuZGVkIHRvIGJlIHNtYWxsIHRlc3RzIA0KdG8gZXhlcmNpc2Ug
aW5kaXZpZHVhbCBjb2RlIHBhdGhzIGluIHRoZSBrZXJuZWwuIFRlc3RzIGFyZSBpbnRlbmRlZCB0
byANCmJlIHJ1biBhZnRlciBidWlsZGluZywgaW5zdGFsbGluZyBhbmQgYm9vdGluZyBhIGtlcm5l
bC4iDQoNClNvLCB3ZSBjYW4gYnVpbGQgb2xkZXIga2VybmVsKHVzZSBvbGRlciBrZXJuZWwgc291
cmNlKSBpZiB3ZSB3YW50IHRvIA0KdGVzdCBvbGRlciBrZXJuZWwuDQoNCklNTywga2VyZW5sIHNl
bGZ0ZXN0IGlzIGRpZmZlcmVudCBmcm9tIG90aGVyIHRlc3RzdWl0KGllIGx0cCwgdGhpcyANCnNo
dW91bGQgdGhpbmsgYWJvdXQgYXBpIGNoYW5nZXMgYmVjYXVzZSBsdHAgbWF5IHRlc3Qgb24gZGlm
ZmVyZW50IGtlcm5lbCkuDQpBbHNvIGNjIGx0cCBjby1tYWludGFpbmVyIFBldHINCg0KT3IsIGRp
ZCBJIG1pc3Mgc29tZXRoaW5nPw0KDQpCZXN0IFJlZ2FyZHMNCllhbmcgWHUNCg0KDQo+DQo+IHRo
YW5rcywNCj4gLS0gU2h1YWgNCg==
