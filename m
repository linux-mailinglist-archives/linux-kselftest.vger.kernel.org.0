Return-Path: <linux-kselftest+bounces-3145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 094CA830346
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 11:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A69D287EC1
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 10:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD5614280;
	Wed, 17 Jan 2024 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XQ1QSfd7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50672904;
	Wed, 17 Jan 2024 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705486186; cv=fail; b=K6yeX39HROUTu9M+nzmZn507PFJfnL9MCTqXrLqrs3x0WoSN+VZR63Ij3xRjNuaO+4JEsYdGww9U4Ba2BPxEkTqpyXYG/QNjqDK1DwnbDwXN+FSLzfnNzoyqgCkpsgIQ/dztUfRT/N8BgY9rYikp+Y+rPc75abSeesJ2MMUm0Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705486186; c=relaxed/simple;
	bh=BFTE0xktxBzG6Nl0Cvugp/fPxCHto0RSknsVF/TnDio=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:Received:
	 Received:Date:From:To:CC:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	b=na2X9crUtpJKB2NtOUc8nsG1so8JpzzP2lB0ig4JEl7EExnB2jvGXIhOAtvSK1ej+q6gtVDH2xVqxccLjVRu+4P98qG9cqHeuEaAbMK7dXQ/TQKiLdGmcEqsONTpZv0LzZwcGeOv8icr5vvPL98f+UNYS7Y50RD739MuAZUmd9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XQ1QSfd7; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705486184; x=1737022184;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=BFTE0xktxBzG6Nl0Cvugp/fPxCHto0RSknsVF/TnDio=;
  b=XQ1QSfd7VIGoRqmYSL7uwU4w4UNEA/UnIacCQb8AC+Nf3AIz95jUsYwW
   gHT1uCGhs+xeo7nzmxu9qzfT/AKZnFK41ec1D8i+fFbvoSbzLQS4Tea6F
   vtd/ZyJ7r7U4exUsz5gjQYOjmlpZcMruT7FObxwv6o5jD5BvotmnHtL6l
   lylVdpYGugg8D+3w1x0BIU4b32wq2X1udDi5SQN5ZPXu+OiDWxor5IHQa
   kbtzaKikdhE6ksUwJp1OZazHAT2h89juXipAcwdsYYFmlzod0yeEKkc4I
   nelwR3W8bEBa7Yzs28OvG9FIhYpRi2lieqkMYVt4ryTJO2hO6J/Mqf+MV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="403888786"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="403888786"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 02:09:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="907710590"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="907710590"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2024 02:09:44 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 02:09:43 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 02:09:42 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 02:09:42 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 02:09:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9jbm+887DOGq2wjoa1jdN7JXME/devd67AvBwkMgT7A3vjPc+/6Z6c2lQImhBVCupfVFR0vUYsap0ArMsZTMltXI3RigBLq9mt2TDBmbWla2pjVSdSlwspkM17z2f7fU1NeEcF9ubZ/2wjSrRkFjF1uW3NFYRd2EVhQA8UOZdYXBY45PyKky4o7UJea/QfanNDZ2h2Q7LNBxJkLGBYHn+o0DTV7qZ/wlhd5rK+oHsOlt6TALQggxDLtsNdXFl4do364AXZf/UMboC/qEuZBDWUaCf6MALdk5uMkFjrxICYmxTCG5SuolR4DN2Y0lnBHJlEKJrQ2rZe0AML4J4WHTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keUD9/2m99F89mcVFXAkPI71Swmarh1KyG6/rz/zJK8=;
 b=E+xRTGVIdJCDuj+Z91PbnGTmD4v5Les72G9oOOEbweDXl+JcLtVHGt0+s+qcEH8GFoAjslsNREzMWBMBQ0oOvMFgxb6rNAtesS99u4w9zgQAyAr1AtV2PquxTGDYGbylZEjW9NbFYhaDqoEP37WtMmv7NCao4ds0YlNFWbBqfnqfo0TRNVt33rfN3KPDygF6/vv6+jMbFwFuuqPNcpo4dIP0iMOKzxLVgUTQ+64MGXc9dByJFtV7Y5VG1bSXaYH/mwY8qUqhxnN+3dtLWoMPHao4xEmXiWQhtVWd/ysgZyFzlIxUCfuOw2mZx0gFIFEtF/g/DFFMvpRzY0aGYUlZ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CO6PR11MB5585.namprd11.prod.outlook.com (2603:10b6:5:356::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 10:09:35 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530%4]) with mapi id 15.20.7159.013; Wed, 17 Jan 2024
 10:09:34 +0000
Date: Wed, 17 Jan 2024 11:09:27 +0100
From: Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] selftests/resctrl: Add test groups and name L3
 CAT test L3_CAT
Message-ID: <bhqwsfql6zsjydavi2n7fqc2gd5xg6bssgkom6dabg5hzg46z6@aah7fdfsoynj>
References: <cover.1702392177.git.maciej.wieczor-retman@intel.com>
 <de2ea86256f0026989e6836f9e731be3667c7afe.1702392177.git.maciej.wieczor-retman@intel.com>
 <65e7aab3-ac50-442e-b559-00f2345c8a29@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65e7aab3-ac50-442e-b559-00f2345c8a29@intel.com>
X-ClientProxiedBy: FR2P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::17) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|CO6PR11MB5585:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c13e91-45b0-42c0-89bc-08dc174467c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IfIpdYahcOefTKmEONbi32I4JC8tc3xZO4wIVpK7+cUf1ZCgonUXawSe1rTEns3Qxp256Sg3XFw1NOAvA0z/HLTySItQtO+qDlwKpch84YiyCMJg91YcJSh81CtJ2xivDOqWDBb0AYhrnfPfePkROrwgldgNjwWg9lS+NRNwH8APULZqGbjWEopSK5r1IQurINKuefZRRPkwlKsMet/gKDuyTlL0tBgVXnHAsEW5zIGI+ccSAJwnT5DCv9pZSXvg1roleJa6SOroQoD0L+nEtBPRowQlV8diJdS8v8rCpZdZzaJ0XXOQDZIYZwIHJpdaefkR6Bt33bFzEy8Ndibngl0Dwu4jdGRFeFoc5oKgMp6ZQzAIVFdUG0qBPAOmtCWn5nKrzYpXwpqBVWFnnAhHfxUoQsdhuipvB5KaaXiWpQ0sv8olJyv36ElYBkkwQmioxjkTP8zfqrRzCsyD9pOmNAO1KkjzoPTdhUs6iW3sX7+e8TNUQHJL0q4qP0vnyyWaWNFAhFwyR8RqR0nln51/FxchV5EVzsBinjNcx+MEZ7WPtKFUpGAu3Z0yeCIh2YZd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(83380400001)(38100700002)(33716001)(82960400001)(41300700001)(8936002)(8676002)(6636002)(54906003)(66476007)(66556008)(66946007)(316002)(5660300002)(2906002)(4326008)(6862004)(6666004)(478600001)(6506007)(6512007)(9686003)(53546011)(6486002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?RxzQEhRb01UpOogcY5FdvOgSMIK0rHwYDGYa9/ARPz5eQPp0f4DayZtOYo?=
 =?iso-8859-1?Q?Rm/xTre4fukCEQUkk+/8949ij+qm0v+NRPqkNOhshlTGBSPuuT4At98a+g?=
 =?iso-8859-1?Q?p0C2FRgB9KZr92jKUEb8TMzJuJ5viXalLjGGCCnKLF/5wX+StUzEn31I3w?=
 =?iso-8859-1?Q?9SfKyWdyA3E9tBjw+tbVqrSnj8tutvCL3cM8SGQKP+2gtyrhVKqCvmRtdG?=
 =?iso-8859-1?Q?LJyRF4jjWyh63cCOvl9XFlmRNiOjE0SpAW+ZbsAhzk8NHyl9r+QQjg+vVn?=
 =?iso-8859-1?Q?kslRwfPaXm853QLvb4I+eD7gt9/jEigdINtV+WsVd3edDZgK6anmp0m9Q2?=
 =?iso-8859-1?Q?jnxJgHgn9BZfI32cUxvUxiP6CAyQQqCutYzAVYQ/r6D12TGE1rAQqmBicd?=
 =?iso-8859-1?Q?7kqJKirl/iSlvuffIbg6g2Lts+1TrfiSatBtkPi4Qhoaxjgk9EHvg8ypYU?=
 =?iso-8859-1?Q?misD3tXkphNMKVNbIBLsydIm4dTBdses913sV4r2og4pmZ8oQXImPZEfb2?=
 =?iso-8859-1?Q?H5uXxV9F3Daumcqnw9TmZZVPao59QbNVms0zgJpgyfAEtFC09J96d1g+2N?=
 =?iso-8859-1?Q?oOMCoT9tlnvA65XfghuozmQjOo5GT5xUJT7GwVElqqR6zUrYK79aJeWfrF?=
 =?iso-8859-1?Q?7F9/gRSKQtetWSmROU/8ilX+J03QiyQyW6hznCN4dy9S1E9uB4rGI4p48e?=
 =?iso-8859-1?Q?9dL9JA9YvmWOy7hbn4zrkiPEN+S6HGpl20jlgtdW6vL4X6BJH11EsEL73s?=
 =?iso-8859-1?Q?I6epFLxD10uzArpT685Dnuot1zFSVLnPJL6rvAizDGHsToQIX+T7/6r8r9?=
 =?iso-8859-1?Q?k7RnyebsVDdgenKR1qeG9neuRp1GK37Oc5WMgi38lHpv3/2Ylsb2DDUUE0?=
 =?iso-8859-1?Q?OrFVDQCzHSZsRVZZcT4v8JtJ4GXw0+6blJPiA+ZqDxBsktcNie9MtaJ4vh?=
 =?iso-8859-1?Q?fhfVu13ETCDR8F2HybO51YNToLaupMNe27nQEDZmzBkOivYlacZNHTcfJo?=
 =?iso-8859-1?Q?y/8F7peSp1sSG6j0em9X3M+h10khBbu7CdwC/paCbAdVJvpSRof7oKMiUa?=
 =?iso-8859-1?Q?92Gzrv5MkM7Gb4k6BMzYkljM8jr97t9iF3t5kqLu1Fqt+c2TABoAa6vFha?=
 =?iso-8859-1?Q?qB7oITemLhAjBeSNyD9emohMIeAtBrtez1pOd93LddhuUTSXuAUEbIvx8O?=
 =?iso-8859-1?Q?hqoFR5HXaRs0zF5JLZ7wPbg3yV75vnxV03kVPfz+hUgSs/Y/dLFwa6sWMp?=
 =?iso-8859-1?Q?XApQqtDdWXf9K1H//mL6pmf+o1z/kKsKuZgWYWSDhVtVzmeqTINAZvS80H?=
 =?iso-8859-1?Q?SYdXvR9CbjCfnEVgsQaPF+OzUZananN6YJ5ZKVgkvpkyRSGU+XEdyOKfKo?=
 =?iso-8859-1?Q?jWG8zoyFNTKFLSi8Z5XpkCmM4gAcUBBBhyYYuzhTbNUSqBXjcEb++tmy3K?=
 =?iso-8859-1?Q?H1odLUDOSHTs1jgJYs547ngB1KkRdfFdjJP/xTv/hZum4d5KJ1SwlYGW7R?=
 =?iso-8859-1?Q?XP68skdScwkXJ7Ve+pVYG3qXENQx2sdcf0qLl/Tr8umDtW76kNOzG4YDlP?=
 =?iso-8859-1?Q?TeiVf5Vj992GRG/122HS0x6l/NmJabaaS9yxzUmCWofy7QLf1wmQ9fNyuG?=
 =?iso-8859-1?Q?bzVMc9aMmMdOJO+K0p5B3BqnmxUlUYC9A6Axwvysq/ZzAEGUF8uIX82X+x?=
 =?iso-8859-1?Q?IUtHyK22IoZDYMPOcAU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c13e91-45b0-42c0-89bc-08dc174467c4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 10:09:34.8094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cllBDbjG2j+mcTImWxvkjEJ+FUX0wAdjCSTBVKewab6vO4Om+cMhMQj+FTYcdmFT2vJ1z3EThudE/ioI1Hcn6F8BLE0zbfwhKvFBC0SsjOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5585
X-OriginatorOrg: intel.com

Hi,

On 2024-01-08 at 14:31:50 -0800, Reinette Chatre wrote:
>Hi Maciej,
>
>On 12/12/2023 6:52 AM, Maciej Wieczor-Retman wrote:
>> From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> 
>> To select test to run -t parameter can be used. However, -t cat
>> currently maps to L3 CAT test which is confusing after more CAT related
>> tests are added.
>> 
>> Allow selecting tests as groups and call L3 CAT test "L3_CAT", "CAT"
>> group will enable all CAT related tests.
>> 
>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>> Changelog v2:
>> - Move this patch from Ilpo's series here (Ilpo).
>> 
>>  tools/testing/selftests/resctrl/cat_test.c      |  3 ++-
>>  tools/testing/selftests/resctrl/resctrl.h       |  2 ++
>>  tools/testing/selftests/resctrl/resctrl_tests.c | 16 +++++++++++-----
>>  3 files changed, 15 insertions(+), 6 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>> index 24af8310288a..39fc9303b8e8 100644
>> --- a/tools/testing/selftests/resctrl/cat_test.c
>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>> @@ -295,7 +295,8 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>>  }
>>  
>>  struct resctrl_test l3_cat_test = {
>> -	.name = "CAT",
>> +	.name = "L3_CAT",
>> +	.group = "CAT",
>>  	.resource = "L3",
>>  	.feature_check = test_resource_feature_check,
>>  	.run_test = cat_run_test,
>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
>> index c54efcf1412a..739e16d08a7b 100644
>> --- a/tools/testing/selftests/resctrl/resctrl.h
>> +++ b/tools/testing/selftests/resctrl/resctrl.h
>> @@ -65,6 +65,7 @@ struct user_params {
>>  /*
>>   * resctrl_test:	resctrl test definition
>>   * @name:		Test name
>> + * @group:		Test group (e.g., L2 and L3 CAT test belong to CAT group), can be NULL
>
>Could you please remove references to L2 CAT test that is not available yet? A
>detailed description of what a test group is will be helpful.

Sure, thanks for catching this!

>Reinette
>

-- 
Kind regards
Maciej Wieczór-Retman

