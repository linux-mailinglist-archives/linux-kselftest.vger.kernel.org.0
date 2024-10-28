Return-Path: <linux-kselftest+bounces-20790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D449E9B2513
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 07:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039CC1C2039B
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 06:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8485418E37F;
	Mon, 28 Oct 2024 06:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="sO38OjBj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514C18E37C;
	Mon, 28 Oct 2024 06:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730095674; cv=fail; b=OhKfImnAfJz5oH8vt5dIsXhspB4rvpAr79dIV+SCunfAAwkBeDtRhTod/CNpZ86TlPIXHfHzd9VrmcZTzitumO5T2+cCthBzmPGfp2RbssdOwg7ebEocPOrgPQBHuTs1eGKBmbNZ0aCW7t74LZgOriop6oGKDjTm2DaIiCEtciY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730095674; c=relaxed/simple;
	bh=sjezG5YfwUV4s6SeB/ZVflfKOit8XEFq0LQ6MW1D8gc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RaWVVMYlHc3/YprM3ahp0tuOWjTl0FcSw9f91+UDzMQ3z0ouGDCTxNJUszDsoRg1tN/bCynXRwUKUuX4oUd1g2qGJ/D5mzqThXDsPOQ7O3+hzj4FDAF6mr/mSW+46Azu/0qWDW5Lb+zXhky9wR7moh6plJBtw8ewbIo8wdHaW4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=sO38OjBj; arc=fail smtp.client-ip=68.232.159.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1730095672; x=1761631672;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sjezG5YfwUV4s6SeB/ZVflfKOit8XEFq0LQ6MW1D8gc=;
  b=sO38OjBjWo7sf3vP0CCMpcxs+SOOy3Vo30Dd4VaLd1uo/4fR3G89WvmE
   a9TZX3D67Yyhq2+lJSlhelhH9zLz7H8p38Vahr1jIOGMY1qvpxPRtyfH4
   euC4hBBZM6ZCMOe7lK4hjJAexxqP4Scymy16y2sveCBV2k8Y7+h1zuZTK
   cgGvh7/6aGQPKtZSxfJ9WseR5nfZycbUQRNi7jkGlzG2iXHX9roO3GOWn
   3/izVDITgzmnw+ufQyC28qbc+jdviRgOslrSUOdhXUylGaiyLnOF0q0wP
   oXbpakeVyzuS44mLd4JKgzjjyczTYprv3CH0mCEix5ta6r2gBAa0UvLiE
   w==;
X-CSE-ConnectionGUID: KaRoLm22S1OH0hEkVKJLYQ==
X-CSE-MsgGUID: o+L8VqXcTPuAg13nw31tXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="135037191"
X-IronPort-AV: E=Sophos;i="6.11,238,1725289200"; 
   d="scan'208";a="135037191"
Received: from mail-japaneastazlp17011028.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.28])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 15:06:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQWa70yakcjQcEhUgDiNboX/G4DOfVewrYb3QYJdZrmAVzTaAfqIC8plJ0IO6ftbHJEuZihBmxNPc0UCXP5HxK50HmQICeZs3dfL50dmGJo7PvaLpMlhjqEXLozdw2XNsDDXwN8W3tGP0vC9mkIEUK4J3ViBjT7SB+roI6WDfqmwyPVrQgDjvmDkGcuFtKdfRaZBoJ93xgr7q/AaI0T9l7iYHmPGa4bBAX+jAkFRztgXOfdTIsoGVbRAk6hSWTVc8zQlNGXgp53c0k+zNxrC0RDIFSnEBxbKzIaVpNnnW2DszxOOFIaNwTgsbrthp7l2V7XW4UFfgnY/tL4w142Jzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjezG5YfwUV4s6SeB/ZVflfKOit8XEFq0LQ6MW1D8gc=;
 b=yGyvVAkGcQ7jCX/DqvCn9q0VsKbChr5QDgH7DvZDW+3LqEMJyOWwyaO3HZdNIFrMaY/zdkGVinAdt/GtZqgbvGul1b3U2a0uGPBQbQ18j5a0+/rWuiIgeh1siDnFajixMzimDHXpmC+pGnzS5nF+BXto3CENYcwbw0tr5EmeakYF4gbHaMOVvJa/YrjFMa1TapTq56hk1LMTp6ZhYa0iz/3RRqSA/xKGVO1tdzduRvw5/nXu8mha29aXGqlHA+yzVQPJhLsve+o4ElxdwKLN3n/acT7cHZr/u0lJr2LdeXnsS+oNg9DuCrozhrEGG16uuQAkFoOq9DkzekGVZfmaUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYWPR01MB11138.jpnprd01.prod.outlook.com (2603:1096:400:3f3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 06:06:36 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%7]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 06:06:36 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Shuah Khan <skhan@linuxfoundation.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
CC: "shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next 1/3] selftests/watchdog: add count parameter for
 watchdog-test
Thread-Topic: [PATCH for-next 1/3] selftests/watchdog: add count parameter for
 watchdog-test
Thread-Index:
 AQHbJn6pWUq1FBNyBUCuyGcWUIOetrKZwW0AgAGYNoCAACyDAIAACTkAgAAZB4CAAAPMAIAAAq4AgAADOIA=
Date: Mon, 28 Oct 2024 06:06:36 +0000
Message-ID: <6862e399-b169-4ffb-b9c6-904f99d96e56@fujitsu.com>
References: <20241025013933.6516-1-lizhijian@fujitsu.com>
 <c2cae7a7-1a0d-48ef-9b8f-8d2436532ea7@linuxfoundation.org>
 <0861d73d-4fd9-4118-91c8-5a619c7d7ca0@fujitsu.com>
 <e907e67d-9116-4dd2-9b61-f93191737de6@linuxfoundation.org>
 <b7b3deec-47fd-43e4-a9b5-7099e3c00623@fujitsu.com>
 <54cbf018-eba1-4227-b464-78bfa41fa4ae@linuxfoundation.org>
 <3ee0d14a-7f6b-4ef4-9349-d6b0f14ba9e8@fujitsu.com>
 <f10e8a78-3b50-4212-9b5d-ba99a3421379@linuxfoundation.org>
In-Reply-To: <f10e8a78-3b50-4212-9b5d-ba99a3421379@linuxfoundation.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYWPR01MB11138:EE_
x-ms-office365-filtering-correlation-id: 31f2c06a-f5d0-4d19-4f5d-08dcf716ae6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Wk50ZFNuWGJEeUc3N3pPS092ekp6VGNuV1BOWlFPVXc0S3VQVVhGbDFQRndq?=
 =?utf-8?B?azZIQzd0Nzhad3FVbnljdEgrS3FTYU4weVZmMWd4RkZldHhnNGpzTURQY3VB?=
 =?utf-8?B?cWpEeWZrZ2h5TTRXZUFRRFhTTkdzbys0M2JTVmNnM0RoYUFnQlZwWnVvKzZL?=
 =?utf-8?B?cHJIMmJHSnhpdXB4bGE3TEhsVmRwUmZiNmZoT2luVjRLUWs2dWlxZGxWRHFP?=
 =?utf-8?B?V0JOTkp3ajYxbWcrc2VqM1g4NmZCSXZLbEZYVzZCZGhGa1RlZFNGeFJodkN6?=
 =?utf-8?B?WFYrNkU1UkdXYTFrOGJiY004V2NRZkUxcDhKRWZwLzF5ZmNFTHBDd2cvYmZj?=
 =?utf-8?B?eE5HMWc4WHpvOXIrK0orV2dGZTMxV3hodFI3V08xYTROc25KSTZQdndNTUVE?=
 =?utf-8?B?S2hmdlYyYmFzVUJPK3JhdFMxQ3RLcWFzdTlTQ2x6bjU4MHdMdjJNdnoydUpa?=
 =?utf-8?B?SWNINnppRXJvWlpQNmgrMVlUTDlsb2hZdmdBY0VqeXNrRFZzamEyUmMyNW5W?=
 =?utf-8?B?ZmhndW54cGZNeFUrM1UxeHdkK3B4WDkvVVFGdWpnM0xocTFGcUhUa3J6M1Y1?=
 =?utf-8?B?SndicityRlBNRzJqVENQYjYzQVBlaXQvZURSeXFTOHZ3dGljQWdFREZ6Zm9l?=
 =?utf-8?B?SmxQaHFSQ1B1bk1rVU9wQXAvN2s3c1Q3THRoYlhSdnlyU3o1MkV4TE12TFlN?=
 =?utf-8?B?Sy9lQzBvUHBrUlBGM2dlZ2pESUhYUzk0UnlFT2JkK3ZTUS85THNzaDVFd0RB?=
 =?utf-8?B?VEUxRlhGNnFjYWlBcnpCY2ZrTTZQbXFySVZ3OEs2b2o0alZDR0k2cTJJeFI4?=
 =?utf-8?B?YzdVaUgzemV6REh0MDVBY1F0V0wxR3hPekJSYlZ5RTFBcWtxRkowNTJmWjU0?=
 =?utf-8?B?UVU0ekJoK2RPSjRuY083cXkxRGxTZkxsVVpjMGNEOStnODQ1azNaTFRLZDlX?=
 =?utf-8?B?YldJYU5kVUE0b05rYjFwSUlmdTRSNUx1cUpBdmtXdXlCeW85ekNhQmJOT2di?=
 =?utf-8?B?dmNrY1FHdFU1TEVPN1Q3aUZxTDlyb1VOWUEyOUlqajFUQzhOVWh4TG5OUENo?=
 =?utf-8?B?bUExNG9NL1pSWUhmd0kyOVpPdTNOenFSYzdFTEFOelZ2MFV4T0tFMVlSVGlV?=
 =?utf-8?B?VUFscm5PTjhCMjVsbXc1TzNueTcvN3JIREE2OGpQNktpRmR5VzNhVk9rWnI3?=
 =?utf-8?B?ZzZEa3c2L0I0TjdBT0h6cllWN2hvemNoRkRCTVFjQWZDc3VsOVRmck41R2lj?=
 =?utf-8?B?Y3UzRjRlNmI4ZS9LZnZCR011bnNwN3hnWUE0NjZ6UUxGcVA5NWpndW1Mdktv?=
 =?utf-8?B?b0lKUWJvdEhVc0wxNGgyZUc4c2UxZ05rOXk2WDJYMFdaZE1OZVYzWWViTE51?=
 =?utf-8?B?K3B6cmZ5eWk5cEpHZzNxOVIwWjVmcWlFRGhjemV5SlBpSnZSVzNkMWlrZkIz?=
 =?utf-8?B?Z3pnZHBmVzFQaE5UN0Z4NjFZUDdRMFduNUY0V2Jna3pHbytsWlZPTk01QUtZ?=
 =?utf-8?B?eHZDa2l2Y1o5OXhKSFNDdkNNQW1nMWVoeUVSY2VHREJUSGQxaGRQWlRDRXFn?=
 =?utf-8?B?SDRNdFVVWmJRSERIQkV3RjZnMzlYT3dzcWV4amYwa0Z6YVd3SHRYa1VZeHhr?=
 =?utf-8?B?UEg1R2xBTXBsY3BSdmZKU2lVNlF3T3ViVWl3ZkI2eXRDdlhJRzZIbDlLdUQ5?=
 =?utf-8?B?cjliMzFBaVlLeVhsTGtLYzBTMmZvOFF2S2pOVXZGM0hTZy9EVThZVldTVFJv?=
 =?utf-8?B?cDNpcHluOGJvSjJYdWJnaFk3a2tST3pUYU1MK01TRytTTE15eTBValpnZG1H?=
 =?utf-8?B?T0FlbFE5NnJiSHR3VFozYXcwQ2dPMUNCVUdwYzJyNHNCTFhBU3NrU2lydWMy?=
 =?utf-8?B?aHk0YW5DV2NuRnVwSkJjcnUvWGkzSzdDT0dvNzZkQ01ISUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?LzhrakZVRkF5YVZMQjlrQkMwbmZyeEhOb0ZaZHo5Wm56M1dTNFFrMVFabzU1?=
 =?utf-8?B?cVNmRmd3TjZ1QXhPUURrZWJCVG5SODBRYm5yWHBSdFE1Rmh0UFRpZHk0N0th?=
 =?utf-8?B?cHdPbGtwQlJXYVlwb2hMVGxaWkZTVW04ei83YTBSMEg4c2tvdTNzK0pqdlU5?=
 =?utf-8?B?SFl3UmlydXpIM2VBUXNWZkFlTVZpSStQMk12aXlpQStKcmIvY0RYN2c4RmRW?=
 =?utf-8?B?cVoxNURrMzc5TCtDZExZRHVBZnJmLzJnZXVTbC9VdDVMZUtockF2Q2pLOGJQ?=
 =?utf-8?B?TVFaRVR3REJzY1VyVHNONFNNcWlKRS9OZit4WVFUVlJ2aVVCb1poYXJMWUE2?=
 =?utf-8?B?cUhaWkNVSTdZUVVWSnVSNUozR1NkcXpVSlJUTjZ0WENOcDR6ckRGWnBrRStP?=
 =?utf-8?B?RHh5MlI0OFVoL3JYRUYwYXBTdi9DVnF2Q0poVGxvd2ppOTV5dW5aUHJmVHcw?=
 =?utf-8?B?ZzNLejYzaGIrK2xHSmVxRHZlMlNVU3R2clBnTHlqZWdkWTEyaUVrWTdtaVgx?=
 =?utf-8?B?QnY2eGhlMXo0OTBpVTNJWEtETDREMFJqU2o4cFlCajhvTlREZmUzM0k1VTY1?=
 =?utf-8?B?RkovSE0rdUlaUS8yR05OOHI1NXlla1JRZHdlQ1QzU2VPVHRDSjNJVElIeFRF?=
 =?utf-8?B?L2tFeWJXUXRSeFFvL0hTaC9zVFEraWVPNFEwcW5IbFVrSzZFRFd3YkFsNm1x?=
 =?utf-8?B?cUVzbFZnU3F4UkJjdUlBWU5nUlNpdm1SRm92UFN0VWtHZnlERjZDVW1pcytF?=
 =?utf-8?B?cjcvUFR2TjliN003aU9pYXp4Rm5nd3VyRXRLRSsrVnpDLzZJQU95KzdHTEho?=
 =?utf-8?B?OXVTbUpGc2dpT2ptcC9NMDBnSm9SNjBOZ1QrdXZzQSs1WVV3d0x5UU9oV3VF?=
 =?utf-8?B?eEdwSFlZeW9FOEtnK0JHWHA2a3UrQW5HeVJNV05qdGdkNFNRbE94MmFxOEdh?=
 =?utf-8?B?WnRZNkE1RElVeUlJTlhCYm8rcjAvUHA2YVQ5dTJtUjJkMGhrUjVhSGdKR3BE?=
 =?utf-8?B?K3ZHdndlMFVLSlVhR1lnbTJhRUY1R2lWQzhTYzllVllPTzVUZ1h5bTI0UG96?=
 =?utf-8?B?UG5YR2ZzN0xCeGlaVjNzY2R6dTI4SE5Zb0Z5aUF6endoMlZxcm1vSnhqaDZt?=
 =?utf-8?B?ZDhONjVmSHgxUTJoWVZlMzhDUTdIbzc3Y2w5Q21HNkhTRVQzRlJEM2wrVStU?=
 =?utf-8?B?MG9SR0NtSXdNSnlOak9nQmF5VU1uZEd4cm5kTC83bFlCUHNYUHRBOGlZbjc4?=
 =?utf-8?B?SHBDb3ZqeG5WdERMT3NrMkIyNlUzeE1RSEtZQUk1Z1AwMnRob2dNTEZmMWdq?=
 =?utf-8?B?cmh1TFBBSkpLcUFvMVhqRjNoVWtwR1QxOHlSYytpTzlUNUdUdDFnWHJNc2gx?=
 =?utf-8?B?ZjNIUFBRT2RERHJQb1JqZU10UmFCamFNMVpWeHAxQUZOWEZubmZpTXFSZFd4?=
 =?utf-8?B?NitBbUNUTk1BdmlQeXRFMDdQNFYwb0RtSU5GeERxNkYySDZiNlo3STNuZkFU?=
 =?utf-8?B?ZTNhb1FxYncyREZQd3d0eDk1aHF2K2EySzA5d0pJYUNIUSttSkIwTXlGU2pj?=
 =?utf-8?B?aVliYjREeHlxSG40YlRYU21SUHRMeWRQNjY0MGtvRXhjTkUxM041ZGExVk13?=
 =?utf-8?B?TFA1SU1vNGplTnZwblg0UkhVY3J0NDNFR3lxSE5xYXpVaUlEZ2RhT3ppTzN3?=
 =?utf-8?B?OTJhNUFhZ09FaHo1am5ZaVNtTW5OZVQza2Y4S1R1WWxteUFydFRtTCtzTmxr?=
 =?utf-8?B?L1ZTbitjR1c5dmxDbi96NU5kUnNVUXdmTU5oQkZNSlFPZ2c3eTY1bDY1Ritu?=
 =?utf-8?B?blFlT2tiM28wRHprWjhHTjBVZ2g2VmpIdU1jY04zZjZ5Sm1wRDd6ek04R2dr?=
 =?utf-8?B?dWgwWkJvVzJoL0EzN2pBTXJkN3VHbVVvZE1pa2Nta2RoeGk5dC9tWnpVWmpQ?=
 =?utf-8?B?YTZ0U1FoS1hUN281WmUwdDJvc1RKd2ViamhBWEwyUE5IVnB0Um5HTmdrSkRJ?=
 =?utf-8?B?anFXT1NhUkVvSkZZZ3d1NUk2YjF2Ync4NHFqQ0tZMU8wZ2Q1RUk4UVQwaUR6?=
 =?utf-8?B?RUY4U20xU3JQVHVKRjV5NEJISHdLaHFKQWZDbitQRk5aTnVYV1M1N0tCaE0v?=
 =?utf-8?B?dWVJUlU3Yy9SclBxRFNHZHdNTEJoaFQvTXRWOVZXNFFpSjNsVnlkWjhhMWlk?=
 =?utf-8?B?U0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C928F607D2F8D40AAC10C2ACB39DE40@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QP7JEko7kEPUlSq7kE9P+6ZPE5sMz+MZJYJBR799Ri8WMzF3SBdkWUUAVJ7mQipYAuyxnHQdmIp5po1aZr+Syt/+yBz7AFFAR8CNReGdaLXRoELFT1mTpf0hwULd9lZs7YJcyES3ZyH+hZZ/FKwVawlY3mKyWFRjySwFZpJX1x1edGous85QWHUvXD7MK3XHh1PUZ6IStTtNxS35Y+22j5bFAIbXSZCEnh/UPaRr08RR/GDwi3u4tgo5J7HREP12fQZAYKTeEJIGFdrpJYBUS68xIBG74WyaX0ZpOsVQKfvvmoQRXPmvvdLGeFQR5Zc9Dm1C3lfc+Mx5fTfv9TfIUneTz15WkgkOkhygwg0jJxbpLvUj9bcX4hVj97/lX+w1QOA/k/f84tNIwJj2cLqJKkUdmEfpOYZz5omR0KMAuHDjjEbgEpRzkaf7FZKCfHndoqYCD0DNhDZnbhByEW6JHNYDP/o0HnX1hqD2KURTtExdnI6qBhJe8UP6a5hsjBXc/wpxKorFa2RjT60Ox9ewmGzz3Z4t7Ph1BQFIMHk6O9STot8Rcjh8K9vip3cxLzPTxbf9ZulCwh44OUMS7wPp+hXlNS5CeFZQM2PfW899B4c2Vcxea4cUjcBLR/2JR7Z9
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f2c06a-f5d0-4d19-4f5d-08dcf716ae6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 06:06:36.7621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1wTr1JJCtxzqfGCCzqRR7gG/al+g5gTFAOLo3XIVC5f+Y4A9bQW5WMzw4SxFLGYkEAyJzsLB2vFBkNt/hhmorg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11138

bGludXgvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvd2F0Y2hkb2cjIG1ha2UgcnVuX3Rlc3RzDQpU
QVAgdmVyc2lvbiAxMw0KMS4uMQ0KIyB0aW1lb3V0IHNldCB0byA0NQ0KIyBzZWxmdGVzdHM6IHdh
dGNoZG9nOiB3YXRjaGRvZy10ZXN0DQojIFdhdGNoZG9nIFRpY2tpbmcgQXdheSENCiMgLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uIw0Kbm90IG9rIDEgc2VsZnRl
c3RzOiB3YXRjaGRvZzogd2F0Y2hkb2ctdGVzdCAjIFRJTUVPVVQgNDUgc2Vjb25kcw0KDQoNCkFu
ZCBpIGdvdCB3YXJuaW5nIGluIGRtZXNnDQoNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICANClsgMTk1My4yMjk1MTFdIHdhdGNoZG9nOiB3
YXRjaGRvZzA6IHdhdGNoZG9nIGRpZCBub3Qgc3RvcCENCg0KDQoNCg0KT24gMjgvMTAvMjAyNCAx
Mzo1NSwgU2h1YWggS2hhbiB3cm90ZToNCj4+Pj4NCj4+Pg0KPj4+IFRoZcKgc3lzdGVtwqBzaG91
bGRuJ3TCoHJlYm9vdMKganVzdMKgYmVjYXVzZcKgd2F0Y2hkb2fCoHRlc3TCoGlzwqBsZWZ0wqBy
dW5uaW5nLg0KPj4+IHdhdGNoZG9nwqB0ZXN0wqBrZWVwc8KgY2FsbGluZ8KgaW9jdGwoKcKgd2l0
aMKgV0RJT0NfS0VFUEFMSVZFwqB0b8KgbWFrZcKgc3VyZQ0KPj4+IHRoZcKgd2F0Y2hkb2fCoGNh
cmTCoHRpbWVywqBpc8KgcmVzZXQuDQo+Pg0KPj4gRXJyLi4NCj4+DQo+PiBIb3fCoHdhdGNoZG9n
wqB0ZXN0wqBrZWVwwqBjYWxsaW5nwqBpb2N0bCgpwqB3aXRowqBXRElPQ19LRUVQQUxJVkXCoGFm
dGVywqAuL3dhdGNoZG9nX3Rlc3TCoGhhc8KgZmluaXNoZWQ/DQo+Pg0KPj4gSW7CoG15wqB1bmRl
cnN0YW5kaW5nLMKgdGhlwqBjYXVzZcKgaXPCoHRoYXQswqAuL3dhdGNoZG9nX3Rlc3TCoGRpZG4n
dMKgZ290b8KgbmVpdGhlcg0KPj4gQSkNCj4+IDM0N8KgZW5kOg0KPj4gMzQ4wqDCoMKgwqDCoMKg
wqDCoMKgLyoNCj4+IDM0OcKgwqDCoMKgwqDCoMKgwqDCoMKgKsKgU2VuZMKgc3BlY2lmaWPCoG1h
Z2ljwqBjaGFyYWN0ZXLCoCdWJ8KganVzdMKgaW7CoGNhc2XCoE1hZ2ljwqBDbG9zZcKgaXMNCj4+
IDM1MMKgwqDCoMKgwqDCoMKgwqDCoMKgKsKgZW5hYmxlZMKgdG/CoGVuc3VyZcKgd2F0Y2hkb2fC
oGdldHPCoGRpc2FibGVkwqBvbsKgY2xvc2UuDQo+PiAzNTHCoMKgwqDCoMKgwqDCoMKgwqDCoCov
DQo+PiAzNTLCoMKgwqDCoMKgwqDCoMKgwqByZXTCoD3CoHdyaXRlKGZkLMKgJnYswqAxKTsNCj4+
IDM1M8KgwqDCoMKgwqDCoMKgwqDCoGlmwqAocmV0wqA8wqAwKQ0KPj4gMzU0wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByaW50ZigiU3RvcHBpbmfCoHdhdGNoZG9nwqB0aWNrc8Kg
ZmFpbGVkwqAoJWQpLi4uXG4iLMKgZXJybm8pOw0KPj4NCj4+IG5vcsKgQikNCj4gDQo+IENhbsKg
eW91wqBzZW5kwqBzdHJhY2XCoG91dHB1dMKgZnJvbcKgIm1ha2XCoHJ1bl90ZXN0cyLCoGZyb23C
oHlvdXLCoHN5c3RlbT8NCj4gDQo+IHRoYW5rcywNCj4gLS3CoFNodWFo

