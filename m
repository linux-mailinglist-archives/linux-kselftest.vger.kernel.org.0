Return-Path: <linux-kselftest+bounces-9354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B1C8BAAFF
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 12:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68101C220E3
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 10:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D231514E2;
	Fri,  3 May 2024 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RVi5kjBt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12D914EC5C;
	Fri,  3 May 2024 10:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714733290; cv=fail; b=Hbu3apIyZxK+cnalWDVk4FwREIJFsTRp/afOmy8ZO67FWOyiAxMQOvx3ljVcWCOukyQP0yvkit7T9Ji7Gg56iz+w0oxG782g/yOLqgIQyMF9Qhx/lCys61h4NgjByo6XYieNWQTwkAjukOYTftCFA7uTqm1Scb+IGIcihvGWOzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714733290; c=relaxed/simple;
	bh=4pfpnx+4pEYCpM2l/eL2TL4rioIoIxrGJ7T2T6+EzUw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m4+76ZVNUerf/Vzpg+2aruTe7PWJ1xIKpefYMernXYUfCO4aACdJfC7MoY+EogZD0/0IUE7s+4RAMVdaSINJtFoKyAOhd17/J65OL218Slhi00BlkoLib/T8op9VI+/MZmDEDM8QZULtsFBiqW3Wr7iHhW7SCwbUXRdRmWCQGCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RVi5kjBt; arc=fail smtp.client-ip=40.107.96.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1SJ0CUMXBSaNwHF3B/Ei5iaIntFhSCmFB9JNaxKIPmuOP1v668f+mIcm2aFdmVMNzuw8jcx2gXJHgRm1/xcvThuvdMt8Z/bM75YA3z26UC/VBrxp75o4BnWLSSa7MBkZd4V44Wua0HslKMQvUU1UnIOVyokrfwRSZ2TaCYXbPObuFn0wcyHDeOwm5xuqCBhqVIXxEVzHmntO7eFD0wtOuS7pORZxs+jU9nEQtPDeYTUPfSa0HOUx3+vlJcbBkRLAy23/dEOtJuUCRWYYu68nn38IRPpIZNVnEB5AJkFIZhff7Oido3hmjfURZm0VISBtCJ6wA0CiGD+YV6jyASE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUqEKqkSZyVUHX94haLmhXuObAmxjX8fq1SC5XdVAb0=;
 b=DwmmYm8ljthJ71sP7dG0pUk5gMjkJs7eO4+GYKgoqWU7x9/IkrvV/4jEEdnUhH9iIZphox2JwKGJZrdThfdHxHf0dAS/9460sBBPNshOhCpRIs+jargZTUUIpw3+o5MOG57k5Xw7leE67+wkYsx1ipSbP5OC9mokIIKEdHvkzkqJ5rZHovnz7ZegE2nHW0fm8+6lSvSM9M/+ku3ytWeeJfYy6H7O23VxniuOsADdjCIHNWbiC3CSh33rJ9/mBkhTR+YUluUKIIGcG+vaNnwRN9zj1zA/YD7/4rmH+OXW7gvbYi1tLIVuvX0ZbE6mRRF3pzjWG0A3uNsdyCv96XMXXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUqEKqkSZyVUHX94haLmhXuObAmxjX8fq1SC5XdVAb0=;
 b=RVi5kjBtisAiQvx0zt3IIrPuB5lnKC90gQbWEKg6+RMA88ZTwy/eS0ZUMCFH3Xe7MnF3xrV/MF78FWoiBKU3eY/Vh4XOyaewft3AJa4WEUdjJyM96a4QGcIXrreSg2iNxnWxWpevWcKGBixpG/h6sGhwFzNGvzrfS4INV/FkpWs3+lf/AgYNl1qnHIKRlbsKaDWX6PxvWiuf/5/UKEY483+65vKNmcp4AJQ+3vQ2w/exxDHgJKqZmFsYg86w8Hdwv5RE0kdDfK9QSL3o/tA9xDyfIJG3PYlfXrtvlSrpHzMfzkIZCQJmKE8CFfCtj14/VJiPba1rAsE0rSRpFlHLFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by IA0PR12MB7506.namprd12.prod.outlook.com (2603:10b6:208:442::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 10:48:04 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::bbac:e733:5c7e:19c6]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::bbac:e733:5c7e:19c6%5]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 10:48:04 +0000
Message-ID: <6ea936b8-b036-467b-8186-f461b7eea5e1@nvidia.com>
Date: Fri, 3 May 2024 18:47:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] selftest: rtc: Add support rtc alarm content check
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: shuah@kernel.org, avagin@google.com, amir73il@gmail.com,
 brauner@kernel.org, mochs@nvidia.com, linux-kernel@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 sdonthineni@nvidia.com, treding@nvidia.com, linux-tegra@vger.kernel.org
References: <20240503014102.3568130-1-jjang@nvidia.com>
 <20240503014102.3568130-2-jjang@nvidia.com>
 <202405030649157e9de2ac@mail.local>
Content-Language: en-US
From: Joseph Jang <jjang@nvidia.com>
In-Reply-To: <202405030649157e9de2ac@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|IA0PR12MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dfb0400-fce3-4db6-ffb9-08dc6b5e8294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmVZTXZxaHlTSzN5dW95Ym5udlZzNXNYRkgyYmxqbHU1Tk1zUE9EZEVRd3B0?=
 =?utf-8?B?QkxHbS9sVVdyZWdvRTlmUHREU2tCQjY0YjdXcFl6MmJRNi9kY0xRZE1oUnk3?=
 =?utf-8?B?THZXUnVOazdncXZ5NllDTmJpUlNqYlYwSG4wbmpLQXE2cHFIUVVjQWxtenpm?=
 =?utf-8?B?c0FUanFnMHptQzFBc2I3K3hZSTZyVGllVGdEQlVveGxjdmtIOUlsZDhyMzAw?=
 =?utf-8?B?Y2VjRUdxcTk5MHpQYjJldFVINkdlNjhBcTd4WTNGNExVYVNkM2ZIdVVjTXVz?=
 =?utf-8?B?bzJEbVZHR2JUZlExYnpralhiZmNoZ1NFVmRYeXdMQndHKzB1SGRWeWlhTDZx?=
 =?utf-8?B?bzh5eDhnbnBwazFTcXdtbTJ1UlI2Tzg3T1p6S0pSQ1Uzem1JTTJmOGxQd1Rj?=
 =?utf-8?B?UWV4elJ0VHRWLy9sYjJ6c3U4VnhFNUM2YkN0YW44dGJJOUNZZmR5bTMyMDFr?=
 =?utf-8?B?RDhBL0RITWlZNVFhZlVDWktDSE9mWjNIdlFVdml4cDJwUzBXbkliZEsrQXVi?=
 =?utf-8?B?RzBPaDdMSGtodUJFYjVLeDVCWlZacWh6TkNTRmE1bjdUSGdYNlc0QUFmSENT?=
 =?utf-8?B?bDZMZFJadm12ZGk3ckZCRmNRWnhQNi9nSGtZaUJLR292clZQcEtuM2xSem9o?=
 =?utf-8?B?b2Y0WEVYdzhwMlZQMDh0aWJDVWxtM2dWS1BvWWpMVHpFTzNnb1ZhdEtxRkdj?=
 =?utf-8?B?SDZRK2dkYnNFTDhHZHZ6dEh1WkZZSTdGRk52YUJzeTY2TDUzQXlra0hIcVVR?=
 =?utf-8?B?UnVYSUY3MG8ybnhlbXIwZVlCS3ZZTDE3NmY1eHJqQmdVSmxVK3FYa09NZUFC?=
 =?utf-8?B?OXhmU0xqTXg4UXJWeVF3MXZvRmsraGMrSEc3cVJBaUt2VkpVaXY1STdmRGhF?=
 =?utf-8?B?MnF6MllBak8wRnRxMmh1UkVBZmxmNnNLWnkvSU1JKzJabDlQQm51OHRzN3Zt?=
 =?utf-8?B?WUlDUm5pUkQ3d28rd3dvRzFQSUZOMVpSc1llRFQ0WGxRVnFSWTdmdmVzcWpP?=
 =?utf-8?B?b09ycTdCTGdiN1ZrMDRXOWtIdXBWUWZUVVM1T3FqOW1ZdmE1RVMwVnFSRm5G?=
 =?utf-8?B?eSt4WHg3RzI4eEY4N0lXVzlEZy81SUR2b25ONkFEZzdqdndFOUVPLytacWI4?=
 =?utf-8?B?clo4QWE5S2hYYzZZWElXQ01vdVJtbGRLZFVEWGZzZHB4UUZTQ1M0MTNlNGxh?=
 =?utf-8?B?Q0Y3VkRManR2RjdYZDF5a1llZ3JKRzBjWVZQalJjcGpheFI3cmY2Wi9GVEt2?=
 =?utf-8?B?eXNuK3BsaFphWG9idzRnRE9KLytHZGxsL3BrVHhCblBZbmpVVVJQeFQvN1Fq?=
 =?utf-8?B?Ykd6L2VvcnlKZWJFZHl2dkQ1L3hOMXNPZWJCR29aSHVUUVlkUlBzSVA5SnJn?=
 =?utf-8?B?M1B3NUxZZFJmV3pGTXlrY0NZSnEvdXI2ZmV6Y3FzendjTDA5aW5OVkJUZG1G?=
 =?utf-8?B?T1ZDRmtCMzdvemxVcm96ZTVaUFpwN0NNR1pCZHNnazFIQTc1bWUxT3ZMYnJh?=
 =?utf-8?B?REJzS1R1OFRWNi9nUE9lUlZQRjd2MXJRZ0JPdlc2RVhUdHd3Y09EejRZdXRk?=
 =?utf-8?B?RTRySXVMQm10a1hKNDNBbnNRYzFRV1BUd2hUUnBxZ0dLbi9sa2FiY3B6bzNJ?=
 =?utf-8?B?RlhSVlRjRXh5SkNSVVlodWtpOXp4Q3ZZZUtXdHY0ZlZyeXM0UHQ4SkJnMlJE?=
 =?utf-8?B?S3F4bFZUa21OU0lFbksvVXF3VmNQRjc3SzhMalFSTnMveFcvcGlXN2V3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajN4aVRhenp0MFJNdGU0NWlPQlpDVVVxTC81d0NqQ24wSGw3cENMdVBTL28x?=
 =?utf-8?B?a09QTlhCdmFBY0FBSmU0b05QUzB5M2NJaTc3bVJ4L21VdXNZUTJ4VURsZ0JX?=
 =?utf-8?B?YVRBZDJySXlLOCt0STh3SUpLdUZKVVZ6eW9uNHVmMDdvL2JacFpDVjNmQkNx?=
 =?utf-8?B?R3ZzK1pEOHl2Z0E1WEUvSnNsZXFyS1ZMRWJqYmIvQlZibFcydnArWVlOL3hC?=
 =?utf-8?B?UDNqZG9BamMzWDh1bmFiUWtrMjFHR2NhbUxVMk9wRk1Oa2V6a0pwZjBnaCti?=
 =?utf-8?B?bVVqaWhMWTZrLzRwSmZSMkpIVjFMaktJczEydWxuSEtpaGUxNHYrL2JyT2dX?=
 =?utf-8?B?VE54bk5ta0xMUkVseU9nWDdtRjk3dUNadEtGYzltQ2lrQmh5bi9IRk1SSTVp?=
 =?utf-8?B?MU1xcm90WXJyaTIyMnNha2o4b1daRmE0dEpLemxHN3RDbnNzUnpWdU9ISUY2?=
 =?utf-8?B?S25qNUZocU1mdHc2cUNCNlErUkdwRktkTnBUTHJnSEViSDdOYkQ4TnBVZWlu?=
 =?utf-8?B?YlFXc212TTNvaHNpWll3T2syNW8wTzZjOStwSWJxZ3NsYVUvN3QzU3NXNVo4?=
 =?utf-8?B?Rm1obzZUdHdEQ3BlcTlWRncyM2IxWGYwdmZKZGJqcCtaWi8vdk9wMmtURmpm?=
 =?utf-8?B?UXJjdU9mTzA5VFM4R1NsOUlid0ZnZDQzNzVtamN2V0cvc2pTbEdPMVMyK00v?=
 =?utf-8?B?VTZ4TlM4a0ZXVjJ3RmJVTGJuZHExMFc4b1hMbk1RZFB4NmY0bTIrNFVxSWx3?=
 =?utf-8?B?alZ0eXdFZzlmZDVIb2x3YVhDRTZpeGV6WWU4M3V0WHhHWGU1RllHMTZhRzRs?=
 =?utf-8?B?d1dUcWFBYUpFVnZKQXRFNUlKUTltcEJuVG1XN1l5dTh4Q2tBeEpFVlpJY2dn?=
 =?utf-8?B?ZlhyUzQwZDRVT0tyc0VKRW9la0dkNG52eXEwWnNUUkpwaVlWTTA0YXVjVDQx?=
 =?utf-8?B?bVVoSGJ6dXExWERkTStlZzZueCtJTzlhejBMa1QrL2dpYTFMcGIwNU9zNlYr?=
 =?utf-8?B?SEJGb2xBTk1Ob20rQkliOGIrc3BVdlhIbVN1NzArb0UvcDFoQy9pbmlnM1lq?=
 =?utf-8?B?cktuR2dUajdjcFJhRmdCSWw5QlZpcUVKZ1dzTHZkVTF6Ky96L1pxRFZjRVVD?=
 =?utf-8?B?RXZEL20va2tBUDFLMHl2L1ZNWHlEWmJkb1RzUGxIbzRyT2RjYmI5T1lTK09W?=
 =?utf-8?B?QWNoTUtwTWxwdDBGQ1dET2hXaVJlN2JJWGN2MVJWQjRFRDd1KzRTWlY0YUpL?=
 =?utf-8?B?ODVxdlV1TDhZa1RURmMvWnAyMXNQajBMeGlDNEdyNTdoU0hYZk00eUFSUnhv?=
 =?utf-8?B?MnZONDBub3k0TUVoMTBzb0pxYm90ZDBvYld2R3BXNkJzaHVnbDJFUnpBWllE?=
 =?utf-8?B?YkdoQkNXd2dIV3RaTERKemMzcUJxWXYxSGIxSm9keE5ieTRsTDlvUitBL3VK?=
 =?utf-8?B?V0tYSnQrRERXZDBkdXFHckw2WGpzVlBrZEIxTTc5ZGJ6UlNuZGxqR0pqZ050?=
 =?utf-8?B?emJDaEZaWG00YjRBWEU2VjFXTkVhZVMyc0gvRmRmN2VGZGYzd2pNcVNpZTJ3?=
 =?utf-8?B?YUc3Nkg2Ry8yMkVHemYyNnErT1ExVS8rUEpoamRtNitnSFFXdHM4ODBkQlQx?=
 =?utf-8?B?V2VkTGlHVkwrZWVRcXZnUW56d0lvOUxsQmNDaFAraTFPLzUzMGxmbDZQcVdv?=
 =?utf-8?B?Tlgwa1ppcmk3dGFaMk12Y3FERlNsQ055dCtoaUVGWmF3OHJ5aVlpeGlCbmgz?=
 =?utf-8?B?L2NldW01dGthS1VvSXduNzJQSTUrRGFGZXFKTmN2eGJVQkZRU1lReGRkMmkw?=
 =?utf-8?B?Qm9FUmdzK3hiZjJCMUxGdDdhSUxhSFlnVnVqMmNOU1JEZEFJcWc0NWlSUVlB?=
 =?utf-8?B?MlRSeHJXL0ovWVhjQWx3QXM2RS9WZC9OZnZOTkZQcEExbStzNlBWa2tobEFE?=
 =?utf-8?B?UVJidkN6eERpdW4vQlpDZHp0b0lMMEJ5d2xKVlZ3Z2JtcWkxa29KL2w2dXRv?=
 =?utf-8?B?YVZOcGlyWlBIWmdORlBVa2ZmdzhPNUpmdXdUMU9sSHFoNnBtYjhuM25MRnhT?=
 =?utf-8?B?ODEwK0dDNU1MaGRtY2NJR3dtUUFSTFBnekFYVTIxR0tla2dGOHNMWDB3Z28y?=
 =?utf-8?Q?Csrhmx+5CrTSt+W19bV7bMbBN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfb0400-fce3-4db6-ffb9-08dc6b5e8294
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 10:48:04.5165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fa8FM39F/abSh5+h9IFmFbh7ibGKExq5qaPc48+9qDKEbgBHBslG8ejdsccZO7H0FNzThGCMRzTlYASC/Ak7vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7506



On 2024/5/3 2:49 PM, Alexandre Belloni wrote:
> On 02/05/2024 18:41:02-0700, Joseph Jang wrote:
>> Some platforms do not support WAKEUP service by default, we use a shell
>> script to check the absence of alarm content in /proc/driver/rtc.
> 
> procfs for the RTC has been deprecated for a while, don't use it.
> 
> Instead, you can use the RTC_PARAM_GET ioctl to get RTC_PARAM_FEATURES
> and then look at RTC_FEATURE_ALARM.
> See https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/rtc-tools.git/tree/rtc.c
>

I found old version kernel doesn't support RTC_PARAM_GET ioctl. In order 
support old version kernel testing, is it possible to use rtc procfs to 
validate wakealarm function for old version kernel ?

Can I move this rtc alarm validation to 
<linux_root>/tools/testing/selftests/rtc/rtctest.c ? So we could try to 
use RTC_PARAM_GET ioctl
first and then roll back to use rtc procfs if RTC_PARAM_GET ioctl was 
not supported.

Thank you,
Joseph.

>>
>> The script will validate /proc/driver/rtc when it is not empty and then
>> check if could find alarm content in it according to the rtc wakealarm
>> is supported or not.
>>
>> Requires commit 101ca8d05913b ("rtc: efi: Enable SET/GET WAKEUP services
>> as optional")
>>
>> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
>> Signed-off-by: Joseph Jang <jjang@nvidia.com>
>> ---
>>   tools/testing/selftests/Makefile              |  1 +
>>   tools/testing/selftests/rtc/property/Makefile |  5 ++++
>>   .../selftests/rtc/property/rtc-alarm-test.sh  | 27 +++++++++++++++++++
>>   3 files changed, 33 insertions(+)
>>   create mode 100644 tools/testing/selftests/rtc/property/Makefile
>>   create mode 100755 tools/testing/selftests/rtc/property/rtc-alarm-test.sh
>>
>> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
>> index e1504833654d..f5d43e2132e8 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -80,6 +80,7 @@ TARGETS += riscv
>>   TARGETS += rlimits
>>   TARGETS += rseq
>>   TARGETS += rtc
>> +TARGETS += rtc/property
>>   TARGETS += rust
>>   TARGETS += seccomp
>>   TARGETS += sgx
>> diff --git a/tools/testing/selftests/rtc/property/Makefile b/tools/testing/selftests/rtc/property/Makefile
>> new file mode 100644
>> index 000000000000..c6f7aa4f0e29
>> --- /dev/null
>> +++ b/tools/testing/selftests/rtc/property/Makefile
>> @@ -0,0 +1,5 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +TEST_PROGS := rtc-alarm-test.sh
>> +
>> +include ../../lib.mk
>> +
>> diff --git a/tools/testing/selftests/rtc/property/rtc-alarm-test.sh b/tools/testing/selftests/rtc/property/rtc-alarm-test.sh
>> new file mode 100755
>> index 000000000000..3bee1dd5fbd0
>> --- /dev/null
>> +++ b/tools/testing/selftests/rtc/property/rtc-alarm-test.sh
>> @@ -0,0 +1,27 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +if [ ! -f /proc/driver/rtc ]; then
>> +	echo "SKIP: the /proc/driver/rtc is empty."
>> +	exit 4
>> +fi
>> +
>> +# Check if could find alarm content in /proc/driver/rtc according to
>> +# the rtc wakealarm is supported or not.
>> +if [ -n "$(ls /sys/class/rtc/rtc* | grep -i wakealarm)" ]; then
>> +	if [ -n "$(grep -i alarm /proc/driver/rtc)" ]; then
>> +		exit 0
>> +	else
>> +		echo "ERROR: The alarm content is not found."
>> +		cat /proc/driver/rtc
>> +		exit 1
>> +	fi
>> +else
>> +	if [ -n "$(grep -i alarm /proc/driver/rtc)" ]; then
>> +		echo "ERROR: The alarm content is found."
>> +		cat /proc/driver/rtc
>> +		exit 1
>> +	else
>> +		exit 0
>> +	fi
>> +fi
>> -- 
>> 2.34.1
>>
> 

