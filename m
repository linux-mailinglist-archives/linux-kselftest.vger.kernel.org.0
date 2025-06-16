Return-Path: <linux-kselftest+bounces-35112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5992DADB6DC
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B361892132
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E228E2877EB;
	Mon, 16 Jun 2025 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jaVZo4YW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8C11B4231;
	Mon, 16 Jun 2025 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750091231; cv=fail; b=a1YoegpHV9SkqUGONhr9cl+o4/I2nmRuUPTX6drKl1avm0EfWcRAIq5Y9HKp5gRHbutYrW1eEWYez9/hAZqGvBVOuuai9WMaRDrab2KQEWxs/0HHyir1H6wiFxhskYec2hnpOyfMYH0y2nQ7L8HY7Db+z8XHvoWMIVvS9EC/WOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750091231; c=relaxed/simple;
	bh=FC3gj12hGkOwWmysKtVB+mBZHzqMdJ3epz9nvuUP7DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R37wK5faUhEoRztLVYS17ab1cWN2xUyKu4ukSRh9I5mfNaGxIr2dF3IrrTGFbNkQ49Dlbd5HzN6lQVNAsqU6NFOghSkDqnzQ1mi+r8gfZ1YiZCUyFKOHDh/poLyS/mZRDZWZjV7i0k9SXiALRRCGAyugq6qxcy1M0bW3rOkSCCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jaVZo4YW; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nV7yfKcy5YnAiBgOekrre0s5cdXG2eK5XPU+639ABbPDNAnL9WyiMWRWZlg+l2NnovXRTvHpARGbzZxscaAKgdA2YndCYUER04AyBZ9F/a4FxzZxTy137O//26fIz1sx73l6aSGIfIQmUGAmL+sQJbawbfZuq8O145FILVl3zhXnwDKYlW+sGKxZkXj4YReVjzdCYvkgaToMGAJvbJYz8k5z5z7IJuVKtMSv6L7L9KN8KbJiA7S55Ng5hJHkfmlbtt1wSs18evHLiiEQ+MbKuJEbmc3JFfZTcE9h5VKZyHlozJFTubGigtJFirjRo3G/Y2+LFQLif8eKGNBlAJ4a1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U42iEVmyE/4ruPsSPIJ6g2XEVg/oLS0yUSZDQdvl23g=;
 b=TMPvSEMQRCx/O8K4D3HHvkleWU8I92UIzC55Lf/o7DepxUIJW0zNzGbKmPI10Hra9h/MTj+NBiiyziD/0ksDb6PQFbtLRh4naqQaW/BAsqlzGk0C9kf2Hx/Cfv15tOWPQHxXWbL8IjDdrBczOUnc7u7QZ4FT5GHaG0scedkELssJufqF7qJJYhvkZaiv6pAAaIDPzptgTFqLHlI57BdMwC+s81riVKF7ckHXOnz6JkQ/1onk9GdnnbjCIhZiUXP7obwLCTzKEYLPU6rRpOq+XYJEE2hEVH2JWabQnA3F6HwXSclhBB4DOaqcc+MnqjAgacJf8OfX6GPUvdfZn31BPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U42iEVmyE/4ruPsSPIJ6g2XEVg/oLS0yUSZDQdvl23g=;
 b=jaVZo4YWDiPn1DQWspKYqdcJQsbtLrAri0wB+bntILw6EyJ1/F1aOcFwwYo+SBZFu+5dWBFxCznyKwPxB4mKa0QPmCo+eZpKYb9YfPgViiE1uB7kUcM09n8fjw+n85Ck+R9VXqfY0zD7joozasdHeiUSWphuX5weNxCmvjhP1H7EOz4VOOEdNM2mFAW+e36ZBfv0qbJn/Wwvt9XKEm617VDDlOAhFHCrmsc/sD/S7s2Aohxnd6Bg8+Zf7/jWgSA+celVBz8sAWJ/uVhw22kGfEZapcSKH7mmavxbjBjvlMhjomqGbMrzbGwd1jYUchWpwm79NAVoEWVyYWWB2MsmiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 16:27:06 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 16:27:04 +0000
Date: Mon, 16 Jun 2025 13:27:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, shuah@kernel.org, joao.m.martins@oracle.com,
	steven.sistare@oracle.com, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.weissschuh@linutronix.de
Subject: Re: [PATCH rc 4/4] iommufd/selftest: Fix build warnings due to
 uninitialized mfd
Message-ID: <20250616162702.GQ1174925@nvidia.com>
References: <cover.1750049883.git.nicolinc@nvidia.com>
 <be226e78fd581585c22c6c7f33c14bfe4a0c3ef4.1750049883.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be226e78fd581585c22c6c7f33c14bfe4a0c3ef4.1750049883.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YT4P288CA0003.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::11) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c9d354a-8a71-45f8-fc58-08ddacf2a0d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1QzdmZ0WTFUUGlnM1dsQzBPT2k4a2tuSnNSZ3djYzc2SThxSXVvNDR0SFlq?=
 =?utf-8?B?cHlSWFNRL01RSDZWc2hIck9YTENJUk13NzFFNjMvSlovZURxeGNPZXJ3WkI5?=
 =?utf-8?B?VmRMVnVtV0dGLzFyR20ySjByWW5DaDdzVjJTZjdQOEhtSStLN0RONHJja0Z5?=
 =?utf-8?B?L2pJSGxzeVpzR1Fyc1NiVURVbEd2NkY1TUJoWnlKRW55cXNpRHNnemUvYVpJ?=
 =?utf-8?B?WjhTbUVsRFBKWk9mZkMxNTcwVUZvQjU2QjlUbkh5OVJMQUlWZFhHeERGMW9O?=
 =?utf-8?B?Mk9KbFR6Z0ZSSUpjKy8xOGRFWmMvV28zNjdua2JkQnp2Qzd0S005QmVnRHc4?=
 =?utf-8?B?dURSaGVpNlhDVXF0b0JzUHJCeGZmZHAvNWR6K1RxMWVqVERKQzFaYy9PeHpV?=
 =?utf-8?B?SnRLVlJIM29NZW0vMTRXOTBQMldtUm9HQW5wNkdEU0dIeU96cmxkQkZDTkVX?=
 =?utf-8?B?MlJiYW5IaGoraGxpMU4xL0RlSFA5YXdiWGJXS09sWVlNcGJGNlZGcUUzK2xs?=
 =?utf-8?B?UmRBTUxQS0hjSzJDY1pUUG1NVXhpbVJvS0s5LzViYXpQTGxBMDJjYjIzQm4z?=
 =?utf-8?B?UFVyamFQUU5EcS9XV3ppNkFMS0hoTFlPZWVBR0hYN0NvWGRRc0dFcm9DQ050?=
 =?utf-8?B?UG9RcTduVzhBalFKL00ydUV1dVFwNnc4Q1B5NmhGcS85UFlIYnJhQ2QrS0tm?=
 =?utf-8?B?SFNGbi9BYnhaNlpBNW5oWFBjQ0x2QlYyT0NyYUdxZHNEK1JFWUhhQ0cxNUQ4?=
 =?utf-8?B?Z3RVY1NTQ3M0VnZxTnZ6NldOQUc4Q3o2Q2dvcEQrRkIrZGczc05kRG5EbEdI?=
 =?utf-8?B?TFVyakRtMUJJNmtVZHZlOWZzVXcya2pQVFJ2c0ZNZHNDMlN3UThMbXI1OXcz?=
 =?utf-8?B?N0FiZytST2kzY0F5NlVHK0NqU1UwdVo1aGJrTSs4aStlMWpTU20zY21hYlRU?=
 =?utf-8?B?SWM1cHBRbHdLZGJkYnFOMVhrb1lXVWtlL01QczZsYjcrbFR3UG9KZ0piWWR5?=
 =?utf-8?B?MWo5eXZSdllqRERtK0pHcmhtem9WNWF6ZXVPMHU3S29FUUJXTVVEQlpISXFa?=
 =?utf-8?B?dHlwNFErZDFIZmd5bi8xNlowQ0dITm54Q1NPMU1DY2xmM3J6QnhtbFMydW43?=
 =?utf-8?B?aVNZZ3VhWHNiTFRpbktLanZQL3RjaUo0T0xIRHhMbzBYWVBIcDhUME5xU0JP?=
 =?utf-8?B?TitYZ2NzbFRKa0dQU1JWTzlzZURPMWo5Ymh5c0F0d2RMREx4TGFGK1ZZU0d4?=
 =?utf-8?B?V0V2OEszakZ1YlZselg2ZVFMRldIaHRwdCsvTElWc1h4bEowdjhEWElBOUJk?=
 =?utf-8?B?MTI1T3BsSU5RaGUwRFc3SXUzNWFWVDNaMjNKcm1ycWhWZ3BLV3J2ZGEvOE9X?=
 =?utf-8?B?a21iRm5HazZiNnVSTVBtZDdXK3pJSncvblM0a0NpQXZCNWszRUNVS2lmNW5R?=
 =?utf-8?B?bHRxNGFPdnNRTHNmTkE4Vm9zZmg0cjh4aDdjVUdTb29wbWU1SlhFamlYSUZN?=
 =?utf-8?B?dXNBZ1lKOWNjSjUwUGNoa0pVamtRU0ZUcldyQjIyK3dEYzJFaDhabDBWRjJz?=
 =?utf-8?B?R3JDNXBLNkQ0RGdaeENzTzBRWndva2dYcmE5MUNCNC9qWGw1dkhJbjZ4bEhI?=
 =?utf-8?B?K1VpUnRhcldBN0NZUjJwSk5RdWs2cy9JQ1htMzBtdHRibnFycE9hQVZzWTla?=
 =?utf-8?B?MmFTdXc2SnVTL0lRbGZERkZQOVkzQzhFSDBSRmlQbmZTSE14SUpQMk5TL1E3?=
 =?utf-8?B?Y2pUaXhLRDFpdUtEMndEZE5rdDZtWlREWWZBaW1CU0t4cW45Mis4dW9wUWc1?=
 =?utf-8?B?NjNEdUpFT09CZkVLMVhIQWN0R09tWFhPb3FFcU9DSFc3UFlXRHJmUlBXbHNH?=
 =?utf-8?B?WVp5ZTJ1NWxYQXZwYWRCTmgxWWQzSGplaUU0SFBwRlhKRGY0aVUwT3lpd28z?=
 =?utf-8?Q?Ak1Ig/iZaAw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUVYaGJqenl1SU96NE1IdExLa05xN3FNS2J4SlVBUDB1SlNyMW5iUlhCUTNq?=
 =?utf-8?B?VFZlMHZ5dHg4YmxpdWMrTVM4RFBBL0FMMG1kUm1RRTl4NExoTFQxSUlRM0s1?=
 =?utf-8?B?aStwWWo2eFJldmt1Q1E1Q0t2ZnNQdE5xaWpLTmVWeVVDV3g0bjArbXlScnBX?=
 =?utf-8?B?Wkhwb3JiNjgraUE3bkg3WndrMlVsQWMrdU9YaGxHbWlPcXJZYzd3QUl3RnV5?=
 =?utf-8?B?aFdoOHJEellleDB3aU9kbkdNY0NoNjFCSE9vQmJlWkV1SC8waGUxdVRqVE52?=
 =?utf-8?B?RHVnVlBKaEFMcU5xck5rYlJmVlZzZHMzRU5KSFZuNlNqV29SZnpwbFNTblRZ?=
 =?utf-8?B?cC9tNGxXRnNpRHdjSjZpWW9FL3FKNUlDdDJPQ0lpOHhDRjNDNUlhd2dBNHhW?=
 =?utf-8?B?dW50bEpCTXdaRjZma0NsOVlzV2N0cU5XRFZyTTNTam9rNUZ1cFVaU2gwN0pS?=
 =?utf-8?B?WFQ0UUxGNkVNOVlPTGQ0VUxpd0hjZGtBaG9rVDN1RjdqODJWTVRLNWxjTTFz?=
 =?utf-8?B?WmhPbXRtNTkyN2FPcHpkYzBiSDhNOWtXRS8xQ0dQd3BkQ25KYXdRazEwMXQw?=
 =?utf-8?B?dmRBVFRSY2RHUjl6RWhScXdRSTZCZkV2czV2N09FWDg4bmhzY2JuUTMzUS82?=
 =?utf-8?B?Q2llUFBLbzQrMmJhRlJ3c01uaEdDVVJPOE9xR2RPcUhSQ0twS0tOOWlZYm5O?=
 =?utf-8?B?ZnpncFpzSnYzTXR5a2x4WGhpRFVqY3RNRHJ5dTlhZncvSG5PbTZ3VHN4VVBX?=
 =?utf-8?B?ZWExMWw4a2VUM0ZYMEUzMHNUY0xlMHVCbFM1TVlIVWlZd0VSd3dFN2YwNEJG?=
 =?utf-8?B?dVdSU3lETTcvNThOVXNPTHQzSXBrU1pMcENyT1BCay9pdHlxc0VvK0h2WXNJ?=
 =?utf-8?B?ZENpbUhOQ1R3S3dWUmRKOHhjcFAvcFYvNm1rU1ZISWwzWjQwOGdzUjduemg2?=
 =?utf-8?B?cHI3dURJVHdlYllKdGFQazBWMnpFRkQ4OEVFa1RrbkRxU3laamRQaEZDOGUx?=
 =?utf-8?B?UFozVDc3TFpzK3k1ZDZLT1hkbUpYWTlCMmlPTkhETkpZeHFiM3RXc1ZjWGhL?=
 =?utf-8?B?N1FSbWNkZ1ZJbjR2d28rcFhKTTMvUzg1enRSZ1hDc3UzQzBTS1R0aG5iOGRw?=
 =?utf-8?B?T1dBaVpDYXJ0ZS9TbEUzbDhoc2dSWkRlNWs5dUdZWWRWV0lYbU9hMzlnL21P?=
 =?utf-8?B?MGpRdzhnbElaeUdTVFM1NUJ1WFdtZVVMaC8wWGZIM2k2d0pEMXRwTmZVTjJ2?=
 =?utf-8?B?V2JRN3UrcEZNNUNGd1BVUFRrU21qVllBV29PbDU1VmhFV0xDeGR4R0J2VFVE?=
 =?utf-8?B?c3grSTA1QWhwamdybUJqZTdEYW9BNGllMWpwWEVXWWVhV05FU1JWeWt1Y25I?=
 =?utf-8?B?NUtVaUw5elNYYWd3NmhzRExzSWlsV0FVTmFaMEMxOGJpV1lNaHJNbVRSY0E4?=
 =?utf-8?B?MnJCZXVFOHluZTVJZEdhOXl1Tm9QRCtyUlQrMHJzLytHRU1iODlXVWkxQzRy?=
 =?utf-8?B?c015WXNXT0NzL2gwbm5BVG5DK2tKUmVPOUNzRWhTUWE3aFFhWUgwN0t0NElL?=
 =?utf-8?B?RW5WREtTTUE5dTFKWXBtOU9HbkpqWWRQczNTYXNVMkZlT1QxTnRTUWNZaWpP?=
 =?utf-8?B?c3BrU2tCNVVySmx1QnQ0SUZuUGwxaStBNzhJckMxWEc0U0svWkJ0Ky9LaSsx?=
 =?utf-8?B?REZXak41Y0YwQlRMSkVRUFl1ZnNlenY0YVhVUW43bVM5WVdUL3VNMXg0OWlo?=
 =?utf-8?B?OWdCNUhIK0JpNXhEZCsrTC9mVzFVZ0U5d1ltNXkvVnZlZE5vdkxNZ1czVFY1?=
 =?utf-8?B?blBmVis3dDQ5VzVqMHdhNHh6SVdLKzJmWjVkK0pEQnlvTDFCWGVoV0JMYjlj?=
 =?utf-8?B?R0Mvai9XNnFTVEZBR1VvWVJaZUlvQW1tQXlYYkZzeHJrVEg2dW9JWE91dnBz?=
 =?utf-8?B?VnhNWFFhYzhraXl6eDNuYm85UTNJbHNBbU9WT0tjR1Y2N3RBdkQ1Y0dVL3ZH?=
 =?utf-8?B?MVozQ0FmR2ZoOVBraWVMeW42YUkxMGVwazFwNWtvYVA1UlJhTzZYdXhFV2pP?=
 =?utf-8?B?a284MGJDNkxCNjJVYk9IZUpWUHhVRG9BcHdaNForQjlVWU0zS0Foenpid09G?=
 =?utf-8?Q?ZaqXc3IftMdO4NPK8ra/sO7kl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9d354a-8a71-45f8-fc58-08ddacf2a0d7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 16:27:04.0570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2LaOSNTdRMcWeW904hraFGoNnG2lCpVtta8/DrOwmMsaU74CU88FmsmfFnnG0Rl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650

On Sun, Jun 15, 2025 at 10:02:06PM -0700, Nicolin Chen wrote:
> Commit 869c788909b9 ("selftests: harness: Stop using setjmp()/longjmp()")
> changed the harness structure. For some unknown reason, two build warnings
> occur to the iommufd selftest:
> 
> iommufd.c: In function ‘wrapper_iommufd_mock_domain_all_aligns’:
> iommufd.c:1807:17: warning: ‘mfd’ may be used uninitialized in this function
>  1807 |                 close(mfd);
>       |                 ^~~~~~~~~~
> iommufd.c:1767:13: note: ‘mfd’ was declared here
>  1767 |         int mfd;
>       |             ^~~
> iommufd.c: In function ‘wrapper_iommufd_mock_domain_all_aligns_copy’:
> iommufd.c:1870:17: warning: ‘mfd’ may be used uninitialized in this function
>  1870 |                 close(mfd);
>       |                 ^~~~~~~~~~
> iommufd.c:1819:13: note: ‘mfd’ was declared here
>  1819 |         int mfd;
>       |             ^~~
> 
> All the mfd have been used in the variant->file path only, so it's likely
> a false alarm.
> 
> FWIW, the commit mentioned above does not cause this, yet it might affect
> gcc in a certain way that resulted in the warnings. It is also found that
> ading a dummy setjmp (which doesn't make sense) could mute the warnings:
> https://lore.kernel.org/all/aEi8DV+ReF3v3Rlf@nvidia.com/
> 
> The job of this selftest is to catch kernel bug, while such warnings will
> unlikely disrupt its role. Mute the warning by force initializing the mfd
> and add an ASSERT_GT().
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  tools/testing/selftests/iommu/iommufd.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

