Return-Path: <linux-kselftest+bounces-45798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36615C663D1
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 22:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A54304EE4C8
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 21:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BF534D4C1;
	Mon, 17 Nov 2025 21:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gS/uZxZ1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A2232E6AE;
	Mon, 17 Nov 2025 21:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763414003; cv=fail; b=BdoFEMu1wlglzFQlbLUCFmOoZePHCewZtRk7A5TNjma9bEg2Gbp/eb9hYT8XjdQRFENaPSrmtQib3EK5bPcMqHESYzOuR1xhmfsbffvSZj6Z9rOdXsnOiXws5uUhmluyWod6OfftP6maoF8+n3osqtz3bee3VyFjONaa8hpBOr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763414003; c=relaxed/simple;
	bh=B5uv48MzG92PXrNB/E44RLc7Y0eLTCwgXdyhs7tiIq8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ugfrPk9jf4GbWZlc8rZbBN6btaMTOYk+vKT4AxxrWmCQT0DkwydcRoKQYbkoUzoZhcaCFEZMzxO6OGUy//jVvPVdmBYEBu/4EZApi3yJVY7eOW4ZmeTyeucKdX0ICq7sT6ex938QQ6JmBxXhhIUDylw6GKDbkOUhyO2a+No+aW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gS/uZxZ1; arc=fail smtp.client-ip=52.101.52.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhkTWQWPLj/6DPw2WCIyp7/MbYPEPoVVF1CbcL5egMVW2ukzMGoRNepwa99ZYc+Y7B9IBm/jMoKbKZrNjF2CeW2SDBrWVa05R6xEbDduJJGLtvsQpNYMzgbPwlklEdEq/mqKnmsjVBvnIoj3Dlcixm3jzxyaZU0CJ4mvBFG/ZwlkIx2IAYcd5a6bExeEtOrkHbSvf0L7MQqRygc7VjbuDJZpLo2t5q6yisS7cvwffayU4am5Y2QLx/znBKo2kmb2wcPRQjvCxixTEuCWXmkiy7WMDXjS8tNlhuNzKge+mjOSLKAJqhgoQONi9zLy0Ii+f9zAH8ZDoGIy/3kebglIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDyQNvZqZd4xaSuQ9SBI5bajmzElDdrtbeB77wxLbP4=;
 b=iUX9vI2GxP9OEmSZsMin2Ru2LxO0Fy75dSrELymU3+aTo0qKnXjv7WNRNxjvZNrBbJnPEXT/hkI5p3dF3YB/RDmLEq/Z9ScYpF041nmvNHqleVkI9FZfztb/OmVwKfwmx6o/5D8oezJW5RV+F3yghKbEFGyviP46Wznp1nn6WOKfLGEw/n0PDBlS9fG5he8Mm1YttfqFJOUGkGO9M/rWzZaS0O83eHEl92ztKL+xmlTcgja1Z+lLpr2T9v/pEpwUknjtHDy3MLjAAWDYraUUP8HvSxFUoXbukHVpHchZiviCc3wBUfeRIyVFClg4My9ReLB16kZsb1tHaTV31ZpM6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDyQNvZqZd4xaSuQ9SBI5bajmzElDdrtbeB77wxLbP4=;
 b=gS/uZxZ12ZEo1+ArvwXcs4njJ7Itvr9jcxttzSb2rb4EnunzBL2tFCCAuQUZaUsIatxhqayV35Mj0laJrFAT4CXO3Y742P8sbOMGIjA5uEwCXMQ+HD8CjczX4z1aRkQS5zBS4nUcph4Z9g5Rn6gXEZMhEPlLtlGR29XP8xmwQMhzpmYTRLt2ReRMpZbL+a1AEqdWli610lZCB/l+C9HGw3sewU8bK0MsNx+3W4n52DwYt8fpDig/wvUJB2CZ8fsGIympoKOYh7vm4yDQAvOytCdExrhy/fKijj/hOWzFWWNtfRyX8O8mHw2KXQ9GT+kbjUu2RwTZvNFlviboISMc1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.21; Mon, 17 Nov 2025 21:13:18 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::d622:b3e9:bfe1:26bb]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::d622:b3e9:bfe1:26bb%7]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 21:13:18 +0000
Message-ID: <da4877d2-65fd-4ad2-ac31-68d55bda7c07@nvidia.com>
Date: Mon, 17 Nov 2025 13:13:12 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: allow `clippy::disallowed_names` for doctests
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>
Cc: Benno Lossin <lossin@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, rust-for-linux@vger.kernel.org,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Rae Moar <raemoar63@gmail.com>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev
References: <20251117080714.876978-1-ojeda@kernel.org>
 <CANiq72=-w2p8sQgUKYgPG3Tx9GSUNgcVUp24k0ck2RqYgupCVg@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CANiq72=-w2p8sQgUKYgPG3Tx9GSUNgcVUp24k0ck2RqYgupCVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0154.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::9) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|DS7PR12MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ffcd19a-8a11-444a-d757-08de261e2129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3NNTVBLcWttUnBiVTg5L0FVUVZ6WnJhRExpbTNMUmNIVjQxYTcrbUhMTEc0?=
 =?utf-8?B?bXM2bWY3TUNoUVMvZ2hER3laczY4RU92S0FIRC9odWg0a1lNbk5DcE02MTJU?=
 =?utf-8?B?WHBKSE04aktwcHd2dFRIMTRSTTMwVUxEL0pTU1R5SGZ1VkUzNzNtbi8xSnB5?=
 =?utf-8?B?d21aOGdzRitPNGc3R1U0Q2lPRjJGYkViZjE1VDZoK3ppcmEwKzJOYlh2U29p?=
 =?utf-8?B?L0NIOTh3THZwZXZvMnR4MXdrQ2M4aUNRZ0NtM0RKYjVLU1FZWnQ2YWJvT3Fk?=
 =?utf-8?B?THA4STRNVjNVQTJTTUNWc0RGQ2htNnZjRm10OEFMMGhRNERtNDhKTjlzUWlQ?=
 =?utf-8?B?RnA4QURTMWNLTUp2THE1SHhVTzlDcEg3b1ViZmxuVWp4a1hmQjRTRzRLTmhO?=
 =?utf-8?B?Y1lmRGxxMEc1RzZienEzNDA5K0RVaXpYN0JZSjAzMHQ5eWNIeE5RSmtIZ0x1?=
 =?utf-8?B?d2RoSTNZeXkrZjRycGJoNldsL1l2WloyWnFoWHA1NEpMVlM0di9GUnd1RndD?=
 =?utf-8?B?NnZTUW9pUFdDZXRBeUVrM3NoRWFQdGhZeWVKZFUxRWIrN05oYkVtTDRnR00r?=
 =?utf-8?B?REVMNHgxY2R2QzJJVWk5Qlh5SmcvVTNtd2E1QklKY2Ivem1XUG0wc3JicG9s?=
 =?utf-8?B?ZUdSZkowY01sU1plTzFnNnVJeG9OUjR3ai8xZ1B5bEg1RjV0SXpINmRVZW4z?=
 =?utf-8?B?SEd6aTVaN2pDY2xXZjd3bVZtYURqUDg1Q0I0ZHFCZjB0N1VKT0dnWDNlNHZ0?=
 =?utf-8?B?R0hxWGdlaDlKMnZzWm5sVkNSQ0xJQ3BuZ05EUUFaanNtczJCSUlRM3ZaQVFs?=
 =?utf-8?B?QzV4MldwNFhPMjBlZ0svL2Q0UElvQXI1MU5qYUNWQ2RCWUtkVVRiZzVwNWdr?=
 =?utf-8?B?MW1td3N0ZHVXOGJuaEswVWdWaisvYzVnbElLYmpGYnJPUCtMaXBYR3luSm9n?=
 =?utf-8?B?RkEyQkkrQzNDNEZVMERSZWdFb2JKK0MzcHQ5aVJwemw3RjU3RzJRYmQ2Y1hU?=
 =?utf-8?B?Qy9EclZHdXRpNWFOMk5QZVFSVWVWZjAvM2NiZURyYWFGdFFGRzNNMmk2NjlM?=
 =?utf-8?B?U2N6Mk1xbnBGV1hTQUxmZXVxNVZjY3cyQVEwSFJHU2V1NHdUaXN6YjJ1QmVq?=
 =?utf-8?B?Q3ZwT2hPbGRLdDJTeCtGWlhTQlVkVmpRZ21HZ0ZLeU1oM0Z3THlkQWhIWW5U?=
 =?utf-8?B?Zk41bjNPZ2Q0YXF6MXNBbGhocXRXcUlBZTNTSzdpTit3RGNseHVINWpHWC9z?=
 =?utf-8?B?YjJOcDRnTkQvaXpUZGpQVVdTcW0zYjV6K0kzRWZxUFpZNzh0QlRFZXNCUUYx?=
 =?utf-8?B?VlpWNVhPaEhjSTJEaFltSlFMWFowK09FbVNHSzdoYzNkdW5leWNVZThJblQ0?=
 =?utf-8?B?cS9ETnA2WjZ4UDZ0THF5QmhxRTJGb001QUMyK0JnQnBlbktKd3BCZXM0ZWh2?=
 =?utf-8?B?OWVtUHp6YXBkUkMvdXFPZUZLVVRkRThUVXphNWJnN0RuQUFPR3ZndzVVTDhG?=
 =?utf-8?B?Q0g3aU1VangyMVRGck5YbHJmNFNjc0JBVDFDdHlRWURtWWFyRjBTZEpWa2M5?=
 =?utf-8?B?cG1rcUM5aE9xY3djYS9DSER1ODk4MFl3d2dkUmxNWXF3Uk1wMThMNjBidGgr?=
 =?utf-8?B?Nmtxc1gvTHROWmJlbDR2UHAxTXpRZ3VwZEl3aGJJUSs5SnpzcjFUY2p5QUFx?=
 =?utf-8?B?YTZteDBDSzZQSUYyVDlrZTF4NTFobXRIZkVRdEw1TUNHdHdtUVU2bnAwM3Jo?=
 =?utf-8?B?UGc2NE4rTnNPRWhIWVlBRFVyaXo1YkZ0d25VSGozaE9JWFdQQmdMNzk4NDFI?=
 =?utf-8?B?YWk0aE14VktUbmFBRG4rNldXRXZkS3pXVjNQcDdkOTBSdDZyL21xQVpkLzVR?=
 =?utf-8?B?c3pJaVY0WHIvQjNzSCs3a1FrNnhicTlzRmhKMGo3WDJnY2pHb3hRcnJNb2VS?=
 =?utf-8?B?bmxMcCtoeE1xcGtxdGNtYUpZM0FoaEc0cTRlZW9QWGJmYU5XMDR6RHFwTzl0?=
 =?utf-8?B?ZXgxKzd4TVpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkUzQVl5Ui9hUGZlMzhSL0VWb2dsRkhjMzk0Ym9sSVFTQ3I3YWRubERhaUlT?=
 =?utf-8?B?dGxoTCtBWWRQUDdnRXh5R0psQXpIaDI2NEZCU3VuWTBNMCt2ZjdvYjlwdVdM?=
 =?utf-8?B?K2ZOeC93enlhRGVoNUFySVRmWHBmQ1FBWXluTEdXR3JkcG5TblVnMEVLY0NB?=
 =?utf-8?B?aWJoUG04bHdudW1yNGxlaHNzTFhGYTU3MXlVWlRyb1lTREVTNUI0ZWhuQmcz?=
 =?utf-8?B?Sk9HMVR2aFlEWUs3WHM3VGFzaVMwMXBnOW54dzhWM2x6ZTg1K1NWcEdTOWgx?=
 =?utf-8?B?RVpLSGxBd3JCTWNDeXk5MENNRWxxd0JvMVJvTDNKV3FiaUdzUXBLUjM3ZWtL?=
 =?utf-8?B?a0txeGhlYS95amF6R3FXMEp6YjFyVk1oWFRORy9mdDI5aHcwQ1ZMWkpaWHFK?=
 =?utf-8?B?MWpxSzZOSTZYMDl5UjdEOS9RSFhhQUs0NXJOSEtTQ3pBZWtQTXhqTFFWV0x2?=
 =?utf-8?B?T2xDdzdzU1V4Ym9vRVllNDA4WmhmeFFDNEF4UnNnTnBRSnBQMWtSQ3B2RGNy?=
 =?utf-8?B?Ni83RlZSN0Zzb2M2VXZBa05RUktNYzhqYWZFWWwyem12cTdoblhnRmZUa3Aw?=
 =?utf-8?B?WFdWWUNrdVhIcC9CZ0JvbFVzYURjQzVOd1JBL3E2am1GbmFCdDhkbTRjK0xV?=
 =?utf-8?B?UTdTSHdJMnVlTjJyazZ4QWltMzdHZERNcXd4RXI5dUFCMHdxUXo5Z3Y2Y3lm?=
 =?utf-8?B?bkJ0ZXdvVGU2MzQwbFlRcXFPdEdNOUlzMTNkZHl3djdLR0VZeFZqSEQ4NmpM?=
 =?utf-8?B?TGtxemwzb3FjSFNFWHhpUEFJeG5UbTRnNlRJS3NWNlZaaXpMbkxLdVlTcWJx?=
 =?utf-8?B?Q2lPUzhpZ1BQTDBRTk9lVnJTTmJsZVozZHhxNEk2b0R2Rmo1QVk4b09Td0dU?=
 =?utf-8?B?TmFqdVVVYnlCZFpwMWdqSzE1TVc3RFpWeG0xYU1sT3dENno5YVBWZmtpUzhv?=
 =?utf-8?B?bHloNWZvZ3JPa2phcCsya1UxMXJ2cXZNN1p5U3lYREh0VHRtMk1tZTdBejRE?=
 =?utf-8?B?STg4YmJsTEJxOVhBcWE1NGNJY2E3bERYRGlWc1VNUWJtUE9YWEdxbk5vbG5H?=
 =?utf-8?B?WWtsRHEweEtKbXc5OURjUHdOUlBGRHJHa0JzZmpDdnNlSEJIMFBIN1VaeElW?=
 =?utf-8?B?TktuRkllZHNZRjhhSVpaaUZQSURPZTlNY20yVEZRcktPdHZxOTNUVFB4R3Az?=
 =?utf-8?B?STZzMnZ6SDRLUTdqU01RaXVDakQzamdvTWNNa3pEcTY1bWQyaFAzV1pWUGRQ?=
 =?utf-8?B?VHZYbmQxdEVmUXUrcEZUd1pWYVQ4Ym12U0ZzZGlhTUxZR09ZYVlrd1JqTHFk?=
 =?utf-8?B?TkppMDYyTVNPMG1RNWZaV0VrNlY2V2pyQ2tIakIvTDE4bEFTTU1ybHRkTGJh?=
 =?utf-8?B?eHNMRHRKWEUySXY3WlFrNXNQWS8xcSszaG9QSmpxNjdJQTlRSHBvdjFUc1A0?=
 =?utf-8?B?Sk0wNVplWWxiUmNUNlc0dzhzMGk5byt2TWlWK1UrMllURFNzN1crOGwvU1Zv?=
 =?utf-8?B?eUxqSERVQUlwdVZyWmNHeEZrNXR0Y0NtcjZER0JrYzJzNENhRURNbzQ5Y21z?=
 =?utf-8?B?SnZpUDRXK24yUkJaaXZXZEpUcHN1YlFGVHY4Y1BLMUJZakNLeGNOZlZQNlpi?=
 =?utf-8?B?a3Q3dGZWazJ1Q3F3dUpVU1FJZDdPVEVUN0RtdjVPM29tNjJHUlJqT05jb3M4?=
 =?utf-8?B?SkFtaExZTVdpZVp2RHFld0FiRUNmdjdLa2RoNmpiWC96NHI4aEUrSldibFhI?=
 =?utf-8?B?bmh6b2dEVy9hL05zczlBcHdDeVJXbzFBbzFlSFJUNmJudlkzTXpmZ3BNRGpj?=
 =?utf-8?B?N3FZWERONW5iN0lMOWtVWjd5ZVR1UlJBclBZRDZjVXc3N21vVU5YaSt5dnVS?=
 =?utf-8?B?clMvdlpEU29NVTc2dlNRQ05NdU9FcEU0SmpzRjFRVW5NS21TeHJoUHQ0NlVq?=
 =?utf-8?B?bFQ0S3R3SU5mQW00Z1B0a2JtVFFaM0dYUE1yeitFYXRrM09nYjdSOHU0bUlk?=
 =?utf-8?B?Z3BNYzdYWVFYeDMzLzIvc0kxTFQ4eityS3I0SENxS3lFS2ZCRXhmaTZ5Tmh3?=
 =?utf-8?B?Nk9FVDIvV3NrOW9VRUQrR1FXQ1JwOVE0NXNtb3RVa1loaGFFb0FYTFQrWmVo?=
 =?utf-8?Q?Y4v3xpMB5NdPRvumw6RgB7SjB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffcd19a-8a11-444a-d757-08de261e2129
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 21:13:18.2156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwfheuMBfycmYMxSocIiIo1U5PqrV4fjz8HN/A2zffsTyy+p5+0tHjyE5lmNpww5GVRBw6XxiqLCHIwv9ylB2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6309

On 11/17/25 1:02 PM, Miguel Ojeda wrote:
> On Mon, Nov 17, 2025 at 9:07 AM Miguel Ojeda <ojeda@kernel.org> wrote:
>>
>> Examples (i.e. doctests) may want to use names such as `foo`, thus the
>> `clippy::disallowed_names` lint gets in the way.
>>
>> Thus allow it for all doctests.
>>
>> In addition, remove it from the existing `expect`s we have in a few
>> doctests.
>>
>> This does not mean that we should stop trying to find good names for
>> our examples, though.
>>
>> Suggested-by: Alice Ryhl <aliceryhl@google.com>
>> Link: https://lore.kernel.org/rust-for-linux/aRHSLChi5HYXW4-9@google.com/
>> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> 
> Applied to `rust-next` -- thanks everyone!
> 

Is rust-next a rebasing branch? I was going to request a non-empty commit
body, in order to make it more immediately clear what this does. Something
like:

The current set of disallowed names is inherited from clippy's defaults [1],
which are "foo", "baz", and "quux". This may be extended via .clipy.toml,
which so far has no entries for disallowed names.

thanks,
-- 
John Hubbard


