Return-Path: <linux-kselftest+bounces-22511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F01F9D8C93
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 20:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A7F2B23D6F
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 19:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0191816CD35;
	Mon, 25 Nov 2024 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bbkuyOut"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3201CD2C;
	Mon, 25 Nov 2024 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732561345; cv=fail; b=PJtlKV3VuxhkgyIxDRI21TFVrsPjw6UNL57XCakQL8A3zIxSiKHszsM/v6+WEP/TN+b9kzbaAXdP6JfSmhTfajHpgRvqI0Ep0bYmSdtQsGwDjmHZS9X/MJUozsMoBdl7LHu8fYn8HDvKtV2TrRMql9bUB2U3V1lTiotC2j/Pi5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732561345; c=relaxed/simple;
	bh=e+aw/tVlToSZhmMl1iNnEaokMfhgNAWtIgTXI2XxMfI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PO1jjSGLnz9wWmJPatqT4Y/Uxb7J+EmIN+P0jt0Yb6JrohQBXvW+UKe0I1GxavPwLCNhYYy7zHOcAdEhGcPQwOPcc/7YSnF2ZaN6v8OF7kaZG1CGrJNpACqjcH+nLsFLzzANw+7bAnJsIbtC4dyJ4UgA+p50fh5MGf+R9JFOgyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bbkuyOut; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732561344; x=1764097344;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e+aw/tVlToSZhmMl1iNnEaokMfhgNAWtIgTXI2XxMfI=;
  b=bbkuyOutWwgA2y6q6mlEXFEG3UwwsGS0Q8HypDUzLEm+UXTQwByc3vJM
   /W4VD5OcDT8Pw62FNWMPE1F1QNXNvY9EQChXE3dDJDlH9hA5KtPhL3O/E
   GEdJNVGAnELKKxtXAfXiHda45L/3HY/dtuWlDC5KfalBl06jLUd4q823p
   KHfAcpbzvUI5DydbUXcnuMoczvyF88VEygakm4IvaSFkTnzcpJeyXlPg7
   VJMDOR/4Tm7BX4PIWMossOzItX0h6rl0DmO7ekgobj/k9dFvroJZurDif
   1+E6gL5CRWkpD0eEpKJqy2LwkieZDLCS2MbdKg/oxucfAxuw+vMojibyr
   w==;
X-CSE-ConnectionGUID: 8mBlLPeqRUGw9e6DIYOoHA==
X-CSE-MsgGUID: AOzXaKyNQqOVwzOFun+6Gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="32632813"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="32632813"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 11:02:11 -0800
X-CSE-ConnectionGUID: vLoBA05DQ92g+Oh7oVdGqg==
X-CSE-MsgGUID: nLwQq5IxR/2JJ1+hfNlD2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="96140175"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Nov 2024 11:02:11 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 25 Nov 2024 11:02:10 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 25 Nov 2024 11:02:10 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 11:02:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9GdIPV/6GRhosrFm9veTSrEqgl3a8QZ6wiyftJohDyqAPsKCSHKgPUYQfI0PG/0Ai3FkhcMvVX/T8VaMXaGp4QdZSl7zK7Lc1WEJpuykD/ZKJlfBH/kdUvS8TQ9tJUqbxW3tnwxtlAUmDY23zwHdVc71Hu6Nn+S/Xt0c52PdOWFfrCySeD38cau9hVBsbGNp3Sr+gYPkPx41Xoop5pMrq+lSzX9EjJTdn+i+m0D2dqH8K9fRGYI2A39g9J6xnRw4kHLl9ItqTxpb+m5ToHh4+v4owOII50IkLnJm054iSZ6aZJsRESQzF2txcMBmoHNEwYO0jvr8vpzUJjPqZDckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ef67vdxL3//jUVTWsxJsnNbH8F2BFXsFyExDVcS+9+k=;
 b=ixYX3Xehm3FmjeOtPhirivBXirKehTIRqxdM9nQw//RYaFUHreGG34XDkt6hxhnFZWEepgyPgT5RAzaQmherHnajN1/2yNKDl3ZT1RCeb2CUb9datcPVKqcj82I50gENx6L2dUsdbrfRRl2vsbGCeEu6/pWYtUFunEFJdmHeG0MIds0Zx8M8QeST+z8vWcYICRM+Jlf0vEqj1zOAWtuo/GfJv1ka9FyERoM0tYcFl7+HX1axj8SVMWE7MUneev+94sS+de44TlHKy/ccD3qnkOmlZIUVybfkz1hyvZ6TR1WP0Lkctyz27+oZ87IT2cqo8Jk3bcWw/XLnYTHMVszt0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by BL3PR11MB6337.namprd11.prod.outlook.com (2603:10b6:208:3b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 19:02:07 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f%6]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 19:02:07 +0000
Message-ID: <44a203f1-1712-48f9-983a-dc49e40a3139@intel.com>
Date: Mon, 25 Nov 2024 12:01:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] net: ethtool: only allow set_rxnfc with rss
 + ring_cookie if driver opts in
To: Edward Cree <ecree.xilinx@gmail.com>, Gal Pressman <gal@nvidia.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <habetsm.xilinx@gmail.com>,
	<linux-net-drivers@amd.com>, <horms@kernel.org>, <andrew+netdev@lunn.ch>,
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
References: <cover.1731499021.git.ecree.xilinx@gmail.com>
 <cc3da0844083b0e301a33092a6299e4042b65221.1731499022.git.ecree.xilinx@gmail.com>
 <871a9ecf-1e14-40dd-bbd7-e90c92f89d47@nvidia.com>
 <b0f84914-c4bf-9071-b72d-cc2cc4a517f9@gmail.com>
 <d986d2ad-3ac6-4357-a8dc-e83e3622efb2@nvidia.com>
 <6ab56991-1415-4009-a630-14a0b709583d@intel.com>
 <1caf318c-db83-0335-4580-2ee21ff8940f@gmail.com>
Content-Language: en-US
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <1caf318c-db83-0335-4580-2ee21ff8940f@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0314.namprd03.prod.outlook.com
 (2603:10b6:303:dd::19) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|BL3PR11MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: 2610d8ff-c8e9-4da1-fec2-08dd0d83a835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2NLVXNHMjFza0FEUDVEYzRkemtCTFgwT2p5eVNFeFIyU1YzR1BsNjZrS045?=
 =?utf-8?B?aVMzNGN5aFdGWmJMWnhuS3hUQmYzR2lvV2oraUJMRWM4bDZvNi85eU5HVWZS?=
 =?utf-8?B?dCt6WkhsdGFtRkNQTThPRXV1bHJ4V0ZkelllNmVtVUpwdDVZVExRQUNiVmli?=
 =?utf-8?B?YTEvdkttS3dUNnoxaE9sODg1Mm5OOHY3c1czNDN6MXQyNUdqMkhLVWdodkd2?=
 =?utf-8?B?aXpIbldZNktiMk5VVUVoOFA2c1Q2dVl6RFp6eEFXM05XYzNVMXhhc3hUM2dz?=
 =?utf-8?B?aGpqVEkzdTl1L2habW5UU3RwOVBFWUdYT2hZZFRhMFNWRDRLSThUL0NIVkda?=
 =?utf-8?B?OUhuZ3lEbzBkSEtDbE12US8zek9nTnQvWmRPZjZjZ0EyWFdUNkE2WFdzM0h1?=
 =?utf-8?B?b3VpNFRJY1QxTTN2WGRhenA1TG4yWTcvdmd3UUxqNTg0cTh0RTFaMGMrYWRk?=
 =?utf-8?B?ZjY4aEN2ZU93aW9aTmtjM3Z1SmRKN3NOZXRZNHpJN1kySFlnRDhkTzRnZFkv?=
 =?utf-8?B?dks3U3NxSTFodTRmSHhnZERuMDFmUkp3OFB2UGZPQldpdkoxK0ZVWUNHNTFm?=
 =?utf-8?B?TTJNR3FWWmJ3VGRBVTJnMWxUaG16YnVpWDR2Y2xNT2NudmlFdzBkRlRVN2xz?=
 =?utf-8?B?ZlVRbk12WjVxWm5UbTNrWmc1NFNMRXJHT2owSTM5Z2tnNnovQklqSGhLcXpk?=
 =?utf-8?B?Um0yWmdUa0pEYStXb3RQMFFZdSt4T0JFWkZkWEVUTnNwNnBUL2U1cUNHZ1U1?=
 =?utf-8?B?NjBtQldORDIyMk9xL3VQR1VqVUdReHNiUjVRNGJZejZZbGNjaU1SdHhYdzU0?=
 =?utf-8?B?bHh6K1JXRTllU3N5Q0FmbWJQbWMwSXErK2VNK0xWVXZodU5GT0NRT0YxNmZX?=
 =?utf-8?B?TUViV0dzdXg2aG5WVS9yRzdvczFBVW1hVW9EeDVPSjVsNUZROUw5UzhVTTVo?=
 =?utf-8?B?MllwSDVpU3hiTUhvSkJxV2lOd0FHMTZnWVlOcklFOUlQbU1YZStka25idm1D?=
 =?utf-8?B?T0YxWDZ4Q3JVcnpEaXJxTjV6N25Oa0VOais4KzhvdHZ1NXo3M2tOWWZIemhk?=
 =?utf-8?B?L2xVc0lOS2MvOTUyZ09LV1pFTmlCSTlpOG52OWJmNnYvZ05wN3VJbXpVUWNp?=
 =?utf-8?B?T3lKT0xSa0wzeE1jdGN4ODJweVpWTGFkR2kzVWFNWGRYT05Gdk1MK2VHdGl1?=
 =?utf-8?B?SkpxUlczRys4K2YzSFI3UVlva0pBczJ1SmRSVUVYcklCcnZLRTRMU3I1S3BE?=
 =?utf-8?B?djBGTmc0RmV0M2JCeVJOREc0RndvUmJvcndZV0VMMzhyT1l4SXVDcFNPQnZO?=
 =?utf-8?B?eHpHTW5pMEZpS3k2UkhXOW1aZ2tWVCtpUFUzMlp1SitPN1hrNVljR1VEU0Ji?=
 =?utf-8?B?Vm9OeGppUHlBVjRVb2JJMlczbkJQY3YzZGhsQ2pYSGtGWldXU05RbmFQbGJT?=
 =?utf-8?B?S0RtVzZKcW5OT2tiNkt6RVFLTnpnU1lHOVgvY3FhTGdsc1pWSHlMNyttV1gy?=
 =?utf-8?B?ai95SVJOMWloRzB5RFRiUVFvZkV2REpjdCs5dVR2RnNJYXUyOGhrU2lUZ0to?=
 =?utf-8?B?aXhUeXIweUVmNkJ5YWlHcmRhR3B4dTRrVUY4Zzg0S1BnalhLOEdPRmhRNlVW?=
 =?utf-8?B?LzM4S0t1UkVjVzUwUEhxQkRFaXdXWHFQcGZOdHNFRmpxaVBJdytMWTBML0JH?=
 =?utf-8?B?cThwNTVVVnpTTGpOK0FZT0VxTzBUQmxlUGNGbkpkY1ZIcStKOTMzZE5jNXMz?=
 =?utf-8?B?endVN25WWkdaQmtiQWdDSzRDWStxL3ZXY1F4TVpPMTVHelc0aXRUQ0U2SHdH?=
 =?utf-8?B?ZE4xVTRIUCs5S2ZRalhlQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTFRWWg3UW5nTGtYNlVDTUVzZHdnMllVZWtCRjVNMlZaMTI0bURlWUE3WUZL?=
 =?utf-8?B?cG9sTTl2UXBwWDdwNjhpdGdqVDVoc2RRMUlLWGtZa0QwRC9XNEMwNHMzTE1V?=
 =?utf-8?B?UmZsZEZlTExuenRVVkQvWFA5SXZCRUlFc05RNWtyVWMwQWVqejY0SG02bmRS?=
 =?utf-8?B?eHVXT3AreEZmYW9uam5aQWVKWmZJcGwrL1k0eWxDaER4U1lOQm9QRDg0bXlF?=
 =?utf-8?B?TVJLVUExUHdycVgySTVSMmF2aHNPNk1wbXJuU2FMb1pZSW91V0IwWVhocm1D?=
 =?utf-8?B?YUUxYTIwWmkvOVdnLytBZUE3K0JUV2d2OXpnaXJkMCtIbFdmU1RBRm5jb002?=
 =?utf-8?B?bnZUOTZoNk5TSUNySWJSNzkrbHBCNDZtMjZWTGdoOXdrT1RQQXJOZDNPOUxM?=
 =?utf-8?B?dFY1TjdvbDVWYmFYOVd6U3JRL3E1Z0EybCsvMXNFR2V5YWk3dnFmUncydTI3?=
 =?utf-8?B?U2JqQmlzamY2YURNNmRRcTRHNnpreEJ3eXNHSWVkdS9MN0MxWUFxMVp2UCtP?=
 =?utf-8?B?Zzhwek9Nd2lPL3Q4SUJjZVdxQXROTi9vQmhsYlg0b09JR2xzeE9mRTRPUmpk?=
 =?utf-8?B?QzRkaG03K2hDMCtDaUc5dkdRemtIY3dBOHZpQ0tzUUFnTnpEb3FOS0Rha1ZI?=
 =?utf-8?B?RXhVWHYzZTBJNEFtYjZYNFZnNUg0ZFdzZjFsOERqOXB3ODlsRVVpdmVlR3Jt?=
 =?utf-8?B?b1lXa1daelhNalA4czNLc3c5L011cW9IQU1zcXpZbTQzRE1iVnU0YnJTNGtV?=
 =?utf-8?B?MTd1bm9sN0NhaUhyUmV3SCtBMkFSZml0Nlh1c3lJMjB1SjUrUGZZSFhYOVZq?=
 =?utf-8?B?dFJIcFlyd2JBZGZSZTh5RitFa2FSMXBuVWxSYlF3RlJadS9TaFlwekNNcE4y?=
 =?utf-8?B?Z1RjVFF6RlU0N1ZvNmszTVh2LzNOck45c1kwUTR0TVA5VllHdzhBZEloYTBj?=
 =?utf-8?B?cDJsM1NwM3cwa0Q3bG9kUTRYS2MyYUJ0Y1ZHNUkzVGF5Y29mUHRrTFZTT1VK?=
 =?utf-8?B?UTRNOUh6RkNrSEJSNk9NRER5V05xU1d2b0pFaUE4STY0Z08yTUtXSmFlOEl4?=
 =?utf-8?B?ZkhneWRPd1FwM2J4WUpoRnZmbEUvd1QyZjRONVJURzJoeDlGQ2ZHZ0l2QWFG?=
 =?utf-8?B?V054NGxQcExBRm9LdlJxRmJLbk8wNlN0ZlFaQWRINXpGSWRnQjVkeW9NUlhw?=
 =?utf-8?B?N2VuWXgwZVpoSmZTY24wVlAwbjZTT29uNitDK2ozWi9Hd1FHMTFoUU1kYk1u?=
 =?utf-8?B?M0pUMmVuYmpIbldhVEh5ekZteUdmbVpQbk14TmthMmxoVzFNYUtrSWlYYi8v?=
 =?utf-8?B?V0k4RFRyV3FGREpjeWZLUm5ONTY1UklBT3ZWVVBqYjRrS2dQQWRacU01VzNn?=
 =?utf-8?B?NXZoU3FGd0RqckkrTTJJdmZJdGI2KzVPdTlTclkyclNuK2tubElvQngveDRH?=
 =?utf-8?B?aXlkZ3RHeE5rSE95WDhJVkxUVTdNbDFLb0kwdjlsNmV4RTRJVVJmaEs1b1cz?=
 =?utf-8?B?a1hnMStFK0U3YXNqcXozaXVzV09IR1FlYVN0ZitPbUJkVDNneGMwWGI5SXhq?=
 =?utf-8?B?MmlrdWMwbUlJZDBxaEtma1RNYi9obStjOVFMcGw3NlZ2NmRjamhYL0dkbnFB?=
 =?utf-8?B?NEI0QzR3RXpsQzZPL3RYak9GR29wMWdiN1BBNzlhVVFyTXh5Q2d4OTRLNmZy?=
 =?utf-8?B?Z1IxbWVGVXdEcTdFS01uYm5BRDMwYjBjc3Q5MVZ4T0RnKzFKdHBLZk5ZMk5F?=
 =?utf-8?B?N0pRWkRBcEt2S3pvRi9XSlJjSDhsNHNhcGRiZ2xVUzJUaUl4ditKWllnWjZm?=
 =?utf-8?B?c3BqWmtsRDE4R2wxb2xXTEhqYXZqY2FYaFgyNUtGU2dVbEhGU2VPdUxzYTB4?=
 =?utf-8?B?dExVQ3EwZkhTUWJLTy8yWDZ1VXI1R0FqQ1ZmY2NjaFFPbWZWdlF4cWwxTWk3?=
 =?utf-8?B?SXkxS09DNTVhbnFOcklwUGtNWU5DN0UzRkNKUFI4WmM5K2t4YjR1M1hIdjlW?=
 =?utf-8?B?Q2lZbUc0eUVwRVVwTVBYYnpHNmdrMmtLODZQZ3k5Qm5UdkZ6SWVQWEpYRVFY?=
 =?utf-8?B?eG85aUJDQWlZM3pTSW1IQWE3YU1yWCt3clYwOWhOR21QcVZTcjAxVi9vcWVV?=
 =?utf-8?Q?pGgHXo46Tp14Djt23E5iCeUoO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2610d8ff-c8e9-4da1-fec2-08dd0d83a835
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 19:02:07.2797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5QYlYK4nPhoWfC30eSHcB8g5y41JxJ7Ca+7gsGmQhR0Qku1RYS4ao/d5Hhew4jqMf/N9UeD7r9k8oG4bSGstA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6337
X-OriginatorOrg: intel.com



On 2024-11-25 7:42 a.m., Edward Cree wrote:
> On 25/11/2024 14:20, Ahmed Zaki wrote:
>> On 2024-11-25 7:10 a.m., Gal Pressman wrote:
>>> On 25/11/2024 15:21, Edward Cree wrote:
>>>> Also, the check below it, dealing with sym-xor, looks like it's only
>>>>    relevant to ETHTOOL_SRXFH, since info.data is garbage for other commands.
>>>>    Ahmed, is my understanding correct there?
>>>>
>>>
>>> Speaking of the below check, the sanity check depends on the order of
>>> operations, for example:
>>> 1. Enable symmetric xor
>>> 2. Request hash on src only
>>> = Error as expected, however:
>>
>> Correct. The check below is to make sure that no ntuple that does not cover symmetric fields is added if symm-xor is enabled.
> But symm-xor is about hashing, and is only relevant to traffic being
>   directed by RSS.  The user should still be allowed to, and the NIC
>   should be able to handle, setting an ntuple filter (SRXCLSRLINS)
>   that is asymmetric, to override the symmetric hashing for selected
>   traffic.

I agree, and in its first version, the sym-xor series was setting 
sym-xor per ntuple, not per netdev. So the NIC can support different RSS 
functions for different filters. Unfortunately, this was then changed to 
be per-netdev during review. At that point, these checks were added in 
nxfc path.

> symm-xor should only constrain RXFH settings.  And in fact even if
>   you wanted to block asymm ntuple filters, the current code does not
>   do that, since the info.data fields it looks at aren't populated for
>   ntuple filters (whose filter fields are defined by info.fs).
> So the xfrm check should be under `if (info.cmd == ETHTOOL_SRXFH)`.

If it is not, then it is a bug. I will try to test later this week and 
send a fix if needed.



