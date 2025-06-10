Return-Path: <linux-kselftest+bounces-34554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E599AD35A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 14:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA543B1703
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 12:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FAC28E564;
	Tue, 10 Jun 2025 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zs8qqdd/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99C328DF56;
	Tue, 10 Jun 2025 12:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749557350; cv=fail; b=gVbLSRwSuatl2P5q4VQuc+pKWeSj8wTEcFjmr6gdKzmgExhhEpYh3k6T/TvoeszHQpD8KfnN8YDkt15H7//biMzeTND3ogbetFCoweAap+vlN0lodjdMYXS9UAkv+Na6kkcIUdT22eC4tMyIlsJ1qvp4mtMfMEKTcc9DgcZcX7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749557350; c=relaxed/simple;
	bh=/+SusClQNapqDhzEWvNlZ6klA6bonAxRAkbbxatxn20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lMge0FCZh+5boHxb6it28NbMtSSCNoFhXxAUmfOSU5e3VRYrcSs5TkrY1Ob/YhsY9D0H0ZaZqLfe/lP3djtdCheoZ/gEQId0/RQ9mxVxypKvtAtPsGCgjiq3N1db8/5mvn/P/xMiw5Mbju27O8sLwgEDHOx1hxu7a/q1YGyf520=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zs8qqdd/; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTAT63i34tdR1GRvogsP/RyLEOqGvAO8LG6EaMJUf724iHrPWyGX0uPSoXC6Of1rPgszdpAZpc9EHAEYYK/tEFGyCTAF0MM9mEI9PUMI7apychGIaa3/WWMHLogPJ1sKCu3SLDJ5xbao+R+EcVW6LCf5ZtDv1/lJT1Uh6qEsX9bcnz/kCd4Kz0pqTAXalMU+nunVFQaWRmeW7cZ1zJ8ZPDueslrVJvaS6xW6Ng4Hx4J2nbWqkPW6NwmrjzZr15qI5nJ+1yw0qXvBb5VfPpUBnabvgH7vJxqTh7ypUUC3ljyN1SDT5BdlrrEIyqtAQPR6umeE9xE/el9DLfNEbpBnLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rD1LNSuh5YtLDVz9dChNQidau5kAXzrIEz6n6bRUJYs=;
 b=rUxZRtoPNpsKt050NpBnZNaQGLYQBM1voTJtTMVC3ALUZcfayeVphI/KxMpvPp0q3mkPC7KpbsNpzqMaMhltxGu+dVXoMoiFNud3Fg5FszwHougLHFHliJY0m2ZDeQyuUzvdW+2svu9zNyweypqcExlr4xS2zhY3qY6RXZDaJGw5D08TnGWDwtlFHtHKWYdV65ZDBb33JKoeyx4WMl/whaTaY15YGH/k/e3HSRHYZVIsLc9wbm7f+c6NuHJ02C3CGbyAOOJL0je/QKKFK62iLGqGpcHzeVwKDAX09GkEd7oYnERs5ca0jTXkPwrQSpaR8JWt/03OfMdY3IAEYfT7Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rD1LNSuh5YtLDVz9dChNQidau5kAXzrIEz6n6bRUJYs=;
 b=Zs8qqdd/eBJeSPyWs/KRUYFzn3V4jpn3RUGHvZMKYv+g9FvmBGaKdhrcdMJZaHagVgkckct/fdeP0rCkRokKb8XmEpNHf1ECSsUK+cJrQr/5wAhXedSdUzYoG1sOdFemZC7ZSC6RiqJYyfzwbO8EpMtnaKeTsYEZ8om72yPAJnkQbvIPzUJ5egT/cvy8t7YVMeB/hS706NUABPjZk6SS5AVxNe7XD1wrALzkh4pp79t2dzvr/sWGZ21CmtrR4/ACWrPAHdjWxkT8U5OmlGjFldqCykKP+RUv90qCsFVGsUPNY3BUjhV4/PQKvBLYfkyfIcArCSOBYNjBc+dpA9ptLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 12:09:04 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.038; Tue, 10 Jun 2025
 12:09:04 +0000
Date: Tue, 10 Jun 2025 09:09:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Mark Brown <broonie@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 09/14] selftests: harness: Move teardown conditional
 into test metadata
Message-ID: <20250610120902.GB543171@nvidia.com>
References: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
 <20250505-nolibc-kselftest-harness-v4-9-ee4dd5257135@linutronix.de>
 <aEfVYQaid5uOHB+Y@nvidia.com>
 <20250610130817-253d2b2d-030a-4eda-91fc-3edb58a4f549@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610130817-253d2b2d-030a-4eda-91fc-3edb58a4f549@linutronix.de>
X-ClientProxiedBy: BL1PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:208:256::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: c24a75bf-0ec4-4605-d6b6-08dda8179790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWxTclhLejFMVk44RWt6NWJLL3hPaU5PTzdOZ0hUUXFseDBqRFE2bEp2WUY4?=
 =?utf-8?B?K3hpQjlTVjdEK0w1MG1zejFCeEJZRWt3eFMrNiszVFQ4VEkveTB0bkxZb2p2?=
 =?utf-8?B?N1NzM2tjN1BSZFdmeEZ4bGJnS1kzUVJEb2E0Ryt1aWR2QlBzeFZXS1F3OGFK?=
 =?utf-8?B?TE1tUUZ3NDNZbE4yZzBjNS8rbUNyNUtldm1EenhWVDVDWWFGbFdPTzdmYlpQ?=
 =?utf-8?B?WEQySGVnSE4yS1FTVTdhLzZaeTlianR2SDZnTzBVT3Z5cnpmSjA5WDA0NHJk?=
 =?utf-8?B?UW1LNHNqanFGZFpFWCtCUkRKL01PZEVnT3NLVElRanRWZ3psKytia3dOMmRE?=
 =?utf-8?B?UDFFYU9EZy9YUFhKcEtqbFFZVGtlZkpqNnhjZTV6cTFVT1BvRUgzSGc2QXZR?=
 =?utf-8?B?elU4K2FySkJMNHFHQ2VkNkRjWHgrMmF0R1FaUEd1WldUejZVaHgzZ0lDTzNv?=
 =?utf-8?B?RHdMMmduWDZleGF3QjdYRzBIUlV2Ti8vbVRyUmxBRHovZW5VVFlTVTY5VnVS?=
 =?utf-8?B?YXh0YjQ2R05kSXVKN0piWDlnSDM2OHVXT3NwT29qTGE0TGJJRWUwR1VoT1JI?=
 =?utf-8?B?aFdGSXpwczZhTzRmZmpKeVVONnZrZUFxeGFMaFhBMkFjZkM1MFcrT1dyUjMv?=
 =?utf-8?B?a0pNa2NVREkxUDZSaEtrQWV3dzRpWnNSRDAxbTh6MFIzY3BZNzN1YzdIRmd1?=
 =?utf-8?B?c0VLRWErZ0F3b3VQNnlVc3VmRWI4K2R4WmVUZy80M3E5blM3Ry9qUVlqaFdU?=
 =?utf-8?B?dDFnanQzUnRkbUpZUDJRZHk4R1F0amdMcU91am5qTmNVUTJBM3ViYlhNdXdo?=
 =?utf-8?B?YUQvSUlpY0hySTIxZzdIMGlwcFo4STF5bk9IOGdrd0ZCek1BSXJpMmJ3NXFn?=
 =?utf-8?B?WE92OWx3NnNFYXpjYndKNGtHVHVLN3RrelVONndmekt0dGRDWFdhVzN2aDlG?=
 =?utf-8?B?b2s1Rk1EWUY4T1NnK2VZakxBUVJSbmNZK1pEVnFWMXphWG1qNmJpRzZselA3?=
 =?utf-8?B?cXk1RzZoQzVnM1BHdnFobHk0Qjl2RUg3WEw1Z1lpclB6SmdVb3BNVjFpTDF1?=
 =?utf-8?B?M1J3WHFDdlZnUmJpYXJuU2tZcmJ6ajFtMU8xOER5T3hUTFV6TmIwSGYrd3Zl?=
 =?utf-8?B?bnNXdHM0WHJlWDF0ckloSHpsZExidXpPaVlXNUtlaThWaE1yYmZHYkJjQjVs?=
 =?utf-8?B?RkVBd2RkYzlpNENDU3N1TGZCaEdkdFFlZXdsY3hiY2JaWUVHd2ppVFVaU0w0?=
 =?utf-8?B?TTlBbG5Kb2R2enVWVmFkQlgrSlVRUm1HK1Jhc2hsaWN4dEIzNm1yWnRkaWVu?=
 =?utf-8?B?V0VyTmROTTA1WTBpb1BuMmZEOEE3Q0xIRDl1Smg5NzdIN0N5cmtlakZBSm8v?=
 =?utf-8?B?c2dwdnk3ZmlhNis5ZEgvc2dUbG9Ea0VxdlMyMjZJMEg1ajNUVVQ4cU9WbUxp?=
 =?utf-8?B?QlRGeWZsN3ozaVJRUlRlTTk4RFFLNVFTWkNCMENObndHQ044Z3BWNjhBMmk1?=
 =?utf-8?B?N1d3T203NVIrYW9RNXY2ZEs0elJUYjJCeWlueEg5Zno4Y0xIOG5aTzhPQ1Ri?=
 =?utf-8?B?Sm9aZGNZaTF1WkV4blBvMkZ6YUhRb01lc1FzSGN2QkExYkJPSnR2ajhObWQr?=
 =?utf-8?B?N0lINjZuWTl0Y2VHak5vQm5VV1R1MUxhKzllTStWVG9uMjNuaUMxRlM1eFM1?=
 =?utf-8?B?WWtGRHhCNkcwRzZ6Y0NYcFJCQ0ZkVXl5STFhM2NqRVZKN2trYWhqSzJZWlNM?=
 =?utf-8?B?eFNxai9VQy8veFBxMFpjSnBoSUpIL1J5N2FoWTVveFVqVi9yQTVyZDNIQ09V?=
 =?utf-8?B?d21MOGtQbjFrRlB1LzZqVjh3cStGaHBjWS9tMEQ3a0VGTXo4YVZ6YXVtTFJ6?=
 =?utf-8?B?dC92N2htTFNRakJHWm03SmFPaUNOUUcwaGhPQzdNUnRKWHNqRWlUZTU1OW9P?=
 =?utf-8?Q?awX6FfrTBU0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUVSaUkrTmlITm9HQnYwYis3Unl1c2k0bkFSbCtDNmtGOWl5UlcxSWFPMXpn?=
 =?utf-8?B?ZUJRZW5FcEhGMU1LRFdlaTZxQ0pEblNCU2FjS3NUL1JoNkdKdXprZzdZQnNL?=
 =?utf-8?B?d3pwUmRMeGIwZVNUbUJjREVJTlh2K0FSbjdZNW9BWXVEQTFkazczY0h4OE1r?=
 =?utf-8?B?Kzc4ekdMM2FCemxMekhCcmxkWUM5WWh4WXFKeDdDTFYzN2hoRFJ4SFUyeEdn?=
 =?utf-8?B?R2k5dDI3UTNtK1RtZm04TFd3QnJVY3lhanlFajRoZWpiLzQ4OWRxd2pjdkds?=
 =?utf-8?B?bVJzYlVEK1lINUozVE9yYlVrYkRvZVlqWlVUTHk2NE9DVm5IWFVIZzlEcm9O?=
 =?utf-8?B?K05SdWNVVXJvZXQ2UlY4aFp3RURjS2szakpuNVRWdG9PcWdyb2lCTTZxMGR5?=
 =?utf-8?B?bW11NEhHck5PcTExVCt5U0d3S2U2NGtPYVFOc0ZMQ01EVEFjYUtxZW5teEQ1?=
 =?utf-8?B?bVNQM3poMS9iREdKaW5RWnRUcnViTFJHcjlZYmprL1o5OHFDSVBCMzdLd3Ar?=
 =?utf-8?B?L3NhbGUyL2UrZTJZNllBQVdNWFI3M201cFRaSkowYituS3J0RDQ2WWRLTi9a?=
 =?utf-8?B?VlFGZklmS2xTSXRDWHV0STVEZCtsMWlBTU5rVUptRnlEamY0cGcyS0JuWlFF?=
 =?utf-8?B?RDdBL0pSN1pPbFd6Wk5NZlVnSnBITXA5TEFSbUx2T3dNSzIyaDl6S0hIVTV3?=
 =?utf-8?B?WDlPdGNLWXlPMUFSMTZnaDQ5V3crMDRMMUhxNWlDcXJQU3ROUTdDZGVoOWZm?=
 =?utf-8?B?QUd5WFVKVjhFb2VRbndyblVwQUE0SVRGRDNnR3JOT2pUbWg2SE1aQ3V5ekk2?=
 =?utf-8?B?SEpXUkh0N1VPbzFoRnpqcFMwWWFGL0paNUtvQXEzK2E1alFsRUdTQlk2bFpW?=
 =?utf-8?B?UDF1Vnh1TE42ckYzMVZ1RHdHazI0OFVXOFJUS25LNkh3V3JlLzhnNC9ZenFV?=
 =?utf-8?B?eEprZWhFbnJnQW1uM1BsYnBhUGUyTVZDbzR5ZmFxNUVhWWJ1Sm5FUFF4cU9u?=
 =?utf-8?B?NUVmaXBtbVFWVS90TjdwbG90Rkp0MzhJaW1PV2pkcE1FWG1naWhOUkt0eThL?=
 =?utf-8?B?aHlTTlp3SDd2UHFnakwvZkdtM1EyK2tUM0JFdXBOMUFDN3NmN21vQUpEdXdw?=
 =?utf-8?B?OFJCclpjYUM5b0hrTGpRTW00QUEwU1duSk5IMDh4Rm96aE9mR1ZrcHMxSHJo?=
 =?utf-8?B?VFZnaGw4bmw4UFYxRGNlSmdCVTkrTzBSdm1RNjQ3WFFYYW9lVGFSOFVZV0xL?=
 =?utf-8?B?aDBTb3pJN2RFYzdyWFZqWlU1Y0FRc2V1ZENaZEFhWkFwVTExY2RIbENiSHRx?=
 =?utf-8?B?RGxrL251VnZEYU5PMnE3NnJ5MkV1UHFmOGxLWGFOcGlqRUtFczQ2RFdUR21E?=
 =?utf-8?B?NGhZbHM1VVBUOVZDUDlRUVM2V09YRWVaVXF4OXFUN21tUGxaTHFNZ2ZCRVhD?=
 =?utf-8?B?YnUvWTIvM2loWFdjNXV5djBnOVpwUVFaajdhcWk5VmtwcHVmR0lTTUJ0STQ2?=
 =?utf-8?B?WG83Mk1HRmdYSXdyRytuT0phTXZaUDlBbkdIS3NySkNtL2k0a0VyVlExV2hE?=
 =?utf-8?B?eTdrOWZsUW5oMlNVc1ZKT1NERzFTWHJyNXZBazVBM1BCSnM2dnREd3AxaW1W?=
 =?utf-8?B?UGFVZUI4QWh3Q0FpZFN4anhxOUQ0ZlEweFU1dmJoSUJIbFVPVUZSYzM5RE1K?=
 =?utf-8?B?SnlYM1BVOHlVUlQ4M2V5engyQWhpeHBIL01VajFKQUhpUlNxekliakIwQjAw?=
 =?utf-8?B?aERLUlVmVTZBWWVUbllKRnJreU1GVU9ITXNRRDZRQzI1MjFqK3B5M3B0elQ4?=
 =?utf-8?B?cEZvV1lWZTJqVll6RzR0SzBnNmd1MG9jZ3A1aFdXOE5td1YzUTZDNEx3RGUw?=
 =?utf-8?B?ckIrdWxsT2lRNklrYnBSOFIxajdaa1REdEtxRmZwNENHNy9yR0NKbmpJUjJF?=
 =?utf-8?B?SzdZdlFMcDVOaDVQeEk3bGYyd2o3K0dhc2paZXBPQS84UmVPSVVLU1ZZMi9X?=
 =?utf-8?B?ejNLYTA5Sk4vd1BXemFLdzFmR0pKdzdIN1NJa3U2bDY4ZUttajljMEs0dHU4?=
 =?utf-8?B?bVlHcUJyZThzaWJjUFZMU0RDaDhuUHpVVFRlODFBeVhZTGxscS9IMEl4UnZy?=
 =?utf-8?Q?AcQF2yxiYprbp5ZLmqaMCNQlM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24a75bf-0ec4-4605-d6b6-08dda8179790
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 12:09:03.8955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xaGC7meTQjQXQCabMeYLtSdganCmxRbJtT8UaEENtrtDkxBcXaa6eC60t1o2Ohpz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319

On Tue, Jun 10, 2025 at 01:38:22PM +0200, Thomas Weißschuh wrote:
> Hi Nicolin,
> 
> On Mon, Jun 09, 2025 at 11:49:05PM -0700, Nicolin Chen wrote:
> > CC += Jason
> > 
> > On Mon, May 05, 2025 at 05:15:27PM +0200, Thomas Weißschuh wrote:
> > > To get rid of setjmp()/longjmp(), the teardown logic needs to be usable
> > > from __bail(). To access the atomic teardown conditional from there,
> > > move it into the test metadata.
> > > This also allows the removal of "setup_completed".
> > > 
> > > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > > Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> > 
> > Certain hugepage tests in iommufd selftest (CONFIG_IOMMUFD_TEST)
> > start to fail since v6.16-rc1, though the test functions weren't
> > changed during last cycle:
> 
> Thanks for the report.
> 
> > ------------------------------------------------------------------
> > #  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty ...
> > # enforce_dirty: Test terminated unexpectedly by signal 11

Sig 11 is weird..

> I can't reproduce this report.
> On my development machine or a virtme-ng VM I get the following failure:
> 
> 	# ./iommufd -r iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty
> 	TAP version 13
> 	1..1
> 	# Starting 1 tests from 1 test cases.
> 	#  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty ...
> 	iommufd: iommufd.c:2042: iommufd_dirty_tracking_setup: Assertion `vrc == self->buffer' failed.
> 	# enforce_dirty: Test terminated by assertion
> 	#          FAIL  iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty
> 	not ok 1 iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty
> 	# FAILED: 0 / 1 tests passed.
> 	# Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
> 
> Specifically the mmap() fails with ENOMEM.
> 
> When booting the VM with "hugepages=100" the test succeeds.

Yes, that is required

> On another note, the selftest should use the kselftest_harness' ASSERT_*()
> macros instead of plain assert().

IIRC the kselftest stuff explodes if you try to use it's assert
functions within a fixture setup/teardown context.

I also wasn't able to reproduce this (x86 ubuntu 24 LTS OS) Maybe
it is ARM specific, I think Nicolin is running on ARM..

I did see the other warnings that Nicolin reported.

Jason

