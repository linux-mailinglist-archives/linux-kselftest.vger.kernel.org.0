Return-Path: <linux-kselftest+bounces-20468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AFF9ACED3
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 17:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2F01C21CF2
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 15:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD381BF80C;
	Wed, 23 Oct 2024 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cJ/Cs1zL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C31nQccH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988691ACDE8;
	Wed, 23 Oct 2024 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697515; cv=fail; b=adfQ4JhdV+hpOOLPKfBg4N8mZpUtZzXwUTcQwcw2OlZpiloGjEGwne9UemtnyXGydZ4emTGvuM7mzBWz3BoW/uq7Q2Cu1hgTmCwoGrsZbqVBgiiyYHR5FXaUjuw9ShgeP/GomnEm+n6wG3ZVfMPOYinX7BKFjRbaqu698As+U40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697515; c=relaxed/simple;
	bh=NcCM1DX7n4sZzxKrr0oSFX/3zz7hEPFd8aLeAaP9PcU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gsWDWEggtD7fKbv77xBcNbfOL/xAlyYq5lk8FwOu+OWlZNYlJtafS4Q/ickl1NgrjhLtBGeoDZpGgiZ7qxaTPxXV0p/Ods6VxFQJYDZXbyT2N3MBWN9pLOe8pdxCcH7sfQplGWoYnloFBMqOSNE6D80mP+A9awrlOwrndxth6N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cJ/Cs1zL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C31nQccH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NF0Z5P030053;
	Wed, 23 Oct 2024 15:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=NcCM1DX7n4sZzxKrr0oSFX/3zz7hEPFd8aLeAaP9PcU=; b=
	cJ/Cs1zL5ys3aia8Y8eGvjfWW+VBsmvjcNbxb3MAsW2eduFiaDfn++dw42u+IIwg
	Lz6EeTRDvp+e9ZLRY6J7QTc5fa5ctE6DkCZrMjG+7U5ocV6SKW9pKzVkd3tr+BlB
	mBcqqyqwmN8nQKS+vM4rowFFkT/APD7+Cw9bfkYQxJaU/FF8TuaX6Ms47rSujkGP
	9AU/lEMi7Xh4zFW1zC69LIhaudSBJ08z3+91JIh8KvZtBAf+Y+GfyhktXnN2ptE3
	pd9k3I0ZFRiG7OWAvJe8H/07uutJDs6QcXxrW/NsUQ5PKy3qAtkAjgAApN8rLhzo
	sw24160SlkAP3vM+RdEmvQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5458jdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 15:31:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NE343D018490;
	Wed, 23 Oct 2024 15:31:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhjpyme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 15:31:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ghd7BhgUwnWyNMJEigS/o/BOhOPOyqBb7ZxUcGG7/h/yaz9W/VPWGVAx4Em0LdKb/BOMk0b/4yk+kzCfakjI1mHvtJ360tiB7DLquR+fwV3ecuweXH04UwBWiCJRvMbmTYvHacQ9RzL3aNSm1J5/4vUfYC9ABXLYnKFnFkBi4qa9wQb0DZOQ/76N2igm6MeSeNZ5+xIiXaCmKbY7d7Kny/fKs13xXMUidyVqC1zFOsIE+ywdWNNvub6dUo1gq4MoCtTJI9NA7MaF3VWS3aHq3In1ys1jz3AMPqp2qPYvULq0ufaOZnOm3Nan7KMP4ThengrsvCwTPWhmOJYgBEWchg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcCM1DX7n4sZzxKrr0oSFX/3zz7hEPFd8aLeAaP9PcU=;
 b=C/qy8MTaey5xpi/tahyjXot9sEE8GZymM/gIr7eAiVR84ftBuy0aiYzezSMXHTEhi4S0e5ZAY+KBRFCU2XuLhoZRrWF/gQJyr87IwennwIIJlZbsNhEAkxxrzOTJynX7BfH+aPEoGjYMo8kuAK7DLIKM0GmGPBT52UwHL2zr0rk4bpqwgHoqC1E6mxB9MEv7BzKpF/pHH/404AsKkSBt8VRuhlUm26/ynd1ka6jOUHO+4IAe9f24kfalwJVuPi2naU6sk7YdTlvH5dixuuSIWSVp5tYsSugiZDNxEn1Vt20C3wG5BRq+/5+Jw0KlShiDB4zIy6IJdHkVMUhRqpnQvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcCM1DX7n4sZzxKrr0oSFX/3zz7hEPFd8aLeAaP9PcU=;
 b=C31nQccH903Dtlcdw4fbYr0E1QlGqVN8qQYc/8aQ3etY1e+M9MXemc10hWmi9ycDMFlpJMfNbfDwq7bxfLgt3IOdQBu/99aKwOiIzwTDn/nt2gYJLg8KHjFIhvJ4s9FoCKJ5JayXqg3wNkjEDzdUW0KkGTK+wRBSZCj62P/PHKM=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SJ1PR10MB5930.namprd10.prod.outlook.com (2603:10b6:a03:48b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 15:31:11 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 15:31:11 +0000
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
Subject: Re: [PATCH v6 1/6] firmware/psci: Add definitions for PSCI v1.3
 specification
Thread-Topic: [PATCH v6 1/6] firmware/psci: Add definitions for PSCI v1.3
 specification
Thread-Index: AQHbIkvpm7ACGAhwtkSv9B15LbbA67KUfIUA
Date: Wed, 23 Oct 2024 15:31:10 +0000
Message-ID: <AA34E63F-98CD-4A63-B92F-47ACB12417B1@oracle.com>
References: <20241019172459.2241939-1-dwmw2@infradead.org>
 <20241019172459.2241939-2-dwmw2@infradead.org>
In-Reply-To: <20241019172459.2241939-2-dwmw2@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|SJ1PR10MB5930:EE_
x-ms-office365-filtering-correlation-id: 0d1a0a41-546b-40b3-c504-08dcf377b8fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ICME31eD/KxFzXV+bYixCM9XuK7vbEnioHPwX5sZsYDjOLJlU885acFTP1La?=
 =?us-ascii?Q?dBL3DCrLFZ0v9gtSvsPrMbnNWVJCC9Bzxcgaj0iZ2JQH7gPLC+0B/9ipW7+g?=
 =?us-ascii?Q?LppIiwAElu4Duhi+MeD0euTr9kM64gvsnJv4RkUOxUfsXh8CwHGMSDcF+Cer?=
 =?us-ascii?Q?KSroBMW79QQncqs0g+ldG0r6bUe1YZ6AB8j+YBXak3iDcuZKJC+Es+Jeon0a?=
 =?us-ascii?Q?LpoH+/0O/ssAJAjnfl3Z+L3MYRNeQKPxaJYKh06xUTBciX8gNdtPC1Wer4EA?=
 =?us-ascii?Q?e6ocCp8itjwG6NAO7xWpUM7P6o3ZBB3ZOsnW9N9OsJPVLSzvJDWUiDP5pXKK?=
 =?us-ascii?Q?CFkRh0V0fUp3Gp7ojMe3LSReydGanuecR05O11gzvuQhbYRM7ixjJWP6YBL4?=
 =?us-ascii?Q?oNQgYKvd/aHzfs8YQ28HUvCDD/bYzz21BpUAkjckLwvdQgu5tIerb/m9GvkV?=
 =?us-ascii?Q?xgZtUyVvx2EHf5mLxLkobQPNKDtL8SHrQXdBqE/mcvtq6IYTm/cAYG2DxowV?=
 =?us-ascii?Q?X/VWsq7u1OeK7iiL5fXm8odwVtWyqkL0XbA4TeLKechapUUTaklARWNPX/Pz?=
 =?us-ascii?Q?PKkzPLnycKsvXgNgb9z1MK7QuOkA7Fy/AGFH0LxbMvBBBlwDYysBR0Kpw2qw?=
 =?us-ascii?Q?KjcNUTaX0nAKIH8QOx7/FLyBxVOmZxStH3iZolXrCJNnyiPHtvh0w9qMlzDN?=
 =?us-ascii?Q?rw3xtdUKLmlhclYKik6P6Ww7CgoyHH0c7yXs28K3oiypiZs+HP48h+JT4L56?=
 =?us-ascii?Q?pLewyNCSTBir5DDyfiN+OfIQj6+8Vwo9p4ZukiA/UzByMjU2sC/1kKV+QC2G?=
 =?us-ascii?Q?5bdUX/nygPo9nswaVZMGaAc9zm/Npk1klm4lVGLeWF+uJII2I+4G/YV4BTLZ?=
 =?us-ascii?Q?50IOK2X+R5dbVoE490Xrx28ZfBkJOTvwNP80qC3i2T5JXLuujDx1OTjf0dfw?=
 =?us-ascii?Q?5IMyD4K8EIHpVB+QEROdSv3FVkAlA1EQAuBtDy0Q8Yc3kVdI/qpSpvD1TBqA?=
 =?us-ascii?Q?TX0Mr+icW1MOv1LHWMRXvuSchupeVD7MAQ88/zqIIDNfCkkl/7vOxqoBs8na?=
 =?us-ascii?Q?nVRnJkz7uXAnh4FubxETLY0K+FJgEoyKVxX1wOJ+jm8bw+7XOikB3vJY9e70?=
 =?us-ascii?Q?CMg13jvTLzyLoKlcXNMSq1fYoYGmb4rF5ZjShyKDPJ3S5Hr+59IQSl8Nqn5T?=
 =?us-ascii?Q?uBTOzrMmlAXp+pwyvyVEg+YL4c5OiLyrFMU6HE9CKTYxNmIcSg6qMvdqjP1u?=
 =?us-ascii?Q?Hq2L1DuzI6broGK5wtqotX9YY+mCQBwtIyllht+OkFyupXFjKo1xuCNh85Ak?=
 =?us-ascii?Q?osrZ6rtnCtcJWQ8699BlyCeElazReuxHcB/IADYCRuPWU2nR4wOqIpt6kD5g?=
 =?us-ascii?Q?G+RaVopU/0dfX7A1fWpWOwSfKtNt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SPyoQ6XhVFEiCPlLVxWPY5KyHnESsNhdUbrWO51uSiISooCAiS4dhBSqFYXB?=
 =?us-ascii?Q?p5yOfu92eFXmALF3jNcLoQmCEKCcB43U2ogaFvlqzys5SYLwe5nzHo3C1yIE?=
 =?us-ascii?Q?2GD+tGuvhfNLEzY8F6mBw3w7e1oaA0qR36WK5AeUV++3LRkwf4uOUaz+M8cu?=
 =?us-ascii?Q?LSvBlo8bG88eeRcgNCvGSrZHR8nBwXSYkT5B431OavhUOxE9+Or+V5lMPYkT?=
 =?us-ascii?Q?8DrwR47Kk6AJfaXr1GjryqMaA7DKvi1PG65DQFU+8XVDitHLNFoDJyy2pYlW?=
 =?us-ascii?Q?Suoj34E9sWRga2eFv5mdyA2fFF6UH7xATv9C7FoCicONQOPvAtJlK+bR6ac/?=
 =?us-ascii?Q?OTzUS7gZe7K5mQ51kK+Upc4yG0DdaBtt3GyZSckVwBDeFY9fZxBT58lUo03C?=
 =?us-ascii?Q?toetW6o/cpwik/9ai7qCBcYEd5VEkP8BqJFYwBHHZR43PbIlYVOl+aIQidT8?=
 =?us-ascii?Q?1Pi1BIMHQLSkpO90sxqRRUaPAh11uv6HBkuxCwM7gbk+QRORULHK8Z1XOcG2?=
 =?us-ascii?Q?cvGZuziyfl8OOOqFkw+VA4f2h+rFJQz1uGLCj/qyGVpx5NHK/WOEy55uDF/q?=
 =?us-ascii?Q?+b0Z4vzA3OMn0rWzMhsnadF7WBZPCqfwkT+SNHWjwQduKhQENgzcuYeVuICB?=
 =?us-ascii?Q?bAYgRZRkz9qy5AmJjEMuj/ExbI2VAvOaxwhAZi/bJAUi1JA+Q3ouKaHF/E1u?=
 =?us-ascii?Q?p+nercISnaw4BDTpWRHYH+M1qqpNINsyhQCiXFuUBNGZaHNFNx5p9zaPEz0X?=
 =?us-ascii?Q?+KehHqiQhx+UFeH3RnTnbMBGqZf5dlw+bUEmIVO8dBX3iayCD58AzrWg02Bu?=
 =?us-ascii?Q?NoVylDXIViW+PtoZYUCCf4fdpaTvNXviCanp4yiOz6kIddb/h8NBdE/zvWOr?=
 =?us-ascii?Q?C5eVAq5yqPdCLQG/ri7JlLZqVGFWsLJAXiGVXCHS+OTnVOqMBpizIid8Lwt5?=
 =?us-ascii?Q?p0v2kbBLolN7jB9VsOLPBRyl+9oO3oACEZFPrYGE2u3OCoFuVLgNFXbmYWA7?=
 =?us-ascii?Q?b4Dg/LKGpZm4OPQfvXzxnkjpAcpceILl3oT+wQAFv3HCcSzu9OlI09tbR3OE?=
 =?us-ascii?Q?pUjTOgmXec8ceGtq1GxZdZTm5LJJlW8Qa5akxgJLprFd+VtxcPso2WzW/Rq0?=
 =?us-ascii?Q?Kj03v0YsylM3oZ5RHZ1vnrBE+HDveWgPMTq7DCFYVfvnKh7Ul9xbFzoNIV9j?=
 =?us-ascii?Q?ajrSGaCJ48qnACIqrUxO/C76BGvggI7bFivujXWC2XflGP98YmZB7o1sS2qE?=
 =?us-ascii?Q?XX3yIvxApiZNhcZpU0TCrzliIgxdmdBKn39oe6N0kOhlFgjl7uvtvhG1lcGy?=
 =?us-ascii?Q?upnspJobsD7dh/52A32cpU9yuJ1ZWZoqGf8Pv/8qVh/3V4Is4XL+/tW/idjU?=
 =?us-ascii?Q?c0JcTxSHKi9QbJZo0uiSnDbuWYJ+VkTeEzQFrEozysu6kogaUDO8YriZzCtc?=
 =?us-ascii?Q?Jsa+8pdWqAZbeaiMWOxghrMV4t8LlCpFKHAdTeKm1vcWdjGNMerIb9Q4KwMH?=
 =?us-ascii?Q?NHyfM4SEKUUKcbkwZ4y8rl2tdOSQxH2J7ZBc63Q6pYAIY9+Fxst6M9kSpMv1?=
 =?us-ascii?Q?9/LJl3nCiwNKx31D9gsNJWhz6jEX0a/WnGGUNI1nshYf3AmGaSmJrpSfbh/m?=
 =?us-ascii?Q?yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FE6C4DFD400236498B4D66977B7EBBA1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xp6aHM7HXGxsSQmBZ09ifb3XwZPhutHyp4DP+QBs8D6DKmGSIJTAiViIxBlf/hZE0LKzD+ZughDjR0H/+ETUJRrjUIuC4RGXBZBG2iQfkLBiUktYnFhQabXmcN/nt+TTEq26NySKQtiuTWqwzAJWbHawjbRbq0WaYumYgeya4FK/XMkOKvUUkiT3iKQDHfBq3prehy7LIYzgjZaPYvvCtvi3A4NROonm+Auvo2zN3I5S4p4uJchGTXdywNCIVYNrSr8hp8PCwFGxqzA0uhDxs42BzHTFB6+WgZUqsUQOdMaWG7LqIrHFmRAqXKnxbDhVwmTojMjiHqsLMVSuBncg7ZoH9VDL6ajoAHrIATpFTf38PV+gavKPyonRhzCdugkyrXqle2+kdT195CJulVrXP+xiiDArZMv1aE7zkIFVTcFwJoKI9Tm9rjrzFB9r04a8z4aU0XEgxSc3BKHZ9Lu22Y0G200twv4G9lEW21uZ+4edJkbPJ6ga6pmjOJzrJHL3rbKxiewWQzpEdSsoZdDOpk+i/Qi7Pg3PdggIpfTkRlgQrir37LheDTK7kaf3BmJXpDV1dz5BuR5NucMbewg06uES5TYgl/faqCoI+bPFK2M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1a0a41-546b-40b3-c504-08dcf377b8fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 15:31:10.9478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B055cYuzV5MkZkwbWtObodYWUu6Wy8d9JmaMr/1zUJTBsabV+MgwQSK4ZQuHsABlQ6X9/1Z3cEWaka2NQWbiDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5930
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_13,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230095
X-Proofpoint-ORIG-GUID: gjNS4nZ_wpmKizhm05BbcIkkPz2GFvza
X-Proofpoint-GUID: gjNS4nZ_wpmKizhm05BbcIkkPz2GFvza



> On 19 Oct 2024, at 17:15, David Woodhouse <dwmw2@infradead.org> wrote:
>=20
> From: David Woodhouse <dwmw@amazon.co.uk>
>=20
> The v1.3 PSCI spec (https://developer.arm.com/documentation/den0022) adds
> the SYSTEM_OFF2 function. Add definitions for it and its hibernation type
> parameter.
>=20
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> include/uapi/linux/psci.h | 5 +++++
> 1 file changed, 5 insertions(+)
>=20
> diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
> index 42a40ad3fb62..81759ff385e6 100644
> --- a/include/uapi/linux/psci.h
> +++ b/include/uapi/linux/psci.h
> @@ -59,6 +59,7 @@
> #define PSCI_1_1_FN_SYSTEM_RESET2 PSCI_0_2_FN(18)
> #define PSCI_1_1_FN_MEM_PROTECT PSCI_0_2_FN(19)
> #define PSCI_1_1_FN_MEM_PROTECT_CHECK_RANGE PSCI_0_2_FN(20)
> +#define PSCI_1_3_FN_SYSTEM_OFF2 PSCI_0_2_FN(21)
>=20
> #define PSCI_1_0_FN64_CPU_DEFAULT_SUSPEND PSCI_0_2_FN64(12)
> #define PSCI_1_0_FN64_NODE_HW_STATE PSCI_0_2_FN64(13)
> @@ -68,6 +69,7 @@
>=20
> #define PSCI_1_1_FN64_SYSTEM_RESET2 PSCI_0_2_FN64(18)
> #define PSCI_1_1_FN64_MEM_PROTECT_CHECK_RANGE PSCI_0_2_FN64(20)
> +#define PSCI_1_3_FN64_SYSTEM_OFF2 PSCI_0_2_FN64(21)
>=20
> /* PSCI v0.2 power state encoding for CPU_SUSPEND function */
> #define PSCI_0_2_POWER_STATE_ID_MASK 0xffff
> @@ -100,6 +102,9 @@
> #define PSCI_1_1_RESET_TYPE_SYSTEM_WARM_RESET 0
> #define PSCI_1_1_RESET_TYPE_VENDOR_START 0x80000000U
>=20
> +/* PSCI v1.3 hibernate type for SYSTEM_OFF2 */
> +#define PSCI_1_3_OFF_TYPE_HIBERNATE_OFF BIT(0)
> +

Reviewed-by: Miguel Luis <miguel.luis@oracle.com>

> /* PSCI version decoding (independent of PSCI version) */
> #define PSCI_VERSION_MAJOR_SHIFT 16
> #define PSCI_VERSION_MINOR_MASK \
> --=20
> 2.44.0
>=20


