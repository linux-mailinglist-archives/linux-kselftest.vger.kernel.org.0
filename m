Return-Path: <linux-kselftest+bounces-14685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EC6945476
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 00:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23C02B22C12
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 22:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117CA14B08E;
	Thu,  1 Aug 2024 22:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="kg3yJBJX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3DD145352;
	Thu,  1 Aug 2024 22:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722550940; cv=fail; b=kzMZvgY1iqP9UjGGz7eRX0IbRpqqOCAkZBd44cbmS/pT9pRCnc/4q2WifVUknyUUZqXLezBYMgFDJC/232EHNRsDl5+pjYoruj9NrIrR9SOFbeaSqBe+zDGEBE1/xb2YJIdLxR3TUL3qsHEQoY0oQLQrAVB6URsLTjS02vns6WQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722550940; c=relaxed/simple;
	bh=W+u3Q1WO7AfG5hU2NY4sOGQhuP17o8XwQQ6v7cYX0Kc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W+v8wQGzfbc51ZIgLwINqhdb/5QZr4gSJnujCAAxrXI/pKpMWFlpKA02/X0nPTukh1+5plxYZ++tbvKhA/Eh2UTYXOPRQmzywXpSWI5YTLeNu55BIAHKoo5RqknpqYYu+8bYpJ51+WwXSVOP0xIQ0pgM0JtDG1S3TiUYBCRIgN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=kg3yJBJX; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471LcchE015998;
	Thu, 1 Aug 2024 22:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=W+u3Q1W
	O7AfG5hU2NY4sOGQhuP17o8XwQQ6v7cYX0Kc=; b=kg3yJBJX25ksethloGJ5mQn
	Jkry0N0k9VCPFdJ76aq96a00sQScKI9T7jOcgHn4nKoy2xij5Mrln5TkUak3JncZ
	Boo7uUfvi4tqWe8U4qEwwE7YfvyNHU8u6UYW8CKSVbwxjQsrgxCO2a4/82hgADSW
	vlwX3mFZRN/B77BMFIvO9XD0yKinppuN8Gokl5BLR/BC+WLFJsmAg9Hsr6C565QD
	HULk05rjXrrquKwlYjbRBwfP/XC2oBQ6ECAMv8Echh436bmzq3DKAQsGq7AASKJ7
	WWn++nqa9ex8vkCK0Sg3RHCF1adsiEYoNS3qyO50loEvBG+B4NMAykerX63NExA=
	=
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 40rje300h1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 22:04:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crN2piwD75nYiMO9M5mupFyMdeCNJRtYpOi78LZLDORydkJYQGPytye2zO+NDd/c3OfvOLflJ8Lo5lded3Bm9Lncdwe0q3BgbOFYhlmSdTCctQ6hXtac9CHhsIn9buacw8IQAZ0/g65/bR5AfsYz7u+YlAwqaJL0MmiaVCGrKdfEscoRiErSx+vUgUuIgT2ii0FbV2mt0KM4rvhpkbio8a2BE02m3h3TJeFxzO+2HuJxXTuA5zAfj2MrqDYALvs/dd0yFjkEBrTx2N35k4Cs/qQX3iTc3VJ7U7Ta/12uVYOIo5TFHVgEKWbtwTbQGc9Hm4uPUPGZjvR+p89x14PeUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+u3Q1WO7AfG5hU2NY4sOGQhuP17o8XwQQ6v7cYX0Kc=;
 b=k3womWUOUYftZPBnkr0riHl58Zw2ij7xjFQfGXMaiqEwE7Es3KXxR1OfNn+WiXF1svYz1EYpY/KWgFiWVAy+HmiNOAHA+eDdmjFShhk4GhGh2c7r2agiv2NKlrXgOLTtoGvfDFPKRUzyO7WVyuN3IxKdu/GX8WvRpxuWSdjNWvPCzx+VHRYD7CoARp1Vd2HT8vll1ncKORbSuD3DfyKO+p3swDQxoirLDt2SDe3izS9eWjtVE4vznFz80kspTgrEO7NpxQFMHBIYxgq+f1ijf0wCnxKL3MX7Rvm3HHhPDtOvN7TGzUs7TWFDrTlFPm1b7cfqR78/uhqSkbhd5w4yfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BN6PR13MB3041.namprd13.prod.outlook.com (2603:10b6:405:7b::18)
 by BN0PR13MB4632.namprd13.prod.outlook.com (2603:10b6:408:116::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 22:04:37 +0000
Received: from BN6PR13MB3041.namprd13.prod.outlook.com
 ([fe80::3661:5a0d:34d0:7c4]) by BN6PR13MB3041.namprd13.prod.outlook.com
 ([fe80::3661:5a0d:34d0:7c4%4]) with mapi id 15.20.7828.023; Thu, 1 Aug 2024
 22:04:36 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>
CC: Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Laura Nao <laura.nao@collabora.com>,
        Saravana
 Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "kernelci@lists.linux.dev"
	<kernelci@lists.linux.dev>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH RFC] kselftest: devices: Add test to detect missing
 devices
Thread-Topic: [PATCH RFC] kselftest: devices: Add test to detect missing
 devices
Thread-Index: AQHa3hIsyafIaRIb0kKQ4rHe6cO/ibIRhB2AgAFOAICAABAugIAADguAgAANzeA=
Date: Thu, 1 Aug 2024 22:04:36 +0000
Message-ID:
 <BN6PR13MB3041DEADD5F58C6D81C1DAA8FDB22@BN6PR13MB3041.namprd13.prod.outlook.com>
References: <20240724-kselftest-dev-exist-v1-1-9bc21aa761b5@collabora.com>
 <9d0b73ce-704c-4633-bb11-06ca4cb7a9a1@linuxfoundation.org>
 <f9a457c8-f558-4c45-96e0-baa97d143c7b@notapiano>
 <41a912af-4f59-4d54-a072-3de9ee912dee@linuxfoundation.org>
 <22688e55-b611-41b3-9bf0-06691454e3b1@notapiano>
In-Reply-To: <22688e55-b611-41b3-9bf0-06691454e3b1@notapiano>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR13MB3041:EE_|BN0PR13MB4632:EE_
x-ms-office365-filtering-correlation-id: 5920687f-d45a-4b62-a56a-08dcb275ee9d
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?czNxblZ2ZGowOGwyVWxsQ0U1TlRHVUpnR2g2WWVJQmdBZHg0QnhOeC9hQmxO?=
 =?utf-8?B?OVorQXl2bFdhdVR5WFlDeitMK0dkQ2t0MEtQNk9Jc1JFMkF6Um9PaklmY2o2?=
 =?utf-8?B?cGVxQVBtZm1EZXZUa2xGZXlTK29hNy9IWEc4QWtYZlB2WHdlZ2FUY2NzNUNG?=
 =?utf-8?B?VWtLbXRhSGNFMlVhdFN1T3BQQ0loU0NmK1ZHM0tFV1BIcVlHVXlPK2dReDJV?=
 =?utf-8?B?dmhGOTNLd1pTVEZNdkdiTURJc1YreC9kdnNXb09OTUJ1SnFKa3gzb2EzdVBv?=
 =?utf-8?B?RVhLYVRLRDhKQjZkUEc2b1N1R0hPZkhWYi92Nkdsa1JMbEVMbDNxd1QvanVa?=
 =?utf-8?B?UllqK0lsbXBhNFhPZW1GR0JPRFFMZGxCcGxvYlIrYU1iNWQrTkg4anEybWt4?=
 =?utf-8?B?WE9LaHlTS3RzWHF6WUwrVG5kMUcwUzJTQURHYTNGM0NpVFZidlJES0N5UWRL?=
 =?utf-8?B?cGxEdkMvUTRScTA3NFYydmtPNFhITm1MdGZNRGtkUmhzODRjNXhPRkNJYTJK?=
 =?utf-8?B?dzFiMTdveXpBZUxmQkM2ZlhrMDdkYzBSZG9Kc0VRN0k1Wk5GeEhUM3RnMDk3?=
 =?utf-8?B?YWN6Y1AvOHFuK3lZdnQwS2twWmNldjNKKzI0MkxJZTNOeFV2YTNtZkJnREN1?=
 =?utf-8?B?MU1hYzJPa2VOT1dhNm8vSmpkVTZBWUlTVU8wZXBvaFpKaFAyK0NNSkcxNzR4?=
 =?utf-8?B?R2FDUXl2NUxhSXhycWNseGF1RFlmMjlLeXIxUDg5TnBNeTlQRDBFV29OTlht?=
 =?utf-8?B?aDlkOWZMamV1WWVkOHZhcCtzN1llVS9JcWZaMUFRaWV1L3UyZEpnaDhXam9I?=
 =?utf-8?B?OFJNMitGeCtHbkNCK28vb1puK1MwRGFQdW04dnRyZFp0aWQ1UXBBYUpIdHlm?=
 =?utf-8?B?YjVQb0JzSC9scWtnS28vVDFBVmZCMVpQcWlSV0Z4TVhudEZ0L0YvQmRwdmxi?=
 =?utf-8?B?TlY3Z0p4S3RUTzBIMXVtUzZNcVdUbVkvMDUweTIybVFaVWViTUkxd1BwKzJQ?=
 =?utf-8?B?aFAzSVhXRXFEVk9IQWhuSlNZaHFSTWt1SnN2ZDhsTy9vUWI1eGJUMjF1N2RZ?=
 =?utf-8?B?MzJCTzU2QUprczdwUVJtU3VpTSt1cDBzeWVmRE1KTTI5bjB2RnRBMWZDSFFl?=
 =?utf-8?B?STdNQkd1Y0drVWF1WWhKVVBXa0FoVmVhTEc0R2tKamNTTlp2d1NZUllrdDJ4?=
 =?utf-8?B?ZStQOWtWQVAzTDVzMG11MU9LRmRCQ2lTV3ltb1RvMmR0cGVPMWQ0WXdycWk3?=
 =?utf-8?B?ZUVNVXJEWWFEeVFaY2RLa0J2TzNaNktOVU44QWo1RTFYM3dqUW5oOUhGL3Vx?=
 =?utf-8?B?YnhnTGVOMHlxMnM0UHRnTWw5ay9Ba3ZyZWR3L3l6TnFHdktwQkZwMmxyWlNr?=
 =?utf-8?B?MkV6QkFzeFRoR25CWnBWY29XdUpSVUYrZ0hCRVNjZm5XTkdvQzlBakdTN2xp?=
 =?utf-8?B?T0NPODc0NFZ5REZjYytLVVQzRWhDdVplbm1wR2t1QndZZ0pwdzAwZmNBbFZT?=
 =?utf-8?B?K1VEcjE4alQ1SWQ1c0J1VURwNk5aNmxFR0pVUExXRUtGVkVLM1dGYmZ0NkFq?=
 =?utf-8?B?RW4wQ0hnbGRTOGVIVEZqbURVOGxWRUpaSklKY2NSOWc4RHBQaHd6Smd5NkFX?=
 =?utf-8?B?OVZYOG8wV1Q4d2ZCdFRIYU9yaUR5WlJqNVA4ZEh6N2xycitHODdDVE4xdGZ5?=
 =?utf-8?B?Z1dmOVYrOU5XVEpjcDAxOVh1dDQ1dTJIQ2xkOG9sQ29DQXFZb1drRmVLeUU1?=
 =?utf-8?B?WXRTSFRtUHp6Q3UyU1R5RExjRnRyVkFFZzdVMzlKSUNqM092ejdaT2g2RXZU?=
 =?utf-8?B?L1diTjRkQThjSXVrbWZnSVVySllVcjV5b3p1cFJlQ2tPMFRYbTI0OVBBbmMy?=
 =?utf-8?B?b0FWc3JhOUZsVG9xTmVuZlJjSERuNGdIdDFFUnB4N1N1Unc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR13MB3041.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXUxSFMvQTlnL2F6RTlrTDhrQjF0Wi92bXhkcHZhSXpyY2tRVEQ5WVhFMzJy?=
 =?utf-8?B?YUgrUzZINTNIZWhNdVB2OEsyTkNoT3dOaUI4NjVSaW9BM2FWV3hJTWFiSFFL?=
 =?utf-8?B?T3J3U0djdEgrTGFDa1kvckl0N0luSkxSMXowWVN0T2M3c1lRRkdlcUlkY3BQ?=
 =?utf-8?B?djc2WURoclVmWVRSdDNyRTRWem8vNlYxVUhUazNVTEVIK1gyTDd0eCs3UDll?=
 =?utf-8?B?eFlUd2ZMOGxiZHlGRVRrQUlGZGlvQzc4cnVSYVlzNk1QNGZxeDhybGhqVmxp?=
 =?utf-8?B?cW84R2J5VEhlb0ZGNmFJTjZ4Wm55cmdTVHBFdmhka0EwcVRrREg2NElOY05X?=
 =?utf-8?B?aGdNQzl4NXBtSnVBTzJTVXVxbCs4ZXFhUWhxcFloZUIvWU4yQjFJTncrOGh3?=
 =?utf-8?B?Wm9SQzcrbUFYWnJRMXh1VUpRK1NseEFkYXRLZFFuM2pvbytHeDhvaTRkWGZZ?=
 =?utf-8?B?N0tJTlErWkNFTTFIVUhURTlLczlXTnlZdlU5YmplRVFwVEthNmh3V2kzYUlF?=
 =?utf-8?B?VGdRd2g1MGZDRnpZQ1lsZTBpa3BaeFJueVZUWERNWmtUTG5mZlRxODBTY1NP?=
 =?utf-8?B?OUpyMXZVdmNOV3VpTzlEQVduZjJNdTdxS01hM0hMNXJ1YkEvODkyQTZyN09U?=
 =?utf-8?B?dnBTeVMvYXBDQXpyNkUrZ2hCZDlmeWJhUUZKNHNzNW5rOEVaaEU5RW5nQURa?=
 =?utf-8?B?Nm8yY29PQXVaVDlzcU4vdTZxaHZabCt5RUZmTnZDYWthZnMyTDRyWlpyV0VJ?=
 =?utf-8?B?Z2p1RWlLNnd6YlRNSTkyK0V6UmMzT1M5WExGa3ZWWXRvNFl5L21oajZnTGRn?=
 =?utf-8?B?dmgwNVpHNGVmMVYyMnZ0K1U2dWNsTkFBTkRCVWVZWEFLc05WM1FOaGkrVy9G?=
 =?utf-8?B?YlBrbHdsR2ZPQjNnZFZmK0YrU2dyYXhUTkFDeGpqQnB3YURFWGgvR282cVJj?=
 =?utf-8?B?Y0FEd3NXVGNKQUZkU1NUOTZhMkFkZEMyeXVwUnJtWmNvL0hWYXFTOVY0RkQy?=
 =?utf-8?B?T3Fsem1RTGVaMG85UFQ5NHBjR3FJN3JtczdjeWVSM2t0TlFHaGRNV24ySk0y?=
 =?utf-8?B?UVRVWlBFcEMyOU5nbjdqb2U3cXRLZ2NIdmdpTnZXV2ExYU9uWjRWWnlaWmZT?=
 =?utf-8?B?aVFGbWNLb3BSWmVRUGh0YVB5STFJdXhJd1FLYzRwblBWRzBOL0RiTEVRaTh0?=
 =?utf-8?B?UC8zcUJPZmZzUXptN1U1NnJvclp3dHBkbFJFdDhyNDJOMzVJOUhIdktUQ3ZD?=
 =?utf-8?B?bGgvQWhOM3BXWXZjeGl5OUtDMkl3SzB6bjBGaTBkTjhocklXVGdSaUlHT1g3?=
 =?utf-8?B?cHRHb01zaUEwYVptS3VvYmFhY053dG9Qa0V2UllnZEV4WlRDNGhQNXQrbjUw?=
 =?utf-8?B?cEJvYnYyOFpYZG83bVRGR3lhb21KYmpqd3d5RlZ0VVJOaXhLTHI3OWkwWm9q?=
 =?utf-8?B?RVVDOHdjdyttS3RMZllqbXJSZjR5aGUyM05wcFlqekcyM3NiV0txZ3hEd2I0?=
 =?utf-8?B?RklxZFNDQlNXdlpzWmJKc3hIVnc1WXdORE9iOHpZWFZRakNuQWovbmkrMGE0?=
 =?utf-8?B?TEZtSVBkQ2ZSc2Q3S2VXcVpVVkFyRjhUMVZibzE2bzJYZ05ldHBPZ0oxSmRo?=
 =?utf-8?B?MG03c1hnTXhaNWpzdTc4L2xhUWdsbnRmVnBEQ2ppeUhXVDk5Q2RpMlA0bkVp?=
 =?utf-8?B?dW9aV1Fvc2JIU1NyY0dWYTV0MjhVWU5DdXByZW5hVWQxWUpoOEU2QkxvVHR2?=
 =?utf-8?B?UjNENTJQN0ZRK3FZM0dFSmZjdXd0OVJaVUs3SmhCbm92eUttKysxTnM4QXJu?=
 =?utf-8?B?RDV1S0ppbDJoTHRoWHZxMzVYMnlUYVhORUxRS1Y4aHd3V3FMbUtZK0NqdkZS?=
 =?utf-8?B?UnYvOUVqSk9SNkRIdnpLRi9rd2k1MkhxY3F3WC9LYXJJMkRaUDA2OTBjTzB1?=
 =?utf-8?B?cnh4MmxpQ3F0VDlSb1c3R0xnNnJuVXZuWWthMm9RekF2NUJ2QTdWZDBiK0pQ?=
 =?utf-8?B?NGpZbG1tdG5ZNU5jTFlRYzhhNGdiMDRhMXNFcDVlb0hlbmpUQURkbXB3cDJ6?=
 =?utf-8?B?Sm95NDNxOFAzcFpsa0dsRG9jQmVNcjlkVkFZdTFrR0Nzd3l3MlYvd25pNXZ4?=
 =?utf-8?Q?T0jY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	flIltlS/cfILUqrCSKKLbZL8jPaLpcXTtx/PsF1dhL2M0/0W2wUEgDLaDzQz9J55Jy1d18kKBiQFZvJ5XmOm2UzXAOyI9vfSCePhIJWPyCXXvZtYytiG1hNJ8sE4H1gdPn1Q1+JTPiu6YEX9qda1YB7DkdVSwTwL+5dCamS2liJRyB3IrqN6vzr4X2gRCNieW+69PJkSQM2sI28HPU+tXwbacYvLWH46Bya9483JCszF7CCmNaXYM8DSzCkwvb3ZBMVCJXAKlwgLfqtmAAFZ1JlyJ6yswEvZiVj6UeU/Uts5g8at7me1jfqRhFus/okesfc1ZGVcd9PwSQW0reKM5YrOybod8MOek2KX/0zEjB2A3m0h5PEQHnRn//bYDnJcF9qtt+KwWDlU/12LaQRKZY9+t9xusN88xvLCdreDWaDb6YbY4WzflnsMffARZa/EoVhg/ufClPHf4R6oroCkQZyofj5xQ0k+IAoUmnR5RUS3n4GOLVvGHSX/lW5MeJJdGoVL/ZX5bzyGjyJ4iAuuN6QPGjFe3lqAoKxhaNAqIiVvH1aTQo597B217co/khcxkGVojDfr3cuciznsAK6C3BLz7J3vxWK+gggpCh6j/K4yYrVqlUawcubB9AaTrMAk
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR13MB3041.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5920687f-d45a-4b62-a56a-08dcb275ee9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 22:04:36.3445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JrWrTXelGKo9778WA/vhJQ6ImnS90OyCEtCh5fMVVYoZFu48+zlhzISQQPzJvXtl0hL+BDQ01Altuv533KsR4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4632
X-Proofpoint-ORIG-GUID: qV0w5RWACBzXtqHpjmVZhvWZTgnh0arl
X-Proofpoint-GUID: qV0w5RWACBzXtqHpjmVZhvWZTgnh0arl
X-Sony-Outbound-GUID: qV0w5RWACBzXtqHpjmVZhvWZTgnh0arl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_20,2024-08-01_01,2024-05-17_01

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTsOtY29sYXMgRi4gUi4g
QS4gUHJhZG8gPG5mcmFwcmFkb0Bjb2xsYWJvcmEuY29tPg0KPiBPbiBUaHUsIEF1ZyAwMSwgMjAy
NCBhdCAwMjoxMzowNVBNIC0wNjAwLCBTaHVhaCBLaGFuIHdyb3RlOg0KPiA+IE9uIDgvMS8yNCAx
MzoxNSwgTsOtY29sYXMgRi4gUi4gQS4gUHJhZG8gd3JvdGU6DQo+ID4gPiBPbiBXZWQsIEp1bCAz
MSwgMjAyNCBhdCAwNToxOTo0NVBNIC0wNjAwLCBTaHVhaCBLaGFuIHdyb3RlOg0KPiA+ID4gPiBP
biA3LzI0LzI0IDE1OjQwLCBOw61jb2xhcyBGLiBSLiBBLiBQcmFkbyB3cm90ZToNCj4gPiA+ID4g
PiBJbnRyb2R1Y2UgYSBuZXcgdGVzdCB0byBpZGVudGlmeSByZWdyZXNzaW9ucyBjYXVzaW5nIGRl
dmljZXMgdG8gZ28NCj4gPiA+ID4gPiBtaXNzaW5nIG9uIHRoZSBzeXN0ZW0uDQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBGb3IgZWFjaCBidXMgYW5kIGNsYXNzIG9uIHRoZSBzeXN0ZW0gdGhlIHRlc3Qg
Y2hlY2tzIHRoZSBudW1iZXIgb2YNCj4gPiA+ID4gPiBkZXZpY2VzIHByZXNlbnQgYWdhaW5zdCBh
IHJlZmVyZW5jZSBmaWxlLCB3aGljaCBuZWVkcyB0byBoYXZlIGJlZW4NCj4gPiA+ID4gPiBnZW5l
cmF0ZWQgYnkgdGhlIHByb2dyYW0gYXQgYSBwcmV2aW91cyBwb2ludCBvbiBhIGtub3duLWdvb2Qg
a2VybmVsLCBhbmQNCj4gPiA+ID4gPiBpZiB0aGVyZSBhcmUgbWlzc2luZyBkZXZpY2VzIHRoZXkg
YXJlIHJlcG9ydGVkLg0KPiA+ID4gPg0KPiA+ID4gPiBDYW4geW91IGVsYWJvcmF0ZSBvbiBob3cg
dG8gZ2VuZXJhdGUgcmVmZXJlbmNlIGZpbGU/IEl0IGlzbid0IGNsZWFyLg0KPiA+ID4NCj4gPiA+
IEluZGVlZCwgSSdsbCBtYWtlIHRoYXQgaW5mb3JtYXRpb24gY2xlYXJlciBpbiBmdXR1cmUgdmVy
c2lvbnMuDQo+ID4gPg0KPiA+ID4gVGhlIHJlZmVyZW5jZSBmaWxlIGlzIGdlbmVyYXRlZCBieSBw
YXNzaW5nIHRoZSAtLWdlbmVyYXRlLXJlZmVyZW5jZSBmbGFnIHRvIHRoZQ0KPiA+ID4gdGVzdDoN
Cj4gPiA+DQo+ID4gPiAuL2V4aXN0LnB5IC0tZ2VuZXJhdGUtcmVmZXJlbmNlDQo+ID4gPg0KPiA+
ID4gSXQgd2lsbCBiZSBwcmludGVkIGFzIHN0YW5kYXJkIG91dHB1dC4NCj4gPg0KPiA+IEhvdyBh
Ym91dCBhZGRpbmcgYW4gb3B0aW9uIHRvIGdlbmVyYXRlIGZpbGUgdGFraW5nIGZpbGVuYW1lPw0K
PiA+IE1ha2VzIGl0IGVhc2llciB0byB1c2UuDQo+IA0KPiBTdXJlLCB3ZSBjYW4gZG8gdGhhdC4g
QW5vdGhlciBvcHRpb24gd291bGQgYmUgdG8gd3JpdGUgaXQgdG8gdGhlIGZpbGVuYW1lIHRoYXQN
Cj4gd291bGQgYmUgbG9va2VkIGZvciBieSBkZWZhdWx0LiBTbyBmb3IgeW91ciBtYWNoaW5lIGp1
c3QgY2FsbGluZw0KPiANCj4gICAuL2V4aXN0LnB5IC0tZ2VuZXJhdGUtcmVmZXJlbmNlDQo+IA0K
PiBjb3VsZCB3cml0ZSB0aGUgcmVmZXJlbmNlIHRvIC4vTEVOT1ZPLDIwWEgwMDVKVVMueWFtbC4N
Cj4gDQo+ID4NCj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBOw61jb2xhcyBGLiBSLiBBLiBQcmFkbyA8bmZyYXByYWRvQGNvbGxhYm9yYS5jb20+DQo+
ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gSGksDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBLZXkgcG9p
bnRzIGFib3V0IHRoaXMgdGVzdDoNCj4gPiA+ID4gPiAqIEdvYWw6IElkZW50aWZ5IHJlZ3Jlc3Np
b25zIGNhdXNpbmcgZGV2aWNlcyB0byBnbyBtaXNzaW5nIG9uIHRoZSBzeXN0ZW0NCj4gPiA+ID4g
PiAqIEZvY3VzOg0KPiA+ID4gPiA+ICAgICAqIEVhc2Ugb2YgbWFpbnRlbmFuY2U6IHRoZSByZWZl
cmVuY2UgZmlsZSBpcyBnZW5lcmF0ZWQgcHJvZ3JhbWF0aWNhbGx5DQo+ID4gPiA+ID4gICAgICog
TWluaW11bSBvZiBmYWxzZS1wb3NpdGl2ZXM6IHRoZSBzY3JpcHQgbWFrZXMgYXMgZmV3IGFzc3Vt
cHRpb25zIGFzIHBvc3NpYmxlDQo+ID4gPiA+ID4gICAgICAgYWJvdXQgdGhlIHN0YWJpbGl0eSBv
ZiBkZXZpY2UgaWRlbnRpZmllcnMgdG8gZW5zdXJlIHJlbmFtZXMvcmVmYWN0b3JzIGRvbid0DQo+
ID4gPiA+ID4gICAgICAgdHJpZ2dlciBmYWxzZS1wb3NpdGl2ZXMNCj4gPiA+ID4gPiAqIEhvdyBp
dCB3b3JrczogRm9yIGVhY2ggYnVzIGFuZCBjbGFzcyBvbiB0aGUgc3lzdGVtIHRoZSB0ZXN0IGNo
ZWNrcyB0aGUgbnVtYmVyDQo+ID4gPiA+ID4gICAgIG9mIGRldmljZXMgcHJlc2VudCBhZ2FpbnN0
IGEgcmVmZXJlbmNlIGZpbGUsIHdoaWNoIG5lZWRzIHRvIGhhdmUgYmVlbg0KPiA+ID4gPiA+ICAg
ICBnZW5lcmF0ZWQgYnkgdGhlIHByb2dyYW0gYXQgYSBwcmV2aW91cyBwb2ludCBvbiBhIGtub3du
LWdvb2Qga2VybmVsLCBhbmQgaWYNCj4gPiA+ID4gPiAgICAgdGhlcmUgYXJlIG1pc3NpbmcgZGV2
aWNlcyB0aGV5IGFyZSByZXBvcnRlZC4NCj4gPiA+ID4gPiAqIENvbXBhcmlzb24gdG8gb3RoZXIg
dGVzdHM6IEl0IG1pZ2h0IGJlIHBvc3NpYmxlKCopIHRvIHJlcGxhY2UgdGhlIGRpc2NvdmVyYWJs
ZQ0KPiA+ID4gPiA+ICAgICBkZXZpY2VzIHRlc3QgWzFdIHdpdGggdGhpcy4gVGhlIGJlbmVmaXRz
IG9mIHRoaXMgdGVzdCBpcyB0aGF0IGl0J3MgZWFzaWVyDQo+ID4gPiA+ID4gICAgIHRvIHNldHVw
IGFuZCBtYWludGFpbiBhbmQgaGFzIHdpZGVyIGNvdmVyYWdlIG9mIGRldmljZXMuDQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiBBZGRpdGlvbmFsIGRldGFpbDoNCj4gPiA+ID4gPiAqIEhhdmluZyBtb3Jl
IGRldmljZXMgb24gdGhlIHJ1bm5pbmcgc3lzdGVtIHRoYW4gdGhlIHJlZmVyZW5jZSBkb2VzIG5v
dCBjYXVzZSBhDQo+ID4gPiA+ID4gICAgIGZhaWx1cmUsIGJ1dCBhIHdhcm5pbmcgaXMgcHJpbnRl
ZCBpbiB0aGF0IGNhc2UgdG8gc3VnZ2VzdCB0aGF0IHRoZSByZWZlcmVuY2UNCj4gPiA+ID4gPiAg
ICAgYmUgdXBkYXRlZC4NCj4gPiA+ID4gPiAqIE1pc3NpbmcgZGV2aWNlcyBhcmUgZGV0ZWN0ZWQg
cGVyIGJ1cy9jbGFzcyBiYXNlZCBvbiB0aGUgbnVtYmVyIG9mIGRldmljZXMuDQo+ID4gPiA+ID4g
ICAgIFdoZW4gdGhlIHRlc3QgZmFpbHMsIHRoZSBrbm93biBtZXRhZGF0YSBmb3IgZWFjaCBvZiB0
aGUgZXhwZWN0ZWQgYW5kIGRldGVjdGVkDQo+ID4gPiA+ID4gICAgIGRldmljZXMgaXMgcHJpbnRl
ZCBhbmQgc29tZSBzaW1wbGUgc2ltaWxpdGFyaXR5IGNvbXBhcmlzb24gaXMgZG9uZSB0byBzdWdn
ZXN0DQo+ID4gPiA+ID4gICAgIHRoZSBkZXZpY2VzIHRoYXQgYXJlIHRoZSBtb3N0IGxpa2VseSB0
byBiZSBtaXNzaW5nLg0KPiA+ID4gPiA+ICogVGhlIHByb3Bvc2VkIHBsYWNlIHRvIHN0b3JlIHRo
ZSBnZW5lcmF0ZWQgcmVmZXJlbmNlIGZpbGVzIGlzIHRoZQ0KPiA+ID4gPiA+ICAgICAncGxhdGZv
cm0tdGVzdC1wYXJhbWV0ZXJzJyByZXBvc2l0b3J5IGluIEtlcm5lbENJIFsyXS4NCj4gPiA+ID4N
Cj4gPiA+ID4gSG93IHdvdWxkIGEgdXNlciBydW4gdGhpcyBvbiB0aGVpciBzeXN0ZW1zIC0gZG8g
dGhleSBuZWVkIHRvIGFjY2Vzcw0KPiA+ID4gPiB0aGlzIHJlcG9zaXRvcnkgaW4gS2VybmVsQ0k/
DQo+ID4gPg0KPiA+ID4gTm8sIHRoYXQgcmVwb3NpdG9yeSB3b3VsZCBqdXN0IGJlIGEgcGxhY2Ug
d2hlcmUgcGVvcGxlIGNvdWxkIGZpbmQgcHJlLWdlbmVyYXRlZA0KPiA+ID4gcmVmZXJlbmNlIGZp
bGVzICh3aGljaCB3ZSdsbCBiZSB1c2luZyB3aGVuIHJ1bm5pbmcgdGhpcyB0ZXN0IGluIEtlcm5l
bENJKSwgYnV0DQo+ID4gPiBhbnlvbmUgY2FuIGFsd2F5cyBnZW5lcmF0ZSB0aGVpciBvd24gcmVm
ZXJlbmNlIGZpbGVzIGFuZCBzdG9yZSB0aGVtIHdoZXJldmVyDQo+ID4gPiB0aGV5IHdhbnQuDQo+
ID4gPg0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgY2xhcmlmaWNhdGlvbi4gVGhpcyBtaWdodCBi
ZSBnb29kIGFkZGl0aW9uIHRvIHRoZSBkb2N1bWVudC4NCj4gPiBJIHRoaW5rIHRoaXMgdGVzdCBj
b3VsZCBiZW5lZml0IGZyb20gYSBSRUFETUUgb3IgaG93dG8NCj4gDQo+IFN1cmUsIEkgY2FuIGFk
ZCBhIFJFQURNRSBpbiB0aGUgbmV4dCByZXZpc2lvbi4NCj4gDQo+ID4NCj4gPiA+ID4NCj4gPiA+
ID4gVGhpcyBpcyB3aGF0IEkgc2VlIHdoZW4gSSBydW4gdGhlIHRlc3Qgb24gbXkgc3lzdGVtOg0K
PiA+ID4gPg0KPiA+ID4gPiBtYWtlIC1DIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RldmljZXMv
ZXhpc3QvIHJ1bl90ZXN0cw0KPiA+ID4gPiBtYWtlOiBFbnRlcmluZyBkaXJlY3RvcnkgJy9saW51
eC9saW51eF82LjExL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RldmljZXMvZXhpc3QnDQo+ID4g
PiA+IFRBUCB2ZXJzaW9uIDEzDQo+ID4gPiA+IDEuLjENCj4gPiA+ID4gIyB0aW1lb3V0IHNldCB0
byA0NQ0KPiA+ID4gPiAjIHNlbGZ0ZXN0czogZGV2aWNlcy9leGlzdDogZXhpc3QucHkNCj4gPiA+
ID4gIyBUQVAgdmVyc2lvbiAxMw0KPiA+ID4gPiAjICMgTm8gbWF0Y2hpbmcgcmVmZXJlbmNlIGZp
bGUgZm91bmQgKHRyaWVkICcuL0xFTk9WTywyMFhIMDA1SlVTLnlhbWwnKQ0KPiA+ID4NCj4gPiA+
IEZpcnN0IGdlbmVyYXRlIHRoZSByZWZlcmVuY2UgZmlsZSBmb3IgeW91ciBzeXN0ZW0gbGlrZSBz
bzoNCj4gPiA+DQo+ID4gPiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9kZXZpY2VzL2V4aXN0L2V4
aXN0LnB5IC0tZ2VuZXJhdGUtcmVmZXJlbmNlID4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZGV2
aWNlcy9leGlzdC9MRU5PVk8sMjBYSDAwNUpVUy55YW1sDQo+ID4gPg0KPiA+DQo+ID4gV29ya2Vk
IC0gSSBzZWUNCj4gPg0KPiA+IFRBUCB2ZXJzaW9uIDEzDQo+ID4gIyBVc2luZyByZWZlcmVuY2Ug
ZmlsZTogLi9MRU5PVk8sMjBYSDAwNUpVUy55YW1sDQo+ID4gMS4uNzYNCj4gPg0KPiA+IC0tLQ0K
PiA+ICMgVG90YWxzOiBwYXNzOjc2IGZhaWw6MCB4ZmFpbDowIHhwYXNzOjAgc2tpcDowIGVycm9y
OjANCj4gPg0KPiA+DQo+ID4gVGhpbmdzIHRvIGltcHJvdmU6DQo+ID4NCj4gPiAtIEhhdmUgdGhl
IHNjcmlwdCB0YWtlIGEgZmlsZSBpbnN0ZWFkIG9mIGFzc3VtaW5nIHRoYXQgdGhlIHJlZmVyZW5j
ZSBmaWxlDQo+ID4gICBpcyBpbiB0aGUgY3VycmVudCBkaXJlY3RvcnkuDQo+ID4gICBlLmc6IGV4
aXN0LnB5IC1mIHJlZmVyZW5jZV9maWxlDQo+IA0KPiBUaGUgc2NyaXB0IGFsc28gaGFzIGFub3Ro
ZXIgcGFyYW1ldGVyIHRvIHNwZWNpZnkgYSBkaWZmZXJlbnQgZGlyZWN0b3J5IHRvIGxvb2sNCj4g
Zm9yIHRoZSByZWZlcmVuY2UgZmlsZTogLS1yZWZlcmVuY2UtZGlyDQo+IA0KPiBCdXQgdGhlIGZp
bGUgbmFtZSBpcyBjdXJyZW50bHkgZml4ZWQgYW5kIGRldGVybWluZWQgZnJvbSB0aGUgc3lzdGVt
J3MgSUQgKERNSSBvcg0KPiBEZXZpY2V0cmVlIGNvbXBhdGlibGUpLg0KPiANCj4gV2UgY2FuIGRl
ZmluaXRlbHkgaGF2ZSBhbm90aGVyIGZsYWcgdG8gZm9yY2UgYSBkaWZmZXJlbnQgZmlsZSBuYW1l
IGlmIHRoYXQncw0KPiB1c2VmdWwuIEluIHRoZW9yeSBpdCBzaG91bGRuJ3QgYmUgbmVlZGVkIGdp
dmVuIHRoZSBtYWNoaW5lIG5hbWUgaXMgdXNlZCBhcw0KPiBmaWxlbmFtZSwgYnV0IG1pZ2h0IGNv
bWUgaW4gaGFuZHkgaWYgdGhlcmUgYXJlIG1hY2hpbmUgbmFtZSBjbGFzaGVzIG9yIGlmIHlvdQ0K
PiB3YW50IHRvIGhhdmUgcmVmZXJlbmNlcyBmb3IgZGlmZmVyZW50IGtlcm5lbCBzdGFibGUgdmVy
c2lvbnMgZm9yIHRoZSBzYW1lDQo+IG1hY2hpbmUgaW4gdGhlIHNhbWUgZGlyZWN0b3J5Lg0KDQpJ
IHdvdWxkIHJlY29tbWVuZCBoYXZpbmcgYSBmbGFnIHRoYXQgYWxsb3dzIHNwZWNpZnlpbmcgdGhl
IGZpbGVuYW1lICh3aGljaCBvdmVycmlkZXMNCnRoZSBhdXRvbWF0aWNhbGx5IGRldGVybWluZWQg
ZmlsZW5hbWUpLiAgSSBhbSB3YXRjaGluZyB0aGlzIHRocmVhZCB3aXRoIGdyZWF0IGludGVyZXN0
LA0KYXMgSSBhbSBwbGFubmluZyBvbiBwcm9wb3NpbmcsIGF0IFBsdW1iZXJzLCBhbm90aGVyIHN5
c3RlbSB3aGljaCB3aWxsIHV0aWxpemUgcmVmZXJlbmNlDQp2YWx1ZXMgKHRoZSAnYWRkaW5nIGJl
bmNobWFyayByZXN1bHRzIHN1cHBvcnQgdG8gS1RBUC9rc2VsZnRlc3QnIHRvcGljIHRoYXQgSSBw
bGFuIHRvDQpnaXZlIGF0IHRoZSB0ZXN0aW5nIE1DLikNCg0KU2luY2UgdGhpcyB0ZXN0IHVzZXMg
cmVmZXJlbmNlIHZhbHVlcywgaXQgaGFzIGFsbCB0aGUgc2FtZSBpc3N1ZXMgYXMgbXkgcHJvcG9z
YWw6DQogLSBuYW1pbmcgb2YgdGhlIGZpbGUgd2hlcmUgdGhlIHJlZmVyZW5jZSB2YWx1ZXMgbGl2
ZQ0KIC0gc29tZSBtZXRob2QgdG8gYXV0b21hdGljYWxseSBzZWxlY3QgYW4gYXBwcm9wcmlhdGUg
cmVmZXJlbmNlIHZhbHVlcyBmaWxlDQpUaGlzIHBhdGNoIHVzZXMgdGhlICBzeXN0ZW0ncyBJRCwg
YnV0IG90aGVyIHRoaW5ncyAobGlrZSBrZXJuZWwgY29uZmlnKSB3aWxsIGxpa2VseQ0KYWZmZWN0
IHRoZSBzZXQgb2YgZGV2aWNlcyBvbiB0aGUgc3lzdGVtLiAgU28gYSBtb3JlIGNvbXBsZXggc2Vs
ZWN0aW9uIG1lY2hhbmlzbQ0KbWF5IGV2ZW50dWFsbHkgYmUgbmVlZGVkLg0KDQogLSBnZW5lcmF0
aW5nIG9yIHVwZGF0aW5nIHRoZSByZWZlcmVuY2UgdmFsdWUgZmlsZQ0KIC0gd2hlcmUgdG8gc3Rv
cmUgdGhlIHJlZmVyZW5jZSBmaWxlDQogICAgLSBlLmcuIHdoZW4gd291bGQgaXQgYmUgYXBwcm9w
cmlhdGUgdG8gc3RvcmUgaXQgdXBzdHJlYW0gYW5kIHdoZW4gZWxzZXdoZXJlPw0KDQpJIGRvbid0
IHdhbnQgdG8gZ3VtIHVwIHRoZSBhY2NlcHRhbmNlIG9mIHRoaXMgcGF0Y2ggYnkgcmFpc2luZyBh
bGwgdGhlc2UgaXNzdWVzDQpub3cuICBJIHRoaW5rIGl0J3MgYWNjZXB0YWJsZSB0byBoYXZlIGEg
dGVzdGVyIGdlbmVyYXRlIHRoZWlyIG93biByZWZlcmVuY2UgZmlsZQ0KcHJpb3IgdG8gZmlyc3Qg
dXNlIG9mIHRoZSB0ZXN0LCBhcyB0aGUgc2ltcGxlc3Qgd2F5IHRvIHVzZSB0aGlzIHRlc3QuICBC
dXQgSSB0aGluaw0KdGhhdCBoYXZpbmcgcHJlLWdlbmVyYXRlZCByZWZlcmVuY2UgZmlsZXMgdGhh
dCB0ZXN0ZXJzIGNhbiB1c2UsIHdpdGgNCmtub3duLWdvb2QgdmFsdWVzLCB3aWxsIGJlIHZhbHVh
YmxlIGluIHRoZSBsb25nIHRlcm0uDQoNClRoZXNlIGlzc3VlcyBjYW4gYmUgZGlzY3Vzc2VkIGF0
IFBsdW1iZXJzLCBJTUhPLg0KDQpSZWdhcmRzLA0KIC0tIFRpbQ0KIA0K

