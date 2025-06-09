Return-Path: <linux-kselftest+bounces-34511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFC8AD24F4
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 19:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7EA16EA81
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 17:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601F92163BB;
	Mon,  9 Jun 2025 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L8jgiQPy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wFH8kEWt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE00A4A3C;
	Mon,  9 Jun 2025 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749490020; cv=fail; b=YlPzf8VmIDItmPICN+ZC8PVuhVUFQMgMM5OJazSSmo5DYltWcu0YY7Q5uJ3qqGDhd4wGZTICM3+Hm8cwzbjuvuLA48BZg9xyERYUe0j4DPyXF0xzY9Q70Ut14bvf7qfLs23LRX5jYON7uAskON4/YZJDo58r/eLVqRSYu0uPhtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749490020; c=relaxed/simple;
	bh=n93ryYOZ4X5W+jNB7Y5OZYzg0zWRr/M6TYtZUanVbdY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TwUrC7pxMq90oUZge1LOy0liVVIx2kXeu0j4T0LTj8fgV7NnW5k63x7pjf+6TuKZY+gpvy9MqMGL/ZBpfOGm81t2ogjX6/kIGlBj80j7fDIA1YcppJD4dZPFXRmpr1iupfT41W7G7H8AcMw900jYPyqt3usn3crneDxf8DQd/hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L8jgiQPy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wFH8kEWt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559Fdioq005981;
	Mon, 9 Jun 2025 17:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=n93ryYOZ4X5W+jNB7Y5OZYzg0zWRr/M6TYtZUanVbdY=; b=
	L8jgiQPy1lUMKLbHi3GsNJHFRw8g9J6hV0c1eVx7deI1qmiQuRxQ1zeRj848pNys
	XI0Im85x0aeT/j8jj5ZY61/YUR9HaYpO37+ViBeCuDPo6NN2ikKF7EO1YugbOVPL
	lOXiQb7HlVkVWN7kOJH23ZKyMIYISn0g87Db/3io4WLn4FJLbZk6VMhbebgvZMIm
	mFrykrpNkzqKGr0ghILjQUTzFI1CdSjdElRUR+xHgcEHhEokUFDPG9IOp2D2WVEc
	WZMEFJP7OXQ29SeVrVaH9V8DtUlVJQsMzX6+ZekmmjSp8vHatXYWTivz683B3oyG
	0vTksJJKg9Bdzk32BUDEew==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dad2k3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 17:26:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 559Fb497007427;
	Mon, 9 Jun 2025 17:26:37 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv7f9x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 17:26:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzq7xK/p7YGKoagpJF2LDXvjFEWt7q0+fEKFlBlvpCm5ceB5gqU/FHIKBaDsV61AZNYlcpm14OAK3TUmFjwFp0S6O0CbygHN94eUAV6q1CHlR4Hh0nNQ4qheLkh0vm5pn6NDak8iSAQxwksI0X3ZEeYqp+EevYLjnLjbaGv/jifzdd3DLwICWiaRriQ7f1vwFxEXuVIEVihIxNberlDfqAA7ywrSOqSH1KoQ0khA2SJxG+oIUzZunQeKOSU3LFMwpNBa9CG1XH54AG1gfSecVWiF4G4XfiTu/dAnFrF0Yha+ymNEAsXtMs6M2QX+zqwiu7g+Vd0PZ7wF8PEv0IihmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n93ryYOZ4X5W+jNB7Y5OZYzg0zWRr/M6TYtZUanVbdY=;
 b=I2wrHNXnbExQGhBQ788tqbCFbHkWcMZ1Tl/zlmg7ajkn8ecJodCGKqDeuyoLjXiO1436i2E7CcD72P/t5T/ar0+igkUvBdSJ3SJDCeT3OE+neP8/cZR7pkwFP9RcEauRy4olGcw/ta4I/bNMwEF26NBcsqYbIpZzjJoZsxX3C/wr7mzjWF5fbbS/8lcFcMf9wJGb8HHLW0nFeO81O6nP6r9SptVgtVYc4M9lOeduR5T+F/jMy8gdgUgv/0Fl+r22YrL0QBH24a59gvXkx9K+ZplZoloZhlh213jSMz2m9C4h5ZZnG19Q3eGsIhG/pNy+LtJC4ejvVyhDUkLCqE4xjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n93ryYOZ4X5W+jNB7Y5OZYzg0zWRr/M6TYtZUanVbdY=;
 b=wFH8kEWtxSOESNtZ/tohZXzt/ZiMb2w3NcmR2C9FdYYR/xLbccXgmWCRFUgavEtQrqdBNy4d78yj70i9c5oV7sWbjyR5TEf9wx9PmouVHOE2vnQhy/Vr7YVdVy1t/xEPazB5KTN1LkrN/Xb2o37ACC95MvJ2ksmBa8IDxZhN/4A=
Received: from CO6PR10MB5426.namprd10.prod.outlook.com (2603:10b6:5:35e::22)
 by PH7PR10MB7783.namprd10.prod.outlook.com (2603:10b6:510:2ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 17:26:35 +0000
Received: from CO6PR10MB5426.namprd10.prod.outlook.com
 ([fe80::7845:9ba4:7ad2:374]) by CO6PR10MB5426.namprd10.prod.outlook.com
 ([fe80::7845:9ba4:7ad2:374%3]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 17:26:35 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Sebastian Ott <sebott@redhat.com>
CC: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
        Colton Lewis <coltonlewis@google.com>,
        Ricardo Koller <ricarkol@google.com>, Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>, Shuah Khan <shuah@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] KVM: arm64: selftests: arch_timer_edge_cases fixes
Thread-Topic: [PATCH v3 0/4] KVM: arm64: selftests: arch_timer_edge_cases
 fixes
Thread-Index: AQHb1gXQUi/kh5tGIUGVLYOISj2taLP7GzMA
Date: Mon, 9 Jun 2025 17:26:35 +0000
Message-ID: <B77F70F2-EECA-4E10-9F00-972F6AE27831@oracle.com>
References: <20250605103613.14544-1-sebott@redhat.com>
In-Reply-To: <20250605103613.14544-1-sebott@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR10MB5426:EE_|PH7PR10MB7783:EE_
x-ms-office365-filtering-correlation-id: 89107cdf-b582-4610-f7a1-08dda77ac8b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OU5BcnpOK2I3emt5dnpMbTRGSjdOQ2xCd3ZqeTA1T20zYU8rSFJiTlJ4TGVN?=
 =?utf-8?B?aG0vOENmNGlMTndyTXpsZENEaVNvcExZd3orenFzNUY1bVc0QUdOYTFWNzli?=
 =?utf-8?B?bDBUenpXS2hZRzBVQklCR2QwMWdneENEQ2E1WVlXdURVbjkyRXBzNHZLeDBS?=
 =?utf-8?B?MjkydUEzNFBPQ2lpb0JINTRFWm1lZk5XcERacnVZL3Q3OEF5cExENTFIK3hV?=
 =?utf-8?B?MnlhbVRZYjcyZEdWdHZLdUY1VWoxMlpJYjhaelAvdTBrREd6UHBKZE5yZ1hC?=
 =?utf-8?B?UXBFY3d1WHhVTGtpM0o2MUdyWkhzczJYWlZwVXJoTEpBWGlHYlpDZGhvZE9j?=
 =?utf-8?B?cCtkZVZ4eFpwN00rSzlOUE5JbXFoaTROeG5zSzZiNWFyTVdWcUFYdnVKVGRz?=
 =?utf-8?B?UDdPMEtndmtHVmp3cGxJaFN3V3ExN0ZJd3kxSFc0Y2NDMHlmeG5oa2J3dmNF?=
 =?utf-8?B?NEVhM01Bcnl0SzViaCs0WHBsRExGZ0VqRThwdmNVWUJEOUYvbjlTVnlXWGw5?=
 =?utf-8?B?cXM2S2Rqa3NqVEx6YzUrdDlyck1hZldwSXBPdHJzbGt2NU9QV1hCUUZTRkNj?=
 =?utf-8?B?TkE2bEtEQXllRU5sbnNwcWltRjVWTWU4OWNwU0E5TnVIcUUwUERuenY1TnE4?=
 =?utf-8?B?UktXaDFER3pMaXBpRGcvL3h6dTUyRHRoWEluOTNQcnJYUEVPcEVPd3ZsOW9O?=
 =?utf-8?B?UTg1YUdVMXFGY3lMcVVzOUx5ZE1QNUNKWXdidzVTTnJ5UHdXUUUxZE9tQi9n?=
 =?utf-8?B?dlYrem03SE1PU2IvbUxUcWVRZngxZkV0U1lMaiticUFPcWNuVkVISjRabFpm?=
 =?utf-8?B?NHN0bTlKUm1JaDJ0a0tBaG0zNUQ2Q2E1QitseDNZb0NEUUlVR0dGbUduWmtK?=
 =?utf-8?B?UFlXQ29nK0d0dk1wVzBwcytZdDFhSlFxa3hHNHNYS0tDNGhMaExxZlZZaFVL?=
 =?utf-8?B?K2tERzVKbkZSQjIxcVlkZFc3TFp1alRHakk5dk9sUWZnVmpGcjdhN0pDdUxo?=
 =?utf-8?B?K1p4U1ZJYXBES2JhQ24vd2dsZHpBWTdFMGs1QjlPOE95TmEwVW9SNklnL3Zu?=
 =?utf-8?B?VzMyNkRvbDlWVlV5dzNUL0dKNEo0bzEycWFIdGVlZldqRmY1Ym9qTUtzQUhV?=
 =?utf-8?B?ZE1mSkZMMEFYS21Pem40a2M4cExGM0V4bkdLQURCcWU5YjAzcDZrTDZhekc4?=
 =?utf-8?B?VFF1bENRVEI2dVJXdjlkcUg1UFRMd2V0eHdVQlJoYkxxdUpsNmZqUzRmM3V5?=
 =?utf-8?B?Q1VydWNvYkNFR0c1QzAyZXkvOXhWcGdYVkdKaTMzMmpTY1ppd3hUQkswN2Mr?=
 =?utf-8?B?OHpqWG1lM0ZGNHdYaU9nNEtzWnNITXZTa3c5NHU2Q3NmVlk2azJ3WnJjMGM3?=
 =?utf-8?B?NkY4enhqMjZaYVlXT29QdTg1Qm9XUHFCQS9wWU11R2JPRDJ0UDZwenJkakta?=
 =?utf-8?B?MmFobUpFZkFFYU93bzFieGlJZk1qQWFEeXZxa3hmWlRmOUNnMEVEaG9DZFdD?=
 =?utf-8?B?MnJPQ2RlcnF0ZGJnM2hKRnNldkduVFV0dHd5TEh2YXRLdDhXZFYySWlxbTV1?=
 =?utf-8?B?NVNMazNkck9vejlSZ05CY0ozNXo0SStoTmdIUVltZmZ0enFVT3F4ekF2bUUv?=
 =?utf-8?B?aGJJTWlWTldKUlFXVDFmSlBONjFjcmlzb0ZvMUpabEZJa3IzT1A1MWgxZXpM?=
 =?utf-8?B?emlNSW12VUhKNXcwZnF5emltZ2d5SGNma3BqT2ovdEt4UEJGeVBSc2pNcE92?=
 =?utf-8?B?V3IzSHBDWWN1VDNsMkI0VjFuOGxwc2Rra3FMcExMc3gyWGdlUlZOakRRTzN2?=
 =?utf-8?B?b2tMVVEwTVdLVlh4U1hubnhFQnZSaGZEUVFoQjdSOG5ERjdWUzk4dmtybzJM?=
 =?utf-8?B?N2tyRmpUclRXc2ZmY3NHcW1YZUVpcFkxeXNUTlRLNWdJdWNtRUJySXFDd2tr?=
 =?utf-8?B?eVZDYVh5cmk2NHZ5b21uM0xhSys5UkZNekh3YW4zdHpsVWw2MG85MU5RMm9U?=
 =?utf-8?Q?EPAsnVM5P3gLFF0zMU8NCxB0XDgfUg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5426.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YllUWlNzczJzZ1pCbnpOb2JlMGd5dVlvTFl5cHFwQzRJT21veFFqS1VPVEJu?=
 =?utf-8?B?a20rSW5XRGQrNS9jTnR6c2JoT0cvVGg2VnJ2TUQrYlh5dEhhTWRGdnVuaGU2?=
 =?utf-8?B?b004YWIzQWVLSzM2SER1amtyMzhYRUVLclJ6QWxnUXJZaG1OUUpPQmtFdXZS?=
 =?utf-8?B?SFplREo0c3RhQTVOL1d5THBNTCtlYWFDd2JobFR2UnM2RWs3WVZiWmtQTlpF?=
 =?utf-8?B?TGg5b1A1L2VTRjVPR1piUWtBYXZqdURoWWJiMFh3V3c1Ymt6WVVDMGlWMGEr?=
 =?utf-8?B?eHdwUnVkZzZnZlpvbzgra1hFdFZmZVVscTZiWUZGTkZWQkRsVkxOVkpqUDBI?=
 =?utf-8?B?bFpVMGxad3drREVGN0NVUjBnV2dvaEU0V0tna2RXc1JLajkyNVZrbHg3S1BM?=
 =?utf-8?B?ZUlpajNtbHU2VHBsUjQ0MklqMjVuYXNEN0hIWUY1YXVFZzBsMVNiYitUN1po?=
 =?utf-8?B?amxLUkVKUXBIanBwMXFTY25oZ3huRXdZdU1ybzJaVlFvZm5KaldQaVJQb3V4?=
 =?utf-8?B?enZRZ3d2U1c1ZU1qNm9GOVpuSVJEZWtrUWdiWE5tYWNWWlNNUG8wcDVUZSth?=
 =?utf-8?B?QjRodkhuUmxFb0dwU3lxY2oxTjJOZ0NtZUIzcHUyL3dOMnlhSWF2K0FYQXM0?=
 =?utf-8?B?YXVwdDNDeTVNU3JwMmY2Qk81aklTNmRXVmM1aWxwaWRCQ20wS3ZMUmVIN1Bz?=
 =?utf-8?B?Qnlhc2NsMFhhOTVDdWxLdWVNejhHQnZlaTU0aWhyM3JaSENDdWNOc1pVVkZk?=
 =?utf-8?B?TE1oZVBXOGZJdCtUSXpsZDN4ZC9kb2NnZGFjZFcrc2N5dVMxVHVqQzVWZHVm?=
 =?utf-8?B?emVzT2xSUnhKU29yYi85YWxZQ1JVMjVYTmVSUmJVRXR4Zis2OWc5akpsamJM?=
 =?utf-8?B?Y0tGR3Jjd29rZk1DcTN3Rk1JcVgxaXJ3WG5ZcklCQXNmN1JQU21TS1lmOHFJ?=
 =?utf-8?B?Vk9MZy9Lc1pIeXdxcEJDVXhHd1JnTURLMFdaVEFnVUV4NUNkQUt5VzZkdGtI?=
 =?utf-8?B?c2dGVGZnUThuRjFrVzZWMjhtek5WdFhQYTFvQ0F6SUM0ZTMyVS9vTGU5TVdy?=
 =?utf-8?B?aHZNU3FwWGRQTENTUVp5TTFjT0E0ZDhxQlo5aUNTNFNrTWJLNU9icE9LWTBQ?=
 =?utf-8?B?NnVuVFVZZUxxazcrNHZsVnJUamRVK1ZEd21DTElENmVNQ2ZOMGVNOEl2T1li?=
 =?utf-8?B?MHBvOFBGMkpORHFOUzd0b1N6VTZNbEQzMGM5am5LRnVTUGxqV25JZ0dVVXBG?=
 =?utf-8?B?T05GdnZLNzE5V2pCQ25YMkNZQjJJTTZpUHFrVHR2Z2NUSkI3U2VUWjRSSS9s?=
 =?utf-8?B?b0FLVkprZkZKYklKL3ZZcFFuUFFqcEN3bDRFN0ZCVG5SckRkYXUrd1F4azJv?=
 =?utf-8?B?RXFzMkNKYmNqYS9sSzlRL0dTeXZuWEpCaktrY0VkSU9sdlNHa0pjc1FJczZN?=
 =?utf-8?B?REFkRFZSbGFCaHpERytZUk5ZOUhUVEY5VVl1MngvaU5pV1ZBUG1WeWM3dXVm?=
 =?utf-8?B?WGhYeHlRZUd3cTEvQ2tGVHZNNWJGdzg1ekdHVUxQQlJRdWZYZmc3UU5lZTE3?=
 =?utf-8?B?aXhxRGhHUlNVV1oySDU5NGlsTzRqR1FUd3B4WkZmUWZzVzk5Z3h1SWVlSTJ0?=
 =?utf-8?B?Q3pucVlxWGJwdTc0SzVNV2MwcFBYMEpFbHlvMDVCN3FTUlRzbWhFRFFmV05w?=
 =?utf-8?B?eHNIcm1NRHVqNURKdUZFeFo3OU1OZmhQbEV0aEhwWEppdDdGeWZDbHFLdjJJ?=
 =?utf-8?B?UWwvMjRPS2FURFNkMFhhTWUvU0dZYUl3QnJ3TW9JTE5Yem43NDRpUXIzNXIy?=
 =?utf-8?B?bFlKQWsyRjI1d3hMd2tNUzNCZ285NzVlajdDWjh5bExxbWdLN0JTZDlKc2tS?=
 =?utf-8?B?cXkzMVQxQjJXVTllYlF3VWptdkVENWwwbnhJT013SmFlT00zNzZodEl2L3Nj?=
 =?utf-8?B?M2w3VzFjSFNmYjVVdXZvcFBSbGE5cXhWdFRqa3RncVJac0RiSE5Na3VZLzhR?=
 =?utf-8?B?eEF2cy9HaktGa2VGUmUzMlpHZjV6WXZGZkFFRGwzOThScXc3MFJxaTF1Z0lT?=
 =?utf-8?B?RUVNZzlDN21ZaDFwTlgwbEVUL0NMOExSRldtZVgyRHBSQVQ4QzFxVXUwbkYx?=
 =?utf-8?B?WmIwRURBRGVBaGZKeTVuaEc2elRBbk5wZ212T1hpeklTQ2kzWGRDNVVzUEpF?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A6E9E92AA9D074DB8E37D87C28CB045@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZAV1Zs+bfdJuT15i5NWeMlhAIogx+mZMw+M7tUzGIXsgs2vpeSZGqWKXWHxtI40oaaU1X5ouZQKGb80GwDjLeksSpZ1Is9fx+dSd3c5SBgvGzHXp+Qe4dWXl4YT1ZFB0Me3nXXzZ4gDMq0ncEb4rYvlM8njimw4Tw52elp59p6B52bHWMq+wKTRYWr3dpIyJb2TLy5cb7VHxn+SiQTvrIgyVMedE5Q5QYs6xzpL+Xm014+uMZ3ki2uW+pqEeP2KSjAYIq3aGJXRziK1xOUCciIGe0bNDMiW/BECK82GCtRCiYL4pDhAJRsTqDe3xQR0ZHJ73bfhcTIxDkMy22M2DcA1/fn8aBjOt8yoylUsNJXQut5P8mWJfliF1S3bMdRjg0vtGPZRXmGDS6m6F1OrGjtebK1ievvdkt4VJbnu4mQWKcanQQc/d/4nWguRtSifABH36Om2mQYwiDlqCkDsVF1B++LLwGTvR8C1jJYr04PuDhlzmNyajOZv9qcs+rOtzmys2vm/209CPf5jlG/ZwiDbmbaVqe7yUAgbst/In8u86xet/FycoJAcpUEfO/IOoUin/lCvCOM3IHhOEcw9GGa4rX/UpYDyt1Uq7sW8lRCo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5426.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89107cdf-b582-4610-f7a1-08dda77ac8b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 17:26:35.1104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dFwdKvse80oC7jJXLBBs9KdwyMIM2RwWEYcyB9yhKZLon0pKVTHjitIYnYVSdmF0cROT2ZbR6IE04NqNyRQN7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7783
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_06,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506090131
X-Proofpoint-ORIG-GUID: zL3ox9r1y5OVi7ZGkfSjv78DOhN57XSc
X-Authority-Analysis: v=2.4 cv=EJwG00ZC c=1 sm=1 tr=0 ts=6847194e cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=nQstowge16nhZK8uYrUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDEzMSBTYWx0ZWRfX9qiiQJsl5xIw H3BLmN5bi3OrSaIMtCTz7jxxVKF55lr85Wsz2ykNDwZx20xlUO89GIaxspDTDX6r/5djWunjYZf tXMzFpR0b/T4r7V00l7Ww4Ew8NRNrlMGngAQbMeoAV5Z1XlbaMUohMDl1KtcNoj9Jq8agS6rmWw
 1SAeIUm8k9gHgTLvYQfhVwBqcRNMl1nYyfxOg/xBgcAzeJCCsqSqONLhAkiZE/g8RdpYUYFKIBJ e3Zq8O7ay9kEx63VM00qaxfzZr67KP0evwuHy/3G9Z3aoE2YY550McihXcSqmXQwj0OeWqtHUHd t87u0veGbz9GWykd4eJWSf20PbOnUbQrnnYeyjuf3uM21iVNWoBRvQLMJJ2VRrS/ilWXECXTiJh
 ONz5z02QA6FDiu8bZtXJi9xcES85j+Lg2I7/VsNTxJU8OE7FRM9Rs4Yco4NKc2fOMbkB3d1e
X-Proofpoint-GUID: zL3ox9r1y5OVi7ZGkfSjv78DOhN57XSc

SGkgU2ViYXN0aWFuLA0KDQpUaGFua3MgaW4gYWR2YW5jZS4NCg0KPiBPbiA1IEp1biAyMDI1LCBh
dCAxMDozNiwgU2ViYXN0aWFuIE90dCA8c2Vib3R0QHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4g
U29tZSBzbWFsbCBmaXhlcyBmb3IgYXJjaF90aW1lcl9lZGdlX2Nhc2VzIHRoYXQgSSBzdHVtYmxl
ZCB1cG9uDQo+IHdoaWxlIGRlYnVnZ2luZyBmYWlsdXJlcyBmb3IgdGhpcyBzZWxmdGVzdCBvbiBh
bXBlcmUtb25lLg0KPiANCg0KSeKAmXZlIHRlc3RlZCB0aGlzIHRlc3QgdW5kZXIgdGhyZWUgY2ly
Y3Vtc3RhbmNlczoNCg0KMSkgT3JpZ2luYWwgKCFIQVNfRUwyICYmICFIQVNfRUwyX0UySDApDQoN
CjIpIEhBU19FTDIgJiYgSEFTX0VMMl9FMkgwDQoNCjMpIEhBU19FTDIgJiYgIUhBU19FTDJfRTJI
MA0KDQoNClRlc3RzIDEpIGFuZCAyKSByZXR1cm5lZCBpbiBhcHByb3guIHRoZSBzYW1lIGFtb3Vu
dCBvZiByZWFsIHRpbWUgKGFib3V0IDEycykgYWx0aG91Z2ggMykgZG9lc27igJl0DQpzZWVtIHRv
IHJldHVybiBhdCBhbGwuDQoNCknigJl2ZSB0ZXN0ZWQgaXQgb24gYW1wZXJlLW9uZS4NCg0KTWln
dWVsDQoNCj4gQ2hhbmdlcyBzaW5jZSB2MToNCj4gKiBkZXRlcm1pbmUgZWZmZWN0aXZlIGNvdW50
ZXIgd2lkdGggYmFzZWQgb24gc3VnZ2VzdGlvbnMgZnJvbSBNYXJjDQo+IENoYW5nZXMgc2luY2Ug
djI6DQo+ICogbmV3IHBhdGNoIHRvIGZpeCB4dmFsIGluaXRpYWxpemF0aW9uDQo+IA0KPiBJJ3Zl
IGRvbmUgdGVzdHMgd2l0aCB0aGlzIG9uIHZhcmlvdXMgbWFjaGluZXMgLSBubyBpc3N1ZXMgZHVy
aW5nDQo+IHNldmVyYWwgaHVuZHJlZHMgb2YgdGVzdCBydW5zLg0KPiANCj4gdjE6IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2t2bWFybS8yMDI1MDUwOTE0MzMxMi4zNDIyNC0xLXNlYm90dEByZWRo
YXQuY29tLw0KPiB2MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcva3ZtYXJtLzIwMjUwNTI3MTQy
NDM0LjI1MjA5LTEtc2Vib3R0QHJlZGhhdC5jb20vDQo+IA0KPiBTZWJhc3RpYW4gT3R0ICg0KToN
Cj4gIEtWTTogYXJtNjQ6IHNlbGZ0ZXN0czogZml4IGhlbHAgdGV4dCBmb3IgYXJjaF90aW1lcl9l
ZGdlX2Nhc2VzDQo+ICBLVk06IGFybTY0OiBzZWxmdGVzdHM6IGZpeCB0aHJlYWQgbWlncmF0aW9u
IGluIGFyY2hfdGltZXJfZWRnZV9jYXNlcw0KPiAgS1ZNOiBhcm02NDogc2VsZnRlc3RzOiBhcmNo
X3RpbWVyX2VkZ2VfY2FzZXMgLSBmaXggeHZhbCBpbml0DQo+ICBLVk06IGFybTY0OiBzZWxmdGVz
dHM6IGFyY2hfdGltZXJfZWRnZV9jYXNlcyAtIGRldGVybWluZSBlZmZlY3RpdmUgY291bnRlciB3
aWR0aA0KPiANCj4gLi4uL2t2bS9hcm02NC9hcmNoX3RpbWVyX2VkZ2VfY2FzZXMuYyAgICAgICAg
IHwgMzkgKysrKysrKysrKysrLS0tLS0tLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9u
cygrKSwgMTQgZGVsZXRpb25zKC0pDQo+IA0KPiANCj4gYmFzZS1jb21taXQ6IDBmZjQxZGYxY2Iy
NjhmYzY5ZTcwM2EwOGE1N2VlMTRhZTk2N2QwY2ENCj4gLS0gDQo+IDIuNDkuMA0KPiANCj4gDQoN
Cg==

