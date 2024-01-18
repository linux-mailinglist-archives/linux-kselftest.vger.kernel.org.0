Return-Path: <linux-kselftest+bounces-3214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0143831E3C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 18:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540F41F21212
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 17:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349CE2C6B8;
	Thu, 18 Jan 2024 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gyM+z7QN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0FE2C841;
	Thu, 18 Jan 2024 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705598162; cv=fail; b=g1jOZypf7Rn+76r1Tk5OOsQ3o+qPdFGIRQhW+pQVF4nFhx4YY4xqa7PSwXFrYboN+ZQt6+sYIHYP7jKN3ou8RFdvr3NgLi4ROLDlKpYibkWsKDkqn003Py1Y2xC8ErWGjSL3qkIz4eiPGRWkz5rL12t9gU7SLhx1zJD/17LuPzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705598162; c=relaxed/simple;
	bh=MzFYNRVULohTb95ypoBtG5EZHhWMvpuNbSvQPdlET+0=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 Message-ID:Date:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=iVLKhZCACL9iDcX7M/WLUkk3S5SbiwzRfxocRzX4Ur20tEChRCn6Tjzc1oGQQRwBap7ti2vxUDP0M16x2cOI2Vc1fSkXT/c7bxAb0Yas0dJwofHyluC7IsLavP92ZCJKU3iBGY819vzpOjnA0ysBkeVKxbAou9gwZpq4gt1aleU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gyM+z7QN; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705598161; x=1737134161;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MzFYNRVULohTb95ypoBtG5EZHhWMvpuNbSvQPdlET+0=;
  b=gyM+z7QNn5mbVGF0h7SYHvRjZyQSktLalp+cBiN+wZC8jswYaoJVaNUU
   iKRZxTd/YuSxYTpRk34PSrzrWordNpJqZdLC47qisaWEpnGmT0hHGBPYi
   XD14zKQh+z0uYF3VaMnOPJ+ybuUmzcR1kY9BhqJCMzHKz/kUUcBO8HvnW
   QljddfHRLFCXf+tA9/iv8466IapBQCyIDkH9WR+1cIPBZLAsttIEyP46B
   DmjwoBay+KszOwfUY+2dN4y+LDRJVRA69zmstC4PCr/CvtQm5WkM/zVoK
   QwxxNxgl6HD5lNwwS/Jf3pxmCKbJQw4Im8/uTZ11c65IBENTGvfcnQrxf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="414523"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="414523"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 09:15:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="760911972"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="760911972"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jan 2024 09:15:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 09:15:49 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 09:15:49 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 09:15:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7hTbT9VU0v1W+HNcyCynPZRlTLeKVuhS5UggJImSYn/sEiGrS0Sx+EcgIIN2SJNlwktHodwGc6DDLJBO2aQpwTzu6Y6pmj1M2SHIrDG2Wv2eafHey3nw+ZMYprCX9KUXliIxuOI5qQ4lMe7bd8wv5AF423pRtXEr+5edSVvBHVUSa82AEQ1UDHqKBTuEMNpn9ql1JWXMNe1vH/1TBG4P6hhz4Wym5nzYL12gFj1cKJZ8r8AG74aUk/O54y2AuTObLE0plDPv4E/4b7ckfkommMWiD7Mio+/uuO8PYjwomvD/QNz7YA9izZtomUK9dpO6U3ftuK5S7Sbapx4pOhkAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1FL9Ia27qBD2MHIXKwnqRN6lbmQdD4XVcTKu/d9R+E=;
 b=IzbjibrP9e6bo0YZKMt2yRuk/ikfBrmMBBHIs7aWlj2FIeevMOEeSAlbfLYDFtzwHxb6GDZ0I72HIPIee5xLIOJ+xR7cGbBxZQaBUa5PhqtzIdQ2NYW4yhIDPrP+sVfhcgU1noyO207HmAkb9i14HE9t3M/b7FaG9UGUUzc9qJAhBRW3/2iwpBcAth/VgiyysmU+zATbJKbRetKM4ZneQtMnW1PkQf3wokKHH3N3enkLbyaG8UkOSc8+xZE5N2itg/z7gTgRLUVPMg2rSbH2lvnlWNVUIB8cMnnd1uq4GyjszFMWWxlU7vMZlv1xaB57BabbcW9S9HVSysR+E4jNCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB8422.namprd11.prod.outlook.com (2603:10b6:a03:542::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 17:15:48 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7181.018; Thu, 18 Jan 2024
 17:15:48 +0000
Message-ID: <05db3bdc-9d54-44d2-8aae-07d66053892e@intel.com>
Date: Thu, 18 Jan 2024 09:15:46 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] selftests/resctrl: Add non-contiguous CBMs CAT
 test
Content-Language: en-US
To: =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <cover.1702392177.git.maciej.wieczor-retman@intel.com>
 <10c3afd7f62c63db31a3d4af86529144a5d7bbf9.1702392177.git.maciej.wieczor-retman@intel.com>
 <fd6acf6a-2610-406b-b363-220121a45aee@intel.com>
 <6v4hgra7bd5nwubcgtbsidmoohrgxdw7no4faa4a54g4vrxo63@c6qnujvwn5ej>
 <73cea732-3757-4aec-a39c-4f0e50f6fb70@intel.com>
 <su2d6i22icynusoykmowfnzery6hlqugovaw4xcrhb7r3ymbx2@aeimvrxsc5xw>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <su2d6i22icynusoykmowfnzery6hlqugovaw4xcrhb7r3ymbx2@aeimvrxsc5xw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:303:8c::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 189e5456-38ff-4992-caee-08dc18491d08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iuLOGtJp1TP9G9DVuatMSCzNTXSBQUokQnfoXZo8LJpYcmRYZFh8rVlkCTBx9Eec+yI/aJ/CZvTm9Y2aPl2+//2UwpO4A+FeqNdZnk+ZRoCa3kGg+36n0RI4vxfuZuBQ5FUQg6n74sLEIznLpaL8buDNbvUzlWRaMHPw2QIHxAblTgeGl465fTMFi0BAMFuu40NrPWB077NnINq5Zlmi2My0Tgs4iCIf3lkTFAlJhsLJCSeNZ3KDnrAi8vNGauGd3D+js2FDrPSE1zn2059BHpg+5ecC29EG9NFRYtqG9H6Fv3AwTyVAnhYjxQkxMUFjsnhWyXbenUfL6EUSwy2RSsfKFLVb5vFnzgV3qdAMh/s42W/XXIaN0sKrFJi6GgrcJ6/lKIXpY0jl7HeFyyB2TMDbYz+08bAN0BNWrbAW745WcK+iAPwXOknLLz2N2toe1LIAVyX7SmavoPfBubjHvWE1l82jM4g5wNz+n1pYEPGK4We6pf1Wp5xKJGCmwNagmAcZ2Q2N9jRvLbY/ljioNZeLwse+SEKBWRtWgfu2OhsC06CCeJL02xfIn4eG64P4xfLurEFOEMQkbYiuiu+vQns/kW+avSp3T7ApOrhrXTp4cH2g7aWfs200SVOeGdFDunObwGoKs4jb6EswPSgEAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(136003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(8936002)(8676002)(53546011)(6506007)(6862004)(4326008)(41300700001)(26005)(36756003)(5660300002)(2616005)(38100700002)(2906002)(31696002)(66574015)(83380400001)(82960400001)(86362001)(6512007)(44832011)(66476007)(37006003)(316002)(54906003)(6636002)(6486002)(66556008)(66946007)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2FCd0RrMkw0TzhYTlRGZmQyYyswQWtBcnQ1NkRBUlltSGQ4SzY4Z2VkRWJD?=
 =?utf-8?B?T005NklxMWxra3ZodXhvU3RBUzNOR2VxUlRXTnJERjQ3VDJEVjVydEY2L0hU?=
 =?utf-8?B?RUZXc3A1RlcwVjNTOU10czRDTm1HbWsrSERldlVPUzJONVkyRG5NWjluOFdl?=
 =?utf-8?B?Nm03TUhOdWlSYm43MEdNc0NYQkNtWFNMSTFUK1ZkLzJYSmtuclIxMHpmRE9q?=
 =?utf-8?B?UWNROVdIN2dxS0NYK0puTXc5Q3FJZVU0R0N1VFVhK2p4aW5PRUZjUUxPZkw0?=
 =?utf-8?B?Sy9ZR1dqWUIxZFo2c0IzZEt0MEhrM0EzQWVrcVRIM0Y0WFRXUk9mTVlvQldR?=
 =?utf-8?B?NGNQV1FNRkZLUDRTY01hWHlNMk9Kd2ZJbFFHcXFtZTUrb2V4cHRIMUtORHhs?=
 =?utf-8?B?a3JNd0E0OWVkNjZydm9Sby9Rb0dpRTdMVGNFWUZ5ZHRJb0k2dnlCcUJEdG9D?=
 =?utf-8?B?RVpyV3Y5NERGWDBQenU2Nm9ROHlqWU9NbkJ5RnNoTVdJdHFEbFNDcGNKS0d1?=
 =?utf-8?B?VW1oMSsrbks2VnJKL1JpZDRpNGYwK3Q0NDQ5S1J4N2dXQ2pOekJFOEtqaTFQ?=
 =?utf-8?B?OGltTlhtWDNzVTEvcWQzZlpISktvZGFkZXVHOHBHZG1scWJrSEdQTDVoeStS?=
 =?utf-8?B?d01EemhhOXJnTGxJaXVIaGo5Y3hzejROVXBTRjdVN216RlBvTWFoNE93dEVi?=
 =?utf-8?B?dXRyYjBNbXFCdFNXUTg2QWJiYU9pRU51VGYrK2FFOHZKdjlsTXhLNUJTRGlD?=
 =?utf-8?B?enhnYXJnTFg2bnNQbjYzckVLZFVkcmZJRHc4SkE5TWdZTjRlU1lrc3RTY2Rl?=
 =?utf-8?B?Wkh5WjhxTWtPdkZ0b1VobjM5blZhL1gvRTVWOHJwVWtTUVU0WEs5WG1IT0xH?=
 =?utf-8?B?TDJYci91MDhvU1NYYXBiNSsyS3h3aEJud2I4WVBtdDI5eGJMM2NZNmZuUnN2?=
 =?utf-8?B?UE9PaTN5cVRDMHFYbStyc1BRU3RZUzVVa3JlR3ZXQm1kb1NnL2JPQlNlSDJy?=
 =?utf-8?B?QlNBT3ZWa0tOK3RvMnhWSUFMSjdSb1hpZEplU1hLMDZTbExZeFNCVHVVVEpZ?=
 =?utf-8?B?VHYvU0NPcDhLK1pTMVJUYnFYaXRNZy9MWTd1bWl0ZVVQcGh6SGxHOVpIOEM3?=
 =?utf-8?B?d1dxVkxtSDNlZnZyaHZaK0NTc0JTeVBLUVVvajhSeVdKam9nOXQ1TEtmdlM0?=
 =?utf-8?B?TzJ1QnJPZXl4aCtIZWZmUlgySG5ENjJRVk5jaWxXY0w0WUswWTFvR2l3dW1M?=
 =?utf-8?B?aG8rWVNSLzV0TmFOTW0rR3RJYlozeEhmNDBPL2EwM2x0MnhXZVFUczAwU1Ji?=
 =?utf-8?B?YUlzdVcwNHhMTHo3R29uK3M5MnZGVFIyRXpvM1U3dDNlQVFQKzVpU0lIUVVS?=
 =?utf-8?B?Q0FTenpWMFZjRFBlWFhaTDdJaWJ3eXRtaTNFaldhVS9sc0VvNVZ0akRhUzYx?=
 =?utf-8?B?SHZpVThmcnVZcTZBUjYvWHdtSEloUUtVRExpNEd2NUFaYXZuVDNmYUU0d0Q4?=
 =?utf-8?B?dW1qbUxUa0o5TEg5UjdkUzNMa0xUNGRMQlFMZWFqQ21JTkNYSXFKM2doTUxR?=
 =?utf-8?B?MkRTZDBBT2JEVHpvc1ZhU0wyZ0pDcHRIc1JXd3ZqZXArZjZuUytVZ2pyOXkx?=
 =?utf-8?B?OCtabFFuZGFGck1NVE82RjBUK20vZG1Na0J5VUtCRVUzeTZZaHE2Q0xKY3ZS?=
 =?utf-8?B?MUFkSnVlZXFDWGdEdjdiakxDZXA3UzZqdEkzVWZFOEdIVHlFTVd5WG9QWXpw?=
 =?utf-8?B?bWFSN2ZvTDBicm05YjJhV3BWZi90Yjl1SFNZdDQybDduamhvTjN2bU5wdStC?=
 =?utf-8?B?NFhmWUVQZjZZeWMrR3U0K3N4WWZWaDlRVVRvV29uMHBQYlFOTGg3WFRTVTQw?=
 =?utf-8?B?aXhncVNSRHkzdWsxOXBTb2doU1JtUVpTUTdGRlk5K0lOZ2ZOcFVRQkVCbzN0?=
 =?utf-8?B?ZXJTY1M1Y3pqcHJMdml0UmcwbXFDSUUzWHZxeE0xOWlObzFXQlVjMW1EZXNx?=
 =?utf-8?B?UkRSS2hHVTNYUFRRZDJ2dTdpczZoN2lFNi9zd1IvSGx0Q1d0cU5yOWxMdmdJ?=
 =?utf-8?B?N3p4dTdYQ1J4eDlZSUY2YTIwSy9BT24zNXpHNkhOU2o1MzNhdTdEdDB5MFJw?=
 =?utf-8?B?YjVtUkV4SytuMXFJS2kyaXV4eElpa1RZMlRqOVo5aG8yenQ0MExkKzR0MGFq?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 189e5456-38ff-4992-caee-08dc18491d08
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 17:15:47.9930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZB8s05D4CG7C+JW2wWJoT2mHofQyM5cxbKcziMrUEskYfMFnIMjyvdXxs/MUZ8Na4nVq0avHX/vkFE3F2QKS6rr05bIorXC/xVDoawrhRko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8422
X-OriginatorOrg: intel.com

Hi Maciej,

On 1/18/2024 4:02 AM, Maciej Wieczór-Retman wrote:
> On 2024-01-17 at 10:49:06 -0800, Reinette Chatre wrote:
>> On 1/17/2024 12:26 AM, Maciej Wieczór-Retman wrote:
>>> On 2024-01-08 at 14:42:11 -0800, Reinette Chatre wrote:
>>>> On 12/12/2023 6:52 AM, Maciej Wieczor-Retman wrote:

>>>>> +	bit_center = count_bits(full_cache_mask) / 2;
>>>>> +	cont_mask = full_cache_mask >> bit_center;
>>>>> +
>>>>> +	/* Contiguous mask write check. */
>>>>> +	snprintf(schemata, sizeof(schemata), "%lx", cont_mask);
>>>>> +	ret = write_schemata("", schemata, uparams->cpu, test->resource);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>
>>>> How will user know what failed? I am seeing this single test exercise a few scenarios
>>>> and it is not obvious to me if the issue will be clear if this test,
>>>> noncont_cat_run_test(), fails.
>>>
>>> write_schemata() either succeeds with '0' or errors out with a negative value. If
>>> the contiguous mask write fails, write_schemata should print out what was wrong
>>> and I believe that the test will report an error rather than failure.
>>
>> Right. I am trying to understand whether the user will be able to decipher what failed
>> in case there is an error. Seems like in this case the user is expected to look at the
>> source code of the test to understand what the test was trying to do at the time it
>> encountered the failure. In this case user may be "lucky" that this test only has
>> one write_schemata() call _not_ followed by a ksft_print_msg() so user can use that
>> reasoning to figure out which write_schemata() failed to further dig what test was
>> trying to do. 
> 
> When a write_schemata() is executed the string that is being written gets
> printed. If there are multiple calls in a single tests and one fails I'd imagine
> it would be easy for the user to figure out which one failed.

It would be easy for the user the figure out if (a) it is obvious to the user
what schema a particular write_schema() call attempted to write and (b) all the
write_schema() calls attempt to write different schema.

> On a side note I'm not sure if that's true but I'm getting a feeling that the
> harder errors (not just test failures) are more of a clue for developers working
> on the tests. Would you agree that it seems like users probably won't see
> write_schemata() fail here (if the test execution managed to get to this point
> without erroring out due to bad parameters or kernel compiled without required
> options)?

I do agree that users probably won't see such failures. I do not think these
errors are clues to developers working on the tests though, but instead clues
to resctrl developers or kernel development CI systems.

Reinette


