Return-Path: <linux-kselftest+bounces-25131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA54A1BD15
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 21:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2E93AEB68
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 20:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5701DA605;
	Fri, 24 Jan 2025 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="SirZecO0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE95155726;
	Fri, 24 Jan 2025 20:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737748842; cv=fail; b=dVwl2TnrNkaGiDEpgTJgP0H2jHaZnvDIx6BSLzCs4VJHA03xbVJSFDUt/tTtinq38mXJinbg/G0X283u2AzmqJi61eFa8Mnml1ouOfBzfUfsag8vpC3SHLFEOP3QBZrG/B9sNT1lC7fc/eEDg68FxenQbet++UmBQsgsdt1mHNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737748842; c=relaxed/simple;
	bh=UzhQoZarILBz7uAM7J+FuS6diMIj1hxFZhX5D4QQPlg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NURR0jbgBH0ZeWxtDyhj7EuWeHeog1QVaQMzfne+KQpNqWljFN7LPWoVIgaJeLSoicmF3b87tDZy9xZeSQ85Pw5ZCFt0kPTBWgJAOAu8UoQ3GNCd6ysuS03IQj9QdrT5iL/BCcRRvFb6Qcs+h+wHQyU58wEbcHWlL4LTIP54LY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=SirZecO0; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OJs871024241;
	Fri, 24 Jan 2025 19:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=UzhQoZa
	rILBz7uAM7J+FuS6diMIj1hxFZhX5D4QQPlg=; b=SirZecO0OmuuhbmLC78M+PK
	SQN2uBB9TAVr/IaSImVkADGUkHinnJBj1L0dRApcasPFXP9SgWrENuWj7IQTuwBY
	mMJmBi9Z7hr1qFWdVNYkDEs8dpro3hYEaY2lZkjT4y+4D4PV3r2OFHg7GVq3Gmf7
	1n4SltlMRrUi4GZgnE4UW9W94hhHjbHSGS8xzRBZjwLBZf3i5qvGVURKSD/S5nhf
	UcmYJuhaFb/G2w7AVEB7lU8eesc6g3z0AQcuZbAP979ZmTo9rF6l/K2iziVEoHou
	eQ6ZZsueJp3BkOPmIdV/lFn664E3sY0Z2F0KNn8Taljo1F0H1Q4kNQTB3aGqJtA=
	=
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4485mknyje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 19:59:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7LYqFXPvE8/yzsaa+4b0bU9ps68yZTSEwiRmg/AkfdUMbmrcRT76/quvTO/Cdi34ydBT94LlLpxTC4tEiHPaEktp/hoVkOnXpZFH/a1jBUqrhBbfdaeYWnk8FI6JHkRt3o5aqF0YhZHuX34DP3JMmFoKaj8v+K56uQHzlqtko3fGEo5A7LvEXWd8qyR/qlywrYz3cqvKGYZX4IL3jrcd2GvpJnH+3iyIxmt4meOYZIUetnVeBf4cX06X6qf9IAIxfUlZG0+i2GAKy1TvMOYflzBjxl8aCdqnjL3Pmvp4IdW+99bpgU1HXTZxc0slkuVjvO3oxZyOg4RK5eKtnEmwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzhQoZarILBz7uAM7J+FuS6diMIj1hxFZhX5D4QQPlg=;
 b=ClNY+JcWB0TUBOd2aJENFy+8fWDJW/zJGYVZULDrPlSci+COJ8ohKK4G5pzLWKCLsf5AWvBiXySjI0Ur0lbj0VrvhTKqCNXGZzdYQqpAcN15bL0b+9Z//s8QIZuPYqisGOcYZb12RUIJHZn7nRVgU0JlGETbqV9lOCXdvvD3rNYWNWa8dMT8dNWug2/ceVtAYGqwQJLpCuqvVLqTnwoc1hq60v+YAQTlgTBZhHa/WZTw7DJqrMyt1TJLBDgta9Qb0aQS+1SfR1cXOE30256PGvyx3ECbFzlY7JaJb1AfzXpmZ0d6uHYfWjUk/ttlkuG3dIsaDZWka9GHb6NQh2sP0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from MW5PR13MB5632.namprd13.prod.outlook.com (2603:10b6:303:197::16)
 by MN2PR13MB3759.namprd13.prod.outlook.com (2603:10b6:208:1ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Fri, 24 Jan
 2025 19:59:05 +0000
Received: from MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197]) by MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197%4]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 19:59:05 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Helen Mae Koike Fornazier <helen.koike@collabora.com>,
        Mauro Carvalho
 Chehab <mchehab+huawei@kernel.org>
CC: Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Nikolai Kondrashov
	<Nikolai.Kondrashov@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>,
        =?utf-8?B?Ikxlb25hcmRvIEJyw6FzIg==?= <leobras.c@gmail.com>,
        Vignesh Raman
	<vignesh.raman@collabora.com>,
        kernelci <kernelci@lists.linux.dev>,
        linuxtv-ci <linuxtv-ci@linuxtv.org>,
        dave.pigott <dave.pigott@collabora.com>, mripard <mripard@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kselftest
	<linux-kselftest@vger.kernel.org>,
        gustavo.padovan
	<gustavo.padovan@collabora.com>,
        pawiecz <pawiecz@collabora.com>, spbnick
	<spbnick@gmail.com>,
        tales.aparecida <tales.aparecida@gmail.com>,
        workflows
	<workflows@vger.kernel.org>,
        skhan <skhan@linuxfoundation.org>,
        kunit-dev
	<kunit-dev@googlegroups.com>,
        nfraprado <nfraprado@collabora.com>, davidgow
	<davidgow@google.com>,
        cocci <cocci@inria.fr>, Julia.Lawall
	<Julia.Lawall@inria.fr>,
        laura.nao <laura.nao@collabora.com>, kernel
	<kernel@collabora.com>,
        torvalds <torvalds@linuxfoundation.org>,
        gregkh
	<gregkh@linuxfoundation.org>, daniels <daniels@collabora.com>,
        shreeya.patel
	<shreeya.patel@collabora.com>,
        denys.f <denys.f@collabora.com>,
        louis.chauvet
	<louis.chauvet@bootlin.com>,
        hamohammed.sa <hamohammed.sa@gmail.com>,
        melissa.srw <melissa.srw@gmail.com>, simona <simona@ffwll.ch>,
        airlied
	<airlied@gmail.com>, broonie <broonie@kernel.org>,
        groeck
	<groeck@google.com>, rdunlap <rdunlap@infradead.org>,
        geert
	<geert@linux-m68k.org>,
        michel.daenzer <michel.daenzer@mailbox.org>,
        sakari.ailus <sakari.ailus@iki.fi>
Subject: RE: [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
Thread-Topic: [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
Thread-Index:
 AQHbbZ5NNj+k8kjIAU+QmcCK7MYwsLMlYZkAgAAyrwCAAEQuAIAADEqAgAAX8oCAABGGAIAASLUAgAAA2sA=
Date: Fri, 24 Jan 2025 19:59:05 +0000
Message-ID:
 <MW5PR13MB5632647364D67725756B77FBFDE32@MW5PR13MB5632.namprd13.prod.outlook.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
	<f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
	<20250124081250.GA24731@pendragon.ideasonboard.com>
	<D7AAOSNDJV11.AXVF80Z934BK@kernel.org>
	<298675d0-ba19-4c87-b00d-57a5e31b05b6@redhat.com>
	<b3af62d3565d2d60218520d2ebace6f1a0368c17.camel@collabora.com>
 <20250124162916.38e5c6a0@foz.lan>
 <19499dcc55d.d07a9615183956.5491109771298297030@collabora.com>
In-Reply-To: <19499dcc55d.d07a9615183956.5491109771298297030@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR13MB5632:EE_|MN2PR13MB3759:EE_
x-ms-office365-filtering-correlation-id: 100c32be-3b46-49e5-620b-08dd3cb18ec3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?REpGMnlLNGdhRXh0T2YxRmxhaFByeHphRWQ5OWZUazlrZjlxR0xvdDVCelNP?=
 =?utf-8?B?REZZL0RvcDVwSWFZNG0xWXppZncwTWo4YUZETUNpQWN2MllPdWRKOGtsZVMw?=
 =?utf-8?B?T1Q4WHNLbG1Cc1k5UzR3andUWWVMcnVFYlMwd0xrZGxUTTNqSzU1OHhETk1I?=
 =?utf-8?B?U2I3Z1ZvdnFZVHZPTDhrUFpManJaV2tTeUdmMS9OU0x4UHBTMzFGb1pBYk52?=
 =?utf-8?B?V2M5eVZkdlE5ZVNTK1o5MGJVOFR4c3I3YVZUSWI3clJyU21wbVh4OVNzL25N?=
 =?utf-8?B?V0pwVU9ZNWlqVFMxK3ZFZmRXY25HbHJOOUlBWGlQOWRoeHpjY1hNcmVLZ3lF?=
 =?utf-8?B?YU9DYUdPTXp2UlllMGIxeUowVGZMb2wxMWxPbU5nOXJka1FOR2Q3L2txcFpt?=
 =?utf-8?B?S1F5MHNONU5uTjVQUWlEdWNEUkJvS25EUzZLcmF1dWhPMysydTY2NUVYMW1H?=
 =?utf-8?B?b0ExU3d0WDNLL05YMzdmOXlTbG4xck1WQmFVWnUxOGNWbmRQUi9MR0ZwdDhT?=
 =?utf-8?B?ekJrZUg3RWIzRmtBMG1SZkdzU1dFd0dNWkw3Rkk3dFoxTXZ2YXpzcU1WaGtn?=
 =?utf-8?B?WWVWdGlxVU9kUU1MUGRWMWkrcWZvcC9QQi8vd0pIUXZqQS94Y21JeXpjRHRr?=
 =?utf-8?B?SDk2VzYwTHpoS2dRdkp1aWpSS1QzM2Z0MERvY2g5c0N2UExFcFNqNFo0a3li?=
 =?utf-8?B?cDVkcEtySTZTbGRtQnVzL2c1RWdrWGZDeVBHdS9MNEs2bldyTUR6ci9Eb0VB?=
 =?utf-8?B?bkx1bGxoSjhUS29lbUZUSU1mYWZ5QlFnRTFEY3dVaVIxZm5kdXZENkxrbTI3?=
 =?utf-8?B?MVFtTSs3MmpyUWhkZVpPeTZXMUxHRkNNK042aUU1blNrbzJSbmo2OVFqcU5W?=
 =?utf-8?B?bXUzRlhPY0hma014NTNqdFhvZEZNdTBaTDVLd0EvQmFtN2VsTndIcW1zVmdR?=
 =?utf-8?B?US9uR3puYzVDd256VGRpSG02NHF2WHlRVFo0L0RRMnFoZHFlSU5ORk80Vlpa?=
 =?utf-8?B?bUJraHlxYkFFUDk5ODNaeHVUR3VNd1lNcmNvL3VJaHFzNVhxejN6ZHhFYlBp?=
 =?utf-8?B?R2xTOUpybVZSQVdsWE1KV3YyS1ZvWmZwS3lhWjF6OVBmRSsvQ2xBdkpZQUg5?=
 =?utf-8?B?aTdzTjRNTHFIYkFQSkxLNDdDSU5HdGRMTUlLU2VDSkhpbEdEcFQrTFptdStE?=
 =?utf-8?B?MDlxNC80bmlwSkd3NitKckhmcm5BQ0tRMUlqWjFJTUlVZnNEeXUrOU55TlF6?=
 =?utf-8?B?NEN5b1U3SC9vazk4YjZtNWhiZWhpVXhwMjJKK2E3eElBY3dPK1BVb2xEWlJD?=
 =?utf-8?B?N2gyWGwwUWlLNnZHR2xLNnRNanR3aVF6TVUrak1qbm5yK25LVTJDNFlKM0Y0?=
 =?utf-8?B?VmxBbm00TlhMV1RjaDhNL21nK09ySEl2RVRheityVFdyUS85UVY0Q0VvSG53?=
 =?utf-8?B?NUF1MEJXb2J3ajUrVFhmOCtVTmxvVmFXMFR6NEZSWHJkc0djU3JGdm05RXRF?=
 =?utf-8?B?ajIybnl5NXhXMi9nVXBzVXd5dGlqdzhaY3l1SDkrdllDbmtWMGJLMVpHaHV6?=
 =?utf-8?B?SmdjRGtlZHBHYU93ZkducGNuSXBBQUhUL3BkQjJQVWNNSjNrSllsTjg3MHFa?=
 =?utf-8?B?VVA2VzBKbk5PUEV5bzY1bkhZTktZKy9HL1IvTHVEUnFXcTN1ZlFVVmQ2UXVh?=
 =?utf-8?B?dGlmQnNlZUREVDdxTitBTS9ScHY1RklwY05FbjFPRFAveXYrRE1lYU9ld3pk?=
 =?utf-8?B?ekNwUlVNUWR0RDd0Y1ZyN0hnTGNneVFjUHhVZFhWbDlnQ1E5K3pvMW9nTmhF?=
 =?utf-8?B?endwd1NaYnJBMnB6R2hRRDVmTUpkSUZSZStXdGM5ZXhndGR3QzZDWFc3SnE2?=
 =?utf-8?Q?guVdP93gIB4kQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR13MB5632.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmFCZWsreWNjckpWRkZWQnU1blNvUUNubVJQWEFUSjdXSGx6VzNVakhhS0xP?=
 =?utf-8?B?Q3JXaHg3Nm5kUlF1TDRDTnZSeU1UMWxWMDVTbmlTN2xaei90R0VWSk56aFZ1?=
 =?utf-8?B?ZmFkdStjQkVRU3BUSG13VjVFU3ZkYlFaYitDdURKQUNwUUZqWGtTMUM1em1S?=
 =?utf-8?B?VklxWEd1ajQ5RE1WVDlyWW15SUtjbStCSTVLeEM0UXlwN2s5V29LUXNWYzIz?=
 =?utf-8?B?TklTb2ZoMFlYeUoxSVduYVZnSktQNGVoUFFEN2pKZVN6dFhOcXYxRkd1ZHdC?=
 =?utf-8?B?djRZQUZhQy9Va0w2Zlh4Zk85d1dLK0l5Z1k4V1VRVnNxZFozeGVoQTY5Qy9H?=
 =?utf-8?B?MlBFNVN1NDBqWXgwbDZuZG9ac2d1ZWhUTTlmWTNmSk1nQWM5U1RrOWtVWEdH?=
 =?utf-8?B?VVhpNVg2WTVYaDBEamRia3ZrYThoaWR2ZXpLK2YvRmpBQnNnYXpPV2wxTXgy?=
 =?utf-8?B?dkZYc3IvTFJ6WTB3cmJxVXdTeXNoY2ZodzcwekxOY0diNjhlcnVTdDF5MHZ3?=
 =?utf-8?B?bnNBMkxybzhFckRjWGxUUGIwL05nd3BtUHBrZmtkdW1pSmlYb2hQTG9raU9O?=
 =?utf-8?B?YTR6L2RkZWlHU0gySkxnWldBSENCRXFEZmpVZHk3RVBzZi9oTWZKZU51dFNZ?=
 =?utf-8?B?cGlsQlJEaE1JVHIzczNNbVVJYmZTZEtOZWpIdUhiZTBkR1RkMTFycGVYaHRa?=
 =?utf-8?B?YXUrK0VLZnVjS016MFh1c21KN2UzYzZncDdsK2E0OFRDYk4rY0ZaQzFLVjBV?=
 =?utf-8?B?OUxUcGJ3WE91cTVtc3JQbmV1M1BiYUpMUDQxcHNFS3BZZGx3SDNGMUxQY3JV?=
 =?utf-8?B?VVVCTlNmMy9yVkwwRTFBVFAvYlkzcjB2cXF2bjFDSFFZY2h3SDRQRU5zbUJt?=
 =?utf-8?B?UEVqODVyb1BjMktMUWVBRGtrZTRPVWJGWXVzNmRGaUVTN3FzSEJock9CTjVm?=
 =?utf-8?B?d29Ldm1XNzh2VXBmRDBFT3hMRUtxNU04c3c3c3pZSXVBeWt3Y0t1WEZlSVlo?=
 =?utf-8?B?aFZ1aG5zZk5BUHdsRnp2ZXBYaTNDQXk3RURsWmttdUVzQXZLR2VINitLcjZ2?=
 =?utf-8?B?VnplT1dJR3Nwa3RFL3A2eGtwbndqSHJERktRWWNWUVNhQTVJcmJ2RUZrb1dz?=
 =?utf-8?B?ZVZXZHN2NG9HNFhzTktJMkNGMnhRbmlvSk1lbjVyNVBEaTJ1MXVRT2dwNGhE?=
 =?utf-8?B?bVpSdlVtaENxV0x0bVFmZThZbzVyTkc0akd5YlFKdFBZWWkwUlp5Y1lhZlJI?=
 =?utf-8?B?Z05XMGdrNWg3M2JoQ0tRSmVzTWhxMEJibkUzRnk4YjJ6SUsrWGpscXBaR0J4?=
 =?utf-8?B?ZzNNeTJmWWVBYXJXdzVDWDVMMXZra3BNZXY1Z0RDLzRDRzZRTTRBMTFacDZE?=
 =?utf-8?B?Vk5NSmxNeFQxdHpDU2RHeW96dFNhQ1JEK0tJTEljMXdjMUsxWlAyWXAvSmRE?=
 =?utf-8?B?UWVCK2hxUjRkd3pNVnlUYm9abExZOEpjcEtKL3NYd09ESllROU92eHV2bTZH?=
 =?utf-8?B?Y1o0bW5zOFdKTGh5RlFEdFphVHJXS255Wi9Qd2pBTmhjcHExUVhhMXQvWnVs?=
 =?utf-8?B?bGJRTmtWTHdxSTlaeXphYlZwNjViblFoRUpleUdkMWJ1Y3JnZTE5ZVREdlpZ?=
 =?utf-8?B?cGVYYUtSN1IzQjJJVzc3ZnVGdmFueExSUWl1MjFURFV4YS95RTI0S2JxYU5B?=
 =?utf-8?B?YXR2TE4vbk9ob1piUDNuQk9RYnB4UHF1Nk1ZUFFZMlg2YW83RHlhVWNpMEps?=
 =?utf-8?B?UUtiZUZ4eVRiaWlwNTBualRmOWZza01aM2Rod2s5Uk05ODRDRFU3bHA0Kzhu?=
 =?utf-8?B?V3lzZENudS9RajQrOERhYTRpc0loMmpUOTlRTVRmckY4M2U3YmYzSEM4K2Er?=
 =?utf-8?B?bGNBVUZMQ2hiM0FGdi9SNUtnUGIxSzFxTFN2a213TGxmSlNwVGZlcG9GSVFP?=
 =?utf-8?B?ZG8wRDdJMTB1TTMvWlA0Q3VON0kvY0k2bGhxR0ZmVjFSMFM2a2N1b241ZXpR?=
 =?utf-8?B?VzlNWlBoWlNHVnF0VXlrWEpNNzRPQ3hFVGZZZi9EV3ZJUk0wU1hIRVBWelRZ?=
 =?utf-8?B?VEUzTjg3WkV5c25kdWVLOEVzT01TQlVHcGtjaklmWTBEMUhabytpWUIrQlFu?=
 =?utf-8?Q?Az4A=3D?=
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
	wxCEV0ud+2u7tWdcS9K2hvzZwT6UXp5+wY6NsAyKspn290WZw60B9WdaaItj9St15zsjHepfFR0uqJ6AyGwR0Ao01A4iWR30Fhy1RSMRcAL+zKWuzaS/jKGFhngomMS95eVZs3pNFUcRD3XDFfSQM/i9KUW+phmxK/nK0H890eMgF0Phat+fjFyzef3lhiOoMU5KektHTrbVSZ+/T2CY8u7z/mzgeJqFnFHxh+UerPR50jafr0EbqXIuTykPl/3HzNiWY7gptyWioZ1ffx6wOnGSXDD4Xq2Vy6IM4r/Bhj4CiZ23ll2AdQqeqMPObaQQW3xSGo1gMEFAzTJG0WvPLFqvtYS6adGdokfNssZuxcj6muaX3D+4b3D1q7Smii3RDMx8QEVsLADwQ9boKcvxuV3uW3Xtn6uDS6YP7f/jKoynpvn4WUt8Xjr3Fbj5X+NCMDiMBLdH7AVZqknEOphfqjR4Ma9hwFGN6+hyDbT4hNyrYBdhCT9NUiLYqmVawdv0ra0r4PqE9oa5mQqneOW4w4Tj+xKQp8VNz9UaU6JpsK0Qh+fEWvGt8zb/giBQQ4bt/itFqFtKquVCtFpEmCgmpuO1wavC60vA0Jn6Yr35KAjMN0Iv2ZiPsj5R9vqrD4Tw
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR13MB5632.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100c32be-3b46-49e5-620b-08dd3cb18ec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 19:59:05.8475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7UWvFLodch3y1paHApck0JOdqIzkc3oW3JaWzrrXvwglUk0ayYs+WJf81PUDNmli/L8bGO6q7VCQqoIfQNPM+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3759
X-Proofpoint-ORIG-GUID: XQZXGiSRmDtOhD_GTI43tO2GbhhPDVRe
X-Proofpoint-GUID: XQZXGiSRmDtOhD_GTI43tO2GbhhPDVRe
X-Sony-Outbound-GUID: XQZXGiSRmDtOhD_GTI43tO2GbhhPDVRe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_08,2025-01-23_01,2024-11-22_01

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGVsZW4gTWFlIEtvaWtl
IEZvcm5hemllciA8aGVsZW4ua29pa2VAY29sbGFib3JhLmNvbT4NCj4gSGkgTWF1cm8sDQo+ICAN
Cj4gLS0tLSBPbiBGcmksIDI0IEphbiAyMDI1IDEyOjI5OjE2IC0wMzAwIE1hdXJvIENhcnZhbGhv
IENoZWhhYiAgd3JvdGUgLS0tDQo+IA0KPiAgPiBFbSBGcmksIDI0IEphbiAyMDI1IDA5OjI2OjMz
IC0wNTAwDQo+ICA+IE5pY29sYXMgRHVmcmVzbmUgbmljb2xhcy5kdWZyZXNuZUBjb2xsYWJvcmEu
Y29tPiBlc2NyZXZldToNCj4gID4NCj4gID4gPiBIaSwNCj4gID4gPg0KPiAgPiA+IExlIHZlbmRy
ZWRpIDI0IGphbnZpZXIgMjAyNSDDoCAxNTowMCArMDIwMCwgTmlrb2xhaSBLb25kcmFzaG92IGEg
w6ljcml0IDoNCj4gID4gPiA+IE9uIDEvMjQvMjUgMjoxNiBQTSwgSmFya2tvIFNha2tpbmVuIHdy
b3RlOg0KPiAgPiA+ID4gPiBPbiBGcmkgSmFuIDI0LCAyMDI1IGF0IDEwOjEyIEFNIEVFVCwgTGF1
cmVudCBQaW5jaGFydCB3cm90ZToNCj4gID4gPiA+ID4gPiBHaXRsYWIgYXMgYW4gb3Blbi1zb3Vy
Y2Ugc29mdHdhcmUgcHJvamVjdCAodGhlIGNvbW11bml0eSBlZGl0aW9uKSBpcyBvbmUNCj4gID4g
PiA+ID4gPiB0aGluZywgYnV0IGNhbiB3ZSBwbGVhc2UgYXZvaWQgYWR2ZXJ0aXNpbmcgc3BlY2lm
aWMgcHJvcHJpZXRhcnkgc2VydmljZXMNCj4gID4gPiA+ID4gPiBpbiB0aGUga2VybmVsIGRvY3Vt
ZW50YXRpb24gPw0KPiAgPiA+ID4gPg0KPiAgPiA+ID4gPiBJIGRvbid0IHRoaW5rIHdlIHNob3Vs
ZCBoYXZlIGFueSBvZiB0aGlzIGluIHRoZSBtYWlubGluZSBrZXJuZWwuDQo+ICA+ID4gPiA+DQo+
ICA+ID4gPiA+IE9uZSBhbmdsZSBpcyB0aGF0ICJubyByZWdyZXNzaW9ucyBydWxlIiBhcHBsaWVz
IGFsc28gdG8gdGhlIHNoZW5hbmlnYW5zLg0KPiAgPiA+ID4gPg0KPiAgPiA+ID4gPiBEbyB3ZSBy
ZWFsbHkgc3BlbmQgZW5lcmd5IG9uIHRoaXMgcHJvcHJpZXRhcnkgY3JhcCB0byB0aGUgZXRlcm5p
dHk/DQo+ICA+ID4gPg0KPiAgPiA+ID4gVGhpcyBpcyBub3QgZ2V0dGluZyBpbmNsdWRlZCBpbnRv
IHRoZSBrZXJuZWwgaXRzZWxmLCB0aGUgY29udHJpYnV0ZWQgY29kZSBpcywNCj4gID4gPiA+IG9m
IGNvdXJzZSwgb3Blbi1zb3VyY2UuIEFuZCB5ZXMgaXQgd291bGQgZXhlY3V0ZSBqdXN0IGZpbmUg
b24gdGhlIGZ1bGx5DQo+ICA+ID4gPiBvcGVuLXNvdXJjZSBjb21tdW5pdHktZWRpdGlvbiBHaXRM
YWIuDQo+ICA+DQo+ICA+ID4gPiBJIGRvbid0IHRoaW5rICJubyByZWdyZXNzaW9ucyBydWxlIiBz
aG91bGQgYXBwbHkgaGVyZS4NCj4gID4NCj4gID4gSXQgZG9lc24ndCwgYXMgdGhpcyBpcyBub3Qg
YSBLZXJuZWwgdXNlcnNwYWNlIEFQSS4gSXQgaXMganVzdCBzb21lDQo+ICA+IGZhY2lsaXR5IHRv
IGludGVncmF0ZSBLZXJuZWwgYnVpbGRzIHVzaW5nIGEgQ0kgaW5mcmFzdHJ1Y3R1cmUuIFRoaXMg
Y2FuDQo+ICA+IGNoYW5nZSB3aXRoIHRpbWUgYXMgbmVlZGVkLg0KPiAgPg0KPiAgPiBTdGlsbCwg
b25jZSBwZW9wbGUgc3RhcnQgdXNpbmcgaXQsIGRldmVsb3BlcnMgbmVlZCB0byB0YWtlIHNvbWUg
Y2FyZSB0bw0KPiAgPiBhdm9pZCByZWdyZXNzaW9ucyB0aGF0IHdvdWxkIGNhdXNlIENJIGJ1aWxk
cyB0byBmYWlsIGZvciB0aGUgb25lcyB1c2luZw0KPiAgPiBzdWNoIGZhY2lsaXRpZXMuDQo+ICA+
DQo+ICA+IEFsc28sIGlkZWFsbHksIHRoaXMgc2hvdWxkIGJlIGNvbXBsZXRlbHkgaW5kZXBlbmRl
bnQgb2YgdGhlIEtlcm5lbCB2ZXJzaW9uLA0KPiAgPiBlLmcuIGlmIG9uZSBzZXRzIHVwIGFuIGlu
ZnJhIHVzaW5nIHRoZSB2ZXJzaW9uIHRoYXQgd2FzIHRoZXJlIHdoZW4sIGxldCdzDQo+ICA+IHNh
eSwgS2VybmVsIDYuMTQgaXMgcmVsZWFzZWQsIHRoZSBzYW1lIENJIHNjcmlwdHMgc2hvdWxkIHdv
cmsganVzdCBmaW5lDQo+ICA+IHdpdGggc3RhYmxlIEtlcm5lbHMgYW5kIGV2ZW4gZnV0dXJlIEtl
cm5lbHMuDQo+IA0KPiBPciB5b3UgY2FuIGp1c3QgY29uZmlndXJlIHlvdXIgR2l0TGFiIENJIHRv
IHdvcmsgYW5kIGFuIG9sZGVyIHZlcnNpb24gb2YNCj4gdGhlIHNjcmlwdCBieSBqdXN0IHBvaW50
aW5nIHRoZSByaWdodCB5YW1sIFVSTCBhdCB0aGF0IHZlcnNpb25zIGluIHRoZSBjb25maWdzLA0K
PiBvciBhbSBJIG1pc3Npbmcgc29tZXRoaW5nPw0KPiANCj4gID4NCj4gID4gRHVlIHRvIHRoYXQs
IEknbSBub3QgY29udmluY2VkIHRoYXQgc3VjaCBrZXJuZWwgQ0kgZmlsZXMgc2hvdWxkIGJlDQo+
ICA+IGhvc3RlZCBhdCB0aGUgS2VybmVsIHRyZWUuDQo+ICA+DQo+ICA+IElNTywgdGhpcyBzaG91
bGQgYmUgc3RvcmVkIG9uIGEgc2VwYXJhdGUgcmVwb3NpdG9yeSBob3N0ZWQgYXQNCj4gID4ga2Vy
bmVsLm9yZywgdXNpbmcgU2VtYW50aWMgVmVyc29uaW5nIChodHRwczovL3NlbXZlci5vcmcvKSAt
IGUuIGcuDQo+ICA+IHdoZW4gdGhlcmUgYXJlIGluY29tcGF0aWJsZSBjaGFuZ2VzLCBtYWpvciB2
ZXJzaW9uIG51bWJlciB3aWxsIGJlDQo+ICA+IGluY3JlYXNlZC4NCj4gDQo+IEEga2V5IGJlbmVm
aXQgb2YgaGF2aW5nIGl0IGluLXRyZWUgaXMgdGhlIHRlc3QgZXhwZWN0YXRpb24gbGlzdCwgYXMg
c2VlbiB3aXRoDQo+IERSTS1DSS4gVGhpcyBhbGxvd3MgZGV2ZWxvcGVycyB0byB0cmFjayB0aGUg
c3RhdGUgb2YgZHJpdmVycyBhbmQgcHJvZ3Jlc3Mgb3Zlcg0KPiB0aW1lIGJ5IHNob3dpbmcgd2hp
Y2ggdGVzdHMgYXJlIGV4cGVjdGVkIHRvIHBhc3Mgb3IgZmFpbCBhdCBhIGdpdmVuIHBvaW50IGlu
DQo+IGhpc3RvcnkuIChGcm9tIHdoYXQgSSBzZWUgaW4gRFJNLUNJLCB0aGlzIGFkZHMgYSBjb25z
aWRlcmFibGUgYW1vdW50IG9mIHZhbHVlLikNCj4gUGxlYXNlIGNoZWNrIHRoZSBWS01TIHBhdGNo
IGluIHRoaXMgcGF0Y2hzZXQuDQo+IA0KPiBBbHNvLCBpZiB3ZSBrZWVwIHRoaXMgdG9vbCBvdXQg
b2YgdHJlZSwgSeKAmW0gY29uY2VybmVkIHRoYXQgc3Vic3lzdGVtcyBsaWtlIERSTQ0KPiBhbmQg
TWVkaWEgd2lsbCBjb250aW51ZSBub3QgY29sbGFib3JhdGluZ+KAlGVhY2ggY3VycmVudGx5IGhh
cyBpdHMgb3duIHNvbHV0aW9uDQo+IHdoZW4gdGhlIGJhc2UgY291bGQgYmUgc2hhcmVkIGFuZCBy
ZXVzZWQuIEFsbCBzdGF0aWMgY2hlY2tzLCBidWlsZCBwcm9jZXNzZXMsDQo+IGFuZCBib290IG1l
Y2hhbmlzbXMgYXJlIGZ1bmRhbWVudGFsbHkgdGhlIHNhbWUsIHdpdGggb25seSBtaW5vciBkaWZm
ZXJlbmNlcw0KPiB0aGF0IGFyZSBjdXN0b21pemFibGUuIE90aGVyIHN1YnN5c3RlbXMgY291bGQg
dXNlIGp1c3QgdGhlIGJhc2Ugb3IgYnVpbGQgdGhlaXINCj4gc3BlY2lmaWMgY29uZmlndXJhdGlv
bnMvdGVzdHMgb24gdG9wIG9mIGl0Lg0KPiBIYXZpbmcgaXQgaW4tdHJlZSBzZW5kcyBhIG1lc3Nh
Z2U6ICJZb3UgY2FuIGNyZWF0ZSB5b3VyIG93biBHaXRMYWIgQ0kgcGlwZWxpbmUsDQo+IGJ1dCB3
aHkgbm90IHVzZSB0aGlzIGV4aXN0aW5nIG9uZSwgY29udHJpYnV0ZSB0byBpdCwgYW5kIGNvbGxh
Ym9yYXRlIGZvcg0KPiBldmVyeW9uZSdzIGJlbmVmaXQ/Ii4NCj4gU2luY2UgaXQncyB1bmRlciB0
aGUgdG9vbHMvIGZvbGRlciwgaXTigJlzIGEgaGVscGVyIHRvb2wuDQoNCkFsdGhvdWdoIEkgZG9u
J3QgdXNlIGdpdGxhYiBDSSBmb3IgbXkga2VybmVsIHRlc3RpbmcgKEkgdXNlIEZ1ZWdvKSwgSSd2
ZSBiZWVuDQp3YWl0aW5nIGZvciB0aGlzIHNvIHRoYXQgSSBjYW4gc2VlIGlmIGl0J3MgcG9zc2li
bGUgdG8gbGV2ZXJhZ2UgdGhlIGluZm9ybWF0aW9uDQpjb250YWluZWQgaW4gaXQgZm9yIG15IG93
biBDSSBzeXN0ZW0uICBJIG1heSBub3QgZW5kIHVwIHVzaW5nIHRoZSBpbmZvIG15c2VsZiwNCmJ1
dCBhdCBhIG1pbmltdW0gaXQgd2lsbCBzaG93IG1lIHRoZSBpbmZvIG5lZWRlZCBieSBhbm90aGVy
IENJIHN5c3RlbS4NCg0KSGF2aW5nIHRoaXMgdXBzdHJlYW0gaXMgdXNlZnVsLCBJTUhPLCBldmVu
IGlmIGl0IGp1c3QgcmVmbGVjdHMgYSBzaW5nbGUgQ0kgc3lzdGVtDQpjdXJyZW50bHkgYmVpbmcg
dXNlZC4NCiAtLSBUaW0NCg0KDQo+ICA+ID4gPiBUaGlzIGlzIGZvciBkZXZlbG9wZXJzIG9ubHks
IGFuZCBpcyBhIHRlbXBsYXRlIGZvciBtYWtpbmcNCj4gID4gPiA+IHlvdXIgb3duIHBpcGVsaW5l
IG1vc3RseSwgd2l0aCBwaWVjZXMgd2hpY2ggY2FuIGJlIHJldXNlZC4NCj4gID4gPg0KPiAgPiA+
IFBlcmhwYXMgd29ydGggY2xhcmlmeWluZyB0aGF0IE1lZGlhIGFuZCBEUk0gc3Vic3lzdGVtIGhh
dmUgb3B0ZWQgZm9yIHRoZQ0KPiAgPiA+IEZyZWVkZXNrdG9wIGluc3RhbmNlLiBUaGlzIGluc3Rh
bmNlIGlzIHJ1bm5pbmcgdGhlIE9wZW4gU291cmNlIHZlcnNpb24gb2YNCj4gID4gPiBHaXRsYWIs
IHdpdGggaHVuZHJlZHMgb2YgQ0kgcnVubmVycyBjb250cmlidXRlZCBhbmQgc2hhcmVkIGFtb25n
IG1hbnkgcHJvamVjdHMNCj4gID4gPiAod2hpY2ggaW5jbHVkZXMgTWVzYSwgR1N0cmVhbWVyLCBX
YXlsYW5kLCBQaXBld2lyZSwgbGliY2FtZXJhLCBqdXN0IHRvIG5hbWUNCj4gID4gPiBmZXcpLg0K
PiAgPg0KPiAgPiBJdCBkb2Vzbid0IG1hdHRlciBtdWNoIHdoYXQgZ2l0IGZvcmdlIHNvbWUgcHJv
amVjdHMgYXJlIGN1cnJlbnRseSB1c2luZywgYXMNCj4gID4gdGhpbmdzIGxpa2UgdGhhdCBjb3Vs
ZCBjaGFuZ2Ugd2l0aCB0aW1lLg0KPiAgPg0KPiAgPiBTdGFydGluZyB3aXRoIHN1cHBvcnRpbmcg
anVzdCBvbmUgdHlwZSBvZiBnaXQgZm9yZ2Ugc291bmRzIE9LIHRvIG1lLA0KPiAgPiBidXQgbG9u
ZyB0ZXJtIGdvYWwgc2hvdWxkIGJlIHRvIG1ha2UgaXQgZ2VuZXJpYyBlbm91Z2ggdG8gYmUgdXNl
ZCB3aXRoIGFzDQo+ICA+IG11Y2ggQ0kgZW5naW5lcyBhcyBwb3NzaWJsZSAtIG5vdCBvbmx5IGZv
cmdlcyBkZXZlbG9wZWQgYnkgY29tcGFuaWVzIHRoYXQNCj4gID4gcHJvdmlkZSBwYWlkIHNlcnZp
Y2VzIGxpa2UgR2l0bGFiL0dpdGh1YiwgYnV0IGFsc28gY29tcGxldGVseSBvcGVuDQo+ICA+IHNv
dXJjZSBmb3JnZXMgYW5kIGV2ZW4gSmVua2lucy4NCj4gID4NCj4gID4gVGhhbmtzLA0KPiAgPiBN
YXVybw0KPiAgPg0KPiANCg0K

