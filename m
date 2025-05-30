Return-Path: <linux-kselftest+bounces-34082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D73AC94AA
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 19:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE044E8A8A
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 17:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7913B2367C1;
	Fri, 30 May 2025 17:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZOoAy46m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8732367B5;
	Fri, 30 May 2025 17:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748625967; cv=fail; b=qetFJqhOY0BZnPPBSMbxju9o100GMUt+FhyyNXdF1SgV004shxScXGxD4ofPu2FnrSzRjJMXbMuZ+oQigzdg0RUCbl8mEddFEv9LftM0en8i9MoPRQbrAy5N5mrx+6ZVKG+cHsA9P/rfExw1RU5pSJB8/FaAGQBEZKc2v0pjr2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748625967; c=relaxed/simple;
	bh=1+p/nrRf7xk6pn7b6xfHQRWWV57NDVc1hGlAuiPXrOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KHmXe78u6msJ5qE2ei1w62NmxC3BNsDlmEv6MC9Au3sZKudt6uqH9K6htczE5U4pLDQfwxQgeDXHMu/Y8l/RlFbV53NYxo0n/LaFx3Ck0qN//aHG4FTASFK9y50Etf5MEkBhhQcoYVuWzQhub3+m77GbUHu+CUQiSJ6+K9JY3YI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZOoAy46m; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIsGVIA4ZENfGowo+iZLlqURjMiVVXijxuqaaJgNxdt3Z98fjVYdVAGalxypOvVB6p9+i0cLKmPj03saaowk0eAE3LMA0d3vOeNRN5K8h2b1h7H3XUQnDQ0ctHqpspZfh3sYOIGbz06bROU+jm/ufysm6RuIFpvWnuPO8ZNM2Ln3++avLPbgFJxTVi9mhh//ClL0lbEyOeZZ7zQZh9Y53AaDN9bwv7idvl2AlZCWREXyQ/v8lg7CzdwEc0h48DICmOHyLwygez0jyrZgycXAnhcE6KvARenzwadLSCK0GR2bjOV87UdIwPjTmJDRd3trCDsXwZOGOeT3J1MgUZB8Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmSjRZEG9NiRQbdh5HrWosxczroXQBmYyr3sHwzUP6w=;
 b=KYFRuBQIHmI5n+NxMsK0wrVwHgrTP7gR1wbOwSIgyeidM5StGZ219JIApBsjlMsueOLN9Or+t0MmfNjtdom4FfyDXxkScCIbViKcE9olewNYQtxhTEZplWaswQUZng0u7CDtmNRtvzJzxuKIF60AbfNQNoxNuTm4zzHpGKw9vo962auunWkEqUftrP5a0cKvUtxk9PkLMehX17B14sFRaVT55CNX9M6G6UPShAd9HhfbKZ2dDuWkW4khSnGdgS7gOlU2SSKjIca4dnP8NTAmeeRirIdyPOe/iCCZnlnNeWX4+KhvaHL97IXhRSONs37Z1mccrR8E8N1sdT07sJaHig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmSjRZEG9NiRQbdh5HrWosxczroXQBmYyr3sHwzUP6w=;
 b=ZOoAy46m4iAJCyQh3CPyti4Vo670JDYUB+6Dk15DJ3rL0dtzXARanWN5tYggJU9dxyeXZkZUKfJC0CUH2zb/oLErsA5H6F9mPBI5Cq2/yLZCCg/Ipm2POJV6cdNwWUr1pQxj1plwcdwKIYASNcscaop5nvDmfjzguOe+DQEwc78jGSmK4eCCUsrBcVMybt9Xxt1EmxfuY5CXAbeoGBAebnP+O2KJREZGotdGMGwmxcV4GE8bZftdfzSuX0zEkzBVBZyZ/NxiA9rPHwMPD9RdSpD6x+Cvxl+cjODmNqUcWwPc7/gsGbO0Cvyf53vWnpsF9KqTwRRg8PtYBVb2khrdtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB9396.namprd12.prod.outlook.com (2603:10b6:610:1d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Fri, 30 May
 2025 17:26:00 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 17:26:00 +0000
Date: Fri, 30 May 2025 14:25:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Vinod Koul <vkoul@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	WangYuli <wangyuli@uniontech.com>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Auger <eric.auger@redhat.com>, Josh Hilke <jrhilke@google.com>,
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>,
	Vipin Sharma <vipinsh@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 07/33] vfio: selftests: Use command line to set
 hugepage size for DMA mapping test
Message-ID: <20250530172559.GQ233377@nvidia.com>
References: <20250523233018.1702151-1-dmatlack@google.com>
 <20250523233018.1702151-8-dmatlack@google.com>
 <20250526171501.GE61950@nvidia.com>
 <CALzav=fxvZNY=nBhDKZP=MGEDx5iGqCi-noDRo3q7eENJ5XBWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=fxvZNY=nBhDKZP=MGEDx5iGqCi-noDRo3q7eENJ5XBWw@mail.gmail.com>
X-ClientProxiedBy: BN9PR03CA0365.namprd03.prod.outlook.com
 (2603:10b6:408:f7::10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB9396:EE_
X-MS-Office365-Filtering-Correlation-Id: cf547fb0-4baa-4339-4afe-08dd9f9f0bb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3FIcnRJZ0tvdmlWaGRpWTlCS2xMYi9ORm91YTgydjQ4S0x1SHBkVnhNdk5I?=
 =?utf-8?B?eWZlWmN2Y3prdlAyUmc4OWwraTh4SUtYNlo2dFJ4aG9aZDRLSFlzYmszOVlB?=
 =?utf-8?B?cUtQR3dMcnNRSU5JRHpCa3NSakp0d1pvbUhRMGIrUkUzKys5K0ltTjZWRnZR?=
 =?utf-8?B?RHNHYTUxR1cwS3ZobzE0ZlNTOTg5OEhRbmZ4NzIvTyt1eW9YbUgvY2NMZFlH?=
 =?utf-8?B?WlBxaklQVGVGUWJwTEh6UmR6MnY4RzVhaWdoUzNaQXEwNVRBQkIzM2FiaENF?=
 =?utf-8?B?Rk9hRkFaMVJwMUVHYzVLb2M0ejRwdkpMRDA4WXFJZWtMTGxFU2k2RUdzbTFn?=
 =?utf-8?B?TXBKMnpqQVBJQUFxcVROcEFsM2lQOWJxQm9hdUNWc1BrblViaEdtbi9aY0xl?=
 =?utf-8?B?dlVJYTF1K05RakVxdVlONHhKUFl3Q0FpbHpwYTkxSWsvZzhZRDhPUlp4V29w?=
 =?utf-8?B?RWpnbjAyU2x3TFRXL29lSytwSzk1dER5Wk9jTFA2U0k0c1RFNGhMRG10SjFs?=
 =?utf-8?B?R1o3SGhwSlFaUzZjcUcxKzRudWJsZHAzSi9PUncrRVRGM3V4Ukd5RXFzV0k5?=
 =?utf-8?B?MWJvd3o5Z0ozbFFaRFNiMlExOFNhWnFuK1MwVkZnMFN6M2xTUXNXN3huaita?=
 =?utf-8?B?bm5YeHMwc2FjeUdMY3pCaTVCcjc3QUE3YVJwcGl1QlhFNk1oaFBKVmJRVlV2?=
 =?utf-8?B?cE5Uek5mbGxaTXZ1dVJqejhFaDJSSEtFTDBjNHdZZDN6N2xaYjVKUExYQVdC?=
 =?utf-8?B?L2hEUTBwYm5jWnpiaTlMWkpYMTNUem5BK3FURVZtbXpLV1lKbzdCRkl3NHBU?=
 =?utf-8?B?cjZSZnp4RHVGbmRTS0dMOGw2aElBR3ZEN3J1Vy9BeU1yWFZ3RnlhZ0crNlBN?=
 =?utf-8?B?OW5DUjh0TWw1RXBTQUtDNWFpak9GZUNXVzlMK1ZjdmVqQnVkQzNOaWFrd3Fl?=
 =?utf-8?B?eU1TbVIyODhaQjEyU3BoWkdERDhLVXd6TDVXNThubWxDd3NLekU5OUhXMmts?=
 =?utf-8?B?eXNueHJPajE2OGRIVFZBbHFpTmNuZXpSMU1NSEt2MTJxOVVFOUVyTWpnQ05N?=
 =?utf-8?B?MmMrdk5HVGk2NStaejJ6ekRFaUgwWTZ0eWNvd3FHQkhYSG5ENDI0UzA0bnVr?=
 =?utf-8?B?bUZGNEtVUFdVNU9JUmQxNW9tTjdxUUE3Wko3bTZrZTc1eEM0MmVmZU1pVnd3?=
 =?utf-8?B?eGRuTzN3QXAzeUdzeGtoUU8vTWhJbjA1NVBFRkM0Y01tdkZUVnJpQ3BVKzY4?=
 =?utf-8?B?dnV5RFFWRnpIMjRjeVVleWI2R0h0UEZUQ25DMnNCQUJVQjQyQ1NPTTZTdTZZ?=
 =?utf-8?B?OU5VWEFNTWJQZlBWSC82Ri8zUkQxcTQvVGhmSzBJSS9TbkY2S1ZUdE9TN2F1?=
 =?utf-8?B?eGhCMkluR2srN0JHdUZTRjlKaURIY0lPRGFVQ1NEQkZldEdBbDMxSnpOaHlX?=
 =?utf-8?B?RmRwa29PNkNRV3pLNWY3cHIvRG9GSnJzWTdQTnBJdGxNVTd3NjROaHpiQ2lY?=
 =?utf-8?B?b3AwU3ZxUElMM05SNFVseGFZMER4NThsL0tWbm5oQ0RXRkpSZFl4WWdOeHYr?=
 =?utf-8?B?YmZTcFQvSkRIR3FkR3VZMUYwNEE0TW0xWW14MHpMb2ZhN0dTM1d5R0Q3UjVo?=
 =?utf-8?B?QVdYU3JpVm12QitGbDNMZ1pYOThWZU9kK0k4SnJmWXRjUUNKTVJUUVlkU3dq?=
 =?utf-8?B?NGE3dTVuMlNHNFdUQndON3ZXVzFmWkE1T0tYNUZlRGVrMkpobE9GdjJZMHJq?=
 =?utf-8?B?ZGQ0N28vWTEwM3JXMmtUYTlOZnBtSkYzWkQ2c3oxRENYOVdmWURDbWxIdHRR?=
 =?utf-8?B?bDJiZkM4WGZZcXE5RVlOWWFWTXdBR2RCSkRLOWZ5RUxIU3ppS1B6aFBwU0N2?=
 =?utf-8?B?Q2xuOS81V3p0Q2hwWkd4UlZ5dGVhVVVFUFI2anZKeTdwU0tVanpKb0d4OU9l?=
 =?utf-8?Q?lhecJDwnQ4Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGVoK1Qycm9LR091VjErdGJRQUE3TWgydUJMbE0zYU9odS9STTF1YkY1bzlR?=
 =?utf-8?B?VEU2RGkxdkRjU1BWYzhubHJtdE9kcXpiRkVSR2VJZlBrNnIvNi9wc2tGLzhZ?=
 =?utf-8?B?OGxlUlFjNUJ3SktUM3VYVkZhTTd5OGJZN1pkV2dvbHF3RXlYN2ZENVhYSnF2?=
 =?utf-8?B?ZzNVZTBBcTQrcStlanNQV3NhTUxyWjZrbFpwazEzVHkyZjhHaEZNYmR3eHB5?=
 =?utf-8?B?T1RmZ3Q3cnBDRE9QTUcxaHJGSmdMYVpwWGRWRGhqcnFSRDFUMFp3Q0lYTmw2?=
 =?utf-8?B?Nk5ZaThxcEEvTGhGS2FBTUw0ekh5SXJuVGxvd2ZoUGQyc3RFQ3FLYnhEYmcw?=
 =?utf-8?B?ajA5aWZKNnUwT1dpYXAvUG5CN2FEQ3N3bmFUS0FiMUkySVZhNGhNOU5hd1BF?=
 =?utf-8?B?dE9YaUlpamNZMXBJTlNOdmI3S3RkSTVXZEVaUnhpRU1iYVhNOFJpWVpVYmI4?=
 =?utf-8?B?OGlEbnJxRE1BNnNrWVVkTTdjdGNZZkhubEd1dXVIdllVL2VSYjZ2UWpjMnlY?=
 =?utf-8?B?ek50TDU4akxDOGIvZTNZTWUvOUdOUEtHckFCaVRaVHdkRi9mQy8rUEJRNFVh?=
 =?utf-8?B?ZFZ5ejJiNnk3eEVzWmhKMTg5UmsxMjc5UEtFbytuNWJscHdkbkxZUVovMlRj?=
 =?utf-8?B?Y2RjNk9SckhiclN4V01NUHE2UUJyRkxFTjlmczYwRGcxYTVQRFZvV21yNHJz?=
 =?utf-8?B?MkZiemJLNmx1WUNsRi9vWmVQSHVQVWdWUXZoNUdLSWI3bEp5amQxZFVoRnEv?=
 =?utf-8?B?RExJWXhzejlpUjBoeVl4LzYzT2ZEZm5DQldEL0trMG9XaW9xWkhSZkpBN3NK?=
 =?utf-8?B?Sml6OE5sNFY5OVg4WVd6U3ZacFpoclk3RWp2UnhqNlRVQjUyV3FvNWEwSElt?=
 =?utf-8?B?WUcvRVV2Q25wMksxTDhHcldJd3hxMWhLMlg4VzVzejVSRGRuenZmV3QyZ0lt?=
 =?utf-8?B?VFRKdmZBdW41a2FKZUIwSWt0NWgwWGJvN3U3S25TWHVkUGp6S25YaWNoNjZk?=
 =?utf-8?B?bG9yY2U1ZWZucW5aVlFQZkdlQ0NnTWVXUm1iL3phbmhYVXVCejhYaXR0M2RS?=
 =?utf-8?B?YTIvMStDUjJuSWh0bVFVWi9SM0ZnM1U1OStSSURQTzFIcVB3UWlVdFEvOE5r?=
 =?utf-8?B?S2JNSU1rRUVZR01tbGJENjJxVGpEUElORGc0YzNTQzMzK0g4Q0tYcjdmMTRl?=
 =?utf-8?B?V1V1MU9NVU44SXJnZXNHYzJra1hnc3Q0cE1kMkQ4SlJZWDMvZEdwRTl4TG8z?=
 =?utf-8?B?Nzc5R0ZhSkw0Q210bXBuaUNwQzU3Y3ZVSDdVVWN2QnBwQlVCZkNzOXhYNzJS?=
 =?utf-8?B?ME9ERzI2dTJBeFlOK3M3RDF5aXlrU1p6QVZXSjV0WXJucm1PS1ZmclRGMGRI?=
 =?utf-8?B?SEg4cHNkWW4vMmZ4bnRLS0xocmJCOVBhVnE5eVdaUmt6ZU5PbFpVRFZ0ZW1s?=
 =?utf-8?B?TXVrL3YrRW9PeGw4aEMyWUsxT0F0NkNQb29HckFxcHFqVFpJQkU1dm1iOTRC?=
 =?utf-8?B?c2RPVmIxeFdKODZLWFYyVlVYK2NGQWdhMzVBZThKSkJCYTRLODhjSURmc0Ey?=
 =?utf-8?B?Z2EzOTBWNi9aYnJ4VWFaenJNWWtJbW9KdURQcmFuQVZVMmJOdlZPbjFINGF6?=
 =?utf-8?B?Ly9oSXFYMzk2bEJDU0RyUDF1UEFQUEw1bW9ORlNmeVdYRU5sNWdLTlRRckxa?=
 =?utf-8?B?Q0tENFpFUGwrUW80ZThqYVROMGp6NVJiemJPS2tFamJRVVF4OFhGemMwdEFn?=
 =?utf-8?B?M3ZWcDhvL0RCQ3ZWNThPMmFyR3dqdHo4KzdWazhVRlcvbEdzUUpGakYvV3NJ?=
 =?utf-8?B?TWxScmJHeEU0OEJodjllNmRPYmtIUWtRTDk4VjRiRzl4ZHJPVWVaa1NoYVQy?=
 =?utf-8?B?Q2J5dUdsUXI2cHp5WE5NcHcvTWxsdVUvWUJZQkNMcUVTYXRXRjd1RmdDWkEz?=
 =?utf-8?B?Uk03dUNMdXlTazVPKzV5U3VYV0xiRWlaNk1qTkxPaTNqcjhPQ2x2bUs0T1Zz?=
 =?utf-8?B?STFFb1cyMHUvSDFsT0V5eFhNVjYvSVlHZm9jalhGR20yQkZhNW12UGdTWmd2?=
 =?utf-8?B?bTVNNDNvMXRzMVVoU2JxWVQ5eXBiWWwweFdubEFjYmFKUUxkdzFUZC9wS1o0?=
 =?utf-8?Q?tor+2GaUAv3BTjdSEySliZsul?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf547fb0-4baa-4339-4afe-08dd9f9f0bb4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 17:26:00.3159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: je5IP6rih9Z1Fj7ZXL32m89vcVisLfGl2yRCJsU5r2NiVqasz8yeh4HtiHP48Fug
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9396

On Fri, May 30, 2025 at 09:50:22AM -0700, David Matlack wrote:
> On Mon, May 26, 2025 at 10:15 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Fri, May 23, 2025 at 11:29:52PM +0000, David Matlack wrote:
> > > From: Josh Hilke <jrhilke@google.com>
> > >
> > > Add a command line arg to vfio_dma_mapping_test to choose the size of
> > > page which is mapped in VFIO.
> >
> > This doesn't seem right..
> >
> > Tests should run automously, test all possible sizes using a fixture.
> 
> This test uses a fixture already. I assume you're referring to
> FIXTURE_VARIANT()?

Yes


> I'll explore doing this. For a single dimension this looks possible.
> But for multiple dimensions (e.g. cross product of iommu_mode and
> backing_src) I don't see a clear way to do it. But that's just after a
> cursory look.

Explicitly list all the combinations with macros?

Enhance the userspace tests allow code to generate the
variants? Kernel tests can do this:

/**
 * KUNIT_CASE_PARAM - A helper for creation a parameterized &struct kunit_case
 *
 * @test_name: a reference to a test case function.
 * @gen_params: a reference to a parameter generator function.
 *
 * The generator function::
 *
 *	const void* gen_params(const void *prev, char *desc)
 *
 * is used to lazily generate a series of arbitrarily typed values that fit into
 * a void*. The argument @prev is the previously returned value, which should be
 * used to derive the next value; @prev is set to NULL on the initial generator
 * call. When no more values are available, the generator must return NULL.
 * Optionally write a string into @desc (size of KUNIT_PARAM_DESC_SIZE)
 * describing the parameter.
 */
#define KUNIT_CASE_PARAM(test_name, gen_params)			\
		{ .run_case = test_name, .name = #test_name,	\
		  .generate_params = gen_params, .module_name = KBUILD_MODNAME}

> For context, the pattern of passing in test configuration via flags
> rather than automatically testing all combinations is something
> inherited from KVM selftests. That's the common pattern there. There's
> some work happening there to encode configurations at a higher level
> using testcase files and a runner [1].

IMHO it is not good, it should be done with fixtures and variants
slicing the test by matching the test fixture/name/etc.

It doesn't really make sense to have a C test runner that you have to
invoke from bash just because the C stuff is not very good..

>  - The library needs to know which device to use. In this RFC that
> works by the user passing in BDF as a positional argument to each
> test.

I'd probably say it should scan the available vfio devices and pick
the first that it understands how to use. Command line would be an
option.

>  - For tests that use HugeTLB (like this one), the test requires the
> user to have already allocated HugeTLB memory for it to use.

Other tests do this already, like the iommufd test assumes it can get
hugetlb mmaps. Skip the tests on allocation failure is the best I
think you can do.

It would be nice to have test metadata so a runner frame work could
know to provide this stuff in the environment.

Jason

