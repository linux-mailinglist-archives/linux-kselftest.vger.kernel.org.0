Return-Path: <linux-kselftest+bounces-4176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D380684AD5D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 05:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E9F2B21AB9
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 04:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71B0745F8;
	Tue,  6 Feb 2024 04:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VmNr6Pnu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2983473188;
	Tue,  6 Feb 2024 04:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707193044; cv=fail; b=pni/bccaWuFMwp19Dhet9h7tjL8omd3OplUCFfMTpnnMys4I+hzIMemogZxeuD3iBhyk2TzMcDu4ZsRZ9uAjTp8Jg452I0S0LbA/nw/yAlI3iAdTJtBhc1pNCFKbFPkAU/w+nBJTWLyOGFSVea+q3iDpda4Fx+7vPa0khhpWWl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707193044; c=relaxed/simple;
	bh=16d1NejEJbLnDuLJcXNHl+UhZMI465N1e3JS1taQ6/k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UrxC5Ib/EQAWM1L4hlm4j5Iieo3o+v5TzMNGj3hFGO4ao5lmQhklN6I3p0oa9oLE0lhfy95ANxI4yYIAWuqbvIU/e+LVlWR1+UjPRdeDsdmGCfzq8H5L/Z3T+wwRaEOeBgL8w1SRKg3z2Ch9nej7yMx0rgfdbQJTYYs5mirpG+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VmNr6Pnu; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707193042; x=1738729042;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=16d1NejEJbLnDuLJcXNHl+UhZMI465N1e3JS1taQ6/k=;
  b=VmNr6PnuiyRxoQ5mQtoiW5T2it5dhqa7rBtEIJ2ZxtUVLERP3Ckg6N5Y
   bNumSj9ePCH+/gOMdEBfA4Gus8GNpzw/jCW0YfIceAADm6WspcFyhT/xZ
   iTwaT3bDwVse3o8AVX9o3p8vNUL8gY0A9zvhoJNK00uY5kZkN9H/PJuiV
   Gu5E9KWV0TiwtAeDvWpA2Cvk+fkh4U9rXljK131SLHfHJ2wBctbJgXqUu
   DBSXe5tSGEaBzGMYTUctv1uDCYO3o0kGzHAY2/6BzVs0Nf9lmgDPALAbx
   qIrRuA/wB2XzM2smLUyi8dV3+vVA3Ma7GLoVDARsEA/3P+t7gObjVwoGW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="26107066"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="26107066"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 20:17:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="31717807"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 20:17:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 20:17:21 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 20:17:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 20:17:20 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 20:17:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9LOmnfUluMnH6xnIMex1Zdce5zFLYiRjEl0r2Qz8iqrR3XQmimefLFG5wAnRty8v/VXY9s9QNEzYqZzZqm2VTuS38VcxdvaBaRm3jt4plutnVJGLNqR28bBVYRKZ1IkM6nAKgTqB1z5QyM/YjCSZlwD7lS1nO910Bl1Ls1m2qRF7kjVJ/QT/Yg2NIo8/RV/5OsmCZrK8C/+9+qniSeQ8CG3cP6ZxVBRYSg7JRK0qjQEHJK1SEjEElYbWXncRzJy4nqDm4ya9oqMkB90tuJdXJl5iiZbomtmfxf/d+4a+CqzEYQIVavME2YHwVhHleC3i4er05n5UURfMk/o2meoKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+buj99fWYmUg1XPnvBDmxn31OOF0KjD8U1RrCCaT7UY=;
 b=E+l5kd0vxktmQcAG3Oc53t6WjSAi86fG/v27Iez5kX1seHKAP2AU2sPFH3rQMrvBdtKnVF9cVRSsBzBv7b+7sihQ+vfjavOmjo3hTHQ8T17gNG0evs3uvbDGZ0lFVIfkEbiu+0zuOTwC08JuDbkJPQb8CpSy/8GWDbklWTqscMvso3Nd7OUMM8xI5DF8XsBU2jLI5blv4qIi8EKgnO3BCUIBoyBnyMu00DlfbV4Pzw87jrNxysXvDXLd/GmVhxEbs5rUap7Xp/GY6Ain1xaw56c3R551RJ3qB7hbUp8MfGMSc690dq6YhaQngPd4eugpyqJJnSuzqR9NgM11v3YA0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7956.namprd11.prod.outlook.com (2603:10b6:208:40b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 04:17:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7249.032; Tue, 6 Feb 2024
 04:17:19 +0000
Message-ID: <a863439f-1897-4d72-bcb7-f4f8575c2a39@intel.com>
Date: Mon, 5 Feb 2024 20:17:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] selftests/resctrl: Split
 validate_resctrl_feature_request()
Content-Language: en-US
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <cover.1707130307.git.maciej.wieczor-retman@intel.com>
 <e4b1887682e8262a3416dbd7bc63695af0d63ee0.1707130307.git.maciej.wieczor-retman@intel.com>
 <65652533-8333-064a-c446-95232c7da76c@linux.intel.com>
 <zo7bbgj4f367g6bxpgyqs4tmkwqzimjqgcrx32ywoylrsc7v7k@kkqaqby6fueb>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <zo7bbgj4f367g6bxpgyqs4tmkwqzimjqgcrx32ywoylrsc7v7k@kkqaqby6fueb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:303:8f::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: ee019db8-2d8b-48ce-27cf-08dc26ca8227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3yw5CfYR4OG6xPEg8RrpaJsBE3EVOyYYUjQKyTMDelkc6Jk49i5xbH7CRRYagBGSwVn+35Uc48Cpd2GKK4MBzL520dvAFt10unQ1LCIYgpcEMeXk9CAJ2nZuJGPohqUPJbCPbrbnFwz+UYRup0ZhNNmtM9CiOYKkmLmxoNf5I1/GPvba4JL+0qHLjjF7CdNmeYFYiIfMJEbDs0pQQucmrelfFpENSj+On0BPAd+UyUpgfejAkOD07OuJ9s6/2ZDsnH4EfalVgamJBQKkYYNfVyYyA044klhJKDmAaf+kPfzt61hcc7imCUsEpBrNFlMPjHav6/TclTd+l+LCdE83fREWH7FPh5qz7qe6yx0Po2By80RIV5RcaJjVz7zhpUM9/JJm9Fs7BIN1YaOD/byShC2+xEpwXSNTxLPQSgUxZuokeA0nI9Tk3mw3QcHKlDGpd1XlIroPx7jZ70hSaaxiLxdJCRJC5+ZNAYYASgjotTaDecRkaq7B0FaeOCCIsDwZbtQU1bCXtTivjJ48QfhIaJ5ToJz+UDUawyCYs3TgIx1JmvGwy/jspRI54WrwdwydvYLXtBC2p3yXO5yIK9cvmYNQJiVvYlEJIsp2xa9ESOGPaY3PVY/W5kGlsI4ACaFm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(53546011)(6506007)(6486002)(966005)(478600001)(66574015)(26005)(83380400001)(6512007)(2616005)(5660300002)(44832011)(15650500001)(2906002)(66946007)(66476007)(66556008)(110136005)(316002)(38100700002)(4326008)(8936002)(8676002)(82960400001)(31686004)(36756003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dldqd1YrL0loL0VJaTFPVGhONVo4b3Q0WC9HdGMvb2NiYmdzZUI5cW5pZVN1?=
 =?utf-8?B?dGFoby81MEhhM3g5QUVZejZpNlgzZDFFT0RJOUhoT2JkTUkyUVdzUXFCVStJ?=
 =?utf-8?B?NFlwaTkzZ2hpb0gvRzQ0Y09tcFlKQk1sb1Jjbkl1NGJyc1U0L2EyT0lHM1BI?=
 =?utf-8?B?TjgvZDdFWHdtMldCTy9pb0o2VTJnZzhXREF5SGdZbzAwQmNleC9NbzBiR0JV?=
 =?utf-8?B?eHNPOGN4bjZVZURCSkIwZnU1TUtSZTVMdGFkRy8xMTFPNFhIcWkyRkVnVzJG?=
 =?utf-8?B?bVg0em5BU0NDalFuZm1GRHZKMWdIRFlIOEZDQUhWaHVvTG9YUk5JNHlBK2Rl?=
 =?utf-8?B?cSs3RFZjbks5SlovaTNQNEsyK01SL0MvZ09UOW92bXNyS0VlYW5QT1NMZjRO?=
 =?utf-8?B?OTRYRWVuZlRpQ3pYU0xQOVpKaHU0a2dqU0d0OEtna2cvQlNhbTVUNEFvd2Fa?=
 =?utf-8?B?NGRwdlF5Unl1QjFNQUYxRzRtaUV5TXZPOWN4TW9rQVVuZlN0UVpxTzRLdzdx?=
 =?utf-8?B?ZXI2OWJ1OWtURGd2SWk4RVlEZk90ZXZ1WCtoNXRoNmZTUWxhd0xBUzhaTFJz?=
 =?utf-8?B?YjhsamxxRWtyZGltNjArSjFST0lOOWZXYy9raHdrTDhNbzdRVGJ1Nkl6SFd4?=
 =?utf-8?B?dFpFaU1ya2Frc2wyeE5yV3ZwQmlzTURWZUhKdGtuazNyUDB1bXVCU3pUWStL?=
 =?utf-8?B?Qm9Xd3hPb05IZWlPV2hBenlSZTBNMEFTSUZBN2NHZmVtOUZiTXhnVFJyZDZI?=
 =?utf-8?B?dXBTd3libEd3ZWdlajFEZlVaRGEwWGtUdTBndXJka2ZoeVQzZ1JEak9Oc0Vx?=
 =?utf-8?B?VTJ3bDZ3bkxNVXR5dzNHbWJjbmlQMUY0WWpObWxVMnUvV0l2ZldMRnp5VHhS?=
 =?utf-8?B?TWRrYUdha2kyZ21iWjJOTTVZRjBQdjRudUw5TjlIRnMweXhuOFhCMVNjUkE1?=
 =?utf-8?B?dWtjT2NleERxVnVaM0xHTk9nTWVTMHY4dnB1UXljUjNTbkhIeFB1ZzZ2MTVo?=
 =?utf-8?B?TVJvc1FLMkdNMDNoaGJxKytqK1BYenJlclVsbUo4NHo4dDdRUTR6VGlPUlhX?=
 =?utf-8?B?V2hQcnV4Uk9LSVhUdVM4M1FmdGw3cGhVa2t5bFBUdTIvOUQxSUJ3dldHeVd0?=
 =?utf-8?B?VDNlZWQ5MC9ka2o2RE5rUmx0MVVYa1VoY1hSNi9qN3RURE5rcytVdVNic1lv?=
 =?utf-8?B?aTJGbE5EV0pGVDhhMjB0VWxWa05WVW94Z1NPbjZWNlhmMktlbWtLQUV1VW50?=
 =?utf-8?B?YmE2QUU1WC90bXczVzRiMEdXYjIzWXN2a0prbE0vZ2dNdFFNU01iUElHS2o1?=
 =?utf-8?B?MVhsSzRoTkxaT1NJMlRqam1INEFVQUw3VU5naERGMUVINGdoU1NSTEphS2JT?=
 =?utf-8?B?WEFGYTlsUVQzWEZMdWNJSERiMG0vSk1yTWY4MWw0NCtGbkZqZ1ovZDBEcHZn?=
 =?utf-8?B?NFlueGQ1MXNkL0YycyszOFU3dXVzUkV2clM1SVI0R2x3eWxSYXFnWmpsVm45?=
 =?utf-8?B?ZEMyM2NsQ3B1M2E1TDU0MHZ1anlTMUlveW1QWWx0OFJQaFFWcHlzazJDd1ll?=
 =?utf-8?B?M2Z6bGFzRjFKQlNzYUdGSFlhVzkwYTk0M0JEUkw4akVMQUxxdmRkUHYra2FK?=
 =?utf-8?B?UG80Qnk3TzJEN09wTnN3dzFOSFBaQlV5bUZzV0JKbE13OGsxSWFTQmZrK2V5?=
 =?utf-8?B?ZHhkME1IWjkwN3ZXWUIyT0RTb0dGWnQrcHdCNiswUkdzbnh5YWZPMjZqRG1Y?=
 =?utf-8?B?ek9qb3lnUW5RdmJSWHNjT21hYlVJRG9FUHZjdDY0bGd6SWF2bjcyVE9xSkti?=
 =?utf-8?B?ZnpNKzlBK3dkRlkyZXNlNGNVM3U0NnpyckEyaE1seWZXb2JZQ1V6RkJPandH?=
 =?utf-8?B?d0ZLVUNzeTJoQ3NrVjNjQkhIMFZ0K1R6U2IrZWw0TjdBVXFsMlNaRVVrSGxt?=
 =?utf-8?B?VUFSR2krUUx0dFRFc2ZURWdEV0tkQy9iU2hteW4reGJ6MlY2bktlNk5EcWFF?=
 =?utf-8?B?ZjQ0Sm5ldlRtNm0rNlhmamJnaU5oZ1NqYTByMjltOGt4c0Q0ekJSU0ZsRjBW?=
 =?utf-8?B?dHREVHk0d0xRYmg4eSt0bnlQN1FhcWsrWS9TcFZrZ1BPd3E3TXlJNmh3SHNG?=
 =?utf-8?B?RXJDWDh5U0NPc1lBdk54OWdRUXVzUUh5TkJJdUZaSVEzcU1sZ3lueVVsSFBM?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee019db8-2d8b-48ce-27cf-08dc26ca8227
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 04:17:18.9514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: riS4prenX9GTPS1rpT2QgYZkU9mCF44Dg1xKD4UgqAxHPp3mKdvO4PBu6+rL0tNyQxT56R1Q5jkLZ/J+AL8121GjW78jlIaKGCf2pc1g/O8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7956
X-OriginatorOrg: intel.com



On 2/5/2024 5:24 AM, Maciej Wieczor-Retman wrote:
> On 2024-02-05 at 14:41:30 +0200, Ilpo Järvinen wrote:
>> On Mon, 5 Feb 2024, Maciej Wieczor-Retman wrote:
>>
>>> validate_resctrl_feature_request() is used to test both if a resource is
>>> present in the info directory, and if a passed monitoring feature is
>>> present in the mon_features file.
>>>
>>> Refactor validate_resctrl_feature_request() into two smaller functions
>>> that each accomplish one check to give feature checking more
>>> granularity:
>>> - Resource directory presence in the /sys/fs/resctrl/info directory.
>>> - Feature name presence in the /sys/fs/resctrl/info/L3_MON/mon_features
>>>   file.
>>>
>>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>>> ---
>>> Changelog v4:
>>> - Roll back to using test_resource_feature_check() for CMT and MBA.
>>>   (Ilpo).
>>>
>>> Changelog v3:
>>> - Move new function to a separate patch. (Reinette)
>>> - Rewrite resctrl_mon_feature_exists() only for L3_MON.
>>>
>>> Changelog v2:
>>> - Add this patch.
>>>
>>>  tools/testing/selftests/resctrl/cmt_test.c  |  2 +-
>>>  tools/testing/selftests/resctrl/mba_test.c  |  2 +-
>>>  tools/testing/selftests/resctrl/mbm_test.c  |  6 ++--
>>>  tools/testing/selftests/resctrl/resctrl.h   |  3 +-
>>>  tools/testing/selftests/resctrl/resctrlfs.c | 33 +++++++++++++--------
>>>  5 files changed, 28 insertions(+), 18 deletions(-)
>>>
>>
>>> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
>>> index dd5ca343c469..c1157917a814 100644
>>> --- a/tools/testing/selftests/resctrl/cmt_test.c
>>> +++ b/tools/testing/selftests/resctrl/cmt_test.c
>>> @@ -170,7 +170,7 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
>>>  static bool cmt_feature_check(const struct resctrl_test *test)
>>>  {
>>>  	return test_resource_feature_check(test) &&
>>> -	       validate_resctrl_feature_request("L3_MON", "llc_occupancy");
>>> +	       resctrl_resource_exists("L3");
>>
>> This not correctly transformed.
> 
> Oops, sorry, I'll fix it for the next version.
> 
>>
>>> +/*
>>> + * resctrl_mon_feature_exists - Check if requested monitoring L3_MON feature is valid.
>>> + * @feature:	Required monitor feature (in mon_features file).
>>> + *
>>> + * Return: True if the feature is supported, else false.
>>> + */
>>> +bool resctrl_mon_feature_exists(const char *feature)
>>> +{
>>> +	char *res;
>>> +	FILE *inf;
>>> +
>>>  	if (!feature)
>>> -		return true;
>>> +		return false;
>>>  
>>> -	snprintf(res_path, sizeof(res_path), "%s/%s/mon_features", INFO_PATH, resource);
>>> -	inf = fopen(res_path, "r");
>>> +	inf = fopen("/sys/fs/resctrl/info/L3_MON/mon_features", "r");
>>
>> This became less generic? Could there be other MON resource besides L3 
>> one? Perhaps there aren't today but why remove the ability give it as a 
>> parameter?

This does make the function less generic but the benefit is that four copies of
the same hardcoded parameter is no longer needed. In my opinion this patch thus
makes the code cleaner but it is not a requirement that I will use to hold this
series back.

> During v2 discussion [1] Reinette made me realize this functionality only
> interfaces with L3_MON/mon_features file and the 'resource' parameter isn't
> needed. The 'mon_features' file is only mentioned for L3_MON and I don't know of
> any plans for other MON resources so I assumed it doesn't need to be generic.
> 
> But sure, I can make it use a parameter if Reinette doesn't mind.

I prefer what is in this patch, but I will not object if the function
is changed to take the resource as parameter.

> 
> [1] https://lore.kernel.org/all/2o7adr2cos6qcikcu7oop4ss7vib2n6ue33djgfeds3v6gj53f@uu45lomrp5qv/
> 

Reinette

