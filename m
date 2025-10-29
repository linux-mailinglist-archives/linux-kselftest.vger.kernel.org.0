Return-Path: <linux-kselftest+bounces-44318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 024CBC1BF25
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 17:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2BE7F34B62A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 16:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34C827B4F9;
	Wed, 29 Oct 2025 16:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fELxvwNL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c7eiCZGR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D441EB5C2;
	Wed, 29 Oct 2025 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753985; cv=fail; b=q3GUn98XlQqvwiRaiRYvjvCKitP3X1ywR2+z72SlAkpygLIZnflnKcNQcCOqgGu5dNDcOk0blEenSEpSpJ1yneWxFvAwry0CHPvXaA//HjvR9fKPSFyUQ7zR0Hob3+9PWw0BYQCh3++3LY/mnbD4Trg3DfL0bg/ruf/c1RLFKNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753985; c=relaxed/simple;
	bh=7xKjFxPGY89XRDkrlLldGTv/ASMOEiqn97zh+wmpo8M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JUbSc0tvghtv4odCoFqSqyCzGPdhOQFmKdteldWZ4cqaMndddGvoX8Ut5UkciFvS00iJI4kb9/7YuGuoFOC0ZDedH3Hlmg1WRbkoxELaCcaf6im6YTdcHKDKInpJOqElXrRWTC9ZtEVfL/WB/jaVdGRrvFvVhy+23VQVE/W6pHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fELxvwNL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c7eiCZGR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TFgUtR014826;
	Wed, 29 Oct 2025 16:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=i2D1n0wFyuuVFsRRGfjR5wlMxnZNdj8yzMDK3hWrAGg=; b=
	fELxvwNL33m0P7n0lOjTjsBPz1N+KhQ66Eqs4fyNQkip8tGMmHn41R07WKYkv6ai
	RNkpKxB/JSigHc+5UsNL/DEPhKpHkHeTIkq75yOZqZMErcFxylo9TAzlccVopzD1
	re4gNxI3f0sy5elI6luOd3wEuxC7mDBv22ui/byElOBp7SATjlKn+NKNN3uUZb1p
	Hvxi/ckewrUTYFEj9M66uywOGxE+szUjCkKgaGwhTXjsqBMmAqW6Xx73FP8HNQCL
	TyvC5nB79ej7tgnBO3UaQLxoIYkeRV5Ru1hdaKK+N++8PRcvwkZYgPLicfiyHDSd
	WdXTTB+dZZSsTrhpjGlWNA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a33vvj9k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 16:05:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59TEd7Qv021185;
	Wed, 29 Oct 2025 16:05:55 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010027.outbound.protection.outlook.com [52.101.193.27])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a359u2p81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 16:05:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrHTBrGwgiLW00qBtYu8W0eF3i/u5NbQOJk+3e+Tga0TF9uLRMz8o63nkNaq0jvTO6kogYa5UnaI9Z1t7M6jkZjnV3BHGIwQm7lp0SQ3QPOLD7jZjGmWuHUQHdY9/Rby4i4nl/2D7NUGPhqaL1sGxYO1+R3lf7v4YY1sJ4u2ILcU45tMqFcDQgjV8deAHZl0VWQrzYLhQNG6OkgBAok48+RUWTajf2KJgnV4pw1qhQVno3XNJxRWNvcHIBl1CYB+QwJLzq5d2yWi45mbtUEsOkOPL4S4UKZEUykUxwd3fZ1PJMmKWi1eXwrBzL2rLraWbxBSRQVkRXMsCQ/aqn7Ujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2D1n0wFyuuVFsRRGfjR5wlMxnZNdj8yzMDK3hWrAGg=;
 b=lWSTUrgyzL5G+vniaZUvonsib8LogWC10fE9jGTJvYwX2OXNvlSiLa9aq3fPTYkcbe6vaMrLgdjePXug1trP5huNYKmtr89UuhZq1zUr6KC2kE1gBU8t8oBNueGM5IOTajcgJ3pS4BGNZx+2ABinmEicPvl7Grw7SOT/PgpUXwauXJ2IAnFmA5DrDf2mDWv90faQwZkyIwonaiNYBqfhLEqndvNbmM+8GxM8LcUnilxzE3llZ37DxMsb862jiBDjZ+iuyzkOFR5RyGcJZjLoQazkH8pcFQbgufOszQHYrJ1gEK7kCSKxfcdwH4iioyAgaeucnwF7TzyzsB2NKhIN+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2D1n0wFyuuVFsRRGfjR5wlMxnZNdj8yzMDK3hWrAGg=;
 b=c7eiCZGROe4BLW6eStKJbLqo/pR267wh21PmoB5yr4/QTdcmLBRTFdga948JbqLAgvYEE0h+hmqyfp7KUeqbdTDZ8UU3fBEm0g5HO4VT4uJQwF4v5LkprVcKgTowQvHBoxIWDV/zl036iDxt5WiDWYslvRXHAqMF/M6xhPGkhX4=
Received: from DS4PPF5E3A27BDE.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d20) by DS7PR10MB4910.namprd10.prod.outlook.com
 (2603:10b6:5:3a4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 16:05:47 +0000
Received: from DS4PPF5E3A27BDE.namprd10.prod.outlook.com
 ([fe80::aa3d:bc4c:4114:cd4e]) by DS4PPF5E3A27BDE.namprd10.prod.outlook.com
 ([fe80::aa3d:bc4c:4114:cd4e%4]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 16:05:47 +0000
Message-ID: <cc32d3db-60ef-4046-8988-289cd0cc8c26@oracle.com>
Date: Wed, 29 Oct 2025 21:35:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 1/2] bpftool: Print map ID upon creation and
 support JSON output
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: alan.maguire@oracle.com, Quentin Monnet <qmo@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20251028125705.3586552-1-harshit.m.mogalapalli@oracle.com>
 <20251028125705.3586552-2-harshit.m.mogalapalli@oracle.com>
 <89b12696-26ff-411f-9cd3-74361f0f1ecd@linux.dev>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <89b12696-26ff-411f-9cd3-74361f0f1ecd@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0135.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::27) To DS4PPF5E3A27BDE.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF5E3A27BDE:EE_|DS7PR10MB4910:EE_
X-MS-Office365-Filtering-Correlation-Id: 9edece90-b2c8-4382-4440-08de1705054f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S04zT080cHptclgwSnhrSW9vZHdYUnRDYVREN3FPTlJuSDd1S3UwQTlFaUVS?=
 =?utf-8?B?Z2cxUVJNb1VuR2gzclJMdHFFdUUrQ093dUxFd2Y1SHlxSzYwNS9Bd2UrR0ZW?=
 =?utf-8?B?MjR5Nlh6MThhVU5UdmMrSEdZODhvSzRSK3M4emU5L1lsSnUyaXVlTHZJMDkr?=
 =?utf-8?B?dVJ1WlRXaTBvZkowOEp3T0dWd0s4L1FzNUErbmMzOFR2UHVzejRwVkxDVjhx?=
 =?utf-8?B?RlRQa2xCMTB4d0hSNG5WUnBwTmplUmFxeHI1dUFCSVN0TGtWRmFXeWZvc3Yw?=
 =?utf-8?B?MzBjYWFuaXMvTnM0U2d0RU5hYnlhczBqVExwRlJneW9JSmthNmtLeGY1MUxV?=
 =?utf-8?B?VDlJdTk3UU4zUXBEWTdzclBCaFFacnlKYjRRano0L0cwbitoaVNpVVl0OE5w?=
 =?utf-8?B?MXlHOHNDeHI2d29DVmxJNFlXN0R3cVQ3K1R1RjVPMW8yVStvSWQ3VjdxcENk?=
 =?utf-8?B?Sk1Xem9rV3p1RWh0U05xbHA4SDBjYnN5MmVmK0d5NENYbXFyT2RTUFpyYldH?=
 =?utf-8?B?M3RpWnd4YWUvMWlTQitRNzVvQ3RJS0lMUVJnWUc5aDNMdFJHWU1TYmVDc1ZK?=
 =?utf-8?B?M20vbC9LZG00OCt2dFBoTUt3NCtpOE04c2VhK0RDaHlLNy9oMGlMSzFEeXpL?=
 =?utf-8?B?SUc1L0U1ZnRIRkpHREhMMGNvOGQvSEUvVWswS2F4SEk4MWxxbmFFTWk2SVE5?=
 =?utf-8?B?RTNvS0ZKK01KbmlDZXZzVEhucE5oRW5hMTJLNG16NlBMSmIwc0NiQ2JTVnlz?=
 =?utf-8?B?V3d0cFdhV1pWcGUvbnpBQ29RcVJ6QVIxSitPQWxCT2xFSG41Z1psYk11MDcr?=
 =?utf-8?B?KzRBS2htelR4SFYxdk9HRDJiZURNS3VpNS8xOFdWR0lGaXA4VzRuMWRHd2x6?=
 =?utf-8?B?VmYvUDM2dGhnN0liVTRWUm1oR0V5NDYrZWtSYlR3b25ZT3doU0JSVnNlSG9L?=
 =?utf-8?B?TndCTnF6ellMQzRFcjlNWTdjMGhZMzNZOWVKNy9wM2VjTVZ2U0dET25SWmdN?=
 =?utf-8?B?NWdvQUlHa2QrSEhNQys5MUYxMUFvaThUOUVmN3RSaitMdXVCV1kzS1QwSzFz?=
 =?utf-8?B?eUprcGVDRDdUL2g3SnBaYnlCMFM3RWdkbnBPRFc1aHE2cGYyMGI2UkRXMHlD?=
 =?utf-8?B?MnBka3lMTnN3dndXQkg4TjZXY3V4b0x1WHBWS0NudXBZbTUvemMyRDBNL1Mv?=
 =?utf-8?B?MU5BKzd0eW1SYVBUQlBINVMvcjNHRVdOaXc2WU1ObCswUjR4YjlSTDFEaVVS?=
 =?utf-8?B?NzU4OHplRW0rdytQaE9yWmZDMTljVUNuYUNzT0NZeGZUSkE2dzZBeVRJb1VO?=
 =?utf-8?B?aVduM0htM1dwZDZ5SE5oeDBKcmdjNWVtNm4xWklVT3BtRFFWTWs5RHdPLzll?=
 =?utf-8?B?eS96SWt2Tk1QdEQ4ZnRqSHhCMFltQ0VBdjBqU29USThEQmJwZUVnQXVPanlG?=
 =?utf-8?B?djFTMFNsQWxwcXlhbDduQmxkV0N5emtmcU5IL01SWCt2U3BpajN1dXpKMWVq?=
 =?utf-8?B?aThldmJoNkpZMis5YnlEZjFuNnIrQWo3bFNFU1FIVnR0K0psL1BtVittLzk2?=
 =?utf-8?B?N3V1MTk3TEVnUHQvNW5ZZFI5MzNsY05xb0tjUjFrYUlVTmN5Sm9GbWdqY05y?=
 =?utf-8?B?Rm5ncUJTVzJaaDRVVTJEemkybkJQcmJvc0h1ai9naWYyK0pLWE5MYzBING9i?=
 =?utf-8?B?OWpxdnJmYUtWR0JRMHFoTGpFU0VxeEhRMmk5Qlg0TDI4ZTQ1cGVVOVUwbUpV?=
 =?utf-8?B?b1hpNTNaSCtTTklrYXBWRzRpMFA0QWxIWUhSQmh1b1dnSkJ6TS8ybDZJNVNo?=
 =?utf-8?B?Qm5GNWtWYkJhejZVWjBsWWJ3T3IxWGVpaU1qbkcwTnI2Sms3azQ2d2ErNFNT?=
 =?utf-8?B?UXNSNTh0WkJOZkM2bzR1Z3YxYmlvNnNKbk1Lam01U0lFOFlYenhGWE05MXZE?=
 =?utf-8?B?a05UUlRMaUNZNDFTTS9OQ3gxRitSSTlBSEx1b2RNODlZWm1nQ2xVUitvcGdq?=
 =?utf-8?B?NUpYNUdTR3J3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF5E3A27BDE.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWVkaG5JTHpxNk54ZDM5YjE3cVgrcHJxUkNYc2lwZnVycDF6RUJWWlA4Z1o4?=
 =?utf-8?B?MXpHYVgyTHFPcWZPanpDajFTay9wRDV1VzZtTHAzUERFQTk2WGlTNFhlY25a?=
 =?utf-8?B?MXlSZjVKa0p6YXRoUlBpRDdyaEcrV0RHZ1NJQ3hxRzJ6Q2Q2Sy9Xd0tOREFD?=
 =?utf-8?B?ME9VeGYzR3JLTGc4cjIzYjBRRUEvZFdFcTNYdkVaeVdsU2dRcTRHNWR0TTVu?=
 =?utf-8?B?ZHlmVEs3a09YWTViU2FLVGxzeWs4RUFUZkNTT3ArY3hzWVlxcEgyc2NwV01n?=
 =?utf-8?B?SWRNV1pEMTh5N0lXRUdGN0xBbStvV1N4Wk5HRE8xREMyVlZtNXJLRWl3M3lY?=
 =?utf-8?B?NndOclVnbUpxS1BSb2ZTd0JFL1NOaE1JVUM5UXNtUW0vb2ZmMGx4MS9TNUZr?=
 =?utf-8?B?blRTaVM0ZUdTRkd0ci9HUER3S2pYZHROK1dyWFBOaG9tcjFiYlB5NE12SWFU?=
 =?utf-8?B?UC9CUGZBTUxQc3ZxV3U3UE0yN2JTZzZMVmU5MTRidFgybzJ1NE1UazhIdFhz?=
 =?utf-8?B?RVA4ZmwyQUlrTFEyZDI2ZkhhN3A1QitrczdneXdNb1p2TGRLdlhyYkZsZ3Z2?=
 =?utf-8?B?RXNjSTFpM0VxQjAwbkMyQW9CeVN1OVJ4SERSOUNkdzNwYjhkcDVLaTkyMjJQ?=
 =?utf-8?B?RjdSa0FzQ0Z3M2lwbVNWRWVCSzZTc1FZSlZVN0FpUGk5dWFyWUtQVkJZMTVW?=
 =?utf-8?B?NlFJclV0S2JiYnNsL2pDN2szWWxKMmtib2t3NEs0amtjNzdaaDR5c3BIZURT?=
 =?utf-8?B?NjdEWGVFaGRlR3ZCQ3J3N0NSTkE5Q3VMVnN3dElpb2N2c1hRa2VKQi90V2la?=
 =?utf-8?B?cFdhZ2N4b1Y4b0wwa0dVakcvM1doSGNJSWR1TTlkOVpHMDd2TjQ5RHpPQVU2?=
 =?utf-8?B?QUJ1QlRadzYzbk55YkFMSmt4THhsem9WZWRMWm04UnBMYWRORlVJUGptVCs0?=
 =?utf-8?B?RmR4dXlFeDkydlpLMlBZK2YzdE1IVElwSHVJSVZVNUw4Wno3cldIZGw4VW1q?=
 =?utf-8?B?bHVnTTJSWkVhb2ozd3pBQ29QREF5ZWF2ZXhPTmFJTTIzY3I4QnZFYWdWMnVE?=
 =?utf-8?B?ZzhkdWMrcENMdnRvL21CeElFUjgwd012MnZ2QmtHRU9NeFRJUnJraXdETnBu?=
 =?utf-8?B?empqQlhqRHh4UDR1NUxhQXpzcGRLckFhZzVGQ05ob0Fib0QzVmR1OGw0Si91?=
 =?utf-8?B?NUI4UjNoUFE4VTJOT0pNVXFicFV2Qi9ONE5sNVd4ZExuM1dCcnEyVnphOVIx?=
 =?utf-8?B?MTdBQmxBZy8yVlNRUVBxcSsyai9KT0VyTDNrUGtFZm5Mc25ieXNPUTlLdFJh?=
 =?utf-8?B?QThFRUt5SUREc1JGMytoRDJpUmdVVzRxTmV3cStWOVo4UjRKajlBQkRVS0JN?=
 =?utf-8?B?RmVlR3EwdW1Qd0YxYUEwaDVxUk1GQXNkMnlBdCttNmluN0orUXpnb00ySDlT?=
 =?utf-8?B?UTFCY1Y4N3RGRWpWTkh6aFJiMDFyUFFTMjZacjE4SmZrSnlwblZGcjJuYW40?=
 =?utf-8?B?THZ3WVV2blp0emNTcmpTZm1Ic3RqcC84MjYvVExta2dYeW5RbEFjWnJHQ05j?=
 =?utf-8?B?cEpIWERPMm1ySS9EalVVczQ3UjZiZm9KQ2Z6NzAwT0ZJbnN6bE50bFJsaTVH?=
 =?utf-8?B?aU83eW9PQXA0QlZSYWlGQkdLOEdhTGR4L3pOZTVoNHduQjl4MEJ6akVERktB?=
 =?utf-8?B?R1dVNm4wN0VEaWRSWVQ4aXo0cDhGQ0FSV3I5Rm5zWDlDb0tFcG5tdzRRYmRO?=
 =?utf-8?B?eHpxNmc5RmlCdEtwTHFKUlJPNFphSWJkeWh4L2FBOG5tNVFiK3VuTWN4QS82?=
 =?utf-8?B?N1VZVTRGdUk2UEVSc3pRSmYwWEJTL1JhRldWMmF2RTVpODJTWXp2TE1IZU9T?=
 =?utf-8?B?RGp3L0ZLcTUwVUQ0VFJPRnpOMUI3NUc2Qi9abUFMVzQ2WjNZblhMYys4eHpk?=
 =?utf-8?B?dVVGU3lVUVhpSUhMMVphN2gvYlQyR0tFK2FrcHYyNForRkQvOUkwS1UxeFI5?=
 =?utf-8?B?K1d3dVU2L3ppYnBDYWlYcHJWWUkxZEM4ZWFvRmdUM21ITXV3bjMwTHlpZWoy?=
 =?utf-8?B?U2FBOFRIMjBJemJ5QWsyWTIzamNBU2hpaVViN1dTdlFQM0Ivcnd4aDI1dHk5?=
 =?utf-8?B?bmlISUhSREFsVWpVREhsVnVYS0YySzNodUxOMURNQ0VnYzZwUXZEU1hUTXIr?=
 =?utf-8?Q?LfE0l74EPKMzZL2/q0syF4M=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WBj9gQrwHuc6x4OzbFuJXNdp0pOj58+8nBl6iJ4AHLolmhTDO/kCCauS+kQRA3d3Q03qTXaDMeU7/5zKD1mDFm55tut7ECNJxHnrmmH15fXWGqTGpfDD+2vgMpDX3p5dJfJ+bX1P6Sa6jPP+xbX4cXi12FOjY5UR4mDf5+dOKL4buTZm07Vm+0mYcH7rxuUORPB9gf7gDsYBDCKntoWPz2c4OiFRWdtmV7FMxQx3G+GEc/gPg/+UTfOsW/vB90F+RypA2RyW8AMdCPE5tXODl9fiHQZBwdV238JuMbi66NejWRf83NGEOlrUKd04AsoHq441JGpum7z/07x/3A8B36ag9wFd3+eeklaTO2UprcaLathT1WMbXE42B5XjGpKNHczV2eDXUewRUdGufnYVEB2LcOTrYY8oPzisDWkq0UjkrzfUGmiA8WOYilDNnJ3qIpcvnAQ+79JAUgzDmQVVCkNPy4Wj3VEw9p7DlTAJobgJWcyjGXZQgyi8GlWEBY3+f/Zu9dhU0xT3zOrm/1KopyE2O4EanLp9lr3X2k+A57hgaK/yEordb8xw7EsX1lXX52umorFjbfYP76Z8jXVmL0JMvxAYvqeNjToeNxhrITk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9edece90-b2c8-4382-4440-08de1705054f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF5E3A27BDE.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 16:05:46.9127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8tvj+x6M8Zh24drXqRpIjfjBXvfHfoecz49YCV5331JQ4AhbKTtl3vyPRn9ze3T9SW6yAa7JyoEtXjOQLSFkoyKwUbhPsaQygzJIPlLf1qpba3NyBwWaLguw18bmTkO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4910
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2510290126
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2MiBTYWx0ZWRfX3UIDie1OlPeW
 r64BDYSkrCt9ZhZs0iiyCU+ObOAbX96f0ZCbNo2z8mpOj8XnvSXylq/v2zHPyb7GnoaNdOPNa1m
 h0yh3wmJVTihuO9s0/Z6pRT7RY3/vuAtRmGCJ87KE5HRa62XKtG24QE63whM6jJUnslRQOPmmTY
 aIxgEAinfI+NFZGIcmUairJ6K3eeI0rIrdKa1crlKBcHHVMHzsdDdJLUojGMzfp0pyGBN/errhb
 eDjQ33/hu2w8Xj4lMNichV/9MhbfAyk9eAnRkflpSE4qZ7OQDuius4DQ7PkBaX7j9SHvg7239vg
 2zhbSlRvpOKxQlUFhMtJh4gqI7KjelNOFov9GWMJUOVM9LFBqbREqAbCqZuMtXiSu6tHeusEcv8
 lS+c66vqsQY0SodOZkETBaI50PHGOCLX9gbgAEahwqumeIo15TY=
X-Proofpoint-ORIG-GUID: KzkFjcMb6EG3kRq-8ZTtHD5d_4Xpz9Lu
X-Proofpoint-GUID: KzkFjcMb6EG3kRq-8ZTtHD5d_4Xpz9Lu
X-Authority-Analysis: v=2.4 cv=SJ1PlevH c=1 sm=1 tr=0 ts=69023b64 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=yPCof4ZbAAAA:8 a=x5d-3f5kx3CIXEV4MJoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12123

Hi Yonghong,


On 29/10/25 07:44, Yonghong Song wrote:
> 
> 
> On 10/28/25 5:57 AM, Harshit Mogalapalli wrote:
>> It is useful to print map ID on successful creation.
>>
>> JSON case:
>> $ ./bpftool -j map create /sys/fs/bpf/test_map4 type hash key 4 value 
>> 8 entries 128 name map4
>> {"id":12}
>>
>> Generic case:
>> $ ./bpftool  map create /sys/fs/bpf/test_map5 type hash key 4 value 8 
>> entries 128 name map5
>> Map successfully created with ID: 15
>>
>> Bpftool Issue: https://github.com/libbpf/bpftool/issues/121
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>> ---
>>   tools/bpf/bpftool/map.c | 24 ++++++++++++++++++++----
>>   1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
>> index c9de44a45778..b6580f25361d 100644
>> --- a/tools/bpf/bpftool/map.c
>> +++ b/tools/bpf/bpftool/map.c
>> @@ -1251,6 +1251,8 @@ static int do_create(int argc, char **argv)
>>       LIBBPF_OPTS(bpf_map_create_opts, attr);
>>       enum bpf_map_type map_type = BPF_MAP_TYPE_UNSPEC;
>>       __u32 key_size = 0, value_size = 0, max_entries = 0;
>> +    struct bpf_map_info map_info = {};
>> +    __u32 map_info_len = sizeof(map_info);
>>       const char *map_name = NULL;
>>       const char *pinfile;
>>       int err = -1, fd;
>> @@ -1353,13 +1355,27 @@ static int do_create(int argc, char **argv)
>>       }
>>       err = do_pin_fd(fd, pinfile);
>> -    close(fd);
>> -    if (err)
>> +    if (err) {
>> +        close(fd);
> 
> I think you can remove close(fd) here,
> 
>>           goto exit;
>> +    }
>> -    if (json_output)
>> -        jsonw_null(json_wtr);
>> +    err = bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
>> +    if (err) {
>> +        p_err("Failed to fetch map info: %s\n", strerror(errno));
>> +        close(fd);
> 
> and here
> 
>> +        goto exit;
>> +    }
>> +    close(fd);
> 
> and here,
> 
>> +
>> +    if (json_output) {
>> +        jsonw_start_object(json_wtr);
>> +        jsonw_int_field(json_wtr, "id", map_info.id);
>> +        jsonw_end_object(json_wtr);
>> +    } else {
>> +        printf("Map successfully created with ID: %u\n", map_info.id);
>> +    }
>>   exit:
> 
> and put close(fd) here.

I think we need one more close_fd: label and then put a close(fd); here. 
As there are other gotos to exit earlier in this function when fd is 
uninitialized, which can the error like:

map.c: In function ‘do_create’:
map.c:1375:9: warning: ‘fd’ may be used uninitialized 
[-Wmaybe-uninitialized]
  1375 |         close(fd);
       |         ^~~~~~~~~
map.c:1258:23: note: ‘fd’ was declared here
  1258 |         int err = -1, fd;
       |                       ^~



So, maybe we could do something like this:

         err = do_pin_fd(fd, pinfile);
-       close(fd);
         if (err)
-               goto exit;
+               goto close_fd;

-       if (json_output)
-               jsonw_null(json_wtr);
+       err = bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
+       if (err) {
+               p_err("Failed to fetch map info: %s\n", strerror(errno));
+               goto close_fd;
+       }

+       if (json_output) {
+               jsonw_start_object(json_wtr);
+               jsonw_int_field(json_wtr, "id", map_info.id);
+               jsonw_end_object(json_wtr);
+       } else {
+               printf("Map successfully created with ID: %u\n", 
map_info.id);
+       }
+close_fd:
+       close(fd);
  exit:
         if (attr.inner_map_fd > 0)
                 close(attr.inner_map_fd);

I can prepare a v2 with this change, but wouldn't it be simpler to add a
direct close(fd); on the few error paths instead of introducing an
additional label for close(fd);?

Thoughts/Suggestions ?

Thanks,
Harshit

> 
>>       if (attr.inner_map_fd > 0)
>>           close(attr.inner_map_fd);
> 
> 


