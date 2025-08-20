Return-Path: <linux-kselftest+bounces-39371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAA5B2DD13
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 14:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BBF91BC558F
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 12:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F84308F3D;
	Wed, 20 Aug 2025 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="g7yhUuJP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2098.outbound.protection.outlook.com [40.107.116.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79334308F11;
	Wed, 20 Aug 2025 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755694551; cv=fail; b=RzBLk5KsdpmEwi6vx2LQUSy1xi11duE3MAGOJzkO6/vPR1vQWRk7wLDVQhSzTwovQwFlgMcRov+2wxTCtdMO8ly7lzA0nvx9Razlaq1k+oMxjN1zu9QgfFta8VThW3yr+z88GJX0JwTWxRKJcb2HmH4wDC22A+EXDInJQI/yJpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755694551; c=relaxed/simple;
	bh=fvgln9JY6I/3kRgkc2GC23xwYIbnyXLzndG/FGnIdUk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dSdQ0ooEZqWvQ6hcNXt4Y/hGa+OzLtXYoALpxnr8N/MT0bmNd+2kC7/t+Y4dvWjmnzKoiesB7R8c9WERTIV6w05BtCukNxZbZ0qF2QLHwyaIB3YR12rQobfJYDH7xElvuXRbzXvehZhMgRf0WfogPShxg2ePM1ATNyptPjyrj7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=g7yhUuJP; arc=fail smtp.client-ip=40.107.116.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c26HECt9BVQFsIc/jJSHerB2bjqN6NX0JsNwPWp1aomQtpm+rEXUMvAQXTINs9/zfPbgvIg/5ZhGuBa+jHOYvZ7PI3Ok4AYqMUzxc6Fjhf1TJus/DKTJbVfB9CJpGZm4f9AXFoUlizoBvBV3hthqE20NCX4yjHnyvY97oy7Q0sQFyBN6hEH6BD8f/gYg591IgPicZgfNv7zrfdfNLmqRgyoZgAIEZNXWrQadNUIcjA+d3FZ2ZvSKugwH5F3YgnK0rNjH1sS91dMrIk2GDdT2lrwEW4y4nF18jMOULZ4f3p4uEV4Tn1GB0Jm18pnGV0KKi7lPxDpYViBttTUwMMPt2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGBBOQro0+eutlIBlPiLoAC5McPqV4LoI9nFDdv4oVw=;
 b=zV+MAV73A4n9DzLTN1QiPZqejXWfauTUkSexWtZkW7CzW8Pf0U/xMtFQ9qDqfE44ZYLWsQqHFKEM/WVarzNm0QxhgI0eLaKeHQx9nE4HMVQP4a40ccSG3c8o63BMCovLMgVXM9m9g/KYQOHNoJrL3HWB/fb1p2Fo4hCtr9GhcX9rfA5OwmfmwSi3k7Mq5h+MiF6pTqmnVFXa5zeCUAie9wh82x67YcBGCxg/2R81Dh+RnLsmrRPEXJgOQaSy6Ak1C+EhP3XqOL/y+GbED5g7GRMMqtt2g+1mAXrvkDTU8NO9UH7p2nH9WPx3brJ6F/udfARlkWf7L5t78uaBrt5ciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGBBOQro0+eutlIBlPiLoAC5McPqV4LoI9nFDdv4oVw=;
 b=g7yhUuJPMcp2tU3Jp4VEezHFsoUH0wa55QFYa/Hh33CpYFqIx7wFvW13lIcF3SPDq4DLFm1U/Z9en8dXiq1NS2jvpiMYqaD/GolUbiEmg9ynh12nWgHQzZe/dr9+x/dkO6VgIsOebCWWaXAHTizx62P9IAdOiGHNGCbfWJA1x5cSEvDnAHhsJeI9Qe4yP69vvSGj6Etp0iB++VWa9d0vHd6kzfX/duTD+LGY4hE/ZFXytKm3b5sxSQKimbv9w9hYPuS8fOKN+nGwC1cPoZn+Yos1GarDCqvPC1IJ//MIZrxoWJ1nUYBbw0YDMz4QkR/zT1UNnwy34pNMMe/gufDnPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB10491.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 12:55:46 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 12:55:45 +0000
Message-ID: <62f49015-e1af-43ed-8499-507a49032662@efficios.com>
Date: Wed, 20 Aug 2025 08:55:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rseq/selftests: Use weak symbol reference, not
 definition, to link with glibc
To: Sean Christopherson <seanjc@google.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Michael Jeanson <mjeanson@efficios.com>,
 Kienan Stewart <kstewart@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Florian Weimer <fweimer@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20250819222945.3052711-1-seanjc@google.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250819222945.3052711-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::19) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB10491:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a13024-e022-4f8c-3a62-08dddfe8e0e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWxYdWlHNXVHZ2hiQmxoSVNqOWdrY1Z1Sk5CalhZR0wwNVdHL3dKd01hZmlL?=
 =?utf-8?B?QmorQ1lYWFU1RWVTbTJmbE04OTA4KzRUd1Z1V0hNSi9waUk5OURWM1ZkY0xQ?=
 =?utf-8?B?bTRHZkRBUSt1bGcvNGxrai9MaHA4V3NKR2daeURROGRQaXFEdlBaN3I0VDZ1?=
 =?utf-8?B?bGJFKzk3anc2cEJtWC84VkZCbjNYbFJTS2JBRU9uUURyY1NpOU1Ga1lxRE9D?=
 =?utf-8?B?bmFuak9LN3pFN3J3bkd0bmhON2xCV2ZYd0JKUnhIV3VKVU1KNXQrYXFLVkN3?=
 =?utf-8?B?M0lxMmdOYWF4bTg0S05LWnlHSlRwTzFHdzdoTUhJYlByelZacXYyZkVqSjJE?=
 =?utf-8?B?czFBRG1ONFBlVkZ2THhjZHd0bW83VFRvQURTTUxKditSWG91SmRVaHBHUDNY?=
 =?utf-8?B?dzNMQk82MjZOTkdyNEtLVGpDOG5hc0xMSkN3dFZUdTBwdjZ3TUhzS1RqQzFP?=
 =?utf-8?B?STYvUjZ2TlV0Z2g3UUJkeHUxTGtYaWZEaDB3bENrbS9BdkpCNHdCbVFtd0d0?=
 =?utf-8?B?c3hGMnNwWXoxYUpmNC9mMFpBejkrM2YwZkYrZjcxZVlyZHg0a2hhNWdldU13?=
 =?utf-8?B?SzdLWW1GZlNxRURrbHFraGEwYmpYMnNYMHptdGRtREVJNEdKdlJoMHZGMk9z?=
 =?utf-8?B?cU9nMGhEak83YWZDb05kYnlmL2R2azFzWEd3OURYVnlNZDRjWnRrUXpWODF0?=
 =?utf-8?B?b0dlWk1WTlZ2VmtHN1hjbHBEMjVYcmZ6Q2NSczVZMnNpVnJBL2ErTjBoUGVF?=
 =?utf-8?B?OFRUTkNRRXpqMjVMUGFpWXlET2Q4QW81N0dJNWgwOTdualhObmh3TXh6dXM4?=
 =?utf-8?B?MHdhdFRVVUdjNjRpdnJRYmhGdEJHKzFCNU9yMFRvMllKSjR3RkF2MlZFMXpF?=
 =?utf-8?B?a2E0dmRMYkZlSUpuYzdDWG1ZcHhOOXlMMGVXV1ZNTThDQ3daSTN1RVZWZzYr?=
 =?utf-8?B?VFNJVE80Q2ExZlNZRzA5R1JvZDhFcEMxenVqVmJhWGkzOG1xVnI3SERSMXFq?=
 =?utf-8?B?SDBlR0RVeXQyV2p5TGJ3Z3g0cVQ5eTVCN25vTTNuUzhBZzY0KytPRE1lQ0RC?=
 =?utf-8?B?S0hWdG5FYSs5V2EyNDdrL0pGY255Y3hLRjNuWW9IVnR3Y3NCeTM4b3dVbVpt?=
 =?utf-8?B?QzNwdE5vZXQ4dUZxWk5FNk1Ed0MvdUdlR3U3UC80V3IzRTVRRVllWmxsNTJR?=
 =?utf-8?B?bjBUSTFCL2EzWkNIMjVOUWlOM3gzcDI0bzF3bXppZXZ1U0RKNVdtYmNEendM?=
 =?utf-8?B?cjVVbGNGajRVSVFGYXVacklPTndHWURBMkhaM21DM2c5SkFlN1p2bVBhV0xv?=
 =?utf-8?B?MjdFVUNEblpFd1Jyc3lKelNRbUk5RmhNZVpUcEF6eko0NWY3ekp1VFNpRnov?=
 =?utf-8?B?SlhaR2Z4WGVBSkM0NkxnalBUQldJdzFzODI0TU96ZEdCNHluL3VFS3Jqd0RC?=
 =?utf-8?B?dVd0Q3ZScmJUVWhHeC92TWgxVEJJbkRVeUl3SDFVYTduOG8yZUtBdkRLQ3NJ?=
 =?utf-8?B?aDhrc3I5QnFLcjdKb05aYlArQWNSZzlDZmV1ZHFTNTZ5UEtuWGduTWFPU2dX?=
 =?utf-8?B?WTlPMTB0N1V0NEt5NUVuV2xXKytCSFJqYm5UdEV4WFFtSjB5cUVyaU5Bby93?=
 =?utf-8?B?ckdhUE5JVWdqcnNNYjJLRy9DWm1IeHN0dkdPdHJ6RUx4Ulk3T0kwWlZVcEhl?=
 =?utf-8?B?dXB2WXJXeUdUSVJvblhuRzVRbmJqbXBieTh1L0N1N3AxWjBJWnZ1S0diOE0y?=
 =?utf-8?B?bVhGM0gyTjNJUDUzdVBSMXN0WFRMNTQ3WDZWUDJ3N0NwejFyVHdhVkFITnVK?=
 =?utf-8?Q?ZbVQil/150QtZ8AqoQWd+qdqdxVt/TBqSRYkE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2szVUt1cHB2RGk4ZVp3d0FRYnRZNlZRYmNYQmlzNHRuajEzU0JLMWwwRFRT?=
 =?utf-8?B?OU1HcStqSWVXMFYrWkNrdkViU2hsdUgrd3E0TFZlR1A5dnFMQUhOMXhBMnFj?=
 =?utf-8?B?eGpTZlhieEd4cFJsNExJSFdXS3Rxb3d3N0xqa2MwSU0veG4yWE5ESHU3bFAw?=
 =?utf-8?B?bkl0MFJoRFNCTVF3YUphdGRjSU9hTHFoMmNGTnlsQlVVbGVNMDNnRzZodVBp?=
 =?utf-8?B?WEY4Ylc2aDNmZmUrMWlGcUx5V0ZBRmpXR013TGJTMWQ4TXlCV3RGakgwOHJ4?=
 =?utf-8?B?Z2xlck9nSFNHSnlMRUxaOTA1ejZPaGhrQ2MxN0VQdFVLSkhLMlk3dXEzS1pw?=
 =?utf-8?B?NjVWYURGSGFUNG5qWnlpNGo5YzVTVGxBVXlwQm5WeDdGTTdXTDdTaHRETmpr?=
 =?utf-8?B?MkxFVjRjYzBMaFZTc3MyM2E0VE1GQ0RJd3VoWWJHTUhoYmRKNGZnV3NGdDVw?=
 =?utf-8?B?RlR2bGxwTStPdTQ1OFBGbFVPUWtXWWM5V0thY1hlajJxa044dXZBZEFoWFpH?=
 =?utf-8?B?Q1BaSjIzc005cXVIZVhlUTZSMVBRV3puNHQ5anVQYXN2WU8rTVpXMGZNYmUz?=
 =?utf-8?B?YTRuekdYV3lvR0JTUUpGQUozdVkvUzB0SDRmL0dKY3R4cHNnQlVxSm5PWkVJ?=
 =?utf-8?B?VTNBVnBjUGw0aVJxOEVQRVZzdjE0SytQVUorNHdLTWxpZlZXRTBLOEtFc3BT?=
 =?utf-8?B?N2J4RE9ZUXhzS0RtRDZPeitzc2F2eVRmVmV4S2pYNWtxTnpxNTQ2dnZDUlE2?=
 =?utf-8?B?MjBBWkRuMnlhdGtPZ2ZvQmxqNGg1ZHdhcHFoZkt1WEZrK3JOZm1pU2xTcnMw?=
 =?utf-8?B?SWRhVEQyaXYzaEZBbjgrUzZxUU9MZFhMbVVTUDdDM1B3eHFER0gxbWowaHdK?=
 =?utf-8?B?NHR0cGp6bVNqVXYvV3FFcGtreWRML3hscWUrV2puKzdzU0hkSHZCOTVyL2Fn?=
 =?utf-8?B?SzdwbU1jbUhrQ1lDRTFlTmROOEMyUmV1a3NxTEtWZVhHT0ZVTC9GWXByWThn?=
 =?utf-8?B?dzlhQ2Q4a2w3WnRKTm5YVkJWTDB5M3VOVEVVVDdIRlY4TW9Rb2J1dEdhNWdy?=
 =?utf-8?B?TnJGN2lRZXQ5aWRxQzExMkJadFdsNDhoT2lWOFlmbXorYW1KWFllVzRwK2Qy?=
 =?utf-8?B?MnBUQWpGd2l5Zllsc0Z3MDM3TzY3M09DMmNmRVh1UHZ5bkVpZXhnM1B5VHJK?=
 =?utf-8?B?MWJJZTIxSWVWcnZqNDJxeEp6NDNaUkNOQTdDQ3JSN0R4aEVWWFl2N25Bd0Uw?=
 =?utf-8?B?Zjg1Qm1acHBLVk9zZndFYmdXWW84NEF6QnNDODIydEVwcE9YcnhreUJhUUpH?=
 =?utf-8?B?aHZXSWxXdmdmV1Myem5qNndDdDFYYWpqRzBCNmJsUkZJVXRCVGpHM3A0TjJB?=
 =?utf-8?B?STFnS1Y0QURGUVVNNmRXMEM4aDRqaTNjb2dOK3JKTG9BUk5kbmF4b21QQ1Bz?=
 =?utf-8?B?SlpId2FFdUZkUHJ4blA0VFNpM1BNYWlYZEFqK0RpbEpKTWRKKzRqVWxaOEZ4?=
 =?utf-8?B?OHd0VzJTOFhPZCtMN3RyL29YWlAvN3dsbGRyZ1ZTaEdFYm9aUVYrYU9qemZz?=
 =?utf-8?B?blFiY1NFYkVoNFJpQXludlg5ZUlOWlIraktYbThxUlorVnZqeGR1NjVzdEtn?=
 =?utf-8?B?SXRGbCtMSjhJb2c1T0V3dlNmaEZ6S0gwWE5maVZoVkwxNS9UY05uUE5WOGcw?=
 =?utf-8?B?cHlhVTN0bzJrOHFDSGRXNEZqUFVQQ1ZaOHRPNXJJWGhHS0FtMHhiNk1yS1I0?=
 =?utf-8?B?WGRJSE5yQUUwang2VGFjWnhMTml5Y2NPZ1FJaHlIUmpCRUlKTWFpWVpFTE5H?=
 =?utf-8?B?SEphQk9zOU12Y29kdXF3Y3B6c0pMa3cwcjdOcmFXekhiNTFGNE5yb3ZVRjgz?=
 =?utf-8?B?bzVVZnMzZ0l5S3NmOGphL0tQQTBIUUwxUWJMd2hwK1JCeHowc3E2WElSU1Iw?=
 =?utf-8?B?dm9GWWkrU0IydWl5WlpEVzQvTndUUFIwL1IyRnl3VVg3ejgrY3Qzd2VGV08w?=
 =?utf-8?B?cE43NjJFMFBySFhLaGFycW1FYkgzQS9adTQ5TGZ6NXJKUXdLTWgvWEtnYU5F?=
 =?utf-8?B?Q1lkQ2F0Yk1IYzJKMkZIby9KbW1iVTgvV3JuMi91NFQ1ZTBMRHJzQmF4WmQ1?=
 =?utf-8?B?MmFQZlovc2JOR3k4VHJPK3VkVTZjQTVTUDUzL1ovRnZESGdmcXRKbmpNOGwy?=
 =?utf-8?Q?bxjafYEjRcJckQ9Q5HCBCgg=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a13024-e022-4f8c-3a62-08dddfe8e0e7
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:55:45.7312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/7QKEjPzOW18/EB9p0X7kbhB4XppctVG5lhkjtVveUzb3AewkMP0FXU5fbnULbT6WnQt44oFGdw1sHkEuqQaukue9RVM5TW22sB4vDOXo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10491

On 2025-08-19 18:29, Sean Christopherson wrote:
> Add "extern" to the glibc-defined weak rseq symbols to convert the rseq
> selftest's usage from weak symbol definitions to weak symbol _references_.
> Effectively re-defining the glibc symbols wreaks havoc when building with
> -fno-common, e.g. generates segfaults when running multi-threaded programs,
> as dynamically linked applications end up with multiple versions of the
> symbols.
> 
> Building with -fcommon, which until recently has the been the default for
> GCC and clang, papers over the bug by allowing the linker to resolve the
> weak/tentative definition to glibc's "real" definition.
> 
> Note, the symbol itself (or rather its address), not the value of the
> symbol, is set to 0/NULL for unresolved weak symbol references, as the
> symbol doesn't exist and thus can't have a value.  Check for a NULL rseq
> size pointer to handle the scenario where the test is statically linked
> against a libc that doesn't support rseq in any capacity.
> 
> Fixes: 3bcbc20942db ("selftests/rseq: Play nice with binaries statically linked against glibc 2.35+")
> Cc: stable@vger.kernel.org
> Suggested-by: Florian Weimer <fweimer@redhat.com>
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Closes: https://lore.kernel.org/all/87frdoybk4.ffs@tglx
> Signed-off-by: Sean Christopherson <seanjc@google.com>

+ CC: Michael Jeanson <mjeanson@efficios.com>

> ---
>   tools/testing/selftests/rseq/rseq.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
> index 663a9cef1952..dcac5cbe7933 100644
> --- a/tools/testing/selftests/rseq/rseq.c
> +++ b/tools/testing/selftests/rseq/rseq.c
> @@ -40,9 +40,9 @@
>    * Define weak versions to play nice with binaries that are statically linked
>    * against a libc that doesn't support registering its own rseq.

We should therefore update the comment above to e.g.:

/*
  * Define weak symbol references to play nice with binaries that are
  * statically linked against a libc that doesn't support registering its
  * own rseq.
  */

For the rest:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Michael, can you try it out ?

Kienan, we may want to add a configuration forcing "-fno-common" to our
CI, this problematic pattern may be hiding other issues elsewhere. I'm
thinking of LTTng-UST tracepoint headers and libside headers.

Sean, do you want to contribute the fix to librseq as well ?

Thanks everyone for looking into this. I'll be back from vacation next
week and will resume normal operations. :-)

Mathieu

>    */
> -__weak ptrdiff_t __rseq_offset;
> -__weak unsigned int __rseq_size;
> -__weak unsigned int __rseq_flags;
> +extern __weak ptrdiff_t __rseq_offset;
> +extern __weak unsigned int __rseq_size;
> +extern __weak unsigned int __rseq_flags;
>   
>   static const ptrdiff_t *libc_rseq_offset_p = &__rseq_offset;
>   static const unsigned int *libc_rseq_size_p = &__rseq_size;
> @@ -209,7 +209,7 @@ void rseq_init(void)
>   	 * libc not having registered a restartable sequence.  Try to find the
>   	 * symbols if that's the case.
>   	 */
> -	if (!*libc_rseq_size_p) {
> +	if (!libc_rseq_size_p || !*libc_rseq_size_p) {
>   		libc_rseq_offset_p = dlsym(RTLD_NEXT, "__rseq_offset");
>   		libc_rseq_size_p = dlsym(RTLD_NEXT, "__rseq_size");
>   		libc_rseq_flags_p = dlsym(RTLD_NEXT, "__rseq_flags");
> 
> base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

