Return-Path: <linux-kselftest+bounces-37762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B75DB0C880
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 18:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9AA3AAC90
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 16:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EC82DE217;
	Mon, 21 Jul 2025 16:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C3b8byCN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853091A3154;
	Mon, 21 Jul 2025 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753114940; cv=fail; b=RvVJZmi/+2fy6JRzLToCclCDMvEfTWsP+SNHLRrCvK+Azorv9YO4nFM3myOQEgPOSiIAv8xcQ3njrd26P6vNHNpXINHnBQUFERhPUx08n2jyzC8yePuVas3kqitGiLK6l7MW36+RNYRHwYzs7PEPbYyslUAzoljL29ZSkK97QoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753114940; c=relaxed/simple;
	bh=cSvt/QcKzYBLxjiOAH3diJwS7tGISqc6QV/9wyctJiM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=etsIOIwobiZiSpytcbmKl9joniYyWyxk88Y1Dj7JqST6abcY34KgUe584Z4sLN7SNSXX34su4wmw3nL5mbvb7T1f8P8EXi4gGoq/tlC+7zcN5SUFk4lZQR4SRMIhOmrDIzvDIDK4GUzpjCiM6dRuvIRv/J8gUuzbLy7sbUFayBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C3b8byCN; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBYM6++npch7l3uIDF4E9uJ3WKUOM30ouYPKatkDd33Db51HB46HiO6j6kUQIOyThQeQhQttu+/bBp97PBnI7ukwmalKpfQ91Hnl5KakdzHzVsU68QJ9bkpexk6FxHTPK2qDcBZu0Zx3ojoYUYqmu9tEPlHC37ROXygCG7jCFM5TXzpm94VSC6RxG/apUll8hZAjWIla77lQA0sHTb9FPitvk0cDxmEY3m0i04ebVNlEvjYKc+KfG1xLHKeWPuhLBWErOtPPGVfca30Wh8rtTtVN9md92FzfkA0kEW+F7PSzaYm1/Or7j7+gqGzpx1Uharb1oPi85Oh/b1/BWrcI7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+XpEKfvrhAJLdDvE3j8Mlo5EXtO0SqZNKbBvKwmqP0=;
 b=XOYR9/2jN3AgOutK8f9VLSzW/IDJjwxPkxOh14WMpMfLUYlrwUGIh/w6uy3ozD+1+oyipHYJUBYMivsR5jWFBCw+njBddQQ3UL7YpKUkaH0afg3aCtTkvSXZ1yzMfY1vbt7Edj8urSLqMqa2ANpQjmS6knyLPG0ENoaZ/dcj/bybyYm8WBg4SBUkJAUaGHK8fo/vyFS5RH94by2dK/dJRPVL7wF1THNWjHS9iLWbeBrfIb4AXpuDbgUYQ3LpJzADH/8HkarCoYRa5SU62tyJAIukU41wuoqXjFYIH5j/tfmMI5QHFdQ9AO3Knm/yzMD33NFi9ar+bqx7cJaDpoSvgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+XpEKfvrhAJLdDvE3j8Mlo5EXtO0SqZNKbBvKwmqP0=;
 b=C3b8byCNpeCL/eg5rAumYjEYsUNEFHz0xjRaFxTChsGUBS9xmyl4OAGiQKG9jfXxet7z/uuwT6VMWZ9ZbfmEkWgI8Lo+Os+ikAaIvVcUOfqahooshDzEDE0mEzg/DQ62lqMANaSf22tXVXaPTAo3YQAEWq+pkeUKUTsCua62/X15iMsaYkJMTipTDyC+0unDAxROcpu6BmoubYkDx5emUITabpf3B81JmIQgT/zpIO8SzpgBo0tbkNsstfTUENLytYpmLs4HgtIhInA6Y4ynzYasBuoapPVfqQSrQCJEAhj46rhGdORrW0w2fkfNXQA+tvbJ1M3Oja5do/A+tKXMvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB8284.namprd12.prod.outlook.com (2603:10b6:610:12e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 16:22:13 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 16:22:13 +0000
Message-ID: <699122f8-e6c4-4c0d-ab2f-3e1de2c8921e@nvidia.com>
Date: Mon, 21 Jul 2025 12:22:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] binder: Set up KUnit tests for alloc
To: Tiffany Yang <ynaffit@google.com>, linux-kernel@vger.kernel.org
Cc: keescook@google.com, kernel-team@android.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20250717011011.3365074-1-ynaffit@google.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250717011011.3365074-1-ynaffit@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::31) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH3PR12MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c38c339-8a53-4d2c-27ab-08ddc872bf7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cW8zazdPQnJXMnR1azNLQVphU3BXdlhYQzNZTUdhVkd1RkFSMWgrcVh3Z1ZB?=
 =?utf-8?B?OGREaitaczhUd0lZVEFkYVV3YWpEU1hzQm9wZUt0dmkyNVgyWUQ2Smtvbld3?=
 =?utf-8?B?V1E1MHJzWjNIZkRFd0pkd205MVJVOSt0REZJMDVBbTNaUjlzWit1ZHViNzkz?=
 =?utf-8?B?aXgrOWEyNnhlSXlValJxcmhTM0c1d3lMaXhPcE9nc0ltMmZUdkZEckRpbGNy?=
 =?utf-8?B?UWRnS1BJMzgwSldUVERIUUd1T2FGSjNMVWhRUjVoVXdoZCtLOVNkMEQwck9N?=
 =?utf-8?B?bFRWSGNyZ1JrcDY3bTdKdTd2N092MUVHSlR4R3FwTTFxRVFhcUp6cVpRRGJT?=
 =?utf-8?B?OXgwODVqYUluWVBPdUN4NCtoeFNJQzBFdmhNWXdzeTU3aHp4dnhpUDZEN2M2?=
 =?utf-8?B?MHQ5LzZrZE5wcUVGNEFheXM1VkMrbldnczR3MGg5ZHpjbk5hQVhvRU5UenRV?=
 =?utf-8?B?YS9tejl2MSt4Mk14UUM5V1hCbTVYVWVOZ2I2SnhqUUg4bFpTczZQSTNFZitB?=
 =?utf-8?B?czF6N1J5V2xTRmxCZkxvRksxdUNzMnRIallkMmpISktlZzJWbkdLRjFlb2tZ?=
 =?utf-8?B?eUowNUJ5QnJVdnFWaEI5Vld6UHZib2lrOGtFWTdEcUxFbVkzd1UrbGpJTWF3?=
 =?utf-8?B?MVlBM3IrWnBabzlhK3RCTlNTd25VcFRyWGRRWmk4aHZ2TVFUa1N0YmRRZ2Zm?=
 =?utf-8?B?c3NTODVJUEErdU14M2h0NzRPZUxVdjd2a3Y2c25IVStxcGJ2ZlMyUWsyeVZL?=
 =?utf-8?B?eGowWkxjZnFQcEZQNXpLQ040TW5Ra3pNRVRwRXkrY05ocFM1VEgxbzdOTTJC?=
 =?utf-8?B?cXczODI4Y2JLRkhrbzZ6UGVWZjJxeWNXS3RmQytTOENocncyLzlzUmpXVlVl?=
 =?utf-8?B?OEVqdU1NVU9GOVo4Y3VMek5pY1RSbnpXYWFtZkRwUFJ5UjFNcnFYV1dMNTBo?=
 =?utf-8?B?Wk1BZHVmN0tSZUJOZGdYRWcxVW1tcHhIaDgrU293ejV4T2lYY09MVC84NUg4?=
 =?utf-8?B?Mmx6U0Q1TTk0N29kcm5UTWlCcE1lQ2xudnJjN0k3aHErWTJIVnQrTmtabVNr?=
 =?utf-8?B?VjBheThmVzV1SnJFOGIrUWpUTFU2WHJuL1pFQzErRzgxVDl3bHF4My9OM2l5?=
 =?utf-8?B?SzVYK25hMXdYRTU5QjdvSTkvUXBxdXV6cHl4NVd3aFNmWm5GVW9JMUh4aFRC?=
 =?utf-8?B?aUlrTDcwSFJsZ0JwS3VjMGZEZWUyQXdRZm9LUWxJRVUwVGw0b2RpSzRJQmlo?=
 =?utf-8?B?TVJzZDRRYXhPSDcyWDdJamtFMWNMZlgvbmVOMnlQZnF3cStmOXo1eXR3Wm1v?=
 =?utf-8?B?Z2w0UDV3WkVhVU0rQUNrOVVtOU5zd3RRR3BHSkhQWWhQRzk1K1VsUXlJa3FW?=
 =?utf-8?B?anBpMXF4OVNsZnJaT2pDNWR6Q29UVTVYS0JxQmUzT1RTUnpZbE5pMXhjSmd2?=
 =?utf-8?B?UjlrdkdiV1FDMEYwMmNhdzlFaTRHWTA4bklVV0VoMENhT1Q4MWI2dXlTUXVu?=
 =?utf-8?B?WlJaR3c3Z250VEx2WGRIMU5rcUhyampQQzZRNG4veGZ2Y0ZYN2lxZWU1OW00?=
 =?utf-8?B?SDcwUVhLNGZUazJUM0RJaG9TcFRYemlsTGt3UytzSkppZENGUVgxVWRaWnJM?=
 =?utf-8?B?R0t2VGJkbDZLWU5TRk1TNDZpUXlhRzh5Q2QxeGJQREdYNGlaN1JERjArSFNH?=
 =?utf-8?B?YnFyclBlQmdMNFNMTGQ0Rk1pdjFwa05DR0hQOUZUZUNqOStiY000QW5UU1dp?=
 =?utf-8?B?a0xkSTF3YkNpclZTM1M2M0ZQTGZlT0xWaUliSWJ4cUozZVlWRVgxSkxtVWNL?=
 =?utf-8?B?N3VFOFI5ODA2dDhUdHRaVGR3eUlpOGErOGErZS8zVVVjVW4xWU5qNzRPZUVB?=
 =?utf-8?B?QTZPNkt6cGNIZzNhWjhUTCtxTzd6U29ueFJtSDAxbDJJUEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azIwcUN5c1c4WFViMGtVMENLZ2hmYjRaZW0rQUdRVCszZzBLcVVMN1Ard1Ir?=
 =?utf-8?B?eWNpdjVETHZKNVZRVzFTd0ZFYmlkbEZ6QTlnZTlmME1wM0VDMFVsWFduZU9Y?=
 =?utf-8?B?M1pmMHo0NWNFNEh0QzAvTE5EdlZ2RTY0R0g2WlNLdTYxazN6U0ZxSjlZUHpM?=
 =?utf-8?B?NHpkTzJXeHppcDVZeDNGbndiMkFYSm8wZTh2c1pEU0hmNGFPcVRFUTBVVGkx?=
 =?utf-8?B?cGV1dE85UUQxdmt3NjFvWFRQenZ2QnpuQ29VRXo4TUFPdUlsYjhKc0JiWVFO?=
 =?utf-8?B?Qmk5QXZzSm9KS1BUWFJlZDlWNEQrRUV3bEtBNFV5Q1ZCZkNqbG9qYnovbmVI?=
 =?utf-8?B?d2RUaUMxNkErMVlTUGd1L3YxUXFkSDZVNFBJbjVrSS9LMWdqWXg4VWdUb3Z5?=
 =?utf-8?B?Mk5xbksyM3lpRkdua0dwTDBETWZtTDZpRitFYmk0ZTZOS2NvSm5KMHhrbVR1?=
 =?utf-8?B?RnlTWDNlUVhwd3owZHZlby9MMnpEUlRmdkV4aW01UDRmdG50WURzVVl5NDJa?=
 =?utf-8?B?RnV1OHBVUXZzQ011U1JHZ3pjYjZPbjlTeW1scTZsenVkaUxUQ0dhbVpvaGtN?=
 =?utf-8?B?aHRlTjltZmVpS2tyMFpvdkY4RjZ6Yk5sV0EvNXRZOGJtbEJmN3YrRktDSFZ5?=
 =?utf-8?B?TzdmL1plcWRVNktualNUK3ArSWVRcFNnekx5ZkR2NlZRNkRGOERRZDZyTmtu?=
 =?utf-8?B?WWN6eEtvdXdjRXlyZE5WNVRibXBKNjJnZWxrOStURUVibzFCTDc1ZC9vTG0r?=
 =?utf-8?B?ZEw3eDFlZkZYNUxhUnlwZTNDSkJ3WTd3SFhZZkJsaXZ2TGpoUUkxVTM1eWtJ?=
 =?utf-8?B?UURqL2h2YkNHTm5ROWhFMzBJdGVFUElaejFWR0g1bWdtd2wrN1lkbTVpMHRP?=
 =?utf-8?B?L1prbmxrWXNSdWMxaUFBUlIwNnh4OWxPdnlGRHRxRGtaa0RqcHliT2VHRnhj?=
 =?utf-8?B?NVh3R2dqWjBvR2pDV3JBelc5ak51M3lIckZUNllYdkpNNThnb055alZRY0lL?=
 =?utf-8?B?cGN4RG11YzQzTXJHVnZxbXNRY3ZFOW93NW5GSkFCS0M4MTVBWGMxeU54UUlK?=
 =?utf-8?B?VG1vZ2ZMT1JRQTY0d2lKL2JiNnNBRHZWRWlDckRkZzVBMEMvOWZPb2V3WStE?=
 =?utf-8?B?SDc4cE1kMXRaL3AwdUNOVGhNb3FQdW9tRncvZmZjanBWRVNXeDdpbVdJVity?=
 =?utf-8?B?Uk10dzNENkkvaWdubTJ5bmxMVFR0TE9kNCtpa2FpRkhkRGxGNCt0WHAzU3U5?=
 =?utf-8?B?RTBELzNvaHpYeFdaeHBlVHBpUFp2ckJXYzlReEp2bExncUxvMy81WEJUWTR0?=
 =?utf-8?B?b3hESVVPTlBHYWxCR05RSU5YZDNIcjRBSGxvVUxlNTJ0Z25OMEdLbE94U20z?=
 =?utf-8?B?WDdvSXFqWjE2bFhmSGREbE5QZFZLcEMyK2t2MUVQNy82c04rMHNUbXo2KzMv?=
 =?utf-8?B?VHdrVnQ2QmhjKzR0d2ZyNjFKSGo2QWlLdWx3MzUvd3A4aG8zYVVvYkNkY044?=
 =?utf-8?B?bG5vK09pVDhySndkUHRSNDdVVkZLVEVkK0V2dHQydW8rSnR2VGRiSkdoSVhx?=
 =?utf-8?B?QXFTcThwNFkvZXh1TU53Mk9RYWpYREtoVnJidVJDVU9Jc0lISDl1dFU4Zko4?=
 =?utf-8?B?ZFlrejliaUhxYm5mV3k5Tnl2ZjlLcURpWDRyZmU1cWIrTHRyeXVMd3VvWFc3?=
 =?utf-8?B?TW1TOGQ0WTM0RXVXRCthenVUYytmS1JiYlhmZGw3a1plUjdHVmtIbkxIa0s4?=
 =?utf-8?B?K0Fxd2QwREdyN3hDMlpoSElzRDRBZWI2ZFNyNDFRM0NVSkVRRGNZWEluOEFp?=
 =?utf-8?B?QkQ1M2VVVXJyUXJWVEdqR2VlSitsb2FCMVdIOXhLMWIyRXhMVzVRN2ZQa0tM?=
 =?utf-8?B?dVhXek56TUtXeVlwYllKZnMvT3RraXlSdWhaVjJWTVU2TlNDcXlpeGVTNkln?=
 =?utf-8?B?S291UmFQSmk5NlovZzgwVCtLd094SC9oeDBGM2t2UlhORkxKRmtiQWF2OXdi?=
 =?utf-8?B?czlqd3cxalYzQVlJU21hM0Q2RGVjNStxMVYyOS9tQWRwQmJxQVlURmxOa24x?=
 =?utf-8?B?TDRoR0RPdDJhU3ZUcHZ0aVBLQmV6bGhad2RzNU5LbW54UHpvL1R1Z01TSDhZ?=
 =?utf-8?Q?iIfRGPVaTjlWM2B2FiQDlCpx8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c38c339-8a53-4d2c-27ab-08ddc872bf7e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 16:22:13.1662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVZfL69I78nyA2VlM+SnaudOt2QCF9TJqoFnUfsSHV2grMMi4M6Qg3fUEAwnmo1KpgUlrAuNN6eo54mMFY4U9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8284



On 7/16/2025 9:10 PM, Tiffany Yang wrote:
> Hello,
> 
> binder_alloc_selftest provides a robust set of checks for the binder
> allocator, but it rarely runs because it must hook into a running binder
> process and block all other binder threads until it completes. The test
> itself is a good candidate for conversion to KUnit, and it can be
> further isolated from user processes by using a test-specific lru
> freelist instead of the global one. This series converts the selftest
> to KUnit to make it less burdensome to run and to set up a foundation
> for unit testing future binder_alloc changes.
> 
> Thanks,
> Tiffany
> 
> Tiffany Yang (6):
>   binder: Fix selftest page indexing
>   binder: Store lru freelist in binder_alloc
>   kunit: test: Export kunit_attach_mm()
>   binder: Scaffolding for binder_alloc KUnit tests
>   binder: Convert binder_alloc selftests to KUnit
>   binder: encapsulate individual alloc test cases


Looks good to me!  And I learnt a bunch of kunit from reading this too. :)

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

 - Joel


