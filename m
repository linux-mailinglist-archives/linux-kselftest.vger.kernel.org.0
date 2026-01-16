Return-Path: <linux-kselftest+bounces-49196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEFDD3842D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 19:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF3D53028FC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 18:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0253A0B23;
	Fri, 16 Jan 2026 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hVyuT1jV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012011.outbound.protection.outlook.com [40.107.200.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A940346FAD;
	Fri, 16 Jan 2026 18:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768587877; cv=fail; b=YJilJS7GvVXqZEpDaNF4IZR22hlCE1vCKpCwubkp8hm25YxjAKxgHd8qxISrwknh2N6BGxMwBLxBrOlxDvsP8iP5yKAHilIYE8MGpOYBovQgana9ki6WrML0q/TQDCigDNmz/hHCgtYrnz5PHN9oMfB7KNffPZSLXXqRmfG5Thk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768587877; c=relaxed/simple;
	bh=DFX54X9inFS+1z82A1Cl6mvXDF7afJVPvV+4Mfid+RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ntpkLhDwzN3R/rijlG/JplRHF824Jbi58BcIuiA60R5ptHkJS6swBfJnnAfOrDVHO556WtBwYBzotddoi9+WBexJBQUwriPwvdmf5zDWpVvYmyj+Pzi8h1pir7wbCGvJ+CbNPQjGYYM9SOndh7eKNcm29IX8aW+KWAZ8lRIA5Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hVyuT1jV; arc=fail smtp.client-ip=40.107.200.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ew744HLpXMBM4738DWDNibQ6fcAO6PpO8trKxCsORR/ho+5LtwzPLvkgmxq5VUtgLTJakUYdebYpNjukb8Orf6oXcJIOs+7QOmxm7kEGjDrXzzHzp368DLkpGDwtHQMTANAXpZzmgQb5zU2eik5q9l9FUPXT9WIp5yB3jipjvDUPtV2+94klt3jerocMSOhxd3lfh01ftsA1DBJq3zz4lE6qjw4DCxnu2CGE5+DoH+1ftKbr06Fjy1/nOlwjD9CHXCqo3QmBv2sheGC6tInllKQLP+JEhMmtRl41ovYStSMK+0ePhpZv0k7OJ8Yn/ImvbKaKcrAtuizGRW+V3ZRylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgQJRJ4eispkKJiOzXJaxz1Mh8w50Js89Z+CeaE/U3c=;
 b=v3ysWxO460fE8zY43ZJIwJEuVugwC1Nr10ffRC5g3Eq5hyqP3trtDEOlKdAa0KiuBnL27saSw2yfQ20sAumNKXhUTv9MAUzp5/1QRqHzoepTmPnVPcEzzWn1vIcrcwDPeryU4XD+zVAMuyeJuY7rVp0Xa3vyUTwuCNCQbE5Amem90G7TN/XmKiHhdT0uxS1cARam21wIu03cwoz4OoBxh5/ETWgiIqpZ+gPhO0aBj+ZFt+3rAn5ig/Sfcn/VDLniZBmhe+T+YhP5Ts5g0nuZPm+6g18HYHyiypCqHf1nx2CT72N+FENJ2f3tPWIyn/sYEsDkm+v9QLz2iz62Kssm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgQJRJ4eispkKJiOzXJaxz1Mh8w50Js89Z+CeaE/U3c=;
 b=hVyuT1jVxtQBV0IRuMRRQseLQdyo0XL1YgSnae50+52b1/s3SFH+gwUvoSIQNgVteUg3qDxO2batbaN+7N3jLNaAIv4mSUcWd72RKR4hXIINlSjV58XzjBKIuW5H1EnbcqWRsUKGV/WRFkgRIggiuttGbZJJeyMgb2gwaQ26LFyvw3BWnPopCTy6IyIi5wT2xujsKuiWP0TEPNEOhcNOcFpVQujDzkhMnpINoUag1rvbSSkIWqHaAcx4swiYE64rk6cmpreuU0SBHH5ccUhVrgdgBAqtVSg4Jk/bWwSeIV/zmPsw8w1b1NGOFVJXK4QdSdQ/oUD3fM6GcC+r0HOELg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7217.namprd12.prod.outlook.com (2603:10b6:930:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 18:24:33 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 18:24:32 +0000
Date: Fri, 16 Jan 2026 14:24:31 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Linus Walleij <linusw@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v7 1/3] revocable: Revocable resource management
Message-ID: <20260116182431.GA1134360@nvidia.com>
References: <20260116080235.350305-1-tzungbi@kernel.org>
 <20260116080235.350305-2-tzungbi@kernel.org>
 <DFQ45FWO4XHC.2BW7I9LGC76WT@kernel.org>
 <CAMRc=Medaqr5UPimc8o+VTy=9MgU5p8AXjArisQfBNqi7ktSGg@mail.gmail.com>
 <20260116160424.GA14499@pendragon.ideasonboard.com>
 <DFQ5W41X6Z7S.3V6FRPXYMDJ1F@kernel.org>
 <CAMRc=MfAZxzd2hjqgDsXBR+UxgkaEQX0vR5nNZ=a+5WccUb4GQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfAZxzd2hjqgDsXBR+UxgkaEQX0vR5nNZ=a+5WccUb4GQ@mail.gmail.com>
X-ClientProxiedBy: MN2PR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: cf92ccdd-5840-447d-f983-08de552c7e92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1l0K1Z2WmwzZHdXSUY1VUlPRnBhRWprdGNLNWxvUzBGVllyc3dNQjk0ZGwx?=
 =?utf-8?B?M2xYSkdqODhOVHFDeFAwUk16SkhFemxTSVZuWm9kM2Q4c0w4TzhqbzFUVERF?=
 =?utf-8?B?SWtiT3dKY1JaT1ZMa2dhcytxYWw1MzhSdkl1Nmw1YkJua1YrREt5ZHZHUlAx?=
 =?utf-8?B?WjZYVWE3ekc2VXgrU0I4d0lWYldhZndJM3ZSdDdTSzAySDdnVE4xdzdWTVdx?=
 =?utf-8?B?aTRkbis3cnBrck5LVW5YdFEvT2xCc3g2WGVzLzB3R0w2MENhOGZVbUkwc1o5?=
 =?utf-8?B?LzFxVFpDd1JKb3RoaEhyRDRrRkZJQXZxV3lwSlc0V3JsTWpmMkVhQ1ljTjha?=
 =?utf-8?B?ZC9rVEo5M3QxVzBOQ2E0SHVyczJOVjE5alp4VTNxL3psSU1UdWN6VS9xa2NP?=
 =?utf-8?B?OGw4bTgyK1FCTW5lc3pKVHlxa0l0OHhQbmtzclVOU05ORzdnSDdoRkdKQnNF?=
 =?utf-8?B?ZTZhS1N0L2RpcEdnd0Y4bkcvNVZrNUZvbXdkcm16dlhGdlJheXBTNFkydUMv?=
 =?utf-8?B?bHJldEgzQnNVYXpwS1NYR01lT3h1YkhqNmFILytaNDd1dzM1VTFlZFMzZURD?=
 =?utf-8?B?c2UrOVEvaHMyclN2ZmxSTU9BYWlGT2NYRFJPTDBRdmliY1dDcjJUdnRyZ0NB?=
 =?utf-8?B?ODgzUE5uQnJDeVNyM3JsUS9nL0FjdUZQUjFlMWhCZUtmanpqbjhHQmRUYTlx?=
 =?utf-8?B?WG81eWI3QTU5a3FkdGNlK1hlTGI0eGl0dTUvYWJrUzRQYzJvRWl3VEtieFpq?=
 =?utf-8?B?dHR6SkZTMTIyazlzbUlsbnNDUm0yNytScjBIZlhhS3pJSURFOUhQR0pWa3Vi?=
 =?utf-8?B?c21DRnJXL25QTFFTOWNxZ0k1elRKR1B1T3FMMy9KS0FHamdwdk5mOXRoRExp?=
 =?utf-8?B?SEFEc09FcUVWb1ZRRzBsTnJ0c3ZWSjVVYkU0M0RzTFZPT2l4UjlDUmo0NVFo?=
 =?utf-8?B?ZHhGdmpHMk5adW1ob2JBQ3F4U2FqMHZzWmljNE1oVm1EaU4wRllRU2FBU3Jk?=
 =?utf-8?B?WnB0VjdURGMxVHZDanFMWHVaVmQxSU5mT1U1RjRaZ3BJWHluSGs4UVpyTkM0?=
 =?utf-8?B?TWlOdXVKZk1leHBXSWJvc0lnK25XdGhKRGM0YTFJK1VVTWlwNURCMG1mRmRl?=
 =?utf-8?B?dEwreHRUb2xNdzZoNWFERU9DQ2cvcWtJWUpya2tzM1p1UkphZExickZxRDk0?=
 =?utf-8?B?MXZRTkdNZHN3SDFHaUtPUlh0TkxMVlVPM01KM3VLN2l5THlmb2Q3SHZLaDVq?=
 =?utf-8?B?c0p4T2wvQkZMbWFVUWtxNHZZV2hvVXhMaWxoemhaWDlzWStJck5zUWMxdUFD?=
 =?utf-8?B?bjJwSGtNelNiV1o3cVRSWXZyUmZEWEZsR3A3WEd1Y2JUZDN3QmsyQktHR2Js?=
 =?utf-8?B?NE5XQjM2YVZkRDMyekZrWjlBOThZRVl3cjNtZHREMlZ3dDJjVlM0eFJWMTkz?=
 =?utf-8?B?Y1k2V041c2pSUkphanRJMklaVGZIdmdXYU1EWFluLy9GNTRYc1dmUVQ5YWNC?=
 =?utf-8?B?MFBPQ2tBYzJFM1B5ZWl5U05RR1NRcDFvRFhhZ3hmNGx3MU5tNnFXMy9FaEcv?=
 =?utf-8?B?ZTB6RXRpR2RJU2lVb1AvdDBoV3l4Y3NsVDFNaUloM3ZtakZ1c050b0ZMeFVM?=
 =?utf-8?B?VjBQU0dCQWxSZDdWVGpMWFpKRzRtWGVia01IZ1NVSDQ5VjVqYlU1Rm8xNEhk?=
 =?utf-8?B?UDhxVkc0YzN1cVZEUjdPbHZFWEVHVkUrWmxqMit5dlFDOFN4UlViNUlVQm4v?=
 =?utf-8?B?UmxqUXJHS3h3VS95RDVtZkFJMWFGRFhKWTM1blcyaU5sK1BaTXJwQS9rZkVv?=
 =?utf-8?B?VTZqRDFzNkp3eUk1UW1yMjc3TnNyQlFvTzQyQ0lYb3VGaEYrSEo0N2VZSklD?=
 =?utf-8?B?bWZ6KzAvY2s5azlneER0aEMyaUlNTkJGOHBjOFpCRlRNRGN4cGZIbXRqTDZw?=
 =?utf-8?B?Wm5aVmVQU0JUMk1mcnQrTWl6VHBjWEtXc3d6bTFNRGJiMXZRQVFEbDkvbC9i?=
 =?utf-8?B?OU8xdExMOHA1QW1HMk9id3J6OUlCTmo4VkIzeTBKbEo0YmcvTXdsZ013N3ZT?=
 =?utf-8?B?WEgzdnFNalduZm5jNVhPZ1lxOFlaT2d1R1V2U014WjB0Vmsya2JTZjRwU0Nq?=
 =?utf-8?Q?bkB4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckJhdFRWU1pJbmJISmk4b083TGZMZG1PTHVJb0FvMFlzTUl1Z1d3bHhrYUl0?=
 =?utf-8?B?VFhmRkV0TFdlOUhDVldyZkVZT1lRWTBtOUMrZDcxaE4yZ1YyY2ZOdHMzYm0x?=
 =?utf-8?B?MEJ6K1NJM3ljSkZQVWp6amRTNWxRRXMyTjQvaDdrb01VK2Y0SHV1WmFRVFJ1?=
 =?utf-8?B?clJZN3dEVHZPRTJPYTg0NVJnY0VwSG9SRHhhT1ZxVTYxODY2TzBLQXhzaDcw?=
 =?utf-8?B?WW5ZQmpRK2ExbkpIdldXWHlGZUkzbSsyTEpnakZVekVvaFZlR0Z2dnk4d290?=
 =?utf-8?B?cVRnRmxvTWpMcCt4NlEwZi9GUDlOVlM1eEpFZy9QbXQrUXBkaFV0bjlObjhj?=
 =?utf-8?B?VlJWbGc2NW42bEN6Yml0ZmR2RzVZMDR2bEJXdk5BcDcxcFFVS0hlN21uK2Np?=
 =?utf-8?B?dUpmaWZ4alJPb1BGUVFSUzVGVWVEVzhaMmlqUVBrVzVIekR6dUJSMUNLQ0ox?=
 =?utf-8?B?Z3lveDUyQ1d2Y0dMay9HNDMzelpHSTRvcWRZWUMxenVlSjJDTkk3N2pCd2RP?=
 =?utf-8?B?emcvbmZ5Mm9mR2FrYUtra2xWOGpZQ1FqdU9tUHZRdWNmcnhrQ3lDelJnNzB2?=
 =?utf-8?B?RzVTR1R0eU5GMzhQSDlLa0ZIYzZDaWNHeGl6Y1NveE80dGp6OWRROVFPcWJq?=
 =?utf-8?B?YzR0dm9XWU9jbE9RTVRlU3k1ZXJGeDRGRVJKWENZUy9ZOWJWWmJlemh6QXAw?=
 =?utf-8?B?UmFuV3BiZzF1V0JqLytOTFF2RG5rN0xQaW9FYzZzeU1YZHRxUnlqK1FISGU1?=
 =?utf-8?B?Z0g3REpqMzFUVTd2YXlKbjU4ZUZxVkRFMFRraVVaZ0lWMzljcnBVVTAwODFt?=
 =?utf-8?B?bGxZRXpMNC9LSllTUTRWVWVDTXg5MFVEVWtwb2NqNzV3QnRoMFpEdmQ5aEhK?=
 =?utf-8?B?a1ArUE9iYXo1b2l1cHgvaFFnYklkYlVaV0pQMmllczFyWUViRGZ6d3d4eGYv?=
 =?utf-8?B?Tm1hWDd1RXByZmIyMS9haUtlUHdiNyt3dzg5S05hOTFCWEZuL1c5aHllV2sz?=
 =?utf-8?B?bmgzNHBIbGt5emZVbEFqRUFramtrY240QWRXV2FYeEN6SUlNRHNUSWt6SWRB?=
 =?utf-8?B?TVN5SVdLa2VMczJ4eTZJSUwzcy9HbFJhS01ncWNxVmpxdUkvRlhMeVRpT1VZ?=
 =?utf-8?B?bzhuVVFObEloelE1VnVyaExnTjRFRXpuSU9EOHZhNDhQMjF4WlI1WHV1aG11?=
 =?utf-8?B?L0pvQlZ5dGtmS1BWYytTYjBNeHhkdXR0U0swaEhFcjE1MGcxckpFN3lSSUVX?=
 =?utf-8?B?VzlrK2svVHRMQ0ZmOHFkNi8xSENhbEdhdDF4aitXZU9FNlBkdXBzU1N0ZHFG?=
 =?utf-8?B?dkErTWNNV0tFRDRKQjdhM1JTWUtxZWtuanNNNzdoUWVuckxHZHc4UmtHWWo1?=
 =?utf-8?B?QnBPVVVPaW01WFlBQXBZY1lSUTcwdUgyL3pQZ0FXcXhxWERlYURad1dXbXFE?=
 =?utf-8?B?aENlbmdYeitoUHFmZHZ1aDloRVYzbE84NnRSUzhTWGZmWTBPaEZYMWh2SERY?=
 =?utf-8?B?SFU2TXRzaGs1cldhS21xa0Q2VXRWa0J4V2NuUE9FempYSHdxRTBkZ3ZJUTJU?=
 =?utf-8?B?SHMxOUpEK3hSOEpHS1BFRFMrblJybFNoMlBGOWtpaU1rKzFsUkNNRWV4ZStZ?=
 =?utf-8?B?ZjkrRTIzK2tDTU0yWWZxUmJHYStuUFNqOXRib2F1TE81cHNxdFIrK3R3QjlL?=
 =?utf-8?B?OVV1MkRhWldzV0QrTlg0R3VGOWhzTEczdE4wZjMybUlqUDVmcmgzK0EreDc3?=
 =?utf-8?B?ZGVmaWJ5aTQxQjVsM3dHdXY3WVVGSU9jZ0ZxZ3Fwd256REZyU0U5aXBQMldh?=
 =?utf-8?B?NVdZazJjNWk0WHp1a0hlWFlnOVFTUldqa3grN3lLU1JmUHpCZXgrRSszNTht?=
 =?utf-8?B?ZUxXWlVKZGxqeUdlZGd3WmxrWDlWR1VzTzBuSzJXZFA3SzlUbGp4c3VwR1Mv?=
 =?utf-8?B?VDNzbVh0bU1iU3F4My9RMzVrZVgyWVIwRGtrZXJibk5rV3FsTEVuUTltdFlI?=
 =?utf-8?B?ajgvUzJyTm84UkkrZXQrR1R4aTNGNHlhUzROM0pNSzRXakdpQTlRZ3FuL05T?=
 =?utf-8?B?QVNpbTV6Yzg1YXAyNjFqVERkMVdUNUJQSEpUMmJQZU1RdW1rVDJXZXR0MUlT?=
 =?utf-8?B?c1Z1Umt0K0h2S1pxV2xraDVKd3lrdTBTeGY1a3FpckJ3ZkNERE9WNlY1L0kx?=
 =?utf-8?B?MS9md0NSMTRKVHZDODBlTUlNb3ZUL0NFV25tYTlpUkc4VE4yQ3p2YndBQzZh?=
 =?utf-8?B?UmtwOU5HNkw2aXdUUERHRnA3cERHRUtTUE9ZN0NzZ0ttS09qMk8rcEdack0v?=
 =?utf-8?B?WDhjK2lmUVFLTDFiZFhzRkU2WkVZYlk0MmIwRzRGbnQvcldBWTU5QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf92ccdd-5840-447d-f983-08de552c7e92
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 18:24:32.4713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rF+2d4Vt6zr1uDJWckI1LEkxBSZnLnS4oNW0RoypmFqHrfmtJKPKYDEpZA4PtMl1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217

On Fri, Jan 16, 2026 at 07:19:50PM +0100, Bartosz Golaszewski wrote:
> On Fri, Jan 16, 2026 at 5:41 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Fri Jan 16, 2026 at 5:04 PM CET, Laurent Pinchart wrote:
> > > Based on the discussions we had at LPC, the revocable resource management API
> > > is not the right solution to handle races between device removal and userspace
> > > access.
> >
> > Please see: https://lore.kernel.org/all/DFQ5D44A0348.PZJIGPL972N@kernel.org/
> >
> > > It is however a possibly useful tool for races between producers and consumers
> > > *inside the kernel*.
> >
> > Do you have an example for such a case?
> 
> Isn't the GPIO use-case - which the series on top of it addresses - one?
> 
> With fw_devlink=off it's quite easy to trigger all kinds of crashes
> with in-kernel users.

Does this series solve that? It looked to me like it just replaces the
existing SRCU with a wrapper?

Jason

