Return-Path: <linux-kselftest+bounces-23414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ED69F3148
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 14:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94CFA1883991
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 13:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE3B20550B;
	Mon, 16 Dec 2024 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fzXJubo4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA002054FE;
	Mon, 16 Dec 2024 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734354590; cv=fail; b=SUVbN9qLye7xqC7idSyqyr99OcIW88uGHAG+xdBV8KQYYFluKHvSKVrfDmZx8W7bus8nOHplkAqxaiJzVtHfu9NGIyCBRtRLsfmwT+doWuv4C2aooHIBa2/sMGYrUO8oMwPakC3g3qHp4P515gQKaIBJ2AtyWd6bWjPcwy4WTG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734354590; c=relaxed/simple;
	bh=57UR0fWG9Q+ErzUnmU1qhqf7Ea3HHoADNbJ5sJ+OxvY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BL128/j0V90q54bi87mx/biww/iKfAt9GP8+4oIjHSNkyHbEeb0fSzZ9AZ2owxVF1nX3l/hVThkqE58ahrJQe4MUgCEnK1DhNHHG+5aTUOPXhAQhM0MQwIP3TnowSnJMFhGAZyo8E2x8ZGNT85pdNpq/PIAeOL93/PFoTt2qVFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fzXJubo4; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734354588; x=1765890588;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=57UR0fWG9Q+ErzUnmU1qhqf7Ea3HHoADNbJ5sJ+OxvY=;
  b=fzXJubo4jEt8kkhqQ12gbK+j22QtaZ4YGJLhc99aULWs2fsSi3KYfLjZ
   XX09mQe+fSfdtPuUcMNj7b/M2LrergE9a/f29wuzWewnOFeej/52CSBAT
   itASdjeSBDzxggwGslWD1Lcw6RXS/IsBRUVMZtow8xRg8NY2lf7Zr7vUH
   7fr6UDvSu3w5zcBd6t4O7SHXKdcN6pc22TskNiQD5IEAS7KdNj5+eVkuG
   XTwtWfIBlIk14HIOlJqAYFvS/9HULHqS2cNJHAgUGH7XBMre+fHPLRtdB
   7g6eq9EOdw/FCZ//7tDLcQ2OI5bZ0xE69tDp6Xh3YQ13z6T/8HiwpMFMX
   Q==;
X-CSE-ConnectionGUID: vzJ/rd1ESba6yCbrWtZVRg==
X-CSE-MsgGUID: Ns/W2dOPTQiahtwT73S4Ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="46131118"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="46131118"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 05:09:48 -0800
X-CSE-ConnectionGUID: gUmwge+fTfqZGS7Rg7Cl3w==
X-CSE-MsgGUID: LEc0qDEwQY+aKRnvSyirjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="102216633"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 05:09:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 05:09:47 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 05:09:47 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 05:09:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUKbFhRrU8rdrC0KwSQ1mEIHX1FmEhdlmvHh5zMn21aSCjgHXLOVxH3qe2zV++aGfaefeVp6tew/nNGh6JvntKSL7VDf8cMAgp/hVM+W/ph+rhh6tnIbGF7fTvKDYAo5lppJIx/O3bZHwmbYEFMV5FRJq+Q3T3eoa2d0QQPojRMrUUPHVDLfde6l035o/4dZGx5gx9pp//hxQH1idWHYF75fchSLky53jehJYnFmx72ccs8JuDUfkgWhBzOmtC2KzAIofmj4R2ix754sYBxce64sft3S/jBIGEU2nEMVNmaLaLvBr9RFGR3Q3kLpCv/eSZBoonmhmXaB2WA/LKMXJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6vQm/gV59eMVQbLKxetpUhiY2Ed2xDcrG5MjWH5sYA=;
 b=O1vaqNGTDkog6cZdABA2xBYgqzdz5TGlWLAdxmHPOCcWCVRX1l11qCOYoCfI1ZSFrhH+7PyLklzCUsBvbWaZtmMFGKGEZnH3a6QDF/51ClD2++HRt70WFyrAQeCB7P6WcqrXjGScIaFYwqGgKM1XecH5XgHMi6LrMcIeAC/2oUhC7Vc1zZeG8KdgU4afI8Ul82WCnIthu2oQJqpvyZDYHQihau1ss7btULGZawdYcaUaxETDsnUoQPQBb0nqPylWO2eP3QTASz5yrzazPG9p+bhXd+esX98iycfX+an5PDyUxRDyHcHUJRxRNI+VBh6SOM75phW2rysU2bBmfSWKIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by DS0PR11MB6471.namprd11.prod.outlook.com (2603:10b6:8:c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 13:09:45 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%3]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 13:09:45 +0000
Date: Mon, 16 Dec 2024 14:09:39 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: <shuah@kernel.org>, <fenghua.yu@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
Subject: Re: [PATCH v7 0/2] selftests/resctrl: SNC kernel support discovery
Message-ID: <artiz7pangcy2bgfyhbhiv3rag2p4idyf4s56n4chat7cfuxtf@mj2bj3hejgge>
References: <cover.1733741950.git.maciej.wieczor-retman@intel.com>
 <ca2b665a-79da-40b6-93e1-533fe1c46cda@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca2b665a-79da-40b6-93e1-533fe1c46cda@intel.com>
X-ClientProxiedBy: DU7P251CA0015.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::6) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|DS0PR11MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: 955db382-0cbd-4b8f-4a85-08dd1dd2e91f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?9TktmFPDZKoOLtudhQ3uIiQdS5cvVI8D0stJzm36l9M09e/I87M2XQbYpM?=
 =?iso-8859-1?Q?PpU1aSW8AMOsyxUA+luMQZoSfdwBxa+HPar39VLuf7zmBpTE6f/p7hRDgq?=
 =?iso-8859-1?Q?rUJEXQ/LKXBpPqMeWYda2NTGZtBFKSjq9j+4T/Yn+kd2fbedUdq0ECqara?=
 =?iso-8859-1?Q?F5ixQPoNGLg1jBwPazgI4B+a5gZZlrqsM35GVf9JF8pfQD7agLfU4UU+q2?=
 =?iso-8859-1?Q?gYvJXNk8uwvztSg7sGkK9g1ryxFGm6FyRDXP3ExIY3iNfxXHuAqvGL4255?=
 =?iso-8859-1?Q?X4Qdo4SVqu+3wo+eEDW8VDtU262SwvgwP0vpijEQSnxbmfg6QUSivdVcy9?=
 =?iso-8859-1?Q?AFrlbhl3mv5GVARwC+4BKTNFCF/lKI43h0OFOvV6yev9OLko0wjdIvplxD?=
 =?iso-8859-1?Q?orfkkJsREZ8Ju1hLiFWPy5sxDppy3ojrXnYuPVzb8OynwM7Qd7pbUKcU5S?=
 =?iso-8859-1?Q?qWKVAIS0c3Mh3wOU+oIuJToQU040Pd2XxDqoq3SHrFFhYZWfCUD97PTUqR?=
 =?iso-8859-1?Q?Z8Kta5VQv0vNBUQ6/XhTo+JABp8kbGxSqP++p90163H1RuwLnLYJOqx6NE?=
 =?iso-8859-1?Q?x3a7/xu40sur4AK5W83klE3bUkkif8iFNj8FBuNDraaAtFg/a6YH0lZ5+L?=
 =?iso-8859-1?Q?lohtW6zh0Tl3j1ObqIVMoAVffbP9U67q9reCA7Wg+MDIFfn9o8rDuWCl6C?=
 =?iso-8859-1?Q?2V7q6CFj5kSeWeiKlyai8BpjmsxC4vNli7OiixXOiGE9/v9AgpGdnh3VG6?=
 =?iso-8859-1?Q?WKkbzRGVzf2OO9uDYQP7J5dh5zRext0wCiJgs8c17HIkbEROuGTVPt+VC2?=
 =?iso-8859-1?Q?y1V9F+vCr10qtRQLDpE29Wz+EGS6Qhmuxz1BjCO3IChx+2jx+XRAyIU8fY?=
 =?iso-8859-1?Q?BZSmrviqoacMqS5qGeecEhKiFqTsvLk3R9Yz7ojGPMii9WOlwzaf6O4AXK?=
 =?iso-8859-1?Q?h2wUKc5ZVme4oQZhTG411yDoK2vgdrLKSOLn3H1nlkitfav3HPxzoJuXoi?=
 =?iso-8859-1?Q?6YH9TNntGEvUmN6AF4iMsGxoDrSE/+lDmIK/RWKXSOe8+iEsaedjr7aYAQ?=
 =?iso-8859-1?Q?mYfkZ+qJv7ZJj5JqkA+EOFc6348p4crsbkikhbA2JUTs64WbC1QuimnHIx?=
 =?iso-8859-1?Q?XiwGazATTFWvjwVkPViz2HdFXNCX1cklLyFq3cTBD2kqWPwdLzmO3nKg8A?=
 =?iso-8859-1?Q?3JggYwL55gMNXe/rCmF3rmVQzWT9OQQOQ3SpzR4Jp3Yh/tsOkKBLjuAicv?=
 =?iso-8859-1?Q?yZOyPqTc/AcBpvvWFswIA4PxvPbqCFVWzcJ9JucSGfmTiYH7bXwZ9S+iFd?=
 =?iso-8859-1?Q?2YRf82KzD/sIQfkUe0958lBXUHycgsM3WyHYFZxchLdo3KR5YWfaeq7lii?=
 =?iso-8859-1?Q?iMBGl2UGNNk5VDKCMRNakDqtNqaF66gjib3CyaNIXcDS7qBRqTCDlpvTOz?=
 =?iso-8859-1?Q?J2GVfVsDzfRwA7om?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?OAmZ9Y0KMuByE4AGUcTSYj7Mvj6CFC5CDPi39mReWkPxmKPPCTVwZcqhat?=
 =?iso-8859-1?Q?bAtizUIwNT6rdEaM23KuBbklw96vkEcKpcLM6ejjE6NCiFhyTifNvpHmOT?=
 =?iso-8859-1?Q?qVB4uFIqn+JLlslQXA2PxyKe6n09tMSHBxgfG/eOZgcolMWJUnzXYj1Xqk?=
 =?iso-8859-1?Q?Ek130cNyh0uqDH55ux2LgXsAucAOuJ6VB/Rztxrz8kfMNWoC7ra70NNxV3?=
 =?iso-8859-1?Q?rw/XMHB4h1c3kzMHy/AyaLN6ijP0ZRRWt1jtGwbZE6lhC0c+dO3pWnnRGy?=
 =?iso-8859-1?Q?JLtYTaHdVhnvJcEraOPU9Eyw+MX7TBjv9JbQDamFCdtqPrhVhFg/KnopQw?=
 =?iso-8859-1?Q?Cv1oEE23iJrpB4lg49L7NeM/zZzDOjHe6i3FxXnmfzYOtqY+nqbNEoJGvC?=
 =?iso-8859-1?Q?2+O039o74KfoVAYodkjyB/Wg/bscTRFGnnNV+OUR3GnUNlOgQEBIKAlXgG?=
 =?iso-8859-1?Q?2kEUGiy+q3nbyyaknwWDaENTps8rcOxrzYaWaSJU3K1uCK+b1uKCymGoUw?=
 =?iso-8859-1?Q?IQ9kuLvjAnI+jd4veGear7SsYlx/4Hf6Y6Ldjgx7PHUQRu29HGghbNhjmR?=
 =?iso-8859-1?Q?cPaMnV81gAenL8/qgyMBJLaoarmknR3eU5v3U4mAl84Bq4OPQZWq4VHh5z?=
 =?iso-8859-1?Q?bvPx3YdrDzQ5YCCpUQnr3Lihcb+STf9Pixk2dogOC1a43HOvvCo0of7vxq?=
 =?iso-8859-1?Q?kidsmCL9yR76FYz9z3xhqBe2fXcZ68ueTlSv9r67nlnWJpuiFMomp7ygB8?=
 =?iso-8859-1?Q?V1lMQl/XizxXh7PHnqLsYh+1xVWHlkAmxD44PUuLIECCZalqrdROTIqxRT?=
 =?iso-8859-1?Q?KM9lRxx0tjwjo++HB2Jq8U8HUW/QLz4I4wNZluIlBODYjWwOgcjC50rONM?=
 =?iso-8859-1?Q?SercjiMx6h4mCjWL7Y6ThmxHAnqC5p2Qv+zSQrlf0SBAUjOT4XnhL82Jjb?=
 =?iso-8859-1?Q?G5Q7wmKhb0hyDIVixSOISikjbaqeja9xL2m1KrrjnEEiqOrXITPiwgIvKu?=
 =?iso-8859-1?Q?m3vsE99QCYFz6kUPD4OMDtarpbBDNhGbHJXWyWqq5ygPHX/pbnpQEI+BFm?=
 =?iso-8859-1?Q?/XY7JnYf1Cgh4SmupaTxYKT4RzuejaHyRF7W46H02pK2/gOirj00ukqRJS?=
 =?iso-8859-1?Q?GYK3LtcYKu7d63nQC7TBGW9RGoDTu6Tot6mx94I7WpVD3BTwPyDJ382H0A?=
 =?iso-8859-1?Q?9jbAfBOj1YFYKDuVeuAFZxZrYZOw0ALmQyjC5cLZiH7cLqNaGPOsJhuA3w?=
 =?iso-8859-1?Q?rjucCGXQsBCcx1A5ULadQ6Detbyo1WkGjBMSPEorkpWeegMqi6U8e9mCRM?=
 =?iso-8859-1?Q?NxkuHBOh+J8HVICZ5ZOIqwzE4qYjBbBl7g/tZMUMZVBJGBzvMgClAZdCAv?=
 =?iso-8859-1?Q?ZQDgPPDelTa6NDh3NqDtD22amoV1RSsw4VSN2c/TuVvo/kagtULUhUh/lc?=
 =?iso-8859-1?Q?EgmEXaXbeMM3U1K3eDeqd49Z/bLi+D/VJzc5spk1jObJHUdW83Y4yMlt8w?=
 =?iso-8859-1?Q?s/TZz5pZIIGVBc+IAKN3ixwXKoR6WdDheT5q9BWRsouAmVkimidLV4y/mU?=
 =?iso-8859-1?Q?evu65itUYn7dHVopXxomnjaODd4quPW/yei6KLm3oDHH0C5Axn9iuEOC/l?=
 =?iso-8859-1?Q?w/rICQABxkJKLbcffRBQ/twj30WScraHd9t9WjBTcPMX19l0ceJxbCC0w+?=
 =?iso-8859-1?Q?OqNjlbeRXOGD/mK6fAY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 955db382-0cbd-4b8f-4a85-08dd1dd2e91f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 13:09:45.0491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFJ1V6mCAioPHYXVXC0cY9pvbZ8L5N6ktgAg8A0Zm1YNClctdXpHdQmptwliPpKwH+NTBdrlggbXQ+SepaOeNEv49cTEwNNgKSDXtL2sxxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6471
X-OriginatorOrg: intel.com

On 2024-12-09 at 11:19:32 -0800, Reinette Chatre wrote:
>Hi Maciej,
>
>On 12/9/24 3:09 AM, Maciej Wieczor-Retman wrote:
>> 
>> Sub-Numa Clustering (SNC) allows splitting CPU cores, caches and memory
>> into multiple NUMA nodes. When enabled, NUMA-aware applications can
>> achieve better performance on bigger server platforms.
>> 
>> SNC support in the kernel was merged into x86/cache [1]. With SNC enabled
>
>Please note that this work has since been merged and can be found in
>kernels starting with v6.11.
>
>Reinette

Thanks, I'll correct my statement.

-- 
Kind regards
Maciej Wieczór-Retman

