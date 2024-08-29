Return-Path: <linux-kselftest+bounces-16657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A55B963BC0
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 08:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1D00B20CF6
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 06:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63E814B94F;
	Thu, 29 Aug 2024 06:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nOd6gkt3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABAC14600C;
	Thu, 29 Aug 2024 06:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724913448; cv=fail; b=pV2WAn3HaKUyVRbJBjB7+r1R9dvMENXM4aaf6ZYg+i5vGerg160QW8hJuS67CJ2BiwQG9HE6khhTck/WB7ZmDP9PAPJtcaomqh8QFmmsOIvo1LoYs8vZLKTnhCHwvjteMXsKBciFo3rQJD3vLxrM+k3BPfuwgzWZ9hhBA8xuArA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724913448; c=relaxed/simple;
	bh=qOX2e1NPCFzTOmIk6NYvx3VnfHPsv9iRfIihXPegy+g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KlbxYkso+hoUBe+AnATQtkw6ft0qbeZn1oWktOl8hd+rtgnPKGZCb1ZmlI2APf+aCiJ85KdPHdgpdkEG77DNqlazXdrB9Lt2ltNklvNWMNk1zBYuqgHMIWV0p+2zz3mKPwkkMMhPj3pxzxKLd/S5Pz/JNfdldAFG4LLbmzAiRA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nOd6gkt3; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIiIQEpIUp+VrnBMZsM6xmOqNrDofn/3NrhiYkwsYZzZF7IsV5i22RExccGk6W47QbdtRwie9MKRnTpQ+Bfsmy+STZhRSKlk7gxOL6RNcOoM8qSiQXtIlHLw3mXHvqDLULvRbIaK/yFDM/LHsspWhVEov3hJL4Ay0ILVpM0+O/+yGcDDLm0sGWLpWXda0HJMKFWop2q9MSUJEv0UZ4Igw5OYHhstVaHn/HmpdNW/gzBDDxJ0tGZKPFUy+nGmEJ3PV9cmsfNrPcwQGJcy3SWc/jjPyq6bhJMbItVivReqqqkY+VCfR2aRY2i4mCoum382RzzFT40WECVGgScYVIU0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zD+ob20YpMqLAlW2ItHQeWvZjT7ey/lUt3zl+eZZeNk=;
 b=u9KS0MxJdeb3M1nb0BWdvgxXOZbhcufnghYCOd3Nz57j20j2J0nuYhLMT1AGGP0k9fT+1oKCLTDWMzAbcOG2Knw3z+a3WxhR/e+KugVb9btd3/w6ga3gfVxIyUZIvbsArbyfl4y6exXKOLTli1IatOJepSe68u7OjtNs/64Ydlf3XMB+rOFjGjIrvpJZAMppstlwXfgsSOvovxdr2YD+02VyZqbEkE0pQyhpuDD6QK7pr954YTRlxv/a9VJvcmtlarqs0jH+W1WjIEqgzCRWIw6+dhgGR+GJMvaSSrF0PAIY91VxGsQSGrAVeryDom269y+znPSOqf+0gM5pzTa8EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zD+ob20YpMqLAlW2ItHQeWvZjT7ey/lUt3zl+eZZeNk=;
 b=nOd6gkt3xhg+GP0DsX5Rlqvhu4wd/3A6n6yZBqTzIcCYZMque8O4eY2czt8HajrxBlwFthmvZQ9AFvKkUKYYcc96iEu2GNNTDji1Di6zjgMRSTMXM4J/Q9dopMvEB9gZ6t6rwNGoqpBRonDH1NnwPLHkXF1cRjv/BKjfmuS8ZFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 06:37:24 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%5]) with mapi id 15.20.7897.021; Thu, 29 Aug 2024
 06:37:24 +0000
Message-ID: <0645ce7d-8cde-42e0-801e-a5aba59ce1dd@amd.com>
Date: Thu, 29 Aug 2024 12:07:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 2/4] KVM: SVM: Enable Bus lock threshold exit
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com, Manali Shukla <manali.shukla@amd.com>
References: <20240709175145.9986-1-manali.shukla@amd.com>
 <20240709175145.9986-3-manali.shukla@amd.com> <Zr-ubK_e4lAxyt_7@google.com>
 <cf8c67de-4c23-416c-a268-56a12801a305@amd.com> <ZsyqGGspHOsuyEBY@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <ZsyqGGspHOsuyEBY@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::13) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ffd943b-fbdb-4b44-f3e1-08dcc7f50a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L05JSjRUTUc4MnlEL0xPcW1Pbzc5VzlwdGdRa3Y0MVdaTkM0QjJxOGY0MUtP?=
 =?utf-8?B?emxNRjNWWWRFeVNrRUJOZTlRMGh1c1lrTEVFSmR6VFpqVGZtKzJNMmROVU9Q?=
 =?utf-8?B?a0psMnpsQUg3eStHWmVJK1dZZm9ydnVaQkM5RWdlbVNlY011ZVZOQU9mSmhI?=
 =?utf-8?B?RlVoSGp3M1krQmc4VGJCeXB6Z3pzMUtTVGVnSDVVSG1paU45QlB0cHZrQ2Jz?=
 =?utf-8?B?M29NZzRkNnNFUVpGUnh5QndWMjJsdmF3Y0paeHBhTmxHTVd0cmlrZnREQTJZ?=
 =?utf-8?B?V2pDcVVWcjk5UlFkS3k3WW9RaUdPQnVvZjZoUVgyRTYvZExDM3kvemJBb0dX?=
 =?utf-8?B?SUVFdHAyQjdGY1ZvendrWFZrSFNLWmhNWmFaN0ljUVF5TFQydVJCTTFuMHRy?=
 =?utf-8?B?VnNNWHMwRGhKaWNRUnRObjlhRW1VZUduaVp5N3NGd1FXMUlTdStub3g3R25N?=
 =?utf-8?B?UGQrR2xwSjBPVjM5aVhTeXcyYTI1WGdUak5IZWQ4dUNVNmZTbDR6T0phWEd5?=
 =?utf-8?B?dzlLYlk4MmxSaitQTTZneXlNYTR0QmQzWjVhbis1R0FGU3Y5V2ZlRFMrZGlO?=
 =?utf-8?B?cDVmYjNnaUNtYUV2OVBxaENyMWltdmVYTTNJcnZlWVJnZEE0ZWlUclV2SC9W?=
 =?utf-8?B?Y05pWGVoajFpeDlIN3pzT28xZ0pUOWVRRiszMkkvdFlKcVBGS0JQdndwekRE?=
 =?utf-8?B?bS84NG00ZWVwTzBJQy9pWnJzZUZ1eGU1VC9qcmltZldlQzZCbm44Tk93QkVo?=
 =?utf-8?B?a05KZnRlR3BKK3NQZ283aGkySFlraGJRS1JHV2hDOEhacDJBUTNtRCt5K1ZW?=
 =?utf-8?B?WkE0QXZLRXc3WldRRHduMFNwQVNtNzcrNFI1aWovNkJIOEdpTHVQTWx6SHZH?=
 =?utf-8?B?amNWS3ZmZnFLTGI0SWNrL09RQnFrcjl4VEhuMC9nQnNlL3l3Z0NKWkJFdzJZ?=
 =?utf-8?B?NnN6dHB1ZkxJMVVSYllxMTE3dDcyLzZIeHBMbjc3YXZsVGZRWWtmaVJJeTQ0?=
 =?utf-8?B?YXE3L3R1NWVEeHRoTllKZ25OaW5VdHl2RmIwTUFWcnFQRk92ejBHODFYbVdQ?=
 =?utf-8?B?NTZ0aTYwY2VxYnNTRE9La0UvVWJjZzJhZjVaNGc2ZXlGM3IwUGx1V3RPOXJ6?=
 =?utf-8?B?VWlJaFJtREZNclo4ZGRQQjdsSTI0T25LWk9OSjNnS1EvV0FJSUJPYWJyMzUy?=
 =?utf-8?B?eW1hSzV6ZnNCSytadGx5SmY2dWQxUnRUaEUyZG02OFFVcVZwQ2VHeHdaV1Qv?=
 =?utf-8?B?U3ZzaGlXdDZxem9KajBDN0lSU1pJbGZ5cGdWaENVRjZOc0I5UVNrOE92Vitm?=
 =?utf-8?B?Z01jbnU5Z1dJNE5NbzZEdHBabzNPOGxZaFBXaEJzU0JoMVFmY0VNWjJncVQz?=
 =?utf-8?B?S1V1MHJJUWRDb0tZNFVxL05wOGhWOEc5aDJtR0RuMFREZTFOLzNZUVJodkFq?=
 =?utf-8?B?Um0yUEV6YUQzTkRFSW5rZkl2dzNzVVRwbTNSbnA4anVNL3lvLzd3RktTa3BC?=
 =?utf-8?B?dG9XMnBIL1ViS3J3amdreDhySDg2TTlORWo5blFnT0N0RGVLU3ZRbWRtK1pX?=
 =?utf-8?B?WnVQMWZQVzRCTUdvSzhsTS9IaFVzcjVnU3F2d2wvVm9NakNxVURLakt5Zk9z?=
 =?utf-8?B?MExYb1MvTXdKMTMrZUhQdUVpM3I5S0JiYmdpeU9xWEZQMHdoWTBxZFJDMUlq?=
 =?utf-8?B?TThyYzB6WERCSGZ2cFFtSTFIaFcxcE5LbWdNU2ZCd2trWjRFSlFkYzlOSmpD?=
 =?utf-8?B?VWtYcnR3VUlOWTNNZkZFQTJhc1RGSkQ5MnovNGV1d2M5dm9HMUdLaGRyeElG?=
 =?utf-8?B?VVpKL05TRGxVLzR6WTRHdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUs4VHg5ekEvblkvdVEwOFVicmJZSHpBalYrRUJUdDFRaDUvTzVqTmkyVEIr?=
 =?utf-8?B?aXlRM0cwWnhDWm1DQnpFSmtMdytpMmUyNGpZa29PZ3QrbER4bzVQVGtOa1pV?=
 =?utf-8?B?bzdCVFF0SStnY21WeUZMcENic2krNi9ncEs5TE5ad29GdENBaHJwbDNqQWll?=
 =?utf-8?B?UDV0MWNURzFRTEhkTGFRQVpuelhzRjNaU0FWcXE1RnpDcmVnTXFTblJnelZQ?=
 =?utf-8?B?ZTZmVzd4RWh5WjRpdkdjclBhdTg4cGRIRnZpUVBxOXJYZTlBRHZac2JwdmhY?=
 =?utf-8?B?VGcyQjBVWHNrZWNnOThmQS91cHJvdmtkV0UrclhXM3dUMnQxcHFMTlB3WC9r?=
 =?utf-8?B?V1d6dlVVNU1DOFJGd1krZW5MMlcxbFdORER4bGUzU2ZMblhTT3JMSkhGaWJ4?=
 =?utf-8?B?Ym1tNnQ0c21jUTgzT0RhZ1gvdEErWTVLcTVJd0grL20vSzZLeVpFOFVBQTN0?=
 =?utf-8?B?Vno5Sy9oLzhIV2JPS3hmRllMTDN5RmgzRlhwUWpvYVp1RGJyVnpBeHVucUFH?=
 =?utf-8?B?aEt3WUl6L2Z2SHNWWjVsbUlDVktUSitSbWM5RlJWREtTSERrMW5xVmZIRjdi?=
 =?utf-8?B?N01XdnlVUVJlc2RyZTdZUGUyMGkvQ3FRdTREL3p3ak9UbzFQS1BjaFczUEVj?=
 =?utf-8?B?UWhUZ0s4b2N5WGJxL1ZNbE9WeDVwNVZQSzJ1dE9nZlRHMU1nbzJ5TGZ4SnZl?=
 =?utf-8?B?U3ZrcEN0Yzh3WUV5UWo4ZmxVM3M2dmlkVFdvMXNKaFNyMy8zU2tNLzdzL0xW?=
 =?utf-8?B?UWdpQTFzZWh4WnpxM2M3NFNRWWlqanp6UmwyMXB4bTlmMm9XUVA2WW5id1pI?=
 =?utf-8?B?THpxN1R0MElYU1NOWUh1N2tsNzFWSHVUTnFJZkc3ZVNKRVNtU0pEMnQ3NUV3?=
 =?utf-8?B?b0x3OHdNb2V3UjVmVk16cURLVkM5dnlYOUxsbGJ0VWFNdzV0NXNsUXJoWHhW?=
 =?utf-8?B?eC9XbW03VGFhVHBHaGZldGhnR0NFdnlpWXdLV011cW45VzB4Rk4yT2VsTGNq?=
 =?utf-8?B?M3lCZW9zNnd5Tjdsb0xoelRuWU1KVHRER0xmMGxZRlM0TS9ldXVwV2hsSmx2?=
 =?utf-8?B?V0NiSGtyc0k0TDV4bVBTZndwd0FFRWkxdTh5TE14UWhaZ0lHZWtZUVlQRHVV?=
 =?utf-8?B?emlvR0N3UW9waEFTcm5FZHdEUEV0Z2pmRU1LdTlXMlBaeVlVL1FvQllVbTF3?=
 =?utf-8?B?MjZoUEJsRjdCc3VSdVBGRkJEems3QTVnT2I5eDdKbGZIendpK0xCU0pXd25D?=
 =?utf-8?B?ekMvZzExbHNqZWZ2bnlqL2tLS0dkWW1vbU9KNTNzV1VXUXRBaXNwalJIOS9F?=
 =?utf-8?B?UmtVSGVtZVZSWEhkc3l1M0NHb21XcWxqL2ROYWlScXh4YlRBMXZaQWlNd3B0?=
 =?utf-8?B?eEo2REFYUk5WQnVZcXpVTlgwR3NFYTlHL3dzdFI4ZWphclIrR2JNd1gxeGlt?=
 =?utf-8?B?Ly9XWWZWOFF2ekV5c0taL29Rem9MVkJ1TXZydU5hd29nUnhxZ3VOb0pqelJG?=
 =?utf-8?B?bDRBWlhQa280VXEwc1pMTE8yekFvQ0V3alYwaWVIQ3FVV0J4d21tNXdCOVg1?=
 =?utf-8?B?bm0wZWlySzBYdHQ3aFl6M0NNUTJScFJkS1RnV2ZlQUcxOUMyajVJN1lBSVNh?=
 =?utf-8?B?VFpjSkFIN0YvdUJnSVZmcnN0cktRd2RvS1NXSjdNMC9SSzg3dS9ZN0xLVWRo?=
 =?utf-8?B?VlJNT2tPKytUdG56Z0FKcS9YbmRwYmdjZ2tiU2tvREVkQk0raFdiZ2FnblpY?=
 =?utf-8?B?WXIrcjFzVE9lWmVXVjc3MklxMFBiUU5OZVBLcGNWSUxrajY5cXdYZVI2QURu?=
 =?utf-8?B?Y2UrRlBFSXNydmNGYXdTQkRGM3k0RHZCY0ZnNDFZaWUxd0pzQkgyL000MERW?=
 =?utf-8?B?ajk2SURrY2h6YTlPZDA2U2VaZ1UzSzFJbTU4eFhBNFN5VnhoVExvcHR2QnJC?=
 =?utf-8?B?TTNhSmNoNXYraWY5N3BwQXNqOHVpWlc0TC9CUVVLUHRMVDVPSk14SW1sbFBH?=
 =?utf-8?B?amV4K2NJaVVjenNXMnEwYS9FbmtsOEZ4dnh0SUxRVHFPTEJqNlBnSVR5cXgx?=
 =?utf-8?B?Mm5iOWhRSGIyTEhqQlVINDhpK2NzbFo5QlpYSm9MLy9rbzNwVlVtRHRrSDRi?=
 =?utf-8?Q?7dYeaugZMKOzICi8lZcKAPsLv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffd943b-fbdb-4b44-f3e1-08dcc7f50a6d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 06:37:23.8876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ptb5+dRppcA9H7Dkq0sc20WNaQnF0+k5YilXTRFieGYgOMJJ5ufu2DgoGowpoFvniZQ7zezuj15fzIKfjy5u7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455

On 8/26/2024 9:45 PM, Sean Christopherson wrote:
> On Sat, Aug 24, 2024, Manali Shukla wrote:
>>> Actually, we already have a capability, which means there's zero reason for this
>>> module param to exist.  Userspace already has to opt-in to turning on bus lock
>>> detection, i.e. userspace already has the opportunity to provide a different
>>> threshold.
>>>
>>> That said, unless someone specifically needs a threshold other than '0', I vote
>>> to keep the uAPI as-is and simply exit on every bus lock.
>>>  
>>
>> According to APM [1],
>> "The VMCB provides a Bus Lock Threshold enable bit and an unsigned 16-bit Bus
>> Lock Threshold count. On VMRUN, this value is loaded into an internal count
>> register. Before the processor executes a bus lock in the guest, it checks
>> the value of this register. If the value is greater than 0, the processor
>> executes the bus lock successfully and decrements the count. If the value is
>> 0, the bus lock is not executed and a #VMEXIT to the VMM is taken."
>>
>> So, the bus_lock_counter value "0" always results in VMEXIT_BUSLOCK, so the
>> default value of the bus_lock_counter should be greater or equal to "1".
> 
> Ugh, so AMD's bus-lock VM-Exit is fault-like.  That's annoying.

Yeah.

> 
>> I can remove the module parameter and initialize the value of
>> bus_lock_counter as "1" ?
> 
> No, because that will have the effect of detecting every other bus lock, whereas
> the intent is to detect _every_ bus lock.
> 
> I think the only sane approach is to set it to '0' when enabled, and then set it
> to '1' on a bus lock exit _before_ exiting to userspace.  If userspace or the
> guest mucks with RIP or the guest code stream and doesn't immediately trigger the
> bus lock, then so be it.  That only defers the allowed bus lock to a later time,
> so effectively such shenanigans would penalize the guest even more.
> 

When the bus_lock_counter is set to '1' and a bus lock is generated in the guest, 
the counter is decremented to '0', triggering a bus lock exit immediately.
So, bus lock exit is triggered for every generated bus locks in the guest when
bus_lock_counter value is set to '1'.


> We'll need to document that KVM on AMD exits to userspace with RIP pointing at
> the offending instruction, whereas KVM on Intel exits with RIP pointing at the
> instruction after the guilty instruction.

Sure I will document it.

- Manali

