Return-Path: <linux-kselftest+bounces-5930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C975587232D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 16:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F17C1F23210
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 15:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27515127B67;
	Tue,  5 Mar 2024 15:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="mHtKznIP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2097.outbound.protection.outlook.com [40.107.12.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BA38595F;
	Tue,  5 Mar 2024 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.12.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709653956; cv=fail; b=R7ix8RG10Hf6JpWfclAt5pIw8BrbngBSoFuovwaOvkjteS23Knr/MDZ3AzUELftlB+6ZWFKHv6Ht98hYmlG4ovBR/Ic/tpISd/1KfyUBTDCfqUy3k8PJBY8Q03jYWd4g8H0JDQHw8irqHgqRM3ut9PDmVIMaklMYem82KcPVMWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709653956; c=relaxed/simple;
	bh=O+38J+S21hEdFPLERMZdrSiopOJbyO1aIEdlS1Wxsck=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GAWZiaI4F6B/iLa7X7GFYyvNerd1qZqKeWleNxBDweYqlEEWlNtYcPmtZo1oppS40R10zJ8YX25AMwTNwoSJD9iXEsmgLrGAgKW6L7VV812VuVJmpT4TjhIk1L4RCxF1isOy23V5Rl10jBaZWF4EHvVSaiV7xRMjliI64Tw0rkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=mHtKznIP; arc=fail smtp.client-ip=40.107.12.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6fnitwTXVmoIZf7KSBcrnNkudQJxWKD8spfMj7P+xC7iyOrz427JCo6PR4ftinpAd7b49M8RVnphLkYWQP9kouf0wqZlsFLne0SfDH1T0Q9uO+U69uuixUkBK7oaMfgKIoQC+r0Jv03beAJVRxSZX/hWbVKqx6BoHFmnZdWOzR2OYaHi5mHbwGOKFvdML7XqTQ691K6NyM3Q0SsDar5WVy3s4rAQV1TWhq8F9dDwJJQdbHoHpIFwDKrM4nEt++PlSHXaH15pBba8XjMqQGcmZ2Rych4sdPxeB1/fuK+pK8By1OAcimAWzjzSQneraJcAysF6Nc2EtS/VyhJEmY6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+38J+S21hEdFPLERMZdrSiopOJbyO1aIEdlS1Wxsck=;
 b=giPDuleNp+Z+7CeiOUJshGgBCiDfkUmx6i8POF1KE/JVa5wvfKmEzbZfvHa7VqOwO7ZCqqP+ZNqjxtSb7j189a3JuyBZU+hlLqdTQnQgweWmHC3tbiC/N+PNh4gbiZNyCX0NjjUDoQslu0GZ3rq57CC+BblDodaTvIecifGXWu3kLcSO/cNM2kQQZ4+VZy0CaqpJSlOu2hrEkcvMZbALnvHS8PGmD/fA8ahDM6dwgEuoX16v5V1TaD/PQsgeFspjFdZ/QBpvzyzQ6LinUQT2JcwevhdTWtlbIz7AIlodoSTx45tbOiDRB+TX7AzuJN8nPvRG1C3vwNoCsRxD5R/PTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+38J+S21hEdFPLERMZdrSiopOJbyO1aIEdlS1Wxsck=;
 b=mHtKznIPDJdngcEaYgXjvYdce0T2xka0Rb1poOZ/fBS7zAM9GEnfebhUEdfsLsvQwnXzzlPWqA/b+1kBdhD+4eOJw26WfPNSiV7BOmr5cnfmvf2F2Wsl/Vgnx6QR6TAoK/yLNKERjSJcQxBmhAIajMNU7iBFObOwKbTICwcsm+zEioKM7mHjOivkTeVi2O7WuEFp/qcU3AfZoEzaO7P/FhWPOYD/oC3FN3sfJhqAeAWpbv0l3Evz6MYutgEUH4nUzl5rZjsO1ywC9WPMGlQ9Ik1MO6C9dR+C4fWiW/iijmJK0Y6CbpUfl2MmGh3X5rXmIO6BfC53xAh5Tbj8pnMYTA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAYP264MB3503.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 15:52:30 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 15:52:30 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Kent Gibson <warthog618@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "bartosz.golaszewski@linaro.org"
	<bartosz.golaszewski@linaro.org>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"bamv2005@gmail.com" <bamv2005@gmail.com>
CC: Pengfei Xu <pengfei.xu@intel.com>, Yi Lai <yi1.lai@intel.com>
Subject: Re: [PATCH] selftest: gpio: remove obsolete gpio-mockup test
Thread-Topic: [PATCH] selftest: gpio: remove obsolete gpio-mockup test
Thread-Index: AQHabpO0jFQkMKlITk6krXwHgcor57EpTRoA
Date: Tue, 5 Mar 2024 15:52:30 +0000
Message-ID: <6910812b-b568-484f-8d3b-7f78951f5c22@csgroup.eu>
References: <20240305002124.7552-1-warthog618@gmail.com>
In-Reply-To: <20240305002124.7552-1-warthog618@gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAYP264MB3503:EE_
x-ms-office365-filtering-correlation-id: 59e51856-af53-4431-c899-08dc3d2c43fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 upuLCEKQuT2DLs04vVm2b7OCwyLXR+Cy2guNxDXzUzRXa7R1qm3U1n9s7f5sxocw3Z54jMMQUbj+mgGn38fIR4iS2ATefgAGmRjr7yQygtdQt3XWYLHeSCXFXYSiR4zpNTFUZ8Qibft+nUnfBEwjpqe+9hdpi46tA74NFRymHkBFnfCISiTIbq1V7lof4GNOC0EgXkNG+KB53FrG8CAWO2MwP77PRwB2MaZvVKs65oFEp/AVbEQ/8IXpxNJhvnhgq1O22F4pfEL4Th/5HGUmrrjjgARIindP3acYnlj58xWEmfn7jgY4mVB7iQ4yYTD3Q6Lpr95UQ0CZQKD2Dwws/aF15gAh+4vZ6xKUK7Ei058eNEM8mqiToBUcUt6unodmLisF3aGSwsG849BBZJKjAGnp/i7CDu6O6WvTqWMCffqQRpJkcOu+xv0AsIK8yL4WIrvcWHjDIb/gbRsaW6F4pik9nGAT37nmpyFiCFJEvz4EajdadobLddVZWigcZWhDeUAiwcXhWwYYulQrwRHpR0ISHQommX5JZ3g0kzfwENhct1hSyHGAf6zXym24/rigSTZ3uDFM9Tjw+hl51uYJg+h6q/v1avbCV3a8enKZof69gs0Qb3uKiiQsJefco00kcN5Rn4Cn/CKmGD1aeNImILJFpWSyQ++3EA51M05KY8M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VGtISUJZdFpHbXdXMnJtK1JVajBwU3hkMlFWNFVuYlQxY1RZbWJDUGU1eDNR?=
 =?utf-8?B?R2E0OW1vbUl4bHJlUENrNDNLcmFXTDY4ZnFvTXM2SkpKT0xvVUpIZjVDclRK?=
 =?utf-8?B?MG4xdHY5VzdkTXgwS0tLWXZ0cU1oM0hrajBtOURwNXNobXdVL1l4YlhYSjNt?=
 =?utf-8?B?c3YwQ1BnakEycTNoaGUwUkorcWI5bXRQdGVtYWEvd2JnM1F0TkhNalBiTE9K?=
 =?utf-8?B?NFd5cmxoWFNrRkgva1RYaStMUFpJTzhvYncrNWhqTDB6Wkh0WTcwZFkxUlo0?=
 =?utf-8?B?YUpVT1Z6QnpDbml6U2R2Q21DVVFITkVkaU1TQS9MR3ZtS0UyU2dXckFFSmRl?=
 =?utf-8?B?c1FXTVNLdnk5TGJ2WXZKUkpsNHhuZ1FCQmxIN3ZSSnJqck82TGxTWGN0WS9q?=
 =?utf-8?B?K255Zm9MRlBlMnZMb252S0NURHlodkYzSUs1YWhNSVVXbHlMeU50Yk1FKzhx?=
 =?utf-8?B?RldvL2dyZ3IxdGdOMG1jTVN1MEZxT3BIVHBMemVBQVRXMHhjY2V0MHF1bFMx?=
 =?utf-8?B?c05RMGdFeVNvSkVjRVdpLzBqYTRKb0ZYWjFOMENaQjRXNWM5dFlMZTVwRmFr?=
 =?utf-8?B?UDM4eHUrVFBISUpNeVJpTmtaekxDbk4wZG1yK1BPZ2V3YWdjbzZ0SVBoMTYw?=
 =?utf-8?B?bHBCMEJvZC8rRFhqVThDRG1ZNnE4ZlJCd3owUjUvQmFPV2o2TzZwUmJobDl3?=
 =?utf-8?B?ZUFtaTlLMTRFN1pBUXlYcWlDVitBdXQ4VWMza1RwWW16czRVWWJBYnNhSnlF?=
 =?utf-8?B?UG5pUGRtN01GSDU0NWlmVGFZUmxLWVJIcVFLZkg1MzBGUUc0dGpFRWJQNW1Q?=
 =?utf-8?B?SXBkSDg1YjVtay85d2FEd21pZ1F6cy8zNDJRRXFmSHltMEpxSnFIQURkQmtR?=
 =?utf-8?B?dmpvU0J1VGlDaStZblh3aGhwZjJsVUE4dDBlTzNSVm5zWUV2dU55aWlNY1F5?=
 =?utf-8?B?bDMrTGQ0SkcrVjZzcUtDN3R5bVQ2NlBaRVhORkRobExITnBhNk40NzRZai9M?=
 =?utf-8?B?V3RLTHdJRzlvYjBiNGI0MGsvK3NBS2NUWGFja0Q5UmhkdVU4QlVYUlN2aEdV?=
 =?utf-8?B?L2JmK3dZV0xEQlhEN0dPMVp6TkpYQXFUTEU1Y20zbWQ4UWtxK0dBcElXOWVF?=
 =?utf-8?B?VTRFSTA1QVZiRlBGbTlMSzhSSUFtek05S3l5ZmtET3Z3S2VBN0hET3pabjhS?=
 =?utf-8?B?ZWRaTXNPSG80NGxvOG1hcjdNTlc0MGtjTzRBUWVyRnE1L08wTEdKaFdLY3hh?=
 =?utf-8?B?V0hNaVZHNkJRdzdYUVBRQ2FlYVEyY3dVK1JtSkVBN2puODk3ZmRGMHNDV2dq?=
 =?utf-8?B?eG51UGE5T2R0dGxzWTRObUJUSFlXYTZBRU9qZEVTQllnZXFuSTZzQTg5a0Mv?=
 =?utf-8?B?R1B0d1ZYRHgyNm55KzhBTG9RR0lvQTNCYVEzVUpVUVJWNjl3ZXdBajVhYWFF?=
 =?utf-8?B?UlpiRHVuN2NFb1dTUHFnOWlSd2ZHT1RZVExHSWVaQmE5WmRXVWNxQTlyYXd2?=
 =?utf-8?B?dWo2UmJRb21wdDlsUmtGRlRNSzhNK2hscXVZYW0zK29xc1NnQlZ1MGROTzNE?=
 =?utf-8?B?R2V4NFpMM0REUERJUUVPVEV5cW1SZS9XV2k4UUxEVEVFTGN4UkpOajNWMWZm?=
 =?utf-8?B?N1N0RHNLYjFINzhSbzZ3bVhEMytIVE1ORVUxRnJXUVpyY29xbkpyalk0NEFQ?=
 =?utf-8?B?NlZqMVRxdWNFYUs2NXhuWE9KV2dQbktBMnBkY3pmbTZheTdVVkZmeHZscGhQ?=
 =?utf-8?B?RUFBd2ZsdXZqQ05YY0FaY0FOeEJUcVdtZGtlN2NVM0FDZWtJeGhrWUdEb21w?=
 =?utf-8?B?UWtVNVRmd211ZFY5QUNUSUE4UUtoaGR4TG1OMGVPa1pDKzlGRFVWK1NmWmRZ?=
 =?utf-8?B?NjhTRnNNTVlaT3AxMEFrMEZjaWRGSGZwSlduU1dWU3RzVFNJM3NLS2kwYzIv?=
 =?utf-8?B?dzRyWFdDc0p3WGdtM1FPdWdIZ3E2MHhxZ0VOckhqVWN2Wms4dzhOZ3J1S0wv?=
 =?utf-8?B?UzAxZDlKd3lGQXhyVTBPcFJ1L0pUbWFad3BWSEI3eFg1UXZWSENtNDVZMDJE?=
 =?utf-8?B?b1NnaGhpcEhpeDVaUTViaWtSRFIyTTNzbXh0eFdHaDAxd1doeFJyUHlhS09l?=
 =?utf-8?Q?zUq7QopE1b7m/JuYw9D+qdmSe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D60739214577F4BB00577164E2361D3@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e51856-af53-4431-c899-08dc3d2c43fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 15:52:30.7787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGzLZAKHmN9TZ0HCp6BWU5wFG4jcDu1rBvw+8LrFS130y7EHFaJVVsEv+sB6HsVXzD+ZyCT+v7yCXlY3gHOJQjZqrxl+UPk9xXasrdCO/z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAYP264MB3503

DQoNCkxlIDA1LzAzLzIwMjQgw6AgMDE6MjEsIEtlbnQgR2lic29uIGEgw6ljcml0wqA6DQo+IFtW
b3VzIG5lIHJlY2V2ZXogcGFzIHNvdXZlbnQgZGUgY291cnJpZXJzIGRlIHdhcnRob2c2MThAZ21h
aWwuY29tLiBEw6ljb3V2cmV6IHBvdXJxdW9pIGNlY2kgZXN0IGltcG9ydGFudCDDoCBodHRwczov
L2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPiANCj4gV2l0aCB0aGUg
cmVtb3ZhbCBvZiB0aGUgQVJDSF9OUl9HUElPUywgdGhlIG51bWJlciBvZiBhdmFpbGFibGUgR1BJ
T3MNCj4gaXMgZWZmZWN0aXZlbHkgdW5saW1pdGVkLCBjYXVzaW5nIHRoZSBncGlvLW1vY2t1cCBt
b2R1bGUgbG9hZCBmYWlsdXJlDQo+IHRlc3QgdGhhdCBvdmVyZmxvd2VkIHRoZSBudW1iZXIgb2Yg
R1BJT3MgdG8gdW5leHBlY3RlZGx5IHN1Y2NlZWQsIGFuZA0KPiBzbyBmYWlsLg0KPiANCj4gVGhl
IHRlc3QgaXMgbm8gbG9uZ2VyIHJlbGV2YW50IHNvIHJlbW92ZSBpdC4NCj4gUHJvbW90ZSB0aGUg
Im5vIGxpbmVzIGRlZmluZWQiIHRlc3Qgc28gdGhlcmUgaXMgc3RpbGwgb25lIGxvYWQNCj4gZmFp
bHVyZSB0ZXN0IGluIHRoZSBiYXNpYyBzZXQuDQo+IA0KPiBGaXhlczogN2I2MTIxMmYyYTA3ICgi
Z3Bpb2xpYjogR2V0IHJpZCBvZiBBUkNIX05SX0dQSU9TIikNCj4gUmVwb3J0ZWQtYnk6IFBlbmdm
ZWkgWHUgPHBlbmdmZWkueHVAaW50ZWwuY29tPg0KPiBSZXBvcnRlZC1ieTogWWkgTGFpIDx5aTEu
bGFpQGludGVsLmNvbT4NCj4gQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1n
cGlvL1pDNk9IQmpkd0JkVDRzU2JAeHBmLnNoLmludGVsLmNvbS8NCj4gU2lnbmVkLW9mZi1ieTog
S2VudCBHaWJzb24gPHdhcnRob2c2MThAZ21haWwuY29tPg0KDQpBY2tlZC1ieTogQ2hyaXN0b3Bo
ZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1Pg0KDQo+IC0tLQ0KPiAgIHRvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2dwaW8vZ3Bpby1tb2NrdXAuc2ggfCA5ICsrKy0tLS0tLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZ3Bpby9ncGlvLW1vY2t1cC5zaCBi
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2dwaW8vZ3Bpby1tb2NrdXAuc2gNCj4gaW5kZXggMGQ2
YzVmN2Y5NWQyLi5mYzJkZDRjMjRkMDYgMTAwNzU1DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2dwaW8vZ3Bpby1tb2NrdXAuc2gNCj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvZ3Bpby9ncGlvLW1vY2t1cC5zaA0KPiBAQCAtMzc3LDEzICszNzcsMTAgQEAgaWYgWyAiJGZ1
bGxfdGVzdCIgXTsgdGhlbg0KPiAgICAgICAgICBpbnNtb2RfdGVzdCAiMCwzMiwzMiw0NCwtMSwy
MiwtMSwzMSIgMzIgMTIgMjIgMzENCj4gICBmaQ0KPiAgIGVjaG8gIjIuICBNb2R1bGUgbG9hZCBl
cnJvciB0ZXN0cyINCj4gLWVjaG8gIjIuMSBncGlvIG92ZXJmbG93Ig0KPiAtIyBDdXJyZW50bHk6
IFRoZSBtYXggbnVtYmVyIG9mIGdwaW8oMTAyNCkgaXMgZGVmaW5lZCBpbiBhcm0gYXJjaGl0ZWN0
dXJlLg0KPiAtaW5zbW9kX3Rlc3QgIi0xLDEwMjQiDQo+ICtlY2hvICIyLjEgbm8gbGluZXMgZGVm
aW5lZCINCj4gK2luc21vZF90ZXN0ICIwLDAiDQo+ICAgaWYgWyAiJGZ1bGxfdGVzdCIgXTsgdGhl
bg0KPiAtICAgICAgIGVjaG8gIjIuMiBubyBsaW5lcyBkZWZpbmVkIg0KPiAtICAgICAgIGluc21v
ZF90ZXN0ICIwLDAiDQo+IC0gICAgICAgZWNobyAiMi4zIGlnbm9yZSByYW5nZSBvdmVybGFwIg0K
PiArICAgICAgIGVjaG8gIjIuMiBpZ25vcmUgcmFuZ2Ugb3ZlcmxhcCINCj4gICAgICAgICAgaW5z
bW9kX3Rlc3QgIjAsMzIsMCwxIiAzMg0KPiAgICAgICAgICBpbnNtb2RfdGVzdCAiMCwzMiwxLDUi
IDMyDQo+ICAgICAgICAgIGluc21vZF90ZXN0ICIwLDMyLDMwLDM1IiAzMg0KPiAtLQ0KPiAyLjM5
LjINCj4gDQo=

