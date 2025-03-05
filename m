Return-Path: <linux-kselftest+bounces-28338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD0AA50D18
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 22:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36FE171362
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 21:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB401253357;
	Wed,  5 Mar 2025 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ol/pTPh1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BE72512F6;
	Wed,  5 Mar 2025 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741209033; cv=fail; b=H+vlBVAUpahMK6TxixQFexczP5RyTpMg5qMJTiN1Eq5I6ggWqD1onnSlCzHLDXzH1yr4CD84cD52ThS57AtDQfC4OxHfcN5bfT+DWsVWn7oRqbXOwEKf8CPI6e9hL/f0zSPzLWDpLTNcc+KdZwaNEgrEmR74crtGyRcLs85JJnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741209033; c=relaxed/simple;
	bh=cQVgy+L79WTQ/LQQ4RJD+T9Ryh/sELP5cAMu+0j1ygA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ttWS6KH4yB7UaCZ9NlpF/NK6y0fxnWzPpm1MIlbmbTiTqUee06SBoOmYkVNaTC+kbyUj7+axZkIRXz/sBwl+PoemD0kr1E3rAHktUbh2+6lK6hFj1v0Klh0Ibmi1977TdkSVrcTTah8DJx3poJAYPOZsxomDykjRK2SqBQdePKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ol/pTPh1; arc=fail smtp.client-ip=40.107.100.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpi41yPlLvWYBeM5MYJ80ueQn3pUaRAjQ9s7LxpFWWQsaIYqFS0udyD7tZjzi+yY72bksr7B5/TTJXjhGcrySMoV8uKg7c5YG2sJDs6mQiIZ22hZDYNMfB6QrhGY4et2fWnGtW+W6QW09zpY8hy5d+V+9JCzlqSNIdAe2DaKaRv/0SskYbZDg3KQnwgyMN8VQU7+ISLdo/9TqapBsMd6awU1BUoV/rmebYzKPIQFr+L1JP6QJQd9RL257zjMao1hs0OX8v9l6dOO77lkwoRcjcUf6i4NVFcUpad65aDwQKzgRurpxr/GfD74AHApDml+jAyb4G724vgsdnsC3sVsfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQVgy+L79WTQ/LQQ4RJD+T9Ryh/sELP5cAMu+0j1ygA=;
 b=Pwmz7NPKhkeWWQVN9ef5dKGjPMdqoVN3kCGFCgGJh3sL3wnq8mNkT9gvf+ksg33aTLIENawZ8IcFJHsO/qMbz3XQIGtOobrIf9QmOJH9fhLU1AJtNcTtCzfmEYAQcvIa0vyvqaxa+GPA/CctqF53RD9N5ZG+fMAImkYXsoYHFPKjKphkFpETJ8zRFmJVwWjnxUOEumpxGdQq5VOtcFCddzCvzeH6643JDDXoYjxTGLf6ERKKhrhh3LArNeOlJV9C1elAZvaDkwUujQZ983152tLasEKUkFp8oyJuhULi+ApQUMGzDrFNyUR7W7KSTl+ojl0SOqqTsG8L//fTKHHtFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQVgy+L79WTQ/LQQ4RJD+T9Ryh/sELP5cAMu+0j1ygA=;
 b=ol/pTPh1+OZUJWUfGGV8ZW+YnwAl3HnGID88aEHRfSs8gGGfvzVgCOCEQpa7STBPqhi/SMsLEJgoDZjA0hfp7S6LH0wiYPyXbu1Ihetw4ltlP7OuqRX3RobubF8l1wrUr9EjJImpNcmdmCOuPsvt6ByYnNW207mkllmxPxUbuOgR9HbCxRqMRrzVXYw7DuA9pMuN65x1aly/L/wx87757aa0wGDc3LT+HSfC1jvmtD9zRsTBnZsr6e/ka1ktDT4s7NR6RwLuyzPpxO5C7d8z/P9mUrKJT/zS0KfCruhnNvJCW0D5OjkWW0P3llot+U2gqRcGrKfQQ/tDcDtoeE7LUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 21:10:28 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 21:10:27 +0000
From: Zi Yan <ziy@nvidia.com>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>,
 Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH v9 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
Date: Wed, 05 Mar 2025 16:10:22 -0500
X-Mailer: MailMate (2.0r6233)
Message-ID: <2D7DFB2E-DB80-4F6C-A580-DEBC70318364@nvidia.com>
In-Reply-To: <0582f898-bd35-15cc-6b4d-0a3ad9c2a1a4@google.com>
References: <20250226210032.2044041-1-ziy@nvidia.com>
 <20250226210032.2044041-3-ziy@nvidia.com>
 <2fae27fe-6e2e-3587-4b68-072118d80cf8@google.com>
 <408B0C17-E144-4729-9461-80E8B5D1360C@nvidia.com>
 <0582f898-bd35-15cc-6b4d-0a3ad9c2a1a4@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::11) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: 0628274f-48ea-49af-6928-08dd5c2a2751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTRkOHlqQTNzclBtVGtwNU9zU2xPazVEdzh3ZVJ4ZTRVRkthTGZuZmlCa0g5?=
 =?utf-8?B?YVZyTjJTbHdUMmlwQUpiWUxCcFBpa0lDSnhQL1g5OGdhTVJrUEhsTVk1Z3J1?=
 =?utf-8?B?KzRjT2p0OThYanpxQ2EzT2xXRmZ4WXVPdzhlUVpnVHlvOWxHRGVpOGFtaFRV?=
 =?utf-8?B?RlJVSERrRlExTTl4UlB0c2xyV09Wd3dXckVRSHdWd2ZJbUVpQ3Y4MlEwdkJy?=
 =?utf-8?B?NHFNVmwrMDY2OHlWSjhaZmJOQjVyc3RFQUJudjR4THlGOFkyUXE4ZldLTEdj?=
 =?utf-8?B?dEQySHQ3VHdNTzlqTkRnYUdsR05MenZqeTE0YTBXdXFua2pka0pFRzFDTzVt?=
 =?utf-8?B?Vy9EMEc4cjlnVUtQemZ5QnV2em1OVm1tdzNFM0FEUzZ1M2UraUJvVjVmT2pr?=
 =?utf-8?B?dElsVVZXbTlTTjlKQzZ1amdGdUNNY0tCYWFoSGhLdFVxbVdRME94MDJ0VGcv?=
 =?utf-8?B?bG9kdno5RjVDeXM0ZzZjalZRM3ZwRytFSmhqK21IbnBxRXdwcW5UMG1veXhm?=
 =?utf-8?B?Y3d4NlZwd0MyTnRaUWx4aU1vUVNUSldnaTRnd1NmUGFvenQwb1pEK213bVZO?=
 =?utf-8?B?ZTlhSHFFd0NmSVFDbFRRRWVlYzl3SDcyVEpLcEJWNkFOeGJubDN2VTc0NFIr?=
 =?utf-8?B?RkZ5ZGxrNG5RaEZrTjZWY2dNTml3NmtheVdub3JSWmROVUVSWmN5dFphTUt2?=
 =?utf-8?B?SDRabG5BNjd5K1BLMDUwT2haNDNnOXZRazdzREFZOWw3c29iUE1oMVMyYlp2?=
 =?utf-8?B?NVNIYmNHY2FEcXhKUDlsbTZjNXFIQy9vRlRlYVlLTExvditDUjAvSFZyUk5y?=
 =?utf-8?B?Vk1ldTlmMjY2QmZwQzJwNXBQSkFQSU01SjlrcjhrVjlBTUhpcUN0T0RoU1o5?=
 =?utf-8?B?Z0NTYll4Y1ByNGVqK2h0VGlON3NScXJsSkM4WGRFanh2UWlLa3Fnd0VYeXQ4?=
 =?utf-8?B?RFlaeE9hUGRCYm5ocmkySFBCRmg5L281ZmQ0V01adG9kdjJ0MktuTEd0Qmt1?=
 =?utf-8?B?cXVKcUtuZkN1Wmo3dElQZVVTUnJ4bTdETmtpNDNmc3A4ZjdieGowZUNyaDRo?=
 =?utf-8?B?U3RLOWg1N242bnVZeWwwbm8wbE5IS3JCYmhsQlNvb0VFWStKVEQrb0VoUFQr?=
 =?utf-8?B?VEc0Nk0vcWczN1VLcFBRei93ZFJNZU0rTnVjcnBEMWN2U3JZTlZ0TTFZY1Jz?=
 =?utf-8?B?L3Jxbk84dkJlWWFxdkIxT1kzMmRRY1V1VVR2NFVTVHE5VHo0NEhsUU9hNTJo?=
 =?utf-8?B?ZWhBaFBhWDlXM0dHR2ZtcXdsT2VZcjB1cWhPenppOE9MbVd5NWgzdWh4Z1hG?=
 =?utf-8?B?NEtEZHl5MGhLSENndmFtM083cDdsa2dRS21mNWFBTUUrTkhMbE5aRmI2N0FH?=
 =?utf-8?B?Z2NaMGhlc3N6YjBUYmVwaHFPQVIyMk1GSDRxN3RMWGFLc2hIZlk4VmRTNlZn?=
 =?utf-8?B?aGpvbk9VemNKaUZDbVloOVpNMFVLOHBqeitLVE5OaFc3VXhlRXc5M3RvRTRp?=
 =?utf-8?B?L3RSWENzb0lZbXBUeDlMNUhUQUxqellQdFhyWlhxUC9IamdzVEFOODIvVUhM?=
 =?utf-8?B?Q0lOak1pbFFlNWIrVy81azUrcURyaUk3bGdNYkgwdlYzNHZkeGo4NU1uSTJz?=
 =?utf-8?B?U1ZoVEQ5VitYYlpwVXg1RzhZZzRMRHMySGZnVTFuMi94Zno0NW9UUDhxbk5a?=
 =?utf-8?B?eGkwZk5xV25TQzVwRk1ob2Y2T0VtRytlV0dsejM1SlRzeVZFeUVWK1BQWmxl?=
 =?utf-8?B?Qk9UdlhUYU1tWndvVURIOXQ4SFdQUkhQMlZEK3FmY3NlTHF1aHRJczVjMHA1?=
 =?utf-8?B?QTN5Snp2OFV1djVpRkozMFZ1KzloK29kQnVPWVN3bjR4Snd3RzhFb1d0NmZQ?=
 =?utf-8?Q?ug/eBPZgNOjWX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekljM1cvcnBOOFNsY1UxSUcrVlg4YVZZeHJYTGN4ODlCdWN5TFhKQWJzTWww?=
 =?utf-8?B?UzF1MkZJTXg0MENjUTVXZE1LYkpLSnVSTFJqU0VqRFNJQTlZaitwWFM3eW5p?=
 =?utf-8?B?Q2xmd1hQam15dlRScXVieFN3VTVHNnREQTMzVVluM0xBWEQvUmlQcGVIL0lr?=
 =?utf-8?B?WTRIK1lnWEtNTEFmQi81Smo0OVdDbC9SZW4rOFQxYVJUMnArTVMxWjh4b2NE?=
 =?utf-8?B?TGx6ZkFFdzVRemk0UklIUDYrcFlrcUVMamdQNk0yYkZuQmd1WE1JUlg1RXJR?=
 =?utf-8?B?WWY1UXI4OGJxQmNEelV3djRKeHNFRk1EbHhKMjFQT1VsYnhyT0p3cERRR0VF?=
 =?utf-8?B?VGZEcm9iQzBYT3BWKzVOTXU0ZWFOcWY3a1JjenY2VDBHWkJaN0lFaXZJbEM3?=
 =?utf-8?B?NG1PRTcyV3g5d3ZTb01wbDhTaGIxMFhoS2J6Z1ZBQ0dmTXl0aWVlRFhaWU80?=
 =?utf-8?B?ZkNxck5vZ0N4cUh5NXdGV0tCRDVpQnBNSitYaDBMNlBWYW5xK3lpbmZIZ0hT?=
 =?utf-8?B?djNmMEl2WGxGanUvcytBMmFRQlFMYVIwcE9RaTV1MWxKSzg5SE1XcEJYT2Ji?=
 =?utf-8?B?cks5dU5RNktJSDR6aDZiY25nOXZOWWhuVU9pbFRiNHZkelM4TWNOREVESzNk?=
 =?utf-8?B?Rk55cnZKdVc4bUlobU9TaFdjczczbGt0eldwbHNBUngzTkRCaitWcm5tYy91?=
 =?utf-8?B?aGN2RzZNZllsNm9HQSs2aUswZkZvSWIyQ1BZWHRWQXJVbDJiblVudEk3Rmx4?=
 =?utf-8?B?ZzNXTWUwR3F2Sy9zK2xJTkt0RGk5NDBhSXNJL2xKdWIxV3ZkRklDNHRKY09n?=
 =?utf-8?B?RzNTV3hZdnQxc1p4SDVwVUpRQ3FsNERrdnEzSTYzRHRndWNMVCtuN09Da0lX?=
 =?utf-8?B?dmlRc1Qxd1VISFBXdjNxTHlKTmRWNm81cUNnb1duY01saGhoT0I0bndxUWZR?=
 =?utf-8?B?blloQlRLRTZvR2Vhby9XWUhOS2RaZGc5MGhndHNpMkVlT3ovSlBqQkZkZEJH?=
 =?utf-8?B?c2pGNXhNNnkvanEyRmt4alNOL3dNdHA3UWNwVVFIN0k1NUVMaHNualBVcVNh?=
 =?utf-8?B?OHhDQmpXRXBrV3dPTEtzQ3ZTVUZ0bmNzZDgrQW41UmIrM3dBemdydW5IcU96?=
 =?utf-8?B?K3FxQzhLcGpYcE1wRnpobmlqT0pQcmpnc3owczFLM3ZiRGNBQ3pza205Z20x?=
 =?utf-8?B?UlhNWDRGeWNBWjI4Nk9lRzhaMUZRTkU3UEhEdUFvNWNaOC9EcVhiT1V5ZjZp?=
 =?utf-8?B?eUxQSERtVXZLazBsNXlvajdrL3RsYzZ4OXd2bnFYWC9PdmhRbkdrSTdwQjFl?=
 =?utf-8?B?SnJBQ0ZVRkRNemthRS9VRG91K25oUTQweWpjWGMyOC84WXpOR0hpc1hEZC9a?=
 =?utf-8?B?YXZuMm5TczEyaXFDTkxFeUFVR1IyeU8zcFVyZzhoTk1ETHVHUXdnM1F5QXEz?=
 =?utf-8?B?RlRBbklKemNncS9UOUg1OGYybWFRd2IrMERDS0Nwd1NyRWF0UVd0bzhyZTdT?=
 =?utf-8?B?WnczVUt1azVIRHZYNitYVUZNalBQcjR6akVOSjc2VnFHQ2FSZTBORVZZSFJn?=
 =?utf-8?B?d1JoNWFGbEJoYmRUdDYzT3prc0U3UWdEL3Ewd2M1QzF4Q2d6OTRjcnhlM2tV?=
 =?utf-8?B?UmxhZWQ5UENta29ya2wwSnp2cXRrMGRSQlB2M1RHbU5xK1hRQzZvUkpOVmZO?=
 =?utf-8?B?dGRRSWVPa01uSFh2Mnd3ZmI0UDlHWGg0OVc2cWQrbmFvMjErTTdKbDVDSG0z?=
 =?utf-8?B?R2dRcjVaVkxhaUJQZUVBcVBIRlZVUlpqQkF6VlFkd0ZBZ0lLcTdlanpQZzhU?=
 =?utf-8?B?WjVpQ3dMOFplQUJRU1h0S2xqbXBHZmc5NHRaRjB5cEJjT09vSmpzR1JKUDMz?=
 =?utf-8?B?S29vcUwrNHlXNmtueXJxYXpvVzBnM2c0WmY0bFYrbVdudmhiZE9Pd0srUFpm?=
 =?utf-8?B?ekhGajF1dzRNMlA2alI0OTQ4dXFtZGdCQVVvWEQrYWwrWnQ5SFZhZTRxT1Ax?=
 =?utf-8?B?WEFCUXAzLzZFNExNVVFUMlkrYy9UM051TTFjSFJCajFKK3lsbExJWUFzVlpE?=
 =?utf-8?B?aXNadjBLaFhhdmNpa0VqeEY4MHNXU1RPTTlWc1VMa0lEaXpsNm4xakpzZjVI?=
 =?utf-8?Q?PKSMKK0kfDP3mXmrR/I5+hyqC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0628274f-48ea-49af-6928-08dd5c2a2751
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 21:10:27.5542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLC46TDAx4tt01wLf2S7umK00I/PfLG6AU/Tmv33MZpf7nrBDIZgXWBqzagQui5z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971

On 5 Mar 2025, at 16:03, Hugh Dickins wrote:

> On Tue, 4 Mar 2025, Zi Yan wrote:
>> On 4 Mar 2025, at 6:49, Hugh Dickins wrote:
>>>
>>> I'd been unable to complete even a single iteration of my "kernel build=
s
>>> on huge tmpfs while swapping to SSD" testing during this current 6.14-r=
c
>>> mm.git cycle (6.14-rc itself fine) - until the last week, when some
>>> important fixes have come in, so I'm no longer getting I/O errors from
>>> ext4-on-loop0-on-huge-tmpfs, and "Huh VM_FAULT_OOM leaked" warnings: go=
od.
>>
>> This error should be related to the other patch I sent out on using
>> xas_try_split() in shmem_large_entry_split(). Great to have you confirm
>> it fixed some of the bugs.
>>
>>>
>>> But I still can't get beyond a few iterations, a few minutes: there's
>>> some corruption of user data, which usually manifests as a kernel build
>>> failing because fixdep couldn't find some truncated-on-the-left pathnam=
e.
>>
>> It is likely that this patch might fix it (partially):
>> https://lore.kernel.org/linux-mm/56EBE3B6-99EA-470E-B2B3-92C9C13032DF@nv=
idia.com/.
>> Andrew has picked it yesterday.
>
> No, that's a fix to a truncation issue which I had not hit:
> I did try adding that patch, but it has not helped in my case.

Got it.

>
> Beyond checking that, I didn't have time yesterday to investigate
> further, but I'll try again today (still using last weekend's mm.git).

I am trying to replicate your runs locally. Can you clarify your steps
of =E2=80=9Ckernel builds on huge tmpfs while swapping to SSD=E2=80=9D? Do =
you impose
a memory limit so that anonymous memory is swapped to SSD or make tmpfs
swap to SSD?

Thanks.


Best Regards,
Yan, Zi

