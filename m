Return-Path: <linux-kselftest+bounces-6398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 470B687F1B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 22:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2988B21D47
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 21:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D5958123;
	Mon, 18 Mar 2024 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2OVScU3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB990250EC;
	Mon, 18 Mar 2024 21:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710795859; cv=fail; b=cqQ0A4xU/11FbExBmT4tKGt53y1+621C1EvCnZt9Bi3sLj7CxPiRUsbKfZjeQ+EbapR+OAy68xQ7cWxbdOqYzsb5Nguxdb4zbkYDVk7tqLYaEC0ubm7hQDGzX/9KIrnatgE7wH2o+cFE3PnZXSYVfPuGJ96oKYFpBFcMnr1OdaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710795859; c=relaxed/simple;
	bh=6DuIiMZ54mkhyq4lnF5qVviEnhDMyMRPlRcEBk57r6s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oXeCQFJpONAS0i8CnTLp77zvzNyVGieWhGCXOCAoJ0k15y1cg9YLPOzzg3qLCYfReWf1cDcmXR6KWia1AwAwlZjxE0jAIn9nf/SGojz7bXCRYLoNvflGp8g+uh3Is18i2ssuWrkXdkzZ/ry6wmENOe99MNhuXEM698PhHwCUyMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2OVScU3; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710795858; x=1742331858;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6DuIiMZ54mkhyq4lnF5qVviEnhDMyMRPlRcEBk57r6s=;
  b=T2OVScU30uzBCZ3sUatRGWOBqBEibihvjZyAQGyJOiTeuRauUIuZNfPO
   BcuIFfnSMPlhuYxO/BbhC8NRBjOpycBtSGYAmgBtpMdyfKQ8bvG7Akcyg
   dLI1swHXbDR1pbY1qFHaoSuO7knaV8/7Wap7jb9bNhNK5uv6GvRZQH8Pa
   KGWJb9KFoVBMyPgRj2bqkyPZxXKyoMP7JM2bGAy1lFVC9zoTiiFhDsR6+
   jRxGFs8TNaBKnBjtIiBaYY5BASuM2AGFpoTynJrPCjDNghwjI+Ng9bGLj
   gS/y+CedvslhlHvP7Q+gxsbT0VHhnszKR+Kfu2CHu/rcPbXa/ZEeMfkky
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5500570"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="5500570"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 14:04:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="14054742"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 14:04:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 14:04:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 14:04:16 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 14:04:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOT5iJ0ugRBtIVrdXGLO8IOqqcj7EH3ODqJX83UQUHBTQ59V4BpjO7U2XUbbzDkvvZkyBskpZG6mt9meakQK6UPN84hNmwgSj+ZXiaoakTvhXsoXtwzWecmVYrL5u2Jf+9M1LdjymGCdBvbPdOl3bZYcyLo9Xtcs1o0o0jzsxj2Nn6iMG7Y3PI15nvSAminFrarfypT2jCL7P04ANltuH8A3zXYqWiTy6hqnMbkOttLME4uZcHOh+fl9WSzKCFC/Et5HpmLrrueXJhI07T+8cM3CllOEUDQ7excVGpujUcqKOGjhA8ETsvR7MgKm9G4x9/boFXqRZHPKsTof37ENCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DuIiMZ54mkhyq4lnF5qVviEnhDMyMRPlRcEBk57r6s=;
 b=YZiD6OgnsfPqiK4U8jIVh5uw2/hklkwoRXAzrbEB/iYQPNxbCxQBjeDfbulWxFDs5bvCac8H9SGWA3xG3wHUfozVon1AIxjpSkizoVuv9hThsPiTwz3cwZKeVJpCVUfHm/dKaJfhYl7cBc8/XWyGdEBVWhVSJ+c4smJ1MV2TB5Uxu87UBqyis7NCi63DXWk8Zumihae/5ZlnEPAX4yHohSUPSsTzByDFTsKJuYLEk8dQluc/0G8DL6IfmwgDiyZd2uN/997DLMu6ux+gkrVpJljVVaB64iPHQ4u+fWQS51eqXS66n8pJMXJUMj/TNQ3zSN+dW4UvlGX3hE/i+weePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW4PR11MB7104.namprd11.prod.outlook.com (2603:10b6:303:22e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Mon, 18 Mar
 2024 21:04:14 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7409.010; Mon, 18 Mar 2024
 21:04:14 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, James Morse
	<james.morse@arm.com>
CC: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Thread-Topic: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Thread-Index: AQHab7KwshA04b3b7kGAda4tCZ9C1LErPGXQgADHEoCAAIKhUIAAB+aAgAABPhCAACNlgIAAEarAgAAc2ACAAUZZboAK/v/LgATLiICAAAEvkIAAFESAgAADgICAAAPVcA==
Date: Mon, 18 Mar 2024 21:04:14 +0000
Message-ID: <SJ1PR11MB6083FAA69AF7F712B34CA292FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <SJ1PR11MB608310C72D7189C139EA6302FC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <o6va7b7rc3q46olsbscav7pla4hxot2g6xhctflhmf64pj5hpx@56vtbg3yyquy>
 <SJ1PR11MB60830E546B3D575B01D37104FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <159474e6-ef11-4769-a182-86483efcf2a6@intel.com>
 <SJ1PR11MB60832DAD58E864F99A16FCC4FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0393c4ce-7e41-4dcc-940a-a6bea9437970@intel.com>
 <SJ1PR11MB6083AACB10645E41DD3F9639FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <55a55960-8bb1-4ce2-a2c7-68e167da8bcc@intel.com>
 <ZepK4mtoV_J8-UbE@agluck-desk3>
 <eacdc287-24bd-4137-85c8-df055cfd78b1@arm.com>
 <ZetcM9GO2PH6SC0j@agluck-desk3>
 <88430722-67b3-4f7d-8db2-95ee52b6f0b0@arm.com>
 <47c28b3d-3b90-4b33-ba71-1e359d43238e@intel.com>
 <SJ1PR11MB60832422CBDCCDA580010769FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <6948784d-6a20-435a-8781-30f324bed472@intel.com>
 <SJ1PR11MB608303C5E0BEB42CAC5B02BAFC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB608303C5E0BEB42CAC5B02BAFC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW4PR11MB7104:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tu+tyH1hUUNgYgum+Z0ohnMcNcFO2liw/hVBomL0cxBJXb3OHBKML8AsFJs/YunQWopbTc+qwwt7JJruYG4+H+Z2iA2BOGmJiExmrb24DMY14u/Y4uBAzODGfj6qcua6845scaxoUL8QKf0nHFdyY4V8E2JONwyCaNVnWyGYzuNG9JY+QTB84SwT0uVwHnZZp3ktNAzyQ0QorW9S9E2KxNuH2yjJ1+eDOJF0IfF6EEvQlhITBSfWF93QdS7WWjCFIQCAM5pBYTLvftcjoh1u2p89GdWzZoF239oSqrpV6u+IAGiueU8AdCxUxyv6gP0sNyBd2GcUu3p6zQhy4ZawTauSN9pl70BAQCK3hfvoDP118v510A4hGtOVruVLWYijYqow3iEV3CsSMsFhlMIwKnNXOOtSHqC+degKUFx0kHQYvov9rBT9qF6jWjScox99GJbsvOxZYok41AoM2GKRKWfz28soqzGZVh5Wt9tjLRLVzF8kcAMoE0CnCuHKlOcfFJdUdVrltjK/d9nJf9V2+2A820LL+g81lOcIyVvnEx35v2f2Ek6vLyQcDinfvl8gTA4FG50J1lzoWLIz50iTIVwg0wG9OeMzZRgEmF00ndvWs3VJPYJGGAqf25/ui4/t/N8i3PVBiOU/A76qll+d/tyokZSklWWykxCbHrpTv0g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3o0MUdWS0NuWHE3KzYxQmVOWWV1SEtWcmo0Ky9nbm54dmZ2OU9pcjNLV2hG?=
 =?utf-8?B?SmRReitmaDF3bGZZWTFGMTgzanRYRXo4ZElac3V2N0UybzNnU2p2WDBRYUtO?=
 =?utf-8?B?QmYzM3FneXRZNStLSEZDejZxRUdJOTNHUW5LZmF4dDQyRjNiRDBIU0Y0U0Zr?=
 =?utf-8?B?cTlGTVhXeG9IRjBSVXkrSkNBWm4xQXVUd0pRY2hsL3hpKzJFVWZLYnVvekFL?=
 =?utf-8?B?N1lreDRFTWpKeGRoQmVsUDBHNWUxcjhicTZyT29ZVUlndEh4TG9DNWRhcG5D?=
 =?utf-8?B?a2dFdlZjNzErWGU3WWZ4UVNpZDc5RnpmRjZhNVRiS2hhUzFUdDNqMHkrYlds?=
 =?utf-8?B?WlQxdE1DMXZWT1FVam9ISFd3YlNRRVpxRG5yN0ZGL2QrOXZheEJSRGhxVi81?=
 =?utf-8?B?dE0xdHVicTBYc3d2UFI3RFhwTWEvaDZJZGFNVkl5azg4aHd2NHVESkJLdU9i?=
 =?utf-8?B?cGd1VGc1ZHVvak93ZnNhZlZCUFdVRWd0T1p4cW5yTEQxNkl0WTYwc1IvNmVi?=
 =?utf-8?B?ZmRLYUpNYm56cE1JZWhXV3VPVnpNTmpmS0NWMjd4Zy8wWVlOZlFYSS9GTjRO?=
 =?utf-8?B?YWg1bEFjTFZRcmZLS1prQkdudWlIVi94UzVNbGZFMVE2Vmg5eTNCNE1UeWpU?=
 =?utf-8?B?bitSZFZ6b1B2R3Z2Qml6S05rdWVFbWRLVjVpYXJibkdDc0V5SmthV0Y5Nmln?=
 =?utf-8?B?MWFURG1lM0V0V1I1TFlqbCtxT3I2TnZkaVlacFhpN0RTV281ZEZhQ2JtWTcx?=
 =?utf-8?B?RGY2QXVnUkR2c2VHZHcrSDRjakVDdU1SSEJ2Q0wzTUs3S2ZyaHB5ejhEVG8x?=
 =?utf-8?B?Wk9WUWlOY3ZGblZkeWVqRWtxTEFWTjNSKy9ya3doVzg1VEdkQ2F3Um9oTWI4?=
 =?utf-8?B?NG1DMGJXMWt4NDhTMTNSTmwzYkVyYUYxbTRmUnZBRndGcjhUZHZCbTN0djlW?=
 =?utf-8?B?cmpEdXAvMkdxekVJVzJVekdqeXkxNUpsZ1dTVW90RE9nMlBtVzIxdThPYk1z?=
 =?utf-8?B?Yi9ZWWU0UFpzT21pZ2t6QnFiUW5JOG94V3FjU0lJVmpxelNDdWlCRklTTHFR?=
 =?utf-8?B?TGowbTdhQnhwN29zTytjMnpWelltOEIyd0J1bXlBOEVPYzhJWTNQSWpPWTF3?=
 =?utf-8?B?ZS9nUVN1bkZjU3I4WEFldVhYSmkrck8rU2dxWmpMVXFXYkFCZ09qNnUwa1VL?=
 =?utf-8?B?ZTFnSSsyblZMOFVCeXpwQ0thbFlxKzgwNWVHdjRNYmcza01Zam4rb0pjaU9H?=
 =?utf-8?B?TUdpYTZ4Z01JTWlWVFYwcFgxQXBLQllmYXlrazBWVXA3V3MyeFUyK0dlN3dp?=
 =?utf-8?B?SXNCeVBRUW05WDlJVGZXczBDR0xQaEo2OWFUZUhGa1RHcFdIKzFheXcydGJD?=
 =?utf-8?B?UnFldnV2NmRMazNTck1WbUlGeDkrY2ZtSjBocEQvM29ycy9HSk92VkdZZCtD?=
 =?utf-8?B?S0NFMWxSam9TMTRmd2VKUitOTzkwLzg3bGJVS3NHSjIwUnBJRjJuMDNZMUFu?=
 =?utf-8?B?dFByTXBtNll1OWsybHpGc0lNdlJWMTBIQ0xvN0pVcXpadmgraUxqN1dMVTNS?=
 =?utf-8?B?KzRpakZTSG1TR2RVbXh6UFI4Nlp4bW5yNzJZSDdwbllUK3ozck1WaGJaVmVC?=
 =?utf-8?B?SzkyL1Z2emlRQWk3REJXNTk2ZVkwL1Zuc3VHdnNjOFU2cDdBUkxmQkQ5N3ZD?=
 =?utf-8?B?Vk1GN3MzTDJMdk93cThnaURBRVNOTnFUUy9YMFQ0UjVORDVoeWVvc29lOENP?=
 =?utf-8?B?ZlphWEtETU54TGxSWUorTTd0eXV2Q0ptRlVBWEkzWStlL3lFQ1Jvblo2NVBB?=
 =?utf-8?B?MmpuNFI1dS9aY1hFZlpyMStvRERQaUoxL1FQa1lhbW9JQlFaRmhFQXNJVDhu?=
 =?utf-8?B?UUYrUmgvOWpya3p5K2ZLTlBLRG5qUnk4S25scHZlajNJNmc2UmdybnM3aHhY?=
 =?utf-8?B?ajl6WG4xeTByMDZKWjZxS1lxUDlrYmpROGg4ZjZ4WG9BMmRDellLZndCYUdt?=
 =?utf-8?B?VWJodUg1czdkVjBNRnYxeUs1UWZtK3VaamxMNnNBQVVoa2RNaWI3ZzM0Y3R0?=
 =?utf-8?B?S2JEdG03UnZxcXNJTFdsZTFIQThjQjd6ZVh6Vm5GazBob25nc1BWSk9QTFFG?=
 =?utf-8?Q?WO88sp9PtweLyljimCZKzf9yp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e77249f-0b61-4f34-d3a5-08dc478ef76e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 21:04:14.1546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ovU9kr/EgNpevyEBgmryNk45Nc7+NeRMNXPGj2pxm2THVNWTCCB7mZChAgfm9HYhchFaPU5ZfePvUSPXjsJjxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7104
X-OriginatorOrg: intel.com

PiA+IFdoYXQgaXMgdGhlIHVzZSBjYXNlIGZvciBuZWVkaW5nIHRvIGV4cG9zZSB0aGUgaW5kaXZp
ZHVhbCBjbHVzdGVyIGNvdW50cz8gV2hhdCBpZg0KPiA+IHJlc2N0cmwganVzdCBzdW1tZWQgdGhl
IGNsdXN0ZXIgY291bnRzIGFuZCBwcmVzZW50ZWQgdGhlIGRhdGEgYXMgYmVmb3JlIC0gcGVyIEwz
DQo+ID4gY2FjaGUgaW5zdGFuY2U/IEkgZG91YnQgdGhhdCByZXNjdHJsIHdvdWxkIGJlIHdoYXQg
YXBwbGljYXRpb25zIHdvdWxkIHVzZSB0byB2ZXJpZnkNCj4gPiB3aGV0aGVyIHRoZXkgYXJlICJ3
ZWxsIGJlaGF2ZWQiIHdydCBOVU1BLg0KPg0KPiBSZWluZXR0ZSwNCj4NCj4gTXkgKHBlcmhhcHMg
bmHDr3ZlKSBiZWxpZWYgaXMgdGhhdCBpbiBhIGNsb3VkIHNlcnZlciBlbnZpcm9ubWVudCB0aGVy
ZSBhcmUgbWFueQ0KPiB3ZWxsIGJlaGF2ZWQgTlVNQSBhcHBsaWNhdGlvbnMuIE9ubHkgcHJlc2Vu
dGluZyB0aGUgc3VtIHdvdWxkIGxvc2UgdGhlIGRldGFpbGVkDQo+IGluZm9ybWF0aW9uIGZyb20g
ZWFjaCBTTkMgbm9kZS4NCg0KSXMgdGhlIGFuc3dlciB0byAiQSIgb3IgIkIiIC4uLiB3aHkgbm90
IHByb3ZpZGUgYm90aDoNCg0KJCBscyAtbCAvc3lzL2ZzL3Jlc2N0cmwvbW9uX2RhdGENCnRvdGFs
IDANCmRyLXhyLXhyLXguIDIgcm9vdCByb290IDAgTWFyIDE4IDE0OjAxIG1vbl9MM18wMA0KZHIt
eHIteHIteC4gMiByb290IHJvb3QgMCBNYXIgMTggMTQ6MDEgbW9uX0wzXzAxDQpkci14ci14ci14
LiAyIHJvb3Qgcm9vdCAwIE1hciAxOCAxNDowMSBtb25fTk9ERV8wMA0KZHIteHIteHIteC4gMiBy
b290IHJvb3QgMCBNYXIgMTggMTQ6MDEgbW9uX05PREVfMDENCmRyLXhyLXhyLXguIDIgcm9vdCBy
b290IDAgTWFyIDE4IDE0OjAxIG1vbl9OT0RFXzAyDQpkci14ci14ci14LiAyIHJvb3Qgcm9vdCAw
IE1hciAxOCAxNDowMSBtb25fTk9ERV8wMw0KDQpUaGUgIkwzIiBlbnRyaWVzIHByb3ZpZGUgdGhl
IHN1bSBhY3Jvc3MgYWxsIFNOQyBub2RlcyBzaGFyaW5nIHRoZSBjYWNoZS4gVGhlIE5PREUgb25l
cw0KZ2l2ZSB0aGUgYnJva2VuIG91dCBjb3VudHMuDQoNCi1Ub255DQo=

