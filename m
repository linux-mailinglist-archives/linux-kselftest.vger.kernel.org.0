Return-Path: <linux-kselftest+bounces-26599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29CEA35233
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 00:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614CD16B716
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 23:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C94D1C84A1;
	Thu, 13 Feb 2025 23:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="W0jyA2Gv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ADC2753F0
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 23:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739489510; cv=fail; b=UkKWAMCyTNW2SGuzB8+KFtoscN+keSrVCHXlRRSJ85YyxZ2SF+lvRtj2GYbjGhIFsoxpUOSsFFUCNIrxLSWw8PGSVTg48d4X/PZAqe9+34vfWSGAci6HOpbvhOektDVg97Gkd1zIZSFDU06FT/ER+RA83HhuSw6HH3OJTuQUv2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739489510; c=relaxed/simple;
	bh=KhcsnxcJe5p/jSfQtXJgt35ZQCyXjalGOxsS2jqTCT8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ii9QSVFgmpqt4TMgi1D4vaKQyJaWdRty/uamH7Q+KLlZPoAKErFLaC9veQ/Ws1ZRz6veflIMhUuJ4FeauvVgGuQ/mCNA3lAx65KusgfDljdpbCbkvm21A4njI8beXrCvknNk8C2iyWByy+0qmMg6GSWVz57FCRrpTlkIIfllBOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=W0jyA2Gv; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DLdPAf022544;
	Thu, 13 Feb 2025 23:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=Khcsnxc
	Je5p/jSfQtXJgt35ZQCyXjalGOxsS2jqTCT8=; b=W0jyA2GvS7xwNp7r50Hz3XO
	MwMCd0jW0kepIS3xWpFW4G+IzlibNgkrlI2uOz7jPEOpZedn1wHqyDv8isTSnYWC
	gpGqVu8eSxbk7+A0FtV58i8bpsMS7bmb7JmPGFaOt3HtO+m/Y9ZUjnq+MAwfwpuQ
	IElZrGcGj6b+qRS7nd9zzYpTr76qq3y4H5ZS6TIArlOZNXxmCq94ULvqrJ464Lzy
	U8adnE2Xvt0XmySkeeU6NEl09TEwqnQZS4/QAy5/IyPWBwZdYPs8PC2xrf/YBNZ3
	DGo778XPw3p/XUbsTfs0trUXN2XF9EE/LS8BJHbE9S9UDhQhk+6zeyzqntgFs0w=
	=
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 44p0mpd213-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 23:31:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dI8ygHFpI7BqPUaWArgRWozTKQP3T3AmbxSyH8jN8+mTaK4zwY5Ikk4sK4EyKcGHlT1qM8n8kdeF3YIA0wwKEGO/Z05c8NxfiuuAo6CJIHWR+PO972J+Ui0gJRLUcDZ/UBFajbFAuKX0Sa2cP6aOPegiqpt+9KZCOtZwB7hfkBlzyDM+PvLpz6nH7S1T1AruPKzeWOualQL8LQHcA4Z4AD9mlGT7wmaz8jpAO0bw850vNIXw04n9X0Xm7b9QGyIACJH+0LF+STLg+TfXpLo8yu5hFNoO71pkT/AHv1uaJ9AMJ0PcZKPzyPMiV3com31pjf6dGVy4oKMW6ZJaIovDlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhcsnxcJe5p/jSfQtXJgt35ZQCyXjalGOxsS2jqTCT8=;
 b=g1GHOKQEn/VOimkbfwA3PDOY3JoyjnITamsg+XDD6WnLEsinYxPIo+qTn0k2eir4skq9Lmimtjh0dsZVb5t46Y+FSrPvyG7XcoLAwY5JVicqOYflCcp3VBJmeFtEGloYk7gfh3QPmse7otxAwsXb0SFO5Sd4+8l4hQJbKrDIfboszrd6xPxAQBjBoYjh7hHyl3IQquuzNsGcqZEBDSTUVgTUXaVwK0WipwCS0rjYwNSs/ux3zMQxltUaZc0g8Z65IjGO/qOoZ9RstnVwVrZ8UYZCo2Bd8VVzdHc7OEfwAFf4eIoN5xNE76I9hvl7tQd0d6vaI/vv4d0zCeVOG/HBKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from MW5PR13MB5632.namprd13.prod.outlook.com (2603:10b6:303:197::16)
 by PH7PR13MB6090.namprd13.prod.outlook.com (2603:10b6:510:2bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 23:31:25 +0000
Received: from MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197]) by MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197%4]) with mapi id 15.20.8445.008; Thu, 13 Feb 2025
 23:31:25 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Marcelo Moreira <marcelomoreira1905@gmail.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "linux-kernel-mentees@lists.linux.dev"
	<linux-kernel-mentees@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        "martineau@kernel.org"
	<martineau@kernel.org>,
        "~lkcamp/patches@lists.sr.ht"
	<~lkcamp/patches@lists.sr.ht>
Subject: RE: [PATCH] Adds colors to kselftest output
Thread-Topic: [PATCH] Adds colors to kselftest output
Thread-Index: AQHbfl5UPKp6tYDVoUSs8bfFnbNWELNF38tA
Date: Thu, 13 Feb 2025 23:31:25 +0000
Message-ID:
 <MW5PR13MB56323A7DE07549AC6F7664AAFDFF2@MW5PR13MB5632.namprd13.prod.outlook.com>
References: <20250213212858.710884-1-marcelomoreira1905@gmail.com>
In-Reply-To: <20250213212858.710884-1-marcelomoreira1905@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR13MB5632:EE_|PH7PR13MB6090:EE_
x-ms-office365-filtering-correlation-id: eb083630-2833-4679-34f6-08dd4c868870
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZlpzS2pLai9uS2xKWXB2ZmcxRG14b2RCdVhaUE83QnhEZjJZd3MvVDB3RGE1?=
 =?utf-8?B?c0xyakk5VlM4Tll6citRcmw1WkNubWNETTQ0TDBHWXEvNU5kS1k3emRDZXJG?=
 =?utf-8?B?NWIwUjNJZDJGUCt0SjVWR0g0MDNUajF3TmFTTWtxUWhTaGdBQmlCZ3VrNzV1?=
 =?utf-8?B?VTh0aGo2Yi9tN2h2Mk84SVhoUnMyM25McHNYK1NjeDJNWUlwQzk0eFBkQ001?=
 =?utf-8?B?VjMzZGgvNWlnRW5rejQwT1JIZTJjS1lXNEg5UzJTNXdHdDNSUTF1dlAzZVZQ?=
 =?utf-8?B?OGxQcEZidFdFQkIwR0EvQnJLUHdsZUdKbm9zODEvK1Jxclh0L2syV0NZTUw4?=
 =?utf-8?B?aStHUjFmVDk2eWtEZnVQRzg1cTNSZkllN1lWVDRkSU45U1hmbXdRbXViZG5H?=
 =?utf-8?B?MW5GMWdBTlQvMnJteXlqdVZqbUlKZHVvZGQxNW1UTUh5djhPaS9UOTRpZGhw?=
 =?utf-8?B?WWg1ZTd2YXVOMmdjRTBpTW4zNVRPRFNQMUgrMUxobDBNWUJ0Zm8wQ3VZaGxK?=
 =?utf-8?B?ME96QU41bERjUGhjRU1lMG56N1VCZ3FQY0w2NGh1clg2NjRobUZpUDZZbVk3?=
 =?utf-8?B?MGJhdlVaOGNjVlVjQlgwS0dJY3NUaSs1SXZGZCtZYWMyRjd1dzRYMWtrbVY5?=
 =?utf-8?B?TkE0WDE1eTQ0eXl6Y3IwN2ZMbWlzd1lmeW5TT2JrVGlkVDRLOUlJcktKTmp5?=
 =?utf-8?B?SThUa1JoclZmTmFzeHlZUkxCRk9yOHBBS0lNQXJIMjR4Y1kvbG9yNG1QNVU0?=
 =?utf-8?B?YnQ5U0FqcGhDVUdjTUR0YWcxL0JsREVDbnhRZmtuYlNwMXQ1bFpHK3Q5SGJv?=
 =?utf-8?B?NVY5bml3K1hIVnZwamN6bmJDUGQ1cFZLWXNRenJIWWFHM3EyaVBxOEl2SGhs?=
 =?utf-8?B?dDNyaExWYkY1dTFSMHVYSCt5VldBazFGdTRHR3l3MzdUT0pZL1VvcVlFSmVX?=
 =?utf-8?B?enppclhqMGhyczBRWDI2TGdJRXBTYzZzcTQxN1VKTzZBRlJTTm92TVVBeDFa?=
 =?utf-8?B?bFhCSDVxQTVsTGViUkV5REhTRWlKQmhsYXRQUUNzTlBkVTk3dm5wK3BtVVZL?=
 =?utf-8?B?V2w4NWtoc0pxZHZZVXNKSm1CZmVTd0NWSWlOWFMvSDVGV1BJeVc2SzloL1Bv?=
 =?utf-8?B?alJDRG5pemNyaEkrRjJEL2VuMVR0SGFIc3hCRFh6V3Q1bjVjSm8rZHlpOFNN?=
 =?utf-8?B?SUl5NkxyelNrcVJIdU9wZVkzVEJiS3BjVVZNYStkOGRpY1FlSy9NQVRZWmZu?=
 =?utf-8?B?UVNYcm5Uak14Sk5TUndWQzYremFvQjl0WTlyajhjRUR0OVIxeUt5K0JsVmR6?=
 =?utf-8?B?NTdaR0FzN1U4dG1RWi9hcHNldjQ0M2pnT2l0RitnLzU5TWZUSkkxcm1TQzFt?=
 =?utf-8?B?c1JjTThaSmZ2QWRIcGE5YmVEbGRIcENtV0xtVVZYUmZXSysyTGF3UEVaYjBK?=
 =?utf-8?B?aXVxalZKczVPRnYyQVlmek1CQVRRSmkxS2dUc3diVHIzbFFpRzQyMkNXa0NL?=
 =?utf-8?B?TnE2SzlrV1c3RURlMlFTSFFwZ0t0cC90ZXIvSk1MRXVYNEdYaFhIbzhzSUg3?=
 =?utf-8?B?NGxlNGJlNEUwN0M1c1paMnNOM0M5dWhjaTNVbWE3cG5lbGM5cTgvZllPUXZw?=
 =?utf-8?B?ZGUyandHUm9BU2NFUU82RnVYVFpvUnRTZUJDdks5SFNFbXBTU0llMkdmYWhK?=
 =?utf-8?B?a3BTbU1yT2ozSi9KN01XQ1llbTVYdUdHdzF2d0FpVVJuOHFJODRGOWhEOXVh?=
 =?utf-8?B?QTdWMUo5MTdqTDI2TnYxM3ROd2w5SUZtWmZqRW9MNGoxRS9zeUJVYTRBNURB?=
 =?utf-8?B?cXlabmlaWnpoTXRMVVZUNnEzYUJDUG96S2s0Z2M2WitSMVE1RzdnclYwSHVB?=
 =?utf-8?B?bXc5Uk5RMVpiL1N5YW1BTlNUQXZnZ1liZm9IY04vMmZsUTM1Y3FJY3Y4Z0VE?=
 =?utf-8?Q?JsbTXYgf4H97bf2CGgUYAKvYob2blcmU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR13MB5632.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U0dEM2ZxL3VBVWs0cHlSY0NKaVlrY1AwNnFva0FwZGx5NzZsRVJpVk9yVEp4?=
 =?utf-8?B?Qy9KbFU0eWRWSEtvYjg0Q1lPUGY0bFY4YUdLKzF2WVJHY1BFekdqV3REaTl3?=
 =?utf-8?B?S1BYT3pLQ0Mvc3NQT254NS9JV2ZNamNINzI2RFlCUUlHdldJN0tHWk9IejJQ?=
 =?utf-8?B?OHIyd0RRRFFCMFFJTEVZOEJIU3Eva1RlSjJ2OFl6amFhZy8vK3BLVFl5bkdB?=
 =?utf-8?B?VmtNWDRHZWxpS3VXYm1TNFloTmFkQ2o3RlI4MXBYR0RzeUhmY0RNdzhIY0I4?=
 =?utf-8?B?eElydW1vQ0hWenFRNXU0Q05sZ3FxSUx6cnU2MjVCM2Q2eG82SXdZeXdRbjRt?=
 =?utf-8?B?YlJ4VDY4Q2lIWkZ3YVRFdzVTWGNxWWZGY0tRV0xTd3B6akMwZ3hpVW1weHBa?=
 =?utf-8?B?ZHV5YjV2Y0lpdmZKaS9acGtMWEc1cWVMU0VKSU5EOXFqNG9BM0srSUhVY3oy?=
 =?utf-8?B?RDExZnRiTlBhVmZTWWxWWityamhlSnlxdFQ2S2FJMUViaUJrOVIrTEFISTNo?=
 =?utf-8?B?ZWFtVTV2N2pzY2c4ZWIyZis2TkhsYkFJN2h6Uml1OXdSYlc3eE4xTGp4dEMy?=
 =?utf-8?B?MFVQdDlkM3graG05cndDYUptMHlqMjl5d2xzMnVFRzVpZS9kcGlFdnRZSUdX?=
 =?utf-8?B?Tkx0VC9yaEdxZk5SN0RsSUZNR0hrcHhVdWFQTEphSHY4VWN4WEVPcXFIeWti?=
 =?utf-8?B?c1ZIWmdYVytLdGd0TDFlblk5bHNCQVlVd1BsTGpkK0FKbnpmSW82RkhJNW5B?=
 =?utf-8?B?aTVRYXR0cldjcXFuVVNZUWJoSlF1amJ6bjBNZjZOSlVwdzJHQXQ4WWJOV3JL?=
 =?utf-8?B?RHlqa0swODlpc3gxYmk1bHJDRlVrRW1JU3ZENWpZSnZMZTZsSnZjczl3WDh6?=
 =?utf-8?B?MVBncTNZc3pBQThKdGtaT080U0ZLSU1KRDJJbXNJVXJqSzdieFJDOXNUM3pX?=
 =?utf-8?B?L2lYQVNOT1hHUXNpaDhKdCtzOHJKMWdwSjhNWEFxdWZYdFNDNkF0RERhTEZu?=
 =?utf-8?B?WnAxSFBuUk82NFdRaEtZcXU3UUZqaWpBNW5ZOENySVFTL0xCNUgraXRnVkF2?=
 =?utf-8?B?RnBTZkp2Z09ZR29IdXFuZGt2NDd3dVU5bTFiSjF6QkZMdmV0Rm1YS2NodTc4?=
 =?utf-8?B?WHdzRWdYT25YTUc3enQ0NW5ZQkNrWmg3alpRNzdrajdMbXBGb21JTHRjK2Vz?=
 =?utf-8?B?V1lObmg0QVRRRE80RWlYZGlkQlcrdDF1dVpxMjM0ZHl0RUJ1QXRHVWQwRWdW?=
 =?utf-8?B?OE5DRWtNMVpsMlc4eVlXS1NXaTZjYWJDQUtERFJPQVFlRHRUNHhhaDcrN0tD?=
 =?utf-8?B?NWsrWkF6Vm5JMCtjK0pmSms0UVpTdEdxZUNoSEtDN3VNMTlZa3FQM2xxUmw1?=
 =?utf-8?B?SEJTY3RHQ2xKZVdteWU4ZGlJR0FtTEUzTmtCYWVtYk1Eb1RrQWNXQXRqS05I?=
 =?utf-8?B?VDI2SHlEV2R6K0t5Y3RXTVVDeVFoV2dSY0Fxa2QraFl5d0lpQ1hxYzNTMXYz?=
 =?utf-8?B?dzFXSXNpaTZxek11VlA0TnF5M08xcFVraVVJelg2WFh3RjNnaTRNa2RDYkIy?=
 =?utf-8?B?RzFUUEdiSGFJd3ZLa3ZndlRSVitxMjVtYWFObWRMZUNiNXJSVGV6b1FoaVVq?=
 =?utf-8?B?MSt1VEd6TkQrRVd3Y3pBV0tCUzF4YytvRTZEaVAvWTUrNEtpY0t6a0JQZ3NV?=
 =?utf-8?B?ZnhzejJIeXZSdW9SVkx2ck8vSDFFNmIyUStEWDVrY3Q0RmVoRUpMRkNySGxC?=
 =?utf-8?B?Mmk0YTZrWmxkQWZqYnNqSncwTndBdkgrZkRwVXVuajhrbXpYejVyQmtrTWs3?=
 =?utf-8?B?a0tVYTZEeC80dGxaMUhQY0h3YTV5K1BONkJSUHF2QUY1OC91TjNPK2hobVhq?=
 =?utf-8?B?TnFsTUk2Zm9NVThvMkR3NXU0d1pZalpJTEQ4WVlpV3gyZFo1b2EwT1pEK2JK?=
 =?utf-8?B?WHlLUGs0TTQreGIzTzRNb2FsQ2xvMW1jbkFKRHBkcDlWYzBqbmdobFNhU2Iw?=
 =?utf-8?B?YTlrblFqdkNPbE9RWWYzdGNOSUJ0MnplZEZOR0pnZ1FSZjQ3VW5DNEFqTG05?=
 =?utf-8?B?b3h0djhnUmZPUlZLWjYzZUp3ZzJ0RWUrdHpKK2lVTDhoS1VLQnBaTWJOV2xH?=
 =?utf-8?Q?5OFg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	glm4nv/0wQPsVCcfdbv3B4oDJxPGlsBoqJtbhXePGQj7wKCKPq3/e3JQqTXUgsPMiO3mtbw7JOK7pWmsBqFGKHgw3PEYU0lQvMpjOE5kTzr5Xzm7xNeqOvRX/00RdXWQSuo08e5N94XFevrsTX/NSw2l/jBYMEK2wAKCdETMtoovBcR3l9ru5Njhdfal4XbYSqCyBlJJcEmgJSeyl9tq+/zUHdAlTrXRuZNL8MTNZHI7+hAcwqltAS9ub3VFIx50D+mYfb85MjnTFj6ovCphkf62s7WOLv+Z5LdpFGfbcfZX2eDp0NmcGGNu7Ny3aQI4C3luu6N0pLSNVO4kJ7i8De1p4hoT2ODVgDtJEKIPQ/tZXiB0NK55aCgvXXDnlxHnJBaJCYASlytPNgbpTroNHU2xdAM+Gou8tClK7LxqkmuSe9jbgekcuixlXzqOqvqwR9N79HPH9nyoHEFv+CK44VSNuqUxP40tGjbpRa5/7qh4UMuV0wRGiBldqbOEqxlP9R07gT9vecUBn5ktV5lu2g8Zx4xpQC7rYpZe/5e6cgmUZo0qfFe0pR4zvk2EUdMBvhilw2Xk0jmxrBjb9OHh6hO6B/YeZ1V9x+rlUmm6kRleDADDJbVLeEgHbhisMvtV
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR13MB5632.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb083630-2833-4679-34f6-08dd4c868870
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 23:31:25.4344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 40BD4vAB3Ii7ivFgx1I8VK8wpB3CfSh/N+teupcEJ/YaNquHQdIZjkkiug0Gpx0sM/f1C2j/cQQ+bxIYPxtrLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB6090
X-Proofpoint-GUID: _MTSbYOCiMcEAotZJHEU85RaLrWvCXoF
X-Proofpoint-ORIG-GUID: _MTSbYOCiMcEAotZJHEU85RaLrWvCXoF
X-Sony-Outbound-GUID: _MTSbYOCiMcEAotZJHEU85RaLrWvCXoF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_09,2025-02-13_01,2024-11-22_01

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjZWxvIE1vcmVpcmEgPG1h
cmNlbG9tb3JlaXJhMTkwNUBnbWFpbC5jb20+DQo+IFRoaXMgY29tbWl0IGltcHJvdmVzIHRoZSBy
ZWFkYWJpbGl0eSBvZiBrc2VsZnRlc3QgcmVzdWx0cyBieSBhZGRpbmcNCj4gQU5TSSBjb2xvciBj
b2RlcyB0byB0aGUgWyBPSyBdIGFuZCBGQUlMIG1lc3NhZ2VzLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogTWFyY2VsbyBNb3JlaXJhIDxtYXJjZWxvbW9yZWlyYTE5MDVAZ21haWwuY29tPg0KPiAtLS0N
Cj4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9tcHRjcC9tcHRjcF9saWIuc2ggfCA0ICsr
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L21wdGNwL21wdGNw
X2xpYi5zaCBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9tcHRjcC9tcHRjcF9saWIuc2gN
Cj4gaW5kZXggMDUxZTI4OWQ3OTY3Li43YjU1ODU1ZmY3ODggMTAwNjQ0DQo+IC0tLSBhL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9tcHRjcC9tcHRjcF9saWIuc2gNCj4gKysrIGIvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvbmV0L21wdGNwL21wdGNwX2xpYi5zaA0KPiBAQCAtODMsNyArODMs
NyBAQCBtcHRjcF9saWJfcHJpbnRfZXJyKCkgew0KPiANCj4gICMgc2hlbGxjaGVjayBkaXNhYmxl
PVNDMjEyMCAjIHBhcmFtZXRlcnMgYXJlIG9wdGlvbmFsDQo+ICBtcHRjcF9saWJfcHJfb2soKSB7
DQo+IC0JbXB0Y3BfbGliX3ByaW50X29rICJbIE9LIF0kezE6KyAkeyp9fSINCj4gKwltcHRjcF9s
aWJfcHJpbnRfb2sgIlwwMzNbMzJtWyBPSyBdXDAzM1swbSR7MTorICR7Kn19Ig0KPiAgfQ0KDQpU
aGlzIHNob3VsZCBub3QgYmUgZG9uZSB1bmNvbmRpdGlvbmFsbHksIGJ1dCBiYXNlZCBvbiB0aGUg
Y29udHJvbGxpbmcNCmFuZCBDT0xPUiB2YXJpYWJsZXMgZm9yIHRoaXMgbGlicmFyeS4gIFlvdSBz
aG91bGQgYWxzbyByZS11c2VkIHRoZSBleGlzdGluZw0KY29sb3IgcHJpbnQgaGVscGVyIGZ1bmN0
aW9uLg0KDQpJT1csIHdoeSBpcyB0aGlzIG5vdCB1c2luZyBNUFRDUF9MSUJfQ09MT1JfR1JFRU4/
DQpvciB0aGUgaGVscGVyIGZ1bmN0aW9uIG1wdGNwX2xpYl9wcmludF9jb2xvcigpPw0KDQo+ICBt
cHRjcF9saWJfcHJfc2tpcCgpIHsNCj4gQEAgLTk3LDcgKzk3LDcgQEAgbXB0Y3BfbGliX3ByX2Zh
aWwoKSB7DQo+ICAJCXRpdGxlPSJJR05PIg0KPiAgCQljbXQ9IiAoZmxha3kpIg0KPiAgCWVsc2UN
Cj4gLQkJdGl0bGU9IkZBSUwiDQo+ICsJCXRpdGxlPSJcMDMzWzMxbUZBSUxcMDMzWzBtIg0KDQpX
aHkgbm90IHVzZSB0aGUgaGVscGVyIGZ1bmN0aW9uIGFuZCB0aGUgTVBUQ1BfTElCX0NPTE9SX1JF
RCBoZXJlPw0KDQogLS0gVGltDQoNCg==

