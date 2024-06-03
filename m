Return-Path: <linux-kselftest+bounces-11118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481C38D87AD
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 19:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0D51C211BA
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 17:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A87136E0F;
	Mon,  3 Jun 2024 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q3hmbpqS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99CE12EBCA;
	Mon,  3 Jun 2024 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434624; cv=fail; b=eGjTqw2yeAn3RdwHBKi/5XKaW4oDUHew8FE2ObwtsKi+FluPqGKoWf14gORADknBGK7pE8mrsowtkSCGIiyozXdp2iKacirp9lhCXfCRRAVwg8vjQc3jk6rSeqcZrVB03IR+bG0OLJYxEt8yzOsYYPTARWsdYwKt7eeKFfrsZUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434624; c=relaxed/simple;
	bh=Qfyf50kaFqpGWzlv3/36NLMNJDCpUjaZLau9DTHA1hs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G7V7R4/pXmJOaopSO++sfslyVBzxCxgIKR48qbQkdDcoAg7Z6H/N0FL1VydOS4qc0Uz2x1zBTF7Itc8789LGJiEKwyLLJ76jmHdG3NowC+iMTCfyzIxYf0OhvK18nAx4/o42D/qBZb+Jo+iN/ZnbIc70ZHTKsX41/R7jy+qyFGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q3hmbpqS; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMiHKWG+EOYGcEUGPOyIcWEu0mxxN+M3XePLW+5yKpjxttY4oDjfqC133HdWfsWSiZ03QGml1/oOOOU68jT/Qypu/39z9Yjs7+0G7zkqTeKbBzvhNKsNMKkuCp2eT/KrskdcGs5WIXIrzvFj4KZI8PxJEXyYyzgtogaGEwBMdkwRgiPshweL5F099zGutVNXcQElRoZNlEuMH8ReGa+7SoG1ESI10G0wmhTI+l11I1pm6zJBMJuXUXNF6JZqZex0bJnhFFT0/lGsi8oAt6ZHCVTELsG2Zju5SZ+/Vb7Sksulm7kkyeGh7lJrK7QUgG+bN8hysd0vVUjGUxnGeosTGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CqI6UyR9j6HbcdfQYOfyJq4yAVO7lUltEAWoX1WC7E=;
 b=FUacpkNJNsb28yiA+Mbp3GU9r3U6tJoeeVPlgu+rw91yzoCxYILhrDmDf7dBfYploFkwIQ5LMXnxnnvrM19Y4Gin0tHgJ5ggdVKrpg18VhiOgp0oj5gy6cAFeGf3j7ApLtAG77EhtH29AJD7LgrNN1JakWxsVPMnPCEK/gSV8rjkvB1FmpmSQlI0eVwlhQRrRMFw7+vWBWeo2crK6bToslDIxOGCBa3ZqRSAhcr+uzNtsO2sg6Cdzl7wqFw4zwvVjZBrQAWa6B/2s0Ye+RvvvpIaCRUfKS3EPMdZyspaBjIme2pMvzyf4nVv9BhdqAsWcetYeFAqbBOKspdDlVhzug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CqI6UyR9j6HbcdfQYOfyJq4yAVO7lUltEAWoX1WC7E=;
 b=q3hmbpqSJ1gTiU0FUvdjKqWolbGlwW65YpbS9RbSBkJx6Rb4fe1d5mrQ3hHQFDC0/YV5Cen8Mg+PKCr4KELUHGDDMn/zB4EKLPfN1TfKKC7dQbTGFcKHMQVcvHauhQJLtOzQHpOl257KwlzKCfC4ta4KmkBdqAse1aVtttEWs6dwgMLGkq7D8rKlwZ3ZxSU4RBY/mN5hdgrTrFggyNCqXT4xrUZQ7XSDVMye3LT7AMUFBS+Gdl90CK8clLdV8Nx7avk59F9XW8hCtmDS685hTAeDx7/ecpf49GrV1SpWRuuBimy4UgDPsmRig77f5wK0NSOFXtSIKdo6tMI+GxaCUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV8PR12MB9155.namprd12.prod.outlook.com (2603:10b6:408:183::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Mon, 3 Jun
 2024 17:10:19 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 17:10:19 +0000
Message-ID: <96216e54-ba8f-4fd7-b95a-13477c143575@nvidia.com>
Date: Mon, 3 Jun 2024 10:09:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] selftests/lib.mk: handle both LLVM=1 and CC=clang
 builds
To: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Justin Stitt <justinstitt@google.com>, Bill Wendling <morbo@google.com>,
 sunliming <sunliming@kylinos.cn>, Masami Hiramatsu <mhiramat@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>
References: <20240531183751.100541-1-jhubbard@nvidia.com>
 <20240531183751.100541-2-jhubbard@nvidia.com>
 <306eebf8-bb5d-4e1a-9fa3-ad3f4ea11b9c@sirena.org.uk>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <306eebf8-bb5d-4e1a-9fa3-ad3f4ea11b9c@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0123.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::8) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|LV8PR12MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eb2b8b8-d1a4-41f9-27db-08dc83f00b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkFiQkVvMUlIUDkydjQwNUlYamw3TnNrMXpVaDRmMVJOTnQ4VW4zNHFxck5j?=
 =?utf-8?B?WHlGeXh4WkdlbmtTaDl2V3UybUNIOWpLb3NqNkFmRmpuOUpYVXQyMnpzb3R4?=
 =?utf-8?B?OG94MW5PaXdsQW5adkVRVjIvQ0swT2xlMlBTQUFRbjFybThxM2loK2xlc3hX?=
 =?utf-8?B?ZVhLSEpRSFFBcHA0YmdmbklCVU5iNCsyMU5nYUY4ZkhnUGo4NktnM3lUWU9k?=
 =?utf-8?B?U0psYkhhc1FuM1E5M3lTVkRHM1BLbHhoaHV5OEM3V2RsR09EMGZscEVKcVcx?=
 =?utf-8?B?Sm9ZNWZtTkJvaWxVQzhETUhCM2tXbmxacVZrOG1HSmUvV0x3eXNiMmFCd3ZL?=
 =?utf-8?B?c1dMa3BpLy9pWG5haXZ3T0VSdjROTG56OUd2SEdwYURRaTU5Y3B5bW9YOXYy?=
 =?utf-8?B?WUxCZWRKTWNHbXJwYk45Uk5LTGhmRmpSSWpCR0JabE1obUE1dmhTeFBJcDVy?=
 =?utf-8?B?enlkRlVJSkNBU1ZPWWhOVVVUUGQyV2dDZERLWGhFNWVRVDZDQnlHa0cvazhl?=
 =?utf-8?B?d3BCKzZ1NlZLanV6WXpldlVPeGdQN2lpTEJSZkRVK2YrUytjOVI3cWZORm9X?=
 =?utf-8?B?VFhqdm9xRTlVSThWMWRwUi9URzFRYUd0ZlVFVTBBcFVQa1FwUkExdms5WFpl?=
 =?utf-8?B?SzJUbk10YWwrc1NTZFFCbm8ycWJkODJJN2JwQWJLSmlIcmdJemcrekF6bEFL?=
 =?utf-8?B?MHJYNG9IZjJhN0lJQkE0T3ZOeTBRWUFwU01IQVdoZk1yL1A2SXZYWXZtY3VI?=
 =?utf-8?B?WkdZU1JMS29IdFJLcFR5ZEd2TTVpWlF1RzdWNWRwSXV1aTUrOEpEay9MSlIr?=
 =?utf-8?B?Vms0bUlZL2lsdGlheG5ab2Rmd2N6NHdRdjFaODlzc1VKQlFyck5ZMGdIdGNt?=
 =?utf-8?B?QnMwa3Z1NVRReXd5dkQvTytaQ3pKUk1KQ2toWkp5VitYTGxFM2s2YTMzUE9X?=
 =?utf-8?B?MkZKTzUwOW9OWU9CbHJDTSs1aENXNDMveTFtSUo1cDFlQUEzcEhjRzlodDNS?=
 =?utf-8?B?b3BoNUJkcGloSjB1Umg4SVRDVzVHOXFmMkhzL2FBQ3NFdjdaQXFPQzdzSysv?=
 =?utf-8?B?S1VubFVDckJGT0x6M0tMVGtBdlJhTXB3aWlHaldSSlBSNVJ3dzJVeEMzazBW?=
 =?utf-8?B?TE9UbXAwSkp0STdMVjJTT2s3dTdTUkpweE43NnJJdlRyTU1VbEJHVWtFVkxv?=
 =?utf-8?B?UHgvS0Y3bWpib0VwSHpoS1lWRG9YRjltZGJ2LzY5eU5qVE9UL0ZYN0M3WVEw?=
 =?utf-8?B?bW1MdW43MGp6a2oxVElsUkUwanVrVzljeE0yZWE5Skh4cE01b1pRaUFkYjMw?=
 =?utf-8?B?c2hvSjJRcUpGQzNYSHNrYXNEWWFJNXVzSEF0RGhORG44QVR2UDhYWGhKRnFB?=
 =?utf-8?B?ZFI0OXdXQ1E0Mm1Jek1pOGhDVmlyd01VSVZiOCs3UkRzUkQrTXpodzZHekVD?=
 =?utf-8?B?cDlVRXdXdThRenFMRzh2bkNSR0hvRDJ4aEJuVGFNTUYrdkpML1prYVdwOVBK?=
 =?utf-8?B?RjRYbUM4Rk1tSThXblpQU0w5ajBTTDJGVkN2S2Z4T2UwenNnNFpQSXh6a3M0?=
 =?utf-8?B?VHVKUEtTKzU3Y1NWb0ZUbUpSNUx6Zml5MWwrNEFhdTlZWHN1RmF1T3Q4bzdu?=
 =?utf-8?B?SU9ZbENvZFY1WHJ6RkZkMlpySisyTUtNaDRWSWNVRDFmYlpsenpJeTVQQTVB?=
 =?utf-8?B?OENic0dJUVFVWjVwSDVpbklDUld5RDNVV3l5akthdE92eHAzcWprTlZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFgxK1NLMXhiTHhrRjBhakgwVEpRODdzeUhIRjZCOXpmU1JTSHNJdDg5K24v?=
 =?utf-8?B?NWdOM1pNN0RmRW9TMlBKd1RoMnBQNzNrL3JFM0lWM3pvMUVZclYwMnVyYlpz?=
 =?utf-8?B?aFlxUHlxbFZzK2ZSL0FQMXl1Uk56NmpNUUg0aFNQSnhkMHRoTmk4UmhHOWRq?=
 =?utf-8?B?NUxiWXpvbytjQk8xWVh4R0I5OERpNjFRZzBqWDhnb1ZwSUdDaUxRSVhNNXJt?=
 =?utf-8?B?RWN5NnFIS1FBNXpjcDhwU1lDUEt3QllKV2JZajFLMWJ2K0ZvdTljUTRONlBE?=
 =?utf-8?B?OFplUzJESEh1bnRVeE5JWlhSQXVwUXRjVE9XZERBMlhSQzFFSEtVYmxBaXYx?=
 =?utf-8?B?eWEyUFQvODEwOXdiZVdKZ25LZUtxN3VJNU9VYXVmZ0xpUi9KVVpGUWlwZmFL?=
 =?utf-8?B?NlJwS0hua0pPdkgxYlE1d0RkUWs0OTREWUpqY1ozbWw2dlRmM051ckd6ZmRv?=
 =?utf-8?B?MzZKR1dHekVYYXNqN2lzQ1JmeFBDS3VxNFNnNUFxTU5UcUhLS2NoL1lKeHBN?=
 =?utf-8?B?cUU3U0cwYlBxaFk4cXFLckJ1ZU5scDBWcnBmNEFqTmxvQURua1pRNkhZRFVv?=
 =?utf-8?B?bGg2MDQwalpML2NSQW1scnc4UENtczN1aFNRZ1hVd0hyamxzVGFMYU1PN3k3?=
 =?utf-8?B?dFRNcWRvbytjNjZ3SElpQ2FOSnVCSEc0YXJBaUFocGJTRzJnVjg4NVQwdTdw?=
 =?utf-8?B?OUhCQ2YvYVJhQTRYK1QvNHNlaHRMUElzS2xkaGZwV0MraVUrVkpvYzg3OXJC?=
 =?utf-8?B?TEY1ci9yQm9rbXMrUlZjd0gwNUF0RHVuTnRyWGtZZ0s0QU5LdEx0V2dGdXNx?=
 =?utf-8?B?SUZKMS9uMDFhWDFhVEhZVkpGeFRaVklJanBZUlNiOVJsRGxrSEpxQUt1dS9o?=
 =?utf-8?B?VWtSTS9nTExEMThidng0eDZ5WGxYU2RNbjdlTVJZWkFueURBN3d4dWdEZHRC?=
 =?utf-8?B?Ymc1bUdHUFhEOWN5bzl6eHFoekdFRGN3ZmRjMTZKY0FFMGRmZTZDT0hJczRs?=
 =?utf-8?B?RjdQdUpZcnZFTzgxbEUrMkthN21EYmJ3UUVJcnpDWGI0S1ZyVlNLd3VTQUhz?=
 =?utf-8?B?OFJ6dGkxby9DT3ExV2pkYm9YOXZEd1lNeUJRSjZoWUR1TG9IZWFTRHpaSmNO?=
 =?utf-8?B?cTdwSFlKUjNZSlhGaDQ2YjBPUmdaTXB4VEpsZ0RvNHV1aWoxOEdrdmliOW1y?=
 =?utf-8?B?UlpSdFdwdEVTS2lwS3pCRG0zUFRMVkRrKzZJaFFLTXdTY1llY1huck1TYytl?=
 =?utf-8?B?MVRwQWhiWTdUVi9sdnlxMVA0K2pzTTZpRkRHdmlnaGw3VkFWSzNzMjNGNmYz?=
 =?utf-8?B?UE56dnNOMFphaGxZVDVTczRoTFZVdldSU3BEREduMFVmc05yVkY0R0I3QWti?=
 =?utf-8?B?Wmw2OUlPaXY1SThKYjJURWdvL2RQNHhMN1RCdGtyTzc3LzFJWU5maUdOZlpo?=
 =?utf-8?B?Nk5rdFp4Q3Q1Tk43TTdnMG1tUTFMSVN4Wm93VTdFandFcFNOdytQWGhSckxy?=
 =?utf-8?B?T1FRT0FtbDVjcGc5YkFRS1AzM1JuWjlPQzkxMGN4SUxnMjM5UkJ4Wml6RWsz?=
 =?utf-8?B?YVpPeUF2eUxZMmF4a2Fjb0hWRFI0QUdKM2lBaHdyQWtWU0JackNTek1jZ3Er?=
 =?utf-8?B?aG1rWTVkeE9LM1cwR3NNMGk4MFI3VVRrQ1R1aDZwS2s0VlFPcUkrT0Mzb25l?=
 =?utf-8?B?TjdsS0dSVTMvOFBPSGNnU251MS9jWjBWYXpiS3dlNjVidlhmUVRVWUVDQ294?=
 =?utf-8?B?SnZURk5FTWk5Vm8xVnNhZFVTaytYdm9SQ084N2RHQTBaNE9LY2hnUnltRzZZ?=
 =?utf-8?B?Nis2QVFOR0daZUFlR05wZ0d2RmdFbGFPaDRIQ3FPaU5WY251V3dobE9pUVMw?=
 =?utf-8?B?NkNhRUFJRzlvSGlGTEQrdHZ2VjY0YTNqU0FwSjdCOEJXa2gvc2toUk5sRTdW?=
 =?utf-8?B?VTJBSm1uYWVZeXBaVHdRK1M5UU0weTB2Qy9uWGVWbFRRTmRiWXJySDFweEVS?=
 =?utf-8?B?bE1xNUdBcDhHYlFPanhwdzZnVG5FRU5KNlNUSHRwbFNZeU1qUzBYNnRaUlJF?=
 =?utf-8?B?blV0dm9oYngvSnRVTmpNWWEzUDd0eHViSmY2S3RGalpkbFFueUFTZjBGWno1?=
 =?utf-8?B?RkorRlFEOVFHdmZ2QXI1cmI5VUo3WUc0VlJzMkh6MjhiN2V5SUc4YWNoMkI0?=
 =?utf-8?B?V1E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb2b8b8-d1a4-41f9-27db-08dc83f00b9e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 17:10:19.0872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3Ty5mAqK4jnd10k9dUgsPBGCOQioFfEtwPBjxN45eu956tKWy8l130ZbWKF9zx1Rq2/nuAfiPsAiABJAmu1Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155

On 6/3/24 8:32 AM, Mark Brown wrote:
> On Fri, May 31, 2024 at 11:37:50AM -0700, John Hubbard wrote:
>> The kselftests may be built in a couple different ways:
>>      make LLVM=1
>>      make CC=clang
>>
>> In order to handle both cases, set LLVM=1 if CC=clang. That way,the rest
>> of lib.mk, and any Makefiles that include lib.mk, can base decisions
>> solely on whether or not LLVM is set.
> 
> ICBW but I believe there are still some architectures with clang but not
> lld support where there's a use case for using CC=clang.

I'm inclined to wait for those to make themselves known... :)

thanks,
-- 
John Hubbard
NVIDIA


