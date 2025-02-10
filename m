Return-Path: <linux-kselftest+bounces-26141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC09A2E35F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 06:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A738D3A50ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 05:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FA7158874;
	Mon, 10 Feb 2025 05:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G6GgzzhL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DBE2F2A;
	Mon, 10 Feb 2025 05:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739164011; cv=fail; b=IbnLqQWew2t6C/5wqLI3JYFHSfb1DoRx/6ij0hyGB3Cm1JeanYrr6xphPtwzJPDVsvXKDj06+/Oul25uqFlPbG2W7TDc8Af5kNKxCdkXLjQ33oBmuIifyUowIK2EI4oZc1bWhWD4qkfdsIo2+ati3at244iDzMAE2duncktbR7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739164011; c=relaxed/simple;
	bh=zoAPFE9I3uHrEDzUFazdmivfo9bpUJESnUJv9I6t630=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tlOtkUizh0p1QaMr1WaBzra9tg+jmDbZLhhNt2HokR023PQmVZZK2RhH5LfHH65g1YaMHt0IPTyN7soRoVpTpjlkzFi1Gx17YjgJZLY5UU5JDCMruu/ykgEAsoYlVdJcQtCl46gsLxDfpdcgqX+kBiY5xekETNj/7BcNQ3s+XWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G6GgzzhL; arc=fail smtp.client-ip=40.107.101.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JR0TsK2ug6jYooG/3dDFzs9H/5kS4wNGiET6Us9RBjqoLCCw+hrjTZ1fI8tnQ7fKtVtPqxMK4FKDmeDGQOKUw8raFFZtQZdRBW3vXszvhjVsXtMIExSWUivGUEPJHsgHygImFjyNqj5A+4wzota9tzevPJxOXlDhTlBelz5NrFlILWjbElAB58S0J18FH5d5smkwdwXeS4/KyX36eIaCPUMQsCeY1KxGXl4FMZ6GileCTpZ68nZnpoGG4cvUl2hbX0Bv2sd4bCY3VMC1v4Uv3SG9jX7gxXJd8zB/EMts+yyLdnUfM99Ad2BLnK+FVb0JqKLIE0iL1K4d8qoBUtL1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYwEoVEZUUV8R9MrI26Jzr7QlAX2aFMEFmT1QIbBXbE=;
 b=mJ6KNUzbYlXdIgf6s5FW2eI4QtSppj9f+CtVycAK+XacW2DZwGaA0MBsXdpbJh2wpIA0Vi2HWcCm/59L/bB6XIgYXJtJmLEpLGeLpijyoBluAEai/mD9YIykE103l4wTYUZCenbAcMwEDfnHNiaYQATp3Km0fVUstqH5iW0qJzvzeAWyLRj9E+b5aPYXW85XuDbRAKoQ4ocTFwHVQxd1yPaqE+eUlgt/dh44ylNqif7h51G/65zC5y1vXtUq7RdvwOZRm6EYss5/sxfVhFIRIk0CCY/MbgVhVTcyoYQtKbfM/GwJjy/mwJbfWHKeLsoocHtVcLi0nmT+RYdkgnWXZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYwEoVEZUUV8R9MrI26Jzr7QlAX2aFMEFmT1QIbBXbE=;
 b=G6GgzzhLW5kR641+9Jyzp1BGyrNrUi95JsJWM0Sd+9mkQ6clzpcxTpxx+ZTR98o2LeHgus4z0Iu4N5ZAdB5b4SwglTSQ7n74mAYGBLL6Izla6ldH3+TySmvcmb6v1mk7T8sEi3RcRWKbOr6UgWU95qQqAnYBTBooGV2C9Cz6Ylg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Mon, 10 Feb
 2025 05:06:44 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%3]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 05:06:44 +0000
Message-ID: <9f1cc809-c2d8-4a02-ac01-093d3d3eac38@amd.com>
Date: Mon, 10 Feb 2025 10:36:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] Add support for the Idle HLT intercept feature
To: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com, neeraj.upadhyay@amd.com
References: <20250128124812.7324-1-manali.shukla@amd.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <20250128124812.7324-1-manali.shukla@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::9) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|PH7PR12MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: 43410ad0-4cdd-448b-a3bb-08dd4990b61d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFN3VUw1Z3NXd2M1bnZnRXE2dmtDVE5zK3RiSkdvanpkaFpTT0NudHQyOHkz?=
 =?utf-8?B?L0ZxVUc4V2ErQnhFS2FXZVM0WEl5ekdqSUpVSGdVekJPU2VWLzNVUlBGRlpr?=
 =?utf-8?B?ZzROdWdFbm03Y09oYU8zWFNpYklGL0JOcnBjVXJidUpxb1Rja2VJQ2NoUSt6?=
 =?utf-8?B?VHJqWVkwRkd3cHVFVmFCM0xhaG54QXVzdWdUQmx6ZFNVRUtPMDFkRVZlV1Nj?=
 =?utf-8?B?TXJiZU0vcCtMR3J4ZmU4RlpHNnROVVVkTStJbHFFYndqM0hqVkhONW1FQ0o5?=
 =?utf-8?B?cFRjYUJacDlXZTQ5b2dlenhWSWlVa0RuL0NZM1AzVVllcy9SOG52cjhadmE4?=
 =?utf-8?B?TnhWa0pTY1VjaEkyQVFOSEZUVFhpc1JsajJkSCtMTWE2MjB4SEw5YTRlYUFD?=
 =?utf-8?B?anBSNldBTlBpWmFCaFk1REc0NGhFUS9kVE4wZE1NOWVyL25KbmdpMjA1MlQw?=
 =?utf-8?B?UDRRekt0d3p5bXpKTlFuWllKUnkraXBoWENLRVVVYVlKeXFxKzRvZERsREha?=
 =?utf-8?B?OFRFaWMvYVVWc3JqS1FKcjZ1VVFFT1A1dG1ldDFRWThTNUFCMklhcWFpbUtW?=
 =?utf-8?B?am5PSVVVNEVwVzQ1a3QveThDWndCa05aaUNRNTcwV085dml2WVUzU2Nrb0FQ?=
 =?utf-8?B?cW4zYkNWMzl1ZFdXV3Yzc0lrTk12OHBqNFF0dHBEYWZvdkRhRTB4YnVVbGlr?=
 =?utf-8?B?V3NRazd1bWh0S2VYRFZhTFJPSHkxMDJuWkhpM0FJNnhuK0FNNzZBNUlSc0hX?=
 =?utf-8?B?bTNITmxueTdXbFNsamh1cWRMbGtTdGVTNDZFSDhRV0lZcUtZamlGcDdrc05x?=
 =?utf-8?B?UThoZW1Ha2d0TmdzemNpUkVVUURGbjV6OFRJeWtkZlFTSHQ3UmVVTEppdW1L?=
 =?utf-8?B?OTd3UmdlZU9aVmczZGJVUTJFa1BmdjErdjgxbDI3bjRGS1p6SnRxdWsrQjZo?=
 =?utf-8?B?NS9wd0VkV3NibmtaeUowa2pMK0lQUDZ1b1lCYkRKVkE5aVkwL014eGsyeDJ2?=
 =?utf-8?B?QzN1dlRFOXNibHIyWjB4cWhzeWNSREVBS2M2TCthV3lJcUVCYys4SmQrNnpJ?=
 =?utf-8?B?WXNqbVRxbFk1WlczODJ5V1FwVGRxQ01nZXJSaG1neU1TZG50VXNqbHBGaXBK?=
 =?utf-8?B?WnJQR3FkYVRSRDdpZ3N6S0toNSs0WEc3MjJ3aE5ISDRjT0ZCUmlRbE96c3Ft?=
 =?utf-8?B?ekEwaDBId3YrM29PNDl4TWY1SlB6UDNtbXpXdWxWM3pkTk1JVVRhYTBTM1p5?=
 =?utf-8?B?djJMVnBCeURFTTFWVGcvUm5Mb0tPcmlML05xRE4wdWhEeGFnd3dzM2UxeE1m?=
 =?utf-8?B?T21iNEc2cWV1SXJySlZxZDNObzhoZll0SDVZSkhvc09OVmFEQnB1dmhTUDNw?=
 =?utf-8?B?cDdpTDZIL3ZOcURsa2U4Y1hOWXV1S2x3Z29qV2o3OExVQVdlcFd3VTc4T2wr?=
 =?utf-8?B?Z0h2UHJTTitsUk5GZGlkbDVuZ1U0RDZaY1BFSEc1a2dGNXI5WWFmbFMyd2h4?=
 =?utf-8?B?S1Q1ZnFCcktrRjRHSEwrbDhTMlJ2ZnVJbEhBNUJmRStWYVFBN2JHTCtqQWcw?=
 =?utf-8?B?ZTdIaXk4b1RORnY4Zk84VlFkYnpGYlQvTWR3Y1RxcGl1cFFnZGJ0d3AwcVc3?=
 =?utf-8?B?VXJuU2hveEZXcFhlVFhNS0hkT3EwTjh2Q1h2dFNNWDBaTThtbjd1bmM4UFFO?=
 =?utf-8?B?clZyNzY3bEI3Z00rQnRsV2M0a2I5d0l3ZEVuOVo1dUxScDFYc3ROOEJTRkFv?=
 =?utf-8?B?Rkszb0swRkFSZmFUSllXSzhIZW1xd1g5TGlsQVZieER4Ty9zZlpKc1VKOTZo?=
 =?utf-8?B?d2hKMlFGSHExR1pZdXBxUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmM5WldEcElvRjJUcHd2dTd2Wno5b3g3V05IQi9PNDRFaktkWkxMdkJHWDBX?=
 =?utf-8?B?K0FBVlhoMUdDMlVQQ2ZIeUxKY0Fyb3Ria2hsMVV1cWNLK1RMVkREVUdFTUwv?=
 =?utf-8?B?OG15VXJUQ0lJdTlDKzZ3Q2x6YVlrZTJLUk1WcjhWZnBkY09HemRtYXdDeTFH?=
 =?utf-8?B?NmFxNG5EeW9NSWtuekNvQnBYWFNwMGJHSmdGRHloS3JIc201UUdpekE4cXdn?=
 =?utf-8?B?TXl6OGZ1NkV6ay9ZWFp4ZWVRS3dhUjB0M1ZmUm1FUzdwNlUxZDVmazNnSzAr?=
 =?utf-8?B?VDk2WVIvbmJwdWJ6L01BM1NOTkpuWW1JOUZEU05jMy9MZ09Gejk3RHM0ckds?=
 =?utf-8?B?S0Q1bUJUN0JhZGRHMEFFRlBSc3NZTC9NZnNBZHFxZm5hT0dkNHNTa3YraTlS?=
 =?utf-8?B?S1RuMG90RjRycFFQQlpDQVNKYmI3Q0svN2J6TGVsNmo5cGRKS1padU5zais0?=
 =?utf-8?B?Z2R1aHFRQ2pXZHNWemFWVVg1MHl2b2o1Uk5ZazRjaCsyUndaR1FHeVEwVGFD?=
 =?utf-8?B?anJLTzdCc1l2eXZRZFFKOUJOSDdRcU9BdlZ2UitDa3M5VWRKNTZPNEJhM25x?=
 =?utf-8?B?VFA1MUpBQ1czbWQ4WkUrcEQxN3c5STZXZCtpZXlDWHJpSUxDYjN1UzZXMWtR?=
 =?utf-8?B?MHdWOEhXMHBBUHMxK2c3d25oVERmR0dTd1c4bmhLUVUrUm9QQ25ScVZLRVhL?=
 =?utf-8?B?akFUVEFCWlRnNDBZdG9rcElBeTRMS25xcVd2Um9COERjSzVSbzllUSs5ZDNX?=
 =?utf-8?B?NVphcUJMdGxJQjlOaVB6TUVxcERiL3JZVi9GL3Jqc0d1d0k3SUV3TC9TTlRu?=
 =?utf-8?B?R2lRaWJ6aGFGeGE5Yi9vQ1FZdUx3WTdVWGplVHR0U3ZGTTFmTzduWEE2SlZu?=
 =?utf-8?B?QUVHaTk5a21GU0Uzd29nSkI5VktwYUp3N21vQzJiUXlneFNqUWkzQ3NRMUd4?=
 =?utf-8?B?bFhPYStJek96dDdYYjJsc0lBNFdrZnVrZkNyNzBjWFF5SnhobVVxNzJvbGxm?=
 =?utf-8?B?KzBmRCtrT3cwK1o5Q3gyMGJ3aGMxU1BSSGhjNU15T3JmSE9lTTNIdFJwR20y?=
 =?utf-8?B?NHZUdHY2VDBxMVNBbnlTN2NjSUpEUmtGSXRYQS80aklaZFVEY29hWmxKZHZC?=
 =?utf-8?B?enpvNHE5M3FPM1c1Q0tIUHNzc0VtN0pBZDNwZzUxRFpUSEZndDBSRTBrZmJp?=
 =?utf-8?B?VmFMejdwR1V3WElVRDdNTmNOS2VPMlNhVkR0dFpyMnpvOVRha1R3RTIyUnIz?=
 =?utf-8?B?V04xMythRlhGK1BSNWZkeU5RU3lTRnl6OUs3d2tSbUpEUWZLakROZ250a1hz?=
 =?utf-8?B?NTdEU1BxNkx4VTZnL1BVREwxZDUybXU0eVpqK0J6anVrY2UzUXRIa1gzYVdI?=
 =?utf-8?B?VGxiamNoNnBabVc2dThGMG9vdDNwcno0WkNOMDBaby9jYnlrUm1ZWXhpdzRP?=
 =?utf-8?B?cGwrRjhCZDdDU0xtTDNERXExdFRib2ZlVTA1bWJKemFkRjZGTCtkTkZmNU95?=
 =?utf-8?B?bkw0RzI1VzJ4eWx3Z0ZBVmMzVS9GckM3WHBhUklYS3hsTzlkYVFXSTVPbzQr?=
 =?utf-8?B?YXFBa2ZrWWlxMjVSRUFWV2RVWnlhMHA0QUJGLzVxMlA4VWgzdEE2aG9PVWdM?=
 =?utf-8?B?b2V6TWllUTc3cTErWktVcnVrU0lnNXkrdXF6MWs3NDFCRE5IVWxMd2Y0bG03?=
 =?utf-8?B?ckVMNVdXVFBaZmVSQTYyekF5VVlsSXZvRjNIWjdFZEZCOXRsbzdLc0c4UG5o?=
 =?utf-8?B?RzhNN0cxVkQ5b1lpU1Qxcm8vcjdqNkxFdVgwSU1ueG1DMnpOZXJ3Y2xjMEpM?=
 =?utf-8?B?Y2VoZXNHeDR2YzBabUFJTnRGbHprNzBtWjkvcTlDcG5OSjBxbWNWcHRTNjI4?=
 =?utf-8?B?cWZjbHNRckU3VGx0bldTRHNkdTZiWVZMdS9sNlVXeVZBcG9RSFMyVWxjTEVa?=
 =?utf-8?B?SlViOHVMTFJRY2JiK2ExZXNoclBCNmkrcjdNVi9qTXNCaVRnTXJQVndFWlIr?=
 =?utf-8?B?cFV5a3RvVW96NVlFckczUTFkaUp4QkM1RXFKcjZLYXhZQ0VVaCtxa0FaSVhY?=
 =?utf-8?B?R2JQUTRYb3VsVThIU2FyUklQRXk5Q1g2MDc5NG5UMzhPQzNsWlBxUUU3aVc0?=
 =?utf-8?Q?5CplbICiQvKce1j9S9mOZlAWe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43410ad0-4cdd-448b-a3bb-08dd4990b61d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 05:06:44.0532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WTYGkY/NGDwe8DMYH714TdZG0nKX6W+pVNZTT+lE3z8I675R+KAAt037beKLqNssLav3jf5jYoJ2scVFkWTZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5596

On 1/28/2025 6:18 PM, Manali Shukla wrote:
> The upcoming new Idle HLT Intercept feature allows for the HLT
> instruction execution by a vCPU to be intercepted by the hypervisor
> only if there are no pending V_INTR and V_NMI events for the vCPU.
> When the vCPU is expected to service the pending V_INTR and V_NMI
> events, the Idle HLT intercept won’t trigger. The feature allows the
> hypervisor to determine if the vCPU is actually idle and reduces
> wasteful VMEXITs.
> 
> The Idle HLT intercept feature is used for enlightened guests who wish
> to securely handle the events. When an enlightened guest does a HLT
> while an interrupt is pending, hypervisor will not have a way to
> figure out whether the guest needs to be re-entered or not. The Idle
> HLT intercept feature allows the HLT execution only if there are no
> pending V_INTR and V_NMI events.
> 
> Presence of the Idle HLT Intercept feature is indicated via CPUID
> function Fn8000_000A_EDX[30].
> 
> Document for the Idle HLT intercept feature is available at [1].
> 
> This series is based on kvm-x86/next (eb723766b103) + [2].
> 
> Testing Done:
> - Tested the functionality for the Idle HLT intercept feature
>   using selftest ipi_hlt_test.
> - Tested on normal, SEV, SEV-ES, SEV-SNP guest for the Idle HLT intercept
>   functionality.
> - Tested the Idle HLT intercept functionality on nested guest.
> 
> v5 -> v6
> - Incorporated Neeraj's review comments on selftest.
> 
> v4 -> v5
> - Incorporated Sean's review comments on nested Idle HLT intercept support.
> - Make svm_idle_hlt_test independent of the Idle HLT to run on all hardware.
> 
> v3 -> v4
> - Drop the patches to add vcpu_get_stat() into a new series [2].
> - Added nested Idle HLT intercept support.
> 
> v2 -> v3
> - Incorporated Andrew's suggestion to structure vcpu_stat_types in
>   a way that each architecture can share the generic types and also
>   provide its own.
> 
> v1 -> v2
> - Did changes in svm_idle_hlt_test based on the review comments from Sean.
> - Added an enum based approach to get binary stats in vcpu_get_stat() which
>   doesn't use string to get stat data based on the comments from Sean.
> - Added safe_halt() and cli() helpers based on the comments from Sean.
> 
> [1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
>      Vol 2, 15.9 Instruction Intercepts (Table 15-7: IDLE_HLT).
>      https://bugzilla.kernel.org/attachment.cgi?id=306251
> 
> [2]: https://lore.kernel.org/kvm/ee027335-f1b9-4637-bc79-27a610c1ab08@amd.com/T/#u
> 
> ---
> V5: https://lore.kernel.org/kvm/20250103081828.7060-1-manali.shukla@amd.com/
> V4: https://lore.kernel.org/kvm/20241022054810.23369-1-manali.shukla@amd.com/
> V3: https://lore.kernel.org/kvm/20240528041926.3989-4-manali.shukla@amd.com/T/
> V2: https://lore.kernel.org/kvm/20240501145433.4070-1-manali.shukla@amd.com/
> V1: https://lore.kernel.org/kvm/20240307054623.13632-1-manali.shukla@amd.com/
> 
> Manali Shukla (3):
>   x86/cpufeatures: Add CPUID feature bit for Idle HLT intercept
>   KVM: SVM: Add Idle HLT intercept support
>   KVM: selftests: Add self IPI HLT test
> 
>  arch/x86/include/asm/cpufeatures.h            |  1 +
>  arch/x86/include/asm/svm.h                    |  1 +
>  arch/x86/include/uapi/asm/svm.h               |  2 +
>  arch/x86/kvm/svm/svm.c                        | 13 ++-
>  tools/testing/selftests/kvm/Makefile.kvm      |  1 +
>  .../selftests/kvm/include/x86/processor.h     |  1 +
>  tools/testing/selftests/kvm/ipi_hlt_test.c    | 81 +++++++++++++++++++
>  7 files changed, 97 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/ipi_hlt_test.c
> 
> 
> base-commit: eb723766b1030a23c38adf2348b7c3d1409d11f0
> prerequisite-patch-id: cb345fc0d814a351df2b5788b76eee0eef9de549
> prerequisite-patch-id: 71806f400cffe09f47d6231cb072cbdbd540de1b
> prerequisite-patch-id: 9ea0412aab7ecd8555fcee3e9609dbfe8456d47b
> prerequisite-patch-id: 3504df50cdd33958456f2e56139d76867273525c
> prerequisite-patch-id: 674e56729a56cc487cb85be1a64ef561eb7bac8a
> prerequisite-patch-id: 48e87354f9d6e6bd121ca32ab73cd0d7f1dce74f
> prerequisite-patch-id: b32c21df6522a7396baa41d62bcad9479041d97a
> prerequisite-patch-id: 0ff4b504e982db7c1dfa8ec6ac485c92a89f4af8
> prerequisite-patch-id: 509018dc2fc1657debc641544e86f5a92d04bc1a

A gentle reminder for the review.

-Manali



