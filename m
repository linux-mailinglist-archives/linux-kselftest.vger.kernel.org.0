Return-Path: <linux-kselftest+bounces-36446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C021EAF77D1
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219C81C8203A
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5E82ED848;
	Thu,  3 Jul 2025 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c3Y+dCrF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E697E2E62CD;
	Thu,  3 Jul 2025 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553706; cv=fail; b=j/TkIgHUFEIXv8ibOSh7jhMwYMDr8+msWS+D7M0jxgsuoPb2oV/yVG2ekW9x6FiD9FYFZEjqvzqlKI2loXyQqXiJqDs/HABUGHI8kkUS3NRU7YLpBCbgK1qVi4a2/ccumPbhFuIz0Uc/HfYI/+LIDOUXWAy6AET0Lj0kq55UmiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553706; c=relaxed/simple;
	bh=xBNCwLc+9CE1SBfDSR4Zzv2GBSCjY56hwrxgJ/enYQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sb4XBL+TptPfgsg9CebEyEnZaGgT0DpxVol1k939olgXzQqVU9nIOBK8gPq9Edk1tVllna6m3Dkx7HuI7wuorYQSOxHzfkINZr660+Z8GsiD8+QhMgOE/jz0ORqC11iPniy6a9yDExVgTqbNZbZxxn5jvX+OHWlbkUqUvxP2U/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c3Y+dCrF; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVa0ahmiMYdnNE+LyBchxTdM4LtvyMDYOhKeG74rE30EljfTswQ03fMSphGRWTuUDmjFeF7+zkiA4/gyBFPMX6eioMRZAsy1JNlPdf0Q0sSc6wEdlNnsNwGp9kqYRtOEH+QKde4YgV5ctIdl/SEBJBvWINol+1rgMw9ZwHL/IYpwo9STT6Ln5hotAyFVHXUyNP3Lzxg/iDtJgQYzSStCnNbZQ84ePzK+mbL6b6xQnJIa8rsI7BWdWhtidG5lkXjzUXn3ERgJuuhq0hK4nBKctj1M2x1hjpiORB8eRVZ5Bg2EhDvRQP7soQ3AbgedZpPBHBGqcEzQet3vpM+L5/xYjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPsFMVE53UlmVYVMFjt0QO7FUz7D9bqmGM9ACjIQe68=;
 b=Wf9uBlfmDD3QSNZ5BjQJkL4HsiroFOXTPwUoiqKGYZUXyWNgCPltZAXwFtqwXwnmOiyWABZKwqTvq11lXCelipXAciLLYKJmGmtf+hbBh7bjSBkR9bHJgotOVlNI1rxF+8UssS/SibqM5rR8MZESKYXmJn241GNR3z0HXCBZZtqaOZmmu3cxzUbHvu8cPzlKpUnFMcEy89sg+JPnkF9gUoDYHk+2mcOgBVLq5j2I2Opbn7JJzh8HjHzXTJ5HG2Y+nsNt+uQ5X0HmQob1mIEWZ6leGmYcA5w393n0QrtSdUUlWkmvXuysiXjsuQedySax7jCmH68bsXhsGD3pUQ5V4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPsFMVE53UlmVYVMFjt0QO7FUz7D9bqmGM9ACjIQe68=;
 b=c3Y+dCrFEJ/zwBm5W3/Ja0mPHA12/+EUm6HUS2VP8lu624PC/99a6RK0Y/Rrb8/mxbw2GKTEBqlCmwjDnPPUK5riqJ49K5cS/pZDktVatJFhWr56+GgjZfWsZ3CrMmsA3RblVUha7xeT8joz9cB0xNbjGtAnu8uRrgaOAX26TXJUlTmQS+mNWCkcaPPgvyMOUCPxVOwD/LV8uR6brbMEuLvMKhPtk0fTXDUJjUgbFcGG1WyPXxQOXxfEEkV3agirmB7zzX7ZQROwPpn27l9W3WudANqL/shS3xR+Q7Yds03MfayIfMWXG5TcLFU1DBW0F5u1X+wVkk1jBwv6YNgNPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 14:41:42 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%4]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 14:41:42 +0000
From: Zi Yan <ziy@nvidia.com>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
 david@redhat.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, donettom@linux.ibm.com, ritesh.list@gmail.com
Subject: Re: [PATCH v2 2/7] selftests/mm: Add support to test 4PB VA on PPC64
Date: Thu, 03 Jul 2025 10:41:39 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <5FA05361-1FA8-4CAA-AF23-7BB0974DA78B@nvidia.com>
In-Reply-To: <20250703060656.54345-3-aboorvad@linux.ibm.com>
References: <20250703060656.54345-1-aboorvad@linux.ibm.com>
 <20250703060656.54345-3-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR19CA0035.namprd19.prod.outlook.com
 (2603:10b6:208:178::48) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 3caeceb3-4a4f-405c-374f-08ddba3fb9c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3IzbGIwV0VTUjkvMmlFdDNYTVA4Y2lNczZUQ0hJb1huNEw5N2xKTURsUFFp?=
 =?utf-8?B?VE5aM1BadURUdUFGK2JBU3Fwb2d5T29vRGkzRTRpdnBDZ3ZWRldibmlYZmQ4?=
 =?utf-8?B?eUdPblFyQTlTdVBDTkNkR01jUjE5OElIb29NUWtvcFBSWUM5V0FCbXIyUW52?=
 =?utf-8?B?eDhXOHRUUllrZFdvOEZoUnQ4b1dnVHg4S0hxTGhjMnJYejJSQjV3ck9CUjVW?=
 =?utf-8?B?TUlWd1BPbjliZ3N3K2ExZ3BuTnc4cGdINWg1eXVTelQ4VmpheXJkQVp2R3pD?=
 =?utf-8?B?RWxwR1RSY0JLaWM3dDFpOExQand5L0h2cFJNMTdkT0ZTd2NyN2tTSEJPdS9L?=
 =?utf-8?B?TTIyMFZqRlJteHpxd2xieHlKRkRDSmtzK3R4eTJuTDlkRUo4Y3VNTDNpU3Rh?=
 =?utf-8?B?VEQ3Vmpsd1lkSG9PSXJpNXhXUktnYjR3a1pkNFJBOUUrQzdoMFRnQVhGRU9V?=
 =?utf-8?B?QTJidmZLSDNNMzNOVE02Sm5CM1VoZkoxVkw5NHREMG1jNDRBZkR6QVFOcVU1?=
 =?utf-8?B?T2RFUE9jdVZUZVJsR2Y5MGQ4YVNQOWhFTE9BZ3NIcDVway95MVhXd0RzZDhq?=
 =?utf-8?B?cVpnRUp1Y1VBR2J3c3VvWDNEdVFxSUMyUWFFbUI0dno2Zk16NDAzMFR4ZXFH?=
 =?utf-8?B?Y3AxZ1F0bnhKZ1VpOTFaQTFLSEYyWFhtWGtZOUNuZmpadDdJMkZVWXlySnF5?=
 =?utf-8?B?d3JmV2ZJMlUzZ3ExenNPSS8wQ2NsZ0xNc2lIblpTRWZqS3NiS2tjOTFTQ1Fh?=
 =?utf-8?B?TlpidnJDbCtZb3BuVStRaUVNdjUrbVpHZTBwMERyT1pRMjlWR2d4Rk5JNGQx?=
 =?utf-8?B?Zi9Qd2VDUW1Iekt5TUxQcndFZU9Hc2JScG9NUDV2cnNzSk94aGxoUWVISm8x?=
 =?utf-8?B?MTF5a0tTS3Juck9pNGNtZExSOEQ2NWtMeS8wNktFZnBHTWNzSnlPd0tMbXpa?=
 =?utf-8?B?UjZxU3RlSmttLysxM1c5V3VKeXBSTzlFc3RCaXJqZjVRVmR0OE83cXhMQW9E?=
 =?utf-8?B?ZHBIMS9ySVY2aTBsQ00zQ2pIK0t5dGZiYnVaTGhrRTlPb0NoZjhHSjhPcFJM?=
 =?utf-8?B?amJwOWFIQnRCemJNMG1LSXV4SmQxTUxvYmUzMThJdEM1TnVJMzY4MVBKSFNL?=
 =?utf-8?B?a2UvVTNqR2M5Y0F1R1BHMSt2anRhT2dFdWt0ZmJUVkxCUVlGckdqVWc5N0Qw?=
 =?utf-8?B?dVlmcW5hT0tpZ1I0cGtWNEJPWUV1WFRjNDgyQ2l6QTBGUmJOZ1JuYm1JU1Jk?=
 =?utf-8?B?eVNEZ21IV0tsU0E3VjY1ZDF2eXBjUGFCU2J1dlplSVBjMEg1VE5RdmZFRWlJ?=
 =?utf-8?B?eXIvMmtQaW5CWi9naVprMHhpb0JUSFpMOWp3aFlvV3Q0RWdZck5uajlMNXQ2?=
 =?utf-8?B?TEh5K1JBT0hXRUFSbi9hQzdMYkRXNm9NZkdxUFMwZkw1bVlIVXJrRkpKejgy?=
 =?utf-8?B?bmhwWTRNQTgzeldjbUxodldWSitrd1dXNGxIV0R0cWFhejFXRjdkSERJeDZB?=
 =?utf-8?B?S01WcHhLeFdhQkpEK1NGN1JkT3FYeGpJdDJWWFdjK04yUkJGZ29MQWFxVUhU?=
 =?utf-8?B?WWdHQnl6K3ZDZE1hWk5PR25XS0dhbzdMbHpvU3V3ellrRGhVemF3OHAwemkv?=
 =?utf-8?B?UFlZcFRUdjRjV0J6VHdKeWxYNDkyaGk3VzFSZkF0QlJjVndxWk1JbUxZVktx?=
 =?utf-8?B?MjEzYU5UK3ZranVUYzQ3Q0VSakhlaDNKWVJRL2FkNnNRZWxka1pwMXk1ZlR4?=
 =?utf-8?B?eXBJbm94VURrS040ZDFQVmMrUlRNdzg2TzFpSmowU25vUkxWMVBidEk2REhp?=
 =?utf-8?B?WVBEUVBnZHg2M253WjdraHN5RXZDM3ZsL3FZcWxwT1lzeldFOWc4d2RuU2VT?=
 =?utf-8?B?ckJEMlRkcXFkL2JmRkRSSzV3eDYrU2w3cTdrZDNDRmNOU1B2eWdsUFVIOS9o?=
 =?utf-8?Q?xSK+BYpbKOI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEEwSlJPNE5EVWdDZFRJWWFqeldsL2c0KytpVFpQM3d0S3RhVXlLQVU3cVky?=
 =?utf-8?B?U0JsOTRSUFFWYlY4RHlDSUdzeS9GZ0Z0U2d4bEVwSmtxWWFmSUJpUEpRRG41?=
 =?utf-8?B?WGJJclNXREt6Skd5c29Jb1NUeVBza3V6OGE3MS94SDJHOTdtOXdyYWMzRXZE?=
 =?utf-8?B?VmFTTURtRXlCZDNqTEhrQmQ2NHZLWXV4SWFpd1lFdktLM0k3UVRPeE55eFBS?=
 =?utf-8?B?aVd4Sk1oV25PaWdnc05RV1dZK1ZKRFIwS0dLeVAxMktCZDF5VTArdEI4Zjlp?=
 =?utf-8?B?UGFEUHgzYklYZDF2OE5ERkMwTi9uYkl1cW9naTB3UE9EaFRXR2pmREJ2OFYv?=
 =?utf-8?B?Q2ZYTWl4c0pRWEtEZXVyZ3NjYm43OStGc2dJSDFTVVVocGZGdGdSSmR0Uyty?=
 =?utf-8?B?NW1kclI3eElGaHpadzVvcFIzeHR4djVuMHh3Y3JRV1pzMEhoMUZQTU04OGFw?=
 =?utf-8?B?NjNXVXcySW9tYVgzRVBEL2k0WHlVNEZjWjhrRW1SYWdMNFNDNjNITUc5ZEJy?=
 =?utf-8?B?WVJsbFdGU0NPWTNTUGp0S3o4S0R6Wm1KRHRiVFBUc1dIWjBiTzhZcXpGYTgw?=
 =?utf-8?B?UlpQOUJRRVlNcGYvVzgwRFBBQTNzVnlrcVRGUUVTQXY2Q3BtK1ZWMnV2TVhX?=
 =?utf-8?B?Q0J1VTMxMnpsZ2g4L1JiVlhxRml2TnluVkFadFYyZWpIUCtQdU56WGZxdllI?=
 =?utf-8?B?MDRCa3hNRmN6ckx5aWNEMWNmbnhjM3MwdFo0cEFSYnRTL2dPN2R5MStCdWVn?=
 =?utf-8?B?RlVuUG1laXl1OTViQlVUQWdxMklEUkhBbFJSazg0cnJRVWJzL05XL3VsVTBC?=
 =?utf-8?B?TDA3dGlDNHYyMisrSkR6QVNPbDhES2tubWpmN3doTERGY3k3Szg4STRqQlR1?=
 =?utf-8?B?NDlOQUZSdmNqQm1Ub1l6WnpPZnFia08zY1RRdmM1cWpBV0VhcVVNdVdTMXov?=
 =?utf-8?B?U2lnbGpUMEpXZ3p4M0tuRGYvaW9pVmVRWVZsOWVkYnE1M0U2cGpudExmL0xp?=
 =?utf-8?B?cGYyZUpuM0pYSFdHeTY3S0RCYUJqaDNmc05LSzBpZWt0VmpFRXEzcXZVOHFx?=
 =?utf-8?B?UjlVdUlVYXB6V3lXR0laMUN5MXlLNmNCY2V0NlhZKzZkZGh2WWdiazk1V2dB?=
 =?utf-8?B?aHM1dHRUeEtZdEdzWUhsdlpIZnRQa0txMFZyNXJRakpQN01zc1h1VjZCU3ZE?=
 =?utf-8?B?V3lmY3F5QTYyeVhwNDhIU1VPZEMvVzZtSm50MGhVcGpnREgzRkNLZEFGdVZp?=
 =?utf-8?B?NE1sSklKaGM3YkpJOUd6YVdaUTNPNUJmaFJjbnYwSE1wU3N2cnp5SWxyaWN5?=
 =?utf-8?B?Y2cwR3l0Y0FQaTFTQk5TMWFXbHo0SWREQW15eVhiZ2JpQlN4YzI5S3FtK0Zu?=
 =?utf-8?B?eXFiZkFzRW5rY1dtaU5FS1JsUldaOURlTEwxejlYbFhWdXVVVkovYzRLSGhp?=
 =?utf-8?B?d254MzFtYXdyYXNPUk1YZEFzNlNLNzB1VldhV3VhYmNpQXBadC8rQWZUUWFy?=
 =?utf-8?B?Tk1GRFE4VWFzRWFGZmRWcDdIckxVYjN5d29aVWVYVmdJR1lxT3ZPdHV1MlAr?=
 =?utf-8?B?b3p1VzgyVURFWXZEUXFxcDZmaGgzRmRXdkJEdTZWK3FtR3loMk8wZXJqaXlR?=
 =?utf-8?B?TXUwZGdrUlNvVUNMU2VtZ2k5ZFpiNGo0SmtqZE9nem85TDQ1d3NDRkxrNTE4?=
 =?utf-8?B?UUZ1NWkwcncwUTloZ3d3MUVPMFp3NjVKZ0VuRmFTbUVuZzEvUy9HRGY3WXRP?=
 =?utf-8?B?amhNd3hJa21CUlJGdzh3N2VCampwSDhyaEEyS1MxcUY5dlpmN0JaM0VKRXRY?=
 =?utf-8?B?dWVYSzZJNS9vaXQyL2lMRFFTQWt6dkZwc0RCOFQxYmVEQ09BWk5ONDJ2MXdL?=
 =?utf-8?B?SEJpZWNVcFFVQ0JERUlDYUs3RURZUWxlL3krYnRDK1pWUVAyY0lQSGxkeFZB?=
 =?utf-8?B?ZndNUXVHUjZKVnRLME94aDdUbk1yc2JFL3hzZ0R5RUEvL1M5Tk1OZHpicHFJ?=
 =?utf-8?B?SEZSZjN3SUl3VUROMjJuSWZzZDBSeEJkYTlJaWFkV1BOdEgzSXBock14ZTJk?=
 =?utf-8?B?dVQ4Wm5ZWVVkNDljUGFNMStzeUNNcHhjOHB3bU9Md1M2S2VpYWZreEpvUzRE?=
 =?utf-8?Q?ectFlw9TvL0VblJzQoZMu73Xp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3caeceb3-4a4f-405c-374f-08ddba3fb9c0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 14:41:41.9435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBXR+2q+EapSpQgHkh5/9Jq461dR0CCDXWBqwMhj5a+8osn+bqLrjhP2MtI0ll2m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340

On 3 Jul 2025, at 2:06, Aboorva Devarajan wrote:

> From: Donet Tom <donettom@linux.ibm.com>
>
> PowerPC64 supports a 4PB virtual address space, but this test was
> previously limited to 512TB. This patch extends the coverage up to
> the full 4PB VA range on PowerPC64.
>
> Memory from 0 to 128TB is allocated without an address hint, while
> allocations from 128TB to 4PB use a hint address.
>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>  tools/testing/selftests/mm/virtual_address_range.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/t=
esting/selftests/mm/virtual_address_range.c
> index e24c36a39f22..619acf0b9239 100644
> --- a/tools/testing/selftests/mm/virtual_address_range.c
> +++ b/tools/testing/selftests/mm/virtual_address_range.c
> @@ -50,6 +50,7 @@
>  #define NR_CHUNKS_256TB   (NR_CHUNKS_128TB * 2UL)
>  #define NR_CHUNKS_384TB   (NR_CHUNKS_128TB * 3UL)
>  #define NR_CHUNKS_3840TB  (NR_CHUNKS_128TB * 30UL)
> +#define NR_CHUNKS_3968TB  (NR_CHUNKS_128TB * 31UL)
>
>  #define ADDR_MARK_128TB  (1UL << 47) /* First address beyond 128TB */
>  #define ADDR_MARK_256TB  (1UL << 48) /* First address beyond 256TB */
> @@ -59,6 +60,11 @@
>  #define HIGH_ADDR_SHIFT 49
>  #define NR_CHUNKS_LOW   NR_CHUNKS_256TB
>  #define NR_CHUNKS_HIGH  NR_CHUNKS_3840TB
> +#elif defined(__PPC64__)
> +#define HIGH_ADDR_MARK  ADDR_MARK_128TB
> +#define HIGH_ADDR_SHIFT 48
> +#define NR_CHUNKS_LOW   NR_CHUNKS_128TB
> +#define NR_CHUNKS_HIGH  NR_CHUNKS_3968TB
>  #else
>  #define HIGH_ADDR_MARK  ADDR_MARK_128TB
>  #define HIGH_ADDR_SHIFT 48

Could you also update the comment above this code to say PowerPC64 also
supports 4PB virtual address space?

From the comment, arm64 supports 4PB but its NR_CHUNKS_HIGH is only 3840TB,
whereas PowerPC64 here can get to 3968TB. I do not know why arm64=E2=80=99s
4PB is smaller. ;)

Otherwise, the patch looks good to me.

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

