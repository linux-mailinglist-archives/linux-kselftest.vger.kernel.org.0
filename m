Return-Path: <linux-kselftest+bounces-9370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8023B8BAC4D
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 14:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F451F22D7A
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 12:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7110A15351B;
	Fri,  3 May 2024 12:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PHKMwOFD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A105BCA62;
	Fri,  3 May 2024 12:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714739014; cv=fail; b=ftt+TkE4POH+oWTmTEPTyHSC6+IvxSpP3y+7GIdN4zJ2EWjSSfIfCLaS6P7QbKm1/XmnQHuuqKBdZGWHz0kUJzMuvArT+X4Sdo7X5QUEoRgdE1J5vFbdw1W9jYEQxiPnoLryZiNmK83xa5WjRvAldpVr3izDeDUs/ZScuzAsxXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714739014; c=relaxed/simple;
	bh=/9LkdQt3RgWkjldOixCQe6yvtiWybcSTC9ZeaXRAnxk=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZhhDxZmhYP7nbqIrr1iA8KgKqA13n53c6LEFwreSrIt0QDgciYaHosjZ9r+z+vCzTwSYB1IhN/0Bl8DHJShBjtETfdrfCPJHBQfxil2yAw0k/d5c6dunOslAEaFGWWfaTErlzdWqP2vnYCKJCVJr+c9f7Dqh9Go8tBJGB7/9KTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PHKMwOFD; arc=fail smtp.client-ip=40.107.101.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DonCjVRWbLfPR4XzxmCYqSGahU67OimFVCQVQZLzRS0MD41cStGQJAkMD0WxkD0UIr1nLQsVCqZP0Lufm2D8ptnKAbMJS77YUAOd3sure/1UfZ1FCtbh9RrhucJSAm8jrkPvWgN5dGR15DB8HuI2J5dGf9ZMdfFGFe1VleGvMB0g2aXMnM1h0kCN2HhI5c0ybJyxUdOKqvWzdpbX2PQ5d1tuqJOGZCnfIi67EkNjzyITrAvmbJMjYvAP192CmNMlvIDn7gW3rno2dTJIviPdlWpExA1t+VF7JsZ4Fdy26UMukopGoQN2tX9UDEJ7ZAxRURUuRCMIrOI0u0L21nCcwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSG2O78aAoHTN3FhJk7BJUa/Aan9Cre40vOgGjlvBec=;
 b=GwfLjTrYo+479Xn2kaGAhYymGqDrOPQjsTZj9XWLTGuicL1F+9LKMBTgaYKBbB1egcxuQOOdZiYLG+WcJ2KvvAth4nq9+39Y1BgKsfOcK23FXO+UEqASBk1rOZ7ZcvKQ4vNNPRkYmFGe6ctHe7rgBTwtheNw0QtSUMQUjCYPULaBmSrJBvD9rGpFjovsC4JmfAnvCswqXqg3Z+oZTcz6WA+JTytYlJ3By7/sEOMWrGPRLU6MlCkT1JgFg2t8FPXrnWFj6Y9Va+VDxrQbtVlg8nhmR4y/9OaerWqwGmRGj6EWIJin65vghmRT9YyJ3jiAWtqSTMjTLn+elzJbJstCUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSG2O78aAoHTN3FhJk7BJUa/Aan9Cre40vOgGjlvBec=;
 b=PHKMwOFDQQ2LrP9ri2l+cGTY5pCc3f2SY+F4gWAUn/ZbLJ16+Ph0cWKxDTW6QJbO7HkVbKzzcIyA4TRyHmb5KxMuc66X7LYu8bwLPi3NnF62/DWZ7n8jYxkRyRiqAwUQW7c9ZowlsTyalKsVaRXAxc2BtUr0N3ohM78qyqs8bW3ClDEdtokCRQOCy4UreVXoIUzutKPAucsmlk08MqHW8cqfZQ5yjJ0q8ihaW+xtFh8Fm7SgdCSZ0W10NCHhvoH00a8diYZ/gPcQUYdu8lmDZs/CwfKkSqT+Lfy21Ohv0lJLm6ZqaGFvzgDsIud5+MwrkwOWBdO2dPLRzK3AUqdAPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 12:23:28 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::bbac:e733:5c7e:19c6]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::bbac:e733:5c7e:19c6%5]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 12:23:28 +0000
Message-ID: <4f975b98-8aca-4591-9cfe-7f82eed3ddab@nvidia.com>
Date: Fri, 3 May 2024 20:23:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] selftest: rtc: Add support rtc alarm content check
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20240503014102.3568130-1-jjang@nvidia.com>
 <20240503014102.3568130-2-jjang@nvidia.com>
 <202405030649157e9de2ac@mail.local>
 <IA0PR12MB83745321F32B6FA0DE041D10C01F2@IA0PR12MB8374.namprd12.prod.outlook.com>
Content-Language: en-US
Cc: "shuah@kernel.org" <shuah@kernel.org>,
 "avagin@google.com" <avagin@google.com>,
 "amir73il@gmail.com" <amir73il@gmail.com>,
 "brauner@kernel.org" <brauner@kernel.org>, Matt Ochs <mochs@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Thierry Reding <treding@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
From: Joseph Jang <jjang@nvidia.com>
In-Reply-To: <IA0PR12MB83745321F32B6FA0DE041D10C01F2@IA0PR12MB8374.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP301CA0036.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::20) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 295b84fc-41ad-4fcf-bcd0-08dc6b6bd632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEpxcFVQMDZYaUpXU0RVdzRSYTJsVWZBdjNSZkJpMm1zbzhvM3FWN0FTZVdm?=
 =?utf-8?B?Nm9iZnVMaU12MUhOV2IzQlJMUXR6YmVtU2NuNXZrdTJNT0JCWDFjcWxlenNi?=
 =?utf-8?B?WmtkbVdjZ3NmY1FieU5DTmhBd1RzNklOektud0kwR29rWUNPUUx3VEN5VzRk?=
 =?utf-8?B?d1V5QzlYVWxUczMzUVBhZzFnZWdyc3UxNzVlSGJGYWFQRmo4OFpGb2tGeUdu?=
 =?utf-8?B?TVdaWEs2VGZKUk4rSENVTXhiQ2ZKRTdTbDg0MzhaenQ0ZnlueGJYSVdYU1pC?=
 =?utf-8?B?MC9FOHVTS0hhbVpwZEw1Z3JqT2R1TzA1K0xBakp2eGZwLzM2bERlZlNPeEpm?=
 =?utf-8?B?QzlYZ3dBYitLME5OYWRHT1Z0YlUxc1VFNVBSSC8zT280eTB3R0pPSnNaaFRF?=
 =?utf-8?B?YUFyN0h6ejQ3dW5TVno3YmVwUkZnM2UxU0RrTGlTSXdMUWRld3ozUy83OFNy?=
 =?utf-8?B?Vk8zSFNjQVQ1Z0JHdEc3OHRQRmJHWk9DR0RTN1h5WStmUWxIQUh6THMyK0Vl?=
 =?utf-8?B?NFVHajZ5RVNWWUJ4UzBvb2YxUVJ4ZFZJN3E3RjF3cGxkekRxQUZoTCtvMEdU?=
 =?utf-8?B?STNNK01WYjZOOG1QVmJ5U1BoUDRQbkFXTDdmTm1JblY0RUxtMEhMa0FCRmxV?=
 =?utf-8?B?RzJkQzhFT2Q1VDRNK2tuc1dMWWxoZDdZaXVPZGpZRkxFMklQKy9PZlYvODdj?=
 =?utf-8?B?enJEOVRZWk9wdGxPMXpQUEJnMGxkNEZDcHladmRIM1RUZFVYOGZueUFLRjBt?=
 =?utf-8?B?M0poL3g3eTFKNkFTR0xiNFQybHB3bXRhYVNxa0p3NmtVRk9lck5BNkFZaVp4?=
 =?utf-8?B?dFdSU1B4NTBkdytWYzQzUEJLNUd0R3FmQ0hoNnpNUVJ2ZURuYXZTNFgxYnZa?=
 =?utf-8?B?VWcvSm10Um9TK2FObmYrOFJ3SURRdkNkRTI4RW5PSkRTa2pnWDRQTE9rR2xX?=
 =?utf-8?B?Nng0N1UrZ3B1K3V2TTdTOFQ3RTkwWmdWb3JjOGtIQWluY3g3bzNiRitIa282?=
 =?utf-8?B?YTQyQnNuWWVqRFZDS21PNHJLckRUYXVJM3Jnam1QSmhoS0dsbWMyeTZOR1NF?=
 =?utf-8?B?TmdlOU8zTnVvcE9mTlVCKzhTYnJ3OUYwdVZnYUUyL0FuYWdhTUZoWUVFVFYv?=
 =?utf-8?B?NE82R2liVkhQTTBVRENDV1F3QUZ0N0hISnc3VFZra1J3SDNRY2REWUJ0ZjRU?=
 =?utf-8?B?eHdrcS9MU3YzaVpKdjczR2F6bUZSWTRHT3RVdFVFbXRyaEdWaFR6NSt3ZmNj?=
 =?utf-8?B?a1FDUUhKYndmNzI2eHpLS0RIVnZNeHI2RnlERzhxcDNwMTJRdys5aENJQ05i?=
 =?utf-8?B?L1pYOWdXN0VuVDhlWHc1QWpWdFZVS0FMV3JCbmdqM3UvQmtUMGVmbTRDK0tt?=
 =?utf-8?B?amNyU1RWRm81N09qaHp5a3ZnMnZIY21lbkpaOEJuNDlHV0Y3WTlDYk9lTGhT?=
 =?utf-8?B?RTVuWnZsWjBJaHFwdlRZdjdGbHlYNWR1WG5JU1Vmbm5HTDJaQ2QvdThQTHor?=
 =?utf-8?B?WEFSSEFHRjdOWHpGQnJRZW9uREZEVllVYVBsT1p0Y2N1N2FHWlI1bzAzYW1F?=
 =?utf-8?B?SkRzaEZuOHQ2bHNBaHRuTW9YcmlwQk9MMDh0TGhKNGRyWUlNem1jTktWODFq?=
 =?utf-8?B?ZVFXZ085S0JuMndlbmw5R1Axc3E0TlhraHpjaGljL3hLK2hpRGhuUjdHSnZX?=
 =?utf-8?B?dmlIYi92cGZFTWozK1JLSHZqVXVFMWc1azJEVzFmUmw5YmQ3azZHdGtRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFl5RVgyTStIQ1dKdXV0eC96ejh1bnZWRnZZUWFwaHVFcnBrK0xQcFltdHFD?=
 =?utf-8?B?STlEeGI2dEdCMHZFTk9GUktKRmwwdk9EeUhTUGxGMWYvNWVhbjA1NVFFOWpT?=
 =?utf-8?B?STRjNWhNdFRXNktWeFRRNkl1TmdReWVGVlJCQmVERTFocmk0Slg3Q2k3WnR2?=
 =?utf-8?B?Z2xzZmxaUWw0cnlILzZZVWxQQjVyRnZmNTBLMzJadjNDZ1F5dzdxZDBzL3N6?=
 =?utf-8?B?QTIwNHFjRzBweHJmSGVDNjN2bkpHMmdDVmQvaTZXaVpvUVg2WG1XWC9QNlFY?=
 =?utf-8?B?djlKZGFha1UvSUorZEFqNm9Mb09RRCtyOVFrNC9NMWFPenZEY0t0V00wZHk2?=
 =?utf-8?B?a2VOeWM0c1lwNE0xUXF2bGw4MFpHQ2J2OUFucm5oUk5ZV1AvaGtwZjdXR0dP?=
 =?utf-8?B?VDdwSXg4MURFSmFINlZSOFdwQXVaS1BsVS9RTlFnMEVXamNxbkI0Wm9jTmZC?=
 =?utf-8?B?c3AwTkljNWdJT2pTelltY0hRQTdsOFRhZkVMeThIekJWVGM2M1pxT2VpenBm?=
 =?utf-8?B?YmkyR3RLcVBRbDl4c1ZPbmU1dFJaNDBTMTk2QlBXSVBFd01QWUFrdnVUY0s4?=
 =?utf-8?B?ODZmcEUvTk9zK1h6VkRtenIrWmk4YjY4NTdkWVRtTlBVSkNRK0w0NUFWdnZH?=
 =?utf-8?B?aFlhVWZieXRKVEpmMU9uOXJzbGliaExwenl6c0RsQTZJNXBlY090L3EvYkZx?=
 =?utf-8?B?OUJVdUQxWGVZcWEwZStaTy9vTVkrZ2syWVgxUktXeFZpZHBHNUZsblJsTlhM?=
 =?utf-8?B?UGRMUG9DWWRvVzFPKzhBSGxSRnI0U2ZMeUU0TnU4K3NWQWJHK3pUc1E2NkNz?=
 =?utf-8?B?K2IwdXd6NEJnRE5mQTkxSjJlZnBvNkpPNG1zRnJlQXVTUXZQSWJGWE82dnJv?=
 =?utf-8?B?WmxBcytSRGZuQVdxTk9ldGZhVjRHRHgrNDRoM25kZTlzRGNuUmNLblRMeWQr?=
 =?utf-8?B?eGw2MUd6UmR0dnpCOTZLVmZXZHNJRm93QzNmOFJDUmNVeVo1OWRLQTRnNmFW?=
 =?utf-8?B?NHJnTzFEaUZoYXBKMGdBK2J5dlZHM21BK05UNVcyNXkwNkI2M0xGUjZGczZL?=
 =?utf-8?B?dVpWSHpiYi9XQ3ZzK2xYcjBLRHhFRlk3STNKOHpEci9lWWc3YzEzamRwU1dt?=
 =?utf-8?B?TG81VWdmaWhQS3BucklsbXRkR1c4ejgvcGppVm5JNGRNb0k4YW5hSW5keUpk?=
 =?utf-8?B?MzdBNEZWenhOL09MOGduQ1A5dXFhcFYvYk8vK1Z5d3k1OVhoMnF1WW11UGN3?=
 =?utf-8?B?K0tua1ExMDc1SlZBR2pDaGRzQ01VRE96ZWE4anpXdEN6TlJpL1FkOUU0R2hx?=
 =?utf-8?B?dFU5eHpZWmc1VE5IdDNSeDFWM01tM3U2aXRaSlVjYmhNd1VNcUJ1Ui8wTEsy?=
 =?utf-8?B?cWpFZW9Ybm1acXRjNkdSVnd5dzlEZ0RFKy8xR1pnOXhVRVRIdHZEM1hHU2hW?=
 =?utf-8?B?REIzUWJ2d3hyNjkwbGlGcXpjay9SWnN5dmljM3VqMUdjcjdoUE1CUVlSS2o4?=
 =?utf-8?B?VjZFV0prMGZobFJpU1dhYU1Cc2ZacldjUndtMWFtUm1PVjU3QXRsTWV1OG54?=
 =?utf-8?B?SHRadHdwRGY0UWJ4QTdlUGh2N3AzeEVmdGxiSlFKaWNSZG91MnZqZ1FEMDBI?=
 =?utf-8?B?NjU3OXU0SW0weFZXUzVTalZsWVJVU09qcW9zM2ZkekwwdWZrcnZDMCt4R0lr?=
 =?utf-8?B?K0lscnBCdXRpKzVuY3NGSnZpWEUxQm5pS24yVDNLclZ6azVJdjkwTzBFb2hL?=
 =?utf-8?B?ZjVKSGhuMWlhNXg3Y2ZKWkU0Y0lHWEtTWGRBT2xINlYxWkZraXJ1UmgrOGdD?=
 =?utf-8?B?WmU3SUtRd1IyaG5WbWVlbjF6M3A1a1c5SUVpU2RGR2JGS01oMGFMZVJscjMv?=
 =?utf-8?B?TUd4U01rTnZFbktJNGtUYk5KeXVIRzlFcjBXcWZuQkVBNjlKUFlvaGlkKzZ6?=
 =?utf-8?B?R09CcjJiNlFQNUhuazUvYlB4TU5JL2ZsbmRqa2pLQTVJT09mbWRqSmUvbSs4?=
 =?utf-8?B?TWw3VmcxWHRwSzVBZERST3Zja3Z2ZDR1U3BlTGR1M3RNVjlpTmtXQ1J4elpo?=
 =?utf-8?B?dTNETXIvUk5kKzNpVlRTSTBzMmkrU3hjM3pHRURPWGdkd0JUbjJia0dWOEJF?=
 =?utf-8?Q?GOIXH7Pk+uouksGZgynKUySzE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 295b84fc-41ad-4fcf-bcd0-08dc6b6bd632
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 12:23:28.2042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QaOnoSTxEBPSmoKX8qcC16LNaupFBRG0N+n/FA3qXbW372cxdJ62dfdaAcOZvV4dwvFIl8Q3LHBV410M0+NvKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730

Hi Alexandre,

Thanks for your promptly response, I try to remove all HTML links and
resend the email again to avoid the security scanner to disrupt the 
external link. Hope you can see this email without problems.


On 2024/5/3 8:20 PM, Joseph Jang wrote:
> 
> On 02/05/2024 18:41:02-0700, Joseph Jang wrote:
>   > Some platforms do not support WAKEUP service by default, we use a shell
>   > script to check the absence of alarm content in /proc/driver/rtc.
> 
> procfs for the RTC has been deprecated for a while, don't use it.
> 
> Instead, you can use the RTC_PARAM_GET ioctl to get RTC_PARAM_FEATURES
> and then look at RTC_FEATURE_ALARM.
> 
I found old version kernel doesn't support RTC_PARAM_GET ioctl. In order
support old version kernel testing, is it possible to use rtc procfs to
validate wakealarm function for old version kernel ?

Can I move this rtc alarm validation to
<linux_root>/tools/testing/selftests/rtc/rtctest.c ? So, we could try to
use RTC_PARAM_GET ioctl first and then roll back to use rtc procfs if
new RTC_PARAM_GET ioctl was not supported.


Thank you,
Joseph

>   >
>   > The script will validate /proc/driver/rtc when it is not empty and then
>   > check if could find alarm content in it according to the rtc wakealarm
>   > is supported or not.
>   >
>   > Requires commit 101ca8d05913b ("rtc: efi: Enable SET/GET WAKEUP services
>   > as optional")
>   >
>   > Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
>   > Signed-off-by: Joseph Jang <jjang@nvidia.com>
>   > ---
>   >  tools/testing/selftests/Makefile              |  1 +
>   >  tools/testing/selftests/rtc/property/Makefile |  5 ++++
>   >  .../selftests/rtc/property/rtc-alarm-test.sh  | 27 +++++++++++++++++++
>   >  3 files changed, 33 insertions(+)
>   >  create mode 100644 tools/testing/selftests/rtc/property/Makefile
>   >  create mode 100755 tools/testing/selftests/rtc/property/rtc-alarm-test.sh
>   >
>   > diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
>   > index e1504833654d..f5d43e2132e8 100644
>   > --- a/tools/testing/selftests/Makefile
>   > +++ b/tools/testing/selftests/Makefile
>   > @@ -80,6 +80,7 @@ TARGETS += riscv
>   >  TARGETS += rlimits
>   >  TARGETS += rseq
>   >  TARGETS += rtc
>   > +TARGETS += rtc/property
>   >  TARGETS += rust
>   >  TARGETS += seccomp
>   >  TARGETS += sgx
>   > diff --git a/tools/testing/selftests/rtc/property/Makefile
> b/tools/testing/selftests/rtc/property/Makefile
>   > new file mode 100644
>   > index 000000000000..c6f7aa4f0e29
>   > --- /dev/null
>   > +++ b/tools/testing/selftests/rtc/property/Makefile
>   > @@ -0,0 +1,5 @@
>   > +# SPDX-License-Identifier: GPL-2.0
>   > +TEST_PROGS := rtc-alarm-test.sh
>   > +
>   > +include ../../lib.mk
>   > +
>   > diff --git a/tools/testing/selftests/rtc/property/rtc-alarm-test.sh
> b/tools/testing/selftests/rtc/property/rtc-alarm-test.sh
>   > new file mode 100755
>   > index 000000000000..3bee1dd5fbd0
>   > --- /dev/null
>   > +++ b/tools/testing/selftests/rtc/property/rtc-alarm-test.sh
>   > @@ -0,0 +1,27 @@
>   > +#!/bin/bash
>   > +# SPDX-License-Identifier: GPL-2.0
>   > +
>   > +if [ ! -f /proc/driver/rtc ]; then
>   > +     echo "SKIP: the /proc/driver/rtc is empty."
>   > +     exit 4
>   > +fi
>   > +
>   > +# Check if could find alarm content in /proc/driver/rtc according to
>   > +# the rtc wakealarm is supported or not.
>   > +if [ -n "$(ls /sys/class/rtc/rtc* | grep -i wakealarm)" ]; then
>   > +     if [ -n "$(grep -i alarm /proc/driver/rtc)" ]; then
>   > +             exit 0
>   > +     else
>   > +             echo "ERROR: The alarm content is not found."
>   > +             cat /proc/driver/rtc
>   > +             exit 1
>   > +     fi
>   > +else
>   > +     if [ -n "$(grep -i alarm /proc/driver/rtc)" ]; then
>   > +             echo "ERROR: The alarm content is found."
>   > +             cat /proc/driver/rtc
>   > +             exit 1
>   > +     else
>   > +             exit 0
>   > +     fi
>   > +fi
>   > --
>   > 2.34.1
>   >
> 
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> 

