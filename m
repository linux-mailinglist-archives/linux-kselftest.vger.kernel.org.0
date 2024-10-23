Return-Path: <linux-kselftest+bounces-20488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B25FF9AD02E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 18:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4134F1F21AC0
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 16:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3B11D014F;
	Wed, 23 Oct 2024 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C9whuHCw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ORFCBFFe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABB91CFEA4;
	Wed, 23 Oct 2024 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700549; cv=fail; b=bpGC07ubpbAVARRPixpAvTPdHRL9zEDzSXVvrs2x2S5/DsxWTtzAjE75yi7JVpXKwiH7CebdADyhlmODx61J31xZd2+QxWrqvzN3fsqM5ZRvJx3vttEt2KJyMJnBMHxZppf9/yYBiFKb8NA4puiCekfVqGxjFZEjNcKyXNmx8XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700549; c=relaxed/simple;
	bh=Vv2wvlEzXkAWDaIf9pv/80Ip7adK8QyYii8+wo4TyPY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c3Tp81Pxv00374/k/MhNaXsgZsb/InqkcbYRyOosxlT0rSIqPEd1NU2dXqkVwNjPr7YYmxI8mkDVpOS98ZzdvkKISTiKiePODVC6fnwM8AVUxD1D9eeiTFJHyHUSf3rQ0IZaBiAs+cAEvnEShmxiVGGQjc8KHrk7GyXEafSBXTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C9whuHCw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ORFCBFFe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfdPL025347;
	Wed, 23 Oct 2024 16:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Uk/CRNpPCjkKn91bzXpnuKQxqTJl1pqa2VontwKCt7k=; b=
	C9whuHCwmcCJvE27t9K1vw6vfiHbgg/qOeUbOdgP0mbqRh5VDTQPbM86SsTd7ouI
	IeKEXXSg+40NhSvI9mYtdkzRfnVsNAAlwbodNXQ1YXHb/E8lvISsxZORlg5/f0PN
	WE6khRWHZDWkn4wDCy3L2VTY2zliYAIXGBhRAQXrSw6quvR0qEkEawC4oMx11Ut+
	jL62o7tk2WAN7FtyuuN6hgPbFpT15SSEIeImKG02K9x+BcWdRvRM7g5gbfhVow1v
	yZLwcmpXSmb+IUMb9gyAfMx+w3lABzQMAPYUrvh8+I3M4IFIh/GzCFqofECQ4iE5
	eIgATgTTJvdHECSQMnvOSg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5asghx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:21:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFu1HM018529;
	Wed, 23 Oct 2024 16:21:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhjs2vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:21:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCF5pjMx8LXSQvyUSu346UljjVlogexMYW5lDkwLmHBuRsqjOnYVkxpwoyTf1uYyZ4OKsUniqbVKmD4im4JaRRLbnOrXFMTMy7D5plUyzr0GnLahqU1QOZse2T++sB1JFS01EtBw4uhNzURRWvJIB880+rXaz7UNrqyLP23cszBH+ZuGEJ06yBzPfgDQg1sIl7xz7K+fJWex12OqPcPhaS6vJ+FNmbafKRsDHsSXLruyVPOW2NNWngl13JYQh/q2hGovfLRs6NU2yzLHQLa8CTpG9TsL0x9UzhCEFe9fHfSPScgvcP2SMFeYujch9YLGGKmH6ZJNyRiYhX38hn8CYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uk/CRNpPCjkKn91bzXpnuKQxqTJl1pqa2VontwKCt7k=;
 b=ClFNTgmCZqhkt3InkeEWQrhQcDz6zye7xRRMZa192WlDJHSJ0f8mO/MVLbG1cnqLXmJkmcWCx6zG8pb6crbYxjhGwk/qb9kVBiOHZOX1eUwA9KVBcROCzt0jIWyLcaoKJqzaLkUyyxTzAzdYRTv+z1U48qUU7FbzEwavMutCwxAiolBfCSwSyA/9NiAa2LhykxI2H0pBWGNklxwVbpkR0iViKQw+6I5jIpbKMYx4Uny20kymmZuTA2f+6MWufv/3KIxfyqb3Ni2JoQzYh2DYWVjnKWNPeWac7WBvPXLBCR2dxTk5wD1BZjN5Zsni+6exhteRcolkuX7h0+QdPalyuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uk/CRNpPCjkKn91bzXpnuKQxqTJl1pqa2VontwKCt7k=;
 b=ORFCBFFeROU6afkEUKzyigfUBDp4HjOhYAZQKflYIzaMuDaxn96wlUxcOj8mLB8YbhIoQxXqsTqpFMOiyvpafeHx4vDixdEHpI9rrh8Y42RVCycaZJsgOaJzLpFQp2S32LNKMOnMS7g25V8lKxu6VPxEHaDiDBXO02boFzLgmaE=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 16:21:21 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 16:21:20 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: David Woodhouse <dwmw2@infradead.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
        James
 Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo
 Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>, Shuah Khan
	<shuah@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>,
        "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        Francesco Lavra
	<francescolavra.fl@gmail.com>
Subject: Re: [PATCH v6 3/6] KVM: arm64: Add support for PSCI v1.2 and v1.3
Thread-Topic: [PATCH v6 3/6] KVM: arm64: Add support for PSCI v1.2 and v1.3
Thread-Index: AQHbIkvgwayiQjBgCkaUzLnUZaycrrKUiokA
Date: Wed, 23 Oct 2024 16:21:20 +0000
Message-ID: <31FFAD74-391B-4A6F-8B17-D269E3C103D4@oracle.com>
References: <20241019172459.2241939-1-dwmw2@infradead.org>
 <20241019172459.2241939-4-dwmw2@infradead.org>
In-Reply-To: <20241019172459.2241939-4-dwmw2@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|PH0PR10MB5893:EE_
x-ms-office365-filtering-correlation-id: 92577e51-0a9a-48c7-96ab-08dcf37ebb08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OyuHsPf9TykG/b+/KNO0Z3q8DhkO6qjGfwAJx5y6tBgQ2b0ZVhb70yfYs1kw?=
 =?us-ascii?Q?MWk/pyRucJsJav15j12Jgulm5MpK+Hpfn7Vir9tYIVIsgKu9rgaRP9h2RSiV?=
 =?us-ascii?Q?YpjLOho9qpfyBN8ok15zIDhMjjudJU8RUNNNWgMCp4qOKqb7Tw8aF3jjGgKw?=
 =?us-ascii?Q?wres4j4gLc1UeUfaZh6ElDgPwZg1xAQBkk9VM1BMiIwJ8Lmh6Ft1PTVz1e3v?=
 =?us-ascii?Q?7xdI13MbODtcWGDCglxQhyl95OTyxro7Plcj6stM0N5jfPerpFCgbMAe0Tyi?=
 =?us-ascii?Q?bgPodYXC2ZBfW6DzOB8/shAtcl4n6AmO2QGEyiZ+JPGquYhphcYgN+u8ATEo?=
 =?us-ascii?Q?onWs7usqN4tG1NjVH3gdYdu6hNuw3WoctDziXdaOkmbL+JJw5phksNF3x3Jq?=
 =?us-ascii?Q?cKEqLfF9hNTBya+f1jsbsL2NRo8PBd9w7iPHYQ4v0kE0W0uDXgaxVqo88P86?=
 =?us-ascii?Q?vH6n4z/N7KPOjY6Sy4/tf5bFnRCCEt6ivgfYc3KYhEPTg3onbjPizBXs7vVn?=
 =?us-ascii?Q?l4bhiz9yV/5O2aLMkvYESWQXNtRQssYLGEH1MnuOa/xkikX7iMfYLOIdEmvy?=
 =?us-ascii?Q?dLHDVAQuPAkQyIx11h7JbdkchiqaJiZiFQBCSd131iiPoN1CABlYCdfZYzg8?=
 =?us-ascii?Q?lrYX3i8KVKStJXd5sgkbN4i6ONw/M3ifO42Xm27BM6nGrBdi4FnKglaQ5Z6X?=
 =?us-ascii?Q?qVL6jfGjhbQuBGDgSM0liilmsfBEcXdvdGbe5WCPHLVI2mnGMwI1lvSA9ugr?=
 =?us-ascii?Q?o6sb3i0MxaxSO1LLAxdsYKJYb1YksWYZly5uKr3Jecq841URcf27pMihwXd+?=
 =?us-ascii?Q?pWpzXCrYDzuReXcURkW5Xrnze5VHXMbkr0XAS3lPFWCzsl/I9XZI6qBhZDMp?=
 =?us-ascii?Q?dDbnSK0qTRi3f6gY6DXNXkpUyaDASBWC3JwJ6hQGN3u/9uWF7B99wJE0hltp?=
 =?us-ascii?Q?ViaUte5vsHb89Aqvt7Gi6TBeulXsbCvYTJi0UZUnX+Oa9Sqm42JherVA5Y+n?=
 =?us-ascii?Q?4SkcKuQ83HnI8lTYG9vz5kac/4EsKUyIWNsu8gskRjD0AnLH9A1hDm8nnWqj?=
 =?us-ascii?Q?8aZypqtanMmTEFyCZWz3m2Kf4rqACtSNfjpGmVYt56vS5c45WiH/++MF0cJw?=
 =?us-ascii?Q?vlWDLvX/jAzNXS8bAaXu2uO4wn7EanpsFEh0HXKMPmYTLCSOU7Xc4sraEHUu?=
 =?us-ascii?Q?NyiL+DVITOd5TQas6CL07P8tQlrlh0Tj4eMN1sqSzrqc7O+kbuWuhiZbobV7?=
 =?us-ascii?Q?L49ucBmKCVPLL4WuA7lw7I3R6zHKtWgt0Hq2+Xb7oa0DsvKG5WnIXNsQncQ5?=
 =?us-ascii?Q?IS6kLZnVLLUTW6JraF04+uaWKgwM3m3utP0gdruPpytgJ6zJWfK8MxVMZ0EY?=
 =?us-ascii?Q?Fjoqj+s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HOsoNg/4mE4QGngGuKDu2VbT0wq8+FvAqhcLHln+JP3pyoeu4aKK8UnNVW3A?=
 =?us-ascii?Q?EnHnwQD1QnZWpAcrMYcQEt3bLQAOzi7m6Zc9nCvxS0rLNr7ReSbB/GmWp0oI?=
 =?us-ascii?Q?LFAq1+RtOzqoNsK6F4r0/tHgJSqlpaDIQh0G1qyPd8IysvqF52IbTDPGI1bF?=
 =?us-ascii?Q?Z80rE3rKb1Xsy516V1cZww2OkCEtNuqRZP1uhpAwRbfKE2S/cf6eOYH1LOzs?=
 =?us-ascii?Q?XaFAsuaKA6LH3dUMIABJ7N3IIt2m2bjKo3Ppkq6Td5yddAHX1AnLrLroqqUf?=
 =?us-ascii?Q?trAkB8fyfB1ONqYBczX1NJdy0qswMbGza76PjJjoMeJ8GcDSxkAQeYWGNx1m?=
 =?us-ascii?Q?DGQhn0Pc7/z1felYmclQMKxfXDxgxFINORCpJB/VK5atF59FVwbIkNfDAfxV?=
 =?us-ascii?Q?WoGef6Z6Rj5FBMm+YeP9Fr9WSZQEIIdN5WLB5q8QXYCnDXRwZFbPYMMHfdeo?=
 =?us-ascii?Q?VsIuLh1ZjemPOk/RvLtGpxrCdO1N0hcqGjBI8qhdniunXt0H7jiIFYsuzj5U?=
 =?us-ascii?Q?whmJ7mFOSRq7nwm2fw2uIgTA/H4LzWJigdxxmsupVHVyAgZLDmgoDUbqsZcv?=
 =?us-ascii?Q?bc73unpMCW8QIvL6UHKzClOVbMYWlAFrQpjawaLJa8IPe9cCMyvz1XUUZ1rD?=
 =?us-ascii?Q?rY7cecUmEQhEv856r9OZTpZQvhqdefg6NhdmmqFwtIj0fjT1ojhpgLC6IjdB?=
 =?us-ascii?Q?aW3EGnHeM55IGgIhg48mAw9QjzuOyLEcaMXJTqV38W6LA51Vgb8vexzvB1u/?=
 =?us-ascii?Q?m5nR9ll/MA72LOzn1Y7WyUWh+KzWgshW8YdhA3wiioK7y8swpaV+AIKJygpP?=
 =?us-ascii?Q?qoa2G6QAGwc2O+fvn+uDedtg/tzfkKhp8gHuKUJBNsQZ1NKZUmkMa25bMzwf?=
 =?us-ascii?Q?yyZdKPiWq3Xo0EFXTaEESzDLvOSsjmkV5bRB5x0Z2ExKv5uQQqTHYS+zJxeL?=
 =?us-ascii?Q?g9ctmU/GVo7uDrmD3wg2BW3PVDbEpq6FTsNcPHGIQRdCPCeiSqllmoutNSlJ?=
 =?us-ascii?Q?Z4uTYPmNvOcomtPFXRxNIN/lngSQt1+1j8h+TOE9exIe3gmgKPc7/PuYMvnF?=
 =?us-ascii?Q?frBdrUarlbR1F3ngO1UG2K7qtmC2FkS2XRb/4j82mAdzOqBBhg5qKDOrkft9?=
 =?us-ascii?Q?Ps5Df5lglmqtdPc4yv7XHYITKMRvl1hzO+Xltp/hPfi5RDLAJ5XmuC7/9Ybu?=
 =?us-ascii?Q?/a0c6hIcWtglDUj1lKnvtf8HMR+48uKFu/iQkVYwSIqaUSOYFwDMtUPl3VKr?=
 =?us-ascii?Q?Qk+PHN4kpnJYsNWSGJdGgFm1zw7VaXcDf4QmObkPDy57Nq//4ucnaVGmixw4?=
 =?us-ascii?Q?Z781vTSwWrbLLjqWV16PtppEhjYowsvL8ml2Y3vWrVP4AFe0K7a+0ecWCVO/?=
 =?us-ascii?Q?BrnzqJt56Iuy8tYVnYIxW4lXRVJTCbtkrOo0p+pk5EHMtOorky0SkBfHzpNw?=
 =?us-ascii?Q?zR9IeSgoG/IX+NdIO8YXr6yXtyKM1SbxC1XSP+8Jw8FHCg8BmCo3B+Ck6eO7?=
 =?us-ascii?Q?JkT0idYr+5omCDiILhSavZp9etP3rc0TRzpEON2uI2qboNv74bI9gkbIaOwX?=
 =?us-ascii?Q?09Jj/rY/SpAGwAlhaulCblBztTCCYNwZOoWUFSzjdZ/8LioQGDflW4RvwqtA?=
 =?us-ascii?Q?Ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3720D609C71B654E993191C3A22F7234@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mxuIHnYUULT0rLUbQPPHgzC3yrqBwO5wf3y4X24NAtwliHKh+407hr7knK6pOaCUO4yDhWDxkEXmB6gIpUuCNJ/RLxS9jHIF+CCpYRRj9qMAvIVHW3ZUKoTkVlvPvE1C8GgNAQjYZd67QvbmeIUOMaZ3o1qgv9cBu0+Ib89ndvXMtlpEWUEIeCzCTHbRP9zSGzBVKT7sUvq1gSVVgeTki2PyAmPfKP78wwL+icSNLdqS3LaTu9mXBdy69RSEx8XORMKFgQjV0FUUoE2FINvet/9L0KamT20ihcFF76jU7+sbVTDrsdSNQUQdLc6ffX6XEbYbTDOpK1P/Hb7aYLEcDLoF+shNeaTojIKMLDf0pZGZFZnHPn6pl9DLi0D08BBNKaTd+IK8e7RZSNtdrpplbkdo/tDVngeBJau+3NYmyq9hRcQwyAGr+7UTR5z8gfAdR04IVboe+/EoXqxlyI4yLLHzHDdANul5lk9ezHvpuzAbZXL2G5z/vQ0wAjbhaIvAto+h9tsPh8SzyO8MRNufscNt2GjKjDb/hPPumN56L0BWFnILRsD9/NLObBQQYjz5plDSS+82f+H7gMdYTg/3R6wxzIXxyIgRdO/bpcUKh0w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92577e51-0a9a-48c7-96ab-08dcf37ebb08
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 16:21:20.9029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmaxMTMuymLwHMFxq0WMlVNHZD11qVaUY0PvWEcj2nJpY1Q7rSfag1+3IYh+oRJPKZYwa07PZbUoUJUhUNHrAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_13,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230095
X-Proofpoint-GUID: jpxev5ap9_XC61PSVqYryWlVbs0NJpIp
X-Proofpoint-ORIG-GUID: jpxev5ap9_XC61PSVqYryWlVbs0NJpIp



> On 19 Oct 2024, at 17:15, David Woodhouse <dwmw2@infradead.org> wrote:
>=20
> From: David Woodhouse <dwmw@amazon.co.uk>
>=20
> As with PSCI v1.1 in commit 512865d83fd9 ("KVM: arm64: Bump guest PSCI
> version to 1.1"), expose v1.3 to the guest by default. The SYSTEM_OFF2
> call which is exposed by doing so is compatible for userspace because
> it's just a new flag in the event that KVM raises, in precisely the same
> way that SYSTEM_RESET2 was compatible when v1.1 was enabled by default.
>=20
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> arch/arm64/kvm/hypercalls.c | 2 ++
> arch/arm64/kvm/psci.c       | 6 +++++-
> include/kvm/arm_psci.h      | 4 +++-
> 3 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
> index 5763d979d8ca..9c6267ca2b82 100644
> --- a/arch/arm64/kvm/hypercalls.c
> +++ b/arch/arm64/kvm/hypercalls.c
> @@ -575,6 +575,8 @@ int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const s=
truct kvm_one_reg *reg)
> case KVM_ARM_PSCI_0_2:
> case KVM_ARM_PSCI_1_0:
> case KVM_ARM_PSCI_1_1:
> + case KVM_ARM_PSCI_1_2:
> + case KVM_ARM_PSCI_1_3:
> if (!wants_02)
> return -EINVAL;
> vcpu->kvm->arch.psci_version =3D val;
> diff --git a/arch/arm64/kvm/psci.c b/arch/arm64/kvm/psci.c
> index df834f2e928e..6c24a9252fa3 100644
> --- a/arch/arm64/kvm/psci.c
> +++ b/arch/arm64/kvm/psci.c
> @@ -328,7 +328,7 @@ static int kvm_psci_1_x_call(struct kvm_vcpu *vcpu, u=
32 minor)
>=20
> switch(psci_fn) {
> case PSCI_0_2_FN_PSCI_VERSION:
> - val =3D minor =3D=3D 0 ? KVM_ARM_PSCI_1_0 : KVM_ARM_PSCI_1_1;
> + val =3D PSCI_VERSION(1, minor);
> break;
> case PSCI_1_0_FN_PSCI_FEATURES:
> arg =3D smccc_get_arg1(vcpu);
> @@ -493,6 +493,10 @@ int kvm_psci_call(struct kvm_vcpu *vcpu)
> }
>=20
> switch (version) {
> + case KVM_ARM_PSCI_1_3:
> + return kvm_psci_1_x_call(vcpu, 3);
> + case KVM_ARM_PSCI_1_2:
> + return kvm_psci_1_x_call(vcpu, 2);
> case KVM_ARM_PSCI_1_1:
> return kvm_psci_1_x_call(vcpu, 1);
> case KVM_ARM_PSCI_1_0:
> diff --git a/include/kvm/arm_psci.h b/include/kvm/arm_psci.h
> index e8fb624013d1..cbaec804eb83 100644
> --- a/include/kvm/arm_psci.h
> +++ b/include/kvm/arm_psci.h
> @@ -14,8 +14,10 @@
> #define KVM_ARM_PSCI_0_2 PSCI_VERSION(0, 2)
> #define KVM_ARM_PSCI_1_0 PSCI_VERSION(1, 0)
> #define KVM_ARM_PSCI_1_1 PSCI_VERSION(1, 1)
> +#define KVM_ARM_PSCI_1_2 PSCI_VERSION(1, 2)
> +#define KVM_ARM_PSCI_1_3 PSCI_VERSION(1, 3)
>=20
> -#define KVM_ARM_PSCI_LATEST KVM_ARM_PSCI_1_1
> +#define KVM_ARM_PSCI_LATEST KVM_ARM_PSCI_1_3
>=20

Reviewed-by: Miguel Luis <miguel.luis@oracle.com>

> static inline int kvm_psci_version(struct kvm_vcpu *vcpu)
> {
> --=20
> 2.44.0
>=20


