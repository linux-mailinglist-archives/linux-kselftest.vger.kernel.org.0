Return-Path: <linux-kselftest+bounces-18696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26EB98B010
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 00:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089361C2136D
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 22:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CDE18C925;
	Mon, 30 Sep 2024 22:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kkx8t23r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OET7iIhp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAC8188A28
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 22:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727735796; cv=fail; b=tRfCJdrMmpUM6OMEJp3Ifo0W/eSXrq1GWrGZoz1UHLOd/LB0GRURWE0IMJnuBMraN/ZsWHVlpzDRNs1NlAZv+ceDdXIWwSgd9yX4tDah3gilVWMXTF8zeoJec45llbu3Bp6RT4HQpL35YteoKNAkiCwXcHhR4n3jVIVMQ/LxRso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727735796; c=relaxed/simple;
	bh=pSMxA/dDxQaIxeVUfR5oR1d5D6K30cWoh9/FDBLIQV0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lgxXVEKQx+JFuk403mAM23OcY3KJ5p6OaZOW7UpD1IgsWio9W/oXZxGEvJDi+g/4lQ/CLIqr6ba4RBSE99wD/Nye5ydNrs5bGJgTRgv4pwUSQGDGId/Avjl/dJnio7bOhla/V+m0xNbJSKy9OnepSvKRIs3685MzMYsWgFSsYNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kkx8t23r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OET7iIhp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UJthjL002851;
	Mon, 30 Sep 2024 22:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=pSMxA/dDxQaIxeVUfR5oR1d5D6K30cWoh9/FDBLIQ
	V0=; b=kkx8t23r9ArCWqwddegE5K4sEegb9b25VniXoEBMef5iStsQ8ZVZXp7LH
	eK+15i73B423kUjguoTOy9XEemeSrOOBifocEVZNjcRqo/C46hbRdmbX3fUTppnT
	NuS6nZFu020ZWicRYoVSThX/H7pHUINNLcwdh3+Xc8550wZY4O0EkpDbYhePE4gc
	0SJYx26WppaK+3nppWmvvyfQGuec8Z1Yf5XNFygfpgNkHCCXbrNL9+FucQCz5Fy5
	dWSuxgkUQYzrM5mnFSQeLJdjJJnidnA5AgopMaoNkYYhaOISP9CV1bEJhVePvesS
	E2Zq3cL65xxhwXc51qtOBVFc/dHKg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8qb4wsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 22:36:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48UL7CYp017337;
	Mon, 30 Sep 2024 22:36:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x886pdj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 22:36:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEAYI75JcckMt6Qg80L92ZNmLxfH1NHCfBixZSUIrIEWd6Xki00nQYDiAJnrRckxaOiHm7cOA00iW+pbNjRC0SjYgo3+BXt0GwGVv4XsuHnkFPPF8ucbmAcNs4QHHLOCP5GhHzTQ9yN54koqPcY3DpLMjPyZ1DfdncC0Q9vbHXEkzr3btGiWFrjHqasdWfNcG8eLYEtS4qPmip1CVQvXg6ssD5Zu8ZNfkwHzR1hZp3SeAjc7YDgnVP54eLtMHdqD5s6jbLGDKvZMUmuHY2RFmBHvcTnoX/uUF7e6soM/Y+qEpPafVbwGf8Pvovzqm5YK5AXixUhxkcS1Wb0QzuO4eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSMxA/dDxQaIxeVUfR5oR1d5D6K30cWoh9/FDBLIQV0=;
 b=zNujfrGTlOu7O+bgcVtZp34oSX/4g+4Qkri7K7r/AHBteA8Q1ruUUVpgUZxfJeUivATCD8O4E4yzKTrwfoem5t5ZZfeezkftY/U5Hl5pVbo7cC0ilmHRYj3uXTf0VogEgiFntRxE8LBrlUKRO9kLeoJ2Lj9Y/eMy/DboFYIYIECMFwhNTtaL+HMCsHMQDje8cF67DjaIYR8vfuvk+Jctm1K2qB0EaEZvctvaUEWU0VVq06U+vhjAQe0xRkYBCau699ZjO/23LKV5oC3b4UIt3w6sCqB6uEpn1wWJpPL2szP7sTYCtqrmqilgSRpCfteSle1wTJgxa+r0GZSQfJDS5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSMxA/dDxQaIxeVUfR5oR1d5D6K30cWoh9/FDBLIQV0=;
 b=OET7iIhpV7naFSECqYwsDrvacDxt81RC+i+vzhLzd46S/RwVT+pnfBe4P857cv/+HasF/FRcGINgDSPEoI6P+A/HJ+U6TE2VzJHZ/e5QL+cyuQVl/kFHiaaP2Zch9b+wlRjcSstiUOrakWVvTwTuISGCtqtdZSf0ciN2Rjp9Z0k=
Received: from SA1PR10MB7634.namprd10.prod.outlook.com (2603:10b6:806:38a::17)
 by BN0PR10MB5095.namprd10.prod.outlook.com (2603:10b6:408:123::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.14; Mon, 30 Sep
 2024 22:36:26 +0000
Received: from SA1PR10MB7634.namprd10.prod.outlook.com
 ([fe80::5d7d:6585:d28f:3d9b]) by SA1PR10MB7634.namprd10.prod.outlook.com
 ([fe80::5d7d:6585:d28f:3d9b%5]) with mapi id 15.20.8026.009; Mon, 30 Sep 2024
 22:36:26 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: Shuah Khan <skhan@linuxfoundation.org>
CC: "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        Ramanan Govindarajan
	<ramanan.govindarajan@oracle.com>,
        Sinadin Shan <sinadin.shan@oracle.com>
Subject: Re: [External] : Re: [PATCH v4 v6.11 v5.15 v5.4 v4.19 1/1] selftests:
 breakpoints: use remaining time to check if suspend succeed
Thread-Topic: [External] : Re: [PATCH v4 v6.11 v5.15 v5.4 v4.19 1/1]
 selftests: breakpoints: use remaining time to check if suspend succeed
Thread-Index: AQHbE3hlTzMEK+Zu+0OROq7tINPbiLJw5OSAgAAB6YCAAASSAA==
Date: Mon, 30 Sep 2024 22:36:26 +0000
Message-ID: <39176947-298A-4F45-BF74-742FD836E4AB@oracle.com>
References: <20240930203603.2854629-1-yifei.l.liu@oracle.com>
 <ff1b6eec-06c5-4b5f-bc27-6637510014d9@linuxfoundation.org>
 <8d1c1645-8857-4b67-b5dd-2e966aa0d8f5@linuxfoundation.org>
In-Reply-To: <8d1c1645-8857-4b67-b5dd-2e966aa0d8f5@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB7634:EE_|BN0PR10MB5095:EE_
x-ms-office365-filtering-correlation-id: 34c8ff96-e2c7-42fc-72a3-08dce1a051c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dGlpTm04SjNEOTM4MFp6YkkrZzZhcGJNbmFHcUdTWkc2UExsaFE3TDlsL1R4?=
 =?utf-8?B?bHRsbHI4UlRrQ2lrcEZvdnRKYStaQjdsMFd5MXh3cWdpV2xSOTI1UFVYd3o2?=
 =?utf-8?B?U3B4Ly8wbmtQc2ZlRkNuZi9kWDc1QVkwU05zQkYzWEY3dGsvVXZvTXROOG5K?=
 =?utf-8?B?ZmxCOC96dWhzTHJCampiTFRpN2k3cmV6Q2s1VmRJQ3pHbTZCTUZ1Yk84dHRM?=
 =?utf-8?B?OHNyeFkzMHk4QXhKNy9oNmw4cVJtUXlMWUg1NGJZMG12dXBRNDRoMXV3K1R0?=
 =?utf-8?B?MHo3K1FuSTZvb25XQ01pTkRLMTdQRU0zaGZReWltT2N2SEJ6eUt2Wm9mb1dV?=
 =?utf-8?B?VXcveWZWM09OR0Nhb1VYNzhIUno3c0FhNWxrNmJOcmlxNDk3NFN2S2N4QjF1?=
 =?utf-8?B?ZjZNU2Y0WEhVZWFIZTA4aFB6TE1pOE1ZVnpucWhoY0xLU3Y3LzJBWlkrMmto?=
 =?utf-8?B?UXZxQmhSSG9SbXdydXg5d0drWm5FNVI3eWJ3Z2tIcXZsZWRXVDh0Wkp6Y0kw?=
 =?utf-8?B?WDN6QS9ZQ2VIUHhuNWMvaDdvb09BVSt5bFdhNTVGK3ZTUnQzUUMvaEpIWnEr?=
 =?utf-8?B?Umx6ZVJ5WmwyY2dvUUkwQ3RtMzBMNFRSdGhpQ1hLUXc3eE5mc3pYRmN0cm5x?=
 =?utf-8?B?djNrRU9oL2lhdDN2OHVzUmFMaFVmVjAwMklWM3dNSWMyWXdFa243djViZFlq?=
 =?utf-8?B?cktRTWtJelVpMVVyb29BbGgwLzNoblpFeEMrZWFlU3Fhc3g5NWkzeTBuRjlj?=
 =?utf-8?B?WUdkaVFNQy9UMVFVQk5qUlJmMWxlVHVOYVE2YVEzbldDNW5UaTJxek1vS3Rn?=
 =?utf-8?B?c1FHQlI3QmZYUnE4NVV6SEdONnVyYXNrVE9WN242Wlg2Unp3UEhieCszSFJp?=
 =?utf-8?B?SVVkQlcvWlBvSGtNT3lISVpxRUM2K2xERTlkZEhXTHVyZ1dZOHNiME1IbVJG?=
 =?utf-8?B?LytJcHVpOHprRkZuMU16TzlJZjBGVFQ1dHh1TVpQcWJLMG1xeG9zT2FFY3Fu?=
 =?utf-8?B?a25LYlNGUTJlU3MyMEJkeWI2U0hYaFhNOFFPa2VFWWpBWmdPWm5LaklkaXAw?=
 =?utf-8?B?MGpXcitqdHBmSGpJcitnNk9YU3EramE2am5rSmVBOWI0ZEJUTkFaT3YvVmdW?=
 =?utf-8?B?ZGQrbjdZRXFUNnBaVi9PY051UkNPak1MKzZWVTFFNElreVZOb1lieGdDSEg2?=
 =?utf-8?B?dnhmWWs0N09rYk94c3ZPUjF1K0M3dGsxVm5yMHZONnd6VGN5RjBrUmI5TGJS?=
 =?utf-8?B?endMRUcvNnZVUDZQeWhkQTM3eE0wd2RSTTRwdktIZzJvZUswczhzZTIxeUlp?=
 =?utf-8?B?TEVGTHBlZlZIYkJBdFdjTXg5UWx3ZWpyTzVlZVd3Q3lkV25zV3RXWEpEN0ZH?=
 =?utf-8?B?S1dsMlArZmNsSEZxRFVwd3Q1cGJWTzBjeDNxanFvUFdjcFJYaTBVRmREamVT?=
 =?utf-8?B?aDlTRERERld4aE56a1hUU0t0SitTVGpyVE10a3Q2Zi9xYlB2Y1hIUEtmanU0?=
 =?utf-8?B?TlpkbnRNQkhmemxMbUlRRERMSjZ3ZUpJRlVEMmo2MHNyaUZEcmFodHVhVlNj?=
 =?utf-8?B?QTdsMnkwL1l3d21xdjlaeUJXd2p6VDdZME1uSDMwRndCTFdMMUs1N2R2TnlX?=
 =?utf-8?B?NE5mS3R4VmMrK0h6amZUVC83cWViaW9vTSt5N2wwZkxmWkdLalVSMDFNNk41?=
 =?utf-8?B?bEdsWEhIS0x3emNuN3I1NW9ScndTZS9NUzBIOXpISGdMdDVBbmdOZUFkV2Zq?=
 =?utf-8?B?WmRNbFVxczhtK1RCdkJLNzkyYTJqTlgzK3dQZ2ZBTlFGSGREamEzeGw0UGJq?=
 =?utf-8?B?OW1vZFFXUGxkNEFTNDJ3ai9XcUtDUlFOUVFJbWRGYkFRdnRCTXN2Z05VeXNU?=
 =?utf-8?B?aDlJeE5FRUkxMmVCNGtSM3p0TGJxVHU1RjIrUHltRXVieGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB7634.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VTBWallTQkMrVUpmREdDc2VJQkREd25RL2QxQ1JHOU1aVVg0dzJCbEdNOXBQ?=
 =?utf-8?B?aVI0QnhPZEFsNkp3THdDb3d3VUs4S2hqYzdmdUVkSStPSFhrdHJ5cHJGZ1g0?=
 =?utf-8?B?L0pnN3hpcjJ0Wjlscm5rcUFPU0pmbHlXSHJPb2J4ckl6eSs2V3haMldHYmdE?=
 =?utf-8?B?TVpxcGlGVVhOOWhHdVZOM1pSL3ZqK2ZMb0pYTE54N2l0R2tJQUJ4N3JVM3Fj?=
 =?utf-8?B?TFBMaURvOTBYajN3aHpCV3lUUnhCOTJFYXY0SUdZOWZLYlNUODg3RFFoMU9n?=
 =?utf-8?B?TlNzRE9aNEl6V2FhRXRXVWhtdlE3N1NHRWRKS04ybi80M05iRHF0eDJxZ3VZ?=
 =?utf-8?B?dEF3R3VOQ0dOM21TRnA5dVJ6Qk81NXdNQ3YrTHhuYWpnL2JQeGZ0bkEzVWRR?=
 =?utf-8?B?NGZrK1gxTHFTTGZQbjlWaGZNbGNCb2dVTnRMZmhSemhxVG1SVU1tQVRLeFls?=
 =?utf-8?B?Wms1dHpTcndQdkZUSDcybFB3dkJkK0JrYktKeDlLUEE1Q1FxMjAwcUl4TVVJ?=
 =?utf-8?B?UDgvN25HaHFPeFJMdVM3SFNibU5QZ0xEcWpNRnkwZ0lUejB6clVuUHRvRHdp?=
 =?utf-8?B?Q3J6dnl2dlJwdVJSQS9kZ0FtTDJBek5ERTdtclVudmVVbmFtQzlBaHlPaHh5?=
 =?utf-8?B?ZUhQYVNnR2FNYTV5eE9ZNWIrYmRjcUVyY0NlQzgzMnA3ZDc3MGpYYnluWHh6?=
 =?utf-8?B?bmh4VFRQeWJ0cDNqR2RmbmpLOGttNTRpSDlvTEtUTE1JYzJiREozU0FGYmVD?=
 =?utf-8?B?NGQxMXBhdlRtckVTcXIyNGE0MXFkR0FYVHI0T0RyeFZoWGM4TTI5Ri9Sd21H?=
 =?utf-8?B?YWhmY1ZlQU12K1dvQXE2czJMeHRtN2tCQmNScnFmZUpDSE9tMDQ1bUVHSkNZ?=
 =?utf-8?B?RVowdEhwSWxSRnRXYk1BZUF2TzBZUVJqR0p1WENzbWVoVXE3d201SUZZTCs5?=
 =?utf-8?B?RWd5bnFpNURLdW9CUG94KzJMcG1qMmJUdTVDcS9kN25Zdi9FVkpia3g4S2lk?=
 =?utf-8?B?U0FpVzBHTE1QS1Q2VmIzeWNtaEpjRXJkYnpGSHhRODNNMFY3YU9VUTJLRzA3?=
 =?utf-8?B?MTk1czBjbW51VmpHVHNIcVI2RzY0K3A5NHVpbzZmV0c5d0NFYUx3UUEyUnZS?=
 =?utf-8?B?c2xVNlA0REJJZEwyOXpudy90Z2hBYkx2NDNqTGtyQlE1S0pEclZ5MEwvSW5z?=
 =?utf-8?B?VzAvUndyQmlLTGFQTkZ1YnhLWmhFM1FxUkg1RCtMZWloODlRYWtYTzRqQTVl?=
 =?utf-8?B?TDVVREhrcVI0dlp5aXFSSk9PWG1ubWRWemNwZEVKbVZkeFQ0YzNJMTRoVzk1?=
 =?utf-8?B?T0Q4NGJ5N3BDUGg0amtNL0I4NTFVeEJwNG03SHJuMXlRQ1dGbkJTVjVtTmpp?=
 =?utf-8?B?NnhsNDJ6cG9INXNUS3o0alQ4b0NlNXYzTFhTeXN4NzdMbFpibHRRRnBNRXRu?=
 =?utf-8?B?ZEw2TVRrVFMydHZWYXFPVkZRYnkxckFVUWwwempkTFZIdTZoT2dGSjNXU09z?=
 =?utf-8?B?YndoUXh2UDdSTTV5eUF2WnRUL2c1eldyekJHSGpmWDdjSldWeVQyalNJdFdo?=
 =?utf-8?B?OFpwSDg4eCtGM0FtRHVMUEdxMS9IakZQd1JHMEoyd3RFdUJ4N1RZZmlWS21U?=
 =?utf-8?B?dTJPRmkxU2ZiK09zaGl4WmcvWlZyZStKOHc3L081SlNycjRZekxnRGlqVlkw?=
 =?utf-8?B?NS83cVZKSDZNSUgxK3B3WnlCZTkrRXZoTVBaUUhsZ2RqcmxQMkVQbEhJTFRB?=
 =?utf-8?B?TVErcnNtZWNiNjVEWFBiYkpNYjJ0MEx4MU0wYUl0bnM0em1hYy9vcWUxL050?=
 =?utf-8?B?QVFGMDhXcFpCTjd1V2RhdjRNMnNOU3NYUEhnek4zK2hvYWFNTklRRVk2U3cz?=
 =?utf-8?B?aE12ZW16RE9ORHplUS9meG5wMGJzYUNpUEdJRzFCQS8vSU02U1VadXZTMEQ2?=
 =?utf-8?B?OHdYSFh0Z2hQMDVkWmIwbEFKWXdiV1JxeVpneEdzY09UWEdXdkJqVWRtTkRy?=
 =?utf-8?B?dGliOUpZeEFpZEVKKys4cm9iNTdhdHpmdzN2Y1dFY0ZKYzFueEM4SERHRUpi?=
 =?utf-8?B?RE5FT2Y3VmlrWEFjRTIxVjBsalNaTXE5UGwrVENzSFZha2lLaXhOd3lGVENh?=
 =?utf-8?B?N1krcnJCUE5KbEQ2b05sbkpmMklwaWMyZHY0cmhENmd6UVJsRUl2ZmFYRHM3?=
 =?utf-8?Q?a8vQaeXLorIjBSfkWXFkUE0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CDD696F0AF4044DB116D5F6C4C4506E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L3mRd/6FKDmD3T0lmKMAKwlUaRdiXsmBZqaiR7XvU5YN9/tHtAaV/3btqD8Nt1z/wFL8BJQiMAuIeeRdJthlF4VBbXEAvJ9zcr8gSLxhus9uD97xVGXbzbBiluLW1X0obgKLezKoZk1+bj40kfFrEghqMsdT6ek4xqbC3BlwA16Je+eo2BNGKfSIUuh5bRKC9sEOE45Sra6v7xdeMaNLkmJVu5ZeJHymOp477Q+B4Jr2OGO4efP1LDi/qIwa+mwFy8EU0UiCbZZor77BA/7xi7KMaIWKMu3c+O8EEpgpdkqkD4ibbbZ+DVtQi+OMNKzNkb+yej/0Wy49VLUpK0hj3znsh0ZFazq0dv5mqI49JpADxi73CfMAJn0EKHvBbSgDXZAxGHwySyLgVBYSh38hwCTw/Nisna9d0qiI1niZ5AG6B8tktW1iObBLoKIXzD95cNlj1FMyH0ztKLWD90mYeosv2UcnLQiyIpIldm/R8RQTgY/leMuAnjLBpIKTcxrzaE0jqB+WKEmpKGuSQgsvsXRtmLpSpwSh2EJu1UX2EwsBsOR+B1mYty5bwULj/mE98PqhBSheMAFb4K2Id5iFbqiNzpLwcmILZ9AG6Px0TE8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB7634.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c8ff96-e2c7-42fc-72a3-08dce1a051c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 22:36:26.2177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c6hZBtAX4gA51/QBqba+OYJmChshu+MQLtH3+dD8ZWROHkAOMN56u+Fj83zuy3S1TN/kFZsT82xf80iXiCIKUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5095
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_20,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409300160
X-Proofpoint-GUID: -sf968X8abIZynd3q5Pkk9g2et0Ft8_X
X-Proofpoint-ORIG-GUID: -sf968X8abIZynd3q5Pkk9g2et0Ft8_X

SGkgU2h1YWgsIA0KDQo+IE9uIFNlcCAzMCwgMjAyNCwgYXQgMzoxOeKAr1BNLCBTaHVhaCBLaGFu
IDxza2hhbkBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IE9uIDkvMzAvMjQgMTY6
MTMsIFNodWFoIEtoYW4gd3JvdGU6DQo+PiBPbiA5LzMwLzI0IDE0OjM2LCBZaWZlaSBMaXUgd3Jv
dGU6DQo+Pj4gInN0ZXBfYWZ0ZXJfc3VzcGVuZF90ZXN0IGZhaWxzIHdpdGggZGV2aWNlIGJ1c3kg
ZXJyb3Igd2hpbGUNCj4gDQo+IFlvdSBkb24ndCBuZWVkIHF1b3Rlcw0KPiANCj4+PiB3cml0aW5n
IHRvIC9zeXMvcG93ZXIvc3RhdGUgdG8gc3RhcnQgc3VzcGVuZC4iDQo+IA0KPiBTYW1lIGhlcmUu
DQpTdXJlLCBJIHdpbGwgcmVtb3ZlIHRoZW0uIA0KPiBUaGUgdGVzdCBiZWxpZXZlcw0KPj4+IGl0
IGZhaWxlZCB0byBlbnRlciBzdXNwZW5kIHN0YXRlIHdpdGgNCj4+PiANCj4+PiAkIHN1ZG8gLi9z
dGVwX2FmdGVyX3N1c3BlbmRfdGVzdA0KPj4+IFRBUCB2ZXJzaW9uIDEzDQo+Pj4gQmFpbCBvdXQh
IEZhaWxlZCB0byBlbnRlciBTdXNwZW5kIHN0YXRlDQo+Pj4gDQo+Pj4gSG93ZXZlciwgaW4gdGhl
IGtlcm5lbCBtZXNzYWdlLCBJIGluZGVlZCBzZWUgdGhlIHN5c3RlbSBnZXQNCj4+PiBzdXNwZW5k
ZWQgYW5kIHRoZW4gd2FrZSB1cCBsYXRlci4NCj4+PiANCj4+PiBbNjExMTcyLjAzMzEwOF0gUE06
IHN1c3BlbmQgZW50cnkgKHMyaWRsZSkNCj4+PiBbNjExMTcyLjA0NDk0MF0gRmlsZXN5c3RlbXMg
c3luYzogMC4wMDYgc2Vjb25kcw0KPj4+IFs2MTExNzIuMDUyMjU0XSBGcmVlemluZyB1c2VyIHNw
YWNlIHByb2Nlc3Nlcw0KPj4+IFs2MTExNzIuMDU5MzE5XSBGcmVlemluZyB1c2VyIHNwYWNlIHBy
b2Nlc3NlcyBjb21wbGV0ZWQgKGVsYXBzZWQgMC4wMDEgc2Vjb25kcykNCj4+PiBbNjExMTcyLjA2
NzkyMF0gT09NIGtpbGxlciBkaXNhYmxlZC4NCj4+PiBbNjExMTcyLjA3MjQ2NV0gRnJlZXppbmcg
cmVtYWluaW5nIGZyZWV6YWJsZSB0YXNrcw0KPj4+IFs2MTExNzIuMDgwMzMyXSBGcmVlemluZyBy
ZW1haW5pbmcgZnJlZXphYmxlIHRhc2tzIGNvbXBsZXRlZCAoZWxhcHNlZCAwLjAwMSBzZWNvbmRz
KQ0KPj4+IFs2MTExNzIuMDg5NzI0XSBwcmludGs6IFN1c3BlbmRpbmcgY29uc29sZShzKSAodXNl
IG5vX2NvbnNvbGVfc3VzcGVuZCB0byBkZWJ1ZykNCj4+PiBbNjExMTcyLjExNzEyNl0gc2VyaWFs
IDAwOjAzOiBkaXNhYmxlZA0KPj4+IC0tLSBzb21lIG90aGVyIGhhcmR3YXJlIGdldCByZWNvbm5l
Y3RlZCAtLS0NCj4gDQo+IFRoZSBhYm92ZSBzaG91bGRuJ3QgYmUgdGhlcmUuIGdpdCBhbSB0aHJv
d3MgYXdheSBldmVyeXRoaW5nIGFmdGVyDQo+IHRoaXMuIEdldCByaWQgb2YgdGhlIGFib3ZlIGxp
bmUuDQpTdXJlLCBJIHdpbGwgcmVtb3ZlIHRoYXQuIA0KPiANCj4+PiBbNjExMjAzLjEzNjI3N10g
T09NIGtpbGxlciBlbmFibGVkLg0KPj4+IFs2MTEyMDMuMTQwNjM3XSBSZXN0YXJ0aW5nIHRhc2tz
IC4uLg0KPj4+IFs2MTEyMDMuMTQxMTM1XSB1c2IgMS04LjE6IFVTQiBkaXNjb25uZWN0LCBkZXZp
Y2UgbnVtYmVyIDcNCj4+PiBbNjExMjAzLjE0MTc1NV0gZG9uZS4NCj4+PiBbNjExMjAzLjE1NTI2
OF0gcmFuZG9tOiBjcm5nIHJlc2VlZGVkIG9uIHN5c3RlbSByZXN1bXB0aW9uDQo+Pj4gWzYxMTIw
My4xNjIwNTldIFBNOiBzdXNwZW5kIGV4aXQNCj4+PiANCj4+PiBBZnRlciBpbnZlc3RpZ2F0aW9u
LCBJIG5vdGljZWQgdGhhdCBmb3IgdGhlIGNvZGUgYmxvY2sNCj4+PiBpZiAod3JpdGUocG93ZXJf
c3RhdGVfZmQsICJtZW0iLCBzdHJsZW4oIm1lbSIpKSAhPSBzdHJsZW4oIm1lbSIpKQ0KPj4+ICAg
ICBrc2Z0X2V4aXRfZmFpbF9tc2coIkZhaWxlZCB0byBlbnRlciBTdXNwZW5kIHN0YXRlXG4iKTsN
Cj4+PiANCj4+PiBUaGUgd3JpdGUgd2lsbCByZXR1cm4gLTEgYW5kIGVycm5vIGlzIHNldCB0byAx
NiAoZGV2aWNlIGJ1c3kpLg0KPj4+IEl0IHNob3VsZCBiZSBjYXVzZWQgYnkgdGhlIHdyaXRlIGZ1
bmN0aW9uIGlzIG5vdCBzdWNjZXNzZnVsbHkgcmV0dXJuZWQNCj4+PiBiZWZvcmUgdGhlIHN5c3Rl
bSBzdXNwZW5kIGFuZCB0aGUgcmV0dXJuIHZhbHVlIGdldCBtZXNzZWQgd2hlbiB3YWtpbmcgdXAu
DQo+Pj4gQXMgYSByZXN1bHQsIEl0IG1heSBiZSBiZXR0ZXIgdG8gY2hlY2sgdGhlIHRpbWUgcGFz
c2VkIG9mIHRob3NlIGZldw0KPj4+IGluc3RydWN0aW9ucyB0byBkZXRlcm1pbmUgd2hldGhlciB0
aGUgc3VzcGVuZCBpcyBleGVjdXRlZCBjb3JyZWN0bHkgZm9yDQo+Pj4gaXQgaXMgcHJldHR5IGhh
cmQgdG8gZXhlY3V0ZSB0aG9zZSBmZXcgbGluZXMgZm9yIDUgc2Vjb25kcy4NCj4+PiANCj4+PiBU
aGUgdGltZXIgdG8gd2FrZSB1cCB0aGUgc3lzdGVtIGlzIHNldCB0byBleHBpcmUgYWZ0ZXIgNSBz
ZWNvbmRzIGFuZA0KPj4+IG5vIHJlLWFybS4gSWYgdGhlIHRpbWVyIHJlbWFpbmluZyB0aW1lIGlz
IDAgc2Vjb25kIGFuZCAwIG5hbm8gc2Vjb21kLA0KPj4+IGl0IG1lYW5zIHRoZSB0aW1lciBleHBp
cmVkIGFuZCB3YWtlIHRoZSBzeXN0ZW0gdXAuIE90aGVyd2lzZSwgdGhlIHN5c3RlbQ0KPj4+IGNv
dWxkIGJlIGNvbnNpZGVyZWQgdG8gZW50ZXIgdGhlIHN1c3BlbmQgc3RhdGUgZmFpbGVkIGlmIHRo
ZXJlIGlzIGFueQ0KPj4+IHJlbWFpbmluZyB0aW1lLg0KPj4+IA0KPj4+IEFmdGVyIGFwcGxpbmcg
dGhpcyBwYXRjaCwgdGhlIHRlc3Qgd291bGQgbm90IGZhaWwgZm9yIGl0IGJlbGlldmVzIHRoZQ0K
Pj4+IHN5c3RlbSBkb2VzIG5vdCBnbyB0byBzdXNwZW5kIGJ5IG1pc3Rha2UuIEl0IG5vdyBjb3Vs
ZCBjb250aW51ZSB0byB0aGUNCj4+PiByZXN0IHBhcnQgb2YgdGhlIHRlc3QgYWZ0ZXIgc3VzcGVu
ZC4NCj4+PiANCj4+PiBGaXhlczogYmZkMDkyYjhjMjcyICgic2VsZnRlc3RzOiBicmVha3BvaW50
OiBhZGQgc3RlcF9hZnRlcl9zdXNwZW5kX3Rlc3QiKQ0KPj4+IFJlcG9ydGVkLWJ5OiBTaW5hZGlu
IFNoYW4gPHNpbmFkaW4uc2hhbkBvcmFjbGUuY29tPg0KPiANCj4gRG8geW91IGhhdmUgYSB0aHJl
YWQgZm9yIHRoaXMgcmVwb3J0LiBJZiBzbyBwbGVhc2UgYWRkDQo+IENsb3NlczogdGFnIHdpdGgg
bGluayB0byB0aGUgcmVwb3J0Lg0KVGhhdCBpcyByZXBvcnRlZCBpbnRlcm5hbGx5IGJ5IFNpbmFk
aW4sIHdlIGRvIG5vdCBoYXZlIGEgcHVibGljIGxpbmsgZm9yIHRoYXQuIA0KPiANCj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBZaWZlaSBMaXUgPHlpZmVpLmwubGl1QG9yYWNsZS5jb20+DQo+Pj4gLS0tDQo+
PiBJbiB0aGUgZnV0dXJlIGFkZCB2ZXJzaW9uIHRvIHZlcnNpb24gY2hhbmdlcyB0byBtYWtlIGl0
IGVhc2llciBmb3INCj4+IHJldmlld2VycyB0byBjaGVjayBmb3IgdGhlIGNoYW5nZXMgdGhleSBh
c2tlZCBmb3IuDQo+Pj4gICAuLi4vdGVzdGluZy9zZWxmdGVzdHMvYnJlYWtwb2ludHMvc3RlcF9h
ZnRlcl9zdXNwZW5kX3Rlc3QuYyAgfCA1ICsrKystDQo+Pj4gICAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4gDQo+Pj4gZGlmZiAtLWdpdCBhL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2JyZWFrcG9pbnRzL3N0ZXBfYWZ0ZXJfc3VzcGVuZF90ZXN0LmMg
Yi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icmVha3BvaW50cy9zdGVwX2FmdGVyX3N1c3BlbmRf
dGVzdC5jDQo+Pj4gaW5kZXggZGZlYzMxZmI5YjMwZC4uOGQyNzVmMDNlOTc3ZiAxMDA2NDQNCj4+
PiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icmVha3BvaW50cy9zdGVwX2FmdGVyX3N1
c3BlbmRfdGVzdC5jDQo+Pj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnJlYWtwb2lu
dHMvc3RlcF9hZnRlcl9zdXNwZW5kX3Rlc3QuYw0KPj4+IEBAIC0xNTIsNyArMTUyLDEwIEBAIHZv
aWQgc3VzcGVuZCh2b2lkKQ0KPj4+ICAgICAgIGlmIChlcnIgPCAwKQ0KPj4+ICAgICAgICAgICBr
c2Z0X2V4aXRfZmFpbF9tc2coInRpbWVyZmRfc2V0dGltZSgpIGZhaWxlZFxuIik7DQo+Pj4gLSAg
ICBpZiAod3JpdGUocG93ZXJfc3RhdGVfZmQsICJtZW0iLCBzdHJsZW4oIm1lbSIpKSAhPSBzdHJs
ZW4oIm1lbSIpKQ0KPj4+ICsgICAgc3lzdGVtKCIoZWNobyBtZW0gPiAvc3lzL3Bvd2VyL3N0YXRl
KSAyPiAvZGV2L251bGwiKTsNCj4+PiArDQo+Pj4gKyAgICB0aW1lcmZkX2dldHRpbWUodGltZXJm
ZCwgJnNwZWMpOw0KPj4+ICsgICAgaWYgKHNwZWMuaXRfdmFsdWUudHZfc2VjICE9IDAgfHwgc3Bl
Yy5pdF92YWx1ZS50dl9uc2VjICE9IDApDQo+Pj4gICAgICAgICAgIGtzZnRfZXhpdF9mYWlsX21z
ZygiRmFpbGVkIHRvIGVudGVyIFN1c3BlbmQgc3RhdGVcbiIpOw0KPj4+ICAgICAgIGNsb3NlKHRp
bWVyZmQpOw0KPiANCj4gU2VuZCBhbm90aGVyIHZlcnNpb24gd2l0aCB0aGVzZSBjaGFuZ2VzLg0K
PiANCj4gdGhhbmtzLA0KPiAtLSBTaHVhaA0KPiANCg0K

