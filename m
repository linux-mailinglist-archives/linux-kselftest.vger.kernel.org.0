Return-Path: <linux-kselftest+bounces-24553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED89A11C66
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 09:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6C03A2C82
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 08:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002B123F295;
	Wed, 15 Jan 2025 08:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SAR0C//5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AFE1E7C28;
	Wed, 15 Jan 2025 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736930953; cv=fail; b=mQHH1NRLrFdXzRRYjA4+h2DOTgr/5hQ75b1/tqyg6WdiNiN8tK/scSQEFRLfCNyVTpntVNtljYXYtFmIBK3RqsNHRqH5sh8UUSwVBH3S9VxdUQlo9khUwzv9Yge/HgrUYWOx3KvQR3o0dqrf4ekQdwf9uIGHcgGw3vrHxSUvO/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736930953; c=relaxed/simple;
	bh=GN8j2ViWU+LsP4smt5RQBpRW980eqjowz26wU9DkZJU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eqDb0nma9NSsO5Tzm98UwEofvGFArcfHgnlvl79q5y0kRx91FzMwtwS9LP4fWQxAyq+uIrVenWZrqmRag2Hzozp9vRE3rpvutyMqVhDprXoGs0mtc5U6vT7peXrvsyYuSmn9tjiag27zaFMTGuRtc1uodGKhb4s2Ke3SM7T0ZBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SAR0C//5; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736930948; x=1768466948;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=GN8j2ViWU+LsP4smt5RQBpRW980eqjowz26wU9DkZJU=;
  b=SAR0C//5VpfNH/GxCiT98eOJszsbQqxgjlhG+VA4exx+gvWAPAk1AZZP
   POid+R6sWO6kQvNxyJBCH1UfYKdOyP6dKp2gMB9PgH9wRUOXXqcjo8cgs
   08KBs9ku8drg1EpoOxF9rBna8KJzdq2jdzyteUPeGlbnmrzC2lxI3lC1T
   Tb6snUEpd+JuQi3zntY3365E/BoqzlLkUWM/GZv3TDMzcAC1FymHYrgAz
   zVfV5yOVNDVNzPKOTSyt1X+2UvSYRoDVTKexabH36ng69bDoZslBkKjSE
   5Uxnxi1OCvnIXzWoyYdNEta2ZAim4aq3t9sCiUY+8YePzh89TETtWoR1u
   Q==;
X-CSE-ConnectionGUID: ykve3XrdRNmwgOV2pUxj5g==
X-CSE-MsgGUID: Enhbb/ddQH65unPdXE/b4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="47839640"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="47839640"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 00:49:03 -0800
X-CSE-ConnectionGUID: blFhQ6vVQUiT+EBNrIJQ9A==
X-CSE-MsgGUID: 1Lt5trMPQ32Pc+Jigi0q6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110203644"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2025 00:49:02 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 15 Jan 2025 00:49:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 15 Jan 2025 00:49:01 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 15 Jan 2025 00:49:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oglUhqZMovIFnSojpw6PQKqkN5+IwKS0mu9a6qZIWX5X4TJpHBX7LcmMhTcSvnWvwlGBfIkbmelfbCsZoWoeyOGtuTbpWCFXYZ3w41jdImR7peMkUhdUycrl9rfHFQ8v2wUu1MQ7D60X3uqzhjtJsfEmycqGCPEomxsFTAHWdAmktpIB1AGHQY0OpL9dFPByY5bTXqqSbFX7970wfhx6k8TLoHwf+cA9VMiLrRWYJettg0QqpU7SFwURxdJBaCTW1rV03aAlztYQ2wfl/hlASZ12c0wIxdGGGzQNve8dndwT1xVnAbBDEE2xTlo6k/CLE/svNoNi3TXo0APd8IpASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Q6N7g+q0o9ohW3uSgexo2vnU8aUA8QriXiNKjbM92Y=;
 b=WsBKx5h1FJfvyPQW5O8Y9+2Di/w+oPO2pmX3TfQ+DIm3NlvqP4NpoiMLI9G5ml45Dx/rf0b7VNn3cE8DivEKW9mjHULJundfXUV4v3sgNCy+VezOK11Ecs3i59ZLHl1LNQVRY1bwD9C1KsSOkI6MAm+YtidvPz4U1zur0W9COnvdJs3CUREAuecyYND4I6VIfxciKVGv9rDv2d4j5E3FmO8I9rZwDqGoX7P+tfMd2lhqv6jMMQ6+0sDfBHW3niAsc/g83SwJr9zaGxhgyHZVrj4ea625qmW67xdbMi+YmUyCrqJ/XhEoNJm34/Lx8isHxhTpYmJA+bKOlesO+d7/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by LV8PR11MB8463.namprd11.prod.outlook.com (2603:10b6:408:1ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 08:48:59 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 08:48:59 +0000
Date: Wed, 15 Jan 2025 09:48:52 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Shuah Khan <skhan@linuxfoundation.org>
CC: Reinette Chatre <reinette.chatre@intel.com>, <fenghua.yu@intel.com>,
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ilpo.jarvinen@linux.intel.com>,
	<tony.luck@intel.com>
Subject: Re: [PATCH v8 0/2] selftests/resctrl: SNC kernel support discovery
Message-ID: <hfyhmyaxzz3d4rtuujmpen7lj6xcaoydnmvjmxa2wg5ynppzvs@nf7gpp3i2z2l>
References: <cover.1734361935.git.maciej.wieczor-retman@intel.com>
 <808036fb-9a2c-44c3-ac6c-5406313a232a@intel.com>
 <9223d698-d16a-43c8-95c1-9839b81c2c23@intel.com>
 <c1fd1a9a-ead7-4203-af55-5eeddef76f2d@linuxfoundation.org>
 <e9971c30-8a0f-49d8-a7f5-ccd64e12f895@intel.com>
 <4c34c66e-6861-4195-8837-5debbb0f71da@linuxfoundation.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c34c66e-6861-4195-8837-5debbb0f71da@linuxfoundation.org>
X-ClientProxiedBy: DB8PR03CA0018.eurprd03.prod.outlook.com
 (2603:10a6:10:be::31) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|LV8PR11MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: 89126fdc-4b24-4ebd-6b0b-08dd354173ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?/osD7pIvx+YOtjEnQTT+GH7ssCwGn5BJVp+ge7H3gAKDETAaD0kX3t3kA0?=
 =?iso-8859-1?Q?e0zt3ynHuhhlagtGNdIn1hmNIfliGiDWG9DQRTK2frxqHexnryk9cPyTZw?=
 =?iso-8859-1?Q?br1pYzOOWyqTAhTAcHRbyKODqYWew6QrrJQcSghM3V4ucoxHi3q5cuQ41j?=
 =?iso-8859-1?Q?709+Yn+NL4wvoKr5h/nB7RvPz9aFrMQ1w7Cpz4aJ/XFtduC0PxEIjLmG9Z?=
 =?iso-8859-1?Q?qjsqf50Jv8dbmvOZOihKfqrRjrLyu2qlVeyhyJsHwkUXxS5ktsWWU6lH0v?=
 =?iso-8859-1?Q?EbYATlnOGkQEXBXJVOjHsMgd0DUBtOXoJg58vdIl4K9d0Y0UT1Hi8+SGZC?=
 =?iso-8859-1?Q?41kwUrjDRtcYO1y82FwWr1mNjMh7okMMQsKi2v7HAxmntqLteGoZB5Xx+C?=
 =?iso-8859-1?Q?xcaB33wLQhq/m/QrAmWjtqXSxDgxvRuO9+SNESNYldX5Cild9ZZOgG6arF?=
 =?iso-8859-1?Q?oGlhsEFb4S0udArQPYhxWFI2ZWNvTEGosB2s2dK+LxtN1UGQyfxxD1K8Rb?=
 =?iso-8859-1?Q?ETTkbJi5xWXGZY8YBqMDBiyqdwAb0Tes5gQrBfJAdicfI3sNKCz3TAlZUA?=
 =?iso-8859-1?Q?MLvgsRGi3O6arN+yxgyo0bMAAXaVNaFx65X6qTXGTEjehdtTwapQKThBvp?=
 =?iso-8859-1?Q?FDZKIlSt7rTfA6xt6/0pr21thWh4i4WQy3Ik6AEz6KOk/C+0jlgjaaRbK4?=
 =?iso-8859-1?Q?lD+wfI1d2fxgft79m3tYO+270G2zddqiUiCTWC3HAcLuzn8EjNuSEYwn37?=
 =?iso-8859-1?Q?RDqs+k0l0NE4Pi6OaHdOhAeJfxIk9W0IGaMncYeiByvvoIYIxNNGCne1jx?=
 =?iso-8859-1?Q?fSIFd0ZitSDs1YgDgRaXF7NDSNNhA+WWinKBCuGuWFlp/9JF2C17jwq1++?=
 =?iso-8859-1?Q?eiv50vb5rrmErFEUcHd+f7edvBCKRm6prNT43r3OFOU5XjEbWvA++ZLzCv?=
 =?iso-8859-1?Q?QjP1V/v8YpOfLBfymCcAjGHHIQ5r2lOuWeDTWHTMIYVUJ23xPFwokYBrct?=
 =?iso-8859-1?Q?WmWLjh3RqG/XD+qMTVgvFur2Uj0I6RyhY5vVVRAbp7/jpFBaYAL9KBd9wS?=
 =?iso-8859-1?Q?gk0YxdpHCVvR5vX5zYlOG7mkxe+7WmzZ+TE8QJtXYpErsjkJ32AnjZggb3?=
 =?iso-8859-1?Q?4UVfKtQ42IcSGEF5o3PyjhHcpNm5UCqu60jhAIDwI/SENy6Uz/Bz0F4lHX?=
 =?iso-8859-1?Q?GneUvEyASAVWp/TIYCdzgv71GYUV0fGoe2Fq24UdXQCf45Df0VwCDAZQqB?=
 =?iso-8859-1?Q?UoPO896I/dRE26OnWqN5ho0zWsEmiRE6chSrWOSBPi1wj1I0dZRkDWVVMb?=
 =?iso-8859-1?Q?/znZZbLDN9GuQyrW8NFMUiOfG1vqVG0+WxV/EycWIkePSWrxV2gmbqQ9V6?=
 =?iso-8859-1?Q?iY193DtacJaEdLFfotmTozRnFj8JJRUgc0jn1PxeQHMOBoj5wpiNMcDGn7?=
 =?iso-8859-1?Q?1DWaeHgFvsb4HyGZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?DTNf2xWU2N8gB9TVuHfCyf39VJeBqslxioVh8AE/a+aSSpTH8MX8mubQ/4?=
 =?iso-8859-1?Q?rRjuYfosZsaSN2DfRyvPxNBeV+C71x+NKkC6fzmTdxeNSJQvwcdfxfRZ/3?=
 =?iso-8859-1?Q?52vnTEljin3H/CCJ2IEGRMtHWpUky7yrve7+tk7Oe/+77NVbvC9VnF92J0?=
 =?iso-8859-1?Q?XoFEJ4hi0luVn6Om4wggng74kW+WeFckkMkyaWY1LzWwpbECPmDtQn7g97?=
 =?iso-8859-1?Q?06bBMroxCa3xbIYhC5iip138B0vpH/jr8SdHqucmsaF3H0yccg0GZH6lrM?=
 =?iso-8859-1?Q?k4qYqvf4sX8teOq4z074u8S6Luh+W0lw+TmVCVYdmhjYYdlbhBRqT6TUIG?=
 =?iso-8859-1?Q?/25DztFyPQzyv3urRPbmfftKszZN6g22WxW3K16CJa6iGiw6WchUz0j3xP?=
 =?iso-8859-1?Q?A2DZgThzfjizWTertf8mW+vaQb8/UULMzI/Ii1Ofbd+6r1W9rmoJebw1vT?=
 =?iso-8859-1?Q?HeP+sLTxztIuLTn3vor2niZyP/yuEnQKwU7PG1cOrRtHTCiVFnSWbnfbsu?=
 =?iso-8859-1?Q?cLpcEFTkyx8qli4u5rXqjF3Omzb+yOrPp067OPF2Dg2MbbmQaF8baLSyB2?=
 =?iso-8859-1?Q?hi6i9oIBuR6IVSXaEdmlycpwhUX5V7EuzPFi3sJ8N1o5SIgwjhgWEYUuml?=
 =?iso-8859-1?Q?tdWF9LXV9MBRDLkCUqLiW+RwEzBZ+rPcqd4LTF/ih+ZH6e00bjX4pFZbn/?=
 =?iso-8859-1?Q?QQsYsEdr7XYfcvn2+TD+RUknmldlTGTLaeVIqTU44V5PffPAHSKAnHg7RY?=
 =?iso-8859-1?Q?U0NvJYuqZM4I1UOrMMf0y+via+VqxYECIkv6JHXMVdnZUaCNcaLZAIABI9?=
 =?iso-8859-1?Q?eXk11aVMl/yYLCAnKdRhW607ffA464J325aPS4GydzAbgD2a33lkL79HfA?=
 =?iso-8859-1?Q?iazkv0PSfe0lkq3Ja44dIpcyMv4vCRVy75T7y/F1RphoVWrz6ngn/h2EpC?=
 =?iso-8859-1?Q?eClWP0BwoBeUPVEMz0DZDwwKXwHbhWx/vxobmMLKk/hhYkf/DyAlDgr1V8?=
 =?iso-8859-1?Q?SzNc5MlpZYqk7EortgV06zaEG52QS8PBw9M8f9o6q5jMesK6WQF2lPUePS?=
 =?iso-8859-1?Q?Fiv7ehS07S8IbUC4Qme1MENHYsHHPY48n83o1yZ2zrcgqov4i17URpEux0?=
 =?iso-8859-1?Q?uIPS0PXNRUqSIKPB9jJSBfivbH4wtNo4BcycG+SY2kSqc3i5tGQ7aRd862?=
 =?iso-8859-1?Q?CcIMeJPeIjn8yhJ9pRBa1eD9ONKFLQkFJdSTc3e7xNQXTXsOrb7J4Cwb03?=
 =?iso-8859-1?Q?/KkZTTLfKNRW5sQRC9iLG47VKOnZvbi0LkLUWQZ0cz30RY4mJ+VVBMM+Qy?=
 =?iso-8859-1?Q?XkG1iqJ694sXanywGpS5z6iJOHbDe3dmFjdBJ9IEy7VYWVhCgB/LGeNJxH?=
 =?iso-8859-1?Q?O1GURomOoj7Xs3/uoqIu3s9ApiXuk/NFKn2+egJT6BLouO1fLesTZi0txZ?=
 =?iso-8859-1?Q?hBmuu+/Cw/rWmZiFYTMHBQ6Fj/XWVvh75EE4teBebeZt7AYGY60/ct2L4L?=
 =?iso-8859-1?Q?5YPB2AVuoljQbV+57UkNuvO83qe4VzYbqDoDj8Sf4MdD8yqdgTE64qMrDH?=
 =?iso-8859-1?Q?u0It+obwVlIEz9xygzrZYf6TF1hK3flr/C3OJQjR8hZAgztGfJ/e/Prd6d?=
 =?iso-8859-1?Q?VO4Ah/GZHMkTB7OZ1toSy/9NVM4UR5FWFErbCujPNSsSsrNj+4iC8B5Oy7?=
 =?iso-8859-1?Q?reOIYfkQ5gwn7N4S8dM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89126fdc-4b24-4ebd-6b0b-08dd354173ca
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 08:48:58.9353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jH38PnfnOzvegb45Lrf6j3mYoh6PYe9vu3+GPhAp9MWha9Ftzbfvse95ix9NbK7X6O9EEqRwCx7l7yQg8BnaMJf0s4KPD0MC0Gnjxu3NySc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8463
X-OriginatorOrg: intel.com

On 2025-01-14 at 16:58:34 -0700, Shuah Khan wrote:
>On 1/14/25 16:28, Reinette Chatre wrote:
>> 
>> 
>> On 1/14/25 3:25 PM, Shuah Khan wrote:
>> > 
>> > Thank you for bumping it up to top of my Inbox.
>> > I will apply these for 6.14-rc1 now.
>> > 
>> 
>> Thank you very much Shuah.
>> 
>> Reinette

Thanks for bumping up the series :)

>
>Done. These two patches are now in linux-kselftest next.
>
>thanks,
>-- Shuah

And thank you for merging it :)

-- 
Kind regards
Maciej Wieczór-Retman

