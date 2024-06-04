Return-Path: <linux-kselftest+bounces-11168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F194C8FA96F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 06:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59A3FB24759
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 04:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E2F136986;
	Tue,  4 Jun 2024 04:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QBnBLb+s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDCF28F1;
	Tue,  4 Jun 2024 04:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717476946; cv=fail; b=kGTV4zbfQlKp7yeX/NWKsJEQBjYcx1R0HNVyxqB7vN4YSUAzmXNsLXqIJDn8y5EDwBrv0ROTIxRBU77cWMvfaS7GFZ2IaxKU3QKD+h83pbdt1WH7Nc/9Ald6/xG7dBkGbW1VBVDamonEHSxWSNi9hUw2O3q8kqPZevoyBWKMlYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717476946; c=relaxed/simple;
	bh=8UNL5eDvy1/vPSRD46W0Zkz3+NSndA2roWjMMt/iNAU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tAz1edJIXHT4IyVUMF5I0oC0+JoC0yP4pmihLbsvv6RgWd4ywJlQvm02v2FsGkjc5xmmBFVaWCzd8LXSv/aGSPQ3pWY8UJaVnl8TLiElXYHLZnA2yAY8iO845shUTtpDfr90NQrqNRbRjc4BMKzmlA+ZDkfePa4vgKj/eNlOzNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QBnBLb+s; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJLLE6cpXq4zHiwiLxXqsU9SZtBIhjd3zRX1roLWvvHd30BMsm4M7ZjEXNbY2eWKNeMyFeN7Ezrm7vcSGZvkxOedAKwdMjrm8hOW/S/gcN5r8WANQSKNS8Ktz+YRzi7jFtUKabAz/vRsGU8Ennud2DEKYFG+QYscoshkBRQ5nZez5IvePpMI3KUHkqY97p81RAfmbaxbkcMjCGp3F3oMtYGcMCmlkmZD0qK7DTvVs4NYlSMidNITo0qXDsHQysPBwI8NFsycVfN3Ra6IUvKWmfTcxoO+JU/ePujGvJV8CuSFbs8HHf2XIDzrnUB9hhghhvtbK4hyHd/pO1sl3OXa7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nlul5NgllCUA70KECwRAGProH33eG4hyjy+ZhcwJUHs=;
 b=DM+oh5eEpjzQ3bLXL+tHnCFJzNKWhVRdA9iU+4lz14cpFnH+3lWltyAicixc5TENaqSDoS0Lt8lkEezXpSyIA65IGnz1vyzrIeyojaxSYLSuW+yNxU/VqjjDqKuTdQZGbPQczbLkMVs4tuIU6x59g5gaPWO+hKlo6OpKDErIY9zlhRpyyL72DLwoVk6vPBDYr7eNuHXTDvzXLsyDE5OcoOZ1O1Few7M++06G0NS2QrHXTy/aWVp2ns2XsRTD3LUCuNnpSB2z83nSm91Mzs7ggo8s6eey3sxomWr48SSuoeV7J49R3NYbqIZ+YLTbIAVREWI3uUPdRfxd6CexcgplOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nlul5NgllCUA70KECwRAGProH33eG4hyjy+ZhcwJUHs=;
 b=QBnBLb+sNL7tHJ1tDOMWG7P8gquRUTdczd3ZDPzV0iRToM1mRak/ibFSRvV0j9Dy73bfXGTnMn5HMzGjuAUnoKU1TtbLNDN7uo7TYdUUpEarfzzncSet9juDqF3PodLaVqYXcnDzrXhR3aUYi8eKevhdCb3eBDeR51feZ0oDDvCrmlcaoF11BrG+Swy9YW+NzDHMBAkgMY8JOIImKfwouzD3xk+0RxJRRHGUkTjDmQkzAFfonAFoxWA0v9Wmvmyyzn3ydEvAbk5IIEby9KbSY4lknbnQKRcdPPBRbuUGhVVqEUphLGFbePpuUnyl4iYsd0EEtMkaDlvl9gPlPyXreQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SN7PR12MB7348.namprd12.prod.outlook.com (2603:10b6:806:29b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 4 Jun
 2024 04:55:41 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 04:55:41 +0000
Message-ID: <2c57be33-77b8-419b-a708-e99aa9b44395@nvidia.com>
Date: Mon, 3 Jun 2024 21:55:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] selftests/lib.mk: handle both LLVM=1 and CC=clang
 builds
To: Nathan Chancellor <nathan@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Justin Stitt <justinstitt@google.com>, Bill Wendling <morbo@google.com>,
 sunliming <sunliming@kylinos.cn>, Masami Hiramatsu <mhiramat@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20240531183751.100541-1-jhubbard@nvidia.com>
 <20240531183751.100541-2-jhubbard@nvidia.com>
 <306eebf8-bb5d-4e1a-9fa3-ad3f4ea11b9c@sirena.org.uk>
 <20240603224706.GA245774@thelio-3990X>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240603224706.GA245774@thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::12) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SN7PR12MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: eb6988f6-3532-4822-210e-08dc845295a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wmwva28zQTVSUC9UcVVXL3FObS93aG5SekxnU2Y2TXNMUjRjTDEwNXNLSGts?=
 =?utf-8?B?WDRicUZadmF0MURlU3k3anhOVGZBWDZWcDhyY1JLYWZPaEtWdWNZWndRdVB3?=
 =?utf-8?B?bU5LNWRFMDhtc2JxQXFHYklZYllYNmxpOFErOEpwYW1VOHBPU3pZQTZoSHBh?=
 =?utf-8?B?b2lOc0JjR2ZMMm1veG51dk1jbVJ0dTZOQlgrazN6Tjl3RFI5TlQ0b0h2dCtr?=
 =?utf-8?B?ZFp3MC91cVBjUkZHT3RKUzdtdm5ZOW5IcllYcXhsUmVPT1pTcEg4T1F2NjNu?=
 =?utf-8?B?eEhxWjJuSzhMUXk1Tit0NFRQOXlIOEV6MEk3R0lpMGdHR01LMEhhL29zZHVl?=
 =?utf-8?B?U3phLzRlZUo0dHFtYWI0V3cwSlBKSWJvNnExMFd4RE9JWlNOalJJUm4vRXQ3?=
 =?utf-8?B?RCtGRndKRWRyS0hDcXhMOEx5UzhDMjd5Q2ZFTGQrdzJnenVnbkxURXBkSEkx?=
 =?utf-8?B?L05pc1I0ZWo0dGJyVmtETkZjVzJldVJhVVBMQlFOR3dDTjEzdEZJRG5JNUky?=
 =?utf-8?B?YVI0U0ZPNHRRWXdvSUswa1lZcWdhTXFGQ2xxMFA5SFd1WXAzbFd1UnRPd0Iz?=
 =?utf-8?B?ZnpLeG40MWlnU0I4Q083VEcxQXhBV2IrY2JpaEhPejl5eWRCcnNTOEswd3dy?=
 =?utf-8?B?clBpWjdFZDM4UGhodnZkUXJab0ViZkN5ZmoySTI3bkk3c2hUR29DUW8xc1hx?=
 =?utf-8?B?Zk5aSnRNTTRTM1VCUS9wYnhNN3NSRElHOElRK1BPd05wbjQ5MmdwT3ozaWYz?=
 =?utf-8?B?dGFEbFQ2OGw2OXl3SW5EaDhGNCt5SWFjeFI3V0oxVURLUG13TlRybEt4UHp1?=
 =?utf-8?B?TXhLeWN5UVEvVVNFVU1XZ29PTXBNa1BjdkphRGVCV0FqZkZsbThyU29OVUFz?=
 =?utf-8?B?VnRqZENMaDRxZDNzN2ZEcXZFNWxReTdjd0VuSGFybGNrM3VVT3E1cmhOTW9Q?=
 =?utf-8?B?Q1hTaTVsK1IwYmNxUnBwTUljWDFLeWUzVzQzVkhrTXJIbUVOUCs2azNZT21T?=
 =?utf-8?B?VmVvaU9OdTlXYm52Y3V3dkVVZXd5VUVrMzRlV21aN01JNkV3SmJxemlmbVB5?=
 =?utf-8?B?Z1hGdXRFaEl1dFdJamVpS3dsdjA1YWxRYVl2TGV3S01DdDN5Qyt0cjFuM1lZ?=
 =?utf-8?B?SkIrRUdlVVdQWi90bE1PZzVVZnVlbnpaWEJUVU5kWGlEeFZOZldpcDhmQ2wx?=
 =?utf-8?B?clZKOHM4dkJOaFBjeGtrcGVaUERaaXRzN09pWWZtYnlZcU9hWkJjYk5kVUhM?=
 =?utf-8?B?S0d2Mm1pTmc0UXF3NDBqV1RvdjBFQ09hWUhkcG1VYVowcGVBNDlpUmUxUWF1?=
 =?utf-8?B?a2xvcWp4UUtTdGlnM1owRjRiQXJTb3kvOE1seTVMaktlZ0I0Z243aWdTdEtX?=
 =?utf-8?B?VlRkcmlDM1BNdVlJZkVoaFkyV3QvRVJPajREK3ZjU0VzNXBNRHVoYVAxZlNl?=
 =?utf-8?B?cHBSWERsdS91RnNjK21QMFpQd2JnbEVLL2doOU0xY1dZQktNSkY4bmt4T1lu?=
 =?utf-8?B?dEhhWndGaGFpRWNWMk04cUYzTEM5cVdPcG50Ukh5QWFPMHdhaEpNR2hhY0Vk?=
 =?utf-8?B?OXNCRU5QdzFKT2hrdnRyRmFhaWNXWGZMc25acjd3TDJteGphTHBKZU5uazAw?=
 =?utf-8?B?UFNBajI3QkVyemlUTlN4OVdiNWdCc2RWNWVhbVdoL2pZSFFVejRIekNKVzZR?=
 =?utf-8?B?VmdDaFVPWEdQeUFKc0F3SzZyV2F6emlJaXdnUVRMTG12QVhBWkN0UlpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnY2WWdxTzA0VkwrVHFHVmZoeTdNeS9WTDlVbkFNakhDd0NrMmRyeGhVSXhM?=
 =?utf-8?B?ejZPYk83NXR5dXk5MnJHTVRYcWxQd05EelRzNjRncEdTV0ZWd1ZhbVVtamZF?=
 =?utf-8?B?U1ZvdjhReGRaazJySFd5aEJzaWRKZjQ2WWFxbG5DQ0tJVE5TOU94Q1F1S0l6?=
 =?utf-8?B?OUc5a3BucXdlem9GWlczQ0c5V1NMWTlzK0lPRHVEcVByTVNreUtyMG5Cbm5P?=
 =?utf-8?B?WHpBOUpFQWl0amxEYm01N20xM3h0YUpBTHc0VzQ2NzhOVXczdU52WHJJUjln?=
 =?utf-8?B?Njg5YzhiZm5DckFHeWEwNU96M2hzMFZDalRrbSsxdndkR1R4SWV5R29zVWE5?=
 =?utf-8?B?cGN4YWNBSXR1RHNrQ3JWYjJ3NFZEMDlMYWIzcllWR3diOTZrMUR0L29MOWxH?=
 =?utf-8?B?c2dGWVErTUVSWUk4WjVSWXM3Ty9HTFd6cjJUTG5nWGNWL2Z1UWVwR2tKSVRs?=
 =?utf-8?B?NHNvWEFrWHNURG9mTE1KRHdiRXZDL01mTEh0bXl0OHZPY1NWYnNPQXF0MjAx?=
 =?utf-8?B?US8zaXFNZW9rSDhCOHpMalUrWjVSbFNGc05QcjZSeTFZRktSaHk0NjRqOEsr?=
 =?utf-8?B?WmdLTVN3ODZtclVDbDRRS2gwRnRrZEVZZnFpUWtwbGg4RUNnWmhjSDlSM0ZW?=
 =?utf-8?B?UklSRTM0eGl5cGRSU1VrWTI0MUpTWnloajdVZ1JhemdyQXdjK05yMWZBdzBx?=
 =?utf-8?B?ZEt0VU9jN0JYc1VHb0orYXk3RUhIL29RYnJXcyt1bmhOdFFlWk5NQ3FzY3pl?=
 =?utf-8?B?NHBJYTRkb1dZTUFZdVVESCs3cWwvaVp1N0lnWTg3eUkwZGxvWk9hbGlvMWZK?=
 =?utf-8?B?YkNoZ29JM2pHRVVlSDdHVGhxckVuQ0orY2FqeHJxZ2hRbElBYWFOaFJQZWFY?=
 =?utf-8?B?RldIcWNQWFFxMGdtZjdad0pqODZWVldYZ3VzRDJWVE95ZC9uV3RSK0xWSGdX?=
 =?utf-8?B?R1g3cm5xR0ZpVTd5Q2pGOXRqaXowSEtNUU9yUHhWcHcvU0Z2c3E0RFVMN0Nu?=
 =?utf-8?B?QURSVGQzM3FLTFIzUlk2UzJMS3dBOENGUDBMTU1udXY4T2V3emlXVzVyUUY1?=
 =?utf-8?B?NjY4OEhPS3dHdVlVS2NtSXRPYjZxSUh5dUtUWS9WMy9tWVBZNFBJWGd4Q0tB?=
 =?utf-8?B?QjgvbkJOTS9sVy9YQUhCNTFQa0dIVGFtUy9Oekt2ellGWXp6YkE2T29uSHB3?=
 =?utf-8?B?eS9jWUl3dEFBdU8zRlNmbnEydTJKVUJUZDVkb2FtRDk4WkJnb0ZIVU9qbFl2?=
 =?utf-8?B?QlhNc1hUekF0QUJZaGkxUjRuZ2F6bXZ1UmVUUmhIMHFLSHVpZm9sZ0xLY3VE?=
 =?utf-8?B?MzlaSlJlQ0lYM2Z2L1NwZm41NVpjcFB1MThjY1g5UWNrd3VEcmo3UnRUV0U1?=
 =?utf-8?B?a3FadnF2VnZlYXJiekFhRTh4dTJyNmVxblJPTXpwQWV0V1Q5QjZQZ0IzTGRm?=
 =?utf-8?B?UDU2OERYNk1HVDNQd25LUlcrUDBzUU4xWXJMOVBUaVNGanFjeDcxVVd3WFZQ?=
 =?utf-8?B?TWE3YkpPRU5YeERmL1JwODRpZzZvMW9QVXhrcGkzdXJLZGk2R3BSKzkvVXRk?=
 =?utf-8?B?SFkzY2V4SHk0azc2eG1aRVNibjQyTVNONG5tYXo2Tmt3dHNFL0hOYkFxMTBR?=
 =?utf-8?B?K2tPTktMeDRnMDAvK2NwQk9pVzRXSHFEVjNOdXBlS2FLcDgrWDRlNER3K1JI?=
 =?utf-8?B?MC91ZFlEUGordmpROURqL0JDU3o2SWw2aTU0UkFnUkcvY01vMUNtaVVUMklV?=
 =?utf-8?B?RFF4KzlSMmJrV1IwVWdRSjZ6YlBwYklvRWU2SUNxdHlFd2RpczdxeUlhODJw?=
 =?utf-8?B?S2pCM0VQd0ZLUWNhNHZJZlZSdEZpWTZZRzQ2UTJPZ0VEd0hhQWY4VHM4TVNC?=
 =?utf-8?B?cEVMSzh6UVBPcHlIUTJ4ZTJTd04rRmwwVGh3YmRlSjlLKzBvdVFpUnE2L0Fv?=
 =?utf-8?B?a20yK1FFUkR5SGh2a2wvaXFoSVNJemFTNWF3S2NrZjE2NVMvOGNKSCt5bC9C?=
 =?utf-8?B?bkU0WTQrQ3NldjdDTDNxUnVEdkpNbzhZSGdqRU5jNEpPdHpTbitPa3V4N1oy?=
 =?utf-8?B?bjdzRXJXbDQ5UjN1cHVDR1dFV0M0VkoxWFFBK2RKUXNhTzNnNkp3UmxhZlVT?=
 =?utf-8?B?R1o3R3EyekUwdURVSDV2WFZHVjFIVkE2Zjk2UVhEMTBLdzlZUktpazNqZHZ6?=
 =?utf-8?Q?/0PKvHlXZ+VlI4MJ95Y9XA0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6988f6-3532-4822-210e-08dc845295a9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 04:55:41.3898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MYTNeA9LxxJBgN6nCntmF9vUpJbrfdlMP+LmVJBSZeVOR09pwNIVlgFkeL1fcBesRHfBqECbdnu3cikBWGcxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7348

On 6/3/24 3:47 PM, Nathan Chancellor wrote:
> On Mon, Jun 03, 2024 at 04:32:30PM +0100, Mark Brown wrote:
>> On Fri, May 31, 2024 at 11:37:50AM -0700, John Hubbard wrote:
>>> The kselftests may be built in a couple different ways:
>>>      make LLVM=1
>>>      make CC=clang
>>>
>>> In order to handle both cases, set LLVM=1 if CC=clang. That way,the rest
>>> of lib.mk, and any Makefiles that include lib.mk, can base decisions
>>> solely on whether or not LLVM is set.
>>
>> ICBW but I believe there are still some architectures with clang but not
>> lld support where there's a use case for using CC=clang.
> 
> Does CC=clang even work for the selftests? lib.mk here uses 'CC :=' so
> won't CC=clang get overridden to CC=$(CROSS_COMPILE)gcc?
> 

I received a report that someone (I forget who or what) was definitely
attempting to just set CC=clang. But yes, it definitely doesn't work
properly for CROSS_COMPILE.

And the more we talk it through, the less I like this direction that
I went off on. Let's just drop this patch and instead consider moving
kselftest builds closer to kbuild, instead of making it more different.


thanks,
-- 
John Hubbard
NVIDIA


