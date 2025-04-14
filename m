Return-Path: <linux-kselftest+bounces-30739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A51EA88AA4
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 20:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A8837A8985
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 18:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933F528935B;
	Mon, 14 Apr 2025 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="j5q8l1tP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2079.outbound.protection.outlook.com [40.92.91.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAFB288CA2;
	Mon, 14 Apr 2025 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744653770; cv=fail; b=M6fFCYhiTvY40jEyiZQJ/7Rka12SfKo+gME7XDZnq/kwOjfs2mVtCKQM/W/dDuL2ujijPMphSvGVGg+z99C1GGU5yJWDre/fBdYbVGyQcrlPJR+kVw3nRQMJlIf7KVoGf3np8R5I4I/xBne/g8MYP3N0pK2fnnrbnsYFUZzTpM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744653770; c=relaxed/simple;
	bh=d1vyeKJJ9usi4jKG/J1KJX3J9s1zADKaiIH11Cjxb24=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UDsoywf8u4BpQGd4pUYivXDMTblg52oFvwDFZyBo4kj+Zfi1s/x17LVsgNOSYlbYfA6NO71MMCycLS3QPCDIrM4QdkStLQlfDwzUuRXyFiVdMAMKwCMYhZO0ZoiFgUTnLGO5P9HY95Vduy3047PRjE1FwySSYt8x3WO1AHSWTAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=j5q8l1tP; arc=fail smtp.client-ip=40.92.91.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFx6jf1Fq3EWvGUn2T+KhssmzKzPONkYVulnb2uzfkGh4/aj9KvjNwwKYZjYJ6yxRLJSYcFaaIstHRmqr2cxSDSJnSEasuzVnbu+loLahOvMGlzR9/ed57N0OatdbUILxi55yt/QEuaRhOrhxMT0q8YNzI4AW7sHgGRga4T4VUJyA7M+XQ/qQspV7uR5/IgQGE6AU3aeJuVeTox2j7TSaqwwc0hDBmhRHNp+4dnShju1q9tTH8M+fLay6zfc1Uk4VTtDCwx2uTHBW+0vg4udv7nJgfH1cE45YPh2pXiCjJbWltHXwo+gtjIeyJCipiCKI04tQN9Nyf98ueqR92MJfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joZQ2Ftc9Qb+laFF3JoipjWIWsGFFJqkf1UcseD/hgA=;
 b=I+Bn2sH1fq1FrX7SOaGKOxf9wwyrN0frDEYLIxWKraSyaScGxUnUw8QSI+2sdPbBLdYq9d/7TFO0d37ESaPkiqJjtPpauerTlMCpQwMpyje+0VIIyLw30dAxf+6pw2I+RB+UxMQjPD2MeZQVOOx5zkMo/RTJ7fsSUBUyXhnGHhEcoUwiyl9uDQK4c0ymHDJMpKEsvdeCgXVInjnsqYyb24OkfU5HApQot2A/ERQZiJ7T8IU/qyPJIfnvFwCVmW8k53pBMJiJESrb+Q4C5srLs8p6uhvZncJFrqFSrIXGXVp0dPgGm3RbV1hxZKgpNSaLT8JKXDpKB3OUKACnCMUd/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joZQ2Ftc9Qb+laFF3JoipjWIWsGFFJqkf1UcseD/hgA=;
 b=j5q8l1tPRggiIeZVFRvtrYKVs/4w3WfpOhGk9+o5N1nbcUFED2xRc6Sp4u/HCmO9xGObU0TahRQzthNuKOhxoYUmHXofsxEHVw/07ud20wLRVOrd2HBo3QqshmwZmPvJ8p0bUiB9Wvb+8xVohBdjnciTbOIOLubiYKl/HLduSFqhVSBhsbeVSDkZRz03LqMtwrU6/xO/BgLE+h0Lnbo++dfdWl899f6rkokWSBrSo8zscHunQNVkKSO+sU8T3nsBEEyerxBegDjwxQMNguX9eyG7tA6H9egSR+t3d1nY6KWoeF6Os7bUugDeeOCo1IptG8OUTdF1GztYMwKUO6f/pA==
Received: from AS8PR02MB10217.eurprd02.prod.outlook.com
 (2603:10a6:20b:63e::17) by DU2PR02MB10087.eurprd02.prod.outlook.com
 (2603:10a6:10:495::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 14 Apr
 2025 18:02:46 +0000
Received: from AS8PR02MB10217.eurprd02.prod.outlook.com
 ([fe80::58c3:9b65:a6fb:b655]) by AS8PR02MB10217.eurprd02.prod.outlook.com
 ([fe80::58c3:9b65:a6fb:b655%7]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 18:02:45 +0000
From: David Binderman <dcb314@hotmail.com>
To: "maz@kernel.org" <maz@kernel.org>, "oliver.upton@linux.dev"
	<oliver.upton@linux.dev>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "yuzenghui@huawei.com"
	<yuzenghui@huawei.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: linux-6.15-rc2/tools/testing/selftests/kvm/lib/arm64/processor.c:107:
 Possible int/long mixup ?
Thread-Topic:
 linux-6.15-rc2/tools/testing/selftests/kvm/lib/arm64/processor.c:107:
 Possible int/long mixup ?
Thread-Index: AQHbrWbpzJ8XBRC91E6shghw0PHUIA==
Date: Mon, 14 Apr 2025 18:02:45 +0000
Message-ID:
 <AS8PR02MB10217FE659681FD584050156F9CB32@AS8PR02MB10217.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR02MB10217:EE_|DU2PR02MB10087:EE_
x-ms-office365-filtering-correlation-id: 2d8f44f3-18fd-465c-26c5-08dd7b7e8f59
x-ms-exchange-slblob-mailprops:
 Vs63Iqe4sQl3RqqletCEFdzMlpBSGXYPi6lbj6FC4cENAW+gcpc2W/QDewr6WglYpFk5vGotq4C0TCRgpE+BPXSWz/3ErsPC4jBtG2flLnN8yz+EMv0RL5rrs1XCwRQ3XBLS4PX+W0rFLtLvZzSvIC1WW+Vp6tBkQo186f0fIXR0mEZM/vP2mdxDSgMt6InNUwEUi+eurq6xDFG8s+RWkNX2DRDqxmF7gtAnxfEhiFbCmD9XlcfAm4VFyMAa1Ul+VxblrU2hwhbxfJGDccSfT9m/HxC+dF4MKKzJ7iQxOKin/QZr+byzFzQUf1EtyPoGtiXvPEhGKlwUMC6fd9tx6DrPPiC6ADvbxJpXt8bvs5uXFZ6jQl9VklGcuYu/0T8Hz2J+oW1aCEm9Sjm75v0rC/wUprK00hCGKKZ81+k5t/m1zvTxr/Q8I07mZvp8HPShYhzn3qvKD8AL+peLCb7iP3iOmBCznaSVXeEwSK2JKLNXUNmJU29/73bhTpNYMRRRnazsY1kcCiE8RkmGPAl/rJqpitmClxH3NeMe3eyQ/7S5IxpB5ZF2qMqXLNfv9v43L0ogvRQZEoT+t+mAxfWYOTDrECkvLVJN09gA8XV7qAj26mnVRPT3PDU0URrfvGX6RJLbVwl7lyZoup0Istr+JTojnkF4b9jgj6dT4xPTZgyZs/eKTQOEGjmc4D+wASw8PUwWNgYaZk9duAEKRBPDuYt3nlCzEcXEG5LWhlFny38=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|15080799006|7092599003|19110799003|461199028|15030799003|8062599003|440099028|3412199025|21999032|102099032|41001999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?i7zO7cMzx+DmbP+jMYnKZc96DCnHzZbJ2kBlczabDMP8gL0cH8bMxH1M0t?=
 =?iso-8859-1?Q?NM8mw682AxrFEArYw+2iUZnUv+Ji0otTv849iSFBpd8FN7be7tUt5m4dB4?=
 =?iso-8859-1?Q?Zngzc9WUDdxAE4WLCjY3vNg87X8s0OMOa8nOCTW+F9qlQ1XNJQZg8C0Y4Y?=
 =?iso-8859-1?Q?7A84HHNmw3/a5V+v4H9SKt+ir/ny4002W3RNI+vpnZMGt14l690VLQF+M4?=
 =?iso-8859-1?Q?NPV9xS+Bt7CDb4GNBvMNufjG6dOwEr+c4+YTpm8TtrqCwBVNbWDBkXlZ45?=
 =?iso-8859-1?Q?P5Q92WqzpidcSVKOhi1v4lLkPMEeXNsNXejGvI8pGYknQ7uq6wvR3Xxdrb?=
 =?iso-8859-1?Q?md2Aa5esVBGSMyRtUjCaLFfmRdf9DfbOgGk+TFApnCIKYc+7mP19DhTN/o?=
 =?iso-8859-1?Q?vBgdDkLaeu5g0A0g4/9C2MG+Z+FGmu2Cmph0aF+xiYC6u01384LrEe5nzI?=
 =?iso-8859-1?Q?5cDYvRGGquooAT+hxdqYiwyWe5HE/y1taeI81wOJusOjs+iZDyyYs3rCYv?=
 =?iso-8859-1?Q?0IAu+rhI1mhohE2SRQ8veIhXsZEoPH2vVDPa46sH0aKklAl8xnrG0f6VlR?=
 =?iso-8859-1?Q?2H10YtmoxctFap9JGq3m+ecC2R111yUBN8+exqszNxCaz6KIcEb4JAighj?=
 =?iso-8859-1?Q?CxX/V+dz/kD+bm2ghts7mHPz1zQ0BbXJzgsz7PI6xOv1rkgsgn2jK7IR3U?=
 =?iso-8859-1?Q?0WgjiX34eTz3ft6NnKrsDomy+Lb4g1yw6S3CJykCXWWZyq4PK/btOlSvRS?=
 =?iso-8859-1?Q?2F177d4A8N6Nx+FzUQuYFBPQCm3VPHqgHNxMFC4W6Imt5sULTj6VFjoEEP?=
 =?iso-8859-1?Q?rq7DPE/dKgUv/cgZN1Lhy25JixVfIurXmQM8xxpXRd7Sqnyo8r5nEAdbdV?=
 =?iso-8859-1?Q?YkwG+tBehehT2vqahDYTu966TfLrlrsj/BRhH8KqWh4EJWLa9NO5a6JfDF?=
 =?iso-8859-1?Q?QocxGk0AqTDYwcPfGZ320ykTQhqaOUUS0oDkQzjkbq/dEX3PLJOL1Qwowr?=
 =?iso-8859-1?Q?iqb6m/k42186qY8s0Z6M/b8qLYpqzpqzIQFP57M2Qa2WFKVF3c4RaMMFuO?=
 =?iso-8859-1?Q?bTbj8wAVgirBIV7mIQ+wRYZ0oNnVOXMFDIeiXAQLh7eJhb0pwuuUJsVrdL?=
 =?iso-8859-1?Q?ixT/trd2dzKB/VmRcVLh9itB4Qb8/nx3s/+oOysKcGHUeu22/9+rwQZeC3?=
 =?iso-8859-1?Q?qpdET9z0HBff6U/nPTVwclw7HLtjXaMrD+Q=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0DVt8WQnhtdPcGkVNbGfWc42W0FUKVx1g7LHqr0HftFlojlmX95u25vVbg?=
 =?iso-8859-1?Q?BpPjxHHA7iXJzyP2eecnZ0bTnN9GaSv5MtEVZE+NzyniMHIqVWsMdd8rbS?=
 =?iso-8859-1?Q?DkaaFOP+QkO5vJy66yPBsoUx9+bgdnKyepKFfKPBoxbzHXw0BsIBDjriOC?=
 =?iso-8859-1?Q?Hy3fRGH9DpM6oMDGjzi/fXbp9hIvlPo1o9+LAeZcummPZV52bCQksJJyHS?=
 =?iso-8859-1?Q?GEBe4b5Ax0e1fvIZ8IF4sakHqYJjipH9aOg8kX3Ky1UDPK2PMxYIiKfr8w?=
 =?iso-8859-1?Q?801xlbP30TLWGq3yYJRWOn5+FP8tB4m54r9tSHrabmNh1euT7z9baGqZHO?=
 =?iso-8859-1?Q?m8KfEIhDT27PxvpIyDuNkIlDNZUUW8Z3C3oxrgw29QT+BMhbT8r2RWxe5f?=
 =?iso-8859-1?Q?h2MVmJmo3lO1XyDz/lTreJ35W2JyLQk8iP2FOtf0++2SM2kj6lk+ahrKIh?=
 =?iso-8859-1?Q?iF6Ssyb0XNYlQTZCQgGdieenzFPrclruVRFG3MshgnEcYc0OLMLrhoijNo?=
 =?iso-8859-1?Q?pF3vZLpGyVVWVkIS+RIEgH1B2ffwfyzQxBWvgEliW8sdZuUzJjcbztf61R?=
 =?iso-8859-1?Q?/q9fFCZjdEu3VtxfQSeigKOV8TL5GZwS8GmDb4jrUAmJHTPhcQRcI228VL?=
 =?iso-8859-1?Q?FBYcKvW0ggqCWNZD3W+Mf65ANA4AJNK41t4khRcXmHdgw05u9mPh72f+qn?=
 =?iso-8859-1?Q?SREo1SyN9nHwVP5doCKOSqrgqK5VlDIWZTLa4ArQ3l3r9vwvKFzP2WLZiV?=
 =?iso-8859-1?Q?2A2cfSyhpX6BZfKV066H6f84pQJwvktwecxdwP7LjrkDpaNU8hUh5dw5n1?=
 =?iso-8859-1?Q?fIiLoemeYbUY9YjhmyV32jzxMQdL4u8UtWOZyynwvbDOpSkUAhI2ximv7T?=
 =?iso-8859-1?Q?zaJi0FOV3WpJ8+E4ognmAd4vZiUTBhA5+Fn92bDrtHCMz2S6ADuQE71gXK?=
 =?iso-8859-1?Q?ip1goPYjLIopaCvBxn3dyI//+BR4SW8Rd4AbljxP1WFfXIP0tS4JyqcuKo?=
 =?iso-8859-1?Q?vnvHou2emDZM2UhjSdij4z7aVExoAMhGEsah+GHQ9s6trmehJD7Qg2Jebw?=
 =?iso-8859-1?Q?0MMCM4xj4cZkaQeGc78YBMHpIKCNeUlgvfWtQiQqadkpPPCsyynLBVaTeP?=
 =?iso-8859-1?Q?YB61cFFFEPy+SvfwArkjM8KYVH7TDXQ8naNgCgs+OvyFEC2lATKFzsEfQo?=
 =?iso-8859-1?Q?8rHmzmubhGMzRYxalaZOzdgHQQCNlQ1hrhaUVrIMOSB792LX6rXqo82+iS?=
 =?iso-8859-1?Q?nB/XiDxNMX9BZlTKjkYA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB10217.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8f44f3-18fd-465c-26c5-08dd7b7e8f59
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 18:02:45.7105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR02MB10087

Hello there,=0A=
=0A=
Static analyser cppcheck says:=0A=
=0A=
linux-6.15-rc2/tools/testing/selftests/kvm/lib/arm64/processor.c:107:2: sty=
le: int result is returned as long value. If the return value is long to av=
oid loss of information, then you have loss of information. [truncLongCastR=
eturn]=0A=
=0A=
Source code is=0A=
=0A=
   return 1 << (vm->va_bits - shift);=0A=
=0A=
Maybe better code:=0A=
=0A=
   return 1UL << (vm->va_bits - shift);=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=

