Return-Path: <linux-kselftest+bounces-10943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6B78D5251
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 21:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1971F2462F
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 19:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31D214BFBC;
	Thu, 30 May 2024 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q/HB+IH1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB8314B97A;
	Thu, 30 May 2024 19:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717097325; cv=fail; b=kh+viW3eVGj3IIdZ7kLTYfTuqCN3qexKnoKDVjDrDecDv3KgGS3uxJXxvMPp6eKNeSJbrpPEK7+Z6EJwsSvHQ7O+F/xz8hReo1RreBvVHZPbmQf3DYqF6VMsXXi16XNBtBW6KlmYeExIF7Kz3BjnXQkILJaEFr3oUmsatacCHPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717097325; c=relaxed/simple;
	bh=qu0HkuFw+5FuXbGanszQhE7EQ1xrCo2lFs06kBMoUWw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=irv/8i6vL98AnASounV7JctZn7Xr6KUNozTcY1/Hd8GAbba+d7LwponJjzhWeQ5nUfkyw6Sdk4rHnXFcGCA9myZiPF2cVDXjv/HPVZ8xuv4CCB7+DS9wGcrL7pMB6ale1ruAvJus8RVr3qPob5xYt6asFlelKfE72GJ7toCM9rU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q/HB+IH1; arc=fail smtp.client-ip=40.107.100.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfK+dbujKU05BVWELuFfwYe4TMbXOP4X9qq3Pw+idd1xWxIVM/sLiOvb92LK/+QNEZWmHzwMombfGuUTW/TmU7tdUNs6TQuXNujWz98JXb86ZezhYxOwS8DRwrXHPY8GRZWmRC1LEvtNBOTFEEuM79hs+yIcIGt/RabgBAfYQOI0usHWnVrItpWxxQNYYbfRwdpJuuzWlw2NIDYe7B/iUO/BehhAs4fTpE2+apdzKNhcx/nxGHtqT/j53tfWF+piG0bG6mcBEiAadW45b+zI4+SMCKzS8rqMYy3JZubGE1pzD+WhQxj0k5ssfd8rwyRagHJ5bOTsCZnenmuBrM9OpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9vmDKBiSw/JrMqwuPn0Z0nPi23MsJYITvaHF4jcEw8=;
 b=jGSdjYA62QS2nYMyokShhDJ06fWIFNg/HZUh7Mtpb3cDurSlFOrKFYxVBO+2ZYrCTd9ivIo1n6BCoFdEG9sx1iF8Yq//AOTYan5R6lOoxI4DUZLbghA1ba7rPKTNl76SNcL188Bsrt7prSn0YKvXg765KofhUWEpg7Da7v3ouRgRv4cdsoVRbOmlZ0I34NP48ENU+MWRrSYeXVk63/uz+lui3bhLh/mY89ULAUM9BZPDpH8AEqQx1vL0esAGrvye0Xb7jSqoe0ytUpjL/7tbGMwHSadvUr8fS5UTrkADvKIJdhyoaI3udxHIU83OV3IjlXAfvNRn9+hE/7aENiYjQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9vmDKBiSw/JrMqwuPn0Z0nPi23MsJYITvaHF4jcEw8=;
 b=Q/HB+IH1mI2C4zMa1cokCj+/YwAHlKfBdR22Jn6R9IqP7SkOKScOsjF2udpBLp4Er5qgw5NkSox69ngyBwm6o8JTsl7UtYS5o1JBPnpUB+VbqSoi4iIo8An/77KDt8EK8tp+M8YujzCl15+5ltSypPNI/jUXpSUE3W2P4EUS8Uu8tyKrF/2pMfB2SY/h60qJs4Q/3BLdFeg2KPJEqGP/5kbhFzdfUrsBMMq8Cy9dqwXvrCEcxZLbr8vxgu7bVD3JwfoCuevt620zDboWYKigvZeQDYCmT03KmC3G/8F5fFWKFHoja7gf3kFhwQIClL20SKHBMAf9Dy8mkACTUmzgFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH8PR12MB7025.namprd12.prod.outlook.com (2603:10b6:510:1bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 30 May
 2024 19:28:39 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 19:28:39 +0000
Message-ID: <e0f3563b-5cd7-4f3c-ae7c-4478c25d527c@nvidia.com>
Date: Thu, 30 May 2024 12:28:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/lib.mk: silence some clang warnings that
 gcc already ignores
To: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Justin Stitt <justinstitt@google.com>, Bill Wendling <morbo@google.com>,
 sunliming <sunliming@kylinos.cn>, Masami Hiramatsu <mhiramat@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>
References: <20240529020842.127275-1-jhubbard@nvidia.com>
 <20240529020842.127275-3-jhubbard@nvidia.com>
 <88c64f5e-4586-4b38-b3c8-0c3af93a71ae@linuxfoundation.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <88c64f5e-4586-4b38-b3c8-0c3af93a71ae@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0045.namprd11.prod.outlook.com
 (2603:10b6:a03:80::22) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH8PR12MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: 7303b896-3dc6-49f2-5642-08dc80deb59a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkdSdW1Pc3crSWVPWDdVMlI5Sy9ZWnd6czg1UWF5bXRTaUhlQjdlalg5UmdF?=
 =?utf-8?B?ek40aHBodlQrZlAvbzg4MWVyZ3VIMzFxS1BKMWNCZDdjVGJoN2hHMTMvVm9U?=
 =?utf-8?B?cmY2aEFJaHkvVVNXM2lsTmlEaEFCcVF4NUhRdklzTG1Teml3T091MVNXSTNO?=
 =?utf-8?B?eEdFQTgxdDJWWmcwSXg3UjR5OFk4LzBGTHc2cFRGM2dzMHliVWxQVFNxeWdV?=
 =?utf-8?B?eE15UUJwcWxYM3pmS1hUbWlCTzB4ZmxpUjAxS01BWE1kRWpCY0FaNnEydVhu?=
 =?utf-8?B?c3V1TVV5K2t1MFFUKzF3ZERiVkFmYzBWQ1JYcW1uRWF0UVdIL1ArVVN2QjI2?=
 =?utf-8?B?N1pnVWtlcTg3TFdUSU5ISGN6TWVaRGpqVEFQb0dSNm5idkxpUW9oNEMvNWhx?=
 =?utf-8?B?NllRSzhvWEZ5UlhyT05PT3JWTmlZalpOSWwzUXJJL1hMVUpFcm1hNVFZV2pY?=
 =?utf-8?B?ZEpvcW9naTB4aVFUOFYzZkswR3VsYkJZUmJnVm1TS3JrVFRsditiUEhuNnZl?=
 =?utf-8?B?dEg0ZDZHbUlDZDBxS2o5YjlqV285Q1Rwc1Y5R2hZTkZydzRpdHdsTDUydnBx?=
 =?utf-8?B?alhORFdYNzlZNG5LbmxocVJEd2RHeXBLUitCYk56TWlvRm95aG0xbXMrOVlU?=
 =?utf-8?B?ME1oaXE0UVJHeE1NV1hyUzNYS2dVMnRsaUFDVmUvRDUxQVNaNnBXbWlHRXpI?=
 =?utf-8?B?eDhweHVWV2hUTE5CWlJwN1NSQlkzM0V1d0EzY1FQRUZncDg5bHFlQXViNXhx?=
 =?utf-8?B?UldsY1M0TFY3WTRPU2V6VFhqeW5aN01lRENKaGwwOEx3TTRvRkpaVC9QU1VC?=
 =?utf-8?B?NDFFQU5ycmtFcXJiSjZFdHlCMDJ1RWVxeVM0SG9JWFJneUlEU1BlMjRVM3JY?=
 =?utf-8?B?a1NXRVZyMDMweW1MblNkR282MEVQaC9ZSnluNE1icHFVV3dFY1p5bnlWWm1i?=
 =?utf-8?B?L0MyRDZUVG91ZHhNaXgvUENtVlRZMlZza3R5ZW9ncmZvWW93RkEyYlBXbnBH?=
 =?utf-8?B?TURYblZ6S1d4d09tZU5mR3EwdzVPSzhhQTMvQkY2UUs4c3c3Qk1xdzVncmpl?=
 =?utf-8?B?dTU1RmQvcEdSSjk2UWVSaDNWY1pGTnJnY3o4Slo2blpDQlhnbW1DV2VQeHkw?=
 =?utf-8?B?cE96bXZtSWk2TGNIRVlNaGJhWWx5UmFNZlFVNU5LV3NoTk5BWExoVDQwSlNX?=
 =?utf-8?B?c0Z1cW9sRVovOEdITnBpWVFUYlczYWdNZHNxOG5TT2NrMlZKbnF5ZFlZTnJ6?=
 =?utf-8?B?a29VbkFZMHlkTm1BQ2VleW1sTTBtSzdpUGErM2RQV0dNL3dLMGdmZjNYK3ds?=
 =?utf-8?B?M1N5ZzJiMVZHR1YzQVhSTHNjOXJBZDZ0YjlHTUNxOTkvcTZOM3pSb2N4Sktm?=
 =?utf-8?B?ejdLV0VoczlHdEVwVTg1emEvTGdsQ01yMm5NZ0IyY01zYXhEWG1LaDJudHNJ?=
 =?utf-8?B?TjB1K3ZQa1ZaaFJnTmg5OGVwVWhoRmV6T0dHYVJ1SGxLTEZnaVUyQzExTTlV?=
 =?utf-8?B?RmJlYWVvWFJ5citCWE14WHJ3N3I0L0ZPUktwbEZFakVnYTdKbCtZanFmQmQ3?=
 =?utf-8?B?MGNEaGRhZ3dFY1hDT1NsUHRxaENyYXRocGhkVG80UWNoa3IyRkI4eW9IOUhS?=
 =?utf-8?B?RUFyRGw1SWdSRlhNbTMwRi82S09DOWF0ZFdjNVp1eEdkckhtako5R2kwR0lq?=
 =?utf-8?B?WGowTlYrM1FUQThmZHREa0tWUEZPU2xiK0RTT0ZySFhOWlVmMlIzaktnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTBVUW1UV0xkM0hxQUIvcnY4SFBpb2lBNWdPM3JRRkxCa3lKSkJWSE10d0gr?=
 =?utf-8?B?RFluZldEaTRnTisydFY2YkZ1QWFCckswNkdaVmJ6bENIczdRa25PdytqTkpC?=
 =?utf-8?B?d2hOM2JDbmgzVUxjYnF0TSs1Ui9RMU5kSkRuc1hCU1dmTmVpSDE3UWh2QVIz?=
 =?utf-8?B?eVVqbVRIam15S212WXg4Vmp0WkVwbGU3Z25GYkpCZUJrTHZtQkQrOWh0YkM4?=
 =?utf-8?B?K2NjWUlubXNGMFUwdWs2dUMvclhGcU1JamJLNEd0aTF2dUJJSHU3Q1R1MUJ2?=
 =?utf-8?B?S1JGUVI5Q0RpUVVKL3YzVkYwTGNrM0laMFNlbEJxeU95T05hUkdISzFub0JC?=
 =?utf-8?B?WkMxdzRVd3FoQ2puZmVIZm5oVzlYN29uYzloMmZnamhNYWNRRjlkSEtKYU1H?=
 =?utf-8?B?aUtNZDRQcndLeEtvbUJyVFkvSFl0YVBaZ25yMEhiMUJoRGZydnVOdWEvMTlz?=
 =?utf-8?B?L1cwTGFSYVBKa0JDeVhuTUl5RFYreTA2aTJlc0NEUmJ0eHc2aGlYOEtsUnFN?=
 =?utf-8?B?aC9JaEFRZ2s5MWREZ3JmUlJCMkptdEF0bVJKSHEzZFFwRHhXcTdHOHlubGRh?=
 =?utf-8?B?dGxzOEZJNUYzNDlVQ3dtMGU4VC9GQzJhZVVhd1VsUjVSK3VEMGlUUUo1TVdK?=
 =?utf-8?B?LzVYd0V6SmNlMWRKdG9GOHpQK2FybXIrK2Z1Z3BDaFRWdlgzS1BScWdpYUh1?=
 =?utf-8?B?N3orZU5SRkNPaTVQZEdndVJTZHE2NUtwNkNYb3MzYjhwdFhxNi8ycFUvaWRm?=
 =?utf-8?B?bUF0WDgwTVZ3UmpGT1R2bnhidlo2Y3JqNkR5ME5BWmIyL0NndEd0N28ya1Rj?=
 =?utf-8?B?NDl5Rm5OVnhZV012Tm5PV3pXZ2h2bFVQb1F6Z1g0Tk55c3AzMWNMNUROWGhm?=
 =?utf-8?B?MHo5NHFNWWc3NnZwekFacmJqTGhNN3RDRmZsYW1MZCsvVXhDVGd0YUk4bk5w?=
 =?utf-8?B?eU1PcTRrbVZnSm5CVDhnMUFJblJJcXpvYmJ1ckhDSjlLZmkzWU1kbmc4VG9F?=
 =?utf-8?B?VzVISlRXanVlUzhDaktySTFMWUJ3ZWxtRURaYkxQeGh6OFlIRnVCT2N5ZWhF?=
 =?utf-8?B?blRaenJLa1h4S0dtTGlYVngrNFUxOUFzcXBVZkVKVWxsa3VtZ2tVN1JsTWt2?=
 =?utf-8?B?TGRTSmk2TUc0QndJYk01T3V4QUtGbHM2VHIweG92YVp0R2ZKeVJhVFFsY3E2?=
 =?utf-8?B?bGhqQ2hFNjFSZlR4a21pVG4yZVNLekUzWi9rRm9mR1VITm1jdUJQNFJSc1Vt?=
 =?utf-8?B?ZUxLR0Y3Y043c0VBVGliR3lUeFowU09sZG44RDBCTzhQeUI3Qk52Wk9Rczhu?=
 =?utf-8?B?UEpiMTJOWFAyMHpUeEl5WTlIdVMrb3d1UjhHd2VIWExMbitETEhnUmtQQ1Br?=
 =?utf-8?B?UjkvWjlHMXdIQUliekJXVHFYamxZVlEvU2lWckNIQ3JnT1ovdDhNejllOUE1?=
 =?utf-8?B?TENpOFl5ODlpZkdPRlViVnYrSlRHNCthUDBhTmdoSlpmN1BwWGgxdmlSOU5u?=
 =?utf-8?B?Q2hvVFloK0FrTEd3NSt6TUJYb3VISVBNSEJhQ2lCcEwweVY1TlZEWVRlamtw?=
 =?utf-8?B?NFpwUkFITnNDeUlQZ2dzQzNQR2VPckQxSUl5REhMTWU0aGhFTHBXSWRKY3B3?=
 =?utf-8?B?eTFTWFNwa1ZScFpLSVlmbzI1TDJEMHJ0UzJUUlByRHFiV0FiTXRSaVkybjlX?=
 =?utf-8?B?andiYkFoU0YwWmlsV0JWb21RelZ5RllHbS91V3d6dkt3Y1ZXTjN0eEVKZG1J?=
 =?utf-8?B?MitLQnRMZHhzbzMva2dFckpiZHFSOVFxWGxDbUtUN1UzOS8zdklYUEtjWW1H?=
 =?utf-8?B?K0FueVlHTkdFRG9KaXovYk5sS3RjdFJ1dDNSLy9TS3hYNGZKaWR4dURFQzRX?=
 =?utf-8?B?c2ptbjNjUkF1b0tUYjJ2SC9NVTNMVUVUMDJ5ZTdjZ2o4TEd5ME5lTm84N0ov?=
 =?utf-8?B?QXZTWXVKWlIzSkN3Y3pHMVdHaUJ2NXdBVnIwcDUwMkVNZEQ3K0pyeXNpbHJ6?=
 =?utf-8?B?dUx3dmVCKzRSSC93OTNXY3NIRFFXSDkyM1RHdi8zOEZ5M3dhRWVyRk5JeXhp?=
 =?utf-8?B?VU16TXVxV0VBL0RwcEdUZ1FzNDZXNVNNSExjZzIwN09rcUlxeDNtKzlKTzJq?=
 =?utf-8?B?MVhpV0ViYzNZdkdLM056aGZKdHZIdDE1OW9LNGl0UGhhNUZqZVQwY1hsTlpS?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7303b896-3dc6-49f2-5642-08dc80deb59a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 19:28:39.8402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tu73YmL+Zki3WQ+o4Xar4Ajyk1AiFj+p+YprjLe+5gY0O8SHGQjTtufcz89YaYMQPQ6sjjH2eYdxyhaKrbD0Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7025

On 5/30/24 7:25 AM, Shuah Khan wrote:
> On 5/28/24 20:08, John Hubbard wrote:
>> gcc defaults to silence (off) for the following warnings, but clang
>> defaults to the opposite. These warnings are not useful for kselftests,
>> so silence them for the clang builds as well:
> 
> Please you add more information on why they aren't useful
> for kselftests.

Ah OK. My wording is a little misleading. The warnings are not useful
for the *kernel*, as previous decided by the gcc settings when building
the kernel. And it is only only due to including kernel data structures
in the selftests, that we get the warnings on clang.

So it is not something unique to the selftests. There is nothing that
the selftests' code does that triggers these warnings, other than the
act of including the kernel's data structures.

I can post a v2 to update both the comment and the commit description.


thanks,
-- 
John Hubbard
NVIDIA

> 
>>
>>      -Wno-address-of-packed-member
>>      -Wno-gnu-variable-sized-type-not-at-end
>>
>> This eliminates warnings for the net/ and user_events/ kselftest
>> subsystems, in these files:
>>
>>      ./net/af_unix/scm_rights.c
>>      ./net/timestamping.c
>>      ./net/ipsec.c
>>      ./user_events/perf_test.c
>>
>> Cc: Nathan Chancellor <nathan@kernel.org>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>   tools/testing/selftests/lib.mk | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/tools/testing/selftests/lib.mk 
>> b/tools/testing/selftests/lib.mk
>> index 2902787b89b2..41e879f3f8a2 100644
>> --- a/tools/testing/selftests/lib.mk
>> +++ b/tools/testing/selftests/lib.mk
>> @@ -50,6 +50,12 @@ else
>>   CLANG_FLAGS     += --target=$(notdir $(CROSS_COMPILE:%-=%))
>>   endif # CROSS_COMPILE
>> +# gcc defaults to silence (off) for the following warnings, but clang 
>> defaults
>> +# to the opposite. These warnings are not useful for kselftests, so 
>> silence them
>> +# for the clang builds as well.
>> +CFLAGS += -Wno-address-of-packed-member
>> +CFLAGS += -Wno-gnu-variable-sized-type-not-at-end
>> +
>>   CC := $(CLANG) $(CLANG_FLAGS) -fintegrated-as
>>   else
>>   CC := $(CROSS_COMPILE)gcc
> 
> thanks,
> -- Shuah
> 



