Return-Path: <linux-kselftest+bounces-42915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C408DBC73C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 09 Oct 2025 04:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F2444E406E
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Oct 2025 02:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA531D63E4;
	Thu,  9 Oct 2025 02:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="jSAxcjJi";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="OD6K42UD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F196F1684A4;
	Thu,  9 Oct 2025 02:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.214
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759978030; cv=fail; b=kCNqpwQ8No+rv1nxIJFMAkQ9MQnYhaUCr1s6Resq63e8dfj50+9CIPGkh7bsDeT9DaXdTcW9vFnaacA8HgaCxtPHU8sS/UTzLlmHhg/QtIcF7DfUoEt7+dJ2WXYHZE+M4hIJfZcON9oOsXjBwaOkCF2sY60ON/huWXp9Qa3+XT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759978030; c=relaxed/simple;
	bh=rCWSpUmjeiRAlOgsSldJzZiVEVAWWG/R6gPOTY31HwQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kFQ0Ld+9O5FGl8U/toTUlRAs2whe9KGprUTNCpMkfk2aC5yvTnG1R50UdUFt1cfvtv9il4h8EloW0HrAQjNwl4Ool44FsbFcEhh2qc06zoEtrsChcQFULaxVbpc4eP2+CW7jaKFSURqeWCf22tjcfRkuiTM/yBUDccl8JRsc3V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=jSAxcjJi; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=OD6K42UD; arc=fail smtp.client-ip=68.232.151.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1759978028; x=1791514028;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rCWSpUmjeiRAlOgsSldJzZiVEVAWWG/R6gPOTY31HwQ=;
  b=jSAxcjJisImZn4+E0nL3QCS3T0ZCCNYtf5GX1FB0yg3ADYsfFjnYhldg
   96n0nBsxO00z5bpCMEby/uKAK/aroGJ0JUXyOPwLuqikLGSu537kWyfut
   c7ZMH7VLg2h6GVjcUU3fIvX89PGbroqc070bGzkzg3qN5xpYbfV49NFCb
   UzLpGnwHqkdexbzMgFY7ScOGbWXmw5TY9J2zh3kxQMLve8KLyjypUEd/h
   zw58Xagm952ZgZEf5jVfidkxIF7/o1tPrkFc4+QL+S9Zk3Kao+LOeICPW
   FCzqnnm2nPB86KaEqcobZXkF6v1mBiz8Vb0BKR5bUbAaiDtmBYtrimN9E
   Q==;
X-CSE-ConnectionGUID: hv1GVHkaSmWeX1LzNbyrsg==
X-CSE-MsgGUID: fcSaSt5YSLSqeaEqulD2KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="83327715"
X-IronPort-AV: E=Sophos;i="6.19,215,1754924400"; 
   d="scan'208";a="83327715"
Received: from mail-japaneastazon11010034.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([52.101.229.34])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 11:45:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UcOWnQUzZpA5kmorP4ipF14aRXIW1w93cJEzK0R2LKGWILaWp8PA2wyu7c/j1RGis4RrB4hq/ZTG5Kgp8Gkx6DD7EVu0F3Q6iBuZ6cwenKm99Iqx0dOL5nl8C72PbQRggefYlW2nRnswNH5p3Lj36NhyvwD3X/PZPTKG9745pVDmgQRvJee4Pu2Vscw9yxIHX9moUm8rQAbetX9vJjUcsFIw7EcCzIT7TFrs4VuwEh0cZXSk2RzxWqDKmt1pWOM5ZSvFgy9TILu8lmd0zPSqcWbybC0pDud3SNr/H2Bez5dslCOabhezOv793z93Q20/UCsO3QLi+OY45BKz/oWklg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0XXlSnjlfyZ4pxC0rLArq+iMKYfApnSMMwvpBCqq9g=;
 b=JKXnAWMkeBzVgvm+2akb0N+hSmdnJgP4kr+gbadxD1RGU+cZ9/9lK1Ky/2qjw6Uo6tojZTB6ABir4YIzW5m85u35I+pxZa/U0CAXQUSSUb0AKiQWlEZfFG4zSURKxNGuQml5sF0GGMz4GpUce3g87DbvP5h9IdfsnGLIgp2+XqB/N2ORhqkw8VT9BKpVe3M/61RakYCX2KPkRfKadVWzlQeDssiNKtGYlWCGpH5D9sBBCMzerrU5Br1up0KkD6Eo+mTvBu24dLuKv81BQ4X0NMbFAfq6lyf1H1gPfu3wjKEjAQwrPaaveAGB9883OYMk3kc1VYSquUcMj/R9NCvxjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0XXlSnjlfyZ4pxC0rLArq+iMKYfApnSMMwvpBCqq9g=;
 b=OD6K42UDIvGlK4C0CevK6jFqYqVvXS3cuvG0aaRtG2F7TSZIQzZ8aZEl1PPrDbVwfe3QrVwPtbn5NO7S6PMei+2sIT0oLkGzvdqJl5dYKFMCa3wDKPrQVQPib93jF1q9ZcUlg15IL2CjEy5uO0zdPte3IHbK6L2PuJnQK+zDuCttGrSiXllUs6kdJxDsIZF/q1mjitlP/K4bZOvzzw4FMwkM/R28PRWbPda5nGwf+bFRohCzqJAE0BJCmHr+EB7MU5HOGyCcsMk1ej69EI59U3M9GvIkQW/t8eKAIQj0yEdCekV71yCS6J+QaVZ6Q7EmjsaL/P8lsQBKSg2G4zQEDQ==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TYRPR01MB12893.jpnprd01.prod.outlook.com (2603:1096:405:1b7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 02:45:47 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 02:45:47 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: 'Babu Moger' <babu.moger@amd.com>, "'james.morse@arm.com'"
	<james.morse@arm.com>, "'dave.martin@arm.com'" <dave.martin@arm.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'linux-kselftest@vger.kernel.org'" <linux-kselftest@vger.kernel.org>,
	"'ilpo.jarvinen@linux.intel.com'" <ilpo.jarvinen@linux.intel.com>,
	"'babu.moger@amd.com'" <babu.moger@amd.com>,
	"'maciej.wieczor-retman@intel.com'" <maciej.wieczor-retman@intel.com>,
	"'peternewman@google.com'" <peternewman@google.com>, "'eranian@google.com'"
	<eranian@google.com>, "'fenghua.yu@intel.com'" <fenghua.yu@intel.com>,
	"'reinette.chatre@intel.com'" <reinette.chatre@intel.com>,
	"'shuah@kernel.org'" <shuah@kernel.org>
Subject: RE: [PATCH v3 0/4] selftests/resctrl: Enable MBM and MBA tests on AMD
Thread-Topic: [PATCH v3 0/4] selftests/resctrl: Enable MBM and MBA tests on
 AMD
Thread-Index: AQHcOMMcHTMo7Zd2vkWleDxNKUE337S5Gf1g
Date: Thu, 9 Oct 2025 02:45:47 +0000
Message-ID:
 <OSZPR01MB8798A07599944A1790AD03B48BEEA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <cover.1717626661.git.babu.moger@amd.com>
In-Reply-To: <cover.1717626661.git.babu.moger@amd.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=42cf9220-fd32-4561-b412-379c9c071d3d;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-10-09T02:38:12Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TYRPR01MB12893:EE_
x-ms-office365-filtering-correlation-id: 9580eef1-1d10-429e-e41c-08de06ddf347
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?RjF1Nys5eFMwZUFNWCtMOGNEU3NZdmFWUUFzaCs0U0pvbEpmUWMwYzBs?=
 =?iso-2022-jp?B?RGcvTmJmVis1Nko5RXJYZkV4SG1ZdG1UNlh2ck50Z2dONDExMzNZS2pW?=
 =?iso-2022-jp?B?a3VOeWlUY3AyYVIwTEI1ZFRjeE5XaWx6NksydTFzbDVWOUNucmhtRmFG?=
 =?iso-2022-jp?B?YVJOS1FCcjdhempnbHRlMSthZEppZzJiRzJQeXBZL0dsa3RKTVNHRS8r?=
 =?iso-2022-jp?B?OU1oKzRpWG9QcVppKzhRZDB4bW92dlZMVlAvUTQ3STcwaThrVm1RcS9D?=
 =?iso-2022-jp?B?MTNzcndieFpuNE42by9MLzR0a2w4RnM2RDRvQzVHaGtKRXpQc2QwTkIx?=
 =?iso-2022-jp?B?cC92TWRUK0wvV092MDF5M0RkZ0NDMStQYk9rTzZGeTlvelZmdENqQXhC?=
 =?iso-2022-jp?B?TDE4dEwzRENPNnZwU25tK24zc25xdU5zVFFzcjNoUmE5V2lKaUdyZXIz?=
 =?iso-2022-jp?B?UTFKU0IvMktydXEzWGl3eEVHQlRibndiSHBDNHBPRTFkRmhseU93MXZq?=
 =?iso-2022-jp?B?ci9iL20xaUU2Z3RDRENwY3JhMDI3b1pmMDl5TWh5TnZWOE5HVUN5bUtF?=
 =?iso-2022-jp?B?MktHSm8xVk5iaEVlVEtWcjM1ZklCci9pSTlmT1ZacXhlUTJqWk05bmd2?=
 =?iso-2022-jp?B?QWpsd3ZxWUVZVjdrN2tZQ0x3UkJnbng4VzA1MDQwWk1IY3NVbWJmK2d1?=
 =?iso-2022-jp?B?cGl1WGxyNjBRN0FINkNrNjAwaTVwMytXMnJFUWgycWJ6UWkvYWJmNUhK?=
 =?iso-2022-jp?B?T1FBVXFZeWl5WUIxa0FtVEE0YkpycDVnOUUyOCt0dnBPY1IvWmd3YklB?=
 =?iso-2022-jp?B?RWtPSWsxTTVabkV5WEplQURHNkRFL1RhQUFtOWtzYmZKWjJycW5TeDI0?=
 =?iso-2022-jp?B?Y0dHTnNzTVZGTnF2NS9TeEsxeWRsQytpV3U0STNNUmRnalRsVGZIYVBQ?=
 =?iso-2022-jp?B?ZjNRNVQvS0JUYVg2VTY3YWM3MG5XMVVxWDZQdGpxYUVvWnUrUDR0a1NX?=
 =?iso-2022-jp?B?cnZxcnlwY0ROZFIySnljMGJBTHFwL3hvVHlOQ2l6NVlpQnhpS3FSN0FJ?=
 =?iso-2022-jp?B?RG1IL0dDazNWb1h0eVB0VjdPcHIwd3g3bW9aQ0Q0ZUJ5L1RsUG1JNWQv?=
 =?iso-2022-jp?B?aXRZVnRVa1E4a0FJUGxjUUU4MDhIdWpEWDVUOXJUVWRZKzdlL29EWm80?=
 =?iso-2022-jp?B?Y00rekpMdTcxUUpkOG1tVG0wSEI5MUpOREo2Y0NLY2NhcVppc2xPWkFp?=
 =?iso-2022-jp?B?alBEZm1tY3lraWtiRUZKMzFSK2xLQlhQdytxQTNhcmdKT0RsQ3hxS2Er?=
 =?iso-2022-jp?B?dlVXUlVkTU9SV1BYdVQyYTYzbng1M01UdmpOMFo0WXo5VktlMXgrTXhW?=
 =?iso-2022-jp?B?dU85VU1RYi8yQm5jb3pPQ0V6T0M4SVRiVXdRcDA3OUJlWU1pWU1GMGpw?=
 =?iso-2022-jp?B?Tmw2T1pSV3ZpYXVZNE0wbkg4czR3bHVKb2RvRTRJTi9GejNTdlp3T1Uv?=
 =?iso-2022-jp?B?L3p1b3Z0SlQ1YXVIUHY3Sm5zelRNQjlFWWx0WjN3M1pkS05MUkVXci83?=
 =?iso-2022-jp?B?Z0hYbnRub0lJdis1Tk9zVjZoMXlPcU9BYldNeVdiMjNnT0lTU29kaFhH?=
 =?iso-2022-jp?B?RDJyRzJtZ2ZML2JISE9QZGw2NE5jYmdwcmhFZTIzckhTbHptZEVZS3ZV?=
 =?iso-2022-jp?B?NHlRYXRDeGU0TWhTMzV4UE8wRlFUWWw1WkJscEt3YTZKNnNSVjB6MWdQ?=
 =?iso-2022-jp?B?dmhQV1o4RUFIUWg0UFJWd1U2NEZ3bk9oL1FYWEpKR1pjTTdMc3lGS1BQ?=
 =?iso-2022-jp?B?UTIvbDFwalFLbFZUNTFWbWdsVERsT1lRMTBER1A5dkpHWG9QTEZoVUVa?=
 =?iso-2022-jp?B?UkFWT1lQQlN4YU05Smw3YTIrektGbWp3VmJiVlQwU0cvTENhdEM4U2dC?=
 =?iso-2022-jp?B?ZWRxZmI1aUhyVjV0WTFDUlNvc2JJK1haWFI0ZHRsSWRGOEt4c1BuUFFX?=
 =?iso-2022-jp?B?STZ1NnVUdklONWpzRkp1c1ZnTUdwVHVBaURDSWY4ZnU2Yk0rVXdGYm8x?=
 =?iso-2022-jp?B?dVRzN3FtTmUvSXFqNE1sWVZmdUU1djlNMHVNZVVOY3lkY0FaczFTem5t?=
 =?iso-2022-jp?B?TWVSbktkQVAvRldYYjJUSlRUcTl6UXR3aEhuZGJzOHgwa1RlRlNKb2Nw?=
 =?iso-2022-jp?B?dGJpbGwxaTE2MjRIbHJaTTJCVVFQVWlw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?THFwdUpqMEVlZExVVElUR2N4Y1BuYzZ5OXpORDIxVld2N1VQWWlwSmMx?=
 =?iso-2022-jp?B?dkxlTGZQWmtYVVl1ZTVmZ0Y0Q0VMQ0dwVk8wRGJnNUhpNktTZnJrejFo?=
 =?iso-2022-jp?B?NjBzczUxbTBoMkZ0ZmU1am03aExuSUI4MlZWYUVMeDl5bHhHT3RxOXBO?=
 =?iso-2022-jp?B?QnNRRGJmTk5kc3J4RTV3RlgwVGxXSHNXSHExRStNNjVHUDg2Q1dDNUZy?=
 =?iso-2022-jp?B?MnJ2SnBvV3MyZURpdDR5QzUrSGJNeVlCdmJ5NVJjR1VYbWhpcS9kR2Rk?=
 =?iso-2022-jp?B?dkF1ODQvdkVUTjhMRkt2cHpZVXhxU0J0M2Z1Q2greDh4czl2eERFOUps?=
 =?iso-2022-jp?B?ZWdzNXlhTlZJL3BCZ0t3a0FkTzh6SEtZcmNiS3U1THFCWGdaWWd0VXpz?=
 =?iso-2022-jp?B?V3JDQ3puWHZMUFlhZGxsU25uMmlVV2I3VTM5WGhMZ2ZIbDdITDBUS3F5?=
 =?iso-2022-jp?B?NEMycHgyVGJwZVRMMW1IeUVzdFQ3UUN1QlFPRDUzQXd5Ri9IbDE0U0U0?=
 =?iso-2022-jp?B?VE0wOThVR0NEU3BUWG02cHJPd1piOEZEWG5nS0dPQUoyUW5oQWRINTBs?=
 =?iso-2022-jp?B?T3QwWmtURmlzQ2hYRDJLRjcxVTd4NmcrbDd5N3JaWTVYeFBrVVI0RGxX?=
 =?iso-2022-jp?B?VGxhNGx5OFB0TmFPM1dXUml6Z0xvZDNsVHZqN0NHZlA5WStZbGVpTjNz?=
 =?iso-2022-jp?B?dEY0QWFtNWMxTkJuREVJQ0lhSUpLM0xONEhMbFppMzNOaldUY2NSbmhX?=
 =?iso-2022-jp?B?WHFGOUMxNElzUW1tTW5Zd1VLYUxnY29MM3RQSHE4UjZVQUo1WENNZlhi?=
 =?iso-2022-jp?B?YlZDVVJBQjVLVy95MnU4anZuaWh0dHBCcnVDZVFHS0o1VkcyMHB1UXdK?=
 =?iso-2022-jp?B?VFVaekZRNVNhOHlUdU03M1B2ME9oN1ptSEtsbGwyeG5vRjNrRTIvZTVY?=
 =?iso-2022-jp?B?WDZ6OVJFQzJ1M3IyRDlTV0FzcTNkQWVNclRzY1VUanNCckxhRG9uck8r?=
 =?iso-2022-jp?B?TG0yOElDSlFrM1NEekxkbFRzc2pZOTgyMmtJZjJWdzh6NnE5OUREaVVp?=
 =?iso-2022-jp?B?SGlXY1FwT0lRWnhnQSszc0NQUlkvUVljK2xjbzh2ZU1rNzc5SmlkR1Ny?=
 =?iso-2022-jp?B?YlBsNVNQOC9HN0IzL0NLZUxhMnBpT2FDS3R3ZndWOUMrZzg3MUJRN1d1?=
 =?iso-2022-jp?B?OTZaUjZhUjBsUHk5bVhTSkNBTkhkS3BpUXd2UTVZa0oraCsrdVZKZFpE?=
 =?iso-2022-jp?B?ZE9sVlJYUXJpZWFURS8wSG1XN3VpQjVua2V2ZE9tMTBMWXVTOEZXczI1?=
 =?iso-2022-jp?B?bzNwMnBvVENwYTJDRE54RGk5K2dlc3hHOGVsbUtxSjYyUWlRdGdxeUsr?=
 =?iso-2022-jp?B?d3A4UlJDakc5Ry9IYVhLMjlraVlBWGNMUzliSG9CSzhhQm9LY2dXYzdE?=
 =?iso-2022-jp?B?VnNUdysxMDIzNW91MFVkbU81cndmMVRFNjJHU0FoRzdsRFJqQzdrTktp?=
 =?iso-2022-jp?B?VDhhcHJ3bXZqZXMxTk9LaG5aM3IrTVNqQm9aUzIyeXdZcnFLQmtUK29n?=
 =?iso-2022-jp?B?aGNBRGdSSndmRVYxaG92Zjg5dHRXL21iblJYVkdFSUJXeWZxV3VDakEv?=
 =?iso-2022-jp?B?b1IxbmlmZEM5R2lnZDN5aE1XcTl5dDFiaFhYWjBScE4rd1FSN0hXbEtn?=
 =?iso-2022-jp?B?Zy9uRjgrL2pudk9VeWtuVzlWRTFpdXo2UzA5b0tldExDZnplbXdNRE1a?=
 =?iso-2022-jp?B?czU5OEhIa1d5Q3JNb1FNL1hRL3hCZTFmc1hkMmp0N3ljRHA4YlFSdDBk?=
 =?iso-2022-jp?B?d0tGMDZyaXZBMGZ5My8yc1EwMmJtYm1weWlpTTEvWVYrbmNNOVhnTXAx?=
 =?iso-2022-jp?B?NjRJaXl1WmxBcThHbXNQYk5mVDRYV2wrdWVpSlkrTTdnMVhvZ1Zidmow?=
 =?iso-2022-jp?B?dHR1LzAvSlNjaThBT1ppVC9pNEljVzBjS1pNRWU4anNydjBsV3psM3Rx?=
 =?iso-2022-jp?B?bEtiSmdoMWZCMjUvOHdtNlc5MW5QZHZVakw2YVVtZFRZZ0g1b2VQV3F6?=
 =?iso-2022-jp?B?NXlUSUs4Y25OWkxOT2tIMXJtY3FmZGhaR0oveTVmbGhmdWxROEc0ekZs?=
 =?iso-2022-jp?B?WGFra2RONnI4ZzhSdEhLWTMwWGNnM3VPOTgyRFBwN2YzSkluQjdwQXpl?=
 =?iso-2022-jp?B?T2l0NXBaNkJmL1BVRDJrQ0JiRi9hRUFqN1RUMitjQVQyZE8zQzYzak13?=
 =?iso-2022-jp?B?T002L3ZDZ2dSNFFaMzk3dEdFVGN4eG1sdnNPNm1ydFZYNU5tMHVIZWxt?=
 =?iso-2022-jp?B?SWlOWjE3S0V4OUlvTDAxZW1tT1pWZnM5Nnc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qUFAfTcV1cEfGisVHhgkrwV2Ulu2jERBzgO6ZZWx3Nkx3OsWZj8qDIEPdSK/9gKuVzQG1rAS5K4PhtF4gS08wo49spBLMKXdpBcwLKk8BYXW+eazjUKWMdp/pTvcbFDaRuD8+0p35LoGdLPt4XU/Wdc0JjyqDa4M3sGqTv3n8EwUBlNfjB0D+0iVSFT7+hlv39JlxHU7LKrILIHFqn077D0fBaLeXgHMzj/YPL9fomgA5CYdQEDPH3vIVKk0p6NWoTaZL861DrKNPt/7Abm05VOPN3Si2X6Rcs7xxsOIl6FFMl7G0KtR9ZKib484CMEZPR0+uA1oe3dy+xP5UzaKKoBHbyI3ajHp7PelzjweZGc1B5NiYmviUw22F7h5yiaZQu5MruEP3fjna4sRyYys6OG7ClJQYyXa4PM7wwe+KjSu1bEsvMGMBPibIVBx+zLorVqyGU7JwVRrBfj7RbdXzO6BB8hODlbh7OIV/5y2XRffDfp/8/Jn0JtxRd6NlETU/7QHmpHCquDq749kFaqatinnDEcXt9GGesKvrhw//JV8H8ydu76H4qKTJv9GOKXYKtzcnyLLt6tDDHGb8DRq0s5eDuSo4+RDyuGm0VGm9x7tzVtEjw5Vf4srXYXI7NaT
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9580eef1-1d10-429e-e41c-08de06ddf347
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 02:45:47.1945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XMoD6G9ztUUQp9skCoTaQ8fJfAwf8ZCUcOanRD5WX87+2DQEcQxxQ7O01G0SWuyS45lmJbfvr+OtG1acyHSMNU+7VVYsFWMXbuHAew07iYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12893

Hello Babu,
=20
I think you are still planning to upstream this patch series.
Do you have a timeline for posting v4? And when do you anticipate it being =
merged?

I'd like to enable MBM/MBA tests for ARM arch (MPAM driver),
However, I foresee potential conflicts if this patch series is not merged.
I apologize for the inconvenience, I kindly request your attention to this =
matter.

Hello James, Dave,

Have you already considered or made any plans to enable the MBM/MBA tests f=
or the MPAM driver?

Best regards,
Shaopeng TAN


> The MBM (Memory Bandwidth Monitoring) and MBA (Memory Bandwidth
> Allocation) features are not enabled for AMD systems. The reason was lack=
 of
> perf counters to compare the resctrl test results.
>=20
> Starting with the commit
> 25e56847821f ("perf/x86/amd/uncore: Add memory controller support"), AMD
> now supports the UMC (Unified Memory Controller) perf events. These event=
s
> can be used to compare the test results.
>=20
> This series adds the support to detect the UMC events and enable MBM/MBA
> tests for AMD systems.
>=20
> v3:
>     Note: Based the series on top of latest kselftests/master
>     1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0 (tag: v6.10-rc1).
>=20
>     Also applied the patches from the series
>=20
> https://lore.kernel.org/lkml/20240531131142.1716-1-ilpo.jarvinen@linux.in=
tel.
> com/
>=20
>     Separated the fix patch.
>     Renamed the imc to just mc to make it generic.
>     Changed the search string "uncore_imc_" and "amd_umc_"
>     Changes related rebase to latest kselftest tree.
>=20
> v2: Changes.
>     a. Rebased on top of tip/master (Apr 25, 2024)
>     b. Addressed Ilpo comments except the one about close call.
>        It seems more clear to keep READ and WRITE separate.
>=20
> https://lore.kernel.org/lkml/8e4badb7-6cc5-61f1-e041-d902209a90d5@linux.
> intel.com/
>     c. Used ksft_perror call when applicable.
>     d. Added vendor check for non contiguous CBM check.
>=20
> v1: https://lore.kernel.org/lkml/cover.1708637563.git.babu.moger@amd.com/
>=20
>=20
> Babu Moger (4):
>   selftests/resctrl: Rename variables and functions to generic names
>   selftests/resctrl: Pass sysfs controller name of the vendor
>   selftests/resctrl: Add support for MBM and MBA tests on AMD
>   selftests/resctrl: Enable MBA/MBA tests on AMD
>=20
>  tools/testing/selftests/resctrl/mba_test.c    |  25 +-
>  tools/testing/selftests/resctrl/mbm_test.c    |  23 +-
>  tools/testing/selftests/resctrl/resctrl.h     |   2 +-
>  tools/testing/selftests/resctrl/resctrl_val.c | 305 ++++++++++--------
>  tools/testing/selftests/resctrl/resctrlfs.c   |   2 +-
>  5 files changed, 191 insertions(+), 166 deletions(-)
>=20
> --
> 2.34.1
>=20


