Return-Path: <linux-kselftest+bounces-28656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D575A59B8A
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 17:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 897347A8661
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 16:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48660232369;
	Mon, 10 Mar 2025 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qR+D3mGa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA7B2309A7;
	Mon, 10 Mar 2025 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624935; cv=fail; b=Q7B+uu4hV2XjQkz5E9EjROc8lVc01GQTXLg/t5hzqLRBk+qZAf+lDQkwWwHWxZhst5arSbBLgN4JhVsCGBqtGUmRs3+RtI3B/M+3rSPlHoTLvCkR7YG91vrXvuQDBkSTPMolLMTTxSf9EtCQqoxmIcKRorqwfYq70pcD1cP39h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624935; c=relaxed/simple;
	bh=QS+86MZVl8h1BSc9Luku8Gsgzz9C277lwZuMHEQ2cm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=soATshxV9yBDFKC4rA0VtVz2gH7oGmyBqvek/ep9swAwfukcaNAPUfPVX22FGoZWfmrKLLeK0fKC53JQPlFSSO1jry9Tpz5TQnriFh+HbNuWpRIiTOKpsi9BA3ZGQVLLHlQbIUBwR1mV+QP4GmZCKHwSOR4XC0WgairtsPJ7/eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qR+D3mGa; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnbe+D4NvfUhQQlMwIA9liKQdWwo3AYm4ygLow6MslwaLm54kaQMJW3AV331No2eM/VDrhkXgKpYwH8QCPkLiJX7Gzse6ORfZ2Nrv7kLrcUJ2uZGu9cTvF37zH4M2iKIpKgguVOLppGVLq5hd0oMMkojYdz/86/s5aab/0cmXcMsbtbhXlPsVLgJFqpE0mRZGqsoRAXpZ8WQyHZj9+Xi1q72JJPXltUFG8eMgpAEjCSmaK3iuJZ9rHbqw2o5RMdjddoGeKyIxdpecOlxhUTk5yRxfZMA5mTFdSuzfE2zSnF4sWwg67tbwxbtSE5ZuVeLJrowWrEY3G4Mu5/Nf3ITpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9D3TwKZdbt/5hJ337GUt5gyjLYgZIIxPhUPJnjk5JU=;
 b=ZOjsZ64P9RO70HRlOziItC1HqY7CdPbUwbM5xuujzqOg+bngm8v44r3997IH13Xe/zfFKOwTHZ/A/A5MLx5LhT8d22xMSot5w4TqijrLNBazuY+zLtYesCcrq1T/6ErrnFVwicBCNbD2p+7vfelwZz/eZT2LUfAaWyIkSlAYzNrBokR4FfSQGLZMGspasPjzwcWpI+kiRYGPWHhxU+TsvZsBBhgT6P6oFFIxLJCSJ6lcw7gUbAnYmrKkWnob+yEAnfqtmQJiriIi+1yWDMsIZ+6n+sYtyGsDCBG1F9QAY8dXg2JfSDuEdZRF0/VZD2Czt/3fxumMcNZmQpp3H5DVdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9D3TwKZdbt/5hJ337GUt5gyjLYgZIIxPhUPJnjk5JU=;
 b=qR+D3mGaP6NnXDBhA/krGDKNafgjNu2arM4Sy8s26PedsTalr9kWF0hGU/8HIU8zW4iU1+eWcgS5P4Cr5KAnF0UNqKXT6olMiAc+uHmw+SalM+o5e5xDAFIa+b/wT6Po3dLTkPF11jnanQipVXS+twTC85npage/RWJGSMAlNJweAqxWXQFjt2GR/SA+wJLnv1FC9g9PezZHMMfnk6l3e2JI18XljN1ADoUqqSCNn3y6/2K+fZVTrqB2S7driw4wXrqVKNJEETmGC4+zBx6mNoPFFv8ZarKDGLExxJosqU5M8PFI0xlhE63te1ho3wL+9VqNrchBuO3B3AUgfJsXog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.26; Mon, 10 Mar 2025 16:42:09 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 16:42:09 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, Yang Shi <yang@os.amperecomputing.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v10 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
Date: Mon, 10 Mar 2025 12:42:06 -0400
X-Mailer: MailMate (2.0r6233)
Message-ID: <D94BB56F-4BA0-4376-B5C4-7E38D2D92624@nvidia.com>
In-Reply-To: <A10312E5-F4CE-4CBA-B7CB-D435DFEA496F@nvidia.com>
References: <20250307174001.242794-1-ziy@nvidia.com>
 <20250307174001.242794-3-ziy@nvidia.com>
 <Z88ToirSWa_meevw@casper.infradead.org>
 <A10312E5-F4CE-4CBA-B7CB-D435DFEA496F@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0244.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::9) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6d250a-8f62-4488-a2da-08dd5ff2802c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0x5T1hOWFVDdkNDV3VSekc0emVkeVRkWkcyVittcGZQSEY0Sy9NWXRRQUxM?=
 =?utf-8?B?bzFpYTRlbi9yc0ZkSjZML2NrZHd1WGpERmlJYjZsSnJoTGtieDRmM1V0TkE2?=
 =?utf-8?B?cXFCRFY1WnZqTjgvMkEyMDNMSjhkcnZrZk5hNjhZZU51Y2N3a1BSMTBCRkR2?=
 =?utf-8?B?YlJ0a09vME1uR0dFNW5kOVdoUDdXTXBYa0R6WDlrcTNlQ0d1THpQS2FJUUxR?=
 =?utf-8?B?WWpsc1ZOeWJvcTFHcGhqL2hlSkZKdUJFbUx4WllYa0JQQy80ME01TllibEJo?=
 =?utf-8?B?Rk1GbnR2SFZ2KzUvUS8yYmhKbXZRZ1RtY1dCS3IyWitNSGFnYUJIUkRnSi9U?=
 =?utf-8?B?TmkvTitEUTdzK1Q5Z01SWUF1NlhXNUU1Q2YwM2hVaHlnVUF0SDlvMmVXdXNL?=
 =?utf-8?B?TlVGM1h3THFDeGlhdTR4UFRsY2JaOC9NZUowbFBieFNNWCs4MnBTQXVOODI5?=
 =?utf-8?B?M2R5WDRLSHQyUjJZUks3YkRPRWx4M1J2MjBaOHFYQ0hGajZoeXB3NnlEUXpq?=
 =?utf-8?B?c2VMOXdlMlUxUWFqYVlNaVdsTGszbnFNZFFSdzZzVGlnb0VOeTY2cGZtWU1J?=
 =?utf-8?B?YXQ3bkRhY1pweEtSc3NMbC8xalpZRjBnRnkzS2IweHFabnlGRkRmZEl0SFZK?=
 =?utf-8?B?QWY0ZmhXUHBGY0ZSbmRxaWRDQ2RlSGgwTWc1RDVhZUg0WkovWjRLdVNHcHpR?=
 =?utf-8?B?bTZjNHM0Ymx5dXFxaHhxdzUwZFpXbFpUZlNqVFAwajFFSVJ6Y3pzZC94Skdx?=
 =?utf-8?B?SU5vRElYZy9kMDJxK1VzY3VsbzVDclUrRlBzb0lpSkVqN0VqZDE1OFRNMk1E?=
 =?utf-8?B?alQyR0RTSEEwTUtpVnZxaHNyRzA0RUM5ZVhKODNpWGFCRTlLZnQ0cVB1dnE3?=
 =?utf-8?B?OXVBNXFRc1diK2VkU3ZqSVQ3dXBaK2gxcEN3VTl6T05HdFFyMmtVdStOVEFT?=
 =?utf-8?B?ekQ0UUFycEg2ekZtWEFyaEozNlVhTStBTlVkRnEyVVdFUEhPeFA5Tk1ZcXFV?=
 =?utf-8?B?dGZvYkFITnA2eDh5SDVIbnVKbHlCcVlnbkVLb0pLcy9RWlAxM3B6MkhHSkxq?=
 =?utf-8?B?aWFVYncrMk9jUjRLVkw5L08vUlgzZGZBZ1FnRGJNVXY0b1VyQ1pCTm5Nb1lI?=
 =?utf-8?B?VThmU1h4cnVuWFUzdzQ0aEYyNUlId2RqbSs4Tk1xSkxXeW9ZNC9nODF2UVhv?=
 =?utf-8?B?S3hLS3czNzNGRXg1UjY3enNmd0U1TFhncDJ5ankyM1BaVnZrK3RpZW0zdnRP?=
 =?utf-8?B?a29sVlBsWEh6Z0hnMm8rcENJVGI5VjV2YjNDc3Z4RmdNc0pvcjVxbW5DKzRL?=
 =?utf-8?B?c2s0SVl2Q3BweWczNmUzWTZZaUpST1hERWxVS0VTYWFlNnJmRC93RW9FR3Az?=
 =?utf-8?B?Q1dtOWwzVlg1dGl4Ulk0bzFNc3VOa0RXclNCRXR4S0xIclNhck9YKytrQzQw?=
 =?utf-8?B?cXVEMzZKdlI5VkFLc3lTUjJleENvUDkxaUdEMHQyeEJmTVVPNHFmbllDdVlh?=
 =?utf-8?B?MDRJY1JiWHpFMWswSGZGbndOOU9VN0NobVVGYzY3clZ5RW9MUzI3ZitXN2g3?=
 =?utf-8?B?dXJoK01OYzhFK1FBU1NueWRoTW9OVTJvQ29rQkFKdTlINEZFZTlNc3l5cGs1?=
 =?utf-8?B?bkxORCtEZkVJemRsclNxYmphLy93RXVTb2p1QjJKWXFzRDVZRHk5VjQ2eWN5?=
 =?utf-8?B?eldhS3RIZFlTWnA0S2Nyb1BNQkdLeEVNUllSUmdNVjc5MjUzd1RoelZMdDd5?=
 =?utf-8?B?UnBmbEhNQlk3L0Zsa2lJa2ZPa2RIQ3JVQUJZYnMvSURLcGNEbnZZWTRwdTRj?=
 =?utf-8?B?blVHMndsaGlTZmNYeUVwK3NBc1pjMU1PTDlOL21oTnIrTXQwbyt3SmxWaExX?=
 =?utf-8?Q?FFpYbGeFDLjIN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzRiVHpXUmtmY0JHMUlXdkxRSXZoZWc0emtadlptSGgxZGxONk45cmdxa1Zt?=
 =?utf-8?B?UWVITkN3RVI5ZlJscVhiN3k3bG4wY3EwZjlpOWJ4T0NnM25YWWlrV2hOSlgz?=
 =?utf-8?B?R2hPN0JtNDZnSWlvdHBpTDlxa29QekwrNGxSelpVWG8wclhmclpLZExvcmRw?=
 =?utf-8?B?elY2TGhLUE4yRkFNR0FMTjl5bVlIYkxJMUxBL1gvVldrZUhzUmwyWVQraXJV?=
 =?utf-8?B?a2ROaEovUWpzQ29DUS9JWGl1bGZPZUR2MlY0NWtKcVlKWTNBRE9MZFR1bzht?=
 =?utf-8?B?RkFTZ0JUQnViTU51bDNpSWo0RWNoWFNUQ0RXV0pNQlE2NmErVVZuZFZ4VWw5?=
 =?utf-8?B?YTJ3Mi9RVDZ4dUFqclhBbWMvL2gza29MWVpQM0JLay81bXlWb05MdWhicUho?=
 =?utf-8?B?WkJFeEdibkhxa0FramlFdm1lTm9lcllCRnVDQVVwN3pHSVB3REcwUC81NmI4?=
 =?utf-8?B?R1FSemJkMVRURlhaSDcrVFBYUEk2NjJyQ3YyK1NsRGV4eE9XYTkzU1o3RkU2?=
 =?utf-8?B?bno1eDNHSlB5T0JxVWNoMGJVb0VrYXJZd05FM0Z0SHNUcVhjOHFZV24yQ2RI?=
 =?utf-8?B?aFlLeE4rNFNsQVpIZzNhaGRFYitxTXlvUy9EU2NzQzNxZjAyVnJwMEkxQjZY?=
 =?utf-8?B?Z1NBdE9OZ2FLMjZxWWdhY0N4VWk1cGZBNWgvelRySnIvVEZJb0JEVU5LSURx?=
 =?utf-8?B?Z2g5TndrK0lLODlxb295cGdWdnlQK1Zwa0J6cEJkWE5vaUllNXdWQ3liM2Fp?=
 =?utf-8?B?NmxUZGJVMEpXUEtPV0phOW5tTHFoUFQzUUE2RzRneTY2UWI5UlBTN0RYUlVB?=
 =?utf-8?B?VkNKNHYrcUI0d0J1OHhPMVAyNmVWc29nMVNQUENoeDNKNDBFbEN5MVJNblBs?=
 =?utf-8?B?NVJwSE5qRXUwV21HRWhOU1EyU21TcmNFVHg5dllBN290T3Bld2NiN2hORVRa?=
 =?utf-8?B?MzlGQTBPeDcwZlNJU2FrMUY5RlZ4QnRCdkpDd1VZL3pySWFJOGhDNEVDNS9V?=
 =?utf-8?B?NkcyQ0VXbHBlTUMzYmtrU0lrTjR5bmVUOVBxQTN1Q3FqOTB6QnZ1N0x5dENN?=
 =?utf-8?B?OWJScVJqNTlDOVVENzVsSmpreEl6UmZ1YnBmYWk3QVc4OXJPUVJMUllMR3kv?=
 =?utf-8?B?SVpzWFRHWmI0bWpQUW9yRC9yTTUwOFNvS1dhZzRzMndtNmQwSGZlMzhJVXBW?=
 =?utf-8?B?bkt3QjE4b01WNmlKcGhLL2JvUVBFUE5MQ0Vqc3lYN2FTMGI4K09MelU4dXRK?=
 =?utf-8?B?bksvOWE2OHphRmJJZmhtcXN2N2tSeEQ3aFBMSnQ1c2dVb01heGNJRTJtQU9K?=
 =?utf-8?B?VTZZTWV5aFlsNURlRHlONVFBbHVKdmxZN0NCemtiMzVJSk0yTmJubnN6SjB0?=
 =?utf-8?B?LzRTUjNxOWtudkJoL3ltTVBHMis2K1A4YWV2ZjRQSWlsRTliaXhkUm5hSG5I?=
 =?utf-8?B?QjREK0lQZEpiMDhTZEZuY1Y1bnFrS0pvSnhsZTdFUW1jWit2SHIwL0hwczlB?=
 =?utf-8?B?blFuZktvZVhKRFhqWXRwR21TM0c2MzJKQUVURGxDWlVHQTNJNEk1SGY4YWtM?=
 =?utf-8?B?YkhrT3lkdWRHbDh4YTRYSkd5TFBMMWxRczZIRWljS0FSQm54dm1YWDZlWjYy?=
 =?utf-8?B?ZUlvNGZOYi9iWUE2OFA4amlMZWJmSkM5LzRwM2hhL1FDWXRPeEF1N3k1YndQ?=
 =?utf-8?B?VlM2K09yai9nTFFPcnpxMGIrUkxSOTdNekFkc2U4amx0ekxMY1B1R00vUnZJ?=
 =?utf-8?B?UVprMlFaeiszcmRmYi96WWlaSzRNNUdvS0RveVdJc2FZV1pqcUhNZjdwRlpJ?=
 =?utf-8?B?d0FXbFBWOUNlWEFJVC9sZUpZTW5ETWtleTI3VU9La3M3cWZlYUhmU09IL3lR?=
 =?utf-8?B?akRsMmZHUlcyZWlKanV6YW5hZ21qOGZCcDV1M2dZZmpBVnhSc1Y4R2ZYRzlH?=
 =?utf-8?B?bnhsdFJ1N1pCajhDakoxcW9JT2YyUmdJdUNwK21pRU9BdjAvYWxQdW5HbzY5?=
 =?utf-8?B?ck1ONnlhSGF4S1cvME4wb2psQUxrcXBTWERMdzBKODlnWmZ5RU9aNG4zbStN?=
 =?utf-8?B?Z0pkZjZnZDk3QzNMQ2ZPNEJSNFRXa2ZLakZDVWEyempJaGxyWEIzZzU2bk53?=
 =?utf-8?Q?xN1flicG6/5hgwTrQ+34795Zf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6d250a-8f62-4488-a2da-08dd5ff2802c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:42:09.4601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOlSk3tRIWn4oMd5C8DGNJyeHIoaioo9zWiST0HrGluhCRQ7TDOfdNjn0bQDRX1q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204

On 10 Mar 2025, at 12:39, Zi Yan wrote:

> On 10 Mar 2025, at 12:30, Matthew Wilcox wrote:
>
>> On Fri, Mar 07, 2025 at 12:39:55PM -0500, Zi Yan wrote:
>>> +	for (index =3D new_nr_pages; index < nr_pages; index +=3D new_nr_page=
s) {
>>> +		struct page *head =3D &folio->page;
>>> +		struct page *new_head =3D head + index;
>>> +
>>> +		/*
>>> +		 * Careful: new_folio is not a "real" folio before we cleared PageTa=
il.
>>> +		 * Don't pass it around before clear_compound_head().
>>> +		 */
>>> +		struct folio *new_folio =3D (struct folio *)new_head;
>> [...]
>>> +		/* ->mapping in first and second tail page is replaced by other uses=
 */
>>> +		VM_BUG_ON_PAGE(new_nr_pages > 2 && new_head->mapping !=3D TAIL_MAPPI=
NG,
>>> +			       new_head);
>>> +		new_head->mapping =3D head->mapping;
>>> +		new_head->index =3D head->index + index;
>>
>> Why are you using new_head->mapping and ->index instead of new_folio?
>
> Because of the =E2=80=9CCareful=E2=80=9D comment. But new_folio->* should=
 be fine,
> since it is the same as new_head. So I probably can replace all
> new_head with new_folio except those VM_BUG_ON_PAGE checks?

Something like?

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f06508e4d242..007c927536bb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3341,8 +3341,8 @@ static void __split_folio_to_order(struct folio *foli=
o, int old_order,
 		 * unreferenced sub-pages of an anonymous THP: we can simply drop
 		 * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
 		 */
-		new_head->flags &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
-		new_head->flags |=3D (head->flags &
+		new_folio->flags &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
+		new_folio->flags |=3D (head->flags &
 				((1L << PG_referenced) |
 				 (1L << PG_swapbacked) |
 				 (1L << PG_swapcache) |
@@ -3364,8 +3364,8 @@ static void __split_folio_to_order(struct folio *foli=
o, int old_order,
 		/* ->mapping in first and second tail page is replaced by other uses */
 		VM_BUG_ON_PAGE(new_nr_pages > 2 && new_head->mapping !=3D TAIL_MAPPING,
 			       new_head);
-		new_head->mapping =3D head->mapping;
-		new_head->index =3D head->index + index;
+		new_folio->mapping =3D head->mapping;
+		new_folio->index =3D head->index + index;

 		/*
 		 * page->private should not be set in tail pages. Fix up and warn once



Best Regards,
Yan, Zi

