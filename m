Return-Path: <linux-kselftest+bounces-34137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5711AACAF1D
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 15:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C743A8A08
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 13:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1B021FF39;
	Mon,  2 Jun 2025 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="el9Lyei+";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="WxDY6mZH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53345221555;
	Mon,  2 Jun 2025 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748871296; cv=fail; b=cXhh/IdYPeqtJqzlKR+QfXPq97qn6jeg9pO95nhpC8dFARj8LhD388efwUULMCQ7R91Pf0bnG3eK5Ve7Dvev7I3zaGwFOHOFjxQfIojmpr596GNRh1ROtteZCB/36Bq68fp4OVIO4dm13i0vLDN+xPtdtBLUENO+ZHAflX2KnnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748871296; c=relaxed/simple;
	bh=Lb3IN/6jXcoSKTuEPqixXW6ADvu+ajRSJXtM97/XuVE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=s09qSXegGP2rQrcGUcggJ2tX0YOBI/7rRFy3489tubB4QUr7nISrn4/gwAJJbrjcTkjD0LOg9Mby4zTudSEW46nXiuk0jlVfDvZSS/57JGVfEqjskMgP6o8DwXnwf29zb8TBvKa2SFUM7ZtfwZD7w6X4ZWSR/B5MWh+j5E+XFio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=el9Lyei+; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=WxDY6mZH; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552BR1wh028253;
	Mon, 2 Jun 2025 08:34:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=eqkp8cJswYuNo00IqOWPzyFvg92xaNUGrXfgycgck60=; b=
	el9Lyei++qn2zAXGfpMxVTq8gExkxIt0mi0FGVTGoVyZ/L9Km8HXuxa39t4623X1
	YqP5yjt730Q0ETSGvY8dgVtSBDb9fCuriC5pQZhY/sNZnbKr5BpRK+HpGBxJj11d
	SvKnGwuUdc4EyIWHFSV2mTczVt2VRN/uIuhEKtgPkHgSfbGHYqKFhrbMSl0Rq3vc
	5dEdSPym3JANnbWyzNvtJ3/iu/qn9vhw7GFmTVOBd5lh+/c7wsj8UdT3N9tErWx5
	cvK3gkWPMdaTiBdReGo31rcLohJ1NCJW/byiJMCFcd1f05iUPa2Plkr6oLzl8Wzh
	2WACppm6nmZ9eZ+Kest8Fg==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2097.outbound.protection.outlook.com [40.107.220.97])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 471b3806x3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Jun 2025 08:34:24 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWo0Yp5FzRpp0CpLimKZBCrzoAjMuuB3+QSbOJC+dQccXAHHX0zs6tzxIX64XnrtqXYJSgilEangW/SOJlsaFQakqnq5ymc2xCLZCf4li2ZSeQ3Do2sMaXDZBAmin3dqqo549WYCYZptaP9yff4W0QD98t718dcJ8Q4RBt3Ncgl/hq+/Ua/hu0V8A5sOz7YA+NfbQB8wfztoaIKz/GNEbhfau1IDxliSMqESEoIhKZmkJ20Z1IZWwLDsLVcCCfAgAHA0qYMjNRVvx5dz1Kmi5yx5ZP7dn+0iDHo3p3lLn/y2tVlCPgtl81bT6XRaKlY6m9IhKEJMvTPAlamN9jSZog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqkp8cJswYuNo00IqOWPzyFvg92xaNUGrXfgycgck60=;
 b=Xw1mJBE51SyNxUMYL2z8dy7y4EafoVJWe/+eJ63kyFVJZMltAEzfHQATZFVjcH1Uwe5RLrPMoEOA2gQ0Hlsb2kNOjbws+cXn/+K2maNt2jlEssz/VzC4YYH1muQRdpFwls16m8L/2R4lw7PCYJcqMtTGd0WSAIQ19LgBkV66dghY0gG3lp3V6dPGcSufcQTFDVA8RkMi9CFXPi3bgwlMIpxpyZtnFZ+anWq7ho9GgltvJDIgtAMcHQ/Fd8LdtlHSbDr55q6Q/NR3XgghpN2cxKOXoCN/L7sXDRThAeViISueMu8Ma81JWFcAdO1c+L6fszY3ZoJSAoDUOT6ooP8mbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=davemloft.net
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqkp8cJswYuNo00IqOWPzyFvg92xaNUGrXfgycgck60=;
 b=WxDY6mZHDIFnaGlTJqL9T+D9+CNHD+w4N5DalFgq7iB9HcdlLj15Mqc+4UbI5XBCDWi08h0WO8RBvL+jdyHcuU1ahcDFpSY0Rx7IAtsdhWyhB9tMo1ATSY+xwfInHa4IKBEE7JvHM5SIjiqP+r13Yp3jx1CZ1nziX9CITv2I0PU=
Received: from DM6PR17CA0019.namprd17.prod.outlook.com (2603:10b6:5:1b3::32)
 by PH3PPF8B4EB7E23.namprd19.prod.outlook.com (2603:10b6:518:1::c39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Mon, 2 Jun
 2025 13:34:20 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:1b3:cafe::b8) by DM6PR17CA0019.outlook.office365.com
 (2603:10b6:5:1b3::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.32 via Frontend Transport; Mon,
 2 Jun 2025 13:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Mon, 2 Jun 2025 13:34:18 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 2EC8940654F;
	Mon,  2 Jun 2025 13:34:17 +0000 (UTC)
Received: from [198.90.208.24] (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 31686820258;
	Mon,  2 Jun 2025 13:34:17 +0000 (UTC)
Message-ID: <74d3a550-a828-4666-8664-d08d06fc6f0f@opensource.cirrus.com>
Date: Mon, 2 Jun 2025 14:34:16 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH net] Revert "kunit: configs: Enable
 CONFIG_INIT_STACK_ALL_PATTERN in all_tests"
To: Jakub Kicinski <kuba@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, brendan.higgins@linux.dev,
        davidgow@google.com, rmoar@google.com, broonie@kernel.org,
        mic@digikod.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
References: <20250530135800.13437-1-kuba@kernel.org>
 <9628c61e-234f-45af-bc30-ab6db90f09c6@linuxfoundation.org>
 <20250530180750.4c722f71@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250530180750.4c722f71@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|PH3PPF8B4EB7E23:EE_
X-MS-Office365-Filtering-Correlation-Id: e243792f-de39-425b-b4a3-08dda1da2d02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34070700014|7416014|82310400026|36860700013|376014|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFRSazBJTDFVaWlNUFJMZ05CVWFvdDBrY2w3cW1ZQ2dYV1V1YXRpMEt3eFli?=
 =?utf-8?B?SGxJYXRYVGE2b3JYeStseDhiTllQRkdLRXQwODhIL3dIWGVYSkEzbUoxM3Y5?=
 =?utf-8?B?NnNXd3c3NUdwbTFNdmw0M3BDamVhWVZ2OVlBZ3pjZGxKb1NWSzZwbmFjK0Va?=
 =?utf-8?B?dTgwYmxhUGNYSDBRRHBoWlBpTjVHMDBkWS9NU2tWV2h0NmRiWlUyTnpkdWhE?=
 =?utf-8?B?NytHTEpsS1ppMVFvendUcEtwRmZjbUM2RDEvQ1NZV0M1SFNXSXNoVElYVFhq?=
 =?utf-8?B?cmVSY0VBTy9ZNVdhSHhjMlpLTkNqQ0ZoeGlmUk9OejZITGtBVDRYTTJDbnY5?=
 =?utf-8?B?bDhRazQ1RnFrTGIyTEE1NlV5WVRxSjlCc1UzNTh0dzhBMzl6OUE1VTVlWUVp?=
 =?utf-8?B?aGozdVlqbkcxeGJwVEx1Zy9jdU5yQm5BN2M1UGM5NnF3V01pMS8vUEc4dDBB?=
 =?utf-8?B?S0dEbE5aWE54dWhKdXV5Wnl6NlhneTYwOEVXbkduMVpqM0pyaG81V0hBckFQ?=
 =?utf-8?B?emtjWVRHVm95enNoRmtNd29wS0pJejBDZjV6OTR1Z05XUkVPQ290L21yV0Y5?=
 =?utf-8?B?TmloMmUrMVNIaXhablhsTkJGd1hOYTlLK29xempld2pwdzVGT2NpVHV6V3U3?=
 =?utf-8?B?TktLZzZPa1gvUGhhT2JRWXhaVUJCZXdXL3dweW1DeDVPQVoyRjdhSlhJSlho?=
 =?utf-8?B?MExOVFdIRVRmdEVTdjgvVS9iWVIybFFIV0dFZlM5VWtCMXVYV29nc0VqSURr?=
 =?utf-8?B?Rk9kaVNxQnVvZXFhQmdaVTFDaE9MYm0yY0RKWUIzNkJLeXQxekczcEI1TkpQ?=
 =?utf-8?B?UVZZM2tsU1JCWnZYbkc4VysvQzZxaXFjZFlrZ3I0TWhyMTFuUmNTS3hHZG5S?=
 =?utf-8?B?cmVsSmZ5SzN3Mll2L091Tmo2WGVhVytFV0VHVTBZSXgwVkpHYlQrelg3YjJE?=
 =?utf-8?B?TFRmU1E3UnVoSzlpNnZzWGhMRG4zTnBNZmo1VG53WUM4U0pBWVlJU3RBVzZz?=
 =?utf-8?B?UnVrb21mQlY2TjY5M1Zob3ZWQVBKdE4yWTAxdnJ2U00rYlQ4VVFtaEpQdmNx?=
 =?utf-8?B?Ny9yVDNjbmFKc0FCNnZCR0phRURITFA4Zi92bFRYRUpCS0ZXUEVaSlhsRnZJ?=
 =?utf-8?B?ZzBYSlA0SG5KZW5jWVQxUThkc0ZUNC8xcmlTM0dsSldkWEZlcDdvVjFnUUpR?=
 =?utf-8?B?dXg1R0MxV21DNWc3R3d2MFl2NENiZ0IzZGV3T1M5UllPVlhZVU42eFFwZ2lG?=
 =?utf-8?B?amQ1bTlrWFhtbjRINk9RdzY2N0c3Sk5ZdWtUZVIxK0JkSkJNZGljRzJLKysv?=
 =?utf-8?B?emgvRm9lVE84M3B5R0M1VUdZWXhHSUtuODlPbmdzNEd2cXVKZlkxOG9oYVFB?=
 =?utf-8?B?aVpHeTREQW9WcjlFM0NNeEJUeHFBV2cvMmlwaVBwemREeWVRM1BEblBncFRo?=
 =?utf-8?B?UHA1R09wMmZPOU40WWhvMGJqZUg5QnYxd2FMaUFOSHd6RDFkL0xHQ252Z2M5?=
 =?utf-8?B?WkxJRFhEbTdLK0c0dXBRb2REMklRODBxbGpwVjMxQ3dIYU9rRDc4SEkvYStk?=
 =?utf-8?B?WnFoRWcxd09sMmJhVDllYVdLZnBrUy96YW14RjAwTTlFT21sN3FpWU8vLzVL?=
 =?utf-8?B?RUVlWVJCbjZKdDFaT0s4L3BCR2gwTW9kbHgzTW1xd2NFUi9YWnl0K3lOZDM1?=
 =?utf-8?B?RnRuWU5nYWpkMEtud2FLOXh5ZHdnWU1Nd2ZMYTdPWkZiL01zYy9kYTZ2SG4x?=
 =?utf-8?B?SndkUk5BNkZzRVF6bU1hYy9oSFM0Zkp4WVBwRWc4bm5wRFhhcG9WV1phanUv?=
 =?utf-8?B?MXdCZm52K1cwTVZ6azlmRTI3UnFwdmdoWTNwQkZucUxieENiMmZpNThzRDB4?=
 =?utf-8?B?KzRpaCtWVHNrT3N4RXRqTy8welhtcS9NWnlUdVFMeWhUUFVRSm1vZ0pteCtn?=
 =?utf-8?B?bWFSNnpJVkVtTHZyL2R3c0dJaUo5cUdOZzZyTzRmVHl2dzZQSlRScmFoc3Yz?=
 =?utf-8?B?alU0WTJUQmJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(34070700014)(7416014)(82310400026)(36860700013)(376014)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 13:34:18.3800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e243792f-de39-425b-b4a3-08dda1da2d02
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF8B4EB7E23
X-Authority-Analysis: v=2.4 cv=Kf/SsRYD c=1 sm=1 tr=0 ts=683da860 cx=c_pps a=Ze6KCB9QP8ZtDdwQ7yE/RQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=RWc_ulEos4gA:10 a=VwQbUJbxAAAA:8 a=Dbesrkm3OhuCW59rINcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: sq8J_i3bC0-jgnsUHMSYGOsNr_zocXmg
X-Proofpoint-ORIG-GUID: sq8J_i3bC0-jgnsUHMSYGOsNr_zocXmg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDExMCBTYWx0ZWRfX0aqMOGWwNbet bsprOSzJlTOW7Ou3MYu+tBY3obbGRQ4ohHui3AMSeojKzinPPbjoSN/M550VTF/p75gvebTEJkA 7nMWlvuR6tmnI3qrecUW3wgUCWjCwWQdhMud6QeVLKpg7igT5sH+KKb6LyeCrWcF+cWOkkxbCI6
 0DWthK+joFTQuOMgVkDEaTVX5j/VHJyfJPlih8Y37FAxawWiapm7oW9Emxj23cGN54w3M8wBVwO hpZZXyl1YnMd4aTlbJNbxhPqEmKrZAitJk6phRRod+BqUSpn5hY9XAtkmq7TN53R8X73/3gWHZv ldnxkS/KwqSAn/Ew6J2eCPmbAeAa30IIQ+hXsr/Vg62j/t/PhQKBynBDZsrwLQsmXelfj04GASY
 LccEGvDV6ZRjdGdmN5cKc5eyBcpjlOHXvMo7vpvBItjrd0cekkrLN37eYjh9zhCBHFfywg04
X-Proofpoint-Spam-Reason: safe

On 31/05/2025 2:07 am, Jakub Kicinski wrote:
> On Fri, 30 May 2025 10:59:54 -0600 Shuah Khan wrote:
>> On 5/30/25 07:58, Jakub Kicinski wrote:
>>> This reverts commit a571a9a1b120264e24b41eddf1ac5140131bfa84.
>>>
>>> The commit in question breaks kunit for older compilers:
>>>> $ gcc --version
>>>    gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-5)
>>>
>>> $ ./tools/testing/kunit/kunit.py run  --alltests --json --arch=x86_64
>>>    Configuring KUnit Kernel ...
>>>    Regenerating .config ...
>>>    Populating config with:
>>>    $ make ARCH=x86_64 O=.kunit olddefconfig
>>
>>
>>>    ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
>>>    This is probably due to unsatisfied dependencies.
>>>    Missing: CONFIG_INIT_STACK_ALL_PATTERN=y
>>
>> Does adding config option work for you?
>> ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_INIT_STACK_ALL_PATTERN
> 
> Nope (with this patch applied):
> 
> $ ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_INIT_STACK_ALL_PATTERN=y
> [18:02:47] Configuring KUnit Kernel ...
> Regenerating .config ...
> Populating config with:
> $ make ARCH=um O=.kunit olddefconfig
> ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
> This is probably due to unsatisfied dependencies.
> Missing: CONFIG_INIT_STACK_ALL_PATTERN=y
> Note: many Kconfig options aren't available on UML. You can try running on a different architecture with something like "--arch=x86_64".
> 
>>> Link: https://lore.kernel.org/20250529083811.778bc31b@kernel.org
>>> Fixes: a571a9a1b120 ("kunit: configs: Enable CONFIG_INIT_STACK_ALL_PATTERN in all_tests")
>>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>>> ---
>>> I'd like to take this in via netdev since it fixes our CI.
>>> We'll send it to Linus next week.
>>>    
>>
>> I am good with reverting it for now.
>>
>> David, Brendan,
>> We will have to enable this at a later time. Also we saw this problem
>> before with other configs. Anyway way to fix this for alltests case?
> 
> FWIW Richard commented in the linked thread, IIUC this was just for
> added coverage but not a hard requirement.
Correct. It's not required (for me). It found a bug in my code, so it
seemed useful to have enabled while testing. I thought this was safe to
do, I didn't know that this only works with certain platforms and
compilers.

