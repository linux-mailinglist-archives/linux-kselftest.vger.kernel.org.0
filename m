Return-Path: <linux-kselftest+bounces-16684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3533F964877
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 16:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A30F1C20CAA
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 14:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379541591E8;
	Thu, 29 Aug 2024 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MyiYKn98"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13F21AAE28;
	Thu, 29 Aug 2024 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941948; cv=fail; b=SOk1M/7YV20z5euqzmQ94rQGFmsf7yua0q08kGKS/LJI7oFqmj+bIXoOsywHd+shGMrzF95JinDfwTtBVZ/zgj5GBQcT4/NckVY6ng1NjHgDalmm1Nno62zs5dE4J4CbcvyCNf4GGo/RXYGBJfaKSVqAp316+E3EHElqZBXD7fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941948; c=relaxed/simple;
	bh=vfv5V3VBuWJmfNohu6KMaE61EHNtILeCq4qze21mShQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y7qxcQWfFXfGBTRll59cZq4SU/MpNzrnxgtKouf6Vxeu0+RXevQl89WPR4AcBhDNHRU/zqGKd94jWH5hZddojuLKXStw+CrBgPVvbP/XvF+f2c4fpmZXVe9oxKg2WDqHiqiEULJ80R4U7Q1PReAzr+P3+mlD56DukS1b+AtGU/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MyiYKn98; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFePmQhyTwrVO/Ea/TDORmzqYfC6F4bt8k/r4SscmR6sv/Ly1JOOnAPLBiCAV2BMMX8dSFJbWZRXWin+kc1QJxBOLCq/4prJDw3II7EtY3CKSIovscI7VQ2jr746W7d632sHPORZok5eIbip9ren4If/dN/FmIOv+diUSSs86YmERtZaEwHSlBkUQfOaB9F0wqmlWQGcW9App/5RcI5s0v7fD6InMMVacTVC190jfU/xdFQOhKYa/nKMHYQJfKCpzR3TFVnoQYq3XOG2NE5WFxIcphmx3SXL9NYp5Bz4kI/Epl7UNY/3vCSquPqq/yC7IF/kTtllLrpnOtLOQFE3CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNpHT2Yxe2NFbuJZ8poOjuFF162UA8VU/jxgVdsLRpI=;
 b=ZIYMaCpef5/BAJf+j+tdHQjRCcyxvXuqt7/1Q6DIJDB7armpi18p/1sfPIy5OfuBXEOhaNHSrtAErshgre5HnwsXIygLNb2q3aZAujO13WOSaRqef6E1dWZv+mdLaynGsZet2ZNbmC0hwMD+SIWn3EIZsJjRfmq2Wg8x1p2EqSh7FHysL4Qhdf+/scsrm8vnfXMr1DHc0Ch8vlWBhsXl61Soe4RV2qmLGs/Ktrg5BHBrByVumXg2KgzgrRoDH/c+0+Mu0Du4/24MYzoiKwQ9wQ520Q5oxudrQdC+ckn8LYZshbxjxzqvQIX1r+i/7tn3eWx30+ZuzEGdnt4wG3GP9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNpHT2Yxe2NFbuJZ8poOjuFF162UA8VU/jxgVdsLRpI=;
 b=MyiYKn98Iro5BQJAAzXPxEnw38M0etGzcLsPG3aODB13GR3rCPAxP8DwQcoWY+plogTGm7HJbWN+e03TJY++ORutkRAmR3qu9+qXELrBK+w5ID+sbOxAHrEq9WYwACPm09BQX/ha2rCSYIcgOVGCXDpY3kQHPHnPXqjXdZgT7QQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 IA0PR12MB8716.namprd12.prod.outlook.com (2603:10b6:208:485::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 14:32:24 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%5]) with mapi id 15.20.7897.021; Thu, 29 Aug 2024
 14:32:23 +0000
Message-ID: <a990d0db-119b-46c4-be56-86571d3ac184@amd.com>
Date: Thu, 29 Aug 2024 20:02:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/4] KVM: x86: nSVM: Implement support for nested
 Bus Lock Threshold
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com, Manali Shukla <manali.shukla@amd.com>
References: <20240709175145.9986-1-manali.shukla@amd.com>
 <20240709175145.9986-4-manali.shukla@amd.com> <Zr-zKxHiaFbnKvw_@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <Zr-zKxHiaFbnKvw_@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::30) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|IA0PR12MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: 999e7bc3-88d3-432c-13a0-08dcc83765ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3hucVJWQm5oeGcwQnhKMWVXMnNpRGUrQVh4NHdBcmJ4Z3MweXErMlFMcEhH?=
 =?utf-8?B?RDZJU0t4MEtCak1uN0JmVGRySDY2cWNJbGxxNkRxak5iRUozeDZZbnMvQ1ox?=
 =?utf-8?B?UlVyVTI4eE9WRlMvM0dweDRWWnhjOElXK0ZpRS9uZGV0djZPdWpNbk9pbUhF?=
 =?utf-8?B?UnZaRjBsdTF0MXFhL0E2aUFyUnZXRUFKdHI2cTdiVEZtaE9FQnkyNWJKZ0xm?=
 =?utf-8?B?RWdacjNkWjF4MTdNRFhhbHk0a0ZVemVPdlg0djdEbEhQcTZCTmVTbWdDMnhu?=
 =?utf-8?B?SWU3K3JBT1VTdGN5RG1veVpVQWppMjNJQjFrdmVqVm9pSW9nREI4cEU1ZUxa?=
 =?utf-8?B?eWo3UlpFejdUUmQ2UVpTUExmSjlwSHJiWkVRNDQwTGowaHZFcmhJZmZMamM5?=
 =?utf-8?B?dVlTaUI4NENwZ0thd2kyaTNUc1IvODhld2E3eWZqVzlLRmlxNUlaYzFaVzlo?=
 =?utf-8?B?MHVCZFBBdUNYbWd6WkJBbVFJUGsyMFMxK3d3ck4wbFp3bGVtbFJiS204WHgr?=
 =?utf-8?B?N2QrOEQxSm9LQncwTFpmTzVmRllJS01wMnNCQjd5VmtidWhONXIwbk50UGpL?=
 =?utf-8?B?MVBEb2RQRWVFZ1FrSDZzTFF5cmVieWREUUJtSE04WkhiZXROamwwTmlaV3Qv?=
 =?utf-8?B?aUl6ZTcyb05IZ3VLRFZlL0RUZm5mcXhvSDZ0cXhLeWNnM0dFb285UkRmZE1t?=
 =?utf-8?B?OXZUTEhNNzVJQU96U2phUDJpL2xIN3Q3eERld3BndFVQTkI4KzJLSHZWWnFC?=
 =?utf-8?B?UlZpN1lTSUJGWnFSUGZkS3ppaFNSZ1AyZGtxanBUTHJyaTh5ZW1IdWJlM3lz?=
 =?utf-8?B?VER4V3ZoU010NlBRQklXN0tlVTN2TE9GdjNSZmxYMW5TcWc1WWtnM3JRZ2dU?=
 =?utf-8?B?TzFhVHpLNVN6VHlZbXh4emkzOTZ3TEx6VUFLNVQzMU0rYVpTZWU5Q05CeHFt?=
 =?utf-8?B?M2FJV0w2eVM1bzI3a2syWjYwVHBvN21xUFpjNUFYeE1mbzQ1cWdiL3JhOGwr?=
 =?utf-8?B?cGhaRmpxWXVqNnFMS1l5c2NHK2t6Rzh3ekdmYkNDMVVrYUY1TkZZUUlYM0RY?=
 =?utf-8?B?L1gyR0NGdzQ2cTZXRXoyQk9nQUdXNVd4MmoyY2IxL2pQWUF0Uk5NSCthYy9R?=
 =?utf-8?B?QmViYjA3aTNiUHJtOUZQSVFkMFE0Z2hxNEF5WTV4YXdyeFVOVGV0a1pnOWpE?=
 =?utf-8?B?L2YyNHZicDJKUm1OUkNvTjBveDNnQjJzU1M2R0tNQy9yVS9TZFIzd2gvS0VD?=
 =?utf-8?B?Zm1vTVJ1dWhJYWdMdVR0R0syc2RIamVUcVlWeUFqdWN6MmQ5RWo5RU8zWFU4?=
 =?utf-8?B?RTRzUUk4eTNYOS9XTmVjT1pmVnNRaFVSZ3VkNmkxREhWSk1KeFFjQWtIMHRi?=
 =?utf-8?B?K05qZmRCWkRKdkxWMVY0aytvVkw2NUhNc2NMZXhEemR2R2F3WC9aR09TUyt5?=
 =?utf-8?B?WkhraS9SMnpxTkhhT3p3UHdCRGZHeHRQVjNjd01USFBtd1BzQktIWFVCV1J6?=
 =?utf-8?B?ay9uYXJ1Q1FDUVA1bXgxQnE3QTlZelVqdlRmSnZPdXJQdWVRYTVlYjh2S1FL?=
 =?utf-8?B?ZHJWbmhoeGFVYjBSTnh3Q2hVa1VHNk5DNERTK2lUV29lL3pGWFRJR0tqaERj?=
 =?utf-8?B?bFRCdDg3WlpESWFKTXdBTzM1cmZLS2FSLzd0cVVPZkw2WWwveWtjNkxPNHFo?=
 =?utf-8?B?d0s1bkx0S2hSYlg2cTlOZGdCNWJ3eHN5MjNXcUFxdDN4ekFJYVZYdm9WQTFJ?=
 =?utf-8?B?N0ppeWZsL0dVM0lsMy8xNHpGNXdWNkx4SUdTd1NOckFaRnF4QWl6cVlHNnd1?=
 =?utf-8?B?Ykt4VUFwUllXeTRvS3hSdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3FabG5oQnBwY2hpMmZ1OGlvcTBmS2VuL2dYT3J6TWpVbXpyYUtqam9OeHBX?=
 =?utf-8?B?cnhkQk82N1RRQXpmQ21YVVZiVjUxdmUzZjJwNitSbXh1SXZLV0FOSXZsS3FI?=
 =?utf-8?B?RXNuTEZlUjZZV0s0TW5ISWlNYlltL0p6ekR3NkprOURGYjJhbVlrQjdnUjlC?=
 =?utf-8?B?WG1NNjNvSmNNVUlaYXZ6TDF5eEpTeVFleHpFMXBFS28wVHdFdjROVFpRZ3NB?=
 =?utf-8?B?M3UxaHhoVFUycUJIU3RiQ2syUmpiVW9pZExDSkhBY2trbUl4VENNcEl6UHVa?=
 =?utf-8?B?OUdHVmdvSjBIaEZITCtjNmREWHRrZkVkSER1Zy8wQmQ3SnB5WDIyOFFRT3kv?=
 =?utf-8?B?Qytic2ZMZ1BiVzlyLzlhaHgzeWhoMmljd3I3L1Q4c1hBM2Mwb3BoTFZFUGhK?=
 =?utf-8?B?aDhEc1NQNktGTlBlSVlTSUNtVUxvd2IwQVd0ZFljUW1VOEVHTFJjdEljbGIv?=
 =?utf-8?B?Tnlib2RnL25WTlhGUUpsUVJhVXJXTDd6WTBmM1ovK21OVEx5RnUwekxVeDR6?=
 =?utf-8?B?b3E0dWdFVVh2amFRL1Bib0c0L1B4WTBNQWt6VWdmUmg0aHJGaUJjWlJrei9w?=
 =?utf-8?B?bnRlNTFpYjU2SzU4TXBQK2NodGJDZlhOeXJZQ3lpNG84NWQzcmFPMXo2UFlS?=
 =?utf-8?B?YTk1bjJtWGR3RmM0VDhJWWl4VHVPZTNjVlk2RlFLZFV3ZTlocjdjWGhTcFl2?=
 =?utf-8?B?ZmNIeEZuNS83RmpEZUlXTTcyQ2hoR2ZjZ0poRVg5SkFjL2hxeU8vVHYwaWR6?=
 =?utf-8?B?ZUZEVDZSb3Q1d21TT0ZrREZONzBIV3RwMXpNc0FrZEo4V3BBWktWbVFCMzZl?=
 =?utf-8?B?b3hsSW1WUnZTbExYRE9QUG5ZaVRHNEN3THZuWnozQS8xVTc3cWFqT1pmNERy?=
 =?utf-8?B?cWpWY3BxMEsyR3B0TzFQYXcwdEdPc0VNZFlrQi9lMTVucW5HNUZWOUtMSHBs?=
 =?utf-8?B?WTZxaTNKazVPQ0FZZGlUNzIwYjFxeVRSTXY1cDIzOTE2bHlncDdyekdxajlN?=
 =?utf-8?B?Z3E5d09tdVp1Z0g1S1BMcG5OZGQ1aDQ2cU5LZk9uU2RNaDh2ZlpFbXFjQjU1?=
 =?utf-8?B?R1pMb0NWTUs0OHNha2VIOUYyV01jaTRYWGhQbzJBUmcrMzhHTy9iYXM2alZC?=
 =?utf-8?B?TkppN0NZWHY3MWxzaVFHS3Fya3k0dHgyMWNwWWU0czIrUjlXYVlqT0F5Q3g3?=
 =?utf-8?B?ZXZIeFM0bXp0REIyTUFkNWJYaGlLMDNHd2hVQTZwaW1PVXpwK1RkTk9sUVFF?=
 =?utf-8?B?SEdUU1VObk1kM2lMdXEvcjJaWHkzTzY3bFV3cUF1R2lzTjhCeXl2RXpzRkFa?=
 =?utf-8?B?WXV3MDJSTHg1cjRTMGRLWXRGYjVRVjA1RjlHWEQvcXNnOVJzbG5YRjZ4dkxZ?=
 =?utf-8?B?WEJUWEF3eFhGVks2djN4SityL2swNEhHVGxMRmV6MjA5UlFpQXB3SFhlT01q?=
 =?utf-8?B?NHAxeWc3dmxKZE1yWDRrSUZpeG1NTklSWUxrQ0t2aWc0RVJjYzBCZ2p2V3hp?=
 =?utf-8?B?SjQzeWh6SXAvZWphK2QxQllCdDQzZHVtSjlzMmRZTXJHS21rYWtyMTd4TDBu?=
 =?utf-8?B?VWtrTzR2TlhSb3QwS3NDc1FJYVhBb2VRZS9KRGQwZjNydll5NEN2a3pQeVJ1?=
 =?utf-8?B?TTBpK2M1dW9NVThheDFNajhBdjhxemRmTCt2NkdabytlYWhyWXhBWmVoei9U?=
 =?utf-8?B?TlQvbFFyTEFuWDNYYjh4NzkvdnZTNkhwOWRRQmtUUlU5blNOZ0dNL0xjTGJR?=
 =?utf-8?B?R3RBSy9qRDREUElucW5MN05FS1BZRllKSk0rdWp3TENhV1lEdlpIaTZjeWRs?=
 =?utf-8?B?YU5sWU5ob2FlVXRKTitaUXZMamRoenNVcExtR0lZTyszcmpYZXhxdHJWT2JB?=
 =?utf-8?B?WmZKNmU4UTQzd3JGUGlYZ0dRWDdXaE5wdjRtZGhwTGFxaGVIUmM0VWo2OUJk?=
 =?utf-8?B?YjhwcHViNWpCQk0rYTBtaVh0Um81dkc1cVVXMEtmKzA2a3RMT2RHcUE3L0xJ?=
 =?utf-8?B?M255L2ZDV25saVZpOWtIYkxxTUdwdUlxQ0sya1pqMWtlZkNEckIva1d6QTFk?=
 =?utf-8?B?ZzJGZFJYWklybUp6UU1oMm9jeklsZFlMcVBaSHJQZ28zb3BoVUgxR0x4K2Np?=
 =?utf-8?Q?1bK9RNwWbYioUeUGYSUO4opuj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 999e7bc3-88d3-432c-13a0-08dcc83765ae
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 14:32:23.8892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PfAQCAm/xKr0ezkHkrwGbaYoU0MfohnueCD8IFnXU13zkQF4J6sa7JDCxpExubiZ3VN9G6KnOQwoJzqq0wSTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8716

On 8/17/2024 1:44 AM, Sean Christopherson wrote:
> On Tue, Jul 09, 2024, Manali Shukla wrote:
>> @@ -758,6 +759,16 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
>>  		}
>>  	}
>>  
>> +	/*
>> +	 * If guest intercepts BUSLOCK, use guest's bus_lock_counter value,
>> +	 * otherwise use host bus_lock_counter value.
>> +	 */
>> +	if (guest_can_use(vcpu, X86_FEATURE_BUS_LOCK_THRESHOLD) &&
>> +	    vmcb12_is_intercept(&svm->nested.ctl, INTERCEPT_BUSLOCK))
>> +		vmcb02->control.bus_lock_counter = svm->nested.ctl.bus_lock_counter;
>> +	else
>> +		vmcb02->control.bus_lock_counter = vmcb01->control.bus_lock_counter;
> 
> Copying vmcb01's count to/from vmcb02 belongs in the core enabling patch.  From
> KVM's perspective, the counter is associated with a vCPU, not a VMCB, and so the
> count should keep running across nested transitions.
> 
> As written, taking only the core enabling patch will mean that L2 runs with the
> wrong count.  Amusingly, because '0' means "always exit", L2 would run in a *more*
> restrictive environment due to the VMCB being zero-allocated.

Yeah. From my testing, with core enabling patch + copying vmcb01's count to/from vmcb02,
L2 runs with correct value of bus lock counter and counter continues to run across
nested transitions. The bus lock exit happens to L0 hypervisor when buslock is generated
from L2 guest.

- Manali

