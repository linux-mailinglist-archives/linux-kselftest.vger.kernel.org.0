Return-Path: <linux-kselftest+bounces-43213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA1BBDFA46
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 18:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1792C19C69F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 16:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC9D3375D6;
	Wed, 15 Oct 2025 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cV0GYCZY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D9E1B3937;
	Wed, 15 Oct 2025 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760545542; cv=fail; b=tU1OOQkFnsrkXyrzL5EuarjsxPILJH5hJJUOnq/x3vNIyi020SA356LH+sK7JI2YUvI3ncuvLEMI1ZZ9CMgiydqbIV7F8ZFxFVcxgWlDDNr5FLhX5ZbrcR2mjcHDce1CMZWK7+iRs41PS4L6/OzOFQE9jGa5rs4ubHh7XRC3Yo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760545542; c=relaxed/simple;
	bh=mUj0cv+SlfXf2Jm/I239s1PYmjEY4ngxHN9bUQ+w7Hw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PjlcMBtNtEA720FIpQdwTOGr4WGYqaPhpJFGOPBpvWQjZgh4AHt1retRCtjm9yj0wxPh80mqs2uiUyxc3UbhV3AXSYGlN5+Ndw+kJfSCiYfFuGijanbMQsEwejgFN7PGvl0TA/XnT+61EYdaF0i5v2DzOFW/SGh3p3NfqVo2UeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cV0GYCZY; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760545540; x=1792081540;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mUj0cv+SlfXf2Jm/I239s1PYmjEY4ngxHN9bUQ+w7Hw=;
  b=cV0GYCZYfW5y7CAoo93ZbhLYK9X+wzc9n66R0dyp4ntr4EavpzOORDsk
   Nz8KM4Wv6vezUfn4Aj9SfqlFzfU12VDig2ShXmdR697FRuZeEK9bkvxvu
   0aGhsbhWjbA4tiArw1FZW0Erq1xggHohbn8Di4Qz8zvJIuhs50Jb1UnS0
   UzK7T3hSSDIsMn2iS/WEbpe74z7kniyP+ubZnVyi/TR1UBJ3SJgFg5FRe
   r/hIwlPYMaK4M4RK+cchLZfttncNrlHIcAurNqUFsLrnURpKpKidjnXo4
   kvsmUc0gtomreQyP3fVRICaYFo6PMWin/yQOgq3LyMechD92GH79DFYxi
   A==;
X-CSE-ConnectionGUID: HUt7EawPTMyWTC30r48dlg==
X-CSE-MsgGUID: ecejT9FgT6GXWADOblPzew==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="73327175"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="73327175"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 09:25:40 -0700
X-CSE-ConnectionGUID: 26k3kR21QLeYGzOmuhWMig==
X-CSE-MsgGUID: ZeI/hWMjSpSx0aZOUDRUpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="186232697"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 09:25:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 09:25:38 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 09:25:38 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.0) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 09:25:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqxf+vA1wh6ozaXgtJK2GtQhDZhY4w7NtappDNQpIG5//cT+3aLxadOPizZo1AW3uxIkzkT20gMwlsqYTwzXUJ3JxuuSCk5GvGoPhVYzfakCI9uibfhReesQtoFVYXXQ6kyb07RRbZw9Uaf9JzCnglRo4UM552YLWx+CUMIgZ6y74U5gCkvwgFDfDQzk9H9zXC6UGG2i+AyikXq6fgzPgQhDHNFfnL0bU4dKecnohY3LQsZgDXmgjjEn2q7XWl8o2zCkv17aD1JbVT+gg7eN2E18UYoWlzFuX3yT2Pc35g+meaBaFISxkAr/wReeWL/dSyndk6VM0EihRlTlgP/mIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKv5ixoz8F8WgyNpIpbbEGKfIj29NdpTg8WeJvi4Jws=;
 b=yJghLu0Md1hIhpKV0P4HejUbYbk6VcZtkDWOKe8CzlvvrX+C0FI/kA09yNYS+7CkT/WBtCFJZgu9s+UCnAS+X7P7NEpMC1HMLyiIoGbfJz/KDKa5l1qbHx7iA0/cwashWNibtD1B1xApnv11drcFWREVom/zIUesKpPwrhcJFaiLn2hT5i2fWtLVR5Y5OyIU/62lY83kOa4cDDce+IUeZd9FrTEr66zUAB32YR2o/zu82sQyUIQLJyT++9YJ2thTTXKkpPDU+hfVZcmVT7mbjVkLKFijpzfNR9Yv8Om21o14GOWWtG87V2c7CJ9PLA+NHnyWVoD0dFT8AS3JiPR/Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by DS0PR11MB7972.namprd11.prod.outlook.com
 (2603:10b6:8:124::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 16:25:34 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%7]) with mapi id 15.20.9228.012; Wed, 15 Oct 2025
 16:25:34 +0000
Date: Wed, 15 Oct 2025 11:27:42 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas
	<erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Roger
 Wang" <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Oliver
 Upton" <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, Chenyi Qiang
	<chenyi.qiang@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v11 13/21] KVM: selftests: Add helpers to init TDX memory
 and finalize VM
Message-ID: <68efcb7ee33e5_cab031002e@iweiny-mobl.notmuch>
References: <20250925172851.606193-1-sagis@google.com>
 <20250925172851.606193-14-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250925172851.606193-14-sagis@google.com>
X-ClientProxiedBy: SJ0PR13CA0143.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::28) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|DS0PR11MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: bd0e4298-691e-467e-963f-08de0c077779
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3jVbdeFaiiYJK655oiirA8iHJE64dlWs4bmaNQ2hTERaqMOkAr02+AeDtX7Y?=
 =?us-ascii?Q?Sulpo1FQwP5cveUaXfs/M4Iodz7bqaG8jZmjSuCjGQ+tPRdxLTALr+JZ8sbI?=
 =?us-ascii?Q?L10uRHERJY9BUsu1jtA0ilXM/t3I9rkSg827x1bBZ0h3NzaHDOBM80HdJn7b?=
 =?us-ascii?Q?8VEsXNyFUmoRgeF6rI6PADQMK2ZzUjwvDLYWvqSxz5BfZQ07lxJVhj/CPLcE?=
 =?us-ascii?Q?+5CSvWLBhL2HR8USryyNC0nq+q5o3GUOvhxf/QOzRxcD5eQG151t03SrjMt+?=
 =?us-ascii?Q?rOvYI+L71qgzRESYAJmD84Mw0LlqJnf0uofGFRk6qivK1KCjZkJJyFlNPnA6?=
 =?us-ascii?Q?IEKGADpTusdQAKQZfw0XFgb3rCvkJpLjE5QajrCsJaqCupg6/YMO/88gP6ZB?=
 =?us-ascii?Q?rVTPzDqOgfOcvkSJOLk0NARmoGwYE5pEqrA+AbVTA9GcWdZ+AFmm4/hw0bWK?=
 =?us-ascii?Q?5ruWX/yfa6lzQa1skSXy6TAGRS5g6SNcYUoKNwyZVGwGC0lZh5lINnpupHwX?=
 =?us-ascii?Q?M45W0mjG5Y2B2Tqx4rsnTIGL+C7O0gtP0eQkFSnIk1yOCHvDfo/6U0uj9iYI?=
 =?us-ascii?Q?G5L3RXygICFmPa0ayQfGLZ5B7rcxH5RgUd/mFaFMsGM3yWXX4A1O1ehLveTa?=
 =?us-ascii?Q?YSz1JGM9gHyub3UqYGAKQ9j8ejYuEHzUI3m259azdBUTgsiSjJSLXp/pZVhl?=
 =?us-ascii?Q?MwpWgBWlbT9t3kDaC3eP8c6Ddktj+0+KbfcD1xn0bndnovPjJOVtyPxK7edR?=
 =?us-ascii?Q?+teQ+2ckt3EgKRDcM+eahFgd1pb2d3XbBQCFcelUpDNBWg+NI8RvwKk+6fnp?=
 =?us-ascii?Q?QejyvINFL9rKxN4zTsdmnMudy9USwES3c057sfi0bgyAxQVf9n4gWieUF1gw?=
 =?us-ascii?Q?6SG4BNJCarqMf07TJlDMZYv9bBykHpvo/S0gFUN/fi3cGfM8F9m84tntrO5G?=
 =?us-ascii?Q?H+pJZ83CQTRLEl1sC/eQBtvV1/shnIvGNci+/4xvG5HbDbiKdRJ439Aa4gmS?=
 =?us-ascii?Q?SQC/fKeTeAglhw01KHRXK94LZZEdYGxQseCGDK8lVJqDx0Egcsi4rTcKb054?=
 =?us-ascii?Q?6/Kxynk4phkYDiA7RH89QoCC4+a/q6iu1TJll6A1NdxOAh/iP1bMpUBTzI49?=
 =?us-ascii?Q?QMUcx69qakfnDfIQQritfFTZMXwuS9pD90LoRqUCkexmGnMHLkEwNIJOkIHR?=
 =?us-ascii?Q?3qgbMIqh+5brH6dyLPgY1Y+crwCtTnuuzCXKrvhHZ5sZZpYZdOap5Idu3azP?=
 =?us-ascii?Q?cS51fw0yEyXiYMUW/e/KD03OF1Mbw0U3inwyxBhFl9JsQjxGNBLF/B8jqQHk?=
 =?us-ascii?Q?+oGBmbgHdIVloVI639YgYrnhIV0l6FASJ/S1uuCLuE7QiRfPhqc0g0RAqVfU?=
 =?us-ascii?Q?OC6Qv6Gb+t57+MGUh+gx6n9vzIqIlUphaTdkZDdB6VPM+yHSpZVDNFCu848V?=
 =?us-ascii?Q?YP7DyYzG+UIforYPp6rajHHsfwfIugKX2UewZrSa4mIQfLk+qkotf39y2qZP?=
 =?us-ascii?Q?/DHmAtbCF5TvW24=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T4VjVstGqBzGa0NqoZKeHkVqz+IWaEzswMNM9nxF/b3YYrII5z+BQjXxf3Q6?=
 =?us-ascii?Q?nYvZgfavU1fvk18/T2JVJYbkIAjLaB3MNy7c7DXH39V78FeAKhZARUCrGQOZ?=
 =?us-ascii?Q?4e8oahPwVxO9roagpvEInQz10I9u/T2fbFBiY19CpYQIdKqElmWSNG3XKJQr?=
 =?us-ascii?Q?Y6duODINlNNsMpmA4uWz8XjNTHmmOdhbVpKY4idfsWtIf6ih1j2KODyBPzg6?=
 =?us-ascii?Q?FxVFikQpeJDa24wU24brP5DQy8RbuQ8GI2gKbRDSXp4+KSLyhyiq0vXVx6kf?=
 =?us-ascii?Q?xNJ14oXZ+ytAbIUvtwwGJUKTtFTYvqa/E255YiqDfb67t9Knk5uhnCHj6dx1?=
 =?us-ascii?Q?6tKRpbXsVzvl98td/S9Ont5cutEwEcRJyMUOD2zWEnBTo5VPqGN9UKhOYUTB?=
 =?us-ascii?Q?M0qaaoHaDQ2b6FkEEdM7wa2Ko0oPLW08iimHN+d2KoeNuiN71edcVeLS+PDx?=
 =?us-ascii?Q?euR5+N85KfdD43LlOJ5cZmWp2SlRUT9o12kUQs012yboqKPU5kqcf3UoDDi2?=
 =?us-ascii?Q?6VRfbb0BX5QkSsxJP25/S6ff1sfVCLGMBmYMayLrdV8KaHRorTwCAnx+U4lJ?=
 =?us-ascii?Q?kwXXgKqdU1B2Y5uQ3ErRAEUMDWSzA6VLtS+O2CVgcp+NWGA97tIZltDrlwJx?=
 =?us-ascii?Q?e7k/NBA+M6SIyDdorKetoeFdpMA653iEWpxmpZ2JQsysiwtv2LJX4uFeGA/4?=
 =?us-ascii?Q?sKctC98XIZGTQhTWS/uJsJGqTqJ9Opqmu2RzQrnZia3XAojFDtQ+BSfNGudD?=
 =?us-ascii?Q?7heVCjb6UQ4BAFEsy0BinqtjH17NSdJF/Zs6ujWzaqpS8lp55sYLS2tQs7xN?=
 =?us-ascii?Q?AnEhwk+2MQpY8O4pcfnqIQUwPW8OlonmVE7P4qn+rXKIviljyxwEd0sD7gfZ?=
 =?us-ascii?Q?XFv3DHcF0Y3E11XAB+bKaM+0ClfTb0M63ro5UjOwvFB1v5kDOUe2d51UXlP2?=
 =?us-ascii?Q?/In0iPYrZ0X5LAMgi9sOLpG3FI0T7C34UrZZ3RErdBE/ww2Hoy2VsEqUK4EL?=
 =?us-ascii?Q?xCtlLtDHaWPTb6Jo3X4Gs3v0Clc6Ii7xprprndCJ/9OUY3BChYG+SnjQfdRP?=
 =?us-ascii?Q?42KusOq2guFrkXEa0LeyRmoxDRFtRagX5SBzAm7R7Mcue/OSCqt4zhTCOX/K?=
 =?us-ascii?Q?hXlwssTxoGh5Y2mnf43ZaVzfw+B0ITVltx4UV0SHyIa8eQE9zDXPNanUywtT?=
 =?us-ascii?Q?tYdsRaZgXbHZdMj0cJGyCF64FRhAMmB3uR4t/hWgz+1jgiG7FxYMcnIsj5Mo?=
 =?us-ascii?Q?5HtHjt/eBQPSTG+zTEF1J7wHbB0GsbhCeJGn1nZvsS1UNMhbKbZKssBKFXd8?=
 =?us-ascii?Q?ETJf7tfFSd70qeQmFmUxzY1+OMXmRk51zIIfAwkwXdoxpPJh0AZwudWyaTlb?=
 =?us-ascii?Q?ReqHRQ69lR58cAWF4MeD2KG4vG1Pa/fn6Rm3qjvF3K4RPX4wFRk3dlzjHiZx?=
 =?us-ascii?Q?llIyf4vW79tew+OabIgMq4rEOydqxsSQaXbByx8A457rT0AKTsmxorrZlJD1?=
 =?us-ascii?Q?nYRonU5eVSpuu9ragj7QcOvYVZbD9WU3+2XC7+Vec9WkZDPm/96w8Pu+Xk0B?=
 =?us-ascii?Q?X8pdXvRdOun63va3F/lA4ui2LF2f7uysd0wHhsCW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0e4298-691e-467e-963f-08de0c077779
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 16:25:34.4485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZHr4Wu1SG+TAi58EnXbJkZItQoR+Guw90o/W71FSKd03jEDGJLwjXiZ5n0oxSFZLz1E3gMHp7t2DEpPzfBzQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7972
X-OriginatorOrg: intel.com

Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 

[snip]

> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> index 2551b3eac8f8..53cfadeff8de 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -270,3 +270,61 @@ void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
>  
>  	free(init_vm);
>  }
> +

[snip]

> +
> +void vm_tdx_finalize(struct kvm_vm *vm)

Why is this not a new kvm_arch_vm_finalize_vcpu() call?

Ira

> +{
> +	load_td_private_memory(vm);
> +	vm_tdx_vm_ioctl(vm, KVM_TDX_FINALIZE_VM, 0, NULL);
> +}
> -- 
> 2.51.0.536.g15c5d4f767-goog
> 

