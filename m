Return-Path: <linux-kselftest+bounces-34827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B1EAD76D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 17:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F98F1899E70
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 15:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C531A265E;
	Thu, 12 Jun 2025 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p5i3VcKl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C03278F5D;
	Thu, 12 Jun 2025 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742970; cv=fail; b=heSClxTLspuOadJwaUlXXcss8VvYEWLaQPREK/k+iZGtK+lsEfuWTBi7e4iKAOS9JUr1XKlL9/sBjdnEh+pM6M6M6SXEWaaGvv7v4Bm8VNEy8uuRVEBHMns/ov2/kO+VYe5/RQa4BgC9TwXa1Mm5f+TBcgT/rGbS8Ep6Gh3oOVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742970; c=relaxed/simple;
	bh=c4r9TVuGmLVtEUpd6Q5HX88/s0QsGraWcRJlOli5wlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cB5OAiGaH2baAR5DVm0PibQcN0jRVylM4nsOyUSxTZKrBoh5rPbCY59FaZXUdhDbu2VvDZmZtaPc5wQIY4apwwLr64I98Ayx3CapJvywOxpKYkjlfqFTg0e6Zh3OH71QYCJ+ARuVN8+4B9W2Q9kySR6KiiWiQOueSkXdu9Rj7Ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p5i3VcKl; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKrc6BhO9x9ZP/hhXeYi8nio4Vb5x8nv6FbZglpOoy/hZtrqvhAh90oSP69F4vfK1g+VAVFdBkFR7tdElzPyyLm/LwwvaYUUuoxXumw1rvBillHBUbkoiZb8lg8785ni9vcdGF1GKcrdU486GXgDhDiEUpjbGseZPlE7lFnFyRxKfRWWSVHOEfn/QMlTi6BXxxh/RRAhZ+cfkxAEM7jaoA7r1n7/vQSUNzcO5Z73yZY/0Hf/4ifadc/uyMOh3lUFZZaBIMaDq2uU1C37FvvW0JfdMIz4BbhNdlP9gbuoqE9FlD90EzjbPsnVx0Wea3zjq1Mwy3ejTShSi1Df9sp8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yv8M2bdjoj4T8m3cSzEVy/gcwMgz1LARpgSvWWHGM6M=;
 b=c+HewIKjBxjBL0W97l9t2T0wX1XOWREGmjR77X248Epb0ToOeuKsasWT5fFfNnROfsOEFYaDTNzeaUyOgdZi7YlYGJnzn1Op9864vdDheSneMW3wtr3IAY6aAk5ETzw2V9vjgM6LsNyqMhv7Jh73CdS3kORCKGtM4u128EfHtbF3N+cP2TSwFsaT3pYnSZlPOLFkMmuqWlUxzrmHZIiexRip8/J+QTDVfe87Tm3NNGnKoJmLDNw4/1z1dVSoGb7cvz2hl1UrZXjnC08Q8qBh0x/mqAptTXMkIpfYuUkRj6XSM+AnWz6rJL/5edYgTXr2oZfkS+GEtYmNyKgesFEjWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yv8M2bdjoj4T8m3cSzEVy/gcwMgz1LARpgSvWWHGM6M=;
 b=p5i3VcKlJMS1Mnmktc1YfHWNePvK8OAh9qTyMRo9yVpOmYPyv0xrTYVoo2KuEi2lL55IX98wn+ac4bfJO6JcO2ZZPjwTTsrbc/ir526G2GljaKInraPCmGvUKtjM5puGpR1QKunzYwMLm4rVa1MK4pz5J47RHF3mycr2GX6slniL5qPoXOmeD5+3s5/kEm8wckInJPef9Qu980QuUGU2EVa/RMlZOAfdrHpCxZTjCaJJsx7z7aTu7Z8q/mzSeDiRIONcWk31x9gF0ZVvM19OOTIVqdelgFGNTH/altglQX2O185g6LbcP8VYcMeCjrFy74iZE7vwcS5nMQbbng6PFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PPFD7DCFAC03.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 12 Jun
 2025 15:42:44 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.038; Thu, 12 Jun 2025
 15:42:44 +0000
Date: Thu, 12 Jun 2025 12:42:42 -0300
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
Message-ID: <20250612154242.GW543171@nvidia.com>
References: <20250611093942-f6c65a06-c72a-4451-aa1e-8cb8de0d69cb@linutronix.de>
 <aEm6tuzy7WK12sMh@nvidia.com>
 <aEn5jmXZbC5hARGv@nvidia.com>
 <aEoUhPYIAizTLADq@nvidia.com>
 <20250611235117.GR543171@nvidia.com>
 <aEp6tGUEFCQz1prh@nvidia.com>
 <20250612135802.GU543171@nvidia.com>
 <20250612162151-1fc97a6c-a1c9-4656-997e-fd02f5f9418b@linutronix.de>
 <20250612145801.GV543171@nvidia.com>
 <20250612171437-450fb7d6-c73a-47e3-9e1c-5c009cba7fe1@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250612171437-450fb7d6-c73a-47e3-9e1c-5c009cba7fe1@linutronix.de>
X-ClientProxiedBy: MN2PR18CA0021.namprd18.prod.outlook.com
 (2603:10b6:208:23c::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PPFD7DCFAC03:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b9e18f-c213-423e-c501-08dda9c7c5e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmFVdlc1RGpzMTAvTSs4dW1XZW95M0I2SHZlMVpjNHJ6ZFJSeHh2ZGdKQVhj?=
 =?utf-8?B?a0VFVWp6cXVZczVSMW9YTVB1OEJEK0NsSHBmTzZ0UWFkTWt2YTJmRTI0Y3hm?=
 =?utf-8?B?WW4zeE90Rm1kOCtXSlNCVzhLejlIK3JvTzJRS1UzNjUvTU5ab1JxWnFXdEVJ?=
 =?utf-8?B?TndsZDlHNmZPRkZnQWFLMlZoeE9lTFJrT3BaVkZYQ0wvdFB0QnlLWjZZczJJ?=
 =?utf-8?B?dmlxYllKMkU1dk94SWxpSDI4NXREQzBSZk9aM1FtTWxLMnNIbjFiRVFnT2Zn?=
 =?utf-8?B?QmxWOUQ4V05BRitWbzJVWXI0d0drc0JWNlhiUVMzVWtsRWh4dzlGbjdxSGlv?=
 =?utf-8?B?OVlIQWJFR1V0dUhLYkxoTXp1NmZqWWNabVprTXZ1WGhmME1PeDRjcldqazdx?=
 =?utf-8?B?Ymd1S2NIS015WFB6bHowcDAvY2JuUDZJVEFXTit4ajhJK1VpOHA3SndsR0dP?=
 =?utf-8?B?MFV0OEZPUW1VT0VZNmFXMU11SGs3ejlLRGRIWFNTalJjeUQ5NzlsSkVsZTE0?=
 =?utf-8?B?RUFZaXBpcS9NNXN4M2FvN3VqWVJxRGh4UHJMcWcweU1mOU9wK3FsZG9ONnRD?=
 =?utf-8?B?VmdZbnp3TFRIQ2FKUDFpU1cvQUlCby9HRjFlVjVFMjZkRzJtdW9PVWRCTk5X?=
 =?utf-8?B?L3gzUXVIQXVMcXovNUoxMitzV0h0VVhmR01STUJYY0FqMENYR1dWNXNTZHQ4?=
 =?utf-8?B?aWNaT2RNWXZsdFJQT2lEMzlNc2sySDNGVVkrMU4vQTlXblphbnpmQzN2NFJ2?=
 =?utf-8?B?VkMzVFdmamM5SU1VTGxxejFKWTFQbkQ1NjBGR3hEMTZ3SnJNZVNvcVZORHlK?=
 =?utf-8?B?dkVFMkJ3SFh3QzNoc3FtSVN1OERld2Znemp4SGp1VDlwZkdHS09rWUpVbmVt?=
 =?utf-8?B?U1dWc3lWcDJxSFp0dnpsK3FWWXdhTDA2d0JPRDltZUJUZmlKRGNaYXpSMUd1?=
 =?utf-8?B?Zmp2Nkp0V3RaMkVtUmk1YjYvRkNWN3RHS2hoZEpmV1IwVlBzWFRUbHJYT2Rk?=
 =?utf-8?B?UlNSdG5WekNTMU95d0I4MllsLytnem5ieEsrbXdNSmhhSFk4UHpqT2dpU2lj?=
 =?utf-8?B?TElWeFFvWlUrLzJKUmlwTmRoaUE0UmJla3NSTXg4SVl6dytZaVQ5Ujk2MFJq?=
 =?utf-8?B?TDBjY0tSdzNId1M2QmVXUWVCRnNQdkFNVHF1T3Y2VlVCRTA5RE5RSWxjYk9Z?=
 =?utf-8?B?cFk3ZDF5KzhhbGdnd2dDTXlqUEJleUFBRHZnZFd2a1g2V0xjaGtkMW1JRWZn?=
 =?utf-8?B?RmR1cEFzejFyemJNWEtBaDZyT25WNWQ4dnhJRGZBZFVvWEdMNlU1MmovZ0dv?=
 =?utf-8?B?MXpkZGFlTkhzSGU2c1Avb1Foc2lBRGtldGVFeDVlN25aaFlSaGdselVZckt3?=
 =?utf-8?B?S0NyclBhcWVhczhQZ1ZFOWkzSklxZkdmSGxhLzlNT2tNQ0pSOEUyNnFHUTRP?=
 =?utf-8?B?N2IzT09lOUNRUEU3TXh4YlNsUTNBdXhNU2REeTVQb0tmQVNkeUhFbFA3MDlJ?=
 =?utf-8?B?Ty9UR2tibW1HN21yUXora0ErRy9KWk5PRVhJSHNsbVdPenhFeUkzRFpleU1I?=
 =?utf-8?B?NGx1R0tqSWw4V1N4RFlkTWxrVmE5ZFNSNlBUTExkbzdPN0JqR0VRWjNWT2N4?=
 =?utf-8?B?QjBHT1F1Y08wck80ejlxcDZ1WVlleVZWTG1IRm8wZkxXVkVTTGFXNWNqYjNk?=
 =?utf-8?B?cWxKTXZ4K1kwS0R4cEZqOWlZczNtWHhFeGtpWDBaZUtCRDJnQ0ZnSFUvU3JU?=
 =?utf-8?B?bThxRjhESFMrYVhFM1Azenk3QnZTZUphMHc1WFJZVnVwTGpENmVST3k4SFJo?=
 =?utf-8?B?bzhQWGo5RDdscm42Y1BTcW9RQ0NiTVVxS2k2ZFRlb2JJOVl2dHc2U3VuWU1p?=
 =?utf-8?B?dU16MWxsZlp4OW4ralBPbDV3ZEFuREt2SGhldFZ3OTZEZUFJSzlaVnA0M3BH?=
 =?utf-8?Q?74RxKOaX/Zw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmVEOWNIT3JxRC84Nm1ZRmRZeFVNTXZlTXZ1L2FFYnN6cFdKSDBCSUd4b0po?=
 =?utf-8?B?L1BiT1loL25oRTR6MHk3Y1NXdEpNNERLOERUQU9WZ28yUGZDZU1YVFo5Ny9C?=
 =?utf-8?B?RVZsUStXYUJ6KzBnR0ZXaWVSVjN0V1RCTVlVM3N2SDJHWDVNSDUxMTFDMGNj?=
 =?utf-8?B?S3VOSzE1NFNjN3NoWmk1cytsS1lKcS9jcjZvUkNVUjEwaHpQdW1hSWFKcm5z?=
 =?utf-8?B?eHg5RTNVeHZQdEcxMm03elNHUTl5K2NDaXFGa280aUp0Z3ltTVRoL3ppKzBo?=
 =?utf-8?B?VWNHdTlNVVVULys1VjAzUWx4cDJHU3YzaDc1SnpMdmM2aWNJV1JqMG5uVkty?=
 =?utf-8?B?WmZsY1VVYTRrY2EwbVd0ZzZ0MEh0YWYzVDMzZUF1OVBpRW91N3l3N01GNEZl?=
 =?utf-8?B?YnBzNDhwZzR2SVRqWGxyNEtOaFlYeUFMUnRnYytwV2xtN215UjBYclFidGJh?=
 =?utf-8?B?SHIyWElNc2FXSG1tbDBlU0hMbnpRNFdXZUN6TExlbHdRaFV1dFdjeXI5Vlgw?=
 =?utf-8?B?L2RwVjhYUjJFcVpLdzNiL0V2YzI4UXhudWI0Zk9lYVJqVDdIT3N5Q3BlR205?=
 =?utf-8?B?UTZIUVkzYUl0MTFGQnhHY3FPc2RjbXFsUmxSdzEwbDhoVlVvWmNYVFg1aFd6?=
 =?utf-8?B?K25vOG1pQWVvY2xIYm1Rc202ZmFwRWg0eEQ1NFdWN2NCTGIzQlE3d1dxdGM4?=
 =?utf-8?B?K2dnU2JaMS8rR1pYMjMzaVFHTnNabVFteUlkMEpvUGt4VkMwTTJ4NnhWNmNr?=
 =?utf-8?B?Z2R6SjducW8yVjh0MGcyeVpoQSszTXl3Yks5cml5TnBWbG1LbEo5ZXQ2SmJt?=
 =?utf-8?B?cm0vekdlQlZYcFpudmt4UHM1L2VKRzVMTkNXbFg2Y1IxMEJxcHpneGNNWU45?=
 =?utf-8?B?d2gzK3RWalNHWjNZYVE3bmxTMDNVWWpBT0Z6OEEzN3NnU1I5SUtlLytZZThT?=
 =?utf-8?B?WS91MzN2T2Jla3BSQ1lLbS9tRWdjT05oOHJmTmM2R2p2U2Z6MzNiVG5razM0?=
 =?utf-8?B?RVdqVTVQTmR2eVZNZ2dxMDdUZ2NYeDdlRDVIb0RqUFNpWUw3TmR6VDBzR0cz?=
 =?utf-8?B?VGdDV0JqMERISE5iMXBGdXQzdXYvYUZQdnJOQ3RudE5zc3FmTVZrakQ3RllT?=
 =?utf-8?B?dUx6SzlxcVJLWWVMS1BIREJBSXFsUEJILyt3RFR5YU9OWnE4WFNjNloreFpW?=
 =?utf-8?B?SnlnSi9JdHFuSlFUSHZiNk1vRWszN1JsMnhNVlBjZGtHeHRLRDE0QmhKRHdF?=
 =?utf-8?B?M2dYSGhmRnFHZ2tYNjVQUDNFV0Mwem9QNE5WOGptUWhEWmVNbGdEMVd0dFRs?=
 =?utf-8?B?alpnd0xSRmdldHJNVCt3UlVNSjF6OS9LWTRXeXp6WFJZYWpzdm9SNmh2RGlG?=
 =?utf-8?B?RVM3NE1nWmw1Y0UyNmlwV0NlWVVqMlQra3l5YUpwajhSZnBETk1CdFdJb1Nt?=
 =?utf-8?B?OG9GMUhOWDFxaHZmWUxOSE9RMHRmT05CSjNnckNiaGdkbWxkT3A0YW9CUkkz?=
 =?utf-8?B?dzRpRmQ5UVdCSnlXZDcxNXNFK1lFNExYM1lMazhtT3hOWWhHL2VpbHR3YlJp?=
 =?utf-8?B?TXpkVmRvM253YUk2ODZHbC95U0Y2YUp4ZG42czhVcXhmYU9hb2tQZVZUVVZT?=
 =?utf-8?B?Q3dRVUluOHBjcXFzU1pkZ1pmdGpkc2hodWZjRm5HRC94TEdBdTRXRGNqY2w1?=
 =?utf-8?B?dmh5M1RQU0h2SGZMQ0JkY1RYcEhsZFBoL0tEbXVLMEM2QkZqMFptcGExenlK?=
 =?utf-8?B?UEpOdm1pLzhFWmhNSDZSNmNDa0ZUSE5SRzM1cmxIa3NobmQvTHVBK2kvZmVK?=
 =?utf-8?B?cnZwVFZKa3ViL2RQSGlnR2xOQ0VOWXZpVGZuYjB6dWMvNGJQVGxmZ3FyemUy?=
 =?utf-8?B?VkVIbHovK2hBYkRRSGFCSFNDUC9JbkRncWZzM210R29adzRxK1hEVzMxQklo?=
 =?utf-8?B?ZTBGakJSZWxuUDQzZDRodHFWYVdYMHNhUzg1dTI1MzMxOHdpQ2VvZ1BUU21q?=
 =?utf-8?B?RHFSVHZhWGlReWREUlJpVnNZZVZqaW02S0YrSXBhQ0RrOEZXOTJiS0pSZFU5?=
 =?utf-8?B?UmQ2SjJPd21rcnNCekJacm5FcFlxaDV6bmNGang1RjNiaTJkSkpQdHVxelIx?=
 =?utf-8?Q?T1KXnx+TNRBGu3d7c3wWD4pRr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b9e18f-c213-423e-c501-08dda9c7c5e7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:42:44.1670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXhSCRGPGcTWtUsvP0waWCbFOLoRcMOXsHMBs8LbBcQ59r66gL/RE3vm8aylgSRQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD7DCFAC03

On Thu, Jun 12, 2025 at 05:23:01PM +0200, Thomas Weißschuh wrote:
> On Thu, Jun 12, 2025 at 11:58:01AM -0300, Jason Gunthorpe wrote:
> > On Thu, Jun 12, 2025 at 04:27:41PM +0200, Thomas Weißschuh wrote:
> > 
> > > If the assumption is that this is most likely a kernel bug,
> > > shouldn't it be fixed properly rather than worked around?
> > > After all the job of a selftest is to detect bugs to be fixed.
> > 
> > I investigated the history for a bit and it seems likely we cannot
> > change the kernel here. Call it an undocumented "feature".
> 
> I looked a bit and it seems to be mentioned in mmap(2):
> 
> 	For mmap(), offset must be a multiple of the underlying huge page size.
> 	The system automatically aligns length to be a multiple of the underlying huge page size.

Oh there you go then :) Horrible design. No way for userspace to know
what the rounded up length actually was and thus no way for
userspace to unmap it.

> > MAP_HUGETLBFS rounds up the length to some value, userspace has to
> > figure that out and not pass incorrect lengths.  The selftest is doing
> > that wrong.
> 
> The selftest would be more robust if MAP_FIXED is replaced by
> MAP_FIXED_NOREPLACE. Even with the new explicit skip logic it should
> make debugging easier if something goes wrong.

The point is to replace something that is already mapped there, though
I no longer remember why it is working like this.

Jason

