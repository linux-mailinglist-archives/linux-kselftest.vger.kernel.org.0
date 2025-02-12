Return-Path: <linux-kselftest+bounces-26491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F77A332AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 23:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E0963A3791
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 22:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72042066F2;
	Wed, 12 Feb 2025 22:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DXCYXl8z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28745204590;
	Wed, 12 Feb 2025 22:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399498; cv=fail; b=ZrYYKT3dqeU77+i0AILPIoqz7NU9eONKuBBucZUcSfJih3+0d2x6JRuWvk/Z+1Kr6Dv00mJTT+XcFr11fibf5ZFUzDlYnVOwR2w4WDv+gqEvqcrh1VOpTgdLLXKtu64cRcTlYrgTbJzSntFzWvcjXaENGrugC58pbBlnuFDCPtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399498; c=relaxed/simple;
	bh=6bAh8kILWkYv0L4tWQ76suucyIVUKUhJp8Jtnj8wN1E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YMHoMef2ainElKgH7ON61RgGUj8aZDmNtw3lPt5WEbdL3cnUcIIBPZl+3nRXWeigxGzRO4Nu58BmtToQHxRHUfrEqqLL86uFMbvvdKwaMo3n/iOIFtkAdH/UGf1GQ7UMaq76uvMQRY7rHmteotJ6PErINka8smWJtCGNWbiGjDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DXCYXl8z; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkom7bCbPxlYRzs75KpLfJMXXh0OZeNOt0skngSosGM8Jm55qlEjO7uwEq9H5tUOzPlcZoI42HzhNhUV5sLMNGbMN75fACwZIx+o5mfoD6agI9Iuk5n2zHhXj04ewfXitWqAvc8TZCNiype7FNhZ4anwJcFR3QqIpGNEPSJi/V35Kq1ig4tEqr+FwxjB47OMTkaU2n5xkGM1QLAUNmAgzsNFHEkm/MhGLCVB2hiiXBohRIJNZcK9Y3XmtdMs9cIIA4p5SlTNw832KMG53iS235cjJFfM7y90DSOOvo1hnHyWA2Vtr6jvZB+Pyj5CWQYLKlmT6rTXBvxmxK0asQ2kAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3MUtvBESOS4uBwTYUTR68MHs7G0Puqa1XwdBcJs54Q=;
 b=fTxfLp+90qL2njzrDGc+pzVCB/Ws6pE2VtSyiFoNZhtm/ByupgEgpxntm6MYu9k2vOgjQa3X0dzADrJdGmTZztmCrGtcAAcPz6OJ9zfoDJ2Y3Bn3qjumz7S1bsbdzD5DMjWxUc2pTlv6jw1rnSNVgzYbyrGChA2lc4t12hf1dLDoScCQZap5wyIfIl9oPP1t2f/y1dFZY480JjRzWacp2vQ4jD8e2DImLeDZwKPwDhWCDNMcuCg1DxfidxdU+Xue7D+KMGEQjev3R1SivUxBqmRqVY9wPVKH+76IDN7+Nu5ysktCziS5lesatqo3Eqk9Ol8japO8FPVikGNJMuPOeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3MUtvBESOS4uBwTYUTR68MHs7G0Puqa1XwdBcJs54Q=;
 b=DXCYXl8zPR7GknNJgIivfKjnRc4fbUOxC8pU3heImc1M0A6KP4rguxnqaWfmp6jm/MD7WXKrCqUEzkUK/Cb14MEqM7QjekMiy28CLeKxZWxtdzLb2lH7CgsUWfX/DudJopxxhxQKLd5b1vRThh+gRgazhIntTHo+k5kixuEFLBuAH/eXlKNBYk4kL+e6EGpUXMbte7xA4IfCkdF7dYDzJFK8F++zSlsOYBTdE+EPJBUCIhaNckKAMJiXQReJ+vqibWYrArmZZ+9rdH1gEVhJInWlhDAihxgmVrLLfXCFxemx+Wkylnk24nnOnd+YLwkjsRbH2cY30SUpU+YHXTVv/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by SJ2PR12MB8157.namprd12.prod.outlook.com (2603:10b6:a03:4fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 22:31:30 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 22:31:30 +0000
Message-ID: <12502c05-be51-4c9d-9cb7-5a40ba1fe307@nvidia.com>
Date: Wed, 12 Feb 2025 14:31:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] selftests/mm: remove local __NR_* definitions
To: Dave Hansen <dave.hansen@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
 Shuah Khan <shuah@kernel.org>
Cc: Andrei Vagin <avagin@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Christian Brauner <brauner@kernel.org>, David Hildenbrand
 <david@redhat.com>, Kees Cook <kees@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>, Rich Felker <dalias@libc.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240614023009.221547-1-jhubbard@nvidia.com>
 <20240614023009.221547-7-jhubbard@nvidia.com>
 <dc585017-6740-4cab-a536-b12b37a7582d@intel.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <dc585017-6740-4cab-a536-b12b37a7582d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|SJ2PR12MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e789632-5fad-40ac-2192-08dd4bb4ff5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzJPcXBKRWRROGZOSEFKTFJIWkd0TjZ2emwvN3RWNmRMQmhORXh0SFNUdElJ?=
 =?utf-8?B?dE9heldmSFdwWVIyZkFkRTdjR09tR1o0N2hBQ3BNdlhCMTRVaEF4YXQwQVRt?=
 =?utf-8?B?Q2FqQ01URXVlNXRCRHExcGtXZklmdUpHd2tZZll4enRQVE9vUXpDRnNvR1Jz?=
 =?utf-8?B?dW1oOTQwbStxK2NpNzcvTEZuRzdtZFVGTjJkaVlSSUxuOHB2ek5CK1hGMU1X?=
 =?utf-8?B?NFVROFovZWdBa0x5ejRqeWl3cHBXZFMxNU11TmRuSGJ4UDBOYjYwdy9qMzFH?=
 =?utf-8?B?U1FrNHk1Vm8zVTJzb08yRjNVTHZDSHhtNm95OEUwcm0yS3RoVzNZemxTOTBa?=
 =?utf-8?B?ay9VSTlRTE42TTNXSWxpQ2VkMUFvQjN6dEFkUU80YTk5bitLUkMrMDdkdzVS?=
 =?utf-8?B?V09JSm5McEs5bjNiL2grOFcyODlsdlQ0ZGh3OFZVM1pONFFSRkZrRnpXNTkz?=
 =?utf-8?B?d09rMy9lbEhnWGJzMWVKS3BkdklpM3VGWFA3cHNBbHYvVmZnR1hoSTJYZ3h6?=
 =?utf-8?B?dEFWdk9XdkRQT3B2Zk84K01RM0JDMmxiOE1UWGdyOHVGZmkzS09nTVUwYk9T?=
 =?utf-8?B?WGIzanNyN1l4NURpZVpMYzZLYjBpNXpkalpKaEcxQmlNTVNuNlpzc0Y4aVFE?=
 =?utf-8?B?Ym8vY1ZXcTl1RXlqSmFrRk83UExUZUFWY3IxTEF5d20wcFhOY3FyVDN6c2Ja?=
 =?utf-8?B?ekhqQzV4RmpSaXNzUDE0cHNmSjJaNGIwdzNjYlg0dnpjTnJJc2VuUTQyWito?=
 =?utf-8?B?S2oxSUJUSE1UUzlsQkY5SUwweTdRUEMvWHYvbHhsenMzTldsMmlJbjlrS2Er?=
 =?utf-8?B?RTU0SXllVGdpbVhsOUZRZkRZZERDN25VZlViNFRteWJjbUVha1J5cWprUkNH?=
 =?utf-8?B?bGE1ZWxSK2REcnlwRmpWNFkwZEI3REJBaDh6OXJNc2I4QmVKb0F4WXJkeDhZ?=
 =?utf-8?B?a2dMR1d3M0tZQThVZ3JtUTBQeFRJVkpRZ3hsd2ZZVTN6U0xkS0VZZUd4ZEEx?=
 =?utf-8?B?eXFGVFNjSVI5bVMyOTdxSE9VVjdhbTV0ZlZ6REhRL3JaanNXVk82dndmMHZ6?=
 =?utf-8?B?VithdHU2NWczSG5Nby9NNkZXSCtCT3ArQjFEYldLbjNwbDVPVU5LcUt2a3Bh?=
 =?utf-8?B?UThyQzM2TkJWR0swaWpEVEt5L1B0TlI5RzBxNVNnTHZRN3hkUlkyZnNTa2NS?=
 =?utf-8?B?L1QxM285NkVubDZwcFl0cFMxR3dKWWtuZGFiWDNZeHkycVpqbmJZQS8zdGJM?=
 =?utf-8?B?OUUySVBtOXZ0c0dnTG5nc2NvY3Z0c0hFK3VZSldCcW1WTytxVmFlWWFGTDJD?=
 =?utf-8?B?cTgxcnlrd0JNcFVLcENhL2hNbFVITnJTTTRBWnRWVEFNcTJnRVUra2VYSEV2?=
 =?utf-8?B?L1FxaFpwakhyR0RhUlRpd3JxaFc4R1ROb2V3NFErUWFoZEdWMEpOR2JGWTQx?=
 =?utf-8?B?cGhrdkFzdmJHRnF5K3Z2TEgxTk5WdEpQdldoZTU0Sm5hRW1BQnlLS0pyU0kv?=
 =?utf-8?B?OGhlOWpTVHdFeUlnQTk1SWEyOVRUWmIwRnI2TytpckdkY3lVUjdubjUxMnVC?=
 =?utf-8?B?aExhdnFQUFJ2QmlLNTZjL0dPeTR6ajNkOWlTd2V3YTFsQXBid3poSXBLMjZr?=
 =?utf-8?B?NlRkK2dVMFZzWWVEcFAxV2ZtNXFaY0NqQXFYUWtab092bkR4N1RnQUw5SVh3?=
 =?utf-8?B?UE9qY2hQVFVTSVd4L3htWWVyK2czRGR1bEdJSFpaa25ROUFhSDV5RFFycFUv?=
 =?utf-8?B?TlBpd3BhTmEwN24vK1R0NU1zNDlHUDdzUE4yU1hOUHJrNjh3Ylkyc3ZLbUFl?=
 =?utf-8?B?UDQ3YlBYSE1ub3lqdXN2NnVIN0M1MXF1bGFvaGJjR2Iwb2J6MWVOVkYwK2Nu?=
 =?utf-8?Q?If8kJWU/70+ic?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z04zSzczTTlkc0V4TTBOa0ZjNHE4VkJneUJ6cFkrZXhaVWFVMFI5U0J5eTIx?=
 =?utf-8?B?QThaTHF3YzB6dS80L0VEdEJFa3ZXTzNFc3BvN3dFbTVIUWZHR01VakM5aTcw?=
 =?utf-8?B?Nzg0QXRKbnBRcGRoUDhYQnVTeFBRM09yV2w5cWg2Z0kwY1RDVUZFTm1Fa2lL?=
 =?utf-8?B?SUxWWWhvZHdmL1ZrWHJoVkxRalc4V1ZxUEp5cXlzY1ZqZHVudk1pU3VVeENG?=
 =?utf-8?B?MkVwWVhzbGxmT0h4MCtJYmVDWlhBWExFaE9hYmUyVUlZUXl6M3h0VDY1eExk?=
 =?utf-8?B?eFFwZ0lnWlptMzFPcVlGRFMxKzFXdTBxVGpvSFlMMDhvK1o4anN0bk5PZWE4?=
 =?utf-8?B?T21PWDJ4K0dLN3YrYUhnVFpIUlhmcm9NZy9vSVlNa2EvQ0dCSmsvVWVpMXZH?=
 =?utf-8?B?a1dMVVRRVlBuSkhGZXFPM1dadjdwNUcwTXdFV3hOS21mczdMU1ZmRis4NjJw?=
 =?utf-8?B?Q3p4Q01YSlNhK0prTDRRS2FVWHROOTdlcnkweG1aTW81WlN4eUJobHZ6N3hI?=
 =?utf-8?B?MlA1M0dqdkxQaTQ2eVFLcDUvMG1DMDhsdnkxalBMNDNvSE5pbjJCQzJpclQr?=
 =?utf-8?B?eXlqaHFqd0I5eFZ2YmZzbnVLWVdGU0JMTEN2Qzc1OUpjandBWDBDNC90RzBr?=
 =?utf-8?B?eXcrMmlGV0lob3NwNVJBQndwd1hueEYzbGUzZUdOTUYxNTM2SGhjekoxNTJD?=
 =?utf-8?B?aENHM2RvMzlDT00zMWxJTThXRHVLVkMrdFdWWEwvUWVXNFV5anZNTG9UWG05?=
 =?utf-8?B?MU9OZlMvR0ovTnUzajNTV3FacWdETjFYV3JMMzFaRWIrLzZwZjhYa1dOdGZI?=
 =?utf-8?B?L0swRktPV1piN3Vndmd1Zi9FZGNhbGxTTzcxczM3ZnRsU0VveHl0cnpMM01C?=
 =?utf-8?B?MDJROWkzbS9ZNXdaOFVKUFRLK2s3aWI5UkdFNDFvN0c0MGNTOVR0TS9UTjlU?=
 =?utf-8?B?ZWlBRE1iVGcxcTZXRWlBdUhjS2NlSGc3TmlXVzJjaTNpQkZZaVpXT1ZuejN6?=
 =?utf-8?B?Ty9vWFlFVGJGU0s0eWpGaUNnSXBMOXVPNE5WWWFQSDlGbnpmeVhtaUY2NzRY?=
 =?utf-8?B?YTVSL2dJV0lzRG9IQUxrSkR1N3FXUEJ3azRwT0JjbnlSUTd2NWcvR3ZUR2Fa?=
 =?utf-8?B?aXZoYlZRY0prNmR1NGtiRHI5eDVDOFFxUjVQakhPUkhETkExWnF1YmRTU1E5?=
 =?utf-8?B?VG5sLzZDWUp4SlFLVjlLK0tSOC93SmlGbTR6eVhlQkR5S2lWM21Oc2NzZ3dj?=
 =?utf-8?B?RjJocWVNeGJqUXl4MDlSUUtjc0RvT1VyQTBXNGcvVUVmMzNUOUpnSkczK2k5?=
 =?utf-8?B?SUFaY3BHVTN2dGpqTFlsWTdicGZvZFRPblZrOFI0VTZIMnVDbm9XVVZ3anFx?=
 =?utf-8?B?aWcwcDZNbGVnVE1FQWl2ZFdLV2VPQ3RtS2x1YlhVN0lwdUc2N2ROdFM3NHRR?=
 =?utf-8?B?M3FMNUVRSndZY3JkOWxEdUtOcTZQOEhpSzJ0MFNQSTBiQUFkbHRmOXNJWVYw?=
 =?utf-8?B?Skp5aFoyZUk3YmhsZ2hzNEdRNTUzT2VWbXRmTXl1MHordVBSTkV1aWdhakxW?=
 =?utf-8?B?cUZSdXpuMU51MjMzc3U2aUs5Y283WndFNGpQeHB6MFduTkJCTEF6NDgzemVt?=
 =?utf-8?B?bW1WNmxLYm5wamp4NHZxZG9aRHk3aE1GSDBUL2NuV1YrcXk2ZVkwaGdIempR?=
 =?utf-8?B?TktHOFBJM2JRREZOaC9pRS9hOGVvdytUVnJ3RzZLaytpcUtNcThocmx3YUg3?=
 =?utf-8?B?a1FOS2UwS0NpL2x5eXpTREJ2bG5vVEhNNmtWeGo2VU1kcitzRVpDcndBQ0J6?=
 =?utf-8?B?NTNGSWRQRHN1U1VDWHNPQ2VZS1U2TjlldjVieDIzUm14aGpjaWtLbmVMUzNk?=
 =?utf-8?B?b0d6UVZVcWRkbUo4OXhBZ0VpU1cvTkErZzlIK2V1TWZjdDhvUStBWW5IMDB2?=
 =?utf-8?B?clRvZjZFcU9LU2c2cStTdkQ3RlhKemNsL1VjY2M4QjdNbHRGQ0RINGRyYTJF?=
 =?utf-8?B?bVVtRUV0QUlHeU1IL2UxQlIrS1k0WU5GbnBObHBHTkQyRDYrdTBGRjl3TkJv?=
 =?utf-8?B?NFcrM0YxalNXSHdnazhpZExuNlg0Z2VNZU1hVHdLcG0rY2djV1Nza1VxYm1s?=
 =?utf-8?Q?z2/ESVUOYCIy6+Srf9JyrXBle?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e789632-5fad-40ac-2192-08dd4bb4ff5b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 22:31:30.8584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+FDYcS9XPz5lSR2q7oYu6Ns5vg1iUxzaavNqFWXsT20a6uuy8ux7yxJC56Vy4nxGUawijak1YpI8m8LwVA+Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8157

On 2/12/25 12:34 PM, Dave Hansen wrote:
> Hi John,
> 
> On 6/13/24 19:30, John Hubbard wrote:
>> --- a/tools/testing/selftests/mm/protection_keys.c
>> +++ b/tools/testing/selftests/mm/protection_keys.c
>> @@ -42,7 +42,7 @@
>>   #include <sys/wait.h>
>>   #include <sys/stat.h>
>>   #include <fcntl.h>
>> -#include <unistd.h>
>> +#include <linux/unistd.h>
>>   #include <sys/ptrace.h>
>>   #include <setjmp.h>
> 
> I'm not quite sure how but this broke the protection_keys.c selftest for
> me. Before this commit (a5c6bc590094a1a73cf6fa3f505e1945d2bf2461) things
> are fine.  But after, I get:
> 
> 	running PKEY tests for unsupported CPU/OS
> 
> The "unsupported" test just makes a pkey_alloc() syscall. It's probably
> calling the wrong syscall number or something.
> 
> I think it's still broken in mainline. What's the right fix?

omg I think this is an asm-generic include mistake, I'll check
on it in an hour or so, in more depth.

thanks,
-- 
John Hubbard


