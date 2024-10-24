Return-Path: <linux-kselftest+bounces-20541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9389AE576
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 15:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13931F22A7E
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 13:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C137B1D514C;
	Thu, 24 Oct 2024 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HI4OnLPE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QaNQhx7d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F28414A0AA;
	Thu, 24 Oct 2024 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729774826; cv=fail; b=WRYlmdJT1pm/5Egqmmt8b/HBO7mwhgmNS1s3mWiieHoZACTOPiaEkSWDOQWipNiSD4fvCQ1bNGvdHYWfKajz9Gpr6ae6AcZqGXEEOLF4ExgcvRezfOSUlU7rvVFHCEtH6Xt96EkexZXiSTxRuB1gXACUA5mdkrTD89+/tdO/wBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729774826; c=relaxed/simple;
	bh=z0yVLaSteCwBkLDotHgzrXsv+E82wbA0oCv+ZNbCNHs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RuPAhBwYkwRm3qlkVa7uXk/Id+JFb5RKlD2gbS+P4/Ks/L02/vfw3pPrAVYEQfqPVkHWBD62utJAP2icdC5W2ukcHR+eII/ojP6VtGwObyteERcuya62oxOScHvWQ79Txpb6UdHmETXYSoTWA6DUl7JaAFlSh/fjCjKX8SnX0q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HI4OnLPE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QaNQhx7d; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OC1Xex030546;
	Thu, 24 Oct 2024 12:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=CJVs/PF7ymm7b1VgTsd3D2DBZ8IAf+lqEYQMdq7enuQ=; b=
	HI4OnLPEPRuNAhQZq7uXX8yFNdPxN7JHi3XfUNVMSrOLVWZyU/iTLbVhnc18nwLQ
	V5AYq5PqZ61FhZgQFiVy9q7pr2dSmm1dTzJxIyRO3NT8N9duSb0AqAym6KOuKhG/
	oplkh8e5riQsjW2Wp/TJtH+ZB0/PS/axnX424lkzy5uXjKMWs8G124QbTeoRoOst
	I0eY11Ll8DPLJARzfUqP9pQ+lwYtcBicBTucIRa5fx8J3ts89nKKbk20C9b8G+oW
	LjLdbfTB7HLh2w4L9qhUsAP/z8ak1C+4UqnpDkuZccvOrlPBCAhZP93HZHrU36eq
	/+bdL5r1h9gnL/RFN2uYgw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53utfys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 12:54:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49OC0CcC039476;
	Thu, 24 Oct 2024 12:54:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhcepn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 12:54:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nj4IUUxFG6ltnEf95QYGtKJQ3+/+H9bbXyDKvekLgnVDocUcEzdBPuLMC6YJH/LJ8REFI7ZtRD6DlF5XOsbDVE9eLYopeCRroqttGd2bpHAClgCEjVINZ2t+MV2ctAsF/I2bS5HCe0CNjJ3MprFOjNwmttG+5zyz1Fsqx1w7llZViS+1RmkQyomFe6STrSV5+JwYjmLNGht+uDudIvQjcEP6GErrEp21YC4owrRfjc+Q2/E3HVJ1krPsDx3mUlMFqcNyfMMy+/bluK0eGGbbs1UNnYT1CFTDuIETOmcPKdbU32lBCuLGeLtom+p92FqjUzHIExVvwnXH/1bj3xXj6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJVs/PF7ymm7b1VgTsd3D2DBZ8IAf+lqEYQMdq7enuQ=;
 b=XzJzUb+a844Hj6HPHwYhQamunmcHsPGP/zIW9ZU34WKZUc9YubKJOwIq0WYQCAhh7xzODPEFxTxBHS/ZIABjeitk42xM1YpSwvkkn1DO5hKJu4WGrqrsZ+bIVjhGuL8sEWV4U1uLZSnFTvUQ0IsxRo+lSFd9xRnj4cQLqiOD3dQDFMngZjnLh2n/NbwToPIP+LBmNYBpLEp1bosN3i79E4FCoaJLeVTvrOMr7Hy4G9EfiXwQaFDjjD2/jvjEEJsBZrXpNUtoxeOuZUtcDm8J7SnAkvg4tF5OcgYV72hHEjEoSu/0U1R3N6TvBkhQWXzMM/DR4MXUjJe2wdaRSRKdiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJVs/PF7ymm7b1VgTsd3D2DBZ8IAf+lqEYQMdq7enuQ=;
 b=QaNQhx7ddaEQ6xv3jXNJoDlp4pATV9aW0zoqSVz9HyU+J7SbTN2XyfpklsP/IxbBB4oHZGFbaYTyRp7lp3kUICzDfp3TrhgcHk9I5wv/rzxYz1/uOdPRsscs501ZL7fnnNMxBov9/BmWTGe+mjlsbDpRCUEzGItR0tdjpdU2h/0=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by DM4PR10MB6766.namprd10.prod.outlook.com (2603:10b6:8:10e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Thu, 24 Oct
 2024 12:54:41 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%7]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 12:54:41 +0000
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
Subject: Re: [PATCH v6 6/6] arm64: Use SYSTEM_OFF2 PSCI call to power off for
 hibernate
Thread-Topic: [PATCH v6 6/6] arm64: Use SYSTEM_OFF2 PSCI call to power off for
 hibernate
Thread-Index: AQHbIkvjVrKcg6oAoUyk8/Kb7bGb5bKV4yMA
Date: Thu, 24 Oct 2024 12:54:41 +0000
Message-ID: <23C91005-7304-4312-A5E0-F5E6C05B3209@oracle.com>
References: <20241019172459.2241939-1-dwmw2@infradead.org>
 <20241019172459.2241939-7-dwmw2@infradead.org>
In-Reply-To: <20241019172459.2241939-7-dwmw2@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|DM4PR10MB6766:EE_
x-ms-office365-filtering-correlation-id: 26cc0031-5e79-4d81-7ea2-08dcf42b06b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VWDu17rkBtVaaHJhDJ818yCy5HuiaYHC9B/b3HZj5n5MPb/IAuoEKSWMt7c+?=
 =?us-ascii?Q?waPdMjXEZZObS8OvpobR3O6elGywzP6mZkXwsCyCdhhTNAdfqJiWweZkgC6A?=
 =?us-ascii?Q?hRwxHqCIYc3KAdgmhcfByPuER81EXTJl/9pNr1s/XlYDJ0ntqL01q2n1litW?=
 =?us-ascii?Q?Ghecs4qo+9CFTvVJhBEYp9izeDA3zpPTVw/krLbn1tQUKsbSg9vk9zA+gIY7?=
 =?us-ascii?Q?fIyc1ga0/oecC7pMkAmYlbGi1+1n48imcah9b37sIZHwF1yKjcRDG+AoqKFo?=
 =?us-ascii?Q?inuh1oQ0TBhbWl8BC3ENOX45u5JBKIMxhdT1z6+v4shR5CDDTw9Xw2zF5WdE?=
 =?us-ascii?Q?Uby7/IKXZ/IZFKZ/DuLSETRUeQSNeNfowhKSl+Br/2mAGEVKW0PsYoAcrg/L?=
 =?us-ascii?Q?XCzKepNeofeLrYhoV9EDBAMwd+IrVLtRmOI0Baxvdq2WxRSZikRGZGxy2K/k?=
 =?us-ascii?Q?oe3nhJz9h1VcWatg2NKXemz78TRShkEpT8s091r4vpLRtqEqdpccwIj/j/So?=
 =?us-ascii?Q?3t3G4M0KrMiwymoE8lwq/lXzLHv6AB5pUeh/oHtsjdo2e+QVtMH7vdBK3XM7?=
 =?us-ascii?Q?2juIO+too4QBsOS4Vsyhy4Dc1k5wkua7gHHPtHyvBs4QoM3YG3pccb3g/h8B?=
 =?us-ascii?Q?CoMuleMuSLFwkXcwtXZgStI9D3SPs8vz0LVQsZg1J7k6ttMi3Hi7CGyTpTDx?=
 =?us-ascii?Q?teGSrajdIRMiHtxWd1Srl6V8WLRl+cvanYjEeChBvaGr7ntYwhZdNeZnhk23?=
 =?us-ascii?Q?f2c2eoFzU+Th2XQBZ97Q4RJoC0AEUZipvuQSQWmSTUb2Snd8Yn4M7NBHGSSc?=
 =?us-ascii?Q?6vjOTYU6vA8PfsSAsVCBuU5l/sBmuJGgN48Ch+fsHO7HgAMPlGs3yZ/OGqYN?=
 =?us-ascii?Q?XKEFYAN5wIxJySaBVF0V4+WrfK3fKSuF3SGkw4/hx2TppWTeHZ3rG1BQ0Yh5?=
 =?us-ascii?Q?pNfjP4xISjasrX8kT8ZKJGEJzqomc2udhclg+PqECyk4ST58Ld+KtBsZlrtk?=
 =?us-ascii?Q?MI6jsofyi1OmJWPsQ1gEcH8AfHX0Cq8DDMSU1MhP///336Tca+a+K1udhX0r?=
 =?us-ascii?Q?TN+fFH+Y72KOmzLN3mITBCeJhqdbj3sJte3MGJ3If3bx5l24Zh5JLPL/YXd5?=
 =?us-ascii?Q?6oIMq1pVajw3lwf/1k2xo6944oEjyMwHiEBJhm31lfd0CYlxr877JiWrnyFE?=
 =?us-ascii?Q?3taId0mefVP4OkNQoHDEaQyPqVZ6PY9PusyoyvEyI4cakvJcZwE5epZvC4+J?=
 =?us-ascii?Q?hpIFzzmtBTpB7zQZx8NSUm7HeP/fMkC0IMo/azb0wSeL55sf5Hi4xxr9q+vj?=
 =?us-ascii?Q?+8baEHZxgAnlM07pcbD8W2CpPDf3+6E9XBGtlvhOzHggAsBtvA9vyMIMAlNv?=
 =?us-ascii?Q?V4pGqYk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wHP6lELksIRmFDlkP9GYgxGBKBMhKlEAaB4KXun8NlP+hzwRBb/MiRQoMrG8?=
 =?us-ascii?Q?wvDcE09FtBtD0Ech7iWGh07/JB9YixzyDMeZ1r22C/Coy5MOOy1aCVQfUcAx?=
 =?us-ascii?Q?TM1IGxgmpUARAkMPnKSEP5Pvlh8KZT33hodo6Si2B8YMmEJ5yIrethHQC1MG?=
 =?us-ascii?Q?WazQt6R4CgfQNlhf9stMUPYb/GFTysM/YhS2l6HU+EYaawXPMZ197JM6pq3y?=
 =?us-ascii?Q?Z8CBi3DjSGc5vYp9tQgU5h3ohULwu4LM56m7CiLqTRIrrqeAwQjqyNWRYNoF?=
 =?us-ascii?Q?K7U2lpAvliVVtFvKj9ohYyK1rVWSLozjdvoGIAhYVunMRIyVDrr+MycZ6e2e?=
 =?us-ascii?Q?EcdzhKZ3cGUtU/1tN/yu9B/MNGjlAbnGjcvz4nMDa68k6VNC1UvQTDYX+FpJ?=
 =?us-ascii?Q?NoPYQpLI00de6HecMarZPzEaAEKlu0o/FMXLie7OxIN95W+qr9lIpkYCyB9H?=
 =?us-ascii?Q?cP+q4HXf02R5ciwQGGZN8LvuiVgo1cKXtf1lK48PiG0VRjC2LI00WuxM23RC?=
 =?us-ascii?Q?OPINd0skbqiGoVAB0TB2FNA33bz6Ok7MRx5yKIzLekka1xua9TeZ0bV/Pezl?=
 =?us-ascii?Q?H3r+m5nV24gwxxA5Kp0m4nLUlcR5+IKl59Fqjk44plbLbQRBKeJzvibcUpWH?=
 =?us-ascii?Q?dCq18IMcbidUnYg6NLkY864bqSjE01hlyJpRxJHngtpssKO5WhCpkICZApte?=
 =?us-ascii?Q?7wUu0V3hteCC4AsDiIr0yXrsFlEX4P/50htDyXWQB/KTmhooAzmdE9dt9EAx?=
 =?us-ascii?Q?BfZBIeze6giOTihNyXW5RVFVS0MWxOP8qhh30yikh9kO2Lgr0IpyLpQiqav3?=
 =?us-ascii?Q?otFNgc2H+jS/uPX97FqR6gc+oIkGbIx+ubMcLxFSP94vFsnBD/Q3/lWIZKRu?=
 =?us-ascii?Q?cSsoGV6FJ8IXABPfrKjfwgVoE282485Fsq0o7jJQr0vI9ucKnzdP34iuxLvs?=
 =?us-ascii?Q?T+47cuypqk6V7uICb/KnNlYmB+q7bMbUhIYzQv/4m8/JXeY/U89o/Q5q75TX?=
 =?us-ascii?Q?FteZUyBKvU/Td9fa9xU0MAhG8iuzjAiFymaSO5Om7V7cz3wYkD1XDD0rrbuo?=
 =?us-ascii?Q?1aNP9zOkODbrkU0uZndJiMKycmpnRVzGmKhWOwnYXugELVqrTh2FK3K+l9Z6?=
 =?us-ascii?Q?a48HWLXId982/Hi1bC7WcsK4vqBX6bsc4Zk65wExB2TNOdmA+Q5OkEKbRkD1?=
 =?us-ascii?Q?oPSGFM1zwkF5BXTYgdAqwIN31ST5IR/n0+ADTmr4X9OTRcd7Vxk7bpzC9oBO?=
 =?us-ascii?Q?65PBI/K2klaxbAjdYg2G4Q5WXA2If0wad9Ov880JTk22/Ok+Ueh61a+lV5TH?=
 =?us-ascii?Q?oKdaRUSgvJ8MEMzGaIYKLJ+D2mFTa35L+mQlUJZwFYsXnDfZYBQwm0Sr+izD?=
 =?us-ascii?Q?tzpBH9v7thqEGEf9NcEvnuyx72nE0NseIHVKN0XsOgmv3O9OMjE1I43TnWgh?=
 =?us-ascii?Q?VlWHTcUr9qsUmiR1ceZHsqdn4m3byvyxUiM1ZeOOxgbRBNhv03ZTyLbinszp?=
 =?us-ascii?Q?8lKyxB3HjnDCaVpxHA1tnh9F21eF1GJ31ccWxEXhffibyw31curMzI81Dmek?=
 =?us-ascii?Q?wzwhkLRNJsQ+LiTUZ9PtOk6fbW2Dt9bTNwGVpEPwf6Cy1vKdA6nw57OskdEE?=
 =?us-ascii?Q?zQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <77EF771EEF6BCA4E8BD292D93F639EFF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	91edctYTJW7bSL0A4kY0lt+k1Ao7mwC3V2wsCKLM3tS/wGIWBrFV3OYaMvHF8qSEAzRMQgNaZHDfmoar2Q3U2HlRnwob9I9nY9jsUehsBr5XWyciUQiGGm4jTSHdbXiLDzrN3QWfFxro39C2S0AtR/NliQYnU7c7IoicWM2bTVbpsH88Eosi0EqZNuOhEQMjx1205zD1c5Q6GQZKWlLNVm5Xt3CTVVclXW3XatrMGUWUNVbOMsvp5wRi+35yDPVe0cq79yAWjU1B3Bc5AnhNY0GR5nQeKwZ4InNHiQwM1YE+S5Uos3gNQb4cYgo9UUlwutWXBZNnFlNE3TVnAHgcvndPrX+iwI5qyN/O2j6nP1EjiKtOPr3K5/iQWHghEtcZj6tnAV3jV967FKPFIfd3KsP4xQn6cnUo+iBGn+JyM7sp94GwWsRe6vCODiYZ0ybK8Uyi7mxc4REFPBP3y4AFzYqoG0UR/VVEDE+49xv9t/tqDZGvKLr6GpKP1MMBZsr023z2NuhDql/b6Z9mBP3oxkiO3647eCzxHpEr8bB7yoHuIrXXrsMN9SoyMFlw838iXwzpvVw12g/s6+t/nxh0PTDWX4Y7pFBdogH1K4kl4j8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cc0031-5e79-4d81-7ea2-08dcf42b06b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 12:54:41.2723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NkuF4enbT4pTKKpY9xOR9DPvk5kN5ys+Kpgs1/cgFGJt1dnXGFjjm9hsCJgXiBwmgKXCFVyEULr7Oky9ScUEaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6766
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_13,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410240106
X-Proofpoint-GUID: bHmfGP6H8iAcGw8wgI_3c2znYq-k818m
X-Proofpoint-ORIG-GUID: bHmfGP6H8iAcGw8wgI_3c2znYq-k818m

Hi David,

> On 19 Oct 2024, at 17:15, David Woodhouse <dwmw2@infradead.org> wrote:
>=20
> From: David Woodhouse <dwmw@amazon.co.uk>
>=20
> The PSCI v1.3 specification adds support for a SYSTEM_OFF2 function
> which is analogous to ACPI S4 state. This will allow hosting
> environments to determine that a guest is hibernated rather than just
> powered off, and handle that state appropriately on subsequent launches.
>=20
> Since commit 60c0d45a7f7a ("efi/arm64: use UEFI for system reset and
> poweroff") the EFI shutdown method is deliberately preferred over PSCI
> or other methods. So register a SYS_OFF_MODE_POWER_OFF handler which
> *only* handles the hibernation, leaving the original PSCI SYSTEM_OFF as
> a last resort via the legacy pm_power_off function pointer.
>=20
> The hibernation code already exports a system_entering_hibernation()
> function which is be used by the higher-priority handler to check for
> hibernation. That existing function just returns the value of a static
> boolean variable from hibernate.c, which was previously only set in the
> hibernation_platform_enter() code path. Set the same flag in the simpler
> code path around the call to kernel_power_off() too.
>=20
> An alternative way to hook SYSTEM_OFF2 into the hibernation code would
> be to register a platform_hibernation_ops structure with an ->enter()
> method which makes the new SYSTEM_OFF2 call. But that would have the
> unwanted side-effect of making hibernation take a completely different
> code path in hibernation_platform_enter(), invoking a lot of special dpm
> callbacks.
>=20
> Another option might be to add a new SYS_OFF_MODE_HIBERNATE mode, with
> fallback to SYS_OFF_MODE_POWER_OFF. Or to use the sys_off_data to
> indicate whether the power off is for hibernation.
>=20
> But this version works and is relatively simple.
>=20
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> ---
> drivers/firmware/psci/psci.c | 42 ++++++++++++++++++++++++++++++++++++
> kernel/power/hibernate.c     |  5 ++++-
> 2 files changed, 46 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 2328ca58bba6..8809455a61a6 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -78,6 +78,7 @@ struct psci_0_1_function_ids get_psci_0_1_function_ids(=
void)
>=20
> static u32 psci_cpu_suspend_feature;
> static bool psci_system_reset2_supported;
> +static bool psci_system_off2_hibernate_supported;
>=20
> static inline bool psci_has_ext_power_state(void)
> {
> @@ -333,6 +334,33 @@ static void psci_sys_poweroff(void)
> invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
> }
>=20
> +#ifdef CONFIG_HIBERNATION
> +static int psci_sys_hibernate(struct sys_off_data *data)
> +{
> + /*
> + * Zero is an acceptable alternative to PSCI_1_3_OFF_TYPE_HIBERNATE_OFF
> + * and is supported by hypervisors implementing an earlier version
> + * of the pSCI v1.3 spec.

s/pSCI/PSCI

> + */
> + if (system_entering_hibernation())
> + invoke_psci_fn(PSCI_FN_NATIVE(1_3, SYSTEM_OFF2),
> +       0 /*PSCI_1_3_OFF_TYPE_HIBERNATE_OFF*/, 0, 0);

Perhaps spec. F.b. could be accommodated by first invoking SYSTEM_OFF2 with
PSCI_1_3_OFF_TYPE_HIBERNATE_OFF and checking its return value in case of a
fallback to an invocation with 0x0 ?

Thanks.
Miguel

> + return NOTIFY_DONE;
> +}
> +
> +static int __init psci_hibernate_init(void)
> +{
> + if (psci_system_off2_hibernate_supported) {
> + /* Higher priority than EFI shutdown, but only for hibernate */
> + register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
> + SYS_OFF_PRIO_FIRMWARE + 2,
> + psci_sys_hibernate, NULL);
> + }
> + return 0;
> +}
> +subsys_initcall(psci_hibernate_init);
> +#endif
> +
> static int psci_features(u32 psci_func_id)
> {
> return invoke_psci_fn(PSCI_1_0_FN_PSCI_FEATURES,
> @@ -364,6 +392,7 @@ static const struct {
> PSCI_ID_NATIVE(1_1, SYSTEM_RESET2),
> PSCI_ID(1_1, MEM_PROTECT),
> PSCI_ID_NATIVE(1_1, MEM_PROTECT_CHECK_RANGE),
> + PSCI_ID_NATIVE(1_3, SYSTEM_OFF2),
> };
>=20
> static int psci_debugfs_read(struct seq_file *s, void *data)
> @@ -525,6 +554,18 @@ static void __init psci_init_system_reset2(void)
> psci_system_reset2_supported =3D true;
> }
>=20
> +static void __init psci_init_system_off2(void)
> +{
> + int ret;
> +
> + ret =3D psci_features(PSCI_FN_NATIVE(1_3, SYSTEM_OFF2));
> + if (ret < 0)
> + return;
> +
> + if (ret & PSCI_1_3_OFF_TYPE_HIBERNATE_OFF)
> + psci_system_off2_hibernate_supported =3D true;
> +}
> +
> static void __init psci_init_system_suspend(void)
> {
> int ret;
> @@ -655,6 +696,7 @@ static int __init psci_probe(void)
> psci_init_cpu_suspend();
> psci_init_system_suspend();
> psci_init_system_reset2();
> + psci_init_system_off2();
> kvm_init_hyp_services();
> }
>=20
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index e35829d36039..1f87aa01ba44 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -685,8 +685,11 @@ static void power_down(void)
> }
> fallthrough;
> case HIBERNATION_SHUTDOWN:
> - if (kernel_can_power_off())
> + if (kernel_can_power_off()) {
> + entering_platform_hibernation =3D true;
> kernel_power_off();
> + entering_platform_hibernation =3D false;
> + }
> break;
> }
> kernel_halt();
> --=20
> 2.44.0
>=20


