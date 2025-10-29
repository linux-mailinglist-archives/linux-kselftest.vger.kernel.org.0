Return-Path: <linux-kselftest+bounces-44303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D545EC1BE70
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 17:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D303804B66
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 15:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE5E343D6D;
	Wed, 29 Oct 2025 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPRoRqqX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8FC32E13A;
	Wed, 29 Oct 2025 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753168; cv=fail; b=FaXJgsTOuythBElqFk3oIk8x41Bb92lTvN9Yv3IBe7OcuWhnzqY+9tUpgiS3vCJFtsz51gie/8qsaDswHQd6q+DpgwSoabam3mVCgZ91e/jTQZJrlIlIeT0dnPXv3rHDBCIiQlDSCxfPUQ8GPtHgBcV3bs4nIo88MuAzsO41bAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753168; c=relaxed/simple;
	bh=TQp/E/JeGHldaZ9No/jtdUGmeFeo/kfPf03VP6zz86U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DE6nFPOZ7/w89vDSlhN065NHLPME9Zv82qL4Q3dE3A/OjqzTKPw9/WfqRcyeuIqzeKClRp2TrYB64cV2EVcUD3WiSHLZuVwc3XB2+qs0nLSw5HI6W+upkJcQC+R8LwVGhIe/mXzzA5CTzvDnoKMoCzjkV9y0n6tt3trPt9ZwLXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPRoRqqX; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761753167; x=1793289167;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TQp/E/JeGHldaZ9No/jtdUGmeFeo/kfPf03VP6zz86U=;
  b=hPRoRqqXqEFjJ2QRfq211eC8e8wPLf+FRUHgQ0DVPb8TvPOmozsAcdfG
   CGsi9xeTuNxO096a2WFEeKhxIHNkA0+KQnBJ25IOozahli/6vhUxz22jq
   VO89hB1VNljULKtc0VF61ToEYKOMcNR2zWvilYJeUEkMLTkG/DFw0XZRi
   55NO5cIFxrfdrIeFFxZPsuPt1V0S0AussooUJVgv9obyJbMC1IvlXVTeD
   iT+rQ5jYJ0WwS3IDF7Z1SZomZqHcsjqIUvokVdH8GAXMcEXSL0WA44KB0
   OAUh8uN1EERuX3hLHU1ZYWdyvwxjiI1IRfmfKdHfWCsEYColw5AyKqMRL
   A==;
X-CSE-ConnectionGUID: DzpBoBvxQ5KiDY8Ar4LOLA==
X-CSE-MsgGUID: nquXjQ3lTPCahtM143MFfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="74478276"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="74478276"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 08:52:46 -0700
X-CSE-ConnectionGUID: jPOTpCiXSeS/YiE+sR0wwA==
X-CSE-MsgGUID: 6PzYj3pMQ+2OYmoRWmJskQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="185399491"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 08:52:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 08:52:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 08:52:45 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.23) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 08:52:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAybflMOVLhB3z7MD2iHGX5haDw2OMdOf0dsmio0tdLLvwQ/wPn1rHJskkmdCYjf/Ey3VfHy7KHtEL8veJdQhLtfcluI+h4Z+m3Q+l0ZdyjhzWm/ra7DcfAW8RgVqjLnGHVgobnlEyoHBmwXW/Qp3B8XFrWUZ+eZzDuRETEWgj4ojV4ZhvnHZvuwFWHmjhedHmX4x5AT9EloW6/BX7xWVcUo2yZKb6H3mO3sFvtU7U8P/JMROl83QuXI5eMJsuBjmTC1Gjsu7BS4E86HvjJ1QQsLvfcThfzUOqdqIpM2Bo0JvhCd2L1lveaIzTBzE38Yng03f9RSeSUG/WqPpis6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f751dgpkeZHiRMcK+dst0ir0BLcT75CrRpQEGyhHqx8=;
 b=OcYDbzOp+txVZz31y0pG9dH0SDlffJ9jOn8VDoZ35zjjKADm7zQn38UHeXzkbL0M23dqsRJ4MYAZ9SpOFWycWFxv8fhl/wE22NNHqTUdH4v5IKQSms2ve8eKWQ2OVayS0mle2612N+N+vCRplHj45ifCIO/4ku7+9Zdv3bU7rmLt+U+EERuvzWsosha0OCApg6820fsijJo19gRnl5PEJk7X9NV8PWVbqI89TqJPLRhTKS0vItxcJWh3ujUwtrUo6YdnM/23UkeXHiTCCj+3vVqLjrhMGMETWMTdKPbTJRXH1Zfr3z91Sgr3cA79bmSYEQL0FP45tO5BeX7PP/Er0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by PH7PR11MB5887.namprd11.prod.outlook.com
 (2603:10b6:510:136::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 15:52:41 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 15:52:41 +0000
Date: Wed, 29 Oct 2025 10:55:02 -0500
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
Subject: Re: [PATCH v12 07/23] KVM: selftests: Add kbuild definitons
Message-ID: <690238d6cca30_20bb4110023@iweiny-mobl.notmuch>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-8-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251028212052.200523-8-sagis@google.com>
X-ClientProxiedBy: BYAPR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::39) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|PH7PR11MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b2e875-d8af-4a82-1202-08de17033169
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Co7MNfdydgw95oaBT4+HUp+jd92lSFxAUdEcaGPLFzlqvIcGsiyq4YWZb50p?=
 =?us-ascii?Q?YPA0m/3n3jFtXMYLGs46w+VJVUpg8cvwmn73WszLsmeFTOlP6cDD2sfbF464?=
 =?us-ascii?Q?34R+VbGJHry5uz+ihi1XUTRwxjFnTxzHUk8AqPxuRYKzWUSFHju1/tsmpt6k?=
 =?us-ascii?Q?X83ht6NoQvAmSDUXfwZzHJIMt2L+FhdYBYmzFUqBtzHA/jhY8m2dQHVNE3ha?=
 =?us-ascii?Q?qu9KUC9vKwUYJzxpeP9VF985djqYc2HOGDichokQ4cGZUnmHkI2EAXCJTGl2?=
 =?us-ascii?Q?stpCtIf14stymXSJL3Mu0+vGeFWRwvjZsfc6R83rk7ssCGycniIZOPrvL73S?=
 =?us-ascii?Q?87btLKkz8FvO4Ca0bezRND7eK8nqR7jo1+PlrjMEZ7kVmyU43944uTXSlNm+?=
 =?us-ascii?Q?yHFatjysK3TcAEVVNSWc7LHw7V12HBDV+18ik81/gJLgUtMG/i0T+Ca+fCCx?=
 =?us-ascii?Q?QqiIEGvcYijlE7qtlMKe7BIQbwsFd3sW+bjr8t8flqgjrg4wTVt0OsA+g3se?=
 =?us-ascii?Q?zT5x19/o1xhx8TsyOfnXFr8sJN1d7Qd5CSHDMmzWHIaVABUETNy1Ffpx73QU?=
 =?us-ascii?Q?AuQri2TeF56EfCIHfeyYfN0cbLSvy9AmfveTKPs858I6kEcmVz/dGpePaSJE?=
 =?us-ascii?Q?UkKmVJbgyjD9OrohsrOBYNdz/3myuPl/jN9Stxd/PSrMghHJpK4FYVxqCN4a?=
 =?us-ascii?Q?wJIuREF5Q0zQAEI32Z55QwaP5qSjaJmpBQCyorAo1uICuAelqtcXq/gIbqVj?=
 =?us-ascii?Q?KWnIsHCdpVKmewBU+1qYDsTbSoLVDpOuT6LKn0CjAsWzgTAdoTR0EF8+K+fI?=
 =?us-ascii?Q?30YTe+Y7VZOhk5kw85/lm5UAN31czpKIKIIT+voGDm7yyahyRQ7wlAXOgMnN?=
 =?us-ascii?Q?wG0Xwm3HCU6WrNP6pCjRQu01OVPN4BQ6KA3T0sL8U/CWrBIIY4ezdaYCA7aM?=
 =?us-ascii?Q?O3Kg30dUIodFRM8HpoSG5ObMrDKFUXILeMga4hej3AR7hvSETViPCITAsJcI?=
 =?us-ascii?Q?Mh/NxfhBivthErB9j5bMGo8RyHGjBDCWlkKrO+F4lorp9uk6lFsnj/aXcY/n?=
 =?us-ascii?Q?H3799p+kIULq9ew7imIG7tLIQXVhr+U8Nv31ZTzI90xhLC6rqGARW2qLAsaM?=
 =?us-ascii?Q?6Qi9yFKEXlhgYohBx3IRO3ZmM8ARBkm4cKy/1FXiYztibFJVw0E6loN1/t9+?=
 =?us-ascii?Q?fOVjQbZLC5uoSpO6IE1w8n0ZYGmwYEhF3Kv6gv6NjWQ4T1JZ64NNNbo0FJhp?=
 =?us-ascii?Q?TYd+Dtwpwu1cbM71nmDsAIJl6G5Q+pTydABf/AFuEaMCUVT6zlPYjH2vQAOF?=
 =?us-ascii?Q?sdu01xDEWDFlXxzxQO870KfSigEeujEh6gZmGn0sG4WW7pOl9QKbzXtR6zlq?=
 =?us-ascii?Q?aVfC3+xoCzX3F4sqAoboZsKZ3Xkwpy/zRFR9ZcurX439ozUn5TWk32KaD3L6?=
 =?us-ascii?Q?UrBBAUrEkVQFIMnqNKpYzWFMQES9ABxfTBpA7hNUcUC0ytpxmA5pgl7iEP/9?=
 =?us-ascii?Q?kucZczv8ZJKzVRs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u+Qzxr0KjPTD+hLqnISYExp8CGKUl6iCXUWAEx4cXKA//QwoOPuQQ2X7Um8x?=
 =?us-ascii?Q?qEIVQvwulwRFJp4fUV/YlRkxp7l5vSbKDu1GGLkl3v7D/e23TCYuykQXE9+P?=
 =?us-ascii?Q?Qt8QRqLODhtikF8SLx+/i76A07M987jdlkYG95Q+IXm1SUKxitcd+OqtzvLo?=
 =?us-ascii?Q?2L3WsR9GZK/edvhHfwMcxe9T+hhEtqhgE+Ls9ny7h6Qt9HBrPtJ99Wxq66J/?=
 =?us-ascii?Q?RtHeLVMhLvS6LsUkffDJZptgF3T+lzt2obiLJID7ocr10MYMOaOCwwcWOqKW?=
 =?us-ascii?Q?r6K7lYf5yudUnWZ+Ek3uXKfY4vB4bmV7itFc8jFJO7nNCLbZjK3rOXJCGQjy?=
 =?us-ascii?Q?6P+Z0OXxn5Bx6d0g9NqOo3eo5+w4fb+Dkb1TZ4Pms0RJ473k5QfHvKuBjtP4?=
 =?us-ascii?Q?aUYrP54TrkNHwwoUBmmBVcBh6qvHuJVRUn/KPv+51+9CPulQ5KkSHzUdjDXC?=
 =?us-ascii?Q?Aqqafm7xhn3wuR+S4Z3BCsO1n1t+21W3bUY6mmbtiWBuiD9atmCtNxKU1KkX?=
 =?us-ascii?Q?XBKSlEjXQEnkZ15CxPvBTyo/VH+yefrfumzQaNIHCP5yogCasBmrcjqdfsAO?=
 =?us-ascii?Q?fbol0uz53So4eA6mQ1Tq7cKjbCOTv9Pq1T3X17FLS5bPkor9rm9x5AydEMGE?=
 =?us-ascii?Q?H34YZsBCOYJuZbUIcUH2byL3Y+a8LXVq2AS/nCLb3h0UfIngaK1jSrZVewYz?=
 =?us-ascii?Q?/7GRpZDjzy1yPLwgwO7wIibWLVfcjjo8hz035AoocUOPq7zwvHBQMO+m3sXY?=
 =?us-ascii?Q?bUSCp/LcGdHFUVhXDWzr+fBTmj5wktYRShWxCGwA3mjDwjT7V8hsx8o/EgS5?=
 =?us-ascii?Q?t6z4oVhd2kw8UthmQLVk0ruZV8Ob0bEtsbkSt0V+ZnA7w+GDhVe9z0z0nLnp?=
 =?us-ascii?Q?olBv7pwFiS8hDxdrYsEhfXh2LU16gXThZMQMHFWnk1MJCMhnjmIRsmC6KHsD?=
 =?us-ascii?Q?KmloPXYAYS8LqiETpUS9G5HFvE8WO2xftCjxzDCqMeOT5pvEVrlrur2XTN/x?=
 =?us-ascii?Q?wTqPZuBg9qJyHOUISrRehzLJYvwHhmO9ejnDlSMwttMzXqxZPXu8N1SG3ey2?=
 =?us-ascii?Q?oWJ1jvqwrxP/y4fnNKX77cURVwpIUJ3po3MHk3FBsJAy5bijiP/R/G/LBPn1?=
 =?us-ascii?Q?5o5GjvTQF1RZRnitOtXt8hidCewffVaV+2IhSVKocMLAayEHTNNdWVCgzP7Z?=
 =?us-ascii?Q?szYzRCKreX7JTUaPCjsOouyLKupaYa1kBw8NSW4mkWZKvxnit4xdulqoG/Pt?=
 =?us-ascii?Q?AYruJDh8I2uNlAsRF2wAZuUMohHF1a1n0I/78QDx2PZyZdXKQMCQHCn3c8mB?=
 =?us-ascii?Q?3rlJJm8cZE9SXl7VvBdCujiWYv4jirzOwMye64ZJIv6QFGQuvgUPxakNvajR?=
 =?us-ascii?Q?iGLXgf17sWVj35axQPflarZWSq+XaU8Nw7vwzXeFGB+N0uRi/X8AuxcpdfPt?=
 =?us-ascii?Q?+eOUtkQRbHkgDm+11+gON4nQPHoWLqsKLRLX4Y7FAnLwTbb6fPnYcVcRvCnB?=
 =?us-ascii?Q?vN31sS6DucugUO2NZckrijDKV5SaG+vGoxv3Sk5kYGjcq7WXN4x0GxwNBDPZ?=
 =?us-ascii?Q?wotjMRg6SdpM4oJiWSQn8hCjaczCAgL1sbsrALtT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b2e875-d8af-4a82-1202-08de17033169
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:52:41.6488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Y+CkaDaUgLwcfDsdhBPjDHK4becBW1CQRORe12cRL+UDoDtPQj8niDrU+sxrNYuw2PB0IBdHgr3vFUL1Tt27Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5887
X-OriginatorOrg: intel.com

Sagi Shahar wrote:
> Add kbuild.h that can be used by files under tools/
> 
> Definitions are taken from the original definitions at
> include/linux/kbuild.h
> 
> This is needed to expose values from c code to assembly code.
> 
> Signed-off-by: Sagi Shahar <sagis@google.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

