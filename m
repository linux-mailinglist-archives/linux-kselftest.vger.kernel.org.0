Return-Path: <linux-kselftest+bounces-35430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F81AE1A8D
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 14:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39973B8D0C
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 12:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E1828A40D;
	Fri, 20 Jun 2025 12:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EKMaBNbZ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EKMaBNbZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013054.outbound.protection.outlook.com [40.107.159.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15579285412;
	Fri, 20 Jun 2025 12:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.54
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750421351; cv=fail; b=QdTMFl0MEmzV31S4xYNuQsifTAuIXGzRMwhyy3ECU7Ebp4WrdPQOpYyVGA8JgEOdwFnrk2YRtVpHHV1aA1n1bpoUO6uC12sM0gBb4PfJH0l/TKtIQeF+yFTcUs4blZo/CFvg+dA3JCRU4PB2D9jk0cuxTCbDon73H8QVfkDDJrE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750421351; c=relaxed/simple;
	bh=goBXCzk56R+fSgGrc+bwEm8MJ1EXgzFxpLkf0MUiSOw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kZ3ubuPggWR+DFCJmgQbzoYup1sCESdgwj9z6P0npqD20vns934ZLvbA73gvdJAdNgsxT80mGr3I/DcNEYKQHNR3MLHOq3N+3zVfsXpEND4EijjWPZvA0FM8TuT3e3F3WwdlHnHeOorRiAuZWVvfWFEx0580or5HGMWA6yJt4rs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EKMaBNbZ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EKMaBNbZ; arc=fail smtp.client-ip=40.107.159.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ZyPbvI5DKC3H3TwlASBxhmoijC+1lKz3SLrNXDCYxpEB0jarHGAdaJP/i+LWmasdTJWtDBjVnb8/stahuxbHq/9uvRevR+fHpwWmwpRd8lPMvJLrNBgEw22ivpjCUy52ek0K9bjc0ix3N78LF4dGtRiCq63pIhqt0f7Qk+0YXLr+c4a7Xsu4Gn+993x63McCumm/aqFtce+VYspkBkgmQxGStgpa4LlV46jUH2DcrtMQN3ksTj9VIT1G+BxI3sndOtCpTU5S/7x0G00/WcfBL8XmsdzMsIyPjmA6fIp0RdWHkicfOBmS8WRNDgT6+/dbbOBrK6k+Wfhz+dPJ+gQ4Tg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXAjcxS35f8JrCqP+7uOJC13GQ4meNCzN6Gtcjy0Kjk=;
 b=fkAsj/jv0/UDRjqZzFabpYmkyXbfa26rZP8v7Y/L3DN2m1ZIbsQVEFwN7M+51hRx5eyqmbO4fBiJi3iIFBVSidqtWJsfPI4hzpGv7QrT37Q2xBtJy/lHvhMthGnq8ulUtTCow9Nw9UZM1mazOpKif90bLkFXkrNndJXRP4+ogTCrRg7vZlhUEDbafdjyKao7O49NhbdgQlGPRRMoJCoqqs9bkfIYQ4GgGcJHxupibOjHgHB2qf4RDHwCUuOAB1NknGi3R8xB58E89QVpqKtgyURkT7YOvNcQOVWWjqwphp90nZkGHyD5trmiGLFxEhxzCb6Y4DDiso/wHfAC88I/1w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXAjcxS35f8JrCqP+7uOJC13GQ4meNCzN6Gtcjy0Kjk=;
 b=EKMaBNbZcJ86HMSRqoGR+8dvNB+4/OVQ1wVzIOVHYagbEKEC4zewQ9dkLd1hs5N4mkOPqeJUmkT8YggDU++2NHmPzW+54qsNM0Adqmsgb6VTDRNArzSRUwCnhwHCvR4RH4wsCbvZnbEGP7pSW6gWaee/ssd6RC4G4DKh9Cv6/Tg=
Received: from DB8PR04CA0016.eurprd04.prod.outlook.com (2603:10a6:10:110::26)
 by VI0PR08MB11224.eurprd08.prod.outlook.com (2603:10a6:800:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 20 Jun
 2025 12:09:01 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:110:cafe::61) by DB8PR04CA0016.outlook.office365.com
 (2603:10a6:10:110::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.25 via Frontend Transport; Fri,
 20 Jun 2025 12:09:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.21
 via Frontend Transport; Fri, 20 Jun 2025 12:09:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxoAv6XutwMd7HmfJcaiqnh/vbvknH5MgcNHL93vIDMeemuePBZfpZDPKgQ+hkl9zt5OwxjBUmpLQmhj5de2/VFH/EfXiYZK1Rz1XW+PXq2jrznIkcGL8IpSdS6q9+9o/C290ShVEpAmBEhgPeXbt0WJamRsy0xZDx7sKZTh6M+lak2nc1f0WF+LjYDOKAYVMYd0qeVxZo8Bcl3Im7NOg9Hh+OG7/z+nyv6NzbabyfHVt3AbHnWJBdwIYAX0dqwmYGa895i371a2gasN4AmSV36oKHir/srFsxTlABYAYMhmZ/EIbHE19RylXDVvezy4Y+e/dXxpJiBJCSj2a1Q5Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXAjcxS35f8JrCqP+7uOJC13GQ4meNCzN6Gtcjy0Kjk=;
 b=xHUJq4ukvTd2d8QQTLdDMSshgNZ36jSUVtl4cQ8sUw1+hwOI36G8WW30gNih+UP/OlBmrIwk0Ef+yMlQIF/9khq8v97pHPt9hPmnZCJUklcvbI4XIyT7GqhNsKGwbLpcn8dCDk9uKObyyzev79ZB8jLVpSjYGC2uoLPqzrZnMUX94hM9EWaS8Nq02d4uaZI6ot+On8ZTYAo57pz4LjP2jr2RkV93F62pCNckUeDMd19u8JlW2qfQzX9k2qm/R5L4d0yqs53AN0MCdDOAb7RI8fvOtpQSTUi2HKboK7OkHSJGr6ZQcU2OONRmOpbF/fVp7L58M98NEgpQCM091c1hGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXAjcxS35f8JrCqP+7uOJC13GQ4meNCzN6Gtcjy0Kjk=;
 b=EKMaBNbZcJ86HMSRqoGR+8dvNB+4/OVQ1wVzIOVHYagbEKEC4zewQ9dkLd1hs5N4mkOPqeJUmkT8YggDU++2NHmPzW+54qsNM0Adqmsgb6VTDRNArzSRUwCnhwHCvR4RH4wsCbvZnbEGP7pSW6gWaee/ssd6RC4G4DKh9Cv6/Tg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DU0PR08MB8932.eurprd08.prod.outlook.com (2603:10a6:10:467::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Fri, 20 Jun
 2025 12:08:28 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%4]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 12:08:28 +0000
Message-ID: <064b6b89-0bda-4375-bb63-fc6796e9b6a9@arm.com>
Date: Fri, 20 Jun 2025 17:38:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Fix validate_addr helper
To: akpm@linux-foundation.org, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 anshuman.khandual@arm.com, ryan.roberts@arm.com, lorenzo.stoakes@oracle.com,
 david@redhat.com, donettom@linux.ibm.com
References: <20250620111150.50344-1-dev.jain@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250620111150.50344-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::10) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DU0PR08MB8932:EE_|DB1PEPF000509F1:EE_|VI0PR08MB11224:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a82d64e-57df-4243-8da2-08ddaff33e55
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?WDVSVzE0VjFpeGpURzVmclN2eUtyaTdFVS9iRWFzMW5UY1k3b3dvcVErRWpU?=
 =?utf-8?B?MHIyYVczaUJZMUo2dHRaQWxGMEhNZnVtbTY3Vms1RDIva1MxTXZ6T2lrVUxE?=
 =?utf-8?B?T2dPSXJhdnZLL1lVSGJ3SmhtaW5HUWs1eTliY24wVVRmaGZSR3ZWVHZHZTR5?=
 =?utf-8?B?Mk1tRjdYTW5pR2FOaGs4U3dBVjA4WWNDaU9UUHdHLzByeG5MT2JZVld2OTE0?=
 =?utf-8?B?Zi81UVdqaU9xdTRnalVlYk0rcDMrMWV3OHF4eDZhOU9lYUNNSm8wUm9hZE5v?=
 =?utf-8?B?eTl5bXNjbmk0UVFCZlFlMkJBL2NHb2xYZVBoR09WRlZ4UitWTTc5VEpuTlhx?=
 =?utf-8?B?a0dwZGhNcmEvd2pCcURaOE9xSDJRTm9JeWNiRWNhUFhrbjFzR25zMVIwNEtR?=
 =?utf-8?B?ZUYybjdxeUNmd1puUXlabnk0UFRtMGpzRmtBY3VaWnBIQWp2RklWZTcvNGx6?=
 =?utf-8?B?SlJ3RHU2a2NlU0pDTm4vdWhUSDcyaW9PS2J5YlZsOEhWeUVYYnJIdVpOZk9P?=
 =?utf-8?B?RURtRlF4UDVIK2g0T0tUWlVNWnY4NVkvdHlQQ0l5RzlHcllLUE1TOVFxN0R1?=
 =?utf-8?B?YW0zVy9NNngrYVNIVGhDaTB6Ynl5QmlwaUgzMUVSa096WTFhemk4Z203NXdG?=
 =?utf-8?B?TUhENnlhVGVKMWpsYi9aQ2l0ZXZTWkZWbE01Vnl2UUladjQ3cU1FVWJacG1N?=
 =?utf-8?B?NlNFZXFRM25zNlNIWXBlSG1QZVhpUnI2RThZR1hRSGpUOWExVDVSWTh0ak1s?=
 =?utf-8?B?bUdDSmE2MDFqcElWU2dZZUxCM05IK0RRaE9aOGNHaUJkekNTUjJ3Q1pEZTYy?=
 =?utf-8?B?ZE4xOTFCZDlxanpScUVZQ0t1c3U2OEVzNzRFMkhMM0Q5Ti84R3g2VzlrdzE1?=
 =?utf-8?B?dFdhUHEyV3pRRnlRY2dnLzdjSlVEVC9RTjRuS3craFVNaGFBSWxXWTk4bjd2?=
 =?utf-8?B?eXRwcjRVTjF1QVArTERqMHlVN2M0QllNb1lBZGRIY2VsWWVZQ0RlMXJhTWR5?=
 =?utf-8?B?dGUrOGZHcEs0ek9IbjhwdU5TTGhDYi84YTJsNHRaTXg4T213Y01LRHROK3Fk?=
 =?utf-8?B?SVJEVmZJdE5NVUU4eGprSGNETFhIb2kzVzI5bVRkUUEzell0akNCeUFDeklo?=
 =?utf-8?B?TUFLTVZyTStpNUZ0SFZUSkNaT1Z4SG5iOHVHZWNlV2duaFU5a1VPd3djeVVR?=
 =?utf-8?B?b0preEc3UnVyY0grYTg4Q0c3MTEwazd0aE42YUVCQXpldHh5Y2MwYlFKYmpV?=
 =?utf-8?B?Z1h1bXZHakR4bUJJR1YwKzBQTVppaGJ5bHZkZERqb3JmRzZuclE4ZXBIWGZL?=
 =?utf-8?B?VlkvaDJMbzRJZHpSM09SRVJBMTdpUkMyMXZhRGhWNWJUQ1V2NE9rTVVjb2Iw?=
 =?utf-8?B?MmVzZlJlTER6WjhYWUtXeVc4WDJuYXdpK0tLWFpvVFA4U0F2aTVweXhRSkZn?=
 =?utf-8?B?OW9xdXNHdy9PNE14eEF3RW5NRFVEaHJHTkpsYXBWc2w3UFRPdmJxL25kUEJV?=
 =?utf-8?B?eGhFNVltclN0Q2NmdE84WjBETEgvV0hWaTVlelpibU1YQlZUQzYyR29xVW5r?=
 =?utf-8?B?NmgyMXpNNkRFVWVjWWlrZy9Jc0xEM3ovNlVtMFJtSmtnM3A1YlcxVVhnZ0g3?=
 =?utf-8?B?VVNiUHlBZXN6TjdUVFAzUlVlNEYwTnFzOW1HTjRkZFd4M3ZzY0ZncVd5ZGFM?=
 =?utf-8?B?SlNieGx4UmRPb2krc2sxY2FoNllLeGZ3anl2eUVBV3U2TEQ3dUdjZEVQblBj?=
 =?utf-8?B?Q3g3RGV0UytzRmlabkNGTTd5WG9sNndrTENFOGUrQUhxaDBPYS9aY0tTMlQ2?=
 =?utf-8?B?YUxnQzR2NWJkSGpRTFB0bVNZL3QwVURRL2x3T0EwbWJ4NFR2UVl2QjVkTjgz?=
 =?utf-8?B?SWlWSERTdm1Wb2RyZVczK1hXY1lOYlpWcjIyOElremdWZHpwZmZXNEhKUGF0?=
 =?utf-8?Q?SMnKiFb+5Mg=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8932
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	df473063-df6c-4dfa-7db6-08ddaff32a3a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|14060799003|1800799024|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUV3ZnpJdC8rQUd4dXI1TkI3WkozUTFyQmRRSCtRYklENU9XQ3JwYzRSeHho?=
 =?utf-8?B?emV3UXFBcklVY0w1MWdQZ3RPK3p3VmQ5WUpKSzhmdHBYM2dsZnA2TDJlVWlk?=
 =?utf-8?B?QjYwbk5XQlJibXhBaklkSUJqRTBoN3Q5eW5vTUVQRzdjOVByLzhtMWd2OWhz?=
 =?utf-8?B?aDFHcU9pOU9PTWxDSUFZUDAyQ1dtRHlSRm1GMkt4emV5V2Y5UVYrYVV5eXRZ?=
 =?utf-8?B?cmxFVUozWCs3WVRZUHdOaVdSNTFRcTZBRDIvdm1KR2dkWVg1VTM5RXFDYkMx?=
 =?utf-8?B?UkRXZWo3RWVTRG5lK0dMb1Zpb28xZVh1SHRGYjllQVVKTEMyRStiSTNINmlE?=
 =?utf-8?B?bEx2YlZhNEwwUjh1NGRuQnB3TWhWQTZ5VEJPd0ZOQzR3SU81NGsvbXJSZmZ4?=
 =?utf-8?B?T1g0MkY1MFF5S1g3YUxWZFJjQ3JqYm95amVyMEJhMDA2SitNVnZpOG01WE5Q?=
 =?utf-8?B?VUxCQUxtVHZadjJyZTVsKzN5ZHM0Q3RhWkRqNEViU01DNmtVTU1ubFNwbUhr?=
 =?utf-8?B?MURldzhQQWx4MWo1VThBWDFLdUtaZlkyUzlQbGRnbXA5N3Zrd0c2cmxmajUw?=
 =?utf-8?B?L0dqYTBnUzVWdjJBclh2RVYrTDdyOXQ4UUo3Tzhza2QrZ1RCbXJBbzRjYWJn?=
 =?utf-8?B?UlgwNW1wNEoxNXlobWg1SDd1TTd4WkJCdnBydWx0TWFWNUJ6TVhYdTJtVVhx?=
 =?utf-8?B?aGtkUWJVUHBkUDM1RHNZYUZoTkdsL243NW0wYWZ0bERlUlFGVHM2Nm03RkhB?=
 =?utf-8?B?SzNVRkh4VUxFay8yTm02bmlIMTFKMXdweW03TXNsWmtjakRKWDZPRXFYN01x?=
 =?utf-8?B?ajJySVFrK2JOZTV1ZWplQVlOYU1WMWg1VExLT0RjQnZJaUVSVXA1R25RVmZ1?=
 =?utf-8?B?ZTBmVWVJajBncnc3Q2trMjhxVHdGR1NUTkQzQllWSTA5OXc4SGNweFBINkRN?=
 =?utf-8?B?UWYvSTFQZmRRYnlrYWNrZVM2aWZXcWprUXV1UzkzV04rM211WUNKMkhMaWto?=
 =?utf-8?B?Rlk2VVI4TUUrejZDY1VpbFpNeGJyK3NHcEdoQzNWTGZSTzRoTlNCejl3L1lR?=
 =?utf-8?B?bVFKZEpDLy9IOUlIU0FlUjV0SGZSU2xZdmQvS2h1RVJRWFZQZXhFVmxWeHB1?=
 =?utf-8?B?UGJhdmlFNW8xQ1hIRCtPL1FKcUd6K0pDUEI2bzlzU3Jqc3Vybnd4S1YxZU56?=
 =?utf-8?B?Q2I0LzNZQlNJRkZCa1dDREJnZnBGTUFrSUh4UllDQ2RvRkEySXBlYzNYQjQw?=
 =?utf-8?B?ay9GbXpaOGFreGZ1Tk1abHluOGpueEhWWmpUTE9sMjhsNFlxQXhiV3ZTUU5x?=
 =?utf-8?B?amRPS01GZXBBV20xSVdEOE5ac1FPT2tUcTNQNit4VnozQ29hQUdvbzlMZGd1?=
 =?utf-8?B?emFocUErQnpqNWFhZlV5L2NpTEhkVGkxa0I0WG1veXpsMUFTVEFxVVdWcHZJ?=
 =?utf-8?B?b2p3bVJ4NG03MngyeHdRMnVLaXFGYUFTay9RbWxUMEpPNzI3Q3pZQVBiSTEr?=
 =?utf-8?B?QkQwNjd4NUQwRzBsN2FmVzVlZ1VQYWw3Uy90ei9LMW5MekkvRHBSYmJCdEU5?=
 =?utf-8?B?bUhGSGJlV0NLd3lPcVVZYlZyZGVscVoxZ1FjUzZMd3BVcTZ1VTZMeDJEalBY?=
 =?utf-8?B?YjRTZm1PdlZQOUNBT3pOa25TdFhCeEhSNExXMk9HSnBiRkdsUmUzdUlmazly?=
 =?utf-8?B?ZVZmdkNtR09KWThEWnJmd0Z4eFFGR2FPdFBZRHRaeEhpTU9TdVNDQkpCVmZO?=
 =?utf-8?B?T1FjZHRVR0dNcUJudTZmWVB1SnlwQUw4THVxL2syTlpjVldLVjAvTWhhZGdl?=
 =?utf-8?B?aFA3a2VuWWRsZU9hbC9rb3gyOHgyNHVvdG1wam1hc01mazVmUmZSTnRXdGo4?=
 =?utf-8?B?VWZFVmVscUg5M2tHZTJxVjk5a282KzR1NzYwUXdJaUFsN3VlbGZqb013cTND?=
 =?utf-8?B?b0V4OTBVRDFwOXF6N3FCWXljTmN2OEU4U3E0bFIwazdlcGtYQlZOeXhyUW1m?=
 =?utf-8?B?WTlJZ3pPNUYxc3hSU0R3OHlDeGxBZVZUVS9OYTFYd0crcjRmWkdhSVBrZmRy?=
 =?utf-8?Q?4rcd24?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(14060799003)(1800799024)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 12:09:01.3139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a82d64e-57df-4243-8da2-08ddaff33e55
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11224


On 20/06/25 4:41 pm, Dev Jain wrote:
> validate_addr() function checks whether the address returned by mmap()
> lies in the low or high VA space, according to whether a high addr hint
> was passed or not. The fix commit mentioned below changed the code in
> such a way that this function will always return failure when passed
> high_addr == 1; addr will be >= HIGH_ADDR_MARK always, we will fall
> down to "if (addr < HIGH_ADDR_MARK)" and return failure. Fix this.

Correction: We will fall down to if (addr > HIGH_ADDR_MASK).

>
> Fixes: d1d86ce28d0f ("selftests/mm: virtual_address_range: conform to TAP format output")
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   tools/testing/selftests/mm/virtual_address_range.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> index b380e102b22f..169dbd692bf5 100644
> --- a/tools/testing/selftests/mm/virtual_address_range.c
> +++ b/tools/testing/selftests/mm/virtual_address_range.c
> @@ -77,8 +77,11 @@ static void validate_addr(char *ptr, int high_addr)
>   {
>   	unsigned long addr = (unsigned long) ptr;
>   
> -	if (high_addr && addr < HIGH_ADDR_MARK)
> -		ksft_exit_fail_msg("Bad address %lx\n", addr);
> +	if (high_addr) {
> +		if (addr < HIGH_ADDR_MARK)
> +			ksft_exit_fail_msg("Bad address %lx\n", addr);
> +		return;
> +	}
>   
>   	if (addr > HIGH_ADDR_MARK)
>   		ksft_exit_fail_msg("Bad address %lx\n", addr);

