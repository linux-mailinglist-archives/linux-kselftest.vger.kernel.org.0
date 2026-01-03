Return-Path: <linux-kselftest+bounces-48083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED40DCEF8F3
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 01:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31AA83004204
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 00:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5053B1DF985;
	Sat,  3 Jan 2026 00:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fHEfJa/K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011022.outbound.protection.outlook.com [52.101.52.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A742419A2A3;
	Sat,  3 Jan 2026 00:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767400906; cv=fail; b=r/iTFEiZycdlB7P/ytYWqPlg/TpG3FWGUCgjq+f0ynx1q2X0sAUXTBR49LY6H5j9INejpG6P4lWvSjkTGRyNhM2ntxIGbq6safl8fYnflPrg1PKMEAjDkAQmJDaerd8OYVOlqoDXXUXND/XKmL4mLSvpo0lbXa/MgY+5bG1LvXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767400906; c=relaxed/simple;
	bh=phOBOxrXy0EHt8z/Ru35WnT491l9XqJiNzrjA2Y7ys4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uPdh1IXM/DFWk2wpEhUaAkbHRxd0GJeZv4zpWjmdMkVRWXr9K3AEuxz4NvbzQ/J39n4yEVxb5ynCjRyI/TC9LTPksiiu/qvmx4We/E1bqp6SNhenS2M7dcyajd7eXtRNyVXuop2uN1jOnGpAqtOfOw3ys9PFxtcmo32mwjj5ZgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fHEfJa/K; arc=fail smtp.client-ip=52.101.52.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEAFKkB6nb3HktKjuQ16gGNE00gM6XIXqZF9q0JKVwLq7heIXmurUG69usZHJs/+Nt6InTKml142YVKwzZleatEqvRLjCM/r9G/bkgRAxEi5HG7JUw9JeDyUhsZA97NU8GhdoA7hK7dt5ZCJW8cAwGNMIPfzHZHg+Hsn0NSjTsyCgIc7mAffUqywE1JQ7vpjawF1QRACoz0JT2rufs/cwz1LRz0a0c1PL+trY2I4e2STtljHzqbEcHaj4DDhlNqrHgpUw3dQHYkvGLj4Gw5jaUPIIZ6T0PbAHG5SEkJh61RSbdiGJ2wm1fQKI4yGhHbgt92k/wcEQg/RGFicaB4RvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/UR8mgy3ef+X91XCB5H5LU7Loazc1pKqYhe7wQ04vk=;
 b=U1CN5Rcq7p/e/ExkXOyNCXG0MCIc/uQB9sc22hR0EO430bLw/h8BckIaMu/9wRANs3eItWTW7Sh0TUUV5oqrzEVFzkOlPwfPQvEjxFFyCv/j7jkZctA4BwZM3mEJ3RPJKW73qIb1LQ0xLNZEIUCwXd1cKLG617Xu2NjMkif/EBfv8UvH3Zpvy64cV5anc2s9hB0tvu+PMPhd8WsXQznOMEUFkvExbVn1XzctQvEPWDzFxPnEKISXynegmMVxCl0soozFDz3bTG9PHnJ68D0bhC5m3r7ZgujbFaCnhx+FDYc3V/c9gKDDJFyEG0DSk2JqGTmqWmeAy4BT5ST5UV+m0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/UR8mgy3ef+X91XCB5H5LU7Loazc1pKqYhe7wQ04vk=;
 b=fHEfJa/Kyn6/vzzTZUE3g2oF4shtE9u2Mk+qj6bkAGgTjhKYLgrZ3oo2IBTzLLlXc0+V1LAz2c/OEQOSGwzJIVzbILmt06d8nPVVyMaPa+P1LfHuMvKBi+rZ9WnYnkTN6pM3wSOEP/fgGpe0VlHo9g27Qmu2olV53OtpxJ0IJ/fsc2m9UCcgCSuN0BMDBGBOGugEMDPE9wwPFkV62DYgeix8Py/lfd6uosXvWNyn0p4el0name2aS+cSo6/oZwZ8W9J2EYOz+OICP70kQYOHtVYWkPDmZWL6ji2DkrIcWfH5oWL5DmNUBQ6f4MBUVBptd3Uovpph/Ls1oYSmX+cREg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CY5PR12MB6454.namprd12.prod.outlook.com (2603:10b6:930:36::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 00:41:40 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 00:41:40 +0000
Message-ID: <252063db-ec72-42df-b9e0-b8dc0aa6bef9@nvidia.com>
Date: Fri, 2 Jan 2026 19:41:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/8] rcu: Fix rcu_read_unlock() deadloop due to
 softirq
To: paulmck@kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Yao Kai <yaokai34@huawei.com>,
 Tengda Wu <wutengda2@huawei.com>
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
 <20260101163417.1065705-2-joelagnelf@nvidia.com>
 <20260102122807.7025fc87@gandalf.local.home>
 <20260102123009.453dfb90@gandalf.local.home>
 <68b5b122-036b-475a-85bb-e39830f99fbe@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <68b5b122-036b-475a-85bb-e39830f99fbe@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:208:52c::32) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CY5PR12MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 97cbf514-ecef-4209-d366-08de4a60dc2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjhVSkJidm56V3VQOHJwalRDV0xpYkc2eHUrOWljNk9DdTVWWlVHblYvV1hp?=
 =?utf-8?B?NEdBa0l4UnNpbjNGbmFRSmRiWlQrc2M5SmNaYW1lTjljV2NtQzBmcXBNRVh1?=
 =?utf-8?B?Q2JYaXVnb0hqTVhlUjdLVDQxcXJYeDZtbUduWW1xWEtXblZlS2ppMVNldWwy?=
 =?utf-8?B?ZTBhZkhUY3d0N0NIQ2N4cU4vRHljWDBNRXd3V3lLQ25acmdSSU1uUXM1eTBv?=
 =?utf-8?B?NzZrak5EOU9JU2hXQmVzOG52aWhUSmFvcDUwd2pTZHlWRUtYVUxCYmM5YXg0?=
 =?utf-8?B?OUxRNmFVbDI5OHJyTkFUVXlPeC9XSk5FRzBEN3BkcVNSNEIwL3RRK2RmdFZY?=
 =?utf-8?B?QTJQUUtIWTl2STd0S0NMRFRQOUpkTkFyczFqdmtpWjY2WG14RzdvV0dKbnRy?=
 =?utf-8?B?S3VuTkR6WGZzOVEvOXE2U1lrZ3lDdFZUa2t6RnVYcWY2Ukd5TmhlOWFTNWsz?=
 =?utf-8?B?ZGNKQnczMnpMQzRhazBNWXF2Q0VYSW81NTM2QjNDVDlWVTlZbXdHamQ2czcz?=
 =?utf-8?B?TkV5SjY3Zk5qcDJKcVArNXg5R1FPcjBTSzlieGRNeEkyMkFSVzlCQS93ZUFS?=
 =?utf-8?B?TnpnRDNzRDk3d3lxajgxeGRJY0tsZi9pVHM0YXVacEk5MkJ2U0hCdDB5VEMv?=
 =?utf-8?B?WXFNK3hMSjJ2OFZUd1RFODg0UzNiTVhWN3N6NkZqaGYxWUdRSE5lMG9OWmFS?=
 =?utf-8?B?ZmlsZDQ1TFlWNkZKSkpjNXlMZUV3UVI1WU1hZE5UaGtVeDZ1UlJnY1JOdkxH?=
 =?utf-8?B?TzNyRVBMYlArZnpNVGtVUFhXSXJTWlJBUkMrZ3NpcWdRS21vNDB1SjhWUGRH?=
 =?utf-8?B?VnlSeWRrd3lwczdmMzBTSEdtMDJhQTYrMmpuV1VTVzliMkEreVhHeXRDbCt6?=
 =?utf-8?B?cmRmRmRJRHArNVZyUzJBOGlLVFBjV2taZEg3bVpRM2tjZ1ErNmVXTXh2bnFU?=
 =?utf-8?B?dVZpYlVjVDk2bDlYcUlFVzBKVlhFME8xc0kwMVpHYWtYU3BYVEpiZC8wOHFE?=
 =?utf-8?B?bEthYjg3Zyt1ZG5TYWQ0bjZQRldCaWs2VFREMFRLK2RSSlkrMFVoSVZKN3B5?=
 =?utf-8?B?blMzdUowaDFMQm5iQzNKVFlIZkRoMkVTZkFxUis5TEJlazJib0lQTitXRGo0?=
 =?utf-8?B?aXhleUF4OVhQZjF0NDFMdlkxcHdsZ0tFZFN5aktsZXRNR0VHaWVkc2Q2TzYv?=
 =?utf-8?B?N1NsVXIwT1lQdHpXcnpjeDViS2hUMmZOa2JGMGhaSGJRaXU1UWF1YWJHbmJq?=
 =?utf-8?B?VG5pOXBZTS9zcWQ3QUJlOWNveTMxd0IzNW9kUGhnaEJPUEFBYnl4T1lYMzRW?=
 =?utf-8?B?TTM0WHN1NjhuZTQwbmxQa3E1TGpKT2hYbG4xbUpRdXlGQ0FmVFc3TXpheHl4?=
 =?utf-8?B?M3BrSlZIMUlIL2NkcVBrRUUzcVpTTG9HU3VqZGlITEV1dTBqQVdIa2hKNnBr?=
 =?utf-8?B?VmhYU0ZDT1lDZjBmSS8rVGxTem9ZaEZHTjlmK0VQYUhEN1VyNlRJM1djQlFu?=
 =?utf-8?B?MDdtUDQ4azNHWTRXS2JIYmpmdms0U3dDZ1dpTUJwcXlFcytzK3lFZEZSZFl1?=
 =?utf-8?B?a0tpS0NGNWo4dHhKRVZtd25XMnN0c2hoaEJhY2hmNlRmR3hWaUtUL2NlVlZM?=
 =?utf-8?B?eHlOYk5jL1Y3dkkxcTU5cEo2aHFwOVI4MmpkbXBKOVlMa1lKbUlYb1lDRG5C?=
 =?utf-8?B?bldNbUg4WFZ2emdoOTZuVUFyUEJaMkE1ME0yLzkzNTUrZ1hUM3ZHTmJDcEQz?=
 =?utf-8?B?b3ZvMWFoaVFPK2Z4V3c0K1l0a1pYRTdhcVRBTTFUeGpXbzAramMrc0FBbXE2?=
 =?utf-8?B?cnpmKy8zWXNQajc2Y2NsSFVLNklBLzlDNGw1UEF6OTg3QWZQTzVPb1puaUIw?=
 =?utf-8?B?OW1mS2FyUzQwTTFRSElhS1F1ejBNMHRWWkEwNUswRWZNTmhDSFVoaXlUeGtu?=
 =?utf-8?Q?r/B5FRYVAn5fwXq+xCcrcVpu1APOrT4Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTRxR1E1T21xdnNrNE9WMURTZHViSXJKYlI1dG1Sd3QvdEtVMUU1SmFlZ2FP?=
 =?utf-8?B?bEhadkpIanVVeEVHdXlqMDdzZHVJMmF5TXZ4QmQ1bk9Lczc0bWdJUjZud3E5?=
 =?utf-8?B?bVFERGVYbTFNaDVvRmdTdW9EK1ZvMFVWejB4czZBVG5XYzIzRndXVUpYSVdw?=
 =?utf-8?B?T011SS9DOWVxWlUwc09HTzhsellWMWtWek94b1FheHk2VmpBSm16MEN5OEJ5?=
 =?utf-8?B?OGtISDhJWmZvZ3dMUjFxcHNWRGxxTjBERW8rQzlxellZaHQyWHB1QmpYNlVM?=
 =?utf-8?B?ZWtGY09ycytQdUxWclpTeWFVYXRYRittY2haQXhUY0pld1hkMHk1SU0yYVNO?=
 =?utf-8?B?RkVsd1kvdjA3ZjlwQUJyNGtOUE4vbEliVklqeDJGVmdzNkcvR3duTiswU2ZJ?=
 =?utf-8?B?RXd5SUc0VjMrSGRXMzFtWHFkVkpDZHZHQkFNVitFUmdmVGRLa3l3S3c1UElE?=
 =?utf-8?B?MFlKclNtNG1vQ2kvUGN0dmlCOVBIbkVwRWVNZk0vNGFOV2JjY25MT0x3SWxP?=
 =?utf-8?B?bDdwZWpKdWo1VmhFNTl1ZGMrM0I3SUFRZHY0UWd1VDJEMVJuNVNnV21BN2s2?=
 =?utf-8?B?SURrNlBUdER0dVp3eDRyUHRkeklBMDFiaUFOZGJaTnVSMFYwSTVjUzFWYk4w?=
 =?utf-8?B?bHpkeUx2dUsvQ0g4NmVEQ1dWS3N0RlBpWi8xM1F1aGlheUhSUDJJbFJnclU4?=
 =?utf-8?B?ODBnbVFQR0M5ckdLSUpEeGpwSnM5QkNleFNuSDU0QUswYWVpNW8zYlkydzcy?=
 =?utf-8?B?STlaQllDczE3Nm5wcXhhc3p4ZFFtL21MUEV3ZzMzN0tFY1BWaU5peHA5c0NZ?=
 =?utf-8?B?WWptZnd2T1dmb0VSSWttbVAvRjlEbXZDVUhsakxQeThqTkJWejhGZUFTNE5D?=
 =?utf-8?B?YWVrRmRGbEdOejRRZUxEWDBjNG9PL2FUNEV6bVB1c1lrcGNmdVJ6OEhaTi9C?=
 =?utf-8?B?VE5jUFZFVnVVVlVUNmZrbU5zajY2Z0I2bytVUmZCUFFhV3M0S09vSlEwUSty?=
 =?utf-8?B?ZHdiSG9LMFh5WE9MVUMzY051SE0vbUYrSlp6SXVmYWpSODhlSTh6bzFLd0JY?=
 =?utf-8?B?NW1BMzNIS3ZxY1ZaY1EvdU4vdnFSNHV3a0hnd3dXc1ZHVjdmNG1maXdvb3RJ?=
 =?utf-8?B?QW1OajNMakI0NFpOcmIyQ3IwVHRzdEROS3lBazhVU0lldDMvU2E2TXlHRms4?=
 =?utf-8?B?ZDFtOG5lTG01aTdLa2JvMTZzcHZNZHF0MTI1TlZtOEdONFhDNmhGTWlENEx5?=
 =?utf-8?B?NmdPL2RnZGYvSFVIZW51TFMxMy9YVmJGeC9KMjNHSU9JaTJydTRhM1lkQmRw?=
 =?utf-8?B?VkUzT1QrRUJYWHdYWGI5Z3lVQUtkalVabXprOVJaQm4xaXRTbEtCQm8xeE5Q?=
 =?utf-8?B?eU9XeVh6VVYvUmpBM05JOXd4Q2hTT3RleDJSZlRuakdrR0lVWGgzc3RlMFRh?=
 =?utf-8?B?dHphUWw1WEY4aVc0ekFtNnlIZktaRWRENTZRWFU0WkMvcHk3RWtVN1BTaUFk?=
 =?utf-8?B?elVESTZIWDJLK2FsTWZ4d3d1dnpqOHBzd01DMXJXOW01T2o4L1dTd2EwcmZ4?=
 =?utf-8?B?SmQzOVRYTk9HYXdScGx4MGxjdFFNcStSSVlPbk9qWVZvZ2JURnd6V1VMT2VN?=
 =?utf-8?B?OTdkSkR3Uk5pT3diamxaVTFIMnd0SXZSYXU3aHBrRnA4MDROSDV1ZUdNb3F6?=
 =?utf-8?B?d0JzZCs5OVNRdEJibG1aTzd5WkREeGs5bUVxb3hwNWp2azRDYVVDK21qRDdM?=
 =?utf-8?B?OHBWYnhubTBjWWxacjhpZG1nWGdOMm5uRlQ3b1BDSmZ2clhlMStQR00xY0Np?=
 =?utf-8?B?U2s0RnNhejhrRWUwMzQ3UDFtbitldWxFbG5RSlN4dHBKRWoyWlA3azgyMm9x?=
 =?utf-8?B?a1NZeDN2dE5xM1lZREtQNEhoR1BtYlYzVSthaERRRTZTdCtCNkI2QTNYaWNz?=
 =?utf-8?B?Z1ZvVmNiRGdNU0p3L2hxdUorUDFmSG53MGJKQnRhc3BUR3Jyb0Q4WDM3QXM2?=
 =?utf-8?B?clZtUGs2ejhlY2h4NkJJR1FuMkNWV3JiQnVTZTg2bjVhSDA3c1N4RUhpWWY4?=
 =?utf-8?B?U2JCdmNYdllMU3Nodnp5amJ4WGROWVcxTmw0UHFxRnR0RkZNV1RDN2xERVZN?=
 =?utf-8?B?UVpneFpmNzUxWDVtRDFTblArVHBPV1pTODJiVHVSYlduRHBkSW1WS29iOWZv?=
 =?utf-8?B?dmJ3UmlWQ2VpOXB1ZExXUjFtWHBtNlpHTmhpeFNveXVnaEg2V1NyY2pTK2VU?=
 =?utf-8?B?bTVjQzFPZkFVeEtxZmVLdkQ5VStmNWE1cmdzUkxjMERIekNSWmd4dllmUkRZ?=
 =?utf-8?B?Y0lNQ1hiejM4czlYeGpJUmRtRk50ZU5FNU9IbjZ3SmtsR25qZXh4dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cbf514-ecef-4209-d366-08de4a60dc2f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 00:41:40.6007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mtrnZT/eBb85ALWy/MM1ocKlso+HKTqlfinED6cRNIspEwBQZioJr06UMBgoUufVm1kcl7Lo++hB5XI431kkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6454



On 1/2/2026 2:51 PM, Paul E. McKenney wrote:
> On Fri, Jan 02, 2026 at 12:30:09PM -0500, Steven Rostedt wrote:
>> On Fri, 2 Jan 2026 12:28:07 -0500
>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>>> Stacktrace should have recursion protection too.
>>>
>>> Can you try this patch to see if it would have fixed the problem too?
>>
>> As I believe the recursion protection should be in the tracing
>> infrastructure more than in RCU. As RCU is used as an active participant in
>> the kernel whereas tracing is supposed to be only an observer.
>>
>> If tracing is the culprit, it should be the one that is fixed.
> 
> Makes sense to me!  But then it would...  ;-)
> 
Could we fix it in both? (RCU and tracing). The patch just adds 3 more net lines
to RCU code. It'd be good to have a guard rail against softirq recursion in RCU
read unlock path, as much as the existing guard rail we already have with
irq_work? After all, both paths attempt to do deferred work when it is safer to
do so.

Yao, if you could test Steve's patch and reply whether it fixes it too?

thanks,

 - Joel




