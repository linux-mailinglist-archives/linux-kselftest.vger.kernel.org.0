Return-Path: <linux-kselftest+bounces-25824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 223BEA28A53
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C93166074
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 12:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E8220ADFB;
	Wed,  5 Feb 2025 12:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BTcEEkAL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78592151987;
	Wed,  5 Feb 2025 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738758733; cv=fail; b=GYdHJIgmauLvg5eGQX+oEeZavMjiq57an5jlPc2gV2YcygXAObmLKdLkB/p3EDg07nbO9JHLqUdbZ6QYJ/re4NzBZr1yXltjbxibCj3SYUOeoNnbpFZoifw8tqmBvoCMWgrluFsEfSnvHOPwP7u4k28kr0z3CzqNOahJG6vW87o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738758733; c=relaxed/simple;
	bh=Vk4c+jfZyEv/DcCZ2d/gKR4uYwh5VQZa96Douy3xYg8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EpZuSHKd0pKTRo8oGVSlR99d6lw+WiXFi96s14FwOSJu2A20WE64rMOBkMvFv9uu3u1Ts1jlAw33GuRMjz+iX6NWR8o6ZRuPhkcA6VLa/stibNG+8towkcnf5ZNJI3kLariP0n2BQYxes5IqMBC9Zh5HIcADrp1OcrebSRjrQR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BTcEEkAL; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738758732; x=1770294732;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Vk4c+jfZyEv/DcCZ2d/gKR4uYwh5VQZa96Douy3xYg8=;
  b=BTcEEkALTPO8lhOiCFY5WWCvo5lQ4lqGs8/r8R/0i4Z6AvKg8l6+NEpI
   OLTw8ua3sDjsdnZvm1tSzwkX6yzESDBnQnBhJ9uQlLTaGuMFX6AXg1a1g
   JY4IEHr7Q0afLLIDxbguDZBBj46BORyphw1iUwSjYJTXdeg8Wj+QZGjuA
   uQvU8SCVVEyD4dcyPLQIKeZh4eCOQ1Ew6QF8YSVSLkDlo6VmRzlBLI2ge
   Xi8piER5ZzIfF5S3gu0TktTlIPf1WPhmHF2hfnp3kwrCGz1BqLNafLUCX
   FMqdZF8+jMJAtISA8H749aPwIffzapHD52zmNzo/p/yyhZPcwoy2cQyyw
   Q==;
X-CSE-ConnectionGUID: VnWimGskQhmF6v9qT+/0TA==
X-CSE-MsgGUID: OWdr8+xcSSCaT5d65qQ1ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="56746290"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="56746290"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:32:11 -0800
X-CSE-ConnectionGUID: ID/qly5lTrixN8ni2J7t/Q==
X-CSE-MsgGUID: Ddar4mosRu+qCCbhEa/acQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="115942241"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 04:32:09 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 04:32:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 04:32:08 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 04:32:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWlfjWiQZYg7bMIiAU8hF82jcqzN/xiyGa9rX9RHXrZ1hz3d45FuaaaxEp15P/jk+351sqKdXCV4P9P+xFURN8g4VRrXOadBFL7sMKmgbxM+LwnxC7aBRCfOVMziLIn8B8CVCu2qtznos3XQkePTMqsMQZNnvXybWQ90YV0oQMryNNKE8v1j5NbvtTcneB4uru6LI/h4meuvTg5cVBRpKoxxi1knl2r5yIWDQ/gRUkUsd8i8ZQrzU2wncJWMHmvd6HZeha8tjtfk7jb05n9T1oghztHZO8jtq1fmYdAo+GKFZIO3eFqVGNEnPGKrg5EbFEblyxfRR5rC2EpFWW33Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4APmcxV0QJiOFJlppxhvx4O0TxJy8Gb6DK9/+JahdQ=;
 b=B6blNE1Byf4hiipkTEOI88/Wl2Z0pEg43uDaDrp0C7WvW6qXYPdFPuYh2SMB8QYaZoWGt5r9RDdz53AP3UZ2zFf0nll+DXgeJSKcONG3fiP4Dy3vs7XoLK5N7Wieo5pvBf0rvpdFZeJtCC7JVB+UXUymHxQPwtorTnD3qZgKs6ssKbUcAEV+ic6kfXSbXYa0q8ccXGUoJTLDH8lky5m3Z9JYfrqvBinaKF4tDFtl5zoy3tJDy3cz6IBV5556KN9c4ga1yUqE5xYFhaTe/lnw/7YqVHuv+G+bzn02i0ES+fwVUjFAa503wJv4aGr76ddTd4x/X4Wr5xlRBVaA32EDkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 12:31:36 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 12:31:36 +0000
Date: Wed, 5 Feb 2025 13:31:18 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Willem de Bruijn
	<willemb@google.com>, Florian Bezdeka <florian.bezdeka@siemens.com>, "Donald
 Hunter" <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, "Bjorn
 Topel" <bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>, Daniel Jurgens <danielj@nvidia.com>,
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
	<kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>, Choong Yong Liang
	<yong.liang.choong@linux.intel.com>, Bouska Zdenek
	<zdenek.bouska@siemens.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <intel-wired-lan@lists.osuosl.org>,
	<xdp-hints@xdp-project.net>
Subject: Re: [PATCH bpf-next v8 4/5] igc: Refactor empty packet insertion
 into a reusable function
Message-ID: <Z6NaFkPBZA18oILE@boxer>
References: <20250205024116.798862-1-yoong.siang.song@intel.com>
 <20250205024116.798862-5-yoong.siang.song@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250205024116.798862-5-yoong.siang.song@intel.com>
X-ClientProxiedBy: VI1PR02CA0060.eurprd02.prod.outlook.com
 (2603:10a6:802:14::31) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MW4PR11MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e152857-999c-47bd-eff5-08dd45e107eb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kJblYdAtmkLLyWkeI02SDIUZiw/hE1ZML+B97sJLCnTOHmwZEn8FDssGOGBA?=
 =?us-ascii?Q?FNCuNi3xu+HIE2HWJOI0Z37JyzxObJcUyg2xLF4LFVqd4OJPyb2T9E2PWfb4?=
 =?us-ascii?Q?Lq9Qf5FNHOkgv1GXrGvgkALfz6BSXZj2OHQezcuRsIzrkOlhfXwv4cY9Ku8O?=
 =?us-ascii?Q?SYAtO6Fhkh664ScFwrCXF6XSDpEc90nR3cDWe1l5dcDvfc/zAJ+/L5fV5rcR?=
 =?us-ascii?Q?SqAsVb9YYVPhE0P/eOzuwoRtkLNBiv8MEGFLbgRq9lz71X7Agkl8BiW9cYMS?=
 =?us-ascii?Q?TmEBLmTf4JBUVdYMJGOZt7DVAIZFHz7rwFlZCFjideQQIZoITC8DxHohsReh?=
 =?us-ascii?Q?zjeKYd0tAYEJEVjCz8+FAWwTKoF8+2fdwlRCyPxuwhXHLqnDVW7RXcNfpnKq?=
 =?us-ascii?Q?DM8prsFEUUNhyb0R1NUbEOsUD45dED63QIlHqqYgiLLm4WEN7HTfc26sg3Da?=
 =?us-ascii?Q?YhXmLDm0GP2Qil9rJfnxr+2CDpFNF9mBxKKEX1pdNKvwy5zTvL6pS/I/mUhv?=
 =?us-ascii?Q?2P+RI//26UaYG/GgZGp3OKoMl8/kOy9E3kuZs6fu/cUWCSGMEcbj8IudKiHA?=
 =?us-ascii?Q?UmM3RIhOIinGY6xzI4RQhfR5JzEeGmcXK1NSXp0YHHgORM8PRNyEvuT6GGA3?=
 =?us-ascii?Q?NRiDMxLZSFMkIg/IrUCDTDpLtt22IjBsGg+SO+mQOfDtHMptUFKrMhp+MvWz?=
 =?us-ascii?Q?6RtfgAqMIAy/3iFklVE+P0Ay3iw90i15xCNhV+l9cerSa6g8js7yeMpNiejW?=
 =?us-ascii?Q?sBvAtfHMh38RFWF78bRli5SFTltSRbShsM20qnbJsCuYaBCeePMRbfAzeVEE?=
 =?us-ascii?Q?bKW8udBPw71EEkx6xHzL+42B9LTWL0taFwESFAnsm40GPSkMHLXa/Vj1NIkz?=
 =?us-ascii?Q?0wNbTPtpX9Id4dJdvBne1A0DZxw9X358ZZJbvKUS3W1hyQ9oXCldTk5pw9H9?=
 =?us-ascii?Q?3Rg5iQta1chRaJtjzTGJ8r6C49gK8nnSWKDcgaQA8fRUN74aPV5pSpg3Zr2B?=
 =?us-ascii?Q?/speustFasycRoPmzP7dYUfrI/WIEEhov6cB+Go8mt7zz0G6ATdg82dAPhBM?=
 =?us-ascii?Q?uQx9hMuFDu2KTUof6t9l38PX20J/g0vuwGV5OETCqEmS4eynpZ0GzV4cRUTH?=
 =?us-ascii?Q?c1GuTiR+5EO/1jTeWC5ijxQC+zQ4dKojMPZzypE7N/vsyuJOfPSXvrh4b9Xx?=
 =?us-ascii?Q?3IwLX/MEvo9ZRqyS+xJeXuYaZjLLt6KT/ri98nfnfYM/gvzsTH7VSul+hFnP?=
 =?us-ascii?Q?Svyvb2bOXzHBt6qN82R32Dg+NiqiCvsu8y7cGa+GtO11qEZOvunzeeXUcg7T?=
 =?us-ascii?Q?wutDatferW/TQvlHRKWcU1JveUHCm0kYMM5xVouPlQ7gFjQzACp04CMq80Y2?=
 =?us-ascii?Q?Kzz+vVqijqdiQ+t3FmCxPlOK19Tt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O7pD8gu8CX4GvPcR5CPZFz7BDtYTqspk5llIv+mJ9tCwCgTbTki0K7LFrmxN?=
 =?us-ascii?Q?x6XSmzD2qaj9rXISRIUCEtxuUjl6/YMLqLG2v7PCl/8W4qX4KGjeVHB7B0nK?=
 =?us-ascii?Q?Spqx3mEC5n/AhRExaSc5ilZ0FxhenuSpMywD8nu4I63hFVWj2ypT6nQF/1qZ?=
 =?us-ascii?Q?YY+32kliuE88yyIeXGIL7pq21mKRaffI7XReTO7T6ldrUwVXMXBVBSwLE4Qk?=
 =?us-ascii?Q?qKTw/8o6vVjgFffdJr+a3s7/5KhOToKwuisKZtKyCQauR3Qm+Hxn5suCha3R?=
 =?us-ascii?Q?1CLF1NByz62Aye9XGFXNIsdIPdQU3n/36rKuwzomnyLljoqsMjMvfSQ8tasa?=
 =?us-ascii?Q?Hh61bhA7Xvi2jHQVNF/dT7fT24BzqceHP/Hp4vWh7zpetrBOmG6ofPlE4Djg?=
 =?us-ascii?Q?cg9IVIRiyGnVAdcmcLPuD6AS0gnte27YjFEuS/wF16ctrnB0nSkP9C8zRETB?=
 =?us-ascii?Q?WQ/ioUKMavYVCm151MCikHD6X2OV92ihz9L53cPbd9H3EH5p88FNLAAYm0Kl?=
 =?us-ascii?Q?/ygwn8u1wcV0DyuAo18NEdMRrjpo0loyKhZ8VfaMfG79lXAl1GsAXrtBgiLe?=
 =?us-ascii?Q?tsuSNl2VjEBkVDveP92/53rTQ/kREXYELcnto81KMuQAIgeeaH9aS7lSK12H?=
 =?us-ascii?Q?Y0NO+J6i+fYw+/9DEdH1iKnSK4gLMiMLsGoAlw9wsg9I/rkFF6BVP8I5wCcS?=
 =?us-ascii?Q?nevVG6s9L/OBu2QIW/+UhI41jSUcSHQgNfWGTtKl2cPw0u9Sm8h36pdDbWHv?=
 =?us-ascii?Q?FCN43K3PT7q5a97Cvrj+Yl9W1kBjzJdtDQvEMUSfWUxVpbzovaCjEDDJ+mBi?=
 =?us-ascii?Q?bIsiTnbHuiIIA2uhtx8YhYm8ou3PJBrBFLuG1AhOqKvVEzDSgthqmG2lHUV9?=
 =?us-ascii?Q?DEtuvg0GkUgjlKuoNxBqVP9T7e3001Ew67esZYbtXWkQL6UfTOh1m0adb3l2?=
 =?us-ascii?Q?OKa+ojOUjdE2ilzyRTZ2NN5t3EYytyNhBwX02ja4gXUuvL3X7GMWy9yoOJ7A?=
 =?us-ascii?Q?/qDM90jiYIGKHFlRX4yc+WhPn+xasEHcGclDoLeM7mljYYyV99mzLiRL+txP?=
 =?us-ascii?Q?IMxGRdQYCdjFfpHI8zDupW4r8z03FEYHffJ0JGdGSj9BLPr5YZJPA5MKmVN3?=
 =?us-ascii?Q?Ia/gjRY7g5W6yg+UhQDYOsckeGih5EvNmAEgyYsv9jw5TujWj1Q/v2YmPDSJ?=
 =?us-ascii?Q?EyuIF/JtcSWlNlvw1pyuFdIe9nOpsJqUw9ZE/uItc4s9WLPwrbC/s0shBtiF?=
 =?us-ascii?Q?x6TpJvF6CjlbcrGU3SzAJ73jZksTI4mdsnalI9Gmncmpt+Y431ADwMEy9JhN?=
 =?us-ascii?Q?JpEP+2jOR/QeZ2PAqwISXHfsrU+MslCStUdPog2OkUqVxqypPOogGgw/3ope?=
 =?us-ascii?Q?njDQd9NoJSWjjHofHlEPI1jP4/ch2Kn/v0RWUs04NvyD1+7jwuZ5ZT5lRRlP?=
 =?us-ascii?Q?QyyCyTcalkH7hUM0sf4qAoVQL5ag2487osFRJ8eU/1b7pQXjJamW3orSMdYQ?=
 =?us-ascii?Q?6LwWKllMxuj5zoDZ2VV/xjn4hP34CXX87KIXMUt4yWvIPac3DCvHENYWmcLt?=
 =?us-ascii?Q?e9KxRWG7MYEjTnpD0VmI/yLEHvIXQvTzv8E+I+dGfpaNNKUGEKKdV+y8PBZA?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e152857-999c-47bd-eff5-08dd45e107eb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 12:31:36.0861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90rQgulDikvfFxq9It3klUvZoSdERMUzAiPzhr54wxI8nblBqzx+BZiIlvGYhOfd3umvzFMGl8ILgd2qlZik/W14afY/a9NCZcrD75RbOdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5933
X-OriginatorOrg: intel.com

On Wed, Feb 05, 2025 at 10:41:15AM +0800, Song Yoong Siang wrote:
> Refactor the code for inserting an empty packet into a new function
> igc_insert_empty_packet(). This change extracts the logic for inserting
> an empty packet from igc_xmit_frame_ring() into a separate function,
> allowing it to be reused in future implementations, such as the XDP
> zero copy transmit function.
> 
> This patch introduces no functional changes.
> 
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>

Your SoB should be last in the set of tags.

> Reviewed-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 42 ++++++++++++-----------
>  1 file changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 21f318f12a8d..553d6d82af0d 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -1566,6 +1566,26 @@ static bool igc_request_tx_tstamp(struct igc_adapter *adapter, struct sk_buff *s
>  	return false;
>  }
>  
> +static void igc_insert_empty_packet(struct igc_ring *tx_ring)
> +{
> +	struct igc_tx_buffer *empty_info;
> +	struct sk_buff *empty;
> +	void *data;
> +
> +	empty_info = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
> +	empty = alloc_skb(IGC_EMPTY_FRAME_SIZE, GFP_ATOMIC);
> +	if (!empty)
> +		return;
> +
> +	data = skb_put(empty, IGC_EMPTY_FRAME_SIZE);
> +	memset(data, 0, IGC_EMPTY_FRAME_SIZE);
> +
> +	igc_tx_ctxtdesc(tx_ring, 0, false, 0, 0, 0);
> +
> +	if (igc_init_tx_empty_descriptor(tx_ring, empty, empty_info) < 0)
> +		dev_kfree_skb_any(empty);

I still don't like the fact igc_insert_empty_packet() doesn't communicate
to caller whether it successfully produced descriptors or not.

Look at this from igc_xmit_frame_ring() POV:
- at the beginning you peek at Tx ring whether there is required amount of
  descriptors free to be used
- but then here's your additional routine which might consume two more
  descs and you are not aware of the status
- then you continue to further produce descriptors assuming there is
  enough space in Tx ring

Right now igc_init_tx_empty_descriptor() returns -EBUSY when ring is full.
How can that happen in the first place + what if it would *really* happen
though? You just continue with your Tx flow.

What I'm trying to say here is, at least from correctness POV, you should
take into the account two potential descriptors for launchtime feature
when calling igc_maybe_stop_tx(). And igc_init_tx_empty_descriptor()
should not really care about space in ring, it should be a caller's job to
call it only when it will be sure it's safe to do so.

> +}
> +
>  static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
>  				       struct igc_ring *tx_ring)
>  {
> @@ -1603,26 +1623,8 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
>  	skb->tstamp = ktime_set(0, 0);
>  	launch_time = igc_tx_launchtime(tx_ring, txtime, &first_flag, &insert_empty);
>  
> -	if (insert_empty) {
> -		struct igc_tx_buffer *empty_info;
> -		struct sk_buff *empty;
> -		void *data;
> -
> -		empty_info = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
> -		empty = alloc_skb(IGC_EMPTY_FRAME_SIZE, GFP_ATOMIC);
> -		if (!empty)
> -			goto done;
> -
> -		data = skb_put(empty, IGC_EMPTY_FRAME_SIZE);
> -		memset(data, 0, IGC_EMPTY_FRAME_SIZE);
> -
> -		igc_tx_ctxtdesc(tx_ring, 0, false, 0, 0, 0);
> -
> -		if (igc_init_tx_empty_descriptor(tx_ring,
> -						 empty,
> -						 empty_info) < 0)
> -			dev_kfree_skb_any(empty);
> -	}
> +	if (insert_empty)
> +		igc_insert_empty_packet(tx_ring);
>  
>  done:
>  	/* record the location of the first descriptor for this packet */
> -- 
> 2.34.1
> 

