Return-Path: <linux-kselftest+bounces-43110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA59BD7F35
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 09:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA7E424A5F
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 07:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36102BFC8F;
	Tue, 14 Oct 2025 07:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="QAjuNs2e";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="VKlcmRxd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41D72D8DAF;
	Tue, 14 Oct 2025 07:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427192; cv=fail; b=IXkaZYyQZSiaXoBhM/KDO6VpcPXAGwAbTzJhRqkUOczDhyMvEGO+xkywO94gqsdNC2Cdb3i+KdFyJPS5+uwq0QsWpTyPrHxEiQT3HCZKjhKgKhxyXJiw71ms4Oqmnoz3b7xNF8cIrGpTfborMLL41vyqSYKBp2smX55AEK1bfXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427192; c=relaxed/simple;
	bh=UbPytBiD4JuZCc1ntlt9pEl6wbIsO1ah3y/C0mVQACA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gufIaCGZQO6f1c4m/i07Coidft7oP62/AcmkljiB8UQZjzEgZijzrOq3DMl7GUyCogAt6aZ9wetA3VYqPduzzmz7ibHT1QbYh8YYzpW6NJc/J62lek0ORmAZSGwZgyFgsKdajZMaQlGnC0/Ql1sktJp0ncCdo0FodUrAbNhlJog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=QAjuNs2e; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=VKlcmRxd; arc=fail smtp.client-ip=68.232.159.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1760427190; x=1791963190;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UbPytBiD4JuZCc1ntlt9pEl6wbIsO1ah3y/C0mVQACA=;
  b=QAjuNs2ez+9tOCYtJ2dmaO2ZuqcOfsutmBZY6eiQhL5WWhoy8rHwHpiI
   lfiFSFsZuzCq67koWBofXN+b6hRXEDaTOugBKPcDmKvEDX4o6PSrZheTI
   e/g+irddEixw0X+qnY4QzYJxNCrAFln5rjdkf9jNqbfJHd+onNR1bvP9J
   jByR6IqId6NWYJi8yysrrprE980OTwPnHWKe/j9X0yZotPCR7kXFirh8v
   THs7CJJFdQZRe9UMP8+iytTFp6xsyGWHJdyajI01AOZGAlGU64JfeqWcD
   8t2BhaIavgwpnSJlwG2V8OTSDJzTbrByL1IYHn3W2lPTZ0FwaOS/qKWRj
   A==;
X-CSE-ConnectionGUID: fVpdulIwTYugTPeakYbOng==
X-CSE-MsgGUID: eRKye3/xSZCj3A13Yap8Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="170710444"
X-IronPort-AV: E=Sophos;i="6.19,227,1754924400"; 
   d="scan'208";a="170710444"
Received: from mail-japaneastazon11010039.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([52.101.229.39])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 16:31:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGLM+ptIMbK9/GlJ/bAdXAeezprQ0kzB2x7XLLfhTO0gSdCKswAFhAmSQgHTgYpHe8Axop7Lx0n4jkP6zyt5+AFgpspNs6J5nYzcyPyXuWIGMgDCXiz/rfAF/0O4r6//Mox0W01XJUzwRgjHrtmNiCs/AaBslGxlI0MxPdqTRbQ39Vqa/avaJ18lXUD2Sio1mlE9TF8Tgms4WDJM0dTfxuGzyxOnQT0SBkhzpY4C5k5MF6IJUdzMoBzdpBzXYg8L9rjHqHWKXP/fwftgbUkX/vJXJd2oQk/vBDhIOQODtmrfwhUued57Grkju8c26o/A9ffdSx9yRDDIKGpuJ3AS3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbPytBiD4JuZCc1ntlt9pEl6wbIsO1ah3y/C0mVQACA=;
 b=MLjmzdFgX3HqJYY5aaLLcQ2J+8vZbm2qqryRbngY/Ydei9L0ETCO4UqROZd55DTJSBDQm4sgAFGIV2izqbPZ9wOtHlNKEXTJkrfN2PfdrNHXYZS6zYOWAyeAjeSnjcifTH76GhRF2FGl08Ljb/7KczLISSBe1YP51/F2K1rUvyh65JlnIjtyyMvWUqaK4XYvyynrM/x70lsQG6z1mlyhzkUw1hs0MeVcrSzxOIojNTZtEbcHYWJt72vlfZRC9/LkhygZ33wgP65ypFvWvgTSdqweMm2anYP/vsprZCEBXS0lPtKjRb4w6dkt/lNk/4bGZShgLLgpwNR5byLc0RDwRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbPytBiD4JuZCc1ntlt9pEl6wbIsO1ah3y/C0mVQACA=;
 b=VKlcmRxdTZoiY+SSKgh9lD3/ZdybxLZEXJ2xqeVJSNQOfNGZw5MW2LvpIhr51EjHJ8cuWwj5bx1gSRgm6M8rCEzkOgJUAIsKy9H+FRde2pAZhBx+wmYexOV8ylB5L+LioxnYiaCQ/d9cNVLiWPbIdsP+2ohxMst8CzwuP+2S0DsZ6u/HWf/BBFugz3M7v6dtkVuMkgBMcC/IVQoxiZDvFeZvKovRciQlln8eZ9lrxiPHO30rGJoEKe1LIWuhZKcYCc4VTbKf3X8QD/zqz1T1fxex6fcgAlZ3e/BrT5C5vP5svSritbG5B6YY8oJ1IoFvvmdd5g10gEdi+RlsQ1rPwg==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TYWPR01MB11217.jpnprd01.prod.outlook.com (2603:1096:400:3f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Tue, 14 Oct
 2025 07:31:51 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9228.005; Tue, 14 Oct 2025
 07:31:50 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: "'Moger, Babu'" <bmoger@amd.com>, 'Babu Moger' <babu.moger@amd.com>,
	"'james.morse@arm.com'" <james.morse@arm.com>, "'dave.martin@arm.com'"
	<dave.martin@arm.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'linux-kselftest@vger.kernel.org'" <linux-kselftest@vger.kernel.org>,
	"'ilpo.jarvinen@linux.intel.com'" <ilpo.jarvinen@linux.intel.com>,
	"'maciej.wieczor-retman@intel.com'" <maciej.wieczor-retman@intel.com>,
	"'peternewman@google.com'" <peternewman@google.com>, "'eranian@google.com'"
	<eranian@google.com>, "'fenghua.yu@intel.com'" <fenghua.yu@intel.com>,
	"'reinette.chatre@intel.com'" <reinette.chatre@intel.com>,
	"'shuah@kernel.org'" <shuah@kernel.org>, "Swapnil.Sapkal@amd.com"
	<Swapnil.Sapkal@amd.com>
Subject: RE: RE: [PATCH v3 0/4] selftests/resctrl: Enable MBM and MBA tests on
 AMD
Thread-Topic: RE: [PATCH v3 0/4] selftests/resctrl: Enable MBM and MBA tests
 on AMD
Thread-Index: AQHcOMMcHTMo7Zd2vkWleDxNKUE337S5Gf1ggAJsQACABaWUAA==
Date: Tue, 14 Oct 2025 07:31:50 +0000
Message-ID:
 <OSZPR01MB8798168634207A7F7C2BD3C58BEBA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <cover.1717626661.git.babu.moger@amd.com>
 <OSZPR01MB8798A07599944A1790AD03B48BEEA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
 <a8dc8c62-6cc5-46f0-a514-d2e97c3313c3@amd.com>
In-Reply-To: <a8dc8c62-6cc5-46f0-a514-d2e97c3313c3@amd.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9NTkwMzg3NmYtODhkMi00NWQ2LTkyNTMtNzVhNjdkZjg0?=
 =?utf-8?B?OGE2O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjUtMTAtMTRUMDU6NTI6MDVaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7TVNJUF9MYWJlbF9hNzI5?=
 =?utf-8?B?NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfVGFnPTEwLCAzLCAw?=
 =?utf-8?Q?,_1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TYWPR01MB11217:EE_
x-ms-office365-filtering-correlation-id: e50e4aa0-9769-4e35-552d-08de0af3bd8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?TER0T21MYmNmdG1MVnJsM09UUjhzWVYxSlZQS2tmb3lhRTUwVE5lQWRHYytS?=
 =?utf-8?B?bFkzMzl5bUloQW0yRW1wakFwd3VQdWt6czNYZkY5RGtXK1NsNVg5M2sva1dZ?=
 =?utf-8?B?dkt6VXdzQWhIZUN2bi8rQlNJazgrZnRaUHVCV253bTZpbnhHOEUwRkplV2VX?=
 =?utf-8?B?OWx3bjRiSHM5YzZmazNvUjRQN3Q0Q2d2blJDTUtVVjVseGNGSWtNcWpOSnZu?=
 =?utf-8?B?ZWFzNVhHTzNMZEFyRktVNmlHL3VzTXJiSFBZSHpzeTVLaGVySkJEc3RHYXlE?=
 =?utf-8?B?MTMxdXdNNkZpbVRRbXdCYlh4dDlpS1h5ZVR2Viswd1diV281TXo4V3FtVnhm?=
 =?utf-8?B?dmoraEJKcU9jMlE1RldWenE2OGNaNFBxUGdBdXhHMkR0d1lrZzBmK0EzSGZq?=
 =?utf-8?B?YmppQUhCYUhsdFcyZzhEMUVoSTBpUU9RWFNrSEJKUkQ0NENENWt5WmhSVytq?=
 =?utf-8?B?ajYyeXhmS1pPSURWNEpqTU5SQWpTMTFweHVBSTU0SG1ML1VlWGI0SnBoWWtp?=
 =?utf-8?B?UGFhVlB3ckpSdGhFMmYxRmlBeFoyZnYrOERPQ3V5TW1ENVlMbC96R0pmL1c0?=
 =?utf-8?B?Z1oxekI4dndUNEN0Z05yUHFkVFloTHdTQTUvMjRpNWlKRXFnQXJhcUFIN1FW?=
 =?utf-8?B?enhNdWJHVE55K2NvZU5MbHdLSjYvVE1lZExJT3F6a010MUk3TWRnL3hON3FD?=
 =?utf-8?B?M253WlpRbFhvUjBrTW85RjNIcWJIOVZtOWdBVWxKS3MwOHVLaW9JMmRKSVFo?=
 =?utf-8?B?L0kwQUxOVWxxRUJjMGVHbTFldU9NNHpvL1RRVWxvSXFVcDdFOW41eGZ4Ulpu?=
 =?utf-8?B?Ti94QUZ1L2pxcmNmMjV3VnNHcUR0emlNWlFnaHdGdXllMUdnM00rWGtBTDVs?=
 =?utf-8?B?TnczV2xGZXc1RVNMMWhPTDBTQVBiRUVqdUFqSStDTUF0WWwzMDNSOE1CMmYv?=
 =?utf-8?B?a3dOMGNnVVNhZk5hOERPU2N2aVRmOVZ6a21GRk5zdUNtdVZXYnl5MGxkSzh4?=
 =?utf-8?B?Tkw4R3lTYm9ZdmQ4MzYwWWo0REhNelZIb05NaVk1VmdhMFhUdHRGZWZGUFor?=
 =?utf-8?B?anVYNWszRjZnVjZWc2JZMm1nUi9MNy9GWHVUbDhzMk9GSldybTByZ1lXS2o1?=
 =?utf-8?B?dmNDZVd5dExsenQ2Z3JRbHNLeElJajlydVBqRlhMQjBiaU0wU3VNY3RoSVlC?=
 =?utf-8?B?YXBRZWlyaytQcE9tRHh6d0k5dUZoWGVIdXdxVUVKWm5DYi9ONmJZK0IxWndk?=
 =?utf-8?B?ZUFSRTh4QjVVWTJ3emdCYXVXdS82WDAvVU1SYzZyVEQ5RTg3V2F3c1AvTXZQ?=
 =?utf-8?B?SXJhUHlHODhJcE5NNW1odXE2dFY1OVBCN3RwYTludWpVb3FoOFFnbDJYYTdB?=
 =?utf-8?B?Q3dGMlUwRG53Zlp1TkFJMXJVeXBjQVZLUzdlMzI1L21laUlIVHU2ZUlkaE5D?=
 =?utf-8?B?MCtzQ2tvc2kwVWtlZWdlUU05VVNnMnhQd3B6cjRaY3N1SXZENWZQbWNlOVRs?=
 =?utf-8?B?UlcwTlZ4TGpKSldrR0FCTUxBYWZoOENyaDRFUEpXYXRnZFljMlA0Nk5oQlJw?=
 =?utf-8?B?WEFZZ1VwbWlNUDRUdTRMNDBxVXIzTEhKcDFHdnVWdTk0bVgzdWF4TllxdnA2?=
 =?utf-8?B?eUlBckY4RWlpTDVXdkJ2STNkL0lCWGhQWUU2em5VdjA2K3A3Z1lQdGU3eWhk?=
 =?utf-8?B?QmN2RlVpL1VWUFR5QkdTOW5KcldwaXI2aStTdktxbGRWMzlCSmhQZVFMajZN?=
 =?utf-8?B?WWhITTQvL3l5VHdQbEhMRzJ2QXp5bWd3VGVacnRvakNHeTBzRklqUU56OHBO?=
 =?utf-8?B?b3ZKYTFkdDR4SWlKNFNoRXZvdnNSS09ET011TGVxZW9FeFZwQ2w2U05yTXVs?=
 =?utf-8?B?djExcExWYVNhaHdXK0ZCVjJPMERRT1lMd2NLYVA5VTkydGZsUVVONmk0WXFF?=
 =?utf-8?B?dnlmWENNTEQ3Y01BUnZLR1J6MFNKZFlIM3FMRFZiV1ErNjJlUkhoeG84cWh1?=
 =?utf-8?B?dThEUlJiR3hqaFlTeXNyYXVuWkpWbGk1d1NGVDBsNVRTaHZ6M1JyZ0FHUFpw?=
 =?utf-8?B?UlZxdjNlR3czbitCaWd6eFg4aDNQcVN4bVlIQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MjF4b2RGc2FNNTZQL3g2ekRYWVFjWUVYK055ZmIrekV5TERDaU9GYVBJaTM1?=
 =?utf-8?B?ekNWanpCNkwzcGt6Wm1CUERkVkpzSDZjNmxXYld4V1ZsVmFJNFIvZndySDMv?=
 =?utf-8?B?Y0pQcEZlUXA4bnB1aTNZazBRUWQybVZiOStaVGFwcGZyZmlHK0oxVE4yN25t?=
 =?utf-8?B?MHg1dElLbyt5V2d6N1RsRHJBMTJVTUdPUFRjY3doSi8vZTlJdlVheXFHRGhs?=
 =?utf-8?B?SjRwZ1RCQ2pVNnJRQnJpeE9LdC84aEZiRXFOSVE2UGJSSHhZQ0xQb21uSzZp?=
 =?utf-8?B?aWUzSGlpTEE0UFBwWHRTNU5yOEV6LytsUi9XSWMwYk5CMENhWlQ1eUVyNlUr?=
 =?utf-8?B?L2tSc3hRa2JPUmVZMFI2cG5sa0Z3dTROQ1orSlcwUWkxMHNBQ1g2UTBDejRh?=
 =?utf-8?B?dHdrK3lwM21PL2dJNitGcUNvTXJmc0N2Mk5GSlpSYUM3cHU2ZEcxTkJJTVE3?=
 =?utf-8?B?ZzZ0cHJCOS9ZMWhxNWt2Wi9QOUcxS1BQZEx4QTEyNjVwZzdtVHY4ajJkMUwx?=
 =?utf-8?B?Zlc3Mm5SdXRMOGRlLytMZE9IUXFXMkNtdVVLbWVLeUhEcjd2cjJSRVB6ZDZ6?=
 =?utf-8?B?R0tZMmF2dU11TXRXNXZHbWVYVE5ud1dwWUprZTRzbFRIN1R2clU4MEpsLzFU?=
 =?utf-8?B?aHdpNjlUSU5ESno2T1V2NVpGZnZvTzU2Znl0UE5aSUxmbGxHMER5WXI0TS8r?=
 =?utf-8?B?ck80VzVkZnh3MnhhanJIUkFBN25KOFZrbE9qaW8yR0liU21zSXlHbGZoVnVQ?=
 =?utf-8?B?OXEwRUpNdUZ6ZFNwS1NkbzRxWTRsR1d4L1o3ZHdocHU4TWs1WWUranhIamt1?=
 =?utf-8?B?dDVoeUU1M0h4d05lUWYrN2RaUFBlVGZ3RlJ5alFwOVorL0lLY1RyN2I2MlJK?=
 =?utf-8?B?UXBvNlRFaUZTNHNsYWR5RmoxNk8wdXlHbHN4NzFJM1llbkY1TUNzd2N1cDRD?=
 =?utf-8?B?NE9yR3RKQng3U0NLRjA5cjd4UUhKRXNKS3ViM2hQZHRsaXA1TmJPSnNGdE9t?=
 =?utf-8?B?QVpSQS93a0NrcnRWNVdPNWNrR3ZYcE1PNU0wV25YaEpXNEZrVktRNlF6VE5Z?=
 =?utf-8?B?UlVvVktBaXFMMlVWNXRtdTJXQlNURzFScDhmTW5CN1lyK011ZHhpZHppa2hF?=
 =?utf-8?B?Q1hIcDV4SlVpWStqU2NuUDA3MXR1QjlUampYYnZSS0FqeUxoVUREaXlHM0wr?=
 =?utf-8?B?RGZHRi8zbU15WjIyN0Jndmg2Yk1vMGpxdWRGb0ZtdDFuUW80bm1ET1ZtSEJs?=
 =?utf-8?B?WUtxamVtdFNtNmNwVGxaZXRZOHJCYWRNc1lBL0xmb2I2MzU3NzNrMkZUVCtq?=
 =?utf-8?B?eFFJd0d0NnVJcWdtUjNMZkcyYnNZNGFxRGlMTm9FVFk5SmdwbXZaTDUzcEJM?=
 =?utf-8?B?RGhkbm9OeXRFVU9kRjVqR3VleXlYUjhRRlJ3b3VaOER3MVIvbzZQUWdIZ3Uw?=
 =?utf-8?B?eit2NDE2allJVDYvNE1ZTnZ0ZlJVcDhqSFRYTDlDSTFrNS9sMFVhUTUwMVVU?=
 =?utf-8?B?STF4NTVPVzJrN0lWOUc0elE2bXRBNG41VDVlQ3J4TXlhZ01DSElzNzZIL1FO?=
 =?utf-8?B?UkcvMWxNRVVpMUhSNHhzK2hxTWJnY1J1MnBxYXFSZlFOUVA1cEFPM050Wlkw?=
 =?utf-8?B?bWtHd3dNMVdxeEUyYVZ6VnFnSGhJVHJyZFVrd1NnRmJQK1JsRzdOVlp3MVVs?=
 =?utf-8?B?eDV1Tzc2RUdLbTNMNHUwVWx6T1dQZVVUZHNYVFMrWE1MNExsdGRvY0F0NHhr?=
 =?utf-8?B?WmRIbnRySWFvekcxT3pNR01iM243dG44akRRNjF5S3pnRXN0Tit6ZlU1dDBI?=
 =?utf-8?B?VmhORHYwc1ZBb1YxZFFNRkQyTVVCaWtWUENsaWRRbDZ5eksxRERWQVVGQ1hO?=
 =?utf-8?B?YTlmSkdJRDFYeGhxS3BXZWFRQkNIVzRyNU1IOHNXYm55Y2t5RGtVbWc4eE8x?=
 =?utf-8?B?SzJaSWVTamVsd0dFaS8xLytOd0llRjRoV1N0OGg2OFBXL1dZQWgxc1RTdnVa?=
 =?utf-8?B?UlUwZlQ4NWdTclU3Z1JNeHNZaVhSREFXVVVSbWZsdE5CcG53Vm9LU1kxWUlZ?=
 =?utf-8?B?R1hoc0lFUWdrWmlDc0lYUkF4R2I1a0FpS1Uydll4blF1VXVJWHRhM1I5dGVw?=
 =?utf-8?B?Z2NYamorRXY1UXlHODdPbXNpK3lya2lEU1UxMjBLc2ZwZjl0cFliRHZPZDIr?=
 =?utf-8?B?ZHc9PQ==?=
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
	KJsr9nJs64jaIqpEzhLQCWxSdQSXuRlVGvye5y2fvBygzdcaptXdwcYgzn08laL5SFpnlfPbieYwPD2ffrrinh3yemVWeXjmiDuDOyD19GDimCaAizJ+53VGs6YNJjoDs6zV0Mlj2RCkSRvQfHxjpXB+/I6ZF/8Le96R1Sfvyqm5rCsfM7uMZMWY/o57gvZMqRO5v4BDNTu6FwN2HU5jzKs7XUUKTCQL8klE1bjANI+0YO/sf2v8zS9I2hRWor+S+82KJPUFnUToq//dq6ichk44TU9kk6Fx5FSym4VS4qGlD2UwwMqThqwrTxlHtSwdpDetOLwJ2G4VQMiDd+WaoL8MwzQnCy/84ZPbS12VK9it3igTBJTSIWoYG/O7KeG/qPLUACp49PEDICSt3eDor8kl3Y7L6++9UcROwqvocTeH5R0U17F18EpPz8rbvC8658RpiGxop65VLDnLx6ollZ1d8HwywwjmtiNk0bMTjykIn91j2EAvvYC9Cwvz1h+lFwlAeq0Fjj8DJg8iPKk47nKxAXfXBXm/ZIw6Q8zfzHVd4OwkiDJT/18iDgb0eSILjkJPzj82/KyeWxGKYa205ISrewv+dISnK6G9D3IK7gNiIEg/QMcnIz1tgNCqzEj9
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50e4aa0-9769-4e35-552d-08de0af3bd8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 07:31:50.6404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G7F0T6/FHddYOWXiifmiMcrrjBQqSZHwx/VlNPLzqmTwsaTWkvWS7WairbEygWTkXXRSJfcODFbMZPsO+gy/+NvleWoIFyclwMZVHcwkCfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11217

SGVsbG8gQmFidSwNCg0KVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5Lg0KSSB3aWxsIHBvc3QgbXkg
cGF0Y2hlcyBvbmNlIHRoZXkgYXJlIHJlYWR5Lg0KVGhhbmsgeW91IGFnYWluIGZvciB5b3VyIGd1
aWRhbmNlLg0KDQpCZXN0IHJlZ2FyZHMsDQpTaGFvcGVuZyBUQU4NCg0KDQo+IFN1YmplY3Q6IFJl
OiBSRTogW1BBVENIIHYzIDAvNF0gc2VsZnRlc3RzL3Jlc2N0cmw6IEVuYWJsZSBNQk0gYW5kIE1C
QSB0ZXN0cw0KPiBvbiBBTUQNCj4gDQo+IEhpIFNoYW9wZW5nLA0KPiANCj4gT24gMTAvOC8yMDI1
IDk6NDUgUE0sIFNoYW9wZW5nIFRhbiAoRnVqaXRzdSkgd3JvdGU6DQo+ID4gSGVsbG8gQmFidSwN
Cj4gPg0KPiA+IEkgdGhpbmsgeW91IGFyZSBzdGlsbCBwbGFubmluZyB0byB1cHN0cmVhbSB0aGlz
IHBhdGNoIHNlcmllcy4NCj4gPiBEbyB5b3UgaGF2ZSBhIHRpbWVsaW5lIGZvciBwb3N0aW5nIHY0
PyBBbmQgd2hlbiBkbyB5b3UgYW50aWNpcGF0ZSBpdCBiZWluZw0KPiBtZXJnZWQ/DQo+ID4NCj4g
PiBJJ2QgbGlrZSB0byBlbmFibGUgTUJNL01CQSB0ZXN0cyBmb3IgQVJNIGFyY2ggKE1QQU0gZHJp
dmVyKSwgSG93ZXZlciwNCj4gPiBJIGZvcmVzZWUgcG90ZW50aWFsIGNvbmZsaWN0cyBpZiB0aGlz
IHBhdGNoIHNlcmllcyBpcyBub3QgbWVyZ2VkLg0KPiA+IEkgYXBvbG9naXplIGZvciB0aGUgaW5j
b252ZW5pZW5jZSwgSSBraW5kbHkgcmVxdWVzdCB5b3VyIGF0dGVudGlvbiB0byB0aGlzDQo+IG1h
dHRlci4NCj4gDQo+IFRoYW5rcyBmb3IgZm9sbG93aW5nIHVwLg0KPiANCj4gU3dhcG5pbCAoQ0Pi
gJlkKSBpcyBjdXJyZW50bHkgd29ya2luZyBvbiByZXZpc2luZyB0aGUgcGF0Y2hlcy4gV2XigJly
ZSBhaW1pbmcgdG8NCj4gcG9zdCB0aGUgdXBkYXRlZCBzZXJpZXMgYnkgdGhlIGZpcnN0IHdlZWsg
b2YgTm92ZW1iZXIuDQo+IFNpbmNlIHRoZXNlIHBhdGNoZXMgd2lsbCBnbyB0aHJvdWdoIG11bHRp
cGxlIHJvdW5kcyBvZiByZXZpZXcgYW55d2F5LCBJ4oCZZA0KPiByZWNvbW1lbmQgcG9zdGluZyB5
b3VycyBpZiB0aGV54oCZcmUgcmVhZHkuDQo+IA0KPiBUaGFua3MNCj4gQmFidQ0K

