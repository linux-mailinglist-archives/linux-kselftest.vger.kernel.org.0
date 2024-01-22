Return-Path: <linux-kselftest+bounces-3355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4008A837019
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 19:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6442A1C29264
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 18:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD6A5F575;
	Mon, 22 Jan 2024 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MtnAgV7u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2695FDC5
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946821; cv=fail; b=UI2kOwmAe+14LHPkz5W4Yo3qRku+KvT2ySpxHCaNXv1LiqhYO2dL+0X7hqisjg1yZjoPLrhDzD0og3RH6qGlzPMNl36vci0m5rUD1Qcw9bRXdvKPey1x2P4PEWuuJ2+nipO4OUL1VK2bSwS1EnAu3BDA3Y5Hb2i0tezHcwGTYkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946821; c=relaxed/simple;
	bh=rRwkneEepvbO060C+cOBXTjkwV+PzhftCfwdATtxvko=;
	h=Message-ID:Date:To:CC:From:Subject:Content-Type:MIME-Version; b=YFn1WV5a5no08GbvqxocXwD9P+dYJgafSoCs9g12fB3v62LLASTfK8ay88w9TXQawhFTgQ0GFGryUDcqI0As1oa+F7fybLu30aGfs7gDTHOcVLuzuRwHI3LWIbZPJZu2XoUwCWFyGOC9GNU0sn2YUl66E/a9HSydLnsq50qBvqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MtnAgV7u; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705946820; x=1737482820;
  h=message-id:date:to:cc:from:subject:
   content-transfer-encoding:mime-version;
  bh=rRwkneEepvbO060C+cOBXTjkwV+PzhftCfwdATtxvko=;
  b=MtnAgV7uFZhPkGIdMiHcYrNTEtG2BkJbkLna2CIRGV8K/3Xq3PdlKEua
   1DRtAwqIJf/ycpuOf5wIG7AGQnFMxBKXfMNbsOnM5DfE2RUw1u5f6BuxS
   PI4MvTbkIlugezGB14oI4xwPRKg+phQP+vdNFqmHeD5zdPwYJZm78+TXW
   GrbIlfyouuSTIt+ai21mAIDnscW45U4Vg1vtufPuyRHKhjvxmyOc4CYTf
   gPd7Qikl7qYyqMaToCpdeVmcciNiPd7B8x8kUNXiQTFeBuW1jHhkJK6S/
   y8civlezXl6S2sf7dAngpkTKIjfbas4BoewjL5+5duJGchlzKrmaN23jO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="14793551"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="14793551"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 10:06:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="34113469"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 10:06:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 10:06:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 10:06:56 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 10:06:56 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 10:06:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2Tqop8jNhs6yDBbPgdRsvHxfcaGo6OxKa2wdGKu5pAkK5jq/g684JysC+uVYXeNN3d8krY88Hj1EiExm07R9tCOLW/sK9FoqAAiY+h4f4PKKwWni0OEj+pysfGy72cb9/1eJoTYnpN1sbhDayanmG2Ad7WwweqYcLiPirsK1AXrCH2PbwHaoHwyYOp7IO9ETyWgyvWNNC4NpQqZESjofZyScrpZMWLeOJ2gZjqRtotWx+CNDLj/x0djJBodKZmi/HyQId6IxCHuSAlytCRNegifjLuxbhjZbbRs+LlhY7acfjryntDWGaABxtoLQpnqNMkUHT+dw6qgr67FQ03M9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRwkneEepvbO060C+cOBXTjkwV+PzhftCfwdATtxvko=;
 b=VSp477zHuJOIJEYmi09HGS10a/GYgdbdPWw15ZrxL0f34yLEI1tIhLi+myamM0ajoVUx1ppMdi5Y3TaIr0i2ViViGzfYYjYBqxq4VoPSWo+PNBPBTPx1jhuXNKGiX2mUuNJzFI1BY15aVe1rb6lpee7HGKcEqO10byGPjpGib28gfOLuBYkrtD/HptO0dBPUszgYJkLtIrUuVmbsA8TwF+LmOLtsjXHuHplUV3/EtpRH6Wt7FO77hWSAS0qjSd+HaQ3HzPBHhUkx/g0CqojH3AqSU8EgA2/O85WQHPKeVpr3TLtQoEOZnBzPda4T8M2pq9nw4stiEd3H/FNRfWN+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH8PR11MB8013.namprd11.prod.outlook.com (2603:10b6:510:239::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 18:06:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7202.034; Mon, 22 Jan 2024
 18:06:54 +0000
Message-ID: <39f71a7a-9a3c-4b0e-aa11-7b94f1003cc4@intel.com>
Date: Mon, 22 Jan 2024 10:06:52 -0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
CC: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: resctrl selftests ready for inclusion
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:303:2b::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH8PR11MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: 38630ba2-1caf-4dba-ee99-08dc1b74ea74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A5nhqcpnote76GvHDDq3Nrn1YOEP5xAKeFl8frrCgikwOSktgZ2UK7j2vHfxSk0PoSW1syjltjIq4Gc0ORnFrbhmFCOC+4b4x90rajnqzuSjGPtUIcH28Z/XMDwQnQ7eoLh5hxJshEGjtU45BFi5IRH/QbbWA1CrBlBTv25LWVhOtC8DK1Qm89BnLA+GW/noOaLQbAsf0gzMvaEd7DkFe7vW1e+xDrJMBbhKimlrp11Kmor/OoKU3GN+0UBEBol3KWS0pfIOUK95/DpflTYP/wXmtY2n2mcqHnUX7efZHs/2EQ8GSFHl9frjg4sMrhQClDK2YgAJBFj6aNdmls+C+XIj8V2ex3uAfYm6Z4Zzs2ivA6y/IbP7dbH83XwOJoxZZ/kaZ8ITyR8MwarStNlMbwRz/r/QCrUCXusBkpczayexj0CO6FYugK02K9vZhCAtMpl2JDm45BCyxc+QDAm1bYUpbaLoYkHMZw3Y63zzQYBsN4Ruwlu8W4nUzeqHC+iKcLRcoyOwOr65KE7+3+uifdZksteyzzimYS321uiR9PI1aN60UE1hIonxqfTviQj6lFngcZQD2T/HwYKOAgY7WPgMhIaKyK2oidhtUj+lQ90Ebiw6Kk54jPZ1+HVNUWMr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(478600001)(558084003)(41300700001)(36756003)(31696002)(86362001)(38100700002)(82960400001)(6506007)(316002)(8676002)(6512007)(4326008)(6486002)(8936002)(54906003)(66556008)(66476007)(66946007)(110136005)(26005)(966005)(44832011)(2616005)(5660300002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2tjRG1wUlcrWERhTklDWEpDell4eWlqbEFPY3VRdVpQVWJqa2N4Mzh3Tm5J?=
 =?utf-8?B?ZW02WWdhZjdhSFRRVENsK2JRUklHWGFmdnFoa1NEMElrM1I1RVJkL3dpRUxx?=
 =?utf-8?B?TnNSWnF5QjlsNWcvNFh0bFRWOGdHc0dmSGNoUUVMQ2ZXb2NVN1l5eWxOQit2?=
 =?utf-8?B?V1Q3dXcvQ09LNXBYc2IycmorQkxnd2FkcXR5MUV4dXNsbmF3YzJnTUs5Q1F3?=
 =?utf-8?B?ZzQ4d2Q1dVJhYnUrOG5DU0JML0F4VDRvbTNPcEZKSk5PR01yemI5ZVBMN2tr?=
 =?utf-8?B?NTVqOXhmTW82aEgwMlVmZlhFL3VkVUdva1ZnMGU4TGJlSmlUM2JnMU4rUDY4?=
 =?utf-8?B?TjlOczdIT3JMclZqb0N5eE9jY3VhLzFPOUw1SjBrWnFBOTlCanVqU21HelEz?=
 =?utf-8?B?M3FrakFYbHZZbjBMK1JNSzlPUlM5dFVVUU1HaVJmYzdlNVBWVUEyM0MxenF1?=
 =?utf-8?B?SGJpMTNlMUlFb0ZtSWc2S3ZsUUdtbndsTThvWHNpVHkvWElaRThjMncwT3RF?=
 =?utf-8?B?cHB0QUF5L0VxN3hmTG5DWHMxRzFGNVJwd1BDOHUvNm55MTJVQUNuWTF4elIr?=
 =?utf-8?B?VCtCRDRRSzVvSlJyZXlUa1lHeW9sOHRKK3FlUzc1NW1aNFlXM3ZzS3AyVzBW?=
 =?utf-8?B?Rkc5SEJEbmFXdEJ1TEtjNUxtOHFXQWUwVEkyQU5WY0pGUUt3SGhCZkF0OUgw?=
 =?utf-8?B?UjFnWVVkQ3dVYTFuc0JPS0c4eUd5engwTnIrck1GSFJBbEg2OHBUYVQ4N1dw?=
 =?utf-8?B?UlpVdGlyWldybHY2TDl5WnN3dTZhQ3JYamZUYURXNXJkb0pXY2EvdUgvVDM1?=
 =?utf-8?B?aVhYVmNqSjBRQk5UQ2FvS3JFN0pDeW4xcXdWdEo3emdKWC9ZU1VkaElJcWFn?=
 =?utf-8?B?Z2dWOEFDMnFEODQxUmpwV2JadUdpMWtMV3FieUNES0tLbE5ZVzQ2SUhpZWRl?=
 =?utf-8?B?SklBcmJEREZBckY0SCs4Skp4R1JpNTVIeDR5YzhTa0Uvd2J1NUI4WUQxT3NM?=
 =?utf-8?B?d3ZLS0JIYVBmZGRvUGJ3SmxkdkUvZ29BNWQxenpHbFByNGZ3UlAvVlJjU05m?=
 =?utf-8?B?UXlWOHEvQXQyRkQwL0tjMitQbkcrU2ZBRkRWUTVoNmJjM051YytjSWZ5ZnRk?=
 =?utf-8?B?czZaYWxXRVlFSFVFbW1GQzZoWkNkWllqL3E0Yk5ZQmFBY1V2TkxpU3ZtM2I5?=
 =?utf-8?B?dG0wOXBsbHFIbktVNjljbzlGSUlDQVU3S2R3QXg4Mk9rZGZkZzZmRHhEWjRY?=
 =?utf-8?B?MFdRaTBSVnBRNjNLVkNhQ01BRFV2Tmp3M2lPcmFGd0VvbDNjanQxT3ljcXR5?=
 =?utf-8?B?RCs4US9PNFBtdDN1ZDlZT0JVVnJyWm1yN0NVOWpJa0xPUGpKUmRJNUlMMzdp?=
 =?utf-8?B?MFZYem96Q3MyS3ZKaTZXNG1aek5sRnFuL01DWFgyMDh2RUJ5WnZSMmt6UU5s?=
 =?utf-8?B?L0xvamoyVFRLc0ZoNklTTDFTbFhLN0RJTVErakVkRlE2eUptZ1ZGdEhZaWFY?=
 =?utf-8?B?clRBL0Y2Y1BDTHErd3RvL3V4dE9pTll4Wlk1NFQ0ZXVzSTF0OXdvVHdFOEZN?=
 =?utf-8?B?SXE4cDhyRnl4cHhUWXlDeHZYeWZZMUZ6RTN5djZ1YUNIM1lWMU82TzFNVVIw?=
 =?utf-8?B?MWNrZzU0OXNieHpjQmpOajIvMmpjR3o5blhtZXZycWRESmZXWStwL01Zd20z?=
 =?utf-8?B?dTF2R1VNMzB2VWxEYXpTNkNYYzFtRXJJR0NtcDM2T1FFVXNIVTNHOGJ1a2xu?=
 =?utf-8?B?QlR4aDNsV01RMHg2RG9OTTFxemQ2QklsS2EzLy9YWDhxSEdjLzE4MUJCTjJW?=
 =?utf-8?B?ZU5wRzJjdHh0Z25Nc3BrVEJ1bUVZcWxaQys1QXZwY3cyZFpheDhUVGorUlNW?=
 =?utf-8?B?aXdmUGM5bzJZOXBKM3A3T1BpSkx6bFZBd3RiZzhTMkNpbUgvaUR0akhsZERY?=
 =?utf-8?B?UkIxeTgraTA1R2lxaEFGYnlpNE1CV3BCN1EyN1g5MWFud1JscjFRdGZUYlUr?=
 =?utf-8?B?MnZLdWdZTVlsM1ozNWpkZFFVUC9xOUVLbzdWengvbTcyVnc2Q0krMzdVZElk?=
 =?utf-8?B?b1QyYi94V2ZiRlNJamdicHNSN1BaRjYxZjZvem9ZSy8wc20yOW15emtXTktk?=
 =?utf-8?B?QklNVlhueEszRkZObUxzb2tLZkwweGpkbVZyMlo5MUVrZ2FVTWRWYXA1NFk5?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38630ba2-1caf-4dba-ee99-08dc1b74ea74
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 18:06:54.4799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /XwluZQ/WFa0CDuBfsMr0sS2vdOWF4fcrgQ8bBVrICuOR+pef7rn6bgi14sH2UfmHpc+cyXRkq0XugAXQm8MSSKRcG8Fy6JyNCiPwcJ1cPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8013
X-OriginatorOrg: intel.com

Hi Shuah,

Could you please consider Ilpo's resctrl selftest enhancements [1]
for inclusion into kselftest's "next" branch in preparation for the
next merge window?

Thank you very much.

Reinette

[1] https://lore.kernel.org/lkml/20231215150515.36983-1-ilpo.jarvinen@linux.intel.com/

